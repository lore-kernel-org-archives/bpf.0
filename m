Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949FD231832
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102156; cv=none; b=K2xH9DPu5Jz2iBkfFPmoyQckNLu1Cz9xkz+dVqZO+0P+PGIorvjn65gdjVTSBF3/EOG3zt1ANGp7/0JJ76HXDlGb/goZI0JUz3LkiADUpTVrNJxjsTsvNIEbbGKzzY0AogmUGSl+4BaKC+X0hlrN6Xy42y4gjPsjVWZVLpYOYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102156; c=relaxed/simple;
	bh=fIeefCb3bmufeJFBs24jnXZp6Q9aVvjUId0u0WrLSRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V5df4Y8/GvXZd/6JqNdiPicEGVBVXbVsQ/CUNYHiJuWny+IJePvcDCFogfDex8Qm1NpvvCySbkAMxH3EHKKa5gCqnjEBq3RkXWPN9ougPBR1F4kZB+VydkGCy5Gb0mwjdkRjshWtWohtkkJRJYHtjnQNEzjtZNxAOQDvgKmR91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXmLMpKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXmLMpKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B9F1F00893;
	Sat, 30 May 2026 00:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102154;
	bh=eYH5TgP58SWRrRUvG/zZkA/zoE+sHwZx+DHo7RSRhzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXmLMpKG2VGRN2gqNblOZkqDnh8+9NX4zrMGoUSLN1oXJAzZAlMGCm7O49PsjvRRh
	 cwtVSuATGu7OQ+y89B+wNPyJwkZ4+KTigtj3P985id0aTWMIwWhPGZfUigfImq+1pG
	 EZEsgmBv1P4eOAbYIOZhY+pjazMqm8JtZhFBYp75hHA4UY9uzUq7FKesK2NsppWlcf
	 TzNnJ4ZRgslqJgzjNxvZvv4RTPUTACE4Jz0NXfas33mCD11OkF2vugsMQrGOBDCZYD
	 IxepBbTY8rEl6Gbya9zoKMJY9U7sjOhn0W7NIw60mkUmX1V4TEsvcXoqJZrr+F6fma
	 wg3o2IcJl7otg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Spring" <ntspring@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526203403.3517607-2-ntspring@meta.com>
References: <20260526203403.3517607-2-ntspring@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:49:13 +0000
Message-Id: <20260530004914.23B9F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch omits updating `dst_negative_advice()` to clear the IP=
v6 destination cache, preventing `SO_CNX_ADVICE` from successfully triggeri=
ng an ECMP path change.

Pre-existing issues:
- [High] bpf_sk_assign_tcp_reqsk() fails to initialize critical sequence nu=
mber fields in the allocated tcp_request_sock, leading to an exploitable re=
mote kernel information leak via challenge ACKs.
--

commit b2f4449a13af2b2f1b25aefcf9bcb16d02d5c080
Author: Neil Spring <ntspring@meta.com>
tcp: rehash onto different local ECMP path on retransmit timeout

This commit updates the TCP retransmit timeout, PLB, and spurious
retransmission paths to explicitly invalidate the cached route for IPv6
when rehashing the socket txhash. It also updates the routing functions
to pick an ECMP path based on the new hash.

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12342,6 +12342,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __=
sk_buff *s, struct sock *sk,
> =20
>  	treq->req_usec_ts =3D !!attrs->usec_ts_ok;
>  	treq->ts_off =3D tsoff;
> +	treq->txhash =3D net_tx_rndhash();

[Severity: High]
This is a pre-existing issue, but does bpf_sk_assign_tcp_reqsk() leave
important sequence number fields uninitialized?

The inet_reqsk_alloc() function allocates memory without the __GFP_ZERO
flag. While txhash is properly initialized here to avoid reading
uninitialized memory, fields like rcv_nxt and snt_isn appear to be left
uninitialized.

When this request socket is processed by the TCP receive path, could
the uninitialized sequence numbers cause the sequence validation to fail
and prompt a challenge ACK? If so, the challenge ACK might be populated
with the uninitialized snt_isn and rcv_nxt, potentially leaking kernel
slab memory to a remote attacker.

[ ... ]

> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -300,6 +300,8 @@ static int tcp_write_timeout(struct sock *sk)
>  	if (sk_rethink_txhash(sk)) {
>  		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
>  		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
> +		if (sk->sk_family =3D=3D AF_INET6)
> +			__sk_dst_reset(sk);
>  	}

[Severity: Medium]
Since the IPv6 destination cache needs to be explicitly cleared here and
in other internal TCP paths to propagate the new txhash, should
dst_negative_advice() also be updated?

When a user calls the SO_CNX_ADVICE socket option, it triggers
dst_negative_advice() which generates a new txhash. Without an explicit
route reset for IPv6 in that path, will it fail to drop the cached
route and prevent the socket from utilizing the new ECMP rehashing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526203403.3517=
607-1-ntspring@meta.com?part=3D1
