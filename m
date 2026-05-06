Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528A4C6C
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778027346; cv=none; b=OAiZjftmSb70Dw3UUrjTq/YreVCpo4NnW3GAa2JdSQPiSJk6w/3vcDQfRSKu+85MUEjA0w3lvhhIEOq+ZPcRMlkR6ZoRIEbJj+0qzLY41ZEjGQ3Bax0ignDYUDyMjHN/6HpKMwDMo1smTqC8FaQGwvofCFSIGIyx5Wa38s0pHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778027346; c=relaxed/simple;
	bh=eHsVhJFvGTUJyB7UNfzlJXv4rgEDMjIcPGTsq+XGdwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j12Y0cHaa4eqsZPUsQ4hZ2YwEhbPaZ//FeA5xbm4kakZuz4gWRQ7vP6inopaxjdWED5OvMiEAyCKCRUVv+jdRI7V0FIVGXU0FXJ+8mMqyeGKTsQjaW9bMn5yO2YscEF3EAEzhj9PLNYS6Ey6InTzgXW3qn1dC6x2BARgH1hj074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRvdNzlo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRvdNzlo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF681C2BCB4;
	Wed,  6 May 2026 00:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778027346;
	bh=eHsVhJFvGTUJyB7UNfzlJXv4rgEDMjIcPGTsq+XGdwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kRvdNzlorEEVUzNKkbtBU+0bvRJAnX4u+1G+7AFYXMuBsGYS+cQYFhY6ZIT21Mpxi
	 KBiFRlMejomSabxB9Tb7C2h1YTQnDfIrrsHUX7C0LedJPymQEdbfdUSDNxNxrOrCU1
	 mfRRgkCGm5sm1WS39xlWg/bdDoRi3e+BJ/mHk3VHqwRY28DXEREX1YEdv6zcp/eifO
	 TtUxOx7Bh0b8uo6Xd6xLMLKH7Cg3x7x4dfdSUZMP/+ra1ax/BcCMEoSryFGJuTedQE
	 6i7aSe1b6qeUkbBK5z7Un6sqWeNkgqt2LyvG6DWOYO+wNRWTey9WVwJuSCB3XhZKkJ
	 j5/gOlO7nPeGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Reply-To: sashiko@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-tcp-dm-netkit-v2-2-56d52ac72fd4@meta.com>
References: <20260504-tcp-dm-netkit-v2-2-56d52ac72fd4@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 00:29:05 +0000
Message-Id: <20260506002905.DF681C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Double lock lockdep splat and potential deadlock in netdev_nl_bind=
_tx_doit()
- [High] Use-After-Free of dma_dev pointer in netdev_nl_bind_tx_doit()
- [High] ABA vulnerability and pointer aliasing due to untracked vdev lifec=
ycle
--

commit fea3266a76d31b8278bf86dac679860b442a5bea
Author: Bobby Eshleman <bobbyeshleman@meta.com>

net: devmem: support TX over NETMEM_TX_NO_DMA devices

This patch enables devmem TX bindings on netkit virtual devices by routing
the binding to the underlying DMA-capable physical device. It extends the
skb validation and binding lookup to support the netkit architecture.

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
>  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);

Is it possible for this virtual device to be unregistered and freed while
the binding is still active? Since there is no reference count acquired on
vdev, and no NETDEV_UNREGISTER notifier seems to clean up the binding for
the virtual device, vdev could become a dangling pointer.

[ ... ]
> @@ -397,7 +398,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_bind=
ing(struct sock *sk,
>  	 */
>  	dst_dev =3D dst_dev_rcu(dst);
>  	if (unlikely(!dst_dev) ||
> -	    unlikely(dst_dev !=3D READ_ONCE(binding->dev))) {
> +	    unlikely(dst_dev !=3D READ_ONCE(binding->dev) &&
> +		     dst_dev !=3D READ_ONCE(binding->vdev))) {

If vdev was freed as mentioned above, and a new, unrelated network device
is allocated at the exact same memory address, could this pointer comparison
incorrectly pass due to the ABA problem?

[ ... ]
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index b8f6076d8007..0e296c3bb677 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
[ ... ]
> @@ -1164,16 +1197,30 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, s=
truct genl_info *info)
[ ... ]
> +	bind_dev =3D netdev_find_netmem_tx_dev(netdev);
> +	if (!bind_dev) {
> +		err =3D -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "No DMA-capable device found for netmem TX");
> +		goto err_unlock_netdev;
> +	}
> +
> +	if (bind_dev !=3D netdev)
> +		netdev_lock(bind_dev);

Will acquiring netdev_lock() on bind_dev while already holding it on netdev
trigger a lockdep warning? Since both are struct net_device instances, their
locks belong to the exact same lockdep class. Without a mutex_lock_nested()
annotation, acquiring them sequentially might trigger a possible circular
locking dependency splat, and introduce a potential deadlock if locked in
reverse order elsewhere.

> +	dma_dev =3D netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);
> +	if (bind_dev !=3D netdev)
> +		netdev_unlock(bind_dev);
> +	binding =3D net_devmem_bind_dmabuf(bind_dev,
> +					 bind_dev !=3D netdev ? netdev : NULL,
> +					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
> +					 priv, info->extack);

Is it safe to use dma_dev after dropping the bind_dev lock? Since
netdev_queue_get_dma_dev() returns a raw device pointer without acquiring a
reference via get_device(), what prevents a concurrent hardware hot-unplug
or driver unbind from freeing the dma_dev between netdev_unlock() and the
subsequent use in net_devmem_bind_dmabuf()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-tcp-dm-net=
kit-v2-0-56d52ac72fd4@meta.com?part=3D2
