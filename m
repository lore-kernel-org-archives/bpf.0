Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A7274B3B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497425; cv=none; b=Z6iS4Ca5yYOzt+0EL5tnLb2F8yI+Q0GKoswwK4jzRQfOihrq5onEMn4o26/jt0kp40b9adqz6Wz1dBqZFvXZpIRtzh00g81PlpEZisgACNdnv+8ilorgBWjFsK9rXhNx5STA1r8CD43+tz3FBidp9im5zELRoAtbzUurZawWzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497425; c=relaxed/simple;
	bh=Sx/1c4Blm/mI+NKMnLiDmnAHNzpD/jLnqJupZf1FP5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pHEooEoD3e4uaxLOgtSIhQH68LKvvujssLoFOmVroMdM2fwHOnaPESuiSMoqzR5ixE8MT2MNKbVM9IJf+oH5NLgY/P6OnYTS6vxe+3o0GhbZGmfmxRUalAr8cAVggt7tGdyw7TxgcGDH8sqP4qm7eC+DYsE7wRMXySwwbf7E3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQmRLDE5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQmRLDE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF4CC19425;
	Wed, 29 Apr 2026 21:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497425;
	bh=Sx/1c4Blm/mI+NKMnLiDmnAHNzpD/jLnqJupZf1FP5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uQmRLDE5wP/k8mTHgiQFK3L5m+b84zSaP5fnLo5D9slWC7D5ACzpTtTACJLKBIxNz
	 2yxNNFzLHRLwIR8uFrdpIWq4N5tYcvdS6c2oZixSvgZ/9dZiFwD2A9W1DZcZ8xYCg6
	 ZFByK87aco2jtO6GElWgd54Wuwyjvnf+Qji5yNDLeA6vtsDHdI8o+Xt8xdDC65zYAf
	 HsISMHfTjvqwXxVttOPJswYw58fATDHBMlfZYblRZZOrJDFnxJM31XPqUmaZtvUo10
	 9DQ+7SekOvftG+j90bfqSHLvQbKJqcCZO1h0M88YRSsRKZVTwr90OEuWa57HbFxwgg
	 vOL89DUsc5dqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 7/7] net: bcmgenet: reject MTU changes
 incompatible with XDP
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428205846.2625550-8-nb@tipi-net.de>
References: <20260428205846.2625550-8-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:17:04 +0000
Message-Id: <20260429211705.4CF4CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The XDP MTU validation logic contains a mathematical error (igno=
ring L2 headers) and is structurally unreachable (dead code) because the de=
vice's maximum MTU is fixed at 1500.
--

commit b8018c0a123b4927db5ca8c39c8395c751532069
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: reject MTU changes incompatible with XDP

This commit introduces a minimal ndo_change_mtu function to the bcmgenet
driver. It checks if an XDP program is attached and rejects MTU values that
would exceed the capacity of a single-page XDP buffer.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index 02ad2f410d6c..4d1ec68ec0c5 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -4085,6 +4085,20 @@ static int bcmgenet_xdp_xmit(struct net_device *de=
v, int num_frames,
[ ... ]
> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct bcmgenet_priv *priv =3D netdev_priv(dev);
> +
> +	if (priv->xdp_prog && new_mtu > PAGE_SIZE - GENET_RX_HEADROOM -
> +	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {

Is this condition actually reachable, and does it correctly account for L2
headers?

The bcmgenet driver does not appear to override dev->max_mtu, which
defaults to ETH_DATA_LEN (1500). Because dev_validate_mtu() in the core
networking stack checks that new_mtu <=3D dev->max_mtu before calling
ndo_change_mtu, new_mtu will never exceed 1500.

Given that PAGE_SIZE (typically 4096) minus GENET_RX_HEADROOM and the
skb_shared_info alignment is roughly 3454 bytes, the check new_mtu > 3454
will always evaluate to false.

Also, new_mtu represents the L3 payload size. Shouldn't the check add the
L2 header overhead when comparing against the L2 buffer capacity?

Furthermore, is it possible for an MTU change to corrupt the XDP buffer
layout as the commit message claims?

The hardware DMA appears to be statically configured to write a maximum of
RX_BUF_LENGTH (2048) bytes per buffer, and bcmgenet_desc_rx() explicitly
drops any packet larger than 2048 bytes. It seems structurally impossible
to overflow the 4096-byte page and corrupt skb_shared_info.

> +		netdev_warn(dev, "MTU too large for single-page XDP buffer\n");
> +		return -EINVAL;
> +	}
> +
> +	WRITE_ONCE(dev->mtu, new_mtu);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428205846.2625=
550-1-nb@tipi-net.de?part=3D7
