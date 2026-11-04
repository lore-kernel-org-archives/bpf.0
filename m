Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800008;
	b=nS/rc9OiN4rmK+IR5E5gxkza26p/lx3NIlP8+iEAYNhR14/YBWui6gXfhcU8hUtA9MAn
	 UD7kvGlOkLYGwY5eJsjLWh0PHVYMYs2KjX3D43uV/grhnS6EI+fNFv1PzH9JFACIQtUL6
	 S8/EplFnFlpSa3gB/By7fBv25DARU+6ELDYApMWRXqmbI6w3rWjk3e+fxfhKacx8WmSnB
	 6CYmsGL7lRzux1d6hO5Y6Xp0tOE3JHPMBKQjPzDsTN11iDQfKBEx9T9bTmwsJ7hCqH4TU
	 nTLR1yg/gea9LRTJ8cbku22Jdk6mAF110NXK2HUV/rA7Tu0KfWxrMBK0wYzDenSvDFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cn/hlvigXlpGfZZ1gqnf+WeteE6RPNzFgxH6LqIzyjQ=;
	b=hpqWChB8FIKXrQXzKv87QRVkupgcrlT3oLIFGwaDp/ZULkxtTwHNmW3lrIKlvZqGnqMz
	 he84yXgDPx+2lL7m1qGlE2zWjF9Zcxl4j7p0P18VUAMNAeRIO5dyaft7OGt1N3suMIcaA
	 Ob064AN7/Zr68kgs54czKgytLyASu7cg+wUlH8js9bXLV4J7klspInWVXFEdFu/G8WUIH
	 DQzilQYXA+NZpWYPuO6WovmwHFAaW9IH2G7OMJak1aI+So3BK1VIieFfRAtQY2bm3OJ79
	 oPTAGwxAmpqpywjfeDAv+nM6sEacapRQhysUX6KO7XXCjdX8hDp5W/4/sOlE3y9R/Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuQ5QDB7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A5606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fuQ5QDB7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A751F000C1;
	Wed,  4 Nov 2026 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800007;
	bh=Cn/hlvigXlpGfZZ1gqnf+WeteE6RPNzFgxH6LqIzyjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fuQ5QDB70VC+izEGWFhM/svelCeXiq21hajUE0E36to6Ets4KnJc4pUGuS+ZAUf5j
	 AhWCIrQNK5bXV8hBuHNbGHMYmczJ0UQ+PugamEBlLBooazihhCvD9p17cBkSAr8q9x
	 a7k1eTq93RhUWSzjXMlng5O4p7Ba+HTyrvQAw9TA6+bS5wWIYFIQ/Ooq5mY3IOx/QR
	 SbR4e6mc3RiE1C1XYqqdSd/11C66GKbHALBqZ1gLFXFwCaTV2G1+kc8RUsFISOZ2sB
	 YQ32Hq9e8HvN1pJgZLHoHmjZwfcU+StpdZSZnrTLRfVGa3RawuuZ49TuvWEM4eVK1t
	 hVyUrxccKO8jg==
Message-ID: <sashiko-outbox-197353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 1/2] icssg: Add multi-flow RX support with
 per-flow NAPI and classification
Reply-To: sashiko-reviews@lists.linux.dev
To: "Meghana Malladi" <m-malladi@ti.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261103134501.4123194-2-m-malladi@ti.com>
References: <20261103134501.4123194-1-m-malladi@ti.com>
 <20261103134501.4123194-2-m-malladi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 13:46:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [Critical] net: ti: icssg: hardcoded flow 0 and queue 0 in multi-flow XSK=
 and XDP
- [Critical] net: ti: icssg: missing rx_flow_num bounds check in XSK pool a=
nd wakeup
- [High] net: ti: icssg: undersized shared RX FDQ ring in prueth_init_rx_ch=
ns()
- [High] net: ti: icssg: shared RX FDQ page leaks in prueth_destroy_rxq() t=
eardown
- [High] net: ti: icssg: build breakage in icssg_prueth_sr1.c from RX API c=
hanges
- [High] net: ti: icssg: hang in prueth_destroy_rxq() on prueth_create_rxq(=
) error
- [Medium] net: ti: icssg: unsigned irq check misses errors in prueth_init_=
rx_chns()
- [Medium] net: ti: icssg: emac_set_coalesce() only sets RX coalescing on f=
low 0
- [Medium] net: ti: icssg: prueth_destroy_rxqs() skips NAPI wakeup for non-=
XSK flows
- [Medium] net: ti: icssg: RX teardown and IRQ pacing bugs in prueth_destro=
y_rxqs()
- [Medium] net: ti: icssg: PRUSS DRAM leak in prueth_netdev_init() on bitma=
p alloc error
- [Medium] net: ti: icssg: allocate PRUETH_MAX_RX_FLOWS rx queues and set r=
eal_num_rx_queues
--

commit a2ae6a161ac2d7097a317321767fd99ea3cc193c
Author: Meghana Malladi <m-malladi@ti.com>

icssg: Add multi-flow RX support with per-flow NAPI and classification

This commit extends the ICSSG driver to support up to 8 RX flows per EMAC,
introducing per-flow NAPI, hrtimer, page pool, XDP rxq, AF_XDP pool, and
IRQ management while sharing a single UDMA RX channel and descriptor pool.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index 4a7d1a6f470b1..99f4353b46966 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c

