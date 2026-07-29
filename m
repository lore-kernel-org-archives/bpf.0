Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2AE3314DE
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353073; cv=none; b=Nvcr/F7h7YM8kqqPa2Vb5b4Gi7ePvAYps2Pu/R8mFy4ONd1JDkkXzCsI0Rd5BMkOc7BQ3BTJDYOZq/ABOvrZr1bUoUpA7lVtnpE6X7wVQwovm0BLkGsSZyK+dA4DZ6mewCwEMkW43zJoXEwmS1oZv1J1sW21WYQQNVfAFTBTfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353073; c=relaxed/simple;
	bh=LneTrGyVXHmM+Wfo8x+g2h3K6GFV/uqdf9v4fzQEah0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsOUUKgBjHDS4/vm41vZutRDIeZdIksYus8+VlJfwvZKMyqU2icxVnUVAEocEJuatei+fguq4UvFAm5SpB/ZHTjZpaSPqv4PNykc+tqBvajS3XOcJll8HNkZ9Yn63wwikXI5pBp8N7PmPUxbgF9Kz/PVR9/dtXP/UD4L6lCSyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+NgnF+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+NgnF+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBA61F00A3A;
	Wed, 29 Jul 2026 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785353071;
	bh=0rrbVAxxcZelbqiJNhl9+crlNim6cfOADiDoriDW4cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+NgnF+SrGAiauxvFoAvAX46eG0/1nym+bEnVlqA5mdSUp92L+FkktBiUt4ko5wak
	 aMLec7IusDqF5yqzFtKepnbTNYiXKWCvHkIloMuDs+WD0dBgOdIkabaccz8BRb5oKX
	 5TmsqarEHi070KKPyKBoIl3HbTDDl5PeU+z+Y9b24lN9crzBwUtMtde4V5WTYK86xS
	 s6OgNIr7dt6PpTJzhGfIQiS99g6r2WI2awkxVxkeCM0y2uzM7r3hMLCeBJ7ysM1dre
	 cT+75qZIYvlYngzlLYNNCeOk57M9FKn7cv35kOwWv9qfanU2w2g0NJ/G8uJDpf3nnm
	 TuucARpOAupgQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 1/1] bpf: Populate mmap-able array map memory lazily
Date: Wed, 29 Jul 2026 12:24:19 -0700
Message-ID: <20260729192419.41331-2-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729192419.41331-1-song@kernel.org>
References: <20260729192419.41331-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An mmap-able BPF array map (BPF_F_MMAPABLE) has its backing memory
vmalloc'ed up front at map creation time. array_map_mmap() then wired up
the whole mapping eagerly via remap_vmalloc_range(), which calls
vm_insert_page() for every page of the map. For large maps this makes
every mmap() O(number of pages): an 8MiB map inserts 2048 PTEs per
mmap() and tears them all down again on munmap(), even when user space
only touches a few pages (or none at all).

Populate the mapping lazily instead, the same way the arena map already
does. array_map_mmap() now only performs the bounds check and returns,
leaving the PTEs unpopulated; pages are inserted on demand by a new
array_map_mmap_fault() handler. Because the memory is already resident,
the fault handler simply resolves the vmalloc page and hands it to the
fault path. This turns mmap()/munmap() into an O(1) operation.

To keep populating a large mapping cheap, also provide an
array_map_mmap_pages() (->map_pages) handler that batch-installs PTEs for
the whole fault-around window under a single page-table lock. This lets
mmap(MAP_POPULATE) and linear access patterns avoid taking one full fault
per page.

Both handlers are reached through new optional ->map_mmap_fault and
->map_mmap_pages callbacks dispatched from the shared
bpf_map_default_vmops, so the existing VMA open/close accounting
(VM_MAYWRITE write-active tracking, freeze handling) stays centralized
rather than each map installing its own vm_operations_struct.

remap_vmalloc_range() previously guarded against offset overflow; since
it is no longer used, array_map_mmap() and the fault handlers compute the
mapping offset with 64-bit arithmetic and check_shl_overflow() so that a
large vm_pgoff cannot overflow the bounds check on 32-bit architectures.

