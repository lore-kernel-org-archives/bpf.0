Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299245;
	b=NguaR30EMrumQIoVDFO9BPDBXuisMhovRMriFiahsDKY0WpLFyYCy2wCkdhhHoj9K62H
	 RIogvi/9+Ax65tAlpHuECcKUGSLvstyLxz1f8w0REh7MDNBoi+BfzBOKlvHpPeo7RM2CX
	 /CjDg85PuVC5xe1R/170fnXxAZIiFKBnV+T6KoK6USOvTGZd5SgrcvI/KE1C7lWQv3gIN
	 D4tP99HuiIG4wCCIE6SGtsEHZDIY/QxbfFvWf4//CzQnf212hlNGXP+ZJ1eaeSt1AWgme
	 Uh5PrO3GDgNcLoAOACEzHLTzjtdz3cgx4cTaTl4O7qjMROIt/CXscFqwCOF8z2NEAeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/DNAEZOB/GOjHfmZ/dNLJS2nU/EC+1gv2qr/LXzWP9E=;
	b=OWxqYcQ24SX67OUFSsymTsN7LFpiH0Jqy3v64Zz63H0L2rKQ/UHnhpjbF9PPVk4y42qj
	 eb45xBoX2uT7ighfn/IvVNpYG8e4Vpl6R5tbaIQHSVTKQSoSis90CemiOx8e6U7g46AUp
	 P3KF69LcLu3I1KrwX9PTuBRjB9hTFArhi41pWTmQcWZkO/7Sqh0IMlicAXXSABHeGEd2x
	 yQPqgC5gpGmsJuA2X4t5SBFRP5JqZT1++KDZZIHGhHvfxIE3MXblcgnxk0HuWDTPIawjk
	 gJ7pCuv+XtJNtku9b09JStZTeEtGuKA/Q0SOHv+qOb/cbpwdJX+gj9pZiV5cVFf3riw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q++7gxW4;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE2606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EEE2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q++7gxW4
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so1269861a91.1
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299244; x=1795904044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DNAEZOB/GOjHfmZ/dNLJS2nU/EC+1gv2qr/LXzWP9E=;
        b=Q++7gxW4qWPVKYgXY65b82Mzx4q+oYxA57j7/bVMu1GAdNPVjqQmnO1WQPJ0U0U2KQ
         iLCpWmzCKED3M+iYeIMt/vX/YS2BuAYHbSdyYW2IKtKFSZM4FRqNgi6XFWbhdFQbZ+uN
         CnnULbunUTjWfexETny9FsQM46BA8NlrMt0pjQh4fffCd858K/FJzsXlcmmXCnpzZ8zQ
         s7iDRGFdFDfL6FFXhg3vwo4BeRxnUURBYwQRO95L8EkkyB3m3a2pwZhJDkxlEqwAV+zT
         Mj1f9ihQcyzNI52hy5PRQWACO2DRbZJ6G5tpEh8qzCkqMt8En4wSXGqJeKgkRItPALBa
         BeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299244; x=1795904044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/DNAEZOB/GOjHfmZ/dNLJS2nU/EC+1gv2qr/LXzWP9E=;
        b=AQVSVWlHvs/UGz1Bzu8m156W+qshZuOt7U+Dyw/HwOKlVAnU6gZmjB0FpTfpu+SCff
         +802c3HfFvL18sC5N/0TfJugb3QoieEkEmpdbO8jb9IlFKAgY+6Px8UVS1TVuRhHenAf
         FfTxIWM9W4zd7KDOe2SgYbcNbixNdfvObTGXD0gOzgycF2FYQZn0bv9uSoo+cgOJWZXj
         NmOkey88G9nxLZ8dDLmxork36EWelusbTQ0NkrrEGgXzAzajxCBZZ7ec0xD1XqXI7XnK
         9s7PFUvLAiSZkb207ife2nvur8+OZwHnDd2pjfSgWYH0oEwXIwjO52ERMqZg8TxFC4rU
         0k+Q==
X-Gm-Message-State: APuU4Z/oMUOv28Gg6rXbmHEsQb7SuGQ9ObyIDmMHTNN3jHoGrph6FUWc
	1yhiStu/D9DUoII5D0W+xcHkL3eghcmdgqmMyBlX4nY7WmkhAP+chidluqQc6A==
