Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AA4E50AF;
	Mon, 28 Sep 2026 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616272; cv=none; b=ZrjK/hUiF1e68cdxAWxgXOvcdk1f/aRDVD4WUVfgYjkHFCXJ6OM5ffITzwrJaje8RgJXCeTrnm5SziD5mJ+yqZeK3A6NwYg8xdaZX3PLxFX86UAJyswPaGnM22h/HYIlc5MMmi/+t6yGF/pBGo5xKt0d27Nnm6rq+kztrLhFbmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616272; c=relaxed/simple;
	bh=A4sGNxmkOrAHQZrCx4hlTt8pCr3WBaG5i7z5E4gUzm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRq9OiulSVvmekQFbQ9G0cA6DDf4bUte2WmW3SMCeQYb3JKTgCOQ4JYE1WCaunLRw8kovIFlA4B4wTnzMqGibmHABzEJDtK/yB+tvoMhDjO/WL99BFcNYpaqbvDMlu+e0hY1wW7xGSBnD9z4ektt4wf32Gdsp0FoTtZWyjMm4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTTnwgHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTTnwgHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A4B1F000FF;
	Mon, 28 Sep 2026 17:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616271;
	bh=CzE2GE5JN/tI9+vf5ceSYktDtLDt2Ax4ATT81DGIpY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BTTnwgHo3e7c9o0rEnQRB7ZYUXhkhD5eIFXOeC520HyCwUZwp8jntGIY9n5YsIix9
	 /Ym50PIIpYqM37fQQXINrRbjumZpkwgpqOull3Vidwl2FElBE4K/ZGUVeOGKt8cKu4
	 a+UKkqCjaVec32acLq750VC4ry62UJhA1lTT4gGp/y+DstTdzx6MC0BJ24rg7StUJf
	 dgv845cDIgkefff7Lc7OjPDgek/7/hApSlYTBXj74Uhnqg/3FzAsZ6YruF/Wkt4mBa
	 F4lCS7i9EpYsGaacidhpQDKTKg3WlYFlUrNt18dgBccYqZ94wbeGNi0MRC87EwDbH+
	 BDQNjNC1bQU2A==
Date: Mon, 28 Sep 2026 19:24:21 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <arqhwHiVf00j94J7@beelink>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b80cb97-6706-412a-b013-9423f6f75153@linaro.org>

On Sep 28 2026, Neil Armstrong wrote:
> Hi,
> 
> On 9/28/26 18:22, Maxime Ripard wrote:
> > Hi,
> > 
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
> This is kind of late for serious applications except if we manage to
> solve the bootloader to Linux display engine transition.
> 
> > 
> > This driver is fully functional and works with both 5" and 7" Touch
> > Display 2 panels for the RaspberryPi. However, it breaks away from the
> > typical panel driver in multiple ways:
> > 
> > - BPF programs can only be loaded by userspace. This leaves us with two
> >    choices:
> > 
> >    * We prevent the driver from loading until the script itself is
> >      loaded. This has the side effect of preventing any other output to
> >      be used until the initramfs is ran at the earliest, and possibly
> >      ever if the loader isn't installed for example.
> 
> This adds a dependency on user-space behavior and if somehow the
> initramfs doesn't load for a reason we won't have a way to display
> an error.
> 
> > 
> >    * Or we probe the driver all the time, but only report it as connected
> >      once a program has been registered. This is somewhat unconventional,
> >      but allows the other outputs to be functional, *and* allows the user
> >      to force the output if their panel doesn't require any
> >      initialization or during debugging. I chose this solution.
> 
> Both options are not really great...
> 
> > 
> > - It's not a panel driver, but a bridge one, which is also pretty
> >    unconventional. This is required because panel drivers don't have
> >    access to a detect callback that is required for the above, but I also
> >    think that the recent work from Luca blurs the line from panels and
> >    bridges and we'll end up going that road anyway.
> 
> On this point, DDIC _are_ bridges, but in the current panel API we blur the line between
> the panel and the DDIC. So being a bridge is fine, but in a general way we lack
> a proper way to describe the display/panel/monitor independently of the DDIC.
> 
> At first glance it's a nice driver, but moving the timings into a blob moves something
> into possible proprietary binaries with possible closed licence and distribution
> restriction so it's a downgrade for the same of bringing up a panel faster.

Quick answer on this, because I had the very same questions regarding
HID-BPF:
- in BPF, you can require (and by default it does) that only GPL
	compatible BPF programs are loaded, closing the argument of "closed
	licence and distribution restriction"
- also, a BPF program can be disassembled much easier than a binary
	blob, and I remember Alexei showing me an example where you get almost
	the source code from the BPF object in just one pass.

Cheers,
Benjamin

