Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625945;
	b=hXPiTPeqo1l03cZlMkYAMdFEdP6gmmEXcrrGsxdA7SADFXYhrKFqcuTNZ2FOmfySu0k0
	 wHTcDBos6I++xmV9WmcVyMS+dIya8WbAP2iQy86hZ8psJdX5PRmm4Lpz1XxyOoSDAwYd7
	 tqgGBmGr1+NZOvhZmdLKpMoz/ieNX6eEc2QsexOaElavbefrlE8aB5V3PnhDZAs6vZ0x3
	 Ca1q4FOM8dJ8O1xt2zDCJI/ArccaNvZV1PkZvYwMcjnoGCK+dnTf2Mw4rEvh4C415T/va
	 Wm19VZoagggFS4JZgYay4HVjwxYbIwfPGDIbW9xwI9fuO1+IvnCDD7yCEJRCrYjFU0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625945;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ww1LBq3WB8AIlOqXrXpKcgmF5Om61CDj0D9IZb6ShCA=;
	b=dXLNwk+vqtM4wkRPweNesQ+UlyPguC+x3nV7ygUnGgSnXa/L/IHPzIixLwUW12ohff/A
	 he1ZEhyfC82HPaN2IAb9f+grNn9xhFoyv0ibEeoz7MC00mk+Vh9Cq2Lq6hYkw6WWMW/a7
	 XzdulODWTlTKNvJT9ebQ1nZPuKz4eF8hb9M7PfKV//BVaLQo2BFQokvUpLQrB3KA0q6L8
	 ZeHsHXPIRHSRcsO9T5cY6TDsSWF2wAb4sYTNn6smLEhV2rMlXIs0C52Nm7VBgil1gZzxh
	 r7lKojEWdv4I2ixeCWEeNxlZzX13RiW5iGq5pVViaUvGB9fA5bRT6MvAAW8OjmLJQ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNXb67zL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C08606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNXb67zL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1F81F000D3;
	Wed, 25 Nov 2026 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625945;
	bh=Ww1LBq3WB8AIlOqXrXpKcgmF5Om61CDj0D9IZb6ShCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LNXb67zLbxpxsQ+8pmBip62CSBctf618CcqtYCqgPf76Od83pO4Yhsv3JdxH5bXC8
	 eE+eyhta+a5hGRh2l0rPahT44UAEiPEet0nOozuvqLFmSw+xu7k3GD0IFxtstT5qwS
	 Piou8doYg+T/Kza1yl+xOS/sH+341G5sO+bVs41548+3oJHESzR/8FT1XHBqiq5LZA
	 Nef/bgPU/gqbRRlJ+zkOr5GiOnqoJB6P/1oL5Ja9bryOiWhx9A9/gwEHW4r2oKXR3Q
	 7uD7f/UWvrxCjnfCkxh7c3HUJK5HqU30fjYokPqmWVNHlVqkzIzYa5inabbHdixRCF
	 Fh4+Pw58iqypQ==
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
Subject: [PATCH v2 bpf-next 3/5] bpf: Support CO-RE relocation of tracing program arguments
Date: Wed, 25 Nov 2026 16:58:43 +0000
Message-ID: <20261125165845.45806-4-almagui@kernel.org>
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

libbpf relocates accesses to struct bpf_func_args___<flavor> against a
struct of the same name describing the context of tracing programs: one
member per parameter of the attach target, named and typed after it, at
its offset in the context, followed by __ret where the program can see
the return value. Light skeletons leave CO-RE relocations to the kernel,
so do the same here for them.

For relocations against such a struct, bpf_core_apply() builds the
struct in a minimal split BTF on top of the program's attach_btf, laid
out as btf_ctx_arg_idx() expects, and uses it as the only candidate, so
the relocations themselves are ordinary CO-RE and relo_core.c needs no
changes. Member names refer to the strings of the attach target's BTF,
so only the names of the struct and of __ret are added. The candidate
depends on the program, so it bypasses the candidate cache; the program
holds a reference to attach_btf, so cand_cache_mutex isn't needed
either. bpf_core_ctx gains the program for this.

