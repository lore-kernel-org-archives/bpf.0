Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793833F8A3;
	Thu,  4 Jun 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577973; cv=none; b=dXl7bzIobFWLzyFryOH0XX8Aihf/pz9m+42JPizhRaJKQC8dANoP1vwo6JZADr6qWTS0R4GSeCBq7GduH88zrvZhfqFR4lNdQGne8aAi9Gq9n7a57O7hQCKYS5aYV5LvyEgZ3osvGzjvNNVuIiY+1q9N73pEGSx+eKmkiMJfvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577973; c=relaxed/simple;
	bh=EgMRvBu5YzRiwRNtwLh6fB99d7xpTCuSwobg5a4x1T0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KZnJJP9FIlIGhKhwfOT/CVLZ3JSQZ4H9/eTNwOCq+yrVZ/RH3S2duUb7ws88d+FDbSIP+zkImwN3qTGy6uWHmkZxttrPQqKzkwzE54sSvvXVVfwsn0ekV3f+tft5cPyVGkxUfa+L5rNsIQiXE5aH95dvdkQAdOhUQA79LytWrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO/WIFOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO/WIFOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C981F00893;
	Thu,  4 Jun 2026 12:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780577970;
	bh=obLgFgbfsTgxgYKjwNEFpJIxnlo2UXx+ip5/KtopYow=;
	h=Date:From:To:Cc:Subject;
	b=iO/WIFOF/9oAhcI20MLOKf3IawGhKBDhswAFykHuGex8EWzlJR7N+dWzbyXjC6ZNC
	 YO2RUUwJr5srOliac/s+94K0XmJIX9wBRO9M2f5LiV04S2S1cAqKw3TTMLEWUHZ5up
	 uJ8CNns26YPbpHHTqxvfYOocBFMnciQu2Yqkr9JigFKV6q6ZppjNuXMwJ853n+cDMy
	 XFfdzb/lEZ4vQ6Jyw1LS+602CyhvhIv02K3Oklatvj+sBHlNqxdky1t2Ma4o5ZxcNf
	 dde52kYOrkExUnFmfkEeC+o4YpZ18j9dq6k++A9EPeFK75tXFzhBW4oVfCE4l0GkJa
	 KAKktEvJSwBng==
Date: Thu, 4 Jun 2026 13:59:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the vfs-brauner
 tree
Message-ID: <aiF2rsdpUb5LuhmZ@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DM+wrrA3zhYr83Bt"
Content-Disposition: inline


--DM+wrrA3zhYr83Bt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/inode.c

between commit:

  a146500e11445 ("bpf: Add simple xattr support to bpffs")

=66rom the vfs-brauner tree and commit:

  b93c55b4932dd ("bpf: fix UAF by restoring RCU-delayed inode freeing in bp=
ffs")

=66rom the bpf-next tree.

This merge resolution definitely needs a double check.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/inode.c
index c3f79b5a2f8c0,188c774a469ca..0000000000000
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@@ -842,9 -768,12 +842,13 @@@ static void bpf_destroy_inode(struct in
 =20
  	if (!bpf_inode_type(inode, &type))
  		bpf_any_put(inode->i_private, type);
 +	simple_xattrs_free(&opts->xa_cache, &bi->xattrs, NULL);
  }
 =20
+ /*
+  * Called after RCU grace period - safe to free inode and anything
+  *  that might be accessed by RCU pathwalk (inode fields, i_link).
+  */
  static void bpf_free_inode(struct inode *inode)
  {
  	if (S_ISLNK(inode->i_mode))

--DM+wrrA3zhYr83Bt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmohdq0ACgkQJNaLcl1U
h9C/xwf+Ou85YMQWM49bpHCIPdrcn1qpCkDTO7jthITlYfCXD5EYFKzsZmuvrHD0
f1f9+vwESZUIqg0M+V+xofKyFp7tkslGhZhWaf82PQjNGjnePVTAwGDfkh05JIaf
Pokq/B3I2v55oopFLxMcsMwjlWoclWcakMrGtKPavZ8t0TOzxYSiuu8+QBj/r1SJ
0VGQFIkD3DHJHap3MlEhaquZ1RJwGQWALh44IyybqbEOfGeS6GStOSeXen+ykKkT
HOawpmgONJ8dAInEwDRy07m2iGK0vcE0IxWPYZfhB5hF9V3zgrWsQowOC3/vjrl6
K1M1Im4wy0R21v0Tu6+Y8384MxwiFg==
=05SM
-----END PGP SIGNATURE-----

--DM+wrrA3zhYr83Bt--
