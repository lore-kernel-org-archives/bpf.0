Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DAF4C652D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542942; cv=none; b=LErhOIEi8+KJY4PFnHNVWJnGWi4bzbZOYDK9BA/MqsGzW74ogg/OXf4ZEg7MQke8d/FjbInGtJm07JazskXIDY1Y08AYHWpoCoshNIs80GAURt19my5v5yOXEEoeZaSZVy4jpLgJy7kI78uKcCLFbtbOK4u2ot3l0echYLKpL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542942; c=relaxed/simple;
	bh=ZZDAH5p+8hPDmaX/6vh5snsUYldF6KrJQKQv2wVkba8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiv+ouHmhH3AgKqfCd70hKg5v2RJDLcDyQURfn/X23DJRz39M07VCubDSw9+CjUGkihLn220AAKSGbCYLOrvAYTGjsmSU4c7EKhGtab/M07sBIz/KTWvum5y7WJo6QnR5OJMqKnJGC5TRQAQ3LET6mMSpQ+lu7sAC/tyILQ6WFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxpeyNn5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxpeyNn5"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so3706499a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542924; x=1792147724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p5Mo+7/dQTrvq0bIVjs6+lKsxchim5fr6SbC49D+h7A=;
        b=SxpeyNn5t1fkNW+wjB82RRhZ38cIqA2DxYJ0BQ4fm62fk7kmZSZ9Nk2Hz5YF5VmKlo
         ikJQlDZY552dSw3Oh9jnfL3mUccJadrnTKbtai6Q7oV7kfgSrRA9eQQ1ngylXudoRTXK
         8mfgLC6oB2Vt5mRjZ+lO9q9FH4VxQACIz/Pl28xLdY5Gs+tEx63B5foLXP/SFnMA1V4w
         gZ0ljaGpFn6Krx4ZG+KamvIv0MpbeX65ggZwGBxB9lovnii7oMm98R1FNjo30Ik0ZS8l
         TPPZHDnGEWHdUXY6bimTPqkoDRZIbMh0hv1EmO7ZSECoEIRuJ/Oj8pz3e2t/+UInpp9x
         sgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542924; x=1792147724;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p5Mo+7/dQTrvq0bIVjs6+lKsxchim5fr6SbC49D+h7A=;
        b=Il4F/5rrZrKbNgj0i+8hjfkD16E3dOrxkxkOzDnTvrv1hqgcFZrjMPFJI99soGwW7I
         gLYs1y4HK41svsGEu19rJMb5jGSsKiEK6GC1Rd1LPEkmShsapkY3dySXyNuRegQK7pL3
         2xi0SQPIl96eHNngDnwbm73kaJkOPLJTz8CyfUPPZ7SGltF9ObKQGtLC7PZAHJnVb3Zz
         +Djbn44txeQhJjyjY7E2nOIZH/i7caOMSBuiPNPkjmYafNXBsZjUgVrphA/ndDxaU7oq
         Iel3fuV/w8XcD3fi/SDmj692LxwxO+90BOtwkY/rpcPcs0gmG8T5JsGieGWS6pU68s4u
         dVgA==
X-Gm-Message-State: AFq9FYK2dNAO664IifVf0mGr4N1HlhDB6IHillkZKFU9MI73lG3gH3Pj
	MDD9dw2+1bA+Bvdm2yXZ8+geQoqiORfHYRd9ysVeyu8cqgodEx8RL2FZL6BbuKKt
X-Gm-Gg: AYBFou1Xki2G1ZNci/0XB1kVrrBJOV/HUYaBoaboiYLPtFpCN1P7Sp9SZBSPToJlRCb
	aJoPU9Iv3YJT0e6Y1PXBQLVR3UvedZsOBAW11WQkrHFBIFogDXrttU3v4hkshcnKQ2jPLs1ySrJ
	Mm8eqfZsKCp5zxkRwOzKT4cmbvuE3RXwN+LgCsvFsi0kl142wQasm0bZX1i4uXqSjkWWZ412Ays
	92ltVCivBpifZtphCIBPZMI3d8yZPipzFGTeMrwz3GhP01tOA+NvWvq40adjNKnZmD/y6L4mRrC
	wg0R8RrvwPihOxTKZvB19dWGIPEYwy+qahMiV6e99mljXJKzuGTX1XAULpz7suHt81N+p73Jyl5
	o7gz4aIL2jwBo7SgqGWoOKXSJlEWEV7pRSyZBzoBNC2nJcgf4pZ8FMNJMVI+0izo781nrMGJ8Dp
	uZ39ugE4WYcOJSRziZNFE/tGin8CKvbL0cpEc0OO4lRhngnYLf3UudI7JB8G8+pPczYIeSIqNuy
	xnQVnTQksJSuSmAev+bI2+RcQ==
X-Received: by 2002:a17:90a:e7ca:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3ab3a953814mr1350794a91.25.1791542923825;
        Fri, 09 Oct 2026 03:48:43 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:43 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 34/51] bpf: use SCEV to widen bounded loops
Date: Fri,  9 Oct 2026 03:47:52 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-34-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Loop-bound computation and register widening
===========================================

During the main verification pass, use SCEV expressions and register
values at the entry to the loop to estimate the number of iterations
the loop might execute. Use this number to widen loop induction variables.

For example:

    0: r7 = 5;
    1: r6 = 0;
    2: while (r6 < 3) {   // latch
    3:     if (r6 == 1)
    4:         r7 = 10;
    5:     r6 += 1;
    6: }
    8: use(r7);

- Scalar evolution expressions (SCEVs) at the latch are:
  - r6 = (linear r6 1)
  - r7 = (any r7 10)
- For this pre-condition loop, this corresponds to the linear inequality
  `r6_entry + n < 3`. With r6_entry = 0, the inequality is `n < 3`.
- Hence infer that r6's range at line 2 is [0,3], including the final
  failed test. The body starts with r6 in [0,2].
- r7's (any r7 10) expression means that its initial value 5 from line 0
  is joined with 10 from line 4: it is widened to [5,10] within
  and after the loop.

Currently such inference is supported for:
- Reducible loops with one backedge and complete backedge/exit lists.
- A linear latch dominating the backedge, with one successor exiting
  the loop. Additional exits are allowed; they can shorten execution.
- 64-bit arithmetic and comparisons whose continuation condition
  normalizes to signed/unsigned < or <=, or !=.
- Initial counter, latch offset, slope and bound evaluable as constants
  at loop entry, yielding a finite, representable iteration bound.
- Values with an eligible type at loop entry, e.g. SCALAR_VALUE or
  PTR_TO_STACK, but not PTR_TO_CTX.

In order for widening to proceed, every register live at the loop
entry has to have a SCEV that can be widened. Currently, the following
expressions are supported:
- (linear <self> <step>): entry value + iteration# * constant step.
- (reg <self>): loop invariant; keep its entry value unchanged.
- (any ...): join the entry value with immediates or invariant registers;
  types must match, and immediates require SCALAR_VALUE.

Main verification loop integration
==================================

Before proceeding with the usual instruction processing, do_check()
takes the following steps at loop entries (H):
- Checks whether the loop can be widened and obtains its
  iteration bound (scev.c:bpf_compute_loop_iters()).
- If it can, saves an unwidened checkpoint E0, which will be used as
  a base for deriving widened values throughout this invocation of
  the loop.
- Widens registers in the current state using E0 and SCEV expressions
  computed for H (scev.c:bpf_widen_scev_regs()).
- Pushes a per-frame loop-stack record to the current verifier state.
  For terminating loops, the record stores E0 and the iteration bounds.
- Lets is_state_visited() create a new checkpoint W at the same
  header, now containing the widened values, and proceeds with
  normal checking.
- On an exit edge, pops the loop record and verifies the exit
  path normally.

is_state_visited() treats a loop proven to terminate like an
iterator-based loop: RANGE_WITHIN comparison attempts to establish
convergence against a checkpoint whose exploration is still
in progress.

For example:

    r0 = 0;
    H: r0 += 1;
       if (r0 != 3) goto H;
       exit;

    first H:  prove H_count = 3; save E0(r0 = 0)
              widen r0 to [0,2]; push the loop record
              save W(r0 = [0,2])
    body:     r0 becomes [1,3]; fork at the conditional
    exit:     r0 = 3; pop the loop record and check exit
    backedge: r0 = [1,2]; clamp, then match with W and prune

Clamping
--------

