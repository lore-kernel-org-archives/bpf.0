Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374147;
	b=n7zucvmN8BMT6JGorL2OGzdSNZSE6KJYgsW5NAmxNNqWFMcgRqj4XgzyS1nbd7V4a096
	 EL803W6cajGluhnypw5RI/ebGnz4FEeIx5fV81OASix2V3t1+TN+hZ8CuRWPf7sFY4DST
	 ZBURNmQz4yFbGqNgBHNXFogY2Mxc6Yb8Qi/XvKo1JiGB0HojJrbOODE2iXY25KtvZU7PU
	 k61z2ANmJw01c4gDTlUtTKa85bj1F0O6bC+tLXcnKVDANXOkcwGxSLKA1MwHDpIVldoWU
	 /egjudkAqshpH0igk0EyPMBKWb9CH7rkTSz5ukC8/AYw4VKGsa4HTbDj5YIWB4ih2hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=SzsTj0QEoPhFy3iruBUdwE2pbhVxPesGnx2Fd7nCz94=;
	b=cPZdnc52hikWEvF5uEupoJqYSsy8JIyhNF/yngu0nxDRO9ezfNoiX2g+pwbkbXoOxvOx
	 lo8KCw3yvzpKskPWaPJUUbsV1ePTIewr9rqxsDDPy+btFS+iiUUi5n2+FTItwNeahIouq
	 N6eUL0MvVTFUJw4BVq246UpYJRbP+QhruAp5YLgj+wSCiCfh4j5q1xXVkls8dHT0c/EdJ
	 IyyB7Uzoyh9VsZ7g6PmDUd2t5VlXSxl4JQtZfWKh+MKmhYTKt/W5nyPo70TyWYcGpYm4V
	 DaSl586xP3ogFcYVyWMJ9bieGKpTiM9sOZK/ReV8qKUB509k+EbVpZONgjFbPi9LUsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VrVy57Fk;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DCC606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4DCC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VrVy57Fk
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso1061750a12.2
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374146; x=1794978946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SzsTj0QEoPhFy3iruBUdwE2pbhVxPesGnx2Fd7nCz94=;
        b=VrVy57FkE2IARSo2PsvNmcvTMC4AUj+Qo+e4ISAPu9LniLwwzdcgKHscI5Fysa/wRv
         4iIMmuWJnnFUXA9o1CvSahY5ryD/FlBk2mC+1pD72d7gYFTc6TlCvCQwsOY9W01UA3ZY
         STuAw/hGlftM2IH8EqB18Wf/2JL/oRvVAIvSl1eZNdw2QlxRw/QGOSEinnO5YBu7CJQO
         2wcvkiLBimboQlgDbOZ/lsruCH62zfVY8qCOUk2EWpWQw7AV49zXN2T4ZZOsPe31O2/Y
         4nvi8EA3FvkaMILhVwqyP1j5dLdrESf9FAjbCnfo+u8HOsV9leAhTe0JEUkBJIEcJYH9
         3NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374146; x=1794978946;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SzsTj0QEoPhFy3iruBUdwE2pbhVxPesGnx2Fd7nCz94=;
        b=kDgS2GaKx+LJiFQQSMCVYhvXokB6aCB+zc/SuAPyuZuy6hpQJI6Rdg2ZHwY5p0aiAS
         mHuj09xcyzuQ+nD8c97qPNEMtLWpIJKgIkI/7XnqL2QqXt6+O0PXfWAfWH8xvdQcAiXE
         jQUWBT8UGOPWXhZeUJhS4cYB3inPntNlq/xPMbG0Nz5lzWoWEpqb3z1snTuPn4aPPuaf
         kTQ8AvJiRE04aRmWP/2p4wpHqXMn2iEHCtNHUI/UPZ/r15+jqd/W+AxBfNiM0KcXAsTn
         5u6uFgesRdnO/jkHmL5QjntYA5gCkOAQR9dNq3Bh5u8AmJJWaFWrRutUb3obFQ2pt/vS
         yJoQ==
