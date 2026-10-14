Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B424BAA0B
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020897; cv=none; b=C+AP0RCmrfxN7JvmKC5LQwfY4Hgqkkk0OArKdbdoTOfKnNIFoAjNZ7+tocZjlORhwacJRwLP2MykqYM3l0YuLPrQmsbAaDy4C5n98YBeVwQEVAKicX5lqyxH3Bz9WnDzU4Fj5hDawPQ/Ew2bmWp7G+gzlX2borp+C4I+TD9Hi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020897; c=relaxed/simple;
	bh=85X0Cyavw0/685TMuxjsRVdg217XQwSGC8LAqesbZxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzfDWdTD95+hyxDNFB4yXdJq2BkY1P6HwWx5ORHbk4MFecJRrMpzfJ6/WvUjAtXCrDI8xSMzHmkIn44Jou/LUl7Fjmrvw/Ju7bCGrRrzo7T3srarobqQVCKXqUEEPXn1CbMk4hkKOBUcvjBESMYhB3r/nLvMriGtsl0IbggEGgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=D4MmcSAq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="D4MmcSAq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so4000889a91.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020896; x=1792625696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSrtDIaP1E/k1u21R856pkkTkc2CYCESnbd05q2y0XI=;
        b=D4MmcSAq8Z55AtGJwZ9Ptf26VD3XAcmBEX7AjkuOUfAyAr+d53mVp8R8HNCzK/Rf4H
         aAggy3EOqGChJK5fYTrcctmxQZ3B1LMG0g9LvJUhjzk2SeV8gaRjZDoLJXbOrKzZYi1Q
         Hgos+iYULk/tZCOBPjsjy/YDzr9vY+0E94+xf5yldnQuhuKAe7RnYjUUo0DEuTNJhFTT
         HlLoCht/viB/O5IGTz4w5cgkDR+Uv/JPJxpnOa3wwsJoEusoiRlZEfCA+E5VLqtAKPx+
         6Y8nUeFjpbxiPQTBXeGd2kTf9bHnYnTg80t1Wc7Di8w+PyJ8+VigrLQ252zDjRmZgdoG
         zZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020896; x=1792625696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CSrtDIaP1E/k1u21R856pkkTkc2CYCESnbd05q2y0XI=;
        b=CaRMRkqN6E3PjfA3Obg+lAqB9C3RqZLyDGLDtaaHp3BMXlk85PgXu6c1CJShJ+67Lm
         xkBiJvCBHCYwPGZ87Xtvi9htqPUY87mHymmml2DKD68Tx0kMwT/6CtIvdpXtb7KgPPeP
         9rxXdM5H2O71cPkT4TmZiGV6ntx0gBJaMdp1VHuK66Bi1u/sj5UKbUmuvpxo1XY8bb0E
         d20r/SHnuIbONkovpm8xPYVY4mY19/AQNz/1M4sBBGPaLuYlKskWXczAKtP5rfSxxCxK
         hL8ix0OkiTELEAQGqIh9l1mIlZDGJ5gmRMLF4eQ1takFDbhETaRUGJvTaumt0rUwrO/c
         ABAQ==
X-Gm-Message-State: AFq9FYIZh9aPXVNgtqeedMxf7e8O5gshJ9e7kQQSu8QgiAXL2/MlvoqL
	7Rw50yg4re/uhdmLNdZdWttn9TbHA51WgMn+JscRrZdLpY4TYuujUIR9pzzSX0LuntY7Ak49+oY
	FxvHnWKY=
