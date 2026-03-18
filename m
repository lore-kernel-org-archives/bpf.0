Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64463F7AA3
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851372; cv=none; b=dgqhhez3illjJdd4/MehZUryGmePTe5uNW8W76L6SA+MG+vM26pd83YE1UXzTPPWolo1Wikdjd+JBjzLVvJIV9Dx+7RfeICAVydKP4UOfCJ5bFyUHUv47B59wG+Q20/XAcPcw80UG9P02LG3Cnzsq+BuwtSfPs6cCucG+yzuHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851372; c=relaxed/simple;
	bh=1kc3HOyJl/LZeIu/gJUDVLOT0SwvNq3dl0gdDKkLK5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feWPPnLl44Fusfe83eBMBRp8T7gNOJA1rg/Rx64Py21fi4G4658cNGnOAWyuEJQFhFYsebHPttKpUrEdFOAaL9h/fiUt+wtOBTqTit1Pwrf+Ha5VjFzdc3hL/yX8GmRPoU9WNmC89aO7I3WzfyqWY/P0WAZOME3x5Y9epTw43Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQfHGz7Z; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQfHGz7Z"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so98497a91.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851364; x=1774456164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAoVa9cBbDuj6rMDzBJ+lKu96a3gz0aaCKJWkX9siVM=;
        b=lQfHGz7Zwve4uwre32kRerDxutjxoBci/tZ6vVBgqDlbZZ1qB1JWFsm02JNfsApYUG
         03NsHVfuzxK+NWqUBhEMao1wn3o2f9oLo6MjGF7IAdhj/+x+QgZATCHzDZCagBY49IJF
         4Xxj1GeAYK0siIREtUjseOUtLR8xZ6OpCF8n9XpaMezNY1avMfSsv9GYdWwaAkNHK0Hn
         VCwsatuCnLcTO7GUf1zGnJ8O4Y3kqtZMDYUsHd1RhaIvL9uJcDpxuWZk7WS2R9exIzug
         pWOlYPTOgcP7Mol3XBU8UpOxgX5rsw6kTFDoXoYDElw71A+JoAV/FitJC5068a+L1qiu
         xyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851364; x=1774456164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yAoVa9cBbDuj6rMDzBJ+lKu96a3gz0aaCKJWkX9siVM=;
        b=XYDA4FHyzHkS2YoHc7Vy18iyzMQr8ff5Y3UJxyEfvVfxeNZK81oR9So1KvGmBRpT41
         BoactgiOiMFvaLZ5S0G2AT1L8sS7pj8TzOn4Akac4XUoUcRJU2qf13GUgCw3i0H6mtf4
         HG8y8nh1EH1DXig/9dMwyq9lwVrDkLINei0HKuxbvjNazj5cb9Atfn4jPaCP5akFRyYp
         6N2am3KsoXwzt/NskgXfQxy/7EoxHuZAsuRpkn3FGNq0vy/UQzrEljWYALNsWulwlarX
         DUrLiRSOgN3PTfAyujcI2FNvAC+WexYDY+jnsfFYRzf+Eibygwz13A/HD/DXvp1DSIA+
         ky0A==
X-Gm-Message-State: AOJu0YzzKA8iHvrxtoyeNJeCTouSRUi1Zeroag9se9v0Q+NoWON1/kd2
	A/wuVcgq3tMPb8ScLoTguSW3oMswuWPCZuT//Z8desJmkfH4JAx3dlaEJVv22A==
X-Gm-Gg: ATEYQzyn4QtIFJ2XmLmX/DQqPVynTG+hB6vvC+WpqDFpcktcZcuOTNNPUMizM0jBQf+
	NueyEGqHwgSNZdvqOoCvZo4jCGQcEg2J8/fiWmGDJ8gSjN83ILyxonsz/B8q5GIz2SLPNbKZPMy
	w8il6OF7yqZ5ppHXP3Y+LW74BMcytYipx5QWyMmic031U3CbtdKOQcsya7dAsuHh/1sJgOX+ltG
	Q2PuYk0qEWID2H59iXx9cxSqCme9iCpnin1R4kwfi7WXfsqAkMS8ZDwzG9VQUxOTv/GzGws0lyi
	17eW5hdBaxc6YHI5ls3t8hYLHHBL4D9kEfEZ7jOyhnLmgzMuFK3jVTKFNt0uRPmWTeA6WKSLaTP
	J9g3RlFSTMvFd4+WFuPdF/OH1KOZOmKYHcAhVP3sqVftZjT8X1oMNKycGAkV25EGtu4X1GqoAlU
	cQSxEZ71wb9ENQy4GbxRyx5UJSoGXoi4TsxoND4+tbewUm9E14gUgdjZ7fuJw=
