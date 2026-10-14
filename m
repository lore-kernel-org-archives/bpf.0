Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F1E4DDB48
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020895; cv=none; b=oM97EkfKW0GnQZOoQQc/oy25LkTq8HScDq1Ek/lq1VefPMO0/nGvvxPzIo4pPS4BkzomKYO2p7uX57iPrUh1MNk4owlHj2/FiS8WshBddfsKHZ4s0wrRVCg28N0fkHMh8MQ1DRZayh56zd4Jksp8O9NXbcvlRHJZFiI5+Df/QRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020895; c=relaxed/simple;
	bh=RQ7sLUMHK2k6Xi8RR36XJRpRs6pJC/Luk1wN5Lrz6Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFf/N5uqjU8r/LzC3wtww3RuFaA2mEv30zpO/+Fx0pOZ0RoXGQfrD/Mu1uHHoIANvIAo+J8LnWSD8KyqDhiUzt7YVZWKKgEwYkoQ6lqYPEnVwR67z4gi4ebIluSq/Ji36ssQTH3wiupcyjjgzulrHJFdirxQHZlwG7v9zBTvVFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KxnMS06B; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KxnMS06B"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so794064a91.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020893; x=1792625693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SJPBxcR4CYcuMyk6VpCFzK8a0dm9RoaXIpoj66kciQA=;
        b=KxnMS06BJLDEaLDjlyy4jPsKOrbPOaFrkkjWpA6Ic9Qreoc4MOkiwYxRCosF1Sn4RU
         MvAPIbv4UYqivy6dYfoH3OyNsgkb/grgKThZHhIov5wv4YuwrKuh/gAtBvVt8xzm0bXH
         SGZulHXEVsFC0OrfTnNfaq/7eqtVC+FcgXmFzRhStmbYMzsO62CAs7SKcG+P7fE2hMPX
         y3PaSrpslr0SxBVBSrqLK0NpGa8ZdaMYzl9F0CmhNunXYBxVT1JGY1PLnCWXOBkp0kJh
         KtkzcmXyn3vIje+IbvFj3YDcKIiXVlXFpH44INLtddypnOOO2WINqY6ZAr91sgIw9uF2
         cvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020893; x=1792625693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SJPBxcR4CYcuMyk6VpCFzK8a0dm9RoaXIpoj66kciQA=;
        b=nbVX7lT80I2m4lKvlLqf3OIgH88vxVZq/a/9oW/WCh7uVXRAZ2SKfJA8bFaEhlTjtP
         A91m727kUcqEBy05XUSjJl0SKX/8uztYnNWp/R4YtPCai5FJ8R9RY+nXS0GojLr6lhzw
         XVkQ8WS6PXAhqcOqoaRbzKbC/l5qdZN6azRIJo1S0vtJRBfJdxL3S7KBdnquTIx2tfPZ
         8I3Aq0xc4/FkU0l9HRL61zF6tfhi7PUVxH3UyorrD8c4xdkyt2fOLcGYO5X8Nk5nUOOh
         GRjtFrAss9m0Q6xthWKe+TEOw9RU92o7Ng1sMku3B6xFMUxZI6q1X3bBSd2SFVFKbCnX
         uI1Q==
X-Gm-Message-State: AFq9FYLjlRh7qo33PiykU4dmPJNTyA6KHzrmeeqdHlMP4xfklJM1VNLb
	E6RqrEBuKbq0yvK5KehVJyhsgIRogQLDzW8wwLUTkDt+0sy0W2f4Ugnb6cTLJebRSMUfnkmBahh
	AncrY
X-Gm-Gg: AYBFou0ZhzPeg2toZBaI++VEICix+/8OHHHo2IKMgg1lLn6AGkycEMR21GiP1yJhhKv
	L7D/XMtCbxUyAP/IxVd7u0ocZosJebOqC6iNmID+ELv91ibpCNXJPsPRC26Lz9TKpOO66yUsDZs
	+AEU25koNzz6mHJUmPH9MLDzN/uplq5ZlWCF2/cX/dvlqOhbaVg82rbgZNrScFdvzf8LeIuAhrB
	qeX6MewH00XXXXE08luWCIz9ALE+07kOemQS3zZcSzDrrBnPSfEhGQsWks3TV4VQGv4aM2q20jL
	FTrE/re9Roasa1N2aQxqVIxQlRokdgcPXhbYXLcarXEp1uRV7FJj/CGoHpCONUrZOXDwtVtZ1TO
	aKkjERYgwmm9K4I2pjoNfo2bQ1uFxB11AhW7aPR+5JQv3XMhCWa02qj4w4g/HgUGBXp/J9P6JWQ
	i62dH6VkySJCh+n3SxNbrI0Zka00avw6hdqzJN66Lg0NuNxxn66iR/BR0hF8l3NQ7s7aNn3PI1A
	znoyjDqMwsRKrbGKnJQ7p67AXvtrELEiEpU
