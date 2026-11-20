Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795192276;
	b=KSvwseyOSLk+gnDdLbnaDME3y1N+em9/KlAz5u8UgVjtlXH05p/bguotQxpFCi6igei9
	 C9TDhmjJTSd9Lg3o9MvAvzUuVojigzUzJ8mzedB8QBF83E237kGKhsGIHax1p42b/D4mi
	 th6B0NvPvI7FpuNhWNhQAsFMMwO6Ic65rB4JBEJmXEpjgiRF9XcBUY49OTVL8zz4UaKs2
	 ZGR7ZdbfG+ZCcA8awIBOQJkbXPx2iih++L7uCawPdGp1K6s1rDSMY/agmoeZk9OyPHbYk
	 f10LODfiRAeiptscFQYFqD2amv/WeD1gfG69SbJ0rwT/fgWC0VlltKj8dliw8X5k1Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9XybEk9chzsUT6dlIG5aWYHUt4msXk3ZvqFDS1Nqvss=;
	b=EJh3Ea4eyWAFvVk9JjsfPXFF8irDfmtmsR0h75Fz9ZjwU55O+kBeTWszAjEdlAnqIwii
	 THt9QdJzGSreuNzeT4ugHfUOKz8TmggNj3sU4Ck5aZSUdGCwuiAH4oU4KVhHJdRLclLH4
	 AM0X/tAo+JxVlDHLzQwy2SWbQOEPNexURxupIF1XEMQ4m1xjgNFXvEIVKVXLygQLUiNhc
	 C6b34l4Lqoe4cmXDmm8ukRFsIex0auIzmTura7HxxyImO0ISnfnFMEzA/QtA/v513+3+8
	 jNuSvmC/ne3jWo0st0nXkIS7kIb5D9hhTdd9A3FnTB/xcdh3ajoTbBfZtFGY9SDXODA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Y7rzbJ/9";
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE16606A330
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 16:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE16606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y7rzbJ/9
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-862a50e0f92so106372a34.1
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795192274; x=1795797074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9XybEk9chzsUT6dlIG5aWYHUt4msXk3ZvqFDS1Nqvss=;
        b=Y7rzbJ/9oy0cRWlUd5RmCcxdwDK9IU1dyTqSPCwxGr+XySafQCfsBdmcy1yRmq1/sF
         bfCZbUlrkG4KVgO32Vnx7Y8FCsE4JmFXWF5Gzhh3TqkVxW8kiO+RjHlsAu607dNQzUDU
         2G83HpQB8Cw/dVbw7wc2Lv52prQMMXo1ihYkldOSkOsQcw5jZQiLF0yECB7o/FwNyqnu
         gghth3w+y0eddTl9hzoVvBh9UOKzNTIT/FRQWtQwtY87FCV3+rJt7B0Tl4L2Sq4df0g/
         hOJh7hGdeOPRCpEy8HbmzJExuMsPJdF67prQY5NUUDepBp1inxiXkSzu8skBNcmSMFQq
         GFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795192274; x=1795797074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9XybEk9chzsUT6dlIG5aWYHUt4msXk3ZvqFDS1Nqvss=;
        b=wE+5bVXB9mZQ9pLNCQ3UWfVTkM3DHhqpdhhsYBjesu1E9doXCtXgGU0OM/f4rE3jXA
         Zq7KVXSMHKYkzHKYuvTbIvfrDMe80H3NQRtVV/p5fgO9kT34+v0ElrsoNooERzSi98le
         O5mNbgeChJf6O4W7EMpeVhLtPk2AdYMXBksc4P77olF0YYIheZ74KVr/6m3PQ1ZO9q/s
         /JAU4INeqHMsNwTfiQMwCnai0WncmcDR/O2SIiwKbT3DvOwTNdIWBTXhUUSAgBlZgTpD
         ep6nzIf4iH4Tj3oomB0p+G/+6Mz6OcJDG6gQevcM/TXWCNLARfyQ4ZcnmE71oOT6lQ4a
         WczA==
