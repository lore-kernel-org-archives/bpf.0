Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1D1A262A;
	Sat,  6 Jun 2026 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707684; cv=none; b=acnDjHv3e5lgPMKyNUrv46L9z456SiXr2qNve2YV7z6vdCHZkwuTdNW1IVocI+1VOpXPpY74r50VZSmD+WxTrmV6N3fCd9CIKT/Kb+eTchK9xzlvCzzkMS0mSz0+Ag5Mj9Yvv81nUfkjNX+5EVHdxsB1ZTwderKPA7ml30j8DqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707684; c=relaxed/simple;
	bh=qtgcWbKmA+ZbXl7F5EN4IQgcvAcmbZNrPKlFia+6LmE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e+nHvAsGhMsLldQrYZgd+xDTe+/ZnG8JOIkL/2L20tIzJ1mzDmdXAb9e5m2MxRK0yGJsOYB6NTaRUdEwxvHl/4lsjqjVLmR0NDmIQqh/gBUWoQ3Dn8dwon0b26fxE2hASekjj2Q9boCx/TatIxpYypVh/SM27DfACkXGiiat4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLBKaJF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLBKaJF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14BE1F00898;
	Sat,  6 Jun 2026 01:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707683;
	bh=epgtBp/go1eGuNCkOElvvGX8UP8sN2zZlWubldPDyQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLBKaJF1ip3rTKd2R64D23dyJcR79UpOtamOj8v+Nvi0TmOL3RbHcHBfpDtQU+EoZ
	 8rW7kLlxFd8Zw52fGPLP2U3q0Zw6WSaTfoPD/cQmkMCcF18Jo/yDTwiawqcBjPUCD1
	 GTCLn6MO9ErzUjPLjpSp2wC5Q5M+v3ZTZwLLgb9Lpk5wA7YN+v/IJO0/q0KmYAi7Bf
	 tVpSjMgyq4oDxj2oQRV5iAebIlEO1BTZBWnb6pKv2sna1WhWM0gOaPjB0+h4ZOScpp
	 7J5BN/IPJmI9CkLm5thI8+lkHx9bOEKh8pWfroUZCRbR1PsBvfADGFcW9vg6ecmHIC
	 FwNJj7cKUkJ7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 02/14] net: phy: qcom: qca808x: Add
 regulator management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260605010022.968612-3-elder@riscstar.com>
References: <20260605010022.968612-3-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 01:01:22 +0000
Message-Id: <20260606010122.E14BE1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The PHY regulators are enabled during `probe()` without re-trigger=
ing a hardware reset, violating power-on sequencing, and the code incorrect=
ly repurposes the MDIO `reset_assert_delay` as a post-power-on stabilizatio=
n delay.
--

commit 7b9b83105850db948e3794f9c1593ea2fbeac999
Author: Daniel Thompson <daniel@riscstar.com>

    net: phy: qcom: qca808x: Add regulator management

This commit adds optional regulator management to the QCA8081 PHY driver.
It attempts to enable the regulators during the probe sequence.

> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808=
x.c
> index 8eb51b1a006c4..fc3f2cf2e55d0 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c

[ ... ]

> @@ -178,15 +179,44 @@ static void qca808x_fill_possible_interfaces(struct=
 phy_device *phydev)
>  		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
>  }
> =20
> +static int qca808x_power_on(struct phy_device *phydev)
> +{
> +#ifdef CONFIG_OF
> +	static const char * const regulator_names[] =3D {
> +		"avdd18", "vdd", "vdd18", "vdd125"
> +	};
> +	struct device *dev =3D &phydev->mdio.dev;
> +	u32 count =3D 0;
> +	int i, ret;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(regulator_names); i++) {
> +		ret =3D devm_regulator_get_enable_optional(dev, regulator_names[i]);
> +		if (!ret)
> +			count++;
> +		else if (ret !=3D -ENODEV)
> +			return ret;
> +	}
> +
> +	if (count)
> +		fsleep(phydev->mdio.reset_assert_delay);

[Severity: High]
Does this apply power to the PHY without re-asserting the hardware reset
line?

The Linux PHY framework pulses the hardware reset line (asserting and then
deasserting via phy_device_reset()) during device registration, which happe=
ns
before the driver's probe callback is invoked. By enabling the regulators
here inside probe(), power is applied while the reset line is already
deasserted, which violates standard hardware power-on sequencing and can
leave the PHY in an undefined or unstable state.

Additionally, is it safe to repurpose the MDIO reset_assert_delay for this
settling time?

This uses the reset-assert-us device tree property (meant to dictate the
minimum active pulse width of the reset signal) as a post-power-on settling
delay. If a board's device tree lacks a reset-assert-us property,
reset_assert_delay will be 0, causing fsleep(0) to return immediately. The
lack of a proper stabilization delay could cause subsequent MDIO accesses to
fail.

> +#endif
> +	return 0;
> +}
> +
>  static int qca808x_probe(struct phy_device *phydev)
>  {
>  	struct device *dev =3D &phydev->mdio.dev;
>  	struct qca808x_priv *priv;
> +	int ret;
> =20
>  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> =20
> +	ret =3D qca808x_power_on(phydev);
> +	if (ret)
> +		return ret;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605010022.9686=
12-1-elder@riscstar.com?part=3D2
