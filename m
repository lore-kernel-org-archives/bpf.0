Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714871;
	b=ur0iCXvzX85iAfDJdiUj+VQZx8s4wN+AM/EcTrlPraAgkuk0u4NTWKMyvWWpEEc+lU+N
	 Vupvq7c8uPKefbvl9jcN6IVf/FWI8U2bMTlJuQ0jR7Ud6e2O//HL6c1f+qppiadIbwEOk
	 bU8vT70eobeR67qMEdCe9kCDg5adT1D6VaXOYPDbbJ4BYc7xUZJIHwlh1qiH7dqT/Rge+
	 QDjzMuHkFrHvSLiJ0OLBOqH1sPHo1hZ6MkxogwOFTgQ9WF8HozAD1cp7LfBy7rZCbzle+
	 v3IQt/iqVCiCqYcOAYdDpRcmXs0B3TVK3XW1HSFVtwSr1tTHRsML8qb/tUSDOrFcgjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dHqRYoSJKP7qnQp4SnKs2FhbzPl6T2bdsa4gJFpX2NM=;
	b=UyFyybaeQsySZ8yrTuHyz8hVPL/vkSghyen1Psh0VnE34LHFMy8DLm4idE1840v67X8I
	 9tAe5hIGYR+fkKnL/U/L9kDnxNJUJj0ImsElsszUF+rr7lyJJ/cMAi22ohc3CijIA1VPB
	 dtTsIZ2UtZo1h4StaHWaB4yX2TBp+JEf8J690sfeCbAZY3zJxYeCMOHobIg7zDWRg+IOQ
	 2MKoQDbFvMgiNUU516/G8PRRWdNJteV/ayBFFq0UiYMTpYymPxR9iMXuW8jnG5EF6pb43
	 lAF9sX9bWJthuLADGoRP0uK4tUpVmILm18Uk9BTpjANYDIKsD+rxeaPIInzTzPiZJCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=UUmAOCsy;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37EF606A31D
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C37EF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=UUmAOCsy
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ea7190aea1so1198525ad.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792714870; x=1793319670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dHqRYoSJKP7qnQp4SnKs2FhbzPl6T2bdsa4gJFpX2NM=;
        b=UUmAOCsyyo6qkry1zm6gw6vl3P5rdophQdIBjcjQsQtNTwHx7uAtCFk2fc7NYwVM4t
         s2Mjf7+3nbxwosoJwOQpo68S3KXhL9AfF9MStJB7g158CX+IJAGOSi3yoHNRrsTbEcCm
         buGNKNpQ6MPgjhtHUfs83ehNFB2zQxJaH5KwIUTKfz9GfMIIp+ecNSdXNT+mP4acWhO1
         sVuCUNlf2Zfp968yYvftxU6XWO/8uuX9TIoQwo4zVZ3pfOJ0fGeMivplCZE1QqTNHdmf
         L77Wo7GX0UdiXgb8Wg7c0zDVQelPc0pe5CbVtAemM2GeyaawEtB9aeb0I3/S56VlVypT
         b93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714870; x=1793319670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dHqRYoSJKP7qnQp4SnKs2FhbzPl6T2bdsa4gJFpX2NM=;
        b=ETVbS68sB3p+0QVkG73cvyrrkGDTCdg2YNHmkIo39F6CrcK/vVBUaFgFdKPdv8KPHw
         NpFSCTfale5r1j/7Zf4m+lbrcVyCVvNqjJkILE9b6AeVBlRfsIKpT8ub4aJOdDwdnTj3
         JaqwwiDGvSaiRF7lhWdQuHfN0jKjMevLxz4Trs235V8PAdxhWUlI8cDiQEUtB90pLsVY
         WYlrEwvWeYoeckAy//GtucaxC8QdeuE76RY8RNQ4VWmtBDj8QMYdR4luAXCxSYyMcgsj
         tnv8f3p7rV+TPdqTq7P2HY4dBoGda11i/wtNUTHH2okeqCPLzCIhlUCOmBtCP6zRXkkN
         4fKA==
