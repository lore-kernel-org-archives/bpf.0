Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F70C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 17:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98A12171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 17:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwMqGRTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDLR7z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:59:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36626 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLR7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 13:59:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so12271913qtn.3;
        Fri, 12 Apr 2019 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBBmLugIejK5W5ybl8eT9LTZVgBCLsVSS84mATdFS3Y=;
        b=AwMqGRTsYl0sb1CsAqAk+IrvX/S6vCl0OELlUzO9pxXJn3Nh0bXpIx6L5luze3W+aj
         rn8b/hnN5aGrxqvBhzq1l5mfO696groP9JJGqfM1/hJCumAJYWuHURvNOWbKnwuGcyiZ
         ILKKRBUu1BRcQivcGJwOpJlvjCONq5KVg+VN0J9rDnsnEvQKgfXuW5f4dEAmAZtRNsXa
         irlJUEZC7qX4e65zNaDwU8OohcQYCS+y9ju+Y/+3yPnjpQxJeLwc5q1t0tCBq57Xbde/
         dzbmcsGnJVQjuzN5Tca5uwaxfCOn74zBtJ1IKrYjkv41jbN2ZpLuyHoXp7PTkny1JkuW
         UL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBBmLugIejK5W5ybl8eT9LTZVgBCLsVSS84mATdFS3Y=;
        b=ZoU2iyPgH9ieAkbVc7suTBY4yf5xMprimFwSTIp1Vfdf/dadlxQYjakgs2o0QUpNhJ
         ebZxZbyarS0E6Ae/4nlEwel9XMg/qi8zty4S1ygdMMWLLSge0v0HxklrTGXCt7e01ITB
         Z4kjULVGEQZ/sJfpcP+GZ/hXbzV6WCDf6Y76jC4vp4X5DrMxab4kUEkTuSA2uVnNJGnB
         XkrgpqPsmPmnPFGMrZnvZDeg6BxyMMHyQjuWjXDBpd2HeoQo12cTMaVkF1tEqX5lbiTF
         SMMUkAY9rZKCZ1PtiH2iF3kmHmtK1kkXU9CYopCBHZ7l/OE7r2z1RCoRTk8qNCRVX0IY
         sBxQ==
X-Gm-Message-State: APjAAAVKkEHIIGc8Eh9qAjEYbll51msXhRaanDHcqn43Xdh+VTvXEHCJ
        zMknNGHt/qd4+Etdgq6hRzgyL7OKmNZilR3Isvg=
X-Google-Smtp-Source: APXvYqwbcGi9asmRXCNygrrJEtsTeC0Rf/A1JnFUZ4VF7i08XFabWRyz0ZHKU9aneVa6SIJ2NTkfqUngAZfKFl8SAKA=
X-Received: by 2002:ac8:30a1:: with SMTP id v30mr48477355qta.176.1555091994146;
 Fri, 12 Apr 2019 10:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <155508158877.23650.13330504000013024259.stgit@firesoul> <155508165793.23650.5590462213777770722.stgit@firesoul>
In-Reply-To: <155508165793.23650.5590462213777770722.stgit@firesoul>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 12 Apr 2019 10:59:43 -0700
Message-ID: <CAPhsuW4EBPEE4BhU=ALFC=UDwgx3rVCdVid9ZrESB5uwo-y9UA@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2 2/4] net: core: introduce build_skb_around
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <songliubraving@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Edward Cree <ecree@solarflare.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 12, 2019 at 8:08 AM Jesper Dangaard Brouer
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

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  include/linux/skbuff.h |    2 +
>  net/core/skbuff.c      |   71 +++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 54 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index a06275a618f0..e81f2b0e8a83 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1042,6 +1042,8 @@ struct sk_buff *__alloc_skb(unsigned int size, gfp_t priority, int flags,
>                             int node);
>  struct sk_buff *__build_skb(void *data, unsigned int frag_size);
>  struct sk_buff *build_skb(void *data, unsigned int frag_size);
> +struct sk_buff *build_skb_around(struct sk_buff *skb,
> +                                void *data, unsigned int frag_size);
>
>  /**
>   * alloc_skb - allocate a network buffer
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 9901f5322852..087622298d77 100644
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
> +       return skb;
> +}
> +EXPORT_SYMBOL(build_skb_around);
> +
>  #define NAPI_SKB_CACHE_SIZE    64
>
>  struct napi_alloc_cache {
>
