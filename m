Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D836D3EEAD8
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649610; cv=none; b=BdqVozLPbylcFGsBpXT8BzBciZK67OXM96dtl6XotJy/gwbDrrMgAwd0E8lQz3eSdqydY65ysZgQhCws4AbVv9/+yW87Fjm0G/zJqHnam6yDgMQw+Ov6jD/0NltJ8NFOEwEAZ8l8steA0U32wwq/Kauiiu0IMAOZjIcOHyh+BCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649610; c=relaxed/simple;
	bh=nCIKMze/nePG9edrgFsirG3py5omd/Tnqbe3SwzpmlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7e22B2cig0HFtiq5wGYgro78RKsptbs5Oxx0e8DANt/GI16pOXmhr9H83q03fC1lblN/lJVysMpcCsnbz57j0dxHCyzqAtuvRGObs9U5NCHtP/uABgJScxKPMangkyryr//Puco9qAShPbFRnvgYO3mpbYIfumLX2zjPG71itY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcWjVjWz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcWjVjWz"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848761b5897so1876902b3a.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649608; x=1788254408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XGkExxMyhBiKuGkp4+FT/b5oczqhluEeBce3FhXEQbg=;
        b=kcWjVjWzA3HGaCKocpjGloK4RirvwRX8mz+rtXE2T/Aa1kt2LGaX+zWUgcfjLpIBov
         lHidaxPX9EVxzW1U+GMAMcBLHgpsd2oaQFjlJCcwuaOosNzwKp5KyEHPoCYJDxKtIF7N
         Za9tpHZbC2TxTrV0t9oppaA1IDdLNhWr+XNTsy4v4piD9uLLGm4pyGJXsmEO7RfIja0D
         ay790K610n+wCiwxw7jHmdS07RVLtLJqPPy68PMqRp6KHowt+rOmG64McaXEbhCf3vjT
         B5UjuccoPKtpeGuWuQajOtFvjqmEE5fpC9SXQWPFAgd/LBIdnICkUZB2I6U96icvXtn5
         MI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649608; x=1788254408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGkExxMyhBiKuGkp4+FT/b5oczqhluEeBce3FhXEQbg=;
        b=sxwUgAOHyIk2BCJ0Wki1Ud/uPIWgGPCAvTkNo0KfCbGPeZjxvkb0ZOFdxX2lU0riy/
         M/84zTShZm7LKRrkW3uly2A7YgkGaktdrqYMA2iXrFKF+TiUtQgM5o+0Dgep6vbFyqt9
         Sj8ts7qa8nvA2XOrhmd63CiQxAvwtz2dZzcl3HD95UeNRBg6e2uN3VQD3cuy76FObSI/
         9TK51WPTrCBa1/QiqH6udYJmjtV83t+WgeyP//2F7V3kSit7CDaqJkuEI9XO81l6RCHN
         lu3uBJTEBivUZjLqeEdiTI3rHN4O3XFAE2Hu2vvWoJx2+HqKDv/0LPBVSsUClGXewPaN
         rFMQ==
X-Gm-Message-State: AFuF++lcckdK/jjOHHsEd0cFZU7qK637JgckPIXGofyOgDXyipTEb2Ko
	iHnt5dLOc87TVu8rGW0w48os+efS8ANsdYGb9t/8Hd0VFnm9QzWZf7AZry4EwvH/kNg=
X-Gm-Gg: AR+sD11d9t1+LEaxHLe78DBllvKzc/7xC7y7CihYJW4RWY4ou6VHq/ovlqXXdKvV6Tr
	mYkCJPQM6Ef4+SfZ83xfvpTFWfzsUhYT0+E3Ifr09QofyuOOnlkRjcUuyCyEUh1YyHt7lrrPVMd
	QT0tT85zNreS4is84tV+ZWMYzHnuMUXP8XuUdRqC8U4g3DMnTvHPyNcXV4FRGTRMZRgHuHygGvv
	0BBdBwyOO5SOjBltVQvd1hJ1lEYIqfzIvIJFxL5/HfroIAam4bVfJfakoetvBYhl17ic/Us3w5d
	rN0rH6It8p3y5SElQJeDMfvRsDEJ22jKcEKz0SnEmeFXdTA/s9WEdI9y5eRoWj7cC6GnwRiJoER
	43l8LqAylcev4WY/m/mgsx6su1083FkqdbxeDKNM9vRFJNI8QPXfyVNqenZ52z10Nt2IUPbRgQ/
	OuVNhjGBueoWNKzgi3I3fFzYXPo5ul60B9Bq6MjljTGFEA2+MPCy4TK5I9fIQvexUxBHCl9xQ1Y
	BL1ZDIRhivaMJziCGyHDB0DIO7ZCA==
X-Received: by 2002:a05:6a20:c91c:b0:3b4:8880:2089 with SMTP id adf61e73a8af0-3cd301784afmr65940319637.16.1787649607933;
        Tue, 25 Aug 2026 02:20:07 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3282afb407bsm5386163eec.30.2026.08.25.02.20.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:20:07 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com
Subject: [PATCH v6 2/4] bpf: arena: allocate the fault-in page outside the lock
Date: Tue, 25 Aug 2026 14:49:50 +0530
Message-ID: <20260825091952.81971-3-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
References: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

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
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 kernel/bpf/arena.c | 90 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b..fa462a0ff1 100644
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
2.54.0 (Apple Git-157)

