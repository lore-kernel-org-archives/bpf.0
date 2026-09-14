Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDE3D6CD3
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391970; cv=none; b=BVntZnHE9Xrk+d3oNqtZRhBYGGyh5UmXX+gP1r4y3E416iAe1SKdX2Pw1pmPhmijCpJfRVZBHvsI5TqB6DMp6HCmFbX9FlfQhBSDrIgAj570zBKHssvQN9j/fkCcXeiFzb/E7XTRtEAs+eEgC3Mz3MKoXdFAENhS1pCKpX4U2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391970; c=relaxed/simple;
	bh=Yv9DiwAUimZjnaVMEKUGSTs522Cm88oA9CwNteYnWFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uug44pu13hhVIJqtYNkbc+b7cWhXs+e2MZaXvEGtnrCOLin6x9dMRLlzGFCOHNiklf28mYyYRAwis8TAPrDOTZSKQ5ZDBriL2f6Xyae/w4BuaHTdRhWoqC9eWYbZkvFXoak43+wjMWee7i78F6r69zBa9LGLa4IZKSczmazuEsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB8xJrkV; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB8xJrkV"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so3547465e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391966; x=1789996766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEVFC+rfboPgJ0pMKLDg7323v7nRMLCrx0mojoB8WAw=;
        b=RB8xJrkVzl7u90eEf04xds29/OtJwTM8oqxTnHjOxDFqpTYI9yPZN3wkmKF+QoI+96
         gBOydX2tBTpKuGXAmw+BAY1xg6f2LWAd+lGDWlTqzjWjsncVYsVkD+7dodsNQ53pd0Gt
         yYwwT582qpt6dqGGkzPqqjbfKPDB2udGOuJwo2EwjD6k5ZAQysXbsYqrVToy17n7icWw
         Cltlp5ds7bNv9T2tgpmiVP2VQl2FVSgE6JvCJpLZxPTTmqRNoQJWUqK2PmN9dyGBH7zN
         Mac5U3C33qyPr91RmwplHmQzh6EuHK6j4CvJcEl784pOkGi9BuAqj5vgeQoHFt4MpjHL
         C4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391966; x=1789996766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uEVFC+rfboPgJ0pMKLDg7323v7nRMLCrx0mojoB8WAw=;
        b=koIOn1RTyv3uuvwR6RF0LLGfWixJ6vNftF/3hXkvF9UE5VMrYiowPqZkoatfzFt3ip
         gRUyVVcRtxeq+fIKv6FAy5oRRmbSOmGmAfgvIMMyLQ6wLBc6qMOY7TudcwNcI7y9WaBi
         1um5Ml/M+yc+FjpSuY5FK0/EnohHrb/CpHX2ZkyX4Uf1wCUoYJp5kHMkUVU0kXdmjQZA
         gn7rJVZxKLnECTWVeSlCKVXqFn7LjoBBPMRFaYWJXEji3YlkDyOHpMLElMaMWmBI29qm
         c05BQQ9PRvb0BPVPNvZZopIUT9lnOMf46oFpsDbeVJ+C4metlAy4SmtkMj5k5kc2ZPxc
         RlfQ==
X-Gm-Message-State: AFuF++kUtfdTeE5E8zh3/a6WeKof6idCg2wMht76QJrvuupJuJ7pU3Md
	ljHwxamalW4Wwzykdw0RFFNe2G1qF0+V1S4O+/bSqudi04HiGpg/wccuOHWuzvpq
X-Gm-Gg: AYBFou0H9JHnVZVaalL54UGLELBuO6BzrkllhgmBzZUkMtYFXXqJqWb7P4OWlBMMwUM
	3R0YFr81I4yZ7MDtgiS3EMgPjmWAehxLwbA1FNweFBJNyFEnZSAguG4UHwzscuNFrPxCy9eIZZ+
	/5rOa4ifpwlNRnVXeABkli1VQPvLtbQZ94vh/1Xeqv9FrW0FV5YN/RzPNjprsxmDzPAspy32R6f
	q6tQc2a9onla4On/TNcRRocqZt8bNmV4TkJTuH50ZfdGQw+p6+JfQWQa8yXOefDL+T6B9bCAADu
	Ya30KW4/L+b3blX24LD7KB+YQqMYbuEvvmuf+aZeSwVZlSQd2svI7Fku+tW27cYjrKVjwr+RKzu
	3zr77Ur9/uIx2A08xIYYgSHq30t4iWk8AVyHWdBFMdJmIp29PM6zDl6AvZJ92gVghMetRDimJQA
	CclZqKS5W3I9A3nBhDRKG7DzLhQbOW+zdmooMMlIoes70gOsaSewzjNY6Lw+31O4AJvQdGkX8LU
	5vwvOfiW14wvyTHSBtgWV26OBOC7eBJtncOMbVWD26ZEz1NZj18IugQbVLzZtFIrcv3bBF8SZ5f
	+sreisq5UpMbb0kv4q4HopjoVX01ecrRjDrT6w==
