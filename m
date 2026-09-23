Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11895442361
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144080; cv=none; b=ZIk1c7A7bEWBA7d1GmMnoGPw15BXqwKIPpz1UePY4cR6KPFVey+6SR/vMWY5z5ZMQgrTz0GBX2NbCpopWV7h0loNaG5/D4J/inp3s6uMcSwFT31SzEKq9CKoV47IyZ7Uxs2GdQDkrhRehQu6CnLGzOoRw5NsmwMVVlP2Lg3Wxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144080; c=relaxed/simple;
	bh=+rZFpISLHxdyqnpaRhpGxVvyQDaBVEYWHLxJ1a0Rxjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1LQlxmv/KrH6kz8JUSWtCyec2FmUZeG6vknpZA3wTzMzoXhi85FSXOPGEEq67KbIZkQbM7wDL2bPBTz9Ow5hnNaWne+B35vgguNZfOyP6GAyt2QhL1ptQqEdi3kMzXT1Dg8UVgTI/q1JgReuwqskTGizihwkUG5+XSSCFZ7f2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OyI8Emev; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OyI8Emev"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so357731a91.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790144072; x=1790748872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MOtnD8d71SlNDuUKe552TkAwYaRk9WG7l3v+8ZbQSWo=;
        b=OyI8EmevhIkWHzrn26cEcSd5tNl7UWyWey0rfLxhc1xou30qBpAUhDmPJ2PONqqOI5
         egIchG1nJD+yOgp5rB9DhCqvKPjxBS8gvz22KJPyjlQZUZDdJKZ1bD8b4A5o968MPF1O
         Dwjh28x7dFZ2SIfh9l0Lo7100PbHhFjH1aJ5vtk+YhGnd7G6KpfUA2nCdBo/U2iAcCcy
         tny+8CpVz0PM/oeUlorF/9r8aJVj5byG5FsgFDE7TtLg6Kk05FldQ4V1c6eYwnMWx1/a
         Yjj7vHNdkFK7G9fEZkhgPYyL+KFEAV74yqHUcVhyv/NpdmxDVVcq48cmfwWlU+QkdAD6
         i2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144072; x=1790748872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MOtnD8d71SlNDuUKe552TkAwYaRk9WG7l3v+8ZbQSWo=;
        b=AyjcOJomO8nLpGjTDg7hXMuGEZEI57K3E5614fq5+mpR3QtIeWW9riNpK9JE7azpPx
         nA+UxodCM6rl4JZK6vXcgg3zarFcl9/0Zz4yoMF1iw35/QhmPon0YnC/CchIMfdQVb5i
         mrEJbVp9QGGzlE3EsRPFpw8OFcAYhTV470obSHYn1esgsiofZjZtfiZKIy0ZaGA9/P2R
         cTotdQIvVHPAt7U8aSOKSdvqoxHIN8/2yowkbhQXcDjQurLagd1KgRY9u/Am7ygD7rPR
         WOly9GqX9vmpjM+HP5yKFa3PndcRq73Yoj8r4048DqesRUQ8R7QDoffa3ajEtPK/8x3T
         MvoQ==
X-Gm-Message-State: AFuF++lTQJIUi+giYgRdv7XzBmQF7IJe70ZkbEFkMlOgUTfrq8x2kQw7
	6PI099ifBw015Y9DQGWbcobu7x/dYqaXwQsLlizUpQPBcLKvlagAVE31yJbQnk7Z449aSVO47V7
	rIKWjDUKsKQ==
X-Gm-Gg: AYBFou0jtGNSVf1mr+I6P03XMWXJl13BCtwEbDNJDU5B8EVmLkM7QiY5vXNYdyXhCyj
	/u32opdVFC4s8OivQlN1hmFGJNvBJeliUyMbOkCe+RoiK1rSouO3qTxgsEzPLjQVUyoViBqdPGT
	0Kh0FFx3r/Mj8XIJ5Ysh9vOLBTlp5E/C3ka1jJQ/J3SaOB6axJy7Wmat57qNa2WLnt4vOLTVJn5
	dXsnUe+A+0LXACA6H5d8FxzNO1VrsNYfVn9RPkCfH4gCG0//sJ5dt5O9Bow//O4W3in9DfTmBGW
	5aa51XYlZkWW4JIbWkzq2YQUB5tJa5kTq/wcBZmKmhqOoVfnIcEYivp0Rhn+O4Y6Xzm2rEKhvIy
	DjWwzWNtfE6gCGJnacARX+Bz/8DIhWtvwBL2/Z3327d7vm7qSr0s+xSBWvpJqHPcad8csW81Aw+
	NuHwfje8V7JmSF/4oOLGjdsgBiADl+ytTByUgVDzO0YuSwEs4PORUvcsc49bexy4pdY4PkvTJP+
	PYFElxYCpaP3UVmCPGxV7PgWvPABhxU1kaXd9+UIN683PaS8FM5
X-Received: by 2002:a17:90b:4f8a:b0:39e:218c:d47c with SMTP id 98e67ed59e1d1-3a07e557910mr1489033a91.9.1790144072425;
        Tue, 22 Sep 2026 23:14:32 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07de57682sm3562652a91.16.2026.09.22.23.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:14:32 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 5/7] bpf: Atomically update PTE and range tree in arena VM fault handler
