Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91501DF736
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300172; cv=none; b=iRPwjrl7t8s4KD/FWGYk61B0Y9L47P66pvYtewc6EfYgrPvcfH2yeDRBeD4dQoP3p1be/yc/tz8mKOwyCLPoJuxehYFGWCF2ueEb9pHuA9eXDpuj9ZNA/4BsgXPLLNxFqepoaapoNuaVxQgTpQK6CN+Vgx6B8PFb6IhkdfEpKPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300172; c=relaxed/simple;
	bh=CRADR9Dpe+zzVNEIQKxfJZC0s/euNk2S8md4waljZj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UYPechBD4qrEWacg406Pcg2XgfykPMGtlej2ObK61W4+ok8ecOrLeVpQmMbAP23cvwz+QIkkdQ8L8YcDG5T4JFuzMg+yNl+Cb8O9iCejZxhLRZ5iEY4iOTE5RoBU9xKN+ZJ6thmEmTMpjx5J4XpJ7EfhVKmjlxXFt++kvcdTfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJSQfuus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJSQfuus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380F51F000E9;
	Wed, 24 Jun 2026 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782300171;
	bh=dri9GVicHrWIHHZFJvflJ0nisTO+YMyGsZHzKV64/DE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJSQfuushRvgy/WJ/OXJeDFZxTpSV3G833w041Iyogn3TsbHhHFkyanUFaC/P+Plb
	 eCzwzXXyC1pILb4W/rYnv6qOHxwGe/dYzlwbBOtpU5IyJO1ZgIIvd+0g0DC60jNVz8
	 noLyMrZpCFSP6jFD3mr/VvNhq86Wlm3LeUIdL/ytpuJDjWArsF/2EG/QRNph2c1VPJ
	 fUMp3NGPYbcgFbtLxWAnQj9BtwMa/EWNwAZdUYYq2PYocjck7i/sa+tSSUKi5sko3j
	 mSvd2IWy4a08MJSajYc66Pjs8e0utuSoGytxbWfgcUm1SIfYUzSlp7aVpe0Pwj38Iw
	 L4gRkletWR6MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: fix XDP_TX from the
 AF_XDP zero-copy RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623112225.303930-1-devnexen@gmail.com>
References: <20260623112225.303930-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 11:22:50 +0000
Message-Id: <20260624112251.380F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Uninitialized descriptor usage leads to arbitrary DMA unmappin=
g and memory corruption

Pre-existing issues:
- [Critical] Double free and memory leak on XDP_TX failure path for zero-co=
py frames
- [High] DMA API Violation: Freeing memory before unmapping DMA
- [High] Missing dma_sync_single_for_device() causes stale data transmission
--

commit 87bb8b22d4b9f56b9ec402460012e589c44163a5
Author: David Carlier <devnexen@gmail.com>

net: ti: icssg-prueth: fix XDP_TX from the AF_XDP zero-copy RX path

This commit addresses an issue with XDP_TX on zero-copy RX frames by using
the NDO path to DMA map cloned frames instead of treating them as page pool
buffers. It also introduces PRUETH_SWDATA_XDPF_TX to skip DMA unmapping for
page pool frames on the completion path.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index 82ddef9c17d54..96c8bf5ef6719 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -185,7 +185,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>  	first_desc =3D desc;
>  	next_desc =3D first_desc;
>  	swdata =3D cppi5_hdesc_get_swdata(first_desc);
> -	if (swdata->type =3D=3D PRUETH_SWDATA_XSK)
> +	if (swdata->type =3D=3D PRUETH_SWDATA_XSK || swdata->type =3D=3D PRUETH=
_SWDATA_XDPF_TX)
>  		goto free_pool;
> =20
>  	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);

[Severity: Critical]
Does this error path properly handle uninitialized descriptors?

In emac_xmit_xdp_frame(), a new descriptor is allocated via
k3_cppi_desc_pool_alloc(), which uses gen_pool_alloc() and does not zero the
returned memory.

This patch allows emac_xmit_xdp_frame() to take the dma_map_single() branch
for non-page-pool XDP frames. If that mapping fails, the code jumps to
drop_free_descs and passes first_desc to prueth_xmit_free().

