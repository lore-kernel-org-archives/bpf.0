Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D74DC54F
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531170; cv=none; b=jIGb+akEpOwo79sD7X7g54C34vp42aEM7YuBgnLHRteUgbmHBhCLANtTlu061/OsPN+Qd2TRFBQM/cRX0t9Tn44EH7XNuRzJJGHr3iCbjnrK6OxbwmyZuj66qJTE8yV2Nv9WOTKg5L5Pcde/1UhVfusfHhUweOa9188kPBtQdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531170; c=relaxed/simple;
	bh=P8smfUdLuWPaab+Wg546sg8RdGiY3+4QYI0+YKyZqFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qw1/53Uj/A++76xA8G4gSWrqOkB+WyQRDg6WRruFFTRF5vxaBiOl5FoltLA2LlaZm94uJBQXQG9N4Ii1cPa7yg1xkhq5sOs8OKJNrM4bOMoRggWnBs8ISC9po5Fo4Qwba25VYJSjOZUtcjHbafZ6aau3ir4xqMgSyzd898vI0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/V6YW0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/V6YW0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBE11F00899;
	Wed,  3 Jun 2026 23:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531169;
	bh=ow/+ckgtArYLvSTkeGJlQiFU0NaP1pyuLVybFmCh9i4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k/V6YW0GF5JjhOaEzbMwMYlUP247zXw2q2jypQtEdK63P6oq5qgONx95OVfOtUnWK
	 YFlaNu5izIhnM7eBnFgafRVZm6YB81aocJk2VussH2bXJDBGH2PKIKUWHm+ujHHkpo
	 +eqyh+szCeHlsgQ8Hx1mKUxMeT2UAQzxtmoo9SBPsCvudabv/mhK7y9p0Vc7z7oQlH
	 HZk4Fu/mzgHZscflWGPR3dEVt2oqcNoPD3/4/TM3uzZVKPr4BLcy4ZjQFmCJZBKPss
	 5HaCU1yR6V58sByBogPI7g/ToLLEZJ5i1SyQhC5WPQq0Zsf8iIsfB0LRJ98EaQt9sg
	 mchxFe2kXu/Ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 02/15] gve: refactor initialization with
 helper functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harshitha Ramamurthy" <hramamurthy@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602235900.3050782-3-hramamurthy@google.com>
References: <20260602235900.3050782-3-hramamurthy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 23:59:28 +0000
Message-Id: <20260603235929.3BBE11F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] gve_verify_driver_compatibility() is incorrectly skipped during de=
vice reset recovery, causing the device to lose driver capability context.
--

commit 8cee6a7e999b446ef0c02854dce95bbc44f444e8
Author: Harshitha Ramamurthy <hramamurthy@google.com>
gve: refactor initialization with helper functions

This commit refactors gve_probe() and gve_init_priv() to commonize code
using helper functions gve_set_num_ntfy_blks() and gve_set_num_queues().
It also reorders code to combine lines that accomplish similar objectives
and moves setting HW-GRO and UDP GSO support into gve_init_priv().

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 30bf6df4ebc58..b9542ef36b297 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c

[ ... ]

> @@ -2470,18 +2437,73 @@ static int gve_init_priv(struct gve_priv *priv, b=
ool skip_describe_device)

[ ... ]

> +static int gve_init_priv(struct gve_priv *priv, bool skip_describe_devic=
e)
> +{
> +	int err;
> +
> +	/* Set up the adminq */
> +	err =3D gve_adminq_alloc(&priv->pdev->dev, priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev,
> +			"Failed to alloc admin queue: err=3D%d\n", err);
> +		return err;
> +	}
> +
> +	priv->num_registered_pages =3D 0;
> +
> +	if (skip_describe_device)
> +		goto setup_device;
> +
> +	err =3D gve_verify_driver_compatibility(priv);

[Severity: High]
Does moving this driver compatibility check below the early-exit bypass the
critical capability handshake during reset recovery?

When a device reset occurs, the hardware clears its internal state. In the
baseline code, gve_verify_driver_compatibility() was called unconditionally
at the beginning of gve_init_priv(), ensuring the device was repopulated
with the driver's capabilities.

By placing it after the skip_describe_device check, the driver capability
handshake appears to be skipped during reset recovery. This leaves the
hardware unaware of the driver's features, which can cause it to reject
subsequent configuration commands or misinterpret descriptors, potentially
resulting in a denial of service until the module is reloaded.

Is it intentional to omit this handshake during recovery?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602235900.3050=
782-1-hramamurthy@google.com?part=3D2
