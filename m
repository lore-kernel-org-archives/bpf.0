Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFC266B72
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139614; cv=none; b=IAXR+BZHKfu9vC42B7dFeYZ4tvTy92Alf4dzYOibDBjBv+B3WyvA/tT78P2BON0mxU4ib0otx6LeXUI0aCN9dYMbHP/cSybh0htswH+tsK/oJzKzwPx9rDOlNjBRRlOWKE96ZmgIOjZMCuZBPO+9isCkECwsAONNckX178hEHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139614; c=relaxed/simple;
	bh=R67D8AiWYMLb5O4Mq3u+MKM9LRdnhM7P1eGK3FwGa1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVSnaw+77rjGTqkq/lWW7MT/cWThuJq8ArKtLSCteD3w8bjW9UIb69xLBmnnPkUuNUL7Ye7nZPeh4HO5y//RMRdBR5bmOloQN3Ys9Q2UWP48X71It7Ui+qnI2RYMuxeChHtXckT4ey84Z/n49DRcmZ4gYszwimb7H/MLC/41ZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9CA6D2C8DADBAD; Tue, 22 Sep 2026 22:00:08 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 16/21] libbpf: Collect .bpf_cleanup records and pass them to the kernel
Date: Tue, 22 Sep 2026 22:00:08 -0700
Message-ID: <20260923050008.2425961-1-yonghong.song@linux.dev>
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

The records are sorted by begin_off once the offsets are final: the kerne=
l
wants the table sorted with disjoint ranges so that it can find the recor=
d
covering a call site with a binary search, and records arrive in
.bpf_cleanup order, which says nothing about where the subprograms they
describe were appended. Overlapping ranges are reported here, where the
program name and both regions are still at hand.

