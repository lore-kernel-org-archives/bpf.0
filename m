Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426244;
	b=lK/9DRH+7/qZqINfhVldYgUCNpcNf8kQfv7qNiRI3/cZqaRSA0DWCNQ5h+KZBvtIeVCA
	 qIrRyFeQFjt7ALV+s5oP7BmSw4COmNM+IJ+Hv+kpo9SHaXMgeSS7fkmL5Xx+Dt4UEXhuy
	 yr1memitX4cy/GqFzOmWp34BzzfKEeMG26r6VhEJ0nAQO3C382jaBDNGjcwFSMKt7M75d
	 7q02vLoUZ8VZTYEfGyT4xPqVdGWQJ6cdNRCOV4f4y/EBJirSnwWsifYrIl+jKFVqzqyqH
	 s3Rgyhn3lrUghOaqsvwepdlve7L1ypRg+JChv/c2mIyjfDyzODx+MFXa2zaDZZfXzmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426244;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=BwqJ94bd75cZjVpXn/TlgXd93/gMvYA1acKy07eUl1c=;
	b=Dk7ZFovCR86EgOm67yGX7Ij0dyfpAZgRtsoDQqfXfCH3Gz+3zQG+Q5vGnXnxh8YzlGa4
	 jr5WWiPanxnRdVrRSYs3h5ilLXrlad3DGE2a82/cFsvxNGtv4gA3HAFwRuHh2ddoMX4W5
	 N3L47zaJZMQfsyhvP6kiIVZYGMhmuqTeOt4Z/sa5jSfR4sowidouLguO434WQgoyshjxt
	 SUnhjZwQl7ZUzFiso4/xS7FFgSpuPlYVgwXM9VakAUUHScE8vCi2yFR+j7zJykAfSpq4C
	 CrfL8yFGT4LgCKfwB35ZSNN954Eqob83QpnyUc7CWhzD5IKZ5KGGzdYqBonQQpSW7Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0sdwG2W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B837606A32D;
	Mon, 19 Oct 2026 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0sdwG2W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22641F000C6;
	Mon, 19 Oct 2026 16:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426244;
	bh=BwqJ94bd75cZjVpXn/TlgXd93/gMvYA1acKy07eUl1c=;
	h=Date:From:To:Cc:Subject;
	b=J0sdwG2WLlP/0a+gCfWUUIzC0AQ8118B1emqMQhvSET1cn14pIomliXRK/EszZVaB
	 6hgDtgyAHdfKfcDFSL/4FV0GJiaX+QMYilSNdn5pELRLz5MGXrFfn7c3mV632aGyCP
	 kfYqasO0zusNdTDVw9X9N7Uccngs5DL8EbG+QDpqjheITJSJdK9Qg8JuwPDJY07ZQi
	 hvSOxYG1r6wiuk+Fo9Z3Nir78SZcFm3Jcm6NyImIlDnjO0XRuXk7sIrYrm9c7cJ5mj
	 HiQWh7vvEFAbJ+nRnc4143DHmjRIkTwGAd4eSSMSECf/pWODSrAaQqLz8vuoXna/WP
	 D+5fQhr+gNnWg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BD0D01AC57D0; Mon, 19 Oct 2026 17:10:41 +0100 (BST)
Date: Mon, 19 Oct 2026 17:10:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the vfs-brauner
 tree
Message-ID: <atZBAZTtUd6mr09s@sirena.co.uk>
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
	protocol="application/pgp-signature"; boundary="UDGqM2jls/p2DpRp"
Content-Disposition: inline


--UDGqM2jls/p2DpRp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/token.c

between commit:

  64cbb36448ff2 ("file: make struct fd_prepare const and kill its err field=
")

=66rom the vfs-brauner tree and commit:

  f52b699c88634 ("bpf: Don't leak the inode when token creation fails")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/token.c
index da915a4f972b1,19660ef95ddbd..0000000000000
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@@ -169,8 -169,11 +169,11 @@@ int bpf_token_create(union bpf_attr *at
  	FD_PREPARE(fdf, O_CLOEXEC,
  		   alloc_file_pseudo(inode, path.mnt, BPF_TOKEN_INODE_NAME,
  				     O_RDWR, &bpf_token_fops));
- 	if (fdf->fd < 0)
 -	if (fdf.err) {
++	if (fdf->fd < 0) {
+ 		/* no file took over the inode reference */
+ 		iput(inode);
 -		return fdf.err;
 +		return fdf->fd;
+ 	}
 =20
  	token =3D kzalloc_obj(*token, GFP_USER);
  	if (!token)

--UDGqM2jls/p2DpRp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCatZA/gAKCRAv73Ows9A4
iWCvAPkB6ZbL6E1j7g5FYtyC+2t7fVO6dIZrRPranvAHwPucCAEA49FlEn4YlBCE
t9E6OGS0+1cKXqy1ACJY7o9t+222mw8=
=aX1v
-----END PGP SIGNATURE-----

--UDGqM2jls/p2DpRp--
