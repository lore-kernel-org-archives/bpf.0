Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374066;
	b=2XhEnZ2cgRAiou1tStUg7SvG05Bm0EP1W+26ZjCDIuk924xI5Rp21OrmmuF/BxoGkmFu
	 v1fQ6JaMM2BGwJB4VUVpAS2pWH47Iej+Cmqf7nQS0KCHfmXXGLacAtn0pQ9hkYfNGZGFc
	 AKaXEclZ3Pq/AV7LQaYO2PSIjOkbIGlG8kLbcFTImSwuC/EtOz7W1qAFeW+B10EgnJ56n
	 3iAdV1Xgkc3Lj3EoTAlOUqAxBRhiw3tANzKBavJahwMcaUdy/lzmEKxxi+IW5ZI//U+kH
	 S9+3yC1RCp4Gc5xZR9BJTKctp6xkXRRghVco+hzk5T9baYqJMI3Got4QXLoSru7U6cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374066;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wM5ljIr3fHbUV8tPBfp4FntRM9UV1oJkI1ouHELbyrg=;
	b=2mRkI994S3nqYlFwwNUojWpzkpm+uzh4l92GCfoS1XXcT1Yepslx9RRNXdpNuraOWAka
	 UepQTSwzjBOqN/gHQmgdPRhCrK32DbgHCyztiysom2HqQaigO0A8m68ljhr/qZwQ6h33O
	 MYQsgj+0OquBt6WukiymFKgVticdnG5zrNayJTg/VEEbGBUffMaOSNRnWtt4MWMWTQP/P
	 0KTkWapk1C5VWadi69mN5miEY5nLGuXwBUNl6+IE4kx3bgZFgN7KGyxc6O4GIhKHJY19Q
	 QBopFPcujEFT96B/cVKLlFc9/cl/znxGXdi0nlCYZTmci+cHilSNslhUg46E0cp2QbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+RiBJ0m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F626606A320;
	Sun, 22 Nov 2026 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+RiBJ0m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891AB1F000C0;
	Sun, 22 Nov 2026 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795374065;
	bh=wM5ljIr3fHbUV8tPBfp4FntRM9UV1oJkI1ouHELbyrg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U+RiBJ0mZxN4yxqmxaJb+4eNBHwk+uC+9f0cVKE+sbKZqQXSt5jWpO7aywoOgqx94
	 2Esu7IKCokNnj8UoGpsqJvchVzSNAcdRFVyXOr822Y+bAkiqHjOzGO4Jfp/wCGP5HP
	 eJOfkI2Ui8aeHcc1YFXCGrIvMJ/lHFwMvoIiADr0hGuep3Mky4WX1yFX+brXB5b0eO
	 drPgZ7z7WpZ/4nkY2aN7ap6Zx6JrGcX+AFojqqb42zQOPrze5m8nX1VD4O4o155F7L
	 jvM8LX87AnXtFtxjAaSQK0J45NnV+xMZZJgrltEZh9SIrWhN/lDP3BBuGhx6GjlywL
	 yJL4IoCQBcclA==
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add multi-flow RX
 support with per-flow NAPI
From: netdev-bot+sashiko@kernel.org
To: m-malladi@ti.com
Cc: marco.crivellari@suse.com, kees+treewide@kernel.org,
 laixiangwu@cmss.chinamobile.com, philippe.schenker@impulsing.ch,
 haokexin@gmail.com, devnexen@gmail.com, horms@kernel.org,
 jacob.e.keller@intel.com, sdf@fomichev.me, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@kernel.org, davem@davemloft.net,
 andrew+netdev@lunn.ch, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 vigneshr@ti.com, danishanwar@ti.com
Date: Sun, 22 Nov 2026 19:01:04 +0000
Message-ID: <179537406410.3135.5804903978186343042@kernel.org>
In-Reply-To: <20261118184729.2302130-2-m-malladi@ti.com>
References: <20261118184729.2302130-2-m-malladi@ti.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 19 potential
issue(s) to consider.

Critical: 2 · High: 1 · Medium: 12 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] SR1 data RX path is out of bounds.
- [Critical] SR1 management-channel buffers get invalid DMA addresses.
- [High] On a running interface, a failed XSK enable/disable leaves the
  flow half torn down, and the next ndo_stop then hangs or the driver…
