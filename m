Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C3342503
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430506; cv=none; b=CJt0TE+cP2+ChzR7JfnNJafN/Edj9XFebwuSvFm060pphUgBIdcOpuknhr9nH62MxNYwpVSQUwexXbcMiUb/inecLOMOq16RtTGd/3grJyuXEhIZTlm2REq/nJ2UlFZpbtuR5JCGy1FSi5k1L/6Db5jsD088/HX9zTc4WKAhTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430506; c=relaxed/simple;
	bh=xEM3KxvFdswJEuIwCVbdzAtePVmZWgbif/Dru/8vc2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHaK4+ekdRHpGE354CE3D9RM1tMAU587bmdEEaB0IspvLLe5yd682079JXvgRUl2IHMe612Te2qhVo6OgTUj9Li+Bpp07RD8Id+jhUpgVu8GQz9CBIFqm7knuH/C2ICT1ITozaMcFTJ7wXgTALME2qEdfiCfCo0eb4pmP8TRiSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uva3C2rJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uva3C2rJ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43945763558so2445877f8f.3
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771430503; x=1772035303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmN/GN7YS4kNxr7qplWip2HWNaA+e4gDK/269Wd21rM=;
        b=Uva3C2rJnct6wMt1A5CczHVbXgkam8qbs/DQpT/XPz/MsHy6LyC9oa4CKg92rPBW8f
         j0l0tVfsddEWbQYSiz6a8/hk6OnLoU/Vkpcwsm4s7otkPZTg7e7UHQFvtpiRyK13BIQg
         bLACbHMUQsqfJTfbuNSfzA1VfmQaAt5EMkpd7Z2yH3BqiRJRPiA9kOlf2exdb8GAClHr
         WJTw9tYzfmUuJA9kLBRaQZLpOp5sZLjyXNznYecrDmbmwCabznaSc1/T1mr7AH4Yts3g
         wUSXrNMBDpXXcUnTxqdIT4QqoD3t8Yus8+f6kEXQ7ERm5hIEouhUHsbVQHXs9gsnDhRS
         ZMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430503; x=1772035303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DmN/GN7YS4kNxr7qplWip2HWNaA+e4gDK/269Wd21rM=;
        b=HbLVDuuUidsQ8Et5J++4YTSBxZPXwgrH2TQWsPKutz961Y4yuqqchN0k7rWwYoTiBi
         +bnpdV70PGjp/Ha6XZRCAFkn36GacwlJKXeNfUF8TRzW0qQjEEFuyMHVGH4dWX8aPn9q
         /i/qAazRXN4EZlzazmYGnMs9vRT7YoX/SOS+Qktku77fdbfhJ7mrnoZe+2mjFP5iYGIt
         sMf7Bb+yrQMr7lulzYJkD5POlISqGlY29QkfIZaTUZ0XkyOjdIp/Oa0QZ0CqmKMFIdtD
         30sON0gsfVyU2bhIHEYJuHVI8+T7wZJqEjFsLMFj4qfAnloz5R+lcwulWN9yuVdI7jER
         VNtw==
X-Gm-Message-State: AOJu0YwRXmIdEeRmEmUD23u16hpxZwRdN56loOmR60hWgiHMFvaUWLTL
	gT50qpIY8yGjTfIl0dwCuzkfwfYC2aQB88Lw4/osPKEQtcMWcV41ZiFP
X-Gm-Gg: AZuq6aJyt4wtLICYayTPhJ0rfF2m82t1kNJnB0YMmd8RsvQjBkfvzz4NX8CVRhtDleC
	YmO92gHNFkPy6cD88IURuSzVMS5p3A4GOYUF35tn6ZwysVSXo7SaJ82aXFFiV/pa5hCvoLHdFS4
	+npbJ/wZ/X7m4p0AYp4GSjxqfO8d9klWhAQSEQzsSEwItMHQUv2LHR0PaaQrl4VF0tXPa6mdx0C
	6Xvw8bTXMCrPfOZrjvcm5XaUnK+VjP+2jYo/TgAiL+sE94rF48hQEy3Jj8tP9KLQtLCvFuHJkoC
	eoSPWFv9+/Tag8APu5hs+wq8C6X3hDsWy4RVD3hbr4M4RQZdTrh24GKummmnzY7kgOytasoISbm
	fFpSjVsghDmvoIc4jxjdfDZ/36LEKOBAdBcI4uj40xCIXvymX9jLzEm5yCmJqTMs3LmdVt0QIfw
	6gC2fMYwA=
