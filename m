Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADDF274B3B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497422; cv=none; b=LOiudLySA8IE8DOpuYBUNQNxaaDoBG9saCoscBiMh5BFt5dlJCwA4KGMcY1N2s3rYb8grwmi+ZTD7Eb73x+ShXTKYlvlolMmAbUGQPvSL5rrJEAnkep/bnwV7OVJQNdj269ylchfY5K4h3z7zD9SvlEZESUXftXitIhAds6pVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497422; c=relaxed/simple;
	bh=HINDC7MBhtGoj96xzxhrUVOVUkyHyQPreGfvzgv3FXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T0XyCfCdJx/dtJEp6KzmdrnLQG2uEvdTWi8itVYbA1QtPQbRBxzIHJ2Tq/pqJUwgRd+ghReNShU/e76VC9SXOYKWtz4E6PXKLMqggF9ibNVAqAZCrkLRSSqnv3iPcsBEKsmp0J6Ezwgq/1OcBgjunNbDfcwsMtjDFLitP3fTMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJtI3STC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJtI3STC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E86C2BCB4;
	Wed, 29 Apr 2026 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497422;
	bh=HINDC7MBhtGoj96xzxhrUVOVUkyHyQPreGfvzgv3FXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JJtI3STCJ+NjuMgIEXw0sIf2DDXUAm60X1ocX6FAzBNc2pVfLcBpWbJBieRr6Wfdi
	 aBnvq8GfTGFOvDk26e/6MKiX9pQbEpAH4w5LDdqrTGrwnh/n2y9gL+p+a34Wd0Nxwc
	 CkRph4maspmxCShJ/pPIkc9ERqCW0ihxxslflTJ/zJP6ybjTvBrWXr59AOvRwqck6n
	 yj3MT2eq66fJHQ5jvXI+7WtXQwbWW3OvYxN9NXbwJ8LYt6GQuElLJg60HM2v6jzwcf
	 EqjrsPetE5izVyiEaRRURSXMWj9hLVGMk3IJYp3j3lIgM7I4HUPEK3XGQHOHoL0r/+
	 ZyLG9l+wcGldw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 4/7] net: bcmgenet: add XDP_TX support
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428205846.2625550-5-nb@tipi-net.de>
References: <20260428205846.2625550-5-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:17:01 +0000
Message-Id: <20260429211702.42E86C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Out-of-bounds array access in `bcmgenet_tx_reclaim` during interfa=
ce teardown
- [High] Incorrect DMA address calculation for local XDP_TX causes informat=
ion leak and packet corruption
- [High] Prepending `status_64` block overwrites XDP metadata and causes me=
mory corruption
- [Medium] XDP TX ring size is smaller than standard NAPI budget
--

commit 9add891fa4e7cf62ec26683116338b5877c21662
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add XDP_TX support

Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index 1b60571446e1..3c3b0c44ea8a 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -48,8 +48,10 @@
> =20
>  #define GENET_Q0_RX_BD_CNT	\
>  	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_=
q)
> +#define GENET_Q16_TX_BD_CNT	32

Is it possible to drop packets here during bursts since this TX ring is sma=
ller
than the standard NAPI budget?

The standard RX NAPI budget is 64, and TX completions are reclaimed only on=
ce
before the RX loop. If the RX loop processes a full budget of 64 packets and
they all result in an XDP_TX action, the first 32 will fill the TX ring.

The remaining 32 packets would fail in bcmgenet_xdp_xmit_frame() because
ring->free_bds < 1, and be dropped.

[ ... ]
> @@ -2043,6 +2069,9 @@ static void bcmgenet_tx_reclaim_all(struct net_devi=
ce *dev)
>  	do {
>  		bcmgenet_tx_reclaim(dev, &priv->tx_rings[i++], true);
>  	} while (i <=3D priv->hw_params->tx_queues && netif_is_multiqueue(dev));
> +
> +	/* Also reclaim XDP TX ring */
> +	bcmgenet_tx_reclaim(dev, &priv->xdp_tx_ring, true);
>  }

Can this cause an out-of-bounds array access during interface teardown?

When bcmgenet_tx_reclaim_all() calls bcmgenet_tx_reclaim() with all =3D=3D =
true,
it unconditionally calls netdev_tx_reset_queue(netdev_get_tx_queue(dev, rin=
g->index)).

The XDP TX ring has an index of 16 (DESC_INDEX), but the network device is
allocated with only GENET_MAX_MQ_CNT + 1 TX queues (typically 5). Accessing
index 16 of dev->_tx is out-of-bounds, and netdev_tx_reset_queue() will wri=
te
to this invalid memory.

[ ... ]
> @@ -2299,11 +2328,96 @@ static struct sk_buff *bcmgenet_xdp_build_skb(str=
uct bcmgenet_rx_ring *ring,
>  	return skb;
>  }
> =20
> +static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +				     struct xdp_frame *xdpf, bool dma_map)
> +{
[ ... ]
> +	if (dma_map) {
[ ... ]
> +	} else {
> +		struct page *page =3D virt_to_page(xdpf->data);
> +
> +		/* For local XDP_TX the caller already prepended the TSB
> +		 * into xdpf->data/len, so dma_len =3D=3D xdpf->len.
> +		 */
> +		dma_len =3D xdpf->len;
> +		mapping =3D page_pool_get_dma_addr(page) +
> +			  sizeof(*xdpf) + xdpf->headroom;

Does this calculation result in an incorrect DMA address?

The calculation implicitly assumes that xdpf resides exactly at the beginni=
ng
of the page. However, the driver configures the RX page pool with
offset =3D XDP_PACKET_HEADROOM (typically 256 bytes).=20

By omitting the distance from the start of the page to xdpf, the calculated
DMA address points XDP_PACKET_HEADROOM bytes before the actual packet data,
which could lead to transmitting uninitialized memory.

> +		dma_sync_single_for_device(kdev, mapping, dma_len,
> +					   DMA_BIDIRECTIONAL);
> +	}
[ ... ]
> +	case XDP_TX:
> +		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
> +		 * MAC has TBUF_64B_EN set globally, so hardware expects every
> +		 * TX buffer to begin with a 64-byte struct status_64.  Back
> +		 * up xdp->data into the RSB area (which is no longer needed
> +		 * after the BPF program ran) and zero it.
> +		 */
> +		if (xdp->data - xdp->data_hard_start <
> +		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}
> +		xdp->data -=3D sizeof(struct status_64);
> +		xdp->data_meta -=3D sizeof(struct status_64);
> +		memset(xdp->data, 0, sizeof(struct status_64));

Could this overwrite XDP metadata and cause memory corruption?

The space check does not account for metasize (xdp->data - xdp->data_meta).
If the BPF program appended metadata, the memset() here completely overwrit=
es
it.

Furthermore, if metasize is > 0, the shifted xdp->data_meta pointer could
underflow and point exactly to or before xdp->data_hard_start. When
xdp_convert_buff_to_frame() is subsequently called, it writes the xdp_frame
structure at data_hard_start, which would overlap with the shifted data_met=
a.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428205846.2625=
550-1-nb@tipi-net.de?part=3D4
