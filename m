Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5BA2ED154
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790641060; cv=none; b=iyY/9VXoNYxzIk9IF/tJJeVtRHpk9Ij09cJJD2wTOM6UsZ/0npOrV5RtUDC/8V5Zr3b77o/JAjPGGEGZJQ9OX7n3ZlzWpyTIwBwhbY5HpnB1ugoQNvvwSFUIBQgB1UbfSxGXLw2I4AejZODwPuMw7JKiDbND71I0/lcwV0O3bgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790641060; c=relaxed/simple;
	bh=DD27qyXbSZFvO9ACkPbYVg3PK3qqojDhJBHtbKmU48Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFZn4XQwLoYytZ9gQh3/S3m4VZ2hCE1Lafi/ztIgwnEnGlwpz4Bo+bZdz5l6crrJoI6t3obDJ/EIOkHBxfnjsVVx3wRN5IDf7RWpT7xYgISOJ1oSN5rVJ2AsEu3QX9nhQ9yUALtGkCMUH5CJ3pGpPTkJr64KBCSn7uY15xKRlN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6A44A2DE076237; Mon, 28 Sep 2026 17:17:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 16/22] libbpf: Collect .bpf_cleanup records and pass them to the kernel
Date: Mon, 28 Sep 2026 17:17:26 -0700
Message-ID: <20260929001726.3254850-1-yonghong.song@linux.dev>
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

Parse the compiler-emitted .bpf_cleanup section and hand the resulting
table to BPF_PROG_LOAD.

Each record is three 4-byte fields, and each field is a byte offset into
some code section named by a matching .rel.bpf_cleanup relocation.
bpf_object__init_cleanup_info() resolves both halves once at open time an=
d
keeps (section, instruction index) pairs; it rejects a record whose field
has no relocation, whose relocation is not one of the two 32-bit types th=
at
spell a data reference to a code section -- R_BPF_64_NODYLD32 from LLVM,
R_BPF_64_ABS32 from GNU as -- or whose offset is not instruction aligned.
LLVM leaves the section's sh_entsize unset, which is taken to mean the si=
ze
assumed here, so a section declaring any other is refused.

The records are sorted by begin_off once the offsets are final, since the
kernel wants the table sorted with disjoint ranges to find the record
covering a call site with a binary search, and they arrive in .bpf_cleanu=
p
order, which says nothing about where the subprograms they describe were
appended. Overlapping ranges are reported here, where the program name an=
d
both regions are still at hand.

