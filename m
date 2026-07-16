Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286942D759
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212109; cv=none; b=Z3rmRb6fiRpsLEgelKNKvj5NMXJjFXbvh9R0+80qC64MCfHmTyCOlzooREtxRHZ28APjU1c/XriNw7Ur0R36M9BmiQj9QLUF7qUUh+RNvpGoGAnUILkxPcAUhqWJ8+SnlJb+yp3gNFmsFKCfQhvZehpQihTFtGCNTgfbI/dYYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212109; c=relaxed/simple;
	bh=lTkri3eLcyfnznfqpApEqA81+0LQWnP5CrSlpTRIU3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxyLPYotrYbXCqZUunJSEqIhCkro7yrl6HHn4LaNlz6xkziasIUCT2EJ2jB946yXMiAEvNHY2qNga12P6cjNWXc4Hpcolv6hbCdAfsv7QoQpaBYBv7+c6uP1RUjg5zviLpZw+WZejslvepu3UaVTWZE2F+md+7x61paZUBeRg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ey7kylJD; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ey7kylJD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784212095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cn8IWL7vldf7zy6/xPcDXPEoWEq0JvN6ZK8h9U3/xgo=;
	b=Ey7kylJDsBds2FC0n5ih0PJ1Y3WKxFHy3DIOuqIIiz5gG7rB4Ya59zm09SJqWEvpb53z0y
	wrXPu2r0JoMkCtDPnCa8FkoLWr+t2ob2U1Buav7T8inq9trWtt73AhF6JBUAyoOjgeiYxo
	6JwBw52Wq+0vLANNXPRaRclFSyHYMuE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Woojin Ji <random6.xyz@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/3] bpf: Add memory usage for arena
Date: Thu, 16 Jul 2026 22:24:58 +0800
Message-ID: <20260716142746.8794-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

arena is the only map type whose map_mem_usage() still returns 0, so
"bpftool map show" and fdinfo always showed 0 memlock for an arena no
matter how many pages it had.

Count the pages that are actually mapped into the arena: bump a counter in
apply_range_set_cb() when a page goes in and drop it in
apply_range_clear_cb() when a page goes out, both under the arena spinlock.
map_mem_usage() then just returns nr_pages << PAGE_SHIFT.

Only real data pages are counted, not the scratch page.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/arena.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 80b7b8a69446..bc3460211604 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -55,8 +55,10 @@ struct bpf_arena {
 	struct vm_struct *kern_vm;
 	struct page *scratch_page;
 	struct range_tree rt;
-	/* protects rt */
+	/* protects rt and nr_pages */
 	rqspinlock_t spinlock;
+	/* number of pages currently populated in the arena */
+	u64 nr_pages;
 	struct list_head vma_list;
 	/* protects vma_list */
 	struct mutex lock;
@@ -143,14 +145,14 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
 }
 
 struct apply_range_data {
+	struct bpf_arena *arena;
 	struct page **pages;
-	struct page *scratch_page;
 	int i;
 };
 
 struct clear_range_data {
+	struct bpf_arena *arena;
 	struct llist_head *free_pages;
-	struct page *scratch_page;
 };
 
 static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
@@ -180,7 +182,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 
 		if (pte_none(old))
 			continue;
-		if (WARN_ON_ONCE(pte_page(old) != d->scratch_page))
+		if (WARN_ON_ONCE(pte_page(old) != d->arena->scratch_page))
 			return -EBUSY;
 		ptep_get_and_clear(&init_mm, addr, pte);
 		flush_tlb_before_set(addr);
@@ -196,6 +198,7 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 	set_pte_at(&init_mm, addr, pte, pteval);
 #endif
 	d->i++;
+	d->arena->nr_pages++;
 	return 0;
 }
 
@@ -227,10 +230,11 @@ static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
 	 * scratches its PTE. A later bpf_arena_free_pages() over that range walks
 	 * here. Without the skip, scratch_page would be freed.
 	 */
-	if (page == d->scratch_page)
+	if (page == d->arena->scratch_page)
 		return 0;
 
 	__llist_add(&page->pcp_llist, d->free_pages);
+	d->arena->nr_pages--;
 	return 0;
 }
 
@@ -413,7 +417,9 @@ static int arena_map_check_btf(struct bpf_map *map, const struct btf *btf,
 
 static u64 arena_map_mem_usage(const struct bpf_map *map)
 {
-	return 0;
+	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
+
+	return (u64)READ_ONCE(arena->nr_pages) << PAGE_SHIFT;
 }
 
 struct vma_list {
@@ -506,8 +512,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		goto out_sigsegv_memcg;
 
-	struct apply_range_data data = { .pages = &page, .i = 0,
-					 .scratch_page = arena->scratch_page };
+	struct apply_range_data data = { .arena = arena, .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
@@ -696,8 +701,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 		bpf_map_memcg_exit(old_memcg, new_memcg);
 		return 0;
 	}
+	data.arena = arena;
 	data.pages = pages;
-	data.scratch_page = arena->scratch_page;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
 		goto out_free_pages;
@@ -873,8 +878,8 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	range_tree_set(&arena->rt, pgoff, page_cnt);
 
 	init_llist_head(&free_pages);
+	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
-	cdata.scratch_page = arena->scratch_page;
 	/* clear ptes and collect struct pages */
 	apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
 				     apply_range_clear_cb, &cdata);
@@ -981,8 +986,8 @@ static void arena_free_worker(struct work_struct *work)
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	init_llist_head(&free_pages);
+	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
-	cdata.scratch_page = arena->scratch_page;
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
 
-- 
2.43.0

