Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19C392C25
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790467004; cv=none; b=MdRoD79siGvr8fbgHV/UWRF3NbcAj2zwlgeBGbWIExz/FuJ94aoWIirIprpMgEFTsVb/ukuEzc3HcgVnjKqLrZP/VODnby6oSGkZeeln8jpmxcLpSg8M+VukfpYJGWbHLVhGtxPTl4d/WSV9MIa7PFhUjjS3xU/dheKr747dA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790467004; c=relaxed/simple;
	bh=Tt6c/VIw+XAAWXNoPwh8aOEAEFFBPOn01t/Y+pFFVGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WGV5pi2qNKFuMDgO0EOwd5U1oWTE9CiACUb9VZkVNJqvS1LPXApcKQbytopmwgj+SloS0W1hL8bHi/u6N8Fn4yIw6dXtMFmyR01LSrCajUtiVyXgSZ5GBRNx4nmcfgMH1EGJWtENc/zGXfncmM2SCiLVORAKkc8vY4z5qWzDjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/34edd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/34edd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8411F000FF;
	Sat, 26 Sep 2026 23:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790467002;
	bh=Ebqn4OS0nXa7Vyu+V4FVZmS3SJnoc5toUse5ew4wTuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/34edd6wIvK9lKV8Nla6foLvXmh5vuuUcynr7kv3dEfVrkuUKHt2T2LDFa3c3L3W
	 /oOGqju0CPFFh9xW246/btk02XWTNqoWxFFfXIu4PK9s9ygs72uhhspn6TKlsa2KcX
	 +5rrBhQteGRadEVUcRaOoyVRqejez4mrQa4ZXKXATz0Qa0yFl/e5kMjhXUdkIUN6Eo
	 34FqBNkxr7URHbIAePhnubXl0G3Xt2mKEOYLsGa+3hYWJjoN7teJGtRv6LF+8bmejz
	 3A2iD0yoUua78GM7NgkMyaAnPbkNlFs2ci8mDMwvOhhcxUCnkKir6JMfzj+3vC3xNc
	 BzSby3xcw8s8Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 03/16] bpf: Back typed arena chunks with
 scratch on demand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260926233503.3114147-4-memxor@gmail.com>
References: <20260926233503.3114147-1-memxor@gmail.com>
 <20260926233503.3114147-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 23:56:42 +0000
Message-Id: <20260926235642.9D8411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: Use-After-Free due to missing PTE cleanup in typed_arena_=
teardown_cb()
--

commit 5ad8213f9e65607de0b6ea3647cc93fae67f349a
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Back typed arena chunks with scratch on demand

This patch introduces demand-paging for typed BPF arenas, where unbacked
pages fault and are populated with scratch memory. It handles the fault
recovery, marks chunks in a bitmap, and adds allocation and freeing
mechanisms for these chunks during the map's lifecycle.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 9cd1b1ce434c4..c757c19323602 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -371,7 +396,7 @@ static int typed_arena_teardown_cb(pte_t *ptep, unsig=
ned long addr, void *data)
> =20
>  	if ((addr - (unsigned long)ta->base) & (bpf_typed_arena_chunk(ta) - 1))
>  		return 0;
> -	if (!pte_present(pte))
> +	if (!pte_present(pte) || pte_page(pte) =3D=3D typed_arena_scratch_page(=
ta, addr))
>  		return 0;
>  	typed_arena_free_objects(ta, (void *)addr);
>  	__free_pages(pte_page(pte), typed_arena_chunk_order(ta));

[Severity: Critical]
Does this leave the kernel leaf PTEs pointing to freed memory?

This callback frees the physical pages for allocated chunks using
__free_pages(), but it doesn't appear to clear the PTEs using pte_clear()
or ptep_get_and_clear().

If a typed arena is destroyed (for example, if a BPF program load fails
after allocation), bpf_typed_arena_put() calls typed_arena_free(), which
then uses this callback. The underlying memory is freed, but the page
tables remain populated with valid mappings.

Because typed_arena_find_slice() searches for and reuses freed address
gaps, a subsequently loaded BPF program could allocate an arena of the
same size, inherit the same virtual address slice, and access these stale
PTEs to manipulate the freed memory.

> @@ -383,6 +408,10 @@ static void typed_arena_free(struct bpf_arena *arena=
, struct bpf_typed_arena *ta
>  	WRITE_ONCE(arena->typed_arena_mem, arena->typed_arena_mem - typed_arena=
_static_mem(ta));
>  	apply_to_existing_page_range(&init_mm, (unsigned long)ta->base, bpf_typ=
ed_arena_size(ta),
>  				     typed_arena_teardown_cb, ta);
> +	/* Programs may have stored kptrs into the dummy objects. */
> +	typed_arena_free_objects(ta, ta->scratch);
> +	vfree(ta->scratch);

[Severity: Critical]
Could this similarly leave stale mappings to freed scratch space?

The scratch pages are freed via vfree(), but the aliased PTEs within the
arena's kernel VM area that point to these scratch pages are never cleared
during the teardown process.

> +	kfree(ta->scratch_pages);
>  	bitmap_free(ta->chunks);
>  	bitmap_free(ta->pending);
>  	btf_put(ta->btf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926233503.3114=
147-1-memxor@gmail.com?part=3D3
