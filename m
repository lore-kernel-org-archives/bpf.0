Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520351;
	b=k86Fy5NR+AUdeTuHmW//5Y1mVrypKdLPJHeqGrvnjGkqj+1MKM2CNOcQ1UamTVAh8vTf
	 x7M9R8NfXvFwtJtnZZn4vHtc+WEPXaRk04TnkOs2ZwiWNAdJKM0kLI6n13x9d84FayS2A
	 i+bqjXjRFxKAe2E1tcT40Hd/7Pqpt7JsUO65hpcx8G2vWlXT+RRwgFpnjgPw6ne0F1yxI
	 rt06peRLUEQRBcPNadL0OKex1dAFW1Wteb6BvYV8DTNzv7PwBzE69NRCj/8V/zPdKeAX8
	 HNxnHz4EXrcqR+DN/xHd3DTNf+ljm2YoS2sIcx+tRTZ7C2mgoXfVshPy66rKX1JKLHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jIz1peTNq2Tj0Y2KECSx+jzJ//4K9uJMA+w+yP3b6yQ=;
	b=oTzqa6BLDJZ1lmZOvRVz71Y3e4RawRKkgl7SLPmcQr6iKdgPOW54Fh7QmrKFVTcFajF8
	 wlYdbVDZ23kvJlsMAZRZl3jU/Y0T5WhinX8VdssjB8FFNY80OXd4KRhlSkMVtSpBeFk0n
	 ZSDqcAojOQO+MoXMN+VFcjaqN0n3a4dI/w830/VyzVqFgRjXOcvKk7bQz0BMQ65WTXLl8
	 uGafUv9njKqd2Obpn2xcQje2ocaWYihluKB30V4jMecq2lyNAzjWK7UYzaWhJOFxzRkbF
	 yY6OVLiGSxUpLSTPkIMADKivP0zCIdh8elIsb0rQu2R+XRfgLwb24w9wTHDdyGFrlgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b="J/nkOxPa";
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F360A2610
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA5F360A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=J/nkOxPa
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd633ef819bso1395779a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792520350; x=1793125150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jIz1peTNq2Tj0Y2KECSx+jzJ//4K9uJMA+w+yP3b6yQ=;
        b=J/nkOxPa+AQr24qaa534zQ71yvEouIpL8zWiI6e6a0ZVtYnAmUMuClJQEt1XgOqPGv
         Gotn9sYNjkFFJccCfIPECvG6Ru5l2znqcpxc39r/WrUAnsGGMdjk/yEzhkFj8s/bF0fj
         BWM3QJMg/8x2tfGBuWzsNU1hlY5NSHOyJBviZGzpOQTOej1P+r96vXd4zGX+dlgk/Y5B
         +l0qnIbIm/cCk7+qFTarjANnGw0omVARqJ/LTrxLJyypNbu4aHdv3dV3hZWUcf4kdUsX
         6q378GRx/cDE7saiZXfaeRZSKjKg1uR/QxFEy2+gnMzRg5p4lMfVMDYuMb8nllS8bilI
         FbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520350; x=1793125150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jIz1peTNq2Tj0Y2KECSx+jzJ//4K9uJMA+w+yP3b6yQ=;
        b=Ot+WDkNLxnTcij9umWvH/wuZktEZk6CrQjFOgKZujtG/GgGDzqpsil9GISjjfE8qvT
         3X5qfmEe65EWV0/IPhN+NqW5F+VheiQm5/zll9YsW31MINJnnNdlmg13d9zr4BPNlbge
         4CZwcCkZXKHitEmMFHf29wYW6ipwrxg0wY85Eb81FTduRXwCdfhBfFw5GR49phkWh4bG
         5McTlYtc5GqQbsfwaOGq1O7zmVWQ6qyKCxVGqRO8KUoql/Lxic4PB+5+ASNa4s8F7JMj
         lAvxJL/W/TfM+kMy5aDYzJ6oCnQ5g9AL29j1tlr10cHzrEKbfhyegiarXQZYS8tNkPAw
         BnKQ==
X-Gm-Message-State: AFq9FYJHKY3ttUHY2Gep8/3/6JiFM7gh2x8ke6IlsF2mXu79aUaZazng
	QXlfcCbzXyheKidGtTizoOZWCf4/CkYjMaOIDwiv8OL4rF+DGZ8LKuWVJG+1Fj7sgytTrOshK0J
	6KBCKKJs=
