Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E454A3419
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005379; cv=none; b=BgV14sXktwVsdZ2lTIDDGs5EKSRucoatzzAHjfzv8bsYj/D+zB5taQuDDUFssvaKVPMNIX47DESJzwrig9G12u+/moIhwRCJbIHV6yURaJImJ83hrtB9GuNlkHPiZSe10oiadhe44PXg0WODCqWEp8EpBWFh3F+SEECQYUaD9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005379; c=relaxed/simple;
	bh=ZJJSxi+SG+WjAIC6XgJEEg+tXlUO2jF2D9S6uRMTM2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X4QeGXKGdoIq8qX/TLD4mUV+8JDAg+eK+l4ohztol6gFZZrpXo2v4PMO9f4JsIjO/oJopjkT3y3Xztzf5U7tFjvQFei6DwA5lU8mjtre4E0JXtDQb2GCZ5Nfa9lde2vGA/oeak74nSCOAyBFe4FTot6PoMUrwWNqjfAzID8U7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtU/zHce; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtU/zHce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFDFC2BCB4;
	Tue,  5 May 2026 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005378;
	bh=ZJJSxi+SG+WjAIC6XgJEEg+tXlUO2jF2D9S6uRMTM2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OtU/zHcex5wjZqJ+vdpu6gIJPWag8vJM90xHCtj97uTm+NUryRr13PVyR85JOl2mh
	 +lnTye0XVDVwgvVKWk1NQ7hybLYNZtLOT9hA/VyA/r2ajk8EMzCDDAdKbyBAhnw9jK
	 HH/I97yT8xYSpflNyZAs3D1yRjoPG5cNOIjTafxwAYzfqbQtyhx3wWej/j1Y5+JgWP
	 N1AhzPfEt9/pj0bKUVFy6Dp+AU3WTpFRn0a+e2Zffy8EfuGbzUJS4JsyVfYY43wbmM
	 FZq+pMemmx8phnav0BYle8kRy1uWF1ewUVwTOavk21PuMCjjRXp6psRhzZ7H99okKZ
	 ASmMQzuLCGJ/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 09/13] net: lan966x: add PCIe FDMA support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-lan966x-pci-fdma-v3-9-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-9-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:58 +0000
Message-Id: <20260505182258.CFFDFC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Unconditional freeing of SKB in `lan966x_fdma_pci_xmit` causes=
 a Use-After-Free if PTP hardware timestamping is enabled.
- [Critical] Freed SKB used in `lan966x_fdma_pci_rx_get_frame()` after `lan=
966x_hw_offload()` internally drops it, leading to a Use-After-Free.
- [High] PCIe TX path transmits uninitialized host memory due to incorrect =
`BLOCKL` calculation, causing an information leak.
- [High] RX buffer limit (`DATAL`) allows hardware to DMA write past the al=
located buffer space, and bounds checks allow out-of-bounds memcpy.
--

commit 85d5f2d6dafac0733149c1d102524b3671cf0bef
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA support

Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
transfer instead of per-page DMA mappings.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 0000000000000..2c54880460772
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> @@ -0,0 +1,383 @@
> +// SPDX-License-Identifier: GPL-2.0+

[ ... ]

