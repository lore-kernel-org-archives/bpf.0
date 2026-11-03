Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749368;
	b=YwWeXOKaW1vMOxgT0/Vkz7SUP6f23TOh4qXbxIC7TsNT8G1M5IuBEv/1QLAtpxitXHJL
	 TaN8nIIC2awVK3SppHEM2D27m4TsLa2V/0Mapxb+q2RFna/uevUHGM/uSOg5q2E5NQ021
	 MNgFVu+HH2E+3Spm0YUfEDiv+qQGK91FUQ4bPjE7cpHW4CDOBEvBNIeXHnAMUyvFML8m8
	 TPBSDmEWEr2WOfoGdlrf71j2yIQkHAduZQh6egT/4yON/3DFeFpyOjkn7o92E69HOkCyk
	 zvsjFQLfnFmP/WVsblqWLHuTBD8A57+BsWctoat1Mtu0v85OPfGSt+KwLmPGzEGM7xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=gNlq/V39/C+4qgMUJUbXLU8qWLIe5rWHnMcnRKIEei0=;
	b=CX+PJefM+h2SC1Uu1A7W65RVM3NHWQqpj4PIK5wVDQ33nMfG1KCF8NaMdnRxMfW9oygG
	 yw/kpBW4HqTfVrKC9XGppT6Bzj7I2z6ZgGAmYxgMgIauhPQp4Sjj7tQ3qClyaD7BkCu2x
	 Wzg7+SvmKvA8pXayKvFO2Zn6TFspjGmpCipPBOyDnv/MGS1NOek8vxJx5KgeXO9pVXlEW
	 EBrhyjOzveWbclX+1IuImW5e3ZRf+V3yNtuC5dcK9sQwD1VwCmgPixjbjjjW02xQ4LrfT
	 gfO67urOdg8hdb6CDetxx0v5JZ3/ZbVBQ3JfytTFET8+DoaA9LvTHABh1HNVSXKfYXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ePGmAHRA;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB3606A32F
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FDB3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ePGmAHRA
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so78545a91.3
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749367; x=1794354167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gNlq/V39/C+4qgMUJUbXLU8qWLIe5rWHnMcnRKIEei0=;
        b=ePGmAHRAQBmRJRSSYP312OWZ2X0JStLrqTrMrcd0nzxv0MRgycBbpurx/MBKHQ5lxv
         KgU8xnPtP1U8lMTAvZjxqlpAIMDeFvVQGJKeUzt8EEWvSBKVva9Dv4rl2HFBrIFlU3Bc
         RAXCUwiQ/wHFeoRj9AAP0/M59PFTrjtcR+aP4oDnLE+yF4723I/TzpqXqsRSoEKU/SiC
         hD0FvZnuTEzHJXxXCS0xSOUQGNpj6WfPrgOwFS1D6D+i9qY06JuYM1KJBIU5L7lT2ecr
         m7Pqp5QF0HoixubSyUz8djxt7a/IWT7LPq48/puLoc6XJeF1th5FGSIFpNlT1euYKhbW
         sV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749367; x=1794354167;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNlq/V39/C+4qgMUJUbXLU8qWLIe5rWHnMcnRKIEei0=;
        b=AvL7ykPVaFruvImKieY5nJ18CbI6cZ5wXyI9bnr63h5AyBwd2DQGN5EAkqbRDMr9k9
         1cWuhjsGUbLDoeRSEvi74vy2hcM1BQ6qo0Cpgrb/P0mA7WQoa9xkoVTm9zyL43Lgiz9x
         IGIICUbJ/E8Wv89Q6vIO1tBj/rN9eia5+NQEJicZOjf/QrmpKb1nFe43vdGOg0CQ+NQR
         qzCbhym2KnEBCmjKmDYbPK5rlM0VD6xziWWI364o0xQn7Rb8SXoMpB6JaQ+6osWbQcF4
         lXwGlcLrjibcF20suksZr1MAIZO0RwuWb4SaR2SyWORm070cgK/ho/02GPFDPxx/pDD2
         kdsg==