X-Received: by 2002:a05:600c:1c19:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-49e7a691a5amr40235285e9.31.1789391965881;
        Mon, 14 Sep 2026 06:19:25 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2985dsm673054355e9.6.2026.09.14.06.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:19:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 1/2] bpf: Verify global subprogs in each sleepability context
Date: Mon, 14 Sep 2026 15:19:20 +0200
Message-ID: <20260914131923.2544250-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914131923.2544250-1-memxor@gmail.com>
References: <20260914131923.2544250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9285; i=memxor@gmail.com; h=from:subject; bh=Yv9DiwAUimZjnaVMEKUGSTs522Cm88oA9CwNteYnWFY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv5Fx/BibtNVnc43JAIdf961b7ugobY3NnCuaUqUi7XJ 75fGna+o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABP58IPhf1mbYNTTymVfA8VW GqTtXSd5+MROD3G1Xwvkrua9sQksOczwP+pASPyGhtnRP/evdf91gH264Jy+K2tjW/UYVWQuTX7 4lwMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Global subprograms are verified independently with a fresh verifier root.
do_check_common() currently seeds that root's in_sleepable state from the
program, even though a global subprogram can also run from callbacks whose
execution context differs from the program's main entry point.

In particular, workqueue and task-work callbacks are sleepable even when
the containing program is not. A global subprogram of that program is
therefore verified as non-sleepable, making in_rcu_cs() true and allowing
loads of RCU-protected kptrs to produce trusted MEM_RCU pointers. The same
subprogram can then be called from a sleepable callback without a classic
RCU reader. It can retain such a pointer while the object is freed and use
it after free.

The verifier's execution-context predicates are complementary. A state is
sleepable only when in_sleepable is set and no RCU, preemption, IRQ, or lock
region is active. Each condition which prevents sleeping also provides RCU
protection, while in_rcu_cs() treats a non-sleepable state as implicitly
protected.

Use this relationship to represent a global subprogram caller with only the
result of in_sleepable_context(). A protected sleepable caller is normalized
to in_sleepable=false at the independent verification root. This both
prevents sleepable operations and makes in_rcu_cs() true without copying
caller-owned lock state.

Track only the contexts in which each global subprogram is actually
reached. Verify it once if all reachable calls use the same context, and
twice only if both sleepable and non-sleepable calls reach it. Calls found
while verifying globals or asynchronous callbacks mark further contexts
for checking. Repeat the existing subprogram walk until all called
contexts have been verified; unreachable global calls remain unchecked.

Accumulate instruction counts over those verification passes. Preserve
the total recorded before each pass, since path accounting has already
added this pass's synchronous instructions and its root total must also
include asynchronous subprograms.

This makes an unprotected callback verify the global subprogram as
sleepable, turning its RCU-protected kptr load into an untrusted pointer.
Protected callers and global subprograms which do not depend on implicit RCU
protection remain valid.

Fixes: 81f1d7a583fa ("bpf: wq: add bpf_wq_set_callback_impl")
Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h   |  5 +--
 kernel/bpf/verifier.c | 71 ++++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2a5fa346aada..7217e8ddf64b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1682,8 +1682,9 @@ static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags
 struct bpf_func_info_aux {
 	u16 linkage;
 	bool unreliable;
-	bool called : 1;
-	bool verified : 1;
+	/* Indexed by in_sleepable. */
+	bool called[2];
+	bool verified[2];
 };
 
 enum bpf_jit_poke_reason {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..bb9a02ad4f11 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10559,6 +10559,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
+		struct bpf_func_info_aux *sub_aux = subprog_aux(env, subprog);
 		const char *sub_name = bpf_subprog_name(env, subprog);
 		const char *operation;
 		bool returns_void;
@@ -10590,11 +10591,10 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		if (env->log.level & BPF_LOG_LEVEL)
 			verbose(env, "Func#%d ('%s') is global and assumed valid.\n",
 				subprog, sub_name);
+		sub_aux->called[in_sleepable_context(env)] = true;
 		returns_void = subprog_returns_void(env, subprog);
 		if (env->subprog_info[subprog].changes_pkt_data)
 			clear_all_pkt_pointers(env);
-		/* mark global subprog for verifying after main prog */
-		subprog_aux(env, subprog)->called = true;
 		if (returns_void)
 			bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CALLER_SAVED);
 		else