Callers that want the pages populated up front can still request that
explicitly with MAP_POPULATE. Kernel-side access to the map (via the
vmalloc address) is unaffected.

Signed-off-by: Song Liu <song@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 include/linux/bpf.h   |   3 +
 kernel/bpf/arraymap.c | 140 ++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c  |  30 +++++++++
 3 files changed, 169 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7bfc28673124..eb578ce087b7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -145,6 +145,9 @@ struct bpf_map_ops {
 	int (*map_direct_value_meta)(const struct bpf_map *map,
 				     u64 imm, u32 *off);
 	int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
+	vm_fault_t (*map_mmap_fault)(struct bpf_map *map, struct vm_fault *vmf);
+	vm_fault_t (*map_mmap_pages)(struct bpf_map *map, struct vm_fault *vmf,
+				     pgoff_t start_pgoff, pgoff_t end_pgoff);
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
 	unsigned long (*map_get_unmapped_area)(struct file *filep, unsigned long addr,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..b33bfdae8698 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -7,6 +7,8 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/overflow.h>
+#include <linux/pgtable.h>
 #include <linux/filter.h>
 #include <linux/perf_event.h>
 #include <uapi/linux/btf.h>
@@ -576,18 +578,144 @@ static int array_map_check_btf(struct bpf_map *map,
 static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
-	pgoff_t pgoff = PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
 
 	if (!(map->map_flags & BPF_F_MMAPABLE))
 		return -EINVAL;
 
-	if (vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
+	/* use u64 math so the offset cannot overflow on 32-bit archs */
+	if ((u64)vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
 	    PAGE_ALIGN((u64)array->map.max_entries * array->elem_size))
 		return -EINVAL;
 
-	return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
-				   vma->vm_pgoff + pgoff);
+	if (!IS_ENABLED(CONFIG_MMU)) {
+		pgoff_t pgoff = PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
+
+		/*
+		 * Without an MMU there are no page faults, so the lazy fault
+		 * handlers below are not built. Populate the whole mapping up
+		 * front instead, as the eager path always did.
+		 */
+		return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
+					   vma->vm_pgoff + pgoff);
+	}
+
+	/*
+	 * The backing memory is vmalloc'ed up front, so instead of wiring up
+	 * every PTE here we let the fault handlers insert pages on demand.
+	 * remap_vmalloc_range_partial() used to set these flags for us; keep
+	 * them to preserve behavior (no VMA expansion, excluded from coredump).
+	 */
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+
+	return 0;
+}
+
+#ifdef CONFIG_MMU
+/* Resolve the vmalloc page backing the value-area offset of a fault. */
+static struct page *array_map_fault_page(struct bpf_array *array, pgoff_t pgoff)
+{
+	u64 array_size, off;
+	struct page *page;
+
+	array_size = PAGE_ALIGN((u64)array->map.max_entries * array->elem_size);
+
+	/*
+	 * pgoff is the faulting page's offset into the mapped value area (the
+	 * bpf_array header precedes array->value and is not mapped). Guard the
+	 * shift and the bounds explicitly, the same way that
+	 * remap_vmalloc_range_partial() does for the eager path, instead of
+	 * relying on the mmap()-time bounds check alone.
+	 */
+	if (check_shl_overflow(pgoff, PAGE_SHIFT, &off))
+		return NULL;
+	if (off >= array_size)
+		return NULL;
+
+	page = vmalloc_to_page(array->value + off);
+	if (page)
+		/*
+		 * The kernel writes this memory through the vmalloc alias, so
+		 * flush the D-cache before it is exposed at a new user address.
+		 * The eager remap_vmalloc_range() path did this via
+		 * vm_insert_page() -> validate_page_before_insert().
+		 */
+		flush_dcache_folio(page_folio(page));
+
+	return page;
+}
+
+static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
+				       struct vm_fault *vmf)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	struct page *page;
+
+	page = array_map_fault_page(array, vmf->pgoff);
+	if (!page)
+		return VM_FAULT_SIGBUS;
+
+	get_page(page);
+	vmf->page = page;
+
+	return 0;
+}
+
+/*
+ * Fault-around handler: install PTEs for the whole [start_pgoff, end_pgoff]
+ * window under a single page-table lock, so that populating a large mapping
+ * (e.g. mmap(MAP_POPULATE) or a linear access pattern) does not take one full
+ * fault per page.
+ */
+static vm_fault_t array_map_mmap_pages(struct bpf_map *map, struct vm_fault *vmf,
+				       pgoff_t start_pgoff, pgoff_t end_pgoff)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr, rss = 0;
+	vm_fault_t ret = 0;
+	pte_t *start_pte;
+	pgoff_t pgoff;
+
+	/*
+	 * The PTE table for this PMD must already exist; installing it needs
+	 * mm-internal helpers. If it is missing, let the regular ->fault path
+	 * install it and rely on the next fault-around to batch the rest.
+	 */
+	if (pmd_none(*vmf->pmd))
+		return 0;
+
+	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	start_pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
+	if (!start_pte)
+		return 0;
+	vmf->pte = start_pte;
+
+	for (pgoff = start_pgoff; pgoff <= end_pgoff;
+	     pgoff++, vmf->pte++, addr += PAGE_SIZE) {
+		struct folio *folio;
+		struct page *page;
+
+		if (!pte_none(ptep_get(vmf->pte)))
+			continue;
+
+		page = array_map_fault_page(array, pgoff);
+		if (!page)
+			continue;
+
+		folio = page_folio(page);
+		folio_get(folio);
+		set_pte_range(vmf, folio, page, 1, addr);
+		rss++;
+		if (addr == vmf->address)
+			ret = VM_FAULT_NOPAGE;
+	}
+
+	add_mm_counter(vma->vm_mm, MM_FILEPAGES, rss);
+	pte_unmap_unlock(start_pte, vmf->ptl);
+
+	return ret;
 }
