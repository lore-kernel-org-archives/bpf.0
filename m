Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1B3E3DA9
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740123; cv=none; b=DtUFH4gyzpAeRwMVeXlo6OfIA93WUgdjOIjvc6nkZA0spU5piHf5qmw9f9cLJfgs4CF/X26wKjfFyxGNH3K+KeAt2dFdWTM1B524i8P5D/uQqtEAyNG3sfSU4gWvhTvsAOd90vKlvSMapnpu+JFz/jeATSF/tYKHd7BjXWH44Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740123; c=relaxed/simple;
	bh=ySJE/bZJp8KcbGZTGKjqzaj13ue4s1/V1IzxD4OPfck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CP0p+KDR5eFHGG8neYc+HWiEFDQzWubKLsWVYtutxytpYk5P/uDsUZhcLvSOSqpYowk7w+aKrnvA7JhgPndkWnxy92GF9CxE9Thbuz73lZG+CcrGMyU0OnT28kXUdE5Mgl5y8W5VtPpa26g6cSLw+u88j7TDo4jW2jclD4S9R+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us02w2fD; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us02w2fD"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5069b3e0c66so126535441cf.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 11:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772740121; x=1773344921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+zaernbo7eHBJkCm0H52kpFhMOG1Qtt42MRsrXtWdc=;
        b=Us02w2fD7gXP1Ik3pI3/pWIqSz2vws52Zz1R0zmcqVxqku/4AOrv+nCjcy3NdmVnig
         LBPQdAh5aasRQFtYUAmkShrZCVe80Q4bfIQOltTIWNPBWJGRFNlzdYH7k6iqoDqjKzDF
         KV3yBUActVgJyuw0plzXwBufVavICBf+gXqdQiNqXoapsJ15w7mVc1J5cJoGB4FyWPSg
         kHx3NvKGKhcB8CxQehHscweOMDz92cfZFTxrzAu94zD1JswAz3XJExiR+4+v83GZKULI
         s1JQxqMhaJHlqYa9N4ymocVvMMmfShPHWRQQNBYb50hX1JhaGQPQN7wWk3oSnSB+y/dp
         z7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740121; x=1773344921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3+zaernbo7eHBJkCm0H52kpFhMOG1Qtt42MRsrXtWdc=;
        b=aeAkovyWa++MsvVgFsg+K+M0419JsV96tBY0FR//q5U+QAHsK39JDDnM5F9CzYkgY6
         E3FmhUJ1rLpVaxhqpoRtRI5MkeDgXDs0UhU7VwyErP1xqm+P1P9CZBzMG4T0oeRj87MU
         41L8P+MqdYDGmg11noAJwk5Mlc+Oh8eDDMctleU3TBivGl+oqanjz1HKJHW+1hGAbiVv
         x8I3hAu3rdP3VIBOjVKCLmVLSq5S8yGl/Zl+c+gta9W1AQzY6Pdi5QCSpzGwLlN6tdmE
         ChCj30kP6/TVKmaPjx/+jNjdwKelwxerzD/vDD02hJfoFMkw+IkFVzp/4jgXGi+zmeBY
         Cylw==
X-Gm-Message-State: AOJu0Ywd5vUvRMux4a5UCUeD+0J4LzWFZ7dyV/O/zpBbF9KLGDRLIZv1
	vI8a6zUdJ6LuY/r+0OtvAK+ioXy61cLf+1E9vQbp9W0VLlAApwKGaFcw7DXJmA==
X-Gm-Gg: ATEYQzw/9VrAh+qPGunds58oHavJqkYYokKZRIWh5dyfeEf24zW5xDcw+BQ81DsxzUB
	dzemzsAD7f8Z17xRYaf+PS8FVBnWEUEoBrchhWNguWymj71L60PnX3gKNne/2Zl32GudD38/qXq
	MhWohAA0qk0rckhXZbTMcY6OkloEzHZgEXp6XLURL/rbOZTnhAtVFGUlwRcP15ZW139/pL/s5KR
	WNcRWq0bBG9IzffS5CuuF18SUDvQ5EYhBj6Yp/0+UZS82POXeTKVJpDd8nqwhAKJ00MsUL17mo/
	lETYY/0nncpGHG9J+v+W94ehsRQFlukeQsJZIA+beTuKgbTHoZMdvntq7PJnMG/H2ILJemvCEaT
	GTwjTOmLg9JSrIzSYDYvObUX6Y7d4CbBWEM1pQkzZN8Nik78eqTHG1YEPu7ShvAnC8BafTBf2Qt
	uGuSmjYOVMGUCXb15ElzHSt3o73VytuG8Xmu4Uhbaqa9mf1L9ljoP+ZAH/s81iz4vVYs4=
