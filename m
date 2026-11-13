Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602479;
	b=p4JrEYRE+BgE1AhNVczqmffj4QHLfCQA0NaI9eB780MjytXrysf5ssZT97LvOJWPoRj7
	 o+nYfbn1gCertDJeh73HspCLns5vkbXA0XSl56SvUPVihYDHr0FkNoI+fh5xNObg6FSQo
	 +ohqBeTbd/dLZkrSN/2FTI8qEkBnEWr9WRnCLTX1u3NlbNIFHAZZ9js/mlC2gBr94UszV
	 hx8niRUHZZfwmJrNM3JOpAd8KWU1qpksUgKoI0g/x2ZdR6JH4FXCLogEJ4E5S5KxeKfE4
	 YDc+VZ0017KDJ+RkaJegpH2c2jFVjCB2X1y0atqfmYtD2Qdz0ZJX5NBq9oKgNSv1lxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602479;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kQVGXXdygJvGeaB3/f5aA4egdVZxrx90NiJPhyvWGrI=;
	b=rAGMjHNfAz9ox2fN9ufqOgXz9VPd0rQ6qacQjEQQ3/ynvIGz/LfOYwo2nanWelO/vRxn
	 ZJ8yp4iYX+XETK7JsyBQiRtK8PH+Q17RtNns47y3j2ZNfBYNrVW3C3Lg0UfLHB695I6NW
	 6v5It9kTLrxnlz07pbZ/cyYkBiAm6s8EHHu7jE+DmGFBL0LgycvnplhGBEXR8e3DGHKGC
	 L0C8FblCOOBiIBb7tCgQ+ycM8gVJh0wktHm4/A4hdCWuFEc5JvTNVTK+++wrpFYhn/ojK
	 ZkFpl36JpOHTnPNlyQ+Nzlw62/CoMpl6kmah1Yo7ymKj5qynCul5ZUKthOjbqA6ZhAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NVIN13/W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0C606A332
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVIN13/W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C7E1F000C4;
	Fri, 13 Nov 2026 20:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602478;
	bh=kQVGXXdygJvGeaB3/f5aA4egdVZxrx90NiJPhyvWGrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVIN13/W7AeLo/z1r1T8XPi68SqO8HtU1CqOJIWM3ukGv0khAND7eDp+UpfDLpXC+
	 zYkmwM7AtIeDQImnvctGlG7/uf4oqX5XxrUjwQV3iB0B3S0i8Esx5+s/kGCrElJuor
	 kwaYg9KgR2vBnp4yl7RWRzrn5a/hrqh7DdIM5S5zxJzv7Gq7DWcgYHZMVSZT76o3wW
	 dtw9WDvtsVQsqPpFwD5KvMZT+26mxTmrrrghchsduBZTaYPGaOcdz6AFZGk1I+LCf2
	 gqqhKtbZYm8iTDKamvLLgJGw38JqN4nJ3yISjkY4qVh5q77fA8YtvdsGnRjz5ccMGC
	 2mygA4Y15x3tg==
Message-ID: <sashiko-outbox-213666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: xfrm: interface: restore dst_orig
 on every xfrm interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <CORE-9NOG.v2.r0.20261112151659-1@mojatatu.com>
References: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
 <CORE-9NOG.v2.r0.20261112151659-1@mojatatu.com>
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
- [Low] xfrm: interface: missing Fixes trailer in bug-fix commit message
--

commit 07b565180a0d355b65e18ab188e00cf30014d9c1
Author: Jamal Hadi Salim <jhs@mojatatu.com>

> net: xfrm: interface: restore dst_orig on every xfrm interface
>
> Found while testing the dst release for the two producers that steer a
> packet to another device, fixed later in this series. One of the consumers
> of the metadata such a release installs is an xfrm interface, which
> restores the original route before the xfrm lookup; the swap warned on the
> metadata dst still installed in the skb, and only the collect_md arm
> restored the route at all.
>
> The issue:
> An xfrm interface takes the if_id and the underlying device either from i=
ts
> configuration or, in collect_md mode, from the xfrm metadata on the skb.
> When that metadata also carries the route the packet arrived through,
> xfrmi_xmit2() puts the route back on the skb, because the xfrm lookup tak=
es
> the address family from it. skb_dst_set() expects the dst slot to be empty
> for a reference counted dst and warns when it is not, so the route landed
> over a metadata dst that was still there; a kernel built with
> CONFIG_DEBUG_NET=3Dy panics on the first packet that takes this path when
> panic_on_warn is set.
>
> Two more defects sit in the same place. An interface with a configured
> if_id never restores the route: it takes the metadata dst as it is, whose
> address family is AF_UNSPEC, so the lookup finds no policy and the packet
> is dropped as a link failure instead of being transformed. And the restore
> moved the route out of the metadata dst, which a clone of the skb shares,
> so the clone that reached the interface first left the original packet wi=
th
> nothing to restore.
>
> The same slot overwrite is in the unstable helper a tc-bpf program uses to
> attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_or=
ig
> and installs a per-cpu metadata dst over it. The per-cpu dst is shared by
> every invocation of the program, so the restore cannot keep anything in i=
t.
>
> The Fix:
> Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
> dst_clone() so the metadata dst keeps its own, and empty the counted slot
> with skb_dst_drop() before the route is installed. The helper allocates a
> metadata dst per skb instead of a per-cpu one, so the route it records
> belongs to that skb and is released with it; the per-cpu allocation is no
> longer used and goes away.
>
> Conditions to recreate the bug:
> A tc-bpf program that records the route as dst_orig with
> bpf_skb_set_xfrm_info() and redirects the packet to an xfrm interface is
> the shortest way to hit the overwrite. A netdev egress fwd rule that stee=
rs
> a packet routed with an xfrm encapsulation into an interface reaches the
> same place once the dst release earlier in this series keeps the route:
>
>     ip link add xf0 type xfrm if_id 42
>     ip link set xf0 up
>     ip neigh replace 10.20.0.1 lladdr 02:aa:00:00:00:ab \
>             dev va nud permanent
>     ip route add 10.20.0.1/32 dev va encap xfrm if_id 42
>     nft add rule netdev t c fwd ip to 10.1.0.2 device xf0
>
> Send one packet to 10.20.0.1. With CONFIG_DEBUG_NET=3Dy and panic_on_warn=
=3D1
> the kernel panics in xfrmi_xmit() with the metadata dst still installed
> while the route is put back. The interface with the configured if_id drops
> the packet as a link failure without consulting the outbound policy, and a
> clone made after the metadata was attached consumes the route before the
> original packet arrives.
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Since this fixes the dst_orig handling and per-cpu metadata dst added in
bpf_skb_set_xfrm_info() and xfrmi_xmit2(), should this include:

  Fixes: 94151f5aa966 ("xfrm: interface: Add unstable helpers for setting/g=
etting XFRM metadata from TC-BPF")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v2.r0.202=
61112151659@mojatatu.com?part=3D1
