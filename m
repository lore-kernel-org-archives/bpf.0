Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492E30BBB6
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365646; cv=none; b=nHW3BwjtGAdlHLj7J7tzW8YgIEOrJ8h2cdH5m8j9eXYqURd7EwaVCX94GNjXfU8U3v0LYTTrV7bj1rAn5WThN02LINk5FJCj66yah7qL4OU9kpIf6jyea0XrW1ePA2xzpyu8ufjprlkOTAUdkSx+d5GKEZn8iEDdvtXi6E+YQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365646; c=relaxed/simple;
	bh=SSiXkMrPi9Ht5KwQybWkDAxhxv5IkDhf1eRipj/UJjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kpXFpu62yvbIkSQA1x8mIYk1RI/IJ9j4AFURL+K7SQiSp0fLkVUB2YsH4DOwAUlTCGFMW78xoWuAFiNXZB2Y8+SCekryRCMOlTvFjVSux7iRA61R1kxbFx21KvU6jMjPsSABFEauUc16/4s7poot0UQ8DclGVQMxa4mNvDxmoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF9N+6uj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF9N+6uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84FEC2BCAF;
	Thu, 16 Apr 2026 18:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776365646;
	bh=SSiXkMrPi9Ht5KwQybWkDAxhxv5IkDhf1eRipj/UJjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZF9N+6ujHVyDAMrA4u9D/mxMz+UCsC07qRuOPT0Kl01X9tIgUgn5XBfcd9xbwFTaR
	 g0UG/n5eZnfKg9C4n1DMPXBa1NwKdJuya47sb8VNC/4OLxvU5t/hhfolM4rqagT7S6
	 xy7ULEsvBQwyd3P3F3b8+K9/nBUoiI3PKLPU29Bi2ob/6rlzXARM71mNJxjxW218PU
	 bKw0EUwtiqubPT7wdtey/pXRgGfGMOMe45YfA9ixtkGKWBJKDhoNbLBQGdh+x5aC4q
	 zZ+cxy1oUQPne1wP6DTPCfK/nJQRCeuxmwss6DVWrcWhlH3ECWqQW/OsNM59Wz4Fqg
	 bowYhoQXuqY9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 4/7] net: bcmgenet: add XDP_TX support
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416054743.1289191-5-nb@tipi-net.de>
References: <20260416054743.1289191-5-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 18:54:05 +0000
Message-Id: <20260416185405.E84FEC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Local XDP_TX mishandles XDP metadata, leading to buffer underf=
low, metadata destruction, and incorrect DMA mappings.
- [High] Unconditional access to `netdev_get_tx_queue(dev, ring->index)` du=
ring XDP TX reclaim causes an out-of-bounds array access.
--

commit bdb3ec6dd3fa70f6fc80f2e6b98851c833a05d8a
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add XDP_TX support

This commit adds local XDP_TX and ndo_xdp_xmit support to the bcmgenet
driver. It dedicates ring 16 for XDP TX, prepends the required 64-byte
Transmit Status Block (TSB) to the frames, and piggybacks TX completion
reclamation onto the RX NAPI poll loop.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
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

When bcmgenet_tx_reclaim() is called here with all =3D true, it executes
this cleanup path:

	if (all) {
		...
		txq =3D netdev_get_tx_queue(ring->priv->dev, ring->index);
		netif_tx_wake_queue(txq);
	}

Since xdp_tx_ring.index is DESC_INDEX (16), but dev->num_tx_queues is at
most 5, does this cause an out-of-bounds array access when retrieving the
netdev transmit queue?

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
> +		dma_sync_single_for_device(kdev, mapping, dma_len,
> +					   DMA_BIDIRECTIONAL);
> +	}

Does this correctly calculate the mapping offset?=20

xdpf->headroom evaluates to the offset from data_hard_start to the start of
the frame. The offset from the start of the page to data_hard_start
(XDP_PACKET_HEADROOM, 256 bytes) appears to be omitted here, potentially
causing the hardware to read from an uninitialized offset hundreds of bytes
before the actual packet.=20

Furthermore, if metadata is present, it looks like this maps data_meta
instead of the TSB at data.

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

Does this correctly account for XDP metadata?=20

If metadata is present, xdp->data_meta will be lower than xdp->data. By
using xdp->data in this check instead of xdp->data_meta, could subtracting
sizeof(struct status_64) push the metadata boundary below
data_hard_start + sizeof(struct xdp_frame) and cause an out-of-bounds
write when xdp_convert_buff_to_frame() is called?

> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}
> +		xdp->data -=3D sizeof(struct status_64);
> +		xdp->data_meta -=3D sizeof(struct status_64);
> +		memset(xdp->data, 0, sizeof(struct status_64));

Does this memset() overwrite the packet metadata?=20

Since xdp->data was just decremented by 64 bytes, the memory region it
clears appears to perfectly overlap with the space previously occupied by
the BPF metadata.

> +		xdpf =3D xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf)) {
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416054743.1289=
191-1-nb@tipi-net.de?part=3D4
