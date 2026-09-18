Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A34A0921
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720923; cv=none; b=HloV28ZNHOIdk7HvDE3y5zShdcEMzT/HJu+I5ul7/YKQChfyl6G0bykHys4vYPIYEGTkOvBHIPtGzNtYHDv8ox2mQj1Fwsqrj4w3AioXufMsebgD0T8Hjfr1TSaWhqXolOpUROYUNbQzkzfq4LYUFkXkLTcbw8IGqbX5RmUCQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720923; c=relaxed/simple;
	bh=avzHIWkcSx91+p3m3AbRSjYZUyRZLCO1ounXG0xnWKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGg9jHxu4OXllDOmxedNi/OO9pem40vcaYdY1RmGgMN7U4yjpJRshk2edPvDPlUBJWvu6D/7lWt3LwTl9QZFCa+zKPApchiy8xQ4XFTq2Brf80wceEiRI0xwGb4oaem025LuU/RlyWBYs6PSeK55TFpQ3J9WLN4+f/XCt5cAzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NsQ9/9L2; arc=none smtp.client-ip=91.218.175.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NsQ9/9L2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=avzHIWkcSx91+p3m3AbRSjYZUyRZLCO1ounXG0xnWKU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789720918; v=1; x=1790325718;
 b=NsQ9/9L2q2X1NNyMR9mLsPphYuCBzNQV/gFqQNWe0/HavrhZpKLcTUstX4k96GXMIZu0sv98
 D1vUiHPldx0KDfG27uPOB7uVRWUgQt6Y3JXWMEB7W2l4Fn9ruuPnzzdoPfd5Q4NR9QyOyIxbVbH
 8h7lZc7JXGNJhtrBbz5FwhaQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3f4dfc99ad647232;
	Fri, 18 Sep 2026 08:41:58 +0000
X-Mizu-Trace-ID: 3f4dfc99ad647232
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v8 1/3] bpf: arena: allocate the fault-in page outside the lock
Date: Fri, 18 Sep 2026 16:40:25 +0800
Message-ID: <20260918084123.39477-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918084123.39477-1-jiayuan.chen@linux.dev>
References: <20260918084123.39477-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_fault() allocated the page while holding arena->spinlock, so it
could only use the non-blocking allocator, which never reclaims. Once the
memcg is at memory.max that allocation just fails, the fault turns into
VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
arena address. Hitting memory.max is routine (e.g. page cache from
reading a big file), so this kills innocent processes over memory that
reclaim could have freed.

Rework the fault handler:

- Preallocate the page before taking the lock, like do_anonymous_page()
  does, so it can sleep and reclaim, instead of turning a routine
  memory.max into a fake segfault. The allocation uses
  __GFP_RETRY_MAYFAIL so it never invokes the OOM killer: the page is
  charged to the map's memcg, which need not be the faulting task's, so
  an OOM there could kill unrelated tasks in the map's cgroup while a
  foreign faulter could never be its victim. Like the other bpf map
  allocators it places the page on the map's numa_node rather than
  following the task's mempolicy; arena memory is shared, so the map's
  node is the right placement policy.

- On allocation failure fall through to the locked recheck rather than
  failing right away: a page a concurrent allocator installed meanwhile
  is used, otherwise the non-blocking fallback fails and we return
  VM_FAULT_SIGBUS. Not VM_FAULT_OOM: nothing ran the OOM killer, and the
  fault path would just retry it forever.

- A lockless probe skips that preallocation when a page is already mapped
  (e.g. allocated by the bpf program), so the common case wastes no
  allocation. The rare race where such a page is freed before we take the
  lock falls back to the non-blocking allocator under the lock.

- Return VM_FAULT_SIGBUS for the other non-recoverable errors (lock
  failure, range-tree and page-table failures) instead of
  VM_FAULT_SIGSEGV; only BPF_F_SEGV_ON_FAULT, and a scratch-page hole
  under that flag, is a real user addressing error and keeps
  VM_FAULT_SIGSEGV.

- Tidy up the error labels.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
To sashiko:
- The non-blocking fallback under the lock still zeroes:
  alloc_pages_nolock() forces __GFP_ZERO internally and only accepts
  __GFP_ACCOUNT.
- __GFP_ZERO matches the existing __bpf_alloc_page(), and no
  arena-capable arch has D-cache aliasing, so there is no dcache concern.
---
 kernel/bpf/arena.c | 90 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b431..2d0efc0232afd 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -481,7 +481,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct bpf_map *map = vmf->vma->vm_file->private_data;
 	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
 	struct mem_cgroup *new_memcg, *old_memcg;
