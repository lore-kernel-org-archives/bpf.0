Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A83033D8
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788579625; cv=none; b=r8zmsOzQgZu1EJsg1KVib1LmofIYvVzFwJ9PBbE3L4yv0kA3W+eZc3fod2Ptz/1PuNyDuR8Y4HW2gaOSSaSViaHXabx0emR7d3f6M4PlYjSkfPiWHO61g60EVwGiRTgUwpzGMEzl/cv9mkF9jRjRdjQ9B7n2SDAcAqWPXvmsuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788579625; c=relaxed/simple;
	bh=9dilpjMa5l5YL/ZmgnSPx24b9HsAyOmIYuGlGL23kho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucR27w0XD06wWSPx15f9FkzZet/kqzEP7zQG3bf0Wga0xJbI0cst9tD10jNSAcmlYNeQ5NtZPzwaFknaD0iNNP3gGrKfD3r9jqPkMjCZSrK6PulmT6VQ1I8s+WiDDhitFEpCl+IhVwZPVqthZb6391D+nRwc1mdpAqqAldkrTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIQC9Zv+; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIQC9Zv+"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so3394735e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 20:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788579621; x=1789184421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k9aMqFaZj5E9AvfS1Mi7W7zV2vuPIywLGcWYgifZRro=;
        b=BIQC9Zv+i/l4U9bBPf0H5aBrThpoDHcdEppp6zsFYDAe70vvqzIP2qy6xDXf+Hehwf
         gtxMhXQsJBkM+urhhAUXoApx45jd+uWgqWSibGWA0ngly0L73hub1J1zZ3cTbcLBp5R/
         HdlDWUQ+JYT1zMIhv4Qx1qYAla1eEC7NYV19a+DEGbTgl1OJBC1KET4uvuFxUsVxi7qS
         mbqnieVejQVlYoz0pUW+smut76c6NJfOhqd4iYS7qL2XasPZwGmeL3sK3a2lSsudLhKy
         jslDO1tgpH4tUi5nKdqvxZ61uZajWgTda9cOIGH0cmsOsv5MLQosN1FdkosYSQ7ZPb38
         5xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788579621; x=1789184421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k9aMqFaZj5E9AvfS1Mi7W7zV2vuPIywLGcWYgifZRro=;
        b=Dv5F9cJtttWXCa0HhBkcPzvj9WDHJ73AgnEiutp9SIUu59qYgyUDPBcRG5D7BxjRb4
         RHxqZXEckrA9qgM9vr+Sh9q7uZzXwKv6W92VUUtSnledWSuPkkRXki8IVGi/eR3ly8gt
         U1PN2jhgdDv4YhdGr06Ar/P6uF0IeYqSYOolCJog5a5QDZpTbgH1tBt5F16yF0sw4icA
         QiQgenEQ1BnGnSsq36rRc3l5oLunHuDhOB3La1mKPoQgHOf43B3BHHuO34F/kpwO+9gy
         XrOaxx1dR1Prh9ltiMglFlf6ZxjjNq9YnzlaWDgk7JfXbzmlhzZhvcYywWsZNB9w6BsD
         wNhQ==
X-Gm-Message-State: AFuF++k6/2Y7o7GMzVbY99s5B+5adwMoBT9UWaM0qxeTKRyH3hLX4Ks8
	J0+oGnfj1V6KWvXWvaFaScpE68vdrdB9HuBiCXyp/BJu9malwCPU7GzEy3Rw5Gyt
X-Gm-Gg: AYBFou3ArG7uT9ytGbnjkCSmOzrc5drRez6xrycBn63XIvhzJ/FXFcQo/4WiSsQO7Af
	re+1IxJPce2Dw1S+dOoaO8hj/ZuMSDeMgt9hK+Jshh4gMpAPLxNrthNi/ErvBvfAst8Y/T1KdhX
	sZdslvAuKLrKanHr4u0Yp90DnrHYOyxMCxtbqfQFKGGqqVIlTRFkbCAEK1pqNTQSEGe+iC8+6ZH
	wRdRt2AtYJUxVt+mDf0TwaxEXxtF7Oa3L5yubulUWMs9HUjey1KwF2pbNz7DSKRgW9IYvQ9jEqr
	o29YT2tqp6mQTvWM8uwYEvkvqf3bjHejepEoWRo5S/3Kei0FMvxKnHwAOmiCeUlwcyigfELcx63
	/6mZFQxgoUwAfvgHFtRr2X3wi3JyZetUxoUhW0BG228tYmNCcyvTSG4qMimQff5E7orUZsAw/vx
	IS6HT2GoSfv3hUvngv2+DEFpSmO/ewLZXXuZEHejMRAPTvPr5EhfXHIn0gQWhw2jllcuKCB/u57
	x3KXzamgB72PmMdYG1tpqkUa+nTThl+Or6GZK6Qzg2+BNaKDSNlJrV3WtRlRle4JYtgOCaPnMCD
	jLhsDhAsazIDQgt3/21Ro8glNf0=
X-Received: by 2002:a05:600c:6819:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49cf81fb1acmr100976475e9.2.1788579621305;
        Fri, 04 Sep 2026 20:40:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbe5b252sm83337515e9.3.2026.09.04.20.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 20:40:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/2] bpf: Verify global subprogs in each sleepability context
