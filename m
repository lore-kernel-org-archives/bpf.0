Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374200;
	b=O1Eb5sJKk1zKHSPk7JkRYVNlx9R5UUIm4hVjywy+IiWMh7KaoYA01SEctdBm2i5B8jk/
	 r8RsxKR5ACsEFhvp+yDTTtBCpW86H/pxdbzoMdxRZ1gF9Ry4dOSZY2lQ3xiUoTA+DM/zu
	 f15u57UF5m3Vfcwy/YF/4IfE05BQrmSTQcCFyTAFRfXh/7KlK8ux19y1FqIMFMp62int0
	 q/No5TxL5wVyRNlNmhROyW4J2uxSHCEq7DfS8kZE6JX3w4qxwrHAkGfAuPHg4B7yssAMW
	 8b5lNyBtw5+V3P7bQ/cmLSeejw3AvH6B8ChOcxGYxtwNyAB7W+bsGPZO2pU9ERbA5OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sttn/QV3h6oOd7ZTycOxTF8tCnJsHD/9sEHeGCy2cQE=;
	b=VTgtQHdf7KuhDH8LXvCT9H9Su9qGGZjZu2hNq/fVTlcNT2PN4aK9KuOFZmpe9nniwH36
	 Zfwgclm2XV2pOdH23YzkLfv6upVheJQvwybs3f0QxEVi1qvn1SyFOLnubOYio/qMY8soy
	 q/EVqCw6OrziKQ+dSGhM80zPL7aQ1HvQW2YiN9RXxWIwXOGPWRdWJprVr71+XNwTabM7Z
	 3/CsgwEAUj61ACnSDIAFtP+8idGDotPPR+0ggmPoZmNfAFYHiVN0gOj2fUM8StyMzYS7M
	 v0KPO3MzsHUwrwTmQUiA3qHUXtNwAdEs12D4a+NsVEYsGyw1cWqNZKl2CG/pu6RtTxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sVRaQJdB;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CC606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65CC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sVRaQJdB
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so1660123a91.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374199; x=1794978999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sttn/QV3h6oOd7ZTycOxTF8tCnJsHD/9sEHeGCy2cQE=;
        b=sVRaQJdB5IC5DiU8RwgAVPMgpyHw7QVShDg06Fa3TyeEafR1T29kCYGS1PPFRCVWfM
         bUJROF2YAK+YACMDvyTY6mhY975EBjCifw/Tlwe9fy7Gfz0Frin65uniKDCRaII4Y79M
         k4mqm8vAIRENMWVSPURM+7GQXbmac0O9FAsU2aBGw95irKnWpAw1hFJ1oxDC7fXaqvnv
         8ttLU0uFE7//VHayej1HGD/GIniUO4PYyGIi6ELDjKlcCusoG28LPOIXJFTAsR+hTBkP
         AK2Q0lICinGVtDZOdNFnZ3QImFpaPzglikMh6nBEGzcaRz4lQjSbzFcbW1IM1qGxQtza
         q0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374199; x=1794978999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sttn/QV3h6oOd7ZTycOxTF8tCnJsHD/9sEHeGCy2cQE=;
        b=hTysPYgKKwk8TdI8ds9LdAZ7XJIGQaKk0jufikzlLfQeqL9OnVYlbMUoQTtSbHKQv5
         uofdRRcXZ6+hhMFcVHf2u2sdKy2/MzlWUU4v7AaRJ4I3d73uc+hiuL/LmXJbC8nG1fHe
         0Jv6d7s9gokpepTp9uqKDRPdj5iRjCG7gkb20qHRjHsL7O6HVeooEL9wN0kA3mFe5OgN
         PA7iIN3TOhHFQTSiPbroq/nHq6fjnrQduNhlMA0FvuJFyiWbXhjS7v8NQL2ZSov2vsWM
         p8yYrBheU4BZLNsfCSBG35S1Ree1A9vOpQ/Y4yBKmmM41ujy9dU/eiWbCwyxtiBZQZKf
         vrSg==
X-Gm-Message-State: APuU4Z9LUj98/L7Fp0mf/vzgX9jcqREfxbHMoF80BxrFyffc7lgXS0/7
	PKnAWFy3VF0nFeszH7fSetfL4cAQXZu1DY4aB3ggueQEeqgFe4kyKaGB+23KVw==
