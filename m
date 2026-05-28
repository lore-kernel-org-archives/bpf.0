Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9E369D44
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780008890; cv=none; b=GdsYTwSkdXGDaHOQjhM1z1q4Acl/7ymWDGyvL68DpOtAq02hyjCXTjUx9mcgvtYuIVBT0BtNmgd1BKyKARDokoj7/5++stfjNCjz2t6FYbSAiXcE8Jf6LdlymXKNDFWfztJWOVcAp9LicLP4KVawVg6pfxEP2/VdCzLrgkqbH60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780008890; c=relaxed/simple;
	bh=CkIgU+9p9BfiCkr8KKIac0MYY7FTP/DUbBoGj0dhHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy1QH0+d8MmiCEIAfhuVmcpFUy+RwGPaImuY/3E7LCvDn0qlvM9oYgqW/XaHm8sVDQLc2xjJkf7/+ZjoqpByKdG90y/Ssv+ASEYGdOVIA+T37vexstf+yPCMy1fQbdw5lwUFEA/6QX7Lv5YJZLsV4u/bwkxF46eiXIj5usrSnfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=T07ZFvxo; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="T07ZFvxo"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304da3b4508so104588eec.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1780008889; x=1780613689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eVZ4DejMwq9y5/TGGt0Qr2Xm4AzQr3mA1ghIFaC058=;
        b=T07ZFvxoSRswgnTAKD7m62ZuUCYnDuQvlJx0JfoN+Y9nMCscibM4usYiq8YgqJYne0
         JbM1DJrmdRzBle7DVEQnwcIdi4alvQyXftpuHvkPumMO4kNkNpjgDACMwe0elhxgWABp
         jGndyO6MMXvrk0UoPxefZEEg2NRHiKwWZVGKZgNQmMeEZ5GZhFMBYg4EMGHkGEWqBm5R
         1TC4SRmAFjEMH0yLP0COWZWg1mN33XKrEtp/EvjfH61Pb39ZOinL+BqrLrH0VDVyQP5d
         nF0OlzgFvawV3JHzqm2LgSp3Ei4wkEf0WBVQo9UFblsX0ki6bKY4Jt73X5lYGbfWNRSJ
         47hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780008889; x=1780613689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eVZ4DejMwq9y5/TGGt0Qr2Xm4AzQr3mA1ghIFaC058=;
        b=gjBqZBBW/aXSw3J8ks0Pd7dk3qP/quIEp2EIZE4EZzgcDDhH3q7KHRpwToRs7uDl+Q
         tGXNksENJx2ZLpkCDukDtBzhfX2cX/+8bP4KdzJ9lPIA8ta/4O2OADis3o6v4cUApT1L
         Jk4UGGIGqe/0osgGDkt8cqC7dwY2Dmn86sJfYYzrexFnnz5sML6Dol1f8j/HBBSlsh9w
         eRFDq/Q/XKgTKbKO152ikI4+gizobDdJHPxkDWLbKnToimR+AwE7mXfrPzRa+nIV4629
         UbdH6Tae5IvoafWBvB1QiMxNCeT4tQaVmjheRla1jpZnQqoJGbwgaI+bGzld79nHz/p7
         2KUA==
X-Gm-Message-State: AOJu0YxMZAQn8KROqGqGURv7Ti8W8QE4GMsLC575Q51nsKBx7JYpPeS7
	OQUqh818Xs/QuhJSvX8Jmdaf8cbjtmEphwSFSYEXpObSWzzDYuTezcSy0RMIvqUR/u0=
X-Gm-Gg: Acq92OHF7E+Xim7ZoXAyh1MqcKyAu+H+0tzAlLgZn0OWJujpuYNKBojRCZZI8WeTqY0
	p35YKr4yfiXdtIGre7qL/9ZqU9bUZdguV82nBUqu3ane/CSjzFiYSatyOJDobQBOsFBVc0xLV5D
	CdES5RYU9Hw2kxjPA3ciUir6x3ZvcE7DLadpZu7azLXOhAUOe6G9BLhpqW+dr1AJzdddRezOgGn
	IURbnLZw5oYUecLw6cLtZHWFv7MQ8xZwFf6792VtMrQ3jGJMbdh2Yayh4HyWrJtTesbKIZsqgjp
	moOfXfHI9vs7eOtkWdTHQ62fNxruIq6CoWqaJkgk2WhJxlYhv43L2KNGcfMnp2aEgnGzXB/uOUY
	St6BLnSjC/Q/w2LMvT8YbuJrQqYi9QkXqtTSgGCR8vnP5Nap6DNh5SoEuJp85yBK/XYx/LnD8bw
	/6Yn5vpjxnCaG147bQwCC34xTvMpzbXVvQwro=
