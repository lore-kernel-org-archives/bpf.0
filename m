Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960930F924;
	Thu,  7 May 2026 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180537; cv=none; b=Sw2UyknX+q+xKxNQucbcE0M5Xjh2z0PW+BcxHFYdRUOjgi0dds5+xStNovlmAj3K7/B8JQ2Bjj2TEbqdROWwmFV2Wz9LDaqrt3LKaFd66YTmXBQMb8cTJ/atiZycUve+RKJSHb4tfCwwj8EUYNH48udiqOdyNVM0WrnsBbjd+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180537; c=relaxed/simple;
	bh=Fl7PR/0nciK8XX3tbGEReMooqoWzFb0UE4AdnoP3JwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDvBnIyyel5X7sm1mSP+PY6PEbJomPSdIJy6txh5odjMC8IBbY89qtHmgVt7ZgC4YyT4+EKIMbpd1h/nkvaYMaWNMa2KxRUGCpTJ/LSV4vsrx32tPfGxuBeLY+M4SFyQTfxHdept4bozqawPYGBnV3QTK6T4E+7did0na+C9wQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy6Aa8qS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy6Aa8qS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE457C2BCB2;
	Thu,  7 May 2026 19:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778180537;
	bh=Fl7PR/0nciK8XX3tbGEReMooqoWzFb0UE4AdnoP3JwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gy6Aa8qS/nTKK3iyecWi7KQJjL7Z5aDPhweQ2v0x8FZIB+ZQPxgZY7C0SFZisENdw
	 pLmOOu3aVRdTzGEDx0P5eWv1PwE60vQOXGvDH4Evkz3/7iACZwZWCvFetIy8wsMi/i
	 xq7kL/7slcqTA6nUXLEQjdfAOryr9QswdDp21/Zirxsfq/0nRA/TH3KrL4x3/T19OY
	 gOEUomHZiU3BM0DHamMMe4PD5m/ytnIZ0OuwvES5IfOdPkQmkl4XTtZ5+Mwms2rCjr
	 V2l0fqmHQebvO60BRp+Wlqzne6/2rastpdZ+LJfGyuAO58dWjYRA6PB25xarVH/S8b
	 LUFnXnp5F2SAQ==
Date: Thu, 7 May 2026 14:02:15 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko@lists.linux.dev
Cc: Alex Elder <elder@riscstar.com>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] dt-bindings: net: toshiba,tc965x-dwmac:
 add TC956x Ethernet bridge
Message-ID: <20260507190215.GA2243588-robh@kernel.org>
References: <20260501155421.3329862-9-elder@riscstar.com>
 <20260502155615.AF378C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502155615.AF378C19425@smtp.kernel.org>

On Sat, May 02, 2026 at 03:56:15PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The binding adds GPIO provider capabilities but omits `gpio-controller` and `#gpio-cells` from the `required` list.
> - [Medium] The Ethernet endpoint is incorrectly modeled as a PCI bridge, applying bus properties to an endpoint.
> --

Please answer sashiko reports because if maintainers are, it's just more 
work for us. While agreeing with maintainer comments don't need a reply, 
I think we're still at the point any AI review does. Though sashiko is 
2/2 here.

> 
> commit c5a5d0d7a89f5ad66c878c805902efc5e0bd117a
> Author: Daniel Thompson <daniel@riscstar.com>
> 
> dt-bindings: net: toshiba,tc965x-dwmac: add TC956x Ethernet bridge
> 
> This commit adds devicetree bindings for the Toshiba TC956x family of
> Ethernet-AVB/TSN bridges.
> 
> > diff --git a/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> > new file mode 100644
> > index 000000000000..d95d22a3761d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/toshiba,tc956x-dwmac.yaml
> > @@ -0,0 +1,111 @@
> 
> [ ... ]
> 
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus-common.yaml#
> 
> Is it correct to reference pci-bus-common.yaml# here? Since the tc956x_emac0
> node is a PCI endpoint (an Ethernet controller attached to an internal PCIe
> switch) rather than a PCI bus or bridge, applying bridge-specific properties
> could be semantically invalid.

Correct, should be dropped.

> 
> > +  - $ref: /schemas/pci/pci-device.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci1179,0220 # Toshiba TC9564 (a.k.a. Qualcomm QPS615)
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  gpio-controller: true
> 
> [ ... ]
> 
> > +required:
> > +  - compatible
> > +  - reg
> 
> Should gpio-controller and #gpio-cells be explicitly included in this
> required list?
> 
> The binding defines gpio-controller and #gpio-cells above, indicating the
> hardware acts as a GPIO provider. Omitting them from the required list could
> allow incomplete device tree nodes to silently pass schema validation.
> 
> > +examples:
> > +  - |
> > +    pcie {
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +
> > +      tc956x_emac0: pci@0,0 {
> > +        compatible = "pci1179,0220";
> > +        reg = <0x50000 0x0 0x0 0x0 0x0>;
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        device_type = "pci";
> > +        ranges;
> 
> Does this endpoint node need bridge properties like device_type = "pci",
> #address-cells = <3>, #size-cells = <2>, and ranges?

No, it doesn't.

> The child of this node is an mdio bus, which does not use PCI addresses and
> does not require PCI bridge translation. Using device_type = "pci" on an
> endpoint might confuse OS PCI enumeration logic, which expects nodes with
> this device_type to be actual PCI-to-PCI bridges.

