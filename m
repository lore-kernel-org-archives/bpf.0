Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDA3D6CA3
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334503; cv=none; b=lxqdEP8vAzGsiqZdjKUinjXfYVY14QCJjQcGydd6aRS86kBXO2MAGyCb21pxONWSgs+c7fuYSrUIvp5U1haL8tCqTC5025WJwn/Ye1iw/ThUuX3xnSY9UnhdWeb1gwBJWvOO+sF8lmc8UOAQWVTh1aBaInuPZa7Znd2CMikkOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334503; c=relaxed/simple;
	bh=+VztGOMbmVz+cbvQwKADZGsXIi9erdoPoYsZScBSziI=;
	h=Subject:Mime-Version:Cc:In-Reply-To:To:From:Message-Id:References:
	 Date:Content-Type:Content-Disposition; b=SjmD2oyMc3MtyDnaLse4YzRss7RT9ANtqT3cmLW0y2Qi8RKNGdHAm5d70NyAgHa9q2H2iz+DuYcGHsufAQQNC5tixhZ1AFEYOvLrKTfQqlJzC1lNGhOTdNbBEQ7nxx4UOyHcdLSrzlk0EinlB6KrEXU9jMKVImamnD/ovV1VdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=HupT1iVU; arc=none smtp.client-ip=209.127.231.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="HupT1iVU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1782334488; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+/gRR53Ag3PkcCwT4+m/ygvw6HUlnbklOOo9dl+Moag=;
 b=HupT1iVU4O3Pegg+FWHwqMFAiFlSqGG2zjeBRYjvoqVWP9ekOqv4hhMCflwKigvyZil49L
 IluWlgVV02Fi3vZVWsksx37IIOgdAP+OxA1C+sc7ixo6bRvhTSuRchO6JRdLS3sYLxe0gF
 Jfm5p5hiRAu2DbuuL+CGQv+/u4g/maa2dB5CNh1RlXAM+S0vBdAXaNEcYmEUpVLrwTbgbi
 59FsoiIi/iBct+PbtY4RkFStqrU4vGmaQpxxx40fFDw/kH+ohHHlZifG8mvXpGGmjqKEfe
 MUJEu24SbQbAiy0lU1FnMshr2Lu5GdwdxuooMV/faEHMGUUVB4wVW0G6YsSZpA==
Subject: Re: [PATCH] bpf: Fix use-after-free in htab elem with bpf_task_work
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a3c4416+aefd75+vger.kernel.org+me@cherr.cc>
Cc: <bpf@vger.kernel.org>
Received: from pve.cherr ([111.42.148.29]) by smtp.feishu.cn with ESMTPS; Thu, 25 Jun 2026 04:54:45 +0800
X-Original-From: Shengzhuo Wei <me@cherr.cc>
In-Reply-To: <20260624193149.3EE921F000E9@smtp.kernel.org>
To: <sashiko-reviews@lists.linux.dev>, "Shengzhuo Wei" <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Message-Id: <ajxEE59cuz9XUWMV@pve.cherr>
References: <20260625-bpf-htab-task-work-uaf-v1-1-31e711ccb159@cherr.cc> <20260624193149.3EE921F000E9@smtp.kernel.org>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 04:54:43 +0800
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On 2026-06-24 19:31, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
>=20
> New issues:
> - [Critical] Unconditional call to `check_and_init_map_value` on inline e=
lement memory causes out-of-bounds writes for per-CPU maps.
> - [High] Dynamic memory allocation (`kmalloc(GFP_ATOMIC)`) in the element=
 free path breaks NMI safety and causes memory exhaustion.
> - [High] Permanent bricking of `BPF_TASK_WORK` fields during in-place map=
 updates.
>=20
Will try to fix in v2

To be honest, I'm not entirely sure how to handle this UAF issue either,=20
and my understanding of BPF isn't particularly deep. It might be necessary=
=20
for the maintainer to propose a more comprehensive solution.

