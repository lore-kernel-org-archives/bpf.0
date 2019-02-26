Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434DCC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C28217F9
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 17:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH6NYFID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfBZReh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:34:37 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46846 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfBZReh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Feb 2019 12:34:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id j135so11012591oib.13;
        Tue, 26 Feb 2019 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bTuz0/Ws8HRdNNWmXSWKUmhVADlDvq37iU+LYWvOXjs=;
        b=DH6NYFID7wADTpedVGZGmz6Ab97nEeP+4kJgVv6eNlaaq3hFk6PKclCuJ5RxZId1JF
         1c8tAcXmLA8gjckklPZSkdkQ9ui+uh3pnSxFKdLr/Xow6xGYeXlYczodj8r+mrFrPExF
         xfd2ST8fuwgdOsxm/NRh1S5mFeO3L+f5t0G21xWKV1QZ2GX2XFyb6xTK1CAFwK3jBjcv
         NScup9AddeJep8dxnUmb5+njWANKgCmehWGuKP9qwJxCUpt08Z4Mk2LaU2MY31jyQH09
         03TWI1oZP5vSG2HNDPnJ4PyVzi3mdzngx43KyYlbMiuBW+RfTlwz7vfSEKSXjkYAnOLZ
         dOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bTuz0/Ws8HRdNNWmXSWKUmhVADlDvq37iU+LYWvOXjs=;
        b=cZ34MHluJjxQcbi9/L2gJSSODx7GWLb4Hsa2gDPDhv1dn7c/SeF056wfLMaHVYnbLt
         Bx4YDzh2uHY5MGXOo+tYxUDVHH2ncF/vZvIjHRzN+eGPeq+pBhVQboVJNnL+porFAvoX
         VqRP/FbNGqIRjl/iGtJSr/sRnSZCdvQ3YwHyTNHoPPy74QhtfokYALytHrFLd3N4xauh
         XKm73BPYZmfTzokCqnppsfHiYd3E74gqWEDPc7amDZ2XB2kK/XLeqB09W/hPTnnVCvMt
         XuquetuVx9dW8vs+DZcGVb5CaXK1MhFfgDkhzU46at+C64I+8brWkv5meoi/bqgZb+Oo
         OHfA==
X-Gm-Message-State: AHQUAuYBGmfPpGmPA9D3Fl00+110qLDbNN4yXrVC1Kt0j7wr6sGcxzIf
        DBtvJl1spsbjrg+2pq91mkEOtrf+oYhbyJ+i+Cw=
X-Google-Smtp-Source: AHgI3Iba2AO0yeINmdCUjNz3KOcN1XW74kz5aegTi6h9U5AAgx3V3G0wW64J5PbKmW25vwsBQ4V8yieugMpzQAzqva0=
X-Received: by 2002:aca:3bd5:: with SMTP id i204mr3156867oia.167.1551202476299;
 Tue, 26 Feb 2019 09:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20190220205732.2514975-1-andriin@fb.com> <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
 <20190225200822.GB13100@kernel.org> <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
 <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
 <9033db30-1aab-69ae-dc2c-7dfa2585ead3@fb.com> <CAEf4BzZOC9O=ho2cdi2aY=BuXwcBBTO7zBCkW3zKbN7DMQ-a9Q@mail.gmail.com>
 <00483f56-1bb8-6b6b-c408-f6d37cc58764@fb.com> <CAEf4Bzb-L1Cu6y6GKH0gYv611EA1qmvk=h=cnndtqEGydRwhNw@mail.gmail.com>
 <5183cb3f-4ab9-f7d6-6148-71856435569a@fb.com>
