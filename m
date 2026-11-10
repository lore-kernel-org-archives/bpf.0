Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271130;
	b=uOtmp/eHRoF59001OUg899iTGGoxF06FynOePstiBusAIjT/FZ5L4O3ZvWBqybuA+gGp
	 lKN4DPz1uTMuZ5z3OdyyFIGW2LT2cYdpnbJ4ReEmsnrA/pnVOklTeKZb/TeWEuPyXf8UA
	 B6y/tp3C4W1j7PJg2kX3rO+tlN4s6TRusSoaXdgTm9RFe8j0s/RZVjxk5lVDDgeaT3EIB
	 K9Z3hpMfBBBl/RGOHD0FrcrWdNJEP0nzipXOoHnp1MjpCjjRMwjMtwzuP12P4t53yJqNB
	 +llRrJk0SwPQUPcGgJ9uSdC/WRTrmWSSIlK6XTaAH3fb8wwC2Thi9fBohFF61X6JpPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZBSKpXCx/x0Z9ccujE8hpXSlek1K54qxriCeb84cGZg=;
	b=xTZrHM1RjMM934MrdLHGdMhGnD/cgeaR5yURszKc8BaaWUwywb/VItCPWgdjlng1XC3I
	 i6sFGGNM7Q0Pjd5eQKxl5/HEY0ULrBg8VGpo9LBYg2WsYMIH6xRMMykN7I8l64FIMyn96
	 EBANxSQA4XiCSlrm4iIheUVZB5idHJt+dXfCh3UXOeFfrGFhJEDOzk6NPUYGcMJzs7cTC
	 rwaNhBQhFzFXMGMAIdjo1yr1xUNH1vVk26FdzMWh/Hq4hnLQcPx6BNBG8NZPZrafTghXo
	 GSltvkUHH4ZmUpVMOy43ig4NE6oYo5VaEeCVIwLdiz9oTuObZ5fq7SKQQ3kcwCHaYmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=2ApofInA;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C6606A32A
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE6C6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=2ApofInA
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so4761585ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794271129; x=1794875929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBSKpXCx/x0Z9ccujE8hpXSlek1K54qxriCeb84cGZg=;
        b=2ApofInAb5fjMla1Erx+URc15m66C+Wp4LJWOEPeTdhsrPpnSywxECwSrsrA4poaJj
         C6HWUfJgU3bX14EHIaY9lRgFTQ2NCh0mF8kL2cgMCDUuvIwTejH1/uZnu7hKZaZOBJ2Q
         8rs64VqoNOEI9oCGrHtns3y8Ns09FhF/53YK/XLH9QfHGdA6XDg8rk3xQGrukCDewGIf
         ZzUu7UtDXltGsan/K4qKCIRnXrPlBuWphMDCsEeszrzc6Z4FC6qgHCKcWmao2+LoSDyR
         pyU8qMcDQP8EBek7Oq0mit5nqfLhMqVCC/7LbPweaFjlJWu64zRsV2bD3RIIld6dZSuJ
         8ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271129; x=1794875929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZBSKpXCx/x0Z9ccujE8hpXSlek1K54qxriCeb84cGZg=;
        b=FCAj1zsVtuFBKzerySV1lW+7TL/BoIXnI3ISpBq7UqokvdFMBrW/1/BeyOlyMWst0i
         5xxpKcrvIGJ53VOb6wngCWASdS3TGgWvLscSrQpGif8l2oG0eBa5zcHTUl9Q3rs/AtQn
         EFDBDkzfqOIIDiZCN8C5gi23YYtoqUYdYsEF4vUgwEbovfXNqnntUxnBtbJ8oD1QR/oA
         jaF6jhC+eQf1r6vdyk+4RC7fwhn6w+eB1zVSpgjY9fPqs0Pc+5+V2ByqG5drVr5enbPe
         SR5zAwt5yxLpVttcNs6jFtYZcbAX+UJBLcDpiLIH70ECJtBCkqPBnPpWOxPzOVUO2kzI
         IJTg==
