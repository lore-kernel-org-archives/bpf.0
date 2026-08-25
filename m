Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6463ED5C9
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649424; cv=none; b=nH7jrcNT54UEpp7dXaRJnIsubvjSC8gF9h8GrKpdmlgGGUPtV/K1RO2p3rsw5ZjSksIuKmSyRETgjp9eYkCkBPwU4h2uP0c0CmF6N75/sMBVcKTvpCrhA4FrvpQM8KGHiAylQRem+xbz7gr16CX2rCSgVOqoDytRz9wHpZjNO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649424; c=relaxed/simple;
	bh=n39d1Y3WRz91AbqgzkVngKPips7SwY3qmP+NR2SNYK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8v+mdA5oTTfBrVXii0O19L59AlLPt/aluNOXYFm/J5UUbGSZFZIWAVuJPnyvUe7JPuEUUgG4hEovZmKhnlL4RV377OIGxtd9NV4NfzoOpPKvPHI+f6odFDpu15dl87j2Ub5HM3MD/5aVYARoDIbEKk3A7jkcVdHIgtkbYJGkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qIjadi2l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIjadi2l"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6f9e2f681so2082005ad.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649423; x=1788254223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJOMnBC8+UOkkBmi9TvRXsVyiFLnHyyDV0TZJc/rZ/c=;
        b=qIjadi2lB0cGs4DLatwKeh0Vq+THJeya3EzuocQLp4P8eDATEuAeyluHng7EKP0rxa
         QmRYtEhflDD0EqqdQQ3yKQNyzMhi2xbbV9XOTnR4Ij4/V2/3OxDJvvzTLNYa/k3GPMN0
         wWJPYwgXg21MdZ90Q5xp550vRvQ+JtsL9SGzfbwUEOuhl671y4X54iwBpqSPeU9koygy
         I4MEAkw0HQjA4DDuL/iKJRypq4AnNldStNu3+NrtSJ0K90TplC/VeV39+hr49aGTurSC
         0BZMqLQhHezcvmifUSep0bhe6BIscP3/UQ8dXEK2GRVzwE67YARij1MLQ/16rR0gSvGh
         ATZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649423; x=1788254223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJOMnBC8+UOkkBmi9TvRXsVyiFLnHyyDV0TZJc/rZ/c=;
        b=hohE5JKpD/VWAoUzRxoCnJI8jVrruTLlNl+/MD6WKaEYUHYxxlFEo8KW6Xiw4j4Gzu
         2m4Vv1+jNwvLArWZghLGL/qBKWpG0LPqXL8HrvyamE+k1Qbi+VlCPRuk1L5ggvmo93OG
         p/+n/SI+uzYxBcLmQOkYL2Gl5uxnuPUrO3357HmhUyP9RwNdku1uCifR0uUEOlzh+5XL
         oLyNDPG+j/WhvBLRgIU/bRMQ/3MxxCxJpFJmBscnQ/13D7kaGfNtl9mStEJyDY9VivVb
         rY+k590U5CINtUF2hr9/bhbPEDQTj6oaQElRNdgMp6TmRdgt+DXdugyVCaPBTtOcRLOn
         H5vw==
X-Gm-Message-State: AFuF++nm7alZ1xwRol8BGINUxodJ2QpHhIoc5YHgbRarQS+Fx2c3Q+BO
	ADGrS2BAl9GhCNdEybJrevAsFwP6MrHc/hbsF5ZbMtrQVHG7fPJQ34vSWg3PsMyaQMQ=
X-Gm-Gg: AR+sD132Jbl9BQf/ANeP2sAhrHE9O8gUx9nF9N3y+FAsY7XkeAZYcDM3axZPRLj5O38
	bBrW3qMXg18bGLqii3Ims8R7N7J9ULK1p285KVbJVOlWDrWcgQbGpKHsLAu1UCBY10NsHvuDQo7
	ykeIGSBCU8f6fsk4F1Te39IRdcpp6KsW5B4fnYLwhXRB6YyIRG4t+QhcUkrRPDei9DuSV5w+5Cp
	8hRqslz1Ze1ozOsfNuTCViXv2DMShK8G2s1PHwubeyYcz4/7N0EdeH4erorvkmlW9+mfnIL7o66
	dZ/1ID1WA8yTbIFL+L5YY6muIzEOLZ9e6SbucxqqNX2N4sDseNOoJizxfvT4JZUJqXBlGY3CHi5
	5hwzgj0aSL5A9Tnc10eOWJRJnt4q3HonpSVjF6mYl3qeLcr4c4qulHcjWyIf88eyk/rbYSQhOmr
	jHeS7yn79hMxVis61BrV7evl87ukO3zJveGfF7C5uSB/xuopf/AzIKGV14qnuJ1p9kJFxHweQ50
	hCMWEGL0/5Wbz1Q+o8=
X-Received: by 2002:a17:90b:4b02:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-395df2595femr42727078a91.10.1787649422635;
        Tue, 25 Aug 2026 02:17:02 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860fe08csm52122658c88.8.2026.08.25.02.16.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:17:02 -0700 (PDT)
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
Date: Tue, 25 Aug 2026 14:46:45 +0530
Message-ID: <20260825091647.81632-3-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
References: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
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

