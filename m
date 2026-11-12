Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442154;
	b=0rDjsC3PZbG9N4TABbCaDUUah4senpsbMXo8q3vget6mzeJe02c0Ing4W0jD5Ri9JDS8
	 TrFzBBIoc/fNGeVSE+lCiL7wwMfeNqvOPqTDxG+MvRo4ahn090Kk712UVd8je/sEZ8Wej
	 b9B1qz6eH7YvgBHoyZh3/Hj7t/ChRrrpLe+25U9aAZpvviHowX9b2x4GarKC5cOrqzsQ+
	 fSMc5f8NHb/lJUHtVU5Jr99z9F6TbQwAsBKeVeNfa9PKDolVJFyXJl5bNdsqBm5AT5r4f
	 EMsCoF2pDBWYFnotkhomEMVDIa+V6mSnoOdZTWa0NCh3YGifVlVkfvPWoXvoNheVfeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Fn/cgcpD+GeQUeF98wQJ60rD/WsfT45LRvDYzW2SmkI=;
	b=ld2mGwEenmqrLYi/PGPtg/hVI/YR2mcLypBIATBpE2C7XWFY3RDpzBKbP64/lP2EJqnd
	 X5n+oMlIkj90fS34qwVEJIIb3nBT+DOestdq7Ecje5UPdh2t8x2NGYIZwvgQOUg1p8mmW
	 RJfpYMdxU1w9B4heLhAqvFRehKRVZGQPUCopCz28eYpk4a9CaVkEIUUfj2zC1hX2cl81B
	 itHeZmIPbeQgUKMZCd1iaR8PcUpAC19z+jo2vt9FHxPlUVv8xOwRG2lPCQL94IWaUCwKi
	 sR13stc7uzK6u9yv2MlPw2QzbDUvrpkhvJraN99KAQEBfhzGvqPwtMyNas6y72Gzw7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guNpnGSp;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8B606A324
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA8B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guNpnGSp
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so1711415b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794442152; x=1795046952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fn/cgcpD+GeQUeF98wQJ60rD/WsfT45LRvDYzW2SmkI=;
        b=guNpnGSp2Hc1nNEVvlrMnWKpHrCgJoV89KYwLU/8M2esGy+fN98rjGsueC5U33U/i3
         O157XCOt3uRKVMZsTl4NXQVA46Kx83qIJ7s6dzEUI/JNNfulPjTmbs87+CjkFWbfG0Mr
         B9LvNiFoTan0878JeK2tNUWf+A5sU45fR+GPb3DU7yP2il0t9AgI3lCgiOyn/uBHTne6
         iXHqynzo+w2MgO/OQ15MfXbfD5Lt8VTBBWxvs+nU5Hm1XZrhRUlzR8ypF1qY5txD+M47
         ZVE19eIFY0icTuMJ/IGVzF3TdDIy9oEIdlV4LSyZBjnH8skVbcxU4NCZUOImJmqgm06o
         rWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794442152; x=1795046952;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fn/cgcpD+GeQUeF98wQJ60rD/WsfT45LRvDYzW2SmkI=;
        b=zDWKNHA4EwvnBaA0atwH6Iq0uX3y748fneckngI80FG+SNhSe8ke4Np4sP8wrBor03
         2CBLYnJRp0ElU3OFmQkQPHM4QP0+dSWEd5TYEOpzaHnJiCgj8mMxJd/Q8CjIhmJVEs6l
         59he/jj9DIRsJ/UYnPQFLryUvju51NwHN9s7blhEm0ctLmQ4FA/PPkPBprQX1W6hwACS
         +JDj5Fsp0hjx8Iosz9XqRJA0ZcUI1rk0QbV7clvwSKoIEb1RuT3odhjmPj3jbPc7hMEz
         uAYj+QBM2UzSHrJiXzScofiKaAQAv2NQ+dwCrkgk3ms6IMJGpyqbdG2Fxc2We+GF/pgw
         qBmA==
X-Gm-Message-State: APuU4Z8qRW5nrWan5NmVWKMqLd8+W5PH4aBroXHDbEpsoZFKe4LPZqdY
	n8vSsn2kNykhzVSZ9CAzujMkDkR3DHL4kz1VDsz3Yh5AiYj22iuXhWF8iJsBnQ==
X-Gm-Gg: AYBFou3JnFDHMc/5PdCI0BRwqkdH/7Zw3dC5BgNjimjZWbUvg7uOjV9pkQZsM0+22x2
	hrrSBXBNrY7iS3fX5lZGSIhmvCbHv1NQkx2zKh9v+U1OBVLV5B5JrNWNVAGDCfGtHSFdhizB7y3
	+ucy4zMGLsR790ZtJjtEmHT9iuq3MScon1FqB33ozjo1AzFZWDExpkL5blIu4FjHUvH3hOV2CHr
	R6B/gTr7DglXv1fAoHQssEGoUSKqHCe4ozFoUo6B4LUDd9Dnx6z7gdxJL/KmquHsyMTNvQFxNKE
	5Bs7yVH6dZ0JpmVK5HmFdyscoB8WluVhi5AyBLJCLnJGsy89LGIuoNlYoywO+lQdiChd0j3Xba4
	g8j1W41AVxEdXE/YmxWUid/kEUXFbhzgAPHktC6Tx8IwAa336EEih4DYsiMXk7N0AVEPvqKXuNV
	dsZfVEn7pd1EqqESNe94ycKEaHXA6wvttO19I0eKYXYgWBmHnVwsC6jVZsPWHZvTDOHYikc+va1
	f6ZU1TJezNPdmkAQ8pkT28vU7Wkt4jgvXVMgBAuMoKM0w3PNQP8NaOv6MylGHkhSCZwYGHLfmY/
	YvqAdosn30D7ojEIvy02oJ3y9dXBdA/DtTl49l+hRIWC7T5fMRa1uJDNaoWgkJ6H9+8qMo7NB9W
	QiEbqArNeNIveB9axO+I0WOHFuhOFP0qgz+arGkgnF0pPlbnMvlWtmodtzP3nx/rl7pTOjUeEIQ
	==
X-Received: by 2002:a05:6a00:2343:b0:8a0:3336:4b45 with SMTP id d2e1a72fcca58-8bc1c594810mr4009318b3a.12.1794442151282;
        Wed, 11 Nov 2026 16:09:11 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab21a142sm2619483b3a.44.2026.11.11.16.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:09:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 5/7] bpf: Compute the backedge-taken count on cnum, in one function
Date: Thu, 12 Nov 2026 00:08:33 +0000
Message-ID: <20261112000836.3138846-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
References: <20261112000836.3138846-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

These loops are rejected (clang -mcpu=v4, buf is a map value of 64 bytes):

	for (char *p = buf + 56; p >= buf; p -= 8)
		*p = 0;
	for (u32 i = bpf_get_prandom_u32(); i < 64; i--)
		buf[i] = 0;
	for (long i = bpf_get_prandom_u32(); (u32)i < 64; i++)
		buf[i] = 0;

The first one has no iteration count: the offset of p ends at -8, on the
other side of 0. The other two have one, but the range that a 32-bit
latch implies is not used for a register with unknown upper 32 bits, nor
for a 64-bit induction variable. In __strncmp() of netif_receive_skb.c
clang folds two bounds into 'r2 = i - 6; if r2 > 0xf9 goto loop'. r2
moves away from the bound and wraps: no count, the verifier unrolls the
loops. The prog goes from 14519 to 3505 insns.

The count is computed twice from the eight bounds of struct scev_value:
nine cases for constants, and for ranges compute_backedge_taken_max() with
struct latch_domain, a bias for signed numbers and other rules for 32 bits.

Make scev_value a struct scalar and compute on its r64 and r32. On the
circle of cnum a latch is true on one arc. Invert a variable that goes
down and rotate the arc to 0: 'x < end' of unsigned numbers is left, with
one count and one check for wrap-around. 32-bit numbers are compared on
the same circle, shifted up by 32 bits. The table of arcs, a picture and
the examples are in the comment of compute_backedge_taken_count().

iv_range is a struct scalar, and a 32-bit latch sets its r32: the low 32
bits of the register at the header, for any step and any upper half. That
holds for 'w6 += 1; if r6 < 10' and for 'r6 += 1; w3 = w6; if r3 < 10',
which have one struct linear_latch: five conditions that kept the range
away from the 64-bit r6 go. struct bounds is a struct scalar too, the two
additions of scev.c are scalar_add().

