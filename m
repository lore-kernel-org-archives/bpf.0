Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B4115C14F
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342793; cv=none; b=dOPDMYsIOtMkF42HljA5kolvCbA1K0nkaZVKCePOHsuCN4npq6qztkRk3wz16p54w5u0sYBdouFqyJqRL8m8gCE4WwU6ypD8r9MDxMuM4PnMOBs1joLgU/d2LgeGm9cRFtIsOWO2WUuFmYd00WkkBnIyofxY00gS6TOoHxtcJ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342793; c=relaxed/simple;
	bh=5tFUljryd3eQ5xNH7OG6fDbSXvkCGixEraE5MBa06VE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uVG3laJEz9btDRovVaTK98ik3i9zpbAUzWMz579Tc5mJ38wzrY/JD9SLC2wQCE+EEpOdcqcOV8OGY+f3ehv0i1+QYkDqI1yoLrlp7aZvi11AzIK3ZbTPDS2nJriTndal82HsHlCt3Uv3Dh+Ll6gDsuYLMQXHLUqIIz3i+ffBrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H74kDVni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H74kDVni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4131F000E9;
	Wed,  2 Sep 2026 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342791;
	bh=waHIeWPsyeVPzmM7fYvV6TmHQQiUv8V2NN+5UPgEnM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H74kDVnivbK08GH6ULRPvJz0CU9SlTDVzEms6EZ82rzLDWYZdyeQgzH4Ek3XH4khE
	 VAubu5D5yu0pZJPAlvy7cDsOUKgGeBN35FNMUvJ9lqT7jA3qTRig+PE/w6fN0rekt5
	 eEB3aiMHhDuB4I36M4FQXYLFwmGRq6mE1i+2h1PvQy8f6YL6wAvgPXjvi7dGO1LCED
	 2r93cZIOO8P+hGQEghoPbrQLx+Kw6TsZBKmcbZG5HzFeF/gW2OTpJFvHVJp/MdUbcy
	 CuJ1ovI/nlq6zPxtIwoOhHaUxRjEpAN8WdXrDYL6q+ybaoSl+EcNv6fUa9tmBsO4QZ
	 uSr2p2mjtedrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 3/3] bpf, arena: handle range_tree_set
 failures in alloc/free paths
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260902093740.2338724-4-chenyuan_fl@163.com>
References: <CAADnVQKPSWBzaEc7QBT39C_N_32Gu5_P5Cob9G0rxcDgiSQg6g@mail.gmail.com>
 <20260902093740.2338724-1-chenyuan_fl@163.com>
 <20260902093740.2338724-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 09:53:11 +0000
Message-Id: <20260902095311.9A4131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] If `arena_map_free()` fails to acquire the lock and aborts, it lea=
ks the arena and leaves the worker in an infinite retry loop on `-ENOMEM`.
- [Low] The `if (arena->dying)` check in `arena_free_worker` is mathematica=
lly dead code.

Pre-existing issues:
- [High] Virtual memory range is marked free before TLB flush and user PTE =
zap, allowing use-after-free and data loss.
--

commit 9b91373ca20b3a032ab090590fde24790048b705
Author: Yuan Chen <chenyuan@kylinos.cn>
bpf, arena: handle range_tree_set failures in alloc/free paths

This commit adds error handling for range_tree_set() in the arena allocation
and free paths. It includes a bounded retry loop for arena_map_free() to
acquire the spinlock and introduces arena->dying to stop the worker thread's
retry loop during map teardown.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..b0d1f0facfb2c 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
[ ... ]
> @@ -370,6 +373,9 @@ static int existing_page_cb(pte_t *ptep, unsigned lon=
g addr, void *data)
>  static void arena_map_free(struct bpf_map *map)
>  {
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
> +	struct llist_node *list, *pos, *t;
> +	unsigned long flags;
> +	int ret, i;
> =20
>  	/*
>  	 * Check that user vma-s are not around when bpf map is freed.
> @@ -380,7 +386,40 @@ static void arena_map_free(struct bpf_map *map)
>  	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
>  		return;
> =20
> -	/* Ensure no pending deferred frees */
> +	/*
> +	 * No fallback if this fails, so retry a few times for a long but
> +	 * finite hold; -EDEADLK can't be waited out. Cap the retries:
> +	 * leaking the arena is better than hanging map free.
> +	 */
> +	for (i =3D 0; i < 10; i++) {
> +		ret =3D raw_res_spin_lock_irqsave(&arena->spinlock, flags);
> +		if (!ret || ret =3D=3D -EDEADLK)
> +			break;
> +		msleep(1);
> +	}
> +	if (ret) {
> +		WARN_ONCE(1, "bpf_arena: spinlock acquire failed %d\n", ret);
> +		return;
> +	}

[Severity: High]
If this early return path triggers, it intentionally leaks the arena, but
doesn't set arena->dying. Could this strand the worker in an infinite
retry loop?

If the worker's range_tree_set() call fails continuously (e.g., due to memo=
ry
exhaustion), it will endlessly requeue the span and queue an irq_work to
retry. Because arena->dying remains false, this could turn into an infinite
busy loop.

