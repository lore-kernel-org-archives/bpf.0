Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F88C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC2021929
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTthnxoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfBOR0C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:26:02 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45158 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfBOR0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 12:26:02 -0500
Received: by mail-ot1-f48.google.com with SMTP id 32so17710831ota.12;
        Fri, 15 Feb 2019 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBweXTP/2aVfUtf4MJUX5e/WGRiPUCenFIiMtTcwpVI=;
        b=KTthnxocA/WSi5KeEFKDWP5ye9+p6nKArkVoWnM+9t2Gffs7afjFJqjAr7F9CWcLEZ
         hQ9+P5YhmD6rxsDAWxquDm6cgNJjwiITwqB9PB1doyDUoxS54mEo14Rc3B15jO5Sw62q
         ilx3AxjdGgm2vNs/oCbbwRgjgJYWUpRxP6QuqdEwRRqAKUiPgufNJnvAhtpXZ3+p9k7P
         3+qGTa/mvs4JrHwDObfiBgbZ0bD3J+mwTSh9GB/elTYistg3yabGLPain0tPdYUbHDLu
         UH8Ra9YZvUOfYeVITpFHI/bBa28K5s3DwHOYssfxmVE2VeQSI45WXAP1z4oy9fm5Hb+f
         bySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBweXTP/2aVfUtf4MJUX5e/WGRiPUCenFIiMtTcwpVI=;
        b=YWXiDNWFWM7ziuz0ijrnshgDRqyJkf0dfPnj4UmXRbmfKiiLJlZvQ3ZIZoQphZFhGi
         GAvfiN5uf8U92iwEQBfT7nRp29Q/PianRXfWEI8nUIOKbJ7woES+ovRJn/d5eJcYaPjt
         jHjOncVOgmhFxAUiyy4qPbkU5jaefOW/i7O7vlXAkVsoujh0qwSTIIrMIsrSfAe++6pG
         IgWi4Lv+Q20Z5MW8XB16oEwKYzBpe+NGzC9g68J7BiMETPxP3bCD8k8FXrrWurVKN6Ai
         bS3jtBUaZ02u4RRRTXqzVf/bg60MNeu5BWS4UH5SIZpnzGr+OV93BdrMCNJwR2L+4gaK
         kHeA==
X-Gm-Message-State: AHQUAuYt0dNXlEFb2DkEGOMDiKdxG338uInt94aW+DvSPbHljhUF6Ch6
        cj9VCJdzNPBw2svsyPhilYetO+ivq2LfIgIqSXk=
X-Google-Smtp-Source: AHgI3IasPHEOVm2oPYyOsYK9r4czzirRJnM+rjdndbmu0kQuYKNRi9YTElC90LxgHxQ2KrQ3lX+hBqZNvPjneS+GqUg=
X-Received: by 2002:aca:d6cc:: with SMTP id n195mr6596409oig.27.1550251560726;
 Fri, 15 Feb 2019 09:26:00 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzYH25Qi=H7woMf-ZHCu=tML=m+atDh+PO=wdNzeNZ2o3w@mail.gmail.com>
 <20190214124757.GP3269@kernel.org> <20190214131156.GU3269@kernel.org>
 <20190214132029.GA7074@kernel.org> <20190214140118.GC7074@kernel.org>
 <CAEf4BzYpCieVmjuwW-yuiOLuAfhZ9oTPGCZM-O88Jii2rrnP0w@mail.gmail.com> <20190215171538.GB31177@kernel.org>
