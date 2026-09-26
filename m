Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919A438026
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432481; cv=none; b=NWDS29UYCAp6et+X1OWf/zVyAKoSo0bwzPByLqBwrrZGvV3y42cZ6QK6p0VkW7jXqZG1ZrZjLribBxQ65Q3gxcyg3KAuPni5/7CdLF/s8/VD3E4MKZGsjNpbYV4MMQeQCY8qbVpqi90Ae6s99xe714DtrfFkEAJEwzayx+dAaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432481; c=relaxed/simple;
	bh=/8yxSwy7ObTxuZQ1YRoQtCqpTXBb+PMh6LooNkg7R3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9fYeQeOUnHTyzZIAYJ/7ny4B5a9GXz3LM13seU5v/kmAJenYB18jYvaHWHWa3Hw6Vat+gZq092BDtvOe7MC4r01jGaBPcS8UUwOvP4mrf2/STlM3yg946xCLs8N+X72N7yN5jMf/peWrFQa38MWyz3BrxLqVxOrK1tBLNDbh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWyOOeHG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWyOOeHG"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so1154691a91.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432479; x=1791037279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8l0pHciPDKkooF3fqsq1yfSTpu6uZNQacsRoTqPJYcU=;
        b=mWyOOeHG1Zw7Yl8yYbxN7gK0yW+jlNiwrR1yUBm0rN2zNNLCekesK4O53tVvY85Ds7
         t//l3Xu4uXkrxkfJYuP4ZgK/Izhsyvb+5kFWrIOXNBslGwazgcM3/qEXr0eWmCSSxvb8
         EomHcNXrhpRSI0vXvKtEijPcVtqXpRr4hCEDk2qdGHpud6FMiAFp4RTUZr7aO47kyCEW
         6ZkDX4CrgtrSte5n9MiyCFDIpxXEt9JfKLZTQ0rmLnYaptjM9YkWuashhBFf8a25Vq+w
         RutzmlKqAkE9IN0xwli+kJTddxipk0lX/0bTuBtAGaCYonSogjkxg61D8aQnT+Yo7+1q
         MxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432479; x=1791037279;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8l0pHciPDKkooF3fqsq1yfSTpu6uZNQacsRoTqPJYcU=;
        b=BYkJZtPqKAUUCooZ4l8qQ8NtCzog7b3Lsy5h/H0BYkLW+zl405Jd7YcFaj2togf2QY
         HvhaKX02+Nnxr1XsBeOA/sdsC6kx3CTa2ELXP8TdsUG++VvIUa4yl+lnwD13OzMd11cz
         4XjsQzCoklDwX8/Iji1Sma4AJLzsV2CHjeRFJHXNTZ1YESV9mrkyOms2QPmB7wD6PmZJ
         atA/ioaxx+w+bivHDjR3+69AGeygPG5V7jPmi5vJCQqjUpulQN3wqgDUVpBRpw+SMFir
         n4Il3AxoS0iNgCCCgWIrrt80YwiGjEbHAtDAizqF+vtzLYcoRfKz6QJuCChww5FHOg6e
         Vdew==
X-Gm-Message-State: AFq9FYIxOQoVcHHLGBFmSkPN+yFJUQgVr8tXPuiAe52qNaHt0Wye+QVp
	7yGHrut9vxiTvs4RcvF5PLA3KjY7aCKaMxs84BLOp3rLDHEx71a4l+Vm8nNEZ3WfLr8=
X-Gm-Gg: AYBFou1yx/n03l8OzUdoqTHV5SDSv6IG6EqNsPl5GfVashB3K6B5p/IavUXicYoIS+Y
	Ds/hEesfL9QNDWonAcNgUP3/OKC1CC/paEFTMJ+cwYDn/lKPxs8Ii+vg8D/7v5W4oGNFxsrpcza
	GAbW7fR31iZuucYYc5nfPHcrPJxKT/V0LH8NLCYzJ7jtGzTocvIpdsyVJGaaBY13hKh20fdJU79
	K3OnnoyjzyxvAmGoXTOrdtEchYl45bwYyot+jUsWKI9VTtLqgDB+mlviH5nr+GhwvzSzmptXQOD
	IE5QFBITn/09RZ/yt6KvVH3ACN0fxThu87rfM6Y+D/oPQA6SW7OmfOlgwxVDNqJkL4WPXshYbfr
	hJLelv0zyDPS7WT5gM5c5g+vaxCuQ8sbAF14XZBVpMy/chzjcnOmSayxA0UYcb6T8WCbEHoh5Pn
	Xr796GEeHqR9sbNQ4EWhE0e+R2dIfHeSlRtTQxmU+DlI6nYkMXCeCchXh+vggxu2rligMGnvr+d
	VzZDzA8EK1zEvYLlcJc4Vo5OLDn3gGZvDT8oOmGsTBi1dNy1vQO
X-Received: by 2002:a17:90b:53c7:b0:3a0:eeda:39ee with SMTP id 98e67ed59e1d1-3a0eeda3e19mr754263a91.58.1790432478828;
        Sat, 26 Sep 2026 07:21:18 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:18 -0700 (PDT)
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
Subject: [PATCH bpf-next 35/36] selftests/bpf: tests for immediate dominator computation
Date: Sat, 26 Sep 2026 07:20:33 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-35-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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
index be4fd187ba5f..82b21ec472ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -57,6 +57,7 @@
 #include "verifier_helper_packet_access.skel.h"
 #include "verifier_helper_restricted.skel.h"
 #include "verifier_helper_value_access.skel.h"
+#include "verifier_idoms.skel.h"
 #include "verifier_int_ptr.skel.h"
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
@@ -244,6 +245,7 @@ void test_verifier_helper_access_var_len(void) { RUN(verifier_helper_access_var_
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
2.55.0