X-Gm-Gg: AYBFou3kYWyladxViXWKLSRw8wt5G2puWNX5r6lfkVsXS1ioR/UmLcPuEB/0AMsmevB
	3oL2sQj8BwkbqSlevHPFYQkzzTidNXcEuBrwe6+h5jYQ1Yaig4tb+Mi1jlZnJgfjOnalC2jVM/Y
	9D73gO2mBmdg+LklDu9EF5hxMkZj83S4xjD/fYa1p+SC6gKpGblLwxwYREfZwukMuzoE5tudbPu
	ieqptYgatTEKaZBF7pQR7ZnFjr2KW78GMRY0fX/+UJk8A3p5Tb3OSTV9cIJzsOLj8dM9fP7wreC
	YS8a+pp25jNqCf53e9U00rf/Xz2hc0Z6b/j9U4TYqMKYyYYdz/cqky7bhsNdPHT7paAn4q3qdgw
	NXYm/zg8bHlTbPYEn9KHRakpuL6OL9i0R7zyQ00//Txf5NDbzgLVbDdUKSxr9bFwW+qur1nYg1N
	W1Z6qnuxaMgD2OuXx3huAoRuFc/r08qJS1TcmFaAt38kQ7ux4NA7ElJIosunwltVt66rwOKS2YE
	uXd5dUgKXxwENhWpFz4MRl2ejhOmVQb38oQ3FYgET8z/68=
X-Received: by 2002:a17:90b:1dc3:b0:3ac:9e76:aa76 with SMTP id 98e67ed59e1d1-3aceefb0116mr10846355a91.13.1792520350147;
        Tue, 20 Oct 2026 11:19:10 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm710661a91.2.2026.10.20.11.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:09 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 6/7] selftests/bpf: libarena: Add a transfer cache
Date: Tue, 20 Oct 2026 18:18:59 +0000
Message-ID: <20261020181900.6755-7-emil@etsalapatis.com>
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

Per-CPU caches keep hot objects local, but they cannot move spare capacity
between CPUs. A producer can overflow its local cache into the buddy while
another CPU underflows and refills from the buddy, causing avoidable lock
and metadata traffic.

Add a fixed-size shared transfer array for each cached order, protected by
a per-order lock. Move one batch from a full local cache to the transfer
array and consume one batch on a local miss. Fall back to the buddy when
the shared array is full or empty.

Embed the transfer arrays in the buddy cache state so this intermediate
layer requires no dynamically allocated containers.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../libarena/include/libarena/buddy_cache.h   |  10 ++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 123 +++++++++++++++++-
 2 files changed, 130 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h
index cad198ac732d..9fa90097dc98 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h
@@ -26,6 +26,9 @@ enum buddy_cache_consts {
 	 * Objects retained locally for each allocation order.
 	 */
 	BUDDY_CACHE_CAPACITY = BUDDY_CACHE_BATCH_SIZE * 2,
+
+	/* Number of objects shared between per-CPU caches for each order. */
+	BUDDY_TRANSFER_CAPACITY = BUDDY_CACHE_BATCH_SIZE * 8,
 };
 
 struct buddy_cache_order {
@@ -39,8 +42,15 @@ struct buddy_cache {
 	struct buddy_cache_order orders[BUDDY_CACHE_NUM_ORDERS];
 };
 
+struct buddy_transfer_order {
+	arena_spinlock_t lock;
+	u32 elems;
+	void __arena *objects[BUDDY_TRANSFER_CAPACITY];
+} __attribute__((aligned(64)));
+
 struct buddy_cache_state {
 	struct buddy_cache __arena *percpu[BUDDY_CACHE_MAX_CPUS];
+	struct buddy_transfer_order transfer[BUDDY_CACHE_NUM_ORDERS];
 	bool valid;
 };
 
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 3b760b1fc66e..2248631392b2 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -131,6 +131,78 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
 	return 0;
 }
 
