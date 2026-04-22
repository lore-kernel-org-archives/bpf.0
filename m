Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C8371860
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886960; cv=none; b=LQHfewLsKnq1xKKQeq8b9a4Onoaxpe9wO2qpNiQPtOXqig7ezZEXIjCdpCTT1LOBH8ZpbFJKs702xHDn0ooGjkLAmfAjZbtjNDUugeGw/Pya98+bMy5OQwjO8ODB7muKK6NxpheSeYXIbW1dGkjbMS5IsDvlbuorjKnGfU1cdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886960; c=relaxed/simple;
	bh=oXZmfMc3yfjXh3Hj0sjrz4LWjygLhV8RDpQ8WXQiOPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSdJ5WiQY/Dyi0s+FDPp3psyxJ9pi64B5+TJYPeKD7hRNS+yZ1JrtPUQdNNxxu2MrYLJwxyFoQxYdxA/rLd4sdRgwj0tttUwfhCCtmn72HKwpuqFVByFlkrj+E/Hg65kA/pI/ZFZ7YmuiSriAPzsoRN1QTt3BHInkIEdfH3eO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBTuyrme; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBTuyrme"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so6029579f8f.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776886957; x=1777491757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNeOKK9xkcdi+aWADt90Jrspt3OmLLc1K1IhNWquSoA=;
        b=aBTuyrmeFMopJuwntcLuuochaHk4XhUQiEFMe/u/rnK4ROyDXjCszaVl0/zmPnCcb4
         1+BZwyscKBtw7NkRsR2HWxV6kGbu6XGoEOXyE48rYoyHfWbqY1DNc95euRsxQ49sXqhe
         p4VBTVaui+6BVI7dfJcaAC78/8sRjcvSxZaIi600f8KBZdrwyKBF2uH/9t3wuJ81C+kA
         xkXr4SY9t1zSp/R0In8Bx2o/GpZp4fhn2IWf8hjCUltMtXQREJ5ReIgj8INP9ueCSmCX
         yqvURcXUqRXeCGvgMmi2O64AcfWjUWYpfeeq8+UuNzjQrguGLnofRWL2X6ivtzhkeTBn
         5bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886957; x=1777491757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FNeOKK9xkcdi+aWADt90Jrspt3OmLLc1K1IhNWquSoA=;
        b=QE730UQCMRcLEPKvWhsKwCYrOkZUisvST6ns6JJ5mfzp1TVpslRciFFexZ+0qb/yph
         plohHz+VJNqJAu1gjt8dNWxkhMlkROLK2uP4jo1MAGUsMrQnRDtaxwwN5SHWHGh2I8+z
         viaZFzRsPmf6BgLbM4kmM5PaNbBR63gK++62CuI4Du3QzN4yDBfrGEzqQVcvuzXfV9DP
         ECxd21+Pnnl2lpIwBmdOnJaKUKhw9Yst5REZ8m6ouzpcmKviSALyXxoLNfFL4EiG2Lqk
         DkUmoDZUHIogksTk1Uc4HnbN28UsSK3S6+FO4Rt9gv7gcBwkkMLgxBHJeKEzBove1lBB
         lmXQ==
X-Gm-Message-State: AOJu0YziEQ7lqr6znUrPgo0OkUjvwLU7ePEaFYaiCittCa1ykQKeCDfC
	JRF9YoC8wGLhCxw1OopY967wylUGKQDMOdI3o3By8NwZSoV2E+m/s5tm
X-Gm-Gg: AeBDietTBP1vEqqCMRtNDa54UGtCee775DistgyU5caj3AgStnSMVMLgA0uKJqCrAxc
	DAlZ5YejqF6JBBNFfWCl6K05kCvBaXGYNd+JPnHAhTXucHZc89HWKiYrR6/jjVne/C4kSpO+85A
	Mr58RnVtzFpQrrNRmKOsxwK40KT9YcpBNrW3sac6JrJFuR9tf+6K95xEyX3lV7oienynWkdF1yb
	SMsFLjjRaVv0n4SgFmDAeNsnRJ8PODIBSnhizUKpZjDuTU2AyUo6BfNPLFYgETukmW2ipntquRn
	+8rmbacMfpu3uUUtPdrduFGWtYaghhMk2zSl71sycsycV3KDyQu587OkzRaALfbEE12NPR2kDWA
	gZV/KuFAyIfd9aZZ0LA5KLRKA6tH8d67ukHSyrt30kjmpsuKbd9wOz3AWSY+Qf7cqErd0nYz/WQ
	YEunoGm6UXu8pPv1qI23jPbuz8dbTQeQXeGg==
