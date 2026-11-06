Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937228;
	b=osGSqU+I6xk65EcD+1DpOa29kqroxsQAt/EnlVuRfnUXD61Kl3IGw7sV9dJlwQDxzQVp
	 sR4SuCCZ0/+SEsuIagWV4qXAGHR+5MbI3uXCkK+xlZVDPvmhf3aR1zIoCYtK/h67XXTIk
	 4JkHpd2oGgbCgkcsIi5fxKF9nwqHpAQAQ/D8WLpaUfYFnlUTY5QtlPvEJvkTZAattcJ/S
	 0Zfa+vEVfXiCTeZ88kH9KHhOVCMujUgZp7MYAyxbXXS0boGNpun1JU1MZwWW/EzTIfA8D
	 w4VPNE1Qv+KwoUJGbQfFes3eXuiGFdSkklpmKI3hDYe13UPVHATU5yKDYU/v286MrOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l+0fnLSO1xjtthCUlxvlEOfaD4uQ4pMHa7VBeKlF4S0=;
	b=qMTqH3oQikSOhE3zuspuNmgt/oUAkJc/9jbPArrG6bu2KGxDsy1y6pNYrZeR+msiI1yw
	 U+tOIR4laAH/LvLJQIn8x1lXEcf51IrtnO97hwpByRL3ghj4RcNIUo4/U2hLBymDtQT8x
	 WFP7L4NR/b3koXbvHgxA+UOIYXWY4kfLjSZ5q9ILDMXQ5SD2b6KqaKMN9tRIypQhpdlyz
	 P8S4JHYLM5aAWAko7qk8efyU6elNCRjmWErvP97l7EsCXEsmsSsIKkCPYY3UxDdhNVa4/
	 Cjwv62xE90isqJGWDpauvPG8j9je+AZ20sqgNh2DGc7G1L7qjne9DotxXeTxKmoaKhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eszTdCD1;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3D606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CA3D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eszTdCD1
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ea7190aea1so707935ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937227; x=1794542027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+0fnLSO1xjtthCUlxvlEOfaD4uQ4pMHa7VBeKlF4S0=;
        b=eszTdCD1PVxLAyL30kZzNzwIFFIwzKgGhtijpRf8af5wPheMcfu3epg2WINUC7uPa5
         yTdZ8Kdwp1jwCGigrvAOGtN4Vm5znvBcBzpjIb2hxpGa3uAlM2ckmU2cQWXocCQTHdMX
         NON4wjj4FwUPTBAd5g0maGi0i948lpew7GoFXBrRnkWazi2jeGvEjNIEdmvLRUhBXtDM
         hnDar7a3V6RXTwXgAL16cyUWIiNB8lK/PA/61GBqWkckI765+eDtaUtEIYKKtKHGAbb3
         cm6z4aoI9RFq8SZQg5FIoIyPxlHLmBlVT6VgTIq/syMWaybYE1AAYeZ6gKK7zcQ6u/N5
         DjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937227; x=1794542027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+0fnLSO1xjtthCUlxvlEOfaD4uQ4pMHa7VBeKlF4S0=;
        b=bJDLKO3QdIHTNL/ER/pYNEW1ZaFaAXnkOULVYkJuFDlGVNCU+JLy/DtRWV29sk3MqI
         Nr/Z8srsMpeI/vLJrbPGUJ3SPpRkPUF4XPFgC2Z3hmvo2JB4TwfpEbEf2PF/jHJ/Ixtl
         nSYpxZkIkMV4idOQPomfrByq+qoaIVGgKvG2Ing14ULk27AD2epOjl87AY0JvqyhcXv1
         sNJ8LUcXEIkLNrCyrdiaX/2poK/lqIzhpyZnx665LHNzkcaSHrHoiU+GddN4i2QfTPgs
         77c0oSYT/LDN9HgP+HrlwmVy2fieLfd6k83/b02y9eb4yCRlSG9M65ShzOzFdd2GKTtY
         OicQ==
X-Gm-Message-State: APuU4Z+O8j800O1ILoUSFP/ORrTD8iY40T9WomMdFocmbtIYLIID3fxY
	OgBGHBfyKNgS01wvWQIMy3AVQ3W9T8+N8eqCtYGL9M5gLDwShH6OaGsYSPhEww==
