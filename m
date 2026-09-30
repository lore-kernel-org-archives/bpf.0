Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AA3ACEFE;
	Wed, 30 Sep 2026 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743935; cv=none; b=uExPbebt7tW+xF1Ryyo9kXpRjusK8+Uz1d4xDzxXM8TMHi2BDB/LCfcqTt1R9HVzlQ58Wk2eNSw1dB8KxSszGjBY5vkiJWLtkEYwceFJOe8ubDU3cWqvPMeq9f14lYWrsKUggrwRI6GntKRxp6/Pkl9lGvukmvzKzKybwYEoNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743935; c=relaxed/simple;
	bh=8ywhAYWoPbgS+Gbsxai8A6lph1XhhnXID54X3n2FXb4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LeumhdAkuyvi4MLo4IIyx8LtnmTB4g9W5G5ND1NP0yXlnmbzpRi4+Z+loxRl+Y35muhe/QqLOqqpSBRG8r3GpY3hbjDkpXLl8IORM62DrQyjtRgOBQn6JNMiFsWpwClk8L+vToqFj7aa/HZqvt7dvz/6gYaV/B+jZVRVUFbsSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNejObcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNejObcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9A21F000FF;
	Wed, 30 Sep 2026 04:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743928;
	bh=igtVl4jmPv/GxYhXWE0vCTn4PzBIYTexddEIEcvNIbI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DNejObcCs7NshfvN5OW0lISSTMy8XWLv0DCXfQZGQKXI7SUay+G0avPo7qTTDnYwk
	 RuJySsbOj2uupimKSG+qU6F3UW+rLi6NA1cYfN1cGMJqrhNP1Vf2oNGVb73XPLO/wR
	 N/wJubOZJAB/8YfyJNKIMMJ3oqF8NjeEpTL+dVI2T6hr2mCZyTAsZs64QZGwTuUz9H
	 myhqJLkUTgi51qA/3VT2+EmN+l+fSFotUn1Ql8YGOwFWtdURZvH/vGKusUvNwtankt
	 mzM8G7tXmWJLSqFIAOgbOpMm6p0Yl6QncmsQSBFUMcX17BgeDbM7uwXCtjAs58tru/
	 YoLnY88h4d82w==
Subject:
 Re: [PATCH net v4 15/15] net: stmmac: retain DMA resources across MTU changes
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
Date: Wed, 30 Sep 2026 04:52:04 +0000
Message-ID: <179074392485.434549.10940493400361936935@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-15-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-15-ec1c0250b3c9@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] stmmac_reconfigure_mtu()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c) calls…
- [Medium] stmmac_reconfigure_mtu() takes priv->ptp_mutex
  (stmmac_main.c:6668) before it calls phylink_stop().
- [Medium] stmmac_reconfigure_mtu() masks only the per-channel DMA
  interrupt enables (stmmac_set_dma_irq_state -> set_irq_mask).
- [Medium] Before the first stmmac_hw_setup(), stmmac_reconfigure_mtu()
  calls phylink_prepare_resume().

--

net: stmmac: retain DMA resources across MTU changes

