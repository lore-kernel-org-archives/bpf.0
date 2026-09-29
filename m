Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFD37AA7A;
	Tue, 29 Sep 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674387; cv=none; b=l8l+/3uL4gjCebyTi68G8cKWxeuM76zfqU3AGXCwcvSO80M/vltiVz59g97TU1VYs/Ukp/vYv/YP1J+z7N3clTFM4JBfSRXl6aRIebGCjjZ52AFhN/GJF7TC/U05FmuX9bc2X2XqEIq0Mu1irZyYsExjupHeO0TAC6s3/KR5XoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674387; c=relaxed/simple;
	bh=egp61g4fx32yp6WAEsrcn+kHQU8ltab5JqPn7OiECDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oipCc0wtYj13YyQFiOvaOb4yiK1wMEdogM5HRNsBOWAy5/rgQz4X4x96ogHYuZ46OU9Nz0IAfH4YFM3S3U/LC4F4n34PKysj8Y/kk597co7jU6upql+oMEpxsJUSCehzCifQ5cyYBMgaKzL0vbNaX4nA5mznuw79zO0PJuPpuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1fEQqx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1fEQqx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EC61F000FF;
	Tue, 29 Sep 2026 09:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790674386;
	bh=7my33tHkcnAh5NzGYvJklT1PtJEphsrY3nRhIAu2WEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g1fEQqx6q9GJjmXIa4fL4LunigoQ8sYi2oCnV0YG6aD4gqsX6MV47f2rOQBdyupOR
	 ZDxf/muo0fXP9Ml6XxfjgNPPwvXz2a3H/ma4tOKFvuPcDQp8QRg5hb5NjKMDWi7qHN
	 lJ5bX1GB8/u+X5Kk26FqdWLRuotq6M/89CVYEYjsPQ/VvOgAd6e8A7qefsNexpVjbO
	 pv29vxAcIhf798lWkQL0VXtsEuguV0bopYfBjxfp9H9xT7akHCUxNpl3QDa6NuaIPU
	 masy6oFHXPWXl/kzWZSoL3BEHwMMMMrWOs9IwXJaDxiz865Aa/NxzzudsvYWCX5F3t
	 SZ/A6FUd2Y6uQ==
Date: Tue, 29 Sep 2026 11:32:57 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <aruD5kwOEsvFhW2e@beelink>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>

On Sep 29 2026, Jani Nikula wrote:
> On Mon, 28 Sep 2026, Maxime Ripard <mripard@kernel.org> wrote:
> > Panels in general, and MIPI-DSI panels in particular, are pretty
> > difficult to support and require pretty much a panel driver for each
> > panel produced. Most of them are pretty simple, and require an opaque
> > initialization sequence that is usually poorly documented.
> >
> > This creates a tension between OEMs and distros because OEMs will
> > typically get a new panel to react to a sourcing issue during
> > production, and thus need some swift turnaround between getting their
> > new panel and it being operational in the OS. Distributions on the other
> > hand can take years to ship a kernel with that new panel driver.
> >
> > To solve this, I followed the example of HID-BPF and wrote a panel
> > driver that will rely on BPF programs to perform the panel
> > initialization. That way, we can ship the programs separately from the
> > kernel, and with a different lifecycle. If this driver is accepted, the
> > plan is to have a userspace component started by udev to identify and
> > load the right BPF program for the panels found on the device.
> 
> I'd think for most panels it would suffice to have a declarative
> language describing what to do at what points in time. For example, at
> poweron, enable this GPIO, wait a little, write this set of DSI
> commands, etc. You rarely need actual programming, or even ability to
> read-modify-write something.

TBH, that's exactly how Maxime presented the idea to me before
submitting this.

> 
> It could be, say, YAML converted to some binary representation. Maybe
> that could be in the DT, or maybe you could override it with the
> firmware loader. And obviously any vendor "blob" could be trivially
> converted back to YAML and upstreamed.

Ouch. This immediately raises the "let's implement a parser in the
kernel" flag, or "let's create a new langage".

That's exactly what BPF is: ou have a source file (in C, rust, whatever)
that is converted to a binary blob that the kernel already knows how to
use and that is safe to load, and we can easily go back to the sources.

> 
> Where that falls short, you could always have a dedicated driver, or
> extend the declarative stuff.

See Maxime's answers: yes, falling back to dedicated driver is still
encouraged.

> 
> Now, the question is, how much more BPF solves over that, without
> requiring a dedicated driver, and is the added complexity worth it?

You'd still need a dedicated driver for your new blob parser, with far
fewer people who had had a look at it than BPF who has been working on
for several years.

The integration of BPF and the kernel is honestly transparent nowaday:
calling a struct_ops BPF function is just a function call away, and from
the bpf calling anything in the kernel is also just a call away.

> 
> FWIW, on the Intel platforms that support DSI, all of the
> initialization, poweron/poweroff, backlight on/off etc. sequences like
> that are stored in the BIOS, defined by the OEM. A plethora of DSI
> panels, one driver. Don't look at it for examples how to implement it,
> but I think the basic idea is workable.

Isn't that what Maxime wants to have? One driver for a plethora of DSI
panels, with the same ability the BIOS has to also do function calls to
set things up?

Cheers,
Benjamin
