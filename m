Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875882;
	b=pTtgIMAFj7Sj7LlQ53thN9r4FMjAA7tVIDbAl45WyDDx9ItLj1GK0Q1nay5C2RAElX2u
	 b/R8tTbzNIqt1inbK+X3WatnR+EyS2LNugwKr4t3MmpqmrobElTmpr3LQK4qNSfxILV88
	 TW02Vd3tICgYIB+7UjnfzuPfPWUvdUKFlFZlaubDQAS2qSGqLpyx20Xs9Vq+Tfd1qtPy7
	 +pRO5GW5DwTWC/auhaIBXeLl3x6Td4Zy33Xi4lBX5MPqstqnG4sDShwBuc1B3z0HvuBzC
	 iCQxYABcjSV5JmvsvyoG0xBG+b8RSKiYQ9jl4HLzGaiCQS6E7eUGhcpOkgy0CGCNf4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U2OgTY2zzZOYcKTAxeLonQ+/L5osGPHHb4jgaI1ZuJ8=;
	b=o+bU6radK7DxeAysGoG9nPWqsQe80J+mXF/3N4/TAdCLpmM7Hem2HAjsgQoEmM2wQtSu
	 Os8H9Pls9zuiRoqa+Zamv84Y6eocUfLk1lY9H/bmpKIDM8/TS7Wvpq9taoy+LGSOWO+d4
	 Ps0/H+lmyG80RLIJ/ghWdNOLuDsk4RzMTsH7iLFYq3wDiSoVbPVxM84pLJ5z2Gvoxx2ao
	 TgGqG8jISq6ej6r4WpeQSG2LYp4E9+mqppz3n4X/L3GM01vc+qbsTvELg0boYR48OyBRz
	 5UuQXQ0ywZqvzBUSdHnr3ymccP7EGIeD+hpoPVHr9bnQH50Z+BYHXNED0eDMLJjCi5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY+X78UC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86F606A31F
	for <bpf@vger.kernel.org>; Sat, 28 Nov 2026 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bY+X78UC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E328C1F000C1;
	Sat, 28 Nov 2026 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795875882;
	bh=U2OgTY2zzZOYcKTAxeLonQ+/L5osGPHHb4jgaI1ZuJ8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bY+X78UCKedAF2wmLmpYLEn6NvNj4Xr2moCHJKERfCE0vhOdcwT5l0C1KTDwsJ+PG
	 G4/EdCq0UpDd3gHiVUJILe2m9VLUnpS5inMuOIhEe6p+dhR6HfKst3sYSx6awztydI
	 RKCOJ6Sb35pEWc6cbT6mZvNCJbb8eY/tHrSEnj1W74F5dFcUOYkhgV0wQON0uWa5fN
	 jGquEuem5mRpSnc7gMNyV9AjmQh5jUqJFynwLvn+K9FfQnH99foAkgXsn+xgJ+/NMa
	 LfA6TY+okaXdisYVOY7HkE3IlT/DIOnXYP6QqDRwbcC5Et60CdWRv8koOrR2sd09so
	 O9Emd5XJ0mRCQ==
Message-ID: <sashiko-outbox-238772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: defer reuse of LRU hash elements until after an
 RCU grace period
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zheng Shuhao" <viennaoffh@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <179587316462.32208.2314387285324230199@gmail.com>
References: <179587316462.32208.2314387285324230199@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 14:24:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] bpf: deferred RCU eviction in bpf_lru_pop_free() breaks BPF
  helper updates
- [High] bpf: deferred free on pending_list in bpf_common_lru_pop_free()
  over-evicts
- [High] bpf: race in bpf_lru_rcu_work() and bpf_lru_rcu_done() strands
  rcu_pending
- [High] bpf: uninterruptible wait_event() starvation in
  bpf_lru_wait_for_rcu()
- [Medium] bpf: TOCTOU race in bpf_lru_wait_for_rcu() causes spurious
  -ENOMEM
