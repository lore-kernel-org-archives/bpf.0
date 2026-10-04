Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7309435EE9
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121132; cv=none; b=G744uGUmOPSubQ5mhcHurgkJ/eck+fzaDQZjwHqOSG9+abtRuPYOodzWAeSrh+ISAE6zSRminZPYGFOFMMbjvylV0BffQHILQ+MrdV0135Zlu82haDMPCHSmnd50p7Rxs4D49w6MuXOAI9LfPwrO4m71kGZIZBzPWduHiE9kMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121132; c=relaxed/simple;
	bh=WAaUUoFX8C1dzHMvzU32OdOL/UU5RlMiZEyFO+K3IYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9NBN0cpYUOzeHZfJ2r0gc8y1s3n+q6XhTOhNJpNW+tpeL6eDZ7hwabzVavyo4OfoovUu54jGsjuULGE+l1HDYJ+5FagyNaokIRJqdXLtCHJ+01KpldY2v7O3Sq9+xqDCiqwgYMjeDa6oUPaG1qEPB1mwWnysgMVG6rs0JScWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4ZWf9zQ; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4ZWf9zQ"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4c3304784so294201a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121130; x=1791725930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0BJSb57Uses8ogFF7iXJEZQeJF/eI+nTz1gyI/NKl7k=;
        b=Z4ZWf9zQFfCSeAwJj0xTmFAhcJO+jzOAeVzHKZSIwFqsn4vh9o2M+h0txUSZOBcZA8
         m6g5zl0vfvZgtzBxjEw0sGTJGCylViFNPX54AIcEImKyGLoV1GOWtUR6S04YjBkZiVTZ
         oS4biV7pGSZ5HPVtFZM/CaXMyRRIX4jlw3Kc6WngGWl6WP6dCKEVh/HJ3rBHebFr/F3u
         i6oaT1xC9AtpBg+qCkehCDWFsGQi3sraMZEIx/F0/zlqBajMnUXWK/MDsAO4tGZZYnZA
         sNDbRZe2WgvQqn+e541d9y/w1HOkqs+n/cXmkzQVCYXm7ogVLa8bhcfarqjtjeFHtdAs
         hEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121130; x=1791725930;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BJSb57Uses8ogFF7iXJEZQeJF/eI+nTz1gyI/NKl7k=;
        b=fdkhi0QdYEK9Yrda6kzyIz1S4WA9On/MkMrrXaQ6+Qh9/n6cGblHacPHBS73Wyn+Gm
         Puo9EtfqMiTEHK6XzlVbKNPJUpAchBAFqgei/E2qJhVs3gYsOEfefzYf/3xWhV0lOV9X
         o5XngqkihM6oKVvmrkSYY4j5LT99rB/aeu6ev2Q6rk6YBRShj3L/jWru32tM1SXqVbYt
         36K1GsdIuNFO2Jf9KcAwWv9ahBRYGVEHblmKEQ2mmtBL4Z1aSHL2P+g6pAHWA+LR9w3B
         G9eujXDkUzjNjcM0IB9QAlP+ijvJE5wM9KtOLtrIbr3HWMKfEccckfZqmpCcVBCl0vTP
         seIQ==
X-Gm-Message-State: AFuF++ncG1/CcI0JZizjtRVAbHmLH6tVx1DHS/05KpFGMnSDhdO2s63p
	yf8VP0K8A3q5WVbdHpiTnPVZEt/p80WKls0Fcmzdba+aFAXJg5kAlXxbA2kDxg==
X-Gm-Gg: AYBFou0ahBsQkHMO9v5dYcK3rzbesHOPGXMQXp04sirB2Laqnx8vHWJYXO0vfclmjOc
	OfHmJbquJGemsQzYi0VYdSxQpZ4m5CwspI2OsaxxzEOviLeSrALzXrhHs4t29ih8D7czBInz6Pa
	em2hGZWJA9lQ34OM0cLObXoXSg834JFDACbdQln/YSeb4mup3dI+hdBTAq1QE+Qxe2Oxs36q1So
	Zw16lyrc2y8b1qrSaxYxzDtN8olIlrjJD208nwTPT84Q1/QcWQKKf0fnizf7xWszB9eNJnNG/I5
	hyu4H/KBFno34ke6ZpnGM3bqqVkCMe6TBrClxhx4J+98l5mnDhX/oUhBKKurnOUXK/dAb1mAA2v
	cXb2cdnC844ZCPPvaZHyzeadu3GMMh4cYUtVMpFw30xh3HbigdxSrGvPpDn3JWhXdpdgglEVNoR
	EAZTQPC9zQOyk6OG7yrdv3bFFHNyxymKZFtpAVrUlFlyC/6ByWLrW457IWDbSWP4R0Lf21rEpX5
	cq/FMkrzBMsP8qRUOhr4AxNGA==