X-Gm-Message-State: APuU4Z9CYUtr0A+697+jGQ7/0TMSL+DKSAI7sDfjqbGCf0KBnNTV2Fvx
	eZNIPcK+88+eyHXB5Bz0fHZZKOdkFI+8kHJAsga9EvtcfejF2Qz1MtdjNv4VOw==
X-Gm-Gg: AYBFou34hwNEp8iiSA90MeUTbTbBGJfZPHbBFZqRrNHT6X+OYmIVhGasRv6bH9InRM+
	fcxL/mPbKoeNife7375K6jG1TGpkqiGFkfKq8TWEnhJI3BGDi7xZjG8QYiWWPWYhnWBLBQV+I4T
	9gyMyN3Ujlg3DR7gBkCGDr8j5kt3B4bcxqVb6aQeVFiOmbgo0H33qZ81Dl7hxPXLJ6iZKuvXq2k
	nUkfLEUlF815Mie4MpqqlsjrHoLry+hokfzeQyM+8OV9YBmolgd5bYwCbCEywzHQZrYTe0fH9MG
	nTmmX8CZpjpnrkX5DQGh29qPiGPDapnU/5N80ZwhWvXCX1zksURhFyL2ZqTDrkAjppC6c1weNz7
	cGrUhssO5RJVyvndbrkHQvU9Bq80HHAmkL9xNh+jp9WibTqqt4J1ZqBCchCW7QUF1sUHSa9I+EN
	KjahsTSq6KuWRgt4LN957hCNpJuSxPyE95Yf1/WzYEF2e92XPdQ5ljUwvLVpBfpPmENzDiJkQEo
	LQMfXM6oMJsyDpwnnwMjU01Zg/fDaSc+mJoXZaYaT0Bfc5LqLhQCbqi3ZRHwQ5F/ekn2aUthnIn
	nE413co2lbSq3tX8NK7v0WMBav71bBLg52NAauo+tkP9Aink7S8Tw+pdLDvExFWu95HQGFZceVq
	2XRgYX0Ax4A93b4l08Jt4kTPpuwlVvrTC9U3rKhA2OXuHYP0y70TT+po98OAC1iPKS0LSZfwuZU
	8=
X-Received: by 2002:a17:90b:5886:b0:3a8:a98c:ea07 with SMTP id 98e67ed59e1d1-3ae896f8551mr10964708a91.13.1793749367205;
        Tue, 03 Nov 2026 15:42:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0993fb8a8sm124029a91.4.2026.11.03.15.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:42:46 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 17/37] selftests/bpf: Test loops whose first value or bound is a range
Date: Tue,  3 Nov 2026 23:40:42 +0000
Message-ID: <20261103234104.208239-18-alexei.starovoitov@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

