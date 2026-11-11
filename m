Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415829;
	b=HI8DemdSUQLGMx8bI7QD8JJjQbER1Z9ZxfOUC2BFTAtf1VNG3s7DQ9+5Aeqrd8LYoLT8
	 znzzPs9S7vu6guAJpyD6VN3CHamNynsRT7ViLaihvDpUkZxbI857FWFvh9cGhP8SWYibk
	 FRfT0Cg0n6WkM2zfDFlBizeAV5iLoGdbdZh2PO+AF5mx974V2fE0Mbyia/I3nMtM9xEWh
	 s4kaHpFqz3MRsMg6lrzog/CeQbQXF2UODSbuYbQcCeBce/4m/y2jRWTw0GixSz/88f00r
	 F6ZrF41O1LWpc+6bQjpRtH14NjcO2A7lMMqvjeo6Q6p46NpsEvUJs+Y8ojruJ0mUzUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/lIi5/WPjIRYUf37ZmSX8fO+PfLTJMonmqOWI6gtnPE=;
	b=2DeO4fAqj9cjHkR5tPm9xywhknnG/jiGt1AYiI/d9iNyY8/jiYBviYOGXmqMqYXlTQnt
	 ZRpJCA26ya34qWPnnYXQWE3xvDJsKqAupJR72FItdo4gKfuM4hikKds95OvFeQaDM9s6D
	 IFl7YUaRULKiRYvr7SAXLNOEkMFESWKiXILIjSDzXmNSDa/8+RKqr7FKW4A0Xkb95QjPA
	 solJ1L3j0O6gV5sVrguIRDTFCPmbKCBwoPM5grT7KLGyA2h3U6T9qTSxpTpC9F58sxzsE
	 x0cGnHtB227r+2/eAb/FIPvM/xgPJqNmBAjVHOtKFzQfAsdkOE8x6tJ9SkTVJIRCkjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBdd0Mqp;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46A606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B46A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBdd0Mqp
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso1389715a12.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415829; x=1795020629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lIi5/WPjIRYUf37ZmSX8fO+PfLTJMonmqOWI6gtnPE=;
        b=sBdd0MqpMfqmhXpvIaz5waclTUkiqTzm4VQkBrUN3z0dvDMqcnsAMen4h7TG/P3RZZ
         qCpv5PyjnZSK6scYkW+uI1IeQ0q0yWvxWvAA+rfL8J0KWMi3JKm60AVGi+reocYxsNYh
         XYfquXmWXfLF/Yvklko/m5qye5t70ycGWBumKPt+JZNt4lc3doXT6JHVTkvSwgxA94AU
         j8jxFEaPcUYMJzD7VMfFuOMfZ02OLPaUIA4P0VCaPVcK/hML3DxE2AoeqtbmeUx5gYBE
         IYJ4x5Z2P9J6HX8rdDcBYxA+AUc6Pl3n1cwjfV76euhOCbodNveBhXTPbYksgY4c8NC8
         F9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415829; x=1795020629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lIi5/WPjIRYUf37ZmSX8fO+PfLTJMonmqOWI6gtnPE=;
        b=W/1so7/tA5ZcFqlOMzg0hn1pBqV0G+XGwS+UBKrIaHGN+KimuZnNLD+ZiFcJubgREx
         /NdeqiPlyP0Zy25z8Dey1oekE24UJVoeJY7raAADuIsxleaSdbN6BNb0Fma6g1qzMJeR
         17jvdRteT0ySwhJEUpoVlVJprtn4RoQ3u1X4QLwXVhsCjfCGmmD6iWJYsoNn6r1+lOAy
         c/6qUqV/MOdWsprkFloPcvecjanWJClNTZJl6B7lHt1tkIo+57y6xAlix8JX6BLUPolv
         vD5yAJ2GhtAMxlzm2TRvqpvB9PjDg1CAAMvWPbMnoKoHCRCfKa74Pe+WNbXmEFTqebKm
         Y9Qw==
X-Gm-Message-State: APuU4Z/HbKgYt6sQqT44pQmlhsP1zxIz1Ui2x8ggnzU7SEidDbg4qRkA
	ksD9xEj69Wb+1jIO6wIkSuhc3jjBhnwdjwHgBzLWs7iYMarFO6x1yJugk5tAaA==
