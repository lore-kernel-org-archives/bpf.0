Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED93C5826;
	Sat, 11 Jul 2026 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783774147; cv=none; b=t/asI38W8EW5STIm5xfErEJY0JmwnfeydDweW8mFqc8vksaGgCZnyO8UgFzdR7kwgpg69epHwUaTXi7LfNvwilSxbgi9CTTe6n8k4z3vM2QVpdJQMvnG1P/s0Z1xxv2mhH9lEADIEG6EMEu5jHKScFqfMvUohbcCERYVhBPzkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783774147; c=relaxed/simple;
	bh=0dWDNl7crilbCQSqN9tYgFiSuT0qpf6TG1Zum8iGacE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPcI2mv6NtO1ILjTt2kz6C7XP4fgC6NOqsc3VXX7zdlUXvc2X3Bj4+qVVctjd6MdPfpJZaKnVJ8lWiEyKBRlf2MtR+hT8V/RSZfBNt/0+WbSeBVAxQ74vdt0utKDG0mEPG1K707WRYSn25v6HpthHka5T2hx0WfT8VK6M5ephXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZRwj7mZ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZRwj7mZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783774143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai1KcpgNUI4QdqfPIyJUWqcgePxLUR94N3w947XBtW8=;
	b=fZRwj7mZmfr0znN16LT7kWoxSiTVvFpZ5G3kmSccDrG9F/5rMT3Tc3u9Kv5w0x81Y+4gxX
	7xKMKzTFb7rIsi+1+sLK4L38D69g7XNXujZjj3juqxC+D/ydu6e5jP+ew9WlAUajUXymX2
	RVZcTptHYxrghME2bsuZYxrCjZIGVv8=
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
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test fentry link after tracing_multi link
Date: Sat, 11 Jul 2026 20:48:22 +0800
Message-ID: <20260711124822.29406-3-leon.hwang@linux.dev>
In-Reply-To: <20260711124822.29406-1-leon.hwang@linux.dev>
References: <20260711124822.29406-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Verify that there's no any issue to attach tracing_multi link, then attach
fentry link.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 69 +++++++++++++++++++
 .../progs/tracing_multi_intersect_attach.c    |  8 +++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index f02ffc7f41d7..0aa9532a05cf 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -460,6 +460,73 @@ static void test_intersect(void)
 	tracing_multi_intersect__destroy(skel);
 }
 
+static void test_fentry_after_multi(void)
+{
+	static const char * const funcs[] = {
+		"bpf_fentry_test1",
+	};
+	struct bpf_link *fentry_link = NULL, *multi_link = NULL;
+	struct tracing_multi_intersect *skel = NULL;
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	__u32 *ids = NULL;
+	int err;
+
+	skel = tracing_multi_intersect__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_intersect__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	ids = get_ids(funcs, ARRAY_SIZE(funcs), NULL);
+	if (!ASSERT_OK_PTR(ids, "get_ids"))
+		goto cleanup;
+
+	opts.ids = ids;
+	opts.cnt = ARRAY_SIZE(funcs);
+	multi_link = bpf_program__attach_tracing_multi(skel->progs.fentry_1, NULL, &opts);
+	if (!ASSERT_OK_PTR(multi_link, "attach_multi"))
+		goto cleanup;
+
+	fentry_link = bpf_program__attach(skel->progs.fentry);
+	if (!ASSERT_OK_PTR(fentry_link, "attach_fentry"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry_1), &topts);
+	if (!ASSERT_OK(err, "test_run"))
+		goto cleanup;
+	ASSERT_EQ(skel->bss->test_result_fentry_1, 1, "multi_fentry");
+	ASSERT_EQ(skel->bss->test_result_fentry, 1, "fentry");
+
+	err = bpf_link__destroy(fentry_link);
+	fentry_link = NULL;
+	if (!ASSERT_OK(err, "destroy_fentry"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry_1), &topts);
+	if (!ASSERT_OK(err, "test_run_multi"))
+		goto cleanup;
+	ASSERT_EQ(skel->bss->test_result_fentry_1, 2, "multi_fentry_only");
+	ASSERT_EQ(skel->bss->test_result_fentry, 1, "fentry_detached");
+
+	err = bpf_link__destroy(multi_link);
+	multi_link = NULL;
+	if (!ASSERT_OK(err, "destroy_multi"))
+		goto cleanup;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.fentry_1), &topts);
+	if (!ASSERT_OK(err, "test_run_detached"))
+		goto cleanup;
+	ASSERT_EQ(skel->bss->test_result_fentry_1, 2, "multi_fentry_detached");
+	ASSERT_EQ(skel->bss->test_result_fentry, 1, "fentry_still_detached");
+
+cleanup:
+	bpf_link__destroy(fentry_link);
+	bpf_link__destroy(multi_link);
+	free(ids);
+	tracing_multi_intersect__destroy(skel);
+}
+
 static void test_session(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, topts);
@@ -957,4 +1024,6 @@ void test_tracing_multi_test(void)
 	if (test__start_subtest("attach_api_fails"))
 		test_attach_api_fails();
 	RUN_TESTS(tracing_multi_verifier);
+	if (test__start_subtest("fentry_after_multi"))
+		test_fentry_after_multi();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
index cd5be0bb6ffd..5b0af8f4c62f 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
@@ -11,6 +11,14 @@ __u64 test_result_fentry_1 = 0;
 __u64 test_result_fentry_2 = 0;
 __u64 test_result_fexit_1 = 0;
 __u64 test_result_fexit_2 = 0;
+__u64 test_result_fentry = 0;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry)
+{
+	tracing_multi_arg_check(ctx, &test_result_fentry, false);
+	return 0;
+}
 
 SEC("fentry.multi")
 int BPF_PROG(fentry_1)
-- 
2.55.0

