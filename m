Received: from mta1.migadu.com (out-102.mta1.migadu.com [95.215.58.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1A5012BE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577705; cv=none; b=fI+ZqkeDZBdDj2fjLsDuG1ThU1qZC6sGx1aJGK0+uZGTKpOPhx0/YnVQWcVlboSEwcEAf2surpalGUXhIGgeJUXha+8HWC1LReV7m6Ct2ax+qd77niE5uGpwQL6nHQGoTppFxcYUHo01hB0E3EJKF4FOe/tEfAnA7PdMDKjMoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577705; c=relaxed/simple;
	bh=RnTN0WqJHc30mYPXgRMzpCnBfDU3HJINk3ADYJn26NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1q0xHDv+yVs9kDEm8HghUtp1Cmm3XMa4QR4EFvM9ZtuHebgmEGm6OPMRDoGOQIYVl+fCMgc2/+XtczCTMppLYsApSef0iUSRa0cVOEBJZBXwRQDjv8edQweDRrMuXSLNw9oe92GjIXLLyVAIi5Y2P57ECMprEv0aCBoACy7XLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S4YH2BfO; arc=none smtp.client-ip=95.215.58.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S4YH2BfO"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RnTN0WqJHc30mYPXgRMzpCnBfDU3HJINk3ADYJn26NM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577700; v=1; x=1792182500;
 b=S4YH2BfOBT1Nr7KlkCKRdnD0TrTgOCguB9DaShQPH1URJ/8126Ci3fhxfLDGkNjdJ+hnShGS
 gJsLx7b0NqNWTNVtDAy58CjUxKQ9G63BRuJvqd9smhrm1l48aqL67qP4WuF976KaXDXsbBY59Bp
 D4xVlnRXMMg0GvGJ6s++oDYw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ff79169a2ba3382;
	Fri, 09 Oct 2026 20:28:20 +0000
X-Mizu-Trace-ID: 9ff79169a2ba3382
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 01/11] bpf: Set up callee state outside of setup_func_entry()
Date: Fri,  9 Oct 2026 13:27:48 -0700
Message-ID: <20261009202759.50520-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009202759.50520-1-ihor.solodrai@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callback argument setup may need to attach bookkeeping to the verifier
state owning the callee frame. The frame should be current in that
state before the arguments are set up.

For sync callbacks, the setter runs inside setup_func_entry() before
the new frame becomes current. Async callback setters already run on a
complete state, directly from push_callback_call().

Move sync callback argument setup to push_callback_call() after the
frame is in place. Leave setup_func_entry() responsible for pushing the
frame, and copy static-call arguments directly.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 69 +++++++++++++------------------------------
 1 file changed, 20 insertions(+), 49 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 353bde9ae227..a0310e093880 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10821,32 +10821,25 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
-static int set_callee_state(struct bpf_verifier_env *env,
-			    struct bpf_func_state *caller,
-			    struct bpf_func_state *callee, int insn_idx);
-
-static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int callsite,
-			    set_callee_state_fn set_callee_state_cb,
-			    struct bpf_verifier_state *state)
+static struct bpf_func_state *setup_func_entry(struct bpf_verifier_env *env, int subprog,
+					       int callsite, struct bpf_verifier_state *state)
 {
-	struct bpf_func_state *caller, *callee;
-	int err;
+	struct bpf_func_state *callee;
 
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
 		verbose(env, "the call stack of %d frames is too deep\n",
 			state->curframe + 2);
-		return -E2BIG;
+		return ERR_PTR(-E2BIG);
 	}
 
 	if (state->frame[state->curframe + 1]) {
 		verifier_bug(env, "Frame %d already allocated", state->curframe + 1);
-		return -EFAULT;
+		return ERR_PTR(-EFAULT);
 	}
 
-	caller = state->frame[state->curframe];
 	callee = kzalloc_obj(*callee, GFP_KERNEL_ACCOUNT);
 	if (!callee)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	state->frame[state->curframe + 1] = callee;
 
 	/* callee cannot access r0, r6 - r9 for reading and has to write
@@ -10858,19 +10851,9 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			callsite,
 			state->curframe + 1 /* frameno within this callchain */,
 			subprog /* subprog number within this prog */);
-	err = set_callee_state_cb(env, caller, callee, callsite);
-	if (err)
-		goto err_out;
-
-	/* only increment it after check_reg_arg() finished */
 	state->curframe++;
 
-	return 0;
-
-err_out:
-	free_func_state(callee);
-	state->frame[state->curframe + 1] = NULL;
-	return err;
+	return callee;
 }
 
 static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const struct btf *btf,
@@ -10990,10 +10973,6 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (err == -EFAULT)
 		return err;
 
-	/* set_callee_state is used for direct subprog calls, but we are
-	 * interested in validating only BPF helpers that can call subprogs as
-	 * callbacks
-	 */
 	env->subprog_info[subprog].is_cb = true;
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
@@ -11044,8 +11023,11 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 	if (IS_ERR(callback_state))
 		return PTR_ERR(callback_state);
 
-	err = setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
-			       callback_state);
+	callee = setup_func_entry(env, subprog, insn_idx, callback_state);
+	if (IS_ERR(callee))
+		return PTR_ERR(callee);
+
+	err = set_callee_state_cb(env, caller, callee, insn_idx);
 	if (err)
 		return err;
 
@@ -11069,8 +11051,8 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_subprog_info *caller_info;
 	u16 callee_incoming, stack_arg_cnt;
-	struct bpf_func_state *caller;
-	int err;
+	struct bpf_func_state *caller, *callee;
+	int i;
 
 	caller = state->frame[state->curframe];
 
@@ -11088,9 +11070,12 @@ static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
 	 * For regular function entry setup new frame and continue
 	 * from that frame.
 	 */
-	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state, state);
-	if (err)
-		return err;
+	callee = setup_func_entry(env, subprog, *insn_idx, state);
+	if (IS_ERR(callee))
+		return PTR_ERR(callee);
+
+	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
+		callee->regs[i] = caller->regs[i];
 
 	bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CALLER_SAVED);
 	clear_caller_saved_regs(env, caller->regs);
@@ -11301,20 +11286,6 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static int set_callee_state(struct bpf_verifier_env *env,
-			    struct bpf_func_state *caller,
-			    struct bpf_func_state *callee, int insn_idx)
-{
-	int i;
-
-	/* copy r1 - r5 args that callee can access.  The copy includes parent
-	 * pointers, which connects us up to the liveness chain
-	 */
-	for (i = BPF_REG_1; i <= BPF_REG_5; i++)
-		callee->regs[i] = caller->regs[i];
-	return 0;
-}
-
 static int set_map_elem_callback_state(struct bpf_verifier_env *env,
 				       struct bpf_func_state *caller,
 				       struct bpf_func_state *callee,
-- 
2.56.0