X-Gm-Gg: AYBFou1BSb5nYmad9io6o/S4ZvGnCdJGkM/VbX7hvQ3RjQ+DceyIuVBNIvQ0/RMMMqU
	i0QE6UinQdl7hxWI+lHf1ytw1usST1gcyp/D7dg0WLLxVsQxeOFTPqKQEXmfpPQicN3j7Bgm9+T
	hZTEuG7mxvBHB9JE20d12Wq1uAXuJCPnqiOLDkiYT7cgfFvHKH5rEySMiGL5wxQj+UZ/ICkU+kn
	w9Ewg2ld+WhtGdInlPyClGMei83aV8Vz2rR+d58lYU7STNHw2PIZGg1kJM1Oe3ayoSbphRLFV8F
	bUDAs2PtNprf8Z+Rx4aZ/cIMNwp4w0fS58cGsfCL5EPcR7eZlyiUtx0tqgmxBbQSC1H3a/xJX48
	0xUrJFfvZ95Wcdu/deRM34PWHELqjI2vvrcZSu1Ab4N/KIkLU2N4NZwcfJQKezqPeVtVPZnVqdf
	+dLz7DHtMMgT9hBqqcdT5RF81wvIsWpvgVYcQcISCXEppAFOl6Vb31/tOB8IhSmq2935JAUq7ju
	heaBLfMsEt/GAo2laFQZ5FLJ/3mcKf8T7mzPiNAWxKKtQjO1wTZz6/3ojcTzTTgtTZ5zxItX/Oh
	MA39cSjLyazRJsPOWN6953R64dQWOe8r25ayCnmYn3Lw6hDugouOpOmxrJyvbu0nDEyuSEvtAO2
	NKu7b7VoNIysePSfcXPGXicVMc1bL2CPgW+0+L9PcaiDOwTaL2rCT0sNYJuZ/3UG/XzDH2KyCMp
	Q=
X-Received: by 2002:a17:90b:498d:b0:3b0:9882:9e5e with SMTP id 98e67ed59e1d1-3b182ec1fa7mr3035881a91.18.1794415828576;
        Wed, 11 Nov 2026 08:50:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8b287sm66513a91.15.2026.11.11.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:50:28 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 6/6] selftests/bpf: Test the backedge-taken count on struct scalar
Date: Wed, 11 Nov 2026 16:49:49 +0000
Message-ID: <20261111164950.2674588-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
References: <20261111164950.2674588-1-alexei.starovoitov@gmail.com>
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

37 tests in verifier_scev.c.

A count or a range that is new: post32_ge_away, range32_ge_away,
post32_jump_wide, post32_zext_gt_wide, range_post_lt_crosses_0,
range_lt_near_max, range_lt_dir_any_first, ptr_const_crosses_fp.

No count: post32_ge_away_miss, range_lt_near_max_wrap, range32_ge_min,
range32_le_max, range32_zext_sgt_neg, range32_zext_slt_wide,
range_ne_step2_bounds, backedges_away_then_again. range_first_after_bound,
range32_zext_slt_bit31 and backedges_low32_and_64 fail if the count or the
range is too small.

zext32_copy_*: a 32-bit latch tests a zero-extended copy of a 64-bit
induction variable. An access that takes the range of the copy for the
range of the variable is rejected. zext32_iv_below_0 is the same loop with
a 32-bit induction variable.

