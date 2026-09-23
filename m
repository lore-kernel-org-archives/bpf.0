Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC143F8A7
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144079; cv=none; b=Rmatgcn9RlCLngddiD70Hwu+PKiezWrspTo3nEKQpr9z3xUG7rkkxI6URfBgHfsyDLOAgbUmGl+s2XKva2WuJGAE6U9KuTA+WTc2Wp7AXNp1+i2Qh/i+9LiKvMWfLVJuHnuURAHfzEu0MA6pVzsTQQ+gRW9+fLg4nD1jIzcEN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144079; c=relaxed/simple;
	bh=c1lEwNzjkUh/zE3xCzTroY1bVQmgOfPDSnoDyZxvuZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QomOpnLFsA0eSMc+4pitK5glQWNPEhzip9MrNH1WJHzEDtxDtcV+XC4eB0HXXHNrLXycrxg6C98tig2WwCDevHvct4a0uimB8BKWaWNL1xlxgCCBQnPm9DdCus6K/w3AGEUnM4Dcdsie/ErICom3SEJbbyR/+MGh5wqONVosO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=TSGP+tca; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="TSGP+tca"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so383710a91.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790144071; x=1790748871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ysCKswnh2tGvmKdF3Re8uZrhsAK6d7LMtZqv5irn70I=;
        b=TSGP+tcaPEc3VACyPvBWrs3V0d4MDFPVUkHZxOSvaJDY33VPtC3wYyr7F+GkdToLyn
         g7QYEZrEMCXfdf4ikdy3cvL3ixC37XzGRWHGcx4K/FeTYXPLUKPWJc/dg7FSC3lixES7
         DGWSz89lcWr4qxHUNE39GjTIAmAPPBWinbOmP7APdVUCIIjzQ/vWZhOFg4vL6Lp61ain
         /GQR0PyKRpL8tN9A9rsc/BU96kP8paHhKjZDEwCYze1yNDO2IkDPvmO1rCB26DGQlFdY
         3hR5cUHMj/jo9fjFJYBfzQDe1PYjA1hO4k1moP+KAKpLgrCEJAfZFA5MwjYCE5VaYDZe
         OZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144071; x=1790748871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ysCKswnh2tGvmKdF3Re8uZrhsAK6d7LMtZqv5irn70I=;
        b=OxXQal6rqPjVblbkPGfvlLHIe9UnyjeIvws8IKom5rBGynC/BwrcfdWcNWN61itLXK
         BX2U9xY03IaXHqHWncn3VtBaae6xQ+S/ze9uaJ3nW1K1UjhZ/ZVh4QQR1P+DV+Y4AvA6
         BtmgL/PjQowyKwalKqFxpA9BTX8pLEtn1aTVVRzePYZ+xyad8gHLDATk+UPCQe/vvAY5
         q5+3AeAIqxQ/g/cvj2Hxbx7Dpva6jQxpfPTrSw98bU2qGFJyHZCfazgtLg17cTAHae7I
         P6/wlT0oYxiSgPRSxuEbgv3iEbGZM1qEB3JmPFPOrqUTQf6uaFZ4ZKY+F9dOChqQJ68b
         TFCA==
X-Gm-Message-State: AFuF++njMwNSaEL5VI8aCCKTS0W34a1gc1InDXyjqT9YhVlOHykCYUtZ
	Uc7q+RR8JZUU5/ShATJ2IaTH8rGJdUQPrmJYbkjMkJTGy7QULtIe0iRCm5Q6cf7IzhZVNbVVjFJ
	7tRgW
