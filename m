Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138D1C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 03:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FE420851
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 03:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKJo1wHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfB1DtX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:49:23 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33083 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfB1DtX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 22:49:23 -0500
Received: by mail-oi1-f194.google.com with SMTP id z14so15447898oid.0;
        Wed, 27 Feb 2019 19:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcLVGmOTnvFkf2yTAO9jXVKBrkxyLFZ/9uNjnD70G3M=;
        b=aKJo1wHtWzOjtTgRnMILkU96UXZOYmb04ONn/GvfkSirDdFpr5azAA2R7XJaqxnso4
         3FKh3zN7TI0wNVeXbvZcWMf4wNwnTYQu0higfDTqGjLXQnDRQXPI2neIVCcpEu61JgAa
         8BKXkz/CXRFF6IRuM5AQZmXOVu8PhKPJeUp6wAZmaz1UTvVyS4qd9dtaD/X+hzsR2E4x
         3CmQ731ACoWd2NGiTjSx40mEfxYu3bMWPqMHejBgwpkoMYlFqj8xdrFS2fPd/QYgrVuL
         ZIclAHUTlhBZlbanNmYUDeKh482xloEvBH1/ioqVoV9XaSdSNff65iRBBtQaQ6l3v/P8
         w6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcLVGmOTnvFkf2yTAO9jXVKBrkxyLFZ/9uNjnD70G3M=;
        b=Gkk5ccAjcHIstChPRFDX/SFHmhrt9AhMsGiPgq4nqCHXbqMaEoV525HKaTKiDqXb6a
         wkycTxLXevWmYrxLpME4+3+8YDuUedcM80fxkuyVWixaA4tbFRYGheGgQPHCl28mETa5
         +km0FVCP+hKdxvHcWIv7IfKb3/xLA4svXQ7kXR5pmvF57wu7fdq2FaB8kM9hZZow0jlt
         O8L9rWjVt40MsGJi/21FnPpqth+pODJvtlqODwYyADERyl528Jg6pJd8Daa56EoO6P4h
         oge9bVWTV4JKB6ivlzfYm6MuHYoPj0FEwUeaUd6qb6fbfB/IPdtpC6nCQyr5ZsXPvCEy
         qSng==
X-Gm-Message-State: AHQUAuY1j28mejMV7XTq/ggTKFRnoA6edKkoFC+Pefd1JBcL5q4U1gXn
        z4K+u2SHa7MaJ3+zIeea7TXb+VFZsgN6rF3CF6o=
X-Google-Smtp-Source: APXvYqwzxkQYwq8f6V7HuQMbKv2bKhsI2p8IwM8aWO2LtQVERW6stkMwUnAIZqyEOhCJ4MwX6RdGtM++Y+gjq7SffLw=
X-Received: by 2002:aca:3e54:: with SMTP id l81mr1673384oia.10.1551325761980;
 Wed, 27 Feb 2019 19:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20190227233046.11718-1-jakub.kicinski@netronome.com>
 <20190227233046.11718-4-jakub.kicinski@netronome.com> <CAEf4BzZR+7R9TjXSMHiYzbHCvuwL+Z_LBD=Pk+rRW+X+pgdg4w@mail.gmail.com>
 <20190227155703.121514a2@cakuba.netronome.com> <20190228024715.ijjki2fleuunxydn@ast-mbp>
In-Reply-To: <20190228024715.ijjki2fleuunxydn@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Feb 2019 19:49:10 -0800
Message-ID: <CAEf4BzZuOeUXKUmMqukQm2M1eTnX2=JwkNyfwF5FvbMEuby9BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] tools: libbpf: add a correctly named define
 for map iteration
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 27, 2019 at 6:47 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 27, 2019 at 03:57:03PM -0800, Jakub Kicinski wrote:
> > On Wed, 27 Feb 2019 15:47:56 -0800, Andrii Nakryiko wrote:
> > > On Wed, Feb 27, 2019 at 3:31 PM Jakub Kicinski
> > > <jakub.kicinski@netronome.com> wrote:
> > > >
> > > > For historical reasons the helper to loop over maps in an object
> > > > is called bpf_map__for_each while it really should be called
> > > > bpf_object__for_each_map.  Rename and add a correctly named
> > > > define for backward compatibility.
> > >
> > > Seems like there are at least 3 more functions that are not named correctly:
> > > - __bpf_map__iter (__bpf_object__iter_map?)
> > > - bpf_map__next (=> bpf_object__next_map?)
> > > - bpf_map__prev (=> bpf_object__prev_map?)
> > >
> > > Let's rename them as well?
> >
> > At least those are consistently named between programs and maps.
>
> I think this patch makes naming consistent enough.
>
> > I'm happy to do the rename if we don't need backward compat, seems
> > a little much to add aliases?
> >
> > > > Switch all in-tree users to the correct name (Quentin).
> > > >
> > > > Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > > > Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
> >
> > > > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > > > index 6c0168f8bba5..b4652aa1a58a 100644
> > > > --- a/tools/lib/bpf/libbpf.h
> > > > +++ b/tools/lib/bpf/libbpf.h
> > > > @@ -278,10 +278,11 @@ bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
> > > >
> > > >  LIBBPF_API struct bpf_map *
> > > >  bpf_map__next(struct bpf_map *map, struct bpf_object *obj);
> > > > -#define bpf_map__for_each(pos, obj)            \
> > > > +#define bpf_object__for_each_map(pos, obj)             \
> > > >         for ((pos) = bpf_map__next(NULL, (obj));        \
> > > >              (pos) != NULL;                             \
> > > >              (pos) = bpf_map__next((pos), (obj)))
> > > > +#define bpf_map__for_each bpf_object__for_each_map
> > >
> > > Should we get rid of this as well, instead of accumulating cruft?
> >
> > Well, we did some gymnastics in the past to maintain backward compat,
> > I thought we do need it..?
>
> We do need to keep backward compat.
> This line is necessary.
>
> imo this set looks good to me as-is.
>

bpf_map__next/prev and bpf_program__next/prev convention feels a bit
weird, they fill more like methods of bpf_object rather than methods
of bpf_map and bpf_program, but I can understand why we might want to
preserve them.

Would it make sense to still add bpf_object__{next,prev}_{map,program}
(with struct bpf_object as a first arg) and just call them from
bpf_{map,program}__{next,prev}? That way we'll have consistent naming
that follows libbpf's own naming guidelines and we'll preserve
backwards compatibility? We can do that in follow up patches, if at
all, so I'll ack this patch.


Acked-by: Andrii Nakryiko <andriin@fb.com>
