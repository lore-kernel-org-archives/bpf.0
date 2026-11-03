Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749374;
	b=bR++gmf3MSoMI84DfUEaSCwq48XaXzcoCL5bNenBKunq4hlhvl5ZCaSE1Epgo9L/ykpK
	 0XuehdaJC2uyaYezv5VXLb/kxJ5FtIMzsvZxGKFSTRi47p9fopcKkZalgy+u2KEIqEWaS
	 j4eoHgGRd7q6vN56YEMzI9tYsWmzFUaIZLNNO2ugcfAxCArwM/FdVXV8vLGRZ4Rqy24Ql
	 XMELdBGxnZcyxohLWFULOvJdBMlvlJBXAmgqz3HgjLVExFWQFUrC6pO9tC7gW5jJ+uzyi
	 2JWqjokfTk1f5raj7n+Tb1gqt1nRCPZeOOaqtKlS2SHdrWPDoFgWEFZogprR1uhUQsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FWqguGXrCzd+bdEotQm4bGQyWeyURmq2gZrFKsGS6Qo=;
	b=BFlfVPCLiVOBdINPL0bee4uMlpfclNYTkg0XJTFMxMxXs81fnJZpuLp2YvrtJDgT+hX+
	 EwC8BV20C7pFNFSU8rgSFA9z5AYlbQzzD1yYfrg3FRlcZSsATy11BjHzo0egbZYx20XD+
	 Miq/8oSvayui951BrMMDC4cHbhKrXRURaZ1bvxJ3IDttXheZ6FdAjyPlKmI8ij3Eg7M1g
	 IlEuzmx2ychubJygxTgv0lpFxiwkM3+eNgVRYaytqHD1kPo1kSXBqY5V+5n3ftHsFPSlu
	 rV3L46vhH6xiKuTzFaa8F4SRsY1CP3VpQPScgLSFoo6GxbTx+QLeQW3QJXMpIWogQEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcTY3qE3;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A2606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E3A2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RcTY3qE3
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06e79e152so113526b3a.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749373; x=1794354173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWqguGXrCzd+bdEotQm4bGQyWeyURmq2gZrFKsGS6Qo=;
        b=RcTY3qE3V3rDdi8CSrn2imUt1TDUp+AyQJmwrrVd5mKcHkOtDMEhTSZZPqQeN9ooxl
         Y1Bw2PIra1qgh59j2BP28P6NSArb84D/3JapofvvXJC087mtd9SAZpqNKOvthwebHusw
         mav9zDSMc4fRnVtIkEKDUNwZVavzUKr5K4JAoKNQjoLXUaa7oy5K5uoypwc0PoRo5p86
         ujp48rxAoWLfGpiKMGQipT+ozunh2Yz6ZNShaEWq20l0XUAfkmTyVEbjhMTj1iG4IHfE
         MCcCcLRlnM2D974H+udT3UlzZdilOEPqp6FdqnwRw5+1o9fmHOtJvpr6laLsBvTVbq7I
         yhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749373; x=1794354173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWqguGXrCzd+bdEotQm4bGQyWeyURmq2gZrFKsGS6Qo=;
        b=rDHJI6a/Bj9BxBLtwk97VIND7cQBROWGDA2ljPl9xVtCnoiEpIFUHbO4sHDW2Lf9A3
         r1+nnt3QRKwohy7gqVwHC6O4bnJV84djZjDL2yZG9qvvn+MBnaCroAc1R74Uw3M6Igkv
         PDf2F5aSHffW0mYgg95zM4G87KODDvfocrB8PoOCMbax9YvfT9BaWQrXw2tvuUTiZGn8
         ajiKOrWf8d8hrxRgT5Be1v5b+W46Ou5uns3Frb8JkqcrPVnHjIcCir61gVP77OgKITCV
         maSYUF1COAQ/z7fo4a+xao9sgjk9EMNmym3mI4Fqu76+exfClBmmC8I4rtY4PIybdZD3
         JYqQ==
X-Gm-Message-State: APuU4Z9qeAcU4Sdix6ZZjADtJjcKeau8sauQiV0JkFtyqHKqIPTlK900
	pxOeqpTwWNwIWwlgP7Kda8gyefBqvZE2dK6/tzMkyqth3KXCLhsbreQX/yEQzQ==
