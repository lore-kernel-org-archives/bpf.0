Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795494475;
	b=Uqs2b9HyhJFpvL402AS5IFlCYh476VA5ZI4TqzvPZMGtKqPDzNAp8PcvmyJ09WERqNeS
	 ZdE3X5+hIWD25xq2wy1cyI0SHmXsXNnpNNHY5oiDtCodmGrXEdMqBdbWEn0h35fJciztL
	 cvvtO0E6Rfbpwvjd2UsCq1tkR3j69npS4dJN3PlDVTm/P6VnawG81w8JwgH1wcRgDhEyF
	 Kl4RpKlGe9mRW0nbi6SjRREs8raSHww78Jc8Ctcz9f0l8yocT2KSJqr2Q24Jbj4otdEZH
	 WBXTD0foOp75qEcaC3k2QUo0JyxyiBURPhDNg8VVGmKp0LcTlkkcA5HM+SYf6Zda+pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795494475;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3sgsCRjafLAvDvi+MwXgezmCR0GxlUJYMcxTCDAZpxQ=;
	b=kOhnnBuDzfxgqdtLw+FG6snKLNfrrRb7IXQdFWz5ImtLboWaBIxJq4TwTmto7FCPlzEk
	 SXEg6QudxY3qorbJY1zyGDrFW+d19NMHfsM/jxfvV5TDheMDeqTL3R6a7aXIZyTw+vI4m
	 WL5G0urgpBQn7RBv7W5Pr4QO1FmaO0wkScXAlUweQnaKCgSxtoCoy1lT+b6E+CY20o+Xl
	 xoRaCsmWCdSpU9monrcbfh4CnagXv2i3A2KJKohuv6fNKOIl0/PijlCOJwASXHtkKjttO
	 ealrZipG1QP/uh+FZhLiAhmajmlvC2n+1siJiEKn0qXw39oWntIkjA9uHjTzQzm3/ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vyt1Hbqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1A606A322
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vyt1Hbqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DF11F000E1;
	Tue, 24 Nov 2026 04:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795494475;
	bh=3sgsCRjafLAvDvi+MwXgezmCR0GxlUJYMcxTCDAZpxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vyt1HbqyfqSOzmKkJCieakSjf0qaVQrD7buX7S4czsvtZYGLJuvVOa9nQkjLdUKNf
	 1zAKz2lmVAjsTjEPVBbfDRDF1WqujmioF1ilfRVsSNDbEHgxsFg5Ccc0yA1rIPs33X
	 N4DVWp+1m8VFi8FaCTPU+4tRpI7jzAFNt+bDRQk8LD3g+qE0ae5VR010bopLuAtwA4
	 vLU2Z+7hBgz8J45akgl7zfBE9v4CRsRl7WolQXihJuXKe8fm3HP/R2Av7m5TiosizQ
	 shrXM72/eFJJ7/BoCq+UQUKQnaeJw4QqNrfZ2IhEM0Zmbwf/O5feQuhK6xd90Ljt3X
	 udOliaYVUDWgg==
Message-ID: <sashiko-outbox-230501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net: gro: skip the checksum of fraglist GRO
 packets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OkJQRiBbTUlTQ106S2V5d29yZDooPzogYnxfKWJwZig/?=
 =?utf-8?b?OiBifF8p?= <bpf@vger.kernel.org>
In-Reply-To: <20261123042735.139550-1-rosenp@gmail.com>
References: <20261123042735.139550-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 04:27:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] ipv6: gro: stale ipv6hdr pointer dereference in
  tcp6_gro_receive()
- [High] net: gro: CHECKSUM_NONE fraglist GRO skbs break GSO on
  NETIF_F_GSO_FRAGLIST devs
It also noticed 2 related pre-existing issues this patch does not
introduce:
- [High] tcp: missing protocol check in tcp_add_backlog() allows
  cross-family coalesce [1]
- [High] tcp: gro: stale CHECKSUM_COMPLETE on fraglist in
  tcp4/6_gro_complete() [2]
--

commit fa341d1e23410a4c1023b2a324454cb1f2e9afbb
Author: Rosen Penev <rosenp@gmail.com>

net: gro: skip the checksum of fraglist GRO packets

