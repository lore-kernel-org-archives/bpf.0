Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E6468C26
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432480; cv=none; b=UUTprDWvCjlnxYZCMXb56SGKgxC81PA+kOyUI32Ra4uRPeMK5binuyEvd0ivNhb1ynZGzIBblK+WliG7/Q9/mGN6GoqAb/YQAOIb3tdBvuGgj6le7C7JvWPWwkVdZMz/w7JPdBmgeGjh1YIMv7UOijjAIlGMVd21hvH87WXuq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432480; c=relaxed/simple;
	bh=SoCdNiYRRVGVL9cgerMR9YwKeXbuxq8GlE9Mylit9P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CA/OAWYfI8KnSaevKn5B1DF+1yUbHTeOh1pxmcYaOl9Dk0CWrImMpSFH4xZW3W74F23eVSR7A6vlY5hmd4L3dpDitBykNft9eC/c+U1st2/ORe7NeDBl4il23rnIT/ROr9cFg/tb15oTX7LcNxrxy7MoyTFxOzlSGkEZyyqH7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfhzoRE6; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfhzoRE6"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso863510a91.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432478; x=1791037278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/vXcKgg1PQXTMKQTmvcizD/IfTtWU/wpsyAzxVCeZU=;
        b=jfhzoRE6Q2sH34xhFpvIvXmGxHazwE8Zy9vhj/5IPWaqQC8NbuH44aA4ifoRGomr0R
         jZKGm/bfoVvbeNC75UTMRJBKJozy2QE1ghZtHQFVs+sChBqxN5ttgbeknCsbK3H+TRxV
         Jg4njIgGLM1VFdaBF9ImVsvZQCgibsljH8qt4Dztu8VwFbFtTgXhkXKEqAu5wdMBv+5B
         1LnxFsT/8a1Pa16rxoUWfWWXki6mX9mVpyO0P6DAfWO4IHWxSjQPMXR05ffj2+u1Tz23
         pB0uw9IvxPSMAq5JBzy8MYNJF0sCGxN9iGt/YRjiERiguHsiM5J18+90qEsJGI/AyyPI
         z8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432478; x=1791037278;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/vXcKgg1PQXTMKQTmvcizD/IfTtWU/wpsyAzxVCeZU=;
        b=GMdAQxJDz7+N+l4k4uiRm19AGnyHZYVGkQYJif0zYUjpHEjonFPHvWxkfaBpSRKEUM
         7QgtdLzsNBAcQjQd6LRQHBN1QS2Sn/7Iim2HMEGbZYt8Nx3h8de9URp2wRFXhF8+tFMY
         hVgqlOUC8v2gI+rPN1jGwAr0msuc4VRm32EEwrWrKZYA53LsG+I8MLNBNGglacv9SIvz
         fyaTqglFy43ujHty+rr0E2eCV0hxxRwqlSuWEdaIadQY3Ku6sqkRMceNtxYZjFFBcf4R
         Z/OCU5zBBRGZWyRw4dQFsRDq7+DnxnsODnVdrzPEfI3qLtViVYA17A0E3cfhLHM6xM3/
         w3nA==
X-Gm-Message-State: AFq9FYKztxSGRQFYMGRe+H84bC/VUZrTU4ijgHNRf9DrLcX4vxcAUvWr
	AGcRJqOaorEcmacpZFYCYZ97+UyAgFi4/gBKmShETMnRdgWqiU1NlWUQtFrGznB68NQ=
X-Gm-Gg: AYBFou1mJbJtD3XvlJF0++aT1BEEesejoAZ8I8Qkra80qRtlxW940d4Xh6El2PV/6Es
	h8gu11TSevhKJJ3UbPy8IfmrFurWvf62WuehPiakhYOR7RACTC7aA45ZTUTma5mq/hvL4nD+eS4
	IV0HwAk8Dm/6jLzM4cHE/2wUJ3uz1jPTglY+bccH/Bc0YrKhTGFNkkU7tr3s0+xm9Qn8wIJEvhL
	MSgzODEGCudBB7pENJOUgwKMogxsR6mGPAzFdeFK3KRIDt92IKFCkHdHn9T6HygVc5VmJMbNGaI
	lsj+9RwoXt6ZCViZwHj7u49MbpyJK1c3Fb/HjbZtu3m44w/AQVzXZZuYUNAt0+A2tCbCzGjx7JF
	WyqAryI+I8Mxbwf/3p2umagN8hv5WGEewRSxuFLoZqoHyjaHVp0YXF1TN91CGviQSz9BpQqW5Nt
	HdNgrY0RmYLnNPfDkKjj7qHJef5RYJ7tSo8Efa4N23uP2Bxhk7eYMelhXadUXtfbyWlRP7/KW82
	ZJDoDg7nZBTAguK4NjoEQJ4zgngD7oIb5R6QexkaA==
