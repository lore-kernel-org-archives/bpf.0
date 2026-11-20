Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207882;
	b=hp3U7F35XGACeZmHJUtKEEJxbEJ+PeHa/6vVW8pY0UrSui5HyV6FlDCdwgdnJRY+NzC5
	 hZ+gXjtErENmzmHM77zhgJi05H5uS6wh0vdRgZ9xvXUz2qM++GL9CkvrAySuzdfoBuyVL
	 m1K1YUzHXWbgYoKFyitqnSgVpsMkp87klQ05ocbla9ljo4iUZQgrTjRbIBkFuRH8asKbU
	 Q5sN+mpUBFSJQzd3oFqOgA0SEURFqsRS8MO52u7u1FKcujDfBy1qfIdHaPv4R+L6DdETD
	 w3Vg6bXR4aDBzR/MAZY9dlpGz6Rv37lg/lA7WwijiWGBpmJWSKM2YG0ua3/RLDwy0XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SxizU7LrsQysXu4crjAm3poxT7BtfKGXFFFt0NMw7LA=;
	b=0LEUQr++X+CE95NlKWLYq8jl2/Piz/1DRIwyI1fVhGhhOlNCNKkdbO93j57BYidJbykc
	 7A5mdqaTiIl0Af6SPvHNY2M+zEVnMxFIzwN3SWQn4iiMNX1sqPSXhuAvU0Xaxvih1W5hA
	 TjSLmP70JGjB2+MDNYlYu6lKRXHqgmWmqEipT96PcwTqUcubu8yWSk8LhYOaWLsM7HBlw
	 CjAevDmWFLLm+s5F6o2xJqPFBVeFE1QdSqGhYhqqjCiYxBzHmLmuPbR9pu8dM9LPsDg4h
	 si4e0LHDu6WChzbEzUHSJS/MORI3PCGqBWcOLkClLZvn6acjBkNWnKYOxjvVWAfbcdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YP034k+/";
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22D606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C22D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YP034k+/
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso724084a91.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207875; x=1795812675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxizU7LrsQysXu4crjAm3poxT7BtfKGXFFFt0NMw7LA=;
        b=YP034k+/PcGQ4hFaRxmmoxp43hnN6Ia3/yPPXizfS7Zy1HC/G5AZDLvr8ZoaEWaf1U
         Xvy1IkJgPjICITwJjZ9D6ymg4NL+DolPd/sMTzG4QzvG5c5Fn4VEDpq7Y7XfgaEpFEJJ
         H4Ar5y8aFRr8vgxt1tssLuuulKtK5xppK9fmPo+IQYw7fhv8CO4dGMwyCWkBnCSiffyO
         eA8qFODaQJiV3neG29aJNhPLST5ILb91/ujZAg55NaWMsx5fWxBSql+7cmmHplwtF4Gu
         YQyoPkBh+1GDangxa/E+3FwlOWAqNhB+wyhoPwxyiXWPcvnuD6QuKafQKDdSHljqlvVY
         fiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207875; x=1795812675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SxizU7LrsQysXu4crjAm3poxT7BtfKGXFFFt0NMw7LA=;
        b=jgq/F/gLC1c38rnyGQe9R7EUBv/HMqwENT+6lgkqbMn3OQOGrRnccQzBXajr9NR+6e
         ewsJQvpqoihGIgxCGeX9a2EKWh5nYeShqZ8wZnmXV99t/y4vsm73+Gfkw0ffsN4gSVrA
         5D/0ReXhghfhmsKvhvpNiXBS39536q6R6jRjcaSz07EgUCO0OS8L1n6qIsY64ZdRWpIN
         mmpggOg7rQTU9Xux9UGBydEFFyQfqRn2qZz+reY8SI3fz0jU0wiL0hDDBmcPkWE9cgzU
         q4mHyMv6gK1REpwKx6rhUVy9B3CH/hWvRoe0jTsilEq+oShVn2s1tLbBpt0wNv3wQ4Mv
         OXxQ==
X-Gm-Message-State: APuU4Z+ZvDcA7uNGEn4KbxT7TECF1ktAzUrC7EN1yD52OtsNGh1sKOxl
	W0wCKaAlYjEmuPXNOiCWjPhltw6JLr0vKYKEiJdXEcr3kC8Ko6O+7onFJZW92Q==
