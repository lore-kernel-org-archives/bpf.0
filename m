Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD9274B3B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497423; cv=none; b=iOzXR+MAWg5drbir1/CZJbcD52smSWYPc3GPx42PeuhpYvjf5a8DeHVGBcYsRiFzX9EvuPLkecrYKhh+lDcvuUc9AHen1yq/R3gTriA/KFLYi21N0FBbwPY1bxZwsfMNE90xIMLYmT1pPriI+dxwydciJdt4IOOv88b6pQctnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497423; c=relaxed/simple;
	bh=2P7K2Tx0jVIiqpciwVfFa3GN/7nUZTRuvZhCvH4/v/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lyX/uZ7V5JFDJY/uWvv7+FCkPYlRuTopaQUT4AO9PTkZG34Zt7+jVYBfIjzWSzx+7A4Ty76zAJO8Ch0rCm+lFPM6d8V2jlohB7v3K+uUBE3o3nJypWS6ywejoLg5gtzI9cKlWQBTvQW8yu1UHYhQRN0gZRLqqTGUzRbZlXFQt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfaP5KeL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfaP5KeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EC9C2BCB4;
	Wed, 29 Apr 2026 21:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497423;
	bh=2P7K2Tx0jVIiqpciwVfFa3GN/7nUZTRuvZhCvH4/v/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HfaP5KeLeVybABgVQjq9z8pCpzl+HFXpUGKcD5jMR9S/Dggn7QTw1rXPAePQIHd3r
	 LPWHqSImMie/VZ7Bc+Fm77W6N3oNxe9tQpl9HDgmgKU3uj3xbcYk+5NEGSdw1Za0MN
	 HWyPUGre/58Bnv5QdJCeB9JHihKn+kbyWiRqkxS0hzO42OdS5y9o+KQdJVIodk2Dts
	 BXqB3BFk5w/A5r8nscIXPuvGL7x3k1eI7H4xDSAZRFl9Xw0V5Vxgjo2aqKfNefuV/I
	 +ps3L/MQFGeTB9bnOg1RQn187TJ320TuFfA17biZwS/v0UT3UdIBuXM+voOnVoZG2W
	 OXJoUtdHQiKsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 5/7] net: bcmgenet: add XDP_REDIRECT and
 ndo_xdp_xmit support
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428205846.2625550-6-nb@tipi-net.de>
References: <20260428205846.2625550-6-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:17:02 +0000
Message-Id: <20260429211703.19EC9C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Prepended TSB in ndo_xdp_xmit completely overwrites struct xdp=
_frame.
- [Critical] Headroom validation in XDP_TX ignores metadata size, allowing =
out-of-bounds writes.
- [High] DMA mapping address in XDP_TX is incorrect when XDP metadata is pr=
esent.
- [High] Redirected XDP frames will be leaked indefinitely if the target in=
terface is idle.
- [Medium] bcmgenet_xdp_setup() clears NETDEV_XDP_ACT_NDO_XMIT when detachi=
ng an XDP program, hiding device capabilities.
- [Medium] Runt XDP frames (less than 60 bytes) will not be padded by the h=
ardware and will be transmitted as undersized packets.
--

commit 893d59a522f087d2ccf486f06a06bb9e815cf330
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support

