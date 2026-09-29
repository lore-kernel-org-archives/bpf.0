Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56D3BC680;
	Tue, 29 Sep 2026 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664874; cv=none; b=nUsomKrjnc83IxtTs9xHmDjvptkVdWi9Bs0OQ6/as3GDOyq0C+IOuPX8ZUyhX2kt/SpaU2LUQt0339o2QjEqLEza9W+1YcFBO0WeJW7aD4QHLrQDcAVae/L3cs6eg0h7ccRHiBYhH4j06Wa8ajt6G5lyIhgntpU4ZDx6JhJQ1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664874; c=relaxed/simple;
	bh=fvVro5k3PR+3AomRvHgSoTQsYco3oL7ZrDn8H9OG80o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFhGzEyTCEATJTwpCkL+hvLAv9/pn8DJYDGr88nsQ1PNHxDdxvb5Vs7BizPKNgmxcXuiprc3ID5z+UufYoF5Vq+wSMeeSMBetDm7v+lwDbom8aBYietsJdr2ahzVMs8vDinR9TQ/gHTCZauayHnn1Z94HBe5I+L9VHIGuiFnbQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPDvVPIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPDvVPIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AF81F000FF;
	Tue, 29 Sep 2026 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664872;
	bh=frSugISh6ArGwMVikkGuowUUcfyIsFmCGNO08QVoGlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mPDvVPIsCW1jE6xXRRu36jGSKhoB6gkBF5/x2mZzSwevIThy1W8kgIJafiodO57Pw
	 jbIF4TZCI+++nk8+KoUXxQOP4eWq2i/rXQ966+/nMEE7rKBi5Z5UmQCJxzHhJCrX5x
	 sdjRWxnDr6NYga4Ofl4rZ2MqeG9crwkRKC3lzCHo0xLhzEYatEReSHb6KAkaJ5PXDV
	 O8ARPrqHDO+PgsRdHOF1KJ9KrJgCuejQZwYl+8RZg83+lZeEZTzPVZrfex1kx5TVTX
	 Gtsh+RKpwW0lbgEdfN/NlVldgQW7k2ljgKd0yh7fcOVCicVxslwl2bGi1VJSz7pqmM
	 GS0t1pNVgio6A==
Date: Tue, 29 Sep 2026 08:54:28 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Albert Esteve <aesteve@redhat.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
Message-ID: <artcVqmYRxeZ4dHs@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928163711.GA210522@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="nqvv5v626rm3lewc"
Content-Disposition: inline
In-Reply-To: <20260928163711.GA210522@killaraus.ideasonboard.com>


--nqvv5v626rm3lewc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
MIME-Version: 1.0

Hi Laurent,

On Mon, Sep 28, 2026 at 07:37:11PM +0300, Laurent Pinchart wrote:
> On Mon, Sep 28, 2026 at 06:22:00PM +0200, Maxime Ripard wrote:
> > Panels in general, and MIPI-DSI panels in particular, are pretty
> > difficult to support and require pretty much a panel driver for each
> > panel produced. Most of them are pretty simple, and require an opaque
> > initialization sequence that is usually poorly documented.
> >=20
> > This creates a tension between OEMs and distros because OEMs will
> > typically get a new panel to react to a sourcing issue during
> > production, and thus need some swift turnaround between getting their
> > new panel and it being operational in the OS. Distributions on the other
> > hand can take years to ship a kernel with that new panel driver.
> >=20
> > To solve this, I followed the example of HID-BPF and wrote a panel
> > driver that will rely on BPF programs to perform the panel
> > initialization. That way, we can ship the programs separately from the
> > kernel, and with a different lifecycle. If this driver is accepted, the
> > plan is to have a userspace component started by udev to identify and
> > load the right BPF program for the panels found on the device.
>=20
> Interesting idea.
>=20
> How would that work for devices that want early display support ? In
> particular, how does it interact with your recent work on "fastboot"
> support (with the kernel drivers taking over a running display
> configured by the boot loader) ?

That's a very good question, and I haven't really thought about it tbh.
I don't think it would be super hard to implement though. For panels
itself, we don't typically track anything in the state. panel_bridge
however would still need to fill its own bridge state but that only
contains the bus formats and flags which can be infered from the DT.

Another thing we might need for the connector is whether it's active or
not, but panel ICs typically don't tell you that anyway, and you can
always infer it from the encoder / previous bridge state.

And then, for the first kernel modeset, we end up in the same situation
than a regular driver I suppose.

> I'm also wondering about the incentives for vendors to upstream the
> code. How will we avoid having a proliferation of out-of-tree drivers ?

I'm not really concerned about that part, because:

* You can *already* support a panel with a proprietary out-of-tree
  module, and it hasn't really affected us so far

* In fact, it's easier to decompile an hypothetical proprietary BPF
  program than an compiled .ko file (that we wouldn't be able to load
  anyway), so if we really end up there, it would be easy for us to get
  to the source code again.

* And panels are so trivial that I don't really see the importance of
  having support for them in the kernel anyway. It's constant tedious
  work that is barely documented, fragile, and provides very little
  value. And the vast majority of the panels are not supported anyway
  except for some willing OEMs (that are using panel-edp anyway) and
  willing hobbyists/consultants. So we probably wouldn't miss much.

Maxime

--nqvv5v626rm3lewc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCartgoAAKCRAnX84Zoj2+
dt9YAYDeU+GLtwcwZIrfjpOUwqvG0dXKTb7mMZ52PfHb8HcUxp3eaOBzW24xy6Y9
WlLfWwkBgLLyxC4OO+6o0WjZXUX0tkDmLjSIY34SioQZFBv1MwyPij+tOMXuIS6y
2wHe+UzVuQ==
=+zAf
-----END PGP SIGNATURE-----

--nqvv5v626rm3lewc--
