Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397633;
	b=OvgJfiht9uc9Yrmb0SGU1H4+3f3efpESjuppT0Gdvl9eW3E9sSNCMv9BeYpM7KWzhKti
	 O6E5ZAAhnCdCB455xDWsPzPe0HMrrQXEFnE/Ku7HdX66iSJa6nO33/ZxQMHY6mjJldZCo
	 riCeLlCeOgOmXd6vql5Dc7f9AgW8Xvz9W3tRNyQwUDkGS3Nhg+dSkPJ3Lc2r98vNjLAFk
	 JaoIopXEiut3M9d611kiPFuXCQ1Jf3NGePEFCJ9/2AZ4lxes6ESN2UP4YzxwaogXfucel
	 lf3pA1XBF9UbyWRfwBUAb9Ly8R8VAhYc5QVJ0B5uDim6NWIKyIElw7veCwOhU0nWRWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397633;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=hSrhjQ/TWRX4InbKWtKHtYXAh19fxrq/c8z+nCcpNxE=;
	b=LBfVTM0zenoO+1AWPcqbKsbv06ujyEDPURURkLEsBaRFcLJtyxVK8mFznfDEuKElBgUP
	 bC7Ri+/r3UXL606zvcnq2kzEFznFNEgn9a/qCFYhvBltQefD2vU/o6/FVoVpQwxlyGCYW
	 iCk2Y7qV8RGqLRt63dLuDmCCSnL2DN7iRr4bCHKvkHv1Rieu/A928QMC5qBnreb+6AXBE
	 VxO5TiYDkTviGU7YDFuZBoH1fM0zIc7EavA6vGc3fE74z03Hn9Fq72Z9p1mVVXrtb9ZhR
	 MOPy9k0XBk/D7JuWS87Exifsxc9YrKHfXNukl5JTprBmjwHPpHbPHtWOHSLA1WxwQvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjfRabsX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592B606A683;
	Mon, 23 Nov 2026 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjfRabsX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FA41F000C4;
	Mon, 23 Nov 2026 01:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397632;
	bh=hSrhjQ/TWRX4InbKWtKHtYXAh19fxrq/c8z+nCcpNxE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DjfRabsXEcvkrNBAKFQ6l8gc8rtUoMV6pzUvAvkSWF6vBkeWa0CCGIdn8vGD0MAzQ
	 dU8RX+SIZgDjjegpfTvzYlr/eDJUcA0nO63sZEvQ0wNP6J9dIjSRjo7eqJaTxTiNRD
	 MyNcMp+WrUUi9EBNIG1IhiLFQ319Zlmx3rKM+dE4QisAZsyNwe6AgJdfAWi7tlSfr3
	 WevaCinA8TObY6N8+e0Ott6V0Y+z7fkvI2H/YyMGy1yP7Om2ybyxdwG1lqFHQDSnAQ
	 Dgb2r4YuyNw5I8YNm/uEtKk26dmWfCcYiUftR59L1UjlmC1jM1s1gtg6o/1z19sp0C
	 6CmYL3IQNOn5g==
Subject: Re: [PATCH net-next v2 6/9] eth: mlx5e: drop the now-dead HW-GRO and
 LRO vs XDP handling
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org, nktgrg@google.com
Date: Mon, 23 Nov 2026 01:33:51 +0000
Message-ID: <179539763134.3135.16178645255065325636@kernel.org>
In-Reply-To: <20261122010112.1471146-7-kuba@kernel.org>
References: <20261122010112.1471146-7-kuba@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch removes mlx5e's own HW-GRO/LRO vs XDP handling.
- [Medium] The patch keys the whole NETDEV_XDP_ACT_XSK set
  (BASIC|REDIRECT|XSK_ZEROCOPY, plus RX_SG) in mlx5e_set_xdp_feature()…
- [Medium] mlx5e_set_xdp_feature() now dereferences
  priv->netdev->cfg_pending->hds_config.

--

eth: mlx5e: drop the now-dead HW-GRO and LRO vs XDP handling

