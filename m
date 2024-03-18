Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87372C690
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754323; cv=none; b=FKxjOD+WNG8cvV4m6VHb5LAXw2vIqG1E6je5iD1AciYbFGRa0au7NGKT/HfeIWZS2Y6zVnndQCk4IuJY8VhmX2gIUF7LrG9DeigxDhzhomBXSoqbP4CZU/5NeBhVBrp6X66/9XdDeBJV5kmKl7C40niCe7zXWBYuU2KQv9bHBDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754323; c=relaxed/simple;
	bh=5DboNuMwT5PdIDVwPvOeDhnMZylEb9eibCS4DHvnQU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyAsn74nR+bOcaTXDPOakYHdSt8EYpazUxmU/ncdDb9lNueHa6LWwH5Cz2VXfmyNgzLO+IrJajD0B4AR4P2+qDwZjBjASflTW1j0HQ3ke0qiVcDn1BFYAdsubctigmD5dXMUPQa7NFtnbFthX6jTZSC9CkjFky45YNcIwezZa8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvPswqKL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvPswqKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFEAC433F1;
	Mon, 18 Mar 2024 09:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710754323;
	bh=5DboNuMwT5PdIDVwPvOeDhnMZylEb9eibCS4DHvnQU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tvPswqKLAiillPvOzVL2ytrZmiP2QirZqu7X8GN8GDqOngfUIJPq3w3gHX/jf69fI
	 O9QrgyhZfuCNHOB5qcTHpm2plkw0RRJg7j5Ly0kSgJk0FR0SNbpA+hwlBteJOAwXfm
	 jBPh0ZmqsOXtOmQZktp0kDlZ/yLvzsy0VzCrG3S9jmiukd2gf4gE3mmdtoVY2MXwVq
	 M1gHEDtkkYN+BRmNzaSAm3mPMd2LWtRvrmP2R0k4UKtQq29GyrXVaN3T+b4bavkqwI
	 SYRLc1cdo3MhAudJIoBz7a13x63IRqKNWXqGHb3cD08WV+MgQr1UZ3q4avAcBxDyc8
	 WZ+j11gZdOI6Q==
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
Subject: [PATCH RFC bpf-next 2/3] selftests/bpf: Add uretprobe syscall test
Date: Mon, 18 Mar 2024 10:31:37 +0100
Message-ID: <20240318093139.293497-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093139.293497-1-jolsa@kernel.org>
References: <20240318093139.293497-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add uretprobe syscall test and compare register values before
and after the uretprobe is hit. Also compare the register values
seen from attached bpf program.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          | 13 ++-
 .../bpf/prog_tests/arch/x86/uprobe_syscall.S  | 89 +++++++++++++++++++
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 84 +++++++++++++++++
 .../selftests/bpf/progs/uprobe_syscall.c      | 15 ++++
 4 files changed, 200 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arch/x86/uprobe_syscall.S
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 3b9eb40d6343..e425a946276b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -490,6 +490,9 @@ TRUNNER_TEST_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.test.o,	\
 				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/*.c)))
 TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
 				 $$(filter %.c,$(TRUNNER_EXTRA_SOURCES)))
+TRUNNER_ASM_OBJS := $$(patsubst %.S,$$(TRUNNER_OUTPUT)/%.arch.o,	\
+				 $$(notdir $$(wildcard $(TRUNNER_TESTS_DIR)/arch/$(SRCARCH)/*.S)))
+
 TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
 TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
 TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
@@ -597,6 +600,13 @@ $(TRUNNER_EXTRA_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
 	$$(call msg,EXT-OBJ,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
 
+$(TRUNNER_ASM_OBJS): $(TRUNNER_OUTPUT)/%.arch.o:			\
+		       $(TRUNNER_TESTS_DIR)/arch/$(SRCARCH)/%.S		\
+		       $(TRUNNER_TESTS_HDR)				\
+		       $$(BPFOBJ) | $(TRUNNER_OUTPUT)
+	$$(call msg,ASM-OBJ,$(TRUNNER_BINARY),$$@)
+	$(Q)$$(CC) $$(CFLAGS) -c $$< $$(LDLIBS) -o $$@
+
 # non-flavored in-srctree builds receive special treatment, in particular, we
 # do not need to copy extra resources (see e.g. test_btf_dump_case())
 $(TRUNNER_BINARY)-extras: $(TRUNNER_EXTRA_FILES) | $(TRUNNER_OUTPUT)
@@ -606,7 +616,8 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
 endif
 
 $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
-			     $(TRUNNER_EXTRA_OBJS) $$(BPFOBJ)		\
+			     $(TRUNNER_EXTRA_OBJS) $(TRUNNER_ASM_OBJS)	\
+			     $$(BPFOBJ)					\
 			     $(RESOLVE_BTFIDS)				\
 			     $(TRUNNER_BPFTOOL)				\
 			     | $(TRUNNER_BINARY)-extras
diff --git a/tools/testing/selftests/bpf/prog_tests/arch/x86/uprobe_syscall.S b/tools/testing/selftests/bpf/prog_tests/arch/x86/uprobe_syscall.S
new file mode 100644
index 000000000000..bcbad218c4d6
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arch/x86/uprobe_syscall.S
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef ASM_NL
+#define ASM_NL	 ;
+#endif
+
+#define SYM_ENTRY(name)			\
+	.globl name ASM_NL		\
+	name:
+
+#define SYM_END(name)			\
+	.type name STT_FUNC ASM_NL	\
+	.size name, .-name ASM_NL
+
+.code64
+.section .text, "ax"
+
+SYM_ENTRY(uprobe_syscall_arch_test)
+	movq $0xdeadbeef, %rax
+	ret
+SYM_END(uprobe_syscall_arch_test)
+
+.globl uprobe_syscall_arch
+uprobe_syscall_arch:
+	movq %r15,   0(%rdi)
+	movq %r14,   8(%rdi)
+	movq %r13,  16(%rdi)
+	movq %r12,  24(%rdi)
+	movq %rbp,  32(%rdi)
+	movq %rbx,  40(%rdi)
+	movq %r11,  48(%rdi)
+	movq %r10,  56(%rdi)
+	movq  %r9,  64(%rdi)
+	movq  %r8,  72(%rdi)
+	movq %rax,  80(%rdi)
+	movq %rcx,  88(%rdi)
+	movq %rdx,  96(%rdi)
+	movq %rsi, 104(%rdi)
+	movq %rdi, 112(%rdi)
+	movq   $0, 120(%rdi) /* orig_rax */
+	movq   $0, 128(%rdi) /* rip      */
+	movq   $0, 136(%rdi) /* cs       */
+
+	pushf
+	pop %rax
+
+	movq %rax, 144(%rdi) /* eflags   */
+	movq %rsp, 152(%rdi) /* rsp      */
+	movq   $0, 160(%rdi) /* ss       */
+
+	pushq %rsi
+	call uprobe_syscall_arch_test
+
+	/* store return value and get second argument pointer  to rax */
+	pushq %rax
+	movq 8(%rsp), %rax
+
+	movq %r15,   0(%rax)
+	movq %r14,   8(%rax)
+	movq %r13,  16(%rax)
+	movq %r12,  24(%rax)
+	movq %rbp,  32(%rax)
+	movq %rbx,  40(%rax)
+	movq %r11,  48(%rax)
+	movq %r10,  56(%rax)
+	movq  %r9,  64(%rax)
+	movq  %r8,  72(%rax)
+	movq %rcx,  88(%rax)
+	movq %rdx,  96(%rax)
+	movq %rsi, 104(%rax)
+	movq %rdi, 112(%rax)
+	movq   $0, 120(%rax) /* orig_rax */
+	movq   $0, 128(%rax) /* rip      */
+	movq   $0, 136(%rax) /* cs       */
+
+	pop %rax
+	pop %rsi
+	movq %rax,  80(%rsi)
+
+	pushf
+	pop %rax
+
+	movq %rax, 144(%rsi) /* eflags   */
+	movq %rsp, 152(%rsi) /* rsp      */
+	movq   $0, 160(%rsi) /* ss       */
+
+	ret
+
+.section .note.GNU-stack,"",@progbits
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
new file mode 100644
index 000000000000..0df205fea957
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#ifdef __x86_64__
+
+#include <unistd.h>
+#include <asm/ptrace.h>
+#include "uprobe_syscall.skel.h"
+
+extern int uprobe_syscall_arch(struct pt_regs *before, struct pt_regs *after);
+
+static void test_uretprobe(void)
+{
+	struct pt_regs before = {}, after = {};
+	unsigned long *pb = (unsigned long *) &before;
+	unsigned long *pa = (unsigned long *) &after;
+	unsigned long *prog_regs;
+	struct uprobe_syscall *skel = NULL;
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
+	prog_regs = (unsigned long *) &skel->bss->regs;
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
+		 * These will be different (not set in uprobe_syscall_arch),
+		 * we don't care.
+		 */
+		case offsetof(struct pt_regs, orig_rax):
+		case offsetof(struct pt_regs, rip):
+		case offsetof(struct pt_regs, cs):
+		case offsetof(struct pt_regs, rsp):
+		case offsetof(struct pt_regs, ss):
+			break;
+		default:
+			if (!ASSERT_EQ(prog_regs[i], pa[i], "register prog-after value check"))
+				fprintf(stdout, "failed register offset %u\n", offset);
+		}
+	}
+
+cleanup:
+	uprobe_syscall__destroy(skel);
+}
+#else
+static void test_uretprobe(void) { }
+#endif
+
+void test_uprobe_syscall(void)
+{
+	if (test__start_subtest("uretprobe"))
+		test_uretprobe();
+}
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
new file mode 100644
index 000000000000..0cc7e8761410
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
+	memcpy(&regs, ctx, sizeof(regs));
+	return 0;
+}
-- 
2.44.0

