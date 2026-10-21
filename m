Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625226;
	b=BZ+r4tATBydHNb2G1ZdLK+kZhfECZ7F7+VfBlHtZ+l3IokpavSsXLh0R89QmB6ePAALB
	 Ct4ieeCCHdK29ZLn7YNSay4/9erBLwKVXk2nOGDk1m7TtwfFouO/seM31uuolid+G0W7Y
	 /UxJkvdEZ2UBPKgcuGGnJr/3ROC6696QzXLq5LiOTDqhus+yMEOJLZNybbihfSfgzjaq0
	 5To0ooGZLgJHrcurTG9MDqTVFgjLFsav22X2FdzZ+NbpIucUydSHctEmjlQd9qYkbt1Rh
	 7fcqAG33q6PsYf2uvIkZC5fzjy/SYxS1crHoJqJwJovntvVArfXQDi72ZV5kXHaa9DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FsYeRjBqU3c5FuyR1XSxXnR7ukLItLZ8lKzob+qhlNg=;
	b=AeJlikt12LS/lBeH+5OL3kxhnMJF9nMIilH/EIt/nxAa79Kinsccta8U2yRfhecoqaiV
	 kpW/qfqWH0cNj5BkWFH79iWsas2BwCNnVmnZjwSYpQDW1WjRn2W6/TrmjR8m3BrQ4GAss
	 xS+RloEjE0C3pu3H9AFtPsL9WUj5P8DMKlkCmy4NT+6NN+QqGCY3PV7aeK7xoMe96IJyu
	 fdMMc/0T2NxUCQlk02VPzpVuVPTSrQctaV6lTdl7GtFYA5Hh5XxFTPKn+FRT8WJ5+y/RO
	 idzmw3PO7WwaAPu3sr8812iLQnP0vUkSci7wqmlfIhV7XQUUUfOkiytQmSwJUg8FAGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kE6vJbB6;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161FD606A31A
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 161FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kE6vJbB6
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e977109392so7952775ad.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792625225; x=1793230025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FsYeRjBqU3c5FuyR1XSxXnR7ukLItLZ8lKzob+qhlNg=;
        b=kE6vJbB6E24IQvq5VqN1EzbolOFS4Vs1+Kx1NEzxA3yAUHVyPIyQsHMcaL7o7/gINR
         fMwVI77EaLA8L7GWS/ZaElKq8MWJZEP7lVCjEUkxbN/AHI6gHW/4i6diiYIg2VG71OJ+
         NaDPFw8bjULjFzvXXJ+Xjpp1fri0gX7Z6efqXNeaeIPwqqtkhkW5klSaUsmvZ6dNMm6w
         a6A9xTmdA7BzFSyjd2/dR4naj+vky9BNu6YFY6iRBxnU+tRZNVhFfeR/+oBaCLnjHD8/
         GhyF2F6a2XQb6m8DxXH756vJXV6okG6xzxUAV4Rm/0kDijeWC+kFW6Disgg4SjjDq8W+
         2QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625225; x=1793230025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FsYeRjBqU3c5FuyR1XSxXnR7ukLItLZ8lKzob+qhlNg=;
        b=1W2ZpNgaF5ifT8RSlApCA/Rt4NGkDuEf4LwOkZkeYD/axRo8sJH+QDx4tRd2jVwWnX
         LMzWQ1iThfP5G3W9oo5MZbfKZesWl1q5dH/EdkPeopi3ecA64OWt750Jb4MSKwqo4WXK
         OuFBZ9T4PgvV8p07xYAXbUN4I+sMtitUR/wPjrtWftoRLtlA2ZLgF2CcxH8uTsAreY9m
         c0dWDW4L/qCPRHG6SiZxPXnxov2Lg7ZqiE8otzTlg/SALgwagINxEBVfx5AzdDMTuXvW
         bO9dz/c92sx+qs2xktS5eOMQ+8/3DzWD2v9iKjZZIcgq3FnJ1VjScEO4HeWyzfSJRLGN
         jxdA==
X-Gm-Message-State: AFq9FYJkYZL84BBwPL2gy8o3K3YJEhGJv8x9BTtFnRsUxxL0zmVRPblJ
	toGV2yXjpFmc1ilQIR46ub5Wlg0yaGgzsVBhcJ6Sq0vL8lknYluzjzaPu2rWx15F7zv3RCRB1XE
	JXmvATiDmIg==
X-Gm-Gg: AYBFou2VUNxVqqTVGmAGaUQ1d6hcvnbrKlfSdziFEmsnvBAw3Df5PAXax0NAl5B/oDZ
	ye1P7N+zLsRDIpt3aeeNwf6vhnshRcqcODz4U5Opd10xtjZ0IVgOmM4GdL4FSSyWsog/cy8IQ30
	d5ZAfD2w9eif/CCEOImRip7ktuwDA8osk9yq5ceVi5y8ECmHPH4fF/67UTFkUN6wvH5I+3jnVZU
	3YLcbbds2slltt1f5xXbLOz+luDzhDhN32OCD80VzinZ8zaIs0yQoObJdIpI1OmdSeqL+Xk+Scz
	xIt+/8nb6a2nzRzNqnyVjL2V/V6jS33TKchUnuLIamUGkr67S7XRFub6U964EJaeBLNbm5rcjux
	538U5HR5jB55cbNn3sfxaWix/p2ediMoT8Isa0wUrbwuOEaOS4C/wf5XHBAeDxwS+eXuhtI4fbX
	j1GTCeXGZZmQuxzH7I6k4n6A4kePOTDVzPAyPG9lIskGd63srjpEm6CqhS5LlP1KrYXVEDLz2Ry
	XVDJiYRaBZhE0MTz5EmccFKaCkP6D9wGthzu/u/1m75
