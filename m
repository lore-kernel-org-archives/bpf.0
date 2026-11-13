Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602479;
	b=x/q4ZI1nUi/MTGbCx+uGdLtHlDQ/cerLuoDiDHnAcy1t4Kpw1iIcMmOAN9OTkd0bsrK7
	 jbgUrSRp3T1HQTTEHC+QsnD6sjY9saNHQduLyaLOgmMZIFswJPvOqMyzJjGpfXKAjQB1E
	 guVdSorUkCcTsyKttFvMCDR+SAN63faBGgcdSktRkaczefvpXhB5NZZ3G+GqoDEQ8E59T
	 STyMxupzBePBFW/DuOAd+evJ2vhO35XNgTyxhmXczTZldvPqNKEt8MSPVJ6J7ly9ae+jV
	 cnqi9xTMjvzj7Fd4C5rXmfW6IdMLdg4ijXY8XGY0fZ1Jhz4VEBJWes87BMBvgFdsspQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602479;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yKY+csPF9vB3YvQj62Dw8JT9L9B/CvGwCqEUypFaduQ=;
	b=wTGvxh/pSgFofUvdQhAULZHHLSykiRyniucuCDEI5mof0FKZNt7SHsqsBMCjwJE5KScP
	 wp9e+Q8ctO5dnNYsYR2eqKmGhfnIKUy/pZcdaAbus0j7Y3EMb77a9BCiFVm7BJb9+ukvV
	 N0fgLEaqUh+mgTG5XCNuBx/NTpRBi4INnJu30T2EObRieIEfh32TULIdNul1ggelUkj5A
	 lLnTWWI+uMGZOJkZZsz+hfXipEF6Lf35ieenlGkGSE89P51OP3l3g6ira6b3mjDsthisu
	 AA6mkKOgDmXMU6peDT0097XRWJlKYcn/ygzWRLaKJLieFJ6K5cIuxOwuoSyPJe6aHDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZA03QPa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86364606A336
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZA03QPa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305141F000C5;
	Fri, 13 Nov 2026 20:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602479;
	bh=yKY+csPF9vB3YvQj62Dw8JT9L9B/CvGwCqEUypFaduQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZA03QPa1WbvWyeicSbTvXbeo5pCqCtuASinRukLNPqXvDXFlc4VSfrZQioq0M6RW
	 CMXpH8p9qTOInzHeV/8+AoilWxdYUsJZi2/qxe35oSw1lq8KI05ONqpMq7MpIds/5p
	 IRosEYfkUwf5bWdncz+6oLEZZLKfBybyVzWP9qbPk6jowQ/HvbXn9yXlC+PMq+5Lpx
	 7ii93KqJmQzEMC1pJG3zf2sRAuU2i8sP8CBJMFJzlGqNekVXRwPvAq+B5A9JAbEyz3
	 iDxvLnHS58nlTxVPdDp88Ybxn15s+pdpcNgTaOR+yy/olqtpsr3wJhs8kbZJIOGC03
	 nffjxCFQQcZAA==
Message-ID: <sashiko-outbox-213669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/4] bpf: drop the stale dst when
 redirecting to an explicit nexthop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <CORE-9NOG.v2.r0.20261112151659-4@mojatatu.com>
References: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
 <CORE-9NOG.v2.r0.20261112151659-4@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:41:18 +0000
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

commit 69d202e339fb4761ba7ad2174f002c73503bb498
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
> Release the dst when the nexthop is supplied. That branch never consults
> the route dst, so nothing that describes the route is lost, and the queue
> drain keeps the target device's parking neighbour.
>
> The release goes through skb_dst_drop_keep_metadata(), so encapsulation
> parameters a route carries are handed over to a metadata dst instead of
> being lost, and a metadata dst already on the packet is left in place. Bo=
th
> wrappers take their existing drop path when that copy cannot be allocated,
> so a packet is never sent with the stale route.
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
Should this commit include a Fixes: tag for the commit that added the
explicit nexthop branch in __bpf_redirect_neigh_v4() and
__bpf_redirect_neigh_v6()?

  Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support s=
upplying nexthop")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v2.r0.202=
61112151659@mojatatu.com?part=3D4
