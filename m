Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8EC372ED7
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570423; cv=none; b=QE2v1VMgSoR5S28xogmUH5K22pITRH5WVmrCznrqqz2/CsLScP/bL8almZZSjBF1LQhq2mKOCiNX794Nr7s8S1t0t7ZZelYg7pjmoIYvEMpqKlGRey2CF4CAYsx29L1xmcp+aezcIw/XlNtQu7IFl6c1d8JM36LkJK6tu/uKgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570423; c=relaxed/simple;
	bh=8sWzBneNGlvr1dqXJxaQU8n3D8b8+QzAQwQ17Iv8fmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbebXZ+pBarcPEBrUDevhzMkup4PJjl1fk9rUlE1bzUjHy7sWGXEGtdr+USwiu2Cl2LdRVQKY2+06OyneqaXXNu990KYNvnGNLhA33o6MmRYiNlTtqc4UvKEKXGT3HLLC+hVy2yExZKABT6MhNV+0yejTTM0UPWmgIiLYs8LBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYA9kO1y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYA9kO1y"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceb096e675so21553855ad.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570421; x=1786175221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HBmBbQI9Gz8AA10S9H1W7QAQzqqpZwrEykKtL7Ucw9M=;
        b=VYA9kO1y/6oQBcCI8Y1qi/BxV4oHQCrqdkTRIYqFMWi9pImSfFYvqmFhNvBfU5sqXA
         SzrRgKHLs5tOPIT+czG7eQh1X5DytMUTHFPPf9FLcySFuteOJRW03T6MyVu8w6EES8uu
         ARoR1UpjfR6u/71DC27Xo3Fpyv0YfFGY5csfz+aeeCeaEW4LKLChV5tsM8SM3ACRKfUR
         UW6AQpLo1w2G+JvU7514jwFYSbBbYzEdrOOm/yq1cjdc+RLkNudVpCsMUlDZCfvXCVYn
         O1dfuhfC6H3NGalHsIqkblIv2UbVQKbEo8Tq0oM55b+gBi+n4AyVm1Xs26Z4BXeFcBu1
         K9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570421; x=1786175221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HBmBbQI9Gz8AA10S9H1W7QAQzqqpZwrEykKtL7Ucw9M=;
        b=tBe54XKl8x73/7IpFQwl+T1vnra27S1nwjsX4Z7WO+dvLO3Z0g4LohnxJdPlpDPDD3
         I1p6qmfPYSYAWUUokkorn4vJzRQxNpAHAF8fKtTk87tJm/7XEkEFhjXrseUhw2SxnGMh
         zzkHH21FtbudFpKIIPBKIVc2FxqDWZulw+uyGCvvXVD4sFajbKunIrQfmJEqOcJ697Sc
         XoOBnv1of3P6TDwPmAtYZd5ubZaCTwsYU33b+CzAKTf69pRflDGKnWooNOBnUPpOkpNs
         whtW2HD2kWTlIOZur+5HFKgDm+oAaieal++8TZSzILL85gr2JJ94IxRF9RjJIc4bvaAP
         LXKw==
X-Gm-Message-State: AOJu0YyJZRDl57gvSd7Jg22io50FCCVfNnv8pNIM4K8uLnwYu1/tllzi
	RnS7g1Qs3WHz0g/N0Fd7ogF6rdsZm9vam6BXG5GVlXvBPIiWNPEa+ZQGEmj1lg==
