Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795366985;
	b=yWXPARUbnaiMShrBK3jg9A1GMszP+C6sZgzB68XWIWcQn9nQejauVS7G2sneFS1FAbS/
	 QpmiDNjkPIeylt3sQas7hGz4tSNl7rvBSQQXarlf1gFY4IkaCT92PNKAZf/YjZnYXA57k
	 LsrqFjcPkNsMTdXj4rwsFHFqAsuMZwxMEscRzlUjBgwIRJTQAk5Kp29DiZGvDPBGvvJB8
	 IkbfnS/K0/cYg2CeEoHna9SttXyayV83Fqo4o1T0oiDViCptazW9PAoGjkWnouBV4RJ5e
	 lepCdp03gvYg8+WYrEVDoatE3m+oNPKS2oIW19pJ8AAFg6wHCVszAPGjfv1Sa3jl4yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795366985;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1U39VImRUhp4ZBzFGdbAkw/lcqCBqDe+o06gGUsa4/o=;
	b=SEZ2F75eSLsnXzRVIVvetowglLlHDWgrWLcSkOvzPC735pWcOE/79OHkJyZWz+zG2eXm
	 /o+xSJhtRzeD7wO2ug1/ndn6Ak0de6YTUdUMlK6tuubzd1HLmAQqK+hF78Hlk/AfEIVPp
	 87NEk3T4cdaXRvUsEMvZvaN7ObDI++MEqLjAEBG1NAKwYfYzHJdprauatF5+19KDRL0Jv
	 7ujYsE31d8Wkf64coCgooFxyCf8Yu4srEAntxcIvKL043YTzWf04LyQbFaM7+HEFLb+Hu
	 W/Q4aNe32jTDsXfKi0okS7J6ccfKdIdXPyn5lQ26Y9codR94QviFNd+hciEouu81c8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Je6sYNZ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074B606A330;
	Sun, 22 Nov 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Je6sYNZ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000BE1F000E1;
	Sun, 22 Nov 2026 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795366984;
	bh=1U39VImRUhp4ZBzFGdbAkw/lcqCBqDe+o06gGUsa4/o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Je6sYNZ7Mn1hfGA9wyZY1iCO0nfMe5juzivmGgGrbj/GgFZDIVIRBO/amJC0MgTLi
	 I8u8AdjCkWztpOGOT8oibjMVEYa4+M4bofxoe8ZoJiZ2WssyQTlZfxWlMn1cZGZ62H
	 t7qL0284Sq1fj0/47a3Sm1rWhdK9GkI6EVKvaDu1KNNOCHrdwE0fXJr4vK5yoIYEKI
	 WXLsmw+DzEaDgnYrQleN5vQoFtBUaTL3Huezkl95h7QA5wvGh98hhhxtQAaPd09sw8
	 Ol8RXNFep06chNqKewrhwZb9qfUVtzRv8jQiLF68Up9xMHRnHykzlCev/EEx16/2oZ
	 i9BIDbdI9PZHQ==
Subject: Re: [PATCH net-next 3/8] net: state the "XDP excludes HW-GRO" rule in
 the core
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org
Date: Sun, 22 Nov 2026 17:03:03 +0000
Message-ID: <179536698358.3135.1764700076873359155@kernel.org>
In-Reply-To: <20261118232315.3593731-4-kuba@kernel.org>
References: <20261118232315.3593731-4-kuba@kernel.org>
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

- [Medium] Generic (SKB-mode) XDP attach now fails on devices where
  NETIF_F_GRO_HW is fixed on, i.e. present in dev->features but missing…
- [Medium] dev_xdp_attach() now sets dev->xdp_pending = 1 and calls
  dev_xdp_clear_rx_agg() before dev_xdp_install() runs its validation.
- [Low] The commit fixes concrete user-visible bugs but carries no Fixes:
  tag.

--

net: state the "XDP excludes HW-GRO" rule in the core

This commit moves the "XDP excludes HW-GRO" policy into the core. While an
XDP program is attached or pending, __netdev_update_features() now clears
NETIF_F_GRO_HW. The XDP attach paths call a new helper,
dev_xdp_clear_rx_agg(), which refuses the attach if HW-GRO cannot be
turned off, and the warn-only dev_disable_gro_hw() is removed.

> The device also lost the bit from wanted_features for good, so HW-GRO
> never came back after detach - on mlx5 that took header-data split
> with it, and with it devmem and io_uring zero-copy Rx.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[Severity: Low]
Should this carry a Fixes: tag? Two things combine to cause the splat and
the permanent loss of NETIF_F_GRO_HW from wanted_features:

  - the HDS-forces-GRO_HW logic in mlx5e_fix_features()
  - the warn-and-continue behavior of dev_disable_gro_hw()