X-Received: by 2002:a05:7301:4186:b0:2ea:5057:a320 with SMTP id 5a478bee46e88-304eb0f1c17mr99701eec.2.1780008888653;
        Thu, 28 May 2026 15:54:48 -0700 (PDT)
Received: from m2 ([83.171.251.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304eb9975b7sm181947eec.6.2026.05.28.15.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:54:48 -0700 (PDT)
Date: Thu, 28 May 2026 15:54:46 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v7 1/7] net: move netfilter
 nf_reject_fill_skb_dst to core ipv4
Message-ID: <46rav7qeseaysu5tlzvkst2ukbqgzj5nyk5joar4pnlokj5e6o@4fh4loahchyi>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
 <20260526153708.279717-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153708.279717-2-mahe.tardy@gmail.com>

On Tue, May 26, 2026 at 03:37:02PM +0000, Mahe Tardy wrote:
> Move and rename nf_reject_fill_skb_dst from
> ipv4/netfilter/nf_reject_ipv4 to ip_route_reply_fill_dst in ipv4/route.c
> so that it can be reused in the following patches by BPF kfuncs.
> 
> Netfilter uses nf_ip_route that is almost a transparent wrapper around
> ip_route_output_key so this patch inlines it.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  include/net/route.h                 |  1 +
>  net/ipv4/netfilter/nf_reject_ipv4.c | 19 ++-----------------
>  net/ipv4/route.c                    | 15 +++++++++++++++
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/include/net/route.h b/include/net/route.h
> index f90106f383c5..300d292cd9a1 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -173,6 +173,7 @@ struct rtable *ip_route_output_flow(struct net *, struct flowi4 *flp,
>  				    const struct sock *sk);
>  struct dst_entry *ipv4_blackhole_route(struct net *net,
>  				       struct dst_entry *dst_orig);
> +int ip_route_reply_fill_dst(struct sk_buff *skb);
> 
>  static inline struct rtable *ip_route_output_key(struct net *net, struct flowi4 *flp)
>  {
> diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
> index fecf6621f679..c1c0724e4d4d 100644
> --- a/net/ipv4/netfilter/nf_reject_ipv4.c
> +++ b/net/ipv4/netfilter/nf_reject_ipv4.c
> @@ -252,21 +252,6 @@ static void nf_reject_ip_tcphdr_put(struct sk_buff *nskb, const struct sk_buff *
>  	nskb->csum_offset = offsetof(struct tcphdr, check);
>  }
> 
> -static int nf_reject_fill_skb_dst(struct sk_buff *skb_in)
> -{
> -	struct dst_entry *dst = NULL;
> -	struct flowi fl;
> -
> -	memset(&fl, 0, sizeof(struct flowi));
> -	fl.u.ip4.daddr = ip_hdr(skb_in)->saddr;
> -	nf_ip_route(dev_net(skb_in->dev), &dst, &fl, false);
> -	if (!dst)
> -		return -1;
> -
> -	skb_dst_set(skb_in, dst);
> -	return 0;
> -}
> -
>  /* Send RST reply */
>  void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
>  		   int hook)
> @@ -279,7 +264,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
>  	if (!oth)
>  		return;
> 
> -	if (!skb_dst(oldskb) && nf_reject_fill_skb_dst(oldskb) < 0)
> +	if (!skb_dst(oldskb) && ip_route_reply_fill_dst(oldskb) < 0)
>  		return;
> 
>  	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
> @@ -352,7 +337,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
>  	if (iph->frag_off & htons(IP_OFFSET))
>  		return;
> 
> -	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
> +	if (!skb_dst(skb_in) && ip_route_reply_fill_dst(skb_in) < 0)
>  		return;
> 
>  	if (skb_csum_unnecessary(skb_in) ||
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index bc1296f0ea69..1f031c5ef554 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
>  }
>  EXPORT_SYMBOL_GPL(ip_route_output_flow);
> 
> +int ip_route_reply_fill_dst(struct sk_buff *skb)
> +{
> +	struct rtable *rt;
> +	struct flowi4 fl4 = {
> +		.daddr = ip_hdr(skb)->saddr
> +	};
> +
> +	rt = ip_route_output_key(dev_net(skb->dev), &fl4);
> +	if (IS_ERR(rt))
> +		return PTR_ERR(rt);
> +	skb_dst_set(skb, &rt->dst);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ip_route_reply_fill_dst);
> +
>  /* called with rcu_read_lock held */
>  static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
>  			struct rtable *rt, u32 table_id, dscp_t dscp,
> --
> 2.34.1
> 

Reviewed-by: Jordan Rife <jordan@jrife.io>
