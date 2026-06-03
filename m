Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BC4DD6CE
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531173; cv=none; b=R2wQ0V6Ilv79iCqoT8N/ZCay+HjfX4tKmqbXoojtsH/zSxAQ3deHJSbVQ/OUvYDZhvr7vBrLLBvlvrGclJhl6POakz9aW78L62Git6JZDFSUP3pi0cUJPdebKkg7XpLAqG8/l/jiWTyr3RR3Lc8RG/3Zj6Fs6zZB63mvtUVB+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531173; c=relaxed/simple;
	bh=Meh8CpHVUc/+PXJ7AdlA9zGXRqW5qTvzZYkt7Gz1OJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kOJJ4zboHpfU6cohalCw3k8O71s07RMwE6nfxsxtADc3IScwszlhPGH7aTz8mVAFlew64GVxCtWBNFEBSDsUji9AF+PtNbxHOdADKLndkHO8F4YfmYJTSEjfN9Jqez6SSyKaz8DW6KfAQSpOLr3Lv9/MOjGCq8K8pX0LLDiLQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8MiXJQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8MiXJQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569201F00898;
	Wed,  3 Jun 2026 23:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531172;
	bh=hNmEag5vVdFozAfrxfGAFincI7TYd3UTJco8nsH52uU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8MiXJQEioO/lQ/EWFlqlKH4bBs/uaBbq78yr20SGjrlXkdQSG4EsvvI/COj8ZQRL
	 VgO0wTxvNvWuFfnBlMiSwJ/zw+WRayT0t/dXGFuTmV7ogi093gi7JH38e90u5rYiQF
	 VCbq2+JwKepkZ+Q79iDRntAI8ZERuC8Y1n06+vA4zRGXBqvqpalluuc39GvsIC9wj/
	 Nn3ckAM6wR0bVLX+twnMnqJq9z2+rtZodwC2MPeBf+w8qME5LyJkq+qOZzx5hdcD6O
	 Exx8X5TZExvGLcBVljHndfEtkTZ+yQOCP1tMjqqiIHde1TlwFUPVzaBip5hiG/krxt
	 q7hrBweCTmSEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 15/15] gve: add link status/speed ctrl ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602235900.3050782-16-hramamurthy@google.com>
References: <20260602235900.3050782-16-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:59:31 +0000
Message-Id: <20260603235932.569201F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Data race and double-read TOCTOU on unprotected `priv->link_up` =
boolean field.

Pre-existing issues:
- [Critical] DMA memory corruption risk in AdminQ command timeout handling.
- [Critical] Use-After-Free of `priv->adminq` when an ethtool command is is=
sued after a failed device reset.
- [High] The driver fails to cancel the `service_task` workqueue during dev=
ice suspend, allowing it to run while the device is in D3hot, triggering AE=
R crashes.
--

commit ef66cc6af8d7947d84b4c6d611c745d03fb318bf
Author: Joshua Washington <joshwash@google.com>

gve: add link status/speed ctrl ops

Refactor link status check to use a control plane op. Introduce
new op for retrieving the link status in AQ mode. This op reads
the link status from the device status register and stores the
value in priv.

Also add an op for retrieving link speed in AQ mode which calls into
gve_adminq_report_link_speed.

> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 799381d24c71f..b33633555b710 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1872,3 +1872,12 @@ int gve_adminq_create_queues(struct gve_priv *priv)
> =20
>  	return err;
>  }
> +
> +int gve_adminq_report_link_status(struct gve_priv *priv)
> +{
> +	u32 status;
> +
> +	status =3D ioread32be(&priv->reg_bar0->device_status);
> +	priv->link_up =3D !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);

[Severity: Medium]
Can this cause a data race? This function directly writes to priv->link_up
without locks, while it is read concurrently in other contexts.

> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/=
ethernet/google/gve/gve_ethtool.c
> index 54b623b678ce3..aaf5b8b1671b5 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -749,12 +749,11 @@ static int gve_get_link_ksettings(struct net_device=
 *netdev,
>  	int err =3D 0;
> =20
>  	if (priv->link_speed =3D=3D 0)
> -		err =3D gve_adminq_report_link_speed(priv);
> +		err =3D priv->ctrl_ops->report_link_speed(priv);

[Severity: Critical]
This is a pre-existing issue, but I have a question about the timeout handl=
ing
inside gve_adminq_report_link_speed().=20

If gve_adminq_execute_cmd() returns a timeout error, the function drops the
error and immediately frees the DMA memory via dma_free_coherent(). However,
since a host CPU timeout does not guarantee the NIC has aborted the DMA
operation, could the hardware eventually execute a DMA write to the provided
bus address after the memory has been reallocated, causing memory corruptio=
n?

[Severity: Critical]
This is another pre-existing issue, but could this ethtool call trigger a
use-after-free if a previous device reset failed?

If a device reset fails, gve_adminq_free() destroys the adminq_pool and fre=
es
the DMA memory backing priv->adminq. If user-space subsequently issues an
ethtool command like gve_get_link_ksettings, the driver invokes
report_link_speed() and eventually gve_adminq_issue_cmd().=20

If the device's tail counter was reset to 0, and the host's head counter is
still 0, could gve_adminq_issue_cmd() write the command payload into the
now-dangling priv->adminq buffer?

> =20
>  	cmd->base.speed =3D priv->link_speed;
> =20
>  	cmd->base.duplex =3D DUPLEX_FULL;

[ ... ]

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index a103a6304b495..74778ee4d4d0e 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1475,15 +1475,15 @@ static int gve_close(struct net_device *dev)
>  	return err;
>  }
> =20
> -static void gve_handle_link_status(struct gve_priv *priv, bool link_stat=
us)
> +static void gve_handle_link_status(struct gve_priv *priv)
>  {
>  	if (!gve_get_napi_enabled(priv))
>  		return;
> =20
> -	if (link_status =3D=3D netif_carrier_ok(priv->dev))
> +	if (priv->link_up =3D=3D netif_carrier_ok(priv->dev))
>  		return;
> =20
> -	if (link_status) {
> +	if (priv->link_up) {

[Severity: Medium]
Is there a time-of-check to time-of-use race here?=20

Because priv->link_up is read twice in quick succession without protection,=
=20
and could be modified concurrently by gve_adminq_report_link_status() runni=
ng
in the lockless service_task workqueue, can the value change between the two
checks?

Would using READ_ONCE() and saving the result to a local variable prevent
unintended compiler optimizations and state changes?

>  		netdev_info(priv->dev, "Device link is up.\n");
>  		netif_carrier_on(priv->dev);
>  	} else {

[ ... ]

> @@ -2299,12 +2298,14 @@ static void gve_service_task(struct work_struct *=
work)
>  {
>  	struct gve_priv *priv =3D container_of(work, struct gve_priv,
>  					     service_task);
> +	const struct gve_ctrl_ops *ops =3D priv->ctrl_ops;
>  	u32 status =3D ioread32be(&priv->reg_bar0->device_status);
> =20
>  	gve_handle_status(priv, status);
> =20
>  	gve_handle_reset(priv);
> -	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & statu=
s);
> +	ops->report_link_status(priv);
> +	gve_handle_link_status(priv);

[Severity: High]
This is a pre-existing issue, but is the service_task safely stopped during
system suspend?

Looking at gve_suspend(), the function does not call cancel_work_sync() for
the service_task. Because the priv->gve_wq workqueue is allocated without t=
he
WQ_FREEZABLE flag, it will not be frozen by the PM core.=20

If this service_task runs while the device is in D3hot, could ioread32be()
return all Fs (0xFFFFFFFF), causing the GVE_DEVICE_STATUS_RESET_MASK check =
to
pass? If so, would this trigger gve_reset() to write to MMIO registers of a
suspended PCIe device, resulting in a PCIe Master Abort?

>  }
> =20
>  static void gve_set_netdev_xdp_features(struct gve_priv *priv)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235900.3050=
782-1-hramamurthy@google.com?part=3D15