Independent register ranges lose correlations between induction
variables. For example:

    r6 = 0; r7 = 0;
    do { r6 += 1; r7 += 2; } while (r6 < 3);
    use(r7);

    header:   r6 in [0,2], r7 in {0,2,4}
    body:     r6 in [1,3], r7 in {2,4,6}
    backedge: r6 in [1,2], r7 still in {2,4,6}

The latch narrows r6 but does not propagate this refinement to r7.
To account for this, before comparing states on a backedge,
scev.c:bpf_clamp_scev_regs() recomputes r7's range from E0 and the
saved iteration bound, then intersects the current range {2,4,6}
with the recomputed {0,2,4}, arriving at {2,4}.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                       |   33 +
 kernel/bpf/log.c                                   |    5 +
 kernel/bpf/scev.c                                  | 1039 ++++++++++++++++++++
 kernel/bpf/states.c                                |   88 +-
 kernel/bpf/verifier.c                              |  205 +++-
 tools/testing/selftests/bpf/progs/verifier_gotox.c |    6 +-
 6 files changed, 1364 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 52f72e92eb0c..d760d2283ac5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -328,6 +328,25 @@ struct bpf_retval_range {
 	bool return_32bit;
 };
 
+/* SCEV/widening register space: r0..r10 plus every stack slot of a frame. */
+#define BPF_SCEV_REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
+
+struct bpf_loop_iters {
+	u32 min_header_count;   /* min number of times header is executed */
+	u32 max_header_count;   /* max number of times header is executed */
+	unsigned long precise_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+};
+
+struct loop_stack_entry {
+	struct bpf_verifier_state *entry_state;
+	u32 min_header_count;
+	u32 max_header_count;
+	u32 loop_id:31;
+	u32 terminates:1;
+};
+
+#define LOOP_STACK_SIZE 16
+
 /* state of the program:
  * type of all registers and stack info
  */
@@ -373,6 +392,11 @@ struct bpf_func_state {
 	u32 callback_depth;
 	/* Instructions processed in this frame and callees on the current path. */
 	u32 insns_subtotal;
+	/*
+	 * Control-flow loop nesting at the current insn within this frame's
+	 * subprogram (loops never cross subprogram boundaries).
+	 */
+	u32 loop_stack_cnt;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -390,6 +414,7 @@ struct bpf_func_state {
 
 	u16 out_stack_arg_cnt; /* Number of outgoing on-stack argument slots */
 	struct bpf_reg_state *stack_arg_regs; /* Outgoing on-stack arguments */
+	struct loop_stack_entry *loop_stack;
 };
 
 #define MAX_CALL_FRAMES 16
@@ -436,6 +461,7 @@ static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
 			 MAX_CALL_FRAMES)
+
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
@@ -1971,4 +1997,11 @@ int bpf_init_scev(struct bpf_verifier_env *env);
 void bpf_free_scev(struct bpf_verifier_env *env);
 int bpf_compute_scev(struct bpf_verifier_env *env);
 
