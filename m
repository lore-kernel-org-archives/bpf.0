Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BB31AAA8
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097665; cv=none; b=O1Zg8ILC5iXLTRZ1JvpScR/NFyM+RyXos/nd4i4YhQqqMx6/TW44BYcaV4qxOHy/YuM0o13XJTgileNCf6m7RuZ/htugAp/LVKIDPs+SyO+dhu286ybts7/u/dsp4SEbLW0Tlr4yB2/dujW5d9fhDrmWUaKE0ESnEsgGlVWd2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097665; c=relaxed/simple;
	bh=PsyezPmsCCqSciSrrn3Yl57lfZC59g7PBWVyHd1ttno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2ST2tAYZtmKkHFxYHhwQbpd3LHe9yCPd1s80v1d+pFgHC3fXuYY3AXkBW12npLHU+pExHNZivh7fv6l3Adh2AEJbluEqBRad0yNXzWChj02GlpGGBowFWb+HLz+ohs92DEMEzncmJ0r7SiXfajBfZfm2MvJb8JMlwydwzIsN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABEM+Y0Y; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABEM+Y0Y"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-447a81776e9so1748138fac.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097662; x=1784702462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikehVD3Ioaie670Q5ju2NRfRRVoNm9sy4ADNFM7FNpY=;
        b=ABEM+Y0Yk5dr/FlzhNaVhaO8bL3/kvjRiJvy/1NfaJJoTUQddNY5QQbiP8gc5wZcP0
         l5r2C+qSAr6w5yPU6Gqg3gYLRd/wFKGXc6ve/3rqz1VJdIwFHViuJZaycXNDSCW1srzS
         /uVq+McbZ9nIo4iSFiEk43bD167RG8wCnQ/md0e+HxLCYh8sEtE0ubelVxiaKWUcz2Zb
         DpzzsKoSD1uwwNjSKxd+6gfykxsFXfr9Ichf2q8BQ3mQWUqwzS9OscCmORJzxDFg33wq
         sRQI64LGdQv8cJEre994eGqW4jEBsAnEvyenA7Ccb7V8xQYOT50hHXGIzL5c3WoB2AaX
         IqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097662; x=1784702462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ikehVD3Ioaie670Q5ju2NRfRRVoNm9sy4ADNFM7FNpY=;
        b=PX4nf9EZOwMzfrdcRh+Ek5p0UHHcXbZDPpuJeHwZZHwLu5tWFT2nX2x++/HasTMfwY
         hE0HizUjo1lyAmk1X6HtolZhg7EiX5b2C50l3mqtfQcownuQbGagLRW5tIO5N6YGF3OK
         kVx2Dsh/rDpbUmpdOEfe+Qha0DwNymWy4fYOaMpEYQatdNHXCPUhEDx3JPFjI3hGSWAD
         lrIrBzT4lhVzrRazefDpcnbNb3GpUELrCvmxL7G8WT1PayGz9J8xz+93knlo4Vv71Ysj
         KvTvHlCWZ5nY34TNzaMx3vjNSRBKQqVX/ZG2QbxeQqqgocmUYZAEukTo8oIaMB0R6rBs
         kERg==
X-Gm-Message-State: AOJu0Yzb61ivYMtizTDBEY7Z78NnYkbOcSzTHKhe6NmPNRP+IW3/K4dZ
	ia97O5KwJDzyVpTE2FsULceDNYxzLEv6hwAO+6WueqQWCUuc9y/Jt7/pUTyy1Q==
