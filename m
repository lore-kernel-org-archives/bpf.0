Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E851B4F1F
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780106396; cv=none; b=blXSe0c5XVPn2oOJRK80qRMX/S1ewG5n/FMLXr3AWdD5GFGugRCrVhVgajBkSIn6K5uCpr487jQnShSWpvUvyn8hkg+6R8L8DY8HiIflh8Yg0DRsQ72VNElfpsmPAQNAiCfP8OGFZECHDwv57GgYENDcOWxi8ZSVM4v+QVO2NyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780106396; c=relaxed/simple;
	bh=fxYAWofrgnyeViTrxAr+KB6GIeIw5x4xmsOURbESx4c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Oti+OXVxbSMa+E/qmzfyoVZdBRI2TIX51BdmPlNXoS8CNsJxV7GfOhZPYRCK0Zi0CUBpfC4uj4TsBF9QfVVb8TiIclKpVbtJQpwHmw3rpjhHomEcSEm+36QgAqPXwkXnLQzH0EuAt7hBjZfgqngfKxnVrdXG2CRqIEPoH+nv+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLO7b6lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLO7b6lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E821F00893;
	Sat, 30 May 2026 01:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780106394;
	bh=gvQEeaYLW/wYQCXduLu+dmOxzqQTLbCPPqALp/1B/Us=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mLO7b6lrgVqTATAo0H4I+EfeTnXCdbM6R9moHmNM6ps+5yguFdEQ7tyi5N4SJUXiF
	 D6k1oG/wR+bmvPdYl9/tY4Dm2hIF63xBrA4Xg0mmGmprxWx5MAeizaTsBm4qfMHASR
	 CLiNTcoHxFLOh4Jta/mqm7wEXGz5Pu2i6EWJmsvOsVl5igjQovsh7Z4I4jgjoW4oES
	 73YpBy64HhyIWmBo9abbKoolf53eM6R7XRYz7eGm4oDNyeJg1w1SRzaeSttcF2i2Nm
	 q+nGZNK6UodvwD8IrFHh3mi7HiERsh1oQLYWjqIOUKMjirUgymnz/B68K2LxCkoJWi
	 lNMtvieJdqmvg==
Content-Type: multipart/mixed; boundary="===============4695289581068011818=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b629b9f1f284359ed76a11cf1ead7b9061854c0bdd7f67b2b046886c254af005@mail.kernel.org>
In-Reply-To: <20260530011345.99342-4-alexei.starovoitov@gmail.com>
References: <20260530011345.99342-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf,slab: Add slub-backed allocator for bpf_arena
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,memxor@gmail.com,eddyz87@gmail.com,vbabka@suse.cz,harry.yoo@oracle.com,david@kernel.org,tj@kernel.org,roman.gushchin@linux.dev,peterz@infradead.org,linux-mm@kvack.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 30 May 2026 01:59:54 +0000 (UTC)

--===============4695289581068011818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git kernel/bpf/arena.c kernel/bpf/arena.c
> index 1727503b25d8..0f389ccf4c8f 100644
> --- kernel/bpf/arena.c
> +++ kernel/bpf/arena.c

[ ... ]

> @@ -63,10 +74,20 @@ struct bpf_arena {
>  	struct irq_work     free_irq;
>  	struct work_struct  free_work;
>  	struct llist_head   free_spans;
> +
> +	/*
> +	 * SLAB_BPF_ARENA: kva <-> arena offset translation at the kfunc
> +	 * boundary. Forward (kva -> uaddr32) via slab->stride; reverse
> +	 * (uaddr32 -> page) via @slab_pages[pgoff], sized to max_entries.
> +	 */
> +	struct page **slab_pages;
> +	struct kmem_cache *kmalloc_caches[ARENA_KMALLOC_NUM_BUCKETS];
>  };

[ ... ]

> @@ -290,12 +332,25 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
>  		goto err_free_scratch;
>  	mutex_init(&arena->lock);
>  	raw_res_spin_lock_init(&arena->spinlock);
> +	arena->slab_pages = bpf_map_area_alloc(attr->max_entries *
> +					       sizeof(arena->slab_pages[0]),
> +					       numa_node);

The slab_pages[] array is allocated with exactly attr->max_entries entries.
The struct comment documents it as "sized to max_entries" and indexed by
the logical page offset within the arena's 4GB window.

[ ... ]

