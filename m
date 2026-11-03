Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749380;
	b=4Ddz/oVh+ceOkHN4W/7SMV3aOSWl4Oa3cWLlluHzqfF45hTFnaWOu18opA4C5c1ldwBL
	 zNvK4Er0SQr3uvk4MakCK6Y8DGNK3Vse4GpjdBecevUfq45zwSUJs4frBuw1MDtoV5LIL
	 ZuQl6msDsS/Je7FfmIQ/NIwzephue2qOCGBIMGFqgifgbXRSL5tJKzByAGMnTpTV2D4vQ
	 tL7dYUgFCDw3kqIJUbRZkCa/uHJx1VCMBSyMdC5LeZbcQ2MQKr7tPni+m20qQle3xJhkq
	 /pfSFnWmWpRRfzeizgMO4JEcPxittTGvvQvsmPHpdu9xpSJfgyV1uCF7KfbyMRZMqHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749380;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SZjEiQxeTvCyqVs4lqpLDdXSx+8OZ+IaNsl76w2rqtU=;
	b=Z63SUQpjaUFfxusA/Y0ggfmNYKbOu6N+YkZi/pCao/crPKQFlwGqxZv8rTdubaDPJdwl
	 BXN012KPDeeGssnvJ/z/HeI9aStYjFwKmmiKwhwjEZxRjkrYcJfISk6mg1LiGAjY3wM8d
	 OFpoNIoESQed5nrIKf4ZU2531CBoVRjhlgpq7UNRRo2IQqlv1uJiXdsadTsmgOT4+veoi
	 7BkdUBM6tku4uLGTcswhanVBpqUJVfFt+ZfKpoeYXXaYcm1tyfsYQzyOwgTc75ucFY3ON
	 wc2iRqIzB2xeWoDOTLj+W23MsiwrEvgwOjd5iONdtcnS6pAtqOxXSknRAsPL4NtLj3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGnHOXCy;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76A606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A76A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGnHOXCy
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso102145a12.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749379; x=1794354179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SZjEiQxeTvCyqVs4lqpLDdXSx+8OZ+IaNsl76w2rqtU=;
        b=UGnHOXCyW6VRdbfykp5B+u3Wsj07sghPQ+qWLRb+DCemErl7DbNNfJ5aTw/dih0Hm7
         WSgtXQGfuY9SEMdeXTxbpBG5LWxcPq4KR98HYjVSrcCbTwDTdaGePNm73LmKusDfS1Kt
         hY36wK+JbHxteC5fVgTg6tJgFoaQx8HckaeOghLpP7o3zmLyZ5g1O+gyZnu40lMraNKM
         ci8RF6QSa0t2prXQtkX9zhqVpG1GplOyMXXKTpsdto1F3fiA8ZQ7YZNsTQxDs/j5NGYn
         WUYVt4DXF9/ZodlRU53E5yH8ZG2Kv4/B7rTjckooakx1CtjmQmqPhO0vSAaL+BPOuF2/
         0paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749379; x=1794354179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SZjEiQxeTvCyqVs4lqpLDdXSx+8OZ+IaNsl76w2rqtU=;
        b=IXoLalcAnZ5IRCzs9e+vZ9M98jbEhBtHHtithLWNJpIgG+PhBrvvn3B44e+/wybFkV
         Bgz1A993NsuW/CubEl6iN1rAwLPh/pzFA8F1EQmU5WeU2Oni6G+mxmzAkKibQnGUeUUS
         4DL1a5DUmDZByRKeaCfl7L26EpKEHimGywPhY2Hc0CE0kVgcv7zAFgkk7vZnwmoA4wka
         HDxzyZr726zQJUXFhXHXCV6n6yERQ1WlEYuYExPBvYx+PiuXoizjPVOmj571qn5rcm4y
         wHZxYlklycL7JNV9rGOTaAQuvX3rLUstp46aP1AR6Zc63Cv/TGYIGIDjAW1wPNdBJAHH
         mb9g==
