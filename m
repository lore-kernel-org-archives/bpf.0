Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC16382F06
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435904; cv=none; b=mmHND9vY77WswEHXYS+2pkc+amqE3d+Z4t51wcux7JkfRsbIA4K5LiEH4vXvlLLZyFDd7no0wzdS8OF3SYiOjcj85G79pz1tAZaBeWBqF+IZxFBwuW6eAcZ4pMC9qQIlyHXszZWU/Htj2zp5wC54d7z5I1HdvY9/CeC91VKyRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435904; c=relaxed/simple;
	bh=JZYp+sHtQC7bLCt5rA2IaPRvcpY1Z3TrxEXp/XBLz1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWhGFk5arM6JBC2hI6qPtWY0iFp0RG+DI2mpJre5jDgueDc/kl6ZDK4v4A9S6qfg1GhTyR0CG6f9mk87vvMsqI3BU9XVn0wEOFNloZwi+TK0/o4Z9uMSt1LK5+luDMomPY/KfplCndtm4Ee1C0q7QzKfErGHJD7lfoFrLWRooLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8ur5XeV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8ur5XeV"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so21781375e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773435902; x=1774040702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VdLlI8p3c2ml716EZ2LGSjLC8UKoGj5GsyCV00O6Eo=;
        b=l8ur5XeVwelqO5kBCiDeim4AC8m3gX5rZG5wphU3brKBSzAr1T/vgIitS4OTHpkfIr
         6qI7I8nFu0q/8hsYFXfh09pwxw3wM8pDNoO3kluemm/vQj7pgsQ9BgZphFWHNoNKLcxC
         IePbpwrqIrW5Sol3f/iMYsrc+vUnBmfVu6lQrazuRapfIjO63GNX/xgJQj43IQXt8orq
         xvv6uEgQZg2q9dlLRRbSM8cDT5p9MSQHXzuBBYPqnYKY7BRnhRfu84fDnFq41f1ecGnB
         9ULxeJF1rZBgZBScxKiiSfSSMfYJ8XXHc5s8mHZPKLDfvDYZa8CorLqdnRIWcMbfaojv
         Lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435902; x=1774040702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7VdLlI8p3c2ml716EZ2LGSjLC8UKoGj5GsyCV00O6Eo=;
        b=C+hxKPPtTdV/pYQm6jH7T55e2jMGGB+lEXiAworbKjWowgAKaYARlQ3wEnJlA6UilR
         M5oJIUvo7mLXHXUGXZkFRYVHVKY7NspgahsqWeP3T9/zG2740RuKrMxEB8yfJeB/2FqJ
         fTHtFGZx6ajd3uo99uZoArnkHGgJRMK/Bz02iYssbAhLT7XDmvFDlau1u8Gm9HTMKZ05
         h2TL9SWK7Tm9Qif4q3GsHzbI4cGbfToyLkADdMTwuYGZ92uRX1vpW5mmrMsCLIFnioQP
         nJ3EwfugNmn/5IKMHKw23BRmhvi7HGpwjA1E9RZa2zT6gLIRPYfbSaMemxOTzZlgnRIg
         waWQ==
X-Gm-Message-State: AOJu0Yz72ZvIXa8U1Mq9ctQ4eQf6YRvEEWwmaz7O4SoV+NhSuBIn7Le1
	QyX8v6LdywAFBV7c5h2IFSmppQHVclRWnQBAngIkgBnwlOdxZYs8N9mW
X-Gm-Gg: ATEYQzxzw25d1DJN3XbLaCIrG6cjpIBb8tceA1O+3tkS75+9mLp98M+NPkGu8Mql0Y0
	G8DeTpX3jmY3pnCI97DGndPlTvkLRrnbKQJgvIeEXz6L/x6YePrC+wOKEEF8o4uCNuuUhNXuy7B
	v3z2aGn8hsBlDGzfWJVtzawjuUANfAlyQvOgioBaMRv1w4UuLIpAl5iKo/On6MvrMlxKW+jyVSj
	d5Mh+jnDyAI3zvTM9dpCrazCyHTcok3v/Z5GylIJMazGzQWWAkG8MrcwqHaeSM1wlvai/XtX0e2
	9dAbLStBaDm8RjP7kVP3UaIugMPCqHSa0FoSWDMTEC3Msn6qvmcwXGwWK0kT/Mc4E2kgNzPZBqA
	wxpJtLC6VKc/OTsPFNmpUS0TxUFXY9RaGM4HMLvHGZdQA6ZdvKZE6C72hEO9xfp7M2YEhmsTEQn
	9c7FX5DVB2OTqVKSUk4Q==