What changes:
 - More latches have a count: a variable that moves away from the bound
   and wraps into the values that end the loop, a 64-bit variable under a
   32-bit jump, a 32-bit variable under a 64-bit jump if the register or
   the tested sum fits in 32 bits, a 32-bit '!=' that goes all the way
   around (post32_ne_around: 4294967293). Up to 2^32 iterations are
   counted, as for 'i < 0xfffffffd' in 64 bits: such a loop gets no
   may_goto.
 - A loop that gets its first count is summarized, no longer unrolled by
   the verifier. A variable that another exit bounds, one without a count,
   is 'initial + step * count' then: a valid loop can be rejected. Beside
   a live variable without a linear form the iterations are kept apart up
   to the count: more insns.
 - count_backedge() keeps the smallest count: a loop with several
   backedges can lose its count to the new count of another jump.
 - range32_jump has 3..14 for 3..20. The price, if the latch tests a copy:
   'l: w3 = w8; if w3 >= 240 goto out; r8 += 4; goto l' from any u32 has
   0..0x1000000ef for 0..U32_MAX.
 - Constant offsets of pointers obey +-BPF_MAX_VAR_OFF, as ranges do.
 - false_until: 'i < 128' of an i that goes down is false until i is 127
   again, not until S64_MIN. It is 0 if an initial value can be above 127.
 - bpf_clamp_scev_regs() behind the jump that counts: if the range plus
   what the iteration has added wraps, the range wraps with it and the
   step is dropped. The register was left as it was (moved_over).
 - The log: [0..8] for 'header_count is 8' if i goes down from 6 while
   'i < n' and n is a range. No
   'mixed-width latch has operands outside 32-bit ranges'.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |   8 +-
 include/linux/cnum.h                          |   2 +
 kernel/bpf/cnum.c                             |  26 +
 kernel/bpf/scev.c                             | 838 ++++++------------
 kernel/bpf/verifier.c                         |  10 +-
 .../selftests/bpf/progs/verifier_loop_latch.c |   6 +-
 .../selftests/bpf/progs/verifier_scev.c       |  15 +-
 7 files changed, 324 insertions(+), 581 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index fefe860e1d51..d4fdb724cc1b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -382,10 +382,10 @@ struct bpf_loop_iters {
 	/*
 	 * The variable that the latches of all back edges test, or -1, and what
 	 * it can be at the loop header: what it is at the entry or what one of
-	 * the latches lets through.
+	 * the latches lets through. A 32-bit latch bounds its low 32 bits only.
 	 */
 	int iv_reg;
-	struct cnum64 iv_range;
+	struct scalar iv_range;
 	/* a jump that counts: it leaves the loop in the last iteration, if not before. Or -1 */
 	int count_insn;
 	/* a pointer to the stack that stores go through moves in the loop */
@@ -448,7 +448,7 @@ struct loop_stack_entry {
 	u32 walk_id;
 	u32 walk_patience;
 	int iv_reg;
-	struct cnum64 iv_range;
+	struct scalar iv_range;
 	int count_insn;
 };
 
@@ -2071,7 +2071,7 @@ void scalar_add(struct scalar *dst, const struct scalar *a, const struct scalar
 void scalar_zext32(struct scalar *s);
 void scalar_union(struct scalar *acc, const struct scalar *src);
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step);
+		      const struct scalar *range);
 bool bpf_reg_union_compatible(const struct bpf_reg_state *a, const struct bpf_reg_state *b);
 void bpf_reg_widen_range(struct bpf_reg_state *reg, const struct bpf_reg_state *old,
 			 const struct bpf_loop_rungs *rungs, int linear);
diff --git a/include/linux/cnum.h b/include/linux/cnum.h
index bf514cc0a098..e00148d352ea 100644
--- a/include/linux/cnum.h
+++ b/include/linux/cnum.h
@@ -85,6 +85,8 @@ bool cnum64_is_subset(struct cnum64 outer, struct cnum64 inner);
 struct cnum32 cnum32_from_cnum64(struct cnum64 cnum);
 struct cnum64 cnum64_zext32(struct cnum32 cnum);
 struct cnum64 cnum64_sext32(struct cnum32 cnum);
+struct cnum64 cnum64_lshift32(struct cnum32 cnum);
+struct cnum32 cnum32_rshift32(struct cnum64 cnum);
 struct cnum64 cnum64_cnum32_intersect(struct cnum64 a, struct cnum32 b);
 struct cnum64 cnum64_intersect_linear(struct cnum64 in, u16 base, u16 step);
 
diff --git a/kernel/bpf/cnum.c b/kernel/bpf/cnum.c
index 21bb6411cfb8..e64c09a37cc8 100644
--- a/kernel/bpf/cnum.c
+++ b/kernel/bpf/cnum.c
@@ -42,6 +42,32 @@ struct cnum64 cnum64_sext32(struct cnum32 cnum)
 	return cnum64_from_srange(cnum32_smin(cnum), cnum32_smax(cnum));
 }
 
+/*
+ * The smallest arc with { x << 32 : x in 'cnum' }. The circle of 2^32 numbers is laid on the circle
+ * of 2^64 numbers: sums, the order of signed and of unsigned numbers and the places where they wrap
+ * stay.
+ */
+struct cnum64 cnum64_lshift32(struct cnum32 cnum)
+{
+	if (cnum32_is_empty(cnum))
+		return CNUM64_EMPTY;
+	return (struct cnum64){ .base = (u64)cnum.base << 32, .size = (u64)cnum.size << 32 };
+}
+
+/* { x >> 32 : x in 'cnum' } */
+struct cnum32 cnum32_rshift32(struct cnum64 cnum)
+{
+	u32 base = cnum.base >> 32;
+	u32 size = ((cnum.base + cnum.size) >> 32) - base;
+
+	if (cnum64_is_empty(cnum))
+		return CNUM32_EMPTY;
+	/* less than 1 << 32 numbers are missing, or the arc ends one before its base */
+	if (cnum.size >> 32 == U32_MAX || size == U32_MAX)
+		return CNUM32_UNBOUNDED;
+	return (struct cnum32){ .base = base, .size = size };
+}
+
 /*
  * Suppose 'a' and 'b' are laid out as follows:
  *
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 46c7c654164c..815a6367555d 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -3454,18 +3454,10 @@ int bpf_scev_jump_counts(struct bpf_verifier_env *env, int header, int n, bool t
 
 /* What is known about a scalar or about the offset of a pointer. */
 struct scev_value {
-	u64 umin, umax;
-	s64 smin, smax;
-	u32 u32_min, u32_max;
-	s32 s32_min, s32_max;
+	struct scalar;
 	int ptr_reg;	/* SCEV register identifying the pointer origin, or -1. */
 };
 
-static bool scev_value_is_const(const struct scev_value *v)
-{
-	return v->umin == v->umax;
-}
-
 static void log_scev_value(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			   const struct scev_value *v)
 {
@@ -3475,10 +3467,10 @@ static void log_scev_value(struct bpf_verifier_env *env, struct bpf_func_state *
 		reg = scev_reg_for_read(env, st, v->ptr_reg);
 		log_reg(env, v->ptr_reg);
 		bpf_log(&env->log, " (%s)", reg ? reg_type_str(env, reg->type) : "unavailable");
-	} else if (scev_value_is_const(v)) {
-		bpf_log(&env->log, "scalar %llu", v->umin);
+	} else if (cnum64_is_const(v->r64)) {
+		bpf_log(&env->log, "scalar %llu", v->r64.base);
 	} else {
-		bpf_log(&env->log, "scalar %llu..%llu", v->umin, v->umax);
+		bpf_log(&env->log, "scalar %llu..%llu", cnum64_umin(v->r64), cnum64_umax(v->r64));
 	}
 }
 
@@ -3519,38 +3511,13 @@ static bool scev_value_add(struct bpf_verifier_env *env, struct bpf_func_state *
 			   const struct scev_value *a, const struct scev_value *b,
 			   struct scev_value *result)
 {
-	bool min_wraps, max_wraps;
-
 	if (a->ptr_reg >= 0 && b->ptr_reg >= 0) {
 		if (env->log.level & BPF_LOG_LEVEL2)
 			log_incompatible_scev_values(env, "can't add two pointers", st, a, b);
 		return false;
 	}
 	result->ptr_reg = a->ptr_reg >= 0 ? a->ptr_reg : b->ptr_reg;
-
-	/* when both ends wrap around it is a range still */
-	min_wraps = check_add_overflow(a->umin, b->umin, &result->umin);
-	max_wraps = check_add_overflow(a->umax, b->umax, &result->umax);
-	if (min_wraps != max_wraps) {
-		result->umin = 0;
-		result->umax = U64_MAX;
-	}
-	if (check_add_overflow(a->smin, b->smin, &result->smin) ||
-	    check_add_overflow(a->smax, b->smax, &result->smax)) {
-		result->smin = S64_MIN;
-		result->smax = S64_MAX;
-	}
-	min_wraps = check_add_overflow(a->u32_min, b->u32_min, &result->u32_min);
-	max_wraps = check_add_overflow(a->u32_max, b->u32_max, &result->u32_max);
-	if (min_wraps != max_wraps) {
-		result->u32_min = 0;
-		result->u32_max = U32_MAX;
-	}
-	if (check_add_overflow(a->s32_min, b->s32_min, &result->s32_min) ||
-	    check_add_overflow(a->s32_max, b->s32_max, &result->s32_max)) {
-		result->s32_min = S32_MIN;
-		result->s32_max = S32_MAX;
-	}
+	scalar_add(scalar_of(result), scalar_of(a), scalar_of(b));
 	return true;
 }
 
