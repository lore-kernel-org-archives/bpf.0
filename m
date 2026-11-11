Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415734;
	b=GKGbsZRCwwa2NqUqqnp3Mkopg+SnGA9/YSmmOsVkgN8IIX2aGR3zM5CqcqGeKGB9WLUd
	 8S+mSvjmGRt1iq7S1ke25+WsTh95Jtx1Vn966n1p9ba+KZpg3ou7+qUbg5jU6vFfDTiOM
	 6jIsa3+fi6r9nzXxGzHwkKDsm4cQoO0BdQ48ttxf0iWA2xheZ+VIMZXf/nQk/nj/ekkTu
	 OXXi1ChI65fKxmNVgyFzu8OAebBgU5/eiUu+yvYWjK+VijJa+eJRR+W/1HlJqMziyRSlj
	 7uklnxNAZUSf2RENrn420H5HFEeuW7G3de5ffLTAsU73vI+2qLnEyxa7fGmRGsDbWZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HQuEJoC9J6RewKWbkujJ2exOqHiJr8K0rWFWeLbyGsw=;
	b=qLM5+vsC1z6DoZNaaIetbhFDG/vLwU12+mGWPHJzP4zqaTqyl0c6wVhxPtANXuIsRkUU
	 CtK6FNBOcQwZEVj6fhx0H6Dl76M8GayHpb2CYd0yeEEOqPxL06NcxL9vxCgINIwRgqPmc
	 COd1ggZ/nHI4U5nAmiDAxkeGQhTTZatw4r1AjxomSv2nVJYEofDWyexT8/uMLhnW8Yt+1
	 ayFPI0w8mp0w+fj3ZUbD0jXPGHUATgRVOmvxy468OrVbMXunRbZ30ypyvwNkOOO5aojrg
	 xgJ3E30ybeRZkGbEBXrwL0PrCviSxchgTuKUIWI9GYwECwWwW2hw94KaO0Yg/XdX5xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYvNp+9V;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEEB606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FEEB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eYvNp+9V
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so2112358a91.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415734; x=1795020534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HQuEJoC9J6RewKWbkujJ2exOqHiJr8K0rWFWeLbyGsw=;
        b=eYvNp+9VVYfm8Ypv6KbYJEFk1npnj1epL+8EaZTJwxHQp3OCf9XIhjPO6oCOwwWn+o
         Vh8Vi0EQYqQ9mk/EozuS22yfo2KHZvjRYjuCoarVNet1vfXv2wFOzaLaj54YFB8XaRpD
         nItEfmHMHEs/cql91p/pwqoq4+qknIZ4YPIE5poSrKi7xhHEyywxA24ECSgT79tpMytz
         PpQjE9HhiUWTTs3adQ6Rpe/fdJwaudbumxSZZn4UTgMrV6Er0naBAiVALv0HDWKsjZ/J
         gwc2LnXTadGiltPicsVqAdgumZyTs9g6IABHlGAtjFR5/V10Ky9eD3dUckr8NBzqQGwg
         PwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415734; x=1795020534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HQuEJoC9J6RewKWbkujJ2exOqHiJr8K0rWFWeLbyGsw=;
        b=EeRNcwf6zSVmKjZMRlgL0cZWtOCLZ1pt/K+LkoAqk8MUdJAASXaQj2223zFRLf8n37
         D9DeoNbxJAcrPjPvXhzhCjqnQEyO8RRKJ30jCUihZR37zr0nk7pfMWMGCbirOQXR7xCy
         atoBXDOIndmAJAYGrYQWkkotB3G/1R3E0BKqGPFEgjbwQuSSif1YFTsPrT3jVPitbdO0
         lVP3ripNaQVJi0tYy0LIdx+Hx6A1ILkZ/nvkrsmEU5TshWtJF+SixqcvLYnpfqAF1jpa
         hPOf0Yr+TwHmgt9uEg2sxaoto9CQfASpdEGZKs7lGbErXn2IrD6v79FZSewS+1lF5zL0
         4E/Q==
X-Gm-Message-State: APuU4Z+tPAqQGMMQaTzmqK+tI4Uq2syBg5lk8N2m7r9b2/m5Kv1N+iBN
	MZj+k1IP6OPj8tiiGFiZN4kDqNen0Dp/+aZ2h0YgTRpSiSDTKWdV5PylKsy01A==
X-Gm-Gg: AYBFou19WI4YAEbOkNk+JOhk9zZfpcxTxwiIuZf7EPGOn1+qZrLusaLDCXXlbGV+8KW
	FcdPcz866Q/Y8C5oJGgwjWq59RVnu3G1Sh2EFGEd4k3naQuM8vQLEZ7QWqWAZkfgs2JjFiemxk8
	iYxWHhqPrLEZNQKv7QRAYWMappSe5jtXqSUcJico33oxYQWZvOruGxYxPM2tNpln9QbWZ4D4FGP
	hbpoAItrNDL6nDpgVfJyt4FWtrOYtlm/tFXp/lKCvWEZIO+E0U9qzInvjfLVxlwdJG3fk/hxwOe
	1UddDRaZgIAgjN38vTSpX8msZbVQLZatyzmBlZD9T5K8WXFMHL2Xw/E7WMrhff7gqRWKqT+wT2k
	aEdG/yCoEunj7wke/M7U4/MKPcP5Obny32iPgDzZ9lJ4ahtVPQnmhSRjNCD6NqVoCerV/0a4TW+
	/PA75djY5IcrwIiQgQ4I9SQezGvYdX0i9Yi+b58HBDNioBvDr52c9hT3/c7NnJKcD2oeLjH/XBE
	eY3ET5uL5dCd1r1Q8VVWyaeUKHUo78wKDtoy78L1I1wdLGNyR5+4iskdzNQn8adgnYgHoZTlUn+
	IzmeOQTdOu4RGYBhWb7dvo3vlkrpCzD3KXVzN1RHkzxtMUd7J+OdzDGl2AzfzmZuTOQ1ngj6uBy
	/jhhjVNikpoAizye4GS/di+GP4x30drP7OZHvWIZfDSOrY0/ZWhhPx7kASb05cG3xO303ZBMJSg
	==
X-Received: by 2002:a17:90b:2d08:b0:3ab:f2a9:cacd with SMTP id 98e67ed59e1d1-3b182f26e76mr3058403a91.49.1794415733742;
        Wed, 11 Nov 2026 08:48:53 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d35525sm18728a91.16.2026.11.11.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:48:53 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 29/29] selftests/bpf: Test loops with a sign-extended 32-bit induction variable
Date: Wed, 11 Nov 2026 16:45:52 +0000
Message-ID: <20261111164557.2659679-30-alexei.starovoitov@gmail.com>
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
index 3a01bdf260b5..6fbe4b435d35 100644
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

