Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B180308F26
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537796; cv=none; b=mgYKPJ+X3kkru8HQEdXCDI5sx2Zpfae+WoMqEBThh3bMTvacGHaNjekITVwBuvNFPuq6ap0yevmxrSP5iwJBXZUapbpZz9wwNeTmtpp1XhY4L848ipgQMcrpp5gofWepK3sPFGfGn38cSaSBvaziuT2+WDZdgWtVk2Qac4UMzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537796; c=relaxed/simple;
	bh=gY4V5LV+q98qcscc6WPLSmgFPAZHQj5XrwM2yCCu0jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLyDmU1+PMN9cY4KUfCqGZKf0nI9bzJ9AckNxzrRkdA5+IsTEzA7E05eZI29l8O0kl6+HZuQpXnL+23jFFeRekqh3FV5eD8V36OSwvpst/GMPGobkIpZghvEGR8ZWveMQBEp69a1ZECKg8Ev/iV44LrrRy2gjEMURQxShw6Je/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Tj1Sxxvp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Tj1Sxxvp"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c5386f1c9fso842202085a.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537794; x=1770142594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Rl/5FaxOu0T7OvPYJ+TOjmQgWH3sv6AotqpAiDJgkM=;
        b=Tj1Sxxvpp8lcXYW5aQt5SpdNMgXchlqh1/HPJ/8f5ILId7gfUn/nj8M9cgtVfE5G4V
         cpSzSHtKp/E5aSbW7XfJfPs46hf2Jcsnvcb2eiiPhWfiSLpc41SHXBCtPqTq52U2EfzD
         TPFCAis0+rEReSWA5zbptP/cqkYyDqvH8gdPm48SwXCo6Mb5DEiQOsVs57mfs6V9Aaxf
         gYCC/BrEaqkqKs80TYAJrP9z8/o6MTGkIGEII7ccmdehY/FWGpSMJdpiGEcbL2vSSl/r
         0hQgr2qRxwIOJn846OhzsgtPzoQNpEJJVFjlkd49I5z4Gw5gQW6O9TTMwMlwID6rxD33
         KHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537794; x=1770142594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Rl/5FaxOu0T7OvPYJ+TOjmQgWH3sv6AotqpAiDJgkM=;
        b=hfdLG/cdjDAbEFiUjf8SY3RxXZnZO4AxREFcKtvtHkc4+RDT10NlA7DFfrvJngvvcU
         mevoNdnyUo2K6ez2DeU4h5J3XGXiJ2nbe6N3rRhu96Fh+4+C2FFnl5QVCQeakaHQt3Qc
         OPEYNfJsSY/dRFu4bG5WL4uXueyMNI5kHysH1GrRP1/xaCG6WoPN68hlt4MKJOJQLZPz
         aophNdedEYTVQkofk8U+s0NBcs2ycEGk47tdN2xUupnjfleNA03F/X+d5TFyio9LozP4
         i6Vf02MnABV/Z6ONxW4LWhUduB12lCw07ROwn1m26reaI+bmdBUnUUvqW/d1/YX1uzSp
         m5+A==
X-Gm-Message-State: AOJu0YybqD8i3Xf94NBh7LJqawQESMkjJG/Fd1+RpdcbUjrJL5Qavebu
	iskLiq59AFdyz6fdo5CMKveRxI30pR+aizCyvNbDiHifijQJFHO66v9ePsWHi+9dWdLZW8R63v9
	/dvkq
X-Gm-Gg: AZuq6aJTue0Ry5RAcC3zB2XdXXwH0GWmw98FP8S+ynwWgo86fO/CsigKJ0wujBWEKpL
	Q5jab+a9EwKgrD7MC2dG5oyIT0hx5VwUJF+4CoTjKu5sDLubKLMAXe7YY/36Ep1Cdjy2fGXr4cr
	ZJBMMc5OYgCEanjHzzY+REaiwyYmHt1EDoFwa8MJUI7CWELrtqYIa4A5ofTu972bdMqvxaCaVvC
	iBWlH2NoOXJu7luj8AWeQeZ+r9H3bIn1SnVYnJ3/Dx3VwfGlww2hsVveaseAzARwkpW6/jarF5P
	C+O0pE87JMDJPjE48eVVY47Tqcn13pvWcYYhxzb+ZqBgZfnJEoYDFE7H373PGO7FxpaOdp4Ou/u
	454F7rl+iWm17T8CX3LRZDcH0uHBLyPQ1RlOaqVMP+zxzbf2XMKz3QRVztzEkPhxMnjw90YZKSb
	WWMmqtpf2MX77rzaqH21Oy
