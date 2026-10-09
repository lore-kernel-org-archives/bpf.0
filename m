Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51C4C77BC
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542927; cv=none; b=a1YUgK/6H5nf2v7gFNEuUf8Ucc+PJzZDEth2AfshxFzB6J+RaKcMmOGB7xAHQevZ5PcyQtFJIFPU1zLuItHOLaPhC+vPW0R2klOPjE8AguLUWP8VQ5MDFnmvNOAUGTTbHVfvJ+JdChgw13+oEAcHcZBoWdXBMi2t08f0UsmzZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542927; c=relaxed/simple;
	bh=1euZF5GoYF8lAJSA6glOEl3CC5NcTj19kGWoH+jXxKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ztj2xBzXEiTo/Z2fgbUZWUw0d0978bAs+QPbInlh1oJPdnLSSlIkaNRVTNewme2YQdPal/2ar9Osv+wY1BIOCbzgODORpVsdrmermFnGmex9sbW6KkMfDDhhdq1TAUzR4fR/8ZAop2TkpviR0edn6K0qNRpZk9HRKyFzQZ88+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUkHFKM0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUkHFKM0"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so4047968a91.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542912; x=1792147712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PNLB4QndITvKqEPfSptTeD+OvRFoX97uWFpSOB9RQ6A=;
        b=NUkHFKM0pFyvmkJFmlw0cupXbe/WuXW/o5jSWvKGxdC+PnULil9X1GBCMHvcfS18Be
         brgBziq5LcvgjNw12sDwfGoejVq/OxP6PrA789PvM/dcxeW895pO50zL6AqSPG7q6DD1
         ce2UxLd3b/p/p2jVpPT8Xc85sG51Gd0W6pL+S6IC0IEVaF1gumlLht9T+mcUYkTMyNgg
         3LhstAaDoEom4qETnoXYdSsRikKb570oUInxXLxyoLtXuECt7TgZptTxjnUXSGFVTYb8
         RXt1ZPLl7++8DxySRW5YMPEerljUJ3bYnz+3TBlrtJIXMMwLVuM9iWBo/sHjV32uvMVJ
         F0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542912; x=1792147712;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PNLB4QndITvKqEPfSptTeD+OvRFoX97uWFpSOB9RQ6A=;
        b=jJsad6K23dJ52JYSOLEMGc8xOT0uZysrkIUvNZLiuQGPxFxr2tT4fwZbjiqUa7MMkg
         BBc8HqKYojj/JVBPHscZTxwWwzlDIATrVkIPVmz30Lv7S+RKYv2m69dlJzwqpOz7OISu
         kmdiWdo+EpNDTKAYbaH5lfYfxACY3EjiHcx7jwqSfZSU9p0jH4WfSQQ1ZKuqPRv2r2+c
         ChPePE1MsKnGSvpVOKVBbOXaTFFFhubfMSrFexHuPLqE0eIQ4RaJAA5GW6YqFTPoKfVQ
         ta6IC6fhAHyoMQeGo2Fg2t3YqvuRU89Jn3n0QiyF8QVRr3LVqsBPxlFYzwaNON36+XeY
         K+5A==
X-Gm-Message-State: AFq9FYL40dkqsmJV84q4sDoGKjQEChS4yAwBT3S+GXuDv3//6ie861hy
	3PMInLuBnF4e+A2vEvkfILrCplrpYd2BgLvUXglsIARyFWnff7D3oeZCVkh81bqj
X-Gm-Gg: AYBFou2yiu2suVQpZeaknK8ehDNoZkev6VoS2VZucZLZ69qFisthyd32yjr6a6kurRQ
	wstqlruKoOt9rO1vR/0m2qA4ZdVb6BaCFacSckXlue5/TcwjPKmmF7Kvq45XbUrs5lU//KTq7gp
	noqsClI3oWvyXdZw8QGXHZGDoSH5ZARQe4VUDZuchrxD7B7/GoWxgLoHmVXSrmrxS4VQg8Oeo47
	DCp/wc3HhZv3uzr3uVzwNiaDy2jnvLqhyDCo0arcRN/rtNrCbHE2nQ+03SYQFT5EAMJrwfUslbO
	YFi+iUzflr1FPbphtAK6UNLEOobgl/3P33T4H8SyNtGWVxciKvaNEcqZpy+1BZEq8wirIiW4oyw
	BMWU1Ro99DBmu000ByM3BjeXwPokRPGYsrcLzjTtRbGtKzePHkiILe2+xlDjbuXmDuHasDpgSPm
	NawoSApxZsVApCeXCSQqWBoqcDbEYz/YVEtDnl2xGKWIOwTlftKfDWox15jU7QYcKQtlw/Z6bLt
	J/vxzlCg4rZLwQ=
X-Received: by 2002:a17:90a:d44d:b0:3a4:bd4e:6d15 with SMTP id 98e67ed59e1d1-3ab3a8a471cmr1389617a91.34.1791542912141;
        Fri, 09 Oct 2026 03:48:32 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:31 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 19/51] bpf: representation for intervals with steps
