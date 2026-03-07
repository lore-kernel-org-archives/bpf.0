Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D1944F
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841696; cv=none; b=oyUG27nvgeeTIQAS4/EgI9TQPJ+daJXIfn4YQT4ahye5X5fhMSNWzjlJl3CxHpolelu+Ojavz4g3wq4SvlaL0L2oKhttXa/ckXNnZ2IYsUwGcu/T2DtlfMeFK/7+Mjj0Zm9TY2JPmn8DbGwNsoZJtxlIDUzZ/8Uo0DzHXUxh8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841696; c=relaxed/simple;
	bh=6ozAcxKHjh0oFv/DGiWE2RNXFB096iJ5zWn2d/gjncA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fy/qjhDhtDq4pPntnAtmRTBLRjfdnDMSleJwK0HB4GKmAUukz6kHuySesk7NEQ4IsVwDuian3RrqHaY7zjTokYQkH1UqOOqd6/Gb1An2iSQPjHgdxA+/hygpyxL0RKyfXaQII9QVkdx4K19RfuBQnJGiTVSWk7G0EYXCdC48n/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImuKhmI+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImuKhmI+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439afc58ac7so6808643f8f.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772841693; x=1773446493; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGxZHBDnaJpl3OlGLZ5Avk+qOptnFQVWAMx22GzB8Kw=;
        b=ImuKhmI+iIv6WflyUXpBWeAWiohRM6YymQ/t8NfJ+BYF/H+y3ymxTTqPbAAYWuThas
         J9fQTXupfWgZsLTItGaiYBjBv7INjxPnMmAumnKiZkCUlfw51Ly+pIABWhPpfxbH508t
         34UZWXNQbVl8Jq7wo0ova0OxPWyJIbhggPkT+tWh4+7cuiZsjkBnuxzQgkKouiF4ZEzt
         LJ2Jrwo/i8xKJePTYmocsddIYaZdaDNZ80xGLJm55wSy2kA5skBtQI8eI97LOFwQoG/n
         rXtYUBJLGe5Exgp1ImI1UrB0TSndnykK3qShduTWAlh/S0pfcNlzFPXPv6WGuOp/4Po+
         tCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772841693; x=1773446493;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGxZHBDnaJpl3OlGLZ5Avk+qOptnFQVWAMx22GzB8Kw=;
        b=KLiyX7V7eVR/fU0UtztZEFy06BrPv9dBlVfcxGvt3mT9Usa5V4IhQ7/ipQiUKfuszj
         HaJs0Ap1pBQIOEINjch44oZdgrkusMU5+Pg0vnLXhwkFuXt64ybWnjxOVW1D56LOuJ/d
         ZVlj/J66SWkmql1B6qpy18EFmaIPIEFtxB1grcBEPxq+8vfI/RJdquKNuWeyr2XRtyLU
         uxgGmue5MNf7SdZcu+5SbcshJ34OKIqrww7zQkCBrl+JP3qTQNvD0OnCCkUMsaHIJzl3
         8qZsRgIhIV+C6Mrxk0Weg+18svEIHEBPp8btq6IXzq2KV/s6XqRuH2kRXxjqwJoqObQZ
         p/8g==
X-Gm-Message-State: AOJu0YxcRk2US1Fu8oZePqF6zC1Wi0L0a67mbCzWuEZ6EgIdQGpK+NW5
	kSUhph/ZeFFECgz2wy62MxyeZ9cJoDThqBx0ymERv5O8ca2sQhoX6sa7EmtpsGwL
