Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954661A6816;
	Sat,  6 Jun 2026 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707683; cv=none; b=XnUL/KW9fVZboRCwJr29VSI0RMM70yI+HAtYtFI56cHSk8w7LXQhFg+40XbJdsRC87AL9HvLG1WX2pyLcXxosFjl/+wahpupREWNRiiAfffVBsgD9YGQ8yX4nfoTCxIIZaZQlfFx8wKR8eM7UKj03QKX66oykBjPTH/6A0wyHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707683; c=relaxed/simple;
	bh=vwS0MDGwnMP+qy+iMt0cW823/NcvkElfyo3HMquYRMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fnFrDeqPyypDW+Uv7kaTfplyfowbzBrwnl8gyU6n5OWJqbLser1vMNpIJ+k0ZqmL8qBrd6IrLn9ACV0F+KvWW98OMs/RIMyxqVhxalwY/jg/n5KBvTi9hQ5NjjsvjlUxx1tzM3Mh/lq0JwES5i8BtJOROEl9/CjIt1w9Ie9JIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVO4mYiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVO4mYiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A211F00899;
	Sat,  6 Jun 2026 01:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707682;
	bh=Ur2NTdRGOHJR7RwLC+7bY1IFjGxC1Gqdfo05jJ2ykt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bVO4mYiKVPYb3TFdUpz3mIqpjyCiRyx4OIgWbHXPKxkb2T8nxnvWtD4UcdWY4Oybb
	 i6qKq9Ng/7/6JJ8RLkiT5Cnq9BY5Ph42FPALyTdNb1ApxO7AlNJLvRBBZSUp+8atAM
	 8TezKVEPZOZ5J6TPKGOmHgtlUfhBilbnQTXYIu1WCxjRVuBpJK82/63KKIRLfOjeFV
	 SdmXCknUy7uRjkJUnXOoIoTGRITxAdZZT5qKLtwmiS9AwSwA7EuAL1zuO2qAlNWdFt
	 Ym3WDb1J6wAWPKwdzTKRUA2ZM/ubNTUUkx5vBtE1vs2kHE0vnbIUrzF4WTmdKuSHIx
	 55Uqa088f9+9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 06/14] net: stmmac: dma: create a separate
 dma_device pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260605010022.968612-7-elder@riscstar.com>
References: <20260605010022.968612-7-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 01:01:21 +0000
Message-Id: <20260606010122.21A211F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When DMA mapping fails during transmission, the driver either leak=
s mapped memory (non-TSO path) or causes a permanent hardware TX queue stal=
l (TSO path).
- [High] Kernel panic in the DMA descriptor allocation error path due to a =
NULL pointer dereference when tearing down uninitialized queues.
--

commit 66acc331f7f048d75e9c4b2fb700576508be93dc
Author: Alex Elder <elder@riscstar.com>
Subject: net: stmmac: dma: create a separate dma_device pointer

