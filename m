Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDA3D3D05
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661031; cv=none; b=BidMx2LbiYAgD7R5BpOvSvjp/3iFa0T2lBk7ZenHZrAJEqctycZs3WleCkqN0QW5UhbzHHLsoJapo3KQUpQMxYEhs+DmJTR2+4DB9sU5SqrAfsWjUNgZeFVc4gojIOblFGGPpQhhDBSvjrO5xpsuiS/2NMdgn559I4hN2xS/0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661031; c=relaxed/simple;
	bh=vOpR3QprRCoCSUSNkfjF5VxENkiKE25FatWfq3c5xfI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AgqPwfqRjYXjMFvDhvWw7I+CY0/03+kvKzqT4REpfSUKCPRQw7wHUgCsPpgbzwEUtSqF5q6ZmQGXd09QVIvlVY2DDpi11OTy+QjzX7gnzgSWpQ/iielUd4XL4H2K/aZXIuPF9CxV7rbcgIItBR8+NMJwm9jgDKfi41vrt+bAGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rtr5j7Yp; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rtr5j7Yp"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794719afcd4so162217b3.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661028; x=1776265828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWIArzpyOOvfAEAf63T5ijzN/e9W9mTmg83yyPjlKNo=;
        b=Rtr5j7Ypk51ub5o1xrBiGukwtti9l4BH0sKzRygdmBLfTjxc0PMxVjgVtCPzCoFT3Z
         Ekw6YIabsynSFo4qw3+ijG63HzDmv8tvISZmUpmzhnWqqPqik5smnCYm1S7n2zCfY+Gr
         XwRF/+g0EMCPlzGkajo0dgubWZBlAFgHV4TcVHtJw861Q3RuYQRjnuUECpbDFKBkLA7k
         WRgUFMgGNQQBVOTR7jsDrC7cNRdaS61rZGs0u1E7meYlhzvqmbjz5q8MoymGHvphc+Af
         ltmEWw39ldh59HfiR9RoCXtxhaeYGGW3bvU3eqd7hGjNLiWurnhqD9ar0sltWsoZHb0p
         EuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661028; x=1776265828;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWIArzpyOOvfAEAf63T5ijzN/e9W9mTmg83yyPjlKNo=;
        b=ceRpxHyMvAEc++M01MAbHyJkLs4RuBVEf2EBhFwRXn16w1CjZHTG2IYdofkLeTDoc8
         rspoXY6aCXSvSQi2lHW9dG/xEmolFQ53B2jLnPVxXceYeTvYLsCNpUSJkO0aw+0GzSWD
         vxir3htF5UGyEgUuLuyOITaxhTJKEcTWfUHlX3bE8zdENnRMnn7z38ejKh17xhQnC4xd
         2ZZOB5VmmTDkNNTJPORS9vbGG9JoAKD/6IBDImJDdzp5FfhEhFjHAjuS9gkpfSsimsCH
         6TWOyusWEKSp9+SFF3m1gDNebcyF4zvHthPvRE60d1LEP805oftWtn6C/qPsKPmKSqYy
         cAww==
X-Forwarded-Encrypted: i=1; AJvYcCV/k8sNgZ+MlPqrsgQB/CKfN+n8wGYWyFxw+DeuL2al18kYzaghnbUOzZugEZzv14Ls3IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnDoG/JSQn1sfU+A7+JVfdm25z/N7ysqMjf1gLVAHzM2mnoqu
	MBO3n4W+dPNoL6IUsuBsMJeJcVpEHlEP/it+s/TqONv9nzVrPMQBWhEh
X-Gm-Gg: AeBDieuFYRqFMXLR0IGRrT86cjnlcg4fWS09QN+qj+DY4SBFqyUr2WaHlU07z4RgKPq
	FfJ8vXsYQ9Wo1/UDWwn3AVvT8uDzHilwRZrE8EADL2ezhU7q43wcqkw78Xx3SgQ97XLQDUQRXuF
	2AmwI7vGbiSKF4jrJ8fz+nCeQw44l8V+K2tpBx9rOdLLx21t5g/JHUTqHqU0vnv3IgnGt8zjidx
	wO0I/4e/69ruL2OdttjbtQNi674uEsoTxTIYSFt5TwFaPrC0DuP3vBdTIIm59FIUKUazjj559t4
	zv7N1+U7mo04nSGPkvWAfEMXvJg+iQbRjwatzEkvlSPgniJaQ99fa/iFW7tMqGkCYRozIScdFcO
	dYIiu1knl9f3CSqYu4ftkNAXKh34/32iGMY/FDvPsLhEf4D08pScjNlbZiOfnxCVyoj6MpiSCY7
	FRVZO1MV7hWXE1RWkCklSCcGLg3MmkbdtE8b7KRYNmnqW5TpUAvONJdSCgm7ocxBEW8AFlwOw5l
	9Uq
X-Received: by 2002:a05:690c:88:b0:79f:d961:47d3 with SMTP id 00721157ae682-7a4d3ac7a52mr210788537b3.21.1775661028199;
        Wed, 08 Apr 2026 08:10:28 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e42ff26sm89073237b3.9.2026.04.08.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:27 -0700 (PDT)
Date: Wed, 08 Apr 2026 11:10:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.245c592e6d270@gmail.com>
In-Reply-To: <20260407105005.1639815-6-nhudson@akamai.com>
References: <20260407105005.1639815-1-nhudson@akamai.com>
 <20260407105005.1639815-6-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Nick Hudson wrote:
> On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
> according to the decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}, and
>                                      SKB_GSO_TUNNEL_REMCSUM
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6
> 
> When all tunnel-related GSO bits are cleared, also clear
> skb->encapsulation.
> 
> Handle the ESP inside a UDP tunnel case where encapsulation should remain
> set.
> 
> If UDP decap is performed and GSO state removed then reset encap_hdr_csum, and
> remcsum_offload.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  net/core/filter.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f8d43420afb..04059d07d368 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3667,6 +3667,46 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>  
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM |
> +					 SKB_GSO_TUNNEL_REMCSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM |
> +					      SKB_GSO_TUNNEL_REMCSUM);

REMCSUM was previously not included in the series.

It is a non-obvious and rare enough feature that I would exclude it,
or move it to a separate patch.

> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_GRE |
> +					      SKB_GSO_GRE_CSUM);
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
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
> +					skb->encapsulation = 0;
> +
> +			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
> +				skb->encap_hdr_csum = !!(shinfo->gso_type & SKB_GSO_UDP_TUNNEL_CSUM);

Since the flag is never set, only possibly cleared: just clear this field when clearing the flag?

It appears that this is only used for deprecated UFO anyway.

> +				skb->remcsum_offload = !!(shinfo->gso_type & SKB_GSO_TUNNEL_REMCSUM);

Always zero?