X-Gm-Gg: AYBFou1v47kZxE3mc5I5f4LGVLdTbYhScEGB+zwLPzh3tjCXV0Kame2JGsilxh8ZiUD
	/M4ocPQF7KI5FQp3/5lWp9a5lvU9N7VyZ0jBj4kFK9Xd+kiAygWKZ0EkKHFrZkApypFFPAkn/wd
	2pN+ISZbBqcF7PPz8p7418RL1xXilh/6zJ0Rw4ox16Io02dOYCQ5r3sBuacIypIRSEvJJKycB1d
	qpeLp888G3MYEuVktn7T6HyLusJL2uM3a3Vrwhq8xECcq3y7+KBIT3NAod+t3o9Rz+AWA5MxEun
	e0wYGgOSn56MH7TqTwgazPz+CJU0gWAHskCR7OTiMnciLSWefG9rOkmQcIrBwPQSbycpL8E+QE7
	nawgqMGI7Je57Isgq9iwwV0Xs9bn5fCN2eQc/HajyPQytpEBHHPupQvw3/rMElwmYraR1DLhOJm
	eIK9l4i/1P610F5EvziNPwTvgLSwScnaSEJBZJBAfFsTBG2LHkqoNi3+lpWztYshIgrzMrv9KNp
	Dh8Ff3WV9RI6QDyOJm5OiJzFvYVZRzhQ+4teDz4Pg==
X-Received: by 2002:a17:90b:1344:b0:3a0:2ffd:1a54 with SMTP id 98e67ed59e1d1-3a07e516d89mr1543831a91.9.1790144070700;
        Tue, 22 Sep 2026 23:14:30 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de57682sm3562652a91.16.2026.09.22.23.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:14:30 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykola Lysenko <nickolay.lysenko@gmail.com>
Subject: [PATCH bpf-next v2 3/7] bpf: Fix arena race between page free and alloc leading to incoherency
Date: Wed, 23 Sep 2026 06:14:21 +0000
Message-ID: <20260923061425.7045-4-emil@etsalapatis.com>
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
Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 128 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 118 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index f49b52fa8586..8bb011aae604 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -76,6 +76,7 @@ struct arena_free_span {
 	struct llist_node node;
 	unsigned long uaddr;
 	u32 page_cnt;
+	bool release_only;
 };
 
 u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
@@ -513,6 +514,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		goto out_sigsegv_memcg;
 
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
+	/* If a range is unavailable, try again. */
+	if (ret == -EAGAIN) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+
+		goto retry;
+	}
+
 	if (ret)
 		goto out_sigsegv_memcg;
 
@@ -542,6 +551,17 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 out_sigsegv:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	return VM_FAULT_SIGSEGV;
+
+retry:
+
+	/* Only for special cases (GUP/device drivers). */
+	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
+		return VM_FAULT_SIGBUS;
+
+	if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		release_fault_lock(vmf);
+
+	return VM_FAULT_RETRY;
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
@@ -855,6 +875,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	struct arena_free_span *s;
 	struct clear_range_data cdata;
 	unsigned long flags;
+	bool release_only = false;
 	int ret = 0;
 
 	/* only aligned lower 32-bit are relevant */
@@ -881,7 +902,19 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	if (ret)
 		goto defer;
 
-	range_tree_set_avail(&arena->rt, pgoff, page_cnt);
+	ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+	if (ret) {
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
@@ -911,6 +944,16 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
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
@@ -928,6 +971,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 
 	s->page_cnt = page_cnt;
 	s->uaddr = uaddr;
+	s->release_only = release_only;
 	llist_add(&s->node, &arena->free_spans);
 	irq_work_queue(&arena->free_irq);
 }
@@ -977,12 +1021,14 @@ static void arena_free_worker(struct work_struct *work)
 	struct llist_node *list, *pos, *t;
 	struct arena_free_span *s;
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
@@ -992,28 +1038,57 @@ static void arena_free_worker(struct work_struct *work)
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
+		ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
+		if (ret) {
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
@@ -1024,8 +1099,6 @@ static void arena_free_worker(struct work_struct *work)
 
 		/* remove pages from user vmas */
 		zap_pages(arena, full_uaddr, page_cnt);
-
-		kfree_nolock(s);
 	}
 
 	/* free all pages collected by apply_to_existing_page_range() in the first loop */
@@ -1034,7 +1107,42 @@ static void arena_free_worker(struct work_struct *work)
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
-- 
2.54.0

