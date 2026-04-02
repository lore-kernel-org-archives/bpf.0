Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA24273D6D
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110684; cv=none; b=O7zuCfl0HwH0iL12AmE5I7GgQa3bOKdWfH/jyyyXv7jxC5mZw5HAzxu2lJkKHq6Z2XizMg2qOqbkBBK1r0lFdkzqApdLITLTqg0T0/0VnILRlRPq1IBT49dESrwz58ic2/aHeu2W3sEVcE0/+E+57yDbc0+2FYWUBVAKIJl5qFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110684; c=relaxed/simple;
	bh=uPDvUrhzz7VN43Xcrtkw0ok7kUmz5NU2Zsh76VOcMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xi8NI9kBI6WoVIIqOG5QCrR6NHh6T0jqy70Zg9V8dqkB+P2HSDPE/Rh9rNFXl/xbR4ULwdAF89fewmtHHNRBpWUdaiQGdx1LxQB2ke3qjcD/wRHFciQKpHPBuvDrJh0hjlGVJaiF/+G7tNVpedMJ7C0Pe1fKnRTqpWcoT5WED98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Af4O2whd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af4O2whd"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82c68339cf0so1056233b3a.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775110682; x=1775715482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXUdqTnatMBSv6Qtt7N79CuMWGMQoV7dJ3xziJxnkZQ=;
        b=Af4O2whd+yYYOauaMjD0Rj68tp0adtx5INkb3axbXRc6YgSEAMb5d27cht/4pjpFW6
         l+EvcDZRiZCyW5Mn7ImXWaXsmkracuCwqG5Vm23y0QmHMczfgZzyMmOzF9AJ6flwIILw
         GOQ4aYEVHnoSvI4f+ohbjsJCqRSZWDKzb1n0nlOgD1u3UFNaU0W5+ZIYLB68423LE/FC
         B57A+wmYagKdFl8MqkTzsYmSbOQBYmGeYJ8wjlNmQFL1wGumqr0sxtCoKPgR/GvtbP9T
         2R6KzBLkNydDT0ItVjrlraGv/VbPkl7P0w9Na7pGmjNBUcp/WQtOWBj54N9QDQK+QLpx
         3pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110682; x=1775715482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXUdqTnatMBSv6Qtt7N79CuMWGMQoV7dJ3xziJxnkZQ=;
        b=kvACEr9hTvfqQumzPLS9Im2YG7py71XCZq827ztJ1C4YPRPLv+ALFNnssABrWhlaRn
         OwlVLai1jACHrWH+jktJuAEc0m43jDg9kfpcX8zj+3bDgmDH1Nunmve7S7rS3U3x/6sf
         qvEYPLrfnPjMqSfZi3niIltsoOl+ch0XjSVikI5zIrvqk+yTUw7uIbWumMOBhuO5FWSo
         82zeOh7gPH7Qz/l/Wz/793XkHYdE1+rZXAXmCzDCFgHt/QxMzdhD+VxA7tlG0ir4evZU
         Z4237CCfnFBjI696y1HHPQFknzW6TVE23tGaz8NX0mdpg/7z3J0VYIFzrHfyH/uOvuMH
         2xxw==
X-Gm-Message-State: AOJu0Yx0iNBmUmcyVrfFSh8Qpkx0P/eBBJi7fdhMTWowEGDxBohsEYln
	Jkfg7UlkCSI+KbWsWrTZmu5e6FbUY0aQ9HhCbX37rvyYHavq3WFh06dBfyDckQ==
X-Gm-Gg: ATEYQzzwFSaIKueB0ALPn58/3umqtm1zhz10jG1j3DpBzaExx0cFS9Pp92S4VOdZ7X7
	GYXqtfV4l7AI2li5DiTD01jADeOj4cb2/5IIW0gGmr49/2/UR2eFoRpZ8/R2ioME3fJjIIvJ8zS
	wxvJtb5w0Q8aE2fZHWFtra0ySRYaV85zRGmrUyoDhgm8fG3wP52dI8dxpbEjRCCph7Q+jvZy5aM
	Efvnwpo3VGcBlkyNPIzOmu1uz5pWIMPGf/L5cEjugg6oRbvfIT71Aos42U423EYs6KhI9HCW4Tl
	swYIYn7B0noW9x1yUA1KdaC/Kcyqw7tNucNi2DtBN7CEx+erEjQBviIjiCUbRlpphjWQMsCEUxY
	TfljbYGaIwodrMmcaI2napJj/TPQ+KN/6Nbi2Lmsp4l3dJdt4/OQ9Bi5Ad8RWoMPidGL+QMH5Yj
	/TO1L20nDEsJegmJdcQvP6bnerz4w/x2xWQkj5mtKs5Aw+2FpG0xmo1ceyuYcx3EQ7lnhR4or9w
	TpRE5o6Q9ptqhyTt3gGHmuVRSJQnXyxASIEfW2i0OzgpDSTvJmIJVtatqF6cJiTQx9xS36g
X-Received: by 2002:a05:6a00:2d8c:b0:7b8:acdd:23c3 with SMTP id d2e1a72fcca58-82d002350f5mr1251394b3a.11.1775110681608;
        Wed, 01 Apr 2026 23:18:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1f28sm1911341b3a.57.2026.04.01.23.18.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 23:18:01 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 6/6] bpf: Add helper and kfunc stack access size resolution
Date: Wed,  1 Apr 2026 23:17:44 -0700
Message-ID: <20260402061744.10885-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   6 ++
 kernel/bpf/verifier.c        | 188 +++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 1a7349d3af9c..475e73174c54 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1137,6 +1137,12 @@ int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			  struct bpf_call_summary *cs);
+s64 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env,
+				  struct bpf_insn *insn, int arg,
+				  int insn_idx);
+s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env,
+				 struct bpf_insn *insn, int arg,
+				 int insn_idx);
 
 int bpf_stack_liveness_init(struct bpf_verifier_env *env);
 void bpf_stack_liveness_free(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2a5d862a82db..bca8129fd1ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14080,6 +14080,194 @@ static int fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
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
+		if (!val)
+			return S64_MIN;
+		size = val;
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
+			 * Size arg is const on each path but differs across merged
+			 * paths. MAX_BPF_STACK is a safe upper bound for reads.
+			 */
+			if (at & MEM_UNINIT)
+				return 0;
+			return MAX_BPF_STACK;
+		}
+		return S64_MIN;
+	case ARG_PTR_TO_DYNPTR:
+		size = BPF_DYNPTR_SIZE;
+		break;
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
+	if (at & MEM_UNINIT)
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
+	if (is_kfunc_arg_dynptr(btf, &args[arg])) {
+		size = BPF_DYNPTR_SIZE;
+		goto out;
+	}
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
+		return MAX_BPF_STACK;
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
+	if (arg == 0 && meta.kfunc_flags & KF_ITER_NEW)
+		return -size;
+	if (is_kfunc_arg_uninit(btf, &args[arg]))
+		return -size;
+	return size;
+}
+
 /* check special kfuncs and return:
  *  1  - not fall-through to 'else' branch, continue verification
  *  0  - fall-through to 'else' branch
-- 
2.52.0

