Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749363;
	b=Z6c2BT8VdAq5aTbZNOKyiUsloP/Az4cxHl3rAHxRzqezuc5xOAem86Qv9jV9Ngf0aAG+
	 hOAfqm/nELWODEA7eCwJrVfM3zo5X4tnhYnAoCEWwkJ1fOJIon02c9ihDwOxdRIWU634R
	 VoWwbEaYryQpf+EKy4T6zjeQI+2Qam2+PrkOtglLsHvyvNwKvTW2vKgJZGqieAi0golfX
	 Xykad4mmrG5bSJK+XXuhVhvfXa9z6VwrHQXNSo0eu81hBWX9h11rjjzNSufpw/LgDWTOg
	 eqX/mHje0xTO83RN73HEmsNkl8yvysdWESOhMJbvBjyLL+ZHWzG+bcpbxP6ymEy47pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hPBZU33k7S1Eje+NJZZrQhvPVfyCW9b23U84b5OyoEs=;
	b=sSg5TSVKIHTAOffzH5hlqK5hs+VNNe2qDleGcm20X0hteOA17RbNj6jW3SZs0o+OwoUL
	 3OwgG7q5LXStcR8vcQJlmR1rjmD2m21Nk4M9vOrM7cH5HN31X6zRTiMl66+HbhdUhexwC
	 TXb94PeREOF43xEWrb9ItqNPRjfTxvsxgMEZXU2H+yLK3sqOboD778BSUUt5wXp8Krhf5
	 Vn6IXXcDBtlCqn8BrmIBYHFs1ekHirROo6TGp5IZ/kOIREE9+hQNIhgvL0AhMD+AlohSO
	 YNdTf8BFNOzZORwew6pOmZh6AK48BeMEmKytoGACZING22/hHiv6aERFS30HQVbpLQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPftxZF2;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCBC606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DCBC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZPftxZF2
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a064dcfcfdso71181b3a.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749362; x=1794354162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hPBZU33k7S1Eje+NJZZrQhvPVfyCW9b23U84b5OyoEs=;
        b=ZPftxZF2slns8D5ndtoP3UdKVFaXU2dzO81IWeE5MUH2vwVUBD4duUYO+ZWO42LeKJ
         9rbTq7PTGl78cW8StlXabNdqyUh9lCSoalMFkpx8/fyOYhJ0ODBIITI9YWWzqKfj02BO
         7VvFJ1vVbF1TxqqJ5HlwnKHh2HcKUpbjD6SuIoIR6cBBhsq1vd8224e3+Pm0ImefkMbY
         FUjtGv0pBYD+6HDEuM/McGYePA6rQVCQokA+VkwE0W+l2c30G5AgIEFayY7arsdFJTDB
         jptDkr3jM6lZ5C99KagdYCzSKXW8OutyJ9TM9m/etdF7ILuRA34UGQkchlg8XFbaRFTc
         6sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749362; x=1794354162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPBZU33k7S1Eje+NJZZrQhvPVfyCW9b23U84b5OyoEs=;
        b=DZx26qxD9SNU0jhu/Y/CK9DF0zZ+2da5/GEZ2N5xAGMqQMerCcBnZJRNKE3Z3VQsnq
         nfZr333I4qvQWt2aUHPo5T/ZNT53E7muPrwJ8cJchtk1zKEv2y6ESpVD75+KQRi8HFn6
         aaRK/bys6UxHWAbShABWxz148J6F/OIuhMdPCgG5Xp4Bjh8++KYem/SE5pLnL7hh02Pi
         fjfdo4bXSBdvQPvdpc0i6bcwy6Qwz6b6Ivu1xiKHbUFY+qGRL8TFZmRrLFfrDy6HV5u/
         4VodG3Hd1zYxV5gsjMUn1xlkmfYMmyOFOQ1o1myq20I6wjz37qFYegVWEJx6/oKC0d+8
         if3Q==
