Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022794;
	b=HK/Wj2QTW8aNz8mH5ts7LCBfOknfr73zv4qxt/ONeqRH9mlsbOYelvVlqtlSfxDbso+8
	 Jp7tFE/wX7cUFgTUb5Po6SpI0oJnYwv8hNX/5laPOWnazUTGlw0AodF+FSM4LdsRtd2Wo
	 IJJs3ccdQR4ggsGZ5vC0JUgJHxZOcZCOhhWvxqUFFEKO5J3NarXX1/uN32fAFDB6O0mAG
	 ix2hB6vUPxzm1zCva1bAH0IdtIIOEuYq/KzpZaf1TqYlI4shiM+9H/B0KaNLc60Kd66VO
	 ETO8tN5g/M1CchZ/nQjhHY/SJYvsZl8/+7sAx6q5RuTNhiuX6Gc47M/FAiWtjCnID3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIOAF3kdDXl+yPrD+9p69Av+Bk03hMFkvgvp9BXLD84=;
	b=sR1p3DL9HPcwQ6AssJibKYErO+F8itw/8moYPZpMm63zO8/JaQRsiCdIXQd+zbpzMIJN
	 y5cW2MQFHXtjUWig26ykvCvbojUtFjcKtPFJotVYwkRvhxh0tk74rgrY6Yl8p79vO5uNJ
	 ZKoRJHhtw96ox1RegGtpXyrt6+nInQG4oKlRFOkE4Rv6n4DcifvjKsfO/JVbr2MXYOouQ
	 IrV43EJo2SzsZtnEb1aRCJJtL3dAr+3ltnyEzm/Sn6C6g/JGPMTF9jki0RAcey0QzYqaz
	 29M94dTuNvb2+mG1kpFzBUAlrhwp7Qwzh3PA45241+IfnjoNwzOPYXts0pnofiJ0HrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GxbAeppM;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53900606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53900606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GxbAeppM
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso709061a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022793; x=1794627593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UIOAF3kdDXl+yPrD+9p69Av+Bk03hMFkvgvp9BXLD84=;
        b=GxbAeppMr/DHjuJTa9Gwbw3jS5/0Sbls0n9uVRN2bRU0KJyPyBUz2Q4xkNKBRwoXkJ
         fDWzpo1yMOT1cUWOGaVRnCaU7EquOW62EK8XUje7mVDRiy6cciCcwA0y2f1vZxiyly4Z
         10ar4tMyDrRV2UUO9xNbuzfMsFoCnQdpqfJRJB5sWHv5iWApX8793SyRbVBotSPzIkPw
         Ww2JKX5fi4cjlhfQ+wSmR1Nl3OhWiWDLbfm2IIVhU92aNpFjPxLGM28TvA70rC/5K8Qw
         uHVCTbWe6heX1ho8JiNJocpvO/gYlkwlhAdJ+feHKyNshO7bMwQIVNgBRbD+7Ff2cnZy
         4+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022793; x=1794627593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UIOAF3kdDXl+yPrD+9p69Av+Bk03hMFkvgvp9BXLD84=;
        b=oiUFxAwlrLXPU76hHuy1J4JtrLa3lJh5Sm9mfcyFjzs8c8KqV2vVz/aJInWVOCMxVe
         VmIMS7dcXH9xEOpFuOcGhK+ayF7JUifsNJXQEWethdy95RY8wjWz4CQchkl2Ypb2/CTQ
         hAmlo4YyEFlCQYw3qQ68U6vDEGMZqi8Ww8tDHJPPcGHgKjRrNmG3T1AwJHgSprMJ4wt2
         TQFqE+SQgPPHMug/MnyuaBl7a0Eun/RZFr3CuPmeLrZ3A017KVoBzZz4PZ7wwSKQ2q0Q
         FCGKp5qhoA5ajor0CmskhdfXLfHaCqTsscipdwwuOuB7qxDhsUmxPxm5c+w6h+BvYq+p
         OsMQ==
X-Gm-Message-State: APuU4Z+Fxmz89yOrMl66Zn/gTVSwx4VfZIP7MKOzf0VzGnDoKJrsSKNt
	oyloAjJH73hUVwfGWuKsD+j+9gKsIYSNpIvnP47jrui+pcXD0P7rtVmYVNATdw==
