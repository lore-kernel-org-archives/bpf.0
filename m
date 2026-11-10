Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271124;
	b=yUzpSxU7/fhejsiMmHHxsvAEXEyylxIb24VBK35QRmf94x6fr+UF7PiU5sjDIMy47WXK
	 g8WZjRr4V36/sVZRQqj+JOgPv75TkP1Fdf/sYvQL0KU/85u3TfrGBR8bdQcXLLdikb7nl
	 Oqq6BIHli2HmxH/LNxSUzh8HhnZSja0hLjBwqbogJwYbTo4Djln94oBPxkR0ItcAdy60P
	 hf8ZPMe2u4tVQ9+REJ7Opm6ky0RhDoTEAPUZwq/pyq9DUkKpYwHeGM9b/KzyLB3b9Uvtw
	 ydBzOc7H1dyIyXDks2m7C7wBsTfueIrf99+O2tg6RSEGx8DG95jAkSivcHIvvUIGtUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d/MfMlM8XGgAJJIuusCwscxzvQuKTLjHmuXDzRYpdVE=;
	b=SYam6zTyWsrIpM2qxw0bIjdECxazzlTuuNx61buk+lHznN79AwKgM2pSnxPnp1DSxKQl
	 n75x2uo3Ca8SVlFukswgkt5Gl6UBbshXQwyF8WXaSSZZjsvjP2giNfIFsmZRzvgf0Pl91
	 hwfcm2LfobiYHtW8AqCXRG+Mg5oKcqOQRCr8acHUgfMUZ9078iaIAAmYwpdqZEkAd7S8T
	 IBMLy2l8Xlrel2saeG2pxvNdmUv6Wg7PvgeodYz4G3zUcfXeLM0Im92fghGolPokGB9yr
	 mtkUvH+FpRXZUnWEyli5j+Yb07+grLJa95MoXhl1mlhb9BrbEoiN19kjRefaBMbb/MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=YQIiH6qJ;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487C606A333
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7487C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=YQIiH6qJ
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso534741a12.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271123; x=1794875923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/MfMlM8XGgAJJIuusCwscxzvQuKTLjHmuXDzRYpdVE=;
        b=YQIiH6qJd8LD/uXRwF10TZI8uOoF5kNGwDiKj9HCen6xDguf1rmvshi2MKgh/PXbJp
         Xxk2hlrSIyPy+xm4ob/SyfjAUf+xrosZvgvTJdH8KXA5aQ2aoPATtFJ0Xbn7/4Yph52s
         nIQGY4EbVLSOJRo7cgxP9Ekpsdp3zEBlpI8Vp3Bs9eXnYjG82QsUnNrpdSr5Ay5ergI8
         PeSJ1nMcrsoupbsdTqjtALbiYtGlo2prtP35zjZJe80iZX8/IGgqIiADLPFYV1GqQD7R
         SoSjO2WXGQbXY2r6zZ45AQh+FwqX3nfQf2iGSyXkfYyubFPZHUM6G123JMYAOhb230uI
         71nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271123; x=1794875923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d/MfMlM8XGgAJJIuusCwscxzvQuKTLjHmuXDzRYpdVE=;
        b=e4MUFix4EumEtk8N4rr4gjdDryCQ3fb8OAOt3nuS1r75DzVZo4lzjDDlmpwX+tvsEa
         LBBGso/xpUFpI3wIYPTyeGv97VAO2QDVc6HMqNDSXpl1yEa2ykOmwVlZFziI7SFOyzyk
         F9jEp4APqzHt9JUfygLWtnwxVUqO4626878Xja5kcwwH94UJFdjk5OO1CpHaCQL4aIrg
         /C6oHfkIqawDJjhvnILV+ljC3Zw2s2qxe+BZOBJd0iBxdQqOT0hSlJUghwD/pyyRk0BQ
         jAREbOJUMbMWMYmKE21HDs8cy8WCbUdfWl9KW99XZRXezVRnJesuWosuUpegJX0+U7O3
         +UNA==
X-Gm-Message-State: APuU4Z/rR9F/3EgbgRDLEZp8SVda04zHZ8EwsGkFaTA5aIzaeJVEQi0T
	7lhSuQCC0beiuxhpwkVT8JHqeVRdSLpjqQSUpJPc06bRyLQxDw12YcZiepDg1sNIASuBfNghe1h
	uhfA5Z9w=
X-Gm-Gg: AYBFou1jPCZR66cREpMkpDe75LzQXk77MI91OMW2kiPC/CZEQ8T11cnAbVqoVqKtGz5
	5YTRCYdnreW3TPuF89vrQjLfa7cCPqObFlKZ+98hmUi+dRmT70pNMLGY/tUta4FvLlJpafKc3d5
	Jw/mFijNpfk0gET/FGf5CBUf1XoXcJ5gSGd9CHqT7bHuyymOsL669hSyqr+MZECLbjByp1W72Mr
	aSSLAzOCkDD5nmTK5nDO6dc43kmMY2JvQZiUbv4x0/chfnYQaWRqyfxtz/fi/J4MF6HtL5/C76W
	aB3ynXRN1duuAwjI2pwBgkJ+7omGFNDNOHnpV60iL4ZUI98yUq3qh9lJxm4yCAgzvDX6Q6ySpNs
	UXhShombCjCVVwuxqbINgIWxTBfVlXkSKaPPB+mwwND160CZLzJ9lqkFLTzVAXx8kyMEIRDOKlW
	WHeZiejkaHAniTWWZMXLd7QHXzSmFiu6NOhb0/5JFNF7pqJC2K4S7kx5mes+0VdHVI40Q8RJREJ
	pUcJOfboamrxnL8JeM6qdCs3eRV3jr2bv7vEdop5vNmk7JSujUaxZCZP6VDQZGltdX4Wnf0Qtp7
	dRUc/HRHa3H+fnHOeX0/VgLNmw5sLlvi9FlvmskYuOVTydG29X7xY1+j231fTUbvmVs/Tt3JL3M
	bPh+rjPcgnlX18vE4o+2JS0VRB5s=
