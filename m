Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF153D3CED
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194252; cv=none; b=mw2NGihVR7Zli8eBxhkoJ2kQd7NWi/gfNMOuHhEwfgwkV7TaojJ95PSeg+UgQlpEev76p6SyBnTLvbygFza4HfnqvJLOFM2040teotbdjmJZp2t5uDjc/VQI9q36T3I+eMq9z09Pxiqlo+1oFN1FSlXvzcFQkkQVsLP/FnWbZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194252; c=relaxed/simple;
	bh=2cQooiS9B1tVse67j5w9DCy7KOGfoc5FtZAsqkEI+GA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=qvhIJGs/fpwLPEcYF/Z5BM1r5zfMn2yQ4f3AlOFzltvHZRDDogSh2kJI81a+mPAzvrIeowNRf6QJ6ZsT+tcfay1uIB0sePquugovpgFLrKaxpYrZs/TsWz3Fh2b8dhxCuUdXFjO4S0C5egSE7TPI5c9a10kLndjlew9YNpr4cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qefDVB7z; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qefDVB7z"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd633ef819bso229738a12.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792194250; x=1792799050; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kNS5x/0L/n+z+Qg+B2WUtR1qrScfMOJus+iQvFPWTUc=;
        b=qefDVB7zM6MzUMDyNO743EJMX8BPLQGhB4NZPO65pk/oOBTL7MySBL7vKcZm7msI82
         ag+NHBQPuRW2eeJDxGvE91PvZ5rTmJot/DSPesmRFOcgS+kDsZYX0ZGXiZKpdZyqGPQh
         N9cDXynWGrkUWmYmxJV16E3A4o3DfrS473FL4WMO3GeLlVCpbmpn4Krdrt8taVIjnG5e
         3Hcz7/72uL7j/3NXzCOhvgyQ6mu7dhhQAYtg1IBB7ba7jWMK28eDWMyOZW112RDepLoP
         WSNxqklzmEzB6abLDluVWkhv6tq9FTsqg2P304eYJZkdTfzaLv7w1FK4CQ7My+SUykEK
         di2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792194250; x=1792799050;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kNS5x/0L/n+z+Qg+B2WUtR1qrScfMOJus+iQvFPWTUc=;
        b=JaOtelG8TRybG6ThI2SFS1O/jqoJQNnRTaOhrvsB/jwWjMhJ/I8hc3yYi2yI9Yqqvx
         7sbx2fiNwBNTFjbFgFgpJbJipJVSWhoJSF480v6d1j7Slui4oZW3GTkfYFwarLWGFt0O
         VvNhdla47Ty598m74lxLDYXjmWwWtEtjHAFQ/Na2rxJx9ovgluD1Jphl0JEEkrNontHL
         aqfyQ/0H4h4GR4HPCDMtuOP7laHUgEabv//gpZQwCHdGl5d72LXr1dd+SdYBQTuWEkzA
         FPoJlJL//nOCkR2CU45EqQImncVPeCRjUXRO+IyNeehu1Y4e/mi8v8ePUFVdZLM81Q6x
         bPaA==
X-Forwarded-Encrypted: i=1; AKwUvBwF1jMWA/6nwvZ9TyyS3uoiKPZFtr6tziqv6EjuBaY+Yi+Vc56CtPZU/16lvZre116VoPw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNYWEyPiuWk3//3g93KePk8yWgn9g39hZE5scSTILqqLOCf3C7
	xEACRTPuD+SwVhfcruz41/f0siawzb0PHS8CZPo6Lh41pPcT6WVZqzB7
