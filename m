Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB7547DFA9
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013135; cv=none; b=nj41YkGleZGInNDW3h5GBnjOLwrPNgw1gX2RnJLrBkN6MhH2Y4B0FaFeDI9WuAvzzik+7c/bkf0ZVdb4fDrxiW7W2D8+Dfx3uJEBLEwgGdhsAQRRBOyTOc4sEe+bVkhPCkKa4DiNlMCHZA3PyOHdwmcRK0Lw3Db5k6Sc3DKISZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013135; c=relaxed/simple;
	bh=WLMBnn9EZmjBxmpowiiVk0GIxnQx72XAxGRRyfNI45Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9QSs8+uSijYLEyQX5pNoZkVkM5LWu3SbutwrJ8LuDvJ7XhPPhZE+lH7CagtIcKiX2jH9yq6FhT6wXf0XaVrfhML6Hna85LhHIBPfADGSZ3ltbxq3gGRLoNTrAIv9gZVLOfAHT3jDvMgqr9D8YYUKwW/m4pxhS2itUHG79n18Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2hzhPSL; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2hzhPSL"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e934c6c1c8so3821655ad.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792013133; x=1792617933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G+Nt1WU9o0/6agOUrFEv9wiq3Bk8RTaplLrnvKQ3ikc=;
        b=k2hzhPSLI5oHXk4prZrk4rOxffYCQMfxvxH5i8lyGuhL899hYZ0r5Jj11z3VpekgEe
         C2UER27kLovqvWd10w35EOOvcpue7dm3hx6enS+VpjkIORPmdjTFZQrsiYrSv71s/ItN
         jkwp2hbkSiyvCbzuFoBJZBiHUvzXyI3v8MBRrXmkd22YB/FO0HvZshgxzpPJe8CaC9v7
         /kjEr+6E8FhPMci2crup63omfYZthy5yyFdilEG3luHiYH0xMdO+WwilU7MF/jrDg3Ac
         mtMxhQipNwXZPcZjUq+zOPDeU4Sj0HULdH4mpIgNyB6S0O0FxlY2KvuD+nj52I5uCunh
         pY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792013133; x=1792617933;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+Nt1WU9o0/6agOUrFEv9wiq3Bk8RTaplLrnvKQ3ikc=;
        b=A3UmPjPjrMz9rMhaHj+/cztUEYNV8T3/YELWwLxXEubP4IhLKhQXK03tDmByxpM+s1
         AuffyqAnLVg+sLiPyhKwTS+k/PTOSLhQ5h1ulBJgjr4lWEc/WAcnrWY8Zrg0su6Lsdjd
         d1MMh4fT9WjJKWT6YZvhRzxjfj/Z7aE35JWRQrBTWzmmYFctneCocC+kQcOXtYViIJ6l
         LTJA0oDMqxnLKOq7l2yD/RoDY43v/i4PAYK30s1r4WWLUCacEIrC1NepazGUiaYCKw/S
         rS7zo7Bri1ozUkIhSkw5zLy7wvjnA3oin7lnJmfQLMue0/vV0vi9R6N2FodY3ETC2xRN
         VkeA==
X-Forwarded-Encrypted: i=1; AKwUvBxssUcaAOZanu9OSoL13jWn96lfL4uSllixnB1/jGMfjruNrL6XK+YsEyzWnjC+Xanl4T4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKg5qlYk9PNrtXRGezK23yeKzZXFeN5caP3wDFYh6+mvFDH4hJe
	FcyLh32pIEMozIcqrMZrjonXwvles1hYE8F8i+D/kOfNsaw5SP0U4CJ9
X-Gm-Gg: AYBFou1/1OG6OUwcBOP6Vv8wq61QsvKLYryVfNOG1xGwDYXTPCnugGYi9OJ17f/JQ4N
	gLNx9hhQzXB2864nxl+rZrPm+IMelazzSwlY0ZBE3AphUn1yOUdQR0nks7YC6+54wJ8mStFsg49
	6JZmcpp/NRQ7g/bbpCYxqD1SIii1CxTnLTOtONHvYW4FjW3sMEbSqkbsYmD/gKAKi1SbZzy38C3
	Au7lMVu5B/Oi1ICHHBLCi5SzElPwQTh7wozdxQca1MsqxFf//NMfNv/DY6Kx8FR2kCsD/tOpbkv
	lW3aykFPw9Q0mXUslDo9c2n2Vjh4tsKt2czWT37PYyEmYBOtFxcTN9NKSiUWpb2nJ/xhLsfLDE1
	REES+qH3evf7qDZW78jkX3gjwBN5juVCQt29ARnEVVWGNAAiyn75fTO2YZ3v0nhAaTGF/me6O8M
	tj0DLCcn9W8wGz/8eUjjm4QahekEFxoU8+SFWmyW0WrbwfYv/3zKCwimupg4PS+qdD
