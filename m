Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517647044B
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722990; cv=none; b=u6auNdTmZjR8wCdZmfktylbrMyLDIWREzGUZf592VR2rlKm7zfaIWQWqkv+2oQZD5saMyP9npsXIUxS0qXaDWvvM2Iog1xnQDGqJZbRyfKaVpkH574P6IfzpAxQhlDzrjyI4vnq/ofuS7Z94smNr6+Z/eHmqvY/3W9V/bm2NZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722990; c=relaxed/simple;
	bh=E7IViKRC8dE7uxVtkBVmyFZnmdCR4PLxLYh03J8ekvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pnBWaGRCip5lKKNJePTiVrzUjL2PO851C6+HoxCruoD5m2uoKyl/OVLPoLyf7nZIjhzov/NiD69yM3ixlrF7dvZ4UJfS6g9rvlwumyCyKWxOIKIecqiFmdZDmXzG9NURClpg5hHUtkM1q1OWowLQtGcvyaaHGXSd2sJ467wnFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kioiLDIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kioiLDIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F701F000E9;
	Fri, 14 Aug 2026 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722988;
	bh=3DoNzIE795muIFTFG7tDuDxjNLrqvWvME5yF4gjwYh4=;
	h=From:To:Cc:Subject:Date;
	b=kioiLDINbfH1JZ7d6484UwEWzsXzT7eVd5gGDjzKWc36Pvqe7jcr/o6XLhG6kmG+t
	 Iq5oNXTofOm8RpOnSTI+1SDpozvaIlfLSUzGoTWF+qBfKB1PZry3Z73jEK97s8JFt0
	 hUqx4HpDaRs+jB0jjpA7hK5iYFF33dIaCaPSiQr4hz2j1K49ZKzptqGQrOuEmU5hBv
	 i6E672Salhy/A98H2T8+GjxpRu/i5w6qXJghqPcUgRR8GWxV9OZgk5zwGuD+bXGNop
	 AQw3rrIFcIG+n2+JOa0eHqE7dfZvEsrWUwQoJBOA9lyEYjXArScslaZNlxA9x5ijdc
	 RvzIUvSs5jfSg==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v7 bpf-next] bpf: Populate mmap-able array map memory lazily
Date: Fri, 14 Aug 2026 08:56:23 -0700
Message-ID: <20260814155623.111565-1-song@kernel.org>
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

The handler is reached through a new optional ->map_mmap_fault callback.
Maps that provide it get a vm_operations_struct with a .fault handler;
maps that populate their mapping eagerly keep the one they had. Both
share the same open/close callbacks, so the existing VMA accounting
(VM_MAYWRITE write-active tracking, freeze handling) stays centralized
rather than each map installing its own vm_operations_struct.

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
Changes in v7:
- Set VM_MIXEDMAP, which the eager remap_vmalloc_range() path set via
  vm_insert_page(), so that e.g. NUMA balancing keeps skipping these
  VMAs. (BPF CI AI review)
- Only install the .fault handler for maps that populate their mapping
  lazily, so that eagerly populated maps (ringbuf) keep exactly the
  vm_operations_struct they had before. (BPF CI AI review)
v6: https://lore.kernel.org/bpf/20260813224853.1436734-1-song@kernel.org/

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
 kernel/bpf/arraymap.c | 34 ++++++++++++++++++++++++++++++----
 kernel/bpf/syscall.c  | 22 +++++++++++++++++++++-
 3 files changed, 52 insertions(+), 5 deletions(-)

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
index 34865701f7f7..ef315b168b29 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -608,17 +608,42 @@ static int array_map_check_btf(struct bpf_map *map,
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
+	 * Pages are faulted in on demand by array_map_mmap_fault(). Set the
+	 * same flags that the eager remap_vmalloc_range() path used to set
+	 * via vm_insert_page(), so that e.g. NUMA balancing keeps skipping
+	 * these VMAs.
+	 */
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP | VM_MIXEDMAP);
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
@@ -844,6 +869,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_direct_value_addr = array_map_direct_value_addr,
 	.map_direct_value_meta = array_map_direct_value_meta,
 	.map_mmap = array_map_mmap,
+	.map_mmap_fault = array_map_mmap_fault,
 	.map_seq_show_elem = array_map_seq_show_elem,
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d8c3e8e6d62..caf3e202ad6c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1076,11 +1076,30 @@ static void bpf_map_mmap_close(struct vm_area_struct *vma)
 		bpf_map_write_active_dec(map);
 }
 
+static vm_fault_t bpf_map_mmap_fault(struct vm_fault *vmf)
+{
+	struct bpf_map *map = vmf->vma->vm_private_data;
+
+	return map->ops->map_mmap_fault(map, vmf);
+}
+
 static const struct vm_operations_struct bpf_map_default_vmops = {
 	.open		= bpf_map_mmap_open,
 	.close		= bpf_map_mmap_close,
 };
 
+/*
+ * Only for maps that populate their mapping lazily. Maps that populate it
+ * eagerly keep the default vm_ops, so that a fault racing the temporary
+ * pte clearing of a read/modify/write update still gets the pte re-checked
+ * under the ptl by do_fault() instead of a SIGBUS.
+ */
+static const struct vm_operations_struct bpf_map_lazy_vmops = {
+	.open		= bpf_map_mmap_open,
+	.close		= bpf_map_mmap_close,
+	.fault		= bpf_map_mmap_fault,
+};
+
 static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct bpf_map *map = filp->private_data;
@@ -1116,7 +1135,8 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
 		return err;
 
 	/* set default open/close callbacks */
-	vma->vm_ops = &bpf_map_default_vmops;
+	vma->vm_ops = map->ops->map_mmap_fault ? &bpf_map_lazy_vmops
+					       : &bpf_map_default_vmops;
 	vma->vm_private_data = map;
 	vm_flags_clear(vma, VM_MAYEXEC);
 	/* If mapping is read-only, then disallow potentially re-mapping with

base-commit: 259d60f5bfa41056fe01cbf2ba3f6f0331865a16
-- 
2.53.0-Meta

