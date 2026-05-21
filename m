Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF063C278B;
	Thu, 21 May 2026 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367563; cv=none; b=rhN1u4otyB0nU+k7kvzxxUeagiL1TcSC2KvMkj9P4+ONti3pQZ+LYD25dnFRklLmawMwPq2/CPRng27kuOWvhDINWm4vUYy7TQsJbgchoNQIxKhe1tT28rZo6GjaTW7LaNKsM7pzI0sUZgzkWnF9Ee4Iz0es2hGim89wLK1uWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367563; c=relaxed/simple;
	bh=dUFXXklbdlQITfJAk3V+YR0FntcmlcSUZhngeThZSTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swzj4tgzY6Qo4o7r7i/+6QL2zaC2u5DzSfHENksJ38LOQX1T7fW5bb7QfcMqqgJGMPxYjkCqAFajdVofDsvBLUbQMw1BPvFJM4bzSYXuqmyT+3Mdp9Hrwd59KqxNe+X77xhbTgl9qiFoH+merlAxV9NRlTFlm1tOFemHZBQaguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7iqnODN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7iqnODN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061DA1F000E9;
	Thu, 21 May 2026 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367562;
	bh=wbM4sepSvtQsULFVlM6/3zyRDviV/3JEl8JTugX6aIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i7iqnODNk4shsWg+D0ENcDIh44AUyS9yKMX/NinEskaxnh0uWKcdo11xRFHTb2V53
	 Fpm34y6sbPIGQK9CygdZWg4Cve6efwr1PfwyA2smm9kd5g0EBVtp9IwzOd10C2QCnw
	 O/x0FmByUlw31m/QIQyuTNZAp1YwQpPY3/ebrX2+nS02v5uD1jQ3fqgp7//5erS/DF
	 8tNifDwIdQBV0jYPPGJdGV9dQHBCVCva+AKrJ/ckSwb0cXCGwSRQJBCefOuiAaMz0O
	 xZpi44FzYWczwfb1WSIkN7Lz2u6NjODwFmWXI+kinhTggm8N3FYLOdDZQ5c4UecoBf
	 84IqvJiXRvKXQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv3 11/12] selftests/bpf: Add tests for uprobe nop10 red zone clobbering
Date: Thu, 21 May 2026 14:44:10 +0200
Message-ID: <20260521124411.31133-12-jolsa@kernel.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

The uprobe nop5 optimization used to replace a 5-byte NOP with a 5-byte
CALL to a trampoline. The CALL pushes a return address onto the stack at
[rsp-8], clobbering whatever was stored there.

On x86-64, the red zone is the 128 bytes below rsp that user code may use
for temporary storage without adjusting rsp. Compilers can place USDT
argument operands there, generating specs like "8@-8(%rbp)" when rbp ==
rsp. With the CALL-based optimization, the return address overwrites that
argument before the BPF-side USDT argument fetch runs.

Add two tests for this case. The uprobe_syscall subtest stores known values
at -8(%rsp), -16(%rsp), and -24(%rsp), executes an optimized nop10 uprobe,
and verifies the red-zone data is still intact. The USDT subtest triggers a
probe in a function where the compiler places three USDT operands in the
red zone and verifies that all 10 optimized invocations deliver the expected
argument values to BPF.

On an unfixed kernel, the first hit goes through the INT3 path and later
hits use the optimized CALL path, so the red-zone checks fail after
optimization.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
[ updates to use nop10 ]
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 75 +++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/usdt.c | 49 ++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c | 25 +++++++
 tools/testing/selftests/bpf/usdt_2.c          | 13 ++++
 4 files changed, 162 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 969f4deba9fd..efff0c515184 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -357,6 +357,48 @@ __nocf_check __weak void usdt_test(void)
 	USDT(optimized_uprobe, usdt);
 }
 
