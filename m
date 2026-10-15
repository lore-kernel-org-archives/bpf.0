Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB233EC826
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037008; cv=none; b=qpd8o0IVDtOynK5IfB9CzDm3OIy/msJv7Fyn3TlOVJaJsn43JTsjhxClfm1tmTGiR8fupQjsvaC/z2Lzc6jQndSY0eeSoaLZSGkgJ3dgWmwuJqkdYOX1iDknvmXp+QPyF7U85LFk3stGT9Dlr+Mh7KZz+KaWvvEfm068niNyLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037008; c=relaxed/simple;
	bh=0VcrsWkPrEP8Z3rRherSMkl8hhf9y0oiDYjQAX4k0cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0sXDQpI2byCA3qCz4U1KAP/bfBfbY/Lr/bHLUYO/dLMNKA3vaDkquxnycz+FMKEIE+Mqg+ywOvq2OlRPWX1ssIul32/cY8HqI1SNrw/c7cbQF7CZ96iF0wXTqbQQ9p7YsDR1tnf40g2wVCEIkrj3q5v7PQF4gIOS+pJeSohKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 217F8314995848; Wed, 14 Oct 2026 21:03:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 20/26] libbpf: Collect .bpf_cleanup records and pass them to the kernel
Date: Wed, 14 Oct 2026 21:03:26 -0700
Message-ID: <20261015040326.865061-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Parse the compiler-emitted .bpf_cleanup section and hand the table to
BPF_PROG_LOAD:

 - At open, each record field, a byte offset into a code section, is
   resolved through its .rel.bpf_cleanup relocation: R_BPF_64_NODYLD32
   from LLVM or R_BPF_64_ABS32 from GNU as.
 - At relocation, once a main program's subprogs are appended, the
   records in the main program and in those subprogs get final
   instruction indices and are sorted by begin_off, as the kernel wants.
   A record in code no function claims belongs to a weak function the
   static linker kept after overriding it, and is skipped, as that
   code's relocations are.
 - At load, the table goes through the bpf_prog_load() options, from
   bpf_object_load_prog() and from bpf_program__clone(), the path
   veristat uses.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c          | 287 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |   3 +
 2 files changed, 288 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b3cfd7c58776..d227dcc7ef0b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -516,6 +516,11 @@ struct bpf_program {
 	void *line_info;
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
+
+	struct bpf_cleanup_info *cleanup_info;
+	__u32 cleanup_info_rec_size;
+	__u32 cleanup_info_cnt;
+
 	__u32 prog_flags;
 	__u8  hash[SHA256_DIGEST_LENGTH];
=20
@@ -572,6 +577,7 @@ struct bpf_struct_ops {
  * are loaded with BPF_F_ARENA_SCALAR.
  */
 #define ARENA_DATA_SEC ".arena.data"
+#define CLEANUP_SEC ".bpf_cleanup"
=20
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -710,6 +716,25 @@ struct elf_sec_desc {
 	Elf_Data *data;
 };
=20
+#define CLEANUP_REC_FIELDS	(sizeof(struct bpf_cleanup_info) / sizeof(__u=
32))
+
+/* Index of each field of struct bpf_cleanup_info, read as an array of _=
_u32. */
+enum {
+	CLEANUP_REC_BEGIN,
+	CLEANUP_REC_END,
+	CLEANUP_REC_PAD,
+};
+
+/*
+ * One (begin, end, landing_pad) triple from .bpf_cleanup, each field re=
solved
+ * from its relocation to a section and an instruction index within it. =
Final
+ * indices wait for subprogram placement, which differs per main program=
.
+ */
+struct cleanup_raw_rec {
+	int sec_idx[CLEANUP_REC_FIELDS];
+	size_t insn_idx[CLEANUP_REC_FIELDS];
+};
+
 struct elf_state {
 	int fd;
 	const void *obj_buf;
@@ -729,6 +754,8 @@ struct elf_state {
 	bool has_st_ops;
 	int arena_data_shndx;
 	int jumptables_data_shndx;
+	Elf_Data *cleanup_data;
+	int cleanup_shndx;
 };
=20
 struct usdt_manager;
@@ -817,6 +844,9 @@ struct bpf_object {
 	void *jumptables_data;
 	size_t jumptables_data_sz;
=20
+	struct cleanup_raw_rec *cleanup_recs;
+	size_t cleanup_rec_cnt;
+
 	struct {
 		struct bpf_program *prog;
 		unsigned int sym_off;
@@ -874,6 +904,7 @@ void bpf_program__unload(struct bpf_program *prog)
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
 	zfree(&prog->subprogs);
+	zfree(&prog->cleanup_info);
 }
=20
 static void bpf_program__exit(struct bpf_program *prog)
@@ -1639,6 +1670,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
 	obj->efile.obj_buf_sz =3D obj_buf_sz;
 	obj->efile.btf_maps_shndx =3D -1;
 	obj->efile.arena_data_shndx =3D -1;
+	obj->efile.cleanup_shndx =3D -1;
 	obj->kconfig_map_idx =3D -1;
 	obj->arena_map_idx =3D -1;
=20
@@ -1658,6 +1690,7 @@ static void bpf_object__elf_finish(struct bpf_objec=
t *obj)
 	obj->efile.ehdr =3D NULL;
 	obj->efile.symbols =3D NULL;
 	obj->efile.arena_data =3D NULL;
+	obj->efile.cleanup_data =3D NULL;
=20
 	zfree(&obj->efile.secs);
 	obj->efile.sec_cnt =3D 0;
@@ -4275,6 +4308,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 				sec_desc->shdr =3D sh;
 				sec_desc->data =3D data;
 				obj->efile.has_st_ops =3D true;
+			} else if (strcmp(name, CLEANUP_SEC) =3D=3D 0) {
+				obj->efile.cleanup_data =3D data;
+				obj->efile.cleanup_shndx =3D idx;
 			} else if (strcmp(name, ARENA_SEC) =3D=3D 0) {
 				obj->efile.arena_data =3D data;
 				obj->efile.arena_data_shndx =3D idx;
@@ -4300,8 +4336,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
=20
 			/*
 			 * Only do relo for section with exec instructions,
-			 * struct_ops, maps, and read-only data that might
-			 * have pointers to functions.
+			 * struct_ops, maps, read-only data that might have
+			 * pointers to functions, and the exception cleanup
+			 * table.
 			 */
 			if (!section_have_execinstr(obj, targ_sec_idx) &&
 			    !(obj->data_in_arena &&
@@ -4315,6 +4352,7 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_LINK_SEC) &&
+			    strcmp(name, ".rel" CLEANUP_SEC) &&
 			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
@@ -5099,6 +5137,219 @@ static struct bpf_program *find_prog_by_sec_insn(=
const struct bpf_object *obj,
 	return NULL;
 }
=20
+static int bpf_object_init_cleanup_info(struct bpf_object *obj)
+{
+	Elf_Data *data =3D obj->efile.cleanup_data;
+	size_t i, nrels, nslots, nrecs;
+	struct cleanup_raw_rec *recs;
+	Elf_Data *relo =3D NULL;
+	const char *vals;
+	int ret =3D 0;
+	bool native;
+
+	if (!data || obj->efile.cleanup_shndx < 0 || !data->d_size)
+		return 0;
+
+	native =3D is_native_endianness(obj);
+
+	for (i =3D 0; i < obj->efile.sec_cnt; i++) {
+		struct elf_sec_desc *sd =3D &obj->efile.secs[i];
+
+		if (sd->sec_type =3D=3D SEC_RELO && sd->shdr &&
+		    sd->shdr->sh_info =3D=3D (Elf64_Word)obj->efile.cleanup_shndx) {
+			relo =3D sd->data;
+			break;
+		}
+	}
+	if (!relo) {
+		pr_warn("%s present without relocations\n", CLEANUP_SEC);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+	if (data->d_size % sizeof(struct bpf_cleanup_info)) {
+		pr_warn("%s size %zu is not a multiple of the record size %zu\n",
+			CLEANUP_SEC, data->d_size, sizeof(struct bpf_cleanup_info));
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+
+	vals =3D data->d_buf;
+	nslots =3D data->d_size / sizeof(__u32);
+	nrecs =3D data->d_size / sizeof(struct bpf_cleanup_info);
+
+	recs =3D calloc(nrecs, sizeof(*recs));
+	if (!recs)
+		return -ENOMEM;
+	for (i =3D 0; i < nslots; i++)
+		recs[i / CLEANUP_REC_FIELDS].sec_idx[i % CLEANUP_REC_FIELDS] =3D -1;
+
+	/* One relocation per 4-byte field, naming the section it points into. =
*/
+	nrels =3D relo->d_size / sizeof(Elf64_Rel);
+	for (i =3D 0; i < nrels; i++) {
+		Elf64_Rel *rel =3D elf_rel_by_idx(relo, i);
+		Elf64_Sym *sym =3D elf_sym_by_idx(obj, ELF64_R_SYM(rel->r_info));
+		size_t type =3D ELF64_R_TYPE(rel->r_info);
+		size_t slot =3D rel->r_offset / sizeof(__u32);
+		struct cleanup_raw_rec *rec;
+		size_t off;
+		__u32 val;
+
+		if (type !=3D R_BPF_64_NODYLD32 && type !=3D R_BPF_64_ABS32) {
+			pr_warn("%s: relocation %zu has unexpected type %zu\n",
+				CLEANUP_SEC, i, type);
+			ret =3D -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+		if (!sym || slot >=3D nslots || rel->r_offset % sizeof(__u32)) {
+			pr_warn("%s: bad relocation %zu\n", CLEANUP_SEC, i);
+			ret =3D -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+		/*
+		 * The addend lives in the section data, which libelf leaves in
+		 * the object's byte order; a non-section symbol additionally
+		 * contributes its own value. The section is only byte aligned.
+		 */
+		memcpy(&val, vals + slot * sizeof(val), sizeof(val));
+		off =3D (native ? val : bswap_32(val)) + sym->st_value;
+		if (off % BPF_INSN_SZ) {
+			pr_warn("%s: field %zu offset %zu is not instruction aligned\n",
+				CLEANUP_SEC, slot, off);
+			ret =3D -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+		rec =3D &recs[slot / CLEANUP_REC_FIELDS];
+		if (rec->sec_idx[slot % CLEANUP_REC_FIELDS] >=3D 0) {
+			pr_warn("%s: field %zu has more than one relocation\n",
+				CLEANUP_SEC, slot);
+			ret =3D -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+		rec->sec_idx[slot % CLEANUP_REC_FIELDS] =3D sym->st_shndx;
+		rec->insn_idx[slot % CLEANUP_REC_FIELDS] =3D off / BPF_INSN_SZ;
+	}
+
+	for (i =3D 0; i < nslots; i++) {
+		if (recs[i / CLEANUP_REC_FIELDS].sec_idx[i % CLEANUP_REC_FIELDS] < 0) =
{
+			pr_warn("%s: field %zu has no relocation\n", CLEANUP_SEC, i);
+			ret =3D -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+	}
+
+	obj->cleanup_recs =3D recs;
+	obj->cleanup_rec_cnt =3D nrecs;
+	return 0;
+out:
+	free(recs);
+	return ret;
+}
+
+static int cmp_cleanup_info(const void *a, const void *b)
+{
+	const struct bpf_cleanup_info *x =3D a, *y =3D b;
+
+	if (x->begin_off =3D=3D y->begin_off)
+		return 0;
+	return x->begin_off < y->begin_off ? -1 : 1;
+}
+
+static int bpf_prog_collect_cleanup_info(struct bpf_object *obj,
+					 struct bpf_program *prog)
+{
+	size_t i;
+	int j;
+
+	for (i =3D 0; i < obj->cleanup_rec_cnt; i++) {
+		struct cleanup_raw_rec *raw =3D &obj->cleanup_recs[i];
+		struct bpf_program *owner =3D NULL;
+		struct bpf_cleanup_info ci =3D {};
+		__u32 fields[CLEANUP_REC_FIELDS];
+		void *tmp;
+
+		for (j =3D 0; j < CLEANUP_REC_FIELDS; j++) {
+			size_t idx =3D raw->insn_idx[j], final;
+			struct bpf_program *p;
+
+			/*
+			 * An exclusive end may name the instruction past the
+			 * last of a function, so ask about the last one the
+			 * range covers, the way the kernel does.
+			 */
+			if (j =3D=3D CLEANUP_REC_END) {
+				if (!idx) {
+					pr_warn("%s: record %zu ends at instruction 0\n",
+						CLEANUP_SEC, i);
+					return -LIBBPF_ERRNO__FORMAT;
+				}
+				idx--;
+			}
+
+			p =3D find_prog_by_sec_insn(obj, raw->sec_idx[j], idx);
+			if (!p && j =3D=3D CLEANUP_REC_BEGIN) {
+				/*
+				 * Code no function claims is an overridden weak
+				 * function the linker kept: skip its records,
+				 * as its relocations are.
+				 */
+				pr_debug("%s: record %zu is in no function, probably an overridden w=
eak function, skipping\n",
+					 CLEANUP_SEC, i);
+				break;
+			}
+			if (!p) {
+				pr_warn("%s: record %zu field %d is not inside a function\n",
+					CLEANUP_SEC, i, j);
+				return -LIBBPF_ERRNO__FORMAT;
+			}
+			if (!owner) {
+				owner =3D p;
+			} else if (owner !=3D p) {
+				pr_warn("%s: record %zu spans functions '%s' and '%s'\n",
+					CLEANUP_SEC, i, owner->name, p->name);
+				return -LIBBPF_ERRNO__FORMAT;
+			}
+
+			if (owner =3D=3D prog) {
+				final =3D raw->insn_idx[j] - prog->sec_insn_off;
+			} else if (prog_is_subprog(obj, owner) && owner->sub_insn_off) {
+				/*
+				 * sub_insn_off is where this subprogram was
+				 * appended to the main program being relocated;
+				 * zero means it is not part of it.
+				 */
+				final =3D owner->sub_insn_off +
+					raw->insn_idx[j] - owner->sec_insn_off;
+			} else {
+				owner =3D NULL;
+				break;
+			}
+			fields[j] =3D final;
+		}
+		if (!owner)
+			continue;
+
+		ci.begin_off =3D fields[CLEANUP_REC_BEGIN];
+		ci.end_off =3D fields[CLEANUP_REC_END];
+		ci.landing_pad_off =3D fields[CLEANUP_REC_PAD];
+
+		tmp =3D libbpf_reallocarray(prog->cleanup_info, prog->cleanup_info_cnt=
 + 1,
+					  sizeof(*prog->cleanup_info));
+		if (!tmp)
+			return -ENOMEM;
+		prog->cleanup_info =3D tmp;
+		prog->cleanup_info_rec_size =3D sizeof(struct bpf_cleanup_info);
+		prog->cleanup_info[prog->cleanup_info_cnt++] =3D ci;
+
+		pr_debug("prog '%s': cleanup region [%u,%u) -> landing pad %u\n",
+			 prog->name, ci.begin_off, ci.end_off, ci.landing_pad_off);
+	}
+
+	if (!prog->cleanup_info_cnt)
+		return 0;
+
+	qsort(prog->cleanup_info, prog->cleanup_info_cnt,
+	      sizeof(*prog->cleanup_info), cmp_cleanup_info);
+	return 0;
+}
+
 static int
 bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr,=
 Elf_Data *data)
 {
@@ -8197,6 +8448,13 @@ static int bpf_object__relocate(struct bpf_object =
*obj, const char *targ_btf_pat
 					return err;
 			}
 		}
+
+		err =3D bpf_prog_collect_cleanup_info(obj, prog);
+		if (err) {
+			pr_warn("prog '%s': failed to collect cleanup info: %s\n",
+				prog->name, errstr(err));
+			return err;
+		}
 	}
 	for (i =3D 0; i < obj->nr_programs; i++) {
 		prog =3D &obj->programs[i];
@@ -8561,6 +8819,9 @@ static int bpf_object__collect_relos(struct bpf_obj=
ect *obj)
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
=20
+		if (idx =3D=3D obj->efile.cleanup_shndx)
+			continue;
+
 		if (obj->efile.secs[idx].sec_type =3D=3D SEC_RODATA)
 			err =3D bpf_object__collect_rodata_relos(obj, shdr, data);
 		else if (obj->efile.secs[idx].sec_type =3D=3D SEC_DATA)
@@ -8856,6 +9117,11 @@ static int bpf_object_load_prog(struct bpf_object =
*obj, struct bpf_program *prog
 		load_attr.line_info_rec_size =3D prog->line_info_rec_size;
 		load_attr.line_info_cnt =3D prog->line_info_cnt;
 	}
+	if (prog->cleanup_info_cnt) {
+		load_attr.cleanup_info =3D prog->cleanup_info;
+		load_attr.cleanup_info_cnt =3D prog->cleanup_info_cnt;
+		load_attr.cleanup_info_rec_size =3D prog->cleanup_info_rec_size;
+	}
 	load_attr.log_level =3D log_level;
 	load_attr.prog_flags =3D prog->prog_flags;
 	/* the program accesses its data in arena through plain numbers */
@@ -9460,6 +9726,7 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
 	err =3D err ? : bpf_object__init_maps(obj, opts);
 	err =3D err ? : bpf_object_init_progs(obj, opts);
 	err =3D err ? : bpf_object__collect_relos(obj);
+	err =3D err ? : bpf_object_init_cleanup_info(obj);
 	if (err)
 		goto out;
=20
@@ -10602,6 +10869,9 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->jumptables_data);
 	obj->jumptables_data_sz =3D 0;
=20
+	zfree(&obj->cleanup_recs);
+	obj->cleanup_rec_cnt =3D 0;
+
 	for (i =3D 0; i < obj->jumptable_map_cnt; i++)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
@@ -11011,6 +11281,19 @@ int bpf_program__clone(struct bpf_program *prog,=
 const struct bpf_prog_load_opts
 		attr.line_info_rec_size =3D info ? info_rec_size : prog->line_info_rec=
_size;
 	}
=20
+	/* exception cleanup table */
+	info =3D OPTS_GET(opts, cleanup_info, NULL);
+	info_cnt =3D OPTS_GET(opts, cleanup_info_cnt, 0);
+	info_rec_size =3D OPTS_GET(opts, cleanup_info_rec_size, 0);
+	if (!!info !=3D !!info_cnt || !!info !=3D !!info_rec_size) {
+		pr_warn("prog '%s': cleanup_info, cleanup_info_cnt, and cleanup_info_r=
ec_size must all be specified or all omitted\n",
+			prog->name);
+		return libbpf_err(-EINVAL);
+	}
+	attr.cleanup_info =3D info ?: prog->cleanup_info;
+	attr.cleanup_info_cnt =3D info ? info_cnt : prog->cleanup_info_cnt;
+	attr.cleanup_info_rec_size =3D info ? info_rec_size : prog->cleanup_inf=
o_rec_size;
+
 	/* Logging is caller-controlled; no fallback to prog/obj log settings *=
/
 	attr.log_buf =3D OPTS_GET(opts, log_buf, NULL);
 	attr.log_size =3D OPTS_GET(opts, log_size, 0);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 4e45dfacb548..ecbdb0d7dee1 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -56,6 +56,9 @@
 #ifndef R_BPF_64_ABS32
 #define R_BPF_64_ABS32 3
 #endif
+#ifndef R_BPF_64_NODYLD32
+#define R_BPF_64_NODYLD32 4
+#endif
 #ifndef R_BPF_64_32
 #define R_BPF_64_32 10
 #endif
--=20
2.53.0-Meta

