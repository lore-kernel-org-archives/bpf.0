Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153EA316199
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985096; cv=none; b=Rei2QJ7CduSTwH+QfMmq6hdDqvn7p4Iq/RMibzsN9aBpqBJVr5MYtGXvXBNCqFA3muVoDW3q2bXO0trZU0sO3r9v9+M7OerAfJyw8PX3RIpSIsmALg82Ufl5N3811gy+uwIxRmhNNDsYEAbO204N/nQFP103/qz2wSefUYmdIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985096; c=relaxed/simple;
	bh=eAUmKVMvLyl25pur6lSPz2Nd/yYuCuZUmNGgOkr1otw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhlFny1BUQrUjVcimamL3wEZ6OeldQoIdruway3SxcBBMWX8ZV8xKaGsBPXK/nDcby17Ee+ZZBvSPwv2lLH3O9b1YzIOSwfWLUfBnqGDeRw0znRmZgGm13bz1Pq5o+Q/fxoK2x7g3uPQeWy6yYbDgRkjFd7UfEyf3jHpOOv3AdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJlVXd9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJlVXd9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FC11F000E9;
	Thu, 28 May 2026 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779985094;
	bh=npHcmLNnsW0+nboeAvgt/kd2kfrQJD7UmVURB8ZbN6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DJlVXd9F6fVzViVbS4qli7c0jUGk2RnUeZEop6yUE/fLAPIrLYUYt5JW14Fsd1ekx
	 lhOox2bcu0VrIDsjVPECfaubSVmn6CT3J7PWRL7ymQW8dZak3GFyrjvwrj+cc4RkGf
	 Ivd7CrjMBlgiQW3ZjJcx1pka3La4s0F0ZKTCI79u9SUviSzcu04lmS/4iMQoj7juMq
	 DQRtiXaMoKidw6/f3viChkolmU0GDr3bFskEsmWmbgdr4NoR3ZH60r3CXcbCLhXfJj
	 gJR7LYnhBvEoMS5+Gt9mP9cf3bk8V7jMwTJfA5+ktPt2+zdphGBNrFB7aru7G6RJUb
	 A9mlnoX7kF96A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	"Yonghong Song" <yonghong.song@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Use at least 10 args in stack argument tests
Date: Thu, 28 May 2026 09:17:48 -0700
Message-ID: <20260528161750.1900674-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528161750.1900674-1-puranjay@kernel.org>
References: <20260528161750.1900674-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On arm64, the first 8 arguments are passed in registers (x0-x7), so
tests with 8 or fewer arguments never exercise the native stack argument
path in the JIT. Increase argument counts to at least 10 across all
BPF-to-BPF subprog and kfunc stack argument tests so that at least 2
arguments land on the arm64 stack.

For the two-callees test, bump foo1 from 8 to 10 and foo2 from 10 to 12
args to preserve the different-stack-depth flavor of the test.

The bpf_kfunc_call_stack_arg_mem kfunc is left unchanged at 7 args to
avoid breaking the precision backtracking test which relies on hardcoded
verifier log instruction indices.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/stack_arg.c      | 30 +++----
 tools/testing/selftests/bpf/progs/stack_arg.c | 90 +++++++++++--------
 .../selftests/bpf/progs/stack_arg_kfunc.c     | 24 ++---
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 25 ++++--
 .../bpf/test_kmods/bpf_testmod_kfunc.h        | 11 ++-
 5 files changed, 108 insertions(+), 72 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg.c b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
index d61bac33f809..57193543f260 100644
--- a/tools/testing/selftests/bpf/prog_tests/stack_arg.c
+++ b/tools/testing/selftests/bpf/prog_tests/stack_arg.c
@@ -37,7 +37,7 @@ static void test_global_many(void)
 	if (!ASSERT_OK(stack_arg__load(skel), "load"))
 		goto out;
 
-	run_subtest(skel->progs.test_global_many_args, 36);
+	run_subtest(skel->progs.test_global_many_args, 55);
 
 out:
 	stack_arg__destroy(skel);
@@ -62,10 +62,10 @@ static void test_async_cb_many(void)
 	run_subtest(skel->progs.test_async_cb_many_args, 0);
 
 	/* Wait for the timer callback to fire and verify the result.
-	 * 10+20+30+40+50+60+70+80 = 360
+	 * 10+20+30+40+50+60+70+80+90+100 = 550
 	 */
 	usleep(50);
