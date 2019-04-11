Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C67DC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 05:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C350F2133D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 05:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Syh9vI79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfDKFdJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:33:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42714 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKFdJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 01:33:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so5480782wrx.9
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 22:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YMGp3dvRwi4O62jsENa5WnApPmSzgB6N7KhEpKllvTk=;
        b=Syh9vI79lHWuhHRkKuLmRvpIu9Sm2Y0heCxO7YY1FPFkt0BdFxRpvyEREPphAxpecx
         SaCumoTEX036lfkarVSLMqufUeadxeYMUfYQlp/Zk//terK7MCCHzdJYRR1NzN8zRXZN
         C2waeNA0v7YQUFgPrJePfSZ5jM2PJ9giY90BvaenZub2FW94SRjCURQmzrdEst4PbqWI
         Fi+AWu6XoKIUBMpGu6RcoY1gu70DUTBYvQwx5U2xyLOWuFHp6qqsj0VSCeFTxatnORN/
         lDeynSjyT9H45/fayfDAfqH7fWS603M6TTHAefuRWGj0eEX0mPnPx0XeDDomeofQBcl7
         siyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YMGp3dvRwi4O62jsENa5WnApPmSzgB6N7KhEpKllvTk=;
        b=ay8XHnxXEhn6herTBqTTwbU0zA5IniK24hyZzKzmx4CB/RwW3DWcsBkWtpmUzVHMH3
         A0Qz7lMuj03qUeT3ggvshTLfvpIcf9Zl/3blEnm9LgMXFzxzhTx/vQQWh1FTc13uWckE
         7ZBDJX24zTFwU+MwnUD+gY3bv283GDljzFtuS/u1bblPvO2/I7F2v2pLAMwwrcfbL3MM
         ObrVTllVkfsqksIac1i9cqrbyeck3JXZX22geHwwW/4Nk2Wh/jzNovIuhrFXcfaMkEVH
         7piv2NJylvuEVCqrqDQ0dxiiz1A3iETw9ZyTerCX440B25DOvtehrn1EFYMoE9BY0Xx5
         SgAg==
X-Gm-Message-State: APjAAAWkmgY+X0UFPNkI+8f9oNlFuPluQJYL6yLju6IWSx1YeuLJcGU3
        Xc22xSqCLIQcz1/LODrAEVcFhQ==
X-Google-Smtp-Source: APXvYqxTjQzd6Ugoy0pQXhzMikh1PpeGUmI6R0VlRUYzlo9Mz+moTiGvMOwmz5Dz3INJpOmnT8Cr6g==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr29832227wrx.4.1554960787028;
        Wed, 10 Apr 2019 22:33:07 -0700 (PDT)
Received: from apalos (athedsl-165181.home.otenet.gr. [85.75.188.219])
        by smtp.gmail.com with ESMTPSA id j22sm114114295wrd.91.2019.04.10.22.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:33:06 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:33:03 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, bpf@vger.kernel.org,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Subject: Re: [PATCH bpf-next 3/5] net: core: introduce build_skb_around
Message-ID: <20190411053303.GA1416@apalos>
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
 <155489662793.20826.5533583763088193882.stgit@firesoul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155489662793.20826.5533583763088193882.stgit@firesoul>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 10, 2019 at 01:43:47PM +0200, Jesper Dangaard Brouer wrote:
