Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61CC5592E5
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190709; cv=none; b=bKPPfRdIZMJQvei3blsZDMCSw0N+PWtE7w2Lw1Md3E2PZrWqM5XocGTvIVeTmvaKEA8yGX14pVeEeLw4QAGR50xUNzGk9HczVsBc+F7g59XG7BGFUFnfgIO7wieRBDQnIxvMrWDG3c1TJbcQ5uA5bb9t+YQcEZy4q0BgnkU+xNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190709; c=relaxed/simple;
	bh=hLFI4CFxCL2iSbtIVUXUhXMd1In57vSDVSEqXAQy6/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKoN3KgYTkhqL0hEMApTZ+UeAmiC5bUfQlJ959rFaXQ7YlQH0wR4QZ3yZGgLTDAJY8Z0lYfTV8mnwX0BTFbJZV9JqmJI+HchMd/W5AhGqW5LzRzP4O54LYWgQCrQcYzRE1yFbGGwa6xkBcPbVonFuXdZLbBqRU+l9iNoeMSpVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MWXEgPPF; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MWXEgPPF"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485b1d2874fso545160f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790190705; x=1790795505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SMVFKkaEKJ+ZyTp7/yZ/k0F2Qa778nhhy9DOdbB+tFk=;
        b=MWXEgPPFUZfTzs4+ai5KeKHAVzLLkoXS9GggZxl+z431xSe8eHQu33VG0eXZKer+Rd
         IYEdYTXNaH37DYM934talXRvCJjfHER8kvXaEnwmWc9L/7Yg5KK3FKJ6PE6UkcxcuxMe
         67+ODH0qCOUQmxzGRE7cZFM/cAI6QDSg2w/nkqB2BGCUAFevzPu/mGSXeU8RxiT1amzz
         rOepgtuDA6XLIJXtYsR9EDeCDffznFzAR2HcsJzrfEF1Mtv/y0egiCYAouDuBwcLLJcn
         nGRk3u2a9SwmxyMwKf0VPvgZO5Ggcl/Eyd6IwRVSSVLEXlON++V7OzXhXG6panJVEK/7
         DRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190705; x=1790795505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SMVFKkaEKJ+ZyTp7/yZ/k0F2Qa778nhhy9DOdbB+tFk=;
        b=VdEyeHWGEFvAJEJw6yXZbqzIRN8Mu8qNOaW8N36Qha/7WSwdzjM1OZGSvDAXLxDeLr
         pfN+f6WZ4h++SyG3Tn0whOu2ydUAO27Ozz979p4kUv7FShDzzoFhTYdfRYs9qnZ32Wfo
         cWomIjFQcssBEyd6EZe3C820P9Flqam9QBFvpiYfWn20gBYDY4YqPg9q01dmPUBLzRSe
         nhUKVqYoeFfrkf/txqGnCjw24kspc5yU0FQ7tQVN4kbLwCPN/EZeD05PpVldhd70FJ2I
         2qOrV86pVIH12SupHkzy2fwf1knVjN5cwvI+FdLP9w80H2PQ8+bzTkCHv0s5hh7wYTL0
         K6Rw==
X-Gm-Message-State: AFuF++kp+rvWvNhwO2f+Ir4jcdNt+RcgfYFj+heuUfCZaa0ATNEG1YQQ
	lyD/V/nUapuGP+64G0PLO7fpbwinPEKd9D4f5Jtq4UXoG+uHXo+TP8WP0IFgReL1uRSmxVn4/zk
	8WupouRpx+w==
