Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4BE371D0E
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336266; cv=none; b=qTuUKqUqVvnEnmVaQ2Y7Xum0ynYglgpwpC4fSTjcMa0E3+kKXvUQ0Yi+wn4C+vbfFZPlXJhPzpfi9zHpt8f4GGQH3JoaqEVTNky0pDn65WoS/EoCxncnjiHIqFbnI+QxICnJWPthRXOyuJopoZVUR9zmmVKVCNvRbRBHk5Fz0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336266; c=relaxed/simple;
	bh=jICuYWEX4g2YmogVkx4/q8J5fODU25Klz29NtDXmydw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcLhkNXq7G3JV80js8kurqyyzU74QJso58hhU/jzcpV2ztwSt12d5iOEgG3AHHX3w7NhjKppwJLH9+mr7LCkEolfo0xSNZ69HQSHwYWbwBT6X8U/p1thNDzLWSOi0VD8OHooMRmfU/MzU8Tz6svClEtHNss9A1aZiVyzAgOHhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=jcvp0rgW; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="jcvp0rgW"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c5912314fso198226eec.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1782336264; x=1782941064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l020PWe23ASno0QYX4vMPVYhg0UD9F7hgSKmKrhgjQ8=;
        b=jcvp0rgW/8SrerFbTHwZZedM8XyoEqnYirG+dgx9k0cB3z4L44aw+hA7QyG7VuUXob
         0g877AaEvAYG/v3h25LIm7iIJlMzTBXWKOjg4pwUrUGzSNBLr867+daLd1s/1sCpkXhv
         TcE9CJuw6HGBI8pZV6kjihYHhDb0H5kyLsgDklC/KTmvEvLIu0TVHuSTLTPej+AOiS7v
         +LapisxTYEwbWfnH2c7NXAHZCW6C01a4OQI2Y9xX+go3JaMJgvzzHQ+kTllaVFUPICQ+
         Fqvqr2SaM0ud21bHqcSBnbt7u8A1EruzzKgWFgqZdaHbL2Xz4MZpxu3QGZLpaoOqCHX5
         devg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782336264; x=1782941064;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l020PWe23ASno0QYX4vMPVYhg0UD9F7hgSKmKrhgjQ8=;
        b=EhwVJ466eGMeP8Tyw9t5zB3C1GDuaKIqSqtOQlGiDQ/pRATznGikVEep+NgEf3VNsH
         h3K7l9x2IZgoE3WH+t0cvpinKb72qbQxBqivAleBDNQ5DlkYM0rTUAbq5Na+SofDSnwv
         LQjuBXsvunvtez0ZkhtiD29SleqB0Cy6CGMBYi7QoIJQDEZ3kFgq/Vs04vcA9YeEb0Hz
         SxyRqwOOyqROkQh8BeSZHgB//9hhtr+s/dYmoyPRZ5ehI+79rejRY8MHAhvdTOUk7fPm
         txu6gNYOkwcbqGj9CYXp61aQIrDSbyZJQZmFZ0sTWXQRLgQjk6c9Ps3BpQ2BoqPheIZT
         hiew==
X-Gm-Message-State: AOJu0YzRjM0dPnq3b7j+cW551vpuAZV9FO2AlqvH/PNm0BgXJasIDx5v
	PEaap2WSsP4bMyqpp/XXPd45JcQnPq7oFtkpi4S5XaI2/Blq8RTaaVzCYD22Y/GWtq0=
X-Gm-Gg: AfdE7cmNpuJrkM9O52LnKk1dabUMDpwl6fhwnfbvB//ZaqxhSsnkV6T5pbRmlh4KF02
	aTu1WmcjgBvLMGEmO9gjHZU8LB0zW38L2CzczmALTEm1C6fAxXUh9he/Ve6UOOqfjl9HTxv/PkG
	7aeF2IP1cE3CTStTY/9Fw2kiav5FW44ntQQI3zc/nDtKi0+TqjukulDR8edely41ztLd+cNyVuL
	ubaRnr1tOHFffl9LVprt4hTL/GIOsIbIzm2LA9lrfg27PshkfHT4+8Cf/ACGa1IZ5bZaOE+A/8K
	L4iAA8gSmXapIR1crCUfMfAeH9FIXMNSwzEuoHlV2B3vQJZvYKAJ+bSvMYsvRDfszyDEIbFWOA4
	izJblO+Ry7ebJwYXYH9wFNRvl8r9SLHawSVrbDtFgGDu2sP8G9Ggcj79ob45m6uvFz1OqKZEnZh
	WDLtk=
X-Received: by 2002:a05:7300:7fa5:b0:30b:6192:5b9 with SMTP id 5a478bee46e88-30c523b78dbmr4205355eec.8.1782336264052;
        Wed, 24 Jun 2026 14:24:24 -0700 (PDT)
Received: from m2 ([83.171.251.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52eed6sm1579273eec.9.2026.06.24.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:24:23 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:24:21 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com
Subject: Re: [PATCH bpf-next v9 1/5] bpf: add bpf_icmp_send kfunc
Message-ID: <q2volbjfd45cxfmkfu2w47rxdprmzdy3bhwsirytdb3u4hgj2m@biu6gdsl7tnb>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
 <20260624185554.362555-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624185554.362555-2-mahe.tardy@gmail.com>

On Wed, Jun 24, 2026 at 06:55:50PM +0000, Mahe Tardy wrote:
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
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce..f3aa494ed105 100644
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
> @@ -12546,6 +12549,84 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
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
> + *         -ENETUNREACH: Unusable IPv4 route/dst attached to the skb
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
> +		/* icmp_send requires a rtable; test-run synthetic skbs lack one. */
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
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		memset(IP6CB(nskb), 0, sizeof(*IP6CB(nskb)));
> +		icmpv6_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +#endif
> +	default:
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
> 
>  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> @@ -12588,6 +12669,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
>  BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
> 
> +BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
> +BTF_ID_FLAGS(func, bpf_icmp_send)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
>  	.owner = THIS_MODULE,
>  	.set = &bpf_kfunc_check_set_skb,
> @@ -12618,6 +12703,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
>  	.set = &bpf_kfunc_check_set_sock_ops,
>  };
> 
> +static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_kfunc_check_set_icmp_send,
> +};
> +
>  static int __init bpf_kfunc_init(void)
>  {
>  	int ret;
> @@ -12639,6 +12729,7 @@ static int __init bpf_kfunc_init(void)
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
>  					       &bpf_kfunc_set_sock_addr);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
>  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
>  }
>  late_initcall(bpf_kfunc_init);
> --
> 2.34.1
> 

Reviewed-by: Jordan Rife <jordan@jrife.io>
