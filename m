Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC03DC4D8
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838675; cv=none; b=tboYa084g+HFwLzfCsczjfXCkI+aIPYX5Vx6h68X2tGqcK8YyPWJGD/Tmtg+AYQlM5O3eqG1jGDB4SPYPzVAzw5/XPp36ZV3TTmEayGqWecvo8Ifs7WRJU1UEgGnsgmx98q9NfSeAjKwZvQSTHm8Cd0RfzYV9kICMdm3bObqeiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838675; c=relaxed/simple;
	bh=ae8tLXl0/8Rm3Bffe9NvwlFykMqT55BFieAPnyhrPHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frHORQrRg4CnNLkxxhBv/v1dOJ4kqV5WThNBgBCnBWcMmzb6RV7Djk9RJ+kvj9+pKIIqYHGTg9jSScUe1H4TTldxlGuPz37uZwBBc4JsaMHaCN8Yc4VV4OfKtmUGyUZRKErvPcGqk3BBA6NlqrFK1+3Y/wqqWHXYqwnfbtx3TBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Ze++F9Q4; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Ze++F9Q4"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1919255eec.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775838673; x=1776443473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H69tAwngqLWDdXow3SNko52Kh+TBsqvastySjobHu/I=;
        b=Ze++F9Q4VeU1f9983+Tg03w9uNKvvT62+YGw2DNci/gNwoSf1/iyJZjaC1l67CN834
         ZO5xfbc1OHTD/WUPH2llR3JpXcJBmVcIrBG/qDWiVdjGgZ8siHN6ZrR6/YQ0S2uLzpm7
         RKMo7aRkYldsT4v51qAYb3RX28IPfUZOv7EXrNDJs1c06of2wyRyvxFIgUjWpYjt7WH6
         nEc7AoA6vOXV2cDqsuio1Pk5u6qTsAedGR8v4fY+REMma0WCKocvNLSaE7NHjn9Rixov
         7R6ZRN9M1NPwPBFnqATbLToxGx16TDH7XfV7TpBJ79NtYSMzHzfOe7DNvYFUmCODM9Oi
         Dq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838673; x=1776443473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H69tAwngqLWDdXow3SNko52Kh+TBsqvastySjobHu/I=;
        b=a9NjAc+nlWZVJPPxgfM47zXi+7fk1tiwvCtcsKD2NrCDln4cFl7TBHnf+Dc8+N7yn4
         dEmFjZribrB/LGIVlypXsmza+euj8Z6IYSFOJY3+LP+3pDmQj88f2YMm5mst6YIN6oSW
         esvhFgoyL6rIp6X7TsjgswfdkqILF7h5DaVAxhg/LneSS3cA3a5LJIKICPkK1EQ7+MDx
         F+pkH+bzo12ZIdItYf2hVmy2NV14YfT3zkCQlBhg4M6EMzmNvY1Qlpt625p56MDb4XSR
         gOguUe6sHg8MMZJK5DdsGlvutFOMgQ/nwVJqDkwclA4NEYbj11F8gLwFsVkI/3nRUyEu
         vlRQ==
X-Gm-Message-State: AOJu0YyRFgQhVlmL40epIR0q/r/LMU4FCwqvxt72F91CvA4i+PpI9Qqm
	ByWFJ1jAoG30nwSr1BEaLB0yrLojec3AkVWTREKQ9+ZClY92DD7jqlNLYoprS9lo3bTsvKgDX59
	sFrN2d84=
