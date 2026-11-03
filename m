Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749404;
	b=Zqjtzuezf2HUHFn+h1562L32HFW4sOAmJCcoHFxFSrw2KlHzZepMYwyTTTteHK/1GMCF
	 9C6R671/047FvQzbcD/ubMb86vsfArfy8Q15xB/kiJy3rCSenEpLz6Wn3I5m+ui+D0qWp
	 YQjyK+71I/KP5mNczDqRV7Tk2rSMwEdHIKyK+BVESm1m/V5TkOgIEicCpXEe4JH9PZwWa
	 wYiHXYsxMhexz+myNMwkdij/V4zxkkPkM1ddzfuvRv8p86WgxfmNXoBaHL72MdML6cYOw
	 cfUV0giFmTBNVqfB6Nrel8YE3sfYw6K7yGfpVPTiWHXDxw3V0JaNHs9gP4QWkmafyeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EL6Q4henxTHC/gYmhExC+p0eHElVQQ226RHUL1SpDeQ=;
	b=cn9nPoyzQvrkF69NtBoDx5GnyHrePoJaN06OfSldufaTcAEggH9KzDQCKDWimKMyaYEy
	 TcqjH664NjwRZt6K+xOyifooj071QLuwsdz9yNS7q/tWakp2tYxQFxJGs3adAbRXP7PSH
	 yXU2okzU9wnACE39iIjm/6XBzwAPPq1c7coOMghTOQPvJxaQAzPdIcjTvgtduGWVIdGLH
	 i8Y9/dA+kC/eCB4b7fkPWjI3d4Lv574zXEcW+/S0eN+FvyglOVZjDq9L32ZNB78m+Adqy
	 Kq346E51MtPd06xeGerFCiyKKCVPISD+MhoXX6WBObv19BMIB8qDHYEKjvL3HMupDbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouBU0CBT;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FFE606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4FFE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouBU0CBT
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso63324a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749403; x=1794354203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EL6Q4henxTHC/gYmhExC+p0eHElVQQ226RHUL1SpDeQ=;
        b=ouBU0CBTsU7uU3ZXKPH9sz9CtDvN5RTGo6CWervvT0dKGRNvgdSAx/wsuXrJ3cxxvd
         8hiL3eteV8xL8zdjS5ixMYHa/yX20MNg1RfE+SsUNQF5sR6mn/qLQyBqV21wghwRBsqm
         FbFotn3prkwR9VNL6fKF6oFP6JGlG5D0EnwBH83t4ztKosmNxYdaEI1vJz2B5f0sOOQ5
         w7aSOCvuyofAxG4gpiQlKr23OwFvW9Ezt2wpsAj3eGZmvVvNxME5NwHr+6nZnaC2vKqV
         dXKcuDTx61Fdua/aXyVfjkvi+ZSMNbksXB7z124YQiOwNOke9wyINhsye7BPxGYiPHmH
         XcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749403; x=1794354203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EL6Q4henxTHC/gYmhExC+p0eHElVQQ226RHUL1SpDeQ=;
        b=P8K7TFxwbPHGpzhAdwohuWGSdXPMOHyJpCbW8wnmvjA0zQhjpD22uEzd38P4wLXMsJ
         bqh7QSbPeE+KkLjAHkjr7SpTed5cDZHl44blv4Pc66Vcvfq/xPG/Les+Dh8ZrOKNUJ3D
         CIerzBUaAdaciZFBjf25SDYaX935eWMK4IyJriE5BbKedU8HxL8jCdjBBV4k1pvMXPR2
         qA3XNR31d8JeffpYXDixgyQGsU9md52B6sX2TNv3CWg8uTybD51l/NfTbIZd+Q1tCU/B
         /Ddw8u/p8B9vq0deHT3G0bWiLbSuE0NmYNBOhQeePNhqW18wbPKB8X1Zd+R9AGG6aokE
         as8Q==
X-Gm-Message-State: APuU4Z/oHml21LgTqJ4a22L5JvGTsiuKgeozSGqWCCjXEIVmacXq2l4n
	35Zd+rfLN7MtAuB0xGoTfvP6g7jnJE9sclSWFo7/wjXT6TRxViwKAsnjQryvbg==
