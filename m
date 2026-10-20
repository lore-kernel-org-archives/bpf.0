Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494400;
	b=HY5g9jXKbjhhFEE1STBFKyrYZ52IYiliuNv70I26xc0hhNh7A2WKgzrbUOnU4Y5B4UGC
	 ZE2WEE9JkldCFdfkjCFwOSqTwYgQdye0A2h/Zyq85hlUw6nA6JcGiNa1RbuW0QRYJoJH6
	 u80o78uwPWZuo2PMQER3LtlP6hddjAVNTlLwfpuNIFWGaH9VYmM2DggOo+2sVU4pDgfcK
	 EpdpW2W6NJg/2utczaiyVUcGn6ZRkwXYKApAcHa+4KSIs9XaUHchG/0C7YOQ4LfH9wMpO
	 c8hGWHRckNLOHiacz/VKhUHBgREXBbLB7VvkvJHOUlsx+hA+dnfYk9bvVhm9vKwdRYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Pd6gO2BHbD6n5TKNtLjOzWiedlpDV6iAR3MRrGDjk8A=;
	b=lwnMP0jw6dZcMKyi1jvdKaHw6uY5HUsLwdlLqWOUe1nSG6pvbPvgewtCumX312kUvRIO
	 YjjPQc5BwaIZnV5VU8sMWzpLdteeuWvbPu0/ut/wPnOcTAD65zkjB5u9SppVGeM2q6w+9
	 AznZMhl+jbXgff5pyyZrAGtL040c9SXTNael/3/R/Zq9Pwkk+Y6bwYbtH1tYwsmvaYdxl
	 E8z1XIDgC4sh/9WWWw+32Li2XfTqRZsKy3XtO4lkStSJWk6PSA1u2hD7KKRoHCel5LXRQ
	 qEyQziqr1lK8FgdTrAM0lI4ZaHEd6jMfQi/GiFpDTYxJ7PhBrDJhMpH9nrcRfkZWhcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DYq5UDwM;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A7606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB3A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DYq5UDwM
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso1799381a91.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792494399; x=1793099199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pd6gO2BHbD6n5TKNtLjOzWiedlpDV6iAR3MRrGDjk8A=;
        b=DYq5UDwMzQdaaMCC801wgvdS2rBiK9FoWmdvLb5KvE1rVEoieL2ziiSmHTLMUnz550
         suIr1P4vipPXz+kzlupwL17r6R39/ILaZcYIKRcExviEvdo6eFgdd/IqyKjdjYSbbru3
         MRE/3mfvKoJWD3Ri5p65B4WDPczH4E9iwFlD2eR2Cq9ojRIDIwxqh+vWqcf+qt9FescV
         5/lK3ct1SbG+UsWTJUOFCFuaK907BJRRY5INIOFIHdMaHCyBI0vm7buU9YZsxylwwMcd
         aIDmJCQCjC/8oBLdYp9JgKk1B/eyMtbXb+ICGqfdGyPj/W6zZ2VHuuqkEB2q8vvQLF6k
         Kaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494399; x=1793099199;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pd6gO2BHbD6n5TKNtLjOzWiedlpDV6iAR3MRrGDjk8A=;
        b=A8OutLPG2Y1XGTAHHWs05ddhj627Y3mHdxAkr5KBuBKSFDkujci5piVN3itFzS6YKk
         1+5aiNnISGkQew7Js8a4jEkXlJabnPooXjTC1xzP1Bw3qOOOJu/xNUa3ven6EjNf+kKd
         J80RQtFAg6sWACfVsqIoyChbBguKUSs2KTrzW43Sn7n8jNEWexPOBhU54htzhsMVLkgZ
         CoKHkBaLRbgEYS7GOjE9HGfzCEbtG6749uiWJ/quG1n/B5VcfR3GWc6jaLIgVCE3UyYc
         VikYpSTEGLdKd6kGCXblUK7300unS4kb9ah6TXqg4iXpnqdrbFWsKvuuqSSi8t+VJ3Vv
         cGqA==
X-Gm-Message-State: AFq9FYIJ65vEWMv8wzXlgqbxwnSljj3beyBJuH8HOV6S5Bpm1xp1lnov
	gr78rLj84celTBNXUvIjyJ3+i6uq9OVchMlZ4lBd52E5b5BHUD8tXrE5z66qkw==