X-Gm-Gg: AYBFou2sqgczonOVEvBzXRh/KGvE79HLyVAR1bev1eoLbmFZKyMl3PBBlvjhNY08dte
	mOe44lhPomtNKnIwL9KQJGSpXjIPAx+tvlYL+r+jtZ8SPGi3n3O5MHc0GvZ+a/zF5t1LfsMvTro
	Y26R5MFJ6j2YHTKzazzH67JGuPNgp4vx+a123hkh2voK5T5OfLHDnZladTcZ0JYi45Ty7i4eb2p
	UjXnOrjTy3PFMXgLrSIGjUkNSDQyqYtruO9b69laHaJJVB6G660okOxkjCXPwehYaj+0+4llRRh
	7TT8acSVsnqNqxL20OK7aUwR9IYc78dzKKbi8PXmrEqhfi6yoXG644jMorb/dZ8YxndQc9ReLFU
	7SSrYC0oCkH5jy4dnMdLjLFXU+8sATbs54etABsJMJRLhRtSss96CTaQV7zD1Xjkgq3dwvUyJNf
	HC+942/S7vzUVC+UMCjIwCWr/qITxX0lX5NrxD3MPxyFKIdLj01LWUXSkJQgNxaUtHredripGoJ
	9NPdCJp9SRcIvhTRB+xNaohZtiBc/HXFSOw
X-Received: by 2002:a17:90b:2241:b0:3ac:9e76:aa9e with SMTP id 98e67ed59e1d1-3ac9e76adcamr94080a91.3.1792020895642;
        Wed, 14 Oct 2026 16:34:55 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:53 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [PATCH bpf-next v4 6/8] bpf: Fix arena race between page free and alloc leading to incoherency
Date: Wed, 14 Oct 2026 23:34:40 +0000
Message-ID: <20261014233442.8392-7-emil@etsalapatis.com>
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

Existing arena kfunc code has an underlying race condition
that can lead to writes being lost from the BPF program's
point of view:

a) A memory range gets freed by operation (1), and its range
is added back to the arena range tree.

b) A concurrent allocation (2) reallocates the range, and does
writes to it. Writes from that CPU may follow the stale TLB
entries into the pages that are about to be freed.

c) (1) invalidates the TLB. The old pages, and any writes done
to them, are now inaccessible. zap_pages() similarly removes the
mappings for userspace threads.

This can be triggered by particularly demanding BPF arena data
structures that constantly allocate and deallocate memory, like
hash table allocations.

Solve this ABA problem by preventing range reallocation until
TLB invalidation/unmapping is complete. First, mark the range
freed but unavailable. Afterwards, drop the spinlock and
flush the kernel TLB and zap user page tables. Then pick up
the lock again and mark the ranges as available once again,
completing the free operation.

For faults without FAULT_FLAG_ALLOW_RETRY, return VM_FAULT_NOPAGE
on an unavailable range so GUP can recheck the PTE while retaining
mmap_lock.

Reported-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 189 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 176 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 83106eed99f3..07e19f406ceb 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <linux/anon_inodes.h>
+#include <linux/bits.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/cacheflush.h>
@@ -73,10 +74,25 @@ struct bpf_arena {
 static void arena_free_worker(struct work_struct *work);
 static void arena_free_irq(struct irq_work *iw);
 
+/*
+ * Zero flags denote an unstarted free. ZAPPED implies CLEARED, and FAILED
+ * is a terminal pre-clear failure set alone. RESERVED tracks ownership
+ * independently of cleanup progress.
+ * Each span has a single owner until it is published on free_spans, so flag
+ * updates do not need atomic bit operations.
+ */
+enum arena_free_span_flags {
+	ARENA_FREE_SPAN_CLEARED = BIT(0),	/* Kernel PTEs cleared */
+	ARENA_FREE_SPAN_ZAPPED = BIT(1),	/* Kernel TLB flushed and user mappings zapped */
+	ARENA_FREE_SPAN_RESERVED = BIT(2),	/* Owns an unavailable range */
+	ARENA_FREE_SPAN_FAILED = BIT(3),	/* Freeing operation cannot continue */
+};
+
 struct arena_free_span {
 	struct llist_node node;
 	unsigned long uaddr;
 	u32 page_cnt;
+	unsigned int flags;
 };
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
@@ -600,7 +616,16 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	}
 
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
-	if (ret) {
+	/* If a range is unavailable, try again. */
+	if (ret == -EAGAIN) {
+		/* Non-retryable GUP callers recheck the PTE on NOPAGE. */
+		if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY)) {
+			fault_ret = VM_FAULT_NOPAGE;
+			goto out_err_locked_memcg;
+		}
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		goto retry;
+	} else if (ret) {
 		fault_ret = VM_FAULT_SIGBUS;
 		goto out_err_locked_memcg;
 	}