This patch replaces the release/reopen sequence for live jumbo MTU
changes with a new function, stmmac_reconfigure_mtu(). The new function
keeps the old rings and IRQ registrations so a failed setup can be rolled
back. If the rollback also fails, the interface is left detached in a new
STMMAC_DATAPATH_HALTED state that close or a later down/up can clean up.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 08049c05ffc48..8964f52c26bae 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -6601,6 +6651,109 @@ static void stmmac_set_rx_mode(struct net_device *dev)
>  	stmmac_set_filter(priv, priv->hw, dev);
>  }
>  
> +static int stmmac_reconfigure_mtu(struct net_device *dev, int mtu)
> +{

[ ... ]

> +	mutex_lock(&priv->ptp_mutex);
> +	stmmac_block_ptp(priv, true);
> +	netif_device_detach(dev);
> +	phylink_stop(priv->phylink);

[Severity: Medium]
Can holding ptp_mutex across phylink_stop() create a lock ordering cycle?

phylink_stop()->phylink_run_resolve_and_disable() does:

    queue_work(system_power_efficient_wq, &pl->resolve);
    flush_work(&pl->resolve);

so lockdep records a ptp_mutex -> resolve work dependency.

On link down, the resolve worker runs
phylink_resolve()->phylink_link_down()->phylink_deactivate_lpi()->
stmmac_mac_disable_tx_lpi(), and that takes priv->lock. With MAC WoL,
phylink_stop() also calls phylink_link_down() directly under state_mutex.

stmmac_resume() takes the two locks in the opposite order:

    mutex_lock(&priv->lock);
    ...
    mutex_lock(&priv->ptp_mutex);

Together these form ptp_mutex -> resolve work -> priv->lock -> ptp_mutex.
Both the MTU path and the resume path hold RTNL today, so this may not
deadlock in practice. The resolve worker does not hold RTNL, though.

Once an MTU change, an LPI link-down and a resume have all run, won't
lockdep report a circular dependency? Before this patch, nothing called
phylink_stop() with ptp_mutex held.

Could ptp_mutex be taken after phylink_stop() and stmmac_quiesce()
instead?

> +	stmmac_quiesce(priv);
> +	if (stmmac_fpe_supported(priv))
> +		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
> +
> +	/* Drain handlers before the final TX stop and configuration swap,
> +	 * and keep the registrations for rollback.
> +	 */
> +	stmmac_set_dma_irq_state(priv, false, irq_mask);
> +	stmmac_synchronize_irq(priv);

[Severity: Medium]
Only the per-channel DMA interrupt enables are masked here. What happens
to the MAC core interrupt sources? On dwmac4, dwmac4_core_init() writes
GMAC_INT_DEFAULT_ENABLE (PMT, LPI and TSIE) to GMAC_INT_EN, and none of
those are masked.

While ptp_blocked is set, stmmac_common_interrupt() skips the timestamp
acknowledgement:

    if (!READ_ONCE(priv->ptp_blocked))
        stmmac_timestamp_interrupt(priv, priv);

The only place that clears the TS interrupt is timestamp_interrupt(),
which reads GMAC_TIMESTAMP_STATUS.

Suppose an extts snapshot or a PPS target time event arrives between
stmmac_block_ptp(priv, true) and the unblock at the restart label. Can a
level-triggered line then keep firing, with stmmac_interrupt() returning
IRQ_HANDLED every time? That window includes the sleeping
phylink_stop()/flush_work() and synchronize_net(). It also covers the
time after stmmac_ptp_restore() re-arms extts/PPS inside
stmmac_hw_setup().

On a single-CPU system, could this stop the thread that performs the
reset from ever running?

The failed rollback branch further down has a related problem:

    stmmac_set_dma_irq_state(priv, false, irq_mask);
    stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
    ...
    priv->datapath = STMMAC_DATAPATH_HALTED;

The failed stmmac_hw_setup() has already run stmmac_core_init(), which
re-enables the MAC interrupts, before its later fallible steps
(stmmac_rxp_config(), stmmac_tc_restore_filters(),
stmmac_restore_timestamping(), stmmac_tc_restore_est()).
stmmac_mac_set(false) only clears RE/TE.

stmmac_request_irq_single() registers dev->irq with IRQF_SHARED. If the
MAC raises LPI, TS, PMT or safety status after the handler is freed,
could the shared line storm until the IRQ core disables it? That would
break the unrelated devices that the commit message says this design
keeps working. The old failed-reopen path behaved similarly for this
second case, but the ptp_blocked window above is new.

> +	stmmac_stop_tx_queues(priv);
> +
> +	ret = stmmac_prepare_rx_buffers(priv);
> +	if (ret)
> +		goto restart;
> +
> +	stmmac_stop_all_dma(priv);
> +	phylink_prepare_resume(priv->phylink);
> +
> +	/* MAC receive limits must be programmed for the prospective MTU. */
> +	WRITE_ONCE(dev->mtu, mtu);
> +	priv->dma_conf = new_conf;
> +	stmmac_reset_queues_param(priv);
> +	ret = stmmac_hw_setup(dev, false, true);

[Severity: Medium]
Does passing keep_ptp=true here still work if the PTP reference clock
was never enabled at open?

stmmac_setup_ptp() only warns when the clock fails to enable:

    ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
    priv->ptp_clock_enabled = !ret;
    ...
    if (ret < 0) {
        netdev_warn(...);
        return;
    }

However, stmmac_restore_timestamping() checks only dma_cap and
clk_ptp_rate before it programs the counter. It does not look at
priv->ptp_clock_enabled:

    if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp) ||
        !priv->plat->clk_ptp_rate)
        return 0;

    ret = stmmac_init_tstamp_counter(priv, priv->systime_flags);