-	ASSERT_EQ(skel->bss->timer_result, 360, "timer_result");
+	ASSERT_EQ(skel->bss->timer_result, 550, "timer_result");
 
 out:
 	stack_arg__destroy(skel);
@@ -87,11 +87,11 @@ static void test_bpf2bpf(void)
 	if (!ASSERT_OK(stack_arg__load(skel), "load"))
 		goto out;
 
-	run_subtest(skel->progs.test_bpf2bpf_ptr_stack_arg, 45);
-	run_subtest(skel->progs.test_bpf2bpf_mix_stack_args, 51);
-	run_subtest(skel->progs.test_bpf2bpf_nesting_stack_arg, 50);
-	run_subtest(skel->progs.test_bpf2bpf_dynptr_stack_arg, 69);
-	run_subtest(skel->progs.test_two_callees, 91);
+	run_subtest(skel->progs.test_bpf2bpf_ptr_stack_arg, 75);
+	run_subtest(skel->progs.test_bpf2bpf_mix_stack_args, 66);
+	run_subtest(skel->progs.test_bpf2bpf_nesting_stack_arg, 84);
+	run_subtest(skel->progs.test_bpf2bpf_dynptr_stack_arg, 99);
+	run_subtest(skel->progs.test_two_callees, 133);
 
 out:
 	stack_arg__destroy(skel);
@@ -113,14 +113,14 @@ static void test_kfunc(void)
 	if (!ASSERT_OK(stack_arg_kfunc__load(skel), "load"))
 		goto out;
 
-	run_subtest(skel->progs.test_stack_arg_scalar, 36);
-	run_subtest(skel->progs.test_stack_arg_ptr, 45);
-	run_subtest(skel->progs.test_stack_arg_mix, 51);
-	run_subtest(skel->progs.test_stack_arg_dynptr, 69);
+	run_subtest(skel->progs.test_stack_arg_scalar, 55);
+	run_subtest(skel->progs.test_stack_arg_ptr, 75);
+	run_subtest(skel->progs.test_stack_arg_mix, 66);
+	run_subtest(skel->progs.test_stack_arg_dynptr, 99);
 	run_subtest(skel->progs.test_stack_arg_mem, 151);
-	run_subtest(skel->progs.test_stack_arg_iter, 115);
-	run_subtest(skel->progs.test_stack_arg_const_str, 15);
-	run_subtest(skel->progs.test_stack_arg_timer, 15);
+	run_subtest(skel->progs.test_stack_arg_iter, 145);
+	run_subtest(skel->progs.test_stack_arg_const_str, 45);
+	run_subtest(skel->progs.test_stack_arg_timer, 45);
 
 out:
 	stack_arg_kfunc__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testing/selftests/bpf/progs/stack_arg.c
index b5e9929a4d63..944e3bb603e7 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg.c
@@ -27,14 +27,16 @@ int timer_result;
 const volatile bool has_stack_arg = true;
 
 __noinline static int static_func_many_args(int a, int b, int c, int d,
-					    int e, int f, int g, int h)
+					    int e, int f, int g, int h,
+					    int i, int j)
 {
-	return a + b + c + d + e + f + g + h;
+	return a + b + c + d + e + f + g + h + i + j;
 }
 
 __noinline int global_calls_many_args(int a, int b, int c)
 {
-	return static_func_many_args(a, b, c, 4, 5, 6, 7, 8);
+	return static_func_many_args(a, b, c, a + 3, a + 4, a + 5, a + 6,
+				     a + 7, a + 8, a + 9);
 }
 
 SEC("tc")
@@ -48,18 +50,20 @@ struct test_data {
 	long y;
 };
 
-/* 1 + 2 + 3 + 4 + 5 + 10 + 20 = 45 */
+/* 1+2+3+4+5+6+7+8+9+10+20 = 75 */
 __noinline static long func_with_ptr_stack_arg(long a, long b, long c, long d,
-					       long e, struct test_data *p)
+					       long e, long f, long g, long h,
+					       long i, struct test_data *p)
 {
-	return a + b + c + d + e + p->x + p->y;
+	return a + b + c + d + e + f + g + h + i + p->x + p->y;
 }
 
 __noinline long global_ptr_stack_arg(long a, long b, long c, long d, long e)
 {
 	struct test_data data = { .x = 10, .y = 20 };
 
-	return func_with_ptr_stack_arg(a, b, c, d, e, &data);
+	return func_with_ptr_stack_arg(a, b, c, d, e, a + 5, a + 6, a + 7,
+				      a + 8, &data);
 }
 
 SEC("tc")
