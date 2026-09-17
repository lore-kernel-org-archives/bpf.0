Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B974E0B97;
	Thu, 17 Sep 2026 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665364; cv=none; b=m80R7bAHEQWyVS56wS7mRm6/5bR+V5E9+BGiSDNz0xCgv+E42GxNe5KCAn1YxhbfLQB4DREdsTIhbW3WXboGAAxx/rmhM56ybxlwX6e0N/CKQhbPQ8zuLn0aLYLU22wxWk7Ea3trAgislybg1BLxTESP9XeHdbDFxsjIWmYI5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665364; c=relaxed/simple;
	bh=82KYVSZ6+P/lYvCQQCYrH++1VHotiPvySA50BPg7DGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4bCYWkBEXRUIl22R+GTpNVlAdBIdlMXnYFX0X1FZ18PYVF52/Ixgl1T5G7P9yO09MaxPhHXSptP9cTUS1hCIzvazrC4JKZdy5spYstpN/rLbJNiSiC7TAUpTQLjCX6am32H4aMQm89ljX9yFvrMMHTvgEl0smG7qJqbsRnzgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZlIvVVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZlIvVVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEC61F000FF;
	Thu, 17 Sep 2026 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789665362;
	bh=82KYVSZ6+P/lYvCQQCYrH++1VHotiPvySA50BPg7DGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IZlIvVVvXfQ/eqTa55hTCAXS2hRuC6mXS/KrW7gTMdCgZ0lB6NUSiFC3L8lJgEEmG
	 fTGfIcC8BV2hTVhFJwEvLO1i45Porisk0zaRbGpQfBUCWHPtL1H6t6oljr0+S7vcmX
	 NtjqBRoBzeiguqtp2XmVbmWff/RUwMsQ2uujOCO7iN0ukNX2eGA8niHP88a1VcWiRq
	 OLrEVpnNQx+iIu4Be84okXvB+oFb9ZlOAq0fXV04xofv/0cXlbIGKiazpUB7av57cb
	 rsYyrQ4oxADTUxULEWYC+2cbz8ELAJhKj0Z/hWGr7EkyEtYr0ImwW/lZhEUFU1xpKS
	 r+iUxmJ1BXt3A==
Date: Thu, 17 Sep 2026 18:15:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: Missing signoff in the bpf tree
Message-ID: <d6274d8b-807e-4546-8bad-29826b47a9a9@sirena.org.uk>
References: <aqvBPVcN__UX8P85@sirena.org.uk>
 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
 <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>
 <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
 <9d668d7c-8f85-49ad-bdb9-5cb81fb6f60d@sirena.org.uk>
 <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E1hMGN2GjvYIXJPV"
Content-Disposition: inline
In-Reply-To: <c80c4e2aee9502d781fb52bcd5c0972ccd3bc7e4.camel@gmail.com>
X-Cookie: Whip it, whip it good!


--E1hMGN2GjvYIXJPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 10:08:38AM -0700, Eduard Zingerman wrote:
> On Thu, 2026-09-17 at 16:03 +0100, Mark Brown wrote:
> > On Thu, Sep 17, 2026 at 01:27:01PM +0200, Kumar Kartikeya Dwivedi wrote:
> > > On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:

> > > > Do you have a full list of the current committers, I guess there's been
> > > > more bitrot than just this?

> > > It's me and Eduard, apart from Alexei, Daniel, and Andrii.

> > I've added you and Eduard.

> Apologies, that's on me, some issue with scripts configuration again.
> What would you like me to do? Force push with SOBs?

There's no problem I noticed with the tree - this is about making sure
the list of people who I contact when there's issues with the tree
includes all the committers.

--E1hMGN2GjvYIXJPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqsIE0ACgkQJNaLcl1U
h9D0Ggf/bPNxKd+RtYrnqms34RZdUAd5J70AlyeG0v6NJ0kP9UiE0yLmslT36KIQ
rGl8uUIgBFsJexouefyvzHQU71hkgRy0aBDnYXUGR0oJxzZCtgDu+oRKGp5c40zc
QMOVTlvgxU069sqcufzgWFsmHvD6RSvFuldWpleE9C3LC2bGZiK99Hbn0M9bJnTy
vLWLv0xOrGoH4iTrhCvFQkz9/pSo+QgTSDP+w4PpgqPU1xaw5DqvYMdJG1Khe+4J
S5whyf+wwRNDVTyMVP/YI6B91MpOV2s2hq4KHp0p+iNaC1gaZXalb+2l+sa/oEyD
y9lsr04XQmETARlbBX7GUg8zMsr4cA==
=Ve7z
-----END PGP SIGNATURE-----

--E1hMGN2GjvYIXJPV--
