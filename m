Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955D3C344D
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023821; cv=none; b=n/LDA1G4pJhcKzhleKkmm4kpgm2lvMy6c4xoxRwa++InyVA7nHo2srPldLgAxo0KbhEb3+oC7FbjGe8Cq3LBTZW0W/RTxxeGGEG/8Yn4qLmlHDWUh0WEoRs6/LU5ezI5FHCsj/UXcoijXdyBtJC2OlZGL4HEvIJSR/ZoPyH9eSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023821; c=relaxed/simple;
	bh=FhY4pkFZ5IWpYfCnyqoA1Rh+ws54D8JIe1Ujk42BhZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DTfrzW7PCFRBtmLT50DM6cezJbvPYJCMhkMaSevn8kF0qK+uMfGzo8djBSoHhIacCP5CdZbEb3M/ND/RR+LThPm5srXbKI6kaRy1ecOMD/FwHmZy+53QLgjfInU8kMKsqv6dPA5LENX9KV2as7apbea2S7p/rPxR1Izv44dPhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzoOqhG7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzoOqhG7"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b5bded412so1188407f8f.0
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774023818; x=1774628618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOQ9dUHW8BuX7G28HmAPUp4J7EDZbgVaRT2VSkocffY=;
        b=WzoOqhG7Ci+TwP7ijnTJuv6sHq9TUWu7eeNyEvmUxgUeb/yPvcPotcLCp1IHJRjIs6
         Z56x/i4FgytoBpzT3Y3YuL95ttPkyfcbIMl+/lS3vGP7gqAeaHEUpJjGE7kxNDHaoBFQ
         6Vw+lKDTIZYOtn7QbIdPJliLYt/bUIGh3UQASNU8QulSThLg+aiKds0db/X71rXIblUq
         K45uAueA2HMEkd5k65Zmoa3X1pUcYKVVdXREyieXrswa1L6DQ7ew6dzdSkxvoGpOc0YD
         VcI0ms1gX6O6B/sTjiS9HrngWL5MOKGxWLQAjaIdX/KsriWV7OajGYikJylwIGZ+9CpR
         v9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774023818; x=1774628618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOQ9dUHW8BuX7G28HmAPUp4J7EDZbgVaRT2VSkocffY=;
        b=Gups1ly+ctwehteMmTs7VJeaqiPdU3ijjlH53ks2p0Lj22EyG3Kw2n8Xh4LG8kQ8OR
         Bzyk1HB0YiZoekGK3Ysf6DDUNKqdomvJe2cTFmGMRJcXZrW+UjwQA0DJKOkI2cu8MQ6h
         KOIn93a1bOY+8B5FRTe3a7hzBxxVfz5sQNXxvcvpBUJQtToJuLqBnpWPwMB1R3qPVppr
         QNWf/bidcgKmoC4wBYWhrE9mO5tLRIWI939bGeEQkzj3ZG2oOPtqHfBJISV9+lFharne
         Y4hxdCScH9ITbKE0wCUQ6wUSRaJ6u2jns+8JfjCHEtATlzHpNIYiTDiy3cwvK/TCjNWO
         9AMg==
X-Gm-Message-State: AOJu0Yweqz4EweWDj5Z6kYiadnKFv5ZH8orSFbHQP/GFngMDjm+ETys1
	I4OshL1wYq0+e4ild8mOI2kOoJxexChgzIw7bMtu+Q0bI+dsCaJkyiS8TFm9
