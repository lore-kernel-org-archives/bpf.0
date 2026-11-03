Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749398;
	b=0zjzve/lmWDZiQhG0xVZmfuKKXKug5bdQcf+2yG+bZxae/5ono8LQy4PpaiwMtBQ1ikM
	 ASrChplSZv8FDLLzznktLSKt7l1ivh7bUm9p0TqWkvxPC+HAWRMP76mWT0Er9Otjhu+Vz
	 +vJYiQ7ry6Xx2YLIufU2GqL1ul/pCgt5aV4K3Ia55JLjup0y7p12ghLZHm9fWV5GUH0/D
	 VkMIli6+6vj/+IE8kNqBH/Rz/ifASjtnuxlqlfgm6OzuoCEnxqQgArbCIwWh4X8b1mj/A
	 yfF8apFtoKJcrlZWotWyK442NTVIJokVhgP6QhuxsRfXzO6B8qJO2wQqeBjhkss7llg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i66L/69vZaY292rtwKA6Cr3gKyM+w4tBXRaYVyWqvN0=;
	b=yOsV9T9BQwpy+puRMoUhuJtsKlmIGIP+VnT+KcvKc7kEAxjm1gQYEPL7grS8myIYflcI
	 yO97g4xsY6qXFvVc7M6PryGJ6lqjOguPOJaWmUlt6ZAgFJVmTe2TzumFc0pxPEIS8wqa2
	 OAyt/cxeSQ8x7QWNHH5lZEAjHZNjDTqddDaL2eD4UfVUXRwjtpZ/mPYEe9bIzFwrC78H0
	 zPSroerDEHp3budaHcrK3rOJfCZxwPJhyW+XCIV3srh7zdT3lR2WYK2nfK62jJETosUVc
	 tNVQRgPzjjIXR4QwmMPeOTcYAWPilCiIUHNxNdH4FDQeYvUxohaPG+1FGTdPuXXAeQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n5NxjszK;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9D606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D9D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n5NxjszK
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e987a2ba0cso388165ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749397; x=1794354197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i66L/69vZaY292rtwKA6Cr3gKyM+w4tBXRaYVyWqvN0=;
        b=n5NxjszKTvtaEXL0L3kxfdzFYZm+pHDrZOl6BnaGVFJBDjmO2/ERWjmc4jxlkUHc2e
         siXZ+OcMLGojWe2CYjZfUXHi21MDVustoIyygLMaFZMFXyEx3XzykoRatErnSjlELYC6
         y0A31pHkffvLWp2juMl+K4XIE0/IzUbtzE8CWbWM47PrUv4jwfGufyoYXh75qYtAdAhC
         c0dJmDRjXSdaPCRzVtQ4jTiHUN1z8Qw4A7QrmHPwP+i7EcrS5eea68awwlfgheGZhmOq
         h4ePz+aQfTi3NkZedHkKhzT1x7IQePri9oJnv1rWFcizLTW5OyMQb+X075gVMOxdDQKZ
         GOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749397; x=1794354197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i66L/69vZaY292rtwKA6Cr3gKyM+w4tBXRaYVyWqvN0=;
        b=SBp4K3Zu6yQiSzxXdeLJ5QqPWWtV0EzIx6oatAsWGQXYOm6AXDTXQZY24guBOR42Zr
         7HmUPg4DBiSGyrBGAPcSrS0p1VepS9tu28xQEwknvMM5URhXSOCAGSWCldVC8NVqB9S1
         F9fggAG4qJ0/fUnLQxoRIYqhMa/jL1pgy8VzisRmb4/fHNeu6VJJTgsnJ5iHx+0688xF
         YeDZ1Uu/WCEVVM0ssp6qt6DRzFS9iidU7k2T/e5H+11t/6iccc8NF7gQq8g5BdAwqErT
         Lt2f6KV0OMahpprZzTTWEyq2Rr756jk7xmRRSeiw4MNaNHpo4ryxfC9BjDCFIKsEPl6e
         Q07Q==
