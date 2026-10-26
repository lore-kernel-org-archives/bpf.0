Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984009;
	b=rjF3qzbM6e2dMwPmzlgqE7LT5UdQgl/mZvbVjkt5P9DSKgVA9Bw7rTZI4UuGCDDs83DV
	 nOgsGrz0XNtPTDJf5oHGTMrdlYpdl0YbAl6xv3hbK+31hm8tQbhgnTssMCaJO7P7q7jOg
	 l8Y24uxYC7J+VZ1XWFHgpZ3PPNGPF0NXp45LklbJypgWy4EYe2CwslJB+RLCxsUBkgIc7
	 h7YJbSpAhV8VPQBfcwmUSnefSQCn1heZC90utTr8ooglqn2YKKi2JIleW0oNXRt1KjYuC
	 XdZi2NOqAaQTv17x7K4WJkqwQ6uAOvKbc4I67zKPZpE/zCJpizWKKA+hMREmaI7uXgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dk9CxDgibUHmjhxpJUTHJytpEkr8zzsHs06trnl8VZw=;
	b=vltQcL2Nyf2iC4tBcewRGoBWa0SZa3HvFXz9REZCv3J+Uc6fRcfGvutX1Htns++QVElE
	 RlgXPf9DUzb0FveCHFhnUh0m3ls/6pi0TX0iCDI/p6ZEZBPusvZETwr/iCwORfVS9I9EE
	 aE6QFh//MRqk6k+sBhT+2BqQRvbIYsanCMyJiTRHWEzgWIqsAqtu7zBZ2fdSDmeXCpF5q
	 juFWd9hecPfqlwmTXnJ2KJi5ZLnvH//8FUZLkOGfGgNNLrJgaz6UtnuB1XUOvkt9TtH7o
	 p3Nqo0GwRsJZ/GMMoxxtZYhWiv3jITkFMyhAE+L3ICM5hzUd0HYCwi4UmqqssUI12hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JqsVsUKm;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C40606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C40606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JqsVsUKm
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1842313a91.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984009; x=1793588809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dk9CxDgibUHmjhxpJUTHJytpEkr8zzsHs06trnl8VZw=;
        b=JqsVsUKmJK0xLNRiy1NrLf2vCcFcX4ItUhTfxdLJS8zBuo1zv3dLsUMTdb/tqN1ZWr
         9FokQ1a/2yFN9+RcuPcNg9iP97PyMxt71PunVEAwGL2eh4wiLzCHRxyV7SkPxurjcDd6
         OqThZ9xYCnlMKJ89wBxL3pe37ty+O4FVwAlQaN9aPCytLlUYXkLSXNaqpywI//smgrDZ
         U1DPfgbdrv/Xx35ZurgNJYngk/PqTj7nIchd4K8vFjCX2K2TZj+3TLVu40Aj/iNqduh0
         S3uBSjvmN9CG/RoCzm9yRX2FUVIAbLfImayBpo1LkZG5bMdTSkD2X4N76+ki4lgfDTB0
         scPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984009; x=1793588809;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dk9CxDgibUHmjhxpJUTHJytpEkr8zzsHs06trnl8VZw=;
        b=e+azd7tWighk14e2cRqdebSixw0GKZBHtmJjwhOX8k3JmeltShjswtbd4hGLf76Cfx
         Cqtb+b7U7wDhV2AfsT9Mse05Syh+JuFaQQUjckZRo5NVMEa52pGiQrLUaM/ege8vT3L7
         diOzKu5qlhkE7Ky9VhvmxCQLVtAzMXA6MNtYszrB38KwpRPA1z/OvxY+jmu+zPSZ38ZH
         mDVmqSYlMciBDq1L4dNluaysipU3WWhqwUwIYbVdyHbahaRj+ImFeakETE+gMY/KtIJ0
         A9y57EQr5o1X0zIl4QLrhnkmABqk4kvNhfVuBwFRnZO3m1MzWM9YXt9zILEZ0L30MmYH
         fLnA==
