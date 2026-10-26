Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983968;
	b=yeKDp7G0rKj0tjOm2DmYvhtSU6PPLlpvcupGtIuAtHybWPKB/AhV9L/dDLd9foDnTsRW
	 +9bfrW4x/EYrTXeCsuJqieo6ZAUh7gWnT9ZqTZCihdGLv4BqZy84NjMYQ+xETG775k6S7
	 stGRqrzThcWBiLBPZCW2WpvT/UyCiqHuSOIMLqyUf99+FbUKqZuNK3VWdBhZJKQBvHBqC
	 my9+omIM5SWH54pEtsqfZ+22SuMj8s1GhV0tBAsEeSGP4n5Iqhqe1A7a+h2zX+8Dusl5B
	 5OsVPuCaFXm56s1qB2fu8qLwOUCOxnnUl/0iFiQnyIYqHFir6zHt936FGtoFFao9tZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZauMOPhRpHr1z3P+mJf3juPI8kRv8pp/OncCajEjD0g=;
	b=EuGNI8W3ZaYIKOH/FZCLe/u2epDolo2OqpT63FaSZO+ouo0giX2HNNcfhG/rndIgRgB6
	 WkDU9WELQnc1RGwx5RqAuQTiYPZSWa0YyPvxMtvZhpUScxniz0+vUl7CwLzczcKWgr4MS
	 ah+1GiYk0AOeiPe93i0i4f/8NcEztyfV7gHypiVXHpQndQcb7Z+EI1aya+bGWT/v9o6wB
	 G0rdBrFNAYjXaphw4EfMC3A82R/wEUB2KkPCmOK6CsgJBoYvoucbMoZ/vPJ2FvAX76tuy
	 xnQRURPUemZfMfyvB+/PfxopHCg9S7lRAcCbuJ2uT3Nfl/1Ss5PydZeTLGezBC1UExA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V49CHYdm;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B301606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B301606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V49CHYdm
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9ae391a05so16873285ad.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983968; x=1793588768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZauMOPhRpHr1z3P+mJf3juPI8kRv8pp/OncCajEjD0g=;
        b=V49CHYdmiBWWZvcsZFLPQLt3Gjr9RdFhbqUR0oxLYFsBRddDREmtJZZuKqfAblDTdO
         ziu7YjhrlLxUAoPPl/2Rt1KIY7gDKhHza6DVZ4ZcH12rKPJZj4Mxtdw89cpSfvE2mBIB
         3sX52T77Kqqi3KpCEiqF/OID4pq/Ss7VXchm7c53RiQVS0G2BpzOl6xJcEW+Wq++8qkv
         YTs3JEbdxvoDip/0UuESyhu496KeufpWCcqmVa6c3R4OcRJ/K00qFxFTtcZR8bpm6fIJ
         H1nwOM9YZ2O/RNUaRZf9tpMERNsqyn6u5QXvSXFi6JBKj2iwA5XGRXBVTY6ujNeI7CK8
         hEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983968; x=1793588768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZauMOPhRpHr1z3P+mJf3juPI8kRv8pp/OncCajEjD0g=;
        b=T4+rjdj7aFQuQBmBDf57WJUqt5ANNd66ueR8HUxgqrSAK3zfoTNmGZDAO7pLl2PFf/
         OtNycNtLJbq9XfA2L644uSKlhdp3+9xQfsoUqsapCXs2LT1xTqNJRxNu7nTCwbMbqx0s
         qt9hhWUBtJK+wiqKARvFqUAouim3ucftbh0r1slukmLBGJMYO9p5rCnUo6iyU4QOl+KA
         y0S2uYX7V1DfEI9otPgAaSW8y5koaEgfiJ8qDRBWxxKAaeqm+J1kyhxKDdfFqFB7gIPp
         D9FHHI6saBdi0CAp+sHDXfHB/J9N3rfbv+p6NueUpw5R/Zy88d1lzDQLtANGc+jcRVVL
         O6WA==
X-Gm-Message-State: AFq9FYJmESDl28+3k8KuTYh27S4rXwGDoNfhEJVd7LHmGgpLn8HHsxdz
	RyWRBVxRkxKHpRLtETYJ+zfkMndlMIU5q4ueR3RSBYs/Wz5+5L5hAxbRAsq+ag==
