Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E12349B0D
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502611; cv=none; b=AdvGcsHShGfhH6wyrjUYfAyeDVhMMe9b+tavVA7RCPJ9NL2eN7oLJyXeEzmIH4tMsT5+Ujoc9Mw7TXuUfFzm/4zfEwz/lGupl0JrZ3tH5euzpBnuRJFL+SfuQyfl8nROmBqmL2j5nmuM5ANMxV/90uyhuNUt2szgsyPUYUijuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502611; c=relaxed/simple;
	bh=N1kZikJ/vQqpafRqJdxFD91wKyFhvN8xNeW6LopZmh4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mXZWboHyNAWFGNFJfm61Sq5e5Mt5FmLmWUFg6ATcUhKEyeHANvdfGlFH2tXSAFXQM5J6Mnro22n+ks09purxbLGDOKalyiJRF2f8cE3mrur9phNC2KFGy99m7kgUzOzO0ohpHjDMnrlXW6cjHnMGWwLQ2yjCjoZVjtMYe4QrZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPZ0D37I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPZ0D37I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1917C19425;
	Wed, 29 Apr 2026 22:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777502610;
	bh=N1kZikJ/vQqpafRqJdxFD91wKyFhvN8xNeW6LopZmh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jPZ0D37IUk9uOl+rEa9oqyx1koMrDuW/50ZVOwPCwVJ6m+gXTRZxMi2ExtxhWYT2f
	 S63mNFbWUp4R1XXVT1onXIXnw1/U1PthK7G24NTf4S/2iV7MLUpGwz8wbJENcLAej2
	 rXXzkzuOtL+J1H0TZKv0Ag4ZtgsD30AVcAXEziZblCxYNHnRQyRvi0+ExZVI5+lu6l
	 tsd6/6zoMDX8of8emM7jESKLuaGUrGpOD6jbzdRUpw1koaaTSkEBPaRAr0hXXHRO57
	 F+9kd9VDhYuGbQ35lYRQSZSyZBZj1wqXJ7hgPHNFvBoF7vUVKRQWeMcqc512ORv4OR
	 vlAuMC5vFieyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 07/11] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Reply-To: sashiko@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-tcp-dm-netkit-v1-7-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-7-719280eba4d2@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 22:43:29 +0000
Message-Id: <20260429224330.C1917C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Calling `netdev_queue_get_dma_dev()` on an unlocked physical devic=
e triggers a lockdep assertion.
- [High] Unrecognized unreadable SKBs bypass device capability checks in `v=
alidate_xmit_unreadable_skb()`.
- [High] Dangling `binding->dev` and `binding->vdev` pointers in TX binding=
s cause ABA vulnerabilities and bypass DMA isolation.
- [Medium] Missing rollback on `genlmsg_reply()` failure creates zombie bin=
dings in the netlink TX bind path.
--

commit ad5b7f6dddf55058541369471398808c30d9cb9e
Author: Bobby Eshleman <bobbyeshleman@meta.com>
Subject: net: devmem: support TX over NETMEM_TX_NO_DMA devices

