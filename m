Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415824;
	b=sBXZu9kRYHvLggeJjY9mAwGGUIsoxbv9arn7NLC4/sKAqUsoTi4/k20SSnuTOm5VH9gf
	 MO37jFNd9SzL6PObasm8iTvP4IHvQFMeeFednce9v/GLIuwS4OULRkZ7g3gOre968yCEL
	 /xr0PLtQAy5qc6pwS0a7vevC4cjPDcc7qdNuHNvIo3G3+eVSz+0OGWLBuuKg0Tz8QZocs
	 zIdK2oZhaD4NupmYePDRArICkNp7QgwVwa5CILX6Uw5ITqzAk+kpxu6HCOY/re5CnSdbm
	 JSH63xxY10IGMOWWHrSVF4FBCY1sJt8pvb4xdrtYXU0PQfmemxIYxzq5ytgdL7sLrsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kNvj6kcVJpRt8PxB6bNE41GKNiP4GPeeeIaGnrw7BYw=;
	b=B585ATBxMLInxe9f5wm64PGpXZx37AnYp9sG/7bNgaS2Juy6pvlNO77c7YD1nOgp5kS3
	 2pQpNUA8ysuR1IakOeHtAey0cEX/J4YTiZGGP6ON0WoMyOZAcQOvCNah+dpEeoZ8i05DF
	 E1i7pgTHVRH6FXg4yi9a00AkERlaW1jsa3DaBzMDPcPnw5u82/VEyXdhKmvlyTojGp7tq
	 IgwYdSjEiu+siBd2Dq4rCBgrzfxkDXJGEbKdz4QDhvVSkxyxBV9Du1NPpTGYKOLfp52EW
	 we3ZTjsEAA4XlTrnQcmV+MM9DDheye9J/0xvOBtnKwJspSiVZitigEZnmUJkbTD5MKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSfVR5lZ;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91289606A32A
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91289606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSfVR5lZ
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a07078200fso1381265b3a.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415823; x=1795020623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNvj6kcVJpRt8PxB6bNE41GKNiP4GPeeeIaGnrw7BYw=;
        b=WSfVR5lZiTCV5Z6WrPWCRlUDksm3ta0WpAfgb/Ipj8epQzGvktlAJzAScZp56kE3GJ
         tbAxpEnWWdzRffIyJq9NROlrhsK7VzymnQV3lDhRoCU0s9BSuNBDnMyFw1vsdk2WiOpg
         oYnFxsANT7JD+uwRBDt9wyjr1v65DitwMCzwwJR7jqltT2VPz/teNaQWHlyidBP96HUM
         Gh3DhJwtBFHe+HGLhRe1uyJt7gEG2B+5sEUUHebaOdmq6NbHFGWocvanG8bbe3/1x4Ii
         HI5xb0I6DFpiVydC0iL6r+ghODPotSIwQ1JL5ZTIbSKb6GrDz7rWjV7qtJgAn0QnipDe
         qY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415823; x=1795020623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNvj6kcVJpRt8PxB6bNE41GKNiP4GPeeeIaGnrw7BYw=;
        b=khxelHBV4Wg3/W7IXXJMCrcCNc8alMaLmBwdUGOqfo6wvoN7wvx45I59q9TZxSzkBk
         enZbtCBxe59LM6KemnWOvNMpSdzvy/OOLRBiyYYZsCnTYhV4jCVGAPXG/9WedZQrAeH+
         KN0nAyHVrZPZWsO/YiMARF3rdmqDQ1Deybe5Vn2IC1igW0hUJBfjQ9yCCwOhjY/AaM8O
         ugjS46ayrff+5wopNzkqjXTlKS+sKSULQ3oZfzEfWyQSXt/95rUSV+acDgVtVlR/2IMw
         HBN729LjeVfWoqHyZlI7GOXpZ7ktECjkwiHngjJkwINB7IXer76G6H/g9U/KhBUCLcoO
         y+gw==
X-Gm-Message-State: APuU4Z9BXNGYIJH+Q27e/28E5fYFN/x5NqRuN2xgBs1Fx9OFPeausNAC
	dRbNXq/os2CBZegk96aggObgOStJB9KgJv2vQLv/Gw4XGIajPXYQ5ri/p41ZZQ==
