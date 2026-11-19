Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114244;
	b=x63eoGfKXSxfUHn+nBGm+5uq2rPDSOfRnd5zy9qjHdlenHcmlmlJ5ThNXBFrt6qgmDau
	 pIQc1JNdAsenGpd2Y1ki6iv6D3K8vY/CI7CQbPCnbA4myxSDRcvb3XlVSIkhn2r0PfLA0
	 +ZOMJXOw5jXBETq0Jl+fZbww9WBO2WoTo4cYXk1vaXZeihjGyhwkXS+NcaNIbCymH5Z4X
	 cDTf04pl9r57ynAA/AveLMKEmg8UfiRYYyT7LicWG6cGGuJ7uki1pHJZSLkTm3hIDElZj
	 pHfk8Sx5lSllKJrzla06pBNhFb8m6QxIN1mjCf4AGOekvZPW322zJ9DGKU4tHVdcXtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114244;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xz9wnfftTTYqppZNZ++JmZO1zbzS5tam4RaWf50ZDgo=;
	b=odrvK6P+nPoD0rRUBXlhimk18Nc2fFL1zdA28QIgSbFu94AjaxdG1cL8eZLoPU2JnXar
	 ekk015Uj7f52dXBuFqgByo0SMDu1e595cULGnVCh1q85P91qqwSydciZQdOG8agqgk0Ht
	 msduychF8vK3NATNkKdZsTGU4RXFVkRx+xtp/7Sov2aODLMtm7wHVOt88++ebBeIWgGXK
	 vzjXARH127xrKwrfdJSIQVP8YF/1D1phLFZhzxfgy4hqPC514WpX6ipy3NA6DOgXUt6wx
	 qtWG/AuHFIdI2V/Z1GsvWdSGETH5DHbZtVOl8hbWi63SoBegRoSA+8BHnj9iH5Y0RFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eGpJxi/M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF1606A32C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eGpJxi/M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD441F000C6;
	Thu, 19 Nov 2026 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114243;
	bh=Xz9wnfftTTYqppZNZ++JmZO1zbzS5tam4RaWf50ZDgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eGpJxi/MNi30NluQk/fiEjsWKaapwAjZfkTWTI8snxYpDc2R8AK+OWD46eyAnNlvZ
	 dbk3JzKIR7eTpjr5mViW3K5QeFqK6d9O3PQccn02pH6sP2uvC7PDma650UmVH0R0HA
	 9FcVIiHRi24SIAl6IHDQgTvhxDU3Q8RTwOBXmQhiwxcYxfhg0ZcYw1R+XekamYMCW4
	 +POS+N1MScDs5DnXmac+0S+Q4DPTvjdUDHjLkG04C/gpgGG5N9erdcBJxqx0Q3N6CS
	 mj76YkC6JjtJaD7s2oir7I3ha3Z2bzpPev8hZ8iWp7lT9q/343K2ymoGzES63LNfX2
	 i0bSOmqlbkBxQ==
Message-ID: <sashiko-outbox-223805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add multi-flow RX
 support with per-flow NAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Meghana Malladi" <m-malladi@ti.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261118184729.2302130-2-m-malladi@ti.com>
References: <20261118184729.2302130-1-m-malladi@ti.com>
 <20261118184729.2302130-2-m-malladi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:50:43 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential
issues to consider:
- [High] net: ti: icssg: shared FDQ overflow and broken per-flow reset
  on AM654
- [High] net: ti: icssg: NAPI double-disable hang and leaks in XSK pool
  enable/disable
- [High] net: ti: icssg: OOB flow index and uninitialized NAPI in SR1
  emac_ndo_open()
- [High] net: ti: icssg: broken DMA mapping, reset, and cleanup for SR1
  rx_mgm_chn
- [Medium] net: ti: icssg: uncapped desc_pool avail in
  emac_rx_packet_zc() overflows FDQ
- [Medium] net: ti: icssg: XSK pool state lost in prueth_init_rx_chns()
  and channel change
- [Medium] net: ti: icssg: invalid SR1 max_rx and uninitialized
  rx_flow_num in ethtool
- [Medium] net: ti: icssg: enable_irq() before RXCQ drain in
  prueth_destroy_rxq()
- [Low] net: ti: icssg: emac_set_coalesce() leaves inactive RX flows
  unconfigured
