Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1C37BE9F;
	Mon, 28 Sep 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619167; cv=none; b=iJiY/In1875Qt6XQ2iJr5VgH7hdMGPJEiZiVKeVo/mwarNFQykIi0xxeou9lOnif5DyPjhJPLhNdJ/AGEXIuWBmOeU96rgxQ54MhsYLJSieCY0RNJh8FTP3Plqh00Z/mf6NAOq16hsM6r8PU3Dl3fCqFyr/7X4pDAceQP98By/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619167; c=relaxed/simple;
	bh=USfKYzH0A6fMkjH3Ae9LrJxx6YoB7rY2b4VDa8FNY+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XredEqfa5hZ5DkHm+/bWtJzf5clfBY2VABhtdC/e/swodRs7t53h2rdAeiyc2nlt2eykOlrJQSrIW5GZbAG1NrXoIrTSmioxFtZuqFW3sRyVJ/nLhvtrlfpdRflD0ZJj98N7nIHX9+vBnsITH5e8CD3lIk7MyIrZGZqM7AHLbog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QTo0gZkm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QTo0gZkm"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9B5D18FD;
	Mon, 28 Sep 2026 20:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1790619052;
	bh=USfKYzH0A6fMkjH3Ae9LrJxx6YoB7rY2b4VDa8FNY+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTo0gZkm7WwOtTm4JaKIpKPrNLiNa+iZIUEZ+OKoVN6xmtGJuZe+OAlqHyYjFcvoh
	 CEdeaxjv555X963g8CAZa26Y7UZal+YLZ74per2iWl1sNXIT3kYNjPZmw2ailNjNf0
	 On4p0mZ6uI91tZqb1ZUSGlulGesv3QLO3SS1ocAg=
Date: Mon, 28 Sep 2026 21:12:41 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Albert Esteve <aesteve@redhat.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <20260928181241.GB210522@killaraus.ideasonboard.com>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928163711.GA210522@killaraus.ideasonboard.com>
 <arqi0etVHGajQAMe@beelink>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arqi0etVHGajQAMe@beelink>

On Mon, Sep 28, 2026 at 07:31:59PM +0200, Benjamin Tissoires wrote:
> On Sep 28 2026, Laurent Pinchart wrote:
> > On Mon, Sep 28, 2026 at 06:22:00PM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > Panels in general, and MIPI-DSI panels in particular, are pretty
> > > difficult to support and require pretty much a panel driver for each
> > > panel produced. Most of them are pretty simple, and require an opaque
> > > initialization sequence that is usually poorly documented.
> > > 
> > > This creates a tension between OEMs and distros because OEMs will
> > > typically get a new panel to react to a sourcing issue during
> > > production, and thus need some swift turnaround between getting their
> > > new panel and it being operational in the OS. Distributions on the other
> > > hand can take years to ship a kernel with that new panel driver.
> > > 
> > > To solve this, I followed the example of HID-BPF and wrote a panel
> > > driver that will rely on BPF programs to perform the panel
> > > initialization. That way, we can ship the programs separately from the
> > > kernel, and with a different lifecycle. If this driver is accepted, the
> > > plan is to have a userspace component started by udev to identify and
> > > load the right BPF program for the panels found on the device.
> > 
> > Interesting idea.
> > 
> > How would that work for devices that want early display support ? In
> 
> Brain fart... Include a bpf VM in the bootloader? :)

The boot loader can have its own panel driver, that's not an issue. What
I'm wondering is how we will deal with e.g. getting oops traces on the
screen before userspace is available.

> > particular, how does it interact with your recent work on "fastboot"
> > support (with the kernel drivers taking over a running display
> > configured by the boot loader) ?
> > 
> > I'm also wondering about the incentives for vendors to upstream the
> > code. How will we avoid having a proliferation of out-of-tree drivers ?
> 
> My 2 cents here from the HID-BPF point of view:
> - as mentioned in my reply to Neil, the kernel enforce GPL licensed BPF
> 	only

I didn't know that, it's interesting.

> - so vendors have to publish their code somewhere
> - in HID-BPF, I decided to provide an "official" list of HID-BPF sources
> 	as part of the kernel (see drivers/hid/bpf/progs). I try to sync them
> 	with the userspace tree when time permits
> 
> So basically, distributions can say "we ship only BPF objects compiled
> from the kernel tree". It doesn't mean they have to be in a released
> kernel already to remove the friction, but in the process of being
> released could be sufficient.

-- 
Regards,

Laurent Pinchart
