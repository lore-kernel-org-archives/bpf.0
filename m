Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5843F8BA;
	Fri, 25 Sep 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363534; cv=none; b=qlkfm3ygDSqi8Sa0mH20dq6AGzkKn+ye8wBHvHUeIgtSzQsMBRtVxIv/PPUhcc8QKSlqX8E/8n6waz7qkgDPV0q2yfhF3ZHGDOvxQBzL4MDrIXM2MOHzTy2tH1oGR0b2l84/WVVCn4zWjQddiqLxP0rR9pjV3S/5vczIHhvGO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363534; c=relaxed/simple;
	bh=X9BDE3+PEhECXh6PFg1bdlvQaNt8o1zPlYrhnJgxN64=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XAavOLmP56mHAUxioQVtUYJMirkhscVostvqBexobr6A0QnbWF9BsivcvJg98YpS62mGtxWwHMqSS9aaFzZYuUcmfW1DuGAMgsCCl0FgFEh0Bo4WROXdXseHO3zSi48MU4zMPj6Z2ONRBR2VHanyiuYZEY9EEHZYh4pNu18VSik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbQo7utJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbQo7utJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8426B1F00899;
	Fri, 25 Sep 2026 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363529;
	bh=iSZ02Q/pHhbrdo7zDtSjm8Z3UTYrKKYcQKF/nVYlbYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mbQo7utJtQXqTI3PVb3WE2731RgkPBEPhGanq1wyB7KmGdk7Ndt5oyQiPQUer+GpW
	 F/mYWAlmr4VlsHIMFHfqzPpJBju8PvwU+PhmXoOEAV89rkDb+XrVBWdUn+pwWMaOoY
	 4BKo2QJ9fgO7dSzsZugjSIq5xEv5b+d90kjJ8KVcrCqDEUxS/L0nLjJ4lEnkpgXez4
	 R6WD4OBsbezD4uUd2KH6PtnBf+mo+aixkIxPVhweR/cERTaebH5SipEjGMIqxjEirD
	 1a9bH6gvFp5Klc7wHu0Ltdiu1VLF9qBRGh421OB5dXH/Wmf26fQT6waqceqfRupBqU
	 AAVOEQAEBgfpQ==
Subject: Re: [PATCH net v3 08/10] net: stmmac: use the tracked datapath
 restart for XSK pool changes
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, fancer.lancer@gmail.com, quic_jsuraj@quicinc.com,
 richardcochran@gmail.com, Joao.Pinto@synopsys.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 richard.genoud@bootlin.com, alastair@d-silva.org, mripard@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 zhaojinming@uniontech.com, lorenzo.bianconi@oss.qualcomm.com,
 dinghui1111@163.com
Date: Fri, 25 Sep 2026 19:12:07 +0000
Message-ID: <179036352708.2160803.17834513900548257780@kernel.org>
In-Reply-To:
 <20260924-submit-stmmac-reset-fixes-v1-v3-8-c031e3f3a282@gmail.com>
References:
 <20260924-submit-stmmac-reset-fixes-v1-v3-8-c031e3f3a282@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Every live AF_XDP zero-copy pool bind or unbind now bounces
  the physical link, and the commit message does not say so.
- [Medium] Attaching an XSK pool now leaves rxtx NAPI repolling
  continuously for as long as carrier is down, even when there is no…
- [Low] stmmac.h keeps a stale external prototype for
  stmmac_xsk_wakeup().

Pre-existing issues:
- [Medium] stmmac_xdp_release() calls stmmac_stop_all_dma() and then
  immediately frees the descriptor rings and buffers with…

--

net: stmmac: use the tracked datapath restart for XSK pool changes

Live XSK pool attach and removal used per-queue disable/enable helpers.
This patch replaces them with the full stmmac_xdp_release() and
stmmac_xdp_open() pair. It undoes the bitmap bit and DMA mapping if
attach fails, and always returns success on removal. The unused per-queue
helpers are removed, and their TBS programming moves into
stmmac_xdp_open().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index ab5157fccc465..f07623a1285c9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -437,10 +437,6 @@ static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
>  	return !!priv->xdp_prog;
>  }
>  
> -void stmmac_disable_rx_queue(struct stmmac_priv *priv, u32 queue);
> -void stmmac_enable_rx_queue(struct stmmac_priv *priv, u32 queue);
> -void stmmac_disable_tx_queue(struct stmmac_priv *priv, u32 queue);
> -void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue);
>  int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags);

[Severity: Low]
This isn't a bug, but should this prototype be removed as well?

The only caller outside stmmac_main.c was stmmac_xdp_enable_pool(), and
this patch replaces that call with napi_schedule(). After this patch,
stmmac_xsk_wakeup() is referenced only by its definition and the
.ndo_xsk_wakeup entry in stmmac_main.c. It could be made static there.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index 7ecb7addd2ea7..907ac49a1b764 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c

[ ... ]

> @@ -34,23 +33,23 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
>  		      stmmac_xdp_is_enabled(priv);
>  
> -	if (need_update) {
> -		napi_disable(&ch->rx_napi);
> -		napi_disable(&ch->tx_napi);
> -		stmmac_disable_rx_queue(priv, queue);
> -		stmmac_disable_tx_queue(priv, queue);
> -	}
> +	if (need_update)
> +		stmmac_xdp_release(priv->dev);