X-Gm-Message-State: APuU4Z9HEn2B9sd891tN++92jvuQV2SoaxUKIyiGM+oQ/9qgWszGMB5j
	toHsjIhSuwPbRmcFgoL1y6eBA/6dLcwTbc33r1ME2nXVOrE5OdZii5rBVJidAPlSMdxROpIK5po
	XCbWozfQ=
X-Gm-Gg: AYBFou24/YhiK21MKK1DsvbL0bfFqsSXk4UeGSgvO47k2QFdEwvQk/4TtKl+CD9NuGp
	DZhfrC8U3GZh2NElL87fyTFFj9yNT3JTrjYcBd5kxQrfpXhfCFl5al+INaBXCHX9vGXkykN0mC2
	xF7ImB4t3OazqbVcyPab36wuZ1oglHzcqoMA3spE1iafYy4QfDo66Uu4FeW9BjldmH++Zs6+rKy
	iIXYyX1r/YZf1PYDXwReyDL6Vm7euvmCrQcx6WAxlmof5aHLgw6l/z/1TWIeoDt97S29rKbpaOE
	Jw+Rxx/FZacPOhpoKNiyDJzY0NVbcr8I5Ukz9rrZd0y3Kjuz2plCCgI1acUOB+lcwZus2WrL7AF
	mkjtd2U4orp8/k6SY9OOFwyC3QU6Wsajj+I/NW7zpideaPRlWMubpj0QQ8LNPN2WbnV7a7jEwm/
	dyYYvfRqMCxpHkU5np7/IK1QOaOXnq8ODpoxPD73iOJn45Yae5BNF4rTGBK/nRU+Yu3JR2UGnL7
	j7D9lxuva7T0t0xbNaFtS1iiNhoQ5oMb22qDImlVFUXJaq27rA1GC6Il6I/BeufwbKj6Px+S/6M
	K04y8wN8SbHRvSsLK611hcM4zY+eOSdnp+avs4S2/t/wSdvGJVqs5Q+ck8P+Ir0sW6V2p4hfyRQ
	li9a3XoIYHVkz6vACWU7rEdJ5hoM=
X-Received: by 2002:a17:90b:528c:b0:3a4:b30b:b501 with SMTP id 98e67ed59e1d1-3b166b3f171mr1103049a91.9.1794271129081;
        Mon, 09 Nov 2026 16:38:49 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b168eacb73sm640209a91.1.2026.11.09.16.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:38:48 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 6/9] selftests/bpf: libarena: Handle NMI reentrancy
Date: Tue, 10 Nov 2026 00:38:35 +0000
Message-ID: <20261110003838.8739-7-emil@etsalapatis.com>
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

An NMI can interrupt the buddy allocator while it holds the buddy lock, so
code running in NMI context must not wait for that lock.

Use trylock for buddy operations in NMI context and normal locking in other
contexts. If the buddy lock cannot be acquired, allocations return NULL
and frees transfer ownership to an intrusive deferred-free list.

Drain deferred frees on a later successful lock acquisition, including
from NMI context.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |   3 +
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   2 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 135 ++++++++++++++++--
 3 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index ec5e79a07540..7553ad5a879d 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -49,6 +49,8 @@ struct buddy_header {
 	u32 next_index; /* Same for the next allocation. */
 };
 
+struct buddy_deferred_free;
+
 /*
  * We bring memory into the allocator 1 MiB at a time.
  */
@@ -103,6 +105,7 @@ struct buddy {
 	arena_spinlock_t lock;			/* Allocator lock */
 	u64 vaddr;				/* Allocation into reserved vaddr */
 	struct buddy_cache __arena *percpu[BUDDY_CACHE_MAX_CPUS];
+	struct buddy_deferred_free __arena *deferred_free;
 };
 
 #ifdef __BPF__
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index 85a7ea8b2e97..e7c6ac76433c 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -44,6 +44,8 @@ __weak int test_buddy_create(void)
 		ret = buddy_destroy(&buddy);
 		if (ret)
 			return ret;
