Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714863;
	b=bknn3PVCPFlDco9DFWzAHJFjorV8SXFitRr7p2A3AN/DIgRHk8cb/SIZt0Z3D3c+XLIe
	 FJNyff1DM6r4ahdiNS29zQHFXG0btmgWf1EB8+6380qwM4Jebj6XoJlsM4I0+CIKxgpwr
	 PW7aQahcPIJl7Iseiw1Nn/MmIcPokiHfhlMjz8DmcZoX6szrZhPkatmRJbcZg25TlIp6U
	 OqFbsmVoG2S4zqwNjHJ0ZYPLnyCKEEjQb+QXBcBx3czo+XA6Wha5yoLD2Ug9V8BQXCVkN
	 fgT5WO6rpJ0+wALaK8Fn68vTO7LkmtG7QzKVQndjvnBMTi/hPELTdejLE6lyuzGBsmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wlu+CuVLanz5zFJaxnUHDk4KwR8J4Te8x7Q+cb2dLOY=;
	b=dkvE+AKNGhy4UGcMowjvaw0bWLbbTwWyl9OyeOO8ue4UjE3iomo6bd1pg0Q90TGj+1SU
	 8NW/AJ6YVDhp2vl8QdNUvgqHWPQyZFaNZzG8hJPVluEDSLNrwbNRddqcUFkG6Duyfrel6
	 2IXlq8oIFNpq74t9C81eh6PsNcf56Gy1AY8FeDRM88DRgFv3nTKgiOenMzH47OOKyInj0
	 cZ+HcXfzVANsPE+3BsMDh7/7IV5/rwedDuO97ezAj5kAnj1iDjvMt6jFqzEZ6irljC8Pn
	 zvxb/Tvmo6uvw+vafKXU0YGUN+v3gzwShDrPXBoOL+c/O8ZXtxjSbT4H1/0yXlgX6Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=yEU7gdQB;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BAB606A321
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1BAB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=yEU7gdQB
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so271068a91.2
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792714862; x=1793319662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wlu+CuVLanz5zFJaxnUHDk4KwR8J4Te8x7Q+cb2dLOY=;
        b=yEU7gdQBsSJh6tT6gxeLbd0JeRrScIL/I7eYXqVFLxaI8YimOTwLL7IxgQOLFrvl9D
         sZiBsZZZ1KV/1iu1/ozo3lMa0glBodxuleKTpVYb6xdVsbnFsdwRaFq9Crz4SSPP3kAC
         rR1779yewZDc2VPqGuhxz+qoAWUqfsSsCXTQcZ3bzNCrS01HF07baLcgW7BnPtqH5Gh2
         gdjIlcsrjzt5We8irvqz3EZqzeoCoF3fW6Z31i6nnjX8pW4zGzF0XUTXPGIRfVLOwDoh
         YeEGLVqyiwwcESvD500Asc5SWZi6JkWbKsnaunLfxQjQG7jCcwjfqaxbyBj8jBargpIb
         JXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714862; x=1793319662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wlu+CuVLanz5zFJaxnUHDk4KwR8J4Te8x7Q+cb2dLOY=;
        b=o3ReQelpO423XI6TIeVapiXEP4fps08UgvU5Ss4lLHkYrFZgmlw0BjDoiRGYL1bxSO
         yhE4/eY7cDnDZTwdJFItZavJF07sflaArMdMC26Ep1fh8d/fwUid2h/60LW9NoSYVKoz
         Shnsb4Jx1N+v18q6CDzi7C5oBGsEcsk12kIFsK69MegsNRF4CSalU0lvJV6jKUSuK+n8
         +hSnrWP3fQGE0fqkoNEvcBTSfMSsZsLxXxtpq/bM/gpKJ2Z5JpA6g+cIumE67No9I5Y+
         yuQwlLWzyuyynaXtSfUVHMMjgm82zKUg5O9EIKRUpR8yKrCehRZU/82cSCIJdehrGFjD
         R6Mg==
X-Gm-Message-State: AFq9FYKBXiPlfaEpq2VikBsU7wDN48bZm4eSGUO4zKVmfsGfKiMUz/AX
	7LwIfABvH2cEUYv0HISimwGWRJBp+cn2sHIVgiwlL4q2BESEUSjWI8g5cGge0q4PisZxyed7OTx
	S7Gd49vweww==
