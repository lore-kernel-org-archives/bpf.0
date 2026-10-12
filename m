Received: from mta1.migadu.com (out-19.mta1.migadu.com [95.215.58.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84244AAC4F
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819886; cv=none; b=ghNYhhcYbqX7HHAuDSk9NcLL8MEuPBcYacvzuaC5CZw69U/GFodrf8BA/Dfv2ibelFzzNAOGdm6Yr+6cKuHARUAZGEhe4y38lAWsADtMejTApWZhlDgblAk3ojQVTKXEFeleiOcdoiQTLkPuSb5tWdohmpOSBNd02SmO983KWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819886; c=relaxed/simple;
	bh=RNUPxnQhct34be5Z0buM9fJf70aN/ExmaVf/Fojs7us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7HMfp8A9LxPLUKlkpU18bE5kknaTAu4wI41A0rNlSPC6qOYTI2HC7jAzukc3fjH1eN1XLE2VZwvGtPmOB6q6S/sYKMmJJJlMpkELzwZoc0QgaLJzTkvYCnZ2BzrSrFCq/fKPAJILIg4bmQPkBJCOUV5pzH3zqoKI8bknS6+H8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QD9MmqRh; arc=none smtp.client-ip=95.215.58.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QD9MmqRh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RNUPxnQhct34be5Z0buM9fJf70aN/ExmaVf/Fojs7us=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819882; v=1; x=1792424682;
 b=QD9MmqRhBN2dhFrUjvl6Y/iQO9l89V8X+BEieniv62Ux9Fiy94Fdw6G2wlSTQBVPrFRXXdwt
 tgGThG5+iW8h5myrBvczXVkPFDOtRo/5LMNxelI0mC6VZCIQk0GiieRI0CRiFuFjyApZbBCN3kU
 q10QcjIDKYlROhgLq8L+bNHU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 035d91738ae5639f;
	Mon, 12 Oct 2026 15:44:42 +0000
X-Mizu-Trace-ID: 035d91738ae5639f
X-Migadu-Flow: FLOW_OUT
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
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 15/21] selftests/bpf: Add tracing_multi bpf prog attach test
Date: Mon, 12 Oct 2026 23:40:17 +0800
Message-ID: <20261012154024.29423-16-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attach to two bpf progs with fentry.multi, fexit.multi, and fsession.multi
progs.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 74 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_bpf.c   | 52 +++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index cc727011f3a2..801136ca63f0 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -12,6 +12,7 @@
 #include "tracing_multi_verifier.skel.h"
 #include "tracing_multi_bench.skel.h"
 #include "tracing_multi_rollback.skel.h"
+#include "tracing_multi_bpf.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -1126,3 +1127,76 @@ void test_tracing_multi_test(void)
 	if (test__start_subtest("fentry_after_multi"))
 		test_fentry_after_multi();
 }
+
+static int run_bpf_target(struct bpf_program *prog, __u32 retval, const char *name)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);
+	if (!ASSERT_OK(err, name))
+		return err;
+
+	if (!ASSERT_EQ(topts.retval, retval, name))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void test_link_api_bpf_prog(void)
+{
+	const char *funcs[] = { "target_1", "target_2" };
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi_bpf *skel = NULL;
+	int fds[ARRAY_SIZE(funcs)];
+	struct bpf_link *link;
+
+	skel = tracing_multi_bpf__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi_bpf__open_and_load"))
+		return;
+
+	fds[0] = bpf_program__fd(skel->progs.target_1);
+	fds[1] = bpf_program__fd(skel->progs.target_2);
+
+	opts.fds = fds;
+	opts.funcs = funcs;
+	opts.cnt = ARRAY_SIZE(fds);
+
+	link = bpf_program__attach_tracing_multi(skel->progs.test_fentry, NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_fentry"))
+		goto cleanup;
+	skel->links.test_fentry = link;
+
+	link = bpf_program__attach_tracing_multi(skel->progs.test_fexit, NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_fexit"))
+		goto cleanup;
+	skel->links.test_fexit = link;
+
+	link = bpf_program__attach_tracing_multi(skel->progs.test_fsession, NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_fsession"))
+		goto cleanup;
+	skel->links.test_fsession = link;
+
+	if (run_bpf_target(skel->progs.target_1, 1, "target_1"))
+		goto cleanup;
+	if (run_bpf_target(skel->progs.target_2, 2, "target_2"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->target_1_result, 1, "target_1_result");
+	ASSERT_EQ(skel->bss->target_2_result, 1, "target_2_result");
+	ASSERT_EQ(skel->bss->test_result_fentry, ARRAY_SIZE(funcs), "test_result_fentry");
+	ASSERT_EQ(skel->bss->test_result_fexit, ARRAY_SIZE(funcs), "test_result_fexit");
+	ASSERT_EQ(skel->bss->test_result_fsession_entry, ARRAY_SIZE(funcs),
+		  "test_result_fsession_entry");
+	ASSERT_EQ(skel->bss->test_result_fsession_exit, ARRAY_SIZE(funcs),
+		  "test_result_fsession_exit");
+
+cleanup:
+	tracing_multi_bpf__destroy(skel);
+}
+
+void test_tracing_multi_prog_test(void)
+{
+	if (test__start_subtest("link_api"))
+		test_link_api_bpf_prog();
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c b/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
new file mode 100644
index 000000000000..3e02602558ad
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_bpf.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test_result_fentry;
+__u64 test_result_fexit;
+__u64 test_result_fsession_entry;
+__u64 test_result_fsession_exit;
+__u64 target_1_result;
+__u64 target_2_result;
+
+SEC("syscall")
+int target_1(void *ctx)
+{
+	target_1_result++;
+	return 1;
+}
+
+SEC("syscall")
+int target_2(void *ctx)
+{
+	target_2_result++;
+	return 2;
+}
+
+SEC("fentry.multi")
+int BPF_PROG(test_fentry)
+{
+	test_result_fentry++;
+	return 0;
+}
+
+SEC("fexit.multi")
+int BPF_PROG(test_fexit)
+{
+	test_result_fexit++;
+	return 0;
+}
+
+SEC("fsession.multi")
+int BPF_PROG(test_fsession)
+{
+	if (bpf_session_is_return(ctx))
+		test_result_fsession_exit++;
+	else
+		test_result_fsession_entry++;
+
+	return 0;
+}
-- 
2.55.0

