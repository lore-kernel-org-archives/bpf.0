Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F243DA26
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780505720; cv=none; b=RhcDSg23jDW/TCoLnrJifIgpeAMgriQ4Wk7/IR8FYYZ4Ck1GkWtyc0lMOFsV7fBMvOpzqDmFTAVfiPitdZ/i14huO2uIwLn5onky6Sn72m2XwL5vWjXABvg1e7Sz6V98xnCmt985ZCtswZkeDaRN5IBxV+A2XRizjIEwJqfo5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780505720; c=relaxed/simple;
	bh=b5vU7Cac9HpgkbIv1riRX0VIszvSDb7P5NF2swveL4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MlvOU1BweE5xHbHvRPPJiRegbmHI4MSw3gIcEEy7ex9NLtPfwneT3sskka2pOO73nmPWwRlHL4e8RQtKYT5FxGDEOiBaNY4AEh6wB+Q60OS/Ys17POlNFmtjnhlSoxYjXZjHCjxb0xSjXWJ6EhPmwt/aTIVdBb/MM1cLHAqJrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN/VcfQB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN/VcfQB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EE11F00893;
	Wed,  3 Jun 2026 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780505718;
	bh=g5VQcWsmqiVDgYsNlYIflv1UEzW6X1zhLwnL9pCzVWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dN/VcfQBXvQivLN+JU2zOegHpzJoQIMEGwXaQQwFbv+KQ+xjWoGeIyoOSR2UybuYq
	 otFwGV4qd8oIW3dhYCux6vPa4P3oZLYDXQ9tvRKD71im8U2/EIx10U2H1syfYe16XP
	 BM0CLyCoaeSwVR5tA3/TPvXaWEcHwsA/9IVejYQsksjwMX7wTV0eJYWPirrqKLZ8UC
	 V1S5sf6IMXkbDIr7L7IPBF0uWEglD3DOOeAlp8ij8c/BAoqi6BMcKafJvTXpPSlT+t
	 fS0OuXhHhavZCPe479JoqZJH1O5DLFXkxdTcLKMHtm4FnVQCsw/w3AtpjH+GY3Lgzw
	 ZtymKsNxGKeZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/4] net: mvpp2: sync RX data at the hardware
 packet offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Til Kaiser" <mail@tk154.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602164635.62517-2-mail@tk154.de>
References: <20260602164635.62517-2-mail@tk154.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:55:18 +0000
Message-Id: <20260603165518.96EE11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware address confusion in mvpp2_buff_hdr_pool_put leading to w=
ild pointer dereference.
--

commit 5455df1ccac8168f900ec83f5414e617fb3ad72f
Author: Til Kaiser <mail@tk154.de>

net: mvpp2: sync RX data at the hardware packet offset

This commit modifies the DMA sync offset for received packets in mvpp2_rx.
It uses dma_sync_single_range_for_cpu with MVPP2_SKB_HEADROOM so the CPU
sync correctly aligns with the data written by the hardware.

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
This isn't a bug introduced by this patch, but when rx_status has
MVPP2_RXD_BUF_HDR set, this code jumps to err_drop_frame and eventually
calls mvpp2_buff_hdr_pool_put(). Does mvpp2_buff_hdr_pool_put() swap the
physical and DMA addresses?

Looking at mvpp2_buff_hdr_pool_put():

	phys_addr =3D mvpp2_rxdesc_dma_addr_get(port, rx_desc);
	dma_addr =3D mvpp2_rxdesc_cookie_get(port, rx_desc);

	do {
		buff_hdr =3D (struct mvpp2_buff_hdr *)phys_to_virt(phys_addr);

It appears that phys_addr is populated with a DMA address and dma_addr is
populated with the physical cookie.

On systems with an IOMMU where DMA addresses do not map 1:1 to physical
addresses, will calling phys_to_virt() on a DMA address cause a wild pointer
dereference? Could this also corrupt the hardware Buffer Manager pool when
passing these swapped addresses into mvpp2_bm_pool_put()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602164635.6251=
7-1-mail@tk154.de?part=3D1
