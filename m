Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC73D7D6B
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787828; cv=none; b=NuZR6hstCoCfrYnLR96n3maOGDMulm2V84Us2aGQ5AEEHsn6z3m8xYF9Gw1vsJSHHyGlb/rREaTwuP3Rt+NRkn8aZp3g7D/OEDdzvuzKqVbOLXwnsSV/lX1X/DSaQJmQHI2llbTs9dFh5E05mcmrJ+LPF34ncnkeNuqjee29p/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787828; c=relaxed/simple;
	bh=m9K/fNEC5KVShVZks7j4YwqueqGxT44Pq9x6JL1zy8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV2RbTZsPxOOr/MgZ5xyKGhZoHa5erWg8WTjDf1TUrdAVYl6fPrP1DDPeufDEhj7Gd+uBThY331VEy43Trj2QBigIgQOZJtO2Wo/8wTmfF6ny+ullF/UL+6VUabKDYtDrJJOuLxLxhr2Mnx8vlnCYeJTH78QPX5+1SQqqjXRi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1clQddU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1clQddU"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c795f441ff7so7861342a12.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779787826; x=1780392626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvUyOnXM1ul29fQLK+dCGjOF/7wW2jrVEAnsYNFJdBc=;
        b=n1clQddU3mz417C5mmP1V64aIh4sIZKSbHgn4UpCR1qzzV9GWPEO/BO25w1Ezpls5W
         mGh4997EXKS02Do8zahbwaQaKGWrtTp/2qAZxDxq2mfKFTUMjL24cvwGTcc2nrefnhJd
         Y0hcfBLcZjRP6ZBVsPvbh0LQ/Yk/XjEPFZtd/BlflZ1dkaFDYFETPlhg15YOqDdnNcj7
         8K6DphwY469UfBDXCla+kujOEG6pe7FJp/xrGJ9Xv4xyP9mkDrrUzEjEmwThxR0XFr9T
         Oy1rbyZkaHjOoovREThkhS+ATZ/4aKqoZAvSgjU+WksulzF3PdEiDdMw6PNoEyRXF/NZ
         0NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787826; x=1780392626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FvUyOnXM1ul29fQLK+dCGjOF/7wW2jrVEAnsYNFJdBc=;
        b=R0B1uyTS49lydFRd/kBXmvnm3qMoZF4cEw/uZmoHPp/din/8gBout9Bi45c15Z1rtP
         TIzC193R1xErmGE3aWa+N71nsM4qg0J07JNC1a2RLnfujUyH63vFKd/i4dmOVwhbqEG4
         nX6j2llX7QzQ1dNY5a3E4Sd8oDKbWJlwt2WcGIC8uBvNA034aVkP7gmx9BZSQNLP9FSv
         at2evWfVY68wFGyPvOhV7LU2Tza1ZfwGnx7X4XPwRN64PQXmEbe31+4or19ABDdInS0Y
         yQBt4ODlQDN23Ai0mJm0or0B9ZlObO+MNYvIjnow8xpptDIPKCBovZrSVWI2EzFiiU8e
         Ks8Q==
X-Gm-Message-State: AOJu0Yz1v5bsP1iurnvSlxTZP/PtV4QutvLql4CSbsgJTbl6MoDxxFzz
	W5E3pPYpl1+mHCULdfD8RfxJw3UOaPq1e6vbqLdWadbnEOWy0KqbhA1iXJ67/EH3pSA=
X-Gm-Gg: Acq92OGeiK7/9aBicDMFDIRdOm5ArTx8OP1TMaAaFtzXYJn/dXZ+Sn6CvZ+fFn4mJCj
	EdMZUDezgnU4hAZR9Ht4W1y0W6bX6Ib7LmbCIgxoWLfqTUtWrCNfp2R1BUPHVTAJD9OOuxWbxWk
	Iw+0iTpyCrNa48Op4TiHBcD2cJtqXUL49Yu//R5jxyTN7cwktG3kP94yLxp57lFeCNi0iAZ41Ah
	fmk8waz2l+JokTZws+8WwFCgxcjGZErVVKKH4ReHd8kUV2/65VEnhOxj6f6s+p7ftIpPNQWIVsK
	9YaHw1sISyvnri3khPwYWXw/PgvsKKAlyGVZ6xLE1DbI40+JTfCcO/nOy1Fq9TdKHdwmk41J4p6
	GJ9XhOLZZsIc9hHVgsKQoz3nSaFwn0ql7DgVAGgWd83Gwsohb8BmpPl+CbK2PKxlQp3jC8IfoIf
	ntQ/qTTY2qc38P/hcvjWpqFXNL6eAQFl0yTBo/n1L3