X-Gm-Message-State: APuU4Z90MBcNizRKhOIZllS33gd2FYeVcocd58WSCXaHSIcZMSnKHTV9
	MuuOuMYCDocbZ0o59uiv7IjCh7LdaF4GVn0OuxNSz2NH1p6uPni2n7okciB0WA==
X-Gm-Gg: AYBFou0oCmhd6ZteAICYO04qYcLmsKpT3dPLuNUWVdOG0p2JZ2oY2r7JGaan+dYaJG0
	c4EWKMnlAuBHoKMRYzMlv/DEUS8dMsL9oBMgNx2b6bkJhq4xKY62wNVZFo7gmNwR3p5qFCLrOkG
	JgvaysIgHgQ+hDKiaF7Ctw+fE68lN5aN6exnOAggdhDKmdCH1YwVEb4eaD2MgLq1KBKBPXKuVR4
	+fFK5SUBoBUdNh9QIBvbpCgbbm+5di7hT4AkLso2LYEoOlePvD0t16WtDuY5W2JI+YE3x4lxbDb
	xEYUftXzWHFbpbDGfziRs41M8eD/4jXjdL7U6qkabYeilbyLFLvkSstb51QyLO8P7KXizWkIAyz
	XWOctte0JZdRW/hAtAJSorLjJjjg6F/1OKYp7dHfzTZdr3ZC9/kJCyvWegnhOrb0ms8BVwy/RPq
	1MsbVcJ8wap3vtSy3tFxnVWzzZarkY6kgFzRJSX9nOadzNxg/1zp86A5/yI7lrzl34+0U7BS02J
	G9V6cRxtpYyKzTxrKjQZ2IIUtKZpCLqrdeiSDLPTxFV4M3gySeAo6FbYxTVZhceWxg7KlR/K4iz
	FC5hV7IfS70SVS+qRTVw9X0KAmMkQuUDuLt+cvqIuykucWIcQb17RuzPgHQq1O8srg6EYnyiTrs
	2AESs8kb9yOZlemtlJjgU0756RjPXJlmFxNfnjL+ySkJPcMGuLk3Pw//hAvoiIJTpZAFQF6a7tQ
	==
X-Received: by 2002:a05:6a00:b8a:b0:89e:9c7e:fd49 with SMTP id d2e1a72fcca58-8a9bdcc583dmr11530369b3a.20.1793749361329;
        Tue, 03 Nov 2026 15:42:41 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09bc40bbcsm158550b3a.51.2026.11.03.15.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 16/37] bpf: Count loops whose first value or bound is a range
Date: Tue,  3 Nov 2026 23:40:41 +0000
Message-ID: <20261103234104.208239-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

Scalar evolution calculates the number of iterations of a loop only if the
first value of the variable and the bound in the latch, the jump that
closes the loop, are constants:

  for (i = 0; i < 10; i++)             header_count is 10
  for (i = 0; i < (n & 15); i++)       can't compute iterations count

The verifier unrolls the second loop, and it rejects the same loop with
'n & 0x7fffffff': the sequence of jumps is too complex.

The count grows when the first value and the bound move apart. Calculate it
for the two values that are the furthest apart: an upper bound for all.

  for (i = 0..16; i < 17; i++)         header_count is [0..17]

 - There is no count when the value that ends the loop can wrap around. It
   is less than a step behind the bound, whatever the first value is.
 - '!=' has a count only for a step of 1 or -1, and only if each first
   value is in front of each bound.
 - The ranges are those of the comparison: unsigned, signed, 32 bits.
   Pointers into one object have the order of signed offsets: fp-1 is below
   fp+0. Nothing limits the offset of a pointer that is compared only, and
   base + offset must not wrap around: there is a count only for offsets
   within +-2^29, the limit of reg_not_null(). Constants keep their own
   calculation, with unsigned offsets.
 - 'first value + step * count' is too wide for the variable that the latch
   tests. At the loop head it has its value at the entry, or a value that
   the latch let through plus a step: 0..16 in the example, not 0..32.

