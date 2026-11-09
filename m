Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206986;
	b=af6v8C4UMpJ4YPKTQQbYBF/eNbrmxtpWlhy/EWVIfYWXQ4Cip/eUckuNQBtm9PfsRpv6
	 bkD1cCqG+icrIWDKEM9sc5MauszfQzS7GPX19nKo96YmixL7gepgviy/Hkl0LkqyIjKzj
	 NODaLhi0qXh45C8TkIEggdvysxytb5xyRd2dHSN6ZuVpm6+fNdDp26mVc7oyRNQjkj/1E
	 H4gU8KXW6edWaP+pWEZlj5kYGn47BQEG+Nu2NZaDOPbNtW53Q40qrfdk3P8d+aDlMEXfa
	 Eqk9ZeimirblIDlEXA2HhZzgKHs4Z7oymVOTdQbdCEDTjd2FB2MkT9Fcarpad9hQg/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0Gs8Q+1K3Vfjgu8GRMa4XsMdhiMEbEq/SjF9JTqpS+A=;
	b=UdaiVrT9OK9PFriqsqL6hqNPoQxqT+QMjqarhEUlzMmre/vOGX+fTNu9S9aHLsOh1kxz
	 bkL8c67LBbt4X6KtkdqJSbx9nNbYRT3sp5VqMjfwNUlonp0QGawemGDxIMHFB+k7mOwDs
	 o3HLrdqv/CVOMydXtfjyT2AGnuIHg0xfqoci1PW60cijZvswRzuVFBKCR5qqGXiyQKabo
	 jUwcUkjixy6KoQTTkuqtQQnuL8Ni7+bD/a3m4DFRXE051Ij/UDf9butMZVUbnG2GLPJRF
	 n53osFTQHiViwPZ8DdrotWzuOcxIoAr8Mxf8b/XTXqrNW/LBl/mJPJztXqeIA3cqDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ieo+0iPL;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75FF606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B75FF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ieo+0iPL
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89d6bd67045so212482b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206985; x=1794811785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Gs8Q+1K3Vfjgu8GRMa4XsMdhiMEbEq/SjF9JTqpS+A=;
        b=Ieo+0iPLAUG5vpB4BMAqaC1bX0kYZ4+j1snqox0DruK1LEikY85yHl5VY9Kf30duzO
         QMEUjrYmwNjSgz998pVzISiCt0UPo0Mh2dNM08dxJIDRbprGaaTCnCcX7gfD/k+ZKjQg
         FiTSwg6QvwWL6HgOiKcmg77Uzjs1QGCTr3LCgJCe7Px64dyur3u+tOfad4y9plRaf28j
         PFhx5u65NqqVLyP+7uogsFTDx6kWcJfmInvFc+ShRi7rSJDcvW53hBXYi8BB7g4EiqVI
         9gNXnS7L6xpU7Y+k+ItBaaVaFZTJ86Tr+eNyw1XcNE4c9azH3C64HKfbkaiobsMe5nF1
         +14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206985; x=1794811785;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Gs8Q+1K3Vfjgu8GRMa4XsMdhiMEbEq/SjF9JTqpS+A=;
        b=z/JHBkcAlFWQx9O86YhGl69WsJ2utkpImccb42EgwiMGPFA5OSoZBs1Kh1wfLZd2u2
         q4C4acnacGx/n4E0otpVOz0eXG+ANH7xRqEFyHRXueWQ+VX/AZMbYRjGlNummtjGlyfx
         7eEJgLDRTNlQCWYeNnN2WUP/8KLKbKIY4CAbNXkCDkKIA3ZEzIFPG+dvDnmqLTEHvrNx
         Es1+9tyFqMzKHivZo9NEOKJQK1e1TmubqBnYei9vTMOfHB2H+xvqNMgBpS88Vm4wFZKr
         WxkveiFY3TcB/nN5gJmDyFOgc8jXhnO7E9ZgRrYCCq/WhCUet2Bq61tqA4TeS7gY0ItX
         e0qQ==
