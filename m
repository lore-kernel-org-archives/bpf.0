Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3743FCB03
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254097; cv=none; b=M33XUZFaxNN3roIBk4hpaqAa9+E7x63Xr897UfMd9ahhSw2Kqa0rKQfNG8wZJot6XCm6HAWGkH3dGdh4N7Gqqs8lrxO2QchdbS25tlwvyqGBeKjSt4aDlxxprg7Ee3sBFMgtwEKqt3zIXvXt1d9mKzWWkdOVRFf1lQFZS0pqJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254097; c=relaxed/simple;
	bh=9jtb35f0crCGnnq935Yf9dvcxp3G1+Y4iwe1G29XDb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYSYVGp2InnQcyoeP3X77eLYo0yUJSRTGaDwoVk6s3xgMdLnuq0vpSOrTCWhY81q1PsGneOAFfhIe/aY0I2OlEJYv1LxbmMZzoS5KtDpdMQPOw7FLwlf3ZbTWydMRPsyGPwLaGL+9/xSdj1vInGSX+SdSG1uR3ERbnHHvdiRuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UooR3nWU; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UooR3nWU"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c80167f56cdso821474a12.3
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778254092; x=1778858892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRskt9O7Kxq5nmB8B2ePNGaW8SgURuNPUxawOgj0fPQ=;
        b=UooR3nWUlBPUUgCAm841fhbV9/65A8s0AG1uLSHNYYHs8dMDwrWVtSEr6dW6cQGt90
         ryIpzgDhAN34idEyZ3CnYno4SzM3OmmZMTcr2VvcuqLlV8ayhRwR7wKOn3m3AVNd4tYu
         0u1EM97aFCQV5uhTeZcUgsTyjrJERog814RqesD8GJo0EqsX8k6D4kQjH55H0eSk63hS
         3wmWhSaOFTvciaOFA2Rq/iS1x3cds76XcCtAh2lMgWXfTf3dyF73u0OktYwyOTj57gPd
         4F3LoAE2deD89dizmEHFV9PDpvcS2DVhFBDM0jOxXXpTF5ZPOCZa57EFDTVaTaLhbw4d
         WowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254092; x=1778858892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRskt9O7Kxq5nmB8B2ePNGaW8SgURuNPUxawOgj0fPQ=;
        b=IawKvFEo0BFIT9i1pqSA0L7Vv2SuEsZniw8k8nmZyftJTu/b4BNqtBP7QII7mnEQPv
         U9fRD1vVJ/7u5fx0whlBHfNPVd3WB86S1GV9JJ4lr2vuWobD2YAKaBUTQuYqM+xd8LCm
         7qvP7GBr6mzm7vQJjORjDUG4R7E9XPnXua73YY8LYPGqs8A73HF4PAb3D3TJ9McQJfOT
         2tW4UdsaG5lF2sv8hGAYlx9/C1QaI5i7HNg28ZxJ04xXZIUUce92OyMwM0PlDXiUnt46
         0gOoA9e4xHeeVVmnu4Rx2K0ZNTZ+nB2DSDNL9tZEnuiM9hkJqEQNObh4fUHKDxVS7ynB
         Rv4w==
X-Forwarded-Encrypted: i=1; AFNElJ+HozFbnyvHZr6rNT8T3VsPC60t/tLity1QJpPXkjw8GAA4q3kSgyjc9M4D8zXD+etfb6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEd4NLw4qg9oxpjbRrPT8iU2NKIsQNz0nvuGK4FtIkWiZGK5/v
	Haq8gUhz9rBnfFbBUncfCQwVt+6aK60KrVrRFgpwcjwYcEfpuaroj5J3