X-Received: by 2002:a05:6a21:820d:b0:3dd:a006:7b3a with SMTP id adf61e73a8af0-3e0bd3f551bmr7925217637.57.1791121129976;
        Sun, 04 Oct 2026 06:38:49 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 14/43] bpf: representation for intervals with steps
Date: Sun,  4 Oct 2026 06:37:56 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-14-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Extend scalar register tracking with a linear "base + step * k" description:
each scalar carries two u16 fields, base and step (invariant: base < step),
recording that its value is some point on the line base + step * k.
A fresh scalar starts as base=0, step=1, i.e. any integer.

This lets the verifier reason about strided values, e.g. an index multiplied
by an element size, which neither the min/max bounds nor the tnum can capture
for a non-power-of-2 stride. Such reasoning is necessary to allow
array access with a variable offset through PTR_TO_BTF_ID, e.g.
for expressions like p->arr[i].field.

reg_bounds_sync() uses the description in two ways:
- deduce_bounds_64_from_step() intersects the 64-bit range with the line via
  cnum64_intersect_linear(), snapping smin/smax to actual points on it;
- __reg_bound_offset() clears the low bits of var_off implied by the number
  of trailing zeros shared by base and step.

range_within() is extended to check whether the cur register's equation
describes a subset of the points described by the old register's equation.

Scalar ALU operations update base/step as follows:
- ADD of a constant (including pointer + scalar): keep step, shift base;
- MUL by a constant: scale step and base by the constant;
- LSH by a constant: scale step and base by the corresponding power of two;
- All other operations reset to base=0, step=1.

Branch (eq/neq) checks do not take into account base/step yet.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   7 ++
 kernel/bpf/log.c             |   2 +
 kernel/bpf/states.c          |  26 ++++++-
 kernel/bpf/verifier.c        | 182 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 213 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4371fb3405ac..05914fcbe77c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -178,6 +178,13 @@ struct bpf_reg_state {
 	 * during state comparisons.
 	 */
 	u32 map_uid;
+	/*
+	 * The value described by this register, interpreted as s64, lies on
+	 * a line described by a linear equation base + step * k.
+	 * Invariant: base < step.
+	 */
+	u16 base;
+	u16 step;
 	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
 	bool precise;
 };
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index d850a7863d2e..900d1bb1988b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -692,6 +692,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 			verbose_a("var_off=%s", tn_buf);
+			if (reg->base != 0 || reg->step != 1)
+				verbose_a("step=%d+%d", reg->base, reg->step);
 		}
 	}
 	verbose(env, ")");
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 345079cf64d3..981328f5eb60 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -302,8 +302,30 @@ int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_s
 static bool range_within(const struct bpf_reg_state *old,
 			 const struct bpf_reg_state *cur)
 {
-	return cnum64_is_subset(old->r64, cur->r64) &&
-	       cnum32_is_subset(old->r32, cur->r32);
+	if (!cnum64_is_subset(old->r64, cur->r64) ||
+	    !cnum32_is_subset(old->r32, cur->r32))
+		return false;
+
+	if (old->step <= 1)
+		return true;
+
+	if (cnum64_is_const(cur->r64))
+		return imod((s64)cnum64_smin(cur->r64), old->step) == old->base;
+
+	/*
+	 * Both `old` and `cur` define some sets of points.
+	 * Return true, if points defined by `cur` are a subset of points defined by `old`:
+	 * - bounds for `cur` should be within bounds for `old`;
+	 * - cur->step should be dividable by old->step;
+	 * - cur->base should start at integer number of old->step
+	 *   steps from old->base.
+	 *
+	 * E.g. the following ranges are compatible:
+	 * - old [0, 10] step 2
+	 * - new [2, 10] step 4
+	 */
+	return cur->step % old->step == 0 &&
+	       (cur->base - old->base) % old->step == 0;
 }
 
 /* If in the old state two registers had the same id, then they need to have
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4dd71bf7c1d9..f71778a75f30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5,6 +5,7 @@
  */
 #include <uapi/linux/btf.h>
 #include <linux/bpf-cgroup.h>
+#include <linux/count_zeros.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/slab.h>
@@ -1910,12 +1911,128 @@ static void bpf_diag_record_caller_saved(struct bpf_verifier_env *env,
 	}
 }
 