X-Gm-Gg: AYBFou3eqBDTtsXN2/kR9p/APYODZcP3bjUrFki491D1dTeiiFruLew5OlZwMGaXVZS
	MDkjs+gMFloSEy5J7hGAlronv7TRa1/4HWiLVoX31tegMfQvk/PcdAFv3d34/upUhhAHSPaA/1E
	OTexzZHHfBg0uVFZhY7iBDeHLO12eBv3Dhv7ks8p56kiGR+yi4MqV9uXuEMTG66dXIx+wCwZnEj
	cbO5sDovnkvLPn0ejWDKZ7fyLEXVg84Hww3W4jP+gsQfcA4H0HDntE5TJQXV3d7nvq1XFgf2+rp
	IJAEAq515wkg5h5ryUedtMoPkGqHC+7lWm4iH1SflTjZifK7S5WVfnoCwozX0NFoVdJW7YsvM7q
	/+WreJe4oGDbXt7ESqWP+dMX21gH8SSxtfBD/3fiAVe7SPGT0HupLjLKM3y4ecAH5GyRS2+fzSK
	L5pv21/3CLBxbuf9WrgXQbdQec0Nhs105+X4FFM9kp1Yl13sfLVZmrR4JHxP1o3PS7NAutAQPsF
	Q1GFXpa2SrpxuIedtdNyaRVV6m8yv8s0qrRpFMA0XxZrTly+ju3fCKMkjd+9LDliLj0+qcTcKGh
	Mt2SJ1YxTyJNeEeHjBz9w2C4id8c5EwqLgw0s7l5/FFE90jBwD5B0Wg6O+AvCBoZn56otmylH4I
	sglaCcfaQ3cIq7l3ZbFC6HXU2v18X9ZMzqJDasJBDd0TzA+tLBWur87n5hclk5DV8skhCE+bzTt
	g=
X-Received: by 2002:a17:90b:3c09:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3b182f35f15mr1403945a91.53.1794374198773;
        Tue, 10 Nov 2026 21:16:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17dbcbaf5sm2817099a91.0.2026.11.10.21.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:16:38 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 29/29] selftests/bpf: Test loops with a sign-extended 32-bit induction variable
Date: Wed, 11 Nov 2026 05:13:40 +0000
Message-ID: <20261111051341.2800252-30-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

Tests for (sext32 (linear rA IMM)), the recurrence of 'int i' as GCC
compiles it.

'w1 = w6; w1 += 1; r6 = (s32)r1; if w1 != 4 goto' is '++i != 4' as GCC
emits it. An index that is not in 'char buf[8]' gets to a read of r5, which
is not initialized. r9 is the number of iterations and is what the prog
returns. What loads is run.

 - sext32_iv: i in a register goes from -4 to 3. sext32_iv_hi32_dead: i in
   a stack slot, the half-slot with the upper 32 bits is dead. Both are
   counted loops with header_count 8. The negative tests, *_oob, have one
   iteration more.
 - sext32_iv_wraps: i wraps at INT32_MAX in the loop. Its range is all of
   s32, the index is out of bounds.
 - sext32_iv_unsigned_bound: 'i < n' with n above INT32_MAX. The range that
   the latch condition implies is not the range of i.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 9b1877a1b5e5..a79c00a99c89 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1200,6 +1200,50 @@ RANGE_TEST(range_ge_dir,    "", 10, 20,     2,   3,  5,  PRE("<"),    NO_COUNT)
 RANGE_TEST(range_ne_step2,  "",  0,  3,     2,   3,  8,  PRE("=="),   NO_COUNT)
 RANGE_TEST(range_ne_behind, "",  0,  4,     1,   3,  8,  PRE("=="),   NO_COUNT)
 