- [Medium] Multi-flow RX does not work on AM65x SR2 ('ti,am654-icssg-
  prueth'), which uses NAVSS UDMA rather than PKTDMA, but the driver…
- [Medium] SR1 management-channel teardown is incomplete compared with
  before the patch.
- [Medium] Misplaced error label in SR1 emac_ndo_open().
- [Medium] An AF_XDP pool bound while the interface is down silently
  stops working after ndo_open.
- [Medium] All flows share one desc_pool, and the XSK runtime refill
  budget comes from the pool-wide free count, which other CPUs change…
- [Medium] The SR1 data-flow page pool is never destroyed.
- [Medium] SR1 now gets an RX coalescing hrtimer but never cancels it.
- [Medium] prueth_xsk_pool_disable() can return an uninitialised value.
- [Medium] On a running interface, XSK enable/disable now reconfigures a
  single flow while the shared UDMA RX channel stays enabled.
- [Medium] Racy irq_disabled handling in prueth_destroy_rxq() and the
  prueth_create_rxq() error path.
- [Medium] RX drop and error counters can lose updates now that RX runs
  in several NAPIs at once.
- [Medium] A coalesce setting is not applied to RX flows added later.
- [Low] The ethtool channel range does not match what SR1 implements.
- [Low] In the SR1 mgm flow setup in emac_ndo_open(), the IRQ check is
  wrong for the signed field.
- [Low] Leftover field and mixed-in cleanups.
- [Low] net: ti: icssg: missing skb_record_rx_queue() in RX packet paths

--

net: ti: icssg-prueth: Add multi-flow RX support with per-flow NAPI

This patch extends the ICSSG driver to support up to 8 RX flows per EMAC.
Each flow has its own NAPI, hrtimer, page pool, XDP rxq, AF_XDP pool and
IRQ, and all flows share one UDMA channel and descriptor pool. The channel
lifecycle is split into per-flow create/destroy helpers, xsk_qid is
replaced with an xsk_queues bitmap, and SR1 is converted to the new
per-flow structures.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 4a7d1a6f470b1..6cd2a77c491ac 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -39,16 +39,10 @@
>  				 NETIF_MSG_HW | \
>  				 NETIF_MSG_WOL)
>  
> -#define prueth_napi_to_emac(napi) container_of(napi, struct prueth_emac, napi_rx)
>  
> -void prueth_cleanup_rx_chns(struct prueth_emac *emac,
> -			    struct prueth_rx_chn *rx_chn,
> -			    int max_rflows)
> +void prueth_cleanup_rx_chns(struct prueth_emac *emac)
>  {
> -	if (rx_chn->pg_pool) {
> -		page_pool_destroy(rx_chn->pg_pool);
> -		rx_chn->pg_pool = NULL;
> -	}
> +	struct prueth_rx_chn *rx_chn = &emac->rx_chns;

[Severity: Medium]
page_pool_destroy() has moved out of prueth_cleanup_rx_chns(). Which code
now destroys the SR1 data flow page pool?

The new destroy calls are in prueth_destroy_rxq() and the
prueth_create_rxq() error path, and only the SR2 driver calls those. SR1
emac_ndo_open() creates the pool with:

    prueth_prepare_rx_flow(emac, PRUETH_RX_FLOW_DATA_SR1)

which stores it in rx_chns.flows[3].pg_pool. SR1 emac_ndo_stop() and the
open error labels only call these:

- prueth_reset_rx_chan(), which covers flow 0 only.
- prueth_sr1_cleanup_rx_mgm_chn(), which covers the mgm flows only.
- prueth_cleanup_rx_chns(), which handles the desc pool and channel only.

Does this leak the page_pool and its posted pages on every SR1 close? The
same question applies to any open failure after prueth_prepare_rx_flow().

[ ... ]

> @@ -548,22 +594,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  		goto fail;
>  	}
>  
> -	pool = prueth_create_page_pool(emac, rx_chn->dma_dev, rx_chn->descs_num);
> -	if (IS_ERR(pool)) {
> -		ret = PTR_ERR(pool);
> -		goto fail;
> +	for (i = 0; i < rx_cfg.flow_id_num; i++) {
> +		flow = &rx_chn->flows[i];
> +		flow->pg_pool = NULL;
> +		flow->xsk_pool = NULL;
>  	}

[Severity: Medium]
Does clearing flow->xsk_pool here break an AF_XDP pool that was bound
while the interface was down?

When the interface is down, prueth_xsk_pool_enable() sets the xsk_queues
bit and calls prueth_set_xsk_pool(), which fills in rx_flow->xsk_pool and
tx_chn->xsk_pool. emac_ndo_open() then calls prueth_init_rx_chns(). That
clears xsk_pool for every flow without checking emac->xsk_queues, and
prueth_set_xsk_pool() is not called again on open.

The flow then comes up in page pool mode:

- prueth_xsk_wakeup() passes the test_bit() check but then fails with
  "XSK pool not registered for RX queue".
- prueth_xsk_pool_disable() still treats the queue as registered.

A down/up cycle causes the same mismatch, because prueth_cleanup_tx_chns()
memsets tx_chn while the bitmap bit stays set.

[ ... ]

> @@ -584,9 +622,14 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  				K3_UDMA_GLUE_SRC_TAG_LO_USE_REMOTE_SRC_TAG,
>  		};
>  
> +		flow = &rx_chn->flows[i];
> +		flow->emac = emac;
> +		flow->id = i;
> +		flow->irq = -EINVAL;
> +
>  		rx_flow_cfg.ring_rxfdq0_id = fdqring_id;
> -		rx_flow_cfg.rx_cfg.size = max_desc_num;
> -		rx_flow_cfg.rxfdq_cfg.size = max_desc_num;
> +		rx_flow_cfg.rx_cfg.size = PRUETH_MAX_RX_DESC;
> +		rx_flow_cfg.rxfdq_cfg.size = PRUETH_MAX_RX_DESC;
>  		rx_flow_cfg.rxfdq_cfg.mode = emac->prueth->pdata.fdqring_mode;

