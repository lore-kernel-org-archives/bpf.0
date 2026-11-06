Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943578;
	b=FPgDbZjIsQpCG279ClyaFH7D1O8XnMaR5LZRPc775Sc0JpDZmJuUnKbrDDoXIv2eOwTX
	 /ISpXXOU6D1jdh20EhtPCHV7AD1PRF9sZAskD0d2y0s1wCEBfSwGTU2FfA+VKrse7jii2
	 tOj3DNh+nAKKTl5RN5KacIi7cxVrfR0kfhLsZKSvMExkyf49+3m+N+LkISe+xt9jtkAii
	 LB58y1b/lwGb77wA2fVW8CAQrvcuZjalw3HfPz7fBVMtvUWDHDqf9KrSWHF3i02Njsdha
	 rIKiRfh1A92dUk5gDL64QawldwCl6VWCUB/0cJiBT1wsJ+q4NdiNvi5PQQlrbkyEKgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943578;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8CE16VgOzS/UeofFCEt7QqyWHkHYBnYdAKh1yJWY6qE=;
	b=WsGwZYV6bSkq/DChvyLyDV77F12wF4DBSNcywgt3s4SOVX8IP4/IEo6lXRFtiKnl03pg
	 6TeW2ZFDIv46Q7WnsYxP0ev7UkrnwosdgsTr1cBn4D8D5igbMBLay7dclp/JwqHt2igkj
	 S2lJCs6If1VmrP0M6kYS+7igDN4jy6HhCelQShI7pHPfvBIJFdjFi+F/phoTRq7AvQ9oY
	 BaR44AAiXZmITZFT9X1jehNeWm9/+gRF3AxEbx5lzfMusN/tGt6QvnYWBn6owQp4p0LeP
	 qwB86r97dUdgvkgJ5kgI6RLmxSb+fAIgHC1r71cgdjoLwO4BzumexhsGXZ+l9ck/nNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKJ6qb71;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E119606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WKJ6qb71
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98B91F0089F;
	Fri,  6 Nov 2026 05:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943578;
	bh=8CE16VgOzS/UeofFCEt7QqyWHkHYBnYdAKh1yJWY6qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WKJ6qb71/vKKsL//yiejUeo+lTdTHem1+6Nri8kznmdCl3r4xMcPDRwISdgapfKRw
	 KtL0EkyZ+nK7ebNwO53PGoo5TbEUEeKfCDo8YkMQFMYfJmHju9S5RTHvq8YbGlIyyT
	 6AFypyPP7I+IOtGT0Ay85nG2ifMIYl2yl0etskJAmrdhCkQ1VfTO8z2mKPkFQm7MrA
	 jtoKYZQHlbpkyPgUpQdhTLvo7agvFWfr0sYwdMcdaZaY45j4nJ7dnKY/xvDI+VkXTQ
	 gwgnx74fVxf3dMFcc24DBISGg/4DnPrtan5q3IkHINeVqRy1AYtQksUjslC6Ny24FT
	 HlzQeqtfrNdpg==
Message-ID: <sashiko-outbox-200841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: stmmac: Disable queues before
 netif_tx_disable in xdp_release
Reply-To: sashiko-reviews@lists.linux.dev
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20261105053916.22353-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20261105053916.22353-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:39:36 +0000
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
- [Critical] net: stmmac: race between stmmac_tx_timer_arm() and
  hrtimer_cancel()
- [Medium] net: stmmac: live xmit and shrunk DMA drain window in
  stmmac_xdp_release()
--

commit 55148e7152341ae5e169618b10fed6a75cae5332
Author: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

net: stmmac: Disable queues before netif_tx_disable in xdp_release

