Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973633A9615
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045653; cv=none; b=tPr7+BvhteMYWGEmUdUmcoIKHoph6zjlaKT54keYUejQv4vHLq5NzjpKuvB/sBw7twkdOoSiFM9n6MC9fAaJ3WvZGBbTt4gVSqkJCQIXO4+cnwWrN6not8Ef6EhYH7nvkJ3qhEcZmMUdTCl9orTPOgW/YmV2I5JxkR4FDQ19sTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045653; c=relaxed/simple;
	bh=+8MkJgrLqJzrUkXgAfHiflNQxC0Z5XY0jmQKvVhOEmw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WvKaeAhqfekw4oMM3peLFAhm7/h9HBlkXj8NeJqhfnDVfV0ia5t+/5byDuxctqwSiyGz/j6Cq7BFalEpELO5/AgP/dBSnByRxHw1M9lAhn0aj/zbPpxZENGDxgK3iOWXHy6Ab8tIzq5cOcXehlJLYydRXh2QJ1ixyHW5LJsTiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq4RqxKK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq4RqxKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087EA1F000C4;
	Thu, 15 Oct 2026 06:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792045652;
	bh=VdTpIHra/JzMGZebneaPv4GvgNdPjScvSxz+QTnYyII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iq4RqxKKj6Iav0Q8RU0uen2q6rX5ru8eK0HiHvO2fSLL6bCPD3cqEA79aHsYrQ+8b
	 gRkmyxaw6lmyyGfwvhWwzd+IgILjg3NvKMQ/OVbKXESZtRAbaPROCf03hHbDoZllAR
	 wSnq0ZrIVIdALhYXompEt3A3MCbZ1DXDoSuIK8fio2/fDSBGFKFzdc6656WWpxC2jd
	 yfkG5KTdHAH3AoGIId8ZjGMWOxIGAk1xmUIYb6YDUJ+6gZhvW2q96mxMuSeukB5MG8
	 L45d46ESVvNTaUplrtBqbnfc3vUpEicolxn+DIaQEuziID18tccJbHH3tvjR49A89N
	 2ftt76MJM2tXA==
Message-ID: <sashiko-outbox-172342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/3] net: stmmac: stop DMA when IRQ registration
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <2b70886410b5e9207ef170a48aca1d2d7ce24a68.1791958735.git.kmehltretter@gmail.com>
References: <cover.1791958735.git.kmehltretter@gmail.com>
 <2b70886410b5e9207ef170a48aca1d2d7ce24a68.1791958735.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 06:27:31 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net/stmmac: stmmac_xdp_set_prog() ignores stmmac_xdp_open() failure
- [Medium] net: stmmac: MAC Rx/Tx left enabled on open error paths
--

commit 7ffd7d4ee658f5d19fab03ed54e7532669eeea56
Author: Karl Mehltretter <kmehltretter@gmail.com>

net: stmmac: stop DMA when IRQ registration fails

Both __stmmac_open() and stmmac_xdp_open() start DMA before requesting
IRQs. If IRQ registration fails, their error paths release descriptors
and packet buffers while the DMA channels remain active.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 8fd7d21730911..5c4df26a64bd6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4206,6 +4206,7 @@ static int __stmmac_open(struct net_device *dev,
>  	for (chan =3D 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> =20
> +	stmmac_stop_all_dma(priv);

[Severity: Medium]
In this error path, phylink_stop() is called just above this snippet, but it
only invokes the driver's mac_link_down callback if the link is considered
logically UP.

If the link was never UP, the MAC hardware is left active since it was
enabled earlier during stmmac_hw_setup().

Should the MAC be explicitly disabled here so it doesn't remain permanently
active?

>  	stmmac_release_ptp(priv);
>  init_error:
>  	return ret;
> @@ -7259,6 +7260,7 @@ int stmmac_xdp_open(struct net_device *dev)
>  irq_error:
>  	for (chan =3D 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> +	stmmac_stop_all_dma(priv);

[Severity: Medium]
Earlier in stmmac_xdp_open(), the MAC is explicitly enabled with
stmmac_mac_set(..., true).

However, this error cleanup path lacks the corresponding
stmmac_mac_set(..., false).

Will the MAC continue to process incoming packets and potentially overflow
the internal MTL FIFOs while the DMA and IRQs are stopped?

[Severity: High]
If we hit this error path, stmmac_xdp_open() cleans up its descriptors
and returns an error.

However, its caller stmmac_xdp_set_prog() ignores this return value:

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
    ...
	if (if_running && need_update)
		stmmac_xdp_open(dev);

	if (prog)
		xdp_features_set_redirect_target(dev, false);

	return 0;
}

If an error occurs here, does this leave the interface functionally dead
while still reporting success to userspace?

> =20
>  init_error:
>  	free_dma_desc_resources(priv, &priv->dma_conf);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791958735.gi=
t.kmehltretter@gmail.com?part=3D3
