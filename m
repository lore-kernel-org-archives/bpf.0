Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05ED42A9D
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 04:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778645117; cv=none; b=rlzAFtCLchFwJtpK9RwrQw4B1eRKYg7Y7GtUOVzvCRP0lZJ663S9MWhLjgC3LMmQEV03ImyyAxFlex33WoJUYpJ+nWaV3KqN2CwUPYzxv9Jcmx0dwmHLqYMPBEXSoidhCtQyQUuBKp+BeEk8mIX5FjB7j2MTreaLGSC2cr0t88o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778645117; c=relaxed/simple;
	bh=un48sQJWWn4nydlgphR82QDF54XqWL3M1MsxUa+FS6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YOVDO8fk1xe+hjnAclamAgdJBrsKV1uCt5x70nG0uEPI9kWqozB1A6JUsCsedvVdXD8ZARUq9NJlcl2FnRIbcdBqkEtjiF8fjSsA0fJGsZRg5PI7m4FdMMArgXL+s+YE/SQxeeAF+GrRBEBOgnpUZe3WE3eMhZBCt43jwKMQL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THbcYMMw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THbcYMMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4914EC2BCC7;
	Wed, 13 May 2026 04:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778645116;
	bh=un48sQJWWn4nydlgphR82QDF54XqWL3M1MsxUa+FS6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=THbcYMMwAYA6IdmjGabf19MisLmVbI77Ji2DjGgxLn/4XLBrLXlVSxrhMedGDngiy
	 wLnxMNjYV+2ProWMzgj8fMRqGYjNnV0yd7dXEHdj0KAxl33qIAGn+5k0bRWnFugdaK
	 E14s9WXgxNms1PViODk36Hc5MTM8L4XNvXfCAv7GzgLivtbypHVOjKJJAqQb0ZI09W
	 Q8p6FG2b2m7AdrQGuAcFkWlXjmvL4GoYjKuyOgrqU14H1JhizgOgueaPwN0QI7utc6
	 hORlghC4Z+8n7uz91ne1U8W7baZU/WxzO9LGfMnFM+qJ4RmuIIG9ifUWxD9h/SsghJ
	 LtIBJriOgi8uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511-tcp-dm-netkit-v4-3-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-3-841b78b99d74@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 04:05:15 +0000
Message-Id: <20260513040516.4914EC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Dangling net_device pointers in TX bindings cause a Critical U=
se-After-Free during socket destruction.
- [High] Unrefcounted binding->vdev and binding->dev pointers create an ABA=
 vulnerability allowing DMA domain bypass.
- [Medium] Missing error rollback in netdev_nl_bind_tx_doit() leads to dmab=
uf binding leak.
--

commit 20d630c8bbbcb31ad867556dab2a588deb3faa88
Author: Bobby Eshleman <bobbyeshleman@meta.com>

    net: devmem: support TX over NETMEM_TX_NO_DMA devices
   =20
    When a netkit virtual device leases queues from a physical NIC, devmem
    TX bindings created on the netkit device must still result in the dmabuf
    being mapped for dma by the physical device. This patch accomplishes
    this by teaching the bind handler to search for the underlying
    DMA-capable device by looking it up via leased rx queues.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index cde4c89bc146a..1c67e7524246c 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -212,6 +212,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  	}
> =20
>  	binding->dev =3D dev;
> +	binding->vdev =3D vdev;
>  	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);

Since binding->dev and binding->vdev are stored without holding a reference
count, what happens if the underlying physical or virtual net_device is
unregistered and freed while the binding is still active?

For RX bindings, mp_dmabuf_devmem_uninstall() safely clears binding->dev
when the device unregisters. However, TX bindings have an empty bound_rxqs
list and never receive this callback.

If a user application keeps the netlink socket open after the device is
removed, and later closes it, could netdev_nl_sock_priv_destroy() access
the stale binding->dev pointer and cause a use-after-free?

[ ... ]

> @@ -397,7 +398,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_bind=
ing(struct sock *sk,
>  	 */
>  	dst_dev =3D dst_dev_rcu(dst);
>  	if (unlikely(!dst_dev) ||
> -	    unlikely(dst_dev !=3D READ_ONCE(binding->dev))) {
> +	    unlikely(dst_dev !=3D READ_ONCE(binding->dev) &&
> +		     dst_dev !=3D READ_ONCE(binding->vdev))) {

If the devices are unregistered and the slab allocator reuses the memory
address for a newly created, unrelated net_device, could this pointer
comparison falsely pass due to aliasing (the ABA problem)?

Could this trick the kernel into authorizing the new device to transmit
using a DMABUF mapped exclusively for the original device's IOMMU domain?

>  		err =3D -ENODEV;
>  		goto out_unlock;
>  	}

[ ... ]

> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 4d2c49371cdb4..b4d48f3672a5b 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c

[ ... ]

> @@ -1171,22 +1205,41 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, s=
truct genl_info *info)
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
> +	if (bind_dev !=3D netdev)
> +		netdev_lock(bind_dev);
> +
> +	dma_dev =3D netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);
> +
> +	binding =3D net_devmem_bind_dmabuf(bind_dev,
> +					 bind_dev !=3D netdev ? netdev : NULL,
> +					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
> +					 priv, info->extack);
>  	if (IS_ERR(binding)) {
>  		err =3D PTR_ERR(binding);
> -		goto err_unlock_netdev;
> +		goto err_unlock_bind_dev;
>  	}
> =20
>  	nla_put_u32(rsp, NETDEV_A_DMABUF_ID, binding->id);
>  	genlmsg_end(rsp, hdr);
> =20
> +	if (bind_dev !=3D netdev)
> +		netdev_unlock(bind_dev);
>  	netdev_unlock(netdev);
>  	mutex_unlock(&priv->lock);
> =20
>  	return genlmsg_reply(rsp, info);

If genlmsg_reply() fails here, is the dmabuf binding leaked?

The RX path (netdev_nl_bind_rx_doit) correctly rolls back by calling
net_devmem_unbind_dmabuf() on reply failure. However, it looks like the
TX path returns the error to the user but leaves the orphaned binding
attached to the netlink socket.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-tcp-dm-net=
kit-v4-0-841b78b99d74@meta.com?part=3D3