X-Gm-Message-State: AFq9FYI1trxFEJN63jHveI8BN+Pjz0BORfc38Th84DFuum3vGEUfme5I
	JS8eWoZOgz/QeH6ULXaNy/TMqop3p34tz+19ESYEJekZuTTMx7E1CTQFFwK8KA==
X-Gm-Gg: AYBFou2ja5PVGC9YabIwNpxT1ZeF6v9yjbmIZk/bzPrH4C9LN6JwLi8PnHw9Lb6zDtA
	J64uKKUqmjbxP4bLq1cqHo8K2BVjH5o5agdizQImOOoGcs6xMn99JJSgxm7wIaQP9c5MbDJ6/+O
	HghYze6x0VfJcTYXwfWUy+OCUCGGWloW1xY/sXGZZciEIqHvm/C6htrAhKfBgprl/BRUuSQwNnc
	1Do8CFF8AvHHcHNphdzzNYs15Ucx9aDTcRbhp5zLmi2uNUEw9zMS3j8bJNpxHwPV5Ua0isqbd7H
	rTHF7eAKmtBZlog6IgqECLRm8lqAK8eAoq23JKN1g4wwWDS+gKL7x43opCDoBJUo5RGzHTTYsOg
	jY3zO7b4DWouEiBmyk/QPhVFi3/UN90rQCHw7M48pORq53QscO2YUbfqU0ydCoWFJVDfG8kYTNq
	CgE4mzPB3XJV5pcTvMsu0Q9RQkLjsnzR3Q0QNY9TLXcrJ9KcnpbLG+QsCYU4bqADmQ4ZKBk0yYF
	OF2i6bOPvtr2FYaHU7mx41P5ZOPbMl+dfzjyx4dIprMV3N+In5XVw/aMNYQvzHr2n5G4daxtoKE
	+M5gkmZHhzmb46cpi4D6nw3bZqqWGXzHRlAsDLPxpizDhbkOygAFYMsml75ECAUiCr+Skzxduwm
	cIZ9NfV31o8DegMnbtTZOAP5x
X-Received: by 2002:a17:90b:534b:b0:3ad:ce34:f63c with SMTP id 98e67ed59e1d1-3adeae9c576mr4593052a91.30.1792984008295;
        Sun, 25 Oct 2026 20:06:48 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebad93c5sm4646114a91.2.2026.10.25.20.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:47 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 72/81] selftests/bpf: Adjust tests of pruning
Date: Mon, 26 Oct 2026 02:59:33 +0000
Message-ID: <20261026025943.404450-73-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The verifier followed each path of a prog. It pruned a path when a state
that it saw before at the same insn covered the current state. regsafe(),
stacksafe() and range_within() made this decision, and these tests examine
them. Now the verifier joins the states that meet at a basic block. The
same functions compare a state that arrives at a block with the states that
are already there.

  a state arrives at N     the verifier follows     the verifier joins
                           paths                    states
  -----------------------  -----------------------  -----------------------
  a state at N covers it   It stops the path.       It drops the state.
                           "N: safe"                "from M to N: within"
  no state covers it       It verifies the insns    It joins the two states
                           from N again.            and verifies the join.

Tests of the first case match the new message. Tests of the second case
match the join.

verifier_bounds_step.c examines the step of a scalar, which is the distance
between its possible values.

  test                            the values that meet           result
  ------------------------------  -----------------------------  -------
  step_prune_hit_multiple         [8,68] step 4, [4,130] step 2  step 2
  step_prune_miss_non_multiple    [0,30] step 2, [0,189] step 3  no step
  step_prune_hit_const_on_line    6, and 0,3,6,... (step 3)      step 3
  step_prune_miss_const_off_line  7, and 0,3,6,... (step 3)      no step

