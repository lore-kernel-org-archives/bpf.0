Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366993;
	b=R5yrfnIxoObWi0NQuAM0jR5OiAD9+HfGUBHWIOyoCjN4aWpqEfklvCs/6QSWTmXYNtEZ
	 CqjdXQqh44RdT41cwFy9SuVvlHm7IgCexJIDlfBbOBYI3wgvItlSsAAyBBEKFTlErRJEq
	 vCrtRV1tvemWN12sAA5roQ9Rjo9eu3EyCO5ynM3RqC7sLyR+qz2oiff/hIfFGkNa4GHBw
	 43SWR8vxxh7Y3Qb82J3khrqvdM2F+8QG6oUM5YRUCurxHXa2twQ5c1MfnQi1u9xRt+r/B
	 Z2P+piZyafBV3M7U2ng1b825y7STbtpoipZpn6WDWJn9kFgiJ8BbQePtiZCIEQvl6CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366993;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wlxuZ0OpqEBh+1LpCqTaALs6uRazNSVFbb0AQzNjJYM=;
	b=ro792RIMEwZkUyzubO12UHZ8/xkQWQyIHXf+KOvUO5iIIOIB26gxbmkwYsjxBGhjuYiq
	 z++ntgdQR+F8Hy9i+2vSXjJpdaCM/EDtnUz2G2zE7CcSHCi7smVBnzyH17Da5CeRbZjPl
	 FjE0RX5+5sFVoBxeplOxBEyRFgqbKlpGFSmv5MPjtkZiES38+8yhnqimY/SYTPJUBuF2l
	 7zaSP84D1BNFlEGjvy0Xbo+G8RTeVxyaDhEiFkF29Q4q+yg1BwK+lYgjAMzO3hSdp5sZk
	 HaKg6fiEKlNSWBpvRXmtOrw5vGHvdS5fJeD5IAAjgWQD9hjaZo+Cqsx2QvTPHn4dT/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcDMOQ+w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B4606A330;
	Sun, 22 Nov 2026 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcDMOQ+w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACE91F0089E;
	Sun, 22 Nov 2026 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366993;
	bh=wlxuZ0OpqEBh+1LpCqTaALs6uRazNSVFbb0AQzNjJYM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LcDMOQ+w69hTjgX+klwYRUdZjCVr7DMNMpSC789EGixvshq21r0aQ95tLp+RndtyJ
	 pPLMxysgfub8pwJI7IbWVhb9T1zxUQU43xi2w4Z8cMFcxEz42FW6VwddPpUZO4PMMH
	 cmTNfjaBUDnndWFaXUH8eKdjEkLcCMmdh4b0yIrFqBrjWA80+OYYS2od7wK5HThq3x
	 XDXHqoKBNu2829qwmbzwDUHX6GM3y/EJmGwgqe6B7AWGMKh+0xJNoKrVn4jmxP9J59
	 vOVA6Fedxrwh+UvAF2ar8LJ9eOFRWGtM7bZzn4TBUVfj7fetgQlcnNaSfsL7a3fx4k
	 gOWK1poop6TwA==
Subject:
 Re: [PATCH net-next 8/8] eth: gve: drop the now-dead HW-GRO vs XDP interlock
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
Date: Sun, 22 Nov 2026 17:03:11 +0000
Message-ID: <179536699175.3135.17888123102023780384@kernel.org>
In-Reply-To: <20261118232315.3593731-9-kuba@kernel.org>
References: <20261118232315.3593731-9-kuba@kernel.org>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A gve XDP attach that gve will reject now rebuilds every queue
  twice before failing.
- [Medium] Removing the `priv->xdp_prog && GRO_HW` refusal from
  gve_set_features() lets gve rebuild its DQO RX queues with RSC on…
- [Low] The core reports a misleading -EBUSY "required by another
  feature" when gve's ndo_set_features fails while it is clearing HW-GRO…

--

eth: gve: drop the now-dead HW-GRO vs XDP interlock

This patch removes two gve checks. One refused an XDP attach while
NETIF_F_GRO_HW was on, and the other refused to turn NETIF_F_GRO_HW back
on while an XDP program was attached. The core now clears HW-GRO before
ndo_bpf runs and keeps it off while a program is attached, so an XDP
attach with HW-GRO on now succeeds with HW-GRO turned off.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 0ee69bc11d836..8b65b8119662d 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1798,12 +1798,6 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
>  	struct gve_priv *priv = netdev_priv(dev);
>  	u16 max_xdp_mtu;
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
With this check gone, does an XDP attach that gve will reject anyway now
rebuild all of the queues twice before it fails?

In dev_xdp_attach(), the core clears HW-GRO before the driver sees the
program:

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

On a running DQO device with HW-GRO on (the probe default), the sequence
is:

dev_xdp_clear_rx_agg()
  netdev_update_features()
    gve_set_features()
      gve_adjust_config()              <- rebuild 1, RSC off
