Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD078344DAC
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780092252; cv=none; b=J4xesjOx4IO7b520OlrmttZsukQ+aHo9t53Xr7gohr4kHmK98ThoKPoIVCyv1eiOjDujZb8dPLlS6CSv+hpnDT+M2blkZleArzr8KjhRBHPlk3xzQNIQmWs9h+oLMpNpvTBfI1aJADv9dyzgptx3O0sSk3/OSQwg9Cp43PkO+Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780092252; c=relaxed/simple;
	bh=QyZKHxo5teqkvj23kNF783NoxT/UICR6uhJJMID0if0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iyt1PHv451x8F8izuW6RKKTS7cIEjdA/K/4AOQmtfNkgL9wzayrZa4JNllu0sRbEeSVzcFcGEHTuIUXYPieA3rrRyiUcsE27cVsISyT1ixw4/TLgwPTSUo99VS9WpNEfRjSsZM3jSygyyMWk/1vEJb1AvNKE7PHXqJocQ6ImZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwsuCaF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwsuCaF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1251F1F00893;
	Fri, 29 May 2026 22:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780092250;
	bh=3flGS6rT6KDhNKJWFAzL6aEruX93LfV8II7bsPqp0vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwsuCaF6rAXOZ6yFbOyIB23SlCOEw5O2IqvTtx6iVg9j+baGGMGchER6aVWOfN0bX
	 1qR2ZgYcfQqr77PgEAghsnACfvQilu+sTC3RIcJylpG6sdqavoH+qXWO43KrZQcsld
	 7+3pENGRy09vtRc7eqtMi0GaneoePLcRGYosxfJ6YpCzZ/ViEBJB2cHjjBUGbm4kev
	 T6KXKTz1jj3cLQ8iJvhLTw4/eLNqN5A4wIpCfjRaUqP4Cw60BnhHtrA5UqkvDz/mb8
	 X5McivhsQeBYmB7zNXY4b861NFRV0zi5uXWbyUIZAWMt0FyGgAPNUOZN8rUTRJjO/G
	 RysEY34MJQosA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] bpf,slab: Add slub-backed allocator for
 bpf_arena
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529202438.16408-4-alexei.starovoitov@gmail.com>
References: <20260529202438.16408-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 22:04:09 +0000
Message-Id: <20260529220410.1251F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] BPF-induced freelist double-frees artificially drive SLUB's in=
use counter to zero, prematurely freeing active slabs and causing Use-After=
-Free.
- [Critical] Skipping alloc_slab_obj_exts_early() for arena caches leaves s=
lab->obj_exts uninitialized, causing a kernel panic when SLUB attempts to k=
free() the leftover mem_cgroup pointer.
- [Critical] An out-of-bounds array access in arena_free_pages allows a mal=
icious BPF program to read and overwrite arbitrary kernel memory by bypassi=
ng the bounds check.
- [Critical] A TOCTOU race condition in bpf_arena_free for multi-page fallb=
ack allocations allows concurrent frees to corrupt kernel page allocator me=
tadata.
- [High] BPF program can permanently brick the arena allocator by calling b=
pf_arena_free_pages() on an active slab page.
- [High] Invalid wait context: calling apply_to_page_range() under a raw sp=
inlock causes scheduling while atomic on PREEMPT_RT.
- [Medium] Trylock failures in __slab_free permanently leak orphaned empty =
slabs.
--

commit 0bd3f7f14bd0e0d83546ab9ece9d884e9f9bd2e5
Author: Alexei Starovoitov <ast@kernel.org>

bpf,slab: Add slub-backed allocator for bpf_arena

