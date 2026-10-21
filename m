Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625244;
	b=ZoGg1f5zjRzjfE9gCFkMsLz1DGqCD9l/vYWqySx7O8Yx0XL0590wdrNTWXZXAllcgQHv
	 JJyj5+CuTS5VlY+xMtvMRrAwsQ9hX6SAYm9rFsBj1zDDHMlvK9d2f2yKF18FjRbte/cbk
	 lmjN9HCvREhLzUJhO23vySTqUVBR4CyK6/Clo74DR4AgKnskBSgKpWPO+Ahtq7qD8fHlp
	 b7gdDIkpwDNSVs/tlAa5vba1wIgXywDjeAKmecPrBQ/0i9Wg/hNNVJzzMOD8+TtMR9Jco
	 VCjZOWqpnnyd1MZj5Vkmj7uJlM5AUcGszJ6U8uTXuF6Vp9Rm+3PBNhRbP5WtAfT6JRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mxla+AF7fwgcAQrfp7UkjKT3qYHj+sqekfvzVUx2Szw=;
	b=zxq95qwHFomEuGA6j0gDa80uBq9xd6k5U/WP08kzxxWYO6+YjtE9GU7UovApwtOUoZ6P
	 TafzuKOG36YYlyqrEnV74Qvf1XZiFKNuxRNqeO6a71LX7BcFCgUNJQAeRGFSx9EO/Ct+M
	 PB7+Xopk2J3gupMNpKyjrIEYWntMPdfX/05GYEJoasvnmjjEBINYVI2M/3NCXtiLEhR64
	 xFxzk1z3aVrFRq8czOWXR3zJ3pefyW2OQBtHt7ILqjJ3k4aaOSjH4GIzsvygh5a5XN/eL
	 kQzODTBUFQqrTiDQAsxRZourpZoZFYvHqXcMZ1FhwwwYq5rPZ0uxyJjDCzuIImSRE5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=qQeiNpwI;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF3606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50DF3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=qQeiNpwI
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e5378b281aso6440735ad.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792625244; x=1793230044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mxla+AF7fwgcAQrfp7UkjKT3qYHj+sqekfvzVUx2Szw=;
        b=qQeiNpwIK0Rh+CXj4qe8lokhvS/2yku0JUTcyfuUeIn7ECLcRb4OZaD5As13rJQ0hn
         2YfJAp3p7lNcBYoBXf5412HUHM6j2w5oqkdp5yzKPz3ure/bz9nSvfvniU+ZaRQd1XJE
         ZDjwlY7eymmJrBHEiYc9jDynbBJpYe/6pDc0ZCstNGSg6itmA5UCRRpgEukFNFWl4v6M
         /jB3o5bJiDyAvptccWjK7KOyEBdrBYIjruCA7vV5qqRnSPVrevPM2rIVBn/YAWcpqT5A
         Ckib1KRu4Bmnvu132G2Rv8yza0j1rVOpoWEA6BSku0+hwkyjmPMGAOwfTnsH4qi2Qzbq
         RxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625244; x=1793230044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mxla+AF7fwgcAQrfp7UkjKT3qYHj+sqekfvzVUx2Szw=;
        b=dLb/RCh49PQf8PUt4NYlxyGH3dS2Rthno3e6A4epzYPajFEe5yxsSsVG64j+r4LM2S
         KWxDyu/kLWv+Bjk9pnLg6d+2ERbWYhnxPhGWNncgBqYUqn09pAvZtpxmwu3rm9q8bCki
         zue0wiLBLNhmsNkLSi6wYnRejOE0no6WfM1D42OQyDTLsanaRxqkS+/37AbzXGBHkecH
         lcF2cS7ynK7c7ekkQn45zFQQqna1T98nz2s0Jh9XhzCS3uqM2qo0oyVnH2IjtsTGt+3S
         N0N3P3PFQoiHwEt7x4l8c1+VbZrKpUHDHK7SjjGux4A3tOYGZQKaLx8IB5Nvw94tAz/7
         fYpA==
X-Gm-Message-State: AFq9FYJLHfXvOH7ls+9RqHlSYLsH5MyOPNXadWB821QcN3nTK3Y6+yB7
	sFqWcZzS8IwfKm3oczEsl7gyvg6DUBhYWTHIrD3yyLIyATIvW7XWqBKZY8Lg1ImgLtQF/NZg0oq
	nmf8bbFOBNg==
X-Gm-Gg: AYBFou2Y09gjyVeYI+wF/l3fT1rJoxjY8hE2cMCusHOjXOpMd1pKukbnH94uMPB7xlh
	0oyf1nRaYIjABQjF0mhBrEQPozpIN164ZYcFL4yI+dJqN2c8ozB0IvrOCoJxYFu29VdmPqJLmC2
	9wwoug6cqPPAP9Kh0ZovjV4Bs3pUoPBi6e7d4T9DiPQcLVW+zzTeIoPERVnGw35br4+mRw9I8Yw
	qpqIE3KjosTiRb/JrK2vsq8r9HEVp7woLPOZPNSB/wrSVpmNdsIvNL84UGAOgHaK/TOj25YlREQ
	K5RKJ57LO1KhA3D4D4wIzTnAEb5iILoCIpvADU8/cpte9jWvA1fhihg7DIzzLPgn1X3Po0nB8Je
	vfQmgqPOlzp9BnZWQjtIc2Rbydzbho8z59Xe5VFzMAN9FvePt0DDE36ctvbudYW9wMctWoy2wSw
	ez96yRuc0aK4kID2IwXoe+Upp+tMXoA1jPaACTHoGL7GfOGxlBLRWiadEcWE53rfvTB6/lBfblO
	ZDBA9p6gALvzbraL30KUcbjLA3gkCT7eXfX7FJQ5IUV
X-Received: by 2002:a17:903:1a70:b0:2df:90d4:7847 with SMTP id d9443c01a7336-2ea43c631aamr28989005ad.35.1792625243641;
        Wed, 21 Oct 2026 16:27:23 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:725c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada70sm15651425ad.72.2026.10.21.16.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:27:22 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: libarena: Cover buddy cache fast paths
Date: Wed, 21 Oct 2026 23:26:41 +0000
Message-ID: <20261021232641.10063-8-emil@etsalapatis.com>
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
index 80f2a49f95e5..bd52fd9c3146 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -1172,6 +1172,11 @@ int buddy_alloc_bulk(struct buddy __arena *buddy, size_t size, size_t norder,
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

