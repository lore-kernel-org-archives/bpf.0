Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC01607A4;
	Tue,  2 Jun 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416980; cv=none; b=G7GDohFOm3mOA0gJy3mGR8gmAFhijJ6DFawZe0zIRgHiHdn0yRq5z/r5rpS4dw1CiJ7rN7gCBeLkvaTb8gJf/HhKKujm3VJkeponX+vDjuHE5kajkMpFfKU7KXV4GHwu9vYzlGxcy6li1PD3H2crLm1GZfbz4jrk+E1UIAM8iMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416980; c=relaxed/simple;
	bh=Zu28aI7QA8c6XLewqF5HcvoYkMd8dDjd+V7RmT4+WNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tl240QuVf7+qXqzVH/Bwm2HfAJuqjrfti9mXinPv2WN6CK/2gkAGWYyxbZTE7YzdNOtk2iO1SEK31mjTxTOZdrByJbP5n8kSNZnYzInq+WdaOjfRBGW7ktyoNxmhIej05xOSpLAnDW2m0TuncetjZVGGBJ4HBfv9/BDtSKXodoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFeZQ/L3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFeZQ/L3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C55C1F00893;
	Tue,  2 Jun 2026 16:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780416979;
	bh=vXrLIao4808epUWzIw/fCI05aS9DvD4NHtE5cmik49M=;
	h=Date:From:To:Cc:Subject;
	b=IFeZQ/L3KL17o+bKvxJYpDBU8c9PZxSpaJRfybIkSsWWPbPe2yTk1F0oGzrVRBWPI
	 Q5bLeeX8ZwVpmlStiiRtCQQg8MDNkxxJ98ipo4Ec+t345wIDzfKkqJWTBQx113A9oL
	 tH+86RKX6Ws+iqoJodqaFijt9/JBkqYmTCmbpLdM+chdo1cGs+3pj5ecce5TiPgYfF
	 fhpGF3eoLmcqe0VQlmjWjWo5PF+O7XyTP8wnPOzrrJY2DDEA3oqBnVULw77ZaIRVl4
	 m1ApSsI+8aWRlCQCUEmD4WniCQ6vbYsH562Hb1/KNTOnxV8KeAPK+Fjnkk1sQvnokh
	 v4hsLyI3ggwsg==
Date: Tue, 2 Jun 2026 17:16:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the security tree
Message-ID: <ah8BzqSmZO40xYhS@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cHRHOxUMa9VnXSEq"
Content-Disposition: inline


--cHRHOxUMa9VnXSEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the security tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/security/hornet/hornet_lsm.c:212:36: error: too many argume=
nts to function call, expected 1, have 3
  212 |                         if (map->ops->map_get_hash(map, SHA256_DIGE=
ST_SIZE, hash))
      |                             ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~~~~~~~=
~~~~~~~~~~~~~
/tmp/next/build/include/crypto/sha2.h:14:33: note: expanded from macro 'SHA=
256_DIGEST_SIZE'
   14 | #define SHA256_DIGEST_SIZE      32
      |                                 ^


Caused by commit

  c62310df81899 (lsm: introduce the Hornet LSM)

interacting with

  c48c3a7e7d5be (bpf: Drop redundant hash_buf from map_get_hash operation)

=66rom the bpf-next tree.  I have reverted the latter commit, the new LSM
means that the assumption in the changelog that there is only one caller
isn't true and it seems like the most straightforward approach.

--cHRHOxUMa9VnXSEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmofAc0ACgkQJNaLcl1U
h9DM0Af/Vew4ezfteietydbHLqu5EfXmd+RzY2AvXvF7+Ngy8LvzxU07GbFvw8DC
08nQHq968QL+uaxkYqXr7qYBlUJpyTGZ+5tI1T+hVPndNwTaeJV1RLf/CSV1QVcH
xB/uBey64RAewTIiMXYGcON0gkmW7ewjS3msjycJkHweBh+x6WedNPgodYChCp0C
hhmK8yzRAkpTx0CwMucfzYAvFf1psIAVaN9Oa3zDCA9cn6Sd73EezJ18ANVweUbb
zXRGf059fEuas/JxNSiI/+Bm5AtVIGeslbKMrlIhAtRs6CcSNWNDfgbTwqAnByaI
GxP3sAufey09/HIBqe3ityIpEKjE8Q==
=9gGU
-----END PGP SIGNATURE-----

--cHRHOxUMa9VnXSEq--
