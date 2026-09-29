Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B762F7F13
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641057; cv=none; b=UJVX+shWDQOOa8dnzgsGMwQaN+6w0LXsfZL7QuXrLhCU144ItsZI3rxj/8tTZEr5Snym0H8dJjnO9esDwiWCLm7mnpvMe0wRJf306hrOTpE9tpfgDRywd0BBPp1crgnBMIeyS12QXrUsae/8JNaQwfKy7tVddTcYpDkUB+KOjs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641057; c=relaxed/simple;
	bh=ugO5Ys4nM3MA8/F0ETaRfBXfIUfwsQITnT4J0GFGdsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOKM66k19JPFZDbQbl2US4EkEpqMtnQnWySPm6EtoDUznyUR7cksOstWf/nF4qA7z7IbbRGhCvjzmq/hxTf3eyME0NGGLX8VqF6+EldoLobQiK5F92WjL8JGvg5DyuYO3V7c/+XwKW443Ir7WVOTu++OS0I1y02oUMQEWddaHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8833C2DE076256; Mon, 28 Sep 2026 17:17:31 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 17/22] libbpf: Carry the exception cleanup table through the light skeleton
Date: Mon, 28 Sep 2026 17:17:31 -0700
Message-ID: <20260929001731.3255091-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929001601.3242665-1-yonghong.song@linux.dev>
References: <20260929001601.3242665-1-yonghong.song@linux.dev>
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
for it, and the verifier refused it with "unreachable insn", which names
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
index 251392aa8b41..d10cd0672475 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -994,13 +994,15 @@ static void cleanup_relos(struct bpf_gen *gen, int =
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
@@ -1011,6 +1013,9 @@ static void info_blob_bswap(struct bpf_gen *gen, in=
t func_info, int line_info,
=20
 	for (i =3D 0; i < gen->core_relo_cnt; i++)
 		bpf_core_relo_bswap(cr++);
+
+	for (i =3D 0; i < load_attr->cleanup_info_cnt; i++)
+		bpf_cleanup_info_bswap(ci++);
 }
=20
 void bpf_gen__prog_load(struct bpf_gen *gen,
@@ -1024,8 +1029,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
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
@@ -1074,9 +1082,17 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
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
@@ -1098,6 +1114,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	/* populate union bpf_attr with a pointer to core_relos */
 	emit_rel_store(gen, attr_field(prog_load_attr, core_relos), core_relos)=
;
=20
+	/* with no records there is no blob of them to point the attr at */
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
index f1630f03d5f5..9d341839ca74 100644
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

