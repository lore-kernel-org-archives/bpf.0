Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409CD25A640
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992896; cv=none; b=S1CMHI/k/ec6CtdmU557L3GMQuQDaCGaxDmZ8mqSEvTgmkZLj4QjahMRSmJnjNLvFvnnRWa6Tqzi526EgaI8pTYuwQkbcQUS1OjO3INmo0vURArEiIDV5fRe5eEnLEPOdlkiHPfyTM5/b2+EWPhwo0Hv/ky5dZJUVzWYTjiwrq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992896; c=relaxed/simple;
	bh=gAzVRMyICUKR2XLJwsXvgTEZiY0rEbtGYrLRrraE5oQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jXIUVI3i0684jVcEIFYSDYqagE/yxoMkKC619I5hyXH28jjf9M7dYKo/rioJdzKlvn87uUgOZea8N39Oo/hZFoQ07DT3PyXO0Q3p4JIvJ3jriTaqkDqP1H+Luq5JMRY95Yo15q/42tKzsx4G1pJz93QzfNrbzPiKzsiNv6CaNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqitjgVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqitjgVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3771F000E9;
	Thu, 28 May 2026 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779992894;
	bh=f1YPxvHn9xap33HyNPmbN2SQj0/voH7aLNtsL/YowMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FqitjgVQ/F36HkN/OteE/TkcbhD1Cxa5mt8KvIzCbt9hXdyRTaMVVccRcagGlUQri
	 3PSJsrvwutCahgQ0+TCF/iNT1AxDCKW37o8nLDSYNo+66duUjtUN5OymIeyKfl3qS0
	 GIz/fjKfDF3lgW2kYKflp2pbPKy5ZeEFQk9WUCVvid4m6Yb1AeS0hzdGSp2itGGSFQ
	 YeRfKLLZdJKwW5JFqNOyWaP3mAunWBz/OpcO93rH8zyxsWdGzHitF/sqjMeVc0tXxc
	 PopOeEFsoRdhjZrGnvEJQvs9njiWse93APvqWqjtD7orx0qlZUKXg4m+DYPib2skXQ
	 DRoz58il1ieZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 04/11] bpf: Implement iteration ops for
 resizable hashtab
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528-rhash-v5-4-7205191b6c57@meta.com>
References: <20260528-rhash-v5-4-7205191b6c57@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 18:28:14 +0000
Message-Id: <20260528182814.AD3771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing error pointer check in `rhtab_map_get_next_key` leads =
to unhandled error pointer dereferences and kernel panics.
- [High] `bpf_each_rhash_elem` illegally calls `cond_resched()` and drops `=
rcu_read_lock()` from within a BPF map iterator callback, which will trigge=
r kernel panics in atomic contexts.
- [High] Batch lookup and `seq_file` iterators prematurely terminate when e=
ncountering concurrent deletions, breaking BPF map iteration guarantees and=
 causing silent data omission.
--

commit afc331365f30658242015d82e7bdd35a014f432d
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Implement iteration ops for resizable hashtab

Implement rhtab_map_get_next_key(), batch lookup/lookup-and-delete,
and the seq_file BPF iterator for BPF_MAP_TYPE_RHASH.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 8944c9f070ca8..a03fa5fa6545b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3021,10 +3021,363 @@ static void rhtab_map_free_internal_structs(stru=
ct bpf_map *map)
>  }
> =20
>  static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *=
next_key)
> +	__must_hold_shared(RCU)
>  {
> -	return -EOPNOTSUPP;
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	struct rhtab_elem *elem;
> +
> +	elem =3D rhashtable_next_key(&rhtab->ht, key, rhtab_params);
> +
> +	/* if not found, return the first key */
> +	if (PTR_ERR(elem) =3D=3D -ENOENT)
> +		elem =3D rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
> +
> +	if (!elem)
> +		return -ENOENT;
> +
> +	memcpy(next_key, elem->data, map->key_size);

[Severity: Critical]
Could this dereference an error pointer if rhashtable_next_key() returns
ERR_PTR(-EAGAIN)?=20

The first check only handles -ENOENT. If we get -EAGAIN (which can happen
during concurrent resizing), it bypasses the PTR_ERR check, passes the
!elem check since it isn't NULL, and then passes the error pointer directly
into memcpy().

> +	return 0;
> +}