This commit skips software TCP checksum validation during fraglist GRO and
leaves the merged skb with CHECKSUM_NONE, teaching __skb_checksum_complete()
to verify each frag_list segment individually on demand and moving
tcp_add_backlog()'s checksum check ahead of skb_condense().

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index f2a5c8f3bf9d7..67897435291ae 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1919,14 +1919,6 @@ enum skb_drop_reason tcp_add_backlog(struct sock *=
sk, struct sk_buff *skb)
>  	int delta;
>  	int err;
> =20
> -	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
> -	 * we can fix skb->truesize to its real value to avoid future drops.
> -	 * This is valid because skb is not yet charged to the socket.
> -	 * It has been noticed pure SACK packets were sometimes dropped
> -	 * (if cooked by drivers without copybreak feature).
> -	 */
> -	skb_condense(skb);
> -
>  	tcp_cleanup_skb(skb);
> =20
>  	if (unlikely(tcp_checksum_complete(skb))) {
> @@ -1937,6 +1929,17 @@ enum skb_drop_reason tcp_add_backlog(struct sock *=
sk, struct sk_buff *skb)
>  		return SKB_DROP_REASON_TCP_CSUM;
>  	}
> =20
> +	/* Verify the checksum first: a TCP fraglist GRO skb left unverified
> +	 * can only be checked while its packets are still on its frag_list.
> +	 *
> +	 * In case all data was pulled from skb frags (in __pskb_pull_tail()),
> +	 * we can fix skb->truesize to its real value to avoid future drops.
> +	 * This is valid because skb is not yet charged to the socket.
> +	 * It has been noticed pure SACK packets were sometimes dropped
> +	 * (if cooked by drivers without copybreak feature).
> +	 */
> +	skb_condense(skb);
> +
>  	/* Attempt coalescing to last skb in backlog, even if we are
>  	 * above the limits.
>  	 * This is okay because skb capacity is limited to MAX_SKB_FRAGS.

[Severity: High]
This problem wasn't introduced by this patch, but can tcp_add_backlog()
coalesce ETH_P_IPV6 and ETH_P_IP packets together when an AF_INET6 socket
disconnects and reconnects to an IPv4-mapped peer [1]?

If tcp_v6_rcv() looks up the socket before userspace disconnects and
reconnects it to an IPv4-mapped address while holding the socket lock, both
the in-flight IPv6 packet and subsequent IPv4 packets are queued via
tcp_add_backlog().  Neither the checks right below nor
tcp_skb_can_collapse_rx() verify tail->protocol =3D=3D skb->protocol before
skb_try_coalesce().  When __release_sock() drains the backlog into
tcp_v4_do_rcv(), a stale IPv6 packet coalesced onto an IPv4 tail bypasses
the skb->protocol check and injects stale payload, sequence numbers, or FIN
flags into the IPv4 stream, while an IPv4 packet coalesced onto a stale
IPv6 tail is dropped with it.

> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index b84fcd07c7230..d38eaf24c3c58 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
[ ... ]
> @@ -465,7 +476,9 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct =
sk_buff *skb, int thoff)
>  		skb_shinfo(skb)->gso_type |=3D SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
>  		skb_shinfo(skb)->gso_segs =3D NAPI_GRO_CB(skb)->count;
> =20
> -		__skb_incr_checksum_unnecessary(skb);
> +		/* not verified, see skb_gro_flist_skip_csum() */
> +		if (skb->ip_summed !=3D CHECKSUM_NONE)
> +			__skb_incr_checksum_unnecessary(skb);
> =20
>  		return 0;
>  	}

[Severity: High]
Does leaving SKB_GSO_FRAGLIST packets as CHECKSUM_NONE break GSO handling
on egress devices with NETIF_F_GSO_FRAGLIST (and similarly in
tcp6_gro_complete())?

include/linux/netdevice.h:netif_needs_gso() {
	return skb_is_gso(skb) && (!skb_gso_ok(skb, features) ||
		unlikely((skb->ip_summed !=3D CHECKSUM_PARTIAL) &&
			 (skb->ip_summed !=3D CHECKSUM_UNNECESSARY)));
}

Because netif_needs_gso() returns true for CHECKSUM_NONE even when
skb_gso_ok() is true, validate_xmit_skb() forces software GSO on virtual
devices advertising NETIF_F_GSO_FRAGLIST | NETIF_F_FRAGLIST (such as
bridges, veth, VLANs, or VRFs).  In tcp4_gso_segment() (and
tcp6_gso_segment()):

