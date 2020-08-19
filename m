Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C89FC433E1
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 18:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8066320758
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 18:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dF/8AYNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHSSQe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSSQ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 14:16:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D86DC061383
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 11:16:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so798737plr.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSui/fSURO6y1Wz5D3dLmsitas0HJHJce/emppKsko8=;
        b=dF/8AYNHfvBk97Tne9yynHHsGff9iK0RM/kkGTfShK1LRGRKa/HViuyrVTfy0slqjk
         wzD7tNw/9SwP7DkHBWqiVh1/vHu/5LOHaABMkppQ11J3F4Hb5iXfp1LnIBQb2GzNFe+Y
         Zso/e1BV1VIktkdWwCdDS9kKgiA6BPJvn2xdqHRFZAzHpICLh6pVWwE8FP++sBd2To2t
         VbYvofNGuF3R5X/tMviOhgsBOTRvMPA26sBsH9X7tXj4WBSqAfJB6uELRHB6t44N5jt9
         fBw+wqmDsTyA5fzMBGzJyvBdg3UFWnl/+Prb9sSoi9ffC10L3meNyfzcmfPFSV5WV3Fd
         1+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSui/fSURO6y1Wz5D3dLmsitas0HJHJce/emppKsko8=;
        b=lDM4HVV55D+XgmbcinNKjM8LJCMkB3IQ+r3krX+ZA3kb2d+MEq0Wix72m+1siSgxp4
         9gvkHos10SOWzm4l3C/Ms8GWTp8Wrg3KggNf4kZv2cI7DDSPHMF3mk5tDoNJR6zkA1DQ
         ZJbFT5giSn5FPF7Lf7v2C0QcBIojsvk4vV49kbEKNNAXhvGz/jlfCn6ya/i8D4yAVcVo
         jV4WUn9KHuc98bKc14dLj5szjs0Zx2Pf49u99V1nlS7E+pPpi9b0MfobVW+PMkquV/C0
         b3TAEvkrIY0O6YX/X5V83iQIE8U3RN7lgRaIBm5IJkXQVWKe+c40kRAyqKGnwjFFk/Yl
         32/Q==
X-Gm-Message-State: AOAM5310j9tqVy/w+HOKNDOPSng391mxaTX4XCzDucEM/l2ZW5at1b37
        gm8gPSG36bh61GcG9l09rhcLFl+mnzxJD8bQaj2SJA==
X-Google-Smtp-Source: ABdhPJzsMX/bqJHt1p0BQWY/gaVhEOyhReGXKI17HsvOgOaZ4GJdmSuu2OtNmkJOwIZGjp7Cx7lzB7kU4PKSVbZtFBc=
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr19284728ply.223.1597860988249;
 Wed, 19 Aug 2020 11:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200819092342.259004-1-jolsa@kernel.org> <254246ed-1b76-c435-a7bd-0783a29094d9@fb.com>
 <20200819173618.GH177896@krava>
In-Reply-To: <20200819173618.GH177896@krava>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Aug 2020 11:16:17 -0700
Message-ID: <CAKwvOdnfy4ASdeVqPjMtALXOXgMKdEB8U0UzWDPBKVqdhcPaFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/resolve_btfids: Fix sections with wrong alignment
To:     Yonghong Song <yhs@fb.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mark Wielaard <mjw@redhat.com>,
        Nick Clifton <nickc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 10:36 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Aug 19, 2020 at 08:31:51AM -0700, Yonghong Song wrote:
> >
> >
> > On 8/19/20 2:23 AM, Jiri Olsa wrote:
> > > The data of compressed section should be aligned to 4
> > > (for 32bit) or 8 (for 64 bit) bytes.
> > >
> > > The binutils ld sets sh_addralign to 1, which makes libelf
> > > fail with misaligned section error during the update as
> > > reported by Jesper:
> > >
> > >     FAILED elf_update(WRITE): invalid section alignment
> > >
> > > While waiting for ld fix, we can fix compressed sections
> > > sh_addralign value manually.

Is there a bug filed against GNU ld? Link?

