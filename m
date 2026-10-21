Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625230;
	b=QnLwhTE0hNVK9K+gH18BOVVNmYHNL5I4Jv+XMVuxVPaLZyUh/5apz8DWd5wVJlIfljaL
	 qI86Q07J2ijlLBBfL8NwemEaypxZN++FBEUgh6QA2DlgPdHsg7J1teP9/fbYa7H3JXLG9
	 XPO9i5tg6B3HlOtswBVHvr9UzcnwM/YAKQt+V8oVUqyylh5+d9cCqB3I9ALcTPWyQDuCA
	 ARxWf4ZdvvTcbj2OynPeLzn39nPASzrRbKXjRJ5kr3zJBk5KTu4Dj9ftpZ3ANL0Zjwohu
	 yQwOw16WQWWh/csIkRR75u6Jt5Pn3cBr2KBkWCfOma6trCCaPEczinQVAb4agV8MrZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R09UjwBdHazb9n3Bv49buF32l0ypLjZpsmignhWlQmQ=;
	b=vZ31pb1mkZAwf8mAR/gsL1pjbjNOJlZdVeWFN3MLDSp5kCMif8HzLtDxIyRBb0CocRqQ
	 bZhh7ZCSivKrnkCIEg+/9b1zbdOLYFRdm1Leay/MJhpJccL4zFjUYoTHib8Pj8HAKymmQ
	 JxNfuRLHbRR1kog6prdC8SpJyaBlN0DVYgT0jReeLF5OYFhoua8sCpaBWgLhGEPLYy1h5
	 SQIVOTEx9f7Usmv9ywcHE1u7S0vbJ0k3VN/Rgw0aZwa2ZjqJqTbmt05qfYv3Vg+J8FLxz
	 i3iOsbOOXmwAsA9KxIHYxb7H4h+iD4HG8shLBIB57iNU9RXWM/+WM+j3dl86KPaa2fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ReVZkGhL;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C8606A321
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 23:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D27C8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=ReVZkGhL
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso8188485ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792625229; x=1793230029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R09UjwBdHazb9n3Bv49buF32l0ypLjZpsmignhWlQmQ=;
        b=ReVZkGhLDj9LTM4EUOg5YGd+GdVOVHj8aauPowZlzpWukQG0KypCtG+kS4IZrjzOP3
         o+fqP2PCFpZfR2HGhoIbs4Cnib44w0Jw6t48tPEP+/pXDgg0nfzNMIxGtEu7sz21PDR3
         yQLVCt+x5bAn3XFhttGZSVD1uhZbwztDrq+qd2oqP3UcWBUK+8c1jDvw1Mjb++P1zzrt
         saf7xwXWuY3ESPaYFKjmUTjOxYJOvTjZK18IBrSHx+wt0wNVbtlN+cV6/pHbrZFSTnSf
         AcPRqypGawPF5cRyKEc/cUVOFtckSl71ws44OVpOpc26MpXPkT6mT/uqXU4ip7rhZsjl
         JH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625229; x=1793230029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R09UjwBdHazb9n3Bv49buF32l0ypLjZpsmignhWlQmQ=;
        b=YXCdqd1jB9Zk6b9S3RGn9kU2EMyrjFvcMZ8h3jvAr3eTfZGq9yjcH5W4JDvAXvDaDf
         dweOcELjo090dl2qPPTjoXyY+KTHr1rXQzFm/yrFzxz4a27DTCZN/axLnO7ohf17W24i
         31NBALVg5tNa9hkKfjgq/faojRNnIJaeP/PtoDDUlDCwih8rJ8f1qBrEjJzSdTrPFjKl
         IJ3G+wgmHXuVB/ZlcxTrMPKMw3023C4OKjY4fe/8qwGngy0V/FWNsGidM4Sg8N8Eo8vN
         GT5PAjy1ttO0PNzgL1aQ7NQ07fZosOdFlJfe1JAywIA5n2VZkYRlkfCBuUmkYY68RJ0j
         MQJg==
