Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9E322B96
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537795; cv=none; b=FP2hFqqh+hpbYSFFQUU5bRmXc2ite1+fRKXqsIshbdPfi5ZxxWhx7q9wsfRxrpM+nlo9UuP+dLpZx+8NED9e8Uc4dvuibT34JQXrSeFjaQX1MChki4BExJ4T+JDSp/vQvEia8NxBLRcImm+iUq3XPc1vRKqr55UCYiRA3idt/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537795; c=relaxed/simple;
	bh=VUyK2YWzGile6w7zKOey2qUYzbwem29syGwahprMfFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thIx+hDbrQeC+4Hl5ILV3OZdqtvHJ0BJcA7xBo9G9kE+ESBqS2JBuzhFeQPEqf+iPL2NJEfdhsOgd6R6LxK6q1YzvULtthxxz76FboYoHknmEjHJro697P5bVqYSxa2WV1T5grc4+fR6iqaUZF99akboy2FANFu+L2Osnt9O1Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=FAi6n5+y; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="FAi6n5+y"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c537a42b53so819245385a.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537792; x=1770142592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxEzwUBFaF/soiHFXI35RqqMeD2HoVKQBeAVo3lWuVk=;
        b=FAi6n5+y//EYtPSYMfK9lKjCyapYcKWD+xeyE9wmi5oYCl3peNjCOVa8wskEMzefOT
         YzUabXRu1gPtf/h54xxfE7m6zXuWzJN9dUFMaASrlbneDERbCIA38yr91bJFYy6aSirG
         tTyE0BzWAyLfWO+UjnryO5hVk51EUXQuSIJcjQqpfUSVHq8H707SFix3icZvnJoKkUHh
         9ogX5gRRjxIJY6JyQcpEYD1eK8A52EUD13CQcBaPdlQz7ApqkZkW6G9cdK3nW9v9B7o9
         u0s5OlFWYDpxaMiHlVF7ohQnV4Y095S2AIdgPegnTG/EfbaRC/tOzu8qQ/o9t5JeLzZS
         oTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537792; x=1770142592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxEzwUBFaF/soiHFXI35RqqMeD2HoVKQBeAVo3lWuVk=;
        b=n7824F79e8iFWFLtp6KnGpaaDc+wD4OFG99YJHclxxrO0xp/PUzgLo2El0dpkWi7YD
         HG0qktHH80yPaTFMu/gk1uDSzy82mUV0fWcG4BrHS8QsJe8TEqOSS+p40/0KEyt/bkj9
         L0be1YoZNKQ7VHcZwSSt1BuaoKN7pqL99bJJmdyNUuobHKOdA1t5vH9rbw78YJnywpW2
         F6UYw63NC+nhQOniyf+JwhqUIIKaxP3yoFYLrtPXWNjQskkssBWQJE92h0zUgm+pPgnC
         b9M1Nb3478WGQzfu4dK+H4yHDR2XD7nN68gYKwrIMW3rgjgPYp3+F1Ss7TAvctyzcJc/
         BbYA==
X-Gm-Message-State: AOJu0YwPzDXTNWMwOq9I7OLDEW0LWNJ/+jhmJP7u6TscFvfu79kMcTUO
	Ktj8e4jPZqcbDv+6NUGJrLrfc3wOhFEqRi84uS6rRtPQsZyG3Zuc5rWLAOQQopluXph/f9/xc/9
	tsCEd
