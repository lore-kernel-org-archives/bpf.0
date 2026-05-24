Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7802BB1D
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779628484; cv=none; b=lQJFF+2GVmizUAgp7xfnqfcAaP/WJ3vWCzn+abt8e1cKg8yy/qtY4kpM2x5G6ANG9Yvoc6XciLHivDqroC0wfKtfoTiTJ+3LGSnnyZJWhBlBPe+BqdBZ5bFJyX6UQmWd+WRdnPEpJcp40zifFi1zHMsxl8TWORXWbla8i1Efk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779628484; c=relaxed/simple;
	bh=l6lD1UUM9tJPjoxrB19gxuG5EBkGUcH8uadIOR8dkyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pc9zjN1IfoJZWiMb1KKOroidvJJvSBxWF80OXJQlX31D4csxXOspnrFBDZr1zwHsOsCM2s7tEqN+O7DMn+h3NgsxFg0F/ZnoOegcR4VxDEyGnztKxYHrmA1M1cfp+kJ4bBf2yBUrEz4lvZICAiXOyyT2RHDX3LvdQR7ZaE4R8dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giEuR4yW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giEuR4yW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689C21F000E9;
	Sun, 24 May 2026 13:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779628482;
	bh=LQYITfFCN45agX10us3cRYKN/taRRcnkmbaIEX8oYd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=giEuR4yWl0B6BrKYkaWYeGusHleaOljkPCrW1DDpQ3WpO1fxx8k2dVA6FmN/UEux2
	 hsWFyuaCnZBAJNN5XSith2XmXYmI7K5sJ+GMeJXEmjEYyP51QaOT/gfKtMBlIaMIUa
	 vRxj0OsALGvf1Rir2yutPXVl9NNl2HnXdGyyOVZluYQPriRfLoI1tGranDIZcBRIAe
	 aDt52bB5TpWMlScpjW7cAwYRSNhO5FD46+cx7P0tLBJn0fxgbCZy4Kqjaof+onSlGG
	 DXIt69u2HUOhq2KlGISn3Eat7KJMZ3ZzUyEoYBk5bOp2GVR4qi/sGXG2Um8IWcSEoT
	 1pQugjnJxJhHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: mvpp2: fix skb not reflecting XDP modifications on
 XDP_PASS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260524122334.1730451-1-mail@tk154.de>
References: <20260524122334.1730451-1-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 13:14:42 +0000
Message-Id: <20260524131442.689C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The patch passes an unchecked XDP-modified length to `skb_put()`, =
introducing a deterministic kernel panic (`skb_over_panic`) if the XDP prog=
ram grows the packet.
- [Medium] RX byte statistics inconsistently track XDP modifications.

Pre-existing issues:
- [Critical] Freed data buffers are returned to the hardware Buffer Manager=
 (BM) pool during the RX buffer refill error path, causing severe memory co=
rruption.
- [High] The DMA sync operation misses the packet tail due to an unhandled =
headroom offset, leading to potential data corruption.
- [High] XDP buffer initialization unconditionally uses `PAGE_SIZE`, allowi=
ng out-of-bounds writes on short buffers.
- [High] Hardware checksum status is blindly trusted even after XDP modific=
ations, bypassing network stack validation.
--

commit 07608dfe3a3f044abc14018615b3941358f7641f
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: fix skb not reflecting XDP modifications on XDP_PASS

When an XDP program uses bpf_xdp_adjust_head() or bpf_xdp_adjust_tail()
and then returns XDP_PASS, the driver ignores the updated xdp_buff
pointers and builds the skb from hardcoded offsets derived from the
original RX descriptor. This means any packet modifications made by the
XDP program are silently discarded before the skb reaches the network
stack.

Fix this by saving the post-XDP data pointer offset and length back into
rx_offset and rx_bytes when XDP_PASS is returned, so the subsequent
skb_reserve()/skb_put() calls use the actual packet geometry as seen by
the XDP program. When no XDP program is loaded the variables retain
their original descriptor-derived values and the non-XDP fast path is
unaffected.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index f442b874bb593..27d4feebcb595 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3933,6 +3933,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct=
 napi_struct *napi,
>  		rx_status =3D mvpp2_rxdesc_status_get(port, rx_desc);
>  		rx_bytes =3D mvpp2_rxdesc_size_get(port, rx_desc);
>  		rx_bytes -=3D MVPP2_MH_SIZE;
> +		rx_offset =3D MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
>  		dma_addr =3D mvpp2_rxdesc_dma_addr_get(port, rx_desc);
> =20
>  		pool =3D (rx_status & MVPP2_RXD_BM_POOL_ID_MASK) >>
>  			MVPP2_RXD_BM_POOL_ID_OFFS;
>  		bm_pool =3D &port->priv->bm_pools[pool];
> =20
>  		if (port->priv->percpu_pools) {
>  			pp =3D port->priv->page_pool[pool];
>  			dma_dir =3D page_pool_get_dma_dir(pp);
>  		} else {
>  			dma_dir =3D DMA_FROM_DEVICE;
>  		}
> =20
>  		dma_sync_single_for_cpu(dev->dev.parent, dma_addr,
>  					rx_bytes + MVPP2_MH_SIZE,
>  					dma_dir);

[Severity: High]
This is a pre-existing issue, but does this DMA sync miss the end of the
packet?

Since the payload is written by the hardware at an offset of MVPP2_MH_SIZE +
MVPP2_SKB_HEADROOM from dma_addr, syncing only rx_bytes + MVPP2_MH_SIZE see=
ms
to sync the empty headroom at the beginning but skip the last
MVPP2_SKB_HEADROOM bytes of the packet.

