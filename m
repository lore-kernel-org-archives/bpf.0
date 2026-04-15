Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D733D6666
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264599; cv=none; b=SoACCEQJ/dvggkNC2Ig+J+5Qhe0cvIUKlxSknNVTbZ2cBQjBHJOLgwfafbsgvDIlwXgxGD2L6Tx8MA795aLiU8q1sX5s7VqB+gkDH5ysfu9VAd4bfCuW0AyfZEclFCJOXNEQOijkcLB6j2mkUfIupUbz9G4gzebUCvg8NJ8ShNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264599; c=relaxed/simple;
	bh=u4gpi+PbUdL7og6Otc5VT5uHs3cLlf8UG/3XeAgIrc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byjjdnkz5Qky3OMiuMWig3U4wY8pxPwN4W5KKTQgNLHPM/ra40j+n+wKjlYJcy6Cn4SC9PETpclPE8DqZ4kubjR9s7lFb5AQ7mKWgnclGJWfC94xYpWGPjKK8QjZz4QgzIHG22ZStRoosoGxjEehjnDUWuQWp0hh2YbRFWI3WHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIcMvkFG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIcMvkFG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso81559635e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776264596; x=1776869396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXsGK5Nd9UJ+Rmu9yMSr6/bXsKqym6biRnPixu/b3ME=;
        b=EIcMvkFGGtz/kXXzWjHjqfEA6ZSb9gRpw1phKOllqVo5iuczXEBWL9XZdG8RmH+ctl
         QXZRy7aGeg314oTG5IL0e4zho1NfG3AIOWdP8ju0NhO6KINVeHVNcbhVueH0n7/dkJHg
         w7iEO/+7MX46Q8OZHGX/615b94ujkdkS/gx41Ww/vFDH70X70oJCKxMyT1t1MlmlU7oc
         GWTFKfl+grt6YDbjrcpE563agXEzQ2+PZZ5IfVLeqYf2uw5CptfLtDZ5Ovrvo+JVP03O
         L7HeXNFAiNdbYu7W9zGgM6AbMwW/I4DyD/Nduo8cu271BfEBb8TfeY/HMeksiHFXbiyY
         bdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776264596; x=1776869396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXsGK5Nd9UJ+Rmu9yMSr6/bXsKqym6biRnPixu/b3ME=;
        b=SypAszJiTNe9/G123RnuXPdYOLYCFclUXqSyAaRjDFfnOw4PvNy5JM1rZ0nhcH5yzm
         8jNeUOn0WMuprExvoJHWDVwha/+jsq9+4VOtxxp5/HKSvfFjdes623RLE9bOErPUBkuS
         R0F6l4bADuYccYU/3N3hMED+GeYwNX1JiclHm5OEqCs7d9pUP35rvBeSzSgHjPI511lf
         WbEu/TFrd2NoEaiFZq753IddK99MlDSbRgrkpluAE/jW+slXrPCEZI/gOkaFOETQs7Dd
         RQdeUV/njgssZp1K6Nw8QLK49VevCy4AvlyopK28gzV2kvUlFT803b29MtNAVJAZ0IAq
         5iyA==
X-Gm-Message-State: AOJu0YwjvLd1thobFMhjLVDLSDWyDCA1kaQl00rlhYgS7Pii7iBtuQUW
	vP0+XgYUo2sTDKu3sRVN6r2ncZetDu953sGGflYpFVxB6WiNTNKTGw+1
X-Gm-Gg: AeBDietrr6t1iOVMfdvJNZ0WWVGLx9Y1xlCGNzZVuiAVEY58qFSY4P0R/KCtFHpNG+z
	YJf1k+I7tnLuK4/P9UtXRJFxno6dXDvW+0fnn8xdu9vZ4Q7BsKAA2gcAmknxL8bXeT1hehDJKTu
	qSIY+8GuZtKQUE4ksnX7Rdadk3D/B0+byy6SND24zs8LDXG36Y4ECnilZXAxWgZuXoz0C+q87z3
	L6FoTf4Glp03KY2tyfEDE2rnTyB4IBX5ZUsjplTxmPmS/6k6xdYcpJc6mpyeM9meXV0FSVl0eD5
	FrDTMRR1Mg7JlfeTwdKvYqn708YgAOx13xsYPHoWNSkE5WWvmfCPZOBfh6HnyjrPaE3LPlrjh+w
	P4/tdFsaRzEBBfKjZPWIg6wOD2YvzAMDQrW7vptvdSZud4FGKRhNxpHJses1Z7xrVGTKiWvljnL
	yoI1VcPjwj+nTcwsTrv1NoIoDr
X-Received: by 2002:a05:600c:609a:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-488d68a10d7mr307668055e9.31.1776264595871;
        Wed, 15 Apr 2026 07:49:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4a::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead356616sm5828273f8f.13.2026.04.15.07.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:49:55 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 15 Apr 2026 07:49:08 -0700
