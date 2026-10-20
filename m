Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513214;
	b=W1fH5lhWaYyujZ6ZlMcSx6ZqP2/3AClko4EafhGgHrTZjJhDA4I3PV9q3EWPr9LEEl5a
	 EtIUZ/UGcQCxRHlz2tajjjPB+stC+C4XU6yVkoSa+TqY+FTEHvAFYMJhnWrjI0nv/svpA
	 c09Rrw1jmrMhbHMl8JWXZYhzsc1jNI2fXUAqLrUK2Yjl+iad2gPzHXRFh21lTEVFnRopZ
	 tzQg+JN0luqz7MHe+72cXokLyGft7s1sdwb5bF8hRZQzMAhXceKgjML/n2SX2+iTof5WM
	 /KNMdDBc8ULm1NHTu2kMJfqj/E70aA2yzt1shSnU8VdveN8su8MNexl3Y0DSjqzFbvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513214;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aeEuyyYM2ltDcE4hsGe5Ex7fp6PFqJnBAdk1jg3yBeo=;
	b=N+LjHwpxz0CUm5tV2JEB4gbsS1birjq1HxF6o6U3wvNLoSaCxMFoiuEV2AsIUbsRbz3D
	 W+JrbTWIw/PW3AQR8/FeRHYPbBkPTs/Y47x00V6sHDNznu6lmjY8hDRI98sHY+ukilqGC
	 gI9DMd8/DIAfxtc0h+rUk4B6uQzFbv+MGIiyPYd8zhkbJ40F1Ai5Z0apfnyuqf1STaHcx
	 U99uI/I1KqSD6NKeeu156XVyneLu9peNN3mtRqFurwtFwUJzlGGCtlyL694tdcdOFg/Nv
	 rC/xZU6Fpyr9eov7pvgVT6oFk1enwhUIdjEmS9KHEtslju66AfMfmBvEBz7Wt80WFCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EFBhtOgb;
	arc=none smtp.remote-ip=95.215.58.209
Received: from mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195EE606A32C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 195EE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EFBhtOgb
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ndzYTlgaOkL0YsMx3oV9bHvAAD9cb4ogcKZ+R7dB0Mo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513212; v=1; x=1793118012;
 b=EFBhtOgbZyBCmvmi0O1Apam7zvD/Wx25cain0jb2B9KEiEH46CXjNQwWmd6P1Zk/7oUSR89y
 LDURE9u0gkPCIXu3ylsKetZ0dEq1W9kdyxUPHL1dF6CpAFQhKKNf8U2BtaKw2GAPAoJvtzlTKAH
 oQhGhJvclh2mKejGqjjUQLvU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bdd1f2ff77ffbded;
	Tue, 20 Oct 2026 16:20:09 +0000
X-Mizu-Trace-ID: bdd1f2ff77ffbded
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v3 08/12] bpf: Recover the low 32 bits on the reverse link direction
Date: Tue, 20 Oct 2026 09:19:03 -0700
Message-ID: <20261020161907.2115379-9-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020161907.2115379-1-vineet.gupta@linux.dev>
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
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

A low-32 link over a wide base drives sync_linked_regs() forwards only.
Narrowing the base reaches the members, but narrowing a member tells the
base nothing:

	r6 = ...		/* full 64-bit unknown */
	w7 = w6;
	w7 += 5;
	if w7 != 15 goto ...	/* so (u32)r6 == 10 */
	if w6 == 10 goto ...	/* not deduced */

That refusal is broader than it needs to be, in two ways.

It only applies to a *wide* base in the first place -- the guard is
scoped on get_reg_width(reg) > 32. A base that fits 32 bits is equal to
the member's low half, so a compare on the member pins it exactly, and
such a pair already falls through to the differencing arm. What the two
mov patches had to get right there is which extension rebuilds it, since
choosing wrong is unsound rather than merely imprecise.

And for a wide base it is only the *high* half that is unrecoverable.
Writing the two registers against the same abstract X, the member is
ext(X + d_member) and the base is X + d_base, so their low 32 bits are
(X + d) mod 2^32 and differ by the known constant d_member - d_base. The
member therefore pins the base's low half exactly; what it says nothing
about is everything above bit 31.

Eduard put it as a direction rather than a kind, on v2 03/13:

> - if known_reg is sext/zext -> sync to 'full' register recovers only
>   lower 32-bits and keeps upper untouched (counting on cross-domain
>   bounds sync logic).

So instead of skipping, add the delta difference to the member's 32-bit
range and intersect it into the base's r32 and tnum_subreg, leaving r64
and the upper tnum to reg_bounds_sync(). Never writing the high half
directly is what keeps this sound. Dropping the guard outright instead
makes scalars_alu32_basic and zext_narrow_dst_keeps_base verify, and both
must not; they still fail here.