> +static int lan966x_fdma_pci_rx_alloc(struct lan966x_rx *rx)
> +{
> +	struct lan966x *lan966x =3D rx->lan966x;
> +	struct fdma *fdma =3D &rx->fdma;
> +	int err;
> +
> +	err =3D fdma_alloc_coherent_and_map(lan966x->dev, fdma, &lan966x->atu);
> +	if (err)
> +		return err;
> +
> +	fdma_dcbs_init(fdma,
> +		       FDMA_DCB_INFO_DATAL(fdma->db_size),
> +		       FDMA_DCB_STATUS_INTR);

The DMA pointer given to hardware via fdma_dataptr_dma_addr_contiguous() is
offset by XDP_PACKET_HEADROOM. If we provide a DATAL limit of fdma->db_size,
won't a maximum-sized frame cause the hardware to write XDP_PACKET_HEADROOM
bytes past the end of the allocated DB space?

[ ... ]

> +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *s=
rc_port)
> +{
> +	struct lan966x *lan966x =3D rx->lan966x;
> +	struct fdma *fdma =3D &rx->fdma;
> +	struct lan966x_port *port;
> +	struct fdma_db *db;
> +	void *virt_addr;
> +	u32 blockl;
> +
> +	/* virt_addr points to the IFH. */
> +	virt_addr =3D fdma_dataptr_virt_addr_contiguous(fdma,
> +						      fdma->dcb_index,
> +						      fdma->db_index);
> +
> +	lan966x_ifh_get_src_port(virt_addr, src_port);
> +
> +	if (WARN_ON(*src_port >=3D lan966x->num_phys_ports))
> +		return FDMA_ERROR;
> +
> +	port =3D lan966x->ports[*src_port];
> +	if (!port)
> +		return FDMA_ERROR;
> +
> +	db =3D fdma_db_next_get(fdma);
> +
> +	/* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
> +	 * values before they feed memcpy/XDP sizes.
> +	 */
> +	blockl =3D FDMA_DCB_STATUS_BLOCKL(db->status);
> +	if (blockl < IFH_LEN_BYTES + ETH_FCS_LEN || blockl > fdma->db_size)

If blockl is greater than fdma->db_size - XDP_PACKET_HEADROOM, won't the
subsequent memcpy() in lan966x_fdma_pci_rx_get_frame() read out-of-bounds
into the next DB's memory?

[ ... ]

> +static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *=
rx,
> +						     u64 src_port)
> +{
> +	struct lan966x *lan966x =3D rx->lan966x;
> +	struct fdma *fdma =3D &rx->fdma;
> +	struct sk_buff *skb;
> +	struct fdma_db *db;
> +	u32 data_len;
> +
> +	/* Get the received frame and create an SKB for it. */
> +	db =3D fdma_db_next_get(fdma);
> +	data_len =3D FDMA_DCB_STATUS_BLOCKL(db->status);
> +
> +	skb =3D napi_alloc_skb(&lan966x->napi, data_len);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	memcpy(skb->data,
> +	       fdma_dataptr_virt_addr_contiguous(fdma,
> +						 fdma->dcb_index,
> +						 fdma->db_index),
> +						 data_len);
> +
> +	skb_put(skb, data_len);
> +
> +	skb->dev =3D lan966x->ports[src_port]->dev;
> +	skb_pull(skb, IFH_LEN_BYTES);
> +
> +	skb_trim(skb, skb->len - ETH_FCS_LEN);
> +
> +	skb->protocol =3D eth_type_trans(skb, skb->dev);
> +
> +	if (lan966x->bridge_mask & BIT(src_port)) {
> +		skb->offload_fwd_mark =3D 1;
> +
> +		skb_reset_network_header(skb);
> +		if (!lan966x_hw_offload(lan966x, src_port, skb))
> +			skb->offload_fwd_mark =3D 0;

If lan966x_hw_offload() internally frees the SKB (for instance, if
skb_vlan_untag() fails) and returns false, won't this pointer dereference
cause a use-after-free here, and again when updating skb->dev->stats?

> +	}
> +
> +	skb->dev->stats.rx_bytes +=3D skb->len;
> +	skb->dev->stats.rx_packets++;
> +
> +	return skb;
> +}
> +
> +static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
> +				 struct net_device *dev)
> +{
> +	struct lan966x_port *port =3D netdev_priv(dev);
> +	struct lan966x *lan966x =3D port->lan966x;
> +	struct lan966x_tx *tx =3D &lan966x->tx;
> +	struct fdma *fdma =3D &tx->fdma;
> +	int next_to_use;
> +	void *virt_addr;
> +
> +	next_to_use =3D lan966x_fdma_pci_get_next_dcb(fdma);
> +
> +	if (next_to_use < 0) {
> +		netif_stop_queue(dev);
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	if (skb_put_padto(skb, ETH_ZLEN)) {
> +		dev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}
> +
> +	if (!lan966x_fdma_pci_tx_size_fits(fdma, skb->len)) {
> +		dev_kfree_skb_any(skb);
> +		dev->stats.tx_dropped++;
> +		return NETDEV_TX_OK;
> +	}
> +
> +	skb_tx_timestamp(skb);
> +
> +	/* virt_addr points to the IFH. */
> +	virt_addr =3D fdma_dataptr_virt_addr_contiguous(fdma, next_to_use, 0);
> +	memcpy(virt_addr, ifh, IFH_LEN_BYTES);
> +	memcpy(virt_addr + IFH_LEN_BYTES, skb->data, skb->len);
> +
> +	/* Order frame write before DCB status write below. */
> +	dma_wmb();
> +
> +	fdma_dcb_add(fdma,
> +		     next_to_use,
> +		     0,
> +		     FDMA_DCB_STATUS_INTR |
> +		     FDMA_DCB_STATUS_SOF |
> +		     FDMA_DCB_STATUS_EOF |
> +		     FDMA_DCB_STATUS_BLOCKO(0) |
> +		     FDMA_DCB_STATUS_BLOCKL(IFH_LEN_BYTES + skb->len + ETH_FCS_LEN));

Since we only copy IFH_LEN_BYTES + skb->len bytes to the DMA buffer, but we
configure the hardware BLOCKL to include ETH_FCS_LEN (4 extra bytes), could
the PCIe endpoint transmit uninitialized memory from previous packets
because the contiguous DMA buffers are reused?

> +
> +	/* Start the transmission. */
> +	lan966x_fdma_tx_start(tx);
> +
> +	dev->stats.tx_bytes +=3D skb->len;
> +	dev->stats.tx_packets++;
> +
> +	/* Safe to free: the PCIe DTBO does not enable the PTP interrupt,
> +	 * so lan966x->ptp stays 0 and lan966x_port_xmit() never enqueues
> +	 * this skb on port->tx_skbs for a TX timestamp.
> +	 */
> +	dev_consume_skb_any(skb);

If a device tree does provide the 'ptp' IRQ, PTP will be enabled and
lan966x_port_xmit() will enqueue the SKB for hardware timestamping before
reaching this code. In that case, won't this unconditional
dev_consume_skb_any() free the SKB while it is still queued, leading to a
use-after-free when the PTP IRQ handler later processes it?

> +
> +	return NETDEV_TX_OK;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-lan966x-pc=
i-fdma-v3-0-a56f5740d870@microchip.com?part=3D9