X-Gm-Message-State: AFq9FYKBhHrdW0Tua1B7Zhq/+NL55hJXjH5UMDtUUX7BoIqlrY5YnYsV
	wX4pbdomO04i+BDDRx3bmNEgqO9u5atfZq3RZprAwJFdG0Kh2FbNzUvcdxigIGHst4OAC3IttwZ
	cstgZvS0mMQ==
X-Gm-Gg: AYBFou0GDB7ZKPZ4eADpdGdlIUrjhd2ZVlGxTFCp+S/pSJc7PwAQXXHa7oimY0xJqX3
	gbM1WX+veJPp5dChKAyibbNyZrkETaMjuJBJjRUSd6hMSmHz/j7D48QerWGqFToDgCYVioC0L5E
	2hrxA/3o3eknG9JKAyRR2FKqyeLceRbS5bZ7Gq9NRn1SRcfM5uPGT4U2++qbxgQwbrJI6kpgdVw
	YXUa/CnLRjbVVzeH/DP5EU7hsbgwGKEU1dvtvOpTvGsxoV71MZsFHCaWWqVT8p7KmxvUa1Mu5Pq
	UtZ6n0X78FvghK2qY0hDtiibW/kowWtjWXBJC2EOEMqHI7N8zWHWfom9XzdENtMgKoAMkYstEZ5
	h8qpzFks75aY7Val+4SkZWHy94pZcgcMu3KnStER6YqFoVmHl1D/QRBHAFb5Va8ZpGeQ1itugYn
	HS65PXMTvEhAtzeQmAe29mMhAUfq9oOpg5wPaDAROFAqagB6EZRG2YZTPs5OEmpyUwu4VR0zrM5
	zkKBBk8/do37W9V0ofoev6LzXnHLOq7A7bKdIY93NIzfO1+R9UbIy4R6YDKFmgfjPg04Oaxex6G
	UqzpmykqUmZTXGL8jg==
X-Received: by 2002:a17:903:26c8:b0:2df:ab73:7e94 with SMTP id d9443c01a7336-2ea7c320f99mr8198425ad.51.1792714869942;
        Thu, 22 Oct 2026 17:21:09 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8892c4sm218649a12.11.2026.10.22.17.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:21:09 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 6/7] selftests/bpf: libarena: Add a transfer cache
Date: Fri, 23 Oct 2026 00:20:55 +0000
Message-ID: <20261023002056.6647-7-emil@etsalapatis.com>
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

Batch refills amortize local-cache misses, but every batch that refills
an empty local array, and every free into a full one, still goes through
the buddy lock. Under contention the buddy lock and its metadata updates
dominate, and spare objects on one CPU cannot serve another.

Add a fixed-size shared transfer array for each cached order, protected
by a per-order lock. A full local cache moves one batch into the
transfer array, and an empty one takes a batch from it before falling
back to the buddy allocator. Embed the transfer arrays in struct buddy so
this layer requires no dynamically allocated containers.