X-Gm-Gg: AYBFou0GB2yzktlD0Jvmg0FPK9cLvfdDpqfxTcWORSOT9FuBGRxw0R64BtZUtRQuKbv
	DMUxdTBCxVCpAnj35Zac68g/85TNXI6d91D8LZDXKEktW1qBF9GUnSa13SKfGlDUDFIRonzxA+8
	fotd4k0ib4wd89IPFr88N8Vq5t1jmCUlzjlt9LdGPAMLQrHaynZiUYfskk6Fv8ENjAhZ3VbOOYr
	M+J//2dBkpi8o/nFtXDnWsvtULFfl0ybSZW2Ucmsr3ZsaOJkp9n0m36lKiIK356D9iDh8yFTgl3
	EqlygkkS+FZFm5i4n79+Gr4+HfT2v01BR9uWwTwyMWEGZdgiNpB36TJbocyEk9fgcsWIFL34r4+
	R+GPoRFe0DGsMsAX8NgkNdc/jjdyjG6bVNX4SZf/2POT22GgGTO2KLLQyVg4nMjOC86crlDWTEQ
	uwWnEOZjelySC9ByHFH8DPdQRkx3+aNd0HR0MlaQ4r5xmupOZvaGDmQ6k7cYZB58u5KhMDh37D0
	D6FVjqzR82TvH0KHz1mJsHkw/wAT+96EopNHjoVEE+11ltG1Wps/wbXvnSVX/a27UT6PCIw1MXm
	Y3YRF3hcY8YkEFIz2jMprX39sf77DeseeHTghyIVKCVHRIrjjG97QS/bHkbJ0C4bzTDEDs9ALv9
	lePXFoeW3kOCXURhhmUitnYCd
X-Received: by 2002:a17:903:40c6:b0:2e9:4cee:c8b9 with SMTP id d9443c01a7336-2ea9c80ddadmr35810695ad.14.1792983967246;
        Sun, 25 Oct 2026 20:06:07 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b2209basm9920715ad.73.2026.10.25.20.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:06 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 65/81] bpf: Update comments about paths, pruning and explored states
Date: Mon, 26 Oct 2026 02:59:26 +0000
Message-ID: <20261026025943.404450-66-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

Many comments in verifier.c and states.c describe a verifier that explores
all paths of a prog and prunes a path against explored states. Since
"bpf: Verify programs as a fixpoint over the control flow graph" the
verifier does not do that.

Describe what it does. States meet at the start of a basic block. The
verifier drops a state when a state that is already there covers it.
Otherwise it joins the two states or keeps the two.

The largest change is above process_iter_next_call(). The verifier verifies
a loop with an open-coded iterator in the same way as other loops. Thus
remove the description of the special convergence logic.