RANGE_TEST() makes a loop from a first value, a step and a bound. An atomic
add hides the first value and the bound from the verifier. Jumps put them
into ranges.

 - 11 progs with a count: each kind of comparison, the jump before and
   after the addition, 64 and 32 bits. Each prog runs with the two values
   that are the furthest apart and returns how many times it was at the
   loop head. This number must be the upper bound that the verifier
   calculates. The tests also expect the range of the variable at the loop
   head, at the entry and at the back edge.
 - A loop with up to 2^31 iterations, which is too long to unroll.
 - 3 progs where 'first value + step' wraps around for a part of the range.
 - 13 progs without a count: the value that ends the loop can wrap around,
   the variable moves away from the bound, '!=' can step over the bound or
   start behind it, a 32-bit variable enters the loop with more than 32
   bits.
 - 3 progs compare pointers to the stack. fp-1 is below fp+0, but -1 is the
   largest offset as an unsigned number. A pointer that has an offset of up
   to 2^62, as the first value or as the bound, gives no count.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 6b39c76fd37e..6777d545ec1d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1012,6 +1012,131 @@ POST_COND_TEST32(post32_slt_wrap,  "s<",        INT32_MAX - 3,    2,        INT3
 POST_COND_TEST32(post32_sgt_wrap,  "s>", (__u32)INT32_MIN + 3,  -2u, (__u32)INT32_MIN, "can't compute iterations count")
 POST_COND_TEST32(post32_lt_wrap,   "<",                    -4,    2,               -1, "can't compute iterations count")
 
+/*
+ * The first value of the counter or the bound of the loop is a range: the verifier sees only the
+ * jumps that put r6 into [first_min, first_max] and r7 into [bound_min, bound_max]. An atomic add
+ * hides what they are at run time: the two values that are the furthest apart.
+ * r9 counts how many times the header is executed, and ends the loops that have no count.
+ */
+#define RANGE_TEST(name, sign, first_min, first_max, _step, bound_min, bound_max, loop, expect)	\
+SEC("socket")											\
+__success __log_level(2)									\
+expect												\
+__naked void name(void)										\
+{												\
+	asm volatile (										\
+		"r1 = %[first] ll;"								\
+		"*(u64 *)(r10 - 8) = 0;"							\
+		"lock *(u64 *)(r10 - 8) += r1;"							\
+		"r6 = *(u64 *)(r10 - 8);"							\
+		"r1 = %[bound] ll;"								\
+		"*(u64 *)(r10 - 8) = 0;"							\
+		"lock *(u64 *)(r10 - 8) += r1;"							\
+		"r7 = *(u64 *)(r10 - 8);"							\
+		"r9 = 0;"									\
+		"r1 = %[fmin] ll; if r6 " sign "< r1 goto 2f;"					\
+		"r1 = %[fmax] ll; if r6 " sign "> r1 goto 2f;"					\
+		"r1 = %[bmin] ll; if r7 " sign "< r1 goto 2f;"					\
+		"r1 = %[bmax] ll; if r7 " sign "> r1 goto 2f;"					\
+		loop										\
+		"2: r0 = r9;"									\
+		"exit;"										\
+		:										\
+		: __imm_const(first, (__s64)(_step) > 0 ? first_min : first_max),		\
+		  __imm_const(bound, (__s64)(_step) > 0 ? bound_max : bound_min),		\
+		  __imm_const(fmin, first_min), __imm_const(fmax, first_max),			\
+		  __imm_const(bmin, bound_min), __imm_const(bmax, bound_max),			\
+		  __imm_const(step, _step)							\
+		: __clobber_all);								\
+}
+
+#define LOOP_HEAD	"1: r8 = %[step] ll;" LIMIT_ITERATIONS
+#define PRE(exit_op)	LOOP_HEAD "if r6 " exit_op " r7 goto 2f; r6 += r8; goto 1b;"
+#define POST(add, jump)	LOOP_HEAD add "; if " jump " goto 1b;"
+
+/* 'count' is what the verifier has and what r9 is at run time. 'range' is r6 at the header. */
+#define COUNTED(count, range)									\
+	__retval(count)										\
+	__msg("loop header at {{[0-9]+}}, header_count is [0.." #count "] ")			\
+	__msg("loop header at {{[0-9]+}}, widening r6 to " range " ")				\
+	__msg("loop header at {{[0-9]+}}, clamping r6 to " range " ")
+#define NO_COUNT										\
+	__msg("loop header at {{[0-9]+}}, can't compute iterations count")			\
+	__not_msg("header_count is")
+
+#define M64 ITER_U64_MAX
+#define M32 ITER_U32_MAX
+/*
+ * Example: range_lt
+ *
+ *    u64 r6 = 1..4, r7 = 8..12;
+ *    while (r6 < r7)                // r6 ∈ [1,3,...,11,13]
+ *        r6 += 2;
+ */
+/*         name           sign  first     step   bound   loop         expected */
+RANGE_TEST(range_lt,        "",  1,  4,     2,   8, 12,  PRE(">="),   COUNTED(7, "1..13"))
+RANGE_TEST(range_le,        "",  0,  2,     2,   6,  9,  PRE(">"),    COUNTED(6, "0..11"))
+RANGE_TEST(range_gt,        "", 10, 14,    -2,   3,  5,  PRE("<="),   COUNTED(7, "2..14"))
+RANGE_TEST(range_ge,        "", 10, 14,    -2,   4,  5,  PRE("<"),    COUNTED(7, "2..14"))
+RANGE_TEST(range_slt,      "s", -5,  5,     2,   5,  7,  PRE("s>="),  COUNTED(7, "-5..8"))
+RANGE_TEST(range_ne_up,     "",  0,  3,     1,   3,  6,  PRE("=="),   COUNTED(7, "0..6"))
+RANGE_TEST(range_ne_down,   "",  8, 10,    -1,   4,  8,  PRE("=="),   COUNTED(7, "4..10"))
+/* the order of unsigned numbers says nothing about -1..3, the order of signed numbers does */
+RANGE_TEST(range_ne_signed, "s", -3, -1,    1,  -1,  3,  PRE("=="),   COUNTED(7, "-3..3"))
+/* The jump tests r6 after the addition. At the header r6 is a step behind. */
+RANGE_TEST(range_post_lt,   "",  3, 10,     2,  14, 15,  POST("r6 += r8", "r6 < r7"),
+	   COUNTED(6, "3..14"))
+/* 32 bits. r6 is negative at the entry and zero extended after that. */
+RANGE_TEST(range32_slt,    "s", -5,  5,     2,   7,  9,  POST("w6 += w8", "w6 s< w7"),
+	   COUNTED(7, "-5..0xffffffff"))
+/* Only the jump has 32 bits. The low half says nothing about r6: it's 'first + step * count'. */
+RANGE_TEST(range32_jump,    "",  3, 10,     2,  13, 15,  POST("r6 += r8", "w6 < w7"),
+	   COUNTED(6, "3..20"))
+
+#define COUNTED_2G(range)									\
+	__msg("loop header at {{[0-9]+}}, header_count is [0..2147483{{[0-9]+}}] ")		\
+	__msg("loop header at {{[0-9]+}}, widening r6 to " range " ")
+/* Too long to unroll: only the count ends the loop for the verifier */
+RANGE_TEST(range_long,      "",  0,  0,     1,   0, 0x7fffffff,
+	   "1: r8 = %[step] ll; if r6 >= r7 goto 2f; r6 += r8; goto 1b;", COUNTED_2G("0..0x7fffffff"))
+/* 'first + step' wraps around for a part of the range: the loop starts anywhere */
+RANGE_TEST(range_first_wraps_s64, "s", ITER_S64_MAX - 5, ITER_S64_MAX - 1, 2,
+	   ITER_S64_MAX - 1, ITER_S64_MAX - 1, POST("r6 += r8", "r6 s< r7"), NO_COUNT)
+RANGE_TEST(range_first_wraps_u32, "", 0, 3, -2, 5, 5, POST("w6 += w8", "w6 > w7"),
+	   COUNTED_2G("0..0xffffffff"))
+RANGE_TEST(range_first_wraps_s32, "", INT32_MAX - 5, INT32_MAX - 1, 2, INT32_MAX - 1, INT32_MAX - 1,
+	   POST("w6 += w8", "w6 s< w7"), COUNTED_2G("0..0xffffffff"))
+
+/*
+ * The value that ends the loop can wrap around.
+ *
+ * Example: range_lt_wrap
+ *
+ *    u64 M = U64_MAX, r6 = M-9..M-5, r7 = M-3..M;
+ *    while (r6 < r7)                // M-1 < M, and the next value is 1
+ *        r6 += 2;
+ */
+RANGE_TEST(range_lt_wrap,   "", M64 - 9, M64 - 5,  2, M64 - 3, M64,      PRE(">="), NO_COUNT)
+RANGE_TEST(range_le_wrap,   "", M64 - 9, M64 - 5,  2, M64 - 3, M64 - 1,  PRE(">"),  NO_COUNT)
+RANGE_TEST(range_gt_wrap,   "",       5,       9, -2,       0,       3,  PRE("<="), NO_COUNT)
+RANGE_TEST(range_ge_wrap,   "",       5,       9, -2,       1,       3,  PRE("<"),  NO_COUNT)
+/* a 32-bit addition wraps around at 2^32, also under a 64-bit jump */
+RANGE_TEST(range32_add_wrap, "", M32 - 9, M32 - 5, 2, M32 - 3, M32,
+	   POST("w6 += w8", "r6 < r7"), NO_COUNT)
+RANGE_TEST(range32_ne_far,  "", M32 - 5, M32 - 3,  1, M32 - 1, M32 + 3,
+	   POST("w6 += w8", "r6 != r7"), NO_COUNT)
+/* the first jump tests what enters the loop, and that is not zero extended */
+RANGE_TEST(range32_first_is_wide, "", 0, M32 + 9,  2,      15,      20,
+	   LOOP_HEAD "if r6 >= r7 goto 2f; w6 += w8; goto 1b;", NO_COUNT)
+/* The counter moves away from the exit. */
+RANGE_TEST(range_lt_dir,    "",  3, 10,    -2,  15, 20,  PRE(">="),   NO_COUNT)
+RANGE_TEST(range_le_dir,    "",  3, 10,    -2,  15, 20,  PRE(">"),    NO_COUNT)
+RANGE_TEST(range_gt_dir,    "", 10, 20,     2,   3,  5,  PRE("<="),   NO_COUNT)
+RANGE_TEST(range_ge_dir,    "", 10, 20,     2,   3,  5,  PRE("<"),    NO_COUNT)
+/* '!=' can step over the bound, or start behind it. */
+RANGE_TEST(range_ne_step2,  "",  0,  3,     2,   3,  8,  PRE("=="),   NO_COUNT)
+RANGE_TEST(range_ne_behind, "",  0,  4,     1,   3,  8,  PRE("=="),   NO_COUNT)
+
 SEC("xdp")
 __success
 __log_level(2)
@@ -3360,6 +3485,38 @@ __naked void ptr_stack_other_frame(void)
 "	::: __clobber_all);
 }
 
+/*
+ * r6 is fp-63 + r0. The jump compares addresses. fp-1 is below fp+0: they have the order of signed
+ * offsets, as long as base + offset does not wrap around. Nothing limits the offset of a pointer
+ * that is compared only: fp-63 + 0..2^62 can be a small address.
+ */
+#define PTR_RANGE_TEST(name, offset, first, step, op, bound, expect)		\
+SEC("socket")									\
+__success __log_level(2)							\
+expect										\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"call %[bpf_get_prandom_u32];"						\
+	offset									\
+	"r6 = r10;"								\
+	"r6 += -63;"								\
+	"r6 += r0;"								\
+	"r7 = r10;"								\
+	"r9 = 0;"								\
+"1:"	LIMIT_ITERATIONS							\
+	first " += " #step ";"							\
+	"if " first " " op " " bound " goto 1b;"				\
+"2:	r0 = 0;"								\
+	"exit;"									\
+	:: __imm(bpf_get_prandom_u32) : __clobber_all);				\
+}
+
+PTR_RANGE_TEST(ptr_first_is_below_or_at_fp, "r0 &= 63;", "r6", 1, "<=", "r7",
+	       __msg("loop header at {{[0-9]+}}, header_count is [0..64] "))
+PTR_RANGE_TEST(ptr_first_offset_is_wide, "r0 >>= 2;", "r6", 1, "<", "r7", NO_COUNT)
+PTR_RANGE_TEST(ptr_bound_offset_is_wide, "r0 >>= 2;", "r7", -1, ">", "r6", NO_COUNT)
+
 SEC("xdp")
 __success
 __log_level(2)
-- 
2.55.0

