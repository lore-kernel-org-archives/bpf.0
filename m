Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271133;
	b=d9/DMqpm8ujLo1+acmX9y/AzO34K+t8QZlF1Blj4g0XuZScecSSRak4jtb9c645+Jt+b
	 GprbTsXCsURngkTC/PHUTiJV35qvk6a/UpqHxxlaPY3zLkRGsQWjrRsl/JPGM2i9zpPFe
	 zvHsdNU0Ksv1oaCxXfHepdcuITFTzDz6DVHwy1xludsg2ERRHX9Kh/76Am2GxBTJpP82q
	 YxQKU0vqpmcxhpJ3I8+axTHaRrho3hB4Rx5nPvsRV5xKc4enDn7rOrJHuAz5WhBPMy/dN
	 ngA/cc/ap5Vr0ksruqaI+u+qO5Gi8+b6PrGGg5NbC4arw3tVr8CNW6wZscefuxgACtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PTJlj2zHExKlFLfDk1iN81QDs/xPTFxW9ybiLmfL+Rc=;
	b=qnCuJhSXB3E3KCkBnAVSaG18HDL7ZB6dIv3xNRkPGRzf5YStWI+ky6uNtRpDXzm23d/p
	 bjbukyJ/U9Oh1721XVdUtKB3+jLg9W0gn4rMcO3MGLJU6jqj33YlK5Nn+K4gbE19GcGqi
	 nFXqgVLWSbwPmPNNk7ANUfHeekKiJ4pU2YVBBs7gdd/Pd3dDg6rn6VYJR/hGPKhd+BNs1
	 aa8snoFTJS+wz4mG2ZrzyUuabs5vg96yST2SrwVH5MogkaqU8rbcoyA+IHycGnZVdTDVk
	 dZSju5UEz6w4QJN/cVkOVKpPS2Oq7SyWHmqCnSOf17l7hxpL+Sy5h5p+80HpQJhcwWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=XO+7yWKP;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB960A260C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6FB960A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=XO+7yWKP
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1239564a91.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271132; x=1794875932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PTJlj2zHExKlFLfDk1iN81QDs/xPTFxW9ybiLmfL+Rc=;
        b=XO+7yWKPJo6M7l58S1jLJ3GMxiLCiztrG7LScA7/cP2dIEkzYip9YL+auxqmNMwdNp
         a5I6MUk6tmb2LqFxrFxjkSyg6hE9/fivJGFD5rT3oHAfiU743G2nbKSPpS1PhUc24qZt
         6/uZyzVCNyuxKU/Ioxpq9E//EzSLOPIudj4SG9DwuUNu1nNHqQJoAqa9tubkIDtheKvZ
         O0KX59t3MBNUcj26J507iBArxsEAJBzoOvuRn6lYwfdibypt5jqhs2bHhY0LR3pnUIoy
         nLcH2SrkynZiAWnHd4oqij6uZC3Tf5WyFaAX8L0DMg7bljMMXX9fbv4onPOHcjTlmFGp
         cVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271132; x=1794875932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PTJlj2zHExKlFLfDk1iN81QDs/xPTFxW9ybiLmfL+Rc=;
        b=Ov1ux15BJQH60gx5Z4HVL6Wnfo3LkfXimjKMkqJ5Oy8+OshbY4PpycOIw8i3iy701L
         UN4cOvJVY+fpJAnc5ksvcrIqRAsjVLFva/dyN29/Yc2KPAxNjE18XrKB1XrTKN9NDhLz
         3/UcNP1XDNN08RcNLavVtZvRJ7OjRIAdahRK3xXk1ktNl6p/6ZFC86DDdkHl2Ya6TcXC
         6Q3gWQsLkV4n74XZoiFUxvsPdvV8LX9dZxnr7Y48nef8c5Dd1rbBFvtLsxLfdIO+AEQU
         ose7Zkokm0NSnmq32dVmMoUZc3NkqJwIcWRHZOkvTC9epdUaP3i2vJVKi2xwXfGKq9kV
         isKw==
