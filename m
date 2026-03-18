Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CCF3EF0C5
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773851374; cv=none; b=K+q3i1pFcNezqa5Nx0bx993rX9Mp5M0uAc8LwxY2Gi7RHYWAgxhPuKNhi/nmNWRZj7Xx9IqxRRnFrINGLxgqFys2F9bI+zzL/I84TMVGhwOMvFNzyXuuUmDYxpO4rjw9/o7TCPJK3UT1PrfakcR4eYVoVPMLz4LbFncLF9S8JAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773851374; c=relaxed/simple;
	bh=nBmq5DL/fX/QByUiNo9Ec6n7l1BgaPgv6zV0X/5hupE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkhNWhhD/MOQrCBzjQHV+Vq1pHoWTWJzpiwWGVChtEzQ1nMW+WqM3Kxd2XmzsZlH6Fk5o7nA3z6IZlH1xys76F5JyRfca4fVduyfyKh/3iP+k2TAmrCM99BU8UQYnYcJ/TyYt+B98F4EmREG7NoEdsJOgBv2TGwtgK5SNe5GQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPPcCdNK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPPcCdNK"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35bb7afdc38so119034a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773851365; x=1774456165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8va4vNLgDOCIY8d64fq/drHmdO6UoUNpDG+ZxFL4Po=;
        b=GPPcCdNKq/RHlKg+I6oz0rt0l+ii7QWM8A2+gb0LCKEc6BnkGjCjFJzANodL9xiC4b
         6oQyMTDg5+QiQTAR0U6mQW57FBd0y5vcAZpP78VeuRWM3zJv4ZpqxyFUsJx7VWpI7Bo8
         y5erCAimkYNLUx0ljvN4hvCzihQQvArxqzoHzc/kWanQHWm+GmqPRV4BEArgCpjTCYsE
         P/r+dZrh6WKmSwdXtlUScGPfmWqV4Nnx/Bcr/A2dQbEodisTMeu0dI8sVhhL4m8jCYZz
         T2pHhlr9+DvJP6ylyCVQ1B5PP3lFPcjD13Ve9ZesjdSqYlBZwUHTQDLC+MIRk4rcnT/x
         wIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773851365; x=1774456165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8va4vNLgDOCIY8d64fq/drHmdO6UoUNpDG+ZxFL4Po=;
        b=Vn9sQXST1Fc3fLuDMhsyWn3vKoKvQ7A6TecBhvh61cyMbbo1cYkrSAKsIelMb6RgTZ
         8we0axJIreFM7GRyDc35HViAMQhvb8Qx16J4CcDb+4p28MPooqkqAlI2t+LZkip2mX7n
         4xSPqSq7qd8BipEhE/nHHfxSjIyaiCDXjffsQjzHYThgD/XbfU1Jrcr6FjOC2HiALADF
         MqJb+IttQwGJ7yavZsI8nJx1ofEP93Jpni6p/jMtAVhS699r+fLlRdCPpzjywjz8QVr9
         2AgMFxdFZAgvlNmbJ2PIbgNgsWM49e1drJh4L99xCzwPK0lCoB8y1GFuiipZgGlqkdBn
         AuOA==
X-Gm-Message-State: AOJu0Yyj4TunYbEIUu6PPoZWBEgIOcgKn5/Li+iy0jjLM3l2dImv0qg6
	zTX8T7uwYHDrMu9HSni9BBluipFtqSYe3gd2W5c7/qgYdShTZ6TZFT7zIMnnXg==