X-Gm-Gg: AZuq6aLSOiIo84byAEQaElxnjG5HeEg448LpFXk2huUPev5uZW634wrkQtpgFq02PIe
	5diHaB6q4lhHQ5lBcQ7iqlSKgkB/RruY9yu5Dzv446GRy2kwKKLMFyYT9UqRJN19RY8yrbGHrDV
	6B6cNEe9NaXXyXHZyTnRWwafljVnVAcZzBF6tJ63cgwGkWR+ANpw+118Q1Ld5H7rRi1XLHSp/QY
	JNXag5SCl86sSkiGb8Uyb3IXClMoGEnHBT6Z8YxOL32Jy+TMbXIRXsyl6WQo9hH9VfMU9dYLrh3
	JwnsITM+iHq8r4JzFFqc0GS86rg55jLBTzQDdSUSZzOwli3iRi1D0+fxR5hN6JZrdf7hSY5Ywst
	7Vm7XLAy7sccIPxcTq/kM0R2uXz69+d4dOsL7r41Wagiw2taGesAfFUeO4j1qUqwGOvsh3NKp6f
	XisxhGfkm2VA==
X-Received: by 2002:ac8:5ac2:0:b0:4ed:b441:d866 with SMTP id d75a77b69052e-5032fb1e141mr33914171cf.65.1769537792355;
        Tue, 27 Jan 2026 10:16:32 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:31 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	etsal@meta.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	memxor@gmail.com,
	puranjay@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH v2 09/13] selftests: bpf: Add libarena selftests for the bump allocator
Date: Tue, 27 Jan 2026 13:16:05 -0500
Message-ID: <20260127181610.86376-10-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127181610.86376-1-emil@etsalapatis.com>
References: <20260127181610.86376-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

Add testing for the libarena bump allocator. The testing covers
the behavior of the allocator both by itself and in combination
with ASAN to test that there are no false positives or negatives.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/selftest.c         |  12 +
 .../bpf/libarena/selftests/st_asan_bump.bpf.c | 193 ++++++++++++
 .../bpf/libarena/selftests/st_bump.bpf.c      | 281 ++++++++++++++++++
 3 files changed, 486 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index f63324a1cdde..a0fd7a2e6c46 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -265,6 +265,12 @@ error:							\
 	return ret;					\
 }
 