X-Received: by 2002:a05:6300:4093:b0:3a3:addc:8f47 with SMTP id adf61e73a8af0-3b328ec89e7mr19620044637.42.1779787825864;
        Tue, 26 May 2026 02:30:25 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm13729505b3a.54.2026.05.26.02.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:30:25 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 3/6] selftests/bpf: test cases for loop hierarchy computation
Date: Tue, 26 May 2026 02:30:04 -0700
Message-ID: <20260526-better-1m-reporting-v1-3-51e4f2c59780@gmail.com>
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

Test cases covering the following branches in bpf_compute_loops():
- Case B: simple backedge creating a loop (loop_single)
- Case B: two independent loops (loop_two_independent)
- Case B + D: nested loops where inner header's loop_header points to
  outer (loop_nested)
- Case C: diamond CFG with no loops (fwd_edges_no_loop)
- Case D: sibling inner loops within one outer loop
  (loop_nested_siblings)
- Three levels of loop nesting (loop_three_levels)
- Loop with if-else body containing forward branches
  (loop_with_if_else)

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  | 223 +++++++++++++++++++++
 2 files changed, 225 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 219ff2969868..35d92d176c1f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -57,6 +57,7 @@
 #include "verifier_live_stack.skel.h"
 #include "verifier_liveness_exp.skel.h"
 #include "verifier_load_acquire.skel.h"
+#include "verifier_loop_hierarchy.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
@@ -208,6 +209,7 @@ void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
 void test_verifier_live_stack(void)           { RUN(verifier_live_stack); }
 void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_exp); }
