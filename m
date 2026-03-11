Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB63E6DC1
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253387; cv=none; b=XOeXrOYAF1P/xU1x7yuT6uLKhoo4Cjpz3aVV9IkhkOCQYc0GZQsNtNwlgkNMRAPVc//SdzX4FbXudqVonzKa3Rn/ZwZodRo9/pytolayn5rilO8NV9iuO7LhSimUEnY7UK3X1IaFbSIxJTMqrWtb3e36aPmVlkL8z+LmGj/3mu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253387; c=relaxed/simple;
	bh=FYvHDeKs6YTOt95jeChhPmgYjIf1shkMX1g4JZA9X5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o623gRcRfireGCk1VdaVl/i9ePTqrCNiVi9HR4pqfbes6kQpctUABI9Wxc+aggbdm20K+4owhRiJMwrpaUCXNw1aYGAGKwxqbxZOdPbgYj6iyhOcwf9o/3TZBlV8tmxlWLHwSnt/duZkx2xaNjssXqIzwpspgZsnBcPGkvLoRNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KenP7+/A; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KenP7+/A"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so216091f8f.0
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773253384; x=1773858184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5XY82m7dXSswngXB1AFGnvEBx1RJEgys7LWCKrgiXI=;
        b=KenP7+/AzKI485Z2ny96d7uti+hVWAqvqfOdfCmJ5uBxDatRyha253pWKmPKC/dAEo
         5MgpfwP2VBT1tBeal7nD8wJXhZQKFhAx+h52JYLEy2Y/sVIBu/K7WTZBa2nz6j/rLwXY
         yyZLFbhFv/5ZXvEvK4lCCyheUtWiSTZeNbDr5fGIMncIIcsk+yG6em0deMVpmvXzdWgj
         1ZtogCHMmHeEcybahq5XNukElk9Jf4aL0TRfVkXZaTgWLXkdN11vfI8AsSPI5BCmH1AT
         EsqdTa5GnMZsHL8C3suO7nuKTSNSlJ7jILeEPmlS8zvuIC6gfsJefmPi9jnyOMktI7gI
         b1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253384; x=1773858184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h5XY82m7dXSswngXB1AFGnvEBx1RJEgys7LWCKrgiXI=;
        b=JDskAKYKOgWxwld7pLF08YftDK5+6+2VxgJcFXBXmHCYfGp9TXrXF4KWqB/CElduH8
         eHyhg7l83w9mhUDHB4Ql1sIHfvYtKLbJRm9ZhDkhZj3UiR2HBuAFwGDUgHPknazW9wfO
         t7iUSl28+n8TieO5v92IETAjuKFNm4wGKOVItN7eUcMXqUHLWF4oDz8OE4NicTyPlvlo
         v7chIITa8F2tUFd/h2GrirIg/flPtw4EXVf+uizmc6+UtSayU6aZwyf/rl47FCdQijhz
         +tkoRvOCVzh8rGXHQ3ilLDPJeVkDD+UJ1kS+MNHWQGnvpkNBQsUNZnfKChRDMUTqnoC4
         9E2g==
X-Gm-Message-State: AOJu0YzQdBOWgUQB0gv5hAncUEaVtnaZIIpmsxPXSWglv+dULvAci3ex
	LoZRrIqog9/lBs3tNArwwACa9mc9aS6WKNUO4LFhgaoyX9YOh9hwuDPg
X-Gm-Gg: ATEYQzyk0qxRb/Hhi3hMqRzw10026aTk2e1QijMNIWOBlNEIQpGnTPxcvMZqyfrJjit
	RDMVy0OvWzN/rfmK2nzFv0f6eF/Q41AN8tvGsqzzHfHcKJSAHbVfCJoXzE/ZjGbdnTHHoFhIU1r
	9ILb8kxGTxKwBqbcl5xlepmPAGBW4oswT4srd10bQVVUvPh97FeOAL0JWJ455onu3buE1rha120
	c/Q9nbbENtqy+hllzuEYtGtBXeotvm1LNu8RKenoU49ux1peabC9wwv5tm6gBoYIc+sW+MiYl/h
	CMxaBupcm34UbT88+/YtenIdo+scr5puFbyVm6KJ6i3R4WfH2gWUSa98OqqOiCPEH6Iq5iokSWF
	43IuSemRO8m0Qhvl7FgxX1ehZtmFSC27wqVqMLDQl7f3nF+KphhvaiOb0dhxMz6PR8pNU4CbF8N
	mJ6R/l+e7JwbEXerqCQw==