@@ -3566,31 +3533,19 @@ static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev,
 		reg = scev_reg_for_read(env, st, regno);
 		if (!reg || reg->type == NOT_INIT)
 			return false;
-		result->umin = reg_umin(reg);
-		result->umax = reg_umax(reg);
-		result->smin = reg_smin(reg);
-		result->smax = reg_smax(reg);
-		result->u32_min = reg_u32_min(reg);
-		result->u32_max = reg_u32_max(reg);
-		result->s32_min = reg_s32_min(reg);
-		result->s32_max = reg_s32_max(reg);
+		*scalar_of(result) = *scalar_of(reg);
 		result->ptr_reg = reg->type == SCALAR_VALUE ? -1 : (int)regno;
 		return true;
 	} else if (is_zext32(scev, id, &l) && is_reg(scev, l, &regno)) {
 		reg = scev_reg_for_spill32(st, regno);
 		if (!reg)
 			return false;
-		result->umin = result->smin = result->u32_min = reg_u32_min(reg);
-		result->umax = result->smax = result->u32_max = reg_u32_max(reg);
-		result->s32_min = reg_s32_min(reg);
-		result->s32_max = reg_s32_max(reg);
+		*scalar_of(result) = *scalar_of(reg);
+		scalar_zext32(scalar_of(result));
 		result->ptr_reg = -1;
 		return true;
 	} else if (is_imm(scev, id, &imm)) {
-		result->umin = result->umax = imm;
-		result->smin = result->smax = imm;
-		result->u32_min = result->u32_max = imm;
-		result->s32_min = result->s32_max = imm;
+		scalar_set_const(scalar_of(result), imm);
 		result->ptr_reg = -1;
 		return true;
 	} else if (is_add(scev, id, &l, &r) &&
@@ -3601,6 +3556,12 @@ static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev,
 	return false;
 }
 
