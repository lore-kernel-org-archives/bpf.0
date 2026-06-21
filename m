Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3443B21ABC9
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 21:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078341; cv=none; b=CCF7NfQZpKaQq1v/O+ANRUv4MzFmuDUF8FFo/tNYSSzpZlHj/uEMeVmVpub/XsIlVGLBgaBvmDY1zkt8sE3LvrnNNoiN2BVw3G6aKuwHRV97Kn/hL+ti8pXvanuxjcwv7QvWJfB+hRckllGmLOy1T22sIsYnUsheaO8bESv9Zos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078341; c=relaxed/simple;
	bh=peCGx/sS3Kf6fK9KdC9y6l+wk2BOZjR5hrCkmU9WPhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xy1yv1FuGKefPLaddYwgKEh6+t0/TnuGd9aVv3NeTirVcXhWy3/ZiR9vHRD1rulluewyHfVTL+ma89vUwTExYBTKOhFJC0lJ8v3MWZ7awDoXnch2Cnb5OvoUNovpG/AYSRPBr2TsWQ4QD0LKzsWeG4lszAILw0+4rhJmhZrK9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaI65Ecy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaI65Ecy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F701F000E9;
	Sun, 21 Jun 2026 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078339;
	bh=kjyYL3VTOkSLnLim4LczAfBB9y8KM+eYBI026k/51H0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RaI65EcyhkNEthMJee75Ls3kdD9zwiM/O1s+/TuIJgepghZfCdA8BURq+hoZ2yG9+
	 C87tBpjtq9r7SnyVGdfI0KxHnNe0InHGu3UsQlmoBLYVEpE6zkozutkV2FHnjeOh9H
	 l+acjiBS8sGJWDrWunHi8/qwwjAeCUgXnCQhcgoO8m/mUqCUxbjsv0OSD5I/Q+IWI7
	 99j6Ojnx16MiOf+pHna9RPTYJF9JXkwqUayYK2KfH6NWcqMcROQvMl72pswXEIyZG9
	 NTDaLiL/dwRYsDm1G7Y3zVUhGDR/bt2HrvoGAjQNL9IT3gP6ZqxXmJmU/+JPdYyeK6
	 n6wycPQ+SV4wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: ti: icssg-prueth: fix XDP_TX from the AF_XDP
 zero-copy RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620213756.87499-1-devnexen@gmail.com>
References: <20260620213756.87499-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 21:45:39 +0000
Message-Id: <20260621214539.B7F701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] On XDP_TX transmission failure in AF_XDP zero-copy mode, the d=
river double-frees the original `xsk_buff` and leaks the newly allocated `x=
dp_frame` page.
- [Critical] The TX completion path unconditionally calls `dma_unmap_single=
()` on `PRUETH_SWDATA_XDPF` buffers, destroying the page pool's DMA mapping=
 and using a wrong offset address.
- [High] Error paths in `emac_xmit_xdp_frame()` pass uninitialized hardware=
 descriptors to `prueth_xmit_free()`, causing random/garbage addresses to b=
e unmapped.
- [High] The TX completion routine frees network buffers before unmapping t=
heir DMA mappings, creating a use-after-free pattern if bounce buffers are =
involved.
- [High] Missing DMA synchronization for page pool XDP_TX frames before tra=
nsmission.
--

commit fcfa7d9e02b3a0f883c4feee8ec375b550885d7d
Author: David Carlier <devnexen@gmail.com>

    net: ti: icssg-prueth: fix XDP_TX from the AF_XDP zero-copy RX path

    On XDP_TX from the zero-copy RX path, emac_run_xdp() converts the xsk
    buffer via xdp_convert_zc_to_xdp_frame(), which clones the data into a
    fresh MEM_TYPE_PAGE_ORDER0 page that is not DMA mapped. Transmitting it
    as PRUETH_TX_BUFF_TYPE_XDP_TX derives the DMA address with
    page_pool_get_dma_addr(), reading an uninitialized page->dma_addr, so
    the device DMAs from a bogus address (corrupt TX, or an IOMMU fault).

    Pick the TX buffer type from the frame's memory type: keep
    PRUETH_TX_BUFF_TYPE_XDP_TX for page_pool frames and use
    PRUETH_TX_BUFF_TYPE_XDP_NDO for the cloned zero-copy frame. The
    completion path already unmaps PRUETH_SWDATA_XDPF buffers.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index 82ddef9c17d54..302e700ea17d8 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -826,11 +827,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, s=
truct xdp_buff *xdp, u32 *len
>  			goto drop;
>  		}
> =20
> +		/* In AF_XDP zero-copy mode xdp_convert_buff_to_frame()
> +		 * clones the xsk buffer into a fresh MEM_TYPE_PAGE_ORDER0
> +		 * page that is not DMA mapped. Such a frame must be mapped
> +		 * via the NDO path; only a page pool-backed frame already
> +		 * carries a usable page_pool DMA address.
> +		 */
> +		tx_buff_type =3D xdpf->mem_type =3D=3D MEM_TYPE_PAGE_POOL ?
> +				PRUETH_TX_BUFF_TYPE_XDP_TX :
> +				PRUETH_TX_BUFF_TYPE_XDP_NDO;
> +
>  		q_idx =3D cpu % emac->tx_ch_num;
>  		netif_txq =3D netdev_get_tx_queue(ndev, q_idx);
>  		__netif_tx_lock(netif_txq, cpu);
>  		result =3D emac_xmit_xdp_frame(emac, xdpf, q_idx,
> -					     PRUETH_TX_BUFF_TYPE_XDP_TX);
> +					     tx_buff_type);

