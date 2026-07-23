Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE0387359
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820841; cv=none; b=oGR/99o76VAdPzCjpYTHwChl4CU59HqtNxC02Rrq31MVvRX4pm9aUHx8ccyI+TLFxTGdwxkCnUbW3xjqtmF4bxO48gcN/lTb0BleBtJRojiAOEUgiAd0vC5/UkuSMCTsbVnbGfwn/3G/G+Vp+DE/w9dKgzkT3Vjti8kCJ3PpB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820841; c=relaxed/simple;
	bh=elhTsgp4LGpXJ1EqDFQ6x9SifwLGHaC9l6G+bJbyyCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vEvkfIaudq58OfMxkyp3jiV693pkKE2mRnyz59c9M6WQt7Ur5rwk/6jvLHm6NftP+7pkCrimyD5JBmGaOr92ED6OzNko+1uD1fsF+3cXkXwRpiX1ZIWybSFeWjcMYbOC4NYTKr4uGdNbPl24waGy7kn9aWQv4uMIZOGrEOxIZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17181F00A3D;
	Thu, 23 Jul 2026 15:33:58 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v6 1/5] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723-series-vmap-race-fix-v6-1-8cc77dcc0018@kernel.org>
References: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
 <20260723-series-vmap-race-fix-v6-1-8cc77dcc0018@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 15:33:58 +0000
Message-Id: <20260723153358.B17181F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to fix a use-after-free race between vmap huge =
page promotion and ptdump by taking `mmap_read_trylock(&init_mm)` before fr=
eeing page tables in `vmap_try_huge_*()`. However, the fix is incomplete. T=
he ptdump utility provides debugfs interfaces (e.g., `/sys/kernel/debug/pag=
e_tables/current_kernel` and `efi` on x86, or `efi_page_tables` on RISC-V) =
that walk the kernel address space using other `mm_struct`s like `current->=
mm` or `efi_mm`. During these walks, `ptdump_walk_pgd()` acquires the write=
 lock on the provided `mm`, bypassing the `init_mm` lock completely. Becaus=
e kernel page tables (PUDs/PMDs) are shared globally across all processes, =
ptdump traverses the exact same kernel page table pages that vmap operates =
on in `init_mm`. Since vmap attempts to read-lock `init_mm`, and ptdump wri=
te-locked `current->mm` (or `efi_mm`), there is no mutual exclusion. vmap w=
ill successfully acquire its lock and free the PTE/PMD pages while ptdump i=
s concurrently dereferencing them.
--

--- Patch [1]: [PATCH mm-hotfixes v6 1/5] mm/vmalloc: acquire init_mm lock =
on huge vmap to avoid ptdump UAF ---
commit efa73ddb526da8e42ad98e0cfb9807d1f1de063d
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>

mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF

This commit attempts to fix a race condition between ptdump walking kernel=
=20
page tables and vmap promoting them to huge pages. It introduces an mmap=20
read lock on init_mm during page table freeing to prevent ptdump from=20
accessing freed pages while walking.

Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@googl=
e.com/T/
Link: https://lore.kernel.org/linux-mm/20260706203128.162335-1-devnexen@gma=
il.com/

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1afca3568b9b6..d5c4d2bb770bf 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c

[ ... ]

> @@ -158,10 +159,24 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned l=
ong addr, unsigned long end,
>  	if (!IS_ALIGNED(phys_addr, PMD_SIZE))
>  		return 0;
> =20
> -	if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
> -		return 0;
> +	if (!pmd_present(*pmd))
> +		return pmd_set_huge(pmd, phys_addr, prot);
> =20
> -	return pmd_set_huge(pmd, phys_addr, prot);
> +	/*
> +	 * Acquire the mmap read lock to exclude ptdump, which walks
> +	 * kernel page tables it does not own under the mmap write lock.
> +	 *
> +	 * Concurrent read lock holders are safe: each exclusively owns
> +	 * the range it operates on and cannot reach this page table.
> +	 */
> +#ifndef CONFIG_ARM64
> +	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm)
> +#endif
> +	{

[Severity: High]
This is a pre-existing issue, but does locking init_mm here fully exclude
ptdump from walking and accessing these page tables?

The ptdump utility can walk the kernel address space using other mm_struct
contexts besides init_mm. For example, reading the current_kernel debugfs
file on x86 triggers a walk using current->mm:

arch/x86/mm/debug_pagetables.c:ptdump_curknl_show() {
    ...
    ptdump_walk_pgd_level_debugfs(m, current->mm, false);
}

This walk acquires the mmap write lock on the provided mm, not init_mm:

mm/ptdump.c:ptdump_walk_pgd() {
    mmap_write_lock(mm);
    while (range->start !=3D range->end) {
        walk_page_range_debug(mm, range->start, range->end, ...);
        ...
    }
    mmap_write_unlock(mm);
}

Because kernel page tables are shared globally, this walk traverses the
exact same page table pages that vmap is operating on in init_mm.

If vmap only takes the mmap read lock on init_mm, and ptdump takes the mmap
write lock on current->mm or efi_mm, there is no mutual exclusion between
the two operations.

Could this allow ptdump to concurrently dereference the PTE pages that vmap
is freeing, resulting in a use-after-free?

> +		if (!pmd_free_pte_page(pmd, addr))
> +			return 0;
> +		return pmd_set_huge(pmd, phys_addr, prot);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-series-vma=
p-race-fix-v6-0-8cc77dcc0018@kernel.org?part=3D1
