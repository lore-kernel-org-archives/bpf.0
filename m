Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749350;
	b=JlAP3vC5wabS0Udm4wCN3E88AQ+8rfSUp+CpJsuRO/OR629OO6zBr16Oiw51MBetzdax
	 DNkfojgK7yTyJY1pVrxUoFiBvb9kohy/8ADeXfoZvtYMgTgALWqM8UQwQWf7wWqB/vjhO
	 xZTuNufltBvUiYGNYzyyT3T9GaDh6qx+qSi328K6JoyGi/4smtdAXuvm1HCeek+jeq7Cl
	 2pyQPAX+x/4SwleuL0PzGBkwWrzvEPcNx3ZsyN8E6I5tHfNXqO4fm/mN5PvkvLd69JgHj
	 TFYmWolhw+HBanI4xXSYSXDaEq+9xaL7RAEC7d5W/HCYz8PQn0lEvpZn6Y470gatk4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3HRVL+0jkENpU+A8xT8d9XwYQ7ymgA3lHxHunfBcSsw=;
	b=JdsERSME+4iDeiooi59SY3Ck5uTw4gzYBY8sA2HKowhTxNdS84mjb3hfWwOnjM8zu8nE
	 XkoeheaQLNwm5NolZ8glUXAc1yLcygPKQ+lpe3P0cdA2zZttuEciOZrJKvHP1s43TDwSm
	 l0O+PwViNBqDSdN4OMehId14mhHpoRsfcAGprUYcCA309xDMHbZo43NXuk597oKqYnrcr
	 N0fJj4Qg/n5lisr6KrIwc2zKf5EV+oeiSiIYvuX375iuKtrAr8XBZqVJJs26EN+C3lFv3
	 jEwGpanrQJP5mQROJ1IF2JbY9aC4JoXCV1NSHu7gsKPwcG/shIsadfbcSPXdrIBhAgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PsOYiCTF;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A73606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62A73606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PsOYiCTF
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e987b4a710so6817965ad.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749350; x=1794354150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3HRVL+0jkENpU+A8xT8d9XwYQ7ymgA3lHxHunfBcSsw=;
        b=PsOYiCTF0/sNpTeeczqo5U1hXVUFPy+Ld6+FV/4c2BUVz7ULVEJtjoF702Lj3D1Bfo
         yUlsTLS4s8Ra6HlRohFlAz1cYZCAbjUOq7Kt5AogCjUjB02dVYQ7tBArIqhUiHrqMv6F
         ea2C9uHEzumB967hl7JwV4z2RpxDWyEVZTOawNRSXKKnmV6PSG0Z5x7BIOZnXvaCIsWm
         mAW8jpBUHTJr9+fL8HXtcTkNB/V85D6b/3/PAhg7rQ9Bo1B8+0KdQnc6hSq6kUBi1pnP
         OFmqSaA3EDHmjhWbFGCrEiTnYpyLDnVt4HyOnNVub/KKI9Ekvkpna38yL6XYjfunFDAY
         +NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749350; x=1794354150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3HRVL+0jkENpU+A8xT8d9XwYQ7ymgA3lHxHunfBcSsw=;
        b=sk/sBb8QDGPLCNFiwDF9zjLgK/9Q2D96VpocFMjM78jBiEsUesJD5iB/hXahX5WfUV
         izmd0c6UmU14MBwnTPCkn4FFc0DQnET/aIZIIK/E7sQqnBFN5yZ6JDU6whOQO9C9ZRE8
         Ep57CLKdU5LJLKc4gVNXYCbNNSaVtNrUNrQatdM9viQDOArBWFylC2Cpj/LMicBwJgr6
         XTvGAwx2CvCX3wOh4GQwjqbUTZqIBYfJnR57V/FSbnnMCDfwpqDrkbmMHRdxMvwDjPza
         efqcmJCVNELSFTajQ4IK05wZlu56HdKEsfOYNGGKzNd8XMry5hnHcwoqK9oVcK1vB1SH
         uC7Q==
X-Gm-Message-State: APuU4Z8ilQQb1e+PGgNVeoYRGeCEXZawsSFrhnF7u+v6eeT6fPCgZWGU
	jpHOukLJYPGgtM7fXLS/Sbk0VmJytoIcYNhXzaFXF2w9swGS+hXrmb+1kN+CYQ==
