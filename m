Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BF275AFD;
	Sun, 27 Sep 2026 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790468972; cv=none; b=An04sFtOeBaD/6k8vZezykPGdxnJnmlkxNuBEb1z2YsvHAdfJVl19+C9D56IjpOAKu35I/hx7/fpRcc1oynFumRpqhFVhmqDoxdNAtfFuVPIGwSmb6SMIfF5qekQNm1bs5cFW7uyDkU53T2kTDJQi5sF1oEEo+KuZWXRu4gNlFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790468972; c=relaxed/simple;
	bh=cjNFTZWX2ZJg0TslEXJpZVnYSOPMoFiIdgkhuXR2EvA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxVnRswqT5CEjxnXomiSIeYsb+higHc4+XrjrdwVjJMEGzDvJFkZPkwWIf2hcu39TJmZIVTa24wi+qe2zAnQpaNP5MDooIoKSouZAPMFigW7EZeNDt4Y1RxS40SkpRbBkqwDkdZVG2s3NGs9VoCEI7baip2XHQcV2EOk8zztyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI7nNFQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI7nNFQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B022E1F00893;
	Sun, 27 Sep 2026 00:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790468970;
	bh=3SsiO5u0SoXTNFa8VEX4AEti77B+Odql/Esj4H/XnKk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oI7nNFQM/KL+zaLcMeA6TFQwh4a4OAO4tO71DnqqtGk0Td++2VxLP7cyg9tG3iqFX
	 daTP1dHrii/A8wM9N7KmELZKcw/JFVzKZQ39N67TsQYvn7piI7ST19VOgvwTDaP2fG
	 0nBFH+jTj6mVAR/b3cOw30xGwfLsybcHjMwNKUaMKLruL1ZipV5OwLF8ZahevRhrw1
	 7zN7XkEOBWNW4I8IoEe2IYzOEpNIqG2sGWsS4sUTdu5qGGbEau6a4ADGpHTaTpSu2N
	 P5XffVqSN+mffjavnloqNB2oniQZ0eOL+Pp4ha2+pCfPlj6twVuFHJ5Bu806ddw4eB
	 75qkLMqwLkyRQ==
Subject: Re: [PATCH net v2 2/2] net: stmmac: keep datapath state coherent
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
 sdf@fomichev.me, richard.genoud@bootlin.com, alastair@d-silva.org,
 mripard@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Sun, 27 Sep 2026 00:29:28 +0000
Message-ID: <179046896830.2160803.3222113884012416985@kernel.org>
In-Reply-To:
 <20260922-submit-stmmac-reset-fixes-v1-v2-2-d92e609be996@gmail.com>
References:
 <20260922-submit-stmmac-reset-fixes-v1-v2-2-d92e609be996@gmail.com>
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

Critical: 0 · High: 1 (1) · Medium: 6 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Changing the XDP program on a running interface releases and
  reopens the datapath but never updates the new priv->datapath state,…
- [Medium] The ethtool reinit paths are also release-then-reopen paths,
  and the patch does not handle their failure.
- [Medium] stmmac_bpf() calls `if (priv->datapath ==
  STMMAC_DATAPATH_SUSPENDED) __stmmac_release(dev);` for every…
- [Medium] The patch adds a lasting state where the interface is IFF_UP
  but datapath is DOWN, and in that state clk_ptp_ref has already been…
- [Medium] STMMAC_DATAPATH_SUSPENDED covers two different situations:
  'the system is asleep right now' and 'hardware resume failed'.
- [Medium] The patch leaves a failed resume in SUSPENDED so that 'a later
  successful resume can retry the retained datapath'.
- [Medium] On Tegra MGBE, tegra_mgbe_resume() calls
  clk_bulk_disable_unprepare() on all MGBE clocks when stmmac_resume()…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  touches it and leaves it reachable.

--

net: stmmac: keep datapath state coherent after reinitialization failure

This commit adds a priv->datapath state (DOWN, RUNNING, SUSPENDED) to
stmmac, so that closing after a failed MTU reopen or a failed hardware
resume only does the teardown that is still needed. It moves suspend and
resume under RTNL and detaches the netdev when an MTU reopen fails. The XDP,
TC, debugfs and reset paths now check either the new state or whether the
device is present.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea234..7b423c87314ca 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -4244,25 +4247,38 @@ static int stmmac_open(struct net_device *dev)

[ ... ]