A counted loop is verified with ranges, and there is no way back to one
iteration at a time. Progs that need exact values are rejected now: a
second variable in a loop that tests at the top gets one step too many,
'n - i - 1' is not known to be positive, an offset into ctx is not a
constant. What compilers make of 'for (i = 0; i < n; i++)' loads. No prog
of Cilium, scx, the selftests or the public progs of Meta is lost.

'i < (n & 0x7fffffff)' loads now and runs as long as 'i < 0x7fffffff',
which loads today.

no_widen_small_spill_counter and uninit_slot_counter count from a stack
slot with unknown contents: they have an upper bound now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |  10 +-
 kernel/bpf/scev.c                             | 353 +++++++++++++++++-
 kernel/bpf/verifier.c                         |   5 +-
 .../selftests/bpf/progs/verifier_scev.c       |   6 +-
 4 files changed, 355 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 581458927512..7825a3bc0205 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -348,6 +348,12 @@ struct bpf_loop_iters {
 	u32 min_header_count;   /* min number of times header is executed */
 	u32 max_header_count;   /* max number of times header is executed */
 	unsigned long precise_regs[BITS_TO_LONGS(BPF_SCEV_REGS_NUM)];
+	/*
+	 * The variable that the latch tests, or -1, and what it can be at the
+	 * loop header: what it is at the entry or what the latch lets through.
+	 */
+	int iv_reg;
+	struct cnum64 iv_range;
 };
 
 struct loop_stack_entry {
@@ -356,6 +362,8 @@ struct loop_stack_entry {
 	u32 max_header_count;
 	u32 loop_id:31;
 	u32 terminates:1;
+	int iv_reg;
+	struct cnum64 iv_range;
 };
 
 #define LOOP_STACK_SIZE 16
@@ -2146,6 +2154,6 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state *st,
 			struct bpf_verifier_state *loop_entry, struct bpf_loop_iters *iters);
 int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 insn_idx,
-			struct bpf_verifier_state *entry_state, u32 max_header_count);
+			const struct loop_stack_entry *entry);
 
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 8662205a3b59..eac792dc7b10 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -2035,11 +2035,20 @@ static int match_linear_latch(struct bpf_verifier_env *env,
 	return false;
 }
 
+/* What is known about a scalar or about the offset of a pointer. */
 struct scev_value {
-	u64 value;	/* scalar value or a pointer offset */
+	u64 umin, umax;
+	s64 smin, smax;
+	u32 u32_min, u32_max;
+	s32 s32_min, s32_max;
 	int ptr_reg;	/* SCEV register identifying the pointer origin, or -1. */
 };
 
+static bool scev_value_is_const(const struct scev_value *v)
+{
+	return v->umin == v->umax;
+}
+
 static void log_scev_value(struct bpf_verifier_env *env, struct bpf_func_state *st,
 			   const struct scev_value *v)
 {
@@ -2049,8 +2058,10 @@ static void log_scev_value(struct bpf_verifier_env *env, struct bpf_func_state *
 		reg = scev_reg_for_read(env, st, v->ptr_reg);
 		log_reg(env, v->ptr_reg);
 		bpf_log(&env->log, " (%s)", reg ? reg_type_str(env, reg->type) : "unavailable");
+	} else if (scev_value_is_const(v)) {
+		bpf_log(&env->log, "scalar %llu", v->umin);
 	} else {
-		bpf_log(&env->log, "scalar %llu", v->value);
+		bpf_log(&env->log, "scalar %llu..%llu", v->umin, v->umax);
 	}
 }
 
