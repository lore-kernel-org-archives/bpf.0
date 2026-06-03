Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9473C4B92;
	Wed,  3 Jun 2026 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485043; cv=none; b=rLXCWuViPPnb5L+x1vZiG+DDiMTSjp+UU5oBBLtdpwTLW5yAnOmlRECvIOJ5Q4nVRRSbry/4cxjPSfdVwRrJixScxs5YgC71UJCz0k2qwrHPDm1T+t6icu7EuvCp4G5lkZOl1t7BTC2IXaiLwbHPNpTGZSbex7FHmjtAidA2J1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485043; c=relaxed/simple;
	bh=lNKcBBWezCecz633U9HN0ObDKiBWXhi3a3ZqYTkiFgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9J5byg0JdnZ869Z/7o+QZU6xdeF9lHeXBOv/JYKVOGdy0PdumMcTTqfnOCc4/FOSxm0IqYx8uBRhS0OG9K/NhLqXptPr5WB3Oc85I/br0LHj0AAhO3oniqJGUf1C0dr31dCAzAsFQXBc09rZDXtakSRAsSBHkVZf/+de2yXVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7aDW/hs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7aDW/hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1311F00893;
	Wed,  3 Jun 2026 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485042;
	bh=OYryM4IL5R21TruhIPh1/4IKGAN4r4ju1WNs1rr0T3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b7aDW/hsLPK1frMEOCgVUvrTMmqwyZLiaqb592cBhfT7X9Lxb4W8Lcr+u7e1RQkqH
	 lSmm3AESFVK7Dff8gpDIYymGMAoPYEYGiVPPx6Bo4tMRd68Li/Hy7Y13M35BQA8keF
	 fp7m88+z3acMT8uYERgeLPJwicWRzkniZTY9A7wETd6J/Jn1Yut2UPY8nKTtGQ6oJH
	 8zVrN2091wOFBScSHBL9YND83dymG33KDPIp3jZupXcvFsx5/CuEul6k1qdgy9wTyN
	 IBJHYh1BUkLLzTcHkuvHljVxYmNXqbGjlFQrGiHLXaExgyj7ksdWD3wUexauAIB4zY
	 Zig62x/9a+mBA==
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
Subject: [PATCHv7 bpf-next 26/29] selftests/bpf: Add tracing multi attach fails test
Date: Wed,  3 Jun 2026 13:05:50 +0200
Message-ID: <20260603110554.29590-27-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603110554.29590-1-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
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
index 05683b8d0680..7e1bb071ce2a 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -8,6 +8,7 @@
 #include "tracing_multi_module.skel.h"
 #include "tracing_multi_intersect.skel.h"
 #include "tracing_multi_session.skel.h"
+#include "tracing_multi_fail.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -498,6 +499,99 @@ static void test_session(void)
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
+	ASSERT_EQ(libbpf_get_error(skel->links.test_fentry), -EINVAL, "fail_7");
+
+cleanup:
+	tracing_multi_fail__destroy(skel);
+	free(ids2);
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
@@ -523,4 +617,6 @@ void test_tracing_multi_test(void)
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
2.54.0

