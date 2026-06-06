Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D436C1A262A;
	Sat,  6 Jun 2026 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707682; cv=none; b=XS9GQhqhJv2hRay5zwLXa5qtKit2/mFBAsz+qJux587XfDUNpGDfsZ3Bh/tiJhRgWB+50lkHzsK8K/TTPgG482Y+fQI6EUM7sFMqlI/MeUvKhUMKxTA3TD+hluvl3oSkIUyEaVrIqc9zdJA5fQadX+f8srqpkpVdiqZWvq12yMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707682; c=relaxed/simple;
	bh=dvDm1rbitEHVVRWuvKxq7bgXWQVbprtJLmXCP7BF4vk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r68bCJDKl171yTTrDAjXsT3elJebbmymCkc+DoT5aWMiGjdEv/hfSNkSrCDeUKXcmVEN4qBqMTVJrLm7KoX9fHmW7G5hIT4z44FLzFMrFnAIctfLfcZWpNFRPU/Fm9PWI4kT7lglgm+LqHmRtBWFt0GIMYC9eoW6FBHvxD7BIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCnDEqLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCnDEqLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580DF1F00898;
	Sat,  6 Jun 2026 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707681;
	bh=OllOCYmt/Ha9/XrVXwaHa3NQn1gIUZLBxpQxSVb87XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HCnDEqLNFd3Z2I4gPLyKTDN3hCbzkk+CzydZOjCHVW1S9kBZod5NnF1Xm7Ayp+/wq
	 00U0d88LVn0ygLlgwCJYEkHQSL5Bu57H1Bu7N9acrhQg19sWH6Cz9F0Efkp+96dlgq
	 h1pHIiGOZdDAqZFWcQzJZym/jK5qKY8FNfrRtnFlZmlp44WbV69DFsaFxDyDRoF3YE
	 1hf9pckwhZgxtyTZqTcxvCkpQG6w5sHDLndnIghhKhe8j7qCgdUJczVrwh47jEcpbK
	 1gg1Xxx7SpYNnmomsEsM2QJqu3c6hHnm9mmMUi7sD4dQ0wjOM1g71PgNfUM8nOKuxL
	 By3kUX58oYP/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 05/14] net: pcs: pcs-xpcs: select operating
 mode for 10G-baseR capable PCS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260605010022.968612-6-elder@riscstar.com>
References: <20260605010022.968612-6-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 01:01:20 +0000
Message-Id: <20260606010121.580DF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] False detection of 10Gbase-R capability on 1G-only devices lacki=
ng MMD 3 (PCS) due to unhandled `0xffff` MDIO read response.
--

commit 8962f48f9cb6674f919016e2d22817c0d0ed132d
Author: Daniel Thompson <daniel@riscstar.com>

net: pcs: pcs-xpcs: select operating mode for 10G-baseR capable PCS

This commit adds generic logic to change the operating mode on XPCS
devices that support 10Gbase-R when the default mode is inappropriate.
It sets PCS_TYPE_SEL to a reserved value to fix an issue where modal
switching is otherwise suppressed.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 76c04372b5b50..e58103ae8dadd 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -705,10 +705,49 @@ static void xpcs_get_interfaces(struct dw_xpcs *xpc=
s, unsigned long *interfaces)
>  static int xpcs_switch_interface_mode(struct dw_xpcs *xpcs,
>  				      phy_interface_t interface)
>  {
> +	int mdio_stat2, ret;
> +
>  	/* Wangxun provides a full alternative implementation to handle quirks =
*/
>  	if (xpcs->info.pma =3D=3D WX_TXGBE_XPCS_PMA_10G_ID)
>  		return txgbe_xpcs_switch_mode(xpcs, interface);
> =20
> +	mdio_stat2 =3D xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
> +	if (mdio_stat2 < 0)
> +		return mdio_stat2;
> +
> +	/*
> +	 * If this XPCS supports 10Gbase-R then that will be the default
> +	 * operating mode. There are several interface modes where this default
> +	 * is unhelpful. Change the operating mode for interfaces were we know
> +	 * the default is wrong, and restore the default otherwise.
> +	 */
> +	if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {

[Severity: Medium]
Will this falsely detect 10GBASE-R support on 1G-only devices?

If a device lacks the PCS MMD (MMD 3), the MDIO bus read in xpcs_read()
naturally returns 0xffff due to floating bus pull-ups. Because 0xffff is
greater than 0, it bypasses the mdio_stat2 < 0 error check above.

Since 0xffff & MDIO_PCS_STAT2_10GBR (0x0001) evaluates to true, the driver
will falsely identify the device as 10GBASE-R capable and perform unintended
writes to MDIO_CTRL2 in the unpopulated MMD 3. Does this check need to
account for 0xffff responses?

> +		switch (interface) {
> +		case PHY_INTERFACE_MODE_SGMII:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605010022.9686=
12-1-elder@riscstar.com?part=3D5