X-Gm-Message-State: APuU4Z86WM5YxWVBXLoz8ZGsF2Wzo1TXptVRRcRkAcLOGmC85dUDPsg8
	GfdgIRVnZbwLIZrBFjjXmscu3UWH+EHPypNE61n6jwit+JUsXZabDS5cViIfbQ==
X-Gm-Gg: AYBFou37NfFabHUTqa5JLX88QVKj22tsAFwP0inFnxohhpaKLYNq9MFH0nDwMyH8jeq
	mYdX0W0+IYOENFxyCnDAk1HOCdbyEFDLh/NUaTaNZ5PpH9OeIuu9ydq7Jrv95ZPo5RWHKETJPPD
	dW32DUAlSgOWLbq9DS170+zEfoG5zxgVdRieiK0vSBichUwbu5f0dGfUbX+jCC1cmuitQ60uwLq
	t37dWQkCjsYBMNnWDdEKN9YCf7PXXuQDgy4zQuRuB1cOAZnYrQluAgX31k786Y7qIfbZK8ldULF
	zDKWtjHSejSuLiDYeWuuZW/CMS8QAr8SDzQSxTldxAJ9Mt2Ym2kQMTJwqVzkaXmwjX/HVKslRsf
	T1XAo+nBhr+4RgD+d8oaLWTP/KQLLjei1sYR5tzZfNnfaZXtSVz4KGXH4nIkdJUZQPpbwqaU31r
	JSIg1/22VMIx0cR2dfRzaWgX8R5gnh6Z0MteQ6yW4nw81nefuYsNDSraRCThqNp1MviSN/bDUXX
	7Z5ZgGeKtKezwaWPs+D4NYqjzKK9BmvO3Aru6HV6x+IroVlU3evwUb87vMb1GDZMBPggUrnwT+3
	8lEzFFlqnwR40GxiUnhLbfXJvSWJ/YaZfYKZsjeCeRcHg+IcG0/dm975gjg19mjwcyRzR+KtW4m
	+9oJPtf23y/Oc3ewbf5Dm5fbIQKexr/3Dfw64MKALtqgxbqHllVIRivfn5oQnctL8rEy9b+e94o
	0=
X-Received: by 2002:a05:6a00:4c0f:b0:883:7868:94d7 with SMTP id d2e1a72fcca58-8b66c3fd20bmr2019130b3a.10.1794206984976;
        Sun, 08 Nov 2026 22:49:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b646bd34c4sm952344b3a.4.2026.11.08.22.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:49:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 25/26] bpf: Support sign-extended 32-bit linear scalar evolution
Date: Mon,  9 Nov 2026 06:47:09 +0000
Message-ID: <20261109064715.2382452-26-alexei.starovoitov@gmail.com>
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

A new ability: the recurrence (sext32 (linear rA IMM)), next to
(zext32 (linear ..)) and (spill32 (linear ..)). A loop over 'int i' as GCC
compiles it becomes a counted loop.

test_rhash_update_elements() of rhash.c has 'for (i = 0; i < 128; ++i)'.
GCC adds to an int in 32 bits and keeps the sign extension of the result:

	53: r3 = r7
	54: w3 += 1
	55: r7 = (s32)r3
	56: if w3 == 0x80 goto pc+27
	scev at header 57:
	  r7=(sext32 (zext32 (+ r7 1))) / ?

The backedge value of r7, before the '/', has no closed form. No iteration
count (header_count: how often the header is executed) is computed.
header_count = backedge-taken count + 1. The loop is walked: the verifier
unrolls the loop, one state per iteration; a counted loop is summarized,
one state for all iterations. A long loop that is walked ends with "more
than 1024 states that cannot be joined". It loaded when the verifier
explored each path. GCC compiles some 50 loops of the selftests that way,
most of them with i in a register.

