Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CA3CB91E;
	Wed, 15 Jul 2026 20:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784147542; cv=none; b=nb6x95Rk0v8rNNaAnpDF5uj+nj6KNdMdVmn763pDqy9vhDuz6F0guN1MfPQsAIH7vcA6Xk6eEI5h7E2poQK8gCYwADtljUSrzN8Q49XByL7OJgP8GRHAALC7jraz2sU4BWDHCYdAHnS/wsAxEeuExAnacHCRZ1B99/oScXt3+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784147542; c=relaxed/simple;
	bh=cnHpsTUiHTDqWI7/AqTx+APZ17YU6PDQiXtFGPx7VRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMa7sFks3KMIp1aXggs2w5qnE6PTj3DBxnuRUGdDYqI0e5UxfT7SPgwRutODDUUf3XTAhuUdx4tda5pi1xf9vBYspo5oXeVUctR7H9JkSME051NNiG4xjtKO643i+0VGnIv32I9j8NUzmfiDZWDKDoQKX/wBHKiY+qXLd0jV2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI+V16gT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI+V16gT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892631F00ACF;
	Wed, 15 Jul 2026 20:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784147540;
	bh=s9WceP14hrbFBd0TV4fMurFRNynb7F4OB5T6Cda6+NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kI+V16gTa4Ld3ydhhsukuNq+RHPJMNlC9y0CYEeHn4Cw0MZdgbN25jY9c9sOS2YOe
	 9ANRaN57ljpPpmMJZR3fD3ezRoOijcg8gK0MEBhbjh6vfSrQoVSmToPQNYi14Jupps
	 of8ub2LRLD/CKWDiETvS7/VoXn7cXJXsgmoeRgAqaq18Va9WC3McTXpxUR5oqGhlD1
	 T3mFToQEiap0sp2vhvLgewbxY2Ez8YFs9e9Z42is6nM0336dd7upiY1d0l/wy3wolR
	 Z25n8PrLlvlxrnrsfpYLBv6f6JP0MsbkkKzocMzZDvWv0bIgHjGW6+UsiyhgveW5s7
	 M2lygSPyGvRJw==
Date: Wed, 15 Jul 2026 21:32:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Derek Barbosa <debarbos@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	Stephen Finucane <stephenfin@redhat.com>, bpf <bpf@vger.kernel.org>,
	Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Linking Patchwork with Sashiko?
Message-ID: <e03b97a6-c30c-4c12-ad77-9e5c663b1329@sirena.org.uk>
References: <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
 <f690c44b-bb03-4085-a9f1-0321a3f33e30@sirena.org.uk>
 <6a0f487f-540b-4d47-be4c-db6a0799d2d7@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tr85jkGtzsLOQ/hM"
Content-Disposition: inline
In-Reply-To: <6a0f487f-540b-4d47-be4c-db6a0799d2d7@linux.dev>
X-Cookie: "Speed is subsittute fo accurancy."


--Tr85jkGtzsLOQ/hM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 11:39:41AM -0700, Ihor Solodrai wrote:
> On 7/15/26 10:35 AM, Mark Brown wrote:
> > On Wed, Jul 15, 2026 at 10:12:03AM -0700, Ihor Solodrai wrote:

> >> However it seems that you are suggesting to simply delegate this work
> >> to maintainers, and I very much disagree with that approach (even
> >> though I'm not a maintainer myself).

> > This is something that already happens with human written reviews,
> > indeed I have a canned reply for one particular reviewer telling
> > submitters it's OK to ignore them.  It goes in both directions - it can
> > be ignoring some issues or postponing them for later, or it can be
> > making sure that there's input from particular people.

> My objection is to a suggested expectation for every review to be
> triaged by maintainers/reviewers *before* it's sent or the author
> engages with it.

> I think the author should be the first one to engage, it's a feedback
> on their patch after all. And of course reviewers/maintainers are free
> to jump in whenever they can and feel it's necessary, and they do. Opt-in.

OTOH I don't really want to have to not only look at whatever random
tool is sending reports but also have to check replies from submitters
for routine stuff, I already have a perfectly adequate supply of email.
What I'm seeing is more at the level where I'm likely to want to provide
some additional feedback to people, or where there's a lot of false
reports to ignore.  If people look themselves and take appropriate
action then great, but it's not at the level of the build test bots.

--Tr85jkGtzsLOQ/hM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpX7k4ACgkQJNaLcl1U
h9AInQf/cJTDCsp43Jz8xDcECVTZK2OWf2kF+4e5BZY+++RH7KlqjpVhWYVZ22ZK
VSg0MkA+zNqUJB9BYgbHa1IJXieg4nChS+S0JsT4dIXcADSqBUcU7S5rRrYFpdSE
7LRE6XZUCCTNb7PnFr9FdyYGmZRYbRId5yigNFIclDQpZdWSFWh7Nvw9WXGh5HHD
drcEWoJZ+qlDMsUu+pRHU4WTRrh26Sp53F2256aj59NVVkoMZ9pGqMiHMJFOFN9s
tpV00izqudWxZfWlzQOJhQtVgZ30ijptfDe767rgOWjBVJXxzOwV5LJzFTZJ5GEW
SFLUqVxKaCtuaceMnoBaVvkzBNgB4g==
=Td4z
-----END PGP SIGNATURE-----

--Tr85jkGtzsLOQ/hM--
