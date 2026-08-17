Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7FB3DA7DF
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994185; cv=none; b=rmt6tyt8acPoU7BtPhQlryURCNI4hfH/S3Exe65YdX2/oR+vfX9dBsvaBgHd/ylLP1J29YW8+i7cTlH2BoIXa1CovbHYjj+EkG0hhoLazTCXCBEZr9SFn7HJ/Ar26sqjV4yNArtmtHXHFm4tpfh3JJrzZPo348bKvvIxEApkj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994185; c=relaxed/simple;
	bh=6GRznrP35CSD4ctjOe7jtbB6lu94dtX/K310UxMVqlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC5rkYlQgRzxpvIJXWHHkkVSyiVdLnL8Xgzc1ll5aWMnqLKnKi+e2d81vj/ukwhQv/puWHe8XItI3clvZTEF8ZcenaKjAiWt3v/n6SHVh4j/+TmUQG3OnxOMaWy1CdJ9CWDL/evd8wxJJ5ju8foOZpzXOp6JBlFUxa1h9s7jJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=W2g/2Z4Y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="W2g/2Z4Y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3879428a91.3
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 12:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1786994183; x=1787598983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twiaFp92hUqKCCx1A4Tq7EH5UG7+M0wWYiXXcRJjris=;
        b=W2g/2Z4YnY3EUdbY/0/U90cp6GFW6iGOpu8olBqKSkN4C2MXMV1FmcWe3AwItpNG8A
         xaY3YeUNvy91O8NSTvOYFw9pQZgKAyDXH2UyByex9LPeiWtTZyH9WMKTKv6KBBc9+de3
         4tFW7wWL9jegLSEVcyz/b3G9M1WwS4qkM+Oh2pwzfPbPaonWjAcgrZ8/h6OV4isjy7sp
         eJZjxlGZVgMrhmRmP0Kj+xkZqChdn9WtQiZjj09e2pbu+4RYaT8c3x8V0J0v5uY506BR
         wJjdQomzIzGKYmnS2tF5sMbI8hEBvCWQfpzCRV1R4CZRJzDxb05n8uLwsTX9LS9Q5ckJ
         +0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994183; x=1787598983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=twiaFp92hUqKCCx1A4Tq7EH5UG7+M0wWYiXXcRJjris=;
        b=DNyrterdwzxcIUhwfBU/uWRb5ol7GQjIOmBWyKbfQJ05IO0F6+3+dOJkGywdi9xn2T
         3Ia8xKVbDKwe1XKouX8ic3uPyhm4kdblGJNIkQdkmJW2wUl95QjwcM8VDx2unc7cBbid
         x7DocVY7ijLPd9u8E4dRpLTotILMyK+XBqnbh728FXiAw4W2LkC/sCodAXf5cL+8D1ae
         y76TZ7p7cmL2Wbk3OEOdn9BYu6rWmdHoKdwyxmBiruQFln6C/CgXzahD4rABFTK1b0oN
         p3JMA6ULyUKshQMoUs1NKWuip9yy39LJvrijrJf81dJvEsxVttgONBaTSWP7+DP3RlxN
         TB3A==
X-Gm-Message-State: AOJu0YxzvrJ61tEwSSCV0DVfIINYlvGm9EJWGX8jEalLQWbPVXPJNG6j
	6aoNhNg/PzSpc4FPdl6loCwBjOsQaxU00/3wrGfbhE1UjHAfq4TI3UEXR2Zt2IgpLU3t/rFsop+
	cL8t/p+g=