X-Received: by 2002:a5d:5f48:0:b0:432:5c43:53 with SMTP id ffacd0b85a97d-43796aeff1emr32255535f8f.36.1771430502877;
        Wed, 18 Feb 2026 08:01:42 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac7d91sm44648195f8f.26.2026.02.18.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:01:42 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 18 Feb 2026 16:01:23 +0000
Subject: [PATCH RFC bpf-next 6/6] selftests/bpf: Add tests for sleepable
 raw tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-sleepable_tracepoints-v1-6-ec2705497208@meta.com>
References: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
In-Reply-To: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771430494; l=5677;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=5wPP21q14A9Y3S7PLcpiaUwt0DKBSF48sxI2fpzd68o=;
 b=CPTqaBDc9tMlfZZcxhfTFy38MPoiIe2v40UqN7Wslk144CLv82XM1YtErowOFl6F2jQKOfJAv
 RQLlZkumchYA5yHQSAFZxWcrxjWV6V9QczFLt6zOavV4/PGAyiyZaKw
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add two subtests:
- success: Attach a sleepable BPF program to the faultable sys_enter
  tracepoint (tp_btf.s/sys_enter). Verify the program is triggered by
  a syscall.
- reject_non_faultable: Attempt to attach a sleepable BPF program to
  a non-faultable tracepoint (tp_btf.s/sched_switch). Verify that
  attachment is rejected.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 56 ++++++++++++++++++++++
 .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 +++++++++++++++++
 .../bpf/progs/test_sleepable_raw_tp_fail.c         | 16 +++++++
 tools/testing/selftests/bpf/verifier/sleepable.c   |  5 +-
 4 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
new file mode 100644
index 0000000000000000000000000000000000000000..9b0ec7cc4cacf6ee3d2e0cdc23f63388c9613384
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
@@ -0,0 +1,56 @@
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
+static void test_sleepable_raw_tp_reject(void)
+{
+	struct test_sleepable_raw_tp_fail *skel;
+	int err;
+
+	skel = test_sleepable_raw_tp_fail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
+		goto cleanup;
+
+	err = test_sleepable_raw_tp_fail__attach(skel);
+	ASSERT_ERR(err, "skel_attach_should_fail");
+
+cleanup:
+	test_sleepable_raw_tp_fail__destroy(skel);
+}
+
+void test_sleepable_raw_tp(void)
+{
+	if (test__start_subtest("success"))
+		test_sleepable_raw_tp_success();
+	if (test__start_subtest("reject_non_faultable"))
+		test_sleepable_raw_tp_reject();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
new file mode 100644
index 0000000000000000000000000000000000000000..ebacc766df573c4ab725202b90c0a9b6d32970a1
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
index 0000000000000000000000000000000000000000..ef5dc3888df6d826f6b1d1adb211b439b71d6322
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* Sleepable program on a non-faultable tracepoint should fail at attach */
+SEC("tp_btf.s/sched_switch")
+int BPF_PROG(test_sleepable_sched_switch, bool preempt,
+	     struct task_struct *prev, struct task_struct *next)
+{
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
index 1f0d2bdc673f6e84e8e44be96c72977da0f73ab7..39522b7cd317080de42233afc180347b49fdff34 100644
--- a/tools/testing/selftests/bpf/verifier/sleepable.c
+++ b/tools/testing/selftests/bpf/verifier/sleepable.c
@@ -76,7 +76,7 @@
 	.runs = -1,
 },
 {
-	"sleepable raw tracepoint reject",
+	"sleepable raw tracepoint accept",
 	.insns = {
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
@@ -84,8 +84,7 @@
 	.prog_type = BPF_PROG_TYPE_TRACING,
 	.expected_attach_type = BPF_TRACE_RAW_TP,
 	.kfunc = "sched_switch",
-	.result = REJECT,
-	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
+	.result = ACCEPT,
 	.flags = BPF_F_SLEEPABLE,
 	.runs = -1,
 },

-- 
2.53.0

