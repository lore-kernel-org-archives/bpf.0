Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A541D131
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432473; cv=none; b=DgZXkUmnFuIJC5iw3a7/8mNg8aW21cIps4e/u5R/5JcaV8OarBBmRzbMYr9Kem1P0OnUmlhpMiFCPih5NFlf/SjdsmAL0Nz9V2ds9rGRZyyjx7zcxi2WWxH1SX7rru/bIPFmuaiG6z548C36+kajEfJqV3OjkcXWYDtpm+xe3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432473; c=relaxed/simple;
	bh=3KcVHb5YMuycrQW6pm2ipLEbgdnweegUa3V0RzYBh+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwlDOSuJ+zQqCAUiSGvf9vg3RPTrqVtjzlsqvjAwwxW+eIKVlVC7cozMFTT67XYT17FswZAw/lH3mydltAVkR9in4UJnHh/QvqbECMY8vhS9nJ9SugnZZ2+YBxc7c5wJdJp1kliXKJJ/D6rC++wZ+Znt8qAF+dMH1Z8nNVkOfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYYP9lSh; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYYP9lSh"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0df0bb2d6so303617a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432470; x=1791037270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zj4Aa470U5B0GTRTsa95X20cYD8SfKs9fkz0gmX3LUA=;
        b=hYYP9lSh+cqw4r440bURw8WQZ6xTupmodb1TRkYadjid7/DhQYrMBetrtQGEEn0yYM
         7ARKRhRmqv9Hp5SQxWLPhpmq+X5wErYpNYCGIQoe631ynf15m0PzjCgYL1mHRi0wZh4H
         YjXUC0Nws6SbPyQ3VoOMOXzxSRsogNyTZ9etP7PVWhJTSexi5sbLNTpdIplcsvO2v5Ak
         XpG45LZTRBqsb4ylOr9zufbdn1Io0/pTC3aYJ0roUV3u1G2FAQqm6xG9V1PAgHiuJWv7
         q6KIMRonC5xU7hQILLMLVijZ0SRKCA3HZ8s9oGKwwOsapNpkjbITqfF9fH2poxReATht
         +CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432470; x=1791037270;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zj4Aa470U5B0GTRTsa95X20cYD8SfKs9fkz0gmX3LUA=;
        b=ILOukqKWsegRPG//37nprw6ElpHEZMb6LJ5qnLq08Speu8w9jQLfv3/zihIecYyU5m
         tZEAKWk+qdGPWyFh3Ku6+NF4B24kX+YI8gVk1IA+3dESJVT6ylekW1Yd8VCRTaBRHHKv
         FlP3NCAfIZ7SnxAhCN223yihm7523IA8boLPMU+YdlrxFWHiw30+2aZxogMKp0m3R3ul
         L2539VTXU0ygDmB/yN/WFPhVQkUBQAztSSXFPMuMztjEwedHCu0OgPc7OqYtaItE+sBW
         RAU7Y0n72HK6Xkjk2uAXGHA+dslREB+LcrjU8Wy08n+cXf1FiUm4gql3JQyAEVMVHl5k
         3Fqg==
X-Gm-Message-State: AFq9FYKZDYG+NoEGpUHp8Ed6g9p1z6hPUu8AjhFKWUxsFY06/AsKSrjy
	KoO9hF40CNuaGlM1gzJ0P8htFzRV92gPttEW8DOg2Q3g4VozygQPsbhFSjF7+6c5TeI=
X-Gm-Gg: AYBFou2HjdLbCXfaV/prJUy00US6JMlGFoOpJC03eT7k6D5toFAZUBSsB3ZvEYRpCxS
	O77lKK5gTtCxAIMy2rZbLceahqWH6htKtkg0wNQRluZIL1Q8CCIyLCVmWEb0Ebm1FPi5Ku5j5aZ
	nWUSe2ic0YoInmA9AdaCK9loUnEykCAIlUlYsjdILRkM/5PXWriTNdFhevNVYtuk95wK+8HfqeX
	IytopDhJ1bPdE5Qt9aMzTFBEQVnyfqCIRYtx4jzij4IbNoC0zP4Sn1tyyte6mK/eXjpzIRo8BXX
	nDM/kvtwyVM7M/8dh72eC4XfuZeF5B7APdqVKc3qUe5zWM6O1v7ej65oEyfmhzN26BLTynIDNz4
	J2gj31qq9P3SdyvFq/VFeYc7HrX25KUtWzRPgfXa4BweiD6gXldNZRrGY+z0i1NTYSnFT+WNelu
	DhwJ/b9sEzhTEdpkvNeCZ2h0CE6ZFnaNiEwfgB1XLIIxT2Bhkz83092w5yQ5QgPh74Q5M3Wx7Iz
	1rypi0CbTQyee2YtEYaOiGrUuf4tjbwGqTBdh9nC+8=
