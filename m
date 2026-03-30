Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A23E276A
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909247; cv=none; b=qOEJ8ixOyDJWUQHxIRV4WxO/xOB2FMMfTvPsX0DgqD62+ze/7uNTonpy2q1EtFeLjDIeXrjW0Z/+eaMWo3DBxlBTqRppNkZNdNXTuJO57ncDULDoaYI1h2ADwyKlUp7UQdkKQtBGvbnFvdbUoqKVvrmLdULVDMBhW3UAN6+ZFwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909247; c=relaxed/simple;
	bh=IE1BAsNnBdTF0+Q3ZUORDHJ+mEsNyawrHadfxChxoJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWCWMdMPjmSRQpprr0TAdGb3CoFk53UwkYiiAerxlAcf2embyYNUjZjclXUDnLMBFOqgKk6yj3hwauq+Ztqp/hoBAy5RSrXxYgWJdJVzZzArMqHGO/xWwRrtsOnJgG2b+pH7Niuibabiffaz69/IhfQY05eRscrDdrLpft5b0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a44RqvV3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a44RqvV3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so48001965e9.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909236; x=1775514036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVbIR4eg2yjL4gl+SAEuHsNnr/yuVR4f7DvjBgpcXLQ=;
        b=a44RqvV3Fag5Uob6RB7nsiXpf3nuOpG1vWzs2yImN01UWa4bC6N1Aq76cNpGYq58ZM
         xIKGlP8G4LwzGwOLXvgrY8D5O4FNB6FYUYr6LgLPo5spDB8KgX4yea+WhF5/4kCjVF6b
         xohE8H2qDeuoyURd7usbERm/V2+9R0L73UZJEJOwk8McfiGMJHieSl16zoFBRunK+00D
         6WWSQ5MxwwKP4Vo9azjkYikHnSgFdDNkaKRBmaNiNOUsobypeAXefvWeTobIfJxuyRCl
         2OOWGLj0pPCv6saRCU/ObdJB2cuqM+o8F7b791VXhSDQFexMKfNWcCkKvn7Mb/Yojsj3
         0+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909236; x=1775514036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AVbIR4eg2yjL4gl+SAEuHsNnr/yuVR4f7DvjBgpcXLQ=;
        b=gTqfrNtgEred6PdymcFsGbbuR4LFf+LUN3llzhyuUgbq5jXlhRDo6RIuxsUFulQJbm
         tCUU37/H/nUaXsUgLMmwui2AJoee6MvTxJTbisUCQDgIuMScjC3s55B7M86bc9XqnHtq
         UYAgNHn72+LZHQn9iWVrecq9sIiCTRyakmInYsbp2zJ1mxUzeHyBZWhhMyMMq0FZdzAs
         6uIPgfmtrUhaDhi3ZP3YpzXHLEe2qtTDT2E/Dy/XRaVzKalMrtl3VsLlNwIJU7RSTNrY
         czcuEUCiNI+DuE/y+r4wvWNZlGQN6ihmI4pVLsDgBRdEUx/YkfPtPBBrLao0b1TiB2ln
         TtVg==
X-Gm-Message-State: AOJu0YyzCN8Srct+ws/EEwVpOIJVSos9P+bM+jec9JbBgCVXHbanxKvJ
	xPiyRtcR+j51ex4xENZg8ZZqXGvNE0ZjQ0K3mQjxzvXayeTC9JZvTyp+
X-Gm-Gg: ATEYQzx6LvrvE47U8mUK+X35X3221cXnYXGgYybbtRIfFti+r+y7WrWuDts+XpeUYQk
	EKZwGyQkiuFkdZ/AX3Quz+7N2lAKZPFLa6Vi9hEK1x8viTLLPRn0hsll5uioyvfhMadSQKI3kFF
	CAnHG5O3oJnB7VZYYRRsH6zMl/C+PUED5zenbxp6sjT7GttiLU6OZ11dZo+NH0WlPYDMiUUdTeq
	gmnor7u7KCHUQxDnBMTSN3dW3/b7WOLgeNAQ9u9X30Pfammg62L1OgyEWjkbPj7BHd/or+CBoxe
	QbHQmmKCOHim3S8gqv7ToQwHo8fd6uQbEufnfxI2Id4nvW8quFGnx+6egIOdvmU7HJioNNzsAhO
	ORvV1haTcqykv0o6eRmelvzzR1MO+JluBcOOFoIYhJCDb7eOXl1xlMiQv3z6t95fx9Pu8d2YJqr
	6UuMXWIzb+fJbnaw==
X-Received: by 2002:a05:600c:8489:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-4872807483cmr241046365e9.25.1774909235598;
        Mon, 30 Mar 2026 15:20:35 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887aacb88fsm2783925e9.2.2026.03.30.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:20:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 30 Mar 2026 15:17:29 -0700