X-Gm-Message-State: AFq9FYIT0MWO7/fxzgj/s0a78HzUshS5BHx/y3UtClxqzzaIJs1P1IUg
	8b4fMFpT+s7MhwxifuvRhI7ZjsQ25UnRaDS0sanEfgQsLS++eoGHG/byDqxYawbHlpEuFMrB0ca
	Q+ieZ7QzyGA==
X-Gm-Gg: AYBFou2ud5WujAx67xOFqdelWAk3WQGqTlP+kZIqUMVbhWLF8nanrdURfUuEyGS0aRV
	kKZ85B7Au+E4dQMrI41ebXiFT1Aoi2GwfVDVqv2rG0Nmx6YL/koDVgzIMVj42oBOabV1OuQs09r
	8EJQiCQvvfvAu3G4LHvTL+ZIktdAZXz2pAN2jcKyJ0NH5ecmB+R3Ag9oLUudjsB3idv/5OaAE00
	WCfaYICk6QlL5yCQUtsAA8xKwDYYhbL4PaR22ZESwXQpDyEjtVyUuFEknv0BXV967pWtoumNCVV
	lUDdG8F33qF6RS4G6kzgh+ePkI6a5yAsZ1zR+kTviROe0Fjnj4f4DbW9bRDgJ6Zb1j9XM1HRfSx
	5dRtOisbyzVXHnBBwznsWW4+shXK5An93spe+4YacNPNXAf84flHbhT90W8wXuwBkWrZsuEJibm
	48JDzAvcscrpaU5K8GmZc7NDrb6XZbVwr4nHKIJyZVN6Bs6IdNuLd+PFlkmadovJ3LvwlMDnjwT
	GFHeYQrZTsvFbW+Mhfeu7dPg73b9MUDTlX5PbnZ+cSu0g==
X-Received: by 2002:a17:902:cf0a:b0:2dd:c100:4b81 with SMTP id d9443c01a7336-2ea43d3a655mr32043105ad.56.1792625229067;
        Wed, 21 Oct 2026 16:27:09 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:725c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ada70sm15651425ad.72.2026.10.21.16.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:27:08 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 4/7] selftests/bpf: libarena: Handle NMI reentrancy
Date: Wed, 21 Oct 2026 23:26:38 +0000
Message-ID: <20261021232641.10063-5-emil@etsalapatis.com>
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

An NMI can interrupt the buddy allocator while it holds the buddy lock, so
code running in NMI context must not take that lock.

Allow an allocation from NMI context only when the local cache can satisfy
it without taking the buddy lock.

When an NMI free cannot use the local cache, link the object onto an
intrusive deferred-free list. A later allocator operation from a safe
context drains that list while holding the buddy lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |   3 +
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   2 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 129 +++++++++++++++++-
 3 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 66349915745b..de8d29ea4673 100644
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
index c41e163b014f..e19104ad7422 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -6,6 +6,7 @@
 #include <libarena/buddy.h>
 
 #include <bpf_arena_spin_lock.h>
+#include <bpf_experimental.h>
 
 _Static_assert(BUDDY_CACHE_MAX_CPUS == _Q_MAX_CPUS,
 	       "buddy caches must cover every CPU arena spinlocks support");
@@ -48,6 +49,8 @@ static u64 size_to_order(size_t size);
 static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
 					int order, size_t norder);
 static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr);
+static bool buddy_deferred_free_pending(struct buddy __arena *buddy);
+static int buddy_deferred_free_complete(struct buddy __arena *buddy);
 
 #define buddy_lock(buddy, flags) (arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
 #define buddy_unlock(buddy, flags) (arena_spin_unlock_irqrestore(&(buddy)->lock, (flags)))
@@ -747,6 +750,7 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	if (!asan_ready())
 		return -EINVAL;
+	buddy->deferred_free = NULL;
 
 	/* Reserve enough address space to ensure allocations are aligned. */
 	ret = buddy_reserve_arena_vaddr(buddy);
@@ -817,6 +821,7 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 
 	/* Clear all fields. */
 	buddy->first_chunk = NULL;
+	buddy->deferred_free = NULL;
 
 	return 0;
 }
@@ -967,9 +972,19 @@ static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size
 		return NULL;
 	}
 