X-Gm-Gg: AYBFou0+NEWdrYZOdOlndIGW4I32xAczLT6tn1V2ruF1tybAcv0yleucT9HR+HVGHdh
	eT9Trs8FHFUpelus/Rjpb7TW0Qg9ewI4AWxNYBCspiv6GJdFQnxYTNkHjP1Aj/qy0I0FbVtoTJp
	jbXdaGkLLf5HwAN6dGGVNP45aAFRS/O+lTlYwDFFOvPurgRvjS6gR/jcdfdPvcFmaQ4WVRlixz+
	oHBulcAaqjghB+tsOt7pn2CCJF0I3K6XIgCrAuQxq4k6t/LC1s04xj9f7TEK9j52TTBiQc3r+FX
	CexLpILXhJt1b+nPx0wUuzOGesu2AyOsEkMyjpdFsw4gORaxQKiGbMP2U2tGkvo9qrts35ljMjV
	CtyZPBUXrg2K5Wj/5LftzBj05G/oWtUyBHwsS6EulbLDyXz9H4nD5drVwuhOsXF2j4qyhaChzIF
	HJmoPB7NU0wdo5710oc2tJDNOvFw6gK/AUIkhfDe91shXaYpgJXlvdSNRjOZTi1/m/LV0qQo0d8
	ZWOSvVDH3m1OVNy
X-Received: by 2002:a17:90b:3c0e:b0:3ac:1c76:61c3 with SMTP id 98e67ed59e1d1-3aceec26e7cmr7164019a91.27.1792494398888;
        Tue, 20 Oct 2026 04:06:38 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f3425bsm3064392a91.8.2026.10.20.04.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:06:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: tests for 32-bit scalar evolution bounds computation
Date: Tue, 20 Oct 2026 04:06:27 -0700
Message-ID: <20261020-scev-32bit-v1-2-838f34f9f0cd@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-scev-32bit-v1-0-838f34f9f0cd@gmail.com>
References: <20261020-scev-32bit-v1-0-838f34f9f0cd@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The post32_* tests exercise scev.c:compute_max_iters():
- 32-bit to 64-bit operand extension and overflow handling.
- <, <=, >, >=, s<, s<=, s>, s>=, != operations.
- Checks exact boundary hits and overflow at S32_MIN, S32_MAX, and
  U32_MAX.

The post_cond_jne32* tests exercise zero-extension logic in
scev.c:linear_bounds():
- 32-bit unsigned wraparound.
- Entry and zero-extended iteration values disagreeing on base/step,
  requiring the step to be reduced.
- Widened bounds containing both the original entry value and the
  zero-extended iteration values.
- Preserving step and base when that union crosses the signed 64-bit
  boundary.

The post_cond_alu{32,64}_jmp{64,32} tests cover mixed-width recurrences
and comparisons:
- Declining to compute an iteration count when operands or the
  predicted exit fall outside the required 32-bit ranges.
- Computing iteration counts and widened bounds for compatible
  mixed-width loops.

Also add a basic pre-condition loop test.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 273 +++++++++++++++++++++-
 1 file changed, 272 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 59c4b2864db0..661ce9ca8f93 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf.h>
 #include <stdbool.h>
+#include <stdint.h>
 #include <bpf/bpf_helpers.h>
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
@@ -54,6 +55,12 @@ __naked void name(void)
 #define PRE__COND_TEST2(name, op, initial, step, bound, msg)                     \
 	PRE__COND_TEST(name, op, initial, step, bound, msg, LIMIT_ITERATIONS)
 
+#define POST_COND_TEST32(name, op, initial, step, bound, msg)                    \
+	COND_TEST(name, initial, step, bound, msg,                              \
+		"1: r8 = %[step] ll;" LIMIT_ITERATIONS                           \
+		"w6 += w8;"                                                     \
+		"if w6 " op " w7 goto 1b;")
+
 #define ITER_U64_MAX (~0ULL)
 #define ITER_S64_MAX ((1ULL << 63) - 1)
 #define ITER_S64_MIN (1ULL << 63)
