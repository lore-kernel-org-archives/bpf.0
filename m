Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494399;
	b=OoePEjbukHlDSAdjW9yPSNTb9IbRGvTwg0uIAbEFXDkp32bsBcr7q/Lzs+NXL/ZmbHzg
	 xrD28t12eOIEFSawLRZQs6aVknuyrzMbwIM0U1Zmo0NRrDRJx2kElp5Ft+cCamF8bZBk/
	 +cHepQknn0Z1uDKI2AEhIZdQoDSf/AJYouf5L/wwFeu50vZOwfRcd2xhCl1YW6CKtmQlz
	 GvBdSuCBEgKyZGnCQKp9jYy1nnL9wy7EYjSD/jiWv4RIb46JpGrCQRNl71/GzlFDt5lER
	 9Ze3lN3efXNN4uuPZR1fqgDEozEddbUdBShuLWzvQXfZ1ELQIRchgXKCTMqTAxcKk6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TcW3IbSfvrQubsVRgfuxbDLNsupkAyfFAb8eN70bAlQ=;
	b=L1/ZLHaB32wDhDqElsxMflq32BySkH4DNyiUU0yM9BgLBlMUjikjFqEnOyfd81d8dLQv
	 8LC3Msflb8mwPuzsZSxLIeS7ZL719rL3FnvcRicscfPr8AqAqXC2TrXDIA+8mswge+/SV
	 zwY6WoD6wX/teK0Nw/ki+WRk+ZgHLW1utu3D9OIUqbrx5N/jXPZ7FJpsDfz7TFVp+5NuN
	 5WMo/q+kwQx9v+ESPc6KRJextlh1Xg8exLXcycUWn38wnkAhj7oWIfDBVUuTfVxpGYZkv
	 J6SqMml3wdIFwfadHbNgmhx7hOb/bJZBXL3H6yW2ilYDedYBkIHdG6EAv2KYN9nPFJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XEUy4rB5;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E2606A324
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF8E2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XEUy4rB5
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1671747a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792494398; x=1793099198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TcW3IbSfvrQubsVRgfuxbDLNsupkAyfFAb8eN70bAlQ=;
        b=XEUy4rB5010/GwWuEx/VgsD4GbpbkCkonBQys4hCHqh5CsnBkYxkrgin1oAnYJuxlw
         OuVNYSKh26bx3yDU6iVlp5/Stp+4FPDxyLH5JMB/fqHNoj46hh7wuNX+q8aFucpuYS4+
         o2E3JNf6GyV1sSUSFjSwLGejZpFncsK2cd/DE9gnF32fRmzazhF21h3SGXJPeox20CeF
         l+QZ/S4O5ODugMiczvibTBULR7tuxwp8Fr6JTdrjQ7wlJrVVe7XFccf210pESi/N+C8R
         Ra1OOnRMQik/cVh5+NeMQri9kUNJ8XBAk6XuSuVBuRcV10/8dueED7cpNxok3a0RPczC
         VlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494398; x=1793099198;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcW3IbSfvrQubsVRgfuxbDLNsupkAyfFAb8eN70bAlQ=;
        b=23k1OEL7G2DV5400dsgZG5xz+F9cmNb5I+9/pmfoWs3xQ3kRuxeyh9Nek1EdVN42IA
         OnqOWcl+rFUY+YUUMECX3Kfs1moeImZDmIkGBfqdmvzEHqeIY+ETYQx1YL+WQyg2MRdg
         XC1nrTtf8fuNrFaCPtgsYbR+uxqxLcXZ1kVrdwiGiqMVq0pNCcBl/z8noCIM6vsMho7W
         o2FaMy/QJHXY1YysR8wKR9lxPQIP6PM+mZ1ZfbDmfXD8AkmizLIJY4HYiB6Dil7sRgyq
         jgsStuY8CFzNShhaedb88rr96PSucJmd2LqedgDMQNMNmZL9Hm7sHabHBd1rzY8wYgJ9
         PdSA==
X-Gm-Message-State: AFq9FYJDS2X6zaZNsof85DFgWqkMivWLpI3b3tZCJ9S3GWHSqWSEa3j7
	PGngygCGNK/2xEck2G+/EzK9Aq9UARSq5HUwJKdBRIPNSW+jAmS4HVGXUtZdFw==
