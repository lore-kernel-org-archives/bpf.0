Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC137FF60
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737374; cv=none; b=O5G6vqmjcsm0pbZVyotqA76tIWDo+VqBPVjq6rSoCd3dit0PVZaFrwqBR/r5eY8W7kM5tlJqSmjc+pqm/ewn+naU4OGQU0QbeIzbkxa1e2FXs5ESsAXycTD5ORHu5apzZ7YMAoGk9V8yF9r92+eHrdgpYH8V+fwIhJxofw+w9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737374; c=relaxed/simple;
	bh=I9jFfMLWKngFq1b6Qll1MtWGcjryNAmJJA69FqOt4xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g3Uyd0hz4AD7wC2AYyHYoCtzHQjJ8et7deQtuXkxYf6htW/jvh/rWFBIsLfhhLTz93lQb4HEF3nQm/rgPlAKQFpxnPkMwbIfv6dP+xma9ZROkaNakqGLFi3QKFSAuM5vLc6f6B73b95cmBNZUDYxiOC5hJr95QKFxk8szDsqeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOttX3yJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOttX3yJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCCCC19425;
	Sat,  2 May 2026 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737374;
	bh=I9jFfMLWKngFq1b6Qll1MtWGcjryNAmJJA69FqOt4xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=vOttX3yJds5q/lNR61VCfLtjTI2DyCdM82zqxne8p/yAk1XP/ppG0MFPI5ry/cLkf
	 0WqA9TA/FYNrsLC3se93wGXdse0x4BIfnJleT5XrKtqwJ/xtfJsacO2deWE0WxM2A0
	 o8QfyQR+6yeaj4C4Bu22+nlVa6ucK/kvxWxiZmzr4tRrBhoZ1tONAUWRv6qAfi/vl4
	 omoz2+sUQFOlcNm9Y0MtmjUtDs7VqI9N/UF4U+KZYm6WyVmH/D+aGdirVLmub6FtIg
	 c0thMa8DnStPgbRgQ30WOiCbbgrZkCKtnzRPOOKSe220fSw+cfMguJA3J7c3pdJEVF
	 jGtYXS9UK+RNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 02/12] net: pcs: pcs-xpcs: select operating
 mode for 10G-baseR capable PCS
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-3-elder@riscstar.com>
References: <20260501155421.3329862-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:13 +0000
Message-Id: <20260502155614.2CCCCC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The generic workaround unconditionally overwrites `MDIO_CTRL2`, br=
eaking Wangxun hardware.
- [High] Transitioning from SGMII/1000BASEX to 10GBASE-R leaves MDIO_CTRL2 =
in a broken state, preventing 10G modes from functioning.
- [Medium] Synthesizing a hardware value by adding 1 to a UAPI bitmask macr=
o is brittle and semantically incorrect.
--

commit 797f904fd928c0648fed4442dd4dbb70a939a7f7
Author: Daniel Thompson <daniel@riscstar.com>

net: pcs: pcs-xpcs: select operating mode for 10G-baseR capable PCS

The patch attempts to solve an issue where 10Gbase-R support suppresses mod=
al
switching for 1000base-X and slower speeds on XPCS. It sets the PCS_TYPE_SEL
in MDIO_CTRL2 to a reserved value when detecting the relevant PHY interface
and XPCS feature support.

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index e69fa2f0a0e8..b2c84b7e1e11 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -747,6 +747,40 @@ static void xpcs_pre_config(struct phylink_pcs *pcs,=
 phy_interface_t interface)
>  	xpcs->need_reset =3D false;
>  }
> =20
> +static int xpcs_config_operating_mode(struct dw_xpcs *xpcs, int an_mode)
> +{
> +	int mdio_stat2, ret;
> +
> +	switch (an_mode) {
> +	case DW_AN_C37_SGMII:
> +	case DW_AN_C37_1000BASEX:
> +	case DW_2500BASEX:
> +		mdio_stat2 =3D xpcs_read(xpcs, MDIO_MMD_PCS, MDIO_STAT2);
> +		if (mdio_stat2 < 0)
> +			return mdio_stat2;
> +
> +		/*
> +		 * If this XPCS supports 10Gbase-R then it will be the default
> +		 * which prevents 1000base-X and slower from working correctly.
> +		 *
> +		 * Why are we writing MDIO_PCS_CTRL2_TYPE + 1? We want the modal
> +		 * behaviour that comes when we pick a reserved value. XPCS
> +		 * allocates extra bits to this field and allocates values from
> +		 * 15 down so MDIO_PCS_CTRL2_TYPE + 1 is the value likely to
> +		 * be allocated last (and hopefully never).
> +		 */
> +		if (mdio_stat2 & MDIO_PCS_STAT2_10GBR) {
> +			ret =3D xpcs_write(xpcs, MDIO_MMD_PCS, MDIO_CTRL2,
> +					 MDIO_PCS_CTRL2_TYPE + 1);

Is it safe to calculate the reserved value by adding 1 to the bitmask macro
MDIO_PCS_CTRL2_TYPE?

MDIO_PCS_CTRL2_TYPE is defined in <uapi/linux/mdio.h> as a bitmask (0x0003),
not a maximum integer value. While this evaluates to 4 today, if the IEEE
standard expands the PCS type selection field (e.g. to a 4-bit mask 0x000F),
this expression will evaluate to 16, overflowing the field. Could this use =
an
explicit local constant for the targeted proprietary reserved value instead?

Also, could this cause issues if the interface is dynamically switched back
to a 10G mode (e.g., DW_10GBASER)?

If the interface switches from SGMII to DW_10GBASER,
xpcs_config_operating_mode() hits an empty switch case and does not update
the register. Because xpcs_switch_interface_mode() only sets
xpcs->need_reset =3D true when switching to SGMII, no soft reset is trigger=
ed,
leaving MDIO_CTRL2 stuck at the reserved value 4 and breaking 10GBASE-R
modal behavior.

> +			if (ret < 0)
> +				return ret;
> +		}
> +		break;
> +	}
> +
> +	return 0;
> +}
> +

[ ... ]

> @@ -919,6 +953,10 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_=
interface_t interface,
>  	if (!compat)
>  		return -ENODEV;
> =20
> +	ret =3D xpcs_config_operating_mode(xpcs, compat->an_mode);

Does this unconditionally overwrite MDIO_CTRL2 and break Wangxun hardware?

For Wangxun devices, xpcs_pre_config() calls xpcs_switch_interface_mode(),
which delegates to txgbe_xpcs_switch_mode(). This explicitly configures
MDIO_CTRL2 to MDIO_PCS_CTRL2_10GBX (1) for SGMII and 1000BASE-X.

Later, xpcs_do_config() calls xpcs_config_operating_mode() here. Because
Wangxun devices support 10GBASE-R, it writes the reserved value 4 to
MDIO_CTRL2. This clobbers the required Wangxun-specific 10GBX state,
forcing the hardware into a reserved state and breaking the link.

> +	if (ret < 0)
> +		return ret;
> +
>  	if (xpcs->info.pma =3D=3D WX_TXGBE_XPCS_PMA_10G_ID) {
>  		/* Wangxun devices need backplane CL37 AN enabled for
>  		 * SGMII and 1000base-X

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D2
