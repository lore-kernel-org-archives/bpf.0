Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4D372EF1
	for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230234; cv=none; b=FUIduvjrR3VMB2rhgYZYNjLqJtQ+CcQreXCs4AMHwHyOIjt6vf9/EcY1tmtxcAInDem331Cpwy7kthIgO1XzHamkr57855FDlC1UNdjsWn4Gob0ZUoNXzHMAN+fzIIzCII9daFmsm1lP0Sl6ZPvMDVA881cmLtCYh/dXQq44bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230234; c=relaxed/simple;
	bh=n9FMbnGrvVXuwtAs8vo1oV5S32U2ua2rtlQy/wwyyIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EeAaOT1XeMBgdM6f3LHPmE8h/mgAVZlWfHEgrRWSnyAeJz2kcPA5awNDxm30OYjM+YVF0bTGptJOUUqBlGjb6zKB8kY6gUTtSRLagUXsCYFomoRbH/27voFrzxwK69hYVAGjY3VbfuiE1aA88FzVbsMMcrwAzh6BOjQfWu3iArw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=twkAt+7t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="twkAt+7t"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so80620895ad.2
        for <bpf@vger.kernel.org>; Sun, 26 Apr 2026 12:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1777230228; x=1777835028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJfVXxuRZTPcM17gJcmSzQEZAbW36ZpEinHf4rxWunw=;
        b=twkAt+7t3Yy8mhNzdcEksDrGce5Iq8cWrH6tshZ/0zkOf7QDjEQ0v7r0Ophl4vAGxT
         IrxSgOp6YJq20Zc3lCM8XMpf5IpYN1PqYXfEQ/SYbf3Wbsq3t+IFiXMhqxEaVgXAAQA6
         nn9IKZ7kHxawWoAmo6tE+ldCaWgUlq8VNoxNaG4vgJQG3aqUVfQ0LrW4CpIDPX7UUOU6
         LxUlXpmr7HBMUEXcExvLtBn9uOcWoG1BJRbPg7WytbySSebITRyqjnCXNuCCFSBZB7/Q
         38T3pb9YJbMA+8mzIbWNV2SLn/5JyStQ/meWTcBhTfvEWgtdJwkl1HFMSkvzW9nDT8gE
         4Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230228; x=1777835028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJfVXxuRZTPcM17gJcmSzQEZAbW36ZpEinHf4rxWunw=;
        b=SkN1aX/UTNx90xZc/1S6D8JIueuzcbU/Te9vfyg4pFrjQ46f5MA21l2IiUyGS/vdvO
         gmRwP6Oqfxlob12WI2ft+iZi7FNTo8a5TepVZJWM3Whqk2F0aOo7WlqNxPtHztO5LPxn
         vnReuRUsMn/goCcutDZKqw7YwKNVqr3pkF7iP8dOCfuJ4wEkh5iq0iLKaPfFVhN5dx2N
         UfW+Orou5CFD3gcOld9rP4AYQCPwh6Ucrd5wP9HGEPfT0nqdKKS42TvirWbCoA0IaF79
         /WAX7NtpKFtJByoBcinNH+pOg9pZxmNXAx2RaTMaQnf/3j8YMFewdT1WMGEf3rPD5S0P
         Sp9Q==
X-Gm-Message-State: AOJu0YyDt6IyXDzLuLcmD5yVu20n5S8MQtLNhLNZGztQBn/26V0Expon
	ijTqx1M0XsPeq4K7MQJx8MtBZPHoTBD3bU4jtSRRtdGQNyFVIYxeiO5Civ4vwJ8lBoWyKJkdoV1
	5tkBStqg=
