Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA293B5842;
	Mon, 27 Apr 2026 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287071; cv=none; b=i50SIt+Sg4vJxoBUuvamG7T2VaPYTqZdpj6w2zVJNlug7pz+B5QwYr08D4ECcmoOKmMj6N2PS5xabE53W+FBK6mMxiMSzMaVzNspcBFeJRhZPP5aWsQYJ+ALiaEHWxwsy2PMYkLLGgGEiNhXYS+Ln0Nxb084QfRqbfqG7R68o1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287071; c=relaxed/simple;
	bh=cwnOxapVSw9wrGq4E4MaNayQr6n5/Dd3o5wx8V4ywyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKwFG2XU+KJAPcZVgx8B6VY6qd2yNO2LEPSBJn3oukHoqoAkkP4SiH4gBNRfHOCXUtdQjGyW0waZyNUwsen0bUQaquWXaRjFwyr65xiABdDjaKb3YBd73HJvd7/ZwdPx75gUfx1tV0HglIu1j3GnUBx9YL31k2NlgSxjuHVZgDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOCZ83r/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOCZ83r/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE55C2BCB4;
	Mon, 27 Apr 2026 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287071;
	bh=cwnOxapVSw9wrGq4E4MaNayQr6n5/Dd3o5wx8V4ywyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOCZ83r/RnABRxW8iD9WHUWd0TTVeJ5GbvubPhr2AGX6xQOJzVHq6txjYmusruEJN
	 IB0gProagt6nKBpNyY9mP5mNZuLOtBwJ5lS6z3cqHLRLBN3PR0zHTkTYZSWKeesOpP
	 3L9JZJE8luk4+0NB1gUrwSWmbzIIU2O23B9v+4nMhc3saseG7xjKTuq5IFRNC/7xxB
	 GP5D+rzh1pQaWADOK5Jz+sJ+VskJPpJV408m3kUmr0WFAw6p/hgblXKIjx0pGu32Uk
	 UYaB7fnKycktCKzjOAsZqQLy8Sx7a4aq9DMTjZ1TjaXGapn4upb8ljGEHxJTQlfXjt
	 aQaVBAze6oxPA==
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
Subject: [RFC PATCH 1/9] bpf/arena: Plumb struct bpf_arena * through PTE callbacks
Date: Mon, 27 Apr 2026 00:51:01 -1000
Message-ID: <20260427105109.2554518-2-tj@kernel.org>
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

A subsequent change needs the PTE callbacks in bpf_arena to consult
per-arena state. Make struct bpf_arena * reachable from each:

- apply_range_set_cb: add an arena field to apply_range_data. The
  data arg can no longer be NULL (it now carries arena), so the
  "skip PTE install" sentinel used by populate_pgtable_except_pte()
  shifts from data == NULL to data->pages == NULL.

- apply_range_clear_cb: introduce struct apply_range_clear_data
  { arena, free_pages } in place of the bare struct llist_head *
  arg.

- existing_page_cb: arena_map_free() passes arena instead of NULL.
  The callback doesn't read it yet.

No behavior change.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/arena.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 08d008cc471e..02249d2514f8 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -114,16 +114,22 @@ static long compute_pgoff(struct bpf_arena *arena, long uaddr)
 }
 
 struct apply_range_data {
-	struct page **pages;
+	struct bpf_arena *arena;
+	struct page **pages;	/* NULL: skip PTE install */
 	int i;
 };
 
+struct apply_range_clear_data {
+	struct bpf_arena *arena;
+	struct llist_head *free_pages;
+};
+
 static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 {
 	struct apply_range_data *d = data;
 	struct page *page;
 
-	if (!data)
+	if (!d->pages)
 		return 0;
 	/* sanity check */
 	if (unlikely(!pte_none(ptep_get(pte))))
@@ -144,8 +150,9 @@ static void flush_vmap_cache(unsigned long start, unsigned long size)
 	flush_cache_vmap(start, start + size);
 }
 
-static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *free_pages)
+static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *data)
 {
+	struct apply_range_clear_data *d = data;
 	pte_t old_pte;
 	struct page *page;
 
@@ -161,16 +168,18 @@ static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *free_pages
 	pte_clear(&init_mm, addr, pte);
 
 	/* Add page to the list so it is freed later */
-	if (free_pages)
-		__llist_add(&page->pcp_llist, free_pages);
+	if (d->free_pages)
+		__llist_add(&page->pcp_llist, d->free_pages);
 
 	return 0;
 }
 
 static int populate_pgtable_except_pte(struct bpf_arena *arena)
 {
+	struct apply_range_data data = { .arena = arena };
+
 	return apply_to_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
-				   KERN_VM_SZ - GUARD_SZ, apply_range_set_cb, NULL);
+				   KERN_VM_SZ - GUARD_SZ, apply_range_set_cb, &data);
 }
 
 static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
@@ -286,7 +295,7 @@ static void arena_map_free(struct bpf_map *map)
 	 * free those pages.
 	 */
 	apply_to_existing_page_range(&init_mm, bpf_arena_get_kern_vm_start(arena),
-				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, NULL);
+				     KERN_VM_SZ - GUARD_SZ, existing_page_cb, arena);
 	free_vm_area(arena->kern_vm);
 	range_tree_destroy(&arena->rt);
 	bpf_map_area_free(arena);
@@ -388,7 +397,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	if (ret)
 		goto out_unlock_sigsegv;
 
-	struct apply_range_data data = { .pages = &page, .i = 0 };
+	struct apply_range_data data = { .arena = arena, .pages = &page, .i = 0 };
 	/* Account into memcg of the process that created bpf_arena */
 	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
@@ -569,6 +578,7 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 		bpf_map_memcg_exit(old_memcg, new_memcg);
 		return 0;
 	}
+	data.arena = arena;
 	data.pages = pages;
 
 	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
@@ -696,9 +706,13 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	range_tree_set(&arena->rt, pgoff, page_cnt);
 
 	init_llist_head(&free_pages);
+	struct apply_range_clear_data clear_data = {
+		.arena = arena,
+		.free_pages = &free_pages,
+	};
 	/* clear ptes and collect struct pages */
 	apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
-				     apply_range_clear_cb, &free_pages);
+				     apply_range_clear_cb, &clear_data);
 
 	/* drop the lock to do the tlb flush and zap pages */
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
@@ -804,6 +818,11 @@ static void arena_free_worker(struct work_struct *work)
 	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
 	user_vm_start = bpf_arena_get_user_vm_start(arena);
 
+	struct apply_range_clear_data clear_data = {
+		.arena = arena,
+		.free_pages = &free_pages,
+	};
+
 	list = llist_del_all(&arena->free_spans);
 	llist_for_each(pos, list) {
 		s = llist_entry(pos, struct arena_free_span, node);
@@ -813,7 +832,7 @@ static void arena_free_worker(struct work_struct *work)
 
 		/* clear ptes and collect pages in free_pages llist */
 		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
-					     apply_range_clear_cb, &free_pages);
+					     apply_range_clear_cb, &clear_data);
 
 		range_tree_set(&arena->rt, pgoff, page_cnt);
 	}
-- 
2.53.0

