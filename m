Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F043115B8
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110676; cv=none; b=qDaV4mYc5XT4quojcHsAJT/ykK3cxl9/744acl3RzDIF7WXamHI/Z+kqpYQK+6YQJZbQVOX+R1ksDkqjpavE5jysnVLEZlF8fVxhd4dJ5jlXXTxncYXEzc89uiWLUSElTsbzrXE0T496lVZ64ahMlO5gq7GqAFo80Vsa02h3opw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110676; c=relaxed/simple;
	bh=60XQshgs3asXoEYBHbuEusYSMyHahAFSVqekL/D73BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZpWbDRZhRCTUeUJUiyIf3/OBY8YaTbutp6zbAfPHqfxKIjMvNlkFru11Ih8CB5f/JzsyfKcN1T4FdT0sg3xwGQJasVk4b3AAyU2IIHw6vkJlFBDmwK7Q2nuol7jQUx1rtnpdYYHToJsqb5cYmaVNoxVUbfBoi5KvNtejLm4KJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSaHc+QV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSaHc+QV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2589c26e3so4121745ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775110674; x=1775715474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9VP3n029j4OryR/QOcxxxCrHoNnK5XiSetyhclPT1I=;
        b=sSaHc+QVOn0LWWiNbQAxfsOImBTpC2INeiMuZLsZgzRirkICh61ilBCNt9aUSc83Ax
         w6iR5Cxk5r+oGLbCF/1f3RwWr1G7aVpNW6wrWL+CCihId+wxjWJGUert2vGXZc9c+Ivj
         9RNyZxvWhpg5wB98GzMSuz+Ul1KHl2j3/FpWxKqxPNEGKObs5MzTibs9ljGQcw3YbvuE
         9AWhHEV11XRQaQl4c94NlHdUXwiiFBcWEnqPziQEIgxWb6v+e9DvZ8KCxW14gveGGdZn
         QGffDB+9FA06atcwmaYlyy+EITUtIh9kmYKQXaQxTBAHmfQnwSc1TGYzLS62ZeFHm0OI
         Is1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110674; x=1775715474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9VP3n029j4OryR/QOcxxxCrHoNnK5XiSetyhclPT1I=;
        b=EToKV54iwyFW6KvBmij+36cIhVp4611JDvLVKy+Hyi+31lPatZSTvBvLgbkxmQJz5K
         uG3ucvPIf+L8CHcE7tV7IJrh8uSbgnKhOGfbXWcBYD9bAU/9m5INg3JLtl4Dk6xiBy9s
         NaVrefC0CNrNR7t/UtTj3oOBfMPreGsovplg92+3CV+ioPuYs9ieJ0Hmz6VioM3jvZOH
         ItQlrbvkZVqgNrzhzuLkU5dMak0Xtfusnd6qoau1eQCPDi0BH6p4U/dRn1iqVjJCmLc7
         TXwUsTSHQ2/hb7WvYZZeAjNA+yVRUrBe9tOYT1cZL7D/GNalhwx17tngFCZnOqaFN9X7
         7gdA==
X-Gm-Message-State: AOJu0YwzRVCZIWVubE/AXYj9YpLP63Ep8Y1NJuYEoVYcsWjNIQapGR3D
	kRms5wyVWesevcur/CkY1tNXvV/YR0qSCs2IfmPlNeulM9ZlermbnvXSD/mAhg==
X-Gm-Gg: AeBDiesSO/CcWu8q/zJuAm5//Of85Kwc/P8Fxe0LDRPiXqA7ilAs2I0iKtKov20o+Uf
	SOIt275EYqM3fkA5ziwDVzasB7C8rYLhI+14gwzJko0FD9jY1NzDBgQk3RBmfC7eamcuqK9RcLw
	wJLAW+v3ygMDcOUjBxX9xzfpb5+EyXJmetgd4r7ky5iFiBlnJVLodRxMAwwcIhp6+i6IaUF6sI1
	s9F3nDqB1j0XPL06ptxoTRkgpvaqbhw4KFtVGS8uu40jY6JZgMSMtjXrJQylfY/WD8slyXW08qB
	ZokfM6L50EAvcOI1CfN8cPR9yLJ7YQ7/IoJBCUIwmeCyZePBkZZO4P5Yog0a9V13AMa3eDsSj3N
	MIs65novkuT68XmYvuJPJ9lbXQ2GwKey4tAkd9u+OKBfNK5CYEOVpt1q7FKjx77eqXI+kz6iVmX
	pRrEu83weBHwodhVfcVFnG/ZdP4EGONiXi/g+bIRReh1Gbr1YjyCfd/2xJPWNtfAlA5byVAxlhu
	mLGWZyyuVG5mBmzz0urdwsHtt1C6k0sKC0oD9YdzaLI/QtSVBIznC3ZZyJzFARkkqWD5/o0
X-Received: by 2002:a17:903:2a90:b0:2b2:501c:bc0 with SMTP id d9443c01a7336-2b269ae0171mr70817515ad.7.1775110673830;
        Wed, 01 Apr 2026 23:17:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ce29esm17453585ad.81.2026.04.01.23.17.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 23:17:53 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 3/6] selftests/bpf: Add tests for subprog topological ordering
Date: Wed,  1 Apr 2026 23:17:41 -0700
Message-ID: <20260402061744.10885-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
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

