Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792513241;
	b=V7BPhddKpoxTB2NZheoqbd9X8/ecD915acv2Y2wE9ekaOOSf7ST0XiPcXboGKjmSHDAf
	 ERst12Cu7kbkzixKtDtv1agmA6qed91V7s+VdoNxpHDhpkaTBYXBpDByv8KMswpGZbQ8N
	 Xl/R+TMAOQzvnYz7RkkTnSN+Gd8+7X1Ij9XwqMRMJqMVGo2oPZz8N3Dux2/4/U1NJo7DO
	 9xGf/tGI9MY3UppqCarduk5VJnKPuF19qICkLk60M8As9cnN6WEjOVcY4QU/hH4BGe6iU
	 yIlp7R3wyoDGuswmpLJg9PEimCptuY8NeCuhEfOrKQ14n6n78BdCPpuBAfQL5ugzA0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792513241;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KeJcHprlgsSy37jz/sG9vjDpxR12mebXUF6cGvE57FI=;
	b=Doi7iN8aHDccDaHFc4ak9iavT0Dn+ueaXutESgcJZM88lVcN8t01punG6RnjhBwktPQX
	 VVam8jzuU7X+Q6c0l8kCyvfcVaufCvSHLsG4wRU6tOYkn1oQ4vahPi9NOYIC5bEKmm2t8
	 s6gkKAiljKdF76fOBIS4ZB5usnY+gn1mx4m9uhdYGPz3rcs7kD3dImx0S+ruxXO5Mqoh6
	 O1Ra+zCis7gCmrBAbVaCuCaOAfEhAY4xFsdgWFsdSymd+P1NIOzF16SgII3+ioNXOpciG
	 iV9w2VKdYYEc2/c5rKd6VnPMJ2kesLE43AgEqhofDJElgFKZF+nJa6YODpWzgxzkG1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=joGV6+Gr;
	arc=none smtp.remote-ip=95.215.58.223
Received: from mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE6606A336
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0DE6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=joGV6+Gr
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fWbqd58nG00sKbjBsRKDAHkAG8PIKnJXAquf0f3KMa4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792513239; v=1; x=1793118039;
 b=joGV6+Grdbg07HqEzIJexPKlE63j33/c69tfNiJxVFvlOU9RtuWVQ1GzbvBCjK7hHa7cxjpJ
 EO1RDIIEklAoNh383BiHg5F4mOQgkNLMpzWfSoZa2oq8TDePdkVQbeJCVid4vXtbuswuEr5Nl55
 IIkSsS9gZP/29HV0h2DlaIi0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fbbc5854844eea49;
	Tue, 20 Oct 2026 16:20:38 +0000
X-Mizu-Trace-ID: fbbc5854844eea49
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
Subject: [PATCH bpf-next v3 10/12] selftests/bpf: Cover the low-32 link for narrowing stack fills
Date: Tue, 20 Oct 2026 09:19:05 -0700
Message-ID: <20261020161907.2115379-11-vineet.gupta@linux.dev>
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

Eight programs, following the mov set:

 - zext_fill_narrow_from_wide_spill: narrowing the spilled value reaches
   the filled register
 - sext_fill_narrow_from_wide_spill: the same for a sign-extending fill
 - sext_delta_survives_narrowing_fill: a slot carrying a delta hands it
   to the fill, so r2 is (u32)(r6 + 5) and not (u32)r6
 - zext_fill_full_width_keeps_full_link: a full-width fill stays a plain
   64-bit equality
 - zext_fill_byte_forms_no_link: a sub-word fill is below the model
 - fill_kinds_reach_different_values: the same, for the two kinds off one
   slot
 - sext_fill_does_not_inherit_zext_link: a sign-extending fill must not
   come away with the slot's zero-extending link
 - sext_byte_fill_drops_sext_link: nor may an 8-bit ldsx keep a
   sign-extending one

The first three pin the link itself: disabling link formation in the fill
arm makes all three fail. The last two pin the link-kind checks in
check_mem_access() and assert on the register dump rather than a guarded
branch, so they fail on the rule rather than a downstream effect.

