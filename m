Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEEC3644B3
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 02:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673259; cv=none; b=krz2Irh+T4U7solJRCLFV9LuURyvW7XuNErDNmVqX27rFU34K0QstdeeB6UTx1kLwS7gytKpc92FEdLI+RhnC6JDChMXJ3hBkqLdtq+QiO8bVOOeIuIiT71crLJXn9P7VedN3j75sl2+tKUrkPazKPUlAmrYZKcNrB0hBDjMHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673259; c=relaxed/simple;
	bh=HEhnaCTa/YTK7u68z+muvv6mbLByjzgD/w4ovlb/rKY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lFgP3kbeWlA7irhdlS/C2xvo7lgB5ZHFAPmJ+lhPofPxqlKlUh3vRcsfWs1G6seQmmrpYoc1MqNgEkXNuxMA2UqSWN7R2cQDX3BWUn9YffnbijJWwSsx60nWUtKkx0OSKexC9ZaFE26hv1PvTcVG159PWmzH4UG4y7fIxWyUDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEYgCx/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEYgCx/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529571F000E9;
	Fri, 14 Aug 2026 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786673257;
	bh=JE6XUTDSnjPyWvVaNiGTRgCvi8AVm+K1iQcJ/pn2Z5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bEYgCx/td79kq0HH8zBP0pHAYkJxfr1myuIHPknuZjJ0WsPUy+c5QIx8BDSHlHwT1
	 nG5TddstHkecT5gILqB+lFQX0zdfoow78427zCPR0q5uxexW32CCEmy+0QEtftn+kx
	 TRg8/wXMg6GfEnTVRpeyS0rVOK/upcmw9kHfA1Q5e5j8woo/kqbVYXeRPoS1PylddA
	 4QrDMRs2wOvjFI+DMYzapEQNcS6XaNwW6C9XWPRH9MIA9e1eQr/d/XbT5Xldo9llTD
	 iJDBlQUcZCOUcnroB05Ux4sqMyKTaxqFSLOGQuARKPWJI71PDBfwq9EwoATHYLNncu
	 mfC5+qOQ21yzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 bpf-next] bpf: Populate mmap-able array map memory
 lazily
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813224853.1436734-1-song@kernel.org>
References: <20260813224853.1436734-1-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:07:33 +0000
Message-Id: <20260814020737.529571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Integer overflow in `array_map_mmap` bounds check allows mappi=
ng arbitrary kernel memory, leading to arbitrary kernel code execution.
--

--- Patch [1]: [PATCH v6 bpf-next] bpf: Populate mmap-able array map memory=
 lazily ---
commit ef1e2903b40b525ff2c8448b624a44742a4bc1a4
Author: Song Liu <song@kernel.org>

bpf: Populate mmap-able array map memory lazily

This patch replaces the eager remap_vmalloc_range() in array_map_mmap()
with lazy, on-demand page faulting via array_map_mmap_fault(). This makes
mmap() O(1) by only setting up the VMA bounds and inserting pages during
actual accesses.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 34865701f7f75..a6e44428a6c52 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -608,17 +608,37 @@ static int array_map_check_btf(struct bpf_map *map,
>  static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vm=
a)
>  {
>  	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> -	pgoff_t pgoff =3D PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
> =20
>  	if (!(map->map_flags & BPF_F_MMAPABLE))
>  		return -EINVAL;
> =20
> -	if (vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
> +	/* use u64 math so the offset cannot overflow on 32-bit archs */
> +	if ((u64)vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
>  	    PAGE_ALIGN((u64)array->map.max_entries * array->elem_size))
>  		return -EINVAL;

[Severity: Critical]
Can this arithmetic wrap around 64 bits to a small value, bypassing the saf=
ety
check in array_map_mmap()?

If the user-provided vma->vm_pgoff is carefully crafted, the 64-bit addition
could wrap around to a small value. This overflow was previously harmless
because the eagerly mapped remap_vmalloc_range() strictly guarded against
shift overflows.

> -	return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
> -				   vma->vm_pgoff + pgoff);
> +	/* pages are faulted in on demand by array_map_mmap_fault() */
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> +
> +	return 0;
> +}
> +
> +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> +				       struct vm_fault *vmf)
> +{
> +	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> +	struct page *page;
> +
> +	page =3D vmalloc_to_page(array->value + ((u64)vmf->pgoff << PAGE_SHIFT)=
);

[Severity: Critical]
Does this shift lack overflow checking, allowing backwards pointer arithmet=
ic
in array_map_mmap_fault()?

If a wrapped pgoff bypasses the bounds check in array_map_mmap(), shifting =
the
user-controlled pgoff here without validation can produce a large negative
offset. Since array->value is explicitly aligned to start on the second page
of the map's vmalloc allocation, a negative offset could walk backward to t=
he
first page, inadvertently exposing the struct bpf_array metadata to userspa=
ce.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813224853.1436=
734-1-song@kernel.org?part=3D1
