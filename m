Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D20C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 06:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040662082E
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 06:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrKgE7v3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfDKGUS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:20:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45709 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKGUS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 02:20:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id e5so4194191otk.12;
        Wed, 10 Apr 2019 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmcJ90TnmnI4RJo37Z5WpTldw8nKeSI1l2JOGfSsBvQ=;
        b=mrKgE7v32ittPKaRT7dwHbDhYnV2BOwqBe8nnz13hBqCGXeJ5CKkgS3u4mxstqEXwy
         TEwGDi08J05STc2HwsrFowMMyV8I2XDk26EJxI5boAPpINHPbWIlXvy++ccOkgrGeMlu
         FKomzHvOEtcwd9mkzT/nN64ZVQnaHHUrWce9qSxTiHihf4B1wkbi/Es/F5rpVsXapycb
         tUqdE9AhdIzqZ1vmrdHvdZY60ZZ+qGIShYp5ShHBVQ25oSFLRqkoAP7Ffv/CFf73eNhd
         MTnNLIBx+rly+PGtEHP3oE2bR36zq/Ae4QNrht9KFNEwXf0gpLsnm15tgDEcshPOTff3
         OTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmcJ90TnmnI4RJo37Z5WpTldw8nKeSI1l2JOGfSsBvQ=;
        b=jHUd1Q98rcKBXOnYCdr1Gbd3poQo4Xe+X8qtxghuhQg+uqFoS+lFu7Tz+Mob/rOlAw
         8BoOkeRd8mpeU73mqHfjdRV3isb4BHf7rd7TnpvVvdjVCJIfhSX4CbbdcV+ARA4ccY6n
         fALpYggCsZQZHhBlaRHzMdDMMO2OtkdagjamwLnzsQot+EYjPVzkDudMfKYdtOIfAOzK
         LbIj5thunUFhW35DYOsXO+D7DG3/8fRP3ZzFq31l0Aq4ILDUqrj5olAmWaONSDV2Omja
         TvE3wi7pDC3PBbeovrC+PSB17/1ts/8r5vr/KdAxLTjII49Zn5rMIu/EMyozZxsko+vi
         zUJA==
X-Gm-Message-State: APjAAAW1s5keFvTkQxxReq8l1+VJpjSF4HLqRy55RlIh2y+ZBDFTSQRg
        nwMpVg2EfnR5zjPHBhcepFGZ+qFbhJsdO/0hdo0=
X-Google-Smtp-Source: APXvYqw2i6LFdS6e8ddUN3IqWpcriz9ZrD0DmrEybaI05jktdsY2txXjb46cz+3+7NulBIByU1O2aGP5zbWB2ne6rJ4=
X-Received: by 2002:a9d:69:: with SMTP id 96mr28868168ota.186.1554963617434;
 Wed, 10 Apr 2019 23:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <1554880154-30791-1-git-send-email-magnus.karlsson@intel.com>
 <1554880154-30791-2-git-send-email-magnus.karlsson@intel.com> <CAH3MdRXwK3=8z=CNK-=vvL5dY4nvT1ZCWXDOUWLR8f65zydS2Q@mail.gmail.com>
In-Reply-To: <CAH3MdRXwK3=8z=CNK-=vvL5dY4nvT1ZCWXDOUWLR8f65zydS2Q@mail.gmail.com>
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
Date:   Thu, 11 Apr 2019 08:20:06 +0200
Message-ID: <CAJ8uoz2QcRY1r5q98NAX=_1hN5zQ5-JvCjMSXnvL0mFTL5wXWQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] libbpf: remove likely/unlikely in xsk.h
To:     Y Song <ys114321@gmail.com>
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        bruce.richardson@intel.com, ciara.loftus@intel.com,
        ilias.apalodimas@linaro.org, Ye Xiaolong <xiaolong.ye@intel.com>,
        ferruh.yigit@intel.com, "Zhang, Qi Z" <qi.z.zhang@intel.com>,
        georgmueller@gmx.net
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 10, 2019 at 9:08 PM Y Song <ys114321@gmail.com> wrote:
>
> On Wed, Apr 10, 2019 at 12:21 AM Magnus Karlsson
> <magnus.karlsson@intel.com> wrote:
> >
> > This patch removes the use of likely and unlikely in xsk.h since they
> > create a dependency on Linux headers as reported by several
> > users. There have also been reports that the use of these decreases
> > performance as the compiler puts the code on two different cache lines
> > instead of on a single one. All in all, I think we are better off
> > without them.
>
> The change looks good to me.
>   Acked-by: Yonghong Song <yhs@fb.com>
>
> libbpf repo (https://github.com/libbpf/libbpf/) solved this issue by
> providing some customer
> implementation just to satisfying compilatioins. I guess users here do
> not use libbpf repo and they
> directly extract kernel source and try to build?

That is correct. Quite a number of people did not even know it existed
in the first place. Maybe we need more pointers to the repo.

> Just curious. do you have detailed info about which code in two
> different cache lines instead
> of one cache line and how much performance degradation?

Sorry, I have no detailed info. It is very dependent on the exact
access rates to and from the queues and the way the instructions line
up in the cache in the application. But the more often the unlikely
paths are taken, the more performance can be degraded. The
unlikely/likely paths in the ring access code are just not
unlikely/likely enough to warrant these annotations. They will occur
every time the locally cached values have to be refreshed from the
shared ones.

/Magnus

> >
> > Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  tools/lib/bpf/xsk.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/bpf/xsk.h b/tools/lib/bpf/xsk.h
> > index a497f00..3638147 100644
> > --- a/tools/lib/bpf/xsk.h
> > +++ b/tools/lib/bpf/xsk.h
> > @@ -105,7 +105,7 @@ static inline __u32 xsk_cons_nb_avail(struct xsk_ring_cons *r, __u32 nb)
> >  static inline size_t xsk_ring_prod__reserve(struct xsk_ring_prod *prod,
> >                                             size_t nb, __u32 *idx)
> >  {
> > -       if (unlikely(xsk_prod_nb_free(prod, nb) < nb))
> > +       if (xsk_prod_nb_free(prod, nb) < nb)
> >                 return 0;
> >
> >         *idx = prod->cached_prod;
> > @@ -129,7 +129,7 @@ static inline size_t xsk_ring_cons__peek(struct xsk_ring_cons *cons,
> >  {
> >         size_t entries = xsk_cons_nb_avail(cons, nb);
> >
> > -       if (likely(entries > 0)) {
> > +       if (entries > 0) {
> >                 /* Make sure we do not speculatively read the data before
> >                  * we have received the packet buffers from the ring.
> >                  */
> > --
> > 2.7.4
> >