@@ -2091,13 +2102,38 @@ static bool scev_value_add(struct bpf_verifier_env *env, struct bpf_func_state *
 			   const struct scev_value *a, const struct scev_value *b,
 			   struct scev_value *result)
 {
+	bool min_wraps, max_wraps;
+
 	if (a->ptr_reg >= 0 && b->ptr_reg >= 0) {
 		if (env->log.level & BPF_LOG_LEVEL2)
 			log_incompatible_scev_values(env, "can't add two pointers", st, a, b);
 		return false;
 	}
-	result->value = a->value + b->value;
 	result->ptr_reg = a->ptr_reg >= 0 ? a->ptr_reg : b->ptr_reg;
+
+	/* when both ends wrap around it is a range still */
+	min_wraps = check_add_overflow(a->umin, b->umin, &result->umin);
+	max_wraps = check_add_overflow(a->umax, b->umax, &result->umax);
+	if (min_wraps != max_wraps) {
+		result->umin = 0;
+		result->umax = U64_MAX;
+	}
+	if (check_add_overflow(a->smin, b->smin, &result->smin) ||
+	    check_add_overflow(a->smax, b->smax, &result->smax)) {
+		result->smin = S64_MIN;
+		result->smax = S64_MAX;
+	}
+	min_wraps = check_add_overflow(a->u32_min, b->u32_min, &result->u32_min);
+	max_wraps = check_add_overflow(a->u32_max, b->u32_max, &result->u32_max);
+	if (min_wraps != max_wraps) {
+		result->u32_min = 0;
+		result->u32_max = U32_MAX;
+	}
+	if (check_add_overflow(a->s32_min, b->s32_min, &result->s32_min) ||
+	    check_add_overflow(a->s32_max, b->s32_max, &result->s32_max)) {
+		result->s32_min = S32_MIN;
+		result->s32_max = S32_MAX;
+	}
 	return true;
 }
 