+int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			   struct bpf_loop_iters *iters);
+int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters);
+int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 insn_idx,
+			struct bpf_verifier_state *entry_state, u32 max_header_count);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 8ee7d7b71147..5432c0fc442b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -792,6 +792,11 @@ void print_verifier_state(struct bpf_verifier_env *env, const struct bpf_verifie
 		verbose(env, " cb");
 	if (state->in_async_callback_fn)
 		verbose(env, " async_cb");
+	if (state->loop_stack_cnt) {
+		verbose(env, " loop_stack=");
+		for (i = 0; i < state->loop_stack_cnt; i++)
+			verbose(env, "%s%d", i ? "," : "", state->loop_stack[i].loop_id);
+	}
 	verbose(env, "\n");
 	if (!print_all)
 		mark_verifier_state_clean(env);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 2d2a84156180..05dd8e439609 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
+#include "linux/cnum.h"
 #include <linux/bpf_verifier.h>
 #include <linux/jhash.h>
 #include <linux/log2.h>
 #include <linux/min_heap.h>
 #include <linux/bug.h>
+#include <linux/tnum.h>
+#include <linux/overflow.h>
 
 #define REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
 #define UNKNOWN_EXPR_ID 0
@@ -80,6 +83,9 @@ struct expr_stack_elt {
 DEFINE_MIN_HEAP(int, scev_worklist);
 
 struct scev {
+	/* Read-only representatives for stack slots without a saved register. */
+	struct bpf_reg_state zero_reg;
+	struct bpf_reg_state unknown_reg;
 	/*
 	 * Expressions are identified by id, exprs_ht ensures that
 	 * each expression exists as a unique instance.
@@ -1616,6 +1622,8 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	if (!scev)
 		return -ENOMEM;
 	env->scev = scev;
+	bpf_mark_reg_known_scalar(&scev->zero_reg, 0);
+	bpf_mark_reg_unknown_imprecise(&scev->unknown_reg);
 	/* A power of two for hash & (exprs_ht_cnt - 1)` indexing. */
 	scev->exprs_ht_cnt = roundup_pow_of_two(max(256U, DIV_ROUND_UP(env->prog->len, 4)));
 	scev->exprs_ht = kvcalloc(scev->exprs_ht_cnt, sizeof(*scev->exprs_ht), GFP_KERNEL_ACCOUNT);
@@ -1638,3 +1646,1034 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	bpf_free_scev(env);
 	return -ENOMEM;
 }
+
+static struct bpf_stack_state *scev_regno_to_stack(const struct bpf_func_state *st, u32 r)
+{
+	int spi, slots_available;
+
+	if (r < MAX_BPF_REG)
+		return NULL;
+
+	slots_available = st->allocated_stack / BPF_REG_SIZE;
+	spi = r - MAX_BPF_REG;
+	if (spi < slots_available)
+		return &st->stack[spi];
+
+	return NULL;
+}
+
+static struct bpf_reg_state *scev_regno_to_reg(struct bpf_func_state *st, u32 r)
+{
+	return r < MAX_BPF_REG ? &st->regs[r] : NULL;
+}
+
+/* Linear widening requires a physical register or a full spill. */
+static struct bpf_reg_state *scev_reg_for_linear(struct bpf_func_state *st, u32 r)
+{
+	struct bpf_stack_state *stack;
+
+	if (r < MAX_BPF_REG)
+		return scev_regno_to_reg(st, r);
+	stack = scev_regno_to_stack(st, r);
+	if (!stack || bpf_spill_size(stack) != BPF_REG_SIZE)
+		return NULL;
+	return &stack->spilled_ptr;
+}
+
+/*
+ * Return a borrowed value; never use it as a widening destination.
+ * NULL denotes no readable value.
+ */
+static const struct bpf_reg_state *
+scev_reg_for_read(struct bpf_verifier_env *env, const struct bpf_func_state *st, u32 r)
+{
+	const struct bpf_stack_state *stack;
+	bool zero = true;
+	int i;
+
+	if (r < MAX_BPF_REG)
+		return st->regs[r].type == NOT_INIT ? NULL : &st->regs[r];
+	if (r >= REGS_NUM || r - MAX_BPF_REG >= env->stack_limit / BPF_REG_SIZE)
+		return NULL;
+
+	stack = scev_regno_to_stack(st, r);
+	if (!stack)
+		return &env->scev->unknown_reg;
+	if (bpf_spill_size(stack) == BPF_REG_SIZE)
+		return &stack->spilled_ptr;
+
+	/* Partial spills do not describe the value of the whole slot. */
+	for (i = 0; i < BPF_REG_SIZE; i++) {
+		switch (stack->slot_type[i]) {
+		case STACK_ZERO:
+			break;
+		case STACK_INVALID:
+		case STACK_POISON:
+		case STACK_MISC:
+			zero = false;
+			break;
+		case STACK_SPILL:
+			if (!bpf_is_spilled_scalar_reg(stack))
+				return NULL;
+			zero = false;
+			break;
+		default:
+			return NULL;
+		}
+	}
+	return zero ? &env->scev->zero_reg : &env->scev->unknown_reg;
+}
+
+/* Materialize a writable value in the current state, growing its stack if needed. */
+static int scev_reg_for_write(struct bpf_verifier_env *env, struct bpf_func_state *st,
+			      u32 r, struct bpf_reg_state **out)
+{
+	const struct bpf_reg_state *value;
+	struct bpf_stack_state *stack;
+	u32 spi;
+	int err;
+
+	*out = scev_regno_to_reg(st, r);
+	if (*out)
+		return 0;
+	if (r >= REGS_NUM || r - MAX_BPF_REG >= env->stack_limit / BPF_REG_SIZE)
+		return -EINVAL;
+
+	spi = r - MAX_BPF_REG;
+	err = bpf_grow_stack_state(env, st, (spi + 1) * BPF_REG_SIZE);
+	if (err)
+		return err;
+
+	/* Resolve pointers after growth, which may relocate the stack. */
+	value = scev_reg_for_read(env, st, r);
+	if (!value)
+		return -EINVAL;
+	stack = scev_regno_to_stack(st, r);
+	stack->spilled_ptr = *value;
+	memset(stack->slot_type, STACK_SPILL, sizeof(stack->slot_type));
+	*out = &stack->spilled_ptr;
+	return 0;
+}
+
+static bool scev_reg_alive(struct bpf_verifier_env *env, struct bpf_verifier_state *st, u32 r)
+{
+	int insn_idx = bpf_frame_insn_idx(st, st->curframe);
+	u16 live_regs = env->insn_aux_data[insn_idx].live_regs_before;
+	int spi;
+
+	if (r < MAX_BPF_REG) {
+		return BIT(r) & live_regs;
+	} else {
+		spi = r - MAX_BPF_REG;
+		return bpf_stack_slot_alive(env, st->curframe, spi * 2) ||
+		       bpf_stack_slot_alive(env, st->curframe, spi * 2 + 1);
+	}
+}
+
+/*
+ * Latch is a condition deciding if execution remains inside a loop.
+ * Linear latch represents a condition 'if <reg> <op> <loop invariant> goto <loop-header>',
+ * where equation '<base> + i * <step> <op> <bound>' describes values taken by register <reg>,
+ * 'i' is the loop iteration number, starting from 0.
+ */
+struct linear_latch {
+	u32 insn_idx;
+	u32 base_expr;
+	u32 step_expr;
+	u32 bound_expr;
+	u32 op;
+};
+
+static bool loop_invariant(struct scev *scev, u32 id)
+{
+	s64 imm;
+	u32 reg;
+
+	return is_reg(scev, id, &reg) || is_imm(scev, id, &imm);
+}
+
+static int match_linear_latch(struct bpf_verifier_env *env,
+			      u32 header,
+			      u32 latch_idx,
+			      struct linear_latch *latch)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[latch_idx];
+	struct scev *scev = env->scev;
+	struct env *latch_env;
+	u32 true_branch_loop;
+	u32 true_branch_tgt;
+	u32 src_reg_scev;
+	u32 dst_reg_scev;
+	u32 t, l, r, op;
+	int id;
+
+	/* 32-bit arithmetic is not handled yet */
+	if (BPF_CLASS(insn->code) != BPF_JMP)
+		return false;
+	op = BPF_OP(insn->code);
+	/* Flip the condition if true branch jumps out of the loop. */
+	true_branch_tgt = latch_idx + bpf_jmp_offset(insn) + 1;
+	true_branch_loop = bpf_loop_at_index(env, true_branch_tgt);
+	if (true_branch_loop != header &&
+	    !bpf_is_nested_loop(env, true_branch_loop, header))
+		op = bpf_rev_opcode(op);
+	switch (op) {
+	case BPF_JSLT:
+	case BPF_JSLE:
+	case BPF_JSGT:
+	case BPF_JSGE:
+	case BPF_JLT:
+	case BPF_JLE:
+	case BPF_JGT:
+	case BPF_JGE:
+	case BPF_JNE:
+		break;
+	default:
+		return false;
+	}
+
+	latch->insn_idx = latch_idx;
+
+	latch_env = find_loop_env(scev, header, latch_idx);
+	if (verifier_bug_if(!latch_env, env, "header_idx=%d, latch_idx=%d\n", header, latch_idx))
+		return -EFAULT;
+	dst_reg_scev = latch_env->reg2scev[insn->dst_reg];
+	src_reg_scev = latch_env->reg2scev[insn->src_reg];
+	/*
+	 * Make sure (linear ...) is in dst_reg_scev:
+	 *   'if <invariant> <op> <linear>' ⇔
+	 * 'if <linear> <flip(op)> <invariant>'.
+	 */
+	if (BPF_SRC(insn->code) == BPF_X && is_linear(scev, src_reg_scev, &l, &r)) {
+		swap(dst_reg_scev, src_reg_scev);
+		op = bpf_flip_opcode(op);
+	}
+	latch->op = op;
+	/*
+	 * simplify() produces two shapes for linear latches:
+	 * - (linear register step)
+	 *           ^----------------------------+-- base_expr
+	 *           base_expr                    |
+	 * - (linear (+ register imm) step)       |
+	 *           ^----------------------------'
+	 */
+	if (!is_linear(scev, dst_reg_scev, &latch->base_expr, &latch->step_expr))
+		return false;
+
+	if (BPF_SRC(insn->code) == BPF_K) {
+		id = imm_expr(scev, insn->imm);
+		if (id < 0)
+			return id;
+		latch->bound_expr = id;
+	} else {
+		latch->bound_expr = src_reg_scev;
+	}
+
+	if (!loop_invariant(scev, latch->step_expr) ||
+	    !loop_invariant(scev, latch->bound_expr))
+		return false;
+
+	/* (linear register step) */
+	if (is_reg(scev, latch->base_expr, &t))
+		return true;
+
+	/* (linear (+ register imm) step) */
+	if (is_add(scev, latch->base_expr, &l, &r) &&
+	    is_reg(scev, l, &t) &&
+	    loop_invariant(scev, r))
+		return true;
+
+	return false;
+}
+
+struct scev_value {
+	u64 value;	/* scalar value or a pointer offset */
+	int ptr_reg;	/* SCEV register identifying the pointer origin, or -1. */
+};
+
+static void log_scev_value(struct bpf_verifier_env *env, struct bpf_func_state *st,
+			   const struct scev_value *v)
+{
+	const struct bpf_reg_state *reg;
+
+	if (v->ptr_reg >= 0) {
+		reg = scev_reg_for_read(env, st, v->ptr_reg);
+		log_reg(env, v->ptr_reg);
+		bpf_log(&env->log, " (%s)", reg ? reg_type_str(env, reg->type) : "unavailable");
+	} else {
+		bpf_log(&env->log, "scalar %llu", v->value);
+	}
+}
+
+static void log_incompatible_scev_values(struct bpf_verifier_env *env, const char *reason,
+					struct bpf_func_state *st,
+					const struct scev_value *a, const struct scev_value *b)
+{
+	bpf_log(&env->log, "scev: %s ", reason);
+	log_scev_value(env, st, a);
+	bpf_log(&env->log, ", ");
+	log_scev_value(env, st, b);
+	bpf_log(&env->log, "\n");
+}
+
+static bool scev_value_compatible(struct bpf_verifier_env *env, struct bpf_func_state *st,
+				  const struct scev_value *a, const struct scev_value *b)
+{
+	const struct bpf_reg_state *ra, *rb;
+
+	if (a->ptr_reg < 0 || b->ptr_reg < 0) {
+		if (a->ptr_reg < 0 && b->ptr_reg < 0)
+			return true;
+		goto incompatible;
+	}
+	ra = scev_reg_for_read(env, st, a->ptr_reg);
+	rb = scev_reg_for_read(env, st, b->ptr_reg);
+	if (ra && rb && bpf_same_memory_origin(ra, rb))
+		return true;
+
+incompatible:
+	if (env->log.level & BPF_LOG_LEVEL2)
+		log_incompatible_scev_values(env, "incompatible latch operands", st, a, b);
+	return false;
+}
+
+static bool scev_value_add(struct bpf_verifier_env *env, struct bpf_func_state *st,
+			   const struct scev_value *a, const struct scev_value *b,
+			   struct scev_value *result)
+{
+	if (a->ptr_reg >= 0 && b->ptr_reg >= 0) {
+		if (env->log.level & BPF_LOG_LEVEL2)
+			log_incompatible_scev_values(env, "can't add two pointers", st, a, b);
+		return false;
+	}
+	result->value = a->value + b->value;
+	result->ptr_reg = a->ptr_reg >= 0 ? a->ptr_reg : b->ptr_reg;
+	return true;
+}
+
+static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev,
+		      struct bpf_func_state *st, u32 id, struct scev_value *result)
+{
+	struct scev_value lval, rval;
+	const struct bpf_reg_state *reg;
+	u32 l, r, regno;
+	s64 imm;
+
+	if (is_reg(scev, id, &regno)) {
+		reg = scev_reg_for_read(env, st, regno);
+		if (!reg || reg->type == NOT_INIT || !tnum_is_const(reg->var_off))
+			return false;
+		result->value = reg->var_off.value;
+		result->ptr_reg = reg->type == SCALAR_VALUE ? -1 : (int)regno;
+		return true;
+	} else if (is_imm(scev, id, &imm)) {
+		result->value = imm;
+		result->ptr_reg = -1;
+		return true;
+	} else if (is_add(scev, id, &l, &r) &&
+		   eval_expr(env, scev, st, l, &lval) &&
+		   eval_expr(env, scev, st, r, &rval)) {
+		return scev_value_add(env, st, &lval, &rval, result);
+	}
+	return false;
+}
+
+/*
+ * Loop with post-condition:
+ *
+ *    r0 = 0
+ * l: ...                r0 ∈ [0,1,2] header executed 3 times
+ *    r0 += 1            r0 ∈ [0,1,2]
+ *    ...                r0 ∈ [1,2,3]
+ *    if r0 != 3 goto l  r0 ∈ [1,2,3] backedge taken 2 times
+ *    ...                r0 ∈ [3]
+ *
+ * SCEV at header: r0 = k
+ * SCEV at latch:  r0 = 1 + k
+ *
+ * Loop with pre-condition:
+ *
+ *    r0 = 0
+ * l: ...                r0 ∈ [0,1,2,3] header executed 4 times
+ *    if r0 == 3 goto e  r0 ∈ [0,1,2,3] backedge taken 3 times
+ *    r0 += 1            r0 ∈ [0,1,2]
+ *    ...                r0 ∈ [1,2,3]
+ *    goto l             r0 ∈ [1,2,3]
+ * e: ...                r0 ∈ [3]
+ *
+ * SCEV at header: r0 = k
+ * SCEV at latch:  r0 = k
+ */
+static bool compute_max_iters(struct bpf_verifier_env *env,
+			      struct bpf_func_state *st,
+			      struct linear_latch *latch,
+			      struct bpf_loop_iters *iters)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_loop *loop = aux[bpf_loop_at_index(env, latch->insn_idx)].loop;
+	struct scev *scev = env->scev;
+	struct scev_value initial_val, step_val, bound_val;
+	u64 step, diff, bound, initial, backedge_taken_count;
+	u8 op = latch->op;
+	bool up, down;
+
+	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
+	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
+	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
+		return false;
+
+	if (step_val.ptr_reg >= 0) {
+		if (env->log.level & BPF_LOG_LEVEL2) {
+			bpf_log(&env->log, "scev: latch step is a pointer ");
+			log_scev_value(env, st, &step_val);
+			bpf_log(&env->log, "\n");
+		}
+		return false;
+	}
+	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
+		return false;
+
+	initial = initial_val.value;
+	step = step_val.value;
+	bound = bound_val.value;
+
+	if (step == 0)
+		return false;
+	down = (s64)step < 0;
+	up = (s64)step > 0;
+	diff = bound - initial;
+	switch (op) {
+	case BPF_JLT:
+		/*
+		 * E.g.: 3 + 2*i < 7 ⇔ 2*i < 4 ⇔ i ∈ [0,1].
+		 * Here the inequality describes a set of values `i` might take
+		 * while the latch condition remains true (the backedge is taken).
+		 * The backedge_taken_count is the size of this set.
+		 */
+		if (/*
+		     * If the condition is initially true, decreasing values won't
+		     * change that without underflow. If the condition is initially false,
+		     * the main pass would do a single iteration anyway.
+		     */
+		    down ||
+		    /* Is the latch condition false on the first iteration? */
+		    initial >= bound ||
+		    /* Count iterations satisfying the strict inequality, including i=0. */
+		    check_add_overflow((diff - 1) / step, 1, &backedge_taken_count) ||
+		    /*
+		     * Check if the last iteration overflows the counter:
+		     *   initial + backedge_taken_count * step > U64_MAX
+		     */
+		    backedge_taken_count > (U64_MAX - initial) / step)
+			return false;
+		break;
+	case BPF_JLE:
+		/* E.g.: 3 + 2*i ≤ 7 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
+		if (down || initial > bound ||
+		    /* Count iterations satisfying the non-strict inequality. */
+		    check_add_overflow(diff / step, 1, &backedge_taken_count) ||
+		    backedge_taken_count > (U64_MAX - initial) / step)
+			return false;
+		break;
+	case BPF_JGT:
+		/* E.g.: 7 - 2*i > 3 ⇔ 2*i < 4 ⇔ i ∈ [0,1]. */
+		if (up || initial <= bound ||
+		    check_add_overflow((-diff - 1) / -step, 1, &backedge_taken_count) ||
+		    /*
+		     * The last iteration underflows the counter if:
+		     *   initial + backedge_taken_count * step < 0 ⇔
+		     *             backedge_taken_count * step < -initial ⇔
+		     *                    backedge_taken_count > initial / -step
+		     * (direction flips because step < 0)
+		     */
+		    backedge_taken_count > initial / -step)
+			return false;
+		break;
+	case BPF_JGE:
+		/* E.g.: 7 - 2*i ≥ 3 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
+		if (up || initial < bound ||
+		    check_add_overflow(-diff / -step, 1, &backedge_taken_count) ||
+		    backedge_taken_count > initial / -step)
+			return false;
+		break;
+	case BPF_JSLT:
+		if (down || (s64)initial >= (s64)bound ||
+		    check_add_overflow((diff - 1) / step, 1, &backedge_taken_count) ||
+		    /*
+		     * Check if the last iteration overflows the signed counter:
+		     *   (s64)initial + backedge_taken_count * step > S64_MAX
+		     */
+		    backedge_taken_count > ((u64)S64_MAX - initial) / step)
+			return false;
+		break;
+	case BPF_JSLE:
+		if (down || (s64)initial > (s64)bound ||
+		    check_add_overflow(diff / step, 1, &backedge_taken_count) ||
+		    backedge_taken_count > ((u64)S64_MAX - initial) / step)
+			return false;
+		break;
+	case BPF_JSGT:
+		if (up || (s64)initial <= (s64)bound ||
+		    check_add_overflow((-diff - 1) / -step, 1, &backedge_taken_count) ||
+		    /*
+		     * The last iteration underflows the signed counter if:
+		     *   (s64)initial + backedge_taken_count * step < S64_MIN ⇔
+		     *                  backedge_taken_count * step < S64_MIN - (s64)initial ⇔
+		     *                         backedge_taken_count > initial - (u64)S64_MIN / -step
+		     *	 (direction flips because step < 0)
+		     */
+		    backedge_taken_count > (initial - (u64)S64_MIN) / -step)
+			return false;
+		break;
+	case BPF_JSGE:
+		if (up || (s64)initial < (s64)bound ||
+		    check_add_overflow(-diff / -step, 1, &backedge_taken_count) ||
+		    backedge_taken_count > (initial - (u64)S64_MIN) / -step)
+			return false;
+		break;
+	case BPF_JNE:
+		/*
+		 * For a decreasing counter flip the diff and step:
+		 *   7 - 2*i ≠ 3 ⇔ 2*i ≠ 7 - 3.
+		 */
+		diff = down ? -diff : diff;
+		step = down ? -step : step;
+		if (diff == 0 || diff % step)
+			return false;
+		backedge_taken_count = diff / step;
+		break;
+	default:
+		return false;
+	}
+
+	/*
+	 * max_header_count is u32 and U32_MAX means "infinite",
+	 * check to avoid overflow below.
+	 */
+	if (backedge_taken_count >= U32_MAX - 1)
+		return false;
+
+	/* The header executes once on entry and once for each taken backedge, hence +1. */
+	iters->max_header_count = backedge_taken_count + 1;
+	/*
+	 * The latch is a conditional jump with one jump target exiting the loop.
+	 * Linear latch is matched only if the loop has a single backedge.
+	 * The loop still, however can have multiple exits.
+	 * In such case, conservatively assume that non-latch exit can happen
+	 * at any iteration, thus setting minimal number of iterations as 0.
+	 */
+	iters->min_header_count = loop->exits_cnt == 1 ? iters->max_header_count : 0;
+	return true;
+}
+
+static void mark_scev_reg_scratched(struct bpf_verifier_env *env, u32 r)
+{
+	if (r < MAX_BPF_REG)
+		mark_reg_scratched(env, r);
+	else
+		mark_stack_slot_scratched(env, r - __MAX_BPF_REG);
+}
+
+/*
+ * An unknown scalar is its own widening.
+ * Stack bytes without a value are represented by scev->unknown_reg.
+ */
+static bool is_unbound_scev_reg(struct bpf_verifier_env *env, const struct bpf_func_state *st,
+				u32 r)
+{
+	const struct bpf_reg_state *reg = scev_reg_for_read(env, st, r);
+
+	return reg && reg->type == SCALAR_VALUE && !reg->id && reg->step <= 1 &&
+	       tnum_is_unknown(reg->var_off) &&
+	       reg->r64.size == U64_MAX && reg->r32.size == U32_MAX;
+}
+
+/* Main logic in verifier.c forbids varying offsets for certain register types. */
+static bool is_widenable_reg_type(const struct bpf_reg_state *reg)
+{
+	if (type_may_be_null(reg->type))
+		return false;
+
+	switch (base_type(reg->type)) {
+	case SCALAR_VALUE:
+	case PTR_TO_MAP_VALUE:
+	case PTR_TO_MAP_KEY:
+	case PTR_TO_STACK:
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+	case PTR_TO_MEM:
+	case PTR_TO_BUF:
+	case PTR_TO_BTF_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static void scratch_widened_reg_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
+{
+	switch (base_type(reg->type)) {
+	case SCALAR_VALUE:
+		reg->id = 0;
+		break;
+	case PTR_TO_PACKET:
+	case PTR_TO_PACKET_META:
+		reg->id = ++env->id_gen;
+		break;
+	default:
+		break;
+	}
+}
+
+/* Check that ANY leaves can be unioned with r's loop-entry value. */
+static bool is_widenable_any(struct bpf_verifier_env *env, struct bpf_func_state *loop_entry,
+			     struct env *header_env, u32 r, u32 id)
+{
+	const struct bpf_reg_state *reg, *leaf_reg;
+	struct scev *scev = env->scev;
+	u32 l, ra, rr, leaf, order;
+	s64 imm;
+
+	if (!is_any(scev, id, &l, &rr))
+		return false;
+	reg = scev_reg_for_read(env, loop_entry, r);
+	if (!reg || !is_widenable_reg_type(reg))
+		return false;
+
+	scev->stack_sz = 0;
+	expr_stack_push(scev, id);
+	while (expr_next(scev, &id, &order)) {
+		if (order & DEPTH_LIMIT)
+			return false;
+		if (!(order & PRE) || is_any(scev, id, &l, &rr))
+			continue;
+		if (is_imm(scev, id, &imm)) {
+			if (reg->type != SCALAR_VALUE)
+				return false;
+		} else if (is_reg(scev, id, &leaf)) {
+			/* Other leaves must denote loop-invariant registers. */
+			if (leaf != r &&
+			    !(is_reg(scev, header_env->reg2scev[leaf], &ra) && ra == leaf))
+				return false;
+			leaf_reg = scev_reg_for_read(env, loop_entry, leaf);
+			if (!leaf_reg || !bpf_reg_union_compatible(reg, leaf_reg))
+				return false;
+		} else {
+			return false;
+		}
+	}
+	return true;
+}
+
+struct bounds {
+	struct cnum64 range;
+	u16 base;
+	u16 step;
+};
+
+static bool is_simple_linear(struct scev *scev, u32 id, u32 *base_reg, s64 *slope_imm)
+{
+	u32 base, slope;
+
+	return is_linear(scev, id, &base, &slope) &&
+	       is_reg(scev, base, base_reg) &&
+	       is_imm(scev, slope, slope_imm) &&
+	       *slope_imm <= S16_MAX &&
+	       *slope_imm >= S16_MIN &&
+	       *slope_imm != 0;
+}
+
+/*
+ * Compute the range an induction variable in `reg` spans over the loop.
+ * If the computation overflows s64 the range is unbounded, only the
+ * power-of-two alignment survives the wraparound.
+ */
+static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count, s64 slope,
+			  struct bounds *out)
+{
+	s64 slope_abs = slope < 0 ? -slope : slope;
+	s64 min_val = reg_smin(reg);
+	s64 max_val = reg_smax(reg);
+	s64 total_change;
+	bool overflow;
+
+	overflow = check_mul_overflow(slope, (s64)max_header_count - 1, &total_change) ||
+		   (slope > 0 && check_add_overflow(max_val, total_change, &max_val)) ||
+		   (slope < 0 && check_add_overflow(min_val, total_change, &min_val));
+	/*
+	 * If the entry value is a single point the value set is 'v + slope * k',
+	 * so the step is |slope|. Otherwise, only the power-of-two alignment
+	 * shared by the entry value and the slope.
+	 */
+	if (cnum64_is_const(reg->r64) && !overflow) {
+		out->step = slope_abs;
+		out->base = imod(min_val, out->step);
+	} else {
+		out->step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
+		out->base = 0;
+	}
+	out->range = overflow ? CNUM64_UNBOUNDED : cnum64_from_srange(min_val, max_val);
+}
+
+static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 id,
+			     unsigned long *precise_regs)
+{
+	struct scev *scev = env->scev;
+	struct bpf_reg_state *reg;
+	u32 r, order;
+
+	scev->stack_sz = 0;
+	expr_stack_push(scev, id);
+	while (expr_next(scev, &id, &order)) {
+		if (order & DEPTH_LIMIT) {
+			verifier_bug(env, "scev precision marking exceeds expression depth limit");
+			return -EFAULT;
+		}
+		if (!(order & PRE) || !is_reg(scev, id, &r))
+			continue;
+		/* Synthetic values have no spilled register to mark precise. */
+		reg = scev_reg_for_linear(st, r);
+		if (reg && reg->type == SCALAR_VALUE)
+			__set_bit(r, precise_regs);
+	}
+	return 0;
+}
+
+int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			   struct bpf_loop_iters *iters)
+{
+	struct bpf_func_state *cur_func = st->frame[st->curframe];
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_verifier_log *log = &env->log;
+	struct scev *scev = env->scev;
+	struct env *header_env;
+	struct linear_latch latch, best;
+	struct bpf_backedge *backedge;
+	struct bpf_loop_iters tmp;
+	struct bpf_loop *loop;
+	int insn_idx = st->insn_idx;
+	bool found = false;
+	int linear_latch;
+	u32 r, base_reg;
+	int latch_idx;
+	s64 slope_imm;
+	int err, j;
+
+	if (!env->allow_uninit_stack)
+		return 0;
+
+	/*
+	 * If insn_idx is a loop header for a reducible loop with a single backedge.
+	 * loop is NULL for secondary entries to irreducible loops.
+	 */
+	loop = aux[insn_idx].loop;
+	if (!loop || loop->irreducible || loop->backedges_cnt != 1 || loop->backedges_overflow ||
+	    loop->exits_overflow) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, unsupported loop:%s%s%s\n", insn_idx,
+				!loop || loop->irreducible ? " irreducible" : "",
+				loop && loop->backedges_cnt > 1 ? " multiple backedges" : "",
+				loop && loop->exits_overflow ? " too many exits" : "");
+		return 0;
+	}
+
+	/* If this backedge has a latch */
+	backedge = &loop->backedges[0];
+	if (!backedge->latches_cnt) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, latch not identified\n", insn_idx);
+		return 0;
+	}
+
+	/*
+	 * Every condition dominating the backedge bounds the number of
+	 * iterations from above, keep the smallest bound.
+	 */
+	for (j = 0; j < backedge->latches_cnt; j++) {
+		latch_idx = backedge->latches[j];
+		linear_latch = match_linear_latch(env, insn_idx, latch_idx, &latch);
+		if (linear_latch < 0)
+			return linear_latch;
+		if (!linear_latch) {
+			if (log->level & BPF_LOG_LEVEL2)
+				bpf_log(log, "loop header at %d, non-linear %s at %d\n",
+					insn_idx, j ? "exit" : "latch", latch_idx);
+			continue;
+		}
+		if (!compute_max_iters(env, cur_func, &latch, &tmp)) {
+			if (log->level & BPF_LOG_LEVEL2)
+				bpf_log(log,
+					"loop header at %d, can't compute iterations count at %d\n",
+					insn_idx, latch_idx);
+			continue;
+		}
+		if (!found || tmp.max_header_count < iters->max_header_count) {
+			iters->max_header_count = tmp.max_header_count;
+			best = latch;
+		}
+		iters->min_header_count = found ? min(iters->min_header_count, tmp.min_header_count)
+						: tmp.min_header_count;
+		found = true;
+	}
+	if (!found) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, can't compute iterations count\n", insn_idx);
+		return 0;
+	}
+	latch = best;
+
+	if (iters->max_header_count == 0) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, 0 iterations count\n", insn_idx);
+		return 0;
+	}
+
+	if (iters->max_header_count == U32_MAX) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, inf iterations count\n", insn_idx);
+		return 0;
+	}
+
+	if (log->level & BPF_LOG_LEVEL2) {
+		bpf_log(log, "loop header at %d, header_count is ", insn_idx);
+		if (iters->min_header_count == iters->max_header_count)
+			bpf_log(log, "%u ", iters->max_header_count);
+		else
+			bpf_log(log, "[%u..%u] ", iters->min_header_count, iters->max_header_count);
+		bpf_log(log, "\n");
+	}
+
+	err = bpf_live_stack_query_init(env, st);
+	if (err)
+		return err;
+
+	header_env = find_header_env(scev, insn_idx);
+	for (r = 0; r < REGS_NUM; r++) {
+		struct bpf_reg_state *reg;
+		u32 ra, r_scev, r_expr;
+
+		if (!scev_reg_alive(env, st, r))
+			continue;
+		/*
+		 * A heuristic:
+		 * Ignore SCEVs computed for unbound values and treat those as widened.
+		 * This is poor man's modelling of e.g. bpf_probe_read_kernel() effect
+		 * on stack, when called from a subprogram. Currently this would produce
+		 * an unknown ('?') SCEV as a summary of a subprogram call effects.
+		 * Ideally, this should be computed as an OPAQUE value.
+		 * However, that would require tracking STACK_MISC writes in the
+		 * liveness analysis. Not implemented yet.
+		 */
+		if (is_unbound_scev_reg(env, cur_func, r))
+			continue;
+
+		r_scev = header_env->reg2scev[r];
+		reg = scev_reg_for_linear(cur_func, r);
+		/* If SCEV for r is (linear <reg> <slope>) */
+		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
+		    reg && is_widenable_reg_type(reg)) {
+			continue;
+		}
+
+		/* rA = rA, loop does not change this reg */
+		if (is_reg(scev, r_scev, &ra) && r == ra)
+			continue;
+
+		/* (any 1 (any 2 (any 3 4))) */
+		if (is_widenable_any(env, cur_func, header_env, r, r_scev)) {
+			continue;
+		}
+
+		if (log->level & BPF_LOG_LEVEL2) {
+			r_expr = header_env->reg2expr[r];
+			bpf_log(log, "loop header at %d, can't widen ", insn_idx);
+			log_reg(env, r);
+			bpf_log(log, ", expr is ");
+			log_expr(env, r_expr);
+			bpf_log(log, "\n");
+		}
+		return 0;
+	}
+
+	bitmap_zero(iters->precise_regs, REGS_NUM);
+	err = mark_expr_precise(env, cur_func, latch.base_expr, iters->precise_regs);
+	if (err)
+		return err;
+	err = mark_expr_precise(env, cur_func, latch.step_expr, iters->precise_regs);
+	if (err)
+		return err;
+	err = mark_expr_precise(env, cur_func, latch.bound_expr, iters->precise_regs);
+	if (err)
+		return err;
+
+	return 1;
+}
+
+/* bpf_compute_loop_iters() checked that every leaf can be unioned into acc. */
+static int union_any_reg(struct bpf_verifier_env *env, struct bpf_func_state *loop_entry,
+			 struct bpf_reg_state *acc, u32 id)
+{
+	struct bpf_reg_state *tmp = &env->fake_reg[0];
+	const struct bpf_reg_state *leaf_reg;
+	struct scev *scev = env->scev;
+	u32 l, r, leaf, order;
+	s64 imm;
+	int err;
+
+	scev->stack_sz = 0;
+	expr_stack_push(scev, id);
+	while (expr_next(scev, &id, &order)) {
+		if (order & DEPTH_LIMIT) {
+			verifier_bug(env, "scev ANY union exceeds expression depth limit");
+			return -EFAULT;
+		}
+		if (!(order & PRE) || is_any(scev, id, &l, &r))
+			continue;
+		if (is_imm(scev, id, &imm)) {
+			bpf_mark_reg_known_scalar(tmp, imm);
+			leaf_reg = tmp;
+		} else if (is_reg(scev, id, &leaf)) {
+			leaf_reg = scev_reg_for_read(env, loop_entry, leaf);
+			if (verifier_bug_if(!leaf_reg, env, "unreadable SCEV ANY leaf %u", leaf))
+				return -EFAULT;
+		} else {
+			verifier_bug(env, "scev ANY union has an unsupported leaf");
+			return -EFAULT;
+		}
+		err = bpf_reg_union(env, acc, leaf_reg);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters)
+{
+	struct bpf_func_state *cur_func = st->frame[st->curframe];
+	struct bpf_func_state *entry_func = loop_entry->frame[loop_entry->curframe];
+	struct bpf_verifier_log *log = &env->log;
+	struct scev *scev = env->scev;
+	struct bpf_reg_state *reg;
+	struct env *header_env;
+	struct bounds bounds;
+	u32 r, base_reg, r_expr, a, b;
+	int insn_idx = st->insn_idx;
+	s64 slope_imm;
+	int err;
+
+	for_each_set_bit(r, iters->precise_regs, REGS_NUM) {
+		if (r < MAX_BPF_REG)
+			bpf_bt_set_frame_reg(&env->bt, st->curframe, r);
+		else
+			bpf_bt_set_frame_slot(&env->bt, st->curframe, r - MAX_BPF_REG);
+	}
+	err = bpf_mark_chain_precision(env, st, -1, NULL);
+	if (err)
+		return err;
+
+	header_env = find_header_env(scev, insn_idx);
+	for (r = 0; r < REGS_NUM; r++) {
+		if (!scev_reg_alive(env, st, r) || is_unbound_scev_reg(env, cur_func, r))
+			continue;
+
+		r_expr = header_env->reg2scev[r];
+		/* If SCEV for r is (linear <reg> <slope>)*/
+		if (is_simple_linear(scev, r_expr, &base_reg, &slope_imm) &&
+		    base_reg == r) {
+			err = scev_reg_for_write(env, cur_func, r, &reg);
+			if (err)
+				return err;
+			linear_bounds(reg, iters->max_header_count, slope_imm, &bounds);
+			if (log->level & BPF_LOG_LEVEL2) {
+				bpf_log(log, "loop header at %d, widening ", insn_idx);
+				log_reg(env, r);
+				bpf_log(log, " to ");
+				bpf_verbose_snum(env, cnum64_smin(bounds.range));
+				bpf_log(log, "..");
+				bpf_verbose_snum(env, cnum64_smax(bounds.range));
+				bpf_log(log, " step %u\n", bounds.step);
+			}
+			scratch_widened_reg_id(env, reg);
+			err = bpf_set_reg_range(env, reg, bounds.range, bounds.base, bounds.step);
+			if (err)
+				return err;
+			mark_scev_reg_scratched(env, r);
+		} else if (is_any(scev, r_expr, &a, &b)) {
+			err = scev_reg_for_write(env, cur_func, r, &reg);
+			if (err)
+				return err;
+			err = union_any_reg(env, entry_func, reg, r_expr);
+			if (err)
+				return err;
+			if (log->level & BPF_LOG_LEVEL2) {
+				bpf_log(log, "loop header at %d, widening ", insn_idx);
+				log_reg(env, r);
+				bpf_log(log, " to ");
+				bpf_verbose_snum(env, reg_smin(reg));
+				bpf_log(log, "..");
+				bpf_verbose_snum(env, reg_smax(reg));
+				bpf_log(log, " step %u\n", reg->step);
+			}
+			scratch_widened_reg_id(env, reg);
+			mark_scev_reg_scratched(env, r);
+		}
+	}
+	return 1;
+}
+
+int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur_func_state, u32 insn_idx,
+			struct bpf_verifier_state *entry_state, u32 max_header_count)
+{
+	struct bpf_func_state *entry_st = entry_state->frame[entry_state->curframe];
+	struct bpf_verifier_log *log = &env->log;
+	struct bpf_reg_state *reg, *entry_reg;
+	struct scev *scev = env->scev;
+	struct env *header_env;
+	struct bounds bounds;
+	u32 r, base_reg;
+	s64 slope_imm;
+	int err;
+
+	if (entry_state->curframe != cur_func_state->frameno) {
+		verifier_bug(env, "clamping registers for a wrong frame: %d vs %d\n",
+			     entry_state->curframe, cur_func_state->frameno);
+		return -EFAULT;
+	}
+
+	header_env = find_header_env(scev, insn_idx);
+	for (r = 0; r < REGS_NUM; r++) {
+		/* If SCEV for r is (linear <reg> <slope>)*/
+		if (!is_simple_linear(scev, header_env->reg2scev[r], &base_reg, &slope_imm) ||
+		    base_reg != r)
+			continue;
+
+		entry_reg = scev_reg_for_linear(entry_st, r);
+		reg = scev_reg_for_linear(cur_func_state, r);
+		if (!entry_reg || !reg || entry_reg->type == NOT_INIT || reg->type == NOT_INIT ||
+		    is_unbound_scev_reg(env, entry_st, r))
+			continue;
+
+		linear_bounds(entry_reg, max_header_count, slope_imm, &bounds);
+		bounds.range = cnum64_intersect(reg->r64, bounds.range);
+		if (cnum64_is_empty(bounds.range)) {
+			verifier_bug(env, "scev clamp produced empty range for r%d", r);
+			return -EFAULT;
+		}
+		if (log->level & BPF_LOG_LEVEL2) {
+			bpf_log(log, "loop header at %d, clamping ", insn_idx);
+			log_reg(env, r);
+			bpf_log(log, " to ");
+			bpf_verbose_snum(env, cnum64_smin(bounds.range));
+			bpf_log(log, "..");
+			bpf_verbose_snum(env, cnum64_smax(bounds.range));
+			bpf_log(log, " step %u\n", bounds.step);
+		}
+		scratch_widened_reg_id(env, reg);
+		err = bpf_set_reg_range(env, reg, bounds.range, bounds.base, bounds.step);
+		if (err)
+			return err;
+		mark_scev_reg_scratched(env, r);
+	}
+	return 0;
+}
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 470bff8d8dc8..c62ea992967b 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -936,6 +936,27 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 	return true;
 }
 
