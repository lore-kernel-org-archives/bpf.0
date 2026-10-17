Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AB3AFD05
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205614; cv=none; b=DoetnSMmNmlTt6zL6ECzCO+l9LU6apFgGW8NNv8/fD+FrOUjMGtIBa02TyFSjcezTD+ksVZ9u7TLqGYXVey4to2ievKPSktPfNWNLXHcKM6FyopDOEYdy7NBIBHA4JtWJcthedVrc+H24/zyCxsSWFj1252UgWjwdSzRn1zj2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205614; c=relaxed/simple;
	bh=5vUC9sO//7b31RH+jEFPRZv8KfspnfDYhMv/Ym/+t2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p40bwsHuBj59WNmj5hL4xEoPxLyyho2pjmTUo1mWkNK06VnBl/V8PiJjJJGiJK2u/NEhT7oIFSktYG1rinrLkBAHj5WO/VB/EFOxzZf88Jp8ZGNTdDBTbYwSWl0Trrgj+b8PSV4bKY1vwSg7ZZ6+secXGTWwpsxROxNFa5X6kJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B50DC31B3B014A; Fri, 16 Oct 2026 19:53:13 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 20/25] libbpf: Carry the exception cleanup table through the light skeleton
Date: Fri, 16 Oct 2026 19:53:13 -0700
Message-ID: <20261017025313.1930647-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A light skeleton does not call bpf_prog_load(): its loader program
builds the attr itself, so a program loaded this way reached the kernel
without its table and was refused with "unreachable insn". Carry the
table the way func_info and line_info are carried: the records in the
loader's blob, the count and record size in the attr, and a relocation
for the blob's address.

Only a program with records grows the attr to cleanup_info_cnt, so light
skeletons without them are unchanged.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/gen_loader.c      | 29 ++++++++++++++++++++++++++---
 tools/lib/bpf/libbpf_internal.h |  7 +++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 251392aa8b41..f07727c5b5fb 100644
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
@@ -1024,10 +1029,15 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 			       load_attr->line_info_rec_size;
 	int core_relo_tot_sz =3D gen->core_relo_cnt *
 			       sizeof(struct bpf_core_relo);
+	int cleanup_info_tot_sz =3D load_attr->cleanup_info_cnt *
+				  load_attr->cleanup_info_rec_size;
 	int prog_load_attr, license_off, insns_off, func_info, line_info, core_=
relos;
 	int attr_size =3D offsetofend(union bpf_attr, core_relo_rec_size);
+	int cleanup_info;
 	union bpf_attr attr;
=20
+	if (load_attr->cleanup_info_cnt)
+		attr_size =3D offsetofend(union bpf_attr, cleanup_info_cnt);
 	memset(&attr, 0, attr_size);
 	/* add license string to blob of bytes */
 	license_off =3D add_data(gen, license, strlen(license) + 1);
@@ -1074,9 +1084,17 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
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
@@ -1098,6 +1116,11 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 	/* populate union bpf_attr with a pointer to core_relos */
 	emit_rel_store(gen, attr_field(prog_load_attr, core_relos), core_relos)=
;
=20
+	/* with no records, attr ends before cleanup_info: nothing to store */
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
index ecbdb0d7dee1..e17fc8f60199 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -573,6 +573,13 @@ static inline void bpf_core_relo_bswap(struct bpf_co=
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

