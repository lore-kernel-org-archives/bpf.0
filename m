Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E9480DED
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523921; cv=none; b=Q6AMElszn++GsLNFiup8TbueYsx0HA9s5fcxXh7oz8F5+SXlQVRssWPbTZ27CYE80OcKn5NTwVrEkovekEzn+kvGD2znE3HgG+hFPIC66aEj7iAu5RAPZr1zmeDZLq+C2rs5ikzSmCiIZPuu1B3nooKnL94BC0i3Ej3sfijXFhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523921; c=relaxed/simple;
	bh=yqsoGo1qAllHKRgaSnedg3Jtb7++k8BDRKoTr0FC34A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GG2YnsE1+JKu2vASPgDFQdYFewWp62+2LNdVZ7gUyjs386ybVplOy8585oV46qASDZ2RLNpUdo3U+QDJRl7UvVa3DtQM0oUOXsl5OGprowvTJ/A4ki27mQEvKprEWOrBwPU0+tliFGDox50+fjWitvCSpW6UAmJOX1z5+DmA4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/4axugv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/4axugv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5CE1F00A3D;
	Fri,  4 Sep 2026 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788523919;
	bh=YepaPjBZVB6yj3uBDeF1ssnlAh/NHNPkROXoXwq7wl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c/4axugv1AsEeb1TDwxJ5Acsn3hRyOj3k0vLZ0VHDN0N+8U8OjRxfv/AoiEXi9Z/P
	 kiNh7gbeFvH4Sqhq3kqH0YHf+1ES+51w4OyppMRTLe1/2DxZSjS9F5OxuO2PRUSR5k
	 cCZnkMWSK9PHqkp5/mjK9cLYPg2vMroW48Qj0NWpW9sWt7n5p3/YF73E4HvNLweJ9G
	 z2TkRO78r6wtdd/p58ZNTolpvMqmlBaxqx/NFlBLu9ScLmk0TAz15/Q1soqQtTHvG9
	 vpOh/xlvH0lY6sv11hDXvCf6qOvbGpkPZCuO5fwDSQK0hPvmvbsduoGq7eZODWE0DX
	 HlnVTqph5l4eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/ipv6: don't route packets with unknown
 source address
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903121057.80006-1-ihuguet@riseup.net>
References: <20260903121057.80006-1-ihuguet@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 12:11:58 +0000
Message-Id: <20260904121159.2D5CE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Link-Local Multicast addresses bypass source address clearing in `=
ip6_route_me_harder`.
- [High] TCP resets and ACKs from IPv6 transparent request (NEW_SYN_RECV) a=
nd TIME_WAIT sockets are dropped due to missing FLOWI_FLAG_ANYSRC.
- [High] SCTP IPv6 transparent sockets are broken because `FLOWI_FLAG_ANYSR=
C` is not set in `sctp_v6_get_dst`.
--

commit 0afe460974f748f250f2af7329befb04fd3c1e35
Author: =C3=8D=C3=B1igo Huguet <ihuguet@riseup.net>
Subject: net/ipv6: don't route packets with unknown source address

