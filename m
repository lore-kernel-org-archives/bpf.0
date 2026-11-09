Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254314;
	b=APr5gDi5p8oPKsd7y53sj45I5RnQOKqagaUg/fbNT7LvkhGFuzX2pWItg3f1HJdeHCRM
	 L36eZm9kobdQdRMs5o+TaUNFSnxIJ9mBa+DtYfF7b9/eKa3Z6xf7p1EclQ5Y2ih6uEIQS
	 Ycxo0KXCMBVOhOULNhyY2uUlgNeyTcyd8AyaEOSJTBTM60WxTzKnUufH9D9nxWijcc31E
	 kz5kvfWuV1wrCrlgKSpNOarYSv9RF6OTxZGHuLMwQ6mvHOB8DmZfIK9utPFkqIhMk0sEm
	 qE7dHNeZDlb4AznNDIdDGR9B6eD6NIYmHq1Za5V38M8jZXOGaz5Ux/lYXpYRqA5Y88A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254314;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4LLcytvgiqaTQB/HnV4lcSiqodwY4xf9iEicHvUEDSA=;
	b=HHwEoCj6kzqkkxMi0t/YtWcEvRcm2MrSquZ1nTM1vC9Qr4RNSJkqB+X1v/oZNRMfkaFs
	 2/pHxWBdfNMy1ZaKO9goRYaYDgr0jZ+61i7VfG7GiSSaFO55+4y22wNh42G8o/UQREfgT
	 ZPQ5TZKUSummg7sNsROxPxenJcxpZQj0c4GC50gucO6z2/fSTuWk/oj55iY8QOmOO+rUC
	 AqJ/P5V8AvQURUw+X6bf7XDu1GR8oAn3ZequwvLu2fEu0qyel4OusjuPWngD9E2ZgkgtQ
	 K6KJane045tRAQx8WrL5ORqouHxvWFg0UXaWhcizgoA23Yl1p75zICchiMiUpRh7JQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0HtUjlM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA798606A337;
	Mon,  9 Nov 2026 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0HtUjlM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965A61F008A3;
	Mon,  9 Nov 2026 19:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254313;
	bh=4LLcytvgiqaTQB/HnV4lcSiqodwY4xf9iEicHvUEDSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0HtUjlMnfKb8uJ3PxaNMQy1IEDyhh4b88cUQ08awBNgLSrHbzwF2a6A7HkHXpIGM
	 enUX4+RMAQRy+lJhvfGT04Jdu09bwZJ/15HD94h5xrRnCMoilCKfMY9JGEhJYYSiMY
	 Tidqkws6mFfztUOqhNjyzrzYM/of2z5mSYMLUOLEuxJPuJiZzIiiQUGBDLCZ1IJqpn
	 OuurByXiX148Ui63PzJUZrPQmKAlGMcjnJez2NRuTzjoYQodn8vd+cH3uSbX3g7PRg
	 yAW7opPKzeeA7FuDhXgDZc1ofA/bD2XeX4FAhkBuBPwwrj1SepL5qiFgXc5Tu7xxSr
	 VYfhyX1oApXOA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alan Maguire <almagui@kernel.org>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 13/13] samples/kprobes: Add batch probe example
Date: Mon,  9 Nov 2026 20:58:27 +0100
Message-ID: <20261109195827.1091410-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194916.1089703-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sample module that registers kprobes on a batch of
generated functions and calls each function to trigger
the probes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/Makefile                       |  3 +
 kernel/kprobes_many.c                 | 81 ++++++++++++++++++++++++
 samples/Kconfig                       |  8 +++
 samples/kprobes/Makefile              |  1 +
 samples/kprobes/kprobe_many_example.c | 91 +++++++++++++++++++++++++++
 5 files changed, 184 insertions(+)
 create mode 100644 kernel/kprobes_many.c
 create mode 100644 samples/kprobes/kprobe_many_example.c

diff --git a/kernel/Makefile b/kernel/Makefile
index 4ff92e24680c..f307b29d4fef 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -99,6 +99,9 @@ obj-$(CONFIG_AUDITSYSCALL) += auditsc.o audit_watch.o audit_fsnotify.o audit_tre
 obj-$(CONFIG_GCOV_KERNEL) += gcov/
 obj-$(CONFIG_KCOV) += kcov.o
 obj-$(CONFIG_KPROBES) += kprobes.o
