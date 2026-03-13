Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45920C00C
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360947; cv=none; b=KsvtTFQqGCYv+YhzSB6RPDGLUXKP3wkRzadtUw0hcwN6S7LhG1t9ieUbQMUffwyUP1Y9f4Ae3mSkLJbSQSTvsqdvwYEoJrXAB8TG8ZOkv5atwhm6O9yfmSsXfg7jpWiDJ0DjzJRu8d0C61ReumqHvFgaYp9si9zp5PNRPXYFAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360947; c=relaxed/simple;
	bh=+39be/lM+pCjc6LDbwu3mE50qpIe2hDK+xdcHCZtNcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjewYj2qkAXnZ+sfGE63t1wiCeyPfEu4qBeeZ2QBjNDaFhie7pcdgm2kUSVdeZa6S9Yl4EU2dTFZE2RiapoQLZRJchqn8l72LK7PxCBYayvd3z3foOYX1GORStHbwbwtikFchgv0b6a57TfEuDp51oHeyd3yQ5mfJqmquksAq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BFHCEcsf; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BFHCEcsf"
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-506a747448dso13975511cf.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360944; x=1773965744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wbnk6DhuujZQfq0+crBJouQzTV+20pKhVKIpYP5UqB4=;
        b=Nrdz1UWgvFxTuNx+6EXOJYX043eyc4nB8iY3c91NhjyKzDL0zKuVlFd/qVUMyTxLYX
         EqCQ5hSMsSis3X4fTr2JsQiK5atlhboRNYwjp+h858DvMQXffEV5r55I9na8eug11AVU
         EJz39004myNjZPcH2TYwAoBKZTvDaOrDgxolGWdnpwfG+BPW1XiHvy7ttBA7/lJjyywd
         QTDDfvoASK1/CwVjR2ZctUgY/p/8suVcPT8My2G80wFF46wCu3ci2DVvjuADriI3IOCL
         u+bwvFJdYh2sLZyMuQvW60fyacZsiLANEgkXJK95PVJ5KcMzU3ivQESj6MFhHAhkE4Xu
         gpYg==
X-Forwarded-Encrypted: i=1; AJvYcCUk+FJhYRiAISWh8w8O43zJvYnKtsEOxiR+eE4iP6pK1VeLYyka0gJGJjRbNEBxF/XDmGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLSPw/bGgG93NEHp8+HKKK4nNdKuJkPUkXFCg26C9aoO41ckJ3
	oeiPxfrtriqFvGQMhfb0Kx2LbaJibWKak/Vyx7vJQ5iTqrNnCdjfuEMGzkIIZFBQwszbnrEYCYf
	P1Zu66Grhv44JtQ3QjLEKIx11VwBT4p0rugKY1P9MBHm8HSwFUnRw15dhceS+tVTl6+qxakdVe3
	mB23O+tu8HtOFvJ8Ady96O+rYgv4/Qw74/CC06EQCZxVRM/EcNC6KVrqMTAi4+ATk0gIfsEfym+
	wXmX8Maq4MF8A==
X-Gm-Gg: ATEYQzwnGpPo3JXadFCWdFN/2tWUgJCMVch+sWw93ouZhM9d+nRC53BkYkJ9QpTHGu7
	y4GzBzz4p/yCt5nTkLKSi0J6l3mC6wV230nSLSm1/717avwo0n8EqDq8oU9zdcLhvwx0kYBT4s+
	M/CZywyCaOFOT2YbGr248Vx9O72NHFa/20yS5sHzUq1U+BVtmhT3sjyKaKGUwea7ukSnmAM/4bF
	DP/yVKKU9aQgCLs3ulSjbIMMa/DFOyzkLb4nQm3rdsc9P9xi56+b6dHMVzsOBEB3HxkGlJYCwTs
	shpHAuPl4G7MXwZlj3NtCtI8WRWlQUihahOgKdqLLjScCVESAZlpp9trArdG/QjrHmUiSvRaNM9
	8ml5pxGMJo08EGvtYmvChaixyFf/iMuDUgjPxLCDe4VNCedtcfAAZOxggIuz7T0xqxgmMgGlmkY
	zTbmzEMQRO6EKUCLpSZnTNvcPLtDxsap2jk4A9egrwTFOa40wHY5LOvsb+oe0a22lpKA==
X-Received: by 2002:ac8:7c56:0:b0:509:1be:901e with SMTP id d75a77b69052e-50957df3dc4mr19126591cf.53.1773360944156;
        Thu, 12 Mar 2026 17:15:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89a65d473b8sm6618326d6.28.2026.03.12.17.15.43
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 17:15:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5090cc6a7d2so121716801cf.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773360943; x=1773965743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbnk6DhuujZQfq0+crBJouQzTV+20pKhVKIpYP5UqB4=;
        b=BFHCEcsfqSi5aJVrDGqBDZS0fJOz6c7uIFU+iMGnfKwlp48MkoqtNo0tA2nVxfaTju
         msn9u9Qr+d4wl0UO7ittP90hs5Om+2L0XBapVKjU1YD8pHP4tgi33JOeA/YYeEYP+YUJ
         MxIVVpU3pW92rDxJOoo+/uIp68w29Be2Ohrpw=
X-Forwarded-Encrypted: i=1; AJvYcCW7z1asyDwQJbgo3ofC8L7AH2gvQloDuPOFTwjlXurxisENjqVVLezAsp7n1GuXTgWS4/Q=@vger.kernel.org
X-Received: by 2002:ac8:7f13:0:b0:509:e68:22d5 with SMTP id d75a77b69052e-50957cfece6mr18763191cf.31.1773360943445;
        Thu, 12 Mar 2026 17:15:43 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:509:e68:22d5 with SMTP id d75a77b69052e-50957cfece6mr18762731cf.31.1773360942866;
        Thu, 12 Mar 2026 17:15:42 -0700 (PDT)
Received: from JRM7P7Q02P ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a116d86sm41390251cf.23.2026.03.12.17.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:15:42 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:15:39 -0400
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, joe@dama.to,
	kuba@kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@cloudflare.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] bnxt_en: Implement XDP RSS hash metadata
 extraction for V3_CMP
Message-ID: <abNXK9rAarFyvQc1@JRM7P7Q02P>
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-4-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-4-carges@cloudflare.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, Mar 06, 2026 at 05:00:18PM -0600, Chris J Arges wrote:
> This adds another conditional for if cmp_type is CMP_TYPE_RX_L2_V3_CMP for
> drivers that support this completion format.
> 
> It uses a similar approach as found in other parts of the driver.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 1f920464b426..25ecef1eb96e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -514,6 +514,26 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  		default:
>  			break;
>  		}
> +	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
> +		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
> +		u8 ext_op;
> +
> +		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
> +			hash_type |= XDP_RSS_TYPE_L3_IPV6;
> +		else
> +			hash_type |= XDP_RSS_TYPE_L3_IPV4;
> +
> +		ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
> +		switch (ext_op) {
> +		case EXT_OP_INNER_4:
> +		case EXT_OP_OUTER_4:
> +		case EXT_OP_INNFL_3:
> +		case EXT_OP_OUTFL_3:
> +			hash_type |= XDP_RSS_L4;
> +			break;
> +		default:
> +			break;
> +		}
>  	}
>  
>  	*rss_type = hash_type;
