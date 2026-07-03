Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CBD3CB8E6;
	Fri,  3 Jul 2026 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079519; cv=none; b=KWtNpO0apHe36L9McsR/5vFI4+ND2N+aYYQXREUPrww3MY+M/9QEV68zbuxrJ/k4yFm49RA6sJ/zUCTE/7dUu5yIGYh2FvkiDK1TmgImudLK09jkDEfVUfiLnusH7OpE9bXWQT5i8pLNi0PLHMs0wdhEXSMVAKMNt1jI4Vq7Otk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079519; c=relaxed/simple;
	bh=uS+uBU0I1YUlE+u2cEASKbRadtgcrgEbwbFoMh4+Xh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqZtiCOsV77pBqYJS2c2gyJtVE2s3TRk5skjZUCorGBC4/sAF5scaMoWDo0CWVN5txqSeHhWXNq1fYhLy4dGzcGQouLBuXdGSAcuKggjQha5BJLcat5YGUTxONaatI1RFB9WiGokV2e106TaMTTg/5bA28z+xcrWqEmqeB2+0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD1zbKxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD1zbKxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A18F1F000E9;
	Fri,  3 Jul 2026 11:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783079518;
	bh=RQchSe69DAW2imVyaCUfe1AzsIA6bhxFsqyxnFs71Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bD1zbKxt2NWCSbGz3TEihCl8RMn7YbwnIaxITuNIjS429bfBNF/JzdTrD0RZN04Q5
	 3RUZFlLiPq7mmJ5d4OGG/vu/FQH1PzjJK8B4sZvtWQiPFH8cCmA1pHsrCTrbBEsadT
	 DM5kgoxtyE1hRjIZjiIPG0J8saVXHscoKPHGEo1XuQW60cBhiQ3deBVhOMDW+1DJzF
	 BEhw7XK7ppkWoHPf9Y3qcuL1Z8x7FQL6Kn13FY2aj5a4GBia54aLZfSgJp/nY3mgJf
	 6bwWPiLAkQZFUxcA4Hovlau5PveNLCbmAWPXSb/euqEnzZM1o1jBxPsy6hA9XV3Mq6
	 gSTMiBf3dnNAg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv6 13/13] selftests/bpf: Add tests for forked/cloned optimized uprobes
Date: Fri,  3 Jul 2026 13:49:17 +0200
Message-ID: <20260703114917.238144-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703114917.238144-1-jolsa@kernel.org>
References: <20260703114917.238144-1-jolsa@kernel.org>
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

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index ff07e5df9a65..e193206fc5d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -4,6 +4,8 @@
 
 #ifdef __x86_64__
 
+#define _GNU_SOURCE
+#include <sched.h>
 #include <unistd.h>
 #include <asm/ptrace.h>
 #include <linux/compiler.h>
@@ -13,6 +15,7 @@
 #include <sys/syscall.h>
 #include <sys/prctl.h>
 #include <asm/prctl.h>
+#include <stdnoreturn.h>
 #include "uprobe_syscall.skel.h"
 #include "uprobe_syscall_executed.skel.h"
 #include "bpf/libbpf_internal.h"
@@ -954,6 +957,87 @@ static void test_uprobe_error(void)
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
+static noreturn int child_func(void *arg)
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
+	skel->links.test_uprobe = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+					-1, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_uprobe, "attach_uprobe"))
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
@@ -974,6 +1058,10 @@ static void __test_uprobe_syscall(void)
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
2.54.0

