Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520348;
	b=yEbBz375F405fgVvGv2CJx6N5C0n6Kd7e4Egc9GYPnRn+DRSpn/k/3FUwjSqvvOKZOsC
	 PwzeqkTAH8MGeh2jGkXksSGxKcbMQeFprDYRuDiiaSrtg72DJEiNkMVZpBn1f89CPwSYt
	 tAqXroxWqJ6ampSl9Dew/17xMGbrhN58HEbfw4kiuTvWlMCkfGUrG1a1cT7hGBI0cu7iB
	 NB0487aJ2C9fjdsvCc6yIhqLMHD8s/M0I3JvdknArZtOqa+sRg6epPFUq1XFGnbfJk0cE
	 /XjiJGNYwAuLOB+MhBs5Um4IqLm+Tdw5rbbzE6TOz64PjwqbU15eKi/181uSW35Anhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BAR8XSVHQ9OkX1M+qo33PuQrwMCkn6jSs1oLGONbJ2E=;
	b=sXSLVeUuMlUSt2gZr2178KprwFEzG/AkGN5w26xFYafKS8yKF0L0vyt9kCvPqDwolyU5
	 TBdmfAkxsBh6Hznj6rMOCf5GtPmvKR0TTE6t54MazaOY/ITNAabs14bCBavvsykkBqaI4
	 BtU3qD6aUxMpxe1f58dq2yEGy5RTe2DOBbUB+Q5e3lHQMyb2Rr6jqZR9jltyVj5kd+L+o
	 haijqpWHOYDv27wK5Dm3YkjH7PhFWmq3VFIeh2yNfllW/rpIiAABKvbMK+0Pc1I9tMswZ
	 5nHPbqQqWT1o78BgY3ILZB1b4hSSACfgeK1fDRHfEJWVg0W/ZAohOKE8s0PWVJ/TK0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Nkymy89H;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD0960A2612
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD0960A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Nkymy89H
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so2869076a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792520348; x=1793125148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BAR8XSVHQ9OkX1M+qo33PuQrwMCkn6jSs1oLGONbJ2E=;
        b=Nkymy89HDBS6NEFlma+aJ76Ld0lj4isEpnzbN2GAx8d+nnDzgceF9DbZNjpFXLwZan
         u1NnbYvnjaRzpFhBPMnyzUfxsJo5gTaXxHzuJyQx5RQ9HmsFlilgUEpYJENREBAFygWI
         sVlQLjs29JQ4jjolZJcM70dvP2tHJ4A16zUF1Qypv02I0/+UiBJaCZNT8hyAIyBE9alx
         nxnpifA/c2qRCRP21uxEo02C9AmJSAXE0MTOi/TiZqAYBSU0bgHW5Oeh4/SR3a2spSC0
         BkGM+1fXykE409KyVx/07z2XKfiHBdc/FhcQHQ3RrWwQnoWAAZBWiKB1L0b18rEJiRSa
         H8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520348; x=1793125148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BAR8XSVHQ9OkX1M+qo33PuQrwMCkn6jSs1oLGONbJ2E=;
        b=ZELqKqbs9ytX8tRKQCk8wruBjufMC+VILF+Ur7o9qepMMvDpi2T8lCFRQDZz8peavW
         DdFFGu4aHf3ei9LB7P6l4G+zoh9zCbjlIVLmG4gkkaLdiXFewS8ceue63FDGd1MXyDWC
         JZ/02i7IZfPKgGF87otfuUIzRSXS5eSJaffWgsC0Y6CafTZaQci9QjK65N/al4KB3No9
         nrTzp8fWc9e1Exg5mSzklgpjA++ShDFzVis9ayQ1lgDCcDL8a1XpNmzZc4bZCNTqE+KX
         /gasFhX/CcBSt7BBLba+8Sliry0Bhx5G90wCipi9ocz2GQU/MSaLoApYJSWnKmvfKXW+
         wbww==
X-Gm-Message-State: AFq9FYI9CY3p8V0l1VR70wY8zX6LxOZpdsbDGicQkM6AATq/CXCGmwaE
	2D9lMAKceWNyTLHqaoOrr8NfCPBai0B9NzuNhibKPey93nsYDVJHjjLyXxEKp+HMcr8fVYs+0pf
	yHNyr4Jg=
