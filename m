Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72793BA241
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866113; cv=none; b=gstmEAM8SkCEJNpUGonPuzirD8tiMi/lOAQl0157bCzCqFJCvxVLSVZ7B3ZlMq+0zn/rO/4h+r5iyyxdzL9z+ZkT/5yQjUTOka5mvJ/SErwESGo7pN3we+QSrZYFOPCNKncKbJa11ER1cXy97U4sAXvBsrAt53/1Y0Y7y4p9nE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866113; c=relaxed/simple;
	bh=02PyrSF/qRGiriBbuBj5uvd/rwGyLcS+F/VDwSyksPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJetVo1R1hX03NOUI9wMvOOhgB1ok771l3Jm1yIovJRFvuPuq+ZjeT+Un9k0A8yFcChtwY5U0n35zq1raYnSQZw8hu+0YCto+tYjdAVdKn4gMIm2M/NnEc5N2vkQN4M/oNkvXBASYYKWyVK099kRo1DmraDHZrNS1EdLv5OpjQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=vNCWf48+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="vNCWf48+"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-365d8e43759so5738003a91.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1779866111; x=1780470911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnQwaj7QxIKJNbGjX6oHnpPMZXe3GzGJsbtmsio9QL8=;
        b=vNCWf48+UiftgtBCuwLmGz/4HtgN6M5bU8Z+0gjphEw2nJ/cKggN3J16/FbuvYXx3w
         st3yXmapiaFkycX+BNnHgAZzIPias2A4qITMbKhlEBn+qq4jQv0YqHBuGicuzqEb+6HK
         q22tiau8vHQTUyienXL5sathKLWDvMOPw9TexN+UpnKtxkH5APyMjsPGEk6SaQnlhiq2
         t8KBady12bOoSWG4zy5tY+nZLmpXkmoQhYR3ag1Rx2bVxS6FBrHhbYZKUhgv8G5R84ze
         ScJK6/ToqmrdrHj+E5OnBomGD48wcg8UD1a1U+aGvsr0ZJhuhWhSSBt85ef8v/f+k/hi
         X7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866111; x=1780470911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnQwaj7QxIKJNbGjX6oHnpPMZXe3GzGJsbtmsio9QL8=;
        b=R35IsrjZqZkshAKGgJq6toqkC/My67vAw48tloMXAT9f91HY/Cjlg+pIB1nRF/muFW
         vlx7acA7/KOAv97HKIk4PJk4Pl1cX4ZHjFDX3R7flwE2kxza6cfQdYHnGSy+h41DfwWn
         YXa2DrDv46guBt2tCf82yYpbOUSCeiBaHdMPcgL0mT24z9hOo7OpAvmREwguTsaERAFp
         gQy56/s8qY3eoDR68Aqc7japV8L1iZf+tFSvODTdk7DmuzozJ84uCAzGalea2JtR/yN0
         E40HZdswULccJ54+O4mMlTLOhG2VxiVyws+V4OOO/ZzJUIE35nNrObfkKiGoxrObOWsE
         jqxA==
X-Gm-Message-State: AOJu0Yxb3n4hh8tRphsZN0qxqVXL5LtY7c7YgmFQE9ih+HaAUWhOPHrq
	qivlUprEKfkyFo1fSpC1Vv/w3v653nbvXeobAH4bboFH0XftCf8QovrrO5lN9kYZECowR1lyR3T
	lND5m6/TSZg==
X-Gm-Gg: Acq92OELSZ2GQ+UZMcGdTYhotSwiE2cLpGBsCkwKjMMn9gjkPAL+EkHRcMQ7KiAseaf
	TwTsx2whC6PLEygDi7US6OINSU+85uXV1PPhbPJxpNqr7nH1YMlygXxFdjlaIvRzkCC80O32or5
	PwkIY1SaPHU5D1AwDj5Z7hIVYburjABmhF4YWPcScyJnWrlOA8ot87Qi7GFfSUzLulHj8hbbKBv
	TJFu/L9OcEwVMfncMqycxDvjNDdFLbbq3a3RodzKv3eAzvETYFPMpjLgCjsd+Y8qvPkvFdWeEJf
	Fq+lyuuEYbdkHpZdbFQUKqXJa2foZCI1HEIhy+M/G4vxDj6XeKf0eKbxQOGAECf1t3a8vsCoXHs
	NyDVOsaK0nznDKlg4/7mcDzwIwgnPPJ4SKSFK/FX2tKZ5Ko6IRRrkB1ruWfNTLns6pMsjX0OHuW
	4EJvsstYSDGPhd+7ArfWOe+gZYQtZhP3R1cvE=
X-Received: by 2002:a17:902:d50c:b0:2be:9e09:463 with SMTP id d9443c01a7336-2bea23c6713mr235551445ad.23.1779866111103;
        Wed, 27 May 2026 00:15:11 -0700 (PDT)
