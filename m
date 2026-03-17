Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B06248F54
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754224; cv=none; b=KRJJzxM0v4Zfd1dnYH4ML1PqFx3WJiwkuyqRkU/g7YBr/u3wlR+J4j7m3zYy6HRfxYOtQ8yZPCwt8arNhc2aME5To4RT27KZTtv2GsVxeIVRNIn4j05BxZ4WiYJ45TbNVEwGbGLKBKeyTLsfMsjS2Qn6LqDam+/++kc3s42R7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754224; c=relaxed/simple;
	bh=WTklFd+xAu4hGzmNTuliFYPoc4TDU1mCc0XJBj9j7Ic=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iwCojUuXUd4Rf8k8kLuvB5IohNmVaRQrpFAWZHvsZhT/YaDFqHEKnGHmnrS5G1y2Ak7X/A4caXlKkn4GglImorAXy/P5Nrk7oJw29ZhBvum+mdI7o123xlCDUL2d8fJC8MQxGe6UFJ6fXyBDG/PFatTQP5JVzE43NgLFuvyPKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcay63gh; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcay63gh"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79853c0f5b9so44264567b3.0
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773754222; x=1774359022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+OZHdz7JUIXbfLO4py8nXeTNKDtHpNLhBh45s0nxME=;
        b=dcay63ghRmUbcvLXKdLJlS+RJrvic4H2PSNKb0ztxbdB4pkFo2kKaw3Qk1nbIppe+I
         rFhSqt80K3+F8PdhvQVyLpiAZ1kS0p5pTXDuUiMnqwsqTYYoEDLFycvmltjewaxhYb87
         VAKMefKwMAL9KUf1lpcjybKayzgoAxdUqg/Wp0cvbE1nQsTYHCkfapyxd7fjR9AKG862
         qtr1Ha9mXF8nz3Pl5eyYW/2G5FZcPwS8ydAKPK8HXphVtdCD5I425K6Wh1QAQYV86Ymk
         ef9kpb0wSUVmWKHuToc0PEkyNYBIlqHsz7n+PLV2sk1OraYVl5aPVTspBzdSkj83EGme
         N9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754222; x=1774359022;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+OZHdz7JUIXbfLO4py8nXeTNKDtHpNLhBh45s0nxME=;
        b=SjVBS0Qe7bi+tbmlBxQa1Vbbsgw8gpA8i3geKgOwep+Vauw6vzV41xa7UBpEnC20Zy
         HXO8+BtcWlBkkq7+M92nJiw60py73FZM96iKaF+XMMau66zCPuJy2ANgRNLWur92T6Da
         H1YtY+/O1YkKa2kxY7Xpt7V6XNE1kUD0JXVTA+3aGYU7ZskKPnOo18Um7U8at64GAKOB
         vrigU0IEW+9plOHymmbdUtR94Wmt1g8I59kuRcJzj6fz+Ccc913oDSeHKo6Kjoyyud7w
         By4vnMQody5BXHb6NAUc6DzFPM8iDA4EjlQGKNIN7VSyijrrS74Z4WmpGmNgOlofeQVR
         A9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVoGvCbWDdXMcFutGBBS16WLe35+ACGE+LkSx/m5WSscOpZSby9rWzlvcOW3cTaTzyHw04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jJBFj67D+WzOkpziIkNp0ijhrf7YPPnEKKj4gw4gp+5Ix5gN
	/6TWD06aNj7BXnK+uLupMKdj/Pr13pGLilhCKQCSAy9/njJ23Mvw7VbTRpBjgg==
X-Gm-Gg: ATEYQzx+JKdx37ehf86bf9OfXKSQge/ezZRclahRe+xLWtujh2DG7d60rDji32f7acD
	uB6OMBHRIrHpfLM1OXyTijtE3pP6R3KoVAKsDI6L3P9yu5rRarlIo9KzWCPp7WJMmB0M/WZWm/0
	nmj3Hq+KC8GfyfGrqA+AtnCWsGqtgB2L7QRRdFzfNEG9kJXVp2HIppaFwRwmhlCgpM9kJs23MGT
	PLBUsaAjxrgXN0p+YKYuFp8PBLrr0rg/oBoiflw7ZP7dj0dJ29inlh3kJ/ijT9hGMDvOU1m3buj
	GyIduzV+QJ0MQATxcutzXi+iFvCBn6osO0WFtSdFbvBJtQZ43oAR7GKTUOQ655j2SUSPz42EwlI
	4VTglbP3cNhjSNZIRni9xoeQgERshLk08M3/KDCATvLV8l239WDHOFPGxcPgNltd33XaE15gz0I
	ffFPudvCSxScvxMiJc/PZ8WH9Bk57kOqiD9xboGQ/Q9I9fSXbEUr/j8e3tORahN4iXUA8fNeJpn
	M7H
X-Received: by 2002:a05:690c:84:b0:798:c349:7207 with SMTP id 00721157ae682-79a1c0ab6f1mr165122397b3.4.1773754221917;
        Tue, 17 Mar 2026 06:30:21 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a1688ca84sm78216867b3.48.2026.03.17.06.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:30:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:30:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.4f5a568542ec@gmail.com>
In-Reply-To: <20260317121429.2399539-5-nhudson@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
 <20260317121429.2399539-5-nhudson@akamai.com>
Subject: Re: [PATCH v1 4/5] bpf: add guard rails for new DECAP flags
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
> Add checks to require shrink-only decap, reject conflicting decap flag combinations, and verify removed length is sufficient for claimed header decapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>


This patch probably should come before 3, as 3 enables the features
without the guard rails in place.

> ---
>  net/core/filter.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ac7e1068fe4c..437e0da34f84 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -56,6 +56,7 @@
>  #include <net/sock_reuseport.h>
>  #include <net/busy_poll.h>
>  #include <net/tcp.h>
> +#include <net/gre.h>
>  #include <net/xfrm.h>
>  #include <net/udp.h>
>  #include <linux/bpf_trace.h>
> @@ -3745,20 +3746,46 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>  		return -ENOTSUPP;
>  	}
>  
> -	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> +	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> +		u32 len_decap_min = 0;
> +
>  		if (!shrink)
>  			return -EINVAL;
>  
> -		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> +			return -EINVAL;
> +

Are these equality tests shorthand based on knowledge that each only
have two options, so equality implies more than one option set? That
is not obvious/self documenting. Please add a brief comment.

> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
> +		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +			return -EINVAL;
> +
> +		if (mode == BPF_ADJ_ROOM_MAC)
> +			len_decap_min += proto == htons(ETH_P_IP) ?
> +					 sizeof(struct iphdr) : sizeof(struct ipv6hdr);

MAC is not a GSO related decap, can be used for insertion/deletion of
L2.5 headers. This should be dropped.

> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> +			len_decap_min += sizeof(struct udphdr);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +			len_decap_min += sizeof(struct gre_base_hdr);
> +
> +		if (len_diff_abs < len_decap_min)
> +			return -EINVAL;
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
>  			len_min = sizeof(struct iphdr);
> -			break;
> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>  			len_min = sizeof(struct ipv6hdr);
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
>  	}
>  
>  	len_cur = skb->len - skb_network_offset(skb);
> -- 
> 2.34.1
> 


