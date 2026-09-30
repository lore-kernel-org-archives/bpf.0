Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAA38A73B;
	Wed, 30 Sep 2026 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743891; cv=none; b=UdWW6jZaRp0ZDCQ3iB8w7Cl9NwmThj9rCmfm7xx0h1YYSsiQuqBR9gbLPy8gNXAJMSeOXygyHDHndb8pzaEyw5wUXgDIpy2n2OOuqDKHjJ18H6w9SJWpsdA7UXm0tr5M3D0i1jl8BGo5IjkEhXS/QnPbeD+VZ0HOP/unP4V/wzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743891; c=relaxed/simple;
	bh=O4ZEI8E7/aLCYgTl8e7WVy6Vu+ylqm/hJe9IfZ9kY9c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hhmdZNUzAQmastJzRURZW8zPncyyRN/uKqtC5DJryYksjBhCJFdqwdtDCFDHV0iNK93S56kM7tX+dFBY7iF6ZtABJBmcp211nxB667jAf8f1BO2XrW6r/7XaHepW9CWO99VSJoDSRTZTuXT+2WL1znxIdIpJ69mmL7ITagynMLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVmotk48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVmotk48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622781F000FF;
	Wed, 30 Sep 2026 04:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743890;
	bh=I6jkYFcTNthR5C+Hpfv06QjmgS8uSSJevl9gWXkvy/I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cVmotk48593ZILJB8/gEe7LYuTOWfrkzQF/exVikVuuuFa9zA/AAqfhd0BByUTffD
	 /H+BVg9OGvBFTWmyev6HkAAoE858UtcJI8fL9W5TKWJ2YMZ9k69gDDC47LRlNZCw5C
	 dn5WDmzhOWPVLpn9JrUQaNEHi9RxK/f23gxq3qD+iJvWv9yIjJ/X6UXUdM1ZohQIDf
	 5PnpWJEFuXEtsEpzuvZc2bqUN71NOOXm6bnl2QKCARiAhEzIKFrsJI+kiU023wz0YW
	 ZcOHRYdClFfyVcNrhSmJXd0cY7jYuEnZ/BAlCN1/mxx4b8oINjVFgOJm+hOAo71s8P
	 +zyr/FaT+SYeA==
Subject:
 Re: [PATCH net v4 02/15] net: stmmac: reuse the MDIO reset GPIO on resume
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
Date: Wed, 30 Sep 2026 04:51:26 +0000
Message-ID: <179074388691.434549.18241724837995094025@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-2-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-2-ec1c0250b3c9@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Once the cached descriptor is used, stmmac_mdio_reset() really
  does pulse the snps,reset PHY reset line on every system resume…
- [Low] The commit message explains the mechanism (the second exclusive
  request of snps,reset returns -EBUSY) but not what users see.

--

net: stmmac: reuse the MDIO reset GPIO on resume

MDIO bus registration acquires the snps,reset GPIO. This commit caches
that descriptor in priv->mdio_reset_gpio, so later calls to
stmmac_mdio_reset(), such as the one on resume, reuse it. Without the
cache, those calls request the exclusive line again and fail with
-EBUSY.

> MDIO bus registration acquires the optional snps,reset GPIO through
> devres. A later bus reset must reuse that descriptor: requesting the
> same exclusive GPIO again returns -EBUSY while devres still owns it.

[Severity: Low]

This isn't a bug, but could the commit message describe the effect that
users see?

stmmac_resume() ignores the return value of stmmac_mdio_reset(). Before
this patch, on OF boards with a snps,reset GPIO, every resume without
MAC WoL silently skipped two things: the PHY reset pulse and the
STE101P dummy MDC write:

    writel(0, priv->ioaddr + mii_address);

Nothing was logged when this happened.

