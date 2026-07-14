Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2160D412BE3
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050830; cv=none; b=lLIJU86DyGf8Zs1jjBiAnkMYKgX3JuAIwqLfNVT3yjB6Hzy85H+DRCVH94yZhT1n3eFdLb2mjJtvvQbplfOPzSNW0iFvEsLFUmRuO5VWdCOPtsFseFUnZ3BaJ3tYjH9pZCzZ5shLRy4RyDlja/2qzK4p0O5xe5BBzbJA421gmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050830; c=relaxed/simple;
	bh=E+zJjF7xWInjseOsL1bQ+8RQkfAifewpFBD99jlCOks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j6Ir0iunpBoANc5beBmqgX7efs0u75XV/r7xJXkrSV9HSygcKan9fRi2PFi1b5dbPB984meYxumBKBare8fXY+WjKqVxd/6I73QADTyMdKzglZgCCW8nab62pcHnv0muWPhqthjdpWd/EPa3bQo8GDaXTvkYc4VyxLkUaK0vW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUNzAwjA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUNzAwjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796481F000E9;
	Tue, 14 Jul 2026 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784050825;
	bh=WQrRmmeHD0dXbkoU7U10TgZt0C3Nuu7fi5jGOn4Um0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUNzAwjAtVZ6IXhZIOhxiNsfqdw9RZOjn1UroaiCmYy/fDXreKwTiCtKBCwRiinzI
	 bjnFvqMq53XI9IWG2J7Km0wei8NssBfJfVk88RjSo5Ya4nbDrxzV1xFPgltsO8Qonl
	 TIbIlzrLj/EV0OJ66Qr7MzKQ0tvdb/xNZhVi2m35yTlv6JUi4zJQX8mztewTvGsfGT
	 Ebxon1QoNN4xbba4pe56j3SN0cUk5ZlcWBBfPEPKJ/GXGHL2ZSxLq+kbU4FkA/wyJP
	 Mu5mXuwIzLH1+20kD/xaeULLuVR7tjFA9sdrRWFfMLv/iI4ojDOMXN5T531bAVWpNf
	 8Ic1M7o8hdlWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v3 1/4] mm/vmalloc: acquire init_mm lock on
 huge vmap to avoid ptdump UAF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Stoakes" <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714-series-vmap-race-fix-v3-1-b812eccfa0f9@kernel.org>
References: <20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org>
 <20260714-series-vmap-race-fix-v3-1-b812eccfa0f9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:40:24 +0000
Message-Id: <20260714174025.796481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch attempts to fix a Use-After-Free race between vmap huge =
page promotion and ptdump by taking a read trylock on `init_mm.mmap_lock` b=
efore freeing page tables. However, the fix is incomplete. On x86 and arm64=
, ptdump can walk kernel page tables via `efi_mm` or `current->mm` (e.g., t=
hrough `/sys/kernel/debug/page_tables/current_kernel`). In these cases, ptd=
ump acquires the `mmap_write_lock` for the specific `mm` being walked, but =
does NOT acquire `init_mm.mmap_lock`. As a result, the trylock in `vmap_try=
_huge_pmd()` will succeed, and vmap will free the shared kernel page tables=
 while ptdump is actively walking them, leaving the UAF unresolved.
--

--- Patch [1]: [PATCH mm-hotfixes v3 1/4] mm/vmalloc: acquire init_mm lock =
on huge vmap to avoid ptdump UAF ---
commit c32cd4adc90548fc5b0ca8b1bc9ac0e27ae2f214
Author: Lorenzo Stoakes <ljs@kernel.org>

mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF

This commit attempts to fix a Use-After-Free race between ptdump and vmap h=
uge
page promotion by acquiring a read trylock on init_mm.mmap_lock before free=
ing
page tables.

Link: https://lore.kernel.org/linux-mm/20260706203128.162335-1-devnexen@gma=
il.com/
Closes: https://lore.kernel.org/all/6a287988.39669fcc.33b062.00a0.GAE@googl=
e.com/T/

> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 3ae2586ff45b4..bbcfd68d0907d 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
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

[Severity: High]
This isn't a bug introduced by this patch, but does this assertion fully
protect shared kernel page tables during ptdump walks?

If ptdump walks kernel page tables via efi_mm or current->mm (for example,
through /sys/kernel/debug/page_tables/current_kernel), it locks the specific
mm being walked. This satisfies mmap_assert_write_locked(mm) in
walk_page_range_debug(), but it leaves init_mm unlocked.

>  	/* For convenience, we allow traversal of kernel mappings. */
>  	if (mm =3D=3D &init_mm)
>  		return walk_kernel_page_table_range(start, end, ops,

[ ... ]

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1afca3568b9b6..1fa9ac6e43d4f 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
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
> +	{

[Severity: High]
This is a pre-existing issue, but does locking only init_mm here completely
resolve the use-after-free?

Because ptdump can walk shared kernel page tables (above TASK_SIZE) using
efi_mm or current->mm, it will acquire the mmap_lock for that specific mm,
not init_mm.=20

In that scenario, this trylock on init_mm.mmap_lock will succeed. This allo=
ws
vmap to free the PTE page while ptdump is actively reading it, leaving the
use-after-free unresolved for these specific debugfs paths.

> +		if (!pmd_free_pte_page(pmd, addr))
> +			return 0;
> +		return pmd_set_huge(pmd, phys_addr, prot);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-series-vma=
p-race-fix-v3-0-b812eccfa0f9@kernel.org?part=3D1
