Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513208;
	b=5SeyaKxAUP1t3tceygvMHd3r8G9Xxbck3PXm22iDs91Cl/VkiLmKlhupBauhIaDLZ4oL
	 JybTXqxXCPPC9EM0CB54BfSrnXSmL+nioYZr2bQOQrCRae8WCYE/fCR3rrcnfjU8sjpS5
	 BkvdWIn2P1ceB1PA2q27/kQua1whwPWTare1UpLvMN9V2XiRYPkAgEtdU/ODVZ0rOp2bA
	 FnCgi5yXk1OBpDLqPamT05pPSTvj4WnwlT7qb4D8+x3FYSkRl/vOERK7iCKzBQzZmpSKh
	 WVWOrDKwYpDdr5PLpfWi10szQl3schXFrwN/PmJM3UGP1RgW1XVhvU5wbGou1ObCfQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513208;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yZs8hi4VJCrcWV5AKDvsGDmPww/1ESwn1pfhGcuPAIs=;
	b=famYcz9gwonxQ/91IvbGbepM8+obG+M1xc+NIZ6ylYBcUnAAgahoO7LRrFLAU3iRPGin
	 c/x+LL9V29iHtNPwqhx/6ZP2MASczuLmykdC62Je3jZNNzqhKgeeoQqgEkqqGzKDl8cHX
	 2jmc4pxLMi8WEZvqXcNCEVB9Y55ryctWQLJuQcmeMhGjYa20QNjzWBR8E48NKyh/G4G/Y
	 4n6qfkjdKXCOy8hLah0IZo+qAl9XA08qWsUu5riCOl3DmixVeoYJWw3aTa7aN0peolsPv
	 9bbHoU13YdJmRk7iEiSMPvk+jIvz9TPCp3UIj97HZ7Nnt1KpTuHqJkCzqLpj3UVxzHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MajpKt7q;
	arc=none smtp.remote-ip=91.218.175.196
Received: from mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61335606A331
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61335606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MajpKt7q
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C4c5AMWSJXo8A5a5WWvyfe+WriQJNF6/RHi+f9pjb44=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513205; v=1; x=1793118005;
 b=MajpKt7qGspP37urI2McvPafAfKOB0q9MD6nPS0gn5KTZ9l8oQuP3bI+Bh7xBjZVl39G5MhM
 t47KKCfWbZYIF01RtPgmUAU97H9cF8rxoIZByDID0N0JTgnuKFpnxpRlCSVubQrzKC7uUQoNY65
 3pL6ZzlRjlIXGWhJMVD22kyE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7e5612f78d6ad07c;
	Tue, 20 Oct 2026 16:20:03 +0000
X-Mizu-Trace-ID: 7e5612f78d6ad07c
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
Subject: [PATCH bpf-next v3 07/12] selftests/bpf: Cover the low-32 link for sign-extending movs
Date: Tue, 20 Oct 2026 09:19:02 -0700
Message-ID: <20261020161907.2115379-8-vineet.gupta@linux.dev>
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

Fourteen programs, mirroring the zero-extending set:

 - sext_mov_inherits_delta: a source carrying a delta hands it to the
   sign extension; without that the program is rejected
 - sext_delta_survives_zext_mov: and survives a further zero-extending mov
 - sext_mov_unlinked_src: a call return has no id, so the mov mints one.
   This is the shape the failures that motivated the series take
 - sext_value_survives_spill_across_call: narrowed, then spilled across a
   call, and the value has to come back off the stack
 - sext_mov_wide_src: what arrives is sign-extended, not zero-extended
 - sext_self_mov_keeps_link: r0 = (s32)r0 on a linked register stays in
   its set -- how a sign-extended int return lands
 - sext_self_mov_no_link: the same mov on an unlinked register mints no id
 - sext_no_sync_when_base_has_delta: a delta on the base stops propagation
 - sext_no_sync_from_subreg_base: no reverse propagation from a wide base
 - sext_narrow_base_keeps_high_values: and when the base is not wide, the
   reverse runs with the *zero* extension. Rebuilding it the other way
   dropped every value with bit 31 set
 - sext_drops_stale_step: the base/step line does not survive the
   reconstruction
 - sext_no_sync_from_zext_sibling: the ZEXT/SEXT pair deliberately does
   not reach itself; iter_obfuscate_counter depends on this
 - sext_kinds_reach_different_values: one low half reaches -1 through a
   sign extension and 0xffffffff through a zero extension
 - sext_sync_keeps_narrower_member: a tighter member is not widened