+ifneq ($(CONFIG_SAMPLE_KPROBES_MANY),)
+obj-y += kprobes_many.o
+endif
 obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
diff --git a/kernel/kprobes_many.c b/kernel/kprobes_many.c
new file mode 100644
index 000000000000..1c31a63309bf
--- /dev/null
+++ b/kernel/kprobes_many.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Generated functions for the batch kprobe sample.
+ */
+
+#include <linux/annotate.h>
+#include <linux/export.h>
+#include <linux/linkage.h>
+#include <linux/stringify.h>
+#include <asm/asm.h>
+#include <asm/ibt.h>
+
+#define KPROBE_MANY_MAX_FUNCS	50000
+#define KPROBE_MANY_FUNC_SIZE	24
+#define KPROBE_MANY_PROBE_OFF	8
+
+#if defined(CONFIG_MITIGATION_RETHUNK)
+#define KPROBE_MANY_RET		ASM_RET
+#define KPROBE_MANY_RET_SIZE	5
+#elif defined(CONFIG_MITIGATION_SLS)
+#define KPROBE_MANY_RET		ASM_RET
+#define KPROBE_MANY_RET_SIZE	2
+#else
+#define KPROBE_MANY_RET		ASM_RET
+#define KPROBE_MANY_RET_SIZE	1
+#endif
+
+#define KPROBE_MANY_TAIL_NOPS \
+	(KPROBE_MANY_FUNC_SIZE - KPROBE_MANY_PROBE_OFF - 7 - \
+	 KPROBE_MANY_RET_SIZE)
+
+extern char kprobes_many_func_0[];
+EXPORT_SYMBOL_GPL(kprobes_many_func_0);
+
+/*
+ * Keep these functions at a fixed size so the sample module can place
+ * probes at the same offset in every function.
+ *
+ * For example, KPROBE_MANY_FUNC kprobes_many_func_0 emits:
+ *
+ * kprobes_many_func_0:		ENDBR
+ * 				NOPS to offset 8
+ * 1:				probe site (offset 8), annotated as NOENDBR
+ * 				7 NOPS for the kprobe optimizer
+ * 				NOPS to fill the function
+ * 				RET
+ *
+ * The NOPS and return sequence keep each function 24 bytes long, including
+ * the ENDBR instruction when enabled.
+ */
+asm (
+	".pushsection .text, \"ax\", @progbits\n"
+	".macro KPROBE_MANY_FUNC name\n"
+	".type \\name, @function\n"
+	"\\name:\n"
+	ASM_ENDBR
+	IBT_NOSEAL("\\name")
+	".rept " __stringify(KPROBE_MANY_PROBE_OFF - ENDBR_INSN_SIZE) "\n"
+	"	nop\n"
+	".endr\n"
+	"1:\n"
+	ASM_ANNOTATE_LABEL(1b, ANNOTYPE_NOENDBR) "\n"
+	".rept 7\n"
+	"	nop\n"
+	".endr\n"
+	".rept " __stringify(KPROBE_MANY_TAIL_NOPS) "\n"
+	"	nop\n"
+	".endr\n"
+	KPROBE_MANY_RET
+	".size \\name, .-\\name\n"
+	".endm\n"
+	".macro KPROBE_MANY_FUNC_LOCAL\n"
+	"KPROBE_MANY_FUNC kprobes_many_func_\\@\n"
+	".endm\n"
+	".globl kprobes_many_func_0\n"
+	"KPROBE_MANY_FUNC kprobes_many_func_0\n"
+	".rept " __stringify(KPROBE_MANY_MAX_FUNCS - 1) "\n"
+	"	KPROBE_MANY_FUNC_LOCAL\n"
+	".endr\n"
+	".popsection\n");
diff --git a/samples/Kconfig b/samples/Kconfig
index 00eed83c07df..92a41c5fdbfd 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -80,6 +80,14 @@ config SAMPLE_KRETPROBES
 	default m
 	depends on SAMPLE_KPROBES && KRETPROBES
 