X-Gm-Gg: AZFdTZfAjiEHR7MJlPoK63EIoUnel1BUFoPIhSrJ3spg/RppTMRhxso8bOiBdnL2AOQ
	6iuQ74bWhbiAlRxl+eM4RyUG2KN4/em6tB1RTjz7OKIrlpg3w1oqQcJ6L0OqDDs41DXeu/j60xD
	rRgG6ryYCnU4KxT+xoHk9pmfP/K8sw1umEKQbkhcZsMfVmddgpjGql28SGHIEYrrfq7dZV+q0eg
	6rHj3hpnLRkeYWfzQ3hwVKmRv1gsCMHJNNauIYDyixYZHWZn6L2/gZmM4hiom136ppXolo8+6sN
	IPmFYUpECmeS4d1W4k4Gpun1FvGuaJuAFU08cXMmpEWBJw9jKpnib65y5KbSWCzNDxV7N5g1kIn
	GYMN/Jj2OTwotkehppq9/KsA0xosvObCU0hHSX/macGB9WC3bDlIAzdoKNTZ3DAntEoDf0JgsjD
	1YqjvKN7FnLMspeaCqPhnT4cg7dRWWIGBqLobHdQwfa1W12k1OcIxmN450VedJ6H6LDK4TUTp93
	2LQByHaPFQZJs6BNBSEQ2WbvFgSYSP2CfllxSR6ePtlxOH1AVxGdLlvQTW0tutQUN8Wm6pl6Rdv
	Gg/XWfmkDF0dEtVPK3Nj5SGDJnq2uPIFZ3x2FgiLObbkOuEQwSh41646OGj5yAq8nOtb+aFMhEg
	+cBJoz/pNy3IUqIabGsA3qDqFVNVwSpOis2f8r1AUDI64YQSAlk8xYTgtNZQcVW8B53b1EAgcwg
	==
X-Received: by 2002:a17:90b:3fc7:b0:3a8:5cab:1009 with SMTP id 98e67ed59e1d1-3b41cafe282mr6656842a91.46.1795299244184;
        Sat, 21 Nov 2026 14:14:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe23sm9767142a91.15.2026.11.21.14.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:14:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 3/7] bpf: Mark a skip of trips as a guess if a 32-bit value wraps
Date: Sat, 21 Nov 2026 22:13:40 +0000
Message-ID: <20261121221344.3958866-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
References: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
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

A valid program can be rejected. No unsafe program is accepted, because
the path-sensitive run accepts nothing.

After a pass with an error, the run looks for one path to the error.
It skips trips of a loop: it adds step * trips to each xreg that moves.
It adds in 64 bits, but a 32-bit insn wraps:

  r7 = 0;
  for (i = 0; i < 100; i++) {
          x = r7;
          if (!flag) w7 += 0x4000000;
  }
  if (!flag) buf[x - 0x8c000000];

If flag is 0, x is 0x8c000000 after the loop. The skip gives
0x18c000000. No path has this value, but the access to buf fails with
it. The error counts as real, so the budget of the next passes is cut.
If the program needs more than that budget, it is rejected.

If the skip moves a number past a multiple of 2^31, a 32-bit insn can
wrap. If such an insn writes an xreg that the skip moves, and the upper
half is live, mark the skip as a guess. A guess does not cut the budget.

The test sees the values at the header. It can miss a wrap if a 64-bit
insn adds to the result in the same trip: 'w7 += 1; r7 += 5'. Such a
program is handled as before.

Fixes: a46de5d64e18 ("bpf: Reproduce an error on one path, with no joins")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/equation_join.c   | 45 ++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c        |  5 ++--
 3 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 88b3a5226c..942629cc49 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2593,7 +2593,7 @@ void bpf_collect_iv_thresholds(struct bpf_verifier_env *env);
 int bpf_guess_first_trips(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			  struct bpf_loop *loop);
 bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
-			    const unsigned long *iv_xregs, bool infinite);
+			    const unsigned long *iv_xregs, bool infinite, u64 factor);
 void bpf_fast_forward_xregs(struct bpf_verifier_env *env, const struct bpf_verifier_state *old,
 			    struct bpf_verifier_state *cur, u64 factor, unsigned long *iv_xregs);
 
diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index 339562ba17..fd145c17e5 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -828,24 +828,27 @@ static u32 slot_of_insn(struct bpf_verifier_env *env, const struct bpf_insn *ins
 	return 0;
 }
 
