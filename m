Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEEC34028F
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864178; cv=none; b=b5/fj9UZii8c+hIsk9j+yGE0TRVUP1oUX/SE5PBNduy+N962gZ3ugydxLro5cu7+KbSKovgTFkdwEd5s2epLuEymxhEkE0jMRS9dsgUgzACOAKrosjosn6ktritMoLUICkHe9L8nIJ0/ALeZZlNhEJAkFZfX6Anmn1TaMvfAJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864178; c=relaxed/simple;
	bh=cMCaVXNr7qfEfiS9Zxjes22PtZsQF6QDYQ+CpJPrpvo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mmGWISvKfTJwBvLlxIEXkxzUtK1GqjVRP9/40t/sISIhOvWjWJ08XZZNRHWOMYT+rcJ3HhIV6o5g0BrTj9gSwcmiclt78EoHZ+R05q5BzLcImuRCSRfgiBqK46/C9MozItTSD/q9fXnU0PtO93rTfzUMSMIm66CjrJVDRNyHTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbKs5NPK; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbKs5NPK"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ca423ad53so418906d50.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864176; x=1774468976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BGJyg89KVjKDhlLon0g7DLh+7sfd3j1XaPbD798/2Q=;
        b=JbKs5NPKR+VmuZ5DA58w+uFYFmT/HICtg4kwVVIG0QsZDZGeFIGmFlLmt0AIqtxJiL
         MTjP4+n8mL4LCk/0Wbkcz15HidudHCX9vwXeXRYehAXKLxV7YEcU9zC3CS0DQn44Lk/f
         QDtDrYCLtdYiSy8oupHW/NDpxJjUXT+aU9Jhc5jzJt1SVETOjyRkqrrSV8xhp/E//+bE
         jg/wo1w3fUhWHWoHu1ku9nWMYv+uWdbs7m8zFNcIZMsOa/GJOS3DNlGkvhRGl+jujRUh
         95usvCWmGIVtKVTW09SRaCssrL02vKWxhkfJeHWugGkix3iUX6eHpIesrR3HMKXe/qsR
         6ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864176; x=1774468976;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BGJyg89KVjKDhlLon0g7DLh+7sfd3j1XaPbD798/2Q=;
        b=BGBAKLdlkay/EQTpp38b0oExPBzy8SWCcopu71xObfr/p2ne+UaFLg1WkLVTTPm1fg
         Tt3xMwuBthnKxKmZTdIJEq7KT9o3hI0XzUeMe/wdtm4GYJXtAk4fIOXr1yThVFpLXWPh
         cS5NzLELOX55yHmCK5HOm6B1LHH781IrD7vdfzyzW/7gxROB00WPULq/0wlMikXuPUfc
         AzW+xPj3sxzhi/aLYg/rfE507Ovpm0jfYdIV0QXCGgaH3K8454WWQOanmRDl/uu0Ow1T
         sf/PNkv/hjleHmnIltcd9j6SNCKpFOdqf/IefT2YOHS75TL+BmYYt0nDiuV/0Y2zm+pw
         wjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYFGafJ4w5cuKH+6QEZ7WPUDeJMle+cXphLj19q7FYPF+UyVkcrG7fzzGwf1yNZXVQYOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7M3CLu+980nkyv+771c897e4Fp0uVaYtfLlFZ8NpYatnwB+O
	h19oRU8DE1zxppicEptKi68IUZaIyak9Yx3Zaro/pw1qbwRegxHiwjgb
X-Gm-Gg: ATEYQzwBLJ4N7KvhJy+lg9xtzhnYBjIBtnvaNopG3vSu220nl9Y+eYCg/8aIbQrhSsQ
	AaBk+DBjpLao2uhSV7YxIqzpGBpG0xvdF/bpvyoZ2a406pJnlwskEUqLfBB6lzB6j9klRHp/PMJ
	neUraO4to+ID2Dd2b+Mmxr8b0Cpu0B0AkI0NwlHchn6OYaRpYtU+KPnGuUmOwZDc9OSRGu6DqqJ
	60AD2bl5g/okq0yzhT5gyTMOWn166L/hNTQ2Hzn3WZU1pHk4gpEV33LgRiAARKV4+piJAXE0B/+
	vBtplBTnvBruvjnMwu6iaX5PjaHPxM/bWMRjq2VHdP3r94sPDU3ngZRuMKfyvG2xztJ3xOyHU/d
	aBp3xAyc/1HBbhhGfWlfco9xM1DhLWrSjXV0+SEOP2MYTqVJsX0p8CFr8nBUBcnQFSCe7yLEYJu
	OFue/lKHjKPAPLSsTAhOo+RgaFx8zZy6crGvbg3KGfE849G0Q/SU35ZRZoi7hJKzT1pwglT5BZY
	j6z
X-Received: by 2002:a05:690e:389:b0:64c:2207:52a3 with SMTP id 956f58d0204a3-64e916162camr3569426d50.64.1773864175609;
        Wed, 18 Mar 2026 13:02:55 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64e91be032asm2180679d50.14.2026.03.18.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:02:55 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:02:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.26b750d5f8926@gmail.com>
In-Reply-To: <20260318134242.2725749-5-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-5-nhudson@akamai.com>
Subject: Re: [PATCH v2 4/5] bpf: allow new DECAP flags and add guard rails
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
> Add checks to require shrink-only decap, reject conflicting decap flag
> combinations, and verify removed length is sufficient for claimed header
> decapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  net/core/filter.c | 47 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7c2871b40fe4..47aec44a9cd3 100644
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
> @@ -3496,7 +3497,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
>  					 BPF_F_ADJ_ROOM_ENCAP_L2( \
>  					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
>  
> -#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
> +					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
>  
>  #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
>  					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
> @@ -3743,20 +3746,44 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
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
> +		/* Reject mutually exclusive decap flag pairs. */
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
> +		/* Reject mutually exclusive decap tunnel type flags. */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
> +		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +			return -EINVAL;
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> +			len_decap_min += sizeof(struct udphdr);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +			len_decap_min += sizeof(struct gre_base_hdr);
> +
> +		if (len_diff_abs < len_decap_min)
> +			return -EINVAL;

Should this test come after the below IP flags?

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