+void test_verifier_loop_hierarchy(void)       { RUN(verifier_loop_hierarchy); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
new file mode 100644
index 000000000000..db26157e3e14
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * kernel/bpf/loops.c:compute_loops() distinguish between
+ * the following cases:
+ * - B: backedge -> simple loop
+ * - C: cross edge to non-loop node -> no-op
+ * - D: edge to node whose header is in DFS path -> nested loop
+ * - E: edge to node whose header is NOT in DFS path -> irreducible
+ *
+ * Below test cases cover the above branches in various combinations.
+ */
+
+/* Case B: single bounded loop. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("          0: {{.*}} (b7) r0 = 0")
+__msg("  1       1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("          3: {{.*}} (95) exit")
+__naked void loop_single(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	if r0 < 10 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Case B: two independent loops at the same nesting level. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("          0: {{.*}} (b7) r0 = 0")
+__msg("  2       1: {{.*}} (07) r0 += 1")
+__msg("  2   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("          3: {{.*}} (b7) r1 = 0")
+__msg("  1       4: {{.*}} (07) r1 += 1")
+__msg("  1   4   5: {{.*}} (a5) if r1 < 0xa goto pc-2")
+__msg("          6: {{.*}} (95) exit")
+__naked void loop_two_independent(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	if r0 < 10 goto 1b;				\
+	r1 = 0;						\
+2:	r1 += 1;					\
+	if r1 < 10 goto 2b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Case B + D: nested loops. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("          0: {{.*}} (b7) r0 = 0")
+__msg("  1       1: {{.*}} (07) r0 += 1")		/* outer loop header */
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")		/* outer loop insn */
+__msg("  1   1   3: {{.*}} (07) r1 += 1")		/* inner loop header */
+__msg("  1   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2") /* inner loop insn */
+__msg("  1   1   5: {{.*}} (a5) if r0 < 0xa goto pc-5") /* outer loop insn */
+__msg("          6: {{.*}} (95) exit")
+__naked void loop_nested(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	r1 = 0;						\
+2:	r1 += 1;					\
+	if r1 < 5 goto 2b;				\
+	if r0 < 10 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Case C: forward edges, no loops. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("          0: {{.*}} (b7) r0 = 1")
+__msg("          1: {{.*}} (05) goto pc+2")
+__msg("          2: {{.*}} (b7) r0 = 2")
+__msg("          3: {{.*}} (05) goto pc+1")
+__msg("          4: {{.*}} (b7) r0 = 3")
+__msg("          5: {{.*}} (95) exit")
+__naked void fwd_edges_no_loop(void)
+{
+	asm volatile ("					\
+	r0 = 1;						\
+	if r0 > 0 goto 1f;				\
+	r0 = 2;						\
+	goto 2f;					\
+1:	r0 = 3;						\
+2:	exit;						\
+"	::: __clobber_all);
+}
+
+/* Case B + D: two sibling inner loops within one outer loop. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("          0: {{.*}} (b7) r0 = 0")
+__msg("  1       1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")
+__msg("  1   1   3: {{.*}} (07) r1 += 1")
+__msg("  1   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")
+__msg("  1   1   5: {{.*}} (b7) r2 = 0")
+__msg("  1   1   6: {{.*}} (07) r2 += 1")
+__msg("  1   6   7: {{.*}} (a5) if r2 < 0x5 goto pc-2")
+__msg("  1   1   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
+__msg("          9: {{.*}} (95) exit")
+__naked void loop_nested_siblings(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	r1 = 0;						\
+2:	r1 += 1;					\
+	if r1 < 5 goto 2b;				\
+	r2 = 0;						\
+3:	r2 += 1;					\
+	if r2 < 5 goto 3b;				\
+	if r0 < 10 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Three levels of nesting. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("          0: {{.*}} (b7) r0 = 0")
+__msg("  1       1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (b7) r1 = 0")
+__msg("  1   1   3: {{.*}} (07) r1 += 1")
+__msg("  1   3   4: {{.*}} (b7) r2 = 0")
+__msg("  1   3   5: {{.*}} (07) r2 += 1")
+__msg("  1   5   6: {{.*}} (a5) if r2 < 0x3 goto pc-2")
+__msg("  1   3   7: {{.*}} (a5) if r1 < 0x5 goto pc-5")
+__msg("  1   1   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
+__msg("          9: {{.*}} (95) exit")
+__naked void loop_three_levels(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	r1 = 0;						\
+2:	r1 += 1;					\
+	r2 = 0;						\
+3:	r2 += 1;					\
+	if r2 < 3 goto 3b;				\
+	if r1 < 5 goto 2b;				\
+	if r0 < 10 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Loop with an if-else body (forward branch inside loop, Case C). */
+SEC("socket")
+__success
+__log_level(2)
+__msg("          0: {{.*}} (b7) r0 = 0")
+__msg("  1       1: {{.*}} (07) r0 += 1")
+__msg("  1   1   2: {{.*}} (bf) r1 = r0")
+__msg("  1   1   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
+__msg("  1   1   4: {{.*}} (b7) r1 = 1")
+__msg("  1   1   5: {{.*}} (0f) r0 += r1")
+__msg("  1   1   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
+__msg("          7: {{.*}} (95) exit")
+__naked void loop_with_if_else(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	r1 = r0;					\
+	if r1 > 5 goto 2f;				\
+	r1 = 1;						\
+2:	r0 += r1;					\
+	if r0 < 100 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Case E: irreducible loop. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("          0: {{.*}} (85) call bpf_get_prandom_u32")
+__msg("          1: {{.*}} (b7) r1 = 0")
+__msg("          2: {{.*}} (25) if r0 > 0x5 goto pc+2")
+__msg("  1       3: {{.*}} (b7) r1 = 1")
+__msg("  1   3   4: {{.*}} (05) goto pc+1")
+__msg("          5: {{.*}} (b7) r1 = 2")
+__msg("  1   3   6: {{.*}} (0f) r0 += r1")
+__msg("  1   3   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
+__msg("          8: {{.*}} (95) exit")
+__naked void loop_irreducible(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = 0;						\
+	if r0 > 5 goto 2f;				\
+1:	r1 = 1;						\
+	goto 3f;					\
+2:	r1 = 2;						\
+3:	r0 += r1;					\
+	if r0 < 16 goto 1b;				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0