bpf_object_load_prog() then passes the per-program table through the
bpf_prog_load() options added in the previous patch, with the record size
carried on the program the way func_info and line_info carry theirs.
bpf_program__clone() carries it too -- that is the load path veristat use=
s,
and without the table the kernel sees landing pads nothing reaches and
refuses the program with "unreachable insn".

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c          | 310 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |   3 +
 2 files changed, 313 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7eb15a013a83..872601183112 100644
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
@@ -552,6 +557,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define CLEANUP_SEC ".bpf_cleanup"
=20
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -683,6 +689,25 @@ struct elf_sec_desc {
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
@@ -702,6 +727,8 @@ struct elf_state {
 	bool has_st_ops;
 	int arena_data_shndx;
 	int jumptables_data_shndx;
+	Elf_Data *cleanup_data;
+	int cleanup_shndx;
 };
=20
 struct usdt_manager;
@@ -779,6 +806,9 @@ struct bpf_object {
 	void *jumptables_data;
 	size_t jumptables_data_sz;
=20
+	struct cleanup_raw_rec *cleanup_recs;
+	size_t cleanup_rec_cnt;
+
 	struct {
 		struct bpf_program *prog;
 		unsigned int sym_off;
@@ -848,7 +878,10 @@ static void bpf_program__exit(struct bpf_program *pr=
og)
 	zfree(&prog->sec_name);
 	zfree(&prog->insns);
 	zfree(&prog->reloc_desc);
+	zfree(&prog->cleanup_info);
=20
+	prog->cleanup_info_rec_size =3D 0;
+	prog->cleanup_info_cnt =3D 0;
 	prog->nr_reloc =3D 0;
 	prog->insns_cnt =3D 0;
 	prog->sec_idx =3D -1;
@@ -1600,6 +1633,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
 	obj->efile.obj_buf =3D obj_buf;
 	obj->efile.obj_buf_sz =3D obj_buf_sz;
 	obj->efile.btf_maps_shndx =3D -1;
+	obj->efile.cleanup_shndx =3D -1;
 	obj->kconfig_map_idx =3D -1;
 	obj->arena_map_idx =3D -1;
=20
@@ -4100,6 +4134,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
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
@@ -4135,6 +4172,7 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_LINK_SEC) &&
+			    strcmp(name, ".rel" CLEANUP_SEC) &&
 			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
@@ -4915,6 +4953,240 @@ static struct bpf_program *find_prog_by_sec_insn(=
const struct bpf_object *obj,
 	return NULL;
 }
=20
+static int bpf_object__init_cleanup_info(struct bpf_object *obj)
+{
+	Elf_Data *data =3D obj->efile.cleanup_data;
+	size_t i, nrels, nslots, nrecs;
+	struct cleanup_raw_rec *recs;
+	Elf_Data *relo =3D NULL;
+	const __u32 *vals;
+	Elf64_Shdr *sh;
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
+	/*
+	 * LLVM leaves sh_entsize unset, which is read as the size assumed
+	 * here, so this bites only a producer that declares a record size --
+	 * which is the one able to say it means something other than three
+	 * 4-byte fields.
+	 */
+	sh =3D elf_sec_hdr(obj, elf_sec_by_idx(obj, obj->efile.cleanup_shndx));
+	if (sh && sh->sh_entsize && sh->sh_entsize !=3D sizeof(struct bpf_clean=
up_info)) {
+		pr_warn("%s record size %llu is not the expected %zu\n", CLEANUP_SEC,
+			(unsigned long long)sh->sh_entsize, sizeof(struct bpf_cleanup_info));
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
+		 * contributes its own value.
+		 */
+		off =3D (native ? vals[slot] : bswap_32(vals[slot])) + sym->st_value;
+		if (off % BPF_INSN_SZ) {
+			pr_warn("%s: field %zu offset %zu is not instruction aligned\n",
+				CLEANUP_SEC, slot, off);
+			ret =3D -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+		rec =3D &recs[slot / CLEANUP_REC_FIELDS];
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
+		if (raw->sec_idx[CLEANUP_REC_BEGIN] =3D=3D raw->sec_idx[CLEANUP_REC_EN=
D] &&
+		    raw->insn_idx[CLEANUP_REC_BEGIN] >=3D raw->insn_idx[CLEANUP_REC_EN=
D]) {
+			pr_warn("%s: record %zu is an empty range [%zu,%zu)\n",
+				CLEANUP_SEC, i, raw->insn_idx[CLEANUP_REC_BEGIN],
+				raw->insn_idx[CLEANUP_REC_END]);
+			return -LIBBPF_ERRNO__FORMAT;
+		}
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
+	if (prog->cleanup_info_cnt > INT32_MAX / sizeof(struct bpf_cleanup_info=
)) {
+		pr_warn("prog '%s': too many cleanup records: %u\n",
+			prog->name, prog->cleanup_info_cnt);
+		return -LIBBPF_ERRNO__FORMAT;
+	}
+
+	qsort(prog->cleanup_info, prog->cleanup_info_cnt,
+	      sizeof(*prog->cleanup_info), cmp_cleanup_info);
+	for (i =3D 1; i < prog->cleanup_info_cnt; i++) {
+		struct bpf_cleanup_info *prev =3D &prog->cleanup_info[i - 1];
+		struct bpf_cleanup_info *cur =3D &prog->cleanup_info[i];
+
+		if (cur->begin_off < prev->end_off) {
+			pr_warn("prog '%s': overlapping cleanup regions [%u,%u) and [%u,%u)\n=
",
+				prog->name, prev->begin_off, prev->end_off,
+				cur->begin_off, cur->end_off);
+			return -LIBBPF_ERRNO__FORMAT;
+		}
+	}
+
+	return 0;
+}
+
 static int
 bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr,=
 Elf_Data *data)
 {
@@ -7894,6 +8166,13 @@ static int bpf_object__relocate(struct bpf_object =
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
@@ -8176,6 +8455,9 @@ static int bpf_object__collect_relos(struct bpf_obj=
ect *obj)
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
=20
+		if (idx =3D=3D obj->efile.cleanup_shndx)
+			continue;
+
 		if (obj->efile.secs[idx].sec_type =3D=3D SEC_RODATA)
 			err =3D bpf_object__collect_rodata_relos(obj, shdr, data);
 		else if (obj->efile.secs[idx].sec_type =3D=3D SEC_ST_OPS)
@@ -8469,6 +8751,11 @@ static int bpf_object_load_prog(struct bpf_object =
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
 	load_attr.fd_array =3D obj->fd_array;
@@ -9062,6 +9349,7 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
 	err =3D err ? : bpf_object__init_maps(obj, opts);
 	err =3D err ? : bpf_object_init_progs(obj, opts);
 	err =3D err ? : bpf_object__collect_relos(obj);
+	err =3D err ? : bpf_object__init_cleanup_info(obj);
 	if (err)
 		goto out;
=20
@@ -10195,6 +10483,9 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->jumptables_data);
 	obj->jumptables_data_sz =3D 0;
=20
+	zfree(&obj->cleanup_recs);
+	obj->cleanup_rec_cnt =3D 0;
+
 	for (i =3D 0; i < obj->jumptable_map_cnt; i++)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
@@ -10599,6 +10890,25 @@ int bpf_program__clone(struct bpf_program *prog,=
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
+	if (info) {
+		attr.cleanup_info =3D info;
+		attr.cleanup_info_cnt =3D info_cnt;
+		attr.cleanup_info_rec_size =3D info_rec_size;
+	} else if (prog->cleanup_info_cnt) {
+		attr.cleanup_info =3D prog->cleanup_info;
+		attr.cleanup_info_cnt =3D prog->cleanup_info_cnt;
+		attr.cleanup_info_rec_size =3D prog->cleanup_info_rec_size;
+	}
+
 	/* Logging is caller-controlled; no fallback to prog/obj log settings *=
/
 	attr.log_buf =3D OPTS_GET(opts, log_buf, NULL);
 	attr.log_size =3D OPTS_GET(opts, log_size, 0);
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index 546f65b95cf4..f1630f03d5f5 100644
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

