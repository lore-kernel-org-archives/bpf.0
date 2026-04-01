Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860229408
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009808; cv=none; b=JLO9br41pWCq3ggiwXNSizZhAlha+N4Nx+VPb/d+4zdtuTwpQO82kYb51G4JZMK7/lI3d9QdsnoM0c57Weeahe/e6uPG0Fb4QSD8sZtjbM9JVL1gc52YVc9Nkh4zbCxjdi3wqYbC2D/BENa3qc2ATEER1RooPADhhx2pLcaYAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009808; c=relaxed/simple;
	bh=60XQshgs3asXoEYBHbuEusYSMyHahAFSVqekL/D73BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUh7bs1boo2NLcsS6p3e1h65fJQ/RMxfasZ9bb06JO/iF/jja+Q9P39RJZBQoe1VO9ZaL5ceJglmkD6MpCctWzNg2oVTJltKrFjaLFw1BohWfLK6I9iCEVgX0eo0zsHJEve/uvetK/KvjZh7IicEtLgv8lVw+Uz96OH8QDyFVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ru6Mni5K; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ru6Mni5K"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35691a231a7so3860383a91.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009806; x=1775614606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9VP3n029j4OryR/QOcxxxCrHoNnK5XiSetyhclPT1I=;
        b=ru6Mni5KGA0L/07B0aKQF+bUiPrp0CyYucbWIx7UrWtZf0mh2oW1g+ucUG43DVYtOW
         3HotInWUm/3mtZvW9B/WiR94EP3Ns8bWsYak1VgeWNp0ketqdgiGS0UahzTLh0CB7vHo
         Ms4yJWTTfDMOoznfwowMtmfshzQ11gY0XTTTRUKWZEfGh8OLisG2+KBRAI+ukvKB9rwA
         8rJnbcMNm9OCYS1xGgzE9lxlMKPzuRPNSbQAUyUXLggSUZ7GwhPQrhdVGmt0k3xJK3XK
         JBGXS/wrAU8TnnYzov1uM61cR6vmT5DIh3gNaPrZsZEBsxYfj7HGvqUMc3Qz6fhG8lpp
         wjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009806; x=1775614606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9VP3n029j4OryR/QOcxxxCrHoNnK5XiSetyhclPT1I=;
        b=fQvE3Rca/+BeH3DaS1Rn7z0dVsXXZ+AStZOhXbYS9007YWf9GH5YPoZjUpOjrOz+Jm
         5Seph7fioiswqw1dY9GEzP5EbLhqY/0rzl4QLXVoGqmaxmwgpSrNNsnfvSKHcOt+nTpu
         oBsrqJu5lvSn7MV85OW2YWGfvOhgUt4guaNjt0DdXCeYTdoVzPMkL0HhdDfgkJpEliYl
         bhVBk2fel1vg3TaExD1/dQoly/YvCn+fun0ZrYkgifUuMx9vFXwICEDZ1GT76uwrXhRW
         YPZ4ROKlcMbe/zc7XujpiiNw5z7hRItqPBd3DJlrXjqWf+rlhLmSJcpyVzy2CdjaAIAA
         BIxw==
X-Gm-Message-State: AOJu0YybwV83qjp6ch0sr0qpyyKlG9VA6YPkIykaL+t4ai8a5ylyUPOD
	Ti/f2nWivXLjZL5tViN++6ZwCYCuCeAYeV6CdvP8iFJNgVjzuYeXXsN/VFliYg==
X-Gm-Gg: ATEYQzyX1bGYxsTLHYWA4gGIbAoAo10Ekhh0KRlp18s7ig+1hwo5BfYMVy8SIy/ZstS
	nIMHyWPLeLjfqgNmwQ+yx2bq3MgMYOmzB2GrwaC/g0c1RkEJntcfLGWCv2CANK1u9hLshOrSpjM
	cdaxOoYg4JaA1aMM3d/jgMQVWbVx2C47O8w9dgvvidoQ80wPMWsYj8PBc9cil4AgZmcan6Uws7t
	FJK/C/5oIXdsmAwpASs7WdBIUNspToO2iEvpL81VHdNlRZ6IHKvD75+0EW2W3zB/BC/Jbj0FNtw
	la9KOPL1u4ZO0UbAK6dbZXYQhtOMVkIyb3aswUiL7eEhBOxVJ2hHheEEhYIJMZggHrsCc7MAMiN
	BFrHsOH8rrNuO7hlAawjDLhI2d6YeXdcP27xARBpCJu78y8oDHtJiMLMZfKOXf9rVR6tAAZmbRq
	1e8ItMqu0ZiDQDUZw61O7HMKdW+bcr7qs/SCp66tF7xCBgh+gRVa2aWNZNCzK1X2kAkg08Festd
	qHKIildb2E4dHVIzzKNd09561oBc32jDSe/rbcIRMPoAuhPHLhQStbNnBsZLA==
X-Received: by 2002:a17:90b:35c6:b0:35d:ac4d:3cb7 with SMTP id 98e67ed59e1d1-35dc6e2d018mr1601326a91.6.1775009805912;
        Tue, 31 Mar 2026 19:16:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe624756sm4119635a91.5.2026.03.31.19.16.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 31 Mar 2026 19:16:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 3/6] selftests/bpf: Add tests for subprog topological ordering
Date: Tue, 31 Mar 2026 19:16:32 -0700
Message-ID: <20260401021635.34636-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
References: <20260401021635.34636-1-alexei.starovoitov@gmail.com>
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

