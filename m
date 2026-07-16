Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535D222590
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238199; cv=none; b=BXI4mwEEBmkzbK9HzDw898UN3dgR2mZ3PQXbuMbFfKh1Zmz6PradeRGfYKDkcuckNky4A+0llEgpVcDyuWOdstAmBpCD5mlJwVuwx+NoahAypbjY9ieX1y1KWq24FP9kDQcZXDzmxHkVSA+4bqNTNaJh3b61CROZzQEgaVei2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238199; c=relaxed/simple;
	bh=lMMvdpY8t4y0IbrkLzxL8IdbPXchu1mOGMM2C3I2BTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JxYY3/VPESGKAyZ04OqUhA1EJL0WkRJx6pmn8AGXkRHR6OFRSEKvnf7Bhn1PSNHFlyfErqUBmZd9fc7Nb+6ffQjwZWk1E4Au6vXE2n+2mddliKwoulieKT7tgXchwJDk89xB0Ym4RNL4aqsllSVO5t7qG8MAmIfayGeIAJo7/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV5bn08k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV5bn08k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9891F1F000E9;
	Thu, 16 Jul 2026 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784238197;
	bh=Pv4dsa7OpPD4RarXIdhJ4ZYvJ/oM6Uw+U1u7rVqqqgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CV5bn08kVqwx+jf/W5OfW6OD9Orl6TvQbk6OKK4sI4U9vNkEJplMIOEqv5uaEgD7H
	 S2XvZ6Cvff07ojnLYiMCtadRapCNkDS6OccT5BzGWZnwusp+6AAOJaHb62qwp5Ao0Q
	 1Y8sklnsM+yRjD9eAI2tlf4pOcGEPfvViy4kMTtLdNgp2qMN742rWQcw+Um7MWqGO4
	 VJ6rOJCOAqGtN+/JBbNKiG9Q4Zz23Ptps1gtEKNVN4m7uzg3MmWPLDF/cc9PCU5He5
	 YXrQ3xswbEGZoHPkCjLvwXza0R3O0hjh3fa4rbCIKFvPzsc3CHDgkp5Ibgni4EBQ+t
	 R03Bp+zwTp5ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mm-hotfixes v4 3/4] mm/ptdump: always stabilise against
 page table freeing using init_mm
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260716-series-vmap-race-fix-v4-3-8c108c4317df@kernel.org>
References: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org>
 <20260716-series-vmap-race-fix-v4-3-8c108c4317df@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 21:43:17 +0000
Message-Id: <20260716214317.9891F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ptdump_walk_pgd() accesses user page tables under mmap_write_lock =
without draining per-VMA lock holders, allowing concurrent page table freei=
ng to cause a use-after-free.
--

--- Patch [3]: [PATCH mm-hotfixes v4 3/4] mm/ptdump: always stabilise again=
st page table freeing using init_mm ---
commit 75b68a063760f9b11fe2b9d0fa97f5e54d15f043
Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Subject: mm/ptdump: always stabilise against page table freeing using init_=
mm

This commit fixes races between ptdump and kernel page table freeing by
acquiring a nested mmap write lock for init_mm in ptdump_walk_pgd().
It also adds corresponding assertions to walk_page_range_debug().

> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 973020000096c..5851096e6f656 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -178,11 +178,18 @@ void ptdump_walk_pgd(struct ptdump_state *st, struc=
t mm_struct *mm, pgd_t *pgd)
> =20
>  	get_online_mems();
>  	mmap_write_lock(mm);
> +	/* To stabilise kernel page tables we must hold the init_mm lock too. */
> +	if (mm !=3D &init_mm)
> +		mmap_write_lock_nested(&init_mm, SINGLE_DEPTH_NESTING);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this code leave us
vulnerable to a race with per-VMA lock holders?

The mmap_write_lock() alone doesn't exclude threads already holding a
per-VMA lock. Only vma_start_write() drains them. If a concurrent thread
runs a VMA-locked operation like MADV_DONTNEED, it can clear PMDs and free
PTE pages via PT_RECLAIM while this walk is happening.

Because walk_page_range_debug() configures the walk with no_vma =3D true,
it bypasses VMA lookup entirely:

mm/pagewalk.c:walk_page_range_debug() {
	struct mm_walk walk =3D {
		.ops		=3D ops,
		.mm		=3D mm,
		.pgd		=3D pgd,
		.private	=3D private,
		.no_vma		=3D true
	};

This means we never get a synchronization point to exclude per-VMA
operations. Could this lead to a use-after-free while walking arbitrary
user page tables?

>  	while (range->start !=3D range->end) {
>  		walk_page_range_debug(mm, range->start, range->end,
>  				      &ptdump_ops, pgd, st);
>  		range++;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-series-vma=
p-race-fix-v4-0-8c108c4317df@kernel.org?part=3D3
