Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706437475D;
	Tue, 21 Jul 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641577; cv=none; b=ZzY2Qi6MPxMA5D4MdmMlJaSRxTT8cVomM55EEm6aJeIurcDhyx1aPpqTd5ahJJdZhhRoGIup456AeOz9knhgyDRTayiWtKgA+gO7Iw+yiLzc3j/EqqxktICebI4SOq+D7qzI4QSJ6hnk33Nr9lsa81bYnHf9sJycfJ6cckgs9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641577; c=relaxed/simple;
	bh=YHmAQjiLNzYEaUB8SN7yQlJLJNJo6V1H5zr4Z3M8jOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D88NIl8iMuIQoD56xWWmwBq8tyP0glj/l3vbbtJhPUaNuprQR5hGaeRmjlpQBxhmJONf4RDQZtl44L+Np1HSnZp2qtIWoWS3YBNYZX7ar59Iiru+L67KbSuc31/Vs9Xpz09duvG9J4vb53/OvXFEA29sqHFjxeIKPnw5Z3MmyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxthmrgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxthmrgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6EB1F000E9;
	Tue, 21 Jul 2026 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641576;
	bh=cM6JN2+AatKWYUnC6NFpmF9MDad9HR/pjGosJsoP4zM=;
	h=Date:From:To:Cc:Subject;
	b=VxthmrgCfFsCv6Muw+9RwM0SxYG4Tldq1UpfnG4QR2AnfIfGuRTSTla2+AuV183db
	 ins912Ht0bDIL17HfgRLPQpSqe8XEJnloYu8HTw5DsSurTWkovdGOHeioKFkVmXXdA
	 Wgoj3WN3B4jtLoSPWedkYrGJCqz0WwC55xo0dR2iNTnk5BnLKMSnYAKzmtzlN+eqbq
	 km4IWUL0ZoWZwGhelAwr427lfr3QWfuDj3kvppWxGbbln+AeQSN8SpmGyp9jCHX501
	 droluK/3DAKb7MMsqHnSl73e+fx0tvraFRGkwKON69L3VCMDo3ijHwAg/isfQTtruD
	 oGTvcNcT6u/yg==
Date: Tue, 21 Jul 2026 14:46:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jordan Rife <jordan@jrife.io>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the net tree
Message-ID: <al94I2SyQHoC5V-h@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5Q50+hiJ6PnBkRlS"
Content-Disposition: inline


--5Q50+hiJ6PnBkRlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  net/core/filter.c

between commit:

  3f4920d165b29 ("bpf: Reject redirect helpers without a bpf_net_context")

=66rom the net tree and commit:

  509ca545d4255 ("bpf: Support BPF_F_EGRESS with bpf_redirect_peer")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc net/core/filter.c
index 11bb0d236822a,0b7afdd0ae474..0000000000000
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@@ -2575,13 -2578,12 +2580,13 @@@ static const struct bpf_func_proto bpf_
 =20
  BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
  {
 -	struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
 +	struct bpf_redirect_info *ri;
 =20
- 	if (unlikely(!bpf_net_ctx_get() || flags))
 -	if (unlikely(flags & ~BPF_F_EGRESS))
++	if (unlikely(!bpf_net_ctx_get() || flags & ~BPF_F_EGRESS))
  		return TC_ACT_SHOT;
 =20
 +	ri =3D bpf_net_ctx_get_ri();
- 	ri->flags =3D BPF_F_PEER;
+ 	ri->flags =3D BPF_F_PEER | flags;
  	ri->tgt_index =3D ifindex;
 =20
  	return TC_ACT_REDIRECT;

--5Q50+hiJ6PnBkRlS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpfeCMACgkQJNaLcl1U
h9DQcwf+Lh7WhBOrUTg2ICMHaVJn+jAY0fxZ4bK2mtoSbyHwIGQLTQxl2vEthxnl
0JdRlDi2HTekh2oOrx2vwpm5+R8wMCuHhoaAx+zUrSgm4xmJttAu0ilVffKtKBVE
uKjd3Mju4+02llLVPKNrz0V/NAZzhEPnx9xf6U+JPA6C53xhcjNgdCcZRlG1frmw
5AUKjkEqvR/0HFPOrHXDELHw12ws9/wfWmbcDtPweRPeUQqAMayLb0KeIr1qdKeA
nawksTBNjHfFhwWrXQYZepky3jpmwn0oFNeG21xF9T8bi6PXsuV9a06I/fwVLYXH
QPkEvY2+ufZGLL4eBBlhq071Mkj+pQ==
=bbnB
-----END PGP SIGNATURE-----

--5Q50+hiJ6PnBkRlS--
