Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F143FCB29;
	Wed, 27 May 2026 11:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882252; cv=none; b=uWhDBkmhp8xpm5/2dd+pKWzN5qlUss99ydrXeV2bw9pbAerEzA1mGvS9u52F0tR+U7AYUCET9QcKj/Hj0qrJj9e8N673pRBilkuFPCcTQlj1pOSoVNiI7ku9Atuk9wlCD29ae/VQJ4/iHGtWG10lzWmemsOSsUCi/E7ztdsOkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882252; c=relaxed/simple;
	bh=2HFoojcm1mbfQuqHWgmbVQUggC2BQjiDy+QZvBHSdtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBSTmuWn4vHL1cR4tFFYY9cq3YKVGzZiWEWvy8wi+pmNW6RrbWp0sFYZ7HLcA28aiqZnDdVfE2ZCBPKktvEGzKA6AhxT83ij3b6dHkfxdywB7jkmEo7l3PeBd1vUYBgN5HxDbnJwAGfanLIktOR3ua03BFFAeATGw8Gib4lOIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZdmr9xn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZdmr9xn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C691F000E9;
	Wed, 27 May 2026 11:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779882249;
	bh=RIeIyQ++aAB2y2uUUxK09nEX5FRn3wB0tz6GOMxK5zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZdmr9xn0zAwlB8YkLIJ9hjNTdC1Je0B7luYOmZ9465PoRqnpv/RCW46nFpbDGRiE
	 CVdRQuIgQ2mHRn06C2w70LeZIoHql0dxzLQdkHthEKREC0bSlG5bTJa6lt1ABVtrqx
	 yJplHyS7h26cfNhDGW5u4wT6/BM+UUggTgcV8cDWYetheSGSPLzY8HHVmapL1rQIoZ
	 YMSXGkI/SiqPZWjS6tnzhCra9CsQWpREI+QoOQOHW9mVhR2c1ALkb7cXiz4xkegHE/
	 fpMJFeqQpO6yRMs82sI7ruwGa2oraNHubk8XrOz7k68GkEzlr7S85RoVsxP1zWuibL
	 VNPR/WxUrckKQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv6 bpf-next 24/29] selftests/bpf: Add tracing multi cookies test
Date: Wed, 27 May 2026 13:39:46 +0200
Message-ID: <20260527113951.46265-25-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527113951.46265-1-jolsa@kernel.org>
References: <20260527113951.46265-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for using cookies on tracing multi link.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 23 +++++++++++++++++--
 .../selftests/bpf/progs/tracing_multi_check.c | 15 +++++++++++-
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 26acc1a480cf..f27c086d3f78 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -9,6 +9,19 @@
 #include "tracing_multi_intersect.skel.h"
 #include "trace_helpers.h"
 
+static __u64 bpf_fentry_test_cookies[] = {
+	8,  /* bpf_fentry_test1 */
+	9,  /* bpf_fentry_test2 */
+	7,  /* bpf_fentry_test3 */
+	5,  /* bpf_fentry_test4 */
+	4,  /* bpf_fentry_test5 */
+	2,  /* bpf_fentry_test6 */
+	3,  /* bpf_fentry_test7 */
+	1,  /* bpf_fentry_test8 */
+	10, /* bpf_fentry_test9 */
+	6,  /* bpf_fentry_test10 */
+};
+
 static const char * const bpf_fentry_test[] = {
 	"bpf_fentry_test1",
 	"bpf_fentry_test2",
@@ -216,7 +229,7 @@ static void test_link_api_pattern(void)
 	tracing_multi__destroy(skel);
 }
 
