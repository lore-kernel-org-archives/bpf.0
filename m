Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548919B5B1
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170367; cv=none; b=fEiO6YLWwTYRKiZYOXI90UbGwqbKMyCRksgpzVrynPfgLtCDfDoCnFY4f7CDVltrNBwVheCvczSgsmr4mNIzEgpaJCBBjwH4GNZZ2ij1JmaSiFY9ntHPrOXX/kiL3C7bfSU7org43Zk5lXeilSe72WEClwiZxaMUAPy74fLbzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170367; c=relaxed/simple;
	bh=yuNBtGSbj8wkJJwHZaaFXYEWU5iAbNbkA02hIKLBiSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao7Y+yoUi08Q/3ElVxZzWwYETDHl/6sbJs807mRHd2XRvQkPbMUTTmNamlzBVrCLGUwwasR/MfOJuqZ1Za5TkKq4Y02tMdwyzNJg2UFI8Sz7pHliMw5JVf8JR7FyW55Policl5tS2ireLo9fIfdL0fQ+elMeZxAQuaoKoajrGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut+MULzK; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut+MULzK"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so719585e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 23:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170364; x=1786775164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XgmC+KbYE3gMurZ/WybFzlQ6tsoCqWPjEbKgORLuWAU=;
        b=Ut+MULzKsEmNhVSLj7CAfGuV667bdlWy+YYKgzcVycqAC/vFkjieL2n4Wlf0EzJtND
         klrjOaQpah+lLzLO9RRLnyTzamQek2CNkaXGUiKsf7nMTrixoMWEaMcJKPC0/T0ZX2I5
         aci0faC8VPVmutmjc6slAmf8/jnEPANzA2qY9Xg4HoKoAEWoNey1Ent+jhdu4kUNpszj
         TkeHbH/1lY3YyBVWxpoBDsanTWF4gl3cSMNPC/UHMOLqdiGUc5G1fUvkO85T+hMf90Me
         HdSiUm4TrwUpnc9iFfPG5Hr25Ydo1oCbO/Ie7go+ZuVq+ic2XyNtVaTcDgJ3PNJtxhIq
         4r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170364; x=1786775164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XgmC+KbYE3gMurZ/WybFzlQ6tsoCqWPjEbKgORLuWAU=;
        b=pFO7xtOI8wo6lsl2QTLlseEmdms2un43xLlohlq17jjLG+ZFailvok6Po4yyBYwcsL
         YcXO+dxQUrLy/WclZaMFgUwPhJEav6cBDXqmb/tsfcb9PZpYhWe1yMFPFWCbUWlX1ouR
         /0gEca6YTPPOR0fDaktKod1wyN0ISPi9XiMsQ9gCOmtRDE4B3+eWZxuS/jWKtTE54kNx
         OM2lt3XaGzEJgXNVZl1QaWWNIs3aINQFT+tVNWirvQHbtFPaA6GmzG3zV9E8PrQdU0Sy
         bMTfqtRyVrEryo2kS+/AXJ/2q5Hy9oCLHMJ1gfKMznEcgnd08eGu8/vOxgMXDCbpAxlX
         9trA==
X-Gm-Message-State: AOJu0YxOXBHwzoXjA5n7+B7zLolHwJdeoYLojJo+j3WBRQheiTQDabuz
	VW5urSm6ZSsVwjCHltbkAgzTUTyYamyctPwQS9ENxAcv4PQyFidi3pOW7YPCDk3aZNE=