X-Gm-Message-State: APuU4Z/7dxCWZ0ee+yistxfjszGrMpI3rbJtlrRE6KvLla+vla1cO0ly
	aePeYLALHoNPMkkZTFuicly+p3STwnTGAQVMjfzF6KfiAHmN+qB0gW1hwKoiJw==
X-Gm-Gg: AYBFou3zdYqERrSaie/QV8vIayH22HtfuDb/Q3J70eNxOnyRJXVUxWD7LBG5MZGP+ra
	pmy3g4cMOc4tDT1E3l2kMCV7kGnh7DGJNN7weUDZT5Xd4zdpu4ih/5bciPfnSp8oOmHAmMGIbqF
	HtMOZ1rIuUwDZy+w5LjIv3xfKEtlyseNEZhPwzoDcFBtSsmfoQbeVIHEvNzo364uH3RZxO3CGOm
	hBe9VhkC9wZnM59jTNoZTYS7izHxsBfpo/kwarom6eiovz48QhCTYkVKTSXF13IsVOipcG00HdA
	Q79QHwmqfGFU8LQCdWXtwNRFoMrrBBA50IDVWNFqpPjlw8XIHYcfBzKlxilDqF2ksT6IL+CjU4W
	kdmpNpX+kD5ZBOoGFEa26hzkZ1jR/r+m7Bh3Y1A+Q7KAy9ojyaP0tc91SPJD/rLKaNC4edBqdgr
	79pIF6kKGlCPb/xVUr32p+ttgsGlhaKTz1ZlAezEbm4Lbdun0afWFdgUavc9aRw5GZPIHTldiv8
	SpO5dZ1dAQ+407Q9iRV9ZvrIFrt2YKVJfVIvXDm3Mk5s3HSk7OUcOk/zOUGBajExz7X//R9Kl5v
	Zgz2vktyrbpX9dl+iU99EFhtbb4FEaEMMT6uOGAcDjiDEqVtDqIMHSKCat6fMYIttcuPUyfMzi9
	bl8h5fWhNKuuuk9+QYGTc1gm0lSZ5bOokh2YRwmd2cG6UYQeS2sFxfh5+ipNrDpAxddgCe18+a1
	k=
X-Received: by 2002:a17:90b:2710:b0:3b0:92b2:2e74 with SMTP id 98e67ed59e1d1-3b182fe0859mr1423696a91.62.1794374145946;
        Tue, 10 Nov 2026 21:15:45 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db319bdsm2694847a91.6.2026.11.10.21.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:45 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 20/29] bpf: Find a copy of an induction variable without scalar ids
Date: Wed, 11 Nov 2026 05:13:31 +0000
Message-ID: <20261111051341.2800252-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