+TEST(bump_selftest);
+
+#ifdef BPF_ARENA_ASAN
+TEST(asan_test_bump);
+#endif
+
 static void
 banner(const char *progpath)
 {
@@ -306,5 +312,11 @@ int main(int argc, char *argv[])
 
 	libbpf_set_print(libbpf_print_fn);
 
+	run_bump_selftest();
+
+#ifdef BPF_ARENA_ASAN
+	run_asan_test_bump();
+#endif
+
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
new file mode 100644
index 000000000000..c67c482c3996
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_bump.bpf.c
@@ -0,0 +1,193 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+
+#include <asan.h>
+#include <bump.h>
+
+#include "selftest.h"
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+int asan_test_bump_blob_one(void)
+{
+	volatile struct blob __arena *blob;
+	const size_t alignment = 1;
+
+	blob = bump_alloc(sizeof(*blob) - 1, alignment);
+	if (!blob)
+		return -ENOMEM;
+
+	blob->mem[0] = 0xba;
+	ASAN_VALIDATE_ADDR(false, &blob->mem[0]);
+
+	blob->oob = 0;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	blob = (volatile struct blob __arena *)&blob->oob;
+	blob->mem[0] = 0xba;
+	ASAN_VALIDATE_ADDR(true, &blob->mem[0]);
+
+	blob->oob = 4;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	/*
+	 * Go even further, cast the OOB variable into
+	 * another struct blob and access its own oob.
+	 */
+	blob = (volatile struct blob __arena *)&blob->oob;
+	blob->oob = 5;
+	ASAN_VALIDATE_ADDR(true, &blob->oob);
+
+	return 0;
+}
+
+int asan_test_bump_blob(void)
+{
+	const int iters = 20;
+	int ret, i;
+
+	ret = bump_init(ST_PAGES);
+	if (ret) {
+		bpf_printk("bump_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = 0; i < iters && can_loop; i++) {
+		ret = asan_test_bump_blob_one();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			return ret;
+		}
+	}
+
+	bump_destroy();
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+int asan_test_bump_array_one(void)
+{
+	size_t bytes = 37;
+	size_t overrun = 13;
+	size_t alignment = 1;
+	char __arena *mem;
+	int i;
+
+	mem = bump_alloc(sizeof(*mem) * bytes, alignment);
+	if (!mem)
+		return -ENOMEM;
+
+	for (i = 0; i < bytes + overrun && can_loop; i++) {
+		mem[i] = 0xba;
+		ASAN_VALIDATE_ADDR(i >= bytes, &mem[i]);
+	}
+
+	ASAN_VALIDATE();
+
+	return 0;
+}
+
+int asan_test_bump_array(void)
+{
+	const size_t iters = 20;
+	int ret, i;
+
+	ret = bump_init(ST_PAGES);
+	if (ret) {
+		bpf_printk("bump_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = 0; i < iters && can_loop; i++) {
+		ret = asan_test_bump_array_one();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			return ret;
+		}
+	}
+
+	bump_destroy();
+
+	return 0;
+}
+
+int asan_test_bump_all(void)
+{
+	const int iters = 50;
+	int ret, i;
+
+	ret = bump_init(ST_PAGES);
+	if (ret) {
+		bpf_printk("bump_init failed with %d", ret);
+		return ret;
+	}
+
+	for (i = 0; i < iters && can_loop; i++) {
+		ret = asan_test_bump_array_one();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			return ret;
+		}
+
+		ret = asan_test_bump_blob_one();
+		if (ret) {
+			bpf_printk("%s:%d Failed on iteration %d", __func__,
+				   __LINE__, i);
+			return ret;
+		}
+	}
+
+	bump_destroy();
+
+	return 0;
+}
+
+SEC("syscall")
+int asan_test_bump(void)
+{
+	int ret;
+
+	ret = asan_test_bump_blob();
+	if (ret) {
+		bpf_printk("%s:%d test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = asan_test_bump_array();
+	if (ret) {
+		bpf_printk("%s:%d test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	ret = asan_test_bump_all();
+	if (ret) {
+		bpf_printk("%s:%d test failed", __func__, __LINE__);
+		return ret;
+	}
+
+	return 0;
+}
+
+#else
+
+SEC("syscall")
+int asan_test_bump(void)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c
new file mode 100644
index 000000000000..64f506490a14
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_bump.bpf.c
@@ -0,0 +1,281 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+#include <asan.h>
+#include <bump.h>
+
+#include "selftest.h"
+
+#define ST_MAX_PAGES 8
+
+#define PAGE_SHIFT __builtin_ctz(__PAGE_SIZE)
+
+#define ST_MAX_BYTES (ST_MAX_PAGES * __PAGE_SIZE)
+#define ST_BYTES_MAX_SHIFT __builtin_ctz(ST_MAX_BYTES)
+
+#define ST_MIN_ALIGN_SHIFT (7)
+#define ST_MAX_ALIGN_SHIFT (ST_BYTES_MAX_SHIFT - 2)
+
+#define ST_CYCLES 5
+
+#define ST_PATTERN1 0xAA
+#define ST_PATTERN2 0x55
+
+static inline void st_memset(void __arena *mem, u8 byte, size_t size)
+{
+	u8 __arena *bytes = (u8 __arena *)mem;
+	int i;
+
+	bpf_for(i, 0, size) {
+		bytes[i] = byte;
+	}
+}
+
+static inline bool st_isset(void __arena *mem, u8 byte, size_t size)
+{
+	u8 __arena *bytes = (u8 __arena *)mem;
+	int i;
+
+	for (i = 0; i < size && can_loop; i++) {
+		if (bytes[i] != byte)
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Defining oft-repeated snippets as macros to avoid having to propagate
+ * errors to the caller. Both GCC and Clang support statement expressions.
+ */
+
+#define ALLOC_OR_FAIL(bytes, alignment)                                 \
+	({                                                              \
+		void __arena *mem;                                      \
+		mem = bump_alloc((bytes), (alignment));                 \
+		if (!mem) {                                             \
+			bpf_printk("%s:%d bump_alloc failed", __func__, \
+				   __LINE__);                           \
+			bump_destroy();                                 \
+			return -ENOMEM;                                 \
+		}                                                       \
+		mem;                                                    \
+	})
+
+#define INIT_OR_FAIL(bytes)                                             \
+	do {                                                            \
+		if (bump_init(((bytes) / __PAGE_SIZE))) {			\
+			bpf_printk("%s:%d bump_init failed", __func__,	\
+				   __LINE__);                           \
+			return -ENOMEM;                                 \
+		}                                                       \
+	} while (0)
+
+#define CHECK_OR_FAIL(mem, val, size)                                \
+	do {                                                         \
+		if (!st_isset((mem), (val), (size))) {                \
+			bpf_printk("%s:%d val %d missing", __func__, \
+				   __LINE__);                        \
+			return -EINVAL;                              \
+		}                                                    \
+	} while (0)
+
+#define CMP_OR_FAIL(mem1, mem2, size)                                \
+	do {                                                         \
+		if (st_memcmp((mem1), (mem2), (size))) {             \
+			bpf_printk("%s:%d regions differ", __func__, \
+				   __LINE__);                        \
+			return -EINVAL;                              \
+		}                                                    \
+	} while (0)
+
+#define ALIGNED_OR_FAIL(mem, alignment)                                 \
+	do {                                                            \
+		if ((u64)(mem) & ((alignment) - 1)) {                   \
+			bpf_printk("%s:%d invalid alignment", __func__, \
+				   __LINE__);                           \
+			return -EINVAL;                                 \
+		}                                                       \
+	} while (0)
+
+/*
+ * Basic test: 
+ *
+ * - Create the allocator
+ * - Make a single allocation,
+ * - Ensure proper alignment
+ * - Ensure allocation succeeds and values are all 0s.
+ * - Destroy the allocator. Ensure the allocator returns
+ * zeroed out memory.
+ */
+static int bump_selftest_alloc_single(u64 bytes, u64 alignment)
+{
+	u8 __arena *barray;
+	void __arena *mem;
+	int i;
+
+	for (i = 0; i < ST_CYCLES && can_loop; i++) {
+		INIT_OR_FAIL(bytes);
+
+		mem = ALLOC_OR_FAIL(bytes, alignment);
+
+		/* Alignment is assumed to be 2^n. */
+		ALIGNED_OR_FAIL(mem, alignment);
+
+		barray = (u8 __arena *)mem;
+		CHECK_OR_FAIL(barray, 0, bytes);
+
+		/* Check whether we're touching unallocated memory. */
+		st_memset(barray, ST_PATTERN1, bytes);
+		CHECK_OR_FAIL(barray, ST_PATTERN1, bytes);
+
+		bump_destroy();
+	}
+
+	return 0;
+}
+
+__weak
+int bump_selftest_alloc_multiple(u64 bytes, u64 alignment)
+{
+	void __arena *mem1, *mem2;
+	int ret;
+
+	/* Initialize the allocator */
+	ret = bump_init(ST_MAX_PAGES);
+	if (ret) {
+		bpf_printk("bump_init failed with %d", ret);
+		return ret;
+	}
+
+	mem1 = ALLOC_OR_FAIL(bytes, alignment);
+	st_memset(mem1, ST_PATTERN1, bytes);
+
+	mem2 = ALLOC_OR_FAIL(bytes, alignment);
+	st_memset(mem2, ST_PATTERN2, bytes);
+
+	ALIGNED_OR_FAIL(mem1, alignment);
+	ALIGNED_OR_FAIL(mem2, alignment);
+
+	/* Verify first block still has pattern1 */
+	CHECK_OR_FAIL(mem1, ST_PATTERN1, bytes);
+	CHECK_OR_FAIL(mem2, ST_PATTERN2, bytes);
+
+	bump_destroy();
+	return 0;
+}
+
+__weak
+int bump_selftest_alloc_aligned(void)
+{
+	void __arena *mem;
+	u64 alignment;
+	int round;
+
+	INIT_OR_FAIL(ST_MAX_PAGES * __PAGE_SIZE);
+
+	/* 
+	 * Allocate 1 byte at a time to test allocator alignment. 
+	 * Test ascending and descending allocation orders.
+	 */
+	for (round = 0; round < 2 && can_loop; round++) {
+		for (alignment = 1; alignment <= __PAGE_SIZE && can_loop;
+		     alignment <<= 1) {
+			mem = ALLOC_OR_FAIL(1, alignment);
+			ALIGNED_OR_FAIL(mem, alignment);
+		}
+
+		for (alignment = __PAGE_SIZE; alignment >= 1 && can_loop;
+		     alignment >>= 1) {
+			mem = ALLOC_OR_FAIL(1, alignment);
+			ALIGNED_OR_FAIL(mem, alignment);
+		}
+	}
+
+	bump_destroy();
+
+	return 0;
+}
+
+__weak
+int bump_selftest_alloc_exhaustion(u64 bytes, u64 alignment)
+{
+	size_t allocs = bytes / alignment;
+	void __arena *mem;
+	int i;
+
+	INIT_OR_FAIL(ST_MAX_PAGES * __PAGE_SIZE);
+
+	if (bump_memlimit(bytes)) {
+		bpf_printk("%s:%d bump_memlimit failed", __func__,
+			   __LINE__);
+		return -EINVAL;
+	}
+
+	/* Make an unfullfilable allocation. */
+	mem = bump_alloc(bytes + 1, 1);
+	if (mem) {
+		bpf_printk("%s:%d bump_alloc succeeded", __func__,
+			   __LINE__);
+		bump_destroy();
+		return -EINVAL;
+	}
+
+	/*
+	 * Amounts to allocations of size alignment, but also
+	 * checks that alignment padding is properly accounted for.
+	 */
+	for (i = 0; i < allocs && can_loop; i++)
+		ALLOC_OR_FAIL(1, alignment);
+
+	/* Even a single byte allocation should fail. */
+	mem = bump_alloc(1, alignment);
+	if (mem) {
+		bpf_printk("%s:%d bump_alloc succeeded", __func__,
+			   __LINE__);
+		bump_destroy();
+		return -EINVAL;
+	}
+
+	bump_destroy();
+	return 0;
+}
+
+#define BUMP_ALLOC_SELFTEST(suffix, ...) \
+	ALLOC_SELFTEST(bump_selftest_##suffix, __VA_ARGS__)
+
+
+SEC("syscall")
+int bump_selftest(void)
+{
+	int shift, ashift;
+	u64 alignment;
+	u64 bytes;
+
+	/* Each test manages its own allocator lifecycle. */
+
+	bpf_for(shift, PAGE_SHIFT, ST_BYTES_MAX_SHIFT + 1) {
+		bytes = 1ULL << shift;
+		bpf_for(ashift, PAGE_SHIFT, shift + 1) {
+			alignment = 1ULL << ashift;
+			BUMP_ALLOC_SELFTEST(alloc_single, bytes, alignment);
+			BUMP_ALLOC_SELFTEST(alloc_multiple, bytes, alignment);
+		}
+	}
+
+	BUMP_ALLOC_SELFTEST(alloc_aligned);
+
+	bytes = 1ULL << ST_BYTES_MAX_SHIFT;
+	bpf_for(ashift, ST_MIN_ALIGN_SHIFT, ST_MAX_ALIGN_SHIFT + 1) {
+		alignment = 1ULL << ashift;
+		BUMP_ALLOC_SELFTEST(alloc_exhaustion, bytes, alignment);
+	}
+
+	return 0;
+}
+
+__weak char _license[] SEC("license") = "GPL";
-- 
2.49.0

