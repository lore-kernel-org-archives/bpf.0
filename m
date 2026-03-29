Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4F3793B0
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793127; cv=none; b=PghCZbK7HdeMPrBsecU3EDD4o0XuRJoZk+UTs7JQXtIWPhixjntSeZYuzLwPiEfkdewMihWTeRzx4nfPxFfQ+S+mAeXTRgRx1AbclwwVDtba5soNek7lBcmecYrP7k5rXKbZBo6g6IFetaHbLoq/uE/LXIyiceuq6xagOQEs8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793127; c=relaxed/simple;
	bh=4gRW1+mtRMcdZfAHAzXm2KNnewoZoCSS46EQVHhhBP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9UksDMSvKDvuNA7itR0g/4yaoIuzJFR/kRUWGzn5X3rQ7EA4gp1A5xlzZNe22pz5xpFXnuEDtEU9vowCe9nMnX2NZs1ygzlknEwM9dIQ3LlXvEmOsrFCZshn42y28y2Ol0ZKvUAuLE9dRRlRhsAg3d0QdB0extVI6LOEncI8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsqBWlf/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsqBWlf/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso2327223a91.3
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793125; x=1775397925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi9szT9Syd9CFHAlHUGFYC/MCx4DDJNTxIJ9cbtZIrc=;
        b=CsqBWlf/TJjr0wVtBvbWZ5At3LF6/QmJjR6a0TOMhtQJ8zyKgqZkYjYyo3KXw/MQEH
         Nyn0nyOn22yAfoXAcFAkJ2RkmNn0kwQQX7JMUn9KSlJJ7qx9lp/lIyneRS6pj5kotAlH
         fKu6gqiqPCTLFy+UL9/8lZbSs3D0wGu4toU0d6NCBt2TtXkIHYhfur1/td5GguN+vz3l
         1twyGiIzGzO6qEbPsS3M3XtIK1XQHGNpDrutVJGTNC4ugHHJLtrY5E4KId2HV8cb7uNh
         +etHvajuyQBZELZFTq4l+cz3PgHQqJKDEKP69aVRbc/bvXxVqp/15bkBmV0G4yKQxbQ6
         kZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793125; x=1775397925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mi9szT9Syd9CFHAlHUGFYC/MCx4DDJNTxIJ9cbtZIrc=;
        b=NXWZnFPVRC/WsUJiyzXwCyc9n1XWc94BL+jj1oDcyLp94gBMPKrO+pLliT81uFT9EB
         QxA98KRFdMaqa5YsjLWkv/TOxyVe3Z0lJe7G2+FSoLxiE5P9mJ+ITlRlp3Ec54VeY6kQ
         hYtrDiomiNK25weuq5TKkiQ+gNfLf0gNgcw4AkJnHCKTcyA4nE7OO1yd2uRnV6iF/uAe
         mYtKSstyDh69ccDmlYkco8ZAJuN2+grNzScLnoUFMqUG1MKxLfwa26v15eFIIuzN+GdT
         jPI8OYh7udBMeIEpRq9XUr9wIiq04Hn3DM8SCPIp3HU6zBw3KSnbv/GrJW8pRENQV/9m
         fbDw==
X-Gm-Message-State: AOJu0Yyorp3Xm5iIvgNREq6ArqSs7WLK+vhgajw8Sw9R5DnyZAklFDaP
	FsMJTY1KBhJZFnnjB41OgvnomMHDrTbC8MBK8+tcg7Vb4Orw8CJu+e/7
