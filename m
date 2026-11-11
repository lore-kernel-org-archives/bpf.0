Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392565;
	b=gUNcm2qq0y7Dx5sL4RKJsIkATSpwh950ZGlkKC3QHMHqpaufbC06gE6eh9bYybRiOgvi
	 7tFQaK0mTHb74GpTQB54YnKeVF/GynTOKjTigDtczONVn1kZ+zcsYEkb0gJaqWpqA0dvc
	 YDkQyVbU3Hqwh0CcvN3xcYVT3+zdKj22xWofKaRfuZNsglm+WLMa9Vx8rK1Y7mcX/i/Ag
	 l6Xq7vneeEMTefAaPTYyfMKry8a+PDr4ely89JrunFS0pKHjYy74/zwcwUZ2IvIfGhAfI
	 Hw8BK88Yyyehqhqk+m6as+GIwrhPKXZGLiLQMqAP6ediYSzDVxJgGHEnSMo0YdU3PpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4qsyGDZo3gvXq56qH0wu6282UMwZaH/flMaAVe2LFMM=;
	b=ZW+QQPUt5y02aPqByAkkSq8WDB/bKBPTDv8OEiagiyIGGjf9D2dXQ7ADMF6gc9pV79me
	 O3S7jz148uI35t589Hw/kv/dr+iR7ZFDH3xD5PKybf/02ZD6IUfEIFulIJBe0Gf8Zekt4
	 dz32nov2gKMQIL8e/GliQF6XjKbHxPkqz3PstUL5ytTaYf5UcW2ZOP4/2cKpRDLcvsytq
	 FBfJKMJMu7fXt55VSZmiZxqFPxS2WOBjgc+4kHbVB4jkpDJpt8dLlRtIY+itUtt0xnMyC
	 Hc9ZyuChyQhJmO3ONQxqqsSnqgo/YIo4BzlxINYErtff1bUoJy6K21/HNItU8WXzOdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiWUSzv3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A160606A32E
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiWUSzv3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D625D1F00A06;
	Wed, 11 Nov 2026 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392565;
	bh=4qsyGDZo3gvXq56qH0wu6282UMwZaH/flMaAVe2LFMM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OiWUSzv3gdd8xoG70dfcmICBOGLv4jnKhJ1Js9EE5qDmi/mMqwauIWXOezS646FXo
	 rV4b1sh8IwRNjTgJI4a95wd6JovvCTd697PtWTSJIRwuhX9YCqjBWG5HT76KXMIAc4
	 yNyLR3laXObmn+k0/frlnJ3J28kaIyJnebcgq6d0YDNj7rfkjF5noyqkpdp9xe9RWC
	 5Wxcw9evdItw74jiZGXIRR5PGj95/JWkdO7NDRehgWDCxbmCroWS31uipracNnSOkg
	 7Nh48vutHM8eFKrlzEyCkwTCttCh4GK1hyilTLk484rL9rSgkrm54UqTyUS7YX44B/
	 JnjwKvCsHTNDQ==
Message-ID: <sashiko-outbox-208788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261110102039.1002605-6-bjorn@kernel.org>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:22:44 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] xsk: UAF of pool and UMEM on xsk_pp_bind() failure with active
  page_pool
- [High] xsk: unconditional DMA unmap and UMEM release in
  xsk_pp_unbind()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] net: null pointer dereference in __netdev_queue_config()
  [1]
--

commit 34e15c1f4828114e9aaedcfa55376bd7c379c9a3
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

xsk: Install UMEM page pool providers in the core

This commit installs AF_XDP UMEM memory providers through the netdev RX
queue API for drivers setting netdev_queue_mgmt_ops.xsk_page_pool, and
defers allocating pool->heads to copy mode and driver zero-copy.

> diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
> index 1975de42a60d9..97e33764737bd 100644
> --- a/net/core/netdev_config.c
> +++ b/net/core/netdev_config.c
> @@ -88,6 +88,8 @@ static int __netdev_queue_config(struct net_device *dev=
, int rxq_idx,
>  	mpp =3D &__netif_get_rx_queue(dev, rxq_idx)->mp_params;
>  	if (mpp->rx_page_size)
>  		qcfg->rx_page_size =3D mpp->rx_page_size;
> +	if (mpp->rx_headroom)
> +		qcfg->rx_headroom =3D mpp->rx_headroom;
>  	err =3D validate_cb(dev, qcfg, extack);
>  	if (err)
>  		return err;

[Severity: Critical]
This problem wasn't introduced by this patch, but can __netdev_queue_config=
()
dereference a NULL dev->queue_mgmt_ops pointer [1] when called on a
device without queue management ops?

Earlier in __netdev_queue_config(), dev->queue_mgmt_ops is dereferenced
without a NULL check:

net/core/netdev_config.c:__netdev_queue_config() {
	...
	validate_cb =3D netdev_nop_validate_qcfg;
	if (validate && dev->queue_mgmt_ops->ndo_validate_qcfg)
		validate_cb =3D dev->queue_mgmt_ops->ndo_validate_qcfg;

	memset(qcfg, 0, sizeof(*qcfg));

	/* Get defaults from the driver, in case user config not set */
	if (dev->queue_mgmt_ops->ndo_default_qcfg)
		dev->queue_mgmt_ops->ndo_default_qcfg(dev, qcfg);
	...
}

Calling netdev_queue_config() or netdev_queue_config_validate() on a device
where dev->queue_mgmt_ops is NULL will panic.

> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> index fdd55265a6cdc..c2214e718cdb3 100644
> --- a/net/xdp/xsk_pp.c
> +++ b/net/xdp/xsk_pp.c

[ ... ]

> +	mp.mp_priv =3D pp;
> +	mp.rx_page_size =3D pool->chunk_size;
> +	mp.rx_headroom =3D xsk_pool_get_headroom(pool);
> +	err =3D netif_mp_open_rxq(dev, queue_id, &mp, NULL);
> +	if (!err) {
> +		pp->rxq =3D __netif_get_rx_queue(dev, queue_id);
> +		pool->pp =3D pp;
> +		pool->xdp_zc_max_segs =3D dev->xdp_zc_max_segs;
> +		return 0;
> +	}
> +
> +	xp_dma_unmap(pool, XSK_PP_DMA_ATTR);
> +	/* Copy mode takes the chunks that the provider holds */
> +	if (!xp_alloc_heads(pool) && xsk_pp_abandon(pp))
> +		xsk_pp_put(pp);
> +	else
> +		pool->pp =3D pp;
> +
> +	return err;
> +}

[Severity: High]
If netif_mp_open_rxq() fails after ndo_queue_mem_alloc() has created a
page_pool that attached to pp, can this error path cause a use-after-free of
pool and UMEM?

When page_pool_destroy() defers destruction because chunks are still held
(pp->nr_pools > 0), or when xp_alloc_heads(pool) fails:

1. xp_dma_unmap() runs unconditionally before xsk_pp_abandon(), unmapping
   DMA pages while the lingering page_pool still owns chunks.
2. xsk_pp_bind() sets pool->pp =3D pp without clearing pp->fq, and
   xp_assign_dev() skips the copy-mode fallback because pool->pp is set,
   returning err to xsk_bind().
3. xsk_bind() calls xp_destroy(xs->pool), which drops only pool's reference
   on pp via xsk_pp_put(pool->pp) and immediately kvfree()s pool:

net/xdp/xsk.c:xsk_bind() {
	...
		err =3D xp_assign_dev(xs->pool, dev, qid, flags);
		if (err) {
			xp_destroy(xs->pool);
			xs->pool =3D NULL;
			goto out_unlock;
		}
	...
}

The lingering page_pool still holds its reference to pp, leaving pp->pool
dangling (dereferenced in xsk_pp_alloc_fill() and xsk_pp_refill_done()) and
pp->fq pointing to xs->fq_tmp. Because xs->pool is now NULL and xs->state
remains XSK_READY, closing the socket frees xs->fq_tmp and calls
xdp_put_umem(xs->umem, true), which vunmaps umem->addrs and unpins umem->pgs
while the page_pool still holds chunks.

> +/* Called with RTNL and the instance lock of the device */
> +void xsk_pp_unbind(struct xsk_buff_pool *pool)
> +{
> +	struct xsk_pp *pp =3D pool->pp;
> +	struct pp_memory_provider_params mp =3D {
> +		.mp_ops =3D &xsk_pp_ops,
> +		.mp_priv =3D pp,
> +	};
> +
> +	/* Unregister removed the provider already */
> +	if (!pp->rxq)
> +		return;
> +
> +	netif_mp_close_rxq(pool->netdev, pool->queue_id, &mp);
> +	xsk_pp_detach(pp);
> +}

[Severity: High]
Can xsk_pp_unbind() and xp_release_deferred() unmap DMA and free the pool
and UMEM while the RX queue or page_pool is still using them?

xsk_pp_unbind() ignores the return value of netif_mp_close_rxq() and
unconditionally calls xsk_pp_detach(pp) -> xp_dma_unmap(). If
netif_mp_close_rxq() fails (for example, -ENOMEM when allocating replacement
queue memory in netdev_rx_queue_reconfig()), the hardware RX queue remains
active on the unmapped UMEM pages.

Furthermore, right after xp_clear_dev() returns in xp_release_deferred(),
xdp_put_umem(pool->umem, false) unpins and vunmaps the UMEM and
xp_destroy(pool) frees pool, even if netif_mp_close_rxq() failed or
page_pool_destroy() deferred releasing in-flight netmems (pp->refs > 0).

[1] https://sashiko.dev/#/bug/linux-47dd1618-68d7-4419-9441-df54e8f32d4d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110102039.1002=
605-1-bjorn@kernel.org?part=3D5
