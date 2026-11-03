Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749435;
	b=DBKnEo7xvGunOpvA1BIk4cgvSYeA59yXqjDWakhZLrrfmC8IPZ3FkxzcUL+F8Yw5pdsf
	 VQV8+XGSMVrMrGYZGYFsihjbZ1tKC2Qwwi9HZHVpKVr0PIz6iSvU5R3SS5kdvMtMyTyDP
	 m1VvViVjDyH+4yFypipyuNw6RdtZ3RmwshiwTY2iDQtOwyWEF8+kTyUsWSLpuXp0Y15Bn
	 AyfztNthzcU6poA2Ce4JFqto/7QFeaOK5rtx9+CBCfZNZSz5Ve4x3DH0f9J+4h+4UlpxC
	 1bCoD97Hm73Hyoj3dZe7yhlRSs74glpeHkI2aDc4aBVcPkuHhkLfsAgep390X85clfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MK3wNyVXh+D7X7YilPVs9vfkKW6Y1TBe7vLztP9t6gE=;
	b=lp/x8Cs7wNWsZGhsNAyijxWkapmlmfkI3BPO0SS7Gnmcj52HIclY8QqBfiHZSIaJTjd/
	 bYJvkddTTnyghkMS4w1hPYUtlNOXV7NZAw/+LxAMNn+QSrPvWuRMPnLwjfkgUw5DQpo7Y
	 iq98Q4yrwDoJWht34ZU02rovR0fbqOUKPxrL0+ousgdXjz3d36Twx9d9u9M/kQI447GFv
	 WsFpUJf6e7ZraWb4A169Ij2Uuc8gZeQ9jVeIK4Yqad+1av3Xl5CSCV/ntnwRvZ9qN1qCP
	 TMajDxayr9KnpTZf5OXbW7A14xA/Y8jZWaJKuJzC3pUhXbg6TKuU/5uhfQXVSWneYiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMNqcpom;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985A2606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 985A2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uMNqcpom
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so22779a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749434; x=1794354234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MK3wNyVXh+D7X7YilPVs9vfkKW6Y1TBe7vLztP9t6gE=;
        b=uMNqcpomPfLrQm3Nsj500k25KefGMORKZ4zR+IuzVjyPiAitZFnPeg3xtsC09nNWAe
         R1kpJ+VLm1VZqw3dg/psWzA6yQSoK6oZLU2vqIzN/9SQNKrdPABwUm0gWPiNRIVpbAx7
         qkwrFduKWDYqloN5yJ2Rg9Rs2+h55CHerfAP902kJXuLm77akc2elvmkLT65QlXRtxjw
         pouYrELlD7wkAnSHQqnN71H9uUvBUhlYie5UDsmfS/LE1BHGDPpAgylgmZcISILqKEwr
         f+xRQBFI33J0yeO+h/yPLSVpRDbsQXocH0TVfnyWX8yJy5z8aonqkqFD74EMOUQ5VzR7
         ZcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749434; x=1794354234;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MK3wNyVXh+D7X7YilPVs9vfkKW6Y1TBe7vLztP9t6gE=;
        b=BEnezIzVrMFSq7ZdqX5c8pXcrFWn4IIJDEwAmH4mzezoi/l5PTv4Fz+4A9POz6kHc2
         FxMFPtHFzAo/qApmpqM+CIU1R7yaCwe8JfOFoDuVGmwVsFMgz27j/RcfQtD6EBfaRGGG
         M0OcZRrFp+C/o4nAh8gNKrOQKFsZ020MGQpzRXD/Z6xC4EJgSiHI2I6OqIiaX17mTJRA
         VHSAeAGafSTy+qM63cBr+jTMZHs+6asDKDiZ9uvHLxlNXX/chW+6QSkwrD6xJQqSbH6l
         8bAlYL90xPMd4ESbYjLvK18ZCRMrwyOLeSTtcZtg3XppkR+fxBHFt5rgTFiQOX5eqakh
         D6ig==
X-Gm-Message-State: APuU4Z8RuN9zg/r08tSGuOvInJLmJY6HYGiws9wvsowsBzG/f/P+ex9E
	xky/wemCT9BxFj10+SrgQ1faEnJrwOs/CqI72IEpMBx1+jzdOTy+zSCic2P3Dg==
