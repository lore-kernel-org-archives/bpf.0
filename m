Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476A3CDBAB
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287790; cv=none; b=iejXA+B6YWbhUSyigSRVOH/PkqMvKUEj0BlFPfHmhYxeXuNUrIOyI86PfNEBpJazd26FXj0LU95XAmeqg+QR08tvH/itt88MrBEjpzqla1hYjZWqfZcMNcT8IbH95OGY5eQinnn/VYlPQTWTrH0xz//o9v8MnoOCeiHXAnmT3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287790; c=relaxed/simple;
	bh=P+XpgSYtuURb8u/F/GNzQ+ZudQ36OmDlkZsdItpC/ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCO0KZpWKsGhy8y5iquW30KX/I2KLtmeuXqSwB7TNcH6bd8OVRKGbS4L/aOK3btPL7pCd83hMAdH3vgPtXtcMz4BeLRpSHEY4v2sUOzD8kSFwK0S1HTxCj5sPKVlwCHay+ESjgnZJZXFcg5PONZ0mVvR4kWTX6CXYFC6M6c01rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YSJFSfDi; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YSJFSfDi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786287786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJmQ4Z13HqELfI6OaXH9YpMv3G6mpuQ7rIyCRb6Dlsg=;
	b=YSJFSfDiSN8pOmHbHlq65t38gl2KBrq2jy/X7gCu9xS92SYpkEb7vblPFmyAjuikFzDTyv
	a6F3X4tk1LhhZoRu5Ez/upKjn03Opv1xW5klMBQlxa8GujIj1alrO40Hy9Xiw/wAVvb4ns
	4MYvVk6zf//BD6CAbzgY7oyqOXm5h9k=
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
Subject: [PATCH bpf-next 08/13] selftests/bpf: Add tracing_multi bpf prog attach test
Date: Sun,  9 Aug 2026 23:01:06 +0800
Message-ID: <20260809150111.45000-9-leon.hwang@linux.dev>
In-Reply-To: <20260809150111.45000-1-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Attach to two bpf progs with fentry.multi, fexit.multi, and fsession.multi
progs.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 70 +++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_bpf.c   | 52 ++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_bpf.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 0aa9532a05cf..5ecb751af9be 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -12,6 +12,7 @@
 #include "tracing_multi_verifier.skel.h"
 #include "tracing_multi_bench.skel.h"
 #include "tracing_multi_rollback.skel.h"
+#include "tracing_multi_bpf.skel.h"
 #include "trace_helpers.h"
 
 static __u64 bpf_fentry_test_cookies[] = {
@@ -288,6 +289,73 @@ static void test_link_api_ids(bool test_cookies)
 	free(ids);
 }
 
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
 static void test_module_skel_api(void)
 {
 	struct tracing_multi_module *skel = NULL;
@@ -1026,4 +1094,6 @@ void test_tracing_multi_test(void)
 	RUN_TESTS(tracing_multi_verifier);
 	if (test__start_subtest("fentry_after_multi"))
 		test_fentry_after_multi();
+	if (test__start_subtest("link_api_bpf_prog"))
+		test_link_api_bpf_prog();
 }
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