+		if (buddy.deferred_free)
+			return -EINVAL;
 		if (buddy.percpu[0])
 			return -EINVAL;
 	}
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 58e666210fdb..7fd74f4c5052 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -6,6 +6,7 @@
 #include <libarena/buddy.h>
 
 #include <bpf_arena_spin_lock.h>
+#include <bpf_experimental.h>
 
 _Static_assert(BUDDY_CACHE_MAX_CPUS == _Q_MAX_CPUS,
 	       "buddy caches must cover every CPU arena spinlocks support");
@@ -48,8 +49,12 @@ static u64 size_to_order(size_t size);
 static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
 					int order, size_t norder, bool grow);
 static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr);
+static bool buddy_deferred_free_pending(struct buddy __arena *buddy);
+static void buddy_deferred_free_complete(struct buddy __arena *buddy);
 
-#define buddy_lock(buddy, flags) (arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
+#define buddy_lock(buddy, flags)						\
+	(bpf_in_nmi() ? arena_spin_trylock_irqsave(&(buddy)->lock, (flags)) :	\
+			arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
 #define buddy_unlock(buddy, flags) (arena_spin_unlock_irqrestore(&(buddy)->lock, (flags)))
 
 /*
@@ -747,6 +752,7 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	if (!asan_ready())
 		return -EINVAL;
+	buddy->deferred_free = NULL;
 
 	/* Reserve enough address space to ensure allocations are aligned. */
 	ret = buddy_reserve_arena_vaddr(buddy);
@@ -817,6 +823,7 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 
 	/* Clear all fields. */
 	buddy->first_chunk = NULL;
+	buddy->deferred_free = NULL;
 
 	return 0;
 }
@@ -970,12 +977,16 @@ static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size
 	if (buddy_lock(buddy, flags))
 		return NULL;
 
+	if (unlikely(buddy_deferred_free_pending(buddy))) {
+		buddy_deferred_free_complete(buddy);
+	}
+
 	address = (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order, norder);
 	buddy_unlock(buddy, flags);
 	if (address)
 		goto done;
 
-	if (!grow)
+	if (!grow || bpf_in_nmi())
 		return NULL;
 
 	/* Get a new chunk. */
@@ -1050,6 +1061,9 @@ int buddy_grow(struct buddy __arena *buddy, size_t nr_chunks)
 	unsigned long flags;
 	size_t chunk_index;
 