X-Gm-Message-State: APuU4Z+GFZWREiiBT2RDVrp6UsVumI6iU5rGWXfxRFV13NKauMjLtoWX
	hkGHzRYv6XEAYgeLcU4f/edkZFE0Z0qyzE0yeBX9aYCTtpHdVTMgjL9EJs2JsA==
X-Gm-Gg: AYBFou0VsSH+fx7yqGzjjgaIsf+lmIBVoeriswVhgeVhrOOvBonZRsqnaI45j7rPd92
	7RlW6ZyV7xSz7CtYWJwDyMHSlT8oNuTynJJ1IrYot1Z3oIjmShydiXo44rPtpyYbYylOGGEgYF1
	meddhz0urj9xhlqbKjQrkRMghy2nn4qXWVqKFYJp875sZkUgnCJf/WeXHmMT0FFrq3ZOHSmdm+A
	p1dnMh3jnq3YkI4u1HC9NInJ9hsLrxTw6/83bkxQJtPz1mR3lH6k4tWxR97jLSHeoEbDR0MlUx6
	sie0hOKhOKarqo/OgtsRLo528Y3DaNxG8JThdun9fWP6ekJcwFUouM9b83tIdoasSnYZFfRbINZ
	yUITAO/ALamNbjkXUKhJPj8vfsshlIJqNkzx6/FRXPfHE18LFCRyPtDy7kGm7HKAFs3jz0tSN/o
	vw9SoCw6RRwIx06CmnjyMAVZ3/K7yoyKSOIDHbvYXzcRNxTaQPtS4xXC0Mm3tDWFl/fMQyoVm8M
	48Qep8RRSCJVIbzlk2ULCrUjX4aan7zvQGbggKS9kC2j3v768pJJ8NqbJRqpENqcyn3U2H9XUu7
	N8zD8t6nU/PuqctiO0no2tp7hyelaRRYGgZJmOjaFqTyl6p2Qmb/1zAD/EuUf45K2gHrs5QuTfu
	iGqSpFTW7CaAqd3m2SKj2mZrNEQxPVfVmFFKoiTPcoYlO/viLM3NYeu9vwhk7hiBWx2Th0jOvmw
	==
X-Received: by 2002:a17:903:1cc:b0:2e5:6158:b9c1 with SMTP id d9443c01a7336-2eb364e0730mr143094615ad.47.1793749396907;
        Tue, 03 Nov 2026 15:43:16 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed09152ec5sm392425ad.56.2026.11.03.15.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 22/37] bpf: Describe a 32-bit counter that lives on the stack
Date: Tue,  3 Nov 2026 23:40:47 +0000
Message-ID: <20261103234104.208239-23-alexei.starovoitov@gmail.com>
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

A compiler that has no free register for 'int i' keeps the counter of a
loop in a stack slot:

  1: r2 = *(u32 *)(r10 - 40)
     w2 += 1
     *(u32 *)(r10 - 40) = r2
     if w2 != 200 goto 1b

Scalar evolution has a formula for a counter in a register and for a
counter in a 64-bit slot. It has no formula for this one. Thus the loop has
no count, and the verifier unrolls it:

  *fp-40=(spill32 (zext32 (+ *fp-40 1))) / ?
  loop header at 2, non-linear latch at 5

A 32-bit store writes the low half of the slot, and a 32-bit load reads it
back. Only the low half of the sum gets to the slot. Thus the low half is
'first value + step * k' modulo 2^32 in iteration k. That is the formula of
a register that is computed in 32 bits:

  *fp-40=(spill32 (+ *fp-40 1)) / (spill32 (linear (zext32 *fp-40) 1))
  loop header at 2, header_count is 200
  loop header at 2, widening *fp-40 to 0..199 step 1

 - (spill32 x) says nothing about the other half of the slot. The verifier
   changes the range of the 32-bit number only. The slot must hold such a
   number when the loop starts.
 - The last store to the slot in an iteration must be the 32-bit store of
   'load + constant'. There is no formula if a store of a different size,
   a store to the other half or a store through a pointer comes after it.
 - A jump often tests a second load of the counter. With the formula of the
   loop head in it that is deeper than 8 levels: simplify it first.
 - On big endian this is the high half of the slot. It has no formula.

