Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248466;
	b=z0spcJfdOOOsO9OnQMMRMdA7DzZxA/AGRWMN9Wjlkmzg4TtyAop6iPgjTw3ii5A55EMG
	 L2u+laRGH+azhgJCVYSNdVLTwHBbCTubwYubEBgnS0wyJTvoHSCIvr84H9bX5TzTNnSO5
	 NUWEpeytPN7vXv21zOsotojo3nsQDLQBcdOM0abIwcKtPDNbUl1dm5hXPdhcOfG+zGH8r
	 MGREstJuqFyxzr+FnPKSPZYNqZoc/ujeTuiO6FuRHi3S/8jiiwAYCepoSB9i8ouETGHJx
	 mFSjL9kVX/jGzJc5mkCwSjIlohsnn4ZiF8GXfuzsFFV6/jMNUf24TnoQOjwPcBxBnsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XoySOgOOcpApHrhAOSGtXSN5tVrK86SMHANmXDfLtgg=;
	b=qHhF3vYHq71MTXCM7oLH7jle3BwBUMvt6bmjzox3pZwhNAQpmiWGhdGFdGVwlc/OPykE
	 9KIPgvUdZtpFFsYj4O9cqGD6cM0frtOrzD82gFpmtESe5zokgc83ewwvjkaPwd2lJ6gIa
	 dtTAmJFQRkKD/g3fGPX/1IBdsEfDi2mSJH1DCa367FckXqex9lXT8nMUvmbOU/8ZtP8Fa
	 QGMSEtTjh7HHpFflPzM+Olcc0bvdWekeDgEWfOmRsR9Q3FZiOfVcI6oNCgJame8PLfM1p
	 gKyTX/0aqe65SRXByoKRHGPj7UsxUvox7W3KXUJqmDXy1uhb6BkDrZMO96H2Vtj9z2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=V218TXU3;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4560A2639
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEC4560A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=V218TXU3
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso723755a91.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248465; x=1794853265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XoySOgOOcpApHrhAOSGtXSN5tVrK86SMHANmXDfLtgg=;
        b=V218TXU3CPLsUfDd6cqJrkadSYxlpYS+Tlg0qMvZmShnFHxgEF9S50pMaPepuSjlmc
         VDqTPCOqhBAZCYEUzZUMWZb8n9yxxozbbprsCRxcx+iAeuMY32DQ4V9uY3qxJegoJ3TB
         gg5A+0+gfJC9pM6uJ85DyFbfQnaLiqxki2E/8lVXMJ5GtLTYSEriV72jvo0oycUhp/mr
         6ahzrouPmO1/I8CYrimVW6t/YR/w/d6lGPymHXaeFB0lyzn7aZNx27l6H6W4JjBBOmif
         5vS8BdyoP2MFv0a73fbJD6hmeN6vdJRroTdWbAqbok3HqnVmvqCwOPmicmKjlVbuIrQj
         zqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248465; x=1794853265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XoySOgOOcpApHrhAOSGtXSN5tVrK86SMHANmXDfLtgg=;
        b=GOFkWlB75nETlh67tSKviAkRoZf2UkSNw4reIF8vcd4t5B5nmXDorZiAvlZVM3bqT6
         4wZsVil+ACrK7kWojXIDJQWmgEjVuhmd/05wgiP0tuZfY2dYV+av+z1Q0QtB9NsHmTVf
         mrWrYj1H1YqkyAPx4ngfnYgNgGdo3a126a5p/IKbs946wZsQJOSjDfQcUXL0fkLHcwsh
         MEdZUdlQmtDzAnOZ6FY8pKkU07EgPjD2zDXNVweUoZpWH0LVicO8PtsnZAuoCrqtSEaL
         6ZIo4RfBxxK1SVdMNOM8NmHSu13ZGQwlN9oLL9skESPUvSBvn6TCPaXF3S40U5P3AR/i
         yw5A==
X-Gm-Message-State: APuU4Z93ta83Te84jCtPArpeTMknNURs9MVrQJkrJM9XmgQ6aqExj089
	rXeX3ERkCE2MwQATlGHmQgl7CEpgfy+STiEjSxSW/rAnMaJjAdbHwf/tFJ6M2RjLVP3CIFOguEH
	Bb5X4j2o=
