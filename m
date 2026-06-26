Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A443DB97A
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455509; cv=none; b=XGdNhVSE894ZQKrHf4Jk5GwQaoU2nPJ/lAov3KtZzmXZ7HJ1PISU9hV218DjCekUlVEec290Uhsgx+ILdgmwZ9r0JDeCKVF1H9AE8MSTjxqbF+bQtX9SapwkXGW44j22zhu3+sEjGFh1zRKAkjDqWkLuVpepZKcmogggxmZSSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455509; c=relaxed/simple;
	bh=Qb7kUb95LMyX0OxLYyfxNaJGXks7rdDq4whfq8w/0Gk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tKstaX1rYwTKwMci4il89HSdlaAKwkeDI76jKdfr3u3qQsvSIquD9MjHRThjpZX1IW774eDUODsDo16MxEbDTnO/wN1ogTsxfakiDR631xORgxWrqbJtajA9Sddx5AD3i7WvnqhCn6f+ErMeZqsmEfk02Bt40em2gLhn8hgI1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMlQRzBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMlQRzBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CCD1F000E9;
	Fri, 26 Jun 2026 06:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782455508;
	bh=inSqXVyDYyoRGvjJbii2DuwbmlXzo3L7ilBUUd9hYvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMlQRzBzvEnbLEp49tw2AnWSLefC1Hk18gbi5of0g27Qx5l3sQk/jPX8ALLMO4G+C
	 fIEiwOSTfg4/S3kNhsUZCRnJXczIIBDd4NtEM/g6IfJi/0esn7wkku880MKt5NkyNx
	 bjmm4SI5/cdTN6HAjR/1RcUjBq+QE78g6q2mvkde1RzSmULbXvgnTdJh+vTCjJW/8j
	 hADZp+P77QXyErH4AHDqXKqlRr5Yj5yxsmJFdaa6/Nx2yNOIrdRl2RVUGJuLQAJVOV
	 QM3MiQNHM0DE6v7bD5gLbAg9XDLc3+UqMFR9bT90gFsN2HZiHieH4E00T3Y3M7bRln
	 i8xPC81QfyK+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: fix XDP_TX from the
 AF_XDP zero-copy RX path
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260625063121.24746-1-devnexen@gmail.com>
References: <20260625063121.24746-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 06:31:47 +0000
Message-Id: <20260626063147.C7CCD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Uninitialized descriptor memory used for DMA unmapping in erro=
r paths.
- [High] DMA API violation: memory is freed before the DMA mapping is torn =
down.
- [High] Memory leak and double free when XDP_TX or XDP_REDIRECT fails in A=
F_XDP zero-copy mode.
- [High] Missing DMA synchronization for transmitted Page Pool XDP_TX frame=
s.
- [High] Use-After-Free reading xdpf->len after handing the frame to the ha=
rdware TX queue.
- [Medium] Concurrent non-atomic increments to shared global network statis=
tics.
--

commit dc2f8356525786b4ee8c94beae174920f574ebd4
Author: David Carlier <devnexen@gmail.com>

    net: ti: icssg-prueth: fix XDP_TX from the AF_XDP zero-copy RX path
   =20
    On XDP_TX from the zero-copy RX path, emac_run_xdp() converts the xsk
    buffer via xdp_convert_zc_to_xdp_frame(), which clones the data into a
    fresh MEM_TYPE_PAGE_ORDER0 page that is not DMA mapped. Transmitting it
    as PRUETH_TX_BUFF_TYPE_XDP_TX derives the DMA address with
    page_pool_get_dma_addr(), reading an uninitialized page->dma_addr, so
    the device DMAs from a bogus address (corrupt TX, or an IOMMU fault).

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index 4a7d1a6f470b1..1d9ae764ce88f 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
[ ... ]
> @@ -259,6 +260,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac=
, int chn,
>  			napi_consume_skb(skb, budget);
>  			break;
>  		case PRUETH_SWDATA_XDPF:
> +		case PRUETH_SWDATA_XDPF_TX:
>  			xdpf =3D swdata->data.xdpf;
>  			dev_sw_netstats_tx_add(ndev, 1, xdpf->len);
>  			total_bytes +=3D xdpf->len;

[Severity: High]
This is a pre-existing issue, but does this violate the DMA API by freeing =
the
memory before tearing down the DMA mapping?

