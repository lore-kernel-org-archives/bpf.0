Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132926E173
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101878; cv=none; b=hsSlWqMe3E5lXgRcXEM92sUmmF3ruw2ZJrEydSL1c7uATazB2OYZS/BCEcBOuwEuz3RNddGgUIPZo24c4NlOt5k8qu0w+QsX8lo9g6X2ou24hmvtenudoStzjvNvmACcfrDB7eJ9rGp6t6aq/iwQsc1ZDEAB50uGM9yVzUtnSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101878; c=relaxed/simple;
	bh=vkeUrn1eYtcu2UpGtNY1UD0TS5zCpnPwvmBMFE0pnvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vB+zXA8rkhiyU+zONcCQnnc9k1n3jMW3QDPwrdL9myAUQpP20MrICn1rs0hWMJxjcJOiTp63tSssY1uAcAHZdSBPuphaPLCfG8omq9KX4BaVzRPlpjrsoz2FUeJhrHGAA5qLSg0u/6cOWAOLHiGQm0XQCX/6UpcHcgvGguGSo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+RYndxs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+RYndxs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74581F00899;
	Sat, 30 May 2026 00:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101876;
	bh=zPiBxHGRRlQnxaS6H+l8VZGuPaVPkgyJ6jZWqiWu/+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c+RYndxsijPyL9/bml+SMys/X45tv7JO6grWI7qyu7Ukn/XtJpxgcx1SWA/x+9x4C
	 ZMohlu6+9mJII32M4hCPyojAqfndWsn/m3mIT+JcXxQM7JZf2e1Pm2Unf1c/zqOnQN
	 L8u+z/kNZtVl2r7XAnElmXB9C9NeQiIycPorvIrtFmnSnUqj5pm93kwBJy3WRu7TCR
	 uzLqKoGeUq42XKOuez53I0TdomaQMFgeGGtsosa6u3z9usQhdnqHUhVfLkHC+Ka95E
	 qQNJme43W7kM1CwL0z7tmDB+B6U1EdOAIe1WTy9jOjWN1CTQ47l8WYqTbcnMzOh2ZF
	 IJ8POVyLSAOjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 09/13] net: lan966x: add PCIe FDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-lan966x-pci-fdma-v5-9-ca56197ae05b@microchip.com>
References: <20260520-lan966x-pci-fdma-v5-9-ca56197ae05b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:36 +0000
Message-Id: <20260530004436.C74581F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] The driver unconditionally exposes XDP features for the new PC=
Ie FDMA path, which lacks the required data structures, leading to a kernel=
 crash.
- [High] Unconditional freeing of SKBs in `lan966x_fdma_pci_xmit` causes a =
Use-After-Free if hardware timestamping (PTP) is enabled.
- [High] The DMA descriptor status (`db->status`) is fetched multiple times=
 from PCIe coherent memory, creating a Time-of-Check to Time-of-Use (TOCTOU=
) vulnerability that bypasses frame size validation.

Pre-existing issues:
- [High] Calling `lan966x_hw_offload()` can free the SKB if `skb_vlan_untag=
()` fails or reallocates it, leading to a Use-After-Free in the caller.
- [High] Missing `dma_wmb()` and incorrect assignment order in `__fdma_dcb_=
add()` leads to hardware ring corruption.
--

commit 120b358d3f4f3104d4b61923f6ff96cd2e8cc282
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA support

Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
transfer instead of per-page DMA mappings.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 0000000000000..c27d9e76e7358
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> @@ -0,0 +1,394 @@
> +// SPDX-License-Identifier: GPL-2.0+
[ ... ]
> +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *s=
rc_port)
> +{
[ ... ]
> +	db =3D fdma_db_next_get(fdma);
> +
> +	/* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
> +	 * values before they feed memcpy/XDP sizes.
> +	 */
> +	blockl =3D FDMA_DCB_STATUS_BLOCKL(db->status);
> +	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
> +		return FDMA_ERROR;
> +
> +	return FDMA_PASS;
> +}
> +
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

[Severity: High]
Does fetching db->status again here create a Time-of-Check to Time-of-Use
(TOCTOU) vulnerability?

The driver first calls lan966x_fdma_pci_rx_check_frame(), which reads
db->status from PCIe-accessible coherent memory and validates that the
BLOCKL frame size fits within the buffer.

Immediately after, it calls lan966x_fdma_pci_rx_get_frame(), which fetches
db->status again to determine data_len.

Could a compromised or buggy PCIe endpoint modify the status word between
these fetches, changing the frame size to a large value, bypassing the
validation, and causing an out-of-bounds memcpy()?

