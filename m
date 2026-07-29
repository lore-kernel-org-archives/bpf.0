Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A01F78E6
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285254; cv=none; b=GJ/mLw2UjT73p7UTtz8NX2EyUkl53yO4WA7qdBej/GInKvQSHH9SdXxbvbnJfZD/8v2LhufLLUo2vwtFw2IbzDCiecENeQEgRpotiief25/jYnL+LHFiFwzri7L2SWuJbO3wp5wH5UFAZSkerxFRaIOi8MgOEP6rf3B7uuZauNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285254; c=relaxed/simple;
	bh=4D760caQohMbdmIQWJjXJbQzKhWr34X/SEurCQ/mxqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cDDwcCqefIKQ2eWFBN2nrGd+ukRctJ/FJ3G4qLKo1FH/oPvKTGzozJKbyFQLBhrn3ekROByED0uvMuCAFGsiDSeb3Gvtq5TC4T7k8KFIs6cyHIXJ1ACFjbRcRxJaecLgpKDEZdVsoPfIWYtqjlaVBghK5epgCffLe9NbvjZtAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJOJoULC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJOJoULC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E381F00A3A;
	Wed, 29 Jul 2026 00:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785285252;
	bh=D+rIVDU4xjJXAh4hQ73UtXgpR+4+fonrGP73I4BPYFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJOJoULCPQxDIaVilSvBc8GAQUDkuNe/Hdd5HQaacTPZpPUlQOWIbeVajnHgalPBA
	 rKRcStfDx/VXeQY/0uZ5eG/CNu4Czdh2CApn6L3I6EnlPACAodP2CAjWMotYc6YiXD
	 51/FMIhEGDpGHrGvLd/EfvI7gTpD6ps3kagCfrY+L2ADhil/8JpomXA1tzYK4pzLFE
	 9qJwwbSl4LDVPFBsLGVPucEWUOUv5zNw/FEVxynmxOE/QkzO+TMCsC64K5W8zPFqHh
	 YNzAKxgCoF2SMxuiOL3UaaVQ9yqGBGdcgRYVPE9wb20VXoXXMnGhtBdYS1QTjMCRAj
	 bqaLkvp95ZFvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 1/1] bpf: Populate mmap-able array map
 memory lazily
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729001033.3433328-2-song@kernel.org>
References: <20260729001033.3433328-1-song@kernel.org>
 <20260729001033.3433328-2-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 00:34:11 +0000
Message-Id: <20260729003412.76E381F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing D-cache flush when lazily populating userspace mappings of=
 vmalloc'ed memory, causing potential stale data disclosure.
--

--- Patch [1]: [PATCH v3 bpf-next 1/1] bpf: Populate mmap-able array map me=
mory lazily ---
commit 9d0c286aed96b18164a50c44ca2ef60d558d9222
Author: Song Liu <song@kernel.org>

bpf: Populate mmap-able array map memory lazily

This commit changes BPF array maps with BPF_F_MMAPABLE to map memory lazily.
It replaces the eager remap_vmalloc_range() call with custom fault handlers
that populate PTEs on demand to improve mmap performance for large maps.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178cd..3594e26b9fb88 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[ ... ]

> @@ -576,17 +577,118 @@ static int array_map_check_btf(struct bpf_map *map,
> +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> +				       struct vm_fault *vmf)
> +{
> +	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> +	struct page *page;
> +
> +	page =3D array_map_fault_page(array, vmf->pgoff);
> +	if (!page)
> +		return VM_FAULT_SIGBUS;
> +
> +	get_page(page);
> +	vmf->page =3D page;
> +

[Severity: High]
Does this fault handler need to explicitly flush the D-cache for the resolv=
ed
vmalloc page?

Previously, the eager mapping used remap_vmalloc_range_partial() which calls
vm_insert_page(), and vm_insert_page() explicitly calls flush_dcache_folio(=
).
By returning the page directly to the fault handler without a D-cache flush,
can architectures with aliasing D-caches expose uninitialized physical memo=
ry
to userspace, bypassing the kernel's cached writes?

> +	return 0;
> +}

[ ... ]

> +static vm_fault_t array_map_mmap_pages(struct bpf_map *map, struct vm_fa=
ult *vmf,
> +				       pgoff_t start_pgoff, pgoff_t end_pgoff)
> +{

[ ... ]

> +	for (pgoff =3D start_pgoff; pgoff <=3D end_pgoff;
> +	     pgoff++, vmf->pte++, addr +=3D PAGE_SIZE) {
> +		struct folio *folio;
> +		struct page *page;
> +
> +		if (!pte_none(ptep_get(vmf->pte)))
> +			continue;
> +
> +		page =3D array_map_fault_page(array, pgoff);
> +		if (!page)
> +			continue;
> +
> +		folio =3D page_folio(page);
> +		folio_get(folio);

[Severity: High]
Similarly, in this fault-around handler, is a flush_dcache_folio() call
needed before installing the PTE?

Calling set_pte_range() directly bypasses the D-cache flush that
vm_insert_page() would have provided, which might result in userspace
reading stale physical RAM contents on architectures with VIVT or VIPT
aliasing D-caches.

> +		set_pte_range(vmf, folio, page, 1, addr);
> +		rss++;
> +		if (addr =3D=3D vmf->address)
> +			ret =3D VM_FAULT_NOPAGE;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729001033.3433=
328-2-song@kernel.org?part=3D1
