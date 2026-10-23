Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714865;
	b=c0at9kP5c3BnJOXr/g0x0Cca0a6Uy28oRKWuoCgfkKffkPtqzsKjXs8HjlEExGpMrVoY
	 Sa5ivDw/TD2KnrtU5DKLOMYOnvf9hWqTsImxeIvS7+FXk+bx46ToU7tfF/snXSfXHK947
	 xf0siJRMpNff1pFMS3A18QiTDUOUiGtq7kcpuomefgMYzE2qdaavy8bBcodYcnL6Cf1Az
	 DoLdHCFpR9xrDZYAnCzG0k/XnjpaJP4jZaKDHfKl7INFwBK/C85FN3D7TaA7ym2SsiiR/
	 tmyFzBnzwlvszm0EDhm7OsvZn9Lk+g+6PxHOKeh/8w9Hi0bss+OxzZSndCWPvkug5QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2fTA9m+UUrMBbiYCM6pVt1Oys+TDTRqDsD3bGnYf8oY=;
	b=sSPJSThC7OwmfLAY9oSpo1GjBTzO0jsdk4lgIPvaHEPgSGsxzKci+/Q/6lZPmHpEEu+M
	 EJMyh0tNDMYDAO++2bxmc4ARI0vbyAbe1rqW9lGq9QakltHkY8Ww/fpqLbemnZy4LEs4g
	 CuaJDPB/fbYxiX9A9TeMpZP8F2p4YaQwANxLKNoqroxsQ8xn9OnFYwquAblBarkdubB21
	 BZMIUxTaQeZSsjcmjmLcaONWM6UAjydceDtJhsqPvyEwFm2HNAByR2DHPAtHpCCrBcjJS
	 eayPnqZzxsLaw/gOWpQhFgbQ/2RqQK73y78rA/WAmqvSf3LpzdCqPDHP2tLBFnBOkSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=F8SUdvNS;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B1606A31E
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 715B1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=F8SUdvNS
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06e79e152so204405b3a.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792714865; x=1793319665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fTA9m+UUrMBbiYCM6pVt1Oys+TDTRqDsD3bGnYf8oY=;
        b=F8SUdvNS36JJXU0BjXNFlVJuG9mUPl5N7LyG1D0t8H8747XlqlSVktQfqoP5YGEP+z
         uYsZxosPemPjKt+u61fckN7/779oXDUcV1JruYKKi05nO0/CNYIC4gRNLjcVobD2Bv9r
         7zZqWIYjVMTZT6VsrBCwg1PUI1eWK27KwYExwgaSuy4Hb7yVLL/FUV9qVR4FOro5OnQx
         mTQiOoRZagONcNg3buAjpsqNFf/sIDTo3rFG99QPCAXkLNimrbpFAsHox+76yEdumY2B
         LN9DafUpZPxdkwWRql+8VVdWDeinurNmXH//kSZRCIpfaQYUcx8bJZ/hi1uQHS4Os7b5
         A2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714865; x=1793319665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2fTA9m+UUrMBbiYCM6pVt1Oys+TDTRqDsD3bGnYf8oY=;
        b=GNOnmsan2wZx827H/NUkSlWHODDaruHAlXoVlafOeY35zvw8TBVUgpwh05CyNrgxFk
         Rb7v9ZYOqid5yvzXvoKaT3iopC9meYHcwGwldmHRbAi3Nedaqha0wJ/5sMd9g0a3IvTg
         RhJg42LyBIBUexChU7BchD1j6znDYmImoLeu0sdRH1N4qMI/5zI2lVzbqiKG8YMJCwwu
         9A8joycqQmF7z9BI7zslrZGg7QUXx2zG76I7TJ39IjKPFeBR+zGvMk954IEuBF4smd3h
         AAp/yxquo6gROfKZgKTJ5+xPg/tTAaP07kkmzuI5A+8NNK9JjaKTrK+rw7rvQx9V4O3U
         MLVA==
X-Gm-Message-State: AFq9FYLkxDh7NYiu/O2ZgmnE1gNYNjHPGCZs3YoGcjh2aIHolIyqqNce
	6WajVbaiQp97lf4/j7sm0dsvmaz+8oZkZzvgX1EeYJA4/bPoioXuoPOKTzDDLIKzUpqPIcguqVg
	ylO4YJxnQkg==
X-Gm-Gg: AYBFou0Q3eLqckvoopX8VlL7w7RctBnpU4616oOxvPdf4V3U3AjoH4fBqgkuZY8Bt0p
	PPUx6cM0ACZl2C22cwJ771BqJ60V4l7eIoSq85bdf0eZUM4RUlXaFWvJBOZkwsEbrkfybMpIkEG
	T/SVCO0uilF4NUaFexhVuA/4dVqGsL0AoOTz+uH9zO+jOIFCrDOX9v+BUnhlG+6F3h2Rg+zh2qu
	ZDAVRkwHvubWwA85sfv0oWoGuqg2eUwdVH/AnyQj6hhpyjU5nXkTJV6s+kpa0zy+fFCKww9rCLt
	BzJywCSB2YvuyV/l4it4bqVFcx1jsK8Nv9p4DuGy+WA8SolCFlIG9bCF5RR+UKw/TsjSJKscqZo
	3+548iUK36hGoZpHR4Zkz5mC04M6I6nUSmGBOFz5D0bwCxWlJI3WkkMydln0/Dt/eRsi+sVjm4C
	ygoNUibF6h8VSJdkEWnh9ArgfNymrNa1fNxF+frDg5vus5DZpGB5qQSe6EmZuTy+d4H2JqxN2TA
	Is3GCExRnrQTX5l8Znvm+JczKicIkdxdVK/3mjTlIEMPWgYrW6Nozbu0YaVjMHBlESj3ELox0Tv
	rWxipNLdqsHCmsX8fdfZl625msQKdR7R/G9mCDM=
X-Received: by 2002:a05:6a21:7a8e:b0:3e2:b905:12c7 with SMTP id adf61e73a8af0-3e3766e0aa8mr340187637.78.1792714864585;
        Thu, 22 Oct 2026 17:21:04 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8892c4sm218649a12.11.2026.10.22.17.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:21:03 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 3/7] selftests/bpf: libarena: Add buddy per-CPU caches
Date: Fri, 23 Oct 2026 00:20:52 +0000
Message-ID: <20261023002056.6647-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023002056.6647-1-emil@etsalapatis.com>
References: <20261023002056.6647-1-emil@etsalapatis.com>
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
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 220 +++++++++++++++++-
 4 files changed, 262 insertions(+), 5 deletions(-)

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
index 6dfaa23089a9..769f465fded0 100644
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
@@ -38,18 +41,167 @@
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
+	/*
+	 * Only contexts on this CPU claim the cache, so a compiler barrier is
+	 * enough to keep the cache updates before the claim is released.
+	 */
+	barrier();
+	WRITE_ONCE(cache->active, 0);
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
@@ -557,6 +709,41 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
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
@@ -590,7 +777,16 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
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
@@ -606,6 +802,8 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 	if (!buddy)
 		return -EINVAL;
 
+	buddy_cache_destroy(buddy);
+
 	/*
 	 * Traverse all buddy chunks and free them back to the arena
 	 * with the same granularity they were allocated with.
@@ -840,9 +1038,17 @@ int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
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
 
@@ -939,6 +1145,10 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
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