X-Received: by 2002:a17:90b:4d09:b0:3a0:c85a:e602 with SMTP id 98e67ed59e1d1-3a0c85aeba7mr2745314a91.9.1790432469242;
        Sat, 26 Sep 2026 07:21:09 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:08 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 25/36] bpf: use SCEV to widen bounded loops
Date: Sat, 26 Sep 2026 07:20:23 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-25-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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
 include/linux/bpf_verifier.h                       |  31 +
 kernel/bpf/log.c                                   |   5 +
 kernel/bpf/scev.c                                  | 653 +++++++++++++++++++++
 kernel/bpf/states.c                                |  67 ++-
 kernel/bpf/verifier.c                              | 226 ++++++-
 tools/testing/selftests/bpf/progs/verifier_gotox.c |   6 +-
 6 files changed, 976 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 54a971800ea3..c0eea472949d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -328,6 +328,21 @@ struct bpf_retval_range {
 	bool return_32bit;
 };
 
+struct bpf_loop_iters {
+	u32 min_header_count;   /* min number of times header is executed */
+	u32 max_header_count;   /* max number of times header is executed */
+	bool pre_cond;
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
@@ -373,6 +388,12 @@ struct bpf_func_state {
 	u32 callback_depth;
 	/* Instructions processed in this frame and callees on the current path. */
 	u32 insns_subtotal;
+	/*
+	 * Control-flow loop nesting at the current insn within this frame's
+	 * subprogram (loops never cross subprogram boundaries).
+	 */
+	u32 loop_stack_cnt;
+	struct loop_stack_entry loop_stack[LOOP_STACK_SIZE];
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
@@ -436,6 +457,7 @@ static_assert(MAX_BPF_STACK_SLOTS <= (1 << 12));
 #define MAX_STACK_ARG_SLOTS (MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS)
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK_SLOTS + MAX_STACK_ARG_SLOTS) * \
 			 MAX_CALL_FRAMES)
