Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58E4E8E13
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366353; cv=none; b=ANq+13tpv8bcMNxfv/Nhs9MDIZF7YB864xQEqVsDfA8V3o+Hm7T/bcGV69DF2Scq2k8vqq65tccP2d4exmV1iSbXsaX3ZZPEt4qrhblouGNRDaIGgMIC3dlYNVQ0x9hEItdNaeou1GpKoEApy9Jswq9mJGilPpEyKK9jwrwy7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366353; c=relaxed/simple;
	bh=EfMMg46roFyGVjmbcpoZSeiOSEomsPYOyBNPXvzYnEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YFxW5xhQLVw8+V8jO+3FuhDV5RrgAo32cpJXnW5Uw72IJdMEPa1k8TvzWKUdxzyP1eWgXwzsUzAbACH5l3w4tmfwsAxRcIOfINX+llW4rBdANpj71SpTi3wk68kSwWow0QHgeGGDK+mHUYFN4yV7l18UNTnc/NN8l0B5WzIhpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWrDS+jk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWrDS+jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A37D1F00893;
	Fri, 25 Sep 2026 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366351;
	bh=vnqcTIiP4vu5De8ns1OFYudyiVXRe5A4jMQe++SrPIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KWrDS+jkvequaybjUAIMlm/eOOw8jUJ6ZF/khEpkcacv5sSYHv3syX7u7jQfw+Xoe
	 LJD+RUoQkTiUp9KxGNiqXOfUdxRf5L6m6YVqD1u3Ufl/HKr5Im4Hvenz1g3IE9uDiR
	 SVrOaY+0IwW+hHn8GBbxSfeAoKgwGM0I9px9/SuNvbUFwpc7HSGlxJrMfBRB2de6bN
	 qgd2gtrEl1qRym/28+u/Xu9DtyCwABqQ39jNk+eutR8d8LhiWxkVS7JPSOBFatTmEZ
	 ctLESx6C28H7axmeuvf/2x4WbbpekA/WXzRwU7cC2hRMAw4lwQyQ/wU2mOTzKgcPpu
	 cHHgYa67aW1Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 11/15] net: lan966x: add PCIe FDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260924-lan966x-pci-fdma-v8-11-201c7b707d8b@microchip.com>
References: <20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com>
 <20260924-lan966x-pci-fdma-v8-11-201c7b707d8b@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:59:10 +0000
Message-Id: <20260925195911.5A37D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] net: lan966x: missing NAPI initialization in PCIe FDMA path
- [Medium] net: lan966x: RX descriptor ring reload failure when wrap occurs
- [Low] net: lan966x: DMA engine reads uninitialized memory due to FCS padd=
ing
--

commit b0974995ea3ce44150d8f413eb0f917b2dc37e02
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA support

This commit adds PCIe FDMA support for the lan966x driver, mapping=20
contiguous DMA buffers through the endpoint's ATU. The new path replaces=20
per-page DMA mappings with memcpy-based frame transfers. This significantly=
=20
improves throughput over register-based I/O on PCIe cards.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 0000000000000..bccd1b8590d74
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> @@ -0,0 +1,421 @@

[ ... ]