> @@ -625,7 +687,8 @@ static u64 clear_lo32(u64 val)
>   * Later the pages will be mmaped into user space vma.
>   */
>  static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt, int node_id,
> -			      bool sleepable)
> +			      bool sleepable, bool set_page_slab,
> +			      struct page **out_page)
>  {

[ ... ]

> @@ -720,6 +795,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
>  	}
>  	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	if (out_page)
> +		*out_page = first_page;
>  	kfree_nolock(pages);
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
>  	return clear_lo32(arena->user_vm_start) + uaddr32;

arena_alloc_pages() returns a 64-bit value where the low 32 bits are the
absolute arena offset: clear_lo32(user_vm_start) + uaddr32. This uaddr32
value is (u32)(user_vm_start + logical_pgoff * PAGE_SIZE), so it includes
the low 32 bits of user_vm_start.

[ ... ]

> @@ -770,14 +871,29 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
>  	/* only aligned lower 32-bit are relevant */
>  	uaddr = (u32)uaddr;
>  	uaddr &= PAGE_MASK;
> +	pgoff = compute_pgoff(arena, uaddr);
> +	if (pgoff >= page_cnt_max)
> +		return;
> +	page_cnt = min_t(long, page_cnt, page_cnt_max - pgoff);
> +	if (!page_cnt)
> +		return;
>  	kaddr = bpf_arena_get_kern_vm_start(arena) + uaddr;
>  	full_uaddr = clear_lo32(arena->user_vm_start) + uaddr;
> -	uaddr_end = min(arena->user_vm_end, full_uaddr + (page_cnt << PAGE_SHIFT));
> -	if (full_uaddr >= uaddr_end)
> -		return;
>
> -	page_cnt = (uaddr_end - full_uaddr) >> PAGE_SHIFT;
> -	pgoff = compute_pgoff(arena, uaddr);
> +	/*
> +	 * Drop bookkeeping for any bpf_arena_alloc() fallback pages within the
> +	 * freed range. PageSlab entries are owned by slub and must not be
> +	 * cleared here; slub clears them via bpf_arena_free_slab_page() when
> +	 * the slab page is released.
> +	 */
> +	for (i = 0; i < page_cnt; i++) {
> +		fb_page = READ_ONCE(arena->slab_pages[pgoff + i]);
> +		if (fb_page && !PageSlab(fb_page)) {
> +			WRITE_ONCE(arena->slab_pages[pgoff + i], NULL);
> +			set_page_private(fb_page, 0);
> +		}
> +	}

arena_free_pages() correctly uses compute_pgoff() to convert the 32-bit
arena offset to a logical page index before indexing slab_pages[]. The
compute_pgoff() function subtracts (u32)user_vm_start:

    static long compute_pgoff(struct bpf_arena *arena, long uaddr)
    {
        u32 start = (u32)arena->user_vm_start;
        return ((u32)uaddr - start) >> PAGE_SHIFT;
    }

This gives the correct logical offset in [0, max_entries).

[ ... ]

> +/*
> + * SLAB_BPF_ARENA: per-arena kmem_cache buckets backing bpf_arena_alloc/free.
> + * Slab pages come from the arena pool; slub uses direct-map VAs internally,
> + * BPF sees the arena vmalloc view, translation happens at the kfunc boundary.
> + */
> +struct slab *bpf_arena_alloc_slab_page(void *arena_p, gfp_t flags, int node,
> +				       bool allow_spin)
> +{
> +	struct bpf_arena *arena = arena_p;
> +	long ret_user_va;
> +	struct page *page;
> +	struct slab *slab;
> +	u32 uaddr32;
> +
> +	/*
> +	 * set_page_slab=true makes apply_range_set_cb() tag PageSlab under
> +	 * arena->spinlock so a racing bpf_arena_free_pages() can't free it.
> +	 */
> +	ret_user_va = arena_alloc_pages(arena, 0, 1, node, allow_spin, true, &page);
> +	if (!ret_user_va)
> +		return NULL;
> +
> +	uaddr32 = (u32)ret_user_va;
> +	slab = page_slab(page);
> +	/*
> +	 * Stash uaddr32 in slab->stride; allocate_slab() skips
> +	 * alloc_slab_obj_exts_early() for SLAB_BPF_ARENA so it survives.
> +	 */
> +	slab_set_stride(slab, uaddr32);
> +	WRITE_ONCE(arena->slab_pages[uaddr32 >> PAGE_SHIFT], page);
> +
> +	return slab;
> +}

Does this array indexing work correctly when user_vm_start has non-zero
low 32 bits?

