Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD5442B09
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144081; cv=none; b=A4psasCf2T0TP3XINNqFrWSlnVzap3YhzN273oskZH9NKZuWZTWLi6u8UPQIount5Jcwd9xOkIwUJSxHvUjdYsxhOzpYwAnw095XKLW6p9oTceOnUFp9x0RVv64YwfnMQFBgRwJHO0gT9smz68yUPCrA1vB04nexJjipS/c+YDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144081; c=relaxed/simple;
	bh=HQEoUFSRkDwo3mIuZncleieykvTm3519HX87sXc86FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/n5QeuBYwNIHOxfVxSmlV6Yi7BoPxMw41mikx/2x7ufj7NPuNHEhnqeMr47VUz5NhliTR/ITnN1TMW7aYri80bW/3D7Ld3y4UU4M4lWFdSD0j+FnQhQXpT37X95EiEGwOz456tmT1Ek2vAdvLHJcuPcjrKme4vlV/PANK5+hec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=K+KFmsKK; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="K+KFmsKK"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398c066106cso349218a91.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790144070; x=1790748870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ownvmNvG9hG7pOJ8SQ6E2wH+OAqpxy4dMiSZ+cKCUc=;
        b=K+KFmsKKo/WH174SBGtrt+N8X5vOA/DnNmjj1tNsGbvc8dGb53xGLehpZwvfE8RCDS
         BK8A8uBwiNb0xN0v4ZxtzqyiaHYtoF11RW6incsnHJLuZNIeyjAzdPtTOjKksLZsooY2
         SSKDsDuB0VnRDr7u9VmGRqvhRDTzwPrrl3TUIUcr1oJDt1LdfzHpYOLCxlmsU2muY78P
         XcnsmlpoVrcJlzYOsivkC3rr3Iz9SxyfDxuQKHDZWXuHGr0XHZLKpLUbS0tNu6SVT7xT
         v1zDWm86P6oSrg5WiBBdX0toC2BypAy9fe8vBt+/iBqwPhzUMSKx1PQIFSWcOCmgeTh4
         KM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144070; x=1790748870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ownvmNvG9hG7pOJ8SQ6E2wH+OAqpxy4dMiSZ+cKCUc=;
        b=LyZB62Y1UPtmNOnj93PB7yjziwfcmGm0eIifxnJG95l/GryflDXUKdNRcWOGrL3SK/
         10qOT+anokVmRLu7+a1SjBRvPGsLvhb7QIrmMGBgNp22180QgS6rX75S5+Mo9KaXN4np
         Q1EOz5ed3/p/IbPLTAubTCQxKAUBl7PoedY85Hw+mA86NFnRDuvglOym02yAv1LnKMHA
         ZhIrawpdOcTVg/Dp+ouO0rts955lrKLukk3zZIYw6OFukCHNWgV95bBUWswL/ToYEP+D
         X97TXXHQTiwKW7ysDPZWFh76iQ+aXHZZc1Eah9ciuumF+yJutFjk4zURFdQJqnr9WhJX
         jeBA==
X-Gm-Message-State: AFuF++ksiGdDAWHbUuHb/qFQU2Qq1kd0d7O1gUOsnbJZoJZz5U19QBTF
	2Qgddd/VweSaAICLRXnR4m4qtOFZoVEfLa80f8Xix2iLgiRPVqX682ans36Kd0BR7fgPUAKVZdL
	p9/4E