> > >
> > > Adding warning in -vv mode when the fix is triggered:
> > >
> > >    $ ./tools/bpf/resolve_btfids/resolve_btfids -vv vmlinux
> > >    ...
> > >    section(36) .comment, size 44, link 0, flags 30, type=1
> > >    section(37) .debug_aranges, size 45684, link 0, flags 800, type=1
> > >     - fixing wrong alignment sh_addralign 16, expected 8
> > >    section(38) .debug_info, size 129104957, link 0, flags 800, type=1
> > >     - fixing wrong alignment sh_addralign 1, expected 8
> > >    section(39) .debug_abbrev, size 1152583, link 0, flags 800, type=1
> > >     - fixing wrong alignment sh_addralign 1, expected 8
> > >    section(40) .debug_line, size 7374522, link 0, flags 800, type=1
> > >     - fixing wrong alignment sh_addralign 1, expected 8
> > >    section(41) .debug_frame, size 702463, link 0, flags 800, type=1
> > >    section(42) .debug_str, size 1017571, link 0, flags 830, type=1
> > >     - fixing wrong alignment sh_addralign 1, expected 8
> > >    section(43) .debug_loc, size 3019453, link 0, flags 800, type=1
> > >     - fixing wrong alignment sh_addralign 1, expected 8
> > >    section(44) .debug_ranges, size 1744583, link 0, flags 800, type=1
> > >     - fixing wrong alignment sh_addralign 16, expected 8
> > >    section(45) .symtab, size 2955888, link 46, flags 0, type=2
> > >    section(46) .strtab, size 2613072, link 0, flags 0, type=3
> > >    ...
> > >    update ok for vmlinux
> > >
> > > Another workaround is to disable compressed debug info data
> > > CONFIG_DEBUG_INFO_COMPRESSED kernel option.
> >
> > So CONFIG_DEBUG_INFO_COMPRESSED is required to reproduce the bug, right?
>
> correct
>
> >
> > I turned on CONFIG_DEBUG_INFO_COMPRESSED in my config and got a bunch of
> > build failures.
> >
> > ld: drivers/crypto/virtio/virtio_crypto_algs.o: unable to initialize
> > decompress status for section .debug_info
> > ld: drivers/crypto/virtio/virtio_crypto_algs.o: unable to initialize
> > decompress status for section .debug_info
> > ld: drivers/crypto/virtio/virtio_crypto_algs.o: unable to initialize
> > decompress status for section .debug_info
> > ld: drivers/crypto/virtio/virtio_crypto_algs.o: unable to initialize
> > decompress status for section .debug_info
> > drivers/crypto/virtio/virtio_crypto_algs.o: file not recognized: File format
> > not recognized
> >
> > ld: net/llc/llc_core.o: unable to initialize decompress status for section
> > .debug_info
> > ld: net/llc/llc_core.o: unable to initialize decompress status for section
> > .debug_info
> > ld: net/llc/llc_core.o: unable to initialize decompress status for section
> > .debug_info
> > ld: net/llc/llc_core.o: unable to initialize decompress status for section
> > .debug_info
> > net/llc/llc_core.o: file not recognized: File format not recognized
> >
> > ...
> >
> > The 'ld' in my system:
> >
> > $ ld -V
> > GNU ld version 2.30-74.el8
> >   Supported emulations:
> >    elf_x86_64
> >    elf32_x86_64
> >    elf_i386
> >    elf_iamcu
> >    i386linux
> >    elf_l1om
> >    elf_k1om
> >    i386pep
> >    i386pe

According to Documentation/process/changes.rst, the minimum supported
version of GNU binutils for the kernels is 2.23.  Can you upgrade to
that and confirm that you still observe the issue?  I don't want to
spend time chasing bugs in old, unsupported versions of GNU binutils,
especially as Jiri notes, 2.26 is required for
CONFIG_DEBUG_INFO_COMPRESSED.  We can always strengthen the Kconfig
check for it.  Otherwise, I'm not familiar with the observed error
message.

> > $
> >
> > Do you know what is the issue here?
>
> mine's: GNU ld version 2.32-31.fc31
>
> there's version info in commit:
>   10e68b02c861 Makefile: support compressed debug info
>
>   Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
>   5.0+, binutils 2.26+, and zlib.
>
> cc-ing Nick Desaulniers, author of that patch.. any idea about the error above?
>
> thanks,
> jirka
>


-- 
Thanks,
~Nick Desaulniers