In the two "miss" tests the bounds of the second value contain the first
value. If range_within() ignores the step, the result keeps step 3 and does
not contain all values.

One verdict changes. short_loop1 has a loop with an unknown number of
iterations. The verifier followed the iterations until
"BPF program is too large". Now one state at the loop head covers all
iterations, and the prog loads.

"precision tracking for u32 spills, u64 fill" has 'w3 /= 0' two times: in a
filler insn, and after the jump that it tests. The verifier rejected the
prog at the filler insn, thus the test examined nothing. Replace the filler
insn.

Other changes in the expected logs:
 - "precision tracking for u32 spill/fill" and
   ringbuf_missing_release_callback get a different message for the same
   problem.
 - A state that the verifier drops does not count as a processed insn. Thus
   "processed N insns" is lower by one.
 - The changed tests drop BPF_F_TEST_STATE_FREQ, which has no effect
   without pruning.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c |  4 +-
 .../bpf/progs/verifier_bounds_step.c          | 73 ++++++++++---------
 .../selftests/bpf/progs/verifier_live_stack.c | 23 +++---
 .../bpf/progs/verifier_search_pruning.c       | 30 +++-----
 .../selftests/bpf/progs/verifier_spin_lock.c  |  4 +-
 .../selftests/bpf/progs/verifier_stack_ptr.c  | 15 ++--
 6 files changed, 68 insertions(+), 81 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index c2247b38c849..3d895a90df25 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -127,7 +127,7 @@ static int missing_release_callback_fn(__u32 index, void *data)
 
 /* A callback cannot return with the last dynptr for a referenced resource. */
 SEC("?raw_tp")
-__failure __msg("cannot overwrite referenced dynptr")
+__failure __msg("Unreleased reference id=1")
 int ringbuf_missing_release_callback(void *ctx)
 {
 	bpf_loop(10, missing_release_callback_fn, NULL, 0);
@@ -782,7 +782,7 @@ int dynptr_pruning_overwrite(struct __sk_buff *ctx)
 }
 
 SEC("?tc")
-__success __msg("12: safe") __log_level(2)
+__success __msg("to 12: within") __log_level(2)
 int dynptr_pruning_stacksafe(struct __sk_buff *ctx)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
index d824a5d48a39..51b703058cf7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
@@ -371,14 +371,17 @@ struct {
 	__type(value, struct step_val);
 } step_map SEC(".maps");
 
-/* Old register [4..130, step 2] should prune cur register [8..68, step 4]. */
+/*
+ * Register [8..68, step 4] is within register [4..130, step 2]: one state stands for both
+ * and nothing is lost.
+ */
 SEC("socket")
 __success __log_level(2)
 __msg("7: (27) r6 *= 4                       ; R6=scalar({{.*}}umin32=8,{{.*}}umax32=68,{{.*}},step=0+4)")
 __msg("10: (27) r7 *= 2                      ; R7=scalar({{.*}}umin32=4,{{.*}}umax32=130,{{.*}},step=0+2)")
 __msg("11: (25) if r0 > 0x2a goto pc+1")
