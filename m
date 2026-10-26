Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984017;
	b=mSHuVSnyqCmdf7m3q2j/rGpB/g8ACKEypapoHs+zvha0zPBzYkPtclN7sW2sgjWqAnTM
	 jh8k5UYn73me3sK+LOMUbC/6GbOmWvAakWOwNucDvVNMXw7DXsd+UPgCaLkoO47g7bp43
	 2KNcRqCux6y9F8MOXCOL/gJa/cjwXILKr0I4qwh5V2RdJ91JOP4V2+32yK3ea3PpAeo2t
	 /jabwOGnk762UPmS+pPmqAAdLFzNzMSQSEy14mCA9TaPhQ7zksMyQhtXO1naiIHvP2fSj
	 GDcI3D4Usc2Tt5NTJVptsR2VPGdjx9eCIjVuI6tjw3fPCXdqgSt1JsLg36OjHGpP2sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UG+M8IIRzLBcDQ37fQCVGHnjVOm5AYwQDqBo/OZvE5g=;
	b=ceB2WbQMZVdCAKxZ4Q899wOss80Rl3Hv+9bKDp2oJGQhu9cvfjbY/iuGMPcYySMWfyrv
	 ISSbSppd5vBCGQWgj9TbIC7QWj0hzvsHefBka9DVICqqKGR0PCmhzMzuc/j8Xm9q0/0pX
	 9H+O+P5ji5AGy+MWNbmkHdQEpTBqupjAduyA3HHuOMA92HmNOjiltcov75RtJ2hxqtsP7
	 58j79IQRZaFZHi4f21n8ruxt0cBrQXaxKgLpBB0+yY6iNS9QhDTLH1gfoH2LhUHD/wINB
	 CII9RRRdeC78bD8Ta+BivN1AyQle7Xq8izrVfvlFyn1zI30f5kqA1DoML5mbZYCQZPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rc0eYP2x;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6E606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BC6E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Rc0eYP2x
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e812e2b31bso14374635ad.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984016; x=1793588816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UG+M8IIRzLBcDQ37fQCVGHnjVOm5AYwQDqBo/OZvE5g=;
        b=Rc0eYP2x7LwZHV7nGYe8QbDok3r1CYWIoQIs4mHcgpal8zGPvQFYGn+9iH0s/MdOy/
         Qfxw+8XKIiIAwLii2piizswAQviJHmB7IBPxVshiAPDOTgCJfSzahtOaMLY2sjkIrQpO
         +sQupslgF6Jp9S38LlGzAKHRtfUj+f6zJEaws4+Nd0X13W2bhw+dwoPStqAaRpXY4XPE
         aOTBnVrY7SuXCG5Z8WTO0KW3NULQ0RFl2GoiQ3nluNCzAxZh7wxgTV0W3Oqq5L82+IhT
         cllT8ip2BpnAAmZbA8aslk63K/9jvkCO+SOtBEw5iF8sEYyaC34ws9olIOzBvniH7mfN
         l5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984016; x=1793588816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UG+M8IIRzLBcDQ37fQCVGHnjVOm5AYwQDqBo/OZvE5g=;
        b=jTYSD0t2JMLOgzAc0r4MKvkUMOzReC2yB90jWMi/weDU9ZeisqlGkoeSVY5lQMQlA2
         lliFI8Js6NVxrMnHeDjtJwBMEqL1onpsrWyB7efgvFl6GLg4xgbYskE2b6UAA8R8UCd0
         eB3DuTvGfCCQaQMiq3sjhGiruCAPIcZVKlATmCdL4HuUmvD56CPlSoKGKlUlkvtz1GMF
         0CHAKXtMAmufFkwhcQzzrxMX85FXibo3H327B+m8bDzhtPLClpThjyvoiTNIYUkQekoq
         MK6IoAFJbkNoL6sbL+ujIoJJB0Pxf9JwCN4cSkb/OzxdpWg391iKP7sfccThOZuW4DCo
         hXwQ==
X-Gm-Message-State: AFq9FYL069ay5cwFN0cxegcHPvmWJyj35RnkmwvmZag9iDSJAXqA9Mv4
	PVcPsCjqL/Sq2up6Gd+4WAdygIDyFppXGh9eUxCyCRw/2juIM1zrL9gQbR9S0A==
X-Gm-Gg: AYBFou3YOM599EpZZdUHLhiPNrxmapi721yQ59VQ5anV45v/KyOQgeeSRHtlXeYnV1Q
	SFeXe8saQCIVwoH2NDnOLtq++JslMRZGXnC50NobEdlk7EUfNPGQHwfm1ODchT4iIq+xBYFOTmw
	2VbYzG9bjc4iZj+7Z4MCB+AHfcoi5pztiqnXS7iibRjbF3jl9cUoMQoErVYZoCTPMq3sNNWz1CH
	sA6cbkIdd9SEPv2JcktKvPX+gdE8ZKC1DqAx6dOoE2BE3Hu2Fv4Vx+Djsbz2WT3Xd2N3OcnnOVQ
	wFj568qNbY0oks7geih4LzMO9v2uljpXmdkUrfiHG45ywHdfbejX8+k2oYhMRQWVCDIImGr+47u
	JSah7LupFGPatHDZKc1AC6fkAXzXvIMK+EsqyedTDFVFnKBIfiWYvUvs9sXK7LtPmqHKg/qWV8G
	v+CCWywsrjt+A0N80sYtVG75Lt76Oaa1fRJfiL+Z+JYIwKRvkOfRb4SUl8hxgY5Bwlpq50cTeIK
	Os4ogfpB5wDXskQ5x3a4brptQ6fm4QDyO5sHGHae2FDR+IWYES/DdznjFBv5hLlmPt+tv+Ja4Va
	APAO68eQrzl8pU4cLHzX2mFwiu1SAM0ca2moocRM3dDT2c6zkz5QsKsuSKXALNf/agh4UmcQB6h
	LrqW8SCfIyojTcbR3zFb255fu
X-Received: by 2002:a17:90b:1b01:b0:3ab:1b1c:8a70 with SMTP id 98e67ed59e1d1-3adeafbb11bmr4560120a91.38.1792984014229;
        Sun, 25 Oct 2026 20:06:54 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebad6306sm5193298a91.2.2026.10.25.20.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:06:53 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 73/81] selftests/bpf: Adjust tests of loops
Date: Mon, 26 Oct 2026 02:59:34 +0000
Message-ID: <20261026025943.404450-74-alexei.starovoitov@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Scalar evolution calculates how many times a loop runs. When it could not,
the verifier verified the loop one iteration at a time. If a state occurred
a second time, the verifier rejected the prog with
"infinite loop detected".

Now one state at the loop head covers all iterations of such a loop. This
shows that each iteration is safe, but not that the loop stops. Thus the
verifier adds may_goto to the loop, and may_goto stops the loop after
250 ms.

  the loop                        before                   now
  ------------------------------  -----------------------  ---------------
  has an exit, can spin forever   infinite loop detected   loads
  has no exit                     infinite loop detected,  loop at insn N
                                  program is too large     never exits
  is unsafe in a later iteration  rejected                 rejected, other
                                                           message

The tests run most of the progs of the first row: may_goto stops the loop,
and the prog returns 0. In the last row the verifier now sees the values of
all iterations as one range, for example -24 and -25. Thus it reports the
unsafe access with a different message.

Other changes:
 - unsafe_on_2nd_iter also wrote 8 bytes into 'char buf[4]', and the
   verifier finds this error first. Make the buffer 8 bytes long.
 - bpf_loop_iter_limit_nested compared two sums with a set of values. The
   verifier knows only their range. Compare them with the maximum.
 - bounded_recursion loads and returns 4, because the kernel limits
   recursion at run time.

In the log, the dump of the prog has no scc column, and the state of an
iterator has no depth. BPF_F_TEST_STATE_FREQ has no effect, thus many tests
drop it.

Add tests to verifier_scev.c for loops that scalar evolution can count. The
verifier verifies the body of such a loop one time, with ranges that cover
all iterations, or it verifies each iteration.

  in the loop                     verified        because
  ------------------------------  --------------  -------------------------
  'x &= y', 'w7 = w7'             one time        x stays in [0, max]
  'p += 8', p points to arena     one time        its offset is not tracked
  'x >>= 1', 'x /= 10', 'x %= y'  each iteration  progs need the smaller x
  'p += 1', p points to a buffer  each iteration  needs a constant offset

When the pointer to a buffer is also the counter, 'p < end', scalar
evolution counts the loop. Before, the verifier hit the limit of 1M insns.

'r <<= 32; r >>= 32' is a zero extension. 'r <<= 32; w >>= w2' with 32 in
w2 is not: the cpu shifts by 32 & 31, and the result is 0. The verifier
must reject progs that are unsafe only with this result. A register that is
the same constant in all iterations must stay a constant.

