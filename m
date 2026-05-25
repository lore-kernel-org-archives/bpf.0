Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D82305677
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 23:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779750693; cv=none; b=Lco6drrw/Y8RbufPDGsl1FnkR12oROnnSmwrnAR+44aaikw/pbvMkLx3DeZCvoR2ADGBiiOmdM8ewSekoNAG/kom6vDctjomoiyF5xA4s2BCvHZVi/bnXxHy8wux5gxkdapgGNBE9dKpWvOwlq1Zl5qLnM+WVuoTwGJ2eBucCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779750693; c=relaxed/simple;
	bh=+0mwPhzTIenyX59ZkA3eWcZMC/NSDmRUeM0ohrWwzYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mFtqDE3u6mXPviPS0QqLsUhP5EZcTdPtYwgKBvOAkkTFOicv7KKzZOuphllg9D4XV3mnLYmOp/y33MAm17Ex5t8xGswmC6pcHISSXFdLCjy9ZYQyVVAxyvCNlItl55gOr0Pl2XYVmAaJmAMLqaJYZTY7eEGA4DzJjUEl5AaCErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na+bMHoa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na+bMHoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895201F000E9;
	Mon, 25 May 2026 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779750691;
	bh=+YJ+oiTLCYjniqGJ/xO5m7rYAInNKxkT0fya6901onQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=na+bMHoaeUnsAdkJI7FcKCxru4NC11UYh/deUvq2AL9b13DMBJKBE2BO9/XBb1Gbw
	 +eEwrtHE4FGcB5tOK3lbEis10e1+O5zT18s+JUoxsHsL/WobG6k7H3/DkhWykmmiKU
	 ANweOtV4MQ2+lQ5zrJOcLNRfaigqflF0Ol48hC4PGzD/p+GBMUIszqqmr4uZpkS58c
	 2IeaEwG5LRCMdCjTGpJSqUUMURqOuVvncvVfrBoxnAi+yFkplcE0jl1hq6jlPXnCrM
	 zCcn7nT78lqyBk7NHzNj4FYpdViC1beVhWAXTq4+u57QtxRCHntlwfar02ezYzJbFD
	 +gOFVFQY0pW6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf: Factor out stack_map build ID
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260525223948.1920986-2-ihor.solodrai@linux.dev>
References: <20260525223948.1920986-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 23:11:31 +0000
Message-Id: <20260525231131.895201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The refactored VMA caching logic bypasses the cache for fallback=
 cases and evicts valid VMAs, directly contradicting the patch's stated goa=
l.
--

commit e38559ed451d61a994765f3bfb260cc14edd3569
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Factor out stack_map build ID helpers

This patch refactors stack_map_get_build_id_offset() to use helpers and
continue-driven control flow. It also attempts to optimize VMA caching
by updating the cached VMA on the fallback-to-IP branch to prevent
redundant parsing attempts for anonymous or failing VMAs.

Link: https://lore.kernel.org/bpf/CAEf4Bzac9uWWqBvzH0iFzKvJcq3vxscZ3pKm0sUH=
mN-F-z9wVQ@mail.gmail.com/
Link: https://lore.kernel.org/bpf/226398c1ff3f2b686c0aeb010408d85fb15df13f9=
ff60a045bee31e79b9e41e9@mail.kernel.org/

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15a..e23be7d445038 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -165,44 +187,45 @@ static int fetch_build_id(struct vm_area_struct *vm=
a, unsigned char *build_id, b
>  static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_=
offs,
>  					  u32 trace_nr, bool user, bool may_fault)
>  {

[ ... ]

>  	for (i =3D 0; i < trace_nr; i++) {
>  		u64 ip =3D READ_ONCE(id_offs[i].ip);
> +		u64 offset;
> =20
> -		if (range_in_vma(prev_vma, ip, ip)) {
> +		if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
>  			vma =3D prev_vma;
> -			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
> -			goto build_id_valid;
> +			offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip=
);
> +			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
> +			continue;
>  		}
>  		vma =3D find_vma(current->mm, ip);
> -		if (!vma || fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
> +		if (!vma || vma_is_anonymous(vma) ||
> +		    fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
>  			/* per entry fall back to ips */
> -			id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> -			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
> +			stack_map_build_id_set_ip(&id_offs[i]);
> +			prev_vma =3D vma;
> +			prev_build_id =3D NULL;

[Severity: Medium]
Does setting prev_build_id to NULL here inadvertently defeat the VMA caching
optimization mentioned in the commit message?

The commit message states the intent is to update prev_vma and prev_build_id
on this fallback branch so the cache reflects the actual VMA seen. However,
the cache check at the top of the loop now requires prev_build_id to be
non-NULL:

    if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {

Since prev_build_id is set to NULL on failure, won't consecutive IPs falling
into the same anonymous or failing VMA bypass the cache completely and trig=
ger
redundant find_vma() lookups?

Also, does overwriting prev_vma with the failing VMA while disabling the
cache hit (via NULL prev_build_id) evict the last successful VMA from the
cache, potentially degrading performance if stack frames interleave?

> +			continue;
>  		}
> -build_id_valid:
> -		id_offs[i].offset =3D (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_sta=
rt;
> -		id_offs[i].status =3D BPF_STACK_BUILD_ID_VALID;
> +		offset =3D stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
> +		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
>  		prev_vma =3D vma;
>  		prev_build_id =3D id_offs[i].build_id;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525223948.1920=
986-1-ihor.solodrai@linux.dev?part=3D1
