Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE62FFDDE
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009816; cv=none; b=uMsDmFZ5OV00jTsuVjyQehMm3oOFWaZViwqqJwwManf0zygqXeItPMuotSQ2rJFVxDlcGD+SaZMvt99/3VV89q+zQq4Vhy7imYvsK2z7TkCnmd5XjT6RJTpP2P1pr+dwwZn3Eer4KGrvrO7YFCd4Ey1aydwRg/0WBgxaKyGK9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009816; c=relaxed/simple;
	bh=1gu+jLALcgbbVUJ8WWnrNqnEiRDt0rBwnNch/GZpEO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYVKWpGMtQ4ZHgTx75Hw0dJVT5KQJ2n2adpn6fjQ+v2iuV1ro12DC5kEOvHSjnsV6DEyufe35zzqJmmDRCU5/4GG1Xlm9yC+hFY7rzmBmI4PfxefJiBqVbsvnyLAO84UYmE2BeStQyFiVKNhPM9T3sJpZArZnZ24d5ZhbLZeS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luow41Qh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luow41Qh"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so14164535ad.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009814; x=1775614614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KY8FF2vNKYP/b/w0s75/9c6wrKKa8EvjhQo+6L4l0I=;
        b=luow41QhJtYg0T6pMonvmH7fapxUQFQvC1O+P9kRnAL9NCJkIXnGjkxqb3lh9TW60X
         QCyaUpfSOp+knf3Iz6o5JOKgqBnOq9mrshQH0RvAI+7J49NanVlk2E8ini4He+chI3ZI
         6Nq6FHqOlBagJwAT9+12J8CSpB8nRTfinVqA1F1kOhIJge7zS6rTCmoPxwzCopQ0Wl+z
         9S2vpWZ7N+g4NWo3ppP5OU7kDiQq5wPm/oXeAptYJ7FYo0oEqO1Cb2oXaRXiVqekau16
         e0NguJlxBYa6IXpUvPgQMs2Uoe8/nMsewf7qdQFz9ujpdJP7Rpyr9thT41/9HqjStaNS
         2N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009814; x=1775614614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2KY8FF2vNKYP/b/w0s75/9c6wrKKa8EvjhQo+6L4l0I=;
        b=jqPT7Ml/P+ykO5TKHQHHTKXxoPBC0u9SSJ4PXTN2zlDliawyB+V0LdD0UiqppiZhiE
         fsc5LFMZWMehROD1BJXaqfNAnKXEk1UMmtqz9MEnxZ13sClxOE6pAhWI/Ps7BAdnmJ+H
         JwJndZssSp6EAWjOp0stF9LO2xxj7erRHHP8gzs8SDzMrXk2BXIbr0+oAK2SlQStBRb/
         em9g7A8Cg3O0fVt9o+fZUU6gSTCDSMvWGvlBUa4z15wuxWCUalEfTiLGoiwXbFOsXm36
         QbVaAgvTsX/vG0qM5Hg+cJOyufhC2CcXzPmzH02Vk5WuBpvrUjrUvsZuZOC/pXw2KkIV
         K1EQ==
X-Gm-Message-State: AOJu0Yyl0N5ke7D8VOBpiXrq6yx5vrrjnlUueLif6UFnkRJYVxoteGn3
	uElanfPaMtP0/PMlyjlQYiKz8UMzYBR6OCDnI1zQWi8Y2DAqETPPkZZxa+yjtw==
