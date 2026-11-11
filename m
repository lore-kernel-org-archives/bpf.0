Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436893;
	b=KmGM8Cf5qO9YYgbmNVXJQtGRU26N4m5CntBmyMhfsKbDA5tq24oWl24vqAxNPoHTBYrW
	 TMPURkL8bvAmI68dWZPKyUDhsEVvwGyifen/7FVV7rtWQpJJwNiYKvFPaU4rzEq9aAD/B
	 c4XRuNcdatzuE3dVdikBKZ2roSn6LAWQTUvABq6eiDhI8DqCjKXkUCFtxgtTGQtX/ApgH
	 kYg3MVKpGmLlfK23xUcxp1r5bFjn4Aq333ficxdY6302nTzL0ciA6OqlMMWbHhOIn6LY9
	 f88DOe7MZ/hBeXCVi+O3gUcZYyziM0GmyuSyHXiFhzWzf+yopjgB1TebC7zjJe5pvJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436893;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LJTjahJn9zqRgvX/Ycs7FoWVCdUbyMhl+gR6xg88ieg=;
	b=rWEGtapARiVa0KB/F0HYGpCXe4QLdeWxKA+LFmpLlDKPbH85nNGLxC5WBZ+6wtle4J3I
	 f8EL09GN2W5N7ItMDNZiRyQTdQvAK/4Ndf2nB3u6DzCGU2VlfVrP5LhFIEHa7prVpidQ8
	 dJvutCHSnJLJYCKtLUeWGht/LX8Hs3bMvrf/PDbDzBc0rlxeoAHaL2FtBhDpUglaxAakS
	 Hadf4G4UXbacZBBFzeiGfZ6mvXDaPzP/m1RMe5ZNb+uLZVbt7VWMKBXykpb6Qb2dWDcoj
	 jpTXGFDGUTmSz7M/zEkk3UmT9y3PoLP+7FrP2gYDiztW5o4OqMkAjLBumWdPp3mFepA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHmZ6QH8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBDD606A897;
	Wed, 11 Nov 2026 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHmZ6QH8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B951F00A05;
	Wed, 11 Nov 2026 22:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436893;
	bh=LJTjahJn9zqRgvX/Ycs7FoWVCdUbyMhl+gR6xg88ieg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fHmZ6QH8gByQ5fCq+QnGg1Vbe5YTTV1WjH0OiCiEUmqkwlLV91/pbPG4I/xVl8nxX
	 6VMJA3UN8VxnPufPg/IOQ3970NUGJBQ9LmO8l6yVjV2UDE9+/nXtLZjHn9vy25j2xv
	 HxhAg1SD5fHs7+UEMb+fEDGHvfSy/WVmC+OxM8l9kwOcyi7RqM48MH65qHWGHhgLWb
	 hcWwNrf1u5Qv9yXxc0XYi/fuYCKuETo0LYuzJ0qC3oxpbz3M47c16t83oUXHyHBfxd
	 stnG1EAXlLirrc/0Bv1pqDLP3yYm9HAgz7WdyGDy3CfqKgAfzu3El3pn6Bb7wDVC96
	 Eu7MFq2NkvQRg==
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, alexanderduyck@fb.com, kernel-team@meta.com,
 andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
 ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 asml.silence@gmail.com, axboe@kernel.dk, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org,
 io-uring@vger.kernel.org, almasrymina@google.com, mike.marciniszyn@gmail.com,
 bestswngs@gmail.com, razor@blackwall.org, dw@davidwei.uk,
 aleksander.lobakin@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stuclar@meta.com
Date: Wed, 11 Nov 2026 22:41:30 +0000
Message-ID: <179443689029.2199510.2604170089798059237@kernel.org>
In-Reply-To: <20261110102039.1002605-6-bjorn@kernel.org>
References: <20261110102039.1002605-6-bjorn@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] xsk_pp_unbind() in net/xdp/xsk_pp.c ignores the return value of
  netif_mp_close_rxq() and always calls xsk_pp_detach().
- [High] xsk: UAF of pool and UMEM on xsk_pp_bind() failure with active
  page_pool

--

xsk: Install UMEM page pool providers in the core

This commit installs the AF_XDP UMEM as a page pool memory provider
through the queue management API, for drivers that set
netdev_queue_mgmt_ops.xsk_page_pool. Drivers check the chunk size,
headroom and multi-buffer setup in XDP_VALIDATE_XSK_POOL. The core
then verifies, using a per-queue mp_gen, that the new page pools picked
up the provider.

> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> index fdd55265a6cdc..c2214e718cdb3 100644
> --- a/net/xdp/xsk_pp.c
> +++ b/net/xdp/xsk_pp.c

[ ... ]

