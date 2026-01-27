Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C539326949
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537796; cv=none; b=fCWVgFtKuOTXJ4zAku+O+TJPoFNiiknLeFciaN3X1kcbFVImE4zF/YBRBq+uwbt/3bybIV2/mpJCrrfnjW+iZFnPJXLtMDlxk56RjHpBhn63z17JdX4wk7QNlW2gYB9qCHkw1PKOnNEWk79VYaikqqLjBAcbn3rJRMh8qC8IH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537796; c=relaxed/simple;
	bh=mb7bQmkh6CfIXbh+UXRE7uWUAPW+lXun9g1P8SeJWVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJf/2phAfvjPmkMaW5NOkORZ4N4Qj4j0M1eJ4Y/LRaNj7o/uu4K5BfaJhdCm2g0qIKAH2wcAVtSQ0UsCo5iflNAHiNxTu/lQs9eTPrdk57xeTWKWtlmGvrcE2/8HPWo+kOXS5OBLblzZeCeDszIYGNsQz8bFup1SCNnyhbPciGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=a8iNPQtw; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="a8iNPQtw"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-888bd3bd639so1240686d6.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 10:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769537793; x=1770142593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgEz6pNw6DJXYXwdHgZpmuaQtGZDAVZJa+tTJu1WCVA=;
        b=a8iNPQtwvpxN5tWMpsvgu3FiyXkvorJwTTu7j/L+CESNIrk5Sj7RLBCWj7NVaNJ/Dn
         cSm92d+PPHR1tCvLdrPtW8iD4NN7PNwKpRKN0LbtDipJgxjzVSwR5cgm2xLOWcziXHeO
         xJZyRrRCBSswsR46Hw+vIsO3jWA5tW0qXpo/lwaudfCDGoW44dasa4TyAqjHGuWQoegt
         hq0LI6UZG/k7GZuWaWPoAyc18e5KpozSAh6pwvk+3rDZm/Q5QdrxblFLBGS5e0m0Fl/L
         2Eo9sOm3LDxlsVf06gBQocJgBzfRUQ8JkQjBXc56UyDWBGM6a5m7J6iNdGKrEhc56rqf
         /cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537793; x=1770142593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zgEz6pNw6DJXYXwdHgZpmuaQtGZDAVZJa+tTJu1WCVA=;
        b=RZKdGDr9aKnGaNuKUchScl/krFp9ULLlzqTvCdHdAa+Qi4eHnv2yKJFDC0czqLpJTN
         N/XBorDhWsiBOiCxYyHgjlLfBDd89iUJnfJ9pKMD9rRrRkrF3nqX3I/W5OV2aclmmaa0
         KPDLMbieIDDyPowoXgVHGMD1/Uj+FOVfjMWk23zwrcutzHyH5OEgZW85wA05uaE2uwlx
         05yw6ypOvNuhjSYKZtcHp1sMwlJfSmFhMS92d3/DtFrQ/tFxk2MKub6Nxiife+zc7r7I
         ex741RNC7G7iW87uVXsFx8jWMNPHIryU37/Nuwb42HYFThPZmCqmoeAQYIJslBr6k83X
         px9g==
X-Gm-Message-State: AOJu0YzmhDriRvEAqB/0RsJtOtX9KuxcupKnCZjKdzmBptrWgfWab09S
	ot1sHvflmAKS+ZRXtx5cYGzboZXA9KuTyzlxp+Q2Pi+NGZj4jzWMT/h7BVrfdRYRTinxKPlkkbL
	Pfa7A
X-Gm-Gg: AZuq6aI7yYCy/nfgD6QywRTbf09nHR6OpYwcSXb2Wn4mfMzcyZ30PFzesPQ2mcL70Ot
	WxW/0fY3vRIeZAMa2CI3wsEk3NA/H5yZrqXLrlvuW1pLIY5OhPeRTUjjduQKdSgDNMY57AktDEs
	w3l1TaZWFtUhMvdeBboFJH6eddW9Q4lEH3sSfRgISLgLIStg8pgP1zF3qqJo2Pmu7ujA0xv806/
	I3tWv9pTavkDIZsg5F7WlWDTdJRHe/1N7k7Nlfj1u5F/wIuxi75HQsV2DGYPA526QBsDEZtFcsV
	8Okus5627KSGKB5plPcTWA9iazRnA4G3NwNbjIJL7pBI9EBm1TJtvxcP+4uOcRJQGO1CpKczCjN
	+eKB53lgLNNHr/Dx+lSJFEZBk7tuu4TZzl9QYHzwdT89Sb6TfOppbPdr/txoBu8+Tbi0s5VG8bB
	3S2aUU3yCSnQ==
