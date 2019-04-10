Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4DFC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5920645
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnEcXBDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfDJXf5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:35:57 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39217 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJXf5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 19:35:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id t28so5028396qte.6;
        Wed, 10 Apr 2019 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=faRoTWXTwAOcYwKIdR7r8dP6zM+XzJOozxeAX/KQy6w=;
        b=YnEcXBDFAHdAK9TBWHhYxphJhN1cLYpwu8lJAUxYAdowBN/ubBLmTF+CSZiQSpwAmX
         4pmFvC5GIq3mB2BvR1GcQEpqeq8w/Z47Hr6IdgsbSyap2AkkbSiQSExmQJSNoK+a1jNm
         qbOOvICCl+nWFFKwANyVgSLvKfUsgU0OKmp/FZkKHHgMTVmY/M7jqKA98o3mMzgdn9PW
         ZdBfLoHjDq9glMmimgc0dDvLF3iFrRhHFHiAirtUr3q99ldz+D/yuN7Dw5fD/9eeXB9k
         3hRSsUvXL2gvPIUR4OasDwMhqi9qAN9tMg3jGfLyWQehGkMtNwqVqfcBuxdRm6fdoV9X
         HWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=faRoTWXTwAOcYwKIdR7r8dP6zM+XzJOozxeAX/KQy6w=;
        b=qbtuTx5yHeHjY7S5BIQCMZQQ3V3Kl9oo1dE5I0e+5w279QijAFJzIpUh2DcfIkeB83
         5qBld+ws0DLydN7i5n1joe+dugm/et+myzMN7Qjk5Ljya+aXwMkP6mgmZ29cG10ot9HP
         P65kB6oJUHGWqQn/MqNfVn7597VtAjuxcUFYWJ2PuRX8LsPsxIv86QAzR/2cqmBYKZB8
         mADQme0xUT31NZjepBzmoZ10bqkxqUafZC57DdZTlfdS8bz3pG2iLQ4fkzWCZFvg7gaP
         YyTYFE9Yk2RikXkkIsYEggq0G3nsDGhnAPec+ra548L8SuEiHQLLXJqq2N2f7VbRMCAU
         nxZA==
X-Gm-Message-State: APjAAAXL03oEz3QET2g4LelZkSwzpdC5ZArPYmKg9Q2dOcv67LzJ4zvY
        Ev3miOWfHJ3xmdEl80eTtDQ8MY0Mqin5TdSQKwQU9+e+
X-Google-Smtp-Source: APXvYqzYm7ai10yJeGshXVuKI7Mtkd1TkwCgUmyntMgpJRR9Je3XTfYeko9fjK+DHQQtTD3K9jw24hSGMwXes4nsl6s=
X-Received: by 2002:a0c:ae04:: with SMTP id y4mr39018218qvc.49.1554939356684;
 Wed, 10 Apr 2019 16:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <155489659290.20826.1108770347511292618.stgit@firesoul> <155489663807.20826.15883373865371166146.stgit@firesoul>
In-Reply-To: <155489663807.20826.15883373865371166146.stgit@firesoul>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 10 Apr 2019 16:35:45 -0700
Message-ID: <CAPhsuW7Gbrsh0WKPWB1GPue_gKFnuT-byoSYYx3-qXfcvpDPYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] bpf: cpumap memory prefetchw optimizations
 for struct page
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
> A lot of the performance gain comes from this patch.
>
> While analysing performance overhead it was found that the largest CPU
> stalls were caused when touching the struct page area. It is first read with
> a READ_ONCE from build_skb_around via page_is_pfmemalloc(), and when freed
> written by page_frag_free() call.
>
> Measurements show that the prefetchw (W) variant operation is needed to
> achieve the performance gain. We believe this optimization it two fold,
> first the W-variant saves one step in the cache-coherency protocol, and
> second it helps us to avoid the non-temporal prefetch HW optimizations and
> bring this into all cache-levels. It might be worth investigating if
> prefetch into L2 will have the same benefit.
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
>  kernel/bpf/cpumap.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index b82a11556ad5..4758482ab5b9 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -281,6 +281,18 @@ static int cpu_map_kthread_run(void *data)
>                  * consume side valid as no-resize allowed of queue.
>                  */
>                 n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
> +
> +               for (i = 0; i < n; i++) {
> +                       void *f = frames[i];
> +                       struct page *page = virt_to_page(f);
> +
> +                       /* Bring struct page memory area to curr CPU. Read by
> +                        * build_skb_around via page_is_pfmemalloc(), and when
> +                        * freed written by page_frag_free call.
> +                        */
> +                       prefetchw(page);
> +               }
> +
>                 m = kmem_cache_alloc_bulk(skbuff_head_cache, gfp, n, skbs);
>                 if (unlikely(m == 0)) {
>                         for (i = 0; i < n; i++)
>