X-Received: by 2002:a17:90b:4fc4:b0:35a:24f3:2c8e with SMTP id 98e67ed59e1d1-35bb9eb48c5mr3520832a91.9.1773851364367;
        Wed, 18 Mar 2026 09:29:24 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm89370a91.14.2026.03.18.09.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:29:23 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	harishankar.vishwanathan@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v1 2/4] bpf: cnum for 32->32, 64->64, 64->32 deductions in reg_bounds_sync
Date: Wed, 18 Mar 2026 09:28:59 -0700
Message-ID: <20260318-cnum-sync-bounds-v1-2-1f2e455ea711@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For deduce_bounds_32_from_32() and deduce_bounds_64_from_64()
cnum-based implementation is an intersection of arcs formed by signed
and unsigned register ranges:

  if (cnum32_intersect(cnum32_from_ureg(reg),
                       cnum32_from_sreg(reg),
                       cnum))
    cnum_update_reg32_bounds(reg, cnum);

For deduce_bounds_32_from_64() cnum-based implementation is an
intersection of arcs formed by signed and unsigned register 64-bit
ranges projected to a 32-bit ring.

  if (cnum64_from_reg(reg, &cnum))
    cnum_update_reg32_bounds(reg, cnum32_from_cnum64(cnum));

A non-functional change.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 297 ++++++++++----------------------------------------
 1 file changed, 59 insertions(+), 238 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 01c18f4268deb3355f3ab03c41ceacc7e9d712c6..45ee8711c50c5ef19d7a24333e55abcded93a8fb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -26,6 +26,7 @@
 #include <linux/poison.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <linux/cnum.h>
 #include <linux/bpf_mem_alloc.h>
 #include <net/xdp.h>
 #include <linux/trace_events.h>
@@ -2447,255 +2448,75 @@ static void __update_reg_bounds(struct bpf_reg_state *reg)
 	__update_reg64_bounds(reg);
 }
 
