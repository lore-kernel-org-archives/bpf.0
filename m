Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704628;
	b=1myxzaQFFGjkjgLm5VeO9QlkeV12HGTnkSDDhacuicC7hXZOhDXX+7q3n3F2d9Jiv83R
	 f58Y8mFID7DZeIA2dSu+txb5JvZne5j2cH1OMtOlqOhZkIP3/hkIzldtd6iay4av6Umx2
	 7r15uq8YAW9lbZSvrHOG5C/cq15am4SsV76FEue2kdI3pFqWCpxxeYdiPm2WDwflFw1NX
	 lTtWaI4Et6QgVyLmTCCKzL4DDSeOyDzPO1Mx5s07B5rbN40MtNkeNA3HhZL0DwsjYMNhr
	 LN9N2Rm7KPuvc1vIpfNkRgpRj0MEWXWrGEb0o/YuU2qm3MQ8NlEnH5W+xn4yuwuawwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704628;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XhlAzIOShLXamqfkISKDjFv5wlAzHJo0q2uLVbv54uo=;
	b=qy4nweLvBcQ5ujiCn876hbtKXgutWUmRY1ZuTOAu/kDUz/BkQtv46eBqZWOZBBPiBMZN
	 wwFKTk6YSClYvSWDiT+rOxvuBAgHHgVcW5CVpckvZAlIRX7I3A3Qyk1TcOCzNiXabKZb4
	 JrFlMIgtt1/FJcu6FGU50CR/ZKWBNQM6GCkZFHeMGMfFOybstt/9jiivePBP5SMocWsFp
	 gzv7xyolHgp75mR00inZj+PyMaDuzn3CplmxrgCuAOWZQTPOq54VoUHhEXZQjYWc15rC1
	 f28M3+i2KOSdpfrNrtn3xEYfCVirfYgVrIMcx6VoAF+X8gAVPIV8MBKVlXSmhn7ZoTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6KfHbaj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B893F606A31E;
	Thu, 26 Nov 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6KfHbaj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBC01F000CF;
	Thu, 26 Nov 2026 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704628;
	bh=XhlAzIOShLXamqfkISKDjFv5wlAzHJo0q2uLVbv54uo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j6KfHbajGACGKybgPg1QbCSt3vnPpvTBVbQqo/sxczFU4BHmH+9EtNsh9uErPHPdl
	 iTQF7HqJXHkvBbJFIqPjZGg8uKUjEz346GYLp4Ijsn9VYR/P2QkxhqyjX9mwypuhTa
	 MWx7OWwqyIEdivEmj06J7KUeZpwIJBuIMXZH9rHiuj9kWvdzc8cX36rQY2F8vX+GfE
	 bjnu7G45ytBv3Ig8Xtz/0HWCQeT19VyVYigkSlq2uSHpHd2lttICLdTM9pMDpcy+gg
	 JTxyBHFzuql1ZR1x4nMlL4ctKuWWcH3+Wrf8fLRJnmakQ6dmeKZjD4hh7Mm02er4zD
	 UifKsWNM9PcxQ==
Subject:
 Re: [PATCH net-next v13 2/5] net: stmmac: remove software VLAN tag stripping
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 matthew.gerlach@altera.com, boon.khai.ng@altera.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, nb@tipi-net.de
Date: Thu, 26 Nov 2026 14:50:26 +0000
Message-ID: <179570462642.3135.18427694806922403936@kernel.org>
In-Reply-To: <20261125-stmmac-rx-mb-v13-2-0f6bac53e8d5@oss.qualcomm.com>
References: <20261125-stmmac-rx-mb-v13-2-0f6bac53e8d5@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In __stmmac_dvr_probe()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c),…
- [Low] The patch carries 'Fixes: 534df0c1724b', which marks it for
  stable backporting.
- [Low] On DWXGMAC (stmmac_rx_8021ad_offload() true),
  __stmmac_dvr_probe() now adds NETIF_F_HW_VLAN_STAG_RX to…

--

net: stmmac: remove software VLAN tag stripping

This removes the software VLAN stripping in stmmac_rx_vlan() and changes
stmmac_has_ip_ethertype() so that it still recognises IPv4/IPv6 behind a
single in-payload C-tag on RX. NETIF_F_HW_VLAN_CTAG_RX and
NETIF_F_HW_VLAN_STAG_RX are now advertised only when the VLAN ops and the
descriptor ops provide real RX VLAN offload.

> The DWXLGMAC mis-advertisement was introduced when the RX VLAN offload
> gate was widened to all xmac cores, so tag the fix accordingly.
>
> With NETIF_F_VLAN_FEATURES possibly empty, EEE RX clock stop may be
> enabled on some platforms; the preceding selftests patch blocks RX
> clock stop while the ethtool selftests run.
>
> This depends on the preceding selftests fix.
>
> Fixes: 534df0c1724b ("net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN stripping")

[Severity: Low]
Is the Fixes: tag in proportion to the change? On DWXLGMAC,
dwxlgmac2_vlan_ops has no .rx_hw_vlan:

