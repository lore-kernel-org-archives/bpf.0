Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E653331222
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786661346; cv=none; b=OjAhAzNx1bK4p4yoTP6BJAshmygs+edC0kTiE6Dj7Laz20Eonz3TVJ9LVp8hZt4TL5CGQ+Y98+Znmj6PCmmj/DwejNTaJP0gihEW1SQAIs1q0VmXpBTY3hZC+s+ue37jwJoaxKR0RwdoP+Rap/icpiFzauc4pZrvJn2PMZo7UZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786661346; c=relaxed/simple;
	bh=hZD6Z5uI3FFhEFieMNQQwvTj9KF6y3swzMuKuTWU8Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4kc3/v31QclStcfCoLY1e0VgTkuvGWqAGLT2qSeQDo04ezv1x+MRdrByljNAW20VCJIbtbZ7nbPcBXe2lBkqc9JM1IKtr3D8aw9A5u2BSQ0kMNp0FmwNn7RWgg1RJ6AItIepVzqqsyTSZHSo5O60xO+0BisLBT9C7bo9IGDDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEe5yzhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEe5yzhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D712D1F000E9;
	Thu, 13 Aug 2026 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786661344;
	bh=XMxRCbvJo1u5r1UrLeEa+/OFvDqIKIiSeCJx7G2MxEg=;
	h=From:To:Cc:Subject:Date;
	b=cEe5yzhHJQasbayz2vWqBSATeddg8LDrr3rCdol3kDlOvVmBXOqh7OhkVhhm7INIQ
	 y/W2xnJW8sFtiQuA97ILC24HvB6EPSceVN1kRl5WJdxJhkdMNO2poCja0L7pgCXJXB
	 elLeR9Fw03NvbUb5aPlxAwnGPec1Csne1riHwsaue7SzO/pZ5wAzL0TW+uvA8ucvfF
	 LSpON2oqPWd+wNpMUf41o2pZ9DwKbOteptnXKupdjeDH6OytaqnMoBror7KOGBXc5h
	 K45aHfnSdr8xVpvKiW2RiASNLT5+2KJUuOXOwuhqz8K2T/F40U+LI4TBoAHF+szz5a
	 VbJR/7PZ8h/5Q==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v6 bpf-next] bpf: Populate mmap-able array map memory lazily
Date: Thu, 13 Aug 2026 15:48:53 -0700
Message-ID: <20260813224853.1436734-1-song@kernel.org>
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
fault path. This makes mmap() O(1), and munmap() proportional to the
number of pages that were actually faulted in rather than to the size of
the map.

The handler is reached through a new optional ->map_mmap_fault callback
dispatched from the shared bpf_map_default_vmops, so the existing VMA
open/close accounting (VM_MAYWRITE write-active tracking, freeze
handling) stays centralized rather than each map installing its own
vm_operations_struct.

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
Changes in v6:
- Drop the !CONFIG_MMU branch. nommu cannot mmap() a BPF map fd in the
  first place: the fd is an anon inode and bpf_map_fops has no
  ->mmap_capabilities, so validate_mmap_request() returns -EINVAL before
  ->mmap() runs. (BPF CI AI review)
- Scope the O(1) claim to mmap(); munmap() still tears down whatever was
  faulted in. (BPF CI AI review)
v5: https://lore.kernel.org/bpf/20260812230248.2452103-1-song@kernel.org/

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
 kernel/bpf/arraymap.c | 29 +++++++++++++++++++++++++----
 kernel/bpf/syscall.c  | 12 ++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f4e8d372253a..04cadd987169 100644
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
index 34865701f7f7..a6e44428a6c5 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -608,17 +608,37 @@ static int array_map_check_btf(struct bpf_map *map,
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
@@ -844,6 +864,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_direct_value_addr = array_map_direct_value_addr,
 	.map_direct_value_meta = array_map_direct_value_meta,
 	.map_mmap = array_map_mmap,
+	.map_mmap_fault = array_map_mmap_fault,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d8c3e8e6d62..9e5e65e73dfa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1076,9 +1076,21 @@ static void bpf_map_mmap_close(struct vm_area_struct *vma)
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

base-commit: 259d60f5bfa41056fe01cbf2ba3f6f0331865a16
-- 
2.53.0-Meta

