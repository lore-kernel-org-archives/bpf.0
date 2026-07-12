Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538593090E8
	for <bpf@vger.kernel.org>; Sun, 12 Jul 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783853726; cv=none; b=R4SFdsFHwuyp6T3y+TXuIb6krQKUS0w8FmdZMPnOPQpBFMkp51hYjZnjg8jvjT4PI8LAqOUZvXWweW36BLi8u8JhQKbFpiBUozh10TtmDNsvSQHL0bsmhtpJjlUmQ5ArVHMHa7ZpgUzJ/mIWuS3uI/u5gIn9vPiwdjyTgPP2nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783853726; c=relaxed/simple;
	bh=B5eaNoDYZhFIyhU1RxuNCRcLBBlHErCvk/C+JJ9kb8o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QQN594JER47keoaj8ewjKkBpXxUB35AAYaEARIDdvf2i1+olTOYxklv/OqB+0g9mqnE1S+ofsv1olFEJhIWhN+FunOVBM0+sHQO9UpdRwqdjjhkNDwxSEm08OoU7KvpMGIjHqDw5E2p9ik5WaI/Jm318NBk/rIKJZTRnaDB7Wvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLSfUMHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLSfUMHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD84B1F000E9;
	Sun, 12 Jul 2026 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783853725;
	bh=Yuq6WBFyh/oI8R1hzh7z9LfQWQ4TNfbpQ7TlHZ/0bys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLSfUMHrGCXvyGjG5C/aTWc1+Hv0ZqlUsK9p9gLZuMNzjuaCgAzLWqTzBt2tbvZqT
	 lN49pGhIRl5chSk/omwDbC+Di8+Gm0gJqqxh0MPvU4x+GxSdivKvcuAH0Y1byD98Ex
	 jTu4F9O7EM9nrPaDGO0sWHLI9CHnYbkZPuIef0w8zK3NlsT7of78GH5+dSpZt+VL6F
	 QCmVg4uBY+nyzPlwyCkBOx1xtOpk+cfA91rg65XsSdZhu4lp0PPS4kW1aRE8XWpV/j
	 2sjOeDeVuBRf1TK28UxbvuV9FML8DktUZ4FDLC4o7xg6/c8Uu+OfIcBzVE/Aqd0y9E
	 wdHMV/jObNPyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v2 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Stoakes" <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260712-series-vmap-race-fix-v2-1-ad134cc3a12a@kernel.org>
References: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
 <20260712-series-vmap-race-fix-v2-1-ad134cc3a12a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 10:55:24 +0000
Message-Id: <20260712105524.CD84B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch incompletely fixes a Use-After-Free race between vmap pa=
ge table freeing and ptdump kernel page table walks. It fails to account fo=
r ptdump walking shared kernel page tables via user or EFI mm_structs.
--

--- Patch [1]: [PATCH mm-hotfixes v2 1/4] mm/vmalloc: acquire init_mm lock =
on huge vmap to avoid ptdump UAF ---
commit 3389cf765da1fbcf8e028033238bb065f9a3ca0e
Author: Lorenzo Stoakes <ljs@kernel.org>

mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF

This patch attempts to fix a use-after-free race between ptdump and vmap
by having vmap acquire the mmap read trylock on init_mm before freeing
page tables when promoting to huge pages. It also updates ptdump to assert
that the mmap write lock is held.

Link: https://lore.kernel.org/linux-mm/20260706203128.162335-1-devnexen@gma=
il.com/

> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 3ae2586ff45b4..bbcfd68d0907d 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c

[ ... ]

> @@ -691,6 +693,16 @@ int walk_page_range_debug(struct mm_struct *mm, unsi=
gned long start,
>  		.no_vma		=3D true
>  	};
> =20
> +	/*
> +	 * When walking userland page tables, an mmap write lock must be held to
> +	 * account for munmap() downgrading to an mmap read lock when tearing
> +	 * down page tables.
> +	 *
> +	 * When walking kernel page tables, an mmap write lock must also be held
> +	 * to account for page table freeing on vmap huge page mapping.
> +	 */
> +	mmap_assert_write_locked(mm);
> +
>  	/* For convenience, we allow traversal of kernel mappings. */
>  	if (mm =3D=3D &init_mm)
>  		return walk_kernel_page_table_range(start, end, ops,

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1afca3568b9b6..1fa9ac6e43d4f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c

[ ... ]

> @@ -158,10 +159,25 @@ static int vmap_try_huge_pmd(pmd_t *pmd, unsigned l=
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
> +	 * Kernel page table walkers either walk ranges they own exclusively or
> +	 * hold the mmap write lock on init_mm (ptdump being the motivating
> +	 * case).
> +	 *
> +	 * Therefore, acquire the mmap read lock to prevent use-after-free when
> +	 * freeing page tables.
> +	 */
> +#ifndef CONFIG_ARM64
> +	scoped_cond_guard(mmap_read_lock_try, return 0, &init_mm)
> +#endif

[Severity: High]
This isn't a bug introduced by this patch, but does this completely fix the
UAF for all ptdump walkers?

When ptdump is invoked on efi_mm or current->mm, it only locks the mmap_lock
of that specific mm_struct before walking the shared kernel page tables.

Since it doesn't hold init_mm.mmap_lock, the trylock here in vmap will
succeed, allowing vmap to free the page tables while ptdump is still
concurrently reading them.

For example, in mm/ptdump.c:ptdump_walk_pgd():

	mmap_write_lock(mm);
	while (range->start !=3D range->end) {
		walk_page_range_debug(mm, range->start, range->end,
				      &ptdump_ops, pgd, st);
		range++;
	}
	mmap_write_unlock(mm);

If this is called with efi_mm or current->mm, the lock on init_mm isn't hel=
d,
and the race remains. The newly added mmap_assert_write_locked(mm) in
walk_page_range_debug() will also pass for efi_mm or current->mm without
verifying that init_mm is locked.

Should ptdump also acquire init_mm's mmap_lock before walking shared kernel
page tables?

> +	{
> +		if (!pmd_free_pte_page(pmd, addr))
> +			return 0;
> +		return pmd_set_huge(pmd, phys_addr, prot);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-series-vma=
p-race-fix-v2-0-ad134cc3a12a@kernel.org?part=3D1
