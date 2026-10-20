Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792532465;
	b=J5UcZq80W1claAkeUYEm3vmA1RjDs3FUj+KMJGfQjVVcp3o5E6upvkm9Wre+rwnKHIu3
	 4RUDh+0rcYvA61g8mXkC7/SVYoEfcs4eIBMOmfyOBVSn5/FcodIfgBC35qhJwYK/D0xqu
	 Tvo2piMvpdmvFkBdOcfMTksDMiSHoX05pUpi1zsoF00XQ4HhI6AwtblEMmP1g9THlcMQa
	 T0cIR2JBL5N1mW04F6KGtYvOVkzd3zMsOWrSbtt9otfBh0WV5wYc2NSCcuWC6mA+hSFqb
	 qP11KxYJXVnrewIrQbfTwa9CqEs1juqdWv9A1FUP+HW6egFIOAbamEp8ZcfliXGDCqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792532465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=Bq6Dtr1WvnqVKw7MzL4T9UCEXoPXhLDEgW33FVyxoIQ=;
	b=wSLlm71Kg1V5Abl/ekyYN54FJBl29k5q9ZzCFNrpBirWo6/UcUOFtMFQ2knXzReIX3BT
	 Cvc0+Eyn1iMyyPISa5WSBWq84KirYzQUoltY99+QTjD5hlBnL+VKKUhCiQ74tYJxkFLao
	 5IiVvIui3c79Vt9aCiJrSyQpxSbqQj4+Nv2XH/N/MIxEgdi1NBG1By4I9QCLsnjHChQ7r
	 HJWBvVTi7U6v+mBFQperq4vxI3l+8j5Enqt0ydGfkqh8cCA7cp0AuYZrYXyi5No+YghKM
	 MdoAFoWBih0oVROvx2ZyrTc6PF2X2NxKU44/Tm11ycrucCDpu8NqZNRsoa+MAo/DBaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LbjBIsTq;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39203606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 21:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39203606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LbjBIsTq
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06e79e152so39218b3a.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792532464; x=1793137264; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bq6Dtr1WvnqVKw7MzL4T9UCEXoPXhLDEgW33FVyxoIQ=;
        b=LbjBIsTq+0fEDsf11sz2yggEH13WqGW8ZGjvYe0fEBk5OB3ypXRzJ6NsEFdXhYnxCd
         wIY0AKot/J9xNoTY/aICqTm2cB2yy2hjV5E9Zwr3NslvoMQ/PEF7qIS6uUZt3DwYzKe4
         kWJt6UOggLYvue1/sVwlZkj0HkEQWHM5EynEryFtOwutcO5zfdyJorcsDXPwG6kuSnWB
         jxWsYNuCNEEA2Za0//jrSMZLCmocKAHwSsPEwimgidw5+sCd4KXg2riFrIS9Ffr/S8O2
         GKLOVZCS9YvNjA0MQ4d9m0O/ScN5Mu01xd6DRvuECx8QdB2hE8RXq1rjhrmZJKJ6msvX
         6qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792532464; x=1793137264;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bq6Dtr1WvnqVKw7MzL4T9UCEXoPXhLDEgW33FVyxoIQ=;
        b=iL4XJi78s4XbITaUY9mW1fkWOAfX8t1+aKRBNEUz7SUA7tl+kf2/qBoFosAtqVZV5K
         gDO17l/lw/KUV+uEl7CYINiVuY9OFJadOS5d/6RQHw6CngVlt5OAL/EwTgCLKWM0HXyL
         l3ruA0xHmLYToXGJIGz3M4Kyt8m9OaC8jiyU3Tq6Jq2IL9ajVtdcxnDJijLNMMRCEteM
         V9nviXzbjZrPio1peMDQOJ1UV0tXHyNglkZZddvkwQ7VKgSk1w8qvoSAd2OvJVVZno2c
         +98Q9qjIJarqvfp/mC9O+edyRRtAgEW/KivuEOEeGxYfwuAT7Vd+fqKEYZHSLNLsFMg9
         3y4w==
X-Forwarded-Encrypted: i=1; AKwUvBzWuXmB68F0mewgHb3CsdWJOowDeeKlXOaVecwyZs/0FgAvDyi+DgK8jJmI2Zz4FFNRNp4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbPJKIta+Qh5PlWIGdbuNszn8scIwE5DIQOh10dcgjZOEbXLl/
	IJhVW7ES/NA3mnftU4/TJ/CexrN7tGh7SNUA68aavs7lfO93Pbr0pRWf
