Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38823E00B4
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379345; cv=none; b=K+q1VTIAFIIPg5h0oM6hY1vkgeke6OBIa3edU8A2imowCdmJex/ltWjRuz+Any0gQAuZgfh1zuX/Ulz0GCXNqtmpAUvWoBA/0DyqCAOGscgmMZgkRE6r9B2ctpp/KoA41tP28OJGZ2VvEg9yncJEyEJn28FXtYRWsoo9Xwz0uRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379345; c=relaxed/simple;
	bh=FRX4AsAZP44+epYicQuFf2A18PUMWCfeU/EZ9JcZ6Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhcutYRPw5jEW7o8vIMo2oMSM0O5b2FEx3x25ZXLaGO4lLLIwJYC9dqBF63VNgi2YgyO67+jm1azjvwoHcErO92CxpT7kmFfRdZT32hL69z3k9PyUUWddcYTZbYHbo4QoefyyAPCnKxNjNsY8I5aOUsqQBmBkx9G4a1v5FGmc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=rtBzKDYY; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="rtBzKDYY"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so669249a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790379343; x=1790984143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SH6k1YwRNVBesyLby9v+HzJoiL26GCJQtM+MdOAbiQ4=;
        b=rtBzKDYY7Gge/IcvaaAMSsiWoZavyYtHWW50c4XBHLVdjBp4Ag7w4dtFnpKgzjfGet
         6hNNIZAyul5FlXYegrtoqcP8vHY2LMFRv3nW2ptEWg7eYL9i8KzS/KEXkDCKzNKX01YZ
         9RbHTWTqbhpSmfBPuJLj9ikHxbemGT/SUbI5EwM4SqqRMeNO+bxfX27W/YMUHrc37v28
         dwtP4mX0D1b+b6ytUiLoqfIRh+CmdlvigWTkrFIPQlD9w8fhypu46kVUetPEBmhcY5xq
         Wb4XhvqpQt+eclJcrOjAw2ACH5vQ7Se6oiuSx4dniuVMFPL7aZuAxjpURZGQtd0jSNAk
         BHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379343; x=1790984143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SH6k1YwRNVBesyLby9v+HzJoiL26GCJQtM+MdOAbiQ4=;
        b=R5DYvyynaxezN1NZgEWSN2r6yjY2xtNKUnUgDvJZozU3wW7Hk0bE0/2a/z4fJE6R9q
         NN3AKFjJ14y2wm04icW8eePVTREqMnAvWhDbV7tJqniL6V4jYI/H4aHPmZWfyq2zNm5K
         gZ0JxwLEQbKiqMkkQGBJAwIbJMdfjAkdJt++Hl8zq7XjMBBBXlMPkM/FWD6lmD3tS5mF
         +CLvTUu5TZmozpFxA2Cpt/PdaEobuph8kyssdSHYxcW6BEwyGnJzMbZkfIso4NA94s2l
         mNhghjkvGRvzxr+EvxqfJmw0OAbcs0JJvqEEVYWJLzyIhoRJ3iLMVhtLrK/kHOlLMorv
         VhCw==
X-Gm-Message-State: AFuF++lsAr8lVydsvm2L5T3ju7KSbzfeu5BWgE0fbrW5J+rSI/ZyyutC
	bhhPw2EDv3zrmQtvL5qGs5UGqLTzumwXuoMaq4toY8pT6s6t5x4QVcmcfDTsgS9HVtQWao4W8+2
	n7lSqR+k=
X-Gm-Gg: AYBFou3/GkevvpJ7kDy4z6eubPtGrlBfwDkeZ3ebm3v91ZPEwKz7yzresrb5UKTjUUF
	5HsZkmc+RPc0CC5nig/ZD33KecKOmNTJjVkrtLgr/fsgfb8Ae3EZKGiajH2Umb8OAjuzTdtAKUK
	jbmq0KKQsr6WsyVrJiUeKSQm+wXwHPKXR4mtygW5jATypBQXU+oXaFhXogY7VEcvmm7yj9MZsI3
	ZWNtKPu9aFcAS20tQ0197NFRD/sfqRucglpu3ffl8SFiGIGgFlOTdMxdmL7OCVedH5rPR5zelIu
	vIZjFf54xYt426VKmMdwnl6JXfSaVJHTIDBREYsNpZlS4pjS8Vr0rtgZxNaO293Z1oMv9UA6HgR
	QaN5uUaPNbGJL+zg9XE71GnJy6wquxlR8M6LsqeTQfGdosU3Rw0AWJOvgJyZX43a8GOUWzkgQ4f
	cZwiIYDceRebUmRYVXPQOka4Ekm6ROnSfOrr06qjmHnX71TMPLCm2OCMtgKBa82dHUub8B57fgP
	G2JggTM8xF7GC+K+0K+ToeUiiXE/rLbd/N9w2dkNg==
