Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374121;
	b=vwjqBzyITVZXL0actnHqX7Zemj8iZkJzxAj1CHRYgp+MITjzXqwUbXLtqlipsV7IxpOG
	 f8E00rcL/opu7Od4umAxoshnYEh8cb8CC+OpYYxErwYn4yHQvAwaYZUuJFRbEoSPVZrh0
	 q8byNQrsy5WI62hsusNj+TV3JGGWacBYYG8j1XK8STAVsHFvYF1ov5hbVem0BlKPYTH45
	 JBJ6IUesTkz/aHDRjSFQLvmtG9XOr+bAhduELGtGVrn3HFl0DDmTPaeKlA0x+ZcJVEZzg
	 CHyCCUFkDAx1Ts0q/0uDljZor3EkebIICu2xJ1pCUBsD28/XAn7/WnYq9L29hOefAsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
	b=nzoyzE3hcwjiQD5Luq8Nr1EWrY5v12f7mAs4CeYDej4J+imbuCrepOcTaig/cfxPsuIR
	 /4e7VbsExHPbLb3iLNuJdMpMeI3DG0fyMPPbazku4riKaejdMi4itEqu4KW7nj0jhxCQk
	 pYNFtB+I09PBqkyMMZnOxjeBnaEilAHBfVbUvr3HUWeAvOhOPFJi9S3NMZA+ObH5W7dDt
	 GRqXplCkiB+o4R+jvtCxfWJiWc3mGywrroWJ6sZYxbN2R70qNdXP6bL3Hw8tzSifqS5Ye
	 qU/d2PSjgtKu63FRfxLlbyeuA1GR35a5bgyIIOJQxvoEeIYl29ZP7BEFy4xMqzMBDGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twHrc0r0;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343A2606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 343A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=twHrc0r0
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2edd50e36f2so2090755ad.3
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374115; x=1794978915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
        b=twHrc0r0RPJNLfJ1NJg/9xrKR6af7mMeU9WCizXYd82Hccm5UGfgt9c7nUH9hY7A9i
         cmaEBHwDpPiHfxq49LP2lYgq1FbfjAzWw/SzyTS0bPu4yKdihZvNWPFEzn9VrxOwysUk
         D4fXRwGMmdsP1rki6QTFbVwgMBjal8tpTxzmNHLfyjhxTS9W4p76JYiWGXGy/Bfx1kMG
         niy11n4W3HAqf60C9YlcJk00otbz0YgQCpQlLmrlW/vPzuhDXDhUZGLiak2/krBlq7+m
         ZYiD17uhadXBjuRUQEvmi+FG9s0U4MLY3BKc21cLxjRKlj1mkDUJGor7bzB/JLewI+x7
         m8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374115; x=1794978915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
        b=JgG7T2lwzf3RbzqGmBQ0K6CPBCurKFfe+SviE0z/aONWI4X1tXg0Vg95ujMl5CIvVQ
         9RzctZARS6tExjLnVz/FnTJx0Jaq2iv7p9rSJfJk8Tb/2QDezRaq7si7W+3e+3KOQOhh
         wRsRXpIaK7gxhVOpMA2T5FiKtt2hOBRg4Sj4dMrdeu8FJD4UCfCT4g9RROqq25yuUbSt
         tluzuex9UApRVZ7Hpg07NTltv5huzkfZF3dhWDyX6yJH1IC+Ms4bZGCOgR+y1Ug5sHqz
         2a56XUt24FZZXUXxieCH/dWKBt0qCv16BJiouOnLHVieh4/0d1JSw3ecsMLmxpXl/pQ2
         6z8w==
X-Gm-Message-State: APuU4Z9YZ5kSJ2nw4kPVgx4Ej5RvLj3oibIvdp6WK3VOXkdtdO2jUaiN
	rlpAtLjsna8w9LObvRbRCts1vUthwcrEdbjZedE5K0qgXKE1NlKFm5YnDRB/Zg==
X-Gm-Gg: AYBFou3cvgVjzpU8obHeex0NFLQ6JDImpuD6/MjvbU/ih7CidQxQqLv1baJ9Enj02SY
	kV4yF3ssJot1ioGY5RyXaDdzmYjFOBHigpIg7nXJi5qnv+cYPAk12wJz9XqAon/NJdy1B5mPoDn
	IQuVf8rz52lkFUqNqscw6Gv2bDNPqtNJE9JykiqB0ayP+BVEltArC5K4JxuRAhZXmILKxYEwYvi
	SKLHh4Lj4TCqPgwRc4CTbRITeLGf4lyBtfGCS6KTMUJxVMvx+VgM8eMjkib8YpTxMzU749B3JTo
	kOZlwV0rsrfnqM/clo+HrEJWy4q3oLKhDyJ5wzUktSFmcRpwRqqqFQuAiw6YyT6vsMRCrL9nf14
	GwoKdoeNGz+yLCpyrf1O3bJI8/wpOh7gu/FsQt9juABz2BWHAIR0UvdC5n6o/2fKOrFs+Orsv/G
	ZFrc3D6Uoo75Urqi96AuT9ne8cQk3vqbGh5uYJ6C1FzRie/589xM9WTp2ZVPQLI2L4FN5TGIDJU
	1bsAiBkVXa/7jJcqoKuPjsPR0FE3q+Mb1wE/kzeWsCO1G7qxM2i/7dknzhOiWTqfHRSqLORQw4R
	c4ngS5SknibxwXGduEC/xD4PDjdcdcSJpLSna3N1ZpfgbGB7zayaqz7OX254JsCOv3fJn3IKpz5
	4bQ7X5VI4au+Ip7ICn7aTwFJzTLgilIgKUKIJcE3yWm5DBXtxFV112j8lb2HePxRlFcVqNtroGW
	Q=