> Pre-existing issues:
> - [Critical] LRU map eviction synchronously reuses elements containing `B=
PF_TASK_WORK`, causing UAF and data corruption.
> - [High] Incomplete fix for UAF in preallocated HASH maps due to `extra_e=
lems` cache bypass.
> --
>=20
> commit 3d208f380a67702d8970ff27139db174f1482e4a
> Author: Shengzhuo Wei <me@cherr.cc>
>=20
> bpf: Fix use-after-free in htab elem with bpf_task_work
>=20
> This commit attempts to fix a use-after-free vulnerability when deleting
> hash map elements that embed a bpf_task_work. It defers recycling through
> call_rcu_tasks_trace() to wait for rcu_read_lock_trace() readers. It also
> changes the sentinel value in cancel_and_free() to ERR_PTR(-EBUSY).
>=20
> Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
>=20
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 9f394e1aa2e85..19fa61909e4fe 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -310,6 +310,7 @@ static struct htab_elem *prealloc_lru_pop(struct bp=
f_htab *htab, void *key,
> >  		bpf_map_inc_elem_count(&htab->map);
> >  		l =3D container_of(node, struct htab_elem, lru_node);
> >  		memcpy(l->key, key, htab->map.key_size);
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does this synchronous eviction path in
> kernel/bpf/hashtab.c:prealloc_lru_pop() leave LRU maps vulnerable to a
> use-after-free?
>=20
> When an LRU map is full, it triggers synchronous eviction. The victim nod=
e is
> removed and immediately returned for reuse.
>=20
> Since there is no RCU tasks trace grace period between eviction and reuse=
,
> could a concurrent BPF program holding rcu_read_lock_trace() have its mem=
ory
> overwritten while still in use?
>=20
> > +		check_and_init_map_value(&htab->map, htab_elem_value(l, htab->map.ke=
y_size));
>=20
> [Severity: Critical]
> Can this unconditional initialization cause out-of-bounds memory corrupti=
on
> for per-CPU maps?
>=20
> For per-CPU maps, the actual map values are allocated separately per CPU,=
 and
> the inline memory returned by htab_elem_value() is only large enough to h=
old
> the 8-byte pointer to the per-CPU allocation.
>=20
> If a per-CPU map contains a special field at an offset greater than 8, do=
es
> check_and_init_map_value() write zeroes out of bounds of the htab_elem
> inline storage, corrupting adjacent slab memory?
>=20
> >  		return l;
> >  	}
> > =20
>=20
> [ ... ]
>=20
> > @@ -950,12 +951,69 @@ static int htab_map_get_next_key(struct bpf_map *=
map, void *key, void *next_key)
> >  	return -ENOENT;
> >  }
> > =20
> > +/* Deferred htab_elem free for bpf_task_work maps.  cancel_and_free()
> > + * returns while the task_work callback may still be accessing map_val=
;
> > + * the callback holds guard(rcu_tasks_trace), so deferring the recycle
>=20
> [ ... ]
>=20
> > +static void htab_elem_defer_free(struct bpf_htab *htab, struct htab_el=
em *l)
> > +{
> > +	struct htab_elem_free_rcu *fr;
> > +
> > +	fr =3D kmalloc_obj(*fr, GFP_ATOMIC);
>=20
> [Severity: High]
> Does this dynamic memory allocation break the strict NMI safety guarantee=
s of
> preallocated BPF maps?
>=20
> Preallocated maps are designed to avoid runtime dynamic allocations, ensu=
ring
> they are safe for NMI contexts like perf events. By unconditionally calli=
ng
> htab_elem_defer_free() (which calls kmalloc) for elements with a task wor=
k
> field, does this introduce a risk of deadlocks in SLUB?
>=20
> Additionally, during map destruction of non-preallocated maps,
> delete_all_elements() loops over all elements and frees them:
>=20
> kernel/bpf/hashtab.c:delete_all_elements() {
>     for (i =3D 0; i < htab->n_buckets; i++) {
>         ...
>         hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
>             htab_elem_free(htab, l);
>         }
>     }
> }
>=20
> For a map with millions of elements, could this tight loop exhaust atomic
> memory reserves and risk an OOM panic?
>=20
> > +	if (WARN_ON_ONCE(!fr)) {
> > +		/* Fallback: immediate recycle, small UAF risk */
> > +		htab_elem_recycle(htab, l);
> > +		return;
> > +	}
> > +	fr->htab =3D htab;
> > +	fr->elem =3D l;
> > +	call_rcu_tasks_trace(&fr->rcu, htab_elem_free_rcu_cb);
> > +}
>=20
> [ ... ]
>=20
> > @@ -1118,6 +1180,11 @@ static struct htab_elem *alloc_htab_elem(struct =
bpf_htab *htab, void *key,
> >  	}
> > =20
> >  	memcpy(l_new->key, key, key_size);
> > +	/* Re-initialize special fields for recycled elements.  copy_map_valu=
e()
> > +	 * skips btf_record fields, so a stale ERR_PTR(-EBUSY) left by
> > +	 * bpf_task_work_cancel_and_free would persist and block new scheduli=
ng.
> > +	 */
> > +	check_and_init_map_value(&htab->map, htab_elem_value(l_new, key_size)=
);
>=20
> [Severity: Critical]
> Are we at risk of out-of-bounds writes here as well for per-CPU maps?
>=20
> As with the call in prealloc_lru_pop() above, if the map is a per-CPU
> hash map, htab_elem_value() points to an 8-byte space.
>=20
> If the map has special fields at a larger offset, check_and_init_map_valu=
e()
> might corrupt slab memory. If the offset is zero, could it overwrite the
> per-CPU pointer itself and cause a NULL pointer dereference in
> pcpu_init_value()?
>=20
> [Severity: High]
> This is a pre-existing issue, but does this allocation path bypass the ne=
w
> RCU tasks trace deferral for preallocated hash maps during element update=
s?
>=20
> When updating an existing element in a preallocated map, alloc_htab_elem(=
)
> stashes the old element synchronously into the CPU local cache:
>=20
> kernel/bpf/hashtab.c:alloc_htab_elem() {
>     if (prealloc) {
>         if (old_elem) {
>             pl_new =3D this_cpu_ptr(htab->extra_elems);
>             l_new =3D *pl_new;
>             *pl_new =3D old_elem;
>         }
>     ...
> }
>=20
> Then, htab_map_update_elem() intentionally skips calling free_htab_elem()
> for preallocated maps.
>=20
> A subsequent update on the same CPU can immediately pop the old element f=
rom
> extra_elems and overwrite it. Does this entirely bypass the RCU grace per=
iod
> provided by htab_elem_defer_free(), leaving the original race condition
> intact if a concurrent callback is executing?
>=20
> >  	if (percpu) {
> >  		if (prealloc) {
> >  			pptr =3D htab_elem_get_ptr(l_new, key_size);
>=20
> [ ... ]
>=20
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index c18f1e16edee4..07088ac1f0b2d 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
>=20
> [ ... ]
>=20
> > @@ -4784,8 +4787,8 @@ void bpf_task_work_cancel_and_free(void *val)
> >  	struct bpf_task_work_ctx *ctx;
> >  	enum bpf_task_work_state state;
> > =20
> > -	ctx =3D xchg(&twk->ctx, NULL);
> > -	if (!ctx)
> > +	ctx =3D xchg(&twk->ctx, ERR_PTR(-EBUSY));
>=20
> [Severity: High]
> Could this change permanently brick task work fields for map types that
> update elements in place?
>=20
> The patch relies on the newly added check_and_init_map_value() calls in h=
ash
> map element allocators to clear this ERR_PTR(-EBUSY) sentinel when an ele=
ment
> is reused.
>=20
> However, map types that update elements in place, such as array maps, nev=
er
> allocate a new element. They use copy_map_value() followed by
> bpf_obj_cancel_fields():
>=20
> kernel/bpf/arraymap.c:array_map_update_elem() {
>     ...
>     copy_map_value(map, val, value);
>     bpf_obj_cancel_fields(map, val);
>     ...
> }
>=20
> Since check_and_init_map_value() is never called for these in-place updat=
es,
> twk->ctx appears permanently left in the ERR_PTR(-EBUSY) state. Would any
> future bpf_task_work_schedule() calls on that element permanently fail?
>=20
> > +	if (IS_ERR_OR_NULL(ctx))
> >  		return;
> > =20
> >  	state =3D xchg(&ctx->state, BPF_TW_FREED);
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-bpf-htab=
-task-work-uaf-v1-1-31e711ccb159@cherr.cc?part=3D1
