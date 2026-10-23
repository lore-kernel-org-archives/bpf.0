Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714869;
	b=It9nbULTm3S/UzH4BcLNZnkOciqWXdOOQA82y6mEf05YdU1EH2qkj1g/ZLogEhyMBugm
	 7zz+pRo7lJqdvDRkKUfuxJN8opLMFXr8QZ6bJTtRmDoQsRaL72Zq+DEH2PPHbCChIThZv
	 /1Y91BMNi8wZzrKlgSlAYwReXUD35azva4KZvUsiwrcMWHLXpSj4IHzRjs7vBKjqnrwrx
	 VIz/kfbQ9E4qo4Z0wRzDSamYd4Ym8iE6bzudFMUPdEXu6x7meRkxCbapnhGR92i7I0pZh
	 hRR0xtMlaI+k9RA00lXAn9p7i28bZ5Ypa3LID7uGbxHTNEs90X0EwyXDVWHPhP02hoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PbCc6M4TCb4iYawA08U4X+xoX8sB4YsQ3KuZrQ0ktGQ=;
	b=nQ/bJ3tULrlcPVmCyWnNLA2rWLHkPsA/rrd1y+BROeqcb5H+Nn4xYDQYcJBceoCFHv83
	 N0B3YPAXn4TTgnZQOfIdilSGuF1SV0rskdYgFHFyxBeajIJcS/v75OSPtGYfFbgmv1egQ
	 N3cnAcQbac1YoIlBUbYPqj9bwGKyBEelX7hYAp6RzM5/4H8lasp177EcUs26aLLurS0mr
	 6tkiD57JURS/QPkN2fnd0IhDpmv/27gVJoBKmTumV0+7YwCaXnlxuxLNmHa+TJPsHANf0
	 v9R422fopMZIWVvqcsY930yNpscoZY1zCK5tzjt/aPRxd39KRazwChdnbepzraSWPhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=CdmqQfY6;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7047606A319
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7047606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=CdmqQfY6
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a089dfee18so824075b3a.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792714868; x=1793319668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbCc6M4TCb4iYawA08U4X+xoX8sB4YsQ3KuZrQ0ktGQ=;
        b=CdmqQfY6Xdg4h4j1ftNj/B5CVGnGfWtFOM85KfU8HkehZeBxB5c6v31/7CvzTq6lnJ
         gYxF26uzevzjHUjbhBTQM9QqVOamS7eZznV4fxAmBAa6sYewea2YLTFVTPbaxa9S/ytu
         BJ7EmHMSZE8SuWLfX+wINqnfzOgeBe//HrOjll4UgBH+16iHl4fewBqK4EXLGvscXbIO
         7P32xcFGr6BOQt4fBXQdDj97vACDbssfrMwBfjgygFOQAKgh9/Zz+lsoSRzkX+UQx5uo
         cONLVqVN2G1Oyp0E8SLe4LaT2rg2kUkBqd2m8HlsWcjL1WC+2NME3L66fuYkU8d9VQRo
         4WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714868; x=1793319668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PbCc6M4TCb4iYawA08U4X+xoX8sB4YsQ3KuZrQ0ktGQ=;
        b=tAM5MmaDx34MWWPpzDzckcll05JrDU5C3LnbaghCM1xTEGwkr68xipWvRQqrRKxDMX
         Eq7DmuwFV0A6IQ+EeQz2bFvkQ37I+OwMMbu0NmziUxA6xfxpeTegDq26ruRbwsyRFNDc
         YtdKbYI+VIk5p1RVy+a3DORZIRUGvdUlBo7aRMw/gfxPsjozue1tZkI4/0A76eE8i5Hg
         igddd0MvRMDLG1VV1rLuafpPInZTdqd2e4NyVv6L71BUNyulaCn6qUuaSfMsCn7c4GPb
         h0uyjwtIx4b2ttsm6IOMQDTAR+WEd/SAP1VD9sgLzpCG99AiYtGcK6L5MVc3H2jxT0AH
         taEA==
