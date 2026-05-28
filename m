Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65443B4EBD
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963153; cv=none; b=JXEY1qohBt4WIsYgj8FK6OTmGTrv4g+YiH2KV0RBLRtZIzsjPFgqB95AjhNghZNtnbHH1jsYsl/zKfehKGz2EoeJsIjVXAzSpdbEohcPZTiUjTS9VQFKVaOMO8y7s+GmmB8Mij7xVtBbSZg0yyYJWG5N/Uf8lBcRpcRzbBhWDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963153; c=relaxed/simple;
	bh=aISGlGCvfLQCxvb1ZZoFr4ovbZo9cu35Bv0RWzNWcp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXuxRIZ9FVyQTseH7EZzVxwDeM80eBZacKwk8DfJcLdd4a7zsLdlvvArbVN+67Z+UbIQHFPLFByV3BAQO92VBI0Kf4MFkFqP6H46KTd05XR59H2VBtTyP6hWqiogYizvpDqeGkWGQEd1c5ZYVKEBwL3TyVUQQbVu3tubLuYfcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoRLdwJ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoRLdwJ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDCC1F000E9;
	Thu, 28 May 2026 10:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963150;
	bh=RMOSmePRFO5Xcd33FCL6Tk2VBWwxx8u8OAMezq3Ucow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YoRLdwJ0DN3443P5PAr/+WrExtIPaeMzB66xuguBsqytzjpPJIbHujlJK6dygad0t
	 JYwI4Jm+eG2h0NeoDFKCtlP0ODn5Jz7Y5osQMTHEILe76nMgUVlbxHmFI0JNXtPK5z
	 EPBbMMYQo7FCe9qL7UfWnqIz7ZwSKwT09B5Qsc6Zn5V+Sa0ozORw7RokKfbVP/vgbx
	 kCU6Xt/4Cvu3CXWyALoWsWY2zWLGdp/jh1Zdau6T/169xmwAatTw75LQhP8QDcZztc
	 bZ7EkMTehT0jBJ631eaflNzFHqW9JvuEhU0SGFmG1XwMLQO5L1lSnTsVRJWGsWQAqn
	 Oa0yurHEzQGYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Hellwig" <hch@lst.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260528093437.2519248-2-hch@lst.de>
References: <20260528093437.2519248-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 10:12:29 +0000
Message-Id: <20260528101229.CDDCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] BUG CONFIRMED: MSM UNMAP ioctls fail with -ENOMEM due to 0-size bu=
lk allocation rejection.

Pre-existing issues:
- [High] BUG CONFIRMED: Kernel panic from kfree() on vmalloc pointer in bul=
k allocation error path.
--

commit 2defa6181f53f2235f7496349b8ea576d0868ab8
Author: Christoph Hellwig <hch@lst.de>

mm/slab: improve kmem_cache_alloc_bulk

This commit changes the return type of kmem_cache_alloc_bulk() from int
to bool. Callers are updated to check for boolean success or failure instead
of comparing the return value against the requested count.

> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_io=
mmu.c
> index 058c71c82cf54..533104d71f6ce 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -330,17 +330,15 @@ static int
>  msm_iommu_pagetable_prealloc_allocate(struct msm_mmu *mmu, struct msm_mm=
u_prealloc *p)
>  {
>  	struct kmem_cache *pt_cache =3D get_pt_cache(mmu);
> -	int ret;
> =20
>  	p->pages =3D kvmalloc_objs(*p->pages, p->count);
>  	if (!p->pages)
>  		return -ENOMEM;
> =20
> -	ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->count, p->pages);
> -	if (ret !=3D p->count) {
> +	if (!kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, p->count, p->pages)) {

[Severity: High]
If p->count is 0 (which can happen during UNMAP ioctls), kvmalloc_objs()=20
returns ZERO_SIZE_PTR, which passes the !p->pages check.

However, the updated kmem_cache_alloc_bulk() returns false when size is 0.
Previously, it returned 0, which matched p->count, allowing the function to=
=20
succeed. Now, a 0 count evaluates as a failure and incorrectly returns -ENO=
MEM.=20
Could this inadvertently break UNMAP ioctls by rejecting 0-size allocations?

>  		kfree(p->pages);

[Severity: High]
This is a pre-existing issue, but p->pages is allocated using kvmalloc_objs=
(),
which can fall back to vmalloc for large allocations.

If the allocation was fulfilled by vmalloc, doesn't calling kfree() on this=
=20
pointer cause a kernel panic? Should this be changed to kvfree() instead?

>  		p->pages =3D NULL;
> -		p->count =3D ret;
> +		p->count =3D 0;
>  		return -ENOMEM;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528093437.2519=
248-2-hch@lst.de?part=3D1
