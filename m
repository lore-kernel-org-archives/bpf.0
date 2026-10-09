Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637974C650E
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542950; cv=none; b=OQJVW6K2YaHAi3T1yvmVhZ6YWYuIn4kT8aSdF3yug2MELn3shg6utr7sXR53MLRcQgUsx2aW6wbyiKe023T0VK53CFDuGZWSOsdimlCogULu7YF2sAS7xEotk/+MqX6x744jdOONuY0++fc0838yoSib0PpZP5vSmZV3lzBnDsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542950; c=relaxed/simple;
	bh=tHAHn1EwuED5uEYjdG8sScJpNkyRGTaYawfGidtWE48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruYdszHjprvdAVfDjAXZZZoB80CsrOyxOj1cywKxO1zRuxdxzC1kPnzFUXA1UEMgJVIOCN9BU0Xh9hqYgGo6c7FxRLEl+ZpJAGwHXAtht7bSbh9dLxRsNFqynV0/zByPZS7A9QaYtwBHra0LJ9d/QzUSYJk8UcTn81lQeXyaYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4VSO9la; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4VSO9la"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc758830601so4223267a12.2
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542936; x=1792147736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=igxLyAUBOgxYcRJ2gb75skxPC7Hc6dMZt13SMnkNjhA=;
        b=d4VSO9lasy7DbCAHn1q/Ys6VOO1kvBotRaZ5vVyaoOpOFJ92XRe32McjdE3PG6K7C9
         7gGaoQfqaId8CYMuUQiQFCRd/gVcgcbWvEAetBhHK2Lv6WbwCYtI3hJN5QkayCpcsY3n
         9K+R0dgW+i5JN1wR9dL0l14XivbutySV//rvVreemcu3EGnLHPZQCFLYTT2Y+fzlKhg8
         JJaJULcuXIy2kJKrnYrDhEraZNsySn94Y5XU/0RQ7O/87m8pHFDGJ7YNaxLIz41ah1Zb
         Ka3z7dtzCxVMLRhVsMdu2Res5r7z2YnKze4S29LQhp1S257n+7GugM4IBFDjkQIHKyiG
         Zlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542936; x=1792147736;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igxLyAUBOgxYcRJ2gb75skxPC7Hc6dMZt13SMnkNjhA=;
        b=orUYe/EwFlyrrSP8hVI8rhNwSeQRSY1AmAd7ndfcc2aPCOLNCSbZgMweN5Pzmaa+Qn
         LSqY3eJgOo29s5d+vW6i3ScclZPwD7L9lq5eNtPAbr4qwrKFU9tyJGXF5jairHAfezty
         zqqnqy9ZNfpkLvOjJd3JvOQvqAgN4hMtE2rYznTnwivMfkA+yXISgJmG3Uk2OwjpraMD
         s0CaKAe5AxnBRbC8/rUcltWwHIWoJkCv1cxXbgUgwlUb3PbJiDxYZgaOunyCqWMUNfjr
         eelnZeg+upBoyNE9itgFocdTgsJ/mSq7xM1hOmCeovvush47rAjkSA8UdqEExwUdMfwn
         McGA==
X-Gm-Message-State: AFq9FYJlkY0FA9rK/Q4LiackgA6CbXP5yCupR+7bx3Q0aoch4GZFSrv9
	B6GMJg6FE0yASewYdFzB23PsBvNhwqlIbqTAWz0Z6u9L+0gKOYBYjSn3ZcCTqEwo
X-Gm-Gg: AYBFou1Aiv2qiprPKfzWSjq9OQqoD+D3mWFA4e51gnRL8JcR4IKdms4hClbYHafrIM5
	JfqvM19oLTEdFaVEdPXaxMKSopsDjaQnLW/bJDB1m8Canm8qK3nIUeRbcyvOZ1wyPmeL1nWsyKF
	KIcw246iSBdxRkKqVKh1IBG1U6xnx4SnuVfvIeQhlUzP7xTc0qjwYzIcEYFTA5Boz6EEAYiOhnw
	z9UhNyoNcgnYxBv8pwPk/FF3lep5UCAp67kMKr2REZivzWA3QT7Rp/oo8ReVNNrE5UkX9dpZelQ
	JecPSS6jsLKurleqpylk1BLNDj34tdURVupgw6Jbr+pbLo/jMSVnZwIN59vdOZPDl6PAAagD3BJ
	SbPPCj1PY6cRDQ2+r+j3ZGCndjC0TVc/h85dzGSOSvhKJQ5kGpJfYZQaghEscJ2lrnmCKSOsQc+
	w5fjYZs8LBchS6mJs+qr8l8Vim96ixkSPozmQykK93+ms0fZEDin7AkPGxXTrkX4uie0PynLFTo
	dPHQNd7ZnKErP4=
