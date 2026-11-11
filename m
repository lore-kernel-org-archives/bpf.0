Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392563;
	b=dwk0yR/osFtLPwlQtwFfzRR/3JFnYqbL2L9ki1LoSi/uhVwdpih8HlGP2WI9SA0rB5+L
	 1cO5pY9OX8yvEm2tElvZOqWEtXzFVq45kSmHoom8A+FcXHGBnGT/s/eSjh8NgRwngvSVP
	 FcN9Z3GIseD1DsFLi0S5WDo60yDBWeYsHqUJ0OLFukIN7mFXNVjgWbZBZkaIySQua8OTg
	 jW3Q9Oie57j9A2VwgSPx3+wl8zUZwnfQEJRxHEWFu5cRAWPwbfhwmYZzsD/bNs0/Jfik6
	 oGSbK4rUtfr0uSKb9SuwffowScYkkenR9LMDgUC788CUpK2tzEOk/w/+gxre5TD/dQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RCUU66Cu0GcIjUSzvw2yMjgj5vNlmPqOHxDnEeoMLK4=;
	b=aRkS7POFWyWEEA/pxrVsUUk8I48O6s7nfSiZb0DpfXTaUX9ruHSazp2aeSmqvmO1OH6x
	 ynWBkVKKUqy09c7VTI5bLF+nVjQvY8tjaJ0jP9+zpoBwlBWW5xaYrdyoVknjKoz0pLLNq
	 c9MRvLLAIbbKJ2sB7QXsP6i1qu4hNmoQFXNocyf6+gl5PahjmkWkufIYdmVYK1Pog9E8y
	 i+ZTV5LZWjAhJKdAiZiU33kSOipJ4Y4SwI3+S2gPUi5nqziHl116/QN7I5XECHkJcT7I2
	 kP2OMVkEbui6go6rVv/OVdhNEOr/UIr7cA3JbaO+e//vPcN9W50pTrNo6/BvPoIZviw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJgYo8Ql;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCFE606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DJgYo8Ql
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7B01F00A05;
	Wed, 11 Nov 2026 10:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392563;
	bh=RCUU66Cu0GcIjUSzvw2yMjgj5vNlmPqOHxDnEeoMLK4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DJgYo8QldxxAPh4hQfgjgd6KcD4fLC7E8gPCAKDx2rlPEGWERt4oDjLwl7+7t03+e
	 bfKus1EIFS/Vg0y3FVhOA4g++RJbcjJxYnzAtOk7M3mERqZHEV7XL3xWxqpd5n6i+2
	 7YUbyb7byEN+5e8sN+7oN17GvwsFhVhvyvnuGO00dDK0QQ/64cj9tBdjy0s7NYq6e9
	 my00XZm6xgq1EpF9aAtFlwTC8cJQESMn1dkMSFDBpbYUkM45M+7PggMsJw7GjWnrte
	 edYSBdGDRpoDzavgSg+qM2k1IPE1PqP0GA9UYGVCSV3egF9o+yUOBCOv2WJp72yED1
	 62eRcYmAXGNmw==
Message-ID: <sashiko-outbox-208785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 02/11] net: Add memory provider capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261110102039.1002605-3-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-3-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:22:43 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] xsk: dangling driver pool pointer in xp_assign_dev() [1]
--

commit c73a20cf1440e29e283d9ab9dca3cd14c95d4e33
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

net: Add memory provider capabilities

This commit adds MP_CAP_READABLE and MP_CAP_FRAG capability flags to
describe memory providers and introduces PP_FLAG_MEM_PROVIDER so page
pools can explicitly opt into using readable memory providers.

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 7750d2ec4ee24..18966bbdb5b73 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
[ ... ]
> @@ -241,7 +242,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>  		goto err_unreg_pool;
>  	}
> =20
> -	if (dev_get_min_mp_channel_count(netdev)) {
> +	if (!netif_all_mps_have_cap(netdev, MP_CAP_READABLE)) {
>  		err =3D -EBUSY;
>  		goto err_unreg_pool;
>  	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can the err_unreg_xsk
cleanup path in xp_assign_dev() leave a dangling pool pointer in the
driver [1]?

Just below this hunk, if ndo_bpf() succeeds for XDP_SETUP_XSK_POOL but
leaves pool->dma_pages NULL, xp_assign_dev() jumps to err_unreg_xsk to
call xp_disable_drv_zc(pool) before pool->umem->zc is set:

net/xdp/xsk_buff_pool.c:xp_assign_dev() {
	...
	err =3D netdev->netdev_ops->ndo_bpf(netdev, &bpf);
	if (err)
		goto err_unreg_pool;

	if (!pool->dma_pages) {
		WARN(1, "Driver did not DMA map zero-copy buffers");
		err =3D -EINVAL;
		goto err_unreg_xsk;
	}
	pool->umem->zc =3D true;
	...
err_unreg_xsk:
	xp_disable_drv_zc(pool);
}

Because xp_disable_drv_zc() only calls ndo_bpf() with a NULL pool when
pool->umem->zc is true, it returns without unregistering the pool from the
driver, which can lead to a use-after-free when the pool is freed.

[1] https://sashiko.dev/#/bug/linux-ebfe949d-701b-490d-90a5-2d87285eb1c1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110102039.1002=
605-1-bjorn@kernel.org?part=3D2