This commit prevents outbound IPv6 packets from being routed if their source
address is not configured on the host, aligning the behavior with the IPv4
stack. It adds source address validation to ip6_dst_lookup_tail and applies
the FLOWI_FLAG_ANYSRC flag in various protocol handlers to allow certain
cases like transparent sockets.

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 8fc4766c8da90..a83ca449e3089 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1191,6 +1191,34 @@ static int ip6_dst_lookup_tail(struct net *net, co=
nst struct sock *sk,
>  	if (err)
>  		goto out_err_release;
> =20
> +	/* Routing packets with a src addr not present in the host is not
> +	 * allowed unless the ANYSRC flag is set (i.e. with transparent socket).
> +	 * The address must be in the same L3 domain as the destination device.
> +	 */
> +	if (!ipv6_addr_any(&fl6->saddr) &&
> +	    !(fl6->flowi6_flags & FLOWI_FLAG_ANYSRC)) {
> +		struct net_device *oif_dev;

[Severity: High]
Does this new validation block break SCTP IPv6 transparent sockets?

In net/sctp/ipv6.c, sctp_v6_get_dst() calls ip6_dst_lookup_flow() but
was not updated in this patch to set fl6.flowi6_flags =3D inet_sk_flowi_fla=
gs(sk).

Since this new check blocks non-local source addresses unless FLOWI_FLAG_AN=
YSRC
is set, will a transparent SCTP socket attempting to route a packet with a
foreign source address now be incorrectly rejected here?

> +
> +		rcu_read_lock();
> +		/* For local routes (*dst)->dev can be 'lo', which has no l3mdev
> +		 * master, so that the L3 domain wouldn't match if the source
> +		 * address is in a VRF-enslaved device. To avoid that, check the
> +		 * outgoing interface from the flowi6 structure instead.
> +		 */
> +		if (fl6->flowi6_oif)
> +			oif_dev =3D dev_get_by_index_rcu(net, fl6->flowi6_oif);
> +		else
> +			oif_dev =3D (*dst)->dev;
> +
> +		if (!ipv6_chk_addr_and_flags(net, &fl6->saddr, oif_dev,
> +					     1, 1, IFA_F_TENTATIVE))
> +			err =3D -ENETUNREACH;
> +		rcu_read_unlock();
> +
> +		if (err)
> +			goto out_err_release;
> +	}
> +
[ ... ]
> diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
> index a7025ec870359..716fc6e246de9 100644
> --- a/net/ipv6/netfilter.c
> +++ b/net/ipv6/netfilter.c
[ ... ]
> @@ -41,6 +42,12 @@ int ip6_route_me_harder(struct net *net, struct sock *=
sk_partial, struct sk_buff
>  	};
>  	int err;
> =20
> +	fl6.flowi6_flags =3D sk ? inet_sk_flowi_flags(sk) : 0;
> +	if (saddr_type & (IPV6_ADDR_UNICAST | IPV6_ADDR_LINKLOCAL))
> +		fl6.flowi6_flags |=3D FLOWI_FLAG_ANYSRC;
> +	else
> +		fl6.saddr =3D in6addr_any;

[Severity: High]
Does this logic incorrectly evaluate to true for Link-Local Multicast
addresses?

If ipv6_addr_type() returns IPV6_ADDR_MULTICAST | IPV6_ADDR_LINKLOCAL
for an address like ff02::1, the bitmask check:

saddr_type & (IPV6_ADDR_UNICAST | IPV6_ADDR_LINKLOCAL)

will evaluate to true due to the IPV6_ADDR_LINKLOCAL bit being set.

Will this mistakenly apply FLOWI_FLAG_ANYSRC to link-local multicast
addresses, bypassing the in6addr_any clearing intended to sanitize
invalid source IPs?

> +
>  	if (sk && sk->sk_bound_dev_if)
>  		fl6.flowi6_oif =3D sk->sk_bound_dev_if;
>  	else if (strict)
[ ... ]
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index df9c29eb5c1f4..ae69e71b08598 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
[ ... ]
> @@ -979,6 +980,7 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
>  	fl6.fl6_dport =3D t1->dest;
>  	fl6.fl6_sport =3D t1->source;
>  	fl6.flowi6_uid =3D sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
> +	fl6.flowi6_flags =3D sk && sk_fullsock(sk) ? inet_sk_flowi_flags(sk) : =
0;

[Severity: High]
Can this inadvertently drop TCP resets and ACKs from IPv6 transparent
sockets in TIME_WAIT or NEW_SYN_RECV states?

When tcp_v6_send_response() is called for these states, sk_fullsock(sk)
evaluates to false. As a result, FLOWI_FLAG_ANYSRC is not applied.

Later, when ip6_dst_lookup_tail() validates the transparent (foreign)
source address without the ANYSRC flag, won't it reject the packet and
return -ENETUNREACH, breaking connection teardown and SYN-ACK responses?

>  	security_skb_classify_flow(skb, flowi6_to_flowi_common(&fl6));
> =20
>  	/* Pass a socket to ip6_dst_lookup either it is for RST

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903121057.8000=
6-1-ihuguet@riseup.net?part=3D1