X-Gm-Gg: ATEYQzwR39fDpoCLlbZLnRSeswoEzT/iIvAZMe7TGx4+//6kAzAY3o09MSProQeW8ov
	JdnQjZJU2kRHSb5jhCFjiuDYp8MO4T8wZEO4bzk5fujjcyrU3Z2qE0+Y4VQv/UeHxRPE2Fb9cJy
	98P3sUp4+RacWFJw6dR9Ha9/CfaSozsVC8TrZ0z7uQ/aPlZsYCnfSfONGfiH7JMt5y/qG24YjqI
	d96BXULLLDJeKfcCv9R5bAo7svVPxM1s7/pMOCYSi75M9ya1PG10EeClDkhIVeqX4jt5td1Lpbv
	dcl/qo58RePaG4PbV4iHPsi9/6kmblIgZvMUcaq+msGQJsYc6HNnDAklJ/HsYAy2ZkVRVYHvDtd
	hgKF8iNZJotgGRKgwZQlqjpLcnqTtB/JuK+lXEdXVjdfUXTD9cIuik0Q33leehLVbNUfHPW7DIC
	jAudmKceS9bX9JTjKamIZV7IN9qH6mBZdmTWlyKz0BoE3xHIAW
X-Received: by 2002:a17:90b:3d86:b0:35b:a7be:ae6e with SMTP id 98e67ed59e1d1-35bb9f46b32mr3386187a91.33.1773851365309;
        Wed, 18 Mar 2026 09:29:25 -0700 (PDT)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc610c1efsm89370a91.14.2026.03.18.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:29:24 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next v1 3/4] bpf: cnum 32->64 deductions in reg_bounds_sync
Date: Wed, 18 Mar 2026 09:29:00 -0700
Message-ID: <20260318-cnum-sync-bounds-v1-3-1f2e455ea711@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Replace deduce_bounds_64_from_32() with cnum64_cnum32_intersect()
based implementation. Assume:
- a is a 64-bit range
- b is a 32-bit range
- t is a refined 64-bit range, such that ∀ v ∈ a, (u32)a ∈ b: v ∈ t.

New deduce_bounds_64_from_32() makes the following deductions:

(A): 'b' is a sub-range of the first or the last 32-bit
     sub-range of 'a':

                                                         64-bit number axis --->

 N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
 ||------|---|=====|-------||----------|=====|-------||----------|=====|----|--||
         |   |< b >|                   |< b >|                   |< b >|    |
         |   |                                                         |    |
         |<--+--------------------------- a ---------------------------+--->|
             |                                                         |
             |<-------------------------- t -------------------------->|

(B) 'b' does not intersect with the first of the last 32-bit
    sub-range of 'a':

N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
||--|=====|----|----------||--|=====|---------------||--|=====|------------|--||
    |< b >|    |              |< b >|                   |< b >|            |
               |              |                               |            |
               |<-------------+--------- a -------------------|----------->|
                              |                               |
                              |<-------- t ------------------>|

(C) 'b' crosses 0/U32_MAX boundary:

N*2^32                   (N+1)*2^32                (N+2)*2^32                (N+3)*2^32
||===|---------|------|===||===|----------------|===||===|---------|------|===||
 |b >|         |      |< b||b >|                |< b||b >|         |      |< b|
               |      |                                  |         |
               |<-----+----------------- a --------------+-------->|
                      |                                  |
                      |<---------------- t ------------->|

Current implementation of deduce_bounds_64_from_32() only handles
case (A).

reg_bounds.c is updated with similar logic to keep selftests passing.
Instead of using cnums it inspects intersection between 'b' and
first / last / next-after-first / previous-before-last sub-ranges
of 'a'.

The reg_bounds.c:range64_range32_intersect() function is verified
using cbmc model checker, see [1].

