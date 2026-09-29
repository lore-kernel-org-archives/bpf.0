Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B12E8DEB;
	Tue, 29 Sep 2026 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693834; cv=none; b=oNxObKVs6MWgKVs/qkKdUou3Vu6+gUouxunEiEolaKBOv4D4m9AHHA1DaBIopgVKwA5154PxntBeRfZemhFrVnhakDNImGKk1sS0PwJyqJ5a08mI2kUSmReEjN1A5e+hxAiFmzrfJEnFVohECUwD2C/O7S3T1X3B9sB4Cxi0ctE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693834; c=relaxed/simple;
	bh=Mb/eWLB1hzxMamN2EaZvoHO/5kRqgqUoNzTGvIBJ/bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hhru/E7RQRM+OVBwkjtJuzaFU+ZCMipwYOslOCXkKjXrjSXFJmZDDnATqYZiGpJVWWCY6QQePdJvvYv82r6n/8xCCmvZFXTdG6bNR2sh+Rid2QM4LxtVRyDuge04fDX6CaBJJiVYju3/CG86vXATw4VwJgsfNfkrQ4/nqMtiE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrJ2DxZa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrJ2DxZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056A31F00893;
	Tue, 29 Sep 2026 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790693816;
	bh=VfFU+43eV00HgURhccuIVtc5YQSWyFjP5EWQQctgOTI=;
	h=Date:From:To:Cc:Subject;
	b=hrJ2DxZaJAAh4OGyaSKX2PVX7ZrIpdRRMIzh/fIS05+3d5m84PwzDwkkLENiUJxFS
	 xrGa1/vdLTmRqFsbAHLgeb4Fu/Ye5IC22Uq2elxOEzpn3N2IabB1+4JGzIkq64CVUZ
	 jK//7eYpjijnp/PwOu7hdLEyqWUmK5NhOOeBskyqTgqkkRo7Z9AI/9F/JC7pd2bE9/
	 Oh6wEeHzD/cOIzvS43aWGPdg2xStSzl7PDiE7EGpt98zt6y8VeUhfZDVO5GXk9tqXY
	 4z1u2zQvDu/YrpFZ9AFyFV+4Fjo9otqXJkiPqIYkcJOUBrit/8E5C0GBztncs8vL4X
	 8u90VA7KTsAsA==
Date: Tue, 29 Sep 2026 15:56:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Florent Revest <florent.revest@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <arvRs4KdojDnW1O6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U28t0JN67+uLvANc"
Content-Disposition: inline


--U28t0JN67+uLvANc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  arch/x86/net/bpf_jit_comp.c

between commit:

  17637e1a581a2 ("bpf: Skip detached progs in trampoline images that are st=
ill in use")

=66rom the bpf tree and commit:

  29fcf9ce4bbdf ("bpf, x86: Use global buffer for trampoline size generatio=
n")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/x86/net/bpf_jit_comp.c
index 6bca87457e872,6c7a0578760e7..0000000000000
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@@ -3817,25 -4152,15 +4158,15 @@@ out
  int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
  			     struct bpf_tramp_nodes *tnodes, void *func_addr)
  {
 -	struct bpf_tramp_image im;
 +	struct bpf_tramp_image im =3D {};
- 	void *image;
- 	int ret;
 =20
- 	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
- 	 *
- 	 * We cannot use kvmalloc here, because we need image to be in
- 	 * module memory range.
- 	 * Since it must be writable use execmem_alloc(EXECMEM_MODULE_DATA)
- 	 * that returns writable memory in the module address space.
- 	 */
- 	image =3D execmem_alloc(EXECMEM_MODULE_DATA, PAGE_SIZE);
- 	if (!image)
+ 	if (!trampoline_size_image)
  		return -ENOMEM;
 =20
- 	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, ima=
ge,
- 					    m, flags, tnodes, func_addr);
- 	execmem_free(image);
- 	return ret;
+ 	return __arch_prepare_bpf_trampoline(&im, trampoline_size_image,
+ 					     trampoline_size_image + PAGE_SIZE,
+ 					     trampoline_size_image, m, flags,
+ 					     tnodes, func_addr);
  }
 =20
  static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *=
image, u8 *buf)

--U28t0JN67+uLvANc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq70bIACgkQJNaLcl1U
h9CIeAf/aTtse9gSc8Y06UHaIxa3EIIm1SYMyj0BImtt6DeoA592sdNNjPXKbgit
DGg9Bas77yScTZ2GJv0eo/gTKOPrHzWj3nmmZC1xjJKEkmc332Z25TlzB1FTrvQn
3V0eb4zInVbXJZQYFZ8HVtcjAMsneCFT/tIoyujTn20gouvZR13YWBcCyA/e5z1z
l1YwuhBcOsZJdc4CjExcqc5PULNEOy+7fgFqhoQT8gtC5wjo+s3GsxLWj0f/55Z0
sdTlwXiT/K6KBA3zE8cQNdIy9zHQUz4VKY4pj+MZ+M9Ma3xo/C0zPH6wQ7I/Vz3p
xxo/0uS8kEDtEa0A2FMu0Y5b66Xrig==
=pacq
-----END PGP SIGNATURE-----

--U28t0JN67+uLvANc--