X-Gm-Gg: AYBFou0N2I+WaDXRR/+Nvia/Xbq4PoAp0A2QTz06SOZr4JtkTnO9zFeQ+/wW09mb+gz
	BmYNfFunntIIpNh1l3OweTOpciI7rXA4TpZ0phHD96igIBX1rjeNQBctSsFEd6V5ctOs37dmrKZ
	+VVinV5PVQrXwHuaCJUJa/Ru23gY5174SBGvIisFU+vJ6E/PpxyVEKW+jcU4clwBZKh+J6IRP5K
	B9+A2sS9ue23nZvzy2BYrBOskp3VmeKaC9mnYFgcUFlDoqlJncipxcuKFomofQjXNqs4F7U/NES
	ZZRXi+GCP3m0P0H+kht2jVjTUNcoCEhh04oJo1Wr2VKYNUraSfG0YeyR/jjwo/guYmRLtcimyxv
	9bUMKdlGty3iGC95lk5aeT9pRC+ZYIfBRCpNsGPGrsgBTkrTAafg/b46BJpXTjmAuSStqkc7aLW
	ERZNXxKHeI1MiEa0ctXp26DxG2p2RkOec4h5Sakzitxk/v6TT5+WrHpKJqRskR9NaO1jZ0eForO
	7RjhkWoG+uzZ+A=
X-Received: by 2002:a17:90b:4fd2:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3aceebf6b88mr8986213a91.29.1792494398118;
        Tue, 20 Oct 2026 04:06:38 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f3425bsm3064392a91.8.2026.10.20.04.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:06:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: support 32-bit linear scalar evolution
Date: Tue, 20 Oct 2026 04:06:26 -0700
Message-ID: <20261020-scev-32bit-v1-1-838f34f9f0cd@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-scev-32bit-v1-0-838f34f9f0cd@gmail.com>
References: <20261020-scev-32bit-v1-0-838f34f9f0cd@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Representation
--------------

Represent ALU32 recurrences as:

  w0 += step  ->  (zext32 (linear r0 step))

Extend simplify() rules to maintain the above form for latch
expressions. E.g. for a post-condition loop such as:

     w0 = 0;
  l: w0 += 1;
     if w0 != 3 goto l;
     exit;

          SCEV at header: (zext32 (linear r0 1))
   Initial SCEV at latch: (zext32 (+ (zext32 (linear r0 1)) 1))
Simplified SCEV at latch: (zext32 (+ (zext32 (linear r0 1)) 1))
                          -> (zext32 (+ (linear r0 1) 1))
                          -> (zext32 (linear (+ r0 1) 1))

Iterations count computation
----------------------------

- Extract the main iteration-count logic from compute_max_iters() into
  compute_backedge_taken_count(). Reuse its 64-bit arithmetic after
  sign/zero extending the latch operands.

- Reject the computed count if the predicted exit value falls outside
  signed/unsigned 32-bit range, e.g.:

       w0 = 0x7ffffffe;
    l: w0 += 1;
       if w0 s<= 0x7fffffff goto l;

  The 64-bit computation predicts an exit at S32_MAX + 1, but the
  32-bit value wraps to S32_MIN and the comparison remains true.

- Handle mixed 64-bit/32-bit comparisons/recurrences only when initial
  bounds and step fit in 32-bit ranges, e.g.:

       w0 = 0;
       r1 = 0x100000003 ll;
    l: w0 += 1;
       if r0 != r1 goto l;

  Truncating the bound to 32 bits would predict three header visits.
  However, `w0 += 1` keeps r0 within [0, U32_MAX], so it can never
  be equal to the 64-bit bound.

Widened bounds computation
--------------------------

- Update linear_bounds() to truncate the initially computed 64-bit
  range to 32 bits, then zero-extend it to obtain the 64-bit range
  of iteration values. Step computation needs to handle:
  - unsigned 32-bit wraparound;
  - entry and zero-extended iteration values disagreeing on base/step.

- Union both ranges with the corresponding register ranges at entry,
  since the entry value need not be zero-extended.

- Extend `struct bounds` to keep both {32,64}-bit ranges and pass both
  to bpf_set_reg_range(). A 64-bit range alone loses useful 32-bit
  information, e.g.:

    entry = 0, step = -1, two header visits
    r64: [0, U32_MAX]
    r32: [-1, 0]

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h                       |   2 +-
 kernel/bpf/scev.c                                  | 364 +++++++++++++++------
 kernel/bpf/verifier.c                              |   6 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   2 +-
 4 files changed, 264 insertions(+), 110 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 951a90458d18..903d972ffc9f 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1885,7 +1885,7 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
 bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
 			    const struct bpf_reg_state *reg_b);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-		      struct cnum64 range, u16 base, u16 step);
