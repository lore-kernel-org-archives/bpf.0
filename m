Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AD2D8378
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 02:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786760079; cv=none; b=YpraXwgFzwTWpOboKUIimFtyxpkU8lqT4sqPWLZ0rvs4fuS104Puauq/ftwe5SEjwngygb0yqiqWY5PA0dAlgAQ7TAW5n7GppdWqPAMpWhpvvUuOceMVYjICrYVq7sJZQj54Bf86nTmxt67sHFq1fOw4ZcTauDI7G5SCqNz9v3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786760079; c=relaxed/simple;
	bh=MaQaELpGQ8Whkiu/BIeEKOnHOZS/KRAM7ZuOIds8RRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qy/VFVjw4w+K3DJQMDlGYBou66PZ1aNYWZyoozMxQ9huaV7npI/GnS3TspISG6zQVugV9VA18VDcmFtZNgoNA2vzDf5gI1wFy9mvMQqg7C6dTBCeWtWFjhY2aovZ6yPUdee56SNRiDw/z4cOPyVNN+h2W1MmOVvoDTDZDEPJcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONFZB+2l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONFZB+2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03991F000E9;
	Sat, 15 Aug 2026 02:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786760077;
	bh=57cWLhveEVuEGjgnK2b0uZcA8ey6bPQyE5J2Aq5SwBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ONFZB+2lnJpphjitTnKMJIGv6C42KNWuIOMm/S/WjfUa9m+oldcDLfml1lYPP6fdV
	 PFwPb9TeLrdmK5JPAcDytlANe1q84Bvm1o00uq9cNh7VfYdoVcPrAcKok8cBV9xtLl
	 g7pJsS26QO96IP+fAPduGl21YDnJPKp8mkm5BXlgCw0B1Kqs6B8FYtjUeNEC8fNa30
	 8CfesXgjj0wbNr4QCr0xw8mpoiXh2wF0Hhj6pmQFhBTbi/5vr1d+SAtZ3xEiW2W+6x
	 hBnQmx685kWVTbhJwYo6mnJrDzPYow85Y75W2E2/sv60qheg9yeupFsPfBdx6SOqgi
	 zxlfBdzyAyTkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 08/15] gve: refactor gve_init_priv for reset
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814021406.3044324-9-hramamurthy@google.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
 <20260814021406.3044324-9-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 02:14:37 +0000
Message-Id: <20260815021437.A03991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AF_XDP socket pool bindings are silently detached and forgotten up=
on driver reset.
- [High] Background tasks (`stats_report_task`, `service_task`) are not can=
celed before the resources they depend on are freed, leading to a Use-After=
-Free and kernel panic.
- [High] Null Pointer Dereference in `gve_xsk_pool_enable` and `gve_xsk_poo=
l_disable` if device setup fails.
--

--- Patch [8]: [PATCH net-next v4 08/15] gve: refactor gve_init_priv for re=
set path ---
commit eabed5dc37b0260679aedc435501a49d2e938fb5
Author: Harshitha Ramamurthy <hramamurthy@google.com>

gve: refactor gve_init_priv for reset path

The driver does not need to renegotiate all properties with
the device on a reset since those should stay constant through
a reset. Hence change gve_init_priv() into a method that only
sets these properties into the priv structure and hence needs
to be only called once during gve_probe().

> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> +static int gve_setup_device(struct gve_priv *priv)
> +{
> +	int err;
> +
> +	priv->num_registered_pages =3D 0;
> +
> +	priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but does this allocation silently
detach and forget existing AF_XDP socket pool bindings upon a driver reset?

If a driver reset occurs, for example due to a Tx timeout, the recovery path
calls gve_setup_device() which unconditionally allocates a new, zeroed
xsk_pools bitmap.

When queues restart, gve_reg_xdp_info() will find no registered pools and
configure the hardware for standard traffic instead of zero-copy. Could this
cause existing AF_XDP applications to stop receiving and sending packets
without notification?

> +	if (!priv->xsk_pools) {
> +		err =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	gve_set_netdev_xdp_features(priv);
> +	if (!gve_is_gqi(priv))
> +		priv->dev->xdp_metadata_ops =3D &gve_xdp_metadata_ops;
> +
> +	err =3D gve_setup_device_resources(priv);
> +	if (err)
> +		goto err_free_xsk_bitmap;
> +
> +	return 0;
> +
> +err_free_xsk_bitmap:
> +	bitmap_free(priv->xsk_pools);
> +	priv->xsk_pools =3D NULL;

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer
dereference if the device setup fails?

If gve_setup_device() fails during a reset recovery and frees the bitmap,
xsk_pools is set to NULL. If a privileged user then attempts to attach or
detach an AF_XDP socket before the device is fully recovered:

gve_xsk_pool_enable()
    set_bit(qid, priv->xsk_pools);

Would this unconditionally dereference the NULL priv->xsk_pools pointer?

> +err:
> +	return err;
> +}
[ ... ]
> -err_free_xsk_bitmap:
> -	bitmap_free(priv->xsk_pools);
> -	priv->xsk_pools =3D NULL;
> -err:
> -	gve_adminq_free(priv);
> -	return err;
>  }
> =20
>  static void gve_teardown_priv_resources(struct gve_priv *priv)

[Severity: High]
This is a pre-existing issue not touched by this patch, but does the driver
have a use-after-free during module removal?

In gve_remove(), gve_teardown_priv_resources() is called before
destroy_workqueue(). This frees priv->stats_report.

Because the driver does not cancel the background tasks before freeing these
resources, if stats_report_task is queued, destroy_workqueue() will flush
and execute it. Could this cause gve_handle_report_stats() to dereference
the freed stats_report pointer and panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814021406.3044=
324-1-hramamurthy@google.com?part=3D8
