Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397634;
	b=yy57mWKx7am1eps5IscAC4HN+tbIMYyNOBxEfzAu98FR0vLp4g4qYkM/+1kP6GM5pPbo
	 so1e66U6SJy800mkhUcNupP60usfaVaN8ticLRGqtYO/X8lzYnNHRe2vD2UWFaj+n/0XE
	 yrT4n61xyfnxZEsuXW9hPLVM3OKEnfSQPxxxofUEKrG+ynotW9FcN06NThbPfvpSPGPAe
	 W5zRgynzI55oGfnLKNDLAQJKdDkJM/4YSzNx373haqa68mkkOnB5C1t7OZoJ9J+0msEXt
	 TYfwdJbLSUepo+GraSsbpD+F37l8Z0Mg1oAr8rtH2j1yzmBCfIcSOFYM0kMu7T5OUPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397634;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TFjV7U7E5Jx1Ins2cB0HnvxZayy3EZy1RrJEu6KQsis=;
	b=uRnuRRhPbXphUw58HmVd9PQtFSfeSoR8cM3zrnyKbW65NJsBHhz87qIMPhGyREFV5+wU
	 FcTx5sbo710Qy1V06pD7SIeQWch9DBIll/3mnB4Mi4i4e+oVEST4E/jZl6dXgLNm+LV2y
	 lwrqbKxKZrOppEYaKPAr4IYg3vGOk4bUAlkbgbNaDWg8agfKw7q66UHUOtMeP5ktjaqZx
	 Adj+ykuoc3QLwGyBM/Q+bzl2c3VENETGZ3GwKePDrkzLohfh0IO86RhvmgMlQ6uT3aRb0
	 gC3aBNdiMUSYEmQdWYVdru+hdi9/9S57czsr+DWt+MRYxCF9HIOXaigmQyw3I3DLRrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehUlkQuc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670C606A332;
	Mon, 23 Nov 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehUlkQuc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587111F000C4;
	Mon, 23 Nov 2026 01:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397634;
	bh=TFjV7U7E5Jx1Ins2cB0HnvxZayy3EZy1RrJEu6KQsis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ehUlkQucOqjykh4wWL3BvReDkEexCsjN4X9QiqTyw2K/9Yuql7oK+bCqXG0ppjUEf
	 It2cJdkkztbFLFFgaqLR0ldSI/dzgEzk2E6Tx6TylGiRSGFcOBsMU8+oETAPHOQH5L
	 oxTQv3kKTzbxPdPoyvxdUcbmUDe7aoTZjoZ8uwM0VQ3e9CObaKdcsQYlc/hp0BJLbI
	 1js/mo3RLvjYXyTBvSGzYRshz7Zi7ino9cdCmtHtnqvtRbzp+rgs9qWkxdjoQ/S+YK
	 3c/a8h40wYTATYqzcxHRNf7Zv9p/l5T8TDESqdxniaS2ocbfpFXokefDED9skhNtjE
	 F6eHtObpoZLsg==
Subject: Re: [PATCH net-next v2 9/9] eth: gve: drop the now-dead HW-GRO vs XDP
 interlock
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org, nktgrg@google.com
Date: Mon, 23 Nov 2026 01:33:52 +0000
Message-ID: <179539763293.3135.3326411357299687013@kernel.org>
In-Reply-To: <20261122010112.1471146-10-kuba@kernel.org>
References: <20261122010112.1471146-10-kuba@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A rejected XDP attach on a running gve DQO device with HW-GRO
  on (the DQO default) now rebuilds all of the device's hardware queues…
- [Low] gve's XDP attach path no longer reports its own error when HW-GRO
  cannot be turned off, because the HW-GRO handling now happens inside…

--

eth: gve: drop the now-dead HW-GRO vs XDP interlock

This patch removes two gve checks: one refused XDP while HW-GRO was on,
the other refused HW-GRO while XDP was attached. The core now clears
NETIF_F_GRO_HW before ndo_bpf runs and keeps it off while a program is
attached. Attaching XDP with HW-GRO on now succeeds with HW-GRO turned
off instead of failing with -EOPNOTSUPP.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 35cf0f06a0f27..59ced629dcf6b 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1804,12 +1804,6 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	if (dev->features & NETIF_F_GRO_HW) {
> -		NL_SET_ERR_MSG_MOD(extack,
> -				   "XDP is not supported when HW-GRO is on.");
> -		return -EOPNOTSUPP;
> -	}
> -
>  	if (priv->header_split_enabled) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "XDP is not supported when header-data split is enabled.");

[Severity: Medium]
With this check gone, a rejected XDP attach on a running gve DQO device
with HW-GRO on (the DQO default) seems to rebuild every hardware queue
twice before it fails. Is that intended?

In dev_xdp_attach(), HW-GRO is cleared before dev_xdp_install() and
ndo_bpf get a chance to refuse:

net/core/dev.c:dev_xdp_attach() {
    ...
		if (new_prog) {
			dev->xdp_pending = 1;
			err = dev_xdp_clear_rx_agg(dev, extack);
			if (err)
				goto err_clear_pending;
		}

		err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
		if (err)
			goto err_clear_pending;
    ...
err_clear_pending:
	dev->xdp_pending = 0;
	netdev_update_features(dev);
	return err;
}

dev_xdp_clear_rx_agg()->netdev_update_features() reaches
gve_set_features() with GRO_HW cleared. On a running device that runs a
full gve_adjust_config(): gve_queues_mem_alloc(), gve_close(), then
gve_queues_start(). RSC is fixed per queue when the queue is created, in
gve_adminq_create_rx_queue():

	cmd->create_rx_queue.enable_rsc =
		!!(priv->dev->features & NETIF_F_GRO_HW);

The remaining refusals only run after that rebuild. First come the core
checks in dev_xdp_install(), then
gve_xdp()->gve_verify_xdp_configuration(), which checks queue format,
header split, buffer size, MTU and queue counts.

If any of them fails, err_clear_pending calls netdev_update_features()
again. GRO_HW is still in wanted_features, so gve_adjust_config() runs a
second time to turn RSC back on.

DQO_QPL looks like the easiest way to hit this. gve_init_priv() enables
NETIF_F_GRO_HW for every DQO format, but gve_set_netdev_xdp_features()
leaves xdp_features at 0 for DQO_QPL:

	} else {
		xdp_features = 0;
	}

As a result, every native attach on a running DQO_QPL device rebuilds the
queues twice and then fails with "XDP is not supported on this queue
format.". The MTU and queue-count refusals can be hit the same way on
DQO_RDA, for example with a jumbo MTU.

Either rebuild can also fail in gve_queues_start(), which leaves the
interface running with no live queues:

	err = gve_queues_start(priv, tx_alloc_cfg, rx_alloc_cfg);
	if (err) {
		netif_err(priv, drv, priv->dev,
			  "Adjust config failed to start new queues, !!! DISABLING ALL QUEUES !!!\n");
		gve_queues_mem_remove(priv);
		gve_turndown(priv);
		return err;
	}

Before the series, gve refused the same request right away with no
hardware side effects. The new ordering comes from the earlier patch
"net: state the "XDP excludes HW-GRO" rule in the core", which put
dev_xdp_clear_rx_agg() ahead of dev_xdp_install() and ndo_bpf.

The commit message only describes the success case ("now succeeds with
HW-GRO turned off"). Even a successful attach now rebuilds the queues
twice: once for the GRO_HW toggle and once in gve_configure_rings_xdp().

Could the gve configuration checks run before the core clears HW-GRO? If
the double rebuild is acceptable, could the commit message say so?

> @@ -2218,12 +2212,6 @@ static int gve_set_features(struct net_device *netdev,
>  	if ((netdev->features & NETIF_F_GRO_HW) !=
>  	    (features & NETIF_F_GRO_HW)) {
>  		netdev->features ^= NETIF_F_GRO_HW;
> -		if (priv->xdp_prog && (netdev->features & NETIF_F_GRO_HW)) {
> -			netdev_warn(netdev,
> -				    "HW-GRO is not supported when XDP is on.");
> -			err = -EOPNOTSUPP;
> -			goto revert_features;
> -		}
>  		if (netif_running(netdev)) {
>  			err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>  			if (err)

[Severity: Low]
If gve_adjust_config() fails here while the core is turning HW-GRO off
for an XDP attach, does the user get the real error back?

gve_set_features() restores orig_features and returns the errno.
__netdev_update_features() only logs that errno and returns -1, and
netdev_update_features() discards the -1. dev_xdp_clear_rx_agg() then
just re-reads dev->features:

net/core/dev.c:dev_xdp_clear_rx_agg() {
    ...
	netdev_update_features(dev);

	agg = dev->features & NETIF_F_XDP_DISABLES;
	if (agg) {
		NL_SET_ERR_MSG_FMT(extack,
				   "unable to disable %s, required by another feature",
				   dev_xdp_rx_agg_name(agg));
		return -EBUSY;
	}
    ...
}

gve has no ndo_fix_features, and no gve feature depends on HW-GRO. For
gve, GRO_HW can only stay on because gve_set_features() failed: -ENOMEM
from gve_queues_mem_alloc(), an adminq error from gve_close(), or a
gve_queues_start() failure.

The user gets -EBUSY and a feature-dependency message instead of the
real errno.

If gve_queues_start() was the failure, the device is also left turned
down. The later netdev_update_features() call in err_clear_pending finds
features already equal to wanted_features and does nothing. Nothing in
the extack shows that the NIC has lost its queues.

Before the series, gve refused the same request itself with a specific
-EOPNOTSUPP extack. The new error reporting comes from the earlier patch
"net: state the "XDP excludes HW-GRO" rule in the core".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122010112.1471146-1-kuba%40kernel.org
