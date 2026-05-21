Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509B3D4120;
	Thu, 21 May 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367573; cv=none; b=PcImgMCOJj0/3RWePXHnlv8WnSyX1XVbU0fRdVTnjf3/WvPFnKdkgme6KfvfdoyNuNyk3V3iWfntceQ79YLGlae5k+dKnLZlxZ5faFePQenCrgWrewCrOMbLX5MoxeEcc0wUCkMGZlUFDmdHBO3H4AH/mynuNSXsKT2/brQdkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367573; c=relaxed/simple;
	bh=pOCNzkNfb9lBEcv6/1q7ko9lR987x7/YdbV39QvD1OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVosTd4AiagIXsy5gjBS61Q6n8G/KB1XfYbn/pdCnjMxJ9XttFFR1BoIaHGLThe+j3GcQYLmHl+C5AKIvISMSKrhHKWkjRVMRRNXzvgagZxrkLeLZ4Va6Fp1oXhOh+MlfujfVFvbXa0TI+AxBb0yBfK4d2fKNgeSp8EAhMO/Cck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX3oRtnK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX3oRtnK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E18F1F000E9;
	Thu, 21 May 2026 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367571;
	bh=nq3VsRC1ZV7N4OSkkDlTSU8O0ZMbw+He/KvDiFNIvi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VX3oRtnKWuvWP/EvH2dgL7XrVTZ6MQucFtl2Tt3PppAlmuttlgCmZ3obdk8Xb0Ptn
	 R/zrhBUbQOFhbVUqhd23ib/1949b4fVdJQZO7cwKEqKOESKOabTXxWxEvi6KKiM8zv
	 pxOxWzQKOJ0rxPM2LV3XgMMzsxTCIt0jiWUnoaGhqxOTxKxe/Mdl/d+ZUSDzvC+SsR
	 7K530dHYYo7frR7p0mpJXYevnTXfhGynsPTLgtEbSzzeZ4D3Gg80T3076QDBcgbIIO
	 nf4APgHGmQMdy/ieasNyE0kkVSXTu+2oqPWXDKM76fxdgmyzqAsDjQGaF6sRqD1Bll
	 G9qoMJF1iQo6Q==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 12/12] selftests/bpf: Add tests for forked/cloned optimized uprobes
Date: Thu, 21 May 2026 14:44:11 +0200
Message-ID: <20260521124411.31133-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521124411.31133-1-jolsa@kernel.org>
References: <20260521124411.31133-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for forked/cloned optimized uprobes and make
sure the child can properly execute optimized probe for
both fork (dups mm) and clone with CLONE_VM.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index efff0c515184..033d32b4cc27 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -4,6 +4,8 @@
 
 #ifdef __x86_64__
 
+#define _GNU_SOURCE
+#include <sched.h>
 #include <unistd.h>
 #include <asm/ptrace.h>
 #include <linux/compiler.h>
@@ -936,6 +938,88 @@ static void test_uprobe_error(void)
 	ASSERT_EQ(errno, EPROTO, "errno");
 }
 
+__attribute__((aligned(16)))
+__nocf_check __weak __naked void uprobe_fork_test(void)
+{
+	asm volatile (
+		".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
+		"ret\n"
+	);
+}
+
+static int child_func(void *arg)
+{
+	struct uprobe_syscall_executed *skel = arg;
+
+	/* Make sure the child's probe is still there and optimized.. */
+	if (memcmp(uprobe_fork_test, lea_rsp, sizeof(lea_rsp)))
+		_exit(1);
+
+	skel->bss->pid = getpid();
+
+	/* .. and it executes properly. */
+	uprobe_fork_test();
+
+	if (skel->bss->executed != 3)
+		_exit(2);
+
+	_exit(0);
+}
+
+static void test_uprobe_fork_optimized(bool clone_vm)
+{
+	struct uprobe_syscall_executed *skel = NULL;
+	struct bpf_link *link = NULL;
+	unsigned long offset;
+	int pid, status, err;
+	char stack[65535];
+
+	offset = get_uprobe_offset(&uprobe_fork_test);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto cleanup;
+
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+				-1, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	/* Trigger optimization of uprobe in uprobe_fork_test.  */
+	uprobe_fork_test();
+	uprobe_fork_test();
+
+	/* Make sure it got optimied. */
+	if (!ASSERT_OK(memcmp(uprobe_fork_test, lea_rsp, sizeof(lea_rsp)), "optimized"))
+		goto cleanup;
+
+	if (clone_vm) {
+		pid = clone(child_func, stack + sizeof(stack), CLONE_VM|SIGCHLD, skel);
+		if (!ASSERT_GT(pid, 0, "clone"))
+			goto cleanup;
+	} else {
+		pid = fork();
+		if (!ASSERT_GE(pid, 0, "fork"))
+			goto cleanup;
+		if (pid == 0)
+			child_func(skel);
+	}
+
+	/* Wait for the child and verify it exited properly with 0. */
+	err = waitpid(pid, &status, 0);
+	if (ASSERT_EQ(err, pid, "waitpid")) {
+		ASSERT_EQ(WIFEXITED(status), 1, "child_exited");
+		ASSERT_EQ(WEXITSTATUS(status), 0, "child_exit_code");
+	}
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -956,6 +1040,10 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_race();
 	if (test__start_subtest("uprobe_red_zone"))
 		test_uprobe_red_zone();
+	if (test__start_subtest("uprobe_optimized_fork"))
+		test_uprobe_fork_optimized(false);
+	if (test__start_subtest("uprobe_optimized_clone_vm"))
+		test_uprobe_fork_optimized(true);
 	if (test__start_subtest("uprobe_error"))
 		test_uprobe_error();
 	if (test__start_subtest("uprobe_regs_equal"))
-- 
2.53.0

