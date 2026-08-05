Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCED468C0D
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934139; cv=none; b=MA8E3nKH6r2XNM6xbFp0130uqb0XQXEhGvAKW06g1iH9sO1yVUGPzM0tDWKvXZyGMp3z2dw9258jzv8LccT8AsOKPPN8FfIz0KXmGwy+d4UZrZYBncUh9grT1qjQc63FUa+pFu2Kr5FxRNlvpB9hZxTvp4CAiy17QnHzS2kGCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934139; c=relaxed/simple;
	bh=kM470gmL33Iv9aSAOr0xztTIhSMUcmHJisJS6g9iA4U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FVv89LAkeCvxFXZ6YZFcyy2RhxRGButxnDPKlgJRPmLi5OzQmnCv2SzupZBkEmXmgVwdbEjD4qWpAYaAsni39C0sdpu8LkOFClu+WH2Pyf6UeERJlWvIuhS35aLqNJqpsNS/0pQZzyEB11pXJ+Q6CkZsqKwIIVpygGVBY93ZYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRAu6Hwo; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRAu6Hwo"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6680ae2031fso892989d50.3
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934135; x=1786538935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fDYKkUKm21fBzkrus0DJYqlBResm+tuLY/EKfmGA+zg=;
        b=RRAu6HwotnhvqoUKmpcIkvV2RNe+APHPyRiKn2RBRveD4A9gDrzbx6icfbxWHL2l0c
         JUzmK28yHo64ke7Hg7WON938v6kXsKctlWoc1TPkofPvjAODYSxcLeQe55/k4xnTyoiN
         5EQ/NvD6kFvj5WJiPhe+JTs9sAIcI1zBPaLnPh84cClrKNsgy0tgrjFv9X399HYNHMnw
         BNvMBENt18VSJfIdhPBKzJKLFU3oOZx1dAeETBNzPy+G+/hGTgCc3fctFoA8Z7mlojl3
         sVgUbNc+hnzJR2+y01MwI1+mVuu/IZLhMXa24P0c3An0zFlyYcifYS8UGg53YayK2wbW
         xmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934135; x=1786538935;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fDYKkUKm21fBzkrus0DJYqlBResm+tuLY/EKfmGA+zg=;
        b=Bu9tqSA9SpvSvJ75xapTOe/RP+sphK1A5kvVXexNWrDhb/GnZvTL5iPu/lSQxKQ7T/
         XTyP9QuFnmNHi7+GpaziciQ2r0COELFHVVwq6t2jpF8jKvJ71pfiWR30iP+zmAKUIKI5
         y47fT+zdDgfNSAVQcU2+6vF2rUSMDxPQDu2tA0J2oGBSfWAPTjOzK84OsXppZ+Ac2yPN
         K94zYRll2tkQTLQSoFemx6gckRlPHtSSiqerAKGTtqm8t+nTBkluuVsGEKCfWZLlEb1N
         7Avuj/IuOiuaaMZiVCmtU5P/c78YXvdSoExca46WYvB/estGiSHVfy0zSIvq71FzD804
         Wppw==
X-Forwarded-Encrypted: i=1; AHgh+RqK1LN+rTFeMic2B5/l0yBIpPm6lOVuXkQoLhl6uQLvjrbb2hy+xSfz37k+gk6Rr9Nobuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwbjEgDdNXaoxOKBQPL+ZTXs7gfUrHIftGznSIIG3rOgvNxVfQ
	66NJEHHo1c5lmENcjmTyG961T8F1mE6EHUv8/rZvw6GsOa6fQbCtGDJy
