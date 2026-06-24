Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4126A1AC
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329510; cv=none; b=b7ts+8MAf5RjjSs7CBbpooLVOvkEgk+DszhW3UpeolO+0TBIz78LnHEqoCdHdC5IqDYN6WBWAUMZ+EqBj077txPTPOjs2zuyaLg/uzXcZEIfWlm74Q9C5dXv90sQicyoRZyFRcD8bU3sOdvEUjUrQuKl5mvDqk4WMnoR56iaQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329510; c=relaxed/simple;
	bh=fpnpTIJup9O0O9xKYJyOVyq8RtO/KQUsnF7w9AGnuuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CHIjX+doof814TogAOd6pwd9L4LZW0qCBgSb+DezYG08gfrWqRfvnp9wrBzJ6eYrEyXnNvdqAoLKLL/IF9k52j8nZWhUzOMGW1Rtv5AEsD8z1KB44NRR/uAoe3vvsSLAjqMQ4JCsh8EbASTkcL9qTggL5sv+vU8rP+nrTbB4YgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbVrcJRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbVrcJRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE921F000E9;
	Wed, 24 Jun 2026 19:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782329509;
	bh=WRaDlzBfObKoLxQsvLNyLRJINZxYh9zS5VZpeJFoeRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WbVrcJRjTZaoyad/rhtV56wRElEzBW/PYGbo/eJdN2wShHewzfaiMbeHMhc3B9k1X
	 Pyjgyk1TIYFoB0ah/spPovTjRuhil17WdcNzrIvtDq8D3L4vpiKDOhvigx8CRGaCHf
	 u9RIkDzcNrZzZkOnWdd+7UY6NLIy6padV0GFZt5oNJkF29K3Wccrh5spQ54pFY9GEX
	 gyg+TTRmpWgEL15AxBCEs/od8I3vCNx+8vNA3tcK7hkEvkGJt2ogKUHZw62VgzfO7n
	 9VIrKE+CCnpIDdcqTBfjTkrbhoxE9mJ/nQLv6b5Qr0AdK0FkKF62cAuUGOF6IeZth2
	 Jyqs3wgYqnuDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: Fix use-after-free in htab elem with bpf_task_work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shengzhuo Wei" <me@cherr.cc>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260625-bpf-htab-task-work-uaf-v1-1-31e711ccb159@cherr.cc>
References: <20260625-bpf-htab-task-work-uaf-v1-1-31e711ccb159@cherr.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:31:48 +0000
Message-Id: <20260624193149.3EE921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Unconditional call to `check_and_init_map_value` on inline ele=
ment memory causes out-of-bounds writes for per-CPU maps.
- [High] Dynamic memory allocation (`kmalloc(GFP_ATOMIC)`) in the element f=
ree path breaks NMI safety and causes memory exhaustion.
- [High] Permanent bricking of `BPF_TASK_WORK` fields during in-place map u=
pdates.

Pre-existing issues:
- [Critical] LRU map eviction synchronously reuses elements containing `BPF=
_TASK_WORK`, causing UAF and data corruption.
- [High] Incomplete fix for UAF in preallocated HASH maps due to `extra_ele=
ms` cache bypass.
--

commit 3d208f380a67702d8970ff27139db174f1482e4a
Author: Shengzhuo Wei <me@cherr.cc>

bpf: Fix use-after-free in htab elem with bpf_task_work

This commit attempts to fix a use-after-free vulnerability when deleting
hash map elements that embed a bpf_task_work. It defers recycling through
call_rcu_tasks_trace() to wait for rcu_read_lock_trace() readers. It also
changes the sentinel value in cancel_and_free() to ERR_PTR(-EBUSY).

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Shengzhuo Wei <me@cherr.cc>

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e85..19fa61909e4fe 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -310,6 +310,7 @@ static struct htab_elem *prealloc_lru_pop(struct bpf_=
htab *htab, void *key,
>  		bpf_map_inc_elem_count(&htab->map);
>  		l =3D container_of(node, struct htab_elem, lru_node);
>  		memcpy(l->key, key, htab->map.key_size);

[Severity: Critical]
This is a pre-existing issue, but does this synchronous eviction path in
kernel/bpf/hashtab.c:prealloc_lru_pop() leave LRU maps vulnerable to a
use-after-free?

When an LRU map is full, it triggers synchronous eviction. The victim node =
is
removed and immediately returned for reuse.

Since there is no RCU tasks trace grace period between eviction and reuse,
could a concurrent BPF program holding rcu_read_lock_trace() have its memory
overwritten while still in use?

> +		check_and_init_map_value(&htab->map, htab_elem_value(l, htab->map.key_=
size));

[Severity: Critical]
Can this unconditional initialization cause out-of-bounds memory corruption
for per-CPU maps?

For per-CPU maps, the actual map values are allocated separately per CPU, a=
nd
the inline memory returned by htab_elem_value() is only large enough to hold
the 8-byte pointer to the per-CPU allocation.

If a per-CPU map contains a special field at an offset greater than 8, does
check_and_init_map_value() write zeroes out of bounds of the htab_elem
inline storage, corrupting adjacent slab memory?

>  		return l;
>  	}
> =20

[ ... ]

