Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048C847CC8C
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181479; cv=none; b=Vq+hsrmQ5cQfEOVv5MM0rRfHaDwUzkdMVOpLm6EMI18oVApA2GzP7eyCmTSe0h4yKrxz7TlmoGTrPIR2i3SDb5vtnRyV2HudOpfLBqCAv7WGMM/XyhnlHSaeft+lmrxZ0r5WVALpOLJWdjDxhdPgJUBo5W6TFg2ySaobG2TgCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181479; c=relaxed/simple;
	bh=SxfNm5ObvKkgMCn8a2JRXHvc9MrfPXpX+YCd/QzvR3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P/RVE5jbbJ+QDbZMFUycpnZUHNESJxWucXE0rS3gCSJEXNCHch84GIvLnL3RoYdkJvUbudSwjeWzk01gIqdl/fyu0SsV3RoDyjFde/sbdLknNrE0St+3khbHeTEt9v6DfX/LvTWx1p4jFQAI7HPuc4B6kch8ClmKEWlb9FHvhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAuxuxUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAuxuxUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6ACC2BCB2;
	Thu,  7 May 2026 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181478;
	bh=SxfNm5ObvKkgMCn8a2JRXHvc9MrfPXpX+YCd/QzvR3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LAuxuxUejGpOYb5QZEbCx+oZjMDRG+UGhykd3v6Z2zyFcM/JsBj40Pi30gHNTeygf
	 DV6qKMIeSw4ZC8aOSNseQR8A2N84Kj+THvo+17xEy03ojbz8wdsFu8pGh3tj744hJv
	 QatRRDkvMbaPMbnZfOeiz7J99VCLe2tBZuqXJ59dQ7m9z/gBuKIfOCPYwLKGccQMuD
	 ppuyfmvzByqOoxfkfiHXhmsYPV1nac+Xz5sJGUx3+/01P69FWilqKEuf4yfGQ29hFf
	 zkN0TNeX8Dv7dNbWSUgb09bVOYKRUf4KEjJn+lhzZuNHEC41fCnhGg3n6XVd1unIp3
	 f/OQe6ef9jQkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 4/7] net: bcmgenet: add XDP_TX support
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506095553.55357-5-nb@tipi-net.de>
References: <20260506095553.55357-5-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 19:17:58 +0000
Message-Id: <20260507191758.7A6ACC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Deterministic packet drops on XDP_TX because the dedicated TX ring=
 capacity (32) is smaller than the NAPI budget (64).
- [High] XDP_TX corrupts XDP metadata and copies uninitialized memory into =
the `xdp_frame`.
- [Medium] XDP TX completions can stall indefinitely, leading to page pool =
exhaustion.
- [Medium] Severe lock and MMIO contention across multiple RX NAPI contexts=
 sharing a single XDP TX ring.
--

commit 3ad0ff68731af021753c8986d28477830093832b
Author: Nicolai Buchwitz <nb@tipi-net.de>

    net: bcmgenet: add XDP_TX support
   =20
    Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
    descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index ee1d4ecc2b874..f1e515526787a 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -49,8 +49,10 @@
> =20
>  #define GENET_Q0_RX_BD_CNT	\
>  	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_=
q)
> +#define GENET_Q16_TX_BD_CNT	32

Will this cause deterministic packet drops on XDP_TX? The NAPI budget is
typically 64. Since the RX poll reclaims XDP TX completions only once at the
beginning of the NAPI cycle, a burst of more than 32 XDP_TX actions would
exhaust the TX ring and drop subsequent packets in that burst.

>  #define GENET_Q0_TX_BD_CNT	\
> -	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_=
q)
> +	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_=
q \
> +	 - GENET_Q16_TX_BD_CNT)

[ ... ]

> @@ -2315,14 +2432,42 @@ static unsigned int bcmgenet_run_xdp(struct bcmge=
net_rx_ring *ring,
>  	switch (act) {
>  	case XDP_PASS:
>  		return XDP_PASS;
> +	case XDP_TX:
> +		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
> +		 * MAC has TBUF_64B_EN set globally, so hardware expects every
> +		 * TX buffer to begin with a 64-byte struct status_64.  Back
> +		 * up xdp->data into the RSB area (which is no longer needed
> +		 * after the BPF program ran) and zero it.
> +		 */
> +		if (xdp->data - xdp->data_hard_start <
> +		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {

Does this headroom check need to account for the metadata size? If headroom
is tight, shifting the pointers might cause xdp_update_frame_from_buff()
to fail with -ENOSPC and drop the packet.

> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}
> +		xdp->data -=3D sizeof(struct status_64);
> +		xdp->data_meta -=3D sizeof(struct status_64);
> +		memset(xdp->data, 0, sizeof(struct status_64));

Could this corrupt XDP metadata and copy uninitialized memory?

If the XDP program attached metadata, the physical metadata bytes immediate=
ly
precede the original xdp->data. The memset() here spans the exact memory ar=
ea
where the original metadata resides, overwriting it with zeros.

Because xdp->data_meta is decremented, it now points to uninitialized
headroom memory, which xdp_convert_buff_to_frame() would read as the frame's
metadata.

> +
> +		xdpf =3D xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf)) {
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}

[ ... ]

> @@ -2548,9 +2693,15 @@ static int bcmgenet_rx_poll(struct napi_struct *na=
pi, int budget)
>  {
>  	struct bcmgenet_rx_ring *ring =3D container_of(napi,
>  			struct bcmgenet_rx_ring, napi);
> +	struct bcmgenet_priv *priv =3D ring->priv;
>  	struct dim_sample dim_sample =3D {};
>  	unsigned int work_done;
> =20
> +	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
> +	if (priv->xdp_tx_ring.free_bds < priv->xdp_tx_ring.size)
> +		bcmgenet_tx_reclaim(priv->dev,
> +				    &priv->xdp_tx_ring, false);

If the NAPI budget is not fully consumed, napi_complete_done() is called and
NAPI exits. Since there is no TX interrupt for ring 16, could XDP TX
completions stall indefinitely if RX traffic stops? This might leave buffers
in the TX ring, eventually leading to page pool exhaustion.

Also, is there a risk of severe lock and MMIO contention here?

Since the single XDP TX ring is shared across all RX queues, every active
RX NAPI will concurrently evaluate this condition. Since hardware transmiss=
ion
takes time, this condition could remain true across multiple concurrent NAPI
polls. As a result, all active RX queues could simultaneously call
bcmgenet_tx_reclaim(), heavily contending for spin_lock_bh(&ring->lock) and
performing expensive MMIO reads.

> +
>  	work_done =3D bcmgenet_desc_rx(ring, budget);
> =20
>  	if (work_done < budget && napi_complete_done(napi, work_done))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506095553.5535=
7-1-nb@tipi-net.de?part=3D4
