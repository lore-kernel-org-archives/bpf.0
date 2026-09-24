Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586923F1AD5;
	Thu, 24 Sep 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253583; cv=none; b=UNY9t79T1W9kb7N4WuusCXjGv7/3PP6URpjyAe9UjnSGvOaj05EcX6pzTimda4YqShJBvRCI5cSqspwW1ER9rhOvDoRxJ1NeMFJ0u/th1oUMi9iZ84yd6GsZQZ/j4DlsHyq4xcRvF+OK7FDYABONXGjxxRLfk2z1QPzdB70Dh7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253583; c=relaxed/simple;
	bh=cnExcQWXcl8PtXzuGi64NnpcpmbnmatuREqpexHy5Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JaHtuwVLD44Kn2tR/l+y9eLkKTIvkaBkuM86kcJlWuiB5AhcC+n7q6mTIm2SciRcvmudJquj8Pu6UhjteuD/n+9Sg2OZDdIrgZHWTaQWW+NeWClmfXgrL0pDw7xSTIxB4JZ2dfi6zhUY7YPggu6N/YlrAMGQYk0+xY1NnvZBDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pc2pxKHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc2pxKHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42D01F000FF;
	Thu, 24 Sep 2026 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790253571;
	bh=NWV63fbaJvOqGNz/oJFAY0kcJbTAepBIBYHStlfPyLw=;
	h=Date:From:To:Cc:Subject;
	b=Pc2pxKHIZrDt06ehZWlEtSlkgo6KqDAoVR+KEx5s9wn8Sbomp8FVTaSLfalW4GJgt
	 b/NwgDIEtugWlT5vsDgTJRYJYRRIKcTh0Pm+DmTiFqZW/QiC/q9qE5WVrdAJSgcUZG
	 MHnL/iUqJVaLsQyRKNRLquYxU41ic8Bbj3IiSp3JqZfN3F0kLLQfU29ACfiCdBGeeu
	 ppFH+XPflbhwf2+uFTpjVxLg5K9HSJLBRTE3xMERDJYE/zcSa+my6DUUdT6YiSSbTy
	 vx7W0DBWl2izEuith895Udrsdsn7WhRzhMmvBfsfE+HGtIPvy9y2NcRb9JM9Y/THh8
	 AidwnzFHjKFKQ==
Date: Thu, 24 Sep 2026 13:39:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <arUZ_0CU-Zlct_Tt@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3vVy6u0p7esVuByA"
Content-Disposition: inline


--3vVy6u0p7esVuByA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/prog_tests/cb_refs.c

between commit:

  04ae4ffc57a6b ("selftests/bpf: Check callback map value lock identity")

=66rom the bpf tree and commit:

  11300f54bd887 ("selftests/bpf: Refactor cb_refs selftests")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

(deleted the file, which probably lost the test)

--3vVy6u0p7esVuByA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1Gf4ACgkQJNaLcl1U
h9D8PAf/avM/0V8V3Hr3cNMhZaTjbagIkMivmZJiSQ/LChwAwlNGnvZBLXCVRfRa
2AVvM0q8/DYn61oY2LNnjm6WAXtj9QmSlBHau7e5/LoJO0mlb5g1a6z8PCMwLHbn
xCCecqfOJlpLAtBpcQpqOvQR/fmwCq/y3bpB4XctU3CXYCM+FyNsdxusfBsy0+su
td78ToW9Vkmi7OplweEHpMNgwwc/0Jz9KnOq6xP3sqQM1/YzP4TGB8FftHB8Zw+X
lIIV/6R6TYMmzVhedbpyAT2yT8Eosu5ov2l11UTW4BEao9CG7hmWJVcfnTuRKNGq
lpBw4i/Q4CzaJ/UYGGuK26FuzytDHg==
=yIqI
-----END PGP SIGNATURE-----

--3vVy6u0p7esVuByA--