> +static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
> +				 struct net_device *dev)
> +{

[ ... ]

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

[Severity: Low]
Does the DMA engine read uninitialized host memory here?

The CPU copies skb->len bytes to the contiguous buffer, but the hardware DCB
is programmed to read skb->len + ETH_FCS_LEN bytes. Even though the hardware
likely overwrites the extra 4 bytes with its own FCS internally so it does
not leak onto the wire, this still instructs the DMA to perform an
out-of-bounds read past the initialized region of the host buffer.

[ ... ]

> +static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weig=
ht)
> +{
> +	struct lan966x *lan966x =3D container_of(napi, struct lan966x, napi);
> +	struct lan966x_rx *rx =3D &lan966x->rx;
> +	struct fdma *fdma =3D &rx->fdma;
> +	int dcb_reload, old_dcb;
> +	struct sk_buff *skb;
> +	int counter =3D 0;
> +	u64 src_port;
> +
> +	/* Wake any stopped TX queues if a TX DCB is available. */
> +	spin_lock(&lan966x->tx_lock);
> +	if (lan966x_fdma_pci_get_next_dcb(&lan966x->tx.fdma) >=3D 0)
> +		lan966x_fdma_wakeup_netdev(lan966x);
> +	spin_unlock(&lan966x->tx_lock);
> +
> +	dcb_reload =3D fdma->dcb_index;
> +
> +	/* Get all received skbs. */
> +	while (counter < weight) {
> +		if (!fdma_has_frames(fdma))
> +			break;

[ ... ]

> +		skb =3D lan966x_fdma_pci_rx_get_frame(rx, src_port);
> +		fdma_dcb_advance(fdma);
> +		if (!skb) {
> +			lan966x->ports[src_port]->dev->stats.rx_dropped++;
> +			continue;
> +		}
> +
> +		napi_gro_receive(&lan966x->napi, skb);
> +	}
> +	while (dcb_reload !=3D fdma->dcb_index) {

[Severity: Medium]
Could this loop condition fail to reload the ring if exactly fdma->n_dcbs
frames are processed during a single poll iteration?

If counter reaches fdma->n_dcbs, fdma->dcb_index will wrap completely
around and equal the cached dcb_reload value. The reload loop condition
would evaluate to false immediately, meaning zero descriptors are replenish=
ed.

This would leave the hardware ring marked as done and could cause the driver
to re-process the exact same frames on the next NAPI iteration.

> +		old_dcb =3D dcb_reload;
> +		dcb_reload++;
> +		dcb_reload &=3D fdma->n_dcbs - 1;
> +
> +		fdma_dcb_add(fdma,
> +			     old_dcb,
> +			     FDMA_DCB_INFO_DATAL(fdma->db_size - XDP_PACKET_HEADROOM),
> +			     FDMA_DCB_STATUS_INTR);
> +
> +		lan966x_fdma_rx_reload(rx);
> +	}

[ ... ]

> +static int lan966x_fdma_pci_init(struct lan966x *lan966x)
> +{
> +	struct fdma *rx_fdma =3D &lan966x->rx.fdma;
> +	struct fdma *tx_fdma =3D &lan966x->tx.fdma;
> +	int err;
> +
> +	if (!lan966x->fdma)
> +		return 0;

[ ... ]

> +	tx_fdma->ops.nextptr_cb =3D &lan966x_fdma_pci_nextptr_cb;
> +	tx_fdma->ops.dataptr_cb =3D &lan966x_fdma_pci_dataptr_cb;
> +
> +	err =3D lan966x_fdma_pci_rx_alloc(&lan966x->rx);
> +	if (err)
> +		return err;

[Severity: High]
Is there a missing NAPI initialization in this path?

In the standard FDMA initialization path, lan966x->napi is initialized using
netif_napi_add(). Here, lan966x_fdma_pci_init sets up the PCIe FDMA path
entirely but appears to omit the NAPI struct initialization.

When the first RX/TX interrupt fires, lan966x_fdma_irq_handler will blindly
call napi_schedule(&lan966x->napi). Because the struct is zero-initialized
and not properly registered, this would lead to a kernel panic when the
softirq handler tries to invoke napi->poll().

> +
> +	err =3D lan966x_fdma_pci_tx_alloc(&lan966x->tx);
> +	if (err) {
> +		fdma_free_coherent_and_unmap(lan966x->dma_dev, rx_fdma);
> +		return err;
> +	}
> +
> +	lan966x_fdma_rx_start(&lan966x->rx);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-lan966x-pc=
i-fdma-v8-0-201c7b707d8b@microchip.com?part=3D11