X-Received: by 2002:a17:90b:384d:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ac97bc59f6mr694212a91.14.1792020893086;
        Wed, 14 Oct 2026 16:34:53 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:50 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 5/8] bpf: Track availability information for ranges in range tree
Date: Wed, 14 Oct 2026 23:34:39 +0000
Message-ID: <20261014233442.8392-6-emil@etsalapatis.com>
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

Arena address ranges are currently encoded in a range tree: Ranges
present in the tree are free and available for allocation, while
absent ranges are allocated. However, this opens up the arena code to
subtle races between page table updates, range tree updates, and
concurrent allocations that can cause permanent inconsistencies.

Avoiding such races involves distinguishing between memory ranges that
are free and ready to be allocated, and ranges that are being freed but
should not be reused yet. Such tracking is cleanly possible through the
arena's range tree. The range tree is only consumed by arena and has no
additional future consumers, so it can be tailored towards tracking more
state. Alternatives such as deferring range freeing require more
asynchrony and per-range state tracking in the main arena code, and can
introduce additional race conditions.

Expand the tree to track whether a range present in the tree is
available for allocation. For now, all ranges are available: We add
the option to add back a range in an unavailable state, and to move
already present ranges from unavailable to available. We do not
implement other transitions, since they are not required to support
BPF arenas.

The patch adds two operations: Adding a range as unavailable, and
turning a range from unavailable to available. Unavailable ranges are
not mergable, and will be imminently be turned available by the ongoing
arena free() operation that created them. Turning ranges from
unavailable to available is a simple flag change on the range with an
optional merge with adjacent available ranges.

This diff adds -EAGAIN as a possible return value for range_tree_clear().
This is triggered by code in subsequent diffs, when there is an attempt
to use a range that has not been completely freed yet.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c      |  10 +-
 kernel/bpf/range_tree.c | 220 ++++++++++++++++++++++++++++++++++------
 kernel/bpf/range_tree.h |   7 +-
 3 files changed, 199 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 64a9001ecd68..83106eed99f3 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -340,7 +340,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err_free_arena;
 
 	range_tree_init(&arena->rt);
-	err = range_tree_set(&arena->rt, 0, attr->max_entries);
+	err = range_tree_set_avail(&arena->rt, 0, attr->max_entries);
 	if (err)
 		goto err_free_scratch;
 	mutex_init(&arena->lock);
@@ -612,7 +612,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		llist_del_first(&pages);
-		range_tree_set(&arena->rt, vmf->pgoff, 1);
+		range_tree_set_avail(&arena->rt, vmf->pgoff, 1);
 		fault_ret = VM_FAULT_SIGBUS;
 		goto out_err_locked_memcg;
 	}
@@ -870,7 +870,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 out_unmap:
 	/* Error handling: Undo partial mappings. */
 	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
-	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	range_tree_set_avail(&arena->rt, pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped)
 		arena_free_pages(arena, uaddr32, mapped, sleepable);
@@ -946,7 +946,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	range_tree_set_avail(&arena->rt, pgoff, page_cnt);
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -1073,7 +1073,7 @@ static void arena_free_worker(struct work_struct *work)
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
 
-		range_tree_set(&arena->rt, pgoff, page_cnt);
+		range_tree_set_avail(&arena->rt, pgoff, page_cnt);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 46e2dd01a353..e46f3467c3a2 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -3,6 +3,7 @@
 #include <linux/interval_tree_generic.h>
 #include <linux/slab.h>
 #include <linux/bpf.h>
+#include <linux/err.h>
 #include "range_tree.h"
 
 /*
@@ -39,8 +40,29 @@ struct range_node {
 	u32 rn_start;
 	u32 rn_last; /* inclusive */
 	u32 __rn_subtree_last;
+	bool available; /* range is available for allocating. */
 };
 
