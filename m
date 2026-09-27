Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132175809;
	Sun, 27 Sep 2026 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790468969; cv=none; b=kaKScS6DpS7Eilm35D0lzlLMHvEKEM8kdDDMnYCh2TPCt1Sru7jjfD+HpFQIRKuhiPjQHfOFG8QipdPnyWShCtrq/y2BVLUZqUWKZrwp8GxFcqNUn4eAk9UGYG9PAt0jtis6DZmLszcJDoc+640MLCSlxz2odSjVQ6IN1Gv6CIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790468969; c=relaxed/simple;
	bh=c0pNCWgU1i6GqWHh7u1ewAgAcGTO7EYScQt53GKWhQo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mLy0NWTEHycXzf1vOWEnB1ZDGbGPBI/JdSehEu5Gv+FMb/nkOrMSDh60BWbLtvppouHAhj2iPX8EdBAUUR3yTz6fXyFDlfgjRNGmj+/uutvrIHmIzdBy5AzR3WIFb5/yk7SLROr0glChQJqcECc8YxPzXmhf/PQX/jlclHSPYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVqGA6cW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVqGA6cW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849221F000FF;
	Sun, 27 Sep 2026 00:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790468968;
	bh=XrTKhmN+bzHxb9X+iMRI8p0IuqIREbInH9xGjuSIv84=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oVqGA6cWjdYw9ow3kpUcwNaRqVb96bqVIWGI9m0nNJXfdwIbjARj8IumS1i3RdgmO
	 3NKrMNh7KvxULXpTU6uEGxsqH+59k+dul7XLlFnNxVZxeB6YbgAm2eAompffmQ3CC8
	 /dtu6MLcfpcfLCE4iEuhMyeKnp8ZLn1+F0Mn/itxDPEWUo5tYIDE9RzS5ZCSAluJ4V
	 0Lj1SN1swaycISwByZooME2+yJCCDIZKY/WSKqgXCG/1wrz+yJ94eoT9oN7ZMsFlvp
	 xEtnz/u6gB5mxDAOkOdm+623h3DnpWlnhkWqN74k3jJKUrLKx/FxZuvuWOChMVK+Pg
	 ZZ5RQ0n8RaRjA==
Subject:
 Re: [PATCH net v2 1/2] net: phylink: allow stopping a suspended instance
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
Date: Sun, 27 Sep 2026 00:29:26 +0000
Message-ID: <179046896605.2160803.3111812936943364050@kernel.org>
In-Reply-To:
 <20260922-submit-stmmac-reset-fixes-v1-v2-1-d92e609be996@gmail.com>
References:
 <20260922-submit-stmmac-reset-fixes-v1-v2-1-d92e609be996@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] phylink_stop() (drivers/net/phy/phylink.c:2506-2508) now
  returns early when PHYLINK_DISABLE_STOPPED is already set.

--

net: phylink: allow stopping a suspended instance

This commit lets phylink_stop() handle an instance that is still
suspended by phylink_suspend(), for example after a driver's resume
failed. Without MAC WoL it returns early, since phylink_suspend() already
called phylink_stop(). With MAC WoL it finishes the deferred
mac_link_down() and clears PHYLINK_DISABLE_MAC_WOL.

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index a1458da8111b6..df520d77fdedd 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -2495,11 +2495,18 @@ EXPORT_SYMBOL_GPL(phylink_start);

[ ... ]

>  void phylink_stop(struct phylink *pl)
>  {
>  	ASSERT_RTNL();
>  
> +	/* phylink_suspend() already stops the link without MAC WoL. */
> +	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
> +		return;
> +

[Severity: Medium]
Does this early return leave the PHY speed-down from phylink_suspend() in
place?

phylink_suspend() does this after its own phylink_stop():

drivers/net/phy/phylink.c:phylink_suspend() {
    ...
	} else {
		phylink_stop(pl);
	}

	if (phylink_phy_pm_speed_ctrl(pl))
		phylink_speed_down(pl, false);
}

In phylink, only the phylink_speed_up() call in phylink_resume() undoes
this. With this patch, stopping a suspended instance leaves
phydev->advertising reduced and the saved adv_old still pending. Phylink
still treats the instance as cleanly stopped.

With stmmac, which sets wol_phy_speed_ctrl, this looks reachable with
PHY-only WoL (wolopts_mac == 0 and phy_may_wakeup() true):

1. stmmac_resume() fails before it reaches phylink_resume(). Examples are
   a failure in plat->resume, stmmac_legacy_serdes_power_up() or
   stmmac_hw_setup().

2. The interface is closed while device_may_wakeup(priv->device) is true.
   stmmac_release() then calls phylink_speed_down() a second time:

	if (device_may_wakeup(priv->device))
		phylink_speed_down(priv->phylink, false);

   phy_speed_down() always overwrites adv_old, before it checks whether
   anything changed:

	linkmode_copy(adv_tmp, phydev->advertising);
	ret = phy_speed_down_core(phydev);
	...
	linkmode_copy(phydev->adv_old, adv_tmp);

   This replaces the saved full advertisement with the reduced one.
   __stmmac_release() then calls phylink_stop(), which returns early here.
   phylink_disconnect_phy() runs next.

3. On reopen, phylink_bringup_phy() copies the reduced phy->advertising
   into pl->link_config.advertising. The phylink_speed_up() call in
   stmmac_open() can only restore the reduced adv_old.

Would the link then negotiate only the lowest common speed, for example
10 Mbps instead of 1 Gbps? This would last through later close/open and
suspend/resume cycles until the advertisement is reset with ethtool -s.

The commit message says:

  the driver still decides whether to retry resume or wait for an ordinary
  administrative down/up cycle.

In this case the down/up cycle does not appear to restore the speed. If
device_may_wakeup() is false, the phylink_speed_up() call in stmmac_open()
does restore the advertisement. That fix comes from the driver, though,
and not from the new suspend-to-stop transition in phylink.

Should the suspend-to-stop path in phylink_stop() also call
phylink_speed_up() when phylink_phy_pm_speed_ctrl(pl) is true?

>  	if (pl->sfp_bus)
>  		sfp_upstream_stop(pl->sfp_bus);
>  	if (pl->phydev)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-submit-stmmac-reset-fixes-v1-v2-0-d92e609be996%40gmail.com
