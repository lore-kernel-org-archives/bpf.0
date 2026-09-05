Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0F14A619
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645692; cv=none; b=nsKm4Q+zPIYSgWSk/TwYiMobJlopmaFXRhfGnhkhNs530Hp6VHzsKP99RM5Fo7e0sqnF5mf7HqiMEMMq0Dqh2fGUyzmnSfggAu4BdQTyS7sTIPDIgouJ/4whF1OPYXKL2BtsVLSQTJYeJiXvWdl+aB1zXPrgFdkXqaE1RjkZB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645692; c=relaxed/simple;
	bh=RLuKb6bt1C0iuaLrYyaL3vXxKXB89uHNMn8BgkXEQM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi2VRvbmwrdj/8qsMg5eMajqR4L1lHYS+evfULiGb0iJag40773F1+016+/M9SJI0NP6YaqgcZUwCVRaMLBNaOM+JvX1InhEeT4GkyC6tyd/iF3aw36WRKdq0gET6pDpeb0uk6CqMjUPmIP9Adu5sRT2UboC89QkPQZkoeCkJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+M81LWs; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+M81LWs"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f4f53975e6so2150633a34.3
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645688; x=1789250488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SjxjIZqfSEQnSVC4ZeTixhrnlNF8Cnn2nVzrruaCvlo=;
        b=L+M81LWsFU+DzQ+GVRAzZsihA1fTufqOa7e1la6FceDiaZn0UcGhzMseHlQiAQ3c9w
         3qA6t14fDBR6mqcABbLWxHAdnxLKe4cdodkNAEaJuw1+y3VVX3r6PrLKzxMn1uamg6b5
         ourTBU/NO3kz3IoLhwYsQ9r0AA01Pyh3PFQT7GHJY4cfArWRhl/R1kJBTPRwj5ACdxQS
         wFfjGM3mx53UDaPXZQMjbh98KCxuocZNoNTIENMa+LDaIoOW6QvY7Zsb2ERv1x48cgLp
         /MfGtxoUqBUmMw5OuUQi87ehvsqHOp4FeTP5fobhu58GNSUFghjvcUJ9DhD2xyNX/Yj1
         6VnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645688; x=1789250488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SjxjIZqfSEQnSVC4ZeTixhrnlNF8Cnn2nVzrruaCvlo=;
        b=VW3b/ZXa2epCOSRxCCWjn8FOxpEnvrybRC6gsT/sH0TVyHAIXb3PvDUJTIUM4TW0/z
         8eTAleGx1dM9gzCusRMysMltrKXj6vllVfGcHdWJw2CtJPkNQRynoqBpXHiTn+u6m1ND
         3J+mb1q+Ih6ZS8rAL68EGpHnDQQdX8nwqMRPi/e4MexE/oOH3ivA0aaMKvP/omv4VkjO
         Qzvk6BebSVVcMPet2dvnBvvCMDb+YliBrJ/nW3x367U2WPyZSqYCOwq/R0rvD2Gs801u
         hkQXH+CIm/GXuQolE6hDgYIemcyIERTI/Ub7S0P6mv/VQgEzdAp1ojMzlbuUFnD4Fd1T
         dvDA==
X-Gm-Message-State: AFuF++kj8JNeQGGqKrHGB5DxFW8tFKi0U3oLEe4VED7DqaPsesI2hI2c
	440WK4DEoKspH5LZBpKzVdSRS84MkuxwpHpEmKMesQcMD8pkLZInqkMiiMZksw==
X-Gm-Gg: AYBFou2l3MOJJTSctkbKPyEJO3WeXnB6p5gTWhlOWqX+2tl64LwE0r80OXVJftiF/oM
	le69nYh/Z3i23T2XFTW6XNXFnEod1n9y4hmeY2DcUD1kgNd8nXFQ4ovHvHYfuWDZqSZKlBBc38B
	9c7c0P4EpnNRoiZWCjSYW7wEURQ7KjyozOOBwnGJJlMpoWce8e0RnwClwhP/rxgUNwMIX6CoFBu
	0XETBwJj9G7b6EcsaJFSLKloydZCH5gFx1dHVvBSA+yzVrUzWhjXT9q5G027ihLo0zafYPKwKk7
	RWG+7l/+ZfZUC32KzBwFtf2bQm8EMKxNOrU/8m5YT4eU87t8femPS6KEo2MqOPZcE9QOi/jyqMn
	UVfntTQSepFlKTxvvsGDmRAGUn1vNOkexGk9OwGJwvgbCR1XRnu3FUvyaPxgiULkvrurBsH6hbb
	xVqrfGUpU8qYNVfggg13wc/Nyb5WzwBYOHxey0zMs9a679xRXXUSzwLsrfTYY45w==