+		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 		  const struct bpf_reg_state *src);
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 48500d73105a..fea77772ca96 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -249,6 +249,14 @@ static bool is_linear(struct scev *scev, int id, u32 *base, u32 *slope)
 	return is_binop(scev, LINEAR_SCEV, id, base, slope);
 }
 
+static bool is_linear_or_linear32(struct scev *scev, int id, u32 *base, u32 *slope, bool *zext32)
+{
+	u32 t;
+
+	*zext32 = is_zext32(scev, id, &t);
+	return is_linear(scev, *zext32 ? t : id, base, slope);
+}
+
 static bool is_opaque(struct scev *scev, int id)
 {
 	return is_op(scev, id, OPAQUE);
@@ -1464,7 +1472,7 @@ static int transform_expr(struct scev *scev, u32 root, void *priv,
 
 static int simplify(struct scev *scev, u32 id, void *priv)
 {
-	u32 l, r, base, slope;
+	int a, b, l, r, t, base, slope;
 	s64 imm1, imm2;
 
 	/* (+ (linear base slope) imm) -> (linear (+ base imm) slope) */
@@ -1483,13 +1491,24 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 	if (is_zext32(scev, id, &l) && is_imm(scev, l, &imm1))
 		return imm_expr(scev, (u64)(u32)imm1);
 
+	/*
+	 * (zext32 (+ (zext32 $a) $b)) -> (zext32 (+ $a $b))
+	 * (zext32 (+ $a (zext32 $b))) -> (zext32 (+ $a $b))
+	 */
+	if ((is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a)) ||
+	    (is_zext32(scev, id, &t) && is_add(scev, t, &a, &r) && is_zext32(scev, r, &b))) {
+		t = expr2(scev, BPF_ADD, a, b);
+		t = expr1(scev, ZEXT32, t);
+		return t;
+	}
+
 	return id;
 }
 
 static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header_env)
 {
 	struct scev *scev = env->scev;
-	int l, r, id, ra, rb, ra_expr;
+	int l, r, t, id, ra, rb, ra_expr;
 	s64 imm;
 
 	/*
@@ -1522,6 +1541,19 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 			header_env->reg2scev[ra] = id;
 			continue;
 		}
+		/* rA = (is_zext32 (+ rA IMM)) -> (is_zext32 (linear rA IMM)) */
+		if (is_zext32(scev, ra_expr, &t) &&
+		    is_add(scev, t, &l, &r) &&
+		    is_reg(scev, l, &rb) &&
+		    is_imm(scev, r, &imm) &&
+		    ra == rb) {
+			id = expr2(scev, LINEAR_SCEV, l, r);
+			id = expr1(scev, ZEXT32, id);
+			if (id < 0)
+				return id;
+			header_env->reg2scev[ra] = id;
+			continue;
+		}
 		/* rA = rA -> rA*/
 		if (is_reg(scev, ra_expr, &rb) && ra == rb) {
 			header_env->reg2scev[ra] = ra_expr;
@@ -1846,13 +1878,17 @@ static bool scev_reg_alive(struct bpf_verifier_env *env, struct bpf_verifier_sta
  * Linear latch represents a condition 'if <reg> <op> <loop invariant> goto <loop-header>',
  * where equation '<base> + i * <step> <op> <bound>' describes values taken by register <reg>,
  * 'i' is the loop iteration number, starting from 0.
+ * 'zext32' indicates the latch is for (zext32 (linear ...)) SCEV.
+ * 'jmp32' indicates that the latch is a JMP32 instruction.
  */
 struct linear_latch {
 	u32 insn_idx;
 	u32 base_expr;
 	u32 step_expr;
 	u32 bound_expr;
-	u32 op;
+	u8 op;
+	bool zext32;
+	bool jmp32;
 };
 
 static bool loop_invariant(struct scev *scev, u32 id)
@@ -1878,10 +1914,8 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	u32 t, l, r, op;
 	int id;
 
-	/* 32-bit arithmetic is not handled yet */
-	if (BPF_CLASS(insn->code) != BPF_JMP)
-		return false;
 	op = BPF_OP(insn->code);
+	latch->jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
 	/* Flip the condition if true branch jumps out of the loop. */
 	true_branch_tgt = latch_idx + bpf_jmp_offset(insn) + 1;
 	true_branch_loop = bpf_loop_at_index(env, true_branch_tgt);
@@ -1915,7 +1949,8 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	 *   'if <invariant> <op> <linear>' ⇔
 	 * 'if <linear> <flip(op)> <invariant>'.
 	 */
-	if (BPF_SRC(insn->code) == BPF_X && is_linear(scev, src_reg_scev, &l, &r)) {
+	if (BPF_SRC(insn->code) == BPF_X &&
+	    is_linear_or_linear32(scev, src_reg_scev, &l, &r, &latch->zext32)) {
 		swap(dst_reg_scev, src_reg_scev);
 		op = bpf_flip_opcode(op);
 	}
@@ -1928,7 +1963,8 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	 * - (linear (+ register imm) step)       |
 	 *           ^----------------------------'
 	 */
-	if (!is_linear(scev, dst_reg_scev, &latch->base_expr, &latch->step_expr))
+	if (!is_linear_or_linear32(scev, dst_reg_scev,
+				   &latch->base_expr, &latch->step_expr, &latch->zext32))
 		return false;
 
 	if (BPF_SRC(insn->code) == BPF_K) {
@@ -2049,64 +2085,23 @@ static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev,
 	return false;
 }
 
-/*
- * Loop with post-condition:
- *
- *    r0 = 0
- * l: ...                r0 ∈ [0,1,2] header executed 3 times
- *    r0 += 1            r0 ∈ [0,1,2]
- *    ...                r0 ∈ [1,2,3]
- *    if r0 != 3 goto l  r0 ∈ [1,2,3] backedge taken 2 times
- *    ...                r0 ∈ [3]
- *
- * SCEV at header: r0 = k
- * SCEV at latch:  r0 = 1 + k
- *
- * Loop with pre-condition:
- *
- *    r0 = 0
- * l: ...                r0 ∈ [0,1,2,3] header executed 4 times
- *    if r0 == 3 goto e  r0 ∈ [0,1,2,3] backedge taken 3 times
- *    r0 += 1            r0 ∈ [0,1,2]
- *    ...                r0 ∈ [1,2,3]
- *    goto l             r0 ∈ [1,2,3]
- * e: ...                r0 ∈ [3]
- *
- * SCEV at header: r0 = k
- * SCEV at latch:  r0 = k
- */
-static bool compute_max_iters(struct bpf_verifier_env *env,
-			      struct bpf_func_state *st,
-			      struct linear_latch *latch,
-			      struct bpf_loop_iters *iters)
+static bool is_signed_op(u8 op)
 {
-	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	struct bpf_loop *loop = aux[bpf_loop_at_index(env, latch->insn_idx)].loop;
-	struct scev *scev = env->scev;
-	struct scev_value initial_val, step_val, bound_val;
-	u64 rem, step, diff, bound, initial, backedge_taken_count;
-	u8 op = latch->op;
-	bool up, down;
-
-	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
-	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
-	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
-		return false;
-
-	if (step_val.ptr_reg >= 0) {
-		if (env->log.level & BPF_LOG_LEVEL2) {
-			bpf_log(&env->log, "scev: latch step is a pointer ");
-			log_scev_value(env, st, &step_val);
-			bpf_log(&env->log, "\n");
-		}
+	switch (op) {
+	case BPF_JSLT:
+	case BPF_JSLE:
+	case BPF_JSGT:
+	case BPF_JSGE:
+		return true;
+	default:
 		return false;
 	}
-	if (!scev_value_compatible(env, st, &initial_val, &bound_val))
-		return false;
+}
 
-	initial = initial_val.value;
-	step = step_val.value;
-	bound = bound_val.value;
+static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound, u64 *result)
+{
+	u64 rem, diff, backedge_taken_count;
+	bool up, down;
 
 	if (step == 0)
 		return false;
@@ -2217,6 +2212,115 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		return false;
 	}
 
+	*result = backedge_taken_count;
+	return true;
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
+	u64 step, bound, initial, total_change, backedge_taken_count;
+	u8 op = latch->op;
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
+	/*
+	 * The code below only handles mixed 64-bit/32-bit comparisons/recurrences
+	 * when initial bounds and step fit in 32-bit domain.
+	 */
+	if (latch->zext32 || latch->jmp32) {
+		/*
+		 * With the above constraint doing `l: w0 += 1; if r0 s< 256 goto l;`
+		 *                is equivalent to `l: w0 += 1; if r0 < 256 goto l;`
+		 */
+		if (latch->jmp32 && is_signed_op(op)) {
+			initial = (s64)(s32)(u32)initial;
+			bound   = (s64)(s32)(u32)bound;
+			step    = (s64)(s32)(u32)step;
+		} else {
+			initial = (u32)initial;
+			bound   = (u32)bound;
+			step    = (s64)(s32)(u32)step;
+		}
+	}
+	if (latch->zext32 ^ latch->jmp32 && (initial != initial_val.value ||
+					     bound != bound_val.value ||
+					     step != step_val.value)) {
+		if (env->log.level & BPF_LOG_LEVEL2)
+			bpf_log(&env->log,
+				"scev: mixed-width latch has operands outside 32-bit ranges\n");
+		return false;
+	}
+
+
+	if (!compute_backedge_taken_count(op, initial, step, bound, &backedge_taken_count))
+		return false;
+
+	if (latch->zext32 || latch->jmp32) {
+		/*
+		 * compute_backedge_taken_count() guarantees that 'total_change'
+		 * does not overflow in 64-bit domain.
+		 */
+		total_change = initial + step * backedge_taken_count;
+		if (latch->jmp32 && is_signed_op(op)) {
+			if ((s64)total_change < S32_MIN || (s64)total_change > S32_MAX)
+				return false;
+		} else {
+			if (total_change > U32_MAX)
+				return false;
+		}
+	}
+
 	/*
 	 * max_header_count is u32 and U32_MAX means "infinite",
 	 * check to avoid overflow below.
@@ -2337,40 +2441,92 @@ static bool is_widenable_any(struct bpf_verifier_env *env, struct bpf_func_state
 }
 
 struct bounds {
-	struct cnum64 range;
+	struct cnum64 r64;
+	struct cnum32 r32;
 	u16 base;
 	u16 step;
 };
 
-static bool is_simple_linear(struct scev *scev, u32 id, u32 *base_reg, s64 *slope_imm)
+static void log_bounds(struct bpf_verifier_env *env, const struct bounds *bounds)
+{
+	struct bpf_verifier_log *log = &env->log;
+
+	bpf_verbose_snum(env, cnum64_smin(bounds->r64));
+	bpf_log(log, "..");
+	bpf_verbose_snum(env, cnum64_smax(bounds->r64));
+	if (bounds->r32.size < U32_MAX) {
+		bpf_log(log, " (s32 ");
+		bpf_verbose_snum(env, cnum32_smin(bounds->r32));
+		bpf_log(log, "..");
+		bpf_verbose_snum(env, cnum32_smax(bounds->r32));
+		bpf_log(log, ")");
+	}
+	bpf_log(log, " step %u", bounds->step);
+}
+
+struct linear_coefs {
+	u32 base_reg;
+	s64 slope;
+	bool zext32;
+};
+
+static bool is_simple_linear(struct scev *scev, u32 id, struct linear_coefs *out)
 {
 	u32 base, slope;
 
-	return is_linear(scev, id, &base, &slope) &&
-	       is_reg(scev, base, base_reg) &&
-	       is_imm(scev, slope, slope_imm) &&
-	       *slope_imm <= S16_MAX &&
-	       *slope_imm >= S16_MIN &&
-	       *slope_imm != 0;
+	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) &&
+	       is_reg(scev, base, &out->base_reg) &&
+	       is_imm(scev, slope, &out->slope) &&
+	       out->slope <= S16_MAX &&
+	       out->slope >= S16_MIN &&
+	       out->slope != 0;
 }
 
-/*
- * Compute the range an induction variable in `reg` spans over the loop.
- * If the computation overflows s64 the range is unbounded, only the
- * power-of-two alignment survives the wraparound.
- */
-static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count, s64 slope,
-			  struct bounds *out)
+static struct cnum64 cnum64_zext32(struct cnum32 r32)
+{
+	return cnum64_from_urange(cnum32_umin(r32), cnum32_umax(r32));
+}
+
+/* Compute the range an induction variable in `reg` spans over the loop. */
+static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
+			  struct linear_coefs *coefs, struct bounds *out)
 {
+	s64 slope = coefs->slope;
 	s64 slope_abs = slope < 0 ? -slope : slope;
 	s64 min_val = reg_smin(reg);
 	s64 max_val = reg_smax(reg);
+	struct cnum64 r64;
+	struct cnum32 r32;
 	s64 total_change;
 	bool overflow;
 
 	overflow = check_mul_overflow(slope, (s64)max_header_count - 1, &total_change) ||
 		   (slope > 0 && check_add_overflow(max_val, total_change, &max_val)) ||
 		   (slope < 0 && check_add_overflow(min_val, total_change, &min_val));
+	r64 = overflow ? CNUM64_UNBOUNDED : cnum64_from_srange(min_val, max_val);
+	r32 = CNUM32_UNBOUNDED;
+	if (coefs->zext32) {
+		r32 = cnum32_from_cnum64(r64);
+		r64 = cnum64_zext32(r32);
+		/*
+		 * 32-bit iteration overflow is equivalent to subtracting N * 2**32:
+		 * (base + slope * k) % slope ≠ (base + slope * k - N * 2**32) % slope.
+		 */
+		overflow |= cnum32_contains(r32, 0) && cnum32_contains(r32, U32_MAX);
+		/*
+		 * The entry and zero-extended values must agree on how they define `base`,
+		 * otherwise `base + slope * k` would define different sets of points between
+		 * the two.
+		 */
+		overflow |= imod(reg_smin(reg), slope_abs) !=
+			    imod(cnum64_smin(r64), slope_abs);
+		/*
+		 * Full range is a union of a reg's value at loop entry,
+		 * plus a range produced by 32-bit iteration.
+		 */
+		r64 = cnum64_union(reg->r64, r64);
+		r32 = cnum32_union(reg->r32, r32);
+	}
 	/*
 	 * If the entry value is a single point the value set is 'v + slope * k',
 	 * so the step is |slope|. Otherwise, only the power-of-two alignment
@@ -2378,12 +2534,13 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count, s64 s
 	 */
 	if (cnum64_is_const(reg->r64) && !overflow) {
 		out->step = slope_abs;
-		out->base = imod(min_val, out->step);
+		out->base = imod(reg_smin(reg), out->step);
 	} else {
 		out->step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
 		out->base = 0;
 	}
-	out->range = overflow ? CNUM64_UNBOUNDED : cnum64_from_srange(min_val, max_val);
+	out->r64 = r64;
+	out->r32 = r32;
 }
 
 static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 id,
@@ -2419,16 +2576,16 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 	struct scev *scev = env->scev;
 	struct env *header_env;
 	struct linear_latch latch, best;
+	struct linear_coefs coefs;
 	struct bpf_backedge *backedge;
 	struct bpf_loop_iters tmp;
 	struct bpf_loop *loop;
 	int insn_idx = st->insn_idx;
 	bool found = false;
 	int linear_latch;
-	u32 r, base_reg;
 	int latch_idx;
-	s64 slope_imm;
 	int err, j;
+	u32 r;
 
 	if (!env->allow_uninit_stack)
 		return 0;
@@ -2542,8 +2699,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		r_scev = header_env->reg2scev[r];
 		reg = scev_reg_for_linear(cur_func, r);
 		/* If SCEV for r is (linear <reg> <slope>) */
-		if (is_simple_linear(scev, r_scev, &base_reg, &slope_imm) &&
-		    reg && is_widenable_reg_type(reg)) {
+		if (reg && is_simple_linear(scev, r_scev, &coefs) && is_widenable_reg_type(reg)) {
 			/* Spills at varying offsets lose precision */
 			if (test_bit(r, loop->store_base_regs)) {
 				spill_base = true;
@@ -2639,10 +2795,10 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 	struct scev *scev = env->scev;
 	struct bpf_reg_state *reg;
 	struct env *header_env;
+	struct linear_coefs coefs;
 	struct bounds bounds;
-	u32 r, base_reg, r_expr, a, b;
+	u32 r, r_expr, a, b;
 	int insn_idx = st->insn_idx;
-	s64 slope_imm;
 	int err;
 
 	for_each_set_bit(r, iters->precise_regs, REGS_NUM) {
@@ -2662,23 +2818,21 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 
 		r_expr = header_env->reg2scev[r];
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (is_simple_linear(scev, r_expr, &base_reg, &slope_imm) &&
-		    base_reg == r) {
+		if (is_simple_linear(scev, r_expr, &coefs) && coefs.base_reg == r) {
 			err = scev_reg_for_write(env, cur_func, r, &reg);
 			if (err)
 				return err;
-			linear_bounds(reg, iters->max_header_count, slope_imm, &bounds);
+			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
 				log_reg(env, r);
 				bpf_log(log, " to ");
-				bpf_verbose_snum(env, cnum64_smin(bounds.range));
-				bpf_log(log, "..");
-				bpf_verbose_snum(env, cnum64_smax(bounds.range));
-				bpf_log(log, " step %u\n", bounds.step);
+				log_bounds(env, &bounds);
+				bpf_log(log, "\n");
 			}
 			scratch_widened_reg_id(env, reg);
-			err = bpf_set_reg_range(env, reg, bounds.range, bounds.base, bounds.step);
+			err = bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
+						bounds.base, bounds.step);
 			if (err)
 				return err;
 			mark_scev_reg_scratched(env, r);
@@ -2712,10 +2866,10 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_reg_state *reg, *entry_reg;
 	struct scev *scev = env->scev;
+	struct linear_coefs coefs;
 	struct env *header_env;
 	struct bounds bounds;
-	u32 r, base_reg;
-	s64 slope_imm;
+	u32 r;
 	int err;
 
 	if (entry_state->curframe != cur_func_state->frameno) {
@@ -2727,8 +2881,8 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (!is_simple_linear(scev, header_env->reg2scev[r], &base_reg, &slope_imm) ||
-		    base_reg != r)
+		if (!is_simple_linear(scev, header_env->reg2scev[r], &coefs) ||
+		    coefs.base_reg != r)
 			continue;
 
 		entry_reg = scev_reg_for_linear(entry_st, r);
@@ -2737,9 +2891,10 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		    is_unbound_scev_reg(env, entry_st, r))
 			continue;
 
-		linear_bounds(entry_reg, max_header_count, slope_imm, &bounds);
-		bounds.range = cnum64_intersect(reg->r64, bounds.range);
-		if (cnum64_is_empty(bounds.range)) {
+		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
+		bounds.r64 = cnum64_intersect(reg->r64, bounds.r64);
+		bounds.r32 = cnum32_intersect(reg->r32, bounds.r32);
+		if (cnum64_is_empty(bounds.r64)) {
 			verifier_bug(env, "scev clamp produced empty range for r%d", r);
 			return -EFAULT;
 		}
@@ -2747,13 +2902,12 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			bpf_log(log, "loop header at %d, clamping ", insn_idx);
 			log_reg(env, r);
 			bpf_log(log, " to ");
-			bpf_verbose_snum(env, cnum64_smin(bounds.range));
-			bpf_log(log, "..");
-			bpf_verbose_snum(env, cnum64_smax(bounds.range));
-			bpf_log(log, " step %u\n", bounds.step);
+			log_bounds(env, &bounds);
+			bpf_log(log, "\n");
 		}
 		scratch_widened_reg_id(env, reg);
-		err = bpf_set_reg_range(env, reg, bounds.range, bounds.base, bounds.step);
+		err = bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
+					bounds.base, bounds.step);
 		if (err)
 			return err;
 		mark_scev_reg_scratched(env, r);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d13868846823..ea26da040ff9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17587,10 +17587,10 @@ bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
 }
 
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-		      struct cnum64 range, u16 base, u16 step)
+		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
 {
-	reg->r64 = range;
-	reg->r32 = CNUM32_UNBOUNDED;
+	reg->r64 = r64;
+	reg->r32 = r32;
 	reg->step = step;
 	reg->base = base;
 	reg->var_off = tnum_unknown;
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 3e9d8fc606ae..7fa7bc207850 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -605,7 +605,7 @@ __msg("R7=fp(smin=smin32=-64,smax=smax32=-8")
  * back-edge state is clamped to the remaining iterations and pruned
  * at the header, because [-64, -16] is within the widened [-72, -16]
  */
-__msg("loop header at 3, clamping r7 to -64..-16 step 8")
+__msg("loop header at 3, clamping r7 to -64..-16 (s32 -64..-8) step 8")
 __msg("from 5 to 3: safe")
 __msg("processed 9 insns")
 __naked void stack_ptr_subrange_in_loop(void)

-- 
2.53.0
