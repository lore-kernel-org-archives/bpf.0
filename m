Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562714;
	b=Z61fMet8IrivtXK//rgDTN6mp6RrzFujVEPBs6Gvb8X7mzWrqClWeLoO73p2aAL4F4fx
	 tgn3EBXtQg+dicknKdEngZ1vEUBmkWoV9acyXgOLmp/q+/zDB+cIpKPY4PtKVmHu0QpkP
	 6uBSKoFgQ+FjXQrFWHnK2FobrM4jY5kKv4dnbzCFDCZlsCniVvxsG0yMP8EIMhMfkK3HF
	 UWIs+TgvMiW/tOLuqRdm66tJRHRfhd1SlQvdDNO39xfHBwzMwiqLEaPGIdpmuXvyqTa1Y
	 ZnWKV2A2StjAatv4sr6rQe3Vplea0Fa9Qe+6YVU7envLEoPjtuHx2+qnXM/zhL/gOrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562714;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JRQPHetbw5+WOki81nKrBIUanmE3LLEBtaZZpMsw2oQ=;
	b=sXXCgIgI8jotfIXOXy5umUIAncs05Z09TPcgSnEHOp3rLgHQRNsNu1+FmTmR3bBAoLci
	 YYfitHyAgQZ0ArUZbDskVKFclEg+8wZbZXxcIicCXUvrYFCJ152U3NjVnyy3u9a8VUxTg
	 pm6HHs9Hhfl18+3/Ktkv2ma4MZ+qBha4wKEtP/lOIa1EDzftf6hrgpPM1zXO5GSJB3BZa
	 9Jv9FeDEqUOOrOd+0i5kZsNhq5Ab/y3S5tJ3gbPTRzY1QlwEzr3zfpVjBwYCm25Wj9LFF
	 X2K0DT+5OSHJFyZXEXmtHrTmLVFQG9P41nk2ggn2nyIBA10xoWGrTWdsR6knyqX6eOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LW72ei0+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD28606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LW72ei0+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169521F000C1;
	Sun,  1 Nov 2026 19:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793562714;
	bh=JRQPHetbw5+WOki81nKrBIUanmE3LLEBtaZZpMsw2oQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LW72ei0+wpio3uruTwiREVWrO8HxmTcJGP7n+Q3B9RrN/838EX89ChXvOs64WvoS4
	 37n6IfAAJ8m+pPTyxsYwbcfDQ4+idQQBtiNOVqfNRS8H6cl5zUfCe7p3HnF2YcGypQ
	 evdVvjAThqEq5HdeQTXlxHPEOVqAEnk98eVQ//gCbLfcYLnxQvqUXeX2LHVai52dbR
	 jy68NMNOJ5udfNBdjwblHmh3LpIL17vvc7QNzlMaJP9P+XIdPP3OAs+dcwan5QlygP
	 gRga94EpOAFPuXPxn+Rfd/IMPRmWxlXfzS2XDmVeXsHhY08l6qvWnyd2xahg6I8Ur+
	 HVKoLa2ORfzqg==
Message-ID: <sashiko-outbox-192638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 22/27] bpf: Reset skb->cb after an lwt prog pushes
 an IP header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261101190535.1454146-23-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
 <20261101190535.1454146-23-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:51:52 +0000
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
- [Critical] bpf: incomplete skb->cb reset and VRF flag loss in bpf_lwt_res=
et_cb()
--

commit 40c1b82f0bd0c6a0826ad31c22402c9c073712bd
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Reset skb->cb after an lwt prog pushes an IP header

This commit adds bpf_lwt_reset_cb() to reset skb->cb in bpf_input() after
an lwt program pushes an encapsulation header and in bpf_xmit() before
rerouting. This avoids interpreting stale inner IP option offsets or
cross-family control block fields against the outer header.

> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index b9270a08cc6d1..3a946e8709b16 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -85,6 +85,32 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf=
_lwt_prog *lwt,
>  	return ret;
>  }
> =20
> +/*
> + * skb->cb still describes the IP header that was the first one before t=
he
> + * prog ran. The option offsets in IPCB(skb)->opt are wrong for a pushed
> + * header, and a header of the other family needs the other layout. iif
> + * stays: behind a VRF skb->skb_iif is the L3 master and not the port.
> + * bpf_lwt_push_encap() cannot do this, because bpf_prog_run_save_cb() c=
an
> + * restore skb->cb after the prog.
> + */
> +static void bpf_lwt_reset_cb(struct sk_buff *skb, __be16 proto)
> +{
> +	int iif;
> +
> +	if (skb->protocol =3D=3D proto) {
> +		if (proto =3D=3D htons(ETH_P_IP))
> +			memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
> +	} else if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> +		iif =3D IP6CB(skb)->iif;
> +		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
> +		IPCB(skb)->iif =3D iif;
> +	} else {
> +		iif =3D IPCB(skb)->iif;
> +		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
> +		IP6CB(skb)->iif =3D iif;
> +	}
> +}

