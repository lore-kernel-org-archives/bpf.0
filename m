Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B093F3B2FC2;
	Wed, 15 Jul 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136911; cv=none; b=UlQ6Nht9KiIDjI+LzTYjMDI3BvXBgqmuGa3YzG2syFjcP6+vB4pMbrgqwBpcJUdc+okWK3Zp6e4gZjT1QJLCd0k4lJxUgZzunxBaTFTj9RCpd5d13A6Otj9YDRsPhZY4WD9WhKMz2qyxJ2KTNDKe9wuEo8+vxA9knlnM4Ubo8nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136911; c=relaxed/simple;
	bh=lkjj6NLGkNkR9yLVmWhe+umdaEFWMa1wjPGz7mMcg6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUV/ueavrn1zgCIGt8Q0NCeJnVS3m33dZVlMEm0WvDCTNKlA3ZgL5OXN1Ls8pgLiXeY+9/+dVInxCjqDFbrFFYRtxuAE8/ulcTLJKRFtaQ2/ois7pd6gs8ner1CXbg0WHZn42iQs0iuWAsYc5c5DbudUP/4kpzSceoxDmjRejlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiHKvk1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiHKvk1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F6B1F000E9;
	Wed, 15 Jul 2026 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784136910;
	bh=8+4Mqg1N4xM8NbGsSvTr6LjE/rA6Q16xH8T9ckYLA0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GiHKvk1EhRbdNxTqM3icbUmDeTyqAQIp0dihlfdRyTAOZ+DZxP1gLfcEN2qI98lJz
	 FTWYnIwuLXn1yKKAx6ZMBenj7t/jqFY3a6kwn3lir9MZ4gR1ucc9sAL1Hc8FI8rVUX
	 OcILuwGj4QB/DUKvDjyRUZqBk5eaOGx3lqI1sEykYlW5Q6MW04kRXEzeQ/IoTV7jTv
	 r8KENHhjj0aFgw310WKbx9kLeQEVKbNW5ZNjdt2UUeJQAEbhhYU7/O7kVEzi6PN441
	 3QtipHng8t7ZW4nGX+vMwwkUbZPVq4/gG+L6ciV4gptU59G2x8wyekE5TD4qbfx2e1
	 ieFt3k3g/gp4Q==
Date: Wed, 15 Jul 2026 18:35:04 +0100
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
Message-ID: <f690c44b-bb03-4085-a9f1-0321a3f33e30@sirena.org.uk>
References: <20260710083845.23c753ca@foz.lan>
 <87wlv2jq4t.fsf@linux.dev>
 <20260713095538.3d5e86f1@foz.lan>
 <20260713094120.GD1127719@killaraus.ideasonboard.com>
 <20260713220427.582b28bf@foz.lan>
 <7ia4mrvtrxjl.fsf@castle.c.googlers.com>
 <20260715005909.GF1656185@killaraus.ideasonboard.com>
 <00a244f8-5be6-4ee7-b5b1-e4cbdcd4fc77@linux.dev>
 <20260715163921.GH1778116@killaraus.ideasonboard.com>
 <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SkqSHoWz0v9r0LY1"
Content-Disposition: inline
In-Reply-To: <153db0fa-65ac-49de-9bf5-456c9639954c@linux.dev>
X-Cookie: "Speed is subsittute fo accurancy."


--SkqSHoWz0v9r0LY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2026 at 10:12:03AM -0700, Ihor Solodrai wrote:
> On 7/15/26 9:39 AM, Laurent Pinchart wrote:
> > On Wed, Jul 15, 2026 at 09:28:03AM -0700, Ihor Solodrai wrote:

> >> Yes, assessing whether AI report is "real" is work, but it's not
> >> reasonable to push this work on already overwhelmed maintainers. And
> >> if AI is wrong, again it's the job of the author to convince the
> >> maintainers it's wrong.

> > We disagree on this as well. This would force contributors to constantly
> > justify their value against a machine that is known to produce a
> > non-negligible quantity of nonsense.

> I know what you mean and I can relate. Going through walls of
> AI-generated paragraphs is not fun, to put it lightly.

> However it seems that you are suggesting to simply delegate this work
> to maintainers, and I very much disagree with that approach (even
> though I'm not a maintainer myself).

This is something that already happens with human written reviews,
indeed I have a canned reply for one particular reviewer telling
submitters it's OK to ignore them.  It goes in both directions - it can
be ignoring some issues or postponing them for later, or it can be
making sure that there's input from particular people.

> I think it makes much more sense for the author of the patch to do the
> triage, as they have the best context of the work, and they are
> usually the most invested in their patch being merged in.

It's not clear cut - untrustworthy tooling often causes problems, I'm
fairly sure I'm seeing issues that are the result of submitters getting
mislead by LLM reviews in a similar manner to some compiler warnings.

--SkqSHoWz0v9r0LY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpXxMgACgkQJNaLcl1U
h9D9BQf/bzZSvv9fLCV40VSQ8NjeQQkNzdJAa07FyGx9o4m/KOr46adUs3yy3j87
uFUTgyuB/phluHHQWxouoI7KvL7ZK7QtPq/Dz+jva27sWW2IhAfI1qD2ODZDnPLe
7LC1ptcRW5e4991sQjjcOXmGCdqqOQJ4P867yzD1lCY2RWFf4owvfjdyQxyZIrF+
YPwOpYxk5Fq1GG+ne9rGTp4n+Xr8AGOyk2Kprs3q2QU0HFmMTRkivQ9wihA2II3g
QqmGMeEaAvXlkNboxeegPleYTxkd6UKqCGAcTow7cKoa82ViAmtTaPobY4gquzfd
WP7tcKP8ZWDRHcZUeXA3czU3TxMkhw==
=RA1P
-----END PGP SIGNATURE-----

--SkqSHoWz0v9r0LY1--