X-Gm-Gg: AYBFou0TbQWVrWAkUa7Tpvt9CHRbGM7Ao7QBvMWjCGUfjfdUqR46gsWQkvQCnNp9pig
	EjXQUdOOM0HXKYgyCOK5eAN4fnTJvs4xpo2IhJZP8DwRFju6FkuLM57/NbKv0j48q8ZPz1kiuGN
	DW7ockKVEKGqW1gI+COpxEItrHXzGFzc4YJlZ401Dp73uH0LarLNM0JmWaQr1Zj10ZX/gotyL94
	hE0dSuScFYwU+vqrJ23CWHPeIBwpF6vd4qWUkyH5eSLF/CcamNdWJfFP3sG32GSBGjcyVd6YL4r
	7cTBhWd153ersmpL4Ea416OgSmUdH23JJ1ZhdQXbpb1rJqMrQ5ymB2BhkUfweohevxYC/lhfZB8
	fe6aLfV9YAqVg9KEZHZkmBiXe/TZpichS1YcYqtOjjhqLtbYr4GnRBZBKUnomb9tg8X8Dtdd6NJ
	oAJz0bpvy0sdlNrFBASQQ4gy6t7QoyALLptOjZJtjedw0djfa8qP/8OvELTq2/
X-Received: by 2002:a05:6000:2211:b0:485:8ea0:da8c with SMTP id ffacd0b85a97d-488716c6d66mr204145f8f.16.1790190704584;
        Wed, 23 Sep 2026 12:11:44 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2f89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2a5sm9473563f8f.26.2026.09.23.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [PATCH bpf-next v3 3/6] bpf: Fix arena race between page free and alloc leading to incoherency
Date: Wed, 23 Sep 2026 19:11:22 +0000
Message-ID: <20260923191125.5311-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923191125.5311-1-emil@etsalapatis.com>
References: <20260923191125.5311-1-emil@etsalapatis.com>
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

Reported-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c      | 156 ++++++++++++++++++++++++++++++++++++----
 kernel/bpf/range_tree.c |  36 ++++++++--
 kernel/bpf/range_tree.h |   5 +-
 3 files changed, 176 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 197ac3df68c7..9df4c74ff171 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -76,6 +76,7 @@ struct arena_free_span {
 	struct llist_node node;
 	unsigned long uaddr;
 	u32 page_cnt;
+	bool release_only;
 };
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
@@ -551,7 +552,11 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	}
 
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
-	if (ret) {
+	/* If a range is unavailable, try again. */
+	if (ret == -EAGAIN) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		goto retry;
+	} else if (ret) {
 		fault_ret = VM_FAULT_SIGBUS;
 		goto out_err_locked_memcg;
 	}
@@ -585,6 +590,19 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
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
@@ -890,6 +908,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
 {
 	struct mem_cgroup *new_memcg, *old_memcg;
+	struct range_node *unavail_node = NULL;
 	u64 full_uaddr, uaddr_end;
 	long kaddr, pgoff;
 	struct page *page;
@@ -898,6 +917,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	struct arena_free_span *s;
 	struct clear_range_data cdata;
 	unsigned long flags;
+	bool release_only = false;
 	int ret = 0;
 
 	/* only aligned lower 32-bit are relevant */
@@ -924,7 +944,20 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set_avail(&arena->rt, pgoff, page_cnt);
+	unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+	if (IS_ERR(unavail_node)) {
+		ret = PTR_ERR(unavail_node);
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		/*
+		 * For -EAGAIN: An overlapping fault reserves
+		 * the range before installing its PTE.
+		 */
+		if (ret == -ENOMEM || ret == -EAGAIN)
+			goto defer;
+		WARN_ON_ONCE(ret);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		return;
+	}
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -954,6 +987,16 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 			zap_pages(arena, full_uaddr, 1);
 		__free_page(page);
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
@@ -961,16 +1004,33 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
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
+		 * always be transient, and a permanent one breaks the assumptions
+		 * made in the allocation/faulting code. The operation is safe because
+		 * unavailable nodes are not modified by the range tree code without a reference
+		 * to the node. The modification from unavailable to available also does
+		 * not require touching anything in the tree apart from the node itself,
+		 * so it can be done locklessly. The downside is fragmentation in the tree,
+		 * since we cannot merge with neighbors, but this is a) safe and b) better
+		 * than leaking the range.
 		 */
