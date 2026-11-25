Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625941;
	b=bDt3c6XGqGOQyib6wUOp8XsRGhh2uFCpUiDTIeZHwMwNL85fpwg1viYM5HT4yPRpSUC/
	 mMr8bKAsouQoDv5J4wP/DZXSnHgL5ujxG3agBAGQSVHHCeL3SG1pEgqRzCThhHdduaG8d
	 AqvF0J9ex3IuVKDT9hHswOXQOWAFUS9mVDiPUz2f2K9S98AZ67ZkIIxWBrpYlYyXSXTBF
	 Kz35XGLVmVYthYNKiyfdXu56yJyI/g9hrWhBXpw8KHoNdfXkbTgLr7W8MglG5KBIZmulI
	 zJeKQZ6GomymgkbraRIzr2I8TKVVdACck7msh+N46qSyn9M0OLIBZqPXLAZHBOoFY3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JHCMu310eAj+zPpB/nRUjCTrD6vrN6+98QZfu6UN/5w=;
	b=k1wR/q+X0/SPkxUwiKyvueRzvICh6QzacJuhho1Rrqd6AFxMPITvc1edAjBms/uNprYk
	 DHLeejMWsQ2bC5OyooGD+LZLXqthXm8dRM3HFRduU48vW4a3AZJ3FieIdMYTSDAetVFKY
	 8uzOXg1ClW081NEOHQjXU/87uDTSt1aUGGuHW2FBFVKqHPoeJfdcAXPy+f4XT2akvXx6x
	 L+dv9sjvxpZ9sQ2jPTxZGWSH5qwowyP9nxcBjkviWD5Sdp5vnZK/nyq96lzNY5UPUu6cJ
	 ivcUp1j2+cwz4sWzM6A52yiPRPVsXVPPZ72frkKE9et2/X9zn6XeaM8AgkoBLF7/7kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X89V4AzA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0659606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X89V4AzA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE661F000C6;
	Wed, 25 Nov 2026 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625940;
	bh=JHCMu310eAj+zPpB/nRUjCTrD6vrN6+98QZfu6UN/5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X89V4AzAr6lMDaPJmuZ31LMPht7WzGMnEZAD3yveDZanJTidoZURDc1nL7E9omZFz
	 h/POqRpvROSbxrjjVM11mjpMfYeUuNAER8W291sNGO8t5SAng1sCxJcfgVr/J3LtTb
	 mEONHoaWFXKKEAouf3wADmGondF2Yf0t6aA/p0aIIuYvDpk03zrI3lit4naWMdhkIm
	 crsofOOFNA9ROcTcfQFo2v35FJDNn1Hlnl5N2P6XIW47hKzsGQi5UUlMmNZ3ivkVnB
	 fsknykIxXMgNvlvrQeuBCwJrOo88v/3rtf2FEEX1aJ9QAcZ75z2NMIyzEfK0YRGBaC
	 bpufGfaYVZLNQ==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: andrey.grodzovsky@crowdstrike.com,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	mason@kernel.org,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH v2 bpf-next 2/5] libbpf: Support CO-RE relocation of tracing program arguments
Date: Wed, 25 Nov 2026 16:58:42 +0000
Message-ID: <20261125165845.45806-3-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125165845.45806-1-almagui@kernel.org>
References: <20261125165845.45806-1-almagui@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_PROG() and friends access the arguments of fentry/fexit/tp_btf/LSM
programs by fixed position in the u64 context array. When a traced
function or tracepoint gains, loses or reorders parameters, programs
silently read the wrong argument (or fail verification), and there is
no way to check whether a given argument exists.

Let programs describe the arguments they need as a struct named
bpf_func_args___<flavor>, with members named after the parameters of
the attach target, in any order, and __ret for the return value:

	struct bpf_func_args___unlink {
		struct filename *name;
		int dfd;
		int __ret;
	} __attribute__((preserve_access_index));

	SEC("fexit/filename_unlinkat")
	int handle(struct bpf_func_args___unlink *ctx)
	{
		if (bpf_core_field_exists(ctx->dfd))
			bpf_printk("dfd %d", ctx->dfd);
		...
	}