This commit moves netif_tx_disable() after stmmac_disable_all_queues() and
hrtimer_cancel() in stmmac_xdp_release() to prevent a NAPI TX completion fr=
om
waking a stopped TX queue during XDP ring teardown.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7ffed295eb14a..7d1497392b8b5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7264,15 +7264,15 @@ void stmmac_xdp_release(struct net_device *dev)
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	u8 chan;
> =20
> -	/* Ensure tx function is not running */
> -	netif_tx_disable(dev);
> -
>  	/* Disable NAPI process */
>  	stmmac_disable_all_queues(priv);
> =20
>  	for (chan =3D 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> =20
> +	/* Ensure tx function is not running */
> +	netif_tx_disable(dev);

[Severity: Critical]
As reported by Sashiko on v1 [1], can moving netif_tx_disable(dev) after
hrtimer_cancel() allow an in-flight stmmac_xmit() or stmmac_tso_xmit() to
re-arm tx_q->txtimer after hrtimer_cancel() has already returned?

In drivers/net/ethernet/stmicro/stmmac/stmmac_main.c, stmmac_tx_timer_arm()
checks !napi_is_scheduled(napi) without synchronization against
napi_disable():

    if (unlikely(!napi_is_scheduled(napi))) {
            if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
                    hrtimer_start(&tx_q->txtimer,
                                  STMMAC_COAL_TIMER(tx_coal_timer),
                                  HRTIMER_MODE_REL);

When stmmac_xdp_set_prog() calls stmmac_xdp_release() on a running interfac=
e,
an in-flight transmit holding __netif_tx_lock on another CPU can evaluate
!napi_is_scheduled(napi) as true just before stmmac_disable_all_queues() se=
ts
NAPIF_STATE_SCHED in napi_disable().

Because neither napi_disable() nor hrtimer_cancel() acquires __netif_tx_loc=
k,
stmmac_xdp_release() can finish both stmmac_disable_all_queues() and
hrtimer_cancel() before the transmitting CPU calls hrtimer_start() on
tx_q->txtimer. When stmmac_xdp_open() subsequently calls hrtimer_setup() on
tx_q->txtimer, won't it zero the active timer with memset() while it is sti=
ll
queued in the per-CPU hrtimer RB-tree?

Calling netif_tx_disable(dev) after stmmac_disable_all_queues(priv) and
before the hrtimer_cancel() loop would ensure all in-flight transmits have
exited __netif_tx_lock before the timers are cancelled.

[Severity: Medium]
As reported by Jakub Kicinski on v1 [2], does delaying netif_tx_disable(dev)
until after stmmac_disable_all_queues(priv) and hrtimer_cancel() also leave
ndo_start_xmit() active while TX completion NAPI is disabled, and shrink the
drain window before DMA teardown?

Unlike stmmac_release() (where ndo_stop runs after dev_deactivate_many() has
already stopped TX queues and quiesced qdiscs), stmmac_xdp_set_prog() in
drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c calls stmmac_xdp_release()
while the interface is up and qdiscs are active:

    need_update =3D !!priv->xdp_prog !=3D !!prog;
    if (if_running && need_update)
            stmmac_xdp_release(dev);

While stmmac_disable_all_queues() (which may sleep in synchronize_rcu() and
napi_disable()) and the hrtimer_cancel() loop run, stmmac_xmit() and
stmmac_tso_xmit() on other CPUs can continue mapping SKBs, handing
descriptors to the DMA engine, and updating the TX tail pointer after TX
completion NAPI has been disabled.

Immediately after netif_tx_disable(dev), stmmac_xdp_release() calls
stmmac_free_irq(), stmmac_stop_all_dma(), and free_dma_desc_resources().
However, the hardware TX DMA stop callbacks such as dwmac4_dma_stop_tx() in
drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c only clear the start bit
without polling for an in-flight transfer to finish:

    value &=3D ~DMA_CONTROL_ST;
    writel(value, ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));

Can unmapping TX buffers and freeing descriptor rings in
free_dma_desc_resources() immediately after netif_tx_disable(dev) race with
an in-flight DMA transfer that was submitted just before netif_tx_disable()?
Also, note that the Signed-off-by chain in the commit message still lists
Rohan G Thomas before the commit author without a Co-developed-by tag, and
these v1 review points were not addressed or explained in v2.

[1] https://lore.kernel.org/r/20260727030645.13280-1-muhammad.nazim.amirul.=
nazle.asmade@altera.com
[2] https://lore.kernel.org/r/20260730005641.4191366-1-kuba@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105053916.2235=
3-1-muhammad.nazim.amirul.nazle.asmade@altera.com?part=3D1
