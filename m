Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749315;
	b=Wy/oi7S7MPuX/7CUcBbaBYCVpy480WafO5JSioPqstjvaJqCLb12A04LhrUStDKJceGC
	 sLUd4KX/Lm7yCxb9J7xNtddSJ0jxt/hOnmVJBbHYlm6UlCDTP1n0ZDRUx88KHDPSi7MyS
	 6ef2HaJFT2Bhhq3uGgSnAwyzCNOU4MtXQKvdotYQKCIpa3pCWW1mn0xflF078Wfc9WdSy
	 3zOR9FgZ9Yy2lxXWBwApkOWjDoQLdRhP8ETHIHQxcYimEG38JLIQ/9syFcAqBIXlBUclM
	 9vD4dqegdlYqwI7jOC+PauCytDim5t8O5y/bObVy1wfLKCpGgUfW4IvRCe9denV/NQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9zzAb+wsllW8+muRqP8E/muffLWDQ0tFptZ4gg31Fww=;
	b=KRtjlLqpK8cLjNtlMmK8kX9J/1uPMw+OuAVTkzx4vZAj07Jk9B9bL8DZHaHD4s9yMIg+
	 cFMdkVtgcG4IdqukHgWvQ569TM/HW7RzsCA+Q1XTFpqiXbJXluFzV69IUIOYBrViom13C
	 MWG4hchFbQ1wRonSKsRUmGENq+WP4qsvhUOPJ40iRk0dH317AY/V2kwQsK1USUW8cFMUt
	 cBHCk1s/riycQMq1AD+xta4XA2rQmAjn12tyLdL7UKsh4Qp9nD0qyMULCZUo7Z3pj9Nsp
	 7/Pjf7EOf2dNFyvyKoA7t8SdwKE5YBkiiZCuC2AUmXBR1Q/hiZ8V4sxsVaYCBEBNrrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zkqj5GdP;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56C606A332
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C56C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zkqj5GdP
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a058315c79so74373b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749315; x=1794354115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9zzAb+wsllW8+muRqP8E/muffLWDQ0tFptZ4gg31Fww=;
        b=Zkqj5GdPhBEi79GnySVx3/Ahl3uHK+I4QSQOkasOUlCcLkALKtK7d32kjC82UKIYB2
         /qv26CK7cPPgjDuyofWMc8ZSMMveAP9ib27P1aCQ5o0cnlLO2GjBdk29du2xWk3Ogx2m
         8JHplcYzsP3FZ/xr9THLQzu+UZupx7JBcz3+k0stYyX2TMSRXD1fKDeZDXDwXqCscyfh
         GJELkA2+QjgkgCKANKuNJQUElLQhVB7Lc0dW7ZmAss4ESVkKZS3aCryvsDtrCW4v42qK
         prbW+RWv2QI/8COA1AW+UozzD9yJHcm9sGIlsrHxFRQcXob0LXsbtlTMvrxhQLjMtf4S
         Jypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749315; x=1794354115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9zzAb+wsllW8+muRqP8E/muffLWDQ0tFptZ4gg31Fww=;
        b=tfwEQ/5CfVl8t0AjCnDbiH/VkOIWa9IqW2c+n2IpWHjYaIKqbCj1L81X2E0yllXIOR
         31u40OJTKzACHEYpd/wQUnWiSmMiiVEgmkIMzLxZrH2kLOqU7FlB1y4MuhggWD30kGGc
         kzc/zMHzAckEhGHjbvaEG0TbmgtC9gqttpC1fHtQNt4gUz5RP3OntxvkFSh7JNsC6UjZ
         HPNwIbMEG098SvjQek8YBv5NDr0eddAKrBhtqWGNeh5KqElOqti5o1d/rLM9R2M8w9Nj
         my/Jld/cObffFiio1L/5BfBaYcDTEGQ2nM4aNpLKSjtd8UPA8ti1enx7drkgiK66nC/f
         1NAg==
X-Gm-Message-State: APuU4Z+fU5yqCZIKs6TfdXVjnkdCXcG83LeHnHRwGs7u9YoAwEIKIwly
	yHbjnkUIjrSHzFtTkB28XEAZvCO8X9nELxSbm159li3CKuBHLE1e5oqI7U9IGw==