X-Gm-Gg: AYBFou2wTWtvPe6vansgsN6mwNG6xdnsOQ1DHobFkJbK31CMG+o+wRsitq9Zt9DFoMV
	yFV4oj/Xujay5hqPDJqhqllcp+mxHzfpitVM1wUn0Ul6f9IhZF58tSS04YfD8wZn4SM38SqSHGF
	9ELDHCpPpGFYNeW9KA37SghJccyIPzT5jPgYyjUU8FDyeTthYn01iyuCDpv/dERRr/HjeXWpEWK
	bNYyg2t+vHiUseeubYxzteIvRk42tYss3v7r6Kkwg5RL7BXx0SHITqeL+SewISiP3YeH9QUBKd7
	fhEQ9oJHSwqzvcOtrvClgbkdjXL2u6a7mHmysxz91ohHAcbN5qhTEvXQMepC9MEnrNCs47o7vmQ
	tc3WBoPVkruvYDvdCqYGN3ShrWU70j4LJ1wYwxVP688xbkTicPYRxB4OgnEvR4uoctp7SJ39viR
	gfMkL1sjQN1vLarE2vTGBAht1y2vpQ+G4DFYPLnBc8SXi4ymWqqynmigB6rMqtr47XlLFMq7P7M
	bIeMbMy5s5yXMwOU/CS5Z6YvyoP2mJQGBjL6rPddQa4jB4rfGhKexSd9ZAPTznKJQB2ZK5uhi35
	gSO2cWfehc6BM1Xq98/x5OGO+3zOV7DYaiq+pNgL5VTDSjxq6yqyZeCj8r8I3T/IxSTE545sdMK
	GC3USNrkkT1mGQfItChqMOGJp13r7bh/9V4e7+qKKQOWB856f5haqY4u3UC90JJGusnGM39pkSA
	==
X-Received: by 2002:a05:6a20:6a10:b0:3e0:da23:873b with SMTP id adf61e73a8af0-3e928a63d45mr11676624637.59.1793749373166;
        Tue, 03 Nov 2026 15:42:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46940d0dsm266739a12.19.2026.11.03.15.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:52 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 18/37] bpf: Describe more registers of a counted loop
Date: Tue,  3 Nov 2026 23:40:43 +0000
Message-ID: <20261103234104.208239-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

The verifier verifies the body of a counted loop one time only if scalar
evolution has a formula for each live register that the loop changes. One
register without a formula makes the verifier unroll the loop.

       what the loop does with a live register     the register at the head
  ---  ------------------------------------------  ------------------------
       adds a constant                             range from the count
       sets it to one of a few invariant values    union of the values
  new  only clears bits of [0, max]:               no change
       'idx &= ~(1 << order)', zero extension
  new  moves a pointer to arena                    no change
  new  sets it to the same constant each time      no change
       something else                              no formula

In the new rows the state that enters the loop covers all iterations:
 - A number that loses bits does not grow, and a bit that is 0 stays 0. The
   rule is only for the range [0, max]: 64 or [64, 127] can become 0. The
   register is not equal to its copies any more, thus it loses its id.
 - The verifier does not track the offset of a pointer to arena. So
   bpf_clamp_scev_regs() must not give it a range at the back edge: it now
   sets a range only for the types that get one at the entry.
 - bpf_compute_const_regs() knows the registers that have one constant at
   an insn on all paths: 'r7 &= 31' with 17 in r7. It recorded constants
   that fit in 32 bits. Record that there is a constant for the others too.

The verifier does not rely on the new rows. It compares the state that
returns to the loop head with the state at the head. If they do not agree
it verifies the body again from the state that returned. The counter has
its range then: a loop that makes a number of a pointer to arena and
changes that number in each iteration no longer loads.

'x >> e', 'x / e' and 'x % e' get no rule: iterations one by one tell more
about a number that is halved 8 times. That is true for '&' too: a prog
that needs 'x &= 15' to be below 16 from the second iteration on is
rejected now. But '&' is what the loops in real progs do.

