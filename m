Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA129353A84;
	Thu,  2 Jul 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003971; cv=none; b=TU7TbXz3xKEh7zOrFd+lEv/ABQ4aDzXvDOe66GtDAiz4nPgBu4mkWABPyPs2cn62U4EdfuYWgb9JGbha+UAVOJdtTy9RL+eiYubrgJ7JTMvXLugvAZoFZruTc3SdXGUW9Be47EbP4H0X2JhY+LRuqZ/lqd2CSIJAijWI9HExT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003971; c=relaxed/simple;
	bh=dyK3P9+6GpEtKRQsGj/j0yBYfJElSrgSyi9KCpoxFfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhT5JF8gU6lb106M3latlH1GL4IceljEZcdl4z8y2etyzld3tabOgUz2UcbDwoKHPRrZ2c6TqPwSAa8mRjTdOPBjURAmZRIb/YpyXteRP3e++efUTZ4T+8oSEhoiIq6/4hhjkN0d5MkjidWg6mDkoZAv0vWFuTfJSdf3o1FDrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSR/1tS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSR/1tS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049B61F000E9;
	Thu,  2 Jul 2026 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783003970;
	bh=uOpcrBQPttphsn6xt4p6EKv4HN+A3t9NGrHIZTp18YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DSR/1tS47oqFcCy01ZCvMmROsCZrWZBluIZjmdGVuFUgR7H1PtDIdJ9xplxFGeVoQ
	 Ta2SxXCmoZY+/tIsLDG7d4ilIdcTp3gWXGu44MEUxxf4z6s0MgjWz4mc9JT1UuNhWB
	 C53NlS+mPwdIOFqd2wz5jK+ECSxeXPtSMLtsCg2P8BkpdVgJCxg/XwmUR66ArsM4R5
	 yTSZZV/0bV1REmJBVDv2ohDPArfEDzBwtE8wLtMVgcFpWCJMlNtsrDDIV00+aS948g
	 zq50gH6WIon13YlcqWulOWv2x2ow+D32ObvfyuyY28Jbegd2M2H6BuZiVKnKShgP9O
	 v6pYyLxmtO1xg==
Date: Thu, 2 Jul 2026 16:52:48 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: sdf@fomichev.me, kuba@kernel.org, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	martin.lau@linux.dev, sdf.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v1 0/7] xdp: RX checksum metadata hint and
 checksum assertion over redirect
Message-ID: <akZ7QPfn83OUx5Vm@lore-desk>
References: <20260630191510.81402-1-deliran@verdict.gg>
 <akQyT2d0wNF5F5LG@devvm7509.cco0.facebook.com>
 <akRAUTAqVKkxmoVa@lore-desk>
 <20260701171057.4330-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eDx94642woe8R2LU"
Content-Disposition: inline
In-Reply-To: <20260701171057.4330-1-deliran@verdict.gg>


--eDx94642woe8R2LU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi Lorenzo,

Hi Vladimir,

>=20
> Sorry -- I blindly missed your earlier RX-checksum series before I posted
> mine, thanks Stanislav for the pointer.

No worries. My series is just adding a new kfunc to report the rx-csum resu=
lt
to an ebpf program running on the NIC. It does not take into account the
XDP_REDIRECT use-case. This is orthogonal and we can work on it later.

>=20
> To answer your question: yes, I'm happy to take on the driver selftest
> Jakub asked for.

Cool, thx :)

>=20
> As for my own series, the read side clearly overlaps yours and you own it,
> so I'll drop my bpf_xdp_metadata_rx_csum() hint and its driver bits.
>=20
> What's left that is genuinely separate is the "assertion" half -- a non-d=
ev-bound
> bpf_xdp_assert_rx_csum() that preserves the HW verdict across a
> cpumap/redirect: it sets a flag on the xdp_buff that rides into the
> xdp_frame and becomes skb->ip_summed =3D CHECKSUM_UNNECESSARY in
> __xdp_build_skb_from_frame().
>=20
> Should I resend that as a small standalone series (v2, assert-only)?
> It also looks like a PoC that you and Jakub discussed on v3 [1].

I think we should address the 'CHECKSUM_COMPLETE' use case for it, let's wo=
rk
on the problem later, even Jesper is interested in it ;)

>=20
> A few things I'd like to confirm before writing the test:
>=20
> 1. API for v4. In the v3 discussion you agreed to rework the API to report
>    both COMPLETE and UNNECESSARY (+ csum_level), per Jakub. Do you plan to
>    send that in v4, or should the driver selftest target the current v3
>    signature (enum xdp_checksum + cksum_meta)? I'd rather write the test
>    against the API you intend to keep.

IIRC I addressed the request (the code is in [0]). What is missing is just =
the
self-test.

>=20
> 2. Documented behavior. The selftest is meant to "check the documented
>    expectation", so which rule should it assert -- "a driver must never
>    report CHECKSUM_COMPLETE while an XDP program is attached", or that the
>    driver downgrades/repairs COMPLETE on the XDP_PASS path? I'll write the
>    doc paragraph and the test to match whatever we settle on.

ack

>=20
> 3. Drivers. Your series adds veth and ice; I don't see mlx5e -- was that
>    intentional (left to the driver maintainers)? I had an mlx5e
>    implementation in my v1 and I'm happy to contribute it to your series =
if
>    it's useful.

My series does not intend to address all the drivers :)

>=20
> For the test itself I was thinking of extending
> tools/testing/selftests/drivers/net/hw/xdp_metadata.py, gated on the new
> "checksum" xdp-rx-metadata feature, with good-csum / bad-csum / modify +
> XDP_PASS cases. Does that match what you and Jakub had in mind?

That was my idea too.

Regards,
Lorenzo

>=20
> [1] https://lore.kernel.org/bpf/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c=
50ba71@kernel.org/
>=20
> Thanks,
> Vladimir

[0] https://github.com/LorenzoBianconi/net-next/commits/b4/bpf-xdp-meta-rxc=
ksum/

--eDx94642woe8R2LU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakZ7QAAKCRA6cBh0uS2t
rPwZAP9QldAxf0V9eciMRzUl8nX7zE5NdCf0fMHzRUaKJsx6aQEAvAS4ZnhvJc0F
UMp3vNCipY6If6Pl7wSxkkV/fXWGiQs=
=NKkH
-----END PGP SIGNATURE-----

--eDx94642woe8R2LU--