X-Gm-Gg: ATEYQzwNJNUSCKOd+lH5mw5t6NQMAUGklkt4h2h5lKc6qtRgOO/pf+TXZkKsLMsw3PS
	ybDks1hxQBQCoJy2V8vgd3y1WFFWzfO26pv2rSA2SptllqAF9KRcduniGxP5fcup8jULCNBflMh
	BX8Y1ENEbT2afXa4daU3sXgQyvyzR4TdxhBqgSPx62RrsDG4eqo2UMEm2BkBjfqCzGdprhbYrPP
	pGQJlvmqI3p10/yM6EWFclghnOQNwP76ccf4MoMGCrKvwU91xmEv0n++qcjeBxRtYtGtnc5zqgK
	G5eG9BThoV8R9RqnwIY1DtVO/eioFCYGoMcl+wdYeIBFAG6w72JrImUhsMIzApT3fOaJOjOiLWZ
	9zio6sTTxsBewUsbLhdZSBkA8+GYAfOEC1/9iYeeseau8IPGDOR6yU0P0sXSm+00OkW97h286iq
	+e2L5w+fSNnTp4Sx3277fqRsUkUAnggpjZXahznIanTFm9qiN7ekLrKFBbtWxx3t4t
X-Received: by 2002:a17:90a:1048:b0:35d:93ff:2854 with SMTP id 98e67ed59e1d1-35d93ff2b0amr3089975a91.8.1774793125137;
        Sun, 29 Mar 2026 07:05:25 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950bd630sm4417454a91.16.2026.03.29.07.05.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 07:05:24 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v9 1/9] bpf: refactor kfunc checks using table-driven approach in verifier
Date: Sun, 29 Mar 2026 22:04:58 +0800
Message-ID: <20260329140506.9595-2-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260329140506.9595-1-pilgrimtao@gmail.com>
References: <20260329140506.9595-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

Replace per-kfunc btf_id chains check with btf_id_in_kfunc_table() and
static kfunc tables for easier maintenance.

Prepare for future extensions to the bpf_list API family.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
---
 kernel/bpf/verifier.c | 261 +++++++++++++++++++++++-------------------
 1 file changed, 144 insertions(+), 117 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4fbacd2149cd..f2d9863bb290 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -544,9 +544,6 @@ static bool is_async_callback_calling_kfunc(u32 btf_id);
 static bool is_callback_calling_kfunc(u32 btf_id);
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn);
 
-static bool is_bpf_wq_set_callback_kfunc(u32 btf_id);
-static bool is_task_work_add_kfunc(u32 func_id);
-
 static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_for_each_map_elem ||
@@ -586,7 +583,7 @@ static bool is_async_cb_sleepable(struct bpf_verifier_env *env, struct bpf_insn
 
 	/* bpf_wq and bpf_task_work callbacks are always sleepable. */
 	if (bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
-	    (is_bpf_wq_set_callback_kfunc(insn->imm) || is_task_work_add_kfunc(insn->imm)))
+	    is_async_callback_calling_kfunc(insn->imm))
 		return true;
 
 	verifier_bug(env, "unhandled async callback in is_async_cb_sleepable");
