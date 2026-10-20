Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520352;
	b=yN1GFbriNSHU3RYWd6rQ1XU/wLrY7zGVrHAYz5y7Pj9Gcl6mbucN/wZKYKK+66TGIb2h
	 5tvBZLJqVL5vHxTdrsk/zlb0arw8I6RSd6vwg12eMKRZOzSjO4W+YGfZ+ezvkgWojSBK9
	 Y9/S5Jso9LX/10YPieAfLj9olqFBueKFGZHjdBbPLMcOj5mJ7LCET8u7PCE5ZYUDoVW0z
	 OGU47GfVFKNgSf0D3vCICcpQJSsug6H45OplQBM4XUrhloct2QgkjQROnsWZyicZLWDf/
	 CCE0Dy/JIHg2M0OQ39Q88OLmyxW10CTEYMb7aY9tgseBxQIV+tnoeuWaKSmgH+SZaEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AkNxUSSZGZGrsk11lewd3r4k0/jZfhTbmEuihlD1zfk=;
	b=pVNmBUPramVAWXXSvRjbyn+GHWYhNDTh64vMdxirX/iPYIvfL59sUOySoFsgReyu7FAU
	 RbxM9snIC0JH2wtTc8tNtbAkhcW/utKhW2qgJO1zoTL3AAkxi6vP+kWLYao8LXXPIr3cR
	 /n5alfNAtQqN2M46hn6Lbs8dV+zXW3ohWUO0Ugjzu2LWnFv3TJFs1dfkPvzlHFC9t3FdY
	 R18SE4cm8Exau2eDlQ//Io4IyJGcnuchgNMemLcKMk3fko3ZZbYzLpP3N30/X1GKPCz6L
	 bxDIwb8XAFidWijEp67ukyiHcw4xdthwTUImV+OxgPYnc7MlJqCfeIN6TVVIFWhXoag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=PNtxKsW9;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20460A260E
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF20460A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=PNtxKsW9
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1742951a12.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792520351; x=1793125151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkNxUSSZGZGrsk11lewd3r4k0/jZfhTbmEuihlD1zfk=;
        b=PNtxKsW9rj/u5B8buj8KBnwCPkT1IQOhbetvndJv9NnCFfYY/uqmvbi/tF8g9vQHY/
         bjTI1hEIGT7C8OqtxS2Jsiv7i/JE4CvZjO2Q68dQDGdzLvoVRgs9h9i0v251gvCfN5Zj
         Nzrov0E19XTwG+JjSbRRJWzPvxV0eKsPAH7kDoqIVvm/MB2Nh8VJpcVqgM986Q26g/td
         vwHPjf3KRdo8HyMPC+p8sHXyIqAcv2ejE+B7LzfhMHmyuIgsQuTrdXFYW8cfS0IgLk24
         QF8nVKeL/blWIOj+M9hnU+8pcXmrN2rirrhi5NgpUbw2n6vWErXJwV3pgHLrON8mQyIc
         ZH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520351; x=1793125151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AkNxUSSZGZGrsk11lewd3r4k0/jZfhTbmEuihlD1zfk=;
        b=yoNuMZJAB3pMpqp/sIlzxvxOs/Sgqx31OoSS8Guf+NpBrEvigvKq3i8xLdYPVGtd1w
         A2MVn0C4nbfNJrPUo4BCKrlH7RGJOw+jk0TxiqDhBifav+VLudcNVsz8S8hUHbutZQ5Y
         Fo8LuxIKCz2MFJ65z6pXb9o2n8RBlfjsXTQ3cYibUrNzdLpICBOjEWvxxfjJG7cAQSLi
         LiTNFs3XY79/2dYBnM0Yj0tH/VNDQnvqaIQkIIvgLKvOeyB21gnhgcqPSnCDg7tRhE8c
         YCurOMfH1msh4BLBVPGj4xzEf7qgpP8v5mYurvX9yppXCEwmfog/S2nRvUyMK3WRvGti
         COdQ==
X-Gm-Message-State: AFq9FYKFclYqgLPaZTvfWKbDfBdRAeBoH/vmIO4sC77ycEmcKoW3e2T+
	qYAFxatEtKTH3cDzcgGmU6dH4keDePSkY0aa/198ifIMvQWn3I+NSYz9WdYQoRzwI+h/bmMI3vo
	TmaGr