@@ -636,6 +661,19 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (new_page)
 		free_pages_nolock(new_page, 0);
 	return fault_ret;
+
+retry:
+	bpf_map_memcg_exit(old_memcg, new_memcg);
+	if (new_page)
+		free_pages_nolock(new_page, 0);
+
+	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
+		return VM_FAULT_SIGBUS;
+
+	if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		release_fault_lock(vmf);
+
+	return VM_FAULT_RETRY;
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
@@ -912,6 +950,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
 {
 	struct mem_cgroup *new_memcg, *old_memcg;
+	struct range_node *unavail_node = NULL;
 	u64 full_uaddr, uaddr_end;
 	long kaddr, pgoff;
 	struct page *page;
@@ -920,6 +959,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	struct arena_free_span *s;
 	struct clear_range_data cdata;
 	unsigned long flags;
+	bool release_only = false;
 	int ret = 0;
 
 	/* only aligned lower 32-bit are relevant */
@@ -946,7 +986,18 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set_avail(&arena->rt, pgoff, page_cnt);
+	unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+	if (IS_ERR(unavail_node)) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+		/* If overlapping free in progress or out of memory, defer. */
+		ret = PTR_ERR(unavail_node);
+		if (ret == -ENOMEM || ret == -EAGAIN)
+			goto defer;
+		WARN_ON_ONCE(ret);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		return;
+	}
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -976,6 +1027,16 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 			zap_pages(arena, full_uaddr, 1);
 		arena_put_page(page);
 	}
+
+	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	if (ret) {
+		release_only = true;
+		goto defer;
+	}
+
+	ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	WARN_ON_ONCE(ret);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 
 	return;
@@ -983,16 +1044,36 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 defer:
 	s = kmalloc_nolock(sizeof(struct arena_free_span), __GFP_ACCOUNT, -1);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-	if (!s)
+	if (!s) {
 		/*
-		 * If allocation fails in non-sleepable context, pages are intentionally left
-		 * inaccessible (leaked) until the arena is destroyed. Cleanup or retries are not
-		 * possible here, so we intentionally omit them for safety.
+		 * Directly mark the region available. Unavailable regions must
+		 * always be transient.
+		 *
+		 * Directly marking the node avialable is safe because unavailable nodes
+		 * are not modified by the range tree code without a reference to the node.
+		 * The unavailable -> available op does not touch anything in the tree apart
+		 * from the node so no need to take the lock.
+		 *
+		 * The downside is fragmentation in the tree, but this is a) safe and b) better
+		 * than leaking the range.
 		 */
+		if (release_only)
+			range_node_mark_available(unavail_node);
+
+		/*
+		 * If we haven't even zapped the pages, intentionally leave them
+		 * inaccessible (leaked) until the arena is destroyed. Cleanup or
+		 * retries are not possible here.
+		 */
+
 		return;
+	}
 
 	s->page_cnt = page_cnt;
 	s->uaddr = uaddr;
+	s->flags = release_only ? (ARENA_FREE_SPAN_CLEARED |
+				   ARENA_FREE_SPAN_ZAPPED |
+				   ARENA_FREE_SPAN_RESERVED) : 0;
 	llist_add(&s->node, &arena->free_spans);
 	irq_work_queue(&arena->free_irq);
 }
@@ -1041,6 +1122,7 @@ static void arena_free_worker(struct work_struct *work)
 	struct mem_cgroup *new_memcg, *old_memcg;
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
+	struct range_node *unavail_node;
 	u64 arena_vm_start, user_vm_start;
 	struct llist_head free_pages;
 	struct clear_range_data cdata;
@@ -1048,6 +1130,8 @@ static void arena_free_worker(struct work_struct *work)
 	unsigned long full_uaddr;
 	long kaddr, page_cnt, pgoff;
 	unsigned long flags;