The latch tests the 32-bit add, which is supported. What is missing is to
look through the extension, and the range of all 64 bits:

 - An extension and a partial spill truncate their operand. How it was
   extended or spilled before does not matter, below an add too:
   (sext32 (zext32 a)) is (sext32 a). Two rules of simplify() say so for
   all widths, in place of six.
 - The backedge value (sext32 (+ rA IMM)) is (sext32 (linear rA IMM)) at
   the header. Its range is the sign extension of the range of the low 32
   bits. A wrap is handled, not excluded: the range is all of s32 then.
 - iv_range, the range that the latch condition implies, is a range of the
   zero-extended low 32 bits. iv_bounds() ignores it if bit 31 can be set.
 - For i in a stack slot, zero or sign extended, little endian only:
   iterate_wakeupsources() of plain_c_test_wakeup_source.c has a 64-bit
   spill and a 32-bit fill of i. The half-slot with the upper 32 bits is
   dead, see the new bpf_half_slot_live_before(), and the states don't
   have it: 'fp-16=pppp1000'. A recurrence over 64 bits has no entry value
   there. (spill32 (linear (zext32 rA) IMM)) describes the low 32 bits
   only, so it holds too: use it.

With the patch:

	  r7=(sext32 (+ r7 1)) / (sext32 (linear r7 1))
	loop header at 57, header_count is [0..128]

The selftests as GCC builds them: no verdict changes, 2.6 % fewer insns.

	test_rhash_update_elements (rhash.c)                  6074 ->  105
	iterate_wakeupsources (plain_c_test_wakeup_source.c)  4402 ->  131
	nested_loops (loop1.c)                                4558 ->  702
	test1 (timer.c)                                       3973 ->  173

Three loops of these selftests keep a sign-extended i in a stack slot. Two
load before and after with the same insns. The third, in
dump_task_sleepable() of bpf_iter_tasks.c, is still rejected with the
message above: one of its two backedges has no linear latch, so the loop
has no iteration count.

Fixes: 5395aa9bbeb5 ("bpf: Verify programs as a fixpoint over the control flow graph")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/liveness.c        |  13 ++++
 kernel/bpf/scev.c            | 145 +++++++++++++++++++----------------
 3 files changed, 95 insertions(+), 64 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index cee25ec87403..566787a0196c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2049,6 +2049,7 @@ int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_
 const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
 bool bpf_needs_fixed_stack_off(struct bpf_verifier_env *env, int insn_idx);
 bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
+bool bpf_half_slot_live_before(struct bpf_verifier_env *env, u32 insn_idx, u32 half_spi);
 int bpf_compute_live_registers(struct bpf_verifier_env *env);
 
 #define BPF_MAP_KEY_POISON	(1ULL << 63)
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e930d928afa5..fff5e7fcae18 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -760,6 +760,19 @@ static void compute_may_write_masks(struct bpf_verifier_env *env)
 	}
 }
 
+/* live_stack_before of the insn at @insn_idx for one half-slot */
+bool bpf_half_slot_live_before(struct bpf_verifier_env *env, u32 insn_idx, u32 half_spi)
+{
+	struct func_instance *instance;
+	int bkt;
+
+	hash_for_each(env->liveness->func_instances, bkt, instance, hl_node)
+		if (insn_idx - instance->subprog_start < instance->insn_cnt &&
+		    is_live_before(instance, insn_idx, instance->depth, half_spi))
+			return true;
+	return false;
+}
+
 const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx)
 {
 	return env->insn_aux_data[insn_idx].may_write_mask;
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 34abb4ab0c46..befb2e8c9c27 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -477,6 +477,22 @@ static bool is_spill32(struct scev *scev, int id, u32 *left)
 	return is_spill(scev, id, &bits, left) && bits == 32;
 }
 
+/* (zextN x), (sextN x) or (spillN x) with N >= @bits: the low @bits bits are those of @left */
+static bool is_low_bits(struct scev *scev, int id, u32 bits, u32 *left)
+{
+	u32 op = scev->exprs[id].op;
+
+#ifdef __BIG_ENDIAN
+	/* see is_spill() */
+	if (op == SPILL8 || op == SPILL16 || op == SPILL32)
+		return false;
+#endif
+	if (op_low_bits(op) < bits)
+		return false;
+	*left = scev->exprs[id].params[0];
+	return true;
+}
+
 static bool is_any(struct scev *scev, int id, u32 *left, u32 *right)
 {
 	return is_binop(scev, ANY, id, left, right);
@@ -752,6 +768,19 @@ static bool reg_alive_at(struct bpf_verifier_env *env, u32 reg, u32 insn_idx)
 	       : test_bit(reg - MAX_BPF_REG, aux[insn_idx].live_stack_before);
 }
 
