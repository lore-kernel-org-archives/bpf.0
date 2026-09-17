Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597614C753C;
	Thu, 17 Sep 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641038; cv=none; b=X5cGq9fOrbrBvALrQibgSir2noBefL6tDj9jlAAI9QtpFIYRtgqApDp9MuiO6tQ4K9SuQZ0g0OzvT6O577dKNGtNvZjOHF0V0vYE45QzB58uP+wPRuzmIV5m//5W0TYMIgbdhlX6Gh4xIUeIAJhoJ9iXrOsq35G7+3RK/p9f2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641038; c=relaxed/simple;
	bh=h+PSZ07ElaAG4uKNSW/vf4ikRTNpBKrbzTc+pKVFaBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z0R84qXpnYJMBaKu4t5FRuIw6xkY0J6TBOCgsC7rAzN9z686VcsXBMwZmwACfx4Znd0CkQ3z/QdHgXV57u1h3gsFGgreStvTK1RivrDml9L570xJfEg2prXzuJFovlBdyWVq31NlLcmGve8seP6BXH41p+2SUQXLhhLI56H1APo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkLzcuhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkLzcuhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ACD1F00899;
	Thu, 17 Sep 2026 10:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789641025;
	bh=zhN6BBtSDK6hxpI9eloNR89Fq177Dh+jL9nZm6Y6ofA=;
	h=Date:From:To:Cc:Subject;
	b=IkLzcuhgK0/Q9UQfYNZwq3YCMvYygdhnRpOzw4ph3enkXFTR+AVtjRfDoVVeeUsiE
	 ak76t7uPKkNlyBJcoMibYfc/ogWjdww4SmfOuULRpCxgNPYSAAcuGTUbZhoKmWtNrN
	 5ffqqdQZNhD8W7uLrExspoqHIPr2Q5EZK0jeJvxYeiZZKnkTBAfj5TXyVkRBcVbGq1
	 tPFHY+1t6M0mZkx2KQ57u5+5bv1y0guMvWK1iDTctfEFOKSPc2HDPdLJ+2nhEtXqjF
	 Ao2EfejQBQOzjPGxnheNz67xnjWdhI+Y4BN2m7A2pU7bX4W6bVlva2qbQHmRHOnyZJ
	 WBTP/a1tVyL+Q==
Date: Thu, 17 Sep 2026 11:30:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Missing signoff in the bpf tree
Message-ID: <aqvBPVcN__UX8P85@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LrB2mtwSvA+Hmh+Y"
Content-Disposition: inline


--LrB2mtwSvA+Hmh+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commits

  4499609f99fd5 ("selftests/bpf: Test global subprog callback contexts")
  3506b9a2f1085 ("bpf: Verify global subprogs in each sleepability context")

are missing a Signed-off-by from their committers

--LrB2mtwSvA+Hmh+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqrwTwACgkQJNaLcl1U
h9A3wwf9Gm1KLu/zqi0kvP0jtvpYXbJRSpdZZoFf/QL/Wg6kgbn9aJ70YT2bxxA9
6wXIrIBufm0ojyqIuyct2ttsJ3kCajYTlbFJIvc8ZHd+uBpq/rctteYwRv/euo+U
y5kBdWhTk1xqALWZ8tnwHsM4WMUVF68ENat3BmnvDQTPA0j7lRujdGGCAG9b2O+O
hgYAaNZhPHuvGEwE1YAPpQEavxK51MIaZy6OYhUw6eIa/M1aGsRh7j/uTUbAHD13
RdOa4PMlBt7RLK+HXRg3N+KHk88kfyjJ0a7dr7KQS+VwywzBLF2ejK14EvoPj1/x
fCwz584wbDTHgnbiwhKPGKJ8gxao9Q==
=YEMO
-----END PGP SIGNATURE-----

--LrB2mtwSvA+Hmh+Y--