+		if (release_only)
+			range_node_mark_available(unavail_node);
+
+		/*
+		 * If we haven't even zapped the pages, intentionally leave them
+		 * inaccessible (leaked) until the arena is destroyed. Cleanup or
+		 * retries are not possible here, so we intentionally omit them for safety.
+		 */
+
 		return;
+	}
 
 	s->page_cnt = page_cnt;
 	s->uaddr = uaddr;
+	s->release_only = release_only;
 	llist_add(&s->node, &arena->free_spans);
 	irq_work_queue(&arena->free_irq);
 }
@@ -1019,13 +1079,16 @@ static void arena_free_worker(struct work_struct *work)
 	struct mem_cgroup *new_memcg, *old_memcg;
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
+	struct range_node *unavail_node;
 	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages;
+	struct llist_head free_pages, teardown_spans;
 	struct clear_range_data cdata;
 	struct page *page;
 	unsigned long full_uaddr;
 	long kaddr, page_cnt, pgoff;
 	unsigned long flags;
+	bool retry = false;
+	int ret;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
 		schedule_work(work);
@@ -1035,28 +1098,58 @@ static void arena_free_worker(struct work_struct *work)
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	init_llist_head(&free_pages);
+	init_llist_head(&teardown_spans);
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
 
 	list = llist_del_all(&arena->free_spans);
-	llist_for_each(pos, list) {
+	llist_for_each_safe(pos, t, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
-		kaddr = arena_vm_start + s->uaddr;
 		pgoff = compute_pgoff(arena, s->uaddr);
 
+		if (s->release_only) {
+			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
+			WARN_ON_ONCE(ret);
+			kfree_nolock(s);
+			continue;
+		}
+
+		kaddr = arena_vm_start + s->uaddr;
+
+		unavail_node = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+		if (IS_ERR(unavail_node)) {
+			ret = PTR_ERR(unavail_node);
+			/* Kick off another attempt at the end of this call. */
+			if (ret == -EAGAIN) {
+				llist_add(pos, &arena->free_spans);
+				retry = true;
+				continue;
+			}
+
+			/*
+			 * An -ENOMEM failure is the same failure mode as in
+			 * the defer: path of arena_free_pages(). Do not treat
+			 * the leak as a bug.
+			 */
+			if (ret != -ENOMEM)
+				WARN_ON_ONCE(ret);
+
+			kfree_nolock(s);
+			continue;
+		}
+
 		/* clear ptes and collect pages in free_pages llist */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
-
-		range_tree_set_avail(&arena->rt, pgoff, page_cnt);
+		__llist_add(pos, &teardown_spans);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
-	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
-	llist_for_each_safe(pos, t, list) {
+	/* Keep ranges unavailable until their stale translations are gone. */
+	llist_for_each_safe(pos, t, READ_ONCE(teardown_spans.first)) {
 		s = llist_entry(pos, struct arena_free_span, node);
 		page_cnt = s->page_cnt;
 		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
@@ -1067,8 +1160,6 @@ static void arena_free_worker(struct work_struct *work)
 
 		/* remove pages from user vmas */
 		zap_pages(arena, full_uaddr, page_cnt);
-
-		kfree_nolock(s);
 	}
 
 	/* free all pages collected by apply_to_existing_page_range() in the first loop */
@@ -1077,7 +1168,42 @@ static void arena_free_worker(struct work_struct *work)
 		__free_page(page);
 	}
 
+	if (!llist_empty(&teardown_spans)) {
+		if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
+			llist_for_each_safe(pos, t, __llist_del_all(&teardown_spans)) {
+				s = llist_entry(pos, struct arena_free_span, node);
+				s->release_only = true;
+				llist_add(pos, &arena->free_spans);
+			}
+
+			schedule_work(work);
+			bpf_map_memcg_exit(old_memcg, new_memcg);
+			return;
+		}
+
+		llist_for_each_safe(pos, t, __llist_del_all(&teardown_spans)) {
+			s = llist_entry(pos, struct arena_free_span, node);
+			page_cnt = s->page_cnt;
+			pgoff = compute_pgoff(arena, s->uaddr);
+			/*
+			 * This range tree operation does not allocate memory,
+			 * and so should never fail regardless of contention
+			 * or memory pressure. This is in contrast to regular
+			 * inserts that _can_ fail under memory pressure and
+			 * force us to defer the free.
+			 */
+			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
+			WARN_ON_ONCE(ret);
+			kfree_nolock(s);
+		}
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	}
+
 	bpf_map_memcg_exit(old_memcg, new_memcg);
+
+	/* Retry if any region was unavailable for free. */
+	if (retry)
+		schedule_work(work);
 }
 
 static void arena_free_irq(struct irq_work *iw)
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 456db58650bd..9472cf1bc26d 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -3,6 +3,7 @@
 #include <linux/interval_tree_generic.h>
 #include <linux/slab.h>
 #include <linux/bpf.h>
