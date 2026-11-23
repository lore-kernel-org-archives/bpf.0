Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426151;
	b=5rO+Vga07z4dAfBP+neNxpNPa+fJHZ5J7jAb8mDBjReWgMuacIFhULslKpoRrso4B9pO
	 ujqvU3BE+gMJvakQlgL9sSjroHY2W2ak4cmWG9nfdwTKpGNx/NolJm2iqADIAQHSKfeS/
	 bo4Pvc/uKcjd5ThsdFj2VyqxcPUHP1sBPq31bwxrdhodQm6D7gqGAd8goSIToABnmG6DE
	 mwrUXLfygUVHc3ZchwttxParqZhMWpPr48bQyMH5E/VOwsi/8Za4FPYdNsYMwbRWsKw6Y
	 oi269es9oR009EzXmjwpp8QZKx5T1ybPF8T3YoZeCN6vXlgyqTltNdEimyt7uLxMivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HweZ1D6upucTVFzfMFDjA9bhYMQ/pDaA3YaZryk5Enc=;
	b=NK7Wvg1i66CCxrJv/+t1xo+5Wt4G2gspj3ojUkIWov0RO9w24x4WYjIhkkeU6yfKXr/5
	 KlQvzMIT6VJ11lb8Wwk5LfSoZSDN1LE/SYIaUU0zz3WDa3TFdpbcv6blaJqZspaEba4HO
	 L9fC9IiJ7v/6+Q6zGo2EYvnMfl3Cm/OEbOJ8oukO/+5ySHBvPNfao7pA1w//o9JIC34v7
	 gcj3Z5m8cDHrUGsr/1TIz7XXaNeADCzYF2GlM7vnLZS/eP/374/+/G5Uh68claNw7d3Q9
	 KuK5H5RAyFGlm3GckCkZZA19lRJ3e4dNfJrX0Q+C1z5aMba62XxS9tUM/sP41wrkeFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="S/skPY0G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD0606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S/skPY0G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6AB1F000CF;
	Mon, 23 Nov 2026 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795426150;
	bh=HweZ1D6upucTVFzfMFDjA9bhYMQ/pDaA3YaZryk5Enc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S/skPY0GMLc9DMRFu6DYIc7TtV0r211zAIMvLuNd9fQVQa9gbwaupvn8iFTpJiyV4
	 55z2Atz/kEMROG+X06pt+onkKPFqsHK8Xr/io1MSrrdXVwzrFNLjO6BTB5B/pS+d6c
	 aP0knVGS+Y+pXDKoVRvPNweyxbTKHhIkv8XFfayCiUvZOachNaOPHRLcQoCO92uExN
	 l3txHgcd804SfDf3ux9UD5SZTPSi2r2OWg9iPCMs0RCPaPbqjZAJhl4yhqrzUO9UYg
	 D3N0n+XX4siDbATY8EcL6qikkE37Wo0K25TU1+A/YR7tsaQ3Vy9FCoxlPMAeNrmxPn
	 98nHnfO5cgVyQ==
Message-ID: <sashiko-outbox-228972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf, net: validate assigned socket on receive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolay Aleksandrov" <razor@blackwall.org>, bpf@vger.kernel.org
In-Reply-To: <20261123084138.723275-2-razor@blackwall.org>
References: <20261123084138.723275-1-razor@blackwall.org>
 <20261123084138.723275-2-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 09:29:10 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] net: missing family check for non-fullsocks in
  inet[6]_prefetched_sk_mismatch()
- [High] net: missing v4-mapped check for AF_INET6 sockets in
  inet[6]_prefetched_sk_mismatch()
- [High] net: unvalidated syncookie request_sock left on skb->sk in
  inet[6]_steal_sock()
- [Medium] bpf, net: sk mismatch check bypassed in inet_steal_sock()
  after __nf_queue()
--

commit 2c31081df7649a22a023cb4c1f5a5c68555be5ac
Author: Nikolay Aleksandrov <razor@blackwall.org>

bpf, net: validate assigned socket on receive

This commit validates prefetched sockets in inet_steal_sock() and
inet6_steal_sock() against the caller's network namespace, address family,
and transport protocol, releasing the socket on mismatch.

> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 44b7e39a1245b..ad8a7af17ddbc 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -444,11 +444,24 @@ static inline struct sock *inet_lookup(struct net *=
net,
>  	return sk;
>  }
> =20
> +static inline bool inet_prefetched_sk_mismatch(const struct sock *sk,
> +					       const struct net *net,
> +					       u8 protocol)
> +{
> +	if (unlikely(!net_eq(sock_net(sk), net)))
> +		return true;
> +	if (!sk_fullsock(sk))
> +		return unlikely(protocol !=3D IPPROTO_TCP);

[Severity: High]
Does returning early for !sk_fullsock(sk) allow a request_sock or
timewait socket of the opposite address family through?

In inet_prefetched_sk_mismatch(), a native IPv6 TCP_NEW_SYN_RECV
request_sock (with rsk_ops =3D=3D &tcp6_request_sock_ops) or IPv6
TCP_TIME_WAIT socket passes without any family check.  Conversely, in
inet6_prefetched_sk_mismatch(), checking sk->sk_family !=3D AF_INET6 is not
sufficient for non-fullsocks because an IPv4 request_sock or timewait
socket created on a dual-stack AF_INET6 listener inherits sk_family =3D
AF_INET6 from sk_listener->sk_family in inet_reqsk_alloc() while using
&tcp_request_sock_ops and storing struct ip_options_rcu in ireq->ireq_opt.

When such an IPv4 request_sock is delivered to tcp_v6_rcv() ->
tcp_check_req(), tcp_v6_syn_recv_sock() reads ireq->ipv6_opt (which shares
a union with ireq->ireq_opt in struct inet_request_sock) and passes the
struct ip_options_rcu pointer to ipv6_dup_options().

[Severity: Critical]
This problem wasn't introduced by this patch, but in bpf_sk_assign()
[1] can an unreferenced BTF socket pointer be unhashed, freed, and
reallocated from a SLAB_TYPESAFE_BY_RCU cache between the pre-checks and
refcount_inc_not_zero_acquire()?

net/core/filter.c:bpf_sk_assign() {
    ...
	if (unlikely(dev_net(skb->dev) !=3D sock_net(sk)))
		return -ENETUNREACH;
	if (sk_unhashed(sk))
		return -EOPNOTSUPP;
	if (sk_is_refcounted(sk) &&
	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
		return -ENOENT;
}

CPU0 (bpf_sk_assign)              CPU1
--------------------              ----
checks sock_net(sk)
checks !sk_unhashed(sk)
                                  reqsk unhashed and freed
                                  reallocated in tcp_get_cookie_sock():
                                    req->rsk_listener =3D NULL
                                    refcount_set(&req->rsk_refcnt, 1)
refcount_inc_not_zero_acquire()
skb->sk =3D sk

When tcp_v4_rcv() or tcp_v6_rcv() steals skb->sk, inet_steal_sock()
accepts the TCP_NEW_SYN_RECV request_sock and tcp_v4_rcv() dereferences
the NULL rsk_listener pointer.  A reallocation during sk_clone() while
sock_copy() temporarily has SOCK_RCU_FREE set before inet_csk_clone_lock()
clears it also causes sk_is_refcounted(sk) to skip taking a reference that
sock_pfree() or skb_steal_sock() later drops, underflowing sk_refcnt.

> +	return unlikely(sk->sk_protocol !=3D protocol ||
> +			(sk->sk_family =3D=3D AF_INET6 && ipv6_only_sock(sk)));
> +}

[Severity: High]
Can a dual-stack AF_INET6 socket connected to a native IPv6 address still
pass inet_prefetched_sk_mismatch(), and can an IPv4-mapped AF_INET6 socket
still pass inet6_prefetched_sk_mismatch()?

Unlike bpf_sk_lookup_assign(), bpf_sk_assign() accepts connected and
connecting sockets.  When ipv6_only_sock(sk) is 0, an AF_INET6 TCP socket
connected to a native IPv6 address has icsk_af_ops =3D &ipv6_specific
(.sk_rx_dst_set =3D inet6_sk_rx_dst_set) and sk_backlog_rcv =3D tcp_v6_do_r=
cv.
If it is assigned to an IPv4 packet, inet_prefetched_sk_mismatch() allows
it into tcp_v4_rcv(), where tcp_v4_do_rcv() calls inet6_sk_rx_dst_set() on
the IPv4 skb, casting the IPv4 struct rtable to struct rt6_info in
rt6_get_cookie(), or queues the IPv4 skb to sk_backlog for tcp_v6_do_rcv().

Similarly, an AF_INET6 socket connected to an IPv4-mapped address has
sk_family =3D=3D AF_INET6 with icsk_af_ops =3D &ipv6_mapped and sk_backlog_=
rcv =3D
tcp_v4_do_rcv, so inet6_prefetched_sk_mismatch() allows it into
tcp_v6_rcv().

>  static inline
>  struct sock *inet_steal_sock(struct net *net, struct sk_buff *skb, int d=
off,
>  			     const __be32 saddr, const __be16 sport,
>  			     const __be32 daddr, const __be16 dport,
> -			     bool *refcounted, inet_ehashfn_t *ehashfn)
> +			     bool *refcounted, inet_ehashfn_t *ehashfn,
> +			     u8 protocol)
>  {
>  	struct sock *sk, *reuse_sk;
>  	bool prefetched;
> =20
>  	sk =3D skb_steal_sock(skb, refcounted, &prefetched);
>  	if (!sk)
>  		return NULL;
> =20
> -	if (!prefetched || !sk_fullsock(sk))
> +	if (!prefetched)
>  		return sk;

[Severity: Medium]
Does returning when !prefetched is true bypass the mismatch check after a
packet passes through NFQUEUE?

When a packet carrying a prefetched SOCK_RCU_FREE socket (such as a
TCP_LISTEN or UDP socket) is queued by __nf_queue(), __nf_queue() takes a
reference on sk and replaces skb->destructor =3D sock_pfree with
sock_edemux:

net/netfilter/nf_queue.c:__nf_queue() {
    ...
	if (skb_sk_is_prefetched(skb)) {
		struct sock *sk =3D skb->sk;

		if (!sk_is_refcounted(sk)) {
			if (!refcount_inc_not_zero(&sk->sk_refcnt))
				return -ENOTCONN;

			/* drop refcount on skb_orphan */
			skb->destructor =3D sock_edemux;
		}
	}
    ...
}

On reinjection, skb_steal_sock() sees skb->destructor !=3D sock_pfree and
sets prefetched =3D false, so inet_steal_sock() and inet6_steal_sock()
return the unvalidated socket before running
inet[6]_prefetched_sk_mismatch().

> -	if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
> +	if (unlikely(inet_prefetched_sk_mismatch(sk, net, protocol)))
> +		goto mismatch;

[Severity: High]
When skb->sk is a syncookie request_sock attached by
bpf_sk_assign_tcp_reqsk(), skb_steal_sock() returns req->rsk_listener as
sk while leaving the request_sock on skb->sk.  Does validating only the
listener sk leave a cross-family syncookie request_sock attached to
skb->sk?

If bpf_sk_assign_tcp_reqsk() attaches an IPv6 syncookie request_sock
(rsk_ops =3D=3D &tcp6_request_sock_ops) with a dual-stack AF_INET6 listener
and the packet is then decapsulated or rewritten to IPv4,
inet_prefetched_sk_mismatch() accepts the listener sk and leaves the IPv6
request_sock on skb->sk.  cookie_v4_check() then stores an IPv4 struct
ip_options_rcu pointer into ireq->ireq_opt, and when the request_sock is
freed, tcp_v6_reqsk_destructor() calls kfree_rcu(inet_rsk(req)->ipv6_opt,
rcu), writing struct rcu_head at the ipv6_txoptions offset (48) out of
bounds of the ip_options_rcu allocation.

[1] https://sashiko.dev/#/bug/linux-a29ff632-3911-4094-af19-2d49a80d3698

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123084138.7232=
75-1-razor@blackwall.org?part=3D1
