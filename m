Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429655;
	b=z5tehCC4P2ePoWlRC/cb2GndZ8xl7gbkZ8DFQFRZjbcykpVJU/05PaIM0hYrLBYjzmgD
	 s5d8TzQn9FvHOOY411p5OOgMoBDQLFHtljh/u7WFSrNrmGuX+fVENpjljpKIhCw6Yh/gf
	 3BVBeEpK+BfZqm82kDSd9rYhMwepohkSLhwLcIsvxssX7WpTjU5UwBCAu4O2YQDcnsEmQ
	 93ZjksoNUiPvvIuZ6p5ke3mzbAhT/vVcZ2GUogN74OHb9mfTshzljWZGY+c1gkVeIMuZy
	 RFvUHV9v9dvniOwlEnK9dVGluZYZzV7+w+UHtiTg/Rf9eS6Mq7ZGg4wzjE+4xk1aDow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429655;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rhMGS4hc4DBrGFPmsWHhHKuoY0IQAFvPYSF5t3kd/sA=;
	b=NgtdndLSXzExGqDIVQsem1UR/wclL/2eZt1YkAeoVLz/L3ia49t/2nxBycjGXNOWtB0N
	 eIOZcmMwPlt4bTUBnv0yVM08xrfHODt896FUKn1U4hj+sFXWMMfei0hu3TcBlbO/WQB0C
	 CgfKi0p07PCTuBDh1hSrqaOvjQCkY5JW6G64C28PNIaXUJOqmAip0hk1dTMMyu2rTIhvO
	 Oeh3H9ERt9daJFNkPb1gm2CHYmzAlW9THc6nwgXuMyGrFBE81Qd8Z3ousRzp8J7YwuBg3
	 wcsIVxpRYq1IHIaInuNH7nDGD5LLS0QsLAh0KrFbEHD0alyI6H5nQsdD1sPPT/+mOfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hj4CbPEC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C9606A31B
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 17:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hj4CbPEC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE37E1F000C4;
	Mon, 19 Oct 2026 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792429655;
	bh=rhMGS4hc4DBrGFPmsWHhHKuoY0IQAFvPYSF5t3kd/sA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hj4CbPECyGqNIysZOEz4vWwI1zNys8uGbHD04Dvy/olBRxCM4bFF8kopiFWARlim8
	 h1N/DvZ9N3YrR5sOMo/TZ2W25uDoHRnhURk+N4YapCh/lo8VdcQQUeJMJ7l+OhNblM
	 tvuWn4kcUWHmOaqJj3hN/Gd7xxUiojcXC+ajEELQw6vuBaMyYiWNZ/dkRPn6cL+mxy
	 /9WNsMXGhCMVgCvm8NFoVIeNgHiB9H8pRW4zNvG6VnV+12xUbOgiEjeVXqGp1wMB/t
	 FEMgKHDaK5hx5JJdOqP85pBeWAcMF9TbUkDIwDIhx3gOjlmU03K2D6xlfKvwUrbPo9
	 ijrZKA1XZx+LQ==
Message-ID: <sashiko-outbox-177997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 4/5] net: stmmac: fix VLAN tag stripping on
 non-linear RX frames
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261018-stmmac-rx-mb-v8-4-5f58c0b25849@oss.qualcomm.com>
References: <20261018-stmmac-rx-mb-v8-0-5f58c0b25849@oss.qualcomm.com>
 <20261018-stmmac-rx-mb-v8-4-5f58c0b25849@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 17:07:34 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: stmmac: unconditional VLAN_ETH_HLEN pull in stmmac_rx_vlan()
--

commit 0a2d776ad3e3751ad20c9dd1144b0c000e67acc1
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: fix VLAN tag stripping on non-linear RX frames