[1] https://github.com/eddyz87/cnum-verif

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c                              | 76 ++++----------------
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 82 ++++++++++++++--------
 2 files changed, 65 insertions(+), 93 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 45ee8711c50c5ef19d7a24333e55abcded93a8fb..745aef7d5467f92b0499b480987ef9daf940d52f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2521,69 +2521,19 @@ static void deduce_bounds_64_from_64(struct bpf_reg_state *reg)
 
 static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 {
-	/* Try to tighten 64-bit bounds from 32-bit knowledge, using 32-bit
-	 * values on both sides of 64-bit range in hope to have tighter range.
-	 * E.g., if r1 is [0x1'00000000, 0x3'80000000], and we learn from
-	 * 32-bit signed > 0 operation that s32 bounds are now [1; 0x7fffffff].
-	 * With this, we can substitute 1 as low 32-bits of _low_ 64-bit bound
-	 * (0x100000000 -> 0x100000001) and 0x7fffffff as low 32-bits of
-	 * _high_ 64-bit bound (0x380000000 -> 0x37fffffff) and arrive at a
-	 * better overall bounds for r1 as [0x1'000000001; 0x3'7fffffff].
-	 * We just need to make sure that derived bounds we are intersecting
-	 * with are well-formed ranges in respective s64 or u64 domain, just
-	 * like we do with similar kinds of 32-to-64 or 64-to-32 adjustments.
-	 */
-	__u64 new_umin, new_umax;
-	__s64 new_smin, new_smax;
-
-	/* u32 -> u64 tightening, it's always well-formed */
-	new_umin = (reg->umin_value & ~0xffffffffULL) | reg->u32_min_value;
-	new_umax = (reg->umax_value & ~0xffffffffULL) | reg->u32_max_value;
-	reg->umin_value = max_t(u64, reg->umin_value, new_umin);
-	reg->umax_value = min_t(u64, reg->umax_value, new_umax);
-	/* u32 -> s64 tightening, u32 range embedded into s64 preserves range validity */
-	new_smin = (reg->smin_value & ~0xffffffffULL) | reg->u32_min_value;
-	new_smax = (reg->smax_value & ~0xffffffffULL) | reg->u32_max_value;
-	reg->smin_value = max_t(s64, reg->smin_value, new_smin);
-	reg->smax_value = min_t(s64, reg->smax_value, new_smax);
-
-	/* Here we would like to handle a special case after sign extending load,
-	 * when upper bits for a 64-bit range are all 1s or all 0s.
-	 *
-	 * Upper bits are all 1s when register is in a range:
-	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
-	 * Upper bits are all 0s when register is in a range:
-	 *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
-	 * Together this forms are continuous range:
-	 *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
-	 *
-	 * Now, suppose that register range is in fact tighter:
-	 *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
-	 * Also suppose that it's 32-bit range is positive,
-	 * meaning that lower 32-bits of the full 64-bit register
-	 * are in the range:
-	 *   [0x0000_0000, 0x7fff_ffff] (W)
-	 *
-	 * If this happens, then any value in a range:
-	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
-	 * is smaller than a lowest bound of the range (R):
-	 *   0xffff_ffff_8000_0000
-	 * which means that upper bits of the full 64-bit register
-	 * can't be all 1s, when lower bits are in range (W).
-	 *
-	 * Note that:
-	 *  - 0xffff_ffff_8000_0000 == (s64)S32_MIN
-	 *  - 0x0000_0000_7fff_ffff == (s64)S32_MAX
-	 * These relations are used in the conditions below.
-	 */
-	if (reg->s32_min_value >= 0 && reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) {
-		reg->smin_value = reg->s32_min_value;
-		reg->smax_value = reg->s32_max_value;
-		reg->umin_value = reg->s32_min_value;
-		reg->umax_value = reg->s32_max_value;
-		reg->var_off = tnum_intersect(reg->var_off,
-					      tnum_range(reg->smin_value, reg->smax_value));
-	}
+	struct cnum32 s = cnum32_from_sreg(reg);
+	struct cnum32 u = cnum32_from_ureg(reg);
+	struct cnum64 t;
+
+	t = cnum64_from_ureg(reg);
+	if (cnum64_cnum32_intersect(t, s, &t) &&
+	    cnum64_cnum32_intersect(t, u, &t))
+		cnum_update_reg64_bounds(reg, t);
+
+	t = cnum64_from_sreg(reg);
+	if (cnum64_cnum32_intersect(t, s, &t) &&
+	    cnum64_cnum32_intersect(t, u, &t))
+		cnum_update_reg64_bounds(reg, t);
 }
 
 static void __reg_deduce_bounds(struct bpf_reg_state *reg)
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index cb8dd2f63296b826491c8a010f4ece4aa20c0560..b6f46608d5f18a60238898b406bdfb51aa0dd404 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -478,6 +478,52 @@ static struct range range_refine_in_halves(enum num_t x_t, struct range x,
 
 }
 