X-Gm-Gg: AYBFou3OFSEJB6xlshh2SKj2CEIxN5KjrCQAvaASTwCF5ek/Juipf7Tb5ZNN/5k/HNw
	KgJiLNWrFAhGyy5T7yyG/LMtxs67moMtsN+q3hmgUo8Zy46SLTVybSA1ixO3cMnK9oCatQN0go0
	5aVR2+RQjZiMXqkHSxOpuVkGrr28U5+0mQCbKmWStgIykg139NOe2sgLqbWuyB+LMvBUDnhFoj1
	am56Buq3fDoekeiZNdfSW4058B56LOOdaZ2Dc0k8fNozGgQZ9e+6pHkNP6LcoapuMpi9OEhzgqb
	S0N5AY1T8ZMdAoMKa72bCN/9pRq14QhL+KIiK2h9Zniko9Cbw2VQFIfs/+9NfPxzI0gTdlxmOTD
	2ir/vInbUb3JC2Aq1dndmbs0JVM4uJUdkTYAMPysD+iMuiKDRDg5G9vzKA7T1Ym8u4jOLaoFvou
	4W9QapYf1QY1pbUETuHTnzAx3KJKBSB2uC+JbgftX0oQ3Qgn93CSLm6FNeQn36jVanCvShoEgF0
	Ke3uijSKU2emVClJ7vjqSYniQLmNUPd0zJzRCL1kgaqv2tXjoX9sTQIsMsQeX5f8sgCwKasC7Jp
	eJM=
X-Received: by 2002:a05:6a20:431e:b0:3dd:a00a:7ac9 with SMTP id adf61e73a8af0-3e287eb91f5mr110545637.54.1792532464247;
        Tue, 20 Oct 2026 14:41:04 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6a86e1b22sm145330a12.19.2026.10.20.14.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 14:41:03 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 21:41:03 +0000
Message-Id: <DM9ZQ59RPJ8P.2S767179JJRCC@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Harry Yoo" <harry@kernel.org>
Subject: Re: [PATCH bpf-next v1 0/7] bpf libarena allocator improvements
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261020181900.6755-1-emil@etsalapatis.com>
References: <20261020181900.6755-1-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 11:18 AM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> object LIFOs, one for each allocator order. This speeds up allocation
> and freeing for BPF programs that have some degree of locality. The
> CPU caches are lockless. The caches are replenished from and spilled
> into "transfer caches", per-order caches shared between the CPUs that
> amortize the cost of spilling/refilling. Data from the transfer caches
> is in turn moved from and to the allocator.

can we drop the transfer caches and spill with buddy_free_bulk() ?
Refill already goes through buddy_alloc_bulk() and buddy_free_bulk()
has no user other than the selftest. That's one buddy lock per 8
objects in both directions.

Spilling is where the series doesn't amortize today. With the transfer
array full a free on a full local cache takes the transfer lock, gets
-ENOMEM, then takes the buddy lock for that one object. The local cache
stays full, so the next free does the same: two locks per free. With
--nallocs 1000 from run_bench_libarena.sh that's about 900 of the 1000
frees of each worker.

There are no numbers in the cover or in the logs, and the benchmark
can't show the case patch 6 is for: bench_malloc_free() times only
arena_malloc() and each worker frees its own objects.

Then no need for struct buddy_transfer_order, the per-order locks,
buddy_transfer_take_batch/put_batch and the second enter on a miss or a
full cache. With the guard in struct buddy_cache active[] and struct
buddy_cache_ctx go away too.

Below leaves out NMI handling, selftests and the pointer validation
that sashiko asked for.

Something like this (not even compile tested):

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 528c69a..ff22795 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -65,10 +65,35 @@ struct buddy_chunk {
 	struct buddy_chunk __arena	*next;
 };