X-Gm-Gg: ATEYQzw+O1y8R+QbZGW5I5wZbUL9MCjJu6HCiRnKsOA0AQvkwB/MPOtOdkmSAGi6V5N
	LhQdcz1N3++raJeo1d9KtC0q11cs3yfXrlJW3cwhQydo1eupKyo411BUtZqnGdesaWzVgHaGxKQ
	asut87Z8sLryytOSwCZrqDxkIN5R9/OVXK+kFcoc2HndRgzl+9jHeVU9GMJ8vTr3HoDVB6QliYX
	qbgB0ayZ9DRFmMORskC01MnBfVns9TAc0IqvedKd0q1o3lOywoyf3JlpQfEcuMEnz6GNJlRqpMJ
	h+GlnJvmej/AyDshMZ+CTq9LkbDXsdbMth27iGwztC/JtinUxhKy3oLwvzzeywsAPmJB6gQ+rIK
	Q4ihmnXgyeLb1dvYPahDHL7r4p+3m41W1DmswFTLJc840gZQu/Z4uuJTrg/+GPIJcYNMdgLoKOZ
	RVvlNRFoVCM33hpRVG9pbJvhi1+WwuKMicGY5vYwq3uCDZZElVXkNl4+pFP6fZPfJUTFED5DSP6
	+Vvxg==
X-Received: by 2002:a05:6000:24c4:b0:43b:45d1:f449 with SMTP id ffacd0b85a97d-43b6427cde9mr6394315f8f.51.1774023817766;
        Fri, 20 Mar 2026 09:23:37 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644acb52sm8152704f8f.7.2026.03.20.09.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:23:37 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com,
	shung-hsi.yu@suse.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com
Subject: [PATCH bpf-next v2] bpf: Simplify tnum_step()
Date: Fri, 20 Mar 2026 17:23:36 +0100
Message-Id: <20260320162336.166542-1-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Simplify tnum_step() from a 10-variable algorithm into a straight
line sequence of bitwise operations.

Problem Reduction:

tnum_step(): Given a tnum `(tval, tmask)` where `tval & tmask == 0`,
and a value `z` with `tval ≤ z < (tval | tmask)`, find the smallest
`r > z`, a tnum-satisfying value, i.e., `r & ~tmask == tval`.

Every tnum-satisfying value has the form tval | s where s is a subset
of tmask bits (s & ~tmask == 0).  Since tval and tmask are disjoint:

    tval | s  =  tval + s

Similarly z = tval + d where d = z - tval, so r > z becomes:

    tval + s  >  tval + d
    s > d

The problem reduces to: find the smallest s, a subset of tmask, such
that s > d.

Notice that `s` must be a subset of tmask, the problem now is simplified.

Algorithm:

The mask bits of `d` form a "counter" that we want to increment by one,
but the counter has gaps at the fixed-bit positions.  A normal +1 would
stop at the first 0-bit it meets; we need it to skip over fixed-bit
gaps and land on the next mask bit.

Step 1 -- plug the gaps:

    d | carry_mask | ~tmask

  - ~tmask fills all fixed-bit positions with 1.
  - carry_mask = (1 << fls64(d & ~tmask)) - 1 fills all positions
    (including mask positions) below the highest non-mask bit of d.

After this, the only remaining 0s are mask bits above the highest
non-mask bit of d where d is also 0 -- exactly the positions where
the carry can validly land.

Step 2 -- increment:

    (d | carry_mask | ~tmask) + 1

Adding 1 flips all trailing 1s to 0 and sets the first 0 to 1.  Since
every gap has been plugged, that first 0 is guaranteed to be a mask bit
above all non-mask bits of d.

Step 3 -- mask:

    ((d | carry_mask | ~tmask) + 1) & tmask

Strip the scaffolding, keeping only mask bits.  Call the result inc.

Step 4 -- result:

    tval | inc

Reattach the fixed bits.

A simple 8-bit example:
    tmask:        1  1  0  1  0  1  1  0
    d:            1  0  1  0  0  0  1  0     (d = 162)
                        ^
                        non-mask 1 at bit 5

With carry_mask = 0b00111111 (smeared from bit 5):

    d|carry|~tm   1  0  1  1  1  1  1  1
    + 1           1  1  0  0  0  0  0  0
    & tmask       1  1  0  0  0  0  0  0

