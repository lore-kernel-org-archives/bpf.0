Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70304E80C3;
	Mon, 28 Sep 2026 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628063; cv=none; b=THI22Io4JdguwNe4EKninw92NTI48K7hHckyCZYqv/c9TJ4qB1RZm23idvv2JuPobbXXX3yXETb9vQ9yo+gU4LA4OYJ3IfQCAhwlyRSZf8ezw84rfTwHkkgLQ+mEK+DMHxZ3+8WFucItAgJxe0W6KvPdR5BgGaV7Ov7ReCW2WKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628063; c=relaxed/simple;
	bh=LiG8M1g1s4hpV/5/ll/EQsp5UdX56AQ73H8mw0UIYCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lL6mFshXEZ1iL8JHedQ1AEP1u2Xg90f6w9TJkuvA0pIWu3Q1b9Ch1Yb28sBP173mvTvct5+A2r1uxlwUIcRN7HJbrhJEsHSG08mjdwkRw9+uUuxfU+YGmMzWeoKP518V95vAgGbW3oJvJi0ToolzIf0BT6qbsprMjRtEBx9NlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egMXFZSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egMXFZSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D5E1F00898;
	Mon, 28 Sep 2026 20:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790628062;
	bh=NLW0Xvdr0NdDdNm3pJOiMfwy/Xm72khh3QPraAupQ7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=egMXFZSFJB8mIyXxncXKqSPcoR7YjAGqoqd1U9D9l0YRxjjUjZRzlxCONoBn5oAms
	 I3tRdMjjkNFhoZqWIMId7vW1XmU2yi/unDIg2XY2LRHTGafQ0aMZzjp/rhfkoWUxEE
	 o5wMXTad/9D4Rpwpgmh+Qk4aCNKVo01HPLlEuOJ6/XrVZ4LSxVdoWg8TnYbkI/fOOy
	 60ouPKeoRXjipb+i/MjB2mtzMDzpfGvVnNjGhosiUNudr8tV9mW0dYhdFNl8cfY80z
	 LsCuhOsxDNHPMzD6WhRGaJSSg54X96OQq2mD2UAvdeYavujR8brUKcWIi0e5IyyuoN
	 TKXUO1R/PMAdQ==
Date: Mon, 28 Sep 2026 15:40:59 -0500
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Albert Esteve <aesteve@redhat.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
Message-ID: <20260928204059.GA515872-robh@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>

On Mon, Sep 28, 2026 at 06:22:01PM +0200, Maxime Ripard wrote:
> Most MIPI-DSI panel drivers follow an identical pattern: acquire
> regulators and GPIOs, perform a reset pulse with specific timing,
> send a vendor-supplied sequence of DSI commands, then enable the
> display. The only truly panel-specific part is the init sequence
> and power-on/off timing.
> 
> The panel-mipi-dsi-bpf driver replaces per-panel kernel modules
> with a single generic driver whose panel-specific behavior is
> provided by BPF programs loaded from userspace at runtime,
> following the HID-BPF model. This enables new panel support
> without kernel patches.
> 
> Panel DT nodes use a two-entry compatible with the panel-specific
> string first and "panel-mipi-dsi-bpf" as fallback. The generic
> driver matches on the fallback, while the first compatible is used
> to identify which BPF program to load.

If you need the 1st compatible anyways, what is the point of the second 
one? Also, I assume there is at least some panel supported in the kernel 
you might want to convert to this. That panel would not have the 
fallback (and the DT is fixed).

And I agree with Neil's comment. At least until we start embedding BPF 
into DT directly. ;)

Rob