+/* The first bytes of a stack slot are its high bits */
+static bool is_big_endian_slot(u32 reg)
+{
+	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && reg >= MAX_BPF_REG;
+}
+
+/* Are the upper 32 bits of @reg live before the insn at @insn_idx? */
+static bool hi32_alive_at(struct bpf_verifier_env *env, u32 reg, u32 insn_idx)
+{
+	return reg < MAX_BPF_REG || is_big_endian_slot(reg) ||
+	       bpf_half_slot_live_before(env, insn_idx, (reg - MAX_BPF_REG) * 2);
+}
+
 static void print_env(struct bpf_verifier_env *env, struct env *e, u32 insn_idx)
 {
 	struct bpf_verifier_log *log = &env->log;
@@ -1877,12 +1906,6 @@ static bool match_linked_add(struct bpf_verifier_env *env, int h, u32 tested, u3
 	return true;
 }
 
-/* The first bytes of a stack slot are its high bits */
-static bool is_big_endian_slot(u32 reg)
-{
-	return IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) && reg >= MAX_BPF_REG;
-}
-
 /*
  * const_diff() for the SCEV register @reg, which has the expression @id_b. A fill from byte
  * *@fill_off of a slot reads these bits. On big endian the low bytes of a spill are the last ones,
@@ -2349,7 +2372,7 @@ static int transform_expr_once(struct scev *scev, u32 lvl, u32 root, void *priv,
 static int simplify(struct scev *scev, u32 id)
 {
 	int a, b, l, r, t, base, slope;
-	u32 bits, op = scev->exprs[id].op;
+	u32 op = scev->exprs[id].op, bits = op_low_bits(op);
 	s64 imm1, imm2;
 
 	/* (- x imm) -> (+ x -imm) */
@@ -2392,41 +2415,21 @@ static int simplify(struct scev *scev, u32 id)
 		return imm_expr(scev, (u64)(u32)imm1);
 
 	/*
-	 * (zext32 (+ (zext32 $a) $b)) -> (zext32 (+ $a $b))
-	 * (zext32 (+ $a (zext32 $b))) -> (zext32 (+ $a $b))
-	 */
-	if ((is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a)) ||
-	    (is_zext32(scev, id, &t) && is_add(scev, t, &a, &r) && is_zext32(scev, r, &b))) {
-		t = expr2(scev, BPF_ADD, a, b);
-		t = expr1(scev, ZEXT32, t);
-		return t;
-	}
-
-	/* (zext32 (zext32 X)) -> (zext32 X) */
-	if (is_zext32(scev, id, &a) && is_zext32(scev, a, &b))
-		return a;
-
-	/*
-	 * '*(u32 *)(r10 - 8) = rX' stores the low half of rX:
-	 * (spill32 (zext32 $a)) -> (spill32 $a)
-	 * (spill32 (+ (zext32 $a) $b)) -> (spill32 (+ $a $b))
-	 */
-	if (is_spill32(scev, id, &t) && is_zext32(scev, t, &a))
-		return expr1(scev, SPILL32, a);
-	if (is_spill32(scev, id, &t) && is_add(scev, t, &l, &b) && is_zext32(scev, l, &a))
-		return expr1(scev, SPILL32, expr2(scev, BPF_ADD, a, b));
-
-	/*
-	 * 'rX = *(u32 *)(r10 - 8)' fills what was spilled, a narrower fill the low bits of it:
-	 * (zext32 (spill32 $a)) -> (zext32 $a)
+	 * An extension and a partial spill depend on the low bits of their operand only: look
+	 * through an extension and a partial spill that is not narrower, below an add too:
+	 * (sext32 (zext32 $a)) -> (sext32 $a)
 	 * (sext8 (spill16 $a)) -> (sext8 $a)
-	 * (zext32 (+ (spill32 $a) $b)) -> (zext32 (+ $a $b))
+	 * (zext32 (+ (sext32 $a) $b)) -> (zext32 (+ $a $b))
+	 * (spill32 (+ $a (zext32 $b))) -> (spill32 (+ $a $b))
 	 */
