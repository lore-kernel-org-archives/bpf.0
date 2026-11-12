Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493018;
	b=tbOOnY5Ce5TccYJ5NwjVrsnECqtzTIUUTFI6OrEyVIz1Ns6m12gvbkIH/sczg2FJHWiw
	 ZAJPZPKJHRoAvgvTFy2WZXcJoYUhpWvncFlO4kIRahF9bP/+yPI7rTOL+6gl5WV2F7vT8
	 WwaixgoPy9Ora1c0ldsgkhUnzkkHW6p43e0ux+0B+bJhPeZPYAic9+InBZjvuEz9GOjqv
	 QYgvOBI+2KgNwV6f7g1VbiQJqRtf7+rsGGLhB4i1yxa1lSHFDEUr2RlA0WkcaysQd1OYV
	 fXHgYpNTdYvF74GQi4jw3QT55uc1OB9wCMTWbB1dCrxsGO2/wgmSXDiplcq3OTZgeQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493018;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/Vv1E7PpJMJRjqnKtZZTz9HXKfHhwH3E4+V11WdZeIc=;
	b=mTUhFABZfXtbQ5VoOng46GpDVezIRndIpxM1iNmwgBktw+PERsSSzCvaEGUv0Qh4mSCR
	 EMYRAG5Yxf7e+3h0N2XtJRJDy0Qok1vydbe3aSb0uBD95gj6vAWPxg1oQlsqzrGRamywt
	 ARcf4vvnTyLfXOJt2tuS1e6fdOfzDBPkWARmjPtAFQF/IztgR1SlPxd2d35l8jGQWeiar
	 nauIwjk2tTurf5FIDw+GU4GbOu31KqGheULsNNGF1cTliYfTAoaUrBPrnqzfeFYFwhs2y
	 M6TGMfH8EybnE8hCx6GOC21p3aXSlR7oFsBQIPsP8Gers8TAvEpsxHGKP2qZFpXF3Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBOik6AE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19888606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SBOik6AE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795E91F00A05;
	Thu, 12 Nov 2026 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493017;
	bh=/Vv1E7PpJMJRjqnKtZZTz9HXKfHhwH3E4+V11WdZeIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBOik6AE1wGOkuI4w+7DKALFA422wjmZOppba7/6KDNYYIWYILx4NyRWoZo356VKt
	 UsufBF8zfolMHrNxR61QOIHAsF75BUlEOmoYzkSn0v9e0JN0hT1B1HwvyA/JmuGa+e
	 OKnJ3sG2y7260apuePWCNpB5FdisMawXMGKYmWl8+thQwOq79RUCfiK+KDdsiAFv2P
	 q9YY1wcM4nEkckxOXrZl19GmRi46TXyTKsNVbE4izFlI1umBzTXvEFDC7SLzEQgo88
	 xwdlAZUdrykGNkMFR1kDWnDaAT4VfJ7+nyxrBSpGfh5UmVcCowvhUptAhgcSnsF/K/
	 82J5X9it+wCtg==
Message-ID: <sashiko-outbox-211289@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/2] bpf: drop the stale dst when redirecting
 to an explicit nexthop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <CORE-9NOG.v1.r0.20261111073528-2@mojatatu.com>
References: <CORE-9NOG.v1.r0.20261111073528@mojatatu.com>
 <CORE-9NOG.v1.r0.20261111073528-2@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:16:57 +0000
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

commit 563f2cf949ebea821bc686f9b196aaca4663a1a8
Author: Jamal Hadi Salim <jhs@mojatatu.com>

> bpf: drop the stale dst when redirecting to an explicit nexthop
>
> This is a followup of the review of the teql arp-queue fix as reported
> by Sashiko.
>
> The issue: __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6()
> install a dst for the redirect target only when the program lets the
> helper do the FIB lookup. With BPF_F_NEXTHOP the program supplies the
> nexthop, the lookup is skipped, and whatever dst the packet arrived
> with stays attached while bpf_out_neigh_v{4,6}() switch skb->dev to the
> target device. If that device's neighbour is incomplete the packet is
> parked on its arp_queue with the original route's dst; draining the
> queue re-looks the neighbour up from that dst and builds the frame with
> the original device's link-layer header, then transmits it on the target
> device.
>
> The Fix: drop the dst when the nexthop is supplied. That branch never
> consults the route dst, so nothing is lost, and the queue drain keeps
> the target device's parking neighbour.
>
> Conditions to recreate the bug: two network namespaces, A (10.10.0.1/24)
> and B (10.1.0.1/24) in one, their veth peers in the other with only A's
> peer addressed (10.10.0.2/24) so B's nexthop cannot be resolved by ARP.
> Resolve A's neighbour for 10.10.0.2 as permanent and attach a cls_bpf
> egress program to A, with vb the index of B:
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
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
This fixes a bug in the explicit nexthop handling of
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6().  Should the
commit message include a Fixes tag?

  Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support s=
upplying nexthop")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v1.r0.202=
61111073528@mojatatu.com?part=3D2