The __success ones guard a div by zero that is unreachable only if the
propagation happened; the __failure ones leave it reachable, so an unsound
deduction shows up as an unexpected success.

The sign-extending mov is cpuv4, so the block sits behind CAN_USE_MOVSX,
following CAN_USE_GOTOL so bpf-gcc gets the coverage too. verifier_movsx.c
open-coded the same condition and uses the macro now.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: was v2 8/13.
 - new: sext_mov_inherits_delta and sext_delta_survives_zext_mov, for
   the delta patch 6 adds
 - new: sext_mov_unlinked_src and sext_value_survives_spill_across_call,
   the two shapes the failures that motivated the series take
 - new: sext_narrow_base_keeps_high_values, sext_drops_stale_step and
   sext_sync_keeps_narrower_member, pinning what the reverse direction
   must get right for a narrow base
 - new: sext_no_sync_from_zext_sibling. The shape is bpf-gcc codegen
   clang does not emit, so without it a regression here is invisible
   to CI.
 - the block moves behind CAN_USE_MOVSX so bpf-gcc gets the coverage.

 tools/testing/selftests/bpf/progs/bpf_misc.h  |   8 +
 .../bpf/progs/verifier_linked_scalars.c       | 409 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_movsx.c      |   8 +-
 3 files changed, 419 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index d7f706c3bc4a..c5ffb36dfd74 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -285,6 +285,14 @@
 #define CAN_USE_BPF_ST
 #endif
 
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
+     defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) ||	\
+     defined(__TARGET_ARCH_loongarch)) &&				\
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX))
+#define CAN_USE_MOVSX
+#endif
+
 #if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
 	(defined(__TARGET_ARCH_arm64) ||				\
 	 defined(__TARGET_ARCH_x86) ||					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 815160e56942..9a33cc60e8cb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -213,6 +213,40 @@ l0_%=:							\
 	: __clobber_all);
 }
 
