Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043A3845D8
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214276; cv=none; b=nDylrs0jPmjpWu+iBy+Zq8Mq6RPZ3dj84wQKRjeuZvmBNWbsatRuzOCbiHcXLWXxUdNHOj0b95rpMeUVRthUY//h8qJvveiyzcyStYvAPY7tCJa6V1nIDU8DPSRYTnYM6JtnlJkw2uHuaYKakHwEfksX+Pr1O1zg2W6iKSpzgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214276; c=relaxed/simple;
	bh=xXsACAlWa6JlCH/kB+cziz+ENWQqq8ripw2SZX7B164=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ABslYTRJb8zA2HWahpfZLHA4IiBQIKMaVsJERGWisRgvNDSmtXFvrei8afhQ0Zt8Ofuix+2HFVBr3v1ksVeK6QcDzFRncqUhTYAkU7dv7NjGzGsWj0vQ0HDAh7UguBI+sfgyVTZ3G/YgJnCmtc8nYBrZoQ0zRKsCV30FM3IROk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb8wrPIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb8wrPIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3454D1F00899;
	Thu, 24 Sep 2026 01:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214275;
	bh=DIQN11H73WBv7vLSNeVS8+ojRn+JvGixOfQ7ffQJIlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lb8wrPIsFQbtajnDmIqArwWLOandOsJJ8sUxYdEHlkT87fnBEUwiL2VZJenm3T+tG
	 +qCFvDLyWxY1JEi+dFbLsC5mnx0bP5gvSMlcW4HXlAwBNzVd3aDDdJcWnpd5yvoyN1
	 EOJEh3/inm4+3O6vX4WfsNYtENOAt8FsFAWWxldM1KjUKPaEJzSyT259E6MndIuv8J
	 Fe7NFhWrqSTBB04UBw4+rWtMDxeJTZpuq/Iscom0s+qXEhb3dCqdwM76v2267gyk3B
	 wSv2rBo46gY+KhG2deXCu2bP/76vKcHpY0NWLZfptEv1PIrJdZdb7Sxs1vZhV+bumA
	 HTkj17HR2LZQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 6/8] eth: mpnic: add a netdevice and basic Tx
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Zahka" <daniel.zahka@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260922-linux-mpnic-v1-6-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
 <20260922-linux-mpnic-v1-6-236844f53072@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 01:44:34 +0000
Message-Id: <20260924014435.3454D1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: mpnic: invalid dma_map_single() with size 0 for completely pa=
ged SKBs
--

commit 8d7cf250060d2193a80aa7f55598e2da19bf8165
Author: Daniel Zahka <daniel.zahka@gmail.com>

eth: mpnic: add a netdevice and basic Tx handling

This commit registers the mpnic network interface and implements basic
transmit handling, including doorbell logic and descriptor mapping.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_txrx.c
> index cb4d1427434c9..f4ad8caf6ce66 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -67,6 +92,138 @@ static void mpnic_unmap_page_twd(struct device *dev, =
__le64 *twd)
>  		       FIELD_GET(MPNIC_TWD_LEN, raw_twd), DMA_TO_DEVICE);
>  }
> =20
> +static bool
> +mpnic_tx_map(struct mpnic_ring *ring, struct sk_buff *skb, __le64 *meta)
> +{
> +	struct device *dev =3D skb->dev->dev.parent;
> +	unsigned int tail =3D ring->tail, first;
> +	unsigned int size, data_len;
> +	skb_frag_t *frag;
> +	dma_addr_t dma;
> +	__le64 *twd;
> +
> +	tail++;
> +	tail &=3D ring->size_mask;
> +	first =3D tail;
> +
> +	size =3D skb_headlen(skb);
> +	data_len =3D skb->data_len;
> +
> +	if (size > FIELD_MAX(MPNIC_TWD_LEN))
> +		goto err_dma;
> +
> +	dma =3D dma_map_single(dev, skb->data, size, DMA_TO_DEVICE);

[Severity: High]
Does this code map a zero-length region if the skb is completely paged?

If a completely paged skb is transmitted (for example, from an af_packet
socket) where the total length is large enough to bypass padding but
skb_headlen(skb) is 0, size will be 0 here.

Calling dma_map_single() with a size of 0 violates the DMA API contract and
triggers a WARN_ON_ONCE. It also submits a 0-length data descriptor to the
device, which might stall the transmit queue or crash the firmware.

> +
> +	for (frag =3D &skb_shinfo(skb)->frags[0];; frag++) {
> +		twd =3D &ring->desc[tail];

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-linux-mpni=
c-v1-0-236844f53072@gmail.com?part=3D6
