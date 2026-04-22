Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDD37CD28
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875495; cv=none; b=koYotxRNZ1RxldCpNcgY3f522l/rdJRM4AtgUX8aIR4Q6zzSbPxPt9sR49VfwpBch53xwDCAs2Yl0mFcOwrTuYUgfuxu/j7IxY2t9Q1crlp7M+MLI2zH6p+GfYrRQ5iVId9+LVfx3cJheelMcCTL1oii1MJOm3ZnnQfKFJBN+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875495; c=relaxed/simple;
	bh=ZhN0moLeND6THuDELm2QNMsMkjLuTrdx5gIvE1VuA6w=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=jEhjlhXcJ0mv1EUFPjPyZzqv++os9Lb0P8thFtaoDFfZPQfjNZ4CMbCQHDYk1Hq+zcjIpSo0ZXU1TNRsfNs1WPs6PIBcnF0qyHLILysOz1PB39hvkCGZDvChMCu95f7sX9QBHZ1F51oX+TUPhRYEJhBL3/50fi7c1omin7w8klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHpm4dTo; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHpm4dTo"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dcdaf06498so1356268a34.2
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875493; x=1777480293; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XYSB4MPFe35gJkP7o6kqvgTpyWAy68boQJL3k4gHv3k=;
        b=bHpm4dTo7yWotFXK1bcBNxicoY4DVz9nSwTGZoYrqGVCxjFLqp6IJIMvKdj6ZzoHY+
         XHeaJyu7u6GpbyzNKsF2SquBJH3HO2FJLDwcEK0gsftq4xCRs7eC38EDLn8hw5+eKJjs
         loKmpbIe4ZFkxgaXKXTdAH7ZfQCa/QxOBk3KM3q6d6y5nlg55TwG2R+M9Oun9m2x3sZT
         uJgGhB4K0GsxxJMaNh2jUCZodHcirCyHhmxaEdtyTlMEgQSf4H6Bp9G4WuwInuBrWenw
         Lmfe8Y2bGnBWEYxCs+d0F0TRg3YMerJVyDW0G4UBraZTpXnUZdnS1b3LZYWBhuoYZfAB
         yEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875493; x=1777480293;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYSB4MPFe35gJkP7o6kqvgTpyWAy68boQJL3k4gHv3k=;
        b=Kw+dJK5KfYNn/5AWvjvz/28kvFYASD60DUg6pLHMd6VlRNcmjxykvN9XyGo0r89OUw
         uLok8SEgLlxLhn7c6rw09lydsB/zf988KgLQbu1qFoH3LtuLCP9g4GWnjJmDuYGoCGxo
         ZLqVODRXXJCYwz3aSmzeOFGpl6Xgv/FEFZW/TolZHdlzWLtbDQ/oDunG+RBy45yKjjjQ
         nPY8M7D3ivSH8f/XlCiwJ0SUMhQOThEMofwmIP68wzs+7dTRgmQGC+p89muy4WpDgvez
         6oOVtfkkdhVmE+w9Ev6/YQuy41grzMHwlLudzchmQf4B4UdijMjs506hXknCTOOZpKGE
         JiRQ==
X-Gm-Message-State: AOJu0Yyi0uzMftluGaHc1B2hEEZZ2F/0cqj0vBgszpR7N+pBIlyeVOg0
	iHu8P1PJLSMePK9OYYW+PLqmYk+ZkmNEo7fFI77EMhGXJznwkBrdGy3c
X-Gm-Gg: AeBDietj1ipFEBkeCnXhXENL//MK5e9SzUQ/7Ri7eYn4W8efZrcNE1QqXrl2lI3rmPz
	eVQKSxCKcUNWdKbTcGbc8cQPhA1DS37wpGKgXCCTccTmsdI48DIoCsvT2wZeqYciLGpgfOmCEJJ
	T3aUOiKVI6pIHy5haLm0PcFW4YDIMKnVavjPGCvtRxaAWxMWmL24QEfoOw2OsT/JJrbUPTRbGQD
	l4AeVprIKQVFWzxLs8QneML95AEUg8PqwdluFMhTuaHP2LfXMUSvzFXWYCiDEj8lwG83VXhTybF
	xxhPKKIHmCLbcPK4uMlWTCOlr/GbKmvztGtxna32C+ykBliy0cdtzBIs7mAKWtzN/eqnotx/9au
	I3xw2ekF/JRpv874U5WzEDoYywJjOG8qEhhcyOIitnchn+rSFOUl4RB/gvbV9yUCEV4wccBhb3G
	8pZCsf+4TW9rUKePa5DzjmlV+k0TCQ+DW2B0yiwA==
X-Received: by 2002:a05:6830:8d1:b0:7d7:5b78:ef31 with SMTP id 46e09a7af769-7dc94fdf204mr14413587a34.12.1776875493446;
        Wed, 22 Apr 2026 09:31:33 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dce5c346adsm2386228a34.27.2026.04.22.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:33 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:32 -0700
Message-ID: <e3906107e27c4fbb9276d94ac3362066.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-5-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v3 4/8] xsk: prevent CQ desync when freeing half-built
 skbs in xsk_build_skb()
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> From: Jason Xing <kernelxing@tencent.com>
> 
> Once xsk_skb_init_misc() has been called on an skb, its destructor is
> set to xsk_destruct_skb(), which submits the descriptor address(es) to
> the completion queue and advances the CQ producer. If such an skb is
> subsequently freed via kfree_skb() along an error path - before the
> skb has ever been handed to the driver - the destructor still runs and
> submits a bogus, half-initialized address to the CQ.
> 
> Postpone the init phase when we believe the allocation of first frag is
> successfully completed. Before this init, skb can be safely freed by
> kfree_skb().
> 
> Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
> Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index d23d1b14b8b4..88ec6d2cbbcf 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -739,8 +739,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(err);
>  
>  		skb_reserve(skb, hr);
> -
> -		xsk_skb_init_misc(skb, xs, desc->addr);
>  		if (desc->options & XDP_TX_METADATA) {
>  			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
>  			if (unlikely(err))
> @@ -834,7 +832,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			if (unlikely(err))
>  				goto free_err;
>  
> -			xsk_skb_init_misc(skb, xs, desc->addr);
>  			if (desc->options & XDP_TX_METADATA) {
>  				err = xsk_skb_metadata(skb, buffer, desc,
>  						       xs->pool, hr);
> @@ -884,6 +881,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  		}
>  	}
>  
> +	if (!xs->skb)
> +		xsk_skb_init_misc(skb, xs, desc->addr);
>  	xsk_inc_num_desc(skb);
>  
>  	return skb;
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