@@ -11434,11 +11434,7 @@ int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
 /* Check if we're in a sleepable context. */
 static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 {
-	return !env->cur_state->active_rcu_locks &&
-	       !env->cur_state->active_preempt_locks &&
-	       !env->cur_state->active_locks &&
-	       !env->cur_state->active_irq_id &&
-	       in_sleepable(env);
+	return !in_rcu_cs(env);
 }
 
 static const char *non_sleepable_context_description(struct bpf_verifier_env *env)
@@ -19780,13 +19776,14 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 }
 
-static int do_check_common(struct bpf_verifier_env *env, int subprog)
+static int do_check_common(struct bpf_verifier_env *env, int subprog, bool is_sleepable)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
+	u32 old_insns_total = sub->insns_total;
 	u32 insn_processed = env->insn_processed;
 	int ret, i;
 
@@ -19799,7 +19796,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
-	state->in_sleepable = env->prog->sleepable;
+	state->in_sleepable = is_sleepable;
 	state->frame[0] = kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
 		kfree(state);
@@ -19943,8 +19940,10 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	 * not accounted as callees by account_current_path().
 	 * Accumulate their total counts as total counts of the main or
 	 * global subprog hosting the async call.
+	 * Start from the saved total of earlier contexts: adding to the current
+	 * total would count this pass's synchronous paths twice.
 	 */
-	env->subprog_info[subprog].insns_total = env->insn_processed - insn_processed;
+	sub->insns_total = old_insns_total + (env->insn_processed - insn_processed);
 	return ret;
 }
 
@@ -19972,14 +19971,19 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_func_info_aux *sub_aux;
-	int i, ret, new_cnt;
+	int context, i, ret, new_cnt;
 
 	if (!aux->func_info)
 		return 0;
 
-	/* exception callback is presumed to be always called */
-	if (env->exception_callback_subprog)
-		subprog_aux(env, env->exception_callback_subprog)->called = true;
+	/*
+	 * Callbacks cannot throw, so the exception callback always runs in the
+	 * main program's context. It is presumed to be always called.
+	 */
+	if (env->exception_callback_subprog) {
+		sub_aux = subprog_aux(env, env->exception_callback_subprog);
+		sub_aux->called[env->prog->sleepable] = true;
+	}
 
 again:
 	new_cnt = 0;
@@ -19988,29 +19992,28 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 			continue;
 
 		sub_aux = subprog_aux(env, i);
-		if (!sub_aux->called || sub_aux->verified)
-			continue;
+		for (context = 0; context < ARRAY_SIZE(sub_aux->called); context++) {
+			if (!sub_aux->called[context] || sub_aux->verified[context])
+				continue;
 
-		env->insn_idx = env->subprog_info[i].start;
-		WARN_ON_ONCE(env->insn_idx == 0);
-		ret = do_check_common(env, i);
-		if (ret) {
-			return ret;
-		} else if (env->log.level & BPF_LOG_LEVEL) {
-			verbose(env, "Func#%d ('%s') is safe for any args that match its prototype\n",
-				i, bpf_subprog_name(env, i));
-		}
+			env->insn_idx = env->subprog_info[i].start;
+			WARN_ON_ONCE(env->insn_idx == 0);
+			ret = do_check_common(env, i, context);
+			if (ret)
+				return ret;
+			if (env->log.level & BPF_LOG_LEVEL)
+				verbose(env, "Func#%d ('%s') is safe for any args "
+					"that match its prototype\n",
+					i, bpf_subprog_name(env, i));
 
-		/* We verified new global subprog, it might have called some
-		 * more global subprogs that we haven't verified yet, so we
-		 * need to do another pass over subprogs to verify those.
-		 */
-		sub_aux->verified = true;
-		new_cnt++;
+			sub_aux->verified[context] = true;
+			new_cnt++;
+		}
 	}
 
-	/* We can't loop forever as we verify at least one global subprog on
-	 * each pass.
+	/*
+	 * We can't loop forever as each pass verifies at least one new context,
+	 * and there are only two contexts per global subprog.
 	 */
 	if (new_cnt)
 		goto again;
@@ -20023,7 +20026,7 @@ static int do_check_main(struct bpf_verifier_env *env)
 	int ret;
 
 	env->insn_idx = 0;
-	ret = do_check_common(env, 0);
+	ret = do_check_common(env, 0, env->prog->sleepable);
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
-- 
2.53.0

