Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937191;
	b=zmU8znpShcvhY3rZ/Kozuq/PEgkDV49zuHPZPvT1QiCeW3Sdvvy+Pbxj3se2QSxd2wq1
	 6IvZZerBPGXJqwI00fAXS9i0HulVKRvSZusOIesl3iXPSr2xDjrT3nsQCTConHI7khaRP
	 zlutAYrqHI0FO+8DLIoDPw8mp4iBHVb012AJlURI2VkEraj4Fimv0loyWMuaetqky+Dfi
	 85pigbjpeYpWeauPfSwBS7m4OJU4cEDIFzyYlB5hx/KL6m3KK/gKKJ012iwJg2kwo3c6I
	 3CZn+T8yMdGbjzdl8k8dwb5FaV9zvXojmBNbIvOdGeecVKTyqN1o7rLjIKQWcPwipiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jQgUcGEFYtcMYGOtoer7jP+HOZISfMSS8a9LVJKAXFw=;
	b=JAHZcKgGwK8F0Hpst+015KnW1fTWW3rgqgY9cJHLOoFvciSXh8SE345j56g/++Gmxotq
	 yWZ23ISj7Tw0dqEqftNgA9l/oVjJSbnf5nEL3droP21X+xhbErIhLAJNKGtN9NTAbDF1F
	 ahR6Ckvkxogt8PEPaxhQtp4BVN5B+PZeUb52NLPkI5h77K2MuZUT2c9N6EkJyu9mpQucV
	 0ekFBIqOVQ0La3xxmg5EhxMa4cjMRnOzhhby5QG98XXi87n+NGd+qpAbRAa+Zc1Lgi3WK
	 8ATbkiR3J12MPoffHHXqSNuT16vVdaSYxsG60hDbFL3/sJBXpaXKQkoQeFo3UPOkTfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGn8D3uX;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5EC606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E5EC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGn8D3uX
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e987a2ba0cso973285ad.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937191; x=1794541991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jQgUcGEFYtcMYGOtoer7jP+HOZISfMSS8a9LVJKAXFw=;
        b=cGn8D3uXYR4hYWhXOI0JoYfwLyL3+Hb2NbA8Lx3+T8G2YDKpm6U6vD8vSpS76AJY3Z
         SvzIZO5i+ac7NqzYTJWuO5in3r9+e1SgVPLMhnX5CzwXhV3ohzWiwUNE5uQB2noTbPcG
         dznzmtmBQoWnKJFb78qGJTl/cepN8BQbFRjgoofwWu2QQo+Os2Ztzh8uZc+czitiDayO
         9P0z1Zz38chTPamYCZJONc9Ce71cMFP/B3nGI/vnDYKqPPDXKsGjsaKUwgjSv6jBtO02
         WzJdZ2FukFInCOvtYZfMTl7pDEc37ZRYtugVscVi61q1RGhYpZ1VdGJnvFGnzF4dtWRr
         jZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937191; x=1794541991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jQgUcGEFYtcMYGOtoer7jP+HOZISfMSS8a9LVJKAXFw=;
        b=ssmreifam03muCEcYpalkh+UWGa+4ZptUYhI+l2nPb4cy0zXwAgD+waB5YZ7umOhm3
         xhHPslRJv4MH7affM7lNOpzFgieZlU29Yl3BWNtkW02i6aAPPJ2uQt5SF2+P3RYVi4sB
         FbntdOgkPQBfHlSX8TknLHmGT46exSTWCdmF5/DUH4nTl8uR3acrL0xsggg/2OcuYsgL
         ypur1lN3+bgNkkJ9R9ZytKmriFhzyax9JaIcUszfmC/bzeEgOYevqhKggLPrhsoDwY+t
         2GQiq85o90XABjVLwAP7uo+B6jZ/KszBJeJy6x34/9fMwpnzGmbcbDhV6KVPCJVKHGT8
         R+fQ==
X-Gm-Message-State: APuU4Z86zGbrwVT1Mc9TESJEQNa5nuOej3JKMgVed/3DrvUktT40SuCP
	iOzkTYBIafvaKkM0W77izQBiPvnUPhB9mvoM5M/hy1nmjpLarxeL64kK3bdVTA==
