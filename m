Return-Path: <SRS0=lXxl=CY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8B2C433E2
	for <bpf@archiver.kernel.org>; Tue, 15 Sep 2020 01:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0022D20771
	for <bpf@archiver.kernel.org>; Tue, 15 Sep 2020 01:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh8X28qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgIOByG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Sep 2020 21:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgIOByF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 21:54:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3479C06174A;
        Mon, 14 Sep 2020 18:54:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so1310519ljp.13;
        Mon, 14 Sep 2020 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a/0w/Xj+sECC6TVgublKFy/gImkiR56sEMx0Dz9SN/U=;
        b=Oh8X28qiVEpwJkdubUDDEtu1qG0x7YoJCSyHFYde/8xugVOLdFHenXAJXVeXQtXfJE
         nqxWmOaXqIVysyUgT/ZyCqJK35cp2u3Ii7Kz2I+cEFwAzCF/5IiWSTvcrM25o0HFGwv/
         srbiH0VonHKPLHKs8PY+dMFHl6bXc8jGZptSG97QCDchjik12dAESVdGzGOQcR6XlOJ1
         Mnt7YWMRDWsOyEmTgGJyxNjFhzs81MUUIOA2JUvNqbNSNRpQ7/YWwaSbabBwUS37qwjv
         NuiwUbVd+4PG7Af1N7mY/CBMnxMlBlyDiTmZNofTdkToFDKG1KR+IHXoosNPSPS+evCd
         gYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a/0w/Xj+sECC6TVgublKFy/gImkiR56sEMx0Dz9SN/U=;
        b=HvaW6tgZOInZPQcdq0kAtpRLaY1eEDJdWkg+uf65tFvDxpmm9v+P8ZmUD1EleBBxLT
         Sih33pTNofbu/HyrhE/nbfMLD6/jQMFlx9Ayj29dQnx3wAnczTa6v4scGC46v+daAU4d
         ZqkrJgNk6cLhcGAkHNx3vCaXKZlcj89RbzAT2UL0+WaZElKqNsIYSv5zc+kllAZjVgYO
         1fMaHb3z74gIaUbM7bO7YLfq6PzlDC0tHc4vvGoCDlu9Wz+Ggng1meK2E+boaXKKgmeo
         AmJ83KgruCfZksGpViKhFVUOdscr+qa6VMk6uR2j5NRMu4ePoL6tvlRqKX3l0FFRUJ48
         1Lbw==
X-Gm-Message-State: AOAM531RTvd8br8SJDywLqxqF5YqtAPs8lpfh9JBrkJfYx5HRkzNvzOI
        zU3p9aIkEdtKD5kmBGbBsAkn7L0b7hJomhpNvhQJo9w8
X-Google-Smtp-Source: ABdhPJydUV0CyZQSoEj3IQReZGK6wLEmlCLUaVumTd7AmgJHTbX7uQLXlZdvGpcB+nLQLWRuU3B9gU1S4AQg2zNgn7Q=
X-Received: by 2002:a2e:9782:: with SMTP id y2mr6182559lji.91.1600134843358;
 Mon, 14 Sep 2020 18:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200914223210.1831262-1-yhs@fb.com> <CAEf4BzYAg0ox=yTWAzKjXZbCWuDEMvKzwW1KmJ5C8NGPkecpAA@mail.gmail.com>
 <CAPhsuW6bd5w9b_N53eF4asTtJPGV4ft_Ac+LUC-27cn6gNjZow@mail.gmail.com>
In-Reply-To: <CAPhsuW6bd5w9b_N53eF4asTtJPGV4ft_Ac+LUC-27cn6gNjZow@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Sep 2020 18:53:52 -0700
Message-ID: <CAADnVQKe5dvgcmBj8nGLBdjrJB4aJEn0qxXXhKmYkVYMh-mEDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix a compilation error with xsk.c for
 ubuntu 16.04
To:     Song Liu <song@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 14, 2020 at 3:50 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Sep 14, 2020 at 3:47 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Sep 14, 2020 at 3:32 PM Yonghong Song <yhs@fb.com> wrote:
> > >
> > > When syncing latest libbpf repo to bcc, ubuntu 16.04 (4.4.0 LTS kerne=
l)
> > > failed compilation for xsk.c:
> > >   In file included from /tmp/debuild.0jkauG/bcc/src/cc/libbpf/src/xsk=
.c:23:0:
> > >   /tmp/debuild.0jkauG/bcc/src/cc/libbpf/src/xsk.c: In function =E2=80=
=98xsk_get_ctx=E2=80=99:
> > >   /tmp/debuild.0jkauG/bcc/src/cc/libbpf/include/linux/list.h:81:9: wa=
rning: implicit
> > >   declaration of function =E2=80=98container_of=E2=80=99 [-Wimplicit-=
function-declaration]
> > >            container_of(ptr, type, member)
> > >            ^
> > >   /tmp/debuild.0jkauG/bcc/src/cc/libbpf/include/linux/list.h:83:9: no=
te: in expansion
> > >   of macro =E2=80=98list_entry=E2=80=99
> > >            list_entry((ptr)->next, type, member)
> > >   ...
> > >   src/cc/CMakeFiles/bpf-static.dir/build.make:209: recipe for target
> > >   'src/cc/CMakeFiles/bpf-static.dir/libbpf/src/xsk.c.o' failed
> > >
> > > Commit 2f6324a3937f ("libbpf: Support shared umems between queues and=
 devices")
> > > added include file <linux/list.h>, which uses macro "container_of".
> > > xsk.c file also includes <linux/ethtool.h> before <linux/list.h>.
> > >
> > > In a more recent distro kernel, <linux/ethtool.h> includes <linux/ker=
nel.h>
> > > which contains the macro definition for "container_of". So compilatio=
n is all fine.
> > > But in ubuntu 16.04 kernel, <linux/ethtool.h> does not contain <linux=
/kernel.h>
> > > which caused the above compilation error.
> > >
> > > Let explicitly add <linux/kernel.h> in xsk.c to avoid compilation err=
or
> > > in old distro's.
> > >
> > > Fixes: 2f6324a3937f ("libbpf: Support shared umems between queues and=
 devices")
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > ---
> >
> > Acked-by: Andrii Nakryiko <andriin@fb.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>

Applied. Thanks
