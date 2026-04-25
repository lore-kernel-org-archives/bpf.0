Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20F27470
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777080385; cv=none; b=iAf0t0nPLcq9SqSFjSp81kOwUWTpRzlQm/eGj4E4UQ8kMr7sbAEqM9KIeOfRhrZZCB+O8sCN6VnjtuNxQmMbV5t0mKwHM2Zjk9FHUH/0V7YR8HPh+Aw4LqTxGaS2lPuoqW/VfJGLwYx/D7STrkQ6HFZhcPmXHpdUDGmLcP0Rg8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777080385; c=relaxed/simple;
	bh=lL18ThBIngeuDVB4CLTRD1Lc0QmWS08mTNOMv5kHSEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W05hG2QMstq0qoBIXeDgaG7jOvzeTSVB2jTWKPUR8g+noPhv/Opkn5zXUuRUZVxln/cVfyzCOXCzoUE+wNrfoa8EGAv9yRaHpJLd9pZRDN19gVIAupFbCVp4YpxUaNnOzrOBD29T27AUh59rnxqim7Y8Pn6sotmbP/LTg7fBmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdWsYT7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdWsYT7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC50C19425;
	Sat, 25 Apr 2026 01:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777080385;
	bh=lL18ThBIngeuDVB4CLTRD1Lc0QmWS08mTNOMv5kHSEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QdWsYT7NCpR0/i0NyrBBMAPMDtjF/pHChvJQ8wrFoN/63cTMyFOsX0anRiyWXDbo7
	 wRImfImGiE8HDGmYXNsYUckOIModFtriOutFHkiUh4sZxQjg3/FEcLCcwikNAKIRd5
	 QEab+YT8Xo62vR9Q2Dv0N3q+OZZKvGVh3xOmuc8KQ1e+2ljAuETze/FKPF89LF2jZS
	 Y6eMj1+fPV1wL295Z6vLW1Nbi5qKHi72KKx6WUy2uPA0ExrDZTJmoADKmHA5xUZ87h
	 kEUoqNXlORwAoU18aoa4CgxqBbW++gq5kidm3PcyM/r8YvUoA32ZK5VTv5Jcttt8TS
	 1DdeTEB0Lzbdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 3/7] net: bcmgenet: add basic XDP support
 (PASS/DROP)
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416054743.1289191-4-nb@tipi-net.de>
References: <20260416054743.1289191-4-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 01:26:24 +0000
Message-Id: <20260425012624.DBC50C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The driver incorrectly applies the original hardware checksum (`CH=
ECKSUM_COMPLETE`) to the SKB after an XDP program has processed the packet.
--

commit 5fcb56745df8a1527b5006d1089794e51dbc65ee
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add basic XDP support (PASS/DROP)

This commit adds basic XDP program attachment via ndo_bpf and executes
XDP programs in the RX path. It handles XDP_PASS by building an SKB from
the xdp_buff, and XDP_DROP by returning the page to the page_pool.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2404,30 +2462,34 @@ static unsigned int bcmgenet_desc_rx(struct bcmge=
net_rx_ring *ring,

[ ... ]

> +		/* Save rx_csum before XDP runs - an XDP program
> +		 * could overwrite the RSB via bpf_xdp_adjust_head.
>  		 */
> +		if (dev->features & NETIF_F_RXCSUM)
> +			rx_csum =3D (__force __be16)(status->rx_csum & 0xffff);
> =20
> +		xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
> +		xdp_prepare_buff(&xdp, page_address(rx_page),
> +				 GENET_RX_HEADROOM, pkt_len, true);
> =20
> +		xdp_act =3D bcmgenet_run_xdp(ring, xdp_prog, &xdp, rx_page);
> +		if (xdp_act !=3D XDP_PASS)
> +			goto next;
> =20
> +		skb =3D bcmgenet_xdp_build_skb(ring, &xdp);
> +		if (unlikely(!skb)) {
> +			BCMGENET_STATS64_INC(stats, dropped);
> +			page_pool_put_full_page(ring->page_pool,
> +						rx_page, true);
> +			goto next;
>  		}
> =20
>  		/* Set up checksum offload */
>  		if (dev->features & NETIF_F_RXCSUM) {
>  			if (rx_csum) {
>  				skb->csum =3D (__force __wsum)ntohs(rx_csum);
>  				skb->ip_summed =3D CHECKSUM_COMPLETE;

Does this unconditionally apply the original hardware checksum to the SKB
after the XDP program has executed?

Since XDP programs can modify the packet payload before returning XDP_PASS,
the original hardware sum might no longer be mathematically valid for the
modified packet.

If a modified packet retains CHECKSUM_COMPLETE with the old checksum, could
the network stack rely on it, fail validation, and erroneously drop the
packet?

Would it make sense to invalidate the hardware checksum (for example, by
setting skb->ip_summed to CHECKSUM_NONE) if an XDP program is present and
processes the packet?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416054743.1289=
191-1-nb@tipi-net.de?part=3D3
