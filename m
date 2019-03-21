Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1910C43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 03:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7019218AE
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 03:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/qu+hqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCUDjr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:39:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44617 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUDjr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Mar 2019 23:39:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so3273063pgj.11;
        Wed, 20 Mar 2019 20:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxyFL9AKKuk/gqswhu5VS6912fe5vl+Vt8RZFQPbhGM=;
        b=H/qu+hqt6WfdcjnxWKEGKoKIzgqVIuH8+TDb54XjPQeSWXPIhejjVii/oC8FjXAhXB
         5pedWPtm2K50t3DpGIbfe5Ki7TiVrJlX/4Naq3TNsbd/BHqSqgLTbExBhiSGmAcnA6wA
         5r7d7rmT5I1jk+KNAahkLJSJZ+Gv0tZHRhlqMnNqp4orm4415E7+MsLnKRJeeFR4Jo6/
         NNKu4Dn3zb7an3F2FEdeFi5NSeo7lZelpcLbo9J5Ww6xnp1CpIZ0glpvg0zjIBFDNZzN
         aB6WSysg2w43urUm9PY63zn6WfwgjmvGLWkZkaRx5YX6xnvhXBdXbbNQnRlERqFodx0T
         8InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxyFL9AKKuk/gqswhu5VS6912fe5vl+Vt8RZFQPbhGM=;
        b=q/VgW5M8rnoF2TswCplhc/GmSHBDlJPhFUu4fFdLq+W0eWvsjTHbJ4Wtf41m+3EheC
         w1uM05yQtFBz2sqCeSLE9v9OwkhJdj3kkPXl1L1MwwlWkUWJLxD7Er+bgFsrtkd0EjF/
         jbrNVbspElTR8+iztIbJ1EdG29ciBDJr1HvCC/oUzu1m7zLDd+Y009oDjlAREMTs2tYD
         gvitfa7iMGC5I15PfLjzWWm6+jKpaayrFDbT9v22RtKaZijJojLq1Kw1WZuoPMNJ061B
         SulftH7l4bMHLug+BCXyNaTCB9i0ZZhoAbWnnPpRSOYiOoHbXrbtTX7/Ngr30uek17T7
         q2RA==
X-Gm-Message-State: APjAAAW4Phc1bEqcnW2JSUyTYgZz/2drq5mWNX7L7C6MVaVWuP6owshv
        xm17wxOa3XllEfmW7OKlobw=
X-Google-Smtp-Source: APXvYqxwadvWpZl/ZiXUsGC/HAZOL694MHT8MpbmoSMFi+WY3wWjzo8QpQf3s7ThskxvP0LSaCOhLQ==
X-Received: by 2002:a62:4290:: with SMTP id h16mr1322123pfd.8.1553139586392;
        Wed, 20 Mar 2019 20:39:46 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::c891])
        by smtp.gmail.com with ESMTPSA id h3sm6430705pfb.31.2019.03.20.20.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 20:39:45 -0700 (PDT)
Date:   Wed, 20 Mar 2019 20:39:42 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
Subject: Re: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo}
 helpers