Further down,
stmmac_hw_setup()->stmmac_restore_timestamping()->stmmac_ptp_restore()->
config_addend() polls TSADDREG for up to 100ms:

    return readl_poll_timeout_atomic(ioaddr + PTP_TCR, value,
                                     !(value & PTP_TCR_TSADDREG),
                                     10, 100000);

On hardware where this handshake cannot complete while the reference
clock is gated, the rollback stmmac_hw_setup(dev, true, true) would fail
the same way. Wouldn't that leave the interface in
STMMAC_DATAPATH_HALTED?

Before this patch, the MTU path went through __stmmac_open(). That called
stmmac_hw_setup() with keep_ptp=false and then stmmac_setup_ptp(), which
tolerates this failure. Should stmmac_restore_timestamping() also check
priv->ptp_clock_enabled?

> +	if (ret) {
> +		stmmac_stop_all_dma(priv);
> +		stmmac_mac_set(priv, priv->ioaddr, false);
> +		priv->dma_conf = old_conf;
> +		WRITE_ONCE(dev->mtu, old_mtu);
> +
> +		/* Reuse the retained rings. Reinitialize them only after reset
> +		 * has completed, not merely after clearing the DMA enable bits.
> +		 */
> +		restore_ret = stmmac_hw_setup(dev, true, true);
> +		if (restore_ret) {
> +			stmmac_stop_all_dma(priv);
> +			stmmac_mac_set(priv, priv->ioaddr, false);
> +			/* Setup may have restored DMA interrupt enables. */
> +			stmmac_set_dma_irq_state(priv, false, irq_mask);
> +			stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
> +			stmmac_stop_tx_queues(priv);
> +			stmmac_stop_all_dma(priv);
> +			memset(irq_mask, 0, sizeof(irq_mask));
> +			stmmac_set_dma_irq_state(priv, true, irq_mask);
> +			priv->datapath = STMMAC_DATAPATH_HALTED;
> +			netdev_err(dev, "MTU rollback failed: %pe; interface remains detached\n",
> +				   ERR_PTR(restore_ret));
> +			goto free_new;

[Severity: Medium]
Does anything undo the earlier phylink_prepare_resume() on this path?

On mac_requires_rxc platforms, phylink_prepare_resume() calls
phy_resume() on the PHY that phylink_stop() has just suspended. The
HALTED branch never calls phylink_stop() or phy_suspend(). The PHY stays
powered and can present link to the partner while the interface is
detached. That lasts until close, when __stmmac_release() calls
phylink_stop().

The init_error path in __stmmac_open() does undo it:

init_error:
	phylink_stop(priv->phylink);
	stmmac_drain_dma(priv);
	phylink_stop(priv->phylink);

Should the HALTED branch also call phylink_stop() before it returns?

> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
