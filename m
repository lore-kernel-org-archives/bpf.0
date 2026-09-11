Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C33F8251
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117129; cv=none; b=QKzNBXntX/YNhN2RcLlaptpcE2hbgWzaUNrxf93DbonqI1Qffi6fzulFxvZS1eJjZOUQFoPILl+6FrSc4WTG0wyIXgmg3kDIEsXA8Vh2opNw4ukoAGGmCh2vWuQblu/SNHOttt32AKIIIFoLy9myAdRbj9tudE5MPpXcYHUhbgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117129; c=relaxed/simple;
	bh=4eeP0CqFsrcDf5M7CKpueJgVW48Ny/2bdLJWSwxaBVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OQMqdVJVwSolXpplZGt60lCEHvAaSEV6XBP3g/kJshkl7abQnGDg9xqZELQIFsREUpgFiuC7Ub/LsWHfI5jITN6HRT8zXpFEUJbsBiVgEUIjCnsmhXIUL+BGkQ6WIv0Pq7AvTVTxN94jlTXRc5rJoGztmjQAmCxsrtEMQEG6FDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUd9RpyD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUd9RpyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AA11F000FF;
	Fri, 11 Sep 2026 08:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117127;
	bh=wGTMg7r2QncHBwV2/stYX7NCDA+Upwx1vzE/gYjcajk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gUd9RpyDFVA77h3yUrtZkJBHcI4F6tWZs/qLU4nkC2znFrQq3PER+1O4lhlqATynT
	 go2f1Dr5u6IxviXBZYCn49HAeVKcT95cEd9L9FrAk8zkIO+AsXpWiw+PUrJZRHRca6
	 lRBJ4g79kN3oQs2CogoW1o3Q2mRqp1tmGTpJX5tsEmm2mZNOnuA/TBT7tNghCh9WNv
	 5DPtMABxofur9PaGSgEbM1E3ULrsZe41x1r+WEOt5s7SzyZnEjLlWzR7D9kmRx1Lec
	 tfD2StbdR9jpGsJiOxSO3PPbXGW6oRl0xPwZJ0/EDu4lKnHLFvSdyvj/mRMDbjqgc3
	 krjsI6LDwnD/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Irlanki Sandeep" <irlanki.s@samsung.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910085916.95967-1-irlanki.s@samsung.com>
References: <CGME20260910085832epcas5p37c9dd9e559148f9408b581c06f5e0cbc@epcas5p3.samsung.com>
 <20260910085916.95967-1-irlanki.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:58:46 +0000
Message-Id: <20260911085847.37AA11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The per-socket TCP_ECN configuration is ignored during SYN floods =
because SYN cookie verification directly reads the global sysctl instead of=
 using the listener socket's ECN override.
- [Medium] Missing READ_ONCE() when reading lockless socket fields `ecn_mod=
e` and `ecn_option` in helper functions, creating a data race that can inco=
rrectly expose the internal `TCP_ECN_MODE_UNSPEC` (255) sentinel to TCP log=
ic.
--

commit 6ac47f63644768120d019b76c7e3a3788a53bb07
Author: Irlanki Sandeep <irlanki.s@samsung.com>

tcp: add TCP_ECN and TCP_ECN_OPTION socket options

This patch introduces two new TCP socket options (TCP_ECN and
TCP_ECN_OPTION) to allow per-connection dynamic adaptation of ECN modes
and AccECN option sending frequency. Helper functions are provided to
dynamically evaluate the per-socket overrides, falling back to system
defaults when unspecified.

> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 865d5c5a7718d..931e0877176c7 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -30,8 +31,29 @@ enum tcp_accecn_option {
>  	TCP_ACCECN_OPTION_MINIMUM =3D 1,
>  	TCP_ACCECN_OPTION_FULL =3D 2,
>  	TCP_ACCECN_OPTION_PERSIST =3D 3,
> +	TCP_ACCECN_OPTION_UNSPEC =3D 255,	/* Use sysctl default (per-socket) */
>  };
> =20
> +/* Resolve the effective ECN mode: per-socket override or sysctl fallbac=
k */
> +static inline u8 tcp_ecn_mode_eff(const struct sock *sk)
> +{
> +	u8 mode =3D tcp_sk(sk)->ecn_mode;
> +
> +	if (mode =3D=3D TCP_ECN_MODE_UNSPEC)

[Severity: Medium]
Could this lockless read of tcp_sk(sk)->ecn_mode result in the compiler
reloading the value from memory after the check?

If a concurrent setsockopt updates the mode to 255 (TCP_ECN_MODE_UNSPEC), a
reload could cause this helper to return 255 to the caller.

In tcp_ecn_create_request(), returning 255 would cause
tcp_ecn_mode_eff(listen_sk) >=3D 3 to evaluate to true, incorrectly activat=
ing
AccECN for an incoming connection even though the socket state and sysctl
fallback might dictate it should be disabled (0).

Should tcp_sk(sk)->ecn_mode be read with READ_ONCE() here?

> +		return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
> +	return mode;
> +}
> +
> +/* Resolve the effective AccECN option: per-socket override or sysctl fa=
llback */
> +static inline u8 tcp_accecn_option_eff(const struct sock *sk)
> +{
> +	u8 opt =3D tcp_sk(sk)->ecn_option;
> +
> +	if (opt =3D=3D TCP_ACCECN_OPTION_UNSPEC)

[Severity: Medium]
Similarly, should this read of tcp_sk(sk)->ecn_option use READ_ONCE() to
prevent a compiler reload from exposing the 255 sentinel value during a
concurrent setsockopt?

> +		return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
> +	return opt;
> +}
> +

[ ... ]

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0f60a1dbf9274..0043b4b2bc922 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7457,13 +7457,12 @@ static void tcp_ecn_create_request(struct request=
_sock *req,
>  				   const struct dst_entry *dst)
>  {
>  	const struct tcphdr *th =3D tcp_hdr(skb);
> -	const struct net *net =3D sock_net(listen_sk);
>  	bool th_ecn =3D th->ece && th->cwr;
>  	bool ect, ecn_ok;
>  	u32 ecn_ok_dst;
> =20
>  	if (tcp_accecn_syn_requested(th) &&
> -	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >=3D 3 ||
> +	    (tcp_ecn_mode_eff(listen_sk) >=3D 3 ||

[Severity: High]
Does this per-socket TCP_ECN configuration need to be applied to SYN cookies
as well?

Currently, cookie_ecn_ok() in include/net/tcp.h hardcodes reading the global
sysctl:

	return READ_ONCE(net->ipv4.sysctl_tcp_ecn) ||
		dst_feature(dst, RTAX_FEATURE_ECN);

When under a SYN flood, cookie_v4_check() in net/ipv4/syncookies.c calls it:

	ireq->ecn_ok &=3D cookie_ecn_ok(net, &rt->dst);

This clears the valid decoded ecn_ok state if the global sysctl is disabled,
regardless of what the listener socket explicitly requested. Similarly,
cookie_v6_check() in net/ipv6/syncookies.c exhibits the same behavior:

	ireq->ecn_ok &=3D cookie_ecn_ok(net, dst);

Could this cause connections established during a SYN flood to ignore the
listener socket's TCP_ECN configuration, potentially resulting in ECN
blackholing or total connection failures if the fallback system sysctl is
incompatible with the path?

>  	     tcp_ca_needs_accecn(listen_sk))) {
>  		inet_rsk(req)->ecn_ok =3D 1;
>  		tcp_rsk(req)->accecn_ok =3D 1;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910085916.9596=
7-1-irlanki.s@samsung.com?part=3D1