Subject: [PATCH bpf-next v8 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-sleepable_tracepoints-v8-6-2e323467f3a0@meta.com>
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
In-Reply-To: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909220; l=11695;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=8i8x8zHxNRadRJgtShYdPq3yc8uH8J5HAVSzXZSRsVc=;
 b=9aSEKaTEljfUzDNIT/Dl19hYtBKkgCdXli+SNSdOtCK5j954GeTfwrh0ele4pYZVtOEE7hubF
 pDhi3ohQ07jAqoaoYuJT5Je9yCOXfJwZLWoVUCqGAM2tKgzd16Tw95M
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add functional tests for sleepable tracepoint programs that attach to
the nanosleep syscall and use bpf_copy_from_user() to read user memory:
 * BTF-based raw tracepoint using SEC("tp_btf.s/sys_enter")
 * Classic raw tracepoint using SEC("raw_tp.s/sys_enter")
 * Classic tracepoint using
   SEC("tp.s/syscalls/sys_enter_nanosleep") receiving
   struct syscall_trace_enter with direct access to args[].
 * Sleepable raw_tp executed via bpf_prog_test_run_raw_tp()

Add a negative test (handle_sched_switch) that verifies sleepable
programs are rejected on non-faultable tracepoints (sched_switch).

Update verifier/sleepable.c tests:
  - Add "sleepable raw tracepoint accept" test for sys_enter.
  - Rename reject test and update error message to match the new
    descriptive "Sleepable program cannot attach to non-faultable
    tracepoint" message.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../bpf/prog_tests/sleepable_tracepoints.c         | 153 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 128 +++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 4 files changed, 314 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
new file mode 100644
index 000000000000..66d5146b88fa
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_sleepable_tracepoints.skel.h"
+#include "test_sleepable_tracepoints_fail.skel.h"
+
+static void trigger_nanosleep(void)
+{
+	syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec = 555 }, NULL);
+}
+
+static void run_test(struct test_sleepable_tracepoints *skel)
+{
+	skel->bss->target_pid = getpid();
+	skel->bss->triggered = 0;
+	skel->bss->err = 0;
+	skel->bss->copied_tv_nsec = 0;
+
+	trigger_nanosleep();
+
+	ASSERT_EQ(skel->bss->triggered, 1, "triggered");
+	ASSERT_EQ(skel->bss->err, 0, "err");
+	ASSERT_EQ(skel->bss->copied_tv_nsec, 555, "copied_tv_nsec");
+}
+
+static void run_auto_attach_test(struct bpf_program *prog, struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "prog_attach"))
+		return;
+
+	run_test(skel);
+	bpf_link__destroy(link);
+}
+
+void test_sleepable_tracepoints(void)
+{
+	struct test_sleepable_tracepoints *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = test_sleepable_tracepoints__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	/* Primary functional tests: full bpf_copy_from_user exercise */
+
+	if (test__start_subtest("tp_btf"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_tp_btf, skel);
+
+	if (test__start_subtest("raw_tp"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_raw_tp, skel);
+
+	if (test__start_subtest("tracepoint"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_tp, skel);
+
+	/* Alias SEC variants: verify libbpf prefix parsing */
+
+	if (test__start_subtest("tracepoint_alias")) {
+		link = bpf_program__attach(skel->progs.handle_sys_enter_tp_alias);
+		if (ASSERT_OK_PTR(link, "tp_alias_attach"))
+			bpf_link__destroy(link);
+	}
+
+	if (test__start_subtest("raw_tracepoint_alias")) {
+		link = bpf_program__attach(skel->progs.handle_sys_enter_raw_tp_alias);
+		if (ASSERT_OK_PTR(link, "raw_tp_alias_attach"))
+			bpf_link__destroy(link);
+	}
+
+	/* Bare SEC variants: verify manual attach */
+
+	if (test__start_subtest("raw_tp_bare")) {
+		link = bpf_program__attach_raw_tracepoint(skel->progs.handle_raw_tp_bare,
+							  "sys_enter");
+		if (ASSERT_OK_PTR(link, "raw_tp_bare_attach"))
+			bpf_link__destroy(link);
+	}
+
+	if (test__start_subtest("tp_bare")) {
+		link = bpf_program__attach_tracepoint(skel->progs.handle_tp_bare, "syscalls",
+						      "sys_enter_nanosleep");
+		if (ASSERT_OK_PTR(link, "tp_bare_attach"))
+			bpf_link__destroy(link);
+	}
+
+	/* Sys exit test */
+
+	if (test__start_subtest("sys_exit")) {
+		link = bpf_program__attach(skel->progs.handle_sys_exit_tp);
+		if (ASSERT_OK_PTR(link, "sys_exit_attach")) {
+			skel->bss->target_pid = getpid();
+			skel->bss->exit_triggered = 0;
+
+			trigger_nanosleep();
+
+			ASSERT_EQ(skel->bss->exit_triggered, 1, "exit_triggered");
+			bpf_link__destroy(link);
+		}
+	}
+
+	/* BPF_PROG_TEST_RUN: exercise bpf_prog_test_run_raw_tp() */
+
+	if (test__start_subtest("test_run")) {
+		__u64 args[2] = {0x1234ULL, 0x5678ULL};
+		int prog_fd;
+		LIBBPF_OPTS(bpf_test_run_opts, topts,
+			.ctx_in = args,
+			.ctx_size_in = sizeof(args),
+		);
+
+		prog_fd = bpf_program__fd(skel->progs.handle_test_run);
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_OK(err, "test_run");
+		ASSERT_EQ(topts.retval, 0x1234 + 0x5678, "test_run_retval");
+	}
+
+	if (test__start_subtest("test_run_on_cpu_reject")) {
+		__u64 args[2] = {0x1234ULL, 0x5678ULL};
+		int prog_fd;
+		LIBBPF_OPTS(bpf_test_run_opts, topts,
+			.ctx_in = args,
+			.ctx_size_in = sizeof(args),
+			.flags = BPF_F_TEST_RUN_ON_CPU,
+		);
+
+		prog_fd = bpf_program__fd(skel->progs.handle_test_run);
+		err = bpf_prog_test_run_opts(prog_fd, &topts);
+		ASSERT_ERR(err, "test_run_on_cpu_should_fail");
+		ASSERT_EQ(errno, EINVAL, "test_run_on_cpu_errno");
+	}
+
+	/* Negative: attach-time rejection on non-faultable tracepoints */
+
+	if (test__start_subtest("raw_tp_non_faultable")) {
+		link = bpf_program__attach(skel->progs.handle_raw_tp_non_faultable);
+		ASSERT_ERR_PTR(link, "raw_tp_non_faultable_attach");
+	}
+
+	if (test__start_subtest("tp_non_syscall")) {
+		link = bpf_program__attach(skel->progs.handle_tp_non_syscall);
+		ASSERT_ERR_PTR(link, "tp_non_syscall_attach");
+	}
+
+	test_sleepable_tracepoints__destroy(skel);
+
+	/* Negative: load-time rejection (separate BPF object) */
+	RUN_TESTS(test_sleepable_tracepoints_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
new file mode 100644
index 000000000000..597f8e1935ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <asm/unistd.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+int target_pid;
+int triggered;
+int exit_triggered;
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
+static __always_inline bool is_target_nanosleep(long id)
+{
+	return (bpf_get_current_pid_tgid() >> 32) == target_pid &&
+	       id == __NR_nanosleep;
+}
+
+/* Primary functional tests: full bpf_copy_from_user exercise */
+
+SEC("tp_btf.s/sys_enter")
+int BPF_PROG(handle_sys_enter_tp_btf, struct pt_regs *regs, long id)
+{
+	if (!is_target_nanosleep(id))
+		return 0;
+
+	return copy_nanosleep_arg((void *)PT_REGS_PARM1_SYSCALL(regs));
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp, struct pt_regs *regs, long id)
+{
+	if (!is_target_nanosleep(id))
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
+SEC("tp.s/syscalls/sys_exit_nanosleep")
+int handle_sys_exit_tp(struct syscall_trace_exit *args)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	exit_triggered = 1;
+	return 0;
+}
+
+/* Bare SEC variants: test manual attach without tracepoint in section name */
+
+SEC("raw_tp.s")
+int BPF_PROG(handle_raw_tp_bare, struct pt_regs *regs, long id)
+{
+	return 0;
+}
+
+SEC("tp.s")
+int handle_tp_bare(void *ctx)
+{
+	return 0;
+}
+
+/* Alias SEC variants: test libbpf prefix parsing for long-form names */
+
+SEC("tracepoint.s/syscalls/sys_enter_nanosleep")
+int handle_sys_enter_tp_alias(struct syscall_trace_enter *args)
+{
+	return 0;
+}
+
+SEC("raw_tracepoint.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp_alias, struct pt_regs *regs, long id)
+{
+	return 0;
+}
+
+/* BPF_PROG_TEST_RUN: sleepable raw_tp invoked via bpf_prog_test_run_raw_tp */
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_test_run, struct pt_regs *regs, long id)
+{
+	if ((__u64)regs == 0x1234ULL && (__u64)id == 0x5678ULL)
+		return (__u64)regs + (__u64)id;
+
+	return 0;
+}
+
+/* Negative: sleepable on non-faultable tracepoint (attach-time rejection) */
+
+SEC("raw_tp.s/sched_switch")
+int BPF_PROG(handle_raw_tp_non_faultable, bool preempt,
+	     struct task_struct *prev, struct task_struct *next)
+{
+	return 0;
+}
+
+SEC("tp.s/sched/sched_switch")
+int handle_tp_non_syscall(void *ctx)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
new file mode 100644
index 000000000000..1a0748a9520b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
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

