Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F033C433DB
	for <bpf@archiver.kernel.org>; Tue, 23 Feb 2021 21:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B25564E89
	for <bpf@archiver.kernel.org>; Tue, 23 Feb 2021 21:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBWVge (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBWVgd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 16:36:33 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D28C061574
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 13:35:53 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id u75so18022640ybi.10
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 13:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XlCzZSgKUWonracjD5beVqCtq/AZoJwKJ209tWgYtrI=;
        b=SIa+EIPt8tFsRWFWJmsA7AjUBnFuCOTBqvhG6qIXUO1Ko5iOyBWCvrGR6IWSyEhHKL
         9bjzGHiTNflips/beFAIhsfL0V7cfC3ZFG3Vc8B9Nd+ZcHd9OCmJoQlwShCdc3FkT/KR
         g6KUeddBdU5ZTL4i0FZL2xLS7Upg0LZd5Jh4JtJVvtqgf9gAVDQDDFFPob5tvzTzjbQr
         WdBCCsoBJhHS3ST/6Io+x/hI/kITQ5Cm6CMG5dIl1CXwYIqOyihtwT6NYlpFcqdZPwjI
         8jLZI/sYT5Ita6E1/uI4aGnaQwMQ6tuQLl2thLXoml6ek3t1c58pIUuHflIJKAs4AZe8
         OaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XlCzZSgKUWonracjD5beVqCtq/AZoJwKJ209tWgYtrI=;
        b=DNzE9qXTmQfepsiQcWV8Gj6ftXAfY3HWk1/UAABmgYBCNswPQPOW3hDnHgjq3MFmeD
         VLxl8bGKqybd5Xp2vdDQ6NzMFXriJHmKywaIczdX3WOuIrOSQtCTY4IH8we3fqQJW3/C
         OXfPaHGGDlvI1piF6lpxaA0vHwQvkLgtNHR2ZIkED3CqLdTYLIxpeOBXX52bgUJd80tr
         52j3q/a79sj16r/6h/b7OIvPXUpPGrBumJpqK5IeUIckEsk4yqbvZ2djT/WPTapGnzOc
         4i5UKKQ98H4VefaGJpQ/KnfxnB5yAlWGGbuu/eKd406yFQHhTmcFmYcs+W0u26C9wXrd
         OLUg==
X-Gm-Message-State: AOAM532aH8nwedVwjSmgxfAeXjeBNOEQTZmmwSfcub2o7YDPIejv7BgC
        DWOAJc1VDkqxQy9Poj2LZoO451VmBVSq1ffRJSo=
X-Google-Smtp-Source: ABdhPJx68lnTJD3+RC/SfCWy8S42788Qoj+vIfIZ0Zd6539rbBhCSQKVmBG/Nm6bh08OF4ku799hvuIn96lMBdEYTFk=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr41110147ybd.230.1614116151982;
 Tue, 23 Feb 2021 13:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20210222214917.83629-1-iii@linux.ibm.com> <20210222214917.83629-7-iii@linux.ibm.com>
 <CAEf4BzY+f77raXGrJN3Nz2To2EC0Td9zwaO2bYKS+W-ZftY9-Q@mail.gmail.com> <df9bb41ed2065ff3b44bc85c4eb2e23d8e24fc88.camel@linux.ibm.com>
In-Reply-To: <df9bb41ed2065ff3b44bc85c4eb2e23d8e24fc88.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Feb 2021 13:35:41 -0800
Message-ID: <CAEf4BzZSkAmLshtTCwv4LW+V=PAz4ZGPy=_HFWP3JrNURV5DHA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 6/7] selftest/bpf: Add BTF_KIND_FLOAT tests
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 23, 2021 at 12:16 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Mon, 2021-02-22 at 23:11 -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 22, 2021 at 1:52 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > Test the good variants as well as the potential malformed ones.
> > >
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > Acked-by: Yonghong Song <yhs@fb.com>
> > > ---
> >
> > Would be nice to have BTF dumping and dedup tests added/adjusted as
> > well.
> >
> > >  tools/testing/selftests/bpf/btf_helpers.c    |   4 +
> > >  tools/testing/selftests/bpf/prog_tests/btf.c | 129
> > > +++++++++++++++++++
> > >  tools/testing/selftests/bpf/test_btf.h       |   3 +
> > >  3 files changed, 136 insertions(+)
> > >
> >
> > [...]
>
> I will add a dedup in the next series, but dumping test requires LLVM
> support, so it will have to come later separately. Still, in my local
> setup the following works:

Awesome, thanks for checking!

>
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
> @@ -205,6 +205,12 @@ struct struct_with_embedded_stuff {
>         int t[11];
>  };
>
> +struct float_struct {
> +       float *f;
> +       const double *d;
> +       volatile long double *ld;
> +};
> +
>  struct root_struct {
>         enum e1 _1;
>         enum e2 _2;
> @@ -219,6 +225,7 @@ struct root_struct {
>         union_fwd_t *_12;
>         union_fwd_ptr_t _13;
>         struct struct_with_embedded_stuff _14;
> +       struct float_struct _15;
>  };
>
>  /* ------ END-EXPECTED-OUTPUT ------ */
>
>