X-Gm-Gg: AYBFou2il75AWQYU9W8sMXyrR+jybD43hzeLmFIQrzdhJ3vwUkeBulvUhFCxtMvd5Bx
	1UTDnK3+vqxIBBCvR3awAzzOUNEr+GlNRMtf4tjyG/+2/HinKcIC1qx8Ll4IxllIvTOU1NujG+7
	8XdJJOXJp5/F6o9ChLuwjD32Vtv2XhPgL/M2RIRwD1/Bs7thncBKAISIcYeSj31UUnFy8oZahzP
	eqX8ltqaS6Esv7qJk59oLR9zT/SO6mc+4Df5q8faP/HR7CQYO6cI9u83FmIje0YY+RlLP0cxPLl
	sCFkyRdaroeKilw2kaI7zGKHz+ZZ/GH40se+N3cvurotiS4IkarPRs7VX5FKq4bnKE+zgcx7tXI
	zXjxssJzvn23BMw+BXsB5PJR488KtGH/fOU2IEOB9/VeH3CQfD6RgSdAjMS9EA8Jh+EWR4YuK9g
	RjmlCjpYdMw07NaJb2rAbNaBJriZ04EC7Eox+c7qHEvArosuhVFd9LNkBTU4im9msEJVddHtDWp
	vFAQDNhmaCh8xWTz4KckbACQITvLMeZKiWDIhpDkN6xkuBuyMo3HrIszkxxhaFPdh7hUQTGyh02
	884=
X-Received: by 2002:a17:90b:1c88:b0:3ac:17c:6e8a with SMTP id 98e67ed59e1d1-3acef4fec74mr1074531a91.51.1792194250303;
        Fri, 16 Oct 2026 16:44:10 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3c8e2c9sm2192865a91.2.2026.10.16.16.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 16:44:09 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 23:44:08 +0000
Message-Id: <DM6NU7KBBBPT.32J3EX7WGL328@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Puranjay Mohan" <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v5 0/5] bpf: Fix arena memory incoherence
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261016193703.9203-1-emil@etsalapatis.com>
References: <20261016193703.9203-1-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 07:36 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> - Replace opref (v4 patch 7) with the folio lock. A fault rechecks the
>   kernel PTE with the folio locked and installs the user PTE itself with
>   finish_fault(), and a free waits for the folio lock of each page it
>   removed before zapping (new patch 2). (Alexei)

In v4 I asked to check PageHWPoison() in arena_vm_fault() and return
VM_FAULT_LOCKED. You replied that the page can be poisoned right after
that check and __do_fault() will crash:
https://lore.kernel.org/all/DM6I6ERQ4DJA.25JXLLIZJ75E9@etsalapatis.com/
That's a machine check on this page between two checks that are a few
insns apart, while another process has the page mapped.
tcmu_vma_fault() has the same window since 2022.
It's not a reason to open code do_shared_fault() in arena.
Nothing but mm and dax calls finish_fault().

> - Give faults on a reserved range the scratch_page error. Faults on the
>   range being freed sleep until the free releases it, instead of
>   spinning on VM_FAULT_RETRY. (Alexei)

I asked for the same error in both cases. You replied that the fault
on a range being freed never raised a signal and has to wait:
https://lore.kernel.org/all/DM6IJ1O60GH7.2JQCLY20XU62Q@etsalapatis.com/
It doesn't. Free and realloc is normal use. Touching the page in
between is a bug in user space. In BPF_F_SEGV_ON_FAULT arena it gets
SIGSEGV either way.
retire_pgoff, retire_cnt, retire_seq, arena_wait_for_free() and
bpf_map_inc() in the fault path are there to hand it a zero page
instead.

> - Trylock arena->lock and the mmap read lock of every process that maps
>   the arena before retiring a range, and defer the free if one is
>   contended. The worker waits for the contended lock instead of
>   requeueing itself. The deferred span, allocated with
>   __GFP_RETRY_MAYFAIL when the caller can sleep, is the only allocation
>   before the ptes are cleared. (Alexei)

In v4 I said that mmap_read_lock() in zap_pages() is fine. In the same
reply you said that it has to be a trylock, because iter/task_vma prog
and bpf_find_vma() callback run with mmap_lock held.
zap_pages() does mmap_read_lock() today. If such progs can deadlock
there it's a separate bug with a separate fix.
With the trylocks sleepable bpf_arena_free_pages() is deferred when
another cpu is freeing any page of the arena, or when a writer holds or
waits for mmap_lock of any process that maps it.
arena_race.c has to cope with that:
  /* The reader may populate the slot first, or free may defer. */
The page_cnt == 1 shortcut is gone too, so every free takes mmap_lock
of every process.

[...]
>  kernel/bpf/arena.c                            | 702 +++++++++++++-----