X-Gm-Gg: AR+sD12OFZFsl8RCST5/yVgAQ2scy4dJM22dh5FX3FrJlS3TT1NTxfWdnkmRSArxpGR
	kPYMFVb5foZ7PllWndhl1J4i5sQQuOL0a5Y5jUCuotsqUrxJdYnRUMr2hP8FsA7MA68sTwxPcDK
	ueNbUim/6W9kPJ+uGiSVGUM8pdOxcaNMJ49kVwZsx3O3cDmVlb+UCOzicEhmNo0360B8Dm38oef
	xoI1TkOBHfDouY3MO4bqWFeId6B7wkkBxH7yLZFEdLQe7qyiaxwDAV8cuni3r+DvFLbKUrj1gRA
	km07jYe50i1UdvrG+bVQH90IVwqvhk7Tm8NOSvLroQfwVPPGu3CtxZ7ujfgN2ttcWFLXzhPZJc+
	YPPOKq5tx7rMY5GFIfInlRQtuoXZVMVsuLABa3biSSCRPti9XzxGjV4kw5NpAYlc0CLH9HECEm1
	EnTAIOBK2SKRnd4hZGaRVHILMH5z9e4rtYfsX1Ak7fulYWn8OBQditX4vjBDczH3DMRPCbHB0sh
	8Vxi7EVcpJih0JLKMGF2naOdkQj15bUHDkRoz/KkNdbjaBtTU/i05e8K9XzJihWgsTLqEmM1f+B
	ewgSvdk0/9WxUHqztL3CwMa2BXjYpMTVMYN9pg==
X-Received: by 2002:a05:6000:41ed:b0:47f:8d71:210a with SMTP id ffacd0b85a97d-48130ed871emr6773828f8f.15.1786170363910;
        Fri, 07 Aug 2026 23:26:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021457ebsm12212814f8f.6.2026.08.07.23.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:26:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 1/6] bpf: Track verifier instruction stats for each subprogram
Date: Sat,  8 Aug 2026 08:25:53 +0200
Message-ID: <20260808062601.1070988-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808062601.1070988-1-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7860; i=memxor@gmail.com; h=from:subject; bh=yuNBtGSbj8wkJJwHZaaFXYEWU5iAbNbkA02hIKLBiSo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavs9M0HD41NirL75l8q+22/W3TV73TWVeJxm7a5LLlq6 x5puONfRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZiJsjwPzvXbO6PyKWqCZmd RQ/sHsevCz63N8JYwULTdIrlj7WOfIwM7wR9ty1NX7H41bGoN+cnPRK9nvrI89JLxiU/3W9rXD3 yhQUA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier currently records one instruction count for the main program
and each global subprogram checked independently. Static subprograms are
explored within callers, so their verification cost cannot be reported
separately.

Track both self and inclusive instruction counts for every subprogram.
Charge each processed instruction as self work to the current subprogram and
to a path-local subtotal in its function frame. When a function returns, add
the callee subtotal to its inclusive count and to its parent subtotal. Fold
any remaining frames when a path terminates or is pruned.

Instruction subtotals are accounting state, not semantic verifier state.
Clear them when a verifier state is copied so work before a path fork is
charged once, rather than again when a saved branch is explored. If copying
a saved state fails before all frames are allocated, skip missing frames
while folding the current path.

This generic frame accounting also records self and inclusive totals when an
asynchronous callback starts as a fresh frame-zero state. It does not yet
charge that independently explored callback path back to the main or global
exploration root which scheduled it. That will be done in subsequent
changes.

