Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DC47A896;
	Wed, 14 Oct 2026 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969340; cv=none; b=mD4kF4KtaZPjOKPCAd12aebYuS0pluWoAzORwApxt9zQBv8ogo9ZTtzSXygslmvxqptTj+RhDMyF/fEEFvHtMuvRNUl7L8y0lgvhrCr+WezJrDa64dKUXKvboGWgJN+C9v424/ddMpPvnEotj6fqwfNUx9xxhjAAOJ/CbF8wFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969340; c=relaxed/simple;
	bh=5SFWupJQUwm7vmpu5yNucNcTjpmI6F4lKatU9h+Zprk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hYNY6wYiP4vDat72Kg/lqe9TqyfltbCDR1rW5BPisA/4zjGyxjSjSgptZEcaWXv3IlXtEz058aQgL2VQW8EAtKLWROFVKE6cs2Yw09XqRcUwxZ11kFLRu8EyRIlk/hWKR7/rJrP9kMKxx6SdIq/cJBbisuSjvtrd10BmgOC10ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEWv8tdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEWv8tdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDBC1F00893;
	Wed, 14 Oct 2026 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791969337;
	bh=JyuFAiUkd5zggSLWAMVE2zHEyCybCuX2LJGoDrVWV9Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EEWv8tdOWPtoWZM/JAZYsQhDfpy8dGVtGEvdRm2+mzT1Bs+vW4ZEIPuLRB3hNuuCU
	 miU855XLC4H88bxzZxHUw+fNISFGuCMvXhmSf9KvD4RLNowsmRqi0FQSq1ayAaLf2s
	 Kuz5o5w7YpuE1+lpAMVmM25rez0PHuJcH/1poSJt9KlFufqAsqtuJRMXzfkkaYnK1m
	 YtcndRMD+gs2yscZOMryYZWbF6zXUafcGuWx8zBbSD+pi/2p97Hcn3tFLQnI3x6XvI
	 xsW/1yNC8b1K1lHa0M5qV7XZnNk+nlENeH9ye7+4C2rBWokFO8qjs6hbyNNPuxAmuR
	 WX+xvUjTgcfsA==
Subject: Re: [PATCH net v3 2/2] net: stmmac: Stop Tx queue when (en|dis)abling
 XSK pools
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
Date: Wed, 14 Oct 2026 09:15:36 +0000
Message-ID: <179196933628.434549.6582168487616449135@kernel.org>
In-Reply-To: <20261013-stmmac_xsk_crashes-v3-2-50fca7790af2@linutronix.de>
References: <20261013-stmmac_xsk_crashes-v3-2-50fca7790af2@linutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Both stmmac_xdp_enable_pool() (stmmac_xdp.c:57-59) and
  stmmac_xdp_disable_pool() (stmmac_xdp.c:99-102) now call…
- [Medium] The patch's only guard is the __QUEUE_STATE_DRV_XOFF bit, set
  by stmmac_xdp_stop_tx_queue().
- [Medium] The stopped-queue check in stmmac_xdp_xmit_xdpf() does not
  order the XDP sender against ring re-initialisation, for two reasons.
- [Low] In stmmac_xdp_xmit() (ndo_xdp_xmit, stmmac_main.c:7013-7026),
  when the queue is stopped for an XSK pool switch, the new check makes…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits on the
  error path the patch touches.

--

net: stmmac: Stop Tx queue when (en|dis)abling XSK pools

This patch stops the Tx queue around the Tx ring teardown and
re-allocation in stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool().
It wakes the queue again once the queue has been re-enabled. It also makes
stmmac_xdp_xmit_xdpf() refuse frames while the Tx queue is stopped.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2aa5a26954731..0e8ab2bd8f3e8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5216,6 +5216,10 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  	dma_addr_t dma_addr;
>  	bool set_ic;
>  
> +	/* Ring may be torn down for an XSK pool switch */
> +	if (netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue)))
> +		return STMMAC_XDP_CONSUMED;
> +

[Severity: Medium]

Does this check order the XDP sender against the ring re-initialisation?
The producer index is loaded in the declaration block, before the new test
runs:

    unsigned int entry = tx_q->cur_tx;