X-Gm-Gg: AR+sD1204/6fIg5Gr+E9UIMeKMUlWkxTqoMqr/nHCp7If0Ht+zzu6NPkEvS9JKchMBY
	zf26NKz/4CoTHpAPhy9cIBZGzNOV6PEywAYX51tyWO9mRB2nobU5u411WqO1jFmnHY8d26B2jIz
	cQubJqW4lCCSHwQWOqLJqccaNwMLLhlcII0JAtGwzXoLQ/kTs5GJqgGMOflfjIBTfahoXAoHDua
	kSvT4r+BqCYiTO7f6M/e4qCOPSO4j1VbobWZKZ9U+X3ufSMtNrfyrunJchxOByrUTcHtMhS+kYS
	0AOj8LStmWJZ+2aCNlEte5XtjeomnmTnuptuAcNIB6V75B7ss8ia548r15kUMHh8hb5RNeVlEbO
	CFPEF0pwPsm8HJvz9oO9S5ZP0ko2J+qq085O0wVWsg/vn9rul0Iln4nYuKLLdM+PutBTPr2DlGl
	x3WjY/yR1CJE3ENEynQJaxHNyrFHEnqAiX3ktPfzAH4udjAvkYSpk=
X-Received: by 2002:a17:903:37c4:b0:2cf:7f6b:8c8a with SMTP id d9443c01a7336-2d05229a183mr29499985ad.30.1785570421543;
        Sat, 01 Aug 2026 00:47:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:57::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b15d27asm14941455ad.78.2026.08.01.00.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:47:00 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 16/18] bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL
Date: Sat,  1 Aug 2026 00:46:31 -0700
Message-ID: <20260801074633.1595644-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that get_kfunc_ptr_arg_type() classifies a kfunc pointer argument
from its BTF alone, express a nullable argument by OR-ing PTR_MAYBE_NULL
into the classified type, and resolve a NULL register after
classification instead of before it.

Previously check_kfunc_args() short-circuited a nullable argument passed
a NULL register with a continue placed before get_kfunc_ptr_arg_type(),
so the NULL never reached classification. That kept a register-state
decision (bpf_register_is_null()) ahead of the BTF-based classification.

