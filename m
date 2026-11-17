Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942151;
	b=ONJeBYIAc0h+GFYbOeUp3VUTemgh2fRXWTUiC1K2E7k0ZXART946ha0WvRnzXZVvYoAC
	 4dnVr1KcJGY3NZxIrcAxvKcxOHhubQPq7YaihBSUYellfOhl1bvPRn58RyX0ro8peT8wu
	 i71rZuT6HgPJNL/TYhmsJOVcg3DHVszLcjJXfXrXnKuxOtpMmscF1Sw/DyQtoHlaEod19
	 rRHyNoMi8RsaNksYFIG2Amy/hBebtnAwx09nYwqQcVCt9S8WyJOIiH6Xnt02uzBPyJj5E
	 F7z7VsL3AzcRv2mRNb/URlIURt9qFv4KYC7oPnN8hfKL4dTQ9IsSPi1e6iiuTEwgsQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942151;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oWuKKdSkyE+20Q/Vozl4QSvd0BV8EIG0iBEggAImaWc=;
	b=zwC6+4rNosdcmP8HdFf3xM7I+N6OESqiqA3rqNbD1TZ/qrDzaJdKcKCrpuTONlqsOC3l
	 P8v3CYq8DWyc0iTfBpQg4GnwriH0PNCl5cSjlQQ36B2GhAjYWe6LCFizFlriSKAE4/SW/
	 YTBNKxHSCszG2TlCotYJ6MtcoRKe9nqFMB8KLUB2bjLrsdAtuPFyO4+emfei7EZLanOwg
	 kC3oFZuj6dL6bkb/2zC5lkD5N+fmddV/NzvQORfRZUTlPFug36eNKeJF91jLTgh9II/eP
	 rVjz4XSt1GbM1/dIDdR9dKMFs9l5aVF2FhqcclyiXmImol0u59etP1TQwwhv9GA54Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idSt9OSA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AD606A335
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idSt9OSA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC8A1F000C4;
	Tue, 17 Nov 2026 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942151;
	bh=oWuKKdSkyE+20Q/Vozl4QSvd0BV8EIG0iBEggAImaWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idSt9OSAvqhNmOFnHJLbwCYvX5zIbGdzZHKd/t1TVkdnlzBBA6jwOfvdZP8m4ygoc
	 jKRZc7onu8LBVc0kacnpjlDp3HdiOkWYug4TiZu2XvbZ4anpowW1P9ddhgHB8v4ckB
	 qCAKSglTmnATMl0LztcRDqcRtr7YWf0xoPKpiZrvNnDRHOK/BAqpFX6YvyNyQGUScn
	 +2voVMOmNM2mEVGcjbapSylNimwF83n5myjg1Z3k9xobcHbPOU0DfkNEJxxuRBEB6A
	 S8WhYAqAoJnfgQlm13hkHYTkr1UDbwpbCnVgmAE3Dqj9E3tDTHzQ3aIbZ7B1h7JhI3
	 oOv3m1SRykZ2w==
Message-ID: <sashiko-outbox-219424@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 3/4] netfilter: nft_fwd_netdev: drop the
 stale dst when steering to a device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311-3@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com>
 <CORE-9NOG.v4.r0.20261116135311-3@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:02:30 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] netfilter: nft_fwd_netdev: missing Fixes trailer in commit
  message
--

commit 8509c3096bc9c51dfee6568ce51166947c0741cf
Author: Jamal Hadi Salim <jhs@mojatatu.com>

> netfilter: nft_fwd_netdev: drop the stale dst when steering to a device
>
> This is a followup of the review of the teql arp-queue fix as reported
> by Sashiko.
>
> The issue:
> The neighbour variant of fwd rewrites skb->dev to the configured output
> device and calls neigh_xmit(), but leaves the skb's dst untouched. If that
> device's neighbour for the configured nexthop is incomplete, the packet is
> parked on the neighbour's arp_queue while the stale dst still describes t=
he
> device the packet was routed through. Draining the queue re-looks the
> neighbour up from that dst, so the frame is built with the routed device's
> link-layer header and then transmitted on the configured device. The pack=
et
> leaves with another device's addresses.
>
> The Fix:
> Release the dst before the device switch. Both inputs the neighbour
> transmission needs, the device and the nexthop, are supplied by the rule,
> so the queue drain keeps the parking neighbour and the frame carries the
> configured device's addresses.
>
> The release goes through skb_dst_drop_keep_metadata(), so encapsulation
> parameters a route carries are handed over to a metadata dst instead of
> being lost, and a metadata dst already on the packet is left in place. If
> that copy cannot be allocated the packet is dropped, never sent with the
> stale route.
>
> What the configured device's transmit path still sees:
> The released dst is the route of the device the packet arrived on, and the
> packet leaves through another one, so consumers of that route on the way
> out lose it:
>
>   - a tunnel with no configured remote takes its outer endpoint from the
>     route: ip_tunnel_xmit() reads the route's next hop, and ip6_tnl_xmit()
>     and sit derive it from the route as well. A steered packet whose route
>     carried no encapsulation parameters is left with no dst, so it is
>     dropped and counted as a transmit error instead of being encapsulated
>     towards an endpoint that belongs to another device's path.
>   - the route realm goes with it: a realm is a property of the route the
>     packet took, so nft meta rtclassid and nft rt classid stop matching on
>     that packet, and bpf_get_route_realm() returns 0.
>   - encapsulation parameters are not lost: they moved onto the metadata
>     dst, so a tunnel or an xfrm interface downstream still finds them.
>
> Taking the outer endpoint or the realm from another device's route is the
> same cross-device reuse this patch removes at the neighbour lookup: those
> values were never the configured device's to use.
>
> One consumer is older than this series. When a tunnel cannot take an
> endpoint from the skb, ip_tunnel_xmit() and ip6_tnl_xmit() fall back to
> skb_rtable(), a container_of() over whatever dst the skb carries, and a
> metadata dst is not an rtable. That fallback is reachable without this
> series: a tc-bpf program that calls bpf_skb_set_tunnel_key() with no
> remote already hands an NBMA tunnel such a dst. The release here can leave
> one behind as well, when the parameters a route carries are not usable for
> the payload. The cast is repaired separately.
>
> Conditions to recreate the bug:
> Two network namespaces, A (10.10.0.1/24) and B (10.1.0.1/24) in one, their
> veth peers in the other with only A's peer addressed (10.10.0.2/24) so B's
> nexthop cannot be resolved by ARP. Resolve A's neighbour for 10.10.0.2 as
> permanent, then load this ruleset on A:
>
>     table netdev t {
>             chain c {
>                     type filter hook egress device va priority 0
>                     policy accept
>                     fwd ip to 10.1.0.2 device vb
>             }
>     }
>
> Send one packet to 10.10.0.2. It is parked on B's incomplete neighbour
> for 10.1.0.2; once that neighbour becomes valid the frame leaves B
> carrying A's source address and A's neighbour as the destination.
>
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3=
.r0.20261103062649-2@mojatatu.com
> Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mo=
jatatu.com/
> Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/
> Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Since this fixes a bug in nft_fwd_neigh_eval(), should it include:

  Fixes: d32de98ea70f ("netfilter: nft_fwd_netdev: allow to forward packets=
 via neighbour layer")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v4.r0.202=
61116135311@mojatatu.com?part=3D3
