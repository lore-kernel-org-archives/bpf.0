Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D2366548
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708989; cv=none; b=YjLVgXdSF5fAJ3ZlxCxDqWcPIdqXhcxT3pQg66nkwuZr2KlZKHcj3H66TmiNlg8lpQbX6h4/bc9VPz9ZC7EPY6h/r62JFRRsSI81JHckxDJ+t/qGKEAjwFauiYtC8UpRwNbvCaOCHYrQ9vdOt1kq9zvd3nIAeDgDQN5EnG134V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708989; c=relaxed/simple;
	bh=Q/FdNtpGImn7O5rmgvSmcQtfH2jqv91yRBowb34fYLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfhmNbG5MiZ0FN7pUia2yJoPdv+/ArbqVBpMxS78jAexAxH5o8FoX01lx2LyaJjeqAVUOgStxSdTyYVU0BX/73QndF14vLdFfoaoRCmTRWqPtZaWXXEXvP9X7zLj6/IccdlrXkvLCMmyRvy9f07wt1nMjS1/Xy5n6aQ/7F9Me+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLOUsO60; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLOUsO60"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50335b926c2so73169611cf.2
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 03:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772708987; x=1773313787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGyp5DlEDSNyf1D+fHR1Xar9HkT1CTBb6h7JuOAsMfk=;
        b=iLOUsO60SdlLTnd/T+GCUM+a4Nf5Qpk9ONhIbuc1/3apIrN8TLOBkDgcLJ8jwVi1Pd
         zSSHS9c1W7lkmxKe0SrARGnVY52HT9C675V3odG/1rD0sSCDRuomsp4G6DLflx9lI1Uj
         nbA837JV95HZlZTpy2cDrXFTWMS1B/AR8gAARDXoVHGGG8iYf3hUUb3PXUZM0vq51KZl
         dm2wxuojAXcYH6dX+4Gnzu95rr50VdcQ+Ke3jHILh0nerdN8arU0uyxKsmv0NslxzO1I
         hxMGyi8yVEWSNXegJWxp5yppjwjy3n5SSp/NEPW5JyS27n3xADZPUknZT33fQHnp4rYV
         Xv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708987; x=1773313787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGyp5DlEDSNyf1D+fHR1Xar9HkT1CTBb6h7JuOAsMfk=;
        b=FQE4YI9DWBnkM5zSsImiNO0UTeO43GICCjL/g5bBVu0iK7YebqPPNzY+X9dM4lWpsE
         aCIWWYiWwQ6BG1OM9iWngfEe8FRPN+bJZWEctauYZc192/WBzjLZ8Z4JZx5nCg/VBv5t
         agwdJ4j5Z73H5m0nCvvGG5aMEn9Z11pA1+IX2VPklIXFKiD0tfae8fqJZxCySJc1VwWQ
         M+UFdxlK9bW51GSX1dgi2sZw8Qj8vKugCYQ8YgDEeVqY1ZqjIZ1p6y16oni6fE9hoKDZ
         TDMrgBbO8c16i0b/4LmRLibf0t0Z2CbNtpewprDzKlIrrSC735p1jW9Da+7kBv4C7ssT
         sKeg==
X-Gm-Message-State: AOJu0YxMR18J3GHZGjsJdmae+kaJ02no0xu+0gQPPSVV6C+32Cz3+oRs
	Xq0U4m1dl7Ud/dCWfB2GmGlI++jkpuupA4xCGeJtwqdCpSExrvaw16aDJxEJHA==
