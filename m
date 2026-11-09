Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248460;
	b=OPU0tsI7FR5taTB0GATVr6R7C18dOjyhIPNbL+RwbUogvYMDp1zbH2lPjIMU4Dt23A0A
	 U28xNyXl/NEzBifxi8htAnav7wSX0ajlAhap/kOjsnd4wa1YIIpkN9vdMuK5py3SqWAth
	 Ca1OF2MGnHRFTJjibeP16nKZPhiSIhz5Edq9AnmPmF+HORU77+BD+KjX2nxZCra+53YXC
	 vBCa2V9H/HlbRXtfHhdUXvGy/SaQcJahTpQ7HzsmcPQPMe+f0zY1nSwUK8vH+T9s4icfP
	 4bO68Y4TP4xhj9Gr/svKhof0k5BwkapUwhpwvnyjxcOHUo6zYGGWwUb0DO0z9EnzWAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d/MfMlM8XGgAJJIuusCwscxzvQuKTLjHmuXDzRYpdVE=;
	b=5FhTlxJfdZd/fFcXTHPWgcE+IBVzkCgVGFYa0V7gsuNDmsfiu2zKfUw/jqaEuOiGppeZ
	 kkFfSLAi9v1R38SYb+6As45VOgvH94SwuQ8vw2n8Vnzjo1uuhd6M6hxB3+u5FMgrsmADA
	 8HRBrQ/iNzc3ORvPYmOl69V6xNNW+S5Hg7pmyQ4BJfgSiH5MRKFoRbzOtF/dH/7HJS8eW
	 E4Kv9AvUaJL8I95Q7sKNi0ylRPgIXYFzADHba52v7wo+//tN2FGRkJdOBvc35Aarawdsc
	 BI7ttea84HBwAZnyTQ/jWX6LUS/dg+RkBeQ2Ibu1UZpyxGreiuUmF/IuWyONS4dcPBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=fm00xD7W;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4660A261E
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74D4660A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=fm00xD7W
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so719661a91.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248460; x=1794853260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/MfMlM8XGgAJJIuusCwscxzvQuKTLjHmuXDzRYpdVE=;
        b=fm00xD7W1Wn2w/btYALEo0HtCrwTF0ZVdCYxqxDk5wOx4tx8nqPUQ4i2taa25lVqHh
         qX0VrGXqPIQSBfhpe1VV8Sf44GpLG34F4JI76IRzzTbxCqAzc4DoF+p2HKH/Hkjoj0UT
         ootem1scc8siRqH4tlUDkap4pwXXpHsoyLriUUxcsRW0lSTLIkwYH6mA3GqOQfRW5miM
         nMByFK7o8LEhTj1PvvPtjkgf0EFgGNU54xVemGlc67+DeKhCJhxVEaff3OAExncC9fh1
         7f52kVjDl8QBGXsCcKE58u9QYX3JPmcftb/x6oDUpnFZgdX36N+Af2Uo961HdZhTB6Sc
         zLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248460; x=1794853260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d/MfMlM8XGgAJJIuusCwscxzvQuKTLjHmuXDzRYpdVE=;
        b=vG2ieZv2KHrHZTfowAUSeisuG0icwMXJTfWFOsr5C2mKDW4PsL5BuRtcPFV7t4s32G
         7v1NuaYFBHb5dlSzBJinD/Fh09WhFa80C2394MD7xfY9aSSctps1+IhV10t4qF6C1dio
         76IrE1WgCIhIVdDIv5HTx3Q6YvMcITGHpZ6hZHWHhvguMUwPm3rGKzHfwTpPH051Q4s+
         oD5LmBeUK91jeE27Iu6Gckx0WVxS7GoQC2qlAvueaP3Ul19m4PxxKvVaHGeYb7y/f2TJ
         KVulfoS5OysTvaKzUOzXEUoTxU+MGM3NnYMGw4GWSvIoO0j46IV8x2VgO+lwy0CefKGC
         mCAQ==
X-Gm-Message-State: APuU4Z8INgMzE44ck7kqp7GfnG3Rsq5nBV1SB2Dt9X7CKG8w0veiCzMt
	sfQ0/KN/T6RFF5Z04MYELiIiqARS7JJH9X62a29HNisK45bO1eJd42wa/W5WXXkZPa23E0aa0Ie
	SeVKQonA=
X-Gm-Gg: AYBFou3EuQhpdOOWih/5n5Xn9WMeecMdXT/Zx0UltpUZMuC7tjh1o3h2I3GPHS1VKGq
	2Lq1DO6xN52YXcD2lgID5nqE7xKfgTG1xhXFdmKsH90TsV8wXnQaPbGLoG2bKEXWgfz9aJhuBnx
	d4MJxxIN57eDrn7wMV79hKSPHpAgZE1ONVDx2x8lE9Gw31njOryNultSQQNQHQdvnS9bljeTCYk
	ICC9+qO9WPxq3XVaqfirZi55C6IJGC1gKcxkxCefQ+L71NT9OccEIuLxNmDYiKPtxqdnFFKGAf2
	FEWpWnCX+osXQyDBp4auC96461EgcJhreGm1RV4ViJr5YDD/Oo0OZ3X64B4MD50QKoNJyx6tQ1A
	onGajM8d6KqKWUiXbyAMLtgMrxbtDdn9iM/RTVkfRfoXmGTal9MjS6If7Sgoq43/OFvRjSQEf38
	KnTNjEoLZlkiGOSnXifQnXxWUgJxPJrApbVL5nGlsFUnBqdmNR9lGIVhsGpaZb4MDerZhGUILvK
	bVzXGRtLKO68JG/54U8jgriXWbLP/nMYyCNFquDDovm8r0zBWkPR/PFSlJiHLjIQV4592OscMzb
	TVLNNOXoFbmUr9Q5NxQ3VppFrfbCbC239QG2eFk9wJ5v1QYp1bzFiUlqG0ndwzncEE4/ajzgwQM
	fLwT5l4pEPiN0BYlTBXgWPhDY7hU=
X-Received: by 2002:a17:90a:e7cd:b0:3ad:c482:ae9a with SMTP id 98e67ed59e1d1-3b166b42013mr473591a91.1.1794248459724;
        Mon, 09 Nov 2026 10:20:59 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:20:59 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 1/9] selftests/bpf: libarena: Add bulk buddy allocation helpers
Date: Mon,  9 Nov 2026 18:20:46 +0000
Message-ID: <20261109182055.7581-2-emil@etsalapatis.com>
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