X-Gm-Gg: AYBFou3YYIoMchGzHy7I07wDPDXC/x2AlF5iwiA5OqBlAFjgNgfCg8nPbNlpa/tCE9F
	WL7izH+Z2hVwptZUCcCAJ3No1tz+PNajUEJbM4vRNdk0b0JPrXy4Tm6Ro2S220eOcNhlG48I7pV
	uvyLuTz8m4x0f1GPKC3gZ4xh5tP3T/ggVYA4leQLOcRPPQhfMMWZHVpInPPMEY7CqfYaUIvkNlB
	NJQQD8gCIefNmWRXMfWu2nqe1UIJyMudO2EAZk+IQ0oxksoxVpEsXhvaa0Oh/M+CwcMwddV0Ywy
	eOUq93JensVI0llKODfxcIc6o2DfMbUF8oUV2WhqPnkQhvVa0KmV8L0aSA0OsyVpStqAIvQbSyT
	CoGpyGhp4A2Q1CRY35voEilLokTG+G3e/5qzY1Q/X3QavOQLnpzthyTp4BDHE21sOInbAMRtKmB
	kY1Lij2TWWyODaolQSaNA/jIsLG1Dq1fHdD408vYQ/pOmeKlcpXgEqdiaJSzUi8ahhe0In2mg1N
	pMQM/z8J3hsPHymdql+8cLNKhY7SEnflI8osNw+dspjw8QU+24G7V5BLu2DZtQ0eJruozdqLRf6
	PpNMr3M2tbyiPBnDjzYlB2iqyylIKH+2ySFM+P/hWcFpfO5oNW7WeG4SGbPz2L0zSP0WSs2Fkoe
	mPtISsRbLaC5FEVhyJr/xY83phaa9CPaIjW4X8iFf1aCRT0sT
X-Received: by 2002:a17:90b:4f41:b0:3b0:9941:8d41 with SMTP id 98e67ed59e1d1-3b166caf083mr450844a91.28.1794248465020;
        Mon, 09 Nov 2026 10:21:05 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:21:04 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 5/9] selftests/bpf: libarena: Add buddy per-CPU caches
Date: Mon,  9 Nov 2026 18:20:50 +0000
Message-ID: <20261109182055.7581-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109182055.7581-1-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
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
allocation orders, up to 2 KiB. Each array holds 16 objects, retaining up
to 63.75 KiB of objects per CPU. The cache metadata occupies 1600 bytes
and consumes a 2 KiB buddy allocation per CPU.

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
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 220 +++++++++++++++++-
 4 files changed, 261 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 4c96307e2a2d..ec5e79a07540 100644
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
+	BUDDY_CACHE_MAX_CPUS = 8192,
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
index 940e82cc2928..62a49dcf31d6 100644
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
index 514d0a59eaff..13c55cf53e52 100644
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
+
+	if ((u64)addr & (BUDDY_MIN_ALLOC_BYTES - 1))
+		return BUDDY_CHUNK_NUM_ORDERS;
 
+	chunk = (void __arena *)((u64)addr & ~BUDDY_CHUNK_OFFSET_MASK);
+	idx = ((u64)addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
+
+	if (idx_is_allocated(chunk, idx, &allocated) || !allocated)
+		return BUDDY_CHUNK_NUM_ORDERS;
+
+	return idx_get_order(chunk, idx);
+}
+
+__always_inline int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
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
@@ -819,7 +1012,18 @@ static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size
 __weak
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 {
-	return buddy_alloc_memory(buddy, size, size_to_order(size), 0, true);
+	void __arena *address;
+	int order;
+
+	if (!buddy)
+		return NULL;
+
+	order = size_to_order(size);
+	address = buddy_cache_alloc(buddy, order);
+	if (address)
+		return address;
+
+	return buddy_alloc_memory(buddy, size, order, 0, true);
 }
 
 __weak
@@ -984,6 +1188,10 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
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