This commit updates stmmac_rx_vlan() to linearize the VLAN header with
pskb_may_pull(), preserve XDP metadata when popping the VLAN tag, and drop
the frame in stmmac_rx() and stmmac_dispatch_skb_zc() if pulling fails.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index e929cc0f23125..04dc6dcaa435d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5095,22 +5095,30 @@ static netdev_features_t stmmac_features_check(st=
ruct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }
> =20
> -static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> +static int stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
>  {
> -	struct vlan_ethhdr *veth =3D skb_vlan_eth_hdr(skb);
> -	__be16 vlan_proto =3D veth->h_vlan_proto;
> -	u16 vlanid;
> +	struct vlan_ethhdr *veth;
> =20
> -	if ((vlan_proto =3D=3D htons(ETH_P_8021Q) &&
> +	if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
> +		return -EINVAL;
> +
> +	veth =3D skb_vlan_eth_hdr(skb);
> +	if ((veth->h_vlan_proto =3D=3D htons(ETH_P_8021Q) &&
>  	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
> -	    (vlan_proto =3D=3D htons(ETH_P_8021AD) &&
> +	    (veth->h_vlan_proto =3D=3D htons(ETH_P_8021AD) &&
>  	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {

[Severity: Medium]
Can calling pskb_may_pull(skb, VLAN_ETH_HLEN) unconditionally at the start
of stmmac_rx_vlan() cause valid untagged frames to be dropped, or force
unnecessary fragment pulls on non-linear untagged packets?

When priv->hw->hw_vlan_en is false, stmmac_rx() and stmmac_dispatch_skb_zc()
call stmmac_rx_vlan() on every received frame, even when VLAN RX stripping
offloads are disabled in dev->features or the packet is untagged.

XDP helpers such as bpf_xdp_adjust_head(), bpf_xdp_adjust_tail(), and
bpf_xdp_frags_shrink_tail() allow shrinking a frame down to ETH_HLEN (14
bytes):

net/core/filter.c:bpf_xdp_adjust_head() {
	...
	if (unlikely(data < data_start ||
		     data > xdp->data_end - ETH_HLEN))
		return -EINVAL;
	...
}

For an untagged frame of 14 to 17 bytes (where ETH_HLEN <=3D skb->len <
VLAN_ETH_HLEN), pskb_may_pull(skb, VLAN_ETH_HLEN) fails and returns -EINVAL,
causing both stmmac_rx() and stmmac_dispatch_skb_zc() to free and drop the
skb via dev_kfree_skb_any(skb).

Additionally, for non-linear untagged frames with skb->len >=3D VLAN_ETH_HL=
EN
whose linear head is ETH_HLEN bytes (for example, after bpf_xdp_adjust_head=
()
with BPF_F_XDP_HAS_FRAGS, or with GMAC4 split header mode splitting after t=
he
14-byte L2 header), pulling VLAN_ETH_HLEN before checking h_vlan_proto forc=
es
__pskb_pull_tail() on every untagged packet.

Since veth->h_vlan_proto sits within the first ETH_HLEN bytes of the header,
should stmmac_rx_vlan() only pull ETH_HLEN initially (or check dev->features
first), and defer pskb_may_pull(skb, VLAN_ETH_HLEN) and reloading veth until
after confirming that veth->h_vlan_proto matches a VLAN ethertype to be
stripped?

> +		__be16 vlan_proto =3D veth->h_vlan_proto;
> +		u16 vlanid =3D ntohs(veth->h_vlan_TCI);
> +		u8 meta_len =3D skb_metadata_len(skb);
> +
>  		/* pop the vlan tag */
> -		vlanid =3D ntohs(veth->h_vlan_TCI);
> -		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> +		memmove(skb->data - meta_len + VLAN_HLEN,
> +			skb->data - meta_len, meta_len + ETH_ALEN * 2);
>  		skb_pull(skb, VLAN_HLEN);
>  		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
>  	}
> +
> +	return 0;
>  }

[ ... ]

> @@ -5530,12 +5538,15 @@ static void stmmac_dispatch_skb_zc(struct stmmac_=
priv *priv, u32 queue,
>  	}
> =20
>  	stmmac_get_rx_hwtstamp(priv, p, np, skb);
> -	if (priv->hw->hw_vlan_en)
> +	if (priv->hw->hw_vlan_en) {
>  		/* MAC level stripping. */
>  		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> -	else
> -		/* Driver level stripping. */
> -		stmmac_rx_vlan(priv->dev, skb);
> +	} else if (stmmac_rx_vlan(priv->dev, skb)) {
> +		dev_kfree_skb_any(skb);
> +		priv->xstats.rx_dropped++;
> +		return;
> +	}
> +
>  	skb->protocol =3D eth_type_trans(skb, priv->dev);
> =20
>  	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
> @@ -6041,12 +6052,14 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> =20
>  		stmmac_get_rx_hwtstamp(priv, p, np, skb);
> =20
> -		if (priv->hw->hw_vlan_en)
> +		if (priv->hw->hw_vlan_en) {
>  			/* MAC level stripping. */
>  			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> -		else
> -			/* Driver level stripping. */
> -			stmmac_rx_vlan(priv->dev, skb);
> +		} else if (stmmac_rx_vlan(priv->dev, skb)) {
> +			dev_kfree_skb_any(skb);
> +			rx_dropped++;
> +			goto next;
> +		}
> =20
>  		skb->protocol =3D eth_type_trans(skb, priv->dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-stmmac-rx-=
mb-v8-0-5f58c0b25849@oss.qualcomm.com?part=3D4
