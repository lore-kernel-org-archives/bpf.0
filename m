Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70E4CE688;
	Fri, 25 Sep 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363538; cv=none; b=sCrOYVViD/0zraJKg99pFjSsek9P5tEzTm6TTo+SHXI2U9k2K7HTneU1/heASnke4L5IeocUW5uWzgnFBGpcLNp7VGcCg2wUaKxhulJZfmd3RXtm1ptTDNOkB57LTxaPvFpi8o9ERqbJFCEJuw6AQzBGoNvQn/Q41Gk2R0nhM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363538; c=relaxed/simple;
	bh=6CnO8Sbv97S3PWj0QxlzwSLFSuaV2tbFK0ysInwKqcM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jbuuToHQwmlIo0hnNWSZ5NTMEHUZfqSvKMLfu9wRu4aOwjKs9QURaZCXgBE9klHoNwgiieE2TImAjxHjTgjVEOlq+jii4m3gjncpZ4F9hhwskJ0eo1eJaJDYaT4rnF82tpwYtM4O5XV3jGrsMaySwovfm7n9Xsy2Bx39UnWu0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSQC067Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSQC067Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4538E1F0089A;
	Fri, 25 Sep 2026 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363532;
	bh=pOTd0QsZFwY/1NPCwglWY7eTyUnFOT12GMBT8oi99Wk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fSQC067Y7GVhB5Jepd7waKyynC6keHTYYOTNdqToOBdFbHbBtOKKPJbyaMQsxGlc7
	 zF8Mkwr9sK0OFKn+rialddblW1WR99QFqHzXXZUhZ8W7rGvIscREfBMbO5g9pu9zfp
	 bS764VizpInXL14FTzguX4+COYLJ5ugCEiautA74xQOhIzJosn77BbzJnbZ0Ykg8Vb
	 /GuwiT3JUHB9i46Zi9tVDrZwf49qTNs+bFkCMLYNHo6ctW5i2GOYgPLvRPObXC97W9
	 2yJSBKmD+GDymLZhhMnq9pd2Tw1FLz0ci+Q/ea5bvEBaiGarrLKFJjYABy4Vx+1LCY
	 Cnfx6oyrzlXog==
Subject: Re: [PATCH net v3 09/10] net: stmmac: retain PHY and PM ownership
 during ethtool reopening
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
Date: Fri, 25 Sep 2026 19:12:09 +0000
Message-ID: <179036352982.2160803.2753579871439489009@kernel.org>
In-Reply-To:
 <20260924-submit-stmmac-reset-fixes-v1-v3-9-c031e3f3a282@gmail.com>
References:
 <20260924-submit-stmmac-reset-fixes-v1-v3-9-c031e3f3a282@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In commit "net: stmmac: retain PHY and PM ownership during
  ethtool reopening", a failed hardware setup during a live ethtool…
- [Low] The commit message says the old behaviour lets 'an MTU change ...
  quiesce NAPI which is already disabled'.
- [Low] After a failed live channel change, the netdev core and the
  driver disagree on queue counts.

--

net: stmmac: retain PHY and PM ownership during ethtool reopening

This commit changes the stmmac ethtool ring size and channel count paths.
They now detach the device and release only the datapath, then reopen
through a new stmmac_reopen() helper that keeps the PHY attachment and the
runtime-PM reference. On failure the previous ring sizes or queue counts are
restored and the device stays detached.

> the PHY attachment and runtime-PM reference have already been dropped, but
> the next ordinary close drops them again. The device also remains present,
> allowing an MTU change to quiesce NAPI which is already disabled.

[Severity: Low]
Is this description accurate for this tree?

With the old code, a failed ethtool reopen is stmmac_release() followed by a
failed stmmac_open(). After that, priv->datapath stays
STMMAC_DATAPATH_DOWN. A later jumbo MTU change calls __stmmac_release(),
which returns early:

    if (priv->datapath == STMMAC_DATAPATH_DOWN)
        return;

