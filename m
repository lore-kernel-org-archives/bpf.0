Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48694ED1AC;
	Mon, 28 Sep 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613351; cv=none; b=gybK1K5KgbX4vAj3do+H2WvFxk85NoVOE3IG+6SUJDnovjl1FONjcTU2VEQ2ze2CIKUSMyb1Vstngcs1a1l908nylWwZmNn6Qhqu3y3CXoyUbOrKvhd5ntEdOIDdXip5Q2Qanna7CAZk+T2Rc3wTY7O/UZDlOoJ/7dHbpm9y8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613351; c=relaxed/simple;
	bh=/Mqri5mTDlDrV1GwOlEqnhiCrD1oRaogsEIr4KAyKR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YrbR+bODptLrhu7fsl0g/0MsMLzPexzCrxzYeuGtGq+uPE/xwHBlNhNzVTRvoGufVXiUNmCjhKx+eSDOOr7DrpjxgKz7dyg90GweT3IJmSz+kMthPk0n0sxqhWpUCdfWKiU5LWyb3XBvpCqEEwVNjWiyJVHqoozDBv+PvWr4nCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nirbHt65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nirbHt65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53281F000FF;
	Mon, 28 Sep 2026 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613350;
	bh=w/sVognZBorzeMIsjNGcSKPpCvaHEm1JDK4PKd4R7Qc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nirbHt65n2yYu0oyRo7D16HRtKHd6xck+JbTm40dBlsZI4rUqumBgvQlRBIZuJIyM
	 3kJyQAZpERCQptOxksU8b9THDIcmXwa4Mms68shK6d/dJBouWaW6R5hlE+jC+o0761
	 x105WgzzkSvwlXvBYjQhm9lLD80JJ9zFLKjlJaWE4kxnqvdEQrYp7Xq4CJgmvlqPt2
	 mwby4y2sSSSZVKvzhFuIC9bNFgoLcMpSjVmzyOlXCbanXFj+OvoGp1ffDIkycyDqAF
	 5y0lSZsOgk9LvDlUb0WS/uz20ymFvUPoA7N5du7FOErf5XUyDTJR2FBP2x058hksV7
	 aRhY40fMJXCfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf
 generic panel binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxime Ripard" <mripard@kernel.org>
Cc: bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:35:49 +0000
Message-Id: <20260928163549.E53281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/panel: userspace BPF requirement breaks early boot panic displ=
ay
- [Low] dt-bindings: display: non-standard dsi-lanes instead of endpoint da=
ta-lanes
- [Low] dt-bindings: display: missing gpio.h include causes DTC syntax error
- [Low] dt-bindings: display: examples fail validation against legacy schem=
as
--

commit e9b8b6539dfc465519559ca54cf48b580b394bd1
Author: Maxime Ripard <mripard@kernel.org>
Subject: dt-bindings: display: Add panel-mipi-dsi-bpf generic panel binding

This commit introduces a generic MIPI-DSI panel binding where power sequenc=
ing
and DSI init commands are handled by BPF programs loaded from userspace. It
defines standard regulator supplies and DSI parameters while using a fallba=
ck
compatible string to match the generic driver.

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-d=
si-bpf.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-ds=
i-bpf.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.=
yaml
> @@ -0,0 +1,184 @@
[ ... ]
> +title: Generic MIPI-DSI panel with BPF init sequences
> +
> +maintainers:
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +description: |
> +  A generic MIPI-DSI panel driver where the panel-specific power sequenc=
ing
> +  and DSI init commands are provided by BPF programs.

[Severity: High]
Does this architectural requirement to rely on userspace-loaded BPF programs
result in the loss of early boot display capabilities? If the system crashes
during early boot, before userspace can mount the rootfs and load the BPF
objects, it appears the kernel would be unable to autonomously initialize t=
he
display to render the framebuffer console, splash screens, or kernel panic
messages.

[ ... ]
> +  elvss-supply:
> +    description: OLED EL negative supply
> +
> +  dsi-lanes:
> +    description: Number of DSI data lanes
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3, 4]
> +    default: 4

[Severity: Low]
Could this lead to fragmentation of device tree standards? Standard devicet=
ree
practice for DSI and CSI typically describes lane configurations using the
data-lanes property within the port or endpoint graph node, rather than
introducing a custom property like dsi-lanes at the root level.

[ ... ]
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "elida,kd35t133", "panel-mipi-dsi-bpf";

[Severity: Low]
Will this trigger schema validation errors during make dt_binding_check? The
dt-schema tool automatically evaluates examples against existing legacy
schemas, such as the one for elida,kd35t133. Because legacy schemas typical=
ly
expect exactly one const compatible string and enforce additionalProperties:
false, they might reject the dual-compatible array and the generic
BPF-specific properties used in this example.

[ ... ]
> +  - |
> +    /* OLED panel using avdd/avee and elvdd/elvss supplies */
> +
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "boe,bf060y8m-aj0", "panel-mipi-dsi-bpf";

[Severity: Low]
Similar to the previous example, will dt-schema reject this dual-compatible
array and the generic properties when evaluated against the existing
boe,bf060y8m-aj0 schema?

[ ... ]
> +            vcc-supply =3D <&vreg_l14a>;
> +            iovcc-supply =3D <&vreg_l12a>;
> +            elvdd-supply =3D <&vreg_oled_pos>;
> +            elvss-supply =3D <&vreg_oled_neg>;
> +            reset-gpios =3D <&tlmm 6 GPIO_ACTIVE_LOW>;

[Severity: Low]
Will the dt-extract-example tool cause a DTC syntax error here? This second
example block seems to be missing the include for dt-bindings/gpio/gpio.h
which is required for the GPIO_ACTIVE_LOW macro.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-drm-mipi-d=
si-panel-ebpf-v1-0-5244926aace4@kernel.org?part=3D1
