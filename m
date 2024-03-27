Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433043839D
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534863; cv=none; b=T6RysY+Bw8GM8na3PAFnEC2apyveouFWRf3t+9MnxQCHIQZYssUs5nrHMAhr1Nzr9MtuSuwiDlPpLi3kOEi5Bf80YY7OOjFsCyH3PxQIO3LKaIGc4Vnk6YJVzyeViJShBMPXoRLTwzNCQ3O95NBHwYZH1JwSw+5D2VIiZ6hrm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534863; c=relaxed/simple;
	bh=TWNui25s1EkfmXvPFiumY0g49m2WT4pvcj6b0M6ToxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAda43xiSM+QGlzgZu5TMpuSgvh4oBG7q6yUC4ZNGQXiY8ZpN3uP3qxkdWxhBFkB450q21nh4SRYRD4iUGYUhUwt+9jwxEuNixKIlSLDPFkQqCpwz6UFeON45XienRDmGt+w9auS26C/F0FckXo+DuAm1gves6CVDK919M3AGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lILBquth; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lILBquth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E6BC433F1;
	Wed, 27 Mar 2024 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711534862;
	bh=TWNui25s1EkfmXvPFiumY0g49m2WT4pvcj6b0M6ToxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lILBquthIBCwhF/ZUcFHOY8wGMDOB8rkdxRwrrtgQRX1dC0l4tZ1HT1jLRV+ik1y9
	 pSySisgLV9xTz3bYRxFy9rq3vKUFb5o6EPqrkL38ymwOB+/3gDMXiM5T+sZTUwdjv0
	 xMI+pVFygMDwNmYGV2X9jyCy8Ujw1HALMRZ6CY9JFdyWgLvK9NPgWARbhR1WMqHzaL
	 R67iQIF0Phoh7UezmMnt2+PvwQd80pZEAoSViYZDVaujvom7ZYKe9YQ1KKwQ6qDfti
	 ob4dlzuGB+/KhQa5SxnITNvbJVWlVmsEBW8Wl0WCfBGN6uvsOjVAQvpKuhhPL0Lv5R
	 Omj9BkOQ0WUMQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH bpf-next 2/3] selftests/bpf: Add uretprobe syscall test for regs integrity
Date: Wed, 27 Mar 2024 11:20:35 +0100
Message-ID: <20240327102036.543283-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327102036.543283-1-jolsa@kernel.org>
References: <20240327102036.543283-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add uretprobe syscall test that compares register values before
and after the uretprobe is hit. It also compares the register
values seen from attached bpf program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/linux/compiler.h                |   4 +
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 163 ++++++++++++++++++
 .../selftests/bpf/progs/uprobe_syscall.c      |  15 ++
 3 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 8a63a9913495..6f7f22ac9da5 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -62,6 +62,10 @@
 #define __nocf_check __attribute__((nocf_check))
 #endif
 
+#ifndef __naked
+#define __naked __attribute__((__naked__))
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
 # define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