X-Gm-Gg: ATEYQzzXNzWP4ldhEJpmejB8xEgwGWOPQiK41LEmtZxzETRFf+7rDkP3iyIwwnkUMi4
	lbZbYMOKv8KY53GaAIrSw3sKlSC6JPTQPgHNZI9amcnKdXWnU87PIIt4YWcWO+Dult8kUQDbzmH
	PwGnyByr8W0RXt1B+tQV+CCmxkSs5NYrfibqzl6rWFUa7iH7ErhBRVJRgmOvMcg+CNqZdksI5tP
	ojGzueTjFMrInZnwUvNpHbKrRNJ59rN29kUoc5XkPNrlTglkT0IUYLm1HjFHGmGfamgiQFlBbwc
	C34VkG2n4GiFQibakQPYimt76/OWVz0uABhnTMLZWUll1z6ZcBR78r7Hp3lPDF3QxzGNs9K8NiH
	2/IQOhkYp2G2EVHHMoX1cbISr31WMOz1l9AQDxHT7Y4BeYxb/YtSxp4nfiiMlWRoe723i1UaU6A
	z+9NAfSiPfrEHELyftiZXVsMJBGnpey85x9sM3ZvcIRwoU3lgYmk5FI4Jk8n7O2w4Kiw7RxAADH
	CdVM7SUBIAcvPEIO/bx10DUgyok9zACGuzlSZ9yawUPIwBFIudGFzDnTIBiOOhdxbEqMX/PRYdq
	iizgneDv7Ow=
X-Received: by 2002:a05:6000:2881:b0:437:711c:8754 with SMTP id ffacd0b85a97d-439da55541cmr7253626f8f.7.1772841692422;
        Fri, 06 Mar 2026 16:01:32 -0800 (PST)
Received: from Tunnel (2a01cb089436c000a341eb7e94b4f969.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:a341:eb7e:94b4:f969])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dada3b43sm7089399f8f.13.2026.03.06.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:01:31 -0800 (PST)
Date: Sat, 7 Mar 2026 01:01:29 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
Message-ID: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"), I
added a new round of bounds deduction because two rounds were not enough
to converge to a fixed point. This commit slightly refactor the bounds
deduction logic such that two rounds are enough.

In [1], Eduard noticed that after we improved the refinement logic, a
third call to the bounds deduction (__reg_deduce_bounds) was needed to
converge to a fixed point. More specifically, we needed this third call
to improve the s64 range using the s32 range. We added the third call
and postponed a more detailed analysis of the refinement logic.

I've been looking into this more recently. To help, I wrote a high level
sequence of all the refinements carried out in reg_bounds_sync. u64 ->
s32 means we used the u64 ranges to improve the s32 ranges.

    /* __update_reg_bounds: */
    tnum -> {s32, u32, s64, u64}
    /* __reg_deduce_bounds: */
    for (3 times) {
        /* __reg32_deduce_bounds: */
        u64 -> {u32, s32}
        s64 -> {u32, s32}
        u64 -> s32
        s64 -> s32
        u32 -> s32
        s32 -> u32
        /* __reg64_deduce_bounds: */
        u64 -> s64
        s64 -> u64
        u64 + s64 -> {u64, s64}
        /* __reg_deduce_mixed_bounds: */
        u32 -> u64
        u32 -> s64
        s32 + s64 -> {s64, u64, tnum}
    }
    /* __reg_bound_offset: */
    {u64, u32} -> tnum
    /* __update_reg_bounds: */
    tnum -> {s32, u32, s64, u64}

