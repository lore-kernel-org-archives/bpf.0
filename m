Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBE33CE8A
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638174; cv=none; b=TqwmMnqHfy4I1H5Ipf7IA/Hbruy849Am9pIyN3W6a8pvEcz0jqUKAyJzAP2MXmLvlEd8tl1gAiiNoULc8HaWph0Z5E8SubB7L+Jlbf3lXjWtJJGJWpQoU0AZEnuasE1pxuH0kKeeHzl74/DU7VD/893G0Af4B8JBodEeU+gvxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638174; c=relaxed/simple;
	bh=KRl4XI34dUZWGhY5LF/dmUt9QPVboidk5I/midgXLO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftld/2fbWQXhRx+Q+TLOWKLBB/JRAahSKkcXu/2TPVfxMjDn3hJNDZ9Hg3rSE+mRuX6tGOMhecD1phpTSgaGVDqO6ENU3C4dZYOLUzRLxGOPtq74Cq5U/psUoOS5OlIIXj0YF6NHsk5aEwS4CjtBIqWbeOJZWF+PUwoXHyfVJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/zf9mOO; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/zf9mOO"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb5a9f02e8so195459a34.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 16:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783638171; x=1784242971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7wAe383dW17VYsXt1ufOLuZLeRFGQz7pPZVpzd+sHpw=;
        b=o/zf9mOOrWrs9rXt1BmpXr4p7mRKypuEA0mM1mnfQieMSVlYXa8fznfPNXphLOfPTO
         t+mWGmjSVWDJccU9HGd9+mqCILWVyDmrgRsYEbQbNO9+a3u8LC0JAqZqaDW7bY47YJDD
         awUkNufYSSD2/+k9jlY7qcm0agun888uwhpmxFz9iz9xrXcmWXCZezMzPztbhovOnE6Z
         fY70JskB1NUL58EEHxsUJk6wmnxQaU3MFbD7BnIlq2YmewaPgODghP6P66yPn3azWLbh
         CR8CyaHGweZ2HU3Eg5zL4aOuPDNZMcxbCxoJAFyMmh0WinDLYx0pcxxcjyaB6Zzr8Cc7
         vfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638171; x=1784242971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wAe383dW17VYsXt1ufOLuZLeRFGQz7pPZVpzd+sHpw=;
        b=ZhVc+v3R3WGCYWga+WTD9rMYOR/f+HZMUoC2zG7jTXfhDMhPKOS93bR4CDxD+5hiat
         CEo/xaa+E622BPPtSdjDeAXinlbmfTZd7JsCoZjL0vS9/hpWCaC6blzx/Ee0svl0eNPS
         mZ1P44sL2qGdvPMZIr9iheTy1XhiGvB0wBEHEsurOmUzjuCVIupTIiPYunx0glyLeWKB
         dIXPJdgks/XRxGM31dTWrousHWSKIcF0tPBEJ0cFAsb/g855NuH1LIO+6dG1In+l9vCh
         wu9pMRiAA64ziyGqGj5jODY9WPq4ExlbZLjN0VkQjuSPoKXCJ9mQMW5AhmgQGFDS0e5p
         EPlw==
X-Gm-Message-State: AOJu0YyU2CiSUbY0CH29oHmEhxEmBj0Q6NoDRW9iuMB4Bju1emj+dX85
	C4nPN7s2SkMzly6jiEAHHI2U3FG3Nr8ENQBsaz+8IOu3MoEhefNBCnDRMj363A==
X-Gm-Gg: AfdE7cmGTrskjAndJY1BHoIwMX4E8664cerw88y006Q9ReiX7A77nJk4EuVzbchbql2
	I/BUtnb/QErM1RJRwhIKk4ZU59S4RaBvf4VVI/tmYiDHesPcfd+CYMoZJs9En6Qjf5e2rUNERaZ
	amWuENIOL/a6AR0fnlGOuETsDu4fsHzGgvDm/y0BKeAOQgnmusyCUVEOKu0pPRCIEHRrRWV3clv
	CPpkcTG/O0u5oIgKRvtRMLw7CyCYmWIrdSxZ+D0QGnZXb4cyAGrBmPkPnuQXuEDZXksBXWC/sOM
	GVEogCpWkNMr0lNSilsVxEwLAryBT5kUcqT59VtTsY8H4rM8uczWTVu2vW7a3AUJ2ufvDL4DT7x
	9hsi70jMiqq+K2XLlVgcaf9PGvnsekeBertGv8YQNZ25V3oUpmbcKVruok9ITOoNrs1yTR6atyq
	U7gA==
