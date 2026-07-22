Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413F350A35
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753451; cv=none; b=fEK4sEtoomVIbZLrqDDs65lPw7q/lApgQ5a9BFYbIcnMvIaqlunCg1W3gWhL30KClIbCcxmok0w1XupX/0cPFwMDTKxgIrM4RhxAgoOB+cq4QUnl5xIL+fMiaUbUxU+zTlGX83fB7Upq9vsABvdR4iEgxkb/31D/5EJ1G5YX3A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753451; c=relaxed/simple;
	bh=In4d/x8UKq5Y77p7nQ14kOGEos1fZ8n/iMa4h39LyNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSdJUDme2Pm4iibwX5dbO7zQkn/IwWlFOhWiTTaiTP2Df0Kd0StzdewRIGbIgMV9lnlWxGBk8Nqc1XYA0bGXc92S99ZXT202XGzzlVwiMddZFjFIsJw89IwdDbKJlJ4/PXDOpMQfKdIAA7SOB1ZEW4xdZ4PKUHwAwQZmAM9F7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALwkNfNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALwkNfNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E081F000E9;
	Wed, 22 Jul 2026 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753450;
	bh=p0PlZgo30LnazkShsc2qVlH+m3UIvPgtECbMJvVr5tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ALwkNfNy6T2XelO7xVEIXVLlDUCPsI6a5YbAcIeTl6FrvhvTDiuFNpo8h6i/821WV
	 sLgrCBaZpbCQDCiUUBY+wlBz0sz4UxD5k1P3ceNqfkJAlVXfWK2T8xEJ2bAWVl4m9P
	 bOSrHMxRPhSBXKhjVAbpKDL1DQXbrgxCqZMDRbpgR8AYZpe6lAPV+cakEkh1Cxx3+v
	 zM+u05fwhvQysuHa3Di1mQhnHc9ME9dXdgZHGDkZC2ZaJwgPchcrT+x+cStGND7qZW
	 oN1SrkLJDV5AGYqJN2LTLuoiD5kNOHu2a/Ba2JnmFs0LDXbPQRQ1eG6+C4kx1UBtPE
	 VpX5xr/2wRAZA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/2] bpf: Populate mmap-able array map memory lazily
Date: Wed, 22 Jul 2026 13:50:31 -0700
Message-ID: <20260722205032.1245094-2-song@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722205032.1245094-1-song@kernel.org>
References: <20260722205032.1245094-1-song@kernel.org>
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
leaving the PTEs unpopulated; the pages are inserted on demand by a new
array_map_mmap_fault() handler. Because the memory is already resident,
the fault handler simply resolves the vmalloc page and hands it to the
fault path.

To keep the existing VMA open/close accounting (VM_MAYWRITE write-active
tracking, freeze handling) centralized, the fault handler is reached
through a new optional ->map_mmap_fault callback dispatched from the
shared bpf_map_default_vmops, rather than each map installing its own
vm_operations_struct.

remap_vmalloc_range() previously guarded against offset overflow; since
it is no longer used, array_map_mmap() and the fault handler compute the
mapping offset with 64-bit arithmetic so that a large vm_pgoff cannot
overflow the bounds check on 32-bit architectures.

This turns mmap()/munmap() of an mmap-able array from O(map size) into
O(1). Callers that want the pages populated up front can still request
that explicitly with MAP_POPULATE, matching regular file semantics.
Kernel-side access to the map (via the vmalloc address) is unaffected.

Signed-off-by: Song Liu <song@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/arraymap.c | 43 +++++++++++++++++++++++++++++++++++++++----
 kernel/bpf/syscall.c  | 17 +++++++++++++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e066f44a9c05..b536f3c9e103 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -145,6 +145,7 @@ struct bpf_map_ops {
 	int (*map_direct_value_meta)(const struct bpf_map *map,
 				     u64 imm, u32 *off);
 	int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
+	vm_fault_t (*map_mmap_fault)(struct bpf_map *map, struct vm_fault *vmf);
 	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
 			     struct poll_table_struct *pts);
 	unsigned long (*map_get_unmapped_area)(struct file *filep, unsigned long addr,
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..59fda56062a9 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -576,17 +576,51 @@ static int array_map_check_btf(struct bpf_map *map,
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
+	/*
+	 * The backing memory is vmalloc'ed up front, so instead of wiring up
+	 * every PTE here we let array_map_mmap_fault() insert pages on demand.
+	 * remap_vmalloc_range_partial() used to set these flags for us; keep
+	 * them to preserve behavior (no VMA expansion, excluded from coredump).
+	 */
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+
+	return 0;
+}
+
+static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
+				       struct vm_fault *vmf)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	pgoff_t pgoff = PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
+	struct page *page;
+	void *kaddr;
+
+	/*
+	 * vmf->pgoff is the page offset within the mapping (vma->vm_pgoff plus
+	 * the offset of the faulting address). The data pages start after the
+	 * bpf_array header, hence the extra pgoff. This mirrors the offset that
+	 * remap_vmalloc_range(vma, ..., vma->vm_pgoff + pgoff) used to apply.
+	 */
+	kaddr = array_map_vmalloc_addr(array) +
+		(((u64)vmf->pgoff + pgoff) << PAGE_SHIFT);
+
+	page = vmalloc_to_page(kaddr);
+	if (!page)
+		return VM_FAULT_SIGBUS;
+
+	get_page(page);
+	vmf->page = page;
+
+	return 0;
 }
 
 static bool array_map_meta_equal(const struct bpf_map *meta0,
@@ -812,6 +846,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_direct_value_addr = array_map_direct_value_addr,
 	.map_direct_value_meta = array_map_direct_value_meta,
 	.map_mmap = array_map_mmap,
+	.map_mmap_fault = array_map_mmap_fault,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0ff9e3aa293d..fb0e1f55c487 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1077,9 +1077,26 @@ static void bpf_map_mmap_close(struct vm_area_struct *vma)
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
 static const struct vm_operations_struct bpf_map_default_vmops = {
 	.open		= bpf_map_mmap_open,
 	.close		= bpf_map_mmap_close,
+	.fault		= bpf_map_mmap_fault,
 };
 
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
2.53.0-Meta

