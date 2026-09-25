Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2B3EC687;
	Fri, 25 Sep 2026 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363522; cv=none; b=Mw8f063Q/ID0yXXpkzWleWxVeUwlkWkcXtfloEwXLQly0WvTn/zSNEc922oTt4bzg5Ksu62LPzi1ZdbAHgOD9YiZ/z0U3AAvXoUTOmyGivUB39VG7Bl8mfbgn2Eo5WoJaVMK1nnp+Si+yI70y+UeftXRnQzrEwkp0MgYeLiW5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363522; c=relaxed/simple;
	bh=MmZzCXTlD9GuDQAliRbMxdUOIEprPz8AXGvgzFZGsQI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b19Sf67yumONkFK/B99WbuE79EfkN0+8fGjOOHKGemQA3arDIYN2vCmwucebx8vJc/WNVOeQALJTIM6Jx+LbR2z6DTX14Gy1pq7K+LC4TPqz1yq4XB8Zlhr/yMCmbTQgcvE27IiNAUjCH7xrp4U6SHO3fj0lRWQhqSaL16EOGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBPALbDX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBPALbDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A89C1F000FF;
	Fri, 25 Sep 2026 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363518;
	bh=JKQU9QzUaWV5ZjO1MGHsN9TXv8ULJ7zYd/yNb9scKyA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZBPALbDXeMl+KSlyi8YgU8YsR95vkplh5n0tcSBHzLUDkBySA/O6t2viY7WHL8Avb
	 fgIPe7xmXkJ5EzCvO9Wt5t5vdNdbnt50rSmrZGNfaAyfq05T8Feez/1aZ6tDb/7Id1
	 AcUccL3YNYjeKf9Q1U/OvOCpUXK76bIYer50o9fYw3g57+l0LmpJsSFL7Q2Xe01Xck
	 QbvYWMyYmPP19RHeqKGVSzW0yo4Av1HOYqRiU+pgLbS2kDTYEbabhmlCwQNELZo/Vs
	 D84XxO3jkU14SFzAEBwEohtmQM4aHfjJcjnkUddomcjbCuR4Lop11pnUVFc+u4txPZ
	 JTz8p4+qJIbGQ==
Subject: Re: [PATCH net v3 03/10] net: stmmac: keep datapath state coherent
 after reinitialization failure
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
Date: Fri, 25 Sep 2026 19:11:56 +0000
Message-ID: <179036351610.2160803.7973266254141491623@kernel.org>
In-Reply-To:
 <20260924-submit-stmmac-reset-fixes-v1-v3-3-c031e3f3a282@gmail.com>
References:
 <20260924-submit-stmmac-reset-fixes-v1-v3-3-c031e3f3a282@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 3 (2) · Medium: 4 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] stmmac_resume_hw() now returns the error from
  stmmac_mdio_reset().
- [High] (Baseline: fixed later in the series.) In this commit,
  stmmac_xdp_set_prog() gates on priv->datapath == RUNNING, but…
- [High] (Baseline: fixed later in the series.) In this commit, the
  irq_error path of stmmac_xdp_open() frees the descriptor rings after…
- [Medium] stmmac_bpf() calls __stmmac_release() whenever datapath ==
  STMMAC_DATAPATH_SUSPENDED (and also HALTED at the end of the series).
- [Medium] In stmmac_suspend(), the early exit on `priv->hw_suspended`
  (goto suspend_bsp) comes before the new check that rejects suspend…
- [Medium] After an early resume failure, the new close-time sleep
  cleanup touches MAC registers without confirming that the hardware's…
- [Medium] (Baseline: fixed later in the series.) In this commit,
  stmmac_reinit_queues() and stmmac_reinit_ringparam() call the full…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch adds
  a guard at this exact spot and the guard does not cover it.
- [High] (Baseline: preexisting and fixed later in the series.)
  stmmac_quiesce() cancels the TX coalescing hrtimers before…
- [Medium] (Baseline: preexisting, not introduced.) If
  stmmac_pltfr_noirq_resume() fails in pm_runtime_force_resume() or in…

--

net: stmmac: keep datapath state coherent after reinitialization failure

