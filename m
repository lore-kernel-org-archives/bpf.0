Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B393C4B7A
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866842; cv=none; b=RHhJPjrxOBJgaVde4EBYdu0Dl3eUjOLI+XjoK+DT7U0crI1I8Xr3thNzpmeg2U6+jCHza+OGjYcUEMt2szgzOyBZiLxrnq7nAHEcljtNvqRxf7vCG0l6XncMy2qZwO8CeHdqiCHPoearqWkBjgd+V8hALB0pa6ZwiB5cL808m2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866842; c=relaxed/simple;
	bh=jxry32N3qfZTWmofe3d4aeMYVKztIT/G8JGSIUjlfDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AlB+B3jjJ7u2jjOFYuN1Ra7Eq0KPbny667PfkJ1RjRBZU83H+aWd9bt8F4CymcLW9+bFqUod5fszyASjzn/g0tphtLFeHizessCQU+/GC4GQC9Llj7rtW1buTnQ8tr6wpZRvwoBaDuoCZTeSf2Sl14iEAiVjGf2MTtMqU5anX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGBvMy4I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGBvMy4I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A141F000E9;
	Wed, 27 May 2026 07:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779866838;
	bh=PAk2JZmvpxLvXiltUAVIkdvdQvZqrqshVJxxA0CMUHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGBvMy4I87nL3qPQN8j4NLb0zRDzxhXfQCC3yGW0dHy8jqxisOJpr7bhBcrM31Ei7
	 9PWHwlg+qmj0TYroxLnUEegj3MPV2Hze+1xUk3nuahFLkzV+oyuXeoOWJDryRcqfHJ
	 R/qOYtGrdaLBABNrSFcT6tctu2UNCgIjVcXNmAzSbaSasva8JW5HiRY87Zjzsr3M0f
	 AFnUdPOuEwQPiQqKPfiuzZxhzeNr//NiEtCcWPZxDj87xdoPqtoFsqH6YWSS+9uzT1
	 iZ8VrDvQNho34KcYBOh5Jk1p36vIUYyV7pR0Z8KdbCdkrQXsnfWDcW/6TZRZyehhN8
	 4hyPH6p5Puy0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Hellwig" <hch@lst.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527070239.2252948-2-hch@lst.de>
References: <20260527070239.2252948-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 07:27:17 +0000
Message-Id: <20260527072718.42A141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The patch fails to set the reserved page tables count upon a succe=
ssful bulk allocation in `panthor_vm_prepare_map_op_ctx()`, leaving it at 0.
- [High] `kmem_cache_alloc_bulk_noprof` incorrectly returns `false` (failur=
e) when requested to allocate 0 objects, causing false-positive allocation =
failures.
- [Medium] The patch removes the assignment to `num` in `do_kmem_cache_size=
_bulk()`, causing an uninitialized variable to be passed to `kmem_cache_fre=
e_bulk()`.
- [Low] The patch leaves an undeclared identifier `ret` in `do_kmem_cache_s=
ize()`, causing a build failure.
--

commit d2aac103779e2c77c7fc949b832a9d8ab2aaa90f
Author: Christoph Hellwig <hch@lst.de>

mm/slab: improve kmem_cache_alloc_bulk

This patch changes the return type of kmem_cache_alloc_bulk from an int
to a bool to clearly indicate whether the allocation succeeded or failed.
It updates the slab implementation, tests, and callers to match the new
behavior.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 75d98dad7b1dd..b80d7e1d51237 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1274,10 +1274,9 @@ static int panthor_vm_prepare_map_op_ctx(struct pa=
nthor_vm_op_ctx *op_ctx,
>  		goto err_cleanup;
>  	}
> =20
> -	ret =3D kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
> -				    op_ctx->rsvd_page_tables.pages);
> -	op_ctx->rsvd_page_tables.count =3D ret;
> -	if (ret !=3D pt_count) {
> +	if (!kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
> +			op_ctx->rsvd_page_tables.pages)) {
> +		op_ctx->rsvd_page_tables.count =3D 0;
>  		ret =3D -ENOMEM;
>  		goto err_cleanup;
>  	}

