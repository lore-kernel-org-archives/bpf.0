Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498847;
	b=SY4ESxXU6YtRUz/Yra9GwCQzOQ4aCCuXbTT6sKhBjNx0OLeQgHdS2Kicvp3D2+pKx33c
	 AdxWQ1a4UxvYUlVcx6ZaaWdfExJPvQkdy983JjuYv3AAlSLKAVBG/SNME8iuCJZJqzaCU
	 4APW+f5rmtd5IwzqqnM0LHixaW56RJ10d6rp8VGWfN7t7uMexZMlxFb9w7BuHXJ52PZXR
	 bV7uuoKo1LygrqtGPL0baLGBFmeNK4Rw/Lh7YlnATj/otpmWz2q7G2TUWcJ2uggsfxXjJ
	 kBkaAd2xt3ttfjbsQzC4hui4lRfLr+P77O+w7TMdWhgaYhiE57jmf5wHya4WxW4SdYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+KR5WllcfPWKbh7sJLXORev/PcD2IJzLAvfeT+cuQB8=;
	b=rRJfiqdpc+5SImyUOepo8xucUgi51m/xKlLoxV2aCLfro/Q3pvaClXg1C02jwACFITow
	 W4R8TGs1SkYn3AEGD/sG/BBQjo+akkkI/KuXJ+Tt5hVqyEttP1CnN+lToT9B4Pctz+ph5
	 OmaVqKAbLyobYFEMpOhswkNmV3zRssri6g38UKh6QEX4zlWQaxrQDhaQUUL1JZt1yp5NR
	 s7i35rOg/8SJJPJtcfnNYGg9jeBEfEdNIuxxlcDQAneMMMDq1LyC3HcApmnY5ovDQObtq
	 puVVmh4asojyNsIDRXMMlg6xQFExmFfshHe+AFnKurF+ixJaIhO1CZpSkMMIamDex4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wedr51NF;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3FB606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B3FB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wedr51NF
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so2378004b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498845; x=1795103645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+KR5WllcfPWKbh7sJLXORev/PcD2IJzLAvfeT+cuQB8=;
        b=wedr51NFRxditoM273/2Oy4sHNDN7iGSBH0PLRq9vZtj6aHRcnz24HBrQifc4zfqO1
         gsi9UInSb30eqotgFevuODlrCvaq7hLF2tsooQ6z2bqJu/8sZvDleH8WZVLv6NRiJk7Q
         Nn5rIQd3EgutkZmXTeSES2VFO7LgHVn0ISJzZPd8rsg9vgiQ0+fEnnYilzoVtsxRwYOK
         0dyS8O+g/bUU3xI9I6NLDHu8APZgH4mKdPD++zNHWmE1bxzl12msrBlvw8jRkwKFt3oU
         a0mwfq0wzo+z0ccqm+rp1i4PDAcvZHcnsK3f9O9KTLPlIx3sBMOuCZDz7g4g9i9SkVVc
         vMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498845; x=1795103645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+KR5WllcfPWKbh7sJLXORev/PcD2IJzLAvfeT+cuQB8=;
        b=vLiVd4fI4FIR96l1A/WqNkjNLKBDx2/482Qztwwh7ZbB1SzwRLHfRLCSKGIS1nfIVf
         5Y68t5+5CnCqDSoOxGSJztDCW/0O5GtZyG0jNJ8reoLKg/nMcqNeuyoTMShvlVOzTANU
         eUqL59Ne3RFXxQCu/gkBku2BvbOdmptGe/XwxPE9ZnWb0WgFDuqouM8Hc7Y+WYOPo4vc
         6HpEwnnEi44GPy5DWZVSA8E3tgFrCXQN+YGQnjG7c3D3c7TnOhj2nOa6fphu2cevXWcO
         o+tF2brSWXMKhUAlCBZMrMDAksvqKVeYAhEE4zHytdHIYE/skNFykgPHYVujot3rPEGu
         Mdig==
X-Gm-Message-State: APuU4Z+vtXhvRCKumGfdeJejl04tqkuz9S0SwG97ZHY2WLFXZ+g69L4E
	Kry0IOpJyeUuz6iERjJ3hPn0Ll8hgmh6lqQ1GQ5hCl8sSpq2Vt5q0Y0R07PQwg==
X-Gm-Gg: AYBFou09qVlpZcc8FOL8YJjdtoIlCJxnUBJ5TGMeTrFnRMV1ELEkT91c08u1ti3v1Gd
	LuzOxH+S029HGtIiGMq9Ud4H/me+pmP8ESMsXmUEOGSNVSqDae58joYMdsFwH6csvD54TOJxlgj
	fftj/J/uJ2wq2vOSFP4VgMBx50njj/5phUUF5QJnko9sUXk5rDPEx3DEug6RIMH+UuNL72grHWd
	5LAfW81maNe0lQa6XBFEPqBMyWerpTGY65vdmvTh2I38G5wkE+qchPuqEFcKRNqw5mC+GUClHxH
	w56VbRlF9GuDE5jpNynu2q9cLBkze0Iel3B4+XdjMkiy+0B4xjapqsBevdbqjf5r/Okk9gYmpm4
	28R7diuNYpKP/oqYhXjo/t834NhiSjs79+hAqShZw9vyzf0KzLK58E6IR8gx57raOoCtBMRs6fa
	BKtOctEo/j4wjjNMNThICVTUFBL7oNgk6crYHWmL70soh0xB8M+Zqj3uSRgWN6B0/zacNDmAWPK
	wpOEi6UHduCEbKl8OxDL+KEYBg4EJIdy5KfJwfeS/Vz3Gwsdvm44sB4fP9VTg0uSpdC5UgTV4gX
	cvEYIR7ckbIVYm8mWU7yrtcuMBuAs2IGUC1nGO6bkmK3pny53kW2PeGw9eWgebDU1aX1dUXVIAk
	PmFUbvHFJ4xjVwmDKbfneH4Jv6COHh4jnIKvN8ZakkPaaOBz5aPcRJvSBWh0iHD9eqUSWUtAyYG
	M=
X-Received: by 2002:a17:90b:574c:b0:3ad:93b4:718f with SMTP id 98e67ed59e1d1-3b182fe6fbdmr5984504a91.65.1794498844514;
        Thu, 12 Nov 2026 07:54:04 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35ac2sm5217940a91.17.2026.11.12.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 04/12] bpf: Make the operations on a scalar take struct scalar
Date: Thu, 12 Nov 2026 15:53:29 +0000
Message-ID: <20261112155337.1040699-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Datadog's socket__http2_headers_parser computes p = h + (n & 255) * 20
and compares n with 2 afterwards. The jump refines n. The range of p
follows from its expression: an and, a multiplication, an addition.
Scalar evolution knows the expression and is going to evaluate it with
the transfer functions of the main pass. The values in between are in no
register.

scalar_add(), scalar_union() and a few more functions take
a struct scalar. The others read and write the same five members and
take a struct bpf_reg_state. Code that has a value and no register makes
up a register of 80 bytes: BPF_NEG copies its operand to
env->fake_reg[0], adjust_scalar_min_max_vals() gets a copy of the source
register, refine_linked_regs() copies a register to add a constant.

Make 61 more functions take a struct scalar: reg_bounds_sync() with its
callees, the checks of the invariants, the casts, all ALU operations,
the widening, the refinement by a jump. In them, and in the switch of
adjust_scalar_min_max_vals(), which calls the ALU operations:

	struct bpf_reg_state *		struct scalar *
	reg_smin(reg)			cnum64_smin(s->r64)
	reg_set_srange64(reg, a, b)	s->r64 = cnum64_from_srange(a, b)
	scalar_of(reg)			s
	reg, dst_reg, src_reg		s, dst, src
	reg1, reg2			a, b
	'reg' in the function's name	'scalar'

and the same for the other 7 getters and 3 setters. The names are those
of scalar_add() and scalar_zext32(). bpf_reg_widen_range() becomes
scalar_widen(). What is only read becomes const.

A caller with a register passes scalar_of(reg). reg_bounds_sync() is
called 15 times with a register and reg_is_empty() 8 times: the two
stay, as one line each. reg_step_reset() was such a line. 3 of its 21
calls still have a register, so it goes.

What is not a substitution:

 - An and, or, xor that gives a constant and BPF_NEG call
   __mark_reg_known(). It clears the ids and the union and calls
   scalar_set_const(). They call scalar_set_const() now: their register
   is a SCALAR_VALUE, there is nothing to clear.
 - regs_refine_cond_op() and BPF_UHMUL, BPF_SHMUL in the switch call
   is_reg_const(), which tests the type. Both callers of the first pass
   scalars only, the operands of the switch are scalars.
   scalar_is_const() is the rest of is_reg_const().
 - BPF_NEG keeps its operand in a struct scalar on the stack. The source
   operand of adjust_scalar_min_max_vals(), still passed by value, and
   of maybe_fork_scalars() is a struct scalar.

is_scalar_branch_taken() keeps its registers: it ends in
simulate_both_branches_taken(), which refines four registers of env and
not the arguments. reg_bounds_sanity_check() and range_within() are only
called with a register.

No functional change.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |    6 +-
 kernel/bpf/flow.c                             |    2 +-
 kernel/bpf/join.c                             |    2 +-
 kernel/bpf/verifier.c                         | 1186 ++++++++---------
 .../selftests/bpf/progs/verifier_scalar_ids.c |    2 +-
 5 files changed, 591 insertions(+), 607 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ff560e4899e1..4708131cceb6 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -59,7 +59,7 @@ struct bpf_stack_range {
 
 /*
  * What is known about a 64-bit value: the reduced product of known bits, a range, a range of the
- * low 32 bits and a congruence. The value is in each of the four. reg_bounds_sync() is the
+ * low 32 bits and a congruence. The value is in each of the four. scalar_bounds_sync() is the
  * reduction: what one of them knows refines the others.
  */
 struct scalar {
@@ -2074,8 +2074,8 @@ void scalar_union(struct scalar *acc, const struct scalar *src);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		      const struct scalar *range);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
-void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old,
-			 const struct bpf_loop_rungs *rungs, int linear);
+void scalar_widen(struct scalar *s, const struct scalar *old,
+		  const struct bpf_loop_rungs *rungs, int linear);
 int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 		  const struct bpf_reg_state *src);
 
diff --git a/kernel/bpf/flow.c b/kernel/bpf/flow.c
index f4edf411e81f..640a7c500f7c 100644
--- a/kernel/bpf/flow.c
+++ b/kernel/bpf/flow.c
@@ -1197,7 +1197,7 @@ bool bpf_flow_is_needed(struct bpf_verifier_env *env, int idx, u32 r)
 
 /*
  * A number that grows from one iteration of a loop to the next is not followed step by step. The
- * bound that moved is put where it may come to rest, see bpf_reg_widen_range(). The jumps of
+ * bound that moved is put where it may come to rest, see scalar_widen(). The jumps of
  * the loop tell where that is:
  *	do { a[i] = 0; i += 3; } while (i < 30);		29 at most comes back to the head
  *	while (i < 30) { a[i] = 0; i += 3; }			32
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 196712ecfd59..295dfd769320 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -172,7 +172,7 @@ static bool join_range(struct bpf_join_state *js, struct bpf_reg_state *dst,
 	 */
 	if (dst->type != SCALAR_VALUE)
 		return false;
-	bpf_reg_widen_range(dst, ra, join_rungs(js), join_place_is_linear(js));
+	scalar_widen(scalar_of(dst), scalar_of(ra), join_rungs(js), join_place_is_linear(js));
 	return true;
 }
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed1ec6c2a21a..c208603a10e7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1881,11 +1881,6 @@ static void scalar_step_reset(struct scalar *s)
 	s->step = 1;
 }
 
