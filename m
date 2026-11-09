Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203631;
	b=ZCFRYO/6Ylv4B/DgXL6rgzSF51Z1aFPJhPrsq+dcqmVOnQbC+Npzj+I5GeuyA+v2iDkL
	 ZveoGZ1x2M92GVF33MNdDHZf/fDA32MERt7iFpgNc0bDHeVJOHAfSBArVRPC7mU+qXmtK
	 o02xHStcA8lf2sj2AZSpk4lDyiUDEUz/kngvt0j5AprJtcwVBlS1COpQVgvKKmGRZprSy
	 j9j6bfk+WAqrKC+4WQIkjACjKJcacDC3JYQZTrn7SnssCi2+QrhVFh5pkdZsjdnYkHxbT
	 SCAYk7FtV3gb2W4d1HqGBmq2P9MkUrZegFsiDuVsiWPmRPL1XARrsYXiaaILjGsFVuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203631;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=W1mfR/+JXbp1hpCZu9HuoqLOwrMsPqWR8ZMYk9Ds6Ng=;
	b=4BMgLEiYnPyCwvqxwntCdA219LM38X27Gd2Eqf4zbwWBo9FQv+R/Tcqf6lLuejNk5Eik
	 HyWwjIYSOiP9mKHKGv+lVxMi/TaDeHxfd8uXRUQ407F/VUvQdL5UXh6k4RNyOMxKJFclA
	 ljti8dE34BC+eDYZA/7mwvz3u8jZoFnb84azkl/Pb1g1DT4dkbqOxzaXEkK93bTpiO4e+
	 QxRzhh9KvbxL3RSw2g6QiTA/F+87YHCLeJGy+ctr6PTkdyMFr/n78+r3yjCodC6qqP4Wk
	 JkOaSdHM9o52B5eZ5KwQH43p4NU+Xq+W3s0vAtQYgctrko0qlYVwc/4rD/Cg5xJraLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijlKxu8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFAF606A31C;
	Mon,  9 Nov 2026 05:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijlKxu8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459FF1F0089F;
	Mon,  9 Nov 2026 05:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794203630;
	bh=W1mfR/+JXbp1hpCZu9HuoqLOwrMsPqWR8ZMYk9Ds6Ng=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ijlKxu8n/cdoHYoaEVAKvBG2RpOt+W23Lb9OFOL3uAySOP2c4vvmvXKKsfHW4RbVB
	 9yk5/JkSPA1SQm21DI37LVMJGSnoL1NyCehVi4f8LG5XsYpXEUFvhyrVuez2mbzdel
	 hpy3vnYy4Gf6eS9HTrZEV2hOZxLuNWRj2q0fhkrhZAjBTSTWocr6prPkZBGi1gVyG3
	 XvMgEPU5KoeCey2RYtUrg2vSwDrWmTqkM/Fo0jhMx/ayNBz0gw8ihXy15ARQJiMzkM
	 osdowQDUTqaumgEdN4QGi3toLKjsoVBDOidmdJHmfIKoMau6rKuGsyfp1wa1mgo1OU
	 wb/gdwnXuc9Jg==
Subject: Re: [PATCH net v2] net: stmmac: Disable queues before
 netif_tx_disable in xdp_release
From: netdev-bot+sashiko@kernel.org
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
 ansuelsmth@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 faizal.abdul.rahim@intel.com, noor.azura.ahmad.tarmizi@intel.com,
 yoong.siang.song@intel.com, rohan.g.thomas@altera.com,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 09 Nov 2026 05:53:48 +0000
Message-ID: <179420362880.994134.12466150409496809199@kernel.org>
In-Reply-To: <20261105053916.22353-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20261105053916.22353-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch moves the hrtimer_cancel() loop on tx_q->txtimer ahead
  of netif_tx_disable().
- [Medium] The reorder only blocks one of the two places that can wake a
  TX queue after netif_tx_disable() in stmmac_xdp_release().

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a use-
  after-free in the same teardown.

--

net: stmmac: Disable queues before netif_tx_disable in xdp_release

This commit reorders stmmac_xdp_release(). NAPI is now disabled and the TX
coalescing hrtimers are cancelled before netif_tx_disable() is called. The
goal is to stop stmmac_tx_clean() from waking a TX queue while the DMA
rings are being torn down, using the same order as __stmmac_release().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7ffed295eb14a..7d1497392b8b5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7264,15 +7264,15 @@ void stmmac_xdp_release(struct net_device *dev)
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
hrtimer_cancel() now runs before netif_tx_disable(). Can a stmmac_xmit()
or stmmac_tso_xmit() that is already in flight re-arm tx_q->txtimer after
the cancel has returned?

stmmac_tx_timer_arm() checks the NAPI state and then acts on it:

