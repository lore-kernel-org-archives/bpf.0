Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2E344D99
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287820; cv=none; b=uhXmSHtS2NAsqT5sMnts4EOE/JKjj57z8AoGdhCoobZf7pQmQF07Fdl+KE+U+C+SXo9d14rl59a0//OnXL3I14AMDSfRMnmrObxUbVUp72iN+TuUm+A845IE+Zgo8Z6kiUBG/3EMkDGK7meWwRxNlpumxiVFq/7dr6l4mxXVrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287820; c=relaxed/simple;
	bh=boqQ747tfQaFagRvmdFYTI9yhU/TokaN62heSKuPkoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LT+oOcSjV7ItHgoLOgNWAe0JLJD9FPFJIcC3Ak00UMA4N484md5Rnb9FNpvLiXP1ijkBE9RDILx55ITQaKrSaiEGsy/zyIkLLaBts3ePOZN2uHEEG1Jv+b3IclL1MORto1WkWOW7u0Ud5ZwkZtjtDDTEJkvjc8U8TxhZOEkVtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rkh+ODk3; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rkh+ODk3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZNBCvDZ4wsi/VaiOyMJSfJG8oJ1nr2lIgU1xAz5DUM=;
	b=rkh+ODk3DWDxpDTOQw6lkm+r0DDv70LKJ1b9xrwzPBth/UHXLRFpm9OBYwbSY/b0nnDLRY
	Oq76SH0KC9tut8LmQY7VSvvikgbkyUlE72FsHrGw+CsMRjfVWO5oEBOaEzQphhgOFEl8we
	fYv+nga+R5CfSYkOE+gElYMNvtcyhxs=
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
Subject: [PATCH bpf-next 10/13] selftests/bpf: Add tracing_multi bpf prog cookie test
Date: Sun,  9 Aug 2026 23:01:08 +0800
Message-ID: <20260809150111.45000-11-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Verify that the cookie also works for bpf prog targets of tracing_multi
link.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 25 ++++++++++++++++++-
 .../selftests/bpf/progs/tracing_multi_bpf.c   | 13 ++++++++--
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 5cf11707eaf8..070266a864d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -304,9 +304,12 @@ static int run_bpf_target(struct bpf_program *prog, __u32 retval, const char *na
 	return 0;
 }
 
-static void test_link_api_bpf_prog(void)
+static void __test_link_api_bpf_prog(bool test_cookies)
 {
 	const char *funcs[] = { "target_1", "target_2" };
+	__u64 fentry_cookies[] = { 0xfeed01, 0xfeed01 };
+	__u64 fexit_cookies[] = { 0xfeed02, 0xfeed02 };
+	__u64 fsession_cookies[] = { 0xfeed03, 0xfeed03 };
 	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
 	struct tracing_multi_bpf *skel = NULL;
 	int fds[ARRAY_SIZE(funcs)];
@@ -319,20 +322,28 @@ static void test_link_api_bpf_prog(void)
 	fds[0] = bpf_program__fd(skel->progs.target_1);
 	fds[1] = bpf_program__fd(skel->progs.target_2);
 
+	skel->bss->test_cookies = test_cookies;
+	skel->bss->fentry_cookie = fentry_cookies[0];
+	skel->bss->fexit_cookie = fexit_cookies[0];
+	skel->bss->fsession_cookie = fsession_cookies[0];
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
@@ -356,6 +367,16 @@ static void test_link_api_bpf_prog(void)
 	tracing_multi_bpf__destroy(skel);
 }
 
+static void test_link_api_bpf_prog(void)
+{
+	__test_link_api_bpf_prog(false);
+}
+
+static void test_cookies_bpf_prog(void)
+{
+	__test_link_api_bpf_prog(true);
+}
+
 static void test_module_skel_api(void)
 {
 	struct tracing_multi_module *skel = NULL;
@@ -1196,4 +1217,6 @@ void test_tracing_multi_test(void)
 		test_link_api_bpf_prog();
 	if (test__start_subtest("attach_api_bpf_prog_fails"))
 		test_attach_api_bpf_prog_fails();
+	if (test__start_subtest("cookies_bpf_prog"))
+		test_cookies_bpf_prog();
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