X-Received: by 2002:a05:6830:f83:b0:7f7:9017:1ae8 with SMTP id 46e09a7af769-7fa20ac3c72mr11077516a34.15.1788645688469;
        Sat, 05 Sep 2026 15:01:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7bf0086sm7648092a34.27.2026.09.05.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/22] bpf: Unify kfunc argument kinds with enum bpf_arg_type
Date: Sat,  5 Sep 2026 15:01:01 -0700
Message-ID: <20260905220117.922028-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_kfunc_args() classifies arguments with enum kfunc_ptr_arg_type
while check_func_arg() uses enum bpf_arg_type, yet both classifications
are stored in bpf_func_proto::arg_type. The overlapping namespaces force
the kfunc path to translate argument kinds before calling shared checks.

Fold the kfunc kinds into enum bpf_arg_type. Reuse ARG_SCALAR and
the existing pointer and memory kinds where their semantics match,
map kfunc callbacks to ARG_PTR_TO_FUNC, and add enumerators for the
remaining kfunc-only kinds. check_kfunc_args() can then carry one
classification throughout verification.

Preserving the original argument kind also lets
check_func_arg_reg_off() derive the zero-offset requirement for
ARG_PTR_TO_REFCOUNTED_KPTR directly. Remove its separate
btf_id_fixed_off_ok parameter and wrapper, along with the now-empty
translation switch in check_kfunc_args().

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf.h   |  14 +++
 kernel/bpf/verifier.c | 221 ++++++++++++++----------------------------
 2 files changed, 87 insertions(+), 148 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1574fe2d8cc0..f620920ea575 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -908,6 +908,20 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	ARG_KPTR_XCHG_DEST,	/* pointer to destination that kptrs are bpf_kptr_xchg'd into */
 	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for dynptr type */
+
+	ARG_CONST_SCALAR,	/* scalar known at verification time */
+	ARG_CONST_MEM_SIZE,	/* ARG_MEM_SIZE that must be constant */
+	ARG_PTR_TO_ALLOC_BTF_ID,	/* pointer to an allocated object */
+	ARG_PTR_TO_REFCOUNTED_KPTR,	/* pointer to a refcounted local kptr */
+	ARG_PTR_TO_ITER,	/* pointer to an iterator */
+	ARG_PTR_TO_LIST_HEAD,	/* pointer to bpf_list_head */
+	ARG_PTR_TO_LIST_NODE,	/* pointer to bpf_list_node */
+	ARG_PTR_TO_RB_ROOT,	/* pointer to bpf_rb_root */
+	ARG_PTR_TO_RB_NODE,	/* pointer to bpf_rb_node */
+	ARG_PTR_TO_WORKQUEUE,	/* pointer to bpf_wq */
+	ARG_PTR_TO_TASK_WORK,	/* pointer to bpf_task_work */
+	ARG_PTR_TO_IRQ_FLAG,	/* pointer to saved IRQ flags on the stack */
+	ARG_PTR_TO_RES_SPIN_LOCK,	/* pointer to bpf_res_spin_lock */
 	__BPF_ARG_TYPE_MAX,
 
 	/* Extended arg_types. */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d444e72fdd97..a0a74a5e23be 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8533,10 +8533,9 @@ reg_find_field_offset(const struct bpf_reg_state *reg, s32 off, u32 fields)
 	return field;
 }
 