> +
> +	skb =3D napi_alloc_skb(&lan966x->napi, data_len);
[ ... ]
> +	if (lan966x->bridge_mask & BIT(src_port)) {
> +		skb->offload_fwd_mark =3D 1;
> +
> +		skb_reset_network_header(skb);
> +		if (!lan966x_hw_offload(lan966x, src_port, skb))
> +			skb->offload_fwd_mark =3D 0;
> +	}
> +
> +	skb->dev->stats.rx_bytes +=3D skb->len;

[Severity: High]
This isn't a bug introduced by this patch, but can lan966x_hw_offload() free
the SKB and lead to a Use-After-Free here?

lan966x_hw_offload() takes the skb pointer by value and calls
skb_vlan_untag(skb). If skb_vlan_untag() fails or needs to modify the VLAN
header (e.g., via skb_share_check() or skb_cow()), it frees the original SKB
and returns a new pointer or NULL.

However, because the SKB is passed by value, this caller retains the origin=
al
freed pointer. It then accesses skb->offload_fwd_mark, increments statistics
using skb->len, and passes the freed SKB to napi_gro_receive().

Does this cause a use-after-free when receiving VLAN-tagged packets while
bridging and IGMP snooping are enabled?

> +	skb->dev->stats.rx_packets++;
> +
> +	return skb;
> +}
[ ... ]
> +static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
> +				 struct net_device *dev)
> +{
[ ... ]
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

[Severity: High]
This is a pre-existing issue, but does fdma_dcb_add() lack a memory barrier
when linking the new DCB into the hardware ring?

In __fdma_dcb_add(), the driver links the new DMA Control Block (DCB) into =
the
hardware ring by updating last_dcb->nextptr before initializing the new DCB=
's
own nextptr and info fields:

drivers/net/ethernet/microchip/fdma/fdma_api.c:__fdma_dcb_add() {
    ...
	err =3D dcb_cb(fdma, dcb_idx, &fdma->last_dcb->nextptr);
    ...
	fdma->last_dcb =3D dcb;

	dcb->nextptr =3D FDMA_DCB_INVALID_DATA;
	dcb->info =3D info;
    ...
}

Furthermore, there is no dma_wmb() barrier between setting up the DBs and
linking the DCB.

Since the memory is coherent DMA memory, can the hardware immediately follow
the nextptr link and read uninitialized or stale info and nextptr values fr=
om
the new DCB, causing the DMA controller to process garbage data?

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

[Severity: High]
Can unconditionally freeing the SKB here cause a Use-After-Free if hardware
timestamping (PTP) is enabled?

If PTP is enabled via the device tree (setting lan966x->ptp to 1),
lan966x_port_xmit() enqueues the SKB to port->tx_skbs for hardware
timestamping before passing it to lan966x_fdma_pci_xmit().

However, dev_consume_skb_any(skb) frees the SKB unconditionally. When the P=
TP
TX timestamp interrupt later fires, lan966x_ptp_irq_handler() will traverse
the tx_skbs queue and dereference the freed SKB.

The comment explicitly relies on a specific Device Tree Overlay to keep PTP
disabled. Is it safe to rely on userspace not providing their own device tr=
ees
that enable PTP, which would lead to memory corruption?

> +
> +	return NETDEV_TX_OK;
> +}
[ ... ]
> +static int lan966x_fdma_pci_init(struct lan966x *lan966x)
> +{
[ ... ]
> +	err =3D lan966x_fdma_pci_rx_alloc(&lan966x->rx);
> +	if (err)
> +		return err;
> +
> +	err =3D lan966x_fdma_pci_tx_alloc(&lan966x->tx);

[Severity: Critical]
Does this PCIe FDMA path lack the required data structures for XDP, leading
to a kernel crash if XDP is attached?

Because lan966x->fdma is enabled, lan966x_probe_port() unconditionally expo=
ses
dev->xdp_features. If a user attaches an XDP program, lan966x_xdp_setup()
calls lan966x_fdma_reload_page_pool(), which falls back to the old MMIO
lan966x_fdma_rx_alloc() function instead of the new
lan966x_fdma_pci_rx_alloc().

This replaces the PCIe ATU-mapped coherent ring with an incompatible page_p=
ool
based ring without ATU mappings, destroying the DMA setup and potentially
causing IOMMU faults or memory corruption.

Furthermore, XDP_REDIRECT will crash because lan966x_fdma_pci_tx_alloc() do=
es
not allocate tx->dcbs_buf, resulting in a NULL pointer dereference in
lan966x_fdma_xmit_xdpf().

Is this regression addressed by the subsequent patch 'net: lan966x: add PCIe
FDMA XDP support' in the series?

> +	if (err) {
> +		fdma_free_coherent_and_unmap(lan966x->dev, rx_fdma);
> +		return err;
> +	}
> +
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-lan966x-pc=
i-fdma-v5-0-ca56197ae05b@microchip.com?part=3D9
