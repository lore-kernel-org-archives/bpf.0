Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15341C433B4
	for <bpf@archiver.kernel.org>; Wed, 14 Apr 2021 07:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6940613C7
	for <bpf@archiver.kernel.org>; Wed, 14 Apr 2021 07:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348303AbhDNHAi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Apr 2021 03:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbhDNHA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 03:00:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6118EC06138E;
        Wed, 14 Apr 2021 00:00:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a12so13091856pfc.7;
        Wed, 14 Apr 2021 00:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDBUPYbKf2t3lcczgmI7wZUsX5rnHt3nwJj9heOoJQU=;
        b=nNvVEzl4iQ3HZ+P/jZHrI3IT7OZXAptb1p9duwdro9GBkx5g24beXma628G2N3piD4
         KFLfN2AaY+qpD8dkgw2M+rRiBNZf5TQDxMwRiGWWgh/m/UulYGEkvUpANnZa0FS6TVl0
         kZdZwJhCylmOMa3ceDPHkJeH3lcT1KM7rhNcin8/JQl8UzMMjW8SAn39CAq6KKtd/VCy
         vpRq0jdHIkiqbAhvlLBkJQleZW7l3i5KNrpvDdt163UCcZ0SeYHbV4cyJt9JcDuGuHSx
         RbnSrLhoX64lZ3hXSDPyk3Wouovt44oOY54qvAeXL+Du0kh8tt8UiMzipvxUgfr3phZO
         nxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDBUPYbKf2t3lcczgmI7wZUsX5rnHt3nwJj9heOoJQU=;
        b=FVJjPTQlh+H8giNGPuqV0rrStkm55ZqnU5L72WbYOQyxAUMD1A5RY0yvbuoCXhksFH
         BCCt39j6UIuJeNNCLFQ0LjEp6iqTjhkGyf7P6jH1Ac387gXOa/LPdw35dX0wtOSKiucM
         odW9ODk8aopxf45FPD0ApkdjPK6tRSMjOU0kd10Kj6V1rSIFG9FiEKVV0/8yLfz5fPjs
         yJnjsQ7NT0N21u3dnAKxdWyj9CmIehJnwT5GSdrMR0AwXE+jIzFaBWw64fO3mPoypZcF
         EMzsJma0xrPfTQrYoVl2EsbDYpwqvDS6F0spzHVPxcaw0bD4jzCVl5+7akfIPVthh8i+
         szKg==
X-Gm-Message-State: AOAM533nSvPeGEOtVpyN+EeKh7ISQ3ta1RCOC8oW8IQbYMOJv0OM7jl5
        Mmubiqg5IgJgS0YQcZhf6Jps3DRQEsXN5RFExvw=
X-Google-Smtp-Source: ABdhPJwuv7SdpC58vm4KSJfizii71ErudW5n3xVgTA49pgNVuwuBRelYvJLLt3E0pfQMhW7W9g4Jdi//gXBePEPW6kk=
X-Received: by 2002:aa7:8428:0:b029:250:1323:2d05 with SMTP id
 q8-20020aa784280000b029025013232d05mr7916916pfn.12.1618383600931; Wed, 14 Apr
 2021 00:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210413031523.73507-1-xuanzhuo@linux.alibaba.com> <20210413031523.73507-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210413031523.73507-5-xuanzhuo@linux.alibaba.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Wed, 14 Apr 2021 08:59:50 +0200
Message-ID: <CAJ8uoz1v2zjORdOqXc+zE50XLvfJnMWw0XuhKShcdPwB9GFtCg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 04/10] xsk: support get page by addr
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org,
        bpf <bpf@vger.kernel.org>,
        "dust . li" <dust.li@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 9:58 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> xsk adds an interface and returns the page corresponding to
> data. virtio-net does not initialize dma, so it needs page to construct
> scatterlist to pass to vring.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> ---
>  include/net/xdp_sock_drv.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 4e295541e396..1d08b5d8d15f 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -72,6 +72,12 @@ static inline dma_addr_t xsk_buff_xdp_get_frame_dma(struct xdp_buff *xdp)
>         return xp_get_frame_dma(xskb);
>  }
>
> +static inline struct page *xsk_buff_xdp_get_page(struct xsk_buff_pool *pool, u64 addr)
> +{
> +       addr = pool->unaligned ? xp_unaligned_add_offset_to_addr(addr) : addr;
> +       return pool->umem->pgs[addr >> PAGE_SHIFT];
> +}
> +
>  static inline struct xdp_buff *xsk_buff_alloc(struct xsk_buff_pool *pool)
>  {
>         return xp_alloc(pool);
> @@ -207,6 +213,11 @@ static inline dma_addr_t xsk_buff_xdp_get_frame_dma(struct xdp_buff *xdp)
>         return 0;
>  }
>
> +static inline struct page *xsk_buff_xdp_get_page(struct xsk_buff_pool *pool, u64 addr)
> +{
> +       return NULL;
> +}
> +
>  static inline struct xdp_buff *xsk_buff_alloc(struct xsk_buff_pool *pool)
>  {
>         return NULL;
> --
> 2.31.0
>