The counter has a range now, and the verifier never goes back to one
iteration at a time. A loop that passes '&i' as the key of a lookup in an
array still needs no NULL check: the range of the key is sufficient since
commit c1e03c8479e3 ("bpf: A lookup in an array is not NULL when the
largest key is below max_entries").

5 progs of scx, libarena and bpfjailer have such a loop. They need up to
92 % fewer insns (239986 -> 18034).

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 188 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 164 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index e0d71df9c0b4..b41c2d4d98b4 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -239,6 +239,16 @@ static bool is_zext32(struct scev *scev, int id, u32 *left)
 	return is_unop(scev, ZEXT32, id, left);
 }
 
+/* The low half of the slot is the low half of @left. The other half is not known. */
+static bool is_spill32(struct scev *scev, int id, u32 *left)
+{
+#ifdef __BIG_ENDIAN
+	/* '*(u32 *)(r10 - 8) = rX' writes the high half, see mk_fill() */
+	return false;
+#endif
+	return is_unop(scev, SPILL32, id, left);
+}
+
 static bool is_any(struct scev *scev, int id, u32 *left, u32 *right)
 {
 	return is_binop(scev, ANY, id, left, right);
@@ -257,6 +267,14 @@ static bool is_linear_or_linear32(struct scev *scev, int id, u32 *base, u32 *slo
 	return is_linear(scev, *zext32 ? t : id, base, slope);
 }
 
+/* What a register is at the entry of the loop, or the low half of that. */
+static bool is_reg_or_low32(struct scev *scev, int id, u32 *reg)
+{
+	u32 t;
+
+	return is_reg(scev, id, reg) || (is_zext32(scev, id, &t) && is_reg(scev, t, reg));
+}
+
 static bool is_opaque(struct scev *scev, int id)
 {
 	return is_op(scev, id, OPAQUE);
@@ -1546,6 +1564,26 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 	if (is_zext32(scev, id, &a) && is_zext32(scev, a, &b))
 		return a;
 
+	/*
+	 * '*(u32 *)(r10 - 8) = rX' stores the low half of rX:
+	 * (spill32 (zext32 $a)) -> (spill32 $a)
+	 * (spill32 (+ (zext32 $a) $b)) -> (spill32 (+ $a $b))
+	 */
+	if (is_spill32(scev, id, &t) && is_zext32(scev, t, &a))
+		return expr1(scev, SPILL32, a);
+	if (is_spill32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a))
+		return expr1(scev, SPILL32, expr2(scev, BPF_ADD, a, b));
+
+	/*
+	 * 'rX = *(u32 *)(r10 - 8)' loads what was stored:
+	 * (zext32 (spill32 $a)) -> (zext32 $a)
+	 * (zext32 (+ (spill32 $a) $b)) -> (zext32 (+ $a $b))
+	 */
+	if (is_zext32(scev, id, &t) && is_spill32(scev, t, &a))
+		return expr1(scev, ZEXT32, a);
+	if (is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_spill32(scev, l, &a))
+		return expr1(scev, ZEXT32, expr2(scev, BPF_ADD, a, b));
+
 	return id;
 }
 
@@ -1598,6 +1636,22 @@ static int compute_header_scevs(struct bpf_verifier_env *env, struct env *header
 			header_env->reg2scev[ra] = id;
 			continue;
 		}
