Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56F5FB90
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891551; cv=none; b=BdVBH6945bSBjdl+doxBMtCDT9tKyisTSQgTcJc0oqQpVfTGBL/tDsUU654KelrRDsH+1NbBBWhQW2tgAD/Kzy88zP7hGZRactKwWkP3JVxSHrt66ZC+PVZ7vEzOURZnlNj+mZnD7jW0f+fnRi9ZhzM/xrBdT/Iaz6KqClWaUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891551; c=relaxed/simple;
	bh=3WS8G0YJ6pdKIokO0MY1aAi+HMY2xMEhlU32LBgq0Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvcRnOwIXkSj8Shaf6iF392qEjNZkMVMvsRxg1y6Rk/deZXGhbQwGojd6dMXXZXztzix2VLzne3ct5VPuEPZLbL8TFhF2wMwhphoIq1UPUJ8sXNMG+6purPXqrizP+44jQJYKzjznmd/cf0v1fCqv876CyoossS/Pp68mVLeceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJb5tMPK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJb5tMPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51490C433F1;
	Tue, 19 Mar 2024 23:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710891551;
	bh=3WS8G0YJ6pdKIokO0MY1aAi+HMY2xMEhlU32LBgq0Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJb5tMPKGKiSwLAq31Uv/8WqxakaP+2OeRhivlNkWooVCQDBdaMiIDXeQUbVzcMDp
	 x4YgeK/V1XVw1Q/T9/+WcgnCcZLaO8FD+SW89m6bcoRmNu1N7qRvDOfzdfeD06Ggs3
	 Df6rGJKJ/Q/6jiA+kF9UDJZrA97BfS+ojY4IDULZLFCtQNnAhbverNQzffDr5x/Zjq
	 f9bkyxPECi9C6KplZ7YAVXHTz7SnbedyDaEpoGE/HO0y3oxxQmPtKXMiFB9l30SDam
	 ISD8Q93QpnxqYzR3ZDhC0N2L8aHk2crzGgxoNN9q2fdZrRx1WxLUrr4ARhwte/dbK6
	 86GSVD3rPhkMA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com,
	Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v3 bpf-next 5/5] selftests/bpf: add raw_tp/tp_btf BPF cookie subtests
Date: Tue, 19 Mar 2024 16:38:52 -0700
Message-ID: <20240319233852.1977493-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240319233852.1977493-1-andrii@kernel.org>
References: <20240319233852.1977493-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test validating BPF cookie can be passed during raw_tp/tp_btf
attachment and can be retried at runtime with bpf_get_attach_cookie()
helper.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 114 +++++++++++++++++-
 .../selftests/bpf/progs/test_bpf_cookie.c     |  16 +++
 2 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 1454cebc262b..4407ea428e77 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -573,6 +573,115 @@ static void lsm_subtest(struct test_bpf_cookie *skel)
 		close(lsm_fd);
 }
 
