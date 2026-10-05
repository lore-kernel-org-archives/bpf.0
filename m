Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49710488206;
	Mon,  5 Oct 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207473; cv=none; b=udy5iX3PjoCIpr7qg80CnUZLyP/g2OK1INl2bjjkGyqT5Bel0YJLVTUWOS63NHT2LxuSzrnAXmLXC57pOv5hbvoYZ+JqrMz+2zCjjflzB7pmrb75cyqid9B5Sv4GdUrn+4+iNOh0B43+SYDogAd6hdkJrVRQNh6UUkVgdd5SPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207473; c=relaxed/simple;
	bh=IVJ8ZyuSC0Lbab2geB5UGXa7oruIwTAGiC5pEI/0beo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yd7Spbey+uhrRYIoFnyTgRlSrbc7GFBn5lv2ud8wemxwAt+gNMDPf/zF6RyM6QZNasRvMWRjXklcS7gRq7yESlp0OsA2u1vLZXkH5r+yl2V0dDdldnDM4NRvpJiBoZ6HiQXxcI+GZyKj/N70pNdQpYhrBDbR+piW0YJ5SRlYkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgGTCG55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgGTCG55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5BE1F000FF;
	Mon,  5 Oct 2026 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207471;
	bh=PoXS2bbDcl2eMw/oDug2KXy7DXpxoj3j/ELZyREnj2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OgGTCG55YvOPWTv10ZYL1rlsdMkBoTqC++oSAaEM24udkUPWNCiDbuU7VL6c+9MAI
	 QPaVRCCgB8jUxTnx4TKI48manpOQIw6Io7ceVdK0gSKAcwVM30y4zoBJIyqeXxN892
	 7UUP15rvrgkppTcTE6P4XXNNZ0bPrMXYMwZ95uQgXF7cmFyzCqZN4Zs5WgcVcRJlkH
	 pLZaqyopNLhP3yyr1q5ChFD3pqpHwUo12+/53lGDoRMgGZzIw4brb/RKvFKtIwHXTP
	 4qmANx6GnOJ3j4S8LvrxipeOSgCII4lrwKqgpHdzTSIBXPDjI/SB0pvASfbIU79piR
	 +ETUbepX1F6ug==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 2C788162DFDB; Mon, 05 Oct 2026 14:37:49 +0100 (BST)
Date: Mon, 5 Oct 2026 15:37:49 +0200
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	KBuild Mailing List <linux-kbuild@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Nicolas Schier <nsc@kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the kbuild
 tree
Message-ID: <asOoLZf9UQkB6SS5@sirena.org.uk>
References: <asAzcgDsbNEFIfKV@sirena.co.uk>
 <20261002230632.GA314599@ax162>
 <asA6NZ4QKp4k4nGD@sirena.co.uk>
 <20261005133224.GA1108555@ax162>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tY37R1YkArQtSgOC"
Content-Disposition: inline
In-Reply-To: <20261005133224.GA1108555@ax162>
X-Cookie: Use the Force, Luke.


--tY37R1YkArQtSgOC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2026 at 03:32:24PM +0200, Nathan Chancellor wrote:

> Can you drop the fix up to scripts/Kconfig.toolchain that you added in

>   855c706f2179 ("Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git")

> ? I have temporarily handled this conflict in kbuild-for-next to make
> life easier for you in

Done.

--tY37R1YkArQtSgOC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrDqB8ACgkQJNaLcl1U
h9CQYwf7BGunrjlhW/LCODAWWgYBU3SQ2Wra97KybfNDt1LdxS81WGi7f/z9c6ve
PeJ2RDjulOyZ5WO2P5in5+/EPpKZdWJWfwvD+JT/QYu6AiF5r4xMsWmilraTqt8N
nzKA9EC+YR6YMw8IznGJjWfht/GiVKi+LZrLvHZKfryXx4w/7clxVU8c7wH5UgbY
AORwjh8PpxhWMB7DtnIaq9ToxsrmqabJuo+fTnWrvLlHd6l17VJWD+hPyvYoZK+E
WFLs1NrS1fAOrdOmoRVvNao+V/Pi7vt9yvmpOyZbzD/Sp9HoqfdCCG1UkFcDc3R6
sRx6sKX2e9T71iA3gu6WU/ihZ31NfA==
=Qv3N
-----END PGP SIGNATURE-----

--tY37R1YkArQtSgOC--