X-Gm-Gg: AYBFou0HVU3SagpL8Zm9rZl3wmeYemTTwaUhxtTbXQ6tvgveSU8e63o5x/ITYDFMQHk
	LF4HEtiiX6GXKTXFfnpJvmBpp2eP8IFEAFhl3H/Sr9sNOJ58lhs/Fo/hePxzbW2uCOy5BO/q1zn
	QFFb2/aMk4e3CfLeNg+GH9Cn8Wu7L/nvAEQVqxrb6OFTmUGQKzJD1FBrE+KsfDh9rzUfCJJjHSI
	wzACALNmcmO/wvDlRwaZm2WhA7m1Cr/6IitGz6lCYjsAlO3ZKlFc8vgE6IIA06xSyOgpvenbaUG
	LSgtmXOyeZldARQTfCp/HKajP/TCSGm6DlWgqkqeSNi+2/TXNPbn6VMdRFo7LMp9zQkvFfVpvo2
	5TIy3qgm4X65VZyjDqIH4wPruhQC39j5gbNKEvGNtwyqhewJRbhTys5b/M4L3PgafPmauGBVyI5
	aAWaV5fcFHpOsSBMBp3mmBFGvUTJ2/cElKL4RZxmoM9fXwWZClwLuuGqLsa1W4JXiWmwKK7VeAb
	jUmr3hrRl9Mt7fn5Ub9ymmiwmcvx/dGr6G+nAcLw+mFrzhu4gi6tHNxq18hXsZazTFsbsi9yefE
	ptCqnUrjN50P5e8YFtbXl9MVPsawbXH8qHvCfLnFq1m4a10nKrwwHdjjXtrbDRdGEY6sSfxxENM
	M9ki2jccryFAqJa74N08glb5zFQxd6hPeRlq282Wg/rIC//vrQl+90x9k3Fw1BN3FmrttpFxmuI
	I=
X-Received: by 2002:a17:90b:5250:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3ae897bfdd8mr7663464a91.37.1793749433796;
        Tue, 03 Nov 2026 15:43:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944a0ff7sm1024218a91.10.2026.11.03.15.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 28/37] bpf: Count a loop whose latch is false in the first iteration
Date: Tue,  3 Nov 2026 23:40:53 +0000
Message-ID: <20261103234104.208239-29-alexei.starovoitov@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

  for (i = first; i < 64; i++) {
          if (i >= n)
                  break;
          sum += a[i];
  }

With first = 63 the latch 'i + 1 < 64' is false in the first iteration.
compute_backedge_taken_count() has no count for that: "the main pass would
do a single iteration anyway". That was true while the latch was the only
jump with a count. Now scalar evolution asks each jump that leaves the loop
and dominates the back edge, and the smallest count wins. Here only
'i >= n' is left, and n is not known: 4 billion iterations. The pointer
that moves with i leaves the array, and the verifier rejects the prog.

The back edge is not taken. That is a count of 0: for constants, and for
ranges in which no first value gets through the latch.

 - The operands of the latch can be pointers. Then the numbers are offsets
   from one base, and addresses have the order of signed offsets: one byte
   in front of a map value is below a byte in it. latch_false_at_once()
   uses this order. The formulas for constants still compare unsigned
   offsets. They have no count for an offset that gets to the other side of
   0.
 - A loop with several back edges can go on through a different back edge
   and get to this latch again. A latch that is false at once can move
   towards the values for which it is true: 'i < 10' with i that goes down
   from 20. Thus it counts as false in the first iteration only, and
   latch_false_until() is not asked.

The 9 tests of verifier_scev.c with a latch that is false at once expect a
count of 1 now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c                             | 84 ++++++++++++++-----
 .../selftests/bpf/progs/verifier_scev.c       | 18 ++--
 2 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index fd6abc41b946..9ddaae03ac35 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2274,11 +2274,49 @@ static bool is_signed_op(u8 op)
 	}
 }
 
