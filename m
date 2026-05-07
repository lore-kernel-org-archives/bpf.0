Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DCA480DE4
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181478; cv=none; b=lkte4W1U2geL+t4+NEul8BZQOgGvi5USnlzOKNXu/ANM9w1xGrQYet4QrVrjwbh8KHC8i5nPwr6Ys+mtsDmzX3ppF9qCtLpAhhy1V6fdocmwNIotbZAfN4NhjZ6S8pKBQh7ZMsAANCpDIINQLaoF2qdt156JL1/yhCr+rZiGvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181478; c=relaxed/simple;
	bh=fEeOncEB/h6WZVee5J9vud19uEl0GME5CyLpW+8efvI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FpeRknfz9Lpc6yQjKqpHqs0uHIx5k38WOiiF7wR+JT4t2SRh1UllufLYnoxOpQ2Z8lmQLEdwU6L+/a/S0VFGjVh+7BEsFyEVcP9FB/VP5JB2N1HbgLtafpp4gJwdmsjPgLUWUGA+BXihFwT6/s3jzM/Sa6dh0WlxM8fH+qPnQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlpJ6efs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlpJ6efs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9360C2BCB2;
	Thu,  7 May 2026 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181477;
	bh=fEeOncEB/h6WZVee5J9vud19uEl0GME5CyLpW+8efvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GlpJ6efsk2zbpra/aTcta7SIrN9Zesxmlmh5aDaaErvzjhC/L0xsmq6ZfPrV34oRe
	 3Wd/Vb7QWsnOdMmdy+Ga4n55sRc1xpqAqH8pKiwrvkPeabDSNVyApacMeAYBK6jtF5
	 2jzXAfbNeSKTjrngrFhzOBRH3qrA8SVJtdHO9AnEj0BNdKtr/pvGimoscTOUPhtphO
	 9VdZ74OwAgUKTPbKQkEMe7jWQ/NRHMdRctdTmQ4WODNujhskwE/ql9FXOr9o8RUmr1
	 L3/PQgPNRGdkrfznx4fM8Sek/Nzye9CjP3CeLk5dks5KbwZqaIDS4AfleGkswRddGD
	 LU1kN5qDh/OtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 3/7] net: bcmgenet: add basic XDP support
 (PASS/DROP)
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506095553.55357-4-nb@tipi-net.de>
References: <20260506095553.55357-4-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 19:17:57 +0000
Message-Id: <20260507191757.C9360C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditionally applying CHECKSUM_COMPLETE using the original hard=
ware checksum after an XDP program has executed.
- [High] Calculation of pkt_len can underflow when receiving short frames w=
ith crc_fwd_en enabled, leading to massive out-of-bounds SKB lengths.
--

commit a85e13efa285d96e84232f2f89b59157c43c2cf5
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add basic XDP support (PASS/DROP)

This commit adds basic XDP program attachment via ndo_bpf and executes
XDP programs in the RX path. It handles building SKBs from the xdp_buff
on XDP_PASS and returning pages to the page_pool on XDP_DROP.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index 5bedc18685b09..ee1d4ecc2b874 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2413,30 +2471,34 @@ static unsigned int bcmgenet_desc_rx(struct bcmge=
net_rx_ring *ring,
>  			goto next;
>  		} /* error packet */
> =20
> -		/* Build SKB from the page - data starts at hard_start,
> -		 * frame begins after RSB(64) + pad(2) =3D 66 bytes.
> -		 */
> -		skb =3D napi_build_skb(hard_start, PAGE_SIZE - XDP_PACKET_HEADROOM);
> -		if (unlikely(!skb)) {
> -			BCMGENET_STATS64_INC(stats, dropped);
> -			page_pool_put_full_page(ring->page_pool, rx_page,
> -						true);
> -			goto next;
> -		}
> +		pkt_len =3D len - GENET_RSB_PAD;
> +		if (priv->crc_fwd_en)
> +			pkt_len -=3D ETH_FCS_LEN;

Can pkt_len underflow here if we receive a short frame?

The RX validation earlier in bcmgenet_desc_rx() only ensures that
len >=3D GENET_RSB_PAD. If len is less than GENET_RSB_PAD + 4 (ETH_FCS_LEN),
subtracting ETH_FCS_LEN will result in a negative pkt_len.

When this negative pkt_len is passed to xdp_prepare_buff(), xdp->data_end
will be set before xdp->data. Later, bcmgenet_xdp_build_skb() calls
__skb_put(skb, xdp->data_end - xdp->data), which lacks bounds checking and
converts the negative difference into a very large unsigned integer, causing
an out-of-bounds SKB length.

> -		skb_mark_for_recycle(skb);
> +		/* Save rx_csum before XDP runs - an XDP program
> +		 * could overwrite the RSB via bpf_xdp_adjust_head.
> +		 */
> +		if (dev->features & NETIF_F_RXCSUM)
> +			rx_csum =3D (__force __be16)(status->rx_csum & 0xffff);
> =20
> -		/* Reserve the RSB + pad, then set the data length */
> -		skb_reserve(skb, GENET_RSB_PAD);
> -		__skb_put(skb, len - GENET_RSB_PAD);
> +		xdp_init_buff(&xdp, PAGE_SIZE, &ring->xdp_rxq);
> +		xdp_prepare_buff(&xdp, page_address(rx_page),
> +				 GENET_RX_HEADROOM, pkt_len, true);
> =20
> -		if (priv->crc_fwd_en) {
> -			skb_trim(skb, skb->len - ETH_FCS_LEN);
> +		xdp_act =3D bcmgenet_run_xdp(ring, xdp_prog, &xdp, rx_page);
> +		if (xdp_act !=3D XDP_PASS)
> +			goto next;
> =20
> -		}
> =20
> -		/* Set up checksum offload */
> -		if (dev->features & NETIF_F_RXCSUM) {
> -			rx_csum =3D (__force __be16)(status->rx_csum & 0xffff);
> +		skb =3D bcmgenet_xdp_build_skb(ring, &xdp);
> +		if (unlikely(!skb)) {
> +			BCMGENET_STATS64_INC(stats, dropped);
> +			page_pool_put_full_page(ring->page_pool,
> +						rx_page, true);
> +			goto next;
> +		}
> +
> +		/* Set up checksum offload */
> +		if (dev->features & NETIF_F_RXCSUM) {
>  			if (rx_csum) {
>  				skb->csum =3D (__force __wsum)ntohs(rx_csum);
>  				skb->ip_summed =3D CHECKSUM_COMPLETE;

Is it safe to unconditionally apply CHECKSUM_COMPLETE using the original
hardware checksum after an XDP program has executed?

Since XDP programs are allowed to modify the packet headers and payload,
if the program modifies the packet and returns XDP_PASS, the hardware-compu=
ted
1's complement sum saved in rx_csum will no longer match the packet content=
s.

This could lead to the network stack detecting a checksum mismatch and
incorrectly dropping a valid packet. Should the checksum status be cleared
or set to CHECKSUM_NONE if an XDP program is present?

>  			}
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506095553.5535=
7-1-nb@tipi-net.de?part=3D3
