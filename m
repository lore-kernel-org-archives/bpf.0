Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397631;
	b=Y8RU824p4DRK4KHVK3M8wW7LCXldwflxxmao6IZGW3wQDwcuSNURNNsTYP0X4FHSK42u
	 j9nlrts0bvaWtgYKbUAewaK/XEFbiLNy3671ElrZxetdRC7yYbMrTLOd4RyyB537SyVkY
	 YqUmmpokZrRkH3yLJ4lLU2oysyFCPo6RmCt16nvDxdZ1hfHyLUslFIOn6mRZK2wTpHpvW
	 GTpBzq/CkQ4G61fmlRLCJw6goRWbQuz6doKq5stIhNArhe/qQYcgNGh48A+DBuX/ASRiq
	 G18QBMBBPLNlMn/sUbJJL4rkSDThRJxk0Y5jF1szyx2JNZPLJnXN3aRT/mZsvpc+vfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397631;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mt8mJUZhq4KTZ3utexyMaCQYzKL+gpqFc3XekMPH/vs=;
	b=tOnXXq6D4p0JcW2z0baHcxVSjWbA7+LpCGAqMJ28+N/MKrOxsAVEJwMbPylvgqoUXYJS
	 aFua33wkrUmRNl10sxFT1J8Iq22W1z9Lfc7dFqW81SixlS55BWpICNBL7pL6w43ZGig2S
	 rxkmj9nPJnTohepnrX5UDROU0BqdhvJ2/4SYD9dnOj9RpNbNU6QHB6HQ7nbs7aBt428wj
	 EcT2dZIeFZGt2BLDht23vlIG2VmqNjfSsgVgcXXCqisWkX8Pn9Y5yC5aQi7QvYsiYhRVC
	 ggs4AozoYn3MWqWJ7woVcrLyt/B72Q1c3fuwOsJLWxtGu+81rHCSjgva7NgS9oH0TbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tfv53e5C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D404606A31A;
	Mon, 23 Nov 2026 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tfv53e5C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902601F000C4;
	Mon, 23 Nov 2026 01:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397630;
	bh=mt8mJUZhq4KTZ3utexyMaCQYzKL+gpqFc3XekMPH/vs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tfv53e5CQYha7nbvfhAnyzZTn6wsYR/I5Ua2iD3gdMsysxiJ05SUrj5HboAXMDdtQ
	 pY4dO6GcbmUO1zAggkALjC1TyH1FSzqsWZ34yejXQ7K2hAV4VZAjTBWDZf56vBRJPM
	 p6X89wss2xsCCNdvju/VzLmP7DW2BCfxXxZwLtkfoIKSqEDZL5U6UA7/FtS6HG2Um1
	 o/MS2soDde27BNYFQRCQHtB9MHe6zx5/q8DEeCoBIv1SpVpGyISORgUe9nEPR5/JnV
	 x0i58uHAxfmNX7rMCOD7eVdCTjIf3qKXTNb7FM8MHKiFwViek7MrWiEeG/CYMcTXGU
	 iV0aibwmKiVsA==
Subject: Re: [PATCH net-next v2 5/9] net: state the "XDP excludes LRO" rule in
 the core
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org, nktgrg@google.com
Date: Mon, 23 Nov 2026 01:33:49 +0000
Message-ID: <179539762917.3135.17061480086535171425@kernel.org>
In-Reply-To: <20261122010112.1471146-6-kuba@kernel.org>
References: <20261122010112.1471146-6-kuba@kernel.org>
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

- [Medium] On a stacked device, an XDP attach that fails now turns LRO
  off on every lower device, and it stays off.
- [Low] The netvsc driver documentation is now out of date.
- [Low] The comment above the XDP feature-clearing block in
  __netdev_update_features() (net/core/dev.c:11444-11446) still covers…

--

net: state the "XDP excludes LRO" rule in the core

