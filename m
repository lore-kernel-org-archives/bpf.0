Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36C38E126;
	Thu,  8 Oct 2026 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486595; cv=none; b=rj5xeMRv798HVOUeMW4ewJsZopAIojqV99DtZMxEN1apGum3OgipWMmUyNyJ0fuV50AczMAgPsGbXyQ/1K1vR1KwMXL6sQFpdY8eXgQWtDZrOSJheKbPyg4jRJsZBIhqVjil9p2qPLE344GEbrPgyVU0FITwAshVS6aM0GgqTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486595; c=relaxed/simple;
	bh=ZYF+JXCbDOy8c5Aw9v3H2uo0HuInxjrEpYJzX+UmrPg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hN8gzYvHCG2wyH/ijYBuAO/zVpW0hIM+GXKPbU2IcwK3MAvgNHin6hTnpmP1pPJHQXKaIxG9M13ObdeWn+3WKCQjGFHJ6TDqYaCUl7yy4O/0H8Lsv3t10yRf5aecPvQxWKFnBvwovSUnE8889H4AMTT7fjsH78zVZzI+cUNyklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUHP99dX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUHP99dX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154161F000FF;
	Thu,  8 Oct 2026 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486594;
	bh=TSE/zkvR+fZATE61FvfTd5DhcLvxDvsdlVd/W/5R1tc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OUHP99dX2rkXYzgAURgMPosPeouo6XDclRP9HN8SvR3naf4Q0wLB2/A+gmHIhpTLh
	 unl1GhqKsj4QP8cnfjO016xdKdF5+CSagDX3QoI3jiX5fvaPZNsFBn3zhOrCmONDMN
	 SPmpj7gQ6sHy4GbcRGjqwG2DfRPz1hO/zcOX9qzHCKteo3N49Z/0SkTRoPTsz+kVsu
	 Q+NX/ZPqsz4BbwLVK2chwtSSCwo1UixEVD35iiJ85aqllZccZtm6p4ZSbZpNTXdJxx
	 oCZc8xaiR73kcl4OFHv+kuiadyRZFxLhYvGhl2OlfgPWg7FL/VBc5Rlawu8Zudmipq
	 h0zdOrkBIFEAw==
Subject: Re: [PATCH net v2 1/2] net: stmmac: Disable NAPI before stopping Tx
 queues in stmmac_xdp_release()
From: netdev-bot+sashiko@kernel.org
To: kurt@linutronix.de
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, yoong.siang.song@intel.com,
 noor.azura.ahmad.tarmizi@intel.com, faizal.abdul.rahim@intel.com,
 boon.leong.ong@intel.com, bigeasy@linutronix.de, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Thu, 08 Oct 2026 19:09:52 +0000
Message-ID: <179148659257.434549.8899547962974012240@kernel.org>
In-Reply-To: <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
References: <20261005-stmmac_xsk_crashes-v2-1-46c60cba6421@linutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Baseline decision: false.
- [High] This patch reorders stmmac_xdp_release() so that
  hrtimer_cancel() on every tx_q->txtimer now runs before…

Pre-existing issues:
- [High] This problem was not introduced by this patch, but it is a use-
  after-free in the same teardown sequence, and moving…
- [Medium] Baseline decision: false.

--

net: stmmac: Disable NAPI before stopping Tx queues in stmmac_xdp_release()

This commit reorders stmmac_xdp_release() so that NAPI is disabled and the
Tx coalescing timers are cancelled before netif_tx_disable() is called.
The goal is to stop an in-flight Tx NAPI poll from waking the Tx queue
again while free_dma_desc_resources() releases the descriptor rings.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9741f97fa37a2..796817caf7af0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7178,15 +7178,15 @@ void stmmac_xdp_release(struct net_device *dev)
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
Now that netif_tx_disable() runs after the hrtimer_cancel() loop, can
stmmac_xmit() re-arm tx_q->txtimer after it has been cancelled?

Before this change, netif_tx_disable() took every txq lock first. Any
running stmmac_xmit() had finished and the queues were stopped before the
timers were cancelled.

Now stmmac_xmit() can run at the same time as stmmac_disable_all_queues()
and the cancel loop. It always ends by calling stmmac_tx_timer_arm():

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

