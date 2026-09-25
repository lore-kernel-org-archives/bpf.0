Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83A470433;
	Fri, 25 Sep 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363530; cv=none; b=HaOtIszL6m+3bg7/66IGy8xfLocM2dNemqStyOnwAkjCU6PQF72vJviS8xzN6eSpv4H+hdK4rMj7BMER4N/hnv/9OKz7UVVPie6cJrKaiVrtLH3xWK+kTJkS8qVv8K0sf2fViNqmMwZ9CLWpbbzukPzGhrQRs+9YGtdtGMvpPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363530; c=relaxed/simple;
	bh=6wH3KcJDmGUKoqXG0jFV73TJG/67bHp9rKc6uzd/gJw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxUUx3Iosk7SCm32hKYJ9q8Aq7VyeS2nhIqB/o91D7imtaGWD+i4DqJOvTSEmT6CdCyOH9RhM1GMICDokVnUHjwVDru9oUGDTVln6YA4sP1eNiS821H4BIyPWlwaEs6a5i8CxIM+jFCqKjJOhJZkqWQ5mgUykiZ/vGG4Q3G+e5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR7ixijD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR7ixijD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2761F000FF;
	Fri, 25 Sep 2026 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363524;
	bh=j60HMtfGTi5eBikMo7Dlitd6O6BP/MQk73xPGWTZ4lQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NR7ixijDtlKHhJAOMaQZyckJbqnBNEopUbcqLdZC7vMilmPLijp+YbhOg/KP9csly
	 3hoehJMj5P8fuFYRLbvDmdCm6+GZVV9GkzdnNyBO9T83GXhorb3iVJomZAHTupTATx
	 /X3lKaKosaYNwxmU2cJRB8JUlkoe1HRc077mN3Fx4wLelOXm24tYxePD9YDBpFxYv0
	 Tma7is9IL+UhdJvG5hUI734m8D5Hxa67gldk54YGx7AsH+5+SdJrJBChnESxwfxJax
	 +X6J1kNDkFpnGCX9zYlctK8SJDwwgYaGUhI4r6jbsz+D5J4scInjWRvnbyR34tGHsJ
	 QPRZ1PPVXljeg==
Subject: Re: [PATCH net v3 06/10] net: stmmac: keep DMA configurations at
 stable addresses
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
Date: Fri, 25 Sep 2026 19:12:01 +0000
Message-ID: <179036352184.2160803.4739778084807600711@kernel.org>
In-Reply-To:
 <20260924-submit-stmmac-reset-fixes-v1-v3-6-c031e3f3a282@gmail.com>
References:
 <20260924-submit-stmmac-reset-fixes-v1-v3-6-c031e3f3a282@gmail.com>
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

Critical: 0 · High: 1 · Medium: 3 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Baseline decision: not confirmed as a remaining issue.
- [Medium] In drivers/net/ethernet/stmicro/stmmac/stmmac_main.c, the EEE
  software LPI timer can access a freed DMA configuration.
- [Medium] In drivers/net/ethernet/stmicro/stmmac/stmmac_main.c,
  stmmac_features_check() (ndo_features_check) calls…
- [Medium] Baseline decision: not confirmed as a remaining issue.

Pre-existing issues:
- [Medium] Baseline decision: not confirmed as a remaining issue.

--

net: stmmac: keep DMA configurations at stable addresses