+static __always_inline u64 next_u32_block(u64 x) { return x + (1ULL << 32); }
+static __always_inline u64 prev_u32_block(u64 x) { return x - (1ULL << 32); }
+
+/* Is v within the circular u64 range [base, base + len]? */
+static __always_inline bool u64_range_contains(u64 v, u64 base, u64 len)
+{
+	return v - base <= len;
+}
+
+/* Is v within the circular u32 range [base, base + len]? */
+static __always_inline bool u32_range_contains(u32 v, u32 base, u32 len)
+{
+	return v - base <= len;
+}
+
+static bool range64_range32_intersect(enum num_t a_t,
+				      struct range a /* 64 */,
+				      struct range b /* 32 */,
+				      struct range *out /* 64 */)
+{
+	u64 b_len = (u32)(b.b - b.a);
+	u64 a_len = a.b - a.a;
+	u64 lo, hi;
+
+	if (u32_range_contains((u32)a.a, (u32)b.a, b_len)) {
+		lo = a.a;
+	} else {
+		lo = swap_low32(a.a, (u32)b.a);
+		if (!u64_range_contains(lo, a.a, a_len))
+			lo = next_u32_block(lo);
+		if (!u64_range_contains(lo, a.a, a_len))
+			return false;
+	}
+	if (u32_range_contains(a.b, (u32)b.a, b_len)) {
+		hi = a.b;
+	} else {
+		hi = swap_low32(a.b, (u32)b.b);
+		if (!u64_range_contains(hi, a.a, a_len))
+			hi = prev_u32_block(hi);
+		if (!u64_range_contains(hi, a.a, a_len))
+			return false;
+	}
+	*out = range(a_t, lo, hi);
+	return true;
+}
+
 static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t, struct range y)
 {
 	struct range y_cast;
@@ -485,40 +531,16 @@ static struct range range_refine(enum num_t x_t, struct range x, enum num_t y_t,
 	if (t_is_32(x_t) == t_is_32(y_t))
 		x = range_refine_in_halves(x_t, x, y_t, y);
 
-	y_cast = range_cast(y_t, x_t, y);
-
-	/* If we know that
-	 *   - *x* is in the range of signed 32bit value, and
-	 *   - *y_cast* range is 32-bit signed non-negative
-	 * then *x* range can be improved with *y_cast* such that *x* range
-	 * is 32-bit signed non-negative. Otherwise, if the new range for *x*
-	 * allows upper 32-bit * 0xffffffff then the eventual new range for
-	 * *x* will be out of signed 32-bit range which violates the origin
-	 * *x* range.
-	 */
-	if (x_t == S64 && y_t == S32 && y_cast.a <= S32_MAX  && y_cast.b <= S32_MAX &&
-	    (s64)x.a >= S32_MIN && (s64)x.b <= S32_MAX)
-		return range_intersection(x_t, x, y_cast);
-
-	/* the case when new range knowledge, *y*, is a 32-bit subregister
-	 * range, while previous range knowledge, *x*, is a full register
-	 * 64-bit range, needs special treatment to take into account upper 32
-	 * bits of full register range
-	 */
 	if (t_is_32(y_t) && !t_is_32(x_t)) {
-		struct range x_swap;
+		struct range x1;
 
-		/* some combinations of upper 32 bits and sign bit can lead to
-		 * invalid ranges, in such cases it's easier to detect them
-		 * after cast/swap than try to enumerate all the conditions
-		 * under which transformation and knowledge transfer is valid
-		 */
-		x_swap = range(x_t, swap_low32(x.a, y_cast.a), swap_low32(x.b, y_cast.b));
-		if (!is_valid_range(x_t, x_swap))
-			return x;
-		return range_intersection(x_t, x, x_swap);
+		if (range64_range32_intersect(x_t, x, y, &x1))
+			return x1;
+		return x;
 	}
 
+	y_cast = range_cast(y_t, x_t, y);
+
 	/* otherwise, plain range cast and intersection works */
 	return range_intersection(x_t, x, y_cast);
 }

-- 
2.51.1