-static void reg_step_reset(struct bpf_reg_state *reg)
-{
-	scalar_step_reset(scalar_of(reg));
-}
-
 static void scalar_step_add(struct scalar *dst, const struct scalar *a, const struct scalar *b)
 {
 	const struct scalar *reg;
@@ -1930,7 +1925,7 @@ static void scalar_step_add(struct scalar *dst, const struct scalar *a, const st
 
 /*
  * dst = a + b in each of the four parts. @dst can be @a or @b.
- * The sum of reduced scalars is not always reduced: the caller calls reg_bounds_sync().
+ * The sum of reduced scalars is not always reduced: the caller calls scalar_bounds_sync().
  */
 void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar *b)
 {
@@ -1940,7 +1935,7 @@ void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar
 	dst->var_off = tnum_add(a->var_off, b->var_off);
 }
 
-static void scalar_step_scale(struct bpf_reg_state *dst_reg, u64 amount)
+static void scalar_step_scale(struct scalar *dst, u64 amount)
 {
 	u16 step;
 	s64 tmp;
@@ -1954,25 +1949,25 @@ static void scalar_step_scale(struct bpf_reg_state *dst_reg, u64 amount)
 	 * Taking the result modulo s * d gives:
 	 *   (x * d - n * 2**64) mod (s * d) =
 	 *   (b * d - (n * 2**64 mod (s * d))) mod (s * d)              (1)
-	 * Updating dst_reg->base to b * d and dst_reg->step to s * d
+	 * Updating dst->base to b * d and dst->step to s * d
 	 * requires (1) to equal b * d, which holds if and only if
 	 * n * 2**64 mod (s * d) = 0.
 	 *
 	 * Conservatively reset the stride if a wrap is possible.
 	 */
-	if (amount == 0 || check_mul_overflow(dst_reg->step, amount, &step) ||
-	    check_mul_overflow(reg_smin(dst_reg), (s64)amount, &tmp) ||
-	    check_mul_overflow(reg_smax(dst_reg), (s64)amount, &tmp)) {
-		reg_step_reset(dst_reg);
+	if (amount == 0 || check_mul_overflow(dst->step, amount, &step) ||
+	    check_mul_overflow(cnum64_smin(dst->r64), (s64)amount, &tmp) ||
+	    check_mul_overflow(cnum64_smax(dst->r64), (s64)amount, &tmp)) {
+		scalar_step_reset(dst);
 		return;
 	}
 	/*
-	 * The above established that `step = dst_reg->step * amount`
+	 * The above established that `step = dst->step * amount`
 	 * does not overflow, therefore the base < step invariant holds
 	 * after assignments below.
 	 */
-	dst_reg->base = dst_reg->base * amount;
-	dst_reg->step = step;
+	dst->base = dst->base * amount;
+	dst->step = step;
 }
 
 /*
@@ -2037,10 +2032,10 @@ void bpf_mark_reg_known_scalar(struct bpf_reg_state *reg, u64 imm)
 	reg->type = SCALAR_VALUE;
 }
 
-static void __mark_reg32_known(struct bpf_reg_state *reg, u64 imm)
+static void __mark_scalar32_known(struct scalar *s, u64 imm)
 {
-	reg->var_off = tnum_const_subreg(reg->var_off, imm);
-	reg->r32 = cnum32_const(imm);
+	s->var_off = tnum_const_subreg(s->var_off, imm);
+	s->r32 = cnum32_const(imm);
 }
 
 /* Mark the 'variable offset' part of a register as zero.  This should be
@@ -2151,33 +2146,33 @@ static bool reg_is_init_pkt_pointer(const struct bpf_reg_state *reg,
 	       tnum_equals_const(reg->var_off, 0);
 }
 
-static void __mark_reg32_unbounded(struct bpf_reg_state *reg)
+static void __mark_scalar32_unbounded(struct scalar *s)
 {
-	reg->r32 = CNUM32_UNBOUNDED;
+	s->r32 = CNUM32_UNBOUNDED;
 }
 
-static void __mark_reg64_unbounded(struct bpf_reg_state *reg)
+static void __mark_scalar64_unbounded(struct scalar *s)
 {
-	reg->r64 = CNUM64_UNBOUNDED;
+	s->r64 = CNUM64_UNBOUNDED;
 }
 
-/* Reset the min/max bounds of a register */
-static void __mark_reg_unbounded(struct bpf_reg_state *reg)
+/* Reset the min/max bounds */
+static void __mark_scalar_unbounded(struct scalar *s)
 {
-	__mark_reg64_unbounded(reg);
-	__mark_reg32_unbounded(reg);
+	__mark_scalar64_unbounded(s);
+	__mark_scalar32_unbounded(s);
 }
 
-static void reset_reg64_and_tnum(struct bpf_reg_state *reg)
+static void reset_scalar64_and_tnum(struct scalar *s)
 {
-	__mark_reg64_unbounded(reg);
-	reg->var_off = tnum_unknown;
+	__mark_scalar64_unbounded(s);
+	s->var_off = tnum_unknown;
 }
 
-static void reset_reg32_and_tnum(struct bpf_reg_state *reg)
+static void reset_scalar32_and_tnum(struct scalar *s)
 {
-	__mark_reg32_unbounded(reg);
-	reg->var_off = tnum_unknown;
+	__mark_scalar32_unbounded(s);
+	s->var_off = tnum_unknown;
 }
 
 static struct cnum32 cnum32_from_tnum(struct tnum tnum)
@@ -2203,146 +2198,151 @@ static struct cnum64 cnum64_from_tnum(struct tnum tnum)
 		return cnum64_from_urange(tnum.value, (tnum.value | tnum.mask));
 }
 
-static void __update_reg32_bounds(struct bpf_reg_state *reg)
+static void __update_scalar32_bounds(struct scalar *s)
 {
-	cnum32_intersect_with(&reg->r32, cnum32_from_tnum(reg->var_off));
+	cnum32_intersect_with(&s->r32, cnum32_from_tnum(s->var_off));
 }
 
-static void __update_reg64_bounds(struct bpf_reg_state *reg)
+static void __update_scalar64_bounds(struct scalar *s)
 {
 	u64 tnum_next, tmax;
 	bool umin_in_tnum;
 
-	cnum64_intersect_with(&reg->r64, cnum64_from_tnum(reg->var_off));
+	cnum64_intersect_with(&s->r64, cnum64_from_tnum(s->var_off));
 
 	/* Check if u64 and tnum overlap in a single value */
-	tnum_next = tnum_step(reg->var_off, reg_umin(reg));
-	umin_in_tnum = (reg_umin(reg) & ~reg->var_off.mask) == reg->var_off.value;
-	tmax = reg->var_off.value | reg->var_off.mask;
-	if (umin_in_tnum && tnum_next > reg_umax(reg)) {
+	tnum_next = tnum_step(s->var_off, cnum64_umin(s->r64));
+	umin_in_tnum = (cnum64_umin(s->r64) & ~s->var_off.mask) == s->var_off.value;
+	tmax = s->var_off.value | s->var_off.mask;
+	if (umin_in_tnum && tnum_next > cnum64_umax(s->r64)) {
 		/* The u64 range and the tnum only overlap in umin.
 		 * u64:  ---[xxxxxx]-----
 		 * tnum: --xx----------x-
 		 */
-		scalar_set_const(scalar_of(reg), reg_umin(reg));
+		scalar_set_const(s, cnum64_umin(s->r64));
 	} else if (!umin_in_tnum && tnum_next == tmax) {
 		/* The u64 range and the tnum only overlap in the maximum value
 		 * represented by the tnum, called tmax.
 		 * u64:  ---[xxxxxx]-----
 		 * tnum: xx-----x--------
 		 */
-		scalar_set_const(scalar_of(reg), tmax);
-	} else if (!umin_in_tnum && tnum_next <= reg_umax(reg) &&
-		   tnum_step(reg->var_off, tnum_next) > reg_umax(reg)) {
+		scalar_set_const(s, tmax);
+	} else if (!umin_in_tnum && tnum_next <= cnum64_umax(s->r64) &&
+		   tnum_step(s->var_off, tnum_next) > cnum64_umax(s->r64)) {
 		/* The u64 range and the tnum only overlap in between umin
 		 * (excluded) and umax.
 		 * u64:  ---[xxxxxx]-----
 		 * tnum: xx----x-------x-
 		 */
-		scalar_set_const(scalar_of(reg), tnum_next);
+		scalar_set_const(s, tnum_next);
 	}
 }
 
-static void __update_reg_bounds(struct bpf_reg_state *reg)
+static void __update_scalar_bounds(struct scalar *s)
 {
-	__update_reg32_bounds(reg);
-	__update_reg64_bounds(reg);
+	__update_scalar32_bounds(s);
+	__update_scalar64_bounds(s);
 }
 
-static void deduce_bounds_32_from_64(struct bpf_reg_state *reg)
+static void deduce_bounds_32_from_64(struct scalar *s)
 {
-	cnum32_intersect_with(&reg->r32, cnum32_from_cnum64(reg->r64));
+	cnum32_intersect_with(&s->r32, cnum32_from_cnum64(s->r64));
 }
 
-static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
+static void deduce_bounds_64_from_32(struct scalar *s)
 {
-	reg->r64 = cnum64_cnum32_intersect(reg->r64, reg->r32);
+	s->r64 = cnum64_cnum32_intersect(s->r64, s->r32);
 }
 
-static void __reg_deduce_bounds(struct bpf_reg_state *reg)
+static void __scalar_deduce_bounds(struct scalar *s)
 {
-	deduce_bounds_32_from_64(reg);
-	deduce_bounds_64_from_32(reg);
+	deduce_bounds_32_from_64(s);
+	deduce_bounds_64_from_32(s);
 }
 
 /* Attempts to improve var_off based on unsigned min/max information */
-static void __reg_bound_offset(struct bpf_reg_state *reg)
+static void __scalar_bound_offset(struct scalar *s)
 {
-	struct tnum var64_off = tnum_intersect(reg->var_off,
-					       tnum_range(reg_umin(reg),
-							  reg_umax(reg)));
+	struct tnum var64_off = tnum_intersect(s->var_off,
+					       tnum_range(cnum64_umin(s->r64),
+							  cnum64_umax(s->r64)));
 	struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
-					       tnum_range(reg_u32_min(reg),
-							  reg_u32_max(reg)));
+					       tnum_range(cnum32_umin(s->r32),
+							  cnum32_umax(s->r32)));
 	u32 trailing_zero_bits;
-	u16 base = reg->base;
-	u16 step = reg->step;
+	u16 base = s->base;
+	u16 step = s->step;
 
-	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
+	s->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
 
 	if (base == 0)
 		trailing_zero_bits = count_trailing_zeros(step);
 	else
 		trailing_zero_bits = min(count_trailing_zeros(base),
 					 count_trailing_zeros(step));
-	reg->var_off = tnum_and(reg->var_off, tnum_const(~0ULL << trailing_zero_bits));
+	s->var_off = tnum_and(s->var_off, tnum_const(~0ULL << trailing_zero_bits));
 }
 
-static void __update_bounds_from_step(struct bpf_reg_state *reg)
+static void __update_bounds_from_step(struct scalar *s)
 {
-	reg->r64 = cnum64_intersect_linear(reg->r64, reg->base, reg->step);
-	deduce_bounds_32_from_64(reg);
+	s->r64 = cnum64_intersect_linear(s->r64, s->base, s->step);
+	deduce_bounds_32_from_64(s);
 }
 
-static bool range_bounds_violation(struct bpf_reg_state *reg);
+static bool range_bounds_violation(const struct scalar *s);
 
-static void reg_bounds_sync(struct bpf_reg_state *reg)
+static void scalar_bounds_sync(struct scalar *s)
 {
 	/* If the input reg_state is invalid, we can exit early */
-	if (range_bounds_violation(reg))
+	if (range_bounds_violation(s))
 		return;
 	/* We might have learned new bounds from the var_off. */
-	__update_reg_bounds(reg);
+	__update_scalar_bounds(s);
 	/* We might have learned something about the sign bit. */
-	__reg_deduce_bounds(reg);
-	__reg_deduce_bounds(reg);
+	__scalar_deduce_bounds(s);
+	__scalar_deduce_bounds(s);
 	/* We might have learned some bits from the bounds. */
-	__reg_bound_offset(reg);
+	__scalar_bound_offset(s);
 	/* Intersecting with the old var_off might have improved our bounds
 	 * slightly, e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
 	 * then new var_off is (0; 0x7f...fc) which improves our umax.
 	 */
-	__update_reg_bounds(reg);
+	__update_scalar_bounds(s);
 	/*
 	 * Both tnum and base+step define a sequence of points,
 	 * potentially w/o intersection, or intersecting after N
 	 * tnum_step()'s, where N can be large. On the other hand,
 	 * step+base *must* be in sync with r64 in order for
 	 * array traversal logic starting at reg_smin() to be sound.
-	 * Hence, place this as a final step in the reg_bounds_sync().
+	 * Hence, place this as a final step in the scalar_bounds_sync().
 	 */
-	__update_bounds_from_step(reg);
+	__update_bounds_from_step(s);
+}
+
+static void reg_bounds_sync(struct bpf_reg_state *reg)
+{
+	scalar_bounds_sync(scalar_of(reg));
 }
 
-static bool const_tnum_range_mismatch(struct bpf_reg_state *reg)
+static bool const_tnum_range_mismatch(const struct scalar *s)
 {
-	if (!tnum_is_const(reg->var_off))
+	if (!tnum_is_const(s->var_off))
 		return false;
 
-	return !cnum64_is_const(reg->r64) || reg->r64.base != reg->var_off.value;
+	return !cnum64_is_const(s->r64) || s->r64.base != s->var_off.value;
 }
 
-static bool const_tnum_range_mismatch_32(struct bpf_reg_state *reg)
+static bool const_tnum_range_mismatch_32(const struct scalar *s)
 {
-	if (!tnum_subreg_is_const(reg->var_off))
+	if (!tnum_subreg_is_const(s->var_off))
 		return false;
 
-	return !cnum32_is_const(reg->r32) || reg->r32.base != tnum_subreg(reg->var_off).value;
+	return !cnum32_is_const(s->r32) || s->r32.base != tnum_subreg(s->var_off).value;
 }
 
-static bool range_bounds_violation(struct bpf_reg_state *reg)
+static bool range_bounds_violation(const struct scalar *s)
 {
-	return cnum32_is_empty(reg->r32) || cnum64_is_empty(reg->r64);
+	return cnum32_is_empty(s->r32) || cnum64_is_empty(s->r64);
 }
 
 /* Do @t and [min, max] overlap: is a member of @t in the range? */
@@ -2367,14 +2367,19 @@ static bool tnum_overlaps_cnum(struct tnum t, u64 base, u64 size, u64 ut_max)
  * A range and var_off don't overlap. reg_bounds_sync() compares var_off with umin and umax: it
  * doesn't see that [-2, 1], which crosses 0, has no member with 5 in its low three bits.
  */
-static bool reg_is_empty(struct bpf_reg_state *reg)
+static bool scalar_is_empty(const struct scalar *s)
 {
-	return range_bounds_violation(reg) ||
-	       !tnum_overlaps_cnum(reg->var_off, reg->r64.base, reg->r64.size, U64_MAX) ||
-	       !tnum_overlaps_cnum(tnum_subreg(reg->var_off), reg->r32.base, reg->r32.size,
+	return range_bounds_violation(s) ||
+	       !tnum_overlaps_cnum(s->var_off, s->r64.base, s->r64.size, U64_MAX) ||
+	       !tnum_overlaps_cnum(tnum_subreg(s->var_off), s->r32.base, s->r32.size,
 				   U32_MAX);
 }
 
+static bool reg_is_empty(const struct bpf_reg_state *reg)
+{
+	return scalar_is_empty(scalar_of(reg));
+}
+
 /*
  * var_off, r64, r32 and the line base + step * k are a product that reg_bounds_sync() doesn't
  * reduce to the end. The verifier can take an infeasible path with a register that has no value
@@ -2384,19 +2389,20 @@ static bool reg_is_empty(struct bpf_reg_state *reg)
 static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, const char *ctx)
 {
+	struct scalar *s = scalar_of(reg);
 	const char *msg;
 
-	if (range_bounds_violation(reg)) {
+	if (range_bounds_violation(s)) {
 		msg = "range bounds violation";
 		goto out;
 	}
 
-	if (const_tnum_range_mismatch(reg)) {
+	if (const_tnum_range_mismatch(s)) {
 		msg = "const tnum out of sync with range bounds";
 		goto out;
 	}
 
-	if (const_tnum_range_mismatch_32(reg)) {
+	if (const_tnum_range_mismatch_32(s)) {
 		msg = "const subreg tnum out of sync with range bounds";
 		goto out;
 	}
@@ -2417,8 +2423,8 @@ static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 		reg->base, reg->step);
 	if (env->test_reg_invariants)
 		return -EFAULT;
-	__mark_reg_unbounded(reg);
-	reg_step_reset(reg);
+	__mark_scalar_unbounded(s);
+	scalar_step_reset(s);
 	return 0;
 }
 
@@ -3631,17 +3637,21 @@ void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
 }
 
+static bool scalar_is_const(const struct scalar *s, bool subreg32)
+{
+	return tnum_is_const(subreg32 ? tnum_subreg(s->var_off) : s->var_off);
+}
+
 /* check if register is a constant scalar value */
 static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
 {
-	return reg->type == SCALAR_VALUE &&
-	       tnum_is_const(subreg32 ? tnum_subreg(reg->var_off) : reg->var_off);
+	return reg->type == SCALAR_VALUE && scalar_is_const(scalar_of(reg), subreg32);
 }
 
-/* assuming is_reg_const() is true, return constant value of a register */
-static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
+/* assuming scalar_is_const() is true, return the constant */
+static u64 scalar_const_value(const struct scalar *s, bool subreg32)
 {
-	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.value;
+	return subreg32 ? tnum_subreg(s->var_off).value : s->var_off.value;
 }
 
 static bool is_pointer_regtype(enum bpf_reg_type type)
@@ -4087,7 +4097,7 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				if (dst_regno < 0)
 					return 0;
 
-				/* coerce_reg_to_size will adjust the boundaries. */
+				/* coerce_scalar_to_size will adjust the boundaries. */
 				state->regs[dst_regno] = *reg;
 			} else {
 				int spill_cnt = 0, zero_cnt = 0;
@@ -6300,51 +6310,51 @@ void scalar_zext32(struct scalar *s)
 	s->r64 = cnum64_zext32(s->r32);
 }
 
