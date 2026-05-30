Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C40D3264D8
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103642; cv=none; b=U3GU5imOMGjCn0mBpSCZTNxh32UnphZ4pT2/WHPGdf4zObtN8AZURuiq+h4OqTicHxrJbHDph8jymDLjrsXyfVAs6b9OqKJr4wGuHxOqL1dHLMZ700hxSfwU0ffvvuvqrWOhdkXhf4OYUwxpbU4sqvG3wghsa/E+W3HwD/cE6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103642; c=relaxed/simple;
	bh=8YUtvcZtMEXlY6hj44l99PvZo2jO8c8qw15Lg/4JswU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Doyy80CgZqupQMx6ofJ/MJPUKAGNGg1OZdYGylpRIEJoaVI7ScY9M7WbiC0RWBSC+oPtZnEMjPW2u4T92fBpWcQTWVqPnd4RzfGeiB31MMKl2ZDxy5nWy0dY6wRKMDzlIxnF8EpdrKRWg3Qc6D4znQlWPIHKg2PTR9BeHV3gwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYcQ+qLN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYcQ+qLN"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf125989f2so13986715ad.3
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 18:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780103640; x=1780708440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JemCq4xOu13sv+NHnX0mdoKsOWsBmY6CG/eWTvjKDMs=;
        b=pYcQ+qLNPIpyYpL8jahkX5m7yJWauJQs7uBdyRJFWAA5YokGXzqK21JhMmykvp304g
         dDldWK+JLOe1FLGBpAEPsmXQ1CvOIZJsn7S4YwR9KRLNJBAGVTrLfegsl/mPN8cjh9at
         bTdqvZkXDVouSQBH/9u7f2B+2d+F4wvY4vDLDYgc5xKPt4BDVnoOtpDZddmXsJPWI9Gj
         uLqaYVtQz1NHNbAanAZAu0jtsiE51imCQC+fy1OgMvvhk7WahZsXjyNMmnfpCJI4DHUN
         RbfFleAPpKFjxCkY9udrhT+WCAZDk6DCz4ND7v+9JdFLdiqRfGIh2T/t0hsu+H7kYRuq
         XSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780103640; x=1780708440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JemCq4xOu13sv+NHnX0mdoKsOWsBmY6CG/eWTvjKDMs=;
        b=T2/hEGPMikvhihmZ6jSOjJpJd/P5vziqrjFVlEJgv8a/r4KhywSkeqJlfK6+jXyFqo
         wkR7xr35trWOJuzXSDarB250C73210v9RxdrmAmnI2Q2HRaxwzFmELKsIc74ZLm5hFkb
         U+UACTO+Rzdp7Kex9Ir2uH8uFLxZTWJksH/D+++YmRr55BB1m1vYo0vrYQi6ZpXEvqaI
         OFgYKSrTd1R4WjLy8kg3OBaiJifa+jzEkQ4JbccKC88XxcWYrW3JmNaoDOW0CQz17RoX
         tFhy4oVpuVkRM4samw3rI2p9m+QM2IK147rlrDcgLSeT3/vbRWV1pJK5Xm9efqunLNVo
         pVvw==
X-Gm-Message-State: AOJu0YwaZMccUtEj2rgtxnV5vT0xnyZDgoNLDmWLuIS2KHdTgYV+3iSp
	ifjgc7Uxymq/ZFOJlIfULGdNI9gXeFx3YIE5r1HXAYwfUH11IqrQSf6fvvSFMg==