X-Received: by 2002:a05:6000:40c8:b0:439:c5a5:c1fb with SMTP id ffacd0b85a97d-439f81b6666mr6992316f8f.4.1773253383732;
        Wed, 11 Mar 2026 11:23:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19ad9asm1400573f8f.7.2026.03.11.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:23:03 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 11 Mar 2026 11:22:52 -0700
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Add tests for sleepable raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-sleepable_tracepoints-v3-4-3e9bbde5bd22@meta.com>
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773253376; l=5535;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=8kj9JMRopYR3E6rzk5wM6zp5BTkZUKhz9S82dPbXmWo=;
 b=PQv/rE1FCfobuJHvqxBCRcpH5uFde/SLTvlgmF2h49++6ZUFBlyNF/dbHUjzJxe3sXo5Metxf
 0RZOFoJntcNC4SqVypWNy5N1mENN3CtLPmHpK88YDFr1tuMGXHvNzBj
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add tests for sleepable raw tracepoint programs:
- success: Attach a sleepable BPF program to the faultable sys_enter
  tracepoint (tp_btf.s/sys_enter). Verify the program is triggered by
  a syscall.
- reject_non_faultable: Verify that loading a sleepable BPF program
  targeting a non-faultable tracepoint (tp_btf.s/sched_switch) is
  rejected by the verifier.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 40 ++++++++++++++++++++
 .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 ++++++++++++++++++++++
 .../bpf/progs/test_sleepable_raw_tp_fail.c         | 18 +++++++++
 tools/testing/selftests/bpf/verifier/sleepable.c   | 17 ++++++++-
 4 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
new file mode 100644
index 000000000000..e902b41591e7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include <time.h>
+#include "test_sleepable_raw_tp.skel.h"
+#include "test_sleepable_raw_tp_fail.skel.h"
+
+static void test_sleepable_raw_tp_success(void)
+{
+	struct test_sleepable_raw_tp *skel;
+	int err;
+
+	skel = test_sleepable_raw_tp__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		return;
+
+	skel->bss->target_pid = getpid();
+
+	err = test_sleepable_raw_tp__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec = 555 }, NULL);
+
+	ASSERT_EQ(skel->bss->triggered, 1, "triggered");
+	ASSERT_EQ(skel->bss->err, 0, "err");
+	ASSERT_EQ(skel->bss->copied_tv_nsec, 555, "copied_tv_nsec");
+
+cleanup:
+	test_sleepable_raw_tp__destroy(skel);
+}
+
+void test_sleepable_raw_tp(void)
+{
+	if (test__start_subtest("success"))
+		test_sleepable_raw_tp_success();
+
+	RUN_TESTS(test_sleepable_raw_tp_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
new file mode 100644
index 000000000000..ebacc766df57
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
@@ -0,0 +1,43 @@
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
+long err;
+long copied_tv_nsec;
+
+SEC("tp_btf.s/sys_enter")
+int BPF_PROG(test_sleepable_sys_enter, struct pt_regs *regs, long id)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct __kernel_timespec *ts;
+	long tv_nsec;
+
+	if (task->pid != target_pid)
+		return 0;
+
+	if (id != __NR_nanosleep)
+		return 0;
+
+	ts = (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);
+
+	/*
+	 * Use bpf_copy_from_user() - a sleepable helper - to read user memory.
+	 * This exercises the sleepable execution path of raw tracepoints.
+	 */
+	err = bpf_copy_from_user(&tv_nsec, sizeof(tv_nsec), &ts->tv_nsec);
+	if (err)
+		return err;
+
+	copied_tv_nsec = tv_nsec;
+	triggered = 1;
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
new file mode 100644
index 000000000000..54100899f728
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
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
+int BPF_PROG(test_sleepable_sched_switch, bool preempt,
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