This patch removes the mlx5e driver-side refusal of an XDP attach while
HW-GRO or LRO is on. It also removes the XDP clause in mlx5e_fix_features()
and relies on the core to clear those features and keep them off while a
program is attached. XDP features are now advertised based on
tcp-data-split rather than packet merge, and mlx5e_set_ringparam()
refreshes them when hds changes.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 06a8a4be4be7c..08568137d044d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -4487,12 +4487,14 @@ static int mlx5e_handle_feature(struct net_device *netdev,
>  
>  void mlx5e_set_xdp_feature(struct mlx5e_priv *priv)
>  {
> +	struct netdev_config *cfg = priv->netdev->cfg_pending;

[Severity: Medium]
Is it safe to dereference netdev->cfg_pending here without the netdev
instance lock?

Two callers run mlx5e_set_xdp_feature() on a registered netdev with only
rtnl_lock held: mlx5e_nic_init() and mlx5e_build_rep_params(). Both follow
this pattern:

	if (take_rtnl)
		rtnl_lock();

	/* update XDP supported features */
	mlx5e_set_xdp_feature(priv);

	if (take_rtnl)
		rtnl_unlock();

Both callers are reachable from mlx5e_netdev_change_profile() during
eswitch mode changes.

ethnl_default_set_doit() allocates, swaps and frees cfg_pending while
holding only the instance lock. It does this for the commands mlx5e does
not opt in to rtnl, such as COALESCE_SET, PAUSE_SET, RSS_SET and
LINKMODES_SET:

	ret = netdev_reconfig_start(dev);
	...
out_free_cfg:
	__netdev_free_config(dev->cfg_pending);
	dev->cfg_pending = dev->cfg;

Could the following interleaving read freed memory?

CPU1 (COALESCE_SET, instance lock)
    dev->cfg_pending = P;               /* fresh copy */

CPU0 (profile change, rtnl only)
    cfg = netdev->cfg_pending;          /* P */

CPU1
    __netdev_free_config(P);
    dev->cfg_pending = dev->cfg;

CPU0
    cfg->hds_config                     /* reads freed P */

Reading dev->cfg instead doesn't look safe either. On a successful SET,
the old dev->cfg is swapped into the pending slot and then freed.

Would taking netdev_lock() after rtnl_lock() around these calls work here?
That is the same order mlx5e_nic_enable() uses.

>  	struct mlx5e_params *params = &priv->channels.params;
>  	struct net_device *netdev = priv->netdev;
>  	xdp_features_t val = 0;
>  
> +	/* XDP can't run with HW-GRO, and tcp-data-split keeps HW-GRO on */
>  	if (netdev->netdev_ops->ndo_bpf &&
> -	    params->packet_merge.type == MLX5E_PACKET_MERGE_NONE)
> +	    cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED)
>  		val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>  		      NETDEV_XDP_ACT_XSK_ZEROCOPY |
>  		      NETDEV_XDP_ACT_RX_SG;

[Severity: Medium]
Does keying these bits off hds_config also change how AF_XDP zero-copy
bind behaves?

Together, BASIC, REDIRECT and XSK_ZEROCOPY make up NETDEV_XDP_ACT_XSK, and
xp_assign_dev() checks that set before it allows a zero-copy bind:

net/xdp/xsk_buff_pool.c:xp_assign_dev() {
	...
	if ((netdev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK) {
		err = -EOPNOTSUPP;
		goto err_unreg_pool;
	}
	...
}

Before this patch, a zero-copy bind on mlx5e with LRO or HW-GRO on was
refused, or fell back to copy mode. Now it reaches this path:

ndo_bpf(XDP_SETUP_XSK_POOL)
  mlx5e_xsk_setup_pool()
    mlx5e_xsk_enable_locked()

mlx5e_xsk_enable_locked() registers the pool and bumps priv->xsk.refcnt
without checking packet_merge.

Nothing on that path calls netdev_update_features(), and
dev_xdp_clear_rx_agg() only runs for XDP_SETUP_PROG. So the commit message
says "The AF_XDP check stays", but the priv->xsk.refcnt clause in
mlx5e_fix_features() is not applied at bind time. LRO or HW-GRO stays on
while an XSK pool is bound.

This also seems to open a sequence that was unreachable before:

1. Bind a zero-copy XSK with HW-GRO on and tcp-data-split=auto.
2. Set tcp-data-split=enabled. mlx5e_ethtool_set_tcp_data_split() accepts
   it because GRO_HW is still in dev->features.
3. mlx5e_fix_features() clears GRO_HW in the XSK clause, then the HDS
   clause forces it back on.
4. mlx5e_set_ringparam() calls mlx5e_set_xdp_feature(), which withdraws
   XSK_ZEROCOPY while a zero-copy pool is still bound.

The commit message only describes the XDP attach change ("used to fail
with -EINVAL and now succeeds"). Should the AF_XDP zero-copy bind change
be handled here, or at least described?

[ ... ]

> @@ -4604,17 +4606,6 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
>  		}
>  	}
>  
> -	if (params->xdp_prog) {
> -		if (features & NETIF_F_LRO) {
> -			netdev_warn(netdev, "LRO is incompatible with XDP\n");
> -			features &= ~NETIF_F_LRO;
> -		}
> -		if (features & NETIF_F_GRO_HW) {
> -			netdev_warn(netdev, "HW GRO is incompatible with XDP\n");
> -			features &= ~NETIF_F_GRO_HW;
> -		}
> -	}
> -

[Severity: High]
On mlx5e, does the core really keep HW-GRO off for as long as a program is
attached?

__netdev_update_features() strips NETIF_F_XDP_DISABLES only before it calls
ndo_fix_features, and doesn't check again afterwards:

net/core/dev.c:__netdev_update_features() {
	...
	if ((features & NETIF_F_XDP_DISABLES) && dev_xdp_prog_count(dev)) {
		netdev_dbg(dev, "Dropping HW-GRO and LRO features since XDP is attached.\n");
		features &= ~NETIF_F_XDP_DISABLES;
	}

	if (dev->netdev_ops->ndo_fix_features)
		features = dev->netdev_ops->ndo_fix_features(dev, features);
	...
}

Later, mlx5e_fix_features() adds GRO_HW back unconditionally for HDS:

	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    !(features & NETIF_F_GRO_HW)) {
		...
		features |= NETIF_F_GRO_HW;
	}