The verifier processes about 2 % fewer insns for the selftests. The progs
that change use arena: big_alloc2 goes from 2956 to 216, some get more
insns, at most 270. 3 progs of bpfjailer need 17 % fewer insns. No prog of
Cilium, scx, the selftests or the public progs of Meta is lost.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   4 ++
 kernel/bpf/const_fold.c      |  11 ++--
 kernel/bpf/scev.c            | 109 ++++++++++++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7825a3bc0205..724f3b60130f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -348,6 +348,8 @@ struct bpf_loop_iters {
 	u32 min_header_count;   /* min number of times header is executed */
 	u32 max_header_count;   /* max number of times header is executed */
 	unsigned long precise_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/* [0, max] at the entry, and the loop only clears bits */
+	unsigned long mask_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
 	/*
 	 * The variable that the latch tests, or -1, and what it can be at the
 	 * loop header: what it is at the entry or what the latch lets through.
@@ -851,12 +853,14 @@ struct bpf_insn_aux_data {
 	/*
 	 * Bitmask of R0-R9 that hold known values at this instruction.
 	 * const_reg_mask: scalar constants that fit in 32 bits.
+	 * const_reg_wide_mask: scalar constants that don't, there is no val.
 	 * const_reg_map_mask: map pointers, val is map_index into used_maps[].
 	 * const_reg_subprog_mask: subprog pointers, val is subprog number.
 	 * const_reg_vals[i] holds the 32-bit value for register i.
 	 * Populated by compute_const_regs() pre-pass.
 	 */
 	u16 const_reg_mask;
+	u16 const_reg_wide_mask;
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
index f9edfde965dc..ce1bd72cb6c8 100644
--- a/kernel/bpf/const_fold.c
+++ b/kernel/bpf/const_fold.c
@@ -8,7 +8,7 @@
  * instruction. Tracks 64-bit constant values in R0-R9 through the program,
  * using a fixed-point iteration in reverse postorder. Records which registers
  * hold known constants and their values in
- * env->insn_aux_data[].{const_reg_mask, const_reg_vals}.
+ * env->insn_aux_data[].{const_reg_mask, const_reg_wide_mask, const_reg_vals}.
  */
 
 enum const_arg_state {
@@ -276,9 +276,9 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 	if (changed)
 		goto redo;
 
-	/* Save computed constants into insn_aux[] if they fit into 32-bit */
+	/* Save computed constants into insn_aux[]: the value if it fits into 32-bit */
 	for (i = 0; i < insn_cnt; i++) {
-		u16 mask = 0, map_mask = 0, subprog_mask = 0;
+		u16 mask = 0, wide_mask = 0, map_mask = 0, subprog_mask = 0;
 		struct bpf_insn_aux_data *aux = &insn_aux[i];
 		struct const_arg_info *ci = ci_in[i];
 
@@ -289,8 +289,10 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 			case CONST_ARG_CONST: {
 				u64 val = c->val;
 
-				if (val != (u32)val)
+				if (val != (u32)val) {
+					wide_mask |= BIT(r);
 					break;
+				}
 				mask |= BIT(r);
 				aux->const_reg_vals[r] = val;
 				break;
@@ -308,6 +310,7 @@ int bpf_compute_const_regs(struct bpf_verifier_env *env)
 			}
 		}
 		aux->const_reg_mask = mask;
+		aux->const_reg_wide_mask = wide_mask;
 		aux->const_reg_map_mask = map_mask;
 		aux->const_reg_subprog_mask = subprog_mask;
 	}
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index eac792dc7b10..0d49c9021e30 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2754,6 +2754,21 @@ static bool made_from_partial_spill(struct scev *scev, const struct bpf_func_sta
 	return false;
 }
 
+/*
+ * bpf_compute_const_regs() has @r as a constant at @insn_idx, the head of a loop: it's the same in
+ * every iteration. do_check() takes a value that a range adds to it, or to what is computed
+ * from it, for a bug.
+ * That pass knows no types: arithmetic on a pointer to arena runs in 32 bits, and a pointer and a
+ * number can have one constant. As for a pointer to arena below, this is not relied on.
+ */
+static bool is_const_scev_reg(struct bpf_verifier_env *env, int insn_idx, u32 r)
+{
+	struct bpf_insn_aux_data *aux = &env->insn_aux_data[insn_idx];
+
+	return r < ARRAY_SIZE(aux->const_reg_vals) &&
+	       ((aux->const_reg_mask | aux->const_reg_wide_mask) & BIT(r));
+}
+
 /* Main logic in verifier.c forbids varying offsets for certain register types. */
 static bool is_widenable_reg_type(const struct bpf_reg_state *reg)
 {
@@ -2967,6 +2982,45 @@ static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state
 	return 0;
 }
 
+/*
+ * Does @id have no bit that register @r doesn't have at the head of the loop? 'x & e' and the
+ * low bits of x lose bits only. 'x >> e', 'x / e' and 'x % e' are not greater than x as well, but
+ * iterations one by one tell more about them: a number that is halved 8 times.
+ */
+static bool expr_loses_bits_only(struct scev *scev, u32 id, u32 r, int depth)
+{
+	struct expr *e = &scev->exprs[id];
+	u32 regno;
+
+	if (is_reg(scev, id, &regno))
+		return regno == r;
+	if (depth > 8)
+		return false;
+	switch (e->op) {
+	case BPF_AND:
+		return expr_loses_bits_only(scev, e->params[0], r, depth + 1) ||
+		       expr_loses_bits_only(scev, e->params[1], r, depth + 1);
+	case ANY:
+		return expr_loses_bits_only(scev, e->params[0], r, depth + 1) &&
+		       expr_loses_bits_only(scev, e->params[1], r, depth + 1);
+	case ZEXT8:
+	case ZEXT16:
+	case ZEXT32:
+		return expr_loses_bits_only(scev, e->params[0], r, depth + 1);
+	default:
+		return false;
+	}
+}
+
+/* The ranges of @reg are [0, max]. So no bit is known to be 1. */
+static bool reg_is_zero_to_max(const struct bpf_reg_state *reg)
+{
+	struct cnum64 r64 = cnum64_from_urange(0, reg_umax(reg));
+
+	return cnum64_is_subset(reg->r64, r64) &&
+	       cnum32_is_subset(reg->r32, cnum32_from_cnum64(r64)) && reg->step <= 1;
+}
+
 int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			   struct bpf_loop_iters *iters)
 {
@@ -3077,6 +3131,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	if (err)
 		return err;
 
+	bitmap_zero(iters->mask_regs, REGS_NUM);
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
 		struct bpf_reg_state *reg;
@@ -3110,8 +3165,19 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			continue;
 		}
 
