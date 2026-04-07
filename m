Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49983B389F;
	Tue,  7 Apr 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563019; cv=none; b=CX3ei+t/KiNr5FOiA20SJGroXUHt3TUXWQJv6Fe2BziKSkpeXZ86apqRgRuT1DjbX4PTKtQWIhYKgFVETUnkFvsvh6UJUz6jSJ2nk+AtqE0KDgXZBKVVP3fztA2wrDMKOqdTyfBCyDFjKCb0C8umZtUgErHT4EeGH5GeXSS0HvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563019; c=relaxed/simple;
	bh=DjpTMGM5uO8hDs4UwV0YSkNNsFqc8N3+IFh3c+GCsA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qeW3cufQx+wVpdKhRugEF5Gxvscn5KAZiCpnMNcEQw7FrT1PfetR3UVBirP6o7YMKmFWrCXU0c082vsOFcsAw0uI6cpL9Y+izknvn0wr84IQoZPSciG2aawgreOzR1Bun1JyWer7BQA8ATdyRiJNzVqBGFQyfhFPdXcl2YMPPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwMX75Ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwMX75Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F8DC116C6;
	Tue,  7 Apr 2026 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775563019;
	bh=DjpTMGM5uO8hDs4UwV0YSkNNsFqc8N3+IFh3c+GCsA8=;
	h=Date:From:To:Cc:Subject:From;
	b=VwMX75EiQ8VP5x37sBDKUNK96v7LxQx89pf2ccNmoz6iIXkFNgFoHPkn9ydVWnSXw
	 LUxb71StkEF+Tts8qdTddBI08PsiSFP1VLHDRRES2/2kVdFTrt1Fmel7rga7aS75pR
	 ZMaEFHKOcZiBRgM8pAH8mpDHtPYkLjokbEfDsAic2o9kxNYLtutq+7xyLYZQlaZXSl
	 bAS2RjoKh3HNaZOZJRNAVjnykEcVGMD/LWy9o3mhJPfpaDwo533UbaSY1y9Euj4BX9
	 3HEdzqjlveQI8txJ1Q144fGfHqwrMphjnyG4utHSnapuqnWu8fh0gwUT/AIF/ORnhq
	 3KvVSVYZRs0WQ==
Date: Tue, 7 Apr 2026 12:56:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Abhishek Dubey <adubey@linux.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: linux-next: manual merge of the bpf-next tree with the powerpc tree
Message-ID: <adTxB7PjvXi5N4EB@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SbOp3luEpbBMMsdp"
Content-Disposition: inline


--SbOp3luEpbBMMsdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

between commit:

  66cad93ad325b ("selftest/bpf: Enable instruction array test for powerpc")

=66rom the powerpc tree and commit:

  99726ece0c8ad ("selftests/bpf: Enable test for instruction array on arm64=
")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 482d38b9c29e1,93166c2da8e7b..0000000000000
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@@ -3,7 -3,7 +3,7 @@@
  #include <bpf/bpf.h>
  #include <test_progs.h>
 =20
- #if defined(__x86_64__) || defined(__powerpc__)
 -#if defined(__x86_64__) || defined(__aarch64__)
++#if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__)
  static int map_create(__u32 map_type, __u32 max_entries)
  {
  	const char *map_name =3D "insn_array";

--SbOp3luEpbBMMsdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnU8QYACgkQJNaLcl1U
h9AFcgf/U/ypvZWPUaE38iCgcOr9D2sft431E5zVpFC9wMXs668d9GJOmE/1VuwO
XL253BucFVhgYDo82OVwDzdRqeRcuTF68dvwkZKT8VrAaqrZPv/yEAsY13rHOnnB
grhCgSmPIauCen0an6CPj9CS5s6+JMAOhMCvozwK/6HyAvHUffRnhteWW5LWkrlz
QdfxbvkiBOykKudK+mAPKkscBo3HIQJh94tYYdaU8B1BkmT1QwhZGzHUzBR4NM6F
naYv3V0cCgIRNJGzecDtAk1EiBZ9OQb+/C2rIAoefZBpnPC22Ri27E3rODwELTx1
sqG8OGsPFLCfMNteGrk49svTpH//OA==
=ELIP
-----END PGP SIGNATURE-----

--SbOp3luEpbBMMsdp--
