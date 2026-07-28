Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805622C3255
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208022; cv=none; b=l5ZaZeaWCTs8jek7t6JgiqjY20ifu2OPw5vMgwDlQXJeMJlReCbbRphZwkgcBHexEY+otCeQpdhpdO191dGd+kY2XCZxaRl4ey6l7nTxN7ZycEsKyxBGWvYJZycBNbYyefdaewLrg64lOwUxwYEK0I8qSigQHb/j1EMp+//WMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208022; c=relaxed/simple;
	bh=dNYc2w3FeY8xUCgr8+F2M9FyTc2XnKSKmOvXLN/ZHMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AnolyIBceqaWiVtmFpUAzsSAUnYv8mVk4oJDxnjVenimA9zfVJQPiKXJXBS48UqeYYsDJrN8WsWUMBFs+ZzimvI8v98d2P4RAFGW1fLlORiK5khX5avtA+0kUFl6dN+2aXo7XqRwUG76brUJqqCkN9UYleGk5d9zAnyi6fOqud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLKGN4H+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLKGN4H+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AD31F000E9;
	Tue, 28 Jul 2026 03:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785208021;
	bh=f1XuOkkqb7faPdweoVb8hg9HmIpzIjkw9C4JtP2z6W4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jLKGN4H+U5r4eFVBAQgMqCanMfKEE/HLEI/+tRM9gHcVvPEhS8h5n2DcqXC8eS/B5
	 JF4Qld4FDT4nojIrTmG+XFDvaKMZNYVgXsc3E2bIyUyvAuqgz3jnw2NxDrVk0FqnnS
	 rthqKyLz8vcgWKjvvVXthphtAavxFcZS0ss2EoDPqlLX3O2Kj8MX+Un2BCD9stMebL
	 Gkaahmw3nsJuxW1eCrc62yDIAVaph12Ag86W4UkS3IhgNF1oIoV4LZag1lvXC/FZ0s
	 XVvPrW1dWQ8S8I9aSuiQktNany84i4s1hG//q25VWrU5Lh9kJ2zJYHEXrOHfDq5sOx
	 P6RFvh/P/zVJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: stmmac: Disable queues before netif_tx_disable
 in xdp_release
Reply-To: sashiko-reviews@lists.linux.dev
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260727030645.13280-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:07:00 +0000
Message-Id: <20260728030701.09AD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Reordering `netif_tx_disable()` after `hrtimer_cancel()` intro=
duces a TOCTOU race where a concurrent `ndo_start_xmit` can arm the TX time=
r after it has been canceled, leading to timer RB-tree corruption.

Pre-existing issues:
- [Critical] `stmmac_xdp_release()` frees DMA descriptor resources without =
synchronizing with concurrent `ndo_xdp_xmit` (XDP redirects) or fully stopp=
ing packet transmission, leading to a Use-After-Free.
- [Critical] `stmmac_xdp_set_prog()` ignores the return value of `stmmac_xd=
p_open()`, leading to a UAF if DMA descriptor allocation fails.
--

--- Patch [1]: [PATCH net] net: stmmac: Disable queues before netif_tx_disa=
ble in xdp_release ---
commit b78d98cf884a90fa124b2eaf510b02a6bb8585af
Author: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>

net: stmmac: Disable queues before netif_tx_disable in xdp_release

stmmac_xdp_release() calls netif_tx_disable() before
stmmac_disable_all_queues(), which creates a race window where NAPI
is still running while TX is being disabled. If a packet is still
queued at that point, it can be processed after TX is stopped,
leading to a kernel panic.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 151c77713025c..d806687788a8d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7085,15 +7085,15 @@ void stmmac_xdp_release(struct net_device *dev)
>  	struct stmmac_priv *priv =3D netdev_priv(dev);
>  	u8 chan;
> =20
> -	/* Ensure tx function is not running */
> -	netif_tx_disable(dev);
> -
>  	/* Disable NAPI process */
>  	stmmac_disable_all_queues(priv);
> =20
>  	for (chan =3D 0; chan < priv->plat->tx_queues_to_use; chan++)
>  		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
> =20
> +	/* Ensure tx function is not running */
> +	netif_tx_disable(dev);

[Severity: Critical]
By reordering netif_tx_disable() after hrtimer_cancel(), does this introduc=
e a
race where a concurrent ndo_start_xmit() can re-arm the TX timer after it h=
as
been canceled?

If CPU 1 is in stmmac_tx_timer_arm() (via ndo_start_xmit) and evaluates
!napi_is_scheduled() as true:

CPU 1
stmmac_tx_timer_arm()
    if (!napi_is_scheduled(...)) {

CPU 0 could then execute stmmac_disable_all_queues() and hrtimer_cancel().

When CPU 1 resumes, it will call hrtimer_start() to arm the timer. CPU 0 th=
en
calls netif_tx_disable(), but the timer is already armed and survives the
teardown, potentially leading to hrtimer RB-tree corruption.

> +
>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
> =20

While looking at this file, I noticed a pre-existing issue further down in
stmmac_xdp_release():

> 	/* Stop TX/RX DMA channels */
> 	stmmac_stop_all_dma(priv);
>=20
> 	/* Release and free the Rx/Tx resources */
> 	free_dma_desc_resources(priv, &priv->dma_conf);

[Severity: Critical]
This is a pre-existing issue, but does stmmac_xdp_release() free DMA
descriptor resources without synchronizing with concurrent XDP redirects?

Since STMMAC_DOWN is not set here and no RCU synchronization has occurred to
wait for XDP, if another interface processes an XDP redirect and invokes
stmmac_xdp_xmit():

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_xdp_xmit() {
    ...
	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
		return -ENETDOWN;
    ...
}

Will this proceed to write packet data to the freed tx_skbuff_dma array,
leading to a use-after-free?


I also noticed another pre-existing issue in stmmac_xdp_set_prog():

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
    ...
> 	/* Disable RX SPH for XDP operation */
> 	priv->sph_active =3D priv->sph_capable && !stmmac_xdp_is_enabled(priv);
>=20
> 	if (if_running && need_update)
> 		stmmac_xdp_open(dev);
>=20
> 	if (prog)
> 		xdp_features_set_redirect_target(dev, false);
>=20
> 	return 0;
> }

[Severity: Critical]
This is a pre-existing issue, but does this code ignore the return value of
stmmac_xdp_open()?

If stmmac_xdp_open() fails, it frees all DMA resources and returns an error.
Because stmmac_xdp_set_prog() ignores this error and returns 0, the device
remains logically UP but with freed DMA rings.

Could subsequent XDP redirects then invoke stmmac_xdp_xmit() and access the
freed tx_skbuff_dma structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727030645.1328=
0-1-muhammad.nazim.amirul.nazle.asmade@altera.com?part=3D1