X-Gm-Gg: AYBFou1YV05xVaL0TXyseWwzEMmlhaQnCkpdS8Sv+56XtjZHKNw9eGfmMaqvt4kT81g
	N+MqKA6v8tCFLkFcrrAkjv2CTgCEsjwh0znmel7/k2vzxh4uwHXRAiDiyZAMW/RsMX26f9L8k+4
	zoexN2Ju+D0GT4w/ORXlNJ0kHXl3toCbq8EIAwEqGLas2Ou3TyIdvb0KR0prR2rnxUK2hTXnC6z
	pk3GFrf/aiNgevJsFc0uIljRphlsx54JWPYcHTyE+LgAZxV7utiIzrMqkBR6ePRLWDzsNLXsXO2
	ww36qaw9ChjSqPgD2Rz2oLwk4GKEwu2N/NBPzvwS7ELGG1AVf0LyiENI7QY2f/4+a4hFUfrp6/r
	ySEMIn3unDBKhZ9yL74f32A5nNrnY1kz775sP1JyblPwhODJNYoA/cb00uUGnXWeEm5qZHRTc3k
	d/m+pL90FjgkrG05U2a45xef+EXWq7JrnF+QUTUTwxByNGMmzzQK4ljRw2iYPhtepPjfpghK/BF
	C3QehlIHsUWpaFkYByh5YU7fnU55F5jVYAm6xd1tM5STk0rgVNFVnFbVD1t3xacAYUlV8PUj5KE
	O5tGL3ZG4hOzJs0wa7PptIHnvU7jPgut+/AaJmAD9frhpVoqNeVL7CUsScxt197rwCQzGe8mgFF
	c6mraYd4NPSM5FiSCX7apRGR7QVc6mSOksImotkFKh1e/wvLXbGDmQQu01q1lTiO5z8YiVkWuSL
	/fMcpQWdWKbhL+rPXCDx+Gog==
X-Received: by 2002:a05:6a20:7490:b0:3e1:fa57:1d4f with SMTP id adf61e73a8af0-3e928e59657mr12200949637.59.1793749314462;
        Tue, 03 Nov 2026 15:41:54 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb4691d431sm275099a12.11.2026.11.03.15.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 08/37] bpf: Don't treat a partial spill as widened in scalar evolution
Date: Tue,  3 Nov 2026 23:40:33 +0000
Message-ID: <20261103234104.208239-9-alexei.starovoitov@gmail.com>
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

When scalar evolution knows the number of iterations of a loop, the
verifier gives each live register its range over all iterations and
verifies the body one time. If a live register has no formula, the verifier
verifies the loop one iteration at a time.

An unknown scalar needs no formula. A partial spill counts as one, because
4 spilled bytes do not tell what the 8 bytes of the slot are. But the state
has the value of the 4 bytes, and nothing widens it:

  int cnt = 0;                         /* 4 bytes in the stack */
  for (i = 0; i < 10; i++)
          cnt++;

  BPF program is too large. Processed 1000001 insn

cnt is 0, 1, 2, ... at the head, so the verifier cannot prune there. i is a
range, so 'i < 10' does not end the loop either.

Treat such a slot like a register. It has no formula if the state knows
something about the spilled bytes, they are live at the loop head, and the
next value is made from a partial spill that the loop changes or is '?':

  can't widen *fp-8, expr is (spill32 (zext32 (+ *fp-8 1)))

A flag or a copy of the counter is not made from the slot: no change there.
'flags |= 1', 'sum += x' and a slot that a callee or a helper writes are
unrolled again, as they are when the number is in a register.

On big-endian a narrow load from the stack was opaque. It is the high bits
of the slot, (>> *fp-8 32): now the expression tells what it is made from.

Nothing changes for a number that is loaded through a pointer to the slot,
for a slot of the caller that a loop in a callee changes, and for a slot
that is unknown at the entry and gets a value in the loop.

clamp_callee_state_pruning and clamp_nested_loop_state_pruning need a loop
that is not unrolled: they use bytes that are zero at first now.

2 progs of scx_pandemonium that count in a 32-bit slot load again. Other
progs of scx have such a loop and load before and after. The verifier
unrolls it now: arena_selftest_btree needs about 18K insns and not 9.6K.
No prog of Cilium, scx, the selftests or Meta's public progs is lost.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 61 ++++++++++++++++++-
 .../selftests/bpf/progs/verifier_scev.c       | 36 +++++------
 2 files changed, 76 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 06dee7e421ea..0f46a85f7648 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -616,9 +616,10 @@ static int mk_fill(struct scev *scev, int id, u8 code)
 	bool sx = BPF_MODE(code) == BPF_MEMSX;
 
 #ifdef __BIG_ENDIAN