+/* Is the range available for merging? */
+static inline bool range_available(struct range_node *rn)
+{
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
+}
+
 static struct range_node *rb_to_range_node(struct rb_node *rb)
 {
 	return rb_entry(rb, struct range_node, rb_range_size);
@@ -55,20 +77,30 @@ static u32 rn_size(struct range_node *rn)
 static inline struct range_node *__find_range(struct range_tree *rt, u32 len)
 {
 	struct rb_node *rb = rt->range_size_root.rb_root.rb_node;
-	struct range_node *best = NULL;
+	struct rb_node *best = NULL;
+	struct range_node *rn;
 
 	while (rb) {
-		struct range_node *rn = rb_to_range_node(rb);
+		rn = rb_to_range_node(rb);
 
 		if (len <= rn_size(rn)) {
-			best = rn;
+			best = rb;
 			rb = rb->rb_right;
 		} else {
 			rb = rb->rb_left;
 		}
 	}
 
-	return best;
+	/* Filter unavailable ranges. */
+	while (best) {
+		rn = rb_to_range_node(best);
+		if (range_available(rn))
+			return rn;
+
+		best = rb_prev(best);
+	}
+
+	return NULL;
 }
 
 s64 range_tree_find(struct range_tree *rt, u32 len)
@@ -135,10 +167,19 @@ range_it_iter_first(struct range_tree *rt, u32 start, u32 last)
 /* Clear the range in this range tree */
 int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 {
+	u32 first = start;
 	u32 last = start + len - 1;
 	struct range_node *new_rn;
 	struct range_node *rn;
 
+	/* Scan for unavailable ranges and try again if so. */
+	while ((rn = range_it_iter_first(rt, first, last))) {
+		if (!range_available(rn))
+			return -EAGAIN;
+
+		first = rn->rn_last + 1;
+	}
+
 	while ((rn = range_it_iter_first(rt, start, last))) {
 		if (rn->rn_start < start && rn->rn_last > last) {
 			u32 old_last = rn->rn_last;
@@ -159,6 +200,7 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 			range_it_insert(rn, rt);
 
 			/* Add right-half range */
+			new_rn->available = rn->available;
 			new_rn->rn_start = last + 1;
 			new_rn->rn_last = old_last;
 			range_it_insert(new_rn, rt);
@@ -205,57 +247,153 @@ int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
 	return -ESRCH;
 }
 
-/* Set the range in this range tree */
-int range_tree_set(struct range_tree *rt, u32 start, u32 len)
+/* Do we have adjacent ranges (and do not overlap with them)? */
+static int range_get_adjacent(struct range_tree *rt, u32 start, u32 last,
+		struct range_node **leftp, struct range_node **rightp)
 {
-	u32 last = start + len - 1;
-	struct range_node *new_rn = NULL;
 	struct range_node *right;
 	struct range_node *left;
-	int err;
 
-	/* Is this whole range already set ? */
-	left = range_it_iter_first(rt, start, last);
-	if (left && left->rn_start <= start && left->rn_last >= last)
-		return 0;
+	/* Do we have a left-adjacent range ? */
+	left = start ? range_it_iter_first(rt, start - 1, start - 1) : NULL;
+	if (left && left->rn_last != start - 1)
+		return -EFAULT;
 
-	left = range_it_iter_first(rt, start - 1, start - 1);
-	right = range_it_iter_first(rt, last + 1, last + 1);
-	if (!left && !right) {
-		new_rn = kmalloc_nolock(sizeof(struct range_node),
-					__GFP_ACCOUNT, NUMA_NO_NODE);
-		if (!new_rn)
-			return -ENOMEM;
-	}
+	/* Do we have a right-adjacent range ? */
+	right = last != U32_MAX ? range_it_iter_first(rt, last + 1, last + 1) : NULL;
+	if (right && right->rn_start != last + 1)
+		return -EFAULT;
 
-	/* Clear out everything in the range we want to set. */
-	err = range_tree_clear(rt, start, len);
-	if (err)
-		goto out_free_new;
+	*leftp = left;
+	*rightp = right;
+
+	return 0;
+}
 
-	if (left && right) {
+/*
+ * Merge with adjacent available ranges if possible. The new [start, last]
+ * has already been confirmed to be adjacent with left/right by the caller.
+ */
+static int range_tree_merge(struct range_tree *rt, u32 start, u32 last,
+		struct range_node *left, struct range_node *right)
+{
+	if (range_available(left) && range_available(right)) {
 		/* Combine left and right adjacent ranges */
 		range_it_remove(left, rt);
 		range_it_remove(right, rt);
 		left->rn_last = right->rn_last;
 		range_it_insert(left, rt);
 		kfree_nolock(right);
-	} else if (left) {
+	} else if (range_available(left)) {
 		/* Combine with the left range */
 		range_it_remove(left, rt);
 		left->rn_last = last;
 		range_it_insert(left, rt);
-	} else if (right) {
+	} else if (range_available(right)) {
 		/* Combine with the right range */
 		range_it_remove(right, rt);
 		right->rn_start = start;
 		range_it_insert(right, rt);
 	} else {
-		/* No adjacent ranges; use the pre-allocated node */
-		new_rn->rn_start = start;
-		new_rn->rn_last = last;
-		range_it_insert(new_rn, rt);
+		/* No merge available. */
+		return -ENOENT;
 	}
+
+	return 0;
+}
+
+/* Make a range available, possibly merging. */
+int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len)
+{
+	u32 last = start + len - 1;
+	struct range_node *rn;
+	struct range_node *right;
+	struct range_node *left;
+	int err;
+
+	/*
+	 * Confirm the range exists is unavailable,
+	 * and fits the requested range exactly.
+	 */
+	rn = range_it_iter_first(rt, start, last);
+	if (!rn || rn->available)
+		return -EINVAL;
+
+	if (rn->rn_start != start || rn->rn_last != last)
+		return -EINVAL;
+
+	err = range_get_adjacent(rt, start, last, &left, &right);
+	if (err)
+		return err;
+
+	/* If no merging required, just make available. */
+	if (!range_available(left) && !range_available(right)) {
+		rn->available = true;
+		return 0;
+	}
+
+	/* Can merge, remove the range already. */
+	start = rn->rn_start;
+	last = rn->rn_last;
+	range_it_remove(rn, rt);
+	kfree_nolock(rn);
+
+	return range_tree_merge(rt, start, last, left, right);
+}
+
+/* Set the range in this range tree */
+static int range_tree_set(struct range_tree *rt, u32 start, u32 len,
+			  bool available, struct range_node **new_rnp)
+{
+	u32 last = start + len - 1;
+	struct range_node *new_rn = NULL;
+	struct range_node *right;
+	struct range_node *left;
+	int err;
+
+	/* Already available: nothing to change. */
+	left = range_it_iter_first(rt, start, last);
+	if (available && range_available(left) &&
+	    left->rn_start <= start && left->rn_last >= last)
+		return 0;
+
+	/* Predict whether insertion needs a new node before clearing. */
+	left = start ? range_it_iter_first(rt, start - 1, start - 1) : NULL;
+	right = last != U32_MAX ? range_it_iter_first(rt, last + 1, last + 1) : NULL;
+
+	/* Unavailable ranges cannot merge. Allocate before changing the tree. */
+	if (!available ||
+	    (!range_available(left) && !range_available(right))) {
+		new_rn = kmalloc_nolock(sizeof(*new_rn), __GFP_ACCOUNT,
+					NUMA_NO_NODE);
+		if (!new_rn)
+			return -ENOMEM;
+	}
+
+	/* Clear out everything in the range we want to set. */
+	err = range_tree_clear(rt, start, len);
+	if (err)
+		goto out_free_new;
+
+	/* Recompute adjacency: clearing may have trimmed or split nodes. */
+	err = range_get_adjacent(rt, start, last, &left, &right);
+	if (err)
+		goto out_free_new;
+
+	if (available &&
+	    (range_available(left) || range_available(right))) {
+		err = range_tree_merge(rt, start, last, left, right);
+		goto out_free_new;
+	}
+
+	/* No merge possible; transfer the reserved node to the tree. */
+	new_rn->available = available;
+	new_rn->rn_start = start;
+	new_rn->rn_last = last;
+	range_it_insert(new_rn, rt);
+	if (new_rnp)
+		*new_rnp = new_rn;
+
 	return 0;
 
 out_free_new:
@@ -263,6 +401,24 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 	return err;
 }
 
+int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len)
+{
+	return range_tree_set(rt, start, len, true, NULL);
+}
+
+struct range_node *range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
+{
+	struct range_node *rn = NULL;
+	int err;
+
+	err = range_tree_set(rt, start, len, false, &rn);
+	if (err)
+		return ERR_PTR(err);
+	if (WARN_ON_ONCE(!rn))
+		return ERR_PTR(-EINVAL);
+	return rn;
+}
+
 void range_tree_destroy(struct range_tree *rt)
 {
 	struct range_node *rn;
diff --git a/kernel/bpf/range_tree.h b/kernel/bpf/range_tree.h
index ff0b9110eb71..4f9ea2acea29 100644
--- a/kernel/bpf/range_tree.h
+++ b/kernel/bpf/range_tree.h
@@ -10,11 +10,16 @@ struct range_tree {
 	struct rb_root_cached range_size_root;
 };
 
+struct range_node;
+
 void range_tree_init(struct range_tree *rt);
 void range_tree_destroy(struct range_tree *rt);
 
 int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
-int range_tree_set(struct range_tree *rt, u32 start, u32 len);
+int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len);
+struct range_node *range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
+void range_node_mark_available(struct range_node *rn);
+int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len);
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
 s64 range_tree_find(struct range_tree *rt, u32 len);
 
-- 
2.52.0