X-Received: by 2002:a17:90b:3b90:b0:3ac:17c:6e7c with SMTP id 98e67ed59e1d1-3ac017c7089mr9474554a91.37.1792013133174;
        Wed, 14 Oct 2026 14:25:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e821csm1019907a91.8.2026.10.14.14.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:25:32 -0700 (PDT)
Date: Wed, 14 Oct 2026 14:25:21 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Petr Machata <petrm@nvidia.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Jakub Raczynski <j.raczynski@samsung.com>, 
	Wang Zhan <wang.zhan@smartx.com>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 3/6] net: skbuff: replace skb_page_unref()
 and __skb_frag_unref() with skb_netmem_unref()
Message-ID: <as_yg4hCCfpkukZB@devvm7509.cco0.facebook.com>
References: <20261014173945.373295-1-almasrymina@google.com>
 <20261014173945.373295-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014173945.373295-4-almasrymina@google.com>

On 10/14, Mina Almasry wrote:
> Unreferencing a page_pool fragment with recycle=false decrements the
> non-pp backing refcount instead of pp_ref_count, underflowing the page
> refcount when the fragment was owned via page_pool (as on mlx4's RX
> error path). Having both skb_page_unref() and __skb_frag_unref(frag,
> recycle) made it easy for callers to pass hardcoded recycle=false on
> SKB-owned fragments.
> 
> Replace skb_page_unref() and __skb_frag_unref() with
> skb_netmem_unref(netmem, recycle), which dispatches to
> napi_pp_put_page() when recycle is true and put_netmem() otherwise:
> 
> - Use skb_frag_unref(skb, ...) on SKB-owned fragments in mlx4, sky2,
>   tls_strp, and skb_shift() so unrefs always match skb->pp_recycle.
> - Use put_netmem() directly in tls_device's destroy_record(), which
>   releases raw non-pp page references outside an SKB.
> 
> Found by code inspection and confirmed with the KUnit tests added later
> in this series; not observed in production. The mlx4, sky2, and TLS
> call-site changes are compile-tested only.
> 
> Assisted-by: LLM
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
> v2:
> - Note how the issue was found and how the change was tested.
> - Link to v1: https://lore.kernel.org/netdev/20261010083935.3274178-4-almasrymina@google.com/
> ---
>  drivers/net/ethernet/marvell/sky2.c        |  2 +-
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
>  include/linux/skbuff_ref.h                 | 34 +++++++++++-----------
>  net/core/skbuff.c                          |  7 +++--
>  net/ipv4/esp4.c                            |  4 +--
>  net/ipv6/esp6.c                            |  4 +--
>  net/tls/tls_device.c                       |  2 +-
>  net/tls/tls_strp.c                         |  2 +-
>  8 files changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
> index 30facdece3e29..1d42a82db8f2b 100644

[..]