X-Gm-Gg: AYBFou3V5FJ8bBbTAAyvk/F85jUiT3ZpT0mvpnRv1tb0Kb0TB3JpDSmFZecWzolhjDb
	nQcRs8baZjPtgUqUcaprwWVKZZb/ZKSrq6xVWbCTyCCY2KbnnfmbRGlLPudPRbxoxH/rEL5pXVH
	ulO65aGbqhhA45Z3X94bbE+PzflRhdgTls9VbPOWQi5NXeXdlMAD7irVc7vUVaVS6NGxpfzFTEX
	/A35eslPTpl3f0aTFNhAoz/w9ceACPSudxNmN1Z1BZKBXlv/cT2g6izthfqs+D8NQOv9xJZtZut
	QZVHdViCVZGHvcorhfR8wn+DGewS3m1xFaK5uy2gyP1oBWTenmQtK8aMxtsmc8dkl0W0a0vtg0C
	r+66aPRzwKndwtrk8nsOp09+T19yn8IqLuvtkalFYCA8FIZOAL4B5lKdTvIp1ATIBWbtSOIeyOv
	6afMTTGx1Z2PSpIqWAet/pEQ2XH8QVTrF/3kp+c7SidTJwwSem233MB0wjgQ+WJgRRTSEERyWpb
	Jzh7Sc0EaozwxuIi916+oPIAb1mB2LJ3eN6KEOKb+0KL7cHHkkNL4gZgTtZqYpm/w7xjibw5t19
	eRGYN3VppHx3ui6aXhpJsDXsa+YyNhVBjIgPr9QhpAkthsvlI7vbF/ModU49crCNyuWzwMcmslY
	MlkFVpC6E7JcoXEm496fjW6rtTsq9cqDnhT9zfbZQyUgGZkV+tc4fVjokBCk/t/Gcmv3QClQvFA
	FmZzhoxXYxkKhJkyEZwy0=
X-Received: by 2002:a17:902:c948:b0:2e8:e17d:c8c3 with SMTP id d9443c01a7336-2ed40e34c71mr19185365ad.62.1793937190394;
        Thu, 05 Nov 2026 19:53:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a97bcsm1182705ad.13.2026.11.05.19.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:53:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 20/45] bpf: Keep the count of a loop when a register has no closed form
Date: Fri,  6 Nov 2026 03:50:44 +0000
Message-ID: <20261106035111.3315285-21-alexei.starovoitov@gmail.com>
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

Selftest pyperf600_nounroll, a profiler that reads the stack of Python:
  for (int i = 0; i < STACK_MAX_LEN; ++i) {                  /* 600 */
      if (!frame_ptr || !get_frame_data(..., &frame, &sym))
          break;
      ...
      event->stack[i] = *symbol_id;
      frame_ptr = frame.f_back;
  }
i is an induction variable: 600 iterations, i = [0, 599]. get_frame_data()
fills frame and sym, which are on the stack, in each iteration. These slots
have no closed form, "can't widen *fp-64, expr is ?", and scalar evolution
gives no count for the full loop. Then i is not known either. The main pass
goes through the 600 iterations, 153987 insns, and adds a may_goto without
need. pyperf600, the same loop unrolled 150 times, and strobemeta are
rejected: "math between map_value pointer and register with unbounded .."
res_spin_lock_test_held_lock_max, scx_lavd/lavd_dispatch and
arena_topology_node_init of scx_lavd, scx_chaos and scx_p2dq are rejected
too.

Keep the count. bpf_compute_loop_iters() reports the registers and slots
without a closed form in forget_regs, and bpf_flow_loop_enter() selects
a method:

1. No check depends on the value, bpf_flow_is_needed(): the bytes of sym,
   a hash, a checksum. It is an unknown scalar in the state that covers all
   iterations. pyperf600_nounroll: 1241 insns, no may_goto.

2. A check depends on it. Selftest strobemeta_nounroll1:
     for (int i = 0; i < STROBE_MAX_STRS; ++i)               /* 25 */
         payload_off = read_str_var(cfg, i, .., data, payload_off);
   read_str_var() reads a string to &data->payload[off] and returns off or
   off + len. payload_off is loop-carried, but the step is not a constant:
   "(any r8 (+ r8 ?))". As an unknown scalar: the same "math between ..".
   Walk the loop: each iteration has its own state, with [0, i] in it. The
   count tells where the walk ends. The limit is 100000 insns. 17 progs of
   the selftests (strobemeta, profiler2, linked_list, xdp_synproxy) and
   scx_lavd/lavd_dispatch need it. A pointer, and a slot that does not hold
   one full register, always count as needed.

