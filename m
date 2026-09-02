Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477647FAF2
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349885; cv=none; b=Uy22XD4/Io3Vru9pcKgpdM8IZhYpBxsg9RS/UexYk5a28/T6deBAJj48bQh28tu0f01PthSv7IQgLJOwnybiHb+PPb/Ypn8YtcRch+zZkSUZsqO21MXc9o08CQgdxNvS5pDfeAC0LVeUBxAsf6LC6A1T4UG0Y3vZ95wne05RDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349885; c=relaxed/simple;
	bh=3ZRQ+cvPIdI0Sc08rygqkJdgSC2MwypM94Da2qYY6oM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E+WzjaoA205nwxR3cgv1Ab66ldiPdn8tjDnOo4ZXxrm3B+auWcZx3xC/e3zQhjaC4yR7yEGdQn1r0A6PGMDZ/lFtUiQn7BlhHj5c3t+GJXHW7jqKsnxBC+Uq5zLKEmR+/VBTFH5t5dkZ6Pahmeb0X4gXDvvtyig4OL7zdxJsaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYm8AaW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYm8AaW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC961F000E9;
	Wed,  2 Sep 2026 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788349871;
	bh=g5X8cyvmKzVQhx1GxPIXZgkQ0kSLk1p2OcrHbe3XXqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QYm8AaW09G91tgv0NsPFMSi6xzCW2Ti3LQxc+u3FNe3Z3GZhv3qKhdhCcVg8BnezS
	 EhQN7uLHD1387sVohRpFgXjDQKV8sH2kxYBR7OgA9zXGL5QDCQILjHFCQX/jYVqsBD
	 bV8TWwDiyUvsOlkbgtpGV76BIzh6YgkoLv2+MuY/FQgYTFevu7SmoUFrCCFdTdVhBb
	 cnXrmrFCU9rkIMYhulvdde38EoHHwluvRsdtsxg+zwSf6cLZO9qpGSSvKn1Z0Sa6St
	 V5NaiUPdTKNUgPUKSV7QR9Avma1EUGksGFiPK6dG1AWcdK1zH2YoxKmtZWkiyz6dCc
	 U6GTF/2feOtGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/ipv6: don't route packets with unknown source
 address
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901115021.50057-1-ihuguet@riseup.net>
References: <20260901115021.50057-1-ihuguet@riseup.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:51:10 +0000
Message-Id: <20260902115111.2DC961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] tcp_v6_send_response() calls inet_sk_flowi_flags() on TIME_WAI=
T sockets, resulting in an out-of-bounds memory read.
- [High] ip6_route_me_harder() incorrectly checks the destination address t=
ype instead of the source address type, zeroing the source address for mult=
icast packets and bypassing security checks for unicast.
- [High] IPv6 SCTP transparent sockets are broken because FLOWI_FLAG_ANYSRC=
 is not set during route lookup.
- [High] tcp_v6_connect() overwrites flowi6_flags, inadvertently dropping F=
LOWI_FLAG_ANYSRC for transparent sockets when multipath routing is enabled.
--

commit 4450c087e2afc1b6d2ec6336ee396246ee37e850
Author: =C3=8D=C3=B1igo Huguet <ihuguet@riseup.net>

    net/ipv6: don't route packets with unknown source address
   =20
    Don't allow routing packets with a source address that is not configured
    in the host. Allow it only in certain cases like when using a
    transparent socket, by setting the ANYSRC flag in flowi_flags.

> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 8fc4766c8da90..57eebe347902b 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1191,6 +1191,34 @@ static int ip6_dst_lookup_tail(struct net *net, co=
nst struct sock *sk,
>  	if (err)
>  		goto out_err_release;
> =20
> +	/* Routing packets with a source address not present in the host is
> +	 * disallowed unless the ANYSRC flag is set (i.e. with transparent sock=
ets).
> +	 * The source address must be in the same L3 domain as the destination =
device.
> +	 */
> +	if (!ipv6_addr_any(&fl6->saddr) &&
> +	    !(fl6->flowi6_flags & FLOWI_FLAG_ANYSRC)) {

[Severity: High]
Will this break IPv6 SCTP transparent sockets?

SCTP sockets using IP_TRANSPARENT with a non-local source address fail to r=
oute
packets because sctp_v6_get_dst() initializes flowi6 but does not set
flowi6_flags using inet_sk_flowi_flags(sk). As a result, the check here
rejects the packet due to the missing FLOWI_FLAG_ANYSRC flag.

[ ... ]

> diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
> index a7025ec870359..7c19ecbec112e 100644
> --- a/net/ipv6/netfilter.c
> +++ b/net/ipv6/netfilter.c
> @@ -41,6 +41,12 @@ int ip6_route_me_harder(struct net *net, struct sock *=
sk_partial, struct sk_buff
>  	};
>  	int err;
> =20
> +	fl6.flowi6_flags =3D sk ? inet_sk_flowi_flags(sk) : 0;
> +	if (daddr_type & (IPV6_ADDR_UNICAST | IPV6_ADDR_LINKLOCAL))
> +		fl6.flowi6_flags |=3D FLOWI_FLAG_ANYSRC;
> +	else
> +		fl6.saddr =3D in6addr_any;

[Severity: High]
Does this logic mistakenly check the destination address type instead of the
source address?

Checking daddr_type here causes the source address to be zeroed out for
multicast traffic, breaking multicast routing. It also bypasses the newly
added anti-spoofing checks for unicast traffic.

[ ... ]

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index df9c29eb5c1f4..401a1297e7dba 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -268,6 +268,7 @@ static int tcp_v6_connect(struct sock *sk, struct soc=
kaddr_unsized *uaddr,
>  	fl6->flowi6_mark =3D sk->sk_mark;
>  	fl6->fl6_dport =3D usin->sin6_port;
>  	fl6->fl6_sport =3D inet->inet_sport;
> +	fl6->flowi6_flags =3D inet_sk_flowi_flags(sk);
>  	if (IS_ENABLED(CONFIG_IP_ROUTE_MULTIPATH) && !fl6->fl6_sport)
>  		fl6->flowi6_flags =3D FLOWI_FLAG_ANY_SPORT;

[Severity: High]
Is it intended to overwrite flowi6_flags and drop FLOWI_FLAG_ANYSRC?

If multipath routing is enabled (CONFIG_IP_ROUTE_MULTIPATH) and no source
port is bound, FLOWI_FLAG_ANY_SPORT is assigned using =3D instead of |=3D.
This drops the FLOWI_FLAG_ANYSRC flag, causing transparent sockets to fail
routing when attempting to connect.

[ ... ]

> @@ -979,6 +980,7 @@ static void tcp_v6_send_response(const struct sock *s=
k, struct sk_buff *skb, u32
>  	fl6.fl6_dport =3D t1->dest;
>  	fl6.fl6_sport =3D t1->source;
>  	fl6.flowi6_uid =3D sock_net_uid(net, sk && sk_fullsock(sk) ? sk : NULL);
> +	fl6.flowi6_flags =3D sk ? inet_sk_flowi_flags(sk) : 0;

[Severity: Critical]
Can this result in an out-of-bounds memory read?

Unlike the previous line which explicitly checks sk_fullsock(sk), this calls
inet_sk_flowi_flags(sk) directly. tcp_v6_send_response() can be invoked
with sk pointing to an inet_timewait_sock. inet_sk_flowi_flags() uses
inet_test_bit(TRANSPARENT, sk), casting the socket to struct inet_sock.
Since inet_timewait_sock is smaller than inet_sock, this reads past the
end of the socket allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901115021.5005=
7-1-ihuguet@riseup.net?part=3D1