An earlier patch in this series added that guard ("net: stmmac: keep
datapath state coherent after reinitialization failure"). So
stmmac_quiesce() and napi_disable() never run. MTU changes that don't need
jumbo buffers don't touch the datapath at all.

The real hazard looks different. stmmac_change_mtu() goes on to call
__stmmac_open(), which restarts DMA, IRQs and phylink. At that point
stmmac_release() has already disconnected the PHY and dropped the
runtime-PM reference.

This patch does close that, because dev_set_mtu_ext() returns -ENODEV for a
detached device. Could the commit message describe that consequence instead?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d56b7f911db0a..d17c68f55caf6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -7658,13 +7660,37 @@ static void stmmac_napi_del(struct net_device *dev)
>  	}
>  }
>  
> -int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
> +/* Rebuild only the datapath. The administratively-up device still owns its
> + * PHY attachment and runtime-PM reference, even if this reopen fails.
> + */
> +static int stmmac_reopen(struct net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
> -	int ret = 0, i;
> +	struct stmmac_dma_conf *old_conf = priv->dma_conf;
> +	struct stmmac_dma_conf *dma_conf;
> +	int ret;
>  
> -	if (netif_running(dev))
> -		stmmac_release(dev);
> +	dma_conf = stmmac_setup_dma_desc(priv, dev->mtu);
> +	if (IS_ERR(dma_conf))
> +		return PTR_ERR(dma_conf);
> +
> +	ret = __stmmac_open(dev, dma_conf);
> +	if (ret) {
> +		priv->dma_conf = old_conf;
> +		free_dma_desc_resources(priv, dma_conf);
> +		kfree(dma_conf);
> +		return ret;
> +	}

[Severity: Medium]
Can this failure path leave the PHY powered up while phylink is stopped and
the MAC is disabled?

Before the reopen, __stmmac_release() goes through phylink_stop() and
phy_stop(). That suspends the PHY unless WoL is set.

__stmmac_open() then resumes the PHY before hardware setup. stmmac always
sets config->mac_requires_rxc = true, so phylink_prepare_resume() calls
phy_resume():

__stmmac_open()
    phylink_prepare_resume(priv->phylink);
    ...
    ret = stmmac_hw_setup(dev, false);
    if (ret < 0) {
        ...
        goto init_error;
    }
    ...
init_error:
    stmmac_stop_all_dma(priv);
    stmmac_mac_set(priv, priv->ioaddr, false);
    return ret;

stmmac_hw_setup() can fail, for example when the DMA software reset times
out. The init_error label then skips phylink_stop(), and the error branch
above only frees the replacement dma_conf.

The old path was stmmac_open() error -> phylink_disconnect_phy() ->
phy_detach() -> phy_suspend(). That put the PHY back into power-down.

With this change the PHY can stay powered and bring up a link with the
partner, while the host has no carrier and the MAC is off. This seems to
last until the interface is taken down. At that point __stmmac_release()
returns early on STMMAC_DATAPATH_DOWN, and only phylink_disconnect_phy() in
stmmac_release() suspends the PHY.

phylink_stop() already handles an instance that is already stopped. The
commit "net: phylink: allow stopping a suspended instance" added this
branch:

drivers/net/phy/phylink.c:phylink_stop() {
    if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state)) {
        if (pl->phydev)
            phy_suspend(pl->phydev);
        return;
    }
    ...
}

Would calling phylink_stop() on this failure path undo the power-up and
still keep the PHY attached and the runtime-PM reference held?
stmmac_reopen() is not changed later in the series, so this remains at the
end of the series.

> +
> +	kfree(old_conf);
> +	netif_device_attach(dev);
> +	return 0;
> +}

[ ... ]

> @@ -7676,9 +7702,31 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
>  									rx_cnt);
>  
>  	stmmac_napi_add(dev);
> +}
> +
> +int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
> +{
> +	struct stmmac_priv *priv = netdev_priv(dev);
> +	u8 old_rx = priv->plat->rx_queues_to_use;
> +	u8 old_tx = priv->plat->tx_queues_to_use;
> +	int ret = 0;
> +
> +	if (netif_running(dev)) {
> +		if (!netif_device_present(dev))
> +			return -ENETDOWN;
> +		netif_device_detach(dev);
> +		__stmmac_release(dev);
> +	}
> +
> +	stmmac_set_queues(dev, rx_cnt, tx_cnt);
>  
>  	if (netif_running(dev))
> -		ret = stmmac_open(dev);
> +		ret = stmmac_reopen(dev);
> +	if (ret) {
> +		stmmac_set_queues(dev, old_rx, old_tx);

[Severity: Low]
Does this leave dev->real_num_rx_queues and dev->real_num_tx_queues at the
new counts while the driver goes back to the old ones?

__stmmac_open() can fail after stmmac_hw_setup() has already succeeded, for
example when stmmac_request_irq() fails. By then stmmac_hw_setup() has
already run this with the new counts:

    netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
    netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);

stmmac_set_queues(dev, old_rx, old_tx) restores
priv->plat->rx/tx_queues_to_use, the RSS table and the NAPI instances. It
does not restore the core real_num_* values.

Until the next ndo_open re-syncs them in stmmac_hw_setup(), the core (sysfs
queue kobjects, XPS/RPS, xsk qid bounds) sees the new topology and the
driver sees the old one. The old code never restored the plat values, so
both sides stayed consistent.

Does this partial restore match what the commit message describes as
restoring the "channel topology after failure"?

> +		netdev_err(dev, "failed reopening after channel change: %pe; interface remains detached\n",
> +			   ERR_PTR(ret));
> +	}
>  
>  	return ret;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282%40gmail.com
