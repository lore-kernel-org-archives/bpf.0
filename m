Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258EF31F9A7
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372461; cv=none; b=Bax7N5YxnMPWhr6+AahfKpgyyyVzN4l7B0MsKbGF20aml50BU/7Yt5WSikJSja0Yd0QIN06OeAReEqOxF1MEcSBxysR09+7jeXJNGMo4nAOOPVLzeE6lBeM9075hxkozknUrz8eusc+Cp5YPp40jp6Z1x8XYRDbUgyg2egI+Nes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372461; c=relaxed/simple;
	bh=kFdpkE3/HWvOIbpbCy3ZXCVCoayNjEWRgiMSZTj9eXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OiI4csSS1Pc62n6ZEuEsj7RP0RaOsSnHGkEpS+g2WnQ3FQcHzsiI6tR/FLK6rR8kJRMWdlyPFCyzmYX50IWz737kX87WIdEFgJToqwaJjOZEBworPyKN1ZOIqKvjt3H0QYzuLBgIdUlS5yPb46aEfehpN35KfGoaorMFiQLd8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8v0n74O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8v0n74O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A09C2BCAF;
	Thu, 16 Apr 2026 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776372460;
	bh=kFdpkE3/HWvOIbpbCy3ZXCVCoayNjEWRgiMSZTj9eXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=K8v0n74OsknqDKJZTwjbA5TZ28yhwq4SSoRc8jeISxS3WUtuUpLjE7NlFdQ0c8uZk
	 RP1IYEt7dzAmqjeH7pfalPO0sJi2mO9mD3k8Vp6YLhjYeDZI7aPhuWnQWLD3LLC2SD
	 FN+KrwmLFjcTetg4oFc7VvznULrGPIIq7HN/a85Z1agCqugBt6/FG2/I4TVPKxGV1f
	 1I1dBIhb4R09LSZ+2uxO7WZCEz5nIgXLmAMYv2/fqsq0z4GfgQuiOsBCiGT6Z7kKje
	 nCzoQRR2JaeYBmOZn+pFle37k5aYhV/dXgpJxzmNGLCNYE4TYFQO17zCKBDGT7plrU
	 xdrm7w1pFT5fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 7/7] net: bcmgenet: reject MTU changes
 incompatible with XDP
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416054743.1289191-8-nb@tipi-net.de>
References: <20260416054743.1289191-8-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 20:47:40 +0000
Message-Id: <20260416204740.A7A09C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The added XDP MTU bounds check in `bcmgenet_change_mtu` is mathe=
matically dead code and contains a logic error regarding L2 overhead.
--

commit ed63f1ac315cb265c4f6425861261ded1cad7433
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: reject MTU changes incompatible with XDP

Add a minimal ndo_change_mtu that rejects MTU values too large for
single-page XDP buffers when an XDP program is attached.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index 02ad2f410d6c6..4d1ec68ec0c59 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -4085,6 +4085,20 @@ static int bcmgenet_xdp_xmit(struct net_device *de=
v, int num_frames,
>  	return sent;
>  }
> =20
> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct bcmgenet_priv *priv =3D netdev_priv(dev);
> +
> +	if (priv->xdp_prog && new_mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {

Is this check reachable? The bcmgenet driver appears to rely on the
ether_setup() default of dev->max_mtu =3D ETH_DATA_LEN (1500) and never
overrides it to support jumbo frames.

The core networking stack's dev_validate_mtu() enforces new_mtu <=3D
dev->max_mtu before invoking ndo_change_mtu. Assuming a minimum Linux
PAGE_SIZE of 4096, this check requires new_mtu to be greater than ~3510
bytes, which should never be possible.

Also, does this formula account for L2 overhead?

new_mtu represents the L3 payload size, but the hardware will DMA the full =
L2
frame into the buffer, including the Ethernet header, VLAN tags, and the
Frame Check Sequence. If jumbo frames are enabled later and an MTU exactly
matched this limit, would the L2 frame silently overflow the page boundary
and corrupt the skb_shared_info structure?

> +		netdev_warn(dev, "MTU too large for single-page XDP buffer\n");
> +		return -EINVAL;
> +	}
> +
> +	WRITE_ONCE(dev->mtu, new_mtu);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416054743.1289=
191-1-nb@tipi-net.de?part=3D7
