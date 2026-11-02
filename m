Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609630;
	b=0A4FDjwTqUD794aQ0VD/9iYNd87EHkSENJCNO1uU8NsNWapmsbqtvVlDFvoNpDDMvTj3
	 vCvdQHhdHYQqMS/s1DaYnWKrvP2KK/Enw4BilY5jZqoMzJ4ntDGGHfeVyd08BKtze7jP/
	 KPa4ljbuzOUXsDALlOrrfpB1ZCkm0gPCvKxKRV2iOGTgaByqOZc4wBcOD7yHY8TSBXpsM
	 qTiD3/ipEBvOkacP2YZmo0f/o+l0joVx1B1d7VtcoNC5EER/U2MFRi6t70Ar7e99zcw8y
	 y3kce63JJHrxEf/cH3//jq2WCPoMa1LxxKPgb1880fC1TFb93CnI8l3ePJ3tcbqpBug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609630;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=Tupbzvx4VkKzIlj8hM3jEDvpvxLK2n9OwH+R3BnYryg=;
	b=jZlmP8MOTCwv0YDQ2Vjn4rYwmu/Sum02d/xeY+xaWlYrAfwEofKeTOQN4bMNJQKRZkSt
	 qHDxaP7142lPTQJEwr54P3+OpKT4/56tslpaQu06uh7O0jklXF5wEF86ON2GAkh2uu9Np
	 afb/Q7E2pypKtlET7FcDhLDWmQRcqcXm8HB2cBmN4i5fZBYQipNrOFlvsvYPEJn68vfuM
	 xaNzLtPZagv6pdKAkdLA0dXa1Ra91U9LYPcgM9YrFF+fAwUjPs/U/QAVgETQDnnJtqDS1
	 Jnc/7xNdYs0TlslhVIU6LdUFHI6KUB8RwnvOel84YcpIlrZuvhCFMR1mFSjYIrh4AUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=xxlpOj9D;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF2606A326;
	Mon,  2 Nov 2026 08:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=xxlpOj9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793609629; x=1825145629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8QAClhMDGss4VRpG0qd8RvKwAum8v/xYsu3E2qScQZg=;
  b=xxlpOj9DeeSso1HsMWN8FEcdlbXA5XUn9ejZDAAk6B0YnKTZTVYeHf6m
   Hq03CNzgqv4QIyLMFWHQKbxSevo++ZoDLraQtqXojNAkkNQfb4+0DZ2Lq
   mmAD1reI4JVcBnOp6UMcr52rF278dtuB2KMvPVoAkf8EIeTN//fpbv2dA
   zw4ghABUga+//5f6dZ5FXDVOfT89mgphVSoOEUAD2g+gX6GZlExn3JxtX
   Aj/8N1jvdu5LZ4j4qUHr7hjy2kZf9W/LetoApL5G0oaoq7+SoSrLwFnCt
   RB+ym0SAIlWMqpG2viD5wlwE5mfPzUqiDTULPyXBO4Mx+q7LwZgJrOQW3
   w==;
X-CSE-ConnectionGUID: vaCC1SBATlqPHVLQLR5a7Q==
X-CSE-MsgGUID: 55cphz5uTJS2AXRo/JsVYg==
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="64906431"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 01:53:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 2 Nov 2026 01:53:42 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 2 Nov 2026 01:53:39 -0700
Date: Mon, 2 Nov 2026 09:53:39 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <horatiu.vultur@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: lan966x: don't free XDP buffers in fdma tx
 clear with budget 0
Message-ID: <20261102085339.ixdqujaly75yldp7@DEN-DL-M70577.microsemi.net>
References: <20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c@microchip.com>
 <179339596952.3131.4206946876532380801@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179339596952.3131.4206946876532380801@kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch adds a skip to lan966x_fdma_tx_clear_buf()
