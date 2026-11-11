Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415651;
	b=ZeO/kNWxshLx8cr30bHm5TP2Ubjf7jWGb+YGTuFNxU4Q8mHNUlM8T0GuJlY97f51DvXA
	 G58A+/XIAzEtS8uytxx2i/2LKIHu+5bl3Q3VE6obt8okHtOcCBGt6tCteq3NqG8diM/YC
	 0kp53hI90sTI8M7iWOMehBV3zetz3nUqA++BGf4PEII52xCR8wxSkSMTl3nBwmPiaOYGs
	 FxXoca+MxNVk6/u1DZc5XFdNiDYhUdywTQzDzgjom0faVxRITnErrPnkyiuztUgpND9Bp
	 CBU9eaeTspyGe3eiqpytE4OnyS34xq/bbNvIqAOWtMDs72+QM7PVQ13TyObJThy4Qgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
	b=0yDgLASi16TGXs/8KP9fINOKyEJd87Fn1V+hzWYLX/eXluq8FIJ7rDX46sVbj3WqMyqB
	 oyRfI5bGh7f1L/ZfDbmYmC2rFAV409oTorQtoeqeutgRZHEH4SNVU7Hse9+q8LgNe37hl
	 rzGxfp83WP1Y4hJdm+HqIeIR+w7V+cwVx/e9Mwdaf1I3VT1+mDJl8zyWGFD4qX0ysgd9L
	 sadNZ4mFA/G4sC1QLKULzCrI97Xj1fUvj0/R4H5B89yFvmT0DG6cTexunNTQe0jsATJq6
	 3IcF8jtUylfkchSU/xwEQoj7pUGoocus+5CGjsX0Kpczdrn4/Fl6fawey+WNr3UCm2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBukULLK;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B37606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B37606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uBukULLK
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1414229a12.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415650; x=1795020450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
        b=uBukULLK/zQZb1xwtE6tWXOpQZiZ6unhQAlBJ1yTHLSEssAKCo/mXiQdXN1tRivUdN
         gMSE9MYLhazNUH7U/mO5ob7YCBOhY9wjv0zS/pIRGptSVVEg5MPtRruoYoDyMWwW+AiI
         eHxl6SJa7NFWrRURuCur8I5tYMHVD8XxHwwuZ8ZXH+OtJX8+hMlNnecI/IEsrjCbTMof
         qxWRqpWPbCpuTeGUw6w/MAZgmOSDiEjq6f6M6laddOCkHqvwW9pDgWgfhCrJR9txfyGZ
         f6fDIjdGMiaaY9TIUV+trWSVFdsFNpnXjVDvqpFOazpuOiXAa0o0KoTk+bNloG0LGqab
         AX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415650; x=1795020450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
        b=b+nyThoMSKZZxJLFOcXzaSrP5IzUOvACAXRMG7yNwJavTPSk51ZvReAWbivv0tGn6i
         1nCh9/NUSynMrZSn+op9S1K+QmYr6Qb8NklNJkWEmofxVVU7lq/BW3TcP5pjcImUqOqh
         j//UHdJriGRlrIlAovSJCMBfUUq4CKaocQq1ZcS3Z/9holEZoQeMirTXScT9O81JRLX0
         DN2QuWYEDAssVCbUnzXKiusVx0PGUV+b4+fk3QXRQcEG9RSbU737DbNagCRO6VCqcXis
         Isi2LWv7VX2MP/0aMeGarovQOgFe4OQDgKBHC67yhTN13XZ4Y2h9qDcfTWs69l31bHWl
         cUXw==
X-Gm-Message-State: APuU4Z/hTbDBA6apMbOBrmwAwFXmpZwIJGnUVFiENQ+9BUfRoyNAKYtc
	QsQpIpBqJbL6a8MfUA32hrcor/Mcj8LEQtpwK1juQLz1pvb5MGykvhceqO0jwg==
X-Gm-Gg: AYBFou25A2X/eAXksV9KmY2PO1EAlnZ8MUC4+aB72SXyTMcxp2kLcNvn8EgvbesQa3h
	rRE5TrphbRr8LFC1g9ljJV4qximFD6iQ1StSgs6SNZLUYNcEodOnIS8eIdXMibNOxw0l47+Tr9i
	MneD4xmlT+drch73Rzk2Ftke18yB37fDWiyI3TkPT2ma+7ibV8vQ/NJqhDUDMrKXNA1oyfZFa7B
	mcoqKa4qmO8Gq6LsoJSS71rzaPsIRlZR9cUXS9vpXzxdxSO2X9eT5fNojZ9zcU1kizDu0UaA96I
	u+hXV3Mi563QlLdEbc7B9DYxkOyj79PWKpnTeNcMSxiUARiLJDh03JzcFJh/bLIST2Fki7miszc
	Re2OrUah/vX7AxviKe3QoNy5AApufQVc8nLvOLskxs/UO/M4q8kIpJuEgs6fo7KmW1NS7QCgDFQ
	FEi630/xtWzDjCUSYcvr6t4k8o30ZFM+EkQJBMvpCPWmbDxjkmmKXE+m3uY4fnGfm44ui+tRjeK
	ceXCLl64ZDe43iJ/uZTuNuz2zICgC+kiuvYxpP/xj3LI0DeE6B8Y9cKSMNqZgJ2rCNyt904rIa3
	p3ZelSE8V61s5U0lEKsUj4MlVDg1Lf9Z36euMK6vug+mEkB6EyGyfl8/jBvojkMrc5xu2vXH1mq
	eG7CxomTphBR6cdSn0aQkPc1Y+D82axhbdco8gfAmJwJY9NeogrWAjdiUCP90CDRoxJD337RWhg
	==
X-Received: by 2002:a17:90b:2f07:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b182f26e50mr3052818a91.28.1794415650081;
        Wed, 11 Nov 2026 08:47:30 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67f209sm1944766a12.6.2026.11.11.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:47:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 15/29] selftests/bpf: Test sign extensions of a range and of a linked register
Date: Wed, 11 Nov 2026 16:45:38 +0000
Message-ID: <20261111164557.2659679-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

