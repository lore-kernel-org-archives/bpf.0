Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C7141A51D;
	Wed, 12 Aug 2026 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530789; cv=none; b=UAO1MVMSSqphMRN/p+UO0nQzbtpn2ZggneDQoNpP7AJg8YA7GEgOyxVOgoaM9w2YTMk+xI9Slf+e3y96E7VOn3WtjqVuZT2psxwE3QfunGyuEOncMAptlRWNXRE1fX9MooncJ74h0fYEyhcRyqnjlPQQiOID183s5hxcxKUIyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530789; c=relaxed/simple;
	bh=3UGeB7PKAAMFR1upsojiOAEwzprjNjDh/kMwrcWpwrc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=okojtVHf1Fj8DHPJgJfuusk+bNS+QjHxB/ZMh5Lq0Nsc+oel075Y7emzfQJf2IdgXHExIjm7eZGsZ/DeGJNuEk+LvRFs8lIBwlvMP59EQN7ZaOdNnuX/Lve0PAJP1CePsWuZoMNnerSC1wa/636BXo57uXAcAx38ZP/lSDZsICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTmom6dH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTmom6dH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3E31F000E9;
	Wed, 12 Aug 2026 10:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530788;
	bh=3+WoCbHc2PLdtgpAVd3CdDIq5WVqvr8xIvZhaRu3yBs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FTmom6dHxkc9GtNq//+8zoTqTV/0B2Z7vkGSDfX2Cp8TWqvyOLXGVitjznQmNABTf
	 vxL5T2SZwoYd8dseUWraskMOGxSfBZjdmgfZ1ORdE0gaaxEXXec2WeDXlPu0gZ0aBR
	 2E3CoV2yjWai1p7K+WBwCp3l8LlBU5kM9Dbe7Wjyfj6zNuQ62lFVv6wgktfw79D1rG
	 1YO2g6n0IMGbLTc04oEDvd6dcbldAO4G1BVGw2ZUsVuWK45tJlUIBcnc97IzWGBY5M
	 kh3VFLecocZ8DMXRKzw5GXRxqoiBREW8lsy0k4qEQr/HYgMn39V4odxAhB2G6VsHNC
	 nTZNzaMcYiKUg==
Content-Type: multipart/mixed; boundary="===============6867287178835379924=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7de271430891c4083ed76a28daa613175e04b0b0dc6e402646f22a026275eea5@mail.kernel.org>
In-Reply-To: <20260812083115.73100-5-nhudson@akamai.com>
References: <20260812083115.73100-5-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v7 4/6] bpf: allow new DECAP flags and add guard rails
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 10:33:07 +0000 (UTC)

--===============6867287178835379924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit e891bb72fdfdae2b71119ffb8be655bb3a4b26a7
> Author: Nick Hudson <nhudson@akamai.com>
> Date:   Wed Aug 12 09:31:13 2026 +0100
>
>     bpf: allow new DECAP flags and add guard rails
>
>     Add checks to require shrink-only decap, reject conflicting decap flag
>     combinations, and verify removed length is sufficient for claimed header
>     decapsulation.
>
>     Co-developed-by: Max Tottenham <mtottenh@akamai.com>
>     Signed-off-by: Max Tottenham <mtottenh@akamai.com>
>     Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
>     Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
>     Signed-off-by: Nick Hudson <nhudson@akamai.com>
>     Reviewed-by: Willem de Bruijn <willemb@google.com>

The changelog states this patch "Add checks to require shrink-only decap",
but that check already exists in the parent commit. From e891bb72^:

    if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
            if (!shrink)
                    return -EINVAL;

The diff confirms both the shrink check and the L3 pair check are context
lines, not additions. What this patch actually does is extend the coverage
of those pre-existing checks by widening BPF_F_ADJ_ROOM_DECAP_MASK to
include the new L4 and IPXIP flags.

Could the changelog be reworded to clarify this extends existing checks to
the new flags, rather than implying it adds the shrink-only requirement?

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 89e516049c852..981b75941e7f7 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -3827,6 +3836,8 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>  	}
>
>  	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> +		u32 len_decap_min = 0;
> +
>  		if (!shrink)
>  			return -EINVAL;
>
> @@ -3835,6 +3846,37 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>  		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
>  			return -EINVAL;
>
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> +			return -EINVAL;
> +
> +		/* Reject mutually exclusive decap tunnel type flags. */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
> +		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +			return -EINVAL;
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK)
> +			len_decap_min += bpf_skb_net_base_len(skb);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> +			len_decap_min += sizeof(struct udphdr);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +			len_decap_min += sizeof(struct gre_base_hdr);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
> +			len_decap_min += sizeof(struct iphdr);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
> +			len_decap_min += sizeof(struct ipv6hdr);
> +
> +		if (len_diff_abs < len_decap_min)
> +			return -EINVAL;
> +

Does this minimum-length check account for the mode parameter? The
calculation assumes mode == BPF_ADJ_ROOM_MAC, but nothing constrains mode
when DECAP flags are set.

Earlier in this function, off is computed:

    off = skb_mac_header_len(skb);
    switch (mode) {
    case BPF_ADJ_ROOM_NET:
            off += bpf_skb_net_base_len(skb);
            break;
    case BPF_ADJ_ROOM_MAC:
            break;

In BPF_ADJ_ROOM_NET mode, the removal window starts after the outer L3
header, so that header is not part of the len_diff_abs bytes being removed.

Yet when an L4 decap flag is present, the check adds the outer L3 length
unconditionally:

    if (flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK)
            len_decap_min += bpf_skb_net_base_len(skb);

Consider a tc program on an IPv4 outer packet calling:

    bpf_skb_adjust_room(skb, -8, BPF_ADJ_ROOM_NET,
                        BPF_F_ADJ_ROOM_DECAP_L4_UDP)

to strip an 8-byte FOU/UDP tunnel header. This would compute len_decap_min
= 20 + 8 = 28, so len_diff_abs (8) < len_decap_min (28) causes -EINVAL even
though the request removes exactly the claimed header.

The same mismatch applies to the IPXIP terms: in NET mode the outer IP
header is outside the removal window entirely, yet
BPF_F_ADJ_ROOM_DECAP_IPXIP4/6 requires 20/40 bytes to be removed.

Should this either reject mode != BPF_ADJ_ROOM_MAC when
BPF_F_ADJ_ROOM_DECAP_MASK is set, or make the bpf_skb_net_base_len() term
conditional on mode == BPF_ADJ_ROOM_MAC?

>  		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
>  			len_min = sizeof(struct iphdr);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31584739682
--===============6867287178835379924==--