- [Low] net: ti: icssg: missing skb_record_rx_queue() in RX packet paths
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [Critical] net: ti: icssg-prueth: dangling pointers in
  prueth_cleanup_rx_chns() [1]
- [Critical] net: ti: icssg-prueth: invalid dma_unmap_single() in
  prueth_process_rx_mgm() [2]
--

commit 7f9ba334666f2704f197c0021554819e2e901c62
Author: Meghana Malladi <m-malladi@ti.com>

net: ti: icssg-prueth: Add multi-flow RX support with per-flow NAPI

This commit extends the ICSSG driver to support up to 8 RX flows per EMAC
with per-flow NAPI, hrtimer, page pool, XDP rxq, AF_XDP pool, and IRQ
state.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index 4a7d1a6f470b1..6cd2a77c491ac 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -39,16 +39,10 @@
>  				 NETIF_MSG_HW | \
>  				 NETIF_MSG_WOL)
> =20
> -#define prueth_napi_to_emac(napi) container_of(napi, struct prueth_emac,=
 napi_rx)
> =20
> -void prueth_cleanup_rx_chns(struct prueth_emac *emac,
> -			    struct prueth_rx_chn *rx_chn,
> -			    int max_rflows)
> +void prueth_cleanup_rx_chns(struct prueth_emac *emac)
>  {
> -	if (rx_chn->pg_pool) {
> -		page_pool_destroy(rx_chn->pg_pool);
> -		rx_chn->pg_pool =3D NULL;
> -	}
> +	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
> =20
>  	if (rx_chn->desc_pool)
>  		k3_cppi_desc_pool_destroy(rx_chn->desc_pool);

[Severity: Critical]
This problem wasn't introduced by this patch, but prueth_cleanup_rx_chns()
destroys rx_chn->desc_pool and releases rx_chn->rx_chn without clearing the=
ir
pointers [1].

If a subsequent emac_ndo_open() calls prueth_init_rx_chns() and
k3_udma_glue_request_rx_chn() fails before rx_chn->desc_pool is overwritten,
the fail path calls prueth_cleanup_rx_chns() again with the stale
rx_chn->desc_pool pointer and triggers a double free in
k3_cppi_desc_pool_destroy().

[ ... ]

> @@ -548,22 +594,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  		goto fail;
>  	}
> =20
> -	pool =3D prueth_create_page_pool(emac, rx_chn->dma_dev, rx_chn->descs_n=
um);
> -	if (IS_ERR(pool)) {
> -		ret =3D PTR_ERR(pool);
> -		goto fail;
> +	for (i =3D 0; i < rx_cfg.flow_id_num; i++) {
> +		flow =3D &rx_chn->flows[i];
> +		flow->pg_pool =3D NULL;
> +		flow->xsk_pool =3D NULL;
>  	}

[Severity: Medium]
Does clearing flow->xsk_pool here lose active AF_XDP pools across an
interface down/up cycle or system suspend/resume?

On stop, prueth_cleanup_tx_chns() zeroes tx_chn->xsk_pool, and on open this
loop zeroes flow->xsk_pool while emac->xsk_queues keeps the registered queue
bits set.  Because emac_ndo_open() never calls prueth_set_xsk_pool() before
prueth_create_rxqs(), prueth_create_rxq() falls back to creating a regular
page_pool and prueth_xsk_wakeup() fails with -EINVAL on the NULL xsk_pool
pointers.

In addition, if emac_set_channels() reduces rx_flow_num or tx_ch_num while
the interface is down, prueth_xsk_pool_disable() rejects queue_id >=3D
emac->rx_flow_num or queue_id >=3D emac->tx_ch_num with -EINVAL, leaving no=
 way
to unmap and unregister the pool on that queue.

> -
> -	rx_chn->pg_pool =3D pool;
> -
> -	flow_id_base =3D k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_chn);
> -	if (emac->is_sr1 && !strcmp(name, "rxmgm")) {
> -		emac->rx_mgm_flow_id_base =3D flow_id_base;
> -		netdev_dbg(ndev, "mgm flow id base =3D %d\n", flow_id_base);
> -	} else {
> -		emac->rx_flow_id_base =3D flow_id_base;
> -		netdev_dbg(ndev, "flow id base =3D %d\n", flow_id_base);
> -	}
> +	emac->rx_flow_id_base =3D k3_udma_glue_rx_get_flow_id_base(rx_chn->rx_c=
hn);
> +	netdev_dbg(ndev, "flow id base =3D %d\n", emac->rx_flow_id_base);
> =20
>  	fdqring_id =3D K3_RINGACC_RING_ID_ANY;
>  	for (i =3D 0; i < rx_cfg.flow_id_num; i++) {
> @@ -584,9 +622,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
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
Does configuring rx_flow_cfg.rxfdq_cfg.size to PRUETH_MAX_RX_DESC break
multi-flow RX on AM654 SR2.0 (ti,am654-icssg-prueth)?

Unlike AM642 PKTDMA, AM654 SR2.0 uses NavSS UDMAP where rx_chn->single_fdq =
is
true and all flows share flow 0's FDQ ring (via fdqring_id and
K3_RINGACC_RING_SHARED).  Because the shared FDQ ring is sized to
PRUETH_MAX_RX_DESC (512) instead of rx_chn->descs_num (512 * flow_id_num),
flow 0 fills all 512 slots in prueth_prepare_rx_flow() and flow 1
immediately fails with -ENOMEM in k3_udma_glue_push_rx_chn().