This adds a datapath ownership state and a hw_suspended flag to
stmmac_priv. Close, suspend, resume and XDP paths use them to tell which
IRQ, DMA and NAPI resources are still owned after a failed MTU reopen or
a failed resume. It splits queue quiescing out of __stmmac_release(),
serializes suspend and resume with RTNL, and adds guards to the TC,
debugfs, XDP xmit and reset task paths.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4f3d452c35036..43a6154fcf6d7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4127,6 +4127,37 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
>  	return ERR_PTR(ret);
>  }
>  
> +/* Finish core sleep state even if the platform resume callback failed. */
> +static int stmmac_resume_hw(struct stmmac_priv *priv)
> +{
> +	int ret;
> +
> +	if (!priv->hw_suspended)
> +		return 0;
> +
> +	/* Use the state installed by suspend, not a subsequently changed WoL
> +	 * setting. Clear PMT even when a different device caused the wakeup.
> +	 */
> +	if (priv->irq_wake) {
> +		mutex_lock(&priv->lock);
> +		stmmac_pmt(priv, priv->hw, 0);
> +		mutex_unlock(&priv->lock);
> +		priv->irq_wake = 0;
> +	} else {
> +		ret = pinctrl_pm_select_default_state(priv->device);
> +		if (ret)
> +			return ret;
> +		if (priv->mii) {
> +			ret = stmmac_mdio_reset(priv->mii);
> +			if (ret)
> +				return ret;

[Severity: High]
On boards that use the snps,reset GPIO, could this return -EBUSY on
every resume without WoL?

stmmac_mdio_reset() requests the GPIO each time it runs:

drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:stmmac_mdio_reset() {
    ...
		reset_gpio = devm_gpiod_get_optional(priv->device,
						     "snps,reset",
						     GPIOD_OUT_LOW);
		if (IS_ERR(reset_gpio))
			return PTR_ERR(reset_gpio);
    ...
}

The first call happens at probe through __mdiobus_register()->bus->reset().
Devres then keeps the line requested until unbind. Later calls reach
gpiod_request_commit(), which returns -EBUSY for a line that is already
requested, because GPIOD_OUT_LOW is not a nonexclusive request.

Before this patch, stmmac_resume() ignored this return value. Now it does:

	if (priv->hw_suspended) {
		ret = stmmac_resume_hw(priv);
		if (ret)
			goto out_unlock;

On this error it skips stmmac_hw_setup(). The datapath stays
STMMAC_DATAPATH_SUSPENDED, the netdev stays detached and hw_suspended
stays set.

After that, stmmac_open() calls stmmac_resume_hw() and fails the same
way, while stmmac_release() only logs the error. Would the interface stay
unusable until the driver is rebound?

> +		}
> +	}
> +	priv->hw_suspended = false;
> +
> +	return 0;
> +}

[ ... ]

> @@ -4192,6 +4224,8 @@ static int __stmmac_open(struct net_device *dev,
>  
>  	stmmac_release_ptp(priv);
>  init_error:
> +	stmmac_stop_all_dma(priv);
> +	stmmac_mac_set(priv, priv->ioaddr, false);
>  	return ret;
>  }

[Severity: High]
This stops DMA on the __stmmac_open() failure path. Does stmmac_xdp_open()
still have the same problem? In this commit its error path is:

irq_error:
	for (chan = 0; ...)
		hrtimer_cancel(...);
init_error:
	free_dma_desc_resources(priv, &priv->dma_conf);

By this point stmmac_mac_set(priv, priv->ioaddr, true) and
stmmac_start_all_dma() have already run.

If the IRQ request fails during an XDP reopen, can the running DMA write
into the freed descriptor rings?

The later commit "net: stmmac: account for failed live XDP reopening" in
this series adds stmmac_stop_tx_queues(), stmmac_stop_all_dma() and
stmmac_mac_set(false) to that path.

[ ... ]

> @@ -4246,25 +4284,38 @@ static int stmmac_open(struct net_device *dev)
>  	return ret;
>  }
>  
> -static void __stmmac_release(struct net_device *dev)
> +/* Quiesce NAPI and transmit queues without releasing their resources. */
> +static void stmmac_quiesce(struct stmmac_priv *priv)
>  {
> -	struct stmmac_priv *priv = netdev_priv(dev);
>  	u8 chan;
>  
> -	/* Stop and disconnect the PHY */
> -	phylink_stop(priv->phylink);
> -
>  	stmmac_disable_all_queues(priv);
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
>  
> -	netif_tx_disable(dev);
> +	netif_tx_disable(priv->dev);
> +}

[Severity: High]
This isn't a bug introduced by this patch, but stmmac_quiesce() keeps the
old ordering. It cancels the TX coalescing hrtimers before
netif_tx_disable(), and it does not drain NAPI poll tails. Can
stmmac_xmit() or stmmac_napi_poll_tx()->stmmac_tx_timer_arm() re-arm a
txtimer after its final hrtimer_cancel()?

On the MTU path, __stmmac_open() then copies the new dma_conf over the
embedded timer. That could overwrite a queued hrtimer.

Later in this series, stmmac_quiesce() uses stmmac_stop_tx_queues(),
which calls netif_tx_disable() and synchronize_net() before
hrtimer_cancel(). The commit "net: stmmac: keep DMA configurations at
stable addresses" also replaces the dma_conf copy with a stable pointer.