> --- a/drivers/net/ethernet/marvell/sky2.c
> +++ b/drivers/net/ethernet/marvell/sky2.c
> @@ -2501,7 +2501,7 @@ static void skb_put_frags(struct sk_buff *skb, unsigned int hdr_space,
>  
>  		if (length == 0) {
>  			/* don't need this page */
> -			__skb_frag_unref(frag, false);
> +			skb_frag_unref(skb, i);
>  			--skb_shinfo(skb)->nr_frags;
>  		} else {
>  			size = min(length, (unsigned) PAGE_SIZE);
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> index 96f97fa0f5489..fe18606c2ab55 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> @@ -497,7 +497,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
>  fail:
>  	while (nr > 0) {
>  		nr--;
> -		__skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
> +		skb_frag_unref(skb, nr);
>  	}
>  	return 0;
>  }

These do not support qops and don't advertise devmem tx, so they are not
going to deal with netmems anytime soon, why touch these?

> diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
> index 0441c220fdbdf..04114c64dad99 100644
> --- a/include/linux/skbuff_ref.h
> +++ b/include/linux/skbuff_ref.h
> @@ -36,7 +36,16 @@ static __always_inline void skb_frag_ref(struct sk_buff *skb, int f)
>  
>  bool napi_pp_put_page(netmem_ref netmem);
>  
> -static __always_inline void skb_page_unref(netmem_ref netmem, bool recycle)
> +/**
> + * skb_netmem_unref - release a fragment reference on a netmem
> + * @netmem: netmem to unreference
> + * @recycle: whether page_pool recycling is enabled (e.g. skb->pp_recycle)
> + *
> + * Drops pp_ref_count via napi_pp_put_page() if @recycle is true and @netmem
> + * belongs to a page_pool; otherwise drops a non-pp backing reference via
> + * put_netmem(). Counterpart to skb_netmem_ref().
> + */
> +static __always_inline void skb_netmem_unref(netmem_ref netmem, bool recycle)
>  {
>  #ifdef CONFIG_PAGE_POOL
>  	if (recycle && napi_pp_put_page(netmem))
> @@ -46,31 +55,22 @@ static __always_inline void skb_page_unref(netmem_ref netmem, bool recycle)
>  }
>  
>  /**
> - * __skb_frag_unref - release a reference on a paged fragment.
> - * @frag: the paged fragment
> - * @recycle: recycle the page if allocated via page_pool
> - *
> - * Releases a reference on the paged fragment @frag
> - * or recycles the page via the page_pool API.
> - */
> -static __always_inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
> -{
> -	skb_page_unref(skb_frag_netmem(frag), recycle);
> -}
> -
> -/**
> - * skb_frag_unref - release a reference on a paged fragment of an skb.
> + * skb_frag_unref - release a reference on a paged fragment of an skb
>   * @skb: the buffer
>   * @f: the fragment offset
>   *
> - * Releases a reference on the @f'th paged fragment of @skb.
> + * Drops a reference on the @f'th fragment of @skb via skb_netmem_unref()
> + * (pp_ref_count if skb->pp_recycle and page_pool-backed, else non-pp
> + * backing refcount), skipping managed zerocopy fragments. Counterpart to
> + * skb_frag_ref().
>   */
>  static __always_inline void skb_frag_unref(struct sk_buff *skb, int f)
>  {
>  	struct skb_shared_info *shinfo = skb_shinfo(skb);
>  
>  	if (!skb_zcopy_managed(skb))
> -		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle);
> +		skb_netmem_unref(skb_frag_netmem(&shinfo->frags[f]),
> +				 skb->pp_recycle);
>  }
>  
>  #endif	/* _LINUX_SKBUFF_REF_H */
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 76a42c60508d9..980bbe9166393 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1144,7 +1144,8 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason)
>  	}
>  
>  	for (i = 0; i < shinfo->nr_frags; i++)
> -		__skb_frag_unref(&shinfo->frags[i], skb->pp_recycle);
> +		skb_netmem_unref(skb_frag_netmem(&shinfo->frags[i]),
> +				 skb->pp_recycle);
>  
>  free_head:
>  	if (shinfo->frag_list)
> @@ -1154,7 +1155,7 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason)
>  exit:
>  	/* When we clone an SKB we copy the reycling bit. The pp_recycle
>  	 * bit is only set on the head though, so in order to avoid races
> -	 * while trying to recycle fragments on __skb_frag_unref() we need
> +	 * while trying to recycle fragments on skb_netmem_unref() we need
>  	 * to make one SKB responsible for triggering the recycle path.
>  	 * So disable the recycling bit if an SKB is cloned and we have
>  	 * additional references to the fragmented part of the SKB.
> @@ -4412,7 +4413,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
>  		fragto = &skb_shinfo(tgt)->frags[merge];
>  
>  		skb_frag_size_add(fragto, skb_frag_size(fragfrom));
> -		__skb_frag_unref(fragfrom, skb->pp_recycle);
> +		skb_frag_unref(skb, 0);
>  	}

[..]

>  	/* Reposition in the original skb */
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index e76db5817e78e..ae701561d9f12 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -117,8 +117,8 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
>  		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;
>  
>  		for (sg = sg_next(src); sg; sg = sg_next(sg))
> -			skb_page_unref(page_to_netmem(sg_page(sg)),
> -				       skb->pp_recycle);
> +			skb_netmem_unref(page_to_netmem(sg_page(sg)),
> +					 skb->pp_recycle);
>  	}
>  }
>  
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index b1c9b36f76dc4..d654f0f442388 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -134,8 +134,8 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
>  		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;
>  
>  		for (sg = sg_next(src); sg; sg = sg_next(sg))
> -			skb_page_unref(page_to_netmem(sg_page(sg)),
> -				       skb->pp_recycle);
> +			skb_netmem_unref(page_to_netmem(sg_page(sg)),
> +					 skb->pp_recycle);
>  	}
>  }
>  
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f11d0528fc431..b333a9a72cdae 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -143,7 +143,7 @@ static void destroy_record(struct tls_record_info *record)
>  	int i;
>  
>  	for (i = 0; i < record->num_frags; i++)
> -		__skb_frag_unref(&record->frags[i], false);
> +		put_netmem(skb_frag_netmem(&record->frags[i]));
>  	kfree(record);
>  }
>  
> diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> index 6cc222008d95c..53d3256d0114a 100644
> --- a/net/tls/tls_strp.c
> +++ b/net/tls/tls_strp.c
> @@ -197,7 +197,7 @@ static void tls_strp_flush_anchor_copy(struct tls_strparser *strp)
>  	DEBUG_NET_WARN_ON_ONCE(atomic_read(&shinfo->dataref) != 1);
>  
>  	for (i = 0; i < shinfo->nr_frags; i++)
> -		__skb_frag_unref(&shinfo->frags[i], false);
> +		skb_frag_unref(strp->anchor, i);
>  	shinfo->nr_frags = 0;
>  	if (strp->copy_mode) {
>  		kfree_skb_list(shinfo->frag_list);

Idk this part, seems harmless.. But are you sure we can even reach xfrm
(supposedly that's how we get to esp4) with netmems?