In-Reply-To: <5183cb3f-4ab9-f7d6-6148-71856435569a@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 Feb 2019 09:34:24 -0800
Message-ID: <CAEf4BzYESLKbQs3WxC6cGtjGVEJjCFjmO5bxBfwchJSA33XGgA@mail.gmail.com>
Subject: Re: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling of
 bitfields in btf_loader
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 26, 2019 at 9:25 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/26/19 9:22 AM, Andrii Nakryiko wrote:
> > On Mon, Feb 25, 2019 at 10:03 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 2/25/19 9:45 PM, Andrii Nakryiko wrote:
> >>> On Mon, Feb 25, 2019 at 9:38 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2/25/19 1:36 PM, Andrii Nakryiko wrote:
> >>>>> On Mon, Feb 25, 2019 at 12:51 PM Andrii Nakryiko
> >>>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>>>
> >>>>>> On Mon, Feb 25, 2019 at 12:08 PM Arnaldo Carvalho de Melo
> >>>>>> <arnaldo.melo@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Em Mon, Feb 25, 2019 at 11:42:29AM -0800, Andrii Nakryiko escreveu:
> >>>>>>>> On Mon, Feb 25, 2019 at 11:00 AM Arnaldo Carvalho de Melo> <arnaldo.melo@gmail.com> wrote:
> >>>>>>>
> >>>>>>>>> Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>>>>>>>> So yeah, the BTF encoder/decoder is working just fine, the problem is in
> >>>>>>>>>> pahole's DWARF code, lemme see...
> >>>>>>>>>
> >>>>>>>>> Please try the patch below, for me btfdiff continues to show no diff for
> >>>>>>>>> all types in my vmlinux and now it also produces the same output for
> >>>>>>>>> when the first element of a bitfield has its bit_size equal to its
> >>>>>>>>> byte_size * 8:
> >>>>>>>>
> >>>>>>>> Yes, this fixes all the issues I've seen. btfdiff output is now empty
> >>>>>>>> for my kernel image. Thanks for quick fix!
> >>>>>>>>
> >>>>>>>> Reviewed-by: Andrii Nakryiko <andriin@fb.com>
> >>>>>>>
> >>>>>>> Thanks, just for some extra testing I tried encoding BTF for glibc 2.28:
> >>>>>>>
> >>>>>>> [acme@quaco pahole]$ pahole -JV libc-2.28.so.debug
> >>>>>>> <BIG snip>
> >>>>>>
> >>>>>> <snip>
> >>>>>>
> >
> > <snip>
> >
> >>>>>
> >>>>> Seems like "long double" size is invalid for BTF. And we should
> >>>>> probably add "_Float128" as another "well known" base type name?
> >>>>
> >>>> BPF does not support floating point instructions. As the result,
> >>>> BTF design does not contain floating point types.
> >>>>
> >>>> Looks like kernel also uses float types (in certain drivers and arch's),
> >>>> but types referred by bpf program mostly will not contain float types.
> >>>>
> >>>> Currently, both llvm and pahole will ignore floating types, so
> >>>> from type comparison point of view, we will be fine.
> >>>> The issue may come up with people using vmlinux BTF inside the
> >>>> kernel for different purpose where a float type needs to be
> >>>> specified, e.g., for a floating point function argument in ftrace.
> >>>> But this is rare too.
> >>>>
> >>>> I am not 100% sure whether pahole dwarf/btf parity is considered
> >>>> as a strong reason to add floating point type support in BTF or not.
> >>>
> >>> Isn't float and double just another base type with corresponding name?
> >>> Fundamentally, how is it different from int or long? It's still just a
> >>> collection of bits in 32-bit, 64-bit, etc number, except interpreted
> >>> differently. Do you mean that for BTF to properly support floats,
> >>> we'll need to extends set of possible encodings in INT type (in
> >>> addition to today's CHAR, SIGNED and UNSIGNED)?
> >>
> >> Probably another kind like BTF_KIND_FLOAT with additional u32 (in
> >> addition to btf_type) indicating the size (4 bytes, 8 bytes and 16 bytes).
> >
> > This sounds exactly like current format of BTF_KIND_INT. What
> > BTF_KIND_FLOAT will have that can't be represented by BTF_KIND_INT?
> > Wouldn't it be equivalent to just adding BTF_INT_FLOAT in addition to
> > existing BTF_INT_SIGNED, BTF_INT_CHAR, BTF_INT_BOOL to
> > BTF_INT_ENCODING? Btw, while BTF_INT_SIGNED seems like it deserves
> > separate bit, because it's mostly orthogonal to CHAR vs INT vs FLOAT
> > vs (not so much) BOOL, BTF_INT_CHAR and BTF_INT_BOOL take two
> > independent bits seems excessive. You can't have BOOL and CHAR, right?
> > So why don't we just repurpose bits 1 and 2 to be a small 4-value
> > enum:
> >
> > enum btf_int_encoding {
> >      INT = 0,
> >      CHAR = 1,
> >      BOOL = 2,
> >      FLOAT = 3,
> > };
> >
> > This is backwards compatible and covers all floats (long double vs
> > double vs float is just a question of bitness).
> >
> > Am I missing something here?
>
> float is not an "int". Encoding "float" in INT_KIND does not sound right
> in my opinion.

So isn't "bool". But in the end, it's just a collection of bits that
are interpreted according to some encoding based on convention. From
application perspective, none of float, int or bool has any more
structure, those are "opaque" values. So maybe name BTF_KIND_INT is a
bit unfortunate, it should be more like BTF_KIND_PRIMITIVE or
something (or in pahole's lingo: base type).

>
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> Though for the latter, it probably would be better to resolve base
> >>>>> type size using BTF data itself.
> >>>>>
> >>>>>>> [acme@quaco pahole]$
