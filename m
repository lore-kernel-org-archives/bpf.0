Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625239;
	b=hYMTUQ8qbaXVo+VVDigL947bD2kCq62Bj6U7+HG3qY0xu1SAL5+3uBXNQHqIO2CGuJzi
	 nGHv2WLRRzUIao2QRySnzU2v6UKcgKd7J4WP7c8mry5H4u49SMjKWPXaWacwFyywLuF0/
	 FgyaDAr6Fjkm1wcQOgqISv0hYQAfATg8ePwUDDiMGN/wAg5mMsDn0apeQ3DQrPGHTXxAY
	 kKdWXRzGax35JTek5Jv1rTAkUE9Rq0/PPU93EfLfi7K0ASwTh0mC5F+2HhWbcLNsRs4/y
	 tQX64o8vzyCvftabheEyPNcwiO9UkjD48wIhokZtJgY6DdMA32n6ioIb2IEBeZaIhRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=67WRxWX75J6SbOyMtkI8/EG32ucmow4arv1ne2l5nH0=;
	b=VgJihjBkvcvQ8fpdynkjYiacYxCpnyVzbb2/OmZPY13MSYESRuz59CVntUMox0M52XAH
	 vNihd/raDqNj8ba7GN+ii3iKDV9VsvYaj6IeommR7MBm9LYJ23wYeb9AcKMhs7aRV6sRK
	 ZTqGwoj6AsJsqOQu3AfB5DkYsvr5nRp9lLnWCQ95wgFgXPZWvmZQfJ/bLrrXKDuzC1gXX
	 /bCgcawP9l1CIB4K9W69aJvy3TaiqqTioSyaJuuiYKd6m1HaCDIWeIOOwd5GZ9EsDtB1C
	 6EEyxyA+Dldc/FmFFrmlgfy/JqgGJYvjDN6qssjhoJAImyxEH/z+8sBiNygsPnlhhLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=mAkePAgw;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78591606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78591606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=mAkePAgw
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e831e86ebfso7346115ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792625239; x=1793230039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67WRxWX75J6SbOyMtkI8/EG32ucmow4arv1ne2l5nH0=;
        b=mAkePAgw9RqSkn0A62EB0eVMPhoT37fmltmdNFB0WNGtqT8H2LCaMGn4CPntIQ1ZYz
         nVTTkcUBfG4hXSGnSB1rbUvLI2L+lImgKMGDPKPH0FF2LUnjdsfz3PrM/WNZgAy4uMOy
         BEbWTkByyVpfO7X9A4rNRmNrNGCmm0p95qB/1deL9XINPXCb2CQPs5LhOZoZeFDo5BkR
         m8o7Zrs6vdrficq1+SY9h5GL8qOwsv7VTgirNDUH8zjYPb+LFGpvHn4ZxKnVmooaU8W1
         Wm1urcupSl97xEpsZQdDG0Rf6IYH8pS7nms6+hizQloIl2hp62Eh0Q45j7eKiznfEYs/
         Z0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625239; x=1793230039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=67WRxWX75J6SbOyMtkI8/EG32ucmow4arv1ne2l5nH0=;
        b=mWjpy8AHzmIXsmhTeDbL/XG9PlMhfQQ6/TsZiSAWggh2c/wf2LsVhADWXnQy6CqP3J
         7mfQSvm9XAYABGvFCNoqINbO2b9iDrgj3fRAi6FVS6OCZ4XYCpuW/4JiYWs5T/9laGFr
         cSYS8Nwt7vBdMc6UPh6xh+fLnAPkKPclqb9uyn8/4D1GejCTrNjKqNQ7EJI0tcFjmSY3
         mXWHqBb46i5cETjzcwgJsrBPg4R+GmT2wjlkk+E/9QG0MX9bWB3zZmraKrc0A7O4y/zX
         75JOD7STnhXhYY+zkqMCAEWHA9vdaFdOEO1XUaXzayRac4/2EcEW8RxugpW/sNXfRC6N
         unCw==
X-Gm-Message-State: AFq9FYKiHl4OccLk9dxteMIRHwGiqFseOEszm29xLWg9bFbw5xGggmw1
	psnoZ94JX5NSFPX+zbYuBZMC9cbOqa3P1sKNbUZBj1QQNFpfSypGaHy0W5nO5QdyTwdqJ8FlPTo
	2rnx0u4Kdxg==
X-Gm-Gg: AYBFou2YenS8y9d/TxRcv0lJisdS4RIw2L1yYTyxUEaHL+vQmHuCgZsTMwTk+Uqnr6J
	I+HuyqZcRbs8P0LwwU2HtHXZD1yCds0e6/rmhNIO3woa2EsIIg0ynI6NepzO5EGefmeJ9lSFrBf
	+bUFyms0bAjiYEUh0M2FpMSYVSdOSDmQ26OmKj+S5S3YOqPsWT0figpmWjGgyIqF0Bs8J0XIXVQ
	yDtQJ7hXj+V6789wCTlIzY9lQ57q5DzyxxUyQ1aFS1RVuE7Mi1eN0Z5VUsxXtskl8NTn3C3n94t
	y49Kjd9S+V0oHVQLFIji/tcuFsxYFTKEF9KYEid7O1+Ikagl+bCp9+JBvIQDeJ9A0BLiyGHSzp4
	9FZw/tDq/AOwhzV9IJZVjWRNG8JCrzZus7g8VMOxVXp4zUOw6LajzkaczQTW8apNzF+U/nzvSsq
	WaMqAYp/Mb655M2JoTcN0tunOZuGDJJpa1OBX0cjdhe5iNMWDboz7bq947mjwgsYaTZrX2pL483
	1ajg+5ofhEf/J5r9v8hTEM/FXD0WtxYg4ipJxf93Mr/
X-Received: by 2002:a17:903:18c:b0:2e9:798b:2213 with SMTP id d9443c01a7336-2ea439a6163mr24047075ad.24.1792625238761;
        Wed, 21 Oct 2026 16:27:18 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:725c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada70sm15651425ad.72.2026.10.21.16.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:27:18 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 6/7] selftests/bpf: libarena: Add a transfer cache
Date: Wed, 21 Oct 2026 23:26:40 +0000
Message-ID: <20261021232641.10063-7-emil@etsalapatis.com>
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
index d7c3defeb0a8..80f2a49f95e5 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -126,9 +126,78 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
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
@@ -136,6 +205,11 @@ buddy_cache_refill(struct buddy __arena *buddy, struct buddy_cache __arena *cach
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
@@ -191,6 +265,42 @@ static int buddy_cache_get_order(void __arena *addr)
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
@@ -210,6 +320,8 @@ int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 		return -EAGAIN;
 
 	ret = buddy_cache_push(cache, order, addr);
+	if (ret)
+		ret = buddy_cache_spill(buddy, cache, order, addr);
 	buddy_cache_exit(cache);
 
 	return ret;
@@ -741,6 +853,9 @@ static int buddy_cache_init(struct buddy __arena *buddy)
 	if (CONFIG_NR_CPUS > BUDDY_CACHE_MAX_CPUS)
 		return -E2BIG;
 
+	for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+		WRITE_ONCE(buddy->transfer[order].elems, 0);
+
 	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
 		ret = buddy_alloc_bulk(buddy, sizeof(*cache), 0,
 				       (void __arena * __arena *)&buddy->percpu[cpu]);
@@ -758,10 +873,12 @@ static int buddy_cache_init(struct buddy __arena *buddy)
 
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

