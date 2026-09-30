Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D623AFCF3;
	Wed, 30 Sep 2026 04:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743915; cv=none; b=Cin/RwjKWUWu4S3bwFZDasIhBKgqr6xIDzrQcLyVd3covwnidr7VJD1KvV1iIhYq7AfHaZ3OPxx75kNSLhxoJx4qWtHqBsKlxjqU9wXtbjuPkGq3DeYBAR1Ra7TAlSD5XGrXshah1WHexa0uaCW9IATYkmLwECc/e4K9cdQ6+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743915; c=relaxed/simple;
	bh=tf6NB4SiS5TxBZu2onY22IzSuBet1qx4+ctznNvdR/M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fz62OY/ppgptS1AAD/whrvKpl0E9VdjIHs7f17d+eHzjJrmJowGY0gDIX/OAPeUw9Sg3M79RRZY8cyNjru0aGkNhq1OWjn87RnI8cU11xTaRu3m+kYgg2Ny/EtrIGv+v6Dct6BEeeoZxiPqTjMJkfScyHIDg1jI+IjEIE7c4Cns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVqfpfKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVqfpfKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E841F00893;
	Wed, 30 Sep 2026 04:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743910;
	bh=EzyrbWTGfJV8Y8A+yuLWt+ydpPDFyZ76nI18zyPXRR8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HVqfpfKAV2UgVDNKpNZ0vgBqo0Tnkd+SE7iQkgSLvlVskO2qIzJGC3xixhNvbS20L
	 O/h3S7AM02yKl4ODuoegNqfb0HxuFcsgB8ga57Jiid+merRGTBB1DriQvZVs8UzLfJ
	 uTTLd5qI35ihQyp+E/kIS9tBmzKB0sbhAeMjzyU0/oNudqirixL8CqRF2nIDHtVuhf
	 ahL7gxiLh7jvqT+7qd6Ec3d0zn9ubL5zNfKB2SSbxOiCVVEWqGnxUvBzZYvV3kWcIB
	 mkwRrAUc6v20uEt3WhyPtgrGqSPFzbr5EopjNn3yKYm2j5eXM+pMub255cp8O4FpC7
	 9x6Bo0xjtjUzg==
Subject: Re: [PATCH net v4 09/15] net: stmmac: track datapath and power
 ownership across failed reopening
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
Date: Wed, 30 Sep 2026 04:51:47 +0000
Message-ID: <179074390721.434549.314508523754331236@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-9-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-9-ec1c0250b3c9@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Platforms that have a resume hook but no suspend hook no longer
  run the resume hook on system resume.
- [High] The new 'retry pending power transitions' logic misuses
  pm_runtime_force_resume(), which only does its work once.
- [High] While hw_unavailable is set, stmmac_interrupt() and
  stmmac_mac_interrupt() (and the safety and MSI rx/tx handlers) return…
- [High] With MAC WoL enabled, stmmac_suspend() calls phylink_suspend(pl,
  true), which only sets PHYLINK_DISABLE_MAC_WOL and does not call…
- [Medium] A failed system resume leaves the PHY powered after it was
  resumed only to supply the MAC reset clock.
- [Medium] stmmac_bpf() calls __stmmac_release() on a retained SUSPENDED
  datapath (and, at the end of the series, HALTED) for every…
- [Medium] On platforms without plat->suspend (so bsp_suspended is never
  set), a resume where only re-enabling the optional PTP reference clock…
- [Medium] stmmac_suspend() sets priv->bsp_suspended = true before
  calling priv->plat->suspend(), and does not clear it if the callback…
- [Low] Submission scope and stable backportability: one commit carries
  five Fixes: tags and many independent behaviour changes, and it…

--

net: stmmac: track datapath and power ownership across failed reopening