@@ -68,12 +72,13 @@ int test_bpf2bpf_ptr_stack_arg(void)
 	return global_ptr_stack_arg(1, 2, 3, 4, 5);
 }
 
-/* 1 + 2 + 3 + 4 + 5 + 10 + 6 + 20 = 51 */
+/* 1+2+3+4+5+6+7+10+8+20 = 66 */
 __noinline static long func_with_mix_stack_args(long a, long b, long c, long d,
-						long e, struct test_data *p,
-						long f, struct test_data *q)
+						long e, long f, long g,
+						struct test_data *p,
+						long h, struct test_data *q)
 {
-	return a + b + c + d + e + p->x + f + q->y;
+	return a + b + c + d + e + f + g + p->x + h + q->y;
 }
 
 __noinline long global_mix_stack_args(long a, long b, long c, long d, long e)
@@ -81,7 +86,8 @@ __noinline long global_mix_stack_args(long a, long b, long c, long d, long e)
 	struct test_data p = { .x = 10 };
 	struct test_data q = { .y = 20 };
 
-	return func_with_mix_stack_args(a, b, c, d, e, &p, e + 1, &q);
+	return func_with_mix_stack_args(a, b, c, d, e, e + 1, e + 2, &p,
+					e + 3, &q);
 }
 
 SEC("tc")
@@ -94,26 +100,30 @@ int test_bpf2bpf_mix_stack_args(void)
  * Nesting test: func_outer calls func_inner, both with struct pointer
  * as stack arg.
  *
- * func_inner: (a+1) + (b+1) + (c+1) + (d+1) + (e+1) + p->x + p->y
- *           = 2 + 3 + 4 + 5 + 6 + 10 + 20 = 50
+ * func_inner: (a+1)+...+(i+1) + p->x + p->y
+ *           = 2+3+4+5+6+7+8+9+10+10+20 = 84
  */
 __noinline static long func_inner_ptr(long a, long b, long c, long d,
-				      long e, struct test_data *p)
+				      long e, long f, long g, long h,
+				      long i, struct test_data *p)
 {
-	return a + b + c + d + e + p->x + p->y;
+	return a + b + c + d + e + f + g + h + i + p->x + p->y;
 }
 
 __noinline static long func_outer_ptr(long a, long b, long c, long d,
-				      long e, struct test_data *p)
+				      long e, long f, long g, long h,
+				      long i, struct test_data *p)
 {
-	return func_inner_ptr(a + 1, b + 1, c + 1, d + 1, e + 1, p);
+	return func_inner_ptr(a + 1, b + 1, c + 1, d + 1, e + 1,
+			      f + 1, g + 1, h + 1, i + 1, p);
 }
 
 __noinline long global_nesting_ptr(long a, long b, long c, long d, long e)
 {
 	struct test_data data = { .x = 10, .y = 20 };
 
-	return func_outer_ptr(a, b, c, d, e, &data);
+	return func_outer_ptr(a, b, c, d, e, a + 5, a + 6, a + 7, a + 8,
+			      &data);
 }
 
 SEC("tc")
@@ -122,11 +132,12 @@ int test_bpf2bpf_nesting_stack_arg(void)
 	return global_nesting_ptr(1, 2, 3, 4, 5);
 }
 
-/* 1 + 2 + 3 + 4 + 5 + sizeof(pkt_v4) = 15 + 54 = 69 */
+/* 1+2+3+4+5+6+7+8+9+sizeof(pkt_v4) = 45+54 = 99 */
 __noinline static long func_with_dynptr(long a, long b, long c, long d,
-					long e, struct bpf_dynptr *ptr)
+					long e, long f, long g, long h,
+					long i, struct bpf_dynptr *ptr)
 {
-	return a + b + c + d + e + bpf_dynptr_size(ptr);
+	return a + b + c + d + e + f + g + h + i + bpf_dynptr_size(ptr);
 }
 
 __noinline long global_dynptr_stack_arg(void *ctx __arg_ctx, long a, long b,
@@ -135,7 +146,8 @@ __noinline long global_dynptr_stack_arg(void *ctx __arg_ctx, long a, long b,
 	struct bpf_dynptr ptr;
 
 	bpf_dynptr_from_skb(ctx, 0, &ptr);
-	return func_with_dynptr(a, b, c, d, d + 1, &ptr);
+	return func_with_dynptr(a, b, c, d, d + 1, d + 2, d + 3, d + 4,
+				d + 5, &ptr);
 }
 
 SEC("tc")
@@ -144,24 +156,25 @@ int test_bpf2bpf_dynptr_stack_arg(struct __sk_buff *skb)
 	return global_dynptr_stack_arg(skb, 1, 2, 3, 4);
 }
 
