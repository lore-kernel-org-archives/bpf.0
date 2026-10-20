Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520350;
	b=IyAN7GZRgTAFGwTfmmKbxwimeNtNREYeiPGAv/QZj4LTgI1N1995121M3G0LGs7CQJsH
	 YdEVKdJN2MFbjxFDnDUwz/tPDNOJNYtRya03gWip44dM2QjtBbSZ3ARsDHxBkT1gC1scd
	 ak4FUYqGKVWp0VDk/eDP8iACBffkbiEeG3lP1aixlfFsizeHwKSiVFoVonwwCQ79FfTCj
	 cBXPUAk2DZHIwZMbIwLZ994y4mrjc00Uk120CWctOV99cx1LskXsZPMZBayheoIREulpO
	 GSFlz365EVrX6Qf9CCIjV6M/kpgALjX7U+Chs9RCr2JGrouewaKCmyDygTsE0KBfW9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V1R7E+zB58QEuKokdWAviGN5o3cwAlSemNA8DqtQIz4=;
	b=Ny66907pM5prw+btoP+G3HG3YH/8vCWaXj+2RHv0X+bfenLrSLBR16TgVc03+GNl42UG
	 KbOBRudolx7k6+5KZPq5Kz1/woURZrI5np/ktobtYRqA4MMCO78S2EEkhc9cly/pO6dS1
	 dU8lIjcoyVTW91Wafhg4aRhEMbbdS/1nx319M56PuQz5GBJh6IbWqkrAqZYhCHL/LKFSK
	 zn6nKzSpTS5OQTYhjWvGZ7UhQS0q3+QjbN0iRatXfsYFrVdQmDuB7uWOHKJhKRUWSzOwF
	 y9r9dt98UtnU8H9EWrhjn+NSaVkwKgjnIygKkX3SQbvGo8R/gczG2qYt0iVZUfEsXHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XvQfUeXB;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC860A260D
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BAC860A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=XvQfUeXB
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398b3c37877so2047215a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792520349; x=1793125149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V1R7E+zB58QEuKokdWAviGN5o3cwAlSemNA8DqtQIz4=;
        b=XvQfUeXB3xIeiLHDYqEtgPvFZGCmPedqXDJkinXxilB3B2osnJ4/XJiLzWyStviS5/
         yWmb+5GNvcZe6hk0SfgrSOay0cbcJVtzHM/G/NIPaDPV1XTcODt010h/XvcAdFVk80As
         5+51z3Xt0KveUEhtl2Vkksg6xR7pT8wzLTyzN0MgpwJcQ+mGCpsGgWg8gvRp1T9impKf
         VGDk3/NijpRG6zoFQw0AZR20M2AyrKHphQtVdFWkDaCje6fdtLVIkqxhH+wpl9hz9XLF
         IxfaForUtgpayyv5HU6nzN5VU2SDSI4MTwuBaLw910Kn0zbDJd63VC9b/icAMMqAywEa
         lodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520349; x=1793125149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V1R7E+zB58QEuKokdWAviGN5o3cwAlSemNA8DqtQIz4=;
        b=j83aftN8ZY03jOyhgxNICrdK+sWUmkE/6zoU9q/qsxwTbIZjGKxdqbnl2++ybRpNju
         dsgTFC3x/TQ7KHMBMVUcmStzmbwrWx23enP+vNDH/SlzIW2ZDoLiu3AtoYW3ZJqM7G1M
         tsypzgF27do3LdAQ9l3WKwyjCxL2QhElxi5qwIyiGtrGPFHTsZgFcHEO6KCVCg2ynGOT
         scmQda0Zs6IWhPVgiZWcoOPp6QAYjWLhSmRgM4Ks/z407xb0tKF2xgFYBjBEIYAOZTUS
         FEFAeiW0s51gcrfp5groiEwWX9nqNtl4JjsRXqMmxuIdXHsIpsZrDRhwfam24NLIX0/t
         sGvg==
X-Gm-Message-State: AFq9FYJLen4UxQRqz4vX0wdfLAoV3QW7qB/OvWQysVWhuO8tsFDInQEW
	fGthDp//Y2M/F2M6aeLEouWYdKPazybGcAQT2jinPesxkwuVcI7Y+cw30qeD3OYf+bnW44OdT1k
	eZMXiQ8s=