X-Received: by 2002:a05:6214:e45:b0:894:73dc:a7f6 with SMTP id 6a1803df08f44-894cd2d14d8mr36851966d6.2.1769537793094;
        Tue, 27 Jan 2026 10:16:33 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm988181cf.1.2026.01.27.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:16:32 -0800 (PST)
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
Subject: [PATCH v2 10/13] selftest: bpf: Add libarena stack allocator
Date: Tue, 27 Jan 2026 13:16:06 -0500
Message-ID: <20260127181610.86376-11-emil@etsalapatis.com>
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

Add a page-oriented stack allocator to libarena. The allocator
is targeted towards large, page-aligned allocations for BPF
programs and can serve as an intermediate location for pages
freed by custom allocators like slab allocators to avoid constantly
allocating and freeing arena pages.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/include/stack.h    |  44 +++
 .../selftests/bpf/libarena/src/stack.bpf.c    | 338 ++++++++++++++++++
 2 files changed, 382 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/stack.h
 create mode 100644 tools/testing/selftests/bpf/libarena/src/stack.bpf.c

diff --git a/tools/testing/selftests/bpf/libarena/include/stack.h b/tools/testing/selftests/bpf/libarena/include/stack.h
new file mode 100644
index 000000000000..9f9d8fb47935
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/stack.h
@@ -0,0 +1,44 @@
+#pragma once
+
+struct stk_seg;
+typedef struct stk_seg __arena stk_seg_t;
+
+/*
+ * We devote a single page to stk_seg, and size
+ * the void * array so it fits exactly in it.
+ * Account for prev/next pointers (2 * sizeof(void *)).
+ */
+#define STK_SEG_MAX ((__PAGE_SIZE - 2 * sizeof(void *)) / sizeof(void *))
+
+struct stk_seg {
+	void __arena	*elems[STK_SEG_MAX];
+	stk_seg_t	*prev;
+	stk_seg_t	*next;
+};
+
+/*
+ * Extensible stack struct.
+ */
+struct stk {
+	arena_spinlock_t __arena *lock;
+
+	stk_seg_t *first;	/* First stack segment. */
+	stk_seg_t *last;
+
+	stk_seg_t *current;	/* Current stack segment. */
+	__u64 cind;
+
+	__u64 capacity;		/* Free slots in the stack. */
+	__u64 available;	/* Available items in the stack. */
+	__u64 data_size;
+	__u64 nr_pages_per_alloc;
+};
+
+
+u64 stk_alloc(struct stk *stack);
+int stk_init(struct stk *stackp, arena_spinlock_t __arena *lock,
+		__u64 data_size, __u64 nr_pages_per_alloc);
+void stk_destroy(struct stk *stack);
+int stk_free_internal(struct stk *stack, __u64 elem);
+
+#define stk_free(stack, elem) stk_free_internal(stack, (__u64)elem)
diff --git a/tools/testing/selftests/bpf/libarena/src/stack.bpf.c b/tools/testing/selftests/bpf/libarena/src/stack.bpf.c
new file mode 100644
index 000000000000..068cdd75bffc
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/src/stack.bpf.c
@@ -0,0 +1,338 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright (c) 2024-2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2024-2025 Emil Tsalapatis <etsal@meta.com>
+ */
+
+#include <common.h>
+#include <asan.h>
+#include <stack.h>
+
+/*
+ * Necessary for cond_break/can_loop's semantics. According to kernel commit
+ * 011832b, the loop counter variable must be seen as imprecise and bounded
+ * by the verifier. Initializing it from a constant (e.g., i = 0;), then,
+ * makes it precise and prevents may_goto from helping with converging the
+ * loop. For these loops we must initialize the loop counter from a variable
+ * whose value the verifier cannot reason about when checking the program, so
+ * that the loop counter's value is imprecise.
+ */
+static __u64 zero = 0;
+
+enum {
+	STACK_POISONED = (s8)0xef,
+};
+
+__hidden int stk_init(struct stk *stack,
+			  arena_spinlock_t __arg_arena __arena *lock,
+			  __u64 data_size, __u64 nr_pages_per_alloc)
+{
+	if (!stack)
+		return -EINVAL;
+
+	stack->data_size = data_size;
+	stack->nr_pages_per_alloc = nr_pages_per_alloc;
+	stack->lock = lock;
+
+	return 0;
+}
+
+__hidden void stk_destroy(struct stk *stack)
+{
+	stk_seg_t *seg, *next;
+	__u64 nr_pages;
+
+	/* Operation happens unlocked since we are called last. */
+
+	if (!stack)
+		return;
+
+	nr_pages = stack->nr_pages_per_alloc;
+
+	for (seg = stack->first; seg && can_loop; seg = next) {
+		next = seg->next;
+		asan_unpoison(seg, sizeof(*seg));
+		bpf_arena_free_pages(&arena, seg, nr_pages);
+	}
+
+	stack->first = NULL;
+	stack->last = NULL;
+
+	stack->current = NULL;
+	stack->cind = 0;
+
+	stack->capacity = 0;
+	stack->available = 0;
+	stack->data_size = 0;
+	stack->nr_pages_per_alloc = 0;
+}
+
+static int stk_push(struct stk *stack, void __arena *elem)
+{
+	stk_seg_t *stk_seg = stack->current;
+	int ridx = stack->cind;
+
+	stack->current->elems[stack->cind] = elem;
+
+	ridx += 1;
+
+	/* Possibly loop into the next segment. */
+	if (ridx == STK_SEG_MAX) {
+		ridx = 0;
+		stk_seg = stk_seg->next;
+		if (!stk_seg)
+			return -ENOSPC;
+	}
+
+	stack->current = stk_seg;
+	stack->cind = ridx;
+
+	stack->capacity -= 1;
+	stack->available += 1;
+
+	return 0;
+}
+
+static void __arena *stk_pop(struct stk *stack)
+{
+	stk_seg_t *stk_seg = stack->current;
+	void __arena *elem;
+	int ridx = stack->cind;
+
+	/* Possibly loop into previous segment. */
+	if (ridx == 0) {
+		ridx = STK_SEG_MAX;
+		stk_seg = stack->current->prev;
+		/* Possibly loop back into the last segment. */
+		if (!stk_seg)
+			return NULL;
+	}
+
+	ridx -= 1;
+
+	stack->current = stk_seg;
+	stack->cind = ridx;
+
+	elem = stack->current->elems[stack->cind];
+
+	stack->capacity += 1;
+	stack->available -= 1;
+
+	return elem;
+}
+
+static int stk_seg_to_data(struct stk *stack, size_t nelems)
+{
+	int ret, i;
+	u64 data;
+
+	/* Do we have enough empty segments for the conversion? */
+	if (!stack->first || stack->first == stack->last)
+		return -ENOMEM;
+
+	data = (u64)stack->last;
+
+	stack->last->prev->next = NULL;
+	stack->last = stack->last->prev;
+
+	/* We removed a segment. */
+	stack->capacity -= STK_SEG_MAX;
+
+	for (i = zero; i < nelems && can_loop; i++) {
+		asan_poison((void __arena *)data, STACK_POISONED,
+			    sizeof(struct stk_seg));
+
+		/* This operation should never fail. */
+		ret = stk_push(stack, (void __arena *)data);
+		if (ret)
+			return ret;
+
+		data += stack->data_size;
+	}
+
+	return 0;
+}
+
+static void stk_extend(struct stk *stack, stk_seg_t *stk_seg)
+{
+	if (stack->last)
+		stack->last->next = stk_seg;
+
+	stk_seg->prev = stack->last;
+	stk_seg->next = NULL;
+
+	stack->last = stk_seg;
+	stack->capacity += STK_SEG_MAX;
+
+	if (!stack->first)
+		stack->current = stack->first = stk_seg;
+
+	/*
+	 * Do not adjust the current segment/idx because we did not add
+	 * any elements. The new segment will be pushed into during the next
+	 * allocation.
+	 */
+}
+
+static int stk_free_unlocked(struct stk *stack, void __arena *elem)
+{
+	if (!stack)
+		return -EINVAL;
+
+	asan_poison(elem, STACK_POISONED, stack->data_size);
+
+	/* If no more room, repurpose the allocation into a segment. */
+	if (stack->capacity == 0) {
+		asan_unpoison(elem, sizeof(struct stk_seg));
+
+		stk_extend(stack, (stk_seg_t *)elem);
+		return 0;
+	}
+
+	return stk_push(stack, elem);
+}
+
+__weak int stk_free_internal(struct stk *stack, __u64 elem)
+{
+	int ret;
+
+	if (!stack)
+		return -EINVAL;
+
+	ret = arena_spin_lock(stack->lock);
+	if (ret)
+		return ret;
+
+	ret = stk_free_unlocked(stack, (void __arena *)elem);
+
+	arena_spin_unlock(stack->lock);
+
+	return ret;
+}
+
+static int stk_get_arena_memory(struct stk *stack, __u64 nr_pages, stk_seg_t **data_seg, stk_seg_t **stk_seg)
+{
+	size_t nstk_segs;
+	u64 mem;
+
+	_Static_assert(sizeof(struct stk_seg) <= __PAGE_SIZE,
+		       "segment must fit into a page");
+
+	/*
+	 * The code allocates new memory only as segments. The allocation and
+	 * free code freely typecasts the segment buffer into data that can be
+	 * allocated, and vice versa to avoid either ending up with too many
+	 * empty segments under memory pressure, or having no space in the segment
+	 * buffer for a buffer currently being freed.
+	 */
+
+	if (!stack)
+		return -EINVAL;
+
+	nstk_segs = stk_seg ? 2 : 1;
+
+	mem = (__u64)bpf_arena_alloc_pages(&arena, NULL, nstk_segs * nr_pages,
+					   NUMA_NO_NODE, 0);
+	if (!mem)
+		return -ENOMEM;
+
+	/* Poison the entire data segment allocated */
+	*data_seg = (stk_seg_t *)mem;
+	asan_poison((void __arena *)mem, STACK_POISONED, nr_pages * __PAGE_SIZE);
+
+	if (!stk_seg)
+		return 0;
+
+	/* Skip the segment metadata when poisoning. */
+	*stk_seg = (stk_seg_t *)(mem + nr_pages * __PAGE_SIZE);
+	asan_poison((void __arena *)(mem + sizeof(**stk_seg)), STACK_POISONED,
+		nr_pages * __PAGE_SIZE);
+
+	return 0;
+}
+
+static int stk_fill_new_elems(struct stk *stack)
+{
+	stk_seg_t *data_seg, *stk_seg;
+	bool need_stk_seg;
+	__u64 nr_pages;
+	size_t nelems;
+	int ret, i;
+	u64 mem;
+
+	nr_pages = stack->nr_pages_per_alloc;
+	nelems = (nr_pages * __PAGE_SIZE) / stack->data_size;
+	if (nelems > STK_SEG_MAX) {
+		return -EINVAL;
+	}
+
+	/*
+	 * If we have more than two empty segments available,
+	 * try to repurpose one of them into an allocation.
+	 */
+	ret = stk_seg_to_data(stack, nelems);
+	if (!ret)
+		return 0;
+
+	need_stk_seg = stack->capacity < nelems;
+
+	/* Get memory for a new data segment, and possibly a stack segment if necessary. */
+	ret = stk_get_arena_memory(stack, nr_pages, &data_seg, need_stk_seg ? &stk_seg : NULL);
+	if (ret)
+		return ret;
+
+	if (need_stk_seg)
+		stk_extend(stack, stk_seg);
+
+	mem = (u64)data_seg;
+	for (i = zero; i < nelems && can_loop; i++) {
+		ret = stk_push(stack, (void __arena *)mem);
+		if (ret)
+			return ret;
+		mem += stack->data_size;
+	}
+
+	return 0;
+}
+
+static inline __u64 stk_alloc_unlocked(struct stk *stack)
+{
+	void __arena *elem;
+	int ret;
+
+	/* If segment buffer is empty, we have to populate it. */
+	if (stack->available == 0) {
+		/* The call drops the lock on error. */
+		ret = stk_fill_new_elems(stack);
+		if (ret)
+			return 0ULL;
+	}
+
+	/* An elem value of 0 implies error, drop the lock. */
+	elem = stk_pop(stack);
+	if (elem)
+		asan_unpoison(elem, stack->data_size);
+
+	return (__u64)elem;
+}
+
+__weak __u64 stk_alloc(struct stk *stack)
+{
+	u64 elem;
+
+	if (!stack) {
+		bpf_printk("using uninitialized stack allocator");
+		return 0ULL;
+	}
+
+	if (arena_spin_lock(stack->lock))
+		return 0ULL;
+
+	elem = stk_alloc_unlocked(stack);
+
+	arena_spin_unlock(stack->lock);
+
+	return (u64)elem;
+}
+
+__weak char _license[] SEC("license") = "GPL";
-- 
2.49.0

