Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579781;
	b=op2iWuQqDb0XzkeeJUq/A4XXpTHmju1v+HD+nQ4p590Bl/OIlQMh9Q90iMpW74/BU+lQ
	 vxEKyUK17+whxQe7I4I87F4W4Hgb7kYcM318+gztNJZxec1hTkB9a4neHUaY+UIWjYBIm
	 bQ59MrvfUp4rwrfIl+K3mkYnmd2sbg/rAikUBavi79VsiUrJUjATk2yeHoi18g843Cddh
	 HudYIInasLGekCqI5BeaBgOw1Z3w3YQFWoCLTG2iYgtAh1u6UVWZdZxRn4//bpxEw1+0w
	 mBk7rlWPx81gOV5/tnhKQARQCpMw3l5WO6x6SCYBQR+BAna7ZoytVROGHnI74hEMVgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i6vGCEPmTfNujBrV5pLY6XewY/QJKIYc1T4YRrAIko4=;
	b=Pf2eZLTVpxbS9GOnpUcvmu4xz3OBreUhpX6Ld3kK5I22onxOrdaUHWSZ+TUiV/iLJUaQ
	 r4Xs1sLJ7KjWiNl+TUGIMIcAs/AYZ6mKBqmMTjlW2lGPctZvw2pJA7CQih6YOqMkQV6Ft
	 CF+w2D48zWD8XLNXc/6imyXUEWpZ/RZebHUKwkumH6SNMlROBNCzdcW9ovXaCpGJWofzS
	 U7u3R9AZdLY0xkH/uJTcyn5EjgAFaqkXeaCTCL+kf//vtnIiKtwdIQp4uITsvwiEinDqH
	 GUBM43X2ZF59434Ui6OffteUmdztDDVJ0/GlVTKv/k1lzxTI64CO3tA/zphF9IA2j3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgyMy6WL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10C606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AgyMy6WL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA541F000C0;
	Wed, 25 Nov 2026 04:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579781;
	bh=i6vGCEPmTfNujBrV5pLY6XewY/QJKIYc1T4YRrAIko4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AgyMy6WLC//Y0NlljrnVozDgyoSy43vPFfgVm50thrBgJ1GZCx6KfiKnPXt+r8P1f
	 6kL2c5yoBgFwS5ucTHQIxqwB1TZihJlzSA3vdngryd1/uYHfaPcoC7Uf74r08tqlhR
	 3CxrY3Pq+nPaMKaBUGgrzfn86IbdC2sTnvwoB5e2tyn7lVwKTXcsl3xUrU3dH3icAR
	 bKyrSMUY9e8MyAG8alNogp+q2tCqG9707VTB0uZbQQIFb1N+47UcYmrhEVfOTKDiig
	 O/Lo5Sg/fvmSATWrA1pzZ7u7Cjcuo1Vx102X/wlT+p8XMjRNmsvU2kXJvZGv3vlJLd
	 IxOBeqUWEuZ4Q==
Message-ID: <sashiko-outbox-232556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 42/47] bpf: Take a neighbour of the L3 master in
 bpf_redirect_neigh()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261125032938.670542-43-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
 <20261125032938.670542-43-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:09:40 +0000
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
- [High] bpf: neigh->dev and skb->dev mismatch in bpf_out_neigh_v4() on
  non-L3-master
--

commit 14e765ab115457bb4915055efa26bf5101b3a1a3
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Take a neighbour of the L3 master in bpf_redirect_neigh()

This commit updates bpf_out_neigh_v4() to drop the skb dst and look up a
neighbour on the target device itself when no nexthop is supplied and the
target device is an L3 master.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index eb6aeabb410e4..8d331802a7db6 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2367,7 +2367,11 @@ static int bpf_out_neigh_v4(struct net *net, struc=
t sk_buff *skb,
>  	}
> =20
>  	rcu_read_lock();
> -	if (!nh) {
> +	if (!nh && netif_is_l3_master(dev)) {
> +		/* The route leads to another device, this one looks it up again */
> +		skb_dst_drop(skb);
> +		neigh =3D ip_neigh_gw4(dev, htonl(INADDR_ANY));
> +	} else if (!nh) {
>  		struct rtable *rt =3D skb_rtable(skb);
> =20
>  		neigh =3D ip_neigh_for_gw(rt, skb, &is_v6gw);

[Severity: High]
Can rt->dst.dev still differ from dev in the "else if (!nh)" branch when
dev is not an L3 master?

__bpf_redirect_neigh_v4() calls ip_route_output_flow() and accepts both
RTN_UNICAST and RTN_LOCAL routes without checking that rt->dst.dev =3D=3D d=
ev.
When ip4h->daddr is a local address (or 0.0.0.0),
ip_route_output_key_hash_rcu() produces an RTN_LOCAL route whose
rt->dst.dev is net->loopback_dev (or the VRF master device) rather than
dev; outbound tunnel-mode XFRM policies matched via xfrm_lookup_route()
can likewise switch rt->dst.dev to a different outer egress device.

In that case skb->dev is set to dev while ip_neigh_for_gw() looks up or
creates a neighbour on rt->dst.dev.  If that neighbour is unresolved, the
skb is queued on rt->dst.dev's arp_queue with skb->dev pointing to dev, so
unregistering dev will not purge it via neigh_ifdown() and leaves a
dangling skb->dev pointer (use-after-free).  In addition, headroom was
only validated against dev, so if dev has no header_ops while rt->dst.dev
uses a cached hardware header (such as loopback_dev or a VRF master),
neigh_hh_output() can hit WARN_ON_ONCE(skb_headroom(skb) < hh_alen).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125032938.6705=
42-1-alexei.starovoitov@gmail.com?part=3D42