X-Gm-Gg: AYBFou3MFW6OWEW/sEmV7N1ZZM762B0kSnjSSKUlQ9wAtS/KYgo8fjQMN83Es4LPDE+
	C6OtelIofRjzUar0uM7UA+ZnG0euIxeMKO4f+8VGIFhmdx+6GItI6VQ22uGhQYkv7Lo6QkfiUBo
	9w5ugXu/H+nvKRHCnNgaj/QBzPvMK0n3w6ChmgqjCkSvxkxmpYb8/+icZTj4/cdMoZWKnEstCky
	a7kL4V4B/KFwEFciDwttyMs7Fw5AOJa5htf0fMBhYAffqajd/ZMGrBwoqxGa/1CE++62OnLGL5u
	0dOd0morULag4m8GmFc4rlcfYMugF2twoe9odYNW36fCNjyFYl4hg3qYCV29P8BMUwhOg6q2lnH
	74bNtWfGsUCNpftGTwXWzebC8zoym5zTFjEJYfO6N+iXs1IM+jZRNFicuo/YWcw4+ZN2jAUHQN3
	imHWUw40U5E5JOxfN+pgqLqrQKh34l7qVW1JjvPaGIy1hXNR30SUkbjt5cEE7ey4hNwbSvt+2If
	DX18k81f3rUN459MiAgpsxQ5zzkyI1kakPA8C3z7zU6ie3sX9rgVxmcB1nrV0jpfarCvEZMW0r2
	1MY7Imo6ZusL6M1BIw==
X-Received: by 2002:a17:90b:5884:b0:3a4:f75d:d1a3 with SMTP id 98e67ed59e1d1-3adce07fc6amr447117a91.32.1792714861925;
        Thu, 22 Oct 2026 17:21:01 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8892c4sm218649a12.11.2026.10.22.17.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:21:01 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 1/7] selftests/bpf: libarena: Add bulk buddy allocation helpers
Date: Fri, 23 Oct 2026 00:20:50 +0000
Message-ID: <20261023002056.6647-2-emil@etsalapatis.com>
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

The buddy allocator currently allocates and frees one object at a time.
Callers that need a group of equal-sized objects consequently take the
allocator lock and repeat the same split operations for every object.

Add buddy_alloc_bulk(), which obtains one block and divides it into a
power-of-two number of independently freeable objects. Add
buddy_free_bulk() to free an arbitrary array of objects while holding the
allocator lock once. Bulk frees cannot avoid coalescing each object
independently, but they still amortize lock acquisition.

buddy_free_bulk() fails only when it cannot take the allocator lock, in
which case nothing was freed. Objects that cannot be freed are reported
individually, so a caller can tell from the return value alone whether
the array still owns its objects.

The per-CPU caches added later use this interface to populate a cache with
one trip through the central allocator.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |   4 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 142 ++++++++++++++----
 2 files changed, 118 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 528c69a1f38e..f150e1c37e3d 100644
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
+	void __arena * __arena *out);
 
 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 2490ab1396de..6dfaa23089a9 100644
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
@@ -741,33 +749,35 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
 	chunk->next = buddy->first_chunk;
 	buddy->first_chunk = chunk;
 
-	address = buddy_chunk_alloc(buddy->first_chunk, order);
+	address = buddy_chunk_alloc(buddy->first_chunk, order, norder);
 
 	buddy_unlock(buddy, flags);
 
 	return (u64)address;
 }
-__weak
-void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
+
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
@@ -775,28 +785,68 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
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
+		void __arena * __arena *out)
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
@@ -900,4 +950,40 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 	return ret;
 }
 
+/*
+ * Fails only when the buddy lock cannot be taken, in which case nothing was
+ * freed. Objects that buddy_free_unlocked() rejects are reported there.
+ */
+__weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *addrs, size_t naddrs)
+{
+	unsigned long flags;
+	unsigned int i;
+	int ret;
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
+		buddy_free_unlocked(buddy, (u64)addrs[i]);
+	}
+
+	buddy_unlock(buddy, flags);
+
+	return 0;
+}
+
 __weak char _license[] SEC("license") = "GPL";
-- 
2.52.0