+/* The range of @v. With @low32 that of its low 32 bits, in the upper half of a u64. */
+static struct cnum64 scalar_arc(const struct scalar *v, bool low32)
+{
+	return low32 ? cnum64_lshift32(v->r32) : v->r64;
+}
+
 static bool is_signed_op(u8 op)
 {
 	switch (op) {
@@ -3615,433 +3576,231 @@ static bool is_signed_op(u8 op)
 }
 
 /*
- * Is the latch false in the first iteration, whatever the first value and the bound are in
- * their ranges? For a signed comparison the sign bit is flipped, see struct latch_domain.
+ * What a linear latch tells about the loop. LLVM's ScalarEvolution::ExitLimit has the counts,
+ * @false_until and @iv are ours.
+ */
+struct exit_limit {
+	/* The backedge is taken at most @max times. Exact if initial value and bound are known. */
+	u64 max;
+	/* The latch is false in iterations @max .. @false_until, whatever the initial value is. */
+	u64 false_until;
+	/* The induction variable at the latch in all iterations, the one that ends the loop too. */
+	struct cnum64 iv;
+};
+
+/*
+ * The range of @a as unsigned numbers after the circle is rotated such that @origin is 0.
+ * An arc that crosses @origin gives [0, @ut_max].
  */
-static bool latch_false_at_once(u8 op, u64 imin, u64 imax, u64 bmin, u64 bmax)
+static void rotated_urange(struct cnum64 a, u64 origin, u64 ut_max, u64 *min, u64 *max)
 {
+	a = cnum64_sub(a, cnum64_const(origin));
+	*min = cnum64_umin(a);
+	*max = cnum64_umax(a) & ut_max;
+}
+
+/*
+ * The backedge-taken count of
+ *
+ *	for (x = initial; x <op> bound; x += step)
+ *
+ * The numbers are the points of a circle, see cnum.h. The latch is true on one arc,
+ * [origin, end), and false on the rest of the circle, [end, origin).
+ * min_value is 0, with @sign it is S64_MIN:
+ *
+ *	x <  b	[min_value, b)		3 + 2*i <  7: i ∈ [0,1]
+ *	x <= b	[min_value, b + 1)	3 + 2*i <= 7: i ∈ [0,1,2]
+ *	x >  b	[b + 1, min_value)
+ *	x >= b	[b, min_value)
+ *	x != b	[b + 1, b)		3 + 2*i != 7: i ∈ [0,1]
+ *
+ * 'x <= b' is always true if b + 1 is min_value, and so is 'x >= b' if b is.
+ *
+ * x moves clockwise. If @step is negative, both sides are inverted, as LLVM's howManyLessThans()
+ * does: '7 - 2*i > 3' is '~7 + 2*i < ~3': i ∈ [0,1]. Then the circle is rotated such that origin
+ * is 0. One comparison of unsigned numbers is left, x < end:
+ *
+ *	origin          x     x+step                 end      x+step*count        ut_max
+ *	|---------------|-------|-------|-- .. --|----|-----------|------------------|
+ *	                |<----------- diff ---------->|<overshoot>|
+ *
+ * The count is diff / step, rounded up, as in LLVM's computeMaxBECountForLT(). The loop ends only
+ * if x does not step over [end, origin): end + overshoot <= ut_max.
+ * E.g. 3 + 2*i < 8: diff is 5, the count is 3, overshoot is 1: x is 9.
+ * For '!=' end is ut_max: step has to divide diff.
+ *
+ * With ranges the count is that of the smallest initial value and the largest end. The value that
+ * ends the loop does not get smaller when end grows, so the largest end has the largest
+ * end + overshoot too. Initial values are different:
+ *
+ *	for (u64 i = initial; i > 0; i -= 2)	10: 5 times | 11: i wraps | 12: 6 times
+ *
+ * Both bounds of 10..12 have a count and 11 has none. overshoot is -diff modulo step: when the
+ * initial value grows by 1, so does overshoot, modulo step. For the initial values
+ * imin .. imin + size it is at most 'overshoot of imin' + size while that is below step: exact
+ * for a constant. Else it is step - 1, which is what LLVM's canIVOverflowOnLT() assumes.
+ * '!=' has to hit each bound: what holds for initial values holds for its bounds too.
+ *
+ * 32-bit numbers are compared on the same circle, in the upper half of a u64: cnum64_lshift32().
+ * @unit is the 1 of the text above, 1 or 1 << 32, and ut_max is the largest number, -unit.
+ */
+static bool compute_backedge_taken_count(u8 op, bool sign, u64 unit, struct cnum64 initial,
+					 u64 step, struct cnum64 bound, struct exit_limit *el)
+{
+	u64 min_value = sign ? (u64)S64_MIN : 0, ut_max = -unit, origin = min_value;
+	u64 imin, imax, emin, emax, bmin, bmax, diff, rem, overshoot, size;
+	bool down = (s64)step < 0;
+	struct cnum64 end;
+
+	*el = (struct exit_limit){ .iv = initial };
+	if (down) {
+		/* ~x is ut_max - x. It reverses the order of signed and of unsigned numbers. */
+		initial = cnum64_sub(cnum64_const(ut_max), initial);
+		bound = cnum64_sub(cnum64_const(ut_max), bound);
+		step = -step;
+		op = bpf_flip_opcode(op);
+	}
+	rotated_urange(bound, min_value, ut_max, &bmin, &bmax);
+	end = bound;
+
 	switch (op) {
 	case BPF_JLT:
 	case BPF_JSLT:
-		return imin >= bmax;
+		break;
 	case BPF_JLE:
 	case BPF_JSLE:
-		return imin > bmax;
-	case BPF_JGT:
-	case BPF_JSGT:
-		return imax <= bmin;
+		if (bmax == ut_max)
+			return false;
+		end = cnum64_add(bound, cnum64_const(unit));
+		break;
 	case BPF_JGE:
 	case BPF_JSGE:
-		return imax < bmin;
+		if (!bmin)
+			return false;
+		bmin -= unit;
+		fallthrough;
+	case BPF_JGT:
+	case BPF_JSGT:
+		/*
+		 * x moves away from the bound and wraps: 'i >= 0 && i < 128' as one unsigned
+		 * comparison of a variable that goes down. The smallest bound has the longest arc.
+		 */
+		origin += bmin + unit;
+		end = cnum64_const(min_value);
+		break;
 	case BPF_JNE:
-		return imin == bmax && imax == bmin;
+		/* after each bound and, see below, before each initial value */
+		origin = bound.base + bound.size + unit;
+		break;
 	default:
 		return false;
 	}
-}
 
-static bool compute_backedge_taken_count(u8 op, bool ptrs, u64 initial, u64 step, u64 bound,
-					 u64 *result)
-{
-	u64 rem, diff, backedge_taken_count, bias = is_signed_op(op) || ptrs ? 1ULL << 63 : 0;
-	bool up, down;
+	rotated_urange(initial, origin, ut_max, &imin, &imax);
+	rotated_urange(end, origin, ut_max, &emin, &emax);
 
+	/* An initial value after its bound begins the arc: it goes all the way around. */
+	if (op == BPF_JNE && imax > emin)
+		return false;
 	/*
-	 * The back edge is not taken. That is a count, and a better one than that of
+	 * The backedge is not taken. That is a count, and a better one than that of
 	 * another exit, which may be true for a long time.
-	 * @ptrs: the numbers are offsets from one base. Addresses have the order of signed
-	 * offsets, see compute_backedge_taken_max(). The formulas below give up on an offset
-	 * that gets to the other side of 0.
 	 */
-	if (latch_false_at_once(op, initial ^ bias, initial ^ bias, bound ^ bias, bound ^ bias)) {
-		*result = 0;
+	if (imin >= emax)
 		return true;
-	}
-	if (step == 0)
+	if (!step)
+		return false;
+
+	diff = emax - imin;
+	div64_u64_rem(diff, step, &rem);
+	overshoot = rem ? step - rem : 0;
+	size = imax - imin;
+	if (op == BPF_JNE && check_add_overflow(size, emax - emin, &size))
+		size = ut_max;
+	overshoot = size < step - overshoot ? overshoot + size : step - unit;
+	if (overshoot > ut_max - emax)
 		return false;
-	down = (s64)step < 0;
-	up = (s64)step > 0;
-	diff = bound - initial;
+
+	el->max = div64_u64(diff - 1, step) + 1;
+	/*
+	 * In iteration @max each x is on [end, origin). It stays there until it gets to origin.
+	 * '!=' is false for one number: the end of the arc of one bound is on the arc of another.
+	 */
+	if (op != BPF_JNE || cnum64_is_const(bound))
+		el->false_until = div64_u64(ut_max - imax, step);
+	el->iv = cnum64_add(cnum64_from_urange(imin, emax + overshoot), cnum64_const(origin));
+	el->iv = cnum64_union(initial, el->iv);
+	if (down)
+		el->iv = cnum64_sub(cnum64_const(ut_max), el->iv);
+	return true;
+}
+
+/*
+ * A 64-bit jump tests x, which is zero extended. For a bound in 0 .. U32_MAX it is an unsigned
+ * 32-bit jump. For any other bound it is true for each x or false for each x.
+ * Return false if it can be true for each x. Else drop the bounds for which it is false.
+ */
+static bool bound_of_zext32(u8 op, struct scev_value *bound)
+{
 	switch (op) {
-	case BPF_JLT:
-		/*
-		 * E.g.: 3 + 2*i < 7 ⇔ 2*i < 4 ⇔ i ∈ [0,1].
-		 * Here the inequality describes a set of values `i` might take
-		 * while the latch condition remains true (the backedge is taken).
-		 * The backedge_taken_count is the size of this set.
-		 */
-		if (/*
-		     * The condition is initially true, decreasing values won't
-		     * change that without underflow.
-		     */
-		    down ||
-		    /* Count iterations satisfying the strict inequality, including i=0. */
-		    check_add_overflow(div64_u64(diff - 1, step), 1, &backedge_taken_count) ||
-		    /*
-		     * Check if the last iteration overflows the counter:
-		     *   initial + backedge_taken_count * step > U64_MAX
-		     */
-		    backedge_taken_count > div64_u64(U64_MAX - initial, step))
-			return false;
-		break;
-	case BPF_JLE:
-		/* E.g.: 3 + 2*i ≤ 7 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
-		if (down ||
-		    /* Count iterations satisfying the non-strict inequality. */
-		    check_add_overflow(div64_u64(diff, step), 1, &backedge_taken_count) ||
-		    backedge_taken_count > div64_u64(U64_MAX - initial, step))
-			return false;
-		break;
 	case BPF_JGT:
-		/* E.g.: 7 - 2*i > 3 ⇔ 2*i < 4 ⇔ i ∈ [0,1]. */
-		if (up ||
-		    check_add_overflow(div64_u64(-diff - 1, -step), 1, &backedge_taken_count) ||
-		    /*
-		     * The last iteration underflows the counter if:
-		     *   initial + backedge_taken_count * step < 0 ⇔
-		     *             backedge_taken_count * step < -initial ⇔
-		     *                    backedge_taken_count > initial / -step
-		     * (direction flips because step < 0)
-		     */
-		    backedge_taken_count > div64_u64(initial, -step))
-			return false;
-		break;
 	case BPF_JGE:
-		/* E.g.: 7 - 2*i ≥ 3 ⇔ 2*i ≤ 4 ⇔ i ∈ [0,1,2]. */
-		if (up ||
-		    check_add_overflow(div64_u64(-diff, -step), 1, &backedge_taken_count) ||
-		    backedge_taken_count > div64_u64(initial, -step))
-			return false;
-		break;
-	case BPF_JSLT:
-		if (down ||
-		    check_add_overflow(div64_u64(diff - 1, step), 1, &backedge_taken_count) ||
-		    /*
-		     * Check if the last iteration overflows the signed counter:
-		     *   (s64)initial + backedge_taken_count * step > S64_MAX
-		     */
-		    backedge_taken_count > div64_u64((u64)S64_MAX - initial, step))
-			return false;
-		break;
-	case BPF_JSLE:
-		if (down ||
-		    check_add_overflow(div64_u64(diff, step), 1, &backedge_taken_count) ||
-		    backedge_taken_count > div64_u64((u64)S64_MAX - initial, step))
-			return false;
 		break;
 	case BPF_JSGT:
-		if (up ||
-		    check_add_overflow(div64_u64(-diff - 1, -step), 1, &backedge_taken_count) ||
-		    /*
-		     * The last iteration underflows the signed counter if:
-		     *   (s64)initial + backedge_taken_count * step < S64_MIN ⇔
-		     *                  backedge_taken_count * step < S64_MIN - (s64)initial ⇔
-		     *                         backedge_taken_count > initial - (u64)S64_MIN / -step
-		     *	 (direction flips because step < 0)
-		     */
-		    backedge_taken_count > div64_u64(initial - (u64)S64_MIN, -step))
-			return false;
-		break;
 	case BPF_JSGE:
-		if (up ||
-		    check_add_overflow(div64_u64(-diff, -step), 1, &backedge_taken_count) ||
-		    backedge_taken_count > div64_u64(initial - (u64)S64_MIN, -step))
+		if (cnum64_smin(bound->r64) < 0)
 			return false;
 		break;
-	case BPF_JNE:
-		/*
-		 * For a decreasing counter flip the diff and step:
-		 *   7 - 2*i ≠ 3 ⇔ 2*i ≠ 7 - 3.
-		 */
-		diff = down ? -diff : diff;
-		step = down ? -step : step;
-		backedge_taken_count = div64_u64_rem(diff, step, &rem);
-		if (rem != 0)
+	case BPF_JSLT:
+	case BPF_JSLE:
+		if (cnum64_smax(bound->r64) > U32_MAX)
 			return false;
 		break;
 	default:
-		return false;
-	}
-
-	*result = backedge_taken_count;
-	return true;
-}
-
-/*
- * The first value of the induction variable at the latch and the bound it is
- * compared with, as ranges of unsigned numbers. For a signed comparison the sign
- * bit is flipped: that keeps the order and the differences.
- * [lo, hi] is what the variable can be without wrapping around.
- */
-struct latch_domain {
-	u64 imin, imax;
-	u64 bmin, bmax;
-	u64 lo, hi;
-};
-
-static void latch_domain(const struct linear_latch *latch, const struct scev_value *initial,
-			 const struct scev_value *bound, bool sign, struct latch_domain *d)
-{
-	u64 bias;
-
-	if (latch->jmp32) {
-		bias = sign ? 1U << 31 : 0;
-		d->imin = (sign ? (u32)initial->s32_min : initial->u32_min) ^ bias;
-		d->imax = (sign ? (u32)initial->s32_max : initial->u32_max) ^ bias;
-		d->bmin = (sign ? (u32)bound->s32_min : bound->u32_min) ^ bias;
-		d->bmax = (sign ? (u32)bound->s32_max : bound->u32_max) ^ bias;
-		d->lo = 0;
-		d->hi = U32_MAX;
-		return;
-	}
-	bias = sign ? 1ULL << 63 : 0;
-	d->bmin = (sign ? (u64)bound->smin : bound->umin) ^ bias;
-	d->bmax = (sign ? (u64)bound->smax : bound->umax) ^ bias;
-	if (latch->zext32) {
-		/* zero extended, so it is not negative */
-		d->imin = initial->u32_min ^ bias;
-		d->imax = initial->u32_max ^ bias;
-		d->lo = bias;
-		d->hi = bias + U32_MAX;
-		return;
+		if (cnum64_umax(bound->r64) > U32_MAX)
+			return false;
 	}
-	d->imin = (sign ? (u64)initial->smin : initial->umin) ^ bias;
-	d->imax = (sign ? (u64)initial->smax : initial->umax) ^ bias;
-	d->lo = 0;
-	d->hi = U64_MAX;
-	/* It's base + offset that must not wrap around. The limit is that of reg_not_null(). */
-	if (initial->ptr_reg >= 0) {
-		d->lo = bias - BPF_MAX_VAR_OFF;
-		d->hi = bias + BPF_MAX_VAR_OFF;
+	if (cnum64_umax(bound->r64) > U32_MAX) {
+		bound->r64 = cnum64_intersect(bound->r64, cnum64_from_urange(0, U32_MAX));
+		bound->r32 = cnum32_from_cnum64(bound->r64);
 	}
-}
-
-/*
- * '!=' with a step of one ends when the variable gets to the bound, given that
- * it is on the right side of the bound to begin with.
- */
-static bool count_ne_ranges(const struct latch_domain *d, bool down, u64 *cnt)
-{
-	if (d->bmin < d->lo || d->bmax > d->hi)
-		return false;
-	if (down ? d->imin < d->bmax : d->imax > d->bmin)
-		return false;
-	*cnt = down ? d->imax - d->bmin : d->bmax - d->imin;
-	return true;
-}
-
-static bool domain_add(const struct latch_domain *d, u64 v, s64 delta, u64 *res)
-{
-	if (delta >= 0 ? (u64)delta > d->hi - v : -(u64)delta > v - d->lo)
-		return false;
-	*res = v + delta;
 	return true;
 }
 
 /*
- * The number of iterations depends on the first value, so 'first + slope * count'
- * is far off when the first value is a range. There is a better bound for
- * the variable that the latch tests. At the loop header it is
- * - what it is at the entry, or
- * - a value that the latch let through, @last is the last of them, plus what
- *   is added between the latch and the header.
+ * The iteration count depends on the initial value, so 'initial + slope * count' is far off when
+ * the initial value is a range. There is a better bound for the variable that the latch tests:
+ * at the loop header it is what it is at the latch, @iv, minus what the iteration adds on the way.
+ *
+ * A 32-bit latch tells that about the low 32 bits of the register. It can test a copy of a 64-bit
+ * induction variable, 'r6 += 1; w3 = w6; if r3 < 10 goto l': (u32)(a + b) is (u32)a + (u32)b, so
+ * the range holds whatever the upper 32 bits of the register and of the step are.
  */
 static void latch_iv_range(struct bpf_verifier_env *env, struct bpf_func_state *st,
-			   const struct linear_latch *latch, const struct latch_domain *d,
-			   bool sign, bool down, u64 step, u64 last, struct bpf_loop_iters *iters)
+			   const struct linear_latch *latch, struct cnum64 iv,
+			   struct bpf_loop_iters *iters)
 {
 	struct scev *scev = env->scev;
-	struct scev_value off, reg_val;
-	u64 bias, min, max, next;
+	struct scev_value off;
 	u32 l, r, regno;
-	s64 c = 0;
+	u64 c = 0;
 
 	l = latch->base_expr;
 	if (!is_reg_or_low32(scev, l, &regno)) {
 		if (!is_add(scev, latch->base_expr, &l, &r) || !is_reg_or_low32(scev, l, &regno) ||
-		    !eval_expr(env, scev, st, r, &off) || !scev_value_is_const(&off) ||
+		    !eval_expr(env, scev, st, r, &off) || !cnum64_is_const(off.r64) ||
 		    off.ptr_reg >= 0)
 			return;
-		c = latch->jmp32 || latch->zext32 ? (s32)off.smin : off.smin;
-		if (c == S64_MIN)
-			return;
+		c = off.r64.base;
 	}
-	/* the lower half says nothing about a value that does not fit in it */
-	if (latch->jmp32 &&
-	    (!latch->zext32 || !eval_expr(env, scev, st, l, &reg_val) || reg_val.umax > U32_MAX))
-		return;
-	if (last < d->lo || last > d->hi ||
-	    !domain_add(d, d->imin, -c, &min) ||
-	    !domain_add(d, d->imax, -c, &max) ||
-	    !domain_add(d, last, -c, &next) ||
-	    !domain_add(d, next, down ? -(s64)step : (s64)step, &next))
-		return;
-	if (down)
-		min = min(min, next);
+	scalar_set_unknown(&iters->iv_range);
+	if (latch->jmp32 || latch->zext32)
+		iters->iv_range.r32 = cnum32_sub(cnum32_rshift32(iv), cnum32_const(c));
 	else
-		max = max(max, next);
-
-	if (latch->jmp32) {
-		bias = sign ? 1U << 31 : 0;
-		min ^= bias;
-		max ^= bias;
-		/* negative as s32 is large as zero extended u64 */
-		if (min > max)
-			return;
-		iters->iv_range = cnum64_from_urange(min, max);
-	} else if (sign) {
-		bias = 1ULL << 63;
-		iters->iv_range = cnum64_from_srange(min ^ bias, max ^ bias);
-	} else {
-		iters->iv_range = cnum64_from_urange(min, max);
-	}
+		iters->iv_range.r64 = cnum64_sub(iv, cnum64_const(c));
 	iters->iv_reg = regno;
 }
 
