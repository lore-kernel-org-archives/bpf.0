Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3D448D07;
	Wed, 15 Jul 2026 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145342; cv=none; b=PfSuojasJ6moohdJaA5R4brHZ7JKpyDAZorXusBNhyS27Unr5MieV/X2ckrCZ2FGi/qTcAkqOJOflTpeMW+TN4gH8XuHy2YuOzHTLra1wV8zQuD6MFkBIw/gjGPvtj6y1rVe7hc6K2Wx2T126wFaeT0CjSuAozfQn5WBwGjXFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145342; c=relaxed/simple;
	bh=bf3M7qsXxOCj54QXsTfVzp962EZ9CW8ixd4NFvp8KlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqsU6a96kkN+P0i+epUlW7W8Nbnzq56QlVzbHUegn0qkT1euJ6gV6q3yv9fh21fScMjcltDxuPMYrcu009vXfJ/qUIRslbcRjJQhwbdbCPFXMrlihacTkWgD00057bixv4CjqrQHi1QyWKV69kbT452YO0JBR4ezdZVd1r91mJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVg7LMq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVg7LMq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528EA1F00A3E;
	Wed, 15 Jul 2026 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784145340;
	bh=GwptbYX8KpQf9RM+RIR7cY+rOii/93/U699sbdy55oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PVg7LMq4jhrPzNJOPT94pXoP/jsHBV6xVcbj3ljXe5cpGKaGfo1NEbHCcyMPbr51N
	 DnY5g6iX8hLD8T4/zKR/JJuE0HX0ag+0jajfsCxwAn9y5t5cs1MkZqa95iFVDiQrSh
	 TelyBtV2Okt1HJysYORcmDzHHgmwnT12ewreHMv7cf2sITcI6NYtB9rYkaZu9iGK5h
	 k/lw1WWBh7Y/BmGZcOrjRAOFIX3+Z9hjkdvgr4crL9+VBDHzQpv6PYSBYeuw33mfFl
	 Mz878PHAYgqG3g/Jn8AlaROM+bPpYgoE3eoK59IntlXnjCJmPIQNszZ3YhoHossuBL
	 pM0y+AwOdSPqg==
Date: Wed, 15 Jul 2026 20:55:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Derek Barbosa <debarbos@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	Stephen Finucane <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>,
	Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <125f38a2-9239-4b8a-9cb8-04bb00409e12@sirena.org.uk>
References: <87wlv2jq4t.fsf@linux.dev>
 <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <20260715174153.GB3846105@ziepe.ca>
 <20260715191046.GL1778116@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="htwUcSo/8Gvpepxj"
Content-Disposition: inline
In-Reply-To: <20260715191046.GL1778116@killaraus.ideasonboard.com>
X-Cookie: "Speed is subsittute fo accurancy."


--htwUcSo/8Gvpepxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 10:10:46PM +0300, Laurent Pinchart wrote:
> On Wed, Jul 15, 2026 at 02:41:53PM -0300, Jason Gunthorpe wrote:

> > I feel Sashiko and this whole AI world has created alot more work. It
> > is not saving time at all. Now I have to go and read every Sashiko
> > report to see if there is something important that normal review
> > missed. I have fix all the drive by 'this is already broken' stuff it
> > finds. We get way more patches than we did before. Now *everything*
> > has to be looked at more skeptically if came from some AI slop. I get
> > crazy real security reports that need special hand holding now that we
> > never got before.

> I'd even go as far as questioning if the additional work is resulting in
> less time being spent on changes that would address classes of problems.
> There are many areas in the kernel where APIs are hard to use correctly.
> Improvements there (and I know there's ongoing work such as Kees' object
> allocator functions for instance) may pay off better than spending time
> discussing about one-time memory leaks in error paths of probe
> functions.

Yeah, that's been one of the big issues I've noticed with people
handling the LLM reviews poorly - people tend to end up with very
tactical approachs for issues that are not at all tactical.  Which is
one of the symptoms of the stuff the LLMs generate themselves.

--htwUcSo/8Gvpepxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpX5bUACgkQJNaLcl1U
h9D90Af9GE22O8gXkjue7mzzEgOHy5+T4MkNfTEfMn7fYpOfm93fxzvlE0uiBOJ8
F6YrKpMiKH/J+kM8naVyqvC+kGxjOqK2DqFdjnK9OJPXLIdXvJeErpDSqgnziS17
sGO21AxmguCnqjDxBApsM8fZ0+turXhM5fnTyBg4ItXvsTRRxCWkhjuo3hO33jaU
mHRjsjyX+LdJQx+SZMSNtVS6kwD1JhvQMF8pIi3gjVM243i1+N2IJt3sWOH9Q9uv
FmMLmdLuEv2mQ4vpipUN4MAzRBZatYgXg00LNx9hy3kbsP4LIoxG8vPWG9GFHuRV
c4sFG8fKDQcWyV7jAXvkTbkuZ0Savg==
=IFLh
-----END PGP SIGNATURE-----

--htwUcSo/8Gvpepxj--
