Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A13AD539;
	Wed, 30 Sep 2026 04:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743924; cv=none; b=YbQaK8eV+mVyGy3ONeVE3fW8w2R0Rw8JutH9rmTA2rL6RXUayV8TR678axBLiKFSDpxxCoa+hQYw5u/YkVeh7liu0IukvqTjoxnwy/PDxgtEKSqQbW731xUchovIwfzbLYlxNHVjGNWrRwocfpfqzo7cx57verFPnV02JB3TVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743924; c=relaxed/simple;
	bh=df1pSSG34gO+mAKZQn2WV73rJLwUuwpRQt6pKH2NkDQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NurRTYkTpgS/srmIfTOopaausKRvX1fPeH0USqxWCLAFJlLUClt0C+PvTgh/1V9qR2pKEv0oL/MGudMlgnAC+Oe6x+QFL27eRS6zMK8WPvGd0DBYZizG6PYTwfmEvBoClUq9B2WupRxJQyoTSgsBcMJly7ZagxhkOFquHFqhlss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQZGrlci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQZGrlci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08F31F00899;
	Wed, 30 Sep 2026 04:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743921;
	bh=vrN+A0X0KTyilFwWOzxsQiFyGJzVtrqK0X8cSfJxtTE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NQZGrlci67oXn07kJR/S8vO9EjhhN+/fdlYufDGobWIM/uUMGA4mxr33rrc06UpUp
	 KWXoYJN8JZfeURBP7IOs9T9wZp07EFSrLcRE5IFRYQNVsnxrDw21ECCp8gau4wOC0u
	 ssDszhS7WixSfMgpwxqCA/CA54//34JteoA0YE4Xb+P2cuM7PeK1zP7u8WCkeQM95m
	 bIPjRkSBLedvjjmUakZWmoNSeFSP+51Qkld/wq5zVfurI0GSa/kStCgyA//6+VkSvU
	 /PVwRO1sdeExBIn7gxwrtA6xHF2Bc3Tewl5H6UO9q3UR2fmon6pQDdKy9sN/qirrfR
	 zQpkQC8acr+Gg==
Subject: Re: [PATCH net v4 13/15] net: stmmac: retain DMA memory until
 hardware shutdown completes
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, fancer.lancer@gmail.com, quic_jsuraj@quicinc.com,
 richardcochran@gmail.com, Joao.Pinto@synopsys.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 linusw@kernel.org, martin.blumenstingl@googlemail.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, horms@kernel.org,
 bjorn@kernel.org, thierry.reding@kernel.org, jonathanh@nvidia.com,
 wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 edumazet@kernel.org, richard.genoud@bootlin.com, alastair@d-silva.org,
 mripard@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 zhaojinming@uniontech.com, lorenzo.bianconi@oss.qualcomm.com,
 dinghui1111@163.com, linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
Date: Wed, 30 Sep 2026 04:51:57 +0000
Message-ID: <179074391749.434549.15093720940446108090@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-13-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-13-ec1c0250b3c9@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Resume puts retained RX descriptors back into service after the
  reset without rewriting their buffer addresses.
- [High] After a failed close, the retained ring set can stay attached to
  priv->dma_conf with all its allocations but with dma_owned cleared, so…
- [Medium] TX error recovery can now be lost for good.
- [Medium] On a failed DMA shutdown, stmmac_detach_xsk_buffers() sets
  every dma_conf->tx_queue[q].xsk_pool to NULL but never calls…
- [Medium] Once a config is left dma_owned by a failed drain, removal
  never retries the stop or reset before stmmac_free_dma_conf()…

--

net: stmmac: retain DMA memory until hardware shutdown completes