-/* foo1: a+b+c+d+e+f+g+h */
-__noinline static int foo1(int a, int b, int c, int d,
-			   int e, int f, int g, int h)
+/* foo1: a+b+c+d+e+f+g+h+i+j */
+__noinline static int foo1(int a, int b, int c, int d, int e,
+			   int f, int g, int h, int i, int j)
 {
-	return a + b + c + d + e + f + g + h;
+	return a + b + c + d + e + f + g + h + i + j;
 }
 
-/* foo2: a+b+c+d+e+f+g+h+i+j */
+/* foo2: a+b+c+d+e+f+g+h+i+j+k+l */
 __noinline static int foo2(int a, int b, int c, int d, int e,
-			   int f, int g, int h, int i, int j)
+			   int f, int g, int h, int i, int j,
+			   int k, int l)
 {
-	return a + b + c + d + e + f + g + h + i + j;
+	return a + b + c + d + e + f + g + h + i + j + k + l;
 }
 
-/* global_two_callees calls foo1 (3 stack args) and foo2 (5 stack args).
+/* global_two_callees calls foo1 (5 stack args) and foo2 (7 stack args).
  * The outgoing stack arg area is sized for foo2 (the larger callee).
  * Stores for foo1 are a subset of the area used by foo2.
- * Result: foo1(1,2,3,4,5,6,7,8) + foo2(1,2,3,4,5,6,7,8,9,10) = 36 + 55 = 91
+ * Result: foo1(1..10) + foo2(1..12) = 55 + 78 = 133
  *
  * Pass a-e through so the compiler can't constant-fold the stack args away.
  */
@@ -169,8 +182,9 @@ __noinline int global_two_callees(int a, int b, int c, int d, int e)
 {
 	int ret;
 
-	ret = foo1(a, b, c, d, e, a + 5, a + 6, a + 7);
-	ret += foo2(a, b, c, d, e, a + 5, a + 6, a + 7, a + 8, a + 9);
+	ret = foo1(a, b, c, d, e, a + 5, a + 6, a + 7, a + 8, a + 9);
+	ret += foo2(a, b, c, d, e, a + 5, a + 6, a + 7, a + 8, a + 9,
+		    a + 10, a + 11);
 	return ret;
 }
 
@@ -180,9 +194,15 @@ int test_two_callees(void)
 	return global_two_callees(1, 2, 3, 4, 5);
 }
 