[ ... ]

> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t call=
back_fn,
> +				void *callback_ctx, u64 flags)
> +{
> +	struct bpf_rhtab *rhtab =3D container_of(map, struct bpf_rhtab, map);
> +	void *prev_key =3D NULL;

[ ... ]

> +	rcu_read_lock();
> +	/*
> +	 * Best-effort iteration: if rhashtable is concurrently resized or
> +	 * elements are deleted/inserted, there may be missed or duplicate
> +	 * elements visited.
> +	 */
> +	while ((elem =3D rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params=
))) {
> +		if (IS_ERR(elem))
> +			break;
> +		num_elems++;
> +		ret =3D callback_fn((u64)(long)map,
> +				  (u64)(long)elem->data,
> +				  (u64)(long)rhtab_elem_value(elem, map->key_size),
> +				  (u64)(long)callback_ctx, 0);
> +		if (ret)
> +			break;
> +
> +		prev_key =3D elem->data;	/* valid while RCU held */
> +
> +		if (need_resched()) {
> +			memcpy(key_buf, elem->data, map->key_size);
> +			rcu_read_unlock();
> +			cond_resched();

[Severity: High]
Can this cond_resched() trigger "BUG: scheduling while atomic" panics?

BPF programs using the bpf_for_each_map_elem helper often run in
non-sleepable contexts (like XDP, TC, or tracing) under an outer RCU read
lock or with preemption disabled.=20

While this drops the inner RCU lock, it doesn't exit the outer atomic
context, so sleeping here might violate those constraints and cause system
instability.

> +			rcu_read_lock();
> +			prev_key =3D key_buf;
> +		}
> +	}
> +	rcu_read_unlock();

[ ... ]

> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
> +					       const union bpf_attr *attr,
> +					       union bpf_attr __user *uattr,
> +					       bool do_delete)
> +{

[ ... ]

> +	rcu_read_lock();
> +
> +	/*
> +	 * Cursor stores the key of the next-to-process element (stashed by
> +	 * the previous batch). Look it up directly so the element is included
> +	 * here rather than skipped by next_key(). If the cursor was deleted
> +	 * concurrently (or by the previous do_delete batch), lookup returns
> +	 * NULL and userspace must restart from a NULL cursor.
> +	 */
> +	if (ubatch)
> +		elem =3D rhtab_lookup_elem(map, cursor);
> +	else
> +		elem =3D rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
> +
> +	while (elem && !IS_ERR(elem) && total < max_count) {

[Severity: High]
Will this prematurely terminate the batch iteration if a concurrent deletion
occurs?=20

If the cursor element was concurrently deleted, rhashtable_next_key() retur=
ns
ERR_PTR(-ENOENT). This loop checks !IS_ERR(elem) and will break out early.

This results in the function returning -ENOENT to userspace. Under BPF UAPI
semantics, userspace interprets -ENOENT as the end of the map, which might
cause silent data omission instead of safely recovering or continuing.

> +		memcpy(dst_key, elem->data, key_size);
> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
> +		check_and_init_map_value(map, dst_val);

[ ... ]

> +static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_=
t *pos)
> +{
> +	struct bpf_iter_seq_rhash_map_info *info =3D seq->private;
> +	struct rhtab_elem *elem =3D v;
> +	void *next;
> +
> +	memcpy(info->last_key, elem->data, info->map->key_size);
> +	info->last_key_valid =3D true;
> +	++*pos;
> +
> +	next =3D rhashtable_next_key(&info->rhtab->ht, info->last_key,
> +				   rhtab_params);
> +	if (IS_ERR(next))
> +		return NULL;

[Severity: High]
Does this also prematurely terminate the seq_file iteration on concurrent
deletions?=20

Similar to the batch logic above, returning NULL when next is
ERR_PTR(-ENOENT) signals the end of the sequence to the iterator, which cou=
ld
silently truncate the iteration results.

> +	return next;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528-rhash-v5-0=
-7205191b6c57@meta.com?part=3D4