-	if (op_low_bits(op) && is_spill(scev, scev->exprs[id].params[0], &bits, &a) &&
-	    op_low_bits(op) <= bits)
+	if (!bits)
+		return id;
+	t = scev->exprs[id].params[0];
+	if (is_low_bits(scev, t, bits, &a))
 		return expr1(scev, op, a);
-	if (is_zext32(scev, id, &t) && is_add(scev, t, &l, &b) && is_spill32(scev, l, &a))
-		return expr1(scev, ZEXT32, expr2(scev, BPF_ADD, a, b));
+	if (is_add(scev, t, &l, &r) &&
+	    (is_low_bits(scev, l, bits, &l) || is_low_bits(scev, r, bits, &r)))
+		return expr1(scev, op, expr2(scev, BPF_ADD, l, r));
 
 	return id;
 }
@@ -2449,6 +2452,7 @@ static int compute_header_scevs(struct bpf_verifier_env *env, int h)
 	int l, r, t, id, ra, rb, ra_expr;
 	bool zext32;
 	s64 imm;
+	u32 op;
 
 	/*
 	 * Note:
@@ -2483,30 +2487,24 @@ static int compute_header_scevs(struct bpf_verifier_env *env, int h)
 			header_env->reg2scev[ra] = id;
 			continue;
 		}
-		/* rA = (is_zext32 (+ rA IMM)) -> (is_zext32 (linear rA IMM)) */
-		if (is_zext32(scev, ra_expr, &t) &&
-		    is_add(scev, t, &l, &r) &&
-		    is_reg(scev, l, &rb) &&
-		    is_imm(scev, r, &imm) &&
-		    ra == rb) {
-			id = expr2(scev, LINEAR_SCEV, l, r);
-			id = expr1(scev, ZEXT32, id);
-			if (id < 0)
-				return id;
-			header_env->reg2scev[ra] = id;
-			continue;
-		}
 		/*
+		 * A 32-bit induction variable:
+		 * rA = (zext32 (+ rA IMM)) -> (zext32 (linear rA IMM))
+		 * rA = (sext32 (+ rA IMM)) -> (sext32 (linear rA IMM))
 		 * rA = (spill32 (+ rA IMM)) -> (spill32 (linear (zext32 rA) IMM))
-		 * The low half of the slot counts. Nothing is known about the other half.
+		 * The last SCEV leaves the upper 32 bits of the slot unknown, so it holds for the
+		 * first two as well. They get it if these bits are dead: the states have a
+		 * 32-bit spill then, see bpf_clean_verifier_state().
 		 */
-		if (is_spill32(scev, ra_expr, &t) &&
+		if (is_low_bits(scev, ra_expr, 32, &t) &&
 		    is_add(scev, t, &l, &r) &&
 		    is_reg(scev, l, &rb) &&
 		    is_imm(scev, r, &imm) &&
 		    ra == rb) {
-			id = expr2(scev, LINEAR_SCEV, expr1(scev, ZEXT32, l), r);
-			id = expr1(scev, SPILL32, id);
+			op = hi32_alive_at(env, ra, h) ? scev->exprs[ra_expr].op : SPILL32;
+			if (op == SPILL32)
+				l = expr1(scev, ZEXT32, l);
+			id = expr1(scev, op, expr2(scev, LINEAR_SCEV, l, r));
 			if (id < 0)
 				return id;
 			header_env->reg2scev[ra] = id;
@@ -4105,8 +4103,10 @@ struct linear_coefs {
 	u32 base_reg;
 	s64 slope;
 	bool zext32;
-	/* the low half of a stack slot */
+	/* with zext32: the low 32 bits of a stack slot */
 	bool spill32;
+	/* with zext32: the low 32 bits are sign extended */
+	bool sext32;
 };
 
 static bool is_simple_slope(struct scev *scev, u32 id, s64 *slope)
@@ -4122,8 +4122,12 @@ static bool is_simple_linear(struct scev *scev, u32 id, struct linear_coefs *out
 	u32 base, slope;
 
 	out->spill32 = false;
-	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) &&
-	       is_reg(scev, base, &out->base_reg) &&
+	out->sext32 = is_unop(scev, SEXT32, id, &id);
+	if (!is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) ||
+	    (out->sext32 && out->zext32))
+		return false;
+	out->zext32 |= out->sext32;
+	return is_reg(scev, base, &out->base_reg) &&
 	       is_simple_slope(scev, slope, &out->slope);
 }
 
