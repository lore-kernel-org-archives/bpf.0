Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332DBC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 16:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F200F20830
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 16:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfZyyODc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfCYQD2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:03:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45722 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYQD2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 12:03:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id 5so6389483lft.12
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2019 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gts+NdxB//TF9KS3hm25xGr3U2rd7Zzd9Kl+YdGomiE=;
        b=HfZyyODc+MuTD3jQrNIIRN5I7wvbYVUZvuuvpH9LGYwy9ScpyD6hnSuHXBFTOjQpYE
         t2Djt5FbdqgcgAS/RKlWS4ULxkKCJSUfm7748uJfxj74Vv+iLk4EiODMT5CAmyommZdb
         4HZE8dLZiH0mExNlG5O+u9npSTxqlY/GDzxT68ZKNyPOfEk9TZzq6GYdJ/GDE3u1Gt9v
         NWLvwjjCYe3JWLekRTilq98L7pMyyru+gimT02PoSkI9ERBMKE0Y8IlZGHT3RyEaH/H4
         NZbTrghNtSxR15VGdxSHcV114npNtxIDXB0/rWoJ13zeMkO4vPxDcFX/UHSFIdXAY2Lq
         Q48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gts+NdxB//TF9KS3hm25xGr3U2rd7Zzd9Kl+YdGomiE=;
        b=tAuQwlp6PYx6AAcc5aVSNA0rUdiDIWKnnp9pYZZj2SDmDXGDVlFkSGQGWS4Z9XKi/m
         RqDLTPoLJb2eF2h8bDhKBmwB+6b4GQAmljQWIJXvSmcE5q6r4ux7ynsFFpOI8TOtsta+
         gia4XFAMSz38debMb5PjM/jVuCwQLAsn3o0KCaPYoCr2TF6rtz2JcfoF7HiC26vWAQfP
         gQQipKH3YR4dltsr8ORWCxhaN1ThSaEbzjvwbnHSQMQmQD97TESh7OsIepaiGR1fOZli
         dXxxU4Qv3D6kEhIQu2rMmaC3Xts7GCrtGs4iP0luNtYj9MAa5e5DrqFrbfqR9KhAx2ot
         1Skg==
X-Gm-Message-State: APjAAAVKtsI/xplXgvZov/On+WMEcxzuckIESdTjG6C6FIWcV8xvIagx
        ql/GqXsh2rL+Qyn7GI89jz2GTC2TH25WLFvWPeZDhQ==
X-Google-Smtp-Source: APXvYqxLWcft0FFcPq2S7TJ9DmbYmmSd/pTn2yuh1kaQzmmP300OK5PWuMSlkBD/hT8pHag23qMJoivDysuLo6LyGzM=
X-Received: by 2002:ac2:4985:: with SMTP id f5mr6829867lfl.90.1553529805987;
 Mon, 25 Mar 2019 09:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190325122134.GA14042@krava> <854218ad-ce5c-cd00-7772-97bd9bc379a1@iogearbox.net>
In-Reply-To: <854218ad-ce5c-cd00-7772-97bd9bc379a1@iogearbox.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 25 Mar 2019 09:03:11 -0700
Message-ID: <CAADnVQKvRz-EMPqB5oMiG=6N1-QwAhMGnpnQsgSyQuUcrA781A@mail.gmail.com>
Subject: Re: libbpf packaging
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        Brenden Blanco <bblanco@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 25, 2019 at 5:53 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 03/25/2019 01:21 PM, Jiri Olsa wrote:
> > hi guys,
> > we want to package libbpf and I'd like to coordinate
> > with you on some issues I've met on this:
> >
> > 1) I think libbpf should be part of kernel-tools-libs and kernel-tools-libs-devel,
> >    which would look like below (from early rpm build):
> >
> >    $ rpm -qpl kernel-tools-libs-5.0.0-1.fc31.x86_64.rpm
> >    /usr/lib/.build-id
> >    /usr/lib/.build-id/ca
> >    /usr/lib/.build-id/ca/654da1e5ea553f985e28b8d98ad24e51f19e88
> >    /usr/lib/.build-id/f6
> >    /usr/lib/.build-id/f6/a788b316f26fbe70db47bfc0ef500348117023
> >    /usr/lib64/libbpf.so.0
> >    /usr/lib64/libbpf.so.0.0.1
> >    /usr/lib64/libcpupower.so.0
> >    /usr/lib64/libcpupower.so.0.0.1
> >    /usr/share/licenses/kernel-tools-libs
> >    /usr/share/licenses/kernel-tools-libs/COPYING
> >
> >    $ rpm -qpl kernel-tools-libs-devel-5.0.0-1.fc31.x86_64.rpm
> >    /usr/include/bpf/bpf.h
> >    /usr/include/bpf/btf.h
> >    /usr/include/bpf/libbpf.h
> >    /usr/include/cpufreq.h
> >    /usr/include/cpuidle.h
> >    /usr/lib64/libbpf.a
> >    /usr/lib64/libbpf.so
> >    /usr/lib64/libcpupower.so
> >
> >    Do you see libbpf as a standalone package or kernel-tools-libs* wuold be ok for you?
>
> My preference is definitely on making libbpf a stand-alone package, so
> people can just install 'libbpf' or 'libbpf-dev{,el}' and are good to
> go. Also given the pace it's growing these days, it absolutely qualifies
> as a stand-alone package.

+1
libbpf should be standalone package and not part of kernel-tools.

> > 2) There's already bcc-devel's libbpf library packaged:
> >
> >    $ rpm -qf /usr/lib64/libbpf.so
> >    bcc-devel-0.8.0-1.fc28.x86_64
> >
> >    so there's a conflict.. any chance we could rename libbpf to
> >    something else like:
> >
> >    libbpf2.so
> >    libbpfobject.so
> >    libbpfbest.so
> >    ...?
>
> I don't think we should rename the official libbpf package, this will
> just create plain confusion and will make it much harder for potential
> users to adapt in the long-term since we aim for /everyone/ to consume
> official libbpf library instead of hacking their own.
>
> I think bcc folks are migrating to official libbpf as well, at least
> that was my impression. Imho, this would need fixing on bcc side then.

bcc migrated to libbpf some time ago.