Check the transfer array's count before taking its lock, so that a full
or empty array does not cost a lock acquisition that cannot succeed.
When the array is full or its lock is busy, spill the local batch to the
buddy allocator with buddy_free_bulk(), so the next frees fit in the
local cache instead of each taking the transfer and buddy locks. NMI
context never takes the transfer lock and spills directly. Keep both
slow paths out of line so that cache hits do not pay for them.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  11 ++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 123 +++++++++++++++++-
 2 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 0c984952042a..1c62ae6e3fd0 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -89,6 +89,9 @@ enum buddy_cache_consts {
 	 * Objects retained locally for each allocation order.
 	 */
 	BUDDY_CACHE_CAPACITY = BUDDY_CACHE_BATCH_SIZE * 2,
+
+	/* Number of objects shared between per-CPU caches for each order. */
+	BUDDY_TRANSFER_CAPACITY = BUDDY_CACHE_BATCH_SIZE * 8,
 };
 
 struct buddy_cache_order {
@@ -104,11 +107,19 @@ struct buddy_cache {
 	struct buddy_cache_order orders[BUDDY_CACHE_NUM_ORDERS];
 };
 
+/* Per-order array shared between the per-CPU caches. */
+struct buddy_transfer_order {
+	arena_spinlock_t lock;
+	u32 elems;
+	void __arena *objects[BUDDY_TRANSFER_CAPACITY];
+} __attribute__((aligned(64)));
+
 struct buddy {
 	struct buddy_chunk __arena *first_chunk;		/* Pointer to the chunk linked list. */
 	arena_spinlock_t lock;			/* Allocator lock */
 	u64 vaddr;				/* Allocation into reserved vaddr */
 	struct buddy_cache __arena *percpu[BUDDY_CACHE_MAX_CPUS];
+	struct buddy_transfer_order transfer[BUDDY_CACHE_NUM_ORDERS];
 	struct buddy_deferred_free __arena *deferred_free;
 };
 
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 837d5cf70185..e6528cb5a63d 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -131,9 +131,78 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
 	return 0;
 }
 
