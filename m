Return-Path: <SRS0=Fl3P=7K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A61BC433DF
	for <bpf@archiver.kernel.org>; Thu, 28 May 2020 18:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D51F206A1
	for <bpf@archiver.kernel.org>; Thu, 28 May 2020 18:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6V9xYFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405866AbgE1Sew (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 May 2020 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405863AbgE1Seu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 14:34:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FDBC08C5C7;
        Thu, 28 May 2020 11:34:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k5so34624110lji.11;
        Thu, 28 May 2020 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teZCY71Xz4BPJknJ4L/GZ0v3Ch2Q7hBH8MoQWo4qr3c=;
        b=T6V9xYFbkUvKBcbrPqQw91OJrIiq9n4HoBBb0Fcb98Dk1IkhlsWXJTL1yvngFjoflS
         nvzHoZToyi6JgOHDZS3Z1rq3LWZ1ShzW4Us6QXACbZbVGDRguZkF0sAu0W3TcVHDzLCS
         UUx0KN4DhVxDYL1KmXHghWFQPOpdOTiTKGEEtz2PuwcsBuHskhQAm4yQPkfkbNgM+vJs
         B90JLBEmLkr2i4ciFlJdSK7yUlrMtD2onDsBSVGx6ZDQDC4kogd6Qx1E9Aus+aB3olSF
         pAuQ7qS/VzuyRGVA+WVrg6CzjXGUBthGOQaf+J8DPOnoiidpWnfeXpOQQz551N1W6wn2
         Va6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teZCY71Xz4BPJknJ4L/GZ0v3Ch2Q7hBH8MoQWo4qr3c=;
        b=GxuPFpIzJhgF2oROwTp/bgZEIGXpXNKF0FqjYMRiY40QhhAEEPFA2SUPOJhlOKH1A4
         pS30i87JVrnCtI4YZfm57idELqyY7hrjb+trGhA+QpVaG4IsWmdG/3vR5HyoU+En9TKt
         seKgKNBI3kn5V1bVFsAsD6D8Ej1Na1wgCuxxmaGWIxTgTx72QbBuErpvGxhpWAPRz9mO
         Rku30wMx/kcJbI7QW6FMUc99Z8eJXxziE1diFTEIVqKh8S+eqR+TnYtE9odkBD4xo6+e
         NGVX7WpIbZ6EkOW2kf9PBiadWSS0QPJ1+L00pvOesSK5KZpVnCpfmwloBhEds6m1v+vM
         /OPQ==
X-Gm-Message-State: AOAM532/qdMfE/7nXPLCH+2BDCYKAop/pUrHVkAnMvjygCvtObxYecMz
        ejUtN2BMEwSpTqHAEwSxeaNFMlZx4KzAgr77mlk=
X-Google-Smtp-Source: ABdhPJwPMTMW5IFMX7uVuR01sy0wckmlAbCmNiogJwVQOS1eSfQ23mKgrds2724QqhitssRPJ2/ufL1zQpJ4hZ3KVP0=
X-Received: by 2002:a2e:9b89:: with SMTP id z9mr2040289lji.51.1590690888502;
 Thu, 28 May 2020 11:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <xuny367lq1z1.fsf@redhat.com> <CAADnVQ+1o1JAm7w1twW0KgKMHbp-JvVjzET2N+VS1z=LajybzA@mail.gmail.com>
 <xunyh7w1nwem.fsf@redhat.com> <CAADnVQKbKA_Yuj7v3c6fNi7gZ8z_q_hzX2ry9optEHE3B_iWcg@mail.gmail.com>
 <ec5f6bd9-83e9-fc55-1885-18eee404d988@kernel.org> <CAADnVQJhb0+KWY0=4WVKc8NQswDJ5pU7LW1dQE2TQuya0Pn0oA@mail.gmail.com>
 <20200528100557.20489f04@redhat.com> <20200528105631.GE3115014@kroah.com>
 <20200528161437.x3e2ddxmj6nlhvv7@ast-mbp.dhcp.thefacebook.com>
 <be0a24f4-8602-ba1b-6ca4-7308b01d7a48@linuxfoundation.org>
 <20200528181546.eqzcc5kq5y6hnbcu@ast-mbp.dhcp.thefacebook.com> <CANoWsw=NOvkFAv_roNSJhCqK6Z=xAv79CERzDNKz0qSqzZPstQ@mail.gmail.com>
In-Reply-To: <CANoWsw=NOvkFAv_roNSJhCqK6Z=xAv79CERzDNKz0qSqzZPstQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 28 May 2020 11:34:36 -0700
Message-ID: <CAADnVQL0doJyDFGFZEPgM4_crvDskxRhXQGevzX9KRg8PaFvSQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Benc <jbenc@redhat.com>, shuah <shuah@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 28, 2020 at 11:29 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi!
>
> On Thu, May 28, 2020 at 9:16 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, May 28, 2020 at 11:07:09AM -0600, Shuah Khan wrote:
>
> [...]
> > >
> > > Here is what CI users are requesting:
> > >
> > > - ability to install bpf test with other selftests using kselftest
> > >   install. The common framework is in place and with minor changes
> > >   to bpf test Makefile, we can make this happen. Others and myself
> > >   are willing to work on this, so we can get bpf test coverage in
> > >   test rings.
> >
> > so you're saying that bpf maintainers and all bpf developers now
> > would need to incorporate new 'make install' step to their workflow
> > because some unknown CI system that is not even functional decided
> > to do 'make install' ?
> > That's exactly my point about selfish CI developers who put their
> > needs in front of bpf community of developers.
>
> May be, it can work both ways to make everybody happy :) (I haven't
> seen yet fundamental problems why not).

then stop pretending and do 'cp -r' for your CI as you were suggested
several times already.
It works just fine for libbpf CI. Feel free to copy those scripts.