[ ... ]

> @@ -584,40 +622,49 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  				K3_UDMA_GLUE_SRC_TAG_LO_USE_REMOTE_SRC_TAG,
>  		};
> =20
> +		flow =3D &rx_chn->flows[i];
> +		flow->emac =3D emac;
> +		flow->id =3D i;
> +		flow->irq =3D -EINVAL;
> +
>  		rx_flow_cfg.ring_rxfdq0_id =3D fdqring_id;
> -		rx_flow_cfg.rx_cfg.size =3D max_desc_num;
> -		rx_flow_cfg.rxfdq_cfg.size =3D max_desc_num;
> +		rx_flow_cfg.rx_cfg.size =3D PRUETH_MAX_RX_DESC;
> +		rx_flow_cfg.rxfdq_cfg.size =3D PRUETH_MAX_RX_DESC;

[Severity: High]
Does rx_flow_cfg.rxfdq_cfg.size need to be scaled to rx_chn->descs_num
(PRUETH_MAX_RX_DESC * rx_cfg.flow_id_num) here?

In prueth_init_rx_chns(), flow 0 allocates a shared FDQ ring with
K3_RINGACC_RING_SHARED and subsequent flows pass rx_flow_cfg.ring_rxfdq0_id
=3D fdqring_id. On UDMAP platforms such as AM654, k3_udma_glue_cfg_rx_flow()
shares flow 0's ringrxfdq across all flows, and k3_ringacc_ring_cfg() only
configures the ring size on the first user.

When emac->rx_flow_num > 1, prueth_prepare_rx_flow(emac, 0) pushes
PRUETH_MAX_RX_DESC (512) descriptors into the 512-entry shared FDQ ring,
completely filling it, so prueth_prepare_rx_flow(emac, 1) immediately fails
with -ENOMEM in k3_ringacc_ring_push().

>  		rx_flow_cfg.rxfdq_cfg.mode =3D emac->prueth->pdata.fdqring_mode;
> =20
>  		ret =3D k3_udma_glue_rx_flow_init(rx_chn->rx_chn,
>  						i, &rx_flow_cfg);
>  		if (ret) {
>  			netdev_err(ndev, "Failed to init rx flow%d %d\n",
>  				   i, ret);
>  			goto fail;
>  		}
>  		if (!i)
>  			fdqring_id =3D k3_udma_glue_rx_flow_get_fdq_id(rx_chn->rx_chn,
>  								     i);
> -		ret =3D k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
> -		if (ret < 0) {
> +		flow->irq =3D k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
> +		if (flow->irq <=3D 0) {
> +			ret =3D flow->irq;
>  			netdev_err(ndev, "Failed to get rx dma irq");
>  			goto fail;
>  		}

[Severity: Medium]
In struct prueth_rx_flow, irq is declared as unsigned int. When
k3_udma_glue_rx_get_irq() returns a negative error code, assigning it
directly to flow->irq wraps it to a large positive value, causing
flow->irq <=3D 0 to evaluate to false and bypassing the error check.

Furthermore, if flow->irq is 0, ret =3D flow->irq sets ret to 0 and jumps to
fail:, which cleans up the RX channel and returns 0 (success) to
emac_ndo_open(). Should the return value of k3_udma_glue_rx_get_irq() be
checked in a signed int variable before assigning to flow->irq?

[ ... ]

> @@ -641,8 +688,9 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *ema=
c,
>  	swdata =3D cppi5_hdesc_get_swdata(desc_rx);
>  	swdata->type =3D PRUETH_SWDATA_PAGE;
>  	swdata->data.page =3D page;
> +	swdata->flow_id =3D flow_id;
> =20
> -	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
> +	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, flow_id,
>  					desc_rx, desc_dma);
>  }

[Severity: High]
If k3_udma_glue_push_rx_chn() fails in prueth_dma_rx_push_mapped() (or in
prueth_dma_rx_push_mapped_zc()), does this leak desc_rx from
rx_chn->desc_pool because k3_cppi_desc_pool_free() is not called before
returning?

[ ... ]

> @@ -863,31 +911,32 @@ static int prueth_dma_rx_push_mapped_zc(struct prue=
th_emac *emac,
>  					struct xdp_buff *xdp)
>  {
>  	struct net_device *ndev =3D emac->ndev;
> +	struct prueth_rx_flow *rx_flow =3D &emac->rx_chns.flows[PRUETH_RX_FLOW_=
DATA];
>  	struct cppi5_host_desc_t *desc_rx;
>  	struct prueth_swdata *swdata;
>  	dma_addr_t desc_dma;
>  	dma_addr_t buf_dma;
>  	int buf_len;
> =20
>  	buf_dma =3D xsk_buff_xdp_get_dma(xdp);
>  	desc_rx =3D k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
>  	if (!desc_rx) {
>  		netdev_err(ndev, "rx push: failed to allocate descriptor\n");
>  		return -ENOMEM;
>  	}
>  	desc_dma =3D k3_cppi_desc_pool_virt2dma(rx_chn->desc_pool, desc_rx);
> =20
>  	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
>  			 PRUETH_NAV_PS_DATA_SIZE);
>  	k3_udma_glue_rx_dma_to_cppi5_addr(rx_chn->rx_chn, &buf_dma);
> -	buf_len =3D xsk_pool_get_rx_frame_size(rx_chn->xsk_pool);
> +	buf_len =3D xsk_pool_get_rx_frame_size(rx_flow->xsk_pool);
>  	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
>  	swdata =3D cppi5_hdesc_get_swdata(desc_rx);
>  	swdata->type =3D PRUETH_SWDATA_XSK;
>  	swdata->data.xdp =3D xdp;
> =20
>  	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
>  					desc_rx, desc_dma);
>  }
> =20
> -static int prueth_rx_alloc_zc(struct prueth_emac *emac, int budget)
> +static int prueth_rx_alloc_zc(struct prueth_emac *emac, int flow_id, int=
 budget)