This does not change the verification statistics output format. It only
prepares the counters for per-subprogram reporting.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf_verifier.h |  5 +++-
 kernel/bpf/verifier.c        | 55 ++++++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a2a40caca0a0..f16ee6602179 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -385,6 +385,8 @@ struct bpf_func_state {
 	 *                           | number of simulations is tracked in frame N
 	 */
 	u32 callback_depth;
+	/* Instructions processed in this frame and callees on the current path. */
+	u32 insns_subtotal;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -803,7 +805,8 @@ struct bpf_subprog_info {
 	u32 exit_idx; /* Index of one of the BPF_EXIT instructions in this subprogram */
 	u16 stack_depth; /* max. stack depth used by this function */
 	u16 stack_extra;
-	u32 insn_processed;
+	u32 insns_total;
+	u32 insns_self;
 	/* offsets in range [stack_depth .. fastcall_stack_off)
 	 * are used for bpf_fastcall spills and fills.
 	 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9533ea700ba..855f245e7468 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1593,6 +1593,8 @@ static int copy_func_state(struct bpf_func_state *dst,
 			   const struct bpf_func_state *src)
 {
 	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
+	/* Instruction accounting is path-local, not part of verifier state. */
+	dst->insns_subtotal = 0;
 	return copy_stack_state(dst, src);
 }
 
@@ -9832,6 +9834,42 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 
 static bool is_rbtree_lock_required_kfunc(u32 btf_id);
 
+static void account_processed_insn(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *frame = cur_func(env);
+
+	env->insn_processed++;
+	frame->insns_subtotal++;
+	env->subprog_info[frame->subprogno].insns_self++;
+}
+
+static void account_processed_insns(struct bpf_verifier_env *env,
+				    struct bpf_func_state *callee,
+				    struct bpf_func_state *caller)
+{
+	u32 insns;
+
+	if (!callee)
+		return;
+
+	insns = callee->insns_subtotal;
+
+	env->subprog_info[callee->subprogno].insns_total += insns;
+	if (caller)
+		caller->insns_subtotal += insns;
+	callee->insns_subtotal = 0;
+}
+
+static void account_current_path(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	int frame;
+
+	for (frame = state->curframe; frame >= 0; frame--)
+		account_processed_insns(env, state->frame[frame],
+					frame ? state->frame[frame - 1] : NULL);
+}
+
 /* Are we currently verifying the callback for a rbtree helper that must
  * be called with lock held? If so, no need to complain about unreleased
  * lock
@@ -9928,6 +9966,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		verbose(env, "to caller at %d:\n", *insn_idx);
 		print_verifier_state(env, state, caller->frameno, true);
 	}
+	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
 	free_func_state(callee);
@@ -17504,7 +17543,9 @@ static int do_check(struct bpf_verifier_env *env)
 		insn = &insns[env->insn_idx];
 		insn_aux = &env->insn_aux_data[env->insn_idx];
 
-		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
+		account_processed_insn(env);
+
+		if (env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
 				env->insn_processed);
@@ -17644,6 +17685,7 @@ static int do_check(struct bpf_verifier_env *env)
 					    "speculation barrier after jump instruction may not have the desired effect"))
 				return -EFAULT;
 process_bpf_exit:
+			account_current_path(env);
 			mark_verifier_state_scratched(env);
 			err = bpf_update_branch_counts(env, env->cur_state);
 			if (err)
@@ -18688,6 +18730,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 
 	ret = do_check(env);
 out:
+	account_current_path(env);
 	if (!ret && pop_log)
 		bpf_vlog_reset(&env->log, 0);
 	free_states(env);
@@ -18719,7 +18762,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_func_info_aux *sub_aux;
 	int i, ret, new_cnt;
-	u32 insn_processed;
 
 	if (!aux->func_info)
 		return 0;
@@ -18734,8 +18776,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (!bpf_subprog_is_global(env, i))
 			continue;
 
-		insn_processed = env->insn_processed;
-
 		sub_aux = subprog_aux(env, i);
 		if (!sub_aux->called || sub_aux->verified)
 			continue;
@@ -18743,7 +18783,6 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
 		ret = do_check_common(env, i);
-		env->subprog_info[i].insn_processed = env->insn_processed - insn_processed;
 		if (ret) {
 			return ret;
 		} else if (env->log.level & BPF_LOG_LEVEL) {
@@ -18770,12 +18809,10 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 
 static int do_check_main(struct bpf_verifier_env *env)
 {
-	u32 insn_processed = env->insn_processed;
 	int ret;
 
 	env->insn_idx = 0;
 	ret = do_check_common(env, 0);
-	env->subprog_info[0].insn_processed = env->insn_processed - insn_processed;
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
@@ -18794,10 +18831,10 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 		for (i = 1; i < subprog_cnt; i++)
 			verbose(env, "+%d", env->subprog_info[i].stack_depth);
 		verbose(env, " max %d\n", env->max_stack_depth);
-		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
+		verbose(env, "insns processed %d", env->subprog_info[0].insns_total);
 		for (i = 1; i < subprog_cnt; i++)
 			if (bpf_subprog_is_global(env, i))
-				verbose(env, "+%d", env->subprog_info[i].insn_processed);
+				verbose(env, "+%d", env->subprog_info[i].insns_total);
 		verbose(env, "\n");
 	}
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
-- 
2.53.0

