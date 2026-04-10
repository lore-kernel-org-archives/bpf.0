Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7C218ADD
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840998; cv=none; b=XNyVwP0M5xEaedc8uDJQSTxFD2+bGEbEnU2BS8BOYI178m9VCDXpL/w3O/RZnuavy04vRWwu1qURraUT2GNahyz+qnytyKbFRC2aQn9ns1t/B8/P6+z6M9RO6w1hDP6l5SYNOIKUr2WqJZblUbx3JhOk2nslriPTD410g7fO9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840998; c=relaxed/simple;
	bh=+RYnig5Wy9kjqY2wehO7Q1t7P4HNkmKukbYUxTcslps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdhUHNKOJDPLg4auc2EZeNy0cApN8zsJLJpCtoo5gTUfwJ1HFMHtera5Vg4Fe4SxbqZUREWGZIG+FRn9UAxrB53Z6wWODHT6MSNjnurxcDZ6xHq0jGR6N3TM6xGB4zy4xJv8mZ6D9IZepXObW0RMI72ie5J3/Dwfp2Gd7wY+FIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djCPGrCZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djCPGrCZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso20676155e9.3
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775840996; x=1776445796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By8xowp3q8ypLx0zv/gTp5nku5KYQY8WYkws95TL8UY=;
        b=djCPGrCZubjSFGIu4RuubUB5qYq+5kwAjrS0ezY27C0AvTbT+1+khTHXg4AFPcZA7s
         eRESjROzKNt5srMMeS8W8Z9lIbXdOmpkuyi9rzWJNHKkEGJqX7Or4pLrMHJD7cByM/Of
         OBSlL1pHqBL7WlScG8jODbv411m9jQrwXcnPq/hGg6lrmM6mWjFZLjybEW5P29vhPixG
         Y/CUNPVzXTzkzffnra7UIkDdeBnLBc03QEASI0NnGgqN7X0gaif6hGWBRyLxCKqlm6Ad
         3O3DhqWsxj/w/ijfOIYrnsJvyI+2ojeUdhPtQgj7+FSK21xXavj/rRl7qttMvRe4OZrh
         +69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840996; x=1776445796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=By8xowp3q8ypLx0zv/gTp5nku5KYQY8WYkws95TL8UY=;
        b=GE2iW6ZS4310DpvY5yZcthc9OV/ALQg6MW1raTxoSu7N+eGgwKJDwyhX0wEvZ+Gxsq
         Pvp6LwwEvlqKXm76JpbA7gEhUbQ5Fr6lIKL2aEFHxoBlOPY3lx13rDPQOl1ESyAU97Rs
         9f3I4HrrfZrqHn302QqshwIQm84fojS2GyuBmlwTWHo6jc0cpwzDjVHUtEU2YVgCb9uo
         NU/tAAQNfRFjKrJdAiytLBdKBlw9qgXIRnqPfQITab00phI8JxC5HVXCNyPRULN+u4PU
         SDnMeYL3VabzS/qirzIWNxLyTp/rZ9WKEMwT04Y/Ldh/i9E7QIAnVCp5iqjYZnOsyowt
         iHJg==
X-Gm-Message-State: AOJu0YxBKMVvmbig2IykL55zec8r8wce7UqrQzS829HG5TmY/ZtZehzW
	K5xj9/ojLT4nTQrCM6U919nMYWGDiqKkMcDHdISUmtr4O/fr20sJEasS
X-Gm-Gg: AeBDievUI7iuSAqicCn7s/ef14775E7sSh+K5fPKVvCGEfKMeOPm8xw5bkqGQW2LP0t
	E/BNmu0rlmtrNPsHWLGUdthcWneUKXTdL1ZRXUFnvqGgej4mkizHWNCGzgOlwCYLPaviGnlceMo
	qweKyyizvv81ePEsZsICZPbpLv7hXay7wVKeEAoe61swwHdUe4+zQEFfDPMfdjbIAl8NjIOt13f
	AdLCoMOV+id+vZZHV9hqpyunBp5yixT2/ecI3q+heJnX8nADOmRcZl8CP5yQN/283dHpgmpMM8J
	GbczYMsZtsZv+5JDvKqQ1uL7X3gcb4DJXOjcKd6A1Si3OCz6yL4oaIFlwGItBOmxLWM1TO7mrRT
	0csuPVawj2C2+i9vwkaV4NPne27s8VILZPNs4f8TQ2Wc9wr+SPInPYKcDma8GIkkRpqPZP7nQ2r
	BS16ERMwGVDD2Eo7Xxq4NaQIUp
X-Received: by 2002:a05:600c:8589:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-488d6860376mr36862205e9.23.1775840995444;
        Fri, 10 Apr 2026 10:09:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5888a97sm101120815e9.2.2026.04.10.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:09:55 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 10 Apr 2026 10:09:34 -0700
