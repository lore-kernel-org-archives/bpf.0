Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E03C4545
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867011; cv=none; b=O8DiJV7GLeWaTXXTF/b3/t4n2KtYFWygJOkqZ8mgADLSVXIce5Krnaudp5BpsW633PSFBW9PytAPG1XZv2l5dmV4smngcHTHbaN1xBq+z84YSG3WNu0p/g96bxAsrFBjIAAoXyBjilm7XjIYxr3O87V0CSEUd70guPXl0022OMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867011; c=relaxed/simple;
	bh=Mjsxo2olXXMAUDQh/NafahGd87S670Kk8RRyp9mJSyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyBbHqL5qz89Ho5XyE0ZOvNYmezob0Ofug7AiO8cnVP9eiri/hCxnP6ObV7GVJLELApypx6tLBRJygkI+Abd0bZSExAA+/q+GtAZdjqcMtLDw27Z4JFnrICso9lxiIpXlCUA1mGrfaCxOPQZ82mUdjukdGo5606L+TXSLFfOcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwct0avf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwct0avf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba928852a5so79630935ad.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779867009; x=1780471809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOPSHeBxHMbUBMPJOHsusulUxFzYakXUemD4yVZlOOo=;
        b=jwct0avfjDGsxFaz73hYE4EU4lvbwk1pXT4KccJg0fjy3aJhLvVu6/gCo2LTTvo29x
         9Bx5qaG3I0zTKaQG/7rQE9Gi4R161xoFMomzntz1bY+MIJu+tLsDBBh0J7HJ/+3/oqcd
         DCZnh6BEndNBlYDGKZHbSMosAjaTK3CJVu6PzWnXPnoArV2O9/gi3TfhSmkDHPNVicex
         UM5yR1zFvFtRH7MoTkK/V3OorSkPrWXTp1ifqZsIQPZysgS0n5PJt7IkyycC1LJeHZEr
         WfWMR8JzwNwVx47pQqci3OvZY5Z8jf4G1UUAJye5xBT6z2aQSbrQRZeL4H99Y8TFcAL8
         PgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779867009; x=1780471809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOPSHeBxHMbUBMPJOHsusulUxFzYakXUemD4yVZlOOo=;
        b=X7enkUqXSQeH3Nl2bnL+pYenX6/rh363XN7RwDL2Z/YihSKASRonhyUu1tebQSc4bx
         wa33+8/DJH8fayQuVdZAyWu1wtWgeJ5q/ZNXsuy3hVzW8yT7uPElLexRHhRV8Y03vdgo
         dATblFko5Dy80h9TdmXmVT/Lhjc5ArKTzbfJtD4koSolZ0M66K79VtWNr5pzOGqyxXch
         tkCYO5mChrs+kfTfYhEUAYiT7k/G2pcVe047yN1ZUeQ0frOzOA+Z3sZErklqYkze1s06
         YI3iu8y6o/WAjxew1l26DKPa+vIiYj0hp2K7lEhO7EGw8bdFehFmqxEcVyvuzKwUTA3F
         NUxg==
X-Gm-Message-State: AOJu0YwU8q0v8OGwLdXVqqk+5BL6pvCyqrzYeOvaO7H1v90LpJw2X6ef
	XYk/cPQZyf9rlaiA1xCZPC7wGoNYK+rYHwAEZBjLbmQs7cCyIz3isvOnRPcO9GUV
X-Gm-Gg: Acq92OH7PF750g9hMVi5tgKlUJY5WOC1ge48pqyh9sRMi7CnSI4FHPAMJ8RLn0CEZ5Z
	qWpSAe+dKVmne38oCkVkOEXFPyI/CBIC0X50/JcC3bMCZ0mjbXypBfxGRythfOYIbRZ7teRHCIZ
	qLCjErxbW4jH4Nfge+LrgoCbmGzLCPzisdqnYq+02j6wJ+n2rjCvGHGe+jX218vtGG2QjRhoVAG
	PzUvOP8Jp2QXjzlYJD0yMcg3yxThjHcTXmIOLlDezwk5vw/zQqggrgu+go5tigy/vismvaG8ok/
	KXnhp5s5ahRTEy5QYPVLrePSlNe2XJdJd1mjOHMW+uQeWyPTaeAOho8Eag0vHWY6tH25cg6ZibC
	EyGAPTiYS8GREuGLRGCApvFVTVmXR1wShDyM6FGgsJCPLqZVBC1DT1ot/P7WOe7rNZug8dQyNQY
	czFA+quRva/cuhUHsTvrwjDG/9S/gF8YJGJZAwrTYhQz8wMcSbw8M=
X-Received: by 2002:a17:903:15c7:b0:2bd:6cab:85d with SMTP id d9443c01a7336-2beb06ead0cmr259534775ad.3.1779867007567;
        Wed, 27 May 2026 00:30:07 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bed2061c59sm89242325ad.2.2026.05.27.00.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:30:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next v3 3/6] selftests/bpf: test cases for loop hierarchy computation
Date: Wed, 27 May 2026 00:29:51 -0700
Message-ID: <20260527-better-1m-reporting-v3-3-b3ede0588a75@gmail.com>
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
 .../selftests/bpf/progs/verifier_loop_hierarchy.c  | 233 +++++++++++++++++++++
 2 files changed, 235 insertions(+)

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
index 000000000000..84cabfa42485
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_hierarchy.c
@@ -0,0 +1,233 @@
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
+__msg("Program dump")
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
+__msg("Program dump")
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
+__msg("Program dump")
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
+__msg("Program dump")
+__msg("          0: {{.*}} (85) call bpf_get_prandom_u32")
+__msg("          1: {{.*}} (25) if r0 > 0x0 goto pc+2")
+__msg("          2: {{.*}} (b7) r0 = 2")
+__msg("          3: {{.*}} (05) goto pc+1")
+__msg("          4: {{.*}} (b7) r0 = 3")
+__msg("          5: {{.*}} (95) exit")
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
+__msg("Program dump")
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
+__msg("Program dump")
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
+__msg("Program dump")
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
+__msg("Program dump")
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
