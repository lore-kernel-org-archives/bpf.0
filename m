Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F726F2B9;
	Mon, 27 Jul 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785133639; cv=none; b=gLWQnOJ+qqf45cLBZQAjHzMYyE88z5StQ0sRTAenUJ1RP2DSOGyhBfhY9aiE3ShYmpCFTrCMTt+bMFHdOU4J88gpTbby46DxHIllyvWY5zZJ6v25OK5cNnPnokS/FdEFyPwObq8lF6tcXiW+8twwx6CB/4aqNsMu2ymzxTGbJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785133639; c=relaxed/simple;
	bh=Mp6EEezzBtXjYm7gBf7QPftzo02ud4YNrV3bunMxDbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AA1zWDMA4ayKpma4nNZYQMhWUgJYIo+06xENw+00KYqjo6Iox/tt632q9bJO1u/8OJyf8fqcmgH3Jx9FCNW8UCUeg9w/LIDaPggeqBuGpT71/2DZol6K9mJi0Z9H3l0bLDrOIb0HZ2bJyxIrTrzWZRRh2KLBcg+DG7UoUyVYMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bsQJpE2n; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bsQJpE2n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785133636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vT7c4sh/1WgjnNx+T5ORxtW6C6UQsh5V2hftDQIokAU=;
	b=bsQJpE2npgjEumSereZuRazKglaU+LxtpCVjJYlpglnkCnTWAM/dizp9Dyr24ZUWl8B6u2
	SBRVWLQqCvNKW6J881CpdJiXTN8deIOV1qhYh7XXQVSAKhaLJIvwunp84gwvShyHbLippB
	73WjWkcyn8pFkVkFR3+BwW9/MjMSYiU=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next 2/3] bpf: arena: allocate the fault-in page outside the lock
Date: Mon, 27 Jul 2026 14:24:13 +0800
Message-ID: <20260727062521.376231-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260727062521.376231-1-jiayuan.chen@linux.dev>
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

arena_vm_fault() allocated the page while holding arena->spinlock, so it
could only use the non-blocking allocator. Once the memcg is at
memory.max that allocation just fails, the fault turns into
VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
arena address. Hitting memory.max is routine (e.g. page cache from
reading a big file), so this kills innocent processes.

Preallocate the page before taking the lock, like do_anonymous_page()
does, so the allocation can sleep and go through reclaim and the OOM
path, and return VM_FAULT_OOM on failure so the memcg OOM handler runs
instead of a fake segfault. Also tidy up the error labels.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 kernel/bpf/arena.c | 83 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 34f023a537fe..22a41e3c53b8 100644
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
@@ -489,55 +490,97 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+	page = vmalloc_to_page((void *)kaddr);
+	if (!page) {
+		/*
+		 * Preallocate outside the lock so the allocation can sleep and go
+		 * through reclaim (both memcg and global), the way do_anonymous_page()
+		 * does. Under arena->spinlock only the non-blocking allocator is
+		 * available, which never reclaims.
+		 *
+		 * This has to be the sleepable variant: VM_FAULT_OOM below is only
+		 * meaningful if the OOM machinery was actually engaged. A failure
+		 * from the non-blocking allocator engages nothing, so the fault
+		 * would be retried forever.
+		 */
+		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+		new_page = bpf_map_alloc_page_sleepable(map, NUMA_NO_NODE);
+		bpf_map_memcg_exit(old_memcg, new_memcg);
+		if (!new_page)
+			return VM_FAULT_OOM;
+	}
+
+	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
 		/* Make a reasonable effort to address impossible case */
-		return VM_FAULT_RETRY;
+		fault_ret = VM_FAULT_RETRY;
+		goto out_err;
+	}
 
 	page = vmalloc_to_page((void *)kaddr);
 	if (page) {
-		if (page == arena->scratch_page)
+		if (page == arena->scratch_page) {
 			/* BPF triggered scratch here; don't lazy-alloc over it */
-			goto out_sigsegv;
+			fault_ret = VM_FAULT_SIGSEGV;
+			goto out_err_locked;
+		}
 		/* already have a page vmap-ed */
 		goto out;
 	}
 
+	/*
+	 * The lockless probe was racy: it saw a page, so nothing was
+	 * preallocated, but the re-check under the lock finds it gone - a
+	 * concurrent free must have run in between. There is nothing to
+	 * install and we cannot allocate under the lock, so retry the fault
+	 * and preallocate next time.
+	 */
+	if (!new_page) {
+		fault_ret = VM_FAULT_RETRY;
+		goto out_err_locked;
+	}
+
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
-	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
+	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) {
 		/* User space requested to segfault when page is not allocated by bpf prog */
-		goto out_sigsegv_memcg;
+		fault_ret = VM_FAULT_SIGSEGV;
+		goto out_err_locked_memcg;
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
+		fault_ret = VM_FAULT_OOM;
+		goto out_err_locked_memcg;
 	}
+	struct apply_range_data data = { .arena = arena, .pages = &new_page, .i = 0 };
 
 	ret = apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set_cb, &data);
 	if (ret) {
 		range_tree_set(&arena->rt, vmf->pgoff, 1);
-		free_pages_nolock(page, 0);
-		goto out_sigsegv_memcg;
+		fault_ret = VM_FAULT_SIGSEGV;
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
+out_err:
+	if (new_page)
+		free_pages_nolock(new_page, 0);
+	return fault_ret;
 }
 
 static const struct vm_operations_struct arena_vm_ops = {
-- 
2.43.0

