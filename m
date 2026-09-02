Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B54390C9E
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337257; cv=none; b=ryLn7MGRSR5H6h3iUD1k+uoyLmdnCvajkZtIKg+dPX8isn18IYQslX6oWC/RNx+7KpaIpVSgykoC1ENeD5sxZJbtQJMUVHjwIQVunZBe1dbbuFBTwT0GVrXhWK+IUGaMY8V9/+Ls7Q416wEWHConqefwiBOwb1Ij2Z1Rk6mmtVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337257; c=relaxed/simple;
	bh=UIcuDOjC7wTDHWWOj16DEHJNyGtn3KOcQARTgPm8MJk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KbKWbrMbccfhi31PjP+qhnZVMMSZsGl2dTFHtQ2/A3tYuQbrIw/jtSJuIlQrCZlts12LOK+8tPwtYvljkX2DZtkarHLDgZ8l8gp3siqh2khhh0GiQR26kb55Cfzcs0lZhFU+Y9/jrX4hr8RqCwYt7P5RXXc/8A7yOa0Dc1o/JM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjkMiEXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjkMiEXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624F21F000E9;
	Wed,  2 Sep 2026 08:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788337256;
	bh=VFyHzxTkqOetoKB/3Thy3yZaA1Inh0/qjsa+buM2RqI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LjkMiEXnnyGIaw8nNCkQNdd51bd2qodCB2tLTkQivGqO5uIZKMzxnN/k9kMcEYx0O
	 vXWGDXZ30f8vzsgfv2HZ1XYrqTuE+DTZ7D8MLBixhu4CvXb/3PtPDtzAneKn9jzgC+
	 GdxcLkTEMFSAey9C1DjkU4UZZ2eukavoIe3IpzczfHWDtgp7k9ssURE3R42KOLQR/F
	 hcxQqycoS2mkGniOq+2LppJFFEjWKwG88A/DN5b1AVTJE0mJyzgx/0rW13hVwTwUiz
	 QkIsRTygoo623XBuAKW6Ln45qaPDH7ltyjrOHp88FCz/SzIvQo5JKXc9MY/OR8BN21
	 3E3bOLA0kg3eg==
Content-Type: multipart/mixed; boundary="===============4591167106700377010=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4538f27ca2cbe47b9b1299d6b4bad461933eeabab969b1120fcffd3e9877545@mail.kernel.org>
In-Reply-To: <20260902070239.16968-4-emil@etsalapatis.com>
References: <20260902070239.16968-4-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: Fix arena race between page free and alloc leading to incoherency
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,nickolay.lysenko@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 08:20:55 +0000 (UTC)

--===============4591167106700377010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix arena race between page free and alloc leading to incoherency
>
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

There are three typos in the changelog: "gets gets freed" (duplicated
word in paragraph a), "simlarly" (should be "similarly" in paragraph c),
and "drop the spinlock lock" (redundant "lock" in the solution
paragraph).

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index f49b52fa85860..d22b71a791db3 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -76,6 +76,7 @@ struct arena_free_span {
>  	struct llist_node node;
>  	unsigned long uaddr;
>  	u32 page_cnt;
> +	bool release_only;
>  };

[ ... ]

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

Does this handle -EAGAIN correctly? range_tree_set_unavail() calls
range_tree_set() with available=false, which calls range_tree_clear().
That function returns -EAGAIN when any overlapping range is already
marked !available:

    while ((rn = range_it_iter_first(rt, first, last))) {
            if (!range_available(rn))
                    return -EAGAIN;
            first = rn->rn_last + 1;
    }

Since only -ENOMEM is filtered here, -EAGAIN reaches WARN_ON_ONCE(ret)
and the free is abandoned. The overlapping !available range can come
from any concurrent free that is in its teardown window (the window this
patch introduces: set_unavail -> unlock -> flush/zap -> relock ->
make_avail), or from a deferred free in arena_free_worker's first loop.