dev_xdp_install()
  gve_xdp()
    gve_verify_xdp_configuration()     <- returns -EOPNOTSUPP
err_clear_pending:
  netdev_update_features()
    gve_set_features()
      gve_adjust_config()              <- rebuild 2, RSC back on

gve_verify_xdp_configuration() can still refuse the attach at that point
in several cases:

  - a jumbo MTU above 2048 - ETH_HLEN
  - a packet_buffer_size other than SZ_2K
  - header split with a frags-capable program (the core hds_config check
    only rejects !xdp_has_frags)
  - an RX/TX queue count mismatch

Before this change, the same request failed with -EOPNOTSUPP and the
queues were left alone. Now a refused attach interrupts traffic twice.
Either rebuild can also end up in the failure branch of
gve_adjust_config():

	err = gve_queues_start(priv, tx_alloc_cfg, rx_alloc_cfg);
	if (err) {
		...
		gve_queues_mem_remove(priv);
		gve_turndown(priv);
		return err;
	}

Would it make sense to check gve's XDP preconditions before the core
reconfigures HW-GRO? If not, could the commit message mention this cost
on the failure path? The ordering comes from the core patch "net: state
the "XDP excludes HW-GRO" rule in the core".

> @@ -2212,12 +2206,6 @@ static int gve_set_features(struct net_device *netdev,
>  	if ((netdev->features & NETIF_F_GRO_HW) !=
>  	    (features & NETIF_F_GRO_HW)) {
>  		netdev->features ^= NETIF_F_GRO_HW;
> -		if (priv->xdp_prog && (netdev->features & NETIF_F_GRO_HW)) {
> -			netdev_warn(netdev,
> -				    "HW-GRO is not supported when XDP is on.");
> -			err = -EOPNOTSUPP;
> -			goto revert_features;
> -		}

[Severity: Medium]
Can this check still fire when the core's XDP state and gve's
priv->xdp_prog disagree after a failed detach?

dev_xdp_detach_link() ignores the driver's return value and then
recomputes the features:

net/core/dev.c:dev_xdp_detach_link() {
    ...
	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
	dev_xdp_set_link(dev, mode, NULL);
	netdev_update_features(dev);
    ...
}

gve_set_xdp() only writes priv->xdp_prog on success. So when the detach
fails, the program and the XDP rings stay active. There are at least two
ways for gve's detach to fail:

  (a) gve_xdp() runs gve_verify_xdp_configuration() even for a NULL
      program. gve has no ndo_change_mtu, so the MTU can be raised above
      2048 - ETH_HLEN while XDP is attached. The detach then fails with
      -EOPNOTSUPP.

  (b) gve_configure_rings_xdp(priv, 0)->gve_adjust_config()->
      gve_queues_mem_alloc() returns -ENOMEM.

Once the link is cleared, dev_xdp_prog_count() returns 0. That means
__netdev_update_features() keeps NETIF_F_GRO_HW from wanted_features
and calls gve_set_features().

Before this patch, the priv->xdp_prog check reverted that change. Now
gve_adjust_config() runs with the XDP rings still configured, and
gve_adminq_create_rx_queue() programs RSC from dev->features alone:

		cmd->create_rx_queue.enable_rsc =
			!!(priv->dev->features & NETIF_F_GRO_HW);

The DQO RX path would then run the program that is still attached on
only the first 2K buffer of each coalesced frame. A later
"ethtool -K rx-gro-hw on" would reach the same state.

Doesn't that contradict the statement in the commit message that
"neither of these can fire any more"?

>  		if (netif_running(netdev)) {
>  			err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
>  			if (err)

[Severity: Low]
The core's dev_xdp_clear_rx_agg() is now the only thing that turns
HW-GRO off before XDP on gve. What error does userspace see when this
gve_adjust_config() call fails during an XDP attach?

If gve_queues_mem_alloc(), gve_close() or gve_queues_start() fails,
gve_set_features() jumps to revert_features. That restores orig_features
with NETIF_F_GRO_HW still set:

revert_features:
	netdev->features = orig_features;
	return err;

__netdev_update_features() logs the real errno with netdev_err() and
returns -1, but netdev_update_features() throws that away.
dev_xdp_clear_rx_agg() then treats the bit that is still set as a
feature dependency:

	netdev_update_features(dev);

	agg = dev->features & NETIF_F_XDP_DISABLES;
	if (agg) {
		NL_SET_ERR_MSG_FMT(extack,
				   "unable to disable %s, required by another feature",
				   dev_xdp_rx_agg_name(agg));
		return -EBUSY;
	}

gve has no ndo_fix_features, so no feature dependency exists here.
Could the core check the return value of __netdev_update_features(), so
that this case reports the driver's error instead of -EBUSY and a
dependency message? This also comes from the core patch "net: state the
"XDP excludes HW-GRO" rule in the core".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118232315.3593731-1-kuba%40kernel.org
