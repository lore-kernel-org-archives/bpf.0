Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942150;
	b=YJzALkxojeXM304ti4rAhvBW6hzl1hzLx0GhF7AhxXp4sv6k8gj09r2o80eZ7eZIiaEX
	 smvBZgnc0D5iGGRyyZCnDenJUbOpYxA0jwOOG6yGYNOhjVkzhtOdNrHk7w/Wepm2ZI9KU
	 AXn3FQGs8O/tQC+FeKBsGisJOfPnh9CJAcd0ittQ6bfksMMH6Rxw5O+g4PsGdeE9dn7Wy
	 9emv+H0+9cgRXgNx8Ka5p7A/IIDT/xRXEPj00K9bD4I7SnGrWCA5p8p3jVF2qIF+TakXr
	 xGB1f86KtX1lb9YEcv8IzS08BlvN419uB7SoqsDoskVsEL3MM96zLbWV8Ul+4NNDTHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cjJKDO3z17r3ImfcCAiBzdR7K2OUqeLGGM67X8WWLAo=;
	b=LagZriHV5/I6Y+UtMKUrA3nlPDoqv96cP+yu/mfyksZK9UNmRIce/wzLQ9VPUwq94dhc
	 4HPie0U6HF1hK46V8WsF4QbWLjcCCKtpTXstsUTXvNEg26jJN65WOeTIIMKvg7gIRRkup
	 UInE/eZa30TRic6e7qs1iV2iHIbtFDRO5JJSoWNvJm6c4uP67He3lQG6ZEKHDdzVy8QpB
	 dVmahqkRn9OxvZQD+TH4D4oVBVV7Db1bebrWUYAOjQ+5XroN2u5z7urKuuHnxdn9omLBr
	 /VfvSoHjQjB8dzi6difUgKhg2V52/mQzU5Gh41rSeE0BseAv58nEjNe5Qs0LMjGyxHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQsiP4Xb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25CB606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQsiP4Xb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832B81F000C5;
	Tue, 17 Nov 2026 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942150;
	bh=cjJKDO3z17r3ImfcCAiBzdR7K2OUqeLGGM67X8WWLAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQsiP4Xb9wiI25ERC+IJ9PFAjCcyAGV5NwNXXVtw7SBlwYgMYAzvIzDU7LAF2rSAM
	 +UfrmG/loyG4wIwGwHJRnTuVng6/liTnReiMtJ547hdd+ouExf/UZ1wp+cV81qy0E1
	 Q3ZnNOKLNvK0VTYtQGm/SYc2LByhn8vZV0km+PyzNWaBNf/j5RTReO7yDUYriV86Qq
	 5mhAZYRXAAyb6LbZbCmxM1+3kBmxkYvTQZ25amvhgwA24jUGJvJaDDyd9pTZ1mlKQx
	 X7/yIj5qd/Yf83Ggytf8bPUkWXR3k1VpqM24+bQyGVvDFHn20UYPXTSx8nI6NZ8jWj
	 WUBHmc7P8+a5w==
Message-ID: <sashiko-outbox-219422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 1/4] net: xfrm: interface: restore dst_orig
 on every xfrm interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311-1@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com>
 <CORE-9NOG.v4.r0.20261116135311-1@mojatatu.com>
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
- [Low] xfrm: interface: missing Fixes trailer in bug-fix commit message
--

commit b05c45811463aad7e54095fcda3e363d3e6cefe2
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
> bpf_skb_set_xfrm_info() is self-contained: the overwrite is in the helper,
> so the first packet that calls it panics inside bpf_skb_set_xfrm_info() on
> a CONFIG_DEBUG_NET=3Dy build with panic_on_warn=3D1.
>
> The netdev egress arm needs the rest of the series: it reaches the same
> place once the dst release later in this series keeps the route, and the
> interface takes if_id from the skb there, so it has to be the collect_md
> shape:
>
>     ip link add xf0 type xfrm external
>     ip link set xf0 up
>     ip neigh replace 10.20.0.1 lladdr 02:aa:00:00:00:ab \
>             dev va nud permanent
>     ip route add 10.20.0.1/32 dev va encap xfrm if_id 42
>     nft add rule netdev t c fwd ip to 10.1.0.2 device xf0
>
> Send one packet to 10.20.0.1. The kernel panics in xfrmi_xmit2() with the
> metadata dst still installed while the route is put back.
>
> An interface with a configured if_id shows its own defect without any
> other patch: it drops the packet as a link failure without consulting the
> outbound policy. And a clone made after the metadata was attached consumes
> the route before the original packet arrives.
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Since this fixes standalone bugs in bpf_skb_set_xfrm_info() and
xfrmi_xmit2(), should the commit message include a Fixes tag?

  Fixes: 94151f5aa966 ("xfrm: interface: Add unstable helpers for setting/g=
etting XFRM metadata from TC-BPF")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CORE-9NOG.v4.r0.202=
61116135311@mojatatu.com?part=3D1
