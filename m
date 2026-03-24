Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715338B7A6;
	Tue, 24 Mar 2026 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340570; cv=none; b=IZv3mqyW0TzLlTYD36X0/Lmq7FH6wTqSmNB0H9iSTitsbTiBQlfW8yJnWHFvOlLIin7n5HAHKwwsOiheT0QcZ8VxCO3dW1OYSgJnA2UGfZU+eOU86p+BH9hJjFgmiGPw2x+7erAeaAVQroHNvLt5C9Hlc097TApMxsbFXKxnrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340570; c=relaxed/simple;
	bh=q45c42DUrXLBGL+GWIoydV33mhnIFSgwq3UYvVPt0rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWCdfMNwxXXLor9OmaQIpzVM0udlcshTKYAG3PGcdVKv/RyNVGLmzGpfQW9jikq58ONsbtEHgRSDERFy2zKf46CxYMhAv0k5wP3tkwnOY9JuMOnYR7+AcxwYh7GBntCbkRU++TG8j3wLiIhVFtdXHXN7x/AE5qoQlipodk+39y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb2RfNO/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb2RfNO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970B9C2BCB3;
	Tue, 24 Mar 2026 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340570;
	bh=q45c42DUrXLBGL+GWIoydV33mhnIFSgwq3UYvVPt0rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nb2RfNO/YOJhvEdyH3zwb7T1SugT7NY8wmqzreAIS84jYGMVQaaC8pxvjJ5zuTmg1
	 9iB2jNjAbwnqemtmRYOWTN/5bs1yyBkZgHrZU2oz0S8EJTGVWMF1Lmb25J0RZ1Ct2s
	 cJx2bY6NPtxmMcyFMJz3tEeW7JNH/U1b2Nd2GMz/oOMcgqxY04zsLEFcTXpIx/7iEs
	 pxV9YnmXtiqZXaEB/Tj0uynvcWuTb7B/w6pGElyjX/wa7RoerA4MSU8gvHhlZniLIk
	 vLTmBBiVi0fFTCMYq6/stxcNRLwF26LfQkCeQZ/JEkd/vWXgfYmWJPXp5vkOC1RiQo
	 891fCeUdboD3g==
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
Subject: [PATCHv4 bpf-next 23/25] selftests/bpf: Add tracing multi attach fails test
Date: Tue, 24 Mar 2026 09:18:44 +0100
Message-ID: <20260324081846.2334094-24-jolsa@kernel.org>
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

Adding tests for attach fails on tracing multi link.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 86 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_fail.c  | 18 ++++
 2 files changed, 104 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 2ed43e4719cd..dece45d8fb5e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -8,6 +8,7 @@
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
+#include "tracing_multi_fail.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -487,6 +488,89 @@ static void test_session(void)
 	tracing_multi_session__destroy(skel);
 }
 
+static void test_attach_api_fails(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	static const char * const func[] = {
+		"bpf_fentry_test2",
+	};
+	struct tracing_multi_fail *skel = NULL;
+	__u32 ids[2], *ids2 = NULL;
+	__u64 cookies[2];
+
+	skel = tracing_multi_fail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_fail__open_and_load"))
+		return;
+
+	/* fail#1 pattern and opts NULL */
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, NULL);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_1"))
+		goto cleanup;
+
+	/* fail#2 pattern and ids */
+	opts.ids = ids;
+	opts.cnt = 2;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_2"))
+		goto cleanup;
+
+	/* fail#3 pattern and cookies */
+	opts.ids = NULL;
+	opts.cnt = 2;
+	opts.cookies = cookies;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_3"))
+		goto cleanup;
+
+	/* fail#4 bogus pattern */
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_not_really_a_function*", NULL);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_4"))
+		goto cleanup;
+
+	/* fail#5 abnormal cnt */
+	opts.ids = ids;
+	opts.cnt = INT_MAX;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -E2BIG, "fail_5"))
+		goto cleanup;
+
+	/* fail#6 attach sleepable program to not-allowed function */
+	ids2 = get_ids(func, 1, NULL);
+	if (!ASSERT_OK_PTR(ids2, "get_ids"))
+		goto cleanup;
+
+	opts.ids = ids2;
+	opts.cnt = 1;
+
+	skel->links.test_fentry_s = bpf_program__attach_tracing_multi(skel->progs.test_fentry_s,
+						NULL, &opts);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry_s), -EINVAL, "fail_6"))
+		goto cleanup;
+
+	/* fail#7 attach with duplicate id */
+	ids[0] = ids2[0];
+	ids[1] = ids2[0];
+
+	opts.ids = ids;
+	opts.cnt = 2;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EBUSY, "fail_7");
+
+cleanup:
+	tracing_multi_fail__destroy(skel);
+	free(ids2);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -512,4 +596,6 @@ void test_tracing_multi_test(void)
 		test_link_api_ids(true);
 	if (test__start_subtest("session"))
 		test_session();
+	if (test__start_subtest("attach_api_fails"))
+		test_attach_api_fails();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fail.c b/tools/testing/selftests/bpf/progs/tracing_multi_fail.c
new file mode 100644
index 000000000000..7f0375f4213d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_fail.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry.multi")
+int BPF_PROG(test_fentry)
+{
+	return 0;
+}
+
+SEC("fentry.multi.s")
+int BPF_PROG(test_fentry_s)
+{
+	return 0;
+}
-- 
2.53.0