X-Gm-Gg: AYBFou1vwHFp8rzFTlCinPPgrwzCwHKfiQcqUCSx+q8kL+XqUAJ8z4rUh02vnlmD6ie
	6lgF3QDJx8auXVUmDgNxltaXfj905nEzayfuBGoJ9nTdmGId3nrQ9iRQfRVSRM1Ptm2KyeynhWw
	RcyQ5npnURSEW8tbiGeNHNOU/Bb9EfmWqXjAyy6DI+MtAr3kDzWbgZuhfIDTBIzAedTSU9Muojk
	ujLq4wk+3ErPysa9tS76aFkfJ1BcV6wTA8Xhx3xUPMB9WJpmYcBFwijoRzqaPMzSJbr3TUBZv0I
	Ighlp7to9a7Y4jKGtKtTnRwQvdT/RyxtGKA+Tw57BDO2MkDmgIFTl42fNCtHKboZL3qXfWT1Q+R
	G3x/qCtCTmaLn9BTY+m4cIS/b46MUHd5U4gX/ZDyyMnm0fzg3ue/XCkUHnaBN/MKHC0yizeE8ml
	oq978NBW+kHppG1XAYZQBCk18leN5X1co+yf9nXrMDGYIs1qy3SQHo1H9+OpAYlW1UcdkIFoEZ4
	mr4Nu5sQTLfV5P7h+8aFaruYGZ2eb53y7O7ob0ly+phcts20GFGVMlbsEqVvzT0YsRu2Z3g0GcH
	0BYnNrpqSJduIovGet+zmQHYWtvKhFKmtXeJParDHmj72ct21okG3coV3wLknYTrr38XqORfxaZ
	XJuEOWX50ATqbgh19x/d7879N1aDR7yd7+9l1C0DElvHJvVdaAhqly0NRwMLhU2TUn563Ix7oZV
	0=
X-Received: by 2002:a05:6a00:1893:b0:8b6:59a:2aa with SMTP id d2e1a72fcca58-8bc1cf52946mr3126827b3a.54.1794415822409;
        Wed, 11 Nov 2026 08:50:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa86e1c9sm2337639b3a.23.2026.11.11.08.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:50:21 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/6] bpf: Count a '!=' latch if the step divides the distance
Date: Wed, 11 Nov 2026 16:49:48 +0000
Message-ID: <20261111164950.2674588-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
References: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
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

	struct rec recs[16];		/* 12 bytes each, in a map value */
	u32 n = v->n;			/* if (n > 16) return 0; */

	for (u32 o = n * sizeof(struct rec); o != 0; ) {
		o -= sizeof(struct rec);
		sum += *((u8 *)recs + o);
	}

	u32 i = n;
	while (i-- > 0) {		/* clang: '2 * i != 0', step -2 */
		sum += offs[i];		/* u16 offs[16] */
		bpf_get_current_comm(data + off, 16);
		off += 16;
	}

Both loops are rejected. The verifier says "can't compute iterations
count": '!=' of a range has a count only if the step is 1. From 13 the
first loop steps over 0 and goes on. Without a count nothing bounds o,
and nothing bounds off in the second loop.

But o cannot be 13. n * 12 has reg->step 12, 2 * i and 'len & 0xff8' have
known zero bits in var_off. A struct scalar carries that to the count.

scalar_stride() sees the values of a scalar as an arithmetic progression
on the circle: base, base + stride, .. , base + size. The value that ends
the loop overshoots the end of the arc by a number that is known modulo
g = gcd(step, stride): by at most
step - g + 'overshoot of the smallest initial value' % g. It was step - 1.
For '!=' it has to be 0, and each bound has to be hit: g is the gcd with
the stride of the bounds too.

The stride is reg->step if r64 does not cross S64_MAX / S64_MIN, for the
low 32 bits if r32 is r64 moved by a multiple of 1 << 32. Else it comes
from the known low bits of var_off, and the range is rounded to them:
1..0xff8 with three zero bits is 8..0xff8. The scalar of a pointer is its
offset: the distance of the offsets is that of the addresses.

The summary of a loop must not know less than its iterations one by one.
For a range linear_bounds() kept the power of two that var_off and the
slope share. The entry value is congruent to base modulo step, so
'entry + slope * k' is, modulo gcd(step, |slope|). A register has one
step: the gcd is taken if it is a multiple of that power of two.

What else changes:
 - Like each loop with a count these get no may_goto:
   'for (i = x & ~1; i != 1ULL << 32; i += 2)' of a u32 x runs up to 2^31
   iterations.
 - A count can cost insns. 'while (i) { i--; off += ids[i] & 63; }' has one
   now, off has no linear form, the iterations are kept apart up to the
   count: 90 -> 247 insns for n up to 32.
 - 'r8 = 8 * x + 17' that goes down by 4 while (u32)r8 > 0xfffffffd is
   1 modulo 4 now: no such value takes the backedge, and the next insn on
   that infeasible path trips the WARN of reg_bounds_sanity_check():
   REG INVARIANTS VIOLATION. Its ranges are forgotten and the prog loads,
   as today behind other dead branches that the verifier does not see.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/scev.c | 106 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