Because k3_udma_glue_reset_rx_chn() only drains a shared FDQ when
flow_num =3D=3D 0:

drivers/dma/ti/k3-udma-glue.c:k3_udma_glue_reset_rx_chn() {
    ...
	if (rx_chn->single_fdq && flow_num)
		goto do_reset;
    ...
}

per-flow resets on AM654 SR2.0 also break:
- prueth_create_rxqs() unwinds in reverse order (i > 0 before 0), destroying
  flows[i].pg_pool before flow 0 drains the shared FDQ, so
  prueth_rx_cleanup() sees pg_pool =3D=3D NULL and leaks the pages.
- prueth_destroy_rxqs() destroys flow 0 first, draining the shared FDQ and
  destroying flows[0].pg_pool while flows 1..N still have NAPI enabled and
  undrained completion rings.
- Single-flow teardown in prueth_xsk_pool_enable() and
  prueth_xsk_pool_disable() either drains the shared FDQ for all flows (when
  queue_id =3D=3D 0) or leaves queue_id's descriptors in the shared FDQ (wh=
en
  queue_id > 0).
- On RX, UDMAP pops descriptors from the shared FDQ in FIFO order regardless
  of which flow pushed them, while emac_rx_packet() syncs and recycles pages
  against rx_flow->pg_pool instead of rx_chn->flows[swdata->flow_id].pg_poo=
l.

[ ... ]