@@ -2111,13 +2147,23 @@ static bool eval_expr(struct bpf_verifier_env *env, struct scev *scev,
 
 	if (is_reg(scev, id, &regno)) {
 		reg = scev_reg_for_read(env, st, regno);
-		if (!reg || reg->type == NOT_INIT || !tnum_is_const(reg->var_off))
+		if (!reg || reg->type == NOT_INIT)
 			return false;
-		result->value = reg->var_off.value;
+		result->umin = reg_umin(reg);
+		result->umax = reg_umax(reg);
+		result->smin = reg_smin(reg);
+		result->smax = reg_smax(reg);
+		result->u32_min = reg_u32_min(reg);
+		result->u32_max = reg_u32_max(reg);
+		result->s32_min = reg_s32_min(reg);
+		result->s32_max = reg_s32_max(reg);
 		result->ptr_reg = reg->type == SCALAR_VALUE ? -1 : (int)regno;
 		return true;
 	} else if (is_imm(scev, id, &imm)) {
-		result->value = imm;
+		result->umin = result->umax = imm;
+		result->smin = result->smax = imm;
+		result->u32_min = result->u32_max = imm;
+		result->s32_min = result->s32_max = imm;
 		result->ptr_reg = -1;
 		return true;
 	} else if (is_add(scev, id, &l, &r) &&
@@ -2259,6 +2305,252 @@ static bool compute_backedge_taken_count(u8 op, u64 initial, u64 step, u64 bound
 	return true;
 }
 
+/*
+ * The first value of the induction variable at the latch and the bound it is
+ * compared with, as ranges of unsigned numbers. For a signed comparison the sign
+ * bit is flipped: that keeps the order and the differences.
+ * [lo, hi] is what the variable can be without wrapping around.
+ */
+struct latch_domain {
+	u64 imin, imax;
+	u64 bmin, bmax;
+	u64 lo, hi;
+};
+
+static void latch_domain(const struct linear_latch *latch, const struct scev_value *initial,
+			 const struct scev_value *bound, bool sign, struct latch_domain *d)
+{
+	u64 bias;
+
+	if (latch->jmp32) {
+		bias = sign ? 1U << 31 : 0;
+		d->imin = (sign ? (u32)initial->s32_min : initial->u32_min) ^ bias;
+		d->imax = (sign ? (u32)initial->s32_max : initial->u32_max) ^ bias;
+		d->bmin = (sign ? (u32)bound->s32_min : bound->u32_min) ^ bias;
+		d->bmax = (sign ? (u32)bound->s32_max : bound->u32_max) ^ bias;
+		d->lo = 0;
+		d->hi = U32_MAX;
+		return;
+	}
+	bias = sign ? 1ULL << 63 : 0;
+	d->bmin = (sign ? (u64)bound->smin : bound->umin) ^ bias;
+	d->bmax = (sign ? (u64)bound->smax : bound->umax) ^ bias;
+	if (latch->zext32) {
+		/* zero extended, so it is not negative */
+		d->imin = initial->u32_min ^ bias;
+		d->imax = initial->u32_max ^ bias;
+		d->lo = bias;
+		d->hi = bias + U32_MAX;
+		return;
+	}
+	d->imin = (sign ? (u64)initial->smin : initial->umin) ^ bias;
+	d->imax = (sign ? (u64)initial->smax : initial->umax) ^ bias;
+	d->lo = 0;
+	d->hi = U64_MAX;
+	/* It's base + offset that must not wrap around. The limit is that of reg_not_null(). */
+	if (initial->ptr_reg >= 0) {
+		d->lo = bias - BPF_MAX_VAR_OFF;
+		d->hi = bias + BPF_MAX_VAR_OFF;
+	}
+}
+
+/*
+ * '!=' with a step of one ends when the variable gets to the bound, given that
+ * it is on the right side of the bound to begin with.
+ */
+static bool count_ne_ranges(const struct latch_domain *d, bool down, u64 *cnt)
+{
+	if (d->bmin < d->lo || d->bmax > d->hi)
+		return false;
+	if (down ? d->imin < d->bmax : d->imax > d->bmin)
+		return false;
+	*cnt = down ? d->imax - d->bmin : d->bmax - d->imin;
+	return true;
+}
+
+static bool domain_add(const struct latch_domain *d, u64 v, s64 delta, u64 *res)
+{
+	if (delta >= 0 ? (u64)delta > d->hi - v : -(u64)delta > v - d->lo)
+		return false;
+	*res = v + delta;
+	return true;
+}
+
+/*
+ * The number of iterations depends on the first value, so 'first + slope * count'
+ * is far off when the first value is a range. There is a better bound for
+ * the variable that the latch tests. At the loop header it is
+ * - what it is at the entry, or
+ * - a value that the latch let through, @last is the last of them, plus what
+ *   is added between the latch and the header.
+ */
+static void latch_iv_range(struct bpf_verifier_env *env, struct bpf_func_state *st,
+			   const struct linear_latch *latch, const struct latch_domain *d,
+			   bool sign, bool down, u64 step, u64 last, struct bpf_loop_iters *iters)
+{
+	struct scev *scev = env->scev;
+	struct scev_value off, reg_val;
+	u64 bias, min, max, next;
+	u32 l, r, regno;
+	s64 c = 0;
+
+	l = latch->base_expr;
+	if (!is_reg(scev, l, &regno)) {
+		if (!is_add(scev, latch->base_expr, &l, &r) || !is_reg(scev, l, &regno) ||
+		    !eval_expr(env, scev, st, r, &off) || !scev_value_is_const(&off) ||
+		    off.ptr_reg >= 0)
+			return;
+		c = latch->jmp32 || latch->zext32 ? (s32)off.smin : off.smin;
+		if (c == S64_MIN)
+			return;
+	}
+	/* the lower half says nothing about a value that does not fit in it */
+	if (latch->jmp32 &&
+	    (!latch->zext32 || !eval_expr(env, scev, st, l, &reg_val) || reg_val.umax > U32_MAX))
+		return;
+	if (last < d->lo || last > d->hi ||
+	    !domain_add(d, d->imin, -c, &min) ||
+	    !domain_add(d, d->imax, -c, &max) ||
+	    !domain_add(d, last, -c, &next) ||
+	    !domain_add(d, next, down ? -(s64)step : (s64)step, &next))
+		return;
+	if (down)
+		min = min(min, next);
+	else
+		max = max(max, next);
+
+	if (latch->jmp32) {
+		bias = sign ? 1U << 31 : 0;
+		min ^= bias;
+		max ^= bias;
+		/* negative as s32 is large as zero extended u64 */
+		if (min > max)
+			return;
+		iters->iv_range = cnum64_from_urange(min, max);
+	} else if (sign) {
+		bias = 1ULL << 63;
+		iters->iv_range = cnum64_from_srange(min ^ bias, max ^ bias);
+	} else {
+		iters->iv_range = cnum64_from_urange(min, max);
+	}
+	iters->iv_reg = regno;
+}
+
+/*
+ * The first value or the bound is not a constant. The count is for the pair that is
+ * the furthest apart.
+ */
+static bool compute_backedge_taken_max(struct bpf_verifier_env *env, struct bpf_func_state *st,
+				       const struct linear_latch *latch,
+				       const struct scev_value *initial,
+				       const struct scev_value *step_val,
+				       const struct scev_value *bound,
+				       struct bpf_loop_iters *iters, u64 *result)
+{
+	struct scev *scev = env->scev;
+	bool sign = is_signed_op(latch->op), down;
+	struct scev_value reg_val;
+	struct latch_domain d;
+	/* the last value that the latch lets through */
+	u64 step, cnt, last;
+	u32 l, r;
+
+	/*
+	 * The jump compares addresses, the ranges are those of the offsets from one base.
+	 * fp-1 is below fp+0: whatever the op is, addresses have the order of signed offsets,
+	 * as long as base + offset does not wrap around.
+	 */
+	if (initial->ptr_reg >= 0)
+		sign = true;
+	/*
+	 * (zext32 (linear ...)) is zext32() of something in all iterations but
+	 * the first one at the loop header, where it is what the register has.
+	 */
+	if (latch->zext32 && !latch->jmp32) {
+		l = latch->base_expr;
+		if (!is_reg(scev, l, &r) && !is_add(scev, latch->base_expr, &l, &r))
+			return false;
+		if (!eval_expr(env, scev, st, l, &reg_val) || reg_val.umax > U32_MAX)
+			return false;
+	}
+
+	step = latch->jmp32 || latch->zext32 ? (u64)(s64)(s32)step_val->umin : step_val->umin;
+	if (!step)
+		return false;
+	down = (s64)step < 0;
+	if (down)
+		step = -step;
+
+	latch_domain(latch, initial, bound, sign, &d);
+	/* nothing limits the offset of a pointer that is compared only */
+	if (initial->ptr_reg >= 0 &&
+	    (d.imin < d.lo || d.imax > d.hi || d.bmin < d.lo || d.bmax > d.hi))
+		return false;
+
+	/*
+	 * The value that ends the loop must not wrap around. It is less than a step
+	 * away from the bound whatever the first value is.
+	 */
+	switch (latch->op) {
+	case BPF_JLT:
+	case BPF_JSLT:
+		if (down || d.imin >= d.bmax ||
+		    check_add_overflow(div64_u64(d.bmax - d.imin - 1, step), 1, &cnt) ||
+		    d.bmax > d.hi || step - 1 > d.hi - d.bmax)
+			return false;
+		last = d.bmax - 1;
+		break;
+	case BPF_JLE:
+	case BPF_JSLE:
+		if (down || d.imin > d.bmax ||
+		    check_add_overflow(div64_u64(d.bmax - d.imin, step), 1, &cnt) ||
+		    d.bmax > d.hi || step > d.hi - d.bmax)
+			return false;
+		last = d.bmax;
+		break;
+	case BPF_JGT:
+	case BPF_JSGT:
+		if (!down || d.imax <= d.bmin ||
+		    check_add_overflow(div64_u64(d.imax - d.bmin - 1, step), 1, &cnt) ||
+		    d.bmin < d.lo || step - 1 > d.bmin - d.lo)
+			return false;
+		last = d.bmin + 1;
+		break;
+	case BPF_JGE:
+	case BPF_JSGE:
+		if (!down || d.imax < d.bmin ||
+		    check_add_overflow(div64_u64(d.imax - d.bmin, step), 1, &cnt) ||
+		    d.bmin < d.lo || step > d.bmin - d.lo)
+			return false;
+		last = d.bmin;
+		break;
+	case BPF_JNE:
+		if (step != 1)
+			return false;
+		if (!count_ne_ranges(&d, down, &cnt)) {
+			sign = true;
+			latch_domain(latch, initial, bound, true, &d);
+			if (!count_ne_ranges(&d, down, &cnt))
+				return false;
+		}
+		if (!cnt)
+			return false;
+		last = down ? d.bmin + 1 : d.bmax - 1;
+		break;
+	default:
+		return false;
+	}
+
+	/*
+	 * A 32-bit latch sees the lower half of the step. The register at the header can be
+	 * a 64-bit variable that moves by all of it: the range is for a step that is the same.
+	 */
+	if (step_val->umin == (down ? -step : step))
+		latch_iv_range(env, st, latch, &d, sign, down, step, last, iters);
+	*result = cnt;
+	return true;
+}
+
 /*
  * Loop with post-condition:
  *
@@ -2295,8 +2587,11 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	struct scev *scev = env->scev;
 	struct scev_value initial_val, step_val, bound_val;
 	u64 step, bound, initial, total_change, backedge_taken_count;
+	bool konst;
 	u8 op = latch->op;
 
+	iters->iv_reg = -1;
+
 	if (!eval_expr(env, scev, st, latch->base_expr, &initial_val) ||
 	    !eval_expr(env, scev, st, latch->step_expr, &step_val) ||
 	    !eval_expr(env, scev, st, latch->bound_expr, &bound_val))
@@ -2313,9 +2608,22 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	if (!scev_value_compatible(env, st, &initial_val, &bound_val, latch))
 		return false;
 
-	initial = initial_val.value;
-	step = step_val.value;
-	bound = bound_val.value;
+	if (!scev_value_is_const(&step_val))
+		return false;
+	konst = scev_value_is_const(&initial_val) && scev_value_is_const(&bound_val);
+	if (!konst) {
+		if (!compute_backedge_taken_max(env, st, latch, &initial_val, &step_val, &bound_val,
+						iters, &backedge_taken_count))
+			return false;
+		/* as below */
+		if (backedge_taken_count >= U32_MAX - 1)
+			return false;
+		goto counted;
+	}
+
+	initial = initial_val.umin;
+	step = step_val.umin;
+	bound = bound_val.umin;
 
 	/*
 	 * The code below only handles mixed 64-bit/32-bit comparisons/recurrences
@@ -2336,9 +2644,9 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 			step    = (s64)(s32)(u32)step;
 		}
 	}
-	if (latch->zext32 ^ latch->jmp32 && (initial != initial_val.value ||
-					     bound != bound_val.value ||
-					     step != step_val.value)) {
+	if (latch->zext32 ^ latch->jmp32 && (initial != initial_val.umin ||
+					     bound != bound_val.umin ||
+					     step != step_val.umin)) {
 		if (env->log.level & BPF_LOG_LEVEL2)
 			bpf_log(&env->log,
 				"scev: mixed-width latch has operands outside 32-bit ranges\n");
@@ -2368,6 +2676,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		}
 	}
 
+counted:
 	/* The header executes once on entry and once for each taken backedge, hence +1. */
 	iters->max_header_count = backedge_taken_count + 1;
 	/*
@@ -2377,7 +2686,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	 * In such case, conservatively assume that non-latch exit can happen
 	 * at any iteration, thus setting minimal number of iterations as 0.
 	 */
-	iters->min_header_count = loop->exits_cnt == 1 ? iters->max_header_count : 0;
+	iters->min_header_count = konst && loop->exits_cnt == 1 ? iters->max_header_count : 0;
 	return true;
 }
 