> The function build_skb() also have the responsibility to allocate and clear
> the SKB structure. Introduce a new function build_skb_around(), that moves
> the responsibility of allocation and clearing to the caller. This allows
> caller to use kmem_cache (slab/slub) bulk allocation API.
> 
> Next patch use this function combined with kmem_cache_alloc_bulk.
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  include/linux/skbuff.h |    2 +
>  net/core/skbuff.c      |   71 +++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 54 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 9027a8c4219f..c40ffab8a9b0 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1044,6 +1044,8 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t priority, int flags,
>  			    int node);
>  struct sk_buff *__build_skb(void *data, unsigned int frag_size);
>  struct sk_buff *build_skb(void *data, unsigned int frag_size);
> +struct sk_buff *build_skb_around(struct sk_buff *skb,
> +				 void *data, unsigned int frag_size);
>  
>  /**
>   * alloc_skb - allocate a network buffer
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 4782f9354dd1..d904b6e5fe08 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -258,6 +258,33 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
>  }
>  EXPORT_SYMBOL(__alloc_skb);
>  
> +/* Caller must provide SKB that is memset cleared */
> +static struct sk_buff *__build_skb_around(struct sk_buff *skb,
> +					  void *data, unsigned int frag_size)
> +{
> +	struct skb_shared_info *shinfo;
> +	unsigned int size = frag_size ? : ksize(data);
> +
> +	size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	/* Assumes caller memset cleared SKB */
> +	skb->truesize = SKB_TRUESIZE(size);
> +	refcount_set(&skb->users, 1);
> +	skb->head = data;
> +	skb->data = data;
> +	skb_reset_tail_pointer(skb);
> +	skb->end = skb->tail + size;
> +	skb->mac_header = (typeof(skb->mac_header))~0U;
> +	skb->transport_header = (typeof(skb->transport_header))~0U;
> +
> +	/* make sure we initialize shinfo sequentially */
> +	shinfo = skb_shinfo(skb);
> +	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> +	atomic_set(&shinfo->dataref, 1);
> +
> +	return skb;
> +}
> +
>  /**
>   * __build_skb - build a network buffer
>   * @data: data buffer provided by caller
> @@ -279,32 +306,15 @@ EXPORT_SYMBOL(__alloc_skb);
>   */
>  struct sk_buff *__build_skb(void *data, unsigned int frag_size)
>  {
> -	struct skb_shared_info *shinfo;
>  	struct sk_buff *skb;
> -	unsigned int size = frag_size ? : ksize(data);
>  
>  	skb = kmem_cache_alloc(skbuff_head_cache, GFP_ATOMIC);
> -	if (!skb)
> +	if (unlikely(!skb))
>  		return NULL;
>  
> -	size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -
>  	memset(skb, 0, offsetof(struct sk_buff, tail));
> -	skb->truesize = SKB_TRUESIZE(size);
> -	refcount_set(&skb->users, 1);
> -	skb->head = data;
> -	skb->data = data;
> -	skb_reset_tail_pointer(skb);
> -	skb->end = skb->tail + size;
> -	skb->mac_header = (typeof(skb->mac_header))~0U;
> -	skb->transport_header = (typeof(skb->transport_header))~0U;
>  
> -	/* make sure we initialize shinfo sequentially */
> -	shinfo = skb_shinfo(skb);
> -	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> -	atomic_set(&shinfo->dataref, 1);
> -
> -	return skb;
> +	return __build_skb_around(skb, data, frag_size);
>  }
>  
>  /* build_skb() is wrapper over __build_skb(), that specifically
> @@ -325,6 +335,29 @@ struct sk_buff *build_skb(void *data, unsigned int frag_size)
>  }
>  EXPORT_SYMBOL(build_skb);
>  
> +/**
> + * build_skb_around - build a network buffer around provided skb
> + * @skb: sk_buff provide by caller, must be memset cleared
> + * @data: data buffer provided by caller
> + * @frag_size: size of data, or 0 if head was kmalloced
> + */
> +struct sk_buff *build_skb_around(struct sk_buff *skb,
> +				 void *data, unsigned int frag_size)
> +{
> +	if (unlikely(!skb))
Maybe add a warning here, indicating the buffer *must* be there before calling
this?

> +		return NULL;
> +
> +	skb = __build_skb_around(skb, data, frag_size);
> +
> +	if (skb && frag_size) {
> +		skb->head_frag = 1;
> +		if (page_is_pfmemalloc(virt_to_head_page(data)))
> +			skb->pfmemalloc = 1;
> +	}
> +	return skb;
> +}
> +EXPORT_SYMBOL(build_skb_around);
> +
>  #define NAPI_SKB_CACHE_SIZE	64
>  
>  struct napi_alloc_cache {
> 

/Ilias