> @@ -1022,13 +1081,13 @@ static int emac_rx_packet_zc(struct prueth_emac *=
emac, u32 flow_id,
>  	avail_desc =3D k3_cppi_desc_pool_avail(rx_chn->desc_pool);
>  	alloc_budget =3D min_t(int, budget, avail_desc);
> =20
> -	ret =3D prueth_rx_alloc_zc(emac, alloc_budget);
> +	ret =3D prueth_rx_alloc_zc(emac, flow_id, alloc_budget);
> =20
> -	if (xsk_uses_need_wakeup(rx_chn->xsk_pool)) {
> +	if (xsk_uses_need_wakeup(rx_flow->xsk_pool)) {
>  		if (ret < alloc_budget)
> -			xsk_set_rx_need_wakeup(rx_chn->xsk_pool);
> +			xsk_set_rx_need_wakeup(rx_flow->xsk_pool);
>  		else
> -			xsk_clear_rx_need_wakeup(rx_chn->xsk_pool);
> +			xsk_clear_rx_need_wakeup(rx_flow->xsk_pool);
>  	}

[Severity: Medium]
Can deriving alloc_budget from k3_cppi_desc_pool_avail(rx_chn->desc_pool)
overflow flow_id's 512-entry FDQ ring or starve other RX flows?

rx_chn->desc_pool is shared across all flows (PRUETH_MAX_RX_DESC *
rx_flow_num descriptors), whereas each flow's FDQ ring holds at most
PRUETH_MAX_RX_DESC (512) descriptors.  If another flow has not allocated all
of its descriptors from rx_chn->desc_pool (for example, another XSK flow
whose fill ring had fewer than 512 buffers), avail_desc exceeds the free
slots in flow_id's FDQ ring.  When emac_rx_packet_zc() pops fewer than budg=
et
packets, prueth_rx_alloc_zc() tries to push more descriptors than flow_id's
FDQ ring can hold, failing in k3_udma_glue_push_rx_chn() with -ENOMEM,
freeing the popped xdp_buff, and falsely setting xsk_set_rx_need_wakeup().

[ ... ]

> @@ -1132,15 +1192,15 @@ static int emac_rx_packet(struct prueth_emac *ema=
c, u32 flow_id, u32 *xdp_state)
>  	skb->protocol =3D eth_type_trans(skb, ndev);
> =20
>  	skb_mark_for_recycle(skb);
> -	napi_gro_receive(&emac->napi_rx, skb);
> +	napi_gro_receive(&emac->rx_chns.flows[flow_id].napi_rx, skb);

[Severity: Low]
Should emac_rx_packet() and emac_dispatch_skb_zc() call
skb_record_rx_queue(skb, flow_id) before napi_gro_receive() so the stack
knows which RX queue received the packet?

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/=
ethernet/ti/icssg/icssg_ethtool.c
> index b715af21d23ac..68646cb7df442 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> @@ -159,7 +160,7 @@ static void emac_get_channels(struct net_device *ndev,
>  {
>  	struct prueth_emac *emac =3D netdev_priv(ndev);
> =20
> -	ch->max_rx =3D 1;
> +	ch->max_rx =3D ICSSG_MAX_RFLOWS;
>  	ch->max_tx =3D PRUETH_MAX_TX_QUEUES;
> =20
>  	/* Disable multiple TX channels due to timeouts
> @@ -167,7 +168,7 @@ static void emac_get_channels(struct net_device *ndev,
>  	if (emac->is_sr1)
>  		ch->max_tx =3D 1;
> =20
> -	ch->rx_count =3D 1;
> +	ch->rx_count =3D emac->rx_flow_num;

[Severity: Medium]
On SR1.0, doesn't emac_get_channels() report ch->rx_count =3D=3D 0 before t=
he
interface is opened and allow setting up to 8 RX channels even though SR1.0
only supports 1 RX queue?

In icssg_prueth_sr1.c, prueth_netdev_init() allocates ndev with a single RX
queue via alloc_etherdev_mq() and never initializes emac->rx_flow_num (which
is only set to 1 in emac_ndo_open()).  Capping ch->max_rx =3D 1 when
emac->is_sr1 is true and initializing emac->rx_flow_num =3D 1 in SR1.0's
prueth_netdev_init() would avoid this.  Also, struct prueth_emac in
icssg_prueth.h still retains the unused int xsk_qid field.

[ ... ]

> @@ -264,7 +269,8 @@ static int emac_set_coalesce(struct net_device *ndev,
>  		coal->tx_coalesce_usecs =3D ICSSG_MIN_COALESCE_USECS;
>  	}
> =20
> -	emac->rx_pace_timeout_ns =3D coal->rx_coalesce_usecs * 1000;
> +	for (i =3D 0; i < emac->rx_flow_num; i++)
> +		rx_chn->flows[i].rx_pace_timeout_ns =3D coal->rx_coalesce_usecs * 1000;

[Severity: Low]
If a user configures RX coalescing via emac_set_coalesce() and later
increases the number of RX flows via emac_set_channels(), won't the newly
enabled flows remain at rx_pace_timeout_ns =3D=3D 0 while emac_get_coalesce=
()
reports flow 0's timeout?  Looping over PRUETH_MAX_RX_FLOWS would keep all
flows consistent.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.c
> index 9bb67e185a3ea..716f1b9195d67 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c

[ ... ]

> @@ -921,7 +866,43 @@ static void prueth_destroy_txq(struct prueth_emac *e=
mac)
>  	}
>  }
> =20
> -static void prueth_destroy_rxq(struct prueth_emac *emac)
> +static void prueth_destroy_rxq(struct prueth_emac *emac, int qid)
> +{
> +	struct prueth_rx_chn *rx_chn =3D &emac->rx_chns;
> +	struct prueth_rx_flow *flow =3D &rx_chn->flows[qid];
> +	dma_addr_t desc_dma;
> +
> +	napi_disable(&flow->napi_rx);
> +	hrtimer_cancel(&flow->rx_hrtimer);
> +	if (flow->irq_disabled) {
> +		enable_irq(flow->irq);
> +		flow->irq_disabled =3D false;
> +	}
> +
> +	/* k3_udma_glue_reset_rx_chn() only drains the FDQ; it resets the
> +	 * completion ring (RXCQ) without freeing descriptors still in it.
> +	 * Teardown posts TDCM only to flow 0's RXCQ; flows 1..N have no
> +	 * NAPI trigger to drain their RXCQs. Drain each flow's RXCQ here
> +	 * so page_pool_destroy() finds no inflight pages.
> +	 */
> +	while (!k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, qid, &desc_dma)) {
> +		if (!cppi5_desc_is_tdcm(desc_dma))
> +			prueth_rx_cleanup(rx_chn, desc_dma);
> +	}
> +
> +	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, flow->id, rx_chn,
> +				  prueth_rx_cleanup);

[Severity: Medium]
Can calling enable_irq(flow->irq) before draining and resetting the RXCQ
leave flow->irq permanently disabled when a queue is recreated?

flow->irq is registered with IRQF_TRIGGER_HIGH and stays asserted while
descriptors remain in the RXCQ:

prueth_destroy_rxq()
  napi_disable(&flow->napi_rx)
  if (flow->irq_disabled)
    enable_irq(flow->irq)
      <hardirq>
        prueth_rx_irq()
          flow->irq_disabled =3D true
          disable_irq_nosync(flow->irq)
          napi_schedule(&flow->napi_rx)  <-- no-op (NAPIF_STATE_SCHED set)
    flow->irq_disabled =3D false           <-- clobbers true while IRQ is d=
isabled

The same sequence also exists in the err path of prueth_create_rxq(), and if
flow->irq was still enabled when napi_disable() returned, an IRQ arriving
before the RXCQ is drained will likewise disable flow->irq after the
flow->irq_disabled check has already run.  Draining and resetting the queue
before re-enabling the IRQ (and clearing flow->irq_disabled before
enable_irq()) would prevent this.

[ ... ]

> @@ -1492,21 +1512,24 @@ static int prueth_xsk_pool_enable(struct prueth_e=
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
> -		ret =3D prueth_create_rxq(emac, queue_id);
> +		ret =3D prueth_create_rxq(emac, queue_id);
>  		if (ret) {
>  			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
> +			clear_bit(queue_id, emac->xsk_queues);
> +			prueth_set_xsk_pool(emac, queue_id);
> +			xsk_pool_dma_unmap(pool, PRUETH_RX_DMA_ATTR);
>  			return ret;
>  		}
>  		ret =3D icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
>  		if (ret) {
> -			prueth_destroy_rxq(emac);
> +			prueth_destroy_rxq(emac, queue_id);
>  			return ret;
>  		}
>  		ret =3D prueth_xsk_wakeup(emac->ndev, queue_id, XDP_WAKEUP_RX);
> @@ -1523,12 +1546,13 @@ static int prueth_xsk_pool_disable(struct prueth_=
emac *emac, u16 queue_id)
>  	int ret;
> =20
>  	if (queue_id >=3D PRUETH_MAX_RX_FLOWS ||
> +	    queue_id >=3D emac->rx_flow_num ||
>  	    queue_id >=3D emac->tx_ch_num) {
>  		netdev_err(emac->ndev, "Invalid XSK queue ID %d\n", queue_id);
>  		return -EINVAL;
>  	}
> =20
> -	if (emac->xsk_qid !=3D queue_id) {
> +	if (!test_bit(queue_id, emac->xsk_queues)) {
>  		netdev_err(emac->ndev, "XSK queue ID %d not registered\n", queue_id);
>  		return -EINVAL;
>  	}
> @@ -1544,27 +1568,28 @@ static int prueth_xsk_pool_disable(struct prueth_=
emac *emac, u16 queue_id)
>  		ret =3D icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>  		if (ret)
>  			return ret;
> -		prueth_destroy_rxq(emac);
> +		prueth_destroy_rxq(emac, queue_id);
>  	}
> =20
>  	xsk_pool_dma_unmap(pool, PRUETH_RX_DMA_ATTR);
> -	emac->xsk_qid =3D -EINVAL;
> +	clear_bit(queue_id, emac->xsk_queues);
>  	prueth_set_xsk_pool(emac, queue_id);
> =20
>  	if (netif_running(emac->ndev)) {
> -		ret =3D prueth_create_rxq(emac);
> -		if (ret) {
> -			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
> -			return ret;
> -		}
> -		ret =3D icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
> -		if (ret) {
> -			prueth_destroy_rxq(emac);
> -			return ret;
> -		}
> +		ret =3D prueth_create_rxq(emac, queue_id);
> +		if (ret)
> +			netdev_err(emac->ndev, "Failed to recreate RX queue after XSK disable=
: %d\n",
> +				   ret);
> +
> +		/* Always re-enable port forwarding so the interface is not left
> +		 * permanently disabled if prueth_create_rxq() failed due to a
> +		 * transient descriptor shortage (inflight pages not yet returned
> +		 * by the network stack).
> +		 */
> +		icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
>  	}
> =20
> -	return 0;
> +	return ret;
>  }

[Severity: High]
If prueth_create_rxq() fails in prueth_xsk_pool_enable() or
prueth_xsk_pool_disable(), won't the next emac_ndo_stop() hang forever in
napi_disable()?

When the interface is running, prueth_destroy_rxq() calls
napi_disable(&flow->napi_rx), which sets NAPIF_STATE_SCHED.  If
prueth_create_rxq() then fails (for instance with -ENOSPC when inflight pag=
es
from the previous queue have not yet returned to rx_chn->desc_pool), it jum=
ps
to err before calling napi_enable(&flow->napi_rx).  The interface stays up
with flow->napi_rx disabled, so when emac_ndo_stop() -> prueth_destroy_rxqs=
()
later calls prueth_destroy_rxq() on that flow, napi_disable() is called a
second time and busy-waits forever for NAPIF_STATE_SCHED to clear.

In prueth_xsk_pool_enable(), the error paths also leave the port in
ICSSG_EMAC_PORT_DISABLE when prueth_create_rxq() fails, leak the
xsk_pool_dma_map() mapping if icssg_set_port_state(ICSSG_EMAC_PORT_DISABLE)
fails, and leave queue_id set in emac->xsk_queues with dangling xsk_pool
pointers and a leaked DMA mapping if
icssg_set_port_state(ICSSG_EMAC_PORT_FORWARD) fails.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/n=
et/ethernet/ti/icssg/icssg_prueth_sr1.c
> index 21a14b3bc889b..589b73be3ac60 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -306,7 +306,7 @@ static struct page *prueth_process_rx_mgm(struct prue=
th_emac *emac,
>  	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE=
);
>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
> =20
> -	new_page =3D page_pool_dev_alloc_pages(rx_chn->pg_pool);
> +	new_page =3D page_pool_dev_alloc_pages(rx_chn->flows[flow_id].pg_pool);

[Severity: Critical]
This problem wasn't introduced by this patch, but prueth_process_rx_mgm()
calls dma_unmap_single() on pages allocated from a page_pool [2].

The buffer was never mapped with dma_map_single() (and buf_dma is offset by
PRUETH_HEADROOM), so dma_unmap_single() corrupts DMA state; if
page_pool_dev_alloc_pages() fails, the unmapped page is pushed back to the =
RX
ring for hardware DMA.

>  	/* if allocation fails we drop the packet but push the
>  	 * descriptor back to the ring with old skb to prevent a stall
>  	 */
> @@ -319,14 +319,104 @@ static struct page *prueth_process_rx_mgm(struct p=
rueth_emac *emac,
>  	}
> =20
>  	/* queue another DMA */
> -	ret =3D prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
> -					PRUETH_MAX_PKT_SIZE);
> +	ret =3D prueth_dma_rx_push_mapped(emac, rx_chn, new_page,
> +					PRUETH_MAX_PKT_SIZE, flow_id);
>  	if (WARN_ON(ret < 0))
> -		page_pool_recycle_direct(rx_chn->pg_pool, new_page);
> +		page_pool_recycle_direct(rx_chn->flows[flow_id].pg_pool, new_page);
> =20
>  	return page;
>  }
> =20
> +/* SR1-specific helpers for rx_mgm_chn */
> +
> +static int prueth_sr1_prepare_rx_mgm_flow(struct prueth_emac *emac, int =
flow, u32 buf_len)
> +{
> +	struct prueth_rx_flow *rx_flow;
> +	struct prueth_rx_chn *rx_chn;
> +	struct page_pool *pool;
> +	struct page *page;
> +	int desc_avail;
> +	int i, ret;
> +
> +	rx_chn =3D &emac->rx_mgm_chn;
> +	rx_flow =3D &rx_chn->flows[flow];
> +
> +	/* Initialize page pool for this flow - using simple page pool */
> +	pool =3D page_pool_create(&(struct page_pool_params){
> +		.order =3D 0,
> +		.pool_size =3D rx_chn->descs_num,
> +		.nid =3D NUMA_NO_NODE,
> +		.dev =3D rx_chn->dma_dev,
> +		.dma_dir =3D DMA_FROM_DEVICE,
> +		.max_len =3D PRUETH_MAX_PKT_SIZE,
> +	});
> +
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
> +	for (i =3D 0; i < desc_avail; i++) {
> +		page =3D page_pool_dev_alloc_pages(rx_flow->pg_pool);
> +		if (!page)
> +			break;
> +
> +		ret =3D prueth_dma_rx_push_mapped(emac, rx_chn, page, buf_len, flow);
> +		if (ret < 0) {
> +			page_pool_recycle_direct(rx_flow->pg_pool, page);
> +			netdev_err(emac->ndev, "failed to push rx mgm buf %d\n", ret);
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void prueth_sr1_cleanup_rx_mgm_chn(struct prueth_emac *emac)
> +{
> +	struct prueth_rx_flow *flow;
> +	int i;
> +
> +	for (i =3D 0; i < PRUETH_MAX_RX_MGM_FLOWS_SR1; i++) {
> +		flow =3D &emac->rx_mgm_chn.flows[i];
> +		if (flow->pg_pool) {
> +			page_pool_destroy(flow->pg_pool);
> +			flow->pg_pool =3D NULL;
> +		}
> +	}
> +
> +	if (emac->rx_mgm_chn.rx_chn) {
> +		k3_udma_glue_release_rx_chn(emac->rx_mgm_chn.rx_chn);
> +		emac->rx_mgm_chn.rx_chn =3D NULL;
> +	}
> +}
> +
> +static void prueth_sr1_reset_rx_mgm_chn(struct prueth_emac *emac, bool d=
isable)
> +{
> +	struct prueth_rx_flow *flow;
> +	int i;
> +
> +	for (i =3D 0; i < PRUETH_MAX_RX_MGM_FLOWS_SR1; i++) {
> +		flow =3D &emac->rx_mgm_chn.flows[i];
> +		if (flow->irq <=3D 0)
> +			continue;
> +
> +		if (disable) {
> +			disable_irq(flow->irq);
> +			flow->irq_disabled =3D true;
> +		} else if (flow->irq_disabled) {
> +			enable_irq(flow->irq);
> +			flow->irq_disabled =3D false;
> +		}
> +	}
> +}

[Severity: High]
Does prueth_sr1_prepare_rx_mgm_flow() push unmapped DMA address 0x40 to the
hardware descriptors?

page_pool_create() is called without PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
so page_pool_get_dma_addr(page) returns 0 and prueth_dma_rx_push_mapped()
attaches buf_dma =3D 0 + PRUETH_HEADROOM (0x40) to the descriptor.

There are several additional regressions in the SR1 management channel
handling:
- prueth_sr1_prepare_rx_mgm_flow() checks desc_avail < PRUETH_MAX_RX_DESC
  (16 < 512, which always warns) and loops i < desc_avail (16) instead of
  PRUETH_MAX_RX_MGM_DESC_SR1 (8), overflowing flow 0's 8-entry ring and
  leaving no descriptors for flow 1.
- In emac_ndo_open(), rx_flow_cfg.ring_rxfdq0_id is hardcoded to
  K3_RINGACC_RING_ID_ANY for every management flow instead of passing flow
  0's FDQ ring ID to flow 1 on UDMAP.
- In emac_ndo_open(), flow->irq is a signed int, so
  if (flow->irq =3D=3D 0 || flow->irq > INT_MAX) misses negative error code=
s from
  k3_udma_glue_rx_get_irq() and sets ret =3D 0 when flow->irq =3D=3D 0.
- prueth_sr1_reset_rx_mgm_chn() only toggles IRQs instead of calling
  k3_udma_glue_reset_rx_chn(..., prueth_rx_cleanup) and
  k3_udma_glue_disable_rx_chn(), so management descriptors and pages are
  never drained before page_pool_destroy().
- prueth_sr1_cleanup_rx_mgm_chn() never calls
  k3_cppi_desc_pool_destroy(emac->rx_mgm_chn.desc_pool), leaking the
  management descriptor pool.
- In emac_ndo_open(), cleanup_rx_mgm_init is placed above stop:, so failures
  during rx_mgm_chn setup call prueth_emac_stop(), free_irq(), and
  prueth_ndev_del_rx_napi() / prueth_ndev_del_tx_napi() before those
  resources are initialized, and call prueth_sr1_cleanup_rx_mgm_chn() twice.

[ ... ]

> @@ -514,37 +610,116 @@ static int emac_ndo_open(struct net_device *ndev)
>  		return ret;
>  	}
> =20
> -	max_rx_flows =3D PRUETH_MAX_RX_FLOWS_SR1;
> -	ret =3D prueth_init_rx_chns(emac, &emac->rx_chns, "rx",
> -				  max_rx_flows, PRUETH_MAX_RX_DESC);
> +	emac->rx_flow_num =3D 1;
> +	ret =3D prueth_init_rx_chns(emac);

[ ... ]

> @@ -570,11 +745,15 @@ static int emac_ndo_open(struct net_device *ndev)
>  	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
> =20
>  	/* Prepare RX */
> -	ret =3D prueth_prepare_rx_chan(emac, &emac->rx_chns, PRUETH_MAX_PKT_SIZ=
E);
> +	ret =3D prueth_prepare_rx_flow(emac, PRUETH_RX_FLOW_DATA_SR1);
>  	if (ret)
>  		goto stop;
> =20
> -	ret =3D prueth_prepare_rx_chan(emac, &emac->rx_mgm_chn, 64);
> +	ret =3D prueth_sr1_prepare_rx_mgm_flow(emac, PRUETH_RX_MGM_FLOW_RESPONS=
E_SR1, 64);
> +	if (ret)
> +		goto reset_rx_chn;
> +
> +	ret =3D prueth_sr1_prepare_rx_mgm_flow(emac, PRUETH_RX_MGM_FLOW_TIMESTA=
MP_SR1, 64);
>  	if (ret)
>  		goto reset_rx_chn;
> =20
> @@ -595,7 +774,7 @@ static int emac_ndo_open(struct net_device *ndev)
>  	/* Enable NAPI in Tx and Rx direction */
>  	for (i =3D 0; i < emac->tx_ch_num; i++)
>  		napi_enable(&emac->tx_chns[i].napi_tx);
> -	napi_enable(&emac->napi_rx);
> +	napi_enable(&emac->rx_chns.flows[PRUETH_RX_FLOW_DATA_SR1].napi_rx);

[Severity: High]
Doesn't passing PRUETH_RX_FLOW_DATA_SR1 (3) here access out of bounds in
k3_udma_glue_push_rx_chn() and call napi_enable() on an uninitialized
napi_struct?

emac_ndo_open() sets emac->rx_flow_num =3D 1, so prueth_init_rx_chns() only
allocates 1 flow (index 0) in rx_chn->rx_chn->flows and
prueth_ndev_add_rx_napi() only initializes emac->rx_chns.flows[0].napi_rx.
Calling prueth_prepare_rx_flow(emac, PRUETH_RX_FLOW_DATA_SR1) then indexes
flow 3 in the 1-element UDMA channel flow array, and napi_enable() /
napi_disable() operate on flows[3].napi_rx (where dev is NULL), crashing on
open while flows[0].napi_rx stays disabled.

Also, because page_pool_destroy() was removed from prueth_cleanup_rx_chns(),
neither emac_ndo_stop() nor the open error path in icssg_prueth_sr1.c
destroys emac->rx_chns.flows[].pg_pool, leaking the data RX page pool.

[1] https://sashiko.dev/#/bug/linux-c1c04236-d320-4b5d-9640-11b78b923fbc
[2] https://sashiko.dev/#/bug/linux-925eaf98-fa4b-478a-8a96-afcb47316f81

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118184729.2302=
130-1-m-malladi@ti.com?part=3D1
