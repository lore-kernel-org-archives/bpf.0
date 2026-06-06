Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AA218AB9;
	Sat,  6 Jun 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707689; cv=none; b=Jgbq9rfbWb8Vv/kCzzUdqGlCmO2Vi46JEj/t3qSc4/woNFX19JFWnLMdUoPIb4/t4h7WhTZsdqIgl4cpWzDMAA5Be7vRggs5Hz2t4h1lqtUWqmjSnqpPwPNr8R6oFAnMYMC6Iba0VAmdj11xV1joou4Nal+r6FWPPnlAthzTkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707689; c=relaxed/simple;
	bh=CoBTjRwSS3DCR4zTmkcN6YriuS921oauM7vRPN+Gbps=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=leI2KLe9MJjr5KyByvojD2bohox6kSrat3BPdIuoqW863+kn9TyY/nZ+BYJ0R62+zz9WR1XlCwMZlRTJIajbt39fImVs8A3sfMNKHTmLKDq9OIRd/amqRtxoy/yBeXhdlFCYutNB2q5wDnrA1zqBQn5DeKr5vsAWaG+Hn7xmPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA2qnVg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA2qnVg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C551F00893;
	Sat,  6 Jun 2026 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707688;
	bh=fwgYf2uxhVbOYeMLvkXAX1Sf2no3xFwX6jmF9BaBVcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hA2qnVg94psbpUYgMDsa6x/4XkQ3YP0LYh+AY0fVnY8+uGFYrDUImepPwYQ9xvaKZ
	 VKbXEY+vsiXVxO6/1ACHY5K9E95xqp1YqiMFjtL3OTx9bJdj8g0v6GmBaDEXqg9yI/
	 Yygl1Kaf7UN2xq1q2avIZ8xk0ZszRMa5hjxyQ4scXdCOeEVJU0SFdt9z4cJxgxpLZf
	 +1g39rOSancwKaSo6KIWIJEze9IsUMtXEOr3p8H3ctFlVyQx70s77nUJKemDv7JI67
	 t1+ltlB81wmBtgCrSsI2B6V4RRTKPWYAFy99y8R5OM1yh5npU38EP5Gy7hYC2j4Lcq
	 7S+hSWTnhEv9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 14/14] arm64: dts: qcom: qcs6490-rb3gen2:
 enable TC9564 with a single QCA8081 phy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260605010022.968612-15-elder@riscstar.com>
References: <20260605010022.968612-15-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 01:01:27 +0000
Message-Id: <20260606010127.C4C551F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The Ethernet PHY reset GPIO is incorrectly specified as 'snps,rese=
t' within the PHY node, meaning it will never be acquired or toggled.
- [Low] The PCI endpoint nodes (`pci@0,0` and `pci@0,1`) incorrectly includ=
e bridge-exclusive properties.

Pre-existing issues:
- [High] The newly added `tc9564_gpio0` devicetree node will be rejected by=
 its backing PCI driver due to a typo in the driver codebase.
--

commit 68b46926b348f5281d4dc4e8d117989c980cbff5
Author: Daniel Thompson <daniel@riscstar.com>

arm64: dts: qcom: qcs6490-rb3gen2: enable TC9564 with a single QCA8081 phy

This commit adds device tree properties to support the TC9564 Ethernet brid=
ge
and QCA8081 PHY on the QCS6490 RB3Gen2 platform. It describes how the
embedded PCIe endpoints, GPIO controller, and Ethernet PHYs are connected.

> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/bo=
ot/dts/qcom/qcs6490-rb3gen2.dts
> index e393ccf1884af..1d83b07360a33 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
[ ... ]
> @@ -938,19 +947,51 @@ pcie@3,0 {
>  			bus-range =3D <0x5 0xff>;
> =20
>  			pci@0,0 {
> +				compatible =3D "pci1179,0220";
>  				reg =3D <0x50000 0x0 0x0 0x0 0x0>;
>  				#address-cells =3D <3>;
>  				#size-cells =3D <2>;
>  				device_type =3D "pci";
>  				ranges;

[Severity: Low]
Does this endpoint node incorrectly include bridge-exclusive properties?

Properties like device_type =3D "pci", ranges, #address-cells, and #size-ce=
lls
are typically reserved for PCI bridges that enumerate child buses, not for
leaf endpoints.

> +
> +				tc9564_gpio0: gpio {
> +					gpio-controller;
> +					#gpio-cells =3D <2>;
> +				};

[Severity: High]
This is a pre-existing issue, but the existing PCI MFD driver for this
endpoint has a typo that will cause it to reject this node.

Looking at dev_node_child_gpio() in drivers/misc/tc956x_pci.c, the driver
explicitly checks for "gpio-controllerX":

if (!of_property_present(np, "gpio-controllerX"))
    dev_err(dev, "gpio node contains no gpio-contrller property\n");

Because this patch correctly uses "gpio-controller", will the driver fail
to instantiate the controller and prevent the PHY reset line from being
driven?

>  			};
> =20
>  			pci@0,1 {
> +				compatible =3D "pci1179,0220";
>  				reg =3D <0x50100 0x0 0x0 0x0 0x0>;
>  				#address-cells =3D <3>;
>  				#size-cells =3D <2>;
>  				device_type =3D "pci";
>  				ranges;

[Severity: Low]
Are the bridge-exclusive properties (device_type, ranges, #address-cells)
also incorrectly applied to this leaf endpoint node?

> +
> +				ethernet {
> +					phy-mode =3D "sgmii";
> +					phy-handle =3D <&tc9564_emac1_phy>;
> +
> +					mdio {
> +						compatible =3D "snps,dwmac-mdio";
> +						#address-cells =3D <1>;
> +						#size-cells =3D <0>;
> +
> +						tc9564_emac1_phy: ethernet-phy@1c {
> +							compatible =3D "ethernet-phy-id004d.d101";
> +							reg =3D <0x1c>;
> +							snps,reset =3D <&tc9564_gpio0 1 GPIO_ACTIVE_LOW>;

[Severity: High]
Will this reset GPIO ever be acquired or toggled during initialization?

The stmmac_mdio_reset() function looks for the "snps,reset" GPIO on the
MAC's device node (ethernet), but it is placed here in the PHY subnode.
Meanwhile, the standard mdio_device_register_reset() function looks for
"reset-gpios" in the PHY node, not "snps,reset".

Since neither subsystem will find this property, it seems the PHY reset
will not be performed. Should this either be renamed to "reset-gpios" or
moved to the MAC node?

> +							reset-assert-us =3D <11000>;
> +							reset-deassert-us =3D <70000>;
> +
> +							vdd18-supply =3D <&qep_1p8>;
> +
> +							pinctrl-names =3D "default";
> +							pinctrl-0 =3D <&qep_irq_pin>;
> +							interrupts-extended =3D <&tlmm 101 IRQ_TYPE_LEVEL_LOW>;
> +						};
> +					};
> +				};
>  			};
>  		};
>  	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605010022.9686=
12-1-elder@riscstar.com?part=3D14