@@ -11203,31 +11200,6 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static bool is_rbtree_lock_required_kfunc(u32 btf_id);
-
-/* Are we currently verifying the callback for a rbtree helper that must
- * be called with lock held? If so, no need to complain about unreleased
- * lock
- */
-static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
-{
-	struct bpf_verifier_state *state = env->cur_state;
-	struct bpf_insn *insn = env->prog->insnsi;
-	struct bpf_func_state *callee;
-	int kfunc_btf_id;
-
-	if (!state->curframe)
-		return false;
-
-	callee = state->frame[state->curframe];
-
-	if (!callee->in_callback_fn)
-		return false;
-
-	kfunc_btf_id = insn[callee->callsite].imm;
-	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
-}
-
 static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
 {
 	if (range.return_32bit)
@@ -12639,11 +12611,103 @@ BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
 
-static bool is_task_work_add_kfunc(u32 func_id)
-{
-	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
-	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume];
-}
+/* Kfunc family related to list. */
+static const enum special_kfunc_type bpf_list_api_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+	KF_bpf_list_pop_front,
+	KF_bpf_list_pop_back,
+	KF_bpf_list_front,
+	KF_bpf_list_back,
+};
+
+/* Kfuncs that take a list node argument (bpf_list_node *). */
+static const enum special_kfunc_type bpf_list_node_api_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+};
+
+/* Kfuncs that take an rbtree node argument (bpf_rb_node *). */
+static const enum special_kfunc_type bpf_rbtree_node_api_kfuncs[] = {
+	KF_bpf_rbtree_remove,
+	KF_bpf_rbtree_add_impl,
+	KF_bpf_rbtree_left,
+	KF_bpf_rbtree_right,
+};
+
+/* Kfunc family related to rbtree. */
+static const enum special_kfunc_type bpf_rbtree_api_kfuncs[] = {
+	KF_bpf_rbtree_add_impl,
+	KF_bpf_rbtree_remove,
+	KF_bpf_rbtree_first,
+	KF_bpf_rbtree_root,
+	KF_bpf_rbtree_left,
+	KF_bpf_rbtree_right,
+};
+
+/* Kfunc family related to spin_lock. */
+static const enum special_kfunc_type bpf_res_spin_lock_api_kfuncs[] = {
+	KF_bpf_res_spin_lock,
+	KF_bpf_res_spin_unlock,
+	KF_bpf_res_spin_lock_irqsave,
+	KF_bpf_res_spin_unlock_irqrestore,
+};
+
+/* Kfunc family related to iter_num. */
+static const enum special_kfunc_type bpf_iter_num_api_kfuncs[] = {
+	KF_bpf_iter_num_new,
+	KF_bpf_iter_num_next,
+	KF_bpf_iter_num_destroy,
+};
+
+/* Kfunc family related to arena. */
+static const enum special_kfunc_type bpf_arena_api_kfuncs[] = {
+	KF_bpf_arena_alloc_pages,
+	KF_bpf_arena_free_pages,
+	KF_bpf_arena_reserve_pages,
+};
+
+/* Kfunc family related to stream. */
+static const enum special_kfunc_type bpf_stream_api_kfuncs[] = {
+	KF_bpf_stream_vprintk,
+	KF_bpf_stream_print_stack,
+};
+
+/* Kfuncs that must be called when inserting a node in list/rbtree. */
+static const enum special_kfunc_type bpf_collection_insert_kfuncs[] = {
+	KF_bpf_list_push_front_impl,
+	KF_bpf_list_push_back_impl,
+	KF_bpf_rbtree_add_impl,
+};
+
+/* KF_ACQUIRE kfuncs whose vmlinux BTF return type is void* */
+static const enum special_kfunc_type bpf_obj_acquire_ptr_kfuncs[] = {
+	KF_bpf_obj_new_impl,
+	KF_bpf_percpu_obj_new_impl,
+	KF_bpf_refcount_acquire_impl,
+};
+
+/* Kfunc family related to task_work. */
+static const enum special_kfunc_type bpf_task_work_api_kfuncs[] = {
+	KF_bpf_task_work_schedule_signal,
+	KF_bpf_task_work_schedule_resume,
+};
+
+/* __kfuncs must be an array identifier (not a pointer), for ARRAY_SIZE. */
+#define btf_id_in_kfunc_table(__btf_id, __kfuncs)				\
+	({									\
+		u32 ___id = (__btf_id);						\
+		unsigned int ___i;						\
+		bool ___found = false;						\
+										\
+		for (___i = 0; ___i < ARRAY_SIZE(__kfuncs); ___i++) {		\
+			if (___id == special_kfunc_list[(__kfuncs)[___i]]) {	\
+				___found = true;				\
+				break;						\
+			}							\
+		}								\
+		___found;							\
+	})
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -12680,6 +12744,29 @@ static bool is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
 }
 
+/* Are we currently verifying the callback for a rbtree helper that must
+ * be called with lock held? If so, no need to complain about unreleased
+ * lock
+ */
+static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_insn *insn = env->prog->insnsi;
+	struct bpf_func_state *callee;
+	int kfunc_btf_id;
+
+	if (!state->curframe)
+		return false;
+
+	callee = state->frame[state->curframe];
+
+	if (!callee->in_callback_fn)
+		return false;
+
+	kfunc_btf_id = insn[callee->callsite].imm;
+	return btf_id_in_kfunc_table(kfunc_btf_id, bpf_rbtree_api_kfuncs);
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -13036,65 +13123,20 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 	return 0;
 }
 
