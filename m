Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67C3D7A01
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787831; cv=none; b=CYLXN63i2HoUGYX3p04WqILNE7zXxf1rMQC9sEGxqo6nKc98UU/jeZyupjYd/KXtE1T/8YNlfGKBiWt4c54qDBY0Mf5v/2qiquNsovq/dC5XWkULfusbUzhx36hXGP2pIMeNzr9CyMwaYw1+C+C2RpVHeevFpVJm6B55CgD/Dwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787831; c=relaxed/simple;
	bh=eI/2M5tcgAqTodCDjsaLDI/9bc3DmGePOyD8qL8wT6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYdPVAdD90MPByI5bjyR6VhK9RTvkrttm719fYlc3X1kTVT5xGBV9S+UPDrZOmMw98qwC7nO+pVfQx8CrenFq+r15/h8XBWgQiRxYnUYFY36siGZNgPoVJynIYhF4bAsWpUy1ZC1/QUy71ZB8UwPpREQ1U7o/DYGRm72BWmiORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YojigM9C; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YojigM9C"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8419ab3a297so670191b3a.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779787829; x=1780392629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH+tMbPqWrGCdYXAz0bgQ+U5yt266SK1hwycBWIjpQU=;
        b=YojigM9CgVBMZKuRhexg3uRBOz8ICDbZGS2dIxRXKjBTxii0IkK36O9YrNFX0H7mjX
         4+08E7+pHsJsJJFARWbH2BlrB1AKMrldNpPBAS7FI+firzK0cY0AmDw1u4u7BhuPFrBo
         gUJWVpu3kikBOVeAoljYohd5pePLHwEG5q+cnMntmlTRL0/PJgV8360fr3vo4qNkjVYq
         EsVOXRqXEeW1x8aaaAyEBK4pSgM68r9c02uhyjAnBCUIuPdAbiakNZ47n79S3WDQ/41/
         U0/mmM7OPNajeeKvtteToiALLeODyQlWvEEGnunhtRJcTR1edYezD8JxC9patyRtsxcr
         1oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787829; x=1780392629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YH+tMbPqWrGCdYXAz0bgQ+U5yt266SK1hwycBWIjpQU=;
        b=jvDIUuWhHDBJizdytePhs3NzHk8gwFFeCCW5KOyRohhINY6IweD/XaHCF+6+rDSf7M
         er/LRPmcatHFBmcTGkQDvWn6I9fLLeQVchT/Lp3LsLl54jZyYoWRpo3l/PSmoHf8WBtU
         6cxK8t1Dvkb6P4WKZmgmruMSxuYQxjR0yPCgfOHTL+7nmmGH5vcS8MhG7HFPa/St4cL5
         wo22RpJsF23B3yQepaPTrrEIK6FuA7tSVPJXx827I64dt5DQWvzJWbjhdkjYuMy5SSKT
         slpOUCor6TWv9ai5WkZWAr+kthAHIKJ1pEA3TairPKNr7S9Yw4ePT8gDHiG2l9xrAJ/8
         XTAw==
X-Gm-Message-State: AOJu0YyBwZ1SqFtP0OLjz4d3ga3iuZ9tRtEkmnH7iYiE/F1AMrXTpOa2
	6WG36rTAmLJApVYmZU9s91OpImcE4vCcM9ZoGbYH+TOOafDxkT60OMk0XwmapslBUtE=
X-Gm-Gg: Acq92OElDylsd5tVh4VQBD58RH1Q9+86TShcj4wm75OwKrwlnyI4zykIsZDWlGrncym
	3zvBRqx0vBGDGvG6B0192CU0bwMsJ2mlDGLEJ1qiQJ9BjMplSgWRATsSbxSoQc7qEEHbOGI7Kng
	CEW8lhfmR68lT38hqc3lAayUGO7SjU5wWnKkLRWIbvz+h/9cDLLeZkT8j2rOU/WS2IsNFWqkcKp
	+UzuDWCDW9CRWnIMS5uKhg0uH+RGTr480x0tXQZvEyBiQVH4b/EPBMU5UhIMqOpY25qbT0ihcKd
	WMVZNFNB9yol619PITtqb+Hkz5o1tGi0H2i8b11QrpDun187FYQO+7zFKbnT0My3yMya/n0z99F
	3I2Qun721NtlIzRtrQwKDYhcU7XJdJ954nZfDERRJP4YYI9zTBoitG72EE9hsWxSOGbrsCm6naO
	v28h9LM1fLPxeW5ksDa2/7IGc9UGysPxfjljrfF6y4