X-Received: by 2002:a17:90b:48c1:b0:39e:4c7f:8b19 with SMTP id 98e67ed59e1d1-3a098d3b06cmr6761360a91.30.1790379342881;
        Fri, 25 Sep 2026 16:35:42 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm5790436a91.15.2026.09.25.16.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:35:42 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 1/7] bpf: Use an llist for page allocations
Date: Fri, 25 Sep 2026 23:35:32 +0000
Message-ID: <20260925233538.5708-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925233538.5708-1-emil@etsalapatis.com>
References: <20260925233538.5708-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_map_alloc_pages() does not use its map argument. Storing allocated
pages in an array also forces arena callers to allocate a separate
pointer array.

Expose the single-page allocator as bpf_alloc_page(), rename the bulk
helper to bpf_alloc_pages(), and return bulk allocations through an
llist using page->pcp_llist. Add bpf_free_pages() to safely release all
pages remaining on such a list.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h  |  6 ++-
 kernel/bpf/arena.c   | 95 +++++++++++++++++++-------------------------
 kernel/bpf/syscall.c | 39 ++++++++++--------
 3 files changed, 67 insertions(+), 73 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7c5e203eddd..52242d88cb51 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2884,8 +2884,10 @@ struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
 
-int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
-			unsigned long nr_pages, struct page **page_array);
+struct page *bpf_alloc_page(int nid);
+int bpf_alloc_pages(int nid, unsigned long nr_pages,
+		    struct llist_head *pages);
+void bpf_free_pages(struct llist_head *pages);
 #ifdef CONFIG_MEMCG
 void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
 			 struct mem_cgroup **new_memcg);
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index c6369ea5e208..de4f7c7f68f5 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -146,7 +146,7 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
 
 struct apply_range_data {
 	struct bpf_arena *arena;
-	struct page **pages;
+	struct llist_head *pages;
 	int i;
 };
 
