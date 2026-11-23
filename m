Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795397629;
	b=XVPxtncXRWjdfjrQpzKLKG4kTTsXpS3bNbmHT66Py6HwYsQJOXoBKNG/3Xuq2Kc5WEZQ
	 ZFXNh9uNc+FNFceehcfk/6aJH0a/65BOdkas8keqZVbPGoe2j/ExtfYl4OeL3K88GbXKv
	 7o65rupeNmfJydpePGa3iPKLFUQP99GaXdVEN/COdkZ1Vq264m7q58e6yiIBJ2CH9cY1d
	 d72KyZoJf1boq7j2u6oXdY1eo+aXOgvGbZiyXsB8MP2hJH4huWLzAAEUJwh14JdjT8QEJ
	 fPrlSqu50QoY0H+lTk3coLdCH5rILE0WcC4PLGNooQ9crgxj5nCO5H6/t/EGoSIA05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795397629;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/X/XpNu+XU1r4t66dy+UWenVHX0JRM4YPorfQRX/rS8=;
	b=iALnoNwIAkXkMaeDEzK0lRAsIXRunobse4X0tf6j10kLOnjnJWnH+k4t3XZUZo95hTDl
	 R/1GCWUKLzunRycCeidN6xZ3YI2+5VAH4XSDX2xJTSN6dVaPcNUlNjw8ZCi1Ag8EuDpWd
	 RVa+EXPGSlAc6NUzsa18V/IHATCfQ3lYJaVpDnyJMEoDwhGWvjwzAqC8IgO9twqSj1d3e
	 zC/D+cgnF6OJt4qOaNNtCmmp75vVx6U0VlQ7mSXeAxAGFj82lU2Km7426Cr0HHIG5mXyE
	 Obdlz7EQANGeh0fkyuMjrd5doyc5NFoHEXQTfaW54Np9m7me+0QlntWZE4FAH3h3YeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPHfPjvB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301D0606A31A;
	Mon, 23 Nov 2026 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPHfPjvB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8961F000CA;
	Mon, 23 Nov 2026 01:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795397628;
	bh=/X/XpNu+XU1r4t66dy+UWenVHX0JRM4YPorfQRX/rS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cPHfPjvBzRfvqtr0mQTN/wEv7wC+FV9msUfZyPluXpl3IADfXmEot7WrmTJj0R68d
	 c5iu0R/hx7w1cdc0W0ThVQZR5rMgDfIR6YOZOX0CudXKz1i7IwU4FlMQvdSijM1SH2
	 +WUKtranC5D+TT2HXlmL/WEUKAH+mtbSPwyy7A1FYxHk+ws6bUj0mg7taBVEavu4dO
	 u3rcWL1kQN/u/5i0LuDD1dF70UEJ/e5b/sJ0VB5a8Hi2jC001CzqpOCKcp2PGj5mse
	 FPNnEAWd25ldUd7t6K9T3bXTmvuGv5cvmZoWANmRZb3ccAm1NhqW43/0MPKNGSMl4o
	 mI2b+NzjcnXKg==
Subject: Re: [PATCH net-next v2 4/9] net: state the "XDP excludes HW-GRO" rule
 in the core
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, manishc@marvell.com, joshwash@google.com,
 hramamurthy@google.com, tariqt@nvidia.com, saeedm@nvidia.com,
 daniel@iogearbox.net, hawk@kernel.org, sdf@fomichev.me, willemb@google.com,
 przemyslaw.kitszel@intel.com, bpf@vger.kernel.org, nktgrg@google.com
Date: Mon, 23 Nov 2026 01:33:47 +0000
Message-ID: <179539762712.3135.2625842431945223640@kernel.org>
In-Reply-To: <20261122010112.1471146-5-kuba@kernel.org>
References: <20261122010112.1471146-5-kuba@kernel.org>
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

- [Medium] In dev_xdp_attach() (net/core/dev.c), dev->xdp_pending is set
  and dev_xdp_clear_rx_agg() runs before dev_xdp_install() validates the…
- [Medium] dev_xdp_clear_rx_agg() turns the old warn-and-proceed
  behaviour into a hard failure for every XDP attach mode, generic (SKB)…
- [Low] The commit message describes concrete user-visible bugs that this
  patch fixes, but there is no Fixes: tag.

--

net: state the "XDP excludes HW-GRO" rule in the core

This commit moves the rule that HW-GRO must be off while XDP is attached
into __netdev_update_features(). A new xdp_pending bit makes
dev_xdp_prog_count() report a program while one is being installed. The
attach paths now try to clear HW-GRO first and refuse the attach if they
can't, the detach paths refresh features, and dev_disable_gro_hw() is
removed.

> The device also lost the bit from wanted_features for good, so HW-GRO
> never came back after detach - on mlx5 that took header-data split
> with it, and with it devmem and io_uring zero-copy Rx.

