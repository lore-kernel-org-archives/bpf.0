Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B72C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 10:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929D820811
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 10:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss/e/ef7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCHKqb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:46:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47061 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHKqa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 05:46:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so13875408pfh.13;
        Fri, 08 Mar 2019 02:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fSBx+rr1bSjOid41hu6DhztkFRxW8NBdtlS+vnPaWHo=;
        b=ss/e/ef7/mcyF+YGBz4rWRwYTrq1b5+LoRM8QbL/iu+D0RMtxigK2/3J+4hSsGpIYf
         ES7bd/YhKvSMN7w8rybCuAw2RZ4ILEqWf7TcFtrkt7Fq15kUa6RINrSJzPapwEOo/bM+
         UozB+rtbFCV1hMMzFod500aAzZeRox5NcXjsyDNCDgqsdHvzA69kQVNjfqHv9H/7T0jm
         P08rXEMJK01TLRGq0gYoyJu4+qs1eH2uW3vOGGJ2t82gRju4qk50T3gERg4udl8axHA6
         5NbvETmf12LM+Wr6WIlV5l4hpu5Soun2z55Bu82myL3wTAzNL4WM1IXlIcuPcs+DlIi6
         kMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fSBx+rr1bSjOid41hu6DhztkFRxW8NBdtlS+vnPaWHo=;
        b=aXrwD14NP+PXdGLlGfV9h2GLApp8hFiD7ZpMMug5YD/T3E7tQRFmMRistlijHHDqla
         V6CY4oVM6lZpirIgdjw5B6rLaebJMy7R4uwgpQ+XfA06haAt/rRLypaGBnZojpbrgzWs
         YyrUsvqMtnkuL3g/bXQ2RnZtagtQAH/j3SJlc0sW7bnGcAipM0FSk2Dyq5Zed4K+1FMU
         zevVuRKGa50kTUE8Ku9PbPpmWX2f9BqoZgLkssNsnUrAlH8ZIapnrssf+dzZWK6VCFDN
         eN6fZA9OZStgOszz2AbhcMjVkaPMLGxYetG74i44aPTL0zON167LEgbf9DWurEOW8u1T
         8FSg==
X-Gm-Message-State: APjAAAWJbRgsUnj0T6/9KI6WcdEKQu5fp6CRd5lprgVG7UTZ4qkoYL4C
        EohXZnlg+MuFT2g3gGRj3AY=
X-Google-Smtp-Source: APXvYqxwUj3VTSzoWZ0BB1Sg7DIj/djD9Lnfb8XrrpKbbR04TxvqoHlH4sx6wexQuv/zFbZa2mfFrA==
X-Received: by 2002:a63:3648:: with SMTP id d69mr16130546pga.314.1552041989809;
        Fri, 08 Mar 2019 02:46:29 -0800 (PST)
Received: from localhost ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id v26sm10047331pgn.46.2019.03.08.02.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 02:46:29 -0800 (PST)
Date:   Fri, 8 Mar 2019 11:46:20 +0100
From:   Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>
To:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Netdev <netdev@vger.kernel.org>,
        =?ISO-8859-1?Q?B?= =?ISO-8859-1?Q?j=F6rn_T=F6pel?= 
        <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] xsk: fix to reject invalid flags in xsk_bind
Message-ID: <20190308114620.000067e7@gmail.com>
In-Reply-To: <CAJ+HfNjtiT7v87OEF5kWikVdHro_hKXuC=Cm+gKYKS-3isyS7A@mail.gmail.com>
References: <20190308075727.19358-1-bjorn.topel@gmail.com>
        <20190308075727.19358-2-bjorn.topel@gmail.com>
        <20190308105907.00000518@gmail.com>
        <CAJ+HfNjtiT7v87OEF5kWikVdHro_hKXuC=Cm+gKYKS-3isyS7A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 8 Mar 2019 11:11:05 +0100
Bj=F6rn T=F6pel <bjorn.topel@gmail.com> wrote:

> On Fri, 8 Mar 2019 at 11:00, Maciej Fijalkowski
> <maciejromanfijalkowski@gmail.com> wrote:
> >
> > On Fri,  8 Mar 2019 08:57:26 +0100
> > Bj=F6rn T=F6pel <bjorn.topel@gmail.com> wrote:
> > =20
> > > From: Bj=F6rn T=F6pel <bjorn.topel@intel.com>
> > >
> > > Passing a non-existing flag in the sxdp_flags member of struct
> > > sockaddr_xdp was, incorrectly, silently ignored. This patch addresses
> > > that behavior, and rejects any non-existing flags.
> > >
> > > We have examined existing user space code, and to our best knowledge,
> > > no one is relying on the current incorrect behavior. AF_XDP is still
> > > in its infancy, so from our perspective, the risk of breakage is very
> > > low, and addressing this problem now is important.
> > >
> > > Fixes: 965a99098443 ("xsk: add support for bind for Rx")
> > > Signed-off-by: Bj=F6rn T=F6pel <bjorn.topel@intel.com>
> > > ---
> > >  net/xdp/xsk.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 6697084e3fdf..a14e8864e4fa 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -407,6 +407,10 @@ static int xsk_bind(struct socket *sock, struct =
sockaddr *addr, int addr_len)
> > >       if (sxdp->sxdp_family !=3D AF_XDP)
> > >               return -EINVAL;
> > >
> > > +     flags =3D sxdp->sxdp_flags;
> > > +     if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY))
> > > +             return -EINVAL;
> > > + =20
> >
> > What about setting more than one flag at a time? Is it allowed/make any=
 sense?
> > After a quick look it seems that they exclude each other, e.g. you can'=
t force
> > a zero copy and copy mode at the same time. And for XDP_SHARED_UMEM two
> > remaining flags can't be set.
> >
> > So maybe check here also that only one particular flag is set by doing:
> >
> > if (hweight32(flags & (XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY)) > 1)
> >         return -EINVAL;
> >
> > just like we do it for IFLA_XDP_FLAGS in net/core/rtnetlink.c?
> > =20
>=20
> We have flag semantic checks further down, and my rational was to
> *only* check unknown flags first. IMO the current patch is easier to
> understand, than your suggested one.
>=20

Hmm thought that bailing out earlier would be better and we could drop the
actual copy flags checks for shared umem. For xdp_umem_assign_dev() instead=
 of
passing flags you could just pass a boolean whether you're doing zero copy =
or
not. And that brings up the question whether we really need a XDP_COPY flag?

> Thanks for taking a look!
>=20
> Cheers,
> Bj=F6rn
>=20
> > >       mutex_lock(&xs->mutex);
> > >       if (xs->dev) {
> > >               err =3D -EBUSY;
> > > @@ -425,7 +429,6 @@ static int xsk_bind(struct socket *sock, struct s=
ockaddr *addr, int addr_len)
> > >       }
> > >
> > >       qid =3D sxdp->sxdp_queue_id;
> > > -     flags =3D sxdp->sxdp_flags;
> > >
> > >       if (flags & XDP_SHARED_UMEM) {
> > >               struct xdp_sock *umem_xs; =20
> > =20

