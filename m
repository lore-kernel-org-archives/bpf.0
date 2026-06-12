Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24834332623
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290708; cv=none; b=JXnY844F98iQ9iwVsTWgOvccqYEep9WSWMnr7aj6IwoPF8/YwB4NZ7ILrRlWkdnCLa15qUfCJDRsHjMRQQgmp+T/3notqahi+YQBDwgHfwFfQpGXuMO/o6/gLwgVFOlzKVQU35f8vfif7a1N2szbP8wi0tsfOGcdyY3xgaFZO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290708; c=relaxed/simple;
	bh=cdzdTd+CqU8Pq5mUWI9iBScFWsv/Ja5TsKMV+4btFlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tlD7fU2ivpGJhDQkQwxhZJho8yvu8TN1WlwI4pt6WoIbddBn2OREYEhLkQQmOvbKktvI1Y3kDRzjrtN/2uaeB0qjJCTsoT5atPzLdygoIkMZc/PO981mRnfRFThgAzu0ovUC3Jt7Ippgunakyf38nUv67IjH107+jyTa2s0EJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc9Stvfd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc9Stvfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7071F000E9;
	Fri, 12 Jun 2026 18:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781290706;
	bh=UWRYoFn+ZoPozjewP12ianTfXnhBoNlAZzeVCGyu5Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lc9StvfdlJn3vRCy5L4HQ+6rV3oKXUQ5w1+m1hSDeuu4LpplCDue4nZRZqT3SCZGL
	 xf5WedWk3qn/X3mCbha/pXrBKTrh3Vww+Dmtb0ScygERI4gyv9Fe4NJj4L44ph06N/
	 Dk4LtxuMYV5QhEuzEzLz75Dy6Ns4TVBT1UQw+PkzI5erabekZQoPA+1E0z7CvuU4PK
	 Y2xTZN2TPG/C2WI57/ijkV02Cls+l2nCfypLG5XFmcZSYeSRZvUBf5aK1GKFQs7WVN
	 k/BvHCyKrFeM1keDJZwnn6DVKzAsLNJv71+U+HtOo9pMh5e47gBtCRIrZNDyC+pqn4
	 io35/fA4HM+Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/4] net: ti: icssg: Use undirected TX tag for
 native XDP in HSR offload mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Meghana Malladi" <m-malladi@ti.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611185744.2498070-3-m-malladi@ti.com>
References: <20260611185744.2498070-3-m-malladi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:58:26 +0000
Message-Id: <20260612185826.AF7071F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DMA Mapping / Page Pool Corruption
--

commit e56804b68dffcb60ec1826c1b1a00d1c6ff8b34b
Author: Meghana Malladi <m-malladi@ti.com>

net: ti: icssg: Use undirected TX tag for native XDP in HSR offload mode

This commit updates emac_xmit_xdp_frame() to set the correct destination
tag and tag insertion flags for XDP TX frames when in HSR offload mode.
This allows the PRU firmware to properly duplicate the frames and insert
the HSR sequence tag.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index 55a696912811f..ede32f266729e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c

[ ... ]

> @@ -737,9 +738,25 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
> =20
>  	/* set dst tag to indicate internal qid at the firmware which is at
>  	 * bit8..bit15. bit0..bit7 indicates port num for directed
> -	 * packets in case of switch mode operation
> +	 * packets in case of switch mode operation and port num 0
> +	 * for undirected packets in case of HSR offload mode.
> +	 *
> +	 * XDP_TX frames arrive on a slave port with the HSR tag already
> +	 * stripped by the PRU firmware.  Like skb TX via hsr0, they must
> +	 * be sent as undirected so the PRU duplicates them to both ports
> +	 * and re-inserts the HSR sequence tag.
>  	 */
> -	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx <<=
 8)));
> +	dst_tag_id =3D emac->port_id | (q_idx << 8);
> +
> +	if (emac->prueth->is_hsr_offload_mode &&
> +	    (ndev->features & NETIF_F_HW_HSR_DUP))
> +		dst_tag_id =3D PRUETH_UNDIRECTED_PKT_DST_TAG;
> +
> +	if (emac->prueth->is_hsr_offload_mode &&
> +	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
> +		epib[1] |=3D PRUETH_UNDIRECTED_PKT_TAG_INS;
> +
> +	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);

[Severity: High]
This is a pre-existing issue, but is it possible that prueth_xmit_free()
inadvertently destroys the persistent DMA mapping managed by the page pool
for XDP_TX frames?

In emac_xmit_xdp_frame(), when an XDP frame is transmitted via XDP_TX, it
reuses the page pool's pre-existing DMA address without creating a new mapp=
ing:

    if (buff_type =3D=3D PRUETH_TX_BUFF_TYPE_XDP_TX) {
        page =3D virt_to_head_page(xdpf->data);
        ...
        buf_dma =3D page_pool_get_dma_addr(page);
        buf_dma +=3D xdpf->headroom + sizeof(struct xdp_frame);
    } else {
        buf_dma =3D dma_map_single(...);

However, during TX completion or error handling, prueth_xmit_free()
unconditionally calls dma_unmap_single() on the buffer for PRUETH_SWDATA_XD=
PF:

    dma_unmap_single(tx_chn->dma_dev, buf_dma, buf_dma_len,
                     DMA_TO_DEVICE);

Could this cause an IOMMU fault or memory corruption when this page is
later recycled and the hardware tries to DMA into the unmapped address?

>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->l=
en);
>  	swdata =3D cppi5_hdesc_get_swdata(first_desc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611185744.2498=
070-1-m-malladi@ti.com?part=3D2