[Severity: Medium]
How does this work on AM65x SR2 (ti,am654-icssg-prueth)? That SoC uses
NAVSS UDMA rather than PKTDMA.

On non-PKTDMA, k3_udma_glue_request_rx_chn() sets single_fdq = true, and
k3_udma_glue_cfg_rx_flow() uses ring_rxfdq0_id as given. Here flows 1..N
are given flow 0's FDQ id, so all flows share one k3_ring. That ring is
configured once, by its first user, with PRUETH_MAX_RX_DESC (512) entries.

prueth_prepare_rx_flow() then pushes 512 buffers per flow, and flow 0
fills the shared ring. Wouldn't flow 1's first k3_ringacc_ring_push()
return -ENOMEM? prueth_create_rxqs() would then unwind, and ndo_open would
fail whenever rx_flow_num > 1.

The per-flow design also seems to assume each flow owns its FDQ, which
this hardware does not provide:

- k3_udma_glue_reset_rx_chn() skips the FDQ drain for flow_num != 0 when
  single_fdq is set. That contradicts the comment in prueth_destroy_rxq().
- UDMA can give any rflow a buffer from the shared FDQ, so swdata->flow_id
  and the per-flow page pool would no longer match.
- Concurrent per-flow NAPIs would push into one ring whose software state
  is updated without a lock.

emac_get_channels() still reports max_rx = ICSSG_MAX_RFLOWS on every SoC.
The only mention of this limitation is the changelog note below the "---"
("single_fdq=false on BCDMA/PKTDMA (AM64xx)"), which is dropped when the
patch is applied.

[ ... ]

> @@ -1022,13 +1081,13 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
>  	avail_desc = k3_cppi_desc_pool_avail(rx_chn->desc_pool);
>  	alloc_budget = min_t(int, budget, avail_desc);
>  
> -	ret = prueth_rx_alloc_zc(emac, alloc_budget);
> +	ret = prueth_rx_alloc_zc(emac, flow_id, alloc_budget);

[Severity: Medium]
All flows now share one desc_pool. Can this XSK refill take descriptors
that another flow needs?

The pool is sized exactly PRUETH_MAX_RX_DESC * rx_flow_num, and each flow
posts PRUETH_MAX_RX_DESC, so the free count is close to zero in steady
state. emac_rx_packet() frees the completed descriptor at requeue: and
only then allocates a new one in prueth_dma_rx_push_mapped():

CPU1 (page pool flow)              CPU2 (XSK flow)
emac_rx_packet()
  k3_cppi_desc_pool_free()
                                   emac_rx_packet_zc()
                                     avail_desc = 1
                                     prueth_rx_alloc_zc()
                                       k3_cppi_desc_pool_alloc()
  prueth_dma_rx_push_mapped()
    k3_cppi_desc_pool_alloc() fails
  WARN_ON(ret < 0)

The page pool flow then recycles the page and permanently loses one posted
RX buffer, because its refill is strictly 1:1 with completions. Could
repeated hits drain that flow?

The changelog says "XSK desc_avail not capped per-flow" was addressed.
However, only prueth_prepare_rx_flow() appears to have changed, not this
runtime refill.

[ ... ]

