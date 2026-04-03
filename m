Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E858028CF6F
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181850; cv=none; b=E1HFsYMbzhPo7FGcLm7/UyGFL1X4K/IbW4HnLshx90IGu5pFJMsSErd2EK8NS/NMbnWniu1Ep3w1BZuPgenCSwwtwuZbYO3kqcWw5gcE0CWdaExeCmUWGmluvGRwiifIYojwaAaVasYOVQkKYM5j2TQmHRwQTwiDyvOp6C0zkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181850; c=relaxed/simple;
	bh=YTOkZcJcf4vK8TJwzxiFjawTdgv/R1IvS0jKkWIS40c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNWPB26GhNhu+GtGpy2vRDrD0cuD2py2aC6SUE1AEaqy+pMtio+YQoI/E0vkPDJo0EFbkyVIJlIXU/R0kLureL3lorQwb2aSioYjec2WgrBfTz13WtmuiK26bjQHT0crJO+yiy+Ur2740TdUZ8ECs0mHbUjcn/4aWUMjWLgw+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgNx6xf5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgNx6xf5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82ce49785a0so663895b3a.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775181848; x=1775786648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wr42noGr+nu4YjsOS5BvofSm1MxVNNZHGeejkW0vdI=;
        b=JgNx6xf5KOcU/rztCnYRQdkNuygtclDOR5P/HCTcJMCWO2rGucqjReWnDqN12rK/8n
         Pn8i0Wa0S7lIpaTtSR2mWPtO6K7QimXyrqnq3zMSPivu8N9ZYkCplRF/7OGBU+ecferg
         nu5SovMRfFY1okLll3eh/aKxx3p4g1xMhbQsRMcuuOE3MHsL98RYznWWULyYgtDJDpvm
         xk67/asOMNiHVU6yzaQQaXZdfM2Euvi+neYbX07ijRx9sNGVTa7sylnWW3X5JwHu4CrP
         +XgS4rJz5jtwWpppsZVZIlRXcNxR9N9CxcH6S1KMrCReL6afJ00VpYeXMym7saUPlVyx
         vL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775181848; x=1775786648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2wr42noGr+nu4YjsOS5BvofSm1MxVNNZHGeejkW0vdI=;
        b=LWZfYfQnqQMz0sf8fa+FOSYKYr1IbEjyYd3EHs/loX+H7ETuhtbNouOKr8mmkENBo9
         YKYTrMMZ2u4hO86q80NsKRj42PZoRQs6iO8aVDhBz2DrU7vK3LjXc5SAIzgM1QWh+aw8
         UoVkC6T/BJD2fXzozbXJbYQkmjMSIyL/BisB2VQwN2r5DfIUtuyuYy462o7M/B2pvsdp
         OcPxdf1dWVfsWv5aD6JcRM0a9wRdPAWrUvLNkZzEVcOYaQTrvY8c9Tv1BnRTVI9YdDzL
         ofEwZjGWJKFaraMWXjUKG0yHhxj/Oz2VjB2z72Iwr2kxhAWXixaPOj2XXgfkCAwAgHZp
         7f2Q==
X-Gm-Message-State: AOJu0Yz1GszlgSocSXrP0ExDuKPuPNCXMSW4loR7xkiiAz/VqhfFg8EG
	aWxqcn3xF/lVPsFDMjvWH82QE3hN+bzYCx3D5uRbSeaH0VIFyMq8pegO/pLgZA==
X-Gm-Gg: ATEYQzxmf95S7R4tQSbIUCqObHaNeTC6Wb+e7yqGbMRqi8jRh3fjApWV3Jb3RhUGS+o
	txp4kyuCIm3+jwq6xg+3HaTpekVkVPcIe9irCIS8xmsnR1K8OPzJvqq9nqZTvPkTmB2a4TeAuF5
	ES+VUBI5RG08mY+0oULABfPxLrwzQgclEVqhos2rDvKhMXNIkfaiLNIrr63x9GjRIqvIcXPAOK3
	pr3/hLLVsNpNTMAoqBI0qhxQGQirgJXNCuc4N8ja2YMyHNqD59wmjGoiOR8zXXxIrNzdIEP0fBG
	udSpdQc+uCHf9R6X7Y7FsOEB71lvp3GNOjVo6WHeTtaxBIQ/gdvAeJcW1f/pMKXZj7if+juhNZj
	vqjnFNa7OJt7tkHTs6ypkdtcyE2eKBuxrb6B1dWDgMOIGYU5xMsF0Tdukq/ddhuUTqzB4xHM3uN
	u5TscicYPX4lGZZRWUmq5OFfAl03cFz1ieLdhUOrLtq/w7Cj989aHSDhzN+k+yM7q3mG72WuRBz
	QKm4zQxmvauc7v8SFaDTzE/kidT65+bCvPp5R3cNSoHXsoaUzhVOEsXKstZoqWzraJIW0F3
X-Received: by 2002:a05:6a00:4fc6:b0:82c:eb46:aeac with SMTP id d2e1a72fcca58-82d0dbc34dcmr1154418b3a.50.1775181847871;
        Thu, 02 Apr 2026 19:04:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3c930sm4442832b3a.17.2026.04.02.19.04.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:04:07 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v4 bpf-next 6/6] bpf: Add helper and kfunc stack access size resolution
Date: Thu,  2 Apr 2026 19:03:50 -0700
Message-ID: <20260403020350.73823-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
References: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
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

