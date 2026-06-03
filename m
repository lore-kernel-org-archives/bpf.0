Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116A453497;
	Wed,  3 Jun 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485073; cv=none; b=V3OEofRu8d0NGdDDYiCFtfUchHgudmHNsPxjtbf3mY6nZ0KKWtioYHyYK0S2kIqKGjc/EkuPc3bVNmdkZQ5lWVTNvHfgG9FmPwjzcb6Csh38780OO95jvxb84WS1+lOsPdvKcUM5/rOIDc6tDCjkHsuy1vzWkAKPl7ZqwzxycCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485073; c=relaxed/simple;
	bh=ecG6kzjtimLFn/onkzldzfUmtVUdCZuxf6UUkGjtTog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2Jdu9aQJWgaaDuV6VTiyBqaCMiVxtCJmhMEBfP59AQ7dujk4VOl31vVTR99Nv/yR5xh3I9BJRwGnAnqkmwa3EJU/RNF63qFN2BEd89qMtiV5sScdWAFbELbw6BnIng7KfNMA+92s25X1a4AFovjDogYF0bz3ii8AxXZd2O/M1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og2JwQWE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og2JwQWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C3F1F00898;
	Wed,  3 Jun 2026 11:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780485071;
	bh=VySsBm9BWKIL68reqlyaMj8lfoBwivUKr0YukGq43wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Og2JwQWE147MZLEp6N4pXr0FOtMVn5CX3LCTdpTPjwz+lHNGwacR3o0uQAqqPvHkM
	 gSbxhwfDdAQ86yN4pnVKxltDnjwjnLEqdwqZhlde2PK41gjVwLQtYk8TA+BKI2O9LQ
	 aAQwQM0LOsI3zsKVyPDLwd8Ez2oKsxwQLKgINipbGM65mGVLRQSgsdwxwo1AjoYYAK
	 kkRkR0nL2fatMgGggqYwHMotE8Ci39I6XstMPCM3oReD8rULgwUTp+DyEQXvL48Dke
	 9VgUyjcV94H59CBh+pCObzzluSSvmWo9LzXtM5w18IdH/khCMVRypJsbW7+7GmOVK4
	 S+b0wxW5PiZtA==
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
Subject: [PATCHv7 bpf-next 29/29] selftests/bpf: Add tracing multi attach rollback tests
Date: Wed,  3 Jun 2026 13:05:53 +0200
Message-ID: <20260603110554.29590-30-jolsa@kernel.org>
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

Adding tests for the rollback code when the tracing_multi
link won't get attached, covering 2 reasons:

  - wrong btf id passed by user, where all previously allocated
    trampolines will be released
  - trampoline for requested function is fully attached (has already
    maximum programs attached) and the link fails, the rollback code
    needs to release all previously link-ed trampolines and release
    them

We need the bpf_fentry_test* unattached for the tests to pass,
so the rollback tests are serial.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 212 ++++++++++++++++++
 .../bpf/progs/tracing_multi_rollback.c        |  43 ++++
 2 files changed, 255 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_rollback.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 909dd0705b15..99d09b93bd23 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -11,6 +11,7 @@
 #include "tracing_multi_fail.skel.h"
 #include "tracing_multi_verifier.skel.h"
 #include "tracing_multi_bench.skel.h"
+#include "tracing_multi_rollback.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -693,6 +694,217 @@ void serial_test_tracing_multi_bench_attach(void)
 	btf__free(btf);
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
+	/*
+	 * Mangle last id to trigger rollback, which needs to do put
+	 * on get-ed trampolines.
+	 */
+	ids[9] = 0;
+
+	opts.ids = ids;
+	opts.cnt = cnt;
+
+	skel->bss->pid = getpid();
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
+static struct tracing_multi_rollback *extra_load_and_link(void)
+{
+	struct tracing_multi_rollback *skel;
+	int err;
+
+	skel = tracing_multi_rollback__open();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_rollback__open"))
+		goto cleanup;
+
+	bpf_program__set_autoload(skel->progs.extra, true);
+
+	err = tracing_multi_rollback__load(skel);
+	if (!ASSERT_OK(err, "tracing_multi_rollback__load"))
+		goto cleanup;
+
+	skel->links.extra = bpf_program__attach_trace(skel->progs.extra);
+	if (!ASSERT_OK_PTR(skel->links.extra, "bpf_program__attach_trace"))
+		goto cleanup;
+
+	return skel;
+
+cleanup:
+	tracing_multi_rollback__destroy(skel);
+	return NULL;
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
+	fillers_cleanup(skels, i + 1);
+	return NULL;
+}
+
+static void test_rollback_unlink(void)
+{
+	struct tracing_multi_rollback *skel = NULL, *extra;
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi_rollback **fillers;
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
+	extra = extra_load_and_link();
+	if (!ASSERT_OK_PTR(extra, "extra_load_and_link"))
+		goto cleanup;
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
+	 *
+	 * The rollback needs to unlink already link-ed trampolines and
+	 * put all of them.
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
+	skel->bss->pid = getpid();
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
+	tracing_multi_rollback__destroy(extra);
+	tracing_multi_rollback__destroy(skel);
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
index 000000000000..a49d1d841f3a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_rollback.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+
+__u64 test_result_fentry = 0;
+__u64 test_result_fexit = 0;
+
+SEC("?fentry.multi")
+int BPF_PROG(test_fentry)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	test_result_fentry++;
+	return 0;
+}
+
+SEC("?fexit.multi")
+int BPF_PROG(test_fexit)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	test_result_fexit++;
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(extra)
+{
+	return 0;
+}
+
+SEC("?fentry/bpf_fentry_test10")
+int BPF_PROG(filler)
+{
+	return 0;
+}
-- 
2.54.0

