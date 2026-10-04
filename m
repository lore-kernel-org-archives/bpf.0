Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698643849A
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121147; cv=none; b=OePZrKs6HXCipcXNpLdBRzHVfhDtU5h9dkJFj9ItgSgrRuJua5gSLlb5mKgZG8zRLKu3rplLoBp3+6br5CnaphZ/Cw6IJ6xyPAymeO8BQ3ZF4dAe9EHJOyGYSNDIeONW7sXc0+7LkOU1gDC5QjhibEzLXgEVCCMf+GAFUgqmrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121147; c=relaxed/simple;
	bh=A2jhtTHJYMAFeKAU1UbPNBZ+sj9KyZgiaQfCZwAiyC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSYba8U703fxdUfI81E95oJg9JDaSCwZ5kenYXlm5vlrP3/zv1nucDo1Yx3Gt7Hc8p9gYf1juV1OGG3nwdMG5CPFB3CyPu8Bcfq3AzaO32WmzjzDfTh0+qlWf7DQYBojzs3oBiXRTizpZoq5OI+9NolQpfBiFzZqpBUGguILmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhjFDcE7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhjFDcE7"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a7cfe8f761so71462a91.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121143; x=1791725943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kxk6YHenR4S2aDF+RPGPuWYxK1MxIv1inZRwBNvUGNI=;
        b=YhjFDcE75K/POnRuYEoj3vYrgyJVuJja1rsbUko1Kcq2hyow1jKrvbsAw6i50XZlOq
         Kkn9MPK3TVgQBEYQ0F2WB5oyLZg9Hj/aClapny8fr77lAM90sQexF1g7bR5ghzKfhdmL
         50+Cdh71HmrNXaW1+dn/tO6p0iZ3jgpD7hJgTOOxhwtlQ+xncB1qSI6c/37acPljCTXy
         O+/oGeB50CjfhVlFespmB2XPwJfSrEdDbApblsv8YpPFv5RqQQ34yBTspT5Zzt6yJCT+
         zTfYi7O86JFCPYOqUMRHOyTTXgemrlUBXkJqOwYO7lmZyfujW70fecYCv5NYRrSGLz36
         baVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121143; x=1791725943;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kxk6YHenR4S2aDF+RPGPuWYxK1MxIv1inZRwBNvUGNI=;
        b=jG6DvzSH/YSiNmzsqJ05Nz6CfDXukqC/JZWRwMWJJFgaQaze2NNvH79PJElZNaPCv/
         /VzvqatF6kWr/XnCFGtNq4dRu4DcfAcNuTLC9giBGKWJ1nCV84AyawhKB2QbhYI5X1qi
         FpoBiraJRZhn4vKABtbd+qYR7g3jUyWPhvecKtzqR0s8abpOx0OC6E4Slp9i7myduQTU
         6Xzb/JI3yQa9DNbNsCJ8fmnStyqfpjcZ9D7rzULm/uePKfTK3kbCIx2f2OrK4d1Zi7R5
         ZsXK6ejtYwVbnh011a4eE973Fmu2LFQrZ163E7zQRKRpPDni7STIHtPz/vTJnJMNcJO/
         EYhw==
X-Gm-Message-State: AFq9FYK/0X+sWVmgdhXnQ/d9IskpyKVuyhEDkJU7H3GfsqVc7LhfBhYQ
	4ky8IcdhPJhU6DX30TWUVXzRwaLawCK6g8dRhmijz+K6Uz90f2zpcqWADOwpHQ==