-/* truncate register to smaller size (in bytes)
+/* truncate to smaller size (in bytes)
  * must be called with size < BPF_REG_SIZE
  */
-static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
+static void coerce_scalar_to_size(struct scalar *s, int size)
 {
 	u64 mask = (1ULL << (size * 8)) - 1;
 
-	scalar_step_check_unsigned(scalar_of(reg), size * 8);
+	scalar_step_check_unsigned(s, size * 8);
 
 	/* clear high bits in bit representation */
-	reg->var_off = tnum_cast(reg->var_off, size);
+	s->var_off = tnum_cast(s->var_off, size);
 
 	/* fix arithmetic bounds */
-	if ((reg_umin(reg) & ~mask) == (reg_umax(reg) & ~mask))
-		reg_set_urange64(reg, reg_umin(reg) & mask, reg_umax(reg) & mask);
+	if ((cnum64_umin(s->r64) & ~mask) == (cnum64_umax(s->r64) & ~mask))
+		s->r64 = cnum64_from_urange(cnum64_umin(s->r64) & mask, cnum64_umax(s->r64) & mask);
 	else
-		reg_set_urange64(reg, 0, mask);
+		s->r64 = cnum64_from_urange(0, mask);
 
 	/* If size is smaller than 32bit register the 32bit register
 	 * values are also truncated so we push 64-bit bounds into
 	 * 32-bit bounds. Above were truncated < 32-bits already.
 	 */
 	if (size < 4)
-		__mark_reg32_unbounded(reg);
+		__mark_scalar32_unbounded(s);
 
-	reg_bounds_sync(reg);
+	scalar_bounds_sync(s);
 }
 
-static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
+static void set_sext64_default_val(struct scalar *s, int size)
 {
 	if (size == 1) {
-		reg_set_srange64(reg, S8_MIN, S8_MAX);
-		reg_set_srange32(reg, S8_MIN, S8_MAX);
+		s->r64 = cnum64_from_srange(S8_MIN, S8_MAX);
+		s->r32 = cnum32_from_srange(S8_MIN, S8_MAX);
 	} else if (size == 2) {
-		reg_set_srange64(reg, S16_MIN, S16_MAX);
-		reg_set_srange32(reg, S16_MIN, S16_MAX);
+		s->r64 = cnum64_from_srange(S16_MIN, S16_MAX);
+		s->r32 = cnum32_from_srange(S16_MIN, S16_MAX);
 	} else {
 		/* size == 4 */
-		reg_set_srange64(reg, S32_MIN, S32_MAX);
-		reg_set_srange32(reg, S32_MIN, S32_MAX);
+		s->r64 = cnum64_from_srange(S32_MIN, S32_MAX);
+		s->r32 = cnum32_from_srange(S32_MIN, S32_MAX);
 	}
-	reg->var_off = tnum_unknown;
+	s->var_off = tnum_unknown;
 }
 
-static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
+static void coerce_scalar_to_size_sx(struct scalar *s, int size)
 {
 	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
 	u64 top_smax_value, top_smin_value;
@@ -6352,44 +6362,44 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 	s64 limit = 1LL << (num_bits - 1);
 
 	/* If every value fits the signed N-bit range sign extension is a noop. */
-	if (reg_smin(reg) >= -limit && reg_smax(reg) < limit)
+	if (cnum64_smin(s->r64) >= -limit && cnum64_smax(s->r64) < limit)
 		return;
 
 	/* See comment at scalar_step_check_unsigned(). */
-	reg_step_reset(reg);
+	scalar_step_reset(s);
 
-	if (tnum_is_const(reg->var_off)) {
-		u64_cval = reg->var_off.value;
+	if (tnum_is_const(s->var_off)) {
+		u64_cval = s->var_off.value;
 		if (size == 1)
-			reg->var_off = tnum_const((s8)u64_cval);
+			s->var_off = tnum_const((s8)u64_cval);
 		else if (size == 2)
-			reg->var_off = tnum_const((s16)u64_cval);
+			s->var_off = tnum_const((s16)u64_cval);
 		else
 			/* size == 4 */
-			reg->var_off = tnum_const((s32)u64_cval);
+			s->var_off = tnum_const((s32)u64_cval);
 
-		u64_cval = reg->var_off.value;
-		reg->r64 = cnum64_const(u64_cval);
-		reg->r32 = cnum32_const(u64_cval);
+		u64_cval = s->var_off.value;
+		s->r64 = cnum64_const(u64_cval);
+		s->r32 = cnum32_const(u64_cval);
 		return;
 	}
 
-	top_smax_value = ((u64)reg_smax(reg) >> num_bits) << num_bits;
-	top_smin_value = ((u64)reg_smin(reg) >> num_bits) << num_bits;
+	top_smax_value = ((u64)cnum64_smax(s->r64) >> num_bits) << num_bits;
+	top_smin_value = ((u64)cnum64_smin(s->r64) >> num_bits) << num_bits;
 
 	if (top_smax_value != top_smin_value)
 		goto out;
 
 	/* find the s64_min and s64_min after sign extension */
 	if (size == 1) {
-		init_s64_max = (s8)reg_smax(reg);
-		init_s64_min = (s8)reg_smin(reg);
+		init_s64_max = (s8)cnum64_smax(s->r64);
+		init_s64_min = (s8)cnum64_smin(s->r64);
 	} else if (size == 2) {
-		init_s64_max = (s16)reg_smax(reg);
-		init_s64_min = (s16)reg_smin(reg);
+		init_s64_max = (s16)cnum64_smax(s->r64);
+		init_s64_min = (s16)cnum64_smin(s->r64);
 	} else {
-		init_s64_max = (s32)reg_smax(reg);
-		init_s64_min = (s32)reg_smin(reg);
+		init_s64_max = (s32)cnum64_smax(s->r64);
+		init_s64_min = (s32)cnum64_smin(s->r64);
 	}
 
 	s64_max = max(init_s64_max, init_s64_min);
@@ -6397,27 +6407,27 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 
 	/* both of s64_max/s64_min positive or negative */
 	if ((s64_max >= 0) == (s64_min >= 0)) {
-		reg_set_srange64(reg, s64_min, s64_max);
-		reg_set_srange32(reg, s64_min, s64_max);
-		reg->var_off = tnum_range(s64_min, s64_max);
+		s->r64 = cnum64_from_srange(s64_min, s64_max);
+		s->r32 = cnum32_from_srange(s64_min, s64_max);
+		s->var_off = tnum_range(s64_min, s64_max);
 		return;
 	}
 
 out:
-	set_sext64_default_val(reg, size);
+	set_sext64_default_val(s, size);
 }
 
-static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
+static void set_sext32_default_val(struct scalar *s, int size)
 {
 	if (size == 1)
-		reg_set_srange32(reg, S8_MIN, S8_MAX);
+		s->r32 = cnum32_from_srange(S8_MIN, S8_MAX);
 	else
 		/* size == 2 */
-		reg_set_srange32(reg, S16_MIN, S16_MAX);
-	reg->var_off = tnum_subreg(tnum_unknown);
+		s->r32 = cnum32_from_srange(S16_MIN, S16_MAX);
+	s->var_off = tnum_subreg(tnum_unknown);
 }
 
-static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
+static void coerce_subreg_to_size_sx(struct scalar *s, int size)
 {
 	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
 	s32 field_smin, field_smax;
@@ -6437,54 +6447,54 @@ static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 	 * The range already fits the signed N-bit range, so (sN)v == v for every
 	 * value of the low 32 bits and the sign extension is a no-op.
 	 *
-	 * This has to precede reg_step_reset() below: the base/step line stays.
+	 * This has to precede scalar_step_reset() below: the base/step line stays.
 	 * It is about all 64 bits: scalar_zext32() in the caller discards it
 	 * if the upper 32 bits are not zero.
 	 */
-	if (reg_s32_min(reg) >= field_smin && reg_s32_max(reg) <= field_smax)
+	if (cnum32_smin(s->r32) >= field_smin && cnum32_smax(s->r32) <= field_smax)
 		return;
 
 	/* See comment at scalar_step_check_unsigned(). */
-	reg_step_reset(reg);
+	scalar_step_reset(s);
 
-	if (tnum_is_const(reg->var_off)) {
-		u32_val = reg->var_off.value;
+	if (tnum_is_const(s->var_off)) {
+		u32_val = s->var_off.value;
 		if (size == 1)
-			reg->var_off = tnum_const((s8)u32_val);
+			s->var_off = tnum_const((s8)u32_val);
 		else
-			reg->var_off = tnum_const((s16)u32_val);
+			s->var_off = tnum_const((s16)u32_val);
 
-		u32_val = reg->var_off.value;
-		reg_set_srange32(reg, u32_val, u32_val);
+		u32_val = s->var_off.value;
+		s->r32 = cnum32_from_srange(u32_val, u32_val);
 		return;
 	}
 
-	top_smax_value = ((u32)reg_s32_max(reg) >> num_bits) << num_bits;
-	top_smin_value = ((u32)reg_s32_min(reg) >> num_bits) << num_bits;
+	top_smax_value = ((u32)cnum32_smax(s->r32) >> num_bits) << num_bits;
+	top_smin_value = ((u32)cnum32_smin(s->r32) >> num_bits) << num_bits;
 
 	if (top_smax_value != top_smin_value)
 		goto out;
 
 	/* find the s32_min and s32_min after sign extension */
 	if (size == 1) {
-		init_s32_max = (s8)reg_s32_max(reg);
-		init_s32_min = (s8)reg_s32_min(reg);
+		init_s32_max = (s8)cnum32_smax(s->r32);
+		init_s32_min = (s8)cnum32_smin(s->r32);
 	} else {
 		/* size == 2 */
-		init_s32_max = (s16)reg_s32_max(reg);
-		init_s32_min = (s16)reg_s32_min(reg);
+		init_s32_max = (s16)cnum32_smax(s->r32);
+		init_s32_min = (s16)cnum32_smin(s->r32);
 	}
 	s32_max = max(init_s32_max, init_s32_min);
 	s32_min = min(init_s32_max, init_s32_min);
 
 	if ((s32_min >= 0) == (s32_max >= 0)) {
-		reg_set_srange32(reg, s32_min, s32_max);
-		reg->var_off = tnum_subreg(tnum_range(s32_min, s32_max));
+		s->r32 = cnum32_from_srange(s32_min, s32_max);
+		s->var_off = tnum_subreg(tnum_range(s32_min, s32_max));
 		return;
 	}
 
 out:
-	set_sext32_default_val(reg, size);
+	set_sext32_default_val(s, size);
 }
 
 bool bpf_map_is_rdonly(const struct bpf_map *map)
@@ -7654,9 +7664,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 	    regs[value_regno].type == SCALAR_VALUE) {
 		if (!is_ldsx) {
 			/* b/h/w load zero-extends, mark upper bits as known 0 */
-			coerce_reg_to_size(&regs[value_regno], size);
+			coerce_scalar_to_size(scalar_of(&regs[value_regno]), size);
 		} else {
-			coerce_reg_to_size_sx(&regs[value_regno], size);
+			coerce_scalar_to_size_sx(scalar_of(&regs[value_regno]), size);
 		}
 	}
 
@@ -16856,22 +16866,22 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 	return 0;
 }
 
-static void scalar_step_mul(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg)
+static void scalar_step_mul(struct scalar *dst, const struct scalar *src)
 {
-	if (tnum_is_const(src_reg->var_off))
-		scalar_step_scale(dst_reg, src_reg->var_off.value);
+	if (tnum_is_const(src->var_off))
+		scalar_step_scale(dst, src->var_off.value);
 	else
-		reg_step_reset(dst_reg);
+		scalar_step_reset(dst);
 }
 
-static void scalar_step_lsh(struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg)
+static void scalar_step_lsh(struct scalar *dst, const struct scalar *src)
 {
-	u64 amount = src_reg->var_off.value;
+	u64 amount = src->var_off.value;
 
-	if (tnum_is_const(src_reg->var_off) && amount < 64)
-		scalar_step_scale(dst_reg, 1ULL << amount);
+	if (tnum_is_const(src->var_off) && amount < 64)
+		scalar_step_scale(dst, 1ULL << amount);
 	else
-		reg_step_reset(dst_reg);
+		scalar_step_reset(dst);
 }
 
 /* Handles arithmetic on a pointer and a scalar: computes new min/max and var_off.
@@ -17031,7 +17041,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	 * speculative path: otherwise reg_bounds_sanity_check() might hit some
 	 * constraints violations.
 	 */
