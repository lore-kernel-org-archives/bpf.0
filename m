Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7C7414416
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270647; cv=none; b=FrdD5gR/tKs2S0sEGc5aBNbK2JZaIMePcpzHafOAEp5JAufjnU/axATnqU1tdCl+9Z17/Dj0z8lEDFapOC2cxGvpRNNmtsLrVKtLMAKO2NzOfNMAxsFcdaTF9X08K8jY1Aqdo//f6lRQyzV3L+MHdU6Zuj2FUpfgge3qA8iTG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270647; c=relaxed/simple;
	bh=8AwjF6e5b3SnZpTCa7I1/NhywMY6hD2wu+OFU9YsQiw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dMTt/tC2/6AyRd+vA5XfXEnGWOqJNQcfakvZL4iFadY1f8/HnOYVMX7B8Cd+RZPOCf29J6GIZ6mSWVyBAv36rtIsA+D/0YXUbDUe5ZN1/gIVZRS+F8NUapaSE3rcjfgJEIxUonk284YgwE3gvn5CzFHE8KLgD/EsOH4UBEaV3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ6qUuwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ6qUuwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5AC1F000FF;
	Thu, 24 Sep 2026 17:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270645;
	bh=cP8IY0pEuwX9EQEVUvzioOYl/7ZWxeujsAJhTHFl6DE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VZ6qUuwJuDBV8vZy+E3exWctmucCxmjKfMlO4IiEngfbP8g9ESQwBQqkNTwdUxjR7
	 KWrHNGjV2cVROVI5whQdcH2hFOenel460Hhr48xgOMHkhG9AlbJNO2XpdO3qFnmyfj
	 hvP/G4ShOLh9QCDsQreAIlhuqLX0Ebr4Zb+RuXoEhBty2VzgBzeWjaZgWx2z/kZ9/X
	 98flKM1hWz89SMMz6EUqy6bPqCMfp0dt8eaZ9lN+5nZOlZaw1PJl8bvz8IZokhbO42
	 ZlVshsXSKxTHjX8CqTDjGZRShvSwbGQycusfaHjtRGI25GNH+LaB01ipv+xVqPT954
	 ff8HmkbmBxzNQ==
Content-Type: multipart/mixed; boundary="===============3691704727841175457=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <faeb5da58117dbe9f0e18ec025d8d4071c10659919e9af427e5b5dc658e93b64@mail.kernel.org>
In-Reply-To: <20260924162858.2435106-2-puranjay@kernel.org>
References: <20260924162858.2435106-2-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Support bpf_rcu_head in hash and LRU hash maps
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 17:24:03 +0000 (UTC)

--===============3691704727841175457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8594c8aff745..afdf22cf5a7a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -111,6 +111,8 @@ struct bpf_map_ops {
>  	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
>  	long (*map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags);
>  	long (*map_delete_elem)(struct bpf_map *map, void *key);
> +	/* Release an element a bpf_rcu_head callback was holding. */
> +	void (*map_release_elem)(struct bpf_map *map, void *value);
>  	long (*map_push_elem)(struct bpf_map *map, void *value, u64 flags);
>  	long (*map_pop_elem)(struct bpf_map *map, void *value);
>  	long (*map_peek_elem)(struct bpf_map *map, void *value);

[ ... ]

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 53c99fe4f176..b5555b43147d 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -904,6 +910,11 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>  	int ret;
>
>  	tgt_l = container_of(node, struct htab_elem, lru_node);
> +
> +	/* An element a callback still needs cannot be evicted. */
> +	if (bpf_rcu_head_busy(&htab->map, htab_elem_value(tgt_l, htab->map.key_size)))
> +		return false;
> +
>  	b = __select_bucket(htab, tgt_l->hash);
>  	head = &b->head;
>
> @@ -914,15 +925,24 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
>  	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
>  		if (l == tgt_l) {
>  			hlist_nulls_del_rcu(&l->hash_node);
> -			bpf_map_dec_elem_count(&htab->map);
>  			break;
>  		}
>
>  	htab_unlock_bucket(b, flags);
>
> -	if (l == tgt_l)
> -		check_and_cancel_fields(htab, l);
> -	return l == tgt_l;
> +	if (l != tgt_l)
> +		return false;
> +
> +	/*
> +	 * An arm can land after the check above. The element is already unlinked
> +	 * by now, so map_release_elem() finishes the handoff to the free list.
> +	 */
> +	if (bpf_rcu_head_claim(&htab->map, htab_elem_value(l, htab->map.key_size)))
> +		return false;
> +
> +	bpf_map_dec_elem_count(&htab->map);
> +	check_and_cancel_fields(htab, l);
> +	return true;
>  }