X-Gm-Gg: AZFdTZc93ee+J69Md539cIwm4ZcsGZCmiuXnlbtYRNWsBvXg0/kgJsOa2GvLYZJfZG9
	TcQa7VrJtVCPgbHnucPMUZ2YqJZO2qwpXkLND68u16Qe2U34H8A8tzbOHB9Iv67enTnUZUrvUJ0
	l6yoxaUJhaTO6Af4qt4slhkVSfuNiWzkER/A2KwGoBHuHGo4kZbladLGNspkkMGrpzBvD3orthT
	VJVurGIXaDwD/7CypO7/ugErqnkBn9ajedAN1TtK/aNa+CjZJRswuxtkxTfBCFfcbHPAnhK+Ww1
	p8wwuNChMjiNNrZ0HdnEK+POZdMrmK2ilJoQWc0GYzTbcGlcrYOieFr9dyLT2RisNmtS49V8/FX
	YZ2iWtFq2YMN0J1ntclZVksZ/YtynJW8zasR2e66BcsoyuX1S6zPTo970Up8h9RsM2feVVB2n8s
	mbT/dz8H6anZAzbEy8pWhSmC2+a05nVeoo5To/BOzEtGSJ7C6ASDQIySwE/AMenfYluJoh1M49t
	eCx0gWap1b2me/OIFoAMdLezI2Mh0emYUJc8M9y3LIjhptRGk60xUESV/aMWpCIb1758IOcjyBX
	D1ETXpKHmNStCeKrjZVjYK9/vT7LZKi+ammKdoBRj7dnLbPuftJnHVx+kpFLwzCbflObjFOYxPf
	48jqHLzWT/l30D4RRb4b3cSyRWBiPRDOh9/qZ9l6cBKO6NndNXotSBSZHCGa6MYKG1ATGGxzwAw
	==
X-Received: by 2002:a17:90b:4a48:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3b41c7b60b5mr4032996a91.6.1795207874506;
        Fri, 20 Nov 2026 12:51:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm8760605a91.10.2026.11.20.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:51:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 12/49] bpf: Keep more of what is known about a number
Date: Fri, 20 Nov 2026 20:49:20 +0000
Message-ID: <20261120204959.614908-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

Six transfer functions lose what is known. Scalar evolution hid a part
of that: it had expressions for extensions and for partial spills. Fix
the functions.

1. An AND that clears no bit is a move: the old ranges hold too. If the
   AND splits the state, the step goes away, and a part that has no
   value gets only the new ranges.
     r0 = 1..16; w0 &= 255             was 0..16, now 1..16

2. A sign extension does not change the low bits. The other bits are
   copies of the sign. If the low 32 bits fit, they give the range.
     w6 = -100..100; r7 = (s32)r6      was any s32, now -100..100

3. A fill can be larger than the spill. On little endian the low bytes
   are from the spill.
     *(u32 *)(r10 - 8) = 5; r1 = *(u64 *)(r10 - 8)      w1 is 5

4. A write above the low bytes of a spill does not change them. Keep
   them as a narrow spill. Zero bytes next to it stay zero.
     struct { u32 i; u32 flag; } s; s.i = r6; s.flag = 1;

5. A range that crosses S64_MAX has no signed bounds. A later patch
   makes such ranges. The known bits can have signed bounds, so a signed
   shift takes the tighter ones.
     r7 = 0..0xf0 << 56; r7 s>>= 56    -128..112, not -128..127

6. A number can have a step: 0, 12, 24, ... The known bits tell only a
   power of two. A later patch counts a loop by the distance of the
   counter to its bound:

     for (i = 12 * a; i != 12 * b; i += 12)

     distance = i - 12 * b     ..., -24, -12, 0
     distance != 0             ..., -24, -12     with the step
                               ..., -2, -1       without it

   Without the step, 'i += 12' goes past the bound. Keep it:

     -3 * (3 * a + 1)          step 9: a negative factor
     3 * a + 6 * b             step 3: the gcd of the two steps
     step 3 and step 6         step 6: one is a multiple of the other

   As before, a result that can wrap has no step.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/verifier.c        | 142 +++++++++++++++++++++++------------
 2 files changed, 94 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 63c75a68c99..2efb9d61501 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2121,6 +2121,7 @@ void bpf_blur_far_offset(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax);
 void scalar_set_unknown(struct scalar *s);
 void scalar_set_const(struct scalar *s, u64 imm);
