Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846D49EC7B
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781354; cv=none; b=rSvcJU4ND8EKe9cgD34bqQ1DvkZBHI+8OWybFFdtD4fRXNMbBZ7wYFhraCiN7j66p8JkjuS9Jg1LtDFEAuN5wyM4mpMEq2IJ5cxYqlM6fDKGw+xiKZNDTsCN7PDawJ03rJNr4jaCCwWUobnYxoEf8xGCmiGhR/LjGYi94Zxj7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781354; c=relaxed/simple;
	bh=4ZxvribaMHXWDTy8b1gFpOO/SWX98xpZrFhtsarhpeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OAokeJPwf6a+R3pUeT5RKjPf1KywcX4S7BZAwwayNt21z3YeRGrDUlbZTilfsOj/9914Jd3YvPv5BN87skOK6A2GFuS00BY5Umj514z777W3E/Cdkqodd5+8K0azceew22QFNCxthQgDm+c+nBaKEZStFjsCJQU1sz0CViip7ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9svjyG9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9svjyG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291CF1F00A3A;
	Mon,  7 Sep 2026 11:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781352;
	bh=OF2JQiFy4ROdmKUoAF1swuaZcxwicpvWGrBoNnbLzbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=C9svjyG9pFreS/bTINO+/+NQ0AGj0vC0JFoaMzLlc+MDeO3UAjJxHngZNvBM0zM6r
	 r70iO7uR0hOcaG+t7zGfMQngWtmuIF6mlCnMPx7p2h3RyQZKCYBiiB4iDNlEkvcA4H
	 iZYOvRGi0P90t9sfQkLkt/3/Zpyv4G1oAHvrRA8dSCz4+vCKbgwGUr2klsUuo+VOXK
	 TsbjRpkSJYcPJxnDggXhOzvwSNL81fkkZHXAmlQUxHddtYvdUvF1XOE7JE9VUVv0Jm
	 /huYvepAHaXtKBVVDPef9+ZOn1l3ZrlL8feovqrf93OYdVn4R4tsN8c1huU3WTT3H8
	 o25BPct8aLBjw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, nickolay.lysenko@gmail.com, Emil
 Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: Fix arena race between page free and
 alloc leading to incoherency
In-Reply-To: <20260902070239.16968-4-emil@etsalapatis.com>
References: <20260902070239.16968-1-emil@etsalapatis.com>
 <20260902070239.16968-4-emil@etsalapatis.com>
Date: Mon, 07 Sep 2026 12:41:57 +0100
Message-ID: <m2ik4hqoe2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emil Tsalapatis <emil@etsalapatis.com> writes:

> Existing arena kfunc code has an underlying race condition
> that can lead to writes being lost from the BPF program's
> point of view:
>
> a) A memory range gets gets freed by operation (1), and its
> range is added back to the arena range tree.
>
> b) A concurrent allocation (2) reallocates the range, and does
> writes to it. Writes from that CPU may follow the stale TLB
> entries into the pages that are about to be freed.
>
> c) (1) invalidates the TLB. The old pages, and any writes done
> to them, are now inaccessible. zap_pages() simlarly removes the
> mappings for userspace threads.
>
> This can be triggered by particularly demanding BPF arena data
> structures that constantly allocate and deallocate memory, like
> hash table allocations.
>
> Solve this ABA problem by preventing range reallocation until
> TLB invalidation/unmapping is complete. First, mark the range
> freed but unavailable. Afterwards, drop the spinlock lock and
> flush the kernel TLB and zap user page tables. Then pick up
> the lock again and mark the ranges as available once again,
> completing the free operation.
>
> Reported-by: Mykola Lysenko <nickolay.lysenko@gmail.com>
> Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")

This bug was introduced by yours truly :D in
b8467290edab ("bpf: arena: make arena kfuncs any context safe")

before this commit everything was serialized.

> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  kernel/bpf/arena.c | 94 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 85 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index f49b52fa8586..d22b71a791db 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -76,6 +76,7 @@ struct arena_free_span {
>  	struct llist_node node;
>  	unsigned long uaddr;
>  	u32 page_cnt;
> +	bool release_only;
>  };
>  
>  u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> @@ -855,6 +856,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
>  	struct arena_free_span *s;
>  	struct clear_range_data cdata;
>  	unsigned long flags;
> +	bool release_only = false;
>  	int ret = 0;
>  
>  	/* only aligned lower 32-bit are relevant */
> @@ -881,7 +883,15 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
>  	if (ret)
>  		goto defer;
>  
> -	range_tree_set_avail(&arena->rt, pgoff, page_cnt);
> +	ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
> +	if (ret) {
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		if (ret == -ENOMEM)
> +			goto defer;
> +		WARN_ON_ONCE(ret);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		return;
> +	}
>  
>  	init_llist_head(&free_pages);
>  	cdata.arena = arena;
> @@ -911,6 +921,16 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
>  			zap_pages(arena, full_uaddr, 1);
>  		__free_page(page);
>  	}
> +
> +	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
> +	if (ret) {
> +		release_only = true;
> +		goto defer;
> +	}
> +
> +	ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	WARN_ON_ONCE(ret);
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
>  
>  	return;
> @@ -928,6 +948,7 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
>  
>  	s->page_cnt = page_cnt;
>  	s->uaddr = uaddr;
> +	s->release_only = release_only;
>  	llist_add(&s->node, &arena->free_spans);
>  	irq_work_queue(&arena->free_irq);
>  }
> @@ -977,12 +998,13 @@ static void arena_free_worker(struct work_struct *work)
>  	struct llist_node *list, *pos, *t;
>  	struct arena_free_span *s;
>  	u64 arena_vm_start, user_vm_start;
> -	struct llist_head free_pages;
> +	struct llist_head free_pages, teardown_spans, release_spans;
>  	struct clear_range_data cdata;
>  	struct page *page;
>  	unsigned long full_uaddr;
>  	long kaddr, page_cnt, pgoff;
>  	unsigned long flags;
> +	int ret;
>  
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>  		schedule_work(work);
> @@ -992,28 +1014,51 @@ static void arena_free_worker(struct work_struct *work)
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
>  
>  	init_llist_head(&free_pages);
> +	init_llist_head(&teardown_spans);
> +	init_llist_head(&release_spans);
>  	cdata.arena = arena;
>  	cdata.free_pages = &free_pages;
>  	arena_vm_start = bpf_arena_get_kern_vm_start(arena);
>  	user_vm_start = bpf_arena_get_user_vm_start(arena);
>  
>  	list = llist_del_all(&arena->free_spans);
> -	llist_for_each(pos, list) {
> +	llist_for_each_safe(pos, t, list) {
>  		s = llist_entry(pos, struct arena_free_span, node);
>  		page_cnt = s->page_cnt;
> -		kaddr = arena_vm_start + s->uaddr;
>  		pgoff = compute_pgoff(arena, s->uaddr);
>  
> +		if (s->release_only) {
> +			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
> +			WARN_ON_ONCE(ret);
> +			kfree_nolock(s);
> +			continue;
> +		}
> +
> +		kaddr = arena_vm_start + s->uaddr;
> +
> +		ret = range_tree_set_unavail(&arena->rt, pgoff, page_cnt);
> +		if (ret) {
> +			/*
> +			 * An -ENOMEM failure is the same failure mode as in
> +			 * the defer: path of arena_free_pages(). Do not treat
> +			 * the leak as a bug.
> +			 */
> +			if (ret != -ENOMEM)
> +				WARN_ON_ONCE(ret);
> +
> +			kfree_nolock(s);
> +			continue;
> +		}
> +
>  		/* clear ptes and collect pages in free_pages llist */
>  		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
>  					     apply_range_clear_cb, &cdata);
> -
> -		range_tree_set_avail(&arena->rt, pgoff, page_cnt);
> +		__llist_add(pos, &teardown_spans);
>  	}
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  
> -	/* Iterate the list again without holding spinlock to do the tlb flush and zap_pages */
> -	llist_for_each_safe(pos, t, list) {
> +	/* Keep ranges unavailable until their stale translations are gone. */
> +	llist_for_each_safe(pos, t, __llist_del_all(&teardown_spans)) {
>  		s = llist_entry(pos, struct arena_free_span, node);
>  		page_cnt = s->page_cnt;
>  		full_uaddr = clear_lo32(user_vm_start) + s->uaddr;
> @@ -1025,7 +1070,7 @@ static void arena_free_worker(struct work_struct *work)
>  		/* remove pages from user vmas */
>  		zap_pages(arena, full_uaddr, page_cnt);
>  
> -		kfree_nolock(s);
> +		__llist_add(pos, &release_spans);
>  	}

This isn't a bug, but does release_spans carry any information?

This loop has no condition in it, so every span that goes into it comes
back out into release_spans.  The two lists always hold the same set, and
the split only exists because llist_for_each_safe() consumes the list for
a pass that never frees anything.

Would a plain llist_for_each() over teardown_spans work here, leaving the
list intact for the final make_avail pass and dropping release_spans
entirely?

If release_only became a small stage enum on struct arena_free_span rather
than a bool, the s->release_only = true fixup in the lock-failure path
below would go away as well: the stage can be advanced once, in the first
loop, right after range_tree_set_unavail() succeeds.  The worker then reads
as three passes over one list - reserve under the lock, tear down unlocked,
release under the lock.

There may be more to gain from factoring those three steps into helpers,
since arena_free_pages() open-codes the same sequence for a single span
that arena_free_worker() open-codes for a batch, including both of the
requeue paths between them.

>  	/* free all pages collected by apply_to_existing_page_range() in the first loop */
> @@ -1034,6 +1079,37 @@ static void arena_free_worker(struct work_struct *work)
>  		__free_page(page);
>  	}
>  
> +	if (!llist_empty(&release_spans)) {
> +		if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
> +			llist_for_each_safe(pos, t, __llist_del_all(&release_spans)) {
> +				s = llist_entry(pos, struct arena_free_span, node);
> +				s->release_only = true;
> +				llist_add(pos, &arena->free_spans);
> +			}
> +
> +			schedule_work(work);
> +			bpf_map_memcg_exit(old_memcg, new_memcg);
> +			return;
> +		}
> +
> +		llist_for_each_safe(pos, t, __llist_del_all(&release_spans)) {
> +			s = llist_entry(pos, struct arena_free_span, node);
> +			page_cnt = s->page_cnt;
> +			pgoff = compute_pgoff(arena, s->uaddr);
> +			/*
> +			 * This range tree operation does not allocate memory,
> +			 * and so should never fail regardless of contention
> +			 * or memory pressure. This is in contrast to regular
> +			 * inserts that _can_ fail under memory pressure and
> +			 * force us to defer the free.
> +			 */
> +			ret = range_tree_make_avail(&arena->rt, pgoff, page_cnt);
> +			WARN_ON_ONCE(ret);
> +			kfree_nolock(s);
> +		}
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	}
> +
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
>  }
>  
> -- 
> 2.55.0
