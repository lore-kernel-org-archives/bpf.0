Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793449255;
	b=euCldbniBrPxvVqKXU+5trXEumvnFAsYixiBq5XOl6G1k9SasPrVidcKQi5+GpOLLwuE
	 hD3rxwbOuuLWMW9VgYSZKOXAcsSZzM+RBaUb7TNoEChqYXBTqn+xP0m19zLpwVf2fADOE
	 ek7H6owvfg7Mj3c76ZNYDTWo1NR67rjlmPwNJe97a0PbQFHlygZQqG0ijdFuYKj2C91+r
	 PbQ9Ir0iBL72NeDrYmF7UBkGoqO9jdpk3mdGnoNj8ihRBgKx74RGZ476x3QaqU6VZ9reL
	 ieEuY51q3jU1d8ygz65zLwHJ70pIH4TI4xrDlXseT+fQRGYSoIOIjNMZO96C308JlRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793449255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xykgHgQQ2YmtsvbfOVMQIdquXAxykERN6E4P9IXEmXw=;
	b=Dz0z+TefHtDAswNukF2yQkCsEtvPogR2cacGp8r2hQWHgMOPdOWv1QvNu8bx+Vf8xUF1
	 vTcD0GM+di410mH6RRl1Wi0M0laj/HlgWRf6/dOaKMzWbPDLKtsH1UqfCMwpKjigQ8Rkd
	 fE5AemXQjnVvqXShm58O2HFG9e7Ov0JGDOHd/QcTCX0x1KKQ6BpJEypkF6VDsXG+AB6VU
	 JOIfFbhFy8VoA0HXJ1ImExtSeCDxytPpWDFdL1EvfczWZJSR3YYE2xo44sZoXC8OozIzQ
	 dW8wDh7w2099q1aX5y9sTYO6x1YGljM8MJpnTqT0JNZn3EHzMcJGO7EUU32Xmv8FyFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+uOG0V3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F23606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+uOG0V3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E874D1F000C1;
	Sat, 31 Oct 2026 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793449255;
	bh=xykgHgQQ2YmtsvbfOVMQIdquXAxykERN6E4P9IXEmXw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+uOG0V3si8opR0VRYvWWFljov2IQGgig6m8vvRcVazYdatt14qoTIyxz4nWHy2kK
	 din4BI03TyDEHb0CS4DMQzOKIqi3UmXEPQ5YQPkohgCJxkqnDyCh4EgWOhJvLohagO
	 aK6ng2fMVtMWrf1JKWb1GmaxT94Rkizr2vUrJvXUVbK+BpbRKDOhFQiK0o6D3Zk3KJ
	 MgoMpfbRJ4OWJpTwWNvr5ffVBII3aZ6I9LEiIgSDC809Z/imaox33l79BvqqtSFuOK
	 DbVQpYbtAiKSZBAcRmxLgttxLAv/zYRRDyBWRojbwFLNaY9m/X6ynuNpH1ZHINh2n6
	 KGMzKS8mqUAFg==
Message-ID: <sashiko-outbox-191936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and
 secondary hash tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261030122045.3035709-1-edumazet@kernel.org>
References: <20261030122045.3035709-1-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 12:20:54 +0000
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
- [Medium] udp: tail insertion in udp_lib_get_port() defeats hlist_nulls re=
start check
--

commit f98bb6c6e4827227f9083bb5452ae79a7eeaa175
Author: Eric Dumazet <edumazet@kernel.org>

udp: restore hlist_nulls for primary and secondary hash tables

