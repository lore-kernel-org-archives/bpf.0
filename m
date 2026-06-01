Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF3423393C;
	Mon,  1 Jun 2026 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340284; cv=none; b=qCbIkNSHlHJU9w41YRMDKIzwBJVKw9EMoj762zlFOU0/jND2RtvGLjbjV5CrzpWcEbQEna+I/jtBEydoADyvTsBQZTDF1HWGyY+urWu+8PEzPzmPhNWY4NwM5zhmDhNjgIJ0eZaeArNjefSEYMK3hopcqAWg1IRnuGG0y/BWjew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340284; c=relaxed/simple;
	bh=yRMay8ztBq1oRZs/VDDM24K1p4t3B+LtKCuSuuTycEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iL4t+v5tE7ahjfomsT5ohkTLBcF2F0FQ0RrIdQ+amyGpglGE1U6wOi/yO8oILn5lK5SBFBmKXCQmtk1rgvo9Gu5vUUUlHZL4qbWM8kxTfYmSA0bqyxHU8e4/Ef1slIs/NiMhQAQZgcZC12R5/fZ/nkkrPBxcFesZ/rORo+GOMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlEBJZjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlEBJZjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22171F00893;
	Mon,  1 Jun 2026 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780340282;
	bh=3N5P2gpKxerXP3VehMb0w4n+9h/Z0zVwrIMwJTm545U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MlEBJZjp777Ugtrbn2mMkQEOjHErM9H5DRvRIIBjDvDrIESyeIG3+nBsIudpDoSor
	 9fbwtManuH9Hcj5VIF4CodOHT7Cpb5k9vennYsdjO1dJ81D8R7zagA0va1JAX+IdAo
	 8EnVpDVjYWDPBmacfZ60kSQlA1uq6GGWFWL4REldfd0D33ggR5PUl++XafkT11YfCX
	 Xt4yATn6mXLnmaq4UPNonej8ZotGQWACRXDeAo/3vHJIbmJWl0l86F8V8daBgCiEP/
	 1TAOnzE6Fk+e7X59s50htOcX0SyvOxVIdf1v9iO2IZqwKREFS9j5D0bb/6xXtQVqnp
	 E9fFi8m/UafJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Replace scratch PTE atomically when
 allocating arena pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260601183728.1800490-1-tj@kernel.org>
References: <20260601183728.1800490-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 18:58:02 +0000
Message-Id: <20260601185802.B22171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Replacing the populated scratch page PTE with a newly allocate=
d page lacks a TLB flush on architectures where `flush_tlb_before_set()` is=
 a no-op, causing silent data corruption.
- [High] Calling `pte_page(old)` without checking `pte_present(old)` can ca=
use an invalid pointer dereference or kernel panic.

Pre-existing issues:
- [High] Calling memory allocation and page table walking functions with in=
terrupts disabled causes lock nesting violations and scheduling while atomi=
c bugs.
--

commit b6f9fe34365955853d165d4a39abcf4bf12f7b70
Author: Tejun Heo <tj@kernel.org>

bpf: Replace scratch PTE atomically when allocating arena pages

This commit modifies the BPF arena allocation to replace the shared scratch
page with a newly allocated page. To support architectures like arm64, it
uses ptep_try_set() to do a valid->invalid->valid transition, providing a
new flush_tlb_before_set() hook for the break-before-make sequence. For
architectures without ptep_try_set(), it falls back to checking pte_none()
and setting the PTE directly.

> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index b5739bb99fc15..4c6c4081ef715 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h

[ ... ]

> @@ -1061,6 +1061,24 @@ static inline bool ptep_try_set(pte_t *ptep, pte_t=
 new_pte)
>  }
>  #endif
> =20
> +#ifndef flush_tlb_before_set
> +/**
> + * flush_tlb_before_set - invalidate a kernel PTE's TLB before re-settin=
g it
> + * @addr: kernel virtual address whose PTE was just cleared
> + *
> + * Some architectures (e.g. arm64) do not allow a live page-table entry =
to be
> + * repointed at a different page in one step. The old entry must first b=
e made
> + * invalid and its translation flushed from every TLB, and only then may=
 the new
> + * entry be written.
> + *
> + * This is only for the lockless atomic kernel-PTE installers (ptep_try_=
set()).
> + * It must be callable with interrupts disabled.
> + */
> +static inline void flush_tlb_before_set(unsigned long addr)
> +{
> +}

