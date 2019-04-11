Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A916FC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E96A2146F
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 17:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdccQXhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDKRpZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:45:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38924 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKRpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 13:45:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so8100833qte.6;
        Thu, 11 Apr 2019 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y63J3YQkSU+J7C/W7fpYA0mFWp+nHkWIT4UFr9hQCN8=;
        b=UdccQXhc7w5eA0Z9TISdDVs8IYIcltUxp2KtVuRZfrLGQvOPuGpPDpCFbMf8LCTGrv
         UtGXV/SzQTE50MLYhxvPJUgcboGZoElnW3QV7Vg40RpaZmXoHOcvzITYJKi+O7Mo+v1l
         57AtK2wTV5QY9AYln7IG1vbzjdJZk7DBentrz6ITdXIAkPKKdAsFhcUaJkfDNVzCb4i+
         1IZtWYCCAXsrjksXZixvRsm3BAehxHKkvCdUVfiJJ+WOgrlw9AcLdKr1MjA2xkcTkKJz
         Sz9eVIGBIaU099sSjOmAdnkRbt1ocSvSIM2PMTn6dy2Q+VlrHUDbq1iD/6UBBpQaXoEV
         0gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y63J3YQkSU+J7C/W7fpYA0mFWp+nHkWIT4UFr9hQCN8=;
        b=QfCTsP1DbZ3PaKKZ5kfOXlhcqbD9c3lwjmFbcCUieb4A7VdkgxGRacZUo6lgSFhV5b
         tWvCw/C7/B0/vjrE9h/NJThrJG/uSUajhF0sEjVJmsSqw4GlYLmneQ2fULPksRev6HJd
         INxbrHV0ous28ZsE58Te4p9NZgi67S2Bk4SlYLHA+soeSVlBthx20WQmny8nWSmAFxGH
         Agbuq819thDvTU4yXquXsL1bYEx9wf/GoC/50KKmcaunXCl57AUNND1Wq7PELAEG/u+W
         rz5qg12xTiTQqOn4UPJhAcNzCwgg2RGve8HlwEpjvXVIX+lBPCdf9VPab0prx8+I7KQM
         h35Q==
X-Gm-Message-State: APjAAAXyeE8VZdqffv5GOMJlbZSokzuyW+DEpQJFITBCtWA2ET2hZ0yA
        hrmBUNbiKQ1XlEVQn1sDqlX8923tuiaCc/C/e8/8Jg==
X-Google-Smtp-Source: APXvYqx38xyXhIL55NO1ZXPH7cHorbygPByjxCkHe02VJgbJo0dacjAA0JSluj7OIqwTpqxpCBlVZF1hvoSnblviWmg=
X-Received: by 2002:aed:35b0:: with SMTP id c45mr42419499qte.144.1555004723930;
 Thu, 11 Apr 2019 10:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <155489659290.20826.1108770347511292618.stgit@firesoul>
 <CAPhsuW7yYqJwsrk2s5EaZOjhhxa5B0374vJGR4+BBKmh8UCQWg@mail.gmail.com> <20190411151843.197dfd41@carbon>
In-Reply-To: <20190411151843.197dfd41@carbon>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 11 Apr 2019 10:45:12 -0700
Message-ID: <CAPhsuW61ov7CB3UZ2KmNdh5ugyTcKdGob6JovPXr60funqC+Og@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Bulk optimization for XDP cpumap redirect
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Edward Cree <ecree@solarflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 11, 2019 at 6:18 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Wed, 10 Apr 2019 16:36:40 -0700
> Song Liu <liu.song.a23@gmail.com> wrote:
>
> > On Wed, Apr 10, 2019 at 6:00 AM Jesper Dangaard Brouer
> > <brouer@redhat.com> wrote:
> > >
> > > This patchset utilize a number of different kernel bulk APIs for optimizing
> > > the performance for the XDP cpumap redirect feature.
> >
> > Could you please share some numbers about the optimization?
>
> I've documented ALL the details here:
>  https://github.com/xdp-project/xdp-project/blob/master/areas/cpumap/cpumap02-optimizations.org

Thanks for the results! Please consider adding the results somewhere.

>
> I seem to have found that the SKB-list approach is not a performance
> advantage, which is very surprising.  BUT it might still be due to
> invalid benchmarking, as I found that F27 behind my back is auto-loading
> iptables-filter modules, which change performance.  Thus, I have to
> redo a lot of the tests...
>
> I'm considering removing the SKB-list patch from the patchset, as all
> other patches show a performance increase/improvement.  Then we can
> merge that, and then I can focus on SKB-list approach in another
> patchset.  BUT as I said above, I might have wrong/invalid
> measurements... I have to retest before I concluded anything...

So we will wait for the new results?

Thanks,
Song

>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
