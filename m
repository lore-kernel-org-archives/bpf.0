Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022841;
	b=s6i8yUUnChdmT7lM1f14NFevZ15G69P134LrZcLs2Q0ZpTraCx06kiphr6F1T7+VkhHO
	 E/+7gM+w+4CAeN12kAwWYEIkt3doPrLN9ylgKeVok8hahQA3hu6Z+6INjnZ5xn85Ny46x
	 rtOtKk23GPHALZZN1WOi70IDipCaP6wTVMxZm1h7zXAvvlT9zY4TVnGKt29IQsoJiFUOw
	 JCd3ew76tiRPqPPtjmSZVaT4BZdjEb4Vb9IUGVU6Eh7cIXogqsyJz3w/W1MFQyXxob5Q+
	 7dNgVaeht0DtmhMsW51dBVPgmAQusZbDcvll8BV7WWLn07lurli2RsQrfxQsiHbwmxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RY+416TdCT0rVB8oIsWl+BXixqaFQcTR3UQHZAKFMSE=;
	b=MPN6cR8dvI+0Z+Q/VtrhqL3k+9sLOxGkuC2GNbJbsYhmuVxCHYZFsaIRGlHcUsIq2hbK
	 WNzxBDTkzxhMTnWPqZpBpj8wmS6Y8yE4L4DdaQN6kdktvK691jbaZTk4rWMI1045gxVJV
	 cHQNX18ZqNwqS+E51/4TpYbFrucE3ybbT0Bfixwzqy07zLpkHsT7BP9RWBkQ6rJ1BcBRv
	 TvnRJOYqwDOb4io2AEY5j/qVu+orQ0mOzKFuesTWB8e2CfeqDuy50XX5McpAyX/cpObrO
	 Rd7kGqDrGssOGEj7Jzy5LMS/5Yt3uRJR+iCUjT/M4YyJtAiHSkE7MZyIdxAKU8LS0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n9i94Vcx;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B7606A334
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32B7606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n9i94Vcx
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b2382bf051so606393b3a.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022840; x=1794627640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RY+416TdCT0rVB8oIsWl+BXixqaFQcTR3UQHZAKFMSE=;
        b=n9i94Vcxlm7wf2JndXJah8FIIKKlIr8Nz847+ivri3tOG8hl+AsDIUPmzHvcnRkYXU
         eBf/GyPBmfALIONiScpU7UArDwkAkzipWJ6e2wEZ+IWXROiTTUm/ZZrGvpe5F5zwNDHE
         1jUITIQh4fgy7QYAe1axWhfokE7vTlHK0zkFSc9/5G9I6hzrFdsTuA02TKCw/FWVrUiq
         dBj0PGBTF+DNoD0Q1aXcs4dOwPLlAMn4cmAOoEKFMZ/VZxXRDwvvVKxKE5XqEnzuXFdd
         zvJh0LHZ0TqcuN/nZjNJiI5tJ+8OkluGfe9jVwbhCJ5ae+UA6H1JNqx69jBm4nzwBoNE
         M46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022840; x=1794627640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RY+416TdCT0rVB8oIsWl+BXixqaFQcTR3UQHZAKFMSE=;
        b=TmKxGyeBliN9QXDiOCRpu8qy6g7lYBaCVPUFnHDnrUKSJ1TXbC53ONMvL0lHGGrcTn
         Md4Q39xQyngk4pv/Yzk9SR+eTEM0yywMLxYwC74dRTIAs4vMgzy98YGqtC7cmpVJTend
         nkjJBNyX8H5AKkHBsb6T+y40EkXYPXD3AUSY3updZdjHKcwpZX7stKDiuE3tuGa21lz+
         jtybJvpSFctV42jBdr92Z5pu7CyBtv/zPK28Fzb0VCM5QHhCPAF7AQVzIrDB5MDQ7DCd
         gZW5d3nR7jwGPnb3bJYiUmcFEN1koZvsZFcfNNOXhXy2uTRMXzN2TVLihD80qmfjM7CC
         prOw==
X-Gm-Message-State: APuU4Z8NOGJpAt03/CJXCpSmmbKdteHr3GAmQ0Pgm7i5uqP+2K4FMvni
	QIgOZm0QpR+VoSz73JZDOsU7wEgclR1b8iJcMvuwX5/0AIDe7b/FicRU16jdUA==
