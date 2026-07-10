Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A91DA23
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642421; cv=none; b=sZjM2YOcpZkhp9LC/DVrakiuHAUhXsRrNQPgn/+IwrC2Ao9CK2hh1SlzcCO0QnFbqqfr/begZluxaKbYXIj7RhbxCOQoiSmXaMiR1YLrnv4LV1WRv4AAcOd0Snd+5nJu+xQ4sXP1G4notaHKTS4gYPPsbJARq2n8/RFsDMHtgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642421; c=relaxed/simple;
	bh=Ugh/OpEP8n4AayGypRHKYHXqEemDcC9LJUjQgnKPGI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUYn5Bg2OS2sT+tvv4Qbh1nvKyQ275YUOICG+JDbJrqQ5Wn7Q6MmWs28ZgTWWv+HdL4zMLVMyVVURJ59i9m7xTx9tT9A/H/USKQtigG0ElXL8S86UMTkjFdA1T3NtqTfdBHMe47zNHfbYRWaM8UJH7T3zaVbY/XCHm0kTMYzZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaRXMUXK; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaRXMUXK"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so121439a12.1
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642419; x=1784247219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wnhaarTkKMQdrEB7M6qZBuO7dhcx30S+q+s0SvQiViM=;
        b=NaRXMUXKMbiLIAQ2ZXaFYbPwk7eIzWJGx5XRn0c7cVIBCB3Oxs4s7pY9ZdTb1nU+No
         NiQVAqer4ujbMgpyf1zcwHzn1UWA9us6L0rSuHpgK3Rp0HXKYM/wm9XSB5sNvsnpSjt1
         OOjHFsamm1ZmKwVghCWGh4GQyjwwh+cKg0LTVbdvfQW0HG8g6BaLSRcsOls01KtGLzml
         c1hncM+EGUi882JbF3MpCtUzv15YHS1xR4j0BjrgfxA8N9v2tgmxWMeE9mz04wUcR/pP
         NthUwsylKovEbq5m5szuCTly5vgNsCU3lR7xiUUQvafVjEFrYXYSIJNrcfAbs7X0n8TJ
         VQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642419; x=1784247219;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnhaarTkKMQdrEB7M6qZBuO7dhcx30S+q+s0SvQiViM=;
        b=iL91d96mFcQjk1i5CluMVsKGzZu8/Pd7b1adzBOOmyrmIUlXAU2LaUz94uIQFYOVsh
         +M2sSxchA+Mo8eLhH3zNz+Labc9vFfqWPwMfH5H5hOtJjx+kdqPR2oISV/7Vmf7OFjIi
         X2iOjvna6tMPSH/yv1SdCwpJeqb9XG4RllKtwAHIlTomwKR6zEMrEwSOU8o5puHSXeF1
         R5n8wyWk2tYTbCj/41LhHPLmtoBk23qiOZo0LUPgNcgEVV7Eu+U+gBeJw0jesWgJJfAC
         GAcfxiytvlcsHLb6i32Y95UfGFaNFBFE7AHTfH+T7oyWfYay2Rh2KCzGLh4w/aKxOhSm
         09jA==
X-Gm-Message-State: AOJu0YxaUQKejcb01vKOz9ovARX1s/DAtG2gennTauxndz4WM7xFxyFE
	XAOWPXB4ACkfugUDPKXmcTtL0a20RXIjOfEEWSXUh0l6FR1VAxYNHAGV
X-Gm-Gg: AfdE7cnBHHJkx5XsZ1chSaHkWThlVUhJuOlHw+bUsGVP9KuSLUpmSmwrNY/9/BIE38D
	bAVaR9KUeuTsdFvFSMzOhgFUiRWsyqp3/tBFlhDeu8tSJ11g5LLZNSPaidbED3rywCd4cv40qBA
	WSj1+orhiPGZoEtbHyUfLaZl4ntgsC3lcLDYj4sSZSJDeifH6xBX+R3CdLVLhW7oDnYj9a1kIfs
	dwG5qanGkfXE9Yf1oZvi5Ps652t60VYndXkUpdHvj7m80TvX5o97tlo34E/2COX/2+K4vP5Qojz
	bGHKxLWTz8f30Sn69FOSqR92kQ8uO48yO7DCKzlyXxqiJ093umRkSqNB4/a4sGbhKXgF8k7nXO4
	LNQWrmLVo5mE9BvtyECHOT30Oti2MCIYG/nT+2+p2nFX23GF/xEatDxJIBGVEuQsI0BQwXWOODR
	Yd6mH5
X-Received: by 2002:a05:6a00:451a:b0:842:6a3b:60d1 with SMTP id d2e1a72fcca58-84842f01e28mr9455961b3a.31.1783642419243;
        Thu, 09 Jul 2026 17:13:39 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8484123ce87sm3534608b3a.58.2026.07.09.17.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:38 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:12:21 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 1/5] bpf: add bpf_icmp_send kfunc
Message-ID: <alA4xtY1HGl4Fygf@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-2-mahe.tardy@gmail.com>

On 07/09, Mahe Tardy wrote:
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
> However, bpf_prog_test_run_skb can create synthetic IPv4/IPv6 skbs
> without an attached route. In that case, icmp_send returns early, and
> the kfunc would otherwise report success despite no ICMP reply being
> sent. This check also reject metadata dsts, which are not valid struct
> rtable instances. While IPv6 would stricly require only rejecting
> metadata dsts, same check is applied for API consistency.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4f5cbcac3e78..e4697036c67b 100644
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
> @@ -12548,6 +12551,83 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
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
> +	if (!skb_valid_dst(skb))
> +		return -ENETUNREACH;

This looks much better, thanks!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
