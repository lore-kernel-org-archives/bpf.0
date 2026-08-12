Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461541D10C
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530386; cv=none; b=YyPP8lV3+Z/P071n95X19gltm9lz82Rr4pZ0jCQnaLfC9hQQ4gtQfv+4rkFERWtpQ34LIMAri2XnmziCOwJeT3HQxjSBltvsvjYCH5TBxM2TMK392i9pxJjkVtFM7seC0WvFwUqryhTM277mITX/UcfC0XuVAX8rKI/qsCKDn2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530386; c=relaxed/simple;
	bh=nMHSwZySg7AbyzZptNhS4P9ElwQhi0VI4AfTBsYeCCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMXAGhyktfYRPUekQ9rQi9Bc7OKxyWpgRXeSUEcrvpZuXvTa9CMts9o10JKmAV1bPehv9MUTC+NNFQVTc9KMUs0m6iDUsKqSx0e27GH9m9sPDLdPj/TFK2qwFvDkdUmw4e/qHqMYl6HiWOn2b/EnQo0o9ZqOYQ0oyld6NKC8/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEPcmxhc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEPcmxhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC391F000E9;
	Wed, 12 Aug 2026 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530385;
	bh=eNYlagLbcRuWk0lTikQIFknMaa6MjxANqaEUCen5Kno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XEPcmxhcPcmI0odUzh6e71PnvZQKtAPBzmziUW7LFe8p58I3zl8eQmurkBRhK11Jz
	 V1/n95lmFYDCM0OqZL41v75QtcaI1kNStnco3CYSPWuTPqT127fB6/hlG46dWXKxGW
	 xs3XOD2r1e0oZ0n5DAw+yNfcLN8ZcQ/n2FTWiwtvGNJDNz2N7DbabpMmjHYzbwoIyo
	 OTwXj1LjWEp8HOKS+z7MVKhRlgfqwVlJOfUF88uPCpCYkKAVcK0rJBJt5KjucU2xwD
	 9/YEJ3vNWvmY9siVXC+oIvglnZBjdvkxkFXFI6uyhVajk2Ww+5peIUXd4vfbKtUBAp
	 vdCwt3U8vt0Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 5/6] bpf: clear decap state on
 skb_adjust_room shrink path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260812083115.73100-6-nhudson@akamai.com>
References: <20260812083115.73100-1-nhudson@akamai.com>
 <20260812083115.73100-6-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:26:24 +0000
Message-Id: <20260812102624.BFC391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf_skb_net_shrink() leaves SKB_GSO_PARTIAL and SKB_GSO_TUNNEL_REM=
CSUM dangling in shinfo->gso_type after removing a tunnel.
--

--- Patch [5]: [PATCH bpf-next v7 5/6] bpf: clear decap state on skb_adjust=
_room shrink path ---
commit 672aa1a359079a58d5e4d80fc47569e00a437a80
Author: Nick Hudson <nhudson@akamai.com>
bpf: clear decap state on skb_adjust_room shrink path

This commit updates bpf_skb_adjust_room() on the shrink path to conditional=
ly
clear decapsulation state updates based on BPF_F_ADJ_ROOM_DECAP_* flags. For
GSO skbs, it selectively clears tunnel gso_type bits and encapsulation, whi=
le
for non-GSO skbs it directly clears the encapsulation flag.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 981b75941e7f7..89effff3bc525 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3754,9 +3754,48 @@ static int bpf_skb_net_shrink(struct sk_buff *skb,=
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

[Severity: High]
Does this leave SKB_GSO_PARTIAL and SKB_GSO_TUNNEL_REMCSUM dangling in
shinfo->gso_type after removing a tunnel?

If an SKB acquires SKB_GSO_PARTIAL or SKB_GSO_TUNNEL_REMCSUM (for example,
via software partial segmentation across a veth pair or GRO) and a BPF prog=
ram
uses bpf_skb_adjust_room() to shrink the SKB, it seems the base tunnel flags
are cleared but the modifier flags remain.

Hardware drivers like ixgbe or fbnic use SKB_GSO_PARTIAL to identify packets
requiring partial GSO offload or special tunnel logic. Could leaving this f=
lag
on a decapsulated, non-tunnel SKB cause drivers to misinterpret the packet
structure and corrupt the packet on transmit?

[ ... ]

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
> +		}

[Severity: High]
If all base tunnel flags are cleared and encapsulation is set to 0, which
confirms the packet is no longer a tunnel, is it expected that SKB_GSO_PART=
IAL
and SKB_GSO_TUNNEL_REMCSUM might still be set in gso_type?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812083115.7310=
0-1-nhudson@akamai.com?part=3D5