[Severity: Low]
This isn't a bug, but the commit message describes user-visible problems
that this patch fixes, and there is no Fixes: tag. The problems are:

  - the WARN from generic_xdp_install()->dev_disable_gro_hw() on mlx5 with
    tcp-data-split
  - HW-GRO staying off after a generic XDP detach, because
    dev_disable_gro_hw() cleared it from wanted_features
  - idpf running RSC under XDP

idpf_set_netdev_features() advertises GRO_HW with no XDP interlock:

	if (idpf_is_cap_ena_all(adapter, IDPF_RSC_CAPS, IDPF_CAP_RSC))
		other_offloads |= NETIF_F_GRO_HW;

Should this have a Fixes: tag, or a note saying why it isn't meant for
stable?

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4ca8a9f5a7a5c..5d38cdb6c3260 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c

[ ... ]

> @@ -10617,6 +10599,32 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
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
Is it intended that generic XDP attach now fails on devices where GRO_HW
is fixed on? The old code warned and attached anyway. This check refuses
the attach in every mode, generic (SKB) mode included.

virtio_net is one such device. With VIRTIO_NET_F_GUEST_TSO4/6 negotiated
and VIRTIO_NET_F_CTRL_GUEST_OFFLOADS missing, virtnet_probe() puts GRO_HW
in features but never in hw_features:

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

virtnet_xdp_set() already refuses native XDP in this configuration, so
xdpgeneric was the fallback. Before this patch,
generic_xdp_install()->dev_disable_gro_hw() warned and the program was
attached. Now dev_xdp_attach()->dev_xdp_clear_rx_agg() returns
-EOPNOTSUPP, so xdpgeneric attach fails on these guests.

The commit message covers the old splat and the "attached anyway" outcome.
It doesn't say that such attaches are now refused, and it doesn't mention
the fixed-on case. The later mlx5 patch in the series covers the -EBUSY
refusal for tcp-data-split, but nothing in the series covers virtio_net or
other fixed-on devices.

Could the commit message describe this behavior change?

> +
> +	netdev_update_features(dev);

[ ... ]

> @@ -10880,19 +10905,36 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
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

[ ... ]

> +
> +err_clear_pending:
> +	dev->xdp_pending = 0;
> +	netdev_update_features(dev);
> +	return err;
>  }

[Severity: Medium]
Should dev_xdp_clear_rx_agg() run only after dev_xdp_install() has
validated the program?

dev_xdp_clear_rx_agg() calls netdev_update_features(), which drops
NETIF_F_GRO_HW and reconfigures the device through ndo_set_features().
dev_xdp_install() can still reject the attach after that, for reasons
unrelated to HW-GRO:

net/core/dev.c:dev_xdp_install() {
    ...
		if (prog->expected_attach_type == BPF_XDP_DEVMAP) {
			NL_SET_ERR_MSG(extack, "BPF_XDP_DEVMAP programs can not be attached to a device");
			return -EINVAL;
		}
    ...
		if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
		    !prog->aux->xdp_has_frags) {
    ...
		if (dev_get_min_mp_channel_count(dev)) {
    ...
}

The same applies to offloaded progs without HW_MODE, CPUMAP-typed progs,
and dev-bound progs on the wrong device or in SKB mode.

When that happens, err_clear_pending calls netdev_update_features() again
to turn HW-GRO back on. Nothing checks whether that call succeeded.

On bnxt, every TPA on/off transition in bnxt_set_features() sets re_init:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_set_features() {
    ...
	if (changes & BNXT_FLAG_TPA) {
		update_tpa = true;
		if ((bp->flags & BNXT_FLAG_TPA) == 0 ||
		    (flags & BNXT_FLAG_TPA) == 0 || ...)
			re_init = true;
	}
    ...
}

So a misconfigured attach on bnxt would close and reopen the NIC twice
before being refused. Examples are a DEVMAP-typed program, or any XDP
program on a port with tcp-data-split or a memory provider bound.

Each such attempt also sends two NETDEV_FEAT_CHANGE notifications. If the
restoring ndo_set_features() fails, HW-GRO stays off with no XDP program
attached.

The extack also changes. On mlx5 with tcp-data-split enabled,
mlx5e_fix_features() adds GRO_HW back:

drivers/net/ethernet/mellanox/mlx5/core/en_main.c:mlx5e_fix_features() {
    ...
	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    !(features & NETIF_F_GRO_HW)) {
		...
		features |= NETIF_F_GRO_HW;
	}
    ...
}

A single-buffer program then gets "unable to disable HW-GRO, required by
another feature" instead of the more specific "unable to install XDP to
device using tcp-data-split".

netif_xdp_propagate() runs its hds_config and memory provider checks
before it sets xdp_pending and calls dev_xdp_clear_rx_agg(). Could
dev_xdp_attach() use the same order, so the checks in dev_xdp_install()
run before any features change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261122010112.1471146-1-kuba%40kernel.org