X-Received: by 2002:a17:90b:5286:b0:3a0:cc46:a0ff with SMTP id 98e67ed59e1d1-3a0cc46ab12mr2150843a91.38.1790432477923;
        Sat, 26 Sep 2026 07:21:17 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:17 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 34/36] selftests/bpf: tests for loop hierarchy computation
Date: Sat, 26 Sep 2026 07:20:32 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-34-c8e5ab5ba79f@gmail.com>
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

Test cases covering the following branches in bpf_compute_loops():
- Case B: simple backedge creating a loop (loop_single)
- Case B: two independent loops (loop_two_independent)
- Case B + D: nested loops where the inner header's loop_header points
  to the outer header (loop_nested)
- Case C: diamond CFG with no loops (fwd_edges_no_loop)
- Case D: sibling inner loops within one outer loop
  (loop_nested_siblings)
- Three levels of loop nesting (loop_three_levels)
- Loop with an if-else body containing forward branches
  (loop_with_if_else)
- Case E: An irreducible loop (loop_irreducible)
- A self-loop (loop_self)
- A test with sibling loops nested in outer loops
  (loop_nested_siblings_common_ancestors)

Cases B, C, D and E are described in loops.c:compute_loops_in_subprog().

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  | 317 +++++++++++++++++++++
 2 files changed, 319 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 9f188ff9be89..be4fd187ba5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -73,6 +73,7 @@
 #include "verifier_live_stack.skel.h"
 #include "verifier_liveness_exp.skel.h"
 #include "verifier_load_acquire.skel.h"
+#include "verifier_loop_hierarchy.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
@@ -259,6 +260,7 @@ void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
 void test_verifier_live_stack(void)           { RUN(verifier_live_stack); }
 void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_exp); }
