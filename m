Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2A382394
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737376; cv=none; b=Cdlu2fQ3PEiBaViPPQgXQTxYYO3u655xp3YM4hUgjxu7S6L01RLxb9ReIK5QQOVKSMS4sZ3d14yhb/tuLMl5IkLIIU3fTYHTix0hbsEkE5jb92LW/+UvRqfCns2tCcb4pqd+xJt3ezNyWOoulDbQ4eyN83gARaumZ+UNd0inLIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737376; c=relaxed/simple;
	bh=1j/knQLl8Yb+i/UX/D0utQ++b+nVkqi8BqL+7dSSaFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f9qnW17KkiLpWbtEBbRZ61Ay5qVf1XDqO9vgWk/OnmBKRmP/D75enkv2JVRkMoZS3AI1L+ZWcDW7tlxtcHqqSf/yWefu9Q+2F9tySZdWtmNCDlG4nQyB4YFKwMREGv7OgeSWX0QpUJAZM1uP+Jl56m2mW3WFi5wXSeFhnEUy+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGa8H3JA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGa8H3JA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF378C19425;
	Sat,  2 May 2026 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737375;
	bh=1j/knQLl8Yb+i/UX/D0utQ++b+nVkqi8BqL+7dSSaFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AGa8H3JA8QeNRuVCu+v+5E+Ycnus6YIBup5XXqhq4/c4xGUdzbNYOBpypHcyJzcHK
	 1luSuinY5eVxE8iSol2AzmLooCnfLk8PIzgbzm4rMDtteGqmTjvwiQ2DSIG8bNOhbJ
	 mI9F8Dg6f/0o4B1sGAxv1D32cr0A1pGi9L0OO8Ba3+R5302h34ndUvFfrXg07M0/4a
	 XBXs5zrEobSGuaNk5tbaXqoPgYJTh6nYT7GrcnLz2uiGdIkqZuI0TCrLhlBsH9NY+V
	 1ecHwQ7lbF1hH067u7OWscIzXFW83J53YpYVRnZR3a9HadSxpBthOYA23y9GsZNvB+
	 UO7+qOILOu/jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-9-elder@riscstar.com>
References: <20260501155421.3329862-9-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:15 +0000
Message-Id: <20260502155615.AF378C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The binding adds GPIO provider capabilities but omits `gpio-cont=
roller` and `#gpio-cells` from the `required` list.
- [Medium] The Ethernet endpoint is incorrectly modeled as a PCI bridge, ap=
plying bus properties to an endpoint.
--

commit c5a5d0d7a89f5ad66c878c805902efc5e0bd117a
Author: Daniel Thompson <daniel@riscstar.com>

dt-bindings: net: toshiba,tc965x-dwmac: add TC956x Ethernet bridge

This commit adds devicetree bindings for the Toshiba TC956x family of
Ethernet-AVB/TSN bridges.

> diff --git a/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.y=
aml b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> new file mode 100644
> index 000000000000..d95d22a3761d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> @@ -0,0 +1,111 @@

[ ... ]

> +allOf:
> +  - $ref: /schemas/pci/pci-bus-common.yaml#

Is it correct to reference pci-bus-common.yaml# here? Since the tc956x_emac0
node is a PCI endpoint (an Ethernet controller attached to an internal PCIe
switch) rather than a PCI bus or bridge, applying bridge-specific properties
could be semantically invalid.

> +  - $ref: /schemas/pci/pci-device.yaml#
> +
> +unevaluatedProperties: false
> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci1179,0220 # Toshiba TC9564 (a.k.a. Qualcomm QPS615)
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-controller: true

[ ... ]

> +required:
> +  - compatible
> +  - reg

Should gpio-controller and #gpio-cells be explicitly included in this
required list?

The binding defines gpio-controller and #gpio-cells above, indicating the
hardware acts as a GPIO provider. Omitting them from the required list could
allow incomplete device tree nodes to silently pass schema validation.

> +examples:
> +  - |
> +    pcie {
> +      #address-cells =3D <3>;
> +      #size-cells =3D <2>;
> +
> +      tc956x_emac0: pci@0,0 {
> +        compatible =3D "pci1179,0220";
> +        reg =3D <0x50000 0x0 0x0 0x0 0x0>;
> +        #address-cells =3D <3>;
> +        #size-cells =3D <2>;
> +        device_type =3D "pci";
> +        ranges;

Does this endpoint node need bridge properties like device_type =3D "pci",
#address-cells =3D <3>, #size-cells =3D <2>, and ranges?

The child of this node is an mdio bus, which does not use PCI addresses and
does not require PCI bridge translation. Using device_type =3D "pci" on an
endpoint might confuse OS PCI enumeration logic, which expects nodes with
this device_type to be actual PCI-to-PCI bridges.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D8