X-Gm-Gg: AYBFou2Tt8zrkKRO/XuY/CUOdjDeBH8OMYGWgFHVc6oRP73rVxDdNfviLCn/tTJTmrx
	oGLW975sCnUzqUBNOqHM5LBP6kmrzUcNr72DyehmanQZdTkkvFFBc/YkXIBYoQfOE1oRAdzbaJz
	0E1Fh/NR5JPcGif1LKqGWOXc+djoH2Dwev1xx9XuN0+Yy90LeMOGpdOEdacXYQHG1oHl8YeJSfe
	Q/vp+97c72Th4KCwQr0qeSoUZnl+WjqYWQWuTKfCntu3PY88tpKH1I9o9tUC1vtRC+irVBnRIWz
	ThSGc8jkpqcgKZYzKYv8UjW0C11uQj8oyITItD/vuCP5Wbm87U452pPS1zTGGYYFiWBw7wD6LGW
	pjy7FP/74ZqUj9MHmPFvd54UcJiz/DAP6g81ysRoWIpc/F91SoaoGw174w6FuAm1MUDAPpzmAjF
	gI0eGCPEkHbqy8QEqP9Rb77mhgyapHFElJw9PdVtDTP/IYPCqtIdybIvrWfz8mtGqglt/3iCZ9+
	YdxtPBDSOBf/v2x+ZGInFXu2FJPF6vItQZX
X-Received: by 2002:a17:90b:5448:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3acee98db60mr9518125a91.6.1792520351099;
        Tue, 20 Oct 2026 11:19:11 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm710661a91.2.2026.10.20.11.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:10 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 7/7] selftests/bpf: libarena: Cover buddy cache fast paths
Date: Tue, 20 Oct 2026 18:19:00 +0000
Message-ID: <20261020181900.6755-8-emil@etsalapatis.com>
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

Add coverage for the bulk allocation helpers. Check object stride, bounds
and contents, then free the objects in a non-sequential order to exercise
their independent metadata and coalescing.

Exercise local-cache initialization, batch refill, LIFO reuse and capacity
overflow. Verify that overflow moves a batch into the transfer cache and
that a later underflow consumes it without reaching the buddy allocator.

Document and test that explicit bulk allocations bypass the per-CPU cache.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/test_buddy.bpf.c   | 266 ++++++++++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    |   8 +-
 2 files changed, 273 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index 6d123ec052b0..f14c2945d1e1 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -4,6 +4,7 @@
 #include <libarena/common.h>
 
 #include <libarena/asan.h>
+#include <libarena/buddy_cache.h>
 #include <libarena/buddy.h>
 
 extern struct buddy __arena buddy;
@@ -17,6 +18,24 @@ struct segarr_entry {
 #define SEGARRLEN (512)
 static struct segarr_entry __arena segarr[SEGARRLEN];
 static void __arena *ptrs[17];
+
+enum buddy_alloc_path_test_consts {
+	TEST_BULK_NORDER = 3,
+	TEST_BULK_ITEMS = 1 << TEST_BULK_NORDER,
+	TEST_BULK_SIZE = 17,
+	TEST_BULK_STEP = 32,
+	TEST_CACHE_ORDER = 2,
+	TEST_CACHE_SIZE = BUDDY_MIN_ALLOC_BYTES << TEST_CACHE_ORDER,
+};
+
+struct buddy_alloc_path_test_storage {
+	void __arena *bulk[BUDDY_CACHE_CAPACITY + 1];
+	void __arena *to_free[BUDDY_CACHE_CAPACITY + 1];
+	void __arena *drain[BUDDY_CACHE_BATCH_SIZE];
+};
+
+static struct buddy_alloc_path_test_storage __arena alloc_path_test;
+
 size_t __arena alloc_sizes[] = { 3, 17, 1025, 129, 16350, 333, 9, 517 };
 size_t __arena alloc_multiple_sizes[] = { 3, 17, 1025, 129, 16350, 333, 9, 517, 2099 };
 size_t __arena alloc_free_sizes[] = { 3, 17, 64, 129, 256, 333, 512, 517 };
@@ -221,4 +240,251 @@ __weak int test_buddy_alignment(void)
 	return 0;
 }
 
