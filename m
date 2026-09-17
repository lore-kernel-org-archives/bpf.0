Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC74A689C;
	Thu, 17 Sep 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643417; cv=none; b=SrkP+hJVf1y57ngi3ljIXOY8HkY6oSYUkya8pgQPAc6jeh5xL7kyaG6TMBofMUkK/bvAEgesPOWl7pGWcxn+HvXBJwJotrGwY2CVx+eXLkJPMWCOy+cHbfatwbnp706ApYKaH7vj7gdPMupmhqjC929AMqakgP1RkXCrxcxGEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643417; c=relaxed/simple;
	bh=OGDQ8ynfqxt5lNBYV+TAbNLh05ICfM1VlxEtmEMdb8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djOzoOAww5R/g5LWZyQPSkqAt5wUTcerC7XXW7UPlYbqmQ4QLyFyb/GjsA3S5jkyzDXrxX/MJZgwJDtXaxsIbs3T6eAaNwysnfHpERCNvYzXMsmBr6DdgZPap9blucuOUk6xfzWNFBqa3ZGQYQtrPA+KlR4SskOatjzKW2Y/Kog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnJ/tiIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnJ/tiIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E121F00893;
	Thu, 17 Sep 2026 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789643402;
	bh=RcYu9/NQTxeEVmvwuEoqrceL82UZmeHCQKFB0n6cDO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JnJ/tiIE9hcYG6DGK+tSmWyPSsIOacbTl3TbB1HRRpMgyxbVRKh9UMOvOfHmtsWQy
	 O+m96uEUG1Mk31qGhgHRl4L3xHSvwXVgCiTe5337Wublwj5QNMl6DhJIyikulPNA2T
	 8uhLzlbIw7aq9IhxNw6GFQphSPaRUsvl2pNc996mz12lYXpl3w2eo3CvUi3ylJfQvy
	 VLulRleuBS3P5EHWbinwN+IUNnb6yHP0axDYpwB00eeZYRB9HU7dOOodnIRgfc0PIz
	 AbDTGAFy1LHVef/ldaoja/3ckTqsJK/ag0HLZ/SsjEwJRyANGCgpv+Nf+ANeNCARHG
	 gBAhqTA3a1Kmg==
Date: Thu, 17 Sep 2026 12:09:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: Missing signoff in the bpf tree
Message-ID: <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
References: <aqvBPVcN__UX8P85@sirena.org.uk>
 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KW/2zglwFVpeSqOo"
Content-Disposition: inline
In-Reply-To: <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
X-Cookie: Whip it, whip it good!


--KW/2zglwFVpeSqOo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 12:59:30PM +0200, Kumar Kartikeya Dwivedi wrote:
> +To Eduard
>=20
> On Thu Sep 17, 2026 at 12:30 PM CEST, Mark Brown wrote:
> > Commits
> >
> >   4499609f99fd5 ("selftests/bpf: Test global subprog callback contexts")
> >   3506b9a2f1085 ("bpf: Verify global subprogs in each sleepability cont=
ext")
> >
> > are missing a Signed-off-by from their committers

Does the contacts list for the BPF trees need to be updated?

--KW/2zglwFVpeSqOo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqryoQACgkQJNaLcl1U
h9AePAf/S/yl7NuzOMj/l5SB1hq9XFGYxwtGBIwdfw70FydwwKyWxUhNqZZghurd
PvAGZ722ZCI5wgorSHWLisJPEuX+T7PY/z9S2yir1+81yDwuJuGmnhlb7mHJ3bf/
1N0gefa/XpCIQQi7Pk7aHDoMdI77uEq94oQD0s6H7BFBnr8iWLsONXOhxFJZB/kO
9maCQBLs+c02EyZhiEfe1DN5khPWGXdi6N9zZ09BKLXIxUCioDYSuypchdZLQ8Lz
EPhNouBjKgSImnrwTMxNr/RzEFujhoWRF7Nev/9EuYVpGdqjSA7sXxi03/U/FQUJ
I7fyhy1piiwR6ARM4XnR24SURATK7Q==
=HCSJ
-----END PGP SIGNATURE-----

--KW/2zglwFVpeSqOo--