X-Gm-Gg: ATEYQzweVy35P5DdrastzRNOGOQrl30g6bLkgo6aN3CeKMQ78A6OojvESPYcRG3F5NV
	buXuqDd3H8YZ9rUPtGbIxXzkKXMMTUSPKss2c19MVDnKrw8XlHXapbJrcFdnzZXCJ3YRYXS3sKR
	i3qjVWgfKsJbsFqXSzkc6DZhAMpCcsVJQazf6CoHgM6zl9IoPZ9YjLNMCQANcEbf6q+RlHHZLrY
	eiRRxyty6SJlvAUmlTdsKT0m7smSX4bYJxREwUUP5wJJgaZaf28W/7+qBbL+j8qZ73Mqo0Zblbp
	bN08qViTTPUC3/gZmuOQMq2YQa7WZ8ClFACXpvuUmMNb5FrwRqX2Vb8LjU8BMbf0s3IeGKr+zxU
	ATduksBJedmUVpa03sPaP2hrkSmrmWkkNboqCROl+rsFrfJcGFsNvwuO3oPXa99OxzE8J1SY/5k
	EpSYVxL9FqQhFb+9+cdR6POBmOlWfLEatuFA6EICjrNnFVTK8J6mrHSfX8PC2KcKoSp/meOmNus
	SzE6IiXZkX7rBJyRwSU9bu0LyLymXa6GAl+JsO0BsCn2+ohjZcRjgbntjKnRQ==
X-Received: by 2002:a17:903:390c:b0:2b0:c0a8:5000 with SMTP id d9443c01a7336-2b269ab31a9mr15975125ad.14.1775009813724;
        Tue, 31 Mar 2026 19:16:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242643381sm137453315ad.5.2026.03.31.19.16.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 19:16:53 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 6/6] bpf: Add helper and kfunc stack access size resolution
Date: Tue, 31 Mar 2026 19:16:35 -0700
Message-ID: <20260401021635.34636-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The static stack liveness analysis needs to know how many bytes a
helper or kfunc accesses through a stack pointer argument, so it can
precisely mark the affected stack slots as stack 'def' or 'use'.

Add bpf_helper_stack_access_bytes() and bpf_kfunc_stack_access_bytes()
which resolve the access size for a given call argument.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   6 ++
 kernel/bpf/verifier.c        | 181 +++++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3fccf61afbc8..c1e8e970f756 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1138,6 +1138,12 @@ int find_subprog(struct bpf_verifier_env *env, int off);
 void verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 		      struct call_summary *cs);