X-Gm-Gg: AYBFou2KEiUnQYaekpHM3kIEqRVDu3P2IiXfyt0v1v5ZI4K1JmEu5LmhP5AM6/2tovC
	ADGYiyyX9RdcrBVmO+mjIixJInM3PgMWVmxWEx07A5h3qWfofHBcMjzugRg+KWUuPb3kZUn/BQ0
	yaaemxLIzYmQAudMEQFvH4DQlvxNnxNyXzo56a9q1LWgmCmBVHxG+Q5pMeuIsFTM7JPbvI4x+9j
	R2jXmWNMWKVkovy5fJkuTIl6cRPYDjBbNGd0cVzC0aB7lL+Pg7NBt8l1RA8ALzC/rzedW/F98on
	5bGDjvtdUPH9p4bEEsFC00EhWv7Hoy0euNsCbM5tDyjXHOh/kUz1aziqn4R8bICDiVqrfc77thr
	uq5Ho60Sxt9FgVTjx4+p+W7Hj/5nrM6ZSFkR0uiSmknCu/9pyOne7wD9tZaEhVtxiksvAtYoC4B
	VJN3/srleuX72q1MrLLk02S+XMLgm4Gn/TIELEkIVm2WyXF7Cu4p+ugl1rim+loPWoBPlCG17WL
	SBES5SgqaL3GRNqrAY2ixU6kHEcpK/UVX4UGBJEBo/bmoFMm8nsIjZxmrUNvDtJ046b3MHtee+s
	6s9KlqHP1gbu1q6a3I13AV1MU50YYS/JLDJgvtd7hIEj769mxDCWSi7Quf0hvcQEAb9UpdHRHFF
	0/MS1Tcd6XoE74mz0AiTryEuiSXNTm+cNpS9f4hyJ04OnXcEYIvv4zWnw0sqnKd5Ve9DjfRGphB
	Emy7zZ4Z+Ps1N3nDBpw64=
X-Received: by 2002:a17:90b:4f42:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3ae897c777fmr11362271a91.46.1793749402815;
        Tue, 03 Nov 2026 15:43:22 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09369c638sm1094707a91.0.2026.11.03.15.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:43:22 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 23/37] selftests/bpf: Test a 32-bit counter that lives on the stack
Date: Tue,  3 Nov 2026 23:40:48 +0000
Message-ID: <20261103234104.208239-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

The tests are rows of RANGE_TEST() and PARTIAL_SPILL_TEST(). The counter is
in '*(u32 *)(r10 - 8)'.

 - 5 loops with a count: a register with more than 32 bits that is stored
   at first, a second load for the jump, 64-bit addition and two shifts, a
   first value that is a range with the jump after and in front of the
   addition. Each prog runs and returns the number of iterations. It must
   be the count of the verifier. The tests also expect the range of the
   slot.
 - Two first values, 2 and 0, meet in front of the loop. The verifier must
   count the loop two times.
 - The counter makes the address of a spill: the loop is not summarized. It
   is summarized if nothing is known about the number.
 - No formula: a step above S16_MAX, 64 bits in the slot when the loop
   starts, a load that extends the sign, a sum that is made from a
   different slot.