X-Received: by 2002:a05:6830:82a5:b0:7e9:cc39:2ef0 with SMTP id 46e09a7af769-7ebcff4f59fmr6799422a34.18.1783638170623;
        Thu, 09 Jul 2026 16:02:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bc0d0sm5247629a34.19.2026.07.09.16.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 16:02:50 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/4] bpf: Unify helper and kfunc call argument meta
Date: Thu,  9 Jul 2026 16:02:41 -0700
Message-ID: <20260709230242.2003459-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709230242.2003459-1-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helper and kfunc argument checking carried two separate meta structs: the
verifier-local struct bpf_call_arg_meta and bpf_kfunc_call_arg_meta.
Merge them into a single struct bpf_call_arg_meta. This is groundwork for
sharing argument checking between helpers and kfuncs.

While merging, drop the btf_id field from the helper meta since it is
never used.

No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h | 40 +++++++++------
 kernel/bpf/cfg.c             |  2 +-
 kernel/bpf/verifier.c        | 95 +++++++++++++++---------------------
 3 files changed, 63 insertions(+), 74 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3ed788ec6afc..5fbc3dfe5b19 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1479,18 +1479,24 @@ struct arg_alloc_mem_desc {
 	bool found;
 };
 
-struct bpf_kfunc_call_arg_meta {
-	/* In parameters */
+struct bpf_call_arg_meta {
+	/* Common */
 	struct btf *btf;
 	u32 func_id;
-	u32 kfunc_flags;
-	const struct btf_type *func_proto;
-	const char *func_name;
-	/* Out parameters */
 	u8 release_regno;
-	bool r0_rdonly;
 	u32 ret_btf_id;
 	u32 subprogno;
+	struct bpf_map_desc map;
+	struct bpf_dynptr_desc dynptr;
+	struct ref_obj_desc ref_obj;
+	struct arg_raw_mem_desc arg_raw_mem;
+	struct arg_alloc_mem_desc arg_alloc_mem;
+
+	/* Only set by kfunc */
+	bool r0_rdonly;
+	u32 kfunc_flags;
+	const struct btf_type *func_proto;
+	const char *func_name;
 	struct {
 		u64 value;
 		bool found;
@@ -1521,29 +1527,31 @@ struct bpf_kfunc_call_arg_meta {
 		u8 spi;
 		u8 frameno;
 	} iter;
-	struct bpf_map_desc map;
-	struct bpf_dynptr_desc dynptr;
-	struct ref_obj_desc ref_obj;
-	struct arg_raw_mem_desc arg_raw_mem;
-	struct arg_alloc_mem_desc arg_alloc_mem;
+
+	/* Only set by helper */
+	bool pkt_access;
+	u64 msize_max_value;
+	s64 const_map_key;
+	struct btf *ret_btf;
+	struct btf_field *kptr_field;
 };
 
 int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
 			 const struct bpf_func_proto **ptr);
 int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env, s32 func_id,
-			     s16 offset, struct bpf_kfunc_call_arg_meta *meta);
+			     s16 offset, struct bpf_call_arg_meta *meta);
 bool bpf_is_async_callback_calling_insn(struct bpf_insn *insn);
 bool bpf_is_sync_callback_calling_insn(struct bpf_insn *insn);
-static inline bool bpf_is_iter_next_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+static inline bool bpf_is_iter_next_kfunc(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ITER_NEXT;
 }
 
