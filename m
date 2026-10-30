Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336065;
	b=KMlAwCXBv83HCH5Cp/OlNW33tOpNO2L9DVdTrkruHYz5LWvRBWGHCdO96W0J5LdXjE3r
	 lKekaojxllVex64D4CRSFLLhcYvaU5GwnKzyB+dCL8Lc8hhlBTLv/EU580zzkoKsTEJ9y
	 t5vzDN3uap9YGnpN9AFheYGjvb8NLCOrDX2iSwrZH+k0bB70uZms9SKSKIUvFS2VGm3xy
	 YDRwDsI5QKSiuWFsGCYUJWLh9PAIiQU5hnPjnolZ6Hr9mApOe/AVfHiAEHIS0iA+80FGs
	 WJnx8lLbSz2WdRskRPVaUxbcMHUCeCc7vlCbvhgmpQIehwGLn0TglagMCeEXIJEz/Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OJZSzTa4yBRKXfuO6IV5ZUatTYQAwmlhKy+RHqaMoFs=;
	b=HsFv0I9tIst7ZDs3zcYKaJD4ORtqKU4Ibg8wZjZl99Wpc55aMUKjbpJQ6+z2QmmNZIRK
	 UH1oJTzR4wjzCJHAZnVzM74bkJdmeTNhTQf2CN643ww0vbVwjzeU6EfNSAoHIqwH+VXoa
	 c3BSZJGK0hzGV22TwZ6KfZ4b7DGTIxSbdnrB0WdhQvVWhcZGKW+Bx7KPxX4e4ipYVHe9W
	 +UetPI7rNW4rLVREewtIAod4UpqvpyL2spDkLmGJjsZchK7vHJNoOK1cDLJUcdOf1pgoG
	 ha01I7kdbmdCLz+28+RiuXPEr1yO7ulNsPH4fefcvbK2e/xviMRvqH2UroqT2GQBrPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eEMMLOe/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2D606A321
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEMMLOe/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E755E1F00A02;
	Fri, 30 Oct 2026 04:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336065;
	bh=OJZSzTa4yBRKXfuO6IV5ZUatTYQAwmlhKy+RHqaMoFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEMMLOe/ke1NLUjsrT/3Y/8YNm66DtO15MzXEVo2n4LWaflIod2KxOW+lPVy5DJEh
	 /tQ/+dXxH4hfjqpDG0a53QoJjc9LkZcsBFGvwa1raR8pJPuF5NgdKn2iLqH5mxGsS6
	 XU9AJQweLoG/a++OwTOtdGwtBStzld9s8denZSkgKbmtr5BgRMKhQAB6r6MvWXQJp+
	 fWkiHpEa2MOEmEMuE9DgnEjvwZb6XO8VOxKkz/ou3pOzSS4bSACdnUmn3CAhU8ZiJ7
	 RU1E8o4GnNSUBGSV3VWB/A7pb8C/xYBWwambkZ8qEwvZs06ngwFon2W9uH2UH3+lXl
	 NitTVj+1iCAHw==
Message-ID: <sashiko-outbox-190462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 1/2] tcp: rehash onto different local ECMP
 path on retransmit timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Spring" <ntspring@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260522215733.929238-2-ntspring@meta.com>
References: <20260522215733.929238-2-ntspring@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:24 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] IPv6 flowlabel reflection (REPFLOW) is broken for SYN-ACKs when sy=
ncookies are triggered.
--

commit b64f3a9b6e1ac0e884a330cb07667e97df46001c
Author: Neil Spring <ntspring@meta.com>

tcp: rehash onto different local ECMP path on retransmit timeout

This commit updates the TCP transmit hashing logic to re-roll the txhash on
RTO, PLB, and spurious retransmission events. It additionally ensures the
cached destination route is invalidated and sets up the routing lookup to
use the new txhash for selecting a different local ECMP path.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c

[ ... ]

> @@ -7656,6 +7659,11 @@ int tcp_conn_request(struct request_sock_ops *rsk_=
ops,
>  	/* Note: tcp_v6_init_req() might override ir_iif for link locals */
>  	inet_rsk(req)->ir_iif =3D inet_request_bound_dev_if(sk, skb);
> =20
> +	if (want_cookie) {
> +		isn =3D cookie_init_sequence(af_ops, sk, skb, &req->mss);
> +		tcp_rsk(req)->txhash =3D isn;
> +	}
> +
>  	dst =3D af_ops->route_req(sk, skb, &fl, req, isn);

[Severity: High]
Could this change break IPv6 flowlabel reflection (REPFLOW) for SYN-ACKs wh=
en
syncookies are active?

By moving the cookie initialization before the route_req() call, isn is now
a non-zero cookie value rather than zero when a SYN flood is detected.

For IPv6, af_ops->route_req() maps to tcp_v6_route_req(), which passes this
isn value as the tw_isn parameter to tcp_v6_init_req().

Because tw_isn is now the generated syncookie (a non-zero value) rather tha=
n 0,
the if (!tw_isn && ...) check inside tcp_v6_init_req() evaluates to false.
This causes it to skip saving the SYN packet's ireq->pktopts.

Later, when tcp_v6_send_synack() attempts to send the SYN-ACK, it checks:

	if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)

Since ireq->pktopts was not saved and is NULL, the SYN-ACK fails to reflect
the IPv6 flowlabel during SYN floods.

>  	if (!dst)
>  		goto drop_and_free;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522215733.9292=
38-1-ntspring@meta.com?part=3D1