-static void test_link_api_ids(void)
+static void test_link_api_ids(bool test_cookies)
 {
 	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
 	struct tracing_multi *skel;
@@ -228,6 +241,7 @@ static void test_link_api_ids(void)
 		return;
 
 	skel->bss->pid = getpid();
+	skel->bss->test_cookies = test_cookies;
 
 	ids = get_ids(bpf_fentry_test, cnt, NULL);
 	if (!ASSERT_OK_PTR(ids, "get_ids"))
@@ -236,6 +250,9 @@ static void test_link_api_ids(void)
 	opts.ids = ids;
 	opts.cnt = cnt;
 
+	if (test_cookies)
+		opts.cookies = bpf_fentry_test_cookies;
+
 	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
 						NULL, &opts);
 	if (!ASSERT_OK_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
@@ -449,7 +466,7 @@ void test_tracing_multi_test(void)
 	if (test__start_subtest("link_api_pattern"))
 		test_link_api_pattern();
 	if (test__start_subtest("link_api_ids"))
-		test_link_api_ids();
+		test_link_api_ids(false);
 	if (test__start_subtest("module_skel_api"))
 		test_module_skel_api();
 	if (test__start_subtest("module_link_api_pattern"))
@@ -458,4 +475,6 @@ void test_tracing_multi_test(void)
 		test_module_link_api_ids();
 	if (test__start_subtest("intersect"))
 		test_intersect();
+	if (test__start_subtest("cookies"))
+		test_link_api_ids(true);
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
index 7ede84c50cb6..b2959ba71179 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -6,6 +6,7 @@
 char _license[] SEC("license") = "GPL";
 
 int pid = 0;
+bool test_cookies = false;
 
 /* bpf_fentry_test1 is exported as kfunc via vmlinux.h */
 extern const void bpf_fentry_test2 __ksym;
@@ -27,7 +28,7 @@ extern const void bpf_testmod_fentry_test11 __ksym;
 int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 {
 	void *ip = (void *) bpf_get_func_ip(ctx);
-	__u64 value = 0, ret = 0;
+	__u64 value = 0, ret = 0, cookie = 0;
 	long err = 0;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
@@ -35,6 +36,8 @@ int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 
 	if (is_return)
 		err |= bpf_get_func_ret(ctx, &ret);
+	if (test_cookies)
+		cookie = bpf_get_attach_cookie(ctx);
 
 	if (ip == &bpf_fentry_test1) {
 		int a;
@@ -43,6 +46,7 @@ int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		a = (int) value;
 
 		err |= is_return ? ret != 2 : 0;
+		err |= test_cookies ? cookie != 8 : 0;
 
 		*test_result += err == 0 && a == 1;
 	} else if (ip == &bpf_fentry_test2) {
@@ -55,6 +59,7 @@ int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		b = value;
 
 		err |= is_return ? ret != 5 : 0;
+		err |= test_cookies ? cookie != 9 : 0;
 
 		*test_result += err == 0 && a == 2 && b == 3;
 	} else if (ip == &bpf_fentry_test3) {
@@ -70,6 +75,7 @@ int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		c = value;
 
 		err |= is_return ? ret != 15 : 0;
+		err |= test_cookies ? cookie != 7 : 0;
 
 		*test_result += err == 0 && a == 4 && b == 5 && c == 6;
 	} else if (ip == &bpf_fentry_test4) {
@@ -88,6 +94,7 @@ int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		d = value;
 
 		err |= is_return ? ret != 34 : 0;
+		err |= test_cookies ? cookie != 5 : 0;
 
 		*test_result += err == 0 && a == (void *) 7 && b == 8 && c == 9 && d == 10;
 	} else if (ip == &bpf_fentry_test5) {
@@ -109,6 +116,7 @@ int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		e = value;
 
 		err |= is_return ? ret != 65 : 0;
+		err |= test_cookies ? cookie != 4 : 0;
 
 		*test_result += err == 0 && a == 11 && b == (void *) 12 && c == 13 && d == 14 && e == 15;
 	} else if (ip == &bpf_fentry_test6) {
@@ -133,22 +141,27 @@ int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		f = value;
 
 		err |= is_return ? ret != 111 : 0;
+		err |= test_cookies ? cookie != 2 : 0;
 
 		*test_result += err == 0 && a == 16 && b == (void *) 17 && c == 18 && d == 19 && e == (void *) 20 && f == 21;
 	} else if (ip == &bpf_fentry_test7) {
 		err |= is_return ? ret != 0 : 0;
+		err |= test_cookies ? cookie != 3 : 0;
 
 		*test_result += err == 0 ? 1 : 0;
 	} else if (ip == &bpf_fentry_test8) {
 		err |= is_return ? ret != 0 : 0;
+		err |= test_cookies ? cookie != 1 : 0;
 
 		*test_result += err == 0 ? 1 : 0;
 	} else if (ip == &bpf_fentry_test9) {
 		err |= is_return ? ret != 0 : 0;
+		err |= test_cookies ? cookie != 10 : 0;
 
 		*test_result += err == 0 ? 1 : 0;
 	} else if (ip == &bpf_fentry_test10) {
 		err |= is_return ? ret != 0 : 0;
+		err |= test_cookies ? cookie != 6 : 0;
 
 		*test_result += err == 0 ? 1 : 0;
 	} else if (ip == &bpf_testmod_fentry_test1) {
-- 
2.54.0