+#ifdef CAN_USE_MOVSX
+/*
+ * A sign-extending mov reads only the low 32 bits, so it shares them with
+ * whatever its source shares them with -- including a delta the source
+ * picked up. Here r8 is (s32)(r6 + 5): narrowing r6 to 0xfffffffb makes
+ * (u32)(r6 + 5) zero, so r8 is zero and the divide is unreachable.
+ */
+SEC("socket")
+__success
+__retval(0)
+__naked void sext_mov_inherits_delta(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 <<= 32;						\
+	call %[bpf_get_prandom_u32];				\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	w7 = w6;		/* BPF_REG_LINK_ZEXT, delta 0 */	\
+	w7 += 5;		/* BPF_REG_LINK_ZEXT, delta 5 */	\
+	r8 = (s32)r7;		/* BPF_REG_LINK_SEXT, delta 5 */	\
+	r1 = 0xfffffffb ll;					\
+	if r6 != r1 goto l0_%=;	/* (u32)(r6 + 5) == 0 */	\
+	if r8 == 0 goto l0_%=;					\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+#endif /* CAN_USE_MOVSX */
+
 /*
  * Test that sync_linked_regs() correctly handles large offset differences.
  * r1.off = S32_MIN, r2.off = 1, delta = S32_MIN - 1 requires 64-bit math.
@@ -1058,4 +1092,379 @@ __naked void zext_mov_breaks_linked_src(void)
 	: __clobber_all);
 }
 
+#ifdef CAN_USE_MOVSX
+
+/*
+ * A BPF_REG_LINK_SEXT register carries a delta, so anything forming a low-32 link off
+ * it must inherit that delta rather than assume zero: r9 is (u32)(r6 + 5), not
+ * (u32)(r6 + 0). Resetting it recorded r9 == r6, and the verifier then read a
+ * constant the program never computes.
+ */
+SEC("socket")
+__success
+__naked void sext_delta_survives_zext_mov(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 <<= 32;						\
+	call %[bpf_get_prandom_u32];				\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	w7 = w6;		/* BPF_REG_LINK_ZEXT, delta 0 */	\
+	w7 += 5;		/* BPF_REG_LINK_ZEXT, delta 5 */	\
+	r8 = (s32)r7;		/* BPF_REG_LINK_SEXT, delta 5 */	\
+	w9 = w8;		/* must stay (u32)(r6 + 5) */	\
+	if r6 != 0 goto 1f;	/* r6 == 0, so r9 == 5 */	\
+	if r9 == 5 goto 1f;	/* always taken: r9 is 5 */	\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A 32-bit sign extension keeps the low 32 bits, so narrowing the source
+ * reaches the destination the same way it does for a zero extension. The high
+ * half follows the sign, so the value seen here is negative.
+ */
+SEC("socket")
+__success
+__naked void sext_mov_wide_src(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = (s32)r6;		/* forms the link */		\
+	if w6 != -1 goto 1f;	/* narrows r6, propagates to r7 */ \
+	if r7 == -1 goto 1f;	/* sign-extended, not 0xffffffff */ \
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The source need not already be in a set. A call return or a load has no
+ * id, so the sign-extending mov is what mints one -- which is the shape the
+ * failures that motivated this take, rather than a prior pairing.
+ */
+SEC("socket")
+__success
+__retval(0)
+__naked void sext_mov_unlinked_src(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r7 = (s32)r0;		/* r0 has no id; mint one */	\
+	if w0 != -1 goto l0_%=;	/* narrows r0, propagates to r7 */ \
+	if r7 == -1 goto l0_%=;	/* sign-extended, not 0xffffffff */ \
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * r0 = (s32)r0 is how a sign-extended int return lands. src and dst are the
+ * same register, but r0 is already linked, so there is a set for it to stay
+ * in and the narrowing still propagates.
+ */
+SEC("socket")
+__success
+__naked void sext_self_mov_keeps_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = r6;		/* r6, r7 linked */		\
+	r7 = (s32)r7;		/* self-mov, keeps the id */	\
+	if w6 != -1 goto 1f;	/* narrows r6, propagates to r7 */ \
+	if r7 == -1 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The same self-mov on an unlinked register has nothing to link to, so it
+ * must not mint an id that would leave r6 describing itself.
+ */
+SEC("socket")
+__success __log_level(2)
+/* an id would print as R6=scalar(id=N+0.sx,smin=... */
+__msg("(bf) r6 = (s32)r6 {{.*}} R6=scalar(smin=")
+__naked void sext_self_mov_no_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 ^= 0;		/* drop the id */		\
+	r6 = (s32)r6;		/* forms no link */		\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The shape a sign-extended return takes when it crosses a helper call: the
+ * branch narrows it first, then it is spilled. No link is needed past the
+ * spill -- r7 is already known by then -- but the value has to survive the
+ * round trip.
+ */
+SEC("socket")
+__success
+__retval(0)
+__naked void sext_value_survives_spill_across_call(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = (s32)r6;		/* sext link to r6 */		\
+	if w6 != -1 goto l0_%=;	/* narrows r6, so r7 is -1 */	\
+	*(u64 *)(r10 - 8) = r7;	/* spill the known value */	\
+	call %[bpf_get_prandom_u32];				\
+	r8 = *(u64 *)(r10 - 8);	/* fill it back */		\
+	if r8 == -1 goto l0_%=;	/* survived the round trip */	\
+	r0 /= 0;						\
+l0_%=:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A delta on the branch register is not modelled together with a low-32
+ * link, so the propagation is skipped rather than guessed at.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_no_sync_when_base_has_delta(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = (s32)r6;		/* forms the link */		\
+	r8 = r6;						\
+	r8 += 3;		/* delta on the branch reg */	\
+	if r8 != 3 goto 1f;	/* must not propagate to r7 */	\
+	if r7 == 0 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * ... and with the link as the branch register the propagation must not run
+ * backwards: a BPF_REG_LINK_SEXT register knows nothing about the base's high half, so
+ * narrowing it must leave the rest of the set alone. Were the guard missing,
+ * r8 would be rebuilt as r7 + 3 == 2, treating r7 as if it were the base.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_no_sync_from_subreg_base(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = (s32)r6;		/* forms the link */		\
+	r8 = r6;						\
+	r8 += 3;		/* delta on r8 */		\
+	if r7 != -1 goto 1f;	/* must not propagate to r8 */	\
+	if r8 == 2 goto 1f;	/* taken only if r8 wrongly narrowed */	\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Two different kinds can share one id: r2 is (u32)(r6 + 1) and r7 is
+ * (s32)(r6 + 1). Pinning r2 really does pin r7 -- the deltas are equal, so
+ * w2 == 1 means r7 == 1 -- but sync_linked_regs() skips any pair of
+ * differing kinds, and here that imprecision is load-bearing. bpf-gcc
+ * builds "i += 1" for an int loop counter into exactly this shape, and
+ * deducing r7 makes the counter a fresh constant on every iteration, so the
+ * state never converges and iters.c:iter_obfuscate_counter runs to the 1M
+ * instruction limit.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_no_sync_from_zext_sibling(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 <<= 32;						\
+	call %[bpf_get_prandom_u32];				\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	r2 = r6;						\
+	w2 += 1;		/* r2 = (u32)(r6 + 1) */	\
+	r7 = (s32)r2;		/* r7 = (s32)(r6 + 1) */	\
+	if w2 != 1 goto 1f;	/* must not propagate to r7 */	\
+	if r7 == 1 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The two link kinds rebuild the high half differently: the same low half
+ * reaches -1 through a sign extension and 0xffffffff through a zero
+ * extension, so only one path clears the guard. As above this checks the outcome -- the differing
+ * ranges keep the states apart on their own.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void sext_kinds_reach_different_values(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 &= 1;						\
+	if r6 >= 1 goto 2f;					\
+	/* explored first: r7 is a sign-extended link of r8 */	\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;						\
+	r7 = (s32)r8;						\
+	goto 1f;						\
+2:								\
+	/* runtime path: r7 is a zero-extended link of r8 */	\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;						\
+	w7 = w8;						\
+1:								\
+	if w8 != -1 goto 3f;					\
+	if r7 == -1 goto 3f;	/* only the sign-extended path */ \
+	r0 /= 0;						\
+3:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The sign-extending counterpart: a narrowing of the base must not widen a
+ * member that already proved itself tighter.
+ */
+SEC("socket")
+__success
+__naked void sext_sync_keeps_narrower_member(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	r7 = (s32)r6;		/* forms the link */		\
+	if w7 > 7 goto 1f;	/* r7 low 32 bits in [0, 7] */	\
+	if r6 > 100 goto 1f;	/* narrows the base, syncs to r7 */ \
+	if r7 <= 7 goto 1f;	/* still provable if r7 kept [0, 7] */ \
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The reverse direction is only refused because the base is wider than 32
+ * bits. Narrow it first -- "w6 = w6" leaves r6 in [0, U32_MAX] -- and
+ * sync_linked_regs() does run, with r6 carrying no kind of its own and the
+ * member carrying BPF_REG_LINK_SEXT. The reconstruction there has to be the zero
+ * extension: r6 is below 2^32 and equal to the member's low half, so a
+ * signed compare on the member must not hand r6 the sign-extended value.
+ * Forgetting that dropped every r6 >= 2^31 from the range and made the
+ * guarded div provably dead.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_narrow_base_keeps_high_values(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w6 = w6;		/* r6 in [0, U32_MAX] */	\
+	r7 = (s32)r6;		/* forms the link */		\
+	r8 = 1;							\
+	r8 <<= 31;		/* 0x80000000 */		\
+	if r7 s> 100 goto 1f;	/* r6 is [0,100] or >= 2^31 */	\
+	if r6 < r8 goto 1f;	/* reachable: r6 may be >= 2^31 */ \
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A base/step line does not survive the sign extension: the reconstruction
+ * subtracts 2^32, and 2^32 is not a multiple of 3. Keeping the line let
+ * __update_bounds_from_step() snap r7's bounds onto the wrong congruence
+ * class -- r6 = 0x80000007 is a multiple of 3, so r7 = -2147483641 is
+ * reachable, but the stale line excluded it.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_drops_stale_step(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w6 = w6;						\
+	r6 *= 3;		/* base 0, step 3 */		\
+	r7 = (s32)r6;		/* forms the link */		\
+	r8 = 1;							\
+	r8 <<= 31;						\
+	r9 = r8;						\
+	r9 += 7;						\
+	if r6 < r8 goto 1f;					\
+	if r6 > r9 goto 1f;	/* r6 in [0x80000000, 0x80000007] */ \
+	if r7 != -2147483641 goto 1f; /* reachable: r6 == 0x80000007 */ \
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+#endif /* CAN_USE_MOVSX */
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 3fcd03b7a547..1d04a4369f81 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -4,11 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
-	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && \
-	(__clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX))
+#ifdef CAN_USE_MOVSX
 
 SEC("socket")
 __description("MOV32SX, S8")
@@ -405,6 +401,6 @@ int dummy_test(void)
 	return 0;
 }
 
-#endif
+#endif /* CAN_USE_MOVSX */
 
 char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