Received: from krios.lan ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56d68adsm169036365ad.32.2026.05.27.00.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:15:10 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 5/5] selftests/bpf: libarena: Directly return arena pointers
Date: Wed, 27 May 2026 03:14:57 -0400
Message-ID: <20260527071457.4598-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527071457.4598-1-emil@etsalapatis.com>
References: <20260527071457.4598-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that BPF subprogs can return arena programs, remove
the preprocessor typecasts between u64 and the appropriate
arena type for data structure init functions.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  6 ++---
 .../bpf/libarena/include/libarena/common.h    |  3 +--
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 25 ++++++++++---------
 .../selftests/bpf/libarena/src/common.bpf.c   |  6 ++---
 4 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 1c69817f1540..4f2a19e3d0c4 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -83,10 +83,8 @@ typedef struct buddy __arena *buddy_t;
 
 int buddy_init(buddy_t buddy);
 int buddy_destroy(buddy_t buddy);
-int buddy_free_internal(buddy_t buddy, u64 free);
-#define buddy_free(buddy, ptr) buddy_free_internal((buddy), (u64)(ptr))
-u64 buddy_alloc_internal(buddy_t buddy, size_t size);
-#define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((alloc), (size)))
+int buddy_free(buddy_t buddy, void __arena *ptr);
+void __arena *buddy_alloc(buddy_t buddy, size_t size);
 
 
 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index ca1a6c1d6477..a3eb1641ac36 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -48,8 +48,7 @@ extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
 
-u64 arena_malloc_internal(size_t size);
-#define arena_malloc(size) ((void __arena *)arena_malloc_internal((size)))
+void __arena *arena_malloc(size_t size);
 void arena_free(void __arena *ptr);
 
 /*
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 2e565327b748..e73145d6dc63 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -750,25 +750,25 @@ static u64 buddy_alloc_from_new_chunk(buddy_t buddy, buddy_chunk_t chunk, int or
 	return (u64)address;
 }
 __weak
-u64 buddy_alloc_internal(buddy_t buddy, size_t size)
+void __arena *buddy_alloc(buddy_t buddy, size_t size)
 {
 	buddy_chunk_t chunk;
-	u64 address = (u64)NULL;
+	u8 __arena *address = NULL;
 	int order;
 
 	if (!buddy)
-		return (u64)NULL;
+		return NULL;
 
 	order = size_to_order(size);
 	if (order >= BUDDY_CHUNK_NUM_ORDERS || order < 0) {
 		arena_stderr("invalid order %d (sz %lu)\n", order, size);
-		return (u64)NULL;
+		return NULL;
 	}
 
 	if (buddy_lock(buddy))
-		return (u64)NULL;
+		return NULL;
 
-	address = buddy_alloc_from_existing_chunks(buddy, order);
+	address = (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order);
 	buddy_unlock(buddy);
 	if (address)
 		goto done;
@@ -776,12 +776,12 @@ u64 buddy_alloc_internal(buddy_t buddy, size_t size)
 	/* Get a new chunk. */
 	chunk = buddy_chunk_get(buddy);
 	if (chunk)
-		address = buddy_alloc_from_new_chunk(buddy, chunk, order);
+		address = (u8 __arena *)buddy_alloc_from_new_chunk(buddy, chunk, order);
 
 done:
 	/* If we failed to allocate memory, return NULL. */
 	if (!address)
-		return (u64)NULL;
+		return NULL;
 
 	/*
 	 * Unpoison exactly the amount of bytes requested. If the
@@ -789,10 +789,10 @@ u64 buddy_alloc_internal(buddy_t buddy, size_t size)
 	 * unused bytes that were part of the header.
 	 */
 	if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header))
-		asan_poison((u8 __arena *)address + BUDDY_HEADER_OFF,
-			    BUDDY_POISONED, sizeof(struct buddy_header));
+		asan_poison(address + BUDDY_HEADER_OFF, BUDDY_POISONED,
+				sizeof(struct buddy_header));
 
-	asan_unpoison((u8 __arena *)address, size);
+	asan_unpoison(address, size);
 
 	return address;
 }
@@ -878,8 +878,9 @@ static __always_inline int buddy_free_unlocked(buddy_t buddy, u64 addr)
 	return 0;
 }
 
-__weak int buddy_free_internal(buddy_t buddy, u64 addr)
+__weak int buddy_free(buddy_t buddy, void __arena *ptr)
 {
+	u64 addr = (u64)ptr;
 	int ret;
 
 	if (!buddy)
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index 96220c86a533..50be57213dfb 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -38,14 +38,14 @@ __weak int arena_buddy_reset(void)
 	return buddy_init(&buddy);
 }
 
-__weak u64 arena_malloc_internal(size_t size)
+__weak void __arena *arena_malloc(size_t size)
 {
-	return buddy_alloc_internal(&buddy, size);
+	return buddy_alloc(&buddy, size);
 }
 
 __weak void arena_free(void __arena *ptr)
 {
-	buddy_free_internal(&buddy, (u64)ptr);
+	buddy_free(&buddy, ptr);
 }
 
 
-- 
2.54.0

