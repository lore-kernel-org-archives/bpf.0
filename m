Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154E26ACC
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181842; cv=none; b=b3pwbvbHdA3VhigVEx7MH1GFky61dH7m/aRMI3R5qTHZmZ9duHVW4YW80JEniYgPFXlIbswAgXSr5FvKtaK3ucm76z1M3eQCQhjzXDYMlVG6ty9qhrcbRh3xY8Fgv3LFpBXHLFzn4d/rWbjSda+nCaCyhtb1T6kpc/BCSL7lpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181842; c=relaxed/simple;
	bh=NA9rDnj6NMI6q9BEUtTLSVP8y0avgf+lS6ncOMjP83U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dj6l3GFZ36kGcqnlDNSN42b0QYTPD+kjKKBZpCicK2DHS49d8bfaa0tAKWglj56LQMVII9x7kuBNJ+iBw0Bl4hrJEvNRz2iQPdPveHR643wbOQVPX11tBGMzV4WKQhz5/ZfQcruWOK2Bk/C83z+O9yP1KjV5bOPCp5fRF+jkevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pA4t0b1T; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pA4t0b1T"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so1271501a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775181840; x=1775786640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2yMb/L+V2Q6btalo3rKkwDQCra39DCIZbtjgayRfBs=;
        b=pA4t0b1Trxmn6APf5oDIML9BL7a6T8Th3DhBxXm0yZ5ag/Geyqh/zmNOMGSbVC3HFY
         DlbvDaPNjyg4F33qrespHoK4SEDk0Tcm8ssRwPtLxNvWP+m1ixkCM91rTPzjfdGBhUI0
         TVH1HO9z4aI8jyK3GHgdSdPQC5T3TTBYAvfnP30GhibUJny1k8718WC8qjoQerb2YWv/
         YGkKMJkJ/COPCX/73IwuGnGwnnOfhIxPrjGGPWrrHdMrvlU2jhSI4ArKkV8lpNqlN4+x
         g9RjFy0cJvog+Bk46E/1cQSoMwQB4CfpYjqTQrEkgZAtWdAZMH0r98rH1bD5bk0OtJim
         EMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775181840; x=1775786640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a2yMb/L+V2Q6btalo3rKkwDQCra39DCIZbtjgayRfBs=;
        b=tS+aY6wkMe/mckGPoxcExJ9tzoQX5v4sadyly3K/JR0oFkcTf1yrjnbBrpcPBByAXL
         pApS1IC6xIUU+nyzyIdp0baJE3/4aKVep/zH5ZXq97ixKWA5xAdQkinKQUIhzLBI9DDm
         jNFAILt/pIj1OyAtz8P2TU4x3F+U0DUlx0ZZoe9w5l/wRKdo3RejipyYt/YQ8AZUZCZU
         Ub9eJ9b8gBrB7oLjdJk1+p7YXM50YLkRfM30hMprmFnOXneYMCoB4YFbs4994osoZFZ8
         2YCe/clfkCos0VwyRXpv+8JTeV3/C6ODKmBdhtw4acujbdvCAvdCURNoNOxeMGppBJ/7
         Dhkg==
X-Gm-Message-State: AOJu0Yz91CqIYk6eANj26VuXrKF1CYNQJEtM0Pg1O1aXDHYBJRC+Hbmr
	/1X8GiYc+tvVt0Q7SLl8j0wD9E1EPtzKHtSQYnBNvzEv4tldxlXII9cMpj0rMQ==
X-Gm-Gg: AeBDiev85m2kPIYxTO9/1MLl/8d6ioOb8QBHiWfRI7J5p2e+mU39WD+mkr/e6lbx0fs
	6K8FAmgAD9SC6Xw4QGu5ifKt1a7L59lyW5IDi+wU3u0L9sh6LA8pwHa0Q+F5XAsSll/OgW+2fRu
	o7TBwRIxwf6VIaTZ5/toJE4aMPiRi4y79D4Pn9/OfekqBgVn3/MQRjzgLRTFpujw8fWZ9auptXv
	4UE3vtHB/kZxRokvtxpIrXLnjFNVTT8e01A6ks/OWuAFr9GB6whfUU4GSnSpB7WYQTALliYMGHg
	yPiIDDtrRPIv1l3EFErnS2cw63a0sECXubR8S4bW+AU1B0D+mvZrfLn1cTAXk5i3e7HxtPaCFbf
	zupgwvN3l1827PWJMC65+8e4BqzHZhii3ObSmq9TpuLCRJDX+OH6asEMFbGFuou9qHmP2fISiAD
	eAsqqk4+mx/jejpZwJ5gtkKleHW6VAdp4aFkPBUzO6tK/gOwB0Iyybqcv+kYZ/IiYOqvbSmQTCh
	BOjcMGEgS/w3ez3JOPg9r/V6GT7w80z5Ir1lembZGuiY6KGFhOC5+BYAqIjzA==
X-Received: by 2002:a17:90b:4ecc:b0:359:7c55:c166 with SMTP id 98e67ed59e1d1-35de67dcbe1mr991418a91.7.1775181840207;
        Thu, 02 Apr 2026 19:04:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de52a9819sm306187a91.5.2026.04.02.19.03.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:03:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v4 bpf-next 3/6] selftests/bpf: Add tests for subprog topological ordering
Date: Thu,  2 Apr 2026 19:03:47 -0700
Message-ID: <20260403020350.73823-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
References: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
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