const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
	.update_vlan_hash = dwxgmac2_update_vlan_hash,
	.enable_vlan = vlan_enable,
	.set_hw_vlan_mode = dwxlgmac2_set_hw_vlan_mode,
};

With the old hw_vlan_en = true, stmmac_rx_hw_vlan() did nothing, and
dwxlgmac2_set_hw_vlan_mode() only sets EDVLP. The tag stayed in the
payload and the VLAN core removed it in software. The only visible effect
seems to have been the wrong CTAG_RX/STAG_RX advertisement.

The same Fixes-tagged patch also does the following:

- removes the software stripping path;
- drops CTAG_RX on every dwmac100/dwmac1000;
- changes the RX checksum trust rules in stmmac_has_ip_ethertype();
- makes STAG_RX user-visible in hw_features;
- depends on the preceding selftests patch.

Through the NETIF_F_VLAN_FEATURES check in stmmac_phylink_setup(), it also
enables EEE RX clock stop on every such platform that does not set
STMMAC_FLAG_RX_CLK_RUNS_IN_LPI, not only on "some platforms".

Could the minimal DWXLGMAC advertisement fix be split out for net, with
the cleanup and its EEE side effects going to net-next?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ca4c7fb11b73f..7896364c43e95 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -8275,15 +8248,17 @@ static int __stmmac_dvr_probe(struct device *device,
>  	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
>  	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
>  #ifdef STMMAC_VLAN_TAG_USED
> -	/* Both mac100 and gmac support receive VLAN tag detection */
> -	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
> -	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
> -		ndev->features |= NETIF_F_HW_VLAN_STAG_RX;
> -
> -	if (dwmac_is_xmac(priv->plat->core_type)) {
> +	if (stmmac_rx_8021q_offload(priv)) {
> +		ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		priv->hw->hw_vlan_en = true;
>  	}

[Severity: Medium]
Does this make RX clock stop reachable from set_rx_mode again?

dwmac1000 has no .vlan ops, and neither does DWXLGMAC without
vlhash/vlins. With CONFIG_VLAN_8021Q enabled, these cores now end up with
no NETIF_F_VLAN_FEATURES. stmmac_phylink_setup() then does:

	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI) &&
	    !(priv->dev->features & NETIF_F_VLAN_FEATURES))
		config->eee_rx_clk_stop_enable = true;

As a result the PHY may stop RXC while the link is in LPI.

stmmac_set_rx_mode() runs with BH disabled under netif_addr_lock_bh(). It
cannot use phylink_rx_clk_stop_block(), which needs RTNL and a sleeping
MDIO access:

 *  FIXME: This may need RXC to be running, but it may be called with BH
 *  disabled, which means we can't call phylink_rx_clk_stop*().
 */
static void stmmac_set_rx_mode(struct net_device *dev)
{
	struct stmmac_priv *priv = netdev_priv(dev);

	stmmac_set_filter(priv, priv->hw, dev);

Commit c171e679ee66 notes that the hardware needs RXC when MAC address
configuration registers are written. On these platforms, could a
multicast join/leave, a promisc/allmulti change or a secondary unicast
address update reach stmmac_set_filter() while RXC is stopped? That would
leave the address or hash filter unprogrammed.

The selftests patch covers the ethtool selftests, but the commit message
does not mention this path. dwmac100 should not be affected because it
has no EEE.

These platforms did run with RX clock stop before c171e679ee66, and they
still do with CONFIG_VLAN_8021Q=n. Whether dwmac1000 filter writes
actually fail without RXC is therefore a hardware question.

> +
> +	if (stmmac_rx_8021ad_offload(priv)) {
> +		ndev->features |= NETIF_F_HW_VLAN_STAG_RX;
> +		ndev->hw_features |= NETIF_F_HW_VLAN_STAG_RX;
> +	}

[Severity: Low]
Should STAG_RX be added to hw_features here? On DWXGMAC this tells
userspace the bit can be toggled on its own, but stmmac_fix_features()
ties it to CTAG_RX:

	if (stmmac_rx_8021ad_offload(priv)) {
		if (features & NETIF_F_HW_VLAN_CTAG_RX)
			features |= NETIF_F_HW_VLAN_STAG_RX;
		else
			features &= ~NETIF_F_HW_VLAN_STAG_RX;
	}

stmmac_set_features() also has only one combined hw_vlan_en state.

So "ethtool -K <dev> rx-vlan-stag-hw-parse off" with rxvlan on, or "on"
with rxvlan off, is always undone. ethtool then reports [requested off]
or [requested on].

Before this patch STAG_RX was only in features and showed as [fixed],
which matched the coupling. The coupling in stmmac_fix_features() already
adds STAG_RX back when CTAG_RX is re-enabled.

> +
>  	if (priv->dma_cap.vlhash) {
>  		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
>  		if (priv->plat->core_type == DWMAC_CORE_XGMAC)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125-stmmac-rx-mb-v13-0-0f6bac53e8d5%40oss.qualcomm.com
