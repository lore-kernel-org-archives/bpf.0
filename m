Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366989;
	b=Qy5hJDONuaCJv23DdPvPVjY7AeUO7GI6tK+NCTAn+qJalPSkkS5/CoVJmyjO+t0ZDX7d
	 E1MRJPGZW5SN+o13eBQZVunZkdzK4svsuw191ZXDG2QEy2ZWN9zs0L+f0fOm/oEpV0vB0
	 2tpt9U2KVou2KMPBxUtZ04qH5Ypex/TylqeBSBN8HPfHhylJXI907Onps4SOQ0yh4xagm
	 vDhzcToPGMWS/ohmnXScOC+VyktKi1XhAp7/f/XCjpHQ+oh68KwAD0xPruqdU/CZX8+uw
	 R1jXLOb1vr6uKGUgkljoHSITvRlwC8aop7t7W66TylQYTrM9DnFJWGNTKpX3nwCv1VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366989;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7mlhzgdEHG82CBdkOiOI4F4bFR6o3gvjX8G2/QVEMLU=;
	b=N3myZzoDj97XH22ImiKTb1Nc9fGNWcsatCJjtaWzhRsIVgiLHNntPCTT8Hs+xrReMSGO
	 zAO0L5WzMDrhr7SxhBs3Q0W73JK5lv5DVQgZ2VAaj8TvbwggqS0WR3UImv6ueElQwCnQO
	 79FP8tSQ+uA5h0U1I0sot+Uvc5VVMiIrPHDZYiwAWB06a6Ciaa+f0xh+pwbtuk60q4kRL
	 7XigR6m26QYuBaC8qL4PHelnoIHVddG4v78Gg+t8tQEZYj+rC44H+LndimvE9//AAAVRY
	 PfQWwAKC42Ciu5DgvNUkRWEbeYLQrCpUkMJCQ6yD6bF8oYdh2izcsJriGQuZSqprkEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgIN7M0Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E0606A331;
	Sun, 22 Nov 2026 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgIN7M0Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516761F000CF;
	Sun, 22 Nov 2026 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366989;
	bh=7mlhzgdEHG82CBdkOiOI4F4bFR6o3gvjX8G2/QVEMLU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mgIN7M0YSkIozPR7XXuFMY33ouj+9hnQjzonHtsFdOoQpRYrIXEX3pH3a9jM5WS7D
	 2K3+xT2M8ZwtykThoDEFvRKz5QIasAjE2yNBnzT0Z8HsATo2ZPTN+d7HuSrz8YeIii
	 eBgbhbVTAcRGbNrYy/JflRA37FyVw+3+BQXli43L8fCQVVkARw0/niS9G9tJXIcK9v
	 Ev7Orw8oqKHe1+/wrPerKooadAaY1QRNwaA2AQf46EedaqyRsQv1dTLxeb3QMs210j
	 Fbd1BxhKfZBZah0PS3xExBU6oScl3TlRItLCHCy/qTiZkO5QWvCVmjZvsjAed4HMJw
	 9AjeEMz0darzw==
Subject: Re: [PATCH net-next 5/8] eth: mlx5e: drop the now-dead HW-GRO and LRO
 vs XDP handling
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
Date: Sun, 22 Nov 2026 17:03:07 +0000
Message-ID: <179536698791.3135.11919808360238549850@kernel.org>
In-Reply-To: <20261118232315.3593731-6-kuba@kernel.org>
References: <20261118232315.3593731-6-kuba@kernel.org>
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

- [Medium] mlx5e_set_xdp_feature() in
  drivers/net/ethernet/mellanox/mlx5/core/en_main.c still sets…
- [Low] The commit message calls the removed code 'now-dead' and then
  says 'This does change user visible behavior: attaching XDP with HW-…
- [Low] mlx5e_xdp_set() still ends with '/* Need to fix some features.

--

eth: mlx5e: drop the now-dead HW-GRO and LRO vs XDP handling

The core now clears HW-GRO and LRO before ndo_bpf and keeps them off
while an XDP program is attached. This patch removes the xdp_prog clause
from mlx5e_fix_features() and the packet_merge refusal in
mlx5e_xdp_allowed(), and calls mlx5e_params_validate_xdp() directly from
mlx5e_xdp_set().

> This does change user visible behavior: attaching XDP with HW-GRO or LRO
> on used to fail with -EINVAL and now succeeds with them turned off.

[Severity: Low]
Is this attribution accurate? The subject calls the removed code
"now-dead". At the parent commit, the -EINVAL in mlx5e_xdp_allowed()
already looks unreachable:

dev_xdp_attach()
    dev->xdp_pending = 1;
    dev_xdp_clear_rx_agg()
        netdev_update_features()
            __netdev_update_features()
                strips NETIF_F_XDP_DISABLES (xdp_pending is counted
                by dev_xdp_prog_count())
                mlx5e_set_features()
                    set_feature_lro() / set_feature_hw_gro()
                        packet_merge.type = MLX5E_PACKET_MERGE_NONE
    ndo_bpf -> mlx5e_xdp_set()

netif_xdp_propagate() follows the same sequence. When HW-GRO is pinned,
the core returns -EBUSY before ndo_bpf is called.

So the change from -EINVAL to success seems to come from the earlier core
commits ("net: state the "XDP excludes HW-GRO" rule in the core" and
"net: state the "XDP excludes LRO" rule in the core"), not from this
patch.

Could the message say that, and also mention the dependency in the other
direction? This patch removes both mlx5e guards: the xdp_prog clause in
mlx5e_fix_features() and the packet_merge refusal. If it is applied or
backported without the core commits, XDP could run on LRO/HW-GRO
coalesced frames.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index d8563f8638447..e462dfc725ae4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c

[ ... ]

> @@ -5177,20 +5166,6 @@ static void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  	queue_work(priv->wq, &priv->tx_timeout_work);
>  }
>  
> -static int mlx5e_xdp_allowed(struct net_device *netdev, struct mlx5_core_dev *mdev,
> -			     struct mlx5e_params *params)
> -{
> -	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
> -		netdev_warn(netdev, "can't set XDP while HW-GRO/LRO is on, disable them first\n");
> -		return -EINVAL;
> -	}

[Severity: Medium]
With this refusal gone, does mlx5e_set_xdp_feature() also need an
update? It still advertises native XDP only when packet merge is off:

drivers/net/ethernet/mellanox/mlx5/core/en_main.c:mlx5e_set_xdp_feature() {
    ...
	if (netdev->netdev_ops->ndo_bpf &&
	    params->packet_merge.type == MLX5E_PACKET_MERGE_NONE)
		val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
		      NETDEV_XDP_ACT_XSK_ZEROCOPY |
		      NETDEV_XDP_ACT_RX_SG;
    ...
}

With LRO or HW-GRO on and no program attached, the netdev netlink
xdp-features attribute reports no BASIC, REDIRECT or RX_SG. A native
attach in that state now succeeds anyway:
dev_xdp_attach()->dev_xdp_clear_rx_agg() turns the offloads off before
ndo_bpf, and xdp_features is never checked.

Userspace would then see no XDP support on a device where attaching an
XDP program works. The same goes for bond_xdp_set_features(), which
intersects the slave xdp_features. After detach, the core turns
LRO/HW-GRO back on and the advertised mask is empty again.

The empty mask only looks correct when tcp-data-split pins HW-GRO, since
the core returns -EBUSY there. Would it match the new behavior better to
key this gate off the HDS state instead of packet_merge in general?

> -
> -	if (!mlx5e_params_validate_xdp(netdev, mdev, params))
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static void mlx5e_rq_replace_xdp_prog(struct mlx5e_rq *rq, struct bpf_prog *prog)
>  {
>  	struct bpf_prog *old_prog;
> @@ -5215,10 +5190,9 @@ static int mlx5e_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
>  	new_params = priv->channels.params;
>  	new_params.xdp_prog = prog;
>  
> -	if (prog) {
> -		err = mlx5e_xdp_allowed(netdev, priv->mdev, &new_params);
> -		if (err)
> -			goto unlock;
> +	if (prog && !mlx5e_params_validate_xdp(netdev, priv->mdev, &new_params)) {
> +		err = -EINVAL;
> +		goto unlock;
>  	}
>  
>  	/* no need for full reset when exchanging programs */

[Severity: Low]
This isn't a bug, but should the tail of mlx5e_xdp_set() be removed as
well?

unlock:
	mutex_unlock(&priv->state_lock);

	/* Need to fix some features. */
	if (!err)
		netdev_update_features(netdev);

Commit f6279f113ad5 ("net/mlx5e: Update netdev features after changing
XDP state") added this call so mlx5e_fix_features() could apply or
release the params->xdp_prog LRO/HW-GRO clause. This patch removes that
clause.

On attach, the core has already called netdev_update_features() via
dev_xdp_clear_rx_agg().

On detach, this call runs while dev_xdp_prog_count() is still non-zero,
because dev_xdp_set_prog() only runs after dev_xdp_install() returns. So
it cannot restore LRO/HW-GRO. That happens in the core's own
netdev_update_features() call in dev_xdp_attach(), after the program is
cleared.

The comment also suggests a dependency that no longer exists.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118232315.3593731-1-kuba%40kernel.org