X-Gm-Gg: AYBFou3w7PEwmxiYaXogglJmsDhfgoqAH00mBOOKMkYbCCGMiSvIiPjcZC2yupbff2G
	r2dbIEg1kuE+buR95JTgmkGlFWTYGPqKkgNhz5MfwoGJZJrBv6Q/ifirM1ADna7zolnfFb/Dodd
	WvNAxJcwElg3lXoonDfOlxQ7/vVoVSaDTAKWuy/uC7daPvPqMeD6KzDlukb0sLtRUiuPKaksEsc
	N+fCX0OU3LlpqQvCRWGeTtzHrhTnkqtEK8mv25eQyT9t6Jewlj9i9iKf2eiM5K/vJ/xR1rURojl
	h42hRskKIw3cqk1WpOyV1DgdY6k7wE6KSi6N5pb1djofYhY4FGqBwPKc36IKocwgMIrbGr5yupu
	Qi6hatjeZuOvj5QlVnaG/9Z4WyxG1RLg3C798YMNzhr7w7WAB9wmrN2UIXSDSP+Xkomvf8qz4Bm
	EdVCCS+yI2T78/UG0Orh5f7Po3ESqwo56XPPtXP0mHOeUBzP7aDCmLLJpVLLKQSYR6HvizZ/2Wq
	RnkDAod5jLMkhWj63t3Q4bdLh6HoY1FFCQbdM5VbtkoTZwmzmQ9k/NyGblEaoG/V3CK8vFO5Mve
	yPF0EXx5MDWlcs4Lf7IhTXGfnBV/wMHP3AOmMZtB23Fj0OjVfs+johDXSg85WiwiTSLrfdRNi/W
	YW3b7vafGjBKpQV2iIWK2OZgG9u5vjbobOkddHp2+bViUHSGw5KWffByXdH7yjXYAX+lTATm5xQ
	==
X-Received: by 2002:a17:90b:3e4f:b0:3ac:adce:60a8 with SMTP id 98e67ed59e1d1-3b0db6218c8mr5130608a91.5.1794022792049;
        Fri, 06 Nov 2026 19:39:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585df83sm1437592a91.16.2026.11.06.19.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:39:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 18/46] bpf: Tell the passes over the graph where an added may_goto goes
Date: Sat,  7 Nov 2026 03:37:26 +0000
Message-ID: <20261107033758.1547725-19-alexei.starovoitov@gmail.com>
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

A spin lock in Rust, test atomic_spin_lock of rust-bpf:

  for _ in 0..n {
      while lock.compare_exchange_weak(...).is_err() { spin_loop(); }
      data += 1; lock.store(false, Release);
  }

The compiler makes one loop with two back edges. No jump that leaves the
loop is in each iteration. Today: "infinite loop detected at insn 41". The
only place for may_goto that each iteration passes is the head. Its target
is an exit of all loops around it. 142 of the 225 progs of the schedulers
of rust-bpf have such a loop. The prog has no edge from the head to the
exit. The main pass verifies the state that goes there, but it relies on
passes that see only the control flow graph:

  bpf_compute_const_regs()  r7 == &ro on all edges to the exit, &rw at the
                            head. 'for (i = 0; i < *r7; i++)' behind the
                            exit gets its count from ro.
  compute_subprog_args()    The same with fp-8, fp-16: a store through r7.
  live registers            What the loop sets on each path to the exit is
                            dead at the head: a read behind it is rejected.

Thus call bpf_flow_place_guards() directly after the loops are known. No
constant is known at the target. compute_subprog_args() joins what it knows
at the head into the target. What is live at the target is live at the
head, may_goto or not: r1 in compute_live_registers/may_goto.

  do { ..; more = ++i < 256 && v->in[i & 63]; 10 insns; } while (more);
clang keeps the flag: 'if w6 > 255' sets it and stays in the loop. Today's
bpf_edge_leaves_loop() loses it at 'w1 &= 1': no count, 15611 insns, and
"R7 unbounded memory access" with one state for all iterations. Ask once,
for all edges: with which number in which register is the loop sure to be
left from this insn on? bpf_compute_leave_conds() goes against the edges:

  if w1 != 0 goto head   w1 is 0      does not go to the head
  w1 &= 1                w1 is even   what the insn turns into 0
  l: ..                  w1 is even   nothing writes w1
  w1 = 1                 never        1 is not even

