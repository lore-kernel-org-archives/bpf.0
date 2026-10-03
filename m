Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB137FF56
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991236; cv=none; b=SUAMZrmbWsXl7iABYvgIlyUCporjMStALCk/euLCDGjPXmFv/ea6wPceP34NtPAtAsMumnW3G/lQASoKyy83/yiX/74W1n9DQxjrnEHxGMpU6ak59hhDvHmmZpscckdLmeRasMxD6YwUddmA+Nap3vB0q7Vr/5LvYDkeFQwGJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991236; c=relaxed/simple;
	bh=xyy90GAZgEP86WQk7kIifhQQRR791zCObaQt8h1FTgA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBGOvntRVeMDRidG0YzPgmCu82uiZCUi0V4wVnUqst1dIIFH2xj9H8tdGjD2d8kqC37PqJN07zXEi19c5RTLui4wkMXM9RA0WoYtW6zAWF341Ff0A8jNXhHOERWHMB6p405azbM7QJxZ82LSM0s2GqNrDjHWKaSDHFpU8FqOBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwLH+pym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwLH+pym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06831F00893;
	Sat,  3 Oct 2026 01:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991235;
	bh=XFlSFfJrmOotubJwcbiSXBaAHXK7usYoSmyyoIE8dAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TwLH+pym3joXLaF2M/0XGyPDVbzfp5/z763unluGzKlrStkJIfHi9ZHTB0wdLi6/F
	 mIndgX4C0e64W0qdEHV40NRMNsO7E1AvxoVCkyXMaOFJMjt0/sMOcV6JFuD96HENJK
	 xHnZjkSgtZXxToBas726oSVHuoVvu5OK3ZssWdhseUSXT+g4D3Gj6BSP1g301MM1Vh
	 sbYdVrO3I7u28/zDQ/HQfmJGBWY3bbuMv4N5VllhdJREWwEHI+rrYe1pN3tfP/VFoy
	 /MHut+vZsCt9DkQOjkI+TTfc3BXfcxBmYN6KWTcYykHgc5aWx0aMuK76BztPlmo/z9
	 VuzYvVk5/z/Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 09/13] selftests: xsk: run the RX and TX
 endpoints in separate processes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261001202124.692591-10-maciej.fijalkowski@intel.com>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
 <20261001202124.692591-10-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:54 +0000
Message-Id: <20261003013354.D06831F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: xsk: infinite loop when peer process crashes
--

commit 75a72a39b57bce249cec4dee9c3d6dcc72729c6d
Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
selftests: xsk: run the RX and TX endpoints in separate processes

This commit splits the xsk selftest into separate RX and TX processes that
communicate over a TCP control channel. The endpoints exchange fixed-size
messages to synchronize steps, track progress, and abort on failures.

> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xsk/xsk_peer.c

[ ... ]

> +static int peer_drain(struct xsk_peer *peer)
> +{
> +	struct pollfd pfd =3D { .fd =3D peer->fd, .events =3D POLLIN };
> +	int ret;
> +
> +	while (!peer->closed) {
> +		ret =3D poll(&pfd, 1, 0);
> +		if (ret < 0 && errno =3D=3D EINTR)
> +			continue;
> +		if (ret < 0)
> +			return -errno;
> +		if (!ret)
> +			break;
> +		ret =3D peer_recv_one(peer);
> +		if (ret && !peer->closed)
> +			return ret;
> +	}
> +	return 0;
> +}

[Severity: Medium]
If the peer process crashes, peer_recv_one() detects a closed socket (like
-EPIPE), sets peer->closed to true, and returns the error code. Because
peer->closed is now true, does this if statement suppress the error and
cause the function to return 0 instead of propagating the failure?

> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c

[ ... ]

>  static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info=
 *xsk,
>  		       bool test_timeout)
>  {

[ ... ]

>  	buffer_len =3D pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
> +	if (pacing_tx_sync())
> +		return TEST_FAILURE;
> +
>  	/* pkts_in_flight might be negative if many invalid packets are sent */
>  	if (pkts_in_flight >=3D (int)((umem_size(umem) - xsk->batch_size * buff=
er_len) /
>  	    buffer_len) && !test_timeout) {
>  		ret =3D kick_tx(xsk);
>  		if (ret)
>  			return TEST_FAILURE;
>  		return TEST_CONTINUE;
>  	}

[Severity: Medium]
When pacing_tx_sync() calls xsk_peer_tx_sync() which relies on
peer_drain(), the suppressed error causes pacing_tx_sync() to incorrectly
report success.

Since no PROGRESS messages are received from the crashed peer,
pkts_in_flight remains artificially high. Will this cause __send_pkts() to
repeatedly return TEST_CONTINUE without ever pushing packets?

[ ... ]

>  static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
>  {

[ ... ]

>  	while (!(all_packets_sent(test, bitmap))) {
>  		for (i =3D 0; i < test->nb_sockets; i++) {

[ ... ]

>  			ret =3D __send_pkts(ifobject, &ifobject->xsk_arr[i], test->poll_tmout=
);
>  			if (ret !=3D TEST_CONTINUE)
>  				return ret;
> =20
> -			if (test->fail)
> -				return TEST_FAILURE;
> -
>  			if (!test->poll_tmout) {
>  				ret =3D wait_for_tx_completion(&ifobject->xsk_arr[i]);
>  				if (ret)
>  					return TEST_FAILURE;
>  			}
>  		}
>  	}
> =20
>  	return TEST_PASS;
>  }

[Severity: Medium]
Because __send_pkts() returns TEST_CONTINUE over and over, and
wait_for_tx_completion() returns instantly when no packets are sent, does
this create an infinite loop?

If a test endpoint crashes, it appears the other endpoint will hang
indefinitely instead of failing the test, which could permanently block
automated CI pipelines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001202124.6925=
91-1-maciej.fijalkowski@intel.com?part=3D9