Before rings and buffers are released on close, XDP/XSK replacement or a
failed open, this patch waits for the DMA engines to report idle. If
they do not, it falls back to a completed global reset. Configurations
the hardware may still reach are tracked on a list and kept until a
later successful reset, and XSK DMA references are held independently.
TX hard error recovery moves to the process-context reset path, and
resume-time descriptor cleanup moves after the reset.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index edcb9a025385b..4d70645c4a4f8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> +static void stmmac_detach_xsk_buffers(struct stmmac_priv *priv,
> +				      struct stmmac_dma_conf *dma_conf)
> +{
> +	u32 queue;
> +
> +	/* Socket teardown cannot retain the pool itself. Drop software-only
> +	 * references, but keep each xsk_dma reference: hardware can still reach
> +	 * the mapped UMEM pages even after the pool and its heads are freed.
> +	 */
> +	for (queue = 0; queue < MTL_MAX_RX_QUEUES; queue++) {
> +		struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
> +
> +		if (!rx_q->xsk_pool)
> +			continue;
> +		dma_free_rx_xskbufs(priv, dma_conf, queue);
> +		xsk_pool_set_rxq_info(rx_q->xsk_pool, NULL);
> +		rx_q->xsk_pool = NULL;
> +	}
> +	for (queue = 0; queue < MTL_MAX_TX_QUEUES; queue++)
> +		dma_conf->tx_queue[queue].xsk_pool = NULL;
> +}

[Severity: Medium]
Are the zero-copy XSK TX frames still in the retained TX ring ever
completed after a failed shutdown? Each one reserved a completion queue
slot in xsk_tx_peek_desc() through xskq_prod_reserve_addr().

After a later successful reset, the retained config is freed through
free_dma_desc_resources() -> dma_free_tx_skbufs(). There,
stmmac_free_tx_buffer() counts the STMMAC_TXBUF_T_XSK_TX entries in
xsk_frames_done, but the completion is gated on the pool pointer:

    if (tx_q->xsk_pool && tx_q->xsk_frames_done) {
        xsk_tx_completed(tx_q->xsk_pool, tx_q->xsk_frames_done);

tx_q->xsk_pool was already cleared here, so those frames are dropped.

The socket can stay bound across ifdown/ifup, an XDP program swap, or a
pool change on another queue. In that case the next open attaches the
same pool, which still holds k reserved but unsubmitted CQ slots.

xskq_prod_submit_n() publishes entries in reservation order. Wouldn't
every later completion then report an address k frames behind, with
those k CQ slots and UMEM frames lost for good?

[ ... ]

> @@ -3072,25 +3205,17 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
>   * stmmac_tx_err - to manage the tx error
>   * @priv: driver private structure
>   * @chan: channel index
> - * Description: it cleans the descriptors and restarts the transmission
> - * in case of transmission errors.
> + * Description: stop submissions and request process-context DMA recovery.
>   */
>  static void stmmac_tx_err(struct stmmac_priv *priv, u32 chan)
>  {
> -	struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[chan];
> -
>  	netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, chan));
> -
>  	stmmac_stop_tx_dma(priv, chan);
> -	dma_free_tx_skbufs(priv, priv->dma_conf, chan);
> -	stmmac_clear_tx_descriptors(priv, priv->dma_conf, chan);
> -	stmmac_reset_tx_queue(priv, chan);
> -	stmmac_init_tx_chan(priv, priv->ioaddr, priv->plat->dma_cfg,
> -			    tx_q->dma_tx_phy, chan);
> -	stmmac_start_tx_dma(priv, chan);
> -
>  	priv->xstats.tx_errors++;
> -	netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));
> +	/* Recovery must wait for DMA before freeing or rewriting descriptors.
> +	 * Use the process-context reset path, not teardown in hard IRQ context.
> +	 */
> +	stmmac_global_err(priv);
>  }

[Severity: Medium]
Now that the in-IRQ restart is gone, TX recovery depends only on
stmmac_global_err() queueing the reset work. Can that request be lost?