Date: Wed, 23 Sep 2026 06:14:23 +0000
Message-ID: <20260923061425.7045-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260923061425.7045-1-emil@etsalapatis.com>
References: <20260923061425.7045-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The arena allocation code currently has a race in the fault handler
that can cause userspace threads to write to the wrong arena page.

a) The fault handler removes a range from the range tree to mark the
addresses as allocated, then installs a page A into the kernel page
tables.

b) A concurrent free/reallocation removes A and installs a page B.

c) The fault handler still goes ahead with installing page A in the
page table. The kernel sees page B, while userspace sees page A.

There is no way to protect the PTE installation and the range tree
modification simultaneously, because we cannot nest the synchronization
primitives for their respective critical sections. PTE allocation
may require allocations due to PTE reclamation, and its spinlock
becomes sleepable under PREEMPT_RT. Thus we cannot do this operation
while holding the range tree spinlock. There is no public API for
manually taking this spinlock, so we nest the range tree operation
inside it.

Solve this issue by adjusting the range tree in two steps. First,
mark the address of the page being allocated as unavailable. Then
drop the range spinlock, insert the PTE, take the range spinlock
again, and fully remove it from the range tree. Concurrent free
operations get serialized to before the fault handler, while
it is not possible to allocate the page once it has been reserved.
Concurrent page fault handler calls retry until the page is fully
allocated by the original call.

Also return VM_FAULT_RETRY for transient allocation failures. These
are a) faulting on pages that are temporarily marked unavailable in
the range tree and b) rqspinlock acquisition failures.

Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c      | 41 +++++++++++++++++++++++++++++++----------
 kernel/bpf/range_tree.c | 14 ++++++++++++++
 kernel/bpf/range_tree.h |  1 +
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index ad58aeaa0c87..8594b76dae61 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -492,18 +492,18 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	struct page *page;
 	long kbase, kaddr;
 	unsigned long flags;
+	vm_fault_t ret_fault;
 	int ret;
 
 	kbase = bpf_arena_get_kern_vm_start(arena);
 	kaddr = kbase + (u32)(vmf->address);
 
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
-		/*
-		 * A failed lock means a possible deadlock was detected. Don't
-		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
-		 * the fault path would re-take it on retry and deadlock. Fail.
-		 */
+	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
+	/* If we are deadlocking somehow, no way to ensure forward progress. */
+	if (ret == -EDEADLK)
 		return VM_FAULT_SIGBUS;
+	if (ret)
+		goto retry;
 
 	page = vmalloc_to_page((void *)kaddr);
 	if (page) {
@@ -549,10 +549,31 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	flush_vmap_cache(kaddr, PAGE_SIZE);
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 out:
-	page_ref_add(page, 1);
+	/* Reserve the page while installing its user PTE without the arena lock. */
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+	ret = range_tree_set_unavail(&arena->rt, vmf->pgoff, 1);
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	vmf->page = page;
-	return 0;
+	if (ret) {
+		if (ret == -EAGAIN)
+			goto retry;
+		return VM_FAULT_OOM;
+	}
+
+	ret_fault = vmf_insert_page(vmf->vma, vmf->address, page);
+
+	while ((ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags))) {
+		/* If we somehow deadlocked stop trying to take the lock. */
+		if (ret == -EDEADLK)
+			return VM_FAULT_SIGBUS;
+
+		cond_resched();
+	}
+
+	ret = range_tree_remove_unavail(&arena->rt, vmf->pgoff, 1);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	WARN_ON_ONCE(ret);
+	return ret_fault;
 out_sigsegv_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 out_sigsegv:
@@ -648,7 +669,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
 	 * being copied into the child process on fork.
 	 */
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY | VM_MIXEDMAP);
 	vma->vm_ops = &arena_vm_ops;
 	return 0;
 }
diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
index 456db58650bd..46a32623efb2 100644
--- a/kernel/bpf/range_tree.c
+++ b/kernel/bpf/range_tree.c
@@ -378,6 +378,20 @@ int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len)
 	return range_tree_set(rt, start, len, false);
 }
 
+int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len)
+{
+	u32 last = start + len - 1;
+	struct range_node *rn;
+
+	rn = range_it_iter_first(rt, start, last);
+	if (!rn || rn->available || rn->rn_start != start || rn->rn_last != last)
+		return -EINVAL;
+
+	range_it_remove(rn, rt);
+	kfree_nolock(rn);
+	return 0;
+}
+
 void range_tree_destroy(struct range_tree *rt)
 {
 	struct range_node *rn;
diff --git a/kernel/bpf/range_tree.h b/kernel/bpf/range_tree.h
index aa27edf451bc..4b12ef51cc0b 100644
--- a/kernel/bpf/range_tree.h
+++ b/kernel/bpf/range_tree.h
@@ -16,6 +16,7 @@ void range_tree_destroy(struct range_tree *rt);
 int range_tree_clear(struct range_tree *rt, u32 start, u32 len);
 int range_tree_set_avail(struct range_tree *rt, u32 start, u32 len);
 int range_tree_set_unavail(struct range_tree *rt, u32 start, u32 len);
+int range_tree_remove_unavail(struct range_tree *rt, u32 start, u32 len);
 int range_tree_make_avail(struct range_tree *rt, u32 start, u32 len);
 int is_range_tree_set(struct range_tree *rt, u32 start, u32 len);
 s64 range_tree_find(struct range_tree *rt, u32 len);
-- 
2.54.0

