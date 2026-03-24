Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C963D348C;
	Tue, 24 Mar 2026 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340551; cv=none; b=dxHJwv5RlrJfOYQpaUSmlCaQptbWppdEiZlvvck+qV36OEJ8jl9ETv7730sIZkTX7yb5nRH0HTDT39rRjKkUir+R3uhPJSscco7X+y4+cqFO8khWAsBUNhDDsyCcPz3r4iIIkzRai0dpuh2oXrdJhluuFYd2UA1DddftAXgzQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340551; c=relaxed/simple;
	bh=eZtc0kUqAxdecOJxPE0guS6525sFXeJTMofaZzFILK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJg4y+Ogu3Y3n13uNvYZJ0nFlA0s98NcRTE295EIPRwyWf6V81YR/xv70SeBeAMUGDH588DdF9ALVb7cXm2ISt7B9ywFSLdbKs4wo464/epYgFoFKPc9Ro4YXJV/79D59An+ZsvwLcZVtmDqI92Y8gp72eE6S0VjRHvqVuGA+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnTLyPck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnTLyPck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBC7C2BCB2;
	Tue, 24 Mar 2026 08:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340550;
	bh=eZtc0kUqAxdecOJxPE0guS6525sFXeJTMofaZzFILK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnTLyPckYUPZcMPXss/ByZvHir/t0YlBijLcus5WVYtLEAlWk8biOOTKlu3aNvQxu
	 EQshA+iR0FRnu/xooiDjxczBAIoZ+I2iKG+XtzG7QlbiTY9ys4NIFM36i6iDW2qMQJ
	 Ckhh1X1deNpwtziVpOT7y1nDYplBQNErrbooXBSyFbRx5RjURe3j5wQ/mXUAjqKO47
	 emeTX7HscK2isjfhcQJ13SN8TNIpaD5wug2ZJu4ZMoS0EkZV6yi7U8tZZK+ENAzSnJ
	 eWEZApLEo0xSopdEBuQAca0mQ3ElsIlc9MdMuMn/n8EIdLaIHCNHVWrFcL5W1JNQT+
	 6J7MG30TFvcZw==
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
Subject: [PATCHv4 bpf-next 21/25] selftests/bpf: Add tracing multi cookies test
Date: Tue, 24 Mar 2026 09:18:42 +0100
Message-ID: <20260324081846.2334094-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324081846.2334094-1-jolsa@kernel.org>
References: <20260324081846.2334094-1-jolsa@kernel.org>
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
index 44c6f3fbc82d..c452bf574f22 100644
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
@@ -211,7 +224,7 @@ static void test_link_api_pattern(void)
 	tracing_multi__destroy(skel);
 }
 
-static void test_link_api_ids(void)
+static void test_link_api_ids(bool test_cookies)
 {
 	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
 	struct tracing_multi *skel;
@@ -223,6 +236,7 @@ static void test_link_api_ids(void)
 		return;
 
 	skel->bss->pid = getpid();
+	skel->bss->test_cookies = test_cookies;
 
 	ids = get_ids(bpf_fentry_test, cnt, NULL);
 	if (!ASSERT_OK_PTR(ids, "get_ids"))
@@ -231,6 +245,9 @@ static void test_link_api_ids(void)
 	opts.ids = ids;
 	opts.cnt = cnt;
 
+	if (test_cookies)
+		opts.cookies = bpf_fentry_test_cookies;
+
 	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
 						NULL, &opts);
 	if (!ASSERT_OK_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
@@ -444,7 +461,7 @@ void test_tracing_multi_test(void)
 	if (test__start_subtest("link_api_pattern"))
 		test_link_api_pattern();
 	if (test__start_subtest("link_api_ids"))
-		test_link_api_ids();
+		test_link_api_ids(false);
 	if (test__start_subtest("module_skel_api"))
 		test_module_skel_api();
 	if (test__start_subtest("module_link_api_pattern"))
@@ -453,4 +470,6 @@ void test_tracing_multi_test(void)
 		test_module_link_api_ids();
 	if (test__start_subtest("intersect"))
 		test_intersect();
+	if (test__start_subtest("cookies"))
+		test_link_api_ids(true);
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
index 631fa76ead6a..e2f49393aee9 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_check.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -6,6 +6,7 @@
 char _license[] SEC("license") = "GPL";
 
 int pid = 0;
+bool test_cookies = false;
 
 /* bpf_fentry_test1 is exported as kfunc via vmlinux.h */
 extern const void bpf_fentry_test2 __ksym;
@@ -27,7 +28,7 @@ extern const void bpf_testmod_fentry_test11 __ksym;
 void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 {
 	void *ip = (void *) bpf_get_func_ip(ctx);
-	__u64 value = 0, ret = 0;
+	__u64 value = 0, ret = 0, cookie = 0;
 	long err = 0;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
@@ -35,6 +36,8 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 
 	if (is_return)
 		err |= bpf_get_func_ret(ctx, &ret);
+	if (test_cookies)
+		cookie = bpf_get_attach_cookie(ctx);
 
 	if (ip == &bpf_fentry_test1) {
 		int a;
@@ -43,6 +46,7 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		a = (int) value;
 
 		err |= is_return ? ret != 2 : 0;
+		err |= test_cookies ? cookie != 8 : 0;
 
 		*test_result += err == 0 && a == 1;
 	} else if (ip == &bpf_fentry_test2) {
@@ -55,6 +59,7 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		b = value;
 
 		err |= is_return ? ret != 5 : 0;
+		err |= test_cookies ? cookie != 9 : 0;
 
 		*test_result += err == 0 && a == 2 && b == 3;
 	} else if (ip == &bpf_fentry_test3) {
@@ -70,6 +75,7 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		c = value;
 
 		err |= is_return ? ret != 15 : 0;
+		err |= test_cookies ? cookie != 7 : 0;
 
 		*test_result += err == 0 && a == 4 && b == 5 && c == 6;
 	} else if (ip == &bpf_fentry_test4) {
@@ -88,6 +94,7 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		d = value;
 
 		err |= is_return ? ret != 34 : 0;
+		err |= test_cookies ? cookie != 5 : 0;
 
 		*test_result += err == 0 && a == (void *) 7 && b == 8 && c == 9 && d == 10;
 	} else if (ip == &bpf_fentry_test5) {
@@ -109,6 +116,7 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
 		e = value;
 
 		err |= is_return ? ret != 65 : 0;
+		err |= test_cookies ? cookie != 4 : 0;
 
 		*test_result += err == 0 && a == 11 && b == (void *) 12 && c == 13 && d == 14 && e == 15;
 	} else if (ip == &bpf_fentry_test6) {
@@ -133,22 +141,27 @@ void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
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
2.53.0

