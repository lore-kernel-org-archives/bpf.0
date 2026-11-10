Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271132;
	b=XXCmRP4QdQNAJS4V0AcoCkT+XtMS8bjBnfEYt4Hw9tMZeMN75Vyx0vlC/hsQS0Vb5cYT
	 uCDcxrAoaOUXQkfzNLu4WHENYIXCWuXIniJw5FOx80Sl/gsmFvCz0iEKnwndu8xwKTIeO
	 mZf2w7G+/g7evTAXAZXxXG4qDtnSu0ZUaQgkbf5h1GRcv92j41lM2s20XcKXXuAUJZSwA
	 gRuMkEvPGFI4/U4rqCLQqsNbPkewwsYdxH3t7wNZztJiOZkuv9Yc0iO201VDJuSO6gg1D
	 V/8uuEAifl5Fr4FwEuAfOFWSIFUj+/OrLuHwmGTzERMykF23uTbk8MqD4xMrKU/GTkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vGBa7OIZ0MxlrtcjYZH37iWGX/oNsL9dA7VoB8Hddkk=;
	b=pqiwFms1DLHoSB+hOqCOKS8HE43x1Y+lFDehJqvnOEVKvISW4dq6KH71jv3ol2vBDbe5
	 7dYoNwsE7Leyqrsiffx7oNRbkbz6LitGfbIHN4mlnT2MdvllDNcAFmQ/U+a4w8rHdLTgM
	 arxJpVahBHd23/hU7pqpKKkwIj3L2IbrmbtDwRZQnYvCrfzeSGUJUidCe9snS1nU0WAi9
	 WZq4YqcJpEg52Zpe/jC/aV/1NYe7qdrrmgcqL18eFretSYnJUawFvDy2qsKF1uUXo2MVA
	 wH53841qtFwW3WEm2HEbsE3ZULMe+3T28AsV5f0HKZKE+BnI0J7tKgUylO4WX24G+ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=IoE6djis;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0A60A2605
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD0A60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=IoE6djis
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso852167a91.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271131; x=1794875931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vGBa7OIZ0MxlrtcjYZH37iWGX/oNsL9dA7VoB8Hddkk=;
        b=IoE6djisAVGmJV76zyIatMrTIVrGqOsHMcRTC7OFmXIkYJjWkaPb6wlNB8rMgNjuE9
         JT/43mMdAXJ8qIQlTDAiO0lGYCEAOJSR2+iU4agpNO8+0he12R2sOHrSDQv7HDJcQvOC
         yjd0KfRJS/2PAGkTLa9OTZfud4v7O5bES2eSD3lkcTDhpp1lCzHaMv3sbqZGa0o6Bjce
         +WAH7bf/cTRqUZOkoSdg9tjqscl6fLXZ1w58hXZue2yhlfmpjhPa3EE62hPw4wrR9zr+
         f9OMC7WKwn7mZkfpk6A21ZP/WRDsM+B9KtgeIHe4Xyj5UFOHrGJllaCY4WgGzR6gFX1c
         GpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271131; x=1794875931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vGBa7OIZ0MxlrtcjYZH37iWGX/oNsL9dA7VoB8Hddkk=;
        b=Dcdv/uDjswwUHTrgtyN3QPmpPjvrGP+/g7cgvSbvkHP1UTlf9Nl1ZmLT5h7tWKP8P6
         6qiaZlt1JgB/zTvVBYz3JgbhlBH5FFaV+hzxITcfDXH3tt9vyyze4VqkqCUc8kjJe0Zb
         KE+QmPIeuh32syMY+HRl1KZpoVLYhcT3h/0fp7DrLXRToDEendjRFtgf0NpdMayguams
         ob8jLBp2897db2pHv6v9ImKyGcXNPAOGI5x6VUcvQStSwX7LGicdmfcj+hkN4+Blnc6Q
         Z5fnkgNQOB6zFAlJ54zcA0OM/RM9oBN+CTsoEMF0Mbg3EV3yrc+1Go9JiA2Ceu1yqg6w
         2XgA==
X-Gm-Message-State: APuU4Z+QMoWGazay6GKKf3mLyTNlrAjOKhiJbSUPJhV6xZtiCOmEL8T9
	bxXaDzTmrc6NeLaWvioYbIIXqWQ8t5/RvsOsORfAlmKGZUXrIlM3n5lEKHfWfk9xJ/gMP/Afze5
	287VP
X-Gm-Gg: AYBFou0cGpnsWrThXyHXVt4jOWKVZueMK2va50hoAh91DGAdYwod9QixtXmyvDfwFro
	AhGL5hmogt70MbgN3jQHFly+xsSvRAZ1Tafa8TbbCXBpnSuH/srdckCW75tlIrNT0mFDs/ukrN1
	QB6knM+fZGYo5LMNDXTz3FbMwL8VwB+Uy9Mv8Iwat4UAhZ/KVN4dWznvNyGslRYwCJSner4Ugqr
	M5FMNETnkHPpVTKq1nQcnGFg1MRAvolHXUqWYP4dz6Ff7UqHsKvsm9E8QVQ+P6Gs1vAKUCjiSzL
	61jetaTpXGBjJCq1+8DSEQDbGBlCW5tDnkzTISljUZ++ONKDaGrBcDiQc4L4le7to3VQB66YypM
	mAOJl3MAZnqfiX8wWQCaIbQFciYjZxAIrZQEnc+1bImebL5HUCvXsxUfwLqnh5D/K3avHniDawa
	cL5WZr0iGVCfXSdav5iQG1gRc+VfinlgW7PCKvNZBxe/Mppm3uSSQL/nt+jsgTHcpIWWTERDCcu
	yDvkYku6mp5Z6eqFkTORE4t/rEPSkFeY6Q9c1ZBNfs7k5iUW3SP1XZzHAofPrLRl2z31muHnnXS
	AIaSl2T/JHs76gWcgrdwyoBOWelkawaMhldwI6VcQdrAFedx/4jFQM4ano9HG2B3kJcNI39FVyi
	SXdIUfhInEYlT+Y2SzDp/dyJ7GeU=
