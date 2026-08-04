Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085F37187E
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869226; cv=none; b=spfxmkkRLLOu+o40oFG5BvvBSQgox/3XKzeuopevbMD0PR3aN5Ix05nVeBFzM5hh4cWDrHfr5sp/ZbEuraOgILW2MgUg0JGVbexHfvbNUY3vQQV/N7qy/w8MUsfjOcyyKvWEkDoQ12j72EMUjWkn7tZtzCHOSgAOlbqAiYDbmjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869226; c=relaxed/simple;
	bh=wYzYCcodDYvmLg2rTK9IvEufGoxz015kBZ/UAvfC3qE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BneJbqDODq1zDO3lKsL4OcMJ7wnAaTXtUDN3+9gX5AtEA5V04OrK47aG7ll9aqGB/Tl7DRYG9RP7BQW6RWrGLvqULAIF0dXtIFaj4JRnY5e2mI+nSiftnNSfEB1Gsrm8GBYSeEDGbuDiixAynuW1PBo/PMy9o/8T2ZDnlGVhjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjFVsXfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjFVsXfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445921F000E9;
	Tue,  4 Aug 2026 18:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869225;
	bh=0a2sfo+PUvlDfqJnXO+GOSpHr8C3r23VewW+l0V3agM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjFVsXfpcFgbgu8ycwYh8DH1RnxkpXzVGMv+vcp9Gvbofyb5sjCR1F6AciDrF9PLQ
	 TAiO1oNzlw3MHEHrygGl4ojXKghKSoY5qwRLA8CbpSV1+W1uE3NWlM77bpki65CPJO
	 KT/By3rMb1lI4j1v/tTIYF6iQBxj7btZrs6AqMnLX4kfje1RKpzyqR/NH9v2N5IJo8
	 m9O7j2Ov+6VrgjTnNeEPjV6rJHlzEym3vr45HUDgTT0jSnp8W5iI6Ikg8LLdQua/Sr
	 Xmnyw+AlS/hLFFjHMdlcQJiYWaPnGt0/ZVB0FRUWFiDuVVBpP+e+KmLfv93QeLiFpA
	 W9jlb5Lf8/KPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 14/15] gve: add ctrl ops to for queue
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803184630.3813311-15-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-15-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:47:04 +0000
Message-Id: <20260804184705.445921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces double logging for queue destruction failures,=
 despite the v3 changelog explicitly stating the intention to remove double=
 logging in the create queues path.
--

--- Patch [14]: [PATCH net-next v3 14/15] gve: add ctrl ops to for queue op=
erations ---
commit a53278495dc17ec056277ce3cbdbf3f6c7da4035
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: add ctrl ops to for queue operations

This commit abstracts the creation and destruction of queues into control
operations for the driver. The patch changelog for v3 explicitly notes
that double logging was removed in the create queues path.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c

[ ... ]

> +int gve_adminq_destroy_queues(struct gve_priv *priv)
> +{
> +	int num_tx_queues =3D gve_num_tx_queues(priv);
> +	int err;
> +
> +	err =3D gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
> +	if (err) {
> +		netif_err(priv, drv, priv->dev,
> +			  "failed to destroy tx queues\n");
> +		/* This failure will trigger a reset - no need to clean up */
> +		return err;
> +	}

[ ... ]

> +	err =3D gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
> +	if (err) {
> +		netif_err(priv, drv, priv->dev,
> +			  "failed to destroy rx queues\n");
> +		/* This failure will trigger a reset - no need to clean up */
> +		return err;
> +	}
> +	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
> +	return err;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -1052,26 +1034,16 @@ static int gve_queues_mem_alloc(struct gve_priv *=
priv,
> =20
>  static int gve_destroy_rings(struct gve_priv *priv)
>  {
> -	int num_tx_queues =3D gve_num_tx_queues(priv);
>  	int err;
> =20
> -	err =3D gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
> +	err =3D priv->ctrl_ops->destroy_queues(priv);
> +
>  	if (err) {
> -		netif_err(priv, drv, priv->dev,
> -			  "failed to destroy tx queues\n");
>  		/* This failure will trigger a reset - no need to clean up */
> -		return err;
> -	}
> -	netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
> -	err =3D gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
> -	if (err) {
>  		netif_err(priv, drv, priv->dev,
> -			  "failed to destroy rx queues\n");
> -		/* This failure will trigger a reset - no need to clean up */
> -		return err;
> +			  "failed to destroy queues\n");
>  	}

[Severity: Low]
The v3 changelog notes that double logging was removed for the queue creati=
on
path. Does this code unintentionally leave double logging in place for the
queue destruction path?

Since the underlying control operation, gve_adminq_destroy_queues(), now
prints specific error messages when tx or rx queue destruction fails,
this outer netif_err() in gve_destroy_rings() appears to log redundantly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803184630.3813=
311-1-hramamurthy@google.com?part=3D14