X-Gm-Message-State: AFq9FYJzvr5P4Opf3jEKq3edny9GXmyElA+lgyeZesQ1WQfkJLmDD+xg
	hSNPgfIjeC8z4kUkEysFg14czfcAuYZqMW3LeiEeTunhcENV2YGva9hV20Fdc+SVokp6y9AurL2
	jhxJpIN1tNg==
X-Gm-Gg: AYBFou1rtu+lHbS4P6fIi6+m5ULFEQlaEZHp1PWA5xi3ZTrFp5EYR43tU97KDht31Eg
	Osjn3wPiEiHyVjESlO1C2B8Ams/kUyyw+B+IL9H501qGDztqbMKH5PZyqscG/4KnHlZcAvRblor
	CvvXxwpRV4phIbd+M7gQx/MxTkJQmeXmkr5iI0Y1YGdng3yLcL8zRL2eV46ytzOibYbR8BGSetx
	nlsbjbqvc5cixkQhGKHvXVBX1QajKRukdw+lzTMOkB8VlszogheRTxaTilda59N1SFAflZvB8Mf
	Jh6hRKAOHpLDYpApCKM+t2JF6dj+wEgC1mvEsEO2VMP6wcQnWxEMlb8VEqmJbh2dKvLqb/hY5RZ
	/bQGy7dbzw00tSa6PwqzJPT0qCdd0HoUh8dAutxaLhCzfgN4L8wZNXN9GuLaZ69q07STuPbsS2h
	ojDLOFUa06q4dkdkMuJWkpuVxP7/dT8nfJr+FQF6yL4BxN1tu22YgxGCoLJrcX3EC208r4MVoS8
	x23Y59K+Ms9M0ZC1aJjOTdOvnGY9JDOzJndVy9+2ngMcRe6cX3eItd1WHazkbPYQ649BoaTl07g
	uwwRbvn2m54xK/G8dyVqzUYIARMnTplwLyGIegI=
X-Received: by 2002:a05:6a20:a107:b0:3e2:81f5:a864 with SMTP id adf61e73a8af0-3e2a0bde28cmr2664538637.41.1792714868199;
        Thu, 22 Oct 2026 17:21:08 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8892c4sm218649a12.11.2026.10.22.17.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:21:07 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 5/7] selftests/bpf: libarena: Refill local caches in batches
Date: Fri, 23 Oct 2026 00:20:54 +0000
Message-ID: <20261023002056.6647-6-emil@etsalapatis.com>
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

Cache hits avoid the central lock, but every cache miss still asks the
buddy allocator for one object. A sequence of misses therefore repeats
the same locking and metadata work.

Allocate eight objects with buddy_alloc_bulk() on a local-cache miss.
Return one object directly and retain the other seven in the per-CPU LIFO
array. This amortizes buddy locking and metadata updates over subsequent
allocations. Skip the refill in NMI context, where the backend allocator
cannot safely take its lock.

Express the array capacity as twice the batch size, so that a refilled
array can still absorb a full batch of frees before it overflows.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  6 +++-
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 28 +++++++++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index de8d29ea4673..0c984952042a 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -81,10 +81,14 @@ enum buddy_cache_consts {
 	 */
 	BUDDY_CACHE_MAX_CPUS = 1024,
 
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
index 6f98044518ed..837d5cf70185 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -131,10 +131,28 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
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
+	if (buddy_alloc_bulk(buddy, size, BUDDY_CACHE_BATCH_ORDER,
+			     (void __arena * __arena *)slots->objects))
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
@@ -143,7 +161,11 @@ void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
 	if (!cache)
 		return NULL;
 
+	/* NMIs cannot take the buddy lock, so they only use what is already cached. */
 	address = buddy_cache_pop(cache, order);
+	if (!address && !bpf_in_nmi())
+		address = buddy_cache_refill(buddy, cache, size, order);
+
 	buddy_cache_exit(cache);
 
 	return address;
@@ -1060,7 +1082,7 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 		return NULL;
 
 	order = size_to_order(size);
-	address = buddy_cache_alloc(buddy, order);
+	address = buddy_cache_alloc(buddy, size, order);
 	if (address)
 		return address;
 
-- 
2.52.0

