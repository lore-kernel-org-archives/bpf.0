Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999473;
	b=y4XByslXKxHgcve8rTxKA4j/MWtH0Y/BTubLl6qeXACISly+r8n1K669OaOAVqe9O3+c
	 cFXbpKl3e0DnX35UJOzYR/k/LG/PJwAGpd7y724yNrR0VAvaPVlLWCWEoIcwfANdAMkZ7
	 j1pNVQ/WXhnmXGiOdBiz9AYepefi16BTTD0f1u6aEoSCYTkXXzkemzFHz9nezPGkmcgL3
	 FdWKoutdh8hKSnBArk16ixmtXexix8nM1g9Ec8NuUYwTjvozl6SlGgTKszWNxXyp1w+Xz
	 Po66eFvRHH44QUb9DRaETZZpRLfU4SCrYjh7HDMPfF6Zzp5VCR3Zgq9keJkhxW+QCfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999473;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ldgyxicD8gnQHJGZVb85PMLZcL/wCOWM/4iau2IrFgM=;
	b=2kmUmZPSLvEWlGwzkyO/q/EoRoTukYzzNgVZpXOVoUMpWQw+qRVslWaHANlctUQ9IVQZ
	 sO0a6lSRjY+f3XvtQBVrbxpf8wX2XvBF/5KeSm2+axrrb5D7K1YkMYJVFbu5zYhozhrb9
	 RASAOlbTofpCHoOsGhOG0dFeuV8jwXvqrWkYYWnLD27vZC4+QPrblBOskLus0RksNUbMQ
	 Jm8n5NjogEdfTQ9FIjgWgJwpyKAVOSevf2pumlCalLzrvcpaGaY3TdVgwhJywW3II/vtR
	 k3tKsfq7T2S36khdVuoOZz+ovpCh+sjXRKREV1cZd5HNnCoEf1jzssE3LXarV0liu/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZJkoGKg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E9606A321;
	Mon, 26 Oct 2026 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZJkoGKg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0804E1F01825;
	Mon, 26 Oct 2026 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792999472;
	bh=ldgyxicD8gnQHJGZVb85PMLZcL/wCOWM/4iau2IrFgM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jZJkoGKg21VTjATUMXnCP0794AoDjR/0znSEi9GZ6GHom7CutHnTmLg6IRYHItz3h
	 nEJ78KeSinWe/RGVQURDCpimrJ2ZEENMuzeUWm1jONtLBChXB0TSNFspdiMh6K6DC8
	 AiRdX6M9lZcuJe5f0tkIOjF6LOQo3hI47cyyBroCnLuZ6zVl1dpuTmltVMWbeAU7vP
	 pxWCHLo5p0vjdofhnZTj/vx/GPHZPzvCw26NM7FgsNGHKXbvPh1GX0FxDgIcZK4tFp
	 BVwkJwdr68osFD8NIV17Aub/k3DQDCyy++RPvbmJoJouQ4MacCTPi5hL8ZQsqxcXwz
	 61SHFdgNe2LIQ==
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: Stop Tx queue when
 (en|dis)abling XSK pools
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
Date: Mon, 26 Oct 2026 07:24:30 +0000
Message-ID: <179299947058.3134.16617492920924670801@kernel.org>
In-Reply-To: <20261022-stmmac_xsk_crashes-v4-2-15c0c750bb96@linutronix.de>
References: <20261022-stmmac_xsk_crashes-v4-2-15c0c750bb96@linutronix.de>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] stmmac_xdp_enable_pool() (stmmac_xdp.c:59) and
  stmmac_xdp_disable_pool() (stmmac_xdp.c:102) now call…
- [Medium] The patch only works if __QUEUE_STATE_DRV_XOFF stays set from
  stmmac_xdp_stop_tx_queue() until the ring is rebuilt.
- [Medium] In stmmac_xdp_xmit_xdpf(), first_entry and entry are read from
  tx_q->cur_tx when the locals are declared (stmmac_main.c:5263-5264).

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but if
  __alloc_dma_tx_desc_resources() fails during an XSK pool switch, tx_q…

--

net: stmmac: Stop Tx queue when (en|dis)abling XSK pools

This patch stops the netdev Tx queue while an XSK pool is enabled or
disabled on a running interface. It does this because
stmmac_disable_tx_queue() and stmmac_enable_tx_queue() free and reallocate
the Tx DMA ring. The queue is woken once the ring is rebuilt, and
stmmac_xdp_xmit_xdpf() now drops XDP frames while the queue is stopped.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 27c4a249e560..2083520179a6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5270,6 +5270,10 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  	if (unlikely(xdp_frame_has_frags(xdpf)))
>  		num_frames += sinfo->nr_frags;
>  
> +	/* Ring may be torn down for an XSK pool switch */
> +	if (netif_tx_queue_stopped(netdev_get_tx_queue(priv->dev, queue)))
> +		return STMMAC_XDP_CONSUMED;
> +

[Severity: Medium]
Is this check early enough? first_entry and entry have already been read
from tx_q->cur_tx at the top of stmmac_xdp_xmit_xdpf():

	unsigned int first_entry = tx_q->cur_tx;
	unsigned int entry = tx_q->cur_tx;

The pool switch path does not hold the Tx lock while it rebuilds the ring
or wakes the queue. stmmac_enable_tx_queue()->stmmac_reset_tx_queue() sets
cur_tx and dirty_tx to 0. After that, netif_tx_wake_queue() clears XOFF
without taking the lock.

Take an XDP sender (stmmac_xdp_xmit_back() or stmmac_xdp_xmit()) that:

1. takes __netif_tx_lock() while the queue is stopped
2. loads the old cur_tx == N
3. is delayed past the whole rebuild and wake, for example by being
   preempted on PREEMPT_RT
