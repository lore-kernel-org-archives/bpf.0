Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30539FCBA
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342740; cv=none; b=eYUTLRtcT3EhBAT35empZMlJSZgj+z2WmjdK0087oWlfMfO5nZfSdChSkZvvvncwju7rRD2Eew/aPq1CxLI6x6+NXTofJJ1nD0i353a2UdVzIZ2w3yMHNy1YE/g2RrKIU2dj94loF3LrR4FlU0y9eCj5TtuymLGdL9GNXK0Ep0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342740; c=relaxed/simple;
	bh=ydAOpVCxaRGkSIoafmuBHFbulVKKEekBMag+Ywm0+ZQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p71TDvo48zZvF3aJLase8Z+S3XNz9sw6AWHNgb0Oh20Xsaj209QYK91pqWCKRKcygiZoXBp4ZlgPIKtrtiJObyhgBz/jVowa8FYdDtOWfiC+Eyd0vGcPlO/A2gUrLFhpwNJ6t48d5OR16nIGUDIpBGkCCUb52aJKbJKGMRBZ6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0lWgpDC; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0lWgpDC"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7b23713eac9so50832857b3.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776342738; x=1776947538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cynS+faVTPFVRdqWHrSyVI/SVlDQMOa5TP6GL64bMWc=;
        b=i0lWgpDC86BgdDo2jVoVzTjLVHmICOY16xDo9g/PF2qC/ZA/HrhemCoKLYgIpekUNh
         5m8FYqtMsaO51BJXwaciJAUknGa1c4qV815pWJa4/fDgnC/O9ZYhiv+IvptB6WMBWeZL
         MAgc968SIfqwZHDe6UkdSIOUANlDu/BtQLyuu+ZlY5J2nslCailSPB2ZRFEKFLDy5bgf
         HgoBqYUFGTjWgU8T7ogzm1wjzQ6OASJpd+ml8hSZlBoa565IM3FSi27eH6Ho+bzXPTwD
         70+6M292UMahgrsfnyTP18kG6+Kbj8oU7W8WpD9WzbvwS3Ex6oiAL8l7lD7Gj3yUmEGn
         FsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342738; x=1776947538;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cynS+faVTPFVRdqWHrSyVI/SVlDQMOa5TP6GL64bMWc=;
        b=sppW4o3KmhNh0qvAutco38Gf56S7KYRT+KYG3VGkld1Q6AHSE+jJb/tvvTC597ZUNw
         fi1KOKo7vRgOYJU0k4P8SE5M+SdHzGEfsTKH0QacZtpPq5AEj4408OZoaAwqyyNxA2js
         sFhK69Gzp374m0eBmgDpIXy6bLIj2IsWdXJ6V8AIVDGHbqKYiZIlkFJzW3xu0TRisqYV
         d2yFJNVgyzvqhAko0FfcOpGcye0FYggsPfL2Knd268XWfdJBipofJwJKR8XMkArdfOlS
         blS3S83FgY5Vz0s0RoS7yT9aVCVicAuB/tkWca5P/jiZSWdTyMzIh8e0THGzXHHEO3Z/
         y9PQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uxU5W9JBTKrxcJlcDjvOgx9UjXei2AWRyqhgpvjCkqxPHx5rODkOz/TG3LQy5QCik3io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3wQMX+3EcCHOXsKlb+trxwkwOPVWJ9zmP8pSAuyPul7pcHsz
	wACg3ZDjsrXjfD8b782A9vq2gxjh9Z5F4UVv7Tg0WBwnFYwvXVRvhvwS
X-Gm-Gg: AeBDieulnMJpYnxZOS3qpEiqw4ySIp3WrUmHZGNeGNEOlw6BK4l81Lv7EgU9RbipnTk
	Byqg86yGqERQJfX2GzX/cVOniKmhXW4HV71aWnZU1hu58b3Mo2BlKWedn6JlzGtGgTetBZLUBal
	1xQB8zSy1RexhjcfaxO6JK8CL6Akprb9GVzUNWlu1nksCkFDr9kfHx+cjhkBQHkDm910SWq1ANX
	nS1PukZTh+ylu85uvgVYsR9OvEP1JsGxOVSskZhIyFwvXDA4ACrlKMxihDdD8z1iZs4EcyZARKT
	rSj+yElzGbP2C1qTYbOI7jaL04pWXBExmr7hvp0C+6LUKVGr70wjd5Ei0t4le8oqTOPTr8YkXqD
	0SYaWEyVazrxZ6FlvyZAok1I09hBLcKGAmgBUFtJckGJ65Fx5OA9tWcxOpfhOioidSnzNaZKzm+
	Co/2SN8qykIDGLrvxo6QIkKdXIb4Td2lkC8LOu3TVPKTM1NMmGGL4cjWewN9s7h/qhm5yTwlcGn
	fjdTBfCF/Mfr6w=
X-Received: by 2002:a05:690c:6987:b0:7b6:de92:adb5 with SMTP id 00721157ae682-7b6de92bb2bmr84653277b3.49.1776342737764;
        Thu, 16 Apr 2026 05:32:17 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b769411295sm21733707b3.42.2026.04.16.05.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:32:14 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:32:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.30d031033dc61@gmail.com>
In-Reply-To: <20260416075514.927101-6-nhudson@akamai.com>
References: <20260416075514.927101-1-nhudson@akamai.com>
 <20260416075514.927101-6-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v4 5/6] bpf: clear decap tunnel GSO state in
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
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}
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
> If UDP decap is performed, clear encap_hdr_csum and remcsum_offload.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  net/core/filter.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f8d43420afb..e113ae2f3f14 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3667,6 +3667,44 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>  
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM);
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
> +				skb->encap_hdr_csum = 0;

This field is not used with UDP_L4.

Similar to remcsum, I'd ignore it entirely in this series.

> +				skb->remcsum_offload = 0;

Why still include remote checksum handling?

> +			}
> +		}
> +
>  		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_type |= SKB_GSO_DODGY;
>  		shinfo->gso_segs = 0;
> -- 
> 2.34.1
> 


