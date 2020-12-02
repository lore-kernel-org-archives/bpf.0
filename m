Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAC0C64E7B
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 22:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81F922241
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 22:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgLBWwX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 2 Dec 2020 17:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgLBWwX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 17:52:23 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D07FC0617A6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 14:51:37 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id q7so50829qvt.12
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8gwqfm8ijR6S1efb6DpsDIo7xQb5z2nPRZLd9Yuy5Y=;
        b=HapWJqZf0aUi3LGo7C+kn8ULTM2bGpIiHVBm4WO6WUTbS7ZSlcWCD1OsdmEbt55S+v
         7QgacHGVj7Fw+x4rXkwxk6FC3TLZq4+78zc4UyHR20zUqzh8/Lxhb5rvSWNPA9DRGkfC
         pHoD0dlDEdIVNmaLHUt4yE80dnW3sS5sjNwZCO6lydAIAI6TdiuBgLF0hyyVUCFgnVyl
         ZVYbZvmmG/zhaNv4Bjxj23NBJbcWYIO9Cd+zQM0fv6CDt8mUyNjVsDgrFTxtt7Vg9z0a
         yAeSLSqZPz3W+aevHPIYze6zXLNUh5oFP1qrUh0Ww+zBZPZi1wnJ/b0po5XwajWR+Hq7
         Ipfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8gwqfm8ijR6S1efb6DpsDIo7xQb5z2nPRZLd9Yuy5Y=;
        b=LDfx5QkCNFNeapjUhTeQhMHbbntgpWIzO76zHOzQOkr8O/+sf0Rivfm99JIZb3SC6g
         SzReuWXr90NL1x83rA9SIzz/FWEIONmmWxTyiNwU8grO8H2n3Gw4gWkiJ6QjuCYeDZVi
         ktQRTN99hO1Yf6HjCyZagDxVjgOG2tL6xamM/ha8l2dAmWV2Aq/p9YcGVExHpf1f6LQz
         zIblTpSgWKLTsFMgk/4Xc/sQPJA8pXwIExTNDsUH0scFzzqY7eWjKKbHpaJsGCt/ovaB
         9GFbGbTv+YPHfME+8PqBhuCTR5ZWcf2V1KHmpzCd8ablA7ayMtFFeHd3fdBvPp0TM4kz
         Roww==
X-Gm-Message-State: AOAM532h4nNXKtanAg/tv9Hs7rKcIVESUcaCI+3wGPblm5ke4DiFR5mM
        KRskw08ghJj1Atn4ijkrVwdry34IYGDrddTeTa8AXVJy4IM=
X-Google-Smtp-Source: ABdhPJwkwwzLpiTUuSYPvjZ4YSUOuBmWf8OeMGofgwqPbMVUYPv5if9zOmc/ERwEaoU85g/5AYrV2Cl6o657kYuvRtU=
X-Received: by 2002:a05:6214:4c7:: with SMTP id ck7mr120612qvb.33.1606949496130;
 Wed, 02 Dec 2020 14:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20201202175039.3625166-1-sdf@google.com> <CAEf4BzZKPvO+b-_WARYcs1Y3mckgT_OJKh7K7LSh2orSL5AG8g@mail.gmail.com>
In-Reply-To: <CAEf4BzZKPvO+b-_WARYcs1Y3mckgT_OJKh7K7LSh2orSL5AG8g@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 2 Dec 2020 14:51:25 -0800
Message-ID: <CAKH8qBvubA9RyqCrnRP2nahzZb8jpux+VbmbFdBoXh14SR3BMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add retries in sys_bpf_prog_load
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 2:46 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 9:52 AM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > I've seen a situation, where a process that's under pprof constantly
> > generates SIGPROF which prevents program loading indefinitely.
> > The right thing to do probably is to disable signals in the upper
> > layers while loading, but it still would be nice to get some error from
> > libbpf instead of an endless loop.
> >
> > Let's add some small retry limit to the program loading:
> > try loading the program 10 (arbitrary) times and give up.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
>
> The subject is misleading as hell. You are not adding retries, you are
> limiting the number of retries.
Ah, sorry, should've been s/add/cap/ :-(

> Otherwise, LGTM. I'd probably go with an even smaller number, can't
> imagine any normal use case having more than once EAGAIN. So I'd say
> feel free to reduce it to 5 even.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
Let me respin with a proper subject and 5 retries.
