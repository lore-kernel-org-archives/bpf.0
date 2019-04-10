Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD46C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB05C20645
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTHmWDij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfDJXel (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:34:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37090 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDJXel (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 19:34:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so5052887qtn.4;
        Wed, 10 Apr 2019 16:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wboZM5tSrUKoxl5yWqXoJzjsFvqiilh8fe/9lpBu+3w=;
        b=nTHmWDij2fJuUrTeKpi1/jd6WWPzSGNV/XCtOTf/UD5fwbo4SpzTTpSa6BVk+a748D
         SxVIEh+mfbPgu/gEZJKINwEHw/xNiMCVSxVehM22sRXWIXVVZM3GI+lOSvx3sskHGuZI
         ceptGicVykuNPpF4rvXtMby/Q/PfUwNxk1u2aWi/Kzy935g0jrnXUYaaAjp5q5o+YL2G
         ezkhUzxWsQqkCuLPtbPJXWiuY/9vWbd8kqosqG5/t16LqNJCEOnBRttVM//GO+SsauVO
         AWpzAQ1mToEG/U/EjuFNNuzqv79Oq4K579P97jh6tFxZmrVZMrq3bRLdNQXReTEXU+ny
         kF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wboZM5tSrUKoxl5yWqXoJzjsFvqiilh8fe/9lpBu+3w=;
        b=colZ1EOCtt4RPaixezJ4xRiTp3i46ahf4yQfEHxDcttH4yvbAxZ2nFsFq74/yM/XrQ
         D+N4w13plrbzfWDoPQ+iCqdGmyIhdglT9VQ3NkSrFXQB4bPWdibSzqTJtKVM6msUQiMs
         YLWY1z0PGjB25ljueOJ/9Pj2vX1sAac9p0B536cRdkWCKzYJFqufqZHJ1DqvWjpToQJx
         pw1ekYexWnwIjCpBXC92hr+LzE37IrG7QoRoq/U6r70tLwhq/bLxJIafGINUMqud7HUg
         j4ZIFGEipI49t4iULHx8ANtRm6b51QfIzVG/NTTqfBpiwhhSV42UTSJbHq06De6WkN00
         urBQ==
X-Gm-Message-State: APjAAAWKXyS/kzJ7eLDa4dOU0hjqZws50eRoHu6iE8eODaBETcxLDOOs
        CH4dvUWAFwz1dSIv3KTFIpG1FaLJAV5NM5bhv1A=
X-Google-Smtp-Source: APXvYqyzofh/2Q+mt2sELTh0tglj/2sl/mKuemrKtNdD7nZjll99CwCdx4XOK3Mr/PuvipqEckKrlAW9uP1QCz1F4b0=
X-Received: by 2002:ac8:30a1:: with SMTP id v30mr38854266qta.176.1554939279900;
 Wed, 10 Apr 2019 16:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <155489659290.20826.1108770347511292618.stgit@firesoul> <155489662793.20826.5533583763088193882.stgit@firesoul>
In-Reply-To: <155489662793.20826.5533583763088193882.stgit@firesoul>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 10 Apr 2019 16:34:29 -0700
Message-ID: <CAPhsuW6K+TVaAuD3e6g7oE9zhpBAVx5u3V4NZJgH9E0qM2_ZDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] net: core: introduce build_skb_around
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 10, 2019 at 6:02 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
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
>                             int node);
>  struct sk_buff *__build_skb(void *data, unsigned int frag_size);
>  struct sk_buff *build_skb(void *data, unsigned int frag_size);
> +struct sk_buff *build_skb_around(struct sk_buff *skb,
> +                                void *data, unsigned int frag_size);
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
> +                                         void *data, unsigned int frag_size)
> +{
> +       struct skb_shared_info *shinfo;
> +       unsigned int size = frag_size ? : ksize(data);
> +
> +       size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +       /* Assumes caller memset cleared SKB */
> +       skb->truesize = SKB_TRUESIZE(size);
> +       refcount_set(&skb->users, 1);
> +       skb->head = data;
> +       skb->data = data;
> +       skb_reset_tail_pointer(skb);
> +       skb->end = skb->tail + size;
> +       skb->mac_header = (typeof(skb->mac_header))~0U;
> +       skb->transport_header = (typeof(skb->transport_header))~0U;
> +
> +       /* make sure we initialize shinfo sequentially */
> +       shinfo = skb_shinfo(skb);
> +       memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> +       atomic_set(&shinfo->dataref, 1);
> +
> +       return skb;
> +}
> +
>  /**
>   * __build_skb - build a network buffer
>   * @data: data buffer provided by caller
> @@ -279,32 +306,15 @@ EXPORT_SYMBOL(__alloc_skb);
>   */
>  struct sk_buff *__build_skb(void *data, unsigned int frag_size)
>  {
> -       struct skb_shared_info *shinfo;
>         struct sk_buff *skb;
> -       unsigned int size = frag_size ? : ksize(data);
>
>         skb = kmem_cache_alloc(skbuff_head_cache, GFP_ATOMIC);
> -       if (!skb)
> +       if (unlikely(!skb))
>                 return NULL;
>
> -       size -= SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -
>         memset(skb, 0, offsetof(struct sk_buff, tail));
> -       skb->truesize = SKB_TRUESIZE(size);
> -       refcount_set(&skb->users, 1);
> -       skb->head = data;
> -       skb->data = data;
> -       skb_reset_tail_pointer(skb);
> -       skb->end = skb->tail + size;
> -       skb->mac_header = (typeof(skb->mac_header))~0U;
> -       skb->transport_header = (typeof(skb->transport_header))~0U;
>
> -       /* make sure we initialize shinfo sequentially */
> -       shinfo = skb_shinfo(skb);
> -       memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
> -       atomic_set(&shinfo->dataref, 1);
> -
> -       return skb;
> +       return __build_skb_around(skb, data, frag_size);
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
> +                                void *data, unsigned int frag_size)
> +{
> +       if (unlikely(!skb))
> +               return NULL;
> +
> +       skb = __build_skb_around(skb, data, frag_size);


> +
> +       if (skb && frag_size) {
> +               skb->head_frag = 1;
> +               if (page_is_pfmemalloc(virt_to_head_page(data)))
> +                       skb->pfmemalloc = 1;
> +       }

I didn't find any explanation of this part (head_frag, pfmemalloc).
Shall we split it out to a separate patch?

Thanks,
Song

> +       return skb;
> +}
> +EXPORT_SYMBOL(build_skb_around);
> +
>  #define NAPI_SKB_CACHE_SIZE    64
>
>  struct napi_alloc_cache {
>
