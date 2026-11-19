Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102114;
	b=RMaBxX9H7W9hXummeOu44mj81mWSlqG9SdfJnT0aeITsmlh6kXKues78oVS0+V5xLkir
	 wK6pgnpMoxjV8hh7wMBBoAZdYm5d/CiNDY5OBqPwdNHXNZuAxK0XhnH+TipP1orSRPm3S
	 16C9vBRwJepKQgmcq1Vd38sZOixVNmob+yGPbAF4M5jYU4DQMkfXaGxZuei686zSd6GzJ
	 Xdz7FIoCvDn+gfHevZjIKXgsbQg2aUcuk2aAG3+CXluZPR6AssVupRO2IbjLbLE9pOB7C
	 BUYMxKg0PHwfsP1MF5wxawaPmDWjVl85xo59QsIaOLrdBA4gXHYI57ozLkARlimYyQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LDtCg/MJpzBCoFnPxzOTGDWU3DTa+xxGitfr06tG0OQ=;
	b=LWEU6+iZ7E9OzS1M4I162uK2lxqrOUIF69Rp+Wj7ag/LW1HMqmILWKouyhsGKI+nwwej
	 7oMfwlSmEOf5ZPxvMEsB984hEdY+GYDKMD/9gQ2Fp9Vt/1QV9573sX4QzJMh+spluB5yP
	 yXW3dlL5FOZreXzJ1fCQ/yVLV3A+b578/3o73PrxwCep/eUoqc9lqouhNr3OvZWXNLYL8
	 q4QNtqqmPoimilfW2QGS4h9w08+3VTXwdxMIGQPRXymGdER5kl2jtLe1cc8EhGg3KhK7u
	 mAmsEuSCowjcNTzpetUaR6KqGiAyayTpNcYWGvpZ+O7bcdTKnJ3FToKdrwAG75ac5XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwx832lh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92835606A339
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwx832lh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519FC1F000C7;
	Thu, 19 Nov 2026 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102114;
	bh=LDtCg/MJpzBCoFnPxzOTGDWU3DTa+xxGitfr06tG0OQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gwx832lhwpsr9i/sBy7noe89stqz6eC0NNRTPXR3I9es/aRIajhgDqly61HUlOetY
	 bQ2BsoPfNLxhaJvn2dA+eOEFf1k3rwNpkuUox6lII4ohjVn+7XsBjhS/8TwmFCFBy6
	 cE0/UfXqNLvaPzsQ3nIMT7bmNcWyEdT4uPvj+Nt9iW7upEKj79VAXf92W/thmJbi9k
	 hjE6vjuoGHKFDJlVcv+tRopE/3WZ73bMzglxvBLX6GaQfl0op/+K84zpWp7rRtFJYn
	 VKJPOP7W3bgmZKCmIpz9M7+0VPS0jvZbwn9H2On0uB8H/LT0DdDw7JQlsCRIPXg8HW
	 skY44xk+PKFUQ==
Message-ID: <sashiko-outbox-223384@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/8] bpf: allow bpf_sk_assign on tc egress with
 refcounted sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolay Aleksandrov" <razor@blackwall.org>, bpf@vger.kernel.org
In-Reply-To: <20261119142231.2612515-4-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
 <20261119142231.2612515-4-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 15:28:33 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] bpf: BUG_ON(skb->sk) in skb_orphan() via bpf_sk_assign() in
  test_run
- [High] bpf: socket protocol and family type confusion via egress
  bpf_sk_assign()
- [High] bpf: cross-netns delivery and ip_forward() drops with
  sock_pfree_ref
- [High] net: sk_wmem_alloc corruption on sock_pfree_ref skbs in frag
  and esp
- [High] bpf: kTLS TX fallback and offload triggered on non-TLS
  sock_pfree_ref skbs
- [High] bpf: UAF of RCU listener in skb_do_redirect() due to
  sk_is_refcounted()