X-Received: by 2002:a17:902:eccd:b0:2e9:99cc:154d with SMTP id d9443c01a7336-2ea43fd3590mr29291065ad.41.1792625224799;
        Wed, 21 Oct 2026 16:27:04 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:725c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada70sm15651425ad.72.2026.10.21.16.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:27:04 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 3/7] selftests/bpf: libarena: Add buddy per-CPU caches
Date: Wed, 21 Oct 2026 23:26:37 +0000
Message-ID: <20261021232641.10063-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021232641.10063-1-emil@etsalapatis.com>
References: <20261021232641.10063-1-emil@etsalapatis.com>
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

Add a fixed-size LIFO array for each cached order and CPU. Keep the
per-CPU cache pointers in struct buddy and allocate each CPU's packed
cache from the buddy during initialization. Cache the eight smallest
allocation orders, up to 2 KiB. Each array holds 16 objects, bounding each
CPU's cache to about 1.5 KiB.

Allocations pop from the local array and frees push onto it without taking
the buddy lock. Empty and full arrays fall through to the central buddy
allocator. Packed arrays keep the fast path to a bounds check and a single
slot access.

BPF programs only disable migration, so another task can preempt a cache
operation and run on the same CPU, and an IRQ or NMI program can interrupt
one. Claim the CPU with a cmpxchg on a per-CPU flag before touching its
arrays, following the model used by the main BPF memory allocator. An
operation that finds the CPU already claimed falls through to the central
buddy allocator.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  34 +++
 .../bpf/libarena/include/libarena/common.h    |   4 +
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   9 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 215 +++++++++++++++++-
 4 files changed, 257 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index f150e1c37e3d..66349915745b 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -65,10 +65,44 @@ struct buddy_chunk {
 	struct buddy_chunk __arena	*next;
 };
 
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
+	 * Objects retained locally for each allocation order.
+	 */
+	BUDDY_CACHE_CAPACITY = 16,
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
+	/* Claimed by an in-flight cache operation on this CPU. */
+	unsigned int active;
+	struct buddy_cache_order orders[BUDDY_CACHE_NUM_ORDERS];
+};
+
 struct buddy {
 	struct buddy_chunk __arena *first_chunk;		/* Pointer to the chunk linked list. */
 	arena_spinlock_t lock;			/* Allocator lock */
 	u64 vaddr;				/* Allocation into reserved vaddr */
+	struct buddy_cache __arena *percpu[BUDDY_CACHE_MAX_CPUS];
 };
 
 #ifdef __BPF__
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index a6220355a697..a20947911d34 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -22,6 +22,10 @@
 #define __maybe_unused __attribute__((__unused__))
 #endif
 
+#ifndef min
+#define min(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 #define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))
 
 #define ARENA_PAGES (1UL << (32 - __builtin_ffs(__PAGE_SIZE) + 1))
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index 5628f0987012..85a7ea8b2e97 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -34,9 +34,18 @@ __weak int test_buddy_create(void)
 		if (ret)
 			return ret;
 
+#ifndef BPF_ARENA_ASAN
+		if (!buddy.percpu[0]) {
+			buddy_destroy(&buddy);
+			return -EINVAL;
+		}
+#endif
+
 		ret = buddy_destroy(&buddy);
 		if (ret)
 			return ret;
+		if (buddy.percpu[0])
+			return -EINVAL;
 	}
 
 	return 0;
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 6dfaa23089a9..c41e163b014f 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -7,6 +7,9 @@
 
 #include <bpf_arena_spin_lock.h>
 
+_Static_assert(BUDDY_CACHE_MAX_CPUS == _Q_MAX_CPUS,
+	       "buddy caches must cover every CPU arena spinlocks support");
+
 /*
  * Buddy allocator arena-based implementation.
  *
@@ -38,18 +41,162 @@
  * and their allocation state. It also includes the freelist
  * heads for the allocation itself.
  */