The mlx5 logic was added by:

  Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")

Without a tag, stable and backport tooling can't tell which kernels are
affected. If the series is meant only for net-next, this can be ignored.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index d88af07aea290..c0bb5eb9fdea0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10612,6 +10594,32 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
>  	dev->xdp_state[mode].prog = prog;
>  }
>  
> +/* Try to clear HW-GRO before the driver reconfigures for XDP.
> + * Driver may add features back in via ndo_fix_features(), due to feature
> + * dependencies. In that case we can't run XDP at all.
> + */
> +static int dev_xdp_clear_rx_agg(struct net_device *dev,
> +				struct netlink_ext_ack *extack)
> +{
> +	if (!(dev->features & NETIF_F_GRO_HW))
> +		return 0;
> +	if (!(dev->hw_features & NETIF_F_GRO_HW)) {
> +		NL_SET_ERR_MSG(extack,
> +			       "unable to disable HW-GRO, fixed on");
> +		return -EOPNOTSUPP;
> +	}

[Severity: Medium]
Does this stop generic XDP from attaching to virtio_net devices where
GRO_HW is fixed on?

virtnet_probe() adds GRO_HW to dev->features whenever GUEST_TSO4/6 is
negotiated. It only adds it to hw_features when CTRL_GUEST_OFFLOADS is
negotiated, and that needs the optional ctrl vq:

drivers/net/virtio_net.c:virtnet_probe() {
    ...
	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
		dev->features |= NETIF_F_GRO_HW;
    ...
	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
		dev->hw_features |= NETIF_F_GRO_HW;
    ...
}

Before this patch, generic_xdp_install()->dev_disable_gro_hw() printed
the "failed to disable GRO_HW!" warning and then attached the program
anyway. Now dev_xdp_attach()->dev_xdp_clear_rx_agg() returns -EOPNOTSUPP
before dev_xdp_install() is reached.

virtnet_xdp_set() already refuses native XDP on these setups:

drivers/net/virtio_net.c:virtnet_xdp_set() {
    ...
		NL_SET_ERR_MSG_MOD(extack, "Can't set XDP while host is implementing GRO_HW/CSUM, disable GRO_HW/CSUM first");
		return -EOPNOTSUPP;
    ...
}

So xdpgeneric was the only option left, for example for loaders that fall
back from native to SKB mode.

The refusal matches the new rule. Even so, could the commit message say
that generic XDP attaches which used to succeed are now rejected? The
check is still there at the end of the series, where it also covers LRO.

[ ... ]

> @@ -10875,19 +10900,36 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>  			return -EOPNOTSUPP;
>  		}
>  
> +		if (new_prog) {
> +			dev->xdp_pending = 1;
> +			err = dev_xdp_clear_rx_agg(dev, extack);
> +			if (err)
> +				goto err_clear_pending;
> +		}
> +
>  		err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
>  		if (err)
> -			return err;
> +			goto err_clear_pending;
>  	}

[Severity: Medium]
Is it intended that the hardware gets reconfigured here before
dev_xdp_install() has validated the request?

dev_xdp_clear_rx_agg() calls netdev_update_features(), which ends up in
ndo_set_features(). These checks in dev_xdp_install() only run after
that:

  - native and generic XDP active at the same time
  - an offloaded program without HW_MODE
  - a device-bound program on the wrong device or in SKB mode
  - a BPF_XDP_DEVMAP or BPF_XDP_CPUMAP attach type
  - tcp-data-split enabled with a non-frags program
  - a bound memory provider

The core used to reject such requests without touching the device. Now
it turns HW-GRO off first, the request fails, and err_clear_pending calls
netdev_update_features() again to turn HW-GRO back on.

On bnxt, a GRO_HW change toggles BNXT_FLAG_TPA, so
bnxt_set_features() calls bnxt_reinit_features():

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_reinit_features() {
	bnxt_close_nic(bp, irq_re_init, link_re_init);
	bp->flags = flags;
	if (update_tpa)
		bnxt_set_ring_params(bp);
	return bnxt_open_nic(bp, irq_re_init, link_re_init);
}

One rejected attach therefore costs two full close/open cycles of the
NIC, memory provider queues included.

If either bnxt_open_nic() call fails, __netdev_update_features() only
logs "set_features() failed". Could that leave the device with its rings
freed while it is still IFF_UP?

netif_xdp_propagate() already runs its hds and memory provider checks
before it calls dev_xdp_clear_rx_agg(). Could dev_xdp_attach() also run
the dev_xdp_install() pre-checks before clearing rx aggregation? The
ordering is the same at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118232315.3593731-1-kuba%40kernel.org