Add two progs to verifier_iterating_callbacks.c that have the call of
bpf_loop() at a loop head. The state that returns from the callback belongs
to the same iteration as the call.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |    4 +-
 tools/testing/selftests/bpf/progs/iters.c     |  112 +-
 .../selftests/bpf/progs/iters_state_safety.c  |    8 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |   12 +-
 .../selftests/bpf/progs/verifier_cfg.c        |    8 +-
 .../selftests/bpf/progs/verifier_idoms.c      |    5 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |  110 +-
 .../bpf/progs/verifier_loop_hierarchy.c       |  125 +-
 .../selftests/bpf/progs/verifier_loops1.c     |   14 +-
 .../selftests/bpf/progs/verifier_movsx.c      |    2 +-
 .../selftests/bpf/progs/verifier_scev.c       | 1103 ++++++++++++++++-
 11 files changed, 1277 insertions(+), 226 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 902a70d5afeb..2dc37090d7a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -154,9 +154,9 @@ void test_verif_scale_loop2()
 	scale_test("loop2.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
-void test_verif_scale_loop3_fail()
+void test_verif_scale_loop3()
 {
-	scale_test("loop3.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, true /* fails */);
+	scale_test("loop3.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_loop4()
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ae845ad747bf..fc2a5ab373a7 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -47,7 +47,7 @@ int iter_err_unsafe_c_loop(const void *ctx)
 }
 
 SEC("?raw_tp")
-__failure __msg("unbounded memory access")
+__failure __msg("math between map_value pointer and register with unbounded min value is not allowed")
 int iter_err_unsafe_asm_loop(const void *ctx)
 {
 	struct bpf_iter_num it;
@@ -878,19 +878,15 @@ __naked int delayed_read_mark(void)
 
 SEC("?raw_tp")
 __failure
-__msg("math between fp pointer and register with unbounded")
+__msg("21: (79) r8 = *(u64 *)(r0 +0)")
+__msg("misaligned stack access off -33+0 size 8")
 __naked int delayed_precision_mark(void)
 {
 	/* This is equivalent to C program below.
-	 * The test is similar to delayed_iter_mark but verifies that incomplete
-	 * precision don't fool verifier.
+	 * The test is similar to delayed_iter_mark.
 	 * The call to bpf_iter_num_next() is reachable with r7 values -16 and -32.
-	 * State with r7=-16 is visited first and follows r6 != 42 ... continue branch.
-	 * At this point iterator next() call is reached with r7 that has no read
-	 * and precision marks.
-	 * Loop body with r7=-32 would only be visited if verifier would decide to continue
-	 * with second loop iteration. Absence of precision mark on r7 might affect state
-	 * equivalent logic used for iterator convergence tracking.
+	 * The loop body with r7=-32 is only looked at if the verifier goes on
+	 * with the second iteration of the loop.
 	 *
 	 * r8 = 0
 	 * fp[-16] = 0
@@ -957,22 +953,18 @@ __naked int delayed_precision_mark(void)
 
 SEC("?raw_tp")
 __failure
-__msg("math between fp pointer and register with unbounded")
-__flag(BPF_F_TEST_STATE_FREQ)
+/* -24 or -25 */
+__msg("misaligned stack access off (0xffffffffffffffe0; 0xf)+0 size 8")
 __naked int loop_state_deps1(void)
 {
 	/* This is equivalent to C program below.
 	 *
 	 * The case turns out to be tricky in a sense that:
-	 * - states with c=-25 are explored only on a second iteration
-	 *   of the outer loop;
-	 * - states with read+precise mark on c are explored only on
-	 *   second iteration of the inner loop and in a state which
-	 *   is pushed to states stack first.
+	 * - c is -25 only on a second iteration of the outer loop;
+	 * - c is used only on a second iteration of the inner loop.
 	 *
-	 * Depending on the details of iterator convergence logic
-	 * verifier might stop states traversal too early and miss
-	 * unsafe c=-25 memory access.
+	 * The verifier might stop too early and miss unsafe c=-25
+	 * memory access.
 	 *
 	 *   j = iter_new();		 // fp[-16]
 	 *   a = 0;			 // r6
@@ -1082,23 +1074,18 @@ __naked int loop_state_deps1(void)
 
 SEC("?raw_tp")
 __failure
-__msg("math between fp pointer and register with unbounded")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("34: (0f) r0 += r8")
+__msg("makes fp pointer be out of bounds")
 __naked int loop_state_deps2(void)
 {
 	/* This is equivalent to C program below.
 	 *
 	 * The case turns out to be tricky in a sense that:
-	 * - states with read+precise mark on c are explored only on a second
-	 *   iteration of the first inner loop and in a state which is pushed to
-	 *   states stack first.
-	 * - states with c=-25 are explored only on a second iteration of the
-	 *   second inner loop and in a state which is pushed to states stack
-	 *   first.
+	 * - c is used only on a second iteration of the first inner loop;
+	 * - c is -25 only on a second iteration of the second inner loop.
 	 *
-	 * Depending on the details of iterator convergence logic
-	 * verifier might stop states traversal too early and miss
-	 * unsafe c=-25 memory access.
+	 * The verifier might stop too early and miss unsafe c=-25
+	 * memory access.
 	 *
 	 *   j = iter_new();             // fp[-16]
 	 *   a = 0;                      // r6
@@ -1259,49 +1246,39 @@ __naked int loop_state_deps2(void)
 
 SEC("?raw_tp")
 __failure
-__msg("math between fp pointer and register with unbounded")
-__flag(BPF_F_TEST_STATE_FREQ)
+/* -24 or -25 */
+__msg("misaligned stack access off (0xffffffffffffffe0; 0xf)+0 size 8")
 __naked int loop_state_deps3(void)
 {
 	/* This is equivalent to a C program below.
 	 *
-	 *   if (random() != 24) {       // assume false branch is placed first
+	 *   if (random() != 24) {
 	 *     i = iter_new();           // fp[-8]
 	 *     while (iter_next(i));
 	 *     iter_destroy(i);
 	 *     return;
 	 *   }
 	 *
-	 *   for (i = 10; i > 0; i--);   // increase dfs_depth for child states
+	 *   for (i = 10; i > 0; i--);
 	 *
 	 *   i = iter_new();             // fp[-8]
 	 *   b = -24;                    // r8
-	 *   for (;;) {                  // checkpoint (L)
-	 *     if (iter_next(i))         // checkpoint (N)
+	 *   for (;;) {
+	 *     if (iter_next(i))
 	 *       break;
-	 *     if (random() == 77) {     // assume false branch is placed first
+	 *     if (random() == 77) {
 	 *       *(u64 *)(r10 + b) = 7;  // this is not safe when b == -25
 	 *       iter_destroy(i);
 	 *       return;
 	 *     }
-	 *     if (random() == 42) {     // assume false branch is placed first
+	 *     if (random() == 42) {
 	 *       b = -25;
 	 *     }
 	 *   }
 	 *   iter_destroy(i);
 	 *
-	 * In case of a buggy verifier first loop might poison
-	 * env->cur_state->loop_entry with a state having 0 branches
-	 * and small dfs_depth. This would trigger NOT_EXACT states
-	 * comparison for some states within second loop.
-	 * Specifically, checkpoint (L) might be problematic if:
-	 * - branch with '*(u64 *)(r10 + b) = 7' is not explored yet;
-	 * - checkpoint (L) is first reached in state {b=-24};
-	 * - traversal is pruned at checkpoint (N) setting checkpoint's (L)
-	 *   branch count to 0, thus making it eligible for use in pruning;
-	 * - checkpoint (L) is next reached in state {b=-25},
-	 *   this would cause NOT_EXACT comparison with a state {b=-24}
-	 *   while 'b' is not marked precise yet.
+	 * What the verifier learned in the first two loops must not make it
+	 * take {b=-25} at the head of the third one for {b=-24}.
 	 */
 	asm volatile (
 		"call %[bpf_get_prandom_u32];"
@@ -1884,7 +1861,6 @@ __naked int absent_mark_in_the_middle_state2(void)
 }
 
 SEC("?raw_tp")
-__flag(BPF_F_TEST_STATE_FREQ)
 __failure __msg("misaligned stack access off -31+0 size 8")
 __naked int absent_mark_in_the_middle_state3(void)
 {
@@ -2014,8 +1990,8 @@ static int loop1_wrapper(void)
  * but adapted for use with bpf_loop().
  */
 SEC("raw_tp")
-__flag(BPF_F_TEST_STATE_FREQ)
-__failure __msg("math between fp pointer and register with unbounded min value is not allowed")
+/* -32 or -31 */
+__failure __msg("misaligned stack access off (0xffffffffffffffe0; 0x1)+0 size 8")
 __naked void absent_mark_in_the_middle_state4(void)
 {
 	/*
@@ -2159,8 +2135,7 @@ static int loop_cb5(int i, __u64 *ctx)
 }
 
 SEC("raw_tp")
-__flag(BPF_F_TEST_STATE_FREQ)
-__failure __msg("memory access is {{.*}} and is outside of the object of size 64")
+__failure __msg("invalid access to map value, value_size=64 off=402000 size=4")
 __naked void loop_counter_precision_2nd_iter(void)
 {
 	asm volatile (
@@ -2174,9 +2149,8 @@ __naked void loop_counter_precision_2nd_iter(void)
 		"r3 += -8;"
 		"r4 = 0;"
 		/*
-		 * Explore with nr_loops=1 on a first path and nr_loops=2 on a second path.
-		 * Buggy verifier did not propagate r1 precision properly,
-		 * and thus checkpoints created for nr_loops=1 case matched nr_loops=2 case.
+		 * nr_loops is 1 on one path and 2 on the other.
+		 * The second call of the callback must not be lost.
 		 */
 		"call %[bpf_loop];"
 		"r0 = 0;"
@@ -2190,12 +2164,12 @@ __naked void loop_counter_precision_2nd_iter(void)
 
 /*
  * An iterator that is destroyed and created again inside its loop starts from
- * the beginning and the loop never ends. In the first four progs the first
- * prune point after bpf_iter_num_new() is the call of bpf_iter_num_next().
+ * the beginning and the loop never ends. bpf_iter_num_next() is not what stops such
+ * loop: the verifier adds may_goto. The progs spin until it's out of budget.
  */
 SEC("socket")
 __description("iter: remake in the loop, jump to next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __naked void iter_remake_jmp(void)
 {
 	asm volatile (
@@ -2256,7 +2230,7 @@ __used __naked static void iter_remake(void)
 
 SEC("socket")
 __description("iter: remake in a callee, jump to next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __naked void iter_remake_callee_jmp(void)
 {
 	asm volatile (
@@ -2295,7 +2269,7 @@ __naked void iter_remake_callee_jmp(void)
 
 SEC("socket")
 __description("iter: remake after next, jump to next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __naked void iter_remake_after_next_jmp(void)
 {
 	asm volatile (
@@ -2336,7 +2310,7 @@ __naked void iter_remake_after_next_jmp(void)
 
 SEC("socket")
 __description("iter: two iterators, remake each after its next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __naked void iter_remake_two_jmp(void)
 {
 	asm volatile (
@@ -2398,7 +2372,7 @@ __naked void iter_remake_two_jmp(void)
 /* Same loops with a prune point in front of bpf_iter_num_next() */
 SEC("socket")
 __description("iter: remake in the loop")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void iter_remake_inline(void)
 {
@@ -2439,7 +2413,7 @@ __naked void iter_remake_inline(void)
 
 SEC("socket")
 __description("iter: remake in a callee")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void iter_remake_callee(void)
 {
@@ -2475,7 +2449,7 @@ __naked void iter_remake_callee(void)
 
 SEC("socket")
 __description("iter: remake after next")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void iter_remake_after_next(void)
 {
@@ -2515,7 +2489,7 @@ __naked void iter_remake_after_next(void)
 
 SEC("socket")
 __description("iter: remake when drained")
-__failure __msg("infinite loop detected")
+__success __retval(0)
 __flag(BPF_F_TEST_STATE_FREQ)
 __naked void iter_remake_drained(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/iters_state_safety.c b/tools/testing/selftests/bpf/progs/iters_state_safety.c
index b2ba4609a31e..fa9604f0a173 100644
--- a/tools/testing/selftests/bpf/progs/iters_state_safety.c
+++ b/tools/testing/selftests/bpf/progs/iters_state_safety.c
@@ -30,7 +30,7 @@ int force_clang_to_emit_btf_for_externs(void *ctx)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("fp-8=iter_num(id=1,state=active,depth=0)")
+__msg("fp-8=iter_num(id=1,state=active)")
 int create_and_destroy(void *ctx)
 {
 	struct bpf_iter_num iter;
@@ -207,8 +207,8 @@ static __noinline void subprog_with_iter(void)
 SEC("?raw_tp")
 __failure
 /* ensure there was a call to subprog, which might happen without __noinline */
-__msg("returning from callee:")
-__msg("Unreleased reference id=1")
+__msg("0: (85) call pc+2")
+__msg("Unreleased reference id=2 alloc_insn=7")
 int leak_iter_from_subprog_fail(void *ctx)
 {
 	subprog_with_iter();
@@ -218,7 +218,7 @@ int leak_iter_from_subprog_fail(void *ctx)
 
 SEC("?raw_tp")
 __success __log_level(2)
-__msg("fp-8=iter_num(id=1,state=active,depth=0)")
+__msg("fp-8=iter_num(id=1,state=active)")
 int valid_stack_reuse(void *ctx)
 {
 	struct bpf_iter_num iter;
diff --git a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
index d00888f6687a..88ce4b7a9c33 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod_seq.c
@@ -20,8 +20,8 @@ __s64 res_empty;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_empty(const void *ctx)
 {
@@ -38,8 +38,8 @@ __s64 res_full;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_full(const void *ctx)
 {
@@ -58,8 +58,8 @@ static volatile int zero = 0;
 
 SEC("raw_tp/sys_enter")
 __success __log_level(2)
-__msg("fp-16=iter_testmod_seq(id=1,state=active,depth=0)")
-__msg("fp-16=iter_testmod_seq(id=1,state=drained,depth=0)")
+__msg("fp-16=iter_testmod_seq(id=1,state=active)")
+__msg("fp-16=iter_testmod_seq(id=1,state=drained)")
 __msg("call bpf_iter_testmod_seq_destroy")
 int testmod_seq_truncated(const void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index b429fa7a08f5..e97e89ba3d68 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -138,8 +138,8 @@ l0_%=:	r1 = r0;					\
 
 SEC("socket")
 __description("conditional loop")
-__failure __msg("infinite loop detected")
-__msg_unpriv("back-edge")
+__success
+__failure_unpriv __msg_unpriv("back-edge")
 __naked void conditional_loop(void)
 {
 	asm volatile ("					\
@@ -175,7 +175,7 @@ l1_%=:	r8 += r4;					\
 
 SEC("socket")
 __description("unconditional loop after conditional jump")
-__failure __msg("infinite loop detected")
+__failure __msg("loop at insn 2 never exits")
 __failure_unpriv __msg_unpriv("back-edge from insn 3 to 2")
 __naked void uncond_loop_after_cond_jmp(void)
 {
@@ -201,7 +201,7 @@ static unsigned long never_ending_subprog()
 SEC("socket")
 __description("unconditional loop after conditional jump")
 /* infinite loop is detected *after* check_cfg() */
-__failure __msg("infinite loop detected")
+__failure __msg("loop at insn 6 never exits")
 __naked void uncond_loop_in_subprog_after_cond_jmp(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_idoms.c b/tools/testing/selftests/bpf/progs/verifier_idoms.c
index fdee6bced77b..78cc8650923a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_idoms.c
+++ b/tools/testing/selftests/bpf/progs/verifier_idoms.c
@@ -10,7 +10,7 @@
  * The immediate dominator is printed by log_program() as the numeric column
  * immediately before the "<insn#>:" field of every "Program dump" line:
  *
- *   Program dump (scc? loop_header? idom insn#: live_regs_before):
+ *   Program dump (loop_header? idom insn#: live_regs_before):
  *            -1   0: ....... (b7) r0 = 0     <- idom(0) = -1 (subprog entry)
  *             0   1: ....... (07) r0 += 1    <- idom(1) = 0
  *             ^^^^^^
@@ -311,13 +311,12 @@ __naked void entry_is_loop_header(void)
  * infinite loop, but the dump (and idoms) are printed before that.
  */
 SEC("socket")
-__failure
+__success
 __log_level(2)
 __msg("Program dump")
 __msg("{{.*}} -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
 __msg("{{.*}}  0   1: {{.*}} (a5) if r0 < 0xa goto pc-1")
 __msg("{{.*}}  1   2: {{.*}} (95) exit")
-__msg("infinite loop detected")
 __naked void self_loop(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index a76bce7278e7..a48b48fb2e51 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -45,7 +45,7 @@ SEC("?raw_tp")
 __failure __msg("R1 type=scalar expected=fp")
 int unsafe_on_2nd_iter(void *unused)
 {
-	char buf[4];
+	char buf[8];
 	struct buf_context loop_ctx = { .buf = buf };
 
 	bpf_loop(100, unsafe_on_2nd_iter_cb, &loop_ctx, 0);
@@ -94,7 +94,7 @@ static int loop_detection_cb(__u32 idx, struct num_context *ctx)
 }
 
 SEC("?raw_tp")
-__failure __msg("infinite loop detected")
+__failure __msg("loop at insn 12 never exits")
 int loop_detection(void *unused)
 {
 	struct num_context loop_ctx = { .i = 0 };
@@ -246,10 +246,9 @@ int bpf_loop_iter_limit_nested(void *unused)
 	/* This makes 'c' zero, but neither clang nor verifier know it. */
 	c /= 10;
 	/* Make sure that verifier does not visit 'impossible' states:
-	 * enumerate all possible callback visit masks.
+	 * one more call of any of the callbacks gives more than that.
 	 */
-	if (a != 0 && a != 1 && a != 11 && a != 101 && a != 111 &&
-	    b != 0 && b != 1 && b != 11 && b != 101 && b != 111)
+	if (a > 111 || b > 111)
 		asm volatile ("r0 /= 0;" ::: "r0");
 	return 1000 * a + b + c;
 }
@@ -291,9 +290,106 @@ static __naked void iter_limit_bug_cb(void)
 	);
 }
 
+static __naked __noinline __used void set_flag_cb(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"*(u64 *)(r2 + 0) = r1;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all
+	);
+}
+
+/*
+ * bpf_loop() is the head of a loop whose iterations are looked at one by one, because of r1.
+ * The callback comes back to it in the same iteration, the last one included.
+ */
+SEC("socket")
+__failure __msg("frame pointer is read only")
+__naked void callback_returns_to_loop_head(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 1;"
+	"r2 = %[set_flag_cb] ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"1:"
+	"call %[bpf_loop];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"if r1 == 0 goto 2f;"
+	"if r7 != 3 goto 2f;"
+	"r10 = 0;"
+	"2:"
+	"r7 += 1;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r7;"
+	"r2 = %[set_flag_cb] ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"if r7 < 4 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(set_flag_cb),
+	  __imm(bpf_loop)
+	: __clobber_all
+	);
+}
+
+/* r7 is 4 when the loop is left, and not before */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 = r7 {{.*}}R7=4")
+__naked void callback_returns_to_loop_head_ok(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 1;"
+	"r2 = %[set_flag_cb] ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"1:"
+	"call %[bpf_loop];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"if r1 == 0 goto 2f;"
+	"if r7 != 4 goto 2f;"
+	"r10 = 0;"
+	"2:"
+	"r7 += 1;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r7;"
+	"r2 = %[set_flag_cb] ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"if r7 < 4 goto 1b;"
+	"r0 = r7;"
+	"exit;"
+	:
+	: __imm_addr(set_flag_cb),
+	  __imm(bpf_loop)
+	: __clobber_all
+	);
+}
+
+/*
+ * may_goto doesn't leave the loop, so it's not what stops it. The address is greater than 10:
+ * the loop spins until may_goto that the verifier adds ends the prog.
+ */
 int tmp_var;
 SEC("socket")
-__failure __msg("infinite loop detected at insn 2")
+__success __retval(0)
 __naked void jgt_imm64_and_may_goto(void)
 {
 	asm volatile ("			\
@@ -310,7 +406,7 @@ l0_%=:	.byte 0xe5; /* may_goto */	\
 }
 
 SEC("socket")
-__failure __msg("infinite loop detected at insn 1")
+__success __retval(0)
 __naked void may_goto_self(void)
 {
 	asm volatile ("			\
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
index 0608e983d7fc..4f4e04d50bc7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
@@ -22,10 +22,10 @@ __success
 __log_level(2)
 __msg("loop at 1{{$}}")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")
-__msg("  1   1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
-__msg("          2   3: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("      2   3: {{.*}} (95) exit")
 __naked void loop_single(void)
 {
 	asm volatile ("					\
@@ -43,13 +43,13 @@ __log_level(2)
 __msg("loop at 1{{$}}")
 __msg("loop at 4{{$}}")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  2       0   1: {{.*}} (07) r0 += 1")
-__msg("  2   1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
-__msg("          2   3: {{.*}} (b7) r1 = 0")
-__msg("  1       3   4: {{.*}} (07) r1 += 1")
-__msg("  1   4   4   5: {{.*}} (a5) if r1 < 0xa goto pc-2")
-__msg("          5   6: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("      2   3: {{.*}} (b7) r1 = 0")
+__msg("      3   4: {{.*}} (07) r1 += 1")
+__msg("  4   4   5: {{.*}} (a5) if r1 < 0xa goto pc-2")
+__msg("      5   6: {{.*}} (95) exit")
 __naked void loop_two_independent(void)
 {
 	asm volatile ("					\
@@ -70,13 +70,13 @@ __log_level(2)
 __msg("loop at 1{{$}}")
 __msg("loop at 3, nested in 1")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")			/* outer loop header */
-__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")			/* outer loop insn */
-__msg("  1   1   2   3: {{.*}} (07) r1 += 1")			/* inner loop header */
-__msg("  1   3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")	/* inner loop insn */
-__msg("  1   1   4   5: {{.*}} (a5) if r0 < 0xa goto pc-5")	/* outer loop insn */
-__msg("          5   6: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")			/* outer loop header */
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")			/* outer loop insn */
+__msg("  1   2   3: {{.*}} (07) r1 += 1")			/* inner loop header */
+__msg("  3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")	/* inner loop insn */
+__msg("  1   4   5: {{.*}} (a5) if r0 < 0xa goto pc-5")	/* outer loop insn */
+__msg("      5   6: {{.*}} (95) exit")
 __naked void loop_nested(void)
 {
 	asm volatile ("					\
@@ -95,12 +95,12 @@ SEC("socket")
 __success
 __log_level(2)
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (85) call bpf_get_prandom_u32")
-__msg("          0   1: {{.*}} (25) if r0 > 0x0 goto pc+2")
-__msg("          1   2: {{.*}} (b7) r0 = 2")
-__msg("          2   3: {{.*}} (05) goto pc+1")
-__msg("          1   4: {{.*}} (b7) r0 = 3")
-__msg("          1   5: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (85) call bpf_get_prandom_u32")
+__msg("      0   1: {{.*}} (25) if r0 > 0x0 goto pc+2")
+__msg("      1   2: {{.*}} (b7) r0 = 2")
+__msg("      2   3: {{.*}} (05) goto pc+1")
+__msg("      1   4: {{.*}} (b7) r0 = 3")
+__msg("      1   5: {{.*}} (95) exit")
 __naked void fwd_edges_no_loop(void)
 {
 	asm volatile ("					\
@@ -123,16 +123,16 @@ __msg("loop at 1{{$}}")
 __msg("loop at 3, nested in 1")
 __msg("loop at 6, nested in 1")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")
-__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")
-__msg("  1   1   2   3: {{.*}} (07) r1 += 1")
-__msg("  1   3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")
-__msg("  1   1   4   5: {{.*}} (b7) r2 = 0")
-__msg("  1   1   5   6: {{.*}} (07) r2 += 1")
-__msg("  1   6   6   7: {{.*}} (a5) if r2 < 0x5 goto pc-2")
-__msg("  1   1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
-__msg("          8   9: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")
+__msg("  1   2   3: {{.*}} (07) r1 += 1")
+__msg("  3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")
+__msg("  1   4   5: {{.*}} (b7) r2 = 0")
+__msg("  1   5   6: {{.*}} (07) r2 += 1")
+__msg("  6   6   7: {{.*}} (a5) if r2 < 0x5 goto pc-2")
+__msg("  1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
+__msg("      8   9: {{.*}} (95) exit")
 __naked void loop_nested_siblings(void)
 {
 	asm volatile ("					\
@@ -157,16 +157,16 @@ __msg("loop at 1{{$}}")
 __msg("loop at 3, nested in 1")
 __msg("loop at 5, nested in 3")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")
-__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")
-__msg("  1   1   2   3: {{.*}} (07) r1 += 1")
-__msg("  1   3   3   4: {{.*}} (b7) r2 = 0")
-__msg("  1   3   4   5: {{.*}} (07) r2 += 1")
-__msg("  1   5   5   6: {{.*}} (a5) if r2 < 0x3 goto pc-2")
-__msg("  1   3   6   7: {{.*}} (a5) if r1 < 0x5 goto pc-5")
-__msg("  1   1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
-__msg("          8   9: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")
+__msg("  1   2   3: {{.*}} (07) r1 += 1")
+__msg("  3   3   4: {{.*}} (b7) r2 = 0")
+__msg("  3   4   5: {{.*}} (07) r2 += 1")
+__msg("  5   5   6: {{.*}} (a5) if r2 < 0x3 goto pc-2")
+__msg("  3   6   7: {{.*}} (a5) if r1 < 0x5 goto pc-5")
+__msg("  1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
+__msg("      8   9: {{.*}} (95) exit")
 __naked void loop_three_levels(void)
 {
 	asm volatile ("					\
@@ -189,14 +189,14 @@ __success
 __log_level(2)
 __msg("loop at 1")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (b7) r0 = 0")
-__msg("  1       0   1: {{.*}} (07) r0 += 1")
-__msg("  1   1   1   2: {{.*}} (bf) r1 = r0")
-__msg("  1   1   2   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
-__msg("  1   1   3   4: {{.*}} (b7) r1 = 1")
-__msg("  1   1   3   5: {{.*}} (0f) r0 += r1")
-__msg("  1   1   5   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
-__msg("          6   7: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (b7) r0 = 0")
+__msg("      0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (bf) r1 = r0")
+__msg("  1   2   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
+__msg("  1   3   4: {{.*}} (b7) r1 = 1")
+__msg("  1   3   5: {{.*}} (0f) r0 += r1")
+__msg("  1   5   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
+__msg("      6   7: {{.*}} (95) exit")
 __naked void loop_with_if_else(void)
 {
 	asm volatile ("					\
@@ -217,15 +217,15 @@ __success
 __log_level(2)
 __msg("loop at 3, irreducible")
 __msg("Program dump")
-__msg("         -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
-__msg("          0   1: {{.*}} (b7) r1 = 0")
-__msg("          1   2: {{.*}} (25) if r0 > 0x5 goto pc+2")
-__msg("  1       2   3: {{.*}} (b7) r1 = 1")
-__msg("  1   3   3   4: {{.*}} (05) goto pc+1")
-__msg("          2   5: {{.*}} (b7) r1 = 2")
-__msg("  1   3   2   6: {{.*}} (0f) r0 += r1")
-__msg("  1   3   6   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
-__msg("          7   8: {{.*}} (95) exit")
+__msg("     -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
+__msg("      0   1: {{.*}} (b7) r1 = 0")
+__msg("      1   2: {{.*}} (25) if r0 > 0x5 goto pc+2")
+__msg("      2   3: {{.*}} (b7) r1 = 1")
+__msg("  3   3   4: {{.*}} (05) goto pc+1")
+__msg("      2   5: {{.*}} (b7) r1 = 2")
+__msg("  3   2   6: {{.*}} (0f) r0 += r1")
+__msg("  3   6   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
+__msg("      7   8: {{.*}} (95) exit")
 __naked void loop_irreducible(void)
 {
 	asm volatile ("					\
@@ -244,10 +244,9 @@ __naked void loop_irreducible(void)
 }
 
 SEC("socket")
-__failure
+__success
 __log_level(2)
 __msg("loop at 1")
-__msg("infinite loop detected at insn 1")
 __naked void loop_self(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_loops1.c b/tools/testing/selftests/bpf/progs/verifier_loops1.c
index 48a966cda199..1071d29974b7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loops1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loops1.c
@@ -123,7 +123,7 @@ l0_%=:	exit;						\
 
 SEC("tracepoint")
 __description("infinite loop after a conditional jump")
-__failure __msg("program is too large")
+__failure __msg("loop at insn 2 never exits")
 __naked void loop_after_a_conditional_jump(void)
 {
 	asm volatile ("					\
@@ -135,10 +135,9 @@ l0_%=:	exit;						\
 "	::: __clobber_all);
 }
 
-SEC("tracepoint")
+SEC("xdp")
 __description("bounded recursion")
-__failure
-__msg("recursive call from")
+__success __retval(4)
 __naked void bounded_recursion(void)
 {
 	asm volatile ("					\
@@ -163,7 +162,7 @@ l0_%=:	call bounded_recursion__1;			\
 
 SEC("tracepoint")
 __description("infinite loop in two jumps")
-__failure __msg("loop detected")
+__failure __msg("loop at insn 1 never exits")
 __naked void infinite_loop_in_two_jumps(void)
 {
 	asm volatile ("					\
@@ -174,9 +173,10 @@ l0_%=:	if r0 < 4 goto l1_%=;				\
 "	::: __clobber_all);
 }
 
-SEC("tracepoint")
+/* It never ends on its own. may_goto that the verifier adds ends the prog. */
+SEC("xdp")
 __description("infinite loop: three-jump trick")
-__failure __msg("loop detected")
+__success __retval(0)
 __naked void infinite_loop_three_jump_trick(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 195b27a51224..280ccee33663 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -226,7 +226,7 @@ l0_%=:							\
 
 SEC("socket")
 __description("MOV32SX, S8, var_off u32_max")
-__failure __msg("infinite loop detected")
+__success
 __failure_unpriv __msg_unpriv("back-edge from insn 2 to 0")
 __naked void mov64sx_s32_varoff_1(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index b30802c9e9e3..f4ea854d3212 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -238,7 +238,7 @@ __naked void meet_agrees(void)
 }
 
 SEC("xdp")
-__failure
+__success __retval(0)
 __log_level(2)
 __msg_next("scev at header 1:")
 __msg_next("  r6=(any r6 (+ r6 1)) / ?")
@@ -1015,10 +1015,9 @@ POST_COND_TEST32(post32_lt_wrap,   "<",                    -4,    2,
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 10 ")
 __msg("loop header at 1, widening r0 to 0..9 step 1")
-__msg("processed 5 insns")
+__msg("processed 4 insns")
 __naked void post_cond_jlt(void)
 {
 	asm volatile ("					\
@@ -1030,8 +1029,8 @@ __naked void post_cond_jlt(void)
 }
 
 /*
- * Explore with r7=10 first, r7=4096 next.
- * Should trigger invalid stack read if r7 is marked precise.
+ * r7 is 10 on one path to the loop and 4096 on the other.
+ * Should trigger invalid stack read if the larger one counts.
  *
  *   r0 = 0;
  *   r6 = 0;
@@ -1046,11 +1045,7 @@ __naked void post_cond_jlt(void)
 SEC("xdp")
 __failure
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("loop header at 6, header_count is 10 ")
-__msg("mark_precise: frame0: parent state regs=r6,r7 stack=:")
-__msg("loop header at 6, widening r0 to 0..9 step 1")
-__msg("loop header at 6, header_count is 4096 ")
+__msg("loop header at 6, header_count is [0..4096] ")
 __msg("loop header at 6, widening r0 to 0..4095 step 1")
 __msg("invalid variable-offset read from stack R2")
 __naked void mark_bound_precise(void)
@@ -1076,8 +1071,8 @@ __naked void mark_bound_precise(void)
 }
 
 /*
- * Explore with r6=4086 first, r6=0 next.
- * Should trigger invalid stack read if r6 is marked precise.
+ * r6 is 4086 on one path to the loop and 0 on the other.
+ * Should trigger invalid stack read if the smaller one counts.
  *
  *   r0 = 0;
  *   r6 = bpf_get_prandom_u32() == 42 ? 4086 : 0;
@@ -1091,11 +1086,7 @@ __naked void mark_bound_precise(void)
 SEC("xdp")
 __failure
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("loop header at 5, header_count is 10 ")
-__msg("mark_precise: frame0: parent state regs=r6 stack=:")
-__msg("loop header at 5, widening r0 to 0..9 step 1")
-__msg("loop header at 5, header_count is 4096 ")
+__msg("loop header at 5, header_count is [0..4096] ")
 __msg("loop header at 5, widening r0 to 0..4095 step 1")
 __msg("invalid variable-offset read from stack R2")
 __naked void mark_base_precise(void)
@@ -1309,7 +1300,7 @@ __msg("scev at header 1:")
 __msg_next("r6=(+ r6 1) / (linear r6 1)")
 __msg_next("*fp-8=(any *fp-8 7) / (any *fp-8 7)")
 __msg("loop header at 1, widening r6 to 0..2 step 1")
-__msg("2: (7a) *(u64 *)(r10 -8) = 7          ; R10=fp0 fp-8=7 loop_stack=1")
+__msg("3: (79) r0 = *(u64 *)(r10 -8)         ; R0=scalar() R10=fp0 loop_stack=1")
 __naked void widen_any_unallocated_slot(void)
 {
 	asm volatile ("					\
@@ -1433,6 +1424,278 @@ __naked void latch_tests_a_32bit_copy(void)
 	::: __clobber_all);
 }
 
+/* The same, and the first value is not known */
+SEC("socket")
+__success
+__log_level(2)
+__msg("loop header at 3, header_count is [0..17]")
+__naked void latch_32bit_copy_from_a_range(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"w6 = w0;"
+	"if w6 > 16 goto 2f;"
+"1:"
+	"w1 = w6;"
+	"w6 += 1;"
+	"if w1 < 16 goto 1b;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* (u32)i the way clang does it for cpu v1 and v2: two 64-bit shifts by 32 */
+SEC("socket")
+__success __retval(16)
+__log_level(2)
+__msg("  r6=(zext32 (+ r6 1)) / (zext32 (linear r6 1))")
+__msg("loop header at 1, header_count is 16")
+__naked void two_shifts_by_32_are_zext32(void)
+{
+	asm volatile (
+	"r6 = 0;"
+"1:"
+	"r6 += 1;"
+	"r6 <<= 32;"
+	"r6 >>= 32;"
+	"if r6 < 16 goto 1b;"
+	"r0 = r6;"
+	"exit;"
+	::: __clobber_all);
+}
+
+const volatile __u64 rodata_32 = 32;
+
+/*
+ * A 32-bit shift by a register that has 32 in it shifts by 32 & 31 = 0. @shifts make 0 of r7,
+ * so r7 is 100 in the first iteration and 1 in the others. If they are taken for (u32)r7
+ * then r7 is in [100, 107] and the read of r9 looks like dead code.
+ */
+#define NO_ZEXT32_TEST(name, before, shifts)						\
+SEC("socket")										\
+__failure __msg("R9 !read_ok")								\
+__naked void name(void)									\
+{											\
+	asm volatile (									\
+	before										\
+	"r7 = 100;"									\
+	"r8 = 0;"									\
+"1:"											\
+	"if r7 >= 100 goto 2f;"								\
+	"r0 = *(u64 *)(r9 + 0);"							\
+"2:"											\
+	shifts										\
+	"w7 += 1;"									\
+	"r8 += 1;"									\
+	"if r8 < 8 goto 1b;"								\
+	"r0 = 0;"									\
+	"exit;"										\
+	:										\
+	: __imm_addr(rodata_32)								\
+	: __clobber_all);								\
+}
+
+NO_ZEXT32_TEST(rsh32_by_reg_32,      "",         "r7 <<= 32; r2 = 32; w7 >>= w2;")
+NO_ZEXT32_TEST(rsh32_by_wreg_32,     "",         "r7 <<= 32; w2 = 32; w7 >>= w2;")
+NO_ZEXT32_TEST(rsh32_by_16_plus_16,  "",         "r7 <<= 32; r2 = 16; r2 += 16; w7 >>= w2;")
+NO_ZEXT32_TEST(rsh32_by_32_or_32,    "",
+	       "r7 <<= 32; r2 = 32; if r8 == 5 goto +1; r2 = 32; w7 >>= w2;")
+NO_ZEXT32_TEST(rsh32_by_spilled_32,  "",
+	       "r7 <<= 32; r2 = 32; *(u64 *)(r10 - 8) = r2; r2 = *(u64 *)(r10 - 8); w7 >>= w2;")
+NO_ZEXT32_TEST(rsh32_by_stored_32,   "",
+	       "r7 <<= 32; *(u64 *)(r10 - 8) = 32; r2 = *(u32 *)(r10 - 8); w7 >>= w2;")
+NO_ZEXT32_TEST(rsh32_by_32_in_rodata, "",
+	       "r7 <<= 32; r2 = %[rodata_32] ll; r2 = *(u64 *)(r2 + 0); w7 >>= w2;")
+NO_ZEXT32_TEST(rsh32_by_32_set_before_the_loop, "r6 = 32;", "r7 <<= 32; w7 >>= w6;")
+NO_ZEXT32_TEST(rsh32_by_96,          "",         "r7 <<= 32; r2 = 96; w7 >>= w2;")
+NO_ZEXT32_TEST(rsh32_by_32_in_the_low_half, "",  "r7 <<= 32; r2 = 0x100000020 ll; w7 >>= w2;")
+NO_ZEXT32_TEST(arsh32_by_reg_32,     "",         "r7 <<= 32; r2 = 32; w7 s>>= w2;")
+/* here it's the shift to the left that does nothing */
+NO_ZEXT32_TEST(lsh32_by_reg_32,      "",         "r2 = 32; w7 <<= w2; r7 >>= 32;")
+
+/* 64-bit shifts by 32 do make (u32)r7 */
+#define IS_ZEXT32_TEST(name, msg, shifts)						\
+SEC("socket")										\
+__success __retval(108)									\
+__log_level(2)										\
+__msg("loop header at 2, " msg)							\
+__naked void name(void)									\
+{											\
+	asm volatile (									\
+	"r7 = 100;"									\
+	"r8 = 0;"									\
+"1:"											\
+	shifts										\
+	"w7 += 1;"									\
+	"r8 += 1;"									\
+	"if r8 < 8 goto 1b;"								\
+	"r0 = r7;"									\
+	"exit;"										\
+	::: __clobber_all);								\
+}
+
+IS_ZEXT32_TEST(shifts64_by_reg_32, "widening r7 to 100..107", "r2 = 32; r7 <<= r2; r7 >>= r2;")
+/* 96 & 63 is 32 as well, but the result of a shift by more than 63 is unknown to the verifier */
+IS_ZEXT32_TEST(rsh64_by_96,        "can't widen r7",          "r7 <<= 32; r2 = 96; r7 >>= r2;")
+/* and here nothing is shifted */
+IS_ZEXT32_TEST(shifts32_by_reg_32, "can't widen r7",          "r2 = 32; w7 <<= w2; w7 >>= w2;")
+
+/*
+ * The count is 32 for the cpu. The verifier doesn't know r0 after a shift by more than 63, so it
+ * goes on after the jump with r7 in [0, 1000]. A summary of r7 that starts at 0xffff and has the
+ * step -3 would have nothing in common with that.
+ */
+SEC("socket")
+__success __retval(0)
+__log_level(2)
+__msg("loop header at 2, can't widen r7")
+__naked void lsh64_by_96_makes_the_step(void)
+{
+	asm volatile (
+	"r7 = 0xffff;"
+	"r9 = 0;"
+"1:"
+	"r0 = 3;"
+	"r2 = 96;"
+	"r0 <<= r2;"
+	"r0 >>= 32;"
+	"w7 -= w0;"
+	"if w7 > 1000 goto 2f;"
+	"r9 += 1;"
+	"if r9 < 8 goto 1b;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* What the prog computes with '&' is left as it is */
+SEC("socket")
+__success __retval(70)
+__log_level(2)
+__msg("loop header at 2, can't widen r7, expr is (+ r7 (& 15 7))")
+__naked void and_of_constants_makes_the_step(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r8 = 0;"
+"1:"
+	"r4 = 15;"
+	"r4 &= 7;"
+	"r7 += r4;"
+	"r8 += 1;"
+	"if r8 < 10 goto 1b;"
+	"r0 = r7;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * r3 is 0, not 7: r1 stays 0 and it's r9 that ends the loop, after 1000 iterations and not after
+ * 10. r6 is 8000 then.
+ */
+SEC("socket")
+__failure __msg("R8 !read_ok")
+__naked void rsh32_by_reg_32_makes_the_step(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"r6 = 0;"
+	"r9 = 0;"
+"1:"
+	"r6 += 8;"
+	"r3 = 7;"
+	"r3 <<= 32;"
+	"r2 = 32;"
+	"w3 >>= w2;"
+	"r1 += r3;"
+	"r9 += 1;"
+	"if r9 > 999 goto 2f;"
+	"if r1 < 70 goto 1b;"
+"2:"
+	"if r6 <= 80 goto 3f;"
+	"r0 = *(u64 *)(r8 + 0);"
+"3:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The same when only the copy of r7 that is compared is shifted: r1 is 0 */
+SEC("socket")
+__failure __msg("R8 !read_ok")
+__naked void rsh32_by_reg_32_in_the_latch(void)
+{
+	asm volatile (
+	"r7 = 0;"
+	"r9 = 0;"
+"1:"
+	"r7 += 1;"
+	"r9 += 1;"
+	"if r9 > 999 goto 2f;"
+	"r1 = r7;"
+	"r1 <<= 32;"
+	"r2 = 32;"
+	"w1 >>= w2;"
+	"if r1 < 8 goto 1b;"
+"2:"
+	"if r7 <= 8 goto 3f;"
+	"r0 = *(u64 *)(r8 + 0);"
+"3:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The bound r4 is 0, not 8: the loop ends when r7 is 0 */
+SEC("socket")
+__failure __msg("R8 !read_ok")
+__naked void rsh32_by_reg_32_makes_the_bound(void)
+{
+	asm volatile (
+	"r7 = 20;"
+"1:"
+	"r7 -= 1;"
+	"r4 = 8;"
+	"r4 <<= 32;"
+	"r2 = 32;"
+	"w4 >>= w2;"
+	"if r7 > r4 goto 1b;"
+	"if r7 >= 8 goto 2f;"
+	"r0 = *(u64 *)(r8 + 0);"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * r7 is 1 at the jump, always: the loop has no count.
+ * The prog is not run: it never ends when it's loaded without may_goto.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("loop header at 1, can't compute iterations count")
+__not_msg("header_count is")
+__naked void rsh32_by_reg_32_never_ends(void)
+{
+	asm volatile (
+	"r7 = 100;"
+"1:"
+	"r7 <<= 32;"
+	"r2 = 32;"
+	"w7 >>= w2;"
+	"w7 += 1;"
+	"if w7 < 108 goto 1b;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
 const volatile __u32 rodata_bound = 10;
 
 /* for (i = 0; i < rodata_bound; i++): the bound is loaded in every iteration. */
@@ -1574,11 +1837,10 @@ __naked void eval_expr_unallocated_stack_bound(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 3, header_count is 8")
 __msg("loop header at 3, widening r0 to 2..9 step 1")
 __msg("3: R0=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=9,{{.*}})")
-__msg("processed 6 insns")
+__msg("processed 5 insns")
 __naked void post_cond_jlt_with_base(void)
 {
 	asm volatile ("					\
@@ -1612,11 +1874,10 @@ __naked void latch_base_differs_from_step(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 11")
 __msg("loop header at 1, widening r0 to 0..10 step 1")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=10,{{.*}})")
-__msg("processed 5 insns")
+__msg("processed 4 insns")
 __naked void post_cond_jle(void)
 {
 	asm volatile ("					\
@@ -1630,11 +1891,10 @@ __naked void post_cond_jle(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 10")
 __msg("loop header at 1, widening r0 to 0..9 step 1")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=9,{{.*}})")
-__msg("processed 6 insns")
+__msg("processed 5 insns")
 __naked void post_cond_jge(void)
 {
 	asm volatile ("					\
@@ -1649,11 +1909,10 @@ __naked void post_cond_jge(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("loop header at 1, header_count is 11")
 __msg("loop header at 1, widening r0 to 0..10 step 1")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=10,{{.*}})")
-__msg("processed 6 insns")
+__msg("processed 5 insns")
 __naked void pre_cond_jge(void)
 {
 	asm volatile ("					\
@@ -1668,7 +1927,6 @@ __naked void pre_cond_jge(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 1:")
 __msg_next("  r0=(+ r0 1) / (linear r0 1)")
 __msg_next(" scev at latch 2:")
@@ -1677,10 +1935,9 @@ __msg("loop header at 1, widening r0")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,{{.*}})")
 __msg("1: (07) r0 += 1                       ; R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,{{.*}})")
 __msg("2: (55) if r0 != 0x3 goto pc-2")
-__msg("3: (95) exit")
 __msg("loop header at 1, clamping r0")
-__msg("from 2 to 1: safe")
-__msg("processed 5 insns")
+__msg("3: (95) exit")
+__msg("processed 4 insns")
 __naked void post_cond_jne(void)
 {
 	asm volatile ("					\
@@ -1694,16 +1951,15 @@ __naked void post_cond_jne(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 1:")
 __msg_next("  r0=(+ r0 -1) / (linear r0 -1)")
 __msg_next(" scev at latch 2:")
 __msg_next("  r0=(+ r0 -1) / (linear (+ r0 -1) -1)")
 __msg("loop header at 1, header_count is 3 ")
 __msg("loop header at 1, widening r0 to 1..3 step 1")
-__msg("1: R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3)) loop_stack=1")
+__msg("1: R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,var_off=(0x0; 0x3)) R10=fp0 loop_stack=1")
 __msg("loop header at 1, clamping r0 to 1..2 (s32 1..2) step 1")
-__msg("processed 5 insns")
+__msg("processed 4 insns")
 __naked void post_cond_jne_neg_step(void)
 {
 	asm volatile ("					\
@@ -1717,7 +1973,6 @@ __naked void post_cond_jne_neg_step(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 1:")
 __msg_next("  r0=(+ r0 1) / (linear r0 1)")
 __msg_next(" scev at latch 1:")
@@ -1728,11 +1983,10 @@ __msg("1: (15) if r0 == 0x3 goto pc+2        ; R0=scalar(smin=smin32=0,smax=umax
 __msg("2: (07) r0 += 1                       ; R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,{{.*}})")
 __msg("3: (05) goto pc-3")
 __msg("loop header at 1, clamping r0")
-__msg("1: safe")
 __msg("from 1 to 4: R0=3")
 __msg("4: R0=3")
 __msg("4: (95) exit")
-__msg("processed 6 insns")
+__msg("processed 5 insns")
 __naked void pre_cond_je1(void)
 {
 	asm volatile ("					\
@@ -1747,7 +2001,6 @@ __naked void pre_cond_je1(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 1:")
 __msg_next("  r0=(zext32 (+ r0 1)) / (zext32 (linear r0 1))")
 __msg_next(" scev at latch 2:")
@@ -1756,10 +2009,9 @@ __msg("loop header at 1, widening r0")
 __msg("1: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,{{.*}})")
 __msg("1: (04) w0 += 1                       ; R0=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=3,{{.*}})")
 __msg("2: (56) if w0 != 0x3 goto pc-2")
-__msg("3: (95) exit")
 __msg("loop header at 1, clamping r0")
-__msg("from 2 to 1: safe")
-__msg("processed 5 insns")
+__msg("3: (95) exit")
+__msg("processed 4 insns")
 __naked void post_cond_jne32(void)
 {
 	asm volatile ("					\
@@ -1995,7 +2247,6 @@ __naked void one_backedge_two_exits(void)
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg_next("scev at header 11:")
 __msg_next("  r0=(+ r0 1) / (linear r0 1)")
 __msg_next("  r1=(+ r1 2) / (linear r1 2)")
@@ -2005,18 +2256,15 @@ __msg_next("  r1=(+ r1 2) / (linear (+ r1 2) 2)")
 __msg("loop header at 11, widening r0")
 __msg("loop header at 11, widening r1")
 __msg("11: R0=scalar(smin=smin32=0,smax=umax=smax32=umax32=7,var_off=(0x0; 0x7)) R1=scalar(smin=smin32=0,smax=umax=smax32=umax32=14,var_off=(0x0; 0xe),step=0+2)")
-/* loop exit */
 __msg("16: (a5) if r0 < 0x8 goto pc-6")
-__msg("exiting loop 11")
-__msg("17: (95) exit")
 /* second iteration */
 __msg("loop header at 11, clamping r0")
 __msg("loop header at 11, clamping r1")
 /* iteration convergence */
-__msg("from 16 to 11: safe")
 __not_msg("{{^}}11:")
-/* map lookup error path */
-__msg("from 7 to 17: safe")
+/* loop exit */
+__msg("exiting loop 11")
+__msg("17: (95) exit")
 __naked void correlated_regs(void)
 {
 	asm volatile ("					\
@@ -2050,15 +2298,14 @@ __naked void correlated_regs(void)
  *     k += 1
  *     k <<= 1   // make SCEV construction not possible
  *     k >>= 1
- * map[k] = 1    // make k precise
+ * map[k] = 1    // k has to be known
  */
 SEC("xdp")
 __success
 __log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
 __msg("19: (72) *(u8 *)(r4 +0) = 1           ; R4=map_value(id={{.*}},map=map,ks=4,vs=1024,imm=16)")
 __not_msg("19: ")
-__msg("processed 106 insns")
+__msg("processed 105 insns")
 __naked void nested_loops_precise_var1(void)
 {
 	asm volatile ("					\
@@ -2097,8 +2344,7 @@ __log_level(2)
 __msg("loop header at 2, header_count is 100 ")
 __msg("loop header at 4, header_count is [0..100] ")
 __msg("loop header at 6, header_count is [0..100] ")
-__msg("processed 20 insns")
-__flag(BPF_F_TEST_STATE_FREQ)
+__msg("processed 14 insns")
 __naked void nested_loop_with_two_exits(void)
 {
 	asm volatile ("					\
@@ -2159,14 +2405,14 @@ __msg("loop at 5")
 __msg("loop at 6, nested in 5")
 __msg("loop at 11, irreducible")
 __msg("loop at 12, nested in 11")
-/* entry via if r0 == 5 goto d_%= false branch */
+/* entry via if r0 == 5 goto d_%= true branch */
 __msg("loop header at 12, header_count is 3 ")
 __msg("loop header at 12, widening r9 to 0..2 step 1")
-__msg("12: R8=1 R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3)) loop_stack=11,12")
-/* entry via if r0 == 5 goto d_%= true branch */
+/* entry via if r0 == 5 goto d_%= false branch */
 __msg("loop header at 12, header_count is 3 ")
 __msg("loop header at 12, widening r9 to 0..2 step 1")
-__msg("from 8 to 12: R8=0 R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3)) R10=fp0 loop_stack=11,12")
+__msg("12: R8=0 R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3)) R10=fp0 loop_stack=11,12")
+__msg("12: R8=1 R9=scalar(smin=smin32=0,smax=umax=smax32=umax32=2,var_off=(0x0; 0x3)) R10=fp0 loop_stack=11,12")
 __naked void enter_nested_loop_from_side(void)
 {
 	asm volatile ("					\
@@ -3459,12 +3705,23 @@ exit_%=:						\
  *        } while (r8 < 3);
  *    }
  *    return 0;
+ *
+ * The outer loop gets may_goto in front of the jump that leaves it, the inner loop doesn't.
+ * At run time it's may_goto that ends the prog.
  */
 SEC("xdp")
-__failure
-__log_level(2)
-__flag(BPF_F_TEST_STATE_FREQ)
-__msg("infinite loop detected at insn 6")
+__success __retval(0)
+__xlated("call unknown")
+__xlated("...")
+__xlated("if r0 == 0x2a goto pc+4")
+__xlated("r8 = 0")
+__xlated("r8 += 1")
+__xlated("if r8 < 0x3 goto pc-2")
+__xlated("goto pc-{{[0-9]+}}")
+__xlated("r0 = 0")
+__xlated("exit")
+__xlated("r0 = 0")
+__xlated("exit")
 __naked void nested_terminating_prune(void)
 {
 	asm volatile ("					\
@@ -3561,6 +3818,732 @@ __naked void dominating_exit_bounds_count(void)
 "	::: __clobber_all);
 }
 
+/*
+ * 'x &= e' has no linear formula. [0, max] that loses bits is in [0, max]: the state that enters the
+ * loop stands for all iterations.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("header_count is 16")
+__msg("r6 stays in 0..65535, it loses bits only")
+__naked void and_loses_bits(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 0xffff;					\
+	r7 = 0;						\
+1:	r1 = 1;						\
+	r1 <<= r7;					\
+	r1 ^= -1;					\
+	r6 &= r1;					\
+	r7 += 1;					\
+	if r7 < 16 goto 1b;				\
+	if r6 > 0xffff goto 2f;				\
+	r0 = 0;						\
+	exit;						\
+2:	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* r7 enters as [0, max]. After the loop it's at most 'after'. */
+#define LOSES_BITS_TEST(name, init, op, count, max, after)			\
+SEC("socket")									\
+__success __log_level(2)							\
+__msg("header_count is " #count)						\
+__msg("r7 stays in 0.." #max ", it loses bits only")				\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"call %[bpf_get_prandom_u32];"						\
+	"r8 = r0;"								\
+	"call %[bpf_get_prandom_u32];"						\
+	init									\
+	"r6 = 0;"								\
+"1:"										\
+	op									\
+	"r6 += 1;"								\
+	"if r6 < " #count " goto 1b;"						\
+	"r5 = " #after " ll;"							\
+	"if r7 > r5 goto 2f;"							\
+	"r0 = 0;"								\
+	"exit;"									\
+"2:"										\
+	"r0 = *(u64 *)(r7 + 0);"						\
+	"exit;"									\
+	:									\
+	: __imm(bpf_get_prandom_u32)						\
+	: __clobber_all);							\
+}
+
+LOSES_BITS_TEST(and_reg, "r7 = r0; r7 &= 255;", "r7 &= r8;", 8, 255, 255)
+LOSES_BITS_TEST(and_reg32, "r7 = r0; r7 &= 255;", "w7 &= w8;", 8, 255, 255)
+LOSES_BITS_TEST(and_max_100, "r7 = r0; r7 %%= 101;", "r7 &= r8;", 8, 100, 100)
+LOSES_BITS_TEST(zext8, "r7 = r0; r7 &= 0xffff;", "r7 &= 255;", 8, 65535, 255)
+LOSES_BITS_TEST(zext32, "r7 = r0; r7 <<= 32; r7 |= r8; r7 >>= 8;", "w7 = w7;", 8,
+		72057594037927935, 0xffffffff)
+/* nothing, '&' in 32 bits and a zero extension, a zero extension: three paths */
+LOSES_BITS_TEST(masks_on_three_paths, "r7 = r0; r7 &= 0xffff;",
+		"if r8 == 0 goto +3; if r8 == 1 goto +1; w7 &= w8; r7 &= 0xfff;", 8, 65535, 65535)
+/* too long to unroll */
+LOSES_BITS_TEST(and_reg_long, "r7 = r0; r7 &= 255;", "r7 &= r8;", 1000000, 255, 255)
+
+/* The same in the stack. */
+SEC("socket")
+__success __log_level(2)
+__msg("header_count is 8")
+__msg("*fp-8 stays in 0..255, it loses bits only")
+__naked void and_reg_spilled(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 255;					\
+	*(u64 *)(r10 - 8) = r0;				\
+	r6 = 0;						\
+1:	call %[bpf_get_prandom_u32];			\
+	r7 = *(u64 *)(r10 - 8);				\
+	r7 &= r0;					\
+	*(u64 *)(r10 - 8) = r7;				\
+	r6 += 1;					\
+	if r6 < 8 goto 1b;				\
+	r7 = *(u64 *)(r10 - 8);				\
+	if r7 > 255 goto 2f;				\
+	r0 = 0;						\
+	exit;						\
+2:	r0 = *(u64 *)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("R7 invalid mem access 'scalar'")
+__naked void and_reg_is_not_below_max(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	r7 &= 255;					\
+	r6 = 0;						\
+1:	call %[bpf_get_prandom_u32];			\
+	r7 &= r0;					\
+	r6 += 1;					\
+	if r6 < 8 goto 1b;				\
+	if r7 > 254 goto 2f;				\
+	r0 = 0;						\
+	exit;						\
+2:	r0 = *(u64 *)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* r8 is a copy of r7 in the first iteration only. */
+SEC("socket")
+__failure __msg("R7 invalid mem access 'scalar'")
+__naked void and_reg_is_not_its_copy(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	r7 &= 255;					\
+	r8 = r7;					\
+	r6 = 0;						\
+1:	if r8 < 200 goto 3f;				\
+	if r7 >= 200 goto 2f;				\
+	r0 = *(u64 *)(r7 + 0);				\
+2:	call %[bpf_get_prandom_u32];			\
+	r7 &= r0;					\
+	r6 += 1;					\
+	if r6 < 8 goto 1b;				\
+3:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Shifts to the right, division and modulo don't make a number greater, but there is no formula
+ * for them: iterations one by one tell more.
+ */
+SEC("socket")
+__success __log_level(2)
+__msg("header_count is 8")
+__msg("can't widen r6, expr is (any")
+__not_msg("it loses bits only")
+__naked void shift_div_mod_are_unrolled(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 0xfff;					\
+	call %[bpf_get_prandom_u32];			\
+	r8 = r0;					\
+	r7 = 0;						\
+1:	if r8 == 1 goto 2f;				\
+	if r8 == 2 goto 3f;				\
+	if r8 == 3 goto 4f;				\
+	r6 >>= 1;					\
+	goto 5f;					\
+2:	w6 /= w8;					\
+	goto 5f;					\
+3:	r6 %%= r8;					\
+	goto 5f;					\
+4:	w6 >>= 2;					\
+5:	r7 += 1;					\
+	if r7 < 8 goto 1b;				\
+	if r6 > 0xfff goto 6f;				\
+	r0 = 0;						\
+	exit;						\
+6:	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* The count and the divisor are registers, with bits that a 32-bit insn does not look at. */
+SEC("socket")
+__success __retval(0) __log_level(2)
+__msg("header_count is 8")
+__not_msg("it loses bits only")
+__naked void shift_div_mod_by_reg(void)
+{
+	asm volatile ("					\
+	r6 = 0x300000064 ll;				\
+	r7 = r6;					\
+	r8 = r6;					\
+	r9 = r6;					\
+	r1 = 0;						\
+1:	r2 = 33;					\
+	w6 >>= w2;					\
+	r2 = 65;					\
+	r7 >>= r2;					\
+	r2 = 0x100000000 ll;				\
+	w8 /= w2;					\
+	w9 %%= w2;					\
+	r1 += 1;					\
+	if r1 < 8 goto 1b;				\
+	r0 = 1;						\
+	if r6 != 0 goto 2f;				\
+	if r7 != 0x3000000 goto 2f;			\
+	if r8 != 0 goto 2f;				\
+	if r9 != 0x64 goto 2f;				\
+	r0 = 0;						\
+2:	exit;						\
+"	::: __clobber_all);
+}
+
+/* A shift to the left, an arithmetic shift and a signed division can make the number greater. */
+SEC("socket")
+__success __log_level(2)
+__msg("can't widen r6, expr is (<< r6 1)")
+__not_msg("it loses bits only")
+__naked void shift_left_grows(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 0xf;					\
+	r7 = 0;						\
+1:	r6 <<= 1;					\
+	r7 += 1;					\
+	if r7 < 8 goto 1b;				\
+	r0 = r6;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __log_level(2)
+__msg("can't widen r6, expr is (s>> r6 1)")
+__msg("can't widen r8, expr is (s/ r8 -1)")
+__not_msg("it loses bits only")
+__naked void signed_ops_grow(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 &= 0xf;					\
+	r8 = r6;					\
+	r7 = 0;						\
+1:	r6 s>>= 1;					\
+	r8 s/= -1;					\
+	r7 += 1;					\
+	if r7 < 8 goto 1b;				\
+	r0 = r6;					\
+	r0 += r8;					\
+	r0 &= 1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The size is never 0: bpf_skb_load_bytes() doesn't take 0. [0, max at the entry] has a 0 in it
+ * that is made up, so the loop is unrolled.
+ */
+#define SIZE_TEST(name, init, op, count, expr)					\
+SEC("tc")									\
+__success __log_level(2)							\
+__msg("header_count is " #count)						\
+__msg("can't widen r7, expr is " expr)						\
+__not_msg("it loses bits only")							\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r9 = r1;"								\
+	"call %[bpf_get_prandom_u32];"						\
+	init									\
+	"r6 = 0;"								\
+"1:"										\
+	"r1 = r9;"								\
+	"r2 = 0;"								\
+	"r3 = r10;"								\
+	"r3 += -128;"								\
+	"r4 = r7;"								\
+	"call %[bpf_skb_load_bytes];"						\
+	op									\
+	"r6 += 1;"								\
+	"if r6 < " #count " goto 1b;"						\
+	"r0 = 0;"								\
+	"exit;"									\
+	:									\
+	: __imm(bpf_get_prandom_u32), __imm(bpf_skb_load_bytes)			\
+	: __clobber_all);							\
+}
+
+/* 8, 4, 2, 1 */
+SIZE_TEST(halve_const, "r7 = 8;", "r7 >>= 1;", 4, "(>> r7 1)")
+SIZE_TEST(halve_const32, "r7 = 64;", "w7 >>= 1;", 6, "(zext32 (>> r7 1))")
+SIZE_TEST(divide_const, "r7 = 100;", "r7 /= 10;", 3, "(/ r7 10)")
+/* [64, 127], [32, 63], [16, 31] */
+SIZE_TEST(halve_range, "r7 = r0; r7 &= 63; r7 |= 64;", "r7 >>= 1;", 3, "(>> r7 1)")
+/* 8 or 9 */
+SIZE_TEST(halve_two_values, "r7 = r0; r7 &= 1; r7 |= 8;", "r7 >>= 1;", 4, "(>> r7 1)")
+/* 8 or 16 */
+SIZE_TEST(halve_one_of_two, "r7 = 8; if r0 == 0 goto +1; r7 = 16;", "r7 >>= 1;", 4, "(>> r7 1)")
+/* it loses bits only, but it doesn't enter as [0, max]. The loop doesn't change it. */
+SIZE_TEST(mask_keeps_range, "r7 = r0; r7 &= 63; r7 |= 64;", "r7 &= 127;", 3, "(& r7 127)")
+SIZE_TEST(mov32_keeps_range, "r7 = r0; r7 &= 63; r7 |= 64;", "w7 = w7;", 3, "(zext32 r7)")
+
+/* The same, the size is in the stack. */
+SEC("tc")
+__success __log_level(2)
+__msg("header_count is 4")
+__msg("can't widen *fp-136, expr is (>> *fp-136 1)")
+__not_msg("it loses bits only")
+__naked void halve_const_spilled(void)
+{
+	asm volatile ("					\
+	r9 = r1;					\
+	r7 = 8;						\
+	*(u64 *)(r10 - 136) = r7;			\
+	r6 = 0;						\
+1:	r1 = r9;					\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -128;					\
+	r4 = *(u64 *)(r10 - 136);			\
+	call %[bpf_skb_load_bytes];			\
+	r7 = *(u64 *)(r10 - 136);			\
+	r7 >>= 1;					\
+	*(u64 *)(r10 - 136) = r7;			\
+	r6 += 1;					\
+	if r6 < 4 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_skb_load_bytes)
+	: __clobber_all);
+}
+
+/*
+ * A number that is divided gets smaller and smaller. Only iterations one by one tell how small it
+ * is after the loop, also when it enters as [0, max].
+ */
+#define DIVIDED_TEST(name, init, op, count, max)				\
+SEC("socket")									\
+__success __log_level(2)							\
+__msg("header_count is " #count)						\
+__msg("can't widen r7")								\
+__not_msg("it loses bits only")							\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"call %[bpf_get_prandom_u32];"						\
+	"r8 = r0;"								\
+	init									\
+	"r6 = 0;"								\
+"1:"										\
+	op									\
+	"r6 += 1;"								\
+	"if r6 < " #count " goto 1b;"						\
+	"if r7 > " #max " goto 2f;"						\
+	"r0 = 0;"								\
+	"exit;"									\
+"2:"										\
+	"r0 = *(u64 *)(r7 + 0);"						\
+	"exit;"									\
+	:									\
+	: __imm(bpf_get_prandom_u32)						\
+	: __clobber_all);							\
+}
+
+DIVIDED_TEST(shift_out_const, "r7 = 255;", "r7 >>= 1;", 8, 0)
+DIVIDED_TEST(shift_out_range, "r7 = r0; r7 &= 255;", "r7 >>= 1;", 8, 0)
+DIVIDED_TEST(shift_out_range32, "r7 = r0; r7 &= 255;", "w7 >>= 1;", 8, 0)
+DIVIDED_TEST(div10_range, "r7 = r0; r7 &= 0xffff;", "r7 /= 10;", 3, 65)
+DIVIDED_TEST(divided_on_all_paths, "r7 = r0; r7 &= 255;",
+	     "if r8 == 0 goto +2; r7 >>= 1; goto +1; w7 /= 3;", 8, 0)
+/* the other operand is a register */
+DIVIDED_TEST(shift_by_const_reg, "r7 = r0; r7 &= 255; r5 = 1;", "r7 >>= r5;", 8, 0)
+DIVIDED_TEST(div_by_const_reg, "r7 = r0; r7 &= 255; r5 = 2;", "r7 /= r5;", 8, 0)
+/* 0 + 1 + 2 + 3 + 4 bits */
+DIVIDED_TEST(shift_by_counter, "r7 = r0; r7 &= 255;", "r7 >>= r6;", 5, 0)
+/* the last one is % 1 */
+DIVIDED_TEST(mod_by_counter, "r7 = r0; r7 &= 255;", "r5 = 8; r5 -= r6; r7 %%= r5;", 8, 0)
+/* together with what loses bits */
+DIVIDED_TEST(shift_then_and, "r7 = r0; r7 &= 255;", "r7 >>= 1; r7 &= r8;", 8, 0)
+DIVIDED_TEST(and_then_shift, "r7 = r0; r7 &= 255;", "r7 &= r8; r7 >>= 1;", 8, 0)
+DIVIDED_TEST(shift_then_zext, "r7 = r0; r7 &= 255;", "r7 >>= 1; w7 = w7;", 8, 0)
+/* divided on one of two paths */
+DIVIDED_TEST(divided_on_one_path, "r7 = r0; r7 &= 255;", "if r8 == 0 goto +1; r7 >>= 1;", 8, 255)
+
+SEC("socket")
+__success __log_level(2)
+__msg("header_count is 3")
+__msg("can't widen *fp-8, expr is (/ *fp-8 10)")
+__not_msg("it loses bits only")
+__naked void div10_range_spilled(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xffff;					\
+	*(u64 *)(r10 - 8) = r0;				\
+	r6 = 0;						\
+1:	r7 = *(u64 *)(r10 - 8);				\
+	r7 /= 10;					\
+	*(u64 *)(r10 - 8) = r7;				\
+	r6 += 1;					\
+	if r6 < 3 goto 1b;				\
+	r7 = *(u64 *)(r10 - 8);				\
+	if r7 > 65 goto 2f;				\
+	r0 = 0;						\
+	exit;						\
+2:	r0 = *(u64 *)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* In the second iteration r7 is at most 9 at the head. */
+SEC("socket")
+__success __log_level(2)
+__msg("header_count is [0..3]")
+__msg("can't widen r7, expr is (% r7 10)")
+__naked void mod_at_the_head(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	r7 &= 0xffff;					\
+	r6 = 0;						\
+1:	if r6 == 0 goto 2f;				\
+	if r7 > 9 goto 3f;				\
+2:	r7 %%= 10;					\
+	r6 += 1;					\
+	if r6 < 3 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+3:	r0 = *(u64 *)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* r7 is 0 or 64, 'r7 &= r0' keeps it so. 1..63 are made up in [0, 64]. */
+SEC("socket")
+__success __log_level(2)
+__msg("header_count is 4")
+__msg("can't widen r7, expr is (& r7 ?)")
+__not_msg("it loses bits only")
+__naked void and_keeps_known_bits(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r7 = r0;					\
+	r7 &= 64;					\
+	r6 = 0;						\
+1:	call %[bpf_get_prandom_u32];			\
+	r7 &= r0;					\
+	r6 += 1;					\
+	if r6 < 4 goto 1b;				\
+	r7 &= 63;					\
+	if r7 != 0 goto 2f;				\
+	r0 = 0;						\
+	exit;						\
+2:	r0 = *(u64 *)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * r7 has no formula: the verifier has no bounds for 'x op= unknown'. The loop is unrolled, and
+ * the pointer in r6, which moves in each iteration, keeps its offset.
+ */
+#define PTR_TEST(name, op, add, count)						\
+SEC("socket")									\
+__success __log_level(2)							\
+__msg("header_count is " #count)						\
+__not_msg(": widened")								\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	"r1 = 0;"								\
+	"*(u64*)(r10 - 8) = r1;"						\
+	"r2 = r10;"								\
+	"r2 += -8;"								\
+	"r1 = %[map] ll;"							\
+	"call %[bpf_map_lookup_elem];"						\
+	"if r0 == 0 goto 2f;"							\
+	"r6 = r0;"								\
+	"r9 = r0;"								\
+	"r7 = *(u64 *)(r9 + 512);"						\
+	"r7 &= 0xff;"								\
+	"r1 = 0;"								\
+"1:"										\
+	"*(u8 *)(r6 + 0) = r7;"							\
+	"r6 += " #add ";"							\
+	"r3 = *(u64 *)(r9 + 520);"						\
+	op									\
+	"r1 += 1;"								\
+	"if r1 < " #count " goto 1b;"						\
+"2:"										\
+	"r0 = 0;"								\
+	"exit;"									\
+	:									\
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)				\
+	: __clobber_all);							\
+}
+
+PTR_TEST(ptr_rsh_2, "r7 >>= r3;", 8, 2)
+PTR_TEST(ptr_rsh32_2, "w7 >>= w3;", 8, 2)
+PTR_TEST(ptr_div_2, "r7 /= r3;", 8, 2)
+PTR_TEST(ptr_mod_2, "r7 %%= r3;", 8, 2)
+PTR_TEST(ptr_div_2_step1, "r7 /= r3;", 1, 2)
+PTR_TEST(ptr_div_2_step2, "r7 /= r3;", 2, 2)
+PTR_TEST(ptr_div_2_step3, "r7 /= r3;", 3, 2)
+PTR_TEST(ptr_div_3_step3, "r7 /= r3;", 3, 3)
+PTR_TEST(ptr_rsh_10, "r7 >>= r3;", 8, 10)
+/* what loses bits returns within [0, 255] */
+PTR_TEST(ptr_and_2, "r7 &= r3;", 8, 2)
+PTR_TEST(ptr_and32_2, "w7 &= w3;", 8, 2)
+PTR_TEST(ptr_zext8_2, "r7 &= 255;", 8, 2)
+
+/* The pointer is in the stack. */
+SEC("socket")
+__success __log_level(2)
+__msg("header_count is 2")
+__not_msg(": widened")
+__naked void ptr_rsh_2_spilled(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	*(u64 *)(r10 - 16) = r0;			\
+	r9 = r0;					\
+	r7 = *(u64 *)(r9 + 512);			\
+	r7 &= 0xff;					\
+	r1 = 0;						\
+1:	r6 = *(u64 *)(r10 - 16);			\
+	*(u8 *)(r6 + 0) = r7;				\
+	r6 += 8;					\
+	*(u64 *)(r10 - 16) = r6;			\
+	r3 = *(u64 *)(r9 + 520);			\
+	r7 >>= r3;					\
+	r1 += 1;					\
+	if r1 < 2 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+/*
+ * bpf_compute_const_regs() knows what r7 is in the whole loop, and r8 that is made of it. If r7 gets
+ * a range, or is forgotten because the loop is too long to unroll, then r8 can be 0, the jump finds
+ * that, and do_check() sees a constant that is not the one it has to be. r0 is 0 for the main
+ * pass only.
+ */
+#define CONST_REGS_TEST(name, init, op, probe, count, val)			\
+SEC("socket")									\
+__success __retval(val) __log_level(2)						\
+__msg("header_count is " #count)						\
+__not_msg("wid{{(ening|en)}} r7")						\
+__naked void name(void)								\
+{										\
+	asm volatile (								\
+	init									\
+	"r6 = 0;"								\
+"1:"										\
+	op									\
+	probe									\
+	"call %[bpf_get_prandom_u32];"						\
+	"if r0 != 0 goto 2f;"							\
+	"if r8 != r0 goto 2f;"							\
+	"*(u64 *)(r10 - 8) = r8;"						\
+"2:"										\
+	"r6 += 1;"								\
+	"if r6 < " #count " goto 1b;"						\
+	"r0 = r8;"								\
+	"exit;"									\
+	:									\
+	: __imm(bpf_get_prandom_u32)						\
+	: __clobber_all);							\
+}
+
+CONST_REGS_TEST(const_regs_and, "r7 = 17;", "r7 &= 31;", "r8 = r7;", 10, 17)
+CONST_REGS_TEST(const_regs_mov32, "r7 = 17;", "w7 = w7;", "r8 = r7;", 10, 17)
+CONST_REGS_TEST(const_regs_add_sub32, "r7 = 17;", "w7 += 1; w7 += -1;", "r8 = r7;", 10, 17)
+/* too long to unroll */
+CONST_REGS_TEST(const_regs_and_long, "r7 = 17;", "r7 &= 31;", "r8 = r7;", 1000000, 17)
+CONST_REGS_TEST(const_regs_mov32_long, "r7 = 17;", "w7 = w7;", "r8 = r7;", 1000000, 17)
+CONST_REGS_TEST(const_regs_add_add32_long, "r7 = 17;", "w7 += 0x80000000; w7 += 0x80000000;",
+		"r8 = r7;", 1000000, 17)
+/* r7 doesn't fit in 32 bits, r8 does */
+CONST_REGS_TEST(const_regs_neg_long, "r7 = -16;", "r7 &= -8;", "r8 = r7; r8 &= 255;", 1000000, 240)
+CONST_REGS_TEST(const_regs_wide_long, "r7 = 0xffffffff00000011 ll;", "r7 &= -239;",
+		"r8 = r7; r8 &= 255;", 1000000, 17)
+CONST_REGS_TEST(const_regs_wide_long32, "r7 = 0xffffffff00000011 ll;", "r7 &= -239;",
+		"w8 = w7;", 1000000, 17)
+CONST_REGS_TEST(const_regs_wide_reg_long, "r7 = 0x100000011 ll; r9 = 0x1000000ff ll;",
+		"r7 &= r9;", "r8 = r7; r8 &= 255;", 1000000, 17)
+
+/* A loop without a count around it. */
+SEC("socket")
+__success
+__naked void const_regs_and_nested(void)
+{
+	asm volatile ("					\
+	r7 = 17;					\
+1:	r6 = 0;						\
+2:	r7 &= 31;					\
+	call %[bpf_get_prandom_u32];			\
+	if r0 != 0 goto 3f;				\
+	if r7 != r0 goto 3f;				\
+	*(u64 *)(r10 - 8) = r7;				\
+3:	r6 += 1;					\
+	if r6 < 10 goto 2b;				\
+	call %[bpf_get_prandom_u32];			\
+	if r0 != 0 goto 1b;				\
+	r0 = r7;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 200 iterations are not too long, 200 x 200 are. */
+SEC("socket")
+__success __retval(240)
+__naked void const_regs_neg_nested(void)
+{
+	asm volatile ("					\
+	r7 = -16;					\
+	r9 = 0;						\
+1:	r6 = 0;						\
+2:	r7 &= -8;					\
+	r8 = r7;					\
+	r8 &= 255;					\
+	call %[bpf_get_prandom_u32];			\
+	if r0 != 0 goto 3f;				\
+	if r8 != r0 goto 3f;				\
+	*(u64 *)(r10 - 8) = r8;				\
+3:	r6 += 1;					\
+	if r6 < 200 goto 2b;				\
+	r9 += 1;					\
+	if r9 < 200 goto 1b;				\
+	r0 = r8;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/* The offset of a pointer to arena is not tracked. A loop that moves the pointer is not unrolled. */
+SEC("syscall")
+__success __log_level(2)
+__msg("header_count is 100")
+__not_msg("can't widen r6")
+__naked void arena_pointer_moves(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r6 = 0;						\
+	r6 = addr_space_cast(r6, 0, 1);			\
+	r7 = 0;						\
+1:	*(u64 *)(r6 + 0) = r7;				\
+	r6 += 8;					\
+	r7 += 1;					\
+	if r7 < 100 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+#endif
+
+/* The pointer is not widened, see ptr_buf. The loop is counted: it is unrolled. */
+SEC("iter/bpf_map_elem")
+__success
+__log_level(2)
+__msg("header_count is 4 ")
+__msg("can't widen r6, expr is (+ r6 1)")
+__naked void ptr_buf_is_the_counter(void)
+{
+	asm volatile ("					\
+	r6 = *(u64 *)(r1 + %[value]);			\
+	if r6 == 0 goto 2f;				\
+	r7 = r6;					\
+	r7 += 4;					\
+1:	r6 += 1;					\
+	if r6 < r7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(value, offsetof(struct bpf_iter__bpf_map_elem, value))
+	: __clobber_all);
+}
+
 /*
  * r6 and r7 count together. At the head of the loop both are 0..9 and nothing says
  * that they are equal: r7 = 9 gets through the first jump with r6 = 0..9 and
-- 
2.55.0

