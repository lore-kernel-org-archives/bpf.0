Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366988;
	b=Xp5yt23u4YQmSS6zgLgA/Qp8zJdtZuI4gvhNp6M4W5kl4O0nO10mLgb5Uu2goVCAHK6Y
	 tc8PbcoDL8Ox1adCJTowOYofG2EJL27Egm5/jrs6SMjNCBkxO3TERS9LbOXvCqS9VTg68
	 bshVBgmhMofBidLl7kzCkP8+8hRi+NGeGhv21LkLqzaeDmqHtSD3mx5QJw2BfPdG3O7o5
	 3cMK9sqSthfjdoJA7c7Ee2pGC1qjrK5ylV3LOWFN/P9ogV1hAgqw72hI/zzaXw5syPgiw
	 tjsC5s4Am+BlT2AMQF9AeXlR2JVqBHbhw39zWlRGU3AzdX11/7NMmYHRQq9YNm6KXwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366988;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tKhzkg2IcBGze+CxoAN70ZFX+EAkROqVI34Vr2dBnmk=;
	b=q17h2E/BMvlrPqAYZMXEcMC4qDi2hiLKe8hvkz8grnARHAJpdbr/VrmSkw91FJj28nJG
	 tTJVYeldMTRqds5L1e5AaOXz/5Uya9TKoZRgf1COL4nivGbF1wxLaGJtU5nE2M5dNGYjc
	 UAHvRmpZcyOQruIpiaDxVjBmnOMDi2Tw4b7YG8OMuozESqj4RTYZKQi7kpcVVEdTZN9sI
	 XmxgNqW+w8rRBAEcT4aVocnJCVw+lbKRdDjzUZtxaRC1P3GBcUIvdYb//GbkL41J1fHTn
	 f+4QglafFpEaM7fa/iigkF71roG6+Y7zCI0heG3J79y1L2nfjSF+LSjKH+NRzbOnZOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bry/fTFW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2B9606A320;
	Sun, 22 Nov 2026 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bry/fTFW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232791F000D1;
	Sun, 22 Nov 2026 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366987;
	bh=tKhzkg2IcBGze+CxoAN70ZFX+EAkROqVI34Vr2dBnmk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bry/fTFW2Rhimg2R7W5IzW3K3pdl+kgU1/Fe4HuB02G9o+7RzOck+ndo08OHnCynd
	 xYoCKSy95o6fPwXgD7yQDFGVaiLP9X2Wg7s4gIy019PaGvcErHNCTw1sxTDLimCniK
	 pGV7luUH41OYgp4CM+Hs2FaWZthbioDiX51E9ej+TzOP9U6jBks3ii0ptnIO+/uX2A
	 r416FidpBl+VSsuKrpdoxWguuA0I6pEh7HI131qFmWUXGkMtCtXSjsgpK0rkWDBved
	 zMUSMQNp8Mx+nKwtfeAqiAObXzbBT/9i3aHJzFCuoC7P+WGJKtm8dPVWSG4ngjHDUu
	 krWJ5I7d9W0og==
Subject:
 Re: [PATCH net-next 4/8] net: state the "XDP excludes LRO" rule in the core
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
Date: Sun, 22 Nov 2026 17:03:05 +0000
Message-ID: <179536698568.3135.6742683441314879200@kernel.org>
In-Reply-To: <20261118232315.3593731-5-kuba@kernel.org>
References: <20261118232315.3593731-5-kuba@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] A failed XDP attach now permanently turns LRO off on the
  lowers of an upper device such as a bond.
- [Low] The netvsc documentation still tells users to disable LRO by hand
  before attaching XDP: "XDP program cannot run with LRO (RSC) enabled,…
- [Low] The atlantic driver still encodes the old rule that LRO conflicts
  only with single-buffer XDP.
- [Low] The comment above the XDP feature clearing in
  __netdev_update_features() (net/core/dev.c:11439-11441) still covers…

--

net: state the "XDP excludes LRO" rule in the core

This commit adds NETIF_F_XDP_DISABLES (GRO_HW | LRO). With it, the core
clears LRO next to HW-GRO when an XDP program is attached, and refuses the
attach if the driver keeps LRO on. It also drops netif_disable_lro() from
generic_xdp_install(), so LRO comes back on the device after detach.

> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
> index 8eb6b80336065..62a05df8ee686 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -234,6 +234,12 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
>   */
>  #define NETIF_F_UPPER_DISABLES	NETIF_F_LRO
>  
> +/*
> + * Receive offloads which coalesce frames. XDP has to see the frames as the
> + * wire delivered them, so these are disabled while a program is attached.
> + */
> +#define NETIF_F_XDP_DISABLES	(NETIF_F_GRO_HW | NETIF_F_LRO)

[Severity: Low]
The commit message says atlantic now loses LRO under multi-buffer programs
too. Should the atlantic driver be updated to match? It still has the
single-buffer-only rule:

drivers/net/ethernet/aquantia/atlantic/aq_main.c:aq_ndev_fix_features() {
    ...
	prog = READ_ONCE(aq_nic->xdp_prog);
	if (prog && !prog->aux->xdp_has_frags &&
	    aq_nic->xdp_prog && features & NETIF_F_LRO) {
		netdev_err(ndev, "LRO is not supported with single buffer XDP, disabling\n");
		features &= ~NETIF_F_LRO;
	}
    ...
}

__netdev_update_features() now removes LRO before ndo_fix_features()
whenever dev_xdp_prog_count() is non-zero. That makes this branch dead.