bpf_object_load_prog() then passes the per-program table through the
bpf_prog_load() options added in the previous patch, with the record size
carried on the program the way func_info and line_info carry theirs rathe=
r
than taken from a sizeof() at the call site. bpf_program__clone() carries
it too. That is a second load path -- the one veristat uses -- and withou=
t
the table the kernel sees landing pads nothing reaches and refuses the
program with "unreachable insn".

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/libbpf.c          | 309 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |   3 +
 2 files changed, 312 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2d0081784445..d0e601b3499c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -514,6 +514,11 @@ struct bpf_program {
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
@@ -549,6 +554,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define CLEANUP_SEC ".bpf_cleanup"
=20
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -677,6 +683,26 @@ struct elf_sec_desc {
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
+ * One (begin, end, landing_pad) triple from .bpf_cleanup, with each fie=
ld
+ * resolved from its relocation to an ELF section plus a section-relativ=
e
+ * instruction index. The mapping to final program instruction indices c=
an only
+ * happen after subprogram placement, which differs per main program.
+ */
+struct cleanup_raw_rec {
+	int sec_idx[CLEANUP_REC_FIELDS];
+	size_t insn_idx[CLEANUP_REC_FIELDS];
+};
+
 struct elf_state {
 	int fd;
 	const void *obj_buf;
@@ -696,6 +722,8 @@ struct elf_state {
 	bool has_st_ops;
 	int arena_data_shndx;
 	int jumptables_data_shndx;
+	Elf_Data *cleanup_data;
+	int cleanup_shndx;
 };
=20
 struct usdt_manager;
@@ -773,6 +801,9 @@ struct bpf_object {
 	void *jumptables_data;
 	size_t jumptables_data_sz;
=20
+	struct cleanup_raw_rec *cleanup_recs;
+	size_t cleanup_rec_cnt;
+
 	struct {
 		struct bpf_program *prog;
 		unsigned int sym_off;
@@ -819,7 +850,10 @@ static void bpf_program__exit(struct bpf_program *pr=
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
@@ -1561,6 +1595,7 @@ static struct bpf_object *bpf_object__new(const cha=
r *path,
 	obj->efile.obj_buf =3D obj_buf;
 	obj->efile.obj_buf_sz =3D obj_buf_sz;
 	obj->efile.btf_maps_shndx =3D -1;
+	obj->efile.cleanup_shndx =3D -1;
 	obj->kconfig_map_idx =3D -1;
 	obj->arena_map_idx =3D -1;
=20
@@ -4047,6 +4082,9 @@ static int bpf_object__elf_collect(struct bpf_objec=
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
@@ -4074,6 +4112,7 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_LINK_SEC) &&
+			    strcmp(name, ".rel" CLEANUP_SEC) &&
 			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
@@ -4854,6 +4893,238 @@ static struct bpf_program *find_prog_by_sec_insn(=
const struct bpf_object *obj,
 	return NULL;
 }
=20
+static int bpf_object__init_cleanup_info(struct bpf_object *obj)
+{
+	Elf_Data *data =3D obj->efile.cleanup_data;
+	Elf_Data *relo =3D NULL;
+	size_t i, nrels, nslots, nrecs;
+	struct cleanup_raw_rec *recs;
+	int *slot_sec, ret =3D 0;
+	size_t *slot_val;
+	const __u32 *vals;
+	bool native;
+
+	if (!data || obj->efile.cleanup_shndx < 0)
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
+	slot_sec =3D calloc(nslots, sizeof(*slot_sec));
+	slot_val =3D calloc(nslots, sizeof(*slot_val));
+	recs =3D calloc(nrecs ?: 1, sizeof(*recs));
+	if (!slot_sec || !slot_val || !recs) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+	for (i =3D 0; i < nslots; i++)
+		slot_sec[i] =3D -1;
+
+	/* One relocation per 4-byte field, naming the section it points into. =
*/
+	nrels =3D relo->d_size / sizeof(Elf64_Rel);
+	for (i =3D 0; i < nrels; i++) {
+		Elf64_Rel *rel =3D elf_rel_by_idx(relo, i);
+		Elf64_Sym *sym =3D elf_sym_by_idx(obj, ELF64_R_SYM(rel->r_info));
+		size_t type =3D ELF64_R_TYPE(rel->r_info);
+		size_t slot =3D rel->r_offset / sizeof(__u32);
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
+		slot_sec[slot] =3D sym->st_shndx;
+		/*
+		 * The addend lives in the section data, which libelf leaves in
+		 * the object's byte order; a non-section symbol additionally
+		 * contributes its own value.
+		 */
+		slot_val[slot] =3D (native ? vals[slot] : bswap_32(vals[slot])) +
+				 sym->st_value;
+	}
+
+	for (i =3D 0; i < nslots; i++) {
+		struct cleanup_raw_rec *rec =3D &recs[i / CLEANUP_REC_FIELDS];
+		size_t field =3D i % CLEANUP_REC_FIELDS;
+
+		if (slot_sec[i] < 0) {
+			pr_warn("%s: field %zu has no relocation\n", CLEANUP_SEC, i);
+			ret =3D -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+		if (slot_val[i] % BPF_INSN_SZ) {
+			pr_warn("%s: field %zu offset %zu is not instruction aligned\n",
+				CLEANUP_SEC, i, slot_val[i]);
+			ret =3D -LIBBPF_ERRNO__FORMAT;
+			goto out;
+		}
+		rec->sec_idx[field] =3D slot_sec[i];
+		rec->insn_idx[field] =3D slot_val[i] / BPF_INSN_SZ;
+	}
+
+	obj->cleanup_recs =3D recs;
+	obj->cleanup_rec_cnt =3D nrecs;
+	recs =3D NULL;
+out:
+	free(recs);
+	free(slot_val);
+	free(slot_sec);
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
+			 * The end of a range is exclusive, so it may name the
+			 * instruction just past the last one of a function,
+			 * which belongs to the next function or to nothing at
+			 * all. Ask about the last instruction the range covers,
+			 * the way the kernel does.
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
@@ -7589,6 +7860,13 @@ static int bpf_object__relocate(struct bpf_object =
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
@@ -7779,6 +8057,9 @@ static int bpf_object__collect_relos(struct bpf_obj=
ect *obj)
 			return -LIBBPF_ERRNO__INTERNAL;
 		}
=20
+		if (idx =3D=3D obj->efile.cleanup_shndx)
+			continue;
+
 		if (obj->efile.secs[idx].sec_type =3D=3D SEC_ST_OPS)
 			err =3D bpf_object__collect_st_ops_relos(obj, shdr, data);
 		else if (idx =3D=3D obj->efile.btf_maps_shndx)
@@ -8051,6 +8332,11 @@ static int bpf_object_load_prog(struct bpf_object =
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
@@ -8644,6 +8930,7 @@ static struct bpf_object *bpf_object_open(const cha=
r *path, const void *obj_buf,
 	err =3D err ? : bpf_object__init_maps(obj, opts);
 	err =3D err ? : bpf_object_init_progs(obj, opts);
 	err =3D err ? : bpf_object__collect_relos(obj);
+	err =3D err ? : bpf_object__init_cleanup_info(obj);
 	if (err)
 		goto out;
=20
@@ -9758,6 +10045,9 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->jumptables_data);
 	obj->jumptables_data_sz =3D 0;
=20
+	zfree(&obj->cleanup_recs);
+	obj->cleanup_rec_cnt =3D 0;
+
 	for (i =3D 0; i < obj->jumptable_map_cnt; i++)
 		close(obj->jumptable_maps[i].fd);
 	zfree(&obj->jumptable_maps);
@@ -10156,6 +10446,25 @@ int bpf_program__clone(struct bpf_program *prog,=
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
index cb4d96233844..3ba6d9090368 100644
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