X-Gm-Gg: AYBFou1XWfiM4c5mDCup8hOMnRIHTKG2BXNjXWkXTG+lBHKvA4TDDfGkN+BMoTtSC3m
	sNBd5HiBuw//l0wQRaScT0C0AM5e42eODjruGCbTcCd73+svCO0f+QMJQnzfRvJyKsAoPOGDaXI
	bXuv1Fsqg7T7K8a1U68EfJQe+JCXnHADQvLc/O8a5yfPRbY1nymIkdw3wNV8s5YvS2zeUgjPa2R
	YG22QXxO7onwdJ7WJR8KsVUzHFMBvwOK6wcAtxs9gWtXCw44I14hmFdMB2lrA1d56wROWeZ/VoD
	we8R5MXlZO//Hpf5KI8zI58l7+gGafMZjsOkPN1OIAGrvXQ8WOuNoYi45Z25WbP1N+OB0oeLnDS
	Tk1noAlbxvFn0noQHaVYBGom7GTFbxr5pZgajRtttIEHAf40cyimtcwlWkYHSWUvlCSI+nh5h28
	/esWoL5etMHGhpLDJnRguwsDd1en5S/egLKXOVjKVkJICodboB2daVjqWkjrYRYGbuK4YqLO2RX
	2Mciea3izvLBCNp3k2Ys9YlCQ9HyoE0EE3zJ0YIwiJAt2IO8m32uhSIjdasy1WRftljj03gUida
	Mq0rE/Anc8Sr6vj0sADvo1M6ACOkoXzGZhCxbXxEErURrXLZ9tqcfIhXLbTsFN3f85sE+lfwzu7
	5zlAmt3qkf1cCeAimcvisze9VUorkHa93A8FOpVU0uPtW9nx1BhEiFHYVx+9fHBJ93Lb4yAlkMA
	==
X-Received: by 2002:a17:902:e847:b0:2dd:ad73:c98b with SMTP id d9443c01a7336-2ed40c02f59mr19355385ad.35.1793937226449;
        Thu, 05 Nov 2026 19:53:46 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d408c4sm1168835ad.31.2026.11.05.19.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:53:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 26/45] bpf: Update comments about paths, pruning and explored states
Date: Fri,  6 Nov 2026 03:50:50 +0000
Message-ID: <20261106035111.3315285-27-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

About 30 comments in verifier.c, states.c and bpf_verifier.h describe
a verifier that explores all paths of a prog and prunes a path against
explored states. The reader of regsafe() or stacksafe() learns from them
that the old state "already passed validation" and that the function
returns false "to continue verification of this path". Nothing of it is
true since the main pass is a fixpoint over the control flow graph.

Say what the code does now. States meet at the start of a basic block. The
verifier drops a state when a state that is already there covers it: if the
prog is fine with the old state, it is fine with the current one. Otherwise
it joins the two states or keeps both.

The largest change is above process_iter_next_call(). 60 lines explain how
a loop with an open-coded iterator converges: exact comparison, the depth
of the iteration, widening of scalars that are not precise. Such a loop is
a loop like any other now: what comes back to its head is joined with what
is there until nothing changes.

No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  11 ++--
 kernel/bpf/states.c          |  59 ++++++++------------
 kernel/bpf/verifier.c        | 102 ++++++++---------------------------
 3 files changed, 49 insertions(+), 123 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9439c8f90abd..6d385819bcf5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -58,7 +58,7 @@ struct bpf_stack_range {
 };
 
 struct bpf_reg_state {
-	/* Ordering of fields matters.  See states_equal() */
+	/* Ordering of fields matters.  See regsafe() */
 	enum bpf_reg_type type;
 	/*
 	 * Constant delta between "linked" scalars with the same ID.
@@ -438,10 +438,9 @@ struct bpf_func_state {
 	 * zero == main subprog
 	 */
 	u32 subprogno;
-	/* Every bpf_timer_start will increment async_entry_cnt.
-	 * It's used to distinguish:
-	 * void foo(void) { for(;;); }
-	 * void foo(void) { bpf_timer_set_callback(,foo); }
+	/*
+	 * The frame of an async callback has the count of frame 0 of the state
+	 * that sets the callback plus one. Frames that differ in it are not joined.
 	 */
 	u32 async_entry_cnt;
 	struct bpf_retval_range callback_ret_range;
@@ -1961,7 +1960,7 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn);
 void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			  struct bpf_call_summary *cs);
