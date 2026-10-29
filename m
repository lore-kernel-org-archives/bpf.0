Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301168;
	b=Zv6PjlS9AIBU5ay4Ge2VwIKQ0cORExhyCtilXzMQcRNloX2k4ewQBtFdtcW8h9XtRTuz
	 UisiJ5dZ/oTINk5yHm/x3cji50GdhM4/5fws8Exnm64DVjfQIH0DDZIh3UK4OKn8fFkka
	 NRN1UtXiSlEoQ69wTMElyZ/LjNRIIeBgq1CUqcGR2gysF1S8gTWOCeoN33Qu3OY2Qr4FC
	 JGah/M/mf/tNmKIqFdYqfXIP9O3PKXO9zW3IYcMrAg9Qq7VnRzJ5jzW5Ic2/h6GZgN4/2
	 J/AfSL+udoAjI+Gj6SF1Y7cg/p5KTVm5dkkcn62G7h4Qnrh9iEmtSXgAb1Xx6nBY2oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m6GDrLl66odSMl+xTPokzonWFt9jc7/jOLpsdSOeevs=;
	b=O0aENFiwix4djjHMOOVEWMxmgPO33YjqYYigcEUbJHC5TFAjLKaiLKEL3OLR/DLUBIXJ
	 Z2jJrpJ+518v0b0kxvawjFSz8pnWxzMqCkYBXWsWCmtLFNRIA5rV1BjzDVZFith+KbdPV
	 u/LdVtdaTBJiwC2V8u4aKMrr7RvC+J6ceh6TN9NnqXzII8jrCjb67RA8HELh/6MFPDaTh
	 rrSqBY4cKS7wX2z1T4cfGEWYNfqyao3VRSsq7t9AzpMx1pqR7PoZri/DfZxRh2U9brGzW
	 LmJjs4Pczh4nZuocr8k3J777gRLu9mddipLZAnQjFzgd/3FzR5Cl1O0u4ezpxx4UsKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHooeR1C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B6606A31D
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHooeR1C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575171F01816;
	Thu, 29 Oct 2026 19:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301167;
	bh=m6GDrLl66odSMl+xTPokzonWFt9jc7/jOLpsdSOeevs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHooeR1C+6D89OORkcS71ZX6dON5t6bZkBPzKkIWdiWacz3a471870X6wgrzSY9wD
	 cEJwAg9kNA7aD/WhONRQ8iaupJi5Yu2fYXpKTcujBP+5UC8GziN14yDhVoiAzFVAUW
	 N6W08GUKv5PTfXbvbZQSwSJZS3M82WQppLWfatiX1e2UYvYgOwecISG+YjPEnALEPh
	 BtrGdZZvbz3FKuUYYD4ua5UfOV5pZbYD8/O1BML4cksT2fEmo5oyAIPmu+hplVIBaT
	 BQnXxJG1Eb12Q6zeO/nYT6PnVteNJIS8YQH60Y8QKIKZJrfowVvtxOv9ZhU5/ntOF+
	 z2mzSW5JUlgAQ==
Message-ID: <sashiko-outbox-189854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/3] net/ipv6: don't route packets with unknown
 source address
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261028191103.623156-3-ihuguet@riseup.net>
References: <20261028191103.623156-1-ihuguet@riseup.net>
 <20261028191103.623156-3-ihuguet@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:12:46 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] net/ipv6: uninitialized fib_result in ip6_is_local_saddr()
- [Medium] sctp: missing flowi6_flags initialization in sctp_v6_get_dst()
--

commit a60f53e33acaf53f5beb0a9e9e20fd1e7c8f5aac
Author: =C3=8D=C3=B1igo Huguet <ihuguet@riseup.net>

net/ipv6: don't route packets with unknown source address

This patch prevents routing outbound IPv6 packets when the source address
is not configured on the host (with a fallback to FIB local routes for
loopback subnets), unless FLOWI_FLAG_ANYSRC is set in flowi6_flags.

[ ... ]

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 25fe0ba98b1a6..8715cf43f00ac 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1134,6 +1134,33 @@ static struct dst_entry *ip6_sk_dst_check(struct s=
ock *sk,
>  	return dst;
>  }
> =20
> +/* Check if the address belongs to the host */
> +static bool ip6_is_local_saddr(struct net *net, struct in6_addr *saddr)
> +{
> +	struct fib6_result fib_result;
> +	struct flowi6 fl6;
> +	bool result;
> +
> +	if (ipv6_chk_addr_namespace(net, saddr) ||
> +	    ipv6_chk_acast_addr_src(net, NULL, saddr))
> +		return true;
> +
> +	/* Fallback to FIB local routes so that loopback subnets work. */
> +	memset(&fl6, 0, sizeof(fl6));
> +	fl6.daddr =3D *saddr;
> +	result =3D false;
> +
> +	rcu_read_lock();
> +	if (fib6_lookup(net, 0, &fl6, &fib_result, 0) =3D=3D 0 &&
> +	    fib_result.fib6_type =3D=3D RTN_LOCAL &&
> +	    fib_result.nh->nh_common.nhc_dev) {
> +		result =3D true;
> +	}
> +	rcu_read_unlock();
> +
> +	return result;
> +}