-static int __check_func_arg_reg_off(struct bpf_verifier_env *env,
-				    const struct bpf_reg_state *reg, argno_t argno,
-				    enum bpf_arg_type arg_type,
-				    bool btf_id_fixed_off_ok)
+static int check_func_arg_reg_off(struct bpf_verifier_env *env,
+				  const struct bpf_reg_state *reg, argno_t argno,
+				  enum bpf_arg_type arg_type)
 {
 	u32 type = reg->type;
 
@@ -8592,12 +8591,15 @@ static int __check_func_arg_reg_off(struct bpf_verifier_env *env,
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
-		 * its fixed offset must be 0. In the other cases, fixed offset
-		 * can be non-zero unless the caller requires otherwise.
-		 * var_off always must be 0 for PTR_TO_BTF_ID, hence we still
-		 * need to do checks instead of returning.
+		 * its fixed offset must be 0. bpf_refcount_acquire() returns the
+		 * pointer it was given while incrementing the refcount at the
+		 * refcount field offset, so it needs a zero offset too. In the
+		 * other cases, fixed offset can be non-zero. var_off always must
+		 * be 0 for PTR_TO_BTF_ID, hence we still need to do checks
+		 * instead of returning.
 		 */
-		return __check_ptr_off_reg(env, reg, argno, btf_id_fixed_off_ok);
+		return __check_ptr_off_reg(env, reg, argno,
+					   base_type(arg_type) != ARG_PTR_TO_REFCOUNTED_KPTR);
 	case PTR_TO_CTX:
 		/*
 		 * Allow fixed and variable offsets for syscall context, but
@@ -8613,13 +8615,6 @@ static int __check_func_arg_reg_off(struct bpf_verifier_env *env,
 	}
 }
 
-static int check_func_arg_reg_off(struct bpf_verifier_env *env,
-				  const struct bpf_reg_state *reg, argno_t argno,
-				  enum bpf_arg_type arg_type)
-{
-	return __check_func_arg_reg_off(env, reg, argno, arg_type, true);
-}
-
 static int check_arg_const_str(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, argno_t argno)
 {
@@ -11793,34 +11788,6 @@ static void btf_member_path_str(const struct btf *btf, const struct btf_member_p
 	}
 }
 
-enum kfunc_ptr_arg_type {
-	KF_ARG_CONST_MEM_SIZE,
-	KF_ARG_MEM_SIZE,
-	KF_ARG_CONST,
-	KF_ARG_CONST_ALLOC_SIZE_OR_ZERO,
-	KF_ARG_ANYTHING,
-	KF_ARG_PTR_TO_CTX,
-	KF_ARG_PTR_TO_ALLOC_BTF_ID,    /* Allocated object */
-	KF_ARG_PTR_TO_REFCOUNTED_KPTR, /* Refcounted local kptr */
-	KF_ARG_PTR_TO_DYNPTR,
-	KF_ARG_PTR_TO_ITER,
-	KF_ARG_PTR_TO_LIST_HEAD,
-	KF_ARG_PTR_TO_LIST_NODE,
-	KF_ARG_PTR_TO_BTF_ID,	       /* Also covers reg2btf_ids conversions */
-	KF_ARG_PTR_TO_MEM,
-	KF_ARG_PTR_TO_CALLBACK,
-	KF_ARG_PTR_TO_RB_ROOT,
-	KF_ARG_PTR_TO_RB_NODE,
-	KF_ARG_PTR_TO_CONST_STR,
-	KF_ARG_CONST_MAP_PTR,
-	KF_ARG_PTR_TO_TIMER,
-	KF_ARG_PTR_TO_WORKQUEUE,
-	KF_ARG_PTR_TO_IRQ_FLAG,
-	KF_ARG_PTR_TO_RES_SPIN_LOCK,
-	KF_ARG_PTR_TO_TASK_WORK,
-	KF_ARG_PTR_TO_ARENA,
-};
-
 enum special_kfunc_type {
 	KF_bpf_obj_new_impl,
 	KF_bpf_obj_new,
@@ -12082,15 +12049,15 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	/* Scalar arguments are classified from their BTF suffix/name alone. */
 	if (btf_type_is_scalar(t)) {
 		if (is_kfunc_arg_constant(meta->btf, &args[arg]))
-			return KF_ARG_CONST;
+			return ARG_CONST_SCALAR;
 		if (is_kfunc_arg_const_mem_size(meta->btf, &args[arg]))
-			return KF_ARG_CONST_MEM_SIZE;
+			return ARG_CONST_MEM_SIZE;
 		if (is_kfunc_arg_mem_size(meta->btf, &args[arg]))
-			return KF_ARG_MEM_SIZE;
+			return ARG_MEM_SIZE;
 		if (is_kfunc_arg_scalar_with_name(meta->btf, &args[arg], "rdonly_buf_size") ||
 		    is_kfunc_arg_scalar_with_name(meta->btf, &args[arg], "rdwr_buf_size"))
-			return KF_ARG_CONST_ALLOC_SIZE_OR_ZERO;
-		return KF_ARG_ANYTHING;
+			return ARG_CONST_ALLOC_SIZE_OR_ZERO;
+		return ARG_SCALAR;
 	}
 
 	if (!btf_type_is_ptr(t)) {
@@ -12104,48 +12071,48 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	/* In this function, we verify the kfunc's BTF as per the argument type,
 	 * leaving the rest of the verification with respect to the register
 	 * type to our caller. When a set of conditions hold in the BTF type of
-	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
+	 * arguments, we resolve it to a known bpf_arg_type.
 	 */
 	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx]) ||
 	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_session_is_return]) ||
 	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_session_cookie]))
