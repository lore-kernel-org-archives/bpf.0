Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3B324707
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036645; cv=none; b=pvHfGOuoBXTe4kUyaavtMUVCrUN5h4M1TE0y7Scwnnhi+adeWM1Dwm32aFDtIbyTnjfQN6yl9tjwagZWiH+sBFJEtwOqIokCclex46j7iPOflBg5W9a1hk1Up+ssZPGpfzZFUYsQxPO6cW1MqmCBXpM87/1T/5TG55Ir4UUFW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036645; c=relaxed/simple;
	bh=+Fm6T7z/3fmShG1TP2L2XDrSdKWLreqhljxw/Yve4Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCN+Wk4qqJmKfitMcNlUjAzYFt8GvGYwjh5vXLNIDyxLwt7ogwaTi/YRziEcijDxJVENOWWn3PFx59LxCp1HQgUfzVa1+EIBAzj0eySrs/dPjSj8GePknEy/M/q95j/AUuIIl4+hxEKrh0o5jFLIBEkUpXNZWssvWD7Dn1N37D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYiXxnKG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYiXxnKG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483abed83b6so33907165e9.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772036642; x=1772641442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LYm4CAgDdQMOgDFVADHHsB3EBlPMyK9cUl9PHA+9zfg=;
        b=eYiXxnKGP0rrGwsaP8mDEyOVFcXb2punYL7IDu7nfw38FkAE8IyGKpRvQGP1jld9Qp
         SzQEQTAsW8Xv4AatCdl+JcV8yxvQ9c59X6Tx7BmhD5Qa2TAZDqrBngzZucx5FED7YC0A
         HCoznTBYi3Eaiv3b4VQN+GdQST2ZwWonCaS5wfIElnOQkeo81EY1HygI9MpdHUr2WR5W
         hIqnoncqdhJuQyojJ0GkDqO2kkJcKdn6wTLFe/vlhdHJojI1MvmxwNCw3pY+F9juAc6J
         6KquqUVMwO6wQYlrktN11jxUkRieDWlN+GfnoNojxIc277KMMW0GEw/soKVqPzgXGeFr
         3bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036642; x=1772641442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LYm4CAgDdQMOgDFVADHHsB3EBlPMyK9cUl9PHA+9zfg=;
        b=rvKOdkfAgAfZWNV66bNjIqZKPz7Ep1ZETl8CrmIiaIlmfUqTYzafsee2/vQ1+KSsqc
         HpxBLAVwVWaHJLrLqDKi5Dmd96KhihyKHuPBamNaXs8wJfRXZVvsKaIeZTqgTlJfw5wW
         8VWwy4W6ORrvzSqC+qsYAYOReY1nRHcB5Dwgd3kbo9m3ueeLK6nBLgdHCqNmW4UNoJ5k
         M9XzVJ7nvIAu5+GS+PXs1XqnA2g0bJdMzwCwu7Tktzbnq8lZuhIF0Dpv56579lXJuray
         ne5iqbE9zbnkjrGkom3cilaq3Lnbk3y615C1mLCkBuPfjQvNOg/wtHU2WX3C6kqc/Hib
         ySPw==
X-Gm-Message-State: AOJu0Yxk8ayrVlQhX78RDeAoRFbR4NdVX2cOk6h/0hYIh7AvXjlotWAi
	DJnAoKlA6Nt0QiCn5ZlXnTFJZD4xoOt6dLKMld6UlN9Ng/Jq6PRyTEHI
X-Gm-Gg: ATEYQzxFGb6inDxgPCfrOMqFwweskLyeTMyxuc5N0ypgXLLIiMOAFJZp7u/SRsQPoWg
	wPo+203BxaHisbv+lQF/TtYYaXlDWrelxxMArLXyw8DkS6IfdboEEHkjrl1/3/6qDUnzJ5zlcku
	6+zzYv2SACiMy52bX9yZ/4M70jc+WuWhPq91iW3t8yJ8Jm9tLXXkuLQaHwniDLI2NouN+T3Ph4h
	DzO39q/pjTTaA3PMnvqCgG9sHbmEzWWHF8RLqROvJZHWsVTkQ/Fws5FuH7/MTGY9FOYRUk7CWyF
	74Zyh6+hSDRlTzOrwl7Ny394W5JPV+yH1G6+trP7cZEFAKD9+UszZO673nv96QfytqF+CEaApXY
	lUD4QxMKEYMlEwsB2miGShLaSyZBBrMa4aC5B2dEEi90kNbzwdBKO5IQoa+hQFWkSxxANvhc0/P
	LxF7NwYdnOiFlSIZyo9CHo4CINmL3W
X-Received: by 2002:a05:600c:608f:b0:480:49ce:42cc with SMTP id 5b1f17b1804b1-483a95bd993mr264947845e9.9.1772036641729;
        Wed, 25 Feb 2026 08:24:01 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4f::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb1390bsm30254445e9.1.2026.02.25.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:24:01 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Feb 2026 08:23:54 -0800
Subject: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for sleepable raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-sleepable_tracepoints-v2-6-0330dafd650f@meta.com>
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772036632; l=5453;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=BMl3mFw6Vs+5KyDHPep4zWkHyLgUpj1Y1iebPVtVf6g=;
 b=NEI6N4g3nGw984dF1LwTFSpZ5h/7nPchl4N9hWnKJRgZk37nHK0MA68PYrWVOkYtecVFYLmiF
 mSnmZckL0WhDkhj8KqTfR5NR6lxFA1uj2PG+595zaYsdnKL/OaoGWD8
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

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
index 000000000000..9b0ec7cc4cac
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
index 000000000000..ef5dc3888df6
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
index 1f0d2bdc673f..39522b7cd317 100644
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
2.47.3

