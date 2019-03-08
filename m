Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2039C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 11:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7160D20851
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 11:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQdUsS0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCHLGg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 06:06:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37399 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHLGg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 06:06:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id a48so20707251qtb.4;
        Fri, 08 Mar 2019 03:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=beWMzmpE5s16iAbfzvgY+Dn4G4gCXrvMmBI0gW+/9Q0=;
        b=OQdUsS0gIMH+PoOvg/SRquH2f0DGOMaF7IV4+lbLIdP6pgmlFjnz+SM6GBxwKODnP0
         OJdTjvjFiK+DoXqM2QnNwyufbQ+xd0RFmUz69Od2ElaCLxkrPOhV3jSVqe/JezkemNKl
         lYFBNbZMRd9hzkODIKxzIwwpe7UcLBzZ6Sks7Y0dcQ/cP8ZjNo21UFC1w5WLGsvLC//w
         1qNyWGTi66ba1I0e1BWLDc+We6T6nokFNXyt25Dr7WCZvFefor8hOJaTCka0it+ZfoUX
         jh825WrpNJobloKVpvPWLNxyrvfNjuvi4rznLC4YH13cOMDYi6yr5V6WEJoSYX3xEKuW
         8jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=beWMzmpE5s16iAbfzvgY+Dn4G4gCXrvMmBI0gW+/9Q0=;
        b=CVZB02TeYawqykQ/xPk+3LPRX7Z7svZ64si2vGgjFiXnCmz+Dhjt0YppRK/o+GuWek
         gPHusmyEyGHiPyoHeFS9RdqLuhv4jpE9Kzi91dOBftH60R1Ub7bGCTWtzBUFR4FD4j5g
         FeiXYzGHdONjdoIGGGBxGlp3KOac+t/iE0RCRBXMbgf+vIDolUhv7QVkclzBXlyndsSb
         LU0x2T1O1VvJTDPDjcc4VErsfTHDQD0Fm6UVdJ3BU9RkhgLrdc1UuL5fw2tg2kMA/ir4
         4ukXnswu2HQGMmKN28CtZYXfeRQEfZPhmev34b0WSChZYdz4dhYgLDSp6GMnzO2nHgel
         HrxQ==
X-Gm-Message-State: APjAAAVU7lNkIAwZkF90I7cmKTB0F6FMzWR/rRXDbjctwJLwczc3m3gz
        Wcp4ZuDadqOU5SqXC69uqzCiGAg2bMJvtKC8KD0=
X-Google-Smtp-Source: APXvYqyp/GE5CpQbRx3g9pfHaBDCyeF1TySnyRJUrMMRrW7ZCM+gKuyp915blQORyqw5y7wbuS1ZZ0IChyfPUFTQ9uo=
X-Received: by 2002:ac8:1ba9:: with SMTP id z38mr14155635qtj.3.1552043194645;
 Fri, 08 Mar 2019 03:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20190308075727.19358-1-bjorn.topel@gmail.com> <20190308075727.19358-2-bjorn.topel@gmail.com>
 <20190308105907.00000518@gmail.com> <CAJ+HfNjtiT7v87OEF5kWikVdHro_hKXuC=Cm+gKYKS-3isyS7A@mail.gmail.com>
 <20190308114620.000067e7@gmail.com>
In-Reply-To: <20190308114620.000067e7@gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Fri, 8 Mar 2019 12:06:23 +0100
Message-ID: <CAJ+HfNjGzjkf-LGOvprJrUd+LVu7BN5FV2CRmwGXTRxDBD1JBg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] xsk: fix to reject invalid flags in xsk_bind
To:     Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 8 Mar 2019 at 11:46, Maciej Fijalkowski
<maciejromanfijalkowski@gmail.com> wrote:
>
[...]
> > > > +     flags = sxdp->sxdp_flags;
> > > > +     if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY))
> > > > +             return -EINVAL;
> > > > +
> > >
> > > What about setting more than one flag at a time? Is it allowed/make any sense?
> > > After a quick look it seems that they exclude each other, e.g. you can't force
> > > a zero copy and copy mode at the same time. And for XDP_SHARED_UMEM two
> > > remaining flags can't be set.
> > >
> > > So maybe check here also that only one particular flag is set by doing:
> > >
> > > if (hweight32(flags & (XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY)) > 1)
> > >         return -EINVAL;
> > >
> > > just like we do it for IFLA_XDP_FLAGS in net/core/rtnetlink.c?
> > >
> >
> > We have flag semantic checks further down, and my rational was to
> > *only* check unknown flags first. IMO the current patch is easier to
> > understand, than your suggested one.
> >
>
> Hmm thought that bailing out earlier would be better and we could drop the
> actual copy flags checks for shared umem. For xdp_umem_assign_dev() instead of
> passing flags you could just pass a boolean whether you're doing zero copy or
> not. And that brings up the question whether we really need a XDP_COPY flag?
>

I'd prefer doing that as a follow-up patch.

XDP_COPY is needed to explicitly enable copy-mode. No flags is "select
the best option", and COPY/ZEROCOPY is to explicitly select a mode.
