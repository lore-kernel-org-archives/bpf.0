Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824372;
	b=i4RGOcJkcnLtbKxlHX3qV7zHPPZTO5ZLvPGUlVKst98f+dnYdmt0/zziwBCpHzNvHyVH
	 fX50ACCeW1GkdQrRLWGTFtNr29dWsiPgvx6G2xPeWaszR8abbw3v2SYudQjYnX215goxJ
	 sVXcJxN9OEatqbn3Cttnu9IvHzqueOub+JT19xiyW0oxDWP3E5D68mz46gwVsDbb2wlOf
	 whMdFK7wYXG19f4y1y3BYHc1Qys769bhDWIJwTPcDsSEENGhNK7ipZY3wOuJipi8HnshZ
	 RhRSIIIq4/pu7znGGNlpr9eFS9F74pbEMPMgVJrK8b5POwooAi2s+KE2q9W/49yQlQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824372;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lKmezpCPQ4b5cv5pJrba7Gb6SU2QZHoo1as1Qn6CD8c=;
	b=5IY7p0lcY4fRZeFY2dC/JlwW5w/DfG2w3flv/iibu6RffgrY4lx3Wq5/moNQ7TPr7SiR
	 7lV7cC+tAozQlLgta1/6Sk7Yqld6BuH4IyU/nH1z9DC1DjT2Vac6lbxi/v7qzmwgkZ66C
	 pXVsugAFrw9LqBYQNVeDhsJcofj3JcVGaBOXRC7yqX++TdInS1N//I5Naw4Ycgu2GX6Rk
	 ENS/GG1UNSi3MRPaXNQTvfClB2YP50M8qVicCYaGonwfS/9NFfL5npIaSrf0l5/bLy9fs
	 ohzG1YYF9YhNqjLDUzZcKMbyRrOKk8VD/0zD5NDoNi4g8XYiNUQSKaOeu0emBxPRn3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8HbJVE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79327606A332
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I8HbJVE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA761F000C4;
	Mon, 16 Nov 2026 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824372;
	bh=lKmezpCPQ4b5cv5pJrba7Gb6SU2QZHoo1as1Qn6CD8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8HbJVE+AotLECrDUTSnvWodC4h+bL8alfrBlpaO482K9Lt6cDNxUAJrXpuD2Ln4s
	 jpk1QgDuNLhcODIGigKS0BKe5f9THqfwcWcGmUyY+KzV5ueqgR/7utHzw4wr6G+q7S
	 NKeGulwsGtt9TNuOpKW5MoCL/Xe+ip2AU2zZc3/NRCCWhY+IwY13QxcXa9uGWb8mwM
	 xcIUuA8JU3PNhvj27oN9B3/zh7prwwv1SItvquiEI9k/fIFOY0Q7feienpBQNTQ/5E
	 DKUJQ2Ot6voNQOl8pnmx+hWjXkUAa3LYV8EbCgmQkAoh8r6D1wOYN3s8vAxHsNei3L
	 HXquJrcVE5GSA==
Message-ID: <sashiko-outbox-216713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 4/4] bpf: drop the stale dst when
 redirecting to an explicit nexthop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <CORE-9NOG.v3.r0.20261115050625-4@mojatatu.com>
References: <CORE-9NOG.v3.r0.20261115050625@mojatatu.com>
 <CORE-9NOG.v3.r0.20261115050625-4@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 10:19:31 +0000
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

commit f68e158b3aca1ec216cec6453916862a5820e88d
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
This fixes a bug on the explicit nexthop path in
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6().  Should the
commit message include:

  Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support s=
upplying nexthop")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v3.r0.202=
61115050625@mojatatu.com?part=3D4
