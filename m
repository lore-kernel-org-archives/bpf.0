Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4283344052
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864571; cv=none; b=Th5HAQSgrtzyfL9H8QYlxY3BhkkR7ZNC6du/0qMDsX1EAYaoIE5QIVvblrIFiYEj48C4PMijwKYZQcBf0gGx9tucHLzegHzlt+6fl6+Gx0nhS1gVPchd6rK1DsI4HAUNqfo1AkQL10PDy8p/Fq9+AFwL42Hv9cW+C5tbDbaWnzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864571; c=relaxed/simple;
	bh=G/CSiwUSEOqLczHCD6ZmlD84NXvI596h7Wx0J+y9n9k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J8DSbdc7vBtAmLBPJvYCjEUmv1fwmQ3e1u7lFZjAg7WtjK4Tnc3MVPiNeIip3ouw9XBBQ04p2/i93Lfe0PVjtWbuIGuo8cbvKOPsgN3zOsI0dkdN7VsgMoY5gtYdvccT25tkCqG524m2AvUTjzltxYX+RChYGEPvmKPw/PaQr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZMYXdmD; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZMYXdmD"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64e87a81639so423630d50.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864570; x=1774469370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8FFlAehcFfcN+ZVaCQWmsQGGFzkurvOjaypfavq2lg=;
        b=MZMYXdmDVzHZa5p6P7mAka8KD060PRXBRA1yAuCtDEkKGNO3oh17HBS9U1Ym6oboEr
         Fc7buwL31S0vjxP6Vcz0yG2yw8SNf2VykEOqSfB6vHkpzQE6Hzqg1uE1f6GuYc/bcJLD
         WLsNbFssjONpqsSZfrab5oPVlRuQ/XgK3k9FLzmHpRx2OBJ0ZIyn+4VLd3BkApZTHdlM
         ZmGoK+NO5DQXX/ezXG1p6bod9EsghRQkhdup+ZuZce62SQVJAgZisDI/rdO+pRyciahx
         2bgv/OSR5DR/0EGRzx8CJRyXUZOSQX6031uikbsfnt+bxz8X0rGwVG8IOFEdSHqPbkht
         IHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864570; x=1774469370;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8FFlAehcFfcN+ZVaCQWmsQGGFzkurvOjaypfavq2lg=;
        b=a7weXyS+BMb/hBxJYbuI3GUyDZnqcdEaXQdsgJeJhuqzWZqFiAP6l6RbWZG7i454lK
         5cPgdXlk5eeRBvBi/fP5S/v4JZXuAi/yTrJY8+PykcOFPNQ6dtUzgeLzWHTFq1Ytd6DZ
         3jJuS26WOaUOEEl7v+LKqg9p/JiAW5yU7HV2/KB/NKoU2rl3ZQ5raB6TyhoUFy6iSqr5
         6ELtnr1pO1vWaXMmqPqbUjZn5s6Mggktp7XHwHOpeyGmz6yo6IvGREOrZDQ+49562d6c
         hgE7nNvzCpN0LOcJJHAvOLDamUpL3Uwl6Qs/e+TEf0Mj8NHc3cw1hGHtwCcIs7h0dDT0
         GEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwzPoQ6OXL7MXd9T1nsuqhi1l+rR5ql0fI8T7E1e6egmyqXVUwCtajb2w0Qm1PZU0tJSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rp5DEAvr+2LWUtbzhAKll1d+IHEqM9AFR8/nmpJSLo2RQMen
	L5xodUBnC4Y8n6G6FpYn0LkI2mdZHQBbbYixqqind9TkindSxf9JBXdF
X-Gm-Gg: ATEYQzxOSRI6kZDQoz2BN2HGN6JyV+lwTQbwsIJIfzhGRc8WyHBTGAA8dq3glZgtUdj
	F874xw3H+bYpz9wvrHaNaYS2L/F9s362nvVxvAkZkBns7VF5rByxpIqqk68M1BtQ0PZX+QrJgbq
	X1PQuEZQ/bUyu/amKfo4tZYFElvNbhHolLaxNrAcNDjQ7SKMV7gxRBqdA+wrHUctBQG9Pbcd8PK
	VM8wTaAXzJixDWPGYIe192tYPMhxUvR+JaQT4qnyaGEmti+q5FEuY0fHP6rLzTOyenppuOlc6hM
	HDGt6ZS5Pyxq9nsNjGkCZJtbU2fOARn6af+C9tNls8OMARHm06ZBtIARj8gJ8SAx5LWEXbJYkdF
	44j5izMHlHuUxhwaoTs4CqlA5ZwDmc1bpU+VEMQHcQrXmE/TqtX2ALBKVsv8qA3utEWOjNGtxhS
	56EvbTRbdYCkg0qPrt/iKt1dyU6W9u2dNd1vkbwDwtvmuGtvIyikemC91n5vdhxtKFhu1cfSElB
	sUi
X-Received: by 2002:a53:ca02:0:b0:64c:a49b:ed78 with SMTP id 956f58d0204a3-64e915bd965mr3283791d50.38.1773864569681;
        Wed, 18 Mar 2026 13:09:29 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64e91bb9344sm2236439d50.12.2026.03.18.13.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:09:29 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:09:28 -0400
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
Message-ID: <willemdebruijn.kernel.2e095812836bb@gmail.com>
In-Reply-To: <20260318134242.2725749-6-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-6-nhudson@akamai.com>
Subject: Re: [PATCH v2 5/5] bpf: clear decap tunnel GSO state in
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
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  net/core/filter.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 47aec44a9cd3..35af1199ab97 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3665,6 +3665,37 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
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
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +						  SKB_GSO_UDP_TUNNEL_CSUM |
> +						  SKB_GSO_GRE |
> +						  SKB_GSO_GRE_CSUM |
> +						  SKB_GSO_IPXIP4 |
> +						  SKB_GSO_IPXIP6)))
> +				if (skb->encapsulation)
> +					skb->encapsulation = 0;

Is there any chance that this might clear it while some other tunnel
is still active? From a quick grep on skb->encapsulation the only
possible hit I see is SKB_GSO_ESP.

> +		}
> +
>  		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_type |= SKB_GSO_DODGY;
>  		shinfo->gso_segs = 0;
> -- 
> 2.34.1
> 