Date: Sat,  5 Sep 2026 05:40:15 +0200
Message-ID: <20260905034018.2095649-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905034018.2095649-1-memxor@gmail.com>
References: <20260905034018.2095649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9044; i=memxor@gmail.com; h=from:subject; bh=9dilpjMa5l5YL/ZmgnSPx24b9HsAyOmIYuGlGL23kho=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWt238epr57Pnfe/7Lq6nc/zU9kvjK869c67buvA7lDSb n/m6KXqjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEykaQEjw1Uvh213C3nDt61b 9qbmgF5F9UY/8UsKXBee5AfZnPh525aR4fCRmetP8EdNtnQ/42ge8dNN4WbJ9i2c22d26V1fnDm djQsA
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

Record whether each global subprogram is called with either in_sleepable
value and verify it once for every observed value. Walk global subprograms
in caller-before-callee order so the values propagate through global call
chains, and repeat until every discovered context has been verified to cover
asynchronous callback cycles.

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
 kernel/bpf/verifier.c | 76 ++++++++++++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3a7eb2185c35..66d04244c737 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1650,8 +1650,9 @@ static inline void bpf_trampoline_set_flags(struct bpf_trampoline *tr, u32 flags
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
index 5b51e7ee1a3f..4b9aa0f168bb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9957,6 +9957,7 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (err == -EFAULT)
 		return err;
 	if (bpf_subprog_is_global(env, subprog)) {
+		struct bpf_func_info_aux *sub_aux = subprog_aux(env, subprog);
 		const char *sub_name = bpf_subprog_name(env, subprog);
 		const char *operation;
 		bool returns_void;
@@ -9988,11 +9989,10 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -10804,7 +10804,12 @@ int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
 	return *ptr && (*ptr)->func ? 0 : -EINVAL;
 }
 
-/* Check if we're in a sleepable context. */
+/*
+ * This predicate is the inverse of in_rcu_cs(): non-sleepable programs and
+ * every condition that prevents sleeping also provide RCU protection. Global
+ * subprog verification relies on this equivalence to represent the caller's
+ * execution context using only the in_sleepable bit.
+ */
 static inline bool in_sleepable_context(struct bpf_verifier_env *env)
 {
 	return !env->cur_state->active_rcu_locks &&
@@ -19560,13 +19565,14 @@ static void free_states(struct bpf_verifier_env *env)
 	}
 }
 
-static int do_check_common(struct bpf_verifier_env *env, int subprog)
+static int do_check_common(struct bpf_verifier_env *env, int subprog, bool in_sleepable)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
 	struct bpf_subprog_info *sub = subprog_info(env, subprog);
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_verifier_state *state;
 	struct bpf_reg_state *regs;
+	u32 old_insns_total = sub->insns_total;
 	u32 insn_processed = env->insn_processed;
 	int ret, i;
 
@@ -19579,7 +19585,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	state->curframe = 0;
 	state->speculative = false;
 	state->branches = 1;
-	state->in_sleepable = env->prog->sleepable;
+	state->in_sleepable = in_sleepable;
 	state->frame[0] = kzalloc_obj(struct bpf_func_state, GFP_KERNEL_ACCOUNT);
 	if (!state->frame[0]) {
 		kfree(state);
@@ -19721,7 +19727,8 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	 * Accumulate their total counts as total counts of the main or
 	 * global subprog hosting the async call.
 	 */
-	env->subprog_info[subprog].insns_total = env->insn_processed - insn_processed;
+	env->subprog_info[subprog].insns_total = old_insns_total +
+						(env->insn_processed - insn_processed);
 	return ret;
 }
 
@@ -19749,45 +19756,54 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog_aux *aux = env->prog->aux;
 	struct bpf_func_info_aux *sub_aux;
-	int i, ret, new_cnt;
+	int context, i, j, ret, new_cnt;
 
 	if (!aux->func_info)
 		return 0;
 
 	/* exception callback is presumed to be always called */
-	if (env->exception_callback_subprog)
-		subprog_aux(env, env->exception_callback_subprog)->called = true;
+	if (env->exception_callback_subprog) {
+		sub_aux = subprog_aux(env, env->exception_callback_subprog);
+		sub_aux->called[env->prog->sleepable] = true;
+	}
 
 again:
 	new_cnt = 0;
-	for (i = 1; i < env->subprog_cnt; i++) {
+	/*
+	 * Walk callers before callees so each global subprog normally sees all
+	 * of its contexts before it is verified. Async callback cycles can add a
+	 * context to an earlier subprog, so repeat until every called context is
+	 * verified.
+	 */
+	for (j = env->subprog_cnt - 1; j >= 0; j--) {
+		i = env->subprog_topo_order[j];
+		if (!i)
+			continue;
 		if (!bpf_subprog_is_global(env, i))
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
+	/* We can't loop forever as each pass verifies at least one new context,
+	 * and there are only two contexts per global subprog.
 	 */
 	if (new_cnt)
 		goto again;
@@ -19800,7 +19816,7 @@ static int do_check_main(struct bpf_verifier_env *env)
 	int ret;
 
 	env->insn_idx = 0;
-	ret = do_check_common(env, 0);
+	ret = do_check_common(env, 0, env->prog->sleepable);
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
 	return ret;
-- 
2.53.0