The sign-extending fills are ldsx, so they sit under a new CAN_USE_LDSX
gate; verifier_ldsx.c open-coded the same condition and uses the macro
now. sext_byte_fill_drops_sext_link needs both gates, since the
BPF_REG_LINK_SEXT it tests is built with a movsx and only the fill is an
ldsx.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v3: was v2 10/13.
 - new: sext_delta_survives_narrowing_fill, for the inherited delta
 - new: sext_fill_does_not_inherit_zext_link and
   sext_byte_fill_drops_sext_link, for the two kinds a sign-extending
   load must not come away with. Both assert on the register dump
   rather than a guarded branch.
 - the sign-extending fills are ldsx, so they sit under a new
   CAN_USE_LDSX gate; verifier_ldsx.c open-coded the same condition and
   uses the macro now.

 tools/testing/selftests/bpf/progs/bpf_misc.h  |   8 +
 .../selftests/bpf/progs/verifier_ldsx.c       |   8 +-
 .../bpf/progs/verifier_linked_scalars.c       | 306 ++++++++++++++++++
 3 files changed, 316 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c5ffb36dfd74..ef0250a10cc7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -293,6 +293,14 @@
 #define CAN_USE_MOVSX
 #endif
 
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
+     defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) ||	\
+     defined(__TARGET_ARCH_loongarch)) &&				\
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_LDSX))
+#define CAN_USE_LDSX
+#endif
+
 #if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
 	(defined(__TARGET_ARCH_arm64) ||				\
 	 defined(__TARGET_ARCH_x86) ||					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 49e8cd4bb4f9..6c1553059101 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -5,11 +5,7 @@
 #include "bpf_misc.h"
 #include <bpf_arena_common.h>
 
-#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
-	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
-	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
-	defined(__TARGET_ARCH_loongarch)) && \
-	(__clang_major__ >= 18 || defined(__BPF_FEATURE_LDSX))
+#ifdef CAN_USE_LDSX
 
 SEC("socket")
 __description("LDSX, S8")
@@ -464,6 +460,6 @@ int dummy_test(void)
 	return 0;
 }
 
-#endif
+#endif /* CAN_USE_LDSX */
 
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 69efe1381eca..ab78285153fb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -245,6 +245,7 @@ l0_%=:								\
 	: __imm(bpf_get_prandom_u32)
 	: __clobber_all);
 }
+
 #endif /* CAN_USE_MOVSX */
 
 SEC("socket")
@@ -1120,6 +1121,102 @@ __naked void zext_mov_breaks_linked_src(void)
 	: __clobber_all);
 }
 
