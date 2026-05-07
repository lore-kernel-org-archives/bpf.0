Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBC481669
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181479; cv=none; b=NNGFQEoRdDkcYzrsrhMAKXJFFxREw9TuBDgHAlpolIDL/akqJ+Xafc+KAUp6ycVNTD6PLmANPTcC8PMSxsL/qMjnLQeNtKN3LOfJ0ZFrAHkhd7+LvDyAkqbcubxhFS0y8N/AgEC/LrDl6ia2+g7vtBdbgfvNZjPPzjauiBRTyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181479; c=relaxed/simple;
	bh=jVFOjokF1p4qCAe7/vAbjzXz7NAiz6hQhYvmG2TT/h4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MJbqsftu20ljXCZpmJiunuCq78cJ62T01/CFoHYh4N5Sz7SdsKNhNQ3UcdnTw/aRNmj/RrN8hJwGv28dweWmysAE8c+LbjpSAIckFxRvO3m+0zopJuT8pXbTTfz05SVHr7YZCCVmXR/KwEvyaG6CCwd7TAowB9IqcTuyAyGT458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMLH0TsR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMLH0TsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3D3C2BCB8;
	Thu,  7 May 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181479;
	bh=jVFOjokF1p4qCAe7/vAbjzXz7NAiz6hQhYvmG2TT/h4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cMLH0TsRtdvaQR43gQ4v8hIxap1skwZzyH+ymuc2iIS/aTinJQQL0rqnWSI7QSlmp
	 e1nNFhEEwbP68ps46mwUcxErWznRjHQHVFOIm37UeRa+ZbHsuPk7GYgsffoOo9UjA+
	 gZSgbzkhS+e6mtOdhvU/LiqSHKTRfqOz9Q5MnxjfNDCEdgzr8hVL0+APMP0On/LXqS
	 bZut38hBr3IXjk/7jKxiL/W9jzmOVTO8ODmS+Ng5zme9MWxy18qvpyckLLHIuUz1aV
	 cRNoABXYuSKqwNksp5SbBiSklxeEvliHyF0UGalsjz12LzN0ajtAnB0eqmLHTO6o7A
	 Nk4RRfYTPJukA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 5/7] net: bcmgenet: add XDP_REDIRECT and
 ndo_xdp_xmit support
Reply-To: sashiko@lists.linux.dev
To: "Nicolai Buchwitz" <nb@tipi-net.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506095553.55357-6-nb@tipi-net.de>
References: <20260506095553.55357-6-nb@tipi-net.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 19:17:58 +0000
Message-Id: <20260507191759.2A3D3C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The ndo_xdp_xmit implementation can permanently stall because the =
XDP TX ring (ring 16) is only reclaimed during RX NAPI polling, which may n=
ever run if the interface receives no packets.
--

commit 606bc29cba0382a693d9785fe2fe2ff9ee75e598
Author: Nicolai Buchwitz <nb@tipi-net.de>

net: bcmgenet: add XDP_REDIRECT and ndo_xdp_xmit support

This commit adds XDP_REDIRECT support and implements ndo_xdp_xmit for
receiving redirected frames from other devices.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net=
/ethernet/broadcom/genet/bcmgenet.c
> index f1e515526787a..4e4fe785f0bf5 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2332,22 +2332,22 @@ static struct sk_buff *bcmgenet_xdp_build_skb(str=
uct bcmgenet_rx_ring *ring,
>  	return skb;
>  }
> =20
> +/* Submit a single XDP frame to the TX ring. Caller must hold ring->lock.
> + * Returns true on success. Does not ring the doorbell - caller must
> + * write TDMA_PROD_INDEX after batching.
> + */
>  static bool bcmgenet_xdp_xmit_frame(struct bcmgenet_priv *priv,
> +				     struct bcmgenet_tx_ring *ring,
>  				     struct xdp_frame *xdpf, bool dma_map)
>  {
> -	struct bcmgenet_tx_ring *ring =3D &priv->xdp_tx_ring;
>  	struct device *kdev =3D &priv->pdev->dev;
>  	struct enet_cb *tx_cb_ptr;
>  	dma_addr_t mapping;
>  	unsigned int dma_len;
>  	u32 len_stat;
> =20
> -	spin_lock(&ring->lock);
> -
> -	if (ring->free_bds < 1) {
> -		spin_unlock(&ring->lock);
> +	if (ring->free_bds < 1)
>  		return false;

Can this ring permanently stall if the interface is only used as a redirect
destination?

Because the XDP TX ring has no TX completion interrupts, it relies entirely
on the RX NAPI handler to reclaim completed TX buffers. If the interface
receives no incoming traffic, the RX NAPI handler will never run.

Once the ring descriptors are filled, this check will continuously return
false, permanently dropping all subsequent redirected frames from
ndo_xdp_xmit.

Does ndo_xdp_xmit need to proactively reclaim TX buffers when the ring is
full, or use another mechanism to ensure completion?

> -	}
> =20
>  	tx_cb_ptr =3D bcmgenet_get_txcb(priv, ring);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506095553.5535=
7-1-nb@tipi-net.de?part=3D5