X-Received: by 2002:a05:600c:468e:b0:485:3f58:d9d with SMTP id 5b1f17b1804b1-48556714b67mr75883295e9.32.1773435901279;
        Fri, 13 Mar 2026 14:05:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:54::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563903bbsm51024855e9.0.2026.03.13.14.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:05:00 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Mar 2026 14:04:25 -0700
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: Add tests for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-sleepable_tracepoints-v4-5-debc688a66b3@meta.com>
References: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
In-Reply-To: <20260313-sleepable_tracepoints-v4-0-debc688a66b3@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773435891; l=6510;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=fIDtUeIUB3xqM7bA+Am0k9zlmnK1oz9LSRMIrlVaU7c=;
 b=PCU+iWdpcUwCPbC1hh6tYDJDKbJDANDpiGuQ3ANWOn0PHb6Z/5eD4ZG0FBCXxWNydAYd6RW7R
 ZTRznwE34T+CODyo4zaSkOIUZMx6eqDMDGzN0RhinRoqagtlWZ+sP8I
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add functional tests for sleepable tracepoint programs that attach to
the nanosleep syscall and use bpf_copy_from_user() to read user memory:

  - tp_btf: BTF-based raw tracepoint using SEC("tp_btf.s/sys_enter")
    with PT_REGS_PARM1_SYSCALL (non-CO-RE macro for BTF programs).

  - classic: Classic raw tracepoint using SEC("raw_tp.s/sys_enter")
    with PT_REGS_PARM1_CORE_SYSCALL (CO-RE macro needed for classic).

  - tracepoint: Classic tracepoint using
    SEC("tp.s/syscalls/sys_enter_nanosleep") receiving
    struct syscall_trace_enter with direct access to args[].

Add a negative test (test_sleepable_raw_tp_fail) that verifies
sleepable programs are rejected on non-faultable tracepoints
(sched_switch).

Update verifier/sleepable.c tests:
  - Add "sleepable raw tracepoint accept" test for sys_enter.
  - Rename reject test and update error message to match the new
    descriptive "Sleepable program cannot attach to non-faultable
    tracepoint" message.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../bpf/prog_tests/sleepable_tracepoints.c         | 57 ++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 75 ++++++++++++++++++++++
 tools/testing/selftests/bpf/verifier/sleepable.c   | 17 ++++-
 3 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
new file mode 100644
index 000000000000..308d53c31632
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_sleepable_tracepoints.skel.h"
+
+static void run_test(struct bpf_program *prog,
+		     struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		return;
+
+	skel->bss->target_pid = getpid();
+	skel->bss->triggered = 0;
+	skel->bss->err = 0;
+	skel->bss->copied_tv_nsec = 0;
+
+	syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec = 555 }, NULL);
+
+	ASSERT_EQ(skel->bss->triggered, 1, "triggered");
+	ASSERT_EQ(skel->bss->err, 0, "err");
+	ASSERT_EQ(skel->bss->copied_tv_nsec, 555, "copied_tv_nsec");
+
+	bpf_link__destroy(link);
+}
+
+void test_sleepable_tracepoints(void)
+{
+	struct test_sleepable_tracepoints *skel;
+
+	skel = test_sleepable_tracepoints__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bpf_program__set_autoload(skel->progs.handle_sched_switch, false);
+
+	if (!ASSERT_OK(test_sleepable_tracepoints__load(skel), "skel_load"))
+		goto cleanup;
+
+	if (test__start_subtest("tp_btf"))
+		run_test(skel->progs.handle_sys_enter_tp_btf, skel);
+
+	if (test__start_subtest("classic"))
+		run_test(skel->progs.handle_sys_enter_raw_tp, skel);
+
+	if (test__start_subtest("tracepoint"))
+		run_test(skel->progs.handle_sys_enter_tp, skel);
+
+cleanup:
+	test_sleepable_tracepoints__destroy(skel);
+
+	RUN_TESTS(test_sleepable_tracepoints);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
new file mode 100644
index 000000000000..37e14f5e9f14
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <asm/unistd.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int target_pid;
+int triggered;
+long err;
+long copied_tv_nsec;
+
+static int copy_nanosleep_arg(struct __kernel_timespec *ts)
+{
+	long tv_nsec;
+
+	err = bpf_copy_from_user(&tv_nsec, sizeof(tv_nsec), &ts->tv_nsec);
+	if (err)
+		return err;
+
+	copied_tv_nsec = tv_nsec;
+	triggered = 1;
+	return 0;
+}
+
+SEC("tp_btf.s/sys_enter")
+int BPF_PROG(handle_sys_enter_tp_btf, struct pt_regs *regs, long id)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (id != __NR_nanosleep)
+		return 0;
+
+	return copy_nanosleep_arg((void *)PT_REGS_PARM1_SYSCALL(regs));
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp, struct pt_regs *regs, long id)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (id != __NR_nanosleep)
+		return 0;
+
+	return copy_nanosleep_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs));
+}
+
+SEC("tp.s/syscalls/sys_enter_nanosleep")
+int handle_sys_enter_tp(struct syscall_trace_enter *args)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	return copy_nanosleep_arg((void *)args->args[0]);
+}
+
+/* Sleepable program on a non-faultable tracepoint should fail to load */
+SEC("tp_btf.s/sched_switch")
+__failure __msg("Sleepable program cannot attach to non-faultable tracepoint")
+int BPF_PROG(handle_sched_switch, bool preempt,
+	     struct task_struct *prev, struct task_struct *next)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index 1f0d2bdc673f..6dabc5522945 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -76,7 +76,20 @@
 	.runs = -1,
 },
 {
-	"sleepable raw tracepoint reject",
+	"sleepable raw tracepoint accept",
+	.insns = {
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.prog_type = BPF_PROG_TYPE_TRACING,
+	.expected_attach_type = BPF_TRACE_RAW_TP,
+	.kfunc = "sys_enter",
+	.result = ACCEPT,
+	.flags = BPF_F_SLEEPABLE,
+	.runs = -1,
+},
+{
+	"sleepable raw tracepoint reject non-faultable",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -85,7 +98,7 @@
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
 	.result = REJECT,
-	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.errstr = "Sleepable program cannot attach to non-faultable tracepoint",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },

-- 
2.52.0

