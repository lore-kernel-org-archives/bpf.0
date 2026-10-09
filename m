Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CB4CDDDB
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542951; cv=none; b=Z2SfzyK+yBHrsjJa7CK9kg37kD790exoJlRIgA7Bza87X0cm/Od/98zCqQA3dyvrlIkBB8YvlgJHJni6QxcP1vwKBGFtSkFIIQ+8Qy3Bw32oQ4D50n4NW0sQ99ItPd+ncX81HUBHV7bUp8/mAn5lX9Utj3UG+xpRX3u/W3E6IyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542951; c=relaxed/simple;
	bh=aQbE38hrzIb7+x5hkRNw0pofnfnzFcZDNRwFEHSp3t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcqxvJ7BFN48Zmi1l+98vXxSr9bOBy6rQrDBG0wSWONJOfAKfrpDkzRQbycim8slvGmUjLNy8PxyqE8S6fu+Nkx3jiAbq3Pim7oxQF8MOkcjkviFKunEFkALSB5LyoFT/06bX5jzkBbxNUIGw4oAdbe/Kga0NQj56CIiO8ldilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/4RyUZ1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/4RyUZ1"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab62a8250aso75406a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542936; x=1792147736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xu1aJe8IUhlHGqIUr0J7pRIYq+e/M9NczP5vTDLXXfM=;
        b=a/4RyUZ1yjEIHLMYYOIKEEAsgRBXhuAi4uRAgBXC3Wjs/mOsEJlWJ9O+VWl5FfVpnf
         WpREi2pPJgO5GL6inLXKfG31yt7nEiE6L0w1xmOz9oHcBp//rplhFhorD20Zz1Qm/0Fa
         rFH8YFC6euqJPBW1kBrN6uqTSN9KVpIp121TzzgZFsFrorBegr3OmtX2vTDTjtYDwKKb
         EKBFXY1q2z7yDENEjhFsbrxMg1o22jMKiHk2xasH8CZO489n37baOLTi/8H9QL1jKqw9
         7HaHO3rupSxrZNPidJVYfxmjjoKmF6fJrGnQOaajUDm9iRacZGbj0ciMlRRK7IJ2v0tu
         0a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542936; x=1792147736;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xu1aJe8IUhlHGqIUr0J7pRIYq+e/M9NczP5vTDLXXfM=;
        b=g3gT9toAHOc9QHkTcuiEoJrxqlRmPi3/lVue0x16XQCDUrWGuzam9mPRqn+cjmQ9Ni
         YiEqVvp/43QuMB56c+xLxLoixZCZVpSnUHTYx33lju5r6OCNx1K+fKPpnk77muYqYIqv
         iDY59OqbwRCtDYbxnCaD0L5ITVCrPPo6Pp7nu+eBA7ALQSQvU8aHQIAhQ/xDFagvJW3p
         I2bauudJ+wBRO1fPAGHDHKsJNBhB8+55fLEP4L0dO3d/WCoNFHkURAArss4xQXgo7eZk
         B0/ciyuXi0o8waLb5kWnJvSkOYD9XF2IlEHn1z+C5QTPcjh8Hsxa5Cz2Kv8BCR000j1Z
         UKUA==
X-Gm-Message-State: AFq9FYK+POb3BlTNad+1plauwA9TbDPuFzoEr45RuSsWt9ZdDo/opBWE
	8YnfjWJWmYMikYPNBtMzvgpODpG0VhoKYksT7B4VPvbldxUB6Satg9g4J7lr5RGI