- [Medium] bpf: unbounded O(N) scans in __bpf_lru_list_reclaim_ready()
  under spinlock
- [Medium] bpf: unconditional rcu_barrier() on every LRU map teardown in
  bpf_lru_destroy()
- [Medium] bpf: element size growth and struct bpf_lru cacheline false
  sharing
- [Low] bpf: multi-line comment style violation in
  __htab_map_lookup_and_delete_batch()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] bpf: leak of BTF special fields in free_htab_elem() [1]
--

commit 6f012b4323f692e697fe8368116995d6c2073ba1
Author: Zheng Shuhao <viennaoffh@gmail.com>

bpf: defer reuse of LRU hash elements until after an RCU grace period

This commit defers returning removed LRU hash map elements to the free pool
until after an RCU grace period, and adds a wait-and-retry path for syscall
map updates that encounter -ENOMEM while deferred elements are pending.

Link: https://syzkaller.appspot.com/bug?extid=3D542d2bc50fc9545a27d6

> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> index 3858886b0232f..b8a9a39f40952 100644
> --- a/kernel/bpf/bpf_lru_list.c
> +++ b/kernel/bpf/bpf_lru_list.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2016 Facebook
>   */
>  #include <linux/cpumask.h>
> +#include <linux/rcupdate.h>
>  #include <linux/spinlock.h>
>  #include <linux/percpu.h>
> =20
> @@ -26,6 +27,77 @@ static void bpf_lru_node_clear_ref(struct bpf_lru_node=
 *node)
