Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E9134F46D
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869222; cv=none; b=jlN6pVWfgjq43Om/1B7ng+T3Lht0qANaXnfe+ZQMVDVbGFm5eZet67dfsuKiaEsBBQbFOsV5Yr/IxQKncL2j8pXr5jak5EMVlUEErCuAbFliNP1m2QBya4Q3BvYFLxlo2qynI9O5XNkVh63QaspuZG1oQ0r1gOzJAO+M1dfYUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869222; c=relaxed/simple;
	bh=QLzVzKWKFiDd4T0/gB8IE0iAWVELhGn5cOriOd8poZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QbT7tcL5zfMA2Oaf2BSTmroEi5fNo5MWFfY8rVZp2lAegVSAwNz3aibcw5QN3pux5fpSJQPBRbckEb5pbw+F4bXr8jMJuaqdoXOCHo1k6LE2DjtgBdyqscx6r4Gq7qnZYo1A29sZy0UmuyI2OPsMgbkEV16qipOhRwFvSz6wJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEEWjYEi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEEWjYEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FAE1F000E9;
	Tue,  4 Aug 2026 18:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869221;
	bh=VJHkQy6ZJHniVJ5MuMDYlr2YsdSYwE4XXd4a0Htb2vQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mEEWjYEi3AOdH9kKBm23yx4EoBNUSEdnVNG86Bt+yygQe1voFvQ1jAT9h348Si866
	 v9Mp/4YuqXnwo5c9V/uY2OPGn+goGar5GOcORsmsOpyoLC3hG9/S0X+qyu+2hM5D7S
	 XKlChcEywrzmuHWdIUxV2Itye+iRuKJTZ1LrWGYNXcpruJMV2vpFSRZDpASm4t80tc
	 vFxCUb3NWb10PwRb5V8fOfM2xuHjYtQUiTM+1RtExy1BxhW8FX6OMR8o/v1dnjvePa
	 KXvHRG6GUKfe/fTA9MKxbL3tRhHN/ap5S2nLYhozY6dhw4j/+XJ8hoU3hf/trW3cDZ
	 yd/VGN4frjJpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 08/15] gve: refactor gve_init_priv for reset
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803184630.3813311-9-hramamurthy@google.com>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-9-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:47:00 +0000
Message-Id: <20260804184701.43FAE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] AF_XDP zero-copy socket pool bindings are broken and their DMA map=
pings are leaked across device resets.
- [High] Concurrent use-after-free and NULL pointer dereference of `priv->s=
tats_report` during `gve_stats_report_task`.
--

--- Patch [8]: [PATCH net-next v3 08/15] gve: refactor gve_init_priv for re=
set path ---
commit 02971463a0e35f7deed56d888e3c49b020365965
Author: Harshitha Ramamurthy <hramamurthy@google.com>
gve: refactor gve_init_priv for reset path

This patch refactors device initialization into distinct steps by introduci=
ng
gve_setup_device() and gve_adminq_init(). It reorganizes device properties
configuration to ensure gve_init_priv() is only called once, preparing the
driver for upcoming mailbox mode additions.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> @@ -2414,6 +2414,35 @@ static void gve_set_buf_sizes(struct gve_priv *pri=
v)
>  		priv->header_buf_size =3D device_info->header_buf_size;
>  }
> =20
> +static int gve_setup_device(struct gve_priv *priv)
> +{
> +	int err;
> +
> +	priv->num_registered_pages =3D 0;
> +
> +	priv->xsk_pools =3D bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditionally
overwrite the existing AF_XDP zero-copy socket pool bindings across a reset?

When a reset occurs (e.g., via MTU change or watchdog timeout),
gve_setup_device() re-allocates priv->xsk_pools as a new, zeroed bitmap. The
old bitmap is freed during teardown, but the previously bound XSK pools do
not appear to be restored.

Consequently, when queues are restarted, wouldn't gve_get_xsk_pool() return
NULL, causing XDP zero-copy registration to be skipped and fall back to
standard memory models (PAGE_SHARED/PAGE_POOL)?

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
> +err:
> +	return err;
> +}

[Severity: High]
This is a pre-existing issue, but since this patch refactors the device set=
up
and reset recovery paths, could there be a race condition when tearing down
the stats report?

In gve_free_stats_report(), the stats timer is deleted and the stats_report
DMA memory is freed. However, it does not call
cancel_work_sync(&priv->stats_report_task).

If the gve_stats_report_task executes asynchronously on priv->gve_wq during
or immediately after the memory is freed, could it lead to a use-after-free
or NULL pointer dereference when accessing priv->stats_report->stats in
gve_handle_report_stats()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803184630.3813=
311-1-hramamurthy@google.com?part=3D8