This commit turns priv->dma_conf from an embedded struct into a pointer
to the allocated DMA configuration. The goal is to keep RXQ metadata
registered with XDP and AF_XDP at a stable address. Per-queue MSI
handlers now use priv->channel[] as their cookie. stmmac_quiesce()
drains transmitters and NAPI with synchronize_net() before cancelling
the TX hrtimers. On success the open and MTU paths free the old
configuration, and on failure they restore it.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3b918cf898067..ce598b5757637 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -463,7 +463,7 @@ static bool stmmac_eee_tx_busy(struct stmmac_priv *priv)
>  
>  	/* check if all TX queues have the work finished */
>  	for (queue = 0; queue < tx_cnt; queue++) {
> -		struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
> +		struct stmmac_tx_queue *tx_q = &priv->dma_conf->tx_queue[queue];
>  
>  		if (tx_q->dirty_tx != tx_q->cur_tx)
>  			return true; /* still unfinished work */

[Severity: Medium]
Now that dma_conf is a separate allocation that gets freed on reopen,
can the EEE software LPI timer read a freed configuration here? The
timer path is:

stmmac_eee_ctrl_timer()
  stmmac_try_to_start_sw_lpi()
    stmmac_eee_tx_busy()
      tx_q = &priv->dma_conf->tx_queue[queue];

No lock or RCU protects the priv->dma_conf load.

__stmmac_release() calls phylink_stop() first, and that reaches
stmmac_mac_disable_tx_lpi():

    priv->eee_sw_timer_en = false;
    timer_delete_sync(&priv->eee_ctrl_timer);

NAPI is still running at that point. stmmac_tx_clean() checks the flag
without a lock before it re-arms the timer:

    if (priv->eee_sw_timer_en && !priv->tx_path_in_lpi_mode)
        stmmac_restart_sw_lpi_timer(priv);

Suppose that check passes just before the flag is cleared. Then
mod_timer() can run after timer_delete_sync() has returned. Nothing in
stmmac_quiesce() cancels eee_ctrl_timer again.

Next, suppose the callback loads the old priv->dma_conf before
__stmmac_open() stores the new one, and is then delayed (for example,
preempted in the timer softirq thread on PREEMPT_RT). It would then
dereference tx_queue[] after kfree(old_conf) in stmmac_change_mtu() or
stmmac_open(). Before this patch the configuration was embedded in
priv, so the worst case was a stale read.

Later in the series, stmmac_reconfigure_mtu() adds
timer_delete_sync(&priv->eee_ctrl_timer) after stmmac_quiesce(). The
ethtool ring and channel paths still seem to lack it:

stmmac_reinit_ringparam() / stmmac_reinit_queues()
  __stmmac_release()
  stmmac_reopen()
    __stmmac_open()
    kfree(old_conf)

The close/open path also seems to lack it. Should the EEE timer also be
cancelled on those paths after NAPI is quiesced?

[ ... ]

> @@ -3650,7 +3650,7 @@ static bool stmmac_tso_channel_permitted(struct stmmac_priv *priv,
>  					 unsigned int chan)
>  {
>  	/* TSO and TBS cannot co-exist */
> -	return !(priv->dma_conf.tx_queue[chan].tbs & STMMAC_TBS_AVAIL);
> +	return !(priv->dma_conf->tx_queue[chan].tbs & STMMAC_TBS_AVAIL);
>  }

[Severity: Medium]
stmmac_features_check(), the ndo_features_check callback, calls this.
Can it read priv->dma_conf after the old configuration has been freed?

netif_skb_features() is called from paths that neither
netif_device_detach() nor stopped TX queues exclude:

- tbf_segment() in net/sched/sch_tbf.c, and similarly taprio, cake,
  netem and dualpi2
- ip_finish_output_gso() and its IPv6 counterpart
- validate_xmit_skb() in sch_direct_xmit(), before the stopped-queue
  check

In stmmac_change_mtu(), the only synchronize_net() is the one inside
__stmmac_release(), and it runs before the pointer swap:

stmmac_change_mtu()
  netif_device_detach(dev)
  __stmmac_release(dev)
    stmmac_quiesce()
      synchronize_net()
  __stmmac_open(dev, dma_conf)
    priv->dma_conf = dma_conf;
  kfree(old_conf)

A GSO feature check could load the old pointer after that drain and be
preempted until after kfree(old_conf). It would then read tbs from
freed memory.

The same ordering seems to remain at the end of the series. In
stmmac_reconfigure_mtu(), synchronize_net() runs before
priv->dma_conf = new_conf, followed by kfree(old_conf). stmmac_reopen()
does the same for ring and channel changes.

Is a grace period needed between publishing the new configuration and
freeing the old one?

[ ... ]

> @@ -6267,10 +6274,12 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>  			return PTR_ERR(dma_conf);
>  		}
>  
> +		netif_device_detach(dev);
>  		__stmmac_release(dev);
>  
>  		ret = __stmmac_open(dev, dma_conf);
>  		if (ret) {
> +			priv->dma_conf = old_conf;
>  			free_dma_desc_resources(priv, dma_conf);
>  			kfree(dma_conf);
>  			/*
> @@ -6282,9 +6291,10 @@ static int stmmac_change_mtu(struct net_device *dev, int new_mtu)
>  			return ret;
>  		}
>  
> -		kfree(dma_conf);
> +		kfree(old_conf);

[Severity: High]
The commit message says:

  Drain transmitters and NAPI poll tails before cancelling TX timers so
  a late rearm cannot outlive the configuration containing the timer.

Can a TX hard-error interrupt restart transmitters after that drain?
__stmmac_release() runs stmmac_quiesce() and frees the IRQs only
afterwards:

    stmmac_quiesce(priv);
    ...
    stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
    stmmac_stop_all_dma(priv);
    free_dma_desc_resources(priv, priv->dma_conf);

In that window, stmmac_msi_intr_tx() calls stmmac_tx_err(), which ends
with:

    netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, chan));

Once a queue is woken, stack transmitters can enter stmmac_xmit() or
stmmac_tso_xmit() again. They would be using the old configuration
while free_dma_desc_resources() frees its rings, and while this
kfree(old_conf) frees the struct itself.

Two later commits in the series deal with this:

- "net: stmmac: account for failed live XDP reopening" adds a second
  stmmac_stop_tx_queues() after stmmac_free_irq() in
  __stmmac_release().
- "net: stmmac: retain DMA resources across MTU changes" disables IRQ
  handling in stmmac_reconfigure_mtu() before replacing the
  configuration.

At this patch, though, can the old configuration still be in use after
kfree(old_conf)?

[ ... ]

> @@ -7251,7 +7253,7 @@ void stmmac_xdp_release(struct net_device *dev)
>  	stmmac_disable_all_queues(priv);
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
> -		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> +		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
>  
>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);

[Severity: Medium]
This isn't a bug introduced by this patch, but stmmac_xdp_release()
still cancels the TX hrtimers right after stmmac_disable_all_queues().
It does not run the synchronize_net() that stmmac_quiesce() now uses.
Can a NAPI poll tail re-arm a timer after this cancel?

After napi_complete_done() clears SCHED, stmmac_tx_timer_arm() can see
napi_is_scheduled() == false and call hrtimer_start(). stmmac_xdp_open()
then calls hrtimer_setup() on the same txtimer, which could
re-initialize an armed hrtimer.

Later in the series, "net: stmmac: account for failed live XDP
reopening" addresses this by making stmmac_xdp_release() call
stmmac_quiesce().

[ ... ]

> @@ -7382,11 +7382,9 @@ int stmmac_xsk_wakeup(struct net_device *dev, u32 queue, u32 flags)
>  	    queue >= priv->plat->tx_queues_to_use)
>  		return -EINVAL;
>  
> -	rx_q = &priv->dma_conf.rx_queue[queue];
> -	tx_q = &priv->dma_conf.tx_queue[queue];
>  	ch = &priv->channel[queue];
>  
> -	if (!rx_q->xsk_pool && !tx_q->xsk_pool)
> +	if (!test_bit(queue, priv->af_xdp_zc_qps))
>  		return -EINVAL;

[Severity: Medium]
Is the af_xdp_zc_qps bit a strong enough guard here? In
stmmac_xdp_enable_pool(), the sequence is:

    set_bit(queue, priv->af_xdp_zc_qps);
    ...
    stmmac_enable_rx_queue(priv, queue);
    stmmac_enable_tx_queue(priv, queue);
    napi_enable(&ch->rxtx_napi);
    err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);

Both enable helpers return void. If they fail, dma_rx, buf_pool and
xsk_pool are left NULL.

If both queue re-enables fail, the old check returned -EINVAL. The new
check lets NAPI run stmmac_rx_zc() on a NULL ring and pool.

This seems to go away later in the series with "net: stmmac: use the
tracked datapath restart for XSK pool changes". That commit switches to
stmmac_xdp_release()/stmmac_xdp_open() and clears the bit when the
reopen fails.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282%40gmail.com
