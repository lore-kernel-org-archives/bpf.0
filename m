Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5F189B84
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102232; cv=none; b=LbNvSVjt1yLVLzUlJHY1N8choP6mSVqSU2G5jDRmOUt1dQkf1w22i7Yn6FFsO05T0RGcktGihShd9gPLKEbqdrlriodoXkBpIxUPhwOTAMUVDthmQUjLVdbRk3NQtYbuIbN3wj4rEEcpPnfwvuVFdCnTTGQeqcoad6Q7CwreKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102232; c=relaxed/simple;
	bh=i9bXYE03/AMyGF2sd+XmEPIUxXWB83U3ZY3lmrhG25I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ3oIAJUZa/1cQRXTjHSxmiINhCluCql6jKC0QQZbY2N/24Oqi+dGggPsG2UMow8qHwdzN8oAY4hBPXy7BlrLKkiiQx+goCxucZzsVa44BICac1MFU4bbc3M/z0/3YUrfp9goIFjaeHnqdTK8prcON2BS2M9kmONaPq7OS3Mf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFLim1OD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFLim1OD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E8D1F00893;
	Wed, 10 Jun 2026 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102230;
	bh=WNLL6SicE0kTT0UfGYBK02dCg6MrqvQK72wI7/+7Ko8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gFLim1ODSHrFinAm7GXyiXCv4+zOI67Ws2Yz92cH3bknsjo5MgypjQBLff+sZFA9w
	 +WH0pewZUknr7jd53Z9Q0vzlG2Rz9OPZGv9fL7vWbi+YtrixKqSwB7xzZZlZd3Z0tb
	 KwXuGkcKNTBSDRIszmmxGSKEtFPi5YyvTAfiBaCRhdIMRbNvoDKCfmWJ3StrPYALcx
	 ewZIL1P+yGfxBoXDTnb2ZshJV9u/gEwgXTQBUu228DjXFyOz6WZn8Cvensu4hPwhrX
	 iptPY0xFsDS1cffueiLNyIiKt9nOeH5ehqIwEMDZ8RRz9ls4lZfhXUY/AmtFwnPl3r
	 D7CAyqogMd8/Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 4/6] selftests/bpf: Add uprobe_multi path_fd test
Date: Wed, 10 Jun 2026 16:36:25 +0200
Message-ID: <20260610143627.804790-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610143627.804790-1-jolsa@kernel.org>
References: <20260610143627.804790-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a uprobe_multi link API selftest that opens /proc/self/exe and passes
the resulting descriptor through opts.uprobe_multi.path_fd with
BPF_F_UPROBE_MULTI_PATH_FD set.

Assisted-by: Codex:GPT-5.4
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 56cbea280fbd..ffcf3c92f047 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -2,6 +2,7 @@
 
 #include <unistd.h>
 #include <pthread.h>
+#include <fcntl.h>
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
@@ -757,6 +758,65 @@ static void test_link_api(void)
 	__test_link_api(&child);
 }
 
+static void test_link_api_path_fd(void)
+{
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+	const char *resolve_path = "/proc/self/exe";
+	int prog_fd, link_fd = -1, path_fd = -1;
+	struct uprobe_multi *skel = NULL;
+	unsigned long *offsets = NULL;
+	const char *syms[3] = {
+		"uprobe_multi_func_1",
+		"uprobe_multi_func_2",
+		"uprobe_multi_func_3",
+	};
+	int err;
+
+	err = elf_resolve_syms_offsets(resolve_path, ARRAY_SIZE(syms), syms,
+				       &offsets, STT_FUNC);
+	if (!ASSERT_OK(err, "elf_resolve_syms_offsets"))
+		return;
+
+	path_fd = open(resolve_path, O_RDONLY);
+	if (!ASSERT_GE(path_fd, 0, "path_fd"))
+		goto cleanup;
+
+	opts.uprobe_multi.path_fd = path_fd;
+	opts.uprobe_multi.offsets = offsets;
+	opts.uprobe_multi.cnt = ARRAY_SIZE(syms);
+	opts.uprobe_multi.flags = BPF_F_UPROBE_MULTI_PATH_FD;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_multi__open_and_load"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.uprobe);
+	link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &opts);
+	if (!ASSERT_GE(link_fd, 0, "bpf_link_create"))
+		goto cleanup;
+
+	skel->bss->uprobe_multi_func_1_addr = (__u64)uprobe_multi_func_1;
+	skel->bss->uprobe_multi_func_2_addr = (__u64)uprobe_multi_func_2;
+	skel->bss->uprobe_multi_func_3_addr = (__u64)uprobe_multi_func_3;
+	skel->bss->pid = getpid();
+
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+
+	ASSERT_EQ(skel->bss->uprobe_multi_func_1_result, 1, "uprobe_multi_func_1_result");
+	ASSERT_EQ(skel->bss->uprobe_multi_func_2_result, 1, "uprobe_multi_func_2_result");
+	ASSERT_EQ(skel->bss->uprobe_multi_func_3_result, 1, "uprobe_multi_func_3_result");
+
+cleanup:
+	if (link_fd >= 0)
+		close(link_fd);
+	if (path_fd >= 0)
+		close(path_fd);
+	uprobe_multi__destroy(skel);
+	free(offsets);
+}
+
 static struct bpf_program *
 get_program(struct uprobe_multi_consumers *skel, int prog)
 {
@@ -1354,6 +1414,8 @@ void test_uprobe_multi_test(void)
 		test_attach_api_syms();
 	if (test__start_subtest("link_api"))
 		test_link_api();
+	if (test__start_subtest("link_api_path_fd"))
+		test_link_api_path_fd();
 	if (test__start_subtest("bench_uprobe"))
 		test_bench_attach_uprobe();
 	if (test__start_subtest("bench_usdt"))
-- 
2.54.0

