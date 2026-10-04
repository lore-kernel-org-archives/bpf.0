Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B443991E
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121157; cv=none; b=iXjwNjm1ddLhUQGaxsn6b5LMerPnPkDsaMnapQ8QBHPzZk2qyGnCaa5MhSYQU8u1V1PzpeXUEMJWD9/dc4VjUcOSAJamvbDS2fohI9OeKD5r8ww1aSxFoa34Kyi7KDhAlEfgvbibIjiXiyZ0nA/HhY9UUS5YWFRx4TyS7xpU6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121157; c=relaxed/simple;
	bh=CoLpJnY/U8UHrxMr7TyrfgR2deZW70aoo8583eeGtN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVQwvNX8k/jLgOjiw8SUZZbnxXcH1bm07KjCqVMVYJD6S0CHBBwv1O7zE3ujoz8eFAcOdtGLTHkF/D2WmBIOa3keFUdQC89oKNAdIYxxhTYpX+/ySoBPpxIs+SWv58uaEKYmUNyA9/gqfZCo/7xGn1pMJ71ZIMo+AyCKApIalgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9tkc6QU; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9tkc6QU"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so291133a91.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121154; x=1791725954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FUoJpnn1M77NOLYHswFvMdQPJPT45n+QErnto7jEuKI=;
        b=F9tkc6QUiSgqn3S0oi/giiPTlx6VShUicfTR1Lzo/kdIGcRa3g2Hxm4WhAjRaaRPGX
         /dlXINRZBKfc69NdOGv0BTRNg+8ekXsIicjGI9H1kbqP5Skba+ulHODCZbfEsKf2/kQm
         NXjTNyqMwCgH0LXwqXH1Adq/BuFgsz0DkIvunOyJBRAGj2eVd+jHs64sjDQbOJ3XRNPo
         K1PP/Q1M8JgazxpqJnqwziGXquVTiYsxdIJIhesiXUDhUzX9m99YpYTgvvjjZA8Xm5S8
         hm42KyLQjjEndShwtWMfuYFbZQPNkYkRWSPsTn/CQq+wIK2T3bAjeZqVjR9XtWzLx4su
         X4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121154; x=1791725954;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUoJpnn1M77NOLYHswFvMdQPJPT45n+QErnto7jEuKI=;
        b=i8K4mNVuV/bMp4pUuJiutcOQkCoVdL30uvbcVOKu17aklyY9o4w4G8AMn8RFRTd8+l
         GA3sUG4NAMF1Xz4w+lqcGloH095c4HMeqS+bUsDlF/zZAKxgdZqC0U8kBVuT36HQmZtZ
         2xncMERZjk+wnUNIZIVhxjmTUgiWdgYmllV3fNecT6rHHTIfgCriQPwqXkAZlPI6cV/Y
         StvYJ1tJ8K8v8U7+YIVYdrMe7WnD6/ZlS0yXzJHWEsk0AisrEFdnl2OqfGhvpe2NW8v7
         nrLcvCZjdV+FIb9AGRhrNo65Oaf4CGPvGyzQmxXn8X5TnKd8lc/wQt1ubO6RL8FocZMO
         aQCQ==
X-Gm-Message-State: AFq9FYJZuylod245b34mSury6bnIkNRbi6WAfJueepwicDA1zlj/Yiru
	jdgrNk8nSuYUQoF4vPFSBGRxEQ8bNvRd2s06WiLnplZAaAVt/rAgdMZLvQ9tcw==
X-Gm-Gg: AYBFou3LCD4+m0ah5bPrebki++kk3y9hV5puagTh3qTG67RzHHaYYXjm9aUU96ywh62
	Z7z6ZsTjATPYaPqHTXvv9PpQsB0WpRZyKB+3EOV8ER6vlqHHAmXhD+2iDLiqfKJdfM64IrFW6l8
	VfuH1NMK3iXnCO2XPZEZJwYooYf5VGhVOwNZAQdAsW3KF3FHdUR2SzCxpGTpREbszW7AxrIv6pn
	ReD/aMBALOO8ijp4YaKuPENFprk9IpvO2jlHXJ8ndlJ7VEpA+xVev1jqwrSgtaEgnIGwbslVRso
	5v2Gf8RIDf4nu2/AqqoYCbfIErTezmHeHqtgucRmOatvkcJjiY86jbuZGOtK9uFaYUagCkaLzCr
	pqDzPzUzeNZyA2v93yoR0diiCEkaoN64FtZTdJjkKWEsBPjuOXI1YLPmaBn/HDEU3ew0YNwgXF7
	zn2m9l5+UxhU6YkR0RH3t3HQUdls/oXwlrSqdRlLUTGuWwcSvL3Bawbp5LySPhfmuapqwuefQ5x
	ibO3sTU8oJCi68=
X-Received: by 2002:a17:90b:528d:b0:3a4:e011:d26c with SMTP id 98e67ed59e1d1-3a6ce79670emr6290241a91.29.1791121154282;
        Sun, 04 Oct 2026 06:39:14 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:14 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 42/43] selftests/bpf: tests for immediate dominator computation
Date: Sun,  4 Oct 2026 06:38:24 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-42-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Coverage:
- straight-line code with an ldimm64 in the middle (exercises the
  bpf_is_ldimm64() skip in compute_predecessors());
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
 tools/testing/selftests/bpf/progs/verifier_idoms.c | 390 +++++++++++++++++++++
 2 files changed, 392 insertions(+)

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
index 000000000000..a29d6332baa4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_idoms.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+/*
+ * kernel/bpf/loops.c:bpf_compute_idoms() computes the immediate dominator
+ * of every instruction (Cooper et al, "A Simple, Fast Dominance Algorithm").
+ *
+ * The immediate dominator is printed by log_program() as the numeric column
+ * immediately before the "<insn#>:" field of every "Program dump" line:
+ *
+ *   Program dump (scc? loop_header? idom insn#: live_regs_before):
+ *            -1   0: ....... (b7) r0 = 0     <- idom(0) = -1 (subprog entry)
+ *             0   1: ....... (07) r0 += 1    <- idom(1) = 0
+ *             ^^^^^^
+ *             idom insn#
+ *
+ * The __msg() patterns below wildcard the scc/loop_header/live_regs columns and
+ * anchor on "<idom>   <insn#>:" followed by the disassembled instruction, so
+ * they assert the idom value of each instruction.
+ */
+
+/*
+ * Straight-line code, with an ldimm64 in the middle. Instruction index 2 is
+ * the second half of the ldimm64 at index 1 and is not a CFG node; the idom of
+ * index 3 must be 1, not 2. Exercises the bpf_is_ldimm64() skip in both passes
+ * of compute_predecessors().
+ */
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
+ * dominator). Exercises the idoms[start]=0 ... idoms[start]=-1 handling in
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
+ * predecessor and idom. Also re-exercises the ldimm64 skip: insn 2's idom is 0,
+ * the ldimm64 at index 0 (index 1 is its second half).
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
