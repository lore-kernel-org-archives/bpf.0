Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535976;
	b=ags+VaVIcY2req7nrWb02VWRcB/EYz6WZtX5tS6ijKVtbdWZy86IezX6wVd9aqYOpfX7
	 Ye1ICk0xLDIbkwTgTxIXJssGD1naUYcaMoANCV93CADXoZoEd0JvOuLIvPNQoGqJOYxjs
	 O9Q/PYRJAlRXqbaXb6VBZGtCtUmC9QZMSMxn9xpkuho4GQlbXe8aYNd4Xc6UhwezAa8a+
	 hYBC//H2KnT1ufcoaqQ6kgNwsfoVbUpqCvhoNBQ+A6lwzsBUWNfEEUILfZReYDZ6DagGl
	 oGKaHWxWJbn67khizDjx9lrUPX7gaft414KD1VvKr08Q+r6geWWjSuJAiGi0ZdQo1YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=On1gIz+YL4CJ+Ow3aY8SIrgBX00chlAenVFVGFX/E7E=;
	b=DE9LLOvZar1wR9W+Kn380Axj/hvVLd4aKcWl0TqpqEoSjArGxKy0lFQ7K4pCnRWBcw/f
	 iPyCHp6hd3XonMfs3J/bHLpIh46Qu+12eL/Syyp4CgORQCt7ue73ZqiYJl3kEP8R7z9G9
	 uo2wflF8mZv3c6mQRuHNFMbiqzRbUoQCRDiawU++lVgmQp4wNJr2+oEhfRlF2WJaTdO+y
	 U2axxSxnj8LfQYuQwd3XDhchsRrvrhzacLu/1Wu7SkEM1mPtg6FFKvi+yiJqgv6Jcuytk
	 UhYiLzOiZ85YRJpm2IinFJGvmyTvIalGimcVYkfK0X2p4f+9I6HbGqe4GsGkW36Lkfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emhRHpeg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD100606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emhRHpeg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A4C1F000C0;
	Tue, 24 Nov 2026 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535976;
	bh=On1gIz+YL4CJ+Ow3aY8SIrgBX00chlAenVFVGFX/E7E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=emhRHpegooLeaP63NARVExb7WnPuJmk9RSz8pKDJkrpVRZIIKerGoS7GyCryU8rUA
	 V0ZE2J/fPhKv9orl9NyZjvyMg98F3fOAWPCsVcysHnJDPB4/kIYKaNFrmFJjGcxBT8
	 gt9BsgL+/POkRZLySVstEIrWD9+Y8d13miGGv4jxmh1Jy+qAPtS8GHpw3IbuZ5EGO5
	 Cgov4QYMJ/tdg6RsP8PyvUOxwSYXqmXZc8gcX8O0Qq97Ese7oDQQmg+CKJSrOFilnB
	 V/YuPAxIw6buk1PY4ZBsIqF5NwafuWu2GlYhqVtUBcwIv4lqnpcv+WLINySQFjEKNx
	 YnuNcOYzV05Jw==
Message-ID: <sashiko-outbox-231505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/4] bpf: support bpf_sk_assign in netkit
 tx path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolay Aleksandrov" <razor@blackwall.org>, bpf@vger.kernel.org
In-Reply-To: <20261124151244.1423343-4-razor@blackwall.org>
References: <20261124151244.1423343-1-razor@blackwall.org>
 <20261124151244.1423343-4-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 15:59:35 +0000
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
- [High] bpf: missing L3/L4 protocol validation in bpf_sk_assign() and
  inet_steal_sock()
- [High] bpf: prefetched socket in netkit_xmit() not orphaned on forward
  or xnet
--

commit 7a81b1ade7d996de1fa2508363693501dc7fc20e
Author: Nikolay Aleksandrov <razor@blackwall.org>

bpf: support bpf_sk_assign in netkit tx path

This commit enables bpf_sk_assign() for BPF programs running in the netkit
transmit path by tracking the active skb in bpf_net_context and taking a
reference on the assigned socket via sock_pfree_ref.

> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 75a1a561e5aab..d32d98cad6f65 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -53,15 +53,25 @@ static __always_inline int
>  netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
>  	   enum netkit_action ret)
>  {
> +	struct bpf_net_context *bpf_net_ctx =3D bpf_net_ctx_get();
>  	const struct bpf_mprog_fp *fp;
>  	const struct bpf_prog *prog;
> +	struct sk_buff *prev =3D NULL;
> =20
> +	if (bpf_net_ctx->ri.kern_flags & BPF_RI_F_NETKIT_SK_ASSIGN)
> +		prev =3D bpf_net_ctx->sk_assign_skb;
> +	bpf_net_ctx->sk_assign_skb =3D skb;
> +	bpf_net_ctx->ri.kern_flags |=3D BPF_RI_F_NETKIT_SK_ASSIGN;
>  	bpf_mprog_foreach_prog(entry, fp, prog) {
>  		bpf_compute_data_pointers(skb);
>  		ret =3D bpf_prog_run(prog, skb);
>  		if (ret !=3D NETKIT_NEXT)
>  			break;
>  	}
> +	if (prev)
> +		bpf_net_ctx->sk_assign_skb =3D prev;
> +	else
> +		bpf_net_ctx->ri.kern_flags &=3D ~BPF_RI_F_NETKIT_SK_ASSIGN;
>  	return ret;
>  }

[Severity: High]
What happens if an skb with a prefetched socket is forwarded before
reaching the peer's local IP receive path, or enters netkit_xmit()
already carrying a prefetched socket?

On NETKIT_PASS, __netif_rx(skb) feeds __netif_receive_skb_core() on the
peer, which runs generic XDP, TC ingress (such as act_mirred or
sch_frag), VLANs, and rx_handlers (such as bridge or macvlan) before
ip_rcv().  Neither skb_scrub_packet(), __dev_queue_xmit(), nor
netkit_prep_forward() orphans a prefetched socket.

If the peer forwards the skb into another network namespace (for example
via a macvlan, VLAN, or act_mirred), inet_steal_sock() and
inet6_steal_sock() steal skb->sk without checking net_eq(sock_net(sk),
net), delivering the packet to a socket in the wrong namespace.  If a
frag_list skb carrying a prefetched socket reaches ip_do_fragment() or
ip6_fragment() (via bridge netfilter or sch_frag), fragmentation sets
frag->destructor =3D sock_wfree without charging sk_wmem_alloc,
underflowing sk_wmem_alloc and freeing sk while still in use.  And if TC
ingress assigns an unreferenced sock_pfree socket and forwards the skb
into netkit_xmit(), __netif_rx() queues it to the backlog past the RCU
read-side critical section, causing a use-after-free.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3206b40887c5e..a8e7b46bd648e 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8132,21 +8132,28 @@ static const struct bpf_func_proto bpf_tcp_gen_sy=
ncookie_proto =3D {
> =20
>  BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64,=
 flags)
>  {
> +	bool from_netkit =3D netkit_runs_skb(skb);
> +
>  	if (!sk || flags !=3D 0)
>  		return -EINVAL;
> -	if (!skb_at_tc_ingress(skb))
> +	if (from_netkit) {
> +		if (!sk_fullsock(sk) || (!sk_is_tcp(sk) && !sk_is_udp(sk)) ||
> +		    (skb->sk && !skb->destructor))
> +			return -EOPNOTSUPP;
> +	} else if (!skb_at_tc_ingress(skb)) {
>  		return -EOPNOTSUPP;
> +	}

[Severity: High]
Can bpf_sk_assign() attach a socket whose address family or L4 protocol
does not match the packet in skb?

The from_netkit check allows any full TCP or UDP socket (AF_INET or
AF_INET6), and when the packet enters ip_rcv() or ipv6_rcv() on the peer,
the IP layer dispatches to tcp_v4_rcv(), udp_rcv(), tcp_v6_rcv(), or
udpv6_rcv() based on the packet header.  Those handlers call
inet_steal_sock() or inet6_steal_sock(), which return the prefetched
fullsock without checking sk_family or sk_protocol:

include/net/inet6_hashtables.h:inet6_steal_sock() {
	...
	sk =3D skb_steal_sock(skb, refcounted, &prefetched);
	if (!sk)
		return NULL;

	if (!prefetched || !sk_fullsock(sk))
		return sk;
	...
}

If a netkit program assigns an AF_INET TCP socket or a UDP socket to an
IPv6 TCP packet, tcp_v6_rcv() -> tcp_v6_do_rcv() steals it and computes
tcp_inet6_sk(sk), causing type confusion and out-of-bounds slab accesses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124151244.1423=
343-1-razor@blackwall.org?part=3D3
