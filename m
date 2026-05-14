Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28753F23A2;
	Thu, 14 May 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766867; cv=none; b=IdptK6cqu0wH+rO41QrAQyU+ogCeuji7VmlY0MYj12X30rqeToAilx8sRJFKBihDrOIim80A8zbqacI3DjVHhQ4I4zQ/H/WOYQJQgTV9Sq2jjEZzcrSrfmuPLI/XUg1QPHI5880DhmNYFN3kouIkvbQvUyXMu/ocVXXNNR9S5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766867; c=relaxed/simple;
	bh=uTWcdyD7ngnENVCJThaRkrVqwZI1hg6oEzFZFhL9TaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knx0Ifa7emDknGFA+ghR2xaStFBx/N+VC7aPU8Wn50BDubsfYaU0f4SEZC4iC/lu3wt0BQhJ54jtLPA3LVJcTeIBLQ4LyMW+I5t/pHAyFYeCPanE3dkMCNqQ+kO3kgsdQ5lhy1iTn95CmeLo72WRNLBSiFyDyyA7dr5PJtXCt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh/uZ4Q+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh/uZ4Q+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7C8C2BCFB;
	Thu, 14 May 2026 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778766866;
	bh=uTWcdyD7ngnENVCJThaRkrVqwZI1hg6oEzFZFhL9TaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sh/uZ4Q+vkkztWSf+acC5/fy/782mC2HV+599PhiHQ0AY8SRIy0JWEC+9wG8opT0w
	 /i91IH0SGb9O1btRNw+c+PT+cy8z1LORF+16fQ7VeFB4bA8kmChxKFod+JqoBr8GmY
	 tc1NI/EMBy6nXhilIQUjM2SugXeipDWmzASPJCAfoZjTqmY69q5UxiFDqj5unDl42f
	 DRUaPO7+6/8dcq6YNa0eRziqqyS81TxHkrkYopNzZFg3ptVx7Tep8txYnJ0m4S5acQ
	 ZYo5gbB7eWzmCUDuNTNXjB0/Ara4jba/QI8kCOqU/g8u6q7VPKcw0UP/n/xpbe3seD
	 amarN45Yr47IA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/7] selftests/bpf: Change uprobe syscall tests to use nop10
Date: Thu, 14 May 2026 15:53:39 +0200
Message-ID: <20260514135342.22130-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514135342.22130-1-jolsa@kernel.org>
References: <20260514135342.22130-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimized uprobes are now on top of 10-bytes nop instructions,
reflect that in existing tests.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/benchs/bench_trigger.c      |  2 +-
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 29 ++++++++++---------
 tools/testing/selftests/bpf/prog_tests/usdt.c | 25 +++++++++-------
 tools/testing/selftests/bpf/usdt_2.c          |  2 +-
 4 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 2f22ec61667b..bcc4820c802e 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -398,7 +398,7 @@ static void *uprobe_producer_ret(void *input)
 #ifdef __x86_64__
 __nocf_check __weak void uprobe_target_nop5(void)
 {
-	asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
+	asm volatile (".byte 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00");
 }
 
 static void *uprobe_producer_nop5(void *input)
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 955a37751b52..c2e9e549c737 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -17,7 +17,7 @@
 #include "uprobe_syscall_executed.skel.h"
 #include "bpf/libbpf_internal.h"
 
-#define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
+#define USDT_NOP .byte 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00
 #include "usdt.h"
 
 #pragma GCC diagnostic ignored "-Wattributes"