+
 struct bpf_verifier_state {
 	/* call stack tracking */
 	struct bpf_func_state *frame[MAX_CALL_FRAMES];
@@ -1156,6 +1178,8 @@ struct bpf_verifier_env {
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
 	struct scev *scev;
+	/* SCEV representation of stack slots not allocated yet. */
+	struct bpf_reg_state scev_not_init_reg;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1944,4 +1968,11 @@ int bpf_init_scev(struct bpf_verifier_env *env);
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
index 396b0c776dfa..205bf8684c3d 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
 
+#include "linux/cnum.h"
 #include <linux/bpf_verifier.h>
 #include <linux/jhash.h>
 #include <linux/bug.h>
+#include <linux/tnum.h>
+#include <linux/overflow.h>
 
 #define REGS_NUM (MAX_BPF_REG + MAX_BPF_STACK_SLOTS)
 #define UNKNOWN_EXPR_ID 0
@@ -1498,6 +1501,7 @@ int bpf_init_scev(struct bpf_verifier_env *env)
 	if (!scev)
 		return -ENOMEM;
 	env->scev = scev;
+	bpf_mark_reg_not_init(env, &env->scev_not_init_reg);
 	/* Order worklist in reverse post-order. */
 	bpf_min_heap_init(&scev->worklist, reverse_ranked_compare, env->cfg.postorder_nums);
 	if (expr0(scev, UNKNOWN) < 0 || expr0(scev, OPAQUE)  < 0)
@@ -1517,3 +1521,652 @@ int bpf_init_scev(struct bpf_verifier_env *env)
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
+	u32 reg_expr;
+	u32 reg;
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
+			      u32 latch_idx,
+			      struct linear_latch *latch)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[latch_idx];
+	struct scev *scev = env->scev;
+	struct env *latch_env = find_loop_env(scev, bpf_loop_at_index(env, latch_idx), latch_idx);
+	u32 true_branch_tgt;
+	u32 l, r, op, base;
+	u32 src_reg_scev;
+	u32 dst_reg_scev;
+	int id;
+
+	/* 32-bit arithmetic is not handled yet */
+	if (BPF_CLASS(insn->code) != BPF_JMP)
+		return false;
+	op = BPF_OP(insn->code);
+	/* Flip the condition if true branch jumps out of the loop */
+	true_branch_tgt = latch_idx + bpf_jmp_offset(insn) + 1;
+	if (bpf_loop_at_index(env, true_branch_tgt) != bpf_loop_at_index(env, latch_idx))
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
+	dst_reg_scev = latch_env->reg2scev[insn->dst_reg];
+	src_reg_scev = latch_env->reg2scev[insn->src_reg];
+	if (!is_linear(scev, dst_reg_scev, &base, &latch->step_expr))
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
+	if (is_reg(scev, base, &latch->reg)) {
+		id = imm_expr(scev, 0);
+		if (id < 0)
+			return id;
+		latch->base_expr = id;
+		latch->reg_expr = base;
+	} else if (is_add(scev, base, &l, &r) &&
+		   is_reg(scev, l, &latch->reg)) {
+		latch->base_expr = r;
+		latch->reg_expr = l;
+	} else {
+		return false;
+	}
+
+	if (!loop_invariant(scev, latch->base_expr) ||
+	    !loop_invariant(scev, latch->step_expr) ||
+	    !loop_invariant(scev, latch->bound_expr))
+		return false;
+
+	return true;
+}
+
+static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev, struct bpf_func_state *st, u32 id, u64 *result)
+{
+	struct bpf_reg_state *reg;
+	u32 regno;
+	s64 imm;
+
+	if (is_reg(scev, id, &regno)) {
+		reg = scev_regno_to_reg(env, st, regno);
+		if (reg->type == NOT_INIT)
+			return false;
+		if (tnum_is_const(reg->var_off)) {
+			*result = reg->var_off.value;
+			return true;
+		}
+	} else if (is_imm(scev, id, &imm)) {
+		*result = imm;
+		return true;
+	}
+	return false;
+}
+
+/* Like DIV_ROUND_UP() but overflow safe */
+static u64 div_round_up(u64 a, u64 b)
+{
+	return a / b + (a % b != 0);
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
+	u64 base, step, diff, bound, initial, max_iters;
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_loop *loop = aux[bpf_loop_at_index(env, latch->insn_idx)].loop;
+	struct scev *scev = env->scev;
+	u8 op = latch->op;
+
+	if (!eval_expr(env, scev, st, latch->base_expr, &base) ||
+	    !eval_expr(env, scev, st, latch->step_expr, &step) ||
+	    !eval_expr(env, scev, st, latch->bound_expr, &bound) ||
+	    !eval_expr(env, scev, st, latch->reg_expr, &initial))
+		return false;
+
+	if (step == 0)
+		return false;
+	if ((s64)step == S64_MIN)
+		return false;
+	if ((s64)step < 0) {
+		/* Multiply both sides of the equation by -1, e.g. -2*i > -3 becomes 2*i < 3 */
+		op = bpf_flip_opcode(op);
+		step = -step;
+		swap(bound, initial);
+	}
+	diff = bound - initial;
+	if (diff / step == U64_MAX)
+		return false;
+	switch (op) {
+	case BPF_JLT:
+		max_iters = (u64)initial >= (u64)bound ? 0 : div_round_up(diff, step);
+		break;
+	case BPF_JLE:
+		max_iters = (u64)initial >  (u64)bound ? 0 : diff / step + 1;
+		break;
+	case BPF_JSLT:
+		max_iters = (s64)initial >= (s64)bound ? 0 : div_round_up(diff, step);
+		break;
+	case BPF_JSLE:
+		max_iters = (s64)initial >  (s64)bound ? 0 : diff / step + 1;
+		break;
+	case BPF_JNE:
+		max_iters = diff % step ? U32_MAX : div_round_up(diff, step);
+		break;
+	default:
+		return false;
+	}
+
+	if (max_iters > U32_MAX)
+		return false;
+
+	/*
+	 * The latch is a conditional jump with one jump target exiting the loop.
+	 * Linear latch is matched only if the loop has a single backedge.
+	 * The loop still, however can have multiple exits.
+	 * In such case, conservatively assume that non-latch exit can happen
+	 * at any iteration, thus setting minimal number of iterations as 0.
+	 */
+	iters->max_header_count = max_iters + (base == 0 ? 1 : 0);
+	iters->min_header_count = loop->exits_cnt == 1 ? iters->max_header_count : 0;
+	iters->pre_cond = base == 0;
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
+	u16 step;
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
+	if (cnum64_is_const(reg->r64))
+		step = slope_abs;
+	else
+		step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
+	out->range = cnum64_from_srange(min_val, max_val);
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
+	if (latch_idx < 0)
+		return 0;
+
+	linear_latch = match_linear_latch(env, latch_idx, &latch);
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
+		bpf_log(log, "%s\n", iters->pre_cond ? "pre-cond" : "post-cond");
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
+static void scratch_scalar_id(struct bpf_reg_state *reg)
+{
+	if (reg->type == SCALAR_VALUE)
+		reg->id = 0;
+}
+
+/* The filtering pass has checked that every leaf can be unioned into acc. */
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
+			/* Feasibility was checked in the filtering pass above. */
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
+			scratch_scalar_id(reg);
+			err = bpf_set_reg_range(env, reg, bounds.range, bounds.step);
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
+			scratch_scalar_id(reg);
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
+		scratch_scalar_id(reg);
+		err = bpf_set_reg_range(env, reg, bounds.range, bounds.step);
+		if (err)
+			return err;
+		mark_scev_reg_scratched(env, r);
+	}
+	return 0;
+}
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 68df27e34b60..c1771a355e4e 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -942,6 +942,28 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
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
+		    old_stack[i].iters.pre_cond == cur_stack[i].iters.pre_cond &&
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
@@ -992,6 +1014,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	if (!stack_arg_safe(env, old, cur, &env->idmap_scratch, exact))
 		return false;
 