-/*
- * The first value or the bound is not a constant. The count is for the pair that is
- * the furthest apart.
- */
-static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_func_state *st,
-				       const struct linear_latch *latch,
-				       const struct scev_value *initial,
-				       const struct scev_value *step_val,
-				       const struct scev_value *bound,
-				       struct bpf_loop_iters *iters, u64 *result)
-{
-	struct scev *scev = env->scev;
-	bool sign = is_signed_op(latch->op), down;
-	struct scev_value reg_val;
-	struct latch_domain d;
-	/* the last value that the latch lets through */
-	u64 step, cnt, last;
-	u32 l, r;
-
-	/*
-	 * The jump compares addresses, the ranges are those of the offsets from one base.
-	 * fp-1 is below fp+0: whatever the op is, addresses have the order of signed offsets,
-	 * as long as base + offset does not wrap around.
-	 */
-	if (initial->ptr_reg >= 0)
-		sign = true;
-	/*
-	 * (zext32 (linear ...)) is zext32() of something in all iterations but
-	 * the first one at the loop header, where it is what the register has.
-	 */
-	if (latch->zext32 && !latch->jmp32) {
-		l = latch->base_expr;
-		if (!is_reg_or_low32(scev, l, &r) && !is_add(scev, latch->base_expr, &l, &r))
-			return false;
-		if (!eval_expr(env, scev, st, l, &reg_val) || reg_val.umax > U32_MAX)
-			return false;
-	}
-
-	step = latch->jmp32 || latch->zext32 ? (u64)(s64)(s32)step_val->umin : step_val->umin;
-	if (!step)
-		return false;
-	down = (s64)step < 0;
-	if (down)
-		step = -step;
-
-	latch_domain(latch, initial, bound, sign, &d);
-	/* nothing limits the offset of a pointer that is compared only */
-	if (initial->ptr_reg >= 0 &&
-	    (d.imin < d.lo || d.imax > d.hi || d.bmin < d.lo || d.bmax > d.hi))
-		return false;
-	if (latch_false_at_once(latch->op, d.imin, d.imax, d.bmin, d.bmax)) {
-		*result = 0;
-		return true;
-	}
-
-	/*
-	 * The value that ends the loop must not wrap around. It is less than a step
-	 * away from the bound whatever the first value is.
-	 */
-	switch (latch->op) {
-	case BPF_JLT:
-	case BPF_JSLT:
-		if (down ||
-		    check_add_overflow(div64_u64(d.bmax - d.imin - 1, step), 1, &cnt) ||
-		    d.bmax > d.hi || step - 1 > d.hi - d.bmax)
-			return false;
-		last = d.bmax - 1;
-		break;
-	case BPF_JLE:
-	case BPF_JSLE:
-		if (down ||
-		    check_add_overflow(div64_u64(d.bmax - d.imin, step), 1, &cnt) ||
-		    d.bmax > d.hi || step > d.hi - d.bmax)
-			return false;
-		last = d.bmax;
-		break;
-	case BPF_JGT:
-	case BPF_JSGT:
-		if (!down ||
-		    check_add_overflow(div64_u64(d.imax - d.bmin - 1, step), 1, &cnt) ||
-		    d.bmin < d.lo || step - 1 > d.bmin - d.lo)
-			return false;
-		last = d.bmin + 1;
-		break;
-	case BPF_JGE:
-	case BPF_JSGE:
-		if (!down ||
-		    check_add_overflow(div64_u64(d.imax - d.bmin, step), 1, &cnt) ||
-		    d.bmin < d.lo || step > d.bmin - d.lo)
-			return false;
-		last = d.bmin;
-		break;
-	case BPF_JNE:
-		if (step != 1)
-			return false;
-		if (!count_ne_ranges(&d, down, &cnt)) {
-			sign = true;
-			latch_domain(latch, initial, bound, true, &d);
-			if (!count_ne_ranges(&d, down, &cnt))
-				return false;
-		}
-		if (!cnt)
-			return false;
-		last = down ? d.bmin + 1 : d.bmax - 1;
-		break;
-	default:
-		return false;
-	}
-
-	/*
-	 * A 32-bit latch sees the lower half of the step. The register at the header can be
-	 * a 64-bit variable that moves by all of it: the range is for a step that is the same.
-	 */
-	if (step_val->umin == (down ? -step : step))
-		latch_iv_range(env, st, latch, &d, sign, down, step, last, iters);
-	*result = cnt;
-	return true;
-}
-
-/*
- * @latch is false in iteration @cnt, counted from 0. That is the end of a loop with one back
- * edge. A loop with several back edges may go on through another one and get to @latch
- * again. Return the last iteration in which @latch is still false:
- * - '<', '>' and the like stay false until the variable leaves [lo, hi] of latch_domain():
- *   a number wraps around, the offset of a pointer gets too large to tell,
- * - '!=' is false in one iteration. Which one is known for constants only.
- */
-static u64 latch_false_until(const struct linear_latch *latch, const struct scev_value *initial,
-			     const struct scev_value *step_val, const struct scev_value *bound,
-			     u64 cnt)
-{
-	bool sign = is_signed_op(latch->op) || initial->ptr_reg >= 0;
-	struct latch_domain d;
-	u64 step;
-
-	if (latch->op == BPF_JNE)
-		return scev_value_is_const(initial) && scev_value_is_const(bound) ? cnt : 0;
-
-	step = latch->jmp32 || latch->zext32 ? (u64)(s64)(s32)step_val->umin : step_val->umin;
-	latch_domain(latch, initial, bound, sign, &d);
-	/* The first value is in [lo, hi]. do_check() rejects a pointer with a larger offset. */
-	return (s64)step < 0 ? div64_u64(d.imin - d.lo, -step) : div64_u64(d.hi - d.imax, step);
-}
-
 /*
  * Loop with post-condition:
  *
@@ -4076,11 +3835,13 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 	struct bpf_loop *loop = aux[bpf_loop_at_index(env, latch->insn_idx)].loop;
 	struct scev *scev = env->scev;
-	struct scev_value initial_val, step_val, bound_val;
-	u64 step, bound, initial, total_change, backedge_taken_count;
-	struct linear_latch counted;
-	u8 op = latch->op;
-	bool konst, sign32 = latch->jmp32 && is_signed_op(op);
+	struct scev_value initial_val, step_val, bound_val, reg_val;
+	bool sign = is_signed_op(latch->op), konst;
+	struct cnum64 initial, bound, off;
+	u64 step, unit = 1;
+	struct exit_limit el;
+	bool low32;
+	u32 l, r;
 
 	iters->iv_reg = -1;
 
@@ -4100,107 +3861,74 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	if (!scev_value_compatible(env, st, &initial_val, &bound_val, latch))
 		return false;
 
-	if (!scev_value_is_const(&step_val))
+	if (!cnum64_is_const(step_val.r64))
 		return false;
-	/*
-	 * 'i >= 0 && i < 128' is one unsigned test. A counter that goes down stays below 128.
-	 * The loop ends when it gets below 0. A 64-bit jump compares all 64 bits of the bound.
-	 * The latch of the caller stays as it is: same_latch() compares what the prog tests.
-	 */
-	if ((op == BPF_JLT || op == BPF_JLE) && initial_val.ptr_reg < 0 &&
-	    (latch->jmp32 || latch->zext32 ?
-	     (s32)step_val.umin < 0 && initial_val.u32_min < bound_val.u32_max &&
-	     (latch->jmp32 ? bound_val.u32_max : bound_val.umax) <= S32_MAX :
-	     (s64)step_val.umin < 0 && initial_val.umin < bound_val.umax &&
-	     bound_val.umax <= S64_MAX)) {
-		counted = *latch;
-		latch = &counted;
-		op = latch->op = BPF_JSGE;
-		bound_val = (struct scev_value){ .ptr_reg = -1 };
-		sign32 = true;
-	}
-	konst = scev_value_is_const(&initial_val) && scev_value_is_const(&bound_val);
-	if (!konst) {
-		if (!compute_backedge_taken_max(env, st, latch, &initial_val, &step_val, &bound_val,
-						iters, &backedge_taken_count))
+	konst = cnum64_is_const(initial_val.r64) && cnum64_is_const(bound_val.r64);
+
+	if (latch->zext32 && !latch->jmp32) {
+		/*
+		 * (zext32 (linear ...)) is zext32() of something in all iterations but
+		 * the first one at the loop header, where it is what the register has:
+		 * no difference if that fits in 32 bits. (+ register imm) is zero extended
+		 * in the first iteration too, simplify() makes this shape of
+		 * (zext32 (+ ... imm)) only. Either the register or the sum has to fit.
+		 */
+		l = latch->base_expr;
+		if (!is_reg_or_low32(scev, l, &r) && !is_add(scev, latch->base_expr, &l, &r))
 			return false;
-		/* as below */
-		if (backedge_taken_count >= U32_MAX - 1)
+		if (cnum64_umax(initial_val.r64) > U32_MAX &&
+		    (!eval_expr(env, scev, st, l, &reg_val) || cnum64_umax(reg_val.r64) > U32_MAX))
 			return false;
-		goto counted;
+		if (!bound_of_zext32(latch->op, &bound_val))
+			return false;
+		sign = false;
 	}
-
-	initial = initial_val.umin;
-	step = step_val.umin;
-	bound = bound_val.umin;
-
-	/*
-	 * The code below only handles mixed 64-bit/32-bit comparisons/recurrences
-	 * when initial bounds and step fit in 32-bit domain.
-	 */
-	if (latch->zext32 || latch->jmp32) {
+	low32 = initial_val.ptr_reg < 0 && (latch->jmp32 || latch->zext32);
+	initial = scalar_arc(scalar_of(&initial_val), low32);
+	bound = scalar_arc(scalar_of(&bound_val), low32);
+	step = step_val.r64.base;
+	if (initial_val.ptr_reg >= 0) {
 		/*
-		 * With the above constraint doing `l: w0 += 1; if r0 s< 256 goto l;`
-		 *                is equivalent to `l: w0 += 1; if r0 < 256 goto l;`
+		 * The jump compares addresses, the ranges are those of the offsets from one base.
+		 * fp-1 is below fp+0: whatever the op is, addresses have the order of signed
+		 * offsets, as long as base + offset does not wrap around. The limit is that of
+		 * reg_not_null(). Nothing limits the offset of a pointer that is compared only.
 		 */
-		if (sign32) {
-			initial = (s64)(s32)(u32)initial;
-			bound   = (s64)(s32)(u32)bound;
-			step    = (s64)(s32)(u32)step;
-		} else {
-			initial = (u32)initial;
-			bound   = (u32)bound;
-			step    = (s64)(s32)(u32)step;
-		}
-	}
-	if (latch->zext32 ^ latch->jmp32 && (initial != initial_val.umin ||
-					     bound != bound_val.umin ||
-					     step != step_val.umin)) {
-		if (env->log.level & BPF_LOG_LEVEL2)
-			bpf_log(&env->log,
-				"scev: mixed-width latch has operands outside 32-bit ranges\n");
-		return false;
-	}
-	/*
-	 * 7 goes down to -1, -8 goes up to 0: on the wrong side of the bound as unsigned
-	 * numbers, on the right side as signed ones. From 4 up to 1 is wrong both ways.
-	 */
-	if (op == BPF_JNE && latch->zext32 && ((s64)step < 0 ? initial < bound : initial > bound)) {
-		initial = (s64)(s32)(u32)initial;
-		bound   = (s64)(s32)(u32)bound;
-		sign32 = true;
+		off = cnum64_from_srange(-BPF_MAX_VAR_OFF, BPF_MAX_VAR_OFF);
+		if (!cnum64_is_subset(off, initial) || !cnum64_is_subset(off, bound))
+			return false;
+		sign = true;
+	} else if (low32) {
+		step <<= 32;
+		unit <<= 32;
 	}
 
-	if (!compute_backedge_taken_count(op, initial_val.ptr_reg >= 0, initial, step, bound,
-					  &backedge_taken_count))
+	/* no bound is left for which the latch can be true */
+	if (cnum64_is_empty(bound))
+		el = (struct exit_limit){};
+	else if (!compute_backedge_taken_count(latch->op, sign, unit, initial, step, bound, &el))
 		return false;
-
 	/*
 	 * max_header_count is u32 and U32_MAX means "infinite",
 	 * check to avoid overflow below.
 	 */
-	if (backedge_taken_count >= U32_MAX - 1)
+	if (el.max >= U32_MAX - 1)
 		return false;
-
-	if (latch->zext32 || latch->jmp32) {
-		/* total_change is guaranteed not to overflow at this point */
-		total_change = initial + step * backedge_taken_count;
-		if (sign32) {
-			if ((s64)total_change < S32_MIN || (s64)total_change > S32_MAX)
-				return false;
-		} else {
-			if (total_change > U32_MAX)
-				return false;
-		}
+	if (el.max && initial_val.ptr_reg >= 0) {
+		/* el.iv has the value that ends the loop. Past the limit the latch may be true. */
+		if (!cnum64_is_subset(off, el.iv))
+			return false;
+		el.false_until = min(el.false_until, (s64)step < 0 ?
+				     div64_u64(cnum64_smin(initial) + BPF_MAX_VAR_OFF, -step) :
+				     div64_u64(BPF_MAX_VAR_OFF - cnum64_smax(initial), step));
 	}
+	/* linear_bounds() is exact for constants */
+	if (el.max && !konst)
+		latch_iv_range(env, st, latch, el.iv, iters);
 
-counted:
-	/* A latch that is false at once may be on its way to the values for which it's true. */
-	*false_until = !backedge_taken_count ? 0 :
-		       latch_false_until(latch, &initial_val, &step_val, &bound_val,
-					 backedge_taken_count);
+	*false_until = el.false_until;
 	/* The header executes once on entry and once for each taken backedge, hence +1. */
-	iters->max_header_count = backedge_taken_count + 1;
+	iters->max_header_count = el.max + 1;
 	/*
 	 * The latch is a conditional jump with one jump target exiting the loop.
 	 * The loop still, however can have multiple exits.
@@ -4363,14 +4091,7 @@ static bool is_widenable_any(struct bpf_verifier_env *env, struct bpf_func_state
 	return true;
 }
 
-struct bounds {
-	struct cnum64 r64;
-	struct cnum32 r32;
-	u16 base;
-	u16 step;
-};
-
-static void log_bounds(struct bpf_verifier_env *env, const struct bounds *bounds)
+static void log_bounds(struct bpf_verifier_env *env, const struct scalar *bounds)
 {
 	struct bpf_verifier_log *log = &env->log;
 
@@ -4454,12 +4175,12 @@ static struct bpf_reg_state *spill32_counter(struct scev *scev, struct bpf_func_
 }
 
 /* Compute the range an induction variable in `reg` spans over the loop. */
-static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
-			  struct linear_coefs *coefs, struct bounds *out)
+static void linear_bounds(const struct scalar *reg, u32 max_header_count,
+			  struct linear_coefs *coefs, struct scalar *out)
 {
 	s64 slope = coefs->slope;
 	s64 slope_abs = slope < 0 ? -slope : slope;
-	struct bpf_reg_state low;
+	struct scalar low;
 	s64 min_val, max_val;
 	struct cnum64 r64;
 	struct cnum32 r32;
@@ -4469,12 +4190,11 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 	if (coefs->spill32) {
 		/* what 'rX = *(u32 *)(r10 - 8)' loads */
 		low = *reg;
-		low.var_off = tnum_subreg(reg->var_off);
-		low.r64 = cnum64_zext32(reg->r32);
+		scalar_zext32(&low);
 		reg = &low;
 	}
-	min_val = reg_smin(reg);
-	max_val = reg_smax(reg);
+	min_val = cnum64_smin(reg->r64);
+	max_val = cnum64_smax(reg->r64);
 	overflow = check_mul_overflow(slope, (s64)max_header_count - 1, &total_change) ||
 		   (slope > 0 && check_add_overflow(max_val, total_change, &max_val)) ||
 		   (slope < 0 && check_add_overflow(min_val, total_change, &min_val));
@@ -4495,7 +4215,7 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 		 * otherwise `base + slope * k` would define different sets of points between
 		 * the two.
 		 */
-		overflow |= imod(reg_smin(reg), slope_abs) !=
+		overflow |= imod(cnum64_smin(reg->r64), slope_abs) !=
 			    imod(cnum64_smin(r64), slope_abs);
 		/*
 		 * Full range is a union of a reg's value at loop entry,
@@ -4511,11 +4231,12 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 	 */
 	if (cnum64_is_const(reg->r64) && !overflow) {
 		out->step = slope_abs;
-		out->base = imod(reg_smin(reg), out->step);
+		out->base = imod(cnum64_smin(reg->r64), out->step);
 	} else {
 		out->step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
 		out->base = 0;
 	}
+	out->var_off = tnum_unknown;
 	out->r64 = r64;
 	out->r32 = r32;
 }
@@ -4542,16 +4263,21 @@ static bool is_iv_at_header(struct bpf_verifier_env *env, const struct bpf_func_
 	       const_diff_at_header(env, h, iv_reg, r, &delta) && !delta;
 }
 
-static void iv_bounds(struct bounds *bounds, const struct linear_coefs *coefs,
-		      struct cnum64 iv_range)
+/*
+ * A 32-bit latch bounds the low 32 bits of the induction variable. What follows for all 64 bits
+ * is the reduction that reg_bounds_sync() makes. It is made here for the log, and because two
+ * ranges that are not empty can have no number in common.
+ */
+static void iv_bounds(struct scalar *bounds, const struct scalar *iv_range)
 {
-	struct cnum64 r64 = cnum64_intersect(bounds->r64, iv_range);
+	struct cnum32 r32 = cnum32_intersect(bounds->r32, iv_range->r32);
+	struct cnum64 r64 = cnum64_intersect(bounds->r64, iv_range->r64);
 
-	/* The latch bounds the zero extension. With bit 31 set the sign extension differs. */
-	if (coefs->sext32 && cnum64_umax(iv_range) > S32_MAX)
+	r64 = cnum64_cnum32_intersect(r64, r32);
+	if (cnum64_is_empty(r64))
 		return;
-	if (!cnum64_is_empty(r64))
-		bounds->r64 = r64;
+	bounds->r64 = r64;
+	bounds->r32 = r32;
 }
 
 /*
@@ -4752,7 +4478,7 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		iters->min_header_count = min(iters->min_header_count, tmp.min_header_count);
 		/* at the header the variable is what one of the latches lets through */
 		if (iters->iv_reg >= 0 && iters->iv_reg == tmp.iv_reg)
-			iters->iv_range = cnum64_union(iters->iv_range, tmp.iv_range);
+			scalar_union(&iters->iv_range, &tmp.iv_range);
 		else
 			iters->iv_reg = -1;
 	}
@@ -5019,7 +4745,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 	struct bpf_reg_state *reg, *spill32;
 	struct env *header_env;
 	struct linear_coefs coefs;
-	struct bounds bounds;
+	struct scalar bounds;
 	u32 r, r_expr, a, b;
 	int insn_idx = st->insn_idx;
 	int err;
@@ -5087,10 +4813,10 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			err = reg ? 0 : scev_reg_for_write(env, cur_func, r, &reg);
 			if (err)
 				return err;
-			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
+			linear_bounds(scalar_of(reg), iters->max_header_count, &coefs, &bounds);
 			if (is_iv_at_header(env, entry_func, insn_idx, iters->iv_reg,
 					    coefs.base_reg))
-				iv_bounds(&bounds, &coefs, iters->iv_range);
+				iv_bounds(&bounds, &iters->iv_range);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
 				log_reg(env, r);
@@ -5102,8 +4828,7 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			/* "at pkt_end" and "beyond pkt_end" are not valid in all iterations */
 			if (type_is_pkt_pointer(reg->type))
 				reg->range = max(reg->range, 0);
-			err = bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
-						bounds.base, bounds.step);
+			err = bpf_set_reg_range(env, reg, &bounds);
 			if (err)
 				return err;
 			mark_scev_reg_scratched(env, r);
