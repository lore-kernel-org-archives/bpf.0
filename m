Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C745728541A
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867013; cv=none; b=Y637Fv9SuLTXEHc5qECVqQ3ejCjxQEw6funuVb9Z77QtXC4E2vgEO5k14BiVT83NVTkzCQaTIZU8mgVaQN+6xXPvI6Ug10wBMMOV8S8nmVI3l6yH80aC0hdvUM9+pcCWGjaIrDI7RT9O+yobaLdcBKSyIahRAChnl9HtSgqMdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867013; c=relaxed/simple;
	bh=eI/2M5tcgAqTodCDjsaLDI/9bc3DmGePOyD8qL8wT6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwbSUmOb3VP0zvCtKvswEkMc06r2t2JM4YpDeIU1Ne0mYPz8thRm42sH8DaZY3l6WQExrbVD8DAeyysZIp0AyxOchqVgtuoRmatrdnxoLZc/B9USQUng8TrwUHjtgpW6R65xmA7PMRjmQAS5WW9Ymn7I9vSY9vgeOyvKkTsMIqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4A8sKxU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4A8sKxU"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so118717065ad.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867011; x=1780471811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH+tMbPqWrGCdYXAz0bgQ+U5yt266SK1hwycBWIjpQU=;
        b=L4A8sKxURHQ67MuXM3K1fHoDxSvGdmuWV8mykV0Wx/G75w0bw4ZI9qVZEkv+DOuSiA
         AWsxDxEFA7tJB6lCrJ+VAKMfH7PCnPQD+CG+S5fF3FZZ8r4C16SLm8FgO454kObJEkSa
         alJJEZyG5zqbYur4im9QPujwJcOzoFB0j7obOQtd3swlclAIu0Ad/ss1ZPeDbgpIklPc
         go3yMbjgSN8yZo+rNIJiZSeQrhwjYjL5a/4tQtZ4MfCZXkNhZQWlfTzKCFyayQh64oIj
         k65HWzV4uKQl/J1hVgEekomMlBvIF9I/oDcgsMW//ll/IApEejANvfdHUTftieVR4tQJ
         E0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867011; x=1780471811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YH+tMbPqWrGCdYXAz0bgQ+U5yt266SK1hwycBWIjpQU=;
        b=cBTxY1jYVBsDrxcalQ6tv3GN5DJnqeZCPsZiaSiZIEbvKjPVqwEH8+3k+FA76GodNr
         QUnOeAeASv5LIUtejbvzHw5+zEHuPk03RZwWTj1R3MMNb8lc9hwF+Y9MtB54OnC14vGy
         Fq8FvtpTo6L4Vd082k5LoPkQNesiMO6akeVFEGBENUGVox6X5vXz33ya7pa6rYwS/yC0
         IeENnAVQ8WMnG4+bFzAcu9U0EqKLIqNeIb/rknTSa1M3f5X+LzfBXv2gh11SdPYkYpGU
         ++qtOOs/y0HilILAxq0kClUKXS0+vcCjd0dyzTiaHEQjHvEhVKyIXOvWzIuAJveA8D0t
         Ah5Q==
X-Gm-Message-State: AOJu0YxhlssA9UFccz2StytweKRUoTn1a/svTvxtkh5/jzSOMA5ZWWdS
	uc+qNYTCeZVVz3+anjsE1TrHD+WD0OpRdGG18HG2TjRRe6jVC6jiyFnCVlJcRGng
X-Gm-Gg: Acq92OHZGdJCgKBm9M9q5HloaCNreJSZCk7beR6VjA55Bt1uipFP94y46Y9QUb84GxX
	NfqBQLfetYPXNxIKoAbttGWAn/nyxjQjr5+lS+EtdsLeGhhiiLdoZ5bGrsNoczjQDI9lJxsZ0Fj
	GizCAJXJpqUyXJ9sLnpUkIUd7co7eX/pKXNl55IfO4LLADUmsXNZzdhcrEXcmDH+6Rl10eYL3z9
	RzL0dew6uzqKlpm8Bshv1Z4V0gsxUfDkuAvG+EAinH/SerQ8/HIe1SV555eIhA8e5T6ZnKQb1c5
	7KhsbRiiovPsRjlhZG0xONGXRyy5uwzurvDlyFUnwjSpbVs5tUMaF9PPD+AXtSvKcTooKhOXxk6
	IgrHygYUfNexdZIRbMtUrO+sC/iYZW+UdmTyL5NtFefxlhc69hhJckPhmQCdcr6J1mWQX8PT4kI
	vOz1Cz94ge+IpakDeXek443kM5E3Htaz6/VEvMWwg2lkO5UKQv/lTMHm+z53zIjQ==
X-Received: by 2002:a17:903:3b87:b0:2ba:3e2f:6883 with SMTP id d9443c01a7336-2beb05d9f8cmr245988395ad.19.1779867010214;
        Wed, 27 May 2026 00:30:10 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm89242325ad.2.2026.05.27.00.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:30:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v3 6/6] selftests/bpf: test budget exhaustion profiling report
Date: Wed, 27 May 2026 00:29:54 -0700
Message-ID: <20260527-better-1m-reporting-v3-6-b3ede0588a75@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
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
