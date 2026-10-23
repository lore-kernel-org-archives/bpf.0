Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714873;
	b=J0cL+Rx+QOttV4DEI0fd/d8JNZLQuECNMi59/CXd3gXvAtnDpolZCCn2HcyuYvOlxe6d
	 owGpzCHYiTBgG8NoKpF6iahebB1/GAKNnJH3x+1n//iTC6MZ+B8gm/976nr+gwGuViynp
	 2xzMVEErY+V3uOM8KAOq38bcdGpnQdR8z+3j3uyN4sY/XGJlEhMcGxnNuOLv2cAhDxuaM
	 X3xpdu9qWf3QgCWXvoJCEPFQx/V113w/AZmhJNi3X/jdX+RkGLF/YY+Fy4YclCOwueox8
	 C3ZaTHFIGrCZeTYMOUeVLxiOta0UtCLicZRvasIwDafGkR9mGKOSmVNzCrSa0TJ4GAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/Mpl/nN0vsobni+S/wZjWtkL9isEC+IYjCjUyJo5kzg=;
	b=i4EsLBUgSZzHEgf+NSFVSPSQAxbjPVwpMl8b1Uenw1WygTbl6VaCNeRAxc6TfOQbAJi/
	 bMN8WOs+PSIl23s2xMr28GBvlSR0CwCaQje0/xMmM8wiNmbcUqyMMNwaizRu/da3DeyfU
	 TKEwnWniDJznYGmCzCTZAI0CIPEGnVyVno7jiTGKSC9P4RAvE9fYxqc3K+fw0AYkUkFor
	 uwlydN6YC0kB7E7aP6Cv17aeTp7f24+K4m/uzFLpsURB4z/wbCxdN7tkIUzk0M1GgikSD
	 G10C23BFgOTLYOLRBMYwtJR+rr77THKEbrmIP1uqxYllycM/K8+0+E449wgECONI7pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=K+FPe43c;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BF606A319
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC2BF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=K+FPe43c
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso160693a12.0
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792714872; x=1793319672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Mpl/nN0vsobni+S/wZjWtkL9isEC+IYjCjUyJo5kzg=;
        b=K+FPe43c9WGUSPWHo74pPCtGCWc3FBPwGD6fQTdAmeg7ER0oYBDTIYX2be3BdbKoyT
         X6F2B5O8LKCeoRCRCVo7/qRZj7EA3atYQz4RIBGysnINdsnNsnMTer2iQ6nc2nUyYOtu
         mVIBpyoA/z84fzU2ut8fxXxqhSkO8WolPoQPT4nrPTF8JXPilixeVKkY2KefBZ3dTTES
         +K/n8H4mBcLGzFSv2DoYKwriFaufnNiNOLQLeJxKLl1DNtTcSU0lTXxXGo9UaFqjGOIu
         uN8XV+SVqESXeYJypJWjTs48LpPTi1R41V2t6Opf3VA50Acsgp43a2J74y2yiErEUcEZ
         pkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714872; x=1793319672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Mpl/nN0vsobni+S/wZjWtkL9isEC+IYjCjUyJo5kzg=;
        b=J4VEh7eTFiwvAInd92FjLeIJqJY2whLiM4DuiLTm4Jm8neAwvQbJ+vkiOgQeorTsbb
         AVDg0Pf168LEdxXTPczdH+qk7p1bNcGpTBZWHiLQQif1bVTMgRo79+15bnI6MwScq6LL
         4a52S3ZIhlPnjkGiynHWJ5spvkqFm+qIf+D9bBeuRv8xfmJcOg1XhdB3QedhT7k/e/DM
         JqD8tTeSJNOV1Hr7pV91uENgUq1Vu0vZdmHygw4gMUjfDZh16b8baVidcMHU4GZ9nGPr
         d7AWWGfkpO//hdUHVD+UmOLaVBSfyFYWEmOl8q1KuofiaLunQi7fZcmlL9Ie1U/FVROr
         iujA==
X-Gm-Message-State: AFq9FYKJVj9uskjt8JcaHVMarqqKaCHiEi4sbSof35X1zUgo/z5yn532
	NJP+hmQ6hT7JGtqpVWfNRF6/028er9YQQHazgcVrZbHCAdG/GIg9D3jpS9I4NXJDs175N1+ann/
	RDzP4v+u+ag==
X-Gm-Gg: AYBFou0KxJzb8MYysL0cYFrWRH1d0sIHwiao0Q6ysSr+nfEUaB845Bw6TBSAoRCJ35j
	KbJfT8ao4Yr02eqPktN1XmHXaT0kDHuRYE6ufs3GsspOWfDzpizKUWomgPaG6KNprTN8SjMudHA
	GfyRhyE40xpryBf2VU1YTVj+lrFWrOoefwqjy+QRYpHdebcgKOQ5JThFmyAuIffoRaxOT3gpmlJ
	NUeCVJSK7Ec97/FjaqLb/nUGrld7N4RdwkPvzxFo/aWXKm87TNbfSsWDH9Ju+reYqEnmEJQ7wik
	rwcA3dr5GBkf8SbDU1mf1lQXQIZxtr1TEQ0Mgl0opmUD7+MEP+1iSbZBVwK7TuAtJ3yJYKNqE7W
	Wdz0jaHHAD7qdTB6CibGZ9NNiyeNlyJHUJL2QeKZNOYQMPghrsn5t45eTLf+4+uzEtsW5WdzQd7
	47JBZOB3Sm2fbE8eLLtdtcCkp1VMTJT5ejmUupai9898JtVk2dZJxFk/ZgpnauVI/Nodpwj0e4v
	vFFAsnVAj7F6TIbHATqJKeSKBan8kSimpW3LB4wQz0esNBH8KifGzS1V2heRVIBm0MfpLwDMqaH
	fCfvrdGI075K1G84AQ==
X-Received: by 2002:a17:90b:5627:b0:3ab:31e6:12fc with SMTP id 98e67ed59e1d1-3adcd791abamr454322a91.0.1792714871804;
        Thu, 22 Oct 2026 17:21:11 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8892c4sm218649a12.11.2026.10.22.17.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:21:10 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: libarena: Cover buddy cache fast paths
Date: Fri, 23 Oct 2026 00:20:56 +0000
Message-ID: <20261023002056.6647-8-emil@etsalapatis.com>
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

Add coverage for the bulk allocation helpers. Check object stride, bounds
and contents, then free the objects in a non-sequential order to exercise
their independent metadata and coalescing.

Exercise local-cache initialization, batch refill, LIFO reuse and capacity
overflow. Verify that overflow moves a batch into the transfer cache and
that a later underflow consumes it without reaching the buddy allocator.

Document and test that explicit bulk allocations bypass the per-CPU cache.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/test_buddy.bpf.c   | 262 ++++++++++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    |   5 +
 2 files changed, 267 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index e7c6ac76433c..a25326a3b9a0 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -17,6 +17,24 @@ struct segarr_entry {
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
@@ -221,4 +239,248 @@ __weak int test_buddy_alignment(void)
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
+	cpu = bpf_get_smp_processor_id();
+	cache = buddy.percpu[cpu];
+	if (!cache) {
+		ret = -EINVAL;
+		goto out;
+	}
+	slots = &cache->orders[TEST_CACHE_ORDER];
+	transfer = &buddy.transfer[TEST_CACHE_ORDER];
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
index e6528cb5a63d..a10dd814f3d5 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -1177,6 +1177,11 @@ int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
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