@@ -5160,10 +4885,10 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 	struct bpf_reg_state *reg, *entry_reg;
 	struct scev *scev = env->scev;
 	struct linear_coefs coefs;
+	struct scalar bounds, off;
 	struct env *header_env;
-	struct bounds bounds;
 	u32 r, r_scev;
-	s64 moved, sum;
+	s64 moved;
 	int err;
 
 	if (entry_state->curframe != cur_func_state->frameno) {
@@ -5211,21 +4936,17 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		    (coefs.zext32 && entry_reg->type != SCALAR_VALUE))
 			continue;
 clamp:
-		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
+		linear_bounds(scalar_of(entry_reg), max_header_count, &coefs, &bounds);
 		/*
 		 * iv_range is the range at the header. After the latch @r can be the zero extension
 		 * of its header value. @reg went through that insn and has what holds of the range.
 		 */
 		if (!behind &&
 		    is_iv_at_header(env, entry_st, insn_idx, entry->iv_reg, coefs.base_reg))
-			iv_bounds(&bounds, &coefs, entry->iv_range);
+			iv_bounds(&bounds, &entry->iv_range);
 		if (moved) {
-			/* a sum that can wrap has another residue, see scalar_step_add() */
-			if (check_add_overflow(cnum64_smin(bounds.r64), moved, &sum) ||
-			    check_add_overflow(cnum64_smax(bounds.r64), moved, &sum))
-				continue;
-			bounds.r64 = cnum64_add(bounds.r64, cnum64_from_srange(moved, moved));
-			bounds.base = (bounds.base + imod(moved, bounds.step)) % bounds.step;
+			scalar_set_const(&off, moved);
+			scalar_add(&bounds, &bounds, &off);
 		}
 		if (behind) {
 			/* jumps on the way may have told more */
@@ -5253,8 +4974,7 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 		 */
 		if (type_is_pkt_pointer(reg->type))
 			reg->range = max(entry_reg->range, 0);
-		err = bpf_set_reg_range(env, reg, bounds.r64, bounds.r32,
-					bounds.base, bounds.step);
+		err = bpf_set_reg_range(env, reg, &bounds);
 		if (err)
 			return err;
 		mark_scev_reg_scratched(env, r);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1200ebb875a7..56924ce392e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18291,15 +18291,11 @@ void bpf_trim_pkt_range(struct bpf_reg_state *reg, s64 smax)
 }
 
 int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
