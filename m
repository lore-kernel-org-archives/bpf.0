Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D003B6368;
	Mon, 27 Apr 2026 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287072; cv=none; b=K3QHX9QYUQgiUpsI7NYzSosbp4SwSH1C/3TidQRimgzIUPgQWFlm8b06sGE7vFpmXl05TyaOXDdRfmo3Q1SbkdebD5++EUQQ+1xBHTBPBGZBiwf1FeGNE72E5oXKWHsGFRMhMz0yqYQSelswGD44aXoes+Ljfwyb7YVL/v6+Ki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287072; c=relaxed/simple;
	bh=PMWtPfjETpBzRux4YmorOUiKgOzzBGMvg39wevj5sBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns2WymZmzoLFPogcCN9kQqv00dnSNN6I2IZBifw/D0yuPAo2WvmckYTXrI/WfuVM8644PqKVDuwJxZpp79bkRNZYSYbeXV5gPQ5KhMBI+BwIR1yisKWC8hgtbenO/NmhE1SO8izfl1vi1RRRlAJrkCjwwZpQsA14Oqeq5m1s7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdO663s5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdO663s5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCB0C2BCB4;
	Mon, 27 Apr 2026 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287072;
	bh=PMWtPfjETpBzRux4YmorOUiKgOzzBGMvg39wevj5sBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VdO663s5pTmAz3tWA6JTROy97JiQxyT/mnaW+iCmrFaSWnfx+Xw3LtU9Og5o9Yg5g
	 SNUBxMrv1QhSQqSsfq6fBJVsX9j/XZ0NtswLZ1wchr5IDwJvYYsNDDVW/CjcIGNOuY
	 ZNWyS47jVqiwrfErbw+4cSOtw73EJiSWbVH2YxGsTBxVbxXT/zA3FlDqDKdJyrMsBP
	 Fos7+8AIGR3Zejm9U/3KHVizn9tQlMQWOPVXdGG5N+fsp2KTvzSB7LCqP2SLL1vs9H
	 u0xX0/Bm69Cd4UIdnl/cZb/g1cFNJdzTn7QPhVXv4JRN1H9biPkEfxxmQMbxO2QmDF
	 8ACTPgj1XW7Jw==
From: Tejun Heo <tj@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct kernel access
Date: Mon, 27 Apr 2026 00:51:02 -1000
Message-ID: <20260427105109.2554518-3-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427105109.2554518-1-tj@kernel.org>
References: <20260427105109.2554518-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_arena's kern_vm range is selectively populated: only allocated pages
have PTEs. This catches a narrow class of buggy BPF programs that
dereference unmapped arena addresses, but the protection is shallow - within
the allocated set there are countless ways for a buggy program to corrupt
arena memory.

It does, however, impose cost on the kernel side accesses. A kfunc or
struct_ops callback that wants to consume an arena pointer cannot simply
load through it; the page may have been freed underneath, so the access has
to go through copy_from_kernel_nofault(). Out-parameter writes currently
have no equivalent.

Arena is becoming the primary memory model for BPF programs, and more kfunc
/ struct_ops surfaces will want to read and write arena memory directly. The
actual answer for catching arena memory bugs is arena ASAN, which addresses
all memory access bugs meaningfully. Given that, it's worth offering an
opt-in mode that drops the partial fault protection in exchange for cheap
direct kernel-side access.

Add BPF_F_ARENA_MAP_ALWAYS. Arenas created with this flag allocate a
per-arena "garbage" page and pre-populate every PTE in the kern_vm range to
point at it. arena_alloc_pages() replaces the garbage PTE with a real page;
arena_free_pages() restores the garbage PTE instead of clearing.
arena_vm_fault() ignores the garbage page so user-side fault semantics are
unchanged.

Stores into garbage-backed addresses are silently absorbed; loads return
indeterminate bytes. Userspace mappings are unaffected. The flag is opt-in -
arenas without it behave exactly as before.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/uapi/linux/bpf.h |  7 +++++
 kernel/bpf/arena.c       | 62 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..2bd7f2a31a0f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1456,6 +1456,13 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+/* Keep every kernel-side PTE in a BPF_MAP_TYPE_ARENA backed by a per-arena
+ * "garbage" page so that kernel-side accesses anywhere in the arena's 4G range
+ * never fault. Loads from unallocated or freed regions return indeterminate
+ * bytes; stores are silently absorbed. Userspace mappings are unaffected.
+ */
+	BPF_F_ARENA_MAP_ALWAYS	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 02249d2514f8..4e480c2f3786 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -62,6 +62,8 @@ struct bpf_arena {
 	struct irq_work     free_irq;
 	struct work_struct  free_work;
 	struct llist_head   free_spans;
+	/* BPF_F_ARENA_MAP_ALWAYS fallback page; NULL if the flag is off */
+	struct page *garbage_page;
 };
 
 static void arena_free_worker(struct work_struct *work);