+enum buddy_cache_consts {
+	/* Larger allocations are not cached. */
+	BUDDY_CACHE_NUM_ORDERS	= 1 << 3,
+
+	/* Same limit as arena spinlocks, buddy_init() fails beyond it anyway. */
+	BUDDY_CACHE_MAX_CPUS	= 1024,
+
+	/* Objects moved to and from the buddy at once, as an order. */
+	BUDDY_CACHE_BATCH_ORDER	= 3,
+	BUDDY_CACHE_BATCH_SIZE	= 1 << BUDDY_CACHE_BATCH_ORDER,
+
+	BUDDY_CACHE_CAPACITY	= BUDDY_CACHE_BATCH_SIZE * 2,
+};
+
+struct buddy_cache_order {
+	u32 elems;
+	void __arena *objects[BUDDY_CACHE_CAPACITY];
+} __attribute__((aligned(64)));
+
+struct buddy_cache {
+	unsigned int active;	/* An operation is in flight on this CPU */
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
@@ -76,6 +101,10 @@ struct buddy {
 int buddy_init(struct buddy __arena *buddy);
 int buddy_destroy(struct buddy __arena *buddy);
 int buddy_free(struct buddy __arena *buddy, void __arena *free);
+int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *addrs,
+	size_t naddrs);
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
+int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
+	void __arena * __arena * out);

 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 2490ab1..490133a 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -557,6 +557,139 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 	return chunk;
 }

+/*
+ * Per-CPU caching is disabled in ASAN builds. Cached objects stay unpoisoned
+ * and the additional call chain doesn't fit the stack limit.
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
+	/* A nested or preempting operation on this CPU goes to the buddy. */
+	cache = buddy->percpu[bpf_get_smp_processor_id()];
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
+buddy_cache_pop(struct buddy_cache_order __arena *slots)
+{
+	u32 elems = READ_ONCE(slots->elems);
+
+	if (!elems)
+		return NULL;
+
+	WRITE_ONCE(slots->elems, elems - 1);
+
+	return READ_ONCE(slots->objects[elems - 1]);
+}
+
+static void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t size,
+				       int order)
+{
+	struct buddy_cache_order __arena *slots;
+	struct buddy_cache __arena *cache;
+	void __arena *address;
+
+	if (!buddy_order_cached(order))
+		return NULL;
+
+	cache = buddy_cache_enter(buddy);
+	if (!cache)
+		return NULL;
+
+	slots = &cache->orders[order];
+	address = buddy_cache_pop(slots);
+	if (!address && !buddy_alloc_bulk(buddy, size, BUDDY_CACHE_BATCH_ORDER,
+					  (void __arena * __arena *)slots->objects)) {
+		WRITE_ONCE(slots->elems, BUDDY_CACHE_BATCH_SIZE);
+		address = buddy_cache_pop(slots);
+	}
+
+	buddy_cache_exit(cache);
+
+	return address;
+}
+
+static int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
+{
+	struct buddy_cache_order __arena *slots;
+	struct buddy_cache __arena *cache;
+	struct buddy_chunk __arena *chunk;
+	u32 elems;
+	u64 idx;
+	int order;
+	int ret = 0;
+
+	chunk = (void __arena *)((u64)addr & ~BUDDY_CHUNK_OFFSET_MASK);
+	idx = ((u64)addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
+	order = idx_get_order(chunk, idx);
+	if (!buddy_order_cached(order))
+		return -EINVAL;
+
+	cache = buddy_cache_enter(buddy);
+	if (!cache)
+		return -EAGAIN;
+
+	slots = &cache->orders[order];
+	elems = READ_ONCE(slots->elems);
+	if (elems >= BUDDY_CACHE_CAPACITY) {
+		/* Full. Give a batch back with one trip to the buddy. */
+		elems -= BUDDY_CACHE_BATCH_SIZE;
+		ret = buddy_free_bulk(buddy,
+				      (void __arena * __arena *)&slots->objects[elems],
+				      BUDDY_CACHE_BATCH_SIZE);
+		if (ret)
+			goto out;
+	}
+
+	WRITE_ONCE(slots->objects[elems], addr);
+	WRITE_ONCE(slots->elems, elems + 1);
+
+out:
+	buddy_cache_exit(cache);
+
+	return ret;
+}
+
+static int buddy_cache_init(struct buddy __arena *buddy)
+{
+	struct buddy_cache __arena *cache;
+	unsigned int cpu, order;
+	int ret;
+
+	if (!buddy_order_cached(0))
+		return 0;
+
+	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
+		ret = buddy_alloc_bulk(buddy, sizeof(*cache), 0,
+				       (void __arena * __arena *)&buddy->percpu[cpu]);
+		if (ret)
+			return ret;
+
+		cache = buddy->percpu[cpu];
+		cache->active = 0;
+		for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+			cache->orders[order].elems = 0;
+	}
+
+	return 0;
+}
+
 __weak int buddy_init(struct buddy __arena *buddy)
 {
 	struct buddy_chunk __arena *chunk;
@@ -590,7 +723,14 @@ __weak int buddy_init(struct buddy __arena *buddy)

 	buddy_unlock(buddy, flags);

-	return chunk ? 0 : -ENOMEM;
+	if (!chunk)
+		return -ENOMEM;
+
+	ret = buddy_cache_init(buddy);
+	if (ret)
+		buddy_destroy(buddy);
+
+	return ret;
 }

 /*
@@ -628,7 +768,7 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 	return 0;
 }

-__weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
+__weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req, int order_allocs)
 {
 	struct buddy_header __arena *header, *tmp_header, *next_header;
 	u32 idx, tmpidx, retidx;
@@ -636,7 +776,7 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
 	u64 order = 0;
 	u64 i;

-	for (order = order_req; order < BUDDY_CHUNK_NUM_ORDERS && can_loop; order++) {
+	for (order = order_req + order_allocs; order < BUDDY_CHUNK_NUM_ORDERS && can_loop; order++) {
 		if (chunk->freelists[order] != BUDDY_CHUNK_ITEMS)
 			break;
 	}
@@ -658,11 +798,19 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)

 	header->prev_index = BUDDY_CHUNK_ITEMS;
 	header->next_index = BUDDY_CHUNK_ITEMS;
-	if (idx_set_order(chunk, retidx, order_req))
-		return (u64)NULL;
+	/*
+	 * For a bulk allocation, record the allocation state and size
+	 * of each item separately so each can be freed independently.
+	 */
+	for (i = zero, idx = retidx; i < (1U << order_allocs) && can_loop; i++) {
+		if (idx_set_order(chunk, idx, order_req))
+			return (u64)NULL;

-	if (idx_set_allocated(chunk, retidx, true))
-		return (u64)NULL;
+		if (idx_set_allocated(chunk, idx, true))
+			return (u64)NULL;
+
+		idx += 1U << order_req;
+	}

 	/*
 	 * Do not unpoison the address yet, will be done by the caller
@@ -673,7 +821,7 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
 		return (u64)NULL;

 	/* If we allocated from a larger-order chunk, split the buddies. */