X-Gm-Gg: AYBFou36VhVLC41kpXEqZ++sS9i74G6m2MIP0ICVF0u8eufodwOy2MjEhhAA6c6ISP6
	9ymOPT/f44D5HS1V+s2dzVUMieMlJpdeFoTHFrHFdZ7Y9Rz+N1oHMb+dAjtAToo8DXr3CezUWf6
	N/FHB9Q4ZrRS7uLAbo56Bze3ZJMVcCiqGZf5p6chwjFZX+dQqn14V95hlgrCNoxW7VeXxGyH/9w
	sJ6Jic28f6gpLd6kQUFD81cr02uc40J463Lzdrytyxkt9Ah/c4XYWuQR8+y+gX0Wm5mg0684K8U
	VyeWL2Uy7GXu898rYiYTsYKcEBope6d71c3JZlHfXVY0lH+RmiOoZ3yw8IVlDO5coKJdH+jsjPh
	ErCaY46qL6yeQtKU0SQXD25hp258x+gWMqUWqwlbuhShfGVt6pxKyH/FSXI64c3vBhkdEP4g6D4
	3X4JZPzijrm+QLC4HMRwjxvPkPzyB6QYF7gYYeK544DBwjUmqIaxZyfr9Q3bUsdidHq3lTBvNbj
	CrSopNU1yUnZmhgjT137X8AYZdWlVsi7nWpCSCzyE8Ouv3RXlGuKs34htzAkKes53DQgwp41YXg
	3Je0zReunHxvthERtWmComcuZod9RTzamWWmS6TBN4CzIIDeQDCec30gsqyTKMSs5lzcL4t6bfX
	mkoqDE7X4ODZMlYD7BzTlkTU9AoooCi3c3x1eATp2Kz8+f68KkeQqvyYdLrYgWZbV9DcaQ4W7qV
	k=
X-Received: by 2002:a17:90a:e98b:b0:3b0:9409:6969 with SMTP id 98e67ed59e1d1-3b094096c8cmr341259a91.19.1793749349545;
        Tue, 03 Nov 2026 15:42:29 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09445f7b3sm1044692a91.5.2026.11.03.15.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 14/37] bpf: Fold sums of constants and two shifts by 32 in scalar evolution
Date: Tue,  3 Nov 2026 23:40:39 +0000
Message-ID: <20261103234104.208239-15-alexei.starovoitov@gmail.com>
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

Scalar evolution finds the step of a loop variable when the expression for
one iteration is (+ r imm). Compilers also make other forms of it:

  insns in the loop        expression              it is
  -----------------------  ----------------------  -------------
  r6 += 1; r6 += 1         (+ (+ r6 1) 1)          (+ r6 2)
  r6 -= 1                  (- r6 1)                (+ r6 -1)
  r6 <<= 32; r6 >>= 32     (>> (<< r6 32) 32)      (zext32 r6)

The last one is '(u32)i' for cpu v1 and v2, which have no 32-bit insns.
With these forms the variable has no formula and the loop is not counted.

Each one is an identity for 64-bit numbers that wrap around. The first two
are rules of simplify(). The last one is in transfer(), which sees the
insns: an expression does not tell the width of a shift. (>> x 32) is also
'w6 >>= w2' with 32 in w2, which shifts by 0.

A counted loop is verified with ranges, and there is no way back to one
iteration at a time: a prog with 'r6 -= 1' that needs the exact value of a
variable in each iteration, or after the loop, is rejected now, as it is
with 'r6 += -1'.

state_loop_first_last_equal in verifier_precision examines precision
backtracking in a loop that is not counted. 'r0 += 1; r0 += 1' is a step of
2 now. Replace it with 'r0 += 2; r0 |= 0', which has no formula. expr_chain
needs a deep expression: shift by 16.

The verifier processes 3.8 % fewer insns for the selftests that are built
without 32-bit insns (start_timer: 46008 -> 32), and 5.3 % fewer for those
that gcc builds. No prog is lost.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 26 ++++++++++++++++++-
 .../selftests/bpf/progs/verifier_precision.c  | 11 ++++----
 .../selftests/bpf/progs/verifier_scev.c       |  4 +--
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 8521c34899b0..8662205a3b59 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -666,7 +666,7 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 	u8 mode = BPF_MODE(insn->code);
 	u32 dst = insn->dst_reg;
 	u32 src = insn->src_reg;
