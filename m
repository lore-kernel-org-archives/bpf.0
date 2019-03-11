Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0864FC43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 16:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01D0205F4
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 16:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry7q3dcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfCKQfM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:35:12 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42071 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKQfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 12:35:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id i5so4502564oto.9;
        Mon, 11 Mar 2019 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdjBq4RMDunC52g+ZUwSJALcfkOxA2gRv01eUHJeXzE=;
        b=ry7q3dcZR4yg2DHopk4J9GkeciShrA4Ast+PMKnqxrWDzLPaj4xaYJAENK8F/Wi577
         wQoDxy2Eed5OajiksTQ3dz/McyI8bx/eya8JefML/P3RCJ8o0OF+fi8ACSjZ6p7P/h+u
         J4JHTCXLkKEqgJjYZwyHkm6Y0H0ZdNltN4mZ0/uUDwx3CMXOwJLrjxoMVJRkd0jGp1oi
         GMbpQI1LndWEYEPhtpLjVX6sa7se7Jdd/R5b4SKiIYtItnk6xpnIdkfLZJRSFDVcFnpU
         aMJXUmZEtBJWPD4KUR5vHfZUUCmfoY9LSmgrkFbMHcBP7tyvsNrsZA3JGzw3imB0zUbg
         6FFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdjBq4RMDunC52g+ZUwSJALcfkOxA2gRv01eUHJeXzE=;
        b=Cd8uYE+AvO2OOfy8VnKASwH3HaWnV8O3kzrhIc/+/ukeub4jwqwyntyPFDfjw4OtWi
         BZoZLx88Ztj7QUMNevYIUSFYwZ9UhPycoeantTW4truVAvesNTvN+fEy3ljCVjW38gaT
         I2l8mkOcWuOi7kK2O8+16lWOOsWWD7MWsYcQKluBrVLMLwsW2X+YnCrJkKe2CeIQgkpA
         jdOH23pxOuULgP1FP8AYBXCtjyu5yF8thoULnVmyY8O3CWZ+FKDPuuvfYM4ITuuBTQ4K
         DTICH1KSdQdnWJLpBGIyYcrKLMjVM1+ENLPdO1Y1qiRXavfDYQmaNwIUWoaxK82acn8f
         MnBA==
X-Gm-Message-State: APjAAAU6RIoFofQMsREay21AweJ6Hqet8dtrNYCRKvNYOhRA4dUcUWAx
        DpVjQI83hGIdZdJVE0CyAFhsuFgtD+6KK3suB+N26keFE9w=
X-Google-Smtp-Source: APXvYqyJe8OhBwmMjkGBmfbDsFFMkTTiri+liPL41+92p2cuXXIWMDe8efZVoOK7JWTT/i5nfUaKUjHy4WeAmDay9Hw=
X-Received: by 2002:a9d:2921:: with SMTP id d30mr21659803otb.75.1552322111014;
 Mon, 11 Mar 2019 09:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190311004410.3896503-1-andriin@fb.com> <20190311004410.3896503-2-andriin@fb.com>
 <755d4871-f8a1-ec31-02bf-87ffe82cdd56@fb.com>
In-Reply-To: <755d4871-f8a1-ec31-02bf-87ffe82cdd56@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Mar 2019 09:34:59 -0700
Message-ID: <CAEf4Bzbo1_mCN4wnGV+G8ombYPmSBNMQG7Qy8729Ji7HaKxV3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] btf: resolve enum fwds in btf_dedup
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 12:02 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/10/19 5:44 PM, Andrii Nakryiko wrote:
> > GCC and clang support enum forward declarations as an extension. Such
> > forward-declared enums will be represented as normal BTF_KIND_ENUM types with
> > vlen=0. This patch adds ability to resolve such enums to their corresponding
>
> Thanks Andrii for reporting and trying to fix forward-declared enum
> issue. The current approach to represent forward enum with
> BTF_KIND_ENUM with vlen = 0 does work. "enum A {};" is illegal for C,
> so vlen=0 must be a forward declaration.
>
> But this is probably not the best since we have BTF_KIND_FWD to make
> forward declaration explicit.

Yeah, that's true. See below, though, why for enum it's a bit inconvenient.

In retrospect, I'm wondering if having a special "declaration vs
definition" bit in btf_type->info for struct/union would be better
approach, kind of like DWARF's DW_AT_declaration attribute. But it's a
bit late now.

>
> Currently BTF_KIND_FWD uses (btf_type.info >> 31) to distinguish
> struct/union. If btf_type.info >> 31 == 0, it is a struct, otherwise
> it is a union.
>
> We could extend this to cover forward enum as well with backward
> compability. We can extend by using both bit 30 and bit 31:
>    btf_type.info >> 31   (btf_type.info >> 30) & 0x1
>          0                  0                  <== struct
>          1                  0                  <== union
>          0                  1                  <== enum
>
> Maybe this may be reasonable?

