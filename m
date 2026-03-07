Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169E296BA8
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844887; cv=none; b=R4J3Mtv0n1t29sch6shgSM7C8t0JWZEZGl+qQKIlAySZqGuXmplAUB0xsFnSWltNYoGpb4+auv/YY5ME0249sYwc/L5+PRqNqJvNITmNXl7b6VIK7JfGXwGi3fFmGl0GHhxmNeDDJY/SlUo12jFtByLvKtKEQH+S9IJnnm7KRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844887; c=relaxed/simple;
	bh=E+XTzsJgqQYKaUFTNL5x0UhTWBbeZ83GPEpw4xpBYRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NH1dkB7Mk8T6a+2z2/OvUuT4hc36c7zgPxERa1zAP29MW9rT9dkWsxxva+6nQ596sdMUJFYCXSF7xfosPhJszHmGVBsCJ96jKVUBpnP9EnFFKahenHmCUw4IZxPDp9AxRt0OtiD0uNbwOIYa6uZjmV6ihYdg3Mrlgtvm890yGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKHkbaAf; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKHkbaAf"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3520487eec.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772844885; x=1773449685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyhWKtA9X+WNe+363k4FQ7Vw8VWDNUmxZU0ZE43Rvno=;
        b=eKHkbaAfvaC0lKDhFSgtsGASLtdCdcWlHlM5q2sbX2ExyJH+0QAhtrkh1G26CS8ETS
         grhmBcWOsH4LuBg6IM2DKOm6FYJj9QsGjv2A8NrlvJIsh+UaFb1IUAPfvmM5Wheg1XnQ
         i/G0y8z7XYnntIpu+mNwBzRBB9nwEaP6xY3bv3twBsEJhVxLeq9wBWmeHwaiIvDrBgAb
         2BTMHvmI7pCSoR8A91eE9R+JM2T2W43dLM0DhZ5uWHRFzW/Kkq+RWpQnzVXOOkF+wb8j
         +ZeVE22aCdzLw+hPWor5bPc33/aM8rl4E0t9er20fj95eebIT5rsTSjfXY6XGFMl++Ub
         CC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772844885; x=1773449685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyhWKtA9X+WNe+363k4FQ7Vw8VWDNUmxZU0ZE43Rvno=;
        b=c8h9eFLDJtf8iJP4otQyHTwH284TUVJMbYqlt733jzR2iEKWJvWV9SieEsNzXWMWQl
         acUPvt1N1CP47BvAg5PePJAciWOfSYcxTs+zeFDTHQrTtjv5svsDwlK7ExRpkHgbHbO4
         1uSFiTQgoOelp+TTwrjJPSQQnnLDluM8EWDTStEGEitxFRmUoplheQrTKhmZ56+d2UUR
         1BffILXxyl9aAuVNHrJxOBg8c+3s1NHZPpRHbD/dWPoDDnUIHJqmHt1a+5gnvuj9aU/d
         MwWJMunCvWe/AP02FebIbTiQmu1cDgal/3/WOpeZ4I1qIG9JuNWO3Q5XbzpQXH8fqyB7
         j/CA==
X-Gm-Message-State: AOJu0YyHTzzqlI+1XqvPVZEHyQM/71PoVN/+/0nUYyQEEnc2v9nSWlim
	IBkOqWrIgqPichy49v4D4ingZMK12l2kYEe6axHQnNcATCcoXUllIbQw/Yr3zxmc
X-Gm-Gg: ATEYQzxcuM5lYIhqDfSCPQrqvGD5XQTX5ky4aB1z8gmRCSyrWYgrKV+KiSaksqrb/B6
	BdFFuOq4shPCjumaemgKYavGVRVYO9yraGxPvG7PhiDhbAc6negbuJ3zcZU3GLcuKEXZxCZvcFY
	/tswGf3S8Ug/Et+FETEKrQOz6ujNjPcJHWVIhXxwsYbBxOiwMQMceRqD83zgmygNTs2KWI3fEZf
	ZgjJJ+vPLfZvehdUxdIePWvajo3dzHgR7JUN0mtavJJxoGT6eIC9Xy3A30Y3JBhLF8MRDV4EKo2
	3bl94droTVea7oQF4JT1KuSnEB3E13JKWGGrxVhkGhizFSAxcU2N2eP9wu1OIAWO7hMMmapURz+
	jwNmLOV/I3gHKTItFMoh5TaKLABMuss4pSxOpE0oNhj8h74+/gyxGkE7FxiuyC+CQoGr74Kn9UF
	ixjOgR39TQG9LqSF6EBhLeYnqX27yD6eN8ouGO+SkU2jiSzOCFn1/+cbXsdPPQ4yADr30Uyk9fk
	DFfG+4=
X-Received: by 2002:a05:7301:1008:b0:2ba:7b0b:e205 with SMTP id 5a478bee46e88-2be4e03b3d5mr1516766eec.20.1772844884842;
        Fri, 06 Mar 2026 16:54:44 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f62d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948390sm2235110eec.22.2026.03.06.16.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:54:44 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	emil@etsalapatis.com,
	Andrea Righi <arighi@nvidia.com>
Subject: [PATCH bpf v3 1/3] bpf: refine u32/s32 bounds when ranges cross min/max boundary
Date: Fri,  6 Mar 2026 16:54:24 -0800
Message-ID: <20260306-bpf-32-bit-range-overflow-v3-1-f7f67e060a6b@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
References: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
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
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
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
