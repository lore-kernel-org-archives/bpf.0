Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37E28C2BF
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697618; cv=none; b=rtniJeaPzWz90kDFWIozpXeaN+iHoIOdY1yG76UDTzqzaiCVXUoAlP6Yl8qIJcVnx6szNx4VuaE4T9MEgGRJ1y4R3IKS7vZ/SxFl1xNvpLFVvEmkB4I4WI9X1bdOAEbuSbxRG6T0Gbidcr50Z4Vr/GcDJw7VmVP1TMtVvhtwpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697618; c=relaxed/simple;
	bh=vrjWRnlgKENGDaiuFyFNVhFkvThmKOo1U0iI6F5NZi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u5q9x4r5omNz1cAKLcfjX+1WCzbVSguXC+U6vZPj7Tivid3yJfa/bYLfjZaYE4o2rj2N/l3frIBX53GE9iqwVBA6IN1XQjjd2Rwpj9nyqfCrGz7eDd1koF8RGkWTHOyblgArl49Ij1dxSGs0fzPkpbsjr5GHL6wpV8vaTFeyxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atLJxqX6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atLJxqX6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48534237460so55429435e9.3
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697616; x=1774302416; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63w26VQ4bd8MnGIRXE6gPj9gVwarYkuK0a7aogcvQAE=;
        b=atLJxqX6OEEpLFemttnBPwt0M6YZFNkkH0vOchDpsCapl4uO0sdt/4NUpxMb7gjFSV
         vFtqwVRPTEGyP/Iwa0gAis3TzNcnsAKmYUAbfb3QsMNAZUSkxqjT4xmdBSMvKRtQs/XM
         f5slWwRJnwi5PcsudHcJ3G2b3oNklNVrnLndsQHD+H8f+01Wrrjxv9WCum+yhtiWOnhL
         ZNNtbJUqFj5DbtZY36hjhQN983BqwICafVm4QN6OObtX6ZlddlfcczwzcqC5VrH+znGv
         eRdQOzJKYljkYv2V8Cnmdg3H2ynL5Jt191wIFMbm4sf4obP4fmUHh5g5han+932HZP56
         KEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697616; x=1774302416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=63w26VQ4bd8MnGIRXE6gPj9gVwarYkuK0a7aogcvQAE=;
        b=YJc721jrHnLSalNEcecMPlLzzQ2Z055GCNO8QRjZvjlnUdI3gOABwtg8NtSYOIs8yQ
         Q+mEj/UGN0UE9tj6aToC4r+KAJb8H4jwMOHh9RqED/6k8fznWgy5FlMUljClGcglPA9T
         MaJKiILUhAHE42OEb/a5YTdyER7ugpUJwvqsfFx5K26lyQe5jmavGg5BBR71WorcJCLR
         TeKyuds38wDOGd0a+0aL5LLiChUzfRVBG+AHVbkQieF8y4mbj7q4veRjaT2FdMDNLlI6
         YHqLXyhdQt38W8b6UXrZWXqpG346VlmGpz4B2mE54ZtWugvnIIVSwjT2+bDaVNuDMV6P
         /2jw==
X-Gm-Message-State: AOJu0Yx/NcXrvZPfprNi4WYgpbqZn3rGr5eKD/4D7UT46pcP8ZxhsRH/
	EXUS88JKYHvEJpk8JaZHMOwye749AAs0UIJRQvFKaYnyRjhvQ5HG5DXQ
X-Gm-Gg: ATEYQzz4vxrRt9bBAXTFWPDvmYX4kacc4hWfrBfTfSX5abKbAK4Ox9hfvwZ3is9w8Sk
	lDexLwCwHifNNnXXrNtvVotL37IjF6ZI2HZxIKtYabs0/SBITaZNtS/jSnt+JSHRXbzM3DmNDQ3
	vwyc8uCWbzip63Cp71nc5x/A3qkdS9O9Zp2muhNIdGgnl7zHAsvEQm5R0FxjSJT9NFW11mz3Gip
	MN3LiQ9Fp9Uc8xBSibdLrXucCSGqRC3LXb9S69rWxJGsbfY+PCSij6Dr9rDmg78qxFun36QzDNU
	aItcbN8QSip2YPKBWub5wbXbQ+LRS5xq5jA0zdGfHeobqAhekDNWa2vlVPvrfprOxieny5ySGHK
	ZKKWl/l9mB7NCgg7sgEBqfpKWLdw7Lww+yxS+sizjMV7wLZJxy37hrQLlzmLhQ3Z4/Ja3tB6zS+
	7rDYyn0dODGxAZAQwexqzTf/XC
X-Received: by 2002:a05:600c:4586:b0:485:363b:fafe with SMTP id 5b1f17b1804b1-485566c6a15mr256056205e9.1.1773697615543;
        Mon, 16 Mar 2026 14:46:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9dc46sm23904535e9.8.2026.03.16.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:46:55 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 16 Mar 2026 14:46:48 -0700
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Add tests for sleepable
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-sleepable_tracepoints-v5-5-85525de71d25@meta.com>
References: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
In-Reply-To: <20260316-sleepable_tracepoints-v5-0-85525de71d25@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773697607; l=6502;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=NTxaLa8aw7wxNkZHy7Yr+X6gJI0+nU/rFPWahI3Se0U=;
 b=otEr4R6yS+qwf6wCpKz3GDoUbEz2+7kFK4De+rFXSFHDh/c71hoDX0AK+bNCVCVzdVdxyW6Ev
 AbAu0oZjLXZB1X1fjlwcQjaXlg+6WhdDLbOYKV8KKUQiFfurp/a2KSR
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

Add a negative test (handle_sched_switch) that verifies sleepable
programs are rejected on non-faultable tracepoints (sched_switch).

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

