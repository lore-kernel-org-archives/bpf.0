Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F23D9DB3
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865796; cv=none; b=V00oFGBI7O+vBis+BzxJZ02EyHtZtHIwIiCIVMcPnxyIuIEprL46DO6H7a3A9gXAe9xxtgCjIQslQpeZmac19FA1fZ+VIDlPCpEl1uyMchOH72Cj0ybOx83dQchGmATJwYNmG//v4Sa80WZ3gW9q8GF+R+NVElMs/hhhoWWh0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865796; c=relaxed/simple;
	bh=KEI/qfeKzpigetnsdVeCXzMCSW33pCqz/9zeW7O0AGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZFDYLblYDJSSy3BZR0AObZDhR6l1jHPGO/O7WwH0nSFGkBL+u4+Tx+wvSNzP8dc/agzk6MGWpSJQ/3KaLuivvCdI8JIEaqbK8zymTr815wq//o/BK2cKlapYT4g/eZ9NkiluD50iuXiaOM2Jnn38FX7bOhpX0APoIzmvedGV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqfB9Re3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqfB9Re3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B315BC2BCFA;
	Fri, 15 May 2026 17:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778865795;
	bh=KEI/qfeKzpigetnsdVeCXzMCSW33pCqz/9zeW7O0AGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rqfB9Re3TJIff9pFai7fX2ucuajMf87Qs7+D7BJxLyEX+IS1Yf98avQCSsM6/GbJq
	 U1ntWbHtqcqHUR49EQxWDRC4TDLYNOKsJ60ds5HYmL8c6qxvXt9xjQgOzwGG4+/NNG
	 RK2tJFPg/MjawJ9E2kcS58vBTSDS9CtLIe2TjIBD1sq/eGwOXzmyVRd8HxVMV8Nbrl
	 It3iDhLV9v1mEhxcBEyv3FS69fiR3xhz8WozPazg3LLXcKkaDEW4zPaS8GujKMZ5t3
	 8efKG8ZaL5rFAQCTF22nkgmCuSBykLwJdoycroJ6Ha3wMUxCMqbTulJoekMbetivf4
	 4ZOCJY4VHLiMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260514-tcp-dm-netkit-v5-3-408c59b91e66@meta.com>
References: <20260514-tcp-dm-netkit-v5-3-408c59b91e66@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 17:23:14 +0000
Message-Id: <20260515172315.B315BC2BCFA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Kernel panic (DoS) by bypassing unreadable SKB validation for =
netkit devices.
- [High] Use-After-Free and ABA pointer reuse vulnerability due to dangling=
 `vdev` and `dev` in TX bindings.
- [High] Use-After-Free in `netdev_nl_bind_tx_doit` due to unprotected acce=
ss to `phys_dev`.
- [Medium] Lockdep warning (recursive locking) when locking both virtual an=
d physical devices.
--

commit fc62474407bd468f37ed050ed11229d597ff605b
Author: Bobby Eshleman <bobbyeshleman@meta.com>

net: devmem: support TX over NETMEM_TX_NO_DMA devices

When a netkit virtual device leases queues from a physical NIC, devmem
TX bindings created on the netkit device must still result in the dmabuf
being mapped for dma by the physical device. This patch accomplishes
this by teaching the bind handler to search for the underlying
DMA-capable device.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 2da2688fe490b..bbc93b181ef9a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3993,7 +3993,8 @@ static struct sk_buff *validate_xmit_unreadable_skb=
(struct sk_buff *skb,
>  	struct skb_shared_info *shinfo;
>  	struct net_iov *niov;
> =20
> -	if (likely(skb_frags_readable(skb)))
> +	if (likely(skb_frags_readable(skb) ||
> +		   dev->netmem_tx =3D=3D NETMEM_TX_NO_DMA))
>  		goto out;

If the netkit device is configured to pass packets to its peer (such as via
NETKIT_PASS or NETKIT_NEXT), could this allow an unreadable devmem SKB to be
injected into the host's local receive stack via __netif_rx()?

If software paths expecting valid struct pages attempt to read the payload,
such as local sockets calling kmap_local_page(), will this result in a cras=
h?

[ ... ]

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 468344739db29..893643909f6a4 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -212,6 +212,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  	}
> =20
>  	binding->dev =3D dev;
> +	binding->vdev =3D vdev;
>  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);

Does this code need to take a reference count on dev and vdev?

Since TX bindings remain active until the user closes the netlink socket,
if the physical or virtual device is unregistered and freed while the
socket is open, these pointers might become dangling.

If a new net_device is subsequently allocated at the exact same memory
address, could the pointer comparison dst_dev !=3D READ_ONCE(binding->vdev)
in net_devmem_get_binding() falsely succeed?

[ ... ]

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 4d2c49371cdb4..b4d48f3672a5b 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c

[ ... ]

> +static struct net_device *
> +netdev_find_netmem_tx_dev(struct net_device *dev)
> +{
> +	struct netdev_rx_queue *lease_rxq;
> +	struct net_device *phys_dev;
> +	int i;
> +
> +	if (dev->netmem_tx =3D=3D NETMEM_TX_DMA)
> +		return dev;
> +
> +	if (dev->netmem_tx !=3D NETMEM_TX_NO_DMA)
> +		return NULL;
> +
> +	for (i =3D 0; i < dev->real_num_rx_queues; i++) {
> +		lease_rxq =3D READ_ONCE(__netif_get_rx_queue(dev, i)->lease);
> +		if (!lease_rxq)
> +			continue;
> +
> +		phys_dev =3D lease_rxq->dev;
> +		if (netif_device_present(phys_dev) &&
> +		    phys_dev->netmem_tx =3D=3D NETMEM_TX_DMA)
> +			return phys_dev;

Is it safe to return phys_dev here without holding an RCU read lock or taki=
ng
a reference on the device?

Because the caller netdev_nl_bind_tx_doit() operates without the RTNL lock,
could the physical device be unregistered and freed concurrently between th=
is
pointer read and the subsequent lock acquisition?

> +	}
> +
> +	return NULL;
> +}
> +
>  int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  {

[ ... ]

> +	if (bind_dev !=3D netdev)
> +		netdev_lock(bind_dev);

Since both the virtual device and the physical device are likely initialized
as Ethernet devices, they will share the same lock class.

Will acquiring netdev_lock(bind_dev) while already holding the lock for
netdev trigger a lockdep warning for possible recursive locking?

> +
> +	dma_dev =3D netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-tcp-dm-net=
kit-v5-0-408c59b91e66@meta.com?part=3D3