@@ -158,13 +158,17 @@ struct clear_range_data {
 static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 {
 	struct apply_range_data *d = data;
+	struct llist_node *node;
 	struct page *page;
 	pte_t pteval;
 
 	if (!data)
 		return 0;
 
-	page = d->pages[d->i];
+	node = READ_ONCE(d->pages->first);
+	if (WARN_ON_ONCE(!node))
+		return -EINVAL;
+	page = llist_entry(node, struct page, pcp_llist);
 	/* paranoia, similar to vmap_pages_pte_range() */
 	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
 		return -EINVAL;
@@ -197,6 +201,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 		return -EBUSY;
 	set_pte_at(&init_mm, addr, pte, pteval);
 #endif
+	WARN_ON_ONCE(llist_del_first(d->pages) != node);
 	d->i++;
 	WRITE_ONCE(d->arena->nr_pages, d->arena->nr_pages + 1);
 	return 0;
@@ -312,8 +317,8 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	INIT_WORK(&arena->free_work, arena_free_worker);
 	bpf_map_init_from_attr(&arena->map, attr);
 
-	err = bpf_map_alloc_pages(&arena->map, NUMA_NO_NODE, 1, &arena->scratch_page);
-	if (err)
+	arena->scratch_page = bpf_alloc_page(NUMA_NO_NODE);
+	if (!arena->scratch_page)
 		goto err_free_arena;
 
 	range_tree_init(&arena->rt);
@@ -481,7 +486,9 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct mem_cgroup *new_memcg, *old_memcg;
+	LLIST_HEAD(pages);
 	struct page *page, *new_page = NULL;
+	struct apply_range_data data;
 	vm_fault_t fault_ret;
 	long kbase, kaddr;
 	unsigned long flags;
@@ -543,8 +550,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		 * The probed page was freed meanwhile or preallocation failed;
 		 * try the non-blocking allocator, we cannot sleep here.
 		 */
-		ret = bpf_map_alloc_pages(map, map->numa_node, 1, &new_page);
-		if (ret) {
+		new_page = bpf_alloc_page(map->numa_node);
+		if (!new_page) {
 			fault_ret = VM_FAULT_SIGBUS;
 			goto out_err_locked_memcg;
 		}
@@ -555,12 +562,14 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		fault_ret = VM_FAULT_SIGBUS;
 		goto out_err_locked_memcg;
 	}
-	struct apply_range_data data = {
-		.arena = arena, .pages = &new_page, .i = 0
-	};
+	llist_add(&new_page->pcp_llist, &pages);
+	data.arena = arena;
+	data.pages = &pages;
+	data.i = 0;
 
 	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
+		llist_del_first(&pages);
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
 		fault_ret = VM_FAULT_SIGBUS;
 		goto out_err_locked_memcg;
@@ -716,13 +725,12 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	u64 kern_vm_start = bpf_arena_get_kern_vm_start(arena);
 	struct mem_cgroup *new_memcg, *old_memcg;
 	struct apply_range_data data;
-	struct page **pages = NULL;
-	long remaining, mapped = 0;
-	long alloc_pages;
+	LLIST_HEAD(pages);
+	long mapped = 0;
 	unsigned long flags;
 	long pgoff = 0;
 	u32 uaddr32;
-	int ret, i;
+	int ret;
 
 	if (node_id != NUMA_NO_NODE &&
 	    ((unsigned int)node_id >= nr_node_ids || !node_online(node_id)))
@@ -741,15 +749,9 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	}
 
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
-	/* Cap allocation size to KMALLOC_MAX_CACHE_SIZE so kmalloc_nolock() can succeed. */
-	alloc_pages = min(page_cnt, KMALLOC_MAX_CACHE_SIZE / sizeof(struct page *));
-	pages = kmalloc_nolock(alloc_pages * sizeof(struct page *), __GFP_ACCOUNT, NUMA_NO_NODE);
-	if (!pages) {
-		bpf_map_memcg_exit(old_memcg, new_memcg);
-		return 0;
-	}
 	data.arena = arena;
-	data.pages = pages;
+	data.pages = &pages;
+	data.i = 0;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
 		goto out_free_pages;
@@ -767,45 +769,28 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 	if (ret)
 		goto out_unlock_free_pages;
 
-	remaining = page_cnt;
 	uaddr32 = (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
 
-	while (remaining) {
-		long this_batch = min(remaining, alloc_pages);
-
-		/* zeroing is needed, since alloc_pages_bulk() only fills in non-zero entries */
-		memset(pages, 0, this_batch * sizeof(struct page *));
-
-		ret = bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages);
-		if (ret)
-			goto out;
+	ret = bpf_alloc_pages(node_id, page_cnt, &pages);
+	if (ret)
+		goto out;
 
-		/*
-		 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
-		 * will not overflow 32-bit. Lower 32-bit need to represent
-		 * contiguous user address range.
-		 * Map these pages at kern_vm_start base.
-		 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
-		 * lower 32-bit and it's ok.
-		 */
-		data.i = 0;
-		ret = apply_to_page_range(&init_mm,
-					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
-					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);
-		if (ret) {
-			/* data.i pages were mapped, account them and free the remaining */
-			mapped += data.i;
-			for (i = data.i; i < this_batch; i++)
-				free_pages_nolock(pages[i], 0);
-			goto out;
-		}
+	/*
+	 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
+	 * will not overflow 32-bit. Lower 32-bit need to represent
+	 * contiguous user address range.
+	 * Map these pages at kern_vm_start base.
+	 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
+	 * lower 32-bit and it's ok.
+	 */
+	ret = apply_to_page_range(&init_mm, kern_vm_start + uaddr32,
+				  page_cnt << PAGE_SHIFT, apply_range_set_cb, &data);
+	mapped = data.i;
+	if (ret)
+		goto out;
 
-		mapped += this_batch;
-		remaining -= this_batch;
-	}
 	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	kfree_nolock(pages);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return clear_lo32(arena->user_vm_start) + uaddr32;
 out:
@@ -819,7 +804,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 out_unlock_free_pages:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 out_free_pages:
-	kfree_nolock(pages);
+	bpf_free_pages(&pages);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return 0;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 74496fd716d3..80cae0979c23 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -602,7 +602,7 @@ static bool can_alloc_pages(void)
 		!IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
-static struct page *__bpf_alloc_page(int nid)
+struct page *bpf_alloc_page(int nid)
 {
 	if (!can_alloc_pages())
 		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
@@ -613,27 +613,34 @@ static struct page *__bpf_alloc_page(int nid)
 				0);
 }
 
-int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
-			unsigned long nr_pages, struct page **pages)
+void bpf_free_pages(struct llist_head *pages)
 {
-	unsigned long i, j;
+	struct llist_node *node;
+	struct page *page, *tmp;
+
+	node = llist_del_all(pages);
+	llist_for_each_entry_safe(page, tmp, node, pcp_llist)
+		free_pages_nolock(page, 0);
+}
+
+int bpf_alloc_pages(int nid, unsigned long nr_pages,
+		    struct llist_head *pages)
+{
+	unsigned long i;
 	struct page *pg;
-	int ret = 0;
 
 	for (i = 0; i < nr_pages; i++) {
-		pg = __bpf_alloc_page(nid);
-
-		if (pg) {
-			pages[i] = pg;
-			continue;
-		}
-		for (j = 0; j < i; j++)
-			free_pages_nolock(pages[j], 0);
-		ret = -ENOMEM;
-		break;
+		pg = bpf_alloc_page(nid);
+		if (!pg)
+			goto free_pages;
+		llist_add(&pg->pcp_llist, pages);
 	}
 
-	return ret;
+	return 0;
+
+free_pages:
+	bpf_free_pages(pages);
+	return -ENOMEM;
 }
 
 static int btf_field_cmp(const void *a, const void *b)
-- 
2.52.0