X-Gm-Message-State: APuU4Z8J27oRMQmADYoHRKhr8wnn0YtdQVW32krW+8D/MlwcJvNrVlym
	PpaCYGpGA/kneIgrcsZz3yeJsf4UVSg/FbUDUGEH9byFV5I07dfzPcbGgAJkIalwW0LIAh4pRdm
	/iTXipDU=
X-Gm-Gg: AYBFou2IWpGHMU1QCVyknLQS8LwtZC//IqQyzRUizMtQEalJP7MnOoubqdjrHh4AwuX
	r1IFzqC2yY0vXZ+qCHI5XQhqgkzWTSSAsTfzEgnPLAiD7X0Jk2ESTcOlAZXduHKWNXeC+Su1VCl
	CcpG0rlke5tiaZdZzwasCNKObx4gtsvH61cP0zWqvcaDI+Iq9Oei4pd8RtaGQ5Si5QAqA6wW1mM
	ie1DJ2/7OwUtJBahDxHWSZSKz/pPIZAMceS2Nf3mMIlONG/BNZawe/qoz7TMV8iLWXBAv1KRwyb
	pZB7KCs7s0ka8Py17ZdSDNjfeMNNZUH8u6WAt/bNsFRGG9of8/2DccG3ZCLB/VDd1r7UJPTJ9hy
	KdDdQFoKEZymUdVcI2g2ygNtF0wS8NuTcqNJbdl9VOj/zAuvN3e+kh/eUgHkfG9GyjQWRsjgyRU
	lzsp7eBRUyj5JsAyuKTKPyMRnb+lqALhqIbvizVEmfppgpNBCHrau/t312zzE4JM4vEq0cRa4su
	buzp+/5e2sJbW2ySbvef6dOmQwCV55U8MHHB0vhXPCe3f6AxGKo0E7WbRwG6mkRsDTRj9KFcp4T
	DJnErSzuVUEFjohrz2Jm7WphQq6X7/UaVowO9fbso8TBMqB2tPe+VdBoroDXXt0AqqD1DO4pdwR
	uiUqWeP0pSbOzoFJNT5fBs01zzFzJp9y5yI5DteLWej7Hwqy+
X-Received: by 2002:a17:90a:e7d0:b0:3ab:b39f:41b9 with SMTP id 98e67ed59e1d1-3b166fdcc2cmr1135673a91.61.1794271132235;
        Mon, 09 Nov 2026 16:38:52 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:51 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 9/9] selftests/bpf: libarena: Cover buddy cache fast paths
Date: Tue, 10 Nov 2026 00:38:38 +0000
Message-ID: <20261110003838.8739-10-emil@etsalapatis.com>
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

Add coverage for the bulk allocation helpers. Check object stride, bounds
and contents, then free the objects in a non-sequential order to exercise
their independent metadata and coalescing.

Exercise local-cache initialization, batch refill, LIFO reuse and capacity
overflow. Verify that overflow moves a batch into the transfer cache and
that a later underflow consumes it without reaching the buddy allocator.

Document and test that explicit bulk allocations bypass the per-CPU cache.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/selftests/test_buddy.bpf.c   | 254 ++++++++++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    |   5 +
 2 files changed, 259 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index e7c6ac76433c..886a09019566 100644
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
@@ -221,4 +239,240 @@ __weak int test_buddy_alignment(void)
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
+	for (i = zero;
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
index 467b8eb92d2a..6e9992e3442b 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -1234,6 +1234,11 @@ static int buddy_alloc_bulk_memory(struct buddy __arena *buddy, size_t size, siz
 	if (!buddy || !out || norder >= BUDDY_CHUNK_NUM_ORDERS)
 		return -EINVAL;
 
+	/*
+	 * Bulk allocations bypass the per-cpu caches and reserve one buddy
+	 * block covering all returned objects. The buddy metadata records
+	 * each object separately so it can later be freed independently.
+	 */
 	order = size_to_order(size);
 	address = buddy_alloc_memory(buddy, size, order, norder, grow);
 	if (!address)
-- 
2.52.0