> @@ -1132,15 +1192,15 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
>  	skb->protocol = eth_type_trans(skb, ndev);
>  
>  	skb_mark_for_recycle(skb);
> -	napi_gro_receive(&emac->napi_rx, skb);
> +	napi_gro_receive(&emac->rx_chns.flows[flow_id].napi_rx, skb);
>  	ndev->stats.rx_bytes += pkt_len;
>  	ndev->stats.rx_packets++;
>  
>  requeue:
>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>  	/* queue another RX DMA */
> -	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
> -					PRUETH_MAX_PKT_SIZE);
> +	ret = prueth_dma_rx_push_mapped(emac, rx_chn, new_page,
> +					PRUETH_MAX_PKT_SIZE, flow_id);
>  	if (WARN_ON(ret < 0)) {
>  		page_pool_recycle_direct(pool, new_page);
>  		ndev->stats.rx_errors++;

[Severity: Low]
The netdev now exposes up to PRUETH_MAX_RX_FLOWS RX queues through
alloc_etherdev_mqs() and netif_set_real_num_rx_queues(). Shouldn't
the skbs also record which flow they arrived on?

Neither emac_rx_packet() nor emac_dispatch_skb_zc() calls
skb_record_rx_queue(skb, flow_id) before napi_gro_receive(). As a
result, skb_rx_queue_recorded() is false for every packet, whichever
flow received it.

This has two visible effects:

- get_rps_cpu() falls back to queue 0's rps_map and flow table, so
  RPS/RFS settings under queues/rx-N for N > 0 do nothing.
- sk_rx_queue_mapping is never set for sockets fed from these
  queues.

The point of the series is queue steering through set_rxnfc, so it
seems worth recording flow_id on both paths. That way the stack can
see which queue a packet was steered to.

[Severity: Medium]
Up to 8 per-flow NAPIs can now run at the same time on different CPUs.
Can these ndev->stats updates lose increments?

rx_bytes, rx_packets, rx_dropped and rx_errors are updated with plain
read-modify-write in emac_rx_packet(), emac_dispatch_skb_zc() and
emac_run_xdp(). Before this patch, a single RX NAPI serialized these
updates.

icssg_ndo_get_stats64() reports ndev->stats.rx_errors and rx_dropped to
userspace, so those values can be wrong.

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> index b715af21d23ac..68646cb7df442 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c

[ ... ]

> @@ -159,7 +160,7 @@ static void emac_get_channels(struct net_device *ndev,
>  {
>  	struct prueth_emac *emac = netdev_priv(ndev);
>  
> -	ch->max_rx = 1;
> +	ch->max_rx = ICSSG_MAX_RFLOWS;
>  	ch->max_tx = PRUETH_MAX_TX_QUEUES;
>  
>  	/* Disable multiple TX channels due to timeouts
> @@ -167,7 +168,7 @@ static void emac_get_channels(struct net_device *ndev,
>  	if (emac->is_sr1)
>  		ch->max_tx = 1;

[Severity: Low]
Should max_rx also be limited for SR1, as max_tx is?

SR1 allocates its netdev with alloc_etherdev_mq() (one RX queue), and
emac_ndo_open() in icssg_prueth_sr1.c hard-codes emac->rx_flow_num = 1.
emac_set_channels() still accepts and stores any rx_count up to 8 on SR1.
get_channels then reports that value until the next open silently resets
it.

Separately, the advertised maximum (ICSSG_MAX_RFLOWS) and the size used
for rx_chns.flows[] and alloc_etherdev_mqs() (PRUETH_MAX_RX_FLOWS) are two
independent constants that happen to both be 8.

[ ... ]

> @@ -264,7 +269,8 @@ static int emac_set_coalesce(struct net_device *ndev,
>  		coal->tx_coalesce_usecs = ICSSG_MIN_COALESCE_USECS;
>  	}
>  
> -	emac->rx_pace_timeout_ns = coal->rx_coalesce_usecs * 1000;
> +	for (i = 0; i < emac->rx_flow_num; i++)
> +		rx_chn->flows[i].rx_pace_timeout_ns = coal->rx_coalesce_usecs * 1000;
>  	tx_chn->tx_pace_timeout_ns = coal->tx_coalesce_usecs * 1000;

[Severity: Medium]
What happens to this setting when rx_flow_num is raised later?

This only programs the flows that exist when it is called, and
emac_get_coalesce() always reports flows[0]. Neither emac_set_channels()
nor ndo_open copies the value to new flows. For example:

    ethtool -C eth0 rx-usecs 100    (rx=1)
    ethtool -L eth0 rx 4            (link down)

This leaves flows 1..3 with rx_pace_timeout_ns == 0, so
icssg_napi_rx_poll() re-enables their IRQs immediately. ethtool -c still
reports 100us.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 9bb67e185a3ea..716f1b9195d67 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c

[ ... ]

> @@ -921,7 +866,43 @@ static void prueth_destroy_txq(struct prueth_emac *emac)
>  	}
>  }
>  
> -static void prueth_destroy_rxq(struct prueth_emac *emac)
> +static void prueth_destroy_rxq(struct prueth_emac *emac, int qid)
> +{
> +	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
> +	struct prueth_rx_flow *flow = &rx_chn->flows[qid];
> +	dma_addr_t desc_dma;
> +
> +	napi_disable(&flow->napi_rx);
> +	hrtimer_cancel(&flow->rx_hrtimer);
> +	if (flow->irq_disabled) {
> +		enable_irq(flow->irq);
> +		flow->irq_disabled = false;
> +	}

[Severity: Medium]
Can this race with prueth_rx_irq()?

The IRQ is level triggered. irq_disabled being true here usually means
completions are pending, so the line is likely still asserted:

process context                    hardirq
prueth_destroy_rxq()
  enable_irq(flow->irq)
                                   prueth_rx_irq()
                                     rx_flow->irq_disabled = true
                                     disable_irq_nosync(irq)
                                     napi_schedule() fails, NAPI disabled
  flow->irq_disabled = false

After prueth_create_rxq() calls napi_enable() again, icssg_napi_rx_poll()
and emac_rx_timer_callback() both see irq_disabled == false, so neither
calls enable_irq(). On the XSK disable path nothing else schedules this
flow's NAPI. Would the queue then stop receiving until the next
ifdown/ifup?

The prueth_create_rxq() error path has the same pattern. The changelog
says "IRQ left permanently disabled after hrtimer_cancel" was fixed, but
this race still seems able to leave the IRQ masked.

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
> +
> +	if (xdp_rxq_info_is_reg(&flow->xdp_rxq))
> +		xdp_rxq_info_unreg(&flow->xdp_rxq);
> +
> +	if (flow->pg_pool) {
> +		page_pool_destroy(flow->pg_pool);
> +		flow->pg_pool = NULL;
> +	}
> +}

[Severity: Medium]
Is it safe to call this from the XSK enable/disable paths while the shared
UDMA channel is still enabled?

Before this patch, prueth_xsk_pool_enable() and prueth_xsk_pool_disable()
did a full channel teardown:

- k3_udma_glue_tdown_rx_chn()
- wait for the TDCM
- reset the rings
- k3_udma_glue_disable_rx_chn()

Now they call this per-flow version. It resets one flow's FDQ and RXCQ and
destroys its page pool while the channel is still enabled and PSI-L paired
for the other flows.

The port-disable firmware command stops new frames from the wire, but it
does not flush frames already in flight. If a completion lands after the
drain loop, the RXCQ reset wipes it. That leaks its descriptor from the
shared desc_pool and leaves a page that is DMA-written after its pool was
destroyed.

The glue code notes that UDMA caches FDQ state. Descriptors that UDMA has
already fetched from the FDQ would also escape the drain.

Teardown on this hardware works per channel, not per rflow. Can a single
flow be quiesced safely this way?

[ ... ]

> @@ -1544,27 +1568,28 @@ static int prueth_xsk_pool_disable(struct prueth_emac *emac, u16 queue_id)
>  		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
>  		if (ret)
>  			return ret;
> -		prueth_destroy_rxq(emac);
> +		prueth_destroy_rxq(emac, queue_id);
>  	}
>  
>  	xsk_pool_dma_unmap(pool, PRUETH_RX_DMA_ATTR);
> -	emac->xsk_qid = -EINVAL;
> +	clear_bit(queue_id, emac->xsk_queues);
>  	prueth_set_xsk_pool(emac, queue_id);
>  
>  	if (netif_running(emac->ndev)) {
> -		ret = prueth_create_rxq(emac);
> -		if (ret) {
> -			netdev_err(emac->ndev, "Failed to create RX queue: %d\n", ret);
> -			return ret;
> -		}
> -		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
> -		if (ret) {
> -			prueth_destroy_rxq(emac);
> -			return ret;
> -		}
> +		ret = prueth_create_rxq(emac, queue_id);
> +		if (ret)
> +			netdev_err(emac->ndev, "Failed to recreate RX queue after XSK disable: %d\n",
> +				   ret);

[Severity: High]
If prueth_create_rxq() fails here, the flow stays destroyed with its NAPI
disabled while the interface is up. The prueth_create_rxq() error path
does not call napi_enable(), and the comment below says this failure is
expected on a transient descriptor shortage.

On the next ndo_stop, prueth_destroy_rxqs() calls prueth_destroy_rxq() for
every flow, so napi_disable() runs a second time on this NAPI:

emac_ndo_stop()
  prueth_destroy_rxqs()
    prueth_destroy_rxq(emac, queue_id)
      napi_disable(&flow->napi_rx)

NAPIF_STATE_SCHED stays set after the first disable. Does napi_disable()
then spin forever here while holding the netdev/rtnl lock? The create
failure path in prueth_xsk_pool_enable() leaves the flow in the same
state.

Some error paths in prueth_xsk_pool_enable() also look incomplete:

		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
		if (ret) {
			prueth_destroy_rxq(emac, queue_id);
			return ret;
		}

This path, and the prueth_xsk_wakeup() failure after it, return an error
without clearing the xsk_queues bit or resetting rx_flow->xsk_pool and
tx_chn->xsk_pool. The XSK core treats an ndo_bpf failure as a failed bind
and later frees the pool. Can NAPI or wakeup then use a freed
xsk_buff_pool? The FORWARD failure also leaves the flow destroyed, as
described above.

If the initial icssg_set_port_state(ICSSG_EMAC_PORT_DISABLE) fails, the
earlier xsk_pool_dma_map() is never undone.

The changelog lists "prueth_xsk_pool_enable/disable missing rx_flow_num
check+ error cleanup" as addressed. Only the create_rxq failure in the
enable path seems to have received cleanup.

> +
> +		/* Always re-enable port forwarding so the interface is not left
> +		 * permanently disabled if prueth_create_rxq() failed due to a
> +		 * transient descriptor shortage (inflight pages not yet returned
> +		 * by the network stack).
> +		 */
> +		icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
>  	}
>  
> -	return 0;
> +	return ret;
>  }

[Severity: Medium]
Can this return an uninitialized ret?

ret is only assigned inside the two netif_running() blocks. If the XSK
pool is unbound while the interface is down, both blocks are skipped. Stack
garbage is then returned to the XSK core, after the pool has already been
unmapped and the bit cleared.

Could this make xp_disable_drv_zc() WARN with "Failed to disable
zero-copy!" even though the disable succeeded?

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index df93d15c5b786..d54966730d102 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h

[ ... ]

> @@ -246,14 +251,11 @@ struct prueth_emac {
>  	u64 stats[ICSSG_NUM_MIIG_STATS];
>  	u64 pa_stats[ICSSG_NUM_PA_STATS];
>  
> -	/* RX IRQ Coalescing Related */
> -	struct hrtimer rx_hrtimer;
> -	unsigned long rx_pace_timeout_ns;
> -
>  	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
>  	struct bpf_prog *xdp_prog;
>  	struct xdp_attachment_info xdpi;
>  	int xsk_qid;
> +	unsigned long *xsk_queues;
>  };

[Severity: Low]
This isn't a bug, but struct prueth_emac still declares int xsk_qid even
though the xsk_queues bitmap has replaced all of its users.

Also, prueth_napi_to_rx_chn() returns a struct prueth_rx_flow, not a
struct prueth_rx_chn. That is a bit confusing now that prueth_rx_chn
contains the flows.

The patch also includes cleanups that the commit message does not mention:

- removing the PRUETH_MODULE_DESCRIPTION and ICSSG_CTRL_RGMII_ID_MODE
  defines
- moving PRUETH_MAX_TX_QUEUES into icssg_config.h
- dropping the prueth_create_xdp_rxqs()/prueth_destroy_xdp_rxqs() helpers

[ ... ]

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index 21a14b3bc889b..589b73be3ac60 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c

[ ... ]

> @@ -319,14 +319,104 @@ static struct page *prueth_process_rx_mgm(struct prueth_emac *emac,

[ ... ]

> +static int prueth_sr1_prepare_rx_mgm_flow(struct prueth_emac *emac, int flow, u32 buf_len)
> +{
> +	struct prueth_rx_flow *rx_flow;
> +	struct prueth_rx_chn *rx_chn;
> +	struct page_pool *pool;
> +	struct page *page;
> +	int desc_avail;
> +	int i, ret;
> +
> +	rx_chn = &emac->rx_mgm_chn;
> +	rx_flow = &rx_chn->flows[flow];
> +
> +	/* Initialize page pool for this flow - using simple page pool */
> +	pool = page_pool_create(&(struct page_pool_params){
> +		.order = 0,
> +		.pool_size = rx_chn->descs_num,
> +		.nid = NUMA_NO_NODE,
> +		.dev = rx_chn->dma_dev,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.max_len = PRUETH_MAX_PKT_SIZE,
> +	});

[Severity: Critical]
There is no PP_FLAG_DMA_MAP in .flags here. Are these pages ever
DMA-mapped?

prueth_dma_rx_push_mapped() programs the descriptor with:

	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;

A pool that doesn't map pages never sets the page's dma_addr, so it holds
0 or stale data. The device would then DMA firmware command responses and
TX timestamps to an arbitrary address.

prueth_process_rx_mgm() then calls dma_unmap_single() on that never-mapped
address and requeues more pages from the same pool.

Before this patch, rx_mgm_chn used prueth_create_page_pool(), which sets
PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV.

[ ... ]

> +static void prueth_sr1_cleanup_rx_mgm_chn(struct prueth_emac *emac)
> +{
> +	struct prueth_rx_flow *flow;
> +	int i;
> +
> +	for (i = 0; i < PRUETH_MAX_RX_MGM_FLOWS_SR1; i++) {
> +		flow = &emac->rx_mgm_chn.flows[i];
> +		if (flow->pg_pool) {
> +			page_pool_destroy(flow->pg_pool);
> +			flow->pg_pool = NULL;
> +		}
> +	}
> +
> +	if (emac->rx_mgm_chn.rx_chn) {
> +		k3_udma_glue_release_rx_chn(emac->rx_mgm_chn.rx_chn);
> +		emac->rx_mgm_chn.rx_chn = NULL;
> +	}
> +}
> +
> +static void prueth_sr1_reset_rx_mgm_chn(struct prueth_emac *emac, bool disable)
> +{
> +	struct prueth_rx_flow *flow;
> +	int i;
> +
> +	for (i = 0; i < PRUETH_MAX_RX_MGM_FLOWS_SR1; i++) {
> +		flow = &emac->rx_mgm_chn.flows[i];
> +		if (flow->irq <= 0)
> +			continue;
> +
> +		if (disable) {
> +			disable_irq(flow->irq);
> +			flow->irq_disabled = true;
> +		} else if (flow->irq_disabled) {
> +			enable_irq(flow->irq);
> +			flow->irq_disabled = false;
> +		}
> +	}
> +}

[Severity: Medium]
Does the mgm channel teardown lose steps compared to the old code?

Previously the stop and error paths called two helpers:

- prueth_reset_rx_chan(&emac->rx_mgm_chn, PRUETH_MAX_RX_MGM_FLOWS_SR1,
  true), which drained each mgm flow through prueth_rx_cleanup() and
  disabled the channel.
- prueth_cleanup_rx_chns(emac, &emac->rx_mgm_chn, ...), which destroyed
  the page pool and desc_pool and released the channel.

prueth_sr1_reset_rx_mgm_chn() now only toggles the mgm IRQs. It never
calls k3_udma_glue_reset_rx_chn() or k3_udma_glue_disable_rx_chn().
prueth_sr1_cleanup_rx_mgm_chn() then destroys the mgm page pools while
their pages are still posted in the FDQs, so those pages stay inflight
forever.

prueth_sr1_cleanup_rx_mgm_chn() also never calls
k3_cppi_desc_pool_destroy() on emac->rx_mgm_chn.desc_pool. Does this leak
the "rx_mgm_desc_pool" coherent DMA pool on every close, and on every open
failure after the pool is created?

The "Teardown RX MGM channel" comment in emac_ndo_stop() promises a reset
that this helper does not perform.

[ ... ]

> @@ -514,37 +610,116 @@ static int emac_ndo_open(struct net_device *ndev)
>  		return ret;
>  	}
>  
> -	max_rx_flows = PRUETH_MAX_RX_FLOWS_SR1;
> -	ret = prueth_init_rx_chns(emac, &emac->rx_chns, "rx",
> -				  max_rx_flows, PRUETH_MAX_RX_DESC);
> +	emac->rx_flow_num = 1;
> +	ret = prueth_init_rx_chns(emac);
>  	if (ret) {
>  		dev_err(dev, "failed to init rx channel: %d\n", ret);
>  		goto cleanup_tx;
>  	}

[Severity: Critical]
With rx_flow_num forced to 1 here, prueth_init_rx_chns() requests a
channel with flow_id_num = 1. The glue layer therefore allocates a
one-element rx_chn->flows[] array, and prueth_ndev_add_rx_napi() only
registers NAPI, hrtimer and IRQ for flows[0].

The rest of the SR1 path still uses PRUETH_RX_FLOW_DATA_SR1, which is 3:

emac_ndo_open()
  prueth_prepare_rx_flow(emac, PRUETH_RX_FLOW_DATA_SR1)
    prueth_dma_rx_push_mapped(..., 3)
      k3_udma_glue_push_rx_chn(rx_chn, 3, ...)
        flow = &rx_chn->flows[flow_num];
        k3_ringacc_ring_push(flow->ringrxfdq, &desc_dma)

Doesn't this read past the end of the glue flows[] array and then
dereference whatever ring pointer it finds there?

Even if that doesn't crash, emac_ndo_open() later calls:

	napi_enable(&emac->rx_chns.flows[PRUETH_RX_FLOW_DATA_SR1].napi_rx);

on a napi_struct that was never passed to netif_napi_add(), and
emac_ndo_stop() calls napi_disable() on the same struct. The registered
IRQ and poll loop serve flows[0], which has no buffers posted and no page
pool.

Before this patch, SR1 requested PRUETH_MAX_RX_FLOWS_SR1 (4) rflows, so
flow 3 existed. The commit message does not mention this SR1 change, and
the follow-up patch in the series does not seem to touch
icssg_prueth_sr1.c.

[ ... ]

> +		flow->irq = k3_udma_glue_rx_get_irq(emac->rx_mgm_chn.rx_chn, i);
> +		if (flow->irq == 0 || flow->irq > INT_MAX) {
> +			ret = flow->irq > INT_MAX ? -EINVAL : flow->irq;
> +			dev_err(dev, "Failed to get rx mgm dma irq");
> +			goto cleanup_rx_mgm_init;
> +		}

[Severity: Low]
struct prueth_rx_flow::irq is now a signed int. Can this check ever catch
a failure? flow->irq > INT_MAX is always false for an int, and
k3_udma_glue_rx_get_irq() returns -ENXIO on failure, never 0.

The negative errno is then passed to request_threaded_irq(), which fails
with -EINVAL and logs a misleading "unable to request RX Management RSP
IRQ" message. prueth_init_rx_chns() checks the same API correctly with
flow->irq <= 0.

[ ... ]

> @@ -612,27 +791,27 @@ static int emac_ndo_open(struct net_device *ndev)
>  	 */
>  	prueth_reset_tx_chan(emac, i, false);
>  reset_rx_mgm_chn:
> -	prueth_reset_rx_chan(&emac->rx_mgm_chn,
> -			     PRUETH_MAX_RX_MGM_FLOWS_SR1, true);
> +	prueth_sr1_reset_rx_mgm_chn(emac, true);
>  reset_rx_chn:
> -	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, false);
> +	prueth_reset_rx_chan(emac, false);
> +cleanup_rx_mgm_init:
> +	prueth_sr1_cleanup_rx_mgm_chn(emac);
>  stop:
>  	prueth_emac_stop(emac);
>  free_rx_mgmt_ts_irq:
> -	free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1],
> +	free_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1].irq,
>  		 emac);
>  free_rx_mgm_rsp_irq:
> -	free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_RESPONSE_SR1],
> +	free_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_RESPONSE_SR1].irq,
>  		 emac);
>  free_rx_irq:
> -	free_irq(emac->rx_chns.irq[rx_flow], emac);
> +	prueth_ndev_del_rx_napi(emac, 1);
>  cleanup_napi:
>  	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);