X-Gm-Gg: AYBFou2PKtCcky+XofxJ9KivvF0NMk3P55Ve1r878t65Pw2VyjdaojCtwt6gbPQy+ik
	OX82Q4e+GSOqXtYgI41Xd/SwAYJyt+C2bjcHiJe889wkuWlQ8VNhbRuzcC/zMdRfu6/mfHhpCDL
	LUbSlRZN3reppXdTV1BRXQsi7sj/5gkpWk169uLUnuIIjuWqSM9UZMFhHpeJVLzPMz5i3Me6PCb
	yAbcQ6uwZdaGQKcolsyf+o3AyTML+3KpbEoRAEtRNP1uXYDA10iOEAxEI6T7NMPhIW/1bVah1cL
	AXJshHr8paVWhvBGVwgASoStJJNe3Oci8I75+YL3Cfz143+LXViCbL+GddBAiCaJ0IaNe1XVrVC
	zeeM2AHL1y3EbC7XfRw/O1KpRXcGQxqd4eR8P9TW6zaV8EjkVcHT7BYahAhJWGWCRjO8TnxSrGD
	jfj6FMysaz836YoMQUfzArSyxTu2tuBpU4sLUMfCia8h2sbWPnhNytKWQT5OCxX0ElolVovSEBj
	0/fh9jqr7IBBYYBlxPZz9tZHm0D8pTi1P/4Ptdse5kmhfSahgSbJi3kbkSa6DScuJSbThsMPYxD
	Z867fcLizEg68ME8jQ==
X-Received: by 2002:a17:90b:4d0d:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3acef4fe49fmr10124060a91.46.1792520348747;
        Tue, 20 Oct 2026 11:19:08 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm710661a91.2.2026.10.20.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:08 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 5/7] selftests/bpf: libarena: Refill local caches in batches
Date: Tue, 20 Oct 2026 18:18:58 +0000
Message-ID: <20261020181900.6755-6-emil@etsalapatis.com>
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

Cache hits avoid the central lock, but every cache miss still asks the
buddy allocator for one object. A sequence of misses therefore repeats
the same locking and metadata work.

Allocate eight objects with buddy_alloc_bulk() on a local-cache miss.
Return one object directly and retain the other seven in the per-CPU LIFO
array. This amortizes buddy locking and metadata updates over subsequent
allocations. Skip the refill in NMI context, where the backend allocator
cannot safely take its lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 85d670b8762b..3b760b1fc66e 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -185,6 +185,43 @@ int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 	return ret;
 }
 
+static void __arena *buddy_cache_refill(struct buddy __arena *buddy,
+					size_t size, int order)
+{
+	struct buddy_cache_state __arena *state = &buddy->cache_state;
+	struct buddy_cache_order __arena *slots;
+	struct buddy_cache_ctx ctx;
+	void __arena *address = NULL;
+	int ret;
+
+	DISABLE_CACHE_IF_ASAN(NULL);
+
+	if (order >= BUDDY_CACHE_NUM_ORDERS)
+		return NULL;
+
+	if (buddy_cache_enter(state, &ctx))
+		return NULL;
+
+	/* A free may have populated the cache between the miss and refill. */
+	address = buddy_cache_pop(ctx.cache, order);
+	if (address)
+		goto done;
+
+	slots = &ctx.cache->orders[order];
+	ret = buddy_alloc_bulk(buddy, size, arena_fls(BUDDY_CACHE_BATCH_SIZE) - 1,
+				(void __arena * __arena *)slots->objects);
+	if (ret)
+		goto done;
+
+	address = slots->objects[BUDDY_CACHE_BATCH_SIZE - 1];
+	WRITE_ONCE(slots->elems, BUDDY_CACHE_BATCH_SIZE - 1);
+
+done:
+	buddy_cache_exit(&ctx);
+
+	return address;
+}
+
 enum {
 	BUDDY_POISONED = (s8)0xef,
 
@@ -1052,6 +1089,13 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 	if (address)
 		return address;
 
+	if (bpf_in_nmi())
+		return NULL;
+
+	address = buddy_cache_refill(buddy, size, order);
+	if (address)
+		return address;
+
 	return buddy_alloc_memory(buddy, size, order, 0);
 }
 
-- 
2.52.0

