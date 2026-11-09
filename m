Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206992;
	b=2P3lBr7Tfc36PH8E8VhCqVaprW8+ualQhIDBWWjDEQm0d8ZW2M9CPfFVuJ5xVboSeK/r
	 f3lTa/qvD5P+0iDjMKMQv1ZW0pSyhrvQ52hPgL4nKi5UVICDrPkEwgGzuWBRLGnDpjGl3
	 syNTABCL5nf8EjJQm+p9kV7dc0tJNKUgdtik/t50bFSQcY2EFEPdARSAEm/FajtGwa5nn
	 Lp1NxI8NjZB9ZmNZu2TBo70HRyqRExpNZbLYy8Rh2o89+EKXjUAq0TrtuLMlFOVZyuttM
	 Gzl3FYYaYxEbghOkKJ0qKkhFpA7wbivKh+nUlgTSywsmzQPbYtOaoBNe5eFMXxm9ELA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RLBrMfhTn9qiJKwYIIkQjsIEM2GFN0aZv/cn0uWBb8Q=;
	b=sOZjphK4LkGDnoHqe7gkQjN81Xhz3NNcNHiVY9zKpXaEYHvpfQlMeCjlXc7xutC2dbW3
	 cvlIxIOiXJ+MG8mgxOyzhwE+YUxgU8bmolac3EuUQVZZzxM4Hy7kMRjpS0dGocojthf4N
	 M4IiAYocEqOnN5kblCad7NxUJR2zOok00YSb2DB6Lnwe5+WIewafptL6ZY4fSysw+Clt2
	 3A3ZYxrqv4K2HNH0UtfCAj0mOkJKvowJcFAZVICOiF4BKYuPpMNaUHwzQDgFCeQWMtQMV
	 VdlbqnqelNA/r5+HMsY/Gj7wwLs+JVDpdDtCz7sV7qPLP+FNSqIOgfRmtgt6h+HpG8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s3Us9ZwE;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8F606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8D8F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s3Us9ZwE
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b12cb3c37bso227158a91.2
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206991; x=1794811791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLBrMfhTn9qiJKwYIIkQjsIEM2GFN0aZv/cn0uWBb8Q=;
        b=s3Us9ZwEcNhyAohYqloM7bEdsDEnSXwTtpxyXF5zVgFf8v0OV1ayBYVJSWWo2S2StY
         eFRHOjC2P9uCqzNn5RbY2qbqppJYoSk6AlkFXTLLwHKR5aF60p6zrNHCXaHkDQSwZSgK
         LPMUbdvfOJ3D3igYT6eqxyWxhmnl0pC4GpiH4hAzWxO7Mw9yYFFQKPNB0ZBrgQxCD14B
         m19mzXcyqBsogUC/kEkujDJY2PMxcEgGcbS3PJJV0JcWnNO2LQfttABvZ9/vULZ+d0zw
         TjxVzY9uaHNl8t1RTSPJAfLpZUuRkZxXX3KpMcUGd0bHaMTb2l+ycTCw0MatP5/jCPI4
         kpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206991; x=1794811791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLBrMfhTn9qiJKwYIIkQjsIEM2GFN0aZv/cn0uWBb8Q=;
        b=ldI5KCqh2tvR5hZ+5KMlEJVrRs8/4+4qH2jwMo/9y0jaH+RDz1XAju4PsGX7g3a5X+
         VJ+chY2qt+ZV6UCGm3XBt2Yp3Z4vhNO/QJhg396QE0fBm5eMvnrSuaRG9DaIlA6JZgzx
         cJzLurdQ6NRgFNcehQMN5/6SvHVYT2L/i1xQIqENKw7mA3LMOgOGACVpOpSbgZgWNGyj
         Gd4U5zEV0v0o0/w9AAw6FxBFwSlaLzQMDPbgiCAWntBYCjcWgj3YZfaoIkWAuGI5C68c
         HS1tiT1u+pm5qsC3hab1SeDK+PGx4xtsIyMLXJUmZYNdafFJSvVZn2jCMth398yoc7Pu
         IYVg==
X-Gm-Message-State: APuU4Z8/o2gfk1kMXXAiznP3psPVSo4h7dLIhqtgu2ZkW4OnxuE3PCFA
	1UPw13z3iiz2zGRWkiTskefjYaV9qvAlhIwx6l8TIDQFmSu4ZDFXSBlVqaaM1A==
X-Gm-Gg: AYBFou0wH9GxxWd5tFgzZoZQiTx7jsGGxDR5xUUpjuGGhHfM0szQJY8LmAfHYr+RJ36
	jG1grWxYDpb7dHjLATY7f2/WZDKOWxhlorc1G0cv2vew+P1AEIRo6xJ050MH1sP7viiZo1Bvy/g
	6HUUY/SMVM2n0p/siyEaDdHDfjZtq8nnNm1lixo/bK1jrs9FxiB1eTrysNrSEGr3Ga81qHMN2nB
	tD/TmJx4zz3G6IkXRxGavDvqSdF5YsxB1fxPORqJpcBwoiTbC7QRKJQAzFB7gmnorMMGdBVA0z6
	zADkYQXSkH5KuYquRhd6RWFVZ4YxqIeHNqY09OsdJEuiC4fETEgv0Hcqjkt/WNvxCEldR95lVuP
	Pk84yviVJLnfGxjQbd9N+ZI0Y9gW+zUc/NlgRrXxf03Kh4vssd+xNszhvWwEzi1aaGlaDSe33mW
	VQFDe5kppNak4gQjzgPkB1Xp8rZVHSGeiLW37sboMwSGxfc4wc5cph6NhOloLXp6GGTHntHT0gT
	6JgJd1Zwb/ey+0DI5z12u95hvvk/wPwYv1A7NLYGbMHW8csrJT64YIPsNl3JIdo2JbMVgIXa2Zz
	IY5ryC5Zst2Dj95kGS/f4yMyrMxOxjpXEL4z8ez5FTKtOQ6pro0QNcHhNP03SlRE4Yf/n0fUWTm
	2+JAg2F2/wWPE+CICQlwqlh26ilaj5DLlV7DL0CsKAn4H1G5oji+y1xd4IczqFnR6MJ8erygoKw
	==
X-Received: by 2002:a17:90a:d444:b0:3ac:96a3:77d5 with SMTP id 98e67ed59e1d1-3b12d3826dbmr2499208a91.36.1794206990843;
        Sun, 08 Nov 2026 22:49:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm9400767a91.0.2026.11.08.22.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:49:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 26/26] selftests/bpf: Test loops with a sign-extended 32-bit induction variable
Date: Mon,  9 Nov 2026 06:47:10 +0000
Message-ID: <20261109064715.2382452-27-alexei.starovoitov@gmail.com>
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
index 49f9a976a44c..6e72900826bb 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1169,6 +1169,50 @@ RANGE_TEST(range_ge_dir,    "", 10, 20,     2,   3,  5,  PRE("<"),    NO_COUNT)
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
@@ -3197,6 +3241,14 @@ RANGE_TEST(spill32_first_is_precise, "", 0, 0, 1, 0, 1,
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