Let BPF programs allocate typed objects in a bpf_arena via a
kvmalloc-style API: bpf_arena_alloc() routes requests up to
PAGE_SIZE through per-arena slab buckets, and falls back to
arena_alloc_pages() for larger sizes.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -179,9 +207,22 @@ static void flush_vmap_cache(unsigned long start, un=
signed long size)
>  static int apply_range_clear_cb(pte_t *pte, unsigned long addr, void *da=
ta)
>  {
>  	struct clear_range_data *d =3D data;
> -	pte_t old_pte;
> +	pte_t old_pte, cur;
>  	struct page *page;
> =20
> +	/*
> +	 * Skip slub-owned pages: BPF must use bpf_arena_free() for per-object
> +	 * slab frees. The PTE stays; slub releases it via arena_free_slab_page=
()
> +	 * after __ClearPageSlab(). Non-atomic ptep_get() is safe -- ptep_try_s=
et()
> +	 * only fires on pte_none, and arena_free_slab_page() can't race on this
> +	 * offset (range stays allocated in range_tree for our walk).
> +	 */
> +	cur =3D ptep_get(pte);
> +	if (pte_none(cur) || !pte_present(cur))
> +		return 0;
> +	if (PageSlab(pte_page(cur)))
> +		return 0;

[Severity: High]
If this skips clearing the kernel PTEs for PageSlab pages, could it permane=
ntly
brick the arena allocator?

If a BPF program calls bpf_arena_free_pages() on an active slab page,
arena_free_pages() adds the page offset back to the arena's free range tree
unconditionally.=20

Since the physical page remains mapped, won't subsequent allocations via
arena_alloc_pages() repeatedly pick this slot from the interval tree, hit
-EBUSY in apply_to_page_range() because the PTE is not empty, and abort?

[ ... ]

> @@ -625,7 +686,8 @@ static u64 clear_lo32(u64 val)
>   * Later the pages will be mmaped into user space vma.
>   */
>  static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long =
page_cnt, int node_id,
> -			      bool sleepable)
> +			      bool sleepable, bool set_page_slab,
> +			      struct page **out_page)

[Severity: High]
Does this code acquire a sleeping lock inside a raw spinlock?

Both arena_alloc_pages() and arena_free_pages() acquire arena->spinlock usi=
ng
raw_res_spin_lock_irqsave(), which is a raw spinlock. While holding this, t=
hey
call apply_to_page_range() or apply_to_existing_page_range().

These functions walk the page tables and acquire the init_mm page table lock
(ptl), which is a standard spinlock_t. On PREEMPT_RT kernels, standard
spinlocks are sleepable rt_mutexes. Could this trigger a BUG/panic on
PREEMPT_RT due to an invalid wait context?

[ ... ]

