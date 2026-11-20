Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160745;
	b=YkZC/TuUStZZ+Pi4br/avepRTHimfpXn7DLFVerOXlfAPZp+GKzrdXeamzXtwDWKppiB
	 1B+6J/j4op2Y4xagHbSHKsr/WRfoumxZV71HeCy3of4U9PPv4BbxNKzxQUP3pu0x7s6vQ
	 wwxrj6vTD0E4n68LB4zd1svvPbWH51ilp+emzckFjb1EW4Pxjg652uQP1v5oUKFZbovRc
	 wRpEQpw/hQjxN1cD8NDaXppUAd/g6erMqwo+Q0LZkckIwcObPJiqrvek0VAtYYmw6K+V3
	 lwk49qOEAaYJ8jYmS9DWjAyA8au9QjSF8SXvyXyO10XlDKtEdQi6+3rScCh/ChMpXKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Nb+UGCCUVVFWmgh9WnNQcFb2Gt7mSgFXec4DPWQ7uKM=;
	b=DA5ODfXKJ0DrFP+lJeGQ6DCb7379lpOu1Ya72Gu+r9QMCynpaBNWxgCac/0CiGDf9vgJ
	 eYdVYSa+jTHWKEI2EgIdGSZf25Dm6paG/VGXF7X9iFEFFJNHv44iKiIOV4f9oLmlHTGiM
	 ezyrzB05jU+qL0ydEHlZdBW5JJ1Sfa//orze4zjU6Q81DtMLTZ1QBtbtjnGbv+/kPNBlZ
	 Pnl92Xoodc4d+tfBMncfx2G/rNDkEVSGis3vIi/RPYu8nMX4i8Fn0W6KJ3ETkPRNMb8n4
	 gVHwnoUr4kqjsojkakXqz3Cr4m1t6MhDYAq5ZQQ1rgxPDpTWNzVNnrS4JeWUhV9QygA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S82iGB8d;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C7606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0C7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S82iGB8d
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so270793a12.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160745; x=1795765545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nb+UGCCUVVFWmgh9WnNQcFb2Gt7mSgFXec4DPWQ7uKM=;
        b=S82iGB8dF43PmnL57bp7MGsG9VnojeIYMThvPZ/ep2bQ5vtYIYPgL1uLo1Lj7LvkNt
         9jNPj/JNEoPSVj0Vd2j0qoLKY8sx0I6z7YoCW0jnS/RavJJTYebIcyWuKzIlpc2eF+s6
         HaDfhyiKKOr5+xrYkh0/yhIx32n5fxqObPFtI2WX7hQw2ZoOdZbBZK5PdfkYqFr/lJd7
         FyS12D/Njn+CH5IcBRyh753XM5mG+T9+vbR+hTZ1SMg9vMHoesX3YbOKn34JmhrrcdFp
         caxq1lXzY4pEguovs2B37q11tsS9HgaOPawBrgBEYkE2nPNIWb/0VmTayrqOPy7E84kT
         F5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160745; x=1795765545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nb+UGCCUVVFWmgh9WnNQcFb2Gt7mSgFXec4DPWQ7uKM=;
        b=fEYRH+aZn8Qe1rrBii5UsePnyX/N1xLm3XG+UsshHHvY0y4cLuBFbb4QqAJqzFmtNF
         k3aaf229ywnew8Qupo4dEJxCsQNYaVdrOayn2zUIFHVFRDvqVN5SHMSbOwOCRn4LQPwM
         NneC/vxEYfwVIXwqRy/hAopd3vxqoaC44gZYF6gOV7AcVhJW8ECIM/7maFYqRC71JpQ7
         OLraolA2ABGAyWF+5iORGdBTbeIxaWtxMnM0iLVjKqgv/jcxwg6ZDnOZEw81KA0vO9AQ
         JU2PLInFMxU3TPu/47gToPQRgArE20GZSO7kootUkn9S8VSN+vPSez4gxw7QYnqMdGM0
         cNog==
X-Gm-Message-State: APuU4Z+0pAK+m7knn7lVnMhucx2ey4Clvo0NsMW4/n/P87xdGI5e3ZtI
	GZvPzquQ5zJA8feWz8RuHG/0TDZPiHgSLj8cwaNNFbhp9APGBL0dmk1PMdJQiQ==
X-Gm-Gg: AZFdTZdayt7EwenY9eZ3Z71vc7JS2IVWovHFYI2lhRywKPbW0g6oUziJsQaiIuBzwuq
	xJmGUaFJLT8CFW2myvjDM3wOwfPdGpEWHw5JRfuleNoaMn8nUz57h71OrFiVbKo8CdgKNE4bGI8
	+aFMr2PYuEp3kn6y/FfNHJDNGFm3OLnBuUlx5zNnBT1/4PgphLEKXRUHsDT3djiZ1wVe1bEvf8u
	Pj7fhAeVMUOiSct9UzWAmysHRB99qiMlqpPk/SCbjCy3RjtgUEscgvyAZf3XMHyAp5mfeho4szb
	aBc7CuR+P4W68aZsxB8SMn6hW2QXzEsJgLcSy9rhiNZ2NyYy3xzB6GqeodkdNi+pP3ns/giKDfn
	w63hTleAMD4eyhm/HM4OvPGzMC1G3sFYJCs4uS989irM947ONnWsTWDZbEOtt2lBhDCdB1f9Z9v
	orSJdS5yfjJqpNbpvRMyr6czv+lP45v8/4AmilKW1bTh5Pf8CXWNDihHW0EH+suTy3LgaUOJvp5
	iDa+Y7Qjswo6t08PKmt3GmC99UO1HEAo+BaGka7t8UUYHHC7fmU9dJr3map5hojM5jv7j4G2BK9
	+41iKfmvNbBhSK46RMqa6/tSYglTdM4nsQh8/H7Qa2+DrdZhHGt7nFI/L/7CDkmtOGlbCoChdbK
	i9mTp1p1N30l44cDmhqRt5OkatN4kKoOFsZVBDoQ6A5bP5vInZzT/N5wFbAGkocz21kdeBUHDhx
	e4rlaCodTqmePm2WK7tMQ=