+SEC("syscall")
+__weak int test_buddy_bulk_alloc_free(void)
+{
+	const size_t uncached_size =
+		(BUDDY_MIN_ALLOC_BYTES << (BUDDY_CACHE_NUM_ORDERS - 1)) + 1;
+	void __arena *sentinel = (void __arena *)&alloc_path_test;
+	u8 __arena *mem;
+	unsigned int i, j, idx;
+	int ret, destroy_ret;
+
+	ret = buddy_init(&buddy);
+	if (ret)
+		return ret;
+
+	/*
+	 * A 17-byte request rounds up to a 32-byte buddy allocation. Verify
+	 * that the bulk allocator returns every child at the expected stride,
+	 * without writing beyond the requested output array.
+	 */
+	alloc_path_test.bulk[TEST_BULK_ITEMS] = sentinel;
+	ret = buddy_alloc_bulk(&buddy, TEST_BULK_SIZE, TEST_BULK_NORDER,
+			       alloc_path_test.bulk);
+	if (ret)
+		goto out;
+	if (alloc_path_test.bulk[TEST_BULK_ITEMS] != sentinel) {
+		ret = -EOVERFLOW;
+		goto out;
+	}
+
+	for (i = zero; i < TEST_BULK_ITEMS && can_loop; i++) {
+		mem = alloc_path_test.bulk[i];
+		if (!mem) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		if (i && (u64)mem !=
+			 (u64)alloc_path_test.bulk[i - 1] + TEST_BULK_STEP) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		for (j = zero; j < TEST_BULK_SIZE && can_loop; j++)
+			mem[j] = (u8)(i + 1);
+	}
+
+	for (i = zero; i < TEST_BULK_ITEMS && can_loop; i++) {
+		mem = alloc_path_test.bulk[i];
+		for (j = zero; j < TEST_BULK_SIZE && can_loop; j++) {
+			if (mem[j] != (u8)(i + 1)) {
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+
+		/* Five is coprime to eight, producing a permutation of all items. */
+		idx = (i * 5) & (TEST_BULK_ITEMS - 1);
+		alloc_path_test.to_free[i] = alloc_path_test.bulk[idx];
+	}
+	alloc_path_test.to_free[TEST_BULK_ITEMS] = NULL;
+
+	ret = buddy_free_bulk(&buddy, alloc_path_test.to_free,
+			      TEST_BULK_ITEMS + 1);
+	if (ret)
+		goto out;
+
+	/*
+	 * Order eight is immediately above the per-CPU cache range. Free a bulk
+	 * allocation one child at a time in a non-sequential order to exercise
+	 * independent metadata and coalescing without the cache intercepting it.
+	 */
+	ret = buddy_alloc_bulk(&buddy, uncached_size, TEST_BULK_NORDER,
+			       alloc_path_test.bulk);
+	if (ret)
+		goto out;
+
+	for (i = zero; i < TEST_BULK_ITEMS && can_loop; i++) {
+		idx = (i * 5) & (TEST_BULK_ITEMS - 1);
+		ret = buddy_free(&buddy, alloc_path_test.bulk[idx]);
+		if (ret)
+			goto out;
+	}
+
+out:
+	destroy_ret = buddy_destroy(&buddy);
+	return ret ?: destroy_ret;
+}
+
+SEC("syscall")
+__weak int test_buddy_cache_paths(void)
+{
+#ifdef BPF_ARENA_ASAN
+	return 0;
+#else
+	struct buddy_cache_state __arena *state;
+	struct buddy_cache __arena *cache;
+	struct buddy_cache_order __arena *slots;
+	struct buddy_transfer_order __arena *transfer;
+	void __arena *direct, *cached, *reused, *refilled, *overflow_reused;
+	void __arena *transferred;
+	unsigned int cpu, i;
+	int ret, destroy_ret;
+
+	ret = buddy_init(&buddy);
+	if (ret)
+		return ret;
+
+	state = &buddy.cache_state;
+
+	cpu = bpf_get_smp_processor_id();
+	cache = state->percpu[cpu];
+	if (!cache) {
+		ret = -EINVAL;
+		goto out;
+	}
+	slots = &cache->orders[TEST_CACHE_ORDER];
+	transfer = &state->transfer[TEST_CACHE_ORDER];
+	if (READ_ONCE(slots->elems) || READ_ONCE(transfer->elems)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* A miss bulk-refills the local order and returns one object directly. */
+	direct = buddy_alloc(&buddy, TEST_CACHE_SIZE);
+	if (!direct || READ_ONCE(slots->elems) != BUDDY_CACHE_BATCH_SIZE - 1) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Subsequent allocations and frees stay on the packed local stack. */
+	cached = buddy_alloc(&buddy, TEST_CACHE_SIZE);
+	if (!cached || READ_ONCE(slots->elems) != BUDDY_CACHE_BATCH_SIZE - 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = buddy_free(&buddy, cached);
+	if (ret)
+		goto out;
+	reused = buddy_alloc(&buddy, TEST_CACHE_SIZE);
+	if (reused != cached) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Drain the local stack, then verify that the next miss refills it. */
+	for (i = zero; i < BUDDY_CACHE_BATCH_SIZE - 2 && can_loop; i++) {
+		alloc_path_test.drain[i] = buddy_alloc(&buddy, TEST_CACHE_SIZE);
+		if (!alloc_path_test.drain[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	if (READ_ONCE(slots->elems)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	refilled = buddy_alloc(&buddy, TEST_CACHE_SIZE);
+	if (!refilled ||
+	    READ_ONCE(slots->elems) != BUDDY_CACHE_BATCH_SIZE - 1) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Bulk allocation bypasses the cache. Fill the remaining local slots. */
+	ret = buddy_alloc_bulk(&buddy, TEST_CACHE_SIZE,
+			       arena_fls(BUDDY_CACHE_CAPACITY) - 1,
+			       alloc_path_test.bulk);
+	if (ret)
+		goto out;
+
+	ret = buddy_free(&buddy, alloc_path_test.bulk[0]);
+	if (ret)
+		goto out;
+
+	ret = buddy_free(&buddy, alloc_path_test.bulk[1]);
+	if (ret)
+		goto out;
+
+	for (i = 2;
+	     i <= BUDDY_CACHE_CAPACITY - BUDDY_CACHE_BATCH_SIZE && can_loop;
+	     i++) {
+		ret = buddy_free(&buddy, alloc_path_test.bulk[i]);
+		if (ret)
+			goto out;
+	}
+	if (READ_ONCE(slots->elems) != BUDDY_CACHE_CAPACITY) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* A free beyond local capacity transfers a batch to the shared cache. */
+	ret = buddy_free(&buddy,
+			 alloc_path_test.bulk[BUDDY_CACHE_CAPACITY -
+					      BUDDY_CACHE_BATCH_SIZE + 1]);
+	if (ret)
+		goto out;
+	if (READ_ONCE(slots->elems) !=
+			BUDDY_CACHE_CAPACITY - BUDDY_CACHE_BATCH_SIZE + 1 ||
+	    READ_ONCE(transfer->elems) != BUDDY_CACHE_BATCH_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	overflow_reused = buddy_alloc(&buddy, TEST_CACHE_SIZE);
+	if (overflow_reused != alloc_path_test.bulk[BUDDY_CACHE_CAPACITY -
+							 BUDDY_CACHE_BATCH_SIZE + 1] ||
+	    READ_ONCE(slots->elems) !=
+			BUDDY_CACHE_CAPACITY - BUDDY_CACHE_BATCH_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Drain locally, then consume the batch without touching buddy. */
+	for (i = zero;
+	     i < BUDDY_CACHE_CAPACITY - BUDDY_CACHE_BATCH_SIZE && can_loop;
+	     i++) {
+		alloc_path_test.drain[i] = buddy_alloc(&buddy, TEST_CACHE_SIZE);
+		if (!alloc_path_test.drain[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	transferred = buddy_alloc(&buddy, TEST_CACHE_SIZE);
+	if (transferred != alloc_path_test.bulk[BUDDY_CACHE_CAPACITY -
+						     BUDDY_CACHE_BATCH_SIZE] ||
+	    READ_ONCE(slots->elems) != BUDDY_CACHE_BATCH_SIZE - 1 ||
+	    READ_ONCE(transfer->elems)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Interior pointers are rejected without consuming the allocation. */
+	i = BUDDY_CACHE_CAPACITY - BUDDY_CACHE_BATCH_SIZE + 2;
+	if (!buddy_free(&buddy, (u8 __arena *)alloc_path_test.bulk[i] +
+				 BUDDY_MIN_ALLOC_BYTES)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = buddy_free(&buddy, alloc_path_test.bulk[i]);
+
+out:
+	destroy_ret = buddy_destroy(&buddy);
+	return ret ?: destroy_ret;
+#endif
+}
+
 __weak char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 2248631392b2..796dacf3c6a2 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -318,7 +318,8 @@ static void __arena *buddy_cache_refill(struct buddy __arena *buddy,
 		goto done;
 	}
 
-	ret = buddy_alloc_bulk(buddy, size, arena_fls(BUDDY_CACHE_BATCH_SIZE) - 1,
+	ret = buddy_alloc_bulk(buddy, size,
+				arena_fls(BUDDY_CACHE_BATCH_SIZE) - 1,
 				(void __arena * __arena *)slots->objects);
 	if (ret)
 		goto done;
@@ -1179,6 +1180,11 @@ int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
 	if (!buddy || !out || norder >= BUDDY_CHUNK_NUM_ORDERS)
 		return -EINVAL;
 
+	/*
+	 * Bulk allocations bypass the per-cpu caches and reserve one buddy
+	 * block covering all returned objects. The buddy metadata records
+	 * each object separately so it can later be freed independently.
+	 */
 	order = size_to_order(size);
 	address = buddy_alloc_memory(buddy, size, order, norder);
 	if (!address)
-- 
2.52.0

