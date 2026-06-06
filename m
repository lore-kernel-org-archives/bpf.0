Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3223233950;
	Sat,  6 Jun 2026 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780707686; cv=none; b=BTONjuUQNAiUVNj6GuBdmbMbMAHyTPT+HbJAzdJvs1jMM2woUR/oYikRPAxUOAJ9ytARDMVJgp151ayhrwnaVI1dyzhwySDB8CY2n2uLyHSyQ/fzpD5TWKyT3jpccZ+PbuUEZWkInVDKrbBypgUYoeugUBAYhW9cN4yyTPVfrY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780707686; c=relaxed/simple;
	bh=sCgGa3h6oJQbzDMULG5il6M4SxyEBIKz1L22Yc7YIhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M5pGerMP41eiSfzIGTV4P6htUqtVfSlbuOQuYPvIUC3dA3OypcEjR+uSgLT7d03Cs6Pzu/ocEVNEW5FOKWw1gdEs3TCgLvQHAto5L2OmWxdyUKNzS3lYf9vF6282J6sbdcoi2cvdnjU+/BWRKcfRfjtZyC/wmIHH+2MBmthh0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laP29AlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laP29AlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7878F1F00899;
	Sat,  6 Jun 2026 01:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780707684;
	bh=2hJLK06CussSPw+chVf931RMNhxIWQ61cw6PGJRHYPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=laP29AlNeuOcsYG2KwWgRbBGU4vcRZhR6IcAKOYcTih79Z/bigw9V3YZPjfKHnfXm
	 CokkVv62FC5hF600oXoopkvoWm023aKVXG9Oa6dgH0HYth+aneFGp3ieVV7PlQm9UR
	 hIY0j38wkZ5HIdgw8GnQLrAyOARPtsdi2W+j5HQQ7CgND1V3NeMv+eGpsOC6wFwMLy
	 7sGdPqbjnYvCLvlXjNYltBbODs9c+TIBuhniXnogM3RnPSU31fspI5uDZCdAZk7+4r
	 XJ7/5XDhPLHSVxYhEAxq/DSMbmDuZx1INblO5wZg9fMrpg0+bRnBECgUTr6lWqwV0J
	 Z1M26/7f58epg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 10/14] dt-bindings: net:
 toshiba,tc9654-dwmac: add TC9564 Ethernet bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260605010022.968612-11-elder@riscstar.com>
References: <20260605010022.968612-11-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 01:01:24 +0000
Message-Id: <20260606010124.7878F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The DT binding schema for the embedded GPIO controller lacks req=
uired provider properties and constraints.
- [Medium] The schema incorrectly includes PCI bus properties (`device_type=
 =3D "pci"`, `ranges`, `#address-cells`) on a PCIe endpoint node.
- [Low] The file pattern listed in the new MAINTAINERS entry does not match=
 the actual file added by the commit.
--

commit b83533ab8022940a0adcc430e19c789576b6a45b
Author: Daniel Thompson <daniel@riscstar.com>

dt-bindings: net: toshiba,tc9654-dwmac: add TC9564 Ethernet bridge

Add devicetree bindings for the Toshiba TC956x family of Ethernet-AVB/TSN
bridges. The TC9564 contains a PCIe switch with an attached embedded PCIe
endpoint implementing two PCIe functions, each with an Ethernet interface
and an embedded GPIO controller.

> diff --git a/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.y=
aml b/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
> new file mode 100644
> index 0000000000000..6e7a63dfcf86a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/toshiba,tc9564-dwmac.yaml
> @@ -0,0 +1,120 @@

[ ... ]

> +properties:
> +  compatible:
> +    enum:
> +      - pci1179,0220 # Toshiba TC9564 (a.k.a. Qualcomm QPS615)
> +
> +  gpio:
> +    type: object
> +    description: Embedded GPIO controller
> +    $ref: /schemas/gpio/gpio.yaml#

[Severity: Medium]
When adding a hardware capability like a GPIO controller, should the schema
explicitly list standard properties like gpio-controller and #gpio-cells
in the required list?

Also, would it make sense to enforce a const constraint for #gpio-cells?
Without these requirements, device tree nodes missing the provider properti=
es
might silently pass validation.

[ ... ]

> +allOf:
> +  - $ref: /schemas/pci/pci-device.yaml#
> +  - $ref: /schemas/pci/pci-bus-common.yaml#

[Severity: Medium]
Is it intentional to reference pci-bus-common.yaml# for a PCIe endpoint?

This reference applies bus-specific properties to an endpoint node.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    pcie {
> +        #address-cells =3D <3>;
> +        #size-cells =3D <2>;
> +
> +        pci@0,0 {
> +            compatible =3D "pci1179,0220";
> +            reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            device_type =3D "pci";
> +            ranges;

[Severity: Medium]
Are device_type =3D "pci", ranges, and the address translation cell propert=
ies
valid on this endpoint node?

The Devicetree specification dictates that device_type =3D "pci" should str=
ictly
be used on PCI bus nodes like host bridges or PCI-to-PCI bridges.

Additionally, since the gpio and ethernet child nodes do not use reg
properties, the address and size cell sizing here seems unnecessary.

> +
> +            gpio {
> +                  gpio-controller;
> +                  #gpio-cells =3D <2>;
> +            };

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2aa6ea012c848..f976c9fa9d9c0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27052,6 +27052,12 @@ F:	Documentation/devicetree/bindings/media/i2c/t=
oshiba,tc358743.txt
>  F:	drivers/media/i2c/tc358743*
>  F:	include/media/i2c/tc358743.h
> =20
> +TOSHIBA TC956X/QUALCOMM QPS615 DWMAC ETHERNET DRIVER
> +M:	Alex Elder <elder@kernel.org>
> +M:	Daniel Thompson <danielt@kernel.org>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml

[Severity: Low]
Is there a typo in the filename here?

The commit introduces the file toshiba,tc9564-dwmac.yaml, but the MAINTAINE=
RS
entry lists toshiba,tc956x-dwmac.yaml. This might prevent get_maintainer.pl
from properly matching the new binding file.

> +
>  TOSHIBA WMI HOTKEYS DRIVER
>  M:	Azael Avalos <coproscefalo@gmail.com>
>  L:	platform-driver-x86@vger.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605010022.9686=
12-1-elder@riscstar.com?part=3D10
