Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8F231832
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100596; cv=none; b=lQO8ml+FrhjNkaf6GX+yK/4pIvhPxfE4lKIyooEFVPlgOeSxobbWtBNKk1MICMxmjXpkGVV51+zGHHJ0hl3ULoT9hK2BthrEObuRBtJAaTYO+qdvSG7BqsDn0I62NkoIF0B5VFiX07g7++/WeOntnZJxwPPAmh9R93n30k2LNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100596; c=relaxed/simple;
	bh=NzjAsuYu7zizRHF7pqX5x+omjjXjtTK+vr8coWx5zYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdsSWy9zHSbkPy3j7Z0f7kL6pMWeoLF0TOqIWWTYEoOa7UfVz5etUlsmuFyFIWfHzx3uLNnC0E/UYjC7iiiz2H0rjT7wGh4Y6nu5ij+Fj5Dj0cUO3TopYZv1Ztq5R2xqL94xuWyM8A6bzDvmIXkvMT1uuVvZjSQ5LqPm30BQzb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=xDgk2Q/d; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="xDgk2Q/d"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1370417c01cso7458891c88.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 17:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780100595; x=1780705395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPACp389jITlIbRSXYRxedmsdmmK2Xw7wA/4XRV+Ks8=;
        b=xDgk2Q/d/Izdkm62Y264AD5vB0lFNJdQQvrW24KZFkley2xYL4M+8fKjZdiXKDuG14
         7Uw9sJJPINjstLGH8dDHoXhGEcr+e8wYf/Jxgfdt8bkDKMgnK6oNHwWzKFxu2nInPdQv
         Ii5NxM9O99w99eZaQE0N8LCp7MJ5y0xXIZvxyZCjQCqpbcWZkt0tWrE+Hp1RMtMnRSeE
         w8tgjvRypCFrV9cPjoQbmoHpytUd1XKk+5irtZNr36mnVgHyp6+LHjU+bv7iEX9AZEP0
         xDxj1FYxjBZBvsk301Y8Hekv206vl3qFu6g29aUcaSbfl2neC6mMu/lfuQiisdL9Eksw
         SRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100595; x=1780705395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPACp389jITlIbRSXYRxedmsdmmK2Xw7wA/4XRV+Ks8=;
        b=Pwi41E+Lf/hviLx9DqkbONEg/QkiTVBJ8fUO8ScAZp9rlcLA5POTMjc3lB078BTrsb
         IwvMSPKfJNquc68L3QVBbBDrVN75uAGYG6+Wk0rTL4myF0Yma4CzDmnpcludHpwz5f3O
         XnekJeTKcuBz83WkSeb3aRdKLiOnUj/89qvnMSXYlrynX47/kdflWcNjpfkellrsh3V/
         6RnpP50Ge+5AC2OIeYBPl2ABWdvTRYONuHm33gf7bs9xIHak7Bc0PAF75FvDfE4jpClI
         I62pAq4UbKJTEwmyuOjLf79OOfIi/JSOAsk2IW6T2cdxiXtPZx4HoY5aJ6zzOZ7vK+B6
         QrRQ==
X-Gm-Message-State: AOJu0YyQVZT2l+6o7nk4ilvtLyNzdT92co/IIxfS6DAII2L4D9YMrKHS
	7RrYdY4xWvSiso4/pzwZ3rbuEn5IkFnXDH34c54tDmQTrIlaH2nPxlV9OB5gTw90G+M0T4gZeyq
	H7CSbm/3Blswv
X-Gm-Gg: Acq92OFZJe4rfTxyv65nNjUrtGYPFdMK09NhjSwK0gQbgiQMwfg+PBPOOaG0g7QN6Kd
	dqKqpc23i8bZolWJAZH/AV3YmbqlVkBTF9tI8X3EeBPqjEzALRYhldCFCWwCEBZMJ7K2I4DyaHA
	HaYuktt00nz3P+/+e7YKHQ8HX5hu6PB2oW+9NgLhSGCBWB7aqbNTEsWoFGnN8JsjRy4mWd7W0ds
	Ms+mMe/NQuCjp6KL+Tg11baIQJC6Zm3nlt6qVHfRR20m0LNjf3zv3lg2hZRX+/zb9X9V3XW+kjz
	1+CXMCraUFIb0/f+CQW0tZjEjzM788LoDc0YvTor7ZpcAetqqNVMQ1aFnTHfubIOUfCoAwyv9KB
	Gxw74/HwrJUUl9T+4B/W4bFjtRRZCSYMYZg8kA9pY9HS5qJLmeScZjYefsu8i+4fXYEYgMivD5Q
	s5IMD1L0K/JtmvNo2VpTnloynoNU5YIA==
X-Received: by 2002:a05:7022:f96:b0:128:d7a7:5271 with SMTP id a92af1059eb24-137d426cb51mr795930c88.28.1780100594482;
        Fri, 29 May 2026 17:23:14 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::9529])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b35a5f44sm2070540c88.1.2026.05.29.17.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:23:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: libarena: Directly return arena pointers from functions
Date: Fri, 29 May 2026 20:22:59 -0400
Message-ID: <20260530002259.4505-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530002259.4505-1-emil@etsalapatis.com>
References: <20260530002259.4505-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the __arena annotation includes a BTF type tag, and the
verifier can identify arena pointers at BTF loading time, return
arena pointers as their true type instead of casting to u64. Remove the
preprocessor typecast wrappers used to hide this from the caller.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  3 +--
 .../bpf/libarena/include/libarena/common.h    |  3 +--
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 20 +++++++++----------
 .../selftests/bpf/libarena/src/common.bpf.c   |  4 ++--
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 4d57fc1b5c26..528c69a1f38e 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -76,7 +76,6 @@ struct buddy {
 int buddy_init(struct buddy __arena *buddy);
 int buddy_destroy(struct buddy __arena *buddy);
 int buddy_free(struct buddy __arena *buddy, void __arena *free);
-u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size);
-#define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((alloc), (size)))
+void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
 
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
index f4ed4c3abb4b..c674ee5cfcc1 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -750,25 +750,25 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
 	return (u64)address;
 }
 __weak
-u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size)
+void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 {
-	u64 address = (u64)NULL;
+	void __arena *address = NULL;
 	struct buddy_chunk __arena *chunk;
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
@@ -776,12 +776,12 @@ u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size)
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
@@ -789,10 +789,10 @@ u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size)
 	 * unused bytes that were part of the header.
 	 */
 	if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header __arena))
-		asan_poison((u8 __arena *)address + BUDDY_HEADER_OFF, BUDDY_POISONED,
+		asan_poison(address + BUDDY_HEADER_OFF, BUDDY_POISONED,
 			    sizeof(struct buddy_header __arena));
 
-	asan_unpoison((u8 __arena *)address, size);
+	asan_unpoison(address, size);
 
 	return address;
 }
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index ec9de29e6f3e..50be57213dfb 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -38,9 +38,9 @@ __weak int arena_buddy_reset(void)
 	return buddy_init(&buddy);
 }
 
-__weak u64 arena_malloc_internal(size_t size)
+__weak void __arena *arena_malloc(size_t size)
 {
-	return buddy_alloc_internal(&buddy, size);
+	return buddy_alloc(&buddy, size);
 }
 
 __weak void arena_free(void __arena *ptr)
-- 
2.54.0

