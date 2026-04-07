Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665034F46D
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537863; cv=none; b=VpmO9tuJke5VJyIwCvX0ebpTQujxtIiJQujOIyB1o0k03bIC6W/hjvViqZD7PrBJbjcwWuBiMnpP58QhZ4V25dfRLB6G6UONYFPrHoaQtD5FejfMdCnTsvp/mcTt7HDN+27HnZg4QyYDYLt1Tyj0qLGUTKWgNlkvCxu1mQ9DqLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537863; c=relaxed/simple;
	bh=U5tBnc2qFt1//EAWk/IuN02bNp1LdaXRrsdgoHtvuNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/zBKrIYly2QKoEZShnaKz+xUt7D9MWykr95Dt8+qMzvFV35XK3xLlg2bw/6w11FCLiJEETamAV+jQ1EwXAVOZRTgRotugAxw8xP+EopDq5KNqdELVeogjPHqeyqdOm64Otbp4XfM7UPUL4Pni6PsBfHYpbsJl0RNQxnqKbhSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=qgRYLPCn; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="qgRYLPCn"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c742723c863so3017769a12.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 21:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775537861; x=1776142661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHeydAelzbkThdeY9v7cD5si5fNhz9nYtTNg2k3jgsQ=;
        b=qgRYLPCnOBWQwHLdpmJRKbeRXXU2xJjkDZ1uX6LSRAe+gpJ3gc+pisMOt1Pvr/sQhH
         GN/6PuJGGtjU1O/GBxYBim563p0Vlb16a9vZ3YNl1fq8/zK7zBoxIi5OoYvRzXl6uyix
         hB5EyuuRFI/0IDw/nDi9mNnVZfhCeX+06F6ThCwPF8sG4aL2rxIhwgg1SU4UnUjAMplF
         49tvjGo4kZ9lHUVXmASM1SCgEq3cA7gFqAuM5AYKcdKx83URRbUhbx6HJKm05pFUVqDI
         NdL9sfTGCekY4gQtj5XZyXnIjOW4tubVeoVggzPIy3JjBGnXxaQGVdBUFhA9MKqzP463
         0FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537861; x=1776142661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lHeydAelzbkThdeY9v7cD5si5fNhz9nYtTNg2k3jgsQ=;
        b=i7lBrR8grOowMjY9U+SGNpChAyAg35JW7ETbDU8sQUhHGGT0Ng43Mvpq+ZwMJMKtMM
         9fSueGbZQigLDQhDmc2lvs1K+pu+UWMG1mah3gSWIQlaCg2Cg0Jpb4Iy05eZY9c5hiEs
         r74b8yFOMETICswiq2BJMKg4ZC2naUnPjUBkM62o0CTtubCt59aOiBFnH56+kpgVaVtC
         8JaDLiuLhT3mbjQTwu6t6xH6cHBnuC6MbAruexumhVPKCMK8LRIeUyWXUBNmJkqtd3B2
         00QEkR2w4xZtZd8ytCq625Zt8l12K6FPYi9xZjtzKwLNqZiRZZzVy/VrPh1gc4cCjj1F
         3abA==
X-Gm-Message-State: AOJu0Yw9Sq70L9m27jyht41N22FHZExKUW9sNJWjcLcgcYj5nHXVungD
	3qCt4MTKqWxCkr3GOMX69maazEVG0RHNnKRMmUFmUTGRBohaATBXsF8DehvbQvY9zUX4rBAcZ6a
	xhGeHF5Bsjg==
X-Gm-Gg: AeBDievDbvEkc6QZxWbIlypLf+0jPLIGrB6NvtylzBrT0nEFup3jlXR7IZtyglNk/AM
	eQu2NrIBQAoZ7NrfJKCcQSuCdmYuTak1Ms0xpFSSWCdiYJ1pbaowk3wkfhShYrx9tuCEoYu+LGM
	l4YoWuIfsQ66Lw1LbrTJqDtaeGZoEELPVWSh6VTQuUYO1o/pTW+WUW5wLDn+7iMqiycZipKeNIn
	RsCzYVbJE+diPcvIF44m9zmYgodx3of5e0AzykcQ7WY6QiLns/MengebWqZa0bdjZVsbR6H8z/S
	/YqU3FDRENz2Rs8zbHvpYEMkcgiJsuO6QABSVyrRvyLz0DBQvUALhTgK7dZ3hmbEbjixuatK1iU
	pprVcBseADQwdH2ZdW/zeeaZCLlfianT7VRSWro6uLgoW1MtJkReOhMYkQlLQb/itWbjODQ567Q
	G1sA==
X-Received: by 2002:a05:6a00:1388:b0:823:1c5f:1c43 with SMTP id d2e1a72fcca58-82d0db5ad1fmr15655796b3a.36.1775537860842;
        Mon, 06 Apr 2026 21:57:40 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm16156807b3a.2.2026.04.06.21.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:57:40 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: Add selftests for libarena buddy allocator