index 815a6367555d..b413998d9cf9 100644
--- a/kernel/bpf/scev.c
+++ b/kernel/bpf/scev.c
@@ -3,6 +3,7 @@
 
 #include "linux/cnum.h"
 #include <linux/bpf_verifier.h>
+#include <linux/gcd.h>
 #include <linux/jhash.h>
 #include <linux/log2.h>
 #include <linux/math64.h>
@@ -3562,6 +3563,59 @@ static struct cnum64 scalar_arc(const struct scalar *v, bool low32)
 	return low32 ? cnum64_lshift32(v->r32) : v->r64;
 }
 
+/* Euclid. gcd64(a, 0) is a. gcd() is for unsigned long. */
+static u64 gcd64(u64 a, u64 b)
+{
+	u64 rem;
+
+	while (b) {
+		div64_u64_rem(a, b, &rem);
+		a = b;
+		b = rem;
+	}
+	return a;
+}
+
+/*
+ * The values of @v are among the members of an arithmetic progression on the circle:
+ *
+ *	arc->base, arc->base + stride, arc->base + 2 * stride, .. , arc->base + arc->size
+ *
+ * @arc is scalar_arc() without the values at its ends that @v cannot have.
+ * Return the stride, 0 if there is one value.
+ *
+ * base and step are a congruence of the s64: the distance between two values is a multiple of
+ * step if r64 does not cross S64_MAX / S64_MIN. The low 32 bits have the same distances if r32
+ * is r64 moved by a multiple of 1 << 32.
+ * The known low bits of var_off are a congruence modulo a power of two. That divides 1 << 64 and
+ * 1 << 32, so it holds wherever the arc is. reg_bounds_sync() does not round a range to them:
+ * 1..0xff8 with three zero bits is 8..0xff8 here.
+ */
+static u64 scalar_stride(const struct scalar *v, bool low32, struct cnum64 *arc)
+{
+	struct tnum t = low32 ? tnum_lshift(v->var_off, 32) : v->var_off;
+	s64 smin = cnum64_smin(v->r64), smax = cnum64_smax(v->r64);
+	u64 low, d;
+
+	*arc = scalar_arc(v, low32);
+	if (cnum64_is_empty(*arc) || cnum64_is_const(*arc))
+		return 0;
+	if (v->step > 1 && smin == (s64)v->r64.base &&
+	    imod(smin, v->step) == v->base && imod(smax, v->step) == v->base &&
+	    (!low32 || (v->r32.base == (u32)v->r64.base && v->r32.size == v->r64.size)))
+		return (u64)v->step << (low32 ? 32 : 0);
+
+	low = t.mask ? BIT_ULL(__ffs64(t.mask)) - 1 : U64_MAX;
+	d = (t.value - arc->base) & low;
+	/* range and var_off don't overlap: the path is infeasible */
+	if (d > arc->size)
+		return low32 ? BIT_ULL(32) : 1;
+	arc->base += d;
+	arc->size -= d;
+	arc->size -= arc->size & low;
+	return arc->size ? low + 1 : 0;
+}
+
 static bool is_signed_op(u8 op)
 {
 	switch (op) {
@@ -3638,17 +3692,21 @@ static void rotated_urange(struct cnum64 a, u64 origin, u64 ut_max, u64 *min, u6
  * Both bounds of 10..12 have a count and 11 has none. overshoot is -diff modulo step: when the
  * initial value grows by 1, so does overshoot, modulo step. For the initial values
  * imin .. imin + size it is at most 'overshoot of imin' + size while that is below step: exact
- * for a constant. Else it is step - 1, which is what LLVM's canIVOverflowOnLT() assumes.
+ * for a constant. Else it is known modulo g = gcd(step, @stride), where the initial values are
+ * imin, imin + @stride, imin + 2 * @stride ..: at most step - g + 'overshoot of imin' % g.
+ * 10, 12, 14 has a count: the step divides the distance. With a stride of 1 it is step - 1, which
+ * is what LLVM's canIVOverflowOnLT() assumes.
  * '!=' has to hit each bound: what holds for initial values holds for its bounds too.
  *
  * 32-bit numbers are compared on the same circle, in the upper half of a u64: cnum64_lshift32().
  * @unit is the 1 of the text above, 1 or 1 << 32, and ut_max is the largest number, -unit.
  */
 static bool compute_backedge_taken_count(u8 op, bool sign, u64 unit, struct cnum64 initial,
-					 u64 step, struct cnum64 bound, struct exit_limit *el)
+					 u64 step, struct cnum64 bound, u64 stride,
+					 struct exit_limit *el)
 {
 	u64 min_value = sign ? (u64)S64_MIN : 0, ut_max = -unit, origin = min_value;
-	u64 imin, imax, emin, emax, bmin, bmax, diff, rem, overshoot, size;
+	u64 imin, imax, emin, emax, bmin, bmax, diff, rem, overshoot, size, g;
 	bool down = (s64)step < 0;
 	struct cnum64 end;
 
@@ -3717,7 +3775,14 @@ static bool compute_backedge_taken_count(u8 op, bool sign, u64 unit, struct cnum
 	size = imax - imin;
 	if (op == BPF_JNE && check_add_overflow(size, emax - emin, &size))
 		size = ut_max;
-	overshoot = size < step - overshoot ? overshoot + size : step - unit;
+	if (size < step - overshoot) {
+		overshoot += size;
+	} else {
+		/* Initial values that cross origin are 0 .. ut_max here: imin is none of them. */
+		g = imin == initial.base - origin ? gcd64(step, stride) : unit;
+		div64_u64_rem(overshoot, g, &rem);
+		overshoot = step - g + rem;
+	}
 	if (overshoot > ut_max - emax)
 		return false;
 
@@ -3838,7 +3903,7 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	struct scev_value initial_val, step_val, bound_val, reg_val;
 	bool sign = is_signed_op(latch->op), konst;
 	struct cnum64 initial, bound, off;
-	u64 step, unit = 1;
+	u64 step, unit = 1, stride;
 	struct exit_limit el;
 	bool low32;
 	u32 l, r;
@@ -3884,8 +3949,11 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 		sign = false;
 	}
 	low32 = initial_val.ptr_reg < 0 && (latch->jmp32 || latch->zext32);
-	initial = scalar_arc(scalar_of(&initial_val), low32);
+	stride = scalar_stride(scalar_of(&initial_val), low32, &initial);
 	bound = scalar_arc(scalar_of(&bound_val), low32);
+	/* '!=' has to hit each bound. For the rest the largest or the smallest bound counts. */
+	if (latch->op == BPF_JNE)
+		stride = gcd64(stride, scalar_stride(scalar_of(&bound_val), low32, &bound));
 	step = step_val.r64.base;
 	if (initial_val.ptr_reg >= 0) {
 		/*
@@ -3906,7 +3974,8 @@ static bool compute_max_iters(struct bpf_verifier_env *env,
 	/* no bound is left for which the latch can be true */
 	if (cnum64_is_empty(bound))
 		el = (struct exit_limit){};
-	else if (!compute_backedge_taken_count(latch->op, sign, unit, initial, step, bound, &el))
+	else if (!compute_backedge_taken_count(latch->op, sign, unit, initial, step, bound, stride,
+					       &el))
 		return false;
 	/*
 	 * max_header_count is u32 and U32_MAX means "infinite",
@@ -4185,7 +4254,8 @@ static void linear_bounds(const struct scalar *reg, u32 max_header_count,
 	struct cnum64 r64;
 	struct cnum32 r32;
 	s64 total_change;
-	bool overflow;
+	bool overflow, konst;
+	u16 step;
 
 	if (coefs->spill32) {
 		/* what 'rX = *(u32 *)(r10 - 8)' loads */
@@ -4225,16 +4295,18 @@ static void linear_bounds(const struct scalar *reg, u32 max_header_count,
 		r32 = cnum32_union(reg->r32, r32);
 	}
 	/*
-	 * If the entry value is a single point the value set is 'v + slope * k',
-	 * so the step is |slope|. Otherwise, only the power-of-two alignment
-	 * shared by the entry value and the slope.
+	 * The value set is 'v + slope * k'. It has the power-of-two alignment shared by the entry
+	 * value and the slope. The entry value is congruent to base modulo step, so the sum is,
+	 * modulo gcd(step, |slope|), unless it wraps. A single point is its own base, its step
+	 * is 0: every number divides 0. One step is kept: the gcd if it implies the alignment.
 	 */
-	if (cnum64_is_const(reg->r64) && !overflow) {
-		out->step = slope_abs;
-		out->base = imod(cnum64_smin(reg->r64), out->step);
-	} else {
-		out->step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
-		out->base = 0;
+	out->step = 1u << min_t(u32, tnum_alignment(reg->var_off), __ffs(slope_abs));
+	out->base = 0;
+	konst = cnum64_is_const(reg->r64);
+	step = gcd(konst ? 0 : reg->step, slope_abs);
+	if (!overflow && step > out->step && !(step % out->step)) {
+		out->step = step;
+		out->base = konst ? imod(cnum64_smin(reg->r64), step) : reg->base % step;
 	}
 	out->var_off = tnum_unknown;
 	out->r64 = r64;
-- 
2.55.0

