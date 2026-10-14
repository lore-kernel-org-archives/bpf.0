Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FE47CC85;
	Wed, 14 Oct 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969339; cv=none; b=BMhmTi98J1XEBM+3MJ+tsOnGDTveZ7XWLp0K4irYzzFKEkES2xLTo0hG7hYughqkkYAQW08pvO6lr6JdGc811ACzxUWnoAhPyGMQXpqaroISxKs7XnrxBCfUyzBDAzM7Nk19LcwrC2peX1qt296hk7cwXTucxg7x5xgD4GBvafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969339; c=relaxed/simple;
	bh=Bv8Dph7SjRk/vgI14x3F23k11zlE4wv2Dx3a0aCy45s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PJptIHF6+UNKl0T9dZGMr4SSZMhKMpASdxE0sEFKbG+6Idsyp9Hiw5CrZKzM3MVe9U3K/4q6XTD+3Ta99AQUupxGtecLAKQwldzGiJk8V2yRA25gguszytTWkY9uZ6PvqIpXRySVCUvQjwzkFBO3GRgIG6OwODtB7faZpCQdwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgGCTGs+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgGCTGs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C894E1F000FF;
	Wed, 14 Oct 2026 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969336;
	bh=dQGv2L9oxDJkrezTAHdZSn33xAxZl6B7e87tsu4RiJ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JgGCTGs+CNnovDIl5ImQr5GgxZ6Om8MVRlkzfZsSZ+APztc0DP/4st/hQ4tVmx9Gd
	 ohFiw0Oo6PTMF50FO5rDIGpdjjdBIbNvIz/nR5WIJDPsw0uhAIyDwDqmAGiMcoiN7k
	 gQlf0wBYihzQUZqCYqFEvN91QslAa3Lyx3ekyBw/3L7dNodyvEjxILHYzUY5+1FgAP
	 Pt3KbZ94dfIkZGglKNSNZyNj0oMeKQDhf91ahX0zp83JlkEil5GlWu1UNGzGzyos7B
	 U765zFiYqx90ryZ3h0jjsfr3QKUrAaWQ5Avv5EUZZ43sD/Dfie1XfsWU2GD6cebYcr
	 f6NzSvWF5Exjg==
Subject: Re: [PATCH net v3 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
From: netdev-bot+sashiko@kernel.org
To: kurt@linutronix.de
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, yoong.siang.song@intel.com, faizal.abdul.rahim@intel.com,
 boon.leong.ong@intel.com, bigeasy@linutronix.de, maciej.fijalkowski@intel.com,
 nb@tipi-net.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Wed, 14 Oct 2026 09:15:34 +0000
Message-ID: <179196933433.434549.18379831611245411576@kernel.org>
In-Reply-To: <20261013-stmmac_xsk_crashes-v3-1-50fca7790af2@linutronix.de>
References: <20261013-stmmac_xsk_crashes-v3-1-50fca7790af2@linutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch adds a new race in stmmac_xdp_release()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c).
- [Medium] The fix still leaves a waker that runs after
  netif_tx_disable().
- [Low] Concern: the same Tx-ring free during an active stmmac_xmit() is
  reachable through stmmac_xdp_enable_pool()/stmmac_xdp_disable_pool().

Pre-existing issues:
- [Low] Concern: stmmac_xdp_xmit() (ndo_xdp_xmit), driven by remote
  devmap flushes, ignores the queue-stopped state and only checks…

--

net: stmmac: Disable NAPI before stopping Tx queues in stmmac_xdp_release()