X-Received: by 2002:a17:90b:554d:b0:3ad:d29c:5e64 with SMTP id 98e67ed59e1d1-3b41c9b361fmr2049500a91.65.1795160744335;
        Thu, 19 Nov 2026 23:45:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm4834451a91.3.2026.11.19.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:45:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 12/49] bpf: Keep more of what is known about a number
Date: Fri, 20 Nov 2026 07:41:44 +0000
Message-ID: <20261120074430.2704488-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

1. An AND that clears no bit is a move.
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
 kernel/bpf/verifier.c        | 126 +++++++++++++++++++++++------------
 2 files changed, 85 insertions(+), 42 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a7b6aaa3ce8..e1432f48fea 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2063,6 +2063,7 @@ void bpf_blur_far_offset(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax);
 void scalar_set_unknown(struct scalar *s);
 void scalar_set_const(struct scalar *s, u64 imm);
+void scalar_step_scale(struct scalar *dst, s64 amount);
 void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar *b);
 void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_insn *insn);
 bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index de3e9675e50..3229372c5f4 100644
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
@@ -6203,7 +6216,12 @@ static void set_sext64_default_val(struct scalar *s, int size)
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
@@ -6212,6 +6230,7 @@ static void coerce_scalar_to_size_sx(struct scalar *s, int size)
 	u64 top_smax_value, top_smin_value;
 	u64 num_bits = size * 8;
 	s64 limit = 1LL << (num_bits - 1);
+	struct cnum32 r32;
 
 	/* If every value fits the signed N-bit range sign extension is a noop. */
 	if (cnum64_smin(s->r64) >= -limit && cnum64_smax(s->r64) < limit)
@@ -6236,6 +6255,7 @@ static void coerce_scalar_to_size_sx(struct scalar *s, int size)
 		return;
 	}
 
+	s->var_off = tnum_sext(s->var_off, num_bits);
 	top_smax_value = ((u64)cnum64_smax(s->r64) >> num_bits) << num_bits;
 	top_smin_value = ((u64)cnum64_smin(s->r64) >> num_bits) << num_bits;
 
@@ -6261,12 +6281,19 @@ static void coerce_scalar_to_size_sx(struct scalar *s, int size)
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
@@ -6276,7 +6303,6 @@ static void set_sext32_default_val(struct scalar *s, int size)
 	else
 		/* size == 2 */
 		s->r32 = cnum32_from_srange(S16_MIN, S16_MAX);
-	s->var_off = tnum_subreg(tnum_unknown);
 }
 
 static void coerce_subreg_to_size_sx(struct scalar *s, int size)
@@ -6321,6 +6347,7 @@ static void coerce_subreg_to_size_sx(struct scalar *s, int size)
 		return;
 	}
 
+	s->var_off = tnum_sext(s->var_off, num_bits);
 	top_smax_value = ((u32)cnum32_smax(s->r32) >> num_bits) << num_bits;
 	top_smin_value = ((u32)cnum32_smin(s->r32) >> num_bits) << num_bits;
 
@@ -6341,7 +6368,6 @@ static void coerce_subreg_to_size_sx(struct scalar *s, int size)
 
 	if ((s32_min >= 0) == (s32_max >= 0)) {
 		s->r32 = cnum32_from_srange(s32_min, s32_max);
-		s->var_off = tnum_subreg(tnum_range(s32_min, s32_max));
 		return;
 	}
 
@@ -17297,7 +17323,9 @@ static void scalar_min_max_rsh(struct scalar *dst, const struct scalar *src)
 static void scalar32_min_max_arsh(struct scalar *dst, const struct scalar *src)
 {
 	u32 umin_val = cnum32_umin(src->r32), umax_val = cnum32_umax(src->r32);
-	s32 smin = cnum32_smin(dst->r32), smax = cnum32_smax(dst->r32);
+	struct cnum32 known = cnum32_from_tnum(dst->var_off);
+	s32 smin = max(cnum32_smin(dst->r32), cnum32_smin(known));
+	s32 smax = min(cnum32_smax(dst->r32), cnum32_smax(known));
 
 	/*
 	 * A larger count brings the result closer to 0, or to -1.
@@ -17316,7 +17344,10 @@ static void scalar32_min_max_arsh(struct scalar *dst, const struct scalar *src)
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
@@ -17473,6 +17504,7 @@ void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_i
 	s16 off = insn->off;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	struct scalar tmp;
+	u64 cleared;
 
 	if (!is_safe_to_compute_dst_reg_range(insn, src)) {
 		scalar_set_unknown(dst);
@@ -17578,8 +17610,12 @@ void scalar_alu(struct scalar *dst, const struct scalar *src, const struct bpf_i
 		scalar_step_reset(dst);
 		break;
 	case BPF_AND:
+		cleared = (dst->var_off.value | dst->var_off.mask) & ~src->var_off.value;
+		if (!cleared)
+			break;
 		dst->var_off = tnum_and(dst->var_off, src->var_off);
-		scalar32_min_max_and(dst, src);
+		if ((u32)cleared)
+			scalar32_min_max_and(dst, src);
 		scalar_min_max_and(dst, src);
 		scalar_step_reset(dst);
 		break;
@@ -18921,16 +18957,22 @@ bool scalar_intersect(struct scalar *dst, const struct scalar *src, u32 bits)
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