+/*
+ *    char buf[8];
+ *    for (int i = first; ...; i++)
+ *        sum += buf[i - first];
+ *
+ * GCC adds in 32 bits and keeps the sign extension of the result: a sign-extended 32-bit induction
+ * variable. r6 or fp-16 is i, r7 is first, r9 counts the iterations. r8 is 0, which the verifier
+ * doesn't know. In place of an out-of-bounds access to buf r5 is read, which is not initialized.
+ */
+#define SEXT32_TEST(name, _first, loop, expect)							\
+SEC("socket")											\
+__log_level(2)											\
+expect												\
+__naked void name(void)										\
+{												\
+	asm volatile (										\
+		"r6 = %[first] ll; r7 = r6; r8 = 0; r9 = 0;"					\
+		"*(u64 *)(r10 - 8) = r8; lock *(u64 *)(r10 - 8) += r8; r8 = *(u64 *)(r10 - 8);"	\
+		"*(u64 *)(r10 - 16) = r6;"							\
+		loop										\
+		"2: r0 = r9; exit;"								\
+		:										\
+		: __imm_const(first, _first)							\
+		: __clobber_all);								\
+}
+#define BUF(i)		"r9 += 1; r2 = " i "; r2 -= r7; if r2 <= 7 goto +1; r0 = *(u64 *)(r5 + 0);"
+#define OOB		__failure __msg("R5 !read_ok")
+#define ALL_OF_S32	"0xffffffff80000000..0x7fffffff "
+#define SEXT32_INC	"w1 = w6; w1 += 1; r6 = (s32)r1;"
+#define SEXT32_LOOP(bound)	"1:" BUF("r6") SEXT32_INC "if w1 != " #bound " goto 1b;"
+
+SEXT32_TEST(sext32_iv, -4, SEXT32_LOOP(4), __success __retval(8)
+	    __msg("  r6=(sext32 (+ r6 1)) / (sext32 (linear r6 1))")
+	    __msg("header_count is 8 ") __msg("widening r6 to -4..3 "))
+SEXT32_TEST(sext32_iv_oob, -4, SEXT32_LOOP(5), OOB)
+/* i wraps from INT32_MAX to INT32_MIN. The latch tests 0x7ffffffd .. 0x80000004. */
+SEXT32_TEST(sext32_iv_wraps, INT32_MAX - 3, SEXT32_LOOP(0x80000004),
+	    __msg("header_count is 8 ") __msg("widening r6 to " ALL_OF_S32) OOB)
+/* 'i < n' implies the unsigned range 1 .. 0x80000000. Its last value is negative in r6. */
+SEXT32_TEST(sext32_iv_unsigned_bound, 0,
+	    "r8 &= 1; r6 += r8; r4 = 0x80000001 ll;"
+	    "1:" SEXT32_INC "if w1 < w4 goto 1b; if r6 s>= 0 goto 2f; r0 = *(u64 *)(r5 + 0);",
+	    __msg("widening r6 to " ALL_OF_S32) OOB)
+
 /*
  * Two back edges:
  *
@@ -3228,6 +3272,14 @@ RANGE_TEST(spill32_first_is_precise, "", 0, 0, 1, 0, 1,
 RANGE_TEST(spill32_first_is_64bit, "", 0, 0, 1, 5, 5,
 	   "*(u64 *)(r10 - 8) = r6; 1:" LIMIT_ITERATIONS SPILL32_INC "if w1 != w7 goto 1b;",
 	   SPILL32_COUNTED(5, "0..4"))
+/* A 64-bit spill of i. Its upper 32 bits are dead: the low 32 bits are the induction variable. */
+#define SEXT32_SPILL_LOOP(bound)								\
+	"1:" BUF("*(u32 *)(r10 - 16)") "w1 = *(u32 *)(r10 - 16); w1 += 1; r3 = (s32)r1;"	\
+	"*(u64 *)(r10 - 16) = r3; if w1 != " #bound " goto 1b;"
+SEXT32_TEST(sext32_iv_hi32_dead, 0, SEXT32_SPILL_LOOP(8), __success __retval(8)
+	    __msg("  *fp-16=(sext32 (+ *fp-16 1)) / (spill32 (linear (zext32 *fp-16) 1))")
+	    __msg("header_count is 8 ") __msg("widening *fp-16 to 0..7 "))
+SEXT32_TEST(sext32_iv_hi32_dead_oob, 0, SEXT32_SPILL_LOOP(9), OOB)
 /* The counter makes the address of a spill. Such a loop is not summarized, as with a register. */
 PARTIAL_SPILL_TEST(spill32_is_a_stack_offset, u32, 4,
 	"can't widen *fp-8, expr is (spill32 (+ *fp-8 8)), requires exact stack-offset tracking",
-- 
2.55.0