-	for (i = order_req; i < order && can_loop; i++) {
+	for (i = order_req + order_allocs; i < order && can_loop; i++) {
 		/*
 		 * Flip the bit for the current order (the bit is guaranteed
 		 * to be 0, so just add 1 << i).
@@ -706,14 +854,14 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
 }

 /* Scan the existing chunks for available memory. */
-static u64 buddy_alloc_from_existing_chunks(struct buddy __arena *buddy, int order)
+static u64 buddy_alloc_from_existing_chunks(struct buddy __arena *buddy, int order, int norder)
 {
 	struct buddy_chunk __arena *chunk;
 	u64 address;

 	for (chunk = buddy->first_chunk; chunk != NULL && can_loop;
 	     chunk = chunk->next) {
-		address = buddy_chunk_alloc(chunk, order);
+		address = buddy_chunk_alloc(chunk, order, norder);
 		if (address)
 			return address;
 	}
@@ -725,7 +873,8 @@ static u64 buddy_alloc_from_existing_chunks(struct buddy __arena *buddy, int ord
  * Try an allocation from a newly allocated chunk. Also
  * incorporate the chunk into the linked list.
  */
-static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_chunk __arena *chunk, int order)
+static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_chunk __arena *chunk,
+		int order, int norder)
 {
 	unsigned long flags;
 	u64 address;
@@ -741,33 +890,31 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
 	chunk->next = buddy->first_chunk;
 	buddy->first_chunk = chunk;

-	address = buddy_chunk_alloc(buddy->first_chunk, order);
+	address = buddy_chunk_alloc(buddy->first_chunk, order, norder);

 	buddy_unlock(buddy, flags);

 	return (u64)address;
 }
-__weak
-void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
+static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
+		int order, size_t norder)
 {
 	void __arena *address = NULL;
+	u8 __arena *object;
 	struct buddy_chunk __arena *chunk;
+	unsigned int alloc_size;
+	unsigned int i, offset;
 	unsigned long flags;
-	int order;
-
-	if (!buddy)
-		return NULL;

-	order = size_to_order(size);
-	if (order >= BUDDY_CHUNK_NUM_ORDERS || order < 0) {
-		arena_stderr("invalid order %d (sz %lu)\n", order, size);
+	if (order < 0 || order >= BUDDY_CHUNK_NUM_ORDERS || norder >= BUDDY_CHUNK_NUM_ORDERS - order) {
+		arena_stderr("invalid order %d (norder %lu) (sz %lu)\n", order, norder, size);
 		return NULL;
 	}

 	if (buddy_lock(buddy, flags))
 		return NULL;

-	address = (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order);
+	address = (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order, norder);
 	buddy_unlock(buddy, flags);
 	if (address)
 		goto done;
@@ -775,28 +922,76 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 	/* Get a new chunk. */
 	chunk = buddy_chunk_get(buddy);
 	if (chunk)
-		address = (u8 __arena *)buddy_alloc_from_new_chunk(buddy, chunk, order);
+		address = (u8 __arena *)buddy_alloc_from_new_chunk(buddy, chunk, order, norder);

 done:
 	/* If we failed to allocate memory, return NULL. */
 	if (!address)
 		return NULL;

+	alloc_size = BUDDY_MIN_ALLOC_BYTES << order;
+
 	/*
-	 * Unpoison exactly the amount of bytes requested. If the
-	 * data is smaller than the header, we must poison any
-	 * unused bytes that were part of the header.
+	 * Unpoison exactly the requested bytes in each allocation. Keep
+	 * the padding between the requested size and the rounded buddy
+	 * allocation poisoned.
 	 */
-	if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header __arena))
-		asan_poison(address + BUDDY_HEADER_OFF, BUDDY_POISONED,
-			    sizeof(struct buddy_header __arena));
+	for (i = zero, offset = zero; i < (1U << norder) && can_loop; i++, offset += alloc_size) {
+		object = (u8 __arena *)address + offset;

-	asan_unpoison(address, size);
+		if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header __arena))
+			asan_poison(object + BUDDY_HEADER_OFF,
+				    BUDDY_POISONED,
+				    sizeof(struct buddy_header __arena));
+
+		asan_unpoison(object, size);
+	}

 	return address;
 }