4. then finds the queue running and passes stmmac_tx_avail()

Could that sender fill and OWN-mark descriptors at the stale index N on
the new ring and then set cur_tx = N + 1?

DMA restarts at descriptor 0, which nobody owns. That looks like it would
stall Tx. stmmac_tx_clean() would then walk entries 0..N-1 as if they had
completed.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index 9af9e0cb366c..14445683a5c3 100644
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
Can stmmac_tx_err() undo this stop while the pool switch is still running?

stmmac_tx_err() runs in hardirq context from stmmac_dma_interrupt() and
stmmac_msi_intr_tx() when the channel status is tx_hard_error. It takes no
lock and always finishes by waking the queue:

stmmac_tx_err() {
	...
	stmmac_stop_tx_dma(priv, chan);
	dma_free_tx_skbufs(priv, &priv->dma_conf, chan);
	stmmac_clear_tx_descriptors(priv, &priv->dma_conf, chan);
	stmmac_reset_tx_queue(priv, chan);
	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
			    tx_q->dma_tx_phy, chan);
	stmmac_start_tx_dma(priv, chan);

	priv->xstats.tx_errors++;
	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));
}

The switch does not seem to keep it out. dwmac4_disable_dma_irq() clears
only RIE and TIE, so AIE, RPS, RBU and FBE stay enabled. There is also no
synchronize_irq().

Stopping RX DMA during the switch raises RPS, and with it AIS.
dwmac4_dma_interrupt() decodes AIS together with TPS or FBE as
tx_hard_error.

TPS is never acknowledged, because only the enabled bits get written back:

	writel(intr_status & intr_en,
	       ioaddr + DMA_CHAN_STATUS(dwmac4_addrs, chan));

That means TPS can stay latched from an earlier Tx DMA stop.

Suppose tx_hard_error is decoded inside the stop-to-wake window. Wouldn't
stmmac_tx_err() then work on the freed or half-rebuilt ring and restart
DMA on freed coherent memory? It would also reopen the queue for
stmmac_xmit() and the XDP Tx paths.

The source alone does not show whether the hardware reports exactly
tx_hard_error in that window. For example, a latched RI bit would change
the status value.

[ ... ]

> @@ -46,6 +56,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  		stmmac_enable_rx_queue(priv, queue);
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rxtx_napi);
> +		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));

[Severity: High]
What happens here if stmmac_enable_tx_queue() failed? It returns void.
When an allocation fails, it only logs a message and returns:

stmmac_enable_tx_queue() {
	...
	ret = __alloc_dma_tx_desc_resources(priv, &priv->dma_conf, queue);
	if (ret) {
		netdev_err(priv->dev, "Failed to alloc TX desc.\n");
		return;
	}
	...
}

The state left behind depends on which allocation in
__alloc_dma_tx_desc_resources() failed:

- tx_q->tx_skbuff_dma or tx_q->tx_skbuff is NULL, or
- dma_tx/dma_etx/dma_entx still point at the coherent ring that
  __free_dma_tx_desc_resources() just freed. That function never clears
  those pointers.

stmmac_reset_tx_queue() is skipped as well, so cur_tx and dirty_tx keep
their old values.

Once this unconditional wake runs, stmmac_xmit() can execute:

	WARN_ON(tx_q->tx_skbuff[first_entry]);

It would then write tx_skbuff/tx_skbuff_dma entries, and descriptors via
stmmac_get_tx_desc(), into NULL or freed memory. The new
netif_tx_queue_stopped() check in stmmac_xdp_xmit_xdpf() is open again
too.

stmmac_xdp_disable_pool() gets the same unconditional wake.

The commit message says the crash comes from Tx touching the ring while it
is freed and reallocated. On this error path, that still seems reachable.

Could stmmac_enable_tx_queue() return the error, so the queue stays
stopped (or the switch is unwound) instead of being woken?

[ ... ]

> @@ -87,6 +99,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rx_napi);
>  		napi_enable(&ch->tx_napi);
> +		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));
>  	}
>  
>  	return 0;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. After
stmmac_enable_tx_queue() fails, tx_q looks set up for a double free on the
next teardown.

__alloc_dma_tx_desc_resources() does no unwind. It returns -ENOMEM at the
first step that fails:

	tx_q->tx_skbuff_dma = kzalloc_objs(*tx_q->tx_skbuff_dma,
					   dma_conf->dma_tx_size);
	if (!tx_q->tx_skbuff_dma)
		return -ENOMEM;

	tx_q->tx_skbuff = kzalloc_objs(struct sk_buff *, dma_conf->dma_tx_size);
	if (!tx_q->tx_skbuff)
		return -ENOMEM;
	...
	addr = dma_alloc_coherent(priv->device, size,
				  &tx_q->dma_tx_phy, GFP_KERNEL);
	if (!addr)
		return -ENOMEM;

__free_dma_tx_desc_resources() never clears dma_tx/dma_etx/dma_entx,
tx_skbuff or tx_skbuff_dma. The next teardown therefore calls it again on
the stale pointers. That teardown can be stmmac_disable_tx_queue() during
another pool switch, or free_dma_tx_desc_resources() from stmmac_release().

Wouldn't that call dma_free_coherent() a second time on the ring that was
already freed?

If the tx_skbuff_dma allocation was the one that failed, two more things
happen:

- dma_free_tx_skbufs() dereferences the NULL tx_skbuff_dma in
  stmmac_free_tx_buffer()
- kfree(tx_q->tx_skbuff) frees the old array a second time

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-stmmac_xsk_crashes-v4-0-15c0c750bb96%40linutronix.de
