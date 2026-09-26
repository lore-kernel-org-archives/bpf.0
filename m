Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC965478E57
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432462; cv=none; b=Ag+yCBbWtraGWnV/CwSyT2uOPjHtvSv7Ufb9CdcG8fSSmgwG9W8B39/U6NhkKAgDav39EEq/gRATTZopfAuuUk9CHj+JQENBCbAcVilXjqbJdnIQ6ucCBU+z4JQtH3KrMK8hATsEEJZew/TvNSfQ5L4kCQ6dFEazTP9s8Xb2ppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432462; c=relaxed/simple;
	bh=cGDf/T3nmvODRzF/AEPL2iVq/Qxb0J7P95ByTiuii5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGOg9QQikPG1SRSOnJ/hAn1GTo8jGNT5PHYEkDO8C8eXxkRutp52kScJOkjOJFoN7gkYA8TcBrd+Dl5HZqBRMwwZVUazjaUBLBQoUOKxX5vUh2pG+rtY3jBqIMffpWZTdbbGrdsUccjjQ/pAOoA9C9u4mvo9el//0eb4zDkNxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrTVCtUQ; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrTVCtUQ"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc79a5bdf9fso119379a12.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432460; x=1791037260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OTkXh6BLdXB67ACPDRAfMTCDYe7Nwhy7Q59I+pOt/qA=;
        b=YrTVCtUQT/7G9WVk3hdjga7Yar03O6Hep4LuXceqLbUthLKDYSx8k5ZTh9ZUL+GPZW
         NtQZc+j0Z4M85CLFcH0fxyGtp8ZRUg6Dbc0gs3dX7j82YdJXT31XtqNtwPUk6uz+DMC+
         elDczqnBCz0atnxSiVZ45O4tNrTTjryqcrSI6YmMaKVMmhhzRdnlFv8cZ/DS3G4kOq0z
         DoY9cZP8k0k8vmOqtIhw2WEbVb3piInVdlSmbhHAEAzdyfcZbrSNJhLQ3utKpdN6e1zm
         +4/5DbL826wprqxjZ39lo+8KAM77SiLuJwOa4PONlTBJp50+fWLk0/TyV9JK4v1cGdlI
         cheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432460; x=1791037260;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTkXh6BLdXB67ACPDRAfMTCDYe7Nwhy7Q59I+pOt/qA=;
        b=0FCbTfyBXi9X5CY3mMyri9WcCUC45pfYAJecmG+L0klI+ZA6Kh0MDN9EFh5P70goo0
         3ReYJWb+yzmePq8n+X2XN+637qt6m/dP+gKJY7N+xP978c9bBXTP2UXOSqRm/vm3y5LD
         thHafgL4CKI3O15uTOcgYra734Cjc6MnnvVMIuBsMzgwy6uNYzHheoXOMxmquEnwRq/5
         LBR6ovSlDss3b2D+srA10g12o9LA6cPKnbxZVIMWqB+IdkLhU14hYe5khCzOWLRsLYjn
         FGUoMlt4HqC6194+V1QxzgTcb18vQAt/wQ5e+bgzgz+2buW5MbjuFeYDVxpKfoD94d80
         yvrQ==
X-Gm-Message-State: AFq9FYIpqq4dDitmcITw9syWz4q0hnXWqrpm5ivC0/cCsbVFMmpvUDXn
	W3FEtbjpdgNPMRNOqLGjJ1ZOiPwkTEVJz2FQKgxyNgue2WvAuOnLMIsIzUQimsCql4A=
