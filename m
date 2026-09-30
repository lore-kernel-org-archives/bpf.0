Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AF53AA9C4;
	Wed, 30 Sep 2026 04:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743895; cv=none; b=CLu6/CnlPmEIa+T478ZGWQa728sThljGCYGnpA+0AZVKMein5iMdKlBmyPxzrD9Vcoj8Da5zTD7/c6LwBKSJTuTLPhohmvGD6oXTGwVpG8IQRvwMX3gg7VqTPSRNpLEywYqnPnZRqvx20tnJfonxodu0uinltYfWApzVtNF01xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743895; c=relaxed/simple;
	bh=W1xV03bczKJyo62M0xXybTM/81Dtan9M3OnYcdD2m1Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EgzE+mWlkE6pxirTdjNZYlv3AC1OlxsXqSldg6yizJe158C3U4VzLg7wFZJqTLjbfRZIO0lXDx8p2Z1HQZvUjgRfvUYKufuKIA5hTI2qloXiKcibiJKwIyc6DmzFS6JEYKeyKlRZ4VUshldjg1yIDub440LAVsa16NwkiMAiMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiWiPp2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiWiPp2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A326B1F00893;
	Wed, 30 Sep 2026 04:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743893;
	bh=6i9MajxOfUTnhZI9wNdwKJVhTSCDODZ5z6OOpWJk2s0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aiWiPp2RP812fWkDNudSqPFTSqyWr8yp7wUyo5ypN76/Cz3pWrxk5KJzoEPVKWvF6
	 jI2TlrGU+Buz1TJ2zxFqJjqz/OZo9h31S/oYt5CHyKXPjajLI3hpwyjr0jSOZRUJqg
	 H1jdCMOQPs9rNBmMHF7JzwOql4Jauk0l/AwArCQINeuhsZKj3RJUEuz9ootveqhafk
	 RuJUhJs3Ux2qR+z7v59HBJMGaQEuHPal7U1lbcBQgS4Mxy78M9/FpBeCLE4yuB+1Op
	 9JABI30Mv6vAKiGP4hGLJ2Zkz2wmcSw9sI/ogFUqyPdrSLAcwQ5iKw6malmQPoYLIB
	 QkorU+QjSGKqA==
Subject:
 Re: [PATCH net v4 03/15] net: phylink: allow stopping a suspended instance
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
Date: Wed, 30 Sep 2026 04:51:30 +0000
Message-ID: <179074389021.434549.9076032327066191129@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-3-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-3-ec1c0250b3c9@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] phylink_stop() now returns early whenever
  PHYLINK_DISABLE_STOPPED is set (drivers/net/phy/phylink.c:2536-2543).
- [Medium] The new MAC-WoL completion in phylink_stop()
  (phylink.c:2557-2565) calls phylink_link_down() only when…
- [Low] The only Fixes: tag is f97493657c63 ("net: phylink: add
  suspend/resume support", 2021).

--

net: phylink: allow stopping a suspended instance

This patch lets phylink_stop() shut down an instance that is still
suspended after a driver resume failed, without going through
phylink_resume(). When the instance is already stopped, it no longer
repeats PHY/SFP/PCS shutdown. It also completes the link-down that MAC WoL
deferred, and it tracks and undoes the PHY speed-down done at suspend time.

> Fixes: f97493657c63 ("net: phylink: add suspend/resume support")

[Severity: Low]
Is this Fixes: tag complete? Several of the things this patch fixes were
added after f97493657c63.

phylink_phy_pm_speed_ctrl() and the phylink_speed_down() call in
phylink_suspend() came from dc1a2a9ce5b2c8. The new suspend_speed_down
tracking and phylink_restore_suspend_speed() fix that commit.

The new MAC WoL block in phylink_stop() depends on suspend_link_up
handling, which came from 4c8925cb9db158.

The commit message gives phylink_prepare_resume() as the reason for the
new phy_suspend() call, and phylink_prepare_resume() came from
367f1854d442b3.

Should there be at least one more Fixes: tag, for dc1a2a9ce5b2c8? With
only f97493657c63, stable tooling may try to backport this to trees that
lack the state and functions the patch modifies.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 1bbcf46c83566..b7d30ca340316 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> @@ -2509,11 +2518,30 @@ EXPORT_SYMBOL_GPL(phylink_start);
>   *
>   * This will synchronously bring down the link if the link is not already
>   * down (in other words, it will trigger a mac_link_down() method call.)
> + * A suspended instance may be stopped without first calling phylink_resume().
> + * In particular, closing a device after a failed resume must not restart the
> + * link or reconfigure the MAC just to finish shutting it down.
> + * Any PHY advertisement reduced by phylink_suspend() is restored as part
> + * of this transition.
> + * If phylink_prepare_resume() powered up an already stopped PHY, suspend
> + * it again when Wake-on-LAN permits.
>   */
>  void phylink_stop(struct phylink *pl)
>  {
>  	ASSERT_RTNL();
>  
> +	/* Also undo PHY speed control when terminating a suspended instance. */
> +	phylink_restore_suspend_speed(pl);
> +
> +	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state)) {
> +		/* A failed MAC resume may have called phylink_prepare_resume()
> +		 * and powered the stopped PHY back up to supply its RX clock.
> +		 */
> +		if (pl->phydev)
> +			phy_suspend(pl->phydev);
> +		return;
> +	}

