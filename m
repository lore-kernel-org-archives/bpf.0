Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206939;
	b=XWjgJcWNxQ+KXamPz7NRxOPQNcKHGjxLnBDX0sPe2TsRgxBVwgbTBHHcyiqm8glpNm27
	 u+yqM8Ebp4vvEu5YNhP0kNfwIp2O68JaJ0B61G0sKR8uTGk1vt6K+dvDzv8wAv/5lUOaD
	 2K1efMpKwq/x9oBB9sdFoXNqoP5yZZR+w35D2RNvcwvmUjIt3+H7vc4pcrPGxfEkhwwZu
	 21/2sHjB1ZmdH6SBbsVzB/TENuXz9I9d5hAdrOfWhytmajoF2xXOe2xyztLEi3b+IVYws
	 ZT3ftgNwQNdGnuqrew4o6m6if9lRnRF2fC7aAZSJt7T2gSQT2SoJGTgrAECt5ja3Nyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=xo9bE/4MMghtprJKj0bXe2xJkjy7CFjuvK9NU6cY9HI=;
	b=uRtCh7WLKmXGWykcRjLvYCrG7pjUnXnojna3hvl3zog1b98QB9r0bt7ezKkYh5L+nWzf
	 xKial6Jf7w8nm0cNW6j7HToXfh5EzzeIJjJ9tpWXYVIhCzC6YQ/xPurxx8gPJoBjCic3B
	 rbWSMMLaX99w82nG0zEqHvjDp+N/UM7jzXuniw7eRySumQJzc/6jNZqivHM66y6l5Z6W9
	 Seul9Uaa2W25GdhsQCYQiKyQYHI6JBhvWr/BzUqPxWPmqQJ/FMxZmb01jZM2aAyrqizpg
	 b2+r7nI56v8Nnm1JhcZjh7xev3+Aba3vZvBfJWIhx8pmYhfBFiCFnf0d4E4N1X3Du/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ej7Lh8w0;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D71606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ej7Lh8w0
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso180993a12.1
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206938; x=1794811738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xo9bE/4MMghtprJKj0bXe2xJkjy7CFjuvK9NU6cY9HI=;
        b=ej7Lh8w0/1SxOzVU2je+MmchFfd/m5Eu64gt3EFUb///gjuughWBYwwyZL76dvFeID
         Vynh4fizqBXwaLpK+eTO9R0sujjVt7gva2cZzDbvlCi1oHKwNlbEBR5SMG9qo/EzwDKJ
         yduw5Oqj2DEHZHktxK1htGkYpn8FBkUV3NmS3/WxFEIboa4wO5yAM3QV0J0kd3u9jFWa
         NmTKvXrsyaX1Nk5wVJsyYq+SIFQkjQ8Yks+M8ZJkaGlP2rt/3ZUbgT1xmG/KNPJ0Vcqo
         s+hR6KIg6s43LA3zjzontb4UvOTrUN7SWQrQjYkE2C+ktfob1vWLshmYIC/h8a//E8PJ
         hVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206938; x=1794811738;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xo9bE/4MMghtprJKj0bXe2xJkjy7CFjuvK9NU6cY9HI=;
        b=tkJBChyfdaoUvbZZAVEUTFroZqkox/ZOQ7d1kyXkC08B0B8/P6T8ZdFLxTuMRHKZXp
         Rh1++ND9aH3whc+Gz7AHskmcl+nU2HlBpPKQoIXDmvvqhqROTr/QZM2Ss1G83/snFiOB
         T1muUkjOU2ubELLnHc5AXkxDM3ARkUGQHZz/7LkbYBYH1I20KGQUySeLU8CoVae6V23s
         4toYyIl2/05WfjeUAOgCkbsGX8KPeW1ISn1OhYl7VjCmWgxQ/7cUubu3pIC0GOTUuJBm
         plRdQnG8OeNEMklT3y/b49VltFjUVjNQZCZKqICgonIf2eIzGxpy2Jn/Drgzrz0ei2Um
         SQ3w==