+	bool retry = false;
+	int ret;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
 		schedule_work(work);
@@ -1063,23 +1147,51 @@ static void arena_free_worker(struct work_struct *work)
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
 
 	list = llist_del_all(&arena->free_spans);
-	llist_for_each(pos, list) {
+	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
+		if (s->flags)
+			continue;
+
 		page_cnt = s->page_cnt;
-		kaddr = arena_vm_start + s->uaddr;
 		pgoff = compute_pgoff(arena, s->uaddr);
+		kaddr = arena_vm_start + s->uaddr;
+
+		/*
+		 * Marking the range tree unavailable is required to avoid
+		 * reallocations through, e.g., minor page faults.
+		 */
+		unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+		if (!IS_ERR(unavail_node)) {
+			s->flags |= ARENA_FREE_SPAN_RESERVED;
+			goto clear_ptes;
+		}
+
+		ret = PTR_ERR(unavail_node);
+		/* Retry without starting teardown. */
+		if (ret == -EAGAIN || ret == -ENOMEM)
+			continue;
+
+		/* Unexpected failures leave pages for map teardown. */
+		WARN_ON_ONCE(ret);
+
+		s->flags = ARENA_FREE_SPAN_FAILED;
+		continue;
 
-		/* clear ptes and collect pages in free_pages llist */
+clear_ptes:
+		/* clear ptes and mark the span as cleared. */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
-
-		range_tree_set_avail(&arena->rt, pgoff, page_cnt);
+		s->flags |= ARENA_FREE_SPAN_CLEARED;
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
-	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
+	/* Remove stale translations before freeing the collected pages. */
 	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
+		if (!(s->flags & ARENA_FREE_SPAN_CLEARED) ||
+		    (s->flags & ARENA_FREE_SPAN_ZAPPED))
+			continue;
+
 		page_cnt = s->page_cnt;
 		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
 		kaddr = arena_vm_start + s->uaddr;
@@ -1090,7 +1202,11 @@ static void arena_free_worker(struct work_struct *work)
 		/* remove pages from user vmas */
 		zap_pages(arena, full_uaddr, page_cnt);
 
-		kfree_nolock(s);
+		/*
+		 * Used to avoid zapping twice if we fail the lock acquisition
+		 * below and rerun the span through this function.
+		 */
+		s->flags |= ARENA_FREE_SPAN_ZAPPED;
 	}
 
 	/* free all pages collected by apply_to_existing_page_range() in the first loop */
@@ -1099,7 +1215,54 @@ static void arena_free_worker(struct work_struct *work)
 		arena_put_page(page);
 	}
 
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+		llist_for_each_safe(pos, t, list) {
+			s = llist_entry(pos, struct arena_free_span, node);
+
+			/* Only unstarted frees and reserved ranges need a retry. */
+			if (!s->flags || (s->flags & ARENA_FREE_SPAN_RESERVED)) {
+				llist_add(pos, &arena->free_spans);
+				retry = true;
+			} else {
+				kfree_nolock(s);
+			}
+		}
+		goto done;
+	}
+
+	llist_for_each_safe(pos, t, list) {
+		s = llist_entry(pos, struct arena_free_span, node);
+
+		if (s->flags & ARENA_FREE_SPAN_FAILED) {
+			kfree_nolock(s);
+			continue;
+		}
+
+		if (!(s->flags & ARENA_FREE_SPAN_CLEARED)) {
+			llist_add(pos, &arena->free_spans);
+			retry = true;
+			continue;
+		}
+
+		if (s->flags & ARENA_FREE_SPAN_RESERVED) {
+			page_cnt = s->page_cnt;
+			pgoff = compute_pgoff(arena, s->uaddr);
+			/*
+			 * This range tree operation does not allocate memory,
+			 * so failures are actual bugs.
+			 */
+			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
+			WARN_ON_ONCE(ret);
+		}
+		kfree_nolock(s);
+	}
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+
+done:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
+
+	if (retry)
+		schedule_work(work);
 }
 
 static void arena_free_irq(struct irq_work *iw)
-- 
2.52.0

