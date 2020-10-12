Return-Path: <SRS0=+vlE=DT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71066C433E7
	for <bpf@archiver.kernel.org>; Mon, 12 Oct 2020 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70A62078E
	for <bpf@archiver.kernel.org>; Mon, 12 Oct 2020 22:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAtOmsky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgJLWLL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387733AbgJLWLL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 18:11:11 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A201C0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 15:11:11 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h6so14489680ybi.11
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8fe+/JhQa/FI4JWtTDyGAxSGj9AyAH53z64imLw18YQ=;
        b=kAtOmskyrN3W7kQmVBIwp+vu77AcnRsmYUWDJWZdnroTt/PNZygEb6lo8LlMU6ieRU
         BOvFU/iJb1MsLg4u7AZ+4173kXVpBaWw00ZrOFOuhxplHuFFxHobTyDsr7hNZRgoscSm
         azUze8sRZQbeiZefBIqMh/o3lIQ4DZRdMHDZUId1pIEPY0O5gRC8cRcvOgbpRuEYy4qn
         ikDIZhWggH14e2v10FLAtuYTd/yquL2VB+w6YB2xuijCKgRAnPj20OtJ9IZN03t3qynW
         fQu/RHRYnHNCK8iGd2CpWhq3OR9ioz6sQTVqHLhtnv48QadkfiYjWqnD9xBHWflLSAwX
         37Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8fe+/JhQa/FI4JWtTDyGAxSGj9AyAH53z64imLw18YQ=;
        b=SUNu1h5GHLspxQ6EYm2joXVQHzmXxuKC0bGjKsSwq7DnLje9Kq94Q3V/O+M5kYF03v
         4urvhBXrQ6fLZVX+0Itf0oGNtGVh3K1FIDF3grQT9F2c0IgU0E/2TayoIaSfg04p/meO
         hNGWHvyzASFsLsZAxfzxlIRrs2Fa7fITBKPEwYJCOdyDrAqP7qdVyGLNXGXfM+WnCGBl
         3ju84ltfcwbv6OL/PgVVeP/zb8IPJl2ioz68DnF1iKKggabHaO0Rbk7eumQ9ckGsP4Bp
         XvFGPjLV8qnZiYFhLSlfyy1CpaGkNnSA5rLMa9KACckn9m9iE1h69LH4kVvDOF6271H6
         vWig==
X-Gm-Message-State: AOAM530CKq9r9147SPVd+A/SuGOqwW4e3abRNyGoPKqdzxha/jyQvCrt
        og8aTA6sLIFQeI3raNDe6OZSFV+3qdupLu4poUM=
X-Google-Smtp-Source: ABdhPJyOpaCkof176nCd5n6PQF4JeJ1CFU2HANJYs37feIuYu1OLYs59kF85bvudz9yfc4j8gik8wU/1reb/wD/KvlE=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr27145380ybl.347.1602540670253;
 Mon, 12 Oct 2020 15:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZWoL7w97aR5_02OEjKEkJT8R7OEzpL5Zp8Cycm=yZSLJQ@mail.gmail.com>
 <CAEf4BzYnELT0tE8Y4goPWxuBGN+G-37A8A1yjspFL=LK842geQ@mail.gmail.com> <CAMy7=ZUcdu7_nxnUyGZkGyue5rG_0YRMXqhrnvfKW64dio1LpQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZUcdu7_nxnUyGZkGyue5rG_0YRMXqhrnvfKW64dio1LpQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Oct 2020 15:10:59 -0700
Message-ID: <CAEf4BzZAuXNBA2Z309=zPSf=MHLfzWTWeK_8tXGZ0+-bPkZKAQ@mail.gmail.com>
Subject: Re: libbpf: Loading kprobes fail on some distros
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 12, 2020 at 2:21 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> =E2=80=AB=D7=91=D7=AA=D7=90=D7=A8=D7=99=D7=9A =D7=99=D7=95=D7=9D =D7=91=
=D7=B3, 12 =D7=91=D7=90=D7=95=D7=A7=D7=B3 2020 =D7=91-20:02 =D7=9E=D7=90=D7=
=AA =E2=80=AAAndrii Nakryiko=E2=80=AC=E2=80=8F
> <=E2=80=AAandrii.nakryiko@gmail.com=E2=80=AC=E2=80=8F>:=E2=80=AC
> >
> > On Sun, Oct 11, 2020 at 7:10 PM Yaniv Agman <yanivagman@gmail.com> wrot=
e:
> > >
> > > Trying to load kprobes on ubuntu 4.15.0, I get the following error:
> > > libbpf: load bpf program failed: Invalid argument
> > >
> > > The same kprobes load successfully using bcc
> > >
> > > After some digging, I found that the issue was with the kernel versio=
n
> > > given to the bpf syscall. While libbpf calculated the value 265984 fo=
r
> > > the kern_version argument, bcc used 266002.
> > > It turns out that some distros (e.g. ubuntu, debian) change the patch
> > > number of the kernel version, as detailed in:
> > > https://github.com/ajor/bpftrace/issues/8
> > >
> > > I didn't find a proper API in libbpf to load kprobes in such cases -
> > > is there any?
> >
> > Yes, you can override kernel version that libbpf determines from
> > utsname with a special variable in your BPF code:
> >
> > int KERNEL_VERSION SEC("version") =3D 123;
>
> Thanks! This is trivial, I should have thought about it myself.
> For some reason, I thought that the loader should handle that, but if I i=
nclude

libbpf does handle that automatically, but it has to get the kernel
version from utsname() call, which apparently doesn't always match
what kernel believes LINUX_VERSION_CODE is.

> int KERNEL_VERSION SEC("version") =3D LINUX_VERSION_CODE;
> It should just work
>
> Thanks again!