X-Gm-Gg: AR+sD12F5DAaHqzsB4KG5KW16Rza3OFmuPJA5Fg/P+JizkW5+/uEMc7M67FURrlhoWj
	6XASYdEpZ7d+CuyXw2TWXGQJJdnhiKzbCEb1mysSnwqmwE5jnyYYdCugnuwhUBUi4soLxZf0ZFX
	K5Lhm5ESZMzSHJWHfU7DYjXD2qmeAuVqu8acxpe/J0kw4gAO4kqy5wnieTPVY6ufcpMtSP4hL4Y
	0Q2XmwqexoN9KxoTar/kCxVxpqrHBMKDSy++KofXSCwrR++299Lr6rAxkANsd5I/PRPFO2kedJn
	HyuSt70uvt+aVTh3o7zhWxviBoXclhfsR/KA8M2fTB2Qr8rqnXiYFyKwWsPlwnZkWyGiFKRfeXR
	JtZ1qOwE5BILmm1/v64NF28pc9YLlPdHdR6nEa1U+cpvl3P6LNt0XmxUfgMCkvQ0cZ9soB+jtmZ
	41bwWvfkKl6S/Z4O2asitNxEJwQGQYycN4xKkPzlHezLMkr5sYitI7hCMR1ErZ/yozMr6sizDln
	Q5oQB/4lOUXepqz6u0eTp0=
X-Received: by 2002:a17:90b:5450:b0:38e:655c:6516 with SMTP id 98e67ed59e1d1-3933b4f3238mr28520595a91.0.1786994182940;
        Mon, 17 Aug 2026 12:16:22 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b62696bsm5485597a91.2.2026.08.17.12.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:16:22 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH 3/6] selftests/bpf: libarena: Disable IRQs during allocation
Date: Mon, 17 Aug 2026 15:16:13 -0400
Message-ID: <20260817191616.11071-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260817191616.11071-1-emil@etsalapatis.com>
References: <20260817191616.11071-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The libarena buddy allocator currently uses arena_spin_lock/unlock
to protect its internal data structures in its critical section.
These locks disable preemption, but not IRQs. This in turns can cause
ABBA deadlocks when an allocation/free operation gets an IRQ while
in the critical section, and can only resume after another operation
that in turn blocks on the buddy lock. We have concretely seen this
with sched_ext schedulers:

a) Task 1 on CPU A attempts an allocation during initialization,
which is done without holding an rq lock. The task takes an IRQ
in the middle of the allocation.
b) Task 2 on CPU B exits. It attempts to take the buddy allocator
lock during its sched-ext state teardown, and blocks on the spinlock.
It does so while holding CPU B's rq lock.
c) The scheduler run on CPU A and attempts to move tasks from CPU
B's rq to CPU A's rq before resuming running Task 1. This requires
B's rq lock, which requires Task 2 to take the buddy allocator lock
first.

Fix this by disabling IRQs when taking the buddy lock. We use the
already existing arena_spin_[lock_irqsave, unlock_irqrestore] calls
for this.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 44 +++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index c674ee5cfcc1..2490ab1396de 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -5,6 +5,8 @@
 #include <libarena/asan.h>
 #include <libarena/buddy.h>
 
+#include <bpf_arena_spin_lock.h>
+
 /*
  * Buddy allocator arena-based implementation.
  *
@@ -45,15 +47,8 @@ enum {
 	BUDDY_CHUNK_PAGES	= BUDDY_CHUNK_BYTES / __PAGE_SIZE
 };
 
-static inline int buddy_lock(struct buddy __arena *buddy)
-{
-	return arena_spin_lock(&buddy->lock);
-}
-
-static inline void buddy_unlock(struct buddy __arena *buddy)
-{
-	arena_spin_unlock(&buddy->lock);
-}
+#define buddy_lock(buddy, flags) (arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
+#define buddy_unlock(buddy, flags) (arena_spin_unlock_irqrestore(&(buddy)->lock, (flags)))
 
 /*
  * Reserve part of the arena address space for the allocator. We use
@@ -385,6 +380,7 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 {
 	u64 order, ord, min_order, max_order;
 	struct buddy_chunk __arena  *chunk;
+	unsigned long flags;
 	size_t left;
 	int power2;
 	u64 vaddr;
@@ -416,7 +412,7 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 		return NULL;
 	}
 
-	if (buddy_lock(buddy)) {
+	if (buddy_lock(buddy, flags)) {
 		/*
 		 * We cannot reclaim the vaddr space, but that is ok - this
 		 * operation should always succeed. The error path is to catch
@@ -520,7 +516,7 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 			arena_stderr(
 				"chunk has size of 0x%lx bytes (left %lx bytes)\n",
 				sizeof(*chunk), left);
-			buddy_unlock(buddy);
+			buddy_unlock(buddy, flags);
 
 			return NULL;
 		}
@@ -531,7 +527,7 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 		order = (power2 >= BUDDY_MIN_ALLOC_SHIFT) ? power2 - BUDDY_MIN_ALLOC_SHIFT : 0;
 
 		if (idx_set_allocated(chunk, idx, true)) {
-			buddy_unlock(buddy);
+			buddy_unlock(buddy, flags);
 			return NULL;
 		}
 
@@ -547,7 +543,7 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 		 */
 		min_order = left ? order + 1 : order;
 		if (add_leftovers_to_freelist(chunk, idx, min_order, max_order)) {
-			buddy_unlock(buddy);
+			buddy_unlock(buddy, flags);
 			return NULL;
 		}
 