It buys nothing today, and is proposed anyway. No verdict changes on any
of the three corpora, and on its own it costs nothing anywhere. The zero
is a result rather than a non-event: instrumenting the new arm to emit a
token, it fires 78 times under bpf-gcc and 40 under clang, so programs do
reach it and come out identical. zext_reverse_pins_low_half is a
__failure without the patch.

It does interact with the narrowing-fill patch that follows -- together
they cost big_alloc2 2956 -> 3095 insns where neither does alone -- which
that patch spells out, since a bisect lands the cost there.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: new in v3.
 - answers Eduard's point on v2 03/13: the reverse direction recovers
   the low half even though it cannot recover the high one. A base
   that fits 32 bits was never refused -- the guard is scoped on
   get_reg_width(reg) > 32 -- so this is the remaining case, a base
   wider than 32 bits.
 - proposed for merge, not tagged, and it buys nothing today -- no
   verdict changes on any of the three corpora.
 - costs nothing on its own. With the narrowing-fill patch that follows
   it costs big_alloc2 2956 -> 3095 insns; neither produces that alone,
   and a bisect lands it on the fill patch, which says so.
 - the arm is instrumented to confirm it is reached rather than merely
   silent: 78 firings under bpf-gcc, 40 under clang.

 kernel/bpf/verifier.c                         | 58 ++++++++++++++-----
 .../bpf/progs/verifier_linked_scalars.c       | 47 ++++++++++++---
 2 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dffcaa2e1392..6b26487d4549 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18521,29 +18521,54 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 		if (reg->id != known_reg->id)
 			continue;
 		/*
-		 * The reverse direction does not work for a narrow known_reg:
-		 * it knows only its low 32 bits, which say nothing about a
-		 * wider reg's high half. Neither (u32)(base + delta) nor
-		 * (s32)(base + delta) inverts once the base is wider than 32
-		 * bits.
+		 * The reverse direction, from a narrow known_reg to a wider
+		 * reg, does not invert: neither (u32)(base + delta) nor
+		 * (s32)(base + delta) says anything about the base's high
+		 * half. It does still pin the low half, though -- both sides
+		 * are (base + delta) mod 2^32, differing only by their deltas
+		 * -- so recover that much and leave the high half alone.
 		 */
 		if ((known_reg->link_kind == BPF_REG_LINK_ZEXT ||
 		     known_reg->link_kind == BPF_REG_LINK_SEXT) &&
 		    reg->link_kind != BPF_REG_LINK_ZEXT &&
 		    reg->link_kind != BPF_REG_LINK_SEXT &&
-		    get_reg_width(reg) > 32)
-			continue;
+		    get_reg_width(reg) > 32) {
+			/*
+			 * Only @low's 32-bit half is meaningful: its var_off
+			 * is advanced over all 64 bits while r64 and the
+			 * base/step line are not, and nothing below reads
+			 * either. It is a scratch value, not a register state.
+			 */
+			struct bpf_reg_state low = *known_reg;
+			struct tnum low32;
+
+			fake_reg.type = SCALAR_VALUE;
+			__mark_reg_known(&fake_reg,
+					 (s64)reg->delta - (s64)known_reg->delta);
+			scalar32_min_max_add(&low, &fake_reg);
+			low.var_off = tnum_add(low.var_off, fake_reg.var_off);
+
+			cnum32_intersect_with(&reg->r32, low.r32);
+			low32 = tnum_intersect(tnum_subreg(reg->var_off),
+					       tnum_subreg(low.var_off));
+			reg->var_off = tnum_with_subreg(reg->var_off, low32);
+			reg_bounds_sync(reg);
+			goto scratched;
+		}
 		/*
 		 * Skip a pair of differing kinds. Where BPF_REG_LINK_FULL meets
-		 * a 32-bit kind the delta relationship genuinely does not hold:
-		 * the deltas were added at different ALU widths.
-		 * BPF_REG_LINK_ZEXT against BPF_REG_LINK_SEXT is not that case
-		 * -- both are base + delta in the low 32 bits, so narrowing one
-		 * really does narrow the other -- but that deduction is
-		 * declined on purpose. It makes an int loop counter a fresh
-		 * constant on every iteration, so no two iterations prune
-		 * against each other and the program runs to the instruction
-		 * limit. See sext_no_sync_from_zext_sibling.
+		 * a 32-bit kind the delta relationship does not hold over all
+		 * 64 bits: the deltas were added at different ALU widths. For a
+		 * wide member the low half still relates and the arm above has
+		 * already recovered it; a member that fits 32 bits does not
+		 * reach that arm and is skipped outright. BPF_REG_LINK_ZEXT
+		 * against BPF_REG_LINK_SEXT is not that case -- both are base +
+		 * delta in the low 32 bits, so narrowing one really does narrow
+		 * the other -- but that deduction is declined on purpose. It
+		 * makes an int loop counter a fresh constant on every
+		 * iteration, so no two iterations prune against each other and
+		 * the program runs to the instruction limit. See
+		 * sext_no_sync_from_zext_sibling.
 		 */
 		if (reg->link_kind && known_reg->link_kind &&
 		    reg->link_kind != known_reg->link_kind)