X-Received: by 2002:a17:90b:4b92:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3b182f26af0mr1626001a91.29.1794374114801;
        Tue, 10 Nov 2026 21:15:14 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1846d5684sm656199a91.2.2026.11.10.21.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:15:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 15/29] selftests/bpf: Test sign extensions of a range and of a linked register
Date: Wed, 11 Nov 2026 05:13:26 +0000
Message-ID: <20261111051341.2800252-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
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

From: Vineet Gupta <vineet.gupta@linux.dev>

Tests for two patches of this series. Two progs are for
coerce_subreg_to_size_sx(), which keeps the 32-bit range across a no-op
sign extension. Five are for refine_linked_regs(), which refines the linked
registers of a conditional jump: the live registers and stack slots that
are a tested register + a constant on every path to the jump, here
modulo 2^32.

	call bpf_get_prandom_u32
	r7 = (s32)r0
	if w0 != -1 goto ..

GCC keeps an int that a call returned that way. The jump tests the low
32 bits of r0, the prog goes on with r7.

'w0 = (s8)w0' and 'w0 = (s16)w0' keep a 32-bit range that crosses 0 and
fits in s8 or s16.

After 'r7 = (s32)r6' r7 == r6 (mod 2^32). A test of the low 32 bits of the
source refines r7. The source is the def of r0 by a call, or (u32)(r6 + 1),
which is 'i += 1' of an int as GCC emits it.

Three negative tests get to 'r0 /= 0' and are rejected:
 - A test of r7 does not bound the upper 32 bits of r6 + 3.
 - If r6 is a u32 then 'r7 s<= 100' keeps the values from 2^31 on in r6.
 - If r6 is a multiple of 3 then r7 need not be one: from 2^31 on it is
   r6 - 2^32.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_movsx.c      | 186 ++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 2f4a678c31c2..6f90dac78fcd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -202,6 +202,192 @@ l0_%=:							\
 	: __clobber_all);
 }
 
+/*
+ * A 32-bit range that already fits the signed N-bit range is unchanged by the sign
+ * extension. Both of these straddle zero. The guard that follows can only be
+ * resolved statically if the range survives, and it protects a div by zero.
+ */
+SEC("socket")
+__description("MOV32SX, S8, negative range is preserved")
+__success __success_unpriv __retval(0)
+__naked void mov32sx_s8_negative_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0x3f;					\
+	w0 -= 0x3f;					\
+	/* w0 is [-63, 0], already a valid s8 */	\
+	w0 = (s8)w0;					\
+	if w0 s< -0x3f goto l0_%=;			\
+	w0 = 0;						\
+	exit;						\
+l0_%=:							\
+	/* dead unless the range was widened */		\
+	w0 /= 0;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("MOV32SX, S16, negative range is preserved")
+__success __success_unpriv __retval(0)
+__naked void mov32sx_s16_negative_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w0 &= 0xfff;					\
+	w0 -= 0xfff;					\
+	/* w0 is [-4095, 0], already a valid s16 */	\
+	w0 = (s16)w0;					\
+	if w0 s< -0xfff goto l0_%=;			\
+	w0 = 0;						\
+	exit;						\
+l0_%=:							\
+	/* dead unless the range was widened */		\
+	w0 /= 0;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A 32-bit sign extension keeps the low 32 bits, so refining the source
+ * reaches the destination. The source is a call return, which is the shape
+ * bpf-gcc builds for "int err = helper(); if (err) ..".
+ */
+SEC("socket")
+__success __retval(0)
+__naked void sext_mov_unlinked_src(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r7 = (s32)r0;		/* r0 as the call defines it */	\
+	if w0 != -1 goto l0_%=;	/* refines r0, propagates to r7 */ \
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
+ * The propagation must not run backwards over the upper 32 bits: a sign extension
+ * knows nothing about the upper bits of its source. r8's low 32 bits do become
+ * 2, r8 == 2 does not follow.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_no_sync_from_subreg_base(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = (s32)r6;						\
+	r8 = r6;						\
+	r8 += 3;						\
+	if r7 != -1 goto 1f;	/* pins the low 32 bits of r8 only */ \
+	if r8 == 2 goto 1f;	/* taken only if r8 wrongly refined */	\
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
+ * r2 is (u32)(r6 + 1) and r7 is (s32)(r6 + 1), so w2 == 1 means r7 == 1.
+ * bpf-gcc builds "i += 1" for an int induction variable into exactly this shape.
+ */
+SEC("socket")
+__success __retval(0)
+__naked void sext_sync_from_zext_sibling(void)
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
+	if w2 != 1 goto 1f;	/* propagates to r7 */		\
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
+ * "w6 = w6" leaves r6 in [0, U32_MAX]. A signed compare on its sign extension
+ * must not hand r6 the sign-extended value: that drops every r6 >= 2^31 from
+ * the range and makes the guarded div provably dead.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_narrow_base_keeps_high_values(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	w6 = w6;		/* r6 in [0, U32_MAX] */	\
+	r7 = (s32)r6;						\
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
+ * A base/step line does not survive the sign extension: it subtracts 2^32,
+ * and 2^32 is not a multiple of 3. r6 = 0x80000007 is a multiple of 3, so
+ * r7 = -2147483641 is reachable.
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
+	r7 = (s32)r6;						\
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
 SEC("socket")
 __description("MOV64SX, S16, R10 Sign Extension")
 __failure __msg("R1 type=scalar expected=fp, pkt, pkt_meta, map_key, map_value, mem, ringbuf_mem, buf, trusted_ptr_")
-- 
2.55.0

