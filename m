Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589671;
	b=32uhGwI6we+y8bnCRup4crajQom8AfJV4bOzJcX6iydtnJ0vk7JDiBF0qauBWBvNW33E
	 MTqS5ASTF5ZUCnSAX7QuxGkvkf/fWQSjlNqPT2ms1GfRz7IFjCA1PjrC+3Axq8h13GzlP
	 ywrFzcAEHnLYex3joTqfG4ieJFmr2kYzETJEnGlZwTQHIEn4+Y98o6wZvios10hOLSG2K
	 KpcTtjHbD81+blp8QAstaXTh/h8VxAAH0PO3C/ou+sbUiyjmLT5W1T7R91m3EMhXG5MyS
	 BjSvzcgecAnNRh8O3gi9k6+mLcFr5m/S9tt3oAESPNBKh7ob7zd46jNc6jYfgyqPjSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589671;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zhrXd6irbCVGRCuk+B5sgbrY9TcqoC+GJ4D9REvZQI8=;
	b=va2Io9JzORxosqbdJ9Bq2XLfhhKJRa+B0WvJp2+BX22WsI/4Km1aykGtHGUBkgt4DWm+
	 1JLVZybwxEZ6kLJ5oJOsxw+Xifu/XeCFIO7uWxuVpg8eO3Jcy0yqqD+wDTnazpoLWzBmm
	 aRcavFn2J8hywyNwuwjI6JJdMFZHhVUcr1NQkGcDsAkY6UN1k1Yf1DDGTUBhrY1MvRCPf
	 ofKjXVKxIkfVbq2nWWzqrYPW4X0ienJ2TnFRMGx3Xq23KQCLOw4McBo0L1jxHcmu6LPWL
	 Ifp7eZZlf1IGOxIcaIAOGR6CJNnk6RvqG95ecCsnmu6xW3VVNl/ERhCt5qY9f2gn/nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMWpqOHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595D606A33B
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMWpqOHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F111F000C7;
	Fri, 13 Nov 2026 17:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589671;
	bh=zhrXd6irbCVGRCuk+B5sgbrY9TcqoC+GJ4D9REvZQI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GMWpqOHdGT0gNQErPWKk+O7GhPMn9KOBh6AojoCTnzqBl4rvOWMYvmSr3/QyGuXe0
	 j2xyKnQ4LpCUy8QBHAKsODnRw8tnx2xrB9GanQ7QUkux9MpqDGnB2uWM+hM3BMxHYH
	 R1911dtxntvFSh/71puVQQ4xt6gUf627q9v0VsBut+fEkvCUHsWa9FTBhy0q6rkJfy
	 jFh7i2I5kSOLVov/9QiP9u3ufrA5uHc6G6d1xyZ2W8jHkXttAGyOG30/vxlRoG7v//
	 d9bvOHxgM7nZQv+KEp4O2x5Jh3ffev/SiAZvKTkGCXo+JMTABjEJbTZaaYjBhZQtoH
	 8nSX3HwR6IXew==
Message-ID: <sashiko-outbox-213276@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: net: getsockopt_iter: cover tcp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
 <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:07:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests: net: nodelay_undersize_clamped() uses optlen=3D1 and
  cannot test clamping vs 1-byte shrink
--

commit d0de5c7edf661839608cbe0dcd2d478b9815dc91
Author: Breno Leitao <leitao@debian.org>

selftests: net: getsockopt_iter: cover tcp

This commit adds a kselftest fixture covering do_tcp_getsockopt() across
exact, undersized, and oversized option buffers.

> diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testin=
g/selftests/net/getsockopt_iter.c
> index 2367fce226d4c..4e51c8aa6a855 100644
> --- a/tools/testing/selftests/net/getsockopt_iter.c
> +++ b/tools/testing/selftests/net/getsockopt_iter.c

[ ... ]

> @@ -1005,4 +1008,246 @@ TEST_F(tls, bad_optname)

[ ... ]

> +/* Unlike IPv4, TCP clamps the reply rather than shrinking it to a byte.=
 */
> +TEST_F(tcp, nodelay_undersize_clamped)
> +{
> +	socklen_t optlen =3D 1;
> +	int val =3D 0;
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_NODELAY, &val,
> +				&optlen));
> +	ASSERT_EQ(1, optlen);
> +}

[Severity: Low]
Does passing optlen =3D 1 in nodelay_undersize_clamped() distinguish clampi=
ng to
optlen from shrinking a sub-int reply to a single byte?  Both min_t(unsigned
int, len, sizeof(int)) in do_tcp_getsockopt() and the single-byte fallback =
in
do_ip_getsockopt() report optlen =3D=3D 1 when called with a 1-byte buffer,=
 so
passing optlen =3D 2 or 3 is needed to test the behavior described in the
comment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-getsockopt=
_phase7-v1-0-1eb759dd0929@debian.org?part=3D3