X-Gm-Gg: AYBFou2l17LB4XCCEoPxX0JMchsGkA7gPdymfus5E2EtmikZO5hA+X2PrDMWehmodtZ
	YDaHsCy+0Y/jHv+sFZjXgZHGBcX5B/Swq8hUAMY9dDMRaKnRJJljf7Dg0u85e2nvuS5h5/cfHgE
	fNT0RFnVFsDLxeZcr5RrckXHC1kN6P/RLraaPcvpAn/KDjHflYxrdHRQMmD7KKfsWCxTblwSQBf
	OZ5jNw2tGAUcZXQnhSdgdT1rwbJMsLQXKbr4nbd8CV0MVu9SgJoXlyF4mnYUuMwm0f2SyTBix9f
	KqsJKxoeUr9dCR0c1HntH7KQMiz4kQ9kYq1fl1y2gs7+qXTV50Sq44NeubwUO9bgwC1Lkj5RaTy
	i33oevGuNyhlmwQ+XvUouDjHG0L7dwB8QAf+zkvMFdJUq310Ws+NTxPW4JdPhiKkNzXaH09vJvz
	7RPJvMc1TmGiHZlKH669pRzD1QoqPPml151UQ+9oD5N8MBNKEUe1C3z+GLcNWeWAkHS7ADQ5X6a
	Z+QtMsbF1gBrkkRoURVVMF1/A==
X-Received: by 2002:a17:90b:3e86:b0:3a0:c621:749 with SMTP id 98e67ed59e1d1-3a4f351723fmr7350244a91.23.1791121142913;
        Sun, 04 Oct 2026 06:39:02 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 29/43] bpf: use SCEV to widen bounded loops
Date: Sun,  4 Oct 2026 06:38:11 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-29-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
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
 include/linux/bpf_verifier.h                       |  30 +
 kernel/bpf/log.c                                   |   5 +
 kernel/bpf/scev.c                                  | 840 +++++++++++++++++++++
 kernel/bpf/states.c                                |  88 ++-
 kernel/bpf/verifier.c                              | 203 ++++-
 tools/testing/selftests/bpf/progs/verifier_gotox.c |   6 +-
 6 files changed, 1160 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 88afc639911b..d13f662dcabc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -328,6 +328,20 @@ struct bpf_retval_range {
 	bool return_32bit;
 };
 
+struct bpf_loop_iters {
+	u32 min_header_count;   /* min number of times header is executed */
+	u32 max_header_count;   /* max number of times header is executed */
+};
+
+struct loop_stack_entry {
+	struct bpf_verifier_state *entry_state;
+	struct bpf_loop_iters iters;
+	u32 loop_id:31;
+	u32 terminates:1;
+};
+
+#define LOOP_STACK_SIZE 16
+
 /* state of the program:
  * type of all registers and stack info
  */
@@ -373,6 +387,11 @@ struct bpf_func_state {
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
@@ -390,6 +409,7 @@ struct bpf_func_state {
 
 	u16 out_stack_arg_cnt; /* Number of outgoing on-stack argument slots */
 	struct bpf_reg_state *stack_arg_regs; /* Outgoing on-stack arguments */
+	struct loop_stack_entry *loop_stack;
 };
 
 #define MAX_CALL_FRAMES 16
@@ -436,6 +456,7 @@ static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
 			 MAX_CALL_FRAMES)
+
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
@@ -1163,6 +1184,8 @@ struct bpf_verifier_env {
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
 	struct scev *scev;
+	/* SCEV representation of stack slots not allocated yet. */
+	struct bpf_reg_state scev_not_init_reg;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1969,4 +1992,11 @@ int bpf_init_scev(struct bpf_verifier_env *env);
 void bpf_free_scev(struct bpf_verifier_env *env);
 int bpf_compute_scev(struct bpf_verifier_env *env);
 
+int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			   struct bpf_loop_iters *iters);
+int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
+			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters);
+int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 insn_idx,
+			struct bpf_verifier_state *entry_state, struct bpf_loop_iters *iters);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 900d1bb1988b..6a5564f62669 100644
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
index 9ef28e0d8d48..a98f3fea52ec 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
+#include "linux/cnum.h"
 #include <linux/bpf_verifier.h>
 #include <linux/jhash.h>
 #include <linux/log2.h>
 #include <linux/bug.h>