>  	WRITE_ONCE(node->ref, 0);
>  }
> =20
> +static u8 bpf_lru_node_pending_free(const struct bpf_lru_node *node)
> +{
> +	/* Pair with the release store after the RCU grace period. */
> +	return smp_load_acquire(&node->pending_free);
> +}
> +
> +static void bpf_lru_node_set_free_ready(struct bpf_lru_node *node)
> +{
> +	/* Publish readiness only after the RCU grace period has elapsed. */
> +	smp_store_release(&node->pending_free, BPF_LRU_FREE_READY);
> +}
> +
> +static void bpf_lru_rcu_done(struct rcu_head *rcu)
> +{
> +	struct bpf_lru *lru =3D container_of(rcu, struct bpf_lru, rcu);
> +	struct llist_node *node, *next;
> +
> +	node =3D llist_del_all(&lru->rcu_waiting);
> +	while (node) {
> +		struct bpf_lru_node *lru_node;
> +
> +		next =3D node->next;
> +		lru_node =3D container_of(node, struct bpf_lru_node, rcu_node);
> +		bpf_lru_node_set_free_ready(lru_node);
> +		node =3D next;
> +	}
> +
> +	atomic_set(&lru->rcu_in_progress, 0);
> +	wake_up_all(&lru->rcu_wait);
> +	if (!llist_empty(&lru->rcu_pending))
> +		irq_work_queue(&lru->rcu_work);
> +}
> +
> +static void bpf_lru_rcu_work(struct irq_work *work)
> +{
> +	struct bpf_lru *lru =3D container_of(work, struct bpf_lru, rcu_work);
> +	struct llist_node *node, *next;
> +
> +	if (atomic_xchg(&lru->rcu_in_progress, 1))
> +		return;
> +
> +	node =3D llist_del_all(&lru->rcu_pending);
> +	if (!node) {
> +		atomic_set(&lru->rcu_in_progress, 0);
> +		wake_up_all(&lru->rcu_wait);
> +		return;
> +	}

[Severity: High]
Can a concurrent bpf_lru_node_defer_free() race with the !node exit path in
bpf_lru_rcu_work() and leave nodes stranded on lru->rcu_pending?

CPU0                              CPU1
bpf_lru_rcu_work()
  atomic_xchg(&lru->rcu_in_progress, 1) -> 0
  llist_del_all(&lru->rcu_pending) -> NULL
                                  bpf_lru_node_defer_free()
                                    llist_add(..., &lru->rcu_pending)
                                    irq_work_queue(&lru->rcu_work)
                                  <irq_work>
                                    bpf_lru_rcu_work()
                                      atomic_xchg(..., 1) -> 1
                                      return;
  atomic_set(&lru->rcu_in_progress, 0)
  return;                         <-- rcu_pending non-empty, no work queued

The same race also exists in bpf_lru_rcu_done() because atomic_set() is not
ordered by a full memory barrier before llist_empty(&lru->rcu_pending).
Once a node is stranded on lru->rcu_pending with rcu_in_progress =3D=3D 0,
callers of bpf_lru_wait_for_rcu() sleep forever in wait_event() and
bpf_lru_destroy() spins indefinitely on map teardown.

[ ... ]

> @@ -107,6 +179,50 @@ static void __bpf_lru_node_move(struct bpf_lru_list =
*l,
>  	list_move(&node->list, &l->lists[tgt_type]);
>  }
> =20
> +static unsigned int
> +__bpf_lru_list_reclaim_ready(struct bpf_lru_list *l,
> +			     unsigned int tgt_nshrink,
> +			     struct list_head *free_list,
> +			     enum bpf_lru_list_type tgt_free_type,
> +			     bool *has_pending)
> +{
> +	struct bpf_lru_node *node, *tmp_node;
> +	unsigned int nshrinked =3D 0;
> +	int type;
> +
> +	*has_pending =3D false;
> +	for (type =3D BPF_LRU_LIST_T_ACTIVE; type <=3D BPF_LRU_LIST_T_INACTIVE;
> +	     type++) {
> +		list_for_each_entry_safe_reverse(node, tmp_node,
> +						 &l->lists[type], list) {
> +			u8 pending_free =3D bpf_lru_node_pending_free(node);
> +
> +			if (pending_free !=3D BPF_LRU_FREE_READY)
> +				continue;
> +
> +			__bpf_lru_node_move_to_free(l, node, free_list,
> +						    tgt_free_type);
> +			if (++nshrinked =3D=3D tgt_nshrink)
> +				return nshrinked;
> +		}
> +	}
> +
> +	if (!nshrinked) {
> +		for (type =3D BPF_LRU_LIST_T_ACTIVE;
> +		     type <=3D BPF_LRU_LIST_T_INACTIVE; type++) {
> +			list_for_each_entry(node, &l->lists[type], list) {
> +				if (bpf_lru_node_pending_free(node) =3D=3D
> +				    BPF_LRU_FREE_PENDING) {
> +					*has_pending =3D true;
> +					return 0;
> +				}
> +			}
> +		}
> +	}
> +
> +	return nshrinked;
> +}

[Severity: Medium]
Does __bpf_lru_list_reclaim_ready() walk the entire active and inactive
lists up to twice while holding l->lock with interrupts disabled?

Unlike __bpf_lru_list_rotate_active(), __bpf_lru_list_rotate_inactive(),
and __bpf_lru_list_shrink_inactive(), which bound their scans to
lru->nr_scans, this function traverses up to 2 * max_entries nodes under
raw spinlocks.  In addition, returning early in __bpf_lru_list_shrink()
whenever has_pending is true or when nshrinked is non-zero but less than
tgt_nshrink prevents __bpf_lru_list_shrink_inactive() from evicting
inactive entries or refilling a full target_free batch as soon as a single
node is pending or ready.

[ ... ]

> @@ -201,15 +317,21 @@ __bpf_lru_list_shrink_inactive(struct bpf_lru *lru,
>  	unsigned int i =3D 0;
> =20
>  	list_for_each_entry_safe_reverse(node, tmp_node, inactive, list) {
> -		if (bpf_lru_node_is_ref(node) &&
> -		    !READ_ONCE(node->pending_free)) {
> -			__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_ACTIVE);
> -		} else if (READ_ONCE(node->pending_free) ||
> -			   lru->del_from_htab(lru->del_arg, node)) {
> +		u8 pending_free =3D bpf_lru_node_pending_free(node);
> +
> +		if (pending_free =3D=3D BPF_LRU_FREE_PENDING) {
> +			return nshrinked + 1;
> +		} else if (pending_free =3D=3D BPF_LRU_FREE_READY) {
>  			__bpf_lru_node_move_to_free(l, node, free_list,
>  						    tgt_free_type);
>  			if (++nshrinked =3D=3D tgt_nshrink)
>  				break;
> +		} else if (bpf_lru_node_is_ref(node)) {
> +			__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_ACTIVE);
> +		} else if (lru->del_from_htab(lru->del_arg, node)) {
> +			bpf_lru_node_defer_free(lru, node);
> +			if (++nshrinked =3D=3D tgt_nshrink)
> +				break;
>  		}
> =20
>  		if (++i =3D=3D lru->nr_scans)
> @@ -250,6 +372,12 @@ static unsigned int __bpf_lru_list_shrink(struct bpf=
_lru *lru,
>  	struct bpf_lru_node *node, *tmp_node;
>  	struct list_head *force_shrink_list;
>  	unsigned int nshrinked;
> +	bool has_pending;
> +
> +	nshrinked =3D __bpf_lru_list_reclaim_ready(l, tgt_nshrink, free_list,
> +						 tgt_free_type, &has_pending);
> +	if (nshrinked || has_pending)
> +		return nshrinked ? nshrinked : 1;
> =20
>  	nshrinked =3D __bpf_lru_list_shrink_inactive(lru, l, tgt_nshrink,
>  						   free_list, tgt_free_type);
> @@ -264,11 +392,17 @@ static unsigned int __bpf_lru_list_shrink(struct bp=
f_lru *lru,
> =20
>  	list_for_each_entry_safe_reverse(node, tmp_node, force_shrink_list,
>  					 list) {
> -		if (READ_ONCE(node->pending_free) ||
> -		    lru->del_from_htab(lru->del_arg, node)) {
> +		u8 pending_free =3D bpf_lru_node_pending_free(node);
> +
> +		if (pending_free =3D=3D BPF_LRU_FREE_PENDING) {
> +			return 1;
> +		} else if (pending_free =3D=3D BPF_LRU_FREE_READY) {
>  			__bpf_lru_node_move_to_free(l, node, free_list,
>  						    tgt_free_type);
>  			return 1;
> +		} else if (lru->del_from_htab(lru->del_arg, node)) {
> +			bpf_lru_node_defer_free(lru, node);
> +			return 1;
>  		}
>  	}

[Severity: High]
Does deferring newly evicted nodes in __bpf_lru_list_shrink_inactive(),
__bpf_lru_list_shrink(), and __local_list_pop_pending() without adding any
node to free_list cause bpf_map_update_elem() called from BPF programs to
fail with -ENOMEM once the map is full?

When an LRU map has no pre-existing BPF_LRU_FREE_READY nodes, eviction only
queues deleted entries to lru->rcu_pending and leaves free_list empty, so
prealloc_lru_pop() returns NULL.  Because non-sleepable BPF programs run
inside an RCU read-side critical section and do not use the syscall retry
loop in bpf_map_update_value(), the grace period for the evicted entries
cannot finish during program execution, causing BPF helper updates to evict
live entries and fail with -ENOMEM.

> @@ -283,7 +417,9 @@ static void __local_list_flush(struct bpf_lru_list *l,
> =20
>  	list_for_each_entry_safe_reverse(node, tmp_node,
>  					 &loc_l->pending_list, list) {
> -		if (READ_ONCE(node->pending_free))
> +		if (bpf_lru_node_pending_free(node) =3D=3D BPF_LRU_FREE_PENDING)
> +			continue;
> +		else if (bpf_lru_node_pending_free(node) =3D=3D BPF_LRU_FREE_READY)
>  			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_FREE);
>  		else if (bpf_lru_node_is_ref(node))
>  			__bpf_lru_node_move_in(l, node, BPF_LRU_LIST_T_ACTIVE);

[ ... ]

> @@ -381,12 +504,20 @@ __local_list_pop_pending(struct bpf_lru *lru, struc=
t bpf_lru_locallist *loc_l)
>  ignore_ref:
>  	/* Get from the tail (i.e. older element) of the pending list. */
>  	list_for_each_entry_reverse(node, &loc_l->pending_list, list) {
> +		if (bpf_lru_node_pending_free(node) =3D=3D BPF_LRU_FREE_PENDING)
> +			continue;
> +
>  		if ((!bpf_lru_node_is_ref(node) || force) &&
> -		    (READ_ONCE(node->pending_free) ||
> -		     lru->del_from_htab(lru->del_arg, node))) {
> +		    bpf_lru_node_pending_free(node) =3D=3D BPF_LRU_FREE_READY) {
>  			list_del(&node->list);
>  			return node;
>  		}
> +
> +		if ((!bpf_lru_node_is_ref(node) || force) &&
> +		    lru->del_from_htab(lru->del_arg, node)) {
> +			bpf_lru_node_defer_free(lru, node);
> +			return NULL;
> +		}
>  	}

[Severity: High]
When __bpf_lru_list_shrink() defers nodes on the global list and leaves
tmp_free empty, doesn't bpf_common_lru_pop_free() fall through into its
cross-CPU steal loop and evict one live pending entry from every CPU?

kernel/bpf/bpf_lru_list.c:bpf_common_lru_pop_free() {
    ...
	do {
		steal_loc_l =3D per_cpu_ptr(clru->local_list, steal);

		if (!raw_res_spin_lock_irqsave(&steal_loc_l->lock, flags)) {
			node =3D __local_list_pop_free(steal_loc_l);
			if (!node)
				node =3D __local_list_pop_pending(lru, steal_loc_l);
			raw_res_spin_unlock_irqrestore(&steal_loc_l->lock, flags);
		}

		steal =3D cpumask_next_wrap(steal, cpu_possible_mask);
	} while (!node && steal !=3D first_steal);
    ...
}

Because __local_list_pop_pending() returns NULL after unlinking a live node
via lru->del_from_htab(), the do-while loop does not stop after one
eviction and instead sweeps all possible CPUs.  In addition,
__local_list_flush() leaves BPF_LRU_FREE_PENDING nodes on
loc_l->pending_list where __bpf_lru_list_reclaim_ready() never scans them,
and __local_list_pop_pending() skips BPF_LRU_FREE_READY nodes that still
have node->ref set on the !force pass while evicting older unreferenced
live nodes ahead of newer ready nodes.

[ ... ]

> @@ -585,6 +713,25 @@ void bpf_lru_push_free(struct bpf_lru *lru, struct b=
pf_lru_node *node)
>  		bpf_common_lru_push_free(lru, node);
>  }
> =20
> +void bpf_lru_defer_free(struct bpf_lru *lru, struct bpf_lru_node *node)
> +{
> +	bpf_lru_node_defer_free(lru, node);
> +}
> +
> +bool bpf_lru_wait_for_rcu(struct bpf_lru *lru)
> +{
> +	if (!atomic_read(&lru->rcu_in_progress) &&
> +	    llist_empty(&lru->rcu_pending) &&
> +	    llist_empty(&lru->rcu_waiting))
> +		return false;
> +
> +	wait_event(lru->rcu_wait,
> +		   !atomic_read(&lru->rcu_in_progress) &&
> +		   llist_empty(&lru->rcu_pending) &&
> +		   llist_empty(&lru->rcu_waiting));
> +	return true;
> +}

[Severity: High]
Can wait_event() in bpf_lru_wait_for_rcu() starve a syscall thread in
TASK_UNINTERRUPTIBLE sleep under steady concurrent map updates or deletes?

If new nodes are queued onto lru->rcu_pending while an RCU grace period is
in flight, llist_empty(&lru->rcu_pending) is already false when
bpf_lru_rcu_done() sets rcu_in_progress to 0 and calls wake_up_all(), and
bpf_lru_rcu_work() sets rcu_in_progress back to 1 before draining
rcu_pending into rcu_waiting.  As a result, the three conditions are never
simultaneously true across back-to-back grace periods even though the
batch the caller needed has already become BPF_LRU_FREE_READY.

[ ... ]

> @@ -720,6 +873,14 @@ int bpf_lru_init(struct bpf_lru *lru, bool percpu, u=
32 hash_offset,
> =20
>  void bpf_lru_destroy(struct bpf_lru *lru)
>  {
> +	do {
> +		irq_work_sync(&lru->rcu_work);
> +		rcu_barrier();
> +		irq_work_sync(&lru->rcu_work);
> +	} while (atomic_read(&lru->rcu_in_progress) ||
> +		 !llist_empty(&lru->rcu_pending) ||
> +		 !llist_empty(&lru->rcu_waiting));
> +
>  	if (lru->percpu)
>  		free_percpu(lru->percpu_lru);
>  	else

[Severity: Medium]
Does this do-while loop force a system-wide rcu_barrier() on every LRU map
destruction even when no RCU callback is pending?

Checking atomic_read(&lru->rcu_in_progress), llist_empty(&lru->rcu_pending),
and llist_empty(&lru->rcu_waiting) after an initial irq_work_sync() in a
while loop would avoid stalling map teardown and bpf_map_free_deferred
workers when no grace period is in flight.

> diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
> index 8d0ee61622af0..a0f36a8c5b270 100644
> --- a/kernel/bpf/bpf_lru_list.h
> +++ b/kernel/bpf/bpf_lru_list.h
> @@ -33,11 +36,15 @@ struct bpf_lru_node {
>  	u16 cpu;
>  	u8 type;
>  	u8 ref;
> -	/*
> -	 * Marks nodes whose *_push_free() lock acquire failed; reclaimed
> -	 * by flush/shrink which honor the flag instead of del_from_htab().
> -	 */
> +	/* Tracks whether this node is waiting for, or ready after, an RCU grac=
e period. */
>  	u8 pending_free;
> +	struct llist_node rcu_node;
> +};
> +
> +enum bpf_lru_free_state {
> +	BPF_LRU_FREE_NONE,
> +	BPF_LRU_FREE_PENDING,
> +	BPF_LRU_FREE_READY,
>  };
> =20
>  struct bpf_lru_list {
> @@ -74,6 +81,12 @@ struct bpf_lru {
>  	unsigned int target_free;
>  	unsigned int nr_scans;
>  	bool percpu;
> +	struct llist_head rcu_pending;
> +	struct llist_head rcu_waiting;
> +	struct irq_work rcu_work;
> +	struct rcu_head rcu;
> +	atomic_t rcu_in_progress;
> +	wait_queue_head_t rcu_wait;
>  };

[Severity: Medium]
Does adding rcu_node to struct bpf_lru_node and placing rcu_pending right
after percpu in struct bpf_lru introduce cacheline false sharing and push
64-byte LRU elements across two cachelines?

Growing struct bpf_lru_node from 24 to 32 bytes increases
offsetof(struct htab_elem_lru, elem) from 32 to 40 bytes, so every
preallocated element with an 8-byte key and 8-byte value grows from 64 to
72 bytes.  In struct bpf_lru, rcu_pending, rcu_waiting, and rcu_work also
land in the same 64-byte cacheline as the read-mostly configuration fields
(del_from_htab, del_arg, hash_offset, target_free, nr_scans, and percpu),
so atomic updates in bpf_lru_node_defer_free() dirty the cacheline read on
every bpf_lru_pop_free().

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b8491105430a9..8c5a42348df91 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -1505,11 +1518,15 @@ static long htab_map_update_elem(struct bpf_map *=
map, void *key, void *value,
>  	return ret;
>  }
> =20
> -static void htab_lru_push_free(struct bpf_htab *htab, struct htab_elem *=
elem)
> +static void htab_lru_free_elem(struct bpf_htab *htab, struct htab_elem *=
elem,
> +			       bool defer)
>  {
>  	check_and_cancel_fields(htab, elem);
>  	bpf_map_dec_elem_count(&htab->map);
> -	bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
> +	if (defer)
> +		bpf_lru_defer_free(&htab->lru, htab_elem_lru_node(elem));
> +	else
> +		bpf_lru_push_free(&htab->lru, htab_elem_lru_node(elem));
>  }

[Severity: Critical]
This problem wasn't introduced by this patch, but when preallocated elements
are recycled in htab_lru_free_elem() and free_htab_elem() [1], does
calling only check_and_cancel_fields() without bpf_obj_free_fields() leak
BTF special fields such as kptrs and list heads?

check_and_cancel_fields() only cancels timers, workqueues, and task_work,
and copy_map_value() skips overwriting special fields when the element is
reallocated from the freelist, allowing the recycled element to inherit
stale references that can lead to a use-after-free or double free.

[ ... ]

> @@ -2181,10 +2198,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map=
 *map,
>  		if (do_delete) {
>  			hlist_nulls_del_rcu(&l->hash_node);
> =20
> -			/* bpf_lru_push_free() will acquire lru_lock, which
> -			 * may cause deadlock. See comments in function
> -			 * prealloc_lru_pop(). Let us do bpf_lru_push_free()
> -			 * after releasing the bucket lock.
> +			/* Keep LRU element cleanup outside the bucket lock.
> +			 * The immediate-free path takes lru_lock, and special-field
> +			 * cleanup may synchronize with other contexts. See the lock
> +			 * ordering documented above prealloc_lru_pop().

[Severity: Low]
This isn't a bug, but BPF multi-line comment style puts the opening /* on
its own line with the comment text starting on the next line.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 198438b958495..16216060bb102 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -303,6 +303,14 @@ static int bpf_map_update_value(struct bpf_map *map,=
 struct file *map_file,
>  	}
>  	bpf_enable_instrumentation();
> =20
> +	if (err =3D=3D -ENOMEM &&
> +	    (map->map_type =3D=3D BPF_MAP_TYPE_LRU_HASH ||
> +	     map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH) &&
> +	    bpf_lru_hash_wait_for_rcu(map)) {
> +		cond_resched();
> +		goto retry_update;
> +	}
> +
>  	return err;
>  }

[Severity: Medium]
Can bpf_lru_hash_wait_for_rcu() return false and cause
bpf_map_update_value() to fail with a spurious -ENOMEM when the RCU grace
period finishes just before bpf_lru_wait_for_rcu() checks the queues?

If bpf_lru_rcu_done() completes on another CPU after prealloc_lru_pop()
failed to find a ready node (or if a concurrent bpf_lru_node_defer_free()
set node->pending_free to BPF_LRU_FREE_PENDING via cmpxchg() but has not
yet executed llist_add(&node->rcu_node, &lru->rcu_pending)),
rcu_in_progress, rcu_pending, and rcu_waiting are all empty when
bpf_lru_wait_for_rcu() runs, so it returns false without retrying to pop
the newly ready nodes.

[1] https://sashiko.dev/#/bug/linux-57e88db9-923a-496e-bab2-71962f45f071

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179587316462.32208.=
2314387285324230199@gmail.com?part=3D1