+static void tp_btf_subtest(struct test_bpf_cookie *skel)
+{
+	__u64 cookie;
+	int prog_fd, link_fd = -1;
+	struct bpf_link *link = NULL;
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	LIBBPF_OPTS(bpf_raw_tp_opts, raw_tp_opts);
+	LIBBPF_OPTS(bpf_trace_opts, trace_opts);
+
+	/* There are three different ways to attach tp_btf (BTF-aware raw
+	 * tracepoint) programs. Let's test all of them.
+	 */
+	prog_fd = bpf_program__fd(skel->progs.handle_tp_btf);
+
+	/* low-level BPF_RAW_TRACEPOINT_OPEN command wrapper */
+	skel->bss->tp_btf_res = 0;
+
+	raw_tp_opts.cookie = cookie = 0x11000000000000L;
+	link_fd = bpf_raw_tracepoint_open_opts(prog_fd, &raw_tp_opts);
+	if (!ASSERT_GE(link_fd, 0, "bpf_raw_tracepoint_open_opts"))
+		goto cleanup;
+
+	usleep(1); /* trigger */
+	close(link_fd); /* detach */
+	link_fd = -1;
+
+	ASSERT_EQ(skel->bss->tp_btf_res, cookie, "raw_tp_open_res");
+
+	/* low-level generic bpf_link_create() API */
+	skel->bss->tp_btf_res = 0;
+
+	link_opts.tracing.cookie = cookie = 0x22000000000000L;
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_RAW_TP, &link_opts);
+	if (!ASSERT_GE(link_fd, 0, "bpf_link_create"))
+		goto cleanup;
+
+	usleep(1); /* trigger */
+	close(link_fd); /* detach */
+	link_fd = -1;
+
+	ASSERT_EQ(skel->bss->tp_btf_res, cookie, "link_create_res");
+
+	/* high-level bpf_link-based bpf_program__attach_trace_opts() API */
+	skel->bss->tp_btf_res = 0;
+
+	trace_opts.cookie = cookie = 0x33000000000000L;
+	link = bpf_program__attach_trace_opts(skel->progs.handle_tp_btf, &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach_trace_opts"))
+		goto cleanup;
+
+	usleep(1); /* trigger */
+	bpf_link__destroy(link); /* detach */
+	link = NULL;
+
+	ASSERT_EQ(skel->bss->tp_btf_res, cookie, "attach_trace_opts_res");
+
+cleanup:
+	if (link_fd >= 0)
+		close(link_fd);
+	bpf_link__destroy(link);
+}
+
+static void raw_tp_subtest(struct test_bpf_cookie *skel)
+{
+	__u64 cookie;
+	int prog_fd, link_fd = -1;
+	struct bpf_link *link = NULL;
+	LIBBPF_OPTS(bpf_raw_tp_opts, raw_tp_opts);
+	LIBBPF_OPTS(bpf_raw_tracepoint_opts, opts);
+
+	/* There are two different ways to attach raw_tp programs */
+	prog_fd = bpf_program__fd(skel->progs.handle_raw_tp);
+
+	/* low-level BPF_RAW_TRACEPOINT_OPEN command wrapper */
+	skel->bss->raw_tp_res = 0;
+
+	raw_tp_opts.tp_name = "sys_enter";
+	raw_tp_opts.cookie = cookie = 0x55000000000000L;
+	link_fd = bpf_raw_tracepoint_open_opts(prog_fd, &raw_tp_opts);
+	if (!ASSERT_GE(link_fd, 0, "bpf_raw_tracepoint_open_opts"))
+		goto cleanup;
+
+	usleep(1); /* trigger */
+	close(link_fd); /* detach */
+	link_fd = -1;
+
+	ASSERT_EQ(skel->bss->raw_tp_res, cookie, "raw_tp_open_res");
+
+	/* high-level bpf_link-based bpf_program__attach_raw_tracepoint_opts() API */
+	skel->bss->raw_tp_res = 0;
+
+	opts.cookie = cookie = 0x66000000000000L;
+	link = bpf_program__attach_raw_tracepoint_opts(skel->progs.handle_raw_tp,
+						       "sys_enter", &opts);
+	if (!ASSERT_OK_PTR(link, "attach_raw_tp_opts"))
+		goto cleanup;
+
+	usleep(1); /* trigger */
+	bpf_link__destroy(link); /* detach */
+	link = NULL;
+
+	ASSERT_EQ(skel->bss->raw_tp_res, cookie, "attach_raw_tp_opts_res");
+
+cleanup:
+	if (link_fd >= 0)
+		close(link_fd);
+	bpf_link__destroy(link);
+}
+
 void test_bpf_cookie(void)
 {
 	struct test_bpf_cookie *skel;
@@ -601,6 +710,9 @@ void test_bpf_cookie(void)
 		tracing_subtest(skel);
 	if (test__start_subtest("lsm"))
 		lsm_subtest(skel);
-
+	if (test__start_subtest("tp_btf"))
+		tp_btf_subtest(skel);
+	if (test__start_subtest("raw_tp"))
+		raw_tp_subtest(skel);
 	test_bpf_cookie__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
index 5a3a80f751c4..c83142b55f47 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
@@ -15,6 +15,8 @@ __u64 uprobe_res;
 __u64 uretprobe_res;
 __u64 tp_res;
 __u64 pe_res;
+__u64 raw_tp_res;
+__u64 tp_btf_res;
 __u64 fentry_res;
 __u64 fexit_res;
 __u64 fmod_ret_res;
@@ -87,6 +89,20 @@ int handle_pe(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("raw_tp/sys_enter")
+int handle_raw_tp(void *ctx)
+{
+	update(ctx, &raw_tp_res);
+	return 0;
+}
+
+SEC("tp_btf/sys_enter")
+int handle_tp_btf(void *ctx)
+{
+	update(ctx, &tp_btf_res);
+	return 0;
+}
+
 SEC("fentry/bpf_fentry_test1")
 int BPF_PROG(fentry_test1, int a)
 {
-- 
2.43.0

