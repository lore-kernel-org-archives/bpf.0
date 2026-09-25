Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01784446C0C
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368786; cv=none; b=LpF0kiFOtAmZ9q9IRdzrTVrItG1ANLGdFDWKpHWIhhE0zqRdBNoMOa6GHoZClNvPtQoVqAoQAvzIaSQJH04rnpT/zLFXYw5yh3dF6fdbtdRx5GDYaSwNpqJ0XXoNiw9nel0CknJYqOZvH3jLLCaRarAuN0wewG8husPZ4+oBdno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368786; c=relaxed/simple;
	bh=FRX4AsAZP44+epYicQuFf2A18PUMWCfeU/EZ9JcZ6Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXcpAdRpvkBAv7P1Y8k9MOLX57A5Vb/YkxWF9DqBjDOK5tIFXZCoL5NmRxq+2UTEo1d7ES5/XAtt3hJIUbr9sEuPeHROID6xZeqYOR4QmTTZDHohHyn3ZyCJARLRcTIquigHiHJmKN1tkExWYqmGJcwTbyacRn5hGM8JY5i09Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=zx5YDoSu; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="zx5YDoSu"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0d2c37b0bso252781a91.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790368784; x=1790973584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SH6k1YwRNVBesyLby9v+HzJoiL26GCJQtM+MdOAbiQ4=;
        b=zx5YDoSuL6F11nHTA3gfKaVnixbKkcvDo9mnbUH6Yz5IGhMrcIccbJ9cXKSOAEe23V
         5t1cgrzqqC0fLhgSWqtxo0XdmHGcQ6Jy/OvuprDVlcT9fXA6M0wD9uf/vgsw+oHF3X86
         StUitfnk75t4btkdP0dPU1c6Ky7ORTfaXINU5Dh4DNZLNlZ1v6b3enjsznlI9NI20+jF
         YvW4T3oB+UAVEb79X1/EjEya3fmyj7WL2LdGO5REkILupHcFsqyYYWo/306U9OZEhZmr
         YdClAfIlZ3QxbualmVetWSgOud+PYX1zDiVHHU5HUfSEDxH3xY7LPXK2ob1pwzFgfK1X
         LC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368784; x=1790973584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SH6k1YwRNVBesyLby9v+HzJoiL26GCJQtM+MdOAbiQ4=;
        b=opdxP1NZSfJV4cMUJIlUc6rJRADEYzGIBiCyWwH/HUv9zhK8I1b6sVNFANOPOZIFY8
         aU+SzOkDkGGqV0Obsd415xUaeQOaYC+MRhl61ETkBolSP4b87YTcBtDeff7yThZsKJYU
         yToQOqKuheJ7rtb8tGs5TniMtLvDubxjkn32mS9hvwEIbBfvwsS0MYLKZpIPPv8EhOi2
         cOCyschSZjZSNtuso8Jr62wBMmA6BeowI8KXauNM/hea4JWaKkDzZZhbWQZvqK9fyGU9
         i41WKu1SsjZAUhqBVJSFdhQaX857my65hit6RTiZhFxTmQDFLdNM3S6anSm5TIGd32Wd
         Ws5A==
X-Gm-Message-State: AFuF++nYTgxabMyMKzJdHrfgtGmtGXKUIvdibsRyf/lcTGL9ZZkV4HOu
	CoHpADh6oyzRR/g2eKnTwXNGCmQI8hicQH+RHmmL5PWB6rxhQJa2vBESaEuMjOHAdHVbH61xoOY
	F2IBu3wE=
X-Gm-Gg: AYBFou3n+GDUtnUyT4gPXv9hLSe1OmgRg276c2oUITG8TMo+cYTwmvVzsnltkMr5kt0
	qXhAyew9qW3yuEqqHkWOlS4dMNU9yGOx5KTddP4R9cU6TxPnO9KkBw1k07BcE8xd4Vz+mrku7cS
	bzK6J9pvA4b3u7WUOpetGIwNFnY5zbawOmQdl/wgndcNw6iryZItVktNHTF9c3jxifH4dv5H+U1
	4eudFw/M9bhi7xEtfAP732nh0wlbUFVEDevbIOe7Nqyka3uS5eApKPwBZOo8UfkytkAvX/IEEu1
	hrGOItShkeCKdrx0IZ8L1ZYu0ub0KKKP7cLoV3m4JoaQTHXuDmbL+Yv9WmnmIqFGdlX+I1XDwdZ
	st2blb0zmSKLHx6AvYL6t4+m1TEE/3oLq+lAlyMmbU7MkdqIOXNFLzMtVR0ekvwLfFQ35rKsKsi
	Mu1EPTdKY8RwHFR4ln2C56Gy8czc6otnLwsyxsVLkoWttAGh4uvMlK77/QqhBQvhUlmuplupPXs
	iQjsnSdmXbQXzfQ3ap7PCzQKNwzON4kHwX1k28SIA==
X-Received: by 2002:a17:90b:5107:b0:3a0:d823:c750 with SMTP id 98e67ed59e1d1-3a0d823cb37mr506834a91.49.1790368783989;
        Fri, 25 Sep 2026 13:39:43 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm5955125a91.8.2026.09.25.13.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:39:43 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 1/7] bpf: Use an llist for page allocations
Date: Fri, 25 Sep 2026 20:39:33 +0000
Message-ID: <20260925203939.4105-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925203939.4105-1-emil@etsalapatis.com>
References: <20260925203939.4105-1-emil@etsalapatis.com>
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