-		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
+		      const struct scalar *range)
 {
-	reg->r64 = r64;
-	reg->r32 = r32;
-	reg->step = step;
-	reg->base = base;
-	reg->var_off = tnum_unknown;
+	*scalar_of(reg) = *range;
 	reg_bounds_sync(reg); /* this should infer the tnum alignment */
-	bpf_trim_pkt_range(reg, cnum64_smax(r64));
+	bpf_trim_pkt_range(reg, cnum64_smax(range->r64));
 	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
 }
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index 24ed0d69503d..5ebd3dfadac2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -119,8 +119,8 @@ LOOP(behind_moved_bad, "w8 = 0; r9 = r6; r9 += 2044;", MOVED(4) "goto 1b;")
 
 /*
  * A number goes up by 3 and has moved in front of the jump. At the store it is @first or
- * @first + 3. Moved over S64_MAX it has another residue: 2^64 is not a multiple of 3. It keeps
- * the range of all three iterations then.
+ * @first + 3. Moved over S64_MAX it has another residue: 2^64 is not a multiple of 3. The range
+ * wraps with it, the step is dropped.
  */
 #define NUM(by, back, first, off)						\
 	"r3 = " #by " ll; r9 += r3; if w8 == 2 goto 9f; r2 = r9; r3 = " #first " ll; r2 -= r3;" \