X-Gm-Gg: Acq92OExCSEQyL0xnL4lpEuczba5mIkMWpOfZXQBEy5Ay7FxMQ8athxwBE5j1sdLFJB
	7XcuO1PX3Lpsjm7ODiEmHJ5CvJelDMSui9pp59xv0OOZV9ggevv7qb+l5DALR8rE5ShYDXl8oPO
	OYNUca+rKySx7AbCm+tvYhwYRpSAZpTXFK9ikq80F/8/yAzojredDKJXftvKQa6fimkhmiefvQD
	/ZpgQ4xTxDowrosoig0Cr339Idpu9ALmKwkri/h1HZEnhfw1zfq3JLPRZDN5sWaLv07fIdxnYeZ
	AKz0QzPf/2oDYyZDyUoIudZs2y+Fbf3pux7vKmK5dLSeYrEUp7Xul9hWUvlVw52U/0qVmE+fBFI
	8G86zE9MWS4IQOvcdBib64BbNp/bmLod/oJf1Y4YXbBKVibscEuzfojn7adDnHKZMHqeaW/vkAH
	hQ3+HA6Ft6cGvNm0FJEJUtt5drawNPLt+svnGNwfuNKD5cK/ONOCXdGOOqJUgRlrhqRlbNfgPt4
	/bcQ6p0Nb+lfSDXInlmsClEYANeCPBRtvsl8Ck0bCzXX6kqFQij3BO+wXJHhRV99TwNW1/R
X-Received: by 2002:a17:903:1905:b0:2bd:d7c5:9272 with SMTP id d9443c01a7336-2bf3679f5c3mr26348515ad.6.1780103640226;
        Fri, 29 May 2026 18:14:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239fd85dsm31712065ad.25.2026.05.29.18.13.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 18:13:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	david@kernel.org,
	tj@kernel.org,
	roman.gushchin@linux.dev,
	peterz@infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 bpf-next 4/4] selftests/bpf: Add tests for arena slub-backed allocator
Date: Fri, 29 May 2026 18:13:44 -0700
Message-ID: <20260530011345.99342-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Cover the SLAB_BPF_ARENA path end-to-end:

  - arena_slab: smoke tests for the bpf_arena_alloc/free kfuncs.
  - arena_slab_freeptr_stale_pcs: exercise corrupted in-object
    freepointers to validate get_freepointer() clamping and the
    __refill_objects_node() bounded walk.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/arena_slab.c     |  59 ++++++
 .../prog_tests/arena_slab_freeptr_stale_pcs.c |  28 +++
 .../testing/selftests/bpf/progs/arena_slab.c  | 179 ++++++++++++++++++
 .../bpf/progs/arena_slab_freeptr_stale_pcs.c  | 120 ++++++++++++
 4 files changed, 386 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_slab.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_slab_freeptr_stale_pcs.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_slab.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_slab.c b/tools/testing/selftests/bpf/prog_tests/arena_slab.c