X-Gm-Gg: ATEYQzwvJJJpOhS1bmjuiJc57ZLpRrM9IobOP5MO1/tQN6/T48BYAM5P4IAv8Q6pt1O
	wMPYPpbLZl2VN0pwsRsI23v9hj+w8eedP+uHvLJ9Vu7CnMapdp410iYmo2fkH1x5jNBNoIxVLZf
	khDUeEILinyghJA/B+i38pea22mXuu7DdiKQ1HykirAdIXIBq1dnDfyO1PZvyio8VDBXvvd0xVr
	A4wt1h/nLNOM3DQlcaBXnlMkaElDt2t+lD9BXw9RAUNujXxsk/TRTcfhaIQc2mVshbmof9+H7rf
	mUUcaoDdGyW2XpdnAGx9kpYBnuJ/aVjAbtaMMPQz3YGJq/wXgqLC4puU/Nl/8lsP/us6H/YPzoD
	G+SM8qREy1Zkeh2E1TfHwqZuOGeDOXD8ZKwPh8tJOZIKhfVUWDq3kly2FGUED2FGdKBlBY3+bUZ
	9/JazETO39T2tM8sArEMZWioil1jzenVMLTQF81KSUWCrvTbIR
X-Received: by 2002:ac8:1115:0:b0:4ee:24fc:bea3 with SMTP id d75a77b69052e-508e0d0c138mr44444811cf.35.1772708986836;
        Thu, 05 Mar 2026 03:09:46 -0800 (PST)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744acfcdesm176006751cf.26.2026.03.05.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:09:46 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	arighi@nvidia.com,
	shung-hsi.yu@suse.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 1/2] bpf: refine u32/s32 bounds when ranges cross min/max boundary
Date: Thu,  5 Mar 2026 03:09:28 -0800
Message-ID: <20260305110929.738140-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
in __reg32_deduce_bounds() in the following situations:

0                                                   U32_MAX
|  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
|----------------------------|----------------------------|
|xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
0                     S32_MAX S32_MIN                    -1

0                                                   U32_MAX
|              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
|----------------------------|----------------------------|
|xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
0                     S32_MAX S32_MIN                    -1

This helps for e.g. consider the following program:

   call %[bpf_get_prandom_u32];
   w0 &= 0xffffffff;
   if w0 < 0x3 goto 1f;    // on fall-through u32 range [3..U32_MAX]
   if w0 s> 0x1 goto 1f;   // on fall-through s32 range [S32_MIN..1]
   if w0 s< 0x0 goto 1f;   // range can be narrowed to  [S32_MIN..-1]
   r10 = 0;
1: ...;

The reg_bounds.c selftest is updated to incorporate identical logic,
refinement based on non-overflowing range halves:

  ((x ∩ [0, smax]) ∩ (y ∩ [0, smax])) ∪
  ((x ∩ [smin,-1]) ∩ (y ∩ [smin,-1]))

Reported-by: Andrea Righi <arighi@nvidia.com>
Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
Closes: https://lore.kernel.org/bpf/aakqucg4vcujVwif@gpd4/T/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                         | 24 ++++++++
 .../selftests/bpf/prog_tests/reg_bounds.c     | 58 +++++++++++++++++--
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d92cf2821657..2b79a2a4d1b5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2532,6 +2532,30 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
 	if ((u32)reg->s32_min_value <= (u32)reg->s32_max_value) {
 		reg->u32_min_value = max_t(u32, reg->s32_min_value, reg->u32_min_value);
 		reg->u32_max_value = min_t(u32, reg->s32_max_value, reg->u32_max_value);
+	} else {
+		if (reg->u32_max_value < (u32)reg->s32_min_value) {
+			/* See __reg64_deduce_bounds() for detailed explanation.
+			 * Refine ranges in the following situation:
+			 *
+			 * 0                                                   U32_MAX
+			 * |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
+			 * |----------------------------|----------------------------|
+			 * |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
+			 * 0                     S32_MAX S32_MIN                    -1
+			 */
+			reg->s32_min_value = (s32)reg->u32_min_value;
+			reg->u32_max_value = min_t(u32, reg->u32_max_value, reg->s32_max_value);
+		} else if ((u32)reg->s32_max_value < reg->u32_min_value) {
+			/*
+			 * 0                                                   U32_MAX
+			 * |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
+			 * |----------------------------|----------------------------|
+			 * |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
+			 * 0                     S32_MAX S32_MIN                    -1
+			 */
+			reg->s32_max_value = (s32)reg->u32_max_value;
+			reg->u32_min_value = max_t(u32, reg->u32_min_value, reg->s32_min_value);
+		}
 	}
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index 0322f817d07b..446e5ef62f44 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -422,15 +422,65 @@ static bool is_valid_range(enum num_t t, struct range x)
 	}
 }
 