X-Gm-Gg: AfdE7cn3hxr9Gfr/swwEWt4iTwDF0E9nYW3tg9LkmDsx3F0yuBJOZlTCXmiXoXHKh4o
	VJ9OgcNizewgCBYfpiXmjPBWUTXnFwMWHT3yr9x3cBfwEgx4N1F1LgpqburXnkURNkJ/Nh11jnW
	DWLQlTXcjV2iTeeZAZu384a1MwYUhRmx+sttBN6qloAuM0tS2QZzHvT96CokNaqmHKjIxDO08lv
	HBOVV/yt92k/DwdRhOyspyvtnJtqW21sRIMCEbR2IoA3pMnyz7gCInUS1aENlyELLHzq9lfSeY1
	bmvdlH1KCJSn+QeIx4ucJtpAmHDGBJwT2Sp0BvCg3n6ZPnqMgO+tb16/vN0Db/IwuVAgfCgX/QI
	tdZKpOaST5FuxNphIPiu2fq7+jD9I+9mXZiFbwZVqcgisjSc1VoewMSESiwK3yRWKs+4kHpxN2U
	kVDQ==
X-Received: by 2002:a05:6870:708a:b0:428:27a4:ada with SMTP id 586e51a60fabf-4560b500deamr2883626fac.10.1784097662324;
        Tue, 14 Jul 2026 23:41:02 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm18966429fac.15.2026.07.14.23.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:41:01 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 7/7] bpf: Unify helper and kfunc call argument meta