stmmac_main.c:stmmac_tx_timer_arm() {
    ...
	if (unlikely(!napi_is_scheduled(napi))) {
		if (unlikely(!(hrtimer_active(&tx_q->txtimer))))
			hrtimer_start(&tx_q->txtimer,
				      STMMAC_COAL_TIMER(tx_coal_timer),
				      HRTIMER_MODE_REL);
	} else {
    ...
}

One possible interleaving:

CPU1 (stmmac_xmit, txq lock held)
stmmac_tx_timer_arm()
  napi_is_scheduled(napi) returns false
  <hardirq, or preempted on PREEMPT_RT>

CPU0 (stmmac_xdp_release)
stmmac_disable_all_queues()      /* napi_disable() sets SCHED */
hrtimer_cancel(&tx_q->txtimer)   /* nothing queued, returns */

CPU1
  hrtimer_start(&tx_q->txtimer, ...)

CPU0
netif_tx_disable()   /* waits for the txq lock, timer stays queued */

stmmac_xdp_set_prog() then calls stmmac_xdp_open() straight away, and
stmmac_xdp_open() does:

	hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);

The coalesce timer defaults to 5ms and ethtool can raise it to 100ms, so
the stray timer is likely still queued at that point. Would re-initializing
a queued hrtimer corrupt the per-CPU hrtimer base?

Before this patch, netif_tx_disable() ran first, so in-flight xmits were
drained before the timers were cancelled.

The commit message says:

  "Once NAPI is disabled, NAPI_STATE_SCHED stays set, so
  stmmac_tx_timer_arm() takes the hrtimer_try_to_cancel() path and new
  transmissions cannot re-arm the TX timers after hrtimer_cancel()."

This seems to hold only for transmissions that check the NAPI state after
napi_disable(). Would the order stmmac_disable_all_queues() ->
netif_tx_disable() -> hrtimer_cancel() close both this window and the
stmmac_tx_clean() one?

> +
>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>  

[Severity: Medium]
Disabling NAPI first stops the wake in stmmac_tx_clean(). Is there still a
second waker in the window between netif_tx_disable() and
stmmac_free_irq()?

stmmac_tx_err() also calls netif_tx_wake_queue(). It runs from the hard
IRQ handlers stmmac_dma_interrupt() and stmmac_msi_intr_tx() when the
status is tx_hard_error:

stmmac_main.c:stmmac_tx_err() {
    ...
	stmmac_start_tx_dma(priv, chan);

	priv->xstats.tx_errors++;
	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));
}

The IRQ lines stay requested until stmmac_free_irq(), which now runs after
netif_tx_disable(). stmmac_xdp_release() never sets STMMAC_DOWN, so the
STMMAC_DOWN check in stmmac_msi_intr_tx() does not filter this either.

Suppose the DMA reports TPS or FBE in that window. The queue is woken
again and TX DMA is restarted. Could the NET_TX softirq then call
stmmac_xmit() while stmmac_stop_all_dma() and free_dma_desc_resources()
are freeing the descriptor ring and tx_skbuff/tx_skbuff_dma?

The trigger needs a fatal bus error or a transmit-process-stopped status in
this window, so it is narrow. __stmmac_release() has the same
netif_tx_disable() -> stmmac_free_irq() window. It is still the same
failure the commit message describes: the queue restarts after
netif_tx_disable() and ndo_start_xmit() runs during ring teardown.

[Severity: High]
This isn't a bug introduced by this patch, but it is the ndo_xdp_xmit()
race the v2 changelog mentions. Can stmmac_xdp_xmit() write into the TX
rings that free_dma_desc_resources() is freeing here?

On program removal, stmmac_xdp_set_prog() does:

	if (!prog)
		xdp_features_clear_redirect_target(dev);

	need_update = !!priv->xdp_prog != !!prog;
	if (if_running && need_update)
		stmmac_xdp_release(dev);

Nothing waits for a grace period between these two calls.
stmmac_disable_all_queues() only calls synchronize_rcu() when an RX queue
has an xsk_pool.

Another device's NAPI may already have passed the feature check in
__xdp_enqueue() and queued frames in a devmap bulk queue. When it flushes
through bq_xmit_all() -> stmmac_xdp_xmit(), the only gate is:

	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
		return -ENETDOWN;

stmmac_xdp_release() never sets STMMAC_DOWN. stmmac_xdp_xmit() also takes
__netif_tx_lock() without checking whether the queue is stopped, so
netif_tx_disable() does not fence it.

stmmac_xdp_xmit_xdpf() then writes into tx_q->dma_tx and
tx_q->tx_skbuff_dma. __free_dma_tx_desc_resources() releases that memory
with dma_free_coherent() and kfree().

The v2 changelog already says this will be handled separately.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105053916.22353-1-muhammad.nazim.amirul.nazle.asmade%40altera.com