+	if (!loop_stack_safe(env, old, cur))
+		return false;
+
 	return true;
 }
 
@@ -1038,6 +1063,7 @@ static bool states_equal(struct bpf_verifier_env *env,
 		if (!func_states_equal(env, old->frame[i], cur->frame[i], insn_idx, exact))
 			return false;
 	}
+
 	return true;
 }
 
@@ -1320,15 +1346,30 @@ int bpf_split_cur_state(struct bpf_verifier_env *env)
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
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 {
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
 
@@ -1359,10 +1400,11 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			continue;
 
 		if (sl->state.branches) {
-			struct bpf_func_state *frame = sl->state.frame[0];
+			struct bpf_func_state *old_top_frame = sl->state.frame[0];
+			struct bpf_func_state *old_cur_frame = sl->state.frame[sl->state.curframe];
 
-			if (frame->in_async_callback_fn &&
-			    frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {
+			if (old_top_frame->in_async_callback_fn &&
+			    old_top_frame->async_entry_cnt != cur->frame[0]->async_entry_cnt) {
 				/* Different async_entry_cnt means that the verifier is
 				 * processing another entry into async callback.
 				 * Seeing the same state is not an indication of infinite
@@ -1461,6 +1503,20 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 				}
 				goto skip_inf_loop_check;
 			}
+
+			/*
+			 * If old state belongs to a control flow loop that we know terminates,
+			 * it should be safe to prune current state.
+			 */
+			if (old_cur_frame->loop_stack_cnt &&
+			    old_cur_frame->loop_stack[old_cur_frame->loop_stack_cnt - 1].terminates) {
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
@@ -1619,7 +1675,8 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)
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
index 57085f1bf915..9f56ffe09eba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19604,6 +19604,204 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 	return -EFAULT;
 }
 
+static bool has_entered_loop(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int prev_insn_idx = env->prev_insn_idx;
+	int insn_idx = env->insn_idx;
+
+	return aux[insn_idx].loop_entry &&
+	       (prev_insn_idx == -1 ||
+		bpf_loop_at_index(env, prev_insn_idx) != bpf_loop_at_index(env, insn_idx));
+}
+
+static bool is_next_loop_iteration(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int prev_insn_idx = env->prev_insn_idx;
+	int insn_idx = env->insn_idx;
+
+	return aux[insn_idx].loop_entry &&
+	       (prev_insn_idx != -1 &&
+		bpf_loop_at_index(env, prev_insn_idx) == bpf_loop_at_index(env, insn_idx));
+}
+
+static bool has_exited_loop(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int prev_insn_idx = env->prev_insn_idx;
+	int insn_idx = env->insn_idx;
+	int prev_loop_idx, h;
+
+	if (prev_insn_idx == -1)
+		return false;
+
+	prev_loop_idx = bpf_loop_at_index(env, prev_insn_idx);
+	if (prev_loop_idx < 0)
+		return false;
+
+	/* Still inside the previous instruction's loop if that loop encloses insn_idx */
+	for (h = bpf_loop_at_index(env, insn_idx); h >= 0; h = aux[h].loop_header)
+		if (h == prev_loop_idx)
+			return false;
+
+	return true;
+}
+
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
+ * of the bpf_loop_at_index(env->prev_insn_idx) and bpf_loop_at_index(env->insn_idx).
+ */
+static int loop_stack_push(struct bpf_verifier_env *env,
+			   struct bpf_verifier_state *entry_state,
+			   bool terminates,
+			   struct bpf_loop_iters *iters)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_func_state *frame = cur_func(env);
+	struct loop_stack_entry *loop_stack = frame->loop_stack;
+	u32 missing_headers[LOOP_STACK_SIZE];
+	u32 cnt = frame->loop_stack_cnt;
+	u32 num_missing = 0;
+	int h;
+
+	for (h = bpf_loop_at_index(env, env->insn_idx); h >= 0; h = aux[h].loop_header, num_missing++) {
+		if (cnt && loop_stack[cnt - 1].loop_id == h)
+			break;
+		if (num_missing == LOOP_STACK_SIZE)
+			goto e2big;
+		missing_headers[num_missing] = h;
+	}
+
+	for (; num_missing; num_missing--, cnt++) {
+		if (cnt == LOOP_STACK_SIZE)
+			goto e2big;
+		loop_stack[cnt].loop_id = missing_headers[num_missing - 1];
+		if (num_missing == 1) {
+			loop_stack[cnt].iters = terminates ? *iters : (struct bpf_loop_iters){};
+			loop_stack[cnt].terminates = terminates;
+			loop_stack[cnt].entry_state = entry_state;
+		} else {
+			loop_stack[cnt].iters = (struct bpf_loop_iters){};
+			loop_stack[cnt].terminates = false;
+			loop_stack[cnt].entry_state = NULL;
+		}
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
+				frame->loop_stack_cnt = i + 1;
+				return 0;
+			}
+		}
+	}
+
+	frame->loop_stack_cnt = 0;
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
+	struct bpf_loop_iters iters;
+	bool terminates;
+	int err;
+
+	if (is_next_loop_iteration(env)) {
+		err = maybe_clamp_scev_regs(env);
+		if (err)
+			return err;
+	}
+	if (has_exited_loop(env)) {
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "exiting loop %d\n", bpf_loop_at_index(env, env->prev_insn_idx));
+		err = loop_stack_pop(env);
+		if (err)
+			return err;
+	}
+	if (has_entered_loop(env)) {
+		if (env->log.level & BPF_LOG_LEVEL2)
+			verbose(env, "entering loop %d\n", bpf_loop_at_index(env, env->insn_idx));
+		err = bpf_compute_loop_iters(env, env->cur_state, &iters);
+		if (err < 0)
+			return err;
+		terminates = err == 1;
+		if (terminates) {
+			err = bpf_split_cur_state(env);
+			if (err)
+				return err;
+			err = bpf_widen_scev_regs(env, cur, cur->parent, &iters);
+			if (err < 0)
+				return err;
+		}
+		err = loop_stack_push(env, env->cur_state->parent, terminates, &iters);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 static int do_check(struct bpf_verifier_env *env)
 {
 	bool pop_log = !(env->log.level & BPF_LOG_LEVEL2);
@@ -19618,6 +19816,12 @@ static int do_check(struct bpf_verifier_env *env)
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
 
@@ -19664,6 +19868,15 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -19689,12 +19902,6 @@ static int do_check(struct bpf_verifier_env *env)
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
@@ -19704,6 +19911,13 @@ static int do_check(struct bpf_verifier_env *env)
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
index f5a9878c7b8d..03a3bee21236 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -509,7 +509,7 @@ __naked void too_many_gotox_edges(void)
 
 SEC("socket")
 __description("gotox-edges-at-limit")
-__success __retval(0)
+__failure __msg("Too many nested loops")
 __naked void gotox_edges_at_limit(void)
 {
 	asm volatile (
@@ -517,6 +517,10 @@ __naked void gotox_edges_at_limit(void)
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
2.55.0