mmap_read_lock() in zap_pages() and the page_cnt == 1 shortcut stay.
The worker doesn't requeue itself, so no need for patch 1.
What is missing: the reader in arena_race.c needs a SIGBUS handler.
Something like this (not even compile tested):

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 0ff7077..3689900 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -543,6 +543,12 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 		goto out_err_locked;
 	}
 
+	if (is_range_tree_set(&arena->rt, vmf->pgoff, 1)) {
+		/* Allocated without a page: reserved or being freed */
+		fault_ret = VM_FAULT_SIGBUS;
+		goto out_err_locked;
+	}
+
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
 	if (!new_page) {
@@ -584,8 +590,22 @@ out:
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 	if (new_page)
 		free_pages_nolock(new_page, 0);
-	vmf->page = page;
-	return 0;
+
+	/*
+	 * arena_free_range() clears the pte and then takes the page lock
+	 * before it zaps user vma-s. Either it waits for this fault and zaps
+	 * its pte, or the page is gone from here. See tcmu_vma_fault().
+	 */
+	lock_page(page);
+	if (vmalloc_to_page((void *)kaddr) == page && !PageHWPoison(page)) {
+		vmf->page = page;
+		return VM_FAULT_LOCKED;
+	}
+	/* The page was freed meanwhile. Let the fault start over. */
+	fault_ret = PageHWPoison(page) ? VM_FAULT_HWPOISON : VM_FAULT_NOPAGE;
+	unlock_page(page);
+	put_page(page);
+	return fault_ret;
 
 out_err_locked_memcg:
 	bpf_map_memcg_exit(old_memcg, new_memcg);
@@ -854,7 +874,7 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 	 * otherwise call B's mark would make call A skip a vml that A has
 	 * not yet zapped for A's uaddr range.
 	 */
-	mutex_lock(&arena->zap_mutex);
+	lockdep_assert_held(&arena->zap_mutex);
 	mutex_lock(&arena->lock);
 	my_gen = ++arena->zap_gen;
 	for (;;) {
@@ -888,49 +908,41 @@ static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt)
 		mutex_lock(&arena->lock);
 	}
 	mutex_unlock(&arena->lock);
-	mutex_unlock(&arena->zap_mutex);
 }
 
-static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
+/*
+ * The range stays allocated in the range tree until the pages are unmapped
+ * from vmalloc area and from all user space vma-s, so that nobody can
+ * populate it while stale TLB entries or user ptes are still around.
+ */
+static int arena_free_range(struct bpf_arena *arena, long uaddr, long page_cnt)
 {
-	struct mem_cgroup *new_memcg, *old_memcg;
-	u64 full_uaddr, uaddr_end;
-	long kaddr, pgoff;
-	struct page *page;
-	struct llist_head free_pages;
-	struct llist_node *pos, *t;
-	struct arena_free_span *s;
+	u64 full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
+	long kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
+	long pgoff = compute_pgoff(arena, uaddr);
 	struct clear_range_data cdata;
+	struct llist_node *pos, *t;
+	LLIST_HEAD(free_pages);
 	unsigned long flags;
-	int ret = 0;
-
-	/* only aligned lower 32-bit are relevant */
-	uaddr = (u32)uaddr;
-	uaddr &= PAGE_MASK;
-	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
-	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
-	if (full_uaddr < arena->user_vm_start)
-		return;
-	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
-	if (full_uaddr >= uaddr_end)
-		return;
-
-	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
-	pgoff = compute_pgoff(arena, uaddr);
-	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+	struct page *page;
+	int ret;
 
-	if (!sleepable)
-		goto defer;
+	/* An overlapping free must not release the range before this one is done */
+	guard(mutex)(&arena->zap_mutex);
 
 	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
-
-	/* Can't proceed without holding the spinlock so defer the free */
 	if (ret)
-		goto defer;
+		return ret;
 
-	range_tree_set(&arena->rt, pgoff, page_cnt);
+	/*
+	 * Take the free pages of the range too. It allocates, and can fail,
+	 * only when the whole range is free. Then there is nothing to do.
+	 */
+	if (range_tree_clear(&arena->rt, pgoff, page_cnt)) {
+		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+		return 0;
+	}
 
-	init_llist_head(&free_pages);
 	cdata.arena = arena;
 	cdata.free_pages = &free_pages;
 	/* clear ptes and collect struct pages */
@@ -940,6 +952,12 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 	/* drop the lock to do the tlb flush and zap pages */
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
 
+	/* wait for arena_vm_fault() that found the page before its pte was cleared */
+	llist_for_each_entry(page, free_pages.first, pcp_llist) {
+		lock_page(page);
+		unlock_page(page);
+	}
+
 	/* ensure no stale TLB entries */
 	flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
 
@@ -958,8 +976,39 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
 			zap_pages(arena, full_uaddr, 1);
 		__free_page(page);
 	}
