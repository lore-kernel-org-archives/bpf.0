Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E09C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3071320850
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 18:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVFw4uFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLSG1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:06:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33194 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDLSG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 14:06:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id k189so6218288qkc.0;
        Fri, 12 Apr 2019 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0rEAAlm76Jv7C5QVkbo2DLulQ4Wnsu93erTggjrSIXA=;
        b=HVFw4uFavhDOh0muLJCC7J8VsOX6pxrjf1EXiKpKOMSjGBlM0KOOp4V6cgIxynjfGo
         NscXzuBUPO8pOZ1N0QaI4T5clfOgn4KwhL7xia1OWm5v41cHLUMAoiBFj+vyrddwRXYN
         lYbBrh+6O8eGgL9sVwZA3nrZL1hK2tJpQdYYnX+9vyFyxxbW1+P492gHwEmxT19tCngq
         tr5z9gwEo5/zGci+ejOGvH1HqTcq0EfNPOm/wOTbOflI8E2IXjoxz4b9VakFwagtEOvu
         Uktr5l+OQIlCGUZeO63NZQ6UY/PXva955FRW6UI2vtCbCOGuZSf5UIoID4ZOVQ8qcu2R
         WIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0rEAAlm76Jv7C5QVkbo2DLulQ4Wnsu93erTggjrSIXA=;
        b=lbkIFEYsLX4sdMahG7djLB6PZW5FV1X6e9KElosr9zT6oukgBcr5ezGKSs5ViUrNfp
         LKVg6KrSqXyoo3RGT7xbgjuPQQNp6uSM5DxCoaj8OPptnGTZ9vb3DIyvmzJq0p40AWjo
         +WAyRwIXMk92JiyKwNlsoOM+CxiBPeOk0kluWlO4v5q4r+HGdQ6Qv+ZA4vwQONWpV+zU
         4aGQ6hN/rM1IXHUi0kYSx5V4beonea9DHQ1k3hyueBX2GL/KvTnNl4DTol7FgB2tMdKE
         8ebqwlXOdyUq0uBEhFHw8EY9DRKmg+iiqSuuuJ6lLRDafiApF4xJnaDyHkdDfzEV33Yl
         96bw==
X-Gm-Message-State: APjAAAUmz2twOhedPeBLQwjrDyMCWgZ1CkavTs8hSw1WijLTjhoKQHY9
        9WikukdU5H0xJBbnYvmbLl+82HGOEpWbyGgudxkRjYY6
X-Google-Smtp-Source: APXvYqxVsNA6HldHdORe92t6c0SMP1a6Zw+C/zyP6t3JBIaC0mTrYa+vJNliZUAeT7ZUj5qFK2HAwR4tFTrYJUZpT28=
X-Received: by 2002:a37:a841:: with SMTP id r62mr45409376qke.16.1555092386415;
 Fri, 12 Apr 2019 11:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190412132938.9044-1-quentin.monnet@netronome.com>
In-Reply-To: <20190412132938.9044-1-quentin.monnet@netronome.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 12 Apr 2019 11:06:15 -0700
Message-ID: <CAPhsuW7w0MobM9N9DEj9xfZjWBB4+PA4wPHh2gfBHhg2tPYK9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] tools: bpftool: fix minor issues in bpftool
 and its documentation
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 12, 2019 at 6:30 AM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> Hi,
> This series brings a number of small fixes to bpftool and the related
> manual pages.
>
> The first two patches are on bpftool itself (remove blank lines when
> dumping programs, do not set errno when showing a tree of cgroup programs).
>
> The next two patches are fixes for the manual pages (missing keyword, wrong
> option name for showing bpftool version). The last one is not exactly a
> fix, but rather an addition to the man page, explaining how to dump program
> statistics.

For the set:

Acked-by: Song Liu <songliubraving@fb.com>

>
> Quentin Monnet (5):
>   tools: bpftool: remove blank line after btf_id when listing programs
>   tools: bpftool: reset errno for "bpftool cgroup tree"
>   tools: bpftool: fix man page documentation for "pinmaps" keyword
>   tools: bpftool: fix short option name for printing version in man
>     pages
>   tools: bpftool: add a note on program statistics in man page
>
>  tools/bpf/bpftool/Documentation/bpftool-cgroup.rst  |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-feature.rst |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-map.rst     |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-net.rst     |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-perf.rst    |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst    | 12 ++++++++++--
>  tools/bpf/bpftool/Documentation/bpftool.rst         |  2 +-
>  tools/bpf/bpftool/cgroup.c                          |  7 +++++++
>  tools/bpf/bpftool/prog.c                            |  2 +-
>  9 files changed, 24 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>
