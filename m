Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFF3D0BE1
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909910; cv=none; b=KGo0nwSGJaHsUJH0I3oqaywCJMJB9p2LSowih6HTAsrHW3fKIm8aPTuc6iEatOnwhlhAyZkwpP98iAkJ4H4qkGbLqwa1qD+7oEhR77SCpsbJ5AgYvAU1vkvPivH/prU9mHd06yrRuojOrAM8R+0v2PEtHQb1hAKq8M8v6DHTVTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909910; c=relaxed/simple;
	bh=2VXrJKOEH1OVxRbjAL9JeuxpWS26Ibp60SOxdCjQYNI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K3zuuivTeHGtl2m+zFwHSKtZMxdJNxG+y/47rcprIv1BYOfr1FF4gxTM0B1yYmNY1zoXtI41OMM39k5oB0bd0/ntbeZaY8npMo4h3ZmzZLlPPtTOLF1PRZYl/JegSt2MnKQkxMY+SeveIrJyuVm8TU4pVZpSbmCJxBqPgxg75MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/MOwEk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/MOwEk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41051F00899;
	Tue, 13 Oct 2026 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909909;
	bh=pG5Pqxb534vKh56SbzdH0e7cvBr61H0ROzxyxQy/p/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i/MOwEk7WZA1dv8PTTmRJyUOjwOssUcf3+7BqbvcXwQXq+5Lhwo4URL0V6+PKT94G
	 FLTlQqhDg8MHlZGRKgSm0McE1eCvfk2QtzFAEuUy7hZFmSP++ldK0cKSlU0EIQsQaW
	 5fXshQNGBgBVXLY6YXsue1+nm7n5MX+G2QWzQ3z4REJ77YJBmvqBiDfRzcAvWQve1V
	 Aix0bHXY8DYTi+SHJF7A73lOTjdnM/1lLs3cE6RJQWwMqZsqURH4MGsgJxCkIn32Pu
	 iqOUPaTBMYEFgcSORVIoihnt93ATL9++/nUmSE/HO2+oqUWspub92T5FoxD+Ne4TlY
	 2ULG7IhOGr4ow==
Message-ID: <sashiko-outbox-170148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 3/4] net: stmmac: drop multi-buffer frames
 in XDP mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-3-2225050915c1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:45:08 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: lost increments of global rx_dropped/rx_errors in concurren=
t NAPI polls
--

commit 45e89e4ad29cf5d670b87e898ffe94eedf0e0127
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: drop multi-buffer frames in XDP mode

stmmac_rx() runs the XDP program once per descriptor buffer and uses skb =
=3D=3D
NULL as the only marker for the start of a frame. A frame larger than one
buffer is split by the hardware across several descriptors. XDP does not
support scatter-gather frames until the multi-buffer rework, so this commit
drops the whole frame instead.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 426bb68c9bbce..8c08d44fdbd39 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5893,18 +5893,24 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
> =20
>  		if (priv->extend_desc)
>  			stmmac_rx_extended_status(priv, &priv->xstats, rx_q->dma_erx + entry);
> -		if (unlikely(status =3D=3D discard_frame)) {
> -			page_pool_put_page(rx_q->page_pool, buf->page, 0, true);
> -			buf->page =3D NULL;
> +
> +		if (unlikely(!error && status =3D=3D discard_frame)) {
>  			error =3D 1;
>  			if (!priv->hwts_rx_en)
>  				rx_errors++;
>  		}
> =20
> -		if (unlikely(error && (status & rx_not_ls)))
> -			goto read_again;
> +		/* We do not support SG in XDP mode */
> +		if (unlikely(!error && (status & rx_not_ls) &&
> +			     stmmac_xdp_is_enabled(priv))) {
> +			rx_dropped++;

[Severity: Medium]
Will this lead to lost increments in the global rx_dropped and rx_errors
statistics?

The local rx_dropped and rx_errors counters are updated here, and at the
end of stmmac_rx() they are added directly to the global statistics:

	priv->xstats.rx_dropped +=3D rx_dropped;
	priv->xstats.rx_errors +=3D rx_errors;

When multiple NAPI handlers for different RX queues run concurrently on
different CPUs, could they race on updating these global counters without
synchronization?

> +			error =3D 1;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-stmmac-rx-=
mb-v6-0-2225050915c1@oss.qualcomm.com?part=3D3