A prerequisite of the removal of scalar ids. scev.c has two users of them:
scev_regs_equal() reads them, link_copies() assigns them. Both are for
a loop like this one. It has an iteration count (header_count: how often
the header is executed) before and after the patch:

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
congruent induction variables, LLVM: replaceCongruentIVs()).
Commit ab5fa7281144 ("bpf: Count a loop whose exit tests a copy of the
counter") added (copy r2 (linear r1 1)), COPY_SCEV, for that. scev.c
analyzed loops only then, so it left the entry values to the main pass:
scev_regs_equal() accepts the same constant or the same scalar id in the
state at loop entry.

By now scev.c computes expressions for whole subprogs, the code before the
loop included. const_diff_at_header() decides if r2 == r1 holds at the
header in every iteration: it holds at loop entry and every backedge
preserves it. Then r2 is an induction variable of its own, (linear r2 1),
and but for one place no code after compute_header_scevs() has to know that
it is a copy.

It finds more than scev_regs_equal() did: const_diff_at_header() compares
expressions, it does not know types and needs no id. The copy of a pointer
induction variable, and a copy that is equal by value number only
('r1 = r0 & 255; r2 = r0 & 255'), are induction variables too.
bpf_compute_loop_iters() checks the type of each register that it widens,
as for any induction variable.

The one place: if the entry value is a range,
'entry value + step * header_count' is far off.
'for (i = n; i > 0; i--) a[i - 1]' with n in [1, 4096] gives
[-4094, 4096]. latch_iv_range() has a better bound for the
induction variable that the latch tests, and as (copy ..) r2 had the range
of that one. is_iv_at_header() gives it to every induction variable that is
congruent to the tested one. It is the range at the header and
bpf_clamp_scev_regs() takes it there only. After the linear latch
a register can be the zero extension of its header value, and its state
has what still holds of the range.

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
 - A short loop that was unrolled because the copy of a pointer had no SCEV
   is summarized. After the linear latch a packet pointer is not clamped,
   so the copy has the range of one more iteration there, like the
   induction variable itself.
No other verdict changes in the selftests, Cilium, sched_ext, katran,
bpfjailer and the programs in Rust.

The new test copy_ahead enters the loop with 0 in the induction variable
and 1 in the copy: no iteration count. copy_of_pointer stores through the
value of a pointer from before the increment, 14350 -> 21 insns;
copy_of_pointer_bad is one byte further and is rejected. In
copy_same_value_number the two registers are computed by the same insns.
copy_down_from_range is the loop that runs down from n, copy_zext zero
extends the copy in it. copy_zext_bad zero extends a copy that starts
below 0, stores at it after the latch and is rejected.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 128 +++++-------------
 .../selftests/bpf/progs/verifier_loop_latch.c |  49 ++++++-
 2 files changed, 84 insertions(+), 93 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 98a05f97196a..28fd06c16fe4 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -48,11 +48,6 @@ enum expr_op {
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
@@ -285,7 +280,6 @@ static bool expr_is_vn(struct scev *scev, struct expr *e)
 	case SPILL32:
 	/* a function of the iteration number */
 	case LINEAR_SCEV:
-	case COPY_SCEV:
 	/* a relation between header phis */
 	case ADD_SCEV:
 		return false;
@@ -527,13 +521,6 @@ static bool is_linear(struct scev *scev, int id, u32 *base, u32 *slope)
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
@@ -596,7 +583,6 @@ static const char *op_str(u32 op)
 	case SPILL32:  return "spill32";
 	case ANY:      return "any";
 	case LINEAR_SCEV:  return "linear";
-	case COPY_SCEV:    return "copy";
 	case ADD_SCEV:     return "add";
 	}
 	return NULL;
@@ -620,7 +606,6 @@ static u32 op_params_num(u32 op)
 	case SMOD:
 	case ANY:
 	case LINEAR_SCEV:
-	case COPY_SCEV:
 	case ADD_SCEV:
 		return 2;
 	case BPF_NEG:
@@ -2743,9 +2728,10 @@ static int instantiate_header_scevs(struct scev *scev, u32 id, void *priv)
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
@@ -2830,7 +2816,7 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 	/*
 	 *	do { i++; if (old > 1021) break; c = buf[old]; old = i; } while (c);
 	 * rA = (+ rB IMM) and rB = (+ rB IMM): an iteration leaves the same number in both. If
-	 * they are equal when the loop is entered rA is at the header what rB is.
+	 * they are equal at loop entry too, rA is an induction variable with the same step.
 	 */
 	for (ra = 0; ra < REGS_NUM; ra++) {
 		if (header_env->reg2scev[ra] != UNKNOWN_EXPR_ID ||
@@ -2840,9 +2826,12 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
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
@@ -3072,7 +3061,7 @@ int bpf_compute_scev(struct bpf_verifier_env *env)
 		cond_resched();
 		header = bpf_loop_at_index(env, idx);
 		err = aux[idx].loop
-		      ? compute_header_scevs(env, find_header_env(scev, header))
+		      ? compute_header_scevs(env, header)
 		      : compute_insn_scevs(env,
 					   find_header_env(scev, header),
 					   find_loop_env(scev, header, idx));
@@ -3219,19 +3208,6 @@ static struct bpf_reg_state *scev_reg_for_linear(struct bpf_func_state *st, u32
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
@@ -3349,8 +3325,7 @@ static bool scev_reg_alive(struct bpf_verifier_env *env, struct bpf_verifier_sta
  * 'i' is the loop iteration number, starting from 0.
  * 'zext32' indicates the latch is for (zext32 (linear ...)) SCEV.
  * 'jmp32' indicates that the latch is a JMP32 instruction.
- * 'base_reg' is the register in <base>. 'copy_reg' is -1, or <reg> is made from that register,
- * which has to be equal to 'base_reg' at the entry of the loop, see COPY_SCEV.
+ * 'base_reg' is the register in <base>.
  */
 struct linear_latch {
 	u32 insn_idx;
@@ -3358,7 +3333,6 @@ struct linear_latch {
 	u32 step_expr;
 	u32 bound_expr;
 	u32 base_reg;
-	int copy_reg;
 	u8 op;
 	bool zext32;
 	bool jmp32;
@@ -3382,7 +3356,7 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	struct env *latch_env;
 	u32 src_reg_scev;
 	u32 dst_reg_scev;
-	u32 t, l, r, op;
+	u32 l, r, op;
 	int id;
 
 	op = BPF_OP(insn->code);
@@ -3412,11 +3386,6 @@ static int match_linear_latch(struct bpf_verifier_env *env,
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
@@ -4114,8 +4083,6 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 
 	iters->iv_reg = -1;
 
-	if (latch->copy_reg >= 0 && !scev_regs_equal(st, latch->copy_reg, latch->base_reg))
-		return false;
 	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
 	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
 	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
@@ -4451,49 +4418,15 @@ static bool is_simple_linear(struct scev *scev, u32 id, struct linear_coefs *out
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
@@ -4585,6 +4518,19 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 	out->r32 = r32;
 }
 
+/*
+ * Is @r the induction variable that the latch tests, or congruent to it: equal to it at the header
+ * of the loop at @h in every iteration? Then the range of the one is the range of the other.
+ */
+static bool is_iv_at_header(struct bpf_verifier_env *env, int h, int iv_reg, u32 r)
+{
+	s64 delta;
+
+	if (iv_reg < 0)
+		return false;
+	return r == iv_reg || (const_diff_at_header(env, h, iv_reg, r, &delta) && !delta);
+}
+
 static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
 {
 	struct cnum64 r64 = cnum64_intersect(bounds->r64, iv_range);
@@ -4902,7 +4848,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 			continue;
 		}
 		/* If SCEV for r is (linear <reg> <slope>) */
-		if (reg && is_linear_at_header(scev, cur_func, r_scev, r, &coefs) &&
+		if (reg && is_linear_at_header(scev, r_scev, r, &coefs) &&
 		    bpf_is_widenable_reg_type(reg)) {
 			/* 32-bit ALU operations on pointers convert them to scalars */
 			if (coefs.zext32 && reg->type != SCALAR_VALUE)
@@ -5118,7 +5064,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 		}
 
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (spill32 || is_linear_at_header(scev, entry_func, r_expr, r, &coefs)) {
+		if (spill32 || is_linear_at_header(scev, r_expr, r, &coefs)) {
 			/* the range is derived from @loop_entry: bpf_clamp_scev_regs() */
 			if (back)
 				continue;
@@ -5128,7 +5074,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			if (err)
 				return err;
 			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
-			if (coefs.base_reg == iters->iv_reg)
+			if (is_iv_at_header(env, insn_idx, iters->iv_reg, coefs.base_reg))
 				iv_bounds(&bounds, iters->iv_range);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
@@ -5166,7 +5112,6 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			mark_scev_reg_scratched(env, r);
 		}
 	}
-	link_copies(env, header_env, entry_func, cur_func);
 	return 1;
 }
 
@@ -5223,7 +5168,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			goto clamp;
 
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (!is_linear_at_header(scev, entry_st, r_scev, r, &coefs) &&
+		if (!is_linear_at_header(scev, r_scev, r, &coefs) &&
 		    !(behind && is_moved_linear(scev, r_scev, &coefs, &moved) &&
 		      coefs.base_reg == r))
 			continue;
@@ -5251,7 +5196,11 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			continue;
 clamp:
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
-		if (coefs.base_reg == entry->iv_reg && !moved)
+		/*
+		 * iv_range is the range at the header. After the latch @r can be the zero extension
+		 * of its header value. @reg went through that insn and has what holds of the range.
+		 */
+		if (!behind && is_iv_at_header(env, insn_idx, entry->iv_reg, coefs.base_reg))
 			iv_bounds(&bounds, entry->iv_range);
 		if (moved) {
 			/* a sum that can wrap has another residue, see scalar_step_add() */
@@ -5293,8 +5242,5 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			return err;
 		mark_scev_reg_scratched(env, r);
 	}
-	/* behind the jump the variable may have moved on: its copy is what it was at the head */
-	if (!behind)
-		link_copies(env, header_env, entry_st, cur_func_state);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index 35bb3e16db3d..17222e1332fd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -271,6 +271,51 @@ LOOP(copy_bad, "r8 = 0; r9 = r8;", COPY(2047))
 BAD("a copy of the counter, another number at the entry")
 LOOP(copy_other_const, "r8 = 2047; r9 = 0; r6 += 2047;", COPY(2046))
 
+/* the latch exits one iteration later than for an induction variable that starts from 1 */
+NO_COUNT("a copy of the counter, one more at the entry")
+LOOP(copy_ahead, "r8 = 0; r9 = 1;", COPY(2047))
+
+/* r5 is a copy of the pointer r6 from before the increment: an induction variable too */
+#define PTR_COPY(off)	"*(u8 *)(r5 + " #off ") = r1; r5 = r6; r8 += 1; if r8 < 2048 goto 1b;"
+
+OK("a copy of the pointer", "2048") __msg("widening r5 to 0..2047 step 1")
+LOOP(copy_of_pointer, "r5 = r6; r8 = 0;", PTR_COPY(0))
+
+BAD("a copy of the pointer, one too many")
+LOOP(copy_of_pointer_bad, "r5 = r6; r8 = 0;", PTR_COPY(1))
+
+/* r8 and r9 are computed in the same way from r7: equal by value number, 'r9 = r8' is not needed */
+OK("a copy of the counter, equal by value number", "[0..2]")
+LOOP(copy_same_value_number,
+     "r5 = r6; r8 = r7; r8 &= 1; r8 += 2045; r9 = r7; r9 &= 1; r9 += 2045;", COPY(2045) AT_R8)
+
+/*
+ * 'for (i = n; i > 0; i--) buf[i - 1] = 0;': r9 is i from before the decrement, the latch tests r8.
+ * r9 gets the range that the latch implies for r8.
+ */
+#define DOWN(off)								\
+	"r8 += -1; r2 = r5; r2 += r9; *(u8 *)(r2 " off ") = r1; r9 = r8; if r8 > 0 goto 1b;"
+#define FROM_RANGE	"if r7 > 2048 goto 9f; if r7 == 0 goto 9f; r5 = r6; r8 = r7; r9 = r7;"
+
+OK("a copy of the counter, down from a range", "[0..2048]")
+LOOP(copy_down_from_range, FROM_RANGE, DOWN("- 1"))
+
+BAD("a copy of the counter, down from a range, one too many")
+LOOP(copy_down_from_range_bad, FROM_RANGE, DOWN("+ 0"))
+
+/*
+ * r9 is zero extended. [1, 2048], its range at the header, is the range of the zero extension too.
+ * [-1000, 1001] is not: the first store is 4G behind the value.
+ */
+OK("a copy of the counter, zero extended", "[0..2048]")
+LOOP(copy_zext, FROM_RANGE, "w9 = w9;" DOWN("- 1"))
+
+SEC("socket") __description("latch: a copy of the counter, zero extended, from below 0")
+__failure __msg("R4 unbounded memory access")
+LOOP(copy_zext_bad, "r5 = r6; r8 = r7; r8 &= 255; r8 += -1000; r9 = r8;",
+     "w9 = w9; if r8 s> 1000 goto 9f; r4 = r5; r4 += r9; *(u8 *)(r4 + 1000) = r1;"
+     "r8 += 1; r9 = r8; if r7 != 0 goto 1b;")
+
 OK("a copy of the counter, a range", "[0..2]")
 LOOP(copy_range, "r5 = r6; r8 = r7; r8 &= 1; r8 += 2045; r9 = r8;", COPY(2045) AT_R8)
 
@@ -297,13 +342,13 @@ LOOP(copy_bounds_both, "r5 = r6; if r7 > 2047 goto 9f; r8 = r7; r9 = r8;",
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