This commit restores hlist_nulls for the primary (udptable->hash) and
secondary (udptable->hash2) UDP socket hash tables so lockless RCU readers
can detect when a socket is concurrently unhashed or moved to another
bucket and restart the lookup.

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 173b37b2b8bb0..6140244735b55 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
[ ... ]
> @@ -932,7 +932,11 @@ static inline void __sk_nulls_add_node_tail_rcu(stru=
ct sock *sk, struct hlist_nu
>  static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_n=
ulls_head *list)
>  {
>  	sock_hold(sk);
> -	__sk_nulls_add_node_rcu(sk, list);
> +	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
> +	    sk->sk_family =3D=3D AF_INET6)
> +		__sk_nulls_add_node_tail_rcu(sk, list);
> +	else
> +		__sk_nulls_add_node_rcu(sk, list);
>  }
> =20
>  static inline void __sk_del_bind_node(struct sock *sk)
[ ... ]
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 303d0102519ac..7d3790550241f 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
[ ... ]
> @@ -324,7 +327,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short =
snum,
> =20
>  		sock_set_flag(sk, SOCK_RCU_FREE);
> =20
> -		sk_add_node_rcu(sk, &hslot->head);
> +		sk_nulls_add_node_rcu(sk, &hslot->head);
>  		hslot->count++;
>  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> =20
> @@ -332,11 +335,11 @@ int udp_lib_get_port(struct sock *sk, unsigned shor=
t snum,
>  		spin_lock(&hslot2->lock);
>  		if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
>  		    sk->sk_family =3D=3D AF_INET6)
> -			hlist_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
> -					   &hslot2->head);
> +			hlist_nulls_add_tail_rcu(&udp_sk(sk)->udp_portaddr_node,
> +						 &hslot2->head);
>  		else
> -			hlist_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
> -					   &hslot2->head);
> +			hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
> +						 &hslot2->head);
>  		hslot2->count++;
>  		spin_unlock(&hslot2->lock);
>  	}

[Severity: Medium]
Can the tail insertions in sk_nulls_add_node_rcu() and udp_lib_get_port()
still defeat the get_nulls_value() restart check when a live AF_INET6
SO_REUSEPORT socket is unhashed and re-hashed?

In udp_lib_rehash(), head insertion is used unconditionally with the commen=
t:

	/* Note: head insertion is required here, so
	 * that a lockless reader parked on this socket
	 * restarts from the head of the new chain
	 * instead of hitting a nulls marker early.
	 */
	hlist_nulls_add_head_rcu(&udp_sk(sk)->udp_portaddr_node,
				 &nhslot2->head);

However, a live AF_INET6 SO_REUSEPORT socket bound without SOCK_BINDPORT_LO=
CK
(for example via autobind in connect() or sendmsg(), or bind() with port 0,
or when BPF_CGROUP_RUN_PROG_INET6_POST_BIND fails in __inet6_bind()) can al=
so
be unhashed without an RCU grace period via __udp_disconnect() ->
udp_lib_unhash(), and then immediately re-inserted via bind() or connect() =
->
udp_lib_get_port().

If bucket S contains:

	head -> sk1 -> sk2 -> NULLS_MARKER(S)

and a lockless reader in udp4_lib_lookup1(), udp4_lib_lookup2(),
udp6_lib_lookup1(), udp6_lib_lookup2(), or __udp4_lib_mcast_demux_lookup() =
is
parked on sk1 while sk1 is unhashed and re-inserted into the same bucket S
(or if a reader in bucket S jumps via a moved socket into another bucket and
lands on a socket that is concurrently unhashed and tail-inserted into buck=
et
S), __sk_nulls_add_node_tail_rcu() and hlist_nulls_add_tail_rcu() place sk1
at the end of bucket S:

	head -> sk2 -> sk1 -> NULLS_MARKER(S)

and overwrite sk1's next pointer with NULLS_MARKER(S). When the reader
resumes and advances past sk1, it immediately hits NULLS_MARKER(S) with
get_nulls_value(node) =3D=3D S, so the restart check passes and the lookup
terminates early without ever visiting sk2.

Also, in the primary hash table (udptable->hash), udp4_lib_lookup1() and
udp6_lib_lookup1() always score every socket in hslot->head and do not use
inet_lookup_reuseport() or inet6_lookup_reuseport(), so tail insertion in
sk_nulls_add_node_rcu() does not appear to help reuseport selection on
hslot->head.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030122045.3035=
709-1-edumazet@kernel.org?part=3D1