X-Gm-Gg: AYBFou0AP6RueMB7n/dtaS5CxBGqssY3gamr+0o77MF3nrC/I0vuuGRWIVZb9HEuH1B
	hXUwCfj8IRjENLTNF5jUjJQQ8HPZfprRxjSX9EV34tSy5FU/oAVLgRkFdgJxRtAAqt28zVX7rOu
	q6f3k4tdWksSv3fQhxfSBXxA0OvTdfnP6zrTE/l26rnfJAeictotlvAL8JtO8bB64SfkLNRH6Nw
	IvorQfqTYNEmte2WL9gn72/LRtO2r9vvfF5ittM0+tFxrgx4tbXuKwitMtO+P1MbKTq2wAihUxs
	t5uS4ZGZaIKT9evsGXOObn6hHYckB+g7TZ7f1sV8/JG03S5EBfC2Lcrt8u00OWjLPupG72P8/qp
	I3g89iWzpcNe8GPHFFVcI8Nc9+xeuM4WYxVO1+mdi/roWV2bWDktdKCH7OMxaHOmgSWFL5IqDUk
	escRTGQCcYNNOipBaew3g3Ygv2xuknENH97v4QpV66qPiPgxp26s4h477fn3xmxNyEmWg+B5rCU
	+g8061cULlqAfjGo1eXd8V7FFgY9dbW2NtoJAOIJydaAOQwthXRIlNeFws8VYNKmdjf+phJlRdj
	fDmLerF6CKGiYzuKZP9YoOIYsZGH9l9KaMWxBTpPNdnXbsUT2cdOryPSgovECJmVbhB4gFeTs0H
	D/a0SXDTt0URJ3WEvSmUe6NYxSqMLmCmuvTQnmTRybf0NVn6sp25vmbvTfCRGb+Bhl3g54VAsPt
	Q=
X-Received: by 2002:a05:6a00:2e24:b0:89e:b12e:7ee1 with SMTP id d2e1a72fcca58-8b377f7fe57mr4372707b3a.1.1794022839944;
        Fri, 06 Nov 2026 19:40:39 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597f003asm1105765b3a.29.2026.11.06.19.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:40:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 26/46] bpf: Update comments about paths, pruning and explored states
Date: Sat,  7 Nov 2026 03:37:34 +0000
Message-ID: <20261107033758.1547725-27-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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
index 762fe83cfd3a..6e855ef0b6e6 100644
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
@@ -443,10 +443,9 @@ struct bpf_func_state {
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
@@ -1984,7 +1983,7 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn);
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
index c786755b2a3c..7769b4bd1467 100644
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
@@ -8937,69 +8932,13 @@ static void iter_stops_loops(struct bpf_verifier_env *env, int insn_idx,
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
@@ -12635,7 +12574,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	}
 	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
-	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
+	 * bpf_throw, this will be done by do_check_block() for extra frames. */
 	free_func_state(callee);
 	state->frame[state->curframe--] = NULL;
 	invalidate_outgoing_stack_args(env, caller);
@@ -15361,7 +15300,7 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
  * Describe a helper's stack access through argument @arg (0-based, R1-R5).
  * must_write means the verifier destroys prior state throughout size bytes.
  * In other words, must_write follows the verifier's model of the
- * function's behaviour, which is safe to use for is_state_visited() pruning.
+ * function's behaviour, which is safe to use when states are cleaned and compared.
  */
 struct arg_access_info
 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
@@ -16643,7 +16582,8 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		alu_state |= ptr_is_dst_reg ?
 			     BPF_ALU_SANITIZE_SRC : BPF_ALU_SANITIZE_DST;
 
-		/* Limit pruning on unknown scalars to enable deep search for
+		/*
+		 * Keep states that differ in unknown scalars apart to find
 		 * potential masking differences from other program paths.
 		 */
 		if (!off_is_imm)
@@ -19308,7 +19248,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		if (is_null) {
 			/* We don't need id from this point
 			 * onwards anymore, thus we should better reset it,
-			 * so that state pruning has chances to take effect.
+			 * so that states have chances to be equal.
 			 */
 			__mark_reg_known_zero(reg);
 			reg->type = SCALAR_VALUE;
@@ -20773,8 +20713,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
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