stmmac_service_event_schedule() queues the work only when
STMMAC_SERVICE_SCHED is not already set:

    if (!test_bit(STMMAC_DOWN, &priv->state) &&
        !test_and_set_bit(STMMAC_SERVICE_SCHED, &priv->state))
            queue_work(priv->wq, &priv->service_task);

stmmac_reset_subtask() clears STMMAC_DOWN right after dev_open() has
re-requested the IRQs and restarted DMA. STMMAC_SERVICE_SCHED is only
cleared once the subtask returns:

stmmac_reset_subtask()
    dev_open(priv->dev, NULL);
    clear_bit(STMMAC_DOWN, &priv->state);
    clear_bit(STMMAC_RESETING, &priv->state);
    ...
stmmac_service_task()
    stmmac_reset_subtask(priv);
    clear_bit(STMMAC_SERVICE_SCHED, &priv->state);

Suppose a TX hard error lands in that window. It stops the queue and the
TX DMA channel, turns the carrier off and sets STMMAC_RESET_REQUESTED,
but no work gets queued. The worker also never re-checks
STMMAC_RESET_REQUESTED.

With the carrier off, dev_watchdog() won't call ndo_tx_timeout either.
Does the channel then stay stopped until an administrative down/up or a
link change?

[ ... ]

> @@ -3350,6 +3476,19 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
>  		netdev_err(priv->dev, "Failed to reset the dma\n");
>  		return ret;
>  	}
> +	stmmac_dma_reset_complete(priv);
> +	priv->dma_reset_needed = false;
> +
> +	if (reinit) {
> +		stmmac_reinit_dma_desc(priv);
> +	} else if (priv->datapath == STMMAC_DATAPATH_SUSPENDED) {
> +		/* Suspend only requested a stop. Do not modify its descriptors
> +		 * or release pending TX buffers until this reset has completed.
> +		 */
> +		stmmac_reset_queues_param(priv);
> +		stmmac_free_tx_skbufs(priv);
> +		stmmac_clear_descriptors(priv, priv->dma_conf);
> +	}

[Severity: High]
The commit message says:

  "Rebuild retained RX descriptors after reset with buffer addresses and
  chain links written before ownership."

and:

  "Likewise, move resume-time TX cleanup and descriptor rebuilding after
  the reset succeeds."

That rebuild is stmmac_reinit_dma_desc(), which only runs when reinit is
true. No caller in this patch passes true.

A later patch in the series ("net: stmmac: retain DMA resources across
MTU changes") passes it only for MTU rollback. At the end of the series,
stmmac_resume() still does:

    ret = stmmac_hw_setup(ndev, false, false);

So resume takes the STMMAC_DATAPATH_SUSPENDED branch above, which only
calls stmmac_clear_descriptors(). On GMAC4 that goes through
dwmac4_rd_init_rx_desc() -> dwmac4_set_rx_owner(). On XGMAC it goes
through dwxgmac2_init_rx_desc() -> dwxgmac2_set_rx_owner(). Both only OR
flags into des3:

    p->des3 |= cpu_to_le32(flags);

stmmac_suspend() disables NAPI in stmmac_quiesce() before
stmmac_stop_all_dma(). Frames the DMA completes in between stay in
writeback format: des0 holds VLAN tags or zero, and des1/des2 hold
status. Entries whose refill failed (buf->page == NULL) also stay in
writeback format.

After stmmac_start_all_dma() on resume, would the RX DMA take those
writeback words as buffer addresses and write received data there?

[ ... ]

> @@ -7967,6 +8183,8 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size)
>  		netif_device_detach(dev);
>  		__stmmac_release(dev);
>  	}
> +	if (stmmac_dma_busy(priv))
> +		return -EBUSY;
>  
>  	priv->dma_conf->dma_rx_size = rx_size;
>  	priv->dma_conf->dma_tx_size = tx_size;

[Severity: High]
Can priv->dma_conf still hold all of its allocations while dma_owned is
false, so that this check doesn't catch it? One sequence that seems to
get there:

1. ndo_stop -> __stmmac_release() -> stmmac_drain_dma(): the idle wait
   and stmmac_reset() both fail. Config A stays dma_owned.
   free_dma_desc_resources(A) only calls stmmac_detach_xsk_buffers(), so
   A keeps its descriptors, buf_pool, page_pool and tx_skbuff /
   tx_skbuff_dma arrays. A is not marked retired, because only
   stmmac_put_dma_conf() sets that.

2. ndo_open: stmmac_open() allocates config B. Then
   __stmmac_open(B) -> stmmac_hw_setup() -> stmmac_init_dma_engine()
   resets successfully, and stmmac_dma_reset_complete() sets
   A->dma_owned = false without freeing A.

3. A later step of the open fails, for example stmmac_rxp_config(),
   stmmac_tc_restore_filters(), stmmac_tc_restore_est(),
   stmmac_request_irq() or netif_set_real_num_queues().
   err_dma_resources restores priv->dma_conf = A and frees B.

4. With the interface down, ethtool -G reaches
   stmmac_reinit_ringparam(). stmmac_dma_busy() returns false, and
   A->dma_rx_size and A->dma_tx_size are overwritten.

5. On the next successful open, stmmac_put_dma_conf(A) ->
   free_dma_desc_resources(A) frees A using the new sizes.

If the new sizes are larger, dma_free_rx_skbufs() and
dma_free_tx_skbufs() loop up to the new size. Would they then write
buf->page = NULL and tx_skbuff_dma[i].buf = 0 past the ends of buf_pool
and tx_skbuff_dma, and unmap or free pointers read from beyond them?

Would dma_free_coherent() also be called with a size that doesn't match
the original allocation?

[ ... ]

> @@ -8508,12 +8740,28 @@ void stmmac_dvr_remove(struct device *dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> +	struct stmmac_dma_conf *dma_conf;
> +	u32 queue;
>  
>  	netdev_info(priv->dev, "%s: removing driver", __func__);
>  
>  	pm_runtime_get_sync(dev);
>  
>  	unregister_netdev(ndev);
> +	rtnl_lock();
> +	/* A failed ndo_open has no matching ndo_stop. Its retained resources
> +	 * still need retirement, or software-only disconnection on timeout.
> +	 */
> +	list_for_each_entry(dma_conf, &priv->dma_confs, list) {
> +		free_dma_desc_resources(priv, dma_conf);
> +		for (queue = 0; queue < MTL_MAX_RX_QUEUES; queue++) {
> +			struct xdp_rxq_info *rxq = &dma_conf->rx_queue[queue].xdp_rxq;
> +
> +			if (xdp_rxq_info_is_reg(rxq))
> +				xdp_rxq_info_unreg(rxq);
> +		}
> +	}
> +	rtnl_unlock();

[Severity: Medium]
If an earlier ndo_stop left a config dma_owned, is the stop or reset
ever retried before stmmac_free_dma_conf() quarantines it?

With the datapath already DOWN, __stmmac_release() returns early when
unregister_netdev() calls ndo_stop:

    if (priv->datapath == STMMAC_DATAPATH_DOWN)
        return;

This loop then only calls free_dma_desc_resources(). For owned configs
that is just the software XSK detach; neither stmmac_drain_dma() nor
stmmac_reset() is called.

Further down, stmmac_dvr_remove() asserts the IP reset:

    if (priv->plat->stmmac_rst)
        reset_control_assert(priv->plat->stmmac_rst);

dma_owned is never cleared, though, so the devm action
stmmac_free_dma_conf() skips kfree() for those configs.

After one transient stop/reset timeout followed by an unbind, wouldn't
these leak until reboot?

  - the coherent rings
  - page_pool pages and TX skbs
  - the xsk_dma references, with their UMEM pin and the device and
    netdev references taken by xp_dma_get()

The commit message describes quarantine as happening "If hardware still
cannot stop or reset at removal". Does removal ever actually test that?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