+static bool loop_stack_safe(struct bpf_verifier_env *env, struct bpf_func_state *old,
+			    struct bpf_func_state *cur)
+{
+	struct loop_stack_entry *old_stack = old->loop_stack;
+	struct loop_stack_entry *cur_stack = cur->loop_stack;
+	u32 i;
+
+	if (old->loop_stack_cnt != cur->loop_stack_cnt)
+		return false;
+
+	for (i = 0; i < old->loop_stack_cnt; i++) {
+		if (old_stack[i].loop_id == cur_stack[i].loop_id &&
+		    old_stack[i].max_header_count == cur_stack[i].max_header_count &&
+		    old_stack[i].terminates == cur_stack[i].terminates)
+			continue;
+		return false;
+	}
+
+	return true;
+}
+
 /* compare two verifier states
  *
  * all states stored in state_list are known to be valid, since
@@ -986,6 +1007,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
 		return false;
 
+	if (!loop_stack_safe(env, old, cur))
+		return false;
+
 	return true;
 }
 
@@ -1032,6 +1056,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
 			return false;
 	}
+
 	return true;
 }
 
@@ -1314,15 +1339,40 @@ int bpf_split_cur_state(struct bpf_verifier_env *env)
 	return 0;
 }
 
+/* Force a checkpoint upon reaching a loop header for a terminating loop. */
+static bool need_loop_checkpoint(struct bpf_verifier_env *env, int insn_idx)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	struct bpf_func_state *frame = cur->frame[cur->curframe];
+	struct loop_stack_entry *top;
+
+	if (bpf_loop_at_index(env, insn_idx) != insn_idx || !frame->loop_stack_cnt)
+		return false;
+	top = &frame->loop_stack[frame->loop_stack_cnt - 1];
+	return top->loop_id == insn_idx && top->terminates;
+}
+
+static struct loop_stack_entry *current_loop(struct bpf_verifier_state *st)
+{
+	struct bpf_func_state *frame = st->frame[st->curframe];
+
+	if (frame->loop_stack_cnt == 0)
+		return NULL;
+	return &frame->loop_stack[frame->loop_stack_cnt - 1];
+}
+
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
+	struct loop_stack_entry *old_loop, *cur_loop;
 	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *cur = env->cur_state;
