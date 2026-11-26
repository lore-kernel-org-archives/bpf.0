Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704171;
	b=y9pMRXF8UV8Cv3LKuPNO4IcDgYmToZnXU3UhJ83HqRaqPXc6Cy6uIy0Ci3I+vRMpqGEJ
	 HBme5rHY9AEmjPP069DWj8J+bTEYPCLTbGLKfjjkJ5ZxooaqFwCR85/7kPtUav9zpwLm2
	 rJ9uFuOiGIAOFZ3yE8DMYg7MzNce9aAafW8W827B/wa+beIxLD3THLeFNVG15GZYjNSll
	 GA6pyrKDfOKtMiW0dzmzVRI0iQpTlP9TIRRCLmOdyf7463JYrTbJOLwfKwYmUnyNHiA/F
	 lqCh4atP+4QhR1JzKzjzWZUfe6LTmQIUWn4mU9g+W/8/FgdRp1Zu/xGLDCRge3Tszkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704171;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=JYPsmB66dwbC3XOJ6pYUPwzn1LyFJbhM3EW4JIXLKjw=;
	b=QuS4xiJo29L4wRmnAjcvLel60JzLBJWNbAGouSjp9s+5zbGMWXlI+T7vPqTHZhU42eyM
	 hf6DSqSf0qLa+RambQTPXmF1zWW5qGNlcEyQjVahFp7wBz+Q00iJtm6j/63SvoJ+s/jtq
	 HYr6umByZSExxSNdJr3S3SaZHlyZA0TRZOXVQxiWIHCdoR8uXyrdn7QbUxuFmVd/ST5/r
	 uHYWnmBNBq+9Vz4YtmT+IqPoufRNh3iDYrbeWd6z20kiVyKT9Rp8ydr9w8Jnsj25TEBd1
	 xLw+YIhjXBoWmNJMhUQyXbwWqcKTPfzQge2hEXcNv3x87gM+ms3DK4xBx1pUR71txjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaG113oe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9C606A321;
	Thu, 26 Nov 2026 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaG113oe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DB41F000CA;
	Thu, 26 Nov 2026 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704170;
	bh=JYPsmB66dwbC3XOJ6pYUPwzn1LyFJbhM3EW4JIXLKjw=;
	h=Date:From:To:Cc:Subject;
	b=UaG113oe3Tv0QDg78iAwAXOfxu68pCws8/JTTJy9zAmKAA3bYShyDeupRZkrQKMUM
	 4YXS25Qa7/0YOmFFgsiSWMFOVUUJuDOfpee7QB/jJyaayIbOZN7IHWiyOpMkDh4Yhf
	 ysR1EeWrB3YHB4fe/j+TDaiQ5aBgx6vmXKA3TKJo43P+VqQJLDtxMMEP7CWPFxSuBt
	 wuHYm2Aw2s5jaG0h2ZgbNXTzGzs3YVvx6Jk9GYpdIVrjqOYC+L5NO5H4jSHLY6y5oU
	 CNFtj9MhkcmW5wX5DQ0e6q7EDvbGfAy5qXfCwH8oIVVN7EAUG9ajUa48y+GRZxsN4m
	 PDOyQWQVwwlfg==
Date: Thu, 26 Nov 2026 14:42:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Mark Severson <gr3yf0x87@skyn3tlab.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: linux-next: manual merge of the bpf-next tree with the jc_docs tree
Message-ID: <awhFZdaQIUEMbV9W@sirena.org.uk>
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
	protocol="application/pgp-signature"; boundary="iBYBX0PRmQeTR7gE"
Content-Disposition: inline


--iBYBX0PRmQeTR7gE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  Documentation/process/changes.rst

between commit:

  138ede2edc502 ("lib/Kconfig.debug: Set the minimum required pahole versio=
n to v1.24")

=66rom the bpf-next tree and commit:

  edb9f53371e4a ("docs: changes.rst: set the pahole minimum back to 1.22")

=66rom the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined Documentation/process/changes.rst
index 13093c5c26747,a292f31f18911..0000000000000
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@@ -53,7 -53,7 +53,7 @@@ mcelog                 0.
  mkimage (optional)     2017.01          mkimage --version
  nfs-utils              1.0.5            showmount --version
  openssl & libcrypto    1.0.0            openssl version
- pahole                 1.22             pahole --version
+ pahole                 1.24             pahole --version
  pcmciautils            004              pccardctl -V
  pigz (optional)        2.4              pigz --version
  PPP                    2.4.0            pppd --version
@@@ -146,7 -146,7 +146,7 @@@ pahol
 =20
  Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from k=
ernel
- modules as well.  This requires pahole v1.22 or later.
+ modules as well.  This requires pahole v1.24 or later.
 =20
  It is found in the 'dwarves' or 'pahole' distro packages or from
  https://fedorapeople.org/~acme/dwarves/.

--iBYBX0PRmQeTR7gE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsIRWQACgkQJNaLcl1U
h9A9Hwf/YTjcCBZlSBWpe9gW7pwLNDrpvypzjbgJGd5P0u/Xc1i4zJGZ9JtDEBlF
nRsEz4s/Ixg9tEI4Yc9YO/llAOQ6iazlC9SROY7GFWLfcKP92Ss/ww5itIkqhE89
RktYePv8YW7pI5p5Q287Cfdki/hCRbUckJMdK237YFEGfxexSD6p1fp9daU+ppnD
ex3kjPsXVo8BXX0qrDzaXKEE1UvOU/Qrihw6SQt4O1npCQy8+LblMBiLVdZt8cW0
0I6y/eyrNWILQdSjL/PF9Y9ovc0pjaelO4pepce77u08Z5g6KbrbfleMzbhS+Rk1
kemae6/fVPqRvyLbbjqlzErjrIFh0Q==
=Uzy2
-----END PGP SIGNATURE-----

--iBYBX0PRmQeTR7gE--