On the other side, stmmac_xdp_enable_pool() and stmmac_xdp_disable_pool()
call stmmac_enable_tx_queue() and then netif_tx_wake_queue() without
holding nq->_xmit_lock. The reset happens in
stmmac_enable_tx_queue()->stmmac_reset_tx_queue(), which sets cur_tx = 0
and dirty_tx = 0.

The XDP senders stmmac_xdp_xmit() and stmmac_xdp_xmit_back() hold
__netif_tx_lock(), but that lock does not exclude the waker. Could this
interleaving happen?

CPU A (XDP sender, tx lock held)   CPU B (pool switch)
entry = tx_q->cur_tx; /* 57 */
<delayed by hardirq or RT
 preemption>
                                   stmmac_enable_tx_queue()
                                     stmmac_reset_tx_queue()
                                       tx_q->cur_tx = 0;
                                   netif_tx_wake_queue()
netif_tx_queue_stopped() == false
stmmac_tx_avail() sees empty ring
writes descriptor 57 and xdpf[57]
tx_q->cur_tx = 58;

On weakly ordered CPUs, the plain cur_tx load can also be satisfied
before the relaxed test_bit().

Descriptor 0 has OWN = 0, so the DMA suspends there. stmmac_tx_clean()
also stops at entry 57. Would the queue then stall until the watchdog
resets the device?

Could the cur_tx load be moved after the stopped check? The wake could
also be done under __netif_tx_lock_bh(), the same way
stmmac_xdp_stop_tx_queue() does the stop.

[Severity: Low]

When this returns STMMAC_XDP_CONSUMED for the first frame,
stmmac_xdp_xmit() breaks out of its loop with nxmit == 0, but it still
runs the flush:

stmmac_xdp_xmit() {
    ...
	if (flags & XDP_XMIT_FLUSH) {
		stmmac_flush_tx_descriptors(priv, queue);
		stmmac_tx_timer_arm(priv, queue);
	}
    ...
}

stmmac_flush_tx_descriptors()->stmmac_set_queue_tx_tail_ptr() computes
tx_q->dma_tx_phy + cur_tx * desc_size and writes the result to the
channel's TX tail pointer register. stmmac_tx_timer_arm() reads
tx_q->xsk_pool.

At the same time, stmmac_disable_tx_queue() and stmmac_enable_tx_queue()
can be running on another CPU without the tx lock. They assign a new
dma_tx_phy, reset cur_tx, change xsk_pool and program the same registers.

dma_tx_phy and cur_tx live in the persistent tx_q, so no freed memory is
dereferenced. But can this tail write land after the enable path has
already programmed the new ring?

Should the flush only run when nxmit > 0, or when the queue is not
stopped?

>  	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
>  		return STMMAC_XDP_CONSUMED;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index d7e4db7224b0c..a75ab93aef531 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> @@ -6,6 +6,15 @@
>  #include "stmmac.h"
>  #include "stmmac_xdp.h"
>  
> +static void stmmac_xdp_stop_tx_queue(struct stmmac_priv *priv, u16 queue)
> +{
> +	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
> +
> +	__netif_tx_lock_bh(nq);
> +	netif_tx_stop_queue(nq);
> +	__netif_tx_unlock_bh(nq);
> +}

[Severity: Medium]

During the switch, the XOFF bit set here is the only thing keeping Tx
away from the ring. Can stmmac_tx_err() clear it in the middle of the
teardown?

stmmac_tx_err() runs in hardirq context, called from
stmmac_dma_interrupt() or stmmac_msi_intr_tx() when tx_hard_error is
reported. It ends with:

	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
			    tx_q->dma_tx_phy, chan);
	stmmac_start_tx_dma(priv, chan);

	priv->xstats.tx_errors++;
	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));

It has no way of knowing that a pool switch is in progress. Before that,
it also calls dma_free_tx_skbufs() and stmmac_clear_tx_descriptors() on
the tx_q ring.

Nothing seems to quiesce that path during the switch:

- stmmac_disable_tx_queue() masks only the normal TX interrupt. There is
  no synchronize_irq() before __free_dma_tx_desc_resources().
- dwmac4_disable_dma_irq() clears only RIE/TIE, so abnormal interrupts
  stay enabled.
