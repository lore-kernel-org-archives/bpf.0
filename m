Return-Path: <SRS0=eni5=ST=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB05DC10F14
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 03:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CD92177B
	for <bpf@archiver.kernel.org>; Wed, 17 Apr 2019 03:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHMHpeyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfDQDBx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:01:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41458 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfDQDBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 23:01:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id t30so17611824lfd.8;
        Tue, 16 Apr 2019 20:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHNFiDibRqLM/79eOdwueoxi3F3ytPMKsxRShVPW7nM=;
        b=AHMHpeyiUr1qVA4j+U6baLHWBPxf8ZNed+MS1bJLUgx6H5S6fU0zt2r4xWT6qGrfFE
         J6b9I0w8RLzAkSsg6rhD+RIM5fr05blfgfzoNAJx9Gtwc1aLraiZWzxQpzhahRINYqxY
         mZAyOyzLpmAaclZGQm/HFpBbtTNMU+B8MT6ppsdwnbjGcoKOnVyBfKgS3xN6ZVTOqAyt
         9ch5uysuLnqyZN7UNVj/VqLsd/E6FLGm/GlTNcpK7dKymNePofWfrJr2tsmlrx0DEkxC
         ut4RdN+vWHtxf0ur9R/Nt3MlmT0JGcFRw+7ivNj01YqTdQ64ENdSXp16xHNZji8flpAo
         vVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHNFiDibRqLM/79eOdwueoxi3F3ytPMKsxRShVPW7nM=;
        b=nk1a2ZT5oVj96YwiuHm9lNwvhuDSCzjxm3LWDlm0SjSDQIwv11v4/RtVSHiggrV4Hz
         DbJir2Ogy9VpW6LEA3d7TWmwpJcsih1++3qV0bjdcVUxaXNg10YRZbHs5BxdZbxUVFnr
         x4/tjwNF91LI5qa78i8/3zjoA5MSxUXLsMevgV9eVX4WeyYh6iQzL7izoFPZPk4Ng2n8
         N3Ft7LumkKlk6klCZocn70c+8wT2o2wLOBHwvI7PUYI65NifSd8PIgQ2osfpAkffxLCS
         eMzNPUbCjINv9YoFu8d+xbSi831Zv37DadbhjvUnESYzBSFIekhSyAIA7mZCr2XJYpeJ
         aG2Q==
X-Gm-Message-State: APjAAAXRr52l0fpaGbOh6AORv89N+ZarUcxmCcMxoOMUVSbSG7aPqDdw
        nSe6d7ULTwFlDVzpaNaV412KixqJu0FhnM5PCII=
X-Google-Smtp-Source: APXvYqwaEcc7Q1fDYe5+RMv1q+/3iUSIlv/zum4Heh86r7WjRYGewfr3KvJoZe/jTfs4D/9YThurhV1FjC1zdDyOxSE=
X-Received: by 2002:a19:428c:: with SMTP id p134mr842175lfa.108.1555470109706;
 Tue, 16 Apr 2019 20:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <155508158877.23650.13330504000013024259.stgit@firesoul> <155508165793.23650.5590462213777770722.stgit@firesoul>
In-Reply-To: <155508165793.23650.5590462213777770722.stgit@firesoul>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 16 Apr 2019 20:01:38 -0700
Message-ID: <CAADnVQ+cCKsszq3YZt_f6o+HfpsQEcY1J3yJmkDzm9Pvb2+PLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2 2/4] net: core: introduce build_skb_around
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
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

On Fri, Apr 12, 2019 at 8:07 AM Jesper Dangaard Brouer
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

It looks good to me, but I'd like to see Eric's Ack before applying.