+#endif /* CONFIG_MMU */
 
 static bool array_map_meta_equal(const struct bpf_map *meta0,
 				 const struct bpf_map *meta1)
@@ -812,6 +940,10 @@ const struct bpf_map_ops array_map_ops = {
 	.map_direct_value_addr = array_map_direct_value_addr,
 	.map_direct_value_meta = array_map_direct_value_meta,
 	.map_mmap = array_map_mmap,
+#ifdef CONFIG_MMU
+	.map_mmap_fault = array_map_mmap_fault,
+	.map_mmap_pages = array_map_mmap_pages,
+#endif
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ff9e3aa293d..990c2f5be40a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1077,9 +1077,39 @@ static void bpf_map_mmap_close(struct vm_area_struct *vma)
 		bpf_map_write_active_dec(map);
 }
 
+/*
+ * Called for maps that populate their memory-mapped region lazily, i.e. that
+ * return without wiring up any PTEs from their ->map_mmap callback. Maps that
+ * populate the whole VMA eagerly (e.g. via remap_vmalloc_range()) never reach
+ * here.
+ */
+static vm_fault_t bpf_map_mmap_fault(struct vm_fault *vmf)
+{
+	struct bpf_map *map = vmf->vma->vm_private_data;
+
+	if (!map->ops->map_mmap_fault)
+		return VM_FAULT_SIGBUS;
+
+	return map->ops->map_mmap_fault(map, vmf);
+}
+
+/* Fault-around: batch-populate PTEs around the faulting address. */
+static vm_fault_t bpf_map_mmap_pages(struct vm_fault *vmf,
+				     pgoff_t start_pgoff, pgoff_t end_pgoff)
+{
+	struct bpf_map *map = vmf->vma->vm_private_data;
+
+	if (!map->ops->map_mmap_pages)
+		return 0;
+
+	return map->ops->map_mmap_pages(map, vmf, start_pgoff, end_pgoff);
+}
+
 static const struct vm_operations_struct bpf_map_default_vmops = {
 	.open		= bpf_map_mmap_open,
 	.close		= bpf_map_mmap_close,
+	.fault		= bpf_map_mmap_fault,
+	.map_pages	= bpf_map_mmap_pages,
 };
 
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
2.53.0-Meta

