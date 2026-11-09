Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248471;
	b=H2+0wc2oeHeSPRlVSV9YCCyeMKB0XxqCFOPt8Lo9MLtE6U4v6kSJHHQ5WZlMYcsDRQR2
	 Aw5GT3min5h3x21BHZS50PT65NgK5R6qukqiVjubhUk7+NNAWbMTjUSee4WEWBv3k9E+R
	 qmkGKCKKLJN6VdaF8YzqX2BpoFV3+Ft2AN9bWevKvxiv90JijZHUBfpSsJseXXgBp2go1
	 qAFLyn2XDmx6o/O2gL5mDunlhoZq+PUj1EwdMlfJYN3hkbWWl84UZZplwLnWGd/W8pWXR
	 vL57oF7CgNDPiq581Ow0sRSdx/sHF8/xT95HVUSzEspe1T/5K50JZpez2BzEl5IIL8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BYfq8uSntY3vy/+AVA6TX47+rm1HAVLj6SN/2YtoqoI=;
	b=hZlOvz0NoN5CqmXp0DwrRaFkShosh1290H87ldF93vIvd9m8iJZ+pVX6TWpDb/HLy5/M
	 q/UG0IMoVPR3AB5FLEiR4cSHN90RjBF3ofVx9iCCBIBMc+BoLt2LeZHn1wkIlEHAJFZHc
	 eArP3foO6C13TJPrhmdQWwWEkaTCG/Gz0atL9xeNtA0dUSJdJkS3E1plgoB8ClQviV7Zz
	 ZlAUmF5EYt+YdPB1mgs3Y5CSMjAKECThwQMICKss8Ij9YMwF4EEoly3kdu4Xw0sIOYSa5
	 1WFyyRRkJ6bYGTUx+SLyu1FXV3+HqUrUBPSx3Nei7Q1Z2IMNd11ZzmmZDsuYIGKFMJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Hng9xKtu;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30512606A325
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30512606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=Hng9xKtu
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ed06b725fdso8905895ad.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248470; x=1794853270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BYfq8uSntY3vy/+AVA6TX47+rm1HAVLj6SN/2YtoqoI=;
        b=Hng9xKtuC9N0UfBp0VTFFrzqqAjk3DHE9pnVdsiZAPF7oAhdlJhfk0kXLPMm3xlgAB
         OjRvjJIrrIjjh1+nxIdSS1Fp2ih5iOsN5hflJRZWlv/255WqgQyZdjP0jCO5RqKhaZFi
         hzMYsGq4EOrTbxoNxnCrfgUhGvL1H9sS1Il2K92DVbXeqrOKJoEIhxS/T0qjgfna1j/4
         mGtyvvASFcDxOUQsNqVJc+Gf0LyHoy2cRJeqkXK4L5bIXuwCfbMPFrcKMzhA3zKoPQ3v
         meQdJG8UdTQK2YwLNorGagy2NAYfJ6q2gt9p/sQab93icC4ii+LYAZL4z2icOcam7286
         /+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248470; x=1794853270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BYfq8uSntY3vy/+AVA6TX47+rm1HAVLj6SN/2YtoqoI=;
        b=S3+opvP8rn3yi1btYzpizoTjG6JNZBp2FBcgFQNlEvvwenRmavuxpe5FwrBuZ7P3Xx
         NyskMOelWbh+yaRd6YzUAE6gcmpM+9HfDmCVIW6R6S54m14owsi7ZYwIEVcwtIH0u77B
         +ANEIv4oTKuaCPmAWORC4jPdKILaLTg/tPBeEt5gVCCxONhFAQ1UqN6zr9/e5WbwV92O
         jAzBWWpxAs3weD3HybCHU6Fx4FJq8cQOdbMdj7UU83GxzdLjaMoEQBKa1WYGEwmd6b8j
         VfSaGN3iPiY7DYacDHPSGRIvO0qmEn6UoxTGnTbqVtrD/Slv3fe/IJtMDzyrbe5EDYOp
         3Vdg==
X-Gm-Message-State: APuU4Z/tRDB4TuHdfXmMsQUQDFeEWEuUBfGvjIes+vdR1wAMVNaB2xB9
	AosYgxAGaYQxLzVh8NBiFAUlRcBrdF7T89QCUol0TLv1rGoB344lH7bpaF5rQ8y2wi3GpMFrFkk
	T4PRDLoc=
X-Gm-Gg: AYBFou1gXNVolTrtl5DeY6SND8dJ2dzt0osMtTetuceO+w/FQtrXo7jAee31f1ZvA4w
	yZB79bgVOvmgaB9OqIUHGlU6MrH82JDea3aVemGc8+S8HTa/VxIkb7aSuQNJFGvSqepo9sqPPur
	nZTe3CIobewE5AfYY5HynrHe5SIsfIwBgBu2gSRV1YpcITH2ld4zCX/gl8CfizI0Skao1Yyn2qq
	8Lrv0PJOWvV17wNxxNlUR2FHOaehmWduh5HVAsL185XjMmWmjitmxYFbUxLrq2o6E3j9CZOdw1o
	ptZflD/jjyaNWmyDgaoEETC3oH4hhsIbGY/p60Oanvam5j+t3b4LMGrHNzC9PVW5UlLxK+bVE2V
	yXrGK8lj0RXY+w6QNmAZUfcK9HYjsVebH66ztpTfZCplCJ9rAM+l4JTCrHQrEwK2DYqx53PhaJ9
	1hdpZ4KVmHuh84zy/rmi24w64BQsrqJRlvgFUfrXmpj+N4BycPn6WU7uWbj7NX0coYs25iIC+uM
	V3dR8a9esUX36qNY3CO4/u7S022lMyZ7rA7t1wtlpsZpSvWx71HpGyEd0Rhz/k2GLURQh+Lnwjx
	WxSRYKXZuCeSE1hENG2ohjZ3VICsa8RLHTY48YXgOivmY1+7/x0fkoIIymDqM112eD5BaWpIr2D
	T4uSoFIyxxSYAbj/hFReJkjh52zY=
X-Received: by 2002:a17:90b:4f42:b0:3b0:e388:d9c9 with SMTP id 98e67ed59e1d1-3b167918d73mr191516a91.12.1794248470311;
        Mon, 09 Nov 2026 10:21:10 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:21:08 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 8/9] selftests/bpf: libarena: Add a transfer cache
Date: Mon,  9 Nov 2026 18:20:53 +0000
Message-ID: <20261109182055.7581-9-emil@etsalapatis.com>
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
index a23da811e484..ef7e87344e83 100644
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
@@ -158,9 +235,8 @@ void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t size, size_t
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