-		arg_type = KF_ARG_PTR_TO_CTX;
+		arg_type = ARG_PTR_TO_CTX;
 	else if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
-		arg_type = KF_ARG_PTR_TO_CTX;
+		arg_type = ARG_PTR_TO_CTX;
 	else if (is_kfunc_arg_alloc_obj(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_ALLOC_BTF_ID;
+		arg_type = ARG_PTR_TO_ALLOC_BTF_ID;
 	else if (is_kfunc_arg_refcounted_kptr(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_REFCOUNTED_KPTR;
+		arg_type = ARG_PTR_TO_REFCOUNTED_KPTR;
 	else if (is_kfunc_arg_dynptr(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_DYNPTR;
+		arg_type = ARG_PTR_TO_DYNPTR;
 	else if (is_kfunc_arg_iter(meta, arg, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_ITER;
+		arg_type = ARG_PTR_TO_ITER;
 	else if (is_kfunc_arg_list_head(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_LIST_HEAD;
+		arg_type = ARG_PTR_TO_LIST_HEAD;
 	else if (is_kfunc_arg_list_node(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_LIST_NODE;
+		arg_type = ARG_PTR_TO_LIST_NODE;
 	else if (is_kfunc_arg_rbtree_root(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_RB_ROOT;
+		arg_type = ARG_PTR_TO_RB_ROOT;
 	else if (is_kfunc_arg_rbtree_node(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_RB_NODE;
+		arg_type = ARG_PTR_TO_RB_NODE;
 	else if (is_kfunc_arg_const_str(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_CONST_STR;
+		arg_type = ARG_PTR_TO_CONST_STR;
 	else if (is_kfunc_arg_const_map(meta->btf, &args[arg]))
-		arg_type = KF_ARG_CONST_MAP_PTR;
+		arg_type = ARG_CONST_MAP_PTR;
 	else if (is_kfunc_arg_map(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_BTF_ID;
+		arg_type = ARG_PTR_TO_BTF_ID;
 	else if (is_kfunc_arg_wq(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_WORKQUEUE;
+		arg_type = ARG_PTR_TO_WORKQUEUE;
 	else if (is_kfunc_arg_timer(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_TIMER;
+		arg_type = ARG_PTR_TO_TIMER;
 	else if (is_kfunc_arg_task_work(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_TASK_WORK;
+		arg_type = ARG_PTR_TO_TASK_WORK;
 	else if (is_kfunc_arg_irq_flag(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_IRQ_FLAG;
+		arg_type = ARG_PTR_TO_IRQ_FLAG;
 	else if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_RES_SPIN_LOCK;
+		arg_type = ARG_PTR_TO_RES_SPIN_LOCK;
 	else if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
-		arg_type = KF_ARG_PTR_TO_CALLBACK;
+		arg_type = ARG_PTR_TO_FUNC;
 	else if (is_kfunc_arg_arena(meta->btf, &args[arg])) {
 		if (!bpf_jit_supports_arena_args()) {
 			verbose(env, "JIT does not support kfunc %s() with arena pointer arguments\n",
@@ -12168,7 +12135,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		 * whether the JIT rebases it to the arena base or preserves NULL.
 		 * The common nullable path below records that verifier property.
 		 */
-		arg_type = KF_ARG_PTR_TO_ARENA;
+		arg_type = ARG_PTR_TO_ARENA;
 	} else if (arg + 1 < nargs &&
 		 (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
 		  is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
@@ -12178,10 +12145,10 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = KF_ARG_PTR_TO_MEM;
+		arg_type = ARG_PTR_TO_MEM;
 	} else if (btf_type_is_struct(ref_t))
-		/* A pointer to a struct without a size argument is classified as KF_ARG_PTR_TO_BTF_ID */
-		arg_type = KF_ARG_PTR_TO_BTF_ID;
+		/* A pointer to a struct without a size argument is classified as ARG_PTR_TO_BTF_ID */
+		arg_type = ARG_PTR_TO_BTF_ID;
 	else {
 		/*
 		 * Otherwise this is a fixed-size memory buffer supported by
@@ -12194,7 +12161,7 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 			return -EINVAL;
 		}
-		arg_type = KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+		arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 	}
 
 	if (is_kfunc_arg_nullable(meta->btf, &args[arg]))
@@ -12826,13 +12793,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 	 */
 	for (i = 0; i < nargs; i++) {
 		struct bpf_reg_state *reg = get_func_arg_reg(caller, regs, i);
+		enum bpf_arg_type arg_type = meta->fn->arg_type[i];
 		const struct btf_type *t, *ref_t, *resolve_ret;
-		enum bpf_arg_type arg_type = ARG_UNUSED;
 		argno_t argno = argno_from_arg(i + 1);
 		int regno = reg_from_argno(argno);
-		bool btf_id_fixed_off_ok = true;
 		u32 ref_id = args[i].type, type_size;
-		int kf_arg_type = meta->fn->arg_type[i];
 
 		if (is_kfunc_arg_prog_aux(btf, &args[i])) {
 			/* Reject repeated use bpf_prog_aux */
@@ -12862,7 +12827,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 		if (btf_type_is_ptr(t) &&
 		    (bpf_register_is_null(reg) || type_may_be_null(reg->type)) &&
-		    !type_may_be_null(kf_arg_type)) {
+		    !type_may_be_null(arg_type)) {
 			const char *expected_type;
 
 			expected_type = bpf_diag_fmt_btf_type(env, btf, args[i].type);
@@ -12892,7 +12857,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (reg_is_referenced(env, reg))
 			update_ref_obj(&meta->ref_obj, reg);
 
-		if (bpf_register_is_null(reg) && type_may_be_null(kf_arg_type))
+		if (bpf_register_is_null(reg) && type_may_be_null(arg_type))
 			continue;
 
 		if (is_kfunc_arg_map(btf, &args[i])) {
@@ -12901,54 +12866,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 		}
 
-		switch (base_type(kf_arg_type)) {
-		case KF_ARG_CONST:
-		case KF_ARG_CONST_MEM_SIZE:
-		case KF_ARG_MEM_SIZE:
-		case KF_ARG_ANYTHING:
-		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
-		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
-		case KF_ARG_PTR_TO_BTF_ID:
-		case KF_ARG_CONST_MAP_PTR:
-		case KF_ARG_PTR_TO_ITER:
-		case KF_ARG_PTR_TO_LIST_HEAD:
-		case KF_ARG_PTR_TO_LIST_NODE:
-		case KF_ARG_PTR_TO_RB_ROOT:
-		case KF_ARG_PTR_TO_RB_NODE:
-		case KF_ARG_PTR_TO_MEM:
-		case KF_ARG_PTR_TO_CALLBACK:
-		case KF_ARG_PTR_TO_CONST_STR:
-		case KF_ARG_PTR_TO_WORKQUEUE:
-		case KF_ARG_PTR_TO_TIMER:
-		case KF_ARG_PTR_TO_TASK_WORK:
-		case KF_ARG_PTR_TO_IRQ_FLAG:
-		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
-		case KF_ARG_PTR_TO_ARENA:
-			break;
-		case KF_ARG_PTR_TO_DYNPTR:
-			arg_type = ARG_PTR_TO_DYNPTR;
-			break;
-		case KF_ARG_PTR_TO_CTX:
-			arg_type = ARG_PTR_TO_CTX;
-			break;
-		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
-			arg_type = ARG_PTR_TO_BTF_ID;
-			btf_id_fixed_off_ok = false;
-			break;
-		default:
-			verifier_bug(env, "unknown kfunc arg type %d", kf_arg_type);
-			return -EFAULT;
-		}
-
 		if (regno == meta->release_regno)
 			arg_type |= OBJ_RELEASE;
-		ret = __check_func_arg_reg_off(env, reg, argno, arg_type,
-					       btf_id_fixed_off_ok);
+		ret = check_func_arg_reg_off(env, reg, argno, arg_type);
 		if (ret < 0)
 			return ret;
 
-		switch (base_type(kf_arg_type)) {
-		case KF_ARG_CONST:
+		switch (base_type(arg_type)) {
+		case ARG_CONST_SCALAR:
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
 				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
@@ -12969,7 +12894,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			}
 			break;
-		case KF_ARG_ANYTHING:
+		case ARG_SCALAR:
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
 				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
@@ -12980,7 +12905,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return -EINVAL;
 			}
 			break;
-		case KF_ARG_CONST_ALLOC_SIZE_OR_ZERO:
+		case ARG_CONST_ALLOC_SIZE_OR_ZERO:
 			if (reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a scalar\n", reg_arg_name(env, argno));
 				bpf_diag_call_arg_fmt(env, insn_idx, argno, func_name,
@@ -13003,7 +12928,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			}
 			break;
-		case KF_ARG_PTR_TO_CTX:
+		case ARG_PTR_TO_CTX:
 			if (reg->type != PTR_TO_CTX) {
 				verbose(env, "%s expected pointer to ctx, but got %s\n",
 					reg_arg_name(env, argno), reg_type_str(env, reg->type));
@@ -13022,14 +12947,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				meta->ret_btf_id  = ret;
 			}
 			break;
-		case KF_ARG_PTR_TO_ARENA:
+		case ARG_PTR_TO_ARENA:
 			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
 				verbose(env, "%s is not a pointer to arena or scalar\n",
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			break;
-		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
+		case ARG_PTR_TO_ALLOC_BTF_ID:
 			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
 					verbose(env, "%s expected for bpf_obj_drop()\n",
@@ -13065,7 +12990,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				meta->arg_btf_id = reg->btf_id;
 			}
 			break;
-		case KF_ARG_PTR_TO_DYNPTR:
+		case ARG_PTR_TO_DYNPTR:
 		{
 			enum bpf_arg_type dynptr_arg_type = ARG_PTR_TO_DYNPTR;
 
@@ -13100,7 +13025,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			break;
 		}
-		case KF_ARG_PTR_TO_ITER:
+		case ARG_PTR_TO_ITER:
 			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_iter_css_task_new])) {
 				if (!check_css_task_iter_allowlist(env)) {
 					verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
@@ -13111,7 +13036,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_LIST_HEAD:
+		case ARG_PTR_TO_LIST_HEAD:
 			if (reg->type != PTR_TO_MAP_VALUE &&
 			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				verbose(env, "%s expected pointer to map value or allocated object\n",
@@ -13127,7 +13052,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_RB_ROOT:
+		case ARG_PTR_TO_RB_ROOT:
 			if (reg->type != PTR_TO_MAP_VALUE &&
 			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				verbose(env, "%s expected pointer to map value or allocated object\n",
@@ -13143,7 +13068,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_LIST_NODE:
+		case ARG_PTR_TO_LIST_NODE:
 			if (is_kfunc_arg_nonown_allowed(btf, &args[i]) &&
 			    type_is_non_owning_ref(reg->type) && !reg_is_referenced(env, reg)) {
 				/* Allow bpf_list_front/back return value for
@@ -13165,7 +13090,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_RB_NODE:
+		case ARG_PTR_TO_RB_NODE:
 			if (is_bpf_rbtree_add_kfunc(meta->func_id)) {
 				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 					verbose(env, "%s expected pointer to allocated object\n",
@@ -13192,7 +13117,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_CONST_MAP_PTR:
+		case ARG_CONST_MAP_PTR:
 			if (base_type(reg->type) != CONST_PTR_TO_MAP ||
 			    type_may_be_null(reg->type)) {
 				verbose(env, "pointer in %s isn't map pointer\n",
@@ -13203,7 +13128,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_BTF_ID:
+		case ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
 			if (base_type(reg->type) == PTR_TO_BTF_ID ||
 			    reg2btf_ids[base_type(reg->type)]) {
@@ -13268,10 +13193,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			 * If the register does not contain btf id but the argument type is a pointer to
 			 * scalar-only struct, allow verifying it as a fixed size memory.
 			 */
-			kf_arg_type = KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+			arg_type = ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 			fallthrough;
-		case KF_ARG_PTR_TO_MEM:
-			if (kf_arg_type & MEM_FIXED_SIZE) {
+		case ARG_PTR_TO_MEM:
+			if (arg_type & MEM_FIXED_SIZE) {
 				bool known_memory;
 
 				resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
@@ -13305,7 +13230,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				}
 			}
 			break;
-		case KF_ARG_CONST_MEM_SIZE:
+		case ARG_CONST_MEM_SIZE:
 			ret = process_const_arg(env, reg, argno, meta);
 			if (ret < 0) {
 				if (ret == -EINVAL)
@@ -13316,7 +13241,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return ret;
 			}
 			fallthrough;
-		case KF_ARG_MEM_SIZE:
+		case ARG_MEM_SIZE:
 		{
 			struct bpf_reg_state *buff_reg = get_func_arg_reg(caller, regs, i - 1);
 			struct bpf_reg_state *size_reg = reg;
@@ -13369,14 +13294,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			}
 			break;
 		}
-		case KF_ARG_PTR_TO_CALLBACK:
+		case ARG_PTR_TO_FUNC:
 			if (reg->type != PTR_TO_FUNC) {
 				verbose(env, "%s expected pointer to func\n", reg_arg_name(env, argno));
 				return -EINVAL;
 			}
 			meta->subprogno = reg->subprogno;
 			break;
-		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
+		case ARG_PTR_TO_REFCOUNTED_KPTR:
 			if (!type_is_ptr_alloc_obj(reg->type)) {
 				verbose(env, "%s is neither owning or non-owning ref\n",
 					reg_arg_name(env, argno));
@@ -13405,7 +13330,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			meta->arg_btf = reg->btf;
 			meta->arg_btf_id = reg->btf_id;
 			break;
-		case KF_ARG_PTR_TO_CONST_STR:
+		case ARG_PTR_TO_CONST_STR:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "%s doesn't point to a const string\n",
 					reg_arg_name(env, argno));
@@ -13420,7 +13345,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_WORKQUEUE:
+		case ARG_PTR_TO_WORKQUEUE:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "%s doesn't point to a map value\n",
 					reg_arg_name(env, argno));
@@ -13430,7 +13355,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_TIMER:
+		case ARG_PTR_TO_TIMER:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "%s doesn't point to a map value\n",
 					reg_arg_name(env, argno));
@@ -13440,7 +13365,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_TASK_WORK:
+		case ARG_PTR_TO_TASK_WORK:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "%s doesn't point to a map value\n",
 					reg_arg_name(env, argno));
@@ -13450,7 +13375,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_IRQ_FLAG:
+		case ARG_PTR_TO_IRQ_FLAG:
 			if (reg->type != PTR_TO_STACK) {
 				verbose(env, "%s doesn't point to an irq flag on stack\n",
 					reg_arg_name(env, argno));
@@ -13465,7 +13390,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (ret < 0)
 				return ret;
 			break;
-		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
+		case ARG_PTR_TO_RES_SPIN_LOCK:
 		{
 			int flags = PROCESS_RES_LOCK;
 
-- 
2.52.0

