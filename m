Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FE3F4DD9
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288826; cv=none; b=cLfbPm6+7dh89oqpbBb/YZIwpp7CHyKEu5tJePwoz9E/0Aq47uAkMSfVcm0pF5H6a0nfmyBPJfb5mjAFLio2ufKBcRJwM30fHIyQOaIQ/FOf8c8pWULAlL5rllEN6MUlXo4wMBnAn82yv0b2tvYuTLUGg2TNYxAZ9iNyh9j5WEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288826; c=relaxed/simple;
	bh=L7/QF6YuAdQcBpxKxHlzA8iAAu5Icx9lkHLtmoHEn64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sx+EhM6TAL+LWz/PBvb1by7KbuDPHApOrsZvLC50X+LTvcYzT3U7kAeVtutvhyiy3Uil9SFrihr3I9zclrt3IunfhMsJP1BR9B1JrJOP4DDboYA0BuS3V/yiMzmOEcrkTARzKuoQvlnXyXqYVNnT00o502dPRtGMofz3qYhIlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xGPU2tUa; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xGPU2tUa"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L7/QF6YuAdQcBpxKxHlzA8iAAu5Icx9lkHLtmoHEn64=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787288822; v=1; x=1787893622;
 b=xGPU2tUabD9boLRKSVOGOkxT9P5TEv+ksoVvd/f+EqLY9yxOfeRsGe7wwHzOV3gQHCnQx3OI
 MciBoMfhOO4HjeNjs6FBK4b6VV/Rh2MCAAkSfyzqZEJEUKpdJQ5gx2MQuZJutEbS2H4TvOOSzvS
 GL85/KwiuYsAr63Jd2jz6gEs=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.2)
	by smtp.migadu.com with ESMTPS id 84dea62f2fbb8412;
	Fri, 21 Aug 2026 05:07:02 +0000
X-Mizu-Trace-ID: 84dea62f2fbb8412
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
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 2/4] bpf: arena: allocate the fault-in page outside the lock
Date: Fri, 21 Aug 2026 13:06:13 +0800
Message-ID: <20260821050631.39784-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821050631.39784-1-jiayuan.chen@linux.dev>
References: <20260821050250.35112-1-jiayuan.chen@linux.dev>
 <20260821050631.39784-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arena_vm_fault() allocated the page while holding arena->spinlock, so it
could only use the non-blocking allocator. Once the memcg is at
memory.max that allocation just fails, the fault turns into
VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
arena address. Hitting memory.max is routine (e.g. page cache from
reading a big file), so this kills innocent processes.

Rework the fault handler:

- Preallocate the page before taking the lock, like do_anonymous_page()
  does, so it can sleep, reclaim and go through the OOM path, and return
  VM_FAULT_OOM on failure so the memcg OOM handler runs instead of a fake
  segfault.

- A lockless probe skips that preallocation when a page is already mapped
  (e.g. allocated by the bpf program), so the common case wastes no
  allocation. The rare race where such a page is freed before we take the
  lock falls back to the non-blocking allocator under the lock.

- Return VM_FAULT_SIGBUS for the non-recoverable errors (lock failure,
  range-tree and page-table failures) instead of VM_FAULT_SIGSEGV; only
  BPF_F_SEGV_ON_FAULT, and a scratch-page hole under that flag, is a real
  user addressing error and keeps VM_FAULT_SIGSEGV.

- Tidy up the error labels.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/arena.c | 92 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b43..50dac9ba0f5e 100644
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
+		 * We run in process context here, so preallocate the page
+		 * outside the lock with an explicitly sleepable allocator. It
+		 * can then go through reclaim (both memcg and global) and the
+		 * OOM path, the way do_anonymous_page() does; under
+		 * arena->spinlock only the non-blocking allocator is available,
+		 * which never reclaims. That also decides the return value:
+		 * VM_FAULT_OOM below is only meaningful if the OOM machinery was
+		 * actually engaged, which the non-blocking allocator never does.
+		 */
+		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+		new_page = bpf_map_alloc_page_sleepable(map);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		if (!new_page)
+			return VM_FAULT_OOM;
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
-			/* BPF triggered scratch here; don't lazy-alloc over it */
-			goto out_sigsegv;
+		if (page == arena->scratch_page) {
+			/*
+			 * A scratch page marks a hole. Segfault only if the user
+			 * asked for it; otherwise we could lazy-allocate but
+			 * choose not to over a hole, so report a bus error.
+			 */
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
+		 * Very rare race: the bpf program had allocated a page here, so
+		 * the lockless probe saw it and we skipped preallocation, but it
+		 * freed the page before we took the lock. Now we do need one;
+		 * sleeping is not allowed here, so fall back to the non-blocking
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

