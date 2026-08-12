Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B77A4248DA
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530187; cv=none; b=kpqSUoRspC576sCZaeD1bZma3q0FGdkBn6wWenh7r/5PoSBY8H0cSh1trrZQKV7dRobc2zIbrF72KHixLZa4+jXO6/gZT/aEHISPGFHgN/NDN9wPjYmUMfJWNDbEcm4QCB5cD3GakeziInz67YR96Y0mhvstB1ux7zV21iHxKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530187; c=relaxed/simple;
	bh=e3a64/u1TuGgVCwPe7hJh2vwci+rkbVoLp+DXrTQW+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNn069uH/9aMsged7ekFk2eCk4u57lhCa2IOCyN1JcJufutaOBaeZVUQBQrwB7kb+0CVdsqlQvOQ7XZzsArnQM2Ry6YaINPRxn8MM1u6T1BmrNaFs9eVIcqF49BAUmn0l2uiAO56kbrnfmuskXuOMj4u3h4EkY/N648X+Nfyw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC7mQXPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC7mQXPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF711F000E9;
	Wed, 12 Aug 2026 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530180;
	bh=XW62ji5b7uYcZ6Y4VHrUaam+9UCpg8UHH1XM+iGdak4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DC7mQXPE3bXr0YpmXvbVIiV1Pq2GMj95NqdC2iPQ+4xPCec8UYG9HPfOse5wL9sdQ
	 vsF+UZN+GjUsrTarDe6gqriwV7/QOr0k0MDodrVYwEFdFR3kOdjsR18afvr3AJBLdj
	 nY2+DAp1ddUoVX6fkLS7GZ+FviGrwyIRBgHqFjEiWRM/DYDanlyQAxmvaQ6mpFqiiG
	 dM6t+6wK3HB1Za8vP0uM5wx0FxUISWAeLw8BA1fUCfyGqcMk4lcUG495x9t6kg+3Vq
	 JKf7mFpv+cqibi9w4TcrgmgOYRRZ94PyKqUcTF1nef/2lPXnSgEvbms0vCREfDA1yh
	 K4+xuWI2hJrBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 4/6] bpf: allow new DECAP flags and add
 guard rails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812083115.73100-5-nhudson@akamai.com>
References: <20260812083115.73100-1-nhudson@akamai.com>
 <20260812083115.73100-5-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:22:59 +0000
Message-Id: <20260812102300.0BF711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch exposes new decapsulation flags without implementing the=
 required kernel side effects to clear tunnel-specific GSO flags and `skb->=
encapsulation` status, leading to stale tunnel metadata on decapsulated pac=
kets.
- [High] The `decap` flag check in `bpf_skb_net_shrink()` was not updated t=
o include the new L4 and IPXIP decapsulation masks, causing critical packet=
 state updates (like dropping the outer `dst_entry`) to be skipped.
--

--- Patch [4]: [PATCH bpf-next v7 4/6] bpf: allow new DECAP flags and add g=
uard rails ---
commit cdd433d824d20f40752fca9cc2db82451d364a2c
Author: Nick Hudson <nhudson@akamai.com>

bpf: allow new DECAP flags and add guard rails

Add checks to require shrink-only decap, reject conflicting decap flag
combinations, and verify removed length is sufficient for claimed header
decapsulation.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 89e516049c852..981b75941e7f7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -3579,7 +3586,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buf=
f *skb)
>  					 BPF_F_ADJ_ROOM_ENCAP_L2( \
>  					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
> =20
> -#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)

[Severity: High]
Does this mask update also need to be reflected in the decap check in
bpf_skb_net_shrink()?

Currently, bpf_skb_net_shrink() evaluates decap based only on the L3 mask:

net/core/filter.c:bpf_skb_net_shrink() {
	bool decap =3D flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
	...
	if (decap) {
		...
		if (skb_valid_dst(skb))
			skb_dst_drop(skb);
	}
	...
}

If a BPF program uses BPF_F_ADJ_ROOM_DECAP_L4_UDP to decapsulate an L4 or
IPXIP tunnel but does not provide BPF_F_ADJ_ROOM_DECAP_L3_MASK, decap
evaluates to false.

As a result, skb_dst_drop(skb) is skipped, causing the inner packet to
incorrectly inherit the outer tunnel's routing cache. This can route the
inner packet to the tunnel endpoint instead of its true destination.

[Severity: High]
Does this code miss clearing tunnel-specific GSO flags and skb->encapsulati=
on
status?

The UAPI documentation promises that using BPF_F_ADJ_ROOM_DECAP_L4_UDP will
clear UDP tunnel GSO flags (SKB_GSO_UDP_TUNNEL and SKB_GSO_UDP_TUNNEL_CSUM)
when decapsulating a UDP tunnel.

However, bpf_skb_net_shrink() omits the logic to do this:

net/core/filter.c:bpf_skb_net_shrink() {
	...
	ret =3D bpf_skb_net_hdr_pop(skb, off, len_diff);
	if (unlikely(ret < 0))
		return ret;

	if (decap) {
		/* Match skb->protocol to new outer l3 protocol */
	...
}

Leaving stale tunnel metadata on the packet can cause downstream drivers to
parse incorrect header offsets, resulting in skb_over_panic or
skb_under_panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812083115.7310=
0-1-nhudson@akamai.com?part=3D4
