Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D504B344D9D
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783312; cv=none; b=HNDzTpwIaQS3zA5w/J/TYpqrqOQWusWNwx7UAl1GPdTLfp8VACtnj6OGEeKfw3qmJpS6qptyCh5VauHYU5Nt7GjOiJG0YnT/jUB5jugsk/VMSdK6W1SGLAEwXrEdLJyw1zAdQt+V5oVfGSczZsSlhCGBeETMgbgCnpBvIXGCSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783312; c=relaxed/simple;
	bh=/MIgurFCZFXuk+sUV8R2iGlsSmFVNCe0d3WRK2YxiJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv76pTfeKHY67gkxAI1/+Q5N9xOVA/jtTJt7Azw8zTmYvEt7u01zkAiSzD/9KREnNagnygS32iz3qPRQwM8aaAldFoYE0KvGZlumlt5oayFBBWRJIKkkEy5KCQCDdlsKP/+ThYLCmR+U+dlakGkcEplhDBZBc/xjWjSezPHGIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI8++heC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI8++heC"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8453427d3f4so199159b3a.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783310; x=1785388110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xO4Y9jTwTbLWL4gykUf3RuzCnUxBeBjGhupsy2aXnnI=;
        b=JI8++heCct5CpnTFiwJsqaDIe8MZ9dnn1DisVzcylVoPwuHKkTzT0dfz1BSuGhk9MC
         hcGjJQcMn9+VaR7msqZOGFT6cq152susFxFSSvgIPv9A1/EXNshnyuXQ3G9KjJ03vTu/
         ReT+iXrtfU9dntljjcYWEDQnaF2jbTjdHr9AfZ4AQ99Vi+NS2cJ6kDRugcBY6b7UVpdE
         lHI8rWQPIzz3vl7FaAicbAFS4YVGUeBgkmJ4auVg/rYUsRFzPtkvhWvC9jle0Et+sd2K
         wvLp89iC3fETnw0AC3GdBhMGoxNlLAsGMJ58SsaDQLPGbKG/rh8600ZqaPFPvHHfpphY
         zDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783310; x=1785388110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xO4Y9jTwTbLWL4gykUf3RuzCnUxBeBjGhupsy2aXnnI=;
        b=lVqXanoA6Cxshwq5HeCfeJC1WeAX7t/IVkAexvVsik2M1STcGWuccn5CNHPvlgF6cz
         e4aeFNVhO3Db0zv5DCHRO2qSLajbsx+ABVvI86U5dlWY6zBs/ppUhxQJjdqNqrr1cyQ7
         ri6bjjMbwaM9YfScYA8gWqqXMaiF3xSMJsXZ3QC5uOIAljf4YmPhWmhv+uDOtdjDtHXx
         oKLRvJfp4d7AvZftwo7v33zbdNrIT/bP6QwpruJLXwVJ43cjAI+57w3+7eixPtiARG0/
         YQ3SzhYVfuio+EEYBDaSGN2cKGjCt/xpa9qby250olFrX3tWNi+lKj/djeItdjLE0nTt
         mvXg==
X-Gm-Message-State: AOJu0Yw1ewFtISBamHGYtU2nsKhRIpiVDSw+DVAoaAPHVjYyfufRhbqd
	Z2zUx9qQlUeZcumg0fPEx/aD6ej9K1crilJLTE5qddAr7cfIiuul6DUHgHc5Nw==
X-Gm-Gg: AR+sD12lKkByTpmmnlF999bPi9YfO3vA3vQfb5ZL2IOhmRJPoxBYmK4fBT954sLn6Uy
	CNzE109y/3N8YobGk7q9ydreUYQPHFyvgYrcBentEJWQI5T+URUEy5kE3NtqfxGqwNN+AyC6jz+
	oEz2YB8MDmLp43sCvpMrm67YOHzx7ZK4+MWP9Ch8VK2lnbfwySWhlIRdnbg8pHqTfvytq/kGBiD
	u7KImczY0RlkJr/g5PdYiMSml43L7Ok0SKX1sJWgczHw1GHCM1coGok5ZvcBXhDY0HyPos+CGYM
	e+TPAad2qXnJ7M70NUIwNZnqvPZwvx0bzjuASodZTcd8ElJNlwArh1TufbUJOpR0NyjXTJ8s+HY
	ZkRDQ7MbvI3ld4XFkE7B5VMIOkILAQD/wj26aL+5OcmYr9y7tPEMHhUwooO+ZQPHNElVF
X-Received: by 2002:a05:6a00:174c:b0:848:2f7a:2e5e with SMTP id d2e1a72fcca58-84e2bbdcc09mr1940563b3a.77.1784783309968;
        Wed, 22 Jul 2026 22:08:29 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175d6c30sm2382252b3a.51.2026.07.22.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:29 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 16/18] bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL
Date: Wed, 22 Jul 2026 22:08:04 -0700
Message-ID: <20260723050806.1158442-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 156 ++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 82 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aa3313aeafdb..24858a38c34c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11367,93 +11367,85 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *m
 		       int arg, int nargs, argno_t argno)
 {
 	bool arg_mem_size = false;
-
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
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
-		arg_mem_size = true;
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
+	else {
+		if (arg + 1 < nargs &&
+		    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
+		     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
+			arg_mem_size = true;
+
+		if (btf_type_is_struct(ref_t) && !arg_mem_size) {
+			/* A pointer to a struct without a size argument is classified
+			 * as KF_ARG_PTR_TO_BTF_ID.
+			 */
+			arg_type = KF_ARG_PTR_TO_BTF_ID;
+		} else if (!btf_type_is_scalar(ref_t) &&
+			   !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
+			   (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
+			verbose(env, "%s pointer type %s %s must point to %sscalar, or struct with scalar\n",
+				reg_arg_name(env, argno),
+				btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+			return -EINVAL;
+		} else {
+			/* Otherwise this is a memory buffer supported by
+			 * check_helper_mem_access(): a pointer to a scalar, or to void
+			 * when paired with a size argument. The access size is derived
+			 * from the pointed-to BTF type unless a size argument follows.
+			 */
+			arg_type = arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+		}
+	}
 
-	/* A pointer to a struct without a size argument is classified as KF_ARG_PTR_TO_BTF_ID */
-	if (btf_type_is_struct(ref_t) && !arg_mem_size)
-		return KF_ARG_PTR_TO_BTF_ID;
+	if (is_kfunc_arg_nullable(meta->btf, &args[arg]))
+		arg_type |= PTR_MAYBE_NULL;
 
-	/*
-	 * Otherwise this is a memory buffer supported by check_helper_mem_access(): a pointer
-	 * to a scalar, or to void when paired with a size argument. The access size is derived
-	 * from the pointed-to BTF type unless a size argument follows.
-	 */
-	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
-	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
-		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct with scalar\n",
-			reg_arg_name(env, argno),
-			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
-		return -EINVAL;
-	}
-	return arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+	return arg_type;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12141,14 +12133,14 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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

