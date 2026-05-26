Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A23B27DC
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824261; cv=none; b=bZbc9piEEVCacyE/OvRkJQmjYg83yzcRoZ1gGJ+s5+OsZW6+X0C++M1L1ui2GxF3lTyXBUYScrceF7wIel0wSc9CkX4BTugG4uklwtaoWiErYqm5ruP9cE8mBde6ywIy6TbfYt4EJjUdNLJntPBpAU1pB7rUpq2SFqjrNVzd4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824261; c=relaxed/simple;
	bh=P1EoxFmtZtb+aGnDkht1W4GhExpp0KTQCqbQRamjOWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mt2L/5FIAyo6CUCcdXeute/U/PzB07oYfwS4HEAHA6BULu8HDx4r1aEn6m/PZ+MQNe5MAxm1ZeH/TSAYN72h/yX4b4L+qi9Wnja/NzWFNimNejkD8pdIAtnTesIzWcrD4vDZwEPDnY6lmMqMG/qOITQ+awoKZqvIo1dlU0vWGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTIqHEPz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTIqHEPz"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-366139223e4so6703965a91.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779824259; x=1780429059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4DbxjiA7H6ybmYaA/cibw3/avZAHPnGrov6Z7d/SfM=;
        b=fTIqHEPzzmg0sw+WQbE5RaFntX3WtRf0SHi+B/hloShNlvKLI6sO9kKiQHW8SR90W2
         qCEcDZT9yMg7gHyhXY70oPGU6+WIVBWjqUhl7Z+LwZnT4vLNRIdqVELzwWhHjspL5K9U
         LxROopeyqv6G2SY/9U1mDnPQ7FAIGUsGAO3lc+GIRNGs6Dw9xwR3ap+P+NP2tBZxlT5r
         uBlIbw2qZwN97O6jxpQiH5QwJiRnE/SvWTLJuUNYQXYXrYklxzrjxn5YoDV01qUpB/uD
         hdJSZjndp4crUXzKsu+6uolgGPdvd8Lu3vVOcK6wL/kZ8f95yjkt7/gkqhwCCEYJcOZb
         SPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779824259; x=1780429059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s4DbxjiA7H6ybmYaA/cibw3/avZAHPnGrov6Z7d/SfM=;
        b=Se9/wxPxzfK5H2uNsontatgn89T6LOgzGq8lO8zrxzTkKnNVTF5qpLhRBstts+ddyj
         UQ4lTMnaD6dYlyczlx91vBZE03Jhm5BbgWXpjtXh7RQ9ZbreBCSfj8F1Xv47lWbgwXGb
         yJuhGvViktNN1VFwNewkDq3fFVlFpEcw6zlbNbAaEo3c+uCIARNOJri15B32xAMQXwJR
         5WdfiRVZHM7myz3Wq7mTQ6vs5tN5fPyRqqwVvxDBe7auhmk+IQ+2srEX3zAM5mqqytr2
         q3ahLJWSN88dh/Q0GIobxnHBrqvDK4VGdkskLA57bQW8IaXd899b6jxOhD0KPdSk3tYx
         UIlQ==
X-Gm-Message-State: AOJu0YwCvepkPN3rq+DbCxc/YhptlhLbZfbAcHSEuCMgZzx0evMNrKX3
	b/p2SXarEtCCmJgha0S8Q8j2HAKxTsnWKIpXRrgxzT5XIzZoK4IZYP+f0V3zojrhNzk=
X-Gm-Gg: Acq92OG30lrgTK3Y7RcW0Tu8wVhLSr9NCOu9tP/pXpOplNSe9OFw8rLGDu0V6yKb3D+
	6kHP9kSlU8yZncABho4Gk2ol7l7DlA0yL1oJnSIf219qVjXT2NgbsOF8bZZF8yQIszeuOBPc2nE
	jQE/pLfMjEAiOA2B0YadI6wCrfLrExCAgGCq7WGre8A5z588r2auTat7jjsAubJ/wdiJaDnEERB
	Vk8BYrr7YwdBI3Sqpa2efikgInuSE/qdJyhLEgQSqRM5deSyEfGZDW7dmnlThUKC6jEkYylqS2B
	G5hd0UbwYGkJBaRw4DMmIwXK0zpvhjNyzpFujA5lexri5iZx1sPNgXddXKF+HdTJsFP95CBtUEu
	mkViUhC5j1qIhoYj04uLHj9Iw0HXmRAHyP/jbkByYNBscd7jpXAmIqhRFj5NwcGHVapCT0NrrIV
	ST/Os9SrdNH8HAxPlZ2525LJFlPKFa+TBMuJkkARUptR8p1of170kwP6oHcYZG+YIoUJ8=
X-Received: by 2002:a17:90b:2c83:b0:368:147b:536a with SMTP id 98e67ed59e1d1-36a67504c8dmr18786062a91.14.1779824258931;
        Tue, 26 May 2026 12:37:38 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c913a1sm12617283a91.15.2026.05.26.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 12:37:38 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH RFC bpf-next v2 6/6] selftests/bpf: test budget exhaustion profiling report
Date: Tue, 26 May 2026 12:37:20 -0700
Message-ID: <20260526-better-1m-reporting-v2-6-e7ec61c45d41@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
References: <20260526-better-1m-reporting-v2-0-e7ec61c45d41@gmail.com>
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
2.54.0
