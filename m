Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6E3264F5;
	Wed,  4 Mar 2026 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663129; cv=none; b=h6BIaDNF6nSQkprO0P73zS1e6flEruib/BRLzKJsHxqOFpfCenYAPowMgZMEViRxILBzcdfTGtAXLKzXPHsD9ryAwBivop44CllVRL5GVqhSSLZplc4Kz3dTj4ufORMMiPr36ezS2L+YBT6ac9/o3a1e2516+tiBg8BzHo/TXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663129; c=relaxed/simple;
	bh=3bg51RQSILKreyvAcl9sDTk8WHKVMEidW9Frq/Q/XZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw+O4QZAB+kcdggnVE179ozwTqe6cFn4K76dQK8tP26opWA5nXuFUpt3P+snNiQkXYu8qU/XEUb5yDN071q60r1qFAuUNTqVKFYPJluy2/cXmEdDymNPVUIMR9CL3dMKwjfc7YtuoCb3e3VcuhS+GBHr2SDnwn43dBbQKziV4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju/Zr5yz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju/Zr5yz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C41C4CEF7;
	Wed,  4 Mar 2026 22:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663128;
	bh=3bg51RQSILKreyvAcl9sDTk8WHKVMEidW9Frq/Q/XZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ju/Zr5yzPq89BHxak9hq9/buZjB48neHdP4d2oue5M7u9gKChsjTYG7jv5lOrahFg
	 D3L4I/njnzRN9GW5nY3aDdlFESAn08EtQMLhLPl/s9O1sAgLUeqmzHDTmcwjadIM26
	 mB8D+Fm5ZEb79peOcdDbl1jWvmBHezK9xwuNn0aP7tKPBZ1DwAPinIesd6bTLnTqK3
	 AjX7DJ+UCq0ABBVcrgmSytnDWsiCNOt6+gD95VCW5gS+FN7PR2jYvDYYp9OalMUhVh
	 GAYiaTk6HYlXdifQtJlOnBVY9XM0oPaaB+zWM/gaGYIar4JraliKmuyra4AC7bZm7n
	 GEQZRJ6VWTxmA==
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
Subject: [PATCHv2 bpf-next 21/23] selftests/bpf: Add tracing multi attach fails test
Date: Wed,  4 Mar 2026 23:21:39 +0100
Message-ID: <20260304222141.497203-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222141.497203-1-jolsa@kernel.org>
References: <20260304222141.497203-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/tracing_multi.c  | 74 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_fail.c  | 19 +++++
 2 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 3a55a2aed9a0..d64d90f4e086 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -8,6 +8,7 @@
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
+#include "tracing_multi_fail.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -471,6 +472,77 @@ static void test_session(void)
 	tracing_multi_session__destroy(skel);
 }
 
+static void test_attach_api_fails(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	static const char * const func[] = {
+		"bpf_fentry_test2",
+	};
+	struct tracing_multi_fail *skel = NULL;
+	__u32 ids[2], *ids2;
+	__u64 cookies[2];
+
+	skel = tracing_multi_fail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_fail__open_and_load"))
+		return;
+
+	/* fail#1 pattern and opts NULL */
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, NULL);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#2 pattern and ids */
+	opts.ids = ids;
+	opts.cnt = 2;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#3 pattern and cookies */
+	opts.ids = NULL;
+	opts.cnt = 2;
+	opts.cookies = cookies;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_fentry_test*", &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#4 bogus pattern */
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						"bpf_not_really_a_function*", NULL);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#5 abnormal cnt */
+	opts.ids = ids;
+	opts.cnt = INT_MAX;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* fail#6 attach sleepable program to not-allowed function */
+	ids2 = get_ids(func, 1, NULL);
+	if (!ASSERT_OK_PTR(ids, "get_ids"))
+		goto cleanup;
+
+	opts.ids = ids2;
+	opts.cnt = 1;
+
+	skel->links.test_fentry_s = bpf_program__attach_tracing_multi(skel->progs.test_fentry_s,
+						NULL, &opts);
+	ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi");
+	free(ids2);
+
+cleanup:
+	tracing_multi_fail__destroy(skel);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -496,4 +568,6 @@ void test_tracing_multi_test(void)
 		test_link_api_ids(true);
 	if (test__start_subtest("session"))
 		test_session();
+	if (test__start_subtest("attach_api_fails"))
+		test_attach_api_fails();
 }
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fail.c b/tools/testing/selftests/bpf/progs/tracing_multi_fail.c
new file mode 100644
index 000000000000..8f769ddb9136
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_fail.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <linux/bpf.h>
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

