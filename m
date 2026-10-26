Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999470;
	b=sTt8NacWroCDET9AgtpqGTgNtTiDtEEfOe0II6afoFC9N7vG1ko00n/QOD03WhS/dzSm
	 80pd95vj3sAsf1VaTx2MfI5A3BqC6oF6DiqDfggQMqch1t9HKTD3RRX7yNAwDIJSxXg2X
	 Qp7GSP1s0QjHalFtIK65ZxTQlMwq+XANPCOmw/W0tuST7TVXHEcROfinp+vyk50f5vhbW
	 731jP6Mw5pL16FMQaP4FLm4vqfNfGgGfJ6b0xVJwbPW0gGgdDSrgYNdv79sFoUj72SXwI
	 xI6UFE37N9TCywFai5bdOYwtvUv+l1Ma/buCEkJXUS0KUGQQWXQ1Lx2ARiFkN9Dkr9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999470;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JJgpvEkPumvlVtURp/qLJngATfKKtQ96oi4A6w8xMPs=;
	b=bDoGyp7JXwVnAIsAffudwo2gWIKjlTrTdJq+6BNanPDpI7YBqDcLvIAywZq3Jpwq+oBd
	 Fv75SExA0vMTB/AVGJ0F77jA2s6qZUVHKuRQaqaJKLiGH9+XPnrUa4rf/iCZ5/thClvs2
	 DJht1G01ALQMyCKsRN7WzqnWlTAFmn+U53MHDNjSsTXq6rm/bd55varV29gqUW2bJ9IBI
	 EEtLLIl64h1Z1CaKw2s1pFsdXQudJyA04GPUb0buf8y3RC3hb6SP5bhAb8bhlB91BZFga
	 u+bF0CRL6mKCax6AMFI/yDuRk1U/tPXXBuJG+zSCnP50/Q+TCVzKvMbA2bjIdqbf+iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gn0pQZO7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF4606A31E;
	Mon, 26 Oct 2026 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gn0pQZO7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAE31F01825;
	Mon, 26 Oct 2026 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999470;
	bh=JJgpvEkPumvlVtURp/qLJngATfKKtQ96oi4A6w8xMPs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gn0pQZO73NyS8gRkUMi8fTS8Q1RCv5iL7aBMd14ewKA2GUoXzCc0jBPy4yd2ADuSm
	 TDDcuBZblCYDpN33YCQAplP6xvngTlEXevDS6QxrrUuFHcLnLaJRQMOR6Q2ige0+zT
	 IfSDFERGaV9jBA4mZUqvfaBtZN7D44GGxSOxVStovSTbVO79UQmezteDeHwRJ/aeAe
	 BERuCjUzgWlrNHm4CBdTxeg9PY5xMfI6M9MkyD8MEH5bgbBCRICxRAB6DTKT8ygSWI
	 FJ/X+MatIUb+YAxhzP+wlHcHuxW7yyxoQrzD5KiXi9wbpXL8fVqGUSEFbfF6yCA0U8
	 mfP+joOIxYdBA==
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: Disable NAPI before stopping
 Tx queues in stmmac_xdp_release()
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
Date: Mon, 26 Oct 2026 07:24:28 +0000
Message-ID: <179299946882.3134.17106790246487017966@kernel.org>
In-Reply-To: <20261022-stmmac_xsk_crashes-v4-1-15c0c750bb96@linutronix.de>
References: <20261022-stmmac_xsk_crashes-v4-1-15c0c750bb96@linutronix.de>
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

Critical: 0 · High: 2 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] stmmac_xdp_release() now runs napi_disable (via
  stmmac_disable_all_queues()), then hrtimer_cancel() on every…
- [High] The commit says the Tx queue must not be woken again after
  netif_tx_disable() in stmmac_xdp_release(), and it fixes this only for…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  stmmac_xdp_set_prog() discards the return value of stmmac_xdp_open()…

--

net: stmmac: Disable NAPI before stopping Tx queues in stmmac_xdp_release()

This patch reorders stmmac_xdp_release() so that NAPI is disabled and the
Tx coalescing timers are cancelled before netif_tx_disable(). The goal is
to stop stmmac_tx_clean() from waking the Tx queue after it was stopped,
which let stmmac_xmit() run on descriptor rings freed by
free_dma_desc_resources().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index fb53b1f17714..27c4a249e560 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7222,15 +7222,15 @@ void stmmac_xdp_release(struct net_device *dev)
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
> +

[Severity: High]
With this order, ndo_start_xmit is still live while the hrtimer_cancel()
loop runs. Can stmmac_xmit() or stmmac_tso_xmit() re-arm txtimer after it
has been cancelled?

Both of them end with stmmac_tx_timer_arm(), which does:

