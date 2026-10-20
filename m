Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520348;
	b=eGu7AsA1/A59oWI345sMkLYInYbax+624y95PKalBP9zFaUbpDdqiH4bZe+GXRiEZVl3
	 SP+8hK+mLJTE7Yb7u3sHUAv6SxBcIIpL1feIJYv5Gt/XfpmfEzVDxDy0QOX3wVjQLk+AG
	 P1s+c1niFXK3QCKpC6Xpgoqlf+c2pVgYDNCvaQAt1gczVquAxxyFb0R01qyk7t91aH/ft
	 XeyYjDOi+91ly/MKQRj4tl03VkxkU/fBXVsA6QYIshFfI3JPvz+WcB1nNt93M4PF7MBcu
	 quihuo/HXAC41GpL8Q2Jlo23eKYPRcuKVrU90iZFoTJvtSDL1kZc9Ty3yj7674ltrJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Aen4fc7YwA/+gisG++WZnUlMqdc4Pyx1N36NTDPbn3Y=;
	b=Hihvr3GSFyX/983qXh7tLZY4R11muAYqlEPvxCXnS5MWkLPjNRchpzfjf6o/vlrP5gFS
	 st2pjFAvCSkvw4DKCH+bHpmrkVr/Rrub9diywXvsOmme13cSrckQ8OSlQjdfgkrFKXmRj
	 1USls/jMpGvAKcJT9nfT1WHJOivFOlZ3nmkn9GG9tLZLhSNcw9rT4euXWJN3RClFWCHRs
	 7h+CEQ3UqoF+nZulODRcuX/ICFptsyL3629bZ3TOdnAhdvMXh0mAFYjV0OfLpifdUoDpG
	 Wd4+CeD0i8NdxHN4azpgSifdRkWjddb72BbP8JnW7acFhDaQCxNDCaiV18yRlSvcwzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=UdnO7bnA;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1E60A260D
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F1E60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=UdnO7bnA
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so54475a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792520347; x=1793125147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aen4fc7YwA/+gisG++WZnUlMqdc4Pyx1N36NTDPbn3Y=;
        b=UdnO7bnA75cN9cUf6mzIfwqfhJ5QVhedpA3S+9XyKeoWK6iFvvW9Ew9PF34JsI8GcK
         dIpkrx52J9Xr97z0LmJBop+CN7gM88x6sB2Nc9v4eC0ioRepZMbFXgy5kgJu02OP03gi
         FvWrRLUxmgieKPQ31+rhwOzze1qkV5SH0nrlBf3pQ1YNkv7RSkNkg7g4vrAbqelyI9+k
         1YqCNoxbk7dzlWyQfWBBt24Fl1sB/o/SXxIzPebCbURoWVijkU+vqrDKgCZgxgZ92Cxw
         I3GLvaWq1imQFGkwfWbQzBu3MHeegknY/vjh6BDEWUNTMDrE1f9QB5MrATgA0GCxXW1C
         rWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520347; x=1793125147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Aen4fc7YwA/+gisG++WZnUlMqdc4Pyx1N36NTDPbn3Y=;
        b=lX4YHL4LrF2JB6HQHSylgqimtV/dmfZz4A9NONUTOpuRs0KiITmOos9PG/2QhnoEvO
         a/Rx2QZ1MsQqcxPdp9UZHgJ3IshW+BkY5XFkccetP9FHG5MYFE1+4CJkyNoHE7gakFdw
         VSSYDWNPCzqLZQUQN1xtRQG3P+uQfC6eEB3b7hSbwrMGj4OanGdveZfv+YN28tkOOmnM
         mqYdaEq/1JA17A/rxyZSpJUowRPrxEOCi4/rPNNr6fyfYxb8ytCMTnQw9ZDeFr7A72St
         YQHBBhv4sVr08w5RwSF5ah1VuuBHrbbM0BmaTjtknr3Lea2uNQ88lNMVOMRBfwDiKaSB
         uIZA==
X-Gm-Message-State: AFq9FYKw4r1bCrVPXmSiZXdOl2nlbEUJHD8VutMkw0R0glo7RRGgS7iK
	rZ4DiyUkVFlR+EzcKiZDfz5fbd/EeZuuqBWHkD6lEF3uD0sd6oxieNNHAdlAXAE5KjvAxYrOuBI
	p0udYyaw=