-	/* A narrow fill from a DW spill reads high bits on big-endian. */
+	/* A narrow fill reads the high bits of the slot on big-endian. */
 	if (BPF_SIZE(code) != BPF_DW)
-		return OPAQUE_EXPR_ID;
+		return expr2(scev, sx ? BPF_ARSH : BPF_RSH, id,
+			     imm_expr(scev, 64 - BITS_PER_BYTE * bpf_size_to_bytes(BPF_SIZE(code))));
 #endif
 
 	switch (BPF_SIZE(code)) {
@@ -2369,6 +2370,48 @@ static bool is_unbound_scev_reg(struct bpf_verifier_env *env, const struct bpf_f
 	       reg->r64.size == U64_MAX && reg->r32.size == U32_MAX;
 }
 
+/*
+ * scev_reg_for_read() has scev->unknown_reg for a partial spill, because a part does not tell
+ * what the 8 bytes of the slot are. But the state has the value of the spilled bytes.
+ * Does it know something about them? If not, they are their own widening too.
+ */
+static bool is_known_partial_spill(const struct bpf_func_state *st, u32 r)
+{
+	const struct bpf_stack_state *stack = scev_regno_to_stack(st, r);
+	const struct bpf_reg_state *reg;
+	u64 max;
+
+	if (!stack || !bpf_is_spilled_reg(stack) || bpf_spill_size(stack) == BPF_REG_SIZE)
+		return false;
+	reg = &stack->spilled_ptr;
+	max = GENMASK_ULL(bpf_spill_size(stack) * BITS_PER_BYTE - 1, 0);
+	return (reg->var_off.mask & max) != max || reg->r64.size < max || reg->r32.size < max ||
+	       reg->step > 1;
+}
+
+/*
+ * Is @id made from a partial spill that the loop changes? '?' can be made from anything.
+ * @self is the slot whose next value is @id, as long as only (any ...) is above @id:
+ * (any self ...) tells that one of the paths does not change the slot.
+ */
+static bool made_from_partial_spill(struct scev *scev, const struct bpf_func_state *st,
+				    const struct env *header_env, u32 id, int self, u32 lvl)
+{
+	const struct expr *e = &scev->exprs[id];
+	u32 i;
+
+	if (lvl >= EXPR_STACK_DEPTH || e->op == UNKNOWN)
+		return true;
+	if (e->op == REG)
+		return (int)e->params[0] != self && is_known_partial_spill(st, e->params[0]) &&
+		       header_env->reg2expr[e->params[0]] != id;
+	for (i = 0; i < op_params_num(e->op); i++)
+		if (made_from_partial_spill(scev, st, header_env, e->params[i],
+					    e->op == ANY ? self : -1, lvl + 1))
+			return true;
+	return false;
+}
+
 /* Main logic in verifier.c forbids varying offsets for certain register types. */
 static bool is_widenable_reg_type(const struct bpf_reg_state *reg)
 {
@@ -2700,8 +2743,20 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		 * However, that would require tracking STACK_MISC writes in the
 		 * liveness analysis. Not implemented yet.
 		 */
-		if (is_unbound_scev_reg(env, cur_func, r))
+		if (is_unbound_scev_reg(env, cur_func, r)) {
+			/*
+			 * Nothing widens the value that the state has for a partial spill. A
+			 * value that is made from itself can be a new one in each iteration:
+			 * treat it like a register that has no formula. It's in the half
+			 * of the slot that is farther from fp.
+			 */
+			if (is_known_partial_spill(cur_func, r) &&
+			    bpf_stack_slot_alive(env, st->curframe, (r - MAX_BPF_REG) * 2 + 1) &&
+			    made_from_partial_spill(scev, cur_func, header_env,
+						    header_env->reg2expr[r], r, 0))
+				goto cant_widen;
 			continue;
+		}
 
 		r_scev = header_env->reg2scev[r];
 		reg = scev_reg_for_linear(cur_func, r);
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 14e224ae4efb..c891c9b8dfbc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -520,15 +520,15 @@ __msg("r1 = load_acquire((u8 *)(r10 -8)) {{.*}}; r1 1 -> (zext8 -8)")
 __msg("r1 = load_acquire((u16 *)(r10 -8)) {{.*}}; r1 1 -> (zext16 -8)")
 __msg("r1 = load_acquire((u32 *)(r10 -8)) {{.*}}; r1 1 -> (zext32 -8)")
 #else
-__msg("r1 = *(u32 *)(r10 -8) {{.*}}; r1 1 -> _")
-__msg("r1 = *(u16 *)(r10 -8) {{.*}}; r1 1 -> _")
-__msg("r1 = *(u8 *)(r10 -8) {{.*}}; r1 1 -> _")
-__msg("r1 = *(s32 *)(r10 -8) {{.*}}; r1 1 -> _")
-__msg("r1 = *(s16 *)(r10 -8) {{.*}}; r1 1 -> _")
-__msg("r1 = *(s8 *)(r10 -8) {{.*}}; r1 1 -> _")
-__msg("r1 = load_acquire((u8 *)(r10 -8)) {{.*}}; r1 1 -> _")
-__msg("r1 = load_acquire((u16 *)(r10 -8)) {{.*}}; r1 1 -> _")
-__msg("r1 = load_acquire((u32 *)(r10 -8)) {{.*}}; r1 1 -> _")
+__msg("r1 = *(u32 *)(r10 -8) {{.*}}; r1 1 -> (>> -8 32)")
+__msg("r1 = *(u16 *)(r10 -8) {{.*}}; r1 1 -> (>> -8 48)")
+__msg("r1 = *(u8 *)(r10 -8) {{.*}}; r1 1 -> (>> -8 56)")
+__msg("r1 = *(s32 *)(r10 -8) {{.*}}; r1 1 -> (s>> -8 32)")
+__msg("r1 = *(s16 *)(r10 -8) {{.*}}; r1 1 -> (s>> -8 48)")
+__msg("r1 = *(s8 *)(r10 -8) {{.*}}; r1 1 -> (s>> -8 56)")
+__msg("r1 = load_acquire((u8 *)(r10 -8)) {{.*}}; r1 1 -> (>> -8 56)")
+__msg("r1 = load_acquire((u16 *)(r10 -8)) {{.*}}; r1 1 -> (>> -8 48)")
+__msg("r1 = load_acquire((u32 *)(r10 -8)) {{.*}}; r1 1 -> (>> -8 32)")
 #endif
 __msg("r2 = load_acquire((u64 *)(r10 -8)) {{.*}}; r2 2 -> -8")
 __msg("store_release((u8 *)(r10 -8), r1) {{.*}}; *fp-8 -8 -> (spill8 1)")
@@ -2646,7 +2646,7 @@ __naked __noinline __used static int scrub_slot_callee(void)
 }
 
 /*
- * The callee turns the caller's fp-8 into misc, so the states at the call site
+ * The callee turns the caller's fp-4 from zero into misc, so the states at the call site
  * differ between the first and the second iteration, while the states inside
  * the callee are identical. Verification fails with an infinite loop error if
  * states.c:current_loop() does not search upper frames for active loops.
@@ -2661,21 +2661,21 @@ __msg("12: safe")
 __naked void clamp_callee_state_pruning(void)
 {
 	asm volatile ("					\
-	w1 = 1;						\
-	*(u32 *)(r10 - 8) = r1;				\
+	r1 = 0;						\
+	*(u32 *)(r10 - 4) = r1;				\
 	r6 = 0;						\
 1:	r1 = r10;					\
 	r1 += -8;					\
 	call scrub_slot_callee;				\
 	r6 += 1;					\
 	if r6 < 10 goto 1b;				\
-	r0 = *(u32 *)(r10 - 8);				\
+	r0 = *(u32 *)(r10 - 4);				\
 	exit;						\
 "	::: __clobber_all);
 }
 
 /*
- * The inner loop turns fp-8 from a spill into misc. On the next outer
+ * The inner loop turns the byte at fp-4 from zero into misc. On the next outer
  * iteration, the states inside the inner loop match its first invocation.
  */
 SEC("socket")
@@ -2688,16 +2688,16 @@ __msg("loop header at 3, clamping r6 to 0..9 step 1")
 __naked void clamp_nested_loop_state_pruning(void)
 {
 	asm volatile ("					\
-	w1 = 1;						\
-	*(u32 *)(r10 - 8) = r1;				\
+	r1 = 0;						\
+	*(u16 *)(r10 - 4) = r1;				\
 	r6 = 0;						\
 1:	r7 = 0;						\
-2:	*(u32 *)(r10 - 4) = 1;				\
+2:	*(u8 *)(r10 - 4) = 1;				\
 	r7 += 1;					\
 	if r7 < 3 goto 2b;				\
 	r6 += 1;					\
 	if r6 < 10 goto 1b;				\
-	r0 = *(u32 *)(r10 - 8);				\
+	r0 = *(u16 *)(r10 - 4);				\
 	exit;						\
 "	::: __clobber_all);
 }
-- 
2.55.0