Because the descriptor is completely uninitialized at this point (even
cppi5_hdesc_init() has not been called), prueth_xmit_free() will read garba=
ge
state from a previous packet.

Could this read a stale swdata->type and org_buf_ptr, unmapping an active
DMA buffer belonging to another packet, and following any garbage
next_desc_dma link to potentially double-free active descriptors?

[ ... ]

> @@ -259,6 +259,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac=
, int chn,
>  			napi_consume_skb(skb, budget);
>  			break;
>  		case PRUETH_SWDATA_XDPF:
> +		case PRUETH_SWDATA_XDPF_TX:
>  			xdpf =3D swdata->data.xdpf;
>  			dev_sw_netstats_tx_add(ndev, 1, xdpf->len);
>  			total_bytes +=3D xdpf->len;

[Severity: High]
This is a pre-existing issue, but does this violate the DMA API by freeing
memory before unmapping it?

In emac_tx_complete_packets() and prueth_tx_cleanup(), when cleaning up
PRUETH_SWDATA_XDPF frames, the code calls xdp_return_frame() to free the
underlying memory back to the allocator.

Later in the function, it calls prueth_xmit_free() which subsequently
performs dma_unmap_single() on the buffer.

Could this race condition allow the memory to be reallocated to another
context, causing the delayed DMA unmap operation to corrupt IOMMU state
or free SWIOTLB bounce buffers out from under the new owner?

[ ... ]

> @@ -804,6 +806,7 @@ EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
>   */
>  static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, =
u32 *len)
>  {
> +	enum prueth_tx_buff_type tx_buff_type;
>  	struct net_device *ndev =3D emac->ndev;
>  	struct netdev_queue *netif_txq;
>  	int cpu =3D smp_processor_id();
> @@ -826,11 +829,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, s=
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

[Severity: High]
This is a pre-existing issue, but is a dma_sync_single_for_device() call
missing here?

For page pool-backed frames (PRUETH_TX_BUFF_TYPE_XDP_TX),
emac_xmit_xdp_frame() avoids calling dma_map_single() and derives the DMA
address using page_pool_get_dma_addr(). It then submits this address direct=
ly
to the TX ring.

If the XDP program modified the packet (e.g., swapping MAC addresses or
altering IP headers), those modifications reside in the CPU cache.

Because the driver fails to call dma_sync_single_for_device() before
transmission, could the NIC's DMA engine transmit stale, unmodified packet
contents on non-cache-coherent architectures?

> +
>  		q_idx =3D cpu % emac->tx_ch_num;
>  		netif_txq =3D netdev_get_tx_queue(ndev, q_idx);
>  		__netif_tx_lock(netif_txq, cpu);
>  		result =3D emac_xmit_xdp_frame(emac, xdpf, q_idx,
> -					     PRUETH_TX_BUFF_TYPE_XDP_TX);
> +					     tx_buff_type);
>  		__netif_tx_unlock(netif_txq);
>  		if (result =3D=3D ICSSG_XDP_CONSUMED) {
>  			ndev->stats.tx_dropped++;

[Severity: Critical]
This is a pre-existing issue, but does this error path cause a double free
and a memory leak?

When emac_run_xdp() processes an XDP_TX for an AF_XDP zero-copy buffer,
xdp_convert_buff_to_frame() frees the original zero-copy buffer via
xsk_buff_free() and allocates a new MEM_TYPE_PAGE_ORDER0 page.

If the transmission via emac_xmit_xdp_frame() fails (e.g., due to a full TX
ring), it returns ICSSG_XDP_CONSUMED. The newly allocated xdpf is not freed
here, causing a memory leak.

Furthermore, emac_run_xdp() propagates ICSSG_XDP_CONSUMED back to
emac_rx_packet_zc(). emac_rx_packet_zc() handles ICSSG_XDP_CONSUMED by
calling xsk_buff_free(xdp) on the original buffer again.

Since the buffer was already freed during the cloning step, wouldn't this
trigger a double free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623112225.3039=
30-1-devnexen@gmail.com?part=3D1
