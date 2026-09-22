Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7715577E43
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097654; cv=none; b=NmjUYcxLJbdoerFuM3GJa76NQL23xFzLFyDRUbYPVwoOCXNauVnwJRX7xzfYXuCsYwuZ2rsjFiy2OHKUr0vZhznpGE9b6BtgjkeX/Hz0QK5sa7V4rVP2t194eXRu8FymajRrTi6g2iC5/dRVB814mMjSGoWhWemTsSYEVcU029I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097654; c=relaxed/simple;
	bh=rB1Opw5B2LOg6P/GYytAjPU/kxjLmp3Q4k3S84pEe1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMtFAsM0+B4RIFxGwfam8jjhu2VYaypORES7+7oTr+MxCHkFz4Che0/N9ClHiHG0v5qr5VvoqhHk6ZCSvhlIAGyEcwuk9hHc34aNgRBUab0se6je/Uc5Y6fyatlg0JgKXkHH4JlZNCTls2D0hBEVvxUKY8GaQbyd64B8seFJZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=s+6rxN65; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="s+6rxN65"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc0so99244a12.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097649; x=1790702449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yOnggd3RxTs4DSXKpObmRaWjKX2daePFjv5dqgMAGTw=;
        b=s+6rxN65ayx/N6+2AX/Zd4Ib5vblSugXczah/87RncsbdIPmYJCT1KXE6wAC8HZTZW
         VCvXrkQgxc5gNz4wQitGwhaY1zqFi46jFcPuajLX9L4zPmZjD/mikLaK8N4cjrXtkQKL
         ID+D5pEEDSEZBweCxqtsM/UAg+yOJAoGg6Lv973Q99um45/YjtzPcXw5gYDRI7MXXi6F
         K9l/3QKWmVTVjFo0MK+iQ4DjXcj1cFxh0qbgoKxRthm8GzCBY7YNCmBxzAzyqits0NjW
         bit8jdPklnqyaNOsa4L9+bxBMg1HJAk/WnZbHakfcMMAT7B0oK3oywAoiaKr/oM/+DxU
         WbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097649; x=1790702449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yOnggd3RxTs4DSXKpObmRaWjKX2daePFjv5dqgMAGTw=;
        b=2OI14XuxhcMAak/yUyq1/QDmUx8jGum0ag+uhOxD+avktd1OBv5lB4bjwJaJcP3za4
         SfF9bYO3O2S1tGZvis8W9XeBwoOW4FF8q8iGkQZghj3+B5vPO2SuL3Sp1qH8NpMO7qG+
         qKxlqihCFeW4YBSMM/NW8rs5lkp8CH0uC1Y3jvmJ78wJY/4OSZ8McRFDI6v7WlYCkJVL
         hC5vIJahAVWpS/IK1npK5pViwqA7HOCcoqp8eSrWQwgPFCxHFKpqoWZayX4zxFzo9/2k
         0E+HILKNIAwK4VMb4qgAG7NO6xQyf4FZndXntn4rPxEdpdcmxoClC0sRdkj8A+qJIW/N
         wQsw==
X-Gm-Message-State: AFuF++mPWPV8XIP9zRZB0heUhgM2+seENbSG9dsLnx0168NofR5R9Hht
	ozsZ2EI5qpvJjTVzyC6Ka/lvidOHlEGQz5pI6QOmqGJqWvWZ+yGzO9LfwK8BUzsoPqeFCvZ8lWm
	lNF2U2co=
X-Gm-Gg: AYBFou3ZaX2DHXr0KkZ/eAVrYuONxE7xEcH2QiZ7viTmsScqW9BOQy/lBaMT8h7f4/D
	EENkx1d2dit3Ihn4nSK2J8od8Wf0nYODZSvCI/mWnDeBeBBXINQzl/eu/c9GYbWUqDashWPAN+V
	LrepUSI7bNh1iExivhiiPfT5AanT+klFiEXeYtBJDuxOhMZ8sWQPNbIbZaaa4DNgCAj8b5iJs2s
	md6FqcEfkoMRqYC62CUx+WZUM3BwsLLPngYSzQvU4L6Px4T50ofj+G+nSvvaeWkL00WrNbMC2HO
	u9jbHr5EzYnB63jcUbfwmAtQfr4rWYSkK+eiDEfpN+1o+hJ9AAQ0PvNjTWGSlwMeX5uSGdq3uQT
	m2xhvEWKvVKKLLUHM4VrGMFFFpJRoXz7ZO5XvN1dqjsXRsr7Yp98MioJMi5c5tNvmQAIWGDN94T
	QuvR9a5CxKBCLsPn39KCRpfiUh8JAwMxRwYJDiss0hWAXrCJWz+fsYz9HuQfrEU+UOSIO5c0wk4
	UEinM5rOv9XYvkqxLUyqvQCvQ/C1sOZ38FMjQwEIQ==
