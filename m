Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942152;
	b=dC3iM0baM0Xq0+HIVgQuO9iymw9A06XmQa3oS5mQwhQM/X3AaSPXYBz6cVwBAPgzwAH6
	 xxV8uNm/qJLpwD3TcUZURcGRmfeq5zyY25QsPLzohzNm+dMKVReMkCgdXWelrmzT5vkat
	 26F6rQ+4/K89fX4BjiyjfH45vznjLtRkYIimqOn7YRhC/E9PnezIN13bnp+MQQck4hBvl
	 dauBacm03yO0M9p87iFvh3tcfv7zM/ILcg8YrbDpGL3cfHlSHUi6D/OxEq4Qn1wYC0USv
	 3FyMoyy4wTGlEyI4HxRw1n1DvJAAEwB1/I9mswmnryUUgZ3WFDa0F17amfonQU/m4rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942152;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GlBIhRY3Akk9PwEAdoz2L3EtKZsCS5JmgcAXMjTju5s=;
	b=5F0vwoqwb5jA1qLgbvabQzIUNbuVrGNHaLX7m8vxxpuN/woBbS74LKO+mwzzkt/ir6rD
	 gjhm0vLTscaZSIc/eByrZawwynWNgGZwCF8gRqDfZvfpYtJUVJi8zz5DsOwjelsetod/y
	 xYXqFuamHJ/rXYePjC+FeDvyR+ehqoj0yEEVuKGBAP7rd7fvIrvps3yUvWTTlhI6a0rxC
	 Nn2ECW9RyEB3/2hMzQ40655UdRn2S9seaFlyTFW2WyLXZhedxvNpfuoemTnJ/sx47zoYY
	 y8X1MyArt+1LJijQMlqwB8zZUNTcOReM+P5VPh2UUJiWWhKSrU4m87vkDkhVmqtGkJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOiM6urS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104C606A330
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOiM6urS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1651F000C5;
	Tue, 17 Nov 2026 19:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942151;
	bh=GlBIhRY3Akk9PwEAdoz2L3EtKZsCS5JmgcAXMjTju5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOiM6urSdbDa6+EGKDZ/n6TQ/ggBxcbVXn9BZCuGeb07ltQXgOAPPouAcu154ElEh
	 LLarwsrgI8pPI41aa91m//zw56jJlXa2EZQO5UBVW5JGH7uLk93bQ5/dG83rqLJ8Fl
	 nYPbLFiWK8zjpD+U8dHW7hysakCkTqBXVCDwJ8JUUfGo79w9qV1yIHbLaGuyA0bl/h
	 6guRJs7RDsiJQ927GlnhOgAguqHB2HkoiKqU62jYBtE3ihR2VEbpZLZ23kl7rspz+v
	 Uqs0jlZR26l5ZHoDIyxKsJsVN2IaPsdpRpvyHIEfWi/TqOYpTmkZsAGm62DqctLXog
	 d6M1Xg79uKQPQ==
Message-ID: <sashiko-outbox-219425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when
 redirecting to an explicit nexthop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com>
 <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:02:31 +0000
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
- [Low] bpf: missing Fixes trailer for commit ba452c9e996d in commit
  message
--

commit 1e3c3c3419fd5f480aa33958ee629429b62a0379
Author: Jamal Hadi Salim <jhs@mojatatu.com>

> bpf: drop the stale dst when redirecting to an explicit nexthop
>
> This is a followup of the review of the teql arp-queue fix as reported
> by Sashiko.
>
> The issue:
> __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() install a dst for
> the redirect target only when the program lets the helper do the FIB
> lookup. With BPF_F_NEXTHOP the program supplies the nexthop, the lookup is
> skipped, and whatever dst the packet arrived with stays attached while
> bpf_out_neigh_v{4,6}() switch skb->dev to the target device. If that
> device's neighbour is incomplete the packet is parked on its arp_queue wi=
th
> the original route's dst; draining the queue re-looks the neighbour up fr=
om
> that dst and builds the frame with the original device's link-layer heade=
r,
> then transmits it on the target device.
>
> The Fix:
> Release the dst when the nexthop is supplied, so the queue drain keeps the
> target device's parking neighbour and the frame carries that device's
> addresses.
>
> The release goes through skb_dst_drop_keep_metadata(), so encapsulation
> parameters a route carries are handed over to a metadata dst instead of
> being lost, and a metadata dst already on the packet is left in place. Bo=
th
> wrappers take their existing drop path when that copy cannot be allocated,
> so a packet is never sent with the stale route.
>
> What the target device's transmit path still sees:
> The released dst is the route of the device the packet arrived on, and the
> packet leaves through the redirect target, so consumers of that route on
> the way out lose it:
>
>   - a tunnel with no configured remote takes its outer endpoint from the
>     route, as it does for the netfilter producer: ip_tunnel_xmit() reads
>     the route's next hop, and ip6_tnl_xmit() and sit derive it from the
>     route as well. A redirected packet whose route carried no encapsulati=
on
>     parameters is left with no dst, so it is counted as a transmit error
>     and dropped instead of being encapsulated towards an endpoint that
>     belongs to another device's path.
>   - the route realm goes with it, so nft meta rtclassid, nft rt classid
>     and bpf_get_route_realm() stop matching on that packet.
>   - encapsulation parameters are not lost: they moved onto the metadata
>     dst, so a tunnel or an xfrm interface downstream still builds its out=
er
>     header.
>
> Taking the outer endpoint or the realm from another device's route is the
> same cross-device reuse this patch removes at the neighbour lookup.
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
> permanent and attach a cls_bpf egress program to A, with vb the index of =
B:
>
>     struct bpf_redir_neigh nh =3D { .nh_family =3D AF_INET,
>                                   .ipv4_nh =3D htonl(0x0a010002) };
>
>     return bpf_redirect_neigh(vb, &nh, sizeof(nh), 0);
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
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Since this fixes the explicit nexthop path in __bpf_redirect_neigh_v4()
and __bpf_redirect_neigh_v6(), should the commit message include a Fixes
tag?

  Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support s=
upplying nexthop")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v4.r0.202=
61116135311@mojatatu.com?part=3D4