An edge leaves the loop if the constants at its jump meet the condition at
its target: w1 is 0 at 'if w6 > 255 goto l'. 86 insns. Each insn has one
turn. A condition is a set of numbers per register. const_fold.c tells what
an insn makes of a number. Its constants must know the added edges.
A nested loop is not entered: may_goto there goes where a jump of that loop
goes, whatever the constants say.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |   8 +
 kernel/bpf/const_fold.c                       | 264 +++++++++++++++++-
 kernel/bpf/liveness.c                         |  41 ++-
 kernel/bpf/loops.c                            | 145 ++++------
 kernel/bpf/scev.c                             |  12 +-
 kernel/bpf/verifier.c                         |  15 +
 .../bpf/progs/compute_live_registers.c        |   8 +-
 .../selftests/bpf/progs/verifier_loop_latch.c |   6 +-
 8 files changed, 387 insertions(+), 112 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6745c92ad586..42499a6f7e96 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -817,6 +817,8 @@ struct bpf_backedge {
 	 */
 	int latches[MAX_LATCHES];
 	u8 latches_cnt;
+	/* bit k: the loop is left on the edge of latches[k] that is taken, not on the other one */
+	u8 taken_leaves;
 };
 
 struct bpf_loop_exit {
@@ -934,6 +936,8 @@ struct bpf_insn_aux_data {
 	u64 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
 	u64 guard_edge_dropped:1; /* an edge of may_goto from here was dropped */
 	u64 need_scev:1;
+	/* a jump in a loop: the edge that is not taken, bit 0, or the other one leaves the loop */
+	u64 edge_leaves:2;
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
 	 * pattern for a bpf_fastcall call.
@@ -1483,6 +1487,8 @@ struct bpf_verifier_env {
 	struct bpf_iarray *succ;
 	struct bpf_iarray *gotox_tmp_buf;
 	int *idoms;
+	/* per insn, while bpf_compute_leave_conds() runs */
+	struct bpf_leave_cond *leave_conds;
 	struct scev *scev;
 	struct bpf_flow *flow;
 	struct bpf_join_state *join;
@@ -1718,7 +1724,9 @@ u16 bpf_call_const_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_insn_is_iter_next(struct bpf_verifier_env *env, struct bpf_insn *insn);
 bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
+int bpf_compute_leave_conds(struct bpf_verifier_env *env);
 bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
+int bpf_find_latches(struct bpf_verifier_env *env, bool flags);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index eac2bf80274c..d01d0cc0dde5 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -250,7 +250,7 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 	struct const_arg_info ci_out[MAX_BPF_REG];
 	struct bpf_iarray *succ;
 	bool changed;
-	int i, r;
+	int i, r, t;
 
 	/* kvzalloc zeroes memory, so all entries start as CONST_ARG_UNVISITED (0) */
 	ci_in = kvzalloc_objs(*ci_in, insn_cnt, GFP_KERNEL_ACCOUNT);
@@ -264,6 +264,12 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 		for (r = 0; r < MAX_BPF_REG; r++)
 			ci_in[start][r] = unknown;
 	}
+	/* The same from the head of a loop to where the loop is left, once the loops are known. */
+	for (i = 0; i < insn_cnt; i++) {
+		t = bpf_head_guard_target(env, i);
+		for (r = 0; r < MAX_BPF_REG && t >= 0; r++)
+			ci_in[t][r] = unknown;
+	}
 
 redo:
 	changed = false;
@@ -344,6 +350,262 @@ static int eval_const_branch(u8 opcode, u64 dst_val, u64 src_val)
 	}
 }
 
