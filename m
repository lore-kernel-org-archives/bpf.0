Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520346;
	b=xXvMB3FzbXprQ85Vo0x9EqmmzjorJFjXrhUwNzeoq8cuErg6sP3iDxXEiujnVebDL48P
	 50CsaIuadhol0NfN1Ld4zXY/lFbGbEr2HytWfaJPvXdkc7vOpI3sIFRoGqP53IMeYtvVu
	 2at4X43oLHusbAri+tmx1vBcMiPo25TY7UYbzWEcP5xxrhyw0Kafy1Lh4NiVgvAQKyjak
	 epLKV3a0jmVGPVY1c9NcH/KLHlWUxa04HCQZAriyNuv1CyZj45+7OGBnW+SOB/U/8J/Il
	 b4LJZUqD2E4fGthV6dZK+5PUVV56v1kpxjzmHT6HZdWZy5by2Ki0hw+8TaXLpZyTztg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lZFovTyICUjPAHHog5S/kT9XZfI3TvONjvxqzMAbFT4=;
	b=AfDOAXyzoaHEa5qop4n1hyViYpeXT7bkUgXJ7W8QsFLlWfh1bHWtH2AzykRirRZQVLiB
	 Un4S7qdnEPL1uCp6q8XiuJV4FKYAq9zdQQG2LlOreDbwHqv0dzb/8P6bTpkbEShSa0qtk
	 HNziULc21B/5Tjm1Mx52psMlZFSA1r7P0xPUqsv3m340v7y+m5oSWdDeJNeMCtPuIpxl7
	 p3berS40U2hOhM6o0fsLqmc1bcNZDjwbU1Qs/hT5rtMJC33CvAK7UFwtdIbzL5BZWi6Se
	 fDDIZw3lLcA+DcbsfpcUnfwLKQXbRl2aohGrAMcVvuIcGNkRWH6qM65c0px2GU9ZiOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kfc8fMX9;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E3660A2609
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E3660A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=kfc8fMX9
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so3016094a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792520345; x=1793125145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZFovTyICUjPAHHog5S/kT9XZfI3TvONjvxqzMAbFT4=;
        b=kfc8fMX9zLlxIyi/TApywIEyw3xzBSI2kVz11R7LPNN39DwD7HjdZAKYmnEYxaDfvc
         GUJ+xDR+eMohHgMZPRbFUVRT1bRl4nIMM6VlpSpX+Xe59wzdJepjcG2LUp9X3ALxgosX
         5TuPSzkh3BxVxFhSv1hjv/d8MkQXk2Nfoe1i26qLno8LmZvA5tIqA3dG+iaupKZJ+/ix
         Q+StJ3IbEHdGkxU8c++lN8CiYB7lU5a4WUdJ2jwdW59RCKXXAUbxXDJr+DNbKvOprjyA
         JUVTbm+fd7h34dPCo0aRAHbdQrJnCqpPSpl3Mbxk9TNhRkNzvecIOrUeBdXgjlWq9B6/
         Z4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520345; x=1793125145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZFovTyICUjPAHHog5S/kT9XZfI3TvONjvxqzMAbFT4=;
        b=BzgNJ987yZ0Xc85Z9s0qakEBM8pnbUHQmhzINHd67tB+3dNkgYPulranfGm3mSTdkE
         Wgng4j+ZehWV8WtoRKYUxxVmjeZkV5bKIHcNPnhcV0OJKXWC/xv748MKlds5lI3CCEKV
         G+s1GmbPKx/NywvChSZiRsHqjx+GMUoBsZw0T2sPgIYrqwQB0qAILfW3E8tFW6oO7juI
         utkrr5rF5WKksLWKwB+GCaA9J6z1nouCN/GE0HFSP4UL9CItyOEOLUQWJpjvlaNPRIzJ
         vyvj+HyIqBBPJcvVPH6ninbbdsXhQoftvoS0fFTT+76wAEOdNt6m8ItA5+F6B3ODYLpn
         ZfGQ==
X-Gm-Message-State: AFq9FYKR1/CK2MjkUxAe6JnXrhaEyY0jUFxuK2QRiD+bAmEiyu/y7iDj
	hDuYbYq9on/4MRIxdRY+zaSrDkQTOu4UWusnvx0Crvd8dUg3jMTJGKkHEtsrM2MiH7gNncHwdiN
	dHVtqWxI=
X-Gm-Gg: AYBFou39iYW2fF/lmiXip8u5SGWA9aC2irhA5obaa6pLIFKpXYHpsTUzwYNe+1SPTOk
	R/I5hz7mhLyZwOG7vkI6LqNEWHjnKaMe7G6wjYtCkexAixGZ4+gz/Hxh8IE1yYV/d/QE48ijcjh
	7W1f8fhJODrCVr8oeucQUJC6gXQ9HcSMAzoS2ZfZDyQMjznsWcSURdUAVsjpjsKM7dR05FCLpLU
	PZAwDQ+2ieZqBK+19ekdbr1Hr+oWxiem5h8L4Oq4+j7Eyqpw05O/pS8ysxUYxJinCIwZeGsfTir
	mHh4BBUL24aoxk3Q2KIhZ1YBpeNe58wz2CbPd7uYsVQgI/OvbKq4MUcQ09LpQYt48DqwrwFxzvf
	TEn4KnPfOq/O3R5jVHcXarAQHCHvSIdyU6htIG/f6HTMClxZR2Zr/4wqIXC+vFYDUjrtLw94qwo
	3Ayb7YshJOJA/4emtekcH7aMIZnyZ8C3s3Iq3rUOEvKKkXPu3q/o4g3E1HTzauceAikFLJK7wnY
	Ber7b89ZkOzWUFDodOLzojmJZBG0LAkAC8d
