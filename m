Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794372217;
	b=Jyn4CUcN7SEIoFOn1YszJHz1ZmUdCoL5osnJdSrrZ6efIC7/sfCmt/hGS15Klj1Kdz34
	 DERojgX9mt6LMTZ4Hv0p0oldzXLu6eZ9lFLWWGVBsT9b5xe0208hwR3D80dmMdeAihBdq
	 ry70Xy+YZvNpm+cc6/4cpHWXT5lFs140rocHiUtI8HdLMK1Vyeo4+8Hdkcjyjqc2MIkCc
	 xG+I2hCzfcJFR4Edy3kQVBwDS0jTthKCG7mm2RFKJgZq9xuyQkZW+50BzHQObljKNs+dw
	 0zTEa3JZ0gpdfaCTemCNrJ7Z/XZ+kxPdK9VLdZDuuG1qMeOdyGZp0WRuyfpy+PSJguA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794372217;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S1ATAwbS1D3bXe8l+T0xSIWcj4FrooGqsJE6ERXhb9w=;
	b=RsUAm3ITHc3kEdSa2FpiYtnGfxrX8wGeCiDB7CCFDez28fWihKMd6sPWvqbbsYkjd4iu
	 rx9OTh6DolZg1cY8fTR1848IJ4fp37m8flm7gUxrofl7GCJMzUDx9nFombWqEFotAWVAR
	 tYvjJ3Jl8oRqEoOOT9JGxO1HkGGmSjYFq43UuQofGVtzam8+Rdikx0hlq719Gn9pSrVq/
	 CrmlYdxXWpMKWu3YZm5wwN2eOWNSfuQaL3tyqgCQwjLygKVr/TPf/8NURfJZA2dYK/PwY
	 4ZQKVGCt81K3llZcpxtOzPrEvxkPR5lxWy6T8rpmdKEKpCXWWJsR9kGiSrbOmvWH79Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9XcQMzx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6D606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9XcQMzx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C894B1F0089F;
	Wed, 11 Nov 2026 04:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794372217;
	bh=S1ATAwbS1D3bXe8l+T0xSIWcj4FrooGqsJE6ERXhb9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9XcQMzxqLTytSXJDtS9I1YDzIU4MWTsqc1qdwSbgloiBI9z6I5KpwKS9o5Vg3O/A
	 G9q7iiJFz7KxzmmataQyugy0uEFdSrhnfXOb2zWQXOxpf8aay5CpyKIvv6+tqa76rX
	 rxowyF8KZdGjOMnbhYwTVcOHE/xJOtnzMQ6Z2NESd9o1/x/ntu1aY/XhGe/wHsSdQF
	 AdQUAV4sdFqHyR8WKwUEiBewqVY4IfOAijTJHDZu03j8LwIKhIidsWVuDvaf2r9T9T
	 jxK7RFl3m8w6H3uN90kxMONWwBf7Zq63ca1vMdopBiZOpx5RYd4XsFmkflh2Qv89fo
	 uBdD2x7auuJdw==
Message-ID: <sashiko-outbox-208308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Check async callback value
 membership in the setter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261111024333.228633-6-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
 <20261111024333.228633-6-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:43:36 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: missing map usercnt check in __bpf_async_set_callback()
--

commit a30152ffd79aa0871058c367266aaec41f12d33b
Author: Yun Lu <luyun@kylinos.cn>

bpf: Check async callback value membership in the setter

This commit checks map element membership in __bpf_async_set_callback() so
that timers and workqueues initialized on deleted map elements cannot have a
callback installed and started.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 716be7a852b58..9fa75bcd5e77f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1552,11 +1552,25 @@ static int __bpf_async_set_callback(struct bpf_as=
ync_kern *async, void *callback
>  				    struct bpf_prog *prog)
>  {
>  	struct bpf_async_cb *cb;
> +	struct bpf_map *map;
> =20
>  	cb =3D READ_ONCE(async->cb);
>  	if (!cb)
>  		return -EINVAL;
> =20
> +	/*
> +	 * The prog can still hold a value of an element that was deleted from =
the map.
> +	 * bpf_async_cancel_and_free() is done with it and nothing stops a new =
callback
> +	 * when the element is freed. cb is published at this point: either the=
 lookup
> +	 * doesn't find the element or bpf_async_cancel_and_free() finds cb.
> +	 * Nothing runs without callback_fn. An idle cb stays in the element un=
til the
> +	 * element is reused or freed.
> +	 */
> +	smp_mb();
> +	map =3D READ_ONCE(cb->map);
> +	if (!map || !bpf_map_value_is_linked(map, cb->value))
> +		return -ENOENT;
> +
>  	return bpf_async_update_prog_callback(cb, prog, callback_fn);
>  }

[Severity: High]
Does __bpf_async_set_callback() also need to check atomic64_read(&map->user=
cnt)
and return -EPERM when it is zero?

Because __bpf_async_init() leaves an idle cb attached to an unlinked element
in a non-preallocated hash or rhash map's bpf_mem_alloc cache while
map->usercnt > 0, a subsequent bpf_map_put_uref() only walks linked elements
in htab_free_malloced_internal_structs() / rhtab_map_free_internal_structs()
and never clears that unlinked element's cb.

If a loaded BPF program then recycles that element back into the map via
bpf_map_update_elem() after map->usercnt has reached 0, copy_map_value()
preserves the timer/wq field and bpf_map_value_is_linked() succeeds here.
Installing cb->prog after map_release_uref() has already run pins the BPF
program and map in a permanent reference cycle, or allows a callback on an
inner map to race with non-synchronous cancellation in htab_map_free() /
rhtab_map_free() and use the freed map and element after they are kfreed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111024333.2286=
33-1-luyun_611@163.com?part=3D5
