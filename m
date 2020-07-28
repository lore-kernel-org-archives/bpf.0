Return-Path: <SRS0=s4C/=BH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD1FC433E4
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 20:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9491A206D8
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595969996;
	bh=Gn2c68OR+oIC9TzJwDz7iGXRMZT7RHTYswe361t+q0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f7mAEvmD2MHgHoNLzrwn4AVaopyDK2NVXi6aSRxJ2+A46lfJCaODrjQzcNiek7CbL
	 Zl/9Ao69VqUsUuq2b265S1yhxqGgdELeIiyGGxiuFVxGW9abrqcRn4DeAfcMfo1rMS
	 ZLiipdKtgaLokCEqaJRJrAwBrVHLtctcaiDHJQ6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgG1U74 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728728AbgG1U7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 16:59:55 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B98206D8
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 20:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595969995;
        bh=Gn2c68OR+oIC9TzJwDz7iGXRMZT7RHTYswe361t+q0Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=azXvKksccdLjMIXt1p9oVxtR+yyUpvlUW3ioGozRLcQNFc4TECtaaIR8IDYrF2zkG
         BdL+sJ4oeLI+bJ2SkLBvrhQIfFHM1OpCrcffbo7qjNPHHsHnWx8tF/rW3mSn3HijXC
         mZoYB1/PQj9GBE9kEGi3tjhh/aKTfoQH1UTOsMsE=
Received: by mail-lj1-f179.google.com with SMTP id f5so22688461ljj.10
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 13:59:54 -0700 (PDT)
X-Gm-Message-State: AOAM531uG0iIs+JSBDuUL7ZtlPkUhirs+Y+8g6ytp5ZCS1SMlxBAASKi
        flZbHLIfs/05GLLjHNKB5+KQ3V5qAnfcC8RkmZM=
X-Google-Smtp-Source: ABdhPJzeWUJfHFQV8YC1sfdgOZUmtufWPiE6ygQ2/dF6ju44UKfRzLtCaf5sgZys85DdRFY6suCO9bzxCvle1euB8Vw=
X-Received: by 2002:a2e:7c14:: with SMTP id x20mr13466055ljc.41.1595969993342;
 Tue, 28 Jul 2020 13:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200728120059.132256-1-iii@linux.ibm.com> <20200728120059.132256-3-iii@linux.ibm.com>
In-Reply-To: <20200728120059.132256-3-iii@linux.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jul 2020 13:59:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6PaAe4Kb+q7fOnhcm13bh9Mr0i34ar5gAJOm5+BiGkEg@mail.gmail.com>
Message-ID: <CAPhsuW6PaAe4Kb+q7fOnhcm13bh9Mr0i34ar5gAJOm5+BiGkEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] samples/bpf: Fix test_map_in_map on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 5:14 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> s390 uses socketcall multiplexer instead of individual socket syscalls.
> Therefore, "kprobe/" SYSCALL(sys_connect) does not trigger and
> test_map_in_map fails. Fix by using "kprobe/__sys_connect" instead.

samples/bpf is in semi-deprecated state. I tried for quite some time, but still
cannot build it all successfully. So I apologize for bounding the
question to you...

From the code, we do the SYSCALL() trick to change the exact name for
different architecture. Would this change break the same file for x86?

Thanks,
Song

>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  samples/bpf/test_map_in_map_kern.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/samples/bpf/test_map_in_map_kern.c b/samples/bpf/test_map_in_map_kern.c
> index 8def45c5b697..b0200c8eac09 100644
> --- a/samples/bpf/test_map_in_map_kern.c
> +++ b/samples/bpf/test_map_in_map_kern.c
> @@ -103,10 +103,9 @@ static __always_inline int do_inline_hash_lookup(void *inner_map, u32 port)
>         return result ? *result : -ENOENT;
>  }
>
> -SEC("kprobe/" SYSCALL(sys_connect))
> +SEC("kprobe/__sys_connect")
>  int trace_sys_connect(struct pt_regs *ctx)
>  {
> -       struct pt_regs *real_regs = (struct pt_regs *)PT_REGS_PARM1_CORE(ctx);
>         struct sockaddr_in6 *in6;
>         u16 test_case, port, dst6[8];
>         int addrlen, ret, inline_ret, ret_key = 0;
> @@ -114,8 +113,8 @@ int trace_sys_connect(struct pt_regs *ctx)
>         void *outer_map, *inner_map;
>         bool inline_hash = false;
>
> -       in6 = (struct sockaddr_in6 *)PT_REGS_PARM2_CORE(real_regs);
> -       addrlen = (int)PT_REGS_PARM3_CORE(real_regs);
> +       in6 = (struct sockaddr_in6 *)PT_REGS_PARM2_CORE(ctx);
> +       addrlen = (int)PT_REGS_PARM3_CORE(ctx);
>
>         if (addrlen != sizeof(*in6))
>                 return 0;
> --
> 2.25.4
>