Subject: [PATCH bpf-next v9 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sleepable_tracepoints-v9-6-e719e664e84c@meta.com>
References: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
In-Reply-To: <20260410-sleepable_tracepoints-v9-0-e719e664e84c@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775840983; l=11142;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=NlpWbeA6XSAC5k2YsWiLW+3n0ZQUpHppWP4NOPwwAdc=;
 b=64jjJ1MiiUI4nnbuCgIDAt0OE9CZlMuwJENU4q1203lQyaLO7tOH6Ynw+zGTr9eHmQnUgWNo5
 IZNP75EWIG5CTTFWOUeSkGDvPI8t91TA/rEu+8qLMsuxqDBZ8VplTuH
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Cover all three sleepable tracepoint types (tp_btf.s, raw_tp.s, tp.s)
and sys_exit (via bpf_task_pt_regs) with functional tests using
bpf_copy_from_user() on nanosleep. Verify alias and bare SEC variants,
bpf_prog_test_run_raw_tp() with BPF_F_TEST_RUN_ON_CPU rejection,
attach-time rejection on non-faultable tracepoints, and load-time
rejection for sleepable tp_btf on non-faultable tracepoints.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../bpf/prog_tests/sleepable_tracepoints.c         | 154 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 125 +++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 4 files changed, 312 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
new file mode 100644
index 000000000000..cd2b0e916fab
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_sleepable_tracepoints.skel.h"
+#include "test_sleepable_tracepoints_fail.skel.h"
+
+static void run_test(struct test_sleepable_tracepoints *skel)
+{
+	skel->bss->target_pid = getpid();
+	skel->bss->prog_triggered = 0;
+	skel->bss->err = 0;
+	skel->bss->copied_tv_nsec = 0;
+
+	syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec = 555 }, NULL);
+
+	ASSERT_EQ(skel->bss->prog_triggered, 1, "prog_triggered");
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
+	int err, i;
+
+	skel = test_sleepable_tracepoints__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	/* Primary functional tests: full bpf_copy_from_user exercise */
+	{
+		struct {
+			const char *name;
+			struct bpf_program *prog;
+		} func_tests[] = {
+			{ "tp_btf", skel->progs.handle_sys_enter_tp_btf },
+			{ "raw_tp", skel->progs.handle_sys_enter_raw_tp },
+			{ "tracepoint", skel->progs.handle_sys_enter_tp },
+			{ "sys_exit", skel->progs.handle_sys_exit_tp },
+		};
+
+		for (i = 0; i < ARRAY_SIZE(func_tests); i++) {
+			if (test__start_subtest(func_tests[i].name))
+				run_auto_attach_test(func_tests[i].prog, skel);
+		}
+	}
+
+	/* Attach-only tests: verify libbpf prefix parsing for aliases */
+	{
+		struct {
+			const char *name;
+			struct bpf_program *prog;
+		} attach_tests[] = {
+			{ "tracepoint_alias", skel->progs.handle_sys_enter_tp_alias },
+			{ "raw_tracepoint_alias", skel->progs.handle_sys_enter_raw_tp_alias },
+		};
+
+		for (i = 0; i < ARRAY_SIZE(attach_tests); i++) {
+			if (!test__start_subtest(attach_tests[i].name))
+				continue;
+			link = bpf_program__attach(attach_tests[i].prog);
+			if (ASSERT_OK_PTR(link, "attach"))
+				bpf_link__destroy(link);
+		}
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
+	/* BPF_PROG_TEST_RUN: exercise bpf_prog_test_run_raw_tp() */
+	{
+		struct {
+			const char *name;
+			__u32 flags;
+			bool expect_err;
+		} run_tests[] = {
+			{ "test_run", 0, false },
+			{ "test_run_on_cpu_reject", BPF_F_TEST_RUN_ON_CPU, true },
+		};
+
+		for (i = 0; i < ARRAY_SIZE(run_tests); i++) {
+			__u64 args[2] = {0x1234ULL, 0x5678ULL};
+			LIBBPF_OPTS(bpf_test_run_opts, topts,
+				.ctx_in = args,
+				.ctx_size_in = sizeof(args),
+				.flags = run_tests[i].flags,
+			);
+			int fd;
+
+			if (!test__start_subtest(run_tests[i].name))
+				continue;
+
+			fd = bpf_program__fd(skel->progs.handle_test_run);
+			err = bpf_prog_test_run_opts(fd, &topts);
+			if (!run_tests[i].expect_err) {
+				ASSERT_OK(err, "test_run");
+				ASSERT_EQ(topts.retval, args[0] + args[1], "test_run_retval");
+			} else {
+				ASSERT_ERR(err, "test_run_err");
+			}
+		}
+	}
+
+	/* Negative: attach-time rejection on non-faultable tracepoints */
+	{
+		struct {
+			const char *name;
+			struct bpf_program *prog;
+		} neg_tests[] = {
+			{ "raw_tp_non_faultable", skel->progs.handle_raw_tp_non_faultable },
+			{ "tp_non_syscall", skel->progs.handle_tp_non_syscall },
+		};
+
+		for (i = 0; i < ARRAY_SIZE(neg_tests); i++) {
+			if (!test__start_subtest(neg_tests[i].name))
+				continue;
+			link = bpf_program__attach(neg_tests[i].prog);
+			ASSERT_ERR_PTR(link, "attach_should_fail");
+		}
+	}
+
+	test_sleepable_tracepoints__destroy(skel);
+
+	/* Negative: load-time rejection (separate BPF object) */
+	RUN_TESTS(test_sleepable_tracepoints_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
new file mode 100644
index 000000000000..907c04510a72
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
@@ -0,0 +1,125 @@
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
+int prog_triggered;
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
+	prog_triggered = 1;
+	return 0;
+}
+
+/* Primary functional tests: full bpf_copy_from_user exercise */
+
+SEC("tp_btf.s/sys_enter")
+int BPF_PROG(handle_sys_enter_tp_btf, struct pt_regs *regs, long id)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid ||
+	    id != __NR_nanosleep)
+		return 0;
+
+	return copy_nanosleep_arg((void *)PT_REGS_PARM1_SYSCALL(regs));
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp, struct pt_regs *regs, long id)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid ||
+	    id != __NR_nanosleep)
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
+	struct pt_regs *regs;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	regs = (struct pt_regs *)bpf_task_pt_regs(bpf_get_current_task_btf());
+	return copy_nanosleep_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs));
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