+static void reg_step_reset(struct bpf_reg_state *reg)
+{
+	reg->base = 0;
+	reg->step = 1;
+}
+
+static void scalar_step_add(struct bpf_reg_state *dst_reg,
+			    const struct bpf_reg_state *a,
+			    const struct bpf_reg_state *b)
+{
+	const struct bpf_reg_state *reg;
+	s64 amount, tmp;
+
+	if (tnum_is_const(b->var_off)) {
+		reg = a;
+		amount = (s64)b->var_off.value;
+	} else if (tnum_is_const(a->var_off)) {
+		reg = b;
+		amount = (s64)a->var_off.value;
+	} else {
+		reg_step_reset(dst_reg);
+		return;
+	}
+
+	/*
+	 * Let x be a possible signed value of the register,
+	 * d = amount, s = reg->step, and b = reg->base.
+	 * Then x mod s = b, with s > 0 and 0 <= b < s.
+	 * If the addition causes signed underflow, the resulting value
+	 * is x + d + 2**64.
+	 *
+	 * Taking the result modulo s and substituting x mod s = b gives:
+	 *   (x + d + 2**64) mod s = (b + d + (2**64 mod s)) mod s      (1)
+	 * Keeping reg->step = s and updating reg->base to (b + d) mod s
+	 * requires (1) to equal (b + d) mod s, which holds if and only
+	 * if 2**64 mod s = 0.
+	 * Signed overflow subtracts 2**64 and has the same requirement.
+	 *
+	 * Conservatively reset the stride if either wrap is possible.
+	 */
+	if (check_add_overflow(reg_smin(reg), amount, &tmp) ||
+	    check_add_overflow(reg_smax(reg), amount, &tmp)) {
+		reg_step_reset(dst_reg);
+		return;
+	}
+
+	dst_reg->base = (reg->base + imod(amount, reg->step)) % reg->step;
+	dst_reg->step = reg->step;
+}
+
+static void scalar_step_scale(struct bpf_reg_state *dst_reg, u64 amount)
+{
+	u16 step;
+	s64 tmp;
+
+	/*
+	 * Using the same notation as scalar_step_add(), with d > 0,
+	 * the scaled value satisfies (x * d) mod (s * d) = b * d.
+	 * If the multiplication wraps, its signed result can be represented
+	 * as x * d - n * 2**64 for some nonzero integer n.
+	 *
+	 * Taking the result modulo s * d gives:
+	 *   (x * d - n * 2**64) mod (s * d) =
+	 *   (b * d - (n * 2**64 mod (s * d))) mod (s * d)              (1)
+	 * Updating dst_reg->base to b * d and dst_reg->step to s * d
+	 * requires (1) to equal b * d, which holds if and only if
+	 * n * 2**64 mod (s * d) = 0.
+	 *
+	 * Conservatively reset the stride if a wrap is possible.
+	 */
+	if (amount == 0 || check_mul_overflow(dst_reg->step, amount, &step) ||
+	    check_mul_overflow(reg_smin(dst_reg), (s64)amount, &tmp) ||
+	    check_mul_overflow(reg_smax(dst_reg), (s64)amount, &tmp)) {
+		reg_step_reset(dst_reg);
+		return;
+	}
+
+	dst_reg->base = (dst_reg->base * amount) % step;
+	dst_reg->step = step;
+}
+
+/*
+ * Let x be a possible signed value of the register,
+ * s = reg->step, and b = reg->base.
+ * Then x mod s = b, with s > 0 and 0 <= b < s.
+ * Truncating to N bits and then zero- or sign-extending x
+ * is equivalent to computing x + k * 2**N for some integer k.
+ * For example, sign-extending the low 8 bits of x = 255 can
+ * be expressed as 255 - 2**8 = -1.
+ *
+ * Taking the result modulo s and substituting x mod s = b gives:
+ *   (x + k * 2**N) mod s = (b + (k * 2**N mod s)) mod s
+ * Keeping reg->base = b and reg->step = s requires this to equal b,
+ * which holds if and only if k * 2**N mod s = 0.
+ * Continuing the example with s = 3 and b = 0, we have 255 mod 3 = 0,
+ * but (-1) mod 3 = 2, so the original base and step no longer hold.
+ *
+ * Conservatively reset the stride unless all possible values fit in
+ * the range where the conversion leaves them unchanged.
+ * Call before updating the register's bounds. Requires 0 < bits < 64.
+ */
+static void reg_step_check_unsigned(struct bpf_reg_state *reg, u32 bits)
+{
+	if (reg_umax(reg) >= (1ULL << bits))
+		reg_step_reset(reg);
+}
+
+static void reg_step_check_signed(struct bpf_reg_state *reg, u32 bits)
+{
+	s64 limit = 1LL << (bits - 1);
+
+	if (reg_smin(reg) < -limit || reg_smax(reg) >= limit)
+		reg_step_reset(reg);
+}
+
 /* This helper doesn't clear reg->id */
 static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
 	reg->var_off = tnum_const(imm);
 	reg->r64 = cnum64_from_urange(imm, imm);
 	reg->r32 = cnum32_from_urange((u32)imm, (u32)imm);
