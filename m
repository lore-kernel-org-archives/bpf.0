Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35769C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 18:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F288B2171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 18:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngTvS5bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDLSCK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:02:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46699 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLSCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 14:02:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id s81so6170681qke.13;
        Fri, 12 Apr 2019 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJQjgDZzcEU9c3L5Qw40w7A5uzDoSPY2UoytCzBIU2A=;
        b=ngTvS5bo/VWEVbHI9GN8NXpfhAVa7Im7wEYO6RIKl86lmejtlWWn+StTSo5yTe3PV2
         jzCUb25NNYtoyjGRcCUxUtiszyvNJuIz7acHrvMgDxeR7XBif87eDsiOh5rbz5EGRDxa
         MFeRogW5/YmMeG0d9Gs7kX5Z5Uc4HRpPhAohjCI4P5fyMK8ftl5sLRBvUVkWtg/JOb5l
         T/8FL6EykXPqxB3ibRSox4dCA/WiBTmuUeksUua5TM/cb/h8oiS3T2eGbgOlfTE8RBKB
         Mv9IU9B80PMudNyzAqLRtc1WZ7VJhC9U8etk5G3OPiHKTV2MSfYv9wAJuIvMDrNgFLqK
         i2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJQjgDZzcEU9c3L5Qw40w7A5uzDoSPY2UoytCzBIU2A=;
        b=D1E3Tw22Nx7yLQJqmGD60DOvjh8uV1EhzLAwUExLiq4Mp/Ks0l20kMBQ+6Z4COu0z3
         q7xgcu4+VB+cUQpkK00GvXma0wSrKEjwQwYcYa/hp/IOqsupmVx9Jwb3PS8IaAy4tHTy
         bB/k0J6npYlsmVKust4KQOcEzSy4ACKzbdZv1FlZt4r5hyR3yyb0Shp7KT0qlKLxKYM5
         qk/oL21JXBeOsFrXyzERBBVDp+9fsR0LGw02Gs5otMuVlDu9GeebNSzK/aaUrLKDTaom
         99cfGjoZEsXI05J0BMYEHCyd5EGTyf3eAgSeETrjn8+ENjcTt2tN8+hxrh3Zjmvxds2x
         Ez5A==
X-Gm-Message-State: APjAAAW+POYICeHpFKDLF25RF5Q7HpNMhh8wFcw9/n1h3nn6/WNoqpK1
        QkINanEs9fXUABCf5TPU0W4aWvVPXhWB3j9UNdUj5xdd
X-Google-Smtp-Source: APXvYqw2F/JZ+i2rNa1HD9M0ENhFdyqkVe4RZo0/u7YyxNib2pcH3ueevtfcLmTQ2bHKG4F1tBQnwZBWFnRD/5Q3OIg=
X-Received: by 2002:a37:8843:: with SMTP id k64mr24481432qkd.8.1555092128948;
 Fri, 12 Apr 2019 11:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <155508158877.23650.13330504000013024259.stgit@firesoul> <155508166300.23650.17848112882333883560.stgit@firesoul>
In-Reply-To: <155508166300.23650.17848112882333883560.stgit@firesoul>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 12 Apr 2019 11:01:57 -0700
Message-ID: <CAPhsuW5=h=EZPDy5tH8U7yy72c2sg7+Odnv=M25nbu2x2_oR7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2 3/4] bpf: cpumap do bulk allocation of SKBs
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
> index 430103e182a0..732d6ced3987 100644
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
> @@ -256,7 +256,9 @@ static int cpu_map_kthread_run(void *data)
>         while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
>                 unsigned int drops = 0, sched = 0;
>                 void *frames[CPUMAP_BATCH];
> -               int i, n;
> +               void *skbs[CPUMAP_BATCH];
> +               gfp_t gfp = __GFP_ZERO | GFP_ATOMIC;
> +               int i, n, m;
>
>                 /* Release CPU reschedule checks */
>                 if (__ptr_ring_empty(rcpu->queue)) {
> @@ -278,14 +280,20 @@ static int cpu_map_kthread_run(void *data)
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
>                 local_bh_disable();
>                 for (i = 0; i < n; i++) {
>                         struct xdp_frame *xdpf = frames[i];
> -                       struct sk_buff *skb;
> +                       struct sk_buff *skb = skbs[i];
>                         int ret;
>
> -                       skb = cpu_map_build_skb(rcpu, xdpf);
> +                       skb = cpu_map_build_skb(rcpu, xdpf, skb);
>                         if (!skb) {
>                                 xdp_return_frame(xdpf);
>                                 continue;
>