-static bool is_bpf_list_api_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_pop_back] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_front] ||
-	       btf_id == special_kfunc_list[KF_bpf_list_back];
-}
-
-static bool is_bpf_rbtree_api_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_first] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_root] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
-	       btf_id == special_kfunc_list[KF_bpf_rbtree_right];
-}
-
-static bool is_bpf_iter_num_api_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_iter_num_new] ||
-	       btf_id == special_kfunc_list[KF_bpf_iter_num_next] ||
-	       btf_id == special_kfunc_list[KF_bpf_iter_num_destroy];
-}
-
 static bool is_bpf_graph_api_kfunc(u32 btf_id)
 {
-	return is_bpf_list_api_kfunc(btf_id) || is_bpf_rbtree_api_kfunc(btf_id) ||
+	return btf_id_in_kfunc_table(btf_id, bpf_list_api_kfuncs) ||
+	       btf_id_in_kfunc_table(btf_id, bpf_rbtree_api_kfuncs) ||
 	       btf_id == special_kfunc_list[KF_bpf_refcount_acquire_impl];
 }
 
-static bool is_bpf_res_spin_lock_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave] ||
-	       btf_id == special_kfunc_list[KF_bpf_res_spin_unlock_irqrestore];
-}
-
-static bool is_bpf_arena_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_arena_alloc_pages] ||
-	       btf_id == special_kfunc_list[KF_bpf_arena_free_pages] ||
-	       btf_id == special_kfunc_list[KF_bpf_arena_reserve_pages];
-}
-
-static bool is_bpf_stream_kfunc(u32 btf_id)
-{
-	return btf_id == special_kfunc_list[KF_bpf_stream_vprintk] ||
-	       btf_id == special_kfunc_list[KF_bpf_stream_print_stack];
-}
-
 static bool kfunc_spin_allowed(u32 btf_id)
 {
-	return is_bpf_graph_api_kfunc(btf_id) || is_bpf_iter_num_api_kfunc(btf_id) ||
-	       is_bpf_res_spin_lock_kfunc(btf_id) || is_bpf_arena_kfunc(btf_id) ||
-	       is_bpf_stream_kfunc(btf_id);
+	return is_bpf_graph_api_kfunc(btf_id) ||
+	       btf_id_in_kfunc_table(btf_id, bpf_iter_num_api_kfuncs) ||
+	       btf_id_in_kfunc_table(btf_id, bpf_res_spin_lock_api_kfuncs) ||
+	       btf_id_in_kfunc_table(btf_id, bpf_arena_api_kfuncs) ||
+	       btf_id_in_kfunc_table(btf_id, bpf_stream_api_kfuncs);
 }
 
 static bool is_sync_callback_calling_kfunc(u32 btf_id)
@@ -13102,12 +13144,6 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl];
 }
 
-static bool is_async_callback_calling_kfunc(u32 btf_id)
-{
-	return is_bpf_wq_set_callback_kfunc(btf_id) ||
-	       is_task_work_add_kfunc(btf_id);
-}
-
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off == 0 &&
@@ -13119,15 +13155,16 @@ static bool is_bpf_wq_set_callback_kfunc(u32 btf_id)
 	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback];
 }
 
-static bool is_callback_calling_kfunc(u32 btf_id)
+static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
-	return is_sync_callback_calling_kfunc(btf_id) ||
-	       is_async_callback_calling_kfunc(btf_id);
+	return is_bpf_wq_set_callback_kfunc(btf_id) ||
+	       btf_id_in_kfunc_table(btf_id, bpf_task_work_api_kfuncs);
 }
 