This patch adds NETIF_F_XDP_DISABLES (GRO_HW | LRO). The core now clears
LRO next to HW-GRO before an XDP program is attached, and refuses the
attach if the driver keeps LRO on. It also drops netif_disable_lro() from
generic_xdp_install(), so LRO comes back on the device itself after the
detach.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5d38cdb6c3260..308501d384b6f 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10599,26 +10598,35 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,

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

Can a refused XDP attach on a bond now leave LRO off on the slaves for
good?

dev_xdp_attach() calls dev_xdp_clear_rx_agg() before dev_xdp_install() runs
its checks and before the driver's bpf_op is called:

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
}

LRO is now in NETIF_F_XDP_DISABLES. So for a bond with LRO on, this
netdev_update_features(bond) call drops LRO. LRO is also in
NETIF_F_UPPER_DISABLES, so netdev_sync_lower_features() then does this on
each slave that has LRO on:

			lower->wanted_features &= ~feature;
			__netdev_update_features(lower);

Now suppose the attach fails afterwards, for example in bond_xdp_set() when
the bonding mode doesn't support XDP:

	if (!bond_xdp_check(bond, BOND_MODE(bond))) {
		BOND_NL_ERR(dev, extack,
			    "No native XDP support for the current bonding mode");
		return -EOPNOTSUPP;
	}

The err_clear_pending path calls netdev_update_features() on the bond
only. The bond gets LRO back from its own wanted_features. But
netdev_sync_lower_features() only ever clears bits, so the slaves keep LRO
off.

The attach can also fail at this point if a slave lacks ndo_bpf or
ndo_xdp_xmit. A dev_xdp_install() check can reject it too, for example a
BPF_XDP_DEVMAP or BPF_XDP_CPUMAP program.

Before this patch, a failed native attach never touched LRO. In generic
mode, netif_disable_lro() was only called from generic_xdp_install(), and
that runs after all of the checks in dev_xdp_install().

The commit message explains that slaves stay LRO-off after a detach. It
doesn't say the same happens after a refused attach. Is that intended?

On a single device, a refused attach now also turns LRO off and back on
through ndo_set_features. On ixgbe and vmxnet3 that is a full
reconfiguration, for an attach that simple checks would reject. Could the
checks in dev_xdp_install() run before the aggregation features are
cleared?

[ ... ]

> @@ -11436,9 +11444,9 @@ int __netdev_update_features(struct net_device *dev)
>  	/* GRO_HW may be added back in via ndo_fix_features e.g. if driver needs
>  	 * it to honor the HDS config, clear it before the fix features call.
>  	 */

[Severity: Low]

This isn't a bug, but this comment still mentions only GRO_HW, while the
code below now clears NETIF_F_XDP_DISABLES, which is GRO_HW and LRO. The
patch updates the other comments and the netdev_dbg() string. Should this
comment be updated as well?

> -	if ((features & NETIF_F_GRO_HW) && dev_xdp_prog_count(dev)) {
> -		netdev_dbg(dev, "Dropping HW-GRO feature since XDP is attached.\n");
> -		features &= ~NETIF_F_GRO_HW;
> +	if ((features & NETIF_F_XDP_DISABLES) && dev_xdp_prog_count(dev)) {
> +		netdev_dbg(dev, "Dropping HW-GRO and LRO features since XDP is attached.\n");
> +		features &= ~NETIF_F_XDP_DISABLES;
>  	}

[Severity: Low]

Should Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
be updated along with this? It still says:

  XDP program cannot run with LRO (RSC) enabled, so you need to disable LRO
  before running XDP::

	ethtool -K eth0 lro off

With this change the core clears LRO before ndo_bpf is called. So
netvsc_set_features() turns RSC off first, and the "XDP: not support LRO"
refusal in netvsc_xdp_set() can no longer trigger on attach.

Following the doc by hand also clears LRO from wanted_features. LRO then
doesn't come back after the detach, as it would when the core handles it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122010112.1471146-1-kuba%40kernel.org