new file mode 100644
index 000000000000..6cbaa6991c6b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_slab.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "arena_slab.skel.h"
+
+void test_arena_slab(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_slab *skel;
+	int ret;
+
+	skel = arena_slab__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_slab__open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_slab_alloc), &opts);
+	ASSERT_OK(ret, "alloc_run");
+	ASSERT_OK(opts.retval, "alloc_retval");
+	ASSERT_EQ(skel->bss->alloc_failed, 0, "no alloc failures");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_slab_free), &opts);
+	ASSERT_OK(ret, "free_run");
+	ASSERT_OK(opts.retval, "free_retval");
+	ASSERT_EQ(skel->bss->free_done, 1, "free completed");
+
+	/* Realloc to make sure freed objects can be returned again. */
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_slab_alloc), &opts);
+	ASSERT_OK(ret, "realloc_run");
+	ASSERT_EQ(skel->bss->alloc_failed, 0, "no alloc failures after free");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_slab_free), &opts);
+	ASSERT_OK(ret, "free_run_2");
+
+	/*
+	 * defer_free() corruption repro. Allocates CORRUPT_N PAGE_SIZE
+	 * objects, then with local IRQs disabled frees each one and
+	 * immediately overwrites its freepointer slot. With IRQs off the
+	 * irq_work IPI raised by defer_free() is deferred; multiple
+	 * defer_free()d objects chain onto the per-cpu llist via the
+	 * poisoned freepointer slots. After local_irq_restore() the IPI
+	 * fires and free_deferred_objects() walks the corrupted llist,
+	 * oopsing on a pre-fix kernel. The spin_trylock __slab_free()
+	 * fix keeps the freed objects out of any in-object llist, so the
+	 * test completes cleanly.
+	 */
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_slab_defer_corrupt), &opts);
+	ASSERT_OK(ret, "defer_corrupt_run");
+	ASSERT_OK(opts.retval, "defer_corrupt_retval");
+	ASSERT_EQ(skel->bss->corrupt_alloc_failed, 0, "no alloc failures in defer_corrupt");
+	ASSERT_EQ(skel->bss->corrupt_done, 1, "defer_corrupt completed");
+
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.arena_slab_leak), &opts);
+	ASSERT_OK(ret, "leak_run");
+	ASSERT_OK(opts.retval, "leak_retval");
+	ASSERT_EQ(skel->bss->leak_alloc_failed, 0, "no alloc failures in leak");
+	ASSERT_EQ(skel->bss->leak_done, 1, "leak completed");
+
+	arena_slab__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/arena_slab_freeptr_stale_pcs.c b/tools/testing/selftests/bpf/prog_tests/arena_slab_freeptr_stale_pcs.c
new file mode 100644
index 000000000000..fbf4f5a7e4b3
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_slab_freeptr_stale_pcs.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "arena_slab_freeptr_stale_pcs.skel.h"
+
+void test_arena_slab_freeptr_stale_pcs(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct arena_slab_freeptr_stale_pcs *skel;
+	int ret;
+
+	skel = arena_slab_freeptr_stale_pcs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "arena_slab_freeptr_stale_pcs__open_and_load"))
+		return;
+
+	ret = bpf_prog_test_run_opts(
+		bpf_program__fd(skel->progs.arena_slab_freeptr_stale_pcs),
+		&opts);
+	ASSERT_OK(ret, "arena_slab_freeptr_stale_pcs_run");
+	ASSERT_OK(opts.retval, "arena_slab_freeptr_stale_pcs_retval");
+	ASSERT_EQ(skel->bss->alloc_failed, 0, "initial allocs");
+	ASSERT_EQ(skel->bss->drain_failed, 0, "drain sheaf allocs");
+	ASSERT_EQ(skel->bss->cycle_alloc_failed, 0, "self-cycle alloc");
+	ASSERT_EQ(skel->bss->cycle_alloc_mismatch, 0, "cycle returned victim");
+	ASSERT_EQ(skel->bss->stale_alloc_null, 1, "stale sheaf alloc rejected");
+	ASSERT_EQ(skel->bss->done, 1, "stale pcs trigger completed");
+
+	arena_slab_freeptr_stale_pcs__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/arena_slab.c b/tools/testing/selftests/bpf/progs/arena_slab.c
new file mode 100644
index 000000000000..738a48c45da3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_slab.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 256); /* number of pages */
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32);
+#else
+	__ulong(map_extra, 0x1ull << 44);
+#endif
+} arena SEC(".maps");
+
+void __arena *bpf_arena_alloc(void *map, __u32 size) __ksym __weak;
+void bpf_arena_free(void *map, void __arena *ptr) __ksym __weak;
+void bpf_local_irq_save(unsigned long *flags) __ksym;
+void bpf_local_irq_restore(unsigned long *flags) __ksym;
+
+#define N 64
+#define LARGE_N 2
+#define CORRUPT_N 8
+#define LEAK_N 16
+
+int alloc_failed;
+int free_done;
+int corrupt_alloc_failed;
+int corrupt_done;
+int leak_alloc_failed;
+int leak_done;
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+static __u8 __arena *objs[N];
+static __u8 __arena *large_objs[LARGE_N];
+static __u64 __arena *corrupt_objs[CORRUPT_N];
+
+/* Sizes > PAGE_SIZE force bpf_arena_alloc() onto the arena_alloc_pages() fallback. */
+static const __u32 large_sizes[LARGE_N] = {
+	PAGE_SIZE + 1,
+	3 * PAGE_SIZE,
+};
+#endif
+
+SEC("syscall")
+int arena_slab_alloc(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	int i;
+
+	for (i = 0; i < N; i++) {
+		__u32 size = 8U << (i & 7); /* 8, 16, 32, ... 1024 */
+		__u8 __arena *p = bpf_arena_alloc(&arena, size);
+
+		if (!p) {
+			alloc_failed = i + 1;
+			return 0;
+		}
+		/*
+		 * Write a sentinel that depends on the slot — proves the object
+		 * is real arena memory and not aliased with another slot.
+		 */
+		p[0] = (__u8)(i + 1);
+		p[size - 1] = (__u8)(i + 1);
+		objs[i] = p;
+	}
+
+	/*
+	 * Exercise the >PAGE_SIZE fallback. bpf_arena_alloc() routes these
+	 * through arena_alloc_pages(); bpf_arena_free() recovers page_cnt
+	 * from page->private and tears the range back down.
+	 */
+	for (i = 0; i < LARGE_N; i++) {
+		__u32 size = large_sizes[i];
+		__u8 __arena *p = bpf_arena_alloc(&arena, size);
+
+		if (!p) {
+			alloc_failed = N + i + 1;
+			return 0;
+		}
+		/* Touch first, middle, and last byte to exercise every mapped page. */
+		p[0] = (__u8)(N + i + 1);
+		p[size / 2] = (__u8)(N + i + 1);
+		p[size - 1] = (__u8)(N + i + 1);
+		large_objs[i] = p;
+	}
+#endif
+	return 0;
+}
+
+SEC("syscall")
+int arena_slab_free(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	int i;
+
+	for (i = 0; i < N; i++) {
+		if (!objs[i])
+			continue;
+		bpf_arena_free(&arena, objs[i]);
+		objs[i] = NULL;
+	}
+	for (i = 0; i < LARGE_N; i++) {
+		if (!large_objs[i])
+			continue;
+		bpf_arena_free(&arena, large_objs[i]);
+		large_objs[i] = NULL;
+	}
+	free_done = 1;
+#endif
+	return 0;
+}
+
+SEC("syscall")
+int arena_slab_defer_corrupt(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < CORRUPT_N; i++) {
+		corrupt_objs[i] = bpf_arena_alloc(&arena, 4096);
+		if (!corrupt_objs[i]) {
+			corrupt_alloc_failed = i + 1;
+			return 0;
+		}
+	}
+
+	/*
+	 * IRQs off so defer_free()'s irq_work IPI accumulates the chain across
+	 * iterations instead of draining between each free.
+	 */
+	bpf_local_irq_save(&flags);
+	for (i = 0; i < CORRUPT_N; i++) {
+		bpf_arena_free(&arena, corrupt_objs[i]);
+		/*
+		 * Freepointer slot for non-debug caches is at object_size/2;
+		 * 2048 for the 4096-byte bucket. Poison defer_free()'s next.
+		 */
+		corrupt_objs[i][2048 / sizeof(__u64)] = 0xdeadbeefdeadbeefULL;
+	}
+	bpf_local_irq_restore(&flags);
+
+	corrupt_done = 1;
+#endif
+	return 0;
+}
+
+/*
+ * Intentional leak across multiple bucket caches; destroyed arena must
+ * still tear down cleanly (no kmem_cache_destroy() WARN, no leak).
+ */
+SEC("syscall")
+int arena_slab_leak(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	int i;
+
+	for (i = 0; i < LEAK_N; i++) {
+		__u32 size = 16U << (i & 7); /* 16, 32, ..., 2048 */
+		__u8 __arena *p = bpf_arena_alloc(&arena, size);
+
+		if (!p) {
+			leak_alloc_failed = i + 1;
+			return 0;
+		}
+		p[0] = (__u8)(i + 1);
+	}
+	leak_done = 1;
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c b/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c
new file mode 100644
index 000000000000..79aeccabaeb4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/arena_slab_freeptr_stale_pcs.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include "bpf_arena_common.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 256);
+#ifdef __TARGET_ARCH_arm64
+	__ulong(map_extra, 0x1ull << 32);
+#else
+	__ulong(map_extra, 0x1ull << 44);
+#endif
+} arena SEC(".maps");
+
+void __arena *bpf_arena_alloc(void *map, __u32 size) __ksym __weak;
+void bpf_arena_free(void *map, void __arena *ptr) __ksym __weak;
+void bpf_preempt_disable(void) __ksym;
+void bpf_preempt_enable(void) __ksym;
+
+#define OBJ_SIZE __PAGE_SIZE
+#define FREEPTR_OFFSET (OBJ_SIZE / 2)
+#define SHEAF_FILL 4
+#define TARGET_IDX SHEAF_FILL
+#define EXTRA_IDX (TARGET_IDX + 1)
+#define NR_OBJS (EXTRA_IDX + 1)
+
+int alloc_failed;
+int drain_failed;
+int cycle_alloc_failed;
+int cycle_alloc_mismatch;
+int stale_alloc_null;
+int done;
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+static __u8 __arena *objs[NR_OBJS];
+#endif
+
+SEC("syscall")
+int arena_slab_freeptr_stale_pcs(void *ctx)
+{
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+	__u8 __arena *victim, *p;
+	__u64 raw;
+	int i;
+
+	for (i = 0; i < NR_OBJS; i++) {
+		objs[i] = bpf_arena_alloc(&arena, OBJ_SIZE);
+		if (!objs[i]) {
+			alloc_failed = i + 1;
+			return 0;
+		}
+		objs[i][0] = i + 1;
+	}
+
+	bpf_preempt_disable();
+
+	/* Fill the per-cpu sheaf so the next free reaches SLUB proper. */
+	for (i = 1; i <= SHEAF_FILL; i++)
+		bpf_arena_free(&arena, objs[i - 1]);
+
+	victim = objs[TARGET_IDX];
+
+	/*
+	 * The PAGE_SIZE-bucket cache has one object per slab and a 4-object
+	 * sheaf. Free @victim while the sheaf is full, then turn its encoded
+	 * NULL freepointer into any non-NULL decoded value. The arena clamp
+	 * keeps non-NULL decoded values in the same slab and object-aligned,
+	 * so this becomes a freelist self-cycle back to @victim.
+	 */
+	bpf_arena_free(&arena, victim);
+	raw = *(__u64 __arena *)(victim + FREEPTR_OFFSET);
+	*(__u64 __arena *)(victim + FREEPTR_OFFSET) = raw ^ 1;
+
+	for (i = 0; i < SHEAF_FILL; i++) {
+		p = bpf_arena_alloc(&arena, OBJ_SIZE);
+		if (!p) {
+			drain_failed = i + 1;
+			goto out;
+		}
+	}
+
+	p = bpf_arena_alloc(&arena, OBJ_SIZE);
+	if (!p) {
+		cycle_alloc_failed = 1;
+		goto out;
+	}
+	if (p != victim)
+		cycle_alloc_mismatch = 1;
+
+	for (i = 0; i < SHEAF_FILL; i++)
+		bpf_arena_free(&arena, victim);
+
+	/*
+	 * The sheaf is full of duplicate victim pointers now. Free the four
+	 * filler objects plus one extra object directly to SLUB, leaving enough
+	 * partial slabs that the next target-slab zero-inuse transition discards
+	 * the target page instead of keeping it on the partial list.
+	 */
+	for (i = 0; i < SHEAF_FILL; i++)
+		bpf_arena_free(&arena, objs[i]);
+	bpf_arena_free(&arena, objs[EXTRA_IDX]);
+
+	bpf_arena_free(&arena, victim);
+
+	p = bpf_arena_alloc(&arena, OBJ_SIZE);
+	if (!p)
+		stale_alloc_null = 1;
+
+	done = 1;
+out:
+	bpf_preempt_enable();
+#endif
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