@@ -969,6 +976,42 @@ PRE__COND_TEST (pre_ne_step_min,   "==",                 0, ITER_S64_MIN,     IT
  */
 PRE__COND_TEST2(pre_lt_zero_step,  ">=",                 1,            0,                7, "can't compute iterations count")
 
+/*
+ * Signed JMP32 comparisons sign-extend the initial value, bound and step.
+ * Encode negative operands as positive u32 constants so the conversion matters.
+ * post32_sgt also checks that an exit exactly at S32_MIN is accepted.
+ */
+/*              name               op                 initial  step             bound  expected message */
+POST_COND_TEST32(post32_slt,       "s<",                  -7u,    2,              -1u, "header_count is [0..3] ")
+POST_COND_TEST32(post32_sle,       "s<=",                 -7u,    2,              -1u, "header_count is [0..4] ")
+POST_COND_TEST32(post32_sgt,       "s>", (__u32)INT32_MIN + 6,  -2u, (__u32)INT32_MIN, "header_count is [0..3] ")
+POST_COND_TEST32(post32_sge,       "s>=",                 -1u,  -2u,              -7u, "header_count is [0..4] ")
+
+/*
+ * When computing 32-bit iteration bounds, scev.c:compute_max_iters() does
+ * the computation in the 64-bit domain first. For unsigned JMP32 comparisons,
+ * it zero-extends the initial value and bound, but sign-extends the step.
+ * Hence pick negative 64-bit initial values and bounds, and encode negative
+ * steps as positive u32 constants, so both conversions affect the computation.
+ * post32_lt also checks that an exit exactly at U32_MAX is accepted.
+ */
+POST_COND_TEST32(post32_lt,        "<",                    -7,    2,               -1, "header_count is [0..3] ")
+POST_COND_TEST32(post32_le,        "<=",                   -9,    2,               -3, "header_count is [0..4] ")
+POST_COND_TEST32(post32_gt,        ">",                    -1,  -2u,               -7, "header_count is [0..3] ")
+POST_COND_TEST32(post32_ge,        ">=",                   -1,  -2u,               -7, "header_count is [0..4] ")
+POST_COND_TEST32(post32_ne,        "!=",                   -1,  -2u,               -7, "header_count is [0..3] ")
+
+/* An exit exactly at S32_MAX is accepted as well. */
+POST_COND_TEST32(post32_slt_max,   "s<",        INT32_MAX - 6,    2,        INT32_MAX, "header_count is [0..3] ")
+
+/*
+ * The first iteration fits in 32 bits, but the predicted exit overshoots the bound
+ * by one and wraps.
+ */
+POST_COND_TEST32(post32_slt_wrap,  "s<",        INT32_MAX - 3,    2,        INT32_MAX, "can't compute iterations count")
+POST_COND_TEST32(post32_sgt_wrap,  "s>", (__u32)INT32_MIN + 3,  -2u, (__u32)INT32_MIN, "can't compute iterations count")
+POST_COND_TEST32(post32_lt_wrap,   "<",                    -4,    2,               -1, "can't compute iterations count")
+
 SEC("xdp")
 __success
 __log_level(2)
@@ -1549,7 +1592,7 @@ __msg_next("  r0=(+ r0 -1) / (linear (+ r0 -1) -1)")
 __msg("loop header at 1, header_count is 3 ")
 __msg("loop header at 1, widening r0 to 1..3 step 1")
 __msg("1: R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3)) loop_stack=1")
-__msg("loop header at 1, clamping r0 to 1..2 step 1")
+__msg("loop header at 1, clamping r0 to 1..2 (s32 1..2) step 1")
 __msg("processed 5 insns")
 __naked void post_cond_jne_neg_step(void)
 {
@@ -1591,6 +1634,234 @@ __naked void pre_cond_je1(void)
 "	::: __clobber_all);
 }
 
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg_next("scev at header 1:")
+__msg_next("  r0=(zext32 (+ r0 1)) / (zext32 (linear r0 1))")
+__msg_next(" scev at latch 2:")
+__msg_next("  r0=(zext32 (+ r0 1)) / (zext32 (linear (+ r0 1) 1))")
+__msg("loop header at 1, widening r0")
+__msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,{{.*}})")
+__msg("1: (04) w0 += 1                       ; R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,{{.*}})")
+__msg("2: (56) if w0 != 0x3 goto pc-2")
+__msg("3: (95) exit")
+__msg("loop header at 1, clamping r0")
+__msg("from 2 to 1: safe")
+__msg("processed 5 insns")
+__naked void post_cond_jne32(void)
+{
+	asm volatile ("					\
+	w0 = 0;						\
+1:	w0 += 1;					\
+	if w0 != 3 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* w0 ∈ {0xffffffff, 2, 5}, w0 % 3 ∈ {0, 2, 2} ⇒ step 3 can't be preserved */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("scev at header 1:")
+__msg_next("  r0=(zext32 (+ r0 3)) / (zext32 (linear r0 3))")
+__msg_next(" scev at latch 2:")
+__msg_next("  r0=(zext32 (+ r0 3)) / (zext32 (linear (+ r0 3) 3))")
+__msg("entering loop 1")
+__msg_next("loop header at 1, header_count is 2")
+__msg("loop header at 1, widening r0 to 0..0xffffffff (s32 -1..2) step 1")
+__msg("1: R0=scalar(smin=0,smax=umax=0xffffffff,smin32=-1,smax32=2,{{.*}})")
+__naked void post_cond_jne32_overflow(void)
+{
+	asm volatile ("					\
+	w0 = 0xffffffff;				\
+1:	w0 += 3;					\
+	if w0 != 5 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * w0 ∈ {0, 3, ..., 0xffffffff, 2, 5}, w0 % 3 ∈ {0, 0, ..., 0, 2, 2}
+ * ⇒ step 3 can't be preserved.
+ */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 2, header_count is 1431655767")
+__msg("loop header at 2, widening r0 to 0..0xffffffff step 1")
+__naked void post_cond_jne32_full_range(void)
+{
+	asm volatile ("					\
+	w0 = 0;						\
+	w1 = 0;						\
+1:	w0 += 3;					\
+	w1 += 1;					\
+	if w1 != 1431655767 goto 1b;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* r0 ∈ {-6, 0xfffffff7, 0xfffffff4}, r0 % 3 ∈ {0, 1, 1} ⇒ step 3 can't be preserved. */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 1, header_count is 2")
+__msg("loop header at 1, widening r0 to -6..0xfffffffa (s32 -9..-6) step 1")
+__naked void post_cond_jne32_base_mismatch(void)
+{
+	asm volatile ("					\
+	r0 = -6;					\
+1:	w0 += -3;					\
+	if w0 != -12 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * r0 ∈ {0, 0xffffffff, 0xfffffffe},
+ * ⇒ the 64-bit header bounds are [0, U32_MAX], 32-bit header bounds are [-1, 0].
+ */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 1, header_count is 2")
+__msg("loop header at 1, widening r0 to 0..0xffffffff (s32 -1..0) step 1")
+__naked void post_cond_jne32_neg_step(void)
+{
+	asm volatile ("					\
+	w0 = 0;						\
+1:	w0 += -1;					\
+	if w0 != -2 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * r0 ∈ {S64_MIN + 1, 3, 5}, r0 % 2 ∈ {1, 1, 1}
+ * ⇒ step 2 and base 1 can be preserved.
+ */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 2, header_count is 2")
+__msg("loop header at 2, widening r0 to 0x8000000000000000..0x7fffffffffffffff (s32 1..3) step 2")
+__msg("2: R0=scalar({{.*}}step=1+2)")
+__naked void post_cond_jne32_signed_boundary(void)
+{
+	asm volatile ("					\
+	r0 = %[initial] ll;				\
+1:	w0 += 2;					\
+	if w0 != 5 goto 1b;				\
+	exit;						\
+"	:
+	: __imm_const(initial, ITER_S64_MIN + 1)
+	: __clobber_all);
+}
+
+/* The pre-condition also visits the header with the terminating value 3. */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 1, header_count is 4")
+__msg("loop header at 1, widening r0 to 0..3 (s32 0..3) step 1")
+__msg("loop header at 1, clamping r0")
+__msg("4: R0=3")
+__naked void pre_cond_je32(void)
+{
+	asm volatile ("					\
+	w0 = 0;						\
+1:	if w0 == 3 goto 2f;				\
+	w0 += 1;					\
+	goto 1b;					\
+2:	exit;						\
+"	::: __clobber_all);
+}
+
+/* ALU32 keeps r0 in [0, U32_MAX], so the 64-bit comparison never becomes false. */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 4, can't compute iterations count")
+__naked void post_cond_alu32_jmp64(void)
+{
+	asm volatile ("					\
+	w0 = 0;						\
+	r1 = 0x100000003 ll;				\
+	r9 = 0;						\
+1:	"
+	LIMIT_ITERATIONS
+	"w0 += 1;					\
+	if r0 != r1 goto 1b;				\
+2:	exit;						\
+"	::: __clobber_all);
+}
+
+/* The signed 32-bit comparison is always true, even when r0 exceeds INT32_MAX. */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 2, can't compute iterations count")
+__naked void post_cond_alu64_jmp32(void)
+{
+	asm volatile ("					\
+	r0 = %[initial];				\
+	r9 = 0;						\
+1:	"
+	LIMIT_ITERATIONS
+	"r0 += 1;					\
+	if w0 s<= %[bound] goto 1b;			\
+2:	exit;						\
+"	:
+	: __imm_const(initial, INT32_MAX - 1),
+	  __imm_const(bound, INT32_MAX)
+	: __clobber_all);
+}
+
+/* ALU32 values above INT32_MAX remain positive in a signed 64-bit comparison. */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 3, header_count is 3")
+__msg("loop header at 3, widening r0 to 0xfffffffc..0xfffffffe (s32 -4..-2) step 1")
+__naked void post_cond_alu32_jmp64_bounded(void)
+{
+	asm volatile ("					\
+	w0 = -4;					\
+	r1 = 0xffffffff ll;				\
+1:	w0 += 1;					\
+	if r0 s< r1 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* The negative 64-bit counter and its exit value fit in the signed 32-bit range. */
+SEC("xdp")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("loop header at 1, header_count is 3")
+__msg("loop header at 1, widening r0 to -6..-2 step 2")
+__naked void post_cond_alu64_jmp32_bounded(void)
+{
+	asm volatile ("					\
+	r0 = -6;					\
+1:	r0 += 2;					\
+	if w0 s< 0 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("xdp")
 __success
 __log_level(2)

-- 
2.53.0