+/* 1: the registers @ci take the conditional jump @insn, 0: they don't, -1: not known */
+static int const_branch_taken(const struct bpf_insn *insn, const struct const_arg_info *ci)
+{
+	u64 dst = ci[insn->dst_reg].val, src = insn->imm;
+
+	if (!ci_is_const(&ci[insn->dst_reg]))
+		return -1;
+	if (BPF_SRC(insn->code) == BPF_X) {
+		if (!ci_is_const(&ci[insn->src_reg]))
+			return -1;
+		src = ci[insn->src_reg].val;
+	}
+	/* see bpf_prune_dead_branches() */
+	if (BPF_CLASS(insn->code) == BPF_JMP32) {
+		dst = (s32)dst;
+		src = (s32)src;
+	}
+	return eval_const_branch(insn->code, dst, src);
+}
+
+/*
+ * When is the program that stands in front of an insn of a loop sure to leave the loop?
+ * Always, or when one register holds a number of a set, whatever the other registers hold.
+ * A set has one bit per range of numbers of 32 bits. A flag is a small number: each of 0 - 31
+ * is a range. An error code or a size is not: 32 - 63, 64 - 127, ... are the other ranges.
+ */
+struct bpf_leave_cond {
+	u64 vals[MAX_BPF_REG];
+	bool always;
+};
+
+#define LEAVE_SMALL	32
+#define LEAVE_RANGES	(LEAVE_SMALL + 32 - ilog2(LEAVE_SMALL))
+
+static const struct bpf_leave_cond leave_never;
+static const struct bpf_leave_cond leave_always = {
+	.vals = { [0 ... MAX_BPF_REG - 1] = U64_MAX },
+	.always = true,
+};
+
+static u64 leave_val_bit(u64 val)
+{
+	if (val > U32_MAX)
+		return 0;
+	return BIT_ULL(val < LEAVE_SMALL ? val : ilog2(val) + LEAVE_SMALL - ilog2(LEAVE_SMALL));
+}
+
+/* The condition for the loop at @h in front of @t, where an insn of that loop goes on */
+static const struct bpf_leave_cond *leave_cond_at(struct bpf_verifier_env *env, int h, int t)
+{
+	int l = bpf_loop_at_index(env, t);
+
+	if (l != h)
+		return bpf_is_nested_loop(env, l, h) ? &leave_never : &leave_always;
+	return t == h || !env->leave_conds ? &leave_never : &env->leave_conds[t];
+}
+
+/* The same when the jump at @n goes on at @t: always, if the constants at @n meet it */
+static const struct bpf_leave_cond *leave_cond_edge(struct bpf_verifier_env *env, int h, int n,
+						    int t)
+{
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[n];
+	const struct bpf_leave_cond *p = leave_cond_at(env, h, t);
+	int r;
+
+	for (r = 0; r < ARRAY_SIZE(aux->const_reg_vals); r++)
+		if ((aux->const_reg_mask & BIT(r)) &&
+		    (p->vals[r] & leave_val_bit(aux->const_reg_vals[r])))
+			return &leave_always;
+	return p;
+}
+
+/* Is what the insn at @idx makes of @reg == @val in the set @vals? @ci: nothing is known. */
+static bool insn_makes(struct bpf_verifier_env *env, struct const_arg_info *ci, int idx,
+		       int reg, u64 val, u64 vals)
+{
+	struct const_arg_info unknown = { .state = CONST_ARG_UNKNOWN, .val = 0 };
+	struct bpf_insn *insns = env->prog->insnsi;
+	struct const_arg_info *dst = &ci[insns[idx].dst_reg];
+	bool ret;
+
+	if (reg >= 0) {
+		ci[reg].state = CONST_ARG_CONST;
+		ci[reg].val = val;
+	}
+	const_reg_xfer(env, ci, &insns[idx], insns, idx);
+	ret = ci_is_const(dst) && (vals & leave_val_bit(dst->val));
+	*dst = unknown;
+	if (reg >= 0)
+		ci[reg] = unknown;
+	return ret;
+}
+
+/* @p holds behind the insn at @idx. Make it what holds in front of it. */
+static void leave_cond_insn(struct bpf_verifier_env *env, int idx, struct bpf_leave_cond *p)
+{
+	struct bpf_insn *insns = env->prog->insnsi, *insn = &insns[idx];
+	int r, v, dst = insn->dst_reg, src = insn->src_reg;
+	struct const_arg_info ci[MAX_BPF_REG] = {};
+	u8 class = BPF_CLASS(insn->code);
+	u64 vals;
+
+	/* Nothing is known about a register that is no constant although all were constants */
+	for (r = 0; r < MAX_BPF_REG; r++)
+		ci[r].state = CONST_ARG_CONST;
+	const_reg_xfer(env, ci, insn, insns, idx);
+	for (r = 0; r < MAX_BPF_REG; r++) {
+		if (!ci_is_const(&ci[r]))
+			p->vals[r] = 0;
+		ci[r].state = CONST_ARG_UNKNOWN;
+	}
+	if ((class != BPF_ALU && class != BPF_ALU64 && class != BPF_LD) ||
+	    dst >= MAX_BPF_REG || !p->vals[dst])
+		return;
+	vals = p->vals[dst];
+	p->vals[dst] = 0;
+	if (insn_makes(env, ci, idx, -1, 0, vals)) {
+		*p = leave_always;
+		return;
+	}
+	for (v = 0; v < LEAVE_SMALL && class != BPF_LD; v++) {
+		if (insn_makes(env, ci, idx, dst, v, vals))
+			p->vals[dst] |= BIT_ULL(v);
+		if (BPF_SRC(insn->code) == BPF_X && src != dst && src < MAX_BPF_REG &&
+		    insn_makes(env, ci, idx, src, v, vals))
+			p->vals[src] |= BIT_ULL(v);
+	}
+}
+
+/*
+ * const_branch_taken() for all of @lo - @hi in the register that @insn compares with a number.
+ * The range has numbers of 32 bits of one sign. So '<' and the like treat all of them alike
+ * if they treat both ends alike. '==' and '!=' single out the number that they compare with.
+ * '&': @lo is the bit that all of them have, @hi has the bits that any of them has.
+ */
+static int range_branch_taken(const struct bpf_insn *insn, struct const_arg_info *ci, u64 lo,
+			      u64 hi)
+{
+	u64 vals[] = { lo, hi, clamp_t(u64, (u32)insn->imm, lo, hi) };
+	int i, taken[ARRAY_SIZE(vals)];
+
+	for (i = 0; i < ARRAY_SIZE(vals); i++) {
+		ci[insn->dst_reg].val = vals[i];
+		taken[i] = const_branch_taken(insn, ci);
+	}
+	return taken[0] == taken[1] && taken[0] == taken[2] ? taken[0] : -1;
+}
+
+/*
+ * @p is what is enough on both edges of the jump at @idx. If the jump compares a register
+ * with a number then a number in the register goes one way: enough on that edge is enough.
+ */
+static void leave_cond_jump(struct bpf_verifier_env *env, int h, int idx,
+			    struct bpf_leave_cond *p)
+{
+	struct bpf_insn *insn = &env->prog->insnsi[idx];
+	struct const_arg_info ci[MAX_BPF_REG] = {};
+	u64 t, f, lo, go = 0, stay = 0;
+	int i, taken;
+
+	if (BPF_SRC(insn->code) != BPF_K)
+		return;
+	t = leave_cond_edge(env, h, idx, idx + insn->off + 1)->vals[insn->dst_reg];
+	f = leave_cond_edge(env, h, idx, idx + 1)->vals[insn->dst_reg];
+	if (t == f)
+		return;
+	ci[insn->dst_reg].state = CONST_ARG_CONST;
+	for (i = 0; i < LEAVE_RANGES; i++) {
+		lo = i < LEAVE_SMALL ? i : BIT_ULL(i - LEAVE_SMALL + ilog2(LEAVE_SMALL));
+		taken = range_branch_taken(insn, ci, lo, i < LEAVE_SMALL ? lo : 2 * lo - 1);
+		if (taken > 0)
+			go |= BIT_ULL(i);
+		else if (!taken)
+			stay |= BIT_ULL(i);
+	}
+	p->vals[insn->dst_reg] |= (t & go) | (f & stay);
+}
+
+/*
+ * A compiler makes
+ *	w1 = 0; if w7 > 255 goto l; ...; w1 = 1; l: ...; w1 &= 1; if w1 != 0 goto head;
+ * of 'do { ...; more = ++i < 256 && ...; ...; } while (more);'. The jump that leaves the loop
+ * looks at 1 or 0. The jump that counts stays in the loop on both edges.
+ *
+ * So find for every insn of a loop when the loop is left from there on. Go against the edges:
+ *	if w1 != 0 goto head	w1 is 0		the numbers that don't go to the head
+ *	w1 &= 1			w1 is even	the numbers that the insn turns into 0
+ *	l: ...			w1 is even	nothing writes w1
+ *	w1 = 1			never		1 is not even
+ * w1 is 0 at the jump that counts and 0 is even: the edge to l leaves the loop.
+ *
+ * An insn that is not in the loop: always. The head: never. More than one successor: what is
+ * enough for each of them. Every insn has one turn, in post order. A cycle without the head is
+ * a nested loop, so the successors in the loop itself had their turn. One that didn't: never.
+ * The jumps on the way know constants too: 'r7 = 0; if w1 != 0 goto a; ...; a: if r7 == 2 goto
+ * head' leaves the loop when w1 is not 0.
+ *
+ * Every edge that the program has at run time counts, the edges of may_goto that the verifier
+ * adds too. May_goto of the loop and of the loops around it leaves the loop. A nested loop can
+ * get one in front of a jump that the numbers decide the other way. So a nested loop: never.
+ *
+ * What is kept is the answer for the two edges of each jump: insn_aux_data->edge_leaves.
+ */
+int bpf_compute_leave_conds(struct bpf_verifier_env *env)
+{
+	const struct bpf_leave_cond *q;
+	struct bpf_leave_cond *p;
+	struct bpf_iarray *succ;
+	int i, r, s, h, idx;
+	bool jump;
+	u64 any;
+
+	env->leave_conds = kvcalloc(env->prog->len, sizeof(*p), GFP_KERNEL_ACCOUNT);
+	if (!env->leave_conds)
+		return -ENOMEM;
+	for (i = 0; i < env->cfg.cur_postorder; i++) {
+		idx = env->cfg.insn_postorder[i];
+		h = bpf_loop_at_index(env, idx);
+		if (h < 0)
+			continue;
+		p = &env->leave_conds[idx];
+		*p = leave_always;
+		jump = bpf_insn_is_cond_jump(env->prog->insnsi[idx].code);
+		succ = bpf_insn_successors(env, idx);
+		iarray_for_each(s, succ) {
+			q = jump ? leave_cond_edge(env, h, idx, s) : leave_cond_at(env, h, s);
+			for (r = 0; r < MAX_BPF_REG; r++)
+				p->vals[r] &= q->vals[r];
+			p->always &= q->always;
+			if (jump && q->always)
+				env->insn_aux_data[idx].edge_leaves |= BIT(s != idx + 1);
+		}
+		if (jump) {
+			leave_cond_jump(env, h, idx, p);
+			continue;
+		}
+		for (r = 0, any = 0; r < MAX_BPF_REG; r++)
+			any |= p->vals[r];
+		if (any && !p->always)
+			leave_cond_insn(env, idx, p);
+	}
+	kvfree(env->leave_conds);
+	env->leave_conds = NULL;
+	return 0;
+}
+
+/*
+ * Does the program leave the loop at @h when the conditional jump at @n goes on at @t?
+ * @h is the innermost loop around @n.
+ */
+bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t)
+{
+	return leave_cond_at(env, h, t)->always ||
+	       (env->insn_aux_data[n].edge_leaves & BIT(t != n + 1));
+}
+
 /*
  * Rewrite conditional branches with constant outcomes into unconditional
  * jumps using register values resolved by bpf_compute_const_regs() pass.
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 525c0faff1a6..6a2ee407412b 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -1054,6 +1054,22 @@ static bool arg_track_join(struct bpf_verifier_env *env, int idx, int target, in
 	return true;
 }
 
+/* What leaves @idx gets to @target */
+static bool arg_track_join_all(struct bpf_verifier_env *env, int idx, int target,
+			       struct arg_track *in, struct arg_track *stack_in,
+			       const struct arg_track *out, const struct arg_track *stack_out,
+			       u32 nslots)
+{
+	bool changed = false;
+	int r;
+
+	for (r = 0; r < MAX_AT_TRACK_REGS; r++)
+		changed |= arg_track_join(env, idx, target, r, &in[r], out[r]);
+	for (r = 0; r < nslots; r++)
+		changed |= arg_track_join(env, idx, target, -r - 1, &stack_in[r], stack_out[r]);
+	return changed;
+}
+
 /*
  * Compute the result when an ALU op destroys offset precision.
  * If a single arg is identifiable, preserve it with OFF_IMPRECISE.
@@ -2069,6 +2085,7 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		int i = idx - start;
 		struct bpf_insn *insn = &insns[idx];
 		struct bpf_iarray *succ;
+		int ti;
 
 		if (!arg_is_visited(&at_in[i][0]) && !arg_is_visited(&at_in[i][1]))
 			continue;
@@ -2076,6 +2093,12 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		memcpy(at_out, at_in[i], sizeof(at_out));
 		memcpy(at_stack_out, &at_stack_in[(size_t)i * nslots], nslots * sizeof(*at_stack_out));
 
+		ti = bpf_head_guard_target(env, idx) - start;
+		if (ti >= 0)
+			changed |= arg_track_join_all(env, idx, start + ti, at_in[ti],
+						      &at_stack_in[(size_t)ti * nslots],
+						      at_out, at_stack_out, nslots);
+
 		arg_track_xfer(env, insn, idx, at_out, at_stack_out, nslots,
 			       at_stack_arg_entry, instance, callsites);
 		arg_track_log(env, insn, idx, at_in[i], &at_stack_in[(size_t)i * nslots], at_out,
@@ -2085,21 +2108,14 @@ static noinline_for_stack int compute_subprog_args(struct bpf_verifier_env *env,
 		succ = bpf_insn_successors(env, idx);
 		for (int s = 0; s < succ->cnt; s++) {
 			int target = succ->items[s];
-			int ti;
 
 			/* Filter: stay within the subprogram's range */
 			if (target < start || target >= end)
 				continue;
 			ti = target - start;
