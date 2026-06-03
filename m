Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06D426EB7
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531169; cv=none; b=Urn7rOxerbg4+orBbyPQfdzjIDDzW2+PbM5BPhWl6mxB+/gTh58ggPep+fUylJiy/30eEUoib+N8KqbC6pJxSsaeRnraYoK/rvpb06g12c2UfYURABe6d0ij6Z9XqLzcIJoGWdZ8tEEH38Fjp9Vt2bCIKNDg4Pyx40W05injg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531169; c=relaxed/simple;
	bh=AWWHcsco4Ek8RWFitX+CvIOUdiznrVjYTnvna5YUvoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aTNQgEMTcSHfGFeNdcEfVpYmleX4HE3Nrbd2YBFDqLn6xRvg2uk9ZzN46H+Ww0J5ngTcYZMjoQ+OyHa6w2kVHTL2hFuk31QuLdRCuf6Oe1YcBbBaZUb+vsi8ayCFUj3XUXWAQEWYSwNJfkLt7aTS55+LVOh4ljxj8aQR4F+LbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5ywNcGt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5ywNcGt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9D81F00893;
	Wed,  3 Jun 2026 23:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531168;
	bh=+6252RbZSRPQaNvkgHnulL2UIlDUSjXt0AV63Ngr2uE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e5ywNcGtU+0XxRtJxknOb2bmQ3zssV74+51WdlWN8epcV2l0+380AGpQUd7l0v7/h
	 mSy6zUSdMoJT+ZqqkB+iXsIKaIWk1bKE8lRSNTIa6+fr0dHCi6slMLOmu3ExoVvHNH
	 sX3KoOOEU2V2siERe1EA9g7hIhK6irSb74HrDMlI5V0iTyDrA7UmpqHOBAzwIpL67p
	 GV9ewCBLjo6IYG9lU1GP1tzMxvv3TxB04q+lgDQ7aghXa0lRce09W6D2A6gtvoT/ah
	 PPcBWuHH5p3GFH9eKOTI+chPXkiCqiMz4+xwq9lwV8r5y0Go9cINNU1G+ajvrW5QQL
	 qFdPsfcG1AHBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 08/15] gve: refactor gve_init_priv for reset
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602235900.3050782-9-hramamurthy@google.com>
References: <20260602235900.3050782-9-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:59:27 +0000
Message-Id: <20260603235928.0B9D81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] gve_reset_recovery error path leaves device in a state where subse=
quent ndo_open causes Use-After-Free and NULL pointer dereferences.

Pre-existing issues:
- [High] Device reset leaks XSK pool DMA mappings and silently breaks XDP s=
ockets.
--

commit b96244d58e5385fb7dc71f1bd8136017d84f17d7
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: refactor gve_init_priv for reset path

This commit refactors gve_init_priv() into targeted setup functions to bypa=
ss
full initialization during the reset path. It moves admin queue allocation =
and
device properties negotiation into gve_probe(). This prepares the driver for
adding mailbox mode control plane initialization in upcoming patches.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index d693caed7e3d1..746ff69a28ddc 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2414,6 +2416,33 @@ static void gve_set_buf_sizes(struct gve_priv *pri=
v)
>  		priv->header_buf_size =3D device_info->header_buf_size;
>  }
> =20
> +static int gve_setup_device(struct gve_priv *priv)
> +{
> +	int err;
> +
> +	priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does this allocation cause an XDP socket
DMA mapping leak and silently break XDP sockets during a device reset?

When a device reset occurs, such as from a transmit timeout, the teardown
process frees the priv->xsk_pools bitmap without unmapping the active XDP
socket DMA mappings.

Then gve_reset_recovery() calls gve_setup_device() here, which allocates a
fresh, zeroed xsk_pools bitmap. When the interface is brought back up, the
driver reads the zeroed bitmap, forgetting which queues had active XSK pool=
s.
This causes XDP sockets to silently stop receiving traffic and permanently
leaks the DMA mappings established by gve_xsk_pool_enable().

> +	if (!priv->xsk_pools) {
> +		err =3D -ENOMEM;
> +		goto err;
> +	}

[ ... ]

> @@ -2554,15 +2540,29 @@ static int gve_reset_recovery(struct gve_priv *pr=
iv, bool was_up)
>  {
>  	int err;
> =20
> -	err =3D gve_init_priv(priv, true);
> -	if (err)
> +	err =3D gve_adminq_init(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Failed to alloc admin queue: err=3D%d\n", err);
>  		goto err;
> +	}
> +
> +	err =3D gve_setup_device(priv);
> +	if (err)
> +		goto err_free_adminq;
>  	if (was_up) {
>  		err =3D gve_open(priv->dev);
>  		if (err)
> -			goto err;
> +			goto err_free_device;
>  	}
>  	return 0;
> +
> +err_free_device:
> +	gve_teardown_device_resources(priv);
> +	bitmap_free(priv->xsk_pools);
> +	priv->xsk_pools =3D NULL;
> +err_free_adminq:
> +	gve_adminq_free(priv);

[Severity: High]
If gve_open() fails here, the error path tears down device resources (freei=
ng
priv->ntfy_blocks) and the admin queue DMA pool via gve_adminq_free().

However, the net_device remains registered. If a user subsequently attempts=
 to
bring the interface up, gve_open() is invoked again. Because gve_open()
currently does not check if resources are initialized, it proceeds to call
gve_queues_start().

Could this trigger a use-after-free in gve_adminq_issue_cmd() (dereferencing
priv->adminq from the destroyed pool) and a null pointer dereference in
gve_turnup() or gve_reg_xdp_info() (dereferencing priv->ntfy_blocks)?

I notice this issue is fixed later in the series by commit d54cafae24e9
("gve: simplify reset logic") which adds a gve_get_device_resources_ok()
check at the start of gve_open().

>  err:
>  	dev_err(&priv->pdev->dev, "Reset failed! !!! DISABLING ALL QUEUES !!!\n=
");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235900.3050=
782-1-hramamurthy@google.com?part=3D8