-__msg("from 11 to 13: safe")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("13: R6=scalar({{.*}}umin32=4,{{.*}}umax32=130,{{.*}},step=0+2) R10=fp0")
+__msg("processed 18 insns")
 __naked void step_prune_hit_multiple(void)
 {
 	asm volatile ("					\
@@ -394,11 +397,11 @@ __naked void step_prune_hit_multiple(void)
 	r7 += 2;					\
 	r7 *= 2;					\
 	if r0 > 42 goto 1f;	/* can't predict */	\
-	r6 = r7;		/* step=2 explored first, step=4 explored next */ \
+	r6 = r7;		/* step=2 here, step=4 on the other path */ \
 1:	r0 = r10;					\
 	r6 = -r6;					\
 	r0 += r6;					\
-	*(u8 *)(r0 + 0) = 7;	/* force r6 precise */	\
+	*(u8 *)(r0 + 0) = 7;				\
 	exit;						\
 "	:
 	: __imm(bpf_get_prandom_u32)
@@ -406,17 +409,16 @@ __naked void step_prune_hit_multiple(void)
 }
 
 /*
- * Old register [0..189, step 3] should not prune cur register [0..30, step 2].
- * Bounds and tnum containment allow pruning; step divisibility must prevent it.
+ * Register [0..30, step 2] is not within register [0..189, step 3].
+ * Bounds and tnum say that it is; step divisibility must prevent it.
+ * The states are joined and the result has no step.
  */
 SEC("socket")
 __success __log_level(2)
 __msg("6: (27) r6 *= 2                       ; R6=scalar({{.*}}smin32=0,{{.*}}umax32=30,{{.*}},step=0+2)")
 __msg("8: (27) r7 *= 3                       ; R7=scalar({{.*}}smin32=0,{{.*}}umax32=189,{{.*}},step=0+3)")
 __msg("9: (25) if r0 > 0x2a goto pc+1")
-__msg("17: (95) exit")
-__msg("from 9 to 11: R6=scalar({{.*}},step=0+2)")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("11: R6=scalar({{.*}}umax32=189,var_off=(0x0; 0xff)) R10=fp0")
 __naked void step_prune_miss_non_multiple(void)
 {
 	asm volatile ("					\
@@ -430,13 +432,13 @@ __naked void step_prune_miss_non_multiple(void)
 	r7 &= 0x3f;					\
 	r7 *= 3;					\
 	if r0 > 42 goto 1f;	/* can't predict */	\
-	r6 = r7;		/* step=3 explored first, step=2 explored next */ \
+	r6 = r7;		/* step=3 here, step=2 on the other path */ \
 1:							\
 	r2 = r10;					\
 	r6 += 1;					\
 	r6 = -r6;					\
 	r2 += r6;					\
-	*(u8 *)(r2 + 0) = 7;	/* force r6 precise */	\
+	*(u8 *)(r2 + 0) = 7;				\
 	r0 = 0;						\
 	exit;						\
 "	:
@@ -445,17 +447,17 @@ __naked void step_prune_miss_non_multiple(void)
 }
 
 /*
- * Constant current register lying on the cached line: cached is {0,3,6,...}
- * (step 3, base 0), current is the constant 6. range_within() takes the
- * constant branch: imod(6, 3) == base 0, so cur is on the line and the
- * (precise) state is pruned -> "safe".
+ * Constant register lying on the line of the other state: that is {0,3,6,...}
+ * (step 3, base 0), this is the constant 6. range_within() takes the
+ * constant branch: imod(6, 3) == base 0, so the constant is on the line and
+ * the state with the line stands for both.
  */
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("14: (27) r1 *= 3")		/* cached path: step 3 line */
-__msg("16: (b7) r1 = 6")		/* current path: const 6, on the line */
-__msg("17: safe")			/* pruned at join: imod(6, 3) == 0 */
+__msg("16: (b7) r1 = 6")		/* const 6, on the line */
+__msg("14: (27) r1 *= 3")		/* step 3 line */
+__msg("from 15 to 17: joined")
+__msg("17: R1=scalar({{.*}},step=0+3) R7=")	/* imod(6, 3) == 0 */
 __naked void step_prune_hit_const_on_line(void)
 {
 	asm volatile ("					\
@@ -472,13 +474,13 @@ __naked void step_prune_hit_const_on_line(void)
 	r1 = r6;					\
 	r1 &= 0xff;					\
 	if r6 > 0 goto l_cur_%=;			\
-	r1 *= 3;			/* old: step 3 */	\
+	r1 *= 3;			/* step 3 */	\
 	goto l_join_%=;					\
 l_cur_%=:						\
-	r1 = 6;				/* cur: const on line */	\
+	r1 = 6;				/* const on line */	\
 l_join_%=:						\
 	r0 = r7;					\
-	r0 += r1;			/* r1 forced precise */	\
+	r0 += r1;					\
 	r2 = *(u8 *)(r0 + 0);				\
 l_out_%=:						\
 	r0 = 0;						\
@@ -491,22 +493,21 @@ l_out_%=:						\
 }
 
 /*
- * Constant current register NOT on the cached line: cached is {0,3,6,...}
- * (step 3, base 0), current is the constant 7. imod(7, 3) == 1 != base 0,
- * so range_within() fails and the join is traversed again. A power-of-two
+ * Constant register NOT on the line of the other state: that is {0,3,6,...}
+ * (step 3, base 0), this is the constant 7. imod(7, 3) == 1 != base 0,
+ * so range_within() fails and the states are joined. A power-of-two
  * step is avoided on purpose: with step 3 the tnum is loose enough to admit
  * 7, so imod() is
  * the sole check that rejects it. No failure shape is possible here: 7 is
- * within the line's bounds and tnum, and the cached line path already
- * verifies the whole outro, so an eager prune could not miss an error.
+ * within the line's bounds and tnum.
  */
 SEC("socket")
 __success __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("14: (27) r1 *= 3")		/* cached path: step 3 line */
-__msg("16: (b7) r1 = 7")		/* current path: const 7, off the line */
-/* not pruned: current continues past the join with the constant offset 7 */
-__msg("19: R0=map_value({{.*}}imm=7) R1=7")
+__msg("16: (b7) r1 = 7")		/* const 7, off the line */
+__msg("14: (27) r1 *= 3")		/* step 3 line */
+/* the result stands for 7 too: it has no step */
+__msg("from 15 to 17: joined")
+__msg("17: R1=scalar({{.*}}var_off=(0x0; 0x3ff)) R7=")
 __naked void step_prune_miss_const_off_line(void)
 {
 	asm volatile ("					\
@@ -523,13 +524,13 @@ __naked void step_prune_miss_const_off_line(void)
 	r1 = r6;					\
 	r1 &= 0xff;					\
 	if r6 > 0 goto l_cur_%=;			\
-	r1 *= 3;			/* old: step 3 */	\
+	r1 *= 3;			/* step 3 */	\
 	goto l_join_%=;					\
 l_cur_%=:						\
-	r1 = 7;				/* cur: const off line */	\
+	r1 = 7;				/* const off line */	\
 l_join_%=:						\
 	r0 = r7;					\
-	r0 += r1;			/* r1 forced precise */	\
+	r0 += r1;					\
 	r2 = *(u8 *)(r0 + 0);				\
 l_out_%=:						\
 	r0 = 0;						\
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 5f9b11a81260..f70b23abc702 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -380,9 +380,9 @@ __msg("10: (b7) r0 = 0{{$}}")
 __msg("11: (05) goto pc+0{{$}}")
 __msg("12: (95) exit")
 /*
- * Checkpoint at goto +0 fires because fp0-8 is dead → state pruning.
+ * fp0-8 is dead after goto +0, so one state stands for both.
  */
-__msg("12: safe")
+__msg("from 11 to 12: within")
 __naked void caller_stack_pruning(void)
 {
 	asm volatile (
@@ -497,7 +497,6 @@ struct {
 
 SEC("socket")
 __failure __msg("invalid read from stack R2 off=-4096 size=8")
-__flag(BPF_F_TEST_STATE_FREQ)
 __naked unsigned long caller_stack_write_tail_call(void)
 {
         asm volatile (
@@ -855,7 +854,7 @@ static __used __naked void maybe_clobber_key(void)
 
 /*
  * Demonstrate that subprog arg spill/reload breaks arg tracking,
- * inflating caller stack liveness and preventing state pruning.
+ * inflating caller stack liveness and keeping states apart.
  *
  * modifier2(fp-24) has two paths: one writes a scalar to *(r1+8)
  * = caller fp-16, the other leaves it as zero.  After modifier2
@@ -871,16 +870,15 @@ static __used __naked void maybe_clobber_key(void)
  * the reader never touches it.
  *
  * Result: at modifier2's return point two states with different
- * fp-16 values cannot be pruned.
+ * fp-16 values are kept apart.
  *
- * With correct (or old dynamic) liveness fp-16 is dead at that
- * point and the states prune → "6: safe" appears in the log.
+ * With correct liveness fp-16 is dead at that point and one state is
+ * within the other one.
  */
 SEC("socket")
-__flag(BPF_F_TEST_STATE_FREQ)
 __log_level(2)
 __success
-__msg("6: safe")
+__msg("from 16 to 6: within")
 __naked void spill_reload_inflates_stack_liveness(void)
 {
 	asm volatile (
@@ -1372,13 +1370,12 @@ __naked void half_spi_clean_preserves_stack_zero(void)
  *
  * Static liveness marks fp-8 dead at merge. clean_verifier_state()
  * converts path A's STACK_SPILL to STACK_INVALID. Path B has
- * STACK_INVALID. stacksafe() matches -> path B pruned -> "6: safe".
+ * STACK_INVALID. stacksafe() matches -> one state stands for both paths.
  */
 SEC("socket")
-__flag(BPF_F_TEST_STATE_FREQ)
 __success
 __log_level(2)
-__msg("6: safe")
+__msg("from 5 to 6: within")
 __naked void dead_spill_at_merge_enables_pruning(void)
 {
 	asm volatile (
@@ -1390,7 +1387,7 @@ __naked void dead_spill_at_merge_enables_pruning(void)
 	"call %[bpf_get_prandom_u32];"
 	"r6 = *(u64 *)(r10 - 8);"
 "l_skip%=:"
-	/* fp-8 dead. Path B pruned here -> "6: safe" */
+	/* fp-8 dead. The states of both paths are the same here */
 	"r0 = r6;"
 	"exit;"
 	:
diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
index f40e57251e94..f13ff9380947 100644
--- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -96,7 +96,7 @@ l1_%=:	exit;						\
 SEC("socket")
 __description("varlen_map_value_access pruning")
 __failure __msg("R0 unbounded memory access")
-__failure_unpriv __msg_unpriv("R0 leaks addr")
+__failure_unpriv __msg_unpriv("R0 unbounded memory access")
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void varlen_map_value_access_pruning(void)
 {
@@ -193,7 +193,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("precision tracking for u32 spill/fill")
-__failure __msg("R0 min value is outside of the allowed memory range")
+__failure __msg("invalid access to map value, value_size=8 off=32 size=4")
 __naked void tracking_for_u32_spill_fill(void)
 {
 	asm volatile ("					\
@@ -202,7 +202,7 @@ __naked void tracking_for_u32_spill_fill(void)
 	w6 = 32;					\
 	if r0 == 0 goto l0_%=;				\
 	w6 = 4;						\
-l0_%=:	/* Additional insns to introduce a pruning point. */\
+l0_%=:	/* Additional insns to have one more place where paths meet. */\
 	call %[bpf_get_prandom_u32];			\
 	r3 = 0;						\
 	r3 = 0;						\
@@ -239,15 +239,11 @@ __naked void for_u32_spills_u64_fill(void)
 	call %[bpf_get_prandom_u32];			\
 	r6 = r0;					\
 	w7 = 0xffffffff;				\
-	/* Additional insns to introduce a pruning point. */\
-	r3 = 1;						\
-	r3 = 1;						\
-	r3 = 1;						\
-	r3 = 1;						\
+	/* Additional insns to have a place where paths meet. */\
 	call %[bpf_get_prandom_u32];			\
 	if r0 == 0 goto l0_%=;				\
 	r3 = 1;						\
-l0_%=:	w3 /= 0;					\
+l0_%=:	r3 = 1;						\
 	/* u32 spills, u64 fill */			\
 	*(u32*)(r10 - 4) = r6;				\
 	*(u32*)(r10 - 8) = r7;				\
@@ -255,11 +251,7 @@ l0_%=:	w3 /= 0;					\
 	/* if r8 != X goto pc+1  r8 known in fallthrough branch */\
 	if r8 != 0xffffffff goto l1_%=;			\
 	r3 = 1;						\
-l1_%=:	/* if r8 == X goto pc+1  condition always true on first\
-	 * traversal, so starts backtracking to mark r8 as requiring\
-	 * precision. r7 marked as needing precision. r6 not marked\
-	 * since it's not tracked.			\
-	 */						\
+l1_%=:	/* if r8 == X goto pc+1 */			\
 	if r8 == 0xffffffff goto l2_%=;			\
 	/* fails if r8 correctly marked unknown after fill. */\
 	w3 /= 0;					\
@@ -272,7 +264,8 @@ l2_%=:	r0 = 0;						\
 
 SEC("socket")
 __description("allocated_stack")
-__success __msg("processed 15 insns")
+/* every insn once: what is written to the stack on one path is dead where the paths meet */
+__success __msg("processed 14 insns")
 __success_unpriv __msg_unpriv("") __log_level(1) __retval(0)
 __naked void allocated_stack(void)
 {
@@ -337,12 +330,9 @@ l0_%=:	r1 = 42;					\
 	: __clobber_all);
 }
 
-/* Without checkpoint forcibly inserted at the back-edge a loop this
- * test would take a very long time to verify.
- */
+/* The number of trips is not known */
 SEC("kprobe")
-__failure __log_level(4)
-__msg("BPF program is too large.")
+__success
 __naked void short_loop1(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
index d9d7b05cf6d2..f4e7f47e4cdd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spin_lock.c
@@ -469,9 +469,9 @@ l3_%=:	r1 = r7;					\
 
 SEC("cgroup/skb")
 __description("spin_lock: regsafe() check_ids() similar id mappings")
-__success __msg("29: safe")
+__success __msg("to 29: within")
 __failure_unpriv __msg_unpriv("")
-__log_level(2) __retval(0) __flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2) __retval(0)
 __naked void check_ids_similar_id_mappings(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 7fa7bc207850..4c6e4465092f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -587,14 +587,13 @@ __naked void stack_check_size_512_with_may_goto(void)
 #endif
 
 /*
- * Verify that old PTR_TO_STACK state is considered a super-set of
- * new PTR_TO_STACK state when new variable range is a sub-range
- * of the old range, e.g. old [-72, -16] vs new [-64, -16].
+ * Verify that a PTR_TO_STACK state is considered a super-set of
+ * another PTR_TO_STACK state when the variable range of that is a sub-range
+ * of its range, e.g. [-72, -16] vs [-64, -16].
  */
 SEC("socket")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 /*
  * r7 is widened to [-72, -16] at the loop header (insn 3),
  * the loop body sees [-64, -8] after 'r7 += 8'
@@ -602,12 +601,12 @@ __flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 3, widening r7 to -72..-16 step 8")
 __msg("R7=fp(smin=smin32=-64,smax=smax32=-8")
 /*
- * back-edge state is clamped to the remaining iterations and pruned
- * at the header, because [-64, -16] is within the widened [-72, -16]
+ * back-edge state is clamped to the remaining iterations and goes no further
+ * than the header, because [-64, -16] is within the widened [-72, -16]
  */
 __msg("loop header at 3, clamping r7 to -64..-16 (s32 -64..-8) step 8")
-__msg("from 5 to 3: safe")
-__msg("processed 9 insns")
+__msg("from 5 to 3: within")
+__msg("processed 8 insns")
 __naked void stack_ptr_subrange_in_loop(void)
 {
 	asm volatile ("					\
-- 
2.55.0

