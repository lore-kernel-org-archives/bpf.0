Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929BA341649
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379042; cv=none; b=twih0EpfMpu7t1o7zGtuWvwBOXVhjQldoiSHMU9j7GLVM1qL26RwzitSUy5Kdbgbzd+pu9hMICoGCfL7kdMEd1UJMCvWVGuU58SAySSIXTc2lKXjr960SK1cipSG0L6dmxOwApcREuDGB+vdtHoXbcQzTb/kjp3Cc4N/bS8zaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379042; c=relaxed/simple;
	bh=BSoSyftKPiajwjvo13b22eQ7FZWEXkMUGGHBXk2w854=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkJPSmNP+VTBoiCRl1LSYP5n/EuyZO+3h83PgwraQVNVz01i47ktK00GiFVr6UGalLy/Sc9aKP+EUkH78goStDIUbDZFTuXeVQvUlj6j1HD2VDvnal307X+AqPN0gNPaT5rQ70DHbGM3HfGZHv9rfc5yYXkmt6blZV85y5ocuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0sgZjiF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0sgZjiF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fd27754bso13493295e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379039; x=1774983839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIrwgx/IZkH3tTF7nuFDgIrhDuNcmLtC/GtfOr63PAE=;
        b=H0sgZjiFgVlJaWoHMF3AOiGtcOZWJkxmEveDJMCwK370E8Cq1hI2q0NYRuSSYCRsCu
         cxAsH04chPZ5Y/LHs0JVFJh3yO9fysvMqFl2g4iOzy8wWiTUPwfZ3HT52OQI7bQwKYjt
         YNzjlg9wsmZ+RRxwDS3kWgF5XJmimtscBK5rwyhkMn8pywzPE1o7LWsf1/nKEi4xZyUb
         MlCszostUwpoRj2G6DRJRfrollm/mRkm4DwtXxPKs2GVWCDv0beqBhkt545KjwpQZevR
         6JRseCCf+MYS7DIh9OG9jP51dul9IYEY7DHdBJVFUjMqS7Enpy+vlZZ9P5PRkinhhbKH
         sm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379039; x=1774983839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AIrwgx/IZkH3tTF7nuFDgIrhDuNcmLtC/GtfOr63PAE=;
        b=dANGBKxn/YePtNXDk7b6aE0X5+JkaI9RjMgRmgt6Y1xjXvWGTX2ePxvqwVyvh9lXP8
         hM1JcNbhVyNzjn0QSFdNozbcABIFP8KBUlcLN90CISuudCyA7uWqbSEvG1x8GdM+17TQ
         n+Ax8ZuONMLm/riE5mNFnJ0s/Vqlfp3xN+an3Sa9qul0/Q/iPaMTGn07ORA4NK60PvvJ
         fRpm6uvRiGCUNI0BOQxuge6rE6hJ2ew+op+F+H8VW5fmA2FrgTfM36ExWnmpoOcHL93O
         EIkjSMRkg6MUJyz0yRICoAjG1yRmwhjoaJFVuKrVlBLs4VajZkNNRTx5EFJ1xJ00kzi8
         f+ww==
X-Gm-Message-State: AOJu0YyGlI4xqIImt0bGdqe5QNoeGjtfDMTMi0l6EqDzneqspg9itLrh
	nibuToSicmhg2M8+UNeXfaW3fLXA35maw6yMnGhE3LDWEAM1BcXVKBV2
X-Gm-Gg: ATEYQzxTpFhO+9eFimrrvMFKIBDgS9ywytPvtE1z9g2mcul78z6/6AMpIJCiURuLFs2
	Vy0O+KfYCZV1rTcq7ltRcwOQpH1cr0/LeVjmKQQHxb/Fyn+5JG9KH9kSDotxQcCCm+tRf2jSqrS
	Tudd6Ngu60MdAKpAbNQvFPV2waKitO4PrpEW9UVEmF6WRyOmLgUaFHB+ukOzHsAcAMawna7ISUG
	8xUqh00XZA/eGIZh1DcSETyyUP1CLhNaRvROi/h8oAjnKmbShpzw3cF+1SdmDULxwAUq5kd/3Lb
	TAUvrEK09sqEyiikx97b5kSLz9sG/yWBGtYhRBj0P5u33HAw5AYv1yvQTiliFTkEAR/5Kih+iZM
	z3sos3TNxZQaGNnKm9LR7w1uC/fciS6dirDwywwW5SYt3vKUr+4OXCfclUW00Upec0LGMmmlouU
	9lRUibNiERmqzN
X-Received: by 2002:a05:600c:6308:b0:487:169:9f64 with SMTP id 5b1f17b1804b1-48715fea9afmr11964045e9.12.1774379038350;
        Tue, 24 Mar 2026 12:03:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487172a72b6sm1010175e9.3.2026.03.24.12.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:03:57 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 24 Mar 2026 12:03:44 -0700
Subject: [PATCH bpf-next v6 6/6] selftests/bpf: Add tests for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-sleepable_tracepoints-v6-6-81bab3a43f25@meta.com>
References: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
In-Reply-To: <20260324-sleepable_tracepoints-v6-0-81bab3a43f25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774379028; l=10473;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=WS/EHttt2LOUmTMXKcUjws9WoFGgeeqClW3Jr6Q8Ypg=;
 b=ihlXYlv7snX8b5GiRerIc4pX3gva7HNIAsbCS3sRatsgHPfdczYwpeqj90RpehPP1G1KUdM6i
 YKunQ1Ag1WoDhK75r/dAk9NrtfG2Hcz5V+GGK406Td/U7F5IuzBmR2y
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

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

Add a negative test (handle_sched_switch) that verifies sleepable
programs are rejected on non-faultable tracepoints (sched_switch).

Update verifier/sleepable.c tests:
  - Add "sleepable raw tracepoint accept" test for sys_enter.
  - Rename reject test and update error message to match the new
    descriptive "Sleepable program cannot attach to non-faultable
    tracepoint" message.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../bpf/prog_tests/sleepable_tracepoints.c         | 121 +++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints.c         | 117 ++++++++++++++++++++
 .../bpf/progs/test_sleepable_tracepoints_fail.c    |  18 +++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  17 ++-
 4 files changed, 271 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
new file mode 100644
index 000000000000..46b7de1262b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
@@ -0,0 +1,121 @@
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
index 000000000000..bc8a7fd43ccc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
@@ -0,0 +1,117 @@
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