-	bool force_new_state, add_new_state, loop;
+	bool force_new_state, add_new_state, loop, loop_checkpoint;
 	int n, err, states_cnt = 0;
 	struct list_head *pos, *tmp, *head;
 
+	loop_checkpoint = need_loop_checkpoint(env, insn_idx);
 	force_new_state = env->test_state_freq || bpf_is_force_checkpoint(env, insn_idx) ||
+			  loop_checkpoint ||
 			  /* Avoid accumulating infinitely long jmp history */
 			  cur->jmp_history_cnt > 40;
 
@@ -1353,10 +1403,10 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			continue;
 
 		if (sl->state.branches) {
-			struct bpf_func_state *frame = sl->state.frame[0];
+			struct bpf_func_state *old_top_frame = sl->state.frame[0];
 
-			if (frame->in_async_callback_fn &&
-			    frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {
+			if (old_top_frame->in_async_callback_fn &&
+			    old_top_frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {
 				/* Different async_entry_cnt means that the verifier is
 				 * processing another entry into async callback.
 				 * Seeing the same state is not an indication of infinite
@@ -1455,6 +1505,33 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 				goto skip_inf_loop_check;
 			}
+			/*
+			 * If old state belongs to a control flow loop that we know terminates,
+			 * it should be safe to prune current state. However, account for the
+			 * following situation:
+			 *
+			 *   for (;;) {
+			 *     for (i = 0; i < 10; i++)
+			 *       ...
+			 *   }
+			 *
+			 * Here a backedge to a non-terminating outer loop is dominated by an exit
+			 * from the inner loop. Pruning at a re-entry to the inner loop therefore
+			 * would hide the fact that outer loop is non-terminating.
+			 * Hence, only allow pruning states within the same entry state.
+			 */
+			old_loop = current_loop(&sl->state);
+			cur_loop = current_loop(cur);
+			if (old_loop && cur_loop &&
+			    old_loop->terminates && cur_loop->terminates &&
+			    old_loop->entry_state == cur_loop->entry_state) {
+				if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
+					loop = true;
+					goto hit;
+				}
+				goto skip_inf_loop_check;
+			}
+
 			/* attempt to detect infinite loop to avoid unnecessary doomed work */
 			if (states_maybe_looping(&sl->state, cur) &&
 			    states_equal(env, &sl->state, cur, EXACT) &&
@@ -1613,7 +1690,8 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 		 * Use bigger 'n' for checkpoints because evicting checkpoint states
 		 * too early would hinder iterator convergence.
 		 */
-		n = bpf_is_force_checkpoint(env, insn_idx) && sl->state.branches > 0 ? 64 : 3;
+		n = (bpf_is_force_checkpoint(env, insn_idx) || loop_checkpoint) &&
+		    sl->state.branches > 0 ? 64 : 3;
 		if (sl->miss_cnt > sl->hit_cnt * n + n) {
 			/* the state is unlikely to be useful. Remove it to
 			 * speed up verification
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 60287049cfe4..a597a8c18972 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1681,6 +1681,7 @@ static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
 		return;
+	kfree(state->loop_stack);
 	kfree(state->stack_arg_regs);
 	kfree(state->stack);
 	kfree(state);
@@ -1717,6 +1718,10 @@ static int copy_func_state(struct bpf_func_state *dst,
 	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
 	/* Instruction accounting is path-local, not part of verifier state. */
 	dst->insns_subtotal = 0;
+	dst->loop_stack = copy_array(dst->loop_stack, src->loop_stack, src->loop_stack_cnt,
+				     sizeof(*src->loop_stack), GFP_KERNEL_ACCOUNT);
+	if (!dst->loop_stack)
+		return -ENOMEM;
 	return copy_stack_state(dst, src);
 }
 
@@ -19916,6 +19921,178 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return -EFAULT;
 }
 
+/*
+ * Push the loop entered at insn_idx onto the stack. Usually this adds a single
+ * entry on top of its enclosing loop. However, an edge may enter an inner loop
+ * directly, bypassing the header(s) of its enclosing loop(s), e.g.:
+ *
+ *   1: for (...):       // enclosing loop, header at 1
+ *   2:   for (...):     // inner loop, header at 2
+ *        ...
+ *   3: if ...:
+ *        goto 2b;       // enters loop 2 without going through header 1
+ *
+ * Such a bypass makes the enclosing loop irreducible, so its header is missing
+ * from the stack and both headers (1) and (2) need to be pushed onto stack.
+ * Only the innermost loop (the one actually entered at insn_idx) carries SCEV bounds;
+ * the bypassed ancestors are irreducible and pushed as non-terminating.
+ *
+ * Assumes loop_stack_pop() has already truncated the stack to the common ancestor
+ * of the bpf_loop_at_index(env->insn_idx) and whatever was at the top of the loop stack.
+ */
+static int loop_stack_push(struct bpf_verifier_env *env, bool *pushed)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *loop_stack = frame->loop_stack;
+	u32 missing_headers[LOOP_STACK_SIZE];
+	u32 cnt = frame->loop_stack_cnt;
+	u32 num_missing = 0;
+	int h;
+
+	*pushed = false;
+
+	for (h = bpf_loop_at_index(env, env->insn_idx); h >= 0; h = aux[h].loop_header, num_missing++) {
+		if (cnt && loop_stack[cnt - 1].loop_id == h)
+			break;
+		if (num_missing == LOOP_STACK_SIZE)
+			goto e2big;
+		missing_headers[num_missing] = h;
+	}
+
+	if (num_missing == 0)
+		return 0;
+	if (cnt + num_missing > LOOP_STACK_SIZE)
+		goto e2big;
+	frame->loop_stack = realloc_array(frame->loop_stack, cnt, cnt + num_missing,
+					 sizeof(*frame->loop_stack));
+	if (!frame->loop_stack)
+		return -ENOMEM;
+	loop_stack = frame->loop_stack;
+
+	for (; num_missing; num_missing--, cnt++) {
+		h = missing_headers[num_missing - 1];
+		loop_stack[cnt] = (struct loop_stack_entry){ .loop_id = h };
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "entering loop %d\n", h);
+		*pushed = true;
+	}
+	frame->loop_stack_cnt = cnt;
+	return 0;
+
+e2big:
+	verbose(env, "Too many nested loops (%d/%d) at %d\n", cnt, num_missing, env->insn_idx);
+	return -E2BIG;
+}
+
+/*
+ * An exit from a loop can cross several nested loops, e.g.:
+ *
+ *   1: for (...):
+ *   2:   for (...):
+ *   3:     for (...):
+ *            if ...:    // before goto the loop stack is [1, 2, 3 <top>]
+ *              goto 1b; // after goto it should become [1]
+ */
+static int loop_stack_pop(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_func_state *frame = cur_func(env);
+	int new_cnt = 0;
+	int h, i;
+
+	/*
+	 * Walk the loop nest of insn_idx outwards (innermost first) and stop at
+	 * the first loop that is present on the stack - that loop is the common
+	 * ancestor and becomes the new top. If no enclosing loop is on the
+	 * stack, drop all loops.
+	 */
+	for (h = bpf_loop_at_index(env, env->insn_idx); h >= 0; h = aux[h].loop_header) {
+		for (i = frame->loop_stack_cnt - 1; i >= 0; i--) {
+			if (frame->loop_stack[i].loop_id == h) {
+				new_cnt = i + 1;
+				goto pop;
+			}
+		}
+	}
+
+pop:
+	if (env->log.level & BPF_LOG_LEVEL2)
+		for (i = frame->loop_stack_cnt - 1; i >= new_cnt; i--)
+			verbose(env, "exiting loop %d\n", frame->loop_stack[i].loop_id);
+	frame->loop_stack_cnt = new_cnt;
+	return 0;
+}
+
+static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)
+{
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *entry;
+
+	if (frame->loop_stack_cnt == 0) {
+		verifier_bug(env, "%s: loop stack empty at %d", __FUNCTION__, env->insn_idx);
+		return -EFAULT;
+	}
+
+	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
+	if (!entry->terminates)
+		return 0;
+
+	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry->entry_state,
+				   entry->max_header_count);
+}
+
+static int handle_loop_entry_exit(struct bpf_verifier_env *env)
+{
+	struct bpf_verifier_state *cur = env->cur_state;
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *entry;
+	struct bpf_loop_iters iters;
+	bool pushed, terminates;
+	int err;
+
+	err = loop_stack_pop(env);
+	if (err)
+		return err;
+
+	err = loop_stack_push(env, &pushed);
+	if (err)
+		return err;
+
+	if (frame->loop_stack_cnt == 0)
+		return 0;
+
+	entry = &frame->loop_stack[frame->loop_stack_cnt - 1];
+	if (env->insn_idx != entry->loop_id)
+		return 0;
+
+	/* If nothing was pushed and env->insn_idx is a loop header, we've taken a backedge. */
+	if (!pushed)
+		return maybe_clamp_scev_regs(env);
+
+	err = bpf_compute_loop_iters(env, env->cur_state, &iters);
+	if (err < 0)
+		return err;
+
+	terminates = err == 1;
+	if (!terminates)
+		return 0;
+
+	/* Create a loop_entry checkpoint before widening */
+	err = bpf_split_cur_state(env);
+	if (err)
+		return err;
+
+	entry->min_header_count = iters.min_header_count;
+	entry->max_header_count = iters.max_header_count;
+	entry->entry_state = cur->parent;
+	entry->terminates = true;
+	err = bpf_widen_scev_regs(env, cur, cur->parent, &iters);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -19930,6 +20107,12 @@ static int do_check(struct bpf_verifier_env *env)
 		struct bpf_insn_aux_data *insn_aux;
 		int err;
 
+		if (signal_pending(current))
+			return -EAGAIN;
+
+		if (need_resched())
+			cond_resched();
+
 		/* reset current history entry on each new instruction */
 		env->cur_hist_ent = NULL;
 
@@ -19976,6 +20159,15 @@ static int do_check(struct bpf_verifier_env *env)
 			}
 		}
 