X-Received: by 2002:a17:90b:368d:b0:3b1:6978:5c6 with SMTP id 98e67ed59e1d1-3b1697807ffmr503362a91.53.1794271122537;
        Mon, 09 Nov 2026 16:38:42 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:42 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 1/9] selftests/bpf: libarena: Add bulk buddy allocation helpers
Date: Tue, 10 Nov 2026 00:38:30 +0000
Message-ID: <20261110003838.8739-2-emil@etsalapatis.com>
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

The buddy allocator currently allocates and frees one object at a time.
Callers that need a group of equal-sized objects consequently take the
allocator lock and repeat the same split operations for every object.

Add buddy_alloc_bulk(), which obtains one block and divides it into a
power-of-two number of independently freeable objects. Add
buddy_free_bulk() to free an arbitrary array of objects while holding the
allocator lock once. Bulk frees cannot avoid coalescing each object
independently, but they still amortize lock acquisition.

buddy_free_bulk() fails only when its arguments are invalid or it cannot
take the allocator lock, in which case nothing was freed. Objects that
cannot be freed are reported individually, so a caller can tell from the
return value alone whether the array still owns its objects.

The per-CPU caches added later use this interface to populate a cache with
one trip through the central allocator.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |   6 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 148 ++++++++++++++----
 2 files changed, 125 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 90674ac077df..4c96307e2a2d 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -76,8 +76,14 @@ struct buddy {
 int buddy_init(struct buddy __arena *buddy);
 int buddy_destroy(struct buddy __arena *buddy);
 int buddy_free(struct buddy __arena *buddy, void __arena *free);
+int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *addrs,
+	size_t naddrs);
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
 void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size);
 int buddy_grow(struct buddy __arena *buddy, size_t nr_chunks);
+int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
+	void __arena * __arena *out);
+int buddy_alloc_bulk_nogrow(struct buddy __arena *buddy, size_t size, size_t norder,
+	void __arena * __arena *out);
 
 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index d12c8924a0ad..514d0a59eaff 100644
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
@@ -741,34 +749,35 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
 	chunk->next = buddy->first_chunk;
 	buddy->first_chunk = chunk;
 
-	address = buddy_chunk_alloc(buddy->first_chunk, order);
+	address = buddy_chunk_alloc(buddy->first_chunk, order, norder);
 
 	buddy_unlock(buddy, flags);
 
 	return (u64)address;
 }
 
-static __always_inline
-void __arena *buddy_alloc_maygrow(struct buddy __arena *buddy, size_t size, bool grow)
+static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
+		int order, size_t norder, bool grow)
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
@@ -779,23 +788,30 @@ void __arena *buddy_alloc_maygrow(struct buddy __arena *buddy, size_t size, bool
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
@@ -803,13 +819,13 @@ void __arena *buddy_alloc_maygrow(struct buddy __arena *buddy, size_t size, bool
 __weak
 void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 {
-	return buddy_alloc_maygrow(buddy, size, true);
+	return buddy_alloc_memory(buddy, size, size_to_order(size), 0, true);
 }
 
 __weak
 void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size)
 {
-	return buddy_alloc_maygrow(buddy, size, false);
+	return buddy_alloc_memory(buddy, size, size_to_order(size), 0, false);
 }
 
 __weak
@@ -838,6 +854,43 @@ int buddy_grow(struct buddy __arena *buddy, size_t nr_chunks)
 	return 0;
 }
 
+static int buddy_alloc_bulk_memory(struct buddy __arena *buddy, size_t size, size_t norder,
+				   void __arena * __arena *out, bool grow)
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
+	address = buddy_alloc_memory(buddy, size, order, norder, grow);
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
+int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
+		void __arena * __arena *out)
+{
+	return buddy_alloc_bulk_memory(buddy, size, norder, out, true);
+}
+
+__weak
+int buddy_alloc_bulk_nogrow(struct buddy __arena *buddy, size_t size, size_t norder,
+			    void __arena * __arena *out)
+{
+	return buddy_alloc_bulk_memory(buddy, size, norder, out, false);
+}
+
 static __always_inline int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
 {
 	struct buddy_header __arena *header, *buddy_header;
@@ -941,3 +994,40 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 
 	return ret;
 }
+
+/*
+ * Fails only when the arguments are invalid or the buddy lock cannot be taken.
+ * Nothing is freed in either case. Objects that buddy_free_unlocked() rejects
+ * are reported there.
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
-- 
2.52.0

