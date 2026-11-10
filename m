Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271129;
	b=glVsEPKdgJKYfhXMqwy38ydVQdACk8aD/Hs8hvQ4Z22HhbZqnkK9gQu6a3KrpkE0XETw
	 6dTjF31KIMeJm5wziyxBsZ/qhOh9F/ms7tKQNuGHnhELj78Oc4ydFYrPn/5LOHEX2X8mz
	 5kj6c4x9sR7iF5DMU9j/xGiIfgn3wrAAqRV/m+699SmPheZ2SE9CByS7/2+t9Vt8eBK4R
	 sz87jWdiofSN5x9SWFP4a0FyVdLrlYFrpClK/6RuvfDVG7S9bMHtHayrsTJvr0zh81ZWN
	 uAj3PL+0+FLGsYL1m2M2d/kJel/2pHcajSKH1QCpbnqjPULuDjzjRLhl+mqVGeRe0Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XP0+cW7uRDFUpl0GpIXDkJZ9sHI1Q76mJQup4VzU4zs=;
	b=DaCj/XF1H6go4YYU+b22tB0arnXebPNJV4VFjeGQtZEVPVfHGjBa1VZkDRcRXiEiILRF
	 fUixj0SteKF+JjTKTh15IworDCasVICBe2zK7wTz+5L+VeHlqA+omR3euETka1TrjHnsd
	 XKFh7WdwMouU0LPsGoMojrBtHcnZK+M1f//vyEFilu/tilobYSSctmxrLqueuqtagsKfT
	 1AkybAH0EUW27eKWbSQp0JJfFPYuCwQ75Imfw+H9eqXjCq+BqDNx2Dv+IAnvUrQiTDdj8
	 +4EEULB6rNoXvR19jtN+6AuwKb8EdmSoycheiHEwu3sDR+Rr7aWfnL1njlFsEZhxrwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=vVlgUEZW;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB0606A326
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1FB0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=vVlgUEZW
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b600fae14dso604591b3a.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271128; x=1794875928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XP0+cW7uRDFUpl0GpIXDkJZ9sHI1Q76mJQup4VzU4zs=;
        b=vVlgUEZWFXOUEaIYn7TfXVzvjY6gvowZtKWwC08iaL1QAuVFm4bXCGYY93fmscaayJ
         o/yaIwBn5hCvo/gThmFmXG+elfx4KtaI+6Oci0licT46zK1UZLLM0xiffdktph1GHReE
         GkqxY0AOoTTh+yc2Jd1k9uM83DDdXbaSkcHm8dDkUPVl/zUBYCyeKBGvFlNDvAqI9Yfa
         1dwPv4QcEZJZX1YTWnyl+ZZ1F70+WBO4A0sw07AG89CMAtQHlqDOQu4aZTcKrD5pWZSu
         h9uWH/e75vyzp1vKqu3Y8P5UWO+MPBJf+WG8gm5WBfubUlPKpv+B19XTOnWuiDdYGEfm
         lNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271128; x=1794875928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XP0+cW7uRDFUpl0GpIXDkJZ9sHI1Q76mJQup4VzU4zs=;
        b=GQAQu5/aJiJgxo9A3jjQcu8mLpHLA6JtUNpEqJr9drOE9XOApl4F6rOcJFzXI1lYaf
         Lsf6H7gbMhnJSQOC5Kip3ns/u7tkUcyOW9I142vjHnpjq4ZEZvDCfmX1ZY75UnvjaEtb
         FTagsO/f13W6/mvNkNv9EkED2yMfcL0yI4TbsYYjZPTOjnt2w8LUfeLfZ20F9y0fOhrC
         ssBtBeeUgSbgZC+aXPWNosdr6ig20T3Qld9nQULAGj8kYD8d0xX6qDP8ZJRQ02I/iC6n
         CyywrZRIdkBRwImguaWAPqwUQt3peVx87/rmEVblhzcHuPWwsySQfa7wykL3FpzM+ZAH
         aI8Q==
X-Gm-Message-State: APuU4Z/hJO45YE5FsR9ghF6zgY88gYEf4AzFSOi46Fp3wSltI/tVpmr0
	nMVehg6RVqwMjs+pptqcW3a6p5q/xVL5o4FtB+FsfTYA2YBcJawOJIJtwv2KBTllVM4grkDQbVU
	VL6NysI4=
X-Gm-Gg: AYBFou1wZwHTLJsdL7G7/Z2YG2CIO0XtGQicnnMqky3NHXDiS0CCxg7CZ57mn0op0Yd
	huVWcK3PLOpzWzozgN+N1+AthmxkmXUdBNgMUiUBOB5OFzkBw/AjdvuAf6thkOge1e3Sr7E+7mP
	3cuyaUEhIaV/LT4mH1A2c5Er+BYRCXP/fclmuWEvEZIwMDYPeF1qOkvXJR1/88Yz+TLeoRD6Urh
	68jfbdi6Mep9xUhRo6+RlSqsQO7lAguTITXmQ7cAArt11uLe44sl5Rp9J+8U/k2+q7kcn7ZolY+
	zMYy0PtBMaAUPqInUALtsRLO/JeG+Bqy1UNsZ+1gqyB3b+rmoXUuyOScR3pCFJ3kXqqLHgv4g7N
	o2xvtCXoAALRGw6QiW5tarHOK/1Rt+6ceH8+utz7vJuU3EFZ4Pts1gz7ER1d6mPblDiVCABiKaR
	L2pInzSc2M84rNp494sGwy/3Z57QzlWdJLFxX5hiLKX7b/5CPnGHUP14hOKYCPRhWpGzlyvzcTZ
	vpTbA4Sx5IsOnwp7RnwQNRpNuzowfJF29IKwoTlH48z+78m1/nd8/fhtl2h2Oak+mgjw0vjHIN7
	hvW/S4EZ2VhagjJITdM+ug1+m/Eb8zUSJWoWr1sELuX2NAutNs98RBVfhyCF3HvVktxxLZdz3M6
	+fLN3sEtFt3UVQFuu4+w6kWQjJOE=
X-Received: by 2002:a17:90b:4cce:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3b166ca2897mr1035588a91.9.1794271128081;
        Mon, 09 Nov 2026 16:38:48 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:47 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 5/9] selftests/bpf: libarena: Add buddy per-CPU caches
Date: Tue, 10 Nov 2026 00:38:34 +0000
Message-ID: <20261110003838.8739-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110003838.8739-1-emil@etsalapatis.com>
References: <20261110003838.8739-1-emil@etsalapatis.com>
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
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 233 +++++++++++++++++-
 4 files changed, 273 insertions(+), 7 deletions(-)

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
index 514d0a59eaff..58e666210fdb 100644
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
+					int order, size_t norder, bool grow);
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
+static void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
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
+static __always_inline int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
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
@@ -819,13 +1012,35 @@ static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size
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
 void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size)
 {
-	return buddy_alloc_memory(buddy, size, size_to_order(size), 0, false);
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
+	return buddy_alloc_memory(buddy, size, order, 0, false);
 }
 
 __weak
@@ -984,6 +1199,10 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
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