-	bpf_map_memcg_exit(old_memcg, new_memcg);
 
+	/* The callers hold no other rqspinlock, so this one can only time out */
+	while (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
+		cond_resched();
+	range_tree_set(&arena->rt, pgoff, page_cnt);
+	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	return 0;
+}
+
+static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable)
+{
+	struct mem_cgroup *new_memcg, *old_memcg;
+	u64 full_uaddr, uaddr_end;
+	struct arena_free_span *s;
+
+	/* only aligned lower 32-bit are relevant */
+	uaddr = (u32)uaddr;
+	uaddr &= PAGE_MASK;
+	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
+	if (full_uaddr < arena->user_vm_start)
+		return;
+	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
+	if (full_uaddr >= uaddr_end)
+		return;
+
+	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
+	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
+
+	/* Can't proceed without holding the spinlock so defer the free */
+	if (!sleepable || arena_free_range(arena, uaddr, page_cnt))
+		goto defer;
+
+	bpf_map_memcg_exit(old_memcg, new_memcg);
 	return;
 
 defer:
@@ -1021,66 +1070,18 @@ static void arena_free_worker(struct work_struct *work)
 {
 	struct bpf_arena *arena = container_of(work, struct bpf_arena, free_work);
 	struct mem_cgroup *new_memcg, *old_memcg;
-	struct llist_node *list, *pos, *t;
+	struct llist_node *pos, *t;
 	struct arena_free_span *s;
-	u64 arena_vm_start, user_vm_start;
-	struct llist_head free_pages;
-	struct clear_range_data cdata;
-	struct page *page;
-	unsigned long full_uaddr;
-	long kaddr, page_cnt, pgoff;
-	unsigned long flags;
-
-	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
-		schedule_work(work);
-		return;
-	}
 
 	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
 
-	init_llist_head(&free_pages);
-	cdata.arena = arena;
-	cdata.free_pages = &free_pages;
-	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
-	user_vm_start = bpf_arena_get_user_vm_start(arena);
-
-	list = llist_del_all(&arena->free_spans);
-	llist_for_each(pos, list) {
+	llist_for_each_safe(pos, t, llist_del_all(&arena->free_spans)) {
 		s = llist_entry(pos, struct arena_free_span, node);
-		page_cnt = s->page_cnt;
-		kaddr = arena_vm_start + s->uaddr;
-		pgoff = compute_pgoff(arena, s->uaddr);
-
-		/* clear ptes and collect pages in free_pages llist */
-		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
-					     apply_range_clear_cb, &cdata);
-
-		range_tree_set(&arena->rt, pgoff, page_cnt);
-	}
-	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-
-	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
-	llist_for_each_safe(pos, t, list) {
-		s = llist_entry(pos, struct arena_free_span, node);
-		page_cnt = s->page_cnt;
-		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
-		kaddr = arena_vm_start + s->uaddr;
-
-		/* ensure no stale TLB entries */
-		flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));
-
-		/* remove pages from user vmas */
-		zap_pages(arena, full_uaddr, page_cnt);
-
+		while (arena_free_range(arena, s->uaddr, s->page_cnt))
+			cond_resched();
 		kfree_nolock(s);
 	}
 
-	/* free all pages collected by apply_to_existing_page_range() in the first loop */
-	llist_for_each_safe(pos, t, __llist_del_all(&free_pages)) {
-		page = llist_entry(pos, struct page, pcp_llist);
-		__free_page(page);
-	}
-
 	bpf_map_memcg_exit(old_memcg, new_memcg);
 }
 

pw-bot: cr