[Severity: Medium]
Does this bounce the physical link on every live XSK pool bind and
unbind?

An earlier patch in this series ("net: stmmac: account for failed live
XDP reopening") made stmmac_xdp_release() call phylink_stop() and
stmmac_xdp_open() call phylink_start(). The attach path looks like this:

stmmac_xdp_enable_pool()
  stmmac_xdp_release()
    phylink_stop()
      phy_stop()
        PHY_HALTED: phy_link_down(), PHY_STATE_WORK_SUSPEND
        _phy_state_machine_post_work(): phy_suspend()
  stmmac_xdp_open()
    phylink_start()
      netif_carrier_off()
      autonegotiation restarts

stmmac_xdp_disable_pool() follows the same path on every socket close.

Each bind or unbind would then cause a carrier down/up event and a PHY
power-down followed by renegotiation, which typically takes seconds at
1000BASE-T. Traffic stops on every queue. The rings of all other queues
are freed and rebuilt, including queues serving other live AF_XDP
sockets.

The previous per-queue path touched only one queue and left the link
alone.

The commit message only says "This pauses all queues during a pool
change". Since the patch carries a Fixes: tag, could the commit message
mention the link flap? Alternatively, could pool changes avoid the
phylink stop/start?

>  
>  	set_bit(queue, priv->af_xdp_zc_qps);
>  
>  	if (need_update) {
> -		stmmac_enable_rx_queue(priv, queue);
> -		stmmac_enable_tx_queue(priv, queue);
> -		napi_enable(&ch->rxtx_napi);
> -
> -		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
> -		if (err)
> +		err = stmmac_xdp_open(priv->dev);
> +		if (err) {
> +			clear_bit(queue, priv->af_xdp_zc_qps);
> +			xsk_pool_dma_unmap(pool, STMMAC_RX_DMA_ATTR);
> +			netdev_err(priv->dev, "failed reopening after XSK pool attach: %pe; interface remains detached\n",
> +				   ERR_PTR(err));
>  			return err;
> +		}
> +
> +		/* The pool is installed even if link resolution is still pending. */
> +		napi_schedule(&priv->channel[queue].rxtx_napi);

[Severity: Medium]
Can this leave rxtx_napi repolling nonstop while the carrier is down?

The old code went through stmmac_xsk_wakeup(), which returns -ENETDOWN
when !netif_carrier_ok(). At this point the carrier is always down: the
PHY was just halted, and phylink_start() inside stmmac_xdp_open() has just
called netif_carrier_off(). If no cable is connected, it stays down
indefinitely.

Because tx_q->xsk_pool is set, the poll goes through:

stmmac_napi_poll_rxtx()
  stmmac_tx_clean()
    stmmac_xdp_xmit_zc()

stmmac_xdp_xmit_zc() checks the carrier before it looks at the XSK TX
ring:

	if (unlikely(stmmac_tx_avail(priv, queue) < STMMAC_TX_XSK_AVAIL) ||
	    !netif_carrier_ok(priv->dev)) {
		work_done = false;
		break;
	}

stmmac_tx_clean() then turns that into a full budget:

	if (work_done)
		xmits = budget - 1;
	else
		xmits = budget;
	...
	return max(count, xmits);

stmmac_napi_poll_rxtx() then returns without completing NAPI:

	if (rxtx_done >= budget)
		return budget;

Wouldn't this spin a CPU in softirq or ksoftirqd, even with an empty XSK
TX ring, until the carrier comes up or the interface is closed?

>  	}
>  
>  	return 0;

[ ... ]

> @@ -73,24 +72,21 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
>  	need_update = priv->datapath == STMMAC_DATAPATH_RUNNING &&
>  		      stmmac_xdp_is_enabled(priv);
>  
> -	if (need_update) {
> -		napi_disable(&ch->rxtx_napi);
> -		stmmac_disable_rx_queue(priv, queue);
> -		stmmac_disable_tx_queue(priv, queue);
> -		synchronize_rcu();
> -	}
> +	if (need_update)
> +		stmmac_xdp_release(priv->dev);
>  
>  	xsk_pool_dma_unmap(pool, STMMAC_RX_DMA_ATTR);

[Severity: Medium]
This is a pre-existing issue, but is the hardware DMA guaranteed to be
idle when the pool is unmapped here?

stmmac_xdp_release() does:

	stmmac_stop_all_dma(priv);

	/* Release and free the Rx/Tx resources */
	free_dma_desc_resources(priv, priv->dma_conf);

	/* Disable the MAC Rx/Tx */
	stmmac_mac_set(priv, priv->ioaddr, false);

dwmac4_dma_stop_rx() and dwmac4_dma_stop_tx() only clear the SR/ST bits.
They never poll for the Stopped state, and the MAC receiver is disabled
only after the rings have been freed.

A later commit in this series ("net: stmmac: retain DMA resources across
MTU changes") notes that "clearing a DMA enable bit need not finish an
in-flight frame immediately". An in-flight frame or descriptor writeback
could therefore land in freed descriptors or in the XSK buffers unmapped
here.

__stmmac_release(), the XDP program change path and the removed
per-queue helpers all follow the same stop-then-free pattern, so this
patch did not introduce it. The old synchronize_rcu() before the unmap
did not drain DMA either.

>  
>  	clear_bit(queue, priv->af_xdp_zc_qps);
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282%40gmail.com
