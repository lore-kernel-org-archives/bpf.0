Return-Path: <SRS0=d63n=DB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D88C2D0E2
	for <bpf@archiver.kernel.org>; Thu, 24 Sep 2020 16:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8B72388A
	for <bpf@archiver.kernel.org>; Thu, 24 Sep 2020 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600964284;
	bh=5m9pe55ZxAYoAZK+vXkjSvidw+7ODQ+Em3EX2wWJ1Zo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=151GjPAjW69NR13udYWlr45CgMJw2XO6uu6BE2aRunYp4COSNl1Qkn0KnYV8l1El0
	 rxdlOgEfp3VRO8t0/mb8HHyiII3pd+Ziior8zgrdJZ/yEC6bp0GxsUV8JhQM5Kd3lO
	 UsPKSgs4zN0QXr2KFgUGPVDy2CXXYP2c8DBtvdVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgIXQSE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:18:04 -0400
Received: from condef-01.nifty.com ([202.248.20.66]:36812 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXQSE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 12:18:04 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 12:18:02 EDT
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-01.nifty.com with ESMTP id 08OG4TTa003638;
        Fri, 25 Sep 2020 01:04:29 +0900
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 08OG3ueY021485;
        Fri, 25 Sep 2020 01:03:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 08OG3ueY021485
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1600963437;
        bh=9ee9VwwvdZUxUdcXkkdp1U0lx4DpuWOQMZvDwgytdP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hzTI5ClFT4hOzIoN61jwlSFslzZdSjOWWXR+OdW95+DN+iQjYnA0h0WUtB5ir816s
         +DZ87UAF+nIACgqkwIw4F9pB0RMs1ARNQnZ4wFcSQGRMvfJthFhuGd/ENCPHOENHuh
         octp/bzp1hYU7SieXdp8Wf8kOOIRC3q0kMMR+lkPNoxHYcUfwQ7enFrI2lNYZ4K/LV
         gY9Q0QWN0Mw/Cl3KeRn0ZGc48MJPMumbOKVzGFiExWK6dhJe1YOlO3W3WCSsJW8CB2
         QDxuQfR6FNom+nQiZKHYiceUnq0wFU2t6828TZmfd13Es7qIWNtebAxMt9+XnooEz8
         GPoSxtqBHqrCQ==
X-Nifty-SrcIP: [209.85.216.45]
Received: by mail-pj1-f45.google.com with SMTP id mn7so1832280pjb.5;
        Thu, 24 Sep 2020 09:03:57 -0700 (PDT)
X-Gm-Message-State: AOAM532E/6rxKQqZv80fgjVzSR4P5DMuOr0TA7oxzNF+nlRbOyFTFdyI
        JCQ8C1v7IQXa1ZjQpVToN0UStQjxlhdRB/QDge4=
X-Google-Smtp-Source: ABdhPJyETrEzNzrVd1OXy91uCC2rbMXAsfzVerHQYhaGFjYLlItBVGJOuJ4Yzsw08mGvCA0s2iw7gEeNxhCwz3+/C+c=
X-Received: by 2002:a17:90b:208:: with SMTP id fy8mr27540pjb.153.1600963436461;
 Thu, 24 Sep 2020 09:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200922232140.1994390-1-morbo@google.com>
In-Reply-To: <20200922232140.1994390-1-morbo@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 25 Sep 2020 01:03:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjf+bVqkkoZgwu9sr-A+VXxEnW_R8nEwmH=aDEU6NAQw@mail.gmail.com>
Message-ID: <CAK7LNATjf+bVqkkoZgwu9sr-A+VXxEnW_R8nEwmH=aDEU6NAQw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: explicitly specify the build id style
To:     Bill Wendling <morbo@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 8:21 AM Bill Wendling <morbo@google.com> wrote:
>
> ld's --build-id defaults to "sha1" style, while lld defaults to "fast".
> The build IDs are very different between the two, which may confuse
> programs that reference them.
>
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  Makefile                             | 4 ++--
>  arch/arm/vdso/Makefile               | 2 +-
>  arch/arm64/kernel/vdso/Makefile      | 2 +-
>  arch/arm64/kernel/vdso32/Makefile    | 2 +-
>  arch/mips/vdso/Makefile              | 2 +-
>  arch/riscv/kernel/vdso/Makefile      | 2 +-
>  arch/s390/kernel/vdso64/Makefile     | 2 +-
>  arch/sparc/vdso/Makefile             | 2 +-
>  arch/x86/entry/vdso/Makefile         | 2 +-
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)


Applied to linux-kbuild.
Thanks.

-- 
Best Regards
Masahiro Yamada
