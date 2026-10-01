Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D53B95E0;
	Thu,  1 Oct 2026 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790838581; cv=none; b=KKAncf6Fa9S6Zfi2xvOW1+yRvkEhjHUNH39kH5f6e7F06wKUmz9qCs79L3BNV0Tn0Y87izdOO/p5r7WfdV6tLacVLlHfgg3+Zs77n/zxWSxabZiDMt9H7f11N8e/z994OSeqi+6wdiCTSZkV7qrTm4GYuvc+jV8SLIkkB9ue31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790838581; c=relaxed/simple;
	bh=XFF9m1extKl7fuxmH9zsMDX2E4Ef70rJNPT+E8HnDCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpWJBb2xK9qlp9wg3ra1JwOAATVoWNAk4Tigw29HolAvzQpzkgwJuDC6v2ZyNSOp7Bqhf/r37w+nKVsAUaDQnkkGgh99EG0iu9LqG8lXtihgXE6BG6BGpyma1XHNuBWBrlHlJHqIFNdNyOkTxxSkQQmp4kmP8SRgXrGA0/OZFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8TXv8sn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8TXv8sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965BA1F000FF;
	Thu,  1 Oct 2026 07:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790838580;
	bh=XFF9m1extKl7fuxmH9zsMDX2E4Ef70rJNPT+E8HnDCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E8TXv8sn/bSpQE+NI1vYkKweFuPd7YNLLIzGNuQ+ceTS6EmKTPqCxr518iNn8GQ9l
	 aXUKjLMuhGUJ03/7Yzr9S+fIWZC1/dhfZTpt/JUCnlpkuzoOP0PA8m+PKtzWDinIA7
	 1w9ry8qGjqlCvnmNjIDocjTT7HE39m6sIKGxqAaSBs6nchvWxHnm7Bf8lNmbrRAPFo
	 9fop9kGm+I65m2iX6nMlQY9fNRlenCMdG2dm4ebBtegIWPnT32Gno/Pol9pgkbnrba
	 jYftS8MARMUeWwBdPBxrLlqKbfCqb8ssHOr/oNjHzJqstipUmCCbfD/1SrmJJ2uKBJ
	 3McRuxZ1+Lv6g==
Date: Thu, 1 Oct 2026 09:09:35 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
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
	linux-arm-kernel@lists.infradead.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
Message-ID: <ar4G864IgYTvfNNy@houat>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
 <20260928204059.GA515872-robh@kernel.org>
 <artyl8fD3zzng8Uh@houat>
 <742d5bab-51cc-49f0-825a-f299a055bb1e@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="s3nqed5trv4kttpt"
Content-Disposition: inline
In-Reply-To: <742d5bab-51cc-49f0-825a-f299a055bb1e@linaro.org>


--s3nqed5trv4kttpt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf generic
 panel binding
MIME-Version: 1.0

On Wed, Sep 30, 2026 at 03:32:19PM +0200, Neil Armstrong wrote:
> On 9/29/26 10:39, Maxime Ripard wrote:
> > Hi,
> >=20
> >=20
> <snip>
>=20
> >=20
> > panel-mipi-dsi-spi is a generic panel that will load a firmware, and
> > quite similar to this one. google,android-pipe and qcom,fastrpc don't
> > attach to anything and will just open a tunnel to userspace, which is
> > somewhat equivalent but more dramatic than what this driver is doing.
> > simple-card or its variations will just instantiate a kernel driver from
> > the DT and is used pretty much everywhere.
> >=20
> > I reused the binding from panel-mipi-dsi-spi for this. It was reviewed
> > by rob, and acked by a panel maintainer, and 4 years ago, so we're way
> > past the "oh but we didn't know what we were doing back then" argument.
> >=20
> > So, let's phrase this differently: what's different about the
> > description than panel-mipi-dsi-spi, or any other binding already in
> > tree?
>=20
> The panel-mipi-dsi-spi still describes a class of H/W control interface,
> not a pure software driver implementation type.
>=20
> "panel-mipi-dsi-bpf" or "panel-mipi-dsi-rust" or "panel-mipi-dsi-cplusplu=
s"
> would be the same problem.

Rob explicitly said the bpf part wasn't the problem. Also, I don't care
for the compatible itself, so what would be an acceptable compatible for
you?

> > If it's the BPF part, BPF is not Linux-only, and there's hardware with
> > direct BPF support these days, so it can be considered OS-agnostic and
> > not an implementation detail.
>=20
> If somehow panels used a standardized MIPI firmware we could define this
> in DT, but here we're basically inventing our own type of firmware from
> thin air.

That's not what panel-mipi-dsi-spi is.

Maxime

--s3nqed5trv4kttpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCar4HLwAKCRAnX84Zoj2+
dl6uAYDovwkc1hvb39koGbGLJWTMCbmYcACHdaVw0R7sPvU3411ITrKE0XW6bqGC
VstReW0Bf3SPl1Nrf6ImNbY2KvutXe9EvqIRF88l0/bekyLhlDEc+vl+24UFci5P
jH5weB34Lw==
=ZDWr
-----END PGP SIGNATURE-----

--s3nqed5trv4kttpt--
