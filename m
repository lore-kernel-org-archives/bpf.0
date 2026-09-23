Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889DC260580
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139619; cv=none; b=UxBPwMR8QRnr+rC8Xf2c3/3ly5ncQl2YIYJ1gkyT0CzHkYPch3+PdNOAQfD2qyiSQktpyzkuHiGpwTN71iETR42eC00rxd8boRGSTYH44ocXfROV4jUN2sDKHarnt0+Mg3LVJ4toS/33E3JD1vqThZ6dF/aYJGjtD1SjNBWVV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139619; c=relaxed/simple;
	bh=xDTpe01wxZ+k+QnpgKqxTqmXCv3RLsRIQLYrg7Mgocg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCRboXmuVyGKWrryqts0fgik7w5auQfBow1o+K6Y1/d7XQYF5FOHe9KwP2OMWnyTb74i02eRylFQM5L4SnsfbgoglywkLOxBb014SAm4od4vVvymElkaw8GRITYS5fMfcDiodS2ekOfaru5pYXtmPK9h1+Fq+ulkYhH7tkIGG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B8BA22C8DADBCF; Tue, 22 Sep 2026 22:00:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 17/21] libbpf: Carry the exception cleanup table through the light skeleton
Date: Tue, 22 Sep 2026 22:00:13 -0700
Message-ID: <20260923050013.2426430-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A light skeleton does not call bpf_prog_load(). bpf_gen__prog_load() buil=
ds
its own union bpf_attr field by field, and the loader program it emits is
what issues BPF_PROG_LOAD when the skeleton runs -- so a program loaded
this way reached the kernel without the table the previous patch collecte=
d
for it. The load then fails, because the landing pads are code nothing
reaches and the verifier says so. It says "unreachable insn", which names
neither the skeleton nor the table.

Carry it the way func_info and line_info are carried: the records go into
the loader's blob of bytes, the count and record size into the attr, and =
a
relocation stores the blob's address into attr.cleanup_info once that
address is known. The attr grows to its new last field, cleanup_info_cnt.
Records are 4-byte fields like the other info blobs, so a cross-endian
build has to swap them too.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/gen_loader.c      | 29 +++++++++++++++++++++++++----
 tools/lib/bpf/libbpf_internal.h |  7 +++++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index af3a04f161ac..2345fbdd46f5 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -981,13 +981,15 @@ static void cleanup_relos(struct bpf_gen *gen, int =
insns)
 	cleanup_core_relo(gen);
 }
=20
-/* Convert func, line, and core relo info blobs to target endianness */
+/* Convert func, line, core relo and cleanup info blobs to target endian=
ness */
 static void info_blob_bswap(struct bpf_gen *gen, int func_info, int line=
_info,
-			    int core_relos, struct bpf_prog_load_opts *load_attr)
+			    int core_relos, int cleanup_info,
+			    struct bpf_prog_load_opts *load_attr)
 {
 	struct bpf_func_info *fi =3D gen->data_start + func_info;
 	struct bpf_line_info *li =3D gen->data_start + line_info;
 	struct bpf_core_relo *cr =3D gen->data_start + core_relos;
+	struct bpf_cleanup_info *ci =3D gen->data_start + cleanup_info;
 	int i;
=20
 	for (i =3D 0; i < load_attr->func_info_cnt; i++)
@@ -998,6 +1000,9 @@ static void info_blob_bswap(struct bpf_gen *gen, int=
 func_info, int line_info,
=20
 	for (i =3D 0; i < gen->core_relo_cnt; i++)
 		bpf_core_relo_bswap(cr++);
+
+	for (i =3D 0; i < load_attr->cleanup_info_cnt; i++)
+		bpf_cleanup_info_bswap(ci++);
 }
=20
 void bpf_gen__prog_load(struct bpf_gen *gen,
@@ -1011,8 +1016,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 			       load_attr->line_info_rec_size;
 	int core_relo_tot_sz =3D gen->core_relo_cnt *
 			       sizeof(struct bpf_core_relo);
+	int cleanup_info_tot_sz =3D load_attr->cleanup_info_cnt *
+				  load_attr->cleanup_info_rec_size;
 	int prog_load_attr, license_off, insns_off, func_info, line_info, core_=
relos;
-	int attr_size =3D offsetofend(union bpf_attr, core_relo_rec_size);
+	int attr_size =3D offsetofend(union bpf_attr, cleanup_info_cnt);
+	int cleanup_info;
 	union bpf_attr attr;
=20
 	memset(&attr, 0, attr_size);
@@ -1061,9 +1069,17 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		 core_relos, gen->core_relo_cnt,
 		 sizeof(struct bpf_core_relo));
=20
+	attr.cleanup_info_rec_size =3D tgt_endian(load_attr->cleanup_info_rec_s=
ize);
+	attr.cleanup_info_cnt =3D tgt_endian(load_attr->cleanup_info_cnt);
+	cleanup_info =3D add_data(gen, load_attr->cleanup_info, cleanup_info_to=
t_sz);
+	pr_debug("gen: prog_load: cleanup_info: off %d cnt %u rec size %u\n",
+		 cleanup_info, load_attr->cleanup_info_cnt,
+		 load_attr->cleanup_info_rec_size);
+
 	/* convert all info blobs to target endianness */
 	if (gen->swapped_endian && !gen->error)
-		info_blob_bswap(gen, func_info, line_info, core_relos, load_attr);
+		info_blob_bswap(gen, func_info, line_info, core_relos, cleanup_info,
+				load_attr);
=20
 	libbpf_strlcpy(attr.prog_name, prog_name, sizeof(attr.prog_name));
 	prog_load_attr =3D add_data(gen, &attr, attr_size);
@@ -1085,6 +1101,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	/* populate union bpf_attr with a pointer to core_relos */
 	emit_rel_store(gen, attr_field(prog_load_attr, core_relos), core_relos)=
;
=20
+	/* populate union bpf_attr with a pointer to cleanup_info, if there is =
one */
+	if (load_attr->cleanup_info_cnt)
+		emit_rel_store(gen, attr_field(prog_load_attr, cleanup_info),
+			       cleanup_info);
+
 	/* populate union bpf_attr fd_array with a pointer to data where map_fd=
s are saved */
 	emit_rel_store(gen, attr_field(prog_load_attr, fd_array), gen->fd_array=
);
=20
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 3ba6d9090368..78519f24fb40 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -572,6 +572,13 @@ static inline void bpf_core_relo_bswap(struct bpf_co=
re_relo *i)
 	i->kind =3D bswap_32(i->kind);
 }
=20
+static inline void bpf_cleanup_info_bswap(struct bpf_cleanup_info *i)
+{
+	i->begin_off =3D bswap_32(i->begin_off);
+	i->end_off =3D bswap_32(i->end_off);
+	i->landing_pad_off =3D bswap_32(i->landing_pad_off);
+}
+
 enum btf_field_iter_kind {
 	BTF_FIELD_ITER_IDS,
 	BTF_FIELD_ITER_STRS,
--=20
2.53.0-Meta