+void scalar_step_scale(struct scalar *dst, s64 amount);
 void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar *b);
 void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_insn *insn);
 bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 319b816ee77..d67f6d6780b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1901,44 +1901,39 @@ static void scalar_step_reset(struct scalar *s)
 
 static void scalar_step_add(struct scalar *dst, const struct scalar *a, const struct scalar *b)
 {
-	const struct scalar *reg;
 	s64 amount, tmp;
+	u16 step;
 
-	if (tnum_is_const(b->var_off)) {
-		reg = a;
-		amount = (s64)b->var_off.value;
-	} else if (tnum_is_const(a->var_off)) {
-		reg = b;
-		amount = (s64)a->var_off.value;
-	} else {
-		scalar_step_reset(dst);
-		return;
-	}
+	if (tnum_is_const(a->var_off) && !tnum_is_const(b->var_off))
+		swap(a, b);
+	/* b is d + k * step. A constant has no step. */
+	amount = tnum_is_const(b->var_off) ? b->var_off.value : b->base;
+	step = tnum_is_const(b->var_off) ? a->step : gcd(a->step, b->step);
 
 	/*
 	 * Let x be a possible signed value of the register,
-	 * d = amount, s = reg->step, and b = reg->base.
+	 * d = amount, s = step, and b = a->base mod s.
 	 * Then x mod s = b, with s > 0 and 0 <= b < s.
 	 * If the addition causes signed underflow, the resulting value
 	 * is x + d + 2**64.
 	 *
 	 * Taking the result modulo s and substituting x mod s = b gives:
 	 *   (x + d + 2**64) mod s = (b + d + (2**64 mod s)) mod s      (1)
-	 * Keeping reg->step = s and updating reg->base to (b + d) mod s
+	 * Keeping the step s and updating the base to (b + d) mod s
 	 * requires (1) to equal (b + d) mod s, which holds if and only
 	 * if 2**64 mod s = 0.
 	 * Signed overflow subtracts 2**64 and has the same requirement.
 	 *
 	 * Conservatively reset the stride if either wrap is possible.
 	 */
-	if (check_add_overflow(cnum64_smin(reg->r64), amount, &tmp) ||
-	    check_add_overflow(cnum64_smax(reg->r64), amount, &tmp)) {
+	if (step == 1 || check_add_overflow(cnum64_smin(a->r64), cnum64_smin(b->r64), &tmp) ||
+	    check_add_overflow(cnum64_smax(a->r64), cnum64_smax(b->r64), &tmp)) {
 		scalar_step_reset(dst);
 		return;
 	}
 
-	dst->base = (reg->base + imod(amount, reg->step)) % reg->step;
-	dst->step = reg->step;
+	dst->base = (a->base + imod(amount, step)) % step;
+	dst->step = step;
 }
 
 /*
@@ -1953,8 +1948,10 @@ void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar
 	dst->var_off = tnum_add(a->var_off, b->var_off);
 }
 
-static void scalar_step_scale(struct scalar *dst, u64 amount)
+/* The step of @dst * @amount. The ranges are those before the product. */
+void scalar_step_scale(struct scalar *dst, s64 amount)
 {
+	u64 factor = amount < 0 ? -(u64)amount : amount;
 	u16 step;
 	s64 tmp;
 
@@ -1973,18 +1970,17 @@ static void scalar_step_scale(struct scalar *dst, u64 amount)
 	 *
 	 * Conservatively reset the stride if a wrap is possible.
 	 */
-	if (amount == 0 || check_mul_overflow(dst->step, amount, &step) ||
-	    check_mul_overflow(cnum64_smin(dst->r64), (s64)amount, &tmp) ||
-	    check_mul_overflow(cnum64_smax(dst->r64), (s64)amount, &tmp)) {
+	if (amount == 0 || check_mul_overflow(dst->step, factor, &step) ||
+	    check_mul_overflow(cnum64_smin(dst->r64), amount, &tmp) ||
+	    check_mul_overflow(cnum64_smax(dst->r64), amount, &tmp)) {
 		scalar_step_reset(dst);
 		return;
 	}
 	/*
-	 * The above established that `step = dst->step * amount`
-	 * does not overflow, therefore the base < step invariant holds
-	 * after assignments below.
+	 * The above established that `step = dst->step * |amount|`
+	 * does not overflow. For d < 0 the same holds modulo s * -d.
 	 */
-	dst->base = dst->base * amount;
+	dst->base = imod(dst->base * amount, step);
 	dst->step = step;
 }
 
@@ -3716,11 +3712,21 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		save_register_state(env, state, spi, reg, size);
 	} else {
 		u8 type = STACK_MISC;
-
-		if (bpf_is_spilled_reg(ss))
-			bpf_diag_record_scrub(env, &ss->spilled_ptr,
-					      BPF_DIAG_MOD_WRITE);
-		scrub_special_slot(state, spi);
+		int keep = 0;
+
+		/* the bytes before the write still have the low bytes of a number */
+		if (bpf_is_spilled_scalar_reg(ss) && off % BPF_REG_SIZE)
+			keep = min_t(int, rounddown_pow_of_two(off & (BPF_REG_SIZE - 1)),
+				     bpf_spill_size(ss));
+		if (keep && bpf_stack_narrow_access_ok(0, keep, bpf_spill_size(ss))) {
+			for (i = 0; i < BPF_REG_SIZE - keep; i++)
+				if (ss->slot_type[i] == STACK_SPILL)
+					ss->slot_type[i] = STACK_MISC;
+		} else {
+			if (bpf_is_spilled_reg(ss))
+				bpf_diag_record_scrub(env, &ss->spilled_ptr, BPF_DIAG_MOD_WRITE);
+			scrub_special_slot(state, spi);
+		}
 
 		/* when we zero initialize stack slots mark them as such */
 		if ((reg && bpf_register_is_null(reg)) ||
@@ -3731,7 +3737,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		for (i = 0; i < size; i++)
 			ss->slot_type[(slot - i) % BPF_REG_SIZE] = type;
 	}
-
 	return 0;
 }
 
@@ -3994,6 +3999,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				/* coerce_scalar_to_size will adjust the boundaries. */
 				state->regs[dst_regno] = *reg;
 			} else {
+				/* the low bytes are from the spill */
+				bool fill_exceeds_spill =
+					size > spill_size && !(off % BPF_REG_SIZE) &&
+					!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
 				int spill_cnt = 0, zero_cnt = 0;
 
 				for (i = 0; i < size; i++) {
@@ -4033,6 +4042,10 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				} else {
 					mark_reg_stack_read(env, reg_state, off, off + size,
 							    dst_regno);
+					if (fill_exceeds_spill)
+						scalar_intersect(scalar_of(&state->regs[dst_regno]),
+								 scalar_of(reg),
+								 spill_size * BITS_PER_BYTE);
 				}
 			}
 		} else if (dst_regno >= 0) {
@@ -6202,7 +6215,12 @@ static void set_sext64_default_val(struct scalar *s, int size)
 		s->r64 = cnum64_from_srange(S32_MIN, S32_MAX);
 		s->r32 = cnum32_from_srange(S32_MIN, S32_MAX);
 	}
