Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA44921A0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646819; cv=none; b=R5GuK6KVjEwScmeLGDmcZBlLq+DTouDLyBdS5Qd6WPjGPUpcWRbVpHXSZO3+QMtII0iTeR6oiYy+H/5Lmk3brUmmjLHMNR6jHZwiNw0tzoPfPCaK4k/yAfCFtYOChFeEHNx3YTFCDF4is4VUWV3SKebRjjbbnBWtiWHolMQiYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646819; c=relaxed/simple;
	bh=pFZR+8RvDEIv6tQTT7ySou4uiwJo7wmVoJOcfhhm2c8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NaU45saL+4IyoqX9/ec34PVVcvr6TAq37iQCq3eJLPP4TDfXq8jg0/r3MXHOAJloRdfds9spb2h1viPA0YlqFrL0a+6cJ1p462116ME99FNg2e//QUl12K+CYxMx4UotNd05iA+AThDMYiR1AtrdLsS9J86EJH0OURdCe3fWFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfGAd4HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfGAd4HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCC41F00893;
	Fri,  5 Jun 2026 08:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646818;
	bh=gyLzvMgclJq9B4NioerT2cmfuv0+ZJzOkhJLn2F5DtQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UfGAd4HSYCSZt0cM3QX+XIGBKgzFwTq8IISlBbqgQTDBebdnUI9wfWQGlJOgg/yWn
	 JcZh2Qu1dgZ+juZZuYsqhK5n/n9DXG4pwuBF+JQU6RmzoZ9a1jyPADtq3ir7lViD4z
	 zddu9LJYUzZd/R0/S2b4krN6ednHkwNDh7MUZNn2t71YxyjbpyamnHcX+LhjWS9+Es
	 XhEkrxrcq+MUsn5PW/bayFjZBTBL2wchZh83GL++AzcJzQNLwUfxTvJqiKXAQ7uhei
	 ApOLhYWMS5sWzNb6AEu7Gsi9wKE6Ptp+5kXwizIlvOg+O8DMcPtiy0N0Ex1ZGZaIdQ
	 KXiGwC8oQATtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: prevent kernel panic during XDP program
 and XSK pool transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Carlos Fangmeier" <carlos.fangmeier@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
References: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 08:06:57 +0000
Message-Id: <20260605080657.DCCC41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unconditional `netif_tx_wake_all_queues()` on error paths forces e=
arly transmit, leading to NULL pointer dereferences.
- [High] Global TX queue operations during single-queue XSK pool reconfigur=
ation destroy flow control state for unaffected queues.
- [Medium] The added synchronization logic in `stmmac_xdp_set_prog()` is in=
effective, redundant, and based on a flawed premise.

Pre-existing issues:
- [High] Missing error handling for `stmmac_enable_tx_queue` and `stmmac_en=
able_rx_queue` allocations leads to crashes during XSK pool setup.
--

commit 5f08fcd5650e1c25484ffcb83c996e73d9df4bd4
Author: Carlos Fangmeier <carlos.fangmeier@gmail.com>
Subject: net: stmmac: prevent kernel panic during XDP program and XSK pool =
transitions

This commit attempts to prevent races with pending TX work during XDP and
XSK pool reconfigurations by wrapping the operations with netif_tx_disable()
and netif_tx_wake_all_queues().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/n=
et/ethernet/stmicro/stmmac/stmmac_xdp.c
> index d7e4db7224b0c..a6611aee687fd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> @@ -34,6 +34,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *p=
riv,
>  	need_update =3D netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
> =20
>  	if (need_update) {
> +		netif_tx_disable(priv->dev);
>  		napi_disable(&ch->rx_napi);
>  		napi_disable(&ch->tx_napi);
>  		stmmac_disable_rx_queue(priv, queue);
> @@ -46,6 +47,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *p=
riv,
>  		stmmac_enable_rx_queue(priv, queue);
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rxtx_napi);

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of error retur=
ns
from stmmac_enable_tx_queue() and stmmac_enable_rx_queue() risk kernel pani=
cs
if descriptor allocations fail?

Currently, if __alloc_dma_tx_desc_resources() fails inside
stmmac_enable_tx_queue(), it prints an error and returns early without
initializing the rings.

Since the function returns void, stmmac_xdp_enable_pool() blindly proceeds
to call napi_enable(), which could cause a crash when NAPI or the TX path
dereferences uninitialized pointers.

> +		netif_tx_wake_all_queues(priv->dev);

[Severity: High]
Does calling netif_tx_wake_all_queues() here unintentionally clear the flow
control state for other unaffected transmit queues?

Since stmmac_xdp_enable_pool() only reconfigures a single DMA queue, waking
all queues will clear the off state for every queue on the netdev.

If another queue was intentionally stopped due to actual backpressure becau=
se
its DMA ring was full during stmmac_xmit(), the network stack might
erroneously resume transmitting on that full queue, leading to dropped pack=
ets.

[ ... ]

> @@ -72,6 +74,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *=
priv, u16 queue)
>  	need_update =3D netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
> =20
>  	if (need_update) {
> +		netif_tx_disable(priv->dev);
>  		napi_disable(&ch->rxtx_napi);
>  		stmmac_disable_rx_queue(priv, queue);
>  		stmmac_disable_tx_queue(priv, queue);
> @@ -87,6 +90,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *=
priv, u16 queue)
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rx_napi);
>  		napi_enable(&ch->tx_napi);
> +		netif_tx_wake_all_queues(priv->dev);
>  	}

[Severity: High]
Does this also suffer from the same issue as stmmac_xdp_enable_pool(), where
a global queue wake overrides the flow control state for all other unaffect=
ed
TX queues?

[ ... ]

> @@ -121,8 +125,10 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, st=
ruct bpf_prog *prog,
>  		xdp_features_clear_redirect_target(dev);
> =20
>  	need_update =3D !!priv->xdp_prog !=3D !!prog;
> -	if (if_running && need_update)
> +	if (if_running && need_update) {
> +		netif_tx_disable(dev);
>  		stmmac_xdp_release(dev);
> +	}

[Severity: Medium]
Is this netif_tx_disable() redundant, and does it actually prevent the race
during transitions?

Looking at stmmac_xdp_release(), it already calls netif_tx_disable()
internally.

Furthermore, on the success path, stmmac_xdp_open() calls
netif_tx_start_all_queues() before returning, meaning TX is re-enabled early
regardless of the wrapper added here. It appears the perceived race window
might remain identical.

>  	old_prog =3D xchg(&priv->xdp_prog, prog);
>  	if (old_prog)
> @@ -131,8 +137,10 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, st=
ruct bpf_prog *prog,
>  	/* Disable RX SPH for XDP operation */
>  	priv->sph_active =3D priv->sph_capable && !stmmac_xdp_is_enabled(priv);
> =20
> -	if (if_running && need_update)
> +	if (if_running && need_update) {
>  		stmmac_xdp_open(dev);
> +		netif_tx_wake_all_queues(dev);
> +	}

[Severity: High]
Could this netif_tx_wake_all_queues() force an early transmit and lead to a
panic if stmmac_xdp_open() fails?

If stmmac_xdp_open() returns an error, for example due to DMA descriptor
allocation failure, the DMA rings are not initialized.

Because this code unconditionally wakes all TX queues regardless of success,
the network stack will immediately resume transmission, and stmmac_xmit()
may dereference freed or uninitialized rings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-main-v1-1-=
aed15b1cf1af@gmail.com?part=3D1