> @@ -778,6 +854,21 @@ static void arena_free_pages(struct bpf_arena *arena=
, long uaddr, long page_cnt,
> =20
>  	page_cnt =3D (uaddr_end - full_uaddr) >> PAGE_SHIFT;
>  	pgoff =3D compute_pgoff(arena, uaddr);
> +
> +	/*
> +	 * Drop bookkeeping for any bpf_arena_alloc() fallback pages within the
> +	 * freed range. PageSlab entries are owned by slub and must not be
> +	 * cleared here; slub clears them via bpf_arena_free_slab_page() when
> +	 * the slab page is released.
> +	 */
> +	for (i =3D 0; i < page_cnt; i++) {
> +		fb_page =3D READ_ONCE(arena->slab_pages[pgoff + i]);

[Severity: Critical]
Is there a risk of an out-of-bounds array access here that could bypass the
bounds check and corrupt memory?

If a BPF program passes ptr__ign =3D 0, and arena->user_vm_start has non-ze=
ro
lower 32 bits, clear_lo32() rounds it down to a 4GB boundary, making
full_uaddr this rounded-down value.

The bounds check:
if (full_uaddr >=3D uaddr_end)

evaluates to false because full_uaddr is less than uaddr_end. However,
compute_pgoff() evaluates (u32)(0 - (u32)user_vm_start) >> PAGE_SHIFT, which
underflows to a massive positive index.

Could this massive pgoff allow the loop to iterate over
arena->slab_pages[pgoff + i] out of bounds, potentially writing NULL to
arbitrary kernel memory if it finds a value that passes the !PageSlab() che=
ck?

[ ... ]

> +__bpf_kfunc void bpf_arena_free(void *p__map, void *ptr__ign)
> +{
[ ... ]
> +	if (!PageSlab(page)) {
> +		/*
> +		 * Multi-page allocation from the bpf_arena_alloc() fallback.
> +		 * page->private holds page_cnt stashed at allocation time.
> +		 */
> +		u32 page_cnt =3D page_private(page);
> +
> +		WRITE_ONCE(arena->slab_pages[pgoff], NULL);
> +		set_page_private(page, 0);
> +		arena_free_pages(arena, arena_off, page_cnt, false);
> +		return;
> +	}

[Severity: Critical]
Is there a TOCTOU race condition here when freeing multi-page fallback
allocations?

If a BPF program executes bpf_arena_free() concurrently from multiple threa=
ds
on the same valid pointer, they might both read the page pointer locklessly=
 and
pass the !PageSlab(page) check.

If the first thread calls arena_free_pages(), unmapping the page and freein=
g it
back to the kernel buddy allocator, the second thread will then execute
set_page_private(page, 0).=20

Since the page is already in the buddy allocator at that point, could writi=
ng 0
to its private field corrupt the buddy allocator's internal order-tracking
metadata?

> diff --git a/mm/slub.c b/mm/slub.c
> --- a/mm/slub.c
> +++ b/mm/slub.c

[ ... ]

> @@ -543,7 +558,12 @@ static inline void set_freepointer(struct kmem_cache=
 *s, void *object, void *fp)
>  	unsigned long freeptr_addr =3D (unsigned long)object + s->offset;
> =20
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
> -	BUG_ON(object =3D=3D fp); /* naive detection of double free or corrupti=
on */
> +	if (unlikely(object =3D=3D fp)) {
> +		/* BPF double-free of arena objects must not panic the kernel. */
> +		if (s->bpf_arena)
> +			return;
> +		BUG_ON(object =3D=3D fp); /* naive detection of double free or corrupt=
ion */
> +	}
>  #endif

[Severity: Critical]
Does returning early here to suppress the double-free warning lead to a
corrupted inuse counter?

If a BPF program calls bpf_arena_free() multiple times on the same object,
this early return bypasses the double-free detection for arena caches. Howe=
ver,
__slab_free() still unconditionally executes new.inuse -=3D cnt.

Repeated double-frees will drive the inuse counter to 0. When inuse hits 0,
SLUB assumes the slab is empty and frees the page back to the buddy allocat=
or,
even though other objects in the slab may still be in use by the BPF program
or cached in SLUB's per-CPU sheaves. Could this lead to arbitrary memory
corruption if the page is reused for kernel data structures?

[ ... ]

> @@ -3493,9 +3516,11 @@ static struct slab *allocate_slab(struct kmem_cach=
e *s, gfp_t flags, int node)
>  	init_slab_obj_exts(slab);
>  	/*
>  	 * Poison the slab before initializing the slabobj_ext array
> -	 * to prevent the array from being overwritten.
> +	 * to prevent the array from being overwritten. Arena caches
> +	 * stash uaddr32 in slab->stride; let them keep it.
>  	 */
> -	alloc_slab_obj_exts_early(s, slab);
> +	if (!(s->flags & SLAB_BPF_ARENA))
> +		alloc_slab_obj_exts_early(s, slab);

[Severity: Critical]
Does skipping alloc_slab_obj_exts_early() for arena caches leave
slab->obj_exts uninitialized?

Pages allocated for the BPF arena via bpf_map_alloc_pages() use __GFP_ACCOU=
NT,
which sets folio->memcg_data to point to the memcg. In SLUB, slab->obj_exts
shares the same memory location as folio->memcg_data.

If alloc_slab_obj_exts_early() is skipped, slab->obj_exts is never zeroed a=
nd
retains the memcg pointer. When the slab is freed, won't unaccount_slab() c=
all
free_slab_obj_exts(), which reads the non-null slab->obj_exts and passes it=
 to
kfree(), causing a kernel panic?

[ ... ]

> @@ -5589,14 +5644,19 @@ static void __slab_free(struct kmem_cache *s, str=
uct slab *slab,
> =20
>  			n =3D get_node(s, slab_nid(slab));
>  			/*
> -			 * Speculatively acquire the list_lock.
> -			 * If the cmpxchg does not succeed then we may
> -			 * drop the list_lock without any processing.
> -			 *
> -			 * Otherwise the list_lock will synchronize with
> -			 * other processors updating the list of slabs.
> +			 * Speculatively acquire the list_lock. If the cmpxchg
> +			 * does not succeed we drop the lock without processing.
>  			 *
> +			 * Arena caches may reach here from kfree_nolock() in
> +			 * NMI/irq-off context; trylock and orphan the slab on
> +			 * failure. A later allow_spin caller adopts it.
>  			 */
> -			spin_lock_irqsave(&n->list_lock, flags);
> +			if (unlikely(s->bpf_arena)) {
> +				if (!spin_trylock_irqsave(&n->list_lock, flags))
> +					n =3D NULL;
> +			} else {
> +				spin_lock_irqsave(&n->list_lock, flags);
> +			}

[Severity: Medium]
Can this trylock failure result in permanently leaking orphaned empty slabs?

If spin_trylock_irqsave() fails for an arena cache, n is set to NULL, and t=
he
function returns early without adding the slab to the partial list, orphani=
ng
the slab.

Later, when the slab becomes completely empty (new.inuse =3D=3D 0), __slab_=
free()
acquires the list lock but evaluates:

if (!was_full && !on_node_partial)

Since the slab was orphaned, on_node_partial is false, causing the function
to unlock and return early. The slab_empty discard logic is bypassed. Does
this permanently leak the empty slab until the entire arena map is destroye=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529202438.1640=
8-1-alexei.starovoitov@gmail.com?part=3D3