Date: Tue, 14 Jul 2026 23:40:47 -0700
Message-ID: <20260715064047.1793790-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715064047.1793790-1-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h | 38 +++++++++------
 kernel/bpf/cfg.c             |  2 +-
 kernel/bpf/verifier.c        | 94 +++++++++++++++---------------------
 3 files changed, 62 insertions(+), 72 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e3eda72cbf67..682c2cd3b844 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1479,18 +1479,23 @@ struct ret_mem_desc {
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
+	struct ret_mem_desc ret_mem;
+
+	/* Only set by kfunc */
+	bool r0_rdonly;
+	u32 kfunc_flags;
+	const struct btf_type *func_proto;
+	const char *func_name;
 	struct {
 		u64 value;
 		bool found;
@@ -1521,28 +1526,31 @@ struct bpf_kfunc_call_arg_meta {
 		u8 spi;
 		u8 frameno;
 	} iter;
-	struct bpf_map_desc map;
-	struct bpf_dynptr_desc dynptr;
-	struct ref_obj_desc ref_obj;
-	struct ret_mem_desc ret_mem;
+
+	/* Only set by helper */
+	u64 msize_max_value;
+	s64 const_map_key;
+	struct btf *ret_btf;
+	struct btf_field *kptr_field;
+	struct arg_raw_mem_desc arg_raw_mem;
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
index 37127ae1ff28..de816063ae63 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -252,24 +252,6 @@ static int validate_ref_obj(struct bpf_verifier_env *env, struct ref_obj_desc *r
 	return 0;
 }
 
-struct bpf_call_arg_meta {
-	struct bpf_map_desc map;
-	struct bpf_dynptr_desc dynptr;
-	struct ref_obj_desc ref_obj;
-	struct arg_raw_mem_desc arg_raw_mem;
-	struct ret_mem_desc ret_mem;
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
@@ -927,10 +909,10 @@ static void __mark_reg_known_zero(struct bpf_reg_state *reg);
 
 static bool in_rcu_cs(struct bpf_verifier_env *env);
 
-static bool is_kfunc_rcu_protected(struct bpf_kfunc_call_arg_meta *meta);
+static bool is_kfunc_rcu_protected(struct bpf_call_arg_meta *meta);
 
 static int mark_stack_slots_iter(struct bpf_verifier_env *env,
-				 struct bpf_kfunc_call_arg_meta *meta,
+				 struct bpf_call_arg_meta *meta,
 				 struct bpf_reg_state *reg, int insn_idx,
 				 struct btf *btf, u32 btf_id, int nr_slots)
 {
@@ -1063,7 +1045,7 @@ static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx);
 static int release_irq_state(struct bpf_verifier_state *state, int id);
 
 static int mark_stack_slot_irq_flag(struct bpf_verifier_env *env,
-				     struct bpf_kfunc_call_arg_meta *meta,
+				     struct bpf_call_arg_meta *meta,
 				     struct bpf_reg_state *reg, int insn_idx,
 				     int kfunc_class)
 {
@@ -7245,7 +7227,7 @@ static int process_timer_helper(struct bpf_verifier_env *env, struct bpf_reg_sta
 }
 
 static int process_timer_kfunc(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-			       struct bpf_kfunc_call_arg_meta *meta)
+			       struct bpf_call_arg_meta *meta)
 {
 	return process_timer_func(env, reg, argno, &meta->map);
 }
@@ -7412,23 +7394,23 @@ static int process_dynptr_func(struct bpf_verifier_env *env, struct bpf_reg_stat
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
@@ -7442,7 +7424,7 @@ static bool is_kfunc_arg_iter(struct bpf_kfunc_call_arg_meta *meta, int arg_idx,
 }
 
 static int process_iter_arg(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int insn_idx,
-			    struct bpf_kfunc_call_arg_meta *meta)
+			    struct bpf_call_arg_meta *meta)
 {
 	struct bpf_func_state *state = bpf_func(env, reg);
 	const struct btf_type *t;
@@ -7609,7 +7591,7 @@ static int widen_imprecise_scalars(struct bpf_verifier_env *env,
 }
 
 static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_st,
-						 struct bpf_kfunc_call_arg_meta *meta)
+						 struct bpf_call_arg_meta *meta)
 {
 	int iter_frameno = meta->iter.frameno;
 	int iter_spi = meta->iter.spi;
@@ -7696,7 +7678,7 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
  *     bpf_iter_num_destroy(&it);
  */
 static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
-				  struct bpf_kfunc_call_arg_meta *meta)
+				  struct bpf_call_arg_meta *meta)
 {
 	struct bpf_verifier_state *cur_st = env->cur_state, *queued_st, *prev_st;
 	struct bpf_func_state *cur_fr = cur_st->frame[cur_st->curframe], *queued_fr;
@@ -10750,27 +10732,27 @@ static void mark_btf_func_reg_size(struct bpf_verifier_env *env, u32 regno,
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
@@ -10991,7 +10973,7 @@ static bool is_kfunc_arg_prog_aux(const struct btf *btf, const struct btf_param
  * To determine whether an argument is implicit, we compare its position
  * against the number of arguments in the prototype w/o implicit args.
  */
-static bool is_kfunc_arg_implicit(const struct bpf_kfunc_call_arg_meta *meta, u32 arg_idx)
+static bool is_kfunc_arg_implicit(const struct bpf_call_arg_meta *meta, u32 arg_idx)
 {
 	const struct btf_type *func, *func_proto;
 	u32 argn;
@@ -11290,7 +11272,7 @@ static bool is_task_work_add_kfunc(u32 func_id)
 	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume];
 }
 
-static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
+static bool is_kfunc_ret_null(struct bpf_call_arg_meta *meta)
 {
 	if (is_bpf_refcount_acquire_kfunc(meta->func_id) && meta->arg_owning_ref)
 		return false;
@@ -11298,34 +11280,34 @@ static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
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
@@ -11431,7 +11413,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 					struct bpf_reg_state *reg,
 					const struct btf_type *ref_t,
 					const char *ref_tname, u32 ref_id,
-					struct bpf_kfunc_call_arg_meta *meta,
+					struct bpf_call_arg_meta *meta,
 					int arg, argno_t argno)
 {
 	const struct btf_type *reg_ref_t;
@@ -11501,7 +11483,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 }
 
 static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno,
-			     struct bpf_kfunc_call_arg_meta *meta)
+			     struct bpf_call_arg_meta *meta)
 {
 	int err, spi, kfunc_class = IRQ_NATIVE_KFUNC;
 	bool irq_save;
@@ -11826,7 +11808,7 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 static int
 __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, argno_t argno,
-				   struct bpf_kfunc_call_arg_meta *meta,
+				   struct bpf_call_arg_meta *meta,
 				   enum btf_field_type head_field_type,
 				   struct btf_field **head_field)
 {
@@ -11876,7 +11858,7 @@ __process_kf_arg_ptr_to_graph_root(struct bpf_verifier_env *env,
 
 static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, argno_t argno,
-					   struct bpf_kfunc_call_arg_meta *meta)
+					   struct bpf_call_arg_meta *meta)
 {
 	return __process_kf_arg_ptr_to_graph_root(env, reg, argno, meta, BPF_LIST_HEAD,
 							  &meta->arg_list_head.field);
@@ -11884,7 +11866,7 @@ static int process_kf_arg_ptr_to_list_head(struct bpf_verifier_env *env,
 
 static int process_kf_arg_ptr_to_rbtree_root(struct bpf_verifier_env *env,
 					     struct bpf_reg_state *reg, argno_t argno,
-					     struct bpf_kfunc_call_arg_meta *meta)
+					     struct bpf_call_arg_meta *meta)
 {
 	return __process_kf_arg_ptr_to_graph_root(env, reg, argno, meta, BPF_RB_ROOT,
 							  &meta->arg_rbtree_root.field);
@@ -11893,7 +11875,7 @@ static int process_kf_arg_ptr_to_rbtree_root(struct bpf_verifier_env *env,
 static int
 __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, argno_t argno,
-				   struct bpf_kfunc_call_arg_meta *meta,
+				   struct bpf_call_arg_meta *meta,
 				   enum btf_field_type head_field_type,
 				   enum btf_field_type node_field_type,
 				   struct btf_field **node_field)
@@ -11958,7 +11940,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 
 static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 					   struct bpf_reg_state *reg, argno_t argno,
-					   struct bpf_kfunc_call_arg_meta *meta)
+					   struct bpf_call_arg_meta *meta)
 {
 	return __process_kf_arg_ptr_to_graph_node(env, reg, argno, meta,
 						  BPF_LIST_HEAD, BPF_LIST_NODE,
@@ -11967,7 +11949,7 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
 
 static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
 					     struct bpf_reg_state *reg, argno_t argno,
-					     struct bpf_kfunc_call_arg_meta *meta)
+					     struct bpf_call_arg_meta *meta)
 {
 	return __process_kf_arg_ptr_to_graph_node(env, reg, argno, meta,
 						  BPF_RB_ROOT, BPF_RB_NODE,
@@ -11996,7 +11978,7 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 	}
 }
 
-static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
+static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			    int insn_idx)
 {
 	const char *func_name = meta->func_name, *ref_tname;
@@ -12575,7 +12557,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
 			     s32 func_id,
 			     s16 offset,
-			     struct bpf_kfunc_call_arg_meta *meta)
+			     struct bpf_call_arg_meta *meta)
 {
 	struct bpf_kfunc_meta kfunc;
 	int err;
@@ -12734,7 +12716,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
 				 int arg, int insn_idx)
 {
 	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
-	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_call_arg_meta meta;
 	const struct btf_param *args;
 	const struct btf_type *t, *ref_t;
 	const struct btf *btf;
@@ -12795,7 +12777,7 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
  *  0  - fall-through to 'else' branch
  * < 0 - not fall-through to 'else' branch, return error
  */
-static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
+static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 			       struct bpf_reg_state *regs, struct bpf_insn_aux_data *insn_aux,
 			       const struct btf_type *ptr_type, struct btf *desc_btf)
 {
@@ -12974,7 +12956,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_reg_state *regs = cur_regs(env);
 	const char *func_name, *ptr_type_name;
 	const struct btf_type *t, *ptr_type;
-	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_call_arg_meta meta;
 	struct bpf_insn_aux_data *insn_aux;
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
@@ -16728,7 +16710,7 @@ bool bpf_verifier_inlines_helper_call(struct bpf_verifier_env *env, s32 imm)
 bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			  struct bpf_call_summary *cs)
 {
-	struct bpf_kfunc_call_arg_meta meta;
+	struct bpf_call_arg_meta meta;
 	const struct bpf_func_proto *fn;
 	int i;
 
-- 
2.52.0