For relocations against such a struct, libbpf describes the program's
context as a struct of the same name in a split BTF on top of the BTF of
the attach target: one member per parameter, with its name and type, at
its offset in the context as laid out by the kernel's btf_ctx_arg_idx()
(structs passed by value take up multiple slots), followed by __ret for
fexit, fmod_ret, fsession and LSM programs. This struct is the only
candidate, so the relocations themselves are ordinary CO-RE: offsets are
patched, bpf_core_field_exists() reports missing arguments, unguarded
accesses to them are poisoned, and bpf_core_type_matches() on the whole
struct can tell apart variants of a function's signature, e.g. a
parameter changing from struct vm_area_struct * to struct mm_area *.
No changes to relo_core.c are needed. The candidate depends on the
program, so it is kept out of the object-wide candidate cache, and
built for each relocation.

Clang uses the typedef as the root type of relocations against a struct
accessed through one, so typedefs and modifiers are skipped to find the
struct, and an anonymous struct takes its name from its typedef. The
relocation is then made against the struct itself, so that type-based
relocations match the candidate, unless the struct is anonymous, which
relocations can't have as their root type: type-based relocations then
need a named struct.

Unlike for other types, the flavor is everything after the first triple
underscore, so that any flavor works, including ones that start with or
contain underscores, e.g. when generated from a program's name: with the
usual rule, the essential name of such a struct isn't bpf_func_args, so
all of its members would silently appear to be missing. The candidate is
named after the program's struct rather than bpf_func_args, so that the
root type names compared by type-based relocations match whatever the
flavor is.

btf_trace_xxx prototypes carry no parameter names, so for tp_btf
programs the parameters are taken from the identically-typed
__probestub_xxx() function (Linux 6.5+) or, failing that,
__traceiter_xxx() (Linux 5.10+), without their first void *__data
parameter. On older kernels there is no candidate: guarded accesses see
the arguments as missing, and unguarded accesses fail to load.

The struct can only be used in entry programs (or inlined code), as a
shared subprogram has no single attach target, and only with attach
targets in kernel BTF. Its type ID can't be relocated to a kernel type
ID, as it only exists in libbpf. Light skeletons need the kernel to
apply these relocations, which a following patch adds.

The candidate is built from the attach target when the object is
prepared, which for tracing programs was only done when they were
loaded. If the target isn't found, there is no candidate instead of an
error, as the program then fails to load anyway, and might never be
loaded, e.g. if its load strategy is manual, so preparing the object
doesn't fail because of it.
The relocations depend on the type, attach type and attach target of the
program, so once the object is prepared, setting them with
bpf_program__set_type(), bpf_program__set_expected_attach_type() or
bpf_program__set_attach_target() fails with -EBUSY for programs using the
struct, instead of leaving them relocated against another target.