aq_xdp_setup() also still writes ndev->features directly:

		if (prog && ndev->features & NETIF_F_LRO) {
			netdev_err(ndev,
				   "LRO is not supported with single buffer XDP, disabling\n");
			ndev->features &= ~NETIF_F_LRO;
		}

This check can no longer be true, because the core cleared LRO with
xdp_pending set before ndo_bpf runs.

Later patches in the series remove similar handling from mlx5, bnxt, qede
and gve. Nothing in the series touches drivers/net/ethernet/aquantia/.

[Severity: Low]
Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
still says:

  XDP program cannot run with LRO (RSC) enabled, so you need to disable LRO
  before running XDP::

	ethtool -K eth0 lro off

Should this text be updated? netvsc puts NETIF_F_LRO in hw_features when
the host supports RSC. So dev_xdp_clear_rx_agg() now clears LRO before
netvsc_bpf()->netvsc_xdp_set() runs. The "XDP: not support LRO" refusal in
netvsc_xdp_set() can no longer be reached from the core attach paths.

The document also doesn't say that LRO now comes back when the program is
detached.

> +
>  /* changeable features with no special hardware requirements */
>  #define NETIF_F_SOFT_FEATURES	(NETIF_F_GSO | NETIF_F_GRO)
>  
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c0bb5eb9fdea0..2b9c7aac09693 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10594,26 +10593,35 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,

[ ... ]

>  static int dev_xdp_clear_rx_agg(struct net_device *dev,
>  				struct netlink_ext_ack *extack)
>  {
> -	if (!(dev->features & NETIF_F_GRO_HW))
> +	netdev_features_t agg = dev->features & NETIF_F_XDP_DISABLES;
> +
> +	if (!agg)
>  		return 0;
> -	if (!(dev->hw_features & NETIF_F_GRO_HW)) {
> -		NL_SET_ERR_MSG(extack,
> -			       "unable to disable HW-GRO, fixed on");
> +	if (agg & ~dev->hw_features) {
> +		NL_SET_ERR_MSG_FMT(extack, "unable to disable %s, fixed on",
> +				   dev_xdp_rx_agg_name(agg & ~dev->hw_features));
>  		return -EOPNOTSUPP;
>  	}
>  
>  	netdev_update_features(dev);

[Severity: Medium]
Now that LRO is in NETIF_F_XDP_DISABLES, can a rejected XDP attach leave
LRO off for good on the lowers of an upper device such as a bond?

dev_xdp_attach() sets xdp_pending and calls dev_xdp_clear_rx_agg() before
anything has had a chance to reject the program. Two sets of checks run
after it:

  - the checks in dev_xdp_install(): BPF_XDP_DEVMAP/CPUMAP attach type,
    device-bound mismatch, tcp-data-split, memory provider
  - the driver's ndo_bpf

A bond has LRO in hw_features and in features by default. LRO is also in
NETIF_F_UPPER_DISABLES. So this netdev_update_features() call reaches the
following for every slave:

__netdev_update_features(bond)
  netdev_sync_lower_features(bond, slave, features)
    lower->wanted_features &= ~feature;
    __netdev_update_features(lower);

bond_xdp_set() can then reject the program. One example:

	if (!bond_xdp_check(bond, BOND_MODE(bond))) {
		BOND_NL_ERR(dev, extack,
			    "No native XDP support for the current bonding mode");
		return -EOPNOTSUPP;
	}

Another is the "Slave device does not support XDP" error. In both cases
dev_xdp_attach() only does this:

err_clear_pending:
	dev->xdp_pending = 0;
	netdev_update_features(dev);

The bond gets LRO back from its own wanted_features. Nothing in net/core,
bonding or team puts LRO back into the slaves' wanted_features, and each
slave has already gone through an ndo_set_features() reconfiguration.

netif_xdp_propagate() clears and rolls back the same way when the lower
has lowers of its own.

Before this patch, GRO_HW was not in NETIF_F_UPPER_DISABLES.
netif_disable_lro() only ran from generic_xdp_install(), after all of the
dev_xdp_install() checks had passed.

The commit message covers slaves losing LRO after a successful attach and
detach, but not after a failed attach. Should that case be mentioned too,
or could clearing LRO on the lowers wait until the attach is known to
succeed?

[ ... ]

> @@ -11431,9 +11439,9 @@ int __netdev_update_features(struct net_device *dev)
>  	/* GRO_HW may be added back in via ndo_fix_features e.g. if driver needs
>  	 * it to honor the HDS config, clear it before the fix features call.
>  	 */
> -	if ((features & NETIF_F_GRO_HW) && dev_xdp_prog_count(dev)) {
> -		netdev_dbg(dev, "Dropping HW-GRO feature since XDP is attached.\n");
> -		features &= ~NETIF_F_GRO_HW;
> +	if ((features & NETIF_F_XDP_DISABLES) && dev_xdp_prog_count(dev)) {
> +		netdev_dbg(dev, "Dropping HW-GRO and LRO features since XDP is attached.\n");
> +		features &= ~NETIF_F_XDP_DISABLES;
>  	}

[Severity: Low]
This isn't a bug, but the comment above still only mentions GRO_HW. The
code under it now clears all of NETIF_F_XDP_DISABLES (GRO_HW and LRO).
This patch updated the matching comments in dev_xdp_clear_rx_agg(),
netif_xdp_propagate() and dev_xdp_attach(). Should this one be updated as
well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118232315.3593731-1-kuba%40kernel.org