[Severity: Critical]
Does bpf_lwt_reset_cb() leave several fields in IPCB(skb) and IP6CB(skb) in
an inconsistent state after encapsulation or rerouting?

1. When transitioning from IPv4 to IPv6, memset(IP6CB(skb), 0, ...) leaves
IP6CB(skb)->nhoff as 0 instead of offsetof(struct ipv6hdr, nexthdr). If
bpf_lwt_input_reroute() routes the encapsulated IPv6 packet to local
delivery, ip6_input() -> ip6_protocol_deliver_rcu() reads:

net/ipv6/ip6_input.c:ip6_protocol_deliver_rcu() {
	...
	nhoff =3D IP6CB(skb)->nhoff;
	if (!have_final) {
		if (!pskb_pull(skb, skb_transport_offset(skb)))
			goto discard;
		nexthdr =3D skb_network_header(skb)[nhoff];
	}
}

With nhoff =3D=3D 0, this reads byte 0 of struct ipv6hdr (version and traff=
ic
class) as the next header protocol instead of ipv6_hdr(skb)->nexthdr.

2. For IPv6-in-IPv6 encapsulation or rerouting (skb->protocol =3D=3D proto =
=3D=3D
htons(ETH_P_IPV6)), bpf_lwt_reset_cb() does nothing. However, IP6CB(skb)
holds extension header offsets relative to skb_network_header(skb) (ra,
dst0, srcrt, dst1, lastopt, nhoff, dsthao, srhoff) as well as flags
(IP6SKB_HOPBYHOP, IP6SKB_ROUTERALERT, IP6SKB_FRAGMENTED) and frag_max_size
parsed from the inner IPv6 packet before bpf_input() or bpf_xmit() ran.

After bpf_lwt_push_ip_encap() moves skb->network_header to the newly pushed
outer IPv6 header (or an lwt_xmit program modifies headers and returns
BPF_LWT_REROUTE):

- With CONFIG_IPV6_MIP6, if icmpv6_send() is triggered on the outer packet,
  mip6_addr_swap() uses the stale IP6CB(skb)->dsthao offset relative to the
  new outer network header:

  net/ipv6/icmp.c:mip6_addr_swap() {
	...
	if (opt->dsthao) {
		off =3D ipv6_find_tlv(skb, opt->dsthao, IPV6_TLV_HAO);
		if (likely(off >=3D 0)) {
			hao =3D (struct ipv6_destopt_hao *)
					(skb_network_header(skb) + off);
			swap(iph->saddr, hao->addr);
		}
	}
  }

  Can this corrupt the packet or swap 16 bytes out of bounds?

- On local delivery via ip6_protocol_deliver_rcu() or
  ip6_datagram_recv_specific_ctl(), the stack will index from the new
  network header using the inner packet's nhoff, lastopt, dst0, dst1, and
  srcrt offsets.

- In ip6_forward() and __ip6_finish_output(), stale IP6SKB_ROUTERALERT or
  frag_max_size from the inner packet will divert or fragment the outer
  packet.

3. When a packet arrives on a port enslaved to a VRF device, vrf_ip_rcv()
and vrf_ip6_rcv() set IPSKB_L3SLAVE or IP6SKB_L3SLAVE in cb->flags while
keeping the slave port ifindex in cb->iif and setting skb->skb_iif to the
VRF master ifindex. Because bpf_lwt_reset_cb() clears flags without
translating IPSKB_L3SLAVE and IP6SKB_L3SLAVE across family transitions,
inet6_iif() and inet_sdif() lose the VRF association:

include/linux/ipv6.h:inet6_iif() {
	bool l3_slave =3D ipv6_l3mdev_skb(IP6CB(skb)->flags);

	return l3_slave ? skb->skb_iif : IP6CB(skb)->iif;
}

4. For IPv4-in-IPv4, only IPCB(skb)->opt is zeroed, leaving
IPCB(skb)->frag_max_size and non-VRF flags from the inner packet set, which
causes __ip_finish_output() to fragment the outer packet to the inner
packet's reassembled fragment size.

Should bpf_lwt_reset_cb() reset the full control block for both families
 while preserving iif, translating IPSKB_L3SLAVE / IP6SKB_L3SLAVE, and
initializing IP6CB(skb)->nhoff =3D offsetof(struct ipv6hdr, nexthdr), simil=
ar
to decap_and_validate() in net/ipv6/seg6_local.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101190535.1454=
146-1-alexei.starovoitov@gmail.com?part=3D22