X-Gm-Gg: AYBFou2jAVW89WTy1xfnAoz+aqTNf/VpOa9Fpn8VdwRDbiQkbDyq90tsmVoAB66Fw9O
	D4QcmpBokHEWat2wg0iDpFGDlNh2S7EvUCJQfPDA5ZuCTofzthRzLfgu9utWVAwGdV4t9DLuHg5
	sx0PGf0iy7KOoOmRXP2Tnwx03hPvaCKJhj4lZvmxd32XAOHH+FadmeMrSm0h2Sw3jVTgzCVTk+4
	m0WnzFTOR8QoHZEMsVVqy5Ma846X0Yg3XgFJCXrkJzWzMmaffCcot81EGNUErN78VBCqR5pqatR
	5P3Fz8e+KY3pchJV4TNdrWmLSJ7muchpTETUvKvo8XnUfICu4b1cB/I7OhJUQIbBobbaL1+H+9T
	7DFsxzO2BerGnNabiJrvcddcC007LhpeBmmSj+BpoK6p08L/T/y19FGIf4yiTtw1vSNf2ObcDDS
	js+BHSo0riMwV82rPrLbVzXhaFFZa6AvY5iYk9yTjwjEKe3+fvVQkQj1nyJktlrzFvSgQ7Fm60P
	EZOI9RatDiy/x9+GvZLKdn3KE8ofmps2dSRx5N4ww==
X-Received: by 2002:a17:90b:3f8e:b0:39e:6a7f:618a with SMTP id 98e67ed59e1d1-3a098acb8f5mr5369706a91.27.1790432459893;
        Sat, 26 Sep 2026 07:20:59 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:20:59 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 14/36] bpf: representation for intervals with steps
Date: Sat, 26 Sep 2026 07:20:12 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-14-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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
 include/linux/bpf_verifier.h |  7 ++++
 kernel/bpf/log.c             |  2 +
 kernel/bpf/states.c          | 26 ++++++++++++-
 kernel/bpf/verifier.c        | 87 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 075a28de2a04..3787de11f689 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -178,6 +178,13 @@ struct bpf_reg_state {
 	 * during state comparisons.
 	 */
 	u32 map_uid;
+	/*
+	 * The value described by this register is some point lying on
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
index 29d18520d27c..d4fa98998543 100644
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
index 79aa92486154..89b1a0aa3a25 100644
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
@@ -1911,12 +1912,19 @@ static void bpf_diag_record_caller_saved(struct bpf_verifier_env *env,
 	}
 }
 
+static void reg_step_reset(struct bpf_reg_state *reg)
+{
+	reg->base = 0;
+	reg->step = 1;
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
@@ -2165,10 +2173,16 @@ static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
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
@@ -2180,8 +2194,18 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
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
@@ -2257,6 +2281,7 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 	if (env->test_reg_invariants)
 		return -EFAULT;
 	__mark_reg_unbounded(reg);
+	reg_step_reset(reg);
 	return 0;
 }
 
@@ -2267,6 +2292,7 @@ void bpf_mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 	reg->type = SCALAR_VALUE;
 	reg->var_off = tnum_unknown;
 	__mark_reg_unbounded(reg);
+	reg_step_reset(reg);
 }
 
 /* Mark a register as having a completely unknown (scalar) value,
@@ -15589,6 +15615,50 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static void scalar_step_add(struct bpf_reg_state *dst_reg,
+			    const struct bpf_reg_state *a,
+			    const struct bpf_reg_state *b)
+{
+	u16 base, step;
+
+	/* If either 'a' or 'b' is a constant, update the base/step for the counterpart. */
+	if (tnum_is_const(b->var_off)) {
+		step = a->step;
+		base = imod((s64)a->base + (s64)b->var_off.value, step);
+	} else if (tnum_is_const(a->var_off)) {
+		step = b->step;
+		base = imod((s64)b->base + (s64)a->var_off.value, step);
+	} else {
+		step = 1;
+		base = 0;
+	}
+	dst_reg->base = base;
+	dst_reg->step = step;
+}
+
+static void scalar_step_mul(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg)
+{
+	u64 amount = src_reg->var_off.value;
+
+	if (tnum_is_const(src_reg->var_off) && (s64)amount >= 0 &&
+	    !check_mul_overflow(dst_reg->step, amount, &dst_reg->step) &&
+	    dst_reg->step != 0)
+		dst_reg->base = (dst_reg->base * amount) % dst_reg->step;
+	else
+		reg_step_reset(dst_reg);
+}
+
+static void scalar_step_lsh(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg)
+{
+	u64 amount = src_reg->var_off.value;
+
+	if (tnum_is_const(src_reg->var_off) && amount < 64 &&
+	    !check_mul_overflow(dst_reg->step, 1ull << amount, &dst_reg->step))
+		dst_reg->base = (dst_reg->base * (1ull << amount)) % dst_reg->step;
+	else
+		reg_step_reset(dst_reg);
+}
+
 /* Handles arithmetic on a pointer and a scalar: computes new min/max and var_off.
  * Caller should also handle BPF_MOV case separately.
  * If we return -EACCES, caller may want to try again treating pointer as a
@@ -15746,6 +15816,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 		 * added into the variable offset, and we copy the fixed offset
 		 * from ptr_reg.
 		 */