When htab_lru_map_delete_node() returns false for a busy element, can the
LRU force-shrink loop scan the whole list with IRQs disabled?

Looking at __bpf_lru_list_shrink() in kernel/bpf/bpf_lru_list.c, the
force_shrink_list walk is not bounded by nr_scans:

    list_for_each_entry_safe_reverse(node, tmp_node, force_shrink_list,
                                     list) {
            if (READ_ONCE(node->pending_free) ||
                lru->del_from_htab(lru->del_arg, node)) {
                    __bpf_lru_node_move_to_free(l, node, free_list,
                                                tgt_free_type);
                    return 1;
            }
    }

It runs under raw_res_spin_lock_irqsave(&l->lock), which is either the
global LRU list lock in bpf_lru_list_pop_free_to_local() or the per-CPU
list lock in bpf_percpu_lru_pop_free().

Before this patch, del_from_htab() almost always succeeded on the first
node. Now every busy element returns false and the loop moves on.

The commit message says a callback can be re-armed from inside itself, so
elements can stay ARMED or RUNNING indefinitely. If most of the inactive
list (or the active list when inactive is empty) is busy, then every LRU
insert that needs a free node walks the entire list with IRQs off, up to
max_entries nodes.

For large maps, wouldn't this create IRQs-off latency of milliseconds per
update from any program context, with waiters potentially hitting
rqspinlock timeouts?

[ ... ]