@@ -26,7 +26,7 @@ __attribute__((aligned(16)))
 __nocf_check __weak __naked unsigned long uprobe_regs_trigger(void)
 {
 	asm volatile (
-		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00\n" /* nop5 */
+		".byte 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
 		"movq $0xdeadbeef, %rax\n"
 		"ret\n"
 	);
@@ -345,9 +345,9 @@ static void test_uretprobe_syscall_call(void)
 __attribute__((aligned(16)))
 __nocf_check __weak __naked void uprobe_test(void)
 {
-	asm volatile ("					\n"
-		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00	\n"
-		"ret					\n"
+	asm volatile (
+		".byte 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
+		"ret\n"
 	);
 }
 
@@ -388,14 +388,16 @@ static int find_uprobes_trampoline(void *tramp_addr)
 	return ret;
 }
 
-static unsigned char nop5[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char jmp2B[2]   = { 0xeb, 8 };
+static unsigned char nop10[10]  = { 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
+static unsigned char lea_rsp[5] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
 
-static void *find_nop5(void *fn)
+static void *find_nop10(void *fn)
 {
 	int i;
 
-	for (i = 0; i < 10; i++) {
-		if (!memcmp(nop5, fn + i, 5))
+	for (i = 0; i < 128; i++) {
+		if (!memcmp(nop10, fn + i, 9))
 			return fn + i;
 	}
 	return NULL;
@@ -420,7 +422,8 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 	ASSERT_EQ(skel->bss->executed, executed, "executed");
 
 	/* .. and check the trampoline is as expected. */
-	call = (struct __arch_relative_insn *) addr;
+	ASSERT_OK(memcmp(addr, lea_rsp, 4), "lea_rsp");
+	call = (struct __arch_relative_insn *)(addr + 5);
 	tramp = (void *) (call + 1) + call->raddr;
 	ASSERT_EQ(call->op, 0xe8, "call");
 	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
@@ -432,7 +435,7 @@ static void check_detach(void *addr, void *tramp)
 {
 	/* [uprobes_trampoline] stays after detach */
 	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
+	ASSERT_OK(memcmp(addr, jmp2B, 2), "jmp2B");
 }
 
 static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
@@ -568,8 +571,8 @@ static void test_uprobe_usdt(void)
 	void *addr;
 
 	errno = 0;
-	addr = find_nop5(usdt_test);
-	if (!ASSERT_OK_PTR(addr, "find_nop5"))
+	addr = find_nop10(usdt_test);
+	if (!ASSERT_OK_PTR(addr, "find_nop10"))
 		return;
 
 	skel = uprobe_syscall_executed__open_and_load();
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 69759b27794d..be34c4087ff5 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -252,7 +252,7 @@ extern void usdt_1(void);
 extern void usdt_2(void);
 
 static unsigned char nop1[1] = { 0x90 };
-static unsigned char nop1_nop5_combo[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char nop1_nop10_combo[11] = { 0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
 static void *find_instr(void *fn, unsigned char *instr, size_t cnt)
 {
@@ -271,17 +271,17 @@ static void subtest_optimized_attach(void)
 	__u8 *addr_1, *addr_2;
 
 	/* usdt_1 USDT probe has single nop instruction */
-	addr_1 = find_instr(usdt_1, nop1_nop5_combo, 6);
-	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
+	addr_1 = find_instr(usdt_1, nop1_nop10_combo, 6);
+	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop10_combo"))
 		return;
 
 	addr_1 = find_instr(usdt_1, nop1, 1);
 	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
 		return;
 
-	/* usdt_2 USDT probe has nop,nop5 instructions combo */
-	addr_2 = find_instr(usdt_2, nop1_nop5_combo, 6);
-	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
+	/* usdt_2 USDT probe has nop,nop10 instructions combo */
+	addr_2 = find_instr(usdt_2, nop1_nop10_combo, 6);
+	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop10_combo"))
 		return;
 
 	skel = test_usdt__open_and_load();
@@ -309,12 +309,12 @@ static void subtest_optimized_attach(void)
 
 	bpf_link__destroy(skel->links.usdt_executed);
 
-	/* we expect the nop5 ip */
+	/* we expect the nop10 ip */
 	skel->bss->expected_ip = (unsigned long) addr_2 + 1;
 
 	/*
 	 * Attach program on top of usdt_2 which is probe defined on top
-	 * of nop1,nop5 combo, so the probe gets optimized on top of nop5.
+	 * of nop1,nop10 combo, so the probe gets optimized on top of nop10.
 	 */
 	skel->links.usdt_executed = bpf_program__attach_usdt(skel->progs.usdt_executed,
 						     0 /*self*/, "/proc/self/exe",
@@ -328,8 +328,13 @@ static void subtest_optimized_attach(void)
 	/* nop stays on addr_2 address */
 	ASSERT_EQ(*addr_2, 0x90, "nop");
 
-	/* call is on addr_2 + 1 address */
-	ASSERT_EQ(*(addr_2 + 1), 0xe8, "call");
+	/*
+	 * lea -0x80(%rsp), %rsp
+	 * call ...
+	 */
+	static unsigned char expected[] = { 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8 };
+
+	ASSERT_MEMEQ(addr_2 + 1, expected, sizeof(expected), "lea_and_call");
 	ASSERT_EQ(skel->bss->executed, 4, "executed");
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
index 789883aaca4c..b359b389f6c0 100644
--- a/tools/testing/selftests/bpf/usdt_2.c
+++ b/tools/testing/selftests/bpf/usdt_2.c
@@ -3,7 +3,7 @@
 #if defined(__x86_64__)
 
 /*
- * Include usdt.h with default nop,nop5 instructions combo.
+ * Include usdt.h with default nop,nop10 instructions combo.
  */
 #include "usdt.h"
 
-- 
2.53.0

