Return-Path: <SRS0=qXn4=SU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DC9C282DA
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 02:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ABB217FA
	for <bpf@archiver.kernel.org>; Thu, 18 Apr 2019 02:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k59UF07p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfDRCPT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 17 Apr 2019 22:15:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43957 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfDRCPS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Apr 2019 22:15:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id i68so331690lfi.10;
        Wed, 17 Apr 2019 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63s617pSPWRRkDCNaIurLx+/R20W9dJaEb8O1JfVitQ=;
        b=k59UF07pi0yebdcHl5iEV4GJNlPihA3l3sNf6B/sY4+dF6vYtF0hsmYU+qwdVZ7jU5
         ZCew2c8JhrkEBASii/yxq+cJnzQWIy1s75/huOG5+Rx1x2xGpoIiHOWAWIWSWVM1ipxL
         icbJ1n12d/5EVnD1o5MMVAtE+RpPsA4HMTGteziLk/91CzUlOBjMSzNOvq1aUc3Qdanl
         IJEyCeQhEFsdOfryJO3z/FlBi50Fxd1F0mLr3VXX76KCqHzq4dLXc/igvFB66+3Qd24/
         zZ4LSqRcHAiZsansrDrBGyuCVDeSwORrxsNrgAkbvHOYznepLEX5jZ+hFFR0/fstxvKN
         GMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63s617pSPWRRkDCNaIurLx+/R20W9dJaEb8O1JfVitQ=;
        b=MCiayrqlesSqv/0am9TT6z4QGFpBlaHCGlSck+oaH4lRtwYx2VXVnxJTsXqCCAtIzQ
         z/kYdch+Tf2JYv/U2ZIKOf8CjtbGSAtqxjpA+7+6MyV6ZWJN1Cegu0XU7nlWfPZQgSA6
         2RVUuPmCW8+oCvWgSwI8Gdeb5OSuKMxXST4U924mjXRnqackLRJAqetzh96+86B+ZFal
         S7fBZjkRKLbgAbE2Wqe5BLA3lkW+LZftoHcO8yf6U8mhLguNKmcjAVR+wzwuMzVxFrL5
         SGoPJZuwdlKjp6Knlz/LPlRUGgDEpgjKTsS54BkrejUFAyt5CS1k+fh5ZpTHZge7oILg
         dJFQ==
X-Gm-Message-State: APjAAAXV498CwbPL8Cxfx4baiBFGvKuw+7TX8J+IAR2GjLdr52B2GqNj
        J6sb9Yf2v6C19I7sBuUDs7U4OatnHh9q10Y1t9s=
X-Google-Smtp-Source: APXvYqyChIflRTTZqY4lGt7KMFyjDj4c6dXnT1ucTz93OkJsdXdADOHeLuM6sD/vYzpQbAe8/auYuDQ0e3IvIVIg3Bc=
X-Received: by 2002:ac2:52a8:: with SMTP id r8mr1726471lfm.160.1555553716415;
 Wed, 17 Apr 2019 19:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <155508158877.23650.13330504000013024259.stgit@firesoul>
In-Reply-To: <155508158877.23650.13330504000013024259.stgit@firesoul>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 Apr 2019 19:15:04 -0700
Message-ID: <CAADnVQLig51jQ1z8Epfmzsjh5tT4xQELewmqyJ1e=bwWObO39g@mail.gmail.com>
Subject: Re: [PATCH bpf-next V2 0/4] Bulk optimization for XDP cpumap redirect
To:     Jesper Dangaard Brouer <brouer@redhat.com>
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
> This patchset utilize a number of different kernel bulk APIs for optimizing
> the performance for the XDP cpumap redirect feature.
>
> Benchmark details are available here:
>  https://github.com/xdp-project/xdp-project/blob/master/areas/cpumap/cpumap03-optimizations.org
>
> Performance measurements can be considered micro benchmarks, as they measure
> dropping packets at different stages in the network stack.
> Summary based on above:
>
> Baseline benchmarks
> - baseline-redirect: UdpNoPorts: 3,180,074
> - baseline-redirect: iptables-raw drop: 6,193,534
>
> Patch1: bpf: cpumap use ptr_ring_consume_batched
> - redirect: UdpNoPorts: 3,327,729
> - redirect: iptables-raw drop: 6,321,540
>
> Patch2: net: core: introduce build_skb_around
> - redirect: UdpNoPorts: 3,221,303
> - redirect: iptables-raw drop: 6,320,066
>
> Patch3: bpf: cpumap do bulk allocation of SKBs
> - redirect: UdpNoPorts: 3,290,563
> - redirect: iptables-raw drop: 6,650,112
>
> Patch4: bpf: cpumap memory prefetchw optimizations for struct page
> - redirect: UdpNoPorts: 3,520,250
> - redirect: iptables-raw drop: 7,649,604
>
> In this V2 submission I have chosen drop the SKB-list patch using
> netif_receive_skb_list() as it was not showing a performance improvement for
> these micro benchmarks.

Applied. Thanks!
