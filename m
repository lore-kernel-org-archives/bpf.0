Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776953E3D95
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534684; cv=none; b=JM9PfQl3QkWmdtjj6ruZProwfN2EZdiyg+crNvFUkHS3rCLlgp+VauoCV7F4E5v/QahpgjOtsWs0bMN7slv2s4g0wZn64ZTWVuKZV5p34l7RAzwno3GR9rLe4ITPY/UOKQncpDrC4uZg+WWNVZgnOuN3yzfQOic8Ou4lG+H23wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534684; c=relaxed/simple;
	bh=0Qon4HZXDLs7KJsJb3LtUW6XavGkmseM2RWCIuxU8mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9kyCbw3vyr4NpCZ14OpaJ1kHeDj4l5ZVmqkSrj+1O0+u6wf7EEzLkeDcLlsUCRGWlbgUH5TXwZ3zUvxWgQeizKzCjmV9o+ShWW4cpZXXH3fdozoJ+MRhLiiW/pEXTTqgQmLRI2kHV39wzDZ1XzQuVyIPp7k9Agye+5OatNg3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xm5TdffL; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xm5TdffL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774534676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/h86vRb5ozacPc84nj3zyoBMhFdjKDRSZefVweQNT8=;
	b=xm5TdffLI2ncOD+YXPE61UQvdGMNyhdD5AgviaDMtEnZSZFhiN9aSlR9af6gQU5i1gwaEi
	MjIKAegK5OTkdbHBV0ZG3N+wxfI3sIMRgnjbYfXEhBHGhBCw3vn5cxCYuNnEZA5mZF+B4v
	2f6bl4JNbv1cBLPvFEjqIaRx3/BlcXU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	Leon Hwang <leon.hwang@linux.dev>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add test to verify the fix of kprobe_write_ctx abuse
Date: Thu, 26 Mar 2026 22:17:18 +0800
Message-ID: <20260326141718.17731-3-leon.hwang@linux.dev>
In-Reply-To: <20260326141718.17731-1-leon.hwang@linux.dev>
References: <20260326141718.17731-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a test to verify the issue: kprobe_write_ctx can be abused to modify
struct pt_regs of kernel functions via kprobe_write_ctx=true freplace
progs.

Without the fix, the issue is verified:

kprobe_write_ctx=true freplace prog is allowed to attach to
kprobe_write_ctx=false kprobe prog. Then, the first arg of
bpf_fentry_test1 will be set as 0, and bpf_prog_test_run_opts() gets
-EFAULT instead of 0.

With the fix, the issue is rejected at attach time.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 64 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    | 19 ++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9e77e5da7097..4d253900c4ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -220,11 +220,73 @@ static void test_attach_kprobe_write_ctx(void)
 
 	kprobe_write_ctx__destroy(skel);
 }
+
+static void test_freplace_kprobe_write_ctx(void)
+{
+	struct bpf_program *prog_kprobe, *prog_ext, *prog_fentry;
+	struct kprobe_write_ctx *skel_kprobe, *skel_ext = NULL;
+	struct bpf_link *link_kprobe = NULL, *link_ext = NULL;
+	int err, prog_fd;
+	LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	skel_kprobe = kprobe_write_ctx__open();
+	if (!ASSERT_OK_PTR(skel_kprobe, "kprobe_write_ctx__open kprobe"))
+		return;
+
+	prog_kprobe = skel_kprobe->progs.kprobe_dummy;
+	bpf_program__set_autoload(prog_kprobe, true);
+
+	prog_fentry = skel_kprobe->progs.fentry;
+	bpf_program__set_autoload(prog_fentry, true);
+
+	err = kprobe_write_ctx__load(skel_kprobe);
+	if (!ASSERT_OK(err, "kprobe_write_ctx__load kprobe"))
+		goto out;
+
+	skel_ext = kprobe_write_ctx__open();
+	if (!ASSERT_OK_PTR(skel_ext, "kprobe_write_ctx__open ext"))
+		goto out;
+
+	prog_ext = skel_ext->progs.freplace_kprobe;
+	bpf_program__set_autoload(prog_ext, true);
+
+	prog_fd = bpf_program__fd(skel_kprobe->progs.kprobe_write_ctx);
+	bpf_program__set_attach_target(prog_ext, prog_fd, "kprobe_write_ctx");
+
+	err = kprobe_write_ctx__load(skel_ext);
+	if (!ASSERT_OK(err, "kprobe_write_ctx__load ext"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog_kprobe);
+	link_ext = bpf_program__attach_freplace(prog_ext, prog_fd, "kprobe_dummy");
+	ASSERT_ERR_PTR(link_ext, "bpf_program__attach_freplace link");
+	ASSERT_EQ(errno, EINVAL, "bpf_program__attach_freplace errno");
+
+	link_kprobe = bpf_program__attach_kprobe_opts(prog_kprobe, "bpf_fentry_test1",
+						      &kprobe_opts);
+	if (!ASSERT_OK_PTR(link_kprobe, "bpf_program__attach_kprobe_opts"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog_fentry), &topts);
+	ASSERT_OK(err, "bpf_prog_test_run_opts");
+
+out:
+	bpf_link__destroy(link_ext);
+	bpf_link__destroy(link_kprobe);
+	kprobe_write_ctx__destroy(skel_ext);
+	kprobe_write_ctx__destroy(skel_kprobe);
+}
 #else
 static void test_attach_kprobe_write_ctx(void)
 {
 	test__skip();
 }
+
+static void test_freplace_kprobe_write_ctx(void)
+{
+	test__skip();
+}
 #endif
 
 static void test_attach_probe_auto(struct test_attach_probe *skel)
@@ -434,6 +496,8 @@ void test_attach_probe(void)
 		test_attach_kprobe_long_event_name();
 	if (test__start_subtest("kprobe-write-ctx"))
 		test_attach_kprobe_write_ctx();
+	if (test__start_subtest("freplace-kprobe-write-ctx"))
+		test_freplace_kprobe_write_ctx();
 
 cleanup:
 	test_attach_probe__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
index f77aef0474d3..adbf52afe490 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
@@ -19,4 +19,23 @@ int kprobe_multi_write_ctx(struct pt_regs *ctx)
 	ctx->ax = 0;
 	return 0;
 }
+
+SEC("?kprobe")
+int kprobe_dummy(struct pt_regs *regs)
+{
+	return 0;
+}
+
+SEC("?freplace")
+int freplace_kprobe(struct pt_regs *regs)
+{
+	regs->di = 0;
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(fentry)
+{
+	return 0;
+}
 #endif
-- 
2.53.0