X-Gm-Gg: AeBDievWhj5Qvvx+Jx2qd1UhvYc0ODQ3vd2avxGiZgOgEWbqnAHYs5aWs0WurscdcTC
	nhwzxqo9p+70rkZvkRl+JTvLqVVCVlCC2W3MzBSacdq/ygQNz8E57GGePVAdmVM/Q+6xNTQFDgk
	usuBnQFhiM0AnT/22X5qnyiO4avoY8uLdcmXS4ve1yi0iuIcmGNgyRcolsZgPUhZcNU98SThl2h
	TyrACXE/2UpZHvabod1XuUfiTD16S/tr++tAoKC/GSdsQO4fGaG+cm8Y3wna7VPLZLeez0ae3ZN
	ENYz2xFouennmI9UREpkkiXXMaPr/OFYzi/5sSlyndenZUhJv4eLFXu/16/E9xRKA3Mm9VIjcrz
	poX722EANTU1D3cb9RdTseycXkrPuY8KQOlkM9tpvwl7+8v3oifVFvimkVJrfmHPTfBmO6wO5k2
	RwBP6ZPbKOydPRQ48=
X-Received: by 2002:a05:6a21:329f:b0:39c:1f:3211 with SMTP id adf61e73a8af0-3aa5a9a037cmr14408234637.20.1778254091698;
        Fri, 08 May 2026 08:28:11 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267735e3fsm2134975a12.31.2026.05.08.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:28:11 -0700 (PDT)
Date: Fri, 8 May 2026 08:28:10 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
Message-ID: <af4AO2-9jwluWuik@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-8-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508073355.3916746-8-kuniyu@google.com>

On 05/08, Kuniyuki Iwashima wrote:
> Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.
> 
> Let's invoke the BPF SOCK_OPS prog when
> 
>   1. TCP stack enqueues skb to sk->sk_receive_queue
>      -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()
> 
>   2. TCP recvmsg() completes
>      -> __tcp_cleanup_rbuf()
> 
> This will allow the BPF prog to parse each skb and dynamically
> adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
> until sufficient data (e.g., a full RPC frame) is available
> in the receive queue.
> 
> Note that the direct access to bpf_sock_ops.data is intentionally
> disabled by passing 0 as end_offset.
> 
> Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
> with bpf_sock_ops because payload is not in the linear area
> with TCP header/data split on and skb may contain a RPC
> descriptor in skb frag.  This also simplifies the BPF prog.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

I was reading the series expecting to find some skb_queue_walk-like
implementation, but since it's a cgroup hook we obviously don't
need to do that.. So at this point BPF_SOCK_OPS_RCVLOWAT_CB_FLAG
is basically a "rx queue skb" hook, right? So should we make
the name more generic? There is really nothing lowat-specific
here besides your new kfunc to read the payload?

> ---
>  include/net/tcp.h       | 14 ++++++++++++++
>  net/ipv4/tcp.c          |  2 ++
>  net/ipv4/tcp_fastopen.c |  2 ++
>  net/ipv4/tcp_input.c    | 10 ++++++++++
>  4 files changed, 28 insertions(+)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4e9e634e276b..003e46c9b500 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_check(struct net *net, struct sock
>  }
>  #endif
>  
> +#ifdef CONFIG_CGROUP_BPF
> +void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
> +
> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_FLAG))
> +		bpf_skops_rcvlowat(sk, skb);
> +}
> +#else
> +static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
> +{
> +}
> +#endif
> +
>  /* From net/ipv6/syncookies.c */
>  int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
>  struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1d9e52fc454f..80144b97a87a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
>  		tcp_mstamp_refresh(tp);
>  		tcp_send_ack(sk);
>  	}
> +
> +	tcp_bpf_rcvlowat(sk, NULL);
>  }
>  
>  void tcp_cleanup_rbuf(struct sock *sk, int copied)
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 471c78be5513..91bf421fc5b6 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
>  	TCP_SKB_CB(skb)->seq++;
>  	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
>  
> +	tcp_bpf_rcvlowat(sk, skb);
> +

I'm also not sure about the particular placement of some of these..
For example here, why do it before updating tp? Why not after?

(and same for tcp_ofo_queue)