> @@ -236,11 +243,225 @@ static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
>  	return 0;
>  }
>  
> +/* The queue no longer uses the provider, and its DMA stopped */
> +static void xsk_pp_detach(struct xsk_pp *pp)
> +{
> +	pp->rxq = NULL;
> +	spin_lock_bh(&pp->lock);
> +	pp->fq = NULL;
> +	spin_unlock_bh(&pp->lock);
> +	xp_dma_unmap(pp->pool, XSK_PP_DMA_ATTR);
> +}

[ ... ]

> +/* Called with RTNL and the instance lock of the device */
> +void xsk_pp_unbind(struct xsk_buff_pool *pool)
> +{
> +	struct xsk_pp *pp = pool->pp;
> +	struct pp_memory_provider_params mp = {
> +		.mp_ops = &xsk_pp_ops,
> +		.mp_priv = pp,
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
What happens here if netif_mp_close_rxq() fails? xsk_pp_unbind() drops
its return value and always calls xsk_pp_detach(), and that unmaps the
UMEM DMA.

netif_mp_close_rxq() can return an error after the reconfig fails:

net/core/netdev_rx_queue.c:__netif_mp_close_rxq() {
    ...
	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
	netdev_queue_config(dev, rxq_idx, &qcfg[1]);

	err = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
	if (err == -ENETDOWN)
		return 0;
	WARN_ON(err);
	return err;
}

netdev_rx_queue_reconfig() can fail in several places:

  - kvzalloc() of new_mem or old_mem
  - ndo_queue_mem_alloc()
  - ndo_queue_stop()
  - ndo_queue_start(), which falls back to restarting the old queue

In each case the old queue keeps running. Its page pools still have
mp_priv == pp and mp_ops == &xsk_pp_ops, and the hardware RX ring still
holds UMEM chunk DMA addresses.

The teardown then continues:

xp_release_deferred()
  xp_clear_dev()
    __xp_clear_dev()
      xsk_pp_unbind()
        netif_mp_close_rxq()   <- fails, result dropped
        xsk_pp_detach()
          xp_dma_unmap()
  xdp_put_umem()               <- vunmap(umem->addrs), unpin pages
  xp_destroy(pool)             <- frees the xsk_buff_pool

The surviving page pools hold a reference on the xsk_pp only, taken in
xsk_pp_init(). They hold none on the DMA mapping, the UMEM pages or the
xsk_buff_pool.

Can the NIC then DMA into unmapped IOVAs? Without an IOMMU, can it DMA
into unpinned pages that may already be reused?

Also, xsk_pp_alloc_reuse() would keep recycling chunks with stale DMA
addresses. CPU reads through pp->area.vaddr would hit the vunmapped
umem->addrs, and pp->pool would point to the freed xsk_buff_pool.

Devmem doesn't seem to have this problem, because its page pools pin
the binding and the DMA unmap happens on the last reference drop. Here
the unmap happens no matter what pp->nr_pools is.

netif_rxq_cleanup_unlease() seems to follow the same pattern:

	__netif_mp_close_rxq(phys_rxq->dev, rxq_idx, &p);
	__netif_mp_uninstall_rxq(virt_rxq, &p);

It ignores the close result and then reaches xsk_pp_uninstall(), which
calls xsk_pp_detach().

No driver sets xsk_page_pool at this commit. fbnic opts in later in the
series, and its queue mem_alloc can fail with -ENOMEM.

A later patch in the series adds synchronize_net() before
xp_dma_unmap() in this path. That doesn't seem to help when the old
queue is still running.

Should xsk_pp_detach() be skipped, or the DMA unmap and UMEM release be
deferred until pp->nr_pools drops to zero, when the close fails?

[ ... ]

> @@ -236,11 +243,225 @@ static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
>  	return 0;
>  }
>  
> +/* The queue no longer uses the provider, and its DMA stopped */
> +static void xsk_pp_detach(struct xsk_pp *pp)
> +{
> +	pp->rxq = NULL;
> +	spin_lock_bh(&pp->lock);
> +	pp->fq = NULL;
> +	spin_unlock_bh(&pp->lock);
> +	xp_dma_unmap(pp->pool, XSK_PP_DMA_ATTR);
> +}
> +
> +/* The device unregisters, and is closed */
> +static void xsk_pp_uninstall(void *mp_priv, struct netdev_rx_queue *rxq)
> +{
> +	xsk_pp_detach(mp_priv);
> +}
> +
>  const struct memory_provider_ops xsk_pp_ops = {
>  	.init		= xsk_pp_init,
>  	.destroy	= xsk_pp_destroy,
>  	.alloc_netmems	= xsk_pp_alloc_netmems,
>  	.release_netmem	= xsk_pp_release_netmem,
>  	.nl_fill	= xsk_pp_nl_fill,
> +	.uninstall	= xsk_pp_uninstall,
>  	.caps		= MP_CAP_READABLE,
>  };
> +
> +static bool xsk_pp_abandon(struct xsk_pp *pp)
> +{
> +	struct xsk_buff_pool *pool = pp->pool;
> +	bool busy;
> +	u32 idx;
> +
> +	spin_lock_bh(&pp->lock);
> +	busy = pp->nr_pools;
> +	while (!busy && pp->reuse_cnt) {
> +		idx = pp->reuse[--pp->reuse_cnt];
> +		pp->state[idx] = XSK_PP_USER;
> +		xp_free(&pool->heads[idx]);
> +	}
> +	spin_unlock_bh(&pp->lock);
> +
> +	return !busy;
> +}
> +
> +static int xsk_pp_validate(struct net_device *dev, struct xsk_buff_pool *pool,
> +			   unsigned int mtu, struct bpf_prog *prog,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct xsk_rx_check check = {
> +		.buf_size = pool->chunk_size,
> +		.headroom = xsk_pool_get_headroom(pool),
> +		.mtu = mtu,
> +		.sg = xsk_pool_uses_sg(pool),
> +		.prog = prog,
> +	};
> +	struct netdev_bpf bpf = {
> +		.command = XDP_VALIDATE_XSK_POOL,
> +		.xsk_check.check = &check,
> +		.xsk_check.extack = extack,
> +	};
> +
> +	return dev->netdev_ops->ndo_bpf(dev, &bpf);
> +}
> +
> +/**
> + * xsk_validate_dev - check AF_XDP page pool queues against a new setting
> + * @dev: device of the queues
> + * @mtu: MTU to check
> + * @prog: XDP program to check, or NULL for the current one
> + * @mode: XDP mode of @prog
> + * @extack: netlink extended ack
> + *
> + * Context: holds the instance lock of @dev, or RTNL for a device without it.
> + * Return: 0 if the driver accepts all queues of @dev that have an AF_XDP
> + * memory provider, or its error.
> + */
> +int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
> +		     struct bpf_prog *prog, enum bpf_xdp_mode mode,
> +		     struct netlink_ext_ack *extack)
> +{
> +	struct netdev_rx_queue *rxq;
> +	struct xsk_pp *pp;
> +	unsigned int i;
> +	int err;
> +
> +	netdev_assert_locked_ops_compat(dev);
> +
> +	for (i = 0; i < dev->real_num_rx_queues; i++) {
> +		rxq = __netif_get_rx_queue(dev, i);
> +		if (rxq->mp_params.mp_ops != &xsk_pp_ops)
> +			continue;
> +
> +		/* Generic XDP runs outside the queue NAPI */
> +		if (mode == XDP_MODE_SKB) {
> +			NL_SET_ERR_MSG(extack,
> +				       "generic XDP cannot feed an AF_XDP page pool socket");
> +			return -EBUSY;
> +		}
> +
> +		pp = rxq->mp_params.mp_priv;
> +		err = xsk_pp_validate(dev, pp->pool, mtu, prog, extack);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xsk_validate_dev);
> +
> +/**
> + * xsk_rxq_pool - get the AF_XDP pool that provides memory to an RX queue
> + * @dev: device of the queue
> + * @queue_id: RX queue
> + *
> + * The pool stays valid while the queue that the caller allocates runs.
> + *
> + * Context: holds the instance lock of @dev.
> + * Return: the buffer pool, or NULL.
> + */
> +struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev, u16 queue_id)
> +{
> +	struct netdev_rx_queue *rxq;
> +	struct xsk_pp *pp;
> +
> +	netdev_assert_locked(dev);
> +
> +	if (queue_id >= dev->real_num_rx_queues)
> +		return NULL;
> +
> +	rxq = __netif_get_rx_queue(dev, queue_id);
> +	if (rxq->mp_params.mp_ops != &xsk_pp_ops)
> +		return NULL;
> +
> +	pp = rxq->mp_params.mp_priv;
> +	return pp->pool;
> +}
> +EXPORT_SYMBOL_GPL(xsk_rxq_pool);
> +
> +bool xsk_pp_supported(struct net_device *dev)
> +{
> +	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
> +
> +	return qops && qops->xsk_page_pool;
> +}
> +
> +/* Called with RTNL and the instance lock of @dev. On error, @pool->pp stays
> + * set if an old page pool still owns chunks; copy mode must not take the pool.
> + */
> +int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
> +		u16 queue_id)
> +{
> +	struct pp_memory_provider_params mp = { .mp_ops = &xsk_pp_ops };
> +	struct device *dma_dev;
> +	struct xsk_pp *pp;
> +	int err;
> +
> +	if (queue_id >= dev->real_num_rx_queues || pool->unaligned)
> +		return -EOPNOTSUPP;
> +	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK ||
> +	    (xsk_pool_uses_sg(pool) && dev->xdp_zc_max_segs == 1))
> +		return -EOPNOTSUPP;
> +	if (dev_xdp_prog_id(dev, XDP_MODE_SKB))
> +		return -EOPNOTSUPP;
> +	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE))
> +		return -EBUSY;
> +
> +	err = xsk_pp_validate(dev, pool, dev->mtu, NULL, NULL);
> +	if (err)
> +		return err;
> +
> +	dma_dev = netdev_queue_get_dma_dev(dev, queue_id, NETDEV_QUEUE_TYPE_RX);
> +	if (!dma_dev)
> +		return -EOPNOTSUPP;
> +
> +	err = xp_dma_map(pool, dma_dev, XSK_PP_DMA_ATTR, pool->umem->pgs,
> +			 pool->umem->npgs);
> +	if (err)
> +		return err;
> +
> +	pp = xsk_pp_create(pool);
> +	if (IS_ERR(pp)) {
> +		xp_dma_unmap(pool, XSK_PP_DMA_ATTR);
> +		return PTR_ERR(pp);
> +	}
> +
> +	mp.mp_priv = pp;
> +	mp.rx_page_size = pool->chunk_size;
> +	mp.rx_headroom = xsk_pool_get_headroom(pool);
> +	err = netif_mp_open_rxq(dev, queue_id, &mp, NULL);
> +	if (!err) {
> +		pp->rxq = __netif_get_rx_queue(dev, queue_id);
> +		pool->pp = pp;
> +		pool->xdp_zc_max_segs = dev->xdp_zc_max_segs;
> +		return 0;
> +	}
> +
> +	xp_dma_unmap(pool, XSK_PP_DMA_ATTR);
> +	/* Copy mode takes the chunks that the provider holds */
> +	if (!xp_alloc_heads(pool) && xsk_pp_abandon(pp))
> +		xsk_pp_put(pp);
> +	else
> +		pool->pp = pp;
> +
> +	return err;
> +}
> +
> +/* Called with RTNL and the instance lock of the device */
> +void xsk_pp_unbind(struct xsk_buff_pool *pool)
> +{
> +	struct xsk_pp *pp = pool->pp;
> +	struct pp_memory_provider_params mp = {
> +		.mp_ops = &xsk_pp_ops,
> +		.mp_priv = pp,
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
What keeps the buffer pool and the UMEM alive when this error path
leaves pool->pp set?

netif_mp_open_rxq() can fail after ndo_queue_mem_alloc() has already
created page pools that selected the provider. That happens when
page_pool_check_memory_provider() returns -ENODATA, and when
ndo_queue_stop() or ndo_queue_start() fails. Each of those page pools
took a reference and bumped pp->nr_pools in xsk_pp_init().

If ndo_queue_mem_free() leaves one of them in deferred destruction
because chunks are still out, xsk_pp_abandon() returns false and
pool->pp is set. The same happens when xp_alloc_heads() fails with
-ENOMEM.

By that point xp_dma_unmap() has already run unconditionally. The
lingering page pool may still own chunks whose DMA addresses came from
that mapping. pp->fq is also left pointing at the fill queue, unlike
in xsk_pp_detach().

xp_assign_dev() then sees pool->pp set, skips the copy mode fallback
and returns the error. xsk_bind() destroys the pool right away:

	err = xp_assign_dev(xs->pool, dev, qid, flags);
	if (err) {
		xp_destroy(xs->pool);
		xs->pool = NULL;
		goto out_unlock;
	}

xp_destroy() drops only the buffer pool's reference on the xsk_pp.
The xsk_pp survives on the page pool's reference, and then the
xsk_buff_pool is freed, which leaves pp->pool dangling.

The socket stays in XSK_READY, so on close xsk_release() frees
xs->fq_tmp, which pp->fq still points to. xsk_destruct() then calls
xdp_put_umem(), which vunmaps umem->addrs (pp->area.vaddr) and unpins
the UMEM pages. The lingering page pool still holds chunks backed by
those pages.

When that page pool finally returns its chunks, won't the provider
ops reach pp->pool, pp->fq or pp->area.vaddr after they are gone?

The comment above xsk_pp_bind() says pool->pp stays set so that copy
mode does not take the pool. But the caller frees the pool anyway, so
what does keeping pool->pp set protect? A second bind() on the same
socket also gets a fresh pool with pool->pp == NULL for the same UMEM,
so the pool->pp check in xp_assign_dev() does not help there either.

Should the xsk_pp pin the buffer pool and the UMEM, and do the DMA
unmap in xsk_pp_free(), so they outlive the last page pool? Or should
xsk_bind() defer releasing the pool in this case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110102039.1002605-1-bjorn%40kernel.org
