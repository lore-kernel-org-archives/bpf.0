Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED847AF56
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400783; cv=none; b=SOVOZVeWD1Em+BkDIWV6BCUvPVbDBsjd0XIW7C+52eXFXYPXeeMMG/cfapGXrQ/80851Bb1vwH7Nd/0APCRKs2huoRwMWZXHUcCi2XifcObEPxyEN7Cfsph18f+T6WLSYRN1wkHsexNZjvF/oMzMBJEHDb8bwYCyGO6FUtWbMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400783; c=relaxed/simple;
	bh=WhVsdEkghFRIIIa0/a/roxynEZP8B8HknPXwBr8kGMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ew0ZY47ZBvdjXpBYQOYw4pNe9iZ2+Nh3stVGYvsbesXKmwj9EX1vhM3GEdsL8Zqv3zKbeafCG42Vc+9AhOo3n74w3Z54QlfaIqTxgVlCgxvw8nZCIiKiyIJbnRhZsrZadrzTlWpn96fNLLjnwuaK99RrttGqAvfYOx/WGVNrcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1fGbLYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1fGbLYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC2C2BCB6;
	Tue, 28 Apr 2026 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777400782;
	bh=WhVsdEkghFRIIIa0/a/roxynEZP8B8HknPXwBr8kGMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=a1fGbLYoWm3WFtaQykLOEQfj38h1Ycasn4mUPPGnARLFmRR+L0O0fNyawsZH1Is/q
	 k4i7Dhn0KpzhElA4U1TW5i95vhH0ZTujMTrw6cb9DbT2rimmAft5T8AKEmye4B1wOA
	 XgAJXxeixb97CBN3qh6irgcsmMOy96NCISVBrkrFSVQ7790AC3Fw788lNNdbIpFyJ3
	 2djuzQ1qP7nJXm72ElzHJJGL/T3QqUzRINn/+lJaka9+nAp0gXfMuVUL0Q9jbegH5E
	 PBd6cfa2X8fuPztG8XykAH7QdOYepsIH6tkjXvL2T4xPWGbOa7FNICqPG272hfKOZy
	 gA8P1ZfRi73ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: mana: Force single RX buffer per page for
 CVM/encrypted guest memory
Reply-To: sashiko@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <ae9pxvJfkAZYfKMf@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <ae9pxvJfkAZYfKMf@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 18:26:22 +0000
Message-Id: <20260428182622.B7CC2C2BCB6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Missing DMA Synchronization causing silent data corruption on =
SWIOTLB/non-coherent architectures.
- [High] The implementation violates the commit message's claims regarding =
DMA alignment and mapping size when XDP or jumbo frames are enabled.
- [High] Double Free and Use-After-Free in the `mana_create_rxq` error path.
--

commit cd9b937476d6872de0ead35dec420877b132e896
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: Force single RX buffer per page for CVM/encrypted guest memory

This commit forces the mana driver to use a single Rx buffer per page on
Confidential VMs with encrypted memory. It aims to ensure page-aligned DMA
mappings without offsets to work around issues with swiotlb bounce buffers
when using sub-page fragments.

> When page_pool allocates sub-page RX buffer fragments, the bounce buffer
> granularity may not align with these smaller fragment sizes, leading to
> failure in mana driver rx path.

Could the underlying issue with sub-page fragments be a lack of DMA
synchronization rather than bounce buffer granularity?

The mana driver relies on the page pool DMA map flag for sub-page
Rx fragments, but does it call page_pool_dma_sync_for_cpu() or
dma_sync_single_for_cpu() before processing the packet?

On systems using swiotlb or non-coherent DMA, omitting this sync means
the CPU might read stale data since the bounce buffer is never copied
to the original CPU memory.

Forcing a single buffer per page works around this because the single-page
path calls dma_unmap_single(), which implicitly syncs the data. Would
adding the mandatory CPU DMA sync for sub-page fragments be the correct
fix here?

> - Each RX buffer is exactly one PAGE_SIZE.
> - The DMA offset is always 0.
> - SWIOTLB maps full, page-aligned blocks.

Does the implementation actually achieve these claims when XDP or jumbo
frames are enabled?

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index a654b3699c4c..2d44eaf932a8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -754,8 +772,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_conte=
xt *apc,
>  	/* Calculate datasize first (consistent across all cases) */
>  	*datasize =3D mtu + ETH_HLEN;
> =20
> -	/* For xdp and jumbo frames make sure only one packet fits per page */
> -	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
> +	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
>  		if (mana_xdp_get(apc)) {
>  			*headroom =3D XDP_PACKET_HEADROOM;
>  			*alloc_size =3D PAGE_SIZE;

If XDP is enabled, headroom is set to XDP_PACKET_HEADROOM, which is
typically 256 bytes. When the driver subsequently maps the buffer,
adding this headroom results in a DMA mapping with a 256-byte offset,
rather than 0. The mapped size would also be the data size, not a full page.

Additionally, for jumbo frames, alloc_size is elevated to a higher-order
allocation, meaning the buffer is not exactly one page size.

If the hardware or the hypervisor strictly relies on 0-offset,
page-aligned DMA addresses to function correctly with swiotlb, will enabling
XDP cause DMA faults here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ae9pxvJfkAZYfKMf@li=
nuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net?part=3D1