@@ -129,7 +129,7 @@ LOOP(behind_moved_bad, "w8 = 0; r9 = r6; r9 += 2044;", MOVED(4) "goto 1b;")
 #define FAR(off)	NUM(0x7fffffffffffffff, 0x8000000000000004, 0x7ffffffffffffffa, off)
 
 OK("behind the jump that counts, a number has moved over S64_MAX", "3")
-LOOP(moved_over, "w8 = 0; r5 = r6; r9 = 0x7fffffffffffffcd ll;", OVER(2041))
+LOOP(moved_over, "w8 = 0; r5 = r6; r9 = 0x7fffffffffffffcd ll;", OVER(2044))
 
 BAD("behind the jump that counts, a number has moved over S64_MAX, too far")
 LOOP(moved_over_bad, "w8 = 0; r5 = r6; r9 = 0x7fffffffffffffcd ll;", OVER(2045))
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 6fbe4b435d35..b1fede94edd8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1044,11 +1044,10 @@ POST_COND_TEST32(post32_sgt,       "s>", (__u32)INT32_MIN + 6,  -2u, (__u32)INT3
 POST_COND_TEST32(post32_sge,       "s>=",                 -1u,  -2u,              -7u, "header_count is [0..4] ")
 
 /*
- * When computing 32-bit iteration bounds, scev.c:compute_max_iters() does
- * the computation in the 64-bit domain first. For unsigned JMP32 comparisons,
- * it zero-extends the initial value and bound, but sign-extends the step.
+ * For a JMP32 comparison scev.c:compute_max_iters() takes the low 32 bits of the
+ * initial value, the bound and the step.
  * Hence pick negative 64-bit initial values and bounds, and encode negative
- * steps as positive u32 constants, so both conversions affect the computation.
+ * steps as positive u32 constants, so that the upper 32 bits differ.
  * post32_lt also checks that an exit exactly at U32_MAX is accepted.
  */
 POST_COND_TEST32(post32_lt,        "<",                    -7,    2,               -1, "header_count is [0..3] ")
@@ -1056,12 +1055,12 @@ POST_COND_TEST32(post32_le,        "<=",                   -9,    2,
 POST_COND_TEST32(post32_gt,        ">",                    -1,  -2u,               -7, "header_count is [0..3] ")
 POST_COND_TEST32(post32_ge,        ">=",                   -1,  -2u,               -7, "header_count is [0..4] ")
 POST_COND_TEST32(post32_ne,        "!=",                   -1,  -2u,               -7, "header_count is [0..3] ")
-/* across 0: in order as signed numbers. From 4 up to 1 goes all the way around. */
+/* across 0: '!=' has no order. From 4 up to 1 goes all the way around. */
 POST_COND_TEST32(post32_ne_to_m1,   "!=",                    3,  -1u,               -1, "header_count is [0..4] ")
 POST_COND_TEST32(post32_ne_to_0,    "!=",                   -4,    1,                0, "header_count is [0..4] ")
 POST_COND_TEST32(post32_ne_to_m1_2, "!=",                    3,  -2u,               -1, "header_count is [0..2] ")
 POST_COND_TEST32(post32_ne_miss,    "!=",                    4,  -2u,               -1, "can't compute iterations count")
-POST_COND_TEST32(post32_ne_around,  "!=",                    4,    1,                1, "can't compute iterations count")
+POST_COND_TEST32(post32_ne_around,  "!=",                    4,    1,                1, "header_count is [0..4294967293] ")
 
 /* An exit exactly at S32_MAX is accepted as well. */
 POST_COND_TEST32(post32_slt_max,   "s<",        INT32_MAX - 6,    2,        INT32_MAX, "header_count is [0..3] ")
@@ -1151,9 +1150,9 @@ RANGE_TEST(range_post_lt,   "",  3, 10,     2,  14, 15,  POST("r6 += r8", "r6 <
 /* 32 bits. r6 is negative at the entry and zero extended after that. */
 RANGE_TEST(range32_slt,    "s", -5,  5,     2,   7,  9,  POST("w6 += w8", "w6 s< w7"),
 	   COUNTED(7, "-5..0xffffffff"))
-/* Only the jump has 32 bits. The low half says nothing about r6: it's 'first + step * count'. */
+/* Only the jump has 32 bits. It bounds the low half of r6, 'first + step * count' the rest. */
 RANGE_TEST(range32_jump,    "",  3, 10,     2,  13, 15,  POST("r6 += r8", "w6 < w7"),
-	   COUNTED(6, "3..20"))
+	   COUNTED(6, "3..14"))
 
 #define COUNTED_2G(range)									\
 	__msg("loop header at {{[0-9]+}}, header_count is [0..2147483{{[0-9]+}}] ")		\
-- 
2.55.0