X-Gm-Gg: AYBFou1dLrb2qcxXYvnLOAnqF/IwKGESmjYe2r31EuoVXWr46YllMqCkkFQguOsCEyN
	UZ6rw9sUIzs0x7ErGK71B0wyqTFwj+TKxXpGCXkRj7XqS4EG6YQ0MdWo4FCMc3rcUlx/g76GG4s
	GBHdNv52olu9eVPRXMwj9HUB22GG/Gj1ljqXYvFCf2imDo0nz2wHiNEtdPoOItwanYOE2hBK1Ht
	AHGzWWZR6SkV4YU4+FpmcRU8qRuPWG0imXl69oRvK5zruvmgFvwbrX2CGz6mKgKt6Jx4dizHQnA
	OOW4NgfFc1LlFCB8mmJ+6Die08hhJdsd9KWBxmLMh5bCa0BNyG4Oyg9m/1xTDjUNPgY7/hddlML
	FlCzMGhz1+X6TON/GDX+xFFO73VxqcV8tkHA/XdzrpeiQct8Fs6m+uOZM7ftUpx1ynFmK9wZE1a
	hhH4QYQkLubcnWCl4qFGo1tlcEmPZKv5P8F8JGW0x6kfZAHaX0ZlIe9wppl4tUuBooTE0om0M9R
	4Ig+XV70CrPTfFjvU2GkUtHaRkt5Ljw23s+6crnyYwYc1F85+eg
X-Received: by 2002:a17:90b:258b:b0:39d:f66e:1720 with SMTP id 98e67ed59e1d1-3a07e54e52fmr1476264a91.13.1790144069770;
        Tue, 22 Sep 2026 23:14:29 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de57682sm3562652a91.16.2026.09.22.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:14:29 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 2/7] bpf: Track availability information for ranges in range tree
Date: Wed, 23 Sep 2026 06:14:20 +0000
Message-ID: <20260923061425.7045-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923061425.7045-1-emil@etsalapatis.com>
References: <20260923061425.7045-1-emil@etsalapatis.com>
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
 kernel/bpf/arena.c      |  12 +--
 kernel/bpf/range_tree.c | 177 ++++++++++++++++++++++++++++++++++------
 kernel/bpf/range_tree.h |   4 +-
 3 files changed, 159 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b43..f49b52fa8586 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -317,7 +317,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err_free_arena;
 
 	range_tree_init(&arena->rt);
-	err = range_tree_set(&arena->rt, 0, attr->max_entries);
+	err = range_tree_set_avail(&arena->rt, 0, attr->max_entries);
 	if (err)
 		goto err_free_scratch;
 	mutex_init(&arena->lock);
@@ -520,13 +520,13 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
-		range_tree_set(&arena->rt, vmf->pgoff, 1);
+		range_tree_set_avail(&arena->rt, vmf->pgoff, 1);
 		goto out_sigsegv_memcg;
 	}
 
 	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
-		range_tree_set(&arena->rt, vmf->pgoff, 1);
+		range_tree_set_avail(&arena->rt, vmf->pgoff, 1);
 		free_pages_nolock(page, 0);
 		goto out_sigsegv_memcg;
 	}
@@ -766,7 +766,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	range_tree_set_avail(&arena->rt, pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped) {
 		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
@@ -881,7 +881,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	range_tree_set_avail(&arena->rt, pgoff, page_cnt);
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -1008,7 +1008,7 @@ static void arena_free_worker(struct work_struct *work)
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 					     apply_range_clear_cb, &cdata);
 
-		range_tree_set(&arena->rt, pgoff, page_cnt);
+		range_tree_set_avail(&arena->rt, pgoff, page_cnt);
 	}
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index fdf7ba7aefe0..456db58650bd 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -39,8 +39,15 @@ struct range_node {
 	u32 rn_start;
 	u32 rn_last; /* inclusive */
 	u32 __rn_subtree_last;
+	bool available; /* range is available for allocating. */
 };
 
+/* Is the range available for merging? */
+static inline bool range_available(struct range_node *rn)
+{
+	return rn && rn->available;
+}
+
 static struct range_node *rb_to_range_node(struct rb_node *rb)
 {
 	return rb_entry(rb, struct range_node, rb_range_size);
@@ -55,20 +62,30 @@ static u32 rn_size(struct range_node *rn)
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
@@ -135,10 +152,19 @@ range_it_iter_first(struct range_tree *rt, u32 start, u32 last)
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
@@ -153,6 +179,7 @@ int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
 						NUMA_NO_NODE);
 			if (!new_rn)
 				return -ENOMEM;