+s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
+				  struct bpf_insn *insn, int arg,
+				  int insn_idx);
+s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
+				 struct bpf_insn *insn, int arg,
+				 int insn_idx);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 88285fae21fa..e5424fc0669a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14080,6 +14080,187 @@ static int fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Determine how many bytes a helper accesses through a stack pointer at
+ * argument position @arg (0-based, corresponding to R1-R5).
+ *
+ * Returns:
+ *   > 0   known read access size in bytes
+ *     0   doesn't read anything directly
+ * S64_MIN unknown
+ *   < 0   known write access of (-return) bytes
+ */
+s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				  int arg, int insn_idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+	const struct bpf_func_proto *fn;
+	enum bpf_arg_type at;
+	s64 size;
+
+	if (get_helper_proto(env, insn->imm, &fn) < 0)
+		return S64_MIN;
+
+	at = fn->arg_type[arg];
+
+	switch (base_type(at)) {
+	case ARG_PTR_TO_MAP_KEY:
+	case ARG_PTR_TO_MAP_VALUE: {
+		bool is_key = base_type(at) == ARG_PTR_TO_MAP_KEY;
+		u64 val;
+		int i, map_reg;
+
+		for (i = 0; i < arg; i++) {
+			if (base_type(fn->arg_type[i]) == ARG_CONST_MAP_PTR)
+				break;
+		}
+		if (i >= arg)
+			goto scan_all_maps;
+
+		map_reg = BPF_REG_1 + i;
+
+		if (!(aux->const_reg_map_mask & BIT(map_reg)))
+			goto scan_all_maps;
+
+		i = aux->const_reg_vals[map_reg];
+		if (i < env->used_map_cnt) {
+			size = is_key ? env->used_maps[i]->key_size
+				      : env->used_maps[i]->value_size;
+			goto out;
+		}
+scan_all_maps:
+		/*
+		 * Map pointer is not known at this call site (e.g. different
+		 * maps on merged paths).  Conservatively return the largest
+		 * key_size or value_size across all maps used by the program.
+		 */
+		val = 0;
+		for (i = 0; i < env->used_map_cnt; i++) {
+			struct bpf_map *map = env->used_maps[i];
+			u32 sz = is_key ? map->key_size : map->value_size;
+
+			if (sz > val)
+				val = sz;
+			if (map->inner_map_meta) {
+				sz = is_key ? map->inner_map_meta->key_size
+					    : map->inner_map_meta->value_size;
+				if (sz > val)
+					val = sz;
+			}
+		}
+		size = val ?: S64_MIN;
+		goto out;
+	}
+	case ARG_PTR_TO_MEM:
+		if (at & MEM_FIXED_SIZE) {
+			size = fn->arg_size[arg];
+			goto out;
+		}
+		if (arg + 1 < ARRAY_SIZE(fn->arg_type) &&
+		    arg_type_is_mem_size(fn->arg_type[arg + 1])) {
+			int size_reg = BPF_REG_1 + arg + 1;
+
+			if (aux->const_reg_mask & BIT(size_reg)) {
+				size = (s64)aux->const_reg_vals[size_reg];
+				goto out;
+			}
+			/*
+			 * Size arg is const on each path but differs across
+			 * merged paths.  512 is a safe upper bound for reads.
+			 */
+			if (at & MEM_UNINIT)
+				return S64_MIN;
+			return 512;
+		}
+		return S64_MIN;
+	case ARG_PTR_TO_DYNPTR:
+		return BPF_DYNPTR_SIZE;
+	case ARG_PTR_TO_STACK:
+		/*
+		 * Only used by bpf_calls_callback() helpers. The helper itself
+		 * doesn't access stack. The callback subprog does and it's
+		 * analyzed separately.
+		 */
+		return 0;
+	default:
+		return S64_MIN;
+	}
+out:
+	/*
+	 * MEM_UNINIT args are write-only: the helper initializes the
+	 * buffer without reading it.
+	 */
+	if (size > 0 && at & MEM_UNINIT)
+		return -size;
+	return size;
+}
+
+/*
+ * Determine how many bytes a kfunc accesses through a stack pointer at
+ * argument position @arg (0-based, corresponding to R1-R5).
+ *
+ * Returns:
+ *   > 0      known read access size in bytes
+ *     0      doesn't access memory through that argument (ex: not a pointer)
+ *   S64_MIN  unknown
+ *   < 0      known write access of (-return) bytes
+ */
+s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
+				 int arg, int insn_idx)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+	struct bpf_kfunc_call_arg_meta meta;
+	const struct btf_param *args;
+	const struct btf_type *t, *ref_t;
+	const struct btf *btf;
+	u32 nargs, type_size;
+	s64 size;
+
+	if (fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta) < 0)
+		return S64_MIN;
+
+	btf = meta.btf;
+	args = btf_params(meta.func_proto);
+	nargs = btf_type_vlen(meta.func_proto);
+	if (arg >= nargs)
+		return 0;
+
+	t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
+	if (!btf_type_is_ptr(t))
+		return 0;
+
+	/* dynptr: fixed 16-byte on-stack representation */
+	if (is_kfunc_arg_dynptr(btf, &args[arg]))
+		return BPF_DYNPTR_SIZE;
+
+	/* ptr + __sz/__szk pair: size is in the next register */
+	if (arg + 1 < nargs &&
+	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
+	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
+		int size_reg = BPF_REG_1 + arg + 1;
+
+		if (aux->const_reg_mask & BIT(size_reg)) {
+			size = (s64)aux->const_reg_vals[size_reg];
+			goto out;
+		}
+		return S64_MIN;
+	}
+
+	/* fixed-size pointed-to type: resolve via BTF */
+	ref_t = btf_type_skip_modifiers(btf, t->type, NULL);
+	if (!IS_ERR(btf_resolve_size(btf, ref_t, &type_size))) {
+		size = type_size;
+		goto out;
+	}
+
+	return S64_MIN;
+out:
+	/* KF_ITER_NEW kfuncs initialize the iterator state at arg 0 */
+	if (size > 0 && arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
+		return -size;
+	return size;
+}
+
 /* check special kfuncs and return:
  *  1  - not fall-through to 'else' branch, continue verification
  *  0  - fall-through to 'else' branch
-- 
2.52.0