-/* If the operand has a constant step, the result has one too. @prev: in the same block. */
+/*
+ * If the operand has a constant step, the result has one too. @prev: in the same block.
+ * @wraps: the low 32 bits of the result can wrap.
+ */
 static bool keeps_constant_step(const struct bpf_insn *insn, const struct bpf_insn *prev,
-				bool infinite)
+				bool wraps)
 {
 	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
 
 	if (bpf_is_ldimm64(insn))
 		return true;
-	if (class != BPF_ALU64 && (class != BPF_ALU || infinite))
+	if (class != BPF_ALU64 && (class != BPF_ALU || wraps))
 		return false;
 	if (op == BPF_MOV)
-		return !insn->off || (!infinite && insn->off == 32);
+		return !insn->off || (!wraps && insn->off == 32);
 	if (BPF_SRC(insn->code) == BPF_X)
 		return false;
 	if (op == BPF_ADD || op == BPF_SUB)
 		return true;
 	/* x <<= 32; x >>= 32; */
-	return !infinite && insn->imm == 32 &&
+	return !wraps && insn->imm == 32 &&
 	       (op == BPF_LSH || ((op == BPF_RSH || op == BPF_ARSH) && prev && prev->imm == 32 &&
 				  prev->code == (BPF_ALU64 | BPF_LSH | BPF_K) &&
 				  prev->dst_reg == insn->dst_reg));
@@ -864,6 +867,26 @@ static u64 step_of_xreg(struct bpf_verifier_env *env, const struct loop_stack_en
 	       bpf_find_var_bounds(env, &entry->header_state->st, xreg, &is_ptr)->r64.base;
 }
 
+/* An xreg of @xregs passes a multiple of 2^31 if it moves @factor times as far */
+static bool skip_wraps(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
+		       const unsigned long *xregs, u64 factor)
+{
+	u64 off, end;
+	struct cnum64 x;
+	bool is_ptr;
+	u32 n;
+
+	for_each_set_bit(n, xregs, MAX_BPF_XREG) {
+		x = bpf_find_var_bounds(env, env->cur_state,
+					bpf_xreg(env->cur_state->curframe, n), &is_ptr)->r64;
+		off = step_of_xreg(env, entry, xregs, n) * factor;
+		end = x.base + x.size;
+		if (!is_ptr && ((x.base ^ (x.base + off)) | (end ^ (end + off))) >> 31)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Two trips gave the steps. Does each trip add the same constant to the operands of the jump on
  * the iv, and to @iv_xregs? The code shows it, or a pass saw it at the header.
@@ -871,9 +894,10 @@ static u64 step_of_xreg(struct bpf_verifier_env *env, const struct loop_stack_en
  *	sum += i; x = n / i;		no
  *	a = b; b = 0;			no, if a moved and b did not
  * @infinite: above 2^32 trips. Only the jump counts, and 32-bit insns wrap.
+ * @factor: of the skip. If a 32-bit insn wraps in it, the upper half of its result has no step.
  */
 bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stack_entry *entry,
-			    const unsigned long *iv_xregs, bool infinite)
+			    const unsigned long *iv_xregs, bool infinite, u64 factor)
 {
 	const struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	const struct bpf_insn *insn, *prev = NULL;
@@ -883,11 +907,12 @@ bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stac
 	u16 new_step = 0;	/* the last write in this basic block has a constant step */
 	u16 last_round, uses_no_step;
 	u64 steps[MAX_BPF_EXT_REG];
-	bool has_step;
+	bool has_step, wraps, insn_wraps;
 	u32 slot;
 	int n;
 
 	bitmap_andnot(not_linear, iv_xregs, loop->linear_xregs, MAX_BPF_XREG);
+	wraps = skip_wraps(env, entry, not_linear, factor);
 	do {
 		last_round = no_step;
 		bpf_add_cost(env, loop->nr_insns, BPF_COST_SCAN);
@@ -904,11 +929,13 @@ bool bpf_steps_are_constant(struct bpf_verifier_env *env, const struct loop_stac
 			if (n == entry->iv_jump_idx && (uses_no_step & ~aux[n].const_reg_mask))
 				return false;
 			slot = slot_of_insn(env, insn);
-			has_step = !slot ? keeps_constant_step(insn, prev, infinite) :
+			insn_wraps = infinite || (wraps && (BPF_CLASS(insn->code) != BPF_ALU ||
+							    aux[n].zext_dst));
+			has_step = !slot ? keeps_constant_step(insn, prev, insn_wraps) :
 				   test_bit(bpf_xreg_to_spi(slot),
 					    aux[loop->header].live_stack_before) &&
 				   !test_bit(slot, not_linear) &&
-				   (!infinite || BPF_SIZE(insn->code) == BPF_DW);
+				   (!insn_wraps || BPF_SIZE(insn->code) == BPF_DW);
 			/* a copy that the run made has the step of its source */
 			if (has_step && aux[n].seen && (aux[n].def_regs & ~aux[n].use_regs))
 				steps[insn->dst_reg] =
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 35c9ef706c..907691a67a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21055,6 +21055,7 @@ static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_en
 	const struct loop_stack_entry *saved = bpf_top_loop(old->frame[old->curframe]);
 	u32 period = entry->trip - saved->trip;
 	bool infinite = entry->trips_left > BPF_MAX_TRIPS, guess;
+	u64 factor = div_u64(entry->trips_left - 1, period);
 	DECLARE_BITMAP(iv_xregs, MAX_BPF_XREG) = {};
 	int err;
 
@@ -21067,14 +21068,14 @@ static int fast_forward_trips(struct bpf_verifier_env *env, struct loop_stack_en
 	err = bpf_jumps_see_same(env, old, cur, entry->iv_jump_idx, infinite ? NULL : iv_xregs);
 	if (err <= 0)
 		return err;
-	guess = !bpf_steps_are_constant(env, entry, iv_xregs, infinite);
+	guess = !bpf_steps_are_constant(env, entry, iv_xregs, infinite, factor);
 	if (infinite) {
 		entry->loop->infinite = true;
 		entry->loop->infinite_is_guess = guess || env->run_has_guess;
 		return 0;
 	}
 	env->run_has_guess |= guess;
-	bpf_fast_forward_xregs(env, old, cur, div_u64(entry->trips_left - 1, period), iv_xregs);
+	bpf_fast_forward_xregs(env, old, cur, factor, iv_xregs);
 	entry->iv_jump_idx = 0;
 	entry->trips_left = 1;
 	return 1;
-- 
2.55.0