net/ipv4/tcp_offload.c:tcp4_gso_segment() {
	...
	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
		struct tcphdr *th =3D tcp_hdr(skb);

		if ((skb_pagelen(skb) - th->doff * 4 =3D=3D skb_shinfo(skb)->gso_size) &&
		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
			return __tcp4_gso_segment_list(skb, features);

		skb->ip_summed =3D CHECKSUM_NONE;
	}

	if (unlikely(skb->ip_summed !=3D CHECKSUM_PARTIAL)) {
		...
		th->check =3D 0;
		skb->ip_summed =3D CHECKSUM_PARTIAL;
		__tcp_v4_send_check(skb, iph->saddr, iph->daddr);
	}

	return tcp_gso_segment(skb, features);
}

Unmodified fraglist GRO skbs are immediately split by
__tcp4_gso_segment_list() at the first virtual device instead of passing
through as a GSO aggregate.  Worse, if the geometry was modified after GRO
(for example by bpf_skb_pull_data()), tcp4_gso_segment() overwrites
th->check with a pseudo-header checksum, sets CHECKSUM_PARTIAL, and calls
tcp_gso_segment(), which sees skb_gso_ok(skb, features |
NETIF_F_GSO_ROBUST) =3D=3D true and returns NULL without segmenting the skb,
transmitting the broken fraglist skb unsegmented with an invalid
th->check.

[Severity: High]
This problem wasn't introduced by this patch, but when packets arrive with
CHECKSUM_COMPLETE, does __skb_incr_checksum_unnecessary() leave a stale
single-segment skb->csum on the coalesced fraglist skb (and similarly in
tcp6_gro_complete()) [2]?

Each segment was already validated by skb_gro_checksum_validate() in
tcp4_gro_receive(), which converted CHECKSUM_NONE to CHECKSUM_UNNECESSARY
but left CHECKSUM_COMPLETE intact.  Because
__skb_incr_checksum_unnecessary() only acts on CHECKSUM_NONE and
CHECKSUM_UNNECESSARY, a CHECKSUM_COMPLETE fraglist skb keeps skb->csum from
the first segment while skb->len spans the entire aggregate, causing
later checksum checks in conntrack or local delivery to fail and drop the
packet.

> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index eec3778855eb8..9c5709b2bf721 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
[ ... ]
> @@ -56,10 +59,23 @@ static void tcp6_check_fraglist_gro(struct list_head =
*head, struct sk_buff *skb,
>  static __always_inline struct sk_buff *tcp6_gro_receive(struct list_head=
 *head,
>  							struct sk_buff *skb)
>  {
> +	const struct ipv6hdr *iph =3D skb_gro_network_header(skb);
> +	unsigned int off =3D skb_gro_offset(skb);
>  	struct tcphdr *th;
> =20
> -	/* Don't bother verifying checksum if we're going to flush anyway. */
> +	th =3D skb_gro_header(skb, off + sizeof(*th), off);
> +	if (unlikely(!th))
> +		goto flush;
> +
> +	if (unlikely(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +		tcp6_check_fraglist_gro(head, skb, th);
> +
> +	/* Don't bother verifying checksum if we're going to flush anyway.
> +	 * __skb_checksum_complete() can only verify the packets of a fraglist
> +	 * skb without extension headers.
> +	 */
>  	if (!NAPI_GRO_CB(skb)->flush &&
> +	    !(skb_gro_flist_skip_csum(skb) && iph->nexthdr =3D=3D IPPROTO_TCP) =
&&
>  	    skb_gro_checksum_validate(skb, IPPROTO_TCP,
>  				      ip6_gro_compute_pseudo))
>  		goto flush;

[Severity: High]
Can iph->nexthdr dereference freed memory after skb_gro_header()?

iph is loaded via skb_gro_network_header(skb) before skb_gro_header() pulls
the TCP header.  If off + sizeof(*th) exceeds frag0_len, skb_gro_header()
falls back to skb_gro_header_slow() -> pskb_may_pull(), which can release
the frag0 page or reallocate skb->head, leaving iph dangling when
iph->nexthdr is read.  Fetching skb_gro_network_header(skb) after
skb_gro_header() avoids the stale pointer.

[1] https://sashiko.dev/#/bug/linux-54f30cb5-2d86-46d9-b2c9-c25a0adaef88
[2] https://sashiko.dev/#/bug/linux-b1b0f506-a36b-4c96-bc55-812755610e6c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123042735.1395=
50-1-rosenp@gmail.com?part=3D1