>   (drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c, line 359): `if…
> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but
>   lan966x_fdma_reload()…
> - [Medium] This problem wasn't introduced by this patch, but
>   lan966x_fdma_deinit()…
> 
> --
> 
> net: lan966x: don't free XDP buffers in fdma tx clear with budget 0
> 
> This patch makes lan966x_fdma_tx_clear_buf() skip completed XDP_TX and
> ndo_xdp_xmit DCBs when netpoll calls it with a budget of 0. That way the
> page pool and XDP return APIs are not called with hardirqs disabled. The
> skipped buffers are left for the next NAPI poll, and skbs are still freed
> via napi_consume_skb().
> 
> > diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > index 21668bbcc9063..1fbe910c5ec38 100644
> > --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> > @@ -353,6 +353,12 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
> >               if (!fdma_db_is_done(db))
> >                       continue;
> >
> > +             /* XDP and page pool APIs can't be used with a budget of 0.
> > +              * Leave these buffers for the next NAPI poll.
> > +              */
> > +             if (!weight && !dcb_buf->use_skb)
> > +                     continue;
> 
> [Severity: Medium]
> Can this starve netconsole transmits on the port that owns the FDMA NAPI?
> 
> skbs and XDP frames get slots from the same ring through
> lan966x_fdma_get_next_dcb(), which only checks the used bit:
> 
> lan966x_fdma_get_next_dcb() {
>         ...
>                 if (!dcb_buf->used &&
>                     !fdma_is_last(&tx->fdma, &tx->fdma.dcbs[i]))
>                         return i;
>         ...
> }
> 
> If heavy XDP_TX or ndo_xdp_xmit traffic fills every usable slot, a
> netpoll skb ends up here in lan966x_fdma_xmit():
> 
>         next_to_use = lan966x_fdma_get_next_dcb(tx);
>         if (next_to_use < 0) {
>                 netif_stop_queue(dev);
>                 return NETDEV_TX_BUSY;
>         }
> 
> __netpoll_send_skb() then polls between retries:
> 
> netpoll_poll_dev()->poll_one_napi()->napi->poll(napi, 0)
>   ->lan966x_fdma_tx_clear_buf(lan966x, 0)
> 
> With the new check, every completed XDP DCB is skipped. No slot is freed,
> clear stays false, and lan966x_fdma_wakeup_netdev() is never called.
> 
> Once the retries run out, the skb is put on npinfo->txq and handed to
> delayed work, and later messages queue behind it. In normal operation a
> later IRQ-driven NAPI poll frees the DCBs and output only comes late.
> 
> During a panic, with the other CPUs stopped and hardirqs off, would that
> work ever run? If not, the netconsole output is lost.
> 
> Before this patch, the budget-0 poll freed those slots, so netpoll could
> make progress.

Seems right, however, AFAICT, this is only an issue if the panic hits while the
ring is completely full of finished XDP frames. Freeing those frames from
netpoll is what napi.rst forbids: with a budget of 0 the driver cannot call any
XDP or page pool APIs, and doing so is the splat this patch fixes.

The only other way I see is to give XDP its own FDMA injection channel, so XDP
frames can never take the slots netpoll needs. lan966x has free injection
channels for that, but it is a rework for net-next, not a fix for net.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can XDP_TX pages that TX
> DCBs still hold end up in the wrong page_pool when lan966x_fdma_reload()
> replaces the RX pool?
> 
> lan966x_fdma_reload() does:
> 
>         napi_synchronize(&lan966x->napi);
>         napi_disable(&lan966x->napi);
>         ...
>         err = lan966x_fdma_rx_alloc(&lan966x->rx);
>         ...
>         page_pool_destroy(page_pool);
> 
>         lan966x_fdma_wakeup_netdev(lan966x);
>         napi_enable(&lan966x->napi);
> 
> It never walks tx->dcbs_buf[]. Suppose an XDP_TX DCB posted by the last
> poll completes in hardware after napi_disable(). The FDMA IRQ's
> napi_schedule() then does nothing, and the DCB stays used.
> 
> The first poll after napi_enable() then runs this in
> lan966x_fdma_tx_clear_buf():
> 
>         page_pool_recycle_direct(rx->page_pool,
>                                  dcb_buf->data.page);
> 
> At that point rx->page_pool is the new pool. __page_pool_put_page() does
> not check which pool owns the page. So the old pool's page, with its old
> DMA mapping and order, goes into the new pool's cache.
> 
> If the MTU change raised page_order, could the new pool give this smaller
> page to the RX ring? There db_size is PAGE_SIZE << new_order, so the
> device could DMA a large frame past the end of the page.
> 
> Even if the order stays the same, the old pool's inflight count would
> never reach zero, so its shutdown stalls and the pool is leaked. And
> wouldn't the new pool's inflight count go negative when it is destroyed?
> 
> This can happen on these paths while XDP_TX traffic is flowing:
> 
> lan966x_port_change_mtu()->lan966x_fdma_change_mtu()
>   ->__lan966x_fdma_reload()->lan966x_fdma_reload()
> 
> lan966x_xdp_setup()->lan966x_fdma_reload_page_pool()
>   ->__lan966x_fdma_reload()->lan966x_fdma_reload()
> 
> This patch doesn't widen the window much. An IRQ-driven NAPI poll still
> reclaims those DCBs if it runs before napi_disable().
> 
> [Severity: Medium]
> This is a pre-existing issue, but does lan966x_fdma_deinit() leak the TX
> DCBs that are still marked used?
> 
> lan966x_fdma_deinit() {
>         ...
>         napi_synchronize(&lan966x->napi);
>         napi_disable(&lan966x->napi);
> 
>         lan966x_fdma_rx_free_pages(&lan966x->rx);
>         fdma_free_coherent(lan966x->dma_dev, &lan966x->rx.fdma);
>         page_pool_destroy(lan966x->rx.page_pool);
>         lan966x_fdma_tx_free(&lan966x->tx);
> }
> 
> lan966x_fdma_tx_free() only does:
> 
>         kfree(tx->dcbs_buf);
>         fdma_free_coherent(lan966x->dma_dev, &tx->fdma);
> 
> Entries that are still used are never released:
> 
> - skb and xdp_ndo buffers stay DMA-mapped
> - skbs are not consumed
> - xdp_frames are not returned
> - XDP_TX pages are not returned to the page pool
> 
> Those pages keep the destroyed pool inflight, so its shutdown stalls.
> 
> lan966x_remove() and the probe error path both call fdma_deinit() before
> lan966x_cleanup_ports(). After napi_disable() no poll can reclaim these
> entries.
> 
> This patch adds completed but deferred XDP buffers to what can still be
> outstanding here. The window is narrow, because an IRQ-driven poll
> normally frees them before napi_disable().
> 
> --
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-lan966x-fdma-tx-clear-budget-v1-1-38c52d7aab8c%40microchip.com