Subject: [PATCH bpf-next v10 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-sleepable_tracepoints-v10-6-161f40b33dd7@meta.com>
References: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
In-Reply-To: <20260415-sleepable_tracepoints-v10-0-161f40b33dd7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776264581; l=10556;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=YxkMQtAHw/osa5xySqYc6wIZGixtcDYVQ/n2xx7mwGs=;
 b=0r7L8XG4Cm7U5sXThRhwEQM4Tcrws8jNKtzgzpg8x/o1Px75R5fDY57zJ0e2ilLM2W/WJJDh9
 uQAQDeTTSC6DomNTJ+/xoBzhUKQzwMKN+GcwGKbUAObAfuceIrilTYr
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
 .../bpf/prog_tests/sleepable_tracepoints.c         | 139 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 115 +++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 4 files changed, 287 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
new file mode 100644
index 000000000000..bdc7fe294e7c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
@@ -0,0 +1,139 @@
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
+static void run_auto_attach_test(struct bpf_program *prog,
+				 struct test_sleepable_tracepoints *skel)
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
+static void test_attach_only(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_attach_reject(struct bpf_program *prog)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach(prog);
+	ASSERT_ERR_PTR(link, "attach_should_fail");
+}
+
+static void test_raw_tp_bare(struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach_raw_tracepoint(skel->progs.handle_raw_tp_bare,
+						  "sys_enter");
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_tp_bare(struct test_sleepable_tracepoints *skel)
+{
+	struct bpf_link *link;
+
+	link = bpf_program__attach_tracepoint(skel->progs.handle_tp_bare,
+					      "syscalls", "sys_enter_nanosleep");
+	if (ASSERT_OK_PTR(link, "attach"))
+		bpf_link__destroy(link);
+}
+
+static void test_test_run(struct test_sleepable_tracepoints *skel)
+{
+	__u64 args[2] = {0x1234ULL, 0x5678ULL};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+	);
+	int fd, err;
+
+	fd = bpf_program__fd(skel->progs.handle_test_run);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, args[0] + args[1], "test_run_retval");
+}
+
+static void test_test_run_on_cpu_reject(struct test_sleepable_tracepoints *skel)
+{
+	__u64 args[2] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.ctx_in = args,
+		.ctx_size_in = sizeof(args),
+		.flags = BPF_F_TEST_RUN_ON_CPU,
+	);
+	int fd, err;
+
+	fd = bpf_program__fd(skel->progs.handle_test_run);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	ASSERT_ERR(err, "test_run_on_cpu_reject");
+}
+
+void test_sleepable_tracepoints(void)
+{
+	struct test_sleepable_tracepoints *skel;
+
+	skel = test_sleepable_tracepoints__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	if (test__start_subtest("tp_btf"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_tp_btf, skel);
+	if (test__start_subtest("raw_tp"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_raw_tp, skel);
+	if (test__start_subtest("tracepoint"))
+		run_auto_attach_test(skel->progs.handle_sys_enter_tp, skel);
+	if (test__start_subtest("sys_exit"))
+		run_auto_attach_test(skel->progs.handle_sys_exit_tp, skel);
+	if (test__start_subtest("tracepoint_alias"))
+		test_attach_only(skel->progs.handle_sys_enter_tp_alias);
+	if (test__start_subtest("raw_tracepoint_alias"))
+		test_attach_only(skel->progs.handle_sys_enter_raw_tp_alias);
+	if (test__start_subtest("raw_tp_bare"))
+		test_raw_tp_bare(skel);
+	if (test__start_subtest("tp_bare"))
+		test_tp_bare(skel);
+	if (test__start_subtest("test_run"))
+		test_test_run(skel);
+	if (test__start_subtest("test_run_on_cpu_reject"))
+		test_test_run_on_cpu_reject(skel);
+	if (test__start_subtest("raw_tp_non_faultable"))
+		test_attach_reject(skel->progs.handle_raw_tp_non_faultable);
+	if (test__start_subtest("tp_non_syscall"))
+		test_attach_reject(skel->progs.handle_tp_non_syscall);
+	if (test__start_subtest("tp_btf_non_faultable_reject"))
+		RUN_TESTS(test_sleepable_tracepoints_fail);
+
+	test_sleepable_tracepoints__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
new file mode 100644
index 000000000000..088e204efc0f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
@@ -0,0 +1,115 @@
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
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_test_run, struct pt_regs *regs, long id)
+{
+	if ((__u64)regs == 0x1234ULL && (__u64)id == 0x5678ULL)
+		return (__u64)regs + (__u64)id;
+
+	return 0;
+}
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
index c2b7f5ebf168..6dabc5522945 100644
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
-	.errstr = "Only fentry/fexit/fsession/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.errstr = "Sleepable program cannot attach to non-faultable tracepoint",
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },

-- 
2.52.0

