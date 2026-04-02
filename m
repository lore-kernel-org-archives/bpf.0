Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708693B38B3
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165348; cv=none; b=RBi7cToogL1anIezjDpi2Ey6lxwWLsRzg5SUT1WGEeoy1pqGRn2Nczv+33fh59wAbUktKhpCbDi94hRZOjnNX/kJfCWhD1/AT24vbY0LNeDBxBOlkD87Aq2wYma67T06/rYVd7ckCMkfuLh91mYhXJKKAD6267tzUYcwnJSNx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165348; c=relaxed/simple;
	bh=NA9rDnj6NMI6q9BEUtTLSVP8y0avgf+lS6ncOMjP83U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDR6aPZgDoD/xfVZ91aB/WJrQxjDDJ1jmJR0bfEjubuk52dL+pesLBCyMejNds+a4rgTj65kksC4/dug0a/rvWc7/isMdhG4tcva7r65/XPU+rYahJZi4UxjTuFXibrWcuo02ewpwPuGt04QU1N718nLHlpXil4V7r9YZn/HhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L96a4niX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L96a4niX"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82cd98be655so919617b3a.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165346; x=1775770146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2yMb/L+V2Q6btalo3rKkwDQCra39DCIZbtjgayRfBs=;
        b=L96a4niXRKcrRbG3E9RDfmSVLDcOCI462itCp3QWE6yorTtSDeBOumj25Y4hvs/+zJ
         i1CEJgD1hYwFshq6edcKVeEnkEiLxudSTVBZTrN0LqEBz7nJtjaJpJKTXWtOsY6H43SC
         XEtCPZrOlROM1+s4ZcPWMQq37Itv34XouaBHI5tZCJ6ZkoH29ID/ZgVw53eq+M68S7C3
         881UJhIcQzCT90EYCf+612phWD9fklFGfQ49+mfSZFR7Qx2vJ97NCVjL3M53fbo86VrO
         /KgiSVz5g3ftQ1Gu9Es4Kh+BHX0xNk56zZ4pPO9NWnRVOPLoEOYV/piovGUTdQBjhhsB
         QL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165346; x=1775770146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a2yMb/L+V2Q6btalo3rKkwDQCra39DCIZbtjgayRfBs=;
        b=UmlEFQ3ISQOFifvQDraA6gNrVK03eo+QS6KukdQqOatja34yBL1xYMcrIRMxXQDyTb
         B9TNxwZiJOjJBXrn3efP4Jnm18JKXsoM9uffPsC/psICRLt2NIHv24D9ogkMXgLMZme+
         JWCylEIM9qZD31QIIuujZK7kqBRPMWX6PxdabA9p+XCbOpl2xJYLJcNRbcY7T/RnqB2o
         KvIZMRvM25WRSYjumYBn3rtIRW72ORPRLBclMU+rlLZ+SiYW1+Rqdc4HKPNgTNK7OJQW
         CTHb/4Js9D8JFMifjNLjxUSlEWrqJnfdsckeyCKrpsUi21fhdUb7iBP6yGfWUhq/uUbD
         9JdA==
X-Gm-Message-State: AOJu0Yyn2rh0462vlv4SIjK/PfmU9tAlTbRggzA+WXfLKgb8nZBvv8d0
	XDqN7NycTaHOPXer8wtgbirTH0CchsFFZQGUHsiXxNGEp7PjPmdV7wAwdC/Zxg==
X-Gm-Gg: ATEYQzwgL73bttl2smLe8fqcWOSEVT9uoa9xyqo0XmAo+TfpFhpIxFPaPyfhUsrUKrY
	eF4pMZGI+7IF2BCLDfZVLurtra3KkQJ953d5uydw2tr7VR6U786rvZEG4Q1C3GnZ3tACMy62Kfv
	0L3OrXUoZAmOV/E2AgSdmy3ikcP4EayROQw02bP9kE140X18jM/x/6IA0LY4HaqROppFEEEmK3s
	Q8wX30LMn8VQ7Fsz2xtRmdrpvO576inBVKJyMgRg0WBPzbmUWhApKLw4PkgU2KpxhNi7Zr9W3Xb
	XyCULWfguhG7wtYuuun097eDOqVet/ERwOYxi31dL80K0CUoof9EpHo8UoHx0Rl0xlBAG4Iaj/j
	NVvaMoF5NNIeKEE6Qb5pqthsJhbsBlTOGJoftde0lvH+TxteO7tWa/Ix5QmY/dm6lFMxJ75gK3t
	TH0AD54eRaPq3dDiYqwg1U0agcWYKk5AWTpreNawHSEa+7F4SSHUMupPNPbiKFSpTSGgNHceAej
	4L0EMjUu8MMU5v44XZi+ZsyPWtO4Wn3bq7F9C0/+aYh5WwGRN5YKkjz9oXEUA==
X-Received: by 2002:a05:6a00:92a5:b0:82a:1428:da3c with SMTP id d2e1a72fcca58-82d0db7dd90mr647860b3a.35.1775165346239;
        Thu, 02 Apr 2026 14:29:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c747fdsm3956510b3a.50.2026.04.02.14.29.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 14:29:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v3 bpf-next 3/6] selftests/bpf: Add tests for subprog topological ordering
