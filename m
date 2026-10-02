Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AF47DD78
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938346; cv=none; b=NnDoXrBMQOsOL5isTmAVixuCM2bxhtN8LtqI4bEYi/1QYJxlIpHUHLovu46+Po+XQFlRV5O3yxSKSoVslMjazxIVdac/dHfImaDz//NRvN9TIecmXnouixMeL/vl5vIZ6xf5eistljGoOKFqHLDzILXOwVmXmTaX19kvBggL2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938346; c=relaxed/simple;
	bh=o4RGHZT7aJzADK5+73OJThek/iOlH+3PfokiNtsemxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk19Z7sJzoeuxtOyTQQIy/llhvulSfqF4E3d7cmyiivGfKumCiKD2iTsnZ1bTJ7fgRc0N7F8zvrTQVw7PohKF4NgXfKmWL0RuWtRNMtqlz5yFf8VG5z+m883yd5QOiQj7wNzWvjGuV2mNjRwX5cUcmxiROxf2W48Atq9utlXC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Nc3R71om; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Nc3R71om"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so45731595e9.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938343; x=1791543143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9zbei/ln8S6pfwSTXxcxvm+Js4xi/igyBAkLKJlprQ=;
        b=Nc3R71omIK/vDmZIpfLRbCUrmdrhfyGSiPNdQVLOvDwSVQiqXST613/2vD5xjpnXBa
         9usYZP4I13Dcf2dHQ2FOf4+qgIxfzgjIvfskWaSjqHpPnIv5/t1TLakb9Mzlmw0Ur437
         A/onLMqYpy60U+/qNliOps/xMSTggBRplpDydQwZ262vQ1dahsNobSIRQV+Z2sOgT/s7
         PIc54DnSowQ88aJRTovrXLe6RHVwj8xUJGJj352FKusxRJKHIZmTKkMAAQp30lsXZ8W6
         /4MWQKuqLz0P+0cVpO3Qbh1lKRIkvdx4eQQqV9vLSOTGfc8ErZFuhYTCEm5xNkgBjRvy
         1V4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938343; x=1791543143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y9zbei/ln8S6pfwSTXxcxvm+Js4xi/igyBAkLKJlprQ=;
        b=l14qFMXhVUE0C0lb+l+pAdUHQokuy292RdVswRFkASA1ef+IHhncBFioMjcx9or/Zr
         ZAL1BFmLydkf20KRgXy0xIfK7OhUQ/US0VTan7qbc2XhIgudh0Frj/DwWhRShPqEMr1F
         T9RrCu6uVD/VJQUNS8IIORvTUoinn2TYWapQdZJ1iWleLbttr8cMcs/ArJv+yUAtSXHp
         eIdkFFJcCFrscVwDGvlDaC0sixPtgrKhqEskKHb+2Tod4tSO0XSCjtrjzea4LEBd9W3C
         /+5ejo+JurqI+tiN5uGeiR+mdCb5Ftp4/KWTOuCr1yYduqkftWK3ZW5ph1WoPEjDNGCQ
         8veQ==
X-Gm-Message-State: AFuF++ld7qkJgoUA2zCXhKj2oaBwbTsqYACYG9m90PR9c4tT0S2osXVf
	vxn7pTCjF/zGVZ5d3PDBkVOoHOBpUJW9RAU0UbtA3f9sUOsl8p664TfGDE672DvNNIwZ9+tD+bq
	HYFGdQ4Y=
X-Gm-Gg: AYBFou3mRrjNGc/GAlY658IrucVPgHzCV8TAQ3wv/Vw4eWS6X84IrRwgfeOi+qOzinz
	A7boQDhaEok5Jokuf0ztLM23mPm1bGFem4iIgEyBltI3ijVTEYQ/ntDvXDzGXtjc3pR0vN6TXnh
	cHxJTzMAU7LJShXKKAMe+iprXzy8YmNJvv+SWb7gprbGgLwv1MFoJ6JDs9P3QsfP6fQJ0draEX1
	fbO5/waoQ15h7EskZJgyZX90ip/P8n0+KBr3dKnUE5seFNY0jqJamrHzGSmhw1hHSJFc2Qdj30X
	yEv7+QcEl23KzoJP28XM0b5IIES9F/0wb+ebhwzqCS6m/N7zPrEtPjwNOTNxcsgVATrUDXDuvkb
	ShkFoS8s7D6OcgEE8dboWkqB1uk/UISOPR62PFH1wmZGqiFkpjnBWTReMVGNCN0/TXWj0lmHH0D
	+AJpsR57pPl/sBawNOA8ck4CuDRT8aALo+WklUIpsFLswQ66S06Ck12InMkw==
X-Received: by 2002:a05:600d:848c:20b0:49f:ce73:7aa with SMTP id 5b1f17b1804b1-4a0276f8c54mr30199485e9.35.1790938342285;
        Fri, 02 Oct 2026 03:52:22 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm77866625e9.0.2026.10.02.03.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:52:21 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next v6 1/7] bpf: Use an llist for page allocations
Date: Fri,  2 Oct 2026 10:52:12 +0000
Message-ID: <20261002105218.6171-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002105218.6171-1-emil@etsalapatis.com>
References: <20261002105218.6171-1-emil@etsalapatis.com>
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
index 4bae3796c42f..904b539810c7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2902,8 +2902,10 @@ struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
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
index ac52f4ae414c..a5df15a6cd51 100644
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