The slab_pages[] array was sized to max_entries, which equals the number
of pages in the arena's 4GB window. It should be indexed by the logical
page offset within that window, computed via compute_pgoff().

Here bpf_arena_alloc_slab_page() indexes it with uaddr32 >> PAGE_SHIFT,
where uaddr32 is the absolute 32-bit arena offset returned by
arena_alloc_pages(). This includes the low 32 bits of user_vm_start.

For example, if user_vm_start = 0x7f7d26200000 (as shown in the file's
comment at line 35), then (u32)user_vm_start = 0x26200000. Right-shifting
by PAGE_SHIFT (12) gives 156160. If the arena's max_entries is 262144
(1GB arena), this index is in bounds. But if max_entries is 131072
(512MB), the index 156160 exceeds the array size.

The same indexing pattern appears in:
  - bpf_arena_free_slab_page() at line 523
  - bpf_arena_alloc() fallback path at line 683
  - bpf_arena_free() at line 736

Should all four use compute_pgoff() instead, matching the corrected
indexing in arena_free_pages()?


> +static u32 arena_slab_uaddr32(const struct slab *slab)
> +{
> +	return slab_get_stride((struct slab *)slab);
> +}
> +
> +void bpf_arena_free_slab_page(void *arena_p, struct slab *slab)
> +{
> +	struct bpf_arena *arena = arena_p;
> +	u32 uaddr32 = arena_slab_uaddr32(slab);
> +
> +	WRITE_ONCE(arena->slab_pages[uaddr32 >> PAGE_SHIFT], NULL);
> +	arena_free_pages(arena, uaddr32, 1, false);
> +}

[ ... ]

> +__bpf_kfunc void *bpf_arena_alloc(void *p__map, u32 size)
> +{
> +	struct bpf_map *map = p__map;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	struct kmem_cache *c;
> +	struct slab *slab;
> +	unsigned int idx;
> +	void *kva;
> +	u32 uaddr32;
> +
> +	if (map->map_type != BPF_MAP_TYPE_ARENA || !size)
> +		return NULL;
> +	if (size > (1U << ARENA_KMALLOC_MAX_SHIFT)) {
> +		struct page *first_page;
> +		long ret_user_va;
> +		u32 page_cnt, pgoff;
> +
> +		page_cnt = round_up(size, PAGE_SIZE) >> PAGE_SHIFT;
> +		if (!page_cnt)
> +			return NULL;
> +		/* sleepable=false mirrors kmem_cache_alloc_nolock() */
> +		ret_user_va = arena_alloc_pages(arena, 0, page_cnt, NUMA_NO_NODE,
> +						false, false, &first_page);
> +		if (!ret_user_va)
> +			return NULL;
> +		pgoff = (u32)ret_user_va >> PAGE_SHIFT;
> +		set_page_private(first_page, page_cnt);
> +		WRITE_ONCE(arena->slab_pages[pgoff], first_page);
> +		return (void *)ret_user_va;
> +	}

[ ... ]

> +__bpf_kfunc void bpf_arena_free(void *p__map, void *ptr__ign)
> +{
> +	struct bpf_map *map = p__map;
> +	struct bpf_arena *arena = container_of(map, struct bpf_arena, map);
> +	struct page *page;
> +	struct slab *slab;
> +	u32 arena_off, pgoff;
> +	void *kva;
> +
> +	if (map->map_type != BPF_MAP_TYPE_ARENA || !ptr__ign)
> +		return;
> +
> +	arena_off = (u32)(unsigned long)ptr__ign;
> +	pgoff = arena_off >> PAGE_SHIFT;
> +	if (pgoff >= arena->map.max_entries)
> +		goto violation;
> +	page = READ_ONCE(arena->slab_pages[pgoff]);
> +	if (!page)
> +		goto violation;

The bounds check pgoff >= arena->map.max_entries cannot protect against
the out-of-bounds access if pgoff is computed as (u32)ptr >> PAGE_SHIFT
instead of compute_pgoff(). When user_vm_start has non-zero low 32 bits,
the raw shift produces an offset that includes those bits, which can be
far larger than max_entries. A 1GB arena starting at user_vm_start =
0x7f7d26200000 would have max_entries = 262144, but the first allocated
page offset would be computed as 0x26200000 >> 12 = 156160, which passes
this bounds check even though the array only has 262144 slots and the
correct logical index should be 0.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26670515779
--===============4695289581068011818==--
