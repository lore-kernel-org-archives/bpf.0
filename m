Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF43A4520
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332566; cv=none; b=EgCNSnK2gBo+6YVcIZ05mbyOo1B/Q6sqXEV7sQnolC091lWfFX9v4pjSFOi3EGeuyvWhaluvHzMzeOPS4g12jBXdEc0ZvGUyhV57PC+PXjn7es11RoBfjaMh2UKR5T/ryujx+mXnOW8vcYC/BP/atkLtfZMK/binw/ISP65b3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332566; c=relaxed/simple;
	bh=aUf4T2UiZKQPezQWWfwpuyVocIfJOCuaIuImfkIg/zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhd4D/IGi+kVO+4zeBGbsHEEQpQkfzJ1z/cUFReAYlgu849AnLaauXJLd3Kl7A+gvU5WPCll4t7zSZsH9/FwqBBLserT4/5ULgJ+LEMD4DI4/NOeP6MaQbhlUeYRbrudNhWhq0jdatbwBJTF4hvJiMdnBgeob4wqnwz6ejWcTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Dl1zwzPl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Dl1zwzPl"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b3d66515so904592a91.0
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788332564; x=1788937364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vpDk/8z7B48lxCw84U87cxVPSdRf0XSWAEdoq5EF8tQ=;
        b=Dl1zwzPlztGpkc8hQDK0fjDagazEmeFsZiIZxZxOW4iWRZ2CyL7scAeXaC5e2mdDtZ
         c0QJdRsYcy9tPDue1ZNPQKFH7fOpbqBpuTwp2WFsy41RArvNMuI1iPH6FRSa4d7Wt6bX
         xgYsAqVsGyoAZQAMcLZhic9cL7UfrXYumushfY88Z4jq8uGWjoYV77teuyYcN/BxKJG6
         Oy2yqfeOC/xydO6p1Lja3LbI83XOjaRUiJMi55+qTnXpiG8jxfMAJeWFSQ73s3BHRMTl
         LNgAUCYPLnnrqU68j7eCgy3RDPpqj70rxuDVOWYu6dBX4F1WL2mN8G25iml+wwpYD+u7
         XuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332564; x=1788937364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vpDk/8z7B48lxCw84U87cxVPSdRf0XSWAEdoq5EF8tQ=;
        b=F1O3V1VGIPdAHTHqbyf/17N/lfN7ikcmTQcLLbNj/XCUPA4IyLfczCXjEA78dl9y6K
         HXjjH2LhqbLLxjSOZzy7CyJ9RxOpV6GMu6UN22lgD77LRHhAjSndxjzGSMh9g+Xf++zQ
         +NQsdZXo6B/Kp3EDhgKR2ifZ1ds/91voP59nCNOMqvqdl57h6ZZqXHFMg8yoDm7lSeYF
         HHusc9HvSB5AetX+zPL80Ael2qsx8bKj/yghYzrtqDiQ21FlAENQDconyda98fk0azMs
         zi2RQp49Gf1oP2Jsq97vfo5nMFe69QYoESto/XuZ93V8Ha5Yfkv/BNVJP6IFTCTXN1kD
         vqzw==
X-Gm-Message-State: AFuF++loJ6MeQnYXYakdvPUiiZ2kmFLi4mjgPfq7TtNaBTFgB/6PEcjG
	QS/d15RHX6RYow5mYIZhFcbGoVKXIhtit6t/wV2BAk+2r4l+deg739W5V6dlHeGvczjIJ8Yho+g
	f8kDueF4=
X-Gm-Gg: AYBFou0MK4Xl6cU0/gmpeDRuXLqOVccsYB8Np5cYO/DggccPiqFS0HTllDGY66O6bgh
	9J/QNl2kcU0HT4gZcWzP7TMIQf79tRCELQCJ2MaDTmB2dK1bxyulpCgFN3ZfxHMpVWLLrOo310x
	tQjMWshwVljO0cfvHySdgjN/jpCUzVC5xy74sAXdE/WZFpoYwcLPCtkz1NbTB/Nn14zDJ7keWa0
	vB5tnjXYyvQNmE3/psWrIa5bTXYaLr166haLfD9UwM6OFbfz1XtY2yI83cTc27+nWYYbc/VBT82
	jGor49oANgaprVSYc8VU9Wqx1IrlZX9DxCM+7MsDmu3gKOXMsC0+OE8vu9HnaEJK22ury9Pv0U9
	3aYQpjH8ysjg2Hs+rdiIwes1j0WNjXeXs1gN4mrAQRKW5kNXimP277A9tHBgI/Hfuaiedp284AG
	LlLjb51fy8Pb6Rf9mdyVifnduHE/0uYIgcLofbn55+42/PSEi5sxVMRaKK31iFVNyYXrrC4f1V/
	0MJzJ8ucDPhZVVYP1PGp5qN5Yej4fYBNQ==
X-Received: by 2002:a17:90b:2f0b:b0:398:9c00:29ed with SMTP id 98e67ed59e1d1-39aee1f5fc2mr4411267a91.21.1788332563974;
        Wed, 02 Sep 2026 00:02:43 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae05e21bcsm3793352a91.0.2026.09.02.00.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:02:43 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	nickolay.lysenko@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 2/5] bpf: Track availability information for ranges in range tree
Date: Wed,  2 Sep 2026 03:02:36 -0400
Message-ID: <20260902070239.16968-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070239.16968-1-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
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

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c      |  12 +--
 kernel/bpf/range_tree.c | 180 +++++++++++++++++++++++++++++++++-------
 kernel/bpf/range_tree.h |   4 +-
 3 files changed, 161 insertions(+), 35 deletions(-)

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
index 6f6ba718887c..515e72f054f5 100644
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
@@ -182,7 +209,8 @@ int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
 	u32 last = start + len - 1;
 	struct range_node *rn;
 
-	while ((rn = range_it_iter_first(rt, start, last))) {
+	for (rn = range_it_iter_first(rt, start, last); rn;
+			rn = __range_it_iter_next(rn, start, last)) {
 		/* Make sure the range covers the start */
 		if (rn->rn_start > start)
 			return -ESRCH;
@@ -198,23 +226,12 @@ int is_range_tree_set(struct range_tree *rt, u32 start, u32 len)
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
@@ -226,34 +243,141 @@ int range_tree_set(struct range_tree *rt, u32 start, u32 len)
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
+	}
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
 	}
+
+	left = kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO_NODE);
+	if (!left)
+		return -ENOMEM;
+	left->available = available;
+	left->rn_start = start;
+	left->rn_last = last;
+	range_it_insert(left, rt);
+
 	return 0;
 }
 
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
2.55.0

