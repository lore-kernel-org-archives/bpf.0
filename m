Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B680226CFE
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854351; cv=none; b=pBF0Z4WuQTaGOl55u/7Kk7k94p+M3UOs5ygj89xQbPf9Ltg8fxJ47ppuGJwZp2SsufnFTtQETNW+jwfmY3dc7ku8qXvkqVmlh1hz+RdShA5jmuRNFjLU7kWg7hVrXxQU7OQ1FNOPJV8RdmV5OuNNm41RK5ovWeKsPXVqE/KYWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854351; c=relaxed/simple;
	bh=moyMfN39cEu3RTYoPFylkAwAzKj00qynfBVYJ9w/YUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=vDGq31AD8WuDYHkT7n4FdiDxgz+a4KNwft8YyhY+PRfrX69eKcuorUwAcgw9QEhGCftZhEwQoeN2UwRgcDmDR8ImGy/yFHALTu5NTU9AmyigK8I7Fmu21om65zQJu1dmP+Z2Wvn6P+zA7LfqxjqHjUL9S9/WRSJC7W7AQlCP4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuMXAXzg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuMXAXzg"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso24509f8f.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773854348; x=1774459148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q51DvlvId1ztG4OXoKK0qrunZ8soIsuqncOm3QjsVNM=;
        b=LuMXAXzgylocdEEJ/mA/yLNQTQ+qWAbIkQ9t0I3p2P6Kwl2A6XcylVPQ8knG41BP2z
         mj2sJU9eLxjCTvwWWJ4Cs/iXynUxHNr4X7a1+RnYF9sdV8weRPAp7wrjePInLAOHRStH
         enKmsFrMbDJtlQGXv/EPkUlZ2IYUyageiw5Jb9xGf/UbiU1aH69j+OWHQVQoVBdiJMFh
         QJWJd0uBU6evjY7hUeAZ2kx80jNtO38tlIApI+VOB90FaN1wjsIwVECTNzcUoCf2G0Bo
         O6vkK5duicL/zuBaAZFBRuHu/oH0qiU/BOQW9BEROTo4/Rqe/+Qyl+CKYiB6e6UuJMr0
         p+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773854348; x=1774459148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q51DvlvId1ztG4OXoKK0qrunZ8soIsuqncOm3QjsVNM=;
        b=rdFsiPYLjJmVMloe6dITyJHDOuOrnTytxKyI3I1E5P+m/14VIRSzI3a8UhtTMSG7KW
         7VT2abWXz+NP4knkY93LQsrjVX/wDGiWXmY29eD0jtUHMyxHT/5FCKkcXPx4TlaEPAww
         rOddlUWhz4ppCcOExw/IMmpTP+piNM3tHG3NqQeM3S9O+3ys8vZHMCOuXBR/zdlSBSla
         5EFxRjMHV3ZjkW8MldUZc6e//QtJZqN1rianCjbwbba5JyZ74oBEuVTSw0gUI0WWP9sL
         76HNkSCT+TtkZXpEWiBrR0uxQIHXVpy8glSC6svCZ1iF2bzhB/Tjm8iXI4MAux3kmyzP
         8r3Q==
X-Gm-Message-State: AOJu0YzskNY0CD5uNnwwr59UVZC5v4ccoeVRp9J4m+mmbUp1FqDY9D8L
	xA66C9jhb5yuxvv0rct1EalAnL9A/cFDGl09xNjNldHrWSPyUGYIRRsaoyaX
X-Gm-Gg: ATEYQzyRN26clr+Z8QKX0BiD3FW28EKPEYJbaiih8ZrebbPDnRLImde+5BPBEDivRzj
	N5ssdW/hUh3w/HfxBOoxNC9k4NstAJF2f2nKk5l4Fhct1nikSBabljV05LRbBKCu8rCvjCpzoxD
	SeOPaf9bd2fCJXwbFh3FVl5+lmhAStydX5fWZ6z8JF+KHvE/33JZ8dcXHOX0h6ItH+EXImaOyhD
	OGsvjIzCFQ1a4inKT0mFEdNuX/H1LvhcjFFVbdpitCFAzpBAOuC0G38XKkbW8gmUBbc5lQ3PB7o
	AOTBarRYYoNUx8vpVCQC6cK2kN4Gb0wNuCqWr9LOr1doegWHgXfD86udhqenzRASX79z5HWIFpt
	VwnMn6pR7PExxBMUt47kO00+4qvjs7vKYmN9NkiQsL1Eo+2/jdEeNtaU/MMfr8sRY04acLc3Rie
	P7HS+a27z4YLh6PSyANwnDCteSqJ9OCCLtj8HEVkha+fDdrOLDgHJ94N4bK1tiuKRcBsBzQkHlV
	9zIaw==
X-Received: by 2002:a05:6000:b44:b0:43b:5765:96a9 with SMTP id ffacd0b85a97d-43b576597d1mr630745f8f.24.1773854347814;
        Wed, 18 Mar 2026 10:19:07 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518495aasm9213394f8f.3.2026.03.18.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:19:07 -0700 (PDT)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com
Subject: [PATCH] bpf: Simplify tnum_step()
Date: Wed, 18 Mar 2026 18:19:06 +0100
Message-Id: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
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

The patch passes my local test: test_verifier, test_prog for
`-t verifier` and `-t reg_bounds`.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
The original algorithm is not intuitive to me, let me know if you
spot any inconsistency.

A Lean4 proof for the correctness of the algorithm is also available
in case anyone is interested:
	[1] https://pastebin.com/raw/czHKiyY0

 kernel/bpf/tnum.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index 4abc359b3db0..aa35d4355216 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -286,8 +286,7 @@ struct tnum tnum_bswap64(struct tnum a)
  */
 u64 tnum_step(struct tnum t, u64 z)
 {
-	u64 tmax, j, p, q, r, s, v, u, w, res;
-	u8 k;
+	u64 tmax, d, carry_mask, inc;
 
 	tmax = t.value | t.mask;
 
@@ -299,29 +298,8 @@ u64 tnum_step(struct tnum t, u64 z)
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
+	d = z - t.value;
+	carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
+	inc = ((d | carry_mask | ~t.mask) + 1) & t.mask;
+	return t.value | inc;
 }
-- 
2.34.1