X-Gm-Message-State: APuU4Z8ZwVpQw/XIH9ekDOmu+ET2FULX1em7LGUG7pX8VDygxH3Sa2cd
	FJkOzp7lZhR87+6fR8Id7tzCOXZ+GiaB6SQCFkRF89m1VIh06buQgSU9Tkfr8A==
X-Gm-Gg: AYBFou3P++pvgCG0JtmtHIsVJH+RrhODzJS7N0gWqq1KZNQGWQdyAIx0vkHrzKzvxfG
	UCYput4IJdCZLOtvNqsD8UEVEClQK1HcDqlEmIa/h0+DRWxLdSP9ZOwcJnanJvhZlSaI2hK2RE8
	9M0X/lDruVWB5zvxZPbMXnC5oCFN46F5tv7LtEB8odxV0HL4gmcLP2NefcsIstMASHM07w7/F2C
	Pom3kWi4o6BqNw323OP9tONrycYkTroZvGnzdwYR8BNo6ODA6DWVT5+z103i9JFT4n8rExqbBYo
	iTgKX+FLuLXpA9OIPyNs+7pwV5Tp+4GMFoOOqMLE9BuidLUpygmtZ6W2nxfEvd7XAi5kuMJ2d6+
	NOqrTnUmKa5AA/xxcZ/wkMGCK9KYVwNqdRTJ6Uq3THQTAR4qvHCVVhpgaTMITFOs0VRK0MmyoR2
	M2eylYmq3trHLgmkVV/wRJqBcpFat5UoGvUdFZfJO9izthP9p7MUFm3gFfTl2AT97wCUdfIEafM
	UrVv5nDZecL8Kgut2b6sxJE+EsmbMk+vXee/PmLoD90ahFAM+IWbRFu9qr+CvItoiujucmn41Kn
	KOE/yl4/NDl7wYsiPNetappMANn0k368KM147P2d/RFhSLP+yVaLrSRSauzqdgiZIYXIgbpyMSw
	bi0agTtFHO7BMezrsNScv2SJpuiwb1bYzfr11+1whFi9m5ExgN4v9tU331Xz6KNlG45dMaaPtBQ
	==
X-Received: by 2002:a17:90b:2f8f:b0:3ab:b39f:41b9 with SMTP id 98e67ed59e1d1-3ae897f8c61mr11731815a91.61.1793749379210;
        Tue, 03 Nov 2026 15:42:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9928d1sm6549399a91.14.2026.11.03.15.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:58 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 19/37] selftests/bpf: Test more registers of a counted loop
Date: Tue,  3 Nov 2026 23:40:44 +0000
Message-ID: <20261103234104.208239-20-alexei.starovoitov@gmail.com>
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

 - A register in [0, max] loses bits: '&' with the register on the left and
   on the right, a zero extension on one of two paths, a register that is 0
   or 64. The tests expect 'it loses bits only'.
 - No rule, the verifier unrolls the loop: a register that enters the loop
   as [64, 127], shifts to the right and to the left.
 - A register has the same constant in each iteration, in 32 or in 64 bits.
 - A pointer to arena moves in a loop with 100 iterations.
 - The loop makes a number of a pointer to arena. The prog must not load.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 6777d545ec1d..c91d178a1aed 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3063,6 +3063,91 @@ __naked void conditional_scalar_assignment_gcd(void)
 	: __clobber_all);
 }
 