3. The walk is too long: an unknown scalar, as in 1.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   4 ++
 kernel/bpf/scev.c            | 103 +++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c        |  16 +++++-
 3 files changed, 106 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 91ef4e0a1204..bd62bbb90b39 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -353,6 +353,8 @@ struct bpf_loop_iters {
 	u32 min_header_count;   /* min number of times header is executed */
 	u32 max_header_count;   /* max number of times header is executed */
 	unsigned long precise_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/* live, changed by the loop, and there is no summary of how */
+	unsigned long forget_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/* [0, max] at the entry, and the loop only clears bits */
 	unsigned long mask_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/*
@@ -362,6 +364,8 @@ struct bpf_loop_iters {
 	 */
 	int iv_reg;
 	struct cnum64 iv_range;
+	/* a pointer to the stack that stores go through moves in the loop */
+	bool spill_base;
 };
 
 /* Where may_goto that the verifier adds goes, see check_loop_guard() */
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 8ce188a715e8..c3ce13a52f6f 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -1967,8 +1967,10 @@ scev_reg_for_read(struct bpf_verifier_env *env, const struct bpf_func_state *st,
 
 /*
  * Materialize a writable value in the current state, growing its stack if needed.
- * This does not go through check_stack_write(). The callers skip is_unbound_scev_reg() slots,
- * thus the buffer of a live dynptr slice, see bpf_reg_state::buf, does not become a spill here.
+ * This does not go through check_stack_write(). The buffer of a live dynptr slice, see
+ * bpf_reg_state::buf, does not become a spill here. The callers skip the slots that are
+ * is_unbound_scev_reg() when the loop is entered. A slot that a call in the loop may write
+ * has no description: it is in forget_regs, and they skip these too.
  */
 static int scev_reg_for_write(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			      u32 r, struct bpf_reg_state **out)
@@ -3345,7 +3347,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	struct bpf_loop *loop;
 	int insn_idx = st->insn_idx;
 	u64 until, false_until;
-	bool same = true;
+	bool same = true, walk = false;
 	int err, i;
 	u32 r;
 
@@ -3438,10 +3440,12 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	if (err)
 		return err;
 
+	bitmap_zero(iters->forget_regs, REGS_NUM);
 	bitmap_zero(iters->mask_regs, REGS_NUM);
+	iters->spill_base = false;
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
-		struct bpf_reg_state *reg;
+		struct bpf_reg_state *reg = NULL;
 		u32 ra, r_scev, r_expr;
 		bool spill_base = false;
 
@@ -3488,13 +3492,14 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 
 		reg = scev_reg_for_linear(cur_func, r);
 		/*
-		 * The offset of a pointer to arena is not tracked: what enters the loop stands
-		 * for all iterations. If the loop makes something else of it the state that
-		 * returns to the head is not covered by the state at the head, and the body is
-		 * verified again from that state.
+		 * The offset of a pointer to arena is not tracked, so there is nothing to lose.
+		 * If the loop makes something else of it the state that returns to the head
+		 * is not covered by the state at the head.
 		 */
-		if (reg && reg->type == PTR_TO_ARENA)
+		if (reg && reg->type == PTR_TO_ARENA) {
+			__set_bit(r, iters->forget_regs);
 			continue;
+		}
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {
 			/* 32-bit ALU operations on pointers convert them to scalars */
@@ -3543,10 +3548,69 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 				bpf_log(log, ", requires exact stack-offset tracking");
 			bpf_log(log, "\n");
 		}
-		return 0;
+		/* the count stands, it is this one that is not known in the loop */
+		if (spill_base) {
+			iters->spill_base = true;
+			walk = true;
+			continue;
+		}
+		__set_bit(r, iters->forget_regs);
+		/*
+		 * Only a walk through the iterations tells what it is in each of them. That is not
+		 * worth it for a number that nothing looks at: a sum, a hash, what a call leaves in
+		 * r1 - r5. It's not known in the loop then. A pointer, or a slot that holds
+		 * something else than a register, would be of no use any more.
+		 */
+		if (!reg || (reg->type != SCALAR_VALUE && reg->type != NOT_INIT) ||
+		    bpf_flow_is_needed(env, insn_idx, r)) {
+			walk = true;
+			continue;
+		}
+		if (log->level & BPF_LOG_LEVEL2)
+			bpf_log(log, "loop header at %d, nothing looks at it\n", insn_idx);
 	}
 