@@ -2626,6 +2935,14 @@ static void linear_bounds(struct bpf_reg_state *reg, u32 max_header_count,
 	out->r32 = r32;
 }
 
+static void iv_bounds(struct bounds *bounds, struct cnum64 iv_range)
+{
+	struct cnum64 r64 = cnum64_intersect(bounds->r64, iv_range);
+
+	if (!cnum64_is_empty(r64))
+		bounds->r64 = r64;
+}
+
 static int mark_expr_precise(struct bpf_verifier_env *env, struct bpf_func_state *st, u32 id,
 			     unsigned long *precise_regs)
 {
@@ -2720,6 +3037,8 @@ int bpf_compute_loop_iters(struct bpf_verifier_env *env, struct bpf_verifier_sta
 		}
 		if (!found || tmp.max_header_count < iters->max_header_count) {
 			iters->max_header_count = tmp.max_header_count;
+			iters->iv_reg = tmp.iv_reg;
+			iters->iv_range = tmp.iv_range;
 			best = latch;
 		}
 		iters->min_header_count = found ? min(iters->min_header_count, tmp.min_header_count)
@@ -2925,6 +3244,8 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 			if (err)
 				return err;
 			linear_bounds(reg, iters->max_header_count, &coefs, &bounds);
+			if (r == iters->iv_reg)
+				iv_bounds(&bounds, iters->iv_range);
 			if (log->level & BPF_LOG_LEVEL2) {
 				bpf_log(log, "loop header at %d, widening ", insn_idx);
 				log_reg(env, r);
@@ -2965,9 +3286,11 @@ int bpf_widen_scev_regs(struct bpf_verifier_env *env, struct bpf_verifier_state
 }
 
 int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur_func_state, u32 insn_idx,
-			struct bpf_verifier_state *entry_state, u32 max_header_count)
+			const struct loop_stack_entry *entry)
 {
+	struct bpf_verifier_state *entry_state = entry->entry_state;
 	struct bpf_func_state *entry_st = entry_state->frame[entry_state->curframe];
+	u32 max_header_count = entry->max_header_count;
 	struct bpf_verifier_log *log = &env->log;
 	struct bpf_reg_state *reg, *entry_reg;
 	struct scev *scev = env->scev;
@@ -3005,6 +3328,8 @@ int bpf_clamp_scev_regs(struct bpf_verifier_env *env, struct bpf_func_state *cur
 			continue;
 
 		linear_bounds(entry_reg, max_header_count, &coefs, &bounds);
+		if (r == entry->iv_reg)
+			iv_bounds(&bounds, entry->iv_range);
 		if (log->level & BPF_LOG_LEVEL2) {
 			bpf_log(log, "loop header at %d, clamping ", insn_idx);
 			log_reg(env, r);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 06e72aaf6769..94d9a065e62d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20641,8 +20641,7 @@ static int maybe_clamp_scev_regs(struct bpf_verifier_env *env)
 	if (!entry->terminates)
 		return 0;
 
-	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry->entry_state,
-				   entry->max_header_count);
+	return bpf_clamp_scev_regs(env, frame, env->insn_idx, entry);
 }
 
 static int handle_loop_entry_exit(struct bpf_verifier_env *env)
@@ -20688,6 +20687,8 @@ static int handle_loop_entry_exit(struct bpf_verifier_env *env)
 
 	entry->min_header_count = iters.min_header_count;
 	entry->max_header_count = iters.max_header_count;
+	entry->iv_reg = iters.iv_reg;
+	entry->iv_range = iters.iv_range;
 	entry->entry_state = cur->parent;
 	entry->terminates = true;
 	err = bpf_widen_scev_regs(env, cur, cur->parent, &iters);
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 60b823876eaa..6b39c76fd37e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1188,7 +1188,8 @@ __success
 __log_level(2)
 __msg("scev at header 2:")
 __msg_next("  *fp-8=(+ *fp-8 1) / (linear *fp-8 1)")
-__msg("loop header at 2, can't compute iterations count")
+/* whatever is in the other bytes of the slot */
+__msg("loop header at 2, header_count is [0..266] ")
 __not_msg("widening")
 __naked void no_widen_small_spill_counter(void)
 {
@@ -2526,7 +2527,8 @@ __naked void sibling_inner_loops(void)
 SEC("socket")
 __success
 __log_level(2)
-__msg("loop header at 0, can't compute iterations count")
+/* whatever is in the slot */
+__msg("loop header at 0, header_count is [0..11] ")
 __naked void uninit_slot_counter(void)
 {
 	asm volatile ("					\
-- 
2.55.0