+		/*
+		 * Possibly widen the registers before creating a checkpoint
+		 * in bpf_is_state_visited(). The next loop iteration will
+		 * have a chance to hit this checkpoint and converge.
+		 */
+		err = handle_loop_entry_exit(env);
+		if (err)
+			return err;
+
 		if (bpf_is_prune_point(env, env->insn_idx)) {
 			err = bpf_is_state_visited(env, env->insn_idx);
 			if (err < 0)
@@ -20001,12 +20193,6 @@ static int do_check(struct bpf_verifier_env *env)
 				return err;
 		}
 
-		if (signal_pending(current))
-			return -EAGAIN;
-
-		if (need_resched())
-			cond_resched();
-
 		if (env->log.level & BPF_LOG_LEVEL2 && do_print_state) {
 			verbose(env, "\nfrom %d to %d%s:",
 				env->prev_insn_idx, env->insn_idx,
@@ -20016,6 +20202,13 @@ static int do_check(struct bpf_verifier_env *env)
 			do_print_state = false;
 		}
 
+		if (bpf_loop_at_index(env, env->insn_idx) >= 0 &&
+		    cur_func(env)->loop_stack_cnt == 0) {
+			verifier_bug(env, "loop stack empty at %d, while inside the loop %d\n",
+				     env->insn_idx, bpf_loop_at_index(env, env->insn_idx));
+			return -EFAULT;
+		}
+
 		if (env->log.level & BPF_LOG_LEVEL) {
 			if (verifier_state_scratched(env))
 				print_insn_state(env, state, state->curframe);
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index dc7baa0f2458..84302a122ccf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -511,7 +511,7 @@ __naked void too_many_gotox_edges(void)
 
 SEC("socket")
 __description("gotox-edges-at-limit")
-__success __retval(0)
+__failure __msg("Too many nested loops")
 __naked void gotox_edges_at_limit(void)
 {
 	asm volatile (
@@ -519,6 +519,10 @@ __naked void gotox_edges_at_limit(void)
 		 * 1000 gotox * 1000 targets = 1,000,000 CFG edges. At run
 		 * time, each block loads the next table entry and jumps to
 		 * the following block, so the program terminates.
+		 *
+		 * Every block can jump to every later block, so the CFG is
+		 * a nest of ~1000 irreducible loops, deeper than the
+		 * verifier's loop stack; the program is rejected.
 		 */
 		GOTOX_TABLE_BEGIN(1000)
 		".rept 1000;"

-- 
2.53.0
