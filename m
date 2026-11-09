Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248469;
	b=MPWpIasPBOGtwOOFLSqbdtzKk3g/M8b+dlZAXkOOVItU9iN1+AFEHvDo2wcBydv9AHiJ
	 Y/Cfl0bBx1gkNakTLZWd5Z7n8zPsyUVaogbQbHrEZEIJ1kiNi4QS1AZze50Asfls2W0b4
	 DxgouOaOf5t/5OOtQjoaJxtVDwXBAO3it3IE32SxHFCQ1+ST3a8ikPlNgtoH0rkP5/ML4
	 VK5SmyfaXRwbJ+UHLfK8veudvKer0seGmbCdrVlJilgvppel7QWjd0OK/G5ps4JNjxkLY
	 hB3kg78mMwp+GgGy9uuvmw7K8gpt4ieqvJy0a6fLl+mYn6MVP+xgQrUURd443WI9KWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fdWIPk5T+c/WLC5ol5Qv+1p7Ekr3UScII3Dcwr0WCkQ=;
	b=WZoRf59imqGaYWQeouqH6nrGQzqz0OYsSsO62WYtPMV5rPrjGzvySMy7hhuzT8jM0Lb4
	 0R4oAObiSf43VUalq0P5cnlZOzuhxrBn6vnPuRpyKybVBKzjQe9vWfQtwffoTXuSGA9m1
	 EzHRX5Pmct7tAfSVPj2FTL3XiFgdg25/Jtw6bOuWuQOTJ5BYurRBPQCVE2afcsQs/CRZk
	 DQCJoi4A2ammbmuy3iY/RQkb4tBYeSTQWeqByqv+J+pa1/Yn38L3cRN/nchZ3rPc3cjCa
	 ryX9FtqW6loNBfs4Dpne3hlWWosRT31E9kGbde5TC8qEnV3Dlw5mBy/4HyeRce7fxEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="vVY/DxQl";
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C985860A2617
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C985860A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=vVY/DxQl
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so529624a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248468; x=1794853268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdWIPk5T+c/WLC5ol5Qv+1p7Ekr3UScII3Dcwr0WCkQ=;
        b=vVY/DxQlzMnS39RP416eFQXYrEMzTVBKBk+gKmfTrmHlRpqGIkm0aLZKeCNfaB/CQ+
         VaGrQCPhHHBgNsxL7Ol3PzRs+trP1c57lhrhPvuHtuq7TLejbwpP1uuG7Qy3H6K4fGZN
         Q5HFtE4T0RMEjf0txyOHHvzWVeZ8TpdwbhLZN7RtKUZpCOJTx1NoGztoBr4DLuOyrKYz
         aio2zYw8Eb3bBMpz+FmbiLgWb0SK/tLo9gwhiX7VadJaSwSXrqbc8z5z28CJxqXvdNrs
         fsk2kZqSb1ToUPX/kWVRrvm5loPmyoIXyL8C1sm0Gy7v1BtbfM5jB+vzrjb9l8kF3STD
         LoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248468; x=1794853268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdWIPk5T+c/WLC5ol5Qv+1p7Ekr3UScII3Dcwr0WCkQ=;
        b=ZBY/8uM2GonsRJcaJK6FqYWIPXxUJzumDZnddO0feMSmKaHl0u1B+JdLodXazyVkmR
         Fi4IPreVPfU80fX/nkYc6Ahv5ln54Y09iu1+J1RZEvdpEsZ1WeQ2VoQQCsUlawPtCnmU
         1UlBMjnCEnLG29mBYhpo8TO5H5PqHzluMUQXv8sHC0qHKt5BIlr+gFlckhdE5XG/G8AX
         S7bP1BQ0Q+txkprxp0y8fyvnQsUb4d4OyFkEuTmA/Ixs36S2Ty/nez2azN0ChX41xMoF
         o6k6+xXEGAD0oa0xNkHUN+lbpC3qScmGrZKZbksQBwEZiOIR1Vyq5srfveecFY6SnKyC
         3G1Q==
X-Gm-Message-State: APuU4Z94RVI84pNpVvoMU3hgw/MhG1poPqlyAxk4s0ZSrt0WKUEahKVn
	EuxKCPnRTMNBVJWajnOZGe1/H3MgnRQmduOGHqmePv/2jTTwH7ZDVINF6EIq2Tdrcvof5at4ZFJ
	o7g6O
X-Gm-Gg: AYBFou2zRnuHYj0l9obyUfAu1xrtfXtVWSjDh8kb3KJbXryN/yieS5JebrTYy5IqeEQ
	YPJ841XN9yD1ogqwuEuwaywsUdlsvHb/iON42Bp2A2Q9L4rxbWEnryRsDvmt3UrboyNlpD102RO
	P99IpkUPSfkHaPW6biSbRk3Gj7ufYZMAn8MZOjO36D8UnCvWf68CDV1Xsa5GZPhu6lHw8vDgvkz
	tiyoGHJe3//JpC6ZRDsLBlRSTyfLyvcMkfERb3xkbB1FHY0B5jto92arruu/fqV94wlTgVNCMNg
	9qAg1xnWss8e2cTM/GUhMa+l/plX36xrIEuhXvwPJ2sqS2NH6xfWebvCa58y3wTDKm6P9630lVJ
	QCpp+pFQRznUZg7weFSOWwDYZmF6vAkdndFnbxJyqH7AYoBjvJTch3K17+1FiBAL1oreK3QAJDD
	oSJ3OfyRO/GQtBxQCy1uXNCIdti5V79MKosTI0nwdLLbpAo6hxF12ekqD0R5qC8FRLo9KMcOEVm
	WrlHq6xM9VtyHM/bnwUdg3/VBJE4QQNKd4zeWJJd57CTlsXDTWYzus+iHubSkSh2wWGi/8bqfjK
	X0ib5BWs7L+Ia4vtlW1avTyVNe3obF0ppYfc0fVAHMYlpTm1SxTn5TJE7cqRVOBYjNAg1izRyzU
	qoqWMsqZkcEuic4vHyVy9LNDHYgE=