No functional changes.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  4 +-
 kernel/bpf/states.c          | 56 ++++++++-------------
 kernel/bpf/verifier.c        | 97 +++++++-----------------------------
 3 files changed, 41 insertions(+), 116 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index edac38665f54..d02f6938c2e1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -51,7 +51,7 @@ enum bpf_iter_state {
 };
 
 struct bpf_reg_state {
-	/* Ordering of fields matters.  See states_equal() */
+	/* Ordering of fields matters.  See regsafe() */
 	enum bpf_reg_type type;
 	/*
 	 * Constant delta between "linked" scalars with the same ID.
@@ -1758,7 +1758,7 @@ bool bpf_is_may_goto_insn(struct bpf_insn *insn);
 void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			  struct bpf_call_summary *cs);
-/* Stack effects used for state pruning; must_write implies may_write. */
+/* Stack effects used for liveness; must_write implies may_write. */
 struct arg_access_info {
 	u32 size;		/* Maximum extent; U32_MAX if unknown. */
 	u8 may_read:1;		/* Incoming contents or initialization may be needed. */
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index f1f185f9ce13..5487987b2441 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -227,7 +227,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		    struct bpf_reg_state *rcur, struct bpf_idmap *idmap)
 {
 	if (rold->type == NOT_INIT)
-		/* explored state can't have used this */
+		/* nothing can be done with it */
 		return true;
 
 	/* Enforce that register types have to match exactly, including their
@@ -306,7 +306,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
 		 * BPF_ADD_CONST64 have different linking semantics in
 		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
-		 * so pruning across different flag types is unsafe.
+		 * so one doesn't stand for the other.
 		 */
 		if (rold->id &&
 		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
@@ -418,9 +418,9 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 {
 	int i, spi;
 
-	/* walk slots of the explored stack and ignore any additional
-	 * slots in the current stack, since explored(safe) state
-	 * didn't use them
+	/* walk slots of the old stack and ignore any additional
+	 * slots in the current stack, since the old state
+	 * can't use them
 	 */
 	for (i = 0; i < old->allocated_stack; i++) {
 		struct bpf_stack_state *old_slot, *cur_slot;
@@ -439,9 +439,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (env->allow_uninit_stack && old_type == STACK_MISC)
 			continue;
 
-		/* explored stack has more populated slots than current stack
-		 * and these slots were used
-		 */
+		/* old stack has more populated slots than current stack */
 		if (!cur_slot)
 			return false;
 
@@ -469,10 +467,9 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (old_type == STACK_MISC && cur_slot->slot_type[im] == STACK_ZERO)
 			continue;
 		if (old_type != cur_slot->slot_type[im])
-			/* Ex: old explored (safe) state has STACK_SPILL in
+			/* Ex: old state has STACK_SPILL in
 			 * this stack slot, but current has STACK_MISC ->
-			 * this verifier states are not equivalent,
-			 * return false to continue verification of this path
+			 * this verifier states are not equivalent
 			 */
 			return false;
 		if (im != BPF_REG_SIZE - 1)
@@ -480,15 +477,14 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		/* Both old and cur are having same slot_type */
 		switch (old_type) {
 		case STACK_SPILL:
-			/* when explored and current stack slot are both storing
+			/* when old and current stack slot are both storing
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
@@ -541,7 +537,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 
 /*
  * Compare stack arg slots between old and current states.
- * Outgoing stack args are path-local state and must agree for pruning.
+ * Outgoing stack args are a part of the state and must agree.
  */
 static bool stack_arg_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			   struct bpf_func_state *cur, struct bpf_idmap *idmap)
@@ -639,29 +635,17 @@ static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state
 
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
@@ -716,7 +700,7 @@ bool bpf_state_subsumes(struct bpf_verifier_env *env, struct bpf_verifier_state
 	reset_idmap_scratch(env);
 
 	/* Verification state from speculative execution simulation
-	 * must never prune a non-speculative execution one.
+	 * must never stand for a non-speculative execution one.
 	 */
 	if (old->speculative && !cur->speculative)
 		return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51106df0e76e..2e46287deb08 100644
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
@@ -1343,7 +1340,7 @@ static bool is_stack_slot_special(const struct bpf_stack_state *stack)
  * - STACK_POISON, which truly forbids access to the slot.
  * Regardless of allow_ptr_leaks setting (i.e., privileged or unprivileged
  * mode), we won't promote STACK_INVALID to STACK_MISC. In privileged case it is
- * unnecessary as both are considered equivalent when loading data and pruning,
+ * unnecessary as both are considered equivalent when loading data and comparing states,
  * in case of unprivileged mode it will be incorrect to allow reads of invalid
  * slots.
  */
@@ -8641,69 +8638,13 @@ static struct bpf_reg_state *get_iter_from_state(struct bpf_verifier_state *cur_
  * without having to simulate infinite amount of iterations.
  *
  * In current state, we first assume that iter_next() returned NULL and
- * iterator state is set to DRAINED (BPF_ITER_STATE_DRAINED). In such
- * conditions we should not form an infinite loop and should eventually reach
- * exit.
+ * iterator state is set to DRAINED (BPF_ITER_STATE_DRAINED).
  *
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
- *
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
 /*
  * The program asks for the next element after it was told that there is none. So it didn't
@@ -12348,7 +12289,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	}
 	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
-	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
+	 * bpf_throw, this will be done by do_check_block() for extra frames. */
 	free_func_state(callee);
 	state->frame[state->curframe--] = NULL;
 	invalidate_outgoing_stack_args(env, caller);
@@ -15039,7 +14980,7 @@ int bpf_fetch_kfunc_arg_meta(struct bpf_verifier_env *env,
  * Describe a helper's stack access through argument @arg (0-based, R1-R5).
  * must_write means the verifier destroys prior state throughout size bytes.
  * In other words, must_write follows the verifier's model of the
- * function's behaviour, which is safe to use for is_state_visited() pruning.
+ * function's behaviour, which is safe to use when states are cleaned and compared.
  */
 struct arg_access_info
 bpf_helper_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *insn,
@@ -16300,7 +16241,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 		alu_state |= ptr_is_dst_reg ?
 			     BPF_ALU_SANITIZE_SRC : BPF_ALU_SANITIZE_DST;
 
-		/* Limit pruning on unknown scalars to enable deep search for
+		/* Keep states that differ in unknown scalars apart to find
 		 * potential masking differences from other program paths.
 		 */
 		if (!off_is_imm)
@@ -18875,7 +18816,7 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		if (is_null) {
 			/* We don't need id from this point
 			 * onwards anymore, thus we should better reset it,
-			 * so that state pruning has chances to take effect.
+			 * so that states have chances to be equal.
 			 */
 			__mark_reg_known_zero(reg);
 			reg->type = SCALAR_VALUE;
@@ -20335,8 +20276,8 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
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