X-Received: by 2002:a17:90a:51a7:b0:3ab:3e1c:3c34 with SMTP id 98e67ed59e1d1-3ab3e1c3dc8mr886711a91.51.1791542936435;
        Fri, 09 Oct 2026 03:48:56 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 50/51] selftests/bpf: tests for immediate dominator computation
Date: Fri,  9 Oct 2026 03:48:08 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-50-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Coverage:
- straight-line code with an ldimm64 in the middle;
- an asymmetric if-then-else diamond (unequal-depth idoms_intersect());
- a simple loop, a loop with an if-else body, and nested loops;
- a loop header with two back edges (three predecessors);
- an irreducible CFG (fixpoint convergence);
- immediate dominators across subprogram boundaries, including a callee
  whose entry instruction is itself a loop header;
- a self-loop;
- an indirect jump (gotox) with a two-entry jump table.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/verifier_idoms.c | 377 +++++++++++++++++++++
 2 files changed, 379 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6b60d7720e2a..b45916e04fef 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -58,6 +58,7 @@
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
+#include "verifier_idoms.skel.h"
 #include "verifier_int_ptr.skel.h"
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
@@ -246,6 +247,7 @@ void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_
 void test_verifier_helper_packet_access(void) { RUN(verifier_helper_packet_access); }
 void test_verifier_helper_restricted(void)    { RUN(verifier_helper_restricted); }
 void test_verifier_helper_value_access(void)  { RUN(verifier_helper_value_access); }
+void test_verifier_idoms(void)                { RUN(verifier_idoms); }
 void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_idoms.c b/tools/testing/selftests/bpf/progs/verifier_idoms.c