-static __always_inline int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
+__weak
+int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
+		void __arena * __arena * out)
+{
+	void __arena *address;
+	unsigned int i, off;
+	unsigned int step;
+	int order;
+
+	if (!buddy || !out || norder >= BUDDY_CHUNK_NUM_ORDERS)
+		return -EINVAL;
+
+	order = size_to_order(size);
+	address = buddy_alloc_memory(buddy, size, order, norder);
+	if (!address)
+		return -ENOMEM;
+
+	step = BUDDY_MIN_ALLOC_BYTES << order;
+	for (i = zero, off = zero; i < (1U << norder) && can_loop; i++, off += step)
+		out[i] = &address[off];
+
+	return 0;
+}
+
+__weak
+void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
+{
+	void __arena *address;
+	int order;
+
+	if (!buddy)
+		return NULL;
+
+	order = size_to_order(size);
+	address = buddy_cache_alloc(buddy, size, order);
+	if (address)
+		return address;
+
+	return buddy_alloc_memory(buddy, size, order, 0);
+}
+
+static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
 {
 	struct buddy_header __arena *header, *buddy_header;
 	u64 idx, buddy_idx, tmp_idx;
@@ -889,6 +1084,9 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 	if (!addr)
 		return 0;

+	if (!buddy_cache_free(buddy, addr))
+		return 0;
+
 	ret = buddy_lock(buddy, flags);
 	if (ret)
 		return ret;
@@ -900,4 +1098,32 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 	return ret;
 }

+/*
+ * Fails only when it can't take the lock, then nothing was freed. Objects that
+ * buddy_free_unlocked() rejects are reported there, like in buddy_free().
+ */
+__weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *addrs, size_t naddrs)
+{
+	unsigned long flags;
+	unsigned int i;
+	int ret;
+
+	if (!buddy || !addrs)
+		return -EINVAL;
+
+	ret = buddy_lock(buddy, flags);
+	if (ret)
+		return ret;
+
+	for (i = zero; i < naddrs && can_loop; i++) {
+		/* NULL pointers are ignored. */
+		if (addrs[i])
+			buddy_free_unlocked(buddy, (u64)addrs[i]);
+	}
+
+	buddy_unlock(buddy, flags);
+
+	return 0;
+}
+
 __weak char _license[] SEC("license") = "GPL";

pw-bot: cr