The step divides the distance: range_ne_mul24, range32_ne_mul24,
ptr_ne_mul21, range_ne_align8, range_ne_shl1_down. It does not, or nothing
says so: range_ne_mul12, range_ne_first_mul12, range32_ne_mul24_wide,
range_ne_mul3_plus_range, range_ne_mul3_crosses_s64. range_lt_overshoot,
range_lt_overshoot_crosses_0 and range_ne_first_mul24 pin the value that
ends a '<' loop and the step of the induction variable.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index b1fede94edd8..f7ed39d4b186 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -1061,6 +1061,15 @@ POST_COND_TEST32(post32_ne_to_0,    "!=",                   -4,    1,
 POST_COND_TEST32(post32_ne_to_m1_2, "!=",                    3,  -2u,               -1, "header_count is [0..2] ")
 POST_COND_TEST32(post32_ne_miss,    "!=",                    4,  -2u,               -1, "can't compute iterations count")
 POST_COND_TEST32(post32_ne_around,  "!=",                    4,    1,                1, "header_count is [0..4294967293] ")
+/* The variable moves away from the bound and wraps: -6, -4, -2, 0. From -7 it steps over 0. */
+POST_COND_TEST32(post32_ge_away,    ">=",                   -8,    2,                5, "header_count is [0..4] ")
+POST_COND_TEST32(post32_ge_away_miss, ">=",                 -7,    2,                1, "can't compute iterations count")
+/* Only the jump has 32 bits. The upper half of r6 does not count. */
+COND_TEST(post32_jump_wide, 1ULL << 32, 1, 5, "header_count is [0..5] ",
+	  "1: r8 = %[step] ll;" LIMIT_ITERATIONS "r6 += r8; if w6 < w7 goto 1b;")
+/* Only the addition has 32 bits. No zero-extended number is above -42. */
+COND_TEST(post32_zext_gt_wide, 14, -7, -42, "header_count is [0..1] ",
+	  "1: r8 = %[step] ll;" LIMIT_ITERATIONS "w6 += w8; if r6 > r7 goto 1b;")
 
 /* An exit exactly at S32_MAX is accepted as well. */
 POST_COND_TEST32(post32_slt_max,   "s<",        INT32_MAX - 6,    2,        INT32_MAX, "header_count is [0..3] ")
@@ -1153,6 +1162,11 @@ RANGE_TEST(range32_slt,    "s", -5,  5,     2,   7,  9,  POST("w6 += w8", "w6 s<
 /* Only the jump has 32 bits. It bounds the low half of r6, 'first + step * count' the rest. */
 RANGE_TEST(range32_jump,    "",  3, 10,     2,  13, 15,  POST("r6 += r8", "w6 < w7"),
 	   COUNTED(6, "3..14"))
+/* 'first + step' is -1..0 + 1: a range that crosses 0 is a range */
+RANGE_TEST(range_post_lt_crosses_0, "s", -1, 0, 1,   5,  5,  POST("r6 += r8", "r6 < r7"),
+	   COUNTED(6, "-1..4"))
+/* First values for which the latch is false at once are seen at the header too */
+RANGE_TEST(range_first_after_bound, "", 0, 100, 1,   5,  5,  PRE(">="),   COUNTED(6, "0..100"))
 
 #define COUNTED_2G(range)									\
 	__msg("loop header at {{[0-9]+}}, header_count is [0..2147483{{[0-9]+}}] ")		\
@@ -1181,6 +1195,13 @@ RANGE_TEST(range_lt_wrap,   "", M64 - 9, M64 - 5,  2, M64 - 3, M64,      PRE(">=
 RANGE_TEST(range_le_wrap,   "", M64 - 9, M64 - 5,  2, M64 - 3, M64 - 1,  PRE(">"),  NO_COUNT)
 RANGE_TEST(range_gt_wrap,   "",       5,       9, -2,       0,       3,  PRE("<="), NO_COUNT)
 RANGE_TEST(range_ge_wrap,   "",       5,       9, -2,       1,       3,  PRE("<"),  NO_COUNT)
+/*
+ * It is less than a step after the bound. How far depends on the first value:
+ * M-26, M-25, M-24 end at M-2, M-1, M. M-23 wraps.
+ */
+RANGE_TEST(range_lt_near_max,      "", M64 - 26, M64 - 24, 8, M64 - 2, M64 - 2, PRE(">="),
+	   COUNTED(4, "-27..-1"))
+RANGE_TEST(range_lt_near_max_wrap, "", M64 - 26, M64 - 23, 8, M64 - 2, M64 - 2, PRE(">="), NO_COUNT)
 /* a 32-bit addition wraps around at 2^32, also under a 64-bit jump */
 RANGE_TEST(range32_add_wrap, "", M32 - 9, M32 - 5, 2, M32 - 3, M32,
 	   POST("w6 += w8", "r6 < r7"), NO_COUNT)
@@ -1192,12 +1213,73 @@ RANGE_TEST(range32_first_is_wide, "", 0, M32 + 9,  2,      15,      20,
 /* An unsigned counter goes down and leaves the range below 0. */
 RANGE_TEST(range_lt_dir,    "",  3, 10,    -2,  15, 20,  PRE(">="),   COUNTED(7, "-2..10"))
 RANGE_TEST(range_le_dir,    "",  3, 10,    -2,  15, 20,  PRE(">"),    COUNTED(7, "-2..10"))
+/* 'for (i = n; i < 6; i--)': whatever n is */
+RANGE_TEST(range_lt_dir_any_first, "", 0, M64, -1, 6, 6, PRE(">="),
+	   __retval(1) __msg("header_count is [0..7] "))
+/* Up from 100 while it is '>= 100..103', until it wraps to 84: the smallest bound has the count */
+RANGE_TEST(range32_ge_away, "", 100, 100, 0x0fffffff, 100, 103,
+	   LOOP_HEAD "if w6 < w7 goto 2f; w6 += w8; goto 1b;", __msg("header_count is [0..17] "))
+/* '>= 0' is always true, and so is '<= -1': -4..3 crosses 0 */
+RANGE_TEST(range32_ge_min,  "",  5,  5,     1,   0,  3,  POST("w6 += w8", "w6 >= w7"), NO_COUNT)
+RANGE_TEST(range32_le_max, "s",  0,  0,     2,  -4,  3,  POST("w6 += w8", "w6 <= w7"), NO_COUNT)
+/*
+ * A 64-bit jump tests a zero-extended variable: 's>' a negative bound and 's<' a bound above
+ * U32_MAX are always true. Else it is an unsigned 32-bit jump: 0x7ffffff1 .. 0x80000010.
+ */
+RANGE_TEST(range32_zext_sgt_neg, "s", 100, 100, -1, -3, 4, POST("w6 += w8", "r6 s> r7"), NO_COUNT)
+RANGE_TEST(range32_zext_slt_wide, "", M32 - 15, M32 - 15, 1, M32 - 5, M32 + 2,
+	   POST("w6 += w8", "r6 s< r7"), NO_COUNT)
+RANGE_TEST(range32_zext_slt_bit31, "", M32 / 2 - 15, M32 / 2 - 15, 1, M32 / 2 + 17, M32 / 2 + 17,
+	   POST("w6 += w8", "r6 s< r7"), __msg("header_count is [0..32] "))
 /* The counter moves away from the exit. */
 RANGE_TEST(range_gt_dir,    "", 10, 20,     2,   3,  5,  PRE("<="),   NO_COUNT)
 RANGE_TEST(range_ge_dir,    "", 10, 20,     2,   3,  5,  PRE("<"),    NO_COUNT)
 /* '!=' can step over the bound, or start behind it. */
 RANGE_TEST(range_ne_step2,  "",  0,  3,     2,   3,  8,  PRE("=="),   NO_COUNT)
+RANGE_TEST(range_ne_step2_bounds, "", 0, 0, 2,   9, 10,  PRE("=="),   NO_COUNT)
 RANGE_TEST(range_ne_behind, "",  0,  4,     1,   3,  8,  PRE("=="),   NO_COUNT)
+/*
+ * It does not step over the bound if the step divides the distance: initial value and bound are
+ * congruent modulo the step. 'n * 24' is a multiple of 24. 8 divides the largest 'n * 12', 48,
+ * and is less than 12, but steps over 12.
+ */
+RANGE_TEST(range_ne_mul24,  "",  0,  0,    24,   0,  5,  "r7 *= 24;" PRE("=="),
+	   COUNTED(6, "0..120"))
+RANGE_TEST(range_ne_mul12,  "",  0,  0,     8,   0,  4,  "r7 *= 12;" PRE("=="),   NO_COUNT)
+RANGE_TEST(range_ne_first_mul12, "", 0, 4,  8,  96, 96,  "r6 *= 12;" PRE("=="),   NO_COUNT)
+/* The sum of a multiple of 3 and 0..1 is no multiple of 3 */
+RANGE_TEST(range_ne_mul3_plus_range, "", 0, 3, 3, 0,  1,  "r6 *= 3; r6 += r7; r7 = 12;" PRE("=="),
+	   NO_COUNT)
+/* S64_MAX - 9 + 3k and S64_MIN + 3k are 1 modulo 3. On the circle S64_MAX + 3 is S64_MIN + 2. */
+RANGE_TEST(range_ne_mul3_crosses_s64, "", 0, 3, 3, 0, 1,
+	   "r6 *= 3; if r7 == 0 goto 3f; r1 = 0x7ffffffffffffff6 ll; r6 += r1; goto 4f;"
+	   "3: r1 = 0x8000000000000000 ll; r6 += r1; 4: r7 = 0x800000000000000b ll;" PRE("=="),
+	   NO_COUNT)
+/* 'while (i-- > 0) sum += a[i];' of u16 a[]: the compiler counts 2 * i down to 0 */
+RANGE_TEST(range_ne_shl1_down, "", 1, 5,   -2,   0,  0,  "r6 <<= 1;" POST("r6 += r8", "r6 != r7"),
+	   COUNTED(5, "2..10"))
+/* 20 modulo 24 plus multiples of 8: the induction variable is 4 modulo gcd(24, 8) */
+RANGE_TEST(range_ne_first_mul24, "", 1, 2,  8,  84, 84,  "r6 *= 24; r6 += 20;" PRE("=="),
+	   __retval(6) __msg("header_count is [0..6] ") __msg("widening r6 to 44..84 step 8")
+	   __msg("step=4+8"))
+/* 9, 17, 25 go to 41: each overshoots 40 by 1, not by up to 7. At the header it is 8 less. */
+RANGE_TEST(range_lt_overshoot, "", 0, 2,    8,  40, 40,
+	   "r6 *= 8; r6 += 1;" POST("r6 += r8", "r6 < r7"), COUNTED(5, "1..33"))
+/* -5, -2, 1, 4 cross 0, where the order of '<' begins: 0 is none of them. 1 goes to 22. */
+RANGE_TEST(range_lt_overshoot_crosses_0, "", 0, 3, 3, 20, 20, "r6 *= 3; r6 += -5;" PRE(">="),
+	   __retval(1) __msg("header_count is [0..8] ") __msg("widening r6 to -5..22 "))
+/* Known low bits are a congruence too: 1..40 with three zero bits is 8..40 */
+RANGE_TEST(range_ne_align8, "",  0,  0,     8,   1, 43,
+	   "r7 &= -8; if r7 == 0 goto 2f;" PRE("=="), COUNTED(6, "0..40"))
+/*
+ * The low 32 bits of a multiple of 24 are one as long as it fits in 32 bits.
+ * 24 * 0xaaaaaac is 0x100000020.
+ */
+RANGE_TEST(range32_ne_mul24, "", 0,  0,    24,   1,  5,
+	   "r7 *= 24;" POST("w6 += w8", "w6 != w7"), COUNTED(5, "0..96"))
+RANGE_TEST(range32_ne_mul24_wide, "", 0, 0, 24,  1, 1ULL << 30,
+	   "r7 *= 24; if w7 > 96 goto 2f; if w7 < 24 goto 2f;" POST("w6 += w8", "w6 != w7"),
+	   NO_COUNT)
 
 /*
  *    char buf[8];
@@ -1243,6 +1325,38 @@ SEXT32_TEST(sext32_iv_unsigned_bound, 0,
 	    "1:" SEXT32_INC "if w1 < w4 goto 1b; if r6 s>= 0 goto 2f; r0 = *(u64 *)(r5 + 0);",
 	    __msg("widening r6 to " ALL_OF_S32) OOB)
 
+/*
+ *    for (long i = first; (u32)i < 128; i -= 1000)
+ *
+ * r6 is a 64-bit induction variable, the latch tests a zero-extended copy of it. It has the SCEV
+ * of a 32-bit induction variable, and it bounds the low 32 bits of r6 only.
+ */
+#define IV64_TEST(name, first, loop, expect)	SEXT32_TEST(name, first, loop, expect)
+#define HI32_IS_0	"r4 = r6; r4 >>= 32; if r4 == 0 goto +1; r0 = *(u64 *)(r5 + 0);"
+#define ZEXT32_COPY	"w3 = w6;"
+/* r6 is 0..3, then -1000..-997 */
+IV64_TEST(zext32_copy_below_0, 0,
+	  "r8 &= 3; r6 += r8; 1: if r6 <= 3 goto +1; r0 = *(u64 *)(r5 + 0);"
+	  ZEXT32_COPY "if r3 >= 128 goto 2f; r6 += -1000; goto 1b;",
+	  __msg("header_count is [0..2] ") __msg("widening r6 to -1000..3 ") OOB)
+/* A 32-bit induction variable is 0xfffffc18..0xfffffc1b then */
+IV64_TEST(zext32_iv_below_0, 0,
+	  "r8 &= 3; r6 += r8; 1:" HI32_IS_0
+	  ZEXT32_COPY "if r3 >= 128 goto 2f; w6 += -1000; goto 1b;",
+	  __success __retval(0) __msg("header_count is [0..2] "))
+/* r6 gets to 0x100000009 */
+IV64_TEST(zext32_copy_above_u32_max, 0xfffffff0ULL,
+	  "r8 &= 15; r6 += r8; 1:" HI32_IS_0 "r6 += 1;" ZEXT32_COPY "if r3 < 10 goto 1b;",
+	  __msg("header_count is [0..11] ") __msg("widening r6 to 0xfffffff0..0x100000009 ") OOB)
+IV64_TEST(zext32_copy_above_u32_max_const, 0xfffffffeULL,
+	  "1:" HI32_IS_0 "r6 += 1;" ZEXT32_COPY "if r3 != 3 goto 1b;",
+	  __msg("header_count is 5 ") __msg("widening r6 to 0xfffffffe..0x100000002 ") OOB)
+/* The latch sees the low 32 bits of the step */
+IV64_TEST(zext32_copy_wide_step, 0,
+	  "r8 &= 1; r6 += r8; 1: if r6 <= 10 goto +1; r0 = *(u64 *)(r5 + 0);"
+	  "r1 = 0x100000001 ll; r6 += r1;" ZEXT32_COPY "if r3 < 10 goto 1b;",
+	  __msg("header_count is [0..10] ") OOB)
+
 /*
  * Two back edges:
  *
@@ -1283,6 +1397,17 @@ RANGE_TEST(backedges_wrap_then_end, "", 39, 39, 1, 0, 1,
 /* The same upwards. The largest first value wraps around first. */
 RANGE_TEST(backedges_wrap_up_then_end, "", M32 - 55, M32 - 39, 1, 0, 1,
 	   AND_R8("w6 += 8", 5, "w6 < -16"), AGAIN(4))
+/*
+ * w6 moves away from the bound: 'w6 < 0x38000000' is false in iterations 3..14, and true again in
+ * iteration 15, in which '!=' is false.
+ */
+RANGE_TEST(backedges_away_then_again, "", 0x30000000, 0x30000000, 1, 0, 1,
+	   BACKEDGES("w5 = -0x10000000; w6 += w5", "r7 == 0",
+		     "w6 < 0x38000000", "w6 != 0x30000000"), AGAIN(15))
+/* One latch bounds the low half of r6, the other r6: together they bound neither */
+RANGE_TEST(backedges_low32_and_64, "", 0, 3, 1, 0, 1,
+	   BACKEDGES("r6 += 1", "r7 == 0", "w6 < 5", "r6 < 7"),
+	   __retval(5) __msg("header_count is [0..7] ") __msg("widening r6 to 0..9 "))
 /* It's base + offset that wraps around when the variable is a pointer */
 RANGE_TEST(backedges_pointer_wraps, "", 0, 0, 1, 0, 1, "r4 = r10; r4 += -8; r5 = r10; r5 += -512;"
 	   AND_R8("r5 += 8", 100000000, "r5 < r4"), AGAIN(99999999))
@@ -4146,6 +4271,12 @@ PTR_RANGE_TEST(ptr_first_is_below_or_at_fp, "r0 &= 63;", "r6", 1, "<=", "r7",
 	       __msg("loop header at {{[0-9]+}}, header_count is [0..64] "))
 PTR_RANGE_TEST(ptr_first_offset_is_wide, "r0 >>= 2;", "r6", 1, "<", "r7", NO_COUNT)
 PTR_RANGE_TEST(ptr_bound_offset_is_wide, "r0 >>= 2;", "r7", -1, ">", "r6", NO_COUNT)
+/* Constants: the offset goes from -55 to 1, across 0 */
+PTR_RANGE_TEST(ptr_const_crosses_fp, "r0 = 0;", "r6", 8, "<", "r7",
+	       __msg("loop header at {{[0-9]+}}, header_count is [0..8] "))
+/* 'for (p = buf; p != end; p += 21)': fp-63 and fp-42 get to fp */
+PTR_RANGE_TEST(ptr_ne_mul21, "r0 &= 1; r0 *= 21;", "r6", 21, "!=", "r7",
+	       __msg("loop header at {{[0-9]+}}, header_count is [0..3] "))
 
 SEC("xdp")
 __success
-- 
2.55.0

