Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625235;
	b=k9Kd3i3bbk40x02/y4bdJwgYB34TQnf000Zte2pgCMWs5By15XngXC5QsxGl3k1xEbb0
	 Pt+E0wL0owWiL+pYYPQyZK7Wy3q9A8PGWMBCV5huFqYlZgBWtmUZtndVekOW+SKeVlgsJ
	 HGI7yHDkJ1Gjufwet2DD5jw1NqCdsZksD7iMO4iUJNUAmknNlVHdLAO3QY7OcvF77QuyI
	 8bjrfxKbxRwfx6cCP9BiMBIpuDXjYQQoO+EWOX4nrZdzdgmV7td+RfynM5XokswrE8lNf
	 JurKdVXMlT0OxaR92Y3ktD3w3+bsLjfA+6my6MzkpHyqqxqWq4BPoSwOrqBgpH/LFTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+0DyuQmTMksJf/uGVTik+kn5Dcj40nlTItgkR/m+Aso=;
	b=HFFOat/Ep8QTpo0tsMjA5zGc2oyckh7bv6w/UEUwQpnkZRdbvTLt1kabtgARe+5w6IEf
	 OQehvxcsGNC4ym0xZc7TsF0R/aoa+X6J1gzteQ2sPfSELFi9wfqDRf051febJEuOKQbHI
	 aczqOCN9oUsQENAN60SwS0oBp5oYz3X2wisSrFMb4pG33g60TV/qLE9i8/LajAm9F7eJO
	 0JbGsLCBBTRwSTa9sOrCPbby+7yo70O5Cv6K/DGk8Lvx0aALI1xzeFHjyCAA7uznE71Ci
	 k+umyW+cAEeYbtoR1h0IApucEMI5N7f59uJ1ZzsAj0PdEpznvX1OfWetb9I3zwF975g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=c4eHrV1F;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68872606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68872606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=c4eHrV1F
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso6921945ad.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792625235; x=1793230035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0DyuQmTMksJf/uGVTik+kn5Dcj40nlTItgkR/m+Aso=;
        b=c4eHrV1Fn62L+P1MHbdUq9X9QWdNRRhGbZe9nrvNLPwAxdFXB5my1GEEe+bGKwqbPf
         e3GaUtLGbs9SIBvJNzzRJZ/UpjkCUtdmI7k2cYX3IyluTPRlaUyvCUoNzQ21w5mtCYUY
         bnU6F9oFrGekWHPjwVxY1fwUH2nRhIt32XAalxu6J38lKIEmD5VQYJ8yg2nZ8ouNBRx4
         LeYbBHMB0/vs4W8E5BlzXo0ihuK5KEiy+0phU/j1TOYHpDMJ8QKUDdn3/Ju2DYG7pJkq
         ecChGeGXVMQR+Wch64C1OT9ad17e0Elpk3W/ZfCas8fruLpDBkLulJ7ndr/QNCR7vAVp
         jnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625235; x=1793230035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0DyuQmTMksJf/uGVTik+kn5Dcj40nlTItgkR/m+Aso=;
        b=jBs4s3agTYNtHjC3NXAI+a8pCy9ZumcIQlMuRkB1ZY0MIMcrzx48DcPPZvqLx6GV+Y
         KFRA3ptyGotOszIkiZ+1paU7HyULFJdDwB8NylwV8ZBxCTAX+hwxC9YZ76IwcKZGZhND
         4Qvo349PcKUNAYJxH2m8/3ksOOk2tQhoSN4AgEGOlXGINfMuAI9LjTga/MnA5+Gc53OW
         Ax4iiT+8xlGdmcIXPD5HacujMHcEaHIdUxANHlyuKaAn3ekEEvFGRQLK2J0FpNb98iqz
         NlBBmXN3BTNczqUTQk7vQwTxkHD4g5Ge5fJbInieNsLsmi9lXr1/uxU8k1eSKMLu7ffe
         aUwg==
X-Gm-Message-State: AFq9FYJ1ygpm1LcomsXOiB+lOKQk/LBgypcZCwehF45AXRvQnvHXz6Y8
	M6yCpQSVCzxCLhuHGreyNV5izwU0AweugLfHfz7c6mvTPSyX5LA8rmo/KOzUerf14BjHOaJiONN
	G0xK9AQRgJg==
X-Gm-Gg: AYBFou1MkNsYgQhXdeHcjzDAIURR546qRUK0xvu1VALfOMuc6WBPU07U/ld4UFAKG9x
	RCq0tnJYeVMIa7p026s86NiIYudx55fMGj8TyjIVnIkIWzkS+3ACjfBl0+MXes9mdMlF0UPtH5i
	VhC1vGF/qGnTGz3l3x6KvfMMFgnsmft9SCnjGmm66INjNycbSXssPHIkoX6c+ZfFd3Hl8Gmdzql
	Vyb3C60eXNyTNJtHzBlF4USLRjBt8n5m7oICmMt5kYAiPDXhHvPJyYqupbmv4XsmiLm20EsJHLO
	UhZfJHRg22I3WskLKYGPkZ9+tYb8YaO1pitv1YgmquLJ68Sp3fftTo0QWWPSes6ubVwf8EzSXCx
	B2IiLA+sTIeAwdXC+NNyS6yh/wzY6MqiCxkcq8yHbYM4jnLd9b3lHYUH+bQ++yfXWLnoeNJAOBU
	2/0tO9ipre2j1SwhA2wNLGbMX0COngaNkwTg8G3Q6G1hsC5t2+jJutl2XWfKyOM6N+Np+WtVUR6
	2dPzFX44kJq2fbJask/rww/pLNb2QGlu0uuze5P+RGp
X-Received: by 2002:a17:902:d492:b0:2e2:d39f:182f with SMTP id d9443c01a7336-2ea43e2568amr28956865ad.28.1792625234824;
        Wed, 21 Oct 2026 16:27:14 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:725c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada70sm15651425ad.72.2026.10.21.16.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:27:13 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 5/7] selftests/bpf: libarena: Refill local caches in batches
Date: Wed, 21 Oct 2026 23:26:39 +0000
Message-ID: <20261021232641.10063-6-emil@etsalapatis.com>
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
index e19104ad7422..d7c3defeb0a8 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -126,10 +126,28 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
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
@@ -138,7 +156,11 @@ void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
 	if (!cache)
 		return NULL;
 
+	/* NMIs cannot take the buddy lock, so they only use what is already cached. */
 	address = buddy_cache_pop(cache, order);
+	if (!address && !bpf_in_nmi())
+		address = buddy_cache_refill(buddy, cache, size, order);
+
 	buddy_cache_exit(cache);
 
 	return address;
@@ -1055,7 +1077,7 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 		return NULL;
 
 	order = size_to_order(size);
-	address = buddy_cache_alloc(buddy, order);
+	address = buddy_cache_alloc(buddy, size, order);
 	if (address)
 		return address;
 
-- 
2.52.0