-	s->var_off = tnum_unknown;
+}
+
+/* The low @num_bits bits do not change. The other bits are copies of the sign. */
+static struct tnum tnum_sext(struct tnum t, u32 num_bits)
+{
+	return tnum_arshift(tnum_lshift(t, 64 - num_bits), 64 - num_bits, 64);
 }
 
 static void coerce_scalar_to_size_sx(struct scalar *s, int size)
@@ -6211,6 +6229,7 @@ static void coerce_scalar_to_size_sx(struct scalar *s, int size)
 	u64 top_smax_value, top_smin_value;
 	u64 num_bits = size * 8;
 	s64 limit = 1LL << (num_bits - 1);
+	struct cnum32 r32;
 
 	/* If every value fits the signed N-bit range sign extension is a noop. */
 	if (cnum64_smin(s->r64) >= -limit && cnum64_smax(s->r64) < limit)
@@ -6235,6 +6254,7 @@ static void coerce_scalar_to_size_sx(struct scalar *s, int size)
 		return;
 	}
 
+	s->var_off = tnum_sext(s->var_off, num_bits);
 	top_smax_value = ((u64)cnum64_smax(s->r64) >> num_bits) << num_bits;
 	top_smin_value = ((u64)cnum64_smin(s->r64) >> num_bits) << num_bits;
 