> @@ -1110,6 +1149,17 @@ static bool fd_htab_map_needs_adjust(const struct bpf_htab *htab)
>  	return is_fd_htab(htab) && BITS_PER_LONG == 64;
>  }
>
> +/*
> + * On update a preallocated htab stashes the old element in this CPU's spare
> + * instead of freeing it. An element with a queued callback cannot be reused
> + * that way, so those maps release it through free_htab_elem() instead.
> + */
> +static bool htab_stashes_old_elem(const struct bpf_htab *htab)
> +{
> +	return htab_is_prealloc(htab) &&
> +	       !btf_record_has_field(htab->map.record, BPF_RCU_HEAD);
> +}
> +
>  static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  					 void *value, u32 key_size, u32 hash,
>  					 bool percpu, bool onallcpus,
> @@ -1121,7 +1171,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  	void __percpu *pptr;
>
>  	if (prealloc) {
> -		if (old_elem) {
> +		if (old_elem && htab_stashes_old_elem(htab)) {
>  			/* if we're updating the existing element,
>  			 * use per-cpu extra elems to avoid freelist_pop/push
>  			 */
> @@ -1132,9 +1182,18 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
>  			struct pcpu_freelist_node *l;
>
>  			l = __pcpu_freelist_pop(&htab->freelist);
> -			if (!l)
> -				return ERR_PTR(-E2BIG);
> -			l_new = container_of(l, struct htab_elem, fnode);
> +			if (l) {
> +				l_new = container_of(l, struct htab_elem, fnode);
> +			} else {
> +				/* Spend the spare; freeing old_elem refills the freelist. */
> +				if (!old_elem)
> +					return ERR_PTR(-E2BIG);
> +				pl_new = this_cpu_ptr(htab->extra_elems);
> +				l_new = *pl_new;
> +				if (!l_new)
> +					return ERR_PTR(-E2BIG);
> +				*pl_new = NULL;
> +			}
>  			bpf_map_inc_elem_count(&htab->map);
>  		}
>  	} else {

For preallocated htabs that carry a bpf_rcu_head, once the per-CPU spare
is spent, is it ever refilled?

These maps get extra_elems because htab_has_extra_elems() only excludes
percpu, LRU and fd maps. prealloc_init() allocates max_entries +
num_possible_cpus() elements, and alloc_extra_elems() moves
num_possible_cpus() of them into the per-CPU spares, so the freelist
holds exactly max_entries.

Before this patch the stash path swapped old_elem with the spare, so the
two pools stayed separate and the map never held more than max_entries
elements.

With htab_stashes_old_elem() false, the new branch handles the full-map
case like this:

1. The map holds max_entries elements and the freelist is empty. An update
   of an existing key on CPU0 takes the spare (*pl_new = NULL).

2. htab_map_update_elem() calls free_htab_elem(htab, l_old) after
   unlocking the bucket:

   free_htab_elem() -> bpf_rcu_head_claim() -> __free_htab_elem() ->
   pcpu_freelist_push()

   The freelist now has one element, but the spare is still NULL. Nothing
   refills htab->extra_elems for these maps, since the stash path is the
   only writer.

3. An insert of a new key pops that freelist element, so the map now holds
   max_entries + 1 elements. bpf_map_inc_elem_count() counts it as well.

4. Repeating this on every CPU lets the map hold max_entries +
   num_possible_cpus() live entries.

5. After that, with the freelist empty and this CPU's spare NULL, every
   BPF_EXIST/BPF_ANY update of an existing key returns -E2BIG. A normal
   preallocated hash map never fails this way when it is full.

The comment "freeing old_elem refills the freelist" is only half true. It
refills the freelist rather than the spare, and when bpf_rcu_head_claim()
reports a queued callback it refills nothing until that callback finishes.

Doesn't this violate max_entries, and break replace-in-place once the map
is full?

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a284f20c97d5..2b5a5bc98233 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -4823,26 +4838,96 @@ static void bpf_rcu_run_callback(struct rcu_head *rcu)
>  	struct bpf_prog *prog = rh->prog;
>  	struct bpf_map *map = rh->map;
>  	void *value, *key;
> +	int old, state;
>  	u32 idx;
>
>  	value = (void *)rh - map->record->rcu_head_off;
>  	key = map_key_from_value(map, value, &idx);
>
> -	/* Pairs with the arming cmpxchg(): rh may be re-armed as soon as this store lands. */
> -	smp_store_release(&rh->armed, 0);
> +	/*
> +	 * Take RUNNING first, so a claim racing this always sees one of the two.
> +	 * rh may be re-armed, and its fields overwritten, once ARMED is dropped.
> +	 */
> +	old = atomic_fetch_or(RCU_HEAD_RUNNING, &rh->state);
> +	WARN_ON_ONCE(old & RCU_HEAD_RUNNING);
> +	atomic_andnot(RCU_HEAD_ARMED, &rh->state);
>
> +	/*
> +	 * Drop RUNNING under the read locks, or a re-arm could be invoked while
> +	 * this callback is still on the element. The callback picks the flavour,
> +	 * so both locks are needed.
> +	 */
> +	rcu_read_lock_trace();
>  	rcu_read_lock_dont_migrate();
>  	callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
> +	state = atomic_fetch_andnot(RCU_HEAD_RUNNING, &rh->state) & ~RCU_HEAD_RUNNING;
>  	rcu_read_unlock_migrate();
> +	rcu_read_unlock_trace();
> +
> +	/* A live element is never dead, so this only fires after a claim. */
> +	if (!(state & RCU_HEAD_BUSY) && (state & RCU_HEAD_DEAD))
> +		map->ops->map_release_elem(map, value);
>
>  	bpf_prog_put(prog);
>  }

A subsystem pattern flags this as potentially concerning:

Hash and LRU hash maps can now carry a bpf_rcu_head. So __bpf_call_rcu()
queues call_rcu() / call_rcu_tasks_trace() on an rcu_head embedded in an
htab element that is still linked into its bucket's RCU-protected
hlist_nulls.

If that element is then deleted while the callback is queued,
bpf_rcu_head_claim() sees ARMED and the delete path leaves the release to
the callback. bpf_rcu_run_callback() then returns the element to the
allocator through map->ops->map_release_elem(map, value).

The grace period it waited for began when the head was armed, which is
before the hlist_nulls_del_rcu() in the delete path. A BPF reader that
looked the element up after the call_rcu() and before the unlink is
therefore not covered by that grace period.

The RCU guide's remove-before-reclaim rule says to call call_rcu() or
kfree_rcu() after removing an object from an RCU-protected data structure,
not before.

Is the grace period starting before the unlink acceptable under htab's
existing element-reuse semantics, or should the deferred release wait for
a grace period that starts after the unlink?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36029594826
--===============3691704727841175457==--