>  {
> -	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
> +	struct prueth_rx_flow *rx_flow =3D &emac->rx_chns.flows[flow_id];
>  	struct xdp_buff *xdp;
>  	int i, ret;
> =20
>  	for (i =3D 0; i < budget; i++) {
> -		xdp =3D xsk_buff_alloc(rx_chn->xsk_pool);
> +		xdp =3D xsk_buff_alloc(rx_flow->xsk_pool);
>  		if (!xdp)
>  			break;
> =20
> -		ret =3D prueth_dma_rx_push_mapped_zc(emac, rx_chn, xdp);
> +		ret =3D prueth_dma_rx_push_mapped_zc(emac, &emac->rx_chns, xdp);

[Severity: Critical]
In prueth_rx_alloc_zc(), xdp buffers are allocated from
flows[flow_id].xsk_pool, but prueth_dma_rx_push_mapped_zc() does not take a
flow_id parameter and instead hardcodes PRUETH_RX_FLOW_DATA (0) for both
rx_flow->xsk_pool and k3_udma_glue_push_rx_chn().

If an XSK pool is active on flow_id > 0 while flows[0].xsk_pool is NULL,
won't xsk_pool_get_rx_frame_size(rx_flow->xsk_pool) dereference a NULL
pointer, or otherwise push flow_id's XSK buffers into flow 0's ring?

[ ... ]

> @@ -1155,19 +1206,22 @@ void prueth_rx_cleanup(void *data, dma_addr_t des=
c_dma)
>  	struct prueth_rx_chn *rx_chn =3D data;
>  	struct cppi5_host_desc_t *desc_rx;
>  	struct prueth_swdata *swdata;
> -	struct page_pool *pool;
> +	struct page_pool *pool =3D NULL;
>  	struct xdp_buff *xdp;
>  	struct page *page;
> =20
> -	pool =3D rx_chn->pg_pool;
>  	desc_rx =3D k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
>  	swdata =3D cppi5_hdesc_get_swdata(desc_rx);
> -	if (rx_chn->xsk_pool) {
> +
> +	if (swdata->type =3D=3D PRUETH_SWDATA_XSK) {
>  		xdp =3D swdata->data.xdp;
>  		xsk_buff_free(xdp);
> -	} else {
> -		page =3D swdata->data.page;
> -		page_pool_recycle_direct(pool, page);
> +	} else if (swdata->type =3D=3D PRUETH_SWDATA_PAGE) {
> +		pool =3D rx_chn->flows[swdata->flow_id].pg_pool;
> +		if (pool) {
> +			page =3D swdata->data.page;
> +			page_pool_recycle_direct(pool, page);
> +		}
>  	}
> =20
>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);

[ ... ]

> @@ -1488,59 +1531,77 @@ int icssg_napi_rx_poll(struct napi_struct *napi_r=
x, int budget)
>  }
>  EXPORT_SYMBOL_GPL(icssg_napi_rx_poll);
> =20
> -int prueth_prepare_rx_chan(struct prueth_emac *emac,
> -			   struct prueth_rx_chn *chn,
> -			   int buf_size)
> +int prueth_prepare_rx_flow(struct prueth_emac *emac,
> +			   int flow)
>  {
> +	int buf_size =3D PRUETH_MAX_PKT_SIZE;
> +	struct prueth_rx_flow *rx_flow;
> +	struct prueth_rx_chn *rx_chn;
> +	struct page_pool *pool;
>  	struct page *page;
>  	int desc_avail;
>  	int i, ret;
> =20
> -	desc_avail =3D k3_cppi_desc_pool_avail(chn->desc_pool);
> -	if (desc_avail < chn->descs_num)
> -		netdev_warn(emac->ndev,
> -			    "not enough RX descriptors available %d < %d\n",
> -			    desc_avail, chn->descs_num);
> +	rx_chn =3D &emac->rx_chns;
> +	rx_flow =3D &emac->rx_chns.flows[flow];
> =20
> -	if (chn->xsk_pool) {
> -		/* get pages from xsk_pool and push to RX ring
> -		 * queue as much as possible
> +	if (rx_flow->xsk_pool) {
> +		/* XSK zero-copy: buffers come from the XSK fill ring, no page
> +		 * pool needed.  Push as many XSK buffers as descriptors allow;
> +		 * the fill ring will be replenished by user-space.
>  		 */
> -		ret =3D prueth_rx_alloc_zc(emac, desc_avail);
> -		if (!ret)
> -			goto recycle_alloc_pg;
> -	} else {
> -		for (i =3D 0; i < desc_avail; i++) {
> -			/* NOTE: we're not using memory efficiently here.
> -			 * 1 full page (4KB?) used here instead of
> -			 * PRUETH_MAX_PKT_SIZE (~1.5KB?)
> -			 */
> -			page =3D page_pool_dev_alloc_pages(chn->pg_pool);
> -			if (!page) {
> -				netdev_err(emac->ndev, "couldn't allocate rx page\n");
> -				ret =3D -ENOMEM;
> -				goto recycle_alloc_pg;
> -			}
> +		desc_avail =3D k3_cppi_desc_pool_avail(rx_chn->desc_pool);
> +		if (desc_avail < PRUETH_MAX_RX_DESC)
> +			netdev_warn(emac->ndev,
> +				    "not enough RX descriptors available %d < %d\n",
> +				    desc_avail, PRUETH_MAX_RX_DESC);
> =20
> -			ret =3D prueth_dma_rx_push_mapped(emac, chn, page, buf_size);
> -			if (ret < 0) {
> -				netdev_err(emac->ndev,
> -					   "cannot submit page for rx chan %s ret %d\n",
> -					   chn->name, ret);
> -				page_pool_recycle_direct(chn->pg_pool, page);
> -				goto recycle_alloc_pg;
> -			}
> +		prueth_rx_alloc_zc(emac, flow, desc_avail);
> +		return 0;
> +	}

[Severity: High]
In the rx_flow->xsk_pool branch of prueth_prepare_rx_flow(), desc_avail is
the total number of available descriptors in the shared rx_chn->desc_pool
(up to PRUETH_MAX_RX_DESC * emac->rx_flow_num). Should the budget passed to
prueth_rx_alloc_zc() be capped at min(desc_avail, PRUETH_MAX_RX_DESC) so a
single XSK flow does not consume descriptors needed by subsequent flows?

> +
> +	pool =3D prueth_create_page_pool(emac, rx_chn->dma_dev, rx_chn->descs_n=
um, rx_flow);
> +	if (IS_ERR(pool))
> +		return PTR_ERR(pool);
> +
> +	rx_flow->pg_pool =3D pool;
> +
> +	desc_avail =3D k3_cppi_desc_pool_avail(rx_chn->desc_pool);
> +	if (desc_avail < PRUETH_MAX_RX_DESC)
> +		netdev_warn(emac->ndev,
> +			    "not enough RX descriptors available %d < %d\n",
> +			    desc_avail, PRUETH_MAX_RX_DESC);
> +
> +	for (i =3D 0; i < PRUETH_MAX_RX_DESC; ++i) {
> +		page =3D page_pool_dev_alloc_pages(pool);
> +		if (!page) {
> +			netdev_err(emac->ndev, "couldn't allocate rx page\n");
> +			ret =3D -ENOMEM;
> +			goto err_free_pushed;
>  		}
> +
> +		ret =3D prueth_dma_rx_push_mapped(emac, rx_chn, page, buf_size, flow);
> +		if (ret < 0) {
> +			netdev_err(emac->ndev,
> +				   "cannot submit skb for rx chan %s ret %d\n",
> +				   rx_flow->name, ret);
> +			page_pool_recycle_direct(pool, page);
> +			goto err_free_pushed;
> +		}
>  	}
> =20
>  	return 0;
> =20
> -recycle_alloc_pg:
> -	prueth_reset_rx_chan(&emac->rx_chns, PRUETH_MAX_RX_FLOWS, false);
> -
> +err_free_pushed:
> +	/* i pages were successfully pushed to the ring.  Reset the channel
> +	 * to drain them back and recycle via prueth_rx_cleanup before the
> +	 * caller destroys the page pool.
> +	 */
> +	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, flow, rx_chn,
> +				   prueth_rx_cleanup);
>  	return ret;
>  }

[Severity: High]
How does per-flow reset interact with the shared FDQ ring on UDMAP
platforms?

In k3_udma_glue_reset_rx_chn():

    if (rx_chn->single_fdq && flow_num)
            goto do_reset;

Because all flows share flow 0's FDQ (rx_chn->single_fdq is true on UDMAP),
k3_udma_glue_reset_rx_chn() only drains ringrxfdq when flow_num =3D=3D 0 and
skips it completely when flow_num > 0:

1. Here at err_free_pushed:, if flow > 0 fails partway through pushing
   pages, k3_udma_glue_reset_rx_chn(..., flow, ...) skips ringrxfdq and
   does not drain the pushed pages before the caller destroys
   rx_flow->pg_pool.

2. In prueth_create_rxqs(), the error unwind loop runs backwards:

       for (--i; i >=3D 0; i--)
               prueth_destroy_rxq(emac, i);

   For i > 0, prueth_destroy_rxq(emac, i) skips draining ringrxfdq, calls
   page_pool_destroy(flow->pg_pool), and sets flow->pg_pool =3D NULL. When
   i =3D=3D 0 finally runs k3_udma_glue_reset_rx_chn(..., 0, ...),
   prueth_rx_cleanup() sees rx_chn->flows[swdata->flow_id].pg_pool =3D=3D N=
ULL
   for all descriptors with swdata->flow_id > 0 and leaks those pages.

3. In prueth_xsk_pool_enable() and prueth_xsk_pool_disable(), calling
   prueth_destroy_rxq(emac, queue_id) on a single queue while the shared RX
   channel is enabled either drains and resets the shared FDQ for all flows
   (if queue_id =3D=3D 0) or fails to drain queue_id's descriptors from the
   shared FDQ before destroying its page pool or unmapping its XSK pool
   (if queue_id > 0).

4. During normal multi-flow RX on a shared FDQ ring, UDMAP pops descriptors
   from the shared FDQ in FIFO order regardless of which flow's page_pool
   allocated the page, whereas emac_rx_packet() syncs and recycles pages
   using rx_flow->pg_pool rather than rx_chn->flows[swdata->flow_id].pg_poo=
l,
   and concurrent per-flow NAPI instances call k3_ringacc_ring_push() on
   the same shared struct k3_ring without serialization.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/=
ethernet/ti/icssg/icssg_ethtool.c
> index b715af21d23ac..5c2936ecd595c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c

[ ... ]

> @@ -245,6 +248,8 @@ static int emac_set_coalesce(struct net_device *ndev,
>  			     struct netlink_ext_ack *extack)
>  {
>  	struct prueth_emac *emac =3D netdev_priv(ndev);
> +	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
> +	struct prueth_rx_flow *flow =3D &rx_chn->flows[0];
>  	struct prueth *prueth =3D emac->prueth;
>  	struct prueth_tx_chn *tx_chn;
> =20
> @@ -264,7 +269,7 @@ static int emac_set_coalesce(struct net_device *ndev,
>  		coal->tx_coalesce_usecs =3D ICSSG_MIN_COALESCE_USECS;
>  	}
> =20
> -	emac->rx_pace_timeout_ns =3D coal->rx_coalesce_usecs * 1000;
> +	flow->rx_pace_timeout_ns =3D coal->rx_coalesce_usecs * 1000;
>  	tx_chn->tx_pace_timeout_ns =3D coal->tx_coalesce_usecs * 1000;
> =20
>  	return 0;

[Severity: Medium]
Now that rx_pace_timeout_ns is stored per flow in struct prueth_rx_flow and
checked by icssg_napi_rx_poll() on each flow, emac_set_coalesce() only
updates rx_chn->flows[0].rx_pace_timeout_ns (and
emac_set_per_queue_coalesce() only handles TX queues). Does this leave RX
flows 1..7 with rx_pace_timeout_ns =3D=3D 0 when RX coalescing is configure=
d?

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.c
> index 591be5c8056b4..8338402597b21 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c

[ ... ]

> @@ -883,14 +832,14 @@ static int icssg_update_vlan_mcast(struct net_devic=
e *vdev, int vid,
>  static void prueth_set_xsk_pool(struct prueth_emac *emac, u16 queue_id)
>  {
>  	struct prueth_tx_chn *tx_chn =3D &emac->tx_chns[queue_id];
> -	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
> +	struct prueth_rx_flow *rx_flow =3D &emac->rx_chns.flows[PRUETH_RX_FLOW_=
DATA];
> =20
> -	if (emac->xsk_qid !=3D queue_id) {
> -		rx_chn->xsk_pool =3D NULL;
> -		tx_chn->xsk_pool =3D NULL;
> -	} else {
> -		rx_chn->xsk_pool =3D xsk_get_pool_from_qid(emac->ndev, queue_id);
> +	if (test_bit(queue_id, emac->xsk_queues)) {
> +		rx_flow->xsk_pool =3D xsk_get_pool_from_qid(emac->ndev, queue_id);
>  		tx_chn->xsk_pool =3D xsk_get_pool_from_qid(emac->ndev, queue_id);
> +	} else {
> +		rx_flow->xsk_pool =3D NULL;
> +		tx_chn->xsk_pool =3D NULL;
>  	}
>  }

[Severity: Critical]
In prueth_set_xsk_pool(), rx_flow is indexed with PRUETH_RX_FLOW_DATA (0)
instead of queue_id. When enabling or disabling an XSK pool on queue_id > 0,
won't this overwrite or clear flows[0].xsk_pool while flow 0 is running and
leave flows[queue_id].xsk_pool untouched?

Also, in prueth_init_rx_chns(), flow->xsk_pool is set to NULL for all flows
during emac_ndo_open() without calling prueth_set_xsk_pool() to restore
pools for queues set in emac->xsk_queues.

[ ... ]

> @@ -921,40 +870,58 @@ static void prueth_destroy_txq(struct prueth_emac *=
emac)
>  	}
>  }
> =20
> -static void prueth_destroy_rxq(struct prueth_emac *emac)
> +static void prueth_destroy_rxq(struct prueth_emac *emac, int qid)
> +{
> +	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
> +	struct prueth_rx_flow *flow =3D &rx_chn->flows[qid];
> +
> +	/* reset napi and hrtimer, and free all pending buffers */
> +	napi_disable(&flow->napi_rx);
> +	hrtimer_cancel(&flow->rx_hrtimer);

[Severity: Medium]
If flow->rx_hrtimer is pending when prueth_destroy_rxq() cancels it,
flow->irq_disabled is true and flow->irq is currently disabled at the IRQ
chip waiting for emac_rx_timer_callback() to re-enable it.

When prueth_destroy_rxq() is called from prueth_xsk_pool_enable() or
prueth_xsk_pool_disable() on a running interface, cancelling the timer
without re-enabling flow->irq and clearing flow->irq_disabled leaves the
flow's RX IRQ permanently disabled (and across emac_ndo_stop() /
emac_ndo_open(), flow->irq_disabled remains true because
prueth_init_rx_chns() does not reset it). Should prueth_destroy_rxq() check
flow->irq_disabled and call enable_irq(flow->irq) after hrtimer_cancel()?

> +	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, flow->id, rx_chn,
> +				  prueth_rx_cleanup);
> +
> +	if (xdp_rxq_info_is_reg(&flow->xdp_rxq))
> +		xdp_rxq_info_unreg(&flow->xdp_rxq);
> +
> +	if (flow->pg_pool) {
> +		page_pool_destroy(flow->pg_pool);
> +		flow->pg_pool =3D NULL;
> +	}
> +}
> +
> +static void prueth_destroy_rxqs(struct prueth_emac *emac)
>  {
>  	int i, ret;
> =20
>  	/* tear down and disable UDMA channels */
>  	reinit_completion(&emac->tdown_complete);
>  	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
> =20
>  	/* When RX DMA Channel Teardown is initiated, it will result in an
>  	 * interrupt and a Teardown Completion Marker (TDCM) is queued into
>  	 * the RX Completion queue. Acknowledging the interrupt involves
>  	 * popping the TDCM descriptor from the RX Completion queue via the
>  	 * RX NAPI Handler. To avoid timing out when waiting for the TDCM to
>  	 * be popped, schedule the RX NAPI handler to run immediately.
>  	 */
> -	if (!napi_if_scheduled_mark_missed(&emac->napi_rx)) {
> -		if (napi_schedule_prep(&emac->napi_rx))
> -			__napi_schedule(&emac->napi_rx);
> +	for (int i =3D 0; i < emac->rx_flow_num; i++) {
> +		if (test_bit(i, emac->xsk_queues)) {
> +			if (!napi_if_scheduled_mark_missed(&emac->rx_chns.flows[i].napi_rx)) {
> +				if (napi_schedule_prep(&emac->rx_chns.flows[i].napi_rx))
> +					__napi_schedule(&emac->rx_chns.flows[i].napi_rx);
> +			}
> +		}
>  	}

[Severity: Medium]
Why is NAPI scheduling during RX teardown restricted to flows with
test_bit(i, emac->xsk_queues) set (also shadowing the outer int i)?

If XSK is not enabled on a flow and its RX IRQ is currently disabled by
rx_hrtimer coalescing when prueth_destroy_rxqs() initiates teardown, NAPI
will not be scheduled immediately to pop the TDCM descriptor, causing
wait_for_completion_timeout(&emac->tdown_complete, msecs_to_jiffies(1000))
to time out.

[ ... ]

> @@ -978,27 +945,62 @@ static int prueth_create_txq(struct prueth_emac *em=
ac)
>  	return ret;
>  }
> =20
> -static int prueth_create_rxq(struct prueth_emac *emac)
> +static int prueth_create_rxq(struct prueth_emac *emac, int id)
>  {
> +	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
> +	struct prueth_rx_flow *flow =3D &rx_chn->flows[id];
> +	struct xdp_rxq_info *rxq =3D &flow->xdp_rxq;
>  	int ret;
> =20
> -	ret =3D prueth_prepare_rx_chan(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZ=
E);
> +	ret =3D prueth_prepare_rx_flow(emac, id);
>  	if (ret)
> -		return ret;
> +		goto err;
> =20
> -	ret =3D k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
> +	ret =3D xdp_rxq_info_reg(rxq, emac->ndev, 0, flow->napi_rx.napi_id);

[Severity: Critical]
Should the third argument to xdp_rxq_info_reg() be id instead of hardcoded
0 so each flow's xdp_rxq_info is registered with its own queue index? With
queue_index hardcoded to 0, XDP_REDIRECT to AF_XDP sockets bound to queues
1..7 will fail queue index validation in xsk_rcv_check().

>  	if (ret)
> -		goto reset_rx_chn;
> +		goto err;
> =20
> -	ret =3D prueth_create_xdp_rxqs(emac);
> -	if (ret)
> -		goto reset_rx_chn;
> +	if (flow->xsk_pool) {
> +		ret =3D xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_XSK_BUFF_POOL, NULL);
> +		if (ret)
> +			goto err;
> +		xsk_pool_set_rxq_info(flow->xsk_pool, rxq);
> +	} else {
> +		ret =3D xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL, flow->pg_p=
ool);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	napi_enable(&flow->napi_rx);
> +	return 0;
> +
> +err:
> +	prueth_destroy_rxq(emac, id);
> +	return ret;
> +}

