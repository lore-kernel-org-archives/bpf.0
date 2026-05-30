Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F653375CB
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 03:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110873; cv=none; b=mwiGQ/yUolDTgIV2AJjmuau+xpfuenbg6oAVBF/fou1noPzusqroMTVMYkLzXkk9QBWbd9xbNPFGFH3kiPR5b9gnp/Qm2NMOudTwoaA76r2mWteVEcsnIDL7w0dC7jyAQk03QVhPC1pU5tohZ+sJC6TBAmbOSt1OsaJjLsv2u+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110873; c=relaxed/simple;
	bh=+UdrprPI0+zG4Hue5gWUco/PfSPSGEliE5wW7sbJxOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=STaHCf7wZcCGAtPqMbIhqSqtrnN8zC2xT2YGgNbiamPL5H4DTeUQVacQuJaP/A4fbElJNLHeCklWltiOwGQ0ZA0EFcaNaNz/P1lcQAFuKGmWqoSTMSXAIIrNTxpUFuQGiY2na4KEo1f3HOfCnYpI46vD7BY4yrr87xBhba6X05Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGZ5jXMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGZ5jXMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EAC1F00893;
	Sat, 30 May 2026 03:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780110872;
	bh=KJNSoe4y985xsk1U6LWXVQPh7q3HE9mAK7EEqWoYCf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nGZ5jXMeouo5hk2X5ryCmD27dfOVu3Vk3gZUp2JnYEd0RCbLYpuZujAiMuVZovlcq
	 s64mT6BpoHdmggCcyg8wH0qvPG/mW0X1g4WVB979Go/VvnuENvZuYxlV2KFfNEJ52H
	 00qnJ6lGQDGrb1cgpWGn0dyI3Qan+yjdSOgY58OCxv5C16pe8KlZZhxh3a2of/tdXC
	 jS80zgLwyO01M5lBOHVbyvQaT7Ro42hbVpJ6v6xfuAw1DKv7Ww/Yfv3QmMv/80a0gS
	 9RCEVqCZYsCiucsMXKuY6501UjypT4cX2/GJs5CThAII/LjYUn4sNXjQslf6ukjXbz
	 SVRQsepnIZmWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 3/4] bpf,slab: Add slub-backed allocator for
 bpf_arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260530011345.99342-4-alexei.starovoitov@gmail.com>
References: <20260530011345.99342-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 03:14:31 +0000
Message-Id: <20260530031432.23EAC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Critical] BPF double-free allows arbitrary `inuse` underflow, leading to=
 deterministically reproducible Use-After-Free.
- [Critical] SLUB freepointers leak kernel direct-map addresses into the us=
er-accessible BPF arena, bypassing KASLR.
- [High] Call to undefined function `kfree_arena_nolock()` breaks compilati=
on.
- [High] `bpf_arena_free_pages()` on a slab-backed page poisons the arena's=
 range tree, causing permanent denial of service for future allocations.
- [High] Slab pages are permanently leaked if `spin_trylock_irqsave()` fail=
s in `__slab_free()`.
- [High] Leaked multi-page arena allocations trigger a "BUG: Bad page state=
" kernel panic during map teardown due to uncleared `page->private`.

Pre-existing issues:
- [High] Execution of `kmem_cache_alloc_arena_nolock()` in NMI context on S=
MP systems leads to unconditional deadlocks on `n->list_lock`.
- [High] Calling sleeping functions while holding a raw spinlock in `arena_=
alloc_pages()` violates wait-type rules and causes RT panics.
--

commit 53717ad0236c080a0c28abbad1ef1edb1e2030c3
Author: Alexei Starovoitov <ast@kernel.org>
Subject: bpf,slab: Add slub-backed allocator for bpf_arena

