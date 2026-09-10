Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED063493D50
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045314; cv=none; b=tQFkdbwuGAhHcgxo4OkwNKF9dR9n2htZdRTlbp66QaIXeKN07GtLaRY06tfjooiJmikgw/90eolDJSORW2DrF5zxuWWGfzai9DtCY4tgIUSTKcBm5OHtQa4F7wGGnPziPqRVQahv0R4UR04w7psY8ednaEPu61NmlKmtGYW78iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045314; c=relaxed/simple;
	bh=JK/RiZmhnXLq+omzz7Zc/3lPSJVSSBt7XNhmzhpB6Hg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cE4dVlI7GZyYGBZHVfQQAmN5gyItWg72PolgBQz0m6lQ+YF3RaJOygD5HPy0OynKveaerkMonV4lfEwbi6VkJNhPo81oJrFtGK3J6+5o/vvmBAR0IkI3J/JivusS7O4dk0aRy4DwZV1656t0BB7aFCbDKWMGHwBhhe67zphY9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI9HBaXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI9HBaXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BD21F00899;
	Thu, 10 Sep 2026 13:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045311;
	bh=6C2z09PCtPoIAkjhTLhPlrKf3NKvxPM1v/k4ysgOZq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iI9HBaXptWa0FxFNmazc6hLTfBMBhxi5Vq8mBnvpJzn9uEU8uaXOuCIh99FZDHNa7
	 n5uhgzXg8V2li/MUbdQTu7BT3I42/dfYAqZXfRV/CRw/qfokltdwSOG2RWM/FE3lXk
	 TTMDAX2gZDcgHdJWoU1iv96Oj2Af304suB6NIMmCBqyCSrlpRdpBLquRG803D+/GYZ
	 kIf3uYIJ4xwJjbjfa8zX53jgKhio0MM4AKq1rDCi/6XSsW5m5PUXpOP5lKSWanEs++
	 ARly/xCPqFzdNoudJRIF8QbmWEZaoHFgJpCx09Z9eaHTMHJtu0ZRfgrf7KZkqi+ck4
	 D3f1Vdo0ns0kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 06/14] net: lan966x: use a dedicated device
 for DMA operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909-lan966x-pci-fdma-v6-6-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
 <20260909-lan966x-pci-fdma-v6-6-6f48dab9d671@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:01:50 +0000
Message-Id: <20260910130151.13BD21F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of xdp_frame on DMA mapping error or insufficient head=
room in lan966x_fdma_xmit_xdpf().
- [High] Unchecked failure of fdma_dcbs_init() leaves pages unallocated and=
 leads to a NULL pointer dereference during cleanup.
- [High] Double addition of XDP_PACKET_HEADROOM causes the IFH and packet s=
tart to skip DMA synchronization for CPU.
- [High] Transmitting an xdpf frame uses a corrupted DMA address, leading t=
o transmission of random memory and IOMMU faults.
- [High] Cross-pool page corruption when recycling XDP_TX pages after an MT=
U change.
- [High] XDP_TX completely ignores XDP program packet adjustments (length a=
nd offset).
--

commit 911b52e69be420fb557cf5f643980df6f6523c6c
Author: Daniel Machon <daniel.machon@microchip.com>
Subject: net: lan966x: use a dedicated device for DMA operations

