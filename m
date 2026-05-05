Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25635A3AE
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 04:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954470; cv=none; b=jzD/aWbr4ffH5q6iduFgx6bDEXuE3bRRo1jc5CR3+pku42l2j73m5QteF6KVDhsbAVddDzFWBk8QucyJHnyA+XT/tk7bzlYJcChLR/OwtuQkb517Tz/uYR/9QhdfPXIRcyYKgIc+vt1vEmkCpygFAhiagO3/CDAi858IaUSmU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954470; c=relaxed/simple;
	bh=BOy3elaAeYKB6HktV9rSQEpVWy5I2Xe/lICoZAqiDJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HqtzrnfAC60sH3yi+xahL/HCL1Jx9a93cM0qPFCxkQN/+bYZhwV74OVU69TH4PjNCMVRIDavMBFNaPO7PXGKkNc6Tp/5T5pm7SHmFJHjAt6eUEoQgsKO50TF5EQzcKDPW3MyvM39HteWvrZw3qGGkpruLZpxF7HSgU/5kSLDRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8+7BMYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8+7BMYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55823C2BCB4;
	Tue,  5 May 2026 04:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777954470;
	bh=BOy3elaAeYKB6HktV9rSQEpVWy5I2Xe/lICoZAqiDJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=s8+7BMYcSaNhptDO2kxMRAFEB5ynkaZGCRN8kC7T057xXG3Tx/+GQejGYvUhfPb3t
	 2w3bJb8w4+bZrkuhBx0Y0dkZVg1JtumPBlsJaIfqJFJBMOsVIQ8a7S2ct/WMMlhzg0
	 lNHUwmVRdbeJ9yAVCnp6W1WY5NyOpRG0ax+BEUgrsDLBuQSl2PlRpI1ReNzP2jO6wJ
	 p2yodEHxKnbphlv4crZt9TLUfd9Y0S+ctKqyMwIhWqMwKcoy7OaGk6MOMtGQ225MDB
	 U+K0X5OYE9WK0T5pJzTfH2lm0I5uz9lES74FSgI9+t2JvjCecDabf/+DEFN3oMPnGE
	 WCY3w0GksPPmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] bpf: clear decap state on skb_adjust_room shrink
 path
Reply-To: sashiko@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504101759.3319427-6-nhudson@akamai.com>
References: <20260504101759.3319427-6-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 04:14:29 +0000
Message-Id: <20260505041430.55823C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch fails to clear SKB_GSO_TUNNEL_REMCSUM when decapsulating=
 UDP or GRE tunnels, leaving the SKB in a corrupted GSO state.
- [High] Unconditionally clearing `skb->encapsulation` for non-GSO packets =
breaks hardware ESP offloads for non-GSO ESP-in-UDP packets.
--

commit 531781236d1767d9010b79132e818c1dd8e04a3e
Author: Nick Hudson <nhudson@akamai.com>

bpf: clear decap state on skb_adjust_room shrink path

This commit updates bpf_skb_adjust_room() to selectively clear decapsulation
state when shrinking the skb. For GSO packets, it removes only the gso_type
bits corresponding to the requested decap layer and clears skb->encapsulati=
on
if no tunnel bits remain. For non-GSO packets, it unconditionally clears
skb->encapsulation.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 04871a57f085..ff1c936bb46d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -3666,9 +3666,48 @@ static int bpf_skb_net_shrink(struct sk_buff *skb,=
 u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
> =20
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> +			shinfo->gso_type &=3D ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM);
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +			shinfo->gso_type &=3D ~(SKB_GSO_GRE |
> +					      SKB_GSO_GRE_CSUM);

When decapsulating a tunnel that uses Remote Checksum Offload (like FOU or
VXLAN), the SKB has both the tunnel GSO flag and SKB_GSO_TUNNEL_REMCSUM set
in shinfo->gso_type.

Does this code leave SKB_GSO_TUNNEL_REMCSUM set when decapsulating these UDP
or GRE tunnels?

> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +			shinfo->gso_type &=3D ~SKB_GSO_IPXIP4;
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +			shinfo->gso_type &=3D ~SKB_GSO_IPXIP6;
> +
> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +						  SKB_GSO_UDP_TUNNEL_CSUM |
> +						  SKB_GSO_GRE |
> +						  SKB_GSO_GRE_CSUM |
> +						  SKB_GSO_IPXIP4 |
> +						  SKB_GSO_IPXIP6 |
> +						  SKB_GSO_ESP)))
> +				if (skb->encapsulation)
> +					skb->encapsulation =3D 0;

Because the exclusionary mask above doesn't include SKB_GSO_TUNNEL_REMCSUM =
(or
SKB_GSO_PARTIAL), will this check evaluate to true and incorrectly execute
skb->encapsulation =3D 0 if a remote checksum flag is the only one remainin=
g?

Could this leave the SKB in a corrupted GSO state with a tunnel remote
checksum flag active but skb->encapsulation =3D=3D 0, potentially leading to
incorrect checksum calculations, out-of-bounds inner header accesses, or
kernel panics during GSO segmentation?

> +		}
> +
>  		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_type |=3D SKB_GSO_DODGY;
>  		shinfo->gso_segs =3D 0;
> +	} else {
> +		/* For non-GSO packets, clear encapsulation if decap flags are set */
> +		if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			      BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
> +		    skb->encapsulation)
> +			skb->encapsulation =3D 0;
>  	}

The commit message notes the goal of keeping encapsulation set for cases li=
ke
ESP-in-UDP where tunnel state remains. Does unconditionally clearing
skb->encapsulation here for non-GSO packets break hardware ESP offloads for
non-GSO ESP-in-UDP packets?

Hardware NIC drivers and the IPsec stack (such as xfrm_dev_offload_ok) stri=
ctly
rely on skb->encapsulation =3D=3D 1 to offload ESP crypto and checksums, ev=
en for
non-GSO packets.

Could this unconditionally clear operation destroy ESP offloading for non-G=
SO
packets, introducing the inconsistency between GSO and non-GSO handling that
the commit is intending to prevent?

> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504101759.3319=
427-1-nhudson@akamai.com?part=3D5