On big-endian targets, arguments smaller than 8 bytes are at the end of
their slot, so their members are placed there. The verifier allows
loads of them from the previous patch on; on older kernels, programs
reading them fail to load.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 tools/lib/bpf/libbpf.c | 333 +++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h |  13 +-
 2 files changed, 343 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd37b2e..b452bda266da 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -500,6 +500,8 @@ struct bpf_program {
 	/* the program or a function that it calls has callx */
 	bool has_callx;
 	bool mark_btf_static;
+	/* relocations against struct bpf_func_args___xyz were applied */
+	bool func_args_relocated;
 	enum bpf_prog_type type;
 	enum bpf_attach_type expected_attach_type;
 	int exception_cb_idx;
@@ -6256,6 +6258,107 @@ static const struct bpf_core_relo *find_relo_core(struct bpf_program *prog, int
 	return NULL;
 }
 
+#define BPF_FUNC_ARGS "bpf_func_args"
+
+static int bpf_prog_func_args_btf(const struct bpf_program *prog, const char *name,
+				  struct btf **res);
+
+/*
+ * Is the root type of a relocation 'struct bpf_func_args___xyz'? Clang uses
+ * the typedef as the root type of relocations against a struct accessed
+ * through one, so skip typedefs and modifiers, and take the name of an
+ * anonymous struct from its typedef. Returns the root type to relocate
+ * against in *res_id: the struct, unless it is anonymous.
+ *
+ * Unlike for other types, the flavor is everything after the first triple
+ * underscore, so that it can start with or contain underscores, e.g. when
+ * generated from a program's name.
+ */
+static bool bpf_core_is_func_args(const struct btf *btf, __u32 id, __u32 *res_id)
+{
+	const char *name = NULL;
+	const struct btf_type *t;
+	__u32 root_id = id;
+	int depth = 32;
+
+	t = btf__type_by_id(btf, id);
+	while (t && (btf_is_typedef(t) || btf_is_mod(t)) && depth--) {
+		if (btf_is_typedef(t))
+			name = btf__name_by_offset(btf, t->name_off);
+		id = t->type;
+		t = btf__type_by_id(btf, id);
+	}
+	if (!t || !btf_is_struct(t))
+		return false;
+	/* relocations can't have an anonymous root type, keep its typedef */
+	if (t->name_off) {
+		name = btf__name_by_offset(btf, t->name_off);
+		*res_id = id;
+	} else {
+		*res_id = root_id;
+	}
+
+	return name && (strcmp(name, BPF_FUNC_ARGS) == 0 ||
+			str_has_pfx(name, BPF_FUNC_ARGS "___"));
+}
+
+/*
+ * Resolve a relocation against 'struct bpf_func_args___xyz', whose only
+ * candidate is the struct describing the context of the program, see
+ * bpf_prog_func_args_btf(). The candidate depends on the program, so it is
+ * kept out of the object-wide candidate cache.
+ */
+static int bpf_core_resolve_func_args(struct bpf_program *prog,
+				      const struct bpf_core_relo *relo, int relo_idx,
+				      const struct btf *local_btf, const char *local_name,
+				      __u32 struct_id, struct bpf_core_spec *specs_scratch,
+				      struct bpf_core_relo_res *targ_res)
+{
+	struct bpf_core_cand_list cands = {};
+	struct bpf_core_relo struct_relo;
+	struct bpf_core_cand cand;
+	const char *struct_name;
+	struct btf *btf;
+	int err;
+
+	/* the type only exists in libbpf, not in the kernel */
+	if (relo->kind == BPF_CORE_TYPE_ID_TARGET) {
+		pr_warn("prog '%s': relo #%d: no kernel type ID for struct %s\n",
+			prog->name, relo_idx, local_name);
+		return -EOPNOTSUPP;
+	}
+
+	/* the relocations now depend on the program's attach target */
+	prog->func_args_relocated = true;
+
+	/*
+	 * Name the candidate after the program's struct, so that the names
+	 * that type-based relocations compare match whatever its flavor is.
+	 */
+	struct_name = btf__name_by_offset(local_btf,
+					  btf__type_by_id(local_btf, struct_id)->name_off);
+	err = bpf_prog_func_args_btf(prog, struct_name, &btf);
+	if (err) {
+		pr_warn("prog '%s': relo #%d: failed to find the arguments of the attach target for struct %s: %s\n",
+			prog->name, relo_idx, local_name, errstr(err));
+		return err;
+	}
+	if (btf) {
+		cand.btf = btf;
+		cand.id = btf__type_cnt(btf) - 1;
+		cands.cands = &cand;
+		cands.len = 1;
+	}
+
+	/* type-based relocations need the root to be the struct, not a typedef */
+	struct_relo = *relo;
+	struct_relo.type_id = struct_id;
+	err = bpf_core_calc_relo_insn(prog->name, &struct_relo, relo_idx, local_btf, &cands,
+				      specs_scratch, targ_res);
+	btf__free(btf);
+	return err;
+}
+
 static int bpf_core_resolve_relo(struct bpf_program *prog,
 				 const struct bpf_core_relo *relo,
 				 int relo_idx,
@@ -6269,6 +6372,7 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 	const struct btf_type *local_type;
 	const char *local_name;
 	__u32 local_id = relo->type_id;
+	__u32 struct_id;
 	int err;
 
 	local_type = btf__type_by_id(local_btf, local_id);
@@ -6279,6 +6383,11 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 	if (!local_name)
 		return -EINVAL;
 
+	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
+	    bpf_core_is_func_args(local_btf, local_id, &struct_id))
+		return bpf_core_resolve_func_args(prog, relo, relo_idx, local_btf, local_name,
+						  struct_id, specs_scratch, targ_res);
+
 	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
 	    !hashmap__find(cand_cache, local_id, &cands)) {
 		cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
@@ -10685,10 +10794,26 @@ static struct bpf_sec_def custom_fallback_def;
 static bool has_custom_fallback_def;
 static int last_custom_sec_def_handler_id;
 
+/*
+ * Relocations against struct bpf_func_args___xyz depend on the type, attach
+ * type and attach target of the program, and are applied when the object is
+ * prepared, so these can't change afterwards.
+ */
+static bool prog_func_args_relocated(const struct bpf_program *prog)
+{
+	if (prog->obj->state < OBJ_PREPARED || !prog->func_args_relocated)
+		return false;
+	pr_warn("prog '%s': can't change the attach target of a program using struct %s once the object is prepared\n",
+		prog->name, BPF_FUNC_ARGS);
+	return true;
+}
+
 int bpf_program__set_type(struct bpf_program *prog, enum bpf_prog_type type)
 {
 	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
+	if (prog->type != type && prog_func_args_relocated(prog))
+		return libbpf_err(-EBUSY);
 
 	/* if type is not changed, do nothing */
 	if (prog->type == type)
@@ -10720,6 +10845,8 @@ int bpf_program__set_expected_attach_type(struct bpf_program *prog,
 {
 	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);
+	if (prog->expected_attach_type != type && prog_func_args_relocated(prog))
+		return libbpf_err(-EBUSY);
 
 	prog->expected_attach_type = type;
 	return 0;
@@ -11641,6 +11768,210 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 	return 0;
 }
 
+/* Find the BTF and type ID of the kernel attach target of a program */
+static int bpf_prog_attach_target(const struct bpf_program *prog,
+				  struct btf **btf, int *btf_id)
+{
+	struct bpf_object *obj = prog->obj;
+	int btf_obj_fd = 0, i, err;
+	const char *attach_name;
+
+	if (prog->attach_btf_id) {
+		/* set via bpf_program__set_attach_target() */
+		btf_obj_fd = prog->attach_btf_obj_fd;
+		*btf_id = prog->attach_btf_id;
+	} else {
+		attach_name = strchr(prog->sec_name, '/');
+		if (!prog->sec_def || !(prog->sec_def->cookie & SEC_ATTACH_BTF) ||
+		    !attach_name || !attach_name[1]) {
+			pr_debug("prog '%s': struct %s needs an attach target in kernel BTF\n",
+				 prog->name, BPF_FUNC_ARGS);
+			return -EINVAL;
+		}
+		attach_name++;
+		err = find_kernel_btf_id(obj, attach_name, prog->expected_attach_type,
+					 &btf_obj_fd, btf_id);
+		if (err) {
+			pr_debug("prog '%s': failed to find kernel BTF type ID of '%s': %s\n",
+				 prog->name, attach_name, errstr(err));
+			return err;
+		}
+	}
+
+	*btf = btf_obj_fd ? NULL : obj->btf_vmlinux;
+	for (i = 0; btf_obj_fd && i < obj->btf_module_cnt; i++) {
+		if (obj->btf_modules[i].fd == btf_obj_fd) {
+			*btf = obj->btf_modules[i].btf;
+			break;
+		}
+	}
+	return *btf ? 0 : -ESRCH;
+}
+
+/*
+ * Add a member for an argument or the return value to the struct being built.
+ * Each takes up a whole number of u64 slots in the context, as laid out by
+ * btf_ctx_arg_idx() in the kernel.
+ */
+static int func_args_add(struct btf *btf, const struct btf *targ_btf,
+			 const char *name, __u32 type_id, __u32 *off)
+{
+	const struct btf_type *t;
+	__u32 pad = 0;
+	__s64 sz;
+	int err;
+
+	t = skip_mods_and_typedefs(targ_btf, type_id, NULL);
+	sz = t && btf_is_ptr(t) ? 8 : btf__resolve_size(targ_btf, type_id);
+	if (sz <= 0)
+		return sz ?: -EINVAL;
+	/* a small argument is in the low bytes of its slot */
+	if (sz < 8 && btf__endianness(targ_btf) == BTF_BIG_ENDIAN)
+		pad = 8 - sz;
+	/* unnamed parameters still take up their slots */
+	if (!str_is_empty(name)) {
+		err = btf__add_field(btf, name, type_id, (*off + pad) * 8, 0);
+		if (err)
+			return err;
+	}
+	*off += roundup(sz, 8);
+	return 0;
+}
+
+/*
+ * The context of tp_btf, fentry, fexit, fmod_ret, fsession and LSM programs
+ * is an array of u64 slots: the arguments of the attach target, then, where
+ * the program can see it, its return value. Describe it as
+ *
+ *	struct bpf_func_args___xyz {
+ *		<type of the parameter> <name of the parameter>;
+ *		...
+ *		<return type> __ret;
+ *	};
+ *
+ * in a split BTF on top of the BTF of the attach target, with the same
+ * name as the program's own struct (the name argument), so that it matches
+ * whatever that struct's flavor is. This struct is then the only CO-RE
+ * candidate for the program's struct, and relocations against it are
+ * ordinary CO-RE.
+ *
+ * Sets *res to NULL, so that there is no candidate, if the attach target is
+ * not found, or is a tracepoint without parameter names in BTF (kernels
+ * before 5.10).
+ */
+static int bpf_prog_func_args_btf(const struct bpf_program *prog, const char *name,
+				  struct btf **res)
+{
+	int i, id, first = 0, err;
+	const struct btf_param *p;
+	const struct btf_type *t;
+	struct btf *targ_btf, *btf;
+	bool has_ret = false;
+	const char *tp_name;
+	__u32 off = 0;
+
+	*res = NULL;
+
+	/* shared subprogs have no single attach target */
+	if (prog_is_subprog(prog->obj, prog)) {
+		pr_warn("prog '%s': struct %s can only be used in entry programs\n",
+			prog->name, BPF_FUNC_ARGS);
+		return -EOPNOTSUPP;
+	}
+	if ((prog->type != BPF_PROG_TYPE_TRACING && prog->type != BPF_PROG_TYPE_LSM) ||
+	    prog->attach_prog_fd) {
+		pr_warn("prog '%s': struct %s needs an attach target in kernel BTF\n",
+			prog->name, BPF_FUNC_ARGS);
+		return -EOPNOTSUPP;
+	}
+
+	switch (prog->expected_attach_type) {
+	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_FSESSION:
+	case BPF_LSM_MAC:
+	case BPF_LSM_CGROUP:
+		has_ret = true;
+		break;
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_RAW_TP:
+		break;
+	default:
+		pr_warn("prog '%s': struct %s is not supported for this attach type\n",
+			prog->name, BPF_FUNC_ARGS);
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * A missing attach target fails the load of the program anyway, so
+	 * leave that to it instead of failing to prepare the object, as the
+	 * program might not be loaded at all, e.g. if its load strategy is
+	 * BPF_PROG_LOAD_STRATEGY_MANUAL.
+	 */
+	err = bpf_prog_attach_target(prog, &targ_btf, &id);
+	if (err == -ENOMEM)
+		return err;
+	if (err) {
+		pr_debug("prog '%s': attach target not found, struct %s has no members\n",
+			 prog->name, BPF_FUNC_ARGS);
+		return 0;
+	}
+
+	t = btf__type_by_id(targ_btf, id);
+	if (t && btf_is_typedef(t)) {
+		/*
+		 * btf_trace_xyz has no names of parameters. __probestub_xyz()
+		 * has (6.5+), and __traceiter_xyz() has (5.10+). Both take
+		 * void *__data first, which is not in the context.
+		 */
+		tp_name = btf__name_by_offset(targ_btf, t->name_off);
+		if (!tp_name || !str_has_pfx(tp_name, BTF_TRACE_PREFIX))
+			return -EINVAL;
+		tp_name += sizeof(BTF_TRACE_PREFIX) - 1;
+		id = find_btf_by_prefix_kind(targ_btf, "__probestub_", tp_name, BTF_KIND_FUNC);
+		if (id == -ENOENT)
+			id = find_btf_by_prefix_kind(targ_btf, "__traceiter_", tp_name,
+						     BTF_KIND_FUNC);
+		if (id == -ENOENT) {
+			pr_debug("prog '%s': tracepoint '%s' has no parameter names in BTF, struct %s has no members\n",
+				 prog->name, tp_name, BPF_FUNC_ARGS);
+			return 0;
+		}
+		if (id < 0)
+			return id;
+		t = btf__type_by_id(targ_btf, id);
+		first = 1;
+	}
+	if (!t || !btf_is_func(t))
+		return -EINVAL;
+	t = btf__type_by_id(targ_btf, t->type);
+	if (!t || !btf_is_func_proto(t))
+		return -EINVAL;
+
+	btf = btf__new_empty_split(targ_btf);
+	if (!btf)
+		return -errno;
+
+	id = btf__add_struct(btf, name, 0);
+	err = id < 0 ? id : 0;
+	p = btf_params(t);
+	/* a trailing parameter of type void is '...' */
+	for (i = first; !err && i < btf_vlen(t) && p[i].type; i++)
+		err = func_args_add(btf, targ_btf, btf__name_by_offset(targ_btf, p[i].name_off),
+				    p[i].type, &off);
+	if (!err && has_ret && t->type)
+		err = func_args_add(btf, targ_btf, "__ret", t->type, &off);
+	if (err) {
+		pr_warn("prog '%s': failed to describe the arguments of the attach target: %s\n",
+			prog->name, errstr(err));
+		btf__free(btf);
+		return err;
+	}
+	btf_type_by_id(btf, id)->size = off;
+	*res = btf;
+	return 0;
+}
+
 int libbpf_attach_type_by_name(const char *name,
 			       enum bpf_attach_type *attach_type)
 {
@@ -15658,6 +15989,8 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 
 	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EINVAL);
+	if (prog_func_args_relocated(prog))
+		return libbpf_err(-EBUSY);
 
 	if (attach_prog_fd && !attach_func_name) {
 		/* Store attach_prog_fd. The BTF ID will be resolved later during
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 49f1120f4021..f7dbe49582e8 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1015,7 +1015,9 @@ LIBBPF_API enum bpf_prog_type bpf_program__type(const struct bpf_program *prog);
  * @param prog BPF program to set the program type for
  * @param type program type to set the BPF map to have
  * @return error code; or 0 if no error. An error occurs
- * if the object is already loaded.
+ * if the object is already loaded, or, with -EBUSY, if it is
+ * prepared and libbpf relocated accesses to the arguments of the
+ * program through struct bpf_func_args___xyz, which depend on it.
  *
  * This must be called before the BPF object is loaded,
  * otherwise it has no effect and an error is returned.
@@ -1033,7 +1035,9 @@ bpf_program__expected_attach_type(const struct bpf_program *prog);
  * @param prog BPF program to set the attach type for
  * @param type attach type to set the BPF map to have
  * @return error code; or 0 if no error. An error occurs
- * if the object is already loaded.
+ * if the object is already loaded, or, with -EBUSY, if it is
+ * prepared and libbpf relocated accesses to the arguments of the
+ * program through struct bpf_func_args___xyz, which depend on it.
  *
  * This must be called before the BPF object is loaded,
  * otherwise it has no effect and an error is returned.
@@ -1127,7 +1131,10 @@ LIBBPF_API __u32 bpf_program__line_info_cnt(const struct bpf_program *prog);
  * attach_prog_fd to find destination BTF type ID in that BPF program, or
  * alone (no attach_prog_fd) to resolve kernel (vmlinux/module) BTF ID.
  * Must be provided if attach_prog_fd is 0.
- * @return error code; or 0 if no error occurred.
+ * @return error code; or 0 if no error occurred. Fails with -EBUSY
+ * if the object is prepared and libbpf relocated accesses to the
+ * arguments of the program through struct bpf_func_args___xyz, which
+ * depend on its attach target.
  */
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
-- 
2.56.0