[ ... ]

> @@ -4285,6 +4336,15 @@ static void __stmmac_release(struct net_device *dev)
>  static int stmmac_release(struct net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
> +	int ret;
> +
> +	/* Resume may have failed before restoring pins or disabling MAC wake.
> +	 * Complete that cleanup without restarting the link or the datapath.
> +	 * If it fails, keep hw_suspended set so a fresh open can retry it.
> +	 */
> +	ret = stmmac_resume_hw(priv);
> +	if (ret)
> +		netdev_err(dev, "failed to restore hardware sleep state: %d\n", ret);

[Severity: Medium]
Is it safe to touch MAC registers here after priv->plat->resume() has
failed? In that case stmmac_resume() returns early and leaves
hw_suspended set:

	if (priv->plat->resume) {
		ret = priv->plat->resume(dev, priv->plat->bsp_priv);
		if (ret)
			return ret;
	}

Glue suspend callbacks, such as the one in dwmac-rk, turn off clocks and
regulators. Only the resume callback that just failed turns them back on.

A later close then runs stmmac_release()->stmmac_resume_hw(). That does
the PMT register write, or the dummy writel() in stmmac_mdio_reset().
Next, __stmmac_release() runs stmmac_stop_all_dma() and stmmac_mac_set()
on the retained datapath. Neither step takes pm_runtime_resume_and_get()
or checks the power state first.

Before this patch, the same close hung in napi_disable() before it got
here. Depending on how far the glue resume got, could this now cause a
bus abort or silently dropped writes?

[ ... ]

> @@ -4298,6 +4358,8 @@ static int stmmac_release(struct net_device *dev)
>  	stmmac_legacy_serdes_power_down(priv);
>  	phylink_disconnect_phy(priv->phylink);
>  	pm_runtime_put(priv->device);
> +	/* Allow a fresh open after a failed MTU reopen or resume. */
> +	netif_device_attach(dev);
>  
>  	return 0;
>  }

[Severity: Medium]
How do the ethtool reinit paths behave in this commit?
stmmac_reinit_queues() and stmmac_reinit_ringparam() still do:

	if (netif_running(dev))
		stmmac_release(dev);
	...
	if (netif_running(dev))
		ret = stmmac_open(dev);

If that stmmac_open() fails, stmmac_release() has already dropped the PHY
and runtime PM references. IFF_UP is still set and the device is still
attached.

Would the next ndo_stop call pm_runtime_put() a second time and underflow
the usage count? In that state the netif_device_present() guards in the
TC callback and the reset task would not fire either.

The later commit "net: stmmac: retain PHY and PM ownership during ethtool
reopening" changes both functions to use netif_device_detach(),
__stmmac_release() and stmmac_reopen().

[ ... ]

> @@ -6425,6 +6492,8 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
>  
>  	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
>  		return ret;
> +	if (!netif_device_present(priv->dev))
> +		return -ENETDOWN;
>  
>  	__stmmac_disable_all_queues(priv);

[Severity: High]
This isn't a bug introduced by this patch, but does this guard cover an
interface that is administratively down? In that state the device is
present and NAPI is disabled. That holds for a device that was never
opened, and stmmac_release() now calls netif_device_attach() explicitly.

Adding a u32 or flower filter in that state still reaches
__stmmac_disable_all_queues():

	if (queue < rx_queues_cnt)
		napi_disable(&ch->rx_napi);

napi_disable_locked() then loops forever with RTNL held:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);

Would checking priv->datapath == STMMAC_DATAPATH_RUNNING here work better
than netif_device_present()?

[ ... ]

> @@ -6962,6 +7035,18 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> +	if (bpf->command != XDP_SETUP_PROG &&
> +	    bpf->command != XDP_SETUP_XSK_POOL)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Pool removal must succeed even after a failed resume. Release the
> +	 * suspended rings before their pool or XDP buffer layout can change.
> +	 * Leave the interface detached until it is closed and reopened.
> +	 */
> +	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED)
> +		__stmmac_release(dev);

[Severity: Medium]
Can this run in the middle of an ordinary system suspend? The check does
not look at hw_suspended, so it fires for any suspended datapath. Later in
the series the same applies to the halted state.

XSK pool teardown runs from xp_release_deferred(). That work is queued with
schedule_work() on system_wq, which is not frozen during suspend, and it
takes only RTNL:

	rtnl_lock();
	xp_clear_dev(pool);
	rtnl_unlock();

So the work can run after stmmac_suspend() has dropped RTNL and called
plat->suspend, or after stmmac_pltfr_noirq_suspend(). The noirq callbacks
also read priv->datapath without RTNL, although the new stmmac_priv
comment says the field is serialized by RTNL.