The patch separates the DMA device from the MAC device in the stmmac driver.
It adds a dma_device pointer to the stmmac_priv and plat_stmmacenet_data
structures, and updates all DMA operations to use it.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 35da51c262484..09d2640a18b3c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1730,12 +1730,12 @@ static void stmmac_free_tx_buffer(struct stmmac_p=
riv *priv,
>  	if (tx_q->tx_skbuff_dma[i].buf &&
>  	    tx_q->tx_skbuff_dma[i].buf_type !=3D STMMAC_TXBUF_T_XDP_TX) {
>  		if (tx_q->tx_skbuff_dma[i].map_as_page)
> -			dma_unmap_page(priv->device,
> +			dma_unmap_page(priv->dma_device,
>  				       tx_q->tx_skbuff_dma[i].buf,
>  				       tx_q->tx_skbuff_dma[i].len,
>  				       DMA_TO_DEVICE);
>  		else
> -			dma_unmap_single(priv->device,
> +			dma_unmap_single(priv->dma_device,
>  					 tx_q->tx_skbuff_dma[i].buf,
>  					 tx_q->tx_skbuff_dma[i].len,
>  					 DMA_TO_DEVICE);

[Severity: High]
This is a pre-existing issue, but is there a risk of a NULL pointer
dereference in the DMA descriptor allocation error path?

In the error path of alloc_dma_tx_desc_resources() or
alloc_dma_rx_desc_resources(), if queue allocation fails (e.g., -ENOMEM from
kzalloc_objs), the driver unconditionally cleans up all configured queues,
including those that were never initialized.

When free_dma_rx_desc_resources() or free_dma_tx_desc_resources() processes
an uninitialized queue, it iterates over the descriptor ring and calls
stmmac_free_tx_buffer() or stmmac_free_rx_buffer(). Since tx_skbuff_dma
or buf_pool is NULL for uninitialized queues, attempting to check conditions
like the one above will dereference a pointer relative to NULL, triggering a
panic.

[ ... ]

> @@ -4571,9 +4571,9 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>  	first =3D desc;
> =20
>  	/* first descriptor: fill Headers on Buf1 */
> -	des =3D dma_map_single(priv->device, skb->data, skb_headlen(skb),
> +	des =3D dma_map_single(priv->dma_device, skb->data, skb_headlen(skb),
>  			     DMA_TO_DEVICE);
> -	if (dma_mapping_error(priv->device, des))
> +	if (dma_mapping_error(priv->dma_device, des))
>  		goto dma_map_err;
> =20
>  	stmmac_set_desc_addr(priv, first, des);
> @@ -4599,10 +4599,10 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff=
 *skb, struct net_device *dev)
>  	for (i =3D 0; i < nfrags; i++) {
>  		const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> =20
> -		des =3D skb_frag_dma_map(priv->device, frag, 0,
> +		des =3D skb_frag_dma_map(priv->dma_device, frag, 0,
>  				       skb_frag_size(frag),
>  				       DMA_TO_DEVICE);
> -		if (dma_mapping_error(priv->device, des))
> +		if (dma_mapping_error(priv->dma_device, des))
>  			goto dma_map_err;

[Severity: High]
This is a pre-existing issue, but does a DMA mapping failure here cause a
permanent hardware TX queue stall?

In stmmac_tso_xmit(), intermediate descriptors are eagerly marked with the
OWN=3D1 bit by stmmac_tso_allocator() before all fragments are mapped. If a
subsequent fragment mapping fails, the code jumps to dma_map_err before
setting the OWN bit on the first descriptor.

The hardware DMA engine won't process the intermediate fragments. Later, wh=
en
stmmac_tx_clean() processes the ring, it will encounter the OWN=3D1 descrip=
tor
and permanently halt, freezing the entire TX queue.

[ ... ]

> @@ -4827,9 +4827,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>  	} else {
>  		bool last_segment =3D (nfrags =3D=3D 0);
> =20
> -		dma_addr =3D dma_map_single(priv->device, skb->data,
> +		dma_addr =3D dma_map_single(priv->dma_device, skb->data,
>  					  nopaged_len, DMA_TO_DEVICE);
> -		if (dma_mapping_error(priv->device, dma_addr))
> +		if (dma_mapping_error(priv->dma_device, dma_addr))
>  			goto dma_map_err;
> =20
>  		stmmac_set_tx_skb_dma_entry(tx_q, first_entry, dma_addr,
> @@ -4878,9 +4878,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb,=
 struct net_device *dev)
> =20
>  		desc =3D stmmac_get_tx_desc(priv, tx_q, entry);
> =20
> -		dma_addr =3D skb_frag_dma_map(priv->device, frag, 0, frag_size,
> -					    DMA_TO_DEVICE);
> -		if (dma_mapping_error(priv->device, dma_addr))
> +		dma_addr =3D skb_frag_dma_map(priv->dma_device, frag, 0,
> +					    frag_size, DMA_TO_DEVICE);
> +		if (dma_mapping_error(priv->dma_device, dma_addr))
>  			goto dma_map_err; /* should reuse desc w/o issues */

[Severity: High]
This is a pre-existing issue, but does this error path lead to a memory lea=
k?

In stmmac_xmit(), if dma_map_single() or skb_frag_dma_map() fails, the code
jumps to dma_map_err without advancing tx_q->cur_tx.

Subsequent transmissions will reuse the same descriptor index and overwrite
the DMA addresses in tx_q->tx_skbuff_dma. This causes a permanent memory le=
ak
of the previously mapped fragments for this skb, as they are never unmapped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605010022.9686=
12-1-elder@riscstar.com?part=3D6