[Severity: Critical]
Should fib_result be zero-initialized in ip6_is_local_saddr() before
calling fib6_lookup()?

In net/ipv6/ip6_output.c, ip6_is_local_saddr() declares fib_result on the
stack without initializing it, leaving fib_result.rt6 with uninitialized
stack data.

When custom IPv6 FIB rules are present (net->ipv6.fib6_has_custom_rules is
true), fib6_lookup() in net/ipv6/fib6_rules.c calls fib_rules_lookup() with
arg.lookup_ptr =3D fib6_table_lookup and arg.result =3D &fib_result:

net/ipv6/fib6_rules.c:fib6_lookup() {
	if (net->ipv6.fib6_has_custom_rules) {
		struct fib_lookup_arg arg =3D {
			.lookup_ptr =3D fib6_table_lookup,
			.lookup_data =3D &oif,
			.result =3D res,
			.flags =3D FIB_LOOKUP_NOREF,
		};
		...
		err =3D fib_rules_lookup(net->ipv6.fib6_rules_ops,
				       flowi6_to_flowi(fl6), flags, &arg);

During rule evaluation, fib_rules_lookup() in net/core/fib_rules.c invokes
fib6_rule_action() -> fib6_rule_action_alt() -> fib6_table_lookup() ->
rt6_select(). In net/ipv6/route.c, rt6_select() and __find_rr_leaf() only
populate res->f6i, res->nh, res->fib6_flags, and res->fib6_type, leaving
res->rt6 untouched.

When fib6_rule_action() returns 0, fib_rules_lookup() then calls
fib6_rule_suppress() in net/ipv6/fib6_rules.c:

net/ipv6/fib6_rules.c:fib6_rule_suppress() {
	struct fib6_result *res =3D arg->result;
	struct rt6_info *rt =3D res->rt6;
	struct net_device *dev =3D NULL;

	if (!rt)
		return false;

	if (rt->rt6i_idev)
		dev =3D rt->rt6i_idev->dev;

	if (rt->rt6i_dst.plen <=3D rule->suppress_prefixlen)
		goto suppress_route;

Because fib_result.rt6 is uninitialized, any non-zero stack value causes
fib6_rule_suppress() to dereference rt->rt6i_idev and rt->rt6i_dst.plen,
and potentially call ip6_rt_put_flags() on an arbitrary stack address.

> @@ -1191,6 +1218,17 @@ static int ip6_dst_lookup_tail(struct net *net, co=
nst struct sock *sk,
>  	if (err)
>  		goto out_err_release;
> =20
> +	/* From RFC 4862, "an invalid address MUST NOT be used as the source
> +	 * address of outbound packets". Exceptions to this must set the ANYSRC
> +	 * flag (i.e. transparent sockets).
> +	 */
> +	if (!ipv6_addr_any(&fl6->saddr) &&
> +	    !(fl6->flowi6_flags & FLOWI_FLAG_ANYSRC) &&
> +	    !ip6_is_local_saddr(net, &fl6->saddr)) {
> +		err =3D -ENETUNREACH;
> +		goto out_err_release;
> +	}
> +
>  #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
>  	/*
>  	 * Here if the dst entry we've looked up

[Severity: Medium]
Does sctp_v6_get_dst() in net/sctp/ipv6.c also need to set
fl6->flowi6_flags =3D inet_sk_flowi_flags(sk) so that transparent IPv6 SCTP
sockets continue to work with this check?

IPv6 SCTP supports IPV6_TRANSPARENT and allows binding to non-local IPv6
addresses via sctp_inet6_bind_verify() -> sctp_v6_available():

net/sctp/ipv6.c:sctp_v6_available() {
	...
	res =3D ipv6_can_nonlocal_bind(net, &sp->inet) ||
	      ipv6_chk_addr(net, in6, dev, 0);

However, in net/sctp/ipv6.c, sctp_v6_get_dst() zero-initializes _fl and
calls ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p) without setting
fl6->flowi6_flags from inet_sk_flowi_flags(sk):

net/sctp/ipv6.c:sctp_v6_get_dst() {
	...
	memset(&_fl, 0, sizeof(_fl));
	...
	dst =3D ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
	...
		fl6->saddr =3D laddr->a.v6.sin6_addr;
		fl6->fl6_sport =3D laddr->a.v6.sin6_port;
		final_p =3D fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
		bdst =3D ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);

Because FLOWI_FLAG_ANYSRC is not set in fl6->flowi6_flags, outbound route
lookups for an IPv6 SCTP socket with IPV6_TRANSPARENT bound to a non-local
address will now fail in ip6_dst_lookup_tail() with -ENETUNREACH.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028191103.6231=
56-1-ihuguet@riseup.net?part=3D2