+		scalar_step_add(dst_reg, ptr_reg, off_reg);
 		dst_reg->r64 = cnum64_add(ptr_reg->r64, off_reg->r64);
 		dst_reg->var_off = tnum_add(ptr_reg->var_off, off_reg->var_off);
 		dst_reg->raw = ptr_reg->raw;
@@ -15807,6 +15878,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			if ((!known && smin_val < 0) || dst_reg->range < 0)
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_AND:
 	case BPF_OR:
@@ -16506,6 +16578,7 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 		 * Bounds will be re-derived from the new tnum later.
 		 */
 		__mark_reg_unbounded(dst_reg);
+		reg_step_reset(dst_reg);
 	}
 	/* For bswap16/32, truncate dst register to match the swapped size */
 	if (insn->imm == 16 || insn->imm == 32)
@@ -16632,6 +16705,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	 */
 	switch (opcode) {
 	case BPF_ADD:
+		scalar_step_add(dst_reg, dst_reg, &src_reg);
 		scalar32_min_max_add(dst_reg, &src_reg);
 		scalar_min_max_add(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_add(dst_reg->var_off, src_reg.var_off);
@@ -16640,6 +16714,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar32_min_max_sub(dst_reg, &src_reg);
 		scalar_min_max_sub(dst_reg, &src_reg);
 		dst_reg->var_off = tnum_sub(dst_reg->var_off, src_reg.var_off);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_NEG:
 		env->fake_reg[0] = *dst_reg;
@@ -16647,11 +16722,13 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar32_min_max_sub(dst_reg, &env->fake_reg[0]);
 		scalar_min_max_sub(dst_reg, &env->fake_reg[0]);
 		dst_reg->var_off = tnum_neg(env->fake_reg[0].var_off);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_MUL:
 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_mul(dst_reg, &src_reg);
 		scalar_min_max_mul(dst_reg, &src_reg);
+		scalar_step_mul(dst_reg, &src_reg);
 		break;
 	case BPF_DIV:
 		/* BPF div specification: x / 0 = 0 */
@@ -16669,6 +16746,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				scalar_min_max_sdiv(dst_reg, &src_reg);
 			else
 				scalar_min_max_udiv(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_MOD:
 		/* BPF mod specification: x % 0 = x */
@@ -16684,6 +16762,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				scalar_min_max_smod(dst_reg, &src_reg);
 			else
 				scalar_min_max_umod(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_AND:
 		if (tnum_is_const(src_reg.var_off)) {
@@ -16694,6 +16773,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		dst_reg->var_off = tnum_and(dst_reg->var_off, src_reg.var_off);
 		scalar32_min_max_and(dst_reg, &src_reg);
 		scalar_min_max_and(dst_reg, &src_reg);
+		reg_step_reset(dst_reg);
 		break;
 	case BPF_OR:
 		if (tnum_is_const(src_reg.var_off)) {
@@ -16704,32 +16784,38 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
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
 		if (alu32)
 			scalar32_min_max_lsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_lsh(dst_reg, &src_reg);
+		scalar_step_lsh(dst_reg, &src_reg);
 		break;
 	case BPF_RSH:
 		if (alu32)
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
@@ -17675,6 +17761,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		 * violations if we're on a dead branch.
 		 */
 		__mark_reg_unbounded(reg1);
+		reg_step_reset(reg1);
 		if (is_jmp32) {
 			t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
 			reg1->var_off = tnum_with_subreg(reg1->var_off, t);

-- 
2.55.0