stmmac_tx_timer_arm() {
    ...
	if (unlikely(!napi_is_scheduled(napi))) {
		if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
			hrtimer_start(&tx_q->txtimer,
				      STMMAC_COAL_TIMER(tx_coal_timer),
				      HRTIMER_MODE_REL);
    ...
}

Nothing makes this check-then-start sequence atomic with respect to
napi_disable() and hrtimer_cancel(). One possible interleaving:

CPU1 (stmmac_xmit, holding txq lock)
  napi_is_scheduled(napi) -> false
                                CPU0 (stmmac_xdp_release)
                                stmmac_disable_all_queues()
                                hrtimer_cancel(&tx_q->txtimer)
                                  timer not armed, returns at once
  hrtimer_start(&tx_q->txtimer, ...)
                                netif_tx_disable(dev)
                                  only waits for CPU1 to drop txq lock

Nothing later in stmmac_xdp_release() cancels the timer. It stays queued
for tx_coal_timer, which is 5ms by default and up to 100ms via ethtool -C.
A hardirq on CPU1 widens the window. On PREEMPT_RT it can be arbitrarily
long.

stmmac_xdp_set_prog() then calls stmmac_xdp_open() right away, and that
function does:

stmmac_xdp_open() {
    ...
		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
    ...
}

Would this re-initialize an hrtimer that is still linked in the per-CPU
timerqueue and corrupt the hrtimer base?

Before this patch, netif_tx_disable() ran first and serialized against
in-flight xmit callers. Only NAPI could arm the timer, and NAPI was
disabled before the cancel.

Would the order napi disable, then netif_tx_disable(), then the
hrtimer_cancel() loop avoid this?

>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>  

[Severity: High]
The commit message says the problem is the Tx queue being woken again
after netif_tx_disable(), and this patch covers the stmmac_tx_clean()
waker. Is there still a waker in IRQ context?

netif_tx_disable() still runs before stmmac_free_irq() and
stmmac_stop_all_dma(). At that point the DMA interrupt handlers are still
installed and Tx DMA is still running.

stmmac_xdp_release() never sets STMMAC_DOWN, so the STMMAC_DOWN check in
stmmac_interrupt() and stmmac_msi_intr_tx() does not stop the handlers.

On a Tx fatal bus error (tx_hard_error), stmmac_dma_interrupt() or
stmmac_msi_intr_tx() calls stmmac_tx_err(), which ends with an
unconditional wake:

stmmac_tx_err() {
    ...
	priv->xstats.tx_errors++;
	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));
}

The qdisc is still active in the XDP reconfigure path. In ndo_stop,
dev_deactivate_many() has already run, but not here. So the wake can
start stmmac_xmit() again:

stmmac_xdp_release()
  netif_tx_disable(dev)
                            stmmac_dma_interrupt()
                              stmmac_tx_err()
                                netif_tx_wake_queue()
  stmmac_free_irq()
  stmmac_stop_all_dma()
  free_dma_desc_resources()
                            stmmac_xmit()
                              writes into tx_q->dma_tx / dma_etx

free_irq() only waits for handlers that are already running. It does not
undo the wake, and nothing stops the queue again after it.

Could stmmac_xmit() then write descriptors into rings that
free_dma_desc_resources() has already freed?

Moving netif_tx_disable() after stmmac_free_irq() might close this path.
Another option is a teardown flag that stmmac_tx_err() and the ISRs
check. The last patch of the series ("net: stmmac: Stop Tx queue when
(en|dis)abling XSK pools") does not seem to cover this case.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. It is
on the same release/reopen path, though. stmmac_xdp_set_prog() ignores
the return value of stmmac_xdp_open():

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
    ...
	if (if_running && need_update)
		stmmac_xdp_open(dev);
    ...
}

stmmac_xdp_open() can fail in alloc_dma_desc_resources(),
init_dma_desc_rings() or stmmac_request_irq(). On failure it frees the
descriptor resources and returns before stmmac_enable_all_queues(),
netif_carrier_on() and netif_tx_start_all_queues(). Userspace is still
told the XDP update succeeded.

What happens on the next ifdown in that state? The call chain
stmmac_release()->__stmmac_release()->stmmac_disable_all_queues() calls
napi_disable() on NAPI instances that stmmac_xdp_release() has already
disabled. In napi_disable_locked():

	val = READ_ONCE(n->state);
	do {
		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
			usleep_range(20, 200);
			val = READ_ONCE(n->state);
		}

Both bits are already set, so wouldn't this loop forever while holding
rtnl_lock and the netdev instance lock? Another XDP program change would
take the same path through stmmac_xdp_release().

Should stmmac_xdp_set_prog() propagate the error, and should the device
be left in a state that a later close can handle?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-stmmac_xsk_crashes-v4-0-15c0c750bb96%40linutronix.de