@@ -6260,12 +6280,19 @@ static void coerce_scalar_to_size_sx(struct scalar *s, int size)
 	if ((s64_max >= 0) == (s64_min >= 0)) {
 		s->r64 = cnum64_from_srange(s64_min, s64_max);
 		s->r32 = cnum32_from_srange(s64_min, s64_max);
-		s->var_off = tnum_range(s64_min, s64_max);
+		scalar_bounds_sync(s);
 		return;
 	}
 
 out:
+	r32 = s->r32;
 	set_sext64_default_val(s, size);
+	/* the low 32 bits fit, they do not change */
+	if (cnum32_smin(r32) >= -limit && cnum32_smax(r32) < limit) {
+		s->r32 = r32;
+		s->r64 = cnum64_from_srange(cnum32_smin(r32), cnum32_smax(r32));
+	}
+	scalar_bounds_sync(s);
 }
 
 static void set_sext32_default_val(struct scalar *s, int size)
@@ -6275,7 +6302,6 @@ static void set_sext32_default_val(struct scalar *s, int size)
 	else
 		/* size == 2 */
 		s->r32 = cnum32_from_srange(S16_MIN, S16_MAX);
-	s->var_off = tnum_subreg(tnum_unknown);
 }
 
 static void coerce_subreg_to_size_sx(struct scalar *s, int size)
@@ -6320,6 +6346,7 @@ static void coerce_subreg_to_size_sx(struct scalar *s, int size)
 		return;
 	}
 
+	s->var_off = tnum_sext(s->var_off, num_bits);
 	top_smax_value = ((u32)cnum32_smax(s->r32) >> num_bits) << num_bits;
 	top_smin_value = ((u32)cnum32_smin(s->r32) >> num_bits) << num_bits;
 
@@ -6340,7 +6367,6 @@ static void coerce_subreg_to_size_sx(struct scalar *s, int size)
 
 	if ((s32_min >= 0) == (s32_max >= 0)) {
 		s->r32 = cnum32_from_srange(s32_min, s32_max);
-		s->var_off = tnum_subreg(tnum_range(s32_min, s32_max));
 		return;
 	}
 