X-Gm-Gg: AeBDiet1AzEheiG7WPiv99gcAy4YzYs7pZIsC/K7sQkpbLejAOduWc7x8BewQ0FaRwN
	rMwGItgwN8ts1z6NSnshypK25/j6fvd8Dn6r7moQ2hHh1B9Q9+xRyLzOp0JiRRDwd6L7Tk1A+U7
	XC/5QA9iC7+r+KVrs5ogubVQ0t+BIJxVFO6O5t5Z3Bz9b+9LJ9MY8quuh+wRFsBSHbcw8YM1cLo
	MIUxcZCY0oqGMBy71ljGmQd4RMTfBHqdC5nRcOk31Zji7d9Z7W3ngQMluGEhxNpGll+p/NzWYfH
	flJbry4KNsiGWmPBlz0kDuxgoH9Ww4vGjqqY86tBDlAPn9s1fvuz1zZeLrjb9d5Q+ZLGNnvuzSV
	oYpc6UA7w0z7qVZOw0gmtu3km/qKsxVmRSbpm++EOlv8+5zvcZ8MuOecaI/zN1Kl6kBpHgcXHvk
	wr9SzDAEEvm3RgJQxsK1s=
X-Received: by 2002:a05:7300:dc06:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2d5870ad65fmr2418495eec.5.1775838672442;
        Fri, 10 Apr 2026 09:31:12 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::6eaf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm5642619eec.3.2026.04.10.09.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:31:12 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 9/9] selftests/bpf: Add selftests for libarena buddy allocator
Date: Fri, 10 Apr 2026 12:30:41 -0400
Message-ID: <20260410163041.8063-10-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410163041.8063-1-emil@etsalapatis.com>
References: <20260410163041.8063-1-emil@etsalapatis.com>
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
 .../bpf/libarena/include/selftest_helpers.h   |   7 +
 .../bpf/libarena/selftests/selftest.c         |   8 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 243 ++++++++++++++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 211 +++++++++++++++
 .../selftests/bpf/prog_tests/libarena.c       |  61 +++++
 5 files changed, 530 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/libarena.c

diff --git a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
index 36e4f36ae8e6..cb8bf9b7cd71 100644
--- a/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
+++ b/tools/testing/selftests/bpf/libarena/include/selftest_helpers.h
@@ -112,3 +112,10 @@ static inline int libarena_asan_init(int arena_get_base_fd,
 		return ret;
 	return opts.retval;
 }
+
+static inline bool libarena_must_setup_alloc(struct bpf_program *prog)
+{
+	const char *name = bpf_program__name(prog);
+
+	return !strstr(name, "test_buddy");
+}
diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index 45ab1ac0ef78..824e5f6b4b26 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -17,6 +17,7 @@
 
 #include <common.h>
 #include <asan.h>
+#include <buddy.h>
 #include <selftest_helpers.h>
 
 #ifdef BPF_ARENA_ASAN
@@ -101,6 +102,13 @@ static int init_arena(selftest *skel)
 static int run_test(selftest *skel, struct bpf_program *prog)
 {
 	int prog_fd;
+	int ret;
+
+	if (libarena_must_setup_alloc(prog)) {
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
+		if (ret)
+			return ret;
+	}
 
 	prog_fd = bpf_program__fd(prog);
 	if (prog_fd < 0)
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
new file mode 100644
index 000000000000..21e811f60003
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+extern buddy_t buddy;
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+u64 __arena st_asan_buddy_lock;
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
+	size_t sizes[] = { 16, 32, 64, 128, 256, 512, 128, 1024, 16384 };
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
index 000000000000..82afdeb49496
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <common.h>
+
+#include <asan.h>
+#include <buddy.h>
+
+extern buddy_t buddy;
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
+	idx = 0;
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
+					   __LINE__, &mem[j], mem[j], poison);
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
index 000000000000..548e76360e22
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/libarena.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include <unistd.h>
+
+#include "libarena/include/common.h"
+#include "libarena/include/asan.h"
+#include "libarena/include/buddy.h"
+#include "libarena/include/selftest_helpers.h"
+
+#include "libarena/libarena.skel.h"
+
+static void run_libarena_test(struct libarena *skel, struct bpf_program *prog,
+		const char *name)
+{
+	int ret;
+
+	if (libarena_must_setup_alloc(prog)) {
+		ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_buddy_reset));
+		ASSERT_OK(ret, "arena_buddy_reset");
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
+	ret = libarena_run_prog(bpf_program__fd(skel->progs.arena_alloc_reserve));
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
-- 
2.53.0