Date: Tue,  7 Apr 2026 00:57:30 -0400
Message-ID: <20260407045730.13359-10-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407045730.13359-1-emil@etsalapatis.com>
References: <20260407045730.13359-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce selftests for the buddy allocator without ASAN.
Add the libarena selftests both to the libarena test
runner and to test_progs, so that they are a) available when
libarena is pulled as a standalone library, and b) exercised
along with all other test programs in this directory.

Currently ASAN for libarena requires LLVM 22, which is not
available in the CI. Delay testing the ASAN case directly
through test_progs until that is the case. The ASAN version
is available for testing on demand through the library's own
harness.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/selftest.c         |  12 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 251 ++++++++++++++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 230 ++++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       |  44 +++
 4 files changed, 537 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 2bd8363ea614..ad7e00c2de0f 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -137,6 +137,12 @@ error_no_destroy:					\
 	return ret;					\
 }
 
+TEST(test_buddy);
+
+#ifdef BPF_ARENA_ASAN
+TEST(asan_test_buddy);
+#endif
+
 static void
 banner(const char *progpath)
 {
@@ -174,5 +180,11 @@ int main(int argc, char *argv[])
 
 	libbpf_set_print(libbpf_print_fn);
 
+	run_test_buddy();
+
+#ifdef BPF_ARENA_ASAN
+	run_asan_test_buddy();
+#endif
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
new file mode 100644
index 000000000000..61b551639f6a
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+#include "selftest.h"
+
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+private(ST_BUDDY) struct buddy st_buddy_asan;
+
+u64 __arena st_asan_buddy_lock;
+
+static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
+{
+	u8 __arena *mem;
+	int i;
+
+	ASAN_VALIDATE();
+
+	mem = buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!mem) {
+		arena_stdout("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ASAN_VALIDATE();
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		mem[i] = 0xba;
+		ASAN_VALIDATE_ADDR(false, &mem[i]);
+	}
+
+	mem[alloc_size] = 0xba;
+	ASAN_VALIDATE_ADDR(true, &mem[alloc_size]);
+
+	buddy_free(&st_buddy_asan, mem);
+
+	return 0;
+}
+
+/*
+ * Factored out because ASAN_VALIDATE_ADDR is complex enough to cause
+ * verification failures if verified with the rest of asan_test_buddy_uaf_single.
+ */
+__weak int asan_test_buddy_byte(u8 __arena __arg_arena *mem, int i, bool freed)
+{
+	/* The header in freed blocks doesn't get poisoned. */
+	if (freed && BUDDY_HEADER_OFF <= i &&
+		i < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
+		return 0;
+
+	mem[i] = 0xba;
+	ASAN_VALIDATE_ADDR(freed, &mem[i]);
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
+	mem = buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!mem) {
+		arena_stdout("buddy_alloc failed for size %lu", alloc_size);
+		return -ENOMEM;
+	}
+
+	ASAN_VALIDATE();
+
+	for (i = zero; i < alloc_size && can_loop; i++) {
+		ret = asan_test_buddy_byte(mem, i, false);
+		if (ret)
+			return ret;
+	}
+
+	ASAN_VALIDATE();
+
+	buddy_free(&st_buddy_asan, mem);
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
+
+	blob = buddy_alloc(&st_buddy_asan, alloc_size);
+	if (!blob)
+		return -ENOMEM;
+
+	blob->mem[0] = 0xba;
+	ASAN_VALIDATE_ADDR(false, &blob->mem[0]);
+
+	blob->mem[47] = 0xba;
+	ASAN_VALIDATE_ADDR(false, &blob->mem[47]);
+
+	blob->oob = 0;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	buddy_free(&st_buddy_asan, (void __arena *)blob);
+
+	return 0;
+}
+
+static __always_inline int asan_test_buddy_oob(void)
+{
+	size_t sizes[] = {
+		7, 8, 17, 18, 64, 256, 317, 512, 1024,
+	};
+	int ret, i;
+
+	ret = buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
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
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+__weak int asan_test_buddy_uaf(void)
+{
+	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 128, 1024, 16384 };
+	int ret, i;
+
+	ret = buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
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
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+static __always_inline int asan_test_buddy_blob(void)
+{
+	const int iters = 10;
+	int ret, i;
+
+	ret = buddy_init(&st_buddy_asan,
+			     (arena_spinlock_t __arena *)&st_asan_buddy_lock);
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
+			buddy_destroy(&st_buddy_asan);
+			return ret;
+		}
+	}
+
+	buddy_destroy(&st_buddy_asan);
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+SEC("syscall")
+int asan_test_buddy(void)
+{
+	int ret;
+
+	ret = asan_test_buddy_oob();
+	if (ret) {
+		arena_stdout("%s:%d OOB test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = asan_test_buddy_uaf();
+	if (ret) {
+		arena_stdout("%s:%d UAF test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = asan_test_buddy_blob();
+	if (ret) {
+		arena_stdout("%s:%d blob test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	return 0;
+}
+
+#else
+
+SEC("syscall")
+int asan_test_buddy(void)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
new file mode 100644
index 000000000000..d8354dd2d7fc
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+#include "selftest.h"
+
+
+private(ST_BUDDY) struct buddy st_buddy;
+static u64 __arena st_buddy_lock;
+
+struct segarr_entry {
+	u8 __arena *block;
+	size_t sz;
+	u8 poison;
+};
+
+typedef struct segarr_entry __arena segarr_entry_t;
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
+static int test_buddy_create(void)
+{
+	const int iters = 10;
+	int ret, i;
+
+	for (i = zero; i < iters && can_loop; i++) {
+		ret = buddy_init(
+			&st_buddy, (arena_spinlock_t __arena *)&st_buddy_lock);
+		if (ret)
+			return ret;
+
+		ret = buddy_destroy(&st_buddy);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int test_buddy_alloc(void)
+{
+	void __arena *mem;
+	int ret, i;
+
+	for (i = zero; i < 8 && can_loop; i++) {
+		ret = buddy_init(
+			&st_buddy, (arena_spinlock_t __arena *)&st_buddy_lock);
+		if (ret)
+			return ret;
+
+		mem = buddy_alloc(&st_buddy, alloc_sizes[i]);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		buddy_destroy(&st_buddy);
+	}
+
+	return 0;
+}
+
+static int test_buddy_alloc_free(void)
+{
+	const int iters = 800;
+	void __arena *mem;
+	int ret, i;
+
+	ret = buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
+	if (ret)
+		return ret;
+
+	for (i = zero; i < iters && can_loop; i++) {
+		mem = buddy_alloc(&st_buddy, alloc_free_sizes[(i * 5) % 8]);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		buddy_free(&st_buddy, mem);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+static int test_buddy_alloc_multiple(void)
+{
+	int ret, j;
+	u32 i, idx;
+	u8 __arena *mem;
+	size_t sz;
+	u8 poison;
+
+	ret = buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
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
+	idx = 0;
+	for (i = zero; i < SEGARRLEN && can_loop; i++) {
+		sz = alloc_multiple_sizes[i % 9];
+		poison = (u8)i;
+
+		mem = buddy_alloc(&st_buddy, sz);
+		if (!mem) {
+			buddy_destroy(&st_buddy);
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
+				buddy_destroy(&st_buddy);
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
+				buddy_destroy(&st_buddy);
+				arena_stdout("%s:%d %lx %u vs %u", __func__,
+					   __LINE__, &mem[j], mem[j], poison);
+				return -EINVAL;
+			}
+		}
+
+		buddy_free(&st_buddy, mem);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+static int test_buddy_alignment(void)
+{
+	int ret, i;
+
+	ret = buddy_init(&st_buddy,
+			     (arena_spinlock_t __arena *)&st_buddy_lock);
+	if (ret)
+		return ret;
+
+	/* Allocate various sizes and check alignment */
+	for (i = zero; i < 17 && can_loop; i++) {
+		ptrs[i] = buddy_alloc(&st_buddy, alignment_sizes[i]);
+		if (!ptrs[i]) {
+			arena_stdout("alignment test: alloc failed for size %lu",
+				   alignment_sizes[i]);
+			buddy_destroy(&st_buddy);
+			return -ENOMEM;
+		}
+
+		/* Check 8-byte alignment */
+		if ((u64)ptrs[i] & 0x7) {
+			arena_stdout(
+				"alignment test: ptr %llx not 8-byte aligned (size %lu)",
+				(u64)ptrs[i], alignment_sizes[i]);
+			buddy_destroy(&st_buddy);
+			return -EINVAL;
+		}
+	}
+
+	/* Free all allocations */
+	for (i = zero; i < 17 && can_loop; i++) {
+		buddy_free(&st_buddy, ptrs[i]);
+	}
+
+	buddy_destroy(&st_buddy);
+
+	return 0;
+}
+
+#define BUDDY_ALLOC_SELFTEST(suffix) ALLOC_SELFTEST(test_buddy_##suffix)
+
+SEC("syscall")
+__weak int test_buddy(void)
+{
+	BUDDY_ALLOC_SELFTEST(create);
+	BUDDY_ALLOC_SELFTEST(alloc);
+	BUDDY_ALLOC_SELFTEST(alloc_free);
+	BUDDY_ALLOC_SELFTEST(alloc_multiple);
+	BUDDY_ALLOC_SELFTEST(alignment);
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/prog_tests/libarena.c b/tools/testing/selftests/bpf/prog_tests/libarena.c
new file mode 100644
index 000000000000..ab0153f8baed
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <unistd.h>
+
+#define __arena
+typedef uint64_t u64;
+typedef uint8_t u8;
+
+#include "libarena/include/common.h"
+#include "libarena/include/asan.h"
+#include "libarena/include/selftest_helpers.h"
+
+#include "libarena/libarena.skel.h"
+
+static void test_libarena_buddy(void)
+{
+	struct libarena *skel;
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
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
+	if (!ASSERT_OK(ret, "arena_alloc_reserve"))
+		goto out;
+
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.test_buddy));
+	ASSERT_OK(ret, "test_buddy");
+
+out:
+	libarena__destroy(skel);
+}
+
+void test_libarena(void)
+{
+	if (test__start_subtest("buddy"))
+		test_libarena_buddy();
+}
-- 
2.53.0