+static int buddy_transfer_take_batch(struct buddy_cache_state __arena *state,
+				     int order,
+				     struct buddy_cache_order __arena *slots)
+{
+	struct buddy_transfer_order __arena *transfer;
+	unsigned long flags;
+	u32 elems, start;
+	unsigned int i;
+	int ret = 0;
+
+	transfer = &state->transfer[order];
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
+static int buddy_transfer_put_batch(struct buddy_cache_state __arena *state,
+				    int order,
+				    struct buddy_cache_order __arena *slots)
+{
+	struct buddy_transfer_order __arena *transfer;
+	unsigned long flags;
+	u32 elems, local_elems, start;
+	unsigned int i;
+	int ret = 0;
+
+	transfer = &state->transfer[order];
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
 void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
 {
 	struct buddy_cache_state __arena *state = &buddy->cache_state;
@@ -185,6 +257,38 @@ int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 	return ret;
 }
 
+static int buddy_cache_transfer_free(struct buddy __arena *buddy,
+				     void __arena *addr)
+{
+	struct buddy_cache_state __arena *state = &buddy->cache_state;
+	struct buddy_cache_order __arena *slots;
+	struct buddy_cache_ctx ctx;
+	int order, ret;
+
+	DISABLE_CACHE_IF_ASAN(-EINVAL);
+
+	order = buddy_cache_get_order(addr);
+	if (order >= BUDDY_CACHE_NUM_ORDERS)
+		return -EINVAL;
+
+	if (buddy_cache_enter(state, &ctx))
+		return -EAGAIN;
+
+	/* An allocation may have made room since the first local attempt. */
+	ret = buddy_cache_push(ctx.cache, order, addr);
+	if (!ret)
+		goto done;
+
+	slots = &ctx.cache->orders[order];
+	ret = buddy_transfer_put_batch(state, order, slots);
+	if (!ret)
+		ret = buddy_cache_push(ctx.cache, order, addr);
+
+done:
+	buddy_cache_exit(&ctx);
+	return ret;
+}
+
 static void __arena *buddy_cache_refill(struct buddy __arena *buddy,
 					size_t size, int order)
 {
@@ -208,6 +312,12 @@ static void __arena *buddy_cache_refill(struct buddy __arena *buddy,
 		goto done;
 
 	slots = &ctx.cache->orders[order];
+	ret = buddy_transfer_take_batch(state, order, slots);
+	if (!ret) {
+		address = buddy_cache_pop(ctx.cache, order);
+		goto done;
+	}
+
 	ret = buddy_alloc_bulk(buddy, size, arena_fls(BUDDY_CACHE_BATCH_SIZE) - 1,
 				(void __arena * __arena *)slots->objects);
 	if (ret)
@@ -745,10 +855,12 @@ static int buddy_cache_state_init(struct buddy __arena *buddy)
 
 	DISABLE_CACHE_IF_ASAN(0);
 
+	WRITE_ONCE(state->valid, false);
 	if (CONFIG_NR_CPUS > BUDDY_CACHE_MAX_CPUS)
 		return -E2BIG;
 
-	WRITE_ONCE(state->valid, false);
+	for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+		WRITE_ONCE(state->transfer[order].elems, 0);
 
 	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++) {
 		ret = buddy_alloc_bulk(buddy, sizeof(*cache), 0,
@@ -762,18 +874,19 @@ static int buddy_cache_state_init(struct buddy __arena *buddy)
 	}
 
 	WRITE_ONCE(state->valid, true);
-
 	return 0;
 }
 
 static void buddy_cache_state_destroy(struct buddy __arena *buddy)
 {
 	struct buddy_cache_state __arena *state = &buddy->cache_state;
-	unsigned int cpu;
+	unsigned int cpu, order;
 
 	WRITE_ONCE(state->valid, false);
 	for (cpu = zero; cpu < CONFIG_NR_CPUS && can_loop; cpu++)
 		WRITE_ONCE(state->percpu[cpu], NULL);
+	for (order = zero; order < BUDDY_CACHE_NUM_ORDERS && can_loop; order++)
+		WRITE_ONCE(state->transfer[order].elems, 0);
 }
 
 __weak int buddy_init(struct buddy __arena *buddy)
@@ -1293,6 +1406,10 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 		return 0;
 	}
 
+	ret = buddy_cache_transfer_free(buddy, addr);
+	if (!ret)
+		return 0;
+
 	ret = buddy_lock(buddy, flags);
 	if (ret)
 		return ret;
-- 
2.52.0

