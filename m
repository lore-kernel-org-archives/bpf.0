Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3073ED5A7
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370130; cv=none; b=jse+vjNm7TvTSgPnDBSyut+CMYAfc0uYuOcybla6+ggbw6KfdOndeQmhawB7eBHrrYbTqqcXBXsdwUCnYFJ2WwEpjLl8MjhHabkwPFuUYj/a98eidlLqio65Gth3yDNWCpJKIt6BwOh9wQ32vbiccdv/vzcSu7OXbTUQMT+WGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370130; c=relaxed/simple;
	bh=fIA4velGk9MhEUhnKX7nJdFF1y/+PS3rI2OKLyYUalk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0sOcJnjJ6hKk4Pa14g/R0BsYLI/Ih0mWfIQMSdaDugjR0BzmCfqyU8FLsLlZ4qp1H7ggso8A7RKEZwvIx+dfsWlfShgMCVudMnUG+AYPOSBvg+A3iJogWYwVsVRgZImkqprblrCG9RTNQTD7J/lyHiXKmCZf+pdEhqwu35YafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3WzLXYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3WzLXYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7891C2BCAF;
	Thu, 16 Apr 2026 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776370129;
	bh=fIA4velGk9MhEUhnKX7nJdFF1y/+PS3rI2OKLyYUalk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d3WzLXYZdihFf/TLXlPvPTNjeHSIWmrgwkSE3nkI+pJQy7GYG2Z3+9WsL/sJQorC6
	 tbZD2P5qvxlo1lFu7Ni3K0ifMrzWuID2buhGuGgRCi+9b4nL0+7zQVFgmCmNeWkAhM
	 0N8a17OxfA45CKSdOLtPkpUv9naRJyqyO0RfUHj+6+pQKNYbCdonPCN+gtykdJBAsB
	 cXqwDTrKG+OPkQLipJSjooJ6NBzpYyt97SenKnqY1dBlxCCX6UTrfxthyF+TeXw7M2
	 Hry5HZu02reFXYwdHXMGYI2CVjjJ3Yj+pNng8waGNFPgXdPe3NS8cvCzIJiDyQtwOX
	 fKFCem+FHENvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 6/7] net: bcmgenet: add XDP statistics
 counters
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416054743.1289191-7-nb@tipi-net.de>
References: <20260416054743.1289191-7-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 20:08:49 +0000
Message-Id: <20260416200849.A7891C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Data race and lost increments on global XDP statistics
- [Medium] Missing statistics increment on frame conversion failure
- [Low] Integer overflow of fast-path software statistics
--

commit 7b7f282ba7f7296a985c1fcb93f530101e6a4b26
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add XDP statistics counters

This commit adds XDP statistics counters to the bcmgenet driver. It exposes
xdp_pass, xdp_drop, xdp_tx, xdp_tx_err, xdp_redirect, and xdp_redirect_err
via ethtool statistics.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2428,6 +2435,7 @@ static unsigned int bcmgenet_run_xdp(struct bcmgene=
t_rx_ring *ring,
> =20
>  	switch (act) {
>  	case XDP_PASS:
> +		priv->mib.xdp_pass++;

Is it possible for multiple RX queues to execute this concurrently?

Since priv->mib is global to the device, it seems concurrent NAPI contexts
executing on different CPUs could cause data races and lost increments. Sho=
uld
these counters be tracked per-queue and aggregated, similar to the existing
tx_rings and rx_rings stats64 counters?

>  		return XDP_PASS;
>  	case XDP_TX:
>  		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET

[ ... ]

>  		xdp->data -=3D sizeof(struct status_64);
>  		xdp->data_meta -=3D sizeof(struct status_64);
>  		memset(xdp->data, 0, sizeof(struct status_64));
> =20
>  		xdpf =3D xdp_convert_buff_to_frame(xdp);
>  		if (unlikely(!xdpf)) {
>  			page_pool_put_full_page(ring->page_pool, rx_page,
>  						true);

Does this code miss a stat increment when xdp_convert_buff_to_frame fails?

It returns XDP_DROP here without incrementing xdp_tx_err or xdp_drop, unlike
the other failure paths in this same block.

>  			return XDP_DROP;
>  		}

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.h
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h

[ ... ]

> @@ -156,6 +156,12 @@ struct bcmgenet_mib_counters {
>  	u32	tx_dma_failed;
>  	u32	tx_realloc_tsb;
>  	u32	tx_realloc_tsb_failed;
> +	u32	xdp_pass;
> +	u32	xdp_drop;
> +	u32	xdp_tx;
> +	u32	xdp_tx_err;
> +	u32	xdp_redirect;
> +	u32	xdp_redirect_err;
>  };

Since these are fast-path software counters for XDP, can they wrap around
quickly on 32-bit types? Would using 64-bit types like u64_stats_t be safer
to avoid silent wrap-arounds for long-term statistics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416054743.1289=
191-1-nb@tipi-net.de?part=3D6
