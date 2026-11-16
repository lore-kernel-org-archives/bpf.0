Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842537;
	b=mU7rQi8trTCAfDJ8cSSW+VakJtdGsW0AGqDLtcAbgI2nJo13Ej6hrAQ7l05QN5dAqi0v
	 p8a0A3guknEfQ8PJRqF7Q8B73ugN6uteMtvFMf+UTPwVAbVXMKSPahnjdJLhuYlS7LnIi
	 EItTlnKbu8akW3XxqGugrLRZ6+l8aTDFUhisqTY0TyvVIxCeh54z7DrbULF15oBbi1oqW
	 ouTRabWB/fbIVQS51gzfUNg79tzcV50wCG43kL4WSkD0JIQDPFKhp985T/oVSYC2heKvz
	 41WVTZbFVWgmSyTgQPPRXBvHssXpeTm8DOl8jgdLuiLBti/XD9cjTGeqU6H7zd834Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842537;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=184ZpBXRpLvzwSAALbovT+V+UH0/q/KWhPuda1sGnu4=;
	b=NMqi6vxTxRohrFTNj5rAB3qlLsHd4wjKDFKEbSrPkGzb0nK35s/KM6gdebPzwrFcLXqz
	 mHaxbuC4bQP8MgvmFl5tJTVLb6PZDbOUoKAjSc4v3nBd3r/GssAKfgd+IPKRCtlpJ2uRf
	 dXyXu06Xq2hF76G4poyWX84WhrI4BwWvTm7TyaCKQjgHkd9xIQL+e4bLallkD8ml8NGsu
	 aTadDwmWhFR5IPKA7PjHPoeXPN3OS5F6WsKXm9mBmo3a2xsHOwtpPzz0Ae43l+dnrhVjO
	 mr9GFxt6oF3lL7V/ArdlEjF5RkOYYl70YOFVzZ0OVvSOcd2WQj+602x/+4CGO1BIK0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1aFJHj+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6123E606A31C;
	Mon, 16 Nov 2026 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1aFJHj+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE2B1F000C5;
	Mon, 16 Nov 2026 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842537;
	bh=184ZpBXRpLvzwSAALbovT+V+UH0/q/KWhPuda1sGnu4=;
	h=Date:From:To:Cc:Subject;
	b=a1aFJHj+evmJR5mWe6zc/eqCXyN2rLv+BqVYTSAhoklFPFRJUgnmKBQNx2ZrqYIfi
	 yj+YTU9LN1eiJtly9xRNDVpZeg6jr4UuIYNGNa0WpPhePAtOb6wAZi15DWrsRlL/7E
	 pFFP6KTjA5vQbn1VLW0M4xH0LEhuvMtbtAqgsSS/eC2U8yRBCYaMIcpSaHbfthGUY6
	 rNzl+Gj2PgAJdTng4TUVJd6PcpCuWIsGurc1AUzuzW5QcA+W5Wvh8KCSIsptuB6Jn1
	 U9GWMLssaaNY7WmPE7irpjn077Frhe+EtZSKQNzge23PMtVIKxKR0m1Q6nnJzUORm1
	 RJ6mW+iJpk+Kg==
Date: Mon, 16 Nov 2026 15:22:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Sergei Nizovtsev <snizovtsev@cloudlinux.com>
Subject: linux-next: manual merge of the bpf tree with the origin tree
Message-ID: <avsfpHqbu_rdmOrf@sirena.org.uk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvrkY8uIEiwoI8vX"
Content-Disposition: inline


--fvrkY8uIEiwoI8vX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf tree got a conflict in:

  kernel/bpf/bpf_lsm.c

between commit:

  ea8c4b37b8809 ("bpf: don't mark namespace_init and namespace_free argumen=
ts as trusted")

=66rom the origin tree and commit:

  ab86b62012b9e ("bpf, lsm: Mark backing_file_alloc/free LSM hooks as untru=
sted")

=66rom the bpf tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/bpf_lsm.c
index 468e63dbd922d,f39a3766f2245..0000000000000
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@@ -411,8 -411,8 +411,10 @@@ BTF_ID(func, bpf_lsm_bpf_map_free
  BTF_ID(func, bpf_lsm_bpf_prog_free)
  BTF_ID(func, bpf_lsm_file_alloc_security)
  BTF_ID(func, bpf_lsm_file_free_security)
 +BTF_ID(func, bpf_lsm_namespace_init)
 +BTF_ID(func, bpf_lsm_namespace_free)
+ BTF_ID(func, bpf_lsm_backing_file_alloc)
+ BTF_ID(func, bpf_lsm_backing_file_free)
  #ifdef CONFIG_SECURITY_NETWORK
  BTF_ID(func, bpf_lsm_sk_alloc_security)
  BTF_ID(func, bpf_lsm_sk_free_security)

--fvrkY8uIEiwoI8vX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr7H6MACgkQJNaLcl1U
h9ArJwf/eJ7v7poUUl6J4nNn9ZaW7mYmlyQgaI/TcpTK1dKXNNV62yXgBEVDCQ9C
BzIB0VFocK7OwmWM1lSxF5vi3847m6l9QPrpjSgV1hUVtA4VX7S0lnwsDc62LF93
/wpb/iNbJ1+CjlVxD6i33j6vEd8rjG8JGfDp7DinSYOmDT7XRzPMinL9yVa/jRAS
xcJPnchoAVOM3mj7dejmRuSqxvRVc4WzAAztR2lBcIuExxhkszDHWS5tGVJfHfL3
iGRPzZ36ehECqGrHjAbxR4yy2FKVCywRQrKnZHE+EFAxBJ9x9CNWU1YUk1iKSyob
d4Ogb58Sr3nVc4O6FzdlRh3NXb8keg==
=Mgdt
-----END PGP SIGNATURE-----

--fvrkY8uIEiwoI8vX--
