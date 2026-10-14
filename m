Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49024A6CF6
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020899; cv=none; b=sgGmY3XuGCIQilUUN3GJqFsrYXwB+Fa93Xc13VWhcL0+KEOI8iZZ53jQm3Y1btbWTGsdlyppCZouICBmc9Wc5lpMBVBNcB/gzniDMVwpqNS+snxIs9vHnjG9EvpBuAL+YCxVsC80bl+asMzPtK4lqYhApiUlDKmF3GNvgtiwU8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020899; c=relaxed/simple;
	bh=jUofOGxGZA3HuZ33Y4uqZnWc1VDlQ5Ma2vut94VZ8b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMT4HR0uy+1ff+CMLCELAR3RivC+g8DiTHqZ55m+YQn85jbE8WIzvPC6ICMRqDa/4VkhPmoVWeaqT5SEAQMvsq881qOJ+BVHYzyKqHqnZNpuD3/JxUG/RsdGU42dOlZXncfcUI7rxQhJGghAOS3owaSIO2uoStOd21vp+WVxp9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Kt5X0ekI; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Kt5X0ekI"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1801549a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020897; x=1792625697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3IhoDmHcfledCdyk9cR6tigyOFxbA68aFA8WohaFRs=;
        b=Kt5X0ekINs8weypi3QWYbDZ/9hewvskPIu9zmTu6m8hbJLRPxORprza/PiOJHhR8aj
         7t4s3bUflT6WVWKKvW7I/H+7m4KNRsD5bdgb2+/fwBail05UYGxtnXN1weqq6qIUBo2s
         k8qKTaLwg75Lew5r8gu6bF839Ax9x4Y5g4O8C5VBniRQbur2pJlHzWr8HvsWXcF2Frst
         AF3DVWWiYcmSm2Do8VqG/VoRxt8fFD0ym4Q8PMZaESSohw+Ug+Pf/MV5We1BrXiEmnJ2
         XgcDwv/EM3e7UZZ8kSkVUUGMxxaCW0+d0cDvmVV8dCt63H5V3DJqF1KOryUin8Nqzq4W
         Swbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020897; x=1792625697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3IhoDmHcfledCdyk9cR6tigyOFxbA68aFA8WohaFRs=;
        b=WNfTCXBHjWWDek2DW/fLq0GCwtR4Ivq5L0Tx88VIRlnSVkaSxzAO2HE/iQDQUY+Mc4
         zlVY+Gc6balgGETvQsy3lMfAQoZOv8gCNN3heQaX3uMvDzsAQbws1YUa02NJ1/qIEFH0
         vgvd6LSeCqx7+hWKTK+UwQTlK/zdurAyZZ2xQBV8pxMX8+R1oYw8c6vVdPqp/YYaB37B
         Lc+npZ9sk900koSlgpQxRD1qwdKzCWH8JY+V1bIqlI60HtygLo8bpvKtNZ5X0hCVYIrI
         FYWlVWDKQxkj4AVeTHtJRyGpvSurqhZXdG8bpesSYC8uTGvEQpMk8Gn+J1bdQ1UyoUa/
         MIng==
X-Gm-Message-State: AFq9FYJPlAokniie/WTzEO6jwmN8piFJf6TP7mz8Xfhy+2oHwgWmFYmK
	81ANjvLFa3kvrRPNMcBliQ06UoEKvnY56bSdP3F/knCDWlwY1NZj4Bp99StnXON7P8O860xyWEZ
	jQIu1
X-Gm-Gg: AYBFou2JCKBUh7dMFulHHNtkOI0ytE+x/s4Y90/QTdX5bpE/+182FK1cQ9x41db0a69
	aY1SV/Egq64l5DwTMttII37T0f6Ne+GLCzI3og8tCY/iid2fWqvOCZG7WqiWQuyufI2qJtLbs7P
	FKEZNuhzBZBWY/Me/y+j3rAe+OxAliZ30mXjj0e/XKReA8vYbfYT8PmZTgWj7UTe51RfYwK+0+K
	6MjsOHtLs1eBs1zQMq2mIZ9aoKg+wNu93EMAZux/3XDqaIqmfFswOYlWwm1nS1f42GtQu97lzz5
	BzmS5K0gqZpZfy6xd29qYuPHu6QCT3V+T3OKI0mjVEjqUWHg8QCg5E1opkIXRJWCR8jY1cmyDex
	B3sD2wzaEs1AXeFjOZQFjVG0j8+/4NOu8CwagZPgdq6kG4ngAUK86UGhuQ6yebgbB6EUlR63OUi
	Q/IsNxf1mKmXO13rBbsh+6As1oMUXrVAjBMC3AmGmZAtlWIXtj2aYcJnYQIKs/mHi8RxEq5Mcml
	griOy5NlrGk2uWK5KPW5NKIqGGAMXJe9GgG