-
-			for (r = 0; r < MAX_AT_TRACK_REGS; r++)
-				changed |= arg_track_join(env, idx, target, r,
-							  &at_in[ti][r], at_out[r]);
-
-			for (r = 0; r < nslots; r++)
-				changed |= arg_track_join(env, idx, target, -r - 1,
-							  &at_stack_in[(size_t)ti * nslots + r],
-							  at_stack_out[r]);
+			changed |= arg_track_join_all(env, idx, target, at_in[ti],
+						      &at_stack_in[(size_t)ti * nslots],
+						      at_out, at_stack_out, nslots);
 		}
 	}
 	if (changed)
@@ -2780,6 +2796,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			u32 new_out = 0;
 			u32 new_in = 0;
 			u32 use;
+			int t;
 
 			succ = bpf_insn_successors(env, insn_idx);
 			for (int s = 0; s < succ->cnt; ++s)
@@ -2794,6 +2811,10 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 				use |= state[insn_idx + insns[insn_idx].imm + 1].in &
 				       mask_widen(GENMASK(BPF_REG_5, BPF_REG_1));
 			new_in = (new_out & ~live->def) | use;
+			/* may_goto that is added at the head of a loop goes there */
+			t = bpf_head_guard_target(env, insn_idx);
+			if (t >= 0)
+				new_in |= state[t].in;
 			if (new_out != live->out || new_in != live->in) {
 				live->in = new_in;
 				live->out = new_out;
diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
index 729e0055f86f..0f3b0411003b 100644
--- a/kernel/bpf/loops.c
+++ b/kernel/bpf/loops.c
@@ -304,73 +304,6 @@ int bpf_loop_at_index(struct bpf_verifier_env *env, u32 idx)
 	return aux[idx].loop ? idx : aux[idx].loop_header;
 }
 