[Severity: Critical]
This is a pre-existing issue, but does emac_xmit_xdp_frame() mark page pool
frames with a type that triggers an unconditional unmap?

In emac_xmit_xdp_frame(), PRUETH_TX_BUFF_TYPE_XDP_TX frames are marked
as PRUETH_SWDATA_XDPF:

emac_xmit_xdp_frame() {
    ...
    if (buff_type =3D=3D PRUETH_TX_BUFF_TYPE_XDP_TX) {
        buf_dma =3D page_pool_get_dma_addr(page);
        buf_dma +=3D xdpf->headroom + sizeof(struct xdp_frame);
    }
    ...
    swdata =3D cppi5_hdesc_get_swdata(first_desc);
    swdata->type =3D PRUETH_SWDATA_XDPF;
    ...
}

Then in the completion path, prueth_xmit_free() unconditionally unmaps them:

prueth_xmit_free() {
    ...
    if (swdata->type =3D=3D PRUETH_SWDATA_XDPF) {
        dma_unmap_single(tx_chn->dma_dev, buf_dma, buf_dma_len, DMA_TO_DEVI=
CE);
    }
    ...
}

Does this unmap the page pool-owned DMA address using an offset address,
destroying the mapping and potentially causing an IOMMU fault when the page
is recycled?


[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
emac_xmit_xdp_frame() unmap garbage addresses?

If virt_to_head_page() or dma_map_single() fails early in
emac_xmit_xdp_frame(), the code jumps to drop_free_descs before first_desc
is fully initialized:

emac_xmit_xdp_frame() {
    first_desc =3D k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
    ...
    if (unlikely(!page)) {
        goto drop_free_descs;
    }
    ...
drop_free_descs:
    prueth_xmit_free(tx_chn, first_desc);
    return ICSSG_XDP_CONSUMED;
}

Since k3_cppi_desc_pool_alloc() doesn't zero memory, could prueth_xmit_free=
()
read an uninitialized swdata->type and unmap a random buf_dma address?


[Severity: High]
This is a pre-existing issue, but does emac_xmit_xdp_frame() fail to sync t=
he
DMA buffer for the device?

For PRUETH_TX_BUFF_TYPE_XDP_TX, it retrieves the page pool DMA address:

emac_xmit_xdp_frame() {
    if (buff_type =3D=3D PRUETH_TX_BUFF_TYPE_XDP_TX) {
        buf_dma =3D page_pool_get_dma_addr(page);
    ...
}

Because XDP packet modifications reside in the CPU cache and the driver uses
DMA_BIDIRECTIONAL mappings, is a dma_sync_single_for_device() call required
here to ensure the hardware transmits the modified data instead of stale
content?


[Severity: High]
This isn't a bug introduced by this patch, but does the TX completion path
free the buffer before unmapping it?

In emac_tx_complete_packets():

emac_tx_complete_packets() {
    ...
    xdp_return_frame(xdpf);
    ...
    prueth_xmit_free(tx_chn, desc_tx);
    ...
}

Since prueth_xmit_free() performs dma_unmap_single(), does this free the me=
mory
back to the allocator before the DMA mapping is torn down?

If bounce buffers are used, could this allow the memory to be reallocated
and re-mapped while the previous unmap is incomplete?

>  		__netif_tx_unlock(netif_txq);
>  		if (result =3D=3D ICSSG_XDP_CONSUMED) {
>  			ndev->stats.tx_dropped++;
>  			goto drop;

[Severity: Critical]
This is a pre-existing issue, but does the error path cause a double-free a=
nd
a memory leak when XDP_TX fails in zero-copy mode?

When emac_run_xdp() processes an XDP_TX, it converts the buffer:

emac_run_xdp() {
    ...
    case XDP_TX:
        xdpf =3D xdp_convert_buff_to_frame(xdp);
    ...
}

In AF_XDP zero-copy mode, xdp_convert_zc_to_xdp_frame() allocates a new page
and frees the original xdp buffer.

If emac_xmit_xdp_frame() fails, it returns ICSSG_XDP_CONSUMED and jumps to
the drop label:

        if (result =3D=3D ICSSG_XDP_CONSUMED) {
            ndev->stats.tx_dropped++;
            goto drop;
        }
    ...
drop:
    ...
    case XDP_DROP:
        ndev->stats.rx_dropped++;
        return ICSSG_XDP_CONSUMED;

The return value ICSSG_XDP_CONSUMED propagates to emac_rx_packet_zc(), which
then frees the buffer again:

emac_rx_packet_zc() {
    ...
    ret =3D emac_run_xdp(emac, (struct xdp_buff *)xdp, &pkt_len);
    ...
    switch (ret) {
    case ICSSG_XDP_CONSUMED:
        xsk_buff_free(xdp);
        break;
    ...
}

Does this leak the newly allocated xdpf page and perform a double-free on t=
he
original xdp buffer?

>  		}
> =20
>  		dev_sw_netstats_rx_add(ndev, xdpf->len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620213756.8749=
9-1-devnexen@gmail.com?part=3D1
