Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7FFC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A74E20645
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 23:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt5pFLhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDJXgw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:36:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44291 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfDJXgw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 19:36:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id w5so4988404qtb.11;
        Wed, 10 Apr 2019 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SVdcVduo9kvgnkUhEKBrFhdoHeKl8LvApppmCdT6RA=;
        b=Vt5pFLhOqkWxwdFChtfx7ffQ4/+AATTEv4LHdx62qNewrHLjCXpQ+s0dM24dgjGXOY
         m4oIzd8Ruxed/UBnVV0OJEtjLL4Sa+oWmGcZIahn6plrFki5hciHSQh/2CwYzWw5Teel
         LgR9iRa5U1QpndQVjv2FfWuQTUnGTpknK2EgnudINSCO5czOFnEiQSV34NV9LuaPR/o8
         3Mdy/RMJvODO3w9Qd53DrV23biZ+h6vx2QRF8Vn88mypnc2bDvpRAs0deRc9SKzQhat7
         Wgmt54NMlcJB0jaFDuKXc3jVeM5VgarE0d0yYVnUcy44Jl5S6Edr2ZaUNCP1+P62vITs
         7OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SVdcVduo9kvgnkUhEKBrFhdoHeKl8LvApppmCdT6RA=;
        b=OaCzxJZoBQz8oK7Aedbb8rSJfgmAECE1RwcdWBOC3xAo0MXdXivgk+xhwdwRJKO5rZ
         z2qKptVt5ubbqRc3Hvy5NhKqXB8TgTUs54yPnRTANKowfBj7ZNf0AQPT1n4S/wJISRV7
         39KVgisIB0z6rj2XWB9tIkrsgR0I5FAq5Rs/RFPuIwu/hd8ps4K/GTSLVy69P6uZBApZ
         jse6hoM67akYavIWGSHWT6tvtgjmTrOEnjiuGr5ihk8jAmHNHhC/N/UsVSmO67UDDIfn
         3o8MQ97oPtx1IG7gtRc+9NICQ9iRpJESftYsOK42Hhn6gp7A9hVO6YeqC7Z52o0jhxYc
         GAaw==
X-Gm-Message-State: APjAAAUQB4ouHOfcYOD0n4WywYqjl/FSEbQtjRqQGLPX1Wc9zd2t8kZ7
        orojCyY0025/Q6xuLRabPItmkw6jO25xF3oBFDQ=
X-Google-Smtp-Source: APXvYqypBl/LbXNPtc3wRIQ5Kq8Iq+Via39iQZLL/eXoqUCRzgW5d86hPgnHbcZlxLuPVscuddL9RoVVIJqjxfHL8gk=
X-Received: by 2002:aed:35b0:: with SMTP id c45mr38426452qte.144.1554939411785;
 Wed, 10 Apr 2019 16:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
In-Reply-To: <155489659290.20826.1108770347511292618.stgit@firesoul>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 10 Apr 2019 16:36:40 -0700
Message-ID: <CAPhsuW7yYqJwsrk2s5EaZOjhhxa5B0374vJGR4+BBKmh8UCQWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Bulk optimization for XDP cpumap redirect
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

On Wed, Apr 10, 2019 at 6:00 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> This patchset utilize a number of different kernel bulk APIs for optimizing
> the performance for the XDP cpumap redirect feature.

Could you please share some numbers about the optimization?

Thanks,
Song

>
> Patch-1: ptr_ring batch consume
> Patch-2: Send SKB-lists to network stack
> Patch-3: Introduce SKB helper to alloc SKB outside net-core
> Patch-4: kmem_cache bulk alloc of SKBs
> Patch-5: Prefetch struct page to solve CPU stall
>
> ---
>
> Jesper Dangaard Brouer (5):
>       bpf: cpumap use ptr_ring_consume_batched
>       bpf: cpumap use netif_receive_skb_list
>       net: core: introduce build_skb_around
>       bpf: cpumap do bulk allocation of SKBs
>       bpf: cpumap memory prefetchw optimizations for struct page
>
>
>  include/linux/netdevice.h |    1 +
>  include/linux/skbuff.h    |    2 +
>  kernel/bpf/cpumap.c       |   66 +++++++++++++++++++++++++++++-------------
>  net/core/dev.c            |   18 +++++++++++
>  net/core/skbuff.c         |   71 +++++++++++++++++++++++++++++++++------------
>  5 files changed, 118 insertions(+), 40 deletions(-)
>
> --
