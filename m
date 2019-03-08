Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A121FC43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 10:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8C420811
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 10:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUNef0uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCHKLS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:11:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42402 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfCHKLS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 05:11:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id y140so10828363qkb.9;
        Fri, 08 Mar 2019 02:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2OsHgqUq36BT6rkUog2SBcb5uaqT68I1/kcRfq14//k=;
        b=MUNef0uvGoI5DRUtPCihbdoJNyXpV2Bw7y2Sqk6vCoWLKdG9KYRnDgIgiZ4P6fndtJ
         +JnsV0QoaCxnerxhvutvACWD+whQW6v5zCx/DQvYYsWtedSuVmqWAMWLUo8Ae3G30bgi
         TuSN2Z9fu38W7pzNHAiPhYV58oPgjoFtxQp1tzrDy1/7r6tGzwe2BW1vVsR992LWW38Z
         LAJcja151b2QWUyEr5O6ReAd/Oztwern1rxjIxZgAN47jrzuemi8R9fegkXnvqEeZZyv
         XoMCtKsOq3hnc9C8w5VEFkPF6UHD+STPxIOTEOs3yngfoS6iJ0QmeOrgOsWJEDYN4+rW
         ZDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2OsHgqUq36BT6rkUog2SBcb5uaqT68I1/kcRfq14//k=;
        b=jTZAwyFOPxKrzrpA2GFQRkZ5qYrWpGl2zb2wgxlPoUFSF11jqjLhstOEuzRpwiy6VI
         mhfFkYXJ1+3tdXHSx9wnQKEJs5HvD2pZ7qYf9JiKCyzGjNTydDprmySaDG4iplhYZf0y
         YhqCGzyf3LkLElbyERCHt41RF+JunQdm9e1pveJHDYFm9nlKUevJxql6sfkJBEX+Bvjo
         b7+SaHBfo9g4p+9jrgrbcArtD1kYaJqBjZTcl3zxVQM12fG7a97lGlzSovkw/xKB80aA
         ETbZau0iC3XJ0gMYjMtyqeukH4Gj4u5pTmhVzESGbAtWApq+qXOIJ12yEPKDoRDm6LbM
         0LOw==
X-Gm-Message-State: APjAAAWhcGVh4KrNZMah+TrC22HJqwDQRHYtA94MU4aq4NJr8XDYRK8A
        eQK3yIrgjZclznjA3hK/jLaWPaf80PF6su3akzPeEPwWfpc=
X-Google-Smtp-Source: APXvYqyxFtl4j51byu/oPCK5KoQPUsanznSsFqe6OJ050vbZIFViuCjA2+NKhbrra484g0Ywm65QK9M5sxsMYZRuUJI=
X-Received: by 2002:a37:d150:: with SMTP id s77mr13725745qki.334.1552039876379;
 Fri, 08 Mar 2019 02:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20190308075727.19358-1-bjorn.topel@gmail.com> <20190308075727.19358-2-bjorn.topel@gmail.com>
 <20190308105907.00000518@gmail.com>
In-Reply-To: <20190308105907.00000518@gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Fri, 8 Mar 2019 11:11:05 +0100
Message-ID: <CAJ+HfNjtiT7v87OEF5kWikVdHro_hKXuC=Cm+gKYKS-3isyS7A@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 8 Mar 2019 at 11:00, Maciej Fijalkowski
<maciejromanfijalkowski@gmail.com> wrote:
>
> On Fri,  8 Mar 2019 08:57:26 +0100
> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> wrote:
>
> > From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> >
> > Passing a non-existing flag in the sxdp_flags member of struct
> > sockaddr_xdp was, incorrectly, silently ignored. This patch addresses
> > that behavior, and rejects any non-existing flags.
> >
> > We have examined existing user space code, and to our best knowledge,
> > no one is relying on the current incorrect behavior. AF_XDP is still
> > in its infancy, so from our perspective, the risk of breakage is very
> > low, and addressing this problem now is important.
> >
> > Fixes: 965a99098443 ("xsk: add support for bind for Rx")
> > Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> > ---
> >  net/xdp/xsk.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 6697084e3fdf..a14e8864e4fa 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -407,6 +407,10 @@ static int xsk_bind(struct socket *sock, struct so=
ckaddr *addr, int addr_len)
> >       if (sxdp->sxdp_family !=3D AF_XDP)
> >               return -EINVAL;
> >
> > +     flags =3D sxdp->sxdp_flags;
> > +     if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY))
> > +             return -EINVAL;
> > +
>
> What about setting more than one flag at a time? Is it allowed/make any s=
ense?
> After a quick look it seems that they exclude each other, e.g. you can't =
force
> a zero copy and copy mode at the same time. And for XDP_SHARED_UMEM two
> remaining flags can't be set.
>
> So maybe check here also that only one particular flag is set by doing:
>
> if (hweight32(flags & (XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY)) > 1)
>         return -EINVAL;
>
> just like we do it for IFLA_XDP_FLAGS in net/core/rtnetlink.c?
>

We have flag semantic checks further down, and my rational was to
*only* check unknown flags first. IMO the current patch is easier to
understand, than your suggested one.

Thanks for taking a look!

Cheers,
Bj=C3=B6rn

> >       mutex_lock(&xs->mutex);
> >       if (xs->dev) {
> >               err =3D -EBUSY;
> > @@ -425,7 +429,6 @@ static int xsk_bind(struct socket *sock, struct soc=
kaddr *addr, int addr_len)
> >       }
> >
> >       qid =3D sxdp->sxdp_queue_id;
> > -     flags =3D sxdp->sxdp_flags;
> >
> >       if (flags & XDP_SHARED_UMEM) {
> >               struct xdp_sock *umem_xs;
>