X-Gm-Gg: AYBFou37yUZhSpIaQ4iV4Rn0xCKtf9A83XKqw8ziU8kPS5zibSovBlP0P/XemAzpDgT
	6O3FLZuXrGxnRhhOEJucN5hyoQOUqoBDnTNLRUHGk+ml/vKh9PybSH8e21j8Ise6Q45Uz4PzLx4
	x8w69RN58XEq114xdVodcSdnO/M37RSoIzIyEjzlK2VILnBMuM+BjbvkF3MQD1oO+qNWZ1SYXvr
	NKt6+8P7AcKG2BWtlzvo8J1RbqPgFTv4Dkk53aoqQ4bjPmAfUC9CePtCVkDupf2UxxUHYBiVHCP
	vstx5AJNt6o4Gd/3dKdyXAEyXj4nei76cdf+87SSDB6cEVuVeUX+x6qFat0/FpKilxCnEhDAAJs
	7o5NZCrIeAtKceS6Et1QaPwX9ggyFBAWd0auXrKCMDXz/z9VLQHCNCgygVHRstihDyw1NJUHZ5H
	M2a+IfwWPztUA5p8iE8RD/o+mXXybWdMlUv5M+OrHRTejFrwcEogxbS2Vti5uIackbRDh9uoRrN
	tKN9xINc+0punqNWWwJOgbfMIYadt4pSoiE
X-Received: by 2002:a17:90b:4403:b0:3ac:8897:7bab with SMTP id 98e67ed59e1d1-3acee277aeamr9336020a91.6.1792520346732;
        Tue, 20 Oct 2026 11:19:06 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm710661a91.2.2026.10.20.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:06 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 3/7] selftests/bpf: libarena: Add buddy per-CPU caches
Date: Tue, 20 Oct 2026 18:18:56 +0000
Message-ID: <20261020181900.6755-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020181900.6755-1-emil@etsalapatis.com>
References: <20261020181900.6755-1-emil@etsalapatis.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every small allocation currently reaches the central buddy allocator and
takes its lock. This serializes otherwise independent callers and touches
the buddy metadata on every allocation and free.

Add a fixed-size LIFO array for each cached order and CPU. Embed the cache
state in struct buddy and allocate each CPU's packed cache from the buddy
during initialization. Cache the eight smallest allocation orders and
retain the aggregate capacity of the two magazines this replaces.

Allocations pop from the local array and frees push onto it without taking
the buddy lock. Empty and full arrays fall through to the central buddy
allocator. Packed arrays avoid linked-list traversal and separately
allocated magazine containers on the fast path.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |   3 +
 .../libarena/include/libarena/buddy_cache.h   |  45 +++++
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   9 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 172 +++++++++++++++++-
 4 files changed, 224 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 0ac888be365c..9150a9d22cce 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -2,6 +2,8 @@
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
 #pragma once
 
+#include <libarena/buddy_cache.h>
+
 enum buddy_consts {
 	/*
 	 * Minimum allocation is 1 << BUDDY_MIN_ALLOC_SHIFT.
@@ -69,6 +71,7 @@ struct buddy {
 	struct buddy_chunk __arena *first_chunk;		/* Pointer to the chunk linked list. */
 	arena_spinlock_t lock;			/* Allocator lock */
 	u64 vaddr;				/* Allocation into reserved vaddr */
+	struct buddy_cache_state cache_state;
 };
 
 #ifdef __BPF__
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h
new file mode 100644
index 000000000000..769d966686f5
--- /dev/null
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#pragma once
+
+/* Constants related to the buddy allocator's object caches. */
+enum buddy_cache_consts {
+	/*
+	 * Do not cache larger allocations to avoid excessive
+	 * memory consumption from the per-cpu lists.
+	 */
+	BUDDY_CACHE_NUM_ORDERS = 1 << 3,
+
+	/*
+	 * Just like arena spinlocks, hardcode percpu state to a maximum number of CPUs.
+	 * Since arena spinlocks are a hard dependency, use the exact same limit.
+	 */
+	BUDDY_CACHE_MAX_CPUS = 1024,
+
+	/*
+	 * Items transferred as one batch. This must remain a power of two because
+	 * buddy_alloc_bulk() expresses the number of objects as an order.
+	 */
+	BUDDY_CACHE_BATCH_SIZE = 8,
+
+	/*
+	 * Objects retained locally for each allocation order.
+	 */
+	BUDDY_CACHE_CAPACITY = BUDDY_CACHE_BATCH_SIZE * 2,
+};
+
+struct buddy_cache_order {
+	u32 elems;
+	u32 __pad;
+	void __arena *objects[BUDDY_CACHE_CAPACITY];
+} __attribute__((aligned(64)));
+
+/* Dynamically allocated packed per-CPU slot slab. */
+struct buddy_cache {
+	struct buddy_cache_order orders[BUDDY_CACHE_NUM_ORDERS];
+};
+
+struct buddy_cache_state {
+	struct buddy_cache __arena *percpu[BUDDY_CACHE_MAX_CPUS];
+	bool valid;
+};
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index 5628f0987012..1a1856befeae 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -34,9 +34,18 @@ __weak int test_buddy_create(void)
 		if (ret)
 			return ret;
 