Date: Thu,  2 Apr 2026 14:28:53 -0700
Message-ID: <20260402212856.86606-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
References: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add few tests for topo sort:
- linear chain: main -> A -> B
- diamond: main -> A, main -> B, A -> C, B -> C
- mixed global/static: main -> global -> static leaf
- shared callee: main -> leaf, main -> global -> leaf
- duplicate calls: main calls same subprog twice
- no calls: single subprog

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_subprog_topo.c         | 226 ++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_topo.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index bcf01cb4cfe4..1ac366fd4dae 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -93,6 +93,7 @@
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_store_release.skel.h"
 #include "verifier_subprog_precision.skel.h"
+#include "verifier_subprog_topo.skel.h"
 #include "verifier_subreg.skel.h"
 #include "verifier_tailcall.skel.h"
 #include "verifier_tailcall_jit.skel.h"
@@ -238,6 +239,7 @@ void test_verifier_spin_lock(void)            { RUN(verifier_spin_lock); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_store_release(void)        { RUN(verifier_store_release); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
+void test_verifier_subprog_topo(void)        { RUN(verifier_subprog_topo); }
 void test_verifier_subreg(void)               { RUN(verifier_subreg); }
 void test_verifier_tailcall(void)             { RUN(verifier_tailcall); }
 void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_jit); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_topo.c b/tools/testing/selftests/bpf/progs/verifier_subprog_topo.c
new file mode 100644
index 000000000000..e2b9d14bbc3d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_topo.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* linear chain main -> A -> B */
+__naked __noinline __used
+static unsigned long linear_b(void)
+{
+	asm volatile (
+		"r0 = 42;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long linear_a(void)
+{
+	asm volatile (
+		"call linear_b;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("topo_order[0] = linear_b")
+__msg("topo_order[1] = linear_a")
+__msg("topo_order[2] = topo_linear")
+__naked int topo_linear(void)
+{
+	asm volatile (
+		"call linear_a;"
+		"exit;"
+	);
+}
+
+/* diamond main -> A, main -> B, A -> C, B -> C */
+__naked __noinline __used
+static unsigned long diamond_c(void)
+{
+	asm volatile (
+		"r0 = 1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long diamond_b(void)
+{
+	asm volatile (
+		"call diamond_c;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long diamond_a(void)
+{
+	asm volatile (
+		"call diamond_c;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("topo_order[0] = diamond_c")
+__msg("topo_order[3] = topo_diamond")
+__naked int topo_diamond(void)
+{
+	asm volatile (
+		"call diamond_a;"
+		"call diamond_b;"
+		"exit;"
+	);
+}
+
+/* main -> global_a (global) -> static_leaf (static, leaf) */
+__naked __noinline __used
+static unsigned long static_leaf(void)
+{
+	asm volatile (
+		"r0 = 7;"
+		"exit;"
+	);
+}
+
+__noinline __used
+int global_a(int x)
+{
+	return static_leaf();
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("topo_order[0] = static_leaf")
+__msg("topo_order[1] = global_a")
+__msg("topo_order[2] = topo_mixed")
+__naked int topo_mixed(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"call global_a;"
+		"exit;"
+	);
+}
+
+/*
+ * shared static callee from global and main:
+ * main -> shared_leaf (static)
+ * main -> global_b (global) -> shared_leaf (static)
+ */
+__naked __noinline __used
+static unsigned long shared_leaf(void)
+{
+	asm volatile (
+		"r0 = 99;"
+		"exit;"
+	);
+}
+
+__noinline __used
+int global_b(int x)
+{
+	return shared_leaf();
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("topo_order[0] = shared_leaf")
+__msg("topo_order[1] = global_b")
+__msg("topo_order[2] = topo_shared")
+__naked int topo_shared(void)
+{
+	asm volatile (
+		"call shared_leaf;"
+		"r1 = 0;"
+		"call global_b;"
+		"exit;"
+	);
+}
+
+/* duplicate calls to the same subprog */
+__naked __noinline __used
+static unsigned long dup_leaf(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("topo_order[0] = dup_leaf")
+__msg("topo_order[1] = topo_dup_calls")
+__naked int topo_dup_calls(void)
+{
+	asm volatile (
+		"call dup_leaf;"
+		"call dup_leaf;"
+		"exit;"
+	);
+}
+
+/* main calls bpf_loop() with loop_cb as the callback */
+static int loop_cb(int idx, void *ctx)
+{
+	return 0;
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("topo_order[0] = loop_cb")
+__msg("topo_order[1] = topo_loop_cb")
+int topo_loop_cb(void)
+{
+	bpf_loop(1, loop_cb, NULL, 0);
+	return 0;
+}
+
+/*
+ * bpf_loop callback calling another subprog
+ * main -> bpf_loop(callback=loop_cb2) -> loop_cb2 -> loop_cb2_leaf
+ */
+__naked __noinline __used
+static unsigned long loop_cb2_leaf(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+static int loop_cb2(int idx, void *ctx)
+{
+	return loop_cb2_leaf();
+}
+
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("topo_order[0] = loop_cb2_leaf")
+__msg("topo_order[1] = loop_cb2")
+__msg("topo_order[2] = topo_loop_cb_chain")
+int topo_loop_cb_chain(void)
+{
+	bpf_loop(1, loop_cb2, NULL, 0);
+	return 0;
+}
+
+/* no calls (single subprog) */
+SEC("?raw_tp")
+__success __log_level(2)
+__msg("topo_order[0] = topo_no_calls")
+__naked int topo_no_calls(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

