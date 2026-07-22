Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1315E2DEA86
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704612; cv=none; b=JMbAHkCtgu7jytOAbI1xUebIR6b6iW/c43QBZtXETpoApPomwJE9b9bebt1cQqrVHTuu2iiNZT8HF83DGDyVEnUvM/LWDKweJaf2B9wRBcSXz8XqrnumOPRsNqtkoWItHPYFklZFVci1T/HvST1xUmUxTcCjo+/25gHsxx/KOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704612; c=relaxed/simple;
	bh=HxjyNfUxKkmZTSUFGNjTIpFRJG983QJ1KTtiUKbDf6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KDZGtfMdUxsxs5hEggQaxTP1lGwrhRK/XG73v19wC56H+WBrS2+QjgXJcneu2X1tSIRgeL0nZaj53UToGshxJfNVNhirmgA+ftUSi0oIxxwF+6hh8L+ossqBvzbldT8UpQu4wI6XvpfEdIYP+jGSnqwqi06J87k/zRbhe+ollsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgWUoxp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgWUoxp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D761F000E9;
	Wed, 22 Jul 2026 07:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784704610;
	bh=Xnm79dzrULnWHYEKHnx8l5QEv8x2Sm7NTAeiJHwM4Bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FgWUoxp5AuDpsyYo8AE6fC9kJScBXNmUVlB5e4irR9f4xtCCupW0sRiGDMaWsC4z6
	 qcofEFDwH8oPownX7GCEyzLzN4GWOEkEHVGNphVZZ/A+DHhI4QENEX0arIueL84bbj
	 kTHwLOtnhSHLJd+BOvXZbncmHFIX6epuVlkTAinoVNBxL8Z0qgGO1UiPJiFRm7cRVy
	 BUjq64Gs6nO1qmBlmUKgd0pt2sWcn2uKEjklanBEPiA8++ZrS54s4kHQlUx67Wjlq9
	 jvLnCjtgNKFXuatdA7ViHRq2qUsfsFbtlqzXPY0TNLOUHoMaLIxL17dAIGz14t7wny
	 umdnE5uWUyvBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Populate mmap-able array map memory
 lazily
Reply-To: sashiko-reviews@lists.linux.dev
To: "Song Liu" <song@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722065308.4116186-2-song@kernel.org>
References: <20260722065308.4116186-1-song@kernel.org>
 <20260722065308.4116186-2-song@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:16:50 +0000
Message-Id: <20260722071650.83D761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] An integer overflow in `array_map_mmap` on 32-bit architecture=
s allows bypassing the VMA bounds check. Combined with pointer arithmetic t=
runcation in the new `array_map_mmap_fault` handler, an attacker can map th=
e `struct bpf_array` header into user space, leading to Local Privilege Esc=
alation (LPE) by overwriting the BPF map's operations pointer.
--

--- Patch [1]: [PATCH bpf-next 1/2] bpf: Populate mmap-able array map memor=
y lazily ---
commit 07e8d5ac0a564f432fdda75a2eb43f2790e3860c
Author: Song Liu <song@kernel.org>

bpf: Populate mmap-able array map memory lazily

This commit modifies mmap-able BPF array maps to populate memory lazily
rather than upfront at map creation time. It adds a new map_mmap_fault
callback to handle inserting pages on demand, reducing the mmap and
munmap complexity to O(1) for large maps.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -576,7 +576,6 @@ static int array_map_check_btf(struct bpf_map *map,
>  static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vm=
a)
>  {
>  	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> -	pgoff_t pgoff =3D PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
> =20
>  	if (!(map->map_flags & BPF_F_MMAPABLE))
>  		return -EINVAL;
> @@ -585,8 +584,42 @@ static int array_map_mmap(struct bpf_map *map, struc=
t vm_area_struct *vma)
>  	    PAGE_ALIGN((u64)array->map.max_entries * array->elem_size))
>  		return -EINVAL;

[Severity: Critical]
Does this bounds check in array_map_mmap overflow on 32-bit architectures?

Since the left-hand side calculation uses 32-bit unsigned long arithmetic,
could an excessive page offset overflow the result to zero, thereby
bypassing the check entirely?

> -	return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
> -				   vma->vm_pgoff + pgoff);
> +	/*
> +	 * The backing memory is vmalloc'ed up front, so instead of wiring up
> +	 * every PTE here we let array_map_mmap_fault() insert pages on demand.
> +	 * remap_vmalloc_range_partial() used to set these flags for us; keep
> +	 * them to preserve behavior (no VMA expansion, excluded from coredump).
> +	 */
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> +
> +	return 0;
> +}
> +
> +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> +				       struct vm_fault *vmf)
> +{
> +	struct bpf_array *array =3D container_of(map, struct bpf_array, map);
> +	pgoff_t pgoff =3D PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
> +	struct page *page;
> +	void *kaddr;
> +
> +	/*
> +	 * vmf->pgoff is the page offset within the mapping (vma->vm_pgoff plus
> +	 * the offset of the faulting address). The data pages start after the
> +	 * bpf_array header, hence the extra pgoff. This mirrors the offset that
> +	 * remap_vmalloc_range(vma, ..., vma->vm_pgoff + pgoff) used to apply.
> +	 */
> +	kaddr =3D array_map_vmalloc_addr(array) +
> +		((u64)(vmf->pgoff + pgoff) << PAGE_SHIFT);

[Severity: Critical]
Can this pointer arithmetic lead to truncation when calculating kaddr?

On 32-bit systems, array_map_vmalloc_addr returns a 32-bit pointer.
If the 64-bit offset calculation is added to this pointer, does it truncate
the upper bits? If an overflowed pgoff was passed from the mmap bounds chec=
k,
could this truncation cause the mapping to wrap around and incorrectly
expose the internal bpf_array header memory to user space?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722065308.4116=
186-1-song@kernel.org?part=3D1
