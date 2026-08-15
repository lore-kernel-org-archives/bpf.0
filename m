Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003D34252B
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760081; cv=none; b=iIdXhvWOCF5IVYmd73dAxZzncF85F4tU7hkKXxJTnePYVaHOd6SeOmDT9wzc5XXGGOJv6Ob+AYqlfsyl3nXBip+kDjqYZteH52aX/Z0FL9rFgDj/N0qM8Klns1+1STFGsiF0MwWkPi0ht4bwUubrLajYyX3nUiaBJr7mSa1OoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760081; c=relaxed/simple;
	bh=53XxteKHfA/1qxxZi3kwhPTWj8YmpD/kGePz5WLWSSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dl0BOvKjXVMRv0zSvjeqMwh8ZAOEQfT7q7fqOWJ+mmyS4AFeLXQyZGloRYjB029OYQkSywR4Bb55Uo3Yvd6ICQ+38nZ6jwOyWtkmrvcP719hEqucTn0Sz5+X126BzQhmK0hsIbcecCP6dZPNdIAgI51rIvrnjb6bvememkx8res=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYojdYAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYojdYAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECD61F00A3A;
	Sat, 15 Aug 2026 02:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760080;
	bh=nJKS3O0hP+Q1N+VgCpLDxU7NWM7Gip8ib1zgpKKLPfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYojdYAMx4sDIc72bwbI0BuFN5EQ5St6hWxA+AYP36lgxNEqXghKPvN+3UGq9muMx
	 lWW1UGw/6HgsB967x9b+kfmZ+7SWKC3XpfwMcdupllleFCQq+A0tGPZfVqYvu+LIFb
	 LrfBy6/HRMnMTNJdsvrkJoop315b2cJxBO+ViE9dgbH25s/X18uqW+JVmMWbiXUH48
	 svEN3gkQHTuLB8WoU3/ZHT6vqbi0v7a8AwupO8Wru0ArdchthlJi+iY8uVOR7evK5b
	 48RTkuQm6iv8oy4+TnMDvGmeqTy4ECKwP4d1C7Vzn8YHihfQoinvA6dIgAaDN+z41a
	 31YBECZ2zhRJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 14/15] gve: add ctrl ops to for queue
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-15-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-15-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:39 +0000
Message-Id: <20260815021440.4ECD61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double logging remains in the create queues error path, contradi=
cting the commit message.
--

--- Patch [14]: [PATCH net-next v4 14/15] gve: add ctrl ops to for queue op=
erations ---
commit 026806681c18ac8de5714de37a0562162a553296
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: add ctrl ops to for queue operations

This commit adds control operations for creating and destroying queues. It =
moves existing admin queue functions into the new ops structure to abstract=
 these operations.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index eecc988073951..500247b0e34aa 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> @@ -874,33 +874,18 @@ static int gve_unregister_qpls(struct gve_priv *pri=
v)
> =20
>  static int gve_create_rings(struct gve_priv *priv)
>  {
> -	int num_tx_queues =3D gve_num_tx_queues(priv);
>  	int err;
>  	int i;
> =20
> -	err =3D gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
> +	err =3D priv->ctrl_ops->create_queues(priv);
>  	if (err) {
> -		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
> -			  num_tx_queues);
> -		/* This failure will trigger a reset - no need to clean
> -		 * up
> -		 */
> -		return err;
> -	}
> -	netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
> -		  num_tx_queues);
> -
> -	err =3D gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues);
> -	if (err) {
> -		netif_err(priv, drv, priv->dev, "failed to create %d rx queues\n",
> -			  priv->rx_cfg.num_queues);
> +		netif_err(priv, drv, priv->dev,
> +			  "failed to create queues\n");

[Severity: Medium]
The v3 changelog notes state "remove double logging in the create queues
path", but doesn't this still leave a double logging issue when
create_queues() fails?

If priv->ctrl_ops->create_queues() (which maps to gve_adminq_create_queues(=
))
encounters an error, it logs a specific message:

drivers/net/ethernet/google/gve/gve_adminq.c:gve_adminq_create_queues() {
	...
	err =3D gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
	if (err) {
		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
			  num_tx_queues);
		return err;
	}
	...
}

Then it returns the error back here to gve_create_rings(), which logs a sec=
ond
generic "failed to create queues" message. Should this netif_err() in
gve_create_rings() be removed to fully resolve the double logging?

>  		/* This failure will trigger a reset - no need to clean
>  		 * up
>  		 */
>  		return err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D14
