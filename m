Return-Path: <SRS0=2eLy=CX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70664C433E2
	for <bpf@archiver.kernel.org>; Mon, 14 Sep 2020 22:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D1E20738
	for <bpf@archiver.kernel.org>; Mon, 14 Sep 2020 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600123804;
	bh=uRLXbyUjpJ0cf8iDXJUa7uZenqFuKK8iFOXPwiJ5tXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i/GqO2E/qWyX6lkqC97P6nPWppPY2mSUFRixocbdSRdB2KazR6+iPo/nzHjwKxVGL
	 ITDvuVr/Cv8xEqzSBoDLD5UvlmWDKaL1OUS059zbu9dX6cTianeFVVPJRFjn9ERPTr
	 UCfF2s9zqhyxckRRYNE6ccrzKIa4oxBqYoyWPFoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgINWuD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Sep 2020 18:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgINWuC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 18:50:02 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33262208E4;
        Mon, 14 Sep 2020 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600123801;
        bh=uRLXbyUjpJ0cf8iDXJUa7uZenqFuKK8iFOXPwiJ5tXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XW4w8iCMkxOTWnompRBH+C0he3Qv1I3GhP4zZ/PNWiK15v9s8iorLM2z853wIttbf
         8BSiTwTx8KcxtajDFWHiyjEPJq4td8FBvyBvkAnqOp0GtN6VIXx16Bt0uLhQbg4yF6
         izpvn2CWcJWgJzUWIfg3dfTFF0mkP6CgP/Ip5kXI=
Received: by mail-lj1-f182.google.com with SMTP id c2so1052656ljj.12;
        Mon, 14 Sep 2020 15:50:01 -0700 (PDT)
X-Gm-Message-State: AOAM530NYcQr724/o9Y4Fw+EY3H8EqdCf5ou+AJog4p4/zPJj26TuHfg
        VlwmSOA4ZW5W5zG2psSzKMMXpjrVcoN6CINQmTU=
X-Google-Smtp-Source: ABdhPJxWSoYmot9r6N03FUsm9G20xaUjbad4WhyIjkezfpqOv3kaiVAfSQsy11HpP3lsBY/j4bO37WzdNTXbAqHgSkg=
X-Received: by 2002:a2e:9c8d:: with SMTP id x13mr5407104lji.392.1600123799479;
 Mon, 14 Sep 2020 15:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200914223210.1831262-1-yhs@fb.com> <CAEf4BzYAg0ox=yTWAzKjXZbCWuDEMvKzwW1KmJ5C8NGPkecpAA@mail.gmail.com>
In-Reply-To: <CAEf4BzYAg0ox=yTWAzKjXZbCWuDEMvKzwW1KmJ5C8NGPkecpAA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 14 Sep 2020 15:49:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6bd5w9b_N53eF4asTtJPGV4ft_Ac+LUC-27cn6gNjZow@mail.gmail.com>
Message-ID: <CAPhsuW6bd5w9b_N53eF4asTtJPGV4ft_Ac+LUC-27cn6gNjZow@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix a compilation error with xsk.c for
 ubuntu 16.04
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
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

On Mon, Sep 14, 2020 at 3:47 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 14, 2020 at 3:32 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > When syncing latest libbpf repo to bcc, ubuntu 16.04 (4.4.0 LTS kernel)
> > failed compilation for xsk.c:
> >   In file included from /tmp/debuild.0jkauG/bcc/src/cc/libbpf/src/xsk.c=
:23:0:
> >   /tmp/debuild.0jkauG/bcc/src/cc/libbpf/src/xsk.c: In function =E2=80=
=98xsk_get_ctx=E2=80=99:
> >   /tmp/debuild.0jkauG/bcc/src/cc/libbpf/include/linux/list.h:81:9: warn=
ing: implicit
> >   declaration of function =E2=80=98container_of=E2=80=99 [-Wimplicit-fu=
nction-declaration]
> >            container_of(ptr, type, member)
> >            ^
> >   /tmp/debuild.0jkauG/bcc/src/cc/libbpf/include/linux/list.h:83:9: note=
: in expansion
> >   of macro =E2=80=98list_entry=E2=80=99
> >            list_entry((ptr)->next, type, member)
> >   ...
> >   src/cc/CMakeFiles/bpf-static.dir/build.make:209: recipe for target
> >   'src/cc/CMakeFiles/bpf-static.dir/libbpf/src/xsk.c.o' failed
> >
> > Commit 2f6324a3937f ("libbpf: Support shared umems between queues and d=
evices")
> > added include file <linux/list.h>, which uses macro "container_of".
> > xsk.c file also includes <linux/ethtool.h> before <linux/list.h>.
> >
> > In a more recent distro kernel, <linux/ethtool.h> includes <linux/kerne=
l.h>
> > which contains the macro definition for "container_of". So compilation =
is all fine.
> > But in ubuntu 16.04 kernel, <linux/ethtool.h> does not contain <linux/k=
ernel.h>
> > which caused the above compilation error.
> >
> > Let explicitly add <linux/kernel.h> in xsk.c to avoid compilation error
> > in old distro's.
> >
> > Fixes: 2f6324a3937f ("libbpf: Support shared umems between queues and d=
evices")
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