-	struct page *page;
+	struct page *page, *new_page = NULL;
+	vm_fault_t fault_ret;
 	long kbase, kaddr;
 	unsigned long flags;
 	int ret;
@@ -489,59 +490,108 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+	page = vmalloc_to_page((void *)kaddr);
+	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
+		/*
+		 * Preallocate outside the lock so the allocation can sleep and
+		 * reclaim, which the non-blocking allocator under
+		 * arena->spinlock cannot. __GFP_RETRY_MAYFAIL: reclaim, but
+		 * never OOM-kill in the map's memcg, which need not be the
+		 * faulting task's. On failure, fallthrough: the locked
+		 * recheck below picks up a page a concurrent allocator may
+		 * have installed meanwhile, and otherwise the non-blocking
+		 * fallback fails and we return VM_FAULT_SIGBUS. Not
+		 * VM_FAULT_OOM: nothing ran the OOM killer, and the fault path
+		 * would just retry it forever.
+		 */
+		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+		new_page = alloc_pages_node(map->numa_node,
+					    GFP_KERNEL | __GFP_ZERO |
+					    __GFP_ACCOUNT | __GFP_NOWARN |
+					    __GFP_RETRY_MAYFAIL, 0);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+	}
+
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
 		/*
 		 * A failed lock means a possible deadlock was detected. Don't
 		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
 		 * the fault path would re-take it on retry and deadlock. Fail.
 		 */
+		if (new_page)
+			free_pages_nolock(new_page, 0);
 		return VM_FAULT_SIGBUS;
+	}
 
 	page = vmalloc_to_page((void *)kaddr);
 	if (page) {
-		if (page == arena->scratch_page)
+		if (page == arena->scratch_page) {
 			/* BPF triggered scratch here; don't lazy-alloc over it */
-			goto out_sigsegv;
+			fault_ret = (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) ?
+				    VM_FAULT_SIGSEGV : VM_FAULT_SIGBUS;
+			goto out_err_locked;
+		}
 		/* already have a page vmap-ed */
 		goto out;
 	}
 
+	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) {
+		/* User space requested to segfault when page is not allocated by bpf prog */
+		fault_ret = VM_FAULT_SIGSEGV;
+		goto out_err_locked;
+	}
+
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
-	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
-		/* User space requested to segfault when page is not allocated by bpf prog */
-		goto out_sigsegv_memcg;
+	if (!new_page) {
+		/*
+		 * No page in hand: either the lockless probe saw a page (a bpf
+		 * program page or the scratch page) so we skipped preallocation
+		 * but a concurrent bpf_arena_free_pages() cleared it before we
+		 * took the lock, or the sleepable preallocation failed. We need
+		 * one now and cannot sleep here, so try the non-blocking
+		 * allocator and give up if it fails.
+		 */
+		ret = bpf_map_alloc_pages(map, map->numa_node, 1, &new_page);
+		if (ret) {
+			fault_ret = VM_FAULT_SIGBUS;
+			goto out_err_locked_memcg;
+		}
+	}
 
 	ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
-	if (ret)
-		goto out_sigsegv_memcg;
-
-	struct apply_range_data data = { .arena = arena, .pages = &page, .i = 0 };
-	/* Account into memcg of the process that created bpf_arena */
-	ret = bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
 	if (ret) {
-		range_tree_set(&arena->rt, vmf->pgoff, 1);
-		goto out_sigsegv_memcg;
+		fault_ret = VM_FAULT_SIGBUS;
+		goto out_err_locked_memcg;
 	}
+	struct apply_range_data data = { .arena = arena, .pages = &new_page, .i = 0 };
 
 	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
-		free_pages_nolock(page, 0);
-		goto out_sigsegv_memcg;
+		fault_ret = VM_FAULT_SIGBUS;
+		goto out_err_locked_memcg;
 	}
 	flush_vmap_cache(kaddr, PAGE_SIZE);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
+	/* new_page was consumed */
+	page = new_page;
+	new_page = NULL;
 out:
 	page_ref_add(page, 1);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	if (new_page)
+		free_pages_nolock(new_page, 0);
 	vmf->page = page;
 	return 0;
-out_sigsegv_memcg:
+
+out_err_locked_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
-out_sigsegv:
+out_err_locked:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	return VM_FAULT_SIGSEGV;
+	if (new_page)
+		free_pages_nolock(new_page, 0);
+	return fault_ret;
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
-- 
2.43.0

