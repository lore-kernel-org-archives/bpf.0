Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCF4BE443;
	Fri,  2 Oct 2026 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982715; cv=none; b=n4oL/reo2VG6nfSvjmoKlMpPNMnWpFG6Sk2WmiQcv2e4pUwHHixc+oSVdEUIOTGgokRs2/Lc4+XPQKf8mLCPvgnu9QANybnqR/vVaS3S/YPAAC8WDl4pd5En0PAiQhKm4x9qV38H8z/q5qOtDCFXqFRpg+j3cFE+LVKmiE4LE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982715; c=relaxed/simple;
	bh=Qg1UBe7pY9qBC27d8UoP7JV+IBLSCT+tqgRgQ4ycH9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwn511qRlY7lSzrGOTS8tJmhYkxYEIeHLVR6hDFKnQ+8tsP7U7ecvyZq9IadjXZ2MTGuYivCtcEkIJ3rOVynCuarg5fBFXmnLPrM6p+wwF/2xAnLEc/V8qtQi+TTwrtRJqmUGBrTxh2JF8SvrEOY2D48d8g7J4q0BJOi8bYVsUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOYi8Acd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOYi8Acd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4FB1F000FF;
	Fri,  2 Oct 2026 23:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790982714;
	bh=wGJL9Dq3oS9dB0mFzdoCJmdQpea+lx2mM7lSgkaajm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZOYi8Acd3mm3RYq7Ae7+7ZG9TZVcqpNhVjBQfBe6lEqKmc8q5VHhdBid2IvkSaBtJ
	 0jgIh7hS0qQA/EftmD9fBEc5xNSFqHXFNETWPztJ6tcGKmTUEViEZCcwHdmbkOnQpl
	 EZRW/53plQ60QkkMlrvFcsVD5lVWf7bG+/EXdZLBabKNyz/CRKdpyD+ftW6uCr5jqa
	 Ex/gzuQgC7Xl6OrLw5XPnjJ3gWn/z3qIKXXr4wBB9YjTre2/g2SPTDxnZLNEgyYJd9
	 nXc8Th9ANhWAeNXNGrRp8zb43G7ntLe0YtyU+CVupmOW9T5xzFL9247NHcfmsK58ab
	 GxHfrxNsbR/7A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id B933B1AC57CE; Sat, 03 Oct 2026 00:11:49 +0100 (BST)
Date: Sat, 3 Oct 2026 01:11:49 +0200
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
Message-ID: <asA6NZ4QKp4k4nGD@sirena.co.uk>
References: <asAzcgDsbNEFIfKV@sirena.co.uk>
 <20261002230632.GA314599@ax162>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mdPHBtUdV1DkW8Cb"
Content-Disposition: inline
In-Reply-To: <20261002230632.GA314599@ax162>
X-Cookie: revolutionary, adj.:


--mdPHBtUdV1DkW8Cb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 03, 2026 at 01:06:32AM +0200, Nathan Chancellor wrote:
> On Sat, Oct 03, 2026 at 12:42:58AM +0200, Mark Brown wrote:

> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.

> Thanks, the 'source' line looks correct to me now. Did you also shuffle
> CC_OPT_INLINE_MEMSET into scripts/Kconfig.toolchain like below? You had
> it right in

>   https://lore.kernel.org/ar5-4Yq3wtmXTWnD@sirena.org.uk/

> but the patch changed slightly since that resolution ('4294967295' to
> '4294967294') due to a problem I reported

That will be delayed for today since the scripting has got confused by
me moving machines in the middle of running the merge but it has gone in
later in the merge so it should be there in the final tree, and
hopefully in the right place next time I run -next (due to LPC/MS it'll
be spotty at best this week, I and everyone likely to provide backup are
all in Prauge).

--mdPHBtUdV1DkW8Cb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCasA6NQAKCRAv73Ows9A4
icbrAQCi71c2N/fBwDD5SxPZ72da6XxIuVJSK56u4TV8G9zi2gD/Tp0Pe/83URQa
xX4/VcCmG6bwA/eNxu/ZfGrkCwS8dwk=
=DnDE
-----END PGP SIGNATURE-----

--mdPHBtUdV1DkW8Cb--