X-Received: by 2002:a17:90b:58f0:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3acef4e5d60mr11429746a91.49.1792520344838;
        Tue, 20 Oct 2026 11:19:04 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm710661a91.2.2026.10.20.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:04 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 1/7] selftests/bpf: libarena: Add bulk buddy allocation helpers
Date: Tue, 20 Oct 2026 18:18:54 +0000
Message-ID: <20261020181900.6755-2-emil@etsalapatis.com>
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

The buddy allocator currently allocates and frees one object at a time.
Callers that need a group of equal-sized objects consequently take the
allocator lock and repeat the same split operations for every object.

Add buddy_alloc_bulk(), which obtains one block and divides it into a
power-of-two number of independently freeable objects. Add
buddy_free_bulk() to free an arbitrary array of objects while holding the
allocator lock once. Bulk frees cannot avoid coalescing each object
independently, but they still amortize lock acquisition.

The per-CPU caches added later use this interface to populate a cache with
one trip through the central allocator.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |   4 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 139 ++++++++++++++----
 2 files changed, 115 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 528c69a1f38e..0ac888be365c 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -76,6 +76,10 @@ struct buddy {
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
index 2490ab1396de..72b9ea3ac7d5 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -628,7 +628,7 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 	return 0;
 }
 
-__weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
+__weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req, int order_allocs)
 {
 	struct buddy_header __arena *header, *tmp_header, *next_header;
 	u32 idx, tmpidx, retidx;
@@ -636,7 +636,7 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
 	u64 order = 0;
 	u64 i;
 
-	for (order = order_req; order < BUDDY_CHUNK_NUM_ORDERS && can_loop; order++) {
+	for (order = order_req + order_allocs; order < BUDDY_CHUNK_NUM_ORDERS && can_loop; order++) {
 		if (chunk->freelists[order] != BUDDY_CHUNK_ITEMS)
 			break;
 	}
@@ -658,11 +658,19 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
 
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
@@ -673,7 +681,7 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
 		return (u64)NULL;
 
 	/* If we allocated from a larger-order chunk, split the buddies. */
-	for (i = order_req; i < order && can_loop; i++) {
+	for (i = order_req + order_allocs; i < order && can_loop; i++) {
 		/*
 		 * Flip the bit for the current order (the bit is guaranteed
 		 * to be 0, so just add 1 << i).
@@ -706,14 +714,14 @@ __weak u64 buddy_chunk_alloc(struct buddy_chunk __arena *chunk, int order_req)
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
@@ -725,7 +733,8 @@ static u64 buddy_alloc_from_existing_chunks(struct buddy __arena *buddy, int ord
  * Try an allocation from a newly allocated chunk. Also
  * incorporate the chunk into the linked list.
  */
-static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_chunk __arena *chunk, int order)
+static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_chunk __arena *chunk,
+		int order, int norder)
 {
 	unsigned long flags;
 	u64 address;
@@ -733,7 +742,6 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
 	if (buddy_lock(buddy, flags))
 		return (u64)NULL;
 
-
 	/*
 	 * Add the chunk into the allocator and try
 	 * to allocate specifically from that chunk.
@@ -741,33 +749,34 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
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
 
 	if (!buddy)
 		return NULL;
 
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
@@ -775,28 +784,68 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
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
+
+		if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header __arena))
+			asan_poison(object + BUDDY_HEADER_OFF,
+				    BUDDY_POISONED,
+				    sizeof(struct buddy_header __arena));
 
-	asan_unpoison(address, size);
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
+	int order;
+
+	order = size_to_order(size);
+	return buddy_alloc_memory(buddy, size, order, 0);
+}
+
+static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
 {
 	struct buddy_header __arena *header, *buddy_header;
 	u64 idx, buddy_idx, tmp_idx;
@@ -900,4 +949,38 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 	return ret;
 }
 
+__weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *addrs, size_t naddrs)
+{
+	unsigned long flags;
+	unsigned int i;
+	int err;
+	int ret = 0;
+
+	if (!buddy)
+		return -EINVAL;
+
+	if (!naddrs)
+		return 0;
+
+	if (!addrs)
+		return -EINVAL;
+
+	ret = buddy_lock(buddy, flags);
+	if (ret)
+		return ret;
+
+	for (i = zero; i < naddrs && can_loop; i++) {
+		/* NULL pointers are ignored. */
+		if (!addrs[i])
+			continue;
+
+		err = buddy_free_unlocked(buddy, (u64)addrs[i]);
+		ret = ret ?: err;
+	}
+
+	buddy_unlock(buddy, flags);
+
+	return ret;
+}
+
 __weak char _license[] SEC("license") = "GPL";
-- 
2.52.0