Date: Fri,  9 Oct 2026 03:47:37 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-19-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
- __reg_bound_offset() clears the low bits of var_off implied by the number
  of trailing zeros shared by base and step.
- __update_bounds_from_step() intersects the 64-bit range with the line via
  cnum64_intersect_linear(), snapping smin/smax to actual points on it.
  This is the last step of the sync, as refining the range from var_off
  can move the bounds off the line.

range_within() is extended to check whether the cur register's equation
describes a subset of the points described by the old register's equation.

Scalar ALU operations update base/step as follows:
- ADD of a constant (including pointer + scalar): keep step, shift base;
- MUL by a constant: scale step and base by the constant;
- LSH by a constant: scale step and base by the corresponding power of two;
- sign extension: keep the register unchanged if all values fit the target
  type, reset to base=0, step=1 otherwise;
- All other operations reset to base=0, step=1.

Branch (eq/neq) checks do not take into account base/step yet.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   7 ++
 kernel/bpf/log.c             |   2 +
 kernel/bpf/states.c          |  26 +++++-
 kernel/bpf/verifier.c        | 211 ++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 240 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index b4396867c6f3..2560754ed56c 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -139,6 +139,13 @@ struct bpf_reg_state {
 	 */
 	struct cnum64 r64; /* 64-bit range as circular number */
 	struct cnum32 r32; /* 32-bit range as circular number */
+	/*
+	 * The value described by this register, interpreted as s64, lies on
+	 * a line described by a linear equation base + step * k.
+	 * Invariant: base < step.
+	 */
+	u16 base;
+	u16 step;
 	/* For PTR_TO_PACKET, used to find other pointers with the same variable
 	 * offset, so they can share range knowledge.
 	 * For PTR_TO_MAP_VALUE_OR_NULL this is used to share which map value we
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 87d137734db1..8ee7d7b71147 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -693,6 +693,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
 			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
 			verbose_a("var_off=%s", tn_buf);
 		}
+		if (reg->base != 0 || reg->step != 1)
+			verbose_a("step=%d+%d", reg->base, reg->step);
 	}
 	verbose(env, ")");
 }
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
index 47a632a6749a..f5b2500335a7 100644
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
@@ -1922,12 +1923,124 @@ static void bpf_diag_record_caller_saved(struct bpf_verifier_env *env,
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
+	/*
+	 * The above established that `step = dst_reg->step * amount`
+	 * does not overflow, therefore the base < step invariant holds
+	 * after assignments below.
+	 */
+	dst_reg->base = dst_reg->base * amount;
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
 /* This helper doesn't clear reg->id */
 static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 {
 	reg->var_off = tnum_const(imm);
 	reg->r64 = cnum64_from_urange(imm, imm);
 	reg->r32 = cnum32_from_urange((u32)imm, (u32)imm);
+	reg_step_reset(reg);
 }
 
 /* Mark the unknown part of a register (variable offset or scalar value) as
@@ -2185,8 +2298,24 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
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
+}
+
+static void __update_bounds_from_step(struct bpf_reg_state *reg)
+{
+	reg->r64 = cnum64_intersect_linear(reg->r64, reg->base, reg->step);
+	deduce_bounds_32_from_64(reg);
 }
 
 static bool range_bounds_violation(struct bpf_reg_state *reg);
@@ -2208,6 +2337,15 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	 * then new var_off is (0; 0x7f...fc) which improves our umax.
 	 */
 	__update_reg_bounds(reg);
+	/*
+	 * Both tnum and base+step define a sequence of points,
+	 * potentially w/o intersection, or intersecting after N
+	 * tnum_step()'s, where N can be large. On the other hand,
+	 * step+base *must* be in sync with r64 in order for
+	 * array traversal logic starting at reg_umin() to be sound.
+	 * Hence, place this as a final step in the reg_bounds_sync().
+	 */
+	__update_bounds_from_step(reg);
 }
 
 static bool const_tnum_range_mismatch(struct bpf_reg_state *reg)
@@ -2251,17 +2389,24 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 		goto out;
 	}
 
+	if (reg->step == 0 || reg->base >= reg->step) {
+		msg = "invalid base/step";
+		goto out;
+	}
+
 	return 0;
 out:
 	verifier_bug(env, "REG INVARIANTS VIOLATION (%s): %s r64={.base=%#llx, .size=%#llx} "
-		     "r32={.base=%#x, .size=%#x} var_off=(%#llx, %#llx)",
+		     "r32={.base=%#x, .size=%#x} var_off=(%#llx, %#llx) step=%u+%u",
 		     ctx, msg,
 		     reg->r64.base, reg->r64.size,
 		     reg->r32.base, reg->r32.size,
-		     reg->var_off.value, reg->var_off.mask);
+		     reg->var_off.value, reg->var_off.mask,
+		     reg->base, reg->step);
 	if (env->test_reg_invariants)
 		return -EFAULT;
 	__mark_reg_unbounded(reg);