Suppose noirq suspend has already done clk_disable_unprepare(clk_ptp_ref)
and pm_runtime_force_suspend(). __stmmac_release() would then call
stmmac_free_irq(), stmmac_stop_all_dma() and stmmac_mac_set() on a
clock-gated MAC. stmmac_release_ptp() would also underflow the clk_ptp_ref
enable and prepare counts.

[ ... ]

> @@ -8193,34 +8286,41 @@ EXPORT_SYMBOL_GPL(stmmac_dvr_remove);

[ ... ]

>  int stmmac_suspend(struct device *dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	u8 chan;
>  
> -	if (!ndev || !netif_running(ndev))
> +	rtnl_lock();
> +	if (!netif_running(ndev) || priv->hw_suspended) {
> +		rtnl_unlock();
>  		goto suspend_bsp;
> +	}
> +
> +	/* A failed datapath cannot provide a working MAC wake path. It may
> +	 * even have released its wake IRQ. Do not silently suspend without WoL.
> +	 */
> +	if (priv->wolopts && priv->datapath != STMMAC_DATAPATH_RUNNING) {
> +		netdev_err(ndev, "cannot suspend failed datapath with MAC WoL enabled\n");
> +		rtnl_unlock();
> +		return -EBUSY;
> +	}

[Severity: Medium]
Can the hw_suspended shortcut above skip this WoL rejection? Consider
this sequence:

  1. Suspend with MAC WoL sets irq_wake = 1, sets hw_suspended = true and
     moves the datapath to STMMAC_DATAPATH_SUSPENDED.
  2. priv->plat->resume() fails, so stmmac_resume() returns before it
     clears hw_suspended.
  3. An XDP program change or AF_XDP pool teardown calls
     stmmac_bpf()->__stmmac_release(). That frees all IRQs, including the
     wake IRQ, and sets the datapath to STMMAC_DATAPATH_DOWN.
  4. On the next system suspend, hw_suspended is still set, so this
     function jumps straight to suspend_bsp.

The -EBUSY check never runs, and the system suspends with MAC WoL
configured but no wake IRQ. The commit message says this case is rejected
"rather than silently losing the configured wake source".

Should the WoL check come before the hw_suspended shortcut?

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 6128ed1bd521a..9bd622517389d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

[ ... ]

> @@ -984,12 +985,14 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
>  		if (ret)
>  			return ret;
>  
> -		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
> -		if (ret < 0) {
> -			netdev_warn(priv->dev,
> -				    "failed to enable PTP reference clock: %pe\n",
> -				    ERR_PTR(ret));
> -			return ret;
> +		if (priv->datapath != STMMAC_DATAPATH_DOWN) {
> +			ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
> +			if (ret < 0) {
> +				netdev_warn(priv->dev,
> +					    "failed to enable PTP reference clock: %pe\n",
> +					    ERR_PTR(ret));
> +				return ret;
> +			}
>  		}
>  	}

[Severity: Medium]
This is a pre-existing issue, but consider a failure in
pm_runtime_force_resume() or clk_prepare_enable(clk_ptp_ref) here. The
function then returns without holding the PTP clock reference, while the
datapath is still not STMMAC_DATAPATH_DOWN. Would a later close, through
stmmac_release_ptp(), or the next noirq suspend then disable clk_ptp_ref
a second time?

The pre-patch code had the same sequence. The new datapath checks only
cover the XDP cleanup case.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index d7e4db7224b0c..909219775507b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c

[ ... ]

> @@ -107,7 +109,7 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
>  	bool need_update;
>  	bool if_running;
>  
> -	if_running = netif_running(dev);
> +	if_running = priv->datapath == STMMAC_DATAPATH_RUNNING;
>  
>  	if (prog && dev->mtu > ETH_DATA_LEN) {
>  		/* For now, the driver doesn't support XDP functionality with

[Severity: High]
In this commit, stmmac_xdp_release() and stmmac_xdp_open() never update
priv->datapath. Further down, the return value of stmmac_xdp_open() is
ignored:

	if (if_running && need_update)
		stmmac_xdp_open(dev);

If that reopen fails, NAPI is disabled and the IRQs and rings are freed,
but the datapath stays STMMAC_DATAPATH_RUNNING.

Would a later close then call stmmac_quiesce() from __stmmac_release() and
hang in napi_disable() on NAPI that is already disabled? It could also
free the IRQs and rings a second time. Suspend, AF_XDP pool changes and
the debugfs ring dump would all trust the stale running state too.

The later commit "net: stmmac: account for failed live XDP reopening" in
this series fixes this. It sets the datapath to STMMAC_DATAPATH_DOWN in
stmmac_xdp_release(), sets it to running only when stmmac_xdp_open()
succeeds, and handles the reopen error in stmmac_xdp_set_prog().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282%40gmail.com
