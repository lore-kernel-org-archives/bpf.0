Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824372;
	b=2uWgosPd/RXyZi9mg0+ASWeHydRfQV9PSXqMv11nnKnAxwTpKzeQrYd8AfAxK42Kd9Tf
	 X/anACTc/6fgtutTgj9u4QN8vo3JO11zso7vNrbsC/J/zaexUfEDGCJoRLrmOP7raZD9R
	 dBLZfc0IMStbcpezR1OJwmliGGI34Oe/ibPafpwu/pFzab08vzr6o4N2ILjfmyP+Dore4
	 j5dLbgJfbkFF9Xnz2ujX6MfGFaxYtHZo7UnZNCabdo+EFAvRJTi9npOKDSdWROAPW09hC
	 XE8KXRX4CzVmK6zZekSsY4sTrhhxhYpyg0iVrYPLsl2T95yFM2H4YPKg3JRDH+XnOcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824372;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8DAyR4c/OD+BA8l+bX6z08vIeRE7b9sGmUdqT8K1vnU=;
	b=L9USI+Nl4Wz0VZ5saAEqK5veB7V6f1sAdW3TCjAmUNr0sNtli94FCtAFjGexALPu8oKP
	 rJKew7OVPghGNAfvFLMzeAOELO9Hs8GIBapM6JpbjzQ7nAL0STKlfmEahU08qRhMmgl94
	 R6T+3SMwGdbqrzxf0ke7+l0SmNxHVOwEL3mMcSakP8bo4W9hofxhd3sems7h3KMUVMDKb
	 n9Co8KCVOakQB56+dMch19sciF5y5xMAqMh2I2p7g+upBY1aAAImlL+GhsCYpbM0MbW5k
	 8o/XqxoyTJRHkHrPVh5/e4vB/xCkV24wVZ8hU0jaJK7qUeGd0qqyPJ3sOYfx9AkPZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="g//q72mL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3A606A331
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g//q72mL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EE11F000C4;
	Mon, 16 Nov 2026 10:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824371;
	bh=8DAyR4c/OD+BA8l+bX6z08vIeRE7b9sGmUdqT8K1vnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g//q72mLUYBzTc/ENWsY6UsEgnSQ3Z8ClaLDOKShDfoGgAKIIN2blo2hlEpZL2XlF
	 IHjKB4IrLARJWIPXISBQar8LuJvy8eIGIeNj0UlK2KknKRs8YY5q4PrcHcu15az1Jt
	 PEAM+UV39ZeWzq77o1ZRSf2N2/Lc8Sa7RAOm6dUuApy1rDz7zINvWbu4GRkP3v9WI/
	 zBBWSy6E7hhGpTQdi7v4JsyUUdJhDdVK3iCXdcjqTJ0qnexY3f1JR2aIF5LuubOBSp
	 qPRbB1V06w+4urmXOHu8ssgKbMNrNxPpLmkEfvDIybc7o706l3eXDCDvOJX5gBuzkB
	 m+ZUEhj99SSjw==
Message-ID: <sashiko-outbox-216710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: xfrm: interface: restore dst_orig
 on every xfrm interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <CORE-9NOG.v3.r0.20261115050625-1@mojatatu.com>
References: <CORE-9NOG.v3.r0.20261115050625@mojatatu.com>
 <CORE-9NOG.v3.r0.20261115050625-1@mojatatu.com>
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
- [Low] xfrm: interface: missing Fixes trailer in bug-fix commit message
--

commit fc50a8a0e09367a243cf350a9e4dc409fd76b617
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
This fixes runtime defects in bpf_skb_set_xfrm_info() and xfrmi_xmit2().
Should the commit message include a Fixes tag:

  Fixes: 94151f5aa966 ("xfrm: interface: Add unstable helpers for setting/g=
etting XFRM metadata from TC-BPF")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v3.r0.202=
61115050625@mojatatu.com?part=3D1