X-Received: by 2002:a05:622a:1b8c:b0:4ee:146d:771e with SMTP id d75a77b69052e-5032f8905f7mr31491861cf.29.1769537793816;
        Tue, 27 Jan 2026 10:16:33 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:33 -0800 (PST)
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
Subject: [PATCH v2 11/13] selftests: bpf: Add selftests for the libarena stack allocator
Date: Tue, 27 Jan 2026 13:16:07 -0500
Message-ID: <20260127181610.86376-12-emil@etsalapatis.com>
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

Add ASAN selftests for the stack allocators to ensure proper
ASAN integration.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/selftest.c         |   2 +
 .../libarena/selftests/st_asan_stack.bpf.c    | 253 ++++++++++++++++++
 2 files changed, 255 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/selftests/selftest.c b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
index a0fd7a2e6c46..3e4b8754889f 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/selftest.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/selftest.c
@@ -269,6 +269,7 @@ TEST(bump_selftest);
 
 #ifdef BPF_ARENA_ASAN
 TEST(asan_test_bump);
+TEST(asan_test_stack);
 #endif
 
 static void
@@ -316,6 +317,7 @@ int main(int argc, char *argv[])
 
 #ifdef BPF_ARENA_ASAN
 	run_asan_test_bump();
+	run_asan_test_stack();
 #endif
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf.c
new file mode 100644
index 000000000000..a4c1780e4247
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/selftests/st_asan_stack.bpf.c
@@ -0,0 +1,253 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+
+#include <asan.h>
+#include <stack.h>
+
+#include "selftest.h"
+
+#ifdef BPF_ARENA_ASAN
+
+#include "st_asan_common.h"
+
+#define STACK_PAGES_PER_ALLOC (4)
+#define STACK_ALLOCS (4)
+
+/* 
+ * Keep this test-related array in BSS to avoid
+ * overly burdening the function stack.
+ */
+u64 __arena stk_blks[STACK_ALLOCS];
+
+/*
+ * Spinlock used by the stack allocator.
+ */
+private(ST_STACK) struct stk st_stack;
+u64 __arena st_asan_stack_lock;
+
+static __maybe_unused void stk_blks_dump(void)
+{
+	int i;
+
+	for (i = 0; i < STACK_ALLOCS && can_loop; i++)
+		bpf_printk("[%d] 0x%lx", i, stk_blks[i]);
+}
+
+struct qsort_limits {
+	int lo;
+	int hi;
+};
+
+__always_inline void swap(unsigned int i, unsigned int j)
+{
+	u64 tmp;
+
+	tmp = stk_blks[i];
+	stk_blks[i] = stk_blks[j];
+	stk_blks[j] = tmp;
+}
+
+static __always_inline int qsort_partition(unsigned int lo, unsigned hi)
+{
+	unsigned int i;
+	u64 pivotval;
+	int pivot;
+
+	if (lo >= STACK_ALLOCS || hi >= STACK_ALLOCS) {
+		bpf_printk("%s:%d invalid lo/hi indices %d/%d", __func__,
+			   __LINE__, lo, hi);
+		return 0;
+	}
+
+	pivotval = stk_blks[hi];
+	pivot = lo;
+
+	for (i = lo; i < hi && can_loop; i++) {
+		if (stk_blks[i] > pivotval)
+			continue;
+
+		swap(i, pivot);
+		pivot += 1;
+	}
+
+	swap(pivot, hi);
+
+	return pivot;
+}
+
+static __always_inline int qsort_stack_blocks(void)
+{
+	struct qsort_limits stack[STACK_ALLOCS];
+	struct qsort_limits limits;
+	int stackind = 0;
+	int pivot;
+
+	limits = (struct qsort_limits){ 0, STACK_ALLOCS - 1 };
+	stack[stackind++] = limits;
+
+	while (stackind > 0 && can_loop) {
+		if (stackind <= 0 || stackind > STACK_ALLOCS) {
+			bpf_printk("%s:%d invalid stack index %d", __func__,
+				   __LINE__, stackind);
+			return 0;
+		}
+
+		limits = stack[--stackind];
+		if (limits.lo >= limits.hi)
+			continue;
+
+		pivot = qsort_partition(limits.lo, limits.hi);
+		stack[stackind++] = (struct qsort_limits){
+			.lo = limits.lo,
+			.hi = pivot - 1,
+		};
+
+		if (stackind <= 0 || stackind >= STACK_ALLOCS) {
+			bpf_printk("%s:%d invalid stack index", __func__,
+				   __LINE__);
+			return 0;
+		}
+
+		stack[stackind++] = (struct qsort_limits){
+			.lo = pivot + 1,
+			.hi = limits.hi,
+		};
+	}
+
+	return 0;
+}
+
+int asan_test_stack_uaf_oob_single(u8 __arena __arg_arena *alloced,
+				   u8 __arena __arg_arena *freed)
+{
+	const size_t overshoot = 5;
+	int i;
+
+	/* Use after free check. */
+	stk_free(&st_stack, freed);
+
+	bpf_for(i, 0, __PAGE_SIZE) {
+		freed[i] = 0xba;
+		ASAN_VALIDATE_ADDR(true, &freed[i]);
+	}
+
+	/* 
+	 * Out of bounds check. Assuming the blocks before were
+	 * allocated consecutively, past the end of the block
+	 * the memory is guaranteed to be freed.
+	 */
+	bpf_for(i, 0, __PAGE_SIZE + overshoot) {
+		alloced[i] = 0xba;
+		ASAN_VALIDATE_ADDR(i >= __PAGE_SIZE, &alloced[i]);
+	}
+
+	return 0;
+}
+
+static int asan_sort_stack_blocks()
+{
+	int i;
+
+	qsort_stack_blocks();
+
+	if (!stk_blks[0]) {
+		bpf_printk("NULL stack block pointer");
+		return -EINVAL;
+	}
+
+	for (i = 1; i < STACK_ALLOCS; i++) {
+		if (!stk_blks[i]) {
+			bpf_printk("missing block");
+			return -EINVAL;
+		}
+
+		if (stk_blks[i] != stk_blks[i - 1] + __PAGE_SIZE) {
+			bpf_printk("allocations not consecutive");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static __always_inline int asan_test_stack_uaf_oob(void)
+{
+	u64 base = (u64)(-1);
+	const u64 alloc_size = 4096;
+	u64 block;
+	int ret, i;
+
+	/* Set the stack to support 4KiB allocations. */
+	ret = stk_init(&st_stack, (arena_spinlock_t __arena *)&st_asan_stack_lock,
+			   alloc_size, STACK_PAGES_PER_ALLOC);
+	if (ret) {
+		bpf_printk("stk_init failed with %d", ret);
+		return ret;
+	}
+
+	bpf_for(i, 0, STACK_ALLOCS) {
+		block = (u64)stk_alloc(&st_stack);
+		if (!block) {
+			bpf_printk("allocation %d failed", i);
+			return -ENOMEM;
+		}
+
+		stk_blks[i] = block;
+		base = block < base ? block : base;
+	}
+
+	ret = asan_sort_stack_blocks();
+	if (ret)
+		return ret;
+
+	for (i = 0; i < STACK_ALLOCS && can_loop; i += 2) {
+		if (i + 1 >= STACK_ALLOCS)
+			break;
+
+		if (stk_blks[i] + alloc_size != stk_blks[i + 1]) {
+			bpf_printk("Stack allocations not consecutive");
+			return -EINVAL;
+		}
+
+		ret = asan_test_stack_uaf_oob_single(
+			(u8 __arena *)stk_blks[i],
+			(u8 __arena *)stk_blks[i + 1]);
+		if (ret)
+			return ret;
+	}
+
+	stk_destroy(&st_stack);
+
+	return 0;
+}
+
+SEC("syscall")
+int asan_test_stack(void)
+{
+	int ret;
+
+	ret = asan_test_stack_uaf_oob();
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
+int asan_test_stack(void)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* BPF_ARENA_ASAN */
+
+__weak char _license[] SEC("license") = "GPL";
-- 
2.49.0