In both emac_tx_complete_packets() and prueth_tx_cleanup(), the driver frees
the XDP frame via xdp_return_frame() before calling prueth_xmit_free(), whi=
ch
performs the actual dma_unmap_single().

The physical memory is returned to the allocator and can be immediately reu=
sed
by another subsystem while the device or IOMMU still has an active mapping =
for
it, creating a use-after-free window.

[ ... ]
> @@ -768,7 +770,8 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->l=
en);
>  	swdata =3D cppi5_hdesc_get_swdata(first_desc);
> -	swdata->type =3D PRUETH_SWDATA_XDPF;
> +	swdata->type =3D (buff_type =3D=3D PRUETH_TX_BUFF_TYPE_XDP_TX ?
> +		PRUETH_SWDATA_XDPF_TX : PRUETH_SWDATA_XDPF);
>  	swdata->data.xdpf =3D xdpf;

[Severity: Critical]
This is a pre-existing issue, but does the error path pass an uninitialized
first_desc to the cleanup function?

If dma_map_single() or virt_to_head_page() fails in emac_xmit_xdp_frame(), =
the
driver jumps to the drop_free_descs error path and passes the newly allocat=
ed
first_desc to prueth_xmit_free().

Because the descriptor is allocated via k3_cppi_desc_pool_alloc() without
zeroing the memory, and it is passed before swdata->type and obuf are
initialized, prueth_xmit_free() will read stale swdata->type and garbage
buf_dma/buf_dma_len from a previous packet.

It then calls dma_unmap_single() with this garbage DMA address, potentially
unmapping memory actively used by other subsystems.

[Severity: High]
This isn't a bug introduced by this patch, but does the page pool frame
transmission miss a DMA synchronization?

When buff_type =3D=3D PRUETH_TX_BUFF_TYPE_XDP_TX, emac_xmit_xdp_frame()
retrieves the DMA address via page_pool_get_dma_addr() and passes it to the
TX hardware without calling dma_sync_single_for_device().

Because the hardware is not cache-coherent, the device may transmit stale d=
ata
from RAM instead of the modified cache lines from the BPF program.

[ ... ]
> @@ -825,11 +829,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, s=
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
> +		tx_buff_type =3D (xdpf->mem_type =3D=3D MEM_TYPE_PAGE_POOL ?
> +				PRUETH_TX_BUFF_TYPE_XDP_TX :
> +				PRUETH_TX_BUFF_TYPE_XDP_NDO);
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

[Severity: High]
This is a pre-existing issue, but does this leak memory and cause a
double-free when XDP_TX fails in AF_XDP zero-copy mode?

When an AF_XDP zero-copy buffer is handled, xdp_convert_buff_to_frame()
allocates a new page for the XDP frame and frees the original xsk_buff via
xsk_buff_free().

If the transmission fails and emac_xmit_xdp_frame() returns
ICSSG_XDP_CONSUMED, emac_run_xdp() propagates ICSSG_XDP_CONSUMED to the
caller but never frees the newly allocated xdpf page.

Furthermore, the caller emac_rx_packet_zc() unconditionally calls
xsk_buff_free(xdp) when receiving ICSSG_XDP_CONSUMED, double-freeing the
original xdp buffer.

[Severity: Medium]
This isn't a bug introduced by this patch, but does this perform an unprote=
cted
increment to a shared global statistic?

The driver performs unprotected increments like ndev->stats.tx_dropped++
in multiple contexts, including emac_run_xdp() and icssg_ndo_start_xmit().
Because multiple CPUs can execute these paths concurrently, these
read-modify-write operations on the shared net_device struct can result in
torn reads and lost updates.

[Severity: High]
This is a pre-existing issue, but is there a use-after-free when reading
xdpf->len after handing the frame to the hardware TX queue?

In emac_run_xdp(), the driver passes xdpf to emac_xmit_xdp_frame(), which
enqueues it to the hardware DMA ring. Once pushed, the hardware could trans=
mit
it immediately, allowing the TX completion interrupt on another CPU to pop =
the
descriptor and free xdpf.

Following this handoff, emac_run_xdp() accesses xdpf->len for statistics
accounting (dev_sw_netstats_rx_add), resulting in a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625063121.2474=
6-1-devnexen@gmail.com?part=3D1