X-Gm-Message-State: APuU4Z/UaevBzccHubxATcodD4R8iFhOL2L+7KaCQkAR6TcIqTK5fFC+
	Z4QNeTM8C1ZAiphVhs/ViZL5P5yeB0CHxZpuoF05OQamrn2w+B5roHmM
X-Gm-Gg: AYBFou1DmiR7MlVPH5tT2NK1xlcsBdyBUCfipvOXB6po4Bp3LHZ5z9+DzWvfnKnSAoJ
	U+Vzj28S8zQJJe9ONBK27X6C2ykJViZcALDYvATJCQP4lz5RlcmFPw+0L4m7FPbg/tV++ONV1A6
	nkkd9lLN4CmVYHi0gDVKPGSTokFR8RnoPs954jGHNMIr6J/8/+indCpA/ZkMgAMgOun6yyP/b8F
	hBIBWNtGfkX4bgXFKGyHr+K7pfbZhN2GDEWeepRdsU/A2B9hQfQq0QGNzfCM/baceHCpiAQ63qe
	mibRO0fXeDC1flrRGGOJomxh6yKHoni6HrtN3n2NKTKJTPW12NdOOcOnDeV7+/8zRCqI0L0lft7
	HHdHI9zV5cjtTM75J0Uq6yvRyegi6A2tOuFjGmZdbfX84WSx0Uly2NXY0ZwdkdIplrifQoNJiez
	Tttn0ANQy2lXycut3NJSr1ARyjXMyD1c2UWRxVPSa81egegsBScX1pTVL4NNb2CW2aqzHFD7rsH
	GUjGDmRRBHbiVuuEk6Y6faQ4H/1kBHAxxT/wZPNROUEwKC3kHPmUAbX1l7DPwD/yhFFpqqDNYEu
	BYYr7XoL+vlKP0EMTpPRGS8=
X-Received: by 2002:a05:6830:4ac9:b0:862:bc33:da97 with SMTP id 46e09a7af769-863152c5e3fmr4649100a34.4.1795192273917;
        Fri, 20 Nov 2026 08:31:13 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631670c44dsm2384505a34.0.2026.11.20.08.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:31:13 -0800 (PST)
Date: Fri, 20 Nov 2026 08:31:08 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>, 
	Paul Chaignon <paul@isovalent.com>, Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/8] bpf: allow bpf_sk_assign on tc egress with
 refcounted sockets
Message-ID: <awB1eao9nFgiTn8A@devvm16445.scu0.facebook.com>
References: <20261119142231.2612515-1-razor@blackwall.org>
 <20261119142231.2612515-4-razor@blackwall.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119142231.2612515-4-razor@blackwall.org>

