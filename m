Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F504E324B;
	Fri, 18 Sep 2026 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729564; cv=none; b=ERTJ5ZwUvaiPrSM1k3YWBu0F415vJC2Rgb8cq6RqonQhZakRNDbd+c4/rw7mf9CxybAqGUX7Hd8F2TKSWcqkQYzz/U/LJsqqjdkbjL/cc/G6fbnE0sBarG6kb5b91DCqMyltf9M1+Qb+25yUg9+EEGxbrG3BuCOVL3A9dy9JaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729564; c=relaxed/simple;
	bh=yrJslMal2Z5+2o1dl7cAtxOovi0457QWDYVbV0tPvXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aiC8CM6aOLK9X7Jg5gRdW/Mp/uGH6VjB7f9ITMoGI4NO8Cw9bPJWTFUaf5rXc/8nEROTW7rHZuaV0hrfjlurSleiHaFAWxZb3kwZH40pBa5aOg1JMZ1ndcMzocTPtGdPL5O184ewVSqQ6B5XOlW5XS+fsxr/22x83lIBXBEOVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXd9Z3W9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXd9Z3W9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048201F000FF;
	Fri, 18 Sep 2026 11:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789729553;
	bh=0uYmpYOpG2DxNOTbmuW4IIYbxixZMCV5CKHZgzmFC8I=;
	h=Date:From:To:Cc:Subject;
	b=AXd9Z3W9rZLco22SsfJeRB1lhe4SXkPP6eFQVTbSBxlWHt4/jPKnezHA13xCUcqGT
	 500pDekl3aNuIaeEUASbcBGCoWRfq13A+lb97k1n7vAVp+J6rG1SDjnLJWq4eXNuFW
	 26Obpd2EJssoXkxXD8SbHMOgLQ90GNI43n38PzawaPJLYSngAPvXEzXXY4qrIgxJiV
	 QUfo1/Up3Kx6hjhFIWNL6ekkh7drB+EZ8gnxqRaVWFj+BJnmbRPFZb+aa18+nBke7l
	 /GEbKTl/ePN1drKlGRAYvKsprrhZSNCkpGSc6zLuCSfUoIJ4wPV8kbpRlbejcCsxjk
	 XPguxnvm3ugnw==
Date: Fri, 18 Sep 2026 12:05:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Amery Hung <ameryhung@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <aq0bDIzGl-LblcLL@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8hLPkmWOiVcj4kmr"
Content-Disposition: inline


--8hLPkmWOiVcj4kmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/prog_tests/cb_refs.c

between commit:

  04ae4ffc57a6b ("selftests/bpf: Check callback map value lock identity")

=66rom the bpf tree and commits:

  ab7fff217fd14 ("bpf: Check helper and kfunc arguments in one path")
  5dc1549afac9c ("bpf: Consolidate release argument validation")
  750f3770809ac ("bpf: Consolidate nullable argument validation")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc tools/testing/selftests/bpf/prog_tests/cb_refs.c
index 490e15e7126d9,c32c6dab49bce..0000000000000
--- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
+++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
@@@ -11,9 -11,9 +11,9 @@@ struct=20
  	const char *prog_name;
  	const char *err_msg;
  } cb_refs_tests[] =3D {
- 	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects r=
eferenced PTR_TO_BTF_ID passed to R1" },
- 	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
+ 	{ "underflow_prog", "R1 type=3Dscalar expected=3Dptr_, trusted_ptr_, rcu=
_ptr_" },
+ 	{ "leak_prog", "Unreleased reference id=3D4 alloc_insn=3D3" }, /* alloc_=
insn=3D3{2,3} */
 -	{ "nested_cb", "Unreleased reference id=3D4 alloc_insn=3D2" }, /* alloc_=
insn=3D2{4,5} */
 +	{ "nested_cb", "Unreleased reference id=3D5 alloc_insn=3D2" }, /* alloc_=
insn=3D2{4,5} */
  	{ "non_cb_transfer_ref", "Unreleased reference id=3D4 alloc_insn=3D1" },=
 /* alloc_insn=3D1{1,2} */
  };
 =20

--8hLPkmWOiVcj4kmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqtGwsACgkQJNaLcl1U
h9C0awf9HuzsVsemRZFKDLZd5/naPyIntreoHR3j+vDnj3/RW909Y3HmaFXGSjSe
kUV8tIZDG8zqTLEUoapitlcuR3hgIdeqn9+R/Wh+lxDC17KE0L+ehVDuL63Q5JTu
6CVtv2+xYXx3iec+P1JNPfeiveV1aXh6ugvaZTl2o9DFoi+Mu7JdRPY/zoDuK0Bj
Hn4ZtU3pGZEkt5VDILlZAQYkDUamti/6b1+hzBDVXo+yZlZtrI7AyP3y43RpPMMl
G4WVlpbLBAhukY8gpX4Po/2Ufe83zQGmFgiH0M3Rg89GVYAsaQUaKYIIH87y2xGn
BAXdW69D4pJ9z4IuoazlzgpbCj8h1A==
=u948
-----END PGP SIGNATURE-----

--8hLPkmWOiVcj4kmr--