[Severity: High]
If prueth_prepare_rx_flow(), xdp_rxq_info_reg(), or
xdp_rxq_info_reg_mem_model() fails in prueth_create_rxq(), execution jumps
to err: and calls prueth_destroy_rxq(emac, id) before
napi_enable(&flow->napi_rx) has been called.

Because netif_napi_add() (or a prior napi_disable()) leaves
NAPIF_STATE_SCHED set until napi_enable() is called, won't
napi_disable(&flow->napi_rx) in prueth_destroy_rxq() hang in an infinite
loop waiting for NAPIF_STATE_SCHED to clear?

[ ... ]

> @@ -1018,24 +1020,21 @@ static int emac_ndo_open(struct net_device *ndev)
>  	struct prueth *prueth =3D emac->prueth;
>  	int slice =3D prueth_emac_slice(emac);
>  	struct device *dev =3D prueth->dev;
> -	int max_rx_flows;
> -	int rx_flow;
> =20
>  	/* set h/w MAC as user might have re-configured */
>  	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
> =20
>  	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
>  	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
> =20
>  	/* Notify the stack of the actual queue counts. */
>  	ret =3D netif_set_real_num_tx_queues(ndev, num_data_chn);
>  	if (ret) {
>  		dev_err(dev, "cannot set real number of tx queues\n");
>  		return ret;
>  	}