+/*
+ * A narrowing fill keeps only the slot's low 32 bits, so a later narrowing of
+ * the spilled value must still reach the filled register. Same relation as a
+ * 32-bit mov from a wide source, with the stack slot as the base.
+ */
+SEC("socket")
+__success
+__naked void zext_fill_narrow_from_wide_spill(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+"	r2 = *(u32 *)(r10 - 8);	/* narrowing fill, forms the link */ \
+"
+#else
+"	r2 = *(u32 *)(r10 - 4);				\
+"
+#endif
+"	if w6 != 0 goto 1f;	/* narrows r6, propagates to r2 */ \
+	if r2 == 0 goto 1f;					\
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
+ * A full-width fill of a wide slot is a plain 64-bit equality, not a low-32
+ * link, so it must keep propagating exactly as before.
+ */
+SEC("socket")
+__success
+__naked void zext_fill_full_width_keeps_full_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;						\
+	*(u64 *)(r10 - 8) = r6;					\
+	r2 = *(u64 *)(r10 - 8);	/* no narrowing */		\
+	if r6 != 0 goto 1f;					\
+	if r2 == 0 goto 1f;					\
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
+ * A sub-word fill is below the low-32 model, so no link is formed and the
+ * relation is dropped as before.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void zext_fill_byte_forms_no_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;						\
+	*(u64 *)(r10 - 8) = r6;					\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+"	r2 = *(u8 *)(r10 - 8);	/* 1-byte fill: no link */	\
+"
+#else
+"	r2 = *(u8 *)(r10 - 1);					\
+"
+#endif
+"	if w6 != 0 goto 1f;					\
+	if r2 == 0 goto 1f;	/* not deduced */		\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #ifdef CAN_USE_MOVSX
 
 /*
@@ -1494,6 +1591,215 @@ __naked void sext_drops_stale_step(void)
 	: __clobber_all);
 }
 
+/*
+ * Same for a narrowing fill: the slot is (s32)(r6 + 5), so the filled register
+ * is (u32)(r6 + 5). Forcing the delta to 0 made the verifier believe r2 == r6.
+ */
+SEC("socket")
+__success
+__naked void sext_delta_survives_narrowing_fill(void)
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
+	*(u64 *)(r10 - 8) = r8;	/* full spill keeps the link */	\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+"	r2 = *(u32 *)(r10 - 8);	/* narrowing fill inherits delta */ \
+"
+#else
+"	r2 = *(u32 *)(r10 - 4);					\
+"
+#endif
+"	if r6 != 0 goto 1f;	/* r6 == 0, so r2 == 5 */	\
+	if r2 == 5 goto 1f;	/* always taken: r2 is 5 */	\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #endif /* CAN_USE_MOVSX */
 
+#ifdef CAN_USE_LDSX
+
+/*
+ * The sign-extending counterpart: the filled register is the sign extension of
+ * the slot's low 32 bits, so a narrowing of those bits arrives sign-extended.
+ */
+SEC("socket")
+__success
+__naked void sext_fill_narrow_from_wide_spill(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+"	r2 = *(s32 *)(r10 - 8);	/* narrowing sx fill */		\
+"
+#else
+"	r2 = *(s32 *)(r10 - 4);				\
+"
+#endif
+"	if w6 != -1 goto 1f;	/* narrows r6, propagates to r2 */ \
+	if r2 == -1 goto 1f;	/* sign-extended, not 0xffffffff */ \
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
+ * The same, for the two link kinds off one slot.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void fill_kinds_reach_different_values(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 &= 1;						\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r8 |= r0;						\
+	*(u64 *)(r10 - 8) = r8;					\
+	if r6 >= 1 goto 2f;					\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+"	r2 = *(s32 *)(r10 - 8);	/* sign-extending fill */	\
+"
+#else
+"	r2 = *(s32 *)(r10 - 4);				\
+"
+#endif
+"	goto 1f;						\
+2:								\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+"	r2 = *(u32 *)(r10 - 8);	/* zero-extending fill */	\
+"
+#else
+"	r2 = *(u32 *)(r10 - 4);				\
+"
+#endif
+"1:								\
+	if w8 != -1 goto 3f;					\
+	if r2 == -1 goto 3f;	/* only the sign-extending path */ \
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
+ * A sign-extending fill must not come away with a zero-extending link. The
+ * slot below already fits 32 bits, so the fill is not narrowing and assigns
+ * no link kind of its own, and "state->regs[dst] = *reg" copies the slot's
+ * verbatim; check_mem_access() is what has to drop it, since it would leave
+ * r2 recording a zero-extension of a value it has just sign-extended.
+ * Asserted on the register dump rather than on a guarded branch, so it pins
+ * the rule itself and not a downstream effect.
+ */
+SEC("socket")
+__success __log_level(2)
+/* a copied link would print as R2=scalar(id=N+0,smin=... */
+__msg("(81) r2 = *(s32 *)(r10 {{.*}} R2=scalar(smin=")
+__naked void sext_fill_does_not_inherit_zext_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	w7 = w6;		/* r7 = zext32(r6), fits 32 bits */ \
+	*(u64 *)(r10 - 8) = r7;					\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+"	r2 = *(s32 *)(r10 - 8);	/* sign-extending, not narrowing */ \
+"
+#else
+"	r2 = *(s32 *)(r10 - 4);					\
+"
+#endif
+"	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * BPF_REG_LINK_SEXT says the register is (s32)(base + delta) -- a 32-bit sign
+ * extension specifically. An 8- or 16-bit ldsx is a different relation, so
+ * the exemption that keeps a sign-extending link across a sign-extending
+ * load has to be gated on the load width. Ungated, r2 below claims to be
+ * (s32)r6 when it is really (s8)((s32)r6).
+ */
+SEC("socket")
+__success __log_level(2)
+#ifdef CAN_USE_MOVSX
+/*
+ * Needs MOVSX as well as LDSX: the BPF_REG_LINK_SEXT under test is built with
+ * r7 = (s32)r6, and only the byte fill below is an ldsx.
+ */
+/* a surviving link would print as R2=scalar(id=N+0.sx,smin=... */
+__msg("(91) r2 = *(s8 *)(r10 {{.*}} R2=scalar(smin=")
+__naked void sext_byte_fill_drops_sext_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	r7 = (s32)r6;		/* r7 = BPF_REG_LINK_SEXT, delta 0 */	\
+	if r7 > 255 goto 1f;	/* r7 fits a byte */		\
+	*(u64 *)(r10 - 8) = r7;	/* full spill keeps the link */	\
+"
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+"	r2 = *(s8 *)(r10 - 8);	/* 8-bit ldsx: no link survives */ \
+"
+#else
+"	r2 = *(s8 *)(r10 - 1);					\
+"
+#endif
+"	r0 = r2;		/* keep r2 live so the fill prints it */ \
+	r0 &= 1;						\
+	exit;							\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+#endif /* CAN_USE_MOVSX */
+
+#endif /* CAN_USE_LDSX */
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