-static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound, u64 *result)
+/*
+ * Is the latch false in the first iteration, whatever the first value and the bound are in
+ * their ranges? For a signed comparison the sign bit is flipped, see struct latch_domain.
+ */
+static bool latch_false_at_once(u8 op, u64 imin, u64 imax, u64 bmin, u64 bmax)
+{
+	switch (op) {
+	case BPF_JLT:
+	case BPF_JSLT:
+		return imin >= bmax;
+	case BPF_JLE:
+	case BPF_JSLE:
+		return imin > bmax;
+	case BPF_JGT:
+	case BPF_JSGT:
+		return imax <= bmin;
+	case BPF_JGE:
+	case BPF_JSGE:
+		return imax < bmin;
+	case BPF_JNE:
+		return imin == bmax && imax == bmin;
+	default:
+		return false;
+	}
+}
+
+static bool compute_backedge_taken_count(u8 op, bool ptrs, u64 initial, u64 step, u64 bound,
+					 u64 *result)
 {
-	u64 rem, diff, backedge_taken_count;
+	u64 rem, diff, backedge_taken_count, bias = is_signed_op(op) || ptrs ? 1ULL << 63 : 0;
 	bool up, down;
 
+	/*
+	 * The back edge is not taken. That is a count, and a better one than that of
+	 * another exit, which may be true for a long time.
+	 * @ptrs: the numbers are offsets from one base. Addresses have the order of signed
+	 * offsets, see compute_backedge_taken_max(). The formulas below give up on an offset
+	 * that gets to the other side of 0.
+	 */
+	if (latch_false_at_once(op, initial ^ bias, initial ^ bias, bound ^ bias, bound ^ bias)) {
+		*result = 0;
+		return true;
+	}
 	if (step == 0)
 		return false;
 	down = (s64)step < 0;
@@ -2293,13 +2331,10 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 		 * The backedge_taken_count is the size of this set.
 		 */
 		if (/*
-		     * If the condition is initially true, decreasing values won't
-		     * change that without underflow. If the condition is initially false,
-		     * the main pass would do a single iteration anyway.
+		     * The condition is initially true, decreasing values won't
+		     * change that without underflow.
 		     */
 		    down ||
-		    /* Is the latch condition false on the first iteration? */
-		    initial >= bound ||
 		    /* Count iterations satisfying the strict inequality, including i=0. */
 		    check_add_overflow(div64_u64(diff - 1, step), 1, &backedge_taken_count) ||
 		    /*
@@ -2311,7 +2346,7 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 		break;
 	case BPF_JLE:
 		/* E.g.: 3 + 2*i ≤ 7 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
-		if (down || initial > bound ||
+		if (down ||
 		    /* Count iterations satisfying the non-strict inequality. */
 		    check_add_overflow(div64_u64(diff, step), 1, &backedge_taken_count) ||
 		    backedge_taken_count > div64_u64(U64_MAX - initial, step))
@@ -2319,7 +2354,7 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 		break;
 	case BPF_JGT:
 		/* E.g.: 7 - 2*i > 3 ⇔ 2*i < 4 ⇔ i ∈ [0,1]. */
-		if (up || initial <= bound ||
+		if (up ||
 		    check_add_overflow(div64_u64(-diff - 1, -step), 1, &backedge_taken_count) ||
 		    /*
 		     * The last iteration underflows the counter if:
@@ -2333,13 +2368,13 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 		break;
 	case BPF_JGE:
 		/* E.g.: 7 - 2*i ≥ 3 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
-		if (up || initial < bound ||
+		if (up ||
 		    check_add_overflow(div64_u64(-diff, -step), 1, &backedge_taken_count) ||
 		    backedge_taken_count > div64_u64(initial, -step))
 			return false;
 		break;
 	case BPF_JSLT:
-		if (down || (s64)initial >= (s64)bound ||
+		if (down ||
 		    check_add_overflow(div64_u64(diff - 1, step), 1, &backedge_taken_count) ||
 		    /*
 		     * Check if the last iteration overflows the signed counter:
@@ -2349,13 +2384,13 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 			return false;
 		break;
 	case BPF_JSLE:
-		if (down || (s64)initial > (s64)bound ||
+		if (down ||
 		    check_add_overflow(div64_u64(diff, step), 1, &backedge_taken_count) ||
 		    backedge_taken_count > div64_u64((u64)S64_MAX - initial, step))
 			return false;
 		break;
 	case BPF_JSGT:
-		if (up || (s64)initial <= (s64)bound ||
+		if (up ||
 		    check_add_overflow(div64_u64(-diff - 1, -step), 1, &backedge_taken_count) ||
 		    /*
 		     * The last iteration underflows the signed counter if:
@@ -2368,7 +2403,7 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 			return false;
 		break;
 	case BPF_JSGE:
-		if (up || (s64)initial < (s64)bound ||
+		if (up ||
 		    check_add_overflow(div64_u64(-diff, -step), 1, &backedge_taken_count) ||
 		    backedge_taken_count > div64_u64(initial - (u64)S64_MIN, -step))
 			return false;
@@ -2381,7 +2416,7 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 		diff = down ? -diff : diff;
 		step = down ? -step : step;
 		backedge_taken_count = div64_u64_rem(diff, step, &rem);
-		if (diff == 0 || rem != 0)
+		if (rem != 0)
 			return false;
 		break;
 	default:
@@ -2573,6 +2608,10 @@ static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_
 	if (initial->ptr_reg >= 0 &&
 	    (d.imin < d.lo || d.imax > d.hi || d.bmin < d.lo || d.bmax > d.hi))
 		return false;
+	if (latch_false_at_once(latch->op, d.imin, d.imax, d.bmin, d.bmax)) {
+		*result = 0;
+		return true;
+	}
 
 	/*
 	 * The value that ends the loop must not wrap around. It is less than a step
@@ -2581,7 +2620,7 @@ static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_
 	switch (latch->op) {
 	case BPF_JLT:
 	case BPF_JSLT:
-		if (down || d.imin >= d.bmax ||
+		if (down ||
 		    check_add_overflow(div64_u64(d.bmax - d.imin - 1, step), 1, &cnt) ||
 		    d.bmax > d.hi || step - 1 > d.hi - d.bmax)
 			return false;
@@ -2589,7 +2628,7 @@ static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_
 		break;
 	case BPF_JLE:
 	case BPF_JSLE:
-		if (down || d.imin > d.bmax ||
+		if (down ||
 		    check_add_overflow(div64_u64(d.bmax - d.imin, step), 1, &cnt) ||
 		    d.bmax > d.hi || step > d.hi - d.bmax)
 			return false;
@@ -2597,7 +2636,7 @@ static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_
 		break;
 	case BPF_JGT:
 	case BPF_JSGT:
-		if (!down || d.imax <= d.bmin ||
+		if (!down ||
 		    check_add_overflow(div64_u64(d.imax - d.bmin - 1, step), 1, &cnt) ||
 		    d.bmin < d.lo || step - 1 > d.bmin - d.lo)
 			return false;
@@ -2605,7 +2644,7 @@ static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_
 		break;
 	case BPF_JGE:
 	case BPF_JSGE:
-		if (!down || d.imax < d.bmin ||
+		if (!down ||
 		    check_add_overflow(div64_u64(d.imax - d.bmin, step), 1, &cnt) ||
 		    d.bmin < d.lo || step > d.bmin - d.lo)
 			return false;
@@ -2766,7 +2805,8 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	}
 
 
-	if (!compute_backedge_taken_count(op, initial, step, bound, &backedge_taken_count))
+	if (!compute_backedge_taken_count(op, initial_val.ptr_reg >= 0, initial, step, bound,
+					  &backedge_taken_count))
 		return false;
 
 	/*
@@ -2789,7 +2829,9 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	}
 
 counted:
-	*false_until = latch_false_until(latch, &initial_val, &step_val, &bound_val,
+	/* A latch that is false at once may be on its way to the values for which it's true. */
+	*false_until = !backedge_taken_count ? 0 :
+		       latch_false_until(latch, &initial_val, &step_val, &bound_val,
 					 backedge_taken_count);
 	/* The header executes once on entry and once for each taken backedge, hence +1. */
 	iters->max_header_count = backedge_taken_count + 1;
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index f3908f37ca74..790cbfe1f2e4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -858,15 +858,15 @@ PRE__COND_TEST (pre_gt_sign,       "<=",  ITER_S64_MIN + 1,           -1, ITER_S
  *        r6 += 2;                   // unreachable
  *    }
  */
-PRE__COND_TEST (pre_lt_false,      ">=",                 7,            2,                7, "can't compute iterations count")
-PRE__COND_TEST (pre_le_false,      ">",                  8,            2,                7, "can't compute iterations count")
-PRE__COND_TEST (pre_gt_false,      "<=",                 3,           -2,                3, "can't compute iterations count")
-PRE__COND_TEST (pre_ge_false,      "<",                  2,           -2,                3, "can't compute iterations count")
-PRE__COND_TEST (pre_slt_false,     "s>=",                1,            2,                1, "can't compute iterations count")
-PRE__COND_TEST (pre_sle_false,     "s>",                 2,            2,                1, "can't compute iterations count")
-PRE__COND_TEST (pre_sgt_false,     "s<=",               -1,           -2,               -1, "can't compute iterations count")
-PRE__COND_TEST (pre_sge_false,     "s<",                -2,           -2,               -1, "can't compute iterations count")
-PRE__COND_TEST (pre_ne_false,      "==",                 7,            2,                7, "can't compute iterations count")
+PRE__COND_TEST (pre_lt_false,      ">=",                 7,            2,                7, "header_count is 1 ")
+PRE__COND_TEST (pre_le_false,      ">",                  8,            2,                7, "header_count is 1 ")
+PRE__COND_TEST (pre_gt_false,      "<=",                 3,           -2,                3, "header_count is 1 ")
+PRE__COND_TEST (pre_ge_false,      "<",                  2,           -2,                3, "header_count is 1 ")
+PRE__COND_TEST (pre_slt_false,     "s>=",                1,            2,                1, "header_count is 1 ")
+PRE__COND_TEST (pre_sle_false,     "s>",                 2,            2,                1, "header_count is 1 ")
+PRE__COND_TEST (pre_sgt_false,     "s<=",               -1,           -2,               -1, "header_count is 1 ")
+PRE__COND_TEST (pre_sge_false,     "s<",                -2,           -2,               -1, "header_count is 1 ")
+PRE__COND_TEST (pre_ne_false,      "==",                 7,            2,                7, "header_count is 1 ")
 
 /*
  * The counter moves away from the exit; bound fallback verification.
-- 
2.55.0