[Severity: Medium]
In prueth_netdev_init(), alloc_etherdev_mq(sizeof(*emac), num_tx_chn) is
called with num_tx_chn =3D PRUETH_MAX_TX_QUEUES (4), which only allocates 4
RX queues in ndev->_rx (ndev->num_rx_queues =3D 4, ndev->real_num_rx_queues=
 =3D
4), and emac_ndo_open() never calls
netif_set_real_num_rx_queues(ndev, emac->rx_flow_num).

When emac->rx_flow_num is set to 5..8 via ethtool, queues 4..7 have no
struct netdev_rx_queue entries in ndev->_rx (breaking AF_XDP, RPS, sysfs,
and netlink queue operations for queues >=3D 4), and when emac->rx_flow_num
is 1..3, the stack still sees 4 active RX queues. Should
prueth_netdev_init() use alloc_etherdev_mqs(..., PRUETH_MAX_TX_QUEUES,
PRUETH_MAX_RX_FLOWS) and emac_ndo_open() call
netif_set_real_num_rx_queues(ndev, emac->rx_flow_num)?

[ ... ]

> @@ -1467,7 +1459,6 @@ static int emac_xdp_setup(struct prueth_emac *emac,=
 struct netdev_bpf *bpf)
>  static int prueth_xsk_pool_enable(struct prueth_emac *emac,
>  				  struct xsk_buff_pool *pool, u16 queue_id)
>  {
> -	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
>  	u32 frame_size;
>  	int ret;
> =20
> @@ -1481,7 +1472,7 @@ static int prueth_xsk_pool_enable(struct prueth_ema=
c *emac,
>  	if (frame_size < PRUETH_MAX_PKT_SIZE)
>  		return -EOPNOTSUPP;
> =20
> -	ret =3D xsk_pool_dma_map(pool, rx_chn->dma_dev, PRUETH_RX_DMA_ATTR);
> +	ret =3D xsk_pool_dma_map(pool, emac->rx_chns.dma_dev, PRUETH_RX_DMA_ATT=
R);
>  	if (ret) {
>  		netdev_err(emac->ndev, "Failed to map XSK pool: %d\n", ret);
>  		return ret;
> @@ -1492,21 +1483,21 @@ static int prueth_xsk_pool_enable(struct prueth_e=
mac *emac,
>  		ret =3D icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>  		if (ret)
>  			return ret;
> -		prueth_destroy_rxq(emac);
> +		prueth_destroy_rxq(emac, queue_id);
>  	}
> =20
> -	emac->xsk_qid =3D queue_id;
> +	set_bit(queue_id, emac->xsk_queues);
>  	prueth_set_xsk_pool(emac, queue_id);
> =20
>  	if (netif_running(emac->ndev)) {
> -		ret =3D prueth_create_rxq(emac);
> +		ret =3D prueth_create_rxq(emac, queue_id);
>  		if (ret) {
>  			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
>  			return ret;
>  		}
>  		ret =3D icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
>  		if (ret) {
> -			prueth_destroy_rxq(emac);
> +			prueth_destroy_rxq(emac, queue_id);
>  			return ret;
>  		}
>  		ret =3D prueth_xsk_wakeup(emac->ndev, queue_id, XDP_WAKEUP_RX);

[Severity: Critical]
In prueth_xsk_pool_enable() and prueth_xsk_pool_disable(), queue_id is
checked against PRUETH_MAX_RX_FLOWS and emac->tx_ch_num, but not against
emac->rx_flow_num:

    if (queue_id >=3D PRUETH_MAX_RX_FLOWS ||
        queue_id >=3D emac->tx_ch_num)

If emac->tx_ch_num > emac->rx_flow_num (e.g. tx_ch_num =3D=3D 4 and
rx_flow_num =3D=3D 1) and an AF_XDP pool is bound to queue_id =3D=3D 1,
prueth_destroy_rxq(emac, 1) and prueth_create_rxq(emac, 1) will operate on
an uninitialized flows[1] (hanging in napi_disable() on an uninitialized
napi_struct and indexing past rx_chn->rx_chn->flows in
k3_udma_glue_reset_rx_chn()).

Also, if prueth_xsk_pool_enable() fails after xsk_pool_dma_map() or
set_bit(queue_id, emac->xsk_queues), does it need to unmap the pool and
clear the bit and xsk_pool pointers on the error path?

[ ... ]

> @@ -1594,9 +1586,9 @@ int prueth_xsk_wakeup(struct net_device *ndev, u32 =
qid, u32 flags)
>  {
>  	struct prueth_emac *emac =3D netdev_priv(ndev);
>  	struct prueth_tx_chn *tx_chn =3D &emac->tx_chns[qid];
> -	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
> +	struct prueth_rx_flow *rx_flow =3D &emac->rx_chns.flows[PRUETH_RX_FLOW_=
DATA];
> =20
> -	if (emac->xsk_qid !=3D qid) {
> +	if (!test_bit(qid, emac->xsk_queues)) {
>  		netdev_err(ndev, "XSK queue %d not registered\n", qid);
>  		return -EINVAL;
>  	}
> @@ -1611,7 +1603,7 @@ int prueth_xsk_wakeup(struct net_device *ndev, u32 =
qid, u32 flags)
>  		return -EINVAL;
>  	}
> =20
> -	if (!rx_chn->xsk_pool) {
> +	if (!rx_flow->xsk_pool) {
>  		netdev_err(ndev, "XSK pool not registered for RX queue %d\n", qid);
>  		return -EINVAL;
>  	}
> @@ -1624,9 +1616,9 @@ int prueth_xsk_wakeup(struct net_device *ndev, u32 =
qid, u32 flags)
>  	}
> =20
>  	if (flags & XDP_WAKEUP_RX) {
> -		if (!napi_if_scheduled_mark_missed(&emac->napi_rx)) {
> -			if (likely(napi_schedule_prep(&emac->napi_rx)))
> -				__napi_schedule(&emac->napi_rx);
> +		if (!napi_if_scheduled_mark_missed(&rx_flow->napi_rx)) {
> +			if (likely(napi_schedule_prep(&rx_flow->napi_rx)))
> +				__napi_schedule(&rx_flow->napi_rx);
>  		}
>  	}

[Severity: Critical]
In prueth_xsk_wakeup():

1. test_bit(qid, emac->xsk_queues) is called before checking whether
   qid >=3D PRUETH_MAX_RX_FLOWS, which can read out of bounds of the
   emac->xsk_queues bitmap if qid is out of range (and the bounds check
   itself also misses qid >=3D emac->rx_flow_num).

2. rx_flow is hardcoded to &emac->rx_chns.flows[PRUETH_RX_FLOW_DATA]
   instead of &emac->rx_chns.flows[qid], so XDP_WAKEUP_RX always checks and
   schedules flow 0's NAPI instead of flow qid's NAPI.

> @@ -1697,6 +1689,14 @@ static int prueth_netdev_init(struct prueth *pruet=
h,
>  	}
> =20
>  	emac->tx_ch_num =3D 1;
> +	emac->rx_flow_num =3D 1;
> +	emac->xsk_queues =3D devm_bitmap_zalloc(prueth->dev,
> +					      PRUETH_MAX_RX_FLOWS, GFP_KERNEL);
> +	if (!emac->xsk_queues) {
> +		dev_err(prueth->dev, "failed to allocate xsk_queues bitmap\n");
> +		ret =3D -ENOMEM;
> +		goto free_ndev;
> +	}

[Severity: Medium]
If devm_bitmap_zalloc() fails here in prueth_netdev_init(), jumping to
free_ndev skips pruss_release_mem_region(prueth->pruss, &emac->dram) at the
free: label. Should this jump to free instead so emac->dram is not leaked?

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/n=
et/ethernet/ti/icssg/icssg_prueth_sr1.c
> index b8115ca47082f..582d582cba89f 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -570,11 +570,11 @@ static int emac_ndo_open(struct net_device *ndev)
>  	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
> =20
>  	/* Prepare RX */
> -	ret =3D prueth_prepare_rx_chan(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZ=
E);
> +	ret =3D prueth_prepare_rx_flow(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZ=
E);
>  	if (ret)
>  		goto stop;
> =20
> -	ret =3D prueth_prepare_rx_chan(emac, &emac->rx_mgm_chn, 64);
> +	ret =3D prueth_prepare_rx_flow(emac, &emac->rx_mgm_chn, 64);
>  	if (ret)
>  		goto reset_rx_chn;

[Severity: High]
Does drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c still build when
CONFIG_TI_ICSSG_PRUETH_SR1 is enabled?

Here in emac_ndo_open(), prueth_prepare_rx_flow() is called with 3
arguments (passing struct prueth_rx_chn * as the second argument), whereas
its prototype in icssg_prueth.h is now:

    int prueth_prepare_rx_flow(struct prueth_emac *emac, int flow);

Elsewhere in icssg_prueth_sr1.c:
- prueth_process_rx_mgm() still accesses the removed rx_chn->pg_pool member
  and calls the 5-argument prueth_dma_rx_push_mapped() with 4 arguments.
- emac_ndo_open(), emac_ndo_stop(), and prueth_netdev_init() still access
  the removed emac->napi_rx, emac->rx_chns.irq, and emac->rx_mgm_chn.irq
  fields, and call prueth_init_rx_chns(), prueth_reset_rx_chan(), and
  prueth_cleanup_rx_chns() with their old argument lists.
- emac_ndo_open() passes emac as dev_id to request_irq(..., prueth_rx_irq,
  ..., emac), whereas prueth_rx_irq() now expects &rx_flow->napi_rx as
  dev_id.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103134501.4123=
194-1-m-malladi@ti.com?part=3D1
