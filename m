Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AD3CB551
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673610; cv=none; b=qQVR8dlRzk3r9LixHyWjFMBVdawZo+BI6B88z7G/BFdMhdZdjymxCGElGFpQVhw6lerTnZ20463YgVbbBLflUDsbv6kSqwWVjzmUeK0Lb/k9oXvpZZWP847PLROJzc3tR35sbblmQrNtgE3Vx14tx0rFfYywU8oVA475Y+BJUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673610; c=relaxed/simple;
	bh=aGJv4dVt86SzLoW3qHRE8YgU3+MjIGXVWul/sgoFGVQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=utAqCHC0+gRkSU+R6DDFEh4mUIZKpaE7uTzFR2hZCWD+hTyXVadWuH9/Dgdmp9QRxTDAEjDCVn4O461Ut4RKx5AsOi9PlIHBpvLOQtJODcmxarfuh3802xn+S90gJV6LeCsFkIgQfNv9iLKkQonXvscpxmAjvJxxfNFEctDxDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqIgWEZ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqIgWEZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD401F000FF;
	Sat, 10 Oct 2026 23:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791673606;
	bh=CWoqbvEk8jIgRMK08QSBmDtCL8zH3hB8B8zQRsNn1ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JqIgWEZ27Rr+zdky5VzBa8jOtvGF4y0SHH9w64BjKQTdWeRzG4wlawQGP/gBhKxUX
	 pp2LVLw7+74HgPVFv35usDxdu63E/m64uwbO8QJ8x8YHtGrchg9ExNlkUPQyVlPSbX
	 JXejJHDQaYoq3mMXC0rDbb9oNUIogP8Y2auy+t/snfJBXTUnR/b3Il6zsHd+dgdnIk
	 oARPmbUI9/psenDsXyLRlxCrzdRjAJ2iYfSulaB6Rni4beNknVz3sUH/3n8Ku3MBMd
	 IPW9MsdC9zgqzbUZl+ZkVbPzKYlQe+1Mfgnjn+OOAqWi7sTPS+ym6lYOmvFE6oJYrD
	 0AKteATt1I2Gw==
Message-ID: <sashiko-outbox-166925@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] bpf: Expose pinned arenas as sized bpffs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrea Righi" <arighi@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261010224902.1232178-3-arighi@nvidia.com>
References: <20261010224902.1232178-1-arighi@nvidia.com>
 <20261010224902.1232178-3-arighi@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 23:06:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: unreachable overlap calculation logic for exported arenas in z=
ap_pages()
--

commit 0faffaea3054cd9867f7c5fb15288b7583784671
Author: Andrea Righi <arighi@nvidia.com>

bpf: Expose pinned arenas as sized bpffs files

This commit introduces the BPF_F_ARENA_EXPORT flag to expose pinned BPF
arenas as sized files in bpffs, allowing userspace programs to mmap them.
Map fault handling and page zapping are updated to support disjoint slice
mappings using file offsets. It also mandates that exported arenas use the
BPF_F_ARENA_NO_FREE flag.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
[ ... ]
> @@ -881,8 +917,14 @@ static void zap_pages(struct bpf_arena *arena, long =
uaddr, long page_cnt)
>  		 */
>  		vma =3D find_vma(mm, vm_start);
>  		if (vma && vma->vm_start =3D=3D vm_start &&
> -		    vma->vm_file && vma->vm_file->private_data =3D=3D &arena->map)
> -			zap_vma_range(vma, uaddr, size);
> +		    vma->vm_file && vma->vm_file->private_data =3D=3D &arena->map) {
> +			vma_start =3D (u64)vma->vm_pgoff << PAGE_SHIFT;
> +			vma_end =3D vma_start + vma->vm_end - vma->vm_start;
> +			if (start < vma_end && end > vma_start)
> +				zap_vma_range(vma, vma->vm_start +
> +					      (max(start, vma_start) - vma_start),
> +					      min(end, vma_end) - max(start, vma_start));
> +		}

[Severity: Low]
Is this overlap calculation in zap_pages() reachable for exported arenas?

The offset calculation here uses vma->vm_pgoff to compute overlaps for
partial page zaps. This specific offset math is only strictly necessary
for exported mappings, because canonical arena VMAs always have a zero
page offset.

However, zap_pages() is exclusively called during page freeing operations
such as bpf_arena_free_pages() or via arena_free_worker().

Because arena_map_alloc() requires exported arenas to have the
BPF_F_ARENA_NO_FREE flag set, and bpf_arena_free_pages() explicitly returns
early when this flag is present, BPF programs can never free pages in
exported arenas.

Could this make the newly added partial zap logic using vma->vm_pgoff
completely dead code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010224902.1232=
178-1-arighi@nvidia.com?part=3D2