+static u8 idx_get_order(struct buddy_chunk __arena *chunk, u64 idx);
+static int idx_is_allocated(struct buddy_chunk __arena *chunk, u64 idx, bool *allocated);
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
+#define buddy_order_cached(order) false
+#else
+#define buddy_order_cached(order) ((order) < BUDDY_CACHE_NUM_ORDERS)
+#endif
+
+static __always_inline struct buddy_cache __arena *
+buddy_cache_enter(struct buddy __arena *buddy)
+{
+	struct buddy_cache __arena *cache;
+
+	/* The caches only exist between buddy_init() and buddy_destroy(). */
+	cache = buddy->percpu[bpf_get_smp_processor_id()];
+	if (unlikely(!cache))
+		return NULL;
+
+	/*
+	 * No support for cache operations from contexts that interrupted or
+	 * preempted an in-flight operation on the same CPU, just like the
+	 * kernel's BPF memory allocator.
+	 */
+	if (cmpxchg(&cache->active, 0, 1))
+		return NULL;
+
+	return cache;
+}
+
+static __always_inline void buddy_cache_exit(struct buddy_cache __arena *cache)
+{
+	smp_store_release(&cache->active, 0);
+}
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
+	struct buddy_cache __arena *cache;
+	void __arena *address = NULL;
+
+	if (!buddy_order_cached(order))
+		return NULL;
+
+	cache = buddy_cache_enter(buddy);
+	if (!cache)
+		return NULL;
+
+	address = buddy_cache_pop(cache, order);
+	buddy_cache_exit(cache);
+
+	return address;
+}
+
+/*
+ * Retrieve the order of an allocation from the address. Reject addresses
+ * that do not start an allocated block so that the locked path can report
+ * them, instead of caching memory that overlaps a live allocation. Cached
+ * objects stay marked as allocated, so freeing an object that is already
+ * cached is not detected.
+ */
+static int buddy_cache_get_order(void __arena *addr)
+{
+	struct buddy_chunk __arena *chunk;
+	bool allocated;
+	u64 idx;
 
+	if ((u64)addr & (BUDDY_MIN_ALLOC_BYTES - 1))
+		return BUDDY_CHUNK_NUM_ORDERS;
+
+	chunk = (void __arena *)((u64)addr & ~BUDDY_CHUNK_OFFSET_MASK);
+	idx = ((u64)addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
+
+	if (idx_is_allocated(chunk, idx, &allocated) || !allocated)
+		return BUDDY_CHUNK_NUM_ORDERS;
+
+	return idx_get_order(chunk, idx);
+}
+
+int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
+{
+	struct buddy_cache __arena *cache;
+	int order;
+	int ret = 0;
+
+	/* Skip the metadata lookup when caching is compiled out. */
+	if (!buddy_order_cached(0))
+		return -EINVAL;
+
+	order = buddy_cache_get_order(addr);
+	if (!buddy_order_cached(order))
+		return -EINVAL;
+
+	cache = buddy_cache_enter(buddy);
+	if (!cache)
+		return -EAGAIN;
+
+	ret = buddy_cache_push(cache, order, addr);
+	buddy_cache_exit(cache);
+
+	return ret;
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
@@ -557,6 +704,41 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 	return chunk;
 }
 
+static int buddy_cache_init(struct buddy __arena *buddy)
+{
+	struct buddy_cache __arena *cache;
+	unsigned int cpu, order;
+	int ret;
+
+	if (!buddy_order_cached(0))
+		return 0;
+
+	if (CONFIG_NR_CPUS > BUDDY_CACHE_MAX_CPUS)
+		return -E2BIG;
+
+	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
+		ret = buddy_alloc_bulk(buddy, sizeof(*cache), 0,
+				       (void __arena * __arena *)&buddy->percpu[cpu]);
+		if (ret)
+			return ret;
+
+		cache = buddy->percpu[cpu];
+		WRITE_ONCE(cache->active, 0);
+		for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+			WRITE_ONCE(cache->orders[order].elems, 0);
+	}
+
+	return 0;
+}
+
+static void buddy_cache_destroy(struct buddy __arena *buddy)
+{
+	unsigned int cpu;
+
+	for (cpu = zero; cpu < min(CONFIG_NR_CPUS, BUDDY_CACHE_MAX_CPUS) && can_loop; cpu++)
+		WRITE_ONCE(buddy->percpu[cpu], NULL);
+}
+
 __weak int buddy_init(struct buddy __arena *buddy)
 {
 	struct buddy_chunk __arena *chunk;
@@ -590,7 +772,16 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	buddy_unlock(buddy, flags);
 
-	return chunk ? 0 : -ENOMEM;
+	if (!chunk)
+		return -ENOMEM;
+
+	ret = buddy_cache_init(buddy);
+	if (ret) {
+		buddy_destroy(buddy);
+		return ret;
+	}
+
+	return 0;
 }
 
 /*
@@ -606,6 +797,8 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 	if (!buddy)
 		return -EINVAL;
 
+	buddy_cache_destroy(buddy);
+
 	/*
 	 * Traverse all buddy chunks and free them back to the arena
 	 * with the same granularity they were allocated with.
@@ -840,9 +1033,17 @@ int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
 __weak
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 {
+	void __arena *address;
 	int order;
 
+	if (!buddy)
+		return NULL;
+
 	order = size_to_order(size);
+	address = buddy_cache_alloc(buddy, order);
+	if (address)
+		return address;
+
 	return buddy_alloc_memory(buddy, size, order, 0);
 }
 
@@ -939,6 +1140,10 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
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

