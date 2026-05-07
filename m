Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771B47D945
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181477; cv=none; b=f55Nf/cJTOmCGgIfLyLbXQo29wawfG4Mm5sAJcpdHUGlrFoyNRCCQTN1bdmWf+nePyE0m4T8FEbueqAiILLVwzc2tRCz7Qi7Yl9P+YkrogviBNNu47U+TLWK7twt55z2j3a6JX64Qj545iQSor78AV/BgCmqDQDwWxAGoswp8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181477; c=relaxed/simple;
	bh=5nGbbzE8r8f5ezm0lbypFE+mID//VpE8ImQIWn+ZUFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t2ltrBSeI2iVLGjmo5s93iJnFcff0H00Boy1nA1KQppR/9mK4BkX4+JSq8MEBvQ0jHdXTtGu3v4c5eKRhm08wEZtFZzMtpOguP2/axcCG+6THFeclFvRKnMtSNeYhVjwod/jaYSTBjlz6Mjr3j7I9GnafK4HxPgj0D78dWUsVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzmcqjy2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzmcqjy2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178D1C2BCB2;
	Thu,  7 May 2026 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181477;
	bh=5nGbbzE8r8f5ezm0lbypFE+mID//VpE8ImQIWn+ZUFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kzmcqjy2FRgCPz5rDOtMR1NbJFYjME0OE9Tyb4AKwM/kFu/0pd5rEVHldp3kszycA
	 YF/1xt7z7Byea8ctpD257irsSh+4nFupXssZwKndrFCOvPsv8zSSn/QT80wthDc2Nj
	 Xp6zxo4XgCnA+Yn4jHTXiXjE9L7aKQuO2G0YCtzt+/qgKqXkbSsxx24XYUwgTABDsc
	 sDLftmDViSh8UPCaArrlnaNtKNhaF1KFMsCLIuo4hLcrk/W5NClMAabKew4VqPbafZ
	 QOrKndjbm5KvLvhGq9qtCUyiVzfJaa0GW9e7FOB4lDG+Z67LMULCQsd9lVxvw4GL9V
	 dMYexf7nio/mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 1/7] net: bcmgenet: convert RX path to
 page_pool
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506095553.55357-2-nb@tipi-net.de>
References: <20260506095553.55357-2-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 19:17:56 +0000
Message-Id: <20260507191757.178D1C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Out-of-bounds DMA sync in bcmgenet_desc_rx() due to unvalidated pa=
cket length
--

commit dcf6f3586789c6e4c09c02881b479202e9ad31ad
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: convert RX path to page_pool

This commit replaces the per-packet allocation and DMA mapping in the RX pa=
th
with a page_pool implementation. It updates the refill and descriptor routi=
nes
to allocate from the pool and build skbs using napi_build_skb.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index 54f71b1e85fc4..df11c4977e8f7 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2367,15 +2355,23 @@ static unsigned int bcmgenet_desc_rx(struct bcmge=
net_rx_ring *ring,
>  		dma_flag =3D dma_length_status & 0xffff;
>  		len =3D dma_length_status >> DMA_BUFLENGTH_SHIFT;
> =20
> +		/* Sync the rest of the actual received frame */
> +		if (len > sizeof(struct status_64))
> +			page_pool_dma_sync_for_cpu(ring->page_pool, rx_page,
> +						   sizeof(struct status_64),
> +						   len - sizeof(struct status_64));

Can this cause an out-of-bounds DMA sync regression?

The length is read from the hardware-written Receive Status Block and then
immediately used to sync the remainder of the frame data.

However, the bounds check against RX_BUF_LENGTH is performed after this
page_pool_dma_sync_for_cpu call.

If the hardware provides a corrupted or abnormally large length, could the
driver attempt to sync memory outside of the mapped page pool buffer? On
systems using SWIOTLB, passing a sync size larger than the mapped region
might lead to out-of-bounds copies and memory corruption.

>  		netif_dbg(priv, rx_status, dev,
>  			  "%s:p_ind=3D%d c_ind=3D%d read_ptr=3D%d len_stat=3D0x%08x\n",
>  			  __func__, p_index, ring->c_index,
>  			  ring->read_ptr, dma_length_status);
> =20
> -		if (unlikely(len > RX_BUF_LENGTH)) {
> -			netif_err(priv, rx_status, dev, "oversized packet\n");
> +		if (unlikely(len > RX_BUF_LENGTH || len < GENET_RSB_PAD)) {
> +			netif_err(priv, rx_status, dev,
> +				  "invalid packet length %d\n", len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506095553.5535=
7-1-nb@tipi-net.de?part=3D1