On non-coherent architectures, could this cause the CPU to read stale cached
data for the tail of the packet, leading to data corruption?

[ ... ]

>  		if (xdp_prog) {
>  			struct xdp_rxq_info *xdp_rxq;
> =20
>  			if (bm_pool->pkt_size =3D=3D MVPP2_BM_SHORT_PKT_SIZE)
>  				xdp_rxq =3D &rxq->xdp_rxq_short;
>  			else
>  				xdp_rxq =3D &rxq->xdp_rxq_long;
> =20
>  			xdp_init_buff(&xdp, PAGE_SIZE, xdp_rxq);

[Severity: High]
This isn't a bug introduced by this patch, but does unconditionally using
PAGE_SIZE here allow out-of-bounds writes?

The actual allocated fragment size (bm_pool->frag_size) can be smaller than=
 a
page, such as for the short packet pool. If an XDP program uses
bpf_xdp_adjust_tail() to grow the packet up to PAGE_SIZE, could this write =
past
the end of the allocated buffer and corrupt adjacent memory?

>  			xdp_prepare_buff(&xdp, data,
>  					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
>  					 rx_bytes, true);
> =20
>  			ret =3D mvpp2_run_xdp(port, xdp_prog, &xdp, pp, &ps);
> =20
>  			if (ret) {
>  				xdp_ret |=3D ret;
>  				err =3D mvpp2_rx_refill(port, bm_pool, pp, pool);
>  				if (err) {
>  					netdev_err(port->dev, "failed to refill BM pools\n");
>  					goto err_drop_frame;
>  				}
> =20
>  				ps.rx_packets++;
>  				ps.rx_bytes +=3D rx_bytes;
>  				continue;
>  			}
> =20
> +			/* Update offset and length to reflect any XDP adjustments. */
> +			rx_offset =3D xdp.data     - data;
> +			rx_bytes  =3D xdp.data_end - xdp.data;

[Severity: Medium]
Will this result in inconsistent tracking of RX byte statistics?

If the XDP program returns XDP_TX or XDP_DROP, the original pre-XDP length =
is
added to ps.rx_bytes earlier in this loop. When it returns XDP_PASS, the
updated post-XDP length is now stored in rx_bytes and added to ps.rx_bytes =
at
the end of the loop.

Could this mix wire lengths and post-XDP lengths in the statistics depending
on the verdict?

> =20
>  			metasize =3D xdp.data - xdp.data_meta;
>  		}
> =20
>  		if (frag_size)
>  			skb =3D build_skb(data, frag_size);
>  		else
>  			skb =3D slab_build_skb(data);
>  		if (!skb) {
>  			netdev_warn(port->dev, "skb build failed\n");
>  			goto err_drop_frame;
>  		}
> =20
>  		/* If we have RX hardware timestamping enabled, grab the
>  		 * timestamp from the queue and convert.
>  		 */
>  		if (mvpp22_rx_hwtstamping(port)) {
>  			timestamp =3D le32_to_cpu(rx_desc->pp22.timestamp);
>  			mvpp22_tai_tstamp(port->priv->tai, timestamp,
>  					 skb_hwtstamps(skb));
>  		}
> =20
>  		err =3D mvpp2_rx_refill(port, bm_pool, pp, pool);
>  		if (err) {
>  			netdev_err(port->dev, "failed to refill BM pools\n");
>  			dev_kfree_skb_any(skb);
>  			goto err_drop_frame;
>  		}

[Severity: Critical]
This is a pre-existing issue, but does this error path lead to memory
corruption?

If mvpp2_rx_refill() fails, dev_kfree_skb_any(skb) is called which frees the
SKB and its underlying data buffer back to the kernel allocator. However, t=
he
path then jumps to err_drop_frame, which calls mvpp2_bm_pool_put() with the
same physical address.

Since this returns the freed memory back to the hardware RX pool, could the
hardware DMA new packets into memory that the kernel considers free and may
have reallocated to other subsystems?

[ ... ]

>  		ps.rx_packets++;
>  		ps.rx_bytes +=3D rx_bytes;
> =20
> -		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
> +		skb_reserve(skb, rx_offset);
>  		skb_put(skb, rx_bytes);

[Severity: High]
Does this updated skb_put() call risk triggering a deterministic kernel pan=
ic?

Because xdp_init_buff() incorrectly advertises a capacity of PAGE_SIZE even
for short buffers, an XDP program can legitimately grow the packet length
beyond frag_size. When this unchecked rx_bytes length is passed to skb_put(=
),
if it exceeds the SKB's tailroom (initialized with frag_size in build_skb()=
),
wouldn't this trigger skb_over_panic()?

>  		if (metasize)
>  			skb_metadata_set(skb, metasize);
>  		skb->ip_summed =3D mvpp2_rx_csum(port, rx_status);

[Severity: High]
This isn't a bug introduced by this patch, but should the hardware checksum
status be trusted if the packet was modified by XDP?

If an XDP program modifies the packet payload or changes packet headers (su=
ch
as through bpf_xdp_adjust_head()), the hardware checksum is no longer valid.
By unconditionally setting skb->ip_summed based on the original hardware
state, could this falsely tell the network stack that the checksum is valid
and allow corrupted or incorrectly modified packets to bypass software
checksum validation?

>  		skb->protocol =3D eth_type_trans(skb, dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524122334.1730=
451-1-mail@tk154.de?part=3D1