X-Received: by 2002:a05:6000:144c:b0:43d:6a0c:9571 with SMTP id ffacd0b85a97d-43fe3dd339emr37806868f8f.11.1776886956429;
        Wed, 22 Apr 2026 12:42:36 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb11b4sm48577408f8f.2.2026.04.22.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:42:35 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 22 Apr 2026 12:41:11 -0700
Subject: [PATCH bpf-next v13 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-sleepable_tracepoints-v13-6-99005dff21ef@meta.com>
References: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776886944; l=10479;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=9vPl6w2oiMFxwhCRyA2B7HFOVkmT4J9QUMZkry9XAjA=;
 b=yqMJdSm8NALuxKusesrXBa55RZeLZqKKthpoOTwtXk7aySBdLK2lJyx8pnFyx9tkAduDQmRDO
 m9b726hkWRZB1QLtOZximX6jAiQt7QpL+KYcc8vsScWQIsNHaucgIUg
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Cover all three sleepable tracepoint types (tp_btf.s, raw_tp.s, tp.s)
and sys_exit (via bpf_task_pt_regs) with functional tests using
bpf_copy_from_user() on getcwd. Verify alias and bare SEC variants,
bpf_prog_test_run_raw_tp() with BPF_F_TEST_RUN_ON_CPU rejection,
attach-time rejection on non-faultable tracepoints, and load-time
rejection for sleepable tp_btf on non-faultable tracepoints.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../bpf/prog_tests/sleepable_tracepoints.c         | 142 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 112 ++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 4 files changed, 287 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
new file mode 100644
index 000000000000..19500b785ee3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <unistd.h>
+#include "test_sleepable_tracepoints.skel.h"
+#include "test_sleepable_tracepoints_fail.skel.h"
+
+static void run_test(struct test_sleepable_tracepoints *skel)
+{
+	char buf[PATH_MAX] = "/";
+
+	skel->bss->target_pid = getpid();
+	skel->bss->prog_triggered = 0;
+	skel->bss->err = 0;
+	skel->bss->copied_byte = 0;
+
+	syscall(__NR_getcwd, buf, sizeof(buf));
+
+	ASSERT_EQ(skel->bss->prog_triggered, 1, "prog_triggered");
+	ASSERT_EQ(skel->bss->err, 0, "err");
+	ASSERT_EQ(skel->bss->copied_byte, '/', "copied_byte");
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
+	if (!ASSERT_ERR_PTR(link, "attach_should_fail"))
+		bpf_link__destroy(link);
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
+					      "syscalls", "sys_enter_getcwd");
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
index 000000000000..254f7fd895d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
@@ -0,0 +1,112 @@
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
+char copied_byte;
+
+static int copy_getcwd_arg(char *ubuf)
+{
+	err = bpf_copy_from_user(&copied_byte, sizeof(copied_byte), ubuf);
+	if (err)
+		return err;
+
+	prog_triggered = 1;
+	return 0;
+}
+
+SEC("tp_btf.s/sys_enter")
+int BPF_PROG(handle_sys_enter_tp_btf, struct pt_regs *regs, long id)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid ||
+	    id != __NR_getcwd)
+		return 0;
+
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_SYSCALL(regs));
+}
+
+SEC("raw_tp.s/sys_enter")
+int BPF_PROG(handle_sys_enter_raw_tp, struct pt_regs *regs, long id)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid ||
+	    id != __NR_getcwd)
+		return 0;
+
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs));
+}
+
+SEC("tp.s/syscalls/sys_enter_getcwd")
+int handle_sys_enter_tp(struct syscall_trace_enter *args)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	return copy_getcwd_arg((void *)args->args[0]);
+}
+
+SEC("tp.s/syscalls/sys_exit_getcwd")
+int handle_sys_exit_tp(struct syscall_trace_exit *args)
+{
+	struct pt_regs *regs;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return 0;
+
+	regs = (struct pt_regs *)bpf_task_pt_regs(bpf_get_current_task_btf());
+	return copy_getcwd_arg((void *)PT_REGS_PARM1_CORE_SYSCALL(regs));
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
+SEC("tracepoint.s/syscalls/sys_enter_getcwd")
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