-static struct range range_improve(enum num_t t, struct range old, struct range new)
+static struct range range_intersection(enum num_t t, struct range old, struct range new)
 {
 	return range(t, max_t(t, old.a, new.a), min_t(t, old.b, new.b));
 }
 
+static struct range range_union(enum num_t t, struct range x, struct range y)
+{
+	if (!is_valid_range(t, x))
+		return y;
+	if (!is_valid_range(t, y))
+		return x;
+	return range(t, min_t(t, x.a, y.a), max_t(t, x.b, y.b));
+}
+
+/*
+ * This function attempts to improve x range intersecting it with y.
+ * range_cast(... to_t ...) looses precision for ranges that pass to_t
+ * min/max boundaries. To avoid such precision loses this function
+ * splits both x and y into halves corresponding to non-overflowing
+ * sub-ranges: [0, smin] and [smax, -1].
+ * Final result is computed as follows:
+ *
+ *   ((x ∩ [0, smax]) ∩ (y ∩ [0, smax])) ∪
+ *   ((x ∩ [smin,-1]) ∩ (y ∩ [smin,-1]))
+ *
+ * Precision might still be lost if final union is not a continuous range.
+ */
+static struct range range_refine_in_halves(enum num_t x_t, struct range x,
+					   enum num_t y_t, struct range y)
+{
+	struct range x_pos, x_neg, y_pos, y_neg, r_pos, r_neg;
+	u64 smax, smin, neg_one;
+
+	if (t_is_32(x_t)) {
+		smax = (u64)(u32)S32_MAX;
+		smin = (u64)(u32)S32_MIN;
+		neg_one = (u64)(u32)(s32)(-1);
+	} else {
+		smax = (u64)S64_MAX;
+		smin = (u64)S64_MIN;
+		neg_one = U64_MAX;
+	}
+	x_pos = range_intersection(x_t, x, range(x_t, 0, smax));
+	x_neg = range_intersection(x_t, x, range(x_t, smin, neg_one));
+	y_pos = range_intersection(y_t, y, range(x_t, 0, smax));
+	y_neg = range_intersection(y_t, y, range(y_t, smin, neg_one));
+	r_pos = range_intersection(x_t, x_pos, range_cast(y_t, x_t, y_pos));
+	r_neg = range_intersection(x_t, x_neg, range_cast(y_t, x_t, y_neg));
+	return range_union(x_t, r_pos, r_neg);
+
+}
+
 static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t, struct range y)
 {
 	struct range y_cast;
 
+	if (t_is_32(x_t) == t_is_32(y_t))
+		x = range_refine_in_halves(x_t, x, y_t, y);
+
 	y_cast = range_cast(y_t, x_t, y);
 
 	/* If we know that
@@ -444,7 +494,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 	 */
 	if (x_t == S64 && y_t == S32 && y_cast.a <= S32_MAX  && y_cast.b <= S32_MAX &&
 	    (s64)x.a >= S32_MIN && (s64)x.b <= S32_MAX)
-		return range_improve(x_t, x, y_cast);
+		return range_intersection(x_t, x, y_cast);
 
 	/* the case when new range knowledge, *y*, is a 32-bit subregister
 	 * range, while previous range knowledge, *x*, is a full register
@@ -462,7 +512,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 		x_swap = range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_cast.b));
 		if (!is_valid_range(x_t, x_swap))
 			return x;
-		return range_improve(x_t, x, x_swap);
+		return range_intersection(x_t, x, x_swap);
 	}
 
 	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t != y_t) {
@@ -480,7 +530,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 	}
 
 	/* otherwise, plain range cast and intersection works */
-	return range_improve(x_t, x, y_cast);
+	return range_intersection(x_t, x, y_cast);
 }
 
 /* =======================
-- 
2.51.1