X-Received: by 2002:a05:6a00:ad02:b0:82c:f035:6748 with SMTP id d2e1a72fcca58-8415f383a4dmr17589836b3a.42.1779787829284;
        Tue, 26 May 2026 02:30:29 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm13729505b3a.54.2026.05.26.02.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:30:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 6/6] selftests/bpf: test budget exhaustion profiling report
Date: Tue, 26 May 2026 02:30:07 -0700
Message-ID: <20260526-better-1m-reporting-v1-6-51e4f2c59780@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add verifier selftests that exhaust the 1M instruction budget and
verify that the new profiling report is produced:
- nested function calls with inner loop, check that stack trace is
  print correctly;
- two loops on the same level, check that both are reported;
- iterator-based loop with non-converging register, check that
  register is in the report;
- iterator-based loop with non-converging stack slot, check that stack
  slot is in the report.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_budget_report.c   | 175 +++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 35d92d176c1f..61a732a499b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -14,6 +14,7 @@
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
 #include "verifier_bounds.skel.h"
+#include "verifier_budget_report.skel.h"
 #include "verifier_bounds_deduction.skel.h"
 #include "verifier_bounds_deduction_non_const.skel.h"
 #include "verifier_bounds_mix_sign_unsign.skel.h"
@@ -169,6 +170,7 @@ void test_verifier_bounds(void)               { RUN(verifier_bounds); }
 void test_verifier_bounds_deduction(void)     { RUN(verifier_bounds_deduction); }
 void test_verifier_bounds_deduction_non_const(void)     { RUN(verifier_bounds_deduction_non_const); }
 void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_unsign); }