+/*
+ * Assembly-level red zone clobbering test. Stores known values in the
+ * red zone (below RSP), executes a nop10 (uprobe site), and checks that
+ * the values survived. Returns 0 if intact, 1 if clobbered.
+ *
+ * The nop5 optimization used CALL (which pushes a return address to
+ * [rsp-8]), the value at -8(%rsp) was overwritten. The nop10 optimization
+ * should escape that by moving stackpointer below the redzone before
+ * doing the CALL.
+ */
+__attribute__((aligned(16)))
+__nocf_check __weak __naked unsigned long uprobe_red_zone_test(void)
+{
+	asm volatile (
+		"movabs $0x1111111111111111, %%rax\n"
+		"movq   %%rax, -8(%%rsp)\n"
+		"movabs $0x2222222222222222, %%rax\n"
+		"movq   %%rax, -16(%%rsp)\n"
+		"movabs $0x3333333333333333, %%rax\n"
+		"movq   %%rax, -24(%%rsp)\n"
+
+		".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10: uprobe site */
+
+		"movabs $0x1111111111111111, %%rax\n"
+		"cmpq   %%rax, -8(%%rsp)\n"
+		"jne    1f\n"
+		"movabs $0x2222222222222222, %%rax\n"
+		"cmpq   %%rax, -16(%%rsp)\n"
+		"jne    1f\n"
+		"movabs $0x3333333333333333, %%rax\n"
+		"cmpq   %%rax, -24(%%rsp)\n"
+		"jne    1f\n"
+
+		"xorl   %%eax, %%eax\n"
+		"retq\n"
+		"1:\n"
+		"movl   $1, %%eax\n"
+		"retq\n"
+		::: "rax", "memory"
+	);
+}
+
 static int find_uprobes_trampoline(void *tramp_addr)
 {
 	void *start, *end;
@@ -855,6 +897,37 @@ static void test_uprobe_race(void)
 #define __NR_uprobe 336
 #endif
 
+static void test_uprobe_red_zone(void)
+{
+	struct uprobe_syscall_executed *skel;
+	struct bpf_link *link;
+	void *nop10_addr;
+	size_t offset;
+	int i;
+
+	nop10_addr = find_nop10(uprobe_red_zone_test);
+	if (!ASSERT_NEQ(nop10_addr, NULL, "find_nop10"))
+		return;
+
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	offset = get_uprobe_offset(nop10_addr);
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+			0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "attach_uprobe"))
+		goto cleanup;
+
+	for (i = 0; i < 10; i++)
+		ASSERT_EQ(uprobe_red_zone_test(), 0, "red_zone_intact");
+
+	bpf_link__destroy(link);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
 static void test_uprobe_error(void)
 {
 	long err = syscall(__NR_uprobe);
@@ -881,6 +954,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
+	if (test__start_subtest("uprobe_red_zone"))
+		test_uprobe_red_zone();
 	if (test__start_subtest("uprobe_error"))
 		test_uprobe_error();
 	if (test__start_subtest("uprobe_regs_equal"))
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index fda3a298ccfc..8004c9568ffa 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -250,6 +250,7 @@ static void subtest_basic_usdt(bool optimized)
 #ifdef __x86_64__
 extern void usdt_1(void);
 extern void usdt_2(void);
+extern void usdt_red_zone_trigger(void);
 
 static unsigned char nop1[1] = { 0x90 };
 static unsigned char nop1_nop10_combo[11] = { 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
@@ -340,6 +341,52 @@ static void subtest_optimized_attach(void)
 cleanup:
 	test_usdt__destroy(skel);
 }
+
+/*
+ * Test that USDT arguments survive nop10 optimization in a function where
+ * the compiler places operands in the red zone.
+ *
+ * Signal handlers are prone to having the compiler place USDT argument
+ * operands in the red zone (below rsp).
+ *
+ * The nop5 optimization used CALL (which pushes a return address to
+ * [rsp-8]), the value at -8(%rsp) was overwritten. The nop10 optimization
+ * should escape that by moving stackpointer below the redzone before
+ * doing the CALL.
+ */
+static void subtest_optimized_red_zone(void)
+{
+	struct test_usdt *skel;
+	int i;
+
+	skel = test_usdt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	skel->bss->expected_arg[0] = 0xDEADBEEF;
+	skel->bss->expected_arg[1] = 0xCAFEBABE;
+	skel->bss->expected_arg[2] = 0xFEEDFACE;
+	skel->bss->expected_pid = getpid();
+
+	skel->links.usdt_check_arg = bpf_program__attach_usdt(
+		skel->progs.usdt_check_arg, 0, "/proc/self/exe",
+		"optimized_attach", "usdt_red_zone", NULL);
+	if (!ASSERT_OK_PTR(skel->links.usdt_check_arg, "attach_usdt_red_zone"))
+		goto cleanup;
+
+	for (i = 0; i < 10; i++)
+		usdt_red_zone_trigger();
+
+	ASSERT_EQ(skel->bss->arg_total, 10, "arg_total");
+	ASSERT_EQ(skel->bss->arg_bad, 0, "arg_bad");
+	ASSERT_EQ(skel->bss->arg_last[0], 0xDEADBEEF, "arg_last_1");
+	ASSERT_EQ(skel->bss->arg_last[1], 0xCAFEBABE, "arg_last_2");
+	ASSERT_EQ(skel->bss->arg_last[2], 0xFEEDFACE, "arg_last_3");
+
+cleanup:
+	test_usdt__destroy(skel);
+}
+
 #endif
 
 unsigned short test_usdt_100_semaphore SEC(".probes");
@@ -613,6 +660,8 @@ void test_usdt(void)
 		subtest_basic_usdt(true);
 	if (test__start_subtest("optimized_attach"))
 		subtest_optimized_attach();
+	if (test__start_subtest("optimized_red_zone"))
+		subtest_optimized_red_zone();
 #endif
 	if (test__start_subtest("multispec"))
 		subtest_multispec_usdt();
diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
index f00cb52874e0..0ee78fb050a1 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -149,5 +149,30 @@ int usdt_executed(struct pt_regs *ctx)
 		executed++;
 	return 0;
 }
