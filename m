Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EE3F39E4
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563981; cv=none; b=rKeurTBwHZG1Mk2wtgyUZJMfVBaJv5OG8kb4PpJ5I//oAa7HgAPxaPkbOyflERYAjUBktRIMIe+ocJ6Z/JQxobcSfN3tX6V0p+mNFM+5CpugAdKQbWCls6puLmIr+RnkF/JrONINqj8dxczYhc3bOfWbST5i1ISc8OIpgYA2Rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563981; c=relaxed/simple;
	bh=fFLoGUaXIuhLs7RlyqnHs+S1ANmR65p8p4xh2riS5jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2oxe4z2Mvyy0Ek28X++3y8Ss0kX9x+4pOYgK7TBJNXLs7SLF/WM347d6WrhRCWeydqAV2g2nbAk+vPoMYcm5Il6MdMAnU8i0kaHYZSZdwiOUdN7eAfkl0PbQ7fc7v+OEMDM5YCa1BgEiMivzetwZu/INcS+tdMjYgRHiqknSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nngKV/sM; arc=none smtp.client-ip=95.215.58.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nngKV/sM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fFLoGUaXIuhLs7RlyqnHs+S1ANmR65p8p4xh2riS5jE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787563976; v=1; x=1788168776;
 b=nngKV/sMwido9/M2Xf3gaAS7VHzQM1fxXf9Q85cLdI0YgcvmolIPmG5c8GtG0SilcqIQQIss
 6iJMZBmK8tVzdvvDwXVf3LmWjizYzCMpmj2G1tXLr4JErA0q9BIFlIIVKw46527wXvHCyWPPZab
 WCNlKYsulyHIWVLIE+Po2bnY=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.1)
	by smtp.migadu.com with ESMTPS id ad39717f30a18997;
	Mon, 24 Aug 2026 09:32:56 +0000
X-Mizu-Trace-ID: ad39717f30a18997
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v5 2/4] bpf: arena: allocate the fault-in page outside the lock
Date: Mon, 24 Aug 2026 17:29:53 +0800
Message-ID: <20260824093122.362135-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824093122.362135-1-jiayuan.chen@linux.dev>
References: <20260824093122.362135-1-jiayuan.chen@linux.dev>
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
  does, so it can sleep and go through reclaim and the memcg OOM killer,
  instead of turning a routine memory.max into a fake segfault.

- On allocation failure return VM_FAULT_SIGBUS. The allocation already
  ran reclaim and the OOM killer, so the failure is non-recoverable. For
  a task faulting its own arena this changes nothing: the OOM killer
  already picked it inside the allocation and it dies by SIGKILL, the
  SIGBUS is shadowed by the pending fatal signal, and the memcg OOM is
  still reported. VM_FAULT_OOM would instead be retried by the fault
  path and can livelock when the charged memcg is not the faulting
  task's (e.g. a shared arena) and its OOM killer cannot reach it.

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
 kernel/bpf/arena.c | 90 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b43..fa462a0ff1ad 100644
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
@@ -489,59 +490,106 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+	page = vmalloc_to_page((void *)kaddr);
+	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
+		/*
+		 * Preallocate outside the lock with a sleepable allocator so it
+		 * can reclaim and run the memcg OOM killer, which the
+		 * non-blocking allocator under arena->spinlock cannot. A NULL
+		 * return is non-recoverable, so fail with VM_FAULT_SIGBUS;
+		 * VM_FAULT_OOM would be retried by the fault path and can
+		 * livelock when the charged memcg is not the faulting task's.
+		 */
+		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+		new_page = bpf_map_alloc_page_sleepable(map);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		if (!new_page)
+			return VM_FAULT_SIGBUS;
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

