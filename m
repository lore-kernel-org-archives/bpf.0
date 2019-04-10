Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739A2C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A8B20820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8XFlPQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDJXYt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:24:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39038 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfDJXYt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 19:24:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so5004875qte.6;
        Wed, 10 Apr 2019 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kDRoG1DMLA69YMZcnDh3Gnd3PmYIc0sa2kOnRC3X4E=;
        b=n8XFlPQFpswtZZlvBsdvm9pVwckVIpH2p8kW5PMrJzivn4i6pB/zQXY8+Z5JR8p6tv
         XQH6aF6fg+AEzp9uk6nZYlhO4nTvAXrvxQSd/Ot8tD2cC4ODhs0YVCahKNvAlFOecDNu
         UOlz/NCou2GW1vd07mqunYjqjVWIDD44TRGHipsvpUDlgTiFhUKKAlyelHaw68sR5bZL
         F8WyT2Zle65+HPGep73WVELaTG1GCZmK0Wwr2Byk2Hpqm65Weu9ybzOLoIFOh9rBWgkJ
         oKZoLAGJNKrkrBd5RA4yMHoSC4sREDXLl9ePqqBD7FS2Dn0jiH2wRP9GPVl5RH9HONas
         whoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kDRoG1DMLA69YMZcnDh3Gnd3PmYIc0sa2kOnRC3X4E=;
        b=dB2yLhugNdXZZZMx/FjddpguQ33DRcct1nB2auiTLgwOw90H5Ebu9wjyqpwdrNFR3J
         Eok1OIh+s0khrpxNUrLZZoiWCCcCbouS8CO2YEZYI85XDGYIDHdnRlt/9iKghTVkfBnE
         cSnIlZkv2djMJzW5d9TXlQlJGBs1624FORTb+tn6c9LPdf2S+jm2N46oCJiIz+/GuA8d
         74xGz+J24JWvw2Ik802jGy5NwBuQv/aWj8dglXmWj2gmN8K+p6oeUTeaBfRg0AxcjYvv
         TDCGw1e62jaVQIxbZskiWaSG0yFMovZMbA1BWmauAijLnr0Ff8VykNBstREy5zidv9h0
         u+6A==
X-Gm-Message-State: APjAAAXlVIavhda15GPM5w9XiWDjc7oK6doHeno89Vuu+jgHfowYoFAx
        Fp4spkl10RZ1FVv/NMCQranYI2bn721++ywxHs0=
X-Google-Smtp-Source: APXvYqyzE1KsVJ4uxhWDyVKFP1YDOajlEH82X8SAkDOUvnALgaplhwYNlAdb/tLExqAQDvdtPOK9F7gJhPauy0LexKk=
X-Received: by 2002:a0c:8b4a:: with SMTP id d10mr37306635qvc.29.1554938688433;
 Wed, 10 Apr 2019 16:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <155489659290.20826.1108770347511292618.stgit@firesoul> <155489661778.20826.7424374812567038804.stgit@firesoul>
In-Reply-To: <155489661778.20826.7424374812567038804.stgit@firesoul>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 10 Apr 2019 16:24:37 -0700
Message-ID: <CAPhsuW5FQ_npvmCUSfDKUXFj_vXF4OVk34EKqHJXZtu5eYwF2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: cpumap use ptr_ring_consume_batched
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

On Wed, Apr 10, 2019 at 6:03 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> Move ptr_ring dequeue outside loop, that allocate SKBs and calls network
> stack, as these operations that can take some time. The ptr_ring is a
> communication channel between CPUs, where we want to reduce/limit any
> cacheline bouncing.
>
> Do a concentrated bulk dequeue via ptr_ring_consume_batched, to shorten the
> period and times the remote cacheline in ptr_ring is read
>
> Batch size 8 is both to (1) limit BH-disable period, and (2) consume one
> cacheline on 64-bit archs. After reducing the BH-disable section further
> then we can consider changing this, while still thinking about L1 cacheline
> size being active.
>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/bpf/cpumap.c |   21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 3c18260403dd..430103e182a0 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -240,6 +240,8 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
>         }
>  }
>
> +#define CPUMAP_BATCH 8
> +
>  static int cpu_map_kthread_run(void *data)
>  {
>         struct bpf_cpu_map_entry *rcpu = data;
> @@ -252,8 +254,9 @@ static int cpu_map_kthread_run(void *data)
>          * kthread_stop signal until queue is empty.
>          */
>         while (!kthread_should_stop() || !__ptr_ring_empty(rcpu->queue)) {
> -               unsigned int processed = 0, drops = 0, sched = 0;
> -               struct xdp_frame *xdpf;
> +               unsigned int drops = 0, sched = 0;
> +               void *frames[CPUMAP_BATCH];
> +               int i, n;
>
>                 /* Release CPU reschedule checks */
>                 if (__ptr_ring_empty(rcpu->queue)) {
> @@ -269,14 +272,16 @@ static int cpu_map_kthread_run(void *data)
>                         sched = cond_resched();
>                 }
>
> -               /* Process packets in rcpu->queue */
> -               local_bh_disable();
>                 /*
>                  * The bpf_cpu_map_entry is single consumer, with this
>                  * kthread CPU pinned. Lockless access to ptr_ring
>                  * consume side valid as no-resize allowed of queue.
>                  */
> -               while ((xdpf = __ptr_ring_consume(rcpu->queue))) {
> +               n = ptr_ring_consume_batched(rcpu->queue, frames, CPUMAP_BATCH);
> +
> +               local_bh_disable();
> +               for (i = 0; i < n; i++) {
> +                       struct xdp_frame *xdpf = frames[i];
>                         struct sk_buff *skb;
>                         int ret;
>
> @@ -290,13 +295,9 @@ static int cpu_map_kthread_run(void *data)
>                         ret = netif_receive_skb_core(skb);
>                         if (ret == NET_RX_DROP)
>                                 drops++;
> -
> -                       /* Limit BH-disable period */
> -                       if (++processed == 8)
> -                               break;
>                 }
>                 /* Feedback loop via tracepoint */
> -               trace_xdp_cpumap_kthread(rcpu->map_id, processed, drops, sched);
> +               trace_xdp_cpumap_kthread(rcpu->map_id, n, drops, sched);

btw: can we do the tracepoint after local_bh_enable()?

>
>                 local_bh_enable(); /* resched point, may call do_softirq() */
>         }
>