[Severity: Medium]
Is PHYLINK_DISABLE_STOPPED specific enough to identify a suspended
instance? phylink_create() also sets it:

drivers/net/phy/phylink.c:phylink_create() {
    ...
	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
    ...
}

Every completed phylink_stop() also leaves it set. So this branch also
runs for an instance that was never started and for a second, unbalanced
phylink_stop(). In both cases it calls phy_suspend() without any warning.

Before this patch, a second phylink_stop() reached phy_stop() with the PHY
in PHY_HALTED, which hit:

	WARN(1, "called from state %s\n", phy_state_to_str(phydev->state));

Is it intended that phylink users lose this warning for unbalanced
start/stop?

The new kernel-doc says the PHY is suspended again only "If
phylink_prepare_resume() powered up an already stopped PHY". The code does
it for any stopped instance whose PHY is not suspended. That includes a
PHY powered up by phy_attach_direct() on an instance that was never
started.

A later patch in this series ("net: stmmac: track datapath and power
ownership across failed reopening") already relies on this broader
behaviour. Its __stmmac_open() calls phylink_stop() twice on an instance
that phylink_start() never started.

Should the commit message and kernel-doc describe this wider contract?

The early return also skips the new MAC WoL cleanup further down. If
phylink_suspend(pl, true) runs on an instance that is already stopped,
both bits end up set:

phylink_suspend(pl, true)
    __set_bit(PHYLINK_DISABLE_MAC_WOL, ...)
phylink_stop(pl)
    STOPPED already set -> phy_suspend(); return;
phylink_start(pl)
    phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_STOPPED)
        MAC_WOL is still set, so the resolver never runs

Can the link still come up after that phylink_start()? At this commit,
stmmac seems able to reach this sequence:

  - an MTU change reopen fails, leaving the interface up with phylink
    stopped
  - a MAC WoL system suspend
  - a failed resume
  - close, then open

> +
>  	if (pl->sfp_bus)
>  		sfp_upstream_stop(pl->sfp_bus);
>  	if (pl->phydev)

[ ... ]

> @@ -2526,6 +2554,16 @@ void phylink_stop(struct phylink *pl)
>  
>  	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
>  
> +	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
> +		/* Finish the link-down deferred by MAC WoL, without restarting. */
> +		flush_work(&pl->resolve);
> +		mutex_lock(&pl->state_mutex);
> +		if (pl->suspend_link_up)
> +			phylink_link_down(pl);
> +		__clear_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
> +		mutex_unlock(&pl->state_mutex);
> +	}

[Severity: Medium]
Does this still complete the deferred link-down if phylink_suspend() was
called twice with no phylink_resume() in between?

phylink_suspend() recomputes the flag on every MAC WoL suspend:

drivers/net/phy/phylink.c:phylink_suspend() {
    ...
		pl->suspend_link_up = phylink_link_is_up(pl);
		if (pl->suspend_link_up) {
			...
			if (pl->netdev)
				netif_carrier_off(pl->netdev);
			pl->old_link_state = false;
		}
    ...
}

The first suspend turns the carrier off and clears old_link_state, but
does not call mac_link_down(). While PHYLINK_DISABLE_MAC_WOL is set, the
resolver cannot turn the carrier back on.

Now suppose resume fails before phylink_resume() and the device stays
running. The next system suspend calls phylink_suspend(pl, true) again.

stmmac_suspend() at this commit does this, because it only checks
netif_running(). ucc_geth_suspend() does it after ucc_geth_init_mac()
fails in ucc_geth_resume().

That second call sets suspend_link_up to false, although mac_link_down()
has still not been called.

A later close reaches this block and skips phylink_link_down(), so neither
mac_link_down() nor phylink_deactivate_lpi() runs. PHYLINK_DISABLE_MAC_WOL
is still cleared.

Wouldn't that leave the earlier mac_link_up() without a matching
mac_link_down(), with pl->mac_enable_tx_lpi still true? The next
phylink_start() could then call mac_link_up() again with no link-down in
between.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com