[Severity: Critical]
Since the generic implementation of flush_tlb_before_set() is an empty
function, does this leave a stale TLB entry on architectures like x86?

When the scratch page is replaced, ptep_get_and_clear() clears the PTE, and
then ptep_try_set() installs the newly allocated page. If the architecture
uses the generic fallback for flush_tlb_before_set(), there is no TLB flush
before the new entry is written, and the allocation loop doesn't seem to
perform a deferred flush either.

Could this result in BPF programs continuing to read and write the shared
scratch page instead of the new memory?

> +#endif
> +
>  #ifndef wrprotect_ptes
>  /**
>   * wrprotect_ptes - Write-protect PTEs that map consecutive pages of the=
 same
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index a641b19255aad..799fb49768e69 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -154,19 +155,44 @@ static int apply_range_set_cb(pte_t *pte, unsigned =
long addr, void *data)
>  {
>  	struct apply_range_data *d =3D data;
>  	struct page *page;
> +	pte_t pteval;
> =20
>  	if (!data)
>  		return 0;
> =20
>  	page =3D d->pages[d->i];
>  	/* paranoia, similar to vmap_pages_pte_range() */
>  	if (WARN_ON_ONCE(!pfn_valid(page_to_pfn(page))))
>  		return -EINVAL;
> =20
> -	set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
> +	pteval =3D mk_pte(page, PAGE_KERNEL);
> +#ifdef ptep_try_set
> +	/*
> +	 * Kernel-fault recovery may have installed the scratch page here, and
> +	 * some architectures (arm64) prohibit valid->valid PTE transitions.
> +	 * Install atomically into a none slot. If scratch is present, clear it
> +	 * and flush_tlb_before_set() (break-before-make) before retrying.
> +	 */
> +	while (!ptep_try_set(pte, pteval)) {
> +		pte_t old =3D ptep_get(pte);
> +
> +		if (pte_none(old))
> +			continue;
> +		if (WARN_ON_ONCE(pte_page(old) !=3D d->scratch_page))

[Severity: High]
Can calling pte_page(old) here without first checking pte_present(old)
cause an invalid pointer dereference?

The function pte_none() only guarantees the PTE is not completely empty, but
it doesn't ensure it is present. If the PTE contains a non-present entry
like a swap entry or a poison marker, pte_page() will interpret the swap
metadata as a physical page frame number.

Additionally, on architectures like x86 with CONFIG_DEBUG_VM enabled,
pte_pfn() asserts pte_present(), which would trigger a kernel panic. Should
this check pte_present(old) before extracting the page?

> +			return -EBUSY;
> +		ptep_get_and_clear(&init_mm, addr, pte);
> +		flush_tlb_before_set(addr);
> +	}

[ ... ]

> @@ -475,7 +501,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	if (ret)
>  		goto out_sigsegv_memcg;
> =20
> -	struct apply_range_data data =3D { .pages =3D &page, .i =3D 0 };
> +	struct apply_range_data data =3D { .pages =3D &page, .i =3D 0,
> +					 .scratch_page =3D arena->scratch_page };
>  	/* Account into memcg of the process that created bpf_arena */
>  	ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);

[Severity: High]
This is a pre-existing issue, but does calling bpf_map_alloc_pages() here
with interrupts disabled cause lock nesting violations or scheduling while
atomic bugs?

Looking at arena_vm_fault(), raw_res_spin_lock_irqsave() is called earlier,
disabling interrupts. Then bpf_map_alloc_pages() is called, followed by
apply_to_page_range(). The apply_to_page_range() function can dynamically
allocate page tables using GFP_KERNEL (which can sleep) and acquires the
page table lock, which is a sleepable rt_mutex on PREEMPT_RT kernels.

A similar pattern exists in arena_alloc_pages(), where
raw_res_spin_lock_irqsave() is taken before the while loop that calls
apply_to_page_range(). Is it safe to call these sleepable functions inside
an IRQ-disabled critical section?

>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
>  		goto out_sigsegv_memcg;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601183728.1800=
490-1-tj@kernel.org?part=3D1
