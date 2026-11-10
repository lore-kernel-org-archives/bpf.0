Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271131;
	b=kBBVfGvaRAnb4WmKgZhRRzbmVnkpc4f/8QPWiyBpJjFS+4A6VAnsD70sEcU5dGBx1oue
	 4BC5Yr6ak7w8gQkLjanhucX6Nhx2z78bo6fGcbcSoHiWOeUp7aXEB+q0Qh+hHYUtRW/jJ
	 3Nw2IDywQopK5TOSGu4lbhX71Av2xUEQxXpvG3mFBzKB7faioLYmvCDI9McTX7lznqEJJ
	 E4Df7FefqIv2IVergSd+RhJcFiVdYbbWdnZOWr4N/TvItTp4ul63pMyzTVRKPvdDAeRJG
	 Lk9cgVIJ8KlcoDcWNg/rvUwymdyeTstmi6itVQF4NyhiuUvHWNcckQ9Sl8GKy51shVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MNb/RqwNMzKoZvIb4PFp6Hn+AO9qQQmA2cQfazPNBPk=;
	b=0pbR2bTKkbG5lChBr8PF7eZPQxRhxJiInfH1R0yOJbB+8n0HluTmBNx6goViuYNN6fo2
	 cThb6NwZNDO/ZJpyDlveIPN21X/6kDzrjstkttpruitahwaaTWL/g8hcAzIl+Re1GLSZJ
	 40YVt+7awq6+c12rtf1f3S6JBvrp8+09+4YK4ZyztmR3pHe7WD0aL8f0PH6kl2OFo+mKI
	 7qWh4/JHx3xlmK+G04t7GxBtnHwSLo4MLO5gss7HqPIE5JYuUvOkUMikUS7vBs0ygMigj
	 TqLLZGUEcfFt/AMMIwKmUT3REgFfUuPgucEt6C2PUvRrG7VvOsOFxuU/1tdYMEyRHmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=ICGCVYft;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D9606A33C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B69D9606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=ICGCVYft
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b16896b8ceso216839a91.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271130; x=1794875930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNb/RqwNMzKoZvIb4PFp6Hn+AO9qQQmA2cQfazPNBPk=;
        b=ICGCVYftLGbwNiXPgr3Ks9vE1KkTvcWGCobPtC1pO3cXO9Dn9FD5jN1qhv8UP47l4d
         tA96Uqld9yrC0xInzPx2lEl+mUkPQhrPqX/6CJAsQPlbb3UrIgfKnnstKK2juPYPMCWq
         Ir64OzV//4USnZ40WWX0jiuTtRJ/rhYYNjYmsxDNPWYm0uwQ1k933A2AJvjdbaAoNWyS
         qk6erzfltTgbyOeLIwOZkLnydHwApsfvnT/V89VKfrHr30oPanLpO2KMzF2pwcM/uCqY
         oDrvvD3AR4XJy3wZ2n1e9/9yrLfWQQrYEcybCmorKUv8eFXmYQr93W+cnrYd0J6CtJRN
         d6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271130; x=1794875930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MNb/RqwNMzKoZvIb4PFp6Hn+AO9qQQmA2cQfazPNBPk=;
        b=sXlE2gCPTwYS2GarnrTNLwHPYt83LEU9k/pcCOnrL4wjZ7kL4hLlETf3ZSB0Als9Yf
         q1H5WLZQT9hO4dWGAJYl5e8iq65PHOrLyGh3WNDIDAM5qUVwlM8bqnmE5LKdV92kBYCJ
         EO0AXx3QasVQh81GYn7AMkTqVDH5SLl2yQzyVpZqUlWLeB846lCM613v8SCAf1grMWX0
         r0Yh945tCRMx0jUqckFbHIxgI5oZE9ARgvaBF0P+35TZ8Iw8Kl1PaAk1/fgcYlyDDrHb
         l17dKPq17ayLC9tgirU+aCb74/SlUWKmcntzwEbADFt/5vpySQc2xDUfpSb977wdTXob
         FzBA==