X-Received: by 2002:a17:90b:224c:b0:3aa:f4af:1e0f with SMTP id 98e67ed59e1d1-3ab3a4875c0mr15320025a91.8.1792020896878;
        Wed, 14 Oct 2026 16:34:56 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:56 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 7/8] bpf: Synchronize arena page faults with page freeing
Date: Wed, 14 Oct 2026 23:34:41 +0000
Message-ID: <20261014233442.8392-8-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014233442.8392-1-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A fault can obtain page A, then a free/reallocation can replace it with
page B before the fault installs A in the user page table. Userspace
then sees A while BPF sees B. This also affects faults on existing pages.

Prevent the arena VM fault handler from running in parallel with arena free
operations. This is similar to the policy for file-backed mappings. Use a
per-arena reference counter to exclude faults from synchronous and deferred
page teardown, and vice versa. Faults and frees can each run concurrently
with operations of the same type.

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 123 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 07e19f406ceb..899ad275ac7f 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <linux/anon_inodes.h>
+#include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
@@ -13,6 +14,7 @@
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <linux/wait.h>
 #include <asm/tlbflush.h>
 #include "range_tree.h"
 
@@ -61,6 +63,8 @@ struct bpf_arena {
 	struct range_tree rt;
 	/* protects rt and nr_pages */
 	rqspinlock_t spinlock;
+	atomic_t opref;
+	wait_queue_head_t opwait;
 	/* number of pages currently populated in the arena */
 	u64 nr_pages;
 	struct list_head vma_list;
@@ -74,6 +78,29 @@ struct bpf_arena {
 static void arena_free_worker(struct work_struct *work);
 static void arena_free_irq(struct irq_work *iw);
 
+/* Positive references admit frees, negative references admit faults. */
+enum arena_opref {
+	ARENA_OPREF_FREE = 1,
+	ARENA_OPREF_FAULT = -1,
+};
+
+static bool arena_opref_get(struct bpf_arena *arena, enum arena_opref ref)
+{
+	int users = atomic_read(&arena->opref);
+
+	do {
+		if (users && (users ^ ref) < 0)
+			return false;
+	} while (!atomic_try_cmpxchg_acquire(&arena->opref, &users, users + ref));
+	return true;
+}
+
+static void arena_opref_put(struct bpf_arena *arena, enum arena_opref ref)
+{
+	if (atomic_fetch_sub_release(ref, &arena->opref) == ref)
+		wake_up_all(&arena->opwait);
+}
+
 /*
  * Zero flags denote an unstarted free. ZAPPED implies CLEARED, and FAILED
  * is a terminal pre-clear failure set alone. RESERVED tracks ownership
@@ -361,6 +388,8 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err_free_scratch;
 	mutex_init(&arena->lock);
 	raw_res_spin_lock_init(&arena->spinlock);
+	atomic_set(&arena->opref, 0);
+	init_waitqueue_head(&arena->opwait);
 	err = populate_pgtable_except_pte(arena);
 	if (err)
 		goto err_destroy_rt;
@@ -545,13 +574,22 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct mem_cgroup *new_memcg, *old_memcg;
 	LLIST_HEAD(pages);
-	struct page *page, *new_page = NULL;
 	struct apply_range_data data;
 	vm_fault_t fault_ret;
+	struct page *page, *new_page = NULL;
 	long kbase, kaddr;
 	unsigned long flags;
 	int ret;
 
+	if (!arena_opref_get(arena, ARENA_OPREF_FAULT)) {
+		if (vmf->flags & FAULT_FLAG_ALLOW_RETRY)
+			goto retry;
+		/* zap_pages() does not need the fault caller's mmap_lock. */
+		wait_event(arena->opwait, arena_opref_get(arena, ARENA_OPREF_FAULT));
+	}
+	/* folio_lock_or_retry() may drop the VMA lock before we release opref. */
+	bpf_map_inc(map);
+
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
@@ -569,15 +607,15 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		bpf_map_memcg_exit(old_memcg, new_memcg);
 	}
 
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
-		/*
-		 * A failed lock means a possible deadlock was detected. Don't
-		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
-		 * the fault path would re-take it on retry and deadlock. Fail.
-		 */
-		if (new_page)
-			free_pages_nolock(new_page, 0);
-		return VM_FAULT_SIGBUS;
+	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	if (ret) {
+		/* If we are deadlocking somehow, no way to ensure forward progress. */
+		if (ret == -EDEADLK) {
+			fault_ret = VM_FAULT_SIGBUS;
+			goto out_err;
+		}
+
+		goto retry_admitted;
 	}
 
 	page = vmalloc_to_page((void *)kaddr);