On 11/19, Nikolay Aleksandrov wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> 
> bpf_sk_assign() has been limited to tc ingress because the assigned
> socket may be a SOCK_RCU_FREE listener held without a refcount, relying
> on the current RCU read-side section for its lifetime. That assumption
> breaks on egress where the skb can sit in a qdisc across grace periods.
> However, the helper is also useful on the egress path, for example to
> attribute forwarded traffic to a specific established socket for qdisc
> flow classification (fq, fq_codel), cgroup accounting, or SO_PRIORITY
> propagation. Established sockets are refcounted and therefore safe to
> pin on an skb that may be queued.
> 
> Allow TC egress to assign full refcounted sockets, taking an skb-owned
> reference after orphaning any previous send-side owner. Preserve it
> across redirects, classic BPF verdicts and netem delay. Reject decrypted
> egress skbs to preserve the original TLS transmit owner.
> 
> Using sock_pfree_ref as a destructor encodes the refcount state so:
> 
>   - sock_pfree_ref releases the refcount on drop (unlike sock_pfree
>     which skips non-refcounted sockets).
>   - skb_sk_is_prefetched recognizes both destructors so ip_rcv_core
>     still skips the skb_orphan on the receive side.
>   - skb_steal_sock sets refcounted=true for sock_pfree_ref so the
>     transport layer calls sock_put after consuming the socket.
>   - skb_do_redirect only orphans sock_pfree + !sk_is_refcounted (the
>     true no-refcount case from ingress), preserving sock_pfree_ref
>     sockets across redirects.
> 
> The refcount_inc_not_zero cost per bpf_sk_assign call is negligible
> relative to the BPF program and the sk_lookup that precedes it, and
> does not affect the UDP early demux path which continues to use
> sock_pfree without a refcount.
> 
> Handle reference-only ownership in TLS software fallback and Chelsio
> record reconstruction without sk_wmem_alloc charges or lost references.
> 
> Software GSO splitting after assignment is unsupported, including qdisc,
> device/driver/tunnel fallback and netkit peer-side NFQUEUE segmentation.
> Segments can lose the selected socket; intact GSO and assignment after
> segmentation remain supported. Ordinary loopback and veth peer NAPI/GRO
> preparation can also discard the assignment, even without GSO.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
> CC: Ayush Sawal <ayush.sawal@chelsio.com>
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: David S. Miller <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@kernel.org>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Alexei Starovoitov <ast@kernel.org>
> CC: Daniel Borkmann <daniel@iogearbox.net>
> CC: Andrii Nakryiko <andrii@kernel.org>
> CC: Eduard Zingerman <eddyz87@gmail.com>
> CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> CC: Martin KaFai Lau <martin.lau@linux.dev>
> CC: Song Liu <song@kernel.org>
> CC: Yonghong Song <yonghong.song@linux.dev>
> CC: Jiri Olsa <jolsa@kernel.org>
> CC: Emil Tsalapatis <emil@etsalapatis.com>
> CC: Ihor Solodrai <ihor.solodrai@linux.dev>
> CC: John Fastabend <john.fastabend@gmail.com>
> CC: Stanislav Fomichev <sdf@fomichev.me>
> CC: Simon Horman <horms@kernel.org>
> CC: Kuniyuki Iwashima <kuniyu@google.com>
> CC: Willem de Bruijn <willemb@google.com>
> CC: Jamal Hadi Salim <jhs@mojatatu.com>
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Sabrina Dubroca <sd@queasysnail.net>
> CC: Paul Chaignon <paul@isovalent.com>
> CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
> CC: netdev@vger.kernel.org
> 
>  .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  5 ++++-
>  include/uapi/linux/bpf.h                      |  8 ++++---
>  net/core/filter.c                             | 22 +++++++++++++------
>  net/core/sock.c                               |  4 ++++
>  net/sched/act_bpf.c                           |  4 +++-
>  net/tls/tls_device_fallback.c                 |  5 +++--
>  tools/include/uapi/linux/bpf.h                |  8 ++++---
>  7 files changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> index 4d645771596a..796497e9d3b9 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
> @@ -1669,7 +1669,10 @@ static void chcr_ktls_copy_record_in_skb(struct sk_buff *nskb,
>  	nskb->truesize += record->len;
>  	nskb->sk = skb->sk;
>  	nskb->destructor = skb->destructor;
> -	refcount_add(nskb->truesize, &nskb->sk->sk_wmem_alloc);
> +	if (nskb->destructor == sock_pfree_ref)
> +		sock_hold(nskb->sk);
> +	else
> +		refcount_add(nskb->truesize, &nskb->sk->sk_wmem_alloc);
>  }
>  
>  /*
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 62de0919db72..45e3018fb2ae 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4611,7 +4611,9 @@ union bpf_attr {
>   *		**bpf_clone_redirect**\ () or other methods outside of BPF may
>   *		interfere with successful delivery to the socket.
>   *
> - *		This operation is only valid from TC ingress path.
> + *		This operation is valid from TC ingress and egress paths.
> + *		On egress, only full refcounted sockets are accepted.
> + *		Software GSO segmentation after assignment is unsupported.
>   *
>   *		The *flags* argument must be zero.
>   *	Return
> @@ -4623,8 +4625,8 @@ union bpf_attr {
>   *
>   *		**-ENETUNREACH** if the socket is unreachable (wrong netns).
>   *
> - *		**-EOPNOTSUPP** if the operation is not supported, for example
> - *		a call from outside of TC ingress.
> + *		**-EOPNOTSUPP** if the socket is unhashed, or TC egress uses
> + *		a non-full or non-refcounted socket or a decrypted packet.
>   *
>   * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u64 flags)
>   *	Description
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1ad57a371534..feeb752f7a00 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2559,14 +2559,17 @@ int skb_do_redirect(struct sk_buff *skb)
>  	if (unlikely(!dev))
>  		goto out_drop;
>  
> +#ifdef CONFIG_INET
>  	/*
> -	 * Prefetched sockets may borrow a listener under RCU. Orphan them
> -	 * before redirects that can outlive this section. Peer ingress
> -	 * stays in the same RCU section.
> +	 * Prefetched listeners may be borrowed under RCU. Drop borrowed
> +	 * assignments before redirects that can outlive this section.
> +	 * Peer ingress stays in the same RCU section.
>  	 */
> -	if (skb_sk_is_prefetched(skb) &&
> +	if (skb->destructor == sock_pfree &&
> +	    !sk_is_refcounted(skb->sk) &&
>  	    (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
>  		skb_orphan(skb);
> +#endif
>  	if (flags & BPF_F_PEER) {
>  		dev = skb_get_peer_dev(dev);
>  		if (unlikely(!dev ||
> @@ -8115,21 +8118,26 @@ static const struct bpf_func_proto bpf_tcp_gen_syncookie_proto = {
>  
>  BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
>  {
> +	bool egress = !skb_at_tc_ingress(skb);
> +	bool refcounted;
> +
>  	if (!sk || flags != 0)
>  		return -EINVAL;
> -	if (!skb_at_tc_ingress(skb))
> +	if (egress && (!sk_fullsock(sk) || !sk_is_refcounted(sk) ||
> +		       skb_is_decrypted(skb)))
>  		return -EOPNOTSUPP;
> +	refcounted = egress || sk_is_refcounted(sk);
>  	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
>  		return -ENETUNREACH;
>  	if (sk_unhashed(sk))
>  		return -EOPNOTSUPP;
> -	if (sk_is_refcounted(sk) &&
> +	if (refcounted &&
>  	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
>  		return -ENOENT;
>  
>  	skb_orphan(skb);
>  	skb->sk = sk;
> -	skb->destructor = sock_pfree;
> +	skb->destructor = egress ? sock_pfree_ref : sock_pfree;
>  
>  	return 0;
>  }


[..]

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 3b1f60eaa73e..f4ec58a86056 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2818,6 +2818,10 @@ static bool can_skb_orphan_partial(const struct sk_buff *skb)
>   */
>  void skb_orphan_partial(struct sk_buff *skb)
>  {
> +#ifdef CONFIG_INET
> +	if (skb->destructor == sock_pfree_ref)
> +		return;
> +#endif
>  	if (skb_is_tcp_pure_ack(skb))
>  		return;
>  
> diff --git a/net/sched/act_bpf.c b/net/sched/act_bpf.c
> index 06d8f78b7368..a0918fe9a71a 100644
> --- a/net/sched/act_bpf.c
> +++ b/net/sched/act_bpf.c
> @@ -54,8 +54,10 @@ TC_INDIRECT_SCOPE int tcf_bpf_act(struct sk_buff *skb,
>  	}
>  	if (unlikely(!skb->tstamp && skb->tstamp_type))
>  		skb->tstamp_type = SKB_CLOCK_REALTIME;
> -	if (skb_sk_is_prefetched(skb) && filter_res != TC_ACT_OK)
> +#ifdef CONFIG_INET
> +	if (skb->destructor == sock_pfree && filter_res != TC_ACT_OK)
>  		skb_orphan(skb);
> +#endif
>  
>  	/* A BPF program may overwrite the default action opcode.
>  	 * Similarly as in cls_bpf, if filter_res == -1 we use the

Maybe it's just me, but I don't think all these unrolled ==
sock_pfree{,_ref} checks are readable. Can we at least have new
skb_sk_is_prefetched-like wrappers to do these? With clear
names/comments/intent?
