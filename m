Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0576B4A4993
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819902; cv=none; b=O5SPB7aHRIfrcmZhXw7M5IVJvX83BTqRf1gcLWx36gF65CYfs9aCbfPoPcXgQKvLzCHSExYwO6sTNPNeHqjSuP/esGVTA8ZurUenxNDqtzeHh3CmeFMfMNAQikxMfZ39wSOm9G98a1w8bc6xt/5EfhWiuu5MiE4d9xgNrG3u+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819902; c=relaxed/simple;
	bh=GF2y3cZLLKo3Rw4Rb6OFmd7jVWJ7z6UGsLgzVq2UMpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npftb19nxrvN9gyyK1BrlDnYpTxNE4jqg7D34UQrytvuRBDXuXKWF7Pc/Iz7dLER8rnku1cbnmIS7Qd3oYcSYT6Xc8mKmCjQAv91WjSFaSa7qjjRz4vMR1BJsg+s0Gw2Q9OMhJe9ekTeQ59K4UKuvlFpuAo+ttWioqCSpsbpTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K7gQgv7L; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K7gQgv7L"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GF2y3cZLLKo3Rw4Rb6OFmd7jVWJ7z6UGsLgzVq2UMpQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819898; v=1; x=1792424698;
 b=K7gQgv7LDul7LjYnZ6KujhDcgA910dZs5bKa2i1LYyjey97RTCLY/rhMAW3nbcPn6uU4dQ7L
 VWimG1mcTLRzeyY67/9/4+ect1vUVWne9TnYT/ruyDs6R4M95sUyDtSHN6XZTx331xz45dnyqyQ
 nw2Dgq3NuZbhpJSJLukjsd0s=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 56d1af081940df69;
	Mon, 12 Oct 2026 15:44:58 +0000
X-Mizu-Trace-ID: 56d1af081940df69
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 17/21] selftests/bpf: Add tracing_multi bpf prog cookie test
Date: Mon, 12 Oct 2026 23:40:19 +0800
Message-ID: <20261012154024.29423-18-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that the cookie also works for bpf prog targets of tracing_multi
link.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 21 +++++++++++++++++--
 .../selftests/bpf/progs/tracing_multi_bpf.c   | 13 ++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index d428b5e2600c..bcf933760bc5 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -1143,9 +1143,12 @@ static int run_bpf_target(struct bpf_program *prog, __u32 retval, const char *na
 	return 0;
 }
 
-static void test_link_api_bpf_prog(void)
+static void test_link_api_bpf_prog(bool test_cookies)
 {
 	const char *funcs[] = { "target_1", "target_2" };
+	__u64 fentry_cookies[] = { 0xfeed01, 0xfeed02 };
+	__u64 fexit_cookies[] = { 0xfeed11, 0xfeed12 };
+	__u64 fsession_cookies[] = { 0xfeed21, 0xfeed22 };
 	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
 	struct tracing_multi_bpf *skel = NULL;
 	int fds[ARRAY_SIZE(funcs)];
@@ -1158,27 +1161,39 @@ static void test_link_api_bpf_prog(void)
 	fds[0] = bpf_program__fd(skel->progs.target_1);
 	fds[1] = bpf_program__fd(skel->progs.target_2);
 
+	skel->bss->test_cookies = test_cookies;
+
 	opts.fds = fds;
 	opts.funcs = funcs;
 	opts.cnt = ARRAY_SIZE(fds);
 
+	opts.cookies = test_cookies ? fentry_cookies : NULL;
 	link = bpf_program__attach_tracing_multi(skel->progs.test_fentry, NULL, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_fentry"))
 		goto cleanup;
 	skel->links.test_fentry = link;
 
+	opts.cookies = test_cookies ? fexit_cookies : NULL;
 	link = bpf_program__attach_tracing_multi(skel->progs.test_fexit, NULL, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_fexit"))
 		goto cleanup;
 	skel->links.test_fexit = link;
 
+	opts.cookies = test_cookies ? fsession_cookies : NULL;
 	link = bpf_program__attach_tracing_multi(skel->progs.test_fsession, NULL, &opts);
 	if (!ASSERT_OK_PTR(link, "attach_fsession"))
 		goto cleanup;
 	skel->links.test_fsession = link;
 
+	skel->bss->fentry_cookie = fentry_cookies[0];
+	skel->bss->fexit_cookie = fexit_cookies[0];
+	skel->bss->fsession_cookie = fsession_cookies[0];
 	if (run_bpf_target(skel->progs.target_1, 1, "target_1"))
 		goto cleanup;
+
+	skel->bss->fentry_cookie = fentry_cookies[1];
+	skel->bss->fexit_cookie = fexit_cookies[1];
+	skel->bss->fsession_cookie = fsession_cookies[1];
 	if (run_bpf_target(skel->progs.target_2, 2, "target_2"))
 		goto cleanup;
 
@@ -1296,7 +1311,9 @@ static void test_attach_api_bpf_prog_fails(void)
 void test_tracing_multi_prog_test(void)
 {
 	if (test__start_subtest("link_api"))
-		test_link_api_bpf_prog();
+		test_link_api_bpf_prog(false);
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_bpf_prog_fails();
+	if (test__start_subtest("cookies"))
+		test_link_api_bpf_prog(true);
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c b/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
index 3e02602558ad..651b5d86203f 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
@@ -5,6 +5,10 @@
 
 char _license[] SEC("license") = "GPL";
 
+bool test_cookies;
+__u64 fentry_cookie;
+__u64 fexit_cookie;
+__u64 fsession_cookie;
 __u64 test_result_fentry;
 __u64 test_result_fexit;
 __u64 test_result_fsession_entry;
@@ -29,20 +33,25 @@ int target_2(void *ctx)
 SEC("fentry.multi")
 int BPF_PROG(test_fentry)
 {
-	test_result_fentry++;
+	if (!test_cookies || bpf_get_attach_cookie(ctx) == fentry_cookie)
+		test_result_fentry++;
 	return 0;
 }
 
 SEC("fexit.multi")
 int BPF_PROG(test_fexit)
 {
-	test_result_fexit++;
+	if (!test_cookies || bpf_get_attach_cookie(ctx) == fexit_cookie)
+		test_result_fexit++;
 	return 0;
 }
 
 SEC("fsession.multi")
 int BPF_PROG(test_fsession)
 {
+	if (test_cookies && bpf_get_attach_cookie(ctx) != fsession_cookie)
+		return 0;
+
 	if (bpf_session_is_return(ctx))
 		test_result_fsession_exit++;
 	else
-- 
2.55.0