X-Gm-Message-State: APuU4Z+nHFfrXexDsJF/UdCgKKmfB+MEZ1vAqwjS0XvPlbOJ73ihbgxp
	SKE8dPLcDmdv2qdP07bRugDwQ4xKMsQdl5uHM1KV28LhAAFRed92XC6ubczO+A==
X-Gm-Gg: AYBFou14HImlZI2AUnB/eInmjkNGWpdgMNIc4w4a0h+U8r4c0Zp+DIeO4BtdSrXshBn
	2E/ZIG9YmgI1f3P9NubOSqs8Qk6KiyICkFvoFzy9tRxfQY9UPW+BszRx5F1LQ+BkO6fI0JHgxFN
	TuOkRfPsZdcdqtPulpxZ+QW6p3+vEZ83Of/gk5U5dQlWUmrSMYiYOPYHViFEHuIzhvzL3RDR+7Z
	skzIQSlDab1R8tCszXUqAZCNlObNJS7ilhhIjlRpMsk6e2qETo5PMD+9GEqkw8kzIXqJmKnQley
	wrlz+J8ZKNBvl0WxZWfYBMM4gXbaVv/BAeO4C8vV8vwfuv+d9icLD66WJbw10VvL9WTYVQeUgyF
	ej2zWAkfB9cu9QYK+wZu1M/jHFyM5z46mAzI8MfW5D8rLhV1A4Cse1P0m46UddSpXd96nxVx0ta
	WSXLZ9y6C6gRBS6oCQfMI9kPn0X0HZ9BIPp2/PHD9PeIUUJcJ+HnpO3d9n6eg5GIcrF60yz49Kh
	uUewENDSTzvx5mk1bPBeAvOhXlf+zWeDnD9+Dz8yeAJai4R3U3cwgmiuNg4I74mkZwEuPHp3F/C
	gULG41Cwidkznkl5d96wnru1T347WrDsQflRa4egUU+lduLLy/agH9GdDE9mOunS4tyIBXdQvn8
	Oixop8EnNB1RehaPEGSP8Efsl+/FRlrpT8vjOfKreQd9m2HAI8gWuv37O2fbXkbqp3yzSZ6OoDQ
	==
X-Received: by 2002:a17:90b:1ccd:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b12d54ab46mr2507719a91.30.1794206938294;
        Sun, 08 Nov 2026 22:48:58 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1279158c4sm5786574a91.14.2026.11.08.22.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 17/26] bpf: Find a copy of an induction variable without scalar ids
Date: Mon,  9 Nov 2026 06:47:01 +0000
Message-ID: <20261109064715.2382452-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A prerequisite of the removal of scalar ids, no new ability. scev.c has two
users of them: scev_regs_equal() reads them, link_copies() assigns them.
Both are for a loop like this one. It has an iteration count
(header_count: how often the header is executed) before and after the
patch:

	u32 i = 0;
	while (buf[i++] && i < 1023)
		;
	return buf[i];

clang keeps the value of i from before the increment in r2, and the linear
latch tests r2:

	     r2 = 0
	     r1 = 0
	l:   r1 += 1
	     if r2 > 1021 goto out
	     r2 += r0
	     w3 = *(u8 *)(r2 + 0)
	     r2 = r1
	     if w3 != 0 goto l
	out: r0 += r1

r1 and r2 have the same backedge value. r2 is a copy of the induction
variable r1 if their entry values are equal too (at the header the two are
congruent induction variables, LLVM: replaceCongruentIVs()). scev.c used to
analyze loops only, so (copy r2 (linear r1 1)), COPY_SCEV, leaves the entry
values to the main pass: scev_regs_equal() accepts the same constant or the
same scalar id in the state at loop entry.