@@ -605,8 +643,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 
 	if (!new_page) {
 		/*
-		 * The probed page was freed meanwhile or preallocation failed;
-		 * try the non-blocking allocator, we cannot sleep here.
+		 * Preallocation failed; try the non-blocking allocator since
+		 * we cannot sleep here.
 		 */
 		new_page = bpf_alloc_page(map->numa_node, false);
 		if (!new_page) {
@@ -624,7 +662,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 			goto out_err_locked_memcg;
 		}
 		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-		goto retry;
+		goto retry_memcg;
 	} else if (ret) {
 		fault_ret = VM_FAULT_SIGBUS;
 		goto out_err_locked_memcg;
@@ -647,23 +685,42 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	page = new_page;
 	new_page = NULL;
 out:
-	page_ref_add(page, 1);
+	/* Hand fault admission over to the folio lock before returning to MM. */
+	get_page(page);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	if (new_page)
+
+	if (new_page) {
 		free_pages_nolock(new_page, 0);
-	vmf->page = page;
-	return 0;
+		new_page = NULL;
+	}
+
+	fault_ret = folio_lock_or_retry(page_folio(page), vmf);
+	if (fault_ret) {
+		put_page(page);
+	} else {
+		vmf->page = page;
+		fault_ret = VM_FAULT_LOCKED;
+	}
+	goto out_put;
 
 out_err_locked_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 out_err_locked:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+out_err:
 	if (new_page)
 		free_pages_nolock(new_page, 0);
+out_put:
+	arena_opref_put(arena, ARENA_OPREF_FAULT);
+	bpf_map_put(map);
 	return fault_ret;
 
-retry:
+retry_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
+retry_admitted:
+	arena_opref_put(arena, ARENA_OPREF_FAULT);
+	bpf_map_put(map);
+retry:
 	if (new_page)
 		free_pages_nolock(new_page, 0);
 
@@ -947,6 +1004,14 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	i_mmap_unlock_read(mapping);
 }
 
+static void wait_for_faults(struct llist_head *pages)
+{
+	struct page *page;
+
+	llist_for_each_entry(page, pages->first, pcp_llist)
+		folio_wait_locked(page_folio(page));
+}
+
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
 {
 	struct mem_cgroup *new_memcg, *old_memcg;
@@ -979,12 +1044,14 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 
 	if (!sleepable)
 		goto defer;
+	if (!arena_opref_get(arena, ARENA_OPREF_FREE))
+		goto defer;
 
 	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
 
 	/* Can't proceed without holding the spinlock so defer the free */
 	if (ret)
-		goto defer;
+		goto defer_admitted;
 
 	unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
 	if (IS_ERR(unavail_node)) {
@@ -993,8 +1060,9 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 		/* If overlapping free in progress or out of memory, defer. */
 		ret = PTR_ERR(unavail_node);
 		if (ret == -ENOMEM || ret == -EAGAIN)
-			goto defer;
+			goto defer_admitted;
 		WARN_ON_ONCE(ret);
+		arena_opref_put(arena, ARENA_OPREF_FREE);
 		bpf_map_memcg_exit(old_memcg, new_memcg);
 		return;
 	}
@@ -1009,6 +1077,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	/* drop the lock to do the tlb flush and zap pages */
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
+	wait_for_faults(&free_pages);
+
 	/* ensure no stale TLB entries */
 	flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
 
@@ -1031,16 +1101,19 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
 	if (ret) {
 		release_only = true;
-		goto defer;
+		goto defer_admitted;
 	}
 
 	ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	WARN_ON_ONCE(ret);
+	arena_opref_put(arena, ARENA_OPREF_FREE);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 
 	return;
 
+defer_admitted:
+	arena_opref_put(arena, ARENA_OPREF_FREE);
 defer:
 	s = kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCOUNT, -1);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
@@ -1133,7 +1206,12 @@ static void arena_free_worker(struct work_struct *work)
 	bool retry = false;
 	int ret;
 
+	if (!arena_opref_get(arena, ARENA_OPREF_FREE)) {
+		schedule_work(work);
+		return;
+	}
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+		arena_opref_put(arena, ARENA_OPREF_FREE);
 		schedule_work(work);
 		return;
 	}
@@ -1185,6 +1263,8 @@ static void arena_free_worker(struct work_struct *work)
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
+	wait_for_faults(&free_pages);
+
 	/* Remove stale translations before freeing the collected pages. */
 	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
@@ -1259,6 +1339,7 @@ static void arena_free_worker(struct work_struct *work)
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
 done:
+	arena_opref_put(arena, ARENA_OPREF_FREE);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 
 	if (retry)
-- 
2.52.0