The patch passes my local test: test_verifier, test_progs for
`-t verifier` and `-t reg_bounds`.

CBMC shows the new code is equiv to original one[1], and
a lean4 proof of correctness is available[2]:

theorem tnumStep_correct (tval tmask z : BitVec 64)
    -- Precondition: valid tnum and input z
    (h_consistent : (tval &&& tmask) = 0)
    (h_lo : tval ≤ z)
    (h_hi : z < (tval ||| tmask)) :
    -- Postcondition: r must be:
    --    (1) tnum member
    --    (2) z < r
    --    (3) for any other member w > z, r <= w
    let r := tnumStep tval tmask z
    satisfiesTnum64 r tval tmask ∧
    tval ≤ r ∧ r ≤ (tval ||| tmask) ∧
    z < r ∧
    ∀ w, satisfiesTnum64 w tval tmask → z < w → r ≤ w := by
  -- unfold definition
  unfold tnumStep satisfiesTnum64
  simp only []
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  -- the solver proves each conjunct
  · bv_decide
  · bv_decide
  · bv_decide
  · bv_decide
  · intro w hw1 hw2; bv_decide

[1] https://github.com/eddyz87/tnum-step-verif/blob/master/main.c
[2] https://pastebin.com/raw/czHKiyY0

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

---
v1 -> v2: inline proof, add code comments, add a variable `filled`.

 kernel/bpf/tnum.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 4abc359b3db0..ec9c310cf5d7 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -286,8 +286,7 @@ struct tnum tnum_bswap64(struct tnum a)
  */
 u64 tnum_step(struct tnum t, u64 z)
 {
-	u64 tmax, j, p, q, r, s, v, u, w, res;
-	u8 k;
+	u64 tmax, d, carry_mask, filled, inc;
 
 	tmax = t.value | t.mask;
 
@@ -299,29 +298,22 @@ u64 tnum_step(struct tnum t, u64 z)
 	if (z < t.value)
 		return t.value;
 
-	/* keep t's known bits, and match all unknown bits to z */
-	j = t.value | (z & t.mask);
-
-	if (j > z) {
-		p = ~z & t.value & ~t.mask;
-		k = fls64(p); /* k is the most-significant 0-to-1 flip */
-		q = U64_MAX << k;
-		r = q & z; /* positions > k matched to z */
-		s = ~q & t.value; /* positions <= k matched to t.value */
-		v = r | s;
-		res = v;
-	} else {
-		p = z & ~t.value & ~t.mask;
-		k = fls64(p); /* k is the most-significant 1-to-0 flip */
-		q = U64_MAX << k;
-		r = q & t.mask & z; /* unknown positions > k, matched to z */
-		s = q & ~t.mask; /* known positions > k, set to 1 */
-		v = r | s;
-		/* add 1 to unknown positions > k to make value greater than z */
-		u = v + (1ULL << k);
-		/* extract bits in unknown positions > k from u, rest from t.value */
-		w = (u & t.mask) | t.value;
-		res = w;
-	}
-	return res;
+	/*
+	 * Let r be the result tnum member, z = t.value + d.
+	 * Every tnum member is t.value | s for some submask s of t.mask,
+	 * and since t.value & t.mask == 0, t.value | s == t.value + s.
+	 * So r > z becomes s > d where d = z - t.value.
+	 *
+	 * Find the smallest submask s of t.mask greater than d by
+	 * "incrementing d within the mask": fill every non-mask
+	 * position with 1 (`filled`) so +1 ripples through the gaps,
+	 * then keep only mask bits. `carry_mask` additionally fills
+	 * positions below the highest non-mask 1 in d, preventing
+	 * it from trapping the carry.
+	 */
+	d = z - t.value;
+	carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
+	filled = d | carry_mask | ~t.mask;
+	inc = (filled + 1) & t.mask;
+	return t.value | inc;
 }
-- 
2.34.1