Can this sequence leave SHAMPO active with an XDP program attached?

1. Enable HW-GRO and tcp-data-split.
2. Run ethtool -K <dev> rx-fcs on (or rx off). netdev_fix_features() drops
   GRO_HW after the driver hook, and set_feature_hw_gro(false) sets
   packet_merge to NONE. hds_config stays ENABLED.
3. Attach a multi-buffer native XDP program. dev_xdp_install() only
   refuses hds for !xdp_has_frags, and dev_xdp_clear_rx_agg() sees no
   GRO_HW or LRO. mlx5e_xdp_set() now only calls
   mlx5e_params_validate_xdp().
4. Run ethtool -K <dev> rx-fcs off. The core strips GRO_HW, then
   mlx5e_fix_features() forces it back for HDS, and netdev_fix_features()
   no longer drops it. mlx5e_set_features()->set_feature_hw_gro(true)
   then switches packet_merge to SHAMPO with params.xdp_prog set.

With SHAMPO, the RQs use mlx5e_handle_rx_cqe_mpwrq_shampo(). Header-split
packets go through mlx5e_skb_from_cqe_shampo(), which never runs
rq->xdp_prog, so that traffic would skip the attached program.

The removed xdp clause had the same ordering problem, because it ran
before the HDS clause. However, this patch removes the driver-side
handling on the basis of the core guarantee, and the gap still seems to
be there at the end of the series.

Is anything on this path meant to reject SHAMPO while an XDP program is
attached?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122010112.1471146-1-kuba%40kernel.org