- [High] bpf: refcount underflow and wmem corruption on redirected
  ingress sk_assign
- [High] bpf: missing skb_orphan() for syncookie reqsk in
  skb_do_redirect()
- [Medium] bpf: skb_expand_head() converts sock_pfree_ref ownership into
  sock_wfree
--

commit cb5207c254ec50312656daa003d320c5cdb9abbb
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: allow bpf_sk_assign on tc egress with refcounted sockets

This commit extends bpf_sk_assign() to support assigning full refcounted
sockets on the TC egress path using sock_pfree_ref as the skb destructor.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1ad57a3715343..feeb752f7a008 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2559,14 +2559,17 @@ int skb_do_redirect(struct sk_buff *skb)
>  	if (unlikely(!dev))
>  		goto out_drop;
> =20
> +#ifdef CONFIG_INET
>  	/*
> -	 * Prefetched sockets may borrow a listener under RCU. Orphan them
> -	 * before redirects that can outlive this section. Peer ingress
> -	 * stays in the same RCU section.
> +	 * Prefetched listeners may be borrowed under RCU. Drop borrowed
> +	 * assignments before redirects that can outlive this section.
> +	 * Peer ingress stays in the same RCU section.
>  	 */
> -	if (skb_sk_is_prefetched(skb) &&
> +	if (skb->destructor =3D=3D sock_pfree &&
> +	    !sk_is_refcounted(skb->sk) &&
>  	    (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
>  		skb_orphan(skb);
> +#endif

[Severity: High]
Does checking !sk_is_refcounted(skb->sk) here preserve unreferenced
syncookie request_socks and non-full sockets across redirects?

sk_is_refcounted() returns !sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE=
),
which evaluates to true for TCP_NEW_SYN_RECV and TCP_TIME_WAIT sockets.
When bpf_sk_assign_tcp_reqsk() attaches a syncookie request_sock (with
rsk_refcnt =3D=3D 0 and an unreferenced RCU pointer in req->rsk_listener) or
ingress bpf_sk_assign() attaches a non-full socket with sock_pfree, this
check skips skb_orphan(skb).  Redirecting the skb across an RCU grace
period then allows skb_steal_sock() or sk_to_full_sk() to dereference a
freed listener socket, and allows non-full sockets onto the egress path.

[Severity: High]
Can a syncookie request_sock from bpf_sk_assign_tcp_reqsk() outlive its
RCU read-side critical section when redirected by skb_do_redirect() or
queued by __nf_queue()?

Because sk_fullsock() is false for TCP_NEW_SYN_RECV,
!sk_is_refcounted(skb->sk) is false in both skb_do_redirect() and
__nf_queue().  If the packet is queued to the receive backlog, an egress
qdisc, or NFQUEUE while the TCP_LISTEN socket in req->rsk_listener closes,
skb_steal_sock() later extracts the dangling req->rsk_listener pointer
with *refcounted =3D false, causing a use-after-free in tcp_v4_rcv() or
tcp_v6_rcv().

>  	if (flags & BPF_F_PEER) {
>  		dev =3D skb_get_peer_dev(dev);
>  		if (unlikely(!dev ||

[Severity: High]
When an skb with sock_pfree_ref crosses onto a peer device via
bpf_redirect_peer() or a virtual interface (such as netkit or veth without
GRO), does keeping skb->sk across ip_rcv_core() and ip6_rcv_core() break
forwarding and netns isolation?

Because skb_sk_is_prefetched() is true for sock_pfree_ref, ip_rcv_core()
and ip6_rcv_core() do not orphan skb->sk on the receiving interface:

net/ipv4/ip_input.c:ip_rcv_core() {
	...
	/* Must drop socket now because of tproxy. */
	if (!skb_sk_is_prefetched(skb))
		skb_orphan(skb);
	...
}

If the peer forwards the packet, ip_forward() and ip6_forward() drop it at
if (unlikely(skb->sk)) goto drop.  If the peer is in another network
namespace (which BPF_F_PEER requires) and delivers the packet locally,
inet_steal_sock() and inet6_steal_sock() deliver the packet across
namespaces to the sender namespace's socket and cache the peer namespace's
dst_entry in sk->sk_rx_dst.

[ ... ]

>  	return flags & BPF_F_NEIGH ?
>  	       __bpf_redirect_neigh(skb, dev, flags & BPF_F_NEXTHOP ?
>  				    &ri->nh : NULL) :
>  	       __bpf_redirect(skb, dev, flags);

[Severity: Medium]
What happens if a redirected skb with sock_pfree_ref (or refcounted
sock_pfree) needs headroom expansion in skb_expand_head(), for example via
__bpf_redirect_neigh() -> bpf_out_neigh_v4()?

net/core/skbuff.c:skb_expand_head() {
	...
	if (skb_shared(skb) || !is_skb_wmem(skb)) {
		struct sk_buff *nskb =3D skb_clone(skb, GFP_ATOMIC);
		...
		if (sk)
			skb_set_owner_w(nskb, sk);
		consume_skb(skb);
		skb =3D nskb;
	}
	...
}

Because is_skb_wmem(skb) is false for sock_pfree_ref and sock_pfree,
skb_expand_head() converts the skb to sock_wfree via skb_set_owner_w(),
dropping the sk_refcnt held by sock_pfree_ref, charging sk->sk_wmem_alloc,
and clearing skb_sk_is_prefetched().

> @@ -8115,21 +8118,26 @@ static const struct bpf_func_proto bpf_tcp_gen_sy=
ncookie_proto =3D {
> =20
>  BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64,=
 flags)
>  {
> +	bool egress =3D !skb_at_tc_ingress(skb);
> +	bool refcounted;
> +
>  	if (!sk || flags !=3D 0)
>  		return -EINVAL;
> -	if (!skb_at_tc_ingress(skb))
> +	if (egress && (!sk_fullsock(sk) || !sk_is_refcounted(sk) ||
> +		       skb_is_decrypted(skb)))
>  		return -EOPNOTSUPP;

[Severity: High]
Can assigning a socket whose family or protocol does not match the packet
on TC egress cause socket type confusion when the packet enters a receive
path?

On egress, bpf_sk_assign() does not check that sk is an AF_INET or
AF_INET6 TCP or UDP socket matching the packet (for instance, a TCP socket
can be assigned to a UDP or IPv6 packet, or ctx->sk from a hashed
AF_PACKET or SOCK_RAW socket can be passed back to bpf_sk_assign()).  When
the packet traverses loopback, veth without GRO, netkit, or bpf_redirect()
with BPF_F_INGRESS, ip_rcv_core() and ip6_rcv_core() preserve skb->sk
because skb_sk_is_prefetched() is true for sock_pfree_ref, and
inet_steal_sock() / inet6_steal_sock() return sk to the packet's L4
handler without checking sk_family or sk_protocol:

include/net/inet_hashtables.h:inet_steal_sock() {
	...
	if (sk->sk_protocol =3D=3D IPPROTO_TCP) {
		if (sk->sk_state !=3D TCP_LISTEN)
			return sk;
	} else if (sk->sk_protocol =3D=3D IPPROTO_UDP) {
		if (sk->sk_state !=3D TCP_CLOSE)
			return sk;
	} else {
		return sk;
	}
	...
}

__udp4_lib_rcv() and udpv6_rcv() then cast a stolen tcp_sock or
packet_sock via udp_sk(sk), and tcp_v4_rcv() / tcp_v6_rcv() cast a non-TCP
or AF_INET socket to tcp_sock / inet6_sk(sk), causing out-of-bounds
accesses or a NULL pointer dereference.

[Severity: High]
What happens when bpf_sk_assign() on TC egress assigns a socket that has
kTLS TX device offload enabled (sk->sk_validate_xmit_skb !=3D NULL) to a
non-decrypted packet?

Rejecting skb_is_decrypted(skb) means any packet accepted by egress
bpf_sk_assign() is not an unencrypted kTLS record from sk.  However,
sk_validate_xmit_skb() and tls_is_skb_tx_device_offloaded() only check
skb->sk->sk_validate_xmit_skb, so validate_xmit_skb() or the NIC driver
invokes tls_sw_fallback() or chcr_ktls_xmit() on the packet.  Both
functions unconditionally read tcp_hdr(skb) and skb_tcp_all_headers(skb)
even if the packet is not TCP or skb_transport_header_was_set(skb) is
false, reading skb->head + 0xffff out of bounds or overflowing the 150-byte
stack buffer in chcr_ktls_write_tcp_options() when skb_tcp_all_headers(skb)
exceeds skb->len.

> =20
>  	skb_orphan(skb);
>  	skb->sk =3D sk;
> -	skb->destructor =3D sock_pfree;
> +	skb->destructor =3D egress ? sock_pfree_ref : sock_pfree;
> =20
>  	return 0;
>  }

[Severity: High]
Does calling bpf_sk_assign() from BPF_PROG_TEST_RUN trigger
BUG_ON(skb->sk) in skb_orphan()?

In bpf_prog_test_run_skb(), the test runner allocates a dummy sk and sets
skb->sk =3D sk without setting skb->destructor, leaving skb->tc_at_ingress
as 0.  Previously bpf_sk_assign() returned -EOPNOTSUPP when
!skb_at_tc_ingress(skb); now it treats the test skb as egress and calls
skb_orphan(skb), which hits BUG_ON(skb->sk) because skb->destructor is
NULL.

[Severity: High]
Can an skb with sock_pfree_ref corrupt sk->sk_wmem_alloc when fragmented
via a frag_list or encrypted by IPsec ESP?

bpf_sk_assign() does not charge skb->truesize to sk->sk_wmem_alloc, but
the frag_list loop in ip_do_fragment() (and ip6_fragment()) checks only
skb->sk before installing sock_wfree on each child fragment:

net/ipv4/ip_output.c:ip_do_fragment() {
	...
			BUG_ON(frag->sk);
			if (skb->sk) {
				frag->sk =3D skb->sk;
				frag->destructor =3D sock_wfree;
			}
			skb->truesize -=3D frag->truesize;
	...
}

When those fragments are freed, sock_wfree() subtracts their truesize from
sk->sk_wmem_alloc, underflowing the refcount and freeing sk while still in
use.  Conversely, esp_output_head() and esp6_output_head() check
if (sk && sk_fullsock(sk)) and add tailen to sk->sk_wmem_alloc without
checking is_skb_wmem(skb), leaking sk_wmem_alloc because sock_pfree_ref
never uncharges it.

[Severity: High]
When bpf_sk_assign() is called on TC ingress with a refcounted socket, it
takes a reference on sk->sk_refcnt but still sets skb->destructor =3D
sock_pfree; if skb_do_redirect() then redirects that skb to egress, won't
egress paths see sock_pfree instead of sock_pfree_ref?

Because skb_do_redirect() now preserves sock_pfree when
sk_is_refcounted(skb->sk) is true, the skb enters egress with
skb->destructor =3D=3D sock_pfree.  chcr_ktls_copy_record_in_skb() then tak=
es
the else branch, charging sk_wmem_alloc instead of calling sock_hold()
while copying sock_pfree to nskb, so freeing both skbs drops sk_refcnt
twice and leaks sk_wmem_alloc.  complete_skb(), skb_orphan_partial(), and
tcf_bpf_act() likewise only check for sock_pfree_ref, corrupting
sk_wmem_alloc on TLS software fallback or orphaning the refcounted socket
in netem and act_bpf.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119142231.2612=
515-1-razor@blackwall.org?part=3D3
