Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C911175A74
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987923; cv=none; b=cHp4UtXu0ii9YFYWuxwtpBWdKONxmJ4Gf1EdgxhxcQC+B+UyEdiAOPV+FtEsk5hK8IB+s2cZ63sJ9cHJY9b8TejEfGeBBbtvVh/n040R/Yg4LNaIDrr4A3qkMSQ2oNBhYEinzmVYTBNfs3WkMKQ3s5mwh+631LBaE6MsSJn6/tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987923; c=relaxed/simple;
	bh=0nRWS/irgIJqOzmAX/HcnUp5jo4t5nRRTB+hut+GW7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QZs0G9klkQJNnOZcszLFpY/QKf4s3ziLJpP4LS8AxhYA9d2ZrdF068TtI14SISYcTHw3UrnIYA+FL4ZxMcFYTG1ILJ5w1LA+f5xJvDa81uUOhU2fwxZiWoFpb7fuOaXDGL79ilJeY1YEtNVI0P0jyqSn7AdrITV2eLPQ0aDIhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnFJ7C+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnFJ7C+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7D61F000E9;
	Mon, 17 Aug 2026 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786987921;
	bh=Rgz5IJza+L9F6wQs4yyzWZI3Tcp/Bq/LPrRNfIJLonk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnFJ7C+mu7y85ebYaCxzARuZKUA1+nKN8qvdmFVF4D4JwGLKJiXj8s8DSi9PxkiAL
	 bKQqwXQpBKRorxhDRfwPEKJYrln3c0woa//YV768QBrVx5tUbyjHr+RYbyBqmqf6Ky
	 rN5+3BQzUn2+udftAQ/3YIxOdjyZ1dTKxgZaEh/DrnTjqTt8ZplpLhC2wzGA0E4YX4
	 GCT8Mu8/VjYuQuN0tczOJXQoDG02K9W7hig60MwrmbAMHgzY4d0UUYK6QJNDlS/QVw
	 iVdGGsXLZ5HMgvRjBmpsL4yR0fMNIW5TE6H5IuRRdUH1R4J+tTRvRF5obj12QyOQsK
	 rbsHSVw3dXMuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] bpf/syscall: Route generic_map_update_batch
 key/value allocations to folio_scratchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org
In-Reply-To: <20260817-folio-pool-v1-v1-5-0c1d230aa3af@gmail.com>
References: <20260817-folio-pool-v1-v1-0-0c1d230aa3af@gmail.com>
 <20260817-folio-pool-v1-v1-5-0c1d230aa3af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 17:32:01 +0000
Message-Id: <20260817173201.9E7D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Batch map updates fail with -ENOMEM for maps with keys or valu=
es larger than ~4072 bytes due to order=3D0 chunk limits.
- [High] Missing folio_scratchpad_free on the key allocation error path cau=
ses a permanent kernel memory leak when map->key_size exceeds the chunk cap=
acity.
- [Low] Incompatible pointer type passed to folio_scratchpad_init_key cause=
s a compiler warning.
--

--- Patch [5]: [PATCH 5/9] bpf/syscall: Route generic_map_update_batch key/=
value allocations to folio_scratchpad ---
commit d64109fbe5280b8aca05d025f4ea39aceb7430e9
Author: Jim Cromie <jim.cromie@gmail.com>

bpf/syscall: Route generic_map_update_batch key/value allocations to folio_=
scratchpad

Use struct folio_scratchpad to allocate transient key and value buffers
during map update batch operations, bypassing SLUB cache churn.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b479..8ef48673b9339 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -2083,13 +2087,17 @@ int generic_map_update_batch(struct bpf_map *map,=
 struct file *map_file,
>  	if (put_user(0, &uattr->batch.count))
>  		return -EFAULT;
> =20
> -	key =3D kvmalloc(map->key_size, GFP_USER | __GFP_NOWARN);
> +	folio_scratchpad_init_key(&batch_sp, 0, &bpf_batch_scratchpad_key);

[Severity: Critical]
Does this restrict the size of map elements, causing failures for large
elements?

By passing 0 for the chunk order in folio_scratchpad_init_key(), the
allocation limit is now restricted to a single page. Before this change, the
code used kvmalloc() which supported much larger sizes.

Since folio_scratchpad_alloc() returns NULL if the requested size exceeds t=
he
remaining space in a single page:

lib/folio_pool.c:folio_scratchpad_alloc() {
    ...
    if (sp->remaining < aligned_size) {
        spin_unlock_irqrestore(&sp->lock, flags);
        return NULL;
    }
}

Will this cause legitimate bpf batch map updates with large keys or values =
to
unconditionally fail with -ENOMEM?

[Severity: Low]
Are we passing an incompatible pointer type here?

The variable bpf_batch_scratchpad_key is defined as struct static_key_true
via DEFINE_STATIC_KEY_TRUE, but folio_scratchpad_init_key() expects a
struct static_key *. Passing it directly might trigger strict aliasing
warnings and break builds.

> +
> +	key =3D folio_scratchpad_alloc(&batch_sp, map->key_size,
> +				     sizeof(void *), GFP_USER | __GFP_NOWARN);
>  	if (!key)
>  		return -ENOMEM;

[Severity: High]
Could this lead to a memory leak if the key allocation fails?

If map->key_size exceeds the capacity of the order-0 chunk,
folio_scratchpad_alloc() allocates a new folio and adds it to the chunks
list, but still returns NULL because the chunk is too small:

lib/folio_pool.c:folio_scratchpad_alloc() {
    ...
    list_add(&chunk->link, &sp->chunks);
    ...
    if (sp->remaining < aligned_size) {
        spin_unlock_irqrestore(&sp->lock, flags);
        return NULL;
    }
}

Returning -ENOMEM here in generic_map_update_batch() without calling
folio_scratchpad_free() leaves the newly allocated folio on the
sp->chunks list, leaking the memory.

> =20
> -	value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> +	value =3D folio_scratchpad_alloc(&batch_sp, value_size,
> +				       sizeof(void *), GFP_USER | __GFP_NOWARN);
>  	if (!value) {
> -		kvfree(key);
> +		folio_scratchpad_free(&batch_sp);
>  		return -ENOMEM;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-folio-pool=
-v1-v1-0-0c1d230aa3af@gmail.com?part=3D5