+	reg_step_reset(reg);
 }
 
 /* Mark the unknown part of a register (variable offset or scalar value) as
@@ -2158,10 +2275,16 @@ static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 	reg->r64 = cnum64_cnum32_intersect(reg->r64, reg->r32);
 }
 
+static void deduce_bounds_64_from_step(struct bpf_reg_state *reg)
+{
+	reg->r64 = cnum64_intersect_linear(reg->r64, reg->base, reg->step);
+}
+
 static void __reg_deduce_bounds(struct bpf_reg_state *reg)
 {
 	deduce_bounds_32_from_64(reg);
 	deduce_bounds_64_from_32(reg);
+	deduce_bounds_64_from_step(reg);
 }
 
 /* Attempts to improve var_off based on unsigned min/max information */
@@ -2173,8 +2296,18 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 	struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
 					       tnum_range(reg_u32_min(reg),
 							  reg_u32_max(reg)));
+	u32 trailing_zero_bits;
+	u16 base = reg->base;
+	u16 step = reg->step;
 
 	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
+
+	if (base == 0)
+		trailing_zero_bits = count_trailing_zeros(step);
+	else
+		trailing_zero_bits = min(count_trailing_zeros(base),
+					 count_trailing_zeros(step));
+	reg->var_off = tnum_and(reg->var_off, tnum_const(~0ULL << trailing_zero_bits));
 }
 
 static bool range_bounds_violation(struct bpf_reg_state *reg);
@@ -2250,6 +2383,7 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 	if (env->test_reg_invariants)
 		return -EFAULT;
 	__mark_reg_unbounded(reg);
+	reg_step_reset(reg);
 	return 0;
 }
 
@@ -2260,6 +2394,7 @@ void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	__mark_reg_unbounded(reg);
+	reg_step_reset(reg);
 }
 
 /* Mark a register as having a completely unknown (scalar) value,
@@ -5894,6 +6029,7 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 /* BPF architecture zero extends alu32 ops into 64-bit registesr */
 static void zext_32_to_64(struct bpf_reg_state *reg)
 {
+	reg_step_check_unsigned(reg, 32);
 	reg->var_off = tnum_subreg(reg->var_off);
 	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
 }
