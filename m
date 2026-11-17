Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951567;
	b=cx6F8JhFgKYYJWFOtaWBlS+dqjLOxX/INl8ZwzNMwCWxJNxQ+dcsFf+DgB8+kLZxzdKV
	 TtPRoeKWpXVEHRPi1EknR5BOs93H/RKqKz/aTJlzgrsIXFKCJYP+RZ7ProkqhmNSDMVJM
	 xolc31j7/ne7cP1oCjZUHB0iFME3iJnYPGNn3HCXmkD1aIkCw70ufP9AfVpKtjYqwVobO
	 q6m9xFiVM2iGiGL4aNiSMVn6C1S8He3A+VBMa9HU5oJyTiOI84NElLzVQdiVHn8HhMpNm
	 RiDr9FTwf0HYiDAn3ZfYTn9WCCGd4ui3jdUv8bgJqdErQiQ3mlc5UXnovvIHQYvFqaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951567;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=oScinXla8iFhsV7Z44c+jwWiVoqHGFAC1o8kLT6Z9DQ=;
	b=ssltPbeU091a+O9QfKy4sWYjV2J286YpWAqpQ1J/XDcSMn90AoAF/Uw7pgh0TRisFga9
	 RJuISefhrPbAPBlS/ajrCRzhUh/HHADkUTEYQXZYCeQeeFHSvwV+KJyUMZtQ1DL63DAtg
	 xZSzp/al8U5IAHuPanGDmmSXKDEC/rdWb8aN7gPkAZ9DUHJbfxU3ieMayqLtsYOqhPnag
	 gt8CYlNZqfSEuz4/qA3HlNMPI7e7Ix/eelct2w+B2JL6Ta1CSYKj8wId1ibgKifXKgArn
	 5FxEGC+eKsllVY0sglc58ufENhpV/y3DreqPxaUR5F1J7A4ts9DdI0bTedVHq3ZYmMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJRHO5RE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DF606A31C;
	Tue, 17 Nov 2026 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJRHO5RE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D09D1F000C4;
	Tue, 17 Nov 2026 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794951567;
	bh=oScinXla8iFhsV7Z44c+jwWiVoqHGFAC1o8kLT6Z9DQ=;
	h=Date:From:To:Cc:Subject;
	b=hJRHO5REEBASSbi2j2HIfhVqEMtI55YM9h6JuU4VcBBJYvZ/KsQei5uDiR+tkdrSG
	 EWNRvw1gnOcKAkk05qNAGSCODBo8EVK1NVKWM+YgxR8WIhsqnSiKYp+B7DqotoemHe
	 nQvHZ9iIepFsSquSirZGTk1XooLe0K6ypIEfXUrWZ7MNUerX6O9cmnBwTwHpvAgaCa
	 5/tcMM7tiQyljOuRJMKa5PYXVKvuHNTl+/wywGxnDIzzGIpjcmbqUPgLaATcB1VjGY
	 kX+XyYGonvEHwG0tYJleeDod1MrJgM8/fiqHYuITnjVld/JZegsbFfyMphh2v4UGgv
	 sgz1Lbelkz3BQ==
Date: Tue, 17 Nov 2026 21:39:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <avzJivvibrEmtax3@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="xWHNQ/XToCorKOAZ"
Content-Disposition: inline


--xWHNQ/XToCorKOAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/verifier.c

between commit:

  7f1e33230b7c7 ("bpf: Report RCU-tasks quiescent states in do_check()")

=66rom the bpf tree and commit:

  8fd58560b71e9 ("bpf: Verify static subprogs on their own")

and it appears some other commit that removes the reset of current
history that I didn't spot from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/verifier.c
index 9b228ffbe3fe9,1a8e5a108a681..0000000000000
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@@ -20626,13 -21560,14 +21562,16 @@@ static int do_check_block(struct bpf_=
ve
  		struct bpf_insn_aux_data *insn_aux;
  		int err;
 =20
- 		if (signal_pending(current))
- 			return -EAGAIN;
+ 		if (bpf_must_abort())
+ 			return -EINTR;
 =20
 +		cond_resched_tasks_rcu_qs();
 +
- 		/* reset current history entry on each new instruction */
- 		env->cur_hist_ent =3D NULL;
+ 		/* no insn makes as many ids as there are from here to BPF_INHERITED_ID=
 */
+ 		if (env->id_gen >=3D BPF_MAX_ID) {
+ 			verbose(env, "too many ids\n");
+ 			return -E2BIG;
+ 		}
 =20
  		env->prev_insn_idx =3D prev_insn_idx;
  		if (env->insn_idx >=3D insn_cnt) {

--xWHNQ/XToCorKOAZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr8yYkACgkQJNaLcl1U
h9BeXwf+KWfYD7XbfMeu1qZsmE2dJOavMRKPtgoztl6WC1kVloG57PWaLojmVVm4
RQCZZ+/Q/UEadYCy6UJiJJBXgEn6NLCZPeiX7JdCZclFEHkGXKvRO630iS0Q2dRg
LvnjHXblTQilduMgEGvUePNAu8nfOLXR0MKU1Cns7HOw+9W4Jkjrpnv5t9D7xIXr
K8ckvau4YztGxSeCTKgs40vdY9xyAaMa4/zNyLY0yb5kx5InQmsGyF0pijJ6K11m
/OPuYV5QHO0NGGefsJ0bTL1jKtBoCg9zzRQaGtBkHJhbmSFCX7OmqjXMC5Ls9dGy
OX6tpVnJ0Ll/7YCA8u8ZLhM6Crp6KA==
=S2f+
-----END PGP SIGNATURE-----

--xWHNQ/XToCorKOAZ--