+	if (bpf_in_nmi())
+		return NULL;
+
 	if (buddy_lock(buddy, flags))
 		return NULL;
 
+	if (unlikely(buddy_deferred_free_pending(buddy))) {
+		if (buddy_deferred_free_complete(buddy)) {
+			buddy_unlock(buddy, flags);
+			return NULL;
+		}
+	}
+
 	address = (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order, norder);
 	buddy_unlock(buddy, flags);
 	if (address)
@@ -1128,10 +1143,102 @@ static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
 	return 0;
 }
 
+static bool buddy_deferred_free_pending(struct buddy __arena *buddy)
+{
+	return buddy->deferred_free != NULL;
+}
+
+static void buddy_deferred_free_start(struct buddy __arena *buddy, void __arena *addr)
+{
+	void __arena *head;
+	void __arena * __arena *new;
+
+	/*
+	 * Make a linked list by chaining the allocations into a linked list.
+	 * Possible because allocations are 16 bytes minimum and so fit a pointer.
+	 */
+	new = (void __arena * __arena *)addr;
+	asan_unpoison(addr, sizeof(void *));
+	do  {
+		head = buddy->deferred_free;
+		*new = head;
+	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
+			 head, (void __arena *)new) != head && can_loop);
+}
+
+static void buddy_deferred_free_start_bulk(struct buddy __arena *buddy,
+		 void __arena * __arena *addrs, size_t naddrs)
+{
+	void __arena *head, *first, *last, *addr;
+	unsigned int i;
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
+		return;
+
+	/* Splice the local list onto the deferred-free list. */
+	do  {
+		head = buddy->deferred_free;
+		*(void __arena * __arena *)last = head;
+	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
+			 head, first) != head && can_loop);
+}
+
+static int buddy_deferred_free_complete(struct buddy __arena *buddy)
+{
+	void __arena *head, *old;
+	int ret = 0, err;
+
+	do {
+		head = buddy->deferred_free;
+		if (!head)
+			break;
+		old = head;
+
+		/*
+		 * The cmpxchg is safe because we never pop from the list
+		 * without holding the buddy lock. The next pointer of
+		 * the element then cannot have been gotten invalidated.
+		 */
+
+	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
+			 old, NULL) != old && can_loop);
+
+	while (head && can_loop) {
+		old = head;
+		head = *(void __arena * __arena *)head;
+
+		err = buddy_free_unlocked(buddy, (u64)old);
+		ret = ret ?: err;
+	}
+
+	return ret;
+}
+
 __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 {
 	unsigned long flags;
-	int ret;
+	int ret, err;
 
 	if (!buddy)
 		return -EINVAL;
@@ -1144,12 +1251,23 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 	if (!ret)
 		return 0;
 
+	if (bpf_in_nmi()) {
+		buddy_deferred_free_start(buddy, addr);
+		return 0;
+	}
+
 	ret = buddy_lock(buddy, flags);
 	if (ret)
 		return ret;
 
 	ret = buddy_free_unlocked(buddy, (u64)addr);
 
+	/* Drain any frees stranded during an NMI. */
+	if (unlikely(buddy_deferred_free_pending(buddy))) {
+		err = buddy_deferred_free_complete(buddy);
+		ret = ret ?: err;
+	}
+
 	buddy_unlock(buddy, flags);
 
 	return ret;
@@ -1174,6 +1292,11 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
 	if (!addrs)
 		return -EINVAL;
 
+	if (bpf_in_nmi()) {
+		buddy_deferred_free_start_bulk(buddy, addrs, naddrs);
+		return 0;
+	}
+
 	ret = buddy_lock(buddy, flags);
 	if (ret)
 		return ret;
@@ -1186,6 +1309,10 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
 		buddy_free_unlocked(buddy, (u64)addrs[i]);
 	}
 
+	/* Drain any frees stranded during an NMI. */
+	if (unlikely(buddy_deferred_free_pending(buddy)))
+		buddy_deferred_free_complete(buddy);
+
 	buddy_unlock(buddy, flags);
 
 	return 0;
-- 
2.52.0