Two CPUs running bpf_arena_free_pages() on overlapping ranges would hit
this: CPU0 freeing pages [0,8) and CPU1 freeing [4,12) is enough. The
partially overlapping case means the non-overlapping remainder is never
torn down, so those pages stay mapped and their range stays allocated.

(Fixed in the next commit, 0b79959d464ca, which adds: "if (ret !=
-EAGAIN) WARN_ON_ONCE(ret);")

>
>  	init_llist_head(&free_pages);
>  	cdata.arena = arena;

[ ... ]

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

[ ... ]

After this commit, arena_vm_fault() can spuriously fail with SIGSEGV.
Before this commit nothing inserted !available nodes into arena->rt, so
range_tree_clear() in arena_vm_fault() never returned -EAGAIN.

This commit makes every freed range spend a window marked !available.
During that window, a userspace thread that faults on a page in that
range calls range_tree_clear() which returns -EAGAIN, and
arena_vm_fault() does:

    ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
    if (ret)
            goto out_sigsegv_memcg;

and hands the thread VM_FAULT_SIGSEGV. The window is not short: it
spans flush_tlb_kernel_range() plus zap_pages() (which takes
arena->zap_mutex, arena->lock, and mmap_read_lock of every mapped
process), and if the re-acquire fails the range stays !available until
the irq_work/workqueue round trip completes (release_only span), or
forever if kmalloc_nolock() in the defer path fails.

Should arena_vm_fault() retry on -EAGAIN instead of returning SIGSEGV?
The next commit in the series (0b79959d464ca) adds exactly that:

    ret = range_tree_clear(&arena->rt, vmf->pgoff, 1);
    /* If a range is unavailable, try again. */
    if (ret == -EAGAIN) {
            raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
            bpf_map_memcg_exit(old_memcg, new_memcg);
            goto retry;
    }

Similarly, arena_alloc_pages() and arena_reserve_pages() can now fail
spuriously. is_range_tree_set() does not look at rn->available, so a
fixed-address allocation over a range in its free teardown window passes
the "is this range free" test and then hits:

    ret = range_tree_clear(&arena->rt, pgoff, page_cnt);

which returns -EAGAIN, and arena_alloc_pages() returns 0 (allocation
failure) to the BPF program. arena_reserve_pages() returns -EAGAIN
verbatim instead of the previous 0/-EBUSY/-ENOMEM set.

Unlike the arena_vm_fault() case, the follow-up commit 0b79959d464ca
does not add retry logic here, so fixed-address bpf_arena_alloc_pages()
and bpf_arena_reserve_pages() can fail spuriously (and with a new errno)
while an overlapping free is being torn down.

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

Same -EAGAIN issue here. range_tree_set_unavail() returns -EAGAIN when
an overlapping range is already marked !available, and only -ENOMEM is
filtered, so -EAGAIN hits WARN_ON_ONCE(ret) and the span is dropped (its
pages are never unmapped/freed and its range stays permanently
allocated, since apply_to_existing_page_range() is skipped by the
continue).

This is reachable without concurrency: a BPF program that calls
bpf_arena_free_pages() or bpf_arena_free_pages_non_sleepable() twice on
the same or overlapping range from non-sleepable context queues two
struct arena_free_span entries on arena->free_spans before the worker
runs. In the worker's first loop, the first span calls
range_tree_set_unavail() successfully; the second span sees the
!available node and gets -EAGAIN, which fires WARN_ON_ONCE (kernel panic
with panic_on_warn) and skips that span's teardown.

Before this commit the same sequence was benign: the loop called
range_tree_set_avail(), whose fast path returned 0 for an
already-available range and never warned.

(Fixed in the next commit, 0b79959d464ca, which replaces this with: "if
(ret != -ENOMEM && ret != -EAGAIN) WARN_ON_ONCE(ret);")

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33603499110
--===============4591167106700377010==--
