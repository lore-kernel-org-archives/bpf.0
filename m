Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792714867;
	b=O6ecr5uxZ4fDDewQQVvPhOaawJk5mPyJzUllgWfWlfRY1z3hIdlySYBGz5jRdA6tS7mK
	 PEK/A+cIWQ6hrm2uzJOr/fOTzGVBiTzJE3dLRGBpe75tJwoyImlWQqjQZhJXL8jKASclC
	 TlKBbyXTp5Cv73JXw9PmqxhVB0bANpcxOGiQg9bZhmWtXwOcNQWmaEXuzGjGqkrAmKIwH
	 A7LgOs8RseQgAul38l2eWk2Yvnk5EAy02+RVT9Qnwq+vIGaEpYquwjKH+JNGnndF8qX0D
	 yciui1XvP87dVxdsh5ZtginXbW7tF+sOpLur5l3GlevjGYOZpXS6fkyP/94AIuQ0WNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792714867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lu6Duy/yhK60o1J/BCoalHKY5SdRwWoSfpgVZk3Z0yY=;
	b=QWtK3Iz5EdsZVIsVYzggBOFVkCSNdLcnIGdkv1a2xpqLhDob2+Cj7L5EwWpZTMa+xW08
	 pcKPUTUDoGVcbgMvdaz3n0ESwrP4qJmcQdAtgcZ5DHcy1zBpl/3CG5q0zZB1El48djGtC
	 bzI24jRm+fi7nFZn7FJVHBs42qvPXQbsZca4c6lE8vychENkjrwiVp7FNktYRncIwPFU7
	 5fWd2eYMswS29OHc1MCN+fcug0Aqo1soKw1SyQF4KndkhLuJ3uUU9PKjobQhYHv5Y1iDU
	 VMDdT9hUMVtY9k1JL6mls+R4GJHfG5NTEcv4j5mnwSMjueJzSaD9tzIxWlpHZ9oM8Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=o534PE8O;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227ED606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 00:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 227ED606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=o534PE8O
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so131432a12.1
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 17:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792714866; x=1793319666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lu6Duy/yhK60o1J/BCoalHKY5SdRwWoSfpgVZk3Z0yY=;
        b=o534PE8Oq7whxH3Ky5+KIUj698IgnZULSagZn4Cwi7w3tjTjh4kwsGZNrhmDz+sCmp
         tMK3GG4i3Kj9ZMCO8cCZtxWoaJ75KZGXG2VVETxdZK37EJ2QbMvX4g0ku7lBohQEBU9j
         qLOOUbxS6xN9pTdcB7zOZv2BPQsiOZZ/RGdadwtnjFaEtIYyZCtRG4y6E0SLH8RSkeqX
         4MJbrPjKyqZcgnaxigkvKSthSwHzjHB9kmp1WB5Ieq7Gfm+eQHBWudY3H7KdiR9qohaJ
         e7Z2U8NUJksnJawEjhoh8veR3uB1raaL1lQRjWAfolnvZ7PCgW09hgB2OzT6X9RtQ8A1
         XQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792714866; x=1793319666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lu6Duy/yhK60o1J/BCoalHKY5SdRwWoSfpgVZk3Z0yY=;
        b=otdBfTD5zNWTVl3SQ4dr82yoQClHgih02HwTBpWMQUIT+eoR5pe6AtiaNCRs9P4zWM
         dRsO4/S5slM0jV8zPIBd/H2Qchf/dHTN0xWMNGNdDSA621ByEhl4VU6QXHe78OdYUkBN
         p+KvnZ1gFS6TcGivh/EjTjf8PoTdISWdV6PACQjD8KIXeRZCDrWZipJ/btqxEIRsGLzX
         td3OtGNGO1jAH/IQGC4F7WkH17fLNN2YVpeGnMsBxvGLA/PIRaUK4jsAD7xoetzHjePc
         snjCUQUt9Mp485m+0yOAC3Vb5AgzM40+XgQzmLeDFXf3TTqbVMO32an4mdne50MxgNSJ
         N/Bw==
X-Gm-Message-State: AFq9FYLpYVtttfvoW0XVA00AGRqM2EO4LeWCq6DGQI97Pe7tBldNlUSP
	0o3KKo2LyPRL+N1rnBXMCoQOQpEr1WDRupiHgdqG/8tY1G+7EDazHz36J7YxRHqlHTJcVnw79pu
	RokCykFMpRg==
X-Gm-Gg: AYBFou0T1E4PuPBBvk5ROyqmrIPCrk6vTv9mDOItZqrG98+HfM589WzBSZnz7A2+jCh
	YWkxlu4KoUkkWhaDtAxNlkq6DAKgufbJfTVdnr3uWqCzlpO7H+dFcbshv5NMCHjfk3aK+04abjH
	IGS3LtlCUmydDH4HXbDXthCX37q0+KLJuj3nPYyPhGnhpfUXe1Q27nOFIcYMIT9QSC5EBQppAp9
	yq+OEqFD1eVp7bG+Qp9ijm+DjZjRo3ocj+nddtsYURPS40NBDAsgkeENFzt0aLs41rJbsk9zOn8
	LuOjSRU8DQTsNz30V2g1yR1wC5WN54q9TmN16MESW/QLAmymdYv5lFlu6AOc1jxoZdyK7vI3boD
	G8FBX2L3mxbkxB+Mpug50Gz6rNq33LHe0YXw87rtkCJc3vPOJ0sQO8pSxUK9Ol1cFE61JCgYXQw
	C1NhoBqFOhmzyQWXPVO8t64rjLaO3nRhFd8+hfbQsVLor/WEfvMR3mZPqVdm+LAEMFxAWky2CyR
	RdWbW+ol4sSOyngc1uRl7eL9wOp9D5PTqLEBK6xUe5Z+8mlwvQ+cpr/hkXT0Dp2ylmTbu5NEgxK
	H9y5pFb27posMdAjMA==
X-Received: by 2002:a05:6a21:8284:b0:3e2:5d08:3022 with SMTP id adf61e73a8af0-3e2a07461fdmr2368054637.4.1792714866365;
        Thu, 22 Oct 2026 17:21:06 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8892c4sm218649a12.11.2026.10.22.17.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:21:05 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 4/7] selftests/bpf: libarena: Handle NMI reentrancy
Date: Fri, 23 Oct 2026 00:20:53 +0000
Message-ID: <20261023002056.6647-5-emil@etsalapatis.com>
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
index 769f465fded0..6f98044518ed 100644
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
@@ -752,6 +755,7 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	if (!asan_ready())
 		return -EINVAL;
+	buddy->deferred_free = NULL;
 
 	/* Reserve enough address space to ensure allocations are aligned. */
 	ret = buddy_reserve_arena_vaddr(buddy);
@@ -822,6 +826,7 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 
 	/* Clear all fields. */
 	buddy->first_chunk = NULL;
+	buddy->deferred_free = NULL;
 
 	return 0;
 }
@@ -972,9 +977,19 @@ static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size
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
@@ -1133,10 +1148,102 @@ static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr)
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
@@ -1149,12 +1256,23 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
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
@@ -1179,6 +1297,11 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
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
@@ -1191,6 +1314,10 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
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