[Severity: High]
Does this omit setting op_ctx->rsvd_page_tables.count to pt_count on succes=
s?
Since op_ctx is initialized via memset previously, the count will remain 0,
which could lead to memory leaks when these page tables are consumed or
cleaned up later.

[ ... ]

> diff --git a/lib/test_meminit.c b/lib/test_meminit.c
> index d028a6552cd61..8f178fdf80ff1 100644
> --- a/lib/test_meminit.c
> +++ b/lib/test_meminit.c
> @@ -229,14 +229,12 @@ static int __init do_kmem_cache_size(size_t size, b=
ool want_ctor,
>  	for (iter =3D 0; iter < 10; iter++) {
>  		/* Do a test of bulk allocations */
>  		if (!want_rcu && !want_ctor) {
> -			int ret;
> -
> -			ret =3D kmem_cache_alloc_bulk(c, alloc_mask, BULK_SIZE, bulk_array);
> -			if (!ret) {
> +			if (!kmem_cache_alloc_bulk(c, alloc_mask, BULK_SIZE,
> +					bulk_array)) {
>  				fail =3D true;
>  			} else {
>  				int i;
> -				for (i =3D 0; i < ret; i++)
> +				for (i =3D 0; i < BULK_SIZE; i++)
>  					fail |=3D check_buf(bulk_array[i], size, want_ctor, want_rcu, want_=
zero);
>  				kmem_cache_free_bulk(c, ret, bulk_array);

[Severity: Low]
Will this cause a compilation error? The local variable ret is removed from
this scope, but it is still used in the kmem_cache_free_bulk() call above.

>  			}
> @@ -354,17 +352,18 @@ static int __init do_kmem_cache_size_bulk(int size,=
 int *total_failures)
> =20
>  	c =3D kmem_cache_create("test_cache", size, size, 0, NULL);
>  	for (iter =3D 0; (iter < maxiter) && !fail; iter++) {
> -		num =3D kmem_cache_alloc_bulk(c, GFP_KERNEL, ARRAY_SIZE(objects),
> -					    objects);
> -		for (i =3D 0; i < num; i++) {
> +		if (!kmem_cache_alloc_bulk(c, GFP_KERNEL, ARRAY_SIZE(objects),
> +				objects))
> +			continue;
> +
> +		for (i =3D 0; i < ARRAY_SIZE(objects); i++) {
>  			bytes =3D count_nonzero_bytes(objects[i], size);
>  			if (bytes)
>  				fail =3D true;
>  			fill_with_garbage(objects[i], size);
>  		}
> =20
> -		if (num)
> -			kmem_cache_free_bulk(c, num, objects);
> +		kmem_cache_free_bulk(c, num, objects);

[Severity: Medium]
Is num uninitialized here? It's no longer assigned the result of the
allocation call, so passing it to kmem_cache_free_bulk() might use
indeterminate stack data and lead to memory corruption.

>  	}
>  	kmem_cache_destroy(c);
>  	*total_failures +=3D fail;

[ ... ]

> diff --git a/mm/slub.c b/mm/slub.c
> index a2bf3756ca7d0..d9790e7c17f6c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7382,12 +7392,8 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache=
 *s, gfp_t flags, size_t size,
> -int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size=
_t size,
> -				 void **p)
> +bool kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags,
> +		size_t size, void **p)
>  {
>  	unsigned int i =3D 0;
>  	void *kfence_obj;
> =20
>  	if (!size)
> -		return 0;
> +		return false;

[Severity: High]
Does this incorrectly report an allocation failure when size is 0?
Previously, callers interpreting the return value against size (ret !=3D si=
ze)
would treat 0 objects allocated for a request of 0 as a success. Returning
false here contradicts the typical kernel behavior where allocating 0 items
is a successful no-op, and might cause callers to incorrectly abort with
an error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527070239.2252=
948-2-hch@lst.de?part=3D1
