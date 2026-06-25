Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344E3E8684
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404706; cv=none; b=m/Ber9KMDVKCB+u/gsoVX698JF7UxTbTrL4odCdafL/kxstkUPeTQ2F558MWhuNfgT1TgH1cmKJDnkeZpc59wLErQn7ySOnedRsrjZfQ0zWQvYlnSZSyVeaI+CFCFLgHo5xuP6iqGs50b+2G+fKfC53954ct11svFdDAdJIesZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404706; c=relaxed/simple;
	bh=30HqNndan/Z6kMjzyIR6FKO5AjUePnfZas+E41oEMCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5MZuLKuV6+g2K/E5EgK29TjHRkoR//20uFEpUotV0pATFa/c861RBypAbNWHqKHadFQ3jQezzU0MChhIcO5TQG9qNiPpT5M6xT/oo4mGRydXhdpUxvkXo8pzo7XdyOBS5w3LvozYeyvlz3xnkViVh9L8ugON38dM27v9urzonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjxT0pkz; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjxT0pkz"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c88e3e82d81so30664a12.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782404704; x=1783009504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fQOLivGFsefV0WUnhB5GWS7A9M0rAkZDGfbL+NmjNg=;
        b=TjxT0pkzHSi95bUpoa86/jeN5dOnD2wFU4fZ7mh9jz/LLmxc6fsGSbeQIhIN0HNHqs
         QcDlZgTaTpRtyE93/EogpwwqiVe6fzW2KsbKTWYpviKvyP4WebxkyMoNFLxqb9Hqja+Z
         i1yFt9iWvODtCNTHtdZFxP3wEaqikMH7h3FwwKaFC9QMJl0PGVVkrbj0+KX9zzTLmuXu
         rtDG1tNn7Q7WiXpe/wcfCAHV3Eiswix2EvaSdrts94G6IU451oDLDwOTWyGS6pj51xPc
         PjZ+QKg+gJvSfu/H27mM8ggW7LvXfkODiaFkNJ/tUlS0XhuDT7/EOwr1acUiYY0uKTU5
         WfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782404705; x=1783009505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fQOLivGFsefV0WUnhB5GWS7A9M0rAkZDGfbL+NmjNg=;
        b=sb6XBlev2xvJAgaQr0TuB+fI28VOaHCxU+TETesul5B40+yPjyI3TO5cuFv98IdUBr
         FatX196s33VuwghMbojB7+T5mOvymjyONzi01pDROIiZWkGEz8SOI/dpCp7QX172/M+M
         OiZ9sFPG+KUrRvoNtgc6MQ7whyW9hRBFpOfzvBVvCjYLKJ5AnGvO5xf2FgL80m+Bpb7m
         iwoC5ElsrUrJppu55+/wBXTF4cZ7KKOO8PncyyA5SQuGIpuK4dtPgB7fZTQU11yLxNy+
         ptSTiXIPRGuupL5cBqhTnCcy/N45yPU4CyulY6CEy2ykjt3gAQBiy0cNo2lou87gtEKp
         GIaw==
X-Gm-Message-State: AOJu0YyryUqCDV8r5AvYIk1xW6RJ0bMGuUsQtDnk1PvzNI01dG2xf7oF
	HoRO3iEyoS4xXv0+sS29isiqQhMQrx5e1ycQDib6+07sNxkjlRXfULkA
X-Gm-Gg: AfdE7clFcul65TbSovuOAESkygTpdFpOUEb+F7ApoFnwRPygfo38IoVSYJRqv61V7d/
	SeIB52rOE8U+mZG8CkS3k+S3QHlIkvQ3SDl3Y3D7sTJR23cJlgWcIZKr+WC8zNoq8A6v769x72M
	gSqsePrPFQT2sSFMj1m2o5wZnKKfRVyg90in2MKrbGHS2aAAA2GK+xNWM+12p6l/AsjdT7/obDw
	iKLQCzbD4ovfwGklHK9/dt03UD6EKPhGJO8MzTmJHVV3JXF4YlFycrwqCCKOzD+cmL54SO631ec
	LEU6YBvgyrxs69CHL5lzNQO1yIAD2o4zL4IjvKXx7GGvQwkSxBJHy/Xkal1SwqLU+6ZE+WCIoyC
	4lVWjbbZSu8tDGByIXE2xBfCLe6PosinfiNpm6WDH9kqFAu+jPLGGO6NSnZXb9yPOnnHRsRTvJu
	J2Q7CvQQ==
