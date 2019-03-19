Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AFEC43381
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 21:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B442D2146E
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 21:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI6XRvAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCSVa7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:30:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45731 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCSVa7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 17:30:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so81602pgk.12;
        Tue, 19 Mar 2019 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VQ6PGh8xeRmkVVwa3Eb0QOImVsQ8XegQmgAJw+z/HOE=;
        b=cI6XRvAwjDbg3bU9m4TMOuk0chZunMzW7FLxgvhEthiV6wcTv0YbKdReglkImFiECf
         p5tm85H+D9f4NAF+r/ByqC6WY7Nnyu8ds4QdZSxDUL8skiVBlQpTLADa9JYGeUx8XOJI
         HI3qrhVxIBsIlgJLhzmZP3S2XqSPjIluqZ2vjA+15l8K7LN9Zuqm/g72ZXKATBoJzZH6
         cGzWCkEkQ4ozrn7SJ7Hgw0XHqcKb88i6ksvB8Dxse2lXbCC932pNpERjdP9T2Gaodttz
         F4LDYPtR2y53cg6iwVzWWqnsZvijEF7uf2l1y82rop+9b138DgjWMWPMEbixl40KNWc2
         wByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VQ6PGh8xeRmkVVwa3Eb0QOImVsQ8XegQmgAJw+z/HOE=;
        b=I0kaRAEm6Kr05bMoJum2Pv9RiXIspYyHhD/OZjkMVCuzqYuL9csVGnLk5HHJmAFGRO
         3XixOcPkFMraJaHCO0hZ90juFnHuohhsfNS2lT+qXULzfcAj/jhi6+ivr7zgFIc/Mppz
         SWQzhE0mIxSyU+xXNJaHkl647ecXol1d/s1VnU5q3+7s2e4yjluhCz1FnzF+KVVNXkKs
         sIGDMOFaMbw9wf8BXobQPCU72fANMoQOY7LjJhKI5Vn9kxAd8CpqUX0Q1b6G7+Ur7zLS
         RsnIdBkNy4Sh18XDdOdq45CMobq05/4PLNvmZW0C1bShky51lgqceAAivLt1tpXyi0jr
         X0uA==
X-Gm-Message-State: APjAAAW01bx4m72I/1WK4z9ohPKLxpY2LC8kA8h1mSSyQbTelmYeEye5
        4dT3fbZyf9V1FYhRvJ5HEM8=
X-Google-Smtp-Source: APXvYqyCU1AVxK6ybV4rTUHN8cy7hO/pJ8rLLfPhqKUjW6Lt4s7b4EwDhsr9ZiFz0giatfw+Q2JV6g==
X-Received: by 2002:a17:902:234b:: with SMTP id n11mr4232687plg.89.1553031057938;
        Tue, 19 Mar 2019 14:30:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::7aa3])
        by smtp.gmail.com with ESMTPSA id j20sm16093pff.22.2019.03.19.14.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:30:57 -0700 (PDT)
Date:   Tue, 19 Mar 2019 14:30:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kafai@fb.com
Subject: Re: [PATCH v2 3/8] bpf: add skc_lookup_tcp helper
Message-ID: <20190319213054.gg3t4phnszzgvmpu@ast-mbp.dhcp.thefacebook.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190319102103.7380-1-lmb@cloudflare.com>
 <20190319102103.7380-4-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319102103.7380-4-lmb@cloudflare.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 19, 2019 at 10:20:58AM +0000, Lorenz Bauer wrote:
> Allow looking up a sock_common. This gives eBPF programs
> access to timewait and request sockets.
> 
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  include/uapi/linux/bpf.h |  20 ++++++-
>  kernel/bpf/verifier.c    |   3 +-
>  net/core/filter.c        | 113 +++++++++++++++++++++++++++++++++++----
>  3 files changed, 124 insertions(+), 12 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 983b25cb608d..8e4f8276942a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2374,6 +2374,23 @@ union bpf_attr {
>   *	Return
>   *		A **struct bpf_sock** pointer on success, or NULL in
>   *		case of failure.
> + *
> + * struct bpf_sock *bpf_skc_lookup_tcp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
> + *	Description
> + *		Look for TCP socket matching *tuple*, optionally in a child
> + *		network namespace *netns*. The return value must be checked,
> + *		and if non-**NULL**, released via **bpf_sk_release**\ ().
> + *
> + *		This function is identical to bpf_sk_lookup_tcp, except that it
> + *		also returns timewait or request sockets. Use bpf_sk_fullsock
> + *		or bpf_tcp_socket to access the full structure.
> + *
> + *		This helper is available only if the kernel was compiled with
> + *		**CONFIG_NET** configuration option.
> + *	Return
> + *		Pointer to **struct bpf_sock**, or **NULL** in case of failure.
> + *		For sockets with reuseport option, the **struct bpf_sock**
> + *		result is from **reuse->socks**\ [] using the hash of the tuple.
>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -2474,7 +2491,8 @@ union bpf_attr {
>  	FN(sk_fullsock),		\
>  	FN(tcp_sock),			\
>  	FN(skb_ecn_set_ce),		\
> -	FN(get_listener_sock),
> +	FN(get_listener_sock),		\
> +	FN(skc_lookup_tcp),
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>   * function eBPF program intends to call
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f60d9df4e00a..94420942af32 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -369,7 +369,8 @@ static bool is_release_function(enum bpf_func_id func_id)
>  static bool is_acquire_function(enum bpf_func_id func_id)
>  {
>  	return func_id == BPF_FUNC_sk_lookup_tcp ||
> -		func_id == BPF_FUNC_sk_lookup_udp;
> +		func_id == BPF_FUNC_sk_lookup_udp ||
> +		func_id == BPF_FUNC_skc_lookup_tcp;
>  }
>  
>  static bool is_ptr_cast_function(enum bpf_func_id func_id)
> diff --git a/net/core/filter.c b/net/core/filter.c
> index f879791ea53f..f5210773cfd8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5156,15 +5156,15 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
>  	return sk;
>  }
>  
> -/* bpf_sk_lookup performs the core lookup for different types of sockets,
> +/* bpf_skc_lookup performs the core lookup for different types of sockets,
>   * taking a reference on the socket if it doesn't have the flag SOCK_RCU_FREE.
>   * Returns the socket as an 'unsigned long' to simplify the casting in the
>   * callers to satisfy BPF_CALL declarations.
>   */
>  static unsigned long
> -__bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
> -		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
> -		u64 flags)
> +__bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
> +		 struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
> +		 u64 flags)
>  {
>  	struct sock *sk = NULL;
>  	u8 family = AF_UNSPEC;
> @@ -5192,15 +5192,28 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
>  		put_net(net);
>  	}
>  
> -	if (sk)
> -		sk = sk_to_full_sk(sk);
>  out:
>  	return (unsigned long) sk;
>  }
>  
>  static unsigned long
> -bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
> -	      u8 proto, u64 netns_id, u64 flags)
> +__bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
> +		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
> +		u64 flags)
> +{
> +	struct sock *sk;
> +
> +	sk = (struct sock *)__bpf_skc_lookup(skb, tuple, len, caller_net,
> +					    ifindex, proto, netns_id, flags);

This back and forth casting of pointer and long here and in bpf_sk_lookup is not pretty.
Before this patch there was one ulong cast, but now we probably need
to refactor this a bit.
Like changing __bpf_skc_lookup to return 'struct sock *' and do final (ulong)
cast only in bpf_[xdp_]sk[c]_lookup_[tcp|udp] that return it to bpf side?