+#include <linux/tnum.h>
+#include <linux/overflow.h>
 
 #define REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
 #define UNKNOWN_EXPR_ID 0
@@ -1557,6 +1560,7 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	if (!scev)
 		return -ENOMEM;
 	env->scev = scev;
+	bpf_mark_reg_not_init(env, &env->scev_not_init_reg);
 	/* Order worklist in reverse post-order. */
 	bpf_min_heap_init(&scev->worklist, reverse_ranked_compare, env->cfg.postorder_nums);
 	/* A power of two for hash & (exprs_ht_cnt - 1)` indexing. */
@@ -1581,3 +1585,839 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	bpf_free_scev(env);
 	return -ENOMEM;
 }
+
+static struct bpf_reg_state *scev_regno_to_reg(struct bpf_verifier_env *env,
+					    struct bpf_func_state *st, u32 r)
+{
+	int spi, slots_available;
+
+	if (r < MAX_BPF_REG)
+		return &st->regs[r];
+
+	slots_available = st->allocated_stack / BPF_REG_SIZE;
+	spi = r - MAX_BPF_REG;
+	if (spi < slots_available)
+		return &st->stack[spi].spilled_ptr;
+
+	return &env->scev_not_init_reg;
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
+	/* Flip the condition if true branch jumps out of the loop */
+	true_branch_tgt = latch_idx + bpf_jmp_offset(insn) + 1;
+	if (bpf_loop_at_index(env, true_branch_tgt) !=
+	    bpf_loop_at_index(env, latch_idx))
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
+	latch->op = op;
+	latch->insn_idx = latch_idx;
+
+	latch_env = find_loop_env(scev, header, latch_idx);
+	if (verifier_bug_if(!latch_env, env, "header_idx=%d, latch_idx=%d\n", header, latch_idx))
+		return -EFAULT;
+	dst_reg_scev = latch_env->reg2scev[insn->dst_reg];
+	src_reg_scev = latch_env->reg2scev[insn->src_reg];
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
+		reg = scev_regno_to_reg(env, st, v->ptr_reg);
+		log_reg(env, v->ptr_reg);
+		bpf_log(&env->log, " (%s)", reg_type_str(env, reg->type));
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
+	ra = scev_regno_to_reg(env, st, a->ptr_reg);
+	rb = scev_regno_to_reg(env, st, b->ptr_reg);
+	if (bpf_same_memory_origin(ra, rb))
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
+	struct bpf_reg_state *reg;
+	u32 l, r, regno;
+	s64 imm;
+
+	if (is_reg(scev, id, &regno)) {
+		reg = scev_regno_to_reg(env, st, regno);
+		if (reg->type == NOT_INIT)
+			return false;
+		if (tnum_is_const(reg->var_off)) {
+			result->value = reg->var_off.value;
+			result->ptr_reg = reg->type == SCALAR_VALUE ? -1 : (int)regno;
+			return true;
+		}
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
+	default:
+	}
+}
+
+/* Check that ANY leaves can be unioned with r's loop-entry value. */
+static bool is_any_imm_reg(struct bpf_verifier_env *env, struct bpf_func_state *loop_entry,
+			   struct env *header_env, u32 r, u32 id)
+{
+	struct scev *scev = env->scev;
+	struct bpf_reg_state *reg, *leaf_reg;
+	u32 l, rr, leaf, ra, order;
+	s64 imm;
+
+	if (!is_any(scev, id, &l, &rr))
+		return false;
+	reg = scev_regno_to_reg(env, loop_entry, r);
+	if (!is_widenable_reg_type(reg))
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
+			leaf_reg = scev_regno_to_reg(env, loop_entry, leaf);
+			if (leaf_reg->type != reg->type)
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
+ * Returns false if the computation overflows s64.
+ */
+static bool linear_bounds(struct bpf_reg_state *reg, struct bpf_loop_iters *iters, s64 slope,
+			  struct bounds *out)
+{
+	s64 slope_abs = slope < 0 ? -slope : slope;
+	s64 min_val = reg_smin(reg);
+	s64 max_val = reg_smax(reg);
+	s64 total_change;
+	u16 base, step;
+
+	if (check_mul_overflow(slope, (s64)iters->max_header_count - 1, &total_change))
+		return false;
+	if (slope > 0) {
+		if (check_add_overflow(max_val, total_change, &max_val))
+			return false;
+	} else {
+		if (check_add_overflow(min_val, total_change, &min_val))
+			return false;
+	}
+	/*
+	 * If the entry value is a single point the value set is 'v + slope * k',
+	 * so the step is |slope|. Otherwise, only the power-of-two alignment
+	 * shared by the entry value and the slope.
+	 */
+	if (cnum64_is_const(reg->r64)) {
+		step = slope_abs;
+		base = imod(min_val, step);
+	} else {
+		step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
+		base = 0;
+	}
+	out->range = cnum64_from_srange(min_val, max_val);
+	out->base = base;
+	out->step = step;
+	return true;
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
+	struct linear_latch latch;
+	struct bpf_loop *loop;
+	struct bounds bounds;
+	int insn_idx = st->insn_idx;
+	int linear_latch;
+	u32 r, base_reg;
+	int latch_idx;
+	s64 slope_imm;
+	int err;
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
+	latch_idx = loop->backedges[0].latch;
+	if (latch_idx < 0) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, latch not identified\n", insn_idx);
+		return 0;
+	}
+
+	linear_latch = match_linear_latch(env, insn_idx, latch_idx, &latch);
+	if (linear_latch < 0)
+		return linear_latch;
+
+	if (!linear_latch) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, non-linear latch at %d\n",
+				insn_idx, latch_idx);
+		return 0;
+	}
+
+	if (!compute_max_iters(env, cur_func, &latch, iters)) {
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, can't compute iterations count\n", insn_idx);
+		return 0;
+	}
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
+
+		r_scev = header_env->reg2scev[r];
+		reg = scev_regno_to_reg(env, cur_func, r);
+		/* If SCEV for r is (linear <reg> <slope>) */
+		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
+		    is_widenable_reg_type(reg)) {
+			/* Can't widen if the iteration range overflows */
+			if (base_reg == r &&
+			    !linear_bounds(reg, iters, slope_imm, &bounds))
+				goto cant_widen;
+			continue;
+		}
+
+		/* rA = rA, loop does not change this reg */
+		if (is_reg(scev, r_scev, &ra) && r == ra)
+			continue;
+
+		/* (any 1 (any 2 (any 3 4))) */
+		if (is_any_imm_reg(env, cur_func, header_env, r, r_scev))
+			continue;
+
+cant_widen:
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
+	return 1;
+}
+
+/* bpf_compute_loop_iters() checked that every leaf can be unioned into acc. */
+static int union_any_reg(struct bpf_verifier_env *env, struct bpf_func_state *loop_entry,
+			 struct bpf_reg_state *acc, u32 id)
+{
+	struct bpf_reg_state *tmp = &env->fake_reg[0], *leaf_reg;
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
+			leaf_reg = scev_regno_to_reg(env, loop_entry, leaf);
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
+	header_env = find_header_env(scev, insn_idx);
+	for (r = 0; r < REGS_NUM; r++) {
+		if (!scev_reg_alive(env, st, r))
+			continue;
+
+		r_expr = header_env->reg2scev[r];
+		/* If SCEV for r is (linear <reg> <slope>)*/
+		if (is_simple_linear(scev, r_expr, &base_reg, &slope_imm) &&
+		    base_reg == r) {
+			reg = scev_regno_to_reg(env, cur_func, r);
+			/* bpf_compute_loop_iters() checked these bounds for overflow. */
+			if (!linear_bounds(reg, iters, slope_imm, &bounds)) {
+				verifier_bug(env, "scev widen bounds overflow for r%d", r);
+				return -EFAULT;
+			}
+			if (log->level & BPF_LOG_LEVEL2) {
+				bpf_log(log, "loop header at %d, widening ", insn_idx);
+				log_reg(env, r);
+				bpf_log(log, " to %lld..%lld step %u\n",
+					cnum64_smin(bounds.range), cnum64_smax(bounds.range),
+					bounds.step);
+			}
+			scratch_widened_reg_id(env, reg);
+			err = bpf_set_reg_range(env, reg, bounds.range, bounds.base, bounds.step);
+			if (err)
+				return err;
+			mark_scev_reg_scratched(env, r);
+		} else if (is_any(scev, r_expr, &a, &b)) {
+			reg = scev_regno_to_reg(env, cur_func, r);
+			err = union_any_reg(env, entry_func, reg, r_expr);
+			if (err)
+				return err;
+			if (log->level & BPF_LOG_LEVEL2) {
+				bpf_log(log, "loop header at %d, widening ", insn_idx);
+				log_reg(env, r);
+				bpf_log(log, " to %lld..%lld step %u\n",
+					reg_smin(reg), reg_smax(reg), reg->step);
+			}
+			scratch_widened_reg_id(env, reg);
+			mark_scev_reg_scratched(env, r);
+		}
+	}
+	return 1;
+}
+
+int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur_func_state, u32 insn_idx,
+			struct bpf_verifier_state *entry_state, struct bpf_loop_iters *iters)
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
+		entry_reg = scev_regno_to_reg(env, entry_st, r);
+		reg = scev_regno_to_reg(env, cur_func_state, r);
+		if (entry_reg->type == NOT_INIT || reg->type == NOT_INIT)
+			continue;
+
+		if (!linear_bounds(entry_reg, iters, slope_imm, &bounds)) {
+			verifier_bug(env, "scev clamp bounds overflow for r%d", r);
+			return -EFAULT;
+		}
+		bounds.range = cnum64_intersect(reg->r64, bounds.range);
+		if (cnum64_is_empty(bounds.range)) {
+			verifier_bug(env, "scev clamp produced empty range for r%d", r);
+			return -EFAULT;
+		}
+		if (log->level & BPF_LOG_LEVEL2) {
+			bpf_log(log, "loop header at %d, clamping ", insn_idx);
+			log_reg(env, r);
+			bpf_log(log, " to %lld..%lld step %u\n",
+				cnum64_smin(bounds.range), cnum64_smax(bounds.range),
+				bounds.step);
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
index 470bff8d8dc8..94339729f524 100644
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
+		    old_stack[i].iters.max_header_count == cur_stack[i].iters.max_header_count &&
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
index 1fc3e6e2387e..8e92c77b11a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1669,6 +1669,7 @@ static void free_func_state(struct bpf_func_state *state)
 {
 	if (!state)
 		return;
+	kfree(state->loop_stack);
 	kfree(state->stack_arg_regs);
 	kfree(state->stack);
 	kfree(state);
@@ -1705,6 +1706,10 @@ static int copy_func_state(struct bpf_func_state *dst,
 	memcpy(dst, src, offsetof(struct bpf_func_state, stack));
 	/* Instruction accounting is path-local, not part of verifier state. */
 	dst->insns_subtotal = 0;
+	dst->loop_stack = copy_array(dst->loop_stack, src->loop_stack, src->loop_stack_cnt,
+				     sizeof(*src->loop_stack), GFP_KERNEL_ACCOUNT);
+	if (!dst->loop_stack)
+		return -ENOMEM;
 	return copy_stack_state(dst, src);
 }
 
@@ -19770,6 +19775,176 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
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
+	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry->entry_state, &entry->iters);
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
+	entry->iters = iters;
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
@@ -19784,6 +19959,12 @@ static int do_check(struct bpf_verifier_env *env)
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
 
@@ -19830,6 +20011,15 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -19855,12 +20045,6 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -19870,6 +20054,13 @@ static int do_check(struct bpf_verifier_env *env)
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
