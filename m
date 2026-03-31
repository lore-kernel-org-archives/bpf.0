Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013233A7F70
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968886; cv=none; b=nqGuBXJ8rxJuTPppM13nRH1dYyqy0myhDIHy2revB5rAvVMRHSp1ad8CjgRbnRVZfZhL+EQtkH5OvyBSlnjfDqN4GYV2T1cKRVcDCy7bwMcgzLpSrJPvQ9Uai741T8f8wRK1DQOLwtsnFbN199x1kYleBOIN4emJMkn1Epfcf28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968886; c=relaxed/simple;
	bh=x27V+IEw1MBBIM1+TXEfu6ygBI0xSx84AHvLZ+62gd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5wedZVlPEUWFPEYQB0yCYOuHXqSyVwMncaY8iVs/xdIhg8rwSM82RZvqBMpWpnVubF3qIltcR87kY4r7G5FnZ5gQKOsCenboqupqtScQLOiVOehPryaUmhonBY5mG2ol4MRo9GG5psNKK9Dvskz8aaRVzP76BjaWnvZ0apZN4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vGSBbDxM; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vGSBbDxM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774968883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SM+QVdZlIbNSt11DNnuXfk71/Inw0TohdIdeU6+Lf4A=;
	b=vGSBbDxM7oqt8qD6RQde/FOMv/QvHJqz9gony6PWjXtWWzkEUS5LCiBTzbjsag5TGDyrrj
	loZ+PoF79Gm2gFjl2i4ezhqRjqY60bOox9kQuhOa9/XJccVQtfJ4ci71TNYMbSU2SjixAt
	AONSrzKd9n1sZslaS3VGcK29A6x+Kqw=
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add test to verify the fix of kprobe_write_ctx abuse
Date: Tue, 31 Mar 2026 22:53:53 +0800
Message-ID: <20260331145353.87606-3-leon.hwang@linux.dev>
In-Reply-To: <20260331145353.87606-1-leon.hwang@linux.dev>
References: <20260331145353.87606-1-leon.hwang@linux.dev>
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

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 64 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    | 19 ++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9e77e5da7097..38852df70c0d 100644
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
+	ASSERT_EQ(libbpf_get_error(link_ext), -EINVAL, "bpf_program__attach_freplace error");
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

