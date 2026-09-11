Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AB44237F
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164266; cv=none; b=a5C63aHy+yKQP0lHkuRJ8FSQlImMNbNVuuIZl2fLLbmAs7NhNT8ra0BQZQiG5WdSrNI9xT9SS0hWBaWtw/Xt5B1Ui4oCJ+bMU21jLB1WL4eIng0+QQxs7Ty85YufqUF9iBwUFfbAFkbM1OgATwoD+r9YTLEtCi/6KK7XKTZgqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164266; c=relaxed/simple;
	bh=gSNCXQ6FTlwUkZf9alhBi9GaI0Cnw6+7WmI7ZGEFFIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pk3FHa5kjAs6B/CBm9ux1jYqLwA3G0BQ9NUqNjWUvpRDslvXQ3ohUoDibzznaPo2Cd/KXRVspaIOxIDCrB7wEQWQBhdzU1/Lx59Fo1eOskPqhz0vaFO6VxITL9UgwTW98O8zSPNuPiYddXksWJA0roAGdagDi2Xk1Ome7JTmA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyhxvdRN; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyhxvdRN"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2ffef2so35568b6e.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164264; x=1789769064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bWT3wvnWaFPRuGbZIZ1xiz+1ZnbV5NhCa9zTBAPU9Iw=;
        b=FyhxvdRNW9nmjic0KKmBHYWkNF00m4p9HNM81sAx0jAAp7uBAmiSGq1+CuuqyD0qIG
         f8BOZYAH98DivmcjpIXPhCkViZ9roAI20YS8x7xcR1Z0oNx6ARHg36cPphz+4jT7r6Px
         ySffJM9tUZcfUJN2yu580MiC5HTs0qI1aQtYlepc1kvtK3rpAsPtDkVoU9IUQ/GsWQ+B
         387frBKZmh9OEMP1rR3VZWdaLGf7uKnsL+1FofWOP3wMmkSxwcUi8yH3Ig7mZ9raIE7c
         3PeatPBjiRiFOC1jdM36SQGZ+AxTyLGb8owQlJLHz9GdVu6DfWy6qJ9AMthfSGSX/0ka
         K2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164264; x=1789769064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bWT3wvnWaFPRuGbZIZ1xiz+1ZnbV5NhCa9zTBAPU9Iw=;
        b=boru/IaHDF6s4ytj7R/hweNGrHjF1TbI01fz36uhf02Twk/c8/X3mWWnuM3ivzJ8n+
         T3NQPQZSTWgP0KHBg55uYbmL+3yqGIBsALOlNk202CGlK6r1p0Fdh242HMYTRIVeLpko
         JGKYmzFzYi0VlG+u9KWm6Khi7L3QTLGfaNFZJosMMkD5NKift8mtf34ArjDaBqL65psE
         s8yQ+97/jFrheSCtoxp5t2HLnEhSTNvqZM3aDLvpzVFJKe0BCxUKS3LCdtb5CYLM80Nm
         9weQs5E4TiF26RB0CdFO6pxzUrpNsg73aiywztFcLqiwlGOPgpPh6dr0BDX+Hia5Sxwb
         ge4Q==
X-Gm-Message-State: AFuF++nV9tfOXPU38Ngyux1FAbwP/0FlRGZUdTfMDgNFJqWUTR3Alq9j
	UCEaVKrU7A+Zm5JW6yHzXv5x1DlvFhz6hDxU7Sx4/eJI8CCl57wmJmhh7lGcXw==
X-Gm-Gg: AYBFou2BsqJalcA0gUBhNALFYp0nNsmPr5tc2HDufC/tuqQPEK/wbm1JooY4EdyR+u8
	Rz4u3CjLgQjy1qBXX5rLo1uIHqOeods9BfeU88nDc+e9EmZy97x8pFdOn6r+5qeOjFnRFyLg8yR
	wFyrIuP76zUmfGa7U8DeoJtSb9DqQYfaKOe/TfZuezIyB4STMM4NQcjUTcZsVybNsmM1Six4e8v
	Ydc3EGVao3LjSVQJGC0WvSODIbPvP/54jpIuwfNeZOxLUyQWPv7rJk51/fFKltWz4s77sIZaRQ3
	p4A+ijlwCrM9UTiNdaMta4IHenzcgqm2E9XTGePvO9O2+ejVeLq+pLyNGdVxFwf1JaGQJdayAzS
	X3PkyfimliSKDb6jDGKZyyHgqtxcHHhVpYdDTtbG9MGaG2seBO9ah3LkwdBnyo0DG3f3d9URtON
	Cw1CyhPf+ve03kxZQVEg4KBmRMMyzFKwGo4CCNJVXCu+4Ogmcp2UrinpHWsHGeqQ==
X-Received: by 2002:a05:6808:2e4c:b0:4c1:83fb:8c7b with SMTP id 5614622812f47-4c4a75161f8mr420859b6e.12.1789164263780;
        Fri, 11 Sep 2026 15:04:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c331bc9342sm3388810b6e.12.2026.09.11.15.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:23 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 04/23] bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
Date: Fri, 11 Sep 2026 15:03:56 -0700
Message-ID: <20260911220415.1396439-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911220415.1396439-1-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helpers are identified by enum bpf_func_id, while kfuncs are identified
by a BTF ID. Both values are stored in bpf_call_arg_meta::func_id, and
a helper ID can have the same numeric value as a kfunc BTF ID.