X-Gm-Gg: AeBDiesJrc+57ogUd9pBIp+4YRL3QtI+jBmAdJixQfVEdXU2vON9u3ckd4afITEdtRe
	OiC6wyAgLoVhYpSCPX+E1bPwaDzrZ0Wr6WSH47GICEkkGOcJMwpObG6MB9EwllcYBewpsoc+AMT
	Hg6L0MH+T0J/JjPtkBx8+9QkcLSmi+c1Nux6DlHnc70zjCyRy15wykD0AupzTAc/oEiFzwIyWMm
	/Ofp/6fAB3S+Znb+aHGtl7jocoUo9AwlQeDWqexw7wgAu5ACVNb0bbzppRvPVbe8VgKGbw7FeRw
	f8zjToT6Lcqk5FZ+dwEIGDrquM+/nMGl3yZYkFrVvLzcNSnHudQcEVwyuLFniBJOz///jvg4q9I
	rYFjR3NhPf1tclvTQYXNrAuTi6iUDUBTfcHtXmjsZUIfQEaBecE6EPAF7O1nUVmEt+AZdZaAQiX
	o79MO5BSSOBjWK
X-Received: by 2002:a17:903:32c9:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b5f9fa70e1mr415773925ad.27.1777230228138;
        Sun, 26 Apr 2026 12:03:48 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::2af6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b7a9efd0f2sm107449965ad.31.2026.04.26.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:03:47 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v9 7/8] selftests/bpf: Add selftests for libarena buddy allocator
Date: Sun, 26 Apr 2026 15:03:37 -0400
Message-ID: <20260426190338.4615-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426190338.4615-1-emil@etsalapatis.com>
References: <20260426190338.4615-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce selftests for the buddy allocator with and without
ASAN. Add the libarena selftests both to the libarena test
runner and to test_progs, so that they are a) available when
libarena is pulled as a standalone library, and b) exercised
along with all other test programs in this directory.

ASAN for libarena requires LLVM 22. Add logic in the top-level
selftests Makefile to only compile the ASAN variant if the
compiler supports it, otherwise skip the test.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../libarena/selftests/st_asan_buddy.bpf.c    | 240 ++++++++++++++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 209 +++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       |  66 +++++
 .../selftests/bpf/prog_tests/libarena_asan.c  |  91 +++++++
 4 files changed, 606 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena_asan.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
