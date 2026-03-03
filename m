Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2E36EAAB
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566049; cv=none; b=fiDA2/H14g7vnQ1KQJNGWxCoApKmhixIKFRz5MNmfFkKDMw7/th/HCAtRUOrqqSSj1HmuYc8t35Slg9GDlc5Dn00gFy4ezSNYmgDL1LftmjW299HFmf54mKkRhB35NQT6oeJWgYAQqVlx3keYc1BsVljSVozWLydR7RA3XynF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566049; c=relaxed/simple;
	bh=3KQTnb7khAeZO66gkrvN0Vybgn9ssamBPBLbak/e7g8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jSHVpfEnaxhByyLm488/KyCFelBwHe8/Et+uFb86by2l0k8/UPxhkFJIFjIVkmS4b4ijzzI7kylEuZYXd3dVa/6O5IIErOc3vEVoNe9f/7kS9OO2I3i1WmdwS/qZgKkEgG+G/S3nx/j6lQwcAUJJ6ck4sZBIgTbB5iYhbEEa4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH/AsFKk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH/AsFKk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4807068eacbso50207005e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 11:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772566044; x=1773170844; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+RXAX9PEVTKAQLrJdNQtqPtGtgnDbJVl3qqHrqDcCE=;
        b=dH/AsFKkmmU56fDkbbQxORhNSsI24XAxc9Tmbaw9dSMOT06oTjnYL4pgqIRcxXY4WB
         0UxXed4bfKLQpLmfgxwMs9v/FTlB/00ad/vJUYnItNPLc5mGDvnnFVXoFFa7BaQWv0jr
         d8ClwM6Kosbo6MmElDCLTv1Xd59RQTO+dky32Htcri5dZJj+tKP1HW9f2+KACqSTX2CH
         1GlFv21qTqLGcSq118MEK/wcXAFy0nEXV9z/izMl6d31KxJgXxvs/k9drfU0x+d5ooTa
         p9an/C8n9IC4DyvITz72nUvEJBKOxzXdIlSA3ZfXitSfHnPuHMOSHAB4/8+O2UEOk7Y/
         jx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566044; x=1773170844;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+RXAX9PEVTKAQLrJdNQtqPtGtgnDbJVl3qqHrqDcCE=;
        b=TPA0Kz1/mhDPcGYzE/Ct09UL6MMEFKFizl9ytb0TUfGy9K00/wxnL1FYf0l3TKSKZp
         X9BRG7Adraqv3f0UTOJEn75UdglY2RQ2Dp/8v48gWZ9xQ/3s7bPdnzZYeCA1X83rmjt6
         DeyrsmSrZXYPYJrsFmI8S7v5j43Kny9v+5nnL/atxxPgyEJRvIv8UPYBUkEMIbfh2eZr
         6xw87DWXpu1/fmYQYnDEAhWMt/NMbJsZIcs5jjnY6AA6nlXuilufMuFW5cqKMZKHr1aG
         cNoVW9RKbArJD0GLCRrukqUDt6lCUxwifyCfKJeI2J0xO+VZBKCnG86MpHpOpy6UlNaM
         W4bQ==
X-Gm-Message-State: AOJu0YxHGXaqk9W3xSWHP2qP/cGlHdfMohOBhSGdHRVxrpEhM40U2Krs
	0UyWSwLr0g8nzGkaf18i6oANIYB0o8R7AeM5S7h9M+ojngBD/SD0g5/YHd6nwUDT
X-Gm-Gg: ATEYQzwYIuEjV8xMndJqfIbdvZnbBn4j7b8fv8WlDUwcYKm8Uk5Ymw94ZdY1oyK4v6x
	DycvJr7GKqZJluHZZdAMyqO/PTjdgvDRws7LnJBSON1iMB5Q7k1lT3M3+kYEJc74WuT48l1QbFB
	xBP8aRF8HhwL5oMa7L3YAHJ4hoZcQKPk8/vlpINjaxm5ZjhOq91zeElsMHsg5DZbwTj39JTjLxn
	Bh3cbjIPcr/bjkfitmRXN1CyE7f2IkmujeMPXvZfBwWLWzmLkX46+UC/2temJZu5uRrp79OadRG
	E08nEa25usUlDQAW14gptIQOMreIkaY/X3tXx/SJpdjIaLGc1W8WjU9qT2Bl+9iGtl/YTF93stW
	W+c/bUUXiVFCaSedsObf3HIiqv+1CCJCJ/Zpfq5atfXxNz7ndPUF+hsi3MNe0srNejdaWkvpifv
	AR60cVYEAYrDGUqE4p4v8dX1+/6BEjGecDsvJHOh9ZmOWLWrcMMBi9wSWmPra6Q7deOuIpuXX4y
	5RwO6DgTVz/vry59ZoAHOViihhEUrQh9+sr2yXNQafAPOps3CnpSjI+Ua7xTJ4WaK9FoDitMrOv
	XfWFBVhDPBdrL6MzDJb+dQ==
X-Received: by 2002:a05:600c:4ece:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-483c9bad811mr345958665e9.13.1772566043855;
        Tue, 03 Mar 2026 11:27:23 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e008a159e65a12d50f9.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:8a15:9e65:a12d:50f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335648esm56433955e9.5.2026.03.03.11.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 11:27:22 -0800 (PST)
Date: Tue, 3 Mar 2026 20:27:20 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Subject: [PATCH bpf-next 1/1] bpf: Avoid one round of bounds deduction
Message-ID: <aac2GMpnpoAKD4jX@mail.gmail.com>
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
        {u64, s64} -> {u64, s64}
        /* __reg_deduce_mixed_bounds: */
        u32 -> u64
        u32 -> s64
        {s32, s64} -> {s64, u64, tnum}
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

As expected, this change didn't have any impact on the number of
instructions processed when running it through the Cilium complexity
test suite [2].

Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
Link: https://pchaigno.github.io/test-verifier-complexity.html [2]
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 138 +++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fc4ccd1de569..55575f66aad5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2427,74 +2427,6 @@ static void __update_reg_bounds(struct bpf_reg_state *reg)
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
@@ -2649,6 +2581,75 @@ static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
 
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
@@ -2741,7 +2742,6 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
 	__reg_deduce_bounds(reg);
-	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
-- 
2.43.0