+static int buddy_transfer_take_batch(struct buddy __arena *buddy, int order,
+				     struct buddy_cache_order __arena *slots)
+{
+	struct buddy_transfer_order __arena *transfer = &buddy->transfer[order];
+	unsigned long flags;
+	u32 elems, start;
+	unsigned int i;
+	int ret = 0;
+
+	if (arena_spin_lock_irqsave(&transfer->lock, flags))
+		return -EAGAIN;
+
+	elems = READ_ONCE(transfer->elems);
+	if (elems < BUDDY_CACHE_BATCH_SIZE) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	start = elems - BUDDY_CACHE_BATCH_SIZE;
+	for (i = zero; i < BUDDY_CACHE_BATCH_SIZE && can_loop; i++)
+		WRITE_ONCE(slots->objects[i],
+			   READ_ONCE(transfer->objects[start + i]));
+
+	WRITE_ONCE(transfer->elems, start);
+	WRITE_ONCE(slots->elems, BUDDY_CACHE_BATCH_SIZE);
+
+out_unlock:
+	arena_spin_unlock_irqrestore(&transfer->lock, flags);
+	return ret;
+}
+
+static int buddy_transfer_put_batch(struct buddy __arena *buddy, int order,
+				    struct buddy_cache_order __arena *slots)
+{
+	struct buddy_transfer_order __arena *transfer = &buddy->transfer[order];
+	unsigned long flags;
+	u32 elems, local_elems, start;
+	unsigned int i;
+	int ret = 0;
+
+	if (arena_spin_lock_irqsave(&transfer->lock, flags))
+		return -EAGAIN;
+
+	elems = READ_ONCE(transfer->elems);
+	if (elems > BUDDY_TRANSFER_CAPACITY - BUDDY_CACHE_BATCH_SIZE) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	local_elems = READ_ONCE(slots->elems);
+	if (local_elems < BUDDY_CACHE_BATCH_SIZE) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	start = local_elems - BUDDY_CACHE_BATCH_SIZE;
+	for (i = zero; i < BUDDY_CACHE_BATCH_SIZE && can_loop; i++)
+		WRITE_ONCE(transfer->objects[elems + i],
+			   READ_ONCE(slots->objects[start + i]));
+
+	WRITE_ONCE(slots->elems, start);
+	WRITE_ONCE(transfer->elems, elems + BUDDY_CACHE_BATCH_SIZE);
+
+out_unlock:
+	arena_spin_unlock_irqrestore(&transfer->lock, flags);
+	return ret;
+}
+
 /*
- * Refill an empty cache with one trip to the buddy allocator. Kept out of line
- * so that cache hits do not pay for the refill path.
+ * Refill an empty cache from the shared transfer array, or with one trip to the
+ * buddy allocator. Kept out of line so that cache hits do not pay for the refill
+ * path.
  */
 static __noinline void __arena *
 buddy_cache_refill(struct buddy __arena *buddy, struct buddy_cache __arena *cache,
@@ -141,6 +210,11 @@ buddy_cache_refill(struct buddy __arena *buddy, struct buddy_cache __arena *cach
 {
 	struct buddy_cache_order __arena *slots = &cache->orders[order];
 
+	/* Peek without the lock, buddy_transfer_take_batch() rechecks under it. */
+	if (READ_ONCE(buddy->transfer[order].elems) >= BUDDY_CACHE_BATCH_SIZE &&
+	    !buddy_transfer_take_batch(buddy, order, slots))
+		return buddy_cache_pop(cache, order);
+
 	if (buddy_alloc_bulk(buddy, size, BUDDY_CACHE_BATCH_ORDER,
 			     (void __arena * __arena *)slots->objects))
 		return NULL;
@@ -196,6 +270,42 @@ static int buddy_cache_get_order(void __arena *addr)
 	return idx_get_order(chunk, idx);
 }
 
+/*
+ * Make room in a full cache by moving its top batch to the shared transfer
+ * array, or to the buddy allocator when the array is full or busy, then cache
+ * the freed object. Kept out of line so that frees that fit in the cache do not
+ * pay for it.
+ */
+static __noinline int
+buddy_cache_spill(struct buddy __arena *buddy, struct buddy_cache __arena *cache,
+		  int order, void __arena *addr)
+{
+	struct buddy_cache_order __arena *slots = &cache->orders[order];
+	u32 elems;
+	int ret = -ENOMEM;
+
+	/*
+	 * Peek without the lock, buddy_transfer_put_batch() rechecks under it.
+	 * NMIs never take the transfer lock.
+	 */
+	if (!bpf_in_nmi() &&
+	    READ_ONCE(buddy->transfer[order].elems) <=
+	    BUDDY_TRANSFER_CAPACITY - BUDDY_CACHE_BATCH_SIZE)
+		ret = buddy_transfer_put_batch(buddy, order, slots);
+
+	if (ret) {
+		elems = READ_ONCE(slots->elems) - BUDDY_CACHE_BATCH_SIZE;
+		ret = buddy_free_bulk(buddy, (void __arena * __arena *)&slots->objects[elems],
+				      BUDDY_CACHE_BATCH_SIZE);
+		if (ret)
+			return ret;
+
+		WRITE_ONCE(slots->elems, elems);
+	}
+
+	return buddy_cache_push(cache, order, addr);
+}
+
 int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 {
 	struct buddy_cache __arena *cache;
@@ -215,6 +325,8 @@ int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 		return -EAGAIN;
 
 	ret = buddy_cache_push(cache, order, addr);
+	if (ret)
+		ret = buddy_cache_spill(buddy, cache, order, addr);
 	buddy_cache_exit(cache);
 
 	return ret;
@@ -746,6 +858,9 @@ static int buddy_cache_init(struct buddy __arena *buddy)
 	if (CONFIG_NR_CPUS > BUDDY_CACHE_MAX_CPUS)
 		return -E2BIG;
 
+	for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+		WRITE_ONCE(buddy->transfer[order].elems, 0);
+
 	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
 		ret = buddy_alloc_bulk(buddy, sizeof(*cache), 0,
 				       (void __arena * __arena *)&buddy->percpu[cpu]);
@@ -763,10 +878,12 @@ static int buddy_cache_init(struct buddy __arena *buddy)
 
 static void buddy_cache_destroy(struct buddy __arena *buddy)
 {
-	unsigned int cpu;
+	unsigned int cpu, order;
 
 	for (cpu = zero; cpu < min(CONFIG_NR_CPUS, BUDDY_CACHE_MAX_CPUS) && can_loop; cpu++)
 		WRITE_ONCE(buddy->percpu[cpu], NULL);
+	for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+		WRITE_ONCE(buddy->transfer[order].elems, 0);
 }
 
 __weak int buddy_init(struct buddy __arena *buddy)
-- 
2.52.0