This patch reorders stmmac_xdp_release() so that NAPI is disabled and
the Tx coalescing hrtimers are cancelled before netif_tx_disable() runs.
The goal is to stop an in-flight Tx NAPI poll from waking the Tx queue
via stmmac_tx_clean() while free_dma_desc_resources() releases the
descriptor rings.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b837e8e27a352..2aa5a26954731 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7132,15 +7132,15 @@ void stmmac_xdp_release(struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	u8 chan;
>  
> -	/* Ensure tx function is not running */
> -	netif_tx_disable(dev);
> -
>  	/* Disable NAPI process */
>  	stmmac_disable_all_queues(priv);
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
> +	/* Ensure tx function is not running */
> +	netif_tx_disable(dev);

[Severity: High]

hrtimer_cancel() now runs before netif_tx_disable(). Can a concurrent
stmmac_xmit() or stmmac_tso_xmit() re-arm txtimer after it has been
cancelled?

Both xmit paths end in stmmac_tx_timer_arm(). The check and the start
there are not serialized against napi_disable() or hrtimer_cancel():

stmmac_tx_timer_arm() {
    ...
	if (unlikely(!napi_is_scheduled(napi))) {
		if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
			hrtimer_start(&tx_q->txtimer,
				      STMMAC_COAL_TIMER(tx_coal_timer),
				      HRTIMER_MODE_REL);
    ...
}

One possible interleaving:

CPU1 (stmmac_xmit, holds txq lock)    CPU0 (stmmac_xdp_release)
napi_is_scheduled() == false
                                      stmmac_disable_all_queues()
                                      hrtimer_cancel() (timer inactive)
hrtimer_active() == false
hrtimer_start()
                                      netif_tx_disable()
                                        only waits for the txq lock

The timer then stays armed. The default is 5000us, and ethtool allows
up to 100000us.

stmmac_xdp_set_prog() then calls stmmac_xdp_open(), which sets up the
timer again without cancelling it first:

stmmac_xdp_open() {
    ...
		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
    ...
}

__hrtimer_setup() does memset(timer, 0, sizeof(struct hrtimer)). Could
that corrupt the per-CPU hrtimer base rbtree while the node is still
enqueued?

Before this patch, netif_tx_disable() ran first, so no regular xmit
could run during the cancel loop. The later patch in this series does
not touch stmmac_xdp_release(), so the window seems to remain at the
end of the series.

Would moving the hrtimer_cancel() loop after netif_tx_disable() close
this race and still keep NAPI disabled before Tx is stopped?

> +
>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);

[Severity: Medium]

Can the error interrupt path still wake the Tx queue after
netif_tx_disable()?

The IRQ handlers stay registered until stmmac_free_irq().
stmmac_xdp_set_prog() never sets STMMAC_DOWN, so the STMMAC_DOWN checks
in stmmac_interrupt() and stmmac_msi_intr_tx() let these interrupts
through.

On tx_hard_error, stmmac_dma_interrupt() and stmmac_msi_intr_tx() call
stmmac_tx_err(), which ends with:

stmmac_tx_err() {
    ...
	priv->xstats.tx_errors++;
	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));
}

free_irq() only waits for a running handler to finish. Nothing stops
the queue again before stmmac_stop_all_dma() and
free_dma_desc_resources().

Could stmmac_xmit() then run on rings that are being freed and hit the
same dwmac4_set_addr() fault?

The netif_tx_queue_stopped() check that the later patch in the series
adds to stmmac_xdp_xmit_xdpf() would not help here, because the queue
has already been woken.

The commit message says:

  Nothing stops the queue afterwards, so the Tx path resumes while
  free_dma_desc_resources() releases the descriptor rings underneath it.

The reordering only handles the NAPI waker, though. Would stopping Tx
after stmmac_free_irq(), or having stmmac_tx_err() skip the wake during
teardown, cover this case as well?

[Severity: Low]

This is a pre-existing issue and was not introduced by this patch. Can
stmmac_xdp_xmit() (ndo_xdp_xmit), driven by remote devmap flushes,
write into rings freed by free_dma_desc_resources() during an XDP
detach?

At this commit, stmmac_xdp_xmit() ignores the queue stopped state and
only checks STMMAC_DOWN, which the XDP release path never sets. So it
could write tx_q->xdpf[] and descriptors into the freed rings.

The later patch "net: stmmac: Stop Tx queue when (en|dis)abling XSK
pools" adds this check at the start of stmmac_xdp_xmit_xdpf():

	/* Ring may be torn down for an XSK pool switch */
	if (netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue)))
		return STMMAC_XDP_CONSUMED;

stmmac_xdp_xmit() calls that function under __netif_tx_lock(nq), the
same per-queue lock that netif_tx_disable() takes. After
netif_tx_disable() has run, later ndo_xdp_xmit calls are rejected
before they touch descriptor memory.

That still leaves the case where the queue is woken again through
stmmac_tx_err(), described above.

[Severity: Low]

stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool() in stmmac_xdp.c
seem to have the same problem. Both call stmmac_disable_tx_queue(),
which frees the Tx ring without stopping the netdev Tx queue:

stmmac_disable_tx_queue() {
    ...
	stmmac_stop_tx_dma(priv, queue);
	__free_dma_tx_desc_resources(priv, &priv->dma_conf, queue);
}

At this commit, can stmmac_xmit() fault on that freed descriptor
memory?

The next patch in the series, "net: stmmac: Stop Tx queue when
(en|dis)abling XSK pools", appears to fix this. In both functions it
calls stmmac_xdp_stop_tx_queue() before stmmac_disable_rx_queue() and
stmmac_disable_tx_queue(). It also wakes the queue again after
stmmac_enable_tx_queue().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-stmmac_xsk_crashes-v3-0-50fca7790af2%40linutronix.de