By now scev.c computes expressions for whole subprogs, the code before the
loop included. const_diff_at_header() decides if r2 == r1 holds at the
header in every iteration: it holds at loop entry and every backedge
preserves it. Then r2 is an induction variable of its own, (linear r2 1),
and no code after compute_header_scevs() has to know that it is a copy.

link_copies() assigns one scalar id to r1 and r2 at the header, so that the
test of r2 bounds r1 at 'out'. The linked registers of a conditional jump
do that without an id: the live registers and stack slots that are a tested
register + a constant on every path to the jump. At the header, the latches
and the exits of a loop they include what const_diff_at_header() finds.

Remove COPY_SCEV, is_copy(), copy_reg, scev_regs_equal(), link_copies().

Precision that is lost:
 - Two registers enter the loop with the same constant, and only the state
   knows it, not scev.c. The loop has no iteration count.
 - At a jump of the loop that is no latch and no exit a test of r1 does not
   refine r2: const_diff_at_header() is not used there. copy_less and
   copy_more of verifier_loop_latch.c stored at the copy - 1 and + 1 after
   such a test. They store at the copy now.
No other verdict changes in the selftests, Cilium, sched_ext, katran,
bpfjailer and the programs in Rust.

The new test copy_ahead enters the loop with 0 in the induction variable
and 1 in the copy: no iteration count.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 107 +++---------------
 .../selftests/bpf/progs/verifier_loop_latch.c |   8 +-
 2 files changed, 24 insertions(+), 91 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 0bb52ca8aa56..2792217754be 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -45,11 +45,6 @@ enum expr_op {
 	 * bpf_loop_at_index().
 	 */
 	LINEAR_SCEV,
-	/*
-	 * param[1], given that register param[0] and the register that param[1] starts from are
-	 * equal when the loop is entered. Not known otherwise.
-	 */
-	COPY_SCEV,
 	/*
 	 * (add rB rC) is the SCEV of rA: rA == rB + rC at the header in every iteration. rB and rC
 	 * are the header phis here, not the entry values as below LINEAR_SCEV.
@@ -254,7 +249,6 @@ static bool expr_is_vn(struct scev *scev, struct expr *e)
 	case SPILL32:
 	/* a function of the iteration number */
 	case LINEAR_SCEV:
-	case COPY_SCEV:
 	/* a relation between header phis */
 	case ADD_SCEV:
 		return false;
@@ -492,13 +486,6 @@ static bool is_linear(struct scev *scev, int id, u32 *base, u32 *slope)
 	return is_binop(scev, LINEAR_SCEV, id, base, slope);
 }
 
-static bool is_copy(struct scev *scev, int id, u32 *reg, u32 *orig)
-{
-	u32 t;
-
-	return is_binop(scev, COPY_SCEV, id, &t, orig) && is_reg(scev, t, reg);
-}
-
 static bool is_linear_or_linear32(struct scev *scev, int id, u32 *base, u32 *slope, bool *zext32)
 {
 	u32 t;
@@ -559,7 +546,6 @@ static const char *op_str(u32 op)
 	case SPILL32:  return "spill32";
 	case ANY:      return "any";
 	case LINEAR_SCEV:  return "linear";
-	case COPY_SCEV:    return "copy";
 	case ADD_SCEV:     return "add";
 	}
 	return NULL;
@@ -583,7 +569,6 @@ static u32 op_params_num(u32 op)
 	case SMOD:
 	case ANY:
 	case LINEAR_SCEV:
-	case COPY_SCEV:
 	case ADD_SCEV:
 		return 2;
 	case BPF_NEG:
@@ -2412,9 +2397,10 @@ static int instantiate_header_scevs(struct scev *scev, u32 id, void *priv)
 	return id;
 }
 
