Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA126AF4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645688; cv=none; b=GaTPAtlANqDULnypKqq0neRl5KtY8CzKAz0ZYmIhVQmbZwvkcT6VeagxK6dRGMAe7FjdfThYpYP+gsRE5Cwn8WYQeh1gJ5KLDgO5SyFwlbuxu2r+DDhxP5tk59+Sw8Vy3sDb9hnb8Vh7qxHI+CDqFq8A5YvL06H/IeEprmBgEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645688; c=relaxed/simple;
	bh=BsEmWgyOwXBrZgNlSzd5eA11GpmZSM03lK2Q8WAgD38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqUjlWmplRoQ1yG2b16PljVQH14lGOqNNoMdQY4hJwWqACq5fy/6+mvW7fX5SVeG3ju1lohcqEv9tOY3A+mb3739WyOW4CYWI5NZh+acXuvpkUjAA0dGLj1rcbsYD1fPXzsWHybT8S3SQrcCAMxApoJEFWaCWJJRqgco1E6OOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbIWkDVq; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbIWkDVq"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b0496f4bbcso1511340eaf.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645685; x=1789250485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LW+o7Fmz5OBeJ9TCSTMNh6gH9RxyXjoVLl2ggdQKUHE=;
        b=FbIWkDVq7TJ8vLFh3ZvTbQsqowNyWWOeno44YtxYyd4UTZut0QiZdaRK9hclMX+uOr
         cLH+AnZxgL6gJFQAlPFnNuv1H3HRcET1JmfiTZnm4B32jRGrmy1jmfSGB4bKBZcHNWXk
         kpw5QBv54FXKkk31AG+JXC1TdTnUajIDWXoMm8us4MsD066b6ItZ9Pwmbz/0GutxDNYM
         BfBa/CztKNeu4LbvTrlyMOh1CMptuvEMwQcrgtNX++T/LPm2/ztcTxQX9xUqUkUkLgXT
         kmPDscEXFaMyyjLQA2tPLPeoWFeHgBfV0csk4pNc8punifRtp3liKdu12x93YbMGOdXm
         Z32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645685; x=1789250485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LW+o7Fmz5OBeJ9TCSTMNh6gH9RxyXjoVLl2ggdQKUHE=;
        b=q0wO/1pMolbEh2Hi1081ZKMs0AH4Y0SUnOAEFOI4uQm5asQXOJW48lx03nT/iqG5+R
         JWaesYTwoWc4bk2gSEEeZbbLhXWlVmZCq2M73FDj5kQr8v7nIF4ZpQ2oSpEpDiUfO3Wk
         YHrAm3pyzhW29fhxg/BINKysP/4g2mmiekYml0qEdVeRicUqPjyQrgb0HMw5BNkN03WJ
         UHEEY7z2jX/JsY6USlLLJ1MkJ7agUZsSkhWRXy9Ilh5N+cLFY4ZlC8vSuZgM0awgJxRR
         OHthbrlW0NLAddl+QYAWmFzOkcwsfS/TSyEE7GkKoFGQ5PNnBQtycVlmD0Uv309nRkex
         s5Tw==
X-Gm-Message-State: AFuF++n9IVDCNJNEP334/UCiVD3LpoWP6dl0v4avRiVsfMuy8mYYDOkV
	ZTF+rMiZ9fi1fRqNLBRxG5qSA8xtuRrYxSy/1FG72rE/O8xpbw7lL88ACyMyvw==
X-Gm-Gg: AYBFou2LB0xHmXWHKbtRI39NNV+oGtyfik1S2LPa99Y6lG5zpCmTIYQRhfLFV71XS0L
	MW9nvpDSv5/V/mX0TEkon6JUmrgwPQqNZUHrs/Qd1IXJVdzsJyHgWGV7lxzMn8irR3s4Vt9p2ka
	9Fdy+H1uwngBz0Aoxx3CuwvHQnQpX4vCnFSNS3Drh/MQig+0UAlmzgRMIIir9Q7OhS9InvJpdr3
	xmgF+uP39rvRsYlyEBRWZRyCPHbZDTQzYxjkjBgftKYaZxyuYwdozWQewDXZaZLNOiHAY8uTW4u
	weAmj3hTsKy+/AWEMKq/AtY1bEBZa97G7s5pfseaAaH1D2p7xUCNrBr4boWLLvtbt0OGVwVxD9v
	TW0u+TBrNtEr9StEK8y2kTmbKffNc+LhbA8embObmD3GgDMAilxf1mz3qX7HrZzX7VQMRJ7BYUX
	UK3lwc8nepLuWAxZ+eJYWCsCXq8eUx1dmsrNUf1UKu+NyXDkjopg==
X-Received: by 2002:a05:6820:8c7:b0:6b3:752a:53c9 with SMTP id 006d021491bc7-6b6fabd2fbdmr8078775eaf.2.1788645685383;
        Sat, 05 Sep 2026 15:01:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f7bf0086sm7647910a34.27.2026.09.05.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:24 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/22] bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
Date: Sat,  5 Sep 2026 15:00:59 -0700
Message-ID: <20260905220117.922028-5-ameryhung@gmail.com>
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
index 9a39e46c0745..e8ae6edf2f58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8141,6 +8141,11 @@ static bool is_helper_call(const struct bpf_call_arg_meta *meta, enum bpf_func_i
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
@@ -12041,27 +12046,27 @@ static bool is_kfunc_ret_null(struct bpf_call_arg_meta *meta)
 
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
@@ -12102,9 +12107,9 @@ get_kfunc_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
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
@@ -12315,15 +12320,15 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
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
@@ -13011,7 +13016,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 				return -EINVAL;
 			}
 
-			if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx]) {
+			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_cast_to_kern_ctx])) {
 				ret = get_kern_ctx_btf_id(&env->log, resolve_prog_type(env->prog));
 				if (ret < 0)
 					return -EINVAL;
@@ -13068,17 +13073,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
 
@@ -13097,7 +13102,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
-			if (meta->func_id == special_kfunc_list[KF_bpf_iter_css_task_new]) {
+			if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_iter_css_task_new])) {
 				if (!check_css_task_iter_allowlist(env)) {
 					verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
 					return -EINVAL;
@@ -13473,11 +13478,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 
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
@@ -13820,12 +13826,12 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
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
@@ -13845,8 +13851,8 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 				"kfunc bpf_rdonly_cast type ID argument must be of a struct or void\n");
 			return -EINVAL;
 		}
-	} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice] ||
-		   meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
+	} else if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_slice]) ||
+		   is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_slice_rdwr])) {
 		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->dynptr.type);
 
 		mark_reg_known_zero(env, regs, BPF_REG_0);
@@ -13861,7 +13867,7 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg
 		/* PTR_MAYBE_NULL will be added when is_kfunc_ret_null is checked */
 		regs[BPF_REG_0].type = PTR_TO_MEM | type_flag;
 
-		if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice]) {
+		if (is_kfunc_call(meta, special_kfunc_list[KF_bpf_dynptr_slice])) {
 			regs[BPF_REG_0].type |= MEM_RDONLY;
 		} else {
 			/* this will set env->seen_direct_write to true */
-- 
2.52.0