+
+int arg_total;
+int arg_bad;
+long arg_last[3];
+long expected_arg[3];
+int expected_pid;
+
+SEC("usdt")
+int BPF_USDT(usdt_check_arg, long arg1, long arg2, long arg3)
+{
+	if (expected_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&arg_total, 1);
+	arg_last[0] = arg1;
+	arg_last[1] = arg2;
+	arg_last[2] = arg3;
+
+	if (arg1 != expected_arg[0] ||
+	    arg2 != expected_arg[1] ||
+	    arg3 != expected_arg[2])
+		__sync_fetch_and_add(&arg_bad, 1);
+
+	return 0;
+}
 #endif
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftests/bpf/usdt_2.c
index b359b389f6c0..5e38f8605b02 100644
--- a/tools/testing/selftests/bpf/usdt_2.c
+++ b/tools/testing/selftests/bpf/usdt_2.c
@@ -13,4 +13,17 @@ void usdt_2(void)
 	USDT(optimized_attach, usdt_2);
 }
 
+static volatile unsigned long usdt_red_zone_arg1 = 0xDEADBEEF;
+static volatile unsigned long usdt_red_zone_arg2 = 0xCAFEBABE;
+static volatile unsigned long usdt_red_zone_arg3 = 0xFEEDFACE;
+
+void __attribute__((noinline)) usdt_red_zone_trigger(void)
+{
+	unsigned long a1 = usdt_red_zone_arg1;
+	unsigned long a2 = usdt_red_zone_arg2;
+	unsigned long a3 = usdt_red_zone_arg3;
+
+	USDT(optimized_attach, usdt_red_zone, a1, a2, a3);
+}
+
 #endif
-- 
2.53.0