In-Reply-To: <20190215171538.GB31177@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Feb 2019 09:25:48 -0800
Message-ID: <CAEf4BzY_uZfb0WrmFjVZiOgttJzc4C81NX3_K0K7uAugHKUWaA@mail.gmail.com>
Subject: Re: pahole: soliciting naming suggestion for struct btf rename
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin Lau <kafai@fb.com>, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 15, 2019 at 9:15 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Feb 14, 2019 at 08:37:51PM -0800, Andrii Nakryiko escreveu:
> > On Thu, Feb 14, 2019 at 6:01 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Thu, Feb 14, 2019 at 10:20:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, Feb 14, 2019 at 10:11:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Thu, Feb 14, 2019 at 09:47:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > Em Wed, Feb 13, 2019 at 09:43:43PM -0800, Andrii Nakryiko escreveu:
> > > > > > > happy with it. So consider this email a solicitation for naming
> > > > > > > suggestion. Keep in mind, that all the pahole's functions of the form
> > > > > > > btf__xxx will be renamed as well for consistency. If you like
> > > > > > > btf_info, let me know as well, I'll just stick with it.
> > > > >
> > > > > > Can you try thinking if splitting this further into 'struct btf_loader',
> > > > > > 'struct btf_encoder' that would live in the pahole sources and that
> > > > > > refer to a 'struct btf' that lives in libbpf (or in libbtf, at some
> > > > > > point) is a move that eases your current needs?
> >
> > I think pahole would be simpler by using struct btf for btf_loader and
> > separate struct btf_enc (or whatever name we come up with) to encode
> > BTF during DWARF->BTF conversion. See below about mutable vs immutable
> > BTF representations. For immutable parts libbpf's struct btf should be
> > enough, though pahole is dealing also with endianness issues, so we'll
> > need to resolve that somehow.
> >
> > > > >
> > > > > So, the btf__new() in tools/lib/bpf/btf.c is basically a variant of
> > > > > btf__new() in the pahole sources, probably we should go ahead and make
> > > > > pahole use that btf__new() and do changes in tools/lib/bpf/btf.c to
> > > > > allow for it to access internal state that it needs to do its job?
> > > >
> > > > No, we can't, because tools/lib/btf/btf.c btf__new() is centered on
> > > > getting some BTF buffer no matter where it comes from and passing it to
> > > > the kernel.
> >
> > Yes, libbpf's struct btf is immutable read-only view of .BTF section
> > that can come from either file or kernel. When I'll be adding BTF
> > writing (encoding) API, it probably will be done using something
> > similar to pahole's struct btf, that supports dynamic growth of types
>
> Ok, I noticed that libbpf's btf__new() does load things into the kernel,
> perhaps we should have it not do that and instead have some other method
> for asking it to send the data to kernel, i.e.:
>
>         struct btf *btf = btf__new();
>         int err = btf__load_to_kernel(btf, data, size);
>
> Or have multiple constructors, each specifying what it actually does,
> i.e.:
>
> To get a btf data + size and insert it into the kernel, getting its fd,
> etc:
>
>         struct btf *btf = btf__new_to_kernel(data, size);
>
> For asking for BTF info that is already in the kernel to be obtained for
> tooling to parse maps in running bpf programs:
>
>         struct btf *btf = btf__new_from_kernel(fd);
>
> And for the pahole case it would be:
>
>         struct btf *btf = btf__new_from_elf(file-with-BTF-ELF-section)
>
> that would then be used to do the encoding, etc.

We already did that a couple of days ago, that code wasn't yet
mirrored into github.com/libbpf/libbpf until yesterday (it was merged
this morning). We now have btf__new(data, size) that just constructs
in-memory BTF struct with index for types. And we have
btf__load(struct btf* btf) that can load that into kernel.

We already have equivalent of btf__new_from_kernel(fd) -- btf__get_from_id(fd).

Adding something akin to btf__new_from_elf() might be a good idea as
well, for completeness.


>
> > and strings sections. Then, once application is done constructing BTF,
> > that modifyable struct can be "sealed" into read-only struct btf.
> > Whichever way we'll go about that, there should be minimal changes to
> > pahole to be able to reuse that functionality.
>
> > > > So probably we should backtrack to my previous suggestion of having
> > > > pahole use 'struct btf_loader', or even more explicitely, 'struct
> > > > btf_elf' to make extra clear that this has nothing to do with the
> > > > kernel, its purely about loading/encoding the BTF info from/to a ELF
> > > > file.
>
> > > So, I have this in my private branch, please see if this helps get
> > > things moving forward:
>
> > Yes, this is exactly what I needed, thanks for doing this massive
> > renaming! See just one nit below about probably unintentional file
> > name change.
>
> yeah
>
> > > @@ -645,7 +636,7 @@ static int btf__write_elf(struct btf *btf)
> > >                         llvm_objcopy = "llvm-objcopy";
> > >
> > >                 /* Use objcopy to add a .BTF section */
> > > -               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", btf->filename);
> > > +               snprintf(tmp_fn, sizeof(tmp_fn), "%s.btfe", btfe->filename);
> >
> > This is probably unintentional change, though not a problem per se.
>
> Eagle eyes, I'll fix that.

:)

>
> Thanks,
>
> - Arnaldo
