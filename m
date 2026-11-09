Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206921;
	b=pgYiOYZbWy1WAHZ8AaW4ZPildEkjz1s2r4ppP+BQkar557veIMbEWYXMuhlD5bkexS/A
	 hkHQeovacRyyFCEh/BkBwK/LEEuqZM/Ra5F694vBErkMW6hVzv5mErHO+zQAykDBVKetT
	 MWLagv93q7VcLK9U9dy+qKXz8SOz3czGvt0ypNiTpup0XWh18rmU3lTaMpBOtiqAqgkws
	 jj0KvOwn22gm3IWuG4q4zQds1So5YklHE9l6IjbGmYtkHWwyFd5UlGurT9qJXFGgt2NUp
	 j4fpU7iBKKA0rA/DoJFKiiAC++7fe9vJHBYwCNr/dvsqmE2lzJ9yBcgDqcYIhUEbLbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
	b=DaHWHs6KAKhEw2BYMlwmx3wMdA0Z7l8oRnRRqVsjlDnfrLyCoIzqdQUKrBDxsazNMzSD
	 Lsp1q6F01V2uT8oJRSvXLN4jRG10sslbejMrEaReNXHYXx8VEBMFaHZTJCgr+BZDkQMZC
	 tzPQgSFblUtCrYaX8J/DEjR5ZTCnQCKu0rlek3nJtiAvh+o5VNdK9bu5B50O528W5rm9N
	 YiPYIl6DX4k1xm2bNG4VF5HJrVUtuMX3QjTkx3pId3ZIYmLY9gLpqV/6KFW91U3cy1k0c
	 Vo9gEAT8X/HkEY5ITs4xrjPLY4HGz7ZEHMUZCCEhNMR3UHDOIEyLlDhoZqxIQlVMU0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yW3UdRcz;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C093606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C093606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yW3UdRcz
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ad787e0593so258650a91.3
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206921; x=1794811721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
        b=yW3UdRczeAFfB+cA+6Pu+9uVv55rGXpfxXWmeaMWRCzCKFuLVDwxuYafytcQwfWHmA
         1s8N1iPXCdQDa2GXRA/uvcTUwMF7Z318Up9UtFdA80ApmCnr357h57OYFTr0XZY7dQT8
         Og2phxWGaPNN4A5xI8pHpkMxA3G3cDtHqHeYMp0c8FggVDdwXtV/j1a3DEoIfEjK0php
         a5lkFsUg2TkaZNoQl/khmWY2M+yQJMLsm1UvpiC490vheaRQafLK8R0gQEXmhm8oB6dh
         irN8p4yNssHljZ/hjK+y22Q4V9lsCUoWfZpEo5XJ4AOoFWOryVAD79RWeSJBrl6nFqEE
         d17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206921; x=1794811721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O2jjMVEd2+veLjBsKlSN8S11lNRJrLDfCaGQ947D4Us=;
        b=evIJAVF5y9oHrn+d7ntgQvxo1wvlyV7IyKaCmI30p4mdHEk8YU8pn8pnGCq8jQ0wgY
         jrVw8phaJ0Fi9KRLEztONcuN7I7DOuDyAD0yDKZvMuYw6s5K8CkXVfIKC6YtPooKYgsZ
         AlbZ/bTDLJtyJ6CNrv28oRudQYo3zUneWlhb4h4FLLMeqolVG9MNYvy2M3Jy15LzGr4c
         NfY1dBjQka8LRtKyB1kPmALyYtSThysHVs2rnpKBlPILdkqpLgxuLHpazWo8wpiyTvOB
         qQWvxzFnjK4YkZ/3y/KmySvsGZDIp6ef9sPQl+50o4BBii1xXdA7y0XdkSkRJFwt9Ijz
         gIxQ==
X-Gm-Message-State: APuU4Z+tIFuSQaqYjKStWxVJ18Bnl6wwZYycJKRIDitYDJvt0NhL7/sE
	q0nyyw5GMMnJhTmHXHIYDwfHu3AL8fyamVox0bnTtbd4FnvGXY4TXE2hhRY5AQ==
X-Gm-Gg: AYBFou1xkxoSGIWjb3E1lzYNDZyaMg9noqC8fV5fEkaThmLTLJGYJMSsKWJt0SZ7ufS
	puUUgQ7PxDArKWtqvcI1Pu+4WwOWpSpeUtZlVs2l8LHBE6IAK/24LpCAtzKg/fK5+RReFmsX1mH
	7hyrjG69ZOjfnRIc+7QGmTHuwm65FSysWdDjhG3OSUuD+sILomkne8l1PyiIKTvkVxzSxXnLBLz
	LkZBsTjnrFuHW5gonNc7jnklJqtedXX4VCp025LXYIuFmQPP4AdEvpUeZBcoiVngTs8dCFnuHS+
	MbRc0KL6Y7wJhAe34qz+9sEXMR/GOkQSaf4YB0K8JT3EN30ct2HtFVSBDjrMXOOTltxpGm5Dya1
	EGkhS16ec9t4OBmvg9zqOtr9Bq+7lhhC+pAzsmc8kcBR0LjVDCFaxCSIX6Cv+AYPzyiJHg3PsGL
	RW6TsI2IJNV77XacIMx7OXpLB4KCUo2QPlOo7few64YM40UbI5QfRuU22kCW4fxgiJgMVt4KW1c
	lIU78BX+puEfsaP+P0rjVp8U0id0UM223kbN9VRAgE0lgU6wgpggEPEq1uYm98GaRF5XwGtBobn
	617n6QYziG+IJJLRJgEY74R3SlC0T49vYSDm4WA5bTXoXYQ3Av/QS3yncYpQmFXuZU7BnTbZBjl
	BIT2FZF20z4eciRnf7QEGj/ImXtU9V5SqW3xRpU3IN49HaLdf+71OaXFIJz86tYz5cHEwiyxlQv
	s=
X-Received: by 2002:a17:90b:224e:b0:3b0:e2a9:3466 with SMTP id 98e67ed59e1d1-3b12d2d9c58mr2555666a91.16.1794206920581;
        Sun, 08 Nov 2026 22:48:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1305bf886sm4464627a91.7.2026.11.08.22.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:48:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 14/26] selftests/bpf: Test sign extensions of a range and of a linked register
Date: Mon,  9 Nov 2026 06:46:58 +0000
Message-ID: <20261109064715.2382452-15-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