+#ifndef BPF_ARENA_ASAN
+		if (!buddy.cache_state.valid) {
+			buddy_destroy(&buddy);
+			return -EINVAL;
+		}
+#endif
+
 		ret = buddy_destroy(&buddy);
 		if (ret)
 			return ret;
+		if (buddy.cache_state.valid)
+			return -EINVAL;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 72b9ea3ac7d5..ce05e3e58eba 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -4,9 +4,13 @@
 #include <libarena/common.h>
 #include <libarena/asan.h>
 #include <libarena/buddy.h>
+#include <libarena/buddy_cache.h>
 
 #include <bpf_arena_spin_lock.h>
 
+_Static_assert(BUDDY_CACHE_MAX_CPUS == _Q_MAX_CPUS,
+	       "buddy caches must cover every CPU arena spinlocks support");
+
 /*
  * Buddy allocator arena-based implementation.
  *
@@ -38,18 +42,116 @@
  * and their allocation state. It also includes the freelist
  * heads for the allocation itself.
  */
+static u8 idx_get_order(struct buddy_chunk __arena *chunk, u64 idx);
+static u64 arena_next_pow2(__u64 n);
+static u64 size_to_order(size_t size);
+static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
+					int order, size_t norder);
+static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr);
+
+#define buddy_lock(buddy, flags) (arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
+#define buddy_unlock(buddy, flags) (arena_spin_unlock_irqrestore(&(buddy)->lock, (flags)))
+
+/*
+ * Per-CPU caching is disabled in ASAN builds because its additional call-chain
+ * stack usage causes instrumented programs to exceed BPF's 512-byte stack limit.
+ */
+#ifdef BPF_ARENA_ASAN
+#define DISABLE_CACHE_IF_ASAN(...) do { return (__VA_ARGS__); } while (0)
+#else
+#define DISABLE_CACHE_IF_ASAN(...)
+#endif
+
+static __always_inline void __arena *
+buddy_cache_pop(struct buddy_cache __arena *cache, int order)
+{
+	struct buddy_cache_order __arena *slots;
+	void __arena *addr;
+	u32 elems;
+
+	slots = &cache->orders[order];
+	elems = READ_ONCE(slots->elems);
+	if (!elems)
+		return NULL;
+
+	addr = READ_ONCE(slots->objects[elems - 1]);
+	WRITE_ONCE(slots->elems, elems - 1);
+
+	return addr;
+}
+
+static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
+					    int order, void __arena *obj)
+{
+	struct buddy_cache_order __arena *slots;
+	u32 elems;
+
+	slots = &cache->orders[order];
+	elems = READ_ONCE(slots->elems);
+	if (elems >= BUDDY_CACHE_CAPACITY)
+		return -ENOMEM;
+
+	WRITE_ONCE(slots->objects[elems], obj);
+	WRITE_ONCE(slots->elems, elems + 1);
+
+	return 0;
+}
+
+void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
+{
+	struct buddy_cache_state __arena *state = &buddy->cache_state;
+	struct buddy_cache __arena *cache;
+	unsigned int cpu;
+
+	DISABLE_CACHE_IF_ASAN(NULL);
+
+	if (order >= BUDDY_CACHE_NUM_ORDERS)
+		return NULL;
+
+	cpu = bpf_get_smp_processor_id();
+	cache = state->percpu[cpu];
+
+	return buddy_cache_pop(cache, order);
+}
+
+/* Retrieve the order of an allocation from the address. */
+static int buddy_cache_get_order(void __arena *addr)
+{
+	struct buddy_chunk __arena *chunk;
+	u64 idx;
+
+	chunk = (void __arena *)((u64)addr & ~BUDDY_CHUNK_OFFSET_MASK);
+	idx = ((u64)addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
+
+	return idx_get_order(chunk, idx);
+}
+
+int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
+{
+	struct buddy_cache_state __arena *state = &buddy->cache_state;
+	struct buddy_cache __arena *cache;
+	unsigned int cpu;
+	int order;
+
+	DISABLE_CACHE_IF_ASAN(-EINVAL);
+
+	order = buddy_cache_get_order(addr);
+	if (order >= BUDDY_CACHE_NUM_ORDERS)
+		return -EINVAL;
+
+	cpu = bpf_get_smp_processor_id();
+	cache = state->percpu[cpu];
 
+	return buddy_cache_push(cache, order, addr);
+}
 
 enum {
 	BUDDY_POISONED = (s8)0xef,
 
 	/* Number of pages to be allocated per chunk. */
-	BUDDY_CHUNK_PAGES	= BUDDY_CHUNK_BYTES / __PAGE_SIZE
+	BUDDY_CHUNK_PAGES	= BUDDY_CHUNK_BYTES / __PAGE_SIZE,
 };
 
-#define buddy_lock(buddy, flags) (arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
-#define buddy_unlock(buddy, flags) (arena_spin_unlock_irqrestore(&(buddy)->lock, (flags)))
-
 /*
  * Reserve part of the arena address space for the allocator. We use
  * this to get aligned addresses for the chunks, since the arena
@@ -557,6 +659,46 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 	return chunk;
 }
 
+static int buddy_cache_state_init(struct buddy __arena *buddy)
+{
+	struct buddy_cache_state __arena *state = &buddy->cache_state;
+	struct buddy_cache __arena *cache;
+	unsigned int cpu, order;
+	int ret;
+
+	DISABLE_CACHE_IF_ASAN(0);
+
+	if (CONFIG_NR_CPUS > BUDDY_CACHE_MAX_CPUS)
+		return -E2BIG;
+
+	WRITE_ONCE(state->valid, false);
+
+	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
+		ret = buddy_alloc_bulk(buddy, sizeof(*cache), 0,
+				       (void __arena * __arena *)&state->percpu[cpu]);
+		if (ret)
+			return ret;
+
+		cache = state->percpu[cpu];
+		for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+			WRITE_ONCE(cache->orders[order].elems, 0);
+	}
+
+	WRITE_ONCE(state->valid, true);
+
+	return 0;
+}
+
+static void buddy_cache_state_destroy(struct buddy __arena *buddy)
+{
+	struct buddy_cache_state __arena *state = &buddy->cache_state;
+	unsigned int cpu;
+
+	WRITE_ONCE(state->valid, false);
+	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++)
+		WRITE_ONCE(state->percpu[cpu], NULL);
+}
+
 __weak int buddy_init(struct buddy __arena *buddy)
 {
 	struct buddy_chunk __arena *chunk;
@@ -590,7 +732,16 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	buddy_unlock(buddy, flags);
 
-	return chunk ? 0 : -ENOMEM;
+	if (!chunk)
+		return -ENOMEM;
+
+	ret = buddy_cache_state_init(buddy);
+	if (ret) {
+		buddy_destroy(buddy);
+		return ret;
+	}
+
+	return 0;
 }
 
 /*
@@ -606,6 +757,8 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 	if (!buddy)
 		return -EINVAL;
 
+	buddy_cache_state_destroy(buddy);
+
 	/*
 	 * Traverse all buddy chunks and free them back to the arena
 	 * with the same granularity they were allocated with.
@@ -839,9 +992,14 @@ int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
 __weak
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 {
+	void __arena *address;
 	int order;
 
 	order = size_to_order(size);
+	address = buddy_cache_alloc(buddy, order);
+	if (address)
+		return address;
+
 	return buddy_alloc_memory(buddy, size, order, 0);
 }
 
@@ -938,6 +1096,10 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 	if (!addr)
 		return 0;
 
+	ret = buddy_cache_free(buddy, addr);
+	if (!ret)
+		return 0;
+
 	ret = buddy_lock(buddy, flags);
 	if (ret)
 		return ret;
-- 
2.52.0

