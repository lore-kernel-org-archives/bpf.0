Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793C324B33;
	Mon, 18 May 2026 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102109; cv=none; b=oFwAxd8xLNUSU2X38BnBNfeKMO2yntWmIZ7ROpynmhQYksUp/QANgBGWd4uj/hLEwswm5tJKmacbg3Wru/uqoxDTfWqdQ2LcUPX9XJHssKoF0YdkhRma6qF3dvtgMUyHwly8AzZb71zGpLN9ScjT0VKblyUU35Muo/AIEiDErTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102109; c=relaxed/simple;
	bh=AjRk3DZzX756T1GnD1iYaA/mnxVr7LP7HzFj7r7VFYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaUnBbrrUJTM7RhSdRYN75jpyrjMtY4snev2lOSulNaCJt1xgjPKy8uYsk/uceYGfXkDsVj9GW+QeNBJcQc+3uu2Bv5zGhwhK0FWw7SfzF7YLc6j4RMm+hFKuEtcu20PVkZDW9tDROx8YBVeFWwFCDLOjYo3Da4PJ6L/1Zxvkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDJyE6PN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDJyE6PN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712A4C2BD00;
	Mon, 18 May 2026 11:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779102107;
	bh=AjRk3DZzX756T1GnD1iYaA/mnxVr7LP7HzFj7r7VFYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDJyE6PN4JRhf0cQrmHmyaWspbFKcffF8u9ZznR8BlvnSEDSf5ygH57t48PQuEwvR
	 rsrlqaLtz+fAaN70JIJ38wWNzhzzcg4UeLjVVG/284UOJAKMFmDgoDEkWo0erjqyuo
	 xVPIXPjl3poxeYc32EsJG3/pCXT0A61meQ72K34jE3SdqLDEMoWB8+LeQ+AFgerSXC
	 HvX3ct6SCIubEkDUPc82ePjhCeBoq4uIFchoHN2p5Cf4N6ZixLedcygY00YfkxD4h9
	 MD4KXRdK4GsISn/tGyhwIpT4Go/6rIUeLwnkSR+e7WOMMRivGY2ESl9Hb3OAyZJWXs
	 FMWV8qiMTAJlw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 11/11] selftests/bpf: Add tests for forked/cloned optimized uprobes
Date: Mon, 18 May 2026 12:59:57 +0200
Message-ID: <20260518105957.123445-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518105957.123445-1-jolsa@kernel.org>
References: <20260518105957.123445-1-jolsa@kernel.org>
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
index 739b0be13aa3..713b42d4f190 100644
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
+		".byte 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
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