> @@ -950,12 +951,69 @@ static int htab_map_get_next_key(struct bpf_map *ma=
p, void *key, void *next_key)
>  	return -ENOENT;
>  }
> =20
> +/* Deferred htab_elem free for bpf_task_work maps.  cancel_and_free()
> + * returns while the task_work callback may still be accessing map_val;
> + * the callback holds guard(rcu_tasks_trace), so deferring the recycle

[ ... ]

> +static void htab_elem_defer_free(struct bpf_htab *htab, struct htab_elem=
 *l)
> +{
> +	struct htab_elem_free_rcu *fr;
> +
> +	fr =3D kmalloc_obj(*fr, GFP_ATOMIC);

[Severity: High]
Does this dynamic memory allocation break the strict NMI safety guarantees =
of
preallocated BPF maps?

Preallocated maps are designed to avoid runtime dynamic allocations, ensuri=
ng
they are safe for NMI contexts like perf events. By unconditionally calling
htab_elem_defer_free() (which calls kmalloc) for elements with a task work
field, does this introduce a risk of deadlocks in SLUB?

Additionally, during map destruction of non-preallocated maps,
delete_all_elements() loops over all elements and frees them:

kernel/bpf/hashtab.c:delete_all_elements() {
    for (i =3D 0; i < htab->n_buckets; i++) {
        ...
        hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
            htab_elem_free(htab, l);
        }
    }
}

For a map with millions of elements, could this tight loop exhaust atomic
memory reserves and risk an OOM panic?

> +	if (WARN_ON_ONCE(!fr)) {
> +		/* Fallback: immediate recycle, small UAF risk */
> +		htab_elem_recycle(htab, l);
> +		return;
> +	}
> +	fr->htab =3D htab;
> +	fr->elem =3D l;
> +	call_rcu_tasks_trace(&fr->rcu, htab_elem_free_rcu_cb);
> +}

[ ... ]

> @@ -1118,6 +1180,11 @@ static struct htab_elem *alloc_htab_elem(struct bp=
f_htab *htab, void *key,
>  	}
> =20
>  	memcpy(l_new->key, key, key_size);
> +	/* Re-initialize special fields for recycled elements.  copy_map_value()
> +	 * skips btf_record fields, so a stale ERR_PTR(-EBUSY) left by
> +	 * bpf_task_work_cancel_and_free would persist and block new scheduling.
> +	 */
> +	check_and_init_map_value(&htab->map, htab_elem_value(l_new, key_size));

[Severity: Critical]
Are we at risk of out-of-bounds writes here as well for per-CPU maps?

As with the call in prealloc_lru_pop() above, if the map is a per-CPU
hash map, htab_elem_value() points to an 8-byte space.

If the map has special fields at a larger offset, check_and_init_map_value()
might corrupt slab memory. If the offset is zero, could it overwrite the
per-CPU pointer itself and cause a NULL pointer dereference in
pcpu_init_value()?

[Severity: High]
This is a pre-existing issue, but does this allocation path bypass the new
RCU tasks trace deferral for preallocated hash maps during element updates?

When updating an existing element in a preallocated map, alloc_htab_elem()
stashes the old element synchronously into the CPU local cache:

kernel/bpf/hashtab.c:alloc_htab_elem() {
    if (prealloc) {
        if (old_elem) {
            pl_new =3D this_cpu_ptr(htab->extra_elems);
            l_new =3D *pl_new;
            *pl_new =3D old_elem;
        }
    ...
}

Then, htab_map_update_elem() intentionally skips calling free_htab_elem()
for preallocated maps.

A subsequent update on the same CPU can immediately pop the old element from
extra_elems and overwrite it. Does this entirely bypass the RCU grace period
provided by htab_elem_defer_free(), leaving the original race condition
intact if a concurrent callback is executing?

>  	if (percpu) {
>  		if (prealloc) {
>  			pptr =3D htab_elem_get_ptr(l_new, key_size);

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee4..07088ac1f0b2d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -4784,8 +4787,8 @@ void bpf_task_work_cancel_and_free(void *val)
>  	struct bpf_task_work_ctx *ctx;
>  	enum bpf_task_work_state state;
> =20
> -	ctx =3D xchg(&twk->ctx, NULL);
> -	if (!ctx)
> +	ctx =3D xchg(&twk->ctx, ERR_PTR(-EBUSY));

[Severity: High]
Could this change permanently brick task work fields for map types that
update elements in place?

The patch relies on the newly added check_and_init_map_value() calls in hash
map element allocators to clear this ERR_PTR(-EBUSY) sentinel when an eleme=
nt
is reused.

However, map types that update elements in place, such as array maps, never
allocate a new element. They use copy_map_value() followed by
bpf_obj_cancel_fields():

kernel/bpf/arraymap.c:array_map_update_elem() {
    ...
    copy_map_value(map, val, value);
    bpf_obj_cancel_fields(map, val);
    ...
}

Since check_and_init_map_value() is never called for these in-place updates,
twk->ctx appears permanently left in the ERR_PTR(-EBUSY) state. Would any
future bpf_task_work_schedule() calls on that element permanently fail?

> +	if (IS_ERR_OR_NULL(ctx))
>  		return;
> =20
>  	state =3D xchg(&ctx->state, BPF_TW_FREED);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-bpf-htab-t=
ask-work-uaf-v1-1-31e711ccb159@cherr.cc?part=3D1