From this, we can observe that we first improve the 32bit ranges from
the 64bit ranges in __reg32_deduce_bounds, then improve the 64bit
ranges on their own in __reg64_deduce_bounds. Intuitively, if we were to
improve the 64bit ranges on their own *before* we use them to improve
the 32bit ranges, we may reach a fixed point earlier. Said otherwise, we
would need to move the *64 -> *32 refinements to the beginning of
__reg_deduce_mixed_bounds. (The logic would then also better match the
function names, but that's secondary.)

After testing, this small refactoring does allow us to lose one call to
__reg_deduce_bounds. Without this refactoring, the test
"verifier_bounds/bounds deduction cross sign boundary, negative
overlap" fails when removing one call to __reg_deduce_bounds. This
patch therefore implements that bit of refactoring and reverts commit
5dbb19b16ac49 ("bpf: Add third round of bounds deduction").

In some cases, this change can even improve precision a little bit, as
illustrated in the new selftest in the next patch.

As expected, this change didn't have any impact on the number of
instructions processed when running it through the Cilium complexity
test suite [2].

Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
Link: https://pchaigno.github.io/test-verifier-complexity.html [2]
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Updated description to mention potential precision improvement and
    to clarify the sequence of refinements (Shung-Hsi).
  - Added the second patch.
  - Rebased.

 kernel/bpf/verifier.c | 138 +++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d92cf2821657..792017d87ead 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2450,74 +2450,6 @@ static void __update_reg_bounds(struct bpf_reg_state *reg)
 /* Uses signed min/max values to inform unsigned, and vice-versa */
 static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 {
-	/* If upper 32 bits of u64/s64 range don't change, we can use lower 32
-	 * bits to improve our u32/s32 boundaries.
-	 *
-	 * E.g., the case where we have upper 32 bits as zero ([10, 20] in
-	 * u64) is pretty trivial, it's obvious that in u32 we'll also have
-	 * [10, 20] range. But this property holds for any 64-bit range as
-	 * long as upper 32 bits in that entire range of values stay the same.
-	 *
-	 * E.g., u64 range [0x10000000A, 0x10000000F] ([4294967306, 4294967311]
-	 * in decimal) has the same upper 32 bits throughout all the values in
-	 * that range. As such, lower 32 bits form a valid [0xA, 0xF] ([10, 15])
-	 * range.
-	 *
-	 * Note also, that [0xA, 0xF] is a valid range both in u32 and in s32,
-	 * following the rules outlined below about u64/s64 correspondence
-	 * (which equally applies to u32 vs s32 correspondence). In general it
-	 * depends on actual hexadecimal values of 32-bit range. They can form
-	 * only valid u32, or only valid s32 ranges in some cases.
-	 *
-	 * So we use all these insights to derive bounds for subregisters here.
-	 */
-	if ((reg->umin_value >> 32) == (reg->umax_value >> 32)) {
-		/* u64 to u32 casting preserves validity of low 32 bits as
-		 * a range, if upper 32 bits are the same
-		 */
-		reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->umin_value);
-		reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->umax_value);
-
-		if ((s32)reg->umin_value <= (s32)reg->umax_value) {
-			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
-			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
-		}
-	}
-	if ((reg->smin_value >> 32) == (reg->smax_value >> 32)) {
-		/* low 32 bits should form a proper u32 range */
-		if ((u32)reg->smin_value <= (u32)reg->smax_value) {
-			reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->smin_value);
-			reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->smax_value);
-		}
-		/* low 32 bits should form a proper s32 range */
-		if ((s32)reg->smin_value <= (s32)reg->smax_value) {
-			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
-			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
-		}
-	}
-	/* Special case where upper bits form a small sequence of two
-	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
-	 * 0x00000000 is also valid), while lower bits form a proper s32 range
-	 * going from negative numbers to positive numbers. E.g., let's say we
-	 * have s64 range [-1, 1] ([0xffffffffffffffff, 0x0000000000000001]).
-	 * Possible s64 values are {-1, 0, 1} ({0xffffffffffffffff,
-	 * 0x0000000000000000, 0x00000000000001}). Ignoring upper 32 bits,
-	 * we still get a valid s32 range [-1, 1] ([0xffffffff, 0x00000001]).
-	 * Note that it doesn't have to be 0xffffffff going to 0x00000000 in
-	 * upper 32 bits. As a random example, s64 range
-	 * [0xfffffff0fffffff0; 0xfffffff100000010], forms a valid s32 range
-	 * [-16, 16] ([0xfffffff0; 0x00000010]) in its 32 bit subregister.
-	 */
-	if ((u32)(reg->umin_value >> 32) + 1 == (u32)(reg->umax_value >> 32) &&
-	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >= 0) {
-		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
-		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
-	}
-	if ((u32)(reg->smin_value >> 32) + 1 == (u32)(reg->smax_value >> 32) &&
-	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >= 0) {
-		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
-		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
-	}
 	/* if u32 range forms a valid s32 range (due to matching sign bit),
 	 * try to learn from that
 	 */