[Severity: Medium]
Is cleanup_rx_mgm_init in the right place?

The early mgm init failures jump here: desc pool creation,
k3_udma_glue_rx_flow_init() and the mgm IRQ lookup. All of them happen
before prueth_ndev_add_tx_napi(), prueth_ndev_add_rx_napi(), the two
request_threaded_irq() calls and prueth_emac_start().

Falling through from this label then does the following:

- prueth_emac_stop() on PRU/RTU cores that were never booted
- free_irq() on both mgm IRQs, which were never requested
- prueth_ndev_del_rx_napi(emac, 1) and prueth_ndev_del_tx_napi(), which
  free more IRQs that were never requested

Won't each of those free_irq() calls trigger a "Trying to free
already-free IRQ" warning?

On the later reset_rx_chn path, prueth_sr1_cleanup_rx_mgm_chn() releases
the mgm channel and sets rx_mgm_chn.rx_chn to NULL before the mgm ring
IRQs are freed. Can a threaded handler that runs in that window pop from a
NULL channel?

[ ... ]

> @@ -700,14 +875,14 @@ static int emac_ndo_stop(struct net_device *ndev)
>  	/* stop PRUs */
>  	prueth_emac_stop(emac);
>  
> -	free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1], emac);
> -	free_irq(emac->rx_mgm_chn.irq[PRUETH_RX_MGM_FLOW_RESPONSE_SR1], emac);
> -	free_irq(emac->rx_chns.irq[rx_flow], emac);
> +	free_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_TIMESTAMP_SR1].irq, emac);
> +	free_irq(emac->rx_mgm_chn.flows[PRUETH_RX_MGM_FLOW_RESPONSE_SR1].irq, emac);
> +	prueth_ndev_del_rx_napi(emac, 1);

[Severity: Medium]
Is the RX coalescing hrtimer ever cancelled on SR1?

SR1 now goes through prueth_ndev_add_rx_napi(), which sets up
flows[0].rx_hrtimer. The shared icssg_napi_rx_poll() starts that timer
when rx_pace_timeout_ns is non-zero, and SR1 can set that value through
emac_set_coalesce(). Unlike prueth_destroy_rxq() on SR2, nothing here
calls hrtimer_cancel() before flows[0].irq is freed.

Could a pending timer then run emac_rx_timer_callback() and call
enable_irq() on a freed IRQ? Could hrtimer_setup() re-initialize it on the
next open while it is still queued, or could the callback touch freed
memory after free_netdev()?

Today flows[0]'s NAPI is never enabled on SR1, because napi_enable()
targets flows[3]. So this only becomes reachable once that flow index
issue is fixed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118184729.2302130-1-m-malladi%40ti.com
