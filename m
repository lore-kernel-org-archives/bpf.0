Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34114307AB
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579693; cv=none; b=BVzvSleNdkqbKCyZvIGVLoQ8ChmUQoQtOB005igPIDzjbfabgNb6ilAxnvIkcGuYHlCBRc6Q4d+sPNU7FMNruVeozJNTRTRt+bObS7h8nYT13gwfO+58O+O+kBXv2JGcZMvhx9dAE7R8p2j8JyyLk6LClhQTzn4xXdqKkczwktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579693; c=relaxed/simple;
	bh=cewYe7I33g1sPZHvcmThYFjQH4zSpcJK6NJD0iUgaik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mLrvXGQzPQlE8ErBwkg68I6nuYB6fVqaIc35gv6jGgSgAR8jSOGFICZrCtAPB+3nfjlyuiMK32kMZMwsMUpOVRotknVI6U2Z8baYBZFprOPNd0ODe5nA5YGUpIN4FChkk1DGK8y+3ejFdB7gCcCSgdzzjTAVnSsQPdeGY4UMono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5ZP6ZA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5ZP6ZA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BEF1F000E9;
	Mon, 24 Aug 2026 13:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787579691;
	bh=mMEWnFfYvTxQNqiOMEx1IeMVFwh/BAK6dEfy27Cns6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5ZP6ZA0oXRVNKM5HKt/vTeyjAhRczHAUPN+jsCeIxP3g/Ntar96nRGC8X+js3zwO
	 2HgcDp3yKTtXKin7epfauL8Uyrp4wyiUIfAMa00Nhiii27ljDzhQEPreVBW4RUzNaY
	 9AQLwdrH4o8NjIGD1m7U4HVZ4xmuMJtipxrNVwFXaFNw5b9+3m2BU+vzcZAxTGGOGT
	 q2jsqQYGsxv8zdLPRihRoXvyO2dWWH41xSGNpaFOW3g7HSv8uDFTzNE5eYW1MoLI/+
	 bemGD2lBA5XdsgK90JOMukFpg/wdIq2biBI4RVMkvjurEvwMM+zWzHNK1XBLoFkgTs
	 bImZOM4wm4e5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/3] bpf, arena: check range_tree_set return
 in arena_free_pages and arena_free_worker
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824134016.2006188-4-chenyuan_fl@163.com>
References: <20260824134016.2006188-1-chenyuan_fl@163.com>
 <20260824134016.2006188-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:54:51 +0000
Message-Id: <20260824135451.79BEF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Re-arming irq_work in arena_free_worker() bypasses teardown sy=
nchronization, leading to UAF of the bpf_arena structure on map destruction.
- [High] Immediate, unconditional retry in arena_free_worker() when range_t=
ree_set() fails creates a tight CPU busy-loop and livelock.
- [High] Aborting arena_free_pages() on range_tree_set() failure silently l=
eaks physical memory and memcg quota during the arena's lifetime.

Pre-existing issues:
- [High] Calling apply_to_existing_page_range() while holding raw_res_spin_=
lock_irqsave violates lock wait-type nesting rules (LD_WAIT_SPIN > LD_WAIT_=
CONFIG).
--

--- Patch [3]: [PATCH bpf-next v4 3/3] bpf, arena: check range_tree_set ret=
urn in arena_free_pages and arena_free_worker ---
commit 5874fa92054ab81b6a7b82ddf6fae39167bcb8d3
Author: Yuan Chen <chenyuan@kylinos.cn>
Subject: bpf, arena: check range_tree_set return in arena_free_pages and ar=
ena_free_worker

This commit handles errors from range_tree_set() in arena_free_pages() and
arena_free_worker(). It aborts the free operation on failure to avoid clear=
ing
PTEs for untracked pages, and modifies arena_free_worker() to requeue failed
spans for later retry.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..169b2e71e9cbb 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -881,7 +883,18 @@ static void arena_free_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt,
>  	if (ret)
>  		goto defer;
> =20
> -	range_tree_set(&arena->rt, pgoff, page_cnt);
> +	ret =3D range_tree_set(&arena->rt, pgoff, page_cnt);
> +	if (ret) {
> +		/*
> +		 * range_tree_set() is failure-atomic, so -ENOMEM leaves the
> +		 * range allocated and the pages mapped. Abort the free rather
> +		 * than returning pages the free tree does not track; a later
> +		 * free of the same range can succeed.
> +		 */
> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		return;
> +	}

[Severity: High]
When range_tree_set() fails here, does returning early permanently leak
physical pages and memcg quota if this is called from the unwind path in
arena_alloc_pages()?

If arena_alloc_pages() fails partway through, it calls arena_free_pages()
to unwind. If this early return is hit, the physical pages remain mapped and
allocated. Since the original allocation returns 0, the BPF program cannot
free these pages later.

> =20
>  	init_llist_head(&free_pages);
>  	cdata.arena =3D arena;

[ ... ]

> @@ -992,28 +1006,43 @@ static void arena_free_worker(struct work_struct *=
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
> +			llist_add(&s->node, &arena->free_spans);
> +			retry =3D true;
> +			continue;
> +		}
> +
>  		/* clear ptes and collect pages in free_pages llist */
>  		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
>  					     apply_range_clear_cb, &cdata);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
apply_to_existing_page_range() here violate lock wait-type nesting rules?

This code executes while holding the raw_res_spin_lock_irqsave() raw
spinlock. apply_to_existing_page_range() walks page tables and acquires the
page table lock (PTL). The PTL is a spinlock_t, which maps to a sleepable
rt_mutex on PREEMPT_RT kernels. Acquiring a sleepable lock inside a raw lock
can cause a scheduling while atomic bug.

> -
> -		range_tree_set(&arena->rt, pgoff, page_cnt);
> +		llist_add(&s->node, &cleared);
>  	}
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> =20
> +	if (retry)
> +		irq_work_queue(&arena->free_irq);

[Severity: High]
Can this unconditional retry create a tight CPU busy-loop and livelock?

If range_tree_set() fails (e.g., from -ENOMEM due to memory cgroup limits),
it sets retry =3D true and queues arena->free_irq without any backoff. This
immediately reschedules the worker. Since no memory was freed, it seems it
will likely hit -ENOMEM again indefinitely.

[Severity: Critical]
Does re-arming irq_work here bypass teardown synchronization and lead to a
use-after-free of the bpf_arena structure?

During map destruction, arena_map_free() calls flush_work(&arena->free_work)
to wait for the worker to finish. However, flush_work() does not wait for
newly queued irq_work.=20

If arena_map_free() proceeds to free the arena, the pending IPI might
execute arena_free_irq() and schedule_work(), dereferencing the freed
arena pointer.

> +
>  	/* Iterate the list again without holding spinlock to do the tlb flush =
and zap_pages */
> -	llist_for_each_safe(pos, t, list) {
> +	llist_for_each_safe(pos, t, cleared.first) {
>  		s =3D llist_entry(pos, struct arena_free_span, node);
>  		page_cnt =3D s->page_cnt;
>  		full_uaddr =3D clear_lo32(user_vm_start) + s->uaddr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824134016.2006=
188-1-chenyuan_fl@163.com?part=3D3
