Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF9274B3B
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497421; cv=none; b=Y8sYks7ZcE7e92Z3K7MZ2FHycI/5kM8ANrU1Vk0cdSk9OZuLxdPTDOMVPZwttLpriu3TBWQY9VikMv1LGBb7OvYVScXgbzmF43ofZlTACHty67RRIhhmRwTZW3sETaUQkk/3A4vsiiFDUSNY20WlhCDRThVdt3fDBD8vdARHFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497421; c=relaxed/simple;
	bh=bXNTzCqpskDq0a/nZbxfaIlHh4jp/XO7GTn+k2J8SAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h1Id3CEAI9QT9pODByM3MHvLfeBeMzf1DxtH27+B4LqPrD231T8H76R6cWesQ2PL7jpLjenWc2blDLKMWJS9p9CKuk+owpGrwEJ0f7DI4Y0xO3/eeQJ9vKReHDhU1ssQeNFVx7KJLH2fmcy7VN7rxhFU7fOJwJAetLLnY7ZWEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCmEGdeW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCmEGdeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F2FC19425;
	Wed, 29 Apr 2026 21:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497421;
	bh=bXNTzCqpskDq0a/nZbxfaIlHh4jp/XO7GTn+k2J8SAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iCmEGdeWEmIhIi2Vv7XWExunfnD1zJvmN2W1zm7B4K0ZOY0R07KmNPctSIyIh7dED
	 ExTZ8U3XGEHLlpKghVKH+x808b8977WtoxXFB2XbsGCq4w9OqHsDRD4pZ+B8abQ+6W
	 PgXs8uvCWG5iF2Jj/tbYosjwzflwMfW/btEczNf6gPTUMt1EIlZA1hnseHjrdBpYQS
	 RRC/9lgsTsjCXLulF1ytajqvmA7AweRHdLPWUeElYiq/cQnfpBvuwpcLY173kzMrIo
	 XN9DDCakvLQO63H0rwBmdVWkUI+xuUtar9disvZFtcu5LodGep9q2AM+HMFutOehKa
	 BvJ2KzuLsvLhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 3/7] net: bcmgenet: add basic XDP support
 (PASS/DROP)
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428205846.2625550-4-nb@tipi-net.de>
References: <20260428205846.2625550-4-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:17:00 +0000
Message-Id: <20260429211701.55F2FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware checksum offload (CHECKSUM_COMPLETE) is unconditionally a=
pplied after XDP execution, causing valid modified packets to be dropped.
- [Medium] The driver advertises NETDEV_XDP_ACT_BASIC without supporting XD=
P_TX, violating the XDP feature API contract.
--

commit fcb14e148a380096868da445b34bcc00893540bf
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add basic XDP support (PASS/DROP)

This commit adds basic XDP support to the bcmgenet driver, allowing XDP
programs to execute in the RX path with support for XDP_PASS and XDP_DROP.

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
> -			rx_csum =3D (__force __be16)(status->rx_csum & 0xffff);
>  			if (rx_csum) {
>  				skb->csum =3D (__force __wsum)ntohs(rx_csum);
>  				skb->ip_summed =3D CHECKSUM_COMPLETE;
>  			}

If the XDP program modifies the packet payload (e.g., rewriting IPs or
ports), the hardware checksum saved before XDP execution will no longer mat=
ch
the new payload.

If we unconditionally apply this old checksum and set CHECKSUM_COMPLETE on
the SKB here, will the network stack drop the valid modified packet due to a
hardware checksum failure?

Should the checksum be invalidated when an XDP program is present?

[ ... ]
> @@ -4054,6 +4148,7 @@ static int bcmgenet_probe(struct platform_device *p=
dev)
>  			 NETIF_F_RXCSUM;
>  	dev->hw_features |=3D dev->features;
>  	dev->vlan_features |=3D dev->features;
> +	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC;
> =20
>  	netdev_sw_irq_coalesce_default_on(dev);

The commit message notes that XDP_TX is not yet supported and returns
XDP_ABORTED.

The UAPI definition for NETDEV_XDP_ACT_BASIC implies support for XDP_PASS,
XDP_DROP, XDP_ABORTED, and XDP_TX. Does advertising this flag without XDP_TX
support break feature detection for userspace applications?

I see from the patch series that XDP_TX support is added in a later commit.
Would it be safer to defer setting NETDEV_XDP_ACT_BASIC until that patch to
avoid breaking userspace assumptions during a bisect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428205846.2625=
550-1-nb@tipi-net.de?part=3D3