This commit tracks datapath state (down, running, suspended) separately
from IFF_UP. On failure, the MTU, XDP and ethtool reopen paths now leave
the device detached instead of tearing it down. It also splits core sleep
cleanup from platform and clock restoration, and adds an hw_unavailable
gate on MMIO, MDIO, PHC and IRQ access while power is not restored.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index c4ba97d57b47e..22a65c1c16810 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -959,7 +966,26 @@ static void stmmac_setup_ptp(struct stmmac_priv *priv)
>  static void stmmac_release_ptp(struct stmmac_priv *priv)
>  {
>  	stmmac_ptp_unregister(priv);
> -	clk_disable_unprepare(priv->plat->clk_ptp_ref);
> +	mutex_lock(&priv->pm_mutex);
> +	if (priv->ptp_clock_enabled) {
> +		clk_disable_unprepare(priv->plat->clk_ptp_ref);
> +		priv->ptp_clock_enabled = false;
> +	}
> +	/* A later noirq resume must not reacquire a released reference. */
> +	priv->ptp_clock_suspended = false;
> +	mutex_unlock(&priv->pm_mutex);
> +}

[Severity: Medium]
Can clearing ptp_clock_suspended here stop the interface from opening
until the next system sleep?

Take a platform with no plat->suspend, so bsp_suspended is never set.
Suppose noirq resume restores the bus clocks but
clk_prepare_enable(clk_ptp_ref) fails. ptp_clock_suspended stays true.
stmmac_resume()->stmmac_resume_power(priv, true) fails the same way and
returns before hw_unavailable is cleared.

If the interface is then closed,
stmmac_release()->__stmmac_release()->stmmac_release_ptp() clears
ptp_clock_suspended here. On the next open,
stmmac_open()->stmmac_resume_power(priv, false) evaluates:

	bool pending = priv->bus_clks_suspended || priv->bsp_suspended ||
		       priv->ptp_clock_suspended;

as false. hw_unavailable is never cleared, so every open attempt returns
-EHOSTDOWN.

stmmac_setup_ptp() treats a PTP reference clock failure as only a
warning. Should this optional clock be able to block the whole MAC?

[ ... ]

> @@ -4164,6 +4217,89 @@ stmmac_setup_dma_desc(struct stmmac_priv *priv, unsigned int mtu)
>  	return ERR_PTR(ret);
>  }
>  
> +/* The freezer excludes pool teardown and userspace from noirq callbacks.
> + * Outside system sleep these flags are changed under RTNL.
> + */
> +int stmmac_resume_clocks(struct stmmac_priv *priv)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&priv->pm_mutex);
> +	if (priv->bus_clks_suspended) {
> +		ret = pm_runtime_force_resume(priv->device);
> +		if (ret)
> +			goto out;
> +		priv->bus_clks_suspended = false;
> +	}

[Severity: High]
Is pm_runtime_force_resume() safe to retry like this?

In drivers/base/power/runtime.c it clears needs_force_resume and calls
pm_runtime_enable() on both success and failure:

	if (!dev->power.needs_force_resume && (!dev_pm_smart_suspend(dev) ||
	    pm_runtime_status_suspended(dev)))
		goto out;
	...
out:
	dev->power.needs_force_resume = false;
	pm_runtime_enable(dev);
	return ret;

Suppose the noirq call fails, for example when stmmac_runtime_resume()
fails a clock enable. bus_clks_suspended stays true. The retry from
stmmac_resume(), stmmac_open() or stmmac_release() then skips the
callback, does an unbalanced pm_runtime_enable(), and returns 0.

stmmac_resume_clocks() then clears bus_clks_suspended and
stmmac_resume_power() clears hw_unavailable. After that,
stmmac_resume_hw() and stmmac_hw_setup() access MMIO while the bus
clocks are still off.

stmmac_pltfr_noirq_suspend() has the same problem. It sets the flag
before the call and does not roll it back if the call fails:

		priv->bus_clks_suspended = true;
		ret = pm_runtime_force_suspend(dev);
		if (ret) {
			mutex_unlock(&priv->pm_mutex);
			return ret;
		}

The later retry would then hit the same unbalanced enable and false
success.

[ ... ]