This mirrors how helper arguments carry PTR_MAYBE_NULL in their
bpf_arg_type and is a step toward describing kfuncs with a bpf_func_proto:
the nullability now travels with the per-argument classification, so it is
captured when the prototype is generated at add-call time.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 147 +++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 80 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ac117edc118c..4e3759f7ba68 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11353,98 +11353,85 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *m
 		       const char *ref_tname, const struct btf_param *args,
 		       int arg, int nargs, argno_t argno)
 {
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
-		return KF_ARG_PTR_TO_CTX;
+	int arg_type;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
 	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
 	 */
-	if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
-		return KF_ARG_PTR_TO_CTX;
-
-	if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_ALLOC_BTF_ID;
-
-	if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_REFCOUNTED_KPTR;
-
-	if (is_kfunc_arg_dynptr(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_DYNPTR;
-
-	if (is_kfunc_arg_iter(meta, arg, &args[arg]))
-		return KF_ARG_PTR_TO_ITER;
-
-	if (is_kfunc_arg_list_head(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_LIST_HEAD;
-
-	if (is_kfunc_arg_list_node(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_LIST_NODE;
-
-	if (is_kfunc_arg_rbtree_root(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_RB_ROOT;
-
-	if (is_kfunc_arg_rbtree_node(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_RB_NODE;
-
-	if (is_kfunc_arg_const_str(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_CONST_STR;
-
-	if (is_kfunc_arg_const_map(meta->btf, &args[arg]))
-		return KF_ARG_CONST_MAP_PTR;
-
-	if (is_kfunc_arg_map(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_BTF_ID;
-
-	if (is_kfunc_arg_wq(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_WORKQUEUE;
-
-	if (is_kfunc_arg_timer(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_TIMER;
-
-	if (is_kfunc_arg_task_work(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_TASK_WORK;
-
-	if (is_kfunc_arg_irq_flag(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_IRQ_FLAG;
-
-	if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_RES_SPIN_LOCK;
-
-	if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
-		return KF_ARG_PTR_TO_CALLBACK;
-
-	if (arg + 1 < nargs &&
-	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
+		arg_type = KF_ARG_PTR_TO_CTX;
+	else if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
+		arg_type = KF_ARG_PTR_TO_CTX;
+	else if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_ALLOC_BTF_ID;
+	else if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_REFCOUNTED_KPTR;
+	else if (is_kfunc_arg_dynptr(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_DYNPTR;
+	else if (is_kfunc_arg_iter(meta, arg, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_ITER;
+	else if (is_kfunc_arg_list_head(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_LIST_HEAD;
+	else if (is_kfunc_arg_list_node(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_LIST_NODE;
+	else if (is_kfunc_arg_rbtree_root(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_RB_ROOT;
+	else if (is_kfunc_arg_rbtree_node(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_RB_NODE;
+	else if (is_kfunc_arg_const_str(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_CONST_STR;
+	else if (is_kfunc_arg_const_map(meta->btf, &args[arg]))
+		arg_type = KF_ARG_CONST_MAP_PTR;
+	else if (is_kfunc_arg_map(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_BTF_ID;
+	else if (is_kfunc_arg_wq(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_WORKQUEUE;
+	else if (is_kfunc_arg_timer(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_TIMER;
+	else if (is_kfunc_arg_task_work(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_TASK_WORK;
+	else if (is_kfunc_arg_irq_flag(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_IRQ_FLAG;
+	else if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_RES_SPIN_LOCK;
+	else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
+		arg_type = KF_ARG_PTR_TO_CALLBACK;
+	else if (arg + 1 < nargs &&
+		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
+		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
 		if (!btf_type_is_void(ref_t) && !btf_type_is_scalar(ref_t) &&
 		    !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
 			verbose(env, "%s pointer type %s %s must point to void, scalar, or struct with scalar\n",
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		return KF_ARG_PTR_TO_MEM;
+		arg_type = KF_ARG_PTR_TO_MEM;
+	} else if (btf_type_is_struct(ref_t))
+		/* A pointer to a struct without a size argument is classified as KF_ARG_PTR_TO_BTF_ID */
+		arg_type = KF_ARG_PTR_TO_BTF_ID;
+	else {
+		/*
+		 * Otherwise this is a fixed-size memory buffer supported by
+		 * check_helper_mem_access(): a pointer to a scalar or a struct of
+		 * scalars. The access size is derived from the pointed-to BTF type.
+		 */
+		if (!btf_type_is_scalar(ref_t) &&
+		    !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+			verbose(env, "%s pointer type %s %s must point to scalar, or struct with scalar\n",
+				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
+			return -EINVAL;
+		}
+		arg_type = KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 	}
 
-	/* A pointer to a struct without a size argument is classified as KF_ARG_PTR_TO_BTF_ID */
-	if (btf_type_is_struct(ref_t))
-		return KF_ARG_PTR_TO_BTF_ID;
+	if (is_kfunc_arg_nullable(meta->btf, &args[arg]))
+		arg_type |= PTR_MAYBE_NULL;
 
-	/*
-	 * Otherwise this is a fixed-size memory buffer supported by
-	 * check_helper_mem_access(): a pointer to a scalar or a struct of
-	 * scalars. The access size is derived from the pointed-to BTF type.
-	 */
-	if (!btf_type_is_scalar(ref_t) &&
-	    !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
-		verbose(env, "%s pointer type %s %s must point to scalar, or struct with scalar\n",
-			reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
-		return -EINVAL;
-	}
-	return KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+	return arg_type;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12132,14 +12119,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		ref_t = btf_type_skip_modifiers(btf, t->type, &ref_id);
 		ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 
-		if (is_kfunc_arg_nullable(meta->btf, &args[i]) && bpf_register_is_null(reg))
-			continue;
-
 		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,
 						     args, i, nargs, argno);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
+		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
+			continue;
+
 		if (is_kfunc_arg_map(btf, &args[i])) {
 			ref_id = *reg2btf_ids[CONST_PTR_TO_MAP];
 			ref_t = btf_type_by_id(btf_vmlinux, ref_id);
-- 
2.52.0

