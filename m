Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E237266D
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786575775; cv=none; b=sbXYNkE8Mz3AQ+boONziTAas6RfP3KfF0f6pxL5869kbyGOA1czjaWOOUaA1XN11+KnNt3+gG0nDi6a3GzbUSHBRhjBB4i6fwBgtfbUlCEMF17knTCds4TffKT5qx6BzoTwujIPPDbpL+/Gm94MWWuLLkg5Cfyu+E+WYpo+aKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786575775; c=relaxed/simple;
	bh=7ZR89UBwexnTjrrggkqNcxocPVKOE6C8AqYM7CmkfsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kn8BrakdfCN7IRbkMyz8Dl9qJAlWmdMj6LcB01udEtJKhar3w+hZllT6oX8mJ35UdD+16Ekg4Zsk3m29HVGsu5KndESB0U1FyP8LpLZXMMTUYcSqu0MhA5gyk8cUJCQ6f48mHUPhvfctFajWtRUX3UKLuQB4/R8mCB+hhrGYALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPLVfwv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPLVfwv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC391F000E9;
	Wed, 12 Aug 2026 23:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786575773;
	bh=wEBhgdkw0UZDeaE+cqZheFIpARjax1vp6FfPVBHuKyQ=;
	h=From:To:Cc:Subject:Date;
	b=fPLVfwv4D5nNTeNJQ5+4SPl/R8buB+RhtF+x+2AtzEvqOb5XSkbo/A+YWyO29Hccl
	 aajJ2L6SXFP2cUQwIQe1r78fD2HoABKjDGffzE0XCD6K9+7Pg3yQ3rnuR2xgFrPNn9
	 2wErKL+C+SQwgz/pZKYvbljDPBwwYQZ1zMOCQZbKazLCi0FrsEDMUGVDjrVDYQ6RiC
	 kSESUxCn3f24RotbbBYfqgMbJbeElardphQ3apw+CC0GvRk1N9EMvFDwAo6AYMK+zW
	 MdfvX3cOeoTDVReD0eWLSsExuhRfwJ24Hj+YWBccn8JgtktjSJrlwxkmDXWrWhYVff
	 3Z0Me6Thu5Jmg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v5 bpf-next] bpf: Populate mmap-able array map memory lazily
Date: Wed, 12 Aug 2026 16:02:48 -0700
Message-ID: <20260812230248.2452103-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The handler is reached through a new optional ->map_mmap_fault callback
dispatched from the shared bpf_map_default_vmops, so the existing VMA
open/close accounting (VM_MAYWRITE write-active tracking, freeze
handling) stays centralized rather than each map installing its own
vm_operations_struct.

Lazy population requires page faults, so on !CONFIG_MMU array_map_mmap()
keeps populating the mapping eagerly via remap_vmalloc_range().

Callers that want the pages populated up front can still request that
explicitly with MAP_POPULATE. Kernel-side access to the map (via the
vmalloc address) is unaffected.

Time for one mmap()+munmap() of an 8MiB mmap-able array map:

                                       before     after
  no MAP_POPULATE, no access            226us     1.1us
  no MAP_POPULATE, access all pages     236us    1341us
  MAP_POPULATE, no access               312us     493us
  MAP_POPULATE, access all pages        318us     519us

Mapping without touching the data, which is what this change targets,
gets ~160x cheaper. Faulting in the whole mapping one page at a time is
more expensive than the eager remap_vmalloc_range() loop, so users that
do touch every page should ask for MAP_POPULATE. Note that MAP_POPULATE
is not free before this change either: it adds ~85us (226us => 312us)
for no benefit, as the mapping is already fully populated.

Signed-off-by: Song Liu <song@kernel.org>
Assisted-by: Claude:claude-opus-4-8

---
Changes in v5:
- Drop the ->map_pages (fault-around) handler, it pulls in too much mm
  internal API for the gain. (Andrii)
- Drop the fault path overflow and bounds checks, and the verbose
  comments; VM_DONTEXPAND plus the mmap() time check already bound the
  faulting offset. (Andrii)
- No cover letter for a single patch. (Andrii)
v4: https://lore.kernel.org/bpf/20260729192419.41331-1-song@kernel.org/

Changes in v4:
- Flush the D-cache before exposing a page at a new user address, as the
  eager vm_insert_page() path did. (Sashiko AI review)
- Fix the build on !CONFIG_MMU: keep populating the mapping eagerly
  there, as there are no page faults. (kernel test robot)
v3: https://lore.kernel.org/bpf/20260729001033.3433328-1-song@kernel.org/

Changes in v3:
- Add a ->map_pages (fault-around) handler so mmap(MAP_POPULATE) and
  linear access populate PTEs in batches instead of one fault per page.
- Harden the fault path with check_shl_overflow() and explicit bounds
  checks instead of a plain (u64) cast. (Andrii)
- Drop selftests (2/2 in v2). (Andrii)
v2: https://lore.kernel.org/bpf/20260722205032.1245094-1-song@kernel.org/

Changes in v2:
- Use 64-bit arithmetic for the mmap offset and bounds check to avoid a
  potential overflow on 32-bit architectures.
v1: https://lore.kernel.org/bpf/20260722065308.4116186-1-song@kernel.org/
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/arraymap.c | 37 +++++++++++++++++++++++++++++++++----
 kernel/bpf/syscall.c  | 12 ++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4a10c9878cf..4a50324e7818 100644
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
index 248b4818178c..a1767ef2b473 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -576,17 +576,45 @@ static int array_map_check_btf(struct bpf_map *map,
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
+		/* no page faults without an MMU, populate the mapping now */
+		return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
+					   vma->vm_pgoff + pgoff);
+	}
+
+	/* pages are faulted in on demand by array_map_mmap_fault() */
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+
+	return 0;
+}
+
+static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
+				       struct vm_fault *vmf)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	struct page *page;
+
+	page = vmalloc_to_page(array->value + ((u64)vmf->pgoff << PAGE_SHIFT));
+	if (!page)
+		return VM_FAULT_SIGBUS;
+
+	/* the eager remap_vmalloc_range() flushed via vm_insert_page() */
+	flush_dcache_folio(page_folio(page));
+	get_page(page);
+	vmf->page = page;
+
+	return 0;
 }
 
 static bool array_map_meta_equal(const struct bpf_map *meta0,
@@ -812,6 +840,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_direct_value_addr = array_map_direct_value_addr,
 	.map_direct_value_meta = array_map_direct_value_meta,
 	.map_mmap = array_map_mmap,
+	.map_mmap_fault = array_map_mmap_fault,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8d111da88655..ee0b01373a4b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1077,9 +1077,21 @@ static void bpf_map_mmap_close(struct vm_area_struct *vma)
 		bpf_map_write_active_dec(map);
 }
 
+/* Called for maps that populate their memory-mapped region lazily. */
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

base-commit: 3a59f11e0f989bdd637c87151992605a6559a7cb
-- 
2.53.0-Meta