@@ -17308,7 +17334,9 @@ static void scalar_min_max_rsh(struct scalar *dst, const struct scalar *src)
 static void scalar32_min_max_arsh(struct scalar *dst, const struct scalar *src)
 {
 	u32 umin_val = cnum32_umin(src->r32), umax_val = cnum32_umax(src->r32);
-	s32 smin = cnum32_smin(dst->r32), smax = cnum32_smax(dst->r32);
+	struct cnum32 known = cnum32_from_tnum(dst->var_off);
+	s32 smin = max(cnum32_smin(dst->r32), cnum32_smin(known));
+	s32 smax = min(cnum32_smax(dst->r32), cnum32_smax(known));
 
 	/*
 	 * A larger count brings the result closer to 0, or to -1.
@@ -17327,7 +17355,10 @@ static void scalar32_min_max_arsh(struct scalar *dst, const struct scalar *src)
 static void scalar_min_max_arsh(struct scalar *dst, const struct scalar *src)
 {
 	u64 umin_val = cnum64_umin(src->r64), umax_val = cnum64_umax(src->r64);
-	s64 smin = cnum64_smin(dst->r64), smax = cnum64_smax(dst->r64);
+	struct cnum64 known = cnum64_from_tnum(dst->var_off);
+	/* a range that crosses S64_MAX has no signed bounds, the known bits have: 0..0xf0 << 56 */
+	s64 smin = max(cnum64_smin(dst->r64), cnum64_smin(known));
+	s64 smax = min(cnum64_smax(dst->r64), cnum64_smax(known));
 
 	/* A larger count brings the result closer to 0, or to -1 */
 	dst->r64 = cnum64_from_srange(smin >> (smin < 0 ? umin_val : umax_val),
@@ -17450,6 +17481,8 @@ static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf_insn *ins
 	else
 		return 0;
 
+	/* with a step only a later insn can find that a part has no value */
+	scalar_step_reset(scalar_of(dst_reg));
 	branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
 	if (IS_ERR(branch))
 		return PTR_ERR(branch);
@@ -17484,6 +17517,7 @@ void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_i
 	s16 off = insn->off;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	struct scalar tmp;
+	u64 cleared;
 
 	if (!is_safe_to_compute_dst_reg_range(insn, src)) {
 		scalar_set_unknown(dst);
@@ -17589,10 +17623,18 @@ void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_i
 		scalar_step_reset(dst);
 		break;
 	case BPF_AND:
+		cleared = (dst->var_off.value | dst->var_off.mask) & ~src->var_off.value;
+		tmp = *dst;
 		dst->var_off = tnum_and(dst->var_off, src->var_off);
 		scalar32_min_max_and(dst, src);
 		scalar_min_max_and(dst, src);
 		scalar_step_reset(dst);
+		/*
+		 * If no bit is cleared, the old ranges hold too.
+		 * A part from maybe_fork_scalars() can have no value.
+		 */
+		if (!(u32)cleared && !scalar_is_empty(&tmp))
+			scalar_intersect(dst, &tmp, cleared ? 32 : 64);
 		break;
 	case BPF_OR:
 		dst->var_off = tnum_or(dst->var_off, src->var_off);
@@ -18913,8 +18955,8 @@ static bool scalars_fit_in_bits(const struct scalar *a, const struct scalar *b,
 
 /*
  * The values of @dst and @src are equal in their low @bits bits: @dst becomes the intersection.
- * False: @dst is left as it is. Fewer than 32 bits say nothing about a range. Or the intersection
- * is empty: no execution gets here with these values, the path is infeasible.
+ * Fewer than 32 bits say nothing about a range. Returns false if the intersection is empty.
+ * Then no execution gets here with these values, and @dst does not change.
  */
 bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits)
 {
@@ -18923,25 +18965,27 @@ bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits)
 
 	if (scalars_fit_in_bits(dst, src, bits))
 		bits = 64;
-	if (bits < 32)
-		return false;
-	if (bits < 64) {
-		a = tnum_subreg(a);
-		b = tnum_subreg(b);
-	}
+	if (bits < 64)
+		b = tnum_or(tnum_cast(b, bits / BITS_PER_BYTE), tnum_lshift(tnum_unknown, bits));
 	/* tnum_intersect() of two tnums that don't overlap is not empty */
 	if (!tnum_overlap(a, b))
 		return false;
+	s.var_off = tnum_intersect(a, b);
 	/*
 	 * Equal in 64 bits is equal in the low 32 bits too. 'if w1 s> 200' on a zero extended int
 	 * refines nothing but the 32-bit range.
 	 */
-	s.r32 = cnum32_intersect(dst->r32, src->r32);
+	if (bits >= 32)
+		s.r32 = cnum32_intersect(dst->r32, src->r32);
 	if (bits == 64) {
 		s.r64 = cnum64_intersect(dst->r64, src->r64);
-		s.var_off = tnum_intersect(a, b);
-	} else {
-		s.var_off = tnum_with_subreg(dst->var_off, tnum_intersect(a, b));
+		if (src->step % dst->step == 0) {
+			if (src->base % dst->step != dst->base)
+				return false;
+			s.step = src->step;
+			s.base = src->base;
+		}
+		s.r64 = cnum64_intersect_linear(s.r64, s.base, s.step);
 	}
 	scalar_bounds_sync(&s);
 	if (scalar_is_empty(&s) || const_tnum_range_mismatch(&s) ||
-- 
2.55.0