-	u32 op, sext;
+	u32 op, sext, l, r;
 	bool need_bswap;
 	int i, id;
 	s64 imm;
@@ -726,6 +726,18 @@ static int transfer(struct bpf_verifier_env *env, struct env *e, int idx)
 			else
 				goto mark_dst_unknown;
 
+			/*
+			 * 'r1 <<= 32; r1 >>= 32' is (u32)r1 for cpu v1 and v2. Only here both
+			 * shifts are known to be 64-bit ones: the result of a 32-bit shift is
+			 * (zext32 ...), and (>> x 32) is 'w1 >>= w2' with 32 in w2 as well,
+			 * which shifts by 0.
+			 */
+			if (class == BPF_ALU64 && op == BPF_RSH && id >= 0 &&
+			    is_imm(scev, id, &imm) && imm == 32 &&
+			    is_binop(scev, BPF_LSH, reg2expr[dst], &l, &r) &&
+			    is_imm(scev, r, &imm) && imm == 32)
+				return replace_reg(scev, e, dst, expr1(scev, ZEXT32, l));
+
 			id = expr2(scev, op, reg2expr[dst], id);
 
 			if (class == BPF_ALU)
@@ -1485,6 +1497,18 @@ static int simplify(struct scev *scev, u32 id, void *priv)
 	int a, b, l, r, t, base, slope;
 	s64 imm1, imm2;
 
+	/* (- x imm) -> (+ x -imm) */
+	if (is_binop(scev, BPF_SUB, id, &l, &r) &&
+	    is_imm(scev, r, &imm1) && imm1 != S64_MIN)
+		return expr2(scev, BPF_ADD, l, imm_expr(scev, -imm1));
+
+	/* (+ (+ x imm) imm) -> (+ x imm) */
+	if (is_add(scev, id, &l, &r) &&
+	    is_imm(scev, r, &imm2) &&
+	    is_add(scev, l, &a, &b) &&
+	    is_imm(scev, b, &imm1))
+		return expr2(scev, BPF_ADD, a, imm_expr(scev, (s64)((u64)imm1 + (u64)imm2)));
+
 	/* (+ (linear base slope) imm) -> (linear (+ base imm) slope) */
 	if (is_add(scev, id, &l, &r) &&
 	    is_linear(scev, l, &base, &slope) &&
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index f4459561bf39..71ac80a984d8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -159,11 +159,11 @@ __success __log_level(2)
  * This is quite fragile: if verifier checkpointing heuristic changes, this
  * might need adjusting.
  */
-__msg("2: (07) r0 += 1                       ; R0=6")
+__msg("2: (47) r0 |= 0                       ; R0=6")
 __msg("3: (35) if r0 >= 0xa goto pc+1")
 __msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
-__msg("mark_precise: frame0: regs=r0 stack= before 2: (07) r0 += 1")
-__msg("mark_precise: frame0: regs=r0 stack= before 1: (07) r0 += 1")
+__msg("mark_precise: frame0: regs=r0 stack= before 2: (47) r0 |= 0")
+__msg("mark_precise: frame0: regs=r0 stack= before 1: (07) r0 += 2")
 __msg("mark_precise: frame0: regs=r0 stack= before 4: (05) goto pc-4")
 __msg("mark_precise: frame0: regs=r0 stack= before 3: (35) if r0 >= 0xa goto pc+1")
 __msg("mark_precise: frame0: parent state regs= stack=:  R0=P4")
@@ -173,8 +173,9 @@ __naked int state_loop_first_last_equal(void)
 	asm volatile (
 		"r0 = 0;"
 	"l0_%=:"
-		"r0 += 1;"
-		"r0 += 1;"
+		"r0 += 2;"
+		/* scalar evolution has no formula for it: the loop is not counted */
+		"r0 |= 0;"
 		/* every few iterations we'll have a checkpoint here with
 		 * first_idx == last_idx, potentially confusing precision
 		 * backtracking logic
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 495792b734f5..e6251c21b474 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -298,8 +298,8 @@ __naked void expr_chain(void)
 1:							\
 	if r6 == 2 goto 2f;				\
 	r6 += 1;					\
-	r6 <<= 32;					\
-	r6 >>= 32;					\
+	r6 <<= 16;					\
+	r6 >>= 16;					\
 	w6 += 1;					\
 	r6 = -r6;					\
 	w6 = -w6;					\
-- 
2.55.0

