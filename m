Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50135DA7F
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748106; cv=none; b=mAW0VrM8acoAMMzfyIh80UcuVYzRqqSNWuQYTITjk0E8sO8poN3r0PPho332rkhjJNtcq2OjP7QEzPOJpzRD7PAL3LR78FHZ9tf7eWcIbkWx28Z1VQQg9TRhj1UjP1IT1+DFYHWoiu7w91xXXyOro+64cWXuajigCf3eymGzbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748106; c=relaxed/simple;
	bh=f1sM0H1av6k+Hy6T9Xy+2NldQ7cqpmFYHD6dji1DiH0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BLyu/sHvPGNhZ35Ij6vEnnfJNdTm7I9aU/hpJKhAZDs7B7U27VMD9TNF+Xtm4cJKzoqB6dL0dhmrxpD+Sw2dpx/72xGQYr6ym/X0zTMzh+oqmqitmBPE+a+kMmM00snoiLQ1wGItnmQCJfIvzu45fmqsnS6lyMjcr52TmI2L+C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOroPkMl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOroPkMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4D71F00893;
	Sat,  6 Jun 2026 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748105;
	bh=n6ixPlLBT9NyImMKjDxlAteMaeGuRs1uqwsl6mEJt58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NOroPkMlIuXi7EoeUrJ+qHZhoEpvK8xcVm3BQXjhDeUCZEWG2kEKctFzLUnfeXnXL
	 4tcRqgAOLEjRTvNTGqZMnYPFM5dNbqvnNv8RbWjIp2SsJihmTfY+/n4cMNn0jHSf9R
	 0RyEN6FDeL261zCoQri09L2rHGTV0YVr6M+E65/cLz5L4vrHDHLFXJTN7DRKYU+doh
	 /kwFW0U/kCHfcncjPDnPMGe1CEjtmWnlzW6sWw7E4d4mI1eQj1ZfBJpyFaG0RGbxX5
	 xya1iLvw9qR1VIPYLvcAEaIH9W362ZQxIVYPBGX63ss44fLpy6eClfnyRarS9XaPnC
	 CMBdurPWzc+9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/4] net: mvpp2: sync RX data at the hardware
 packet offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605121332.147397-2-mail@tk154.de>
References: <20260605121332.147397-2-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 12:15:05 +0000
Message-Id: <20260606121505.6B4D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] If SKB allocation fails after XDP processing, the buffer is recycl=
ed with a potentially truncated DMA sync size, leading to possible data cor=
ruption.
--

commit 2937dd51dcd41c34cf709a921bae57060051477d
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: sync RX data at the hardware packet offset

mvpp2 programs the RX queue packet offset, so hardware writes received
data at dma_addr + MVPP2_SKB_HEADROOM. The current CPU sync starts at
dma_addr and only covers rx_bytes + MVPP2_MH_SIZE bytes, which syncs the
unused headroom and misses the same number of bytes at the packet tail.

> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index f442b874bb593..92a701f4fe3f5 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3946,9 +3946,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struc=
t napi_struct *napi,
>  			dma_dir =3D DMA_FROM_DEVICE;
>  		}
> =20
> -		dma_sync_single_for_cpu(dev->dev.parent, dma_addr,
> -					rx_bytes + MVPP2_MH_SIZE,
> -					dma_dir);
> +		dma_sync_single_range_for_cpu(dev->dev.parent, dma_addr,
> +					      MVPP2_SKB_HEADROOM,
> +					      rx_bytes + MVPP2_MH_SIZE,
> +					      dma_dir);
> =20
>  		/* Buffer header not supported */
>  		if (rx_status & MVPP2_RXD_BUF_HDR)

[Severity: High]
Can recycling the buffer with a truncated DMA sync size corrupt memory?

Looking further down in mvpp2_rx(), if an XDP program shrinks the packet,
rx_bytes is updated to the smaller size:

	rx_bytes  =3D xdp.data_end - xdp.data;

If the subsequent build_skb() or slab_build_skb() allocation fails, the err=
or
path recycles the buffer with the modified rx_bytes:

	if (!skb) {
		netdev_warn(port->dev, "skb build failed\n");
		if (pp) {
			page_pool_put_page(pp, virt_to_head_page(data),
					   rx_bytes + MVPP2_MH_SIZE,
					   true);

Because rx_bytes is truncated, does this leave dirty CPU cache lines at the
tail of the original packet uncleaned?

If the hardware reuses this buffer to DMA a new packet, random CPU cache
evictions of these dirty lines could silently corrupt the new packet data
in RAM on non-coherent architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605121332.1473=
97-1-mail@tk154.de?part=3D1
