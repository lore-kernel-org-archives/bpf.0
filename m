Return-Path: <SRS0=x1rW=43=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CCC10F27
	for <bpf@archiver.kernel.org>; Tue, 10 Mar 2020 17:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF9D2146E
	for <bpf@archiver.kernel.org>; Tue, 10 Mar 2020 17:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sk03k7pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCJR0S (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:26:18 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46624 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJR0S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 13:26:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id l7so2570423lfe.13;
        Tue, 10 Mar 2020 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJVFRR1IQX+hmizs9RBYTNxtZNffeaA9KYRc68CKjIo=;
        b=sk03k7pWteCNHL8E35y7QOy7vNYjPCxYpcWvJVWUNWSED8yUld3tjsXtRg1lqwiAzU
         8qkL2Dw4qFdMhMwWjz2yuR4PCd0fe1Jy1o/myV02JBZTKyMeESQUCzHRoI6Fm8o8ZeZM
         59IUFXUhIUXGH/xEVRf+BcOj3uqiyDAYHnsT4aW+oqVD/naVswDDHLGIJh0obaMvFwHn
         IbbYGAQHzGHlsOMYmLxK2Wj6kqFkO7bOxeAObVx5vS7WUnX6Ee6nrPX1EWN4TSb+Vh9c
         DhkcqgD6tJryXHeu5WMnoAd0O12YabN5MdZufkuvjoN2ZaOcbwD2LNvPPqIHBaXHrsiG
         CYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJVFRR1IQX+hmizs9RBYTNxtZNffeaA9KYRc68CKjIo=;
        b=ihiK2uzNMay95fVWErE8SaS/I/jN8wBtbL9g16QcqpO4wL6P8v+3PnzNymN9FzCuMC
         dXcok9LbK3ov42TOOkiadT3Pob//GonTjDhp5UZYCOHQw5DityLUJux/iQ1TqWypC1n5
         /ziAKxabliX+jSvec8OIdMDSj3dPyGgocCNWGlssRp2yNUZ0DFLTUYuZH2SqYjRedPDe
         he6Q2phMzyYX9hRyDb4s0x7ROHosLGUU0Qi4upIZeFGJJoJYwvEGJhulYVmHRqQJYTC4
         lWmXKT91RuLkbZS8v4t/N4XmvF8RCtpp+GfLKoNyX7w7TzY4Qv8qQMZzxAv78jZ9KJmm
         XU/A==
X-Gm-Message-State: ANhLgQ1+c639RL1HGch8zfhecAYT4Rixptm0A6rQP3vXbnyjsZQa+RUt
        7+RvCIQixswhasJC78EKbAlQeMsP6YTjHxd69TQ=
X-Google-Smtp-Source: ADFU+vtpFMCvx4Cn0IdQGZIRB8PDw1PGVOs42uPfsrNRSeYUBmm2xVMMulcrzGBLeKu2ouJ8J02rX8ftRK4uqHYOgN0=
X-Received: by 2002:a19:a40c:: with SMTP id q12mr6940906lfc.73.1583861175618;
 Tue, 10 Mar 2020 10:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <1583825550-18606-1-git-send-email-komachi.yoshiki@gmail.com> <20200310164627.zb3pponhlsweqk45@kafai-mbp>
In-Reply-To: <20200310164627.zb3pponhlsweqk45@kafai-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 10 Mar 2020 10:26:04 -0700
Message-ID: <CAADnVQ+o-TA6WtKk6f5z-T2xO6A6VXhcWCv2uqFA7=EqCh647A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 0/2] Fix BTF verification of enum members with a selftest
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Yoshiki Komachi <komachi.yoshiki@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 10, 2020 at 9:46 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Mar 10, 2020 at 04:32:28PM +0900, Yoshiki Komachi wrote:
> > btf_enum_check_member() checked if the size of "enum" as a struct
> > member exceeded struct_size or not. Then, the function compared it
> > with the size of "int". Although the size of "enum" is 4-byte by
> > default (i.e., equivalent to "int"), the packing feature enables
> > us to reduce it, as illustrated by the following example:
> >
> > struct A {
> >         char m;
> >         enum { E0, E1 } __attribute__((packed)) n;
> > };
> >
> > With such a setup above, the bpf loader gave an error attempting
> > to load it:
> >
> > ------------------------------------------------------------------
> > ...
> >
> > [3] ENUM (anon) size=1 vlen=2
> >         E0 val=0
> >         E1 val=1
> > [4] STRUCT A size=2 vlen=2
> >         m type_id=2 bits_offset=0
> >         n type_id=3 bits_offset=8
> >
> > [4] STRUCT A size=2 vlen=2
> >         n type_id=3 bits_offset=8 Member exceeds struct_size
> >
> > libbpf: Error loading .BTF into kernel: -22.
> >
> > ------------------------------------------------------------------
> >
> > The related issue was previously fixed by the commit 9eea98497951 ("bpf:
> > fix BTF verification of enums"). On the other hand, this series fixes
> > this issue as well, and adds a selftest program for it.
> >
> > Changes in v2:
> > - change an example in commit message based on Andrii's review
> > - add a selftest program for packed "enum" type members in struct/union
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied to bpf tree. Thanks