-static inline bool bpf_is_kfunc_sleepable(struct bpf_kfunc_call_arg_meta *meta)
+static inline bool bpf_is_kfunc_sleepable(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
-bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta);
+bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 26d37066465f..db3416a7c904 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -491,7 +491,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 					return ret;
 			}
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
-			struct bpf_kfunc_call_arg_meta meta;
+			struct bpf_call_arg_meta meta;
 
 			ret = bpf_fetch_kfunc_arg_meta(env, insn->imm, insn->off, &meta);
 			if (ret == 0 && bpf_is_iter_next_kfunc(&meta)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fcd9715eff01..5ccb00a8c84c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -252,25 +252,6 @@ static int validate_ref_obj(struct bpf_verifier_env *env, struct ref_obj_desc *r
 	return 0;
 }
 
-struct bpf_call_arg_meta {
-	struct bpf_map_desc map;
-	struct bpf_dynptr_desc dynptr;
-	struct ref_obj_desc ref_obj;
-	struct arg_raw_mem_desc arg_raw_mem;
-	struct arg_alloc_mem_desc arg_alloc_mem;
-	bool pkt_access;
-	u8 release_regno;
-	u64 msize_max_value;
-	int func_id;
-	struct btf *btf;
-	u32 btf_id;
-	struct btf *ret_btf;
-	u32 ret_btf_id;
-	u32 subprogno;
-	struct btf_field *kptr_field;
-	s64 const_map_key;
-};
-
 struct bpf_kfunc_meta {
 	struct btf *btf;
 	const struct btf_type *proto;
@@ -928,10 +909,10 @@ static void __mark_reg_known_zero(struct bpf_reg_state *reg);
 
 static bool in_rcu_cs(struct bpf_verifier_env *env);
 
-static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta);
+static bool is_kfunc_rcu_protected(struct bpf_call_arg_meta *meta);
 
 static int mark_stack_slots_iter(struct bpf_verifier_env *env,
-				 struct bpf_kfunc_call_arg_meta *meta,
+				 struct bpf_call_arg_meta *meta,
 				 struct bpf_reg_state *reg, int insn_idx,
 				 struct btf *btf, u32 btf_id, int nr_slots)
 {
@@ -1064,7 +1045,7 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
 static int release_irq_state(struct bpf_verifier_state *state, int id);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
-				     struct bpf_kfunc_call_arg_meta *meta,
+				     struct bpf_call_arg_meta *meta,
 				     struct bpf_reg_state *reg, int insn_idx,
 				     int kfunc_class)
 {
@@ -7246,7 +7227,7 @@ static int process_timer_helper(struct bpf_verifier_env *env, struct bpf_reg_sta
 }
 
 static int process_timer_kfunc(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-			       struct bpf_kfunc_call_arg_meta *meta)
+			       struct bpf_call_arg_meta *meta)
 {
 	return process_timer_func(env, reg, argno, &meta->map);
 }
@@ -7413,23 +7394,23 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
 	return err;
 }
 
-static bool is_iter_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_iter_kfunc(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
 }
 
-static bool is_iter_new_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_iter_new_kfunc(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ITER_NEW;
 }
 
 
-static bool is_iter_destroy_kfunc(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_iter_destroy_kfunc(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ITER_DESTROY;
 }
 
-static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
+static bool is_kfunc_arg_iter(struct bpf_call_arg_meta *meta, int arg_idx,
 			      const struct btf_param *arg)
 {
 	/* btf_check_iter_kfuncs() guarantees that first argument of any iter
@@ -7443,7 +7424,7 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
 }
 
 static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
-			    struct bpf_kfunc_call_arg_meta *meta)
+			    struct bpf_call_arg_meta *meta)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	const struct btf_type *t;
@@ -7610,7 +7591,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 }
 
 static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_st,
-						 struct bpf_kfunc_call_arg_meta *meta)
+						 struct bpf_call_arg_meta *meta)
 {
 	int iter_frameno = meta->iter.frameno;
 	int iter_spi = meta->iter.spi;
@@ -7697,7 +7678,7 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
  *     bpf_iter_num_destroy(&it);
  */
 static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
-				  struct bpf_kfunc_call_arg_meta *meta)
+				  struct bpf_call_arg_meta *meta)
 {
 	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
@@ -10748,27 +10729,27 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
 	return __mark_btf_func_reg_size(env, cur_regs(env), regno, reg_size);
 }
 
-static bool is_kfunc_acquire(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_acquire(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ACQUIRE;
 }
 
-static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_release(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_RELEASE;
 }
 
-static bool is_kfunc_destructive(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_destructive(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_DESTRUCTIVE;
 }
 
-static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_rcu(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_RCU;
 }
 
-static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_rcu_protected(struct bpf_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_RCU_PROTECTED;
 }
@@ -10989,7 +10970,7 @@ static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param
  * To determine whether an argument is implicit, we compare its position
  * against the number of arguments in the prototype w/o implicit args.
  */
-static bool is_kfunc_arg_implicit(const struct bpf_kfunc_call_arg_meta *meta, u32 arg_idx)
+static bool is_kfunc_arg_implicit(const struct bpf_call_arg_meta *meta, u32 arg_idx)
 {
 	const struct btf_type *func, *func_proto;
 	u32 argn;
@@ -11288,7 +11269,7 @@ static bool is_task_work_add_kfunc(u32 func_id)
 	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume];
 }
 
-static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_ret_null(struct bpf_call_arg_meta *meta)
 {
 	if (is_bpf_refcount_acquire_kfunc(meta->func_id) && meta->arg_owning_ref)
 		return false;
@@ -11296,34 +11277,34 @@ static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_RET_NULL;
 }
 
-static bool is_kfunc_bpf_rcu_read_lock(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_bpf_rcu_read_lock(struct bpf_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_lock];
 }
 
-static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_bpf_rcu_read_unlock(struct bpf_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_rcu_read_unlock];
 }
 
-static bool is_kfunc_bpf_preempt_disable(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_bpf_preempt_disable(struct bpf_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_preempt_disable];
 }
 