In preparation for the PCIe FDMA implementation, this commit adds a
lan966x->dma_dev pointer and resolves it at probe time. The new pointer
is then used for every DMA operation in the FDMA path. Natively, this is
just lan966x->dev, so there is no functional change for non-PCIe devices.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/driv=
ers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -126,7 +126,7 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *r=
x)
>  	if (err)
>  		return err;
> =20
> -	err =3D fdma_alloc_coherent(lan966x->dev, fdma);
> +	err =3D fdma_alloc_coherent(lan966x->dma_dev, fdma);
>  	if (err) {
>  		page_pool_destroy(rx->page_pool);
>  		return err;
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed that fdma_dcbs_init() is called
further down in lan966x_fdma_rx_alloc() without checking its return value.

If page_pool_dev_alloc_pages() fails inside lan966x_fdma_rx_dataptr_cb(),
fdma_dcbs_init() will return -ENOMEM. Because the error is ignored, device
initialization incorrectly succeeds while rx->page[dcb][db] is left as NULL.

Later, when lan966x_fdma_rx_free_pages() is called during an MTU change or
driver unload, it passes these NULL pointers to page_pool_put_full_page():

    for (j =3D 0; j < fdma->n_dbs; ++j)
        page_pool_put_full_page(rx->page_pool, rx->page[i][j], false);

Could this cause a NULL pointer dereference and system crash?

[ ... ]

> @@ -355,7 +355,7 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x =
*lan966x, int weight)
> =20
>  		dcb_buf->used =3D false;
>  		if (dcb_buf->use_skb) {
> -			dma_unmap_single(lan966x->dev,
> +			dma_unmap_single(lan966x->dma_dev,
>  					 dcb_buf->dma_addr,
>  					 dcb_buf->len,
>  					 DMA_TO_DEVICE);
> @@ -364,7 +364,7 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x =
*lan966x, int weight)
>  				napi_consume_skb(dcb_buf->data.skb, weight);
>  		} else {
>  			if (dcb_buf->xdp_ndo)
> -				dma_unmap_single(lan966x->dev,
> +				dma_unmap_single(lan966x->dma_dev,
>  						 dcb_buf->dma_addr,
>  						 dcb_buf->len,
>  						 DMA_TO_DEVICE);

[Severity: High]
This isn't a bug introduced by this patch, but does recycling XDP_TX pages
here risk cross-pool page corruption when the MTU changes?

During an MTU change in lan966x_fdma_reload(), a new page pool is created
for RX, and the old one is destroyed. However, the TX channel remains activ=
e.
If there are in-flight XDP_TX frames, they will trigger a TX interrupt and
reach the cleanup branch that recycles pages into the current rx->page_pool:

    page_pool_recycle_direct(rx->page_pool, dcb_buf->data.page);

Since the rx->page_pool pointer was updated by the MTU reload, wouldn't this
incorrectly insert pages allocated from the old pool into the new pool's ca=
che,
violating page pool API semantics?

[ ... ]

> @@ -400,7 +400,7 @@ static int lan966x_fdma_rx_check_frame(struct lan966x=
_rx *rx, u64 *src_port)
>  	if (unlikely(!page))
>  		return FDMA_ERROR;
> =20
> -	dma_sync_single_for_cpu(lan966x->dev,
> +	dma_sync_single_for_cpu(lan966x->dma_dev,
>  				(dma_addr_t)db->dataptr + XDP_PACKET_HEADROOM,
>  				FDMA_DCB_STATUS_BLOCKL(db->status),
>  				DMA_FROM_DEVICE);

[Severity: High]
This is a pre-existing issue, but does adding XDP_PACKET_HEADROOM here
cause the IFH to miss DMA synchronization?

During initialization, lan966x_fdma_rx_dataptr_cb() sets db->dataptr to
already include the headroom offset:

    *dataptr =3D page_pool_get_dma_addr(page) + XDP_PACKET_HEADROOM;

By adding XDP_PACKET_HEADROOM again in dma_sync_single_for_cpu(), the
synchronized region skips the first bytes of the packet data. Could this
cause lan966x_ifh_get_src_port() to read the IFH from a stale un-synchroniz=
ed
CPU cache?

[ ... ]

> @@ -635,11 +635,11 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *por=
t, void *ptr, u32 len)
>  		lan966x_ifh_set_bypass(ifh, 1);
>  		lan966x_ifh_set_port(ifh, BIT_ULL(port->chip_port));
> =20
> -		dma_addr =3D dma_map_single(lan966x->dev,
> +		dma_addr =3D dma_map_single(lan966x->dma_dev,
>  					  xdpf->data - IFH_LEN_BYTES,
>  					  xdpf->len + IFH_LEN_BYTES,
>  					  DMA_TO_DEVICE);
> -		if (dma_mapping_error(lan966x->dev, dma_addr)) {
> +		if (dma_mapping_error(lan966x->dma_dev, dma_addr)) {
>  			ret =3D NETDEV_TX_OK;
>  			goto out;
>  		}

[Severity: High]
This is a pre-existing issue, but does this error path leak the XDP frame?

If dma_mapping_error() triggers (or if xdpf->headroom < IFH_LEN_BYTES fails
just above this snippet), the function returns NETDEV_TX_OK without freeing
the frame. The caller, lan966x_xdp_xmit(), sees a successful return and won=
't
clean up the frame either, leading to memory leaks under load.

[Severity: High]
This isn't a bug introduced by this patch, but does the DMA address get
corrupted during transmission for xdpf frames?

Here, the dma_addr points exactly to the start of the mapped data. However,
when lan966x_fdma_xdp_tx_dataptr_cb() is invoked to set the transmission
pointer, it unconditionally adds the headroom offset again:

    *dataptr =3D lan966x->tx.dcbs_buf[dcb].dma_addr + XDP_PACKET_HEADROOM;

For xdpf frames, this shifts the start address far past the mapped buffer,
causing the hardware to read unmapped memory and trigger IOMMU faults.

[ ... ]

> @@ -655,7 +655,7 @@ int lan966x_fdma_xmit_xdpf(struct lan966x_port *port,=
 void *ptr, u32 len)
>  		lan966x_ifh_set_port(ifh, BIT_ULL(port->chip_port));
> =20
>  		dma_addr =3D page_pool_get_dma_addr(page);
> -		dma_sync_single_for_device(lan966x->dev,
> +		dma_sync_single_for_device(lan966x->dma_dev,
>  					   dma_addr + XDP_PACKET_HEADROOM,
>  					   len + IFH_LEN_BYTES,
>  					   DMA_TO_DEVICE);

[Severity: High]
This is a pre-existing issue, but does the XDP_TX path ignore XDP program
packet adjustments?

When the XDP program returns XDP_TX in lan966x_xdp_run(), it passes the
original unmodified data length to lan966x_fdma_xmit_xdpf(). Then, for
page-based transmits, the driver unconditionally writes the IFH at a fixed
offset:

    ifh =3D page_address(page) + XDP_PACKET_HEADROOM;

If the XDP program adjusted the packet length or offset (via
bpf_xdp_adjust_head or bpf_xdp_adjust_tail), the IFH will be written to
the wrong location, and the unmodified packet will be transmitted instead.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-lan966x-pc=
i-fdma-v6-0-6f48dab9d671@microchip.com?part=3D6