new file mode 100644
index 000000000000..14b1cf7a53b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#ifdef __x86_64__
+
+#include <unistd.h>
+#include <asm/ptrace.h>
+#include <linux/compiler.h>
+#include "uprobe_syscall.skel.h"
+
+__naked unsigned long uprobe_syscall_arch_test(void)
+{
+	asm volatile (
+		"movq $0xdeadbeef, %rax\n"
+		"ret\n"
+	);
+}
+
+__naked void uprobe_syscall_arch(struct pt_regs *before, struct pt_regs *after)
+{
+	asm volatile (
+		"movq %r15,   0(%rdi)\n"
+		"movq %r14,   8(%rdi)\n"
+		"movq %r13,  16(%rdi)\n"
+		"movq %r12,  24(%rdi)\n"
+		"movq %rbp,  32(%rdi)\n"
+		"movq %rbx,  40(%rdi)\n"
+		"movq %r11,  48(%rdi)\n"
+		"movq %r10,  56(%rdi)\n"
+		"movq  %r9,  64(%rdi)\n"
+		"movq  %r8,  72(%rdi)\n"
+		"movq %rax,  80(%rdi)\n"
+		"movq %rcx,  88(%rdi)\n"
+		"movq %rdx,  96(%rdi)\n"
+		"movq %rsi, 104(%rdi)\n"
+		"movq %rdi, 112(%rdi)\n"
+		"movq   $0, 120(%rdi)\n" /* orig_rax */
+		"movq   $0, 128(%rdi)\n" /* rip      */
+		"movq   $0, 136(%rdi)\n" /* cs       */
+		"pushf\n"
+		"pop %rax\n"
+		"movq %rax, 144(%rdi)\n" /* eflags   */
+		"movq %rsp, 152(%rdi)\n" /* rsp      */
+		"movq   $0, 160(%rdi)\n" /* ss       */
+
+		/* save 2nd argument */
+		"pushq %rsi\n"
+		"call uprobe_syscall_arch_test\n"
+
+		/* save  return value and load 2nd argument pointer to rax */
+		"pushq %rax\n"
+		"movq 8(%rsp), %rax\n"
+
+		"movq %r15,   0(%rax)\n"
+		"movq %r14,   8(%rax)\n"
+		"movq %r13,  16(%rax)\n"
+		"movq %r12,  24(%rax)\n"
+		"movq %rbp,  32(%rax)\n"
+		"movq %rbx,  40(%rax)\n"
+		"movq %r11,  48(%rax)\n"
+		"movq %r10,  56(%rax)\n"
+		"movq  %r9,  64(%rax)\n"
+		"movq  %r8,  72(%rax)\n"
+		"movq %rcx,  88(%rax)\n"
+		"movq %rdx,  96(%rax)\n"
+		"movq %rsi, 104(%rax)\n"
+		"movq %rdi, 112(%rax)\n"
+		"movq   $0, 120(%rax)\n" /* orig_rax */
+		"movq   $0, 128(%rax)\n" /* rip      */
+		"movq   $0, 136(%rax)\n" /* cs       */
+
+		/* restore return value and 2nd argument */
+		"pop %rax\n"
+		"pop %rsi\n"
+
+		"movq %rax,  80(%rsi)\n"
+
+		"pushf\n"
+		"pop %rax\n"
+
+		"movq %rax, 144(%rsi)\n" /* eflags   */
+		"movq %rsp, 152(%rsi)\n" /* rsp      */
+		"movq   $0, 160(%rsi)\n" /* ss       */
+		"ret\n"
+);
+}
+
+static void test_uretprobe_regs_equal(void)
+{
+	struct uprobe_syscall *skel = NULL;
+	struct pt_regs before = {}, after = {};
+	unsigned long *pb = (unsigned long *) &before;
+	unsigned long *pa = (unsigned long *) &after;
+	unsigned long *pp;
+	unsigned int i, cnt;
+	int err;
+
+	skel = uprobe_syscall__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall__open_and_load"))
+		goto cleanup;
+
+	err = uprobe_syscall__attach(skel);
+	if (!ASSERT_OK(err, "uprobe_syscall__attach"))
+		goto cleanup;
+
+	uprobe_syscall_arch(&before, &after);
+
+	pp = (unsigned long *) &skel->bss->regs;
+	cnt = sizeof(before)/sizeof(*pb);
+
+	for (i = 0; i < cnt; i++) {
+		unsigned int offset = i * sizeof(unsigned long);
+
+		/*
+		 * Check register before and after uprobe_syscall_arch_test call
+		 * that triggers the uretprobe.
+		 */
+		switch (offset) {
+		case offsetof(struct pt_regs, rax):
+			ASSERT_EQ(pa[i], 0xdeadbeef, "return value");
+			break;
+		default:
+			if (!ASSERT_EQ(pb[i], pa[i], "register before-after value check"))
+				fprintf(stdout, "failed register offset %u\n", offset);
+		}
+
+		/*
+		 * Check register seen from bpf program and register after
+		 * uprobe_syscall_arch_test call
+		 */
+		switch (offset) {
+		/*
+		 * These values will be different (not set in uprobe_syscall_arch),
+		 * we don't care.
+		 */
+		case offsetof(struct pt_regs, orig_rax):
+		case offsetof(struct pt_regs, rip):
+		case offsetof(struct pt_regs, cs):
+		case offsetof(struct pt_regs, rsp):
+		case offsetof(struct pt_regs, ss):
+			break;
+		default:
+			if (!ASSERT_EQ(pp[i], pa[i], "register prog-after value check"))
+				fprintf(stdout, "failed register offset %u\n", offset);
+		}
+	}
+
+cleanup:
+	uprobe_syscall__destroy(skel);
+}
+#else
+static void test_uretprobe_regs_equal(void)
+{
+	test__skip();
+}
+#endif
+
+void test_uprobe_syscall(void)
+{
+	if (test__start_subtest("uretprobe_regs_equal"))
+		test_uretprobe_regs_equal();
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
new file mode 100644
index 000000000000..3b7e0a63f659
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <string.h>
+
+struct pt_regs regs;
+
+char _license[] SEC("license") = "GPL";
+
+SEC("uretprobe//proc/self/exe:uprobe_syscall_arch_test")
+int uretprobe(struct pt_regs *ctx)
+{
+	__builtin_memcpy(&regs, ctx, sizeof(regs));
+	return 0;
+}
-- 
2.44.0