Add XDP_REDIRECT support and implement ndo_xdp_xmit for receiving
redirected frames from other devices.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index 3c3b0c44ea8a..9dd258567824 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2451,11 +2452,25 @@ static unsigned int bcmgenet_run_xdp(struct bcmge=
net_rx_ring *ring,
>  						true);
>  			return XDP_DROP;
>  		}
> -		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, xdpf, false))) {
> +
> +		tx_ring =3D &priv->xdp_tx_ring;
> +		spin_lock(&tx_ring->lock);
> +		if (unlikely(!bcmgenet_xdp_xmit_frame(priv, tx_ring,
> +						      xdpf, false))) {

Does the DMA mapping calculation in bcmgenet_xdp_xmit_frame() for this local
XDP_TX path (dma_map =3D=3D false) account for XDP metadata?

If an XDP program populates metadata, the calculation sizeof(*xdpf) +
xdpf->headroom in the else block of bcmgenet_xdp_xmit_frame() will point
to the start of the metadata rather than where the TSB was actually prepend=
ed
at xdpf->data. The hardware expects the TSB at the DMA address, so it might
misinterpret the metadata as the status block.

> +			spin_unlock(&tx_ring->lock);
>  			xdp_return_frame_rx_napi(xdpf);
>  			return XDP_DROP;
>  		}
> +		bcmgenet_xdp_ring_doorbell(priv, tx_ring);
> +		spin_unlock(&tx_ring->lock);
>  		return XDP_TX;

Does the headroom check earlier in this XDP_TX block adequately validate
xdp->data_meta?

Before backing up the pointers:
	if (xdp->data - xdp->data_hard_start <
	    sizeof(struct status_64) + sizeof(struct xdp_frame)) {

This check validates the space before xdp->data, but the code then subtracts
64 bytes from xdp->data_meta:
	xdp->data -=3D sizeof(struct status_64);
	xdp->data_meta -=3D sizeof(struct status_64);

If an XDP program populates metadata, xdp->data_meta will be lower than
xdp->data. The subtraction might push xdp->data_meta below
xdp->data_hard_start, causing out-of-bounds writes when
xdp_convert_buff_to_frame() constructs the struct xdp_frame.

[ ... ]

> @@ -3996,10 +4017,16 @@ static int bcmgenet_xdp_setup(struct net_device *=
dev,
>  		return -EOPNOTSUPP;
>  	}
> =20
> +	if (!prog)
> +		xdp_features_clear_redirect_target(dev);
> +
>  	old_prog =3D xchg(&priv->xdp_prog, prog);
>  	if (old_prog)
>  		bpf_prog_put(old_prog);
> =20
> +	if (prog)
> +		xdp_features_set_redirect_target(dev, false);
> +
>  	return 0;
>  }

Can this unintentionally clear NETDEV_XDP_ACT_NDO_XMIT when detaching an XDP
program?

The driver statically implements ndo_xdp_xmit and advertises it in
dev->xdp_features during probe, indicating the interface can receive XDP
redirected frames from other interfaces regardless of its own XDP program s=
tate.
Calling xdp_features_clear_redirect_target(dev) when prog is NULL will
clear the NETDEV_XDP_ACT_NDO_XMIT capability, hiding it from discovery.

[ ... ]

> @@ -4013,6 +4040,36 @@ static int bcmgenet_xdp(struct net_device *dev, st=
ruct netdev_bpf *xdp)
>  	}
>  }
> =20
> +static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
> +			     struct xdp_frame **frames, u32 flags)
> +{
> +	struct bcmgenet_priv *priv =3D netdev_priv(dev);
> +	struct bcmgenet_tx_ring *ring =3D &priv->xdp_tx_ring;
> +	int sent =3D 0;
> +	int i;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	if (unlikely(!netif_running(dev)))
> +		return -ENETDOWN;
> +
> +	spin_lock(&ring->lock);
> +
> +	for (i =3D 0; i < num_frames; i++) {
> +		if (!bcmgenet_xdp_xmit_frame(priv, ring, frames[i], true))
> +			break;

Does bcmgenet_xdp_xmit_frame() overwrite the struct xdp_frame metadata when
handling these redirected frames?

When dma_map =3D=3D true for redirected frames, the driver prepends a 64-by=
te
hardware TSB by calling memset(xdpf->data - sizeof(struct status_64), 0, 64=
).
Since the struct xdp_frame is located right before xdpf->data (or any prepe=
nded
metadata), writing backwards into the headroom could completely zero out the
struct xdp_frame fields, leading to crashes when returning the frame.

Also, does this cause runt frames to be transmitted as undersized packets?

If the XDP frame is less than 60 bytes, enabling DMA_TX_APPEND_CRC inside
bcmgenet_xdp_xmit_frame() without first padding the frame might trigger the
GENET hardware quirk where it fails to pad packets to the minimum Ethernet =
size,
causing them to be dropped by receiving switches.

Is there a mechanism to ensure these redirected frames won't be leaked if t=
he
target interface is idle?

Without setting DMA_TX_REQ_INTR in len_stat during transmission in
bcmgenet_xdp_xmit_frame(), TX completions for the XDP TX ring rely entirely
on being polled during the RX NAPI cycle. If the interface is receiving no
normal traffic, the NAPI poll might never run, causing the redirected frame=
s to
sit in the TX ring indefinitely.

> +		sent++;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428205846.2625=
550-1-nb@tipi-net.de?part=3D5