+void test_verifier_loop_hierarchy(void)       { RUN(verifier_loop_hierarchy); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
new file mode 100644
index 000000000000..5c5bf5b44529
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
@@ -0,0 +1,317 @@
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
+__msg("loop at 1{{$}}")
+__msg("Program dump")
+__msg("         -1   0: {{.*}} (b7) r0 = 0")
+__msg("  1       0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("          2   3: {{.*}} (95) exit")
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
+__msg("loop at 1{{$}}")
+__msg("loop at 4{{$}}")
+__msg("Program dump")
+__msg("         -1   0: {{.*}} (b7) r0 = 0")
+__msg("  2       0   1: {{.*}} (07) r0 += 1")
+__msg("  2   1   1   2: {{.*}} (a5) if r0 < 0xa goto pc-2")
+__msg("          2   3: {{.*}} (b7) r1 = 0")
+__msg("  1       3   4: {{.*}} (07) r1 += 1")
+__msg("  1   4   4   5: {{.*}} (a5) if r1 < 0xa goto pc-2")
+__msg("          5   6: {{.*}} (95) exit")
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
+__msg("loop at 1{{$}}")
+__msg("loop at 3, nested in 1")
+__msg("Program dump")
+__msg("         -1   0: {{.*}} (b7) r0 = 0")
+__msg("  1       0   1: {{.*}} (07) r0 += 1")			/* outer loop header */
+__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")			/* outer loop insn */
+__msg("  1   1   2   3: {{.*}} (07) r1 += 1")			/* inner loop header */
+__msg("  1   3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")	/* inner loop insn */
+__msg("  1   1   4   5: {{.*}} (a5) if r0 < 0xa goto pc-5")	/* outer loop insn */
+__msg("          5   6: {{.*}} (95) exit")
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
+__msg("Program dump")
+__msg("         -1   0: {{.*}} (85) call bpf_get_prandom_u32")
+__msg("          0   1: {{.*}} (25) if r0 > 0x0 goto pc+2")
+__msg("          1   2: {{.*}} (b7) r0 = 2")
+__msg("          2   3: {{.*}} (05) goto pc+1")
+__msg("          1   4: {{.*}} (b7) r0 = 3")
+__msg("          1   5: {{.*}} (95) exit")
+__naked void fwd_edges_no_loop(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	if r0 > 0 goto 1f;				\
+	r0 = 2;						\
+	goto 2f;					\
+1:	r0 = 3;						\
+2:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Case B + D: two sibling inner loops within one outer loop. */
+SEC("socket")
+__success
+__log_level(2)
+__msg("loop at 1{{$}}")
+__msg("loop at 3, nested in 1")
+__msg("loop at 6, nested in 1")
+__msg("Program dump")
+__msg("         -1   0: {{.*}} (b7) r0 = 0")
+__msg("  1       0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")
+__msg("  1   1   2   3: {{.*}} (07) r1 += 1")
+__msg("  1   3   3   4: {{.*}} (a5) if r1 < 0x5 goto pc-2")
+__msg("  1   1   4   5: {{.*}} (b7) r2 = 0")
+__msg("  1   1   5   6: {{.*}} (07) r2 += 1")
+__msg("  1   6   6   7: {{.*}} (a5) if r2 < 0x5 goto pc-2")
+__msg("  1   1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
+__msg("          8   9: {{.*}} (95) exit")
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
+__msg("loop at 1{{$}}")
+__msg("loop at 3, nested in 1")
+__msg("loop at 5, nested in 3")
+__msg("Program dump")
+__msg("         -1   0: {{.*}} (b7) r0 = 0")
+__msg("  1       0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   1   2: {{.*}} (b7) r1 = 0")
+__msg("  1   1   2   3: {{.*}} (07) r1 += 1")
+__msg("  1   3   3   4: {{.*}} (b7) r2 = 0")
+__msg("  1   3   4   5: {{.*}} (07) r2 += 1")
+__msg("  1   5   5   6: {{.*}} (a5) if r2 < 0x3 goto pc-2")
+__msg("  1   3   6   7: {{.*}} (a5) if r1 < 0x5 goto pc-5")
+__msg("  1   1   7   8: {{.*}} (a5) if r0 < 0xa goto pc-8")
+__msg("          8   9: {{.*}} (95) exit")
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
+__msg("loop at 1")
+__msg("Program dump")
+__msg("         -1   0: {{.*}} (b7) r0 = 0")
+__msg("  1       0   1: {{.*}} (07) r0 += 1")
+__msg("  1   1   1   2: {{.*}} (bf) r1 = r0")
+__msg("  1   1   2   3: {{.*}} (25) if r1 > 0x5 goto pc+1")
+__msg("  1   1   3   4: {{.*}} (b7) r1 = 1")
+__msg("  1   1   3   5: {{.*}} (0f) r0 += r1")
+__msg("  1   1   5   6: {{.*}} (a5) if r0 < 0x64 goto pc-6")
+__msg("          6   7: {{.*}} (95) exit")
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
+__msg("loop at 3, irreducible")
+__msg("Program dump")
+__msg("         -1   0: {{.*}} (85) call bpf_get_prandom_u32#7")
+__msg("          0   1: {{.*}} (b7) r1 = 0")
+__msg("          1   2: {{.*}} (25) if r0 > 0x5 goto pc+2")
+__msg("  1       2   3: {{.*}} (b7) r1 = 1")
+__msg("  1   3   3   4: {{.*}} (05) goto pc+1")
+__msg("          2   5: {{.*}} (b7) r1 = 2")
+__msg("  1   3   2   6: {{.*}} (0f) r0 += r1")
+__msg("  1   3   6   7: {{.*}} (a5) if r0 < 0x10 goto pc-5")
+__msg("          7   8: {{.*}} (95) exit")
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
+SEC("socket")
+__failure
+__log_level(2)
+__msg("loop at 1")
+__msg("infinite loop detected at insn 1")
+__naked void loop_self(void)
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
+/*
+ * Loops at 5 and 7 are nested inside loops at 3 and 1.
+ * The edge 6 -> 7 exits loop at 5 and enters loop at 7.
+ * Check that it is logged only as an exit from loop at 5.
+ *
+ *  0: r0 = 0;
+ *     do {
+ *  1:     r0++;
+ *  2:     r1 = 0;
+ *         do {
+ *  3:         r1++;
+ *  4:         r2 = 0;
+ *             do {
+ *  5:             r2++;
+ *  6:         } while (r2 < 3);
+ *             do {
+ *  7:             r2--;
+ *  8:         } while (r2 != 0);
+ *  9:     } while (r1 < 4);
+ * 10: } while (r0 < 5);
+ * 11: return r0;
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("loop at 1{{$}}")
+__msg_next("  backedge from 10, latch at 10")
+__msg_next("  exit from 10 to 11")
+__msg_next("loop at 3, nested in 1")
+__msg_next("  backedge from 9, latch at 9")
+__msg_next("  exit from 9 to 10")
+__msg_next("loop at 5, nested in 3")
+__msg_next("  backedge from 6, latch at 6")
+__msg_next("  exit from 6 to 7")
+__msg_next("loop at 7, nested in 3")
+__msg_next("  backedge from 8, latch at 8")
+__msg_next("  exit from 8 to 9")
+__naked void loop_nested_siblings_common_ancestors(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+1:	r0 += 1;					\
+	r1 = 0;						\
+2:	r1 += 1;					\
+	r2 = 0;						\
+3:	r2 += 1;					\
+	if r2 < 3 goto 3b;				\
+4:	r2 += -1;					\
+	if r2 != 0 goto 4b;				\
+	if r1 < 4 goto 2b;				\
+	if r0 < 5 goto 1b;				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.55.0
