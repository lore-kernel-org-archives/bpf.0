Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789C034F46F
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184282; cv=none; b=i0LqRNsHcHKDULKdMX0rgyHpS1aC46aNZZtE+KwOmh1TA0qTJo36iWnN8G5kxcdUbmkDdxgUrASn7S7QLxuo8/pEYciJjvjhuIz9BfKdxDHDzayq4JCs55u5EHsdkRa0PmI25H7TGKBK5v92k71fbaRoMBWo5bPDG5A2sjCkk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184282; c=relaxed/simple;
	bh=YTOkZcJcf4vK8TJwzxiFjawTdgv/R1IvS0jKkWIS40c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7nVAsKF70KBZHVbl2txKESktClB/Ba2Vuljf6taRigkOdNRKy2LiWQwO7OkQnMICk3IKyjulOzeutkayvrW2tPd+QQIxEJhwPPWCNAXTSrkh6p4hfhcUsoGaAWAr2aywwHxxRh1ySYKMHJAnk/Wtjq8wcQzwq5YIojEb8dcV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0oduGNx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0oduGNx"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82cebbdab08so1106625b3a.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775184280; x=1775789080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wr42noGr+nu4YjsOS5BvofSm1MxVNNZHGeejkW0vdI=;
        b=Q0oduGNxVuoo7d3edcf4GC/BjZ44PMbZxCjpMoN5b64LvR5c3LQwE97ZNpSxh7Co5A
         oDkz/S7B787QksOU1EIx2ldH80nywVeWof+CdWTEv0LA77htUNk0hmWu+g3cvUnrxSfe
         GU+B53XYWOnoE3YcnYS3hBUxLQ1oWfhnOcCY7wregj6XxJ7S8VzaawXB6qU0ooXfgo6d
         DA0SCO8/ebPqaEXt76j5R3BPQ2T5uDyHqSv9qhV9UWhxypBAO0mUvwk5uchMXxGH0ieY
         GOlgUQTQcWjKGnyumEl+dFUXw4bgcrkl5QbH6/vk9JUWxx8YI5pMpif/gpuiUCTLRNfZ
         h9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184280; x=1775789080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wr42noGr+nu4YjsOS5BvofSm1MxVNNZHGeejkW0vdI=;
        b=J8bdbWigxYxUFZCheMeH6phZJr8xGR9E4+uZHzhHGXd65rVsrezXsgiKw+sZdJnVpy
         HzMakA0kzgJfk+gIS12dGFyaPHge74sCg+5Hrn0M0pGQfiRQ3zLJPPgD4PxgL2Y3rJ10
         EF+LJl/H4PWHGF52qqUzLy/U9AEnYtYXqNjPuhMP39yz9Lat10LNm9RXPtazcabNSikR
         Exf4lNrvcpee3gkpGIHp5sNiqeUkDbymjOUTh4Ma4vaWBPCJqO3PgWqu2IVNQi2HenSC
         ESaWoJTxybXZFrrXXCM7q1Yt08iC4rZjdkGSmDUXoscgKR+DmNI8huHs4ZEwD8FQohDj
         uexA==
X-Gm-Message-State: AOJu0YxQmVzkVOTCINctH9DuwTPwAZtbDCUsl8qyUupn7aZoI7bqslGO
	uR+Yhvg7z2ln/eSJsVgpWsqwFkRXrmE6XrnX43sq8YbkGdtfEcEN80A1rSvUiw==
X-Gm-Gg: ATEYQzwDWoAyU3V0m/kqnbUUOxFNtCGP2x7maaWYIUL/Vxp/erAgPw/YbkucB3bk6zU
	30E8zlfs9ESPRJZ4pIpFnKFij+ytWplbxj08ptGQOiBppm4AimHVYygAdknlj7oneQ9k+hswe8v
	it0MU7KKoy7T7xS0Bn49FuQBuGYwEOTWHMaB2Ct+Fnbw4O+8WSNGEvIFbYJG8v0QUy9FW3b18aj
	x5WXW6vu0XVX3Q1WkuJjNlhkR6FGWVoQWE9oJBNiObs9QWcgXIIiMIVpx2KlkrsfD9O1e0ukFq6
	AWExOIdp1GYEveMR3EFtTwo2lkdEJ0QTc2tiGSjAQNUQWt5AdZ0uwZ+VZXfs88+7sgWVX8nzyCm
	wgWIIYK0rDxCe7wjuFkO2cTqx+vXrdhIM1kso79MLGDSYbzJiJEAkM9ih6unvYZkjE7gGC1hvZU
	3RAe6RBwJihZ+fWTu5867S9g8EjpbUHzUhBUaqcIVaO2S1AsxwNIviXKGKfxDHU79AOlHaKDF8I
	4FF4G+qH3PCC7T+Nv3cR7xxEdmvHm0b612jQdXMB4bpdGc6Jw2JNw7RHURz7Q==
X-Received: by 2002:a05:6a00:1ac9:b0:82c:e3f4:f5e9 with SMTP id d2e1a72fcca58-82d0da7d403mr1318691b3a.18.1775184280543;
        Thu, 02 Apr 2026 19:44:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm4628603b3a.38.2026.04.02.19.44.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:44:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v5 bpf-next 6/6] bpf: Add helper and kfunc stack access size resolution
Date: Thu,  2 Apr 2026 19:44:21 -0700
Message-ID: <20260403024422.87231-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
References: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
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
index 76f62c8907bf..30e4a970c826 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1136,6 +1136,12 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn);
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
index 7ab1c174287c..6fce668a63fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14089,6 +14089,194 @@ static int fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
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

