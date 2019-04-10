Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE47C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FF020850
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da9IF6EL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfDJXaO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:30:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34534 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJXaO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 19:30:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id k2so5068125qtm.1;
        Wed, 10 Apr 2019 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGVEKVS3aOuGjiOBvj0E5UKu83/QrOxk2weTIBMNNGk=;
        b=Da9IF6ELlhE8giza8uQ4sMv1WvuUErO32ocamgyb2QH6IuBhA0aZmb2uqrXN7L03SV
         fX9m/lHC7+FZ4RKvN2uGGsNOCe8L3NrUPZIt+wexlO/Paz23ep0OrJl5YrnOLlTnTrJU
         tV+sYVOHk1KJGX0cOG7yf9V++cBqrrgkLpnjuYLQOnMyKod1eBPAX+x0c/4/f0IDD/xZ
         q/OW0DxcVYXbQaczlsl6N5c5uHGnxgLwC8O9dQ7GO3DaOcue4rFewbKH76VrezmBHtYr
         BpcogpeNZqo/vIlU8HUmVhS9jmd/t8WunnYPR95UBBfaTdNW151QkSDGzIgiQFD8H4BA
         44pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGVEKVS3aOuGjiOBvj0E5UKu83/QrOxk2weTIBMNNGk=;
        b=FKXqa1j2Sio2b9AyiYCuDWArXy0Xi92sFEMydMXh6dBakFmSoX/grGrCOpIZII+Njb
         ijJo6Mr3hGQJEbJNz+IeoCsjozxMUlM/+puZE0/jzMgW+FscwHr61WH8H4js56jHuqDr
         /9In1n6JYdE5vT8V8zeClymVtxv+yoVQNJ4l3jyhRl3McdOH2xLtK5btxKSg1gRaVuo2
         OVXGiU5CnSU2Z2sEq2tQ4WuiLQMhhxriiwru8CdbFvakJXN9aTOEr6VWMJN3XZJuusMk
         SUh1/fuvno+MmSlZj56Z7HDG+9DwpMVAew4hrUmjO3F11Hu5O8iUy96SkCZVjr2/WC03
         RMlQ==
X-Gm-Message-State: APjAAAUoBl3AsmfG84mIM+7fMeWBC3B0rf6r2jkuSV5KpZcSp/WFpXGX
        bcynxtM/s9qGLIK/ElTBHoGB9xNhy9C3eIeeVtQ=
X-Google-Smtp-Source: APXvYqwSK45XBWefKOMlrmPmPY5L5igfAMMDsQQOBEJQhydqMvNhOey7cWuH6gXeWieottoyyv7calZwpEQw8s3N8cA=
X-Received: by 2002:aed:3ba9:: with SMTP id r38mr40330517qte.135.1554939013105;
 Wed, 10 Apr 2019 16:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <155489659290.20826.1108770347511292618.stgit@firesoul> <155489663300.20826.4588027365135744445.stgit@firesoul>
In-Reply-To: <155489663300.20826.4588027365135744445.stgit@firesoul>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 10 Apr 2019 16:30:01 -0700
Message-ID: <CAPhsuW6FLsPeKT=3puVyCnuKGPRq5SntrM4nHELyfNvEfuQtLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: cpumap do bulk allocation of SKBs
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
> As cpumap now batch consume xdp_frame's from the ptr_ring, it knows how many
> SKBs it need to allocate. Thus, lets bulk allocate these SKBs via
> kmem_cache_alloc_bulk() API, and use the previously introduced function
> build_skb_around().
>
> Notice that the flag __GFP_ZERO asks the slab/slub allocator to clear the
> memory for us. This does clear a larger area than needed, but my micro
> benchmarks on Intel CPUs show that this is slightly faster due to being a
> cacheline aligned area is cleared for the SKBs. (For SLUB allocator, there
> is a future optimization potential, because SKBs will with high probability
> originate from same page. If we can find/identify continuous memory areas
> then the Intel CPU memset rep stos will have a real performance gain.)
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/bpf/cpumap.c |   22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index cb93df200cd0..b82a11556ad5 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -160,12 +160,12 @@ static void cpu_map_kthread_stop(struct work_struct *work)
>  }
>
>  static struct sk_buff *cpu_map_build_skb(struct bpf_cpu_map_entry *rcpu,
> -                                        struct xdp_frame *xdpf)
> +                                        struct xdp_frame *xdpf,
> +                                        struct sk_buff *skb)
>  {
>         unsigned int hard_start_headroom;
>         unsigned int frame_size;
>         void *pkt_data_start;
> -       struct sk_buff *skb;
>
>         /* Part of headroom was reserved to xdpf */
>         hard_start_headroom = sizeof(struct xdp_frame) +  xdpf->headroom;
> @@ -191,8 +191,8 @@ static struct sk_buff *cpu_map_build_skb(struct bpf_cpu_map_entry *rcpu,
>                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
>         pkt_data_start = xdpf->data - hard_start_headroom;
> -       skb = build_skb(pkt_data_start, frame_size);
> -       if (!skb)
> +       skb = build_skb_around(skb, pkt_data_start, frame_size);
> +       if (unlikely(!skb))
>                 return NULL;
>
>         skb_reserve(skb, hard_start_headroom);
> @@ -256,8 +256,10 @@ static int cpu_map_kthread_run(void *data)
>         while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
>                 unsigned int drops = 0, sched = 0;
>                 void *frames[CPUMAP_BATCH];
> +               void *skbs[CPUMAP_BATCH];
>                 struct list_head skb_list;
> -               int i, n;
> +               gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
> +               int i, n, m;
>
>                 /* Release CPU reschedule checks */
>                 if (__ptr_ring_empty(rcpu->queue)) {
> @@ -279,14 +281,20 @@ static int cpu_map_kthread_run(void *data)
>                  * consume side valid as no-resize allowed of queue.
>                  */
>                 n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
> +               m = kmem_cache_alloc_bulk(skbuff_head_cache, gfp, n, skbs);
> +               if (unlikely(m == 0)) {
> +                       for (i = 0; i < n; i++)
> +                               skbs[i] = NULL; /* effect: xdp_return_frame */
> +                       drops = n;
> +               }
>
>                 INIT_LIST_HEAD(&skb_list);
>
>                 for (i = 0; i < n; i++) {
>                         struct xdp_frame *xdpf = frames[i];
> -                       struct sk_buff *skb;
> +                       struct sk_buff *skb = skbs[i];
>
> -                       skb = cpu_map_build_skb(rcpu, xdpf);
> +                       skb = cpu_map_build_skb(rcpu, xdpf, skb);
>                         if (!skb) {
>                                 xdp_return_frame(xdpf);
>                                 continue;
>