Introduce is_kfunc_call(), which first confirms that the metadata is for
a kfunc through meta->btf, and use it for comparisons against the special
kfunc BTF ID list. This complements is_helper_call() before later patches
move these checks into paths shared by helpers and kfuncs.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 68 +++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5bf31fbdaac1..42d89db5df07 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8186,6 +8186,11 @@ static bool is_helper_call(const struct bpf_call_arg_meta *meta, enum bpf_func_i
 	return !meta->btf && meta->func_id == func_id;
 }
 
+static bool is_kfunc_call(const struct bpf_call_arg_meta *meta, u32 btf_id)
+{
+	return meta->btf && meta->func_id == btf_id;
+}
+
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
 				 const struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type)
@@ -12137,27 +12142,27 @@ static bool is_kfunc_ret_null(struct bpf_call_arg_meta *meta)
 
 static bool is_kfunc_bpf_rcu_read_lock(struct bpf_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_lock];
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_rcu_read_lock]);
 }
 
 static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_unlock];
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_rcu_read_unlock]);
 }
 
 static bool is_kfunc_bpf_preempt_disable(struct bpf_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_preempt_disable];
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_preempt_disable]);
 }
 
 static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_preempt_enable]);
 }
 
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]);
 }
 
 static int
@@ -12198,9 +12203,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 	 * type to our caller. When a set of conditions hold in the BTF type of
 	 * arguments, we resolve it to a known kfunc_ptr_arg_type.
 	 */
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
+	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx]) ||
+	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_session_is_return]) ||
+	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_session_cookie]))
 		arg_type = KF_ARG_PTR_TO_CTX;
 	else if (btf_is_prog_ctx_type(&env->log, meta->btf, t, resolve_prog_type(env->prog), arg))
 		arg_type = KF_ARG_PTR_TO_CTX;
@@ -12411,15 +12416,15 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 	int err, spi, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_save] ||
-	    meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave]) {
+	if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_local_irq_save]) ||
+	    is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock_irqsave])) {
 		irq_save = true;
-		if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])
+		if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
 			kfunc_class = IRQ_LOCK_KFUNC;
-	} else if (meta->func_id == special_kfunc_list[KF_bpf_local_irq_restore] ||
-		   meta->func_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore]) {
+	} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_local_irq_restore]) ||
+		   is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore])) {
 		irq_save = false;
-		if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore])
+		if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore]))
 			kfunc_class = IRQ_LOCK_KFUNC;
 	} else {
 		verifier_bug(env, "unknown irq flags kfunc");
@@ -13111,7 +13116,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return -EINVAL;
 			}
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
+			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx])) {
 				ret = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
 				if (ret < 0)
 					return -EINVAL;
@@ -13168,17 +13173,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			if (is_kfunc_arg_uninit(btf, &args[i]))
 				dynptr_arg_type |= MEM_UNINIT;
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_skb])) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_xdp]) {
+			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_xdp])) {
 				dynptr_arg_type |= DYNPTR_TYPE_XDP;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
+			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_skb_meta])) {
 				dynptr_arg_type |= DYNPTR_TYPE_SKB_META;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_from_file]) {
+			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_from_file])) {
 				dynptr_arg_type |= DYNPTR_TYPE_FILE;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_file_discard]) {
+			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_file_discard])) {
 				dynptr_arg_type |= DYNPTR_TYPE_FILE | OBJ_RELEASE;
-			} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_clone] &&
+			} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_clone]) &&
 				   (dynptr_arg_type & MEM_UNINIT)) {
 				enum bpf_dynptr_type parent_type = meta->dynptr.type;
 
@@ -13197,7 +13202,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
-			if (meta->func_id == special_kfunc_list[KF_bpf_iter_css_task_new]) {
+			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_iter_css_task_new])) {
 				if (!check_css_task_iter_allowlist(env)) {
 					verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
 					return -EINVAL;
@@ -13578,11 +13583,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
 			if (!is_bpf_res_spin_lock_kfunc(meta->func_id))
 				return -EFAULT;
-			if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
-			    meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])
+			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock]) ||
+			    is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock_irqsave]))
 				flags |= PROCESS_SPIN_LOCK;
-			if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
-			    meta->func_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore])
+			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_res_spin_lock_irqsave]) ||
+			    is_kfunc_call(meta,
+					  special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore]))
 				flags |= PROCESS_LOCK_IRQ;
 			ret = process_spin_lock(env, reg, argno, flags);
 			if (ret < 0)
@@ -13925,12 +13931,12 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 		struct btf_field *field = meta->arg_rbtree_root.field;
 
 		mark_reg_graph_node(regs, BPF_REG_0, &field->graph_root);
-	} else if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
+	} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx])) {
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
 		regs[BPF_REG_0].btf = desc_btf;
 		regs[BPF_REG_0].btf_id = meta->ret_btf_id;
-	} else if (meta->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
+	} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_rdonly_cast])) {
 		ret_t = btf_type_by_id(desc_btf, meta->arg_constant.value);
 		if (!ret_t) {
 			verbose(env, "Unknown type ID %lld passed to kfunc bpf_rdonly_cast\n",
@@ -13950,8 +13956,8 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 				"kfunc bpf_rdonly_cast type ID argument must be of a struct or void\n");
 			return -EINVAL;
 		}
-	} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice] ||
-		   meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
+	} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_slice]) ||
+		   is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_slice_rdwr])) {
 		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->dynptr.type);
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -13966,7 +13972,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 		/* PTR_MAYBE_NULL will be added when is_kfunc_ret_null is checked */
 		regs[BPF_REG_0].type = PTR_TO_MEM | type_flag;
 
-		if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice]) {
+		if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_slice])) {
 			regs[BPF_REG_0].type |= MEM_RDONLY;
 		} else {
 			/* this will set env->seen_direct_write to true */
-- 
2.52.0