new file mode 100644
index 000000000000..9dd2980b5d6c
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <libarena/common.h>
+#include <libarena/asan.h>
+#include <libarena/buddy.h>
+
+extern buddy_t buddy;
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int ret, i;
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	mem = buddy_alloc(&buddy, alloc_size);
+	if (!mem) {
+		arena_stdout("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		mem[i] = 0xba;
+		ret = asan_validate_addr(false, &mem[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	mem[alloc_size] = 0xba;
+	ret = asan_validate_addr(true, &mem[alloc_size]);
+	if (ret < 0)
+		return ret;
+
+	buddy_free(&buddy, mem);
+
+	return 0;
+}
+
+/*
+ * Factored out because asan_validate_addr is complex enough to cause
+ * verification failures if verified with the rest of asan_test_buddy_uaf_single.
+ */
+__weak int asan_test_buddy_byte(u8 __arena __arg_arena *mem, int i, bool freed)
+{
+	int ret;
+
+	/* The header in freed blocks doesn't get poisoned. */
+	if (freed && BUDDY_HEADER_OFF <= i &&
+		i < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
+		return 0;
+
+	mem[i] = 0xba;
+	ret = asan_validate_addr(freed, &mem[i]);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+__weak int asan_test_buddy_uaf_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int ret;
+	int i;
+
+	mem = buddy_alloc(&buddy, alloc_size);
+	if (!mem) {
+		arena_stdout("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		ret = asan_test_buddy_byte(mem, i, false);
+		if (ret)
+			return ret;
+	}
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	buddy_free(&buddy, mem);
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		ret = asan_test_buddy_byte(mem, i, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct buddy_blob {
+	volatile u8 mem[48];
+	u8 oob;
+};
+
+static __always_inline int asan_test_buddy_blob_single(void)
+{
+	volatile struct buddy_blob __arena *blob;
+	const size_t alloc_size = sizeof(struct buddy_blob) - 1;
+	int ret;
+
+	blob = buddy_alloc(&buddy, alloc_size);
+	if (!blob)
+		return -ENOMEM;
+
+	blob->mem[0] = 0xba;
+	ret = asan_validate_addr(false, &blob->mem[0]);
+	if (ret < 0)
+		return ret;
+
+	blob->mem[47] = 0xba;
+	ret = asan_validate_addr(false, &blob->mem[47]);
+	if (ret < 0)
+		return ret;
+
+	blob->oob = 0;
+	ret = asan_validate_addr(true, &blob->oob);
+	if (ret < 0)
+		return ret;
+
+	buddy_free(&buddy, (void __arena *)blob);
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int asan_test_buddy_oob(void)
+{
+	size_t sizes[] = {
+		7, 8, 17, 18, 64, 256, 317, 512, 1024,
+	};
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret) {
+		arena_stdout("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
+		ret = asan_test_buddy_oob_single(sizes[i]);
+		if (ret) {
+			arena_stdout("%s:%d Failed for size %lu", __func__,
+				   __LINE__, sizes[i]);
+			buddy_destroy(&buddy);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&buddy);
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int asan_test_buddy_uaf(void)
+{
+	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 1024, 16384 };
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret) {
+		arena_stdout("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = zero; i < sizeof(sizes) / sizeof(sizes[0]) && can_loop; i++) {
+		ret = asan_test_buddy_uaf_single(sizes[i]);
+		if (ret) {
+			arena_stdout("%s:%d Failed for size %lu", __func__,
+				   __LINE__, sizes[i]);
+			buddy_destroy(&buddy);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&buddy);
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int asan_test_buddy_blob(void)
+{
+	const int iters = 10;
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret) {
+		arena_stdout("buddy_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = zero; i < iters && can_loop; i++) {
+		ret = asan_test_buddy_blob_single();
+		if (ret) {
+			arena_stdout("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			buddy_destroy(&buddy);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&buddy);
+
+	ret = asan_validate();
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+#endif
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
new file mode 100644
index 000000000000..79e6f0baabfe
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <libarena/common.h>
+
+#include <libarena/asan.h>
+#include <libarena/buddy.h>
+
+extern buddy_t buddy;
+
+struct segarr_entry {
+	u8 __arena *block;
+	size_t sz;
+	u8 poison;
+};
+
+#define SEGARRLEN (512)
+static struct segarr_entry __arena segarr[SEGARRLEN];
+static void __arena *ptrs[17];
+size_t __arena alloc_sizes[] = { 3, 17, 1025, 129, 16350, 333, 9, 517 };
+size_t __arena alloc_multiple_sizes[] = { 3, 17, 1025, 129, 16350, 333, 9, 517, 2099 };
+size_t __arena alloc_free_sizes[] = { 3, 17, 64, 129, 256, 333, 512, 517 };
+size_t __arena alignment_sizes[] = { 1, 3, 7, 8, 9, 15, 16, 17, 31,
+				     32, 64, 100, 128, 255, 256, 512, 1000 };
+
+SEC("syscall")
+__weak int test_buddy_create(void)
+{
+	const int iters = 10;
+	int ret, i;
+
+	for (i = zero; i < iters && can_loop; i++) {
+		ret = buddy_init(&buddy);
+		if (ret)
+			return ret;
+
+		ret = buddy_destroy(&buddy);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int test_buddy_alloc(void)
+{
+	void __arena *mem;
+	int ret, i;
+
+	for (i = zero; i < 8 && can_loop; i++) {
+		ret = buddy_init(&buddy);
+		if (ret)
+			return ret;
+
+		mem = buddy_alloc(&buddy, alloc_sizes[i]);
+		if (!mem) {
+			buddy_destroy(&buddy);
+			return -ENOMEM;
+		}
+
+		buddy_destroy(&buddy);
+	}
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int test_buddy_alloc_free(void)
+{
+	const int iters = 800;
+	void __arena *mem;
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret)
+		return ret;
+
+	for (i = zero; i < iters && can_loop; i++) {
+		mem = buddy_alloc(&buddy, alloc_free_sizes[(i * 5) % 8]);
+		if (!mem) {
+			buddy_destroy(&buddy);
+			return -ENOMEM;
+		}
+
+		buddy_free(&buddy, mem);
+	}
+
+	buddy_destroy(&buddy);
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int test_buddy_alloc_multiple(void)
+{
+	int ret, j;
+	u32 i, idx;
+	u8 __arena *mem;
+	size_t sz;
+	u8 poison;
+
+	ret = buddy_init(&buddy);
+	if (ret)
+		return ret;
+
+	/*
+	 * Cycle through each size, allocating an entry in the
+	 * segarr. Continue for SEGARRLEN iterations. For every
+	 * allocation write down the size, use the current index
+	 * as a poison value, and log it with the pointer in the
+	 * segarr entry. Use the poison value to poison the entire
+	 * allocated memory according to the size given.
+	 */
+	for (i = zero; i < SEGARRLEN && can_loop; i++) {
+		sz = alloc_multiple_sizes[i % 9];
+		poison = (u8)i;
+
+		mem = buddy_alloc(&buddy, sz);
+		if (!mem) {
+			buddy_destroy(&buddy);
+			arena_stdout("%s:%d", __func__, __LINE__);
+			return -ENOMEM;
+		}
+
+		segarr[i].block = mem;
+		segarr[i].sz = sz;
+		segarr[i].poison = poison;
+
+		for (j = zero; j < sz && can_loop; j++) {
+			mem[j] = poison;
+			if (mem[j] != poison) {
+				buddy_destroy(&buddy);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/*
+	 * Go to (i * 17) % SEGARRLEN, and free the block pointed to.
+	 * Before freeing, check all bytes have the poisoned value
+	 * corresponding to the element. If any values are unexpected,
+	 * return an error. Skip some elements to test destroying the
+	 * buddy allocator while data is still allocated.
+	 */
+	for (i = 10; i < SEGARRLEN && can_loop; i++) {
+		idx = (i * 17) % SEGARRLEN;
+
+		mem = segarr[idx].block;
+		sz = segarr[idx].sz;
+		poison = segarr[idx].poison;
+
+		for (j = zero; j < sz && can_loop; j++) {
+			if (mem[j] != poison) {
+				buddy_destroy(&buddy);
+				arena_stdout("%s:%d %lx %u vs %u", __func__,
+					   __LINE__, (uintptr_t)&mem[j],
+					   mem[j], poison);
+				return -EINVAL;
+			}
+		}
+
+		buddy_free(&buddy, mem);
+	}
+
+	buddy_destroy(&buddy);
+
+	return 0;
+}
+
+SEC("syscall")
+__weak int test_buddy_alignment(void)
+{
+	int ret, i;
+
+	ret = buddy_init(&buddy);
+	if (ret)
+		return ret;
+
+	/* Allocate various sizes and check alignment */
+	for (i = zero; i < 17 && can_loop; i++) {
+		ptrs[i] = buddy_alloc(&buddy, alignment_sizes[i]);
+		if (!ptrs[i]) {
+			arena_stdout("alignment test: alloc failed for size %lu",
+				   alignment_sizes[i]);
+			buddy_destroy(&buddy);
+			return -ENOMEM;
+		}
+
+		/* Check 8-byte alignment */
+		if ((u64)ptrs[i] & 0x7) {
+			arena_stdout(
+				"alignment test: ptr %llx not 8-byte aligned (size %lu)",
+				(u64)ptrs[i], alignment_sizes[i]);
+			buddy_destroy(&buddy);
+			return -EINVAL;
+		}
+	}
+
+	/* Free all allocations */
+	for (i = zero; i < 17 && can_loop; i++)
+		buddy_free(&buddy, ptrs[i]);
+
+	buddy_destroy(&buddy);
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
new file mode 100644
index 000000000000..81bdb084c271
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <unistd.h>
+
+#include <libarena/common.h>
+#include <libarena/asan.h>
+#include <libarena/buddy.h>
+#include <libarena/userspace.h>
+
+#include "libarena/libarena.skel.h"
+
+static void run_libarena_test(struct libarena *skel, struct bpf_program *prog,
+		const char *name)
+{
+	int ret;
+
+	if (!strstr(name, "test_buddy")) {
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
+		if (!ASSERT_OK(ret, "arena_buddy_reset"))
+			return;
+	}
+
+	ret = libarena_run_prog(bpf_program__fd(prog));
+
+	ASSERT_OK(ret, name);
+
+}
+
+void test_libarena(void)
+{
+	struct arena_alloc_reserve_args args;
+	struct libarena *skel;
+	struct bpf_program *prog;
+	int ret;
+
+	skel = libarena__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	ret = libarena__attach(skel);
+	if (!ASSERT_OK(ret, "attach"))
+		goto out;
+
+	args.nr_pages = ARENA_RESERVE_PAGES_DFL;
+
+	ret = libarena_run_prog_args(bpf_program__fd(skel->progs.arena_alloc_reserve),
+			&args, sizeof(args));
+	if (!ASSERT_OK(ret, "arena_alloc_reserve"))
+		goto out;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		const char *name = bpf_program__name(prog);
+
+		if (!libarena_is_test_prog(name))
+			continue;
+
+		if (!test__start_subtest(name))
+			continue;
+
+		run_libarena_test(skel, prog, name);
+	}
+
+out:
+	libarena__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena_asan.c b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
new file mode 100644
index 000000000000..b4fba10cdfbf
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libarena_asan.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#ifdef HAS_BPF_ARENA_ASAN
+#include <unistd.h>
+
+#include <libarena/common.h>
+#include <libarena/asan.h>
+#include <libarena/buddy.h>
+#include <libarena/userspace.h>
+
+#include "libarena/libarena_asan.skel.h"
+
+static void run_libarena_asan_test(struct libarena_asan *skel,
+		struct bpf_program *prog, const char *name)
+{
+	int ret;
+
+	if (!strstr(name, "test_buddy")) {
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
+		if (!ASSERT_OK(ret, "arena_buddy_reset"))
+			return;
+	}
+
+	ret = libarena_run_prog(bpf_program__fd(prog));
+	ASSERT_OK(ret, name);
+}
+
+static void run_test(void)
+{
+	struct arena_alloc_reserve_args args;
+	struct libarena_asan *skel;
+	struct bpf_program *prog;
+	int ret;
+
+	skel = libarena_asan__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	ret = libarena_asan__attach(skel);
+	if (!ASSERT_OK(ret, "attach"))
+		goto out;
+
+	args.nr_pages = ARENA_RESERVE_PAGES_DFL;
+
+	ret = libarena_run_prog_args(bpf_program__fd(skel->progs.arena_alloc_reserve),
+			&args, sizeof(args));
+	if (!ASSERT_OK(ret, "arena_alloc_reserve"))
+		goto out;
+
+	ret = libarena_asan_init(
+		bpf_program__fd(skel->progs.arena_get_info),
+		bpf_program__fd(skel->progs.asan_init),
+		(1ULL << 32) / sysconf(_SC_PAGESIZE));
+	if (!ASSERT_OK(ret, "libarena_asan_init"))
+		goto out;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		const char *name = bpf_program__name(prog);
+
+		if (!libarena_is_asan_test_prog(name))
+			continue;
+
+		if (!test__start_subtest(name))
+			continue;
+
+		run_libarena_asan_test(skel, prog, name);
+	}
+
+out:
+	libarena_asan__destroy(skel);
+}
+
+#endif /* HAS_BPF_ARENA_ASAN */
+
+/*
+ * Run the test depending on whether LLVM can compile arena ASAN
+ * programs.
+ */
+void test_libarena_asan(void)
+{
+#ifdef HAS_BPF_ARENA_ASAN
+	run_test();
+#else
+	test__skip();
+#endif
+
+	return;
+}
+
-- 
2.53.0