@@ -5903,13 +6039,14 @@ static void zext_32_to_64(struct bpf_reg_state *reg)
  */
 static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
 {
-	u64 mask;
+	u64 mask = (1ULL << (size * 8)) - 1;
+
+	reg_step_check_unsigned(reg, size * 8);
 
 	/* clear high bits in bit representation */
 	reg->var_off = tnum_cast(reg->var_off, size);
 
 	/* fix arithmetic bounds */
-	mask = ((u64)1 << (size * 8)) - 1;
 	if ((reg_umin(reg) & ~mask) == (reg_umax(reg) & ~mask))
 		reg_set_urange64(reg, reg_umin(reg) & mask, reg_umax(reg) & mask);
 	else
@@ -5947,6 +6084,8 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 	u64 top_smax_value, top_smin_value;
 	u64 num_bits = size * 8;
 
+	reg_step_check_signed(reg, num_bits);
+
 	if (tnum_is_const(reg->var_off)) {
 		u64_cval = reg->var_off.value;
 		if (size == 1)
@@ -6012,6 +6151,8 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 	u32 top_smax_value, top_smin_value;
 	u32 num_bits = size * 8;
 
+	reg_step_check_unsigned(reg, num_bits - 1);
+
 	if (tnum_is_const(reg->var_off)) {
 		u32_val = reg->var_off.value;
 		if (size == 1)
@@ -6721,6 +6862,7 @@ static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
 	fake_reg.type = SCALAR_VALUE;
 	__mark_reg_known(&fake_reg, val);
 
+	scalar_step_add(dst_reg, dst_reg, &fake_reg);
 	scalar32_min_max_add(dst_reg, &fake_reg);
 	scalar_min_max_add(dst_reg, &fake_reg);
 	dst_reg->var_off = tnum_add(dst_reg->var_off, fake_reg.var_off);
@@ -15591,6 +15733,24 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void scalar_step_mul(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg)
+{
+	if (tnum_is_const(src_reg->var_off))
+		scalar_step_scale(dst_reg, src_reg->var_off.value);
+	else
+		reg_step_reset(dst_reg);
+}
+
+static void scalar_step_lsh(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg)
+{
+	u64 amount = src_reg->var_off.value;
+
+	if (tnum_is_const(src_reg->var_off) && amount < 64)
+		scalar_step_scale(dst_reg, 1ULL << amount);
+	else
+		reg_step_reset(dst_reg);
+}
+
 /* Handles arithmetic on a pointer and a scalar: computes new min/max and var_off.
  * Caller should also handle BPF_MOV case separately.
  * If we return -EACCES, caller may want to try again treating pointer as a
@@ -15759,6 +15919,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
 		 */
+		scalar_step_add(dst_reg, ptr_reg, off_reg);
 		dst_reg->r64 = cnum64_add(ptr_reg->r64, off_reg->r64);
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
@@ -15820,6 +15981,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			if ((!known && smin_val < 0) || dst_reg->range < 0)
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_AND:
 	case BPF_OR:
@@ -16527,6 +16689,7 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 		 * Bounds will be re-derived from the new tnum later.
 		 */
 		__mark_reg_unbounded(dst_reg);
+		reg_step_reset(dst_reg);
 	}
 	/* For bswap16/32, truncate dst register to match the swapped size */
 	if (insn->imm == 16 || insn->imm == 32)
@@ -16653,6 +16816,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	 */
 	switch (opcode) {
 	case BPF_ADD:
+		scalar_step_add(dst_reg, dst_reg, &src_reg);
 		scalar32_min_max_add(dst_reg, &src_reg);
 		scalar_min_max_add(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_add(dst_reg->var_off, src_reg.var_off);
@@ -16661,6 +16825,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar32_min_max_sub(dst_reg, &src_reg);
 		scalar_min_max_sub(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_sub(dst_reg->var_off, src_reg.var_off);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_NEG:
 		env->fake_reg[0] = *dst_reg;
@@ -16668,8 +16833,10 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar32_min_max_sub(dst_reg, &env->fake_reg[0]);
 		scalar_min_max_sub(dst_reg, &env->fake_reg[0]);
 		dst_reg->var_off = tnum_neg(env->fake_reg[0].var_off);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_MUL:
+		scalar_step_mul(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_mul(dst_reg, &src_reg);
 		scalar_min_max_mul(dst_reg, &src_reg);
@@ -16690,6 +16857,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				scalar_min_max_sdiv(dst_reg, &src_reg);
 			else
 				scalar_min_max_udiv(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_MOD:
 		/* BPF mod specification: x % 0 = x */
@@ -16705,6 +16873,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				scalar_min_max_smod(dst_reg, &src_reg);
 			else
 				scalar_min_max_umod(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_AND:
 		if (tnum_is_const(src_reg.var_off)) {
@@ -16715,6 +16884,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		dst_reg->var_off = tnum_and(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_and(dst_reg, &src_reg);
 		scalar_min_max_and(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_OR:
 		if (tnum_is_const(src_reg.var_off)) {
@@ -16725,13 +16895,16 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		dst_reg->var_off = tnum_or(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_or(dst_reg, &src_reg);
 		scalar_min_max_or(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_XOR:
 		dst_reg->var_off = tnum_xor(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_xor(dst_reg, &src_reg);
 		scalar_min_max_xor(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_LSH:
+		scalar_step_lsh(dst_reg, &src_reg);
 		if (alu32)
 			scalar32_min_max_lsh(dst_reg, &src_reg);
 		else
@@ -16742,15 +16915,18 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			scalar32_min_max_rsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_rsh(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_ARSH:
 		if (alu32)
 			scalar32_min_max_arsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_arsh(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_END:
 		scalar_byte_swap(dst_reg, insn);
+		reg_step_reset(dst_reg);
 		break;
 	default:
 		break;
@@ -17657,6 +17833,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		 * violations if we're on a dead branch.
 		 */
 		__mark_reg_unbounded(reg1);
+		reg_step_reset(reg1);
 		if (is_jmp32) {
 			t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
 			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
@@ -17979,6 +18156,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			reg->delta = saved_off;
 			reg->id = saved_id;
 
+			scalar_step_add(reg, reg, &fake_reg);
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);

-- 
2.53.0
