Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545343935F;
	Wed,  8 Jul 2026 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523530; cv=none; b=XSze/4W1EcjFJk7vKKGgZblrdFQsohscW7k75nX+QZaD/uoQ+Q5qB1l3W/YoNvQpzrc9hKUvUFpxvLCCq5BNWchl7mWDH/n4v+h5qCC3n/ohp2gLksuQp1rLtPddZUIeRhuvzkNM1JdShEEEQYvfIi7iZjuyFLOJnXpmxo+fGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523530; c=relaxed/simple;
	bh=eZm0r2DiTpoq/10mInPMNUJ6HALbq9YR8YcTjrOAKHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDGj/Zj97zCnKxcMBiDm7VRN7C8XT/y1yHwM6HNZnv+xkvwnoOUP31/fw0vmv+VrPkKEL28v6ZBhpOvSuG61rXi6dW/JhFLzRAvkjLK3nfsWK7o+4CNw/YmHjYufF8aWCZwWFqe5KQ/k8ZA0rq7Ur0MoK7AjvH9Yr5hSKlZZ2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr4sAWnz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr4sAWnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D14B1F000E9;
	Wed,  8 Jul 2026 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783523529;
	bh=nyY1MWhLb4Wq5gDtA7z3gSgPQVymbQDkrz21Siw0Hjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cr4sAWnzV4LQ0SCxq+97uhFdA9kAEz60uPyDydZ1AerCsEiKtbU7+a9Oy+hlstCNT
	 /1LwCV9UfoBV5xfX6Q5nys+rPY4itZBiEkHrMLTsgl3CCQHLbAi6xLC0TjfQQ7Pksh
	 Q0ZafeK84RnC9dhV7G8z5HLIMSOYDtsDMam3jQddzJSzoiDqG8NtktnYNbY2yJ+7lG
	 BG+T9bZFWPYvg275MgzeHdJ5a1Gl+E138vs96qutdobF9PX8dJ3qD3Ado4tWhKQk9S
	 UFG5L3Puy932ZMeqoWg5GLMruTguBhVM+neSK0jdsmi0kI5bsdlHPd7VnSaKpA45Js
	 F+iWy2idbGY3g==
Date: Wed, 8 Jul 2026 17:12:07 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: sdf@fomichev.me, kuba@kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	martin.lau@linux.dev, sdf.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/1] selftests: drv-net: XDP RX checksum
 metadata test
Message-ID: <ak5ox296M46FAcWX@lore-desk>
References: <akZ7QPfn83OUx5Vm@lore-desk>
 <cover.1783514455.git.deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25fzO8AAG30TYajc"
Content-Disposition: inline
In-Reply-To: <cover.1783514455.git.deliran@verdict.gg>


--25fzO8AAG30TYajc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,

Hi Vladimir,

>=20
> Here is the driver selftest for your XDP RX checksum series, as
> discussed. It is written against your b4/bpf-xdp-meta-rxcksum branch
> (the bitmask ip_summed + cksum/cksum_level API) and applies on top of
> it rebased onto net-next, since the drv-net xdp_metadata.py test it
> extends only exists there. Feel free to pick it straight into v4.
>=20
> It adds an xdp_rx_csum program to xdp_metadata.bpf.o and two cases
> gated on the "checksum" xdp-rx-metadata feature (SKIP on devices
> without it, e.g. netdevsim):
>=20
>  - xdp_rx_csum_valid (tcp/udp variants): traffic with a correct
>    checksum from the remote endpoint must be reported with a usable
>    verdict (CHECKSUM_UNNECESSARY and/or CHECKSUM_COMPLETE);
>=20
>  - xdp_rx_csum_invalid: UDP with a corrupted L4 checksum (net/lib
>    csum -E) must not be reported as CHECKSUM_UNNECESSARY.

thx for working on it. Unfortunately I do not have the time to look into it=
 a
the moment. I rebased my b4/bpf-xdp-meta-rxcksum branch on top of net-next =
one.
Feel free to repost it adding your patch on top of it.

Regards,
Lorenzo

>=20
>=20
> One question on the invalid case: I assert only that UNNECESSARY is not
> set for a corrupted checksum (COMPLETE may still legitimately be
> reported, since it carries the raw sum for wrong packets too). Is that
> the documented expectation you and Jakub want the test to encode, or
> should it be stricter?
>=20
> Thanks,
> Vladimir
>=20
> Vladimir Vdovin (1):
>   selftests: drv-net: add XDP RX checksum metadata tests
>=20
>  .../selftests/drivers/net/hw/xdp_metadata.py  | 103 ++++++++++++++++
>  .../selftests/net/lib/xdp_metadata.bpf.c      | 112 ++++++++++++++++--
>  2 files changed, 202 insertions(+), 13 deletions(-)
>=20
> --=20
> 2.47.0
>=20

--25fzO8AAG30TYajc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCak5oxwAKCRA6cBh0uS2t
rJryAP9qRx+2qAVR1A56PZcxxMhoGDEv8KyL++5yZgQrru6nIQEAtI8wSuvf/kHZ
AF8m77h6e7pqD0n1l3s/QjHue4ib8AE=
=zMyG
-----END PGP SIGNATURE-----

--25fzO8AAG30TYajc--