+		if (is_const_scev_reg(env, insn_idx, r))
+			continue;
+
 		r_scev = header_env->reg2scev[r];
 		reg = scev_reg_for_linear(cur_func, r);
+		/*
+		 * The offset of a pointer to arena is not tracked: what enters the loop stands
+		 * for all iterations. If the loop makes something else of it the state that
+		 * returns to the head is not covered by the state at the head, and the body is
+		 * verified again from that state.
+		 */
+		if (reg && reg->type == PTR_TO_ARENA)
+			continue;
 		/* If SCEV for r is (linear <reg> <slope>) */
 		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {
 			/* 32-bit ALU operations on pointers convert them to scalars */
@@ -3137,6 +3203,18 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			}
 			continue;
 		}
+
+		/*
+		 * [0, max] that loses bits is in [0, max], a bit that is 0 stays 0: what enters
+		 * the loop stands for all iterations as it is. 64 or [64, 127] does not: it
+		 * can become 0.
+		 */
+		if (reg && reg->type == SCALAR_VALUE && !test_bit(r, loop->store_base_regs) &&
+		    reg_is_zero_to_max(reg) &&
+		    expr_loses_bits_only(scev, header_env->reg2expr[r], r, 0)) {
+			__set_bit(r, iters->mask_regs);
+			continue;
+		}
 cant_widen:
 		if (log->level & BPF_LOG_LEVEL2) {
 			r_expr = header_env->reg2expr[r];
@@ -3234,8 +3312,29 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
-		if (!scev_reg_alive(env, st, r) || is_unbound_scev_reg(env, cur_func, r))
+		if (!scev_reg_alive(env, st, r) || is_unbound_scev_reg(env, cur_func, r) ||
+		    is_const_scev_reg(env, insn_idx, r))
+			continue;
+
+		reg = scev_reg_for_linear(cur_func, r);
+		if (reg && reg->type == PTR_TO_ARENA)
+			continue;
+
+		if (test_bit(r, iters->mask_regs)) {
+			/* The range stays. It's no longer equal to the registers with its id. */
+			err = scev_reg_for_write(env, cur_func, r, &reg);
+			if (err)
+				return err;
+			if (log->level & BPF_LOG_LEVEL2) {
+				bpf_log(log, "loop header at %d, ", insn_idx);
+				log_reg(env, r);
+				bpf_log(log, " stays in 0..%llu, it loses bits only\n",
+					reg_umax(reg));
+			}
+			scratch_widened_reg_id(env, reg);
+			mark_scev_reg_scratched(env, r);
 			continue;
+		}
 
 		r_expr = header_env->reg2scev[r];
 		/* If SCEV for r is (linear <reg> <slope>)*/
@@ -3327,6 +3426,14 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		if (reg->type != entry_reg->type)
 			continue;
 
+		/*
+		 * bpf_compute_loop_iters() gives no range to a pointer to arena that moves, and
+		 * it does not look at dead registers. Set a range only where it would.
+		 */
+		if (!is_widenable_reg_type(entry_reg) ||
+		    (coefs.zext32 && entry_reg->type != SCALAR_VALUE))
+			continue;
+
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
 		if (r == entry->iv_reg)
 			iv_bounds(&bounds, entry->iv_range);
-- 
2.55.0