The message also doesn't say that this change turns the PHY hard reset
on resume back on. That reset has not run since 7c86f20d15b7. Without a
symptom or behaviour change in the message, stable backporters
following the Fixes: tag have nothing to match against bug reports.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index afe98ff5bdcb0..07d5eab05996b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -386,14 +386,20 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  
>  #ifdef CONFIG_OF
>  	if (priv->device->of_node) {
> -		struct gpio_desc *reset_gpio;
> +		struct gpio_desc *reset_gpio = priv->mdio_reset_gpio;
>  		u32 delays[3] = { 0, 0, 0 };
>  
> -		reset_gpio = devm_gpiod_get_optional(priv->device,
> -						     "snps,reset",
> -						     GPIOD_OUT_LOW);
> -		if (IS_ERR(reset_gpio))
> -			return PTR_ERR(reset_gpio);
> +		/* The bus reset also runs on resume. Devres retains the GPIO
> +		 * until unbind, so do not request an already owned line again.
> +		 */
> +		if (!reset_gpio) {
> +			reset_gpio = devm_gpiod_get_optional(priv->device,
> +							     "snps,reset",
> +							     GPIOD_OUT_LOW);
> +			if (IS_ERR(reset_gpio))
> +				return PTR_ERR(reset_gpio);
> +			priv->mdio_reset_gpio = reset_gpio;
> +		}

[Severity: High]

With the descriptor cached, stmmac_mdio_reset() now really pulses the
snps,reset line on every system resume where MAC WoL is off. Does
anything re-initialise the PHY after that?

Before this patch, the second devm_gpiod_get_optional() on the
exclusive line failed in gpiod_request_commit() with -EBUSY. The
resume path ignores that error:

stmmac_resume()
    } else {
        pinctrl_pm_select_default_state(priv->device);
        /* reset the phy so that it's ready */
        if (priv->mii)
            stmmac_mdio_reset(priv->mii);
    }

So no PHY hard reset has run on resume since 7c86f20d15b7. Before that
commit the reset did run, but mdio_bus_phy_resume()->phy_init_hw()
followed it.

Today stmmac_phylink_setup() sets config->mac_managed_pm = true, and
phylink copies that into phydev->mac_managed_pm. As a result,
mdio_bus_phy_resume() returns early:

mdio_bus_phy_resume()
    if (phydev->mac_managed_pm)
        return 0;
    ...
    ret = phy_init_hw(phydev);

The MAC-managed path only runs phylink_prepare_resume()->phy_resume()
and phylink_resume()->phylink_start()->phy_start()->__phy_resume().
Neither of these replays config_init() or config_intr().

Wouldn't that leave the PHY at its power-on or strap defaults while
phylib believes it is still configured? The config_init() settings
would be lost: RGMII delays or skews, clock-out, LEDs, vendor quirks,
and the autonomous EEE disable.

For an interrupt-driven PHY, the reset also clears the interrupt
enable register. phy_start() restarts aneg, sees link down and moves
to PHY_NOLINK, and it does not poll after that. Could link-up then
never be reported, so the interface stays down until the admin runs a
down/up cycle?

PHY-based WoL seems to be affected too. phylink_ethtool_set_wol()
removes the modes the PHY handles from the MAC mask:

    wolopts &= ~w.wolopts;

With PHY WoL, priv->wolopts is therefore 0, so resume takes the reset
branch. Won't the reset pulse erase the PHY's WoL enables, so the next
suspend is not armed for wake?

Resume now also blocks for the snps,reset-delays-us msleep() calls.
When those delays are 0, the DMA reset in stmmac_hw_setup() needs the
PHY RX clock, and it runs right after reset deassert.

This also looks unresolved at the end of the series. After "net:
stmmac: track datapath and power ownership across failed reopening",
stmmac_resume_hw() still calls stmmac_mdio_reset(). stmmac_resume()
still only calls phylink_prepare_resume() and phylink_resume() after
it, and no phy_init_hw() call was added in stmmac or phylink.

This patch carries a Fixes: tag, so it will reach stable. Should the
resume path either re-initialise the PHY after the reset, or skip the
reset pulse on resume?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