+		/*
+		 * rA = (spill32 (+ rA IMM)) -> (spill32 (linear (zext32 rA) IMM))
+		 * The low half of the slot counts. Nothing is known about the other half.
+		 */
+		if (is_spill32(scev, ra_expr, &t) &&
+		    is_add(scev, t, &l, &r) &&
+		    is_reg(scev, l, &rb) &&
+		    is_imm(scev, r, &imm) &&
+		    ra == rb) {
+			id = expr2(scev, LINEAR_SCEV, expr1(scev, ZEXT32, l), r);
+			id = expr1(scev, SPILL32, id);
+			if (id < 0)
+				return id;
+			header_env->reg2scev[ra] = id;
+			continue;
+		}
 		/* rA = rA -> rA*/
 		if (is_reg(scev, ra_expr, &rb) && ra == rb) {
 			header_env->reg2scev[ra] = ra_expr;
@@ -1632,7 +1686,13 @@ static int compute_insn_scevs(struct bpf_verifier_env *env, struct env *eheader,
 	int id, reg;
 
 	for (reg = 0; reg < REGS_NUM; reg++) {
-		id = einsn->reg2expr[reg];
+		/*
+		 * Simplify first. 'store, load, test' of a 32-bit counter on the stack with the
+		 * equation of the header in it is deeper than EXPR_STACK_DEPTH.
+		 */
+		id = transform_expr(scev, einsn->reg2expr[reg], NULL, simplify);
+		if (id < 0)
+			return id;
 		id = transform_expr_once(scev, 0, id, eheader->reg2scev, instantiate_header_scevs);
 		if (id < 0)
 			return id;
@@ -1827,6 +1887,16 @@ static struct bpf_reg_state *scev_reg_for_linear(struct bpf_func_state *st, u32
 	return &stack->spilled_ptr;
 }
 
+/* '*(u32 *)(r10 - 8) = rX' left a number in the low half of the slot. */
+static struct bpf_reg_state *scev_reg_for_spill32(struct bpf_func_state *st, u32 r)
+{
+	struct bpf_stack_state *stack = scev_regno_to_stack(st, r);
+
+	if (!stack || bpf_spill_size(stack) != 4 || stack->spilled_ptr.type != SCALAR_VALUE)
+		return NULL;
+	return &stack->spilled_ptr;
+}
+
 /*
  * Return a borrowed value; never use it as a widening destination.
  * NULL denotes no readable value.
@@ -2010,6 +2080,7 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	 *           base_expr                    |
 	 * - (linear (+ register imm) step)       |
 	 *           ^----------------------------'
+	 * 'register' is (zext32 *fp-8) for a 32-bit counter on the stack.
 	 */
 	if (!is_linear_or_linear32(scev, dst_reg_scev,
 				   &latch->base_expr, &latch->step_expr, &latch->zext32))
@@ -2029,12 +2100,12 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 		return false;
 
 	/* (linear register step) */
-	if (is_reg(scev, latch->base_expr, &t))
+	if (is_reg_or_low32(scev, latch->base_expr, &t))
 		return true;
 
 	/* (linear (+ register imm) step) */
 	if (is_add(scev, latch->base_expr, &l, &r) &&
-	    is_reg(scev, l, &t) &&
+	    is_reg_or_low32(scev, l, &t) &&
 	    loop_invariant(scev, r))
 		return true;
 
@@ -2165,6 +2236,16 @@ static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev,
 		result->s32_max = reg_s32_max(reg);
 		result->ptr_reg = reg->type == SCALAR_VALUE ? -1 : (int)regno;
 		return true;
+	} else if (is_zext32(scev, id, &l) && is_reg(scev, l, &regno)) {
+		reg = scev_reg_for_spill32(st, regno);
+		if (!reg)
+			return false;
+		result->umin = result->smin = result->u32_min = reg_u32_min(reg);
+		result->umax = result->smax = result->u32_max = reg_u32_max(reg);
+		result->s32_min = reg_s32_min(reg);
+		result->s32_max = reg_s32_max(reg);
+		result->ptr_reg = -1;
+		return true;
 	} else if (is_imm(scev, id, &imm)) {
 		result->umin = result->umax = imm;
 		result->smin = result->smax = imm;
@@ -2401,8 +2482,8 @@ static void latch_iv_range(struct bpf_verifier_env *env, struct bpf_func_state *
 	s64 c = 0;
 
 	l = latch->base_expr;
-	if (!is_reg(scev, l, &regno)) {
-		if (!is_add(scev, latch->base_expr, &l, &r) || !is_reg(scev, l, &regno) ||
+	if (!is_reg_or_low32(scev, l, &regno)) {
+		if (!is_add(scev, latch->base_expr, &l, &r) || !is_reg_or_low32(scev, l, &regno) ||
 		    !eval_expr(env, scev, st, r, &off) || !scev_value_is_const(&off) ||
 		    off.ptr_reg >= 0)
 			return;
@@ -2474,7 +2555,7 @@ static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_
 	 */
 	if (latch->zext32 && !latch->jmp32) {
 		l = latch->base_expr;
-		if (!is_reg(scev, l, &r) && !is_add(scev, latch->base_expr, &l, &r))
+		if (!is_reg_or_low32(scev, l, &r) && !is_add(scev, latch->base_expr, &l, &r))
 			return false;
 		if (!eval_expr(env, scev, st, l, &reg_val) || reg_val.umax > U32_MAX)
 			return false;
@@ -2881,18 +2962,47 @@ struct linear_coefs {
 	u32 base_reg;
 	s64 slope;
 	bool zext32;
+	/* the low half of a stack slot */
+	bool spill32;
 };
 
+static bool is_simple_slope(struct scev *scev, u32 id, s64 *slope)
+{
+	return is_imm(scev, id, slope) &&
+	       *slope <= S16_MAX &&
+	       *slope >= S16_MIN &&
+	       *slope != 0;
+}
+
 static bool is_simple_linear(struct scev *scev, u32 id, struct linear_coefs *out)
 {
 	u32 base, slope;
 
+	out->spill32 = false;
 	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) &&
 	       is_reg(scev, base, &out->base_reg) &&
-	       is_imm(scev, slope, &out->slope) &&
-	       out->slope <= S16_MAX &&
-	       out->slope >= S16_MIN &&
-	       out->slope != 0;
+	       is_simple_slope(scev, slope, &out->slope);
+}
+
+/*
+ * A 32-bit counter that lives on the stack: the SCEV of slot @r is
+ * (spill32 (linear (zext32 @r) slope)) and there is a 32-bit number in the slot in @st.
+ * Return what is known about that number.
+ */
+static struct bpf_reg_state *spill32_counter(struct scev *scev, struct bpf_func_state *st,
+					     u32 id, u32 r, struct linear_coefs *out)
+{
+	u32 t, base, slope;
+
+	if (!is_spill32(scev, id, &t) ||
+	    !is_linear(scev, t, &base, &slope) ||
+	    !is_zext32(scev, base, &t) ||
+	    !is_reg(scev, t, &out->base_reg) || out->base_reg != r ||
+	    !is_simple_slope(scev, slope, &out->slope))
+		return NULL;
+	out->zext32 = true;
+	out->spill32 = true;
+	return scev_reg_for_spill32(st, r);
 }
 
 static struct cnum64 cnum64_zext32(struct cnum32 r32)
@@ -2906,13 +3016,22 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 {
 	s64 slope = coefs->slope;
 	s64 slope_abs = slope < 0 ? -slope : slope;
-	s64 min_val = reg_smin(reg);
-	s64 max_val = reg_smax(reg);
+	struct bpf_reg_state low;
+	s64 min_val, max_val;
 	struct cnum64 r64;
 	struct cnum32 r32;
 	s64 total_change;
 	bool overflow;
 
+	if (coefs->spill32) {
+		/* what 'rX = *(u32 *)(r10 - 8)' loads */
+		low = *reg;
+		low.var_off = tnum_subreg(reg->var_off);
+		low.r64 = cnum64_zext32(reg->r32);
+		reg = &low;
+	}
+	min_val = reg_smin(reg);
+	max_val = reg_smax(reg);
 	overflow = check_mul_overflow(slope, (s64)max_header_count - 1, &total_change) ||
 		   (slope > 0 && check_add_overflow(max_val, total_change, &max_val)) ||
 		   (slope < 0 && check_add_overflow(min_val, total_change, &min_val));
@@ -2981,7 +3100,7 @@ static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state
 		if (!(order & PRE) || !is_reg(scev, id, &r))
 			continue;
 		/* Synthetic values have no spilled register to mark precise. */
-		reg = scev_reg_for_linear(st, r);
+		reg = scev_reg_for_linear(st, r) ?: scev_reg_for_spill32(st, r);
 		if (reg && reg->type == SCALAR_VALUE)
 			__set_bit(r, precise_regs);
 	}
@@ -3147,6 +3266,17 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 
 		if (!scev_reg_alive(env, st, r))
 			continue;
+
+		r_scev = header_env->reg2scev[r];
+		if (spill32_counter(scev, cur_func, r_scev, r, &coefs)) {
+			/* There is no exact offset to lose if nothing is known about the number */
+			if (test_bit(r, loop->store_base_regs) &&
+			    is_known_partial_spill(cur_func, r)) {
+				spill_base = true;
+				goto cant_widen;
+			}
+			continue;
+		}
 		/*
 		 * A heuristic:
 		 * Ignore SCEVs computed for unbound values and treat those as widened.
@@ -3175,7 +3305,6 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		if (is_const_scev_reg(env, insn_idx, r))
 			continue;
 
-		r_scev = header_env->reg2scev[r];
 		reg = scev_reg_for_linear(cur_func, r);
 		/*
 		 * The offset of a pointer to arena is not tracked: what enters the loop stands
@@ -3299,7 +3428,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 	struct bpf_func_state *entry_func = loop_entry->frame[loop_entry->curframe];
 	struct bpf_verifier_log *log = &env->log;
 	struct scev *scev = env->scev;
-	struct bpf_reg_state *reg;
+	struct bpf_reg_state *reg, *spill32;
 	struct env *header_env;
 	struct linear_coefs coefs;
 	struct bounds bounds;
@@ -3319,8 +3448,13 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
-		if (!scev_reg_alive(env, st, r) || is_unbound_scev_reg(env, cur_func, r) ||
-		    is_const_scev_reg(env, insn_idx, r))
+		if (!scev_reg_alive(env, st, r))
+			continue;
+
+		r_expr = header_env->reg2scev[r];
+		spill32 = spill32_counter(scev, cur_func, r_expr, r, &coefs);
+		if (!spill32 && (is_unbound_scev_reg(env, cur_func, r) ||
+				 is_const_scev_reg(env, insn_idx, r)))
 			continue;
 
 		reg = scev_reg_for_linear(cur_func, r);
@@ -3343,10 +3477,11 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			continue;
 		}
 
-		r_expr = header_env->reg2scev[r];
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (is_simple_linear(scev, r_expr, &coefs) && coefs.base_reg == r) {
-			err = scev_reg_for_write(env, cur_func, r, &reg);
+		if (spill32 || (is_simple_linear(scev, r_expr, &coefs) && coefs.base_reg == r)) {
+			/* the other half of the slot stays as it is */
+			reg = spill32;
+			err = reg ? 0 : scev_reg_for_write(env, cur_func, r, &reg);
 			if (err)
 				return err;
 			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
@@ -3403,7 +3538,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 	struct linear_coefs coefs;
 	struct env *header_env;
 	struct bounds bounds;
-	u32 r;
+	u32 r, r_scev;
 	int err;
 
 	if (entry_state->curframe != cur_func_state->frameno) {
@@ -3414,9 +3549,14 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 
 	header_env = find_header_env(scev, insn_idx);
 	for (r = 0; r < REGS_NUM; r++) {
+		r_scev = header_env->reg2scev[r];
+		entry_reg = spill32_counter(scev, entry_st, r_scev, r, &coefs);
+		reg = spill32_counter(scev, cur_func_state, r_scev, r, &coefs);
+		if (entry_reg && reg)
+			goto clamp;
+
 		/* If SCEV for r is (linear <reg> <slope>)*/
-		if (!is_simple_linear(scev, header_env->reg2scev[r], &coefs) ||
-		    coefs.base_reg != r)
+		if (!is_simple_linear(scev, r_scev, &coefs) || coefs.base_reg != r)
 			continue;
 
 		entry_reg = scev_reg_for_linear(entry_st, r);
@@ -3440,7 +3580,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		if (!is_widenable_reg_type(entry_reg) ||
 		    (coefs.zext32 && entry_reg->type != SCALAR_VALUE))
 			continue;
-
+clamp:
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
 		if (r == entry->iv_reg)
 			iv_bounds(&bounds, entry->iv_range);
-- 
2.55.0