+			new_rn->available = rn->available;
 			new_rn->rn_start = last + 1;
 			new_rn->rn_last = old_last;
 			range_it_insert(new_rn, rt);
@@ -199,23 +226,12 @@ int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
 	return -ESRCH;
 }
 
-/* Set the range in this range tree */
-int range_tree_set(struct range_tree *rt, u32 start, u32 len)
+/* Do we have adjacent ranges (and do not overlap with them)? */
+static int range_get_adjacent(struct range_tree *rt, u32 start, u32 last,
+		struct range_node **leftp, struct range_node **rightp)
 {
-	u32 last = start + len - 1;
 	struct range_node *right;
 	struct range_node *left;
-	int err;
-
-	/* Is this whole range already set ? */
-	left = range_it_iter_first(rt, start, last);
-	if (left && left->rn_start <= start && left->rn_last >= last)
-		return 0;
-
-	/* Clear out everything in the range we want to set. */
-	err = range_tree_clear(rt, start, len);
-	if (err)
-		return err;
 
 	/* Do we have a left-adjacent range ? */
 	left = range_it_iter_first(rt, start - 1, start - 1);
@@ -227,34 +243,141 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
 	if (right && right->rn_start != last + 1)
 		return -EFAULT;
 
-	if (left && right) {
+	*leftp = left;
+	*rightp = right;
+
+	return 0;
+}
+
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
-		left = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO_NODE);
-		if (!left)
-			return -ENOMEM;
-		left->rn_start = start;
-		left->rn_last = last;
-		range_it_insert(left, rt);
+		/* No merge available. */
+		return -ENOENT;
 	}
+
 	return 0;
 }
 
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
+static int range_tree_set(struct range_tree *rt, u32 start, u32 len, bool available)
+{
+	u32 last = start + len - 1;
+	struct range_node *right;
+	struct range_node *left;
+	int err;
+
+	/* Is this whole range already set ? */
+	left = range_it_iter_first(rt, start, last);
+	if (left && left->rn_start <= start && left->rn_last >= last &&
+	    range_available(left) && available)
+		return 0;
+
+	/* Clear out everything in the range we want to set. */
+	err = range_tree_clear(rt, start, len);
+	if (err)
+		return err;
+
+	/* Get adjacent ranges and check for overlaps. */
+	err = range_get_adjacent(rt, start, last, &left, &right);
+	if (err)
+		return err;
+
+	/*
+	 * If the range is not available for allocation, don't merge.
+	 * Unavailable ranges are in the process of being freed and should
+	 * be imminently marked available, so merging them with other
+	 * unavailable ranges will just lead to splitting the range back
+	 * almost immediately.
+	 */
+	if (available) {
+		err = range_tree_merge(rt, start, last, left, right);
+		if (!err)
+			return 0;
+	}
+
+	left = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO_NODE);
+	if (!left)
+		return -ENOMEM;
+	left->available = available;
+	left->rn_start = start;
+	left->rn_last = last;
+	range_it_insert(left, rt);
+
+	return 0;
+}
+
+int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len)
+{
+	return range_tree_set(rt, start, len, true);
+}
+
+int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
+{
+	return range_tree_set(rt, start, len, false);
+}
+
 void range_tree_destroy(struct range_tree *rt)
 {
 	struct range_node *rn;
diff --git a/kernel/bpf/range_tree.h b/kernel/bpf/range_tree.h
index ff0b9110eb71..aa27edf451bc 100644
--- a/kernel/bpf/range_tree.h
+++ b/kernel/bpf/range_tree.h
@@ -14,7 +14,9 @@ void range_tree_init(struct range_tree *rt);
 void range_tree_destroy(struct range_tree *rt);
 
 int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
-int range_tree_set(struct range_tree *rt, u32 start, u32 len);
+int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len);
+int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
+int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len);
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
 s64 range_tree_find(struct range_tree *rt, u32 len);
 
-- 
2.54.0

