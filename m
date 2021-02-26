Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76246C433E0
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 20:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283C464F0D
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 20:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZUoF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZUoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 15:44:03 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8DFC06174A
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:43:23 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p186so10199813ybg.2
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hg25kKu5F1y7uApZ7vaOAH8fUCKFjqfZoMpttrKFWZ8=;
        b=MTOa8Hsn1BKJylPgV0G3wZvNfn7ijMW9QFrJ4IPEqV6JOEWUPtU+uaAAeTVMCQZlTl
         NnpYCVBAkMNVCAkFd+k1kdP6o6x/a+HsCUw3tc4xyUpSxbDtIf87p9VTdmEiDoKzEWci
         WS6ZME6WaF9lTW8w8LM9lkkgSknh6qYxBqgRi+mJ1uLnmKIG62ey/4NkaipED+Ctn2PB
         XRLUv89qvSYdnKjjKofD8Pg8RLs0eZhCAUa+U4YiJeNfiA7+WA0p2U7zCp3zXfRjiPFA
         Y0/02MHo5r713CcwyF7X+I1ooq9Ajo37l4k0BDqTKhysKOzG60DL8aHt6nZBXu0NA47+
         r6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hg25kKu5F1y7uApZ7vaOAH8fUCKFjqfZoMpttrKFWZ8=;
        b=p58G5tWvrWDKdgyjx/9ZfuHuVhjgiUQ7p72m3EDOsG8zW+VC2KC38nWDX7dTfNdcHp
         w48CqGUScYvzPoIJSkZHaKyy/c7ToHpmHk1PTw/68D+J43S2+Th9Vzh95ZU70OYU5VYM
         HjfJI/zovFLEZsGO1c2Ek+SgmFdYgTNxXvrI6HekKF1hs4eVkU6ypszYiDkadqaLafrs
         TYg4HO+C/h2NC3gxZZeyntRvI+gUiDDYpSl2REwWOe6FwqxZc2nP8v6Y6KL+j/rSHzHt
         xPngz3C9mxIGo3/QulkSPWpAbjon/gC5Aa1TYs1e9Z6xcGwMhuJ6JrNEcPuMcDRZtV3V
         AxXg==
X-Gm-Message-State: AOAM532fcrj6HMm5sRe3vO70NyDi1dtbYMYh+eEEYIPx/cDsdT37XUzH
        Gtg123Y25ohGQTVq+t9oD7bx9qAPgpfiOGcp3Os=
X-Google-Smtp-Source: ABdhPJw7fG93oNVIaUSSEM9YKt+uTbKE+icdN3Sn1aT7fu829Vye4Q56coC5+WYIRPbCGNhpxBUdy/opH04WKrfvtfo=
X-Received: by 2002:a25:bd12:: with SMTP id f18mr7248400ybk.403.1614372202790;
 Fri, 26 Feb 2021 12:43:22 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw9-XZ4XqNP1MZxC1i7+zntVAivopkgRgc4yXaNtD8QcADw@mail.gmail.com>
 <05c0e4ff-3d93-00c8-b81b-9758c90deca8@fb.com>
In-Reply-To: <05c0e4ff-3d93-00c8-b81b-9758c90deca8@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Feb 2021 12:43:12 -0800
Message-ID: <CAEf4BzZVXtVnV9aSQLaQ=7qz-3E44gvMf-abHeHKLS3S4xjChg@mail.gmail.com>
Subject: Re: Enum relocations against zero values
To:     Yonghong Song <yhs@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 26, 2021 at 10:08 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/26/21 9:47 AM, Lorenz Bauer wrote:
> > Hi Andrii and Yonghong,
> >
> > I'm playing around with enum CO-RE relocations, and hit the following snag:
> >
> >      enum e { TWO };
> >      bpf_core_enum_value_exists(enum e, TWO);
> >
> > Compiling this with clang-12
> > (12.0.0-++20210225092616+e0e6b1e39e7e-1~exp1~20210225083321.50) gives
> > me the following:
> >
> > internal/btf/testdata/relocs.c:66:2: error:
> > __builtin_preserve_enum_value argument 1 invalid
> >          enum_value_exists(enum e, TWO);
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > internal/btf/testdata/relocs.c:53:8: note: expanded from macro
> > 'enum_value_exists'
> >                  if (!bpf_core_enum_value_exists(t, v)) { \
> >                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > internal/btf/testdata/bpf_core_read.h:168:32: note: expanded from
> > macro 'bpf_core_enum_value_exists'
> >          __builtin_preserve_enum_value(*(typeof(enum_type)
> > *)enum_value, BPF_ENUMVAL_EXISTS)
> >                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Andrii can comment on MACRO failures.

Yeah, I ran into this a long time ago as well...

I don't actually know why this doesn't work for zeroes. I've tried to
write that macro in a bit different way, but Clang rejects it:

__builtin_preserve_enum_value(({typeof(enum_type) ___xxx =
(enum_value); *(typeof(enum_type)*)&___xxx;}), BPF_ENUMVAL_EXISTS)

And something as straightforward as

__builtin_preserve_enum_value((typeof(enum_type))(enum_value),
BPF_ENUMVAL_EXISTS)

doesn't work as well.

Yonghong, any idea how to write such a macro to work in all cases? Or
why those alternatives don't work? I only get " error:
__builtin_preserve_enum_value argument 1 invalid" with no more
details, so hard to do anything about this.


>
> >
> > Changing the definition of the enum to
> >
> >      enum e { TWO = 1 }
> >
> > compiles successfully. I get the same result for any enum value that
> > is zero. Is this expected?
>
> IIRC, libbpf will try to do relocation against vmlinux BTF.
> So here, "enum e" probably does not exist in vmlinux BTF, so
> the builtin will return 0. You can try some enum type
> existing in vmlinux BTF to see what happens.
>
> >
> > Best
> > Lorenz
> >