-	__mark_reg32_unbounded(dst_reg);
+	__mark_scalar32_unbounded(scalar_of(dst_reg));
 
 	switch (opcode) {
 	case BPF_ADD:
@@ -17109,7 +17119,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			if ((!known && smin_val < 0) || dst_reg->range < 0)
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
-		reg_step_reset(dst_reg);
+		scalar_step_reset(scalar_of(dst_reg));
 		break;
 	case BPF_AND:
 	case BPF_OR:
@@ -17159,7 +17169,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	 */
 	if (reg_is_pkt_pointer(dst_reg) &&
 	    (known || (opcode == BPF_SUB && dst_reg->range > 0))) {
-		__update_reg32_bounds(dst_reg);
+		__update_scalar32_bounds(scalar_of(dst_reg));
 	} else {
 		smax = reg_smax(dst_reg);
 		reg_bounds_sync(dst_reg);
@@ -17185,37 +17195,34 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 	return 0;
 }
 
-static void scalar32_min_max_sub(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
+static void scalar32_min_max_sub(struct scalar *dst, const struct scalar *src)
 {
-	dst_reg->r32 = cnum32_sub(dst_reg->r32, src_reg->r32);
+	dst->r32 = cnum32_sub(dst->r32, src->r32);
 }
 
-static void scalar_min_max_sub(struct bpf_reg_state *dst_reg,
-			       struct bpf_reg_state *src_reg)
+static void scalar_min_max_sub(struct scalar *dst, const struct scalar *src)
 {
-	dst_reg->r64 = cnum64_sub(dst_reg->r64, src_reg->r64);
+	dst->r64 = cnum64_sub(dst->r64, src->r64);
 }
 
-static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
+static void scalar32_min_max_mul(struct scalar *dst, const struct scalar *src)
 {
-	s32 smin = reg_s32_min(dst_reg);
-	s32 smax = reg_s32_max(dst_reg);
-	u32 umin = reg_u32_min(dst_reg);
-	u32 umax = reg_u32_max(dst_reg);
+	s32 smin = cnum32_smin(dst->r32);
+	s32 smax = cnum32_smax(dst->r32);
+	u32 umin = cnum32_umin(dst->r32);
+	u32 umax = cnum32_umax(dst->r32);
 	s32 tmp_prod[4];
 
-	if (check_mul_overflow(umax, reg_u32_max(src_reg), &umax) ||
-	    check_mul_overflow(umin, reg_u32_min(src_reg), &umin)) {
+	if (check_mul_overflow(umax, cnum32_umax(src->r32), &umax) ||
+	    check_mul_overflow(umin, cnum32_umin(src->r32), &umin)) {
 		/* Overflow possible, we know nothing */
 		umin = 0;
 		umax = U32_MAX;
 	}
-	if (check_mul_overflow(smin, reg_s32_min(src_reg), &tmp_prod[0]) ||
-	    check_mul_overflow(smin, reg_s32_max(src_reg), &tmp_prod[1]) ||
-	    check_mul_overflow(smax, reg_s32_min(src_reg), &tmp_prod[2]) ||
-	    check_mul_overflow(smax, reg_s32_max(src_reg), &tmp_prod[3])) {
+	if (check_mul_overflow(smin, cnum32_smin(src->r32), &tmp_prod[0]) ||
+	    check_mul_overflow(smin, cnum32_smax(src->r32), &tmp_prod[1]) ||
+	    check_mul_overflow(smax, cnum32_smin(src->r32), &tmp_prod[2]) ||
+	    check_mul_overflow(smax, cnum32_smax(src->r32), &tmp_prod[3])) {
 		/* Overflow possible, we know nothing */
 		smin = S32_MIN;
 		smax = S32_MAX;
@@ -17224,29 +17231,28 @@ static void scalar32_min_max_mul(struct bpf_reg_state *dst_reg,
 		smax = max_array(tmp_prod, 4);
 	}
 
-	dst_reg->r32 = cnum32_intersect(cnum32_from_urange(umin, umax),
-					cnum32_from_srange(smin, smax));
+	dst->r32 = cnum32_intersect(cnum32_from_urange(umin, umax),
+				    cnum32_from_srange(smin, smax));
 }
 
-static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
-			       struct bpf_reg_state *src_reg)
+static void scalar_min_max_mul(struct scalar *dst, const struct scalar *src)
 {
-	s64 smin = reg_smin(dst_reg);
-	s64 smax = reg_smax(dst_reg);
-	u64 umin = reg_umin(dst_reg);
-	u64 umax = reg_umax(dst_reg);
+	s64 smin = cnum64_smin(dst->r64);
+	s64 smax = cnum64_smax(dst->r64);
+	u64 umin = cnum64_umin(dst->r64);
+	u64 umax = cnum64_umax(dst->r64);
 	s64 tmp_prod[4];
 
-	if (check_mul_overflow(umax, reg_umax(src_reg), &umax) ||
-	    check_mul_overflow(umin, reg_umin(src_reg), &umin)) {
+	if (check_mul_overflow(umax, cnum64_umax(src->r64), &umax) ||
+	    check_mul_overflow(umin, cnum64_umin(src->r64), &umin)) {
 		/* Overflow possible, we know nothing */
 		umin = 0;
 		umax = U64_MAX;
 	}
-	if (check_mul_overflow(smin, reg_smin(src_reg), &tmp_prod[0]) ||
-	    check_mul_overflow(smin, reg_smax(src_reg), &tmp_prod[1]) ||
-	    check_mul_overflow(smax, reg_smin(src_reg), &tmp_prod[2]) ||
-	    check_mul_overflow(smax, reg_smax(src_reg), &tmp_prod[3])) {
+	if (check_mul_overflow(smin, cnum64_smin(src->r64), &tmp_prod[0]) ||
+	    check_mul_overflow(smin, cnum64_smax(src->r64), &tmp_prod[1]) ||
+	    check_mul_overflow(smax, cnum64_smin(src->r64), &tmp_prod[2]) ||
+	    check_mul_overflow(smax, cnum64_smax(src->r64), &tmp_prod[3])) {
 		/* Overflow possible, we know nothing */
 		smin = S64_MIN;
 		smax = S64_MAX;
@@ -17255,60 +17261,55 @@ static void scalar_min_max_mul(struct bpf_reg_state *dst_reg,
 		smax = max_array(tmp_prod, 4);
 	}
 
-	dst_reg->r64 = cnum64_intersect(cnum64_from_urange(umin, umax),
-					cnum64_from_srange(smin, smax));
+	dst->r64 = cnum64_intersect(cnum64_from_urange(umin, umax),
+				    cnum64_from_srange(smin, smax));
 }
 
-static void scalar_min_max_uhmul(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
+static void scalar_min_max_uhmul(struct scalar *dst, const struct scalar *src)
 {
-	u64 dst = reg_const_value(dst_reg, false);
-	u64 src = reg_const_value(src_reg, false);
+	u64 a = scalar_const_value(dst, false);
+	u64 b = scalar_const_value(src, false);
 
-	scalar_set_const(scalar_of(dst_reg), bpf_uhmul64(dst, src));
+	scalar_set_const(dst, bpf_uhmul64(a, b));
 }
 
-static void scalar_min_max_shmul(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
+static void scalar_min_max_shmul(struct scalar *dst, const struct scalar *src)
 {
-	s64 dst = reg_const_value(dst_reg, false);
-	s64 src = reg_const_value(src_reg, false);
+	s64 a = scalar_const_value(dst, false);
+	s64 b = scalar_const_value(src, false);
 
-	scalar_set_const(scalar_of(dst_reg), bpf_shmul64(dst, src));
+	scalar_set_const(dst, bpf_shmul64(a, b));
 }
 
-static void scalar32_min_max_udiv(struct bpf_reg_state *dst_reg,
-				  struct bpf_reg_state *src_reg)
+static void scalar32_min_max_udiv(struct scalar *dst, const struct scalar *src)
 {
-	u32 src_min = reg_u32_min(src_reg), src_max = reg_u32_max(src_reg); /* src_max isn't 0 */
+	u32 src_min = cnum32_umin(src->r32), src_max = cnum32_umax(src->r32); /* src_max isn't 0 */
 
 	/* The largest divisor gives the smallest result, but for x / 0 = 0 */
-	reg_set_urange32(dst_reg, src_min ? reg_u32_min(dst_reg) / src_max : 0,
-			 reg_u32_max(dst_reg) / (src_min ?: 1));
+	dst->r32 = cnum32_from_urange(src_min ? cnum32_umin(dst->r32) / src_max : 0,
+				      cnum32_umax(dst->r32) / (src_min ?: 1));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reset_reg64_and_tnum(dst_reg);
+	reset_scalar64_and_tnum(dst);
 }
 
-static void scalar_min_max_udiv(struct bpf_reg_state *dst_reg,
-				struct bpf_reg_state *src_reg)
+static void scalar_min_max_udiv(struct scalar *dst, const struct scalar *src)
 {
-	u64 src_min = reg_umin(src_reg), src_max = reg_umax(src_reg); /* src_max isn't 0 */
+	u64 src_min = cnum64_umin(src->r64), src_max = cnum64_umax(src->r64); /* src_max isn't 0 */
 
 	/* The largest divisor gives the smallest result, but for x / 0 = 0 */
-	reg_set_urange64(dst_reg, src_min ? div64_u64(reg_umin(dst_reg), src_max) : 0,
-			 div64_u64(reg_umax(dst_reg), src_min ?: 1));
+	dst->r64 = cnum64_from_urange(src_min ? div64_u64(cnum64_umin(dst->r64), src_max) : 0,
+				      div64_u64(cnum64_umax(dst->r64), src_min ?: 1));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reset_reg32_and_tnum(dst_reg);
+	reset_scalar32_and_tnum(dst);
 }
 
-static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
-				  struct bpf_reg_state *src_reg)
+static void scalar32_min_max_sdiv(struct scalar *dst, const struct scalar *src)
 {
-	s32 smin = reg_s32_min(dst_reg);
-	s32 smax = reg_s32_max(dst_reg);
-	s32 src_val = reg_s32_min(src_reg); /* non-zero, const divisor */
+	s32 smin = cnum32_smin(dst->r32);
+	s32 smax = cnum32_smax(dst->r32);
+	s32 src_val = cnum32_smin(src->r32); /* non-zero, const divisor */
 	s32 res1, res2;
 
 	/* BPF div specification: S32_MIN / -1 = S32_MIN */
@@ -17334,17 +17335,16 @@ static void scalar32_min_max_sdiv(struct bpf_reg_state *dst_reg,
 	smax = max(res1, res2);
 
 reset:
-	reg_set_srange32(dst_reg, smin, smax);
+	dst->r32 = cnum32_from_srange(smin, smax);
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reset_reg64_and_tnum(dst_reg);
+	reset_scalar64_and_tnum(dst);
 }
 
-static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
-				struct bpf_reg_state *src_reg)
+static void scalar_min_max_sdiv(struct scalar *dst, const struct scalar *src)
 {
-	s64 smin = reg_smin(dst_reg);
-	s64 smax = reg_smax(dst_reg);
-	s64 src_val = reg_smin(src_reg); /* non-zero, const divisor */
+	s64 smin = cnum64_smin(dst->r64);
+	s64 smax = cnum64_smax(dst->r64);
+	s64 src_val = cnum64_smin(src->r64); /* non-zero, const divisor */
 	s64 res1, res2;
 
 	/* BPF div specification: S64_MIN / -1 = S64_MIN */
@@ -17370,53 +17370,52 @@ static void scalar_min_max_sdiv(struct bpf_reg_state *dst_reg,
 	smax = max(res1, res2);
 
 reset:
-	reg_set_srange64(dst_reg, smin, smax);
+	dst->r64 = cnum64_from_srange(smin, smax);
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reset_reg32_and_tnum(dst_reg);
+	reset_scalar32_and_tnum(dst);
 }
 
-static void scalar32_min_max_umod(struct bpf_reg_state *dst_reg,
-				  struct bpf_reg_state *src_reg)
+static void scalar32_min_max_umod(struct scalar *dst, const struct scalar *src)
 {
-	u32 src_min = reg_u32_min(src_reg), src_max = reg_u32_max(src_reg); /* src_max isn't 0 */
+	u32 src_min = cnum32_umin(src->r32), src_max = cnum32_umax(src->r32); /* src_max isn't 0 */
 
 	/*
 	 * If dst_umax < src_min, the result remains unchanged.
 	 * e.g., [2, 5] % [10, 20] = [2, 5].
 	 */
-	if (reg_u32_max(dst_reg) < src_min)
+	if (cnum32_umax(dst->r32) < src_min)
 		return;
 
 	/* The result is below the divisor and not above x, and x % 0 = x */
-	reg_set_urange32(dst_reg, 0, min(reg_u32_max(dst_reg), src_min ? src_max - 1 : U32_MAX));
+	dst->r32 = cnum32_from_urange(0, min(cnum32_umax(dst->r32),
+					     src_min ? src_max - 1 : U32_MAX));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reset_reg64_and_tnum(dst_reg);
+	reset_scalar64_and_tnum(dst);
 }
 
-static void scalar_min_max_umod(struct bpf_reg_state *dst_reg,
-				struct bpf_reg_state *src_reg)
+static void scalar_min_max_umod(struct scalar *dst, const struct scalar *src)
 {
-	u64 src_min = reg_umin(src_reg), src_max = reg_umax(src_reg); /* src_max isn't 0 */
+	u64 src_min = cnum64_umin(src->r64), src_max = cnum64_umax(src->r64); /* src_max isn't 0 */
 
 	/*
 	 * If dst_umax < src_min, the result remains unchanged.
 	 * e.g., [2, 5] % [10, 20] = [2, 5].
 	 */
-	if (reg_umax(dst_reg) < src_min)
+	if (cnum64_umax(dst->r64) < src_min)
 		return;
 
 	/* The result is below the divisor and not above x, and x % 0 = x */
-	reg_set_urange64(dst_reg, 0, min(reg_umax(dst_reg), src_min ? src_max - 1 : U64_MAX));
+	dst->r64 = cnum64_from_urange(0, min(cnum64_umax(dst->r64),
+					     src_min ? src_max - 1 : U64_MAX));
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reset_reg32_and_tnum(dst_reg);
+	reset_scalar32_and_tnum(dst);
 }
 
-static void scalar32_min_max_smod(struct bpf_reg_state *dst_reg,
-				  struct bpf_reg_state *src_reg)
+static void scalar32_min_max_smod(struct scalar *dst, const struct scalar *src)
 {
-	s32 src_val = reg_s32_min(src_reg); /* non-zero, const divisor */
+	s32 src_val = cnum32_smin(src->r32); /* non-zero, const divisor */
 
 	/*
 	 * Safe absolute value calculation:
@@ -17436,26 +17435,25 @@ static void scalar32_min_max_smod(struct bpf_reg_state *dst_reg,
 	 * If the dividend is already within the result range,
 	 * the result remains unchanged. e.g., [-2, 5] % 10 = [-2, 5].
 	 */
-	if (reg_s32_min(dst_reg) >= -res_max_abs && reg_s32_max(dst_reg) <= res_max_abs)
+	if (cnum32_smin(dst->r32) >= -res_max_abs && cnum32_smax(dst->r32) <= res_max_abs)
 		return;
 
 	/* General case: result has the same sign as the dividend. */
-	if (reg_s32_min(dst_reg) >= 0) {
-		reg_set_srange32(dst_reg, 0, min(reg_s32_max(dst_reg), res_max_abs));
-	} else if (reg_s32_max(dst_reg) <= 0) {
-		reg_set_srange32(dst_reg, max(reg_s32_min(dst_reg), -res_max_abs), 0);
+	if (cnum32_smin(dst->r32) >= 0) {
+		dst->r32 = cnum32_from_srange(0, min(cnum32_smax(dst->r32), res_max_abs));
+	} else if (cnum32_smax(dst->r32) <= 0) {
+		dst->r32 = cnum32_from_srange(max(cnum32_smin(dst->r32), -res_max_abs), 0);
 	} else {
-		reg_set_srange32(dst_reg, -res_max_abs, res_max_abs);
+		dst->r32 = cnum32_from_srange(-res_max_abs, res_max_abs);
 	}
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reset_reg64_and_tnum(dst_reg);
+	reset_scalar64_and_tnum(dst);
 }
 
-static void scalar_min_max_smod(struct bpf_reg_state *dst_reg,
-				struct bpf_reg_state *src_reg)
+static void scalar_min_max_smod(struct scalar *dst, const struct scalar *src)
 {
-	s64 src_val = reg_smin(src_reg); /* non-zero, const divisor */
+	s64 src_val = cnum64_smin(src->r64); /* non-zero, const divisor */
 
 	/*
 	 * Safe absolute value calculation:
@@ -17475,178 +17473,164 @@ static void scalar_min_max_smod(struct bpf_reg_state *dst_reg,
 	 * If the dividend is already within the result range,
 	 * the result remains unchanged. e.g., [-2, 5] % 10 = [-2, 5].
 	 */
-	if (reg_smin(dst_reg) >= -res_max_abs && reg_smax(dst_reg) <= res_max_abs)
+	if (cnum64_smin(dst->r64) >= -res_max_abs && cnum64_smax(dst->r64) <= res_max_abs)
 		return;
 
 	/* General case: result has the same sign as the dividend. */
-	if (reg_smin(dst_reg) >= 0) {
-		reg_set_srange64(dst_reg, 0, min(reg_smax(dst_reg), res_max_abs));
-	} else if (reg_smax(dst_reg) <= 0) {
-		reg_set_srange64(dst_reg, max(reg_smin(dst_reg), -res_max_abs), 0);
+	if (cnum64_smin(dst->r64) >= 0) {
+		dst->r64 = cnum64_from_srange(0, min(cnum64_smax(dst->r64), res_max_abs));
+	} else if (cnum64_smax(dst->r64) <= 0) {
+		dst->r64 = cnum64_from_srange(max(cnum64_smin(dst->r64), -res_max_abs), 0);
 	} else {
-		reg_set_srange64(dst_reg, -res_max_abs, res_max_abs);
+		dst->r64 = cnum64_from_srange(-res_max_abs, res_max_abs);
 	}
 
 	/* Reset other ranges/tnum to unbounded/unknown. */
-	reset_reg32_and_tnum(dst_reg);
+	reset_scalar32_and_tnum(dst);
 }
 
-static void scalar32_min_max_and(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
+static void scalar32_min_max_and(struct scalar *dst, const struct scalar *src)
 {
-	bool src_known = tnum_subreg_is_const(src_reg->var_off);
-	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
-	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
-	u32 umax_val = reg_u32_max(src_reg);
+	bool src_known = tnum_subreg_is_const(src->var_off);
+	bool dst_known = tnum_subreg_is_const(dst->var_off);
+	struct tnum var32_off = tnum_subreg(dst->var_off);
+	u32 umax_val = cnum32_umax(src->r32);
 
 	if (src_known && dst_known) {
-		__mark_reg32_known(dst_reg, var32_off.value);
+		__mark_scalar32_known(dst, var32_off.value);
 		return;
 	}
 
 	/* We get our minimum from the var_off, since that's inherently
 	 * bitwise.  Our maximum is the minimum of the operands' maxima.
 	 */
-	reg_set_urange32(dst_reg,
-			 var32_off.value,
-			 min(reg_u32_max(dst_reg), umax_val));
+	dst->r32 = cnum32_from_urange(var32_off.value,
+				      min(cnum32_umax(dst->r32), umax_val));
 }
 
-static void scalar_min_max_and(struct bpf_reg_state *dst_reg,
-			       struct bpf_reg_state *src_reg)
+static void scalar_min_max_and(struct scalar *dst, const struct scalar *src)
 {
-	bool src_known = tnum_is_const(src_reg->var_off);
-	bool dst_known = tnum_is_const(dst_reg->var_off);
-	u64 umax_val = reg_umax(src_reg);
+	bool src_known = tnum_is_const(src->var_off);
+	bool dst_known = tnum_is_const(dst->var_off);
+	u64 umax_val = cnum64_umax(src->r64);
 
 	if (src_known && dst_known) {
-		__mark_reg_known(dst_reg, dst_reg->var_off.value);
+		scalar_set_const(dst, dst->var_off.value);
 		return;
 	}
 
 	/* We get our minimum from the var_off, since that's inherently
 	 * bitwise.  Our maximum is the minimum of the operands' maxima.
 	 */
-	reg_set_urange64(dst_reg,
-			 dst_reg->var_off.value,
-			 min(reg_umax(dst_reg), umax_val));
+	dst->r64 = cnum64_from_urange(dst->var_off.value,
+				      min(cnum64_umax(dst->r64), umax_val));
 
 	/* We may learn something more from the var_off */
-	__update_reg_bounds(dst_reg);
+	__update_scalar_bounds(dst);
 }
 
-static void scalar32_min_max_or(struct bpf_reg_state *dst_reg,
-				struct bpf_reg_state *src_reg)
+static void scalar32_min_max_or(struct scalar *dst, const struct scalar *src)
 {
-	bool src_known = tnum_subreg_is_const(src_reg->var_off);
-	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
-	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
-	u32 umin_val = reg_u32_min(src_reg);
+	bool src_known = tnum_subreg_is_const(src->var_off);
+	bool dst_known = tnum_subreg_is_const(dst->var_off);
+	struct tnum var32_off = tnum_subreg(dst->var_off);
+	u32 umin_val = cnum32_umin(src->r32);
 
 	if (src_known && dst_known) {
-		__mark_reg32_known(dst_reg, var32_off.value);
+		__mark_scalar32_known(dst, var32_off.value);
 		return;
 	}
 
 	/* We get our maximum from the var_off, and our minimum is the
 	 * maximum of the operands' minima
 	 */
-	reg_set_urange32(dst_reg,
-			 max(reg_u32_min(dst_reg), umin_val),
-			 var32_off.value | var32_off.mask);
+	dst->r32 = cnum32_from_urange(max(cnum32_umin(dst->r32), umin_val),
+				      var32_off.value | var32_off.mask);
 }
 
-static void scalar_min_max_or(struct bpf_reg_state *dst_reg,
-			      struct bpf_reg_state *src_reg)
+static void scalar_min_max_or(struct scalar *dst, const struct scalar *src)
 {
-	bool src_known = tnum_is_const(src_reg->var_off);
-	bool dst_known = tnum_is_const(dst_reg->var_off);
-	u64 umin_val = reg_umin(src_reg);
+	bool src_known = tnum_is_const(src->var_off);
+	bool dst_known = tnum_is_const(dst->var_off);
+	u64 umin_val = cnum64_umin(src->r64);
 
 	if (src_known && dst_known) {
-		__mark_reg_known(dst_reg, dst_reg->var_off.value);
+		scalar_set_const(dst, dst->var_off.value);
 		return;
 	}
 
 	/* We get our maximum from the var_off, and our minimum is the
 	 * maximum of the operands' minima
 	 */
-	reg_set_urange64(dst_reg,
-			 max(reg_umin(dst_reg), umin_val),
-			 dst_reg->var_off.value | dst_reg->var_off.mask);
+	dst->r64 = cnum64_from_urange(max(cnum64_umin(dst->r64), umin_val),
+				      dst->var_off.value | dst->var_off.mask);
 
 	/* We may learn something more from the var_off */
-	__update_reg_bounds(dst_reg);
+	__update_scalar_bounds(dst);
 }
 
-static void scalar32_min_max_xor(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
+static void scalar32_min_max_xor(struct scalar *dst, const struct scalar *src)
 {
-	bool src_known = tnum_subreg_is_const(src_reg->var_off);
-	bool dst_known = tnum_subreg_is_const(dst_reg->var_off);
-	struct tnum var32_off = tnum_subreg(dst_reg->var_off);
+	bool src_known = tnum_subreg_is_const(src->var_off);
+	bool dst_known = tnum_subreg_is_const(dst->var_off);
+	struct tnum var32_off = tnum_subreg(dst->var_off);
 
 	if (src_known && dst_known) {
-		__mark_reg32_known(dst_reg, var32_off.value);
+		__mark_scalar32_known(dst, var32_off.value);
 		return;
 	}
 
 	/* We get both minimum and maximum from the var32_off. */
-	reg_set_urange32(dst_reg, var32_off.value, var32_off.value | var32_off.mask);
+	dst->r32 = cnum32_from_urange(var32_off.value, var32_off.value | var32_off.mask);
 }
 
-static void scalar_min_max_xor(struct bpf_reg_state *dst_reg,
-			       struct bpf_reg_state *src_reg)
+static void scalar_min_max_xor(struct scalar *dst, const struct scalar *src)
 {
-	bool src_known = tnum_is_const(src_reg->var_off);
-	bool dst_known = tnum_is_const(dst_reg->var_off);
+	bool src_known = tnum_is_const(src->var_off);
+	bool dst_known = tnum_is_const(dst->var_off);
 
 	if (src_known && dst_known) {
-		/* dst_reg->var_off.value has been updated earlier */
-		__mark_reg_known(dst_reg, dst_reg->var_off.value);
+		/* dst->var_off.value has been updated earlier */
+		scalar_set_const(dst, dst->var_off.value);
 		return;
 	}
 
 	/* We get both minimum and maximum from the var_off. */
-	reg_set_urange64(dst_reg,
-			 dst_reg->var_off.value,
-			 dst_reg->var_off.value | dst_reg->var_off.mask);
+	dst->r64 = cnum64_from_urange(dst->var_off.value,
+				      dst->var_off.value | dst->var_off.mask);
 }
 
-static void __scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
-				   u64 umin_val, u64 umax_val)
+static void __scalar32_min_max_lsh(struct scalar *dst, u64 umin_val, u64 umax_val)
 {
 	/* If we might shift our top bit out, then we know nothing */
-	if (umax_val > 31 || reg_u32_max(dst_reg) > 1ULL << (31 - umax_val))
-		reg_set_urange32(dst_reg, 0, U32_MAX);
+	if (umax_val > 31 || cnum32_umax(dst->r32) > 1ULL << (31 - umax_val))
+		dst->r32 = cnum32_from_urange(0, U32_MAX);
 	else
 		/* We lose all sign bit information (except what we can pick
 		 * up from var_off)
 		 */
-		reg_set_urange32(dst_reg, reg_u32_min(dst_reg) << umin_val,
-				 reg_u32_max(dst_reg) << umax_val);
+		dst->r32 = cnum32_from_urange(cnum32_umin(dst->r32) << umin_val,
+					      cnum32_umax(dst->r32) << umax_val);
 }
 
-static void scalar32_min_max_lsh(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
+static void scalar32_min_max_lsh(struct scalar *dst, const struct scalar *src)
 {
-	u32 umax_val = reg_u32_max(src_reg);
-	u32 umin_val = reg_u32_min(src_reg);
+	u32 umax_val = cnum32_umax(src->r32);
+	u32 umin_val = cnum32_umin(src->r32);
 	/* u32 alu operation will zext upper bits */
-	struct tnum subreg = tnum_subreg(dst_reg->var_off);
+	struct tnum subreg = tnum_subreg(dst->var_off);
 
-	__scalar32_min_max_lsh(dst_reg, umin_val, umax_val);
-	dst_reg->var_off = tnum_subreg(tnum_lshift(subreg, umin_val));
+	__scalar32_min_max_lsh(dst, umin_val, umax_val);
+	dst->var_off = tnum_subreg(tnum_lshift(subreg, umin_val));
 	/* Not required but being careful mark reg64 bounds as unknown so
 	 * that we are forced to pick them up from tnum and zext later and
 	 * if some path skips this step we are still safe.
 	 */
-	__mark_reg64_unbounded(dst_reg);
-	__update_reg32_bounds(dst_reg);
+	__mark_scalar64_unbounded(dst);
+	__update_scalar32_bounds(dst);
 }
 
-static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
-				   u64 umin_val, u64 umax_val)
+static void __scalar64_min_max_lsh(struct scalar *dst, u64 umin_val, u64 umax_val)
 {
 	struct cnum64 u, s;
 
@@ -17656,139 +17640,134 @@ static void __scalar64_min_max_lsh(struct bpf_reg_state *dst_reg,
 	 * 32bits.
 	 */
 	if (umin_val == 32 && umax_val == 32)
-		s = cnum64_from_srange((s64)reg_s32_min(dst_reg) << 32,
-				       (s64)reg_s32_max(dst_reg) << 32);
+		s = cnum64_from_srange((s64)cnum32_smin(dst->r32) << 32,
+				       (s64)cnum32_smax(dst->r32) << 32);
 	else
 		s = CNUM64_UNBOUNDED;
 
 	/* If we might shift our top bit out, then we know nothing */
-	if (reg_umax(dst_reg) > 1ULL << (63 - umax_val))
+	if (cnum64_umax(dst->r64) > 1ULL << (63 - umax_val))
 		u = CNUM64_UNBOUNDED;
 	else
-		u = cnum64_from_urange(reg_umin(dst_reg) << umin_val,
-				       reg_umax(dst_reg) << umax_val);
+		u = cnum64_from_urange(cnum64_umin(dst->r64) << umin_val,
+				       cnum64_umax(dst->r64) << umax_val);
 
-	dst_reg->r64 = cnum64_intersect(u, s);
+	dst->r64 = cnum64_intersect(u, s);
 }
 
-static void scalar_min_max_lsh(struct bpf_reg_state *dst_reg,
-			       struct bpf_reg_state *src_reg)
+static void scalar_min_max_lsh(struct scalar *dst, const struct scalar *src)
 {
-	u64 umax_val = reg_umax(src_reg);
-	u64 umin_val = reg_umin(src_reg);
+	u64 umax_val = cnum64_umax(src->r64);
+	u64 umin_val = cnum64_umin(src->r64);
 
 	/* scalar64 calc uses 32bit unshifted bounds so must be called first */
-	__scalar64_min_max_lsh(dst_reg, umin_val, umax_val);
-	__scalar32_min_max_lsh(dst_reg, umin_val, umax_val);
+	__scalar64_min_max_lsh(dst, umin_val, umax_val);
+	__scalar32_min_max_lsh(dst, umin_val, umax_val);
 
-	dst_reg->var_off = tnum_lshift(dst_reg->var_off, umin_val);
+	dst->var_off = tnum_lshift(dst->var_off, umin_val);
 	/* We may learn something more from the var_off */
-	__update_reg_bounds(dst_reg);
+	__update_scalar_bounds(dst);
 }
 
-static void scalar32_min_max_rsh(struct bpf_reg_state *dst_reg,
-				 struct bpf_reg_state *src_reg)
+static void scalar32_min_max_rsh(struct scalar *dst, const struct scalar *src)
 {
-	struct tnum subreg = tnum_subreg(dst_reg->var_off);
-	u32 umax_val = reg_u32_max(src_reg);
-	u32 umin_val = reg_u32_min(src_reg);
+	struct tnum subreg = tnum_subreg(dst->var_off);
+	u32 umax_val = cnum32_umax(src->r32);
+	u32 umin_val = cnum32_umin(src->r32);
 
-	/* BPF_RSH is an unsigned shift.  If the value in dst_reg might
+	/* BPF_RSH is an unsigned shift.  If the value in dst might
 	 * be negative, then either:
-	 * 1) src_reg might be zero, so the sign bit of the result is
+	 * 1) src might be zero, so the sign bit of the result is
 	 *    unknown, so we lose our signed bounds
 	 * 2) it's known negative, thus the unsigned bounds capture the
 	 *    signed bounds
 	 * 3) the signed bounds cross zero, so they tell us nothing
 	 *    about the result
-	 * If the value in dst_reg is known nonnegative, then again the
+	 * If the value in dst is known nonnegative, then again the
 	 * unsigned bounds capture the signed bounds.
 	 * Thus, in all cases it suffices to blow away our signed bounds
 	 * and rely on inferring new ones from the unsigned bounds and
 	 * var_off of the result.
 	 */
 
-	dst_reg->var_off = tnum_rshift(subreg, umin_val);
-	reg_set_urange32(dst_reg, reg_u32_min(dst_reg) >> umax_val,
-			 reg_u32_max(dst_reg) >> umin_val);
+	dst->var_off = tnum_rshift(subreg, umin_val);
+	dst->r32 = cnum32_from_urange(cnum32_umin(dst->r32) >> umax_val,
+				      cnum32_umax(dst->r32) >> umin_val);
 
-	__mark_reg64_unbounded(dst_reg);
-	__update_reg32_bounds(dst_reg);
+	__mark_scalar64_unbounded(dst);
+	__update_scalar32_bounds(dst);
 }
 
-static void scalar_min_max_rsh(struct bpf_reg_state *dst_reg,
-			       struct bpf_reg_state *src_reg)
+static void scalar_min_max_rsh(struct scalar *dst, const struct scalar *src)
 {
-	u64 umax_val = reg_umax(src_reg);
-	u64 umin_val = reg_umin(src_reg);
+	u64 umax_val = cnum64_umax(src->r64);
+	u64 umin_val = cnum64_umin(src->r64);
 
-	/* BPF_RSH is an unsigned shift.  If the value in dst_reg might
+	/* BPF_RSH is an unsigned shift.  If the value in dst might
 	 * be negative, then either:
-	 * 1) src_reg might be zero, so the sign bit of the result is
+	 * 1) src might be zero, so the sign bit of the result is
 	 *    unknown, so we lose our signed bounds
 	 * 2) it's known negative, thus the unsigned bounds capture the
 	 *    signed bounds
 	 * 3) the signed bounds cross zero, so they tell us nothing
 	 *    about the result
-	 * If the value in dst_reg is known nonnegative, then again the
+	 * If the value in dst is known nonnegative, then again the
 	 * unsigned bounds capture the signed bounds.
 	 * Thus, in all cases it suffices to blow away our signed bounds
 	 * and rely on inferring new ones from the unsigned bounds and
 	 * var_off of the result.
 	 */
-	dst_reg->var_off = tnum_rshift(dst_reg->var_off, umin_val);
-	reg_set_urange64(dst_reg, reg_umin(dst_reg) >> umax_val,
-			 reg_umax(dst_reg) >> umin_val);
+	dst->var_off = tnum_rshift(dst->var_off, umin_val);
+	dst->r64 = cnum64_from_urange(cnum64_umin(dst->r64) >> umax_val,
+				      cnum64_umax(dst->r64) >> umin_val);
 
 	/* Its not easy to operate on alu32 bounds here because it depends
 	 * on bits being shifted in. Take easy way out and mark unbounded
 	 * so we can recalculate later from tnum.
 	 */
-	__mark_reg32_unbounded(dst_reg);
-	__update_reg_bounds(dst_reg);
+	__mark_scalar32_unbounded(dst);
+	__update_scalar_bounds(dst);
 }
 
-static void scalar32_min_max_arsh(struct bpf_reg_state *dst_reg,
-				  struct bpf_reg_state *src_reg)
+static void scalar32_min_max_arsh(struct scalar *dst, const struct scalar *src)
 {
-	u32 umin_val = reg_u32_min(src_reg), umax_val = reg_u32_max(src_reg);
-	s32 smin = reg_s32_min(dst_reg), smax = reg_s32_max(dst_reg);
+	u32 umin_val = cnum32_umin(src->r32), umax_val = cnum32_umax(src->r32);
+	s32 smin = cnum32_smin(dst->r32), smax = cnum32_smax(dst->r32);
 
 	/*
 	 * A larger count brings the result closer to 0, or to -1.
-	 * Blow away the dst_reg umin_value/umax_value and rely on
-	 * dst_reg var_off to refine the result.
+	 * Blow away the dst umin_value/umax_value and rely on
+	 * dst var_off to refine the result.
 	 */
-	reg_set_srange32(dst_reg, smin >> (smin < 0 ? umin_val : umax_val),
-			 smax >> (smax < 0 ? umax_val : umin_val));
+	dst->r32 = cnum32_from_srange(smin >> (smin < 0 ? umin_val : umax_val),
+				      smax >> (smax < 0 ? umax_val : umin_val));
 
-	dst_reg->var_off = tnum_arshift(tnum_subreg(dst_reg->var_off), umin_val, 32);
+	dst->var_off = tnum_arshift(tnum_subreg(dst->var_off), umin_val, 32);
 
-	__mark_reg64_unbounded(dst_reg);
-	__update_reg32_bounds(dst_reg);
+	__mark_scalar64_unbounded(dst);
+	__update_scalar32_bounds(dst);
 }
 
-static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
-				struct bpf_reg_state *src_reg)
+static void scalar_min_max_arsh(struct scalar *dst, const struct scalar *src)
 {
-	u64 umin_val = reg_umin(src_reg), umax_val = reg_umax(src_reg);
-	s64 smin = reg_smin(dst_reg), smax = reg_smax(dst_reg);
+	u64 umin_val = cnum64_umin(src->r64), umax_val = cnum64_umax(src->r64);
+	s64 smin = cnum64_smin(dst->r64), smax = cnum64_smax(dst->r64);
 
 	/* A larger count brings the result closer to 0, or to -1 */
-	reg_set_srange64(dst_reg, smin >> (smin < 0 ? umin_val : umax_val),
-			 smax >> (smax < 0 ? umax_val : umin_val));
+	dst->r64 = cnum64_from_srange(smin >> (smin < 0 ? umin_val : umax_val),
+				      smax >> (smax < 0 ? umax_val : umin_val));
 
-	dst_reg->var_off = tnum_arshift(dst_reg->var_off, umin_val, 64);
+	dst->var_off = tnum_arshift(dst->var_off, umin_val, 64);
 
 	/* Its not easy to operate on alu32 bounds here because it depends
 	 * on bits being shifted in from upper 32-bits. Take easy way out
 	 * and mark unbounded so we can recalculate later from tnum.
 	 */
-	__mark_reg32_unbounded(dst_reg);
-	__update_reg_bounds(dst_reg);
+	__mark_scalar32_unbounded(dst);
+	__update_scalar_bounds(dst);
 }
 
-static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *insn)
+static void scalar_byte_swap(struct scalar *dst, const struct bpf_insn *insn)
 {
 	/*
 	 * Byte swap operation - update var_off using tnum_bswap.
@@ -17814,38 +17793,38 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 
 	if (need_bswap) {
 		if (insn->imm == 16)
-			dst_reg->var_off = tnum_bswap16(dst_reg->var_off);
+			dst->var_off = tnum_bswap16(dst->var_off);
 		else if (insn->imm == 32)
-			dst_reg->var_off = tnum_bswap32(dst_reg->var_off);
+			dst->var_off = tnum_bswap32(dst->var_off);
 		else if (insn->imm == 64)
-			dst_reg->var_off = tnum_bswap64(dst_reg->var_off);
+			dst->var_off = tnum_bswap64(dst->var_off);
 		/*
 		 * Byteswap scrambles the range, so we must reset bounds.
 		 * Bounds will be re-derived from the new tnum later.
 		 */
-		__mark_reg_unbounded(dst_reg);
-		reg_step_reset(dst_reg);
+		__mark_scalar_unbounded(dst);
+		scalar_step_reset(dst);
 	}
 	/* For bswap16/32, truncate dst register to match the swapped size */
 	if (insn->imm == 16 || insn->imm == 32)
-		coerce_reg_to_size(dst_reg, insn->imm / 8);
+		coerce_scalar_to_size(dst, insn->imm / 8);
 }
 
-static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
-					     const struct bpf_reg_state *src_reg)
+static bool is_safe_to_compute_dst_reg_range(const struct bpf_insn *insn,
+					     const struct scalar *src)
 {
 	bool src_is_const = false;
 	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 
 	if (insn_bitness == 32) {
-		if (tnum_subreg_is_const(src_reg->var_off)
-		    && reg_s32_min(src_reg) == reg_s32_max(src_reg)
-		    && reg_u32_min(src_reg) == reg_u32_max(src_reg))
+		if (tnum_subreg_is_const(src->var_off)
+		    && cnum32_smin(src->r32) == cnum32_smax(src->r32)
+		    && cnum32_umin(src->r32) == cnum32_umax(src->r32))
 			src_is_const = true;
 	} else {
-		if (tnum_is_const(src_reg->var_off)
-		    && reg_smin(src_reg) == reg_smax(src_reg)
-		    && reg_umin(src_reg) == reg_umax(src_reg))
+		if (tnum_is_const(src->var_off)
+		    && cnum64_smin(src->r64) == cnum64_smax(src->r64)
+		    && cnum64_umin(src->r64) == cnum64_umax(src->r64))
 			src_is_const = true;
 	}
 
@@ -17872,17 +17851,17 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_LSH:
 	case BPF_RSH:
 	case BPF_ARSH:
-		return reg_umax(src_reg) < insn_bitness;
+		return cnum64_umax(src->r64) < insn_bitness;
 	default:
 		return false;
 	}
 }
 
 static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn *insn,
-				      struct bpf_reg_state *dst_reg, struct bpf_reg_state src_reg);
+				      struct bpf_reg_state *dst_reg, struct scalar src_val);
 
 static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			      struct bpf_reg_state *dst_reg, const struct bpf_reg_state *src_reg)
+			      struct bpf_reg_state *dst_reg, const struct scalar *src)
 {
 	struct bpf_verifier_state *branch;
 	struct bpf_reg_state *reg;
@@ -17901,8 +17880,8 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 
 	reg = &branch->frame[branch->curframe]->regs[insn->dst_reg];
 	if (alu32) {
-		__mark_reg32_known(reg, 0);
-		__mark_reg32_known(dst_reg, -1ull);
+		__mark_scalar32_known(scalar_of(reg), 0);
+		__mark_scalar32_known(scalar_of(dst_reg), -1ull);
 	} else {
 		__mark_reg_known(reg, 0);
 		__mark_reg_known(dst_reg, -1ull);
@@ -17912,7 +17891,7 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	 * like any other. At this insn the branch is a part of the state that is looked at:
 	 * it must not be compared with it.
 	 */
-	return adjust_scalar_min_max_vals(env, insn, reg, *src_reg);
+	return adjust_scalar_min_max_vals(env, insn, reg, *src);
 }
 
 /* WARNING: This function does calculations on 64-bit values, but the actual
@@ -17922,14 +17901,15 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_insn *insn,
 				      struct bpf_reg_state *dst_reg,
-				      struct bpf_reg_state src_reg)
+				      struct scalar src_val)
 {
+	struct scalar *dst = scalar_of(dst_reg), *src = &src_val, tmp;
 	u8 opcode = BPF_OP(insn->code);
 	s16 off = insn->off;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
-	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
+	if (!is_safe_to_compute_dst_reg_range(insn, src)) {
 		bpf_mark_reg_unknown(dst_reg);
 		return 0;
 	}
@@ -17942,8 +17922,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 
 	/* The count of a shift is a range: a bit of dst_reg can end up in more than one place */
 	if ((opcode == BPF_LSH || opcode == BPF_RSH || opcode == BPF_ARSH) &&
-	    reg_umin(&src_reg) != reg_umax(&src_reg))
-		dst_reg->var_off = tnum_unknown;
+	    cnum64_umin(src->r64) != cnum64_umax(src->r64))
+		dst->var_off = tnum_unknown;
 
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
 	 * There are two classes of instructions: The first class we track both
@@ -17961,21 +17941,21 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	 */
 	switch (opcode) {
 	case BPF_ADD:
-		scalar_add(scalar_of(dst_reg), scalar_of(dst_reg), scalar_of(&src_reg));
+		scalar_add(dst, dst, src);
 		break;
 	case BPF_SUB:
-		scalar32_min_max_sub(dst_reg, &src_reg);
-		scalar_min_max_sub(dst_reg, &src_reg);
-		dst_reg->var_off = tnum_sub(dst_reg->var_off, src_reg.var_off);
-		reg_step_reset(dst_reg);
+		scalar32_min_max_sub(dst, src);
+		scalar_min_max_sub(dst, src);
+		dst->var_off = tnum_sub(dst->var_off, src->var_off);
+		scalar_step_reset(dst);
 		break;
 	case BPF_NEG:
-		env->fake_reg[0] = *dst_reg;
-		__mark_reg_known(dst_reg, 0);
-		scalar32_min_max_sub(dst_reg, &env->fake_reg[0]);
-		scalar_min_max_sub(dst_reg, &env->fake_reg[0]);
-		dst_reg->var_off = tnum_neg(env->fake_reg[0].var_off);
-		reg_step_reset(dst_reg);
+		tmp = *dst;
+		scalar_set_const(dst, 0);
+		scalar32_min_max_sub(dst, &tmp);
+		scalar_min_max_sub(dst, &tmp);
+		dst->var_off = tnum_neg(tmp.var_off);
+		scalar_step_reset(dst);
 		break;
 	case BPF_MUL:
 		/*
@@ -17984,110 +17964,112 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		 * Ordinary low-half MUL continues to use the analysis below.
 		 */
 		if (bpf_insn_is_hmul(insn) &&
-		    (!is_reg_const(dst_reg, false) ||
-		     !is_reg_const(&src_reg, false))) {
+		    (!scalar_is_const(dst, false) ||
+		     !scalar_is_const(src, false))) {
 			bpf_mark_reg_unknown(dst_reg);
 			break;
 		}
 		if (!alu32 && insn->off == BPF_UHMUL) {
-			scalar_min_max_uhmul(dst_reg, &src_reg);
+			scalar_min_max_uhmul(dst, src);
 			break;
 		}
 		if (!alu32 && insn->off == BPF_SHMUL) {
-			scalar_min_max_shmul(dst_reg, &src_reg);
+			scalar_min_max_shmul(dst, src);
 			break;
 		}
-		scalar_step_mul(dst_reg, &src_reg);
-		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
-		scalar32_min_max_mul(dst_reg, &src_reg);
-		scalar_min_max_mul(dst_reg, &src_reg);
+		scalar_step_mul(dst, src);
+		dst->var_off = tnum_mul(dst->var_off, src->var_off);
+		scalar32_min_max_mul(dst, src);
+		scalar_min_max_mul(dst, src);
 		break;
 	case BPF_DIV:
 		/* BPF div specification: x / 0 = 0 */
-		if ((alu32 && reg_u32_max(&src_reg) == 0) || (!alu32 && reg_umax(&src_reg) == 0)) {
-			scalar_set_const(scalar_of(dst_reg), 0);
+		if ((alu32 && cnum32_umax(src->r32) == 0) ||
+		    (!alu32 && cnum64_umax(src->r64) == 0)) {
+			scalar_set_const(dst, 0);
 			break;
 		}
 		if (alu32)
 			if (off == 1)
-				scalar32_min_max_sdiv(dst_reg, &src_reg);
+				scalar32_min_max_sdiv(dst, src);
 			else
-				scalar32_min_max_udiv(dst_reg, &src_reg);
+				scalar32_min_max_udiv(dst, src);
 		else
 			if (off == 1)
-				scalar_min_max_sdiv(dst_reg, &src_reg);
+				scalar_min_max_sdiv(dst, src);
 			else
-				scalar_min_max_udiv(dst_reg, &src_reg);
-		reg_step_reset(dst_reg);
+				scalar_min_max_udiv(dst, src);
+		scalar_step_reset(dst);
 		break;
 	case BPF_MOD:
 		/* BPF mod specification: x % 0 = x */
-		if ((alu32 && reg_u32_max(&src_reg) == 0) || (!alu32 && reg_umax(&src_reg) == 0))
+		if ((alu32 && cnum32_umax(src->r32) == 0) ||
+		    (!alu32 && cnum64_umax(src->r64) == 0))
 			break;
 		if (alu32)
 			if (off == 1)
-				scalar32_min_max_smod(dst_reg, &src_reg);
+				scalar32_min_max_smod(dst, src);
 			else
-				scalar32_min_max_umod(dst_reg, &src_reg);
+				scalar32_min_max_umod(dst, src);
 		else
 			if (off == 1)
-				scalar_min_max_smod(dst_reg, &src_reg);
+				scalar_min_max_smod(dst, src);
 			else
-				scalar_min_max_umod(dst_reg, &src_reg);
-		reg_step_reset(dst_reg);
+				scalar_min_max_umod(dst, src);
+		scalar_step_reset(dst);
 		break;
 	case BPF_AND:
-		if (tnum_is_const(src_reg.var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg, &src_reg);
+		if (tnum_is_const(src->var_off)) {
+			ret = maybe_fork_scalars(env, insn, dst_reg, src);
 			if (ret)
 				return ret;
 		}
-		dst_reg->var_off = tnum_and(dst_reg->var_off, src_reg.var_off);
-		scalar32_min_max_and(dst_reg, &src_reg);
-		scalar_min_max_and(dst_reg, &src_reg);
-		reg_step_reset(dst_reg);
+		dst->var_off = tnum_and(dst->var_off, src->var_off);
+		scalar32_min_max_and(dst, src);
+		scalar_min_max_and(dst, src);
+		scalar_step_reset(dst);
 		break;
 	case BPF_OR:
-		if (tnum_is_const(src_reg.var_off)) {
-			ret = maybe_fork_scalars(env, insn, dst_reg, &src_reg);
+		if (tnum_is_const(src->var_off)) {
+			ret = maybe_fork_scalars(env, insn, dst_reg, src);
 			if (ret)
 				return ret;
 		}
-		dst_reg->var_off = tnum_or(dst_reg->var_off, src_reg.var_off);
-		scalar32_min_max_or(dst_reg, &src_reg);
-		scalar_min_max_or(dst_reg, &src_reg);
-		reg_step_reset(dst_reg);
+		dst->var_off = tnum_or(dst->var_off, src->var_off);
+		scalar32_min_max_or(dst, src);
+		scalar_min_max_or(dst, src);
+		scalar_step_reset(dst);
 		break;
 	case BPF_XOR:
-		dst_reg->var_off = tnum_xor(dst_reg->var_off, src_reg.var_off);
-		scalar32_min_max_xor(dst_reg, &src_reg);
-		scalar_min_max_xor(dst_reg, &src_reg);
-		reg_step_reset(dst_reg);
+		dst->var_off = tnum_xor(dst->var_off, src->var_off);
+		scalar32_min_max_xor(dst, src);
+		scalar_min_max_xor(dst, src);
+		scalar_step_reset(dst);
 		break;
 	case BPF_LSH:
-		scalar_step_lsh(dst_reg, &src_reg);
+		scalar_step_lsh(dst, src);
 		if (alu32)
-			scalar32_min_max_lsh(dst_reg, &src_reg);
+			scalar32_min_max_lsh(dst, src);
 		else
-			scalar_min_max_lsh(dst_reg, &src_reg);
+			scalar_min_max_lsh(dst, src);
 		break;
 	case BPF_RSH:
 		if (alu32)
-			scalar32_min_max_rsh(dst_reg, &src_reg);
+			scalar32_min_max_rsh(dst, src);
 		else
-			scalar_min_max_rsh(dst_reg, &src_reg);
-		reg_step_reset(dst_reg);
+			scalar_min_max_rsh(dst, src);
+		scalar_step_reset(dst);
 		break;
 	case BPF_ARSH:
 		if (alu32)
-			scalar32_min_max_arsh(dst_reg, &src_reg);
+			scalar32_min_max_arsh(dst, src);
 		else
-			scalar_min_max_arsh(dst_reg, &src_reg);
-		reg_step_reset(dst_reg);
+			scalar_min_max_arsh(dst, src);
+		scalar_step_reset(dst);
 		break;
 	case BPF_END:
-		scalar_byte_swap(dst_reg, insn);
-		reg_step_reset(dst_reg);
+		scalar_byte_swap(dst, insn);
+		scalar_step_reset(dst);
 		break;
 	default:
 		break;
@@ -18103,8 +18085,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	 * but we should not zero extend the result.
 	 */
 	if (alu32 && opcode != BPF_END)
-		scalar_zext32(scalar_of(dst_reg));
-	reg_bounds_sync(dst_reg);
+		scalar_zext32(dst);
+	scalar_bounds_sync(dst);
 	return 0;
 }
 
@@ -18226,7 +18208,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 		verbose(env, "verifier internal error: no src_reg\n");
 		return -EFAULT;
 	}
-	return adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
+	return adjust_scalar_min_max_vals(env, insn, dst_reg, *scalar_of(src_reg));
 }
 
 /*
@@ -18314,7 +18296,7 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
 }
 
 /*
- * @reg is what @old became after a trip around a cycle, @old included. The end
+ * @s is what @old became after a trip around a cycle, @old included. The end
  * of the range that moved is going to move again. Put it where it may come
  * to rest. There are few such places, so this is done a few times at most.
  * @rungs: where the jumps of the loop stop it, if they do.
@@ -18323,29 +18305,29 @@ bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_re
  * @linear: every iteration adds a constant to it, in that many bits. Then nothing but a jump
  * stops it. If there is none ahead it goes on until it wraps, and is any number of that many bits.
  */
-void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old,
-			 const struct bpf_loop_rungs *rungs, int linear)
+void scalar_widen(struct scalar *s, const struct scalar *old,
+		  const struct bpf_loop_rungs *rungs, int linear)
 {
-	bool moved = reg->r64.base != old->r64.base || reg->r64.size != old->r64.size ||
-		     reg->r32.base != old->r32.base || reg->r32.size != old->r32.size;
-	s64 min = reg_smin(reg), max = reg_smax(reg), stop;
+	bool moved = s->r64.base != old->r64.base || s->r64.size != old->r64.size ||
+		     s->r32.base != old->r32.base || s->r32.size != old->r32.size;
+	s64 min = cnum64_smin(s->r64), max = cnum64_smax(s->r64), stop;
 
 	/* Only the step got weaker. It comes to rest without help, see below. */
-	if (!moved && reg->var_off.value == old->var_off.value &&
-	    reg->var_off.mask == old->var_off.mask)
+	if (!moved && s->var_off.value == old->var_off.value &&
+	    s->var_off.mask == old->var_off.mask)
 		return;
 
 	if (linear &&
-	    ((max > reg_smax(old) && !(rungs && rungs->has_max && max <= rungs->max[1])) ||
-	     (min < reg_smin(old) && !(rungs && rungs->has_min && min >= rungs->min[1])))) {
+	    ((max > cnum64_smax(old->r64) && !(rungs && rungs->has_max && max <= rungs->max[1])) ||
+	     (min < cnum64_smin(old->r64) && !(rungs && rungs->has_min && min >= rungs->min[1])))) {
 		if (linear == 64 || min < 0 || max > U32_MAX) {
-			scalar_set_unknown(scalar_of(reg));
+			scalar_set_unknown(s);
 			return;
 		}
 		min = 0;
 		max = U32_MAX;
 	}
-	if (max > reg_smax(old)) {
+	if (max > cnum64_smax(old->r64)) {
 		stop = max <= 0 ? 0 :
 		       max <= S32_MAX ? S32_MAX :
 		       max <= U32_MAX ? U32_MAX : S64_MAX;
@@ -18353,7 +18335,7 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 			stop = min(stop, max <= rungs->max[0] ? rungs->max[0] : rungs->max[1]);
 		max = stop;
 	}
-	if (min < reg_smin(old)) {
+	if (min < cnum64_smin(old->r64)) {
 		stop = min >= 0 ? 0 :
 		       min >= S32_MIN ? S32_MIN : S64_MIN;
 		if (rungs && rungs->has_min && min >= rungs->min[1])
@@ -18361,7 +18343,7 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 		min = stop;
 	}
 	if (min == S64_MIN && max == S64_MAX) {
-		scalar_set_unknown(scalar_of(reg));
+		scalar_set_unknown(s);
 		return;
 	}
 	/*
@@ -18371,22 +18353,23 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 	 *	sum += a[i]; if (sum == 77) ...
 	 * It wraps in the next pass, and the other bound is gone as well.
 	 */
-	if ((max == S64_MAX && (reg_smax(old) == S32_MAX || reg_smax(old) == U32_MAX)) ||
-	    (min == S64_MIN && reg_smin(old) == S32_MIN)) {
-		scalar_set_unknown(scalar_of(reg));
+	if ((max == S64_MAX &&
+	     (cnum64_smax(old->r64) == S32_MAX || cnum64_smax(old->r64) == U32_MAX)) ||
+	    (min == S64_MIN && cnum64_smin(old->r64) == S32_MIN)) {
+		scalar_set_unknown(s);
 		return;
 	}
-	/* every part has to include what it did before, hence no reg_bounds_sync() */
-	reg->r64 = cnum64_union(reg->r64, cnum64_from_srange(min, max));
+	/* every part has to include what it did before, hence no scalar_bounds_sync() */
+	s->r64 = cnum64_union(s->r64, cnum64_from_srange(min, max));
 	if (min >= 0 && max <= U32_MAX) {
-		reg->r32 = cnum32_union(reg->r32, cnum32_from_urange(min, max));
-		reg->var_off = tnum_union(reg->var_off, tnum_range(min, max));
+		s->r32 = cnum32_union(s->r32, cnum32_from_urange(min, max));
+		s->var_off = tnum_union(s->var_off, tnum_range(min, max));
 	} else if (min >= S32_MIN && max <= S32_MAX) {
-		reg->r32 = cnum32_union(reg->r32, cnum32_from_srange(min, max));
-		reg->var_off = tnum_unknown;
+		s->r32 = cnum32_union(s->r32, cnum32_from_srange(min, max));
+		s->var_off = tnum_unknown;
 	} else {
-		reg->r32 = CNUM32_UNBOUNDED;
-		reg->var_off = min >= 0 ? tnum_union(reg->var_off, tnum_range(min, max))
+		s->r32 = CNUM32_UNBOUNDED;
+		s->var_off = min >= 0 ? tnum_union(s->var_off, tnum_range(min, max))
 					: tnum_unknown;
 	}
 	/*
@@ -18396,7 +18379,7 @@ void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *
 	 * counts on "a multiple of 4".
 	 */
 	if (moved)
-		reg_step_reset(reg);
+		scalar_step_reset(s);
 }
 
 void scalar_union(struct scalar *acc, const struct scalar *src)
@@ -18446,7 +18429,7 @@ int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
 	step = gcd(acc->step, src->step);
 	base = acc->base % step;
 	if (base != src->base % step) {
-		reg_step_reset(acc);
+		scalar_step_reset(scalar_of(acc));
 	} else {
 		acc->base = base;
 		acc->step = step;
@@ -18526,7 +18509,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 			err = err ?: adjust_scalar_min_max_vals(env, insn,
 							 &regs[insn->dst_reg],
-							 regs[insn->dst_reg]);
+							 *scalar_of(&regs[insn->dst_reg]));
 		} else {
 			err = check_reg_arg(env, insn->dst_reg, DST_OP);
 		}
@@ -18578,7 +18561,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						return -EACCES;
 					} else if (src_reg->type == SCALAR_VALUE) {
 						*dst_reg = *src_reg;
-						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
+						coerce_scalar_to_size_sx(scalar_of(dst_reg),
+									 insn->off >> 3);
 					} else {
 						mark_reg_unknown(env, regs, insn->dst_reg);
 					}
@@ -18594,7 +18578,8 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 					*dst_reg = *src_reg;
 					/* case: W1 = (s8, s16)W2 */
 					if (insn->off)
-						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
+						coerce_subreg_to_size_sx(scalar_of(dst_reg),
+									 insn->off >> 3);
 				} else {
 					mark_reg_unknown(env, regs,
 							 insn->dst_reg);
@@ -18740,21 +18725,22 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 	}));
 }
 
-static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
-				u8 opcode, bool is_jmp32);
+static void scalars_refine_cond_op(struct scalar *a, struct scalar *b, u8 opcode, bool is_jmp32);
 /*
  * Learn more information about live branches by simulating refinement on both branches.
- * regs_refine_cond_op() is sound, so producing ill-formed register bounds for the branch means
+ * scalars_refine_cond_op() is sound, so producing ill-formed register bounds for the branch means
  * that branch is dead.
  */
 static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode, bool is_jmp32)
 {
 	/* Fallthrough (FALSE) branch */
-	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, bpf_rev_opcode(opcode), is_jmp32);
+	scalars_refine_cond_op(scalar_of(&env->false_reg1), scalar_of(&env->false_reg2),
+			       bpf_rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(&env->false_reg1);
 	reg_bounds_sync(&env->false_reg2);
 	/* Jump (TRUE) branch. If FALSE is dead refine_live_branch() takes these registers. */
-	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32);
+	scalars_refine_cond_op(scalar_of(&env->true_reg1), scalar_of(&env->true_reg2), opcode,
+			       is_jmp32);
 	reg_bounds_sync(&env->true_reg1);
 	reg_bounds_sync(&env->true_reg2);
 	/*
@@ -19035,7 +19021,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		/* If pointer is valid tests against zero will fail so we can
 		 * use this to direct branch taken.
 		 */