> +static int stmmac_resume_power(struct stmmac_priv *priv, bool system_resume)
> +{
> +	bool pending = priv->bus_clks_suspended || priv->bsp_suspended ||
> +		       priv->ptp_clock_suspended;
> +	int ret;
> +
> +	ret = stmmac_resume_clocks(priv);
> +	if (ret)
> +		return ret;
> +	if (priv->bsp_suspended && priv->plat->resume) {
> +		ret = priv->plat->resume(priv->device, priv->plat->bsp_priv);
> +		if (ret)
> +			return ret;
> +		priv->bsp_suspended = false;
> +	}

[Severity: High]
Does this skip plat->resume() on platforms that have a resume hook but
no suspend hook?

stmmac_suspend() sets bsp_suspended only when plat->suspend is non-NULL:

	if (priv->plat->suspend && !priv->bsp_suspended) {
		priv->bsp_suspended = true;

Before this patch, stmmac_resume() called plat->resume() unconditionally.

dwmac-mediatek sets plat->resume = mediatek_dwmac_init and has no suspend
hook. stmmac_pltfr_probe() does:

	if (!plat->suspend && plat->exit)
		plat->suspend = stmmac_plat_suspend;
	if (!plat->resume && plat->init)
		plat->resume = stmmac_plat_resume;

So glue drivers with init but no exit (dwmac-thead, dwmac-socfpga,
dwmac-loongson1) get only a resume hook.

On those boards, PHY interface selection, delays and syscon setup would
not be reprogrammed after sleep. stmmac_resume_power(priv, true) still
clears hw_unavailable, and the core goes on into stmmac_hw_setup().

The commit message doesn't mention this change. Was it intended?

[ ... ]

> @@ -6377,6 +6571,12 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id)
>  	struct net_device *dev = (struct net_device *)dev_id;
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  
> +	if (READ_ONCE(priv->hw_unavailable)) {
> +		if (priv->irq_wake)
> +			pm_wakeup_event(priv->device, 0);
> +		return IRQ_NONE;
> +	}
> +

[Severity: High]
Can this cause an interrupt storm on a MAC WoL wake?

stmmac_suspend() sets hw_unavailable after PMT has been armed, and only
stmmac_resume() clears it. With irq_wake set,
stmmac_pltfr_noirq_suspend() keeps the clocks on, so the registers are
still accessible in this window.

The PMT status is cleared by reading it in the host IRQ status path,
which this early return now skips. A magic packet can arrive after
stmmac_suspend(), or the wake IRQ can be replayed after
resume_device_irqs() but before stmmac_resume(). Either way, a
level-triggered MAC/WoL line would stay asserted.

Each pass calls pm_wakeup_event() and returns IRQ_NONE, until
note_interrupt() disables the line as "nobody cared". After that the
interface gets no interrupts following resume.

stmmac_mac_interrupt() has the same early return. When irq_wake keeps the
MAC clocked, would it be better to service the PMT status here?

[ ... ]

> @@ -7029,6 +7283,18 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
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
> +

[Severity: Medium]
Should this release happen only for pool removal, as the comment says?

As written, it runs for every XDP_SETUP_PROG and XDP_SETUP_XSK_POOL
request before any validation. That includes program installs, swaps
from one program to another, and requests that are later rejected by
stmmac_xdp_set_prog() (jumbo MTU) or stmmac_xdp_enable_pool() (bad queue,
small frame size).

Once datapath is DOWN, a later stmmac_resume() takes this path:

	if (priv->datapath != STMMAC_DATAPATH_SUSPENDED) {
		ret = 0;
		goto out_unlock;
	}

It returns 0 with the netdev still detached. The "A later resume may
retry" behaviour described in the resume error path is lost, even when
the XDP request itself failed.

[ ... ]

> @@ -8317,18 +8677,41 @@ int stmmac_suspend(struct device *dev)
>  
>  	mutex_unlock(&priv->lock);
>  
> -	rtnl_lock();
>  	phylink_suspend(priv->phylink, !!priv->wolopts);
> -	rtnl_unlock();
> +	if (priv->datapath == STMMAC_DATAPATH_RUNNING)
> +		priv->datapath = STMMAC_DATAPATH_SUSPENDED;
> +	priv->hw_suspended = true;
>  
>  	if (stmmac_fpe_supported(priv))
>  		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
>  
>  suspend_bsp:
> -	if (priv->plat->suspend)
> -		return priv->plat->suspend(dev, priv->plat->bsp_priv);
> +	accessible = !priv->hw_unavailable;
> +	mutex_lock(&priv->ptp_mutex);
> +	stmmac_block_ptp(priv, true);
> +	mutex_unlock(&priv->ptp_mutex);
> +	/* Drain MDIO transactions before the platform can remove power. */
> +	if (priv->mii)
> +		mutex_lock(&priv->mii->mdio_lock);
> +	/* ndo_set_rx_mode() can run without RTNL under the address lock. */
> +	netif_addr_lock_bh(ndev);
> +	WRITE_ONCE(priv->hw_unavailable, true);
> +	netif_addr_unlock_bh(ndev);
> +	if (priv->mii)
> +		mutex_unlock(&priv->mii->mdio_lock);

[Severity: High]
With MAC WoL enabled, what happens to a polled PHY once this flag is set?

phylink_suspend(priv->phylink, true) only sets PHYLINK_DISABLE_MAC_WOL
and does not call phy_stop(). stmmac sets mac_managed_pm, so
mdio_bus_phy_suspend() does not stop the PHY state machine either.

>From here until stmmac_resume() clears the flag, stmmac_mdio_access()
and the xgmac2 c22/c45 accessors return -EHOSTDOWN. The PHY state machine
work runs on a workqueue that is not freezable. A poll in this window
would get -EHOSTDOWN from phy_read_status(), and phylib would then WARN,
move the PHY to PHY_ERROR and stop polling.

On resume, the irq_wake branch in stmmac_resume_hw() only clears PMT, and
phylink_resume() only clears the disable bit. Is anything left that
restarts the PHY?

Before this patch MDIO stayed usable in this window, because the clocks
are kept on for irq_wake.

> +	if (priv->datapath == STMMAC_DATAPATH_SUSPENDED) {
> +		stmmac_synchronize_irq(priv);
> +		stmmac_stop_tx_queues(priv);
> +		if (accessible)
> +			stmmac_stop_all_dma(priv);
> +	}
> +	if (priv->plat->suspend && !priv->bsp_suspended) {
> +		priv->bsp_suspended = true;
> +		ret = priv->plat->suspend(dev, priv->plat->bsp_priv);
> +	}
> +	rtnl_unlock();

[Severity: Medium]
What happens to bsp_suspended if plat->suspend() fails?

It stays true. The PM core won't call ->resume for a device whose
->suspend failed. Even so, stmmac_open() or
stmmac_release()->stmmac_resume_power() will call plat->resume() for a
platform suspend that never completed.

If no open or close happens first, the next system suspend skips
plat->suspend() because of the !priv->bsp_suspended check, while
stmmac_resume() still calls plat->resume().

For hooks such as the dwmac-intel or PCI glue (pci_enable_device, clock
enables), would this leave the platform enable counts unbalanced? Should
bsp_suspended be set only when the callback succeeds?

[ ... ]

> @@ -8430,13 +8811,13 @@ int stmmac_resume(struct device *dev)
>  	ret = stmmac_hw_setup(ndev);
>  	if (ret < 0) {
>  		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
> -		stmmac_legacy_serdes_power_down(priv);
> -		mutex_unlock(&priv->lock);
> -		rtnl_unlock();
> -		return ret;
> +		goto error_stop_dma;
>  	}

[ ... ]

> @@ -8455,11 +8836,25 @@ int stmmac_resume(struct device *dev)

[ ... ]

> +error_stop_dma:
> +	stmmac_stop_all_dma(priv);
> +	stmmac_mac_set(priv, priv->ioaddr, false);
> +	stmmac_legacy_serdes_power_down(priv);
> +	mutex_unlock(&priv->lock);
> +	/*
> +	 * Keep the suspended data path detached. A later resume may retry, or
> +	 * ndo_stop() can release its resources without disabling NAPI again.
> +	 */
> +out_unlock:
> +	rtnl_unlock();
> +
> +	return ret;
>  }

[Severity: Medium]
Does this leave the PHY powered after a failed resume?

stmmac sets mac_requires_rxc. So the earlier phylink_prepare_resume() in
stmmac_resume() calls phy_resume() on a PHY that the non-WoL
phylink_suspend() had stopped.

If stmmac_hw_setup() then fails, this path does not call phylink_stop().
With the earlier "allow stopping a suspended instance" change in the
series, phylink_stop() would call phy_suspend() here.

__stmmac_open() does this unwind in its init_error path ("Undo
phylink_prepare_resume() even if hardware setup failed"). Should the
resume failure path do the same?

Otherwise the PHY stays powered, and the link partner may see link up
while the datapath is detached, until close or the next suspend.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