> +static void __stmmac_release(struct net_device *dev)
> +{
> +	struct stmmac_priv *priv = netdev_priv(dev);
> +
> +	/* A failed MTU reopen has already released the data path. */
> +	if (priv->datapath == STMMAC_DATAPATH_DOWN)
> +		return;

[Severity: Medium]
Could this early return leak an enable of clk_ptp_ref?

With this patch the interface can stay IFF_UP while priv->datapath is
STMMAC_DATAPATH_DOWN and stmmac_release_ptp() has already released
clk_ptp_ref. That happens after a failed MTU reopen, a failed ethtool
reinit, or stmmac_bpf() releasing a suspended datapath.

stmmac_suspend() and stmmac_resume() now check priv->datapath. The
platform noirq callbacks in stmmac_platform.c still check
netif_running():

stmmac_pltfr_noirq_suspend():
	if (!netif_running(ndev))
		return 0;

	if (!priv->wolopts) {
		/* Disable clock in case of PWM is off */
		clk_disable_unprepare(priv->plat->clk_ptp_ref);

Here is what happens on a system suspend without WoL in this state:

- noirq suspend disables a clock that is already disabled, which
  triggers the clk core warning.
- stmmac_pltfr_noirq_resume() then calls clk_prepare_enable() on
  clk_ptp_ref.
- stmmac_resume() does nothing, because the datapath is not SUSPENDED.
- The later ndo_stop takes this early return and never calls
  stmmac_release_ptp().

Does the PTP reference clock then stay enabled for good, with each later
open/close cycle leaving one extra enable behind?

[ ... ]

> @@ -4296,6 +4312,8 @@ static int stmmac_release(struct net_device *dev)
>  	stmmac_legacy_serdes_power_down(priv);
>  	phylink_disconnect_phy(priv->phylink);
>  	pm_runtime_put(priv->device);
> +	/* Allow a fresh open after a failed MTU reopen or resume. */
> +	netif_device_attach(dev);
>  
>  	return 0;
>  }

[Severity: Medium]
Do the ethtool reinit paths still end up in an inconsistent state when
the reopen fails?

stmmac_reinit_ringparam() (set_ringparam) and stmmac_reinit_queues()
(set_channels) call stmmac_release() and then reopen with:

	if (netif_running(dev))
		ret = stmmac_open(dev);

If stmmac_open() fails, its own unwind already calls
phylink_disconnect_phy() and pm_runtime_put(). The interface is left
IFF_UP and present, with priv->datapath at STMMAC_DATAPATH_DOWN.

On the next ndo_stop, __stmmac_release() returns early. stmmac_release()
still calls phylink_disconnect_phy() and pm_runtime_put() unconditionally
here.

Is this pm_runtime_put() unbalanced, so that it triggers the "Runtime PM
usage count underflow!" warning? The detach and PHY/PM ownership handling
added to stmmac_change_mtu() does not seem to cover these callers.

[ ... ]

> @@ -6422,6 +6445,8 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
>  
>  	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
>  		return ret;
> +	if (!netif_device_present(priv->dev))
> +		return -ENETDOWN;
>  
>  	__stmmac_disable_all_queues(priv);
>  

[Severity: High]
This isn't a bug introduced by this patch, but is netif_device_present()
the right check here?

__stmmac_disable_all_queues() calls napi_disable() on every rx/tx/rxtx
NAPI. In several states the device is present but its NAPIs are already
disabled, or were never enabled:

- the interface is administratively down, including after the failed
  MTU state is closed and stmmac_release() calls netif_device_attach();
- stmmac_reinit_ringparam() or stmmac_reinit_queues() failed in
  stmmac_open();
- an XDP reopen failed.

tc_cls_can_offload_and_chain0() does not check the admin state, so a
sequence such as:

  ip link set dev X down
  tc qdisc add dev X clsact
  tc filter add dev X ingress flower ... skip_sw

would reach napi_disable_locked(), which then spins forever on
NAPIF_STATE_SCHED with RTNL held.

The new state tracks whether NAPI is enabled and the resources are
owned. Would checking priv->datapath == STMMAC_DATAPATH_RUNNING here be
more accurate?

[ ... ]

> @@ -6959,6 +6987,18 @@ static int stmmac_bpf(struct net_device *dev, struct netdev_bpf *bpf)
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
Should this release only happen for requests that actually change the
pool or the program?

It runs for every XDP_SETUP_PROG and XDP_SETUP_XSK_POOL request, before
any validation. That includes requests that are later rejected or do
nothing:

- stmmac_xdp_set_prog() returns -EOPNOTSUPP for a prog when
  dev->mtu > ETH_DATA_LEN
- one program replaces another, so need_update is false
- stmmac_xdp_enable_pool() rejects a small frame_size, or
  xsk_pool_dma_map() fails

In each of these cases the retained rings are freed and the datapath
becomes DOWN. A later stmmac_resume() then does:

	if (priv->datapath != STMMAC_DATAPATH_SUSPENDED) {
		ret = 0;
		goto out_unlock;
	}

It never calls netif_device_attach(), so the interface stays detached
until someone runs a manual down/up.

The commit message only gives a reason for this in the AF_XDP pool
removal case. It also says "A later successful resume can retry the
retained datapath".

[Severity: Medium]
Can this also run during a normal system sleep, and not only after a
failed resume?

stmmac_suspend() sets STMMAC_DATAPATH_SUSPENDED before it drops RTNL. A
failed resume leaves the same state. AF_XDP pool teardown can reach
ndo_bpf from the non-freezable system_wq:

xp_put_pool()
  schedule_work(xp_release_deferred)
    rtnl_lock()
    xp_clear_dev()
      ndo_bpf(XDP_SETUP_XSK_POOL, NULL)
        stmmac_bpf()
          __stmmac_release()

If that work runs after stmmac_suspend() releases RTNL, __stmmac_release()
would:

- call phylink_stop();
- free the IRQs;
- write DMA registers that stmmac_pltfr_noirq_suspend() or
  pm_runtime_force_suspend() may already have clock-gated;
- disable clk_ptp_ref a second time via stmmac_release_ptp().

On wake, stmmac_resume() sees STMMAC_DATAPATH_DOWN and returns 0 without
calling netif_device_attach(). Before this patch, removing a pool with
no XDP program loaded did not touch the hardware.

Is there a way to tell the two SUSPENDED cases apart here?

[ ... ]

> @@ -8198,26 +8246,24 @@ int stmmac_suspend(struct device *dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(dev);
>  	struct stmmac_priv *priv = netdev_priv(ndev);
> -	u8 chan;
>  
> -	if (!ndev || !netif_running(ndev))
> +	rtnl_lock();
> +	if (priv->datapath != STMMAC_DATAPATH_RUNNING) {
> +		rtnl_unlock();
>  		goto suspend_bsp;
> +	}

[Severity: Medium]
After a failed resume, does the next suspend skip re-arming WoL?

The failed stmmac_resume() has already cleared PMT with
stmmac_pmt(priv, priv->hw, 0) and set irq_wake to 0, or has switched
pinctrl to the default state.

The datapath is left SUSPENDED so that a later resume can retry. On the
next system suspend, though, this check sends stmmac_suspend() straight
to suspend_bsp and skips:

	if (priv->wolopts) {
		stmmac_pmt(priv, priv->hw, priv->wolopts);
		priv->irq_wake = 1;
	} else {
		stmmac_mac_set(priv, priv->ioaddr, false);
		pinctrl_pm_select_sleep_state(priv->device);
	}

With WoL configured, the noirq suspend keeps the clocks on, but the MAC
wake mode is never armed again, so the system will not wake on LAN.
Without WoL, the pins stay in the active pinctrl state through suspend.

Is that intended?

[ ... ]

> @@ -8371,11 +8415,25 @@ int stmmac_resume(struct device *dev)

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
On Tegra MGBE, is it safe to recover from this failure with an ordinary
down?

When the common resume fails, tegra_mgbe_resume() in dwmac-tegra.c turns
the clocks off:

	err = stmmac_resume(dev);
	if (err < 0)
		clk_bulk_disable_unprepare(ARRAY_SIZE(mgbe_clks), mgbe->clks);

The datapath stays STMMAC_DATAPATH_SUSPENDED. A later ndo_stop, or the
release in stmmac_bpf(), then runs __stmmac_release() with the MGBE
clocks off:

- phylink_stop() takes the MAC link down and uses MDIO;
- stmmac_stop_all_dma() accesses the XGMAC channel-control and MAC TX
  configuration registers.

Nothing turns these clocks back on first, and the runtime-PM reference
does not cover them. Part of this predates the patch, since the old
ndo_stop also accessed registers through phylink_stop() before it hung.

stmmac_suspend() now returns early when the datapath is not RUNNING. The
next tegra_mgbe_suspend() would therefore call
clk_bulk_disable_unprepare() a second time.

Can this lead to register access on unclocked hardware and to
unbalanced clock disables?

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

[Severity: High]
Does attaching or detaching an XDP program leave priv->datapath stale?

When need_update is true on a running interface, stmmac_xdp_set_prog()
does:

	if (if_running && need_update)
		stmmac_xdp_release(dev);
	...
	if (if_running && need_update)
		stmmac_xdp_open(dev);

stmmac_xdp_release() disables NAPI, frees the IRQs, stops DMA and frees
the rings.

stmmac_xdp_open() can fail in alloc_dma_desc_resources(),
init_dma_desc_rings() or stmmac_request_irq(). Its error labels free the
new rings and return with NAPI disabled and no IRQs requested.

The return value is ignored here, and neither function writes
priv->datapath. It therefore stays STMMAC_DATAPATH_RUNNING, and the
netdev is still present.

After that, would ndo_stop hang?

stmmac_release()
  __stmmac_release()
    if (priv->datapath == STMMAC_DATAPATH_RUNNING)
        stmmac_quiesce(priv);
          stmmac_disable_all_queues()
            napi_disable()   <- already disabled

napi_disable_locked() would spin forever on NAPIF_STATE_SCHED with RTNL
held. It would then be followed by a second stmmac_free_irq() and
free_dma_desc_resources().

Other paths would hit the same state:

- stmmac_suspend(), stmmac_xdp_enable_pool() and
  stmmac_xdp_disable_pool() would reach the same napi_disable();
- stmmac_rings_status_show() only skips the dump for
  STMMAC_DATAPATH_DOWN, so it would read the freed descriptor rings.

The failed-reopen problem here existed before this patch. However, this
commit targets this kind of failed-reopen state and moves this function
onto priv->datapath.

Should stmmac_xdp_release() and stmmac_xdp_open() update priv->datapath?
Should a failed stmmac_xdp_open() also be handled the same way as the
MTU failure path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996%40gmail.com