+	if (bpf_in_nmi())
+		return -EOPNOTSUPP;
+
 	for (chunk_index = zero; chunk_index < nr_chunks && can_loop; chunk_index++) {
 		chunk = buddy_chunk_get(buddy);
 		if (!chunk)
@@ -1187,6 +1201,98 @@ static __always_inline int buddy_free_unlocked(struct buddy __arena *buddy, u64
 	return 0;
 }
 
+static bool buddy_deferred_free_pending(struct buddy __arena *buddy)
+{
+	return buddy->deferred_free != NULL;
+}
+
+static __always_inline void buddy_deferred_free_push(struct buddy __arena *buddy,
+						   void __arena *first, void __arena *last)
+{
+	void __arena *head;
+
+	do {
+		head = READ_ONCE(buddy->deferred_free);
+		*(void __arena * __arena *)last = head;
+	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
+			 head, first) != head && can_loop);
+}
+
+static int buddy_deferred_free_start(struct buddy __arena *buddy, void __arena *addr)
+{
+	int order = buddy_cache_get_order(addr);
+
+	if (order >= BUDDY_CHUNK_NUM_ORDERS)
+		return -EINVAL;
+
+	/*
+	 * Make a linked list by chaining the allocations into a linked list.
+	 * Possible because allocations are 16 bytes minimum and so fit a pointer.
+	 */
+	asan_poison(addr, BUDDY_POISONED, BUDDY_MIN_ALLOC_BYTES << order);
+	asan_unpoison(addr, sizeof(void *));
+	buddy_deferred_free_push(buddy, addr, addr);
+	return 0;
+}
+
+static int buddy_deferred_free_start_bulk(struct buddy __arena *buddy,
+		 void __arena * __arena *addrs, size_t naddrs)
+{
+	void __arena *first, *last, *addr;
+	unsigned int i;
+	int ret = 0, order;
+
+	/*
+	 * Chain the allocations into a local linked list. Possible because
+	 * allocations are 16 bytes minimum and so fit a pointer.
+	 */
+	first = NULL;
+	last = NULL;
+	for (i = zero; i < naddrs && can_loop; i++) {
+		addr = addrs[i];
+		if (!addr)
+			continue;
+
+		order = buddy_cache_get_order(addr);
+		if (order >= BUDDY_CHUNK_NUM_ORDERS) {
+			ret = -EINVAL;
+			continue;
+		}
+
+		asan_poison(addr, BUDDY_POISONED, BUDDY_MIN_ALLOC_BYTES << order);
+		asan_unpoison(addr, sizeof(void *));
+
+		if (!first)
+			first = addr;
+		else
+			*(void __arena * __arena *)last = addr;
+
+		last = addr;
+	}
+
+	if (!first)
+		return ret;
+
+	/* Splice the local list onto the deferred-free list. */
+	buddy_deferred_free_push(buddy, first, last);
+	return 0;
+}
+
+static void buddy_deferred_free_complete(struct buddy __arena *buddy)
+{
+	void __arena *head, *old;
+
+	head = __sync_lock_test_and_set((void __arena * __arena *)&buddy->deferred_free,
+					NULL);
+
+	while (head && can_loop) {
+		old = head;
+		head = *(void __arena * __arena *)head;
+
+		buddy_free_unlocked(buddy, (u64)old);
+	}
+}
+
 __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 {
 	unsigned long flags;
@@ -1204,20 +1310,26 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 		return 0;
 
 	ret = buddy_lock(buddy, flags);
-	if (ret)
-		return ret;
+	if (ret) {
+		return buddy_deferred_free_start(buddy, addr);
+	}
 
 	ret = buddy_free_unlocked(buddy, (u64)addr);
 
+	/* Drain any frees stranded during NMI/lock failure. */
+	if (unlikely(buddy_deferred_free_pending(buddy))) {
+		buddy_deferred_free_complete(buddy);
+	}
+
 	buddy_unlock(buddy, flags);
 
 	return ret;
 }
 
 /*
- * Fails only when the arguments are invalid or the buddy lock cannot be taken.
- * Nothing is freed in either case. Objects that buddy_free_unlocked() rejects
- * are reported there.
+ * Reject a NULL buddy or a NULL address array for a nonempty batch with -EINVAL.
+ * Valid objects are freed under the buddy lock or deferred on lock failure.
+ * Objects that buddy_free_unlocked() rejects are reported there.
  */
 __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *addrs, size_t naddrs)
 {
@@ -1235,8 +1347,9 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
 		return -EINVAL;
 
 	ret = buddy_lock(buddy, flags);
-	if (ret)
-		return ret;
+	if (ret) {
+		return buddy_deferred_free_start_bulk(buddy, addrs, naddrs);
+	}
 
 	for (i = zero; i < naddrs && can_loop; i++) {
 		/* NULL pointers are ignored. */
@@ -1246,6 +1359,10 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
 		buddy_free_unlocked(buddy, (u64)addrs[i]);
 	}
 
+	/* Drain any frees stranded during an NMI/lock failure. */
+	if (unlikely(buddy_deferred_free_pending(buddy)))
+		buddy_deferred_free_complete(buddy);
+
 	buddy_unlock(buddy, flags);
 
 	return 0;
-- 
2.52.0