Message-ID: <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com>
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-2-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319221948.170441-2-sdf@google.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 19, 2019 at 03:19:40PM -0700, Stanislav Fomichev wrote:
> __init_skb is essentially a version of __build_skb which accepts skb as
> an argument (instead of doing kmem_cache_alloc to allocate it).
> 
> __init_skb_shinfo initializes shinfo.
> 
> __init_skb_data initializes skb data pointers.
> 
> No functional changes.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/skbuff.h | 14 ++++++++++
>  net/core/skbuff.c      | 60 +++++++++++++++++-------------------------
>  2 files changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 9027a8c4219f..e8c1d5b97f96 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -4399,5 +4399,19 @@ static inline __wsum lco_csum(struct sk_buff *skb)
>  	return csum_partial(l4_hdr, csum_start - l4_hdr, partial);
>  }
>  
> +static inline void __init_skb_data(struct sk_buff *skb, u8 *data,
> +				   unsigned int size)
> +{
> +	/* Account for allocated memory : skb + skb->head */
> +	skb->truesize = SKB_TRUESIZE(size);
> +	refcount_set(&skb->users, 1);
> +	skb->head = data;
> +	skb->data = data;
> +	skb_reset_tail_pointer(skb);
> +	skb->end = skb->tail + size;
> +	skb->mac_header = (typeof(skb->mac_header))~0U;
> +	skb->transport_header = (typeof(skb->transport_header))~0U;
> +}
> +
>  #endif	/* __KERNEL__ */
>  #endif	/* _LINUX_SKBUFF_H */
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 2415d9cb9b89..b413354ee709 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -160,6 +160,26 @@ static void *__kmalloc_reserve(size_t size, gfp_t flags, int node,
>   *
>   */
>  
> +static inline void __init_skb(struct sk_buff *skb, u8 *data, unsigned int size)
> +{
> +	/* Only clear those fields we need to clear, not those that we will
> +	 * actually initialize below. Hence, don't put any more fields after
> +	 * the tail pointer in struct sk_buff!
> +	 */
> +	memset(skb, 0, offsetof(struct sk_buff, tail));
> +	__init_skb_data(skb, data, size);
> +}
> +
> +static inline void __init_skb_shinfo(struct sk_buff *skb)
> +{
> +	struct skb_shared_info *shinfo;
> +
> +	/* make sure we initialize shinfo sequentially */
> +	shinfo = skb_shinfo(skb);
> +	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> +	atomic_set(&shinfo->dataref, 1);
> +}
> +
>  /**
>   *	__alloc_skb	-	allocate a network buffer
>   *	@size: size to allocate
> @@ -181,7 +201,6 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
>  			    int flags, int node)
>  {
>  	struct kmem_cache *cache;
> -	struct skb_shared_info *shinfo;
>  	struct sk_buff *skb;
>  	u8 *data;
>  	bool pfmemalloc;
> @@ -215,27 +234,9 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask,
>  	size = SKB_WITH_OVERHEAD(ksize(data));
>  	prefetchw(data + size);
>  
> -	/*
> -	 * Only clear those fields we need to clear, not those that we will
> -	 * actually initialise below. Hence, don't put any more fields after
> -	 * the tail pointer in struct sk_buff!
> -	 */
> -	memset(skb, 0, offsetof(struct sk_buff, tail));
> -	/* Account for allocated memory : skb + skb->head */
> -	skb->truesize = SKB_TRUESIZE(size);
> +	__init_skb(skb, data, size);
> +	__init_skb_shinfo(skb);
>  	skb->pfmemalloc = pfmemalloc;
> -	refcount_set(&skb->users, 1);
> -	skb->head = data;
> -	skb->data = data;
> -	skb_reset_tail_pointer(skb);
> -	skb->end = skb->tail + size;
> -	skb->mac_header = (typeof(skb->mac_header))~0U;
> -	skb->transport_header = (typeof(skb->transport_header))~0U;
> -
> -	/* make sure we initialize shinfo sequentially */
> -	shinfo = skb_shinfo(skb);
> -	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> -	atomic_set(&shinfo->dataref, 1);
>  
>  	if (flags & SKB_ALLOC_FCLONE) {
>  		struct sk_buff_fclones *fclones;
> @@ -277,7 +278,6 @@ EXPORT_SYMBOL(__alloc_skb);
>   */
>  struct sk_buff *__build_skb(void *data, unsigned int frag_size)
>  {
> -	struct skb_shared_info *shinfo;
>  	struct sk_buff *skb;
>  	unsigned int size = frag_size ? : ksize(data);
>  
> @@ -287,20 +287,8 @@ struct sk_buff *__build_skb(void *data, unsigned int frag_size)
>  
>  	size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  
> -	memset(skb, 0, offsetof(struct sk_buff, tail));
> -	skb->truesize = SKB_TRUESIZE(size);
> -	refcount_set(&skb->users, 1);
> -	skb->head = data;
> -	skb->data = data;
> -	skb_reset_tail_pointer(skb);
> -	skb->end = skb->tail + size;
> -	skb->mac_header = (typeof(skb->mac_header))~0U;
> -	skb->transport_header = (typeof(skb->transport_header))~0U;
> -
> -	/* make sure we initialize shinfo sequentially */
> -	shinfo = skb_shinfo(skb);
> -	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> -	atomic_set(&shinfo->dataref, 1);
> +	__init_skb(skb, data, size);
> +	__init_skb_shinfo(skb);

I think you need to convince Dave and Eric that
above surgery is necessary to do the hack in patch 6 with
+static DEFINE_PER_CPU(struct sk_buff, bpf_flow_skb);

I think the better option it to introduce new prog type that works
without skb. I think it can be pretty close to shape and form to xdp.