+const volatile int timer_base = 10;
+
 static int timer_cb_many_args(void *map, int *key, struct bpf_timer *timer)
 {
-	timer_result = static_func_many_args(10, 20, 30, 40, 50, 60, 70, 80);
+	int v = timer_base;
+
+	timer_result = static_func_many_args(v, v * 2, v * 3, v * 4, v * 5,
+					     v * 6, v * 7, v * 8, v * 9,
+					     v * 10);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
index da0d4f91d273..345f2da2e361 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
@@ -33,7 +33,7 @@ struct {
 SEC("tc")
 int test_stack_arg_scalar(struct __sk_buff *skb)
 {
-	return bpf_kfunc_call_stack_arg(1, 2, 3, 4, 5, 6, 7, 8);
+	return bpf_kfunc_call_stack_arg(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
 }
 
 SEC("tc")
@@ -41,7 +41,7 @@ int test_stack_arg_ptr(struct __sk_buff *skb)
 {
 	struct prog_test_pass1 p = { .x0 = 10, .x1 = 20 };
 
-	return bpf_kfunc_call_stack_arg_ptr(1, 2, 3, 4, 5, &p);
+	return bpf_kfunc_call_stack_arg_ptr(1, 2, 3, 4, 5, 6, 7, 8, 9, &p);
 }
 
 SEC("tc")
@@ -50,17 +50,17 @@ int test_stack_arg_mix(struct __sk_buff *skb)
 	struct prog_test_pass1 p = { .x0 = 10 };
 	struct prog_test_pass1 q = { .x1 = 20 };
 
-	return bpf_kfunc_call_stack_arg_mix(1, 2, 3, 4, 5, &p, 6, &q);
+	return bpf_kfunc_call_stack_arg_mix(1, 2, 3, 4, 5, 6, 7, &p, 8, &q);
 }
 
-/* 1 + 2 + 3 + 4 + 5 + sizeof(pkt_v4) = 15 + 54 = 69 */
+/* 1+2+3+4+5+6+7+8+9+sizeof(pkt_v4) = 45+54 = 99 */
 SEC("tc")
 int test_stack_arg_dynptr(struct __sk_buff *skb)
 {
 	struct bpf_dynptr ptr;
 
 	bpf_dynptr_from_skb(skb, 0, &ptr);
-	return bpf_kfunc_call_stack_arg_dynptr(1, 2, 3, 4, 5, &ptr);
+	return bpf_kfunc_call_stack_arg_dynptr(1, 2, 3, 4, 5, 6, 7, 8, 9, &ptr);
 }
 
 /* 1 + 2 + 3 + 4 + 5 + (1 + 2 + ... + 16) = 15 + 136 = 151 */
@@ -72,7 +72,7 @@ int test_stack_arg_mem(struct __sk_buff *skb)
 	return bpf_kfunc_call_stack_arg_mem(1, 2, 3, 4, 5, buf, sizeof(buf));
 }
 
-/* 1 + 2 + 3 + 4 + 5 + 100 = 115 */
+/* 1+2+3+4+5+6+7+8+9+100 = 145 */
 SEC("tc")
 int test_stack_arg_iter(struct __sk_buff *skb)
 {
@@ -80,21 +80,22 @@ int test_stack_arg_iter(struct __sk_buff *skb)
 	u64 ret;
 
 	bpf_iter_testmod_seq_new(&it, 100, 10);
-	ret = bpf_kfunc_call_stack_arg_iter(1, 2, 3, 4, 5, &it);
+	ret = bpf_kfunc_call_stack_arg_iter(1, 2, 3, 4, 5, 6, 7, 8, 9, &it);
 	bpf_iter_testmod_seq_destroy(&it);
 	return ret;
 }
 
 const char cstr[] = "hello";
 
-/* 1 + 2 + 3 + 4 + 5 = 15 */
+/* 1+2+3+4+5+6+7+8+9 = 45 */
 SEC("tc")
 int test_stack_arg_const_str(struct __sk_buff *skb)
 {
-	return bpf_kfunc_call_stack_arg_const_str(1, 2, 3, 4, 5, cstr);
+	return bpf_kfunc_call_stack_arg_const_str(1, 2, 3, 4, 5, 6, 7, 8, 9,
+						  cstr);
 }
 
-/* 1 + 2 + 3 + 4 + 5 = 15 */
+/* 1+2+3+4+5+6+7+8+9 = 45 */
 SEC("tc")
 int test_stack_arg_timer(struct __sk_buff *skb)
 {
@@ -104,7 +105,8 @@ int test_stack_arg_timer(struct __sk_buff *skb)
 	val = bpf_map_lookup_elem(&kfunc_timer_map, &key);
 	if (!val)
 		return 0;
-	return bpf_kfunc_call_stack_arg_timer(1, 2, 3, 4, 5, &val->timer);
+	return bpf_kfunc_call_stack_arg_timer(1, 2, 3, 4, 5, 6, 7, 8, 9,
+					      &val->timer);
 }
 
 #else
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 0be918fe3021..30f1cd23093c 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -826,30 +826,34 @@ __bpf_kfunc int bpf_kfunc_call_test5(u8 a, u16 b, u32 c)
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg(u64 a, u64 b, u64 c, u64 d,
-					 u64 e, u64 f, u64 g, u64 h)
+					 u64 e, u64 f, u64 g, u64 h,
+					 u64 i, u64 j)
 {
-	return a + b + c + d + e + f + g + h;
+	return a + b + c + d + e + f + g + h + i + j;
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_ptr(u64 a, u64 b, u64 c, u64 d, u64 e,
+					     u64 f, u64 g, u64 h, u64 i,
 					     struct prog_test_pass1 *p)
 {
-	return a + b + c + d + e + p->x0 + p->x1;
+	return a + b + c + d + e + f + g + h + i + p->x0 + p->x1;
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_mix(u64 a, u64 b, u64 c, u64 d, u64 e,
-					     struct prog_test_pass1 *p, u64 f,
+					     u64 f, u64 g,
+					     struct prog_test_pass1 *p, u64 h,
 					     struct prog_test_pass1 *q)
 {
-	return a + b + c + d + e + p->x0 + f + q->x1;
+	return a + b + c + d + e + f + g + p->x0 + h + q->x1;
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_dynptr(u64 a, u64 b, u64 c, u64 d, u64 e,
+					       u64 f, u64 g, u64 h, u64 i,
 					       struct bpf_dynptr *ptr)
 {
 	const struct bpf_dynptr_kern *kern_ptr = (void *)ptr;
 
-	return a + b + c + d + e + (kern_ptr->size & 0xFFFFFF);
+	return a + b + c + d + e + f + g + h + i + (kern_ptr->size & 0xFFFFFF);
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_mem(u64 a, u64 b, u64 c, u64 d, u64 e,
@@ -865,21 +869,24 @@ __bpf_kfunc u64 bpf_kfunc_call_stack_arg_mem(u64 a, u64 b, u64 c, u64 d, u64 e,
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_iter(u64 a, u64 b, u64 c, u64 d, u64 e,
+					      u64 f, u64 g, u64 h, u64 i,
 					      struct bpf_iter_testmod_seq *it__iter)
 {
-	return a + b + c + d + e + it__iter->value;
+	return a + b + c + d + e + f + g + h + i + it__iter->value;
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_const_str(u64 a, u64 b, u64 c, u64 d, u64 e,
+						   u64 f, u64 g, u64 h, u64 i,
 						   const char *str__str)
 {
-	return a + b + c + d + e;
+	return a + b + c + d + e + f + g + h + i;
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_timer(u64 a, u64 b, u64 c, u64 d, u64 e,
+					       u64 f, u64 g, u64 h, u64 i,
 					       struct bpf_timer *timer)
 {
-	return a + b + c + d + e;
+	return a + b + c + d + e + f + g + h + i;
 }
 
 __bpf_kfunc u64 bpf_kfunc_call_stack_arg_big(u64 a, u64 b, u64 c, u64 d, u64 e,
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 2edc36b66de9..c36bb911defa 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -119,21 +119,28 @@ struct sock *bpf_kfunc_call_test3(struct sock *sk) __ksym;
 long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
 int bpf_kfunc_call_test5(__u8 a, __u16 b, __u32 c) __ksym;
 __u64 bpf_kfunc_call_stack_arg(__u64 a, __u64 b, __u64 c, __u64 d,
-			       __u64 e, __u64 f, __u64 g, __u64 h) __ksym;
+			       __u64 e, __u64 f, __u64 g, __u64 h,
+			       __u64 i, __u64 j) __ksym;
 __u64 bpf_kfunc_call_stack_arg_ptr(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+				   __u64 f, __u64 g, __u64 h, __u64 i,
 				   struct prog_test_pass1 *p) __ksym;
 __u64 bpf_kfunc_call_stack_arg_mix(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
-				   struct prog_test_pass1 *p, __u64 f,
+				   __u64 f, __u64 g,
+				   struct prog_test_pass1 *p, __u64 h,
 				   struct prog_test_pass1 *q) __ksym;
 __u64 bpf_kfunc_call_stack_arg_dynptr(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+				      __u64 f, __u64 g, __u64 h, __u64 i,
 				      struct bpf_dynptr *ptr) __ksym;
 __u64 bpf_kfunc_call_stack_arg_mem(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
 				   void *mem, int mem__sz) __ksym;
 __u64 bpf_kfunc_call_stack_arg_iter(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+				    __u64 f, __u64 g, __u64 h, __u64 i,
 				    struct bpf_iter_testmod_seq *it__iter) __ksym;
 __u64 bpf_kfunc_call_stack_arg_const_str(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+					 __u64 f, __u64 g, __u64 h, __u64 i,
 					 const char *str__str) __ksym;
 __u64 bpf_kfunc_call_stack_arg_timer(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
+				     __u64 f, __u64 g, __u64 h, __u64 i,
 				     struct bpf_timer *timer) __ksym;
 __u64 bpf_kfunc_call_stack_arg_big(__u64 a, __u64 b, __u64 c, __u64 d, __u64 e,
 				   struct prog_test_big_arg s) __ksym;
-- 
2.53.0-Meta