X-Gm-Gg: AYBFou2vXSZwQTCRy5EOZRQFf0f8cjespu2uOMATXCFkuI2TPZNIUip0WbyFmqVE9dU
	ijA7fsm+oPE2CMU8mEPEJXklSpUG7Q6j3Rcr78kIjtlcKWECZpyWol51hcmeWBFvyRwFxwTwu71
	db9/1kBLXairpJ2AmMcE17hYQkfqUJCWUVlSHPmZyDoVC+MkdEW7HSwAHwTkChVby3zrWOnCRGH
	upeOeiXXXaXXpfSaAQL8Ndpjjg7iVR6CW2U6aWYsfO/R+6aHPnIuBXtylmfc9TEOnAboCvreHAA
	Lmc8F/g7HuJ8FXaCwC02o5o1ZbUFtFKTUIFKMvirMlZ/ckKAu4LczrTBQUMimuw0amfJ1Fmkewm
	LHWIxgWuao7VLn2IUPhrlP4xHaiJ99ufHDBm0nfe+Nh8DgQF0xRzW2r9Ade5Ttmg2DWMCCabZ21
	21S5szkO9MP9JDiCxLu2vr5QiiePAxDVo/ozZNBjo+H5X1ZKvszNJzXCRrx8dRzFt1MzcWnGUIx
	sFQGZoj/D+h7IbkWwHOl3k8KoQ2/5PO7mcu
X-Received: by 2002:a17:90b:1d50:b0:3a4:77b8:1770 with SMTP id 98e67ed59e1d1-3aceec709aamr9641493a91.15.1792520347817;
        Tue, 20 Oct 2026 11:19:07 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm710661a91.2.2026.10.20.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:19:07 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 4/7] selftests/bpf: libarena: Handle NMI reentrancy
Date: Tue, 20 Oct 2026 18:18:57 +0000
Message-ID: <20261020181900.6755-5-emil@etsalapatis.com>
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

An NMI can interrupt a cache operation and access the same per-CPU array.
BPF programs also only disable migration, so another task can preempt a
cache operation and run on the same CPU. Allowing the nested operation to
proceed would let it overwrite the interrupted operation's state.

Track active cache operations per CPU and reject nested access, following
the model used by the main BPF memory allocator. Claim the CPU with a
cmpxchg so that two tasks cannot both observe it as idle. An allocation
from NMI context succeeds only when the local cache can satisfy it without
taking the buddy lock.

When an NMI free cannot use the local cache, link the object onto an
intrusive deferred-free list. A later allocator operation from a safe
context drains that list while holding the buddy lock.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |   3 +
 .../libarena/include/libarena/buddy_cache.h   |   6 +
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   2 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 188 +++++++++++++++++-
 4 files changed, 189 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 9150a9d22cce..655b3f5624bf 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -51,6 +51,8 @@ struct buddy_header {
 	u32 next_index; /* Same for the next allocation. */
 };
 
+struct buddy_deferred_free;
+
 /*
  * We bring memory into the allocator 1 MiB at a time.
  */
@@ -72,6 +74,7 @@ struct buddy {
 	arena_spinlock_t lock;			/* Allocator lock */
 	u64 vaddr;				/* Allocation into reserved vaddr */
 	struct buddy_cache_state cache_state;
+	struct buddy_deferred_free __arena *deferred_free;
 };
 
 #ifdef __BPF__
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h
index 769d966686f5..cad198ac732d 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy_cache.h
@@ -43,3 +43,9 @@ struct buddy_cache_state {
 	struct buddy_cache __arena *percpu[BUDDY_CACHE_MAX_CPUS];
 	bool valid;
 };
+
+/* Per-CPU guard against nested or preempting cache operations. */
+
+struct __attribute__((aligned(64))) buddy_cache_active {
+	unsigned int value;
+};
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index 1a1856befeae..6d123ec052b0 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -44,6 +44,8 @@ __weak int test_buddy_create(void)
 		ret = buddy_destroy(&buddy);
 		if (ret)
 			return ret;
+		if (buddy.deferred_free)
+			return -EINVAL;
 		if (buddy.cache_state.valid)
 			return -EINVAL;
 	}
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index ce05e3e58eba..85d670b8762b 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -7,6 +7,7 @@
 #include <libarena/buddy_cache.h>
 
 #include <bpf_arena_spin_lock.h>
+#include <bpf_experimental.h>
 
 _Static_assert(BUDDY_CACHE_MAX_CPUS == _Q_MAX_CPUS,
 	       "buddy caches must cover every CPU arena spinlocks support");
@@ -48,6 +49,14 @@ static u64 size_to_order(size_t size);
 static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
 					int order, size_t norder);
 static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr);
+static bool buddy_deferred_free_pending(struct buddy __arena *buddy);
+static int buddy_deferred_free_complete(struct buddy __arena *buddy);
+static struct buddy_cache_active active[BUDDY_CACHE_MAX_CPUS];
+
+struct buddy_cache_ctx {
+	struct buddy_cache __arena *cache;
+	struct buddy_cache_active *active;
+};
 
 #define buddy_lock(buddy, flags) (arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
 #define buddy_unlock(buddy, flags) (arena_spin_unlock_irqrestore(&(buddy)->lock, (flags)))