X-Gm-Gg: AYBFou0bJ1MdYEfwbZWz539nJsorqcnvptJZU1Bet8wsuZQ6IebY+q9qmygBhxJ3FAh
	CIE4ZaRydoa1R5b6gxca9+9x+75tfjcjxoNW/PAi/e7caxa4WnZXV2aTiu7cZTJH/W2TxGdd9PB
	jXGxVWX+tnOGEWqgVgeQccX3/9MbOsCkn95UjVNy9YprwreSWqc9wLxPoXtYWP3ARydCKnI+pxz
	GWZ0w1dDzmswSsaqZlP6dtcyzMx3zBoW8m34hrG+di3y6uYimY/3D9gdY6cMTqYCsLYpEnY7JB5
	F8vPVfFWal3uWjfyi2T/w/7p3CD4TQEljSLDbX/OJroRnoIqWco9ycEwW00QxkL7ShZutYNf5hr
	D+61NTYruZwMiWktpbrAhBoS7WNyfCXU0SQzgd6f/8Vc4X0xMPxm1Idr/QMZwveY5rbxVuUNRJN
	/NlkkoY0tevVGaNDZ4xZ0SNGznIhSKLJBDx5NXffT7lJkVcm2ryThVKPKAB52iM644mvT75yrt/
	Gk76Xwg84IX/PmH5A0F49CpuQ==
X-Received: by 2002:a17:90b:3810:b0:3a8:425:2b3c with SMTP id 98e67ed59e1d1-3ab3a998274mr1367898a91.34.1791542935684;
        Fri, 09 Oct 2026 03:48:55 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:55 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 49/51] selftests/bpf: tests for loop hierarchy computation
Date: Fri,  9 Oct 2026 03:48:07 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-49-bcba9bc53ac9@gmail.com>
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
- A test case with outer loop's backedge originating
  from an inner loop (loop_outer_backedge_from_inner).

Cases B, C, D and E are described in loops.c:compute_loops_in_subprog().

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  | 346 +++++++++++++++++++++
 2 files changed, 348 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 2f05a0ce829f..6b60d7720e2a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -74,6 +74,7 @@
 #include "verifier_live_stack.skel.h"
 #include "verifier_liveness_exp.skel.h"
 #include "verifier_load_acquire.skel.h"
+#include "verifier_loop_hierarchy.skel.h"
 #include "verifier_loops1.skel.h"
 #include "verifier_lwt.skel.h"
 #include "verifier_map_in_map.skel.h"
@@ -261,6 +262,7 @@ void test_verifier_leak_ptr(void)             { RUN(verifier_leak_ptr); }
 void test_verifier_linked_scalars(void)       { RUN(verifier_linked_scalars); }
 void test_verifier_live_stack(void)           { RUN(verifier_live_stack); }
 void test_verifier_liveness_exp(void)         { RUN(verifier_liveness_exp); }
+void test_verifier_loop_hierarchy(void)       { RUN(verifier_loop_hierarchy); }
 void test_verifier_loops1(void)               { RUN(verifier_loops1); }
 void test_verifier_lwt(void)                  { RUN(verifier_lwt); }
 void test_verifier_map_in_map(void)           { RUN(verifier_map_in_map); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
new file mode 100644
index 000000000000..0608e983d7fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * kernel/bpf/loops.c:compute_loops_in_subprog() distinguishes between
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
+/* Loop with an if-else body (forward branch inside loop, Case D). */
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
+/*
+ * The outer loop backedge (4 -> 2) originates in an inner loop.
+ * For now, latch should not be identified in such cases.
+ */
+SEC("socket")
+__success
+__log_level(2)
+__msg("loop at 2{{$}}")
+__msg_next("  backedge from 4{{$}}")
+__msg_next("  exit from 5 to 7")
+__msg_next("loop at 3, nested in 2")
+__msg_next("  backedge from 6, latch at 5")
+__msg_next("  exit from 4 to 2")
+__msg_next("  exit from 5 to 7")
+__naked void loop_outer_backedge_from_inner(void)
+{
+	asm volatile ("					\
+	r6 = 99;					\
+	r2 = 2;						\
+2:	r6 += 1;			/* loop at 2 */	\
+3:	r2 += 1;			/* loop at 3 */	\
+4:	if r2 == 3 goto 2b;				\
+5:	if r6 > 100 goto 7f;				\
+	goto 3b;					\
+7:	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.53.0
