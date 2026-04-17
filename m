Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D932694E;
	Fri, 17 Apr 2026 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454189; cv=none; b=OCQamXVPqmQVv5jiorHt1CWfZLBV8gWTXf/BU/sq9sRX0VSnCjeRzZss9e0EBE5v6NrE2gee7rZtrkFt7qW9Dl6M/vrjvPi9DdXsrAU0N9HIua2ly5PdJxFAuGr3yYh5CxLc806wVhGPqc4r84zks8z/dYVYMBMjHe3V3mMTrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454189; c=relaxed/simple;
	bh=xaZsM4GJaWP/m92nGhT7yMIKCwhZmWcm/MN1Fi86CHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+Fv15VVrfMKQ/bi6gRItx1WUwmlDXsOnytPA0k47nYk1jnKD+lGkOf+RRjz1/10ALkjmQEMF2MNdU1nMjGUeYrt57IJC6UxaazswihE2Sz5EOC8kXrWLyqrB7uYD8nErcM1J8zrzhKpiLIL8FBFY2BvkCbuQnTQga4RguVxRtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SctDfkx3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SctDfkx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422CEC19425;
	Fri, 17 Apr 2026 19:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776454189;
	bh=xaZsM4GJaWP/m92nGhT7yMIKCwhZmWcm/MN1Fi86CHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SctDfkx3+vmEWr0f3SXhMnQMw0GIPeuzxbQ5iE9XrNNAdK83yUtLO5D5HOS64PSXA
	 pJNFdpjtxXEcnZLFJWK0sjYLkOPD38KJ4APLylWwwDQCNHMb5OVkFNnXA+Z1L5+kNf
	 Rzv6teV0XSpqMxBMuhzxIaU6nhoL85Zo8G6VgB1kH4uniftkfkDkHMCEVfBIEiIFFT
	 AhCxHFYearnLJVtdGDzFZcqmBQq4h+YW0K0kDQBgNjx9JFFhLTrCZIYhbUjSpsnCHN
	 XUsJuGpDMTfDGa7xfh2u9EXQW+oXc4jIF9y4b2CA3okZWalPm5mvltwdbCeXQzDXyB
	 K++Wf//6diWJw==
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
Subject: [PATCHv5 bpf-next 26/28] selftests/bpf: Add tracing multi attach fails test
Date: Fri, 17 Apr 2026 21:25:00 +0200
Message-ID: <20260417192502.194548-27-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417192502.194548-1-jolsa@kernel.org>
References: <20260417192502.194548-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/tracing_multi.c  | 96 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_fail.c  | 18 ++++
 2 files changed, 114 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index d91043cf8dc8..2edb3797970b 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -8,6 +8,7 @@
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
+#include "tracing_multi_fail.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -491,6 +492,99 @@ static void test_session(void)
 	tracing_multi_session__destroy(skel);
 }
 
+static void test_attach_api_fails(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	static const char * const func[] = {
+		"bpf_fentry_test2",
+	};
+	struct tracing_multi_fail *skel = NULL;
+	__u32 ids[2] = {}, *ids2 = NULL;
+	__u64 cookies[2];
+
+	skel = tracing_multi_fail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_fail__open_and_load"))
+		return;
+
+	/* fail#1 (libbpf) pattern and opts NULL */
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, NULL);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_1"))
+		goto cleanup;
+
+	/* fail#2 (libbpf) pattern and ids */
+	LIBBPF_OPTS_RESET(opts,
+		.ids = ids,
+		.cnt = 2,
+	);
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_2"))
+		goto cleanup;
+
+	/* fail#3 (libbpf) pattern and cookies */
+	LIBBPF_OPTS_RESET(opts,
+		.ids = NULL,
+		.cnt = 2,
+		.cookies = cookies,
+	);
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_3"))
+		goto cleanup;
+
+	/* fail#4 (libbpf) bogus pattern */
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_not_really_a_function*", NULL);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_4"))
+		goto cleanup;
+
+	/* fail#5 (kernel) abnormal cnt */
+	LIBBPF_OPTS_RESET(opts,
+		.ids = ids,
+		.cnt = INT_MAX,
+	);
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -E2BIG, "fail_5"))
+		goto cleanup;
+
+	/* fail#6 (kernel) attach sleepable program to not-allowed function */
+	ids2 = get_ids(func, 1, NULL);
+	if (!ASSERT_OK_PTR(ids2, "get_ids"))
+		goto cleanup;
+
+	LIBBPF_OPTS_RESET(opts,
+		.ids = ids2,
+		.cnt = 1,
+	);
+
+	skel->links.test_fentry_s = bpf_program__attach_tracing_multi(skel->progs.test_fentry_s,
+						NULL, &opts);
+	if (!ASSERT_EQ(libbpf_get_error(skel->links.test_fentry_s), -EINVAL, "fail_6"))
+		goto cleanup;
+
+	/* fail#7 (kernel) attach with duplicate id */
+	ids[0] = ids2[0];
+	ids[1] = ids2[0];
+
+	LIBBPF_OPTS_RESET(opts,
+		.ids = ids,
+		.cnt = 2,
+	);
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
@@ -516,4 +610,6 @@ void test_tracing_multi_test(void)
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