The 8 tests that expect a formula are for little endian.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 4b9a094328de..20141f45f28b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3064,6 +3064,72 @@ PARTIAL_SPILL_TEST(partial_spill32_dead_at_the_head, u32, 1000000, NOT_UNROLLED,
 PARTIAL_SPILL_TEST(partial_spill32_unknown, u32, 1000000, NOT_UNROLLED,
 	"*(u32 *)(r10 - 8) = r0;", SPILL32_INC)
 
+/*
+ * 'u32 i' in fp-8 is a counter: SPILL32_INC is 'i++'. It has a formula. The rows are those of
+ * RANGE_TEST: r6 is the first value, r7 is the bound, r9 is the number of iterations.
+ */
+#define SPILL32_LOOP(body)	"*(u32 *)(r10 - 8) = r6; 1:" LIMIT_ITERATIONS body
+#define SPILL32_LOAD		"r1 = *(u32 *)(r10 - 8);"
+#define SPILL32_COUNTED(count, range)								\
+	__retval(count)										\
+	__msg("loop header at {{[0-9]+}}, header_count is [0.." #count "] ")			\
+	__msg("loop header at {{[0-9]+}}, widening *fp-8 to " range " ")			\
+	__msg("loop header at {{[0-9]+}}, clamping *fp-8 to " range " ")
+
+/* On big-endian '*(u32 *)(r10 - 8)' is the high half of the slot: there is no formula for it. */
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+/* Only the low half of the register that is stored at first gets to the slot */
+RANGE_TEST(spill32_inc, "", 7ULL << 32, 7ULL << 32, 1, 5, 5,
+	   SPILL32_LOOP(SPILL32_INC "if r1 != r7 goto 1b;"),
+	   __msg("  *fp-8=(spill32 (+ *fp-8 1)) / (spill32 (linear (zext32 *fp-8) 1))")
+	   SPILL32_COUNTED(5, "0..4"))
+/* The jump tests a second load of the counter */
+RANGE_TEST(spill32_second_load, "", 0, 0, 1, 5, 5,
+	   SPILL32_LOOP(SPILL32_INC SPILL32_LOAD "if w1 != w7 goto 1b;"),
+	   SPILL32_COUNTED(5, "0..4"))
+/* What a compiler makes without 32-bit insns */
+RANGE_TEST(spill32_add64, "", 0, 0, 1, 5, 5,
+	   SPILL32_LOOP(SPILL32_LOAD "r1 += 1; *(u32 *)(r10 - 8) = r1; r1 <<= 32; r1 >>= 32;"
+			"if r1 != r7 goto 1b;"), SPILL32_COUNTED(5, "0..4"))
+/* 'first + step * count' is 0..8. The latch lets 5 through. */
+RANGE_TEST(spill32_first_is_a_range, "", 0, 3, 1, 6, 6,
+	   SPILL32_LOOP(SPILL32_INC "if w1 < w7 goto 1b;"), SPILL32_COUNTED(6, "0..5"))
+RANGE_TEST(spill32_first_is_a_range_pre, "", 0, 3, 1, 6, 6,
+	   SPILL32_LOOP(SPILL32_LOAD "if r1 >= r7 goto 2f;" SPILL32_INC "goto 1b;"),
+	   SPILL32_COUNTED(7, "0..6"))
+/* Explore with 2 in the slot first, with 0 next. The second state is not equal to the first. */
+RANGE_TEST(spill32_first_is_precise, "", 0, 0, 1, 0, 1,
+	   "if r7 == 0 goto +1; r6 = 2;" SPILL32_LOOP(SPILL32_INC "if w1 != 5 goto 1b;"),
+	   __flag(BPF_F_TEST_STATE_FREQ)
+	   __msg("header_count is [0..3] ") __msg("header_count is [0..5] "))
+/* The counter makes the address of a spill. Such a loop is not summarized, as with a register. */
+PARTIAL_SPILL_TEST(spill32_is_a_stack_offset, u32, 4,
+	"can't widen *fp-8, expr is (spill32 (+ *fp-8 8)), requires exact stack-offset tracking",
+	SPILL32_0, SPILL32_LOAD "r2 = r10; r2 += -48; r2 += r1; *(u64 *)(r2 + 0) = r6;"
+	"w1 += 8; *(u32 *)(r10 - 8) = r1;")
+/* But there is no exact address to lose when nothing is known about the number */
+PARTIAL_SPILL_TEST(spill32_unknown_is_a_stack_offset, u32, 1000000,
+	"widening *fp-8 to 0..0xffffffff step 1",
+	"*(u32 *)(r10 - 8) = r0;", SPILL32_LOAD "r2 = r1; r2 &= 24; r3 = r10; r3 += -48; r3 += r2;"
+	"*(u64 *)(r3 + 0) = r6; w1 += 8; *(u32 *)(r10 - 8) = r1;")
+#endif
+
+/* A step above S16_MAX has no range, as with a register */
+PARTIAL_SPILL_TEST(spill32_large_step, u32, 4, "can't widen *fp-8, expr is (spill32 ",
+	SPILL32_0, SPILL32_LOAD "w1 += 0x8000; *(u32 *)(r10 - 8) = r1;")
+/* No formula: the slot holds 64 bits when the loop starts, */
+RANGE_TEST(spill32_first_is_64bit, "", 0, 0, 1, 5, 5,
+	   "*(u64 *)(r10 - 8) = r6; 1:" LIMIT_ITERATIONS SPILL32_INC "if w1 != w7 goto 1b;",
+	   NO_COUNT)
+/* the load extends the sign, */
+RANGE_TEST(spill32_sext_load, "", 0, 0, 1, 5, 5,
+	   SPILL32_LOOP(SPILL32_INC "r1 = *(s32 *)(r10 - 8); if r1 != r7 goto 1b;"), NO_COUNT)
+/* the sum is made from a different slot. */
+RANGE_TEST(spill32_other_slot, "", 0, 0, 1, 5, 5,
+	   "*(u32 *)(r10 - 16) = r6;"
+	   SPILL32_LOOP(SPILL32_LOAD "if w1 == w7 goto 2f; r1 = *(u32 *)(r10 - 16); w1 += 1;"
+			"*(u32 *)(r10 - 8) = r1; goto 1b;"), NO_COUNT)
+
 /*
  * r7 starts as 1 + 6*k and invariant r8 as 1 + 9*k (0 <= k <= 3).
  * The (any r7 r8) union must preserve base 1 and step gcd(6, 9) = 3.
-- 
2.55.0