-/* @known: the registers that hold the constant @val behind @insn. False: a jump or the like. */
-static bool track_consts(const struct bpf_insn *insn, u16 *known, s32 *val)
-{
-	u8 class = BPF_CLASS(insn->code);
-
-	if (class == BPF_ST || (class == BPF_STX && BPF_MODE(insn->code) == BPF_MEM))
-		return true;
-	/* r6 - r9 are what they were when the call returns */
-	if (insn->code == (BPF_JMP | BPF_CALL)) {
-		*known &= ~GENMASK(BPF_REG_5, BPF_REG_0);
-		return true;
-	}
-	if (class != BPF_ALU && class != BPF_ALU64 && class != BPF_LDX)
-		return false;
-	*known &= ~BIT(insn->dst_reg);
-	if (class != BPF_LDX && BPF_OP(insn->code) == BPF_MOV && BPF_SRC(insn->code) == BPF_K) {
-		*known |= BIT(insn->dst_reg);
-		val[insn->dst_reg] = insn->imm;
-	}
-	return true;
-}
-
-/*
- * Does the program leave the loop at @h when the conditional jump at @n goes on at @t?
- * It does when @t is not in the loop. A compiler also makes
- *	w2 = 1; if w1 == 0 goto l; w2 = 0; l: ...; if w2 != 1 goto head;
- * of 'while (n--)'. So follow the constants that are set next to the jump for as long as there
- * is one way to go.
- */
-bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t)
-{
-	struct bpf_insn *insns = env->prog->insnsi, *insn;
-	s32 val[MAX_BPF_REG];
-	u16 known = 0;
-	int i, l;
-	u8 op;
-
-	/* the insns in front of the jump, for as long as nothing else leads to the next one */
-	for (i = n; i && i > n - 4 && !env->insn_aux_data[i].loop && env->idoms[i] == i - 1; i--)
-		;
-	for (; i < n; i++)
-		if (!track_consts(&insns[i], &known, val))
-			known = 0;
-	for (i = 0; i < 16; i++, t++) {
-		l = bpf_loop_at_index(env, t);
-		if (l != h && !bpf_is_nested_loop(env, l, h))
-			return true;
-		insn = &insns[t];
-		op = BPF_OP(insn->code);
-		if (t == h) {
-			return false;
-		} else if (insn->code == (BPF_JMP | BPF_JA)) {
-			t += insn->off;
-		} else if (is_cond_jmp_insn(insn)) {
-			/* a 32-bit and a 64-bit jump agree on a number that is not negative */
-			if (!(known & BIT(insn->dst_reg)) || val[insn->dst_reg] < 0 ||
-			    BPF_SRC(insn->code) != BPF_K || (op != BPF_JEQ && op != BPF_JNE))
-				return false;
-			if ((val[insn->dst_reg] == insn->imm) == (op == BPF_JEQ))
-				t += insn->off;
-		} else if (!track_consts(insn, &known, val)) {
-			return false;
-		}
-	}
-	return false;
-}
-
 /*
  * Collect conditional jumps within n's loop that dominate 'n' and leave
  * the loop on one edge, see bpf_edge_leaves_loop(), nearest first.
@@ -395,6 +328,8 @@ static void find_dominating_conditions(struct bpf_verifier_env *env, int n,
 			    (backedge->latches_cnt || bpf_jump_leaves_loop(env, n_loop, n))) {
 				if (backedge->latches_cnt == MAX_LATCHES)
 					return;
+				if (t_exits_loop)
+					backedge->taken_leaves |= BIT(backedge->latches_cnt);
 				backedge->latches[backedge->latches_cnt++] = n;
 			}
 		}
@@ -404,6 +339,55 @@ static void find_dominating_conditions(struct bpf_verifier_env *env, int n,
 	}
 }
 
+/*
+ * Without @flags: the jumps that leave a loop themselves. That tells where the verifier may add
+ * may_goto. It takes the constants that hold with these edges to follow a flag.
+ */
+int bpf_find_latches(struct bpf_verifier_env *env, bool flags)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	struct bpf_backedge *backedge;
+	struct bpf_loop *loop;
+	int i, j, k, err;
+
+	if (flags) {
+		err = bpf_compute_leave_conds(env);
+		if (err)
+			return err;
+	}
+	for (i = 0; i < env->prog->len; i++) {
+		loop = aux[i].loop;
+		if (!loop)
+			continue;
+		for (j = 0; j < loop->backedges_cnt; j++) {
+			backedge = &loop->backedges[j];
+			backedge->latches_cnt = 0;
+			backedge->taken_leaves = 0;
+			/*
+			 * In theory, the backedge->from and it's latch can reside in
+			 * an inner loop of `i`, e.g.:
+			 *
+			 *  1:  r7 += 1;
+			 *  2:  r6 += 1;
+			 *      if r7 == 2 goto 1b;
+			 *      if r6 < 2 goto 2b;
+			 *
+			 * For now, let's assume that latches are unknown for such cases.
+			 * (GCC/LLVM handle this by inserting artificial cfg nodes).
+			 */
+			if (bpf_loop_at_index(env, backedge->from) != i)
+				continue;
+			find_dominating_conditions(env, backedge->from, backedge);
+			for (k = 1; k < backedge->latches_cnt; k++)
+				if ((env->log.level & BPF_LOG_LEVEL2) &&
+				    !bpf_jump_leaves_loop(env, i, backedge->latches[k]))
+					bpf_log(&env->log, "loop at %d, exit by way of a flag at %d\n",
+						i, backedge->latches[k]);
+		}
+	}
+	return 0;
+}
+
 /*
  * As described in "A New Algorithm for Identifying Loops in Decompilation" by Wei et al,
  * adapted to be non-recursive.
@@ -572,30 +556,9 @@ int bpf_compute_loops(struct bpf_verifier_env *env)
 		if (err)
 			goto out;
 	}
-	/* find latches */
-	for (i = 0; i < len; i++) {
-		loop = aux[i].loop;
-		if (!loop)
-			continue;
-		for (j = 0; j < loop->backedges_cnt; j++) {
-			backedge = &loop->backedges[j];
-			/*
-			 * In theory, the backedge->from and it's latch can reside in
-			 * an inner loop of `i`, e.g.:
-			 *
-			 *  1:  r7 += 1;
-			 *  2:  r6 += 1;
-			 *      if r7 == 2 goto 1b;
-			 *      if r6 < 2 goto 2b;
-			 *
-			 * For now, let's assume that latches are unknown for such cases.
-			 * (GCC/LLVM handle this by inserting artificial cfg nodes).
-			 */
-			if (bpf_loop_at_index(env, backedge->from) != i)
-				continue;
-			find_dominating_conditions(env, backedge->from, backedge);
-		}
-	}
+	err = bpf_find_latches(env, false);
+	if (err)
+		goto out;
 	/* find exits */
 	for (i = 0; i < len; i++) {
 		iloop = aux[i].loop ? i : aux[i].loop_header;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 9629a6bf80b1..d62e087f811d 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2101,13 +2101,12 @@ static bool loop_invariant(struct scev *scev, u32 id)
 
 static int match_linear_latch(struct bpf_verifier_env *env,
 			      u32 header,
-			      u32 latch_idx,
+			      u32 latch_idx, bool taken_leaves,
 			      struct linear_latch *latch)
 {
 	struct bpf_insn *insn = &env->prog->insnsi[latch_idx];
 	struct scev *scev = env->scev;
 	struct env *latch_env;
-	u32 true_branch_tgt;
 	u32 src_reg_scev;
 	u32 dst_reg_scev;
 	u32 t, l, r, op;
@@ -2116,8 +2115,7 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	op = BPF_OP(insn->code);
 	latch->jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 	/* Flip the condition if true branch jumps out of the loop. */
-	true_branch_tgt = latch_idx + bpf_jmp_offset(insn) + 1;
-	if (bpf_edge_leaves_loop(env, header, latch_idx, true_branch_tgt))
+	if (taken_leaves)
 		op = bpf_rev_opcode(op);
 	switch (op) {
 	case BPF_JSLT:
@@ -3347,7 +3345,8 @@ static int count_backedge(struct bpf_verifier_env *env, struct bpf_func_state *s
 
 	for (j = 0; j < backedge->latches_cnt; j++) {
 		latch_idx = backedge->latches[j];
-		linear_latch = match_linear_latch(env, insn_idx, latch_idx, &latch);
+		linear_latch = match_linear_latch(env, insn_idx, latch_idx,
+						  backedge->taken_leaves & BIT(j), &latch);
 		if (linear_latch < 0)
 			return linear_latch;
 		if (!linear_latch) {
@@ -3363,6 +3362,9 @@ static int count_backedge(struct bpf_verifier_env *env, struct bpf_func_state *s
 					insn_idx, latch_idx);
 			continue;
 		}
+		/* a flag can have other reasons to end the loop */
+		if (!bpf_jump_leaves_loop(env, insn_idx, latch_idx))
+			tmp.min_header_count = 0;
 		if (!found || tmp.max_header_count < iters->max_header_count) {
 			iters->max_header_count = tmp.max_header_count;
 			iters->iv_reg = tmp.iv_reg;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5faea922699a..62a58f38f4e2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -25268,6 +25268,21 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	/*
+	 * It took the constants to remove dead branches and find the loops. Now it's known
+	 * which edges the verifier may add, see bpf_head_guard_target(). What follows
+	 * believes the constants.
+	 */
+	ret = bpf_flow_place_guards(env);
+	if (ret > 0)
+		ret = bpf_compute_const_regs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
+	ret = bpf_find_latches(env, true);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret = bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b/tools/testing/selftests/bpf/progs/compute_live_registers.c
index ba43304836ca..f5c505dfd464 100644
--- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
+++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
@@ -316,11 +316,15 @@ __naked void gotol(void)
 }
 #endif
 
+/*
+ * If the verifier had to add may_goto to this loop it would be at the head, insn 0, and go to
+ * insn 3. What is live at 3 is live at 0.
+ */
 SEC("socket")
 __log_level(2)
-__msg("0: .......... (b7) r1 = 1")
+__msg("0: .1........ (b7) r1 = 1")
 __msg("1: .1........ (e5) may_goto pc+1")
-__msg("2: .......... (05) goto pc-3")
+__msg("2: .1........ (05) goto pc-3")
 __msg("3: .1........ (bf) r0 = r1")
 __msg("4: 0......... (95) exit")
 __naked void may_goto(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index 1fcefce9ab01..6dd46edd8ed0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -130,17 +130,17 @@ LOOP(down_two_tests, "w8 = 4; r6 += 2043;",
 /* 'while (n--)': the jump that counts sets a flag, the jump that leaves the loop tests it */
 #define FLAG(mid)	"w8 += 1; w2 = 1; if w8 == 0 goto 2f; w2 = 0; 2: " mid " if w2 != 1 goto 1b;"
 
-OK("a flag", "2048")
+OK("a flag", "[0..2048]")
 LOOP(flag, "w8 = -2048;", FLAG("r3 = r6;"))
 
 BAD("a flag, one too many")
 LOOP(flag_bad, "w8 = -2049;", FLAG("r3 = r6;"))
 
-OK("a flag, a store behind it", "2048")
+OK("a flag, a store behind it", "[0..2048]")
 LOOP(flag_store, "w8 = -2048;",
      "w8 += 1; w2 = 1; *(u32 *)(r10 - 4) = r8; if w8 == 0 goto 2f; w2 = 0; 2: if w2 != 1 goto 1b;")
 
-OK("a flag, a call behind it", "2048")
+OK("a flag, a call behind it", "[0..2048]")
 LOOP(flag_call, "w8 = -2048;",
      "w8 += 1; w9 = 1; if w8 == 0 goto 2f; w9 = 0; 2: call %[bpf_get_prandom_u32]; if w9 != 1 goto 1b;")
 
-- 
2.55.0