@@ -2672,6 +2604,75 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 
 static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
 {
+	/* If upper 32 bits of u64/s64 range don't change, we can use lower 32
+	 * bits to improve our u32/s32 boundaries.
+	 *
+	 * E.g., the case where we have upper 32 bits as zero ([10, 20] in
+	 * u64) is pretty trivial, it's obvious that in u32 we'll also have
+	 * [10, 20] range. But this property holds for any 64-bit range as
+	 * long as upper 32 bits in that entire range of values stay the same.
+	 *
+	 * E.g., u64 range [0x10000000A, 0x10000000F] ([4294967306, 4294967311]
+	 * in decimal) has the same upper 32 bits throughout all the values in
+	 * that range. As such, lower 32 bits form a valid [0xA, 0xF] ([10, 15])
+	 * range.
+	 *
+	 * Note also, that [0xA, 0xF] is a valid range both in u32 and in s32,
+	 * following the rules outlined below about u64/s64 correspondence
+	 * (which equally applies to u32 vs s32 correspondence). In general it
+	 * depends on actual hexadecimal values of 32-bit range. They can form
+	 * only valid u32, or only valid s32 ranges in some cases.
+	 *
+	 * So we use all these insights to derive bounds for subregisters here.
+	 */
+	if ((reg->umin_value >> 32) == (reg->umax_value >> 32)) {
+		/* u64 to u32 casting preserves validity of low 32 bits as
+		 * a range, if upper 32 bits are the same
+		 */
+		reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->umin_value);
+		reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->umax_value);
+
+		if ((s32)reg->umin_value <= (s32)reg->umax_value) {
+			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
+			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
+		}
+	}
+	if ((reg->smin_value >> 32) == (reg->smax_value >> 32)) {
+		/* low 32 bits should form a proper u32 range */
+		if ((u32)reg->smin_value <= (u32)reg->smax_value) {
+			reg->u32_min_value = max_t(u32, reg->u32_min_value, (u32)reg->smin_value);
+			reg->u32_max_value = min_t(u32, reg->u32_max_value, (u32)reg->smax_value);
+		}
+		/* low 32 bits should form a proper s32 range */
+		if ((s32)reg->smin_value <= (s32)reg->smax_value) {
+			reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
+			reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
+		}
+	}
+	/* Special case where upper bits form a small sequence of two
+	 * sequential numbers (in 32-bit unsigned space, so 0xffffffff to
+	 * 0x00000000 is also valid), while lower bits form a proper s32 range
+	 * going from negative numbers to positive numbers. E.g., let's say we
+	 * have s64 range [-1, 1] ([0xffffffffffffffff, 0x0000000000000001]).
+	 * Possible s64 values are {-1, 0, 1} ({0xffffffffffffffff,
+	 * 0x0000000000000000, 0x00000000000001}). Ignoring upper 32 bits,
+	 * we still get a valid s32 range [-1, 1] ([0xffffffff, 0x00000001]).
+	 * Note that it doesn't have to be 0xffffffff going to 0x00000000 in
+	 * upper 32 bits. As a random example, s64 range
+	 * [0xfffffff0fffffff0; 0xfffffff100000010], forms a valid s32 range
+	 * [-16, 16] ([0xfffffff0; 0x00000010]) in its 32 bit subregister.
+	 */
+	if ((u32)(reg->umin_value >> 32) + 1 == (u32)(reg->umax_value >> 32) &&
+	    (s32)reg->umin_value < 0 && (s32)reg->umax_value >= 0) {
+		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->umin_value);
+		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->umax_value);
+	}
+	if ((u32)(reg->smin_value >> 32) + 1 == (u32)(reg->smax_value >> 32) &&
+	    (s32)reg->smin_value < 0 && (s32)reg->smax_value >= 0) {
+		reg->s32_min_value = max_t(s32, reg->s32_min_value, (s32)reg->smin_value);
+		reg->s32_max_value = min_t(s32, reg->s32_max_value, (s32)reg->smax_value);
+	}
+
 	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
 	 * values on both sides of 64-bit range in hope to have tighter range.
 	 * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
@@ -2764,7 +2765,6 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
 	__reg_deduce_bounds(reg);
-	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
-- 
2.43.0