+#include <linux/err.h>
 #include "range_tree.h"
 
 /*
@@ -45,7 +46,21 @@ struct range_node {
 /* Is the range available for merging? */
 static inline bool range_available(struct range_node *rn)
 {
-	return rn && rn->available;
+	/* Pairs with smp_store_release() in range_node_mark_available(). */
+	return rn && smp_load_acquire(&rn->available);
+}
+
+/*
+ * Mark a node as available. Designed to be used locklessly
+ * as a last-ditch effort to avoid leaking unavailable range
+ * tree nodes when all attempts to directly or indirectly
+ * free an arena region has failed. See arena_free_pages()
+ * for more info.
+ */
+void range_node_mark_available(struct range_node *rn)
+{
+	/* Pairs with smp_load_acquire() in range_available(). */
+	smp_store_release(&rn->available, true);
 }
 
 static struct range_node *rb_to_range_node(struct rb_node *rb)
@@ -321,7 +336,8 @@ int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len)
 }
 
 /* Set the range in this range tree */
-static int range_tree_set(struct range_tree *rt, u32 start, u32 len, bool available)
+static int range_tree_set(struct range_tree *rt, u32 start, u32 len, bool available,
+			  struct range_node **new_rn)
 {
 	u32 last = start + len - 1;
 	struct range_node *right;
@@ -364,18 +380,28 @@ static int range_tree_set(struct range_tree *rt, u32 start, u32 len, bool availa
 	left->rn_start = start;
 	left->rn_last = last;
 	range_it_insert(left, rt);
+	if (new_rn)
+		*new_rn = left;
 
 	return 0;
 }
 
 int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len)
 {
-	return range_tree_set(rt, start, len, true);
+	return range_tree_set(rt, start, len, true, NULL);
 }
 
-int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
+struct range_node *range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
 {
-	return range_tree_set(rt, start, len, false);
+	struct range_node *rn = NULL;
+	int err;
+
+	err = range_tree_set(rt, start, len, false, &rn);
+	if (err)
+		return ERR_PTR(err);
+	if (WARN_ON_ONCE(!rn))
+		return ERR_PTR(-EINVAL);
+	return rn;
 }
 
 void range_tree_destroy(struct range_tree *rt)
diff --git a/kernel/bpf/range_tree.h b/kernel/bpf/range_tree.h
index aa27edf451bc..4f9ea2acea29 100644
--- a/kernel/bpf/range_tree.h
+++ b/kernel/bpf/range_tree.h
@@ -10,12 +10,15 @@ struct range_tree {
 	struct rb_root_cached range_size_root;
 };
 
+struct range_node;
+
 void range_tree_init(struct range_tree *rt);
 void range_tree_destroy(struct range_tree *rt);
 
 int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
 int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len);
-int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
+struct range_node *range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
+void range_node_mark_available(struct range_node *rn);
 int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len);
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
 s64 range_tree_find(struct range_tree *rt, u32 len);
-- 
2.52.0