@@ -556,7 +552,7 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 		max_order = order;
 	}
 
-	buddy_unlock(buddy);
+	buddy_unlock(buddy, flags);
 
 	return chunk;
 }
@@ -564,6 +560,7 @@ static struct buddy_chunk __arena *buddy_chunk_get(struct buddy __arena *buddy)
 __weak int buddy_init(struct buddy __arena *buddy)
 {
 	struct buddy_chunk __arena *chunk;
+	unsigned long flags;
 	int ret;
 
 	if (!asan_ready())
@@ -579,7 +576,7 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	chunk = buddy_chunk_get(buddy);
 
-	if (buddy_lock(buddy)) {
+	if (buddy_lock(buddy, flags)) {
 		bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
 		return -EINVAL;
 	}
@@ -591,7 +588,7 @@ __weak int buddy_init(struct buddy __arena *buddy)
 	/* Put the chunk at the beginning of the list. */
 	buddy->first_chunk = chunk;
 
-	buddy_unlock(buddy);
+	buddy_unlock(buddy, flags);
 
 	return chunk ? 0 : -ENOMEM;
 }
@@ -730,9 +727,10 @@ static u64 buddy_alloc_from_existing_chunks(struct buddy __arena *buddy, int ord
  */
 static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_chunk __arena *chunk, int order)
 {
+	unsigned long flags;
 	u64 address;
 
-	if (buddy_lock(buddy))
+	if (buddy_lock(buddy, flags))
 		return (u64)NULL;
 
 
@@ -745,7 +743,7 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
 
 	address = buddy_chunk_alloc(buddy->first_chunk, order);
 
-	buddy_unlock(buddy);
+	buddy_unlock(buddy, flags);
 
 	return (u64)address;
 }
@@ -754,6 +752,7 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 {
 	void __arena *address = NULL;
 	struct buddy_chunk __arena *chunk;
+	unsigned long flags;
 	int order;
 
 	if (!buddy)
@@ -765,11 +764,11 @@ void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 		return NULL;
 	}
 
-	if (buddy_lock(buddy))
+	if (buddy_lock(buddy, flags))
 		return NULL;
 
 	address = (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order);
-	buddy_unlock(buddy);
+	buddy_unlock(buddy, flags);
 	if (address)
 		goto done;
 
@@ -880,6 +879,7 @@ static __always_inline int buddy_free_unlocked(struct buddy __arena *buddy, u64
 
 __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 {
+	unsigned long flags;
 	int ret;
 
 	if (!buddy)
@@ -889,13 +889,13 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 	if (!addr)
 		return 0;
 
-	ret = buddy_lock(buddy);
+	ret = buddy_lock(buddy, flags);
 	if (ret)
 		return ret;
 
 	ret = buddy_free_unlocked(buddy, (u64)addr);
 
-	buddy_unlock(buddy);
+	buddy_unlock(buddy, flags);
 
 	return ret;
 }
-- 
2.54.0

