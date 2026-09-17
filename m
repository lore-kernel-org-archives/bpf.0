Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C73E9F9E;
	Thu, 17 Sep 2026 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644247; cv=none; b=QChYp56OPcPIAnvxV43Za7U7WtDB1FKt+Hb4PDa/yvFlZGlGi5IzvzOWTHdPgNvH1C5TJBkJspqPhV7b/vqqcoX0lI1/dFiS9pu0QT4Ks+ihD3CKk1TndlnSNERSrU7ioxfwck0PeP6+VDhp5i83IZ13t+kv4WnR868eu4whU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644247; c=relaxed/simple;
	bh=gNzm+LAaqYnVv1UeRYDG3ak5Awq1pSqBXi67yI8FMsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trnTlej8dwZhsx0TAJyQsvCyFVNprGVFeJc4wUPCYGiRsknYNgCvOsT+k/pNsvYjrsFFd8avIfL8k1WqcLSqH1XB8Xxg5ho9xdEjcyuKdoQzwRi9p9LGkmsYoe8HbTYw0aXP/A6+u4wrP58eKkMcLwRGxm1tEimWk48Egew6k/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilvuNkBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilvuNkBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EE41F000FF;
	Thu, 17 Sep 2026 11:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644246;
	bh=gNzm+LAaqYnVv1UeRYDG3ak5Awq1pSqBXi67yI8FMsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ilvuNkBFMhXN/jR7x2ViwqKLc6YWTf9LsRBHCmGSvMHXiKBDyByLV/uodUs0LOxB4
	 d8gBhPtav22ADopLhlSb7uZ2bqQCkPh2L7SELz3pnrMnjWGEMBD+88AqaCsRhkghrU
	 hiLqKURCei3GL+wK8b/2i1BW7FpiChAH7vE/Hf9FYpg9rDjGe1OC73fkDxwM8nvQBk
	 NLu6t9tT69UciHOLVxDmVwS4nbBiOT3mEIsuQ0AR35fq4ZrQ5pSAvPGQMexKQY9NCQ
	 B98uDEs5Mc9BWtwlpQ+RDFmKlsuQOmVjpk9JsMzQy/L/FgNrdpMXNOzpMs1cpmPkd3
	 DlJJKZ2h3xe8w==
Date: Thu, 17 Sep 2026 12:23:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: Missing signoff in the bpf tree
Message-ID: <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>
References: <aqvBPVcN__UX8P85@sirena.org.uk>
 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
 <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mvjAN2tVGNxSLZN2"
Content-Disposition: inline
In-Reply-To: <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
X-Cookie: Whip it, whip it good!


--mvjAN2tVGNxSLZN2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2026 at 01:20:11PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Thu Sep 17, 2026 at 1:09 PM CEST, Mark Brown wrote:

> > Does the contacts list for the BPF trees need to be updated?

> Well, he's the committer, so makes sense to put him in the recipients as well :).
> Once he gets to this he can probably force push to correct it, I guess.

Do you have a full list of the current committers, I guess there's been
more bitrot than just this?

--mvjAN2tVGNxSLZN2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqrzc8ACgkQJNaLcl1U
h9Dczwf+OxyaIcr5oPsOvDHEb2RaIGYPDQUdFJwWfMHBaYi4ILiLhacStQvnqKdR
K3FruEIlHZuIBHtzKrMqPsp0/Hpz4Couw/fCX6GzUzK6htCD2YaGcbUsSgh2yCMd
n5z+c+B9z28xo6/SnI8Xd33Zlkubq49G4To6Fun0V+uQw3LWs1wOQR8ZR57ruVNh
zrJkCBaiLRbBSkbtuvBEvW+TA6uLpTmgN8hlAon2LoCRe3D1sjjbFUnmukDb3aLR
3PNKVHKhcxYN8bIf1WGzNx8zg26diQXOsb91+JqlicgZ+GiuDQmB3nOSv09PjYsF
vgRkeE/BtMEkgaJhGq+er7nPut6i7w==
=MUEE
-----END PGP SIGNATURE-----

--mvjAN2tVGNxSLZN2--