X-Received: by 2002:a17:902:d484:b0:2be:3850:297e with SMTP id d9443c01a7336-2c7fc792f8emr31282125ad.31.1782404704363;
        Thu, 25 Jun 2026 09:25:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ac8ac4sm24159485ad.14.2026.06.25.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:25:03 -0700 (PDT)
Date: Thu, 25 Jun 2026 09:24:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v10 1/5] bpf: add bpf_icmp_send kfunc
Message-ID: <aj1V2ZdzY1EGtsma@devvm7509.cco0.facebook.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
 <20260625110321.28236-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625110321.28236-2-mahe.tardy@gmail.com>

On 06/25, Mahe Tardy wrote:
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs.
> 
> This reuses concepts from netfilter reject target codepath with the
> differences that:
> * Packets are cloned since the BPF user can still let the packet pass
>   (SK_PASS from the cgroup_skb progs for example) and the current skb
>   need to stay untouched (cgroup_skb hooks only allow read-only skb
>   payload).
> * We protect against recursion since the kfunc, by generating an ICMP
>   error message, could retrigger the BPF prog that invoked it.
> 
> Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> The interface accepts a type parameter to facilitate future extension to
> other ICMP control message types.
> 
> For normal cgroup_skb paths, the skb dst route should already be set.
> However, bpf_prog_test_run_skb can create synthetic IPv4 skbs without an
> attached route. In that case, icmp_send returns early, and the kfunc
> would otherwise report success despite no ICMP reply being sent. The
> check also rejects metadata dsts, which are not valid struct rtable
> instances. For IPv6, reject metadata dsts only: icmpv6_send can reach
> icmp6_dev, where skb_rt6_info treats any non-NULL skb dst as a struct
> rt6_info, which is not valid for metadata_dst.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce..0a0191586b44 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -84,6 +84,9 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <linux/icmpv6.h>
> +#include <net/icmp.h>
> +#include <net/ip6_route.h>
> 
>  #include "dev.h"
> 
> @@ -12546,6 +12549,88 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
>  	return 0;
>  }
> 
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> + * @code: ICMP code (0-15 except ICMP_FRAG_NEEDED for IPv4, 0-6 for IPv6)
> + *
> + * Sends an ICMP control message in response to the packet. The original packet
> + * is cloned before sending the ICMP message, so the BPF program can still let
> + * the packet pass if desired.
> + *
> + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> + * supported.
> + *
> + * Return: 0 on success (send attempt), negative error code on failure:
> + *         -EBUSY: Recursion detected
> + *         -EPROTONOSUPPORT: Non-IP protocol
> + *         -EOPNOTSUPP: Unsupported ICMP type
> + *         -EINVAL: Invalid code parameter
> + *         -ENETUNREACH: No usable route/dst for the ICMP reply
> + *         -ENOMEM: Memory allocation failed
> + */
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	struct sock *sk;
> +
> +	sk = skb_to_full_sk(skb);
> +	if (sk && sk->sk_kern_sock &&
> +	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
> +		return -EBUSY;
> +
> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP): {
> +		if (type != ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH ||
> +		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
> +			return -EINVAL;
> +
> +		/* icmp_send expects skb_dst to be a real rtable. */
> +		if (!skb_valid_dst(skb))
> +			return -ENETUNREACH;
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
> +		icmp_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +	}
> +#endif
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (type != ICMPV6_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;

[..]

> +		/* icmpv6_send may treat skb_dst as rt6_info. */
> +		if (skb_metadata_dst(skb))
> +			return -ENETUNREACH;

A bit confused about this. Which part of icmpv6_send treats skb_dst as rt6_info?
(I see the original sashiko report about dst, but icmp6 seems to be not
requiring it)