+static struct cnum32 cnum32_from_ureg(struct bpf_reg_state *reg)
+{
+	return cnum32_from_urange(reg->u32_min_value, reg->u32_max_value);
+}
+
+static struct cnum32 cnum32_from_sreg(struct bpf_reg_state *reg)
+{
+	return cnum32_from_srange(reg->s32_min_value, reg->s32_max_value);
+}
+
+static struct cnum64 cnum64_from_ureg(struct bpf_reg_state *reg)
+{
+	return cnum64_from_urange(reg->umin_value, reg->umax_value);
+}
+
+static struct cnum64 cnum64_from_sreg(struct bpf_reg_state *reg)
+{
+	return cnum64_from_srange(reg->smin_value, reg->smax_value);
+}
+
+static bool cnum32_from_reg(struct bpf_reg_state *reg, struct cnum32 *cnum)
+{
+	return cnum32_intersect(cnum32_from_ureg(reg), cnum32_from_sreg(reg), cnum);
+}
+
+static bool cnum64_from_reg(struct bpf_reg_state *reg, struct cnum64 *cnum)
+{
+	return cnum64_intersect(cnum64_from_ureg(reg), cnum64_from_sreg(reg), cnum);
+}
+
+static void cnum_update_reg32_bounds(struct bpf_reg_state *reg, struct cnum32 cnum)
+{
+	reg->u32_min_value = max_t(u32, reg->u32_min_value, cnum32_umin(cnum));
+	reg->u32_max_value = min_t(u32, reg->u32_max_value, cnum32_umax(cnum));
+	reg->s32_min_value = max_t(s32, reg->s32_min_value, cnum32_smin(cnum));
+	reg->s32_max_value = min_t(s32, reg->s32_max_value, cnum32_smax(cnum));
+}
+
+static void cnum_update_reg64_bounds(struct bpf_reg_state *reg, struct cnum64 cnum)
+{
+	reg->umin_value = max_t(u64, reg->umin_value, cnum64_umin(cnum));
+	reg->umax_value = min_t(u64, reg->umax_value, cnum64_umax(cnum));
+	reg->smin_value = max_t(s64, reg->smin_value, cnum64_smin(cnum));
+	reg->smax_value = min_t(s64, reg->smax_value, cnum64_smax(cnum));
+}
+
 /* Uses signed min/max values to inform unsigned, and vice-versa */
 static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
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
+	struct cnum64 cnum;
+
+	if (cnum64_from_reg(reg, &cnum))
+		cnum_update_reg32_bounds(reg, cnum32_from_cnum64(cnum));
 }
 
 static void deduce_bounds_32_from_32(struct bpf_reg_state *reg)
 {
-	/* if u32 range forms a valid s32 range (due to matching sign bit),
-	 * try to learn from that
-	 */
-	if ((s32)reg->u32_min_value <= (s32)reg->u32_max_value) {
-		reg->s32_min_value = max_t(s32, reg->s32_min_value, reg->u32_min_value);
-		reg->s32_max_value = min_t(s32, reg->s32_max_value, reg->u32_max_value);
-	}
-	/* If we cannot cross the sign boundary, then signed and unsigned bounds
-	 * are the same, so combine.  This works even in the negative case, e.g.
-	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
-	 */
-	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
-		reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
-		reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
-	} else {
-		if (reg->u32_max_value < (u32)reg->s32_min_value) {
-			/* See __reg64_deduce_bounds() for detailed explanation.
-			 * Refine ranges in the following situation:
-			 *
-			 * 0                                                   U32_MAX
-			 * |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
-			 * |----------------------------|----------------------------|
-			 * |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
-			 * 0                     S32_MAX S32_MIN                    -1
-			 */
-			reg->s32_min_value = (s32)reg->u32_min_value;
-			reg->u32_max_value = min_t(u32, reg->u32_max_value, reg->s32_max_value);
-		} else if ((u32)reg->s32_max_value < reg->u32_min_value) {
-			/*
-			 * 0                                                   U32_MAX
-			 * |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
-			 * |----------------------------|----------------------------|
-			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
-			 * 0                     S32_MAX S32_MIN                    -1
-			 */
-			reg->s32_max_value = (s32)reg->u32_max_value;
-			reg->u32_min_value = max_t(u32, reg->u32_min_value, reg->s32_min_value);
-		}
-	}
+	struct cnum32 cnum;
+
+	if (cnum32_from_reg(reg, &cnum))
+		cnum_update_reg32_bounds(reg, cnum);
 }
 
 static void deduce_bounds_64_from_64(struct bpf_reg_state *reg)
 {
-	/* If u64 range forms a valid s64 range (due to matching sign bit),
-	 * try to learn from that. Let's do a bit of ASCII art to see when
-	 * this is happening. Let's take u64 range first:
-	 *
-	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
-	 * |-------------------------------|--------------------------------|
-	 *
-	 * Valid u64 range is formed when umin and umax are anywhere in the
-	 * range [0, U64_MAX], and umin <= umax. u64 case is simple and
-	 * straightforward. Let's see how s64 range maps onto the same range
-	 * of values, annotated below the line for comparison:
-	 *
-	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
-	 * |-------------------------------|--------------------------------|
-	 * 0                        S64_MAX S64_MIN                        -1
-	 *
-	 * So s64 values basically start in the middle and they are logically
-	 * contiguous to the right of it, wrapping around from -1 to 0, and
-	 * then finishing as S64_MAX (0x7fffffffffffffff) right before
-	 * S64_MIN. We can try drawing the continuity of u64 vs s64 values
-	 * more visually as mapped to sign-agnostic range of hex values.
-	 *
-	 *  u64 start                                               u64 end
-	 *  _______________________________________________________________
-	 * /                                                               \
-	 * 0             0x7fffffffffffffff 0x8000000000000000        U64_MAX
-	 * |-------------------------------|--------------------------------|
-	 * 0                        S64_MAX S64_MIN                        -1
-	 *                                / \
-	 * >------------------------------   ------------------------------->
-	 * s64 continues...        s64 end   s64 start          s64 "midpoint"
-	 *
-	 * What this means is that, in general, we can't always derive
-	 * something new about u64 from any random s64 range, and vice versa.
-	 *
-	 * But we can do that in two particular cases. One is when entire
-	 * u64/s64 range is *entirely* contained within left half of the above
-	 * diagram or when it is *entirely* contained in the right half. I.e.:
-	 *
-	 * |-------------------------------|--------------------------------|
-	 *     ^                   ^            ^                 ^
-	 *     A                   B            C                 D
-	 *
-	 * [A, B] and [C, D] are contained entirely in their respective halves
-	 * and form valid contiguous ranges as both u64 and s64 values. [A, B]
-	 * will be non-negative both as u64 and s64 (and in fact it will be
-	 * identical ranges no matter the signedness). [C, D] treated as s64
-	 * will be a range of negative values, while in u64 it will be
-	 * non-negative range of values larger than 0x8000000000000000.
-	 *
-	 * Now, any other range here can't be represented in both u64 and s64
-	 * simultaneously. E.g., [A, C], [A, D], [B, C], [B, D] are valid
-	 * contiguous u64 ranges, but they are discontinuous in s64. [B, C]
-	 * in s64 would be properly presented as [S64_MIN, C] and [B, S64_MAX],
-	 * for example. Similarly, valid s64 range [D, A] (going from negative
-	 * to positive values), would be two separate [D, U64_MAX] and [0, A]
-	 * ranges as u64. Currently reg_state can't represent two segments per
-	 * numeric domain, so in such situations we can only derive maximal
-	 * possible range ([0, U64_MAX] for u64, and [S64_MIN, S64_MAX] for s64).
-	 *
-	 * So we use these facts to derive umin/umax from smin/smax and vice
-	 * versa only if they stay within the same "half". This is equivalent
-	 * to checking sign bit: lower half will have sign bit as zero, upper
-	 * half have sign bit 1. Below in code we simplify this by just
-	 * casting umin/umax as smin/smax and checking if they form valid
-	 * range, and vice versa. Those are equivalent checks.
-	 */
-	if ((s64)reg->umin_value <= (s64)reg->umax_value) {
-		reg->smin_value = max_t(s64, reg->smin_value, reg->umin_value);
-		reg->smax_value = min_t(s64, reg->smax_value, reg->umax_value);
-	}
-	/* If we cannot cross the sign boundary, then signed and unsigned bounds
-	 * are the same, so combine.  This works even in the negative case, e.g.
-	 * -3 s<= x s<= -1 implies 0xf...fd u<= x u<= 0xf...ff.
-	 */
-	if ((u64)reg->smin_value <= (u64)reg->smax_value) {
-		reg->umin_value = max_t(u64, reg->smin_value, reg->umin_value);
-		reg->umax_value = min_t(u64, reg->smax_value, reg->umax_value);
-	} else {
-		/* If the s64 range crosses the sign boundary, then it's split
-		 * between the beginning and end of the U64 domain. In that
-		 * case, we can derive new bounds if the u64 range overlaps
-		 * with only one end of the s64 range.
-		 *
-		 * In the following example, the u64 range overlaps only with
-		 * positive portion of the s64 range.
-		 *
-		 * 0                                                   U64_MAX
-		 * |  [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]              |
-		 * |----------------------------|----------------------------|
-		 * |xxxxx s64 range xxxxxxxxx]                       [xxxxxxx|
-		 * 0                     S64_MAX S64_MIN                    -1
-		 *
-		 * We can thus derive the following new s64 and u64 ranges.
-		 *
-		 * 0                                                   U64_MAX
-		 * |  [xxxxxx u64 range xxxxx]                               |
-		 * |----------------------------|----------------------------|
-		 * |  [xxxxxx s64 range xxxxx]                               |
-		 * 0                     S64_MAX S64_MIN                    -1
-		 *
-		 * If they overlap in two places, we can't derive anything
-		 * because reg_state can't represent two ranges per numeric
-		 * domain.
-		 *
-		 * 0                                                   U64_MAX
-		 * |  [xxxxxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxxxxx]        |
-		 * |----------------------------|----------------------------|
-		 * |xxxxx s64 range xxxxxxxxx]                    [xxxxxxxxxx|
-		 * 0                     S64_MAX S64_MIN                    -1
-		 *
-		 * The first condition below corresponds to the first diagram
-		 * above.
-		 */
-		if (reg->umax_value < (u64)reg->smin_value) {
-			reg->smin_value = (s64)reg->umin_value;
-			reg->umax_value = min_t(u64, reg->umax_value, reg->smax_value);
-		} else if ((u64)reg->smax_value < reg->umin_value) {
-			/* This second condition considers the case where the u64 range
-			 * overlaps with the negative portion of the s64 range:
-			 *
-			 * 0                                                   U64_MAX
-			 * |              [xxxxxxxxxxxxxx u64 range xxxxxxxxxxxxxx]  |
-			 * |----------------------------|----------------------------|
-			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s64 range |
-			 * 0                     S64_MAX S64_MIN                    -1
-			 */
-			reg->smax_value = (s64)reg->umax_value;
-			reg->umin_value = max_t(u64, reg->umin_value, reg->smin_value);
-		}
-	}
+	struct cnum64 cnum;
+
+	if (cnum64_from_reg(reg, &cnum))
+		cnum_update_reg64_bounds(reg, cnum);
 }
 
 static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)

-- 
2.51.1