-static bool is_rbtree_lock_required_kfunc(u32 btf_id)
+static bool is_callback_calling_kfunc(u32 btf_id)
 {
-	return is_bpf_rbtree_api_kfunc(btf_id);
+	return is_sync_callback_calling_kfunc(btf_id) ||
+	       is_async_callback_calling_kfunc(btf_id);
 }
 
 static bool check_kfunc_is_graph_root_api(struct bpf_verifier_env *env,
@@ -13138,10 +13175,10 @@ static bool check_kfunc_is_graph_root_api(struct bpf_verifier_env *env,
 
 	switch (head_field_type) {
 	case BPF_LIST_HEAD:
-		ret = is_bpf_list_api_kfunc(kfunc_btf_id);
+		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_list_api_kfuncs);
 		break;
 	case BPF_RB_ROOT:
-		ret = is_bpf_rbtree_api_kfunc(kfunc_btf_id);
+		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_rbtree_api_kfuncs);
 		break;
 	default:
 		verbose(env, "verifier internal error: unexpected graph root argument type %s\n",
@@ -13163,14 +13200,10 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
 
 	switch (node_field_type) {
 	case BPF_LIST_NODE:
-		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_list_push_back_impl]);
+		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_list_node_api_kfuncs);
 		break;
 	case BPF_RB_NODE:
-		ret = (kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_add_impl] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_left] ||
-		       kfunc_btf_id == special_kfunc_list[KF_bpf_rbtree_right]);
+		ret = btf_id_in_kfunc_table(kfunc_btf_id, bpf_rbtree_node_api_kfuncs);
 		break;
 	default:
 		verbose(env, "verifier internal error: unexpected graph node argument type %s\n",
@@ -13878,7 +13911,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return -EINVAL;
 			}
 
-			if (!is_bpf_res_spin_lock_kfunc(meta->func_id))
+			if (!btf_id_in_kfunc_table(meta->func_id, bpf_res_spin_lock_api_kfuncs))
 				return -EFAULT;
 			if (meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock] ||
 			    meta->func_id == special_kfunc_list[KF_bpf_res_spin_lock_irqsave])
@@ -14215,7 +14248,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (is_task_work_add_kfunc(meta.func_id)) {
+	if (btf_id_in_kfunc_table(meta.func_id, bpf_task_work_api_kfuncs)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_task_work_schedule_callback_state);
 		if (err) {
@@ -14304,9 +14337,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return err;
 	}
 
-	if (meta.func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-	    meta.func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-	    meta.func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+	if (btf_id_in_kfunc_table(meta.func_id, bpf_collection_insert_kfuncs)) {
 		release_ref_obj_id = regs[BPF_REG_2].ref_obj_id;
 		insn_aux->insert_off = regs[BPF_REG_2].var_off.value;
 		insn_aux->kptr_struct_meta = btf_find_struct_meta(meta.arg_btf, meta.arg_btf_id);
@@ -14354,11 +14385,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	t = btf_type_skip_modifiers(desc_btf, meta.func_proto->type, NULL);
 
 	if (is_kfunc_acquire(&meta) && !btf_type_is_struct_ptr(meta.btf, t)) {
-		/* Only exception is bpf_obj_new_impl */
+		/* Only exception is bpf_obj_acquire_ptr_kfuncs */
 		if (meta.btf != btf_vmlinux ||
-		    (meta.func_id != special_kfunc_list[KF_bpf_obj_new_impl] &&
-		     meta.func_id != special_kfunc_list[KF_bpf_percpu_obj_new_impl] &&
-		     meta.func_id != special_kfunc_list[KF_bpf_refcount_acquire_impl])) {
+		    !btf_id_in_kfunc_table(meta.func_id, bpf_obj_acquire_ptr_kfuncs)) {
 			verbose(env, "acquire kernel function does not return PTR_TO_BTF_ID\n");
 			return -EINVAL;
 		}
@@ -23316,9 +23345,7 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[1] = addr[1];
 		insn_buf[2] = *insn;
 		*cnt = 3;
-	} else if (desc->func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
-		   desc->func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
-		   desc->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+	} else if (btf_id_in_kfunc_table(desc->func_id, bpf_collection_insert_kfuncs)) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 		int struct_meta_reg = BPF_REG_3;
 		int node_offset_reg = BPF_REG_4;
-- 
2.50.1 (Apple Git-155)