> +	/*
> +	 * Set @dying before draining: the worker checks it under this
> +	 * spinlock before requeueing, so a failed span is either stolen
> +	 * here or dropped by the worker.
> +	 */
> +	arena->dying =3D true;
[ ... ]
> @@ -977,12 +1031,13 @@ static void arena_free_worker(struct work_struct *=
work)
>  	struct llist_node *list, *pos, *t;
>  	struct arena_free_span *s;
>  	u64 arena_vm_start, user_vm_start;
> -	struct llist_head free_pages;
> +	struct llist_head free_pages, cleared;
>  	struct clear_range_data cdata;
>  	struct page *page;
>  	unsigned long full_uaddr;
>  	long kaddr, page_cnt, pgoff;
>  	unsigned long flags;
> +	bool retry =3D false;
> =20
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>  		schedule_work(work);
> @@ -992,28 +1047,52 @@ static void arena_free_worker(struct work_struct *=
work)
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> =20
>  	init_llist_head(&free_pages);
> +	init_llist_head(&cleared);
>  	cdata.arena =3D arena;
>  	cdata.free_pages =3D &free_pages;
>  	arena_vm_start =3D bpf_arena_get_kern_vm_start(arena);
>  	user_vm_start =3D bpf_arena_get_user_vm_start(arena);
> =20
>  	list =3D llist_del_all(&arena->free_spans);
> -	llist_for_each(pos, list) {
> +	llist_for_each_safe(pos, t, list) {
>  		s =3D llist_entry(pos, struct arena_free_span, node);
>  		page_cnt =3D s->page_cnt;
>  		kaddr =3D arena_vm_start + s->uaddr;
>  		pgoff =3D compute_pgoff(arena, s->uaddr);
> =20
> +		/*
> +		 * Set the range free before clearing PTEs, and requeue the
> +		 * span on failure: the PTEs stay intact and the free is
> +		 * retried later. Only spans moved to @cleared (PTE clearing
> +		 * actually ran) reach the flush/zap/release loop below.
> +		 */
> +		if (range_tree_set(&arena->rt, pgoff, page_cnt)) {
> +			if (arena->dying) {
> +				/*
> +				 * The map is being freed. PTEs stay intact
> +				 * and the pages are reclaimed by
> +				 * arena_map_free() via existing_page_cb().
> +				 */
> +				kfree_nolock(s);
> +				continue;
> +			}

[Severity: Low]
Is this check mathematically dead code?

arena->dying is set to true by arena_map_free() while holding arena->spinlo=
ck,
after which arena->free_spans is immediately drained via llist_del_all().

In arena_free_worker(), the list is also drained at the very beginning of i=
ts
arena->spinlock critical section. Because both functions drain the list und=
er
the same spinlock, if arena_map_free() runs first, the worker's list is emp=
ty
and the loop never executes. If the worker runs first, dying is guaranteed =
to
be false throughout its critical section.

> +			llist_add(&s->node, &arena->free_spans);
> +			retry =3D true;
> +			continue;
> +		}
> +
>  		/* clear ptes and collect pages in free_pages llist */
>  		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
>  					     apply_range_clear_cb, &cdata);
> -
> -		range_tree_set(&arena->rt, pgoff, page_cnt);
> +		llist_add(&s->node, &cleared);
>  	}
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> =20
> +	if (retry)
> +		irq_work_queue(&arena->free_irq);
> +
>  	/* Iterate the list again without holding spinlock to do the tlb flush =
and zap_pages */
> -	llist_for_each_safe(pos, t, list) {
> +	llist_for_each_safe(pos, t, cleared.first) {
>  		s =3D llist_entry(pos, struct arena_free_span, node);
>  		page_cnt =3D s->page_cnt;
>  		full_uaddr =3D clear_lo32(user_vm_start) + s->uaddr;
> +		kaddr =3D arena_vm_start + s->uaddr;
> +
> +		/* ensure no stale TLB entries */
> +		flush_tlb_kernel_range(kaddr, kaddr + (page_cnt * PAGE_SIZE));

[Severity: High]
This isn't a bug introduced by this patch, but dropping the spinlock before
the TLB flush opens a race window. Can a concurrent arena_alloc_pages()
allocate the newly freed virtual range and map new physical pages to it?

Since the TLB flush for the old pages has not yet executed, accesses by the
new owner could hit stale TLB entries (or user PTEs). Writes would go to the
old physical pages which are later freed, resulting in a use-after-free and
data loss. The synchronous free path in arena_free_pages() appears to have
the same preexisting vulnerability.

> =20
> -		/* remove pages from user vmas */
> -		zap_pages(arena, full_uaddr, page_cnt);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902093740.2338=
724-1-chenyuan_fl@163.com?part=3D3