The only thing we should consider is that enums can have different
sizes. And enum size is part of enum's forward declaration. So unlike
struct/union fwd, enum's fwd has extra info. I don't think it's
possible to specify in C (enum is always 4 bytes), but C++ definitely
allows to specify custom underlying integer type.

So I don't know, do you think we should just ignore size and go with
BTF_KIND_FWD?

>
> This will require pahole and llvm change to support, besides kernel
> support. I will try to prototype llvm support tomorrow.
>
>
> > fully defined enums. This helps to avoid duplicated BTF type graphs which only
> > differ by some types referencing forward-declared enum vs full enum.
> >
> > One such example in kernel is enum irqchip_irq_state, defined in
> > include/linux/interrupt.h and forward-declared in include/linux/irq.h. This
> > causes entire struct task_struct and all referenced types to be duplicated in
> > btf_dedup output. This patch eliminates such duplication cases.
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >   tools/lib/bpf/btf.c | 51 +++++++++++++++++++++++++++++++++------------
> >   1 file changed, 38 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 1b8d8cdd3575..87e3020ac1bc 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1602,16 +1602,12 @@ static bool btf_equal_int(struct btf_type *t1, struct btf_type *t2)
> >   /* Calculate type signature hash of ENUM. */
> >   static __u32 btf_hash_enum(struct btf_type *t)
> >   {
> > -     struct btf_enum *member = (struct btf_enum *)(t + 1);
> > -     __u32 vlen = BTF_INFO_VLEN(t->info);
> > -     __u32 h = btf_hash_common(t);
> > -     int i;
> > +     __u32 h;
> >
> > -     for (i = 0; i < vlen; i++) {
> > -             h = hash_combine(h, member->name_off);
> > -             h = hash_combine(h, member->val);
> > -             member++;
> > -     }
> > +     /* don't hash vlen and enum members to support enum fwd resolving */
> > +     h = hash_combine(0, t->name_off);
> > +     h = hash_combine(h, t->info & ~0xffff);
> > +     h = hash_combine(h, t->size);
> >       return h;
> >   }
> >
> > @@ -1637,6 +1633,22 @@ static bool btf_equal_enum(struct btf_type *t1, struct btf_type *t2)
> >       return true;
> >   }
> >
> > +static inline bool btf_is_enum_fwd(struct btf_type *t)
> > +{
> > +     return BTF_INFO_KIND(t->info) == BTF_KIND_ENUM &&
> > +            BTF_INFO_VLEN(t->info) == 0;
> > +}
> > +
> > +static bool btf_compat_enum(struct btf_type *t1, struct btf_type *t2)
> > +{
> > +     if (!btf_is_enum_fwd(t1) && !btf_is_enum_fwd(t2))
> > +             return btf_equal_enum(t1, t2);
> > +     /* ignore vlen when comparing */
> > +     return t1->name_off == t2->name_off &&
> > +            (t1->info & ~0xffff) == (t2->info & ~0xffff) &&
> > +            t1->size == t2->size;
> > +}
> > +
> >   /*
> >    * Calculate type signature hash of STRUCT/UNION, ignoring referenced type IDs,
> >    * as referenced type IDs equivalence is established separately during type
> > @@ -1860,6 +1872,17 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
> >                               new_id = cand_node->type_id;
> >                               break;
> >                       }
> > +                     if (d->opts.dont_resolve_fwds)
> > +                             continue;
> > +                     if (btf_compat_enum(t, cand)) {
> > +                             if (btf_is_enum_fwd(t)) {
> > +                                     /* resolve fwd to full enum */
> > +                                     new_id = cand_node->type_id;
> > +                                     break;
> > +                             }
> > +                             /* resolve canonical enum fwd to full enum */
> > +                             d->map[cand_node->type_id] = type_id;
> > +                     }
> >               }
> >               break;
> >
> > @@ -2084,15 +2107,15 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> >               return fwd_kind == real_kind;
> >       }
> >
> > -     if (cand_type->info != canon_type->info)
> > -             return 0;
> > -
> >       switch (cand_kind) {
> >       case BTF_KIND_INT:
> >               return btf_equal_int(cand_type, canon_type);
> >
> >       case BTF_KIND_ENUM:
> > -             return btf_equal_enum(cand_type, canon_type);
> > +             if (d->opts.dont_resolve_fwds)
> > +                     return btf_equal_enum(cand_type, canon_type);
> > +             else
> > +                     return btf_compat_enum(cand_type, canon_type);
> >
> >       case BTF_KIND_FWD:
> >               return btf_equal_common(cand_type, canon_type);
> > @@ -2103,6 +2126,8 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
> >       case BTF_KIND_PTR:
> >       case BTF_KIND_TYPEDEF:
> >       case BTF_KIND_FUNC:
> > +             if (cand_type->info != canon_type->info)
> > +                     return 0;
> >               return btf_dedup_is_equiv(d, cand_type->type, canon_type->type);
> >
> >       case BTF_KIND_ARRAY: {
> >