@@ -18622,6 +18647,7 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 				*reg = prev;
 			reg_bounds_sync(reg);
 		}
+scratched:
 		if (e->is_reg)
 			mark_reg_scratched(env, e->regno);
 		else
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 9a33cc60e8cb..69efe1381eca 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -247,6 +247,30 @@ l0_%=:								\
 }
 #endif /* CAN_USE_MOVSX */
 
+SEC("socket")
+__success
+__retval(0)
+__naked void zext_reverse_pins_low_half(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 <<= 32;						\
+	call %[bpf_get_prandom_u32];				\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	w7 = w6;						\
+	w7 += 5;		/* r7 = (u32)(r6 + 5) */	\
+	if w7 != 15 goto l0_%=;	/* so (u32)r6 == 10 */		\
+	if w6 == 10 goto l0_%=;					\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 /*
  * Test that sync_linked_regs() correctly handles large offset differences.
  * r1.off = S32_MIN, r2.off = 1, delta = S32_MIN - 1 requires 64-bit math.
@@ -414,9 +438,11 @@ l0_%=:								\
 }
 
 /*
- * Test that sync_linked_regs() skips propagation when one register used
- * alu32 (BPF_REG_LINK_ZEXT) and the other used alu64 (BPF_REG_LINK_FULL).
- * The delta relationship doesn't hold across different ALU widths.
+ * Test that sync_linked_regs() does not carry the delta relationship across
+ * registers that used different ALU widths: r7 used alu32 (BPF_REG_LINK_ZEXT) and r8
+ * alu64 (BPF_REG_LINK_FULL), so the relationship does not hold over all 64 bits. The
+ * low half is recovered -- r8 comes out exactly 0x100000000 -- which is why
+ * the div is still reachable and this is a __failure.
  */
 SEC("socket")
 __failure __msg("div by zero")
@@ -434,7 +460,7 @@ __naked void scalars_alu32_alu64_cross_type(void)
 	/* r7 = 0xFFFFFFFF */					\
 	/* sync: known_reg=r7 (BPF_REG_LINK_ZEXT), reg=r8 (BPF_REG_LINK_FULL) */ \
 	/* Without fix: r8 = zext(0xFFFFFFFF + 1) = 0 */	\
-	/* With fix: r8 stays [2, 0x100000001] (r8 >= 2) */	\
+	/* With fix: r8 == 0x100000000, so still > 0 */		\
 	if r8 > 0 goto l1_%=;					\
 	goto l0_%=;						\
 l1_%=:								\
@@ -950,8 +976,10 @@ __naked void zext_no_sync_between_mixed_kinds(void)
 }
 
 /*
- * ... and here the low-32 link is the branch register, so the register
- * carrying the delta must not be narrowed either.
+ * ... and here the low-32 link is the branch register. Its low half does
+ * reach the register carrying the delta, but the high half must not: r8's
+ * low 32 bits become 3 while the rest stays unknown, so r8 == 3 is still
+ * not provable and the div stays reachable.
  */
 SEC("socket")
 __failure __msg("div by zero")
@@ -1276,9 +1304,10 @@ __naked void sext_no_sync_when_base_has_delta(void)
 
 /*
  * ... and with the link as the branch register the propagation must not run
- * backwards: a BPF_REG_LINK_SEXT register knows nothing about the base's high half, so
- * narrowing it must leave the rest of the set alone. Were the guard missing,
- * r8 would be rebuilt as r7 + 3 == 2, treating r7 as if it were the base.
+ * backwards over the high half: a BPF_REG_LINK_SEXT register knows nothing about the
+ * base's high bits. The low half is recovered, so r8's low 32 bits do become
+ * 2, but treating that as the whole value -- r8 == 2, as if r7 were the base
+ * -- must not happen.
  */
 SEC("socket")
 __failure __msg("div by zero")
-- 
2.53.0-Meta