This patch adds support for devmem TX over netkit virtual devices by finding
the underlying DMA-capable physical device. It updates
validate_xmit_unreadable_skb() and netdev_nl_bind_tx_doit() to handle the
dual-device validation and binding setup.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 06c195906231..f6575cf48287 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3990,22 +3990,32 @@ static struct sk_buff *sk_validate_xmit_skb(struc=
t sk_buff *skb,
>  static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  						    struct net_device *dev)
>  {
> +	struct net_devmem_dmabuf_binding *binding;
>  	struct skb_shared_info *shinfo;
>  	struct net_iov *niov;
> =20
>  	if (likely(skb_frags_readable(skb)))
>  		goto out;
> =20
> -	if (!dev->netmem_tx)
> -		goto out_free;
> -
>  	shinfo =3D skb_shinfo(skb);
> +	if (shinfo->nr_frags =3D=3D 0)
> +		goto out;
> +
> +	niov =3D netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> +	if (!net_is_devmem_iov(niov))
> +		goto out;

Will this allow unreadable fragments that are not devmem iovs (such as those
potentially introduced by io_uring) to bypass device capability checks?

Previously, if dev->netmem_tx was NETMEM_TX_NONE, any unreadable fragment
would trigger goto out_free. Now, if it's unreadable but not a devmem iov,
it jumps to out and returns the SKB, successfully bypassing the
dev->netmem_tx check below and potentially failing open on legacy devices.

> -	if (shinfo->nr_frags > 0) {
> -		niov =3D netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> -		if (net_is_devmem_iov(niov) &&
> -		    READ_ONCE(net_devmem_iov_binding(niov)->dev) !=3D dev)
> +	binding =3D net_devmem_iov_binding(niov);
> +
> +	switch (dev->netmem_tx) {
> +	case NETMEM_TX_DMA:
> +		if (READ_ONCE(binding->dev) !=3D dev)
>  			goto out_free;
> +		break;
> +	case NETMEM_TX_NO_DMA:
> +		break;
> +	default: /* NETMEM_TX_NONE */
> +		goto out_free;
>  	}
> =20
>  out:
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index cde4c89bc146..644c286b778f 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
[ ... ]
> @@ -212,6 +212,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  	}
> =20
>  	binding->dev =3D dev;
> +	binding->vdev =3D vdev;

Are dev_hold() references needed here for the TX bindings?

Without a reference count, and since TX bindings do not have an RX queue
memory provider to provide an unregister hook, these pointers could become
dangling if the devices are destroyed.

If a new net_device is later allocated at the same address, couldn't this
lead to an ABA problem in net_devmem_get_binding() and allow users to
transmit packets mapped for the old device's DMA domain?

>  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
> =20
>  	err =3D percpu_ref_init(&binding->ref,
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b8f6076d8007..bc6057aee98e 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
[ ... ]
> @@ -1164,16 +1197,26 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, s=
truct genl_info *info)
>  		goto err_unlock_netdev;
>  	}
> =20
> -	if (!netdev->netmem_tx) {
> +	if (netdev->netmem_tx =3D=3D NETMEM_TX_NONE) {
>  		err =3D -EOPNOTSUPP;
>  		NL_SET_ERR_MSG(info->extack,
>  			       "Driver does not support netmem TX");
>  		goto err_unlock_netdev;
>  	}
> =20
> -	dma_dev =3D netdev_queue_get_dma_dev(netdev, 0, NETDEV_QUEUE_TYPE_TX);
> -	binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
> -					 dmabuf_fd, priv, info->extack);
> +	bind_dev =3D netdev_find_netmem_tx_dev(netdev);
> +	if (!bind_dev) {
> +		err =3D -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "No DMA-capable device found for netmem TX");
> +		goto err_unlock_netdev;
> +	}
> +
> +	dma_dev =3D netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);

Does this cause a lockdep assertion if bind_dev !=3D netdev?

In this function, netdev is locked via netdev_get_by_index_lock(), but
bind_dev is found via netdev_find_netmem_tx_dev(). When bind_dev is not
the same as netdev (e.g., netkit), it appears bind_dev is unlocked.

Calling netdev_queue_get_dma_dev() on bind_dev will trigger the
netdev_ops_assert_locked(dev) assertion inside that function and cause a
splat.

> +	binding =3D net_devmem_bind_dmabuf(bind_dev,
> +					 bind_dev !=3D netdev ? netdev : NULL,
> +					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
> +					 priv, info->extack);
>  	if (IS_ERR(binding)) {
>  		err =3D PTR_ERR(binding);
>  		goto err_unlock_netdev;

Is there a missing rollback if genlmsg_reply() fails at the end of this
function?

After the binding is successfully created here and attached to the socket,
the locks are released and the function returns the result of
genlmsg_reply().

If sending the netlink response fails (e.g., due to memory exhaustion), it
returns an error code, but unlike the RX path, there is no err_unbind
rollback. Does this leave a zombie binding active in the kernel that
userspace has no dmabuf_id for?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-tcp-dm-net=
kit-v1-0-719280eba4d2@meta.com?part=3D7