This patch adds a SLUB-backed allocator for the bpf_arena, letting BPF=20
programs allocate typed objects via a kvmalloc-style API. It routes=20
requests up to PAGE_SIZE through per-arena slab buckets and falls back=20
to arena_alloc_pages() for larger sizes.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
[ ... ]
> @@ -689,6 +689,10 @@ static long arena_alloc_pages(struct bpf_arena *aren=
a, long uaddr, long page_cnt
>  	data.pages =3D pages;
>  	data.set_page_slab =3D set_page_slab;
> =20
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
>  		goto out_free_pages;
> =20
>  	if (uaddr) {
[ ... ]
>  		/*
>  		 * Earlier checks made sure that uaddr32 + page_cnt * PAGE_SIZE - 1
>  		 * will not overflow 32-bit. Lower 32-bit need to represent
>  		 * contiguous user address range.
>  		 * Map these pages at kern_vm_start base.
>  		 * kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE - 1 can overflow
>  		 * lower 32-bit and it's ok.
>  		 */
>  		data.i =3D 0;
>  		ret =3D apply_to_page_range(&init_mm,
>  					  kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT),
>  					  this_batch << PAGE_SHIFT, apply_range_set_cb, &data);

[Severity: High]
This is a pre-existing issue, but does this violate wait-type rules on=20
PREEMPT_RT systems? The code acquires a raw spinlock and then calls=20
apply_to_page_range(). The page table walker acquires page table locks,=20
which are sleeping locks on RT systems. Acquiring a sleeping lock while=20
holding a raw spinlock can cause an invalid wait context BUG and panic.

[ ... ]
> @@ -871,6 +871,11 @@ static void arena_free_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt,
> =20
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> =20
>  	if (!sleepable)
>  		goto defer;
> =20
>  	ret =3D raw_res_spin_lock_irqsave(&arena->spinlock, flags);
> =20
>  	/* Can't proceed without holding the spinlock so defer the free */
>  	if (ret)
>  		goto defer;
> =20
>  	range_tree_set(&arena->rt, pgoff, page_cnt);

[Severity: High]
If a BPF program calls bpf_arena_free_pages() on an offset backed by=20
SLUB, the code unconditionally marks the slot as free in the range tree.=20
However, apply_range_clear_cb() intentionally skips PageSlab pages,=20
leaving the PTE populated. Could this cause a permanent -EBUSY failure=20
during subsequent allocations when apply_range_set_cb() observes a=20
populated PTE?

[ ... ]
> @@ -1176,6 +1176,12 @@ static void arena_destroy_slab_caches(struct bpf_a=
rena *arena)
>  	for (pgoff =3D 0; pgoff < max; pgoff++) {
>  		struct page *page =3D arena->slab_pages[pgoff];
>  		struct slab *slab;
> =20
>  		if (!page)
>  			continue;
>  		if (!PageSlab(page))
>  			/*
>  			 * Leftover bpf_arena_alloc() fallback page; freed by
>  			 * existing_page_cb() in arena_map_free().
>  			 */
>  			continue;

[Severity: High]
Could this leak the page private data for fallback pages? For large=20
allocations, bpf_arena_alloc() falls back to arena_alloc_pages() and=20
stashes the allocation size via set_page_private(). Because this teardown=20
loop skips non-PageSlab pages, they are routed to existing_page_cb()=20
which calls __free_page() without clearing page->private. Can this=20
trigger a BUG: Bad page state kernel panic during map teardown?

[ ... ]
> @@ -1352,6 +1352,10 @@ __bpf_kfunc void bpf_arena_free(void *p__map, void=
 *ptr__ign)
>  	/*
>  	 * Arena variant of the nolock free: safe from any context AND
>  	 * keeps KASAN out of the loop so BPF-program double-frees show
>  	 * up as arena violations, not kernel KASAN splats.
>  	 */
>  	kfree_arena_nolock(kva);
>  	return;

[Severity: High]
Is kfree_arena_nolock() missing from this patch? The code calls this=20
function, but it does not appear to be defined here or elsewhere in the=20
kernel, which will break the build. Was kfree_nolock() intended instead?

> diff --git a/mm/slub.c b/mm/slub.c
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> @@ -563,6 +563,12 @@ static inline void set_freepointer(struct kmem_cache=
 *s, void *object, void *fp)
>  	unsigned long freeptr_addr =3D (unsigned long)object + s->offset;
> =20
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>  	if (unlikely(object =3D=3D fp)) {
>  		/* BPF double-free of arena objects must not panic the kernel. */
>  		if (s->bpf_arena)
>  			return;
>  		BUG_ON(object =3D=3D fp); /* naive detection of double free or corrupt=
ion */
>  	}
>  #endif

[Severity: Critical]
Can this early return lead to a deterministically reproducible=20
use-after-free? When a BPF program double-frees an object, returning=20
early skips the freepointer update, but the caller __slab_free()=20
continues execution and decrements slab->inuse. If double-freed enough=20
times, inuse reaches 0, which frees the entire slab page back to the=20
arena while other active objects still reside on it.

> =20
>  	freeptr_addr =3D (unsigned long)kasan_reset_tag((void *)freeptr_addr);
>  	*(freeptr_t *)freeptr_addr =3D freelist_ptr_encode(s, fp, freeptr_addr);
>  }

[Severity: Critical]
Does storing freepointers directly inside the memory of freed objects=20
leak kernel direct-map addresses into the user-accessible BPF arena?=20
Since arena memory is mapped to userspace, a user can read the freed=20
objects to extract internal kernel pointers, effectively bypassing KASLR.

[ ... ]
> @@ -5468,6 +5468,10 @@ void *kmem_cache_alloc_arena_nolock(struct kmem_ca=
che *s, int node)
>  {
>  	gfp_t alloc_gfp =3D __GFP_NOWARN | __GFP_NOMEMALLOC;
>  	void *ret;
> =20
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
>  		return NULL;
>  	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
>  		return NULL;
> =20
>  	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>  		return NULL;
> =20
>  	ret =3D alloc_from_pcs(s, alloc_gfp, node);
>  	if (!ret)
>  		ret =3D __slab_alloc_node(s, alloc_gfp, node, _RET_IP_,
>  					s->object_size);

[Severity: High]
This is a pre-existing issue, but does permitting execution in NMI=20
context on SMP systems lead to deadlocks? If the fastpath fails and=20
falls back to __slab_alloc_node(), it will attempt to unconditionally=20
acquire n->list_lock. If the NMI interrupted a context on the same CPU=20
that already holds this lock, the CPU will deadlock.

[ ... ]
> @@ -5647,6 +5647,15 @@ static void __slab_free(struct kmem_cache *s, stru=
ct slab *slab,
>  			/*
>  			 * Speculatively acquire the list_lock. If the cmpxchg
>  			 * does not succeed we drop the lock without processing.
>  			 *
>  			 * Arena caches may reach here from kfree_nolock() in
>  			 * NMI/irq-off context; trylock and orphan the slab on
>  			 * failure. A later allow_spin caller adopts it.
>  			 */
>  			if (unlikely(s->bpf_arena)) {
>  				if (!spin_trylock_irqsave(&n->list_lock, flags))
>  					n =3D NULL;
>  			} else {
>  				spin_lock_irqsave(&n->list_lock, flags);
>  			}
[ ... ]
>  	if (likely(!n)) {
>  		/*
>  		 * We didn't take the list_lock because the slab was already on
>  		 * the partial list and will remain there.
>  		 */
>  		return;
>  	}

[Severity: High]
Are slab pages permanently leaked if spin_trylock_irqsave() fails here?=20
If n is set to NULL on failure, the function returns early. The object=20
is marked free locklessly, but the slab is never added to the partial=20
list or freed, making these orphaned slabs inaccessible to the allocator=20
until the entire map is destroyed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530011345.9934=
2-1-alexei.starovoitov@gmail.com?part=3D3