X-Received: by 2002:a17:90b:2f04:b0:3ac:b3ff:b476 with SMTP id 98e67ed59e1d1-3b166d05371mr498415a91.38.1794248467994;
        Mon, 09 Nov 2026 10:21:07 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:21:07 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 7/9] selftests/bpf: libarena: Refill local caches in batches
Date: Mon,  9 Nov 2026 18:20:52 +0000
Message-ID: <20261109182055.7581-8-emil@etsalapatis.com>
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

Cache misses and full-cache frees take the buddy lock for each object.
Batch cache refills and spills to amortize locking and metadata work.
Refill without growing the allocator, falling back to individual
allocation when a batch is unavailable.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  6 ++-
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 54 +++++++++++++++++--
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 7553ad5a879d..a4d96909f5b0 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -81,10 +81,14 @@ enum buddy_cache_consts {
 	 */
 	BUDDY_CACHE_MAX_CPUS = 8192,
 
+	/* Objects moved to and from the buddy allocator at once, as an order. */
+	BUDDY_CACHE_BATCH_ORDER = 3,
+	BUDDY_CACHE_BATCH_SIZE = 1 << BUDDY_CACHE_BATCH_ORDER,
+
 	/*
 	 * Objects retained locally for each allocation order.
 	 */
-	BUDDY_CACHE_CAPACITY = 16,
+	BUDDY_CACHE_CAPACITY = BUDDY_CACHE_BATCH_SIZE * 2,
 };
 
 struct buddy_cache_order {
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 4d4d21356935..a23da811e484 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -128,10 +128,28 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
 	return 0;
 }
 
-void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
+/*
+ * Refill an empty cache with one trip to the buddy allocator. Kept out of line
+ * so that cache hits do not pay for the refill path.
+ */
+static __noinline void __arena *
+buddy_cache_refill(struct buddy __arena *buddy, struct buddy_cache __arena *cache,
+		   size_t size, int order)
+{
+	struct buddy_cache_order __arena *slots = &cache->orders[order];
+
+	if (buddy_alloc_bulk_nogrow(buddy, size, BUDDY_CACHE_BATCH_ORDER,
+				    (void __arena * __arena *)slots->objects))
+		return NULL;
+
+	WRITE_ONCE(slots->elems, BUDDY_CACHE_BATCH_SIZE - 1);
+	return slots->objects[BUDDY_CACHE_BATCH_SIZE - 1];
+}
+
+void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t size, size_t order)
 {
 	struct buddy_cache __arena *cache;
-	void __arena *address = NULL;
+	void __arena *address;
 
 	if (!buddy_order_cached(order))
 		return NULL;
@@ -140,7 +158,11 @@ void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
 	if (!cache)
 		return NULL;
 
+	/* NMIs cannot take the buddy lock, so they only use what is already cached. */
 	address = buddy_cache_pop(cache, order);
+	if (!address && !bpf_in_nmi())
+		address = buddy_cache_refill(buddy, cache, size, order);
+
 	buddy_cache_exit(cache);
 
 	return address;
@@ -171,6 +193,30 @@ static int buddy_cache_get_order(void __arena *addr)
 	return idx_get_order(chunk, idx);
 }
 
+/*
+ * Make room in a full cache by freeing its top batch to the buddy allocator,
+ * then cache the freed object. Kept out of line so that frees that fit in the
+ * cache do not pay for it.
+ */
+static __noinline int
+buddy_cache_spill(struct buddy __arena *buddy, struct buddy_cache __arena *cache,
+		  int order, void __arena *addr)
+{
+	struct buddy_cache_order __arena *slots = &cache->orders[order];
+	u32 elems;
+	int ret;
+
+	elems = READ_ONCE(slots->elems) - BUDDY_CACHE_BATCH_SIZE;
+	ret = buddy_free_bulk(buddy, (void __arena * __arena *)&slots->objects[elems],
+			      BUDDY_CACHE_BATCH_SIZE);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(slots->elems, elems);
+
+	return buddy_cache_push(cache, order, addr);
+}
+
 __always_inline int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 {
 	struct buddy_cache __arena *cache;
@@ -190,6 +236,8 @@ __always_inline int buddy_cache_free(struct buddy __arena *buddy, void __arena *
 		return -EAGAIN;
 
 	ret = buddy_cache_push(cache, order, addr);
+	if (ret)
+		ret = buddy_cache_spill(buddy, cache, order, addr);
 	buddy_cache_exit(cache);
 
 	return ret;
@@ -1033,7 +1081,7 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 		return NULL;
 
 	order = size_to_order(size);
-	address = buddy_cache_alloc(buddy, order);
+	address = buddy_cache_alloc(buddy, size, order);
 	if (address)
 		return address;
 
-- 
2.52.0