As in libbpf, typedefs and modifiers are skipped to find the struct, an
anonymous struct takes its name from its typedef, and the relocation is
made against the struct itself unless it is anonymous. The flavor is
everything after the first triple underscore, and the candidate is named
after the program's struct, whose name is copied into the candidate's
strings along with __ret.

The rules match libbpf's: __ret is only present for fexit, fmod_ret,
fsession and LSM programs, other attach types and BPF program targets
are rejected, as is relocating the struct's type ID to a kernel type ID,
and on big-endian, arguments smaller than 8 bytes are placed in the high
addresses of their slot. For tp_btf programs, the parameters are those
of __probestub_xxx(), without void *__data, as btf_trace_xxx has no
parameter names; unlike libbpf, which supports older kernels, no
fallback is needed here. As the kernel relocates each program with its
subprograms already appended, accesses from subprograms are relocated
against the program's attach target, where libbpf, which relocates
shared subprogram code once, rejects them.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 include/linux/bpf.h    |   2 +
 kernel/bpf/btf.c       | 235 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/check_btf.c |   1 +
 3 files changed, 238 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e9a4d15af0e..9bec0e6bcfd4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3446,6 +3446,8 @@ int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
 	const struct btf *btf;
+	/* the prog being loaded, if any, for struct bpf_func_args */
+	const struct bpf_prog *prog;
 };
 
 bool btf_nested_type_is_trusted(struct bpf_verifier_log *log,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 04f12225ec08..8824da49a0c0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -10721,14 +10721,223 @@ bpf_core_find_cands(struct bpf_core_ctx *ctx, u32 local_type_id)
 	return populate_cand_cache(cands, module_cand_cache, MODULE_CAND_CACHE_SIZE);
 }
 
