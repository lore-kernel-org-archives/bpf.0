Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB74A0928
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190705; cv=none; b=pQbqkzv0QShIFaKbHuocGVXtnmGAYgcUV26oEiF3Ap9radLB3MMLokB4GnreNBPcnqeSmweDEGtuYPAiaDnbRzdjPSOeTACcilo4E18h5m3Soa7GgzC+XteKULShcuENmlp4GRS1cgZry5aU5cODFtruzHG8f7/JK42wdT88isc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190705; c=relaxed/simple;
	bh=Z7c/w9iRH3ZMpar/4oRDraqZ1XJSLhz0IdJCVy+5M58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1gJauP/VphOivqp21fqROfn68j3OZnmZtdAFyBZeqVdH8wpQjs1TnXI1lF9zwNREP4hDE3uEzV026xMrEbl4Xl5q82So2Inbiw1RazqaqgirQs+NrV7TcHOl/rZ4khE9/8hys4r+ywLFlanPaXctIYE3vIGLpU/mmJn4tGZ7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=hVdahgOy; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="hVdahgOy"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so8912785e9.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790190701; x=1790795501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WzhVmk6DR3mwewQwGZTvTSK4SarOwYhabwzSmF2exlc=;
        b=hVdahgOyiI7nXXkwexGQrwfdIOrH/v3JRIDC5yZYxYR9UJ2LLBOg1GkwX8VUf47d//
         +BN/gb3E0crvsRwtY14z1MhO+cSd7Fiq06K0sgHLkdgI9dTWxLFTub5tQdPVbrEuQYUV
         gya5GxnyF9zxb5TptqWavqJJ3hRuq17hcZC9cQbY/6dIH2ZAKCXY9b00V94fEgFrQ1Mj
         jdKsVRyZqa+l05xb41pPJyZ4ROfDmtuLLPitrlE3hsno+CCZDClYZI7DU61CpXuc3l/5
         TlXeLrc5O1VnbGs+TgGZOwMx77iTmunX3+vuUHEwM5We7yFzvAeoj3Hs2WeUmX8R8EZS
         x4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190701; x=1790795501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WzhVmk6DR3mwewQwGZTvTSK4SarOwYhabwzSmF2exlc=;
        b=imguTFQduvDdYRtaxKToGMYCgyT+C+eSymd+76dRvjF8SmW8tPIx33xgvT8HhiyUeh
         yN1JulyMSGyKuOoarJzTrjRG4uH4zyoyQFYY8Qd41FUfhapkYH2kWczQoeUUX7w0TWpW
         hFF/jy2t3B50X3ag1Tpp7y/ALktUxLcn5xZF9nUm4i83QF7sL9lZTlVLxPy0kEPl0Ktz
         tgIzJUQEUUIXOt7s4t5K/k6Z1nUCY2jwK2/uKEMKTlSxrhF64xZAhxx3/xY1iHRlIvBB
         5Nwc0pCiElQhjSAVw6y29l5RqDRMFe3CcxU9Yione63KaPH3p4hmEljG5mDRYyulR9Yh
         1T0g==
X-Gm-Message-State: AFuF++m0eTBg7SStPRcoopFd1jPGFlM2BP/xN4Z8g32rKBW/RA9hLweS
	BYTQ9EwV0scALgY5IxhsyF+MaxcVRo8u385riczyyc+SA65+VbUDasMOm8hVOFK6I+/hJPnWhK0
	RODoTLeEAjw==
X-Gm-Gg: AYBFou0/qUJKjA6FiZ8AIN7DXSNZY93GajKCFwJ0gfZ0J/Bafr++Xxh9/mJSh7MWUef
	NhV94lbjQkaVCRDVupO5GGDD16xqI/c0wUBdrlI+XjFfWeqK6wHczRwqH0IHdv0KevefKGrbl2H
	e0rxryfC1xdx72sZ1X+KISW+AJHsasEWZxmhBHkBxj/aKzjtkq3JkBWG3eHMhPtnxBSpv8sSPs/
	LXu36rLZbV43SVgc4dX+fuulU/bWXpvNFPicn+/htAeKRrF2agqjJbCobqTvLRGtCzmKSjN0aJM
	/pjP0tTc+GDhoN8HKwd0IheexiTRYO0mjGpTvTjRk8Po0Ecx6trhzeEgZELsdJe0IAJqqripLpU
	57E2muwHaTGSlO2vH53KvT/kDRvstcfSxw5JMv9uUFDVVO5zbad9Aqwu/+HO59+XFyz4pkKOPbd
	yIUxZrXhdARoP9O7hFUL1Hq+Q5NlcKw9Qc3sxcOMkkqk72C1CJ4OLL3kSS584+kXo/DeMCoQ==
X-Received: by 2002:a05:600c:8411:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49fe66ef334mr2573535e9.25.1790190700834;
        Wed, 23 Sep 2026 12:11:40 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:2f89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886877a2a5sm9473563f8f.26.2026.09.23.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:40 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 2/6] bpf: Track availability information for ranges in range tree
Date: Wed, 23 Sep 2026 19:11:21 +0000
Message-ID: <20260923191125.5311-3-emil@etsalapatis.com>
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
 kernel/bpf/arena.c      |  10 +--
 kernel/bpf/range_tree.c | 177 ++++++++++++++++++++++++++++++++++------
 kernel/bpf/range_tree.h |   4 +-
 3 files changed, 158 insertions(+), 33 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c6369ea5e208..197ac3df68c7 100644
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
@@ -561,7 +561,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 
 	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
-		range_tree_set(&arena->rt, vmf->pgoff, 1);
+		range_tree_set_avail(&arena->rt, vmf->pgoff, 1);
 		fault_ret = VM_FAULT_SIGBUS;
 		goto out_err_locked_memcg;
 	}
@@ -809,7 +809,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
-	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
+	range_tree_set_avail(&arena->rt, pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (mapped) {
 		flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
@@ -924,7 +924,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	range_tree_set_avail(&arena->rt, pgoff, page_cnt);
 
 	init_llist_head(&free_pages);
 	cdata.arena = arena;
@@ -1051,7 +1051,7 @@ static void arena_free_worker(struct work_struct *work)
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
2.52.0