new file mode 100644
index 000000000000..fdee6bced77b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_idoms.c
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+/*
+ * The immediate dominator is printed by log_program() as the numeric column
+ * immediately before the "<insn#>:" field of every "Program dump" line:
+ *
+ *   Program dump (scc? loop_header? idom insn#: live_regs_before):
+ *            -1   0: ....... (b7) r0 = 0     <- idom(0) = -1 (subprog entry)
+ *             0   1: ....... (07) r0 += 1    <- idom(1) = 0
+ *             ^^^^^^
+ *             idom insn#
+ */
+
+/* Straight-line code, with an ldimm64 in the middle. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (b7) r0 = 0")
+__msg("{{.*}}  0   1: {{.*}} (18) r1 = 0x1122334455667788")
+__msg("{{.*}}  1   3: {{.*}} (07) r0 += 1")
+__msg("{{.*}}  3   4: {{.*}} (0f) r0 += r1")
+__msg("{{.*}}  4   5: {{.*}} (95) exit")
+__naked void straight_line_ldimm64(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	r1 = 0x1122334455667788 ll;			\
+	r0 += 1;					\
+	r0 += r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * Asymmetric if-then-else diamond: the "then" arm is 5 instructions long, the
+ * "else" arm is a single instruction. The merge point (insn 8) is dominated by
+ * the branch (insn 1), not by either arm. This forces idoms_intersect() to walk
+ * the two predecessors up unequal postorder depths before they meet.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
+__msg("{{.*}}  0   1: {{.*}} (25) if r0 > 0x0 goto pc+5")
+__msg("{{.*}}  1   2: {{.*}} (b7) r1 = 1")
+__msg("{{.*}}  2   3: {{.*}} (b7) r1 = 2")
+__msg("{{.*}}  3   4: {{.*}} (b7) r1 = 3")
+__msg("{{.*}}  4   5: {{.*}} (b7) r1 = 4")
+__msg("{{.*}}  5   6: {{.*}} (05) goto pc+1")
+__msg("{{.*}}  1   7: {{.*}} (b7) r1 = 9")
+__msg("{{.*}}  1   8: {{.*}} (95) exit")
+__naked void asymmetric_diamond(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	if r0 > 0 goto 1f;				\
+	r1 = 1;						\
+	r1 = 2;						\
+	r1 = 3;						\
+	r1 = 4;						\
+	goto 2f;					\
+1:	r1 = 9;						\
+2:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Simple loop: the header (insn 1) is dominated by the pre-header (insn 0). The
+ * back edge (insn 2 -> insn 1) must not change idom(1); the back-edge
+ * predecessor folds up via idoms_intersect().
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (b7) r0 = 0")
+__msg("{{.*}}  0   1: {{.*}} (07) r0 += 1")
+__msg("{{.*}}  1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("{{.*}}  2   3: {{.*}} (95) exit")
+__naked void simple_loop(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	if r0 < 10 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * Loop with an if-else in its body. The in-loop merge point (insn 5) is
+ * dominated by the in-loop branch (insn 3), combining a back-edge intersect
+ * with a forward-diamond intersect.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (b7) r0 = 0")
+__msg("{{.*}}  0   1: {{.*}} (07) r0 += 1")
+__msg("{{.*}}  1   2: {{.*}} (bf) r1 = r0")
+__msg("{{.*}}  2   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
+__msg("{{.*}}  3   4: {{.*}} (b7) r1 = 1")
+__msg("{{.*}}  3   5: {{.*}} (0f) r0 += r1")
+__msg("{{.*}}  5   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
+__msg("{{.*}}  6   7: {{.*}} (95) exit")
+__naked void loop_with_if_else_body(void)
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
+/*
+ * Nested loops: the idom chain runs inner-header -> outer-body -> outer-header
+ * -> pre-header. Exercises intersect across back edges at two nesting depths.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (b7) r0 = 0")
+__msg("{{.*}}  0   1: {{.*}} (07) r0 += 1")
+__msg("{{.*}}  1   2: {{.*}} (b7) r1 = 0")
+__msg("{{.*}}  2   3: {{.*}} (07) r1 += 1")
+__msg("{{.*}}  3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")
+__msg("{{.*}}  4   5: {{.*}} (a5) if r0 < 0xa goto pc-5")
+__msg("{{.*}}  5   6: {{.*}} (95) exit")
+__naked void nested_loops(void)
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
+/*
+ * Loop header (insn 1) with two back edges (from insn 4 and insn 5), i.e. three
+ * predecessors. Both back edges route through the incrementing header, so the
+ * loop is bounded and verifies. Repeated idoms_intersect() at the header must
+ * stay stable and keep idom(1) at the pre-header (insn 0).
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (b7) r6 = 0")
+__msg("{{.*}}  0   1: {{.*}} (07) r6 += 1")
+__msg("{{.*}}  1   2: {{.*}} (25) if r6 > 0xa goto pc+3")
+__msg("{{.*}}  2   3: {{.*}} (bf) r7 = r6")
+__msg("{{.*}}  3   4: {{.*}} (a5) if r7 < 0x5 goto pc-4")
+__msg("{{.*}}  4   5: {{.*}} (05) goto pc-5")
+__msg("{{.*}}  2   6: {{.*}} (b7) r0 = 0")
+__msg("{{.*}}  6   7: {{.*}} (95) exit")
+__naked void multi_backedge_header(void)
+{
+	asm volatile ("					\
+	r6 = 0;						\
+1:	r6 += 1;					\
+	if r6 > 10 goto 2f;				\
+	r7 = r6;					\
+	if r7 < 5 goto 1b;				\
+	goto 1b;					\
+2:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * Irreducible CFG (loop with two entries, insn 3 and insn 5, reached from the
+ * insn 2 branch). Dominators remain well-defined; this is a convergence test
+ * for the fixpoint under irreducibility. Note insn 6 is dominated by the branch
+ * (insn 2), not by either arm.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
+__msg("{{.*}}  0   1: {{.*}} (b7) r1 = 0")
+__msg("{{.*}}  1   2: {{.*}} (25) if r0 > 0x5 goto pc+2")
+__msg("{{.*}}  2   3: {{.*}} (b7) r1 = 1")
+__msg("{{.*}}  3   4: {{.*}} (05) goto pc+1")
+__msg("{{.*}}  2   5: {{.*}} (b7) r1 = 2")
+__msg("{{.*}}  2   6: {{.*}} (0f) r0 += r1")
+__msg("{{.*}}  6   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
+__msg("{{.*}}  7   8: {{.*}} (95) exit")
+__naked void irreducible(void)
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
+/*
+ * Idoms are computed per subprog. Layout (libbpf preorder) is:
+ *   main: 0..1, sub: 2..7
+ * The callee entry (insn 2) must have idom -1 (subprog reset), and idoms inside
+ * the callee must reference only the callee's instructions, never main's. The
+ * in-callee merge (insn 7) is dominated by the in-callee branch (insn 3). The
+ * branch is on a prandom value so it is not constant-folded away.
+ */
+static __naked __noinline __used
+unsigned long idoms_diamond_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	if r0 > 0 goto 1f;				\
+	r0 = 1;						\
+	goto 2f;					\
+1:	r0 = 2;						\
+2:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (85) call pc+1")
+__msg("{{.*}}  0   1: {{.*}} (95) exit")
+__msg("{{.*}} -1   2: {{.*}} (85) call bpf_get_prandom_u32#7")
+__msg("{{.*}}  2   3: {{.*}} (25) if r0 > 0x0 goto pc+2")
+__msg("{{.*}}  3   4: {{.*}} (b7) r0 = 1")
+__msg("{{.*}}  4   5: {{.*}} (05) goto pc+1")
+__msg("{{.*}}  3   6: {{.*}} (b7) r0 = 2")
+__msg("{{.*}}  3   7: {{.*}} (95) exit")
+__naked void multi_subprog(void)
+{
+	asm volatile ("					\
+	call idoms_diamond_sub;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * The first instruction of a subprog (insn 3) is itself a loop header, i.e. it
+ * has an incoming back edge. Its idom must still be -1 (the subprog entry has no
+ * dominator). Exercises the idoms[start]=start ... idoms[start]=-1 handling in
+ * compute_subprog_idoms().
+ */
+static __naked __noinline __used
+unsigned long idoms_entry_header_sub(void)
+{
+	asm volatile ("					\
+1:	r1 += 1;					\
+	if r1 < 10 goto 1b;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (b7) r1 = 0")
+__msg("{{.*}}  0   1: {{.*}} (85) call pc+1")
+__msg("{{.*}}  1   2: {{.*}} (95) exit")
+__msg("{{.*}} -1   3: {{.*}} (07) r1 += 1")
+__msg("{{.*}}  3   4: {{.*}} (a5) if r1 < 0xa goto pc-2")
+__msg("{{.*}}  4   5: {{.*}} (b7) r0 = 0")
+__msg("{{.*}}  5   6: {{.*}} (95) exit")
+__naked void entry_is_loop_header(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	call idoms_entry_header_sub;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * Self-loop: insn 1 is its own predecessor. idom(1) must be the pre-header
+ * (insn 0); the self-edge is ignored (idoms[pred] == -1 on the first pass, then
+ * idoms_intersect(a == b) short-circuits). Program is rejected later for an
+ * infinite loop, but the dump (and idoms) are printed before that.
+ */
+SEC("socket")
+__failure
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
+__msg("{{.*}}  0   1: {{.*}} (a5) if r0 < 0xa goto pc-1")
+__msg("{{.*}}  1   2: {{.*}} (95) exit")
+__msg("infinite loop detected")
+__naked void self_loop(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+1:	if r0 < 10 goto 1b;				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_powerpc)
+/*
+ * Indirect jump (gotox) with a two-entry jump table. The gotox (insn 4) has two
+ * successors (insn 5 and insn 7), so both targets have the gotox as their only
+ * predecessor and idom.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("Program dump")
+__msg("{{.*}} -1   0: {{.*}} (18) r0 = {{0x[0-9a-f]+}}")
+__msg("{{.*}}  0   2: {{.*}} (07) r0 += 8")
+__msg("{{.*}}  2   3: {{.*}} (79) r0 = *(u64 *)(r0 +0)")
+__msg("{{.*}}  3   4: {{.*}} (0d) gotox r0")
+__msg("{{.*}}  4   5: {{.*}} (b7) r0 = 0")
+__msg("{{.*}}  5   6: {{.*}} (95) exit")
+__msg("{{.*}}  4   7: {{.*}} (b7) r0 = 1")
+__msg("{{.*}}  7   8: {{.*}} (95) exit")
+__naked void gotox_jump_table(void)
+{
+	asm volatile ("						\
+	.pushsection .jumptables,\"\",@progbits;		\
+jt0_%=:								\
+	.quad ret0_%= - socket;					\
+	.quad ret1_%= - socket;					\
+	.size jt0_%=, 16;					\
+	.global jt0_%=;						\
+	.popsection;						\
+								\
+	r0 = jt0_%= ll;						\
+	r0 += 8;						\
+	r0 = *(u64 *)(r0 + 0);					\
+	.8byte %[gotox_r0];					\
+ret0_%=:							\
+	r0 = 0;							\
+	exit;							\
+ret1_%=:							\
+	r0 = 1;							\
+	exit;							\
+"	:
+	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0, 0))
+	: __clobber_all);
+}
+#endif
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0