-		val = reg_const_value(reg2, is_jmp32);
+		val = scalar_const_value(scalar_of(reg2), is_jmp32);
 		if (val != 0)
 			return -1;
 
@@ -19078,9 +19064,8 @@ u8 bpf_rev_opcode(u8 opcode)
 	}
 }
 
-/* Refine range knowledge for <reg1> <op> <reg>2 conditional operation. */
-static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
-				u8 opcode, bool is_jmp32)
+/* Refine range knowledge for <a> <op> <b> conditional operation. */
+static void scalars_refine_cond_op(struct scalar *a, struct scalar *b, u8 opcode, bool is_jmp32)
 {
 	struct tnum t;
 	u64 val;
@@ -19092,7 +19077,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	case BPF_JSGE:
 	case BPF_JSGT:
 		opcode = bpf_flip_opcode(opcode);
-		swap(reg1, reg2);
+		swap(a, b);
 		break;
 	default:
 		break;
@@ -19101,44 +19086,44 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	switch (opcode) {
 	case BPF_JEQ:
 		if (is_jmp32) {
-			reg1->r32 = cnum32_intersect(reg1->r32, reg2->r32);
-			reg2->r32 = reg1->r32;
+			a->r32 = cnum32_intersect(a->r32, b->r32);
+			b->r32 = a->r32;
 
-			t = tnum_intersect(tnum_subreg(reg1->var_off), tnum_subreg(reg2->var_off));
-			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
-			reg2->var_off = tnum_with_subreg(reg2->var_off, t);
+			t = tnum_intersect(tnum_subreg(a->var_off), tnum_subreg(b->var_off));
+			a->var_off = tnum_with_subreg(a->var_off, t);
+			b->var_off = tnum_with_subreg(b->var_off, t);
 		} else {
-			reg1->r64 = cnum64_intersect(reg1->r64, reg2->r64);
-			reg2->r64 = reg1->r64;
+			a->r64 = cnum64_intersect(a->r64, b->r64);
+			b->r64 = a->r64;
 
-			reg1->var_off = tnum_intersect(reg1->var_off, reg2->var_off);
-			reg2->var_off = reg1->var_off;
+			a->var_off = tnum_intersect(a->var_off, b->var_off);
+			b->var_off = a->var_off;
 		}
 		break;
 	case BPF_JNE:
-		if (!is_reg_const(reg2, is_jmp32))
-			swap(reg1, reg2);
-		if (!is_reg_const(reg2, is_jmp32))
+		if (!scalar_is_const(b, is_jmp32))
+			swap(a, b);
+		if (!scalar_is_const(b, is_jmp32))
 			break;
 
-		/* try to recompute the bound of reg1 if reg2 is a const and
-		 * is exactly the edge of reg1.
+		/* try to recompute the bound of a if b is a const and
+		 * is exactly the edge of a.
 		 */
-		val = reg_const_value(reg2, is_jmp32);
+		val = scalar_const_value(b, is_jmp32);
 		if (is_jmp32) {
 			/* Complement of the range [val, val] as cnum32. */
-			cnum32_intersect_with(&reg1->r32, (struct cnum32){ val + 1, U32_MAX - 1 });
+			cnum32_intersect_with(&a->r32, (struct cnum32){ val + 1, U32_MAX - 1 });
 		} else {
 			/* Complement of the range [val, val] as cnum64. */
-			cnum64_intersect_with(&reg1->r64, (struct cnum64){ val + 1, U64_MAX - 1 });
+			cnum64_intersect_with(&a->r64, (struct cnum64){ val + 1, U64_MAX - 1 });
 		}
 		break;
 	case BPF_JSET:
-		if (!is_reg_const(reg2, is_jmp32))
-			swap(reg1, reg2);
-		if (!is_reg_const(reg2, is_jmp32))
+		if (!scalar_is_const(b, is_jmp32))
+			swap(a, b);
+		if (!scalar_is_const(b, is_jmp32))
 			break;
-		val = reg_const_value(reg2, is_jmp32);
+		val = scalar_const_value(b, is_jmp32);
 		/* BPF_JSET (i.e., TRUE branch, *not* BPF_JSET | BPF_X)
 		 * requires single bit to learn something useful. E.g., if we
 		 * know that `r1 & 0x3` is true, then which bits (0, 1, or both)
@@ -19152,64 +19137,64 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		if (hweight64(val) != 1)
 			break;
 		if (is_jmp32) {
-			t = tnum_or(tnum_subreg(reg1->var_off), tnum_const(val));
-			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
+			t = tnum_or(tnum_subreg(a->var_off), tnum_const(val));
+			a->var_off = tnum_with_subreg(a->var_off, t);
 		} else {
-			reg1->var_off = tnum_or(reg1->var_off, tnum_const(val));
+			a->var_off = tnum_or(a->var_off, tnum_const(val));
 		}
 		break;
 	case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see bpf_rev_opcode() */
-		if (!is_reg_const(reg2, is_jmp32))
-			swap(reg1, reg2);
-		if (!is_reg_const(reg2, is_jmp32))
+		if (!scalar_is_const(b, is_jmp32))
+			swap(a, b);
+		if (!scalar_is_const(b, is_jmp32))
 			break;
-		val = reg_const_value(reg2, is_jmp32);
+		val = scalar_const_value(b, is_jmp32);
 		/* Forget the ranges before narrowing tnums, to avoid invariant
 		 * violations if we're on a dead branch.
 		 */
-		__mark_reg_unbounded(reg1);
-		reg_step_reset(reg1);
+		__mark_scalar_unbounded(a);
+		scalar_step_reset(a);
 		if (is_jmp32) {
-			t = tnum_and(tnum_subreg(reg1->var_off), tnum_const(~val));
-			reg1->var_off = tnum_with_subreg(reg1->var_off, t);
+			t = tnum_and(tnum_subreg(a->var_off), tnum_const(~val));
+			a->var_off = tnum_with_subreg(a->var_off, t);
 		} else {
-			reg1->var_off = tnum_and(reg1->var_off, tnum_const(~val));
+			a->var_off = tnum_and(a->var_off, tnum_const(~val));
 		}
 		break;
 	case BPF_JLE:
 		if (is_jmp32) {
-			cnum32_intersect_with_urange(&reg1->r32, 0, reg_u32_max(reg2));
-			cnum32_intersect_with_urange(&reg2->r32, reg_u32_min(reg1), U32_MAX);
+			cnum32_intersect_with_urange(&a->r32, 0, cnum32_umax(b->r32));
+			cnum32_intersect_with_urange(&b->r32, cnum32_umin(a->r32), U32_MAX);
 		} else {
-			cnum64_intersect_with_urange(&reg1->r64, 0, reg_umax(reg2));
-			cnum64_intersect_with_urange(&reg2->r64, reg_umin(reg1), U64_MAX);
+			cnum64_intersect_with_urange(&a->r64, 0, cnum64_umax(b->r64));
+			cnum64_intersect_with_urange(&b->r64, cnum64_umin(a->r64), U64_MAX);
 		}
 		break;
 	case BPF_JLT:
 		if (is_jmp32) {
-			cnum32_intersect_with_urange(&reg1->r32, 0, reg_u32_max(reg2) - 1);
-			cnum32_intersect_with_urange(&reg2->r32, reg_u32_min(reg1) + 1, U32_MAX);
+			cnum32_intersect_with_urange(&a->r32, 0, cnum32_umax(b->r32) - 1);
+			cnum32_intersect_with_urange(&b->r32, cnum32_umin(a->r32) + 1, U32_MAX);
 		} else {
-			cnum64_intersect_with_urange(&reg1->r64, 0, reg_umax(reg2) - 1);
-			cnum64_intersect_with_urange(&reg2->r64, reg_umin(reg1) + 1, U64_MAX);
+			cnum64_intersect_with_urange(&a->r64, 0, cnum64_umax(b->r64) - 1);
+			cnum64_intersect_with_urange(&b->r64, cnum64_umin(a->r64) + 1, U64_MAX);
 		}
 		break;
 	case BPF_JSLE:
 		if (is_jmp32) {
-			cnum32_intersect_with_srange(&reg1->r32, S32_MIN, reg_s32_max(reg2));
-			cnum32_intersect_with_srange(&reg2->r32, reg_s32_min(reg1), S32_MAX);
+			cnum32_intersect_with_srange(&a->r32, S32_MIN, cnum32_smax(b->r32));
+			cnum32_intersect_with_srange(&b->r32, cnum32_smin(a->r32), S32_MAX);
 		} else {
-			cnum64_intersect_with_srange(&reg1->r64, S64_MIN, reg_smax(reg2));
-			cnum64_intersect_with_srange(&reg2->r64, reg_smin(reg1), S64_MAX);
+			cnum64_intersect_with_srange(&a->r64, S64_MIN, cnum64_smax(b->r64));
+			cnum64_intersect_with_srange(&b->r64, cnum64_smin(a->r64), S64_MAX);
 		}
 		break;
 	case BPF_JSLT:
 		if (is_jmp32) {
-			cnum32_intersect_with_srange(&reg1->r32, S32_MIN, reg_s32_max(reg2) - 1);
-			cnum32_intersect_with_srange(&reg2->r32, reg_s32_min(reg1) + 1, S32_MAX);
+			cnum32_intersect_with_srange(&a->r32, S32_MIN, cnum32_smax(b->r32) - 1);
+			cnum32_intersect_with_srange(&b->r32, cnum32_smin(a->r32) + 1, S32_MAX);
 		} else {
-			cnum64_intersect_with_srange(&reg1->r64, S64_MIN, reg_smax(reg2) - 1);
-			cnum64_intersect_with_srange(&reg2->r64, reg_smin(reg1) + 1, S64_MAX);
+			cnum64_intersect_with_srange(&a->r64, S64_MIN, cnum64_smax(b->r64) - 1);
+			cnum64_intersect_with_srange(&b->r64, cnum64_smin(a->r64) + 1, S64_MAX);
 		}
 		break;
 	default:
@@ -19394,15 +19379,14 @@ static bool try_match_pkt_pointers(const struct bpf_insn *insn,
 }
 
 /* a == b (mod 2^N) implies a == b if both fit in uN or both fit in sN. N is @bits. */
-static bool regs_fit_in_bits(const struct bpf_reg_state *a, const struct bpf_reg_state *b,
-			     u32 bits)
+static bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b, u32 bits)
 {
 	u64 umax = GENMASK_ULL(bits - 1, 0);
 	s64 smax = umax >> 1;
 
-	return (reg_umax(a) <= umax && reg_umax(b) <= umax) ||
-	       (reg_smin(a) >= -smax - 1 && reg_smax(a) <= smax &&
-		reg_smin(b) >= -smax - 1 && reg_smax(b) <= smax);
+	return (cnum64_umax(a->r64) <= umax && cnum64_umax(b->r64) <= umax) ||
+	       (cnum64_smin(a->r64) >= -smax - 1 && cnum64_smax(a->r64) <= smax &&
+		cnum64_smin(b->r64) >= -smax - 1 && cnum64_smax(b->r64) <= smax);
 }
 
 /*
@@ -19478,11 +19462,11 @@ static bool recompute_ptr(struct bpf_verifier_env *env, struct bpf_reg_state *ds
 	if (ptr_reg->type == SCALAR_VALUE || type_is_pkt_pointer(ptr_reg->type) ||
 	    !bpf_is_widenable_reg_type(ptr_reg))
 		return false;
-	__mark_reg32_unbounded(&sum);
+	__mark_scalar32_unbounded(scalar_of(&sum));
 	scalar_add(scalar_of(&sum), scalar_of(&sum), scalar_of(off_reg));
 	reg_bounds_sync(&sum);
-	if (reg_is_empty(&sum) || const_tnum_range_mismatch(&sum) ||
-	    const_tnum_range_mismatch_32(&sum))
+	if (reg_is_empty(&sum) || const_tnum_range_mismatch(scalar_of(&sum)) ||
+	    const_tnum_range_mismatch_32(scalar_of(&sum)))
 		return false;
 	/*
 	 * 'p += i' refuses a constant offset outside of this range, and a constant offset is put in
@@ -19542,7 +19526,7 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 				goto scratch;
 			continue;
 		}
-		if (regs_fit_in_bits(reg, &implied, bits))
+		if (scalars_fit_in_bits(scalar_of(reg), scalar_of(&implied), bits))
 			bits = 64;
 		if (bits < 32)
 			continue;
@@ -19555,12 +19539,12 @@ static void refine_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier
 		 * Equal in 64 bits is equal in the low 32 bits too. 'if w1 s> 200' on a zero
 		 * extended int refines nothing but the 32-bit range.
 		 */
-		regs_refine_cond_op(reg, &implied, BPF_JEQ, true);
+		scalars_refine_cond_op(scalar_of(reg), scalar_of(&implied), BPF_JEQ, true);
 		if (bits == 64)
-			regs_refine_cond_op(reg, &implied, BPF_JEQ, false);
+			scalars_refine_cond_op(scalar_of(reg), scalar_of(&implied), BPF_JEQ, false);
 		reg_bounds_sync(reg);
-		if (reg_is_empty(reg) || const_tnum_range_mismatch(reg) ||
-		    const_tnum_range_mismatch_32(reg)) {
+		if (reg_is_empty(reg) || const_tnum_range_mismatch(scalar_of(reg)) ||
+		    const_tnum_range_mismatch_32(scalar_of(reg))) {
 			*reg = saved;
 			continue;
 		}
diff --git a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
index 56c2412608a5..43578b93dfb5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scalar_ids.c
@@ -745,7 +745,7 @@ __naked void linked_regs_and_subreg_def(void)
 /*
  * A scalar is spilled to the stack and then filled twice: once via a
  * sign-extending load (BPF_MEMSX) into r4 and once via a zero-extending
- * load (BPF_MEM) into r5. coerce_reg_to_size_sx() gives r4 a different
+ * load (BPF_MEM) into r5. coerce_scalar_to_size_sx() gives r4 a different
  * value than the spilled/zero-extended siblings, so r4 must not keep the
  * shared scalar id. Otherwise the later 'if r5 == 0x80000000' refines r4
  * through sync_linked_regs() to a known 0x80000000, while at runtime r4
-- 
2.55.0