X-Gm-Message-State: APuU4Z8O5T8lKPlWOZuBnDpMxdh7tTIlKgswenn457abhJgm0mItx9HQ
	RNzPaa8Jsu0uLb0YnwLikluHZLHBqs5YIaSy81Z70ra92hVBoACFBmbH31JkFj2SbByWM9VXPNL
	sTLssSr0=
X-Gm-Gg: AYBFou163i6SjRksMExvRcvFucal+SdGGYko9MztYm7fiNxxaw+D4hJcLvfPFBZdCzm
	hJRoR9UFgaQNVdNdkgegbWw5bmG5lSpYQCyvkKyJSNvqfvIpx5zaUMU6RV4Vr0Hz+1E1e5wprCi
	Lf9+MT2Ogt61gADD1Q03SKWkFjEd6O53o52QI/fBMqPpn/nLhPIEuLo1I3IIceKWm2x59nnz2xN
	GKnDXgP4tNI36kpW3DL+IvW0BpUo8Rf4DfwUspdZBBIjSIrDJn9nQUvFIpvg1Y6mRrSkW/ngCtB
	i89b511JT4HmCI2BC88R5W0ZHLHZf8UTVOgCw9y8pe+TM3eurcTaU2o3OU7znFVox5789S0aPS8
	dGtf0hFA/Bd15DHaI882HTCyrwT8BfYBf4DcNpEkFUHdM3ZyFHJSclxxZjStJeRWQ56bzvkP+4y
	LZpSKnWiAdhs3dMEE+11A95AfN5Bv3I8iMF85GHZ3J9u7tdeLtfpteGwx4X+isZ0qkASvnlOoUk
	keMe5nH0g7kjkP6KaBr2h6IwIVZmfj7pbZOWTLCKODsqVdXpfitU3MpJoaSusQls+y24cBSX5JA
	GDGGNKEO3C2nJtFKSbdzfLskVNDFJlZnLssKTUQ0N70niwJ43es9Wuf6BwvPjuLhjzRPR2/qjie
	2NO+FyGNjUTi7RH0wp7w6e16nIsQ=
X-Received: by 2002:a17:90b:540b:b0:3ab:7031:d962 with SMTP id 98e67ed59e1d1-3b166d03c73mr1291905a91.41.1794271130046;
        Mon, 09 Nov 2026 16:38:50 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:49 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 7/9] selftests/bpf: libarena: Refill local caches in batches
Date: Tue, 10 Nov 2026 00:38:36 +0000
Message-ID: <20261110003838.8739-8-emil@etsalapatis.com>
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

Cache misses and full-cache frees take the buddy lock for each object.
Batch cache refills and spills to amortize locking and metadata work.
Refill without growing the allocator, falling back to individual
allocation when a batch is unavailable.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  6 +-
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 56 +++++++++++++++++--
 2 files changed, 57 insertions(+), 5 deletions(-)

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
index 7fd74f4c5052..23be400f0eaa 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -128,10 +128,28 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
 	return 0;
 }
 
-static void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
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
+static void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t size, size_t order)
 {
 	struct buddy_cache __arena *cache;
-	void __arena *address = NULL;
+	void __arena *address;
 
 	if (!buddy_order_cached(order))
 		return NULL;
@@ -140,7 +158,11 @@ static void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order
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
 static __always_inline int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 {
 	struct buddy_cache __arena *cache;
@@ -190,6 +236,8 @@ static __always_inline int buddy_cache_free(struct buddy __arena *buddy, void __
 		return -EAGAIN;
 
 	ret = buddy_cache_push(cache, order, addr);
+	if (ret)
+		ret = buddy_cache_spill(buddy, cache, order, addr);
 	buddy_cache_exit(cache);
 
 	return ret;
@@ -1030,7 +1078,7 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 		return NULL;
 
 	order = size_to_order(size);
-	address = buddy_cache_alloc(buddy, order);
+	address = buddy_cache_alloc(buddy, size, order);
 	if (address)
 		return address;
 
@@ -1047,7 +1095,7 @@ void __arena *buddy_alloc_nogrow(struct buddy __arena *buddy, size_t size)
 		return NULL;
 
 	order = size_to_order(size);
-	address = buddy_cache_alloc(buddy, order);
+	address = buddy_cache_alloc(buddy, size, order);
 	if (address)
 		return address;
 
-- 
2.52.0

