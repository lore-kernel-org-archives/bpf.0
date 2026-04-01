Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757132517AF;
	Wed,  1 Apr 2026 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046580; cv=none; b=BKWq9BNAm04qyxxbIPKD9A33qQzueN9Ou10zxCUFBJGvA8/e/dPxj1UvMqf+yI5txdxnnZzpW4l/kbS6TIYdHOJde7aCFLo1+dqeS6OMh9UOytVHMErg3BeyZX45J9aDCUT09ccsIQhThsbTXQjCyde1aM+lk+1vUrhWARKbJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046580; c=relaxed/simple;
	bh=Pa5xehPbpTxE04NEMpalVH5u0HzoLtyr2yyXncQoNic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o0xZGll8JWuy97wDruxe7Y85xc5YoS+EXYr1k3297DCV2Gi/pQaVne5HmJFlulxgSpIzqEcaD/IintIrBD3JgNR6xioNHHAqCb2RcNXR2yvxzF67+GoWePBPKfJaWoABg6RXwMEB3hvCXj7faSOD1HyjSRtYT6t82PN4Tp+7j8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Q8y3yw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Q8y3yw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97C0C4CEF7;
	Wed,  1 Apr 2026 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775046580;
	bh=Pa5xehPbpTxE04NEMpalVH5u0HzoLtyr2yyXncQoNic=;
	h=Date:From:To:Cc:Subject:From;
	b=H5Q8y3ywmZS3C366mQ/5TigV7a3EzxxpbQH29dwB6uYh5SOFNhICSY6bqcQZebIFb
	 f2NsAfhJRhGk0X5qqE2UdSHsJn50sNkMjdbBd6U7+mrKl+S0b71p7ID6a4zXuRThFn
	 aSgf7SIYXJUES3NL0XR2vniOGX7NgYc6QDe7OJH9CcVZltUV0iHP3YCuUo0pHe6RFi
	 MnzvLrzQgV7QVCdupzuhQDxrxG2Hw0hopYeX7zauUQJ5W70OIIApdOTLN+9G6mTxTf
	 /6V/prYrAXK+jq9oKrNBRKnOzDFEyI5JE1Z01Wqy+6tFO5OJ20+Ii1oUsf0UOePOc6
	 tqtWy+1LPqing==
Date: Wed, 1 Apr 2026 13:29:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <ac0Pr9K1Qbn1-Dn9@sirena.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JyB9umdJEX1zuhGn"
Content-Disposition: inline


--JyB9umdJEX1zuhGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/verifier.c

between commit:

  a8502a79e832b ("bpf: Fix regsafe() for pointers to packet")

=66rom the bpf tree and commit:

  022ac07508836 ("bpf: use reg->var_off instead of reg->off for pointers")

=66rom the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc kernel/bpf/verifier.c
index a3388cb8fcbdf,8c1cf2eb6cbbd..0000000000000
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@@ -19915,18 -20075,8 +20075,13 @@@ static bool regsafe(struct bpf_verifier
  		 * since someone could have accessed through (ptr - k), or
  		 * even done ptr -=3D k in a register, to get a safe access.
  		 */
 -		if (rold->range > rcur->range)
 +		if (rold->range < 0 || rcur->range < 0) {
 +			/* special case for [BEYOND|AT]_PKT_END */
 +			if (rold->range !=3D rcur->range)
 +				return false;
 +		} else if (rold->range > rcur->range) {
  			return false;
 +		}
- 		/* If the offsets don't match, we can't trust our alignment;
- 		 * nor can we be sure that we won't fall out of range.
- 		 */
- 		if (rold->off !=3D rcur->off)
- 			return false;
  		/* id relations must be preserved */
  		if (!check_ids(rold->id, rcur->id, idmap))
  			return false;

--JyB9umdJEX1zuhGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnND68ACgkQJNaLcl1U
h9BruQf+IswyKzelhGT+V0k+GSzclqDiiu54e7e+h5L46HJ2ln98S5CnBIcUYjBg
BMk1bTPTlpKRU5xDsK60kl2AAUQGfnS+L7IY1lgcrGqIpuJqaW+GeSVTojbpsYtS
inIyjxS8LHVI5AM25CtQVwUd1Ox7f+LFyJXqRrJ03D/Qrvb/1fBYpKYaHSXoaA1G
/ESdWBAszebmLldA20Ozmu9HjE0cBR3oyUIMsoVClG3W2bImXeEEFeoJFhPK9dec
uDwNki4a6sKioSr2f5NfsX3B4tf4pVhVcDPG12ohATH64eRT9ixP8Vtu/Mra8vUl
Qq++9zcuibJlFBtONmFqFGSnfYH+Wg==
=wEbj
-----END PGP SIGNATURE-----

--JyB9umdJEX1zuhGn--
