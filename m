Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3C0350A1B;
	Wed,  4 Mar 2026 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663149; cv=none; b=EhhsAK9/xbqbigNwKMzMapLaH64pBaSo3s8UTb0bvmGlPXpF3jrPD0MlFOMUxmXYtd1q546/3A2enBZh3UL4U4j+ZYQpK6h0dUDxDPY250GYANKvKAdhyF7/zxQThavnjw90VSpOc4vJvcOcYEqXivfJTURXKwSixvHJczWxncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663149; c=relaxed/simple;
	bh=lCTa9Qd1u2nL91zcwpE+OEBQhBxpQ7EU0l+Y2nrxd/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZNuFiyF4+MT3OFcEQTJZE+HhqZmpIGcV9AlW6uo3Uji1lxqaR5yEFOlcJ9vuVEDpA0Wbl3CJ3EkF/NJ1yYMDup1TVo21gnoHoobTOuF1BpjixSE+0NuIXjvKlx+SSf0ikplvZHbDRTxCmcSgV6i1AkSA4cCk752UHMyJf0o980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBbu05lp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBbu05lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D08C4CEF7;
	Wed,  4 Mar 2026 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663148;
	bh=lCTa9Qd1u2nL91zcwpE+OEBQhBxpQ7EU0l+Y2nrxd/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBbu05lpxuOl93XO/v2Ud9DeTBSIw7wi4fRACuOPEpRrfbqKKXseWoa2zXy0ekjaP
	 Ps9DUpAP/ej/5qq4nVOQqroGWBlI7UImTY7Y79n+j7FfOi4fWNiO0K6jvqXqFEkrUF
	 g4CwpE4aDaltemenAuIl6MKg3hA+b5ys9xSTBZBxvNk3hNRMIyuFispAityUQv7CSh
	 FdzNH9u6zT9oSgQQGy3j5UKjJBPfj1xoMdlLKhyREZso4pEU4ooMz2vzdw2slmvE7h
	 UP+FtSaCup98MHQKwvNo7arjga6RJlOJthlFgK84dYsfitWFosQcN+jfkp3bkJTKmj
	 2DKHn96Ett7lw==
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
Subject: [PATCHv2 bpf-next 23/23] selftests/bpf: Add tracing multi rollback tests
Date: Wed,  4 Mar 2026 23:21:41 +0100
Message-ID: <20260304222141.497203-24-jolsa@kernel.org>
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

Adding tests for the rollback code when the tracing_multi
link won't get attached, covering 2 reasons:

  - wrong btf id passed by user, where all previously allocated
    trampolines will be released
  - trampoline for requested function is fully attached (has already
    maximum programs attached) and the link fails, the rollback code
    needs to release all previously link-ed trampolines and release
    them

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 171 ++++++++++++++++++
 .../bpf/progs/tracing_multi_rollback.c        |  30 +++
 2 files changed, 201 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 585d6b646d20..fe767214e107 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -10,6 +10,7 @@
 #include "tracing_multi_session.skel.h"
 #include "tracing_multi_fail.skel.h"
 #include "tracing_multi_bench.skel.h"
+#include "tracing_multi_rollback.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -721,6 +722,176 @@ void serial_test_tracing_multi_bench_attach(void)
 	free_kallsyms_local(ksyms);
 }
 