X-Received: by 2002:a17:90b:5343:b0:39e:4c7f:7304 with SMTP id 98e67ed59e1d1-3a07e560dd3mr131881a91.27.1790097649059;
        Tue, 22 Sep 2026 10:20:49 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:48 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf v2 10/11] bpf: Track skb memory invalidation by packet-backed dynptrs
Date: Tue, 22 Sep 2026 17:20:27 +0000
Message-ID: <20260922172028.6269-11-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A dynptr can be backed by skb memory, and kfuncs that
write but also read the underlying area may reallocate
the backing memory in the process of pulling the skb.
However, the verifier does not track these calls as
possibly invalidating packet pointers, and does not
do so after their call site.

Expand the verifier to track dynptr kfuncs for packet
invalidation.

Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/cfg.c             | 10 +++++--
 kernel/bpf/verifier.c        | 51 ++++++++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f57730d1d..8a9b7a2f2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1589,6 +1589,7 @@ struct bpf_call_arg_meta {
 
 	/* Only set by kfunc */
 	bool r0_rdonly;
+	bool dynptr_may_clobber_pkt_ptr;
 	u32 kfunc_flags;
 	const struct btf_type *func_proto;
 	const char *func_name;
@@ -1642,6 +1643,7 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
+bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1ea..cb499d19d 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -73,6 +73,12 @@ static void mark_subprog_might_throw(struct bpf_verifier_env *env, int off)
 	subprog->might_throw = true;
 }
 
+static bool bpf_helper_maybe_changes_pkt_data(enum bpf_func_id func_id)
+{
+	return bpf_helper_changes_pkt_data(func_id) ||
+	       func_id == BPF_FUNC_dynptr_write;
+}
+
 /* 't' is an index of a call-site.
  * 'w' is a callee entry point.
  * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
@@ -510,7 +516,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			if (bpf_helper_maybe_changes_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
 			if (insn->imm == BPF_FUNC_tail_call) {
 				ret = visit_abnormal_return_insn(env, t);
@@ -543,7 +549,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && bpf_is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
-			if (ret == 0 && bpf_is_kfunc_pkt_changing(&meta))
+			if (ret == 0 && bpf_is_kfunc_maybe_pkt_changing(&meta))
 				mark_subprog_changes_pkt_data(env, t);
 			if (ret == 0 && bpf_is_throw_kfunc(insn))
 				mark_subprog_might_throw(env, t);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index da110cdbc..e916ce89c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8278,6 +8278,7 @@ static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const char *name);
 static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta);
 static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *meta);
+static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_meta *meta);
 static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_meta *meta);
 static bool is_bpf_obj_drop_kfunc(u32 func_id);
 static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
@@ -9320,6 +9321,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, meta);
 		if (err)
 			return err;
+		/*
+		 * These kfuncs only clobber packet pointers when their
+		 * destination dynptr, argument 0, is backed by skb packet data.
+		 */
+		if (arg == 0 && is_kfunc_dynptr_may_clobber_pkt_ptr(meta) &&
+		    (meta->dynptr.type_unknown ||
+		     meta->dynptr.type == BPF_DYNPTR_TYPE_SKB ||
+		     meta->dynptr.type == BPF_DYNPTR_TYPE_SKB_META))
+			meta->dynptr_may_clobber_pkt_ptr = true;
 		break;
 	}
 	case ARG_PTR_TO_ITER:
@@ -11759,7 +11769,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
-		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
+		if (meta.dynptr.type_unknown ||
+		    dynptr_type == BPF_DYNPTR_TYPE_SKB ||
 		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
@@ -12787,9 +12798,45 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_preempt_enable]);
 }
 
+/*
+ * Dynptr kfuncs that may clobber packet pointers when called with an skb or
+ * skb_meta backed destination dynptr by pulling the packet.
+ */
+BTF_SET_START(dynptr_may_clobber_pkt_ptr_kfuncs)
+BTF_ID(func, bpf_dynptr_memset)
+BTF_ID(func, bpf_dynptr_copy)
+#ifdef CONFIG_BPF_EVENTS
+BTF_ID(func, bpf_probe_read_user_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_dynptr)
+BTF_ID(func, bpf_probe_read_user_str_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_dynptr)
+BTF_ID(func, bpf_copy_from_user_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_str_dynptr)
+#endif
+BTF_SET_END(dynptr_may_clobber_pkt_ptr_kfuncs)
+
+static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_meta *meta)
+{
+	return meta->btf && btf_id_set_contains(&dynptr_may_clobber_pkt_ptr_kfuncs,
+						meta->func_id);
+}
+
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
-	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]);
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]) ||
+	       meta->dynptr_may_clobber_pkt_ptr;
+}
+
+/*
+ * More conservative version of the above used in check_cfg(),
+ * where no register state exists and the dynptr type is unknown.
+ */
+bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta)
+{
+	return bpf_is_kfunc_pkt_changing(meta) ||
+	       is_kfunc_dynptr_may_clobber_pkt_ptr(meta);
 }
 
 static u32 kfunc_abi_slots(const struct btf_func_model *fm)
-- 
2.54.0