-static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header_env)
+static int compute_header_scevs(struct bpf_verifier_env *env, int h)
 {
 	struct scev *scev = env->scev;
+	struct env *header_env = find_header_env(scev, h);
 	int l, r, t, id, ra, rb, ra_expr;
 	bool zext32;
 	s64 imm;
@@ -2499,7 +2485,7 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 	/*
 	 *	do { i++; if (old > 1021) break; c = buf[old]; old = i; } while (c);
 	 * rA = (+ rB IMM) and rB = (+ rB IMM): an iteration leaves the same number in both. If
-	 * they are equal when the loop is entered rA is at the header what rB is.
+	 * they are equal at loop entry too, rA is an induction variable with the same step.
 	 */
 	for (ra = 0; ra < REGS_NUM; ra++) {
 		if (header_env->reg2scev[ra] != UNKNOWN_EXPR_ID ||
@@ -2509,9 +2495,12 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 			id = header_env->reg2scev[rb];
 			if (header_env->reg2expr[rb] != header_env->reg2expr[ra] ||
 			    !is_linear_or_linear32(scev, id, &l, &r, &zext32) ||
-			    !is_reg(scev, l, &t) || t != rb)
+			    !is_reg(scev, l, &t) || t != rb ||
+			    !const_diff_at_header(env, h, rb, ra, &imm) || imm)
 				continue;
-			id = expr2(scev, COPY_SCEV, expr1(scev, REG, ra), id);
+			id = expr2(scev, LINEAR_SCEV, expr1(scev, REG, ra), r);
+			if (zext32)
+				id = expr1(scev, ZEXT32, id);
 			if (id < 0)
 				return id;
 			header_env->reg2scev[ra] = id;
@@ -2741,7 +2730,7 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 		cond_resched();
 		header = bpf_loop_at_index(env, idx);
 		err = aux[idx].loop
-		      ? compute_header_scevs(env, find_header_env(scev, header))
+		      ? compute_header_scevs(env, header)
 		      : compute_insn_scevs(env,
 					   find_header_env(scev, header),
 					   find_loop_env(scev, header, idx));
@@ -2884,19 +2873,6 @@ static struct bpf_reg_state *scev_reg_for_linear(struct bpf_func_state *st, u32
 	return &stack->spilled_ptr;
 }
 
-/* Do the registers or stack slots @a and @b hold the same number in @st? */
-static bool scev_regs_equal(struct bpf_func_state *st, u32 a, u32 b)
-{
-	const struct bpf_reg_state *ra = scev_reg_for_linear(st, a);
-	const struct bpf_reg_state *rb = scev_reg_for_linear(st, b);
-
-	if (!ra || !rb || ra->type != SCALAR_VALUE || rb->type != SCALAR_VALUE)
-		return false;
-	if (tnum_is_const(ra->var_off) && tnum_is_const(rb->var_off))
-		return ra->var_off.value == rb->var_off.value;
-	return ra->id && ra->id == rb->id && ra->delta == rb->delta;
-}
-
 /* '*(u32 *)(r10 - 8) = rX' left a number in the low half of the slot. */
 static struct bpf_reg_state *scev_reg_for_spill32(struct bpf_func_state *st, u32 r)
 {
@@ -3014,8 +2990,7 @@ static bool scev_reg_alive(struct bpf_verifier_env *env, struct bpf_verifier_sta
  * 'i' is the loop iteration number, starting from 0.
  * 'zext32' indicates the latch is for (zext32 (linear ...)) SCEV.
  * 'jmp32' indicates that the latch is a JMP32 instruction.
- * 'base_reg' is the register in <base>. 'copy_reg' is -1, or <reg> is made from that register,
- * which has to be equal to 'base_reg' at the entry of the loop, see COPY_SCEV.
+ * 'base_reg' is the register in <base>.
  */
 struct linear_latch {
 	u32 insn_idx;
@@ -3023,7 +2998,6 @@ struct linear_latch {
 	u32 step_expr;
 	u32 bound_expr;
 	u32 base_reg;
-	int copy_reg;
 	u8 op;
 	bool zext32;
 	bool jmp32;
@@ -3047,7 +3021,7 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	struct env *latch_env;
 	u32 src_reg_scev;
 	u32 dst_reg_scev;
-	u32 t, l, r, op;
+	u32 l, r, op;
 	int id;
 
 	op = BPF_OP(insn->code);
@@ -3077,11 +3051,6 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 		return -EFAULT;
 	dst_reg_scev = latch_env->reg2scev[insn->dst_reg];
 	src_reg_scev = latch_env->reg2scev[insn->src_reg];
-	latch->copy_reg = -1;
-	if (is_copy(scev, dst_reg_scev, &latch->copy_reg, &t))
-		dst_reg_scev = t;
-	else if (BPF_SRC(insn->code) == BPF_X && is_copy(scev, src_reg_scev, &latch->copy_reg, &t))
-		src_reg_scev = t;
 	/*
 	 * Make sure (linear ...) is in dst_reg_scev:
 	 *   'if <invariant> <op> <linear>' ⇔
@@ -3779,8 +3748,6 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 
 	iters->iv_reg = -1;
 
-	if (latch->copy_reg >= 0 && !scev_regs_equal(st, latch->copy_reg, latch->base_reg))
-		return false;
 	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
 	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
 	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
@@ -4116,49 +4083,15 @@ static bool is_simple_linear(struct scev *scev, u32 id, struct linear_coefs *out
 }
 
 /*
- * Is @r 'what it is in @st + slope * k' at the header in iteration k? @id is its SCEV there, @st is
- * the state that entered the loop. At a jump in the loop @id can be what another register was at
- * the header. @st says nothing about @r then.
+ * Is @r 'its entry value + slope * k' at the header in iteration k? @id is its SCEV there. At a
+ * jump in the loop @id can be linear in the entry value of another register: the entry value of @r
+ * does not bound it then.
  */
-static bool is_linear_at_header(struct scev *scev, struct bpf_func_state *st, u32 id, u32 r,
-				struct linear_coefs *out)
+static bool is_linear_at_header(struct scev *scev, u32 id, u32 r, struct linear_coefs *out)
 {
-	u32 copy, orig;
-
-	if (is_copy(scev, id, &copy, &orig))
-		return copy == r && is_simple_linear(scev, orig, out) &&
-		       scev_regs_equal(st, r, out->base_reg);
 	return is_simple_linear(scev, id, out) && out->base_reg == r;
 }
 
-/*
- * @st is at the header of a loop that @entry entered. A copy of an induction variable is equal to
- * it there in every iteration. They got their ranges one by one: give them one id, like 'r2 = r1'
- * does, so that a test of one of them is a test of both.
- */
-static void link_copies(struct bpf_verifier_env *env, struct env *header_env,
-			struct bpf_func_state *entry, struct bpf_func_state *st)
-{
-	struct bpf_reg_state *reg, *orig;
-	struct linear_coefs coefs;
-	u32 r;
-
-	for (r = 0; r < REGS_NUM; r++) {
-		if (!is_linear_at_header(env->scev, entry, header_env->reg2scev[r], r, &coefs) ||
-		    coefs.base_reg == r)
-			continue;
-		reg = scev_reg_for_linear(st, r);
-		orig = scev_reg_for_linear(st, coefs.base_reg);
-		if (!reg || !orig || reg->type != SCALAR_VALUE || orig->type != SCALAR_VALUE ||
-		    tnum_is_const(orig->var_off))
-			continue;
-		if (!orig->id)
-			orig->id = ++env->id_gen;
-		reg->id = orig->id;
-		reg->delta = orig->delta;
-	}
-}
-
 /*
  * A 32-bit counter that lives on the stack: the SCEV of slot @r is
  * (spill32 (linear (zext32 @r) slope)) and there is a 32-bit number in the slot in @st.
@@ -4567,7 +4500,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			continue;
 		}
 		/* If SCEV for r is (linear <reg> <slope>) */
-		if (reg && is_linear_at_header(scev, cur_func, r_scev, r, &coefs) &&
+		if (reg && is_linear_at_header(scev, r_scev, r, &coefs) &&
 		    bpf_is_widenable_reg_type(reg)) {
 			/* 32-bit ALU operations on pointers convert them to scalars */
 			if (coefs.zext32 && reg->type != SCALAR_VALUE)
@@ -4783,7 +4716,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 		}
 
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (spill32 || is_linear_at_header(scev, entry_func, r_expr, r, &coefs)) {
+		if (spill32 || is_linear_at_header(scev, r_expr, r, &coefs)) {
 			/* the range is derived from @loop_entry: bpf_clamp_scev_regs() */
 			if (back)
 				continue;
@@ -4831,7 +4764,6 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			mark_scev_reg_scratched(env, r);
 		}
 	}
-	link_copies(env, header_env, entry_func, cur_func);
 	return 1;
 }
 
@@ -4888,7 +4820,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			goto clamp;
 
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (!is_linear_at_header(scev, entry_st, r_scev, r, &coefs) &&
+		if (!is_linear_at_header(scev, r_scev, r, &coefs) &&
 		    !(behind && is_moved_linear(scev, r_scev, &coefs, &moved) &&
 		      coefs.base_reg == r))
 			continue;
@@ -4958,8 +4890,5 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			return err;
 		mark_scev_reg_scratched(env, r);
 	}
-	/* behind the jump the variable may have moved on: its copy is what it was at the head */
-	if (!behind)
-		link_copies(env, header_env, entry_st, cur_func_state);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index 35bb3e16db3d..805e3f3ae091 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -271,6 +271,10 @@ LOOP(copy_bad, "r8 = 0; r9 = r8;", COPY(2047))
 BAD("a copy of the counter, another number at the entry")
 LOOP(copy_other_const, "r8 = 2047; r9 = 0; r6 += 2047;", COPY(2046))
 
+/* the latch exits one iteration later than for an induction variable that starts from 1 */
+NO_COUNT("a copy of the counter, one more at the entry")
+LOOP(copy_ahead, "r8 = 0; r9 = 1;", COPY(2047))
+
 OK("a copy of the counter, a range", "[0..2]")
 LOOP(copy_range, "r5 = r6; r8 = r7; r8 &= 1; r8 += 2045; r9 = r8;", COPY(2045) AT_R8)
 
@@ -297,13 +301,13 @@ LOOP(copy_bounds_both, "r5 = r6; if r7 > 2047 goto 9f; r8 = r7; r9 = r8;",
 	"r4 = r5; r4 += r9; *(u8 *)(r4 " off ") = r1; 2: r9 = r8; if r7 != 0 goto 1b;"
 
 OK("a copy of the counter, one less behind the jump", "[0..2048]")
-LOOP(copy_less, "r5 = r6; r8 = 0; r9 = r8;", NOT_EQUAL(1, "> 2046", "< 2", "- 1"))
+LOOP(copy_less, "r5 = r6; r8 = 0; r9 = r8;", NOT_EQUAL(1, "> 2046", "< 2", "+ 0"))
 
 BAD("a copy of the counter, one less behind the jump, not equal")
 LOOP(copy_less_bad, "r5 = r6; r8 = 0; r9 = r8;", NOT_EQUAL(1, "> 2046", "< 2", "- 2"))
 
 OK("a copy of the counter, one more behind the jump", "[0..2047]")
-LOOP(copy_more, "r5 = r6; r8 = 2047; r9 = r8;", NOT_EQUAL(-1, "s< 2", "> 2045", "+ 1"))
+LOOP(copy_more, "r5 = r6; r8 = 2047; r9 = r8;", NOT_EQUAL(-1, "s< 2", "> 2045", "+ 0"))
 
 BAD("a copy of the counter, one more behind the jump, not equal")
 LOOP(copy_more_bad, "r5 = r6; r8 = 2047; r9 = r8;", NOT_EQUAL(-1, "s< 2", "> 2045", "+ 2"))
-- 
2.55.0

