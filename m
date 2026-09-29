Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFD280A56;
	Tue, 29 Sep 2026 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725488; cv=none; b=pnXjxsvucD0/x84b0zkUB5MtNNaZcPCML/9c96VfwoFZjj2ofC0D+CmJ0ULXcw5l+EIOp6dqTL331XDahF9ciBVm52rGqMn2pPSdIGHmNxSq4C++O6OZe7EA6gSuxAPTBwNprRGgYxm5XIX1tSfV36vx4ElPbzjptokBFoHib+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725488; c=relaxed/simple;
	bh=1a7q26AUiSJfJhnLWkDe/E6QUJLPL8uPOwMxAmLWoIs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pOQVW3rhu8HSq1LP2sGLZ6Q1jE8mY+eRexzKqkqSLIBgZTLxOdSsCe5Bh8YsL5SPhIJoisOlwHdqLm75IdRDwls79LTHMMbAixD+ljfNQJxhwi8dE7SWYIlJHGIviWJWzCmtVR0oHLWq9ZJQhk0O9AtXnSHMS12K5giql8fj/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPOXNofF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPOXNofF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB7A1F000FF;
	Tue, 29 Sep 2026 23:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790725487;
	bh=q2vPaj70yTFF+nCTHOa1lt+SyViZlBiPKXQR9Adb58c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RPOXNofFRqkcQuogCKfEIrqLH/O4qWMCVjTZxPeEtTkXTpTSudAIKMfHWE2IcO6kI
	 Jiwu3bHTRgMX2r3LxA/0g8nG+qX77tRrELkRYC4GqB6i7ntUd2A9Z6kRpACYYyWK59
	 xOh91Xbkv6RPMHOFB1GtRBAFpQH750wER7jt4H9gOTUZxtYvmkQ9029uOahWlFBGdS
	 srP7Jflk/E5/4H3hp/3BiCjf7oL9O1DfM3Cx3DowLg8pAzraqnn+JY8e2i+U4IpMRs
	 XFnwzbxifKnGopNwBPZ+AYsywJNBqiDEQ+cYTFvyuJ4azZEjvenBX+eiCSDEw7lI4d
	 KawC3aw36Rc7A==
Content-Type: multipart/mixed; boundary="===============4708192409122229443=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7e3ff8952daf06c86b01ff0e115fb6684231f3d666570bd79d93e6a914beaba6@mail.kernel.org>
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic panel binding
From: bot+bpf-ci@kernel.org
To: mripard@kernel.org,neil.armstrong@linaro.org,jesszhan0024@gmail.com,airlied@gmail.com,simona@ffwll.ch,maarten.lankhorst@linux.intel.com,tzimmermann@suse.de,robh@kernel.org,krzk+dt@kernel.org,conor+dt@kernel.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,florian.fainelli@broadcom.com,bcm-kernel-feedback-list@broadcom.com
Cc: andrzej.hajda@intel.com,neil.armstrong@linaro.org,rfoss@kernel.org,Laurent.pinchart@ideasonboard.com,jonas@kwiboo.se,jernej.skrabec@gmail.com,luca.ceresoli@bootlin.com,aesteve@redhat.com,dave.stevenson@raspberrypi.com,javierm@redhat.com,dri-devel@lists.freedesktop.org,devicetree@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,llvm@lists.linux.dev,linux-rpi-kernel@lists.infradead.org,linux-arm-kernel@lists.infradead.org,mripard@kernel.org,bentiss@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 29 Sep 2026 23:44:45 +0000 (UTC)

--===============4708192409122229443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml
> new file mode 100644
> index 000000000000..9a20a21cf70e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.yaml
> @@ -0,0 +1,184 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-mipi-dsi-bpf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic MIPI-DSI panel with BPF init sequences
> +
> +maintainers:
> +  - Maxime Ripard <mripard@kernel.org>
> +
> +description: |
> +  A generic MIPI-DSI panel driver where the panel-specific power sequencing
> +  and DSI init commands are provided by BPF programs.
> +
> +  Panel DT nodes use a fallback compatible so the generic driver matches on
> +  "panel-mipi-dsi-bpf" while the first compatible identifies the specific
> +  panel for BPF program matching.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - description: Panel-specific compatible string
> +      - const: panel-mipi-dsi-bpf

Rob Herring raised concerns about this dual compatible string design in
the v1 discussion: "If you need the 1st compatible anyways, what is the
point of the second one?"

He also pointed out a compatibility issue with existing panels: "I assume
there is at least some panel supported in the kernel you might want to
convert to this. That panel would not have the fallback (and the DT is
fixed)."

In the follow-up discussion, Rob stated: "What? You can't add a generic
compatible in these cases."

How does this binding handle the case where existing in-kernel panels are
converted to use this driver, given that their device trees are already
deployed without the panel-mipi-dsi-bpf fallback compatible?

Neil Armstrong also raised a fundamental concern about including BPF in the
hardware description: "I don't see how this can be a valid hardware
description, bfp is a software implementation and has nothing to do in the
bindings."

Should the binding be redesigned to avoid referencing the software
implementation mechanism (BPF) in what is meant to be a hardware
description?

> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  backlight: true
> +  enable-gpios: true
> +  height-mm: true
> +  port: true
> +  reset-gpios: true
> +  rotation: true
> +  width-mm: true
> +
> +  vcc-supply:
> +    description: IC core supply, typically 2.8-3.3V (charge pump input)
> +
> +  iovcc-supply:
> +    description: I/O interface supply, typically 1.8V (MIPI logic level)
> +
> +  avdd-supply:
> +    description: Positive analog supply for source/gate driver, typically +5V
> +
> +  avee-supply:
> +    description: Negative analog supply for source/gate driver, typically -5V
> +
> +  elvdd-supply:
> +    description: OLED EL positive supply
> +
> +  elvss-supply:
> +    description: OLED EL negative supply

Rob Herring questioned the approach of defining multiple optional supplies
to cover different panel types: "That one [panel-mipi-dbi-spi] defines a
single supply. Any other MIPI SPI panel with different supplies or GPIO
controls probably has its own binding. Trying to parameterize that in DT
doesn't work. We've rejected trying to do that in DT over and over. What's
your story here for that?"

How does this binding address the longstanding kernel policy against
parameterizing hardware variations through optional DT properties?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36644629998
--===============4708192409122229443==--