-/* Stack effects used for state pruning; must_write implies may_write. */
+/* Stack effects used for liveness; must_write implies may_write. */
 struct arg_access_info {
 	u32 size;		/* Maximum extent; U32_MAX if unknown. */
 	u8 may_read:1;		/* Incoming contents or initialization may be needed. */
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index fb7998654e16..07b1f0becd2e 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -229,7 +229,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
 {
 	if (rold->type == NOT_INIT)
-		/* explored state can't have used this */
+		/* nothing can be done with it */
 		return true;
 
 	/* Enforce that register types have to match exactly, including their
@@ -308,7 +308,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
 		 * BPF_ADD_CONST64 have different linking semantics in
 		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
-		 * so pruning across different flag types is unsafe.
+		 * so one doesn't stand for the other.
 		 */
 		if (rold->id &&
 		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
@@ -420,9 +420,10 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 {
 	int i, spi;
 
-	/* walk slots of the explored stack and ignore any additional
-	 * slots in the current stack, since explored(safe) state
-	 * didn't use them
+	/*
+	 * walk slots of the old stack and ignore any additional
+	 * slots in the current stack, since the old state
+	 * can't use them
 	 */
 	for (i = 0; i < old->allocated_stack; i++) {
 		struct bpf_stack_state *old_slot, *cur_slot;
@@ -441,9 +442,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (env->allow_uninit_stack && old_type == STACK_MISC)
 			continue;
 
-		/* explored stack has more populated slots than current stack
-		 * and these slots were used
-		 */
+		/* old stack has more populated slots than current stack */
 		if (!cur_slot)
 			return false;
 
@@ -471,10 +470,10 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (old_type == STACK_MISC && cur_slot->slot_type[im] == STACK_ZERO)
 			continue;
 		if (old_type != cur_slot->slot_type[im])
-			/* Ex: old explored (safe) state has STACK_SPILL in
+			/*
+			 * Ex: old state has STACK_SPILL in
 			 * this stack slot, but current has STACK_MISC ->
-			 * this verifier states are not equivalent,
-			 * return false to continue verification of this path
+			 * this verifier states are not equivalent
 			 */
 			return false;
 		if (im != BPF_REG_SIZE - 1)
@@ -482,15 +481,15 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		/* Both old and cur are having same slot_type */
 		switch (old_type) {
 		case STACK_SPILL:
-			/* when explored and current stack slot are both storing
+			/*
+			 * when old and current stack slot are both storing
 			 * spilled registers, check that stored pointers types
 			 * are the same as well.
-			 * Ex: explored safe path could have stored
+			 * Ex: old state could have stored
 			 * (bpf_reg_state) {.type = PTR_TO_STACK, .off = -8}
-			 * but current path has stored:
+			 * but current state has stored:
 			 * (bpf_reg_state) {.type = PTR_TO_STACK, .off = -16}
 			 * such verifier states are not equivalent.
-			 * return false to continue verification of this path
 			 */
 			if (!regsafe(env, &old_slot->spilled_ptr, &cur_slot->spilled_ptr, idmap))
 				return false;
@@ -537,7 +536,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
 /*
  * Compare stack arg slots between old and current states.
- * Outgoing stack args are path-local state and must agree for pruning.
+ * Outgoing stack args are a part of the state and must agree.
  */
 static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			   struct bpf_func_state *cur, struct bpf_idmap *idmap)
@@ -659,29 +658,17 @@ static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state
 
 /* compare two verifier states
  *
- * all states stored in state_list are known to be valid, since
- * verifier reached 'bpf_exit' instruction through them
- *
- * this function is called when verifier exploring different branches of
- * execution popped from the state stack. If it sees an old state that has
- * more strict register state and more strict stack state then this execution
- * branch doesn't need to be explored further, since verifier already
- * concluded that more strict state leads to valid finish.
- *
- * Therefore two states are equivalent if register state is more conservative
- * and explored stack state is more conservative than the current one.
+ * The state that gets to an insn doesn't have to be looked at when there is
+ * a state at that insn that is more conservative in registers and in the
+ * stack: if the program is fine with the old state it's fine with the current
+ * one.
  * Example:
- *       explored                   current
+ *          old                     current
  * (slot1=INV slot2=MISC) == (slot1=MISC slot2=MISC)
  * (slot1=MISC slot2=MISC) != (slot1=INV slot2=MISC)
  *
- * In other words if current stack state (one being explored) has more
- * valid slots than old one that already passed validation, it means
- * the verifier can stop exploring and conclude that current state is valid too
- *
- * Similarly with registers. If explored state has register type as invalid
- * whereas register type in current state is meaningful, it means that
- * the current state will reach 'bpf_exit' instruction safely
+ * Similarly with registers: the type in the old state is invalid whereas
+ * the type in the current state is meaningful.
  */
 static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			      struct bpf_func_state *cur, u32 insn_idx)
@@ -746,7 +733,7 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
 	reset_idmap_scratch(env);
 
 	/* Verification state from speculative execution simulation
-	 * must never prune a non-speculative execution one.
+	 * must never stand for a non-speculative execution one.
 	 */
 	if (old->speculative && !cur->speculative)
 		return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 285e459ef741..437a3fc03d0b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -62,19 +62,16 @@ static bool bpf_global_percpu_ma_set;
 
 /* bpf_check() is a static code analyzer that walks eBPF program
  * instruction by instruction and updates register/stack state.
- * All paths of conditional branches are analyzed until 'bpf_exit' insn.
  *
- * The first pass is depth-first-search to check that the program is a DAG.
+ * The first pass is depth-first-search over the control flow graph.
  * It rejects the following programs:
- * - larger than BPF_MAXINSNS insns
- * - if loop is present (detected via back-edge)
+ * - if loop is present (detected via back-edge) and the program is unprivileged
  * - unreachable insns exist (shouldn't be a forest. program = one function)
  * - out of bounds or malformed jumps
- * The second pass is all possible path descent from the 1st insn.
- * Since it's analyzing all paths through the program, the length of the
- * analysis is limited to 64k insn, which may be hit even if total number of
- * insn is less then 4K, but there are too many branches that change stack/regs.
- * Number of 'branches to be analyzed' is limited to 1k
+ * The second pass goes from basic block to basic block, starting at the 1st
+ * insn. States that meet at the start of a block are joined, so the length of
+ * the analysis follows the size of the program and not the number of paths
+ * through it. See flow.c.
  *
  * On entry to each instruction, each register has a type, and the instruction
  * changes the types of the registers depending on instruction semantics.
@@ -1358,7 +1355,7 @@ static bool is_stack_slot_special(const struct bpf_stack_state *stack)
  * - STACK_POISON, which truly forbids access to the slot.
  * Regardless of allow_ptr_leaks setting (i.e., privileged or unprivileged
  * mode), we won't promote STACK_INVALID to STACK_MISC. In privileged case it is
- * unnecessary as both are considered equivalent when loading data and pruning,
+ * unnecessary as both are considered equivalent when loading data and comparing states,
  * in case of unprivileged mode it will be incorrect to allow reads of invalid
  * slots.
  */
@@ -1782,9 +1779,7 @@ int bpf_copy_verifier_state(struct bpf_verifier_state *dst_state,
 	struct bpf_func_state *dst;
 	int i, err;
 
-	/* if dst has more stack frames then src frame, free them, this is also
-	 * necessary in case of exceptional exits using bpf_throw.
-	 */
+	/* if dst has more stack frames then src frame, free them */
 	for (i = src->curframe + 1; i <= dst_state->curframe; i++) {
 		free_func_state(dst_state->frame[i]);
 		dst_state->frame[i] = NULL;
@@ -8926,69 +8921,13 @@ static void iter_stops_loops(struct bpf_verifier_env *env, int insn_idx,
  * without having to simulate infinite amount of iterations.
  *
  * In current state, we first assume that iter_next() returned NULL and
- * iterator state is set to DRAINED (BPF_ITER_STATE_DRAINED). In such
- * conditions we should not form an infinite loop and should eventually reach
- * exit.
- *
- * Besides that, we also fork current state and enqueue it for later
- * verification. In a forked state we keep iterator state as ACTIVE
- * (BPF_ITER_STATE_ACTIVE) and assume non-NULL return from iter_next(). We
- * also bump iteration depth to prevent erroneous infinite loop detection
- * later on (see iter_active_depths_differ() comment for details). In this
- * state we assume that we'll eventually loop back to another iter_next()
- * calls (it could be in exactly same location or in some other instruction,
- * it doesn't matter, we don't make any unnecessary assumptions about this,
- * everything revolves around iterator state in a stack slot, not which
- * instruction is calling iter_next()). When that happens, we either will come
- * to iter_next() with equivalent state and can conclude that next iteration
- * will proceed in exactly the same way as we just verified, so it's safe to
- * assume that loop converges. If not, we'll go on another iteration
- * simulation with a different input state, until all possible starting states
- * are validated or we reach maximum number of instructions limit.
- *
- * This way, we will either exhaustively discover all possible input states
- * that iterator loop can start with and eventually will converge, or we'll
- * effectively regress into bounded loop simulation logic and either reach
- * maximum number of instructions if loop is not provably convergent, or there
- * is some statically known limit on number of iterations (e.g., if there is
- * an explicit `if n > 100 then break;` statement somewhere in the loop).
- *
- * Iteration convergence logic in is_state_visited() relies on exact
- * states comparison, which ignores read and precision marks.
- * This is necessary because read and precision marks are not finalized
- * while in the loop. Exact comparison might preclude convergence for
- * simple programs like below:
- *
- *     i = 0;
- *     while(iter_next(&it))
- *       i++;
+ * iterator state is set to DRAINED (BPF_ITER_STATE_DRAINED).
  *
- * At each iteration step i++ would produce a new distinct state and
- * eventually instruction processing limit would be reached.
- *
- * To avoid such behavior speculatively forget (widen) range for
- * imprecise scalar registers, if those registers were not precise at the
- * end of the previous iteration and do not match exactly.
- *
- * This is a conservative heuristic that allows to verify wide range of programs,
- * however it precludes verification of programs that conjure an
- * imprecise value on the first loop iteration and use it as precise on a second.
- * For example, the following safe program would fail to verify:
- *
- *     struct bpf_num_iter it;
- *     int arr[10];
- *     int i = 0, a = 0;
- *     bpf_iter_num_new(&it, 0, 10);
- *     while (bpf_iter_num_next(&it)) {
- *       if (a == 0) {
- *         a = 1;
- *         i = 7; // Because i changed verifier would forget
- *                // it's range on second loop entry.
- *       } else {
- *         arr[i] = 42; // This would fail to verify.
- *       }
- *     }
- *     bpf_iter_num_destroy(&it);
+ * Besides that, we also fork current state. In a forked state we keep iterator
+ * state as ACTIVE (BPF_ITER_STATE_ACTIVE) and assume non-NULL return from
+ * iter_next(). This state goes around the loop like in any other loop: what
+ * comes back to the head of the loop is joined with what is there until
+ * nothing changes, see flow.c.
  */
 static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 				  struct bpf_call_arg_meta *meta)
@@ -12619,7 +12558,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	}
 	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
-	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
+	 * bpf_throw, this will be done by do_check_block() for extra frames. */
 	free_func_state(callee);
 	state->frame[state->curframe--] = NULL;
 	invalidate_outgoing_stack_args(env, caller);
@@ -15338,7 +15277,7 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
  * Describe a helper's stack access through argument @arg (0-based, R1-R5).
  * must_write means the verifier destroys prior state throughout size bytes.
  * In other words, must_write follows the verifier's model of the
- * function's behaviour, which is safe to use for is_state_visited() pruning.
+ * function's behaviour, which is safe to use when states are cleaned and compared.
  */
 struct arg_access_info
 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
@@ -16620,7 +16559,8 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		alu_state |= ptr_is_dst_reg ?
 			     BPF_ALU_SANITIZE_SRC : BPF_ALU_SANITIZE_DST;
 
-		/* Limit pruning on unknown scalars to enable deep search for
+		/*
+		 * Keep states that differ in unknown scalars apart to find
 		 * potential masking differences from other program paths.
 		 */
 		if (!off_is_imm)
@@ -19251,7 +19191,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		if (is_null) {
 			/* We don't need id from this point
 			 * onwards anymore, thus we should better reset it,
-			 * so that state pruning has chances to take effect.
+			 * so that states have chances to be equal.
 			 */
 			__mark_reg_known_zero(reg);
 			reg->type = SCALAR_VALUE;
@@ -20716,8 +20656,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	/* The side effect of the prepare_func_exit which is
 	 * being skipped is that it frees bpf_func_state.
 	 * Typically, process_bpf_exit will only be hit with
-	 * outermost exit. copy_verifier_state in pop_stack will
-	 * handle freeing of any extra bpf_func_state left over
+	 * outermost exit. do_check_block() frees the state with
+	 * any extra bpf_func_state left over
 	 * from not processing all nested function exits. We
 	 * also skip return code checks as they are not needed
 	 * for exceptional exits.
-- 
2.55.0