+static void tracing_multi_rollback_run(struct tracing_multi_rollback *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	prog_fd = bpf_program__fd(skel->progs.test_fentry);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	/* make sure the rollback code did not leave any program attached */
+	ASSERT_EQ(skel->bss->test_result_fentry, 0, "test_result_fentry");
+	ASSERT_EQ(skel->bss->test_result_fexit, 0, "test_result_fexit");
+}
+
+static void test_rollback_put(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi_rollback *skel = NULL;
+	size_t cnt = FUNCS_CNT;
+	__u32 *ids = NULL;
+	int err;
+
+	skel = tracing_multi_rollback__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_rollback__open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.test_fentry, true);
+	bpf_program__set_autoload(skel->progs.test_fexit, true);
+
+	err = tracing_multi_rollback__load(skel);
+	if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
+		goto cleanup;
+
+	ids = get_ids(bpf_fentry_test, cnt, NULL);
+	if (!ASSERT_OK_PTR(ids, "get_ids"))
+		goto cleanup;
+
+	/* Mangle last id to trigger rollback. */
+	ids[9] = 0;
+
+	opts.ids = ids;
+	opts.cnt = cnt;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fexit = bpf_program__attach_tracing_multi(skel->progs.test_fexit,
+						NULL, &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fexit, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* We don't really attach any program, but let's make sure. */
+	tracing_multi_rollback_run(skel);
+
+cleanup:
+	tracing_multi_rollback__destroy(skel);
+	free(ids);
+}
+
+
+static void fillers_cleanup(struct tracing_multi_rollback **skels, int cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++)
+		tracing_multi_rollback__destroy(skels[i]);
+
+	free(skels);
+}
+
+static struct tracing_multi_rollback **fillers_load_and_link(int max)
+{
+	struct tracing_multi_rollback **skels, *skel;
+	int i, err;
+
+	skels = calloc(max + 1, sizeof(*skels));
+	if (!ASSERT_OK_PTR(skels, "calloc"))
+		return NULL;
+
+	for (i = 0; i < max; i++) {
+		skel = skels[i] = tracing_multi_rollback__open();
+		if (!ASSERT_OK_PTR(skels[i], "tracing_multi_rollback__open"))
+			goto cleanup;
+
+		bpf_program__set_autoload(skel->progs.filler, true);
+
+		err = tracing_multi_rollback__load(skel);
+		if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
+			goto cleanup;
+
+		skel->links.filler = bpf_program__attach_trace(skel->progs.filler);
+		if (!ASSERT_OK_PTR(skels[i]->links.filler, "bpf_program__attach_trace"))
+			goto cleanup;
+	}
+
+	return skels;
+
+cleanup:
+	fillers_cleanup(skels, i);
+	return NULL;
+}
+
+static void test_rollback_unlink(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi_rollback **fillers;
+	struct tracing_multi_rollback *skel;
+	size_t cnt = FUNCS_CNT;
+	__u32 *ids = NULL;
+	int err, max;
+
+	max = get_bpf_max_tramp_links();
+	if (!ASSERT_GE(max, 1, "bpf_max_tramp_links"))
+		return;
+
+	/* Attach maximum allowed programs to bpf_fentry_test10 */
+	fillers = fillers_load_and_link(max);
+	if (!ASSERT_OK_PTR(fillers, "fillers_load_and_link"))
+		return;
+
+	skel = tracing_multi_rollback__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_rollback__open"))
+		goto cleanup;
+
+	bpf_program__set_autoload(skel->progs.test_fentry, true);
+	bpf_program__set_autoload(skel->progs.test_fexit, true);
+
+	/*
+	 * Attach tracing_multi link on bpf_fentry_test1-10, which will
+	 * fail on bpf_fentry_test10 function, because it already has
+	 * maximum allowed programs attached.
+	 */
+	err = tracing_multi_rollback__load(skel);
+	if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
+		goto cleanup;
+
+	ids = get_ids(bpf_fentry_test, cnt, NULL);
+	if (!ASSERT_OK_PTR(ids, "get_ids"))
+		goto cleanup;
+
+	opts.ids = ids;
+	opts.cnt = cnt;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fexit = bpf_program__attach_tracing_multi(skel->progs.test_fexit,
+						NULL, &opts);
+	if (!ASSERT_ERR_PTR(skel->links.test_fexit, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	tracing_multi_rollback_run(skel);
+
+cleanup:
+	fillers_cleanup(fillers, max);
+	free(ids);
+}
+
+void serial_test_tracing_multi_attach_rollback(void)
+{
+	if (test__start_subtest("put"))
+		test_rollback_put();
+	if (test__start_subtest("unlink"))
+		test_rollback_unlink();
+}
+
 void test_tracing_multi_test(void)
 {
 #ifndef __x86_64__
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_rollback.c b/tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
new file mode 100644
index 000000000000..a3e4c77e3e05
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test_result_fentry = 0;
+__u64 test_result_fexit = 0;
+
+SEC("?fentry.multi")
+int BPF_PROG(test_fentry)
+{
+	test_result_fentry++;
+	return 0;
+}
+
+SEC("?fexit.multi")
+int BPF_PROG(test_fexit)
+{
+	test_result_fexit++;
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test10")
+int BPF_PROG(filler)
+{
+	return 0;
+}
-- 
2.53.0