X-Gm-Gg: AR+sD13zhrh5fF/M3Hvc+nL0dgQ3jK5ED2FteBx9n5g4N+mJe+Z+e82JSQpbI8rGkZX
	Uax4cEyPoXTwyk0CZq3eyK5Zdi7uwh/ysuFpwc9tJrNQqQVDaWcL9Fo0PgynI6WW3VxOJ7sm8R/
	5v8rMJmpoEOVnGsYzcwo/6rhyds5lObefTXvhIN03vKfL4HH6TveLAY5HKIoXZZG63p+wmPiRec
	2wD6VJApBRdx+yEjUm61ZoqAwai+FMVy05U54svG1Ejthx3KWK6hPlNDgfV7a9x/k2IsJnnAYe2
	mFw/0/Ne/G2+wuwke4EYWFdLLMElGmQrocLCGZJrXtJNqu0yrBtV5UOfErK+RLEIJa1HHOm/D5h
	QVML/orJJJPVDEIQQLcX4qrmyXSjL/WE+JIjfUwijbfqdQAI30yUdcmb/KHh+Om7+2NugjnTBnt
	t+kOZn5nLnAGYBmGQ/Ccta1nwjvmhfHWgoTw/gGdPzhFtguJ/79qjLKj5m2t1WbPs7fBbyfjMIc
	SYKKm6AevsyhdEqTnK139alQioWmupnS5So
X-Received: by 2002:a53:bf01:0:b0:669:8f5f:fec7 with SMTP id 956f58d0204a3-6699a8ca5a6mr2644538d50.16.1785934134658;
        Wed, 05 Aug 2026 05:48:54 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-669915f5a6asm2913336d50.12.2026.08.05.05.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:48:53 -0700 (PDT)
Date: Wed, 05 Aug 2026 08:48:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: wei.fang@oss.nxp.com, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 liuhangbin@gmail.com, 
 mst@redhat.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me
Cc: wei.fang@nxp.com, 
 imx@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
Message-ID: <willemdebruijn.kernel.4a69732dc0a4@gmail.com>
In-Reply-To: <20260805105314.3882595-3-wei.fang@oss.nxp.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
 <20260805105314.3882595-3-wei.fang@oss.nxp.com>
Subject: Re: [PATCH net 2/2] net: tap: fix skb->protocol not updated after
 VLAN network header adjustment
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

wei.fang@ wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> In tap_get_user_xdp(), when processing a VLAN-tagged frame,
> skb_set_network_header() is called with the depth returned by
> vlan_get_protocol_and_depth() to advance network_header past the VLAN
> tag to the inner protocol header. However, skb->protocol was not updated
> to reflect the inner EtherType, leaving it pointing to the outer VLAN
> EtherType (e.g. ETH_P_8021Q).
> 
> This mismatch has two consequences. First, skb_probe_transport_header()
> is called after the VLAN adjustment with proto=ETH_P_8021Q but nhoff
> already pointing past the VLAN tag to the inner header. The flow
> dissector interprets the inner header bytes as a VLAN header, fails to
> find a recognizable encapsulated protocol, and returns false.
> Consequently, transport_header is never set and remains at its
> uninitialized sentinel value (~0U), causing any subsequent
> skb_transport_header() or udp_hdr() call to dereference a pointer
> 65535 bytes past skb->head, potentially corrupting arbitrary kernel
> memory. Second, TC egress and eBPF programs that inspect skb->protocol
> directly (e.g. bpf_skb_net_base_len(), bpf_skb_net_grow(),
> __bpf_redirect_neigh()) will see ETH_P_8021Q instead of the inner
> protocol and behave incorrectly.
> 
> Save the return value of vlan_get_protocol_and_depth(), which already
> resolves the inner EtherType, and assign it to skb->protocol after
> skb_set_network_header(). This keeps skb->protocol and network_header
> consistent for all subsequent processing.
> 
> Fixes: 8c76e77f9069 ("tap: call skb_probe_transport_header after setting skb->dev")
> Assisted-by: WChat:claude-opus-4-8
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/tap.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index fae115915c8e..afcc4919bd04 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1081,9 +1081,15 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>  	}
>  
>  	/* Move network header to the right position for VLAN tagged packets */
> -	if (eth_type_vlan(skb->protocol) &&
> -	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
> -		skb_set_network_header(skb, depth);
> +	if (eth_type_vlan(skb->protocol)) {
> +		__be16 proto = vlan_get_protocol_and_depth(skb, skb->protocol,
> +							   &depth);
> +
> +		if (proto != 0) {
> +			skb_set_network_header(skb, depth);
> +			skb->protocol = proto;
> +		}
> +	}

Does the same apply to the same call in tap_get_user?

And in general to other callers of vlan_get_protocol_and_depth,
including through wrapper skb_network_protocol?

>  
>  	rcu_read_lock();
>  	tap = rcu_dereference(q->tap);
> -- 
> 2.34.1
> 