@@ -62,6 +71,31 @@ static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr);
 #define DISABLE_CACHE_IF_ASAN(...)
 #endif
 
+static __always_inline int
+buddy_cache_enter(struct buddy_cache_state __arena *state,
+		  struct buddy_cache_ctx *ctx)
+{
+	unsigned int cpu;
+
+	/*
+	 * No support for cache operations from contexts that interrupted or
+	 * preempted an in-flight operation on the same CPU, just like the
+	 * kernel's BPF memory allocator.
+	 */
+	cpu = bpf_get_smp_processor_id();
+	ctx->cache = state->percpu[cpu];
+	ctx->active = &active[cpu];
+	if (cmpxchg(&ctx->active->value, 0, 1))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static __always_inline void buddy_cache_exit(struct buddy_cache_ctx *ctx)
+{
+	smp_store_release(&ctx->active->value, 0);
+}
+
 static __always_inline void __arena *
 buddy_cache_pop(struct buddy_cache __arena *cache, int order)
 {
@@ -100,18 +134,21 @@ static __always_inline int buddy_cache_push(struct buddy_cache __arena *cache,
 void __arena *buddy_cache_alloc(struct buddy __arena *buddy, size_t order)
 {
 	struct buddy_cache_state __arena *state = &buddy->cache_state;
-	struct buddy_cache __arena *cache;
-	unsigned int cpu;
+	struct buddy_cache_ctx ctx;
+	void __arena *address = NULL;
 
 	DISABLE_CACHE_IF_ASAN(NULL);
 
 	if (order >= BUDDY_CACHE_NUM_ORDERS)
 		return NULL;
 
-	cpu = bpf_get_smp_processor_id();
-	cache = state->percpu[cpu];
+	if (buddy_cache_enter(state, &ctx))
+		return NULL;
+
+	address = buddy_cache_pop(ctx.cache, order);
+	buddy_cache_exit(&ctx);
 
-	return buddy_cache_pop(cache, order);
+	return address;
 }
 
 /* Retrieve the order of an allocation from the address. */
@@ -129,9 +166,9 @@ static int buddy_cache_get_order(void __arena *addr)
 int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 {
 	struct buddy_cache_state __arena *state = &buddy->cache_state;
-	struct buddy_cache __arena *cache;
-	unsigned int cpu;
+	struct buddy_cache_ctx ctx;
 	int order;
+	int ret = 0;
 
 	DISABLE_CACHE_IF_ASAN(-EINVAL);
 
@@ -139,10 +176,13 @@ int buddy_cache_free(struct buddy __arena *buddy, void __arena *addr)
 	if (order >= BUDDY_CACHE_NUM_ORDERS)
 		return -EINVAL;
 
-	cpu = bpf_get_smp_processor_id();
-	cache = state->percpu[cpu];
+	if (buddy_cache_enter(state, &ctx))
+		return -EAGAIN;
+
+	ret = buddy_cache_push(ctx.cache, order, addr);
+	buddy_cache_exit(&ctx);
 
-	return buddy_cache_push(cache, order, addr);
+	return ret;
 }
 
 enum {
@@ -707,6 +747,7 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	if (!asan_ready())
 		return -EINVAL;
+	buddy->deferred_free = NULL;
 
 	/* Reserve enough address space to ensure allocations are aligned. */
 	ret = buddy_reserve_arena_vaddr(buddy);
@@ -777,6 +818,7 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 
 	/* Clear all fields. */
 	buddy->first_chunk = NULL;
+	buddy->deferred_free = NULL;
 
 	return 0;
 }
@@ -926,9 +968,19 @@ static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size
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
@@ -1084,6 +1136,98 @@ static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
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
+	/* Create a linked list locally. */
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
+	/*
+	 * Make a linked list by chaining the allocations into a linked list.
+	 * Possible because allocations are 16 bytes minimum and so fit a pointer.
+	 */
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
@@ -1100,12 +1244,25 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
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
+		ret = buddy_deferred_free_complete(buddy);
+		if (ret)
+			goto out_unlock;
+	}
+
+out_unlock:
 	buddy_unlock(buddy, flags);
 
 	return ret;
@@ -1127,6 +1284,11 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
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
@@ -1140,6 +1302,12 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
 		ret = ret ?: err;
 	}
 
+	/* Drain any frees stranded during an NMI. */
+	if (unlikely(buddy_deferred_free_pending(buddy))) {
+		err = buddy_deferred_free_complete(buddy);
+		ret = ret ?: err;
+	}
+
 	buddy_unlock(buddy, flags);
 
 	return ret;
-- 
2.52.0