X-Received: by 2002:ac8:584a:0:b0:4e7:4a3:ae88 with SMTP id d75a77b69052e-508e6810a4dmr46178061cf.7.1772740121085;
        Thu, 05 Mar 2026 11:48:41 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449874b7sm178755661cf.9.2026.03.05.11.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:48:40 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	arighi@nvidia.com,
	shung-hsi.yu@suse.com
Subject: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross min/max boundary
Date: Thu,  5 Mar 2026 11:48:22 -0800
Message-ID: <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
in __reg32_deduce_bounds() in the following situations:

- s32 range crosses U32_MAX/0 boundary, positive part of the s32 range
  overlaps with u32 range:

  0                                                   U32_MAX
  |  [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]              |
  |----------------------------|----------------------------|
  |xxxxx s32 range xxxxxxxxx]                       [xxxxxxx|
  0                     S32_MAX S32_MIN                    -1

- s32 range crosses U32_MAX/0 boundary, negative part of the s32 range
  overlaps with u32 range:

  0                                                   U32_MAX
  |              [xxxxxxxxxxxxxx u32 range xxxxxxxxxxxxxx]  |
  |----------------------------|----------------------------|
  |xxxxxxxxx]                       [xxxxxxxxxxxx s32 range |
  0                     S32_MAX S32_MIN                    -1

- No refinement if ranges overlap in two intervals.

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
 kernel/bpf/verifier.c                              | 24 +++++++++
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 62 ++++++++++++++++++++--
 2 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 401d6c4960eccfa90893660b7d8aece859787f7f..f960b382fdb3d4a4f5f2a66a525c2f594de529ff 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2511,6 +2511,30 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
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
index 0322f817d07be5d003c17dd7cedfa3aa4197678e..04938d0d431b38e086b50fe28b99e4ad2682742e 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -422,15 +422,69 @@ static bool is_valid_range(enum num_t t, struct range x)
 	}
 }
 
-static struct range range_improve(enum num_t t, struct range old, struct range new)
+static struct range range_intersection(enum num_t t, struct range old, struct range new)
 {
 	return range(t, max_t(t, old.a, new.a), min_t(t, old.b, new.b));
 }
 
+/*
+ * Result is precise when 'x' and 'y' overlap or form a continuous range,
+ * result is an over-approximation if 'x' and 'y' do not overlap.
+ */
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
@@ -444,7 +498,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 	 */
 	if (x_t == S64 && y_t == S32 && y_cast.a <= S32_MAX  && y_cast.b <= S32_MAX &&
 	    (s64)x.a >= S32_MIN && (s64)x.b <= S32_MAX)
-		return range_improve(x_t, x, y_cast);
+		return range_intersection(x_t, x, y_cast);
 
 	/* the case when new range knowledge, *y*, is a 32-bit subregister
 	 * range, while previous range knowledge, *x*, is a full register
@@ -462,7 +516,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 		x_swap = range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_cast.b));
 		if (!is_valid_range(x_t, x_swap))
 			return x;
-		return range_improve(x_t, x, x_swap);
+		return range_intersection(x_t, x, x_swap);
 	}
 
 	if (!t_is_32(x_t) && !t_is_32(y_t) && x_t != y_t) {
@@ -480,7 +534,7 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 	}
 
 	/* otherwise, plain range cast and intersection works */
-	return range_improve(x_t, x, y_cast);
+	return range_intersection(x_t, x, y_cast);
 }
 
 /* =======================

-- 
2.53.0
