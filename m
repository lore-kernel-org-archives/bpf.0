Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30D4C43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5302175B
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 22:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqGJ0Rbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCSWRl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:17:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40088 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSWRl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 18:17:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so363435pfc.7;
        Tue, 19 Mar 2019 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hM/0Ndv2d6yhCkMSgPd9gvpXlkA7F0d+OwTIN3prQbc=;
        b=BqGJ0RbfOF0FM1ozu12zwWRv7s2xaB0ZB7LIpeBEaumaMf2LRo/NAe2ir+6N1F7xal
         xOt2Rqe7h5H5q+jQlJECFJUoU05nyVq09UdC+w/JzYd8p8qoi/5ZvtIEYerUNAxGnxFh
         4+FGb2NSxGfANvXs2US1OGdISIF9MCwaBVcrZ09M10raqYXK6IXq8L6EwSNNG9gl9IU5
         Is9ZsWnHiD+ZygcLL/iKSTx23K8jGWtv/I44EtKDlhBBtS/HDbBOrt1TBCubE+dr24Nc
         fFAw+o5OVDssMlIaQmHE8qiICShWgOLo/I5z8gpcqZi5VISnAWcTqDNbQeEe6s14t3+E
         l73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hM/0Ndv2d6yhCkMSgPd9gvpXlkA7F0d+OwTIN3prQbc=;
        b=Lk4XAG7tRvfHmKcISV5QToCE2apnQgqhZtYnYTZZh2uslR3pxby/68oFnZUrX6FJ1P
         +Se/zBzg9vQ5LqC/Dy6BfOVX6WN9jBLxX5Hqmlrn2UyzXvIrY11wJKheOH2hNPEGYgdN
         30U53gEv/4//F2d81vXOlkrOvhzMIod7soQRNEL7jy/9WtpTiNGaK0z7jyBkzzzpzY4h
         hrST5ggwfMAUjA5q40nV62sJi53rrQpMgjYFfoPvc4XR5OwYLgEWO6k0gi9ITAAlqdjV
         BrlqdhHcBkHpANjv+L6mZf32ICcwP9/jv/6YuWrsUVWq/6KVq5Rx2XMkIRzIqkC0iwet
         gM4g==
X-Gm-Message-State: APjAAAXXm5XjRi3aWbnojsTvVxpeAX2BiM57iT2TdhHfA6dpiSo9m3mb
        TS8YfxTLF1oZZ3i9T9xlqTw=
X-Google-Smtp-Source: APXvYqznVGa+pANlneRF34mS2Ka0N/GO9gtIl5x1OZzduniCmCu1FXnxP91U2y+u/N99FJux8kGepg==
X-Received: by 2002:a63:3f8b:: with SMTP id m133mr3924018pga.91.1553033859976;
        Tue, 19 Mar 2019 15:17:39 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7aa3])
        by smtp.gmail.com with ESMTPSA id l19sm57038pff.185.2019.03.19.15.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 15:17:39 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:17:37 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kafai@fb.com
Subject: Re: [PATCH v2 4/8] bpf: add helper to check for a valid SYN cookie
Message-ID: <20190319221735.ycueci4ec4rvbkxf@ast-mbp.dhcp.thefacebook.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190319102103.7380-1-lmb@cloudflare.com>
 <20190319102103.7380-5-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319102103.7380-5-lmb@cloudflare.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 19, 2019 at 10:20:59AM +0000, Lorenz Bauer wrote:
> Using bpf_skc_lookup_tcp it's possible to ascertain whether a packet
> belongs to a known connection. However, there is one corner case: no
> sockets are created if SYN cookies are active. This means that the final
> ACK in the 3WHS is misclassified.
> 
> Using the helper, we can look up the listening socket via
> bpf_skc_lookup_tcp and then check whether a packet is a valid SYN
> cookie ACK.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  include/uapi/linux/bpf.h | 18 +++++++++-
>  net/core/filter.c        | 72 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 8e4f8276942a..587d7a3295bf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2391,6 +2391,21 @@ union bpf_attr {
>   *		Pointer to **struct bpf_sock**, or **NULL** in case of failure.
>   *		For sockets with reuseport option, the **struct bpf_sock**
>   *		result is from **reuse->socks**\ [] using the hash of the tuple.
> + *
> + * int bpf_tcp_check_syncookie(struct bpf_sock *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
> + * 	Description
> + * 		Check whether iph and th contain a valid SYN cookie ACK for
> + * 		the listening socket in sk.
> + *
> + * 		iph points to the start of the IPv4 or IPv6 header, while
> + * 		iph_len contains sizeof(struct iphdr) or sizeof(struct ip6hdr).
> + *
> + * 		th points to the start of the TCP header, while th_len contains
> + * 		sizeof(struct tcphdr).
> + *
> + * 	Return
> + * 		0 if iph and th are a valid SYN cookie ACK, or a negative error
> + * 		otherwise.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -2492,7 +2507,8 @@ union bpf_attr {
>  	FN(tcp_sock),			\
>  	FN(skb_ecn_set_ce),		\
>  	FN(get_listener_sock),		\
> -	FN(skc_lookup_tcp),
> +	FN(skc_lookup_tcp),		\
> +	FN(tcp_check_syncookie),
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>   * function eBPF program intends to call
> diff --git a/net/core/filter.c b/net/core/filter.c
> index f5210773cfd8..45a46fbe4ee0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5546,6 +5546,74 @@ static const struct bpf_func_proto bpf_skb_ecn_set_ce_proto = {
>  	.ret_type       = RET_INTEGER,
>  	.arg1_type      = ARG_PTR_TO_CTX,
>  };
> +
> +BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
> +	   struct tcphdr *, th, u32, th_len)

what was the reason to pass ip and tcp header pointers separately?
Why not to pass 'void* iph' with len long enough to cover both?
the helper can compute tcp header and can take into account variable length ipv4 hdr
while checking that resulting ptr is within 'iph + len' validated by the verifier.
Last patch example is buggy in that sense, since it's doing:
tcph = data + sizeof(struct ethhdr) + sizeof(struct iphdr);

If we drop two args then there will be room for 'flags'.
It can be used for example to indicate whether LINUX_MIB_SYNCOOKIESFAILED
should be incremented or not.
May be it shold be unconditionally?

> +{
> +#ifdef CONFIG_SYN_COOKIES
> +	u32 cookie;
> +	int ret;
> +
> +	if (unlikely(th_len < sizeof(*th)))
> +		return -EINVAL;
> +
> +	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
> +	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
> +		return -EINVAL;
> +
> +	if (!sock_net(sk)->ipv4.sysctl_tcp_syncookies)
> +		return -EINVAL;
> +
> +	if (!th->ack || th->rst || th->syn)
> +		return -ENOENT;
> +
> +	if (tcp_synq_no_recent_overflow(sk))
> +		return -ENOENT;
> +
> +	cookie = ntohl(th->ack_seq) - 1;
> +
> +	switch (sk->sk_family) {
> +	case AF_INET:
> +		if (unlikely(iph_len < sizeof(struct iphdr)))
> +			return -EINVAL;
> +
> +		ret = __cookie_v4_check((struct iphdr *)iph, th, cookie);
> +		break;
> +
> +#if IS_BUILTIN(CONFIG_IPV6)
> +	case AF_INET6:
> +		if (unlikely(iph_len < sizeof(struct ipv6hdr)))
> +			return -EINVAL;
> +
> +		ret = __cookie_v6_check((struct ipv6hdr *)iph, th, cookie);

I guess this is fast path and you don't want indirect call via ipv6_bpf_stub ?