+	reg_step_reset(reg);
 	return 0;
 }
 
@@ -2272,6 +2417,7 @@ void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	__mark_reg_unbounded(reg);
+	reg_step_reset(reg);
 }
 
 /* Mark a register as having a completely unknown (scalar) value,
@@ -5902,6 +6048,7 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 /* BPF architecture zero extends alu32 ops into 64-bit registesr */
 static void zext_32_to_64(struct bpf_reg_state *reg)
 {
+	reg_step_check_unsigned(reg, 32);
 	reg->var_off = tnum_subreg(reg->var_off);
 	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
 }
@@ -5911,13 +6058,14 @@ static void zext_32_to_64(struct bpf_reg_state *reg)
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
@@ -5954,6 +6102,14 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
 	u64 top_smax_value, top_smin_value;
 	u64 num_bits = size * 8;
+	s64 limit = 1LL << (num_bits - 1);
+
+	/* If every value fits the signed N-bit range sign extension is a noop. */
+	if (reg_smin(reg) >= -limit && reg_smax(reg) < limit)
+		return;
+
+	/* See commen at reg_step_check_unsigned(). */
+	reg_step_reset(reg);
 
 	if (tnum_is_const(reg->var_off)) {
 		u64_cval = reg->var_off.value;
@@ -6020,6 +6176,16 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 	u32 top_smax_value, top_smin_value;
 	u32 num_bits = size * 8;
 
+	/*
+	 * If value fits the non-negative half of the signed N-bit range,
+	 * sign extension is a noop.
+	 */
+	if (reg_umax(reg) < (1ULL << (num_bits - 1)))
+		return;
+
+	/* See comment at reg_step_check_unsigned(). */
+	reg_step_reset(reg);
+
 	if (tnum_is_const(reg->var_off)) {
 		u32_val = reg->var_off.value;
 		if (size == 1)
@@ -6729,6 +6895,7 @@ static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
 	fake_reg.type = SCALAR_VALUE;
 	__mark_reg_known(&fake_reg, val);
 
+	scalar_step_add(dst_reg, dst_reg, &fake_reg);
 	scalar32_min_max_add(dst_reg, &fake_reg);
 	scalar_min_max_add(dst_reg, &fake_reg);
 	dst_reg->var_off = tnum_add(dst_reg->var_off, fake_reg.var_off);
@@ -15693,6 +15860,24 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
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
@@ -15861,6 +16046,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
 		 */
+		scalar_step_add(dst_reg, ptr_reg, off_reg);
 		dst_reg->r64 = cnum64_add(ptr_reg->r64, off_reg->r64);
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
@@ -15922,6 +16108,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			if ((!known && smin_val < 0) || dst_reg->range < 0)
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_AND:
 	case BPF_OR:
@@ -16629,6 +16816,7 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 		 * Bounds will be re-derived from the new tnum later.
 		 */
 		__mark_reg_unbounded(dst_reg);
+		reg_step_reset(dst_reg);
 	}
 	/* For bswap16/32, truncate dst register to match the swapped size */
 	if (insn->imm == 16 || insn->imm == 32)
@@ -16755,6 +16943,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	 */
 	switch (opcode) {
 	case BPF_ADD:
+		scalar_step_add(dst_reg, dst_reg, &src_reg);
 		scalar32_min_max_add(dst_reg, &src_reg);
 		scalar_min_max_add(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_add(dst_reg->var_off, src_reg.var_off);
@@ -16763,6 +16952,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar32_min_max_sub(dst_reg, &src_reg);
 		scalar_min_max_sub(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_sub(dst_reg->var_off, src_reg.var_off);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_NEG:
 		env->fake_reg[0] = *dst_reg;
@@ -16770,8 +16960,10 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
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
@@ -16792,6 +16984,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				scalar_min_max_sdiv(dst_reg, &src_reg);
 			else
 				scalar_min_max_udiv(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_MOD:
 		/* BPF mod specification: x % 0 = x */
@@ -16807,6 +17000,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				scalar_min_max_smod(dst_reg, &src_reg);
 			else
 				scalar_min_max_umod(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_AND:
 		if (tnum_is_const(src_reg.var_off)) {
@@ -16817,6 +17011,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		dst_reg->var_off = tnum_and(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_and(dst_reg, &src_reg);
 		scalar_min_max_and(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_OR:
 		if (tnum_is_const(src_reg.var_off)) {
@@ -16827,13 +17022,16 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
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
@@ -16844,15 +17042,18 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
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
@@ -17759,6 +17960,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		 * violations if we're on a dead branch.
 		 */
 		__mark_reg_unbounded(reg1);
+		reg_step_reset(reg1);
 		if (is_jmp32) {
 			t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
 			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
@@ -18081,6 +18283,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 			reg->delta = saved_off;
 			reg->id = saved_id;
 
+			scalar_step_add(reg, reg, &fake_reg);
 			scalar32_min_max_add(reg, &fake_reg);
 			scalar_min_max_add(reg, &fake_reg);
 			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);

-- 
2.53.0