+#define BPF_FUNC_ARGS "bpf_func_args"
+#define BTF_TRACE_PREFIX "btf_trace_"
+
+/*
+ * The context of tp_btf, fentry, fexit, fmod_ret, fsession and LSM programs
+ * is an array of u64 slots: the arguments of the attach target, then, where
+ * the program can see it, its return value, see btf_ctx_arg_idx(). Describe
+ * it as
+ *
+ *	struct bpf_func_args {
+ *		<type of the parameter> <name of the parameter>;
+ *		...
+ *		<return type> __ret;
+ *	};
+ *
+ * in a split BTF on top of the BTF of the attach target, named after the
+ * prog's own 'struct bpf_func_args___xyz'. This struct is then the only CO-RE
+ * candidate for it, and relocations against it are ordinary CO-RE. libbpf
+ * does the same, see bpf_prog_func_args_btf() in tools/lib/bpf/libbpf.c.
+ */
+struct func_args_btf {
+	struct btf btf;
+	struct btf_type *types[1];
+	struct bpf_core_cand cand;
+	struct btf_type t;
+	struct btf_member m[MAX_BPF_FUNC_ARGS + 1];
+	/* the names of the struct and of __ret */
+	char strs[];
+};
+
+#define FUNC_ARGS_RET "__ret"
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
+ * generated from a prog's name.
+ */
+static bool bpf_core_is_func_args(const struct btf *btf, u32 id, u32 *res_id)
+{
+	const struct btf_type *t;
+	const char *name = NULL;
+	int depth = MAX_RESOLVE_DEPTH;
+	u32 root_id = id;
+
+	t = btf_type_by_id(btf, id);
+	while (t && btf_type_is_modifier(t) && depth--) {
+		if (btf_type_is_typedef(t))
+			name = btf_name_by_offset(btf, t->name_off);
+		id = t->type;
+		t = btf_type_by_id(btf, id);
+	}
+	if (!t || !__btf_type_is_struct(t))
+		return false;
+	/* relocations can't have an anonymous root type, keep its typedef */
+	if (t->name_off) {
+		name = btf_name_by_offset(btf, t->name_off);
+		*res_id = id;
+	} else {
+		*res_id = root_id;
+	}
+
+	return name && (!strcmp(name, BPF_FUNC_ARGS) ||
+			str_has_prefix(name, BPF_FUNC_ARGS "___"));
+}
+
+static int func_args_add(struct func_args_btf *a, u32 name_off, u32 type_id)
+{
+	const struct btf_type *t = btf_type_skip_modifiers(&a->btf, type_id, NULL);
+	u32 n = btf_type_vlen(&a->t);
+	u32 sz;
+
+	if (!t)
+		return -EINVAL;
+	sz = btf_type_is_ptr(t) ? 8 : t->size;
+	if (!sz)
+		return -EINVAL;
+	if (n == ARRAY_SIZE(a->m))
+		return -E2BIG;
+
+	/* unnamed parameters still take up their slots */
+	if (name_off) {
+		a->m[n].name_off = name_off;
+		a->m[n].type = type_id;
+		a->m[n].offset = a->t.size * 8;
+		/* a small argument is in the high addresses of its slot */
+		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && sz < 8)
+			a->m[n].offset += (8 - sz) * 8;
+		a->t.info = BTF_KIND_STRUCT << 24 | (n + 1);
+	}
+	a->t.size += roundup(sz, 8);
+	return 0;
+}
+
+static struct func_args_btf *bpf_core_func_args_btf(struct bpf_core_ctx *ctx, u32 struct_id)
+{
+	const struct bpf_prog *prog = ctx->prog;
+	struct btf *targ_btf;
+	const struct btf_param *p;
+	const struct btf_type *t;
+	const char *struct_name;
+	struct func_args_btf *a;
+	int i, first = 0, err = 0;
+	size_t name_len;
+	bool has_ret = false;
+	const char *tname;
+	char name[128];
+	s32 id;
+
+	/* the prog holds a reference to attach_btf */
+	if (!prog || !prog->aux->attach_btf || prog->aux->dst_prog ||
+	    (prog->type != BPF_PROG_TYPE_TRACING && prog->type != BPF_PROG_TYPE_LSM)) {
+		bpf_log(ctx->log, "struct %s needs an attach target in kernel BTF\n",
+			BPF_FUNC_ARGS);
+		return ERR_PTR(-EOPNOTSUPP);
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
+		bpf_log(ctx->log, "struct %s is not supported for this attach type\n",
+			BPF_FUNC_ARGS);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	targ_btf = prog->aux->attach_btf;
+	t = btf_type_by_id(targ_btf, prog->aux->attach_btf_id);
+	if (t && btf_type_is_typedef(t)) {
+		/*
+		 * btf_trace_xyz has no names of parameters, __probestub_xyz()
+		 * has. It takes void *__data first, which is not in the
+		 * context.
+		 */
+		tname = btf_name_by_offset(targ_btf, t->name_off);
+		if (!tname || !str_has_prefix(tname, BTF_TRACE_PREFIX))
+			return ERR_PTR(-EINVAL);
+		if (snprintf(name, sizeof(name), "__probestub_%s",
+			     tname + sizeof(BTF_TRACE_PREFIX) - 1) >= sizeof(name))
+			return ERR_PTR(-ENAMETOOLONG);
+		id = btf_find_by_name_kind(targ_btf, name, BTF_KIND_FUNC);
+		t = id > 0 ? btf_type_by_id(targ_btf, id) : NULL;
+		first = 1;
+	}
+	if (!t || !btf_type_is_func(t)) {
+		bpf_log(ctx->log, "can't find the parameters of the attach target for struct %s\n",
+			BPF_FUNC_ARGS);
+		return ERR_PTR(-EINVAL);
+	}
+	t = btf_type_by_id(targ_btf, t->type);
+	if (!t || !btf_type_is_func_proto(t))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Name the candidate after the prog's struct, so that the names that
+	 * type-based relocations compare match whatever its flavor is.
+	 */
+	struct_name = btf_name_by_offset(ctx->btf, btf_type_by_id(ctx->btf, struct_id)->name_off);
+	name_len = strlen(struct_name) + 1;
+	a = kzalloc_flex(*a, strs, name_len + sizeof(FUNC_ARGS_RET), GFP_KERNEL_ACCOUNT);
+	if (!a)
+		return ERR_PTR(-ENOMEM);
+	memcpy(a->strs, struct_name, name_len);
+	memcpy(a->strs + name_len, FUNC_ARGS_RET, sizeof(FUNC_ARGS_RET));
+
+	a->btf.base_btf = targ_btf;
+	a->btf.start_id = btf_nr_types(targ_btf);
+	a->btf.start_str_off = targ_btf->start_str_off + targ_btf->hdr.str_len;
+	a->btf.strings = a->strs;
+	a->btf.hdr.str_len = name_len + sizeof(FUNC_ARGS_RET);
+	a->btf.types = a->types;
+	a->btf.nr_types = 1;
+	a->types[0] = &a->t;
+	a->t.name_off = a->btf.start_str_off;
+	a->t.info = BTF_KIND_STRUCT << 24;
+	a->cand.btf = &a->btf;
+	a->cand.id = a->btf.start_id;
+
+	p = btf_params(t);
+	/* a trailing parameter of type void is '...' */
+	for (i = first; !err && i < btf_type_vlen(t) && p[i].type; i++)
+		err = func_args_add(a, p[i].name_off, p[i].type);
+	if (!err && has_ret && t->type)
+		err = func_args_add(a, a->t.name_off + name_len, t->type);
+	if (err) {
+		bpf_log(ctx->log, "failed to describe the arguments of the attach target: %d\n",
+			err);
+		kfree(a);
+		return ERR_PTR(err);
+	}
+	return a;
+}
+
 int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		   int relo_idx, void *insn)
 {
 	bool need_cands = relo->kind != BPF_CORE_TYPE_ID_LOCAL;
 	struct bpf_core_cand_list cands = {};
+	struct func_args_btf *args = NULL;
+	struct bpf_core_relo struct_relo;
 	struct bpf_core_relo_res targ_res;
 	struct bpf_core_spec *specs;
 	const struct btf_type *type;
+	u32 struct_id;
 	int err;
 
 	/* ~4k of temp memory necessary to convert LLVM spec like "0:1:0:5"
@@ -10746,6 +10955,31 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 		return -EINVAL;
 	}
 
+	if (need_cands && bpf_core_is_func_args(ctx->btf, relo->type_id, &struct_id)) {
+		/* the type only exists here, not in the kernel's BTF */
+		if (relo->kind == BPF_CORE_TYPE_ID_TARGET) {
+			bpf_log(ctx->log, "relo #%u: no kernel type ID for struct %s\n",
+				relo_idx, BPF_FUNC_ARGS);
+			need_cands = false;
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+		/* the candidate depends on the prog, keep it out of the cache */
+		need_cands = false;
+		args = bpf_core_func_args_btf(ctx, struct_id);
+		if (IS_ERR(args)) {
+			err = PTR_ERR(args);
+			args = NULL;
+			goto out;
+		}
+		cands.cands = &args->cand;
+		cands.len = 1;
+		/* type-based relocations need the root to be the struct, not a typedef */
+		struct_relo = *relo;
+		struct_relo.type_id = struct_id;
+		relo = &struct_relo;
+	}
+
 	if (need_cands) {
 		struct bpf_cand_cache *cc;
 		int i;
@@ -10791,6 +11025,7 @@ int bpf_core_apply(struct bpf_core_ctx *ctx, const struct bpf_core_relo *relo,
 
 out:
 	kfree(specs);
+	kfree(args);
 	if (need_cands) {
 		kfree(cands.cands);
 		mutex_unlock(&cand_cache_mutex);
diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
index 79e079e907c9..e302feea9ca9 100644
--- a/kernel/bpf/check_btf.c
+++ b/kernel/bpf/check_btf.c
@@ -352,6 +352,7 @@ int bpf_check_core_relo(struct bpf_verifier_env *env,
 	struct bpf_core_ctx ctx = {
 		.log = &env->log,
 		.btf = btf,
+		.prog = prog,
 	};
 	bpfptr_t u_core_relo;
 	int err;
-- 
2.56.0