+void test_verifier_budget_report(void)        { RUN(verifier_budget_report); }
 void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_stack); }
 void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
 void test_verifier_bswap(void)                { RUN(verifier_bswap); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_budget_report.c b/tools/testing/selftests/bpf/progs/verifier_budget_report.c
new file mode 100644
index 000000000000..7b87e53831c2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_budget_report.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tracepoint")
+__failure
+__log_level(1)
+__msg("two_level_calls():")
+__msg("  0: (85) call pc+1")
+__msg("  1: (95) exit")
+__msg("two_level_calls__l1():")
+__msg("  2: (85) call pc+1")
+__msg("  3: (95) exit")
+__msg("two_level_calls__l2():")
+__msg("  4: (b7) r0 = 0")
+__msg("  5: (07) r0 += 1")
+__msg("  6: (05) goto pc-2")
+__msg("#1 most visited simulated stacktrace (visited 499999 times):")
+__msg("  two_level_calls/0 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
+__msg("  two_level_calls__l1/2 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
+__msg("  two_level_calls__l2/5 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
+__msg("BPF program is too large. Processed 1000001 insn")
+__naked void two_level_calls(void)
+{
+	asm volatile ("					\
+	call two_level_calls__l1;		\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used
+static __naked void two_level_calls__l1(void)
+{
+	asm volatile ("					\
+	call two_level_calls__l2;		\
+	exit;						\
+"	::: __clobber_all);
+}
+
+__used
+static __naked void two_level_calls__l2(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	goto 1b;					\
+"	::: __clobber_all);
+}
+
+SEC("tracepoint")
+__failure
+__log_level(1)
+__msg("two_loops():")
+__msg("  0: (b7) r6 = 250000")
+__msg("  1: (b7) r0 = 0")
+__msg("  2: (07) r0 += 1")
+__msg("  3: (ad) if r0 < r6 goto pc-2")
+__msg("  4: (b7) r0 = 0")
+__msg("  5: (07) r0 += 1")
+__msg("  6: (05) goto pc-2")
+__msg("#1 most visited simulated stacktrace (visited 250000 times):")
+__msg("  two_loops/2 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
+__msg("#2 most visited simulated stacktrace (visited 249999 times):")
+__msg("  two_loops/5 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
+__msg("BPF program is too large")
+__naked void two_loops(void)
+{
+	asm volatile ("					\
+	r6 = 250000;					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	if r0 < r6 goto 1b;				\
+	r0 = 0;						\
+2:	r0 += 1;					\
+	goto 2b;					\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__failure
+__log_level(1)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("iter_loop():")
+__msg("  8: (bf) r1 = r6")
+__msg("  9: (85) call bpf_iter_num_next")
+__msg("  10: (15) if r0 == 0x0 goto pc+3")
+__msg("  11: (07) r7 += 1")
+__msg("  12: (25) if r7 > 0xf4240 goto pc+1")
+__msg("  13: (05) goto pc-6")
+__msg("#1 most visited simulated stacktrace (visited 142856 times):")
+__msg("  iter_loop/8 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
+__msg("#2 most visited simulated stacktrace (visited 142856 times):")
+__msg("  iter_loop/9 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
+__msg("    Most varying: R7 (frame 0)")
+__msg("BPF program is too large. Processed 1000001 insn")
+__naked void iter_loop(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -16;					\
+	w2 = 0;						\
+	w3 = 1000000;					\
+	call %[bpf_iter_num_new];			\
+	r7 = 0;						\
+	r6 = r10;					\
+	r6 += -16;					\
+1:	r1 = r6;					\
+	call %[bpf_iter_num_next];			\
+	if r0 == 0 goto 2f;				\
+	r7 += 1;					\
+	if r7 > 1000000 goto 2f;			\
+	goto 1b;					\
+2:	r1 = r6;					\
+	call %[bpf_iter_num_destroy];			\
+	r0 = r7;					\
+	exit;						\
+"	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy)
+	: __clobber_all);
+}
+
+SEC("socket")
+__failure
+__log_level(1)
+__flag(BPF_F_TEST_STATE_FREQ)
+__msg("iter_stack_varying():")
+__msg("  10: (85) call bpf_iter_num_next")
+__msg("#1 most visited simulated stacktrace (visited 111110 times):")
+__msg("  iter_stack_varying/10 ({{.*}}/verifier_budget_report.c:{{[0-9]+}})")
+__msg("    Most varying: fp-24 (frame 0)")
+__msg("BPF program is too large. Processed 1000001 insn")
+__naked void iter_stack_varying(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -16;					\
+	w2 = 0;						\
+	w3 = 1000000;					\
+	call %[bpf_iter_num_new];			\
+	r8 = 0;						\
+	*(u64 *)(r10 - 24) = r8;			\
+	r6 = r10;					\
+	r6 += -16;					\
+1:	r1 = r6;					\
+	call %[bpf_iter_num_next];			\
+	if r0 == 0 goto 2f;				\
+	r8 = *(u64 *)(r10 - 24);			\
+	r8 += 1;					\
+	*(u64 *)(r10 - 24) = r8;			\
+	if r8 > 1000000 goto 2f;			\
+	goto 1b;					\
+2:	r1 = r6;					\
+	call %[bpf_iter_num_destroy];			\
+	r0 = *(u64 *)(r10 - 24);			\
+	exit;						\
+"	:
+	: __imm(bpf_iter_num_new),
+	  __imm(bpf_iter_num_next),
+	  __imm(bpf_iter_num_destroy)
+	: __clobber_all);
+}
+
+void iter_num_btf_fixup(void)
+{
+	bpf_iter_num_new(0, 0, 0);
+	bpf_iter_num_next(0);
+	bpf_iter_num_destroy(0);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0