+config SAMPLE_KPROBES_MANY
+	tristate "Build batch kprobe example -- x86 loadable module only"
+	depends on SAMPLE_KPROBES && X86 && m
+	help
+	  This builds a sample module that registers kprobes in the middle of
+	  50000 generated x86 kernel functions using the batch kprobe
+	  interface.
+
 config SAMPLE_HW_BREAKPOINT
 	tristate "Build kernel hardware breakpoint examples -- loadable module only"
 	depends on HAVE_HW_BREAKPOINT && m
diff --git a/samples/kprobes/Makefile b/samples/kprobes/Makefile
index e774592718d6..2fd2150e523c 100644
--- a/samples/kprobes/Makefile
+++ b/samples/kprobes/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_SAMPLE_KPROBES) += kprobe_example.o
 obj-$(CONFIG_SAMPLE_KRETPROBES) += kretprobe_example.o
+obj-$(CONFIG_SAMPLE_KPROBES_MANY) += kprobe_many_example.o
diff --git a/samples/kprobes/kprobe_many_example.c b/samples/kprobes/kprobe_many_example.c
new file mode 100644
index 000000000000..5a58908c840c
--- /dev/null
+++ b/samples/kprobes/kprobe_many_example.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Sample module that registers a batch of kprobes in generated kernel
+ * functions.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kprobes.h>
+#include <linux/module.h>
+
+#define KPROBE_MANY_MAX_FUNCS 50000
+#define KPROBE_MANY_FUNC_SIZE 24
+#define KPROBE_MANY_PROBE_OFF 8
+
+extern char kprobes_many_func_0[];
+
+static unsigned int nr_functions = 20000;
+module_param(nr_functions, uint, 0444);
+MODULE_PARM_DESC(nr_functions, "number of generated functions to probe (1-50000)");
+
+static struct kprobe probes[KPROBE_MANY_MAX_FUNCS];
+static struct kprobe *probe_ptrs[KPROBE_MANY_MAX_FUNCS];
+static unsigned int kprobe_many_pre_handler_count;
+
+static int __kprobes kprobe_many_pre_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	kprobe_many_pre_handler_count++;
+	return 0;
+}
+
+/* The generated assembly functions have no CFI type metadata. */
+static noinline __nocfi void
+kprobe_many_call_function(char *functions, unsigned int index)
+{
+	void (*function)(void);
+
+	function = (void (*)(void))(functions + index * KPROBE_MANY_FUNC_SIZE);
+	function();
+}
+
+static int __init kprobe_many_init(void)
+{
+	char *functions;
+	unsigned int i;
+	unsigned int hit_count;
+	int ret;
+
+	if (!nr_functions || nr_functions > KPROBE_MANY_MAX_FUNCS)
+		return -EINVAL;
+
+	functions = kprobes_many_func_0;
+
+	for (i = 0; i < nr_functions; i++) {
+		probes[i].addr = (void *)(functions + i * KPROBE_MANY_FUNC_SIZE +
+					  KPROBE_MANY_PROBE_OFF);
+		probes[i].pre_handler = kprobe_many_pre_handler;
+		probe_ptrs[i] = &probes[i];
+	}
+
+	ret = register_kprobes(probe_ptrs, nr_functions);
+	if (ret) {
+		pr_err("register_kprobes failed, returned %d\n", ret);
+		return ret;
+	}
+
+	pr_info("registered %u probes\n", nr_functions);
+	for (i = 0; i < nr_functions; i++)
+		kprobe_many_call_function(functions, i);
+
+	hit_count = kprobe_many_pre_handler_count;
+	if (hit_count != nr_functions) {
+		pr_err("pre-handler triggered %u times, expected %u\n",
+		       hit_count, nr_functions);
+		unregister_kprobes(probe_ptrs, nr_functions);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void __exit kprobe_many_exit(void)
+{
+	unregister_kprobes(probe_ptrs, nr_functions);
+	pr_info("unregistered %u probes\n", nr_functions);
+}
+
+module_init(kprobe_many_init);
+module_exit(kprobe_many_exit);
+
+MODULE_DESCRIPTION("sample module registering kprobes in generated functions");
+MODULE_LICENSE("GPL");
-- 
2.43.0

