Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1D243DA23;
	Wed,  1 Jul 2026 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904523; cv=none; b=D0VgXroj3CwxS0fVwpxOdxUY8HZ94ZgMws9tMDSYDglN6HWxJsw9RWhzCznYUWmzrnvWeWkgIC1aoPh+XFb95rTDBFJ3zvO54ymqK0m/Bx502YFwNFH/QeOrMmRB257bWOagx0fu3CJl93583tdzilke7pY5JOaqG8ZKDXUUVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904523; c=relaxed/simple;
	bh=VqeljGIa8w8g3eNoL9uvC7nuJ1t1Z2ykOrzgSprpUc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvHKhmCGbTbQeeznO3W2LAwZh9ptSsiJBT1pAiNogw4nGOKAK2P7B4UEZ3Mh55RFkqjz6gT4W59sr/CBemqA27iD03UbfCkF3j881+4hqSjB2EegEw3vquVN2hV/wFloeQovzD3bMICDQLf1r0PeG19GToSLxQbOxhTuFjAOrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2OG/IIe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2OG/IIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2C31F000E9;
	Wed,  1 Jul 2026 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782904521;
	bh=uxInDaGHqiPxY8/dZZHU4VDRajxnuh1zCUvcR/xXvyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2OG/IIeqp5SiECv2Klxb/ujxDYWQaGpLVPaCbfo4vaAS2MHvCdtnLDNiqJBo71UC
	 05MOE2F7yj111lUq/hrrgabuCZQdf2nHEfTbhKjSGRreD9CizK9K6TxQTCPdFHIXZK
	 SLt/OAEsGgxijRNbmYrWw89HITjTCLmmhfkxWuvF3zWsw4QDs6rfWnDBiSn4MpUkZJ
	 v/xudRkHpo5T31qmMEsSg4FBDEGkKOFFykCCD6jvPuxKraGyXyivJpTV/w+1ryeqPo
	 KX+Mt9IvXDu1c50ROHWGYVCAoFtabl/WN+Y5fEiWn9oZC6xCecYmpIXksAAoGGKVTy
	 0CYCGDx5TDb1w==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv5 09/13] selftests/bpf: Change uprobe syscall tests to use nop10
Date: Wed,  1 Jul 2026 13:13:33 +0200
Message-ID: <20260701111337.53943-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701111337.53943-1-jolsa@kernel.org>
References: <20260701111337.53943-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimized uprobes are now on top of 10-bytes nop instructions,
reflect that in existing tests.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/benchs/bench_trigger.c      |  2 +-
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 30 +++++++++++--------
 tools/testing/selftests/bpf/prog_tests/usdt.c | 25 +++++++++-------
 tools/testing/selftests/bpf/usdt_2.c          |  2 +-
 4 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 2f22ec61667b..a60b8173cdc4 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -398,7 +398,7 @@ static void *uprobe_producer_ret(void *input)
 #ifdef __x86_64__
 __nocf_check __weak void uprobe_target_nop5(void)
 {
-	asm volatile (".byte 0x0f, 0x1f, 0x44, 0x00, 0x00");
+	asm volatile (".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00");
 }
 
 static void *uprobe_producer_nop5(void *input)
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c944136252c6..ba50071ace40 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -17,7 +17,7 @@
 #include "uprobe_syscall_executed.skel.h"
 #include "bpf/libbpf_internal.h"
 
-#define USDT_NOP .byte 0x0f, 0x1f, 0x44, 0x00, 0x00
+#define USDT_NOP .byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00
 #include "usdt.h"
 
 #pragma GCC diagnostic ignored "-Wattributes"
@@ -26,7 +26,7 @@ __attribute__((aligned(16)))
 __nocf_check __weak __naked unsigned long uprobe_regs_trigger(void)
 {
 	asm volatile (
-		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00\n" /* nop5 */
+		".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
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
+		".byte 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00\n" /* nop10 */
+		"ret\n"
 	);
 }
 
@@ -388,14 +388,15 @@ static int find_uprobes_trampoline(void *tramp_addr)
 	return ret;
 }
 
-static unsigned char nop5[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char nop10[10]  = { 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
+static unsigned char lea_rsp[5] = { 0x48, 0x8d, 0x64, 0x24, 0x80 };
 
-static void *find_nop5(void *fn)
+static void *find_nop10(void *fn)
 {
 	int i;
 
-	for (i = 0; i < 10; i++) {
-		if (!memcmp(nop5, fn + i, 5))
+	for (i = 0; i < 128; i++) {
+		if (!memcmp(nop10, fn + i, 10))
 			return fn + i;
 	}
 	return NULL;
@@ -420,7 +421,8 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 	ASSERT_EQ(skel->bss->executed, executed, "executed");
 
 	/* .. and check the trampoline is as expected. */
-	call = (struct __arch_relative_insn *) addr;
+	ASSERT_OK(memcmp(addr, lea_rsp, 5), "lea_rsp");
+	call = (struct __arch_relative_insn *)(addr + 5);
 	tramp = (void *) (call + 1) + call->raddr;
 	ASSERT_EQ(call->op, 0xe8, "call");
 	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
@@ -430,9 +432,11 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 
 static void check_detach(void *addr, void *tramp)
 {
+	static const unsigned char nop10_prefix[] = { 0x66, 0x2e, 0x0f, 0x1f, 0x84 };
+
 	/* [uprobes_trampoline] stays after detach */
 	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
+	ASSERT_OK(memcmp(addr, nop10_prefix, 5), "nop10_prefix");
 }
 
 static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
@@ -568,8 +572,8 @@ static void test_uprobe_usdt(void)
 	void *addr;
 
 	errno = 0;
-	addr = find_nop5(usdt_test);
-	if (!ASSERT_OK_PTR(addr, "find_nop5"))
+	addr = find_nop10(usdt_test);
+	if (!ASSERT_OK_PTR(addr, "find_nop10"))
 		return;
 
 	skel = uprobe_syscall_executed__open_and_load();
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 69759b27794d..fda3a298ccfc 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -252,7 +252,7 @@ extern void usdt_1(void);
 extern void usdt_2(void);
 
 static unsigned char nop1[1] = { 0x90 };
-static unsigned char nop1_nop5_combo[6] = { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static unsigned char nop1_nop10_combo[11] = { 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
 static void *find_instr(void *fn, unsigned char *instr, size_t cnt)
 {
@@ -271,17 +271,17 @@ static void subtest_optimized_attach(void)
 	__u8 *addr_1, *addr_2;
 
 	/* usdt_1 USDT probe has single nop instruction */
-	addr_1 = find_instr(usdt_1, nop1_nop5_combo, 6);
-	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop5_combo"))
+	addr_1 = find_instr(usdt_1, nop1_nop10_combo, 11);
+	if (!ASSERT_NULL(addr_1, "usdt_1_find_nop1_nop10_combo"))
 		return;
 
 	addr_1 = find_instr(usdt_1, nop1, 1);
 	if (!ASSERT_OK_PTR(addr_1, "usdt_1_find_nop1"))
 		return;
 
-	/* usdt_2 USDT probe has nop,nop5 instructions combo */
-	addr_2 = find_instr(usdt_2, nop1_nop5_combo, 6);
-	if (!ASSERT_OK_PTR(addr_2, "usdt_2_find_nop1_nop5_combo"))
+	/* usdt_2 USDT probe has nop,nop10 instructions combo */
+	addr_2 = find_instr(usdt_2, nop1_nop10_combo, 11);
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
2.54.0

