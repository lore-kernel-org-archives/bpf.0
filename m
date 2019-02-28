Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4441C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B2521850
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 00:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDEA5xgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfB1AJn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:09:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43189 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB1AJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 19:09:43 -0500
Received: by mail-ot1-f66.google.com with SMTP id n71so16090813ota.10;
        Wed, 27 Feb 2019 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAVYYrpG7Aw0p/PqKsAbsxmCB8jVh9kVdV+/ZiACkSA=;
        b=RDEA5xgAKyTMBFiNSq9dwEhrKomyZR+6x4lT42p94KtlPRgxKdXc/w8qhd4u0bTsuM
         iQIDCNzWYyps8/vIydHPg7Aign1AANlrYvqw2U3cMb51LWqCrVJ49SdIqKOspjyS0ppG
         jtJ57Hri+iSjTt6GeuV4zPUCJ5tBoWBLIkoi+ROFehj9GHMFa/qUt7fFm08V+26rYwZu
         MCjKqdAd/choNR+cY/w66hv90uhtuFFYa2FVHQUirRjJ80evIQXkFpYAU0WxhyEWwKJf
         pnFTack/IXbZz0lcCPED+ZLGYSvRD+BlFuMxFiA8Cc3d8ajX5wa6bm7uhRz12cNjRsf3
         MhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAVYYrpG7Aw0p/PqKsAbsxmCB8jVh9kVdV+/ZiACkSA=;
        b=qXrWjVRMCW5QomqAGfMLLDWN0W7AAgbveElCtva1gft2uLgmE95ERM5HBC2tkvAnww
         pIM/sPVujObNWf5jLz5gKVVt5xfUF3bDKk3A3zlEBbVCCy0xEX5neu9Kc7s/bhapRV7I
         M/lj/AjX10ihb9EltxNtVEkdruBvw0BzY8FImxESkT+8RoH6gF5d8bAruXfLcUeiUsuk
         a+g4PUZlpSzYxWaEi0DRbsVcjE0P+GJX8SqK2W/0JtxG+xHy9Fm8frTfY7OfSx77OAc1
         dvO3+l7e6cxZT2ZyjHJo/aOLs7EuRA8bzEOVNxAIXhN1fHLTpa3cc44F08fw35YzEG09
         4Lxw==
X-Gm-Message-State: AHQUAubNpSPTOU2DFeqrPlupuUgbmikI+rgzldrLE2i3FhjH7k3TfQw3
        x9+GWcC5yVqPKkGAZWK9cgZwmd6lm1JOo2NV3YI=
X-Google-Smtp-Source: AHgI3IZz8+1VQ9nwNYOH2llbzIYmrcFZRUVUAcobYKvgp3G3tQyW/PVs8maVfrb6cQwEmuEIribYOe40WeMayk2WpTs=
X-Received: by 2002:a9d:6c96:: with SMTP id c22mr3709349otr.38.1551312581999;
 Wed, 27 Feb 2019 16:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
 <20190227233046.11718-4-jakub.kicinski@netronome.com> <CAEf4BzZR+7R9TjXSMHiYzbHCvuwL+Z_LBD=Pk+rRW+X+pgdg4w@mail.gmail.com>
 <20190227155703.121514a2@cakuba.netronome.com>
In-Reply-To: <20190227155703.121514a2@cakuba.netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Feb 2019 16:09:30 -0800
Message-ID: <CAEf4BzaOa1TvHPM-qMic1jNn+qrC6aMS2+ad9n0M1xviY26g7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] tools: libbpf: add a correctly named define
 for map iteration
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 3:57 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Wed, 27 Feb 2019 15:47:56 -0800, Andrii Nakryiko wrote:
> > On Wed, Feb 27, 2019 at 3:31 PM Jakub Kicinski
> > <jakub.kicinski@netronome.com> wrote:
> > >
> > > For historical reasons the helper to loop over maps in an object
> > > is called bpf_map__for_each while it really should be called
> > > bpf_object__for_each_map.  Rename and add a correctly named
> > > define for backward compatibility.
> >
> > Seems like there are at least 3 more functions that are not named correctly:
> > - __bpf_map__iter (__bpf_object__iter_map?)
> > - bpf_map__next (=> bpf_object__next_map?)
> > - bpf_map__prev (=> bpf_object__prev_map?)
> >
> > Let's rename them as well?
>
> At least those are consistently named between programs and maps.
> I'm happy to do the rename if we don't need backward compat, seems
> a little much to add aliases?
>
> > > Switch all in-tree users to the correct name (Quentin).
> > >
> > > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > > Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
>
> > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > index 6c0168f8bba5..b4652aa1a58a 100644
> > > --- a/tools/lib/bpf/libbpf.h
> > > +++ b/tools/lib/bpf/libbpf.h
> > > @@ -278,10 +278,11 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
> > >
> > >  LIBBPF_API struct bpf_map *
> > >  bpf_map__next(struct bpf_map *map, struct bpf_object *obj);
> > > -#define bpf_map__for_each(pos, obj)            \
> > > +#define bpf_object__for_each_map(pos, obj)             \
> > >         for ((pos) = bpf_map__next(NULL, (obj));        \
> > >              (pos) != NULL;                             \
> > >              (pos) = bpf_map__next((pos), (obj)))
> > > +#define bpf_map__for_each bpf_object__for_each_map
> >
> > Should we get rid of this as well, instead of accumulating cruft?
>
> Well, we did some gymnastics in the past to maintain backward compat,
> I thought we do need it..?

I'll let others chime in, but, imo, it feels like while we are at
0.0.2 it might be worthwhile to streamline libbpf early on to reduce
confusion later at the expense of early adopters having to do
straightforward conversion right now.