@@ -4155,6 +4159,7 @@ static struct bpf_reg_state *spill32_counter(struct scev *scev, struct bpf_func_
 		return NULL;
 	out->zext32 = true;
 	out->spill32 = true;
+	out->sext32 = false;
 	return scev_reg_for_spill32(st, r);
 }
 
@@ -4163,6 +4168,11 @@ static struct cnum64 cnum64_zext32(struct cnum32 r32)
 	return cnum64_from_urange(cnum32_umin(r32), cnum32_umax(r32));
 }
 
+static struct cnum64 cnum64_sext32(struct cnum32 r32)
+{
+	return cnum64_from_srange(cnum32_smin(r32), cnum32_smax(r32));
+}
+
 /* Compute the range an induction variable in `reg` spans over the loop. */
 static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 			  struct linear_coefs *coefs, struct bounds *out)
@@ -4192,12 +4202,14 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 	r32 = CNUM32_UNBOUNDED;
 	if (coefs->zext32) {
 		r32 = cnum32_from_cnum64(r64);
-		r64 = cnum64_zext32(r32);
+		r64 = coefs->sext32 ? cnum64_sext32(r32) : cnum64_zext32(r32);
 		/*
 		 * 32-bit iteration overflow is equivalent to subtracting N * 2**32:
 		 * (base + slope * k) % slope ≠ (base + slope * k - N * 2**32) % slope.
 		 */
-		overflow |= cnum32_contains(r32, 0) && cnum32_contains(r32, U32_MAX);
+		overflow |= coefs->sext32 ?
+			    cnum32_contains(r32, S32_MAX) && cnum32_contains(r32, S32_MIN) :
+			    cnum32_contains(r32, 0) && cnum32_contains(r32, U32_MAX);
 		/*
 		 * The entry and zero-extended values must agree on how they define `base`,
 		 * otherwise `base + slope * k` would define different sets of points between
@@ -4228,10 +4240,14 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 	out->r32 = r32;
 }
 
-static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
+static void iv_bounds(struct bounds *bounds, const struct linear_coefs *coefs,
+		      struct cnum64 iv_range)
 {
 	struct cnum64 r64 = cnum64_intersect(bounds->r64, iv_range);
 
+	/* The latch bounds the zero extension. With bit 31 set the sign extension differs. */
+	if (coefs->sext32 && cnum64_umax(iv_range) > S32_MAX)
+		return;
 	if (!cnum64_is_empty(r64))
 		bounds->r64 = r64;
 }
@@ -4771,7 +4787,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 				return err;
 			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
 			if (coefs.base_reg == iters->iv_reg)
-				iv_bounds(&bounds, iters->iv_range);
+				iv_bounds(&bounds, &coefs, iters->iv_range);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
 				log_reg(env, r);
@@ -4817,6 +4833,7 @@ static bool is_moved_linear(struct scev *scev, u32 id, struct linear_coefs *out,
 	u32 base, slope, l, r;
 
 	out->spill32 = false;
+	out->sext32 = false;
 	return is_linear_or_linear32(scev, id, &base, &slope, &out->zext32) && !out->zext32 &&
 	       is_add(scev, base, &l, &r) && is_reg(scev, l, &out->base_reg) &&
 	       is_imm(scev, r, moved) && is_simple_slope(scev, slope, &out->slope);
@@ -4893,7 +4910,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 clamp:
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
 		if (coefs.base_reg == entry->iv_reg && !moved)
-			iv_bounds(&bounds, entry->iv_range);
+			iv_bounds(&bounds, &coefs, entry->iv_range);
 		if (moved) {
 			/* a sum that can wrap has another residue, see scalar_step_add() */
 			if (check_add_overflow(cnum64_smin(bounds.r64), moved, &sum) ||
-- 
2.55.0

