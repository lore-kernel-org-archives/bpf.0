Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248473;
	b=s1qqUCIJck3SG/rW408tSD6PZKl2CLwQfqtpwJ1BXMxTB7/rNFcwhj+l8FnDVtDlekkC
	 OpJW9YN3j+cgpWoitViboYtpYgEV0tvHrVBjtuMXqYyArITORZ8+D5bhUSEWPTWYsLw6e
	 jmcy01Ia1473qHygeS6GIOs9ieF+xLO5/cEgZI43UzVvMohDoYUxyEcoXKa1hG1S+dBR5
	 CjrVJdXafb6L/ORyca9tI5vyZCk2kL8V7zlbx+1ZKS+j02Vaf0blPFFI1NdZ8svzwwGix
	 4zJOb0yDn5sFHJIX3VMgckIxEiKtf+4/ZSkfT46Qmd9OM+fNAMbvzwdU2NfE2Ome2Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+XhztW8EozDWIbS5L1Se7ZxXSDA/B52QR5o+grrNClI=;
	b=DLcyt+FuLjm5Flsmts5GPFu3H3oP5Dpp0grgaVxgxKnZMGYFhZyiHFex1giGdntux7KK
	 dys3Sp16hSGMnN8c5hFQ1fsrVJzQNXyJxv0rs+jVl324p6k1zU1b58srFyA6pjhlmBKar
	 0z9Q8Y5KNaAx0XoEiYoWLDBHOkgNuqvbo7xZgnHA+/ui4az6vBQ4iUlPJ7ymiuc3s3XEt
	 bQKDPCjWD9/Mf3AUkaAco5orXBUuyFycmul0UuZqiMtGZXv3TMMppLpUmDvwHTf1CmFR/
	 bLdcmTChAWW5zXqoMfZyDwhXGzDr+7I3y4S6+tEb+kvA9AbvKSRMNPDlQI0rSdBAOfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=yvdBGPrn;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8446360A3811
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8446360A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=yvdBGPrn
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso912648a91.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248472; x=1794853272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+XhztW8EozDWIbS5L1Se7ZxXSDA/B52QR5o+grrNClI=;
        b=yvdBGPrnyor2Ww007TCh8ZqYCCHhb85AE+4lMeiYj4SNdmtufWpdCcnvB8zP/3b4UK
         UocGDTfrEVMYA+L2kS9GpDmyucetz3h7LtqaF5nqNE2/Hmtwgy//MjTASPqAX9C9gD7N
         jv1VOA8TV6VHtGF8eL1kip/0D/HiSPLUsbTLIZ3p8oV8kCPVoUamYGw9DrTUzV5M+BqC
         +WKK0LjLz1NtsaRPjALMq4gfasp+BrW/gY2c4NKjmovHr35y4zSpU91i0RTdA74ZxQ5V
         XnLV1s6vYcC9C/IGSu54vm9WxUrZtXEcWIsRL75yDToViSricY9lucnaO3zB/Ske7AU+
         NTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248472; x=1794853272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+XhztW8EozDWIbS5L1Se7ZxXSDA/B52QR5o+grrNClI=;
        b=L9wkaO409wtaBfzu2kd6Qd8BYN+YItyYwOwPKNpiDkRhUF6xTkP3JvZPGIGzbHAhBN
         PptY1vEjN80iuBJfZ4NVXpWKuhgclkzvI1Y0ztC+00docdIGjpEkvoGPOrbLWCXYkGT0
         sQS0/gIZakqy0o1u2jYzdt2hMBgAtexkbVT/hhMWGFvRjRx885/oPK1AuIxzQnHO5E78
         3ko1Zdx8QG1e4Mr4iGmRy/CXWE4zg106KAAN9A15lFTv0lEGMUDbGSmNU5BQ8ZYWDjYN
         WCg+f/FsVrRPM4GO30QGFmrINd0PnfZYeFxt+GUPb7ZTZH7Vj29n+pHwubED5La+we3i
         bBmA==
X-Gm-Message-State: APuU4Z8hOeuGVzczS9S34n7UIgB9YzZg0LmKxqiYDbr7+w5kY+IpKFye
	IJnOkxfizXV00J1/ZxW7Eem/kEzdlt1UMAPMnLXOY+VWJtAaJmsJfcZZU1OsQh7PSfwurwlhpn+
	/x8HFv4Y=
X-Gm-Gg: AYBFou3iWtnW4rA2PnAxirsmbjt7IgD9fbmYO8K56hlvHzOTfFT1AW4b1bTKfiLyGHt
	31pu2eHUWug/f7j+ij9/q/j7XeV6BrTN/zRtDR0ylPQJw2R+SRr1Q2DY+54rHOTePNheihO35+B
	/RkZSRQ1oFaNoiCyaem6+yWKscZBHoTOPJM/Vgxv80kjm4N+zZtzC16dKOiM3HBEAfnuPSMpj31
	pau85cLNSh+7lwqc1fHHUgrnTrPEQP8aEEqJMW9s8wMVK1U/PT0tXf4QArkjiYC0fL644LKgHvp
	oYtlTiIvUoVJ2Rvrdlxid1kNdu90wD/7gQCkOJ3rdouiiC/6dMLuS1K0fo287iQxnt+GSIr1kCM
	pj0RJnIFAd5ggo+UbKXZA204PnnCNYDU984l0J1q6ydvq2KCDn/sEUEL1p5yXNbCSvRBUFLc2lB
	5MqKMWMTm0+sZGdIVU4W+Wet4xhBBTNJdDswoT60meCd/5LHxkuKbySJBzKFeUck4yicvNnjFLT
	jwcaIvg36+/1G0PhaQVOVgbX/Rca84AFFR30ZczxFfeV6izfFDkxY1eOKYvupJ3EE2FucpGoTOR
	d7uF2hBapAZR/18RGmNLvW4zHW4Qg0x0t4Qk+mYX0diuEjaM2ZOPIlO+RxXKncckEaBIiX4QbGp
	7Dhu65+2VqXwRWnosxLVLZJyeJbQ=
X-Received: by 2002:a17:90a:d450:b0:3b0:9162:948e with SMTP id 98e67ed59e1d1-3b166cdd6e5mr468852a91.27.1794248471772;
        Mon, 09 Nov 2026 10:21:11 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:21:11 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 9/9] selftests/bpf: libarena: Cover buddy cache fast paths
Date: Mon,  9 Nov 2026 18:20:54 +0000
Message-ID: <20261109182055.7581-10-emil@etsalapatis.com>
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
index ef7e87344e83..37803ee23fd1 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -1223,6 +1223,11 @@ static int buddy_alloc_bulk_memory(struct buddy __arena *buddy, size_t size, siz
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