CPU1 (stmmac_xmit)                  CPU0 (stmmac_xdp_release)
stmmac_tx_timer_arm()
  napi_is_scheduled() == false
                                    stmmac_disable_all_queues()
                                      napi_disable() sets SCHED
                                    hrtimer_cancel(&tx_q->txtimer)
                                      timer not armed, returns 0
  hrtimer_start(&tx_q->txtimer)
                                    netif_tx_disable(dev)

The timer then stays queued while the rings are freed. The timeout is 5ms
by default and up to 100ms through ethtool -C tx-usecs.

stmmac_xdp_set_prog() then calls stmmac_xdp_open(), which does:

	hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);

__hrtimer_setup() memsets the timer while it is still linked in the
hrtimer base timerqueue.

Could that corrupt the timerqueue rbtree when the timer expires or is
started again?

Would this order avoid the problem: disable NAPI, then netif_tx_disable(),
then hrtimer_cancel()?

__stmmac_release() is cited in the commit message as the reference order,
but it also cancels the timers before netif_tx_disable(). It may have the
same window.

[Severity: High]
The reproducer in the commit message opens an AF_XDP/ZC socket. When an
XDP program is already attached, that goes through stmmac_xdp_setup_pool()
-> stmmac_xdp_enable_pool() in stmmac_xdp.c, not stmmac_xdp_release():

stmmac_xdp_enable_pool() {
    ...
	if (need_update) {
		napi_disable(&ch->rx_napi);
		napi_disable(&ch->tx_napi);
		stmmac_disable_rx_queue(priv, queue);
		stmmac_disable_tx_queue(priv, queue);
	}
    ...
}

stmmac_disable_tx_queue() frees the ring with stmmac_stop_tx_dma() and
__free_dma_tx_desc_resources(). Nothing stops the netdev Tx queue.
stmmac_xdp_disable_pool() follows the same pattern with ch->rxtx_napi.

At this commit, can stmmac_xmit() keep writing into tx_q->dma_tx while the
ring is freed and reallocated on these paths?

The next patch in the series, "net: stmmac: Stop Tx queue when
(en|dis)abling XSK pools", appears to address this. It adds
stmmac_xdp_stop_tx_queue() after napi_disable() and netif_tx_wake_queue()
after the queues are re-enabled, which closes the gap by the end of the
series.

> +
>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);

[Severity: Medium]
This isn't a bug introduced by this patch, but the TX/DMA IRQ handlers
stay registered after netif_tx_disable() until stmmac_free_irq() runs.
STMMAC_DOWN is not set on this path.

If a TX hard error arrives in that window, stmmac_msi_intr_tx() or
stmmac_dma_interrupt() calls stmmac_tx_err(), which ends with:

stmmac_tx_err() {
    ...
	priv->xstats.tx_errors++;
	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));
}

Can that reopen the queue so that stmmac_xmit() runs on rings that
free_dma_desc_resources() is about to release?

The window existed before this patch and was larger then. Hitting it needs
a hardware DMA TX fatal error during XDP attach or detach.

[Severity: High]
This is a pre-existing issue, not introduced by this patch. Moving
netif_tx_disable() does not change it.

When the XDP program is removed, stmmac_xdp_set_prog() does:

	if (!prog)
		xdp_features_clear_redirect_target(dev);

	need_update = !!priv->xdp_prog != !!prog;
	if (if_running && need_update)
		stmmac_xdp_release(dev);

Nothing like synchronize_rcu() or synchronize_net() runs between clearing
the flag and the release. stmmac_disable_all_queues() calls
synchronize_rcu() only when an rx_q->xsk_pool exists.

Another device's NAPI poll may already have passed the
NETDEV_XDP_ACT_NDO_XMIT check in __xdp_enqueue(). It can then flush its
bulk queue from xdp_do_flush() into stmmac_xdp_xmit() after
free_dma_desc_resources() has run.

stmmac_xdp_xmit() only checks:

	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
		return -ENETDOWN;

This path never sets STMMAC_DOWN. Also, __netif_tx_lock() ignores the
stopped state set by netif_tx_disable().

Could stmmac_xdp_xmit_xdpf() then write into the freed tx_q->dma_tx and
tx_q->tx_skbuff_dma?

Would either of these close it: setting STMMAC_DOWN, or adding
synchronize_rcu()/synchronize_net() after the redirect target is cleared
and before the release?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-stmmac_xsk_crashes-v2-0-46c60cba6421%40linutronix.de