@@ -127,12 +129,14 @@ struct apply_range_clear_data {
 static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 {
 	struct apply_range_data *d = data;
+	pte_t old_pte;
 	struct page *page;
 
 	if (!d->pages)
 		return 0;
-	/* sanity check */
-	if (unlikely(!pte_none(ptep_get(pte))))
+	/* slot must be empty, or point to garbage if MAP_ALWAYS */
+	old_pte = ptep_get(pte);
+	if (unlikely(!pte_none(old_pte) && pte_page(old_pte) != d->arena->garbage_page))
 		return -EBUSY;
 
 	page = d->pages[d->i];
@@ -153,6 +157,7 @@ static void flush_vmap_cache(unsigned long start, unsigned long size)
 static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
 {
 	struct apply_range_clear_data *d = data;
+	struct page *garbage = d->arena->garbage_page;
 	pte_t old_pte;
 	struct page *page;
 
@@ -165,7 +170,14 @@ static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
 	if (WARN_ON_ONCE(!page))
 		return -EINVAL;
 
-	pte_clear(&init_mm, addr, pte);
+	if (garbage) {
+		/* if already cleared, must not free the shared garbage page */
+		if (page == garbage)
+			return 0;
+		set_pte_at(&init_mm, addr, pte, mk_pte(garbage, PAGE_KERNEL));
+	} else {
+		pte_clear(&init_mm, addr, pte);
+	}
 
 	/* Add page to the list so it is freed later */
 	if (d->free_pages)
@@ -182,6 +194,21 @@ static int populate_pgtable_except_pte(struct bpf_arena *arena)
 				   KERN_VM_SZ - GUARD_SZ, apply_range_set_cb, &data);
 }
 
+static int populate_garbage_pte_cb(pte_t *pte, unsigned long addr, void *data)
+{
+	struct page *garbage = data;
+
+	set_pte_at(&init_mm, addr, pte, mk_pte(garbage, PAGE_KERNEL));
+	return 0;
+}
+
+static int populate_pgtable_with_garbage(struct bpf_arena *arena)
+{
+	return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
+				   KERN_VM_SZ - GUARD_SZ, populate_garbage_pte_cb,
+				   arena->garbage_page);
+}
+
 static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 {
 	struct vm_struct *kern_vm;
@@ -197,7 +224,8 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	    /* BPF_F_MMAPABLE must be set */
 	    !(attr->map_flags & BPF_F_MMAPABLE) ||
 	    /* No unsupported flags present */
-	    (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE | BPF_F_NO_USER_CONV)))
+	    (attr->map_flags & ~(BPF_F_SEGV_ON_FAULT | BPF_F_MMAPABLE | BPF_F_NO_USER_CONV |
+				 BPF_F_ARENA_MAP_ALWAYS)))
 		return ERR_PTR(-EINVAL);
 
 	if (attr->map_extra & ~PAGE_MASK)
@@ -245,7 +273,23 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		goto err;
 	}
 
+	if (attr->map_flags & BPF_F_ARENA_MAP_ALWAYS) {
+		arena->garbage_page = alloc_page(GFP_KERNEL);
+		if (!arena->garbage_page) {
+			err = -ENOMEM;
+			goto err_free_arena;
+		}
+		err = populate_pgtable_with_garbage(arena);
+		if (err)
+			goto err_free_garbage;
+	}
+
 	return &arena->map;
+err_free_garbage:
+	__free_page(arena->garbage_page);
+err_free_arena:
+	range_tree_destroy(&arena->rt);
+	bpf_map_area_free(arena);
 err:
 	free_vm_area(kern_vm);
 	return ERR_PTR(err);
@@ -253,6 +297,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 
 static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 {
+	struct bpf_arena *arena = data;
 	struct page *page;
 	pte_t pte;
 
@@ -260,6 +305,9 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 	if (!pte_present(pte)) /* sanity check */
 		return 0;
 	page = pte_page(pte);
+	/* garbage is shared and will be freed once later */
+	if (page == arena->garbage_page)
+		return 0;
 	/*
 	 * We do not update pte here:
 	 * 1. Nobody should be accessing bpf_arena's range outside of a kernel bug
@@ -297,6 +345,8 @@ static void arena_map_free(struct bpf_map *map)
 	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
 				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, arena);
 	free_vm_area(arena->kern_vm);
+	if (arena->garbage_page)
+		__free_page(arena->garbage_page);
 	range_tree_destroy(&arena->rt);
 	bpf_map_area_free(arena);
 }
@@ -383,8 +433,10 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		return VM_FAULT_RETRY;
 
 	page = vmalloc_to_page((void *)kaddr);
+	if (page == arena->garbage_page)
+		page = NULL;
 	if (page)
-		/* already have a page vmap-ed */
+		/* already have a real page vmap-ed */
 		goto out;
 
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
-- 
2.53.0