+/*
+ * Registers that have no linear formula, and the state that enters the loop stands for all
+ * iterations all the same. r7 is what @init makes of an unknown number, r8 is unknown.
+ */
+#define NOT_LINEAR_TEST(name, init, op, expect)					\
+SEC("socket")									\
+__success __log_level(2)							\
+expect										\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"call %[bpf_get_prandom_u32];"						\
+	"r8 = r0;"								\
+	"call %[bpf_get_prandom_u32];"						\
+	"r7 = r0;"								\
+	init									\
+	"r6 = 0;"								\
+"1:"	op									\
+	"r6 += 1;"								\
+	"if r6 < 8 goto 1b;"							\
+	"r0 = r7;"								\
+	"r0 &= 1;"								\
+	"exit;"									\
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);				\
+}
+
+/* [0, max] that loses bits is in [0, max], and a bit that is 0 stays 0 */
+#define LOSES_BITS(max)	__msg("r7 stays in 0.." #max ", it loses bits only")
+#define UNROLLED(expr)	__msg("can't widen r7, expr is " expr) __not_msg("it loses bits only")
+
+NOT_LINEAR_TEST(and_clears_a_bit, "r7 &= 255;", "r1 = 1; r1 <<= r6; r1 ^= -1; r7 &= r1;",
+		LOSES_BITS(255))
+NOT_LINEAR_TEST(and_on_the_right, "r7 &= 255;", "r1 = r8; r1 &= r7; r7 = r1;", LOSES_BITS(255))
+NOT_LINEAR_TEST(and_0_or_64, "r7 &= 64;", "r7 &= r8;", LOSES_BITS(64))
+NOT_LINEAR_TEST(zext32_or_nothing, "r7 >>= 8;", "if r8 == 0 goto +1; w7 = w7;",
+		LOSES_BITS(72057594037927935))
+/* 64..127 can become 0 */
+NOT_LINEAR_TEST(and_64_to_127, "r7 &= 63; r7 |= 64;", "r7 &= 127;", UNROLLED("(& r7 127)"))
+/* '>>' does not make a number greater, but iterations one by one tell more: 0 after 8 shifts */
+NOT_LINEAR_TEST(rsh_on_one_path, "r7 &= 255;", "if r8 == 0 goto +1; r7 >>= 1;",
+		UNROLLED("(any r7 (>> r7 1))"))
+NOT_LINEAR_TEST(rsh_then_and, "r7 &= 255;", "r7 >>= 1; r7 &= r8;", UNROLLED("(& (>> r7 1) r8)"))
+NOT_LINEAR_TEST(lsh_grows, "r7 &= 15;", "r7 <<= 1;", UNROLLED("(<< r7 1)"))
+
+/* bpf_compute_const_regs() knows that r7 is the same constant in each iteration */
+#define NOT_CHANGED	__msg("widening r6 to 0..7")
+NOT_LINEAR_TEST(same_constant, "r7 = 17;", "r7 &= 31;", NOT_CHANGED)
+NOT_LINEAR_TEST(same_wide_constant, "r7 = 0xffffffff00000011 ll;", "r7 &= -239;", NOT_CHANGED)
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* The offset of a pointer to arena is not tracked */
+#define ARENA_TEST(name, op, expect)						\
+SEC("syscall")									\
+__log_level(2)									\
+expect										\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r1 = %[arena] ll;"							\
+	"r6 = 0;"								\
+	"r6 = addr_space_cast(r6, 0, 1);"					\
+	"r7 = 0;"								\
+"1:	*(u64 *)(r6 + 0) = r7;"							\
+	op									\
+	"r7 += 1;"								\
+	"if r7 < 100 goto 1b;"							\
+	"r0 = 0;"								\
+	"exit;"									\
+	:: __imm_addr(arena) : __clobber_all);					\
+}
+
+#define NOT_UNROLLED100	__msg("loop header at 5, widening r7 to 0..99 step 1")
+/* A loop that moves the pointer is not unrolled */
+ARENA_TEST(arena_pointer_moves, "r6 += 8;", __success NOT_UNROLLED100)
+/* The loop makes a number of it: the state that returns to the loop header tells */
+ARENA_TEST(arena_pointer_becomes_a_number, "if r7 != 5 goto +1; r6 = 4096;",
+	   __failure NOT_UNROLLED100 __msg("R6 invalid mem access 'scalar'"))
+#endif
+
 /*
  * r7 = ctx->data;
  * r8 = r7
-- 
2.55.0

