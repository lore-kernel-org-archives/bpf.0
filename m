Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020508;
	b=e2zhEMI9lqOlrZS6/viry2vwJvovOjse8d6TzbaaGWXMm0s4CfKtuxORIja8W/dLRLN6
	 YeulXn0SfgXhxOiOdcJUOS3e/gukJDsMsD+Izk2b2mlo8Wy0HBMXpp4SJQl6EEZNLNuhF
	 0fvxkL/2FbEq3PDBzEbWGPL0AdWkfPTYpjT9emBZvzvNqVxjapYDNsFDWKkoFY0uHjSu8
	 9BleN85aKseOXpo7KB5vZLzHSmB5R7KYSCIsNvVZayV6iPnsCwFLbtzI3y0frfHxtd/PT
	 07cGHK53Zpjn4REcqz0gy06C7V3TjgFjJlemwMGl1zLJS/V35gYHxkpx/iTXDYgT8KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pYuJyNf6uglr1k9kUC9MC9isl/PA99Yw95AuSGe1Ckw=;
	b=ZZBdyK42eVO2CmoAkHNfGN+UES/4V44GxQ7C0Dw6dFMFFtFeF3umemnh1LeoTPItyDsT
	 2tG8EFPDtEjHg+JTB2x0mm+DlcI5l4j4IHbTANbgcqg7H9VunFxpt6BL+0UlWxJEwxkzD
	 CP2ZpMo9RRe2FgDYaz8Xe6tUpuXolqwFiKTtQHHXCNKV8+R1EKu78bk2MD8HBcVpiCSsS
	 jDXe8t4jK6xE9GKCbaKQAxNflGSAzy4HE8h5USnjf5WpbOlKAOYWSQNv6BjavqrhZcPrb
	 DRX9ea8jWRzi31qvCz7j3lv510kubS5SZyB+pxcrDv1DTqOEkTzx2ui5mDXexRUa5pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BG2x6erD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACB606A32F
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BG2x6erD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DF71F000C8;
	Wed, 18 Nov 2026 16:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020508;
	bh=pYuJyNf6uglr1k9kUC9MC9isl/PA99Yw95AuSGe1Ckw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BG2x6erDzJyzSC3MjFfe9Gv1M36G9VfLVMnk5IuUJJcwPRr4IN1MKuvkLTM6SXKrz
	 iGJyrIFWSV+jIbty/Cpd+e7sW7q2ytFhoe/ug9CM6wL0qVReTCRRCbf6Bx9vPzcUdU
	 XnnYz0jPzECGY4zaRLaN9hu6klFdVYGBNeMjI+8eZ40YYsnsuXa4OMB9ooCg6+JK1V
	 GDUB/u69Ao6UDEJx0JmZm+hj1syNEB0B1e56bScNBJsFL2tjOpGOLQwlwLW9UO2H0K
	 8b3N3KMM7aa30J7kXW5dAo3yFG3hH2WM3Kzifbze27EX7k0UnIq1Q66Nwcy3JnjVFQ
	 Uq3ASQmAi63XA==
Message-ID: <sashiko-outbox-221553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/7] net: Admit native XDP on provider queues
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20261117164700.2157816-4-bjorn@kernel.org>
References: <20261117164700.2157816-1-bjorn@kernel.org>
 <20261117164700.2157816-4-bjorn@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:48:27 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: missing propagated XDP check in netif_xdp_mp_ok()
--

commit d33c78f94dc0fb7af8ecef5adb0fc4ff90275bda
Author: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

net: Admit native XDP on provider queues

This commit allows native XDP programs to run alongside unreadable memory
providers on drivers that set netdev_queue_mgmt_ops.xdp_unreadable.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index a230ecce9327d..f0c3d56d5b832 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10575,6 +10575,27 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
>  	return count;
>  }
> =20
> +/* Only native programs run next to unreadable memory providers. Drivers=
 must
> + * mark unreadable fragments and reject XDP_TX while they remain attache=
d.
> + * Tcp-data-split, which these providers need, also needs frags support.
> + */
> +static bool netif_xdp_mp_mode_ok(const struct net_device *dev,
> +				 enum bpf_xdp_mode mode)
> +{
> +	return mode =3D=3D XDP_MODE_DRV && dev->queue_mgmt_ops->xdp_unreadable;
> +}
> +
> +/* Can the XDP programs of @dev run next to a new memory provider? */
> +bool netif_xdp_mp_ok(struct net_device *dev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < __MAX_XDP_MODE; i++)
> +		if (dev_xdp_prog(dev, i) && !netif_xdp_mp_mode_ok(dev, i))
> +			return false;
> +	return true;
> +}
> +
>  int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
>  {
>  	if (!dev->netdev_ops->ndo_bpf)
> @@ -10588,7 +10609,9 @@ int netif_xdp_propagate(struct net_device *dev, s=
truct netdev_bpf *bpf)
>  		return -EBUSY;
>  	}
> =20
> -	if (dev_get_min_mp_channel_count(dev)) {
> +	if (dev_get_min_mp_channel_count(dev) &&
> +	    (bpf->command !=3D XDP_SETUP_PROG ||
> +	     !netif_xdp_mp_mode_ok(dev, XDP_MODE_DRV))) {
>  		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using m=
emory provider");
>  		return -EBUSY;
>  	}

[Severity: Medium]
Does netif_xdp_mp_ok() miss native XDP programs propagated from an upper
device such as bonding or hv_netvsc?

When an upper device propagates XDP via netif_xdp_propagate(), the
program is stored in the upper device's xdp_state[] while the lower
device's dev->xdp_state[] remains empty.  If native XDP is attached to
the upper device first and a memory provider is then opened on the lower
device via __netif_mp_open_rxq(), netif_xdp_mp_ok() sees no program on
the lower device and returns true without checking
dev->queue_mgmt_ops->xdp_unreadable.

On a lower driver with xdp_unreadable set to false, this lets native XDP
run on queues with unreadable net_iov fragments (which can cause a NULL
pointer dereference when XDP_TX or XDP_DROP paths call skb_frag_page()).
In addition, while the memory provider remains bound,
netif_xdp_propagate() rejects even bpf->prog =3D=3D NULL with -EBUSY,
preventing the upper device from detaching the propagated XDP program and
leaking the bpf_prog reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117164700.2157=
816-1-bjorn@kernel.org?part=3D3