-static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
 }
 
-bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
+bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
 	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
 }
 
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_func_state *caller,
-		       struct bpf_reg_state *regs, struct bpf_kfunc_call_arg_meta *meta,
+		       struct bpf_reg_state *regs, struct bpf_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
 		       const char *ref_tname, const struct btf_param *args,
 		       int arg, int nargs, argno_t argno, struct bpf_reg_state *reg)
@@ -11429,7 +11410,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 					struct bpf_reg_state *reg,
 					const struct btf_type *ref_t,
 					const char *ref_tname, u32 ref_id,
-					struct bpf_kfunc_call_arg_meta *meta,
+					struct bpf_call_arg_meta *meta,
 					int arg, argno_t argno)
 {
 	const struct btf_type *reg_ref_t;
@@ -11499,7 +11480,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 }
 
 static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-			     struct bpf_kfunc_call_arg_meta *meta)
+			     struct bpf_call_arg_meta *meta)
 {
 	int err, spi, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
@@ -11824,7 +11805,7 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 static int
 __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, argno_t argno,
-				   struct bpf_kfunc_call_arg_meta *meta,
+				   struct bpf_call_arg_meta *meta,
 				   enum btf_field_type head_field_type,
 				   struct btf_field **head_field)
 {
@@ -11874,7 +11855,7 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
 
 static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, argno_t argno,
-					   struct bpf_kfunc_call_arg_meta *meta)
+					   struct bpf_call_arg_meta *meta)
 {
 	return __process_kf_arg_ptr_to_graph_root(env, reg, argno, meta, BPF_LIST_HEAD,
 							  &meta->arg_list_head.field);
@@ -11882,7 +11863,7 @@ static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
 
 static int process_kf_arg_ptr_to_rbtree_root(struct bpf_verifier_env *env,
 					     struct bpf_reg_state *reg, argno_t argno,
-					     struct bpf_kfunc_call_arg_meta *meta)
+					     struct bpf_call_arg_meta *meta)
 {
 	return __process_kf_arg_ptr_to_graph_root(env, reg, argno, meta, BPF_RB_ROOT,
 							  &meta->arg_rbtree_root.field);
@@ -11891,7 +11872,7 @@ static int process_kf_arg_ptr_to_rbtree_root(struct bpf_verifier_env *env,
 static int
 __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, argno_t argno,
-				   struct bpf_kfunc_call_arg_meta *meta,
+				   struct bpf_call_arg_meta *meta,
 				   enum btf_field_type head_field_type,
 				   enum btf_field_type node_field_type,
 				   struct btf_field **node_field)
@@ -11956,7 +11937,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 
 static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, argno_t argno,
-					   struct bpf_kfunc_call_arg_meta *meta)
+					   struct bpf_call_arg_meta *meta)
 {
 	return __process_kf_arg_ptr_to_graph_node(env, reg, argno, meta,
 						  BPF_LIST_HEAD, BPF_LIST_NODE,
@@ -11965,7 +11946,7 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 
 static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
 					     struct bpf_reg_state *reg, argno_t argno,
-					     struct bpf_kfunc_call_arg_meta *meta)
+					     struct bpf_call_arg_meta *meta)
 {
 	return __process_kf_arg_ptr_to_graph_node(env, reg, argno, meta,
 						  BPF_RB_ROOT, BPF_RB_NODE,
@@ -11994,7 +11975,7 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 	}
 }
 
-static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
+static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			    int insn_idx)
 {
 	const char *func_name = meta->func_name, *ref_tname;
@@ -12573,7 +12554,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
 			     s32 func_id,
 			     s16 offset,
-			     struct bpf_kfunc_call_arg_meta *meta)
+			     struct bpf_call_arg_meta *meta)
 {
 	struct bpf_kfunc_meta kfunc;
 	int err;
@@ -12732,7 +12713,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 				 int arg, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
-	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_call_arg_meta meta;
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t;
 	const struct btf *btf;
@@ -12793,7 +12774,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
  *  0  - fall-through to 'else' branch
  * < 0 - not fall-through to 'else' branch, return error
  */
-static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
+static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			       struct bpf_reg_state *regs, struct bpf_insn_aux_data *insn_aux,
 			       const struct btf_type *ptr_type, struct btf *desc_btf)
 {
@@ -12972,7 +12953,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_reg_state *regs = cur_regs(env);
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
-	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
@@ -16726,7 +16707,7 @@ bool bpf_verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			  struct bpf_call_summary *cs)
 {
-	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_call_arg_meta meta;
 	const struct bpf_func_proto *fn;
 	int i;
 
-- 
2.52.0