-	return 1;
+	/* 2: the count is known, what some of the live registers are is not and it matters */
+	return walk ? 2 : 1;
+}
+
+/* The loop changes @r in a way that has no summary. If it is a number it is not known. */
+static void scev_forget_reg(struct bpf_verifier_env *env, struct bpf_func_state *func, u32 r)
+{
+	struct bpf_stack_state *stack;
+	int i;
+
+	if (r < MAX_BPF_REG) {
+		if (func->regs[r].type == SCALAR_VALUE) {
+			bpf_mark_reg_unknown_imprecise(&func->regs[r]);
+			mark_scev_reg_scratched(env, r);
+		} else if (func->regs[r].type == PTR_TO_ARENA) {
+			/* NULL or not is all that is known about it */
+			bpf_reg_forget_range(&func->regs[r]);
+			mark_scev_reg_scratched(env, r);
+		}
+		return;
+	}
+	stack = scev_regno_to_stack(func, r);
+	if (!stack)
+		return;
+	if (bpf_is_spilled_reg(stack) && stack->spilled_ptr.type == PTR_TO_ARENA) {
+		bpf_reg_forget_range(&stack->spilled_ptr);
+		mark_scev_reg_scratched(env, r);
+		return;
+	}
+	if (bpf_is_spilled_reg(stack) && stack->spilled_ptr.type != SCALAR_VALUE)
+		return;
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (stack->slot_type[i] == STACK_SPILL || stack->slot_type[i] == STACK_ZERO)
+			break;
+	if (i == BPF_REG_SIZE)
+		return;
+	for (i = 0; i < BPF_REG_SIZE; i++)
+		if (stack->slot_type[i] == STACK_SPILL || stack->slot_type[i] == STACK_ZERO)
+			stack->slot_type[i] = STACK_MISC;
+	bpf_mark_reg_not_init(env, &stack->spilled_ptr);
+	mark_scev_reg_scratched(env, r);
 }
 
 /* bpf_compute_loop_iters() checked that every leaf can be unioned into acc. */
@@ -3591,6 +3655,11 @@ static int union_any_reg(struct bpf_verifier_env *env, struct bpf_func_state *lo
 	return 0;
 }
 
+/*
+ * Make @st, which is at the head of a counted loop, stand for all iterations. @loop_entry is the
+ * state that entered the loop and @iters is what bpf_compute_loop_iters() says about it.
+ * @st is a copy of @loop_entry.
+ */
 int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters)
 {
@@ -3621,16 +3690,18 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 		if (!scev_reg_alive(env, st, r))
 			continue;
 
+		if (test_bit(r, iters->forget_regs)) {
+			scev_forget_reg(env, cur_func, r);
+			continue;
+		}
+
 		r_expr = header_env->reg2scev[r];
 		spill32 = spill32_counter(scev, cur_func, r_expr, r, &coefs);
-		if (!spill32 && (is_unbound_scev_reg(env, cur_func, r) ||
+		/* @iters says nothing about a register that is not known in @loop_entry */
+		if (!spill32 && (is_unbound_scev_reg(env, entry_func, r) ||
 				 is_const_scev_reg(env, insn_idx, r)))
 			continue;
 
-		reg = scev_reg_for_linear(cur_func, r);
-		if (reg && reg->type == PTR_TO_ARENA)
-			continue;
-
 		if (test_bit(r, iters->mask_regs)) {
 			/* The range stays. It's no longer equal to the registers with its id. */
 			err = scev_reg_for_write(env, cur_func, r, &reg);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4801e9ac0089..103f36803563 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21630,8 +21630,22 @@ int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop
 	if (err < 0)
 		return err;
 
-	/* @per_trip: the insns of one iteration, times the walks around the loop. */
+	/*
+	 * There is no summary of what the loop does to something that is live.
+	 * Go through the iterations one by one if that is not too long.
+	 * @per_trip: the insns of one iteration, times the walks around the loop.
+	 */
 	per_trip = flow_walk_factor(cur) * loop->nr_insns;
+	if (err == 2 && per_trip <= BPF_FLOW_MAX_WALK &&
+	    iters.max_header_count <= BPF_FLOW_MAX_WALK / (u32)per_trip) {
+		entry->max_header_count = iters.max_header_count;
+		entry->terminates = true;
+		entry->counted = true;
+		entry->apart = true;
+		return 0;
+	}
+	if (err == 2 && iters.spill_base)
+		err = 0;
 	/* The walk has to get to the end of the loop, so it is known to have one. Or not: */
 	if (!err) {
 		err = flow_try_walk(env, entry);
-- 
2.55.0