- stmmac_disable_rx_queue() stops RX DMA, which can raise RPS and
  therefore AIS.
- dwmac4_dma_interrupt() classifies TPS as tx_hard_error. TXSE is not in
  DMA_CHAN_INTR_DEFAULT_MASK, so a TPS latched by an earlier
  stmmac_stop_tx_dma() is never cleared.

Suppose tx_hard_error is reported for this channel inside the window.
Could stmmac_xmit() and stmmac_xdp_xmit_xdpf() then write into the freed
ring, with TX DMA restarted on freed descriptor memory?

Whether the hardware actually reports AIS together with a latched TPS in
that window depends on DWMAC behaviour.

[ ... ]

> @@ -46,6 +56,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  		stmmac_enable_rx_queue(priv, queue);
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rxtx_napi);
> +		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));

[Severity: High]

Is it safe to wake the queue unconditionally here?
stmmac_enable_tx_queue() returns void. When
__alloc_dma_tx_desc_resources() fails, it only logs and returns:

stmmac_enable_tx_queue() {
	ret = __alloc_dma_tx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc TX desc.\n");
		return;
	}
    ...
}

That skips stmmac_reset_tx_queue(), so cur_tx and dirty_tx keep their
old values and stmmac_tx_avail() still reports free space.

The ring was already torn down by
stmmac_disable_tx_queue()->__free_dma_tx_desc_resources(). That function
frees dma_tx/dma_etx/dma_entx, tx_skbuff_dma and tx_skbuff, but sets none
of these pointers to NULL. The resulting state depends on which allocation
failed:

- tx_skbuff_dma kzalloc fails: tx_skbuff_dma is NULL. tx_skbuff and
  dma_tx still point at freed memory.
- tx_skbuff kzalloc fails: tx_skbuff/xdpf is NULL. dma_tx still points
  at freed memory.
- dma_alloc_coherent() fails: it returns before dma_tx is reassigned, so
  dma_tx and dma_tx_phy still refer to the freed ring.

The wake clears __QUEUE_STATE_DRV_XOFF. After that, the new
netif_tx_queue_stopped() check in stmmac_xdp_xmit_xdpf() passes, and the
qdisc calls stmmac_xmit() again. Both paths write des0-des3 through the
stale tx_q->dma_tx, and they also write tx_skbuff[entry] and
tx_skbuff_dma[entry].

Isn't this the same crash the commit is fixing, still reachable when the
allocation fails? The netif_tx_wake_queue() added to
stmmac_xdp_disable_pool() has the same problem.

Could stmmac_enable_tx_queue() return an error, so that the queue can be
left stopped (or the device reset) when it fails?

>  
>  		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
>  		if (err)

[ ... ]

> @@ -87,6 +99,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rx_napi);
>  		napi_enable(&ch->tx_napi);
> +		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));

[Severity: High]

This is a pre-existing issue and was not introduced by this patch, but it
is on the same error path.

If __alloc_dma_tx_desc_resources() partially fails during the pool
switch, tx_q is left inconsistent. The function returns -ENOMEM without
undoing its earlier allocations, and stmmac_enable_tx_queue() does no
cleanup either.

The next teardown can come from
__stmmac_release() or stmmac_xdp_release() through
free_dma_desc_resources()->free_dma_tx_desc_resources()->
__free_dma_tx_desc_resources(). It can also come from the next pool
switch's stmmac_disable_tx_queue(). What it does depends on which
allocation failed:

- tx_skbuff_dma kzalloc failed:
  dma_free_tx_skbufs()->stmmac_free_tx_buffer() dereferences
  tx_q->tx_skbuff_dma[i], which is NULL.
- tx_skbuff kzalloc failed: stmmac_free_tx_buffer() dereferences
  tx_q->xdpf[i], which is NULL.
- dma_alloc_coherent() failed: __free_dma_tx_desc_resources() calls
  dma_free_coherent() again on the stale dma_tx/dma_etx/dma_entx address
  and dma_tx_phy.

Can this cause a NULL pointer oops, or free the coherent descriptor memory
twice?

>  	}
>  
>  	return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-stmmac_xsk_crashes-v3-0-50fca7790af2%40linutronix.de