X-Received: by 2002:a17:90a:c107:b0:3ad:47ce:3876 with SMTP id 98e67ed59e1d1-3b166d3f6b4mr1195371a91.61.1794271131023;
        Mon, 09 Nov 2026 16:38:51 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:50 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 8/9] selftests/bpf: libarena: Add a transfer cache
Date: Tue, 10 Nov 2026 00:38:37 +0000
Message-ID: <20261110003838.8739-9-emil@etsalapatis.com>
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
local cache instead of each taking the transfer and buddy locks. Use
trylock for both locks in NMI context, deferring frees when the buddy lock
cannot be acquired. Keep both slow paths out of line so that cache hits
do not pay for them.

October 21 measurements in a 16-vCPU VM (means of three runs, 64 or
256 allocations per cycle, 2-8 producers) showed 17-60% lower allocation
latency and 60-74% lower free latency than direct bulk spilling. With
8 producers and 256 allocations per cycle, cross-CPU allocation/free
latencies dropped from 1188/1218 ns to 482/408 ns.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  11 ++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 122 +++++++++++++++---
 2 files changed, 118 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index a4d96909f5b0..154a5d1ed0f1 100644
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
index 23be400f0eaa..467b8eb92d2a 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -128,9 +128,81 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
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
+	ret = buddy_lock(transfer, flags);
+	if (ret)
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
+	ret = buddy_lock(transfer, flags);
+
+	if (ret)
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
@@ -138,6 +210,11 @@ buddy_cache_refill(struct buddy __arena *buddy, struct buddy_cache __arena *cach
 {
 	struct buddy_cache_order __arena *slots = &cache->orders[order];
 
+	/* Peek without the lock, buddy_transfer_take_batch() rechecks under it. */
+	if (READ_ONCE(buddy->transfer[order].elems) >= BUDDY_CACHE_BATCH_SIZE &&
+	    !buddy_transfer_take_batch(buddy, order, slots))
+		return buddy_cache_pop(cache, order);
+
 	if (buddy_alloc_bulk_nogrow(buddy, size, BUDDY_CACHE_BATCH_ORDER,
 				    (void __arena * __arena *)slots->objects))
 		return NULL;
@@ -158,9 +235,8 @@ static void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t size,
 	if (!cache)
 		return NULL;
 
-	/* NMIs cannot take the buddy lock, so they only use what is already cached. */
 	address = buddy_cache_pop(cache, order);
-	if (!address && !bpf_in_nmi())
+	if (!address)
 		address = buddy_cache_refill(buddy, cache, size, order);
 
 	buddy_cache_exit(cache);
@@ -194,9 +270,10 @@ static int buddy_cache_get_order(void __arena *addr)
 }
 
 /*
- * Make room in a full cache by freeing its top batch to the buddy allocator,
- * then cache the freed object. Kept out of line so that frees that fit in the
- * cache do not pay for it.
+ * Make room in a full cache by moving its top batch to the shared transfer
+ * array, or to the buddy allocator when the array is full or busy, then cache
+ * the freed object. Kept out of line so that frees that fit in the cache do not
+ * pay for it.
  */
 static __noinline int
 buddy_cache_spill(struct buddy __arena *buddy, struct buddy_cache __arena *cache,
@@ -204,15 +281,25 @@ buddy_cache_spill(struct buddy __arena *buddy, struct buddy_cache __arena *cache
 {
 	struct buddy_cache_order __arena *slots = &cache->orders[order];
 	u32 elems;
-	int ret;
+	int ret = -ENOMEM;
 
-	elems = READ_ONCE(slots->elems) - BUDDY_CACHE_BATCH_SIZE;
-	ret = buddy_free_bulk(buddy, (void __arena * __arena *)&slots->objects[elems],
-			      BUDDY_CACHE_BATCH_SIZE);
-	if (ret)
-		return ret;
+	/*
+	 * Peek without the lock, buddy_transfer_put_batch() rechecks under it.
+	 * NMIs just try the transfer lock and return immediately on failure.
+	 */
+	if (READ_ONCE(buddy->transfer[order].elems) <=
+	    BUDDY_TRANSFER_CAPACITY - BUDDY_CACHE_BATCH_SIZE)
+		ret = buddy_transfer_put_batch(buddy, order, slots);
 
-	WRITE_ONCE(slots->elems, elems);
+	if (ret) {
+		elems = READ_ONCE(slots->elems) - BUDDY_CACHE_BATCH_SIZE;
+		ret = buddy_free_bulk(buddy, (void __arena * __arena *)&slots->objects[elems],
+				      BUDDY_CACHE_BATCH_SIZE);
+		if (ret)
+			return ret;
+
+		WRITE_ONCE(slots->elems, elems);
+	}
 
 	return buddy_cache_push(cache, order, addr);
 }
@@ -769,6 +856,9 @@ static int buddy_cache_init(struct buddy __arena *buddy)
 	if (CONFIG_NR_CPUS > BUDDY_CACHE_MAX_CPUS)
 		return -E2BIG;
 
+	for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+		WRITE_ONCE(buddy->transfer[order].elems, 0);
+
 	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
 		ret = buddy_alloc_bulk(buddy, sizeof(*cache), 0,
 				       (void __arena * __arena *)&buddy->percpu[cpu]);
@@ -786,10 +876,12 @@ static int buddy_cache_init(struct buddy __arena *buddy)
 
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

