Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77423491DB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184274; cv=none; b=F3M7f57JNhDZsy1zZsnBdkz3zXfzJnblDuGNYr//gjOV2UZB4TzLm3pICug1zyamQQCeNYsXzOivq1/2P7wGau5sIhXzwCkXNwqjsshI/HF859bCpmqsTz//9OrMnn9uTSv2yKA+sl1yDfsea8aXiIFkVYHl1tP6hRr7TWXgjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184274; c=relaxed/simple;
	bh=NA9rDnj6NMI6q9BEUtTLSVP8y0avgf+lS6ncOMjP83U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAyA9DEJctU2hUNHVnjzrJz6aFoEjhD+2WhjWGHnSV3Hzam3jfGrUAEUe04KGbYdIu+kYLwfsb6ldRt6qkxF0NhI1DTUM58t22NuF73+M1VdqvwhYfU6JTLpgGIlQ3u9y6bOLLkAik7UyCwcr1QY3Uq6qqMKz+Hw9LD2SSfSyrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWETsvbe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWETsvbe"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b23f90f53aso14112355ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775184272; x=1775789072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2yMb/L+V2Q6btalo3rKkwDQCra39DCIZbtjgayRfBs=;
        b=fWETsvbeyeMdkxA1EUmIvvbBPpH89YVrRpWFf8ifnR6SF7XnwIRm9NfQdi5jNcTa7R
         b5BPfj4sg54fYOQ/aNS+EdPcSjIU6GVnIKoUGx6McEUBKgq+lo5KulYungNEb7XI/Ynj
         +V11azepYgIXQ+fFG+YBdR5CVpxzjmoVl8f9cwSo4uXDkJqmwe8Hm1uSTFp45pZxJPF/
         Zij6ptr25LV2UDO5DBulmEkFBCbZO86wvuuFVqXGxhpuczaUZcbHWL0ivXGomQOHQRIQ
         J2ujTuaat7hfGaXTEcCW5yFz20j0xFfpAKqjmYe4P1atoxkdVzfACpc+thBmCfVQuXEu
         an2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184272; x=1775789072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a2yMb/L+V2Q6btalo3rKkwDQCra39DCIZbtjgayRfBs=;
        b=MyCpKWM/1tEIk9TmJ7J09qU8XiWf+fsIZw6jrYu8mgLyC07ZN6F/Ekdi8s9EguhmPa
         sqDvlKKD+xOXLLME7hQHdo8sQKuPf6TaBXk25Ry3PmLHg7YBTsqwnV9tLKpHJXQBCq2u
         5jyywkRbuu5nMEtw4gsJGFw/f2RwDKek5USG5Si7njuC0j0L0Ml93hVLC2b0/jc6WKAK
         n4yapJHEU5RzndSqemn/AUiLgiEHvHJceqN+frsJrXLRqwnMXhTpHXLSNOz+nr+DQikV
         /e/fkLccAsvBg5DQwQov3qSe3yZKEJw246Odd0/BOjtDqizfKC3MbqhNmlZUEyJvTpsS
         zfKg==
X-Gm-Message-State: AOJu0YzSfMhNG83P3iEn63Hcn2cXwI9zztnQ9vIijwpMLj94WDkEWiVg
	6HqtLVwIAKROAbMX3KtGKKPuYhPEo7uMLTqaYisAsSYJXuGO1x8YRc9nwgiBGA==
X-Gm-Gg: AeBDievtzXfFcW6p3u4D1DXAT1KrV2Rns/cEYI8nPowyC0/733cua8QeGc+aw8lE4h9
	qwTH+OrwnjOITQ5FkdlXMOv1EeUkXpx8bvPc3Mz4cNAxZ4mfbtVG7dXVeNgHlP93aD7xjTVMfyu
	seqn2gaS85UUIOcIqLeRnX4Q1UaHWVLYxOKCnnrt5ETYnLolBul45BObekuahr/ef0SSo8RSC8i
	e+Bmi2GfWrWYUDAglK3j6ZvpeoMfvimmTkHgXwpTrUBX9tXMtJo6ZajR5gfTQDYOjOVWHHEm80J
	esvJlVqXv+Gzx8sVZTxB1+NcnDwwqZByl4Qc2lCCR3n7MOsQxzMfwdTKTa7hZ2UayfaYYCsKSGm
	gC1xkD+X1SKymoWSsBBcPE/AtuS4Iu/bIIeID8wza4gWOfk/m5nHS1lEOxgIJdRxSnCwQfblMNp
	ZvTwqyL+NYpPYN9t6hRdG1OYnIcO8Qbpc1ZiUKDwWZ/nEQkVOgMotIa+hTF0lxUvjcE9Mq7oq7Q
	jOliIBSjL3q/HMQnSpa2KfudDDXmw10M6peazZeBTRr784i56J/bDprwZM3jQ==
X-Received: by 2002:a17:903:40d2:b0:2ae:ac0c:5a29 with SMTP id d9443c01a7336-2b281674f1emr15327165ad.10.1775184271727;
        Thu, 02 Apr 2026 19:44:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749e2e97sm56327285ad.82.2026.04.02.19.44.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:44:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v5 bpf-next 3/6] selftests/bpf: Add tests for subprog topological ordering
Date: Thu,  2 Apr 2026 19:44:18 -0700
Message-ID: <20260403024422.87231-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
References: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
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

