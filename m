Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF2C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 05:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B452147C
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 05:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHRu8vxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfBZFp1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:45:27 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43741 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBZFp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Feb 2019 00:45:27 -0500
Received: by mail-oi1-f195.google.com with SMTP id i8so9386695oib.10;
        Mon, 25 Feb 2019 21:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZMX9luGKi7gHYdneKnQu6cEgD/0QJSbk12gVsNJhAw=;
        b=EHRu8vxgsmuEWmd9u8L1+nJOylGzKQ0S/jVXcHw/Gu1KK7Yl6l8FWq7zi9p9uvEB+G
         dgzD7/OTJUfnSwV2H+AvBdMJjbcIAhAKDWFBsE2iz12kkTfdn1dy8KsgBv7OOqwiVyjr
         pIVNHgJnXTSP9KRUJ9BJFGncQzzowV6UhfQ2z+cc6nUIFmtBQ438SKuJEYtAqcgJtExz
         5YOc1wEWwwgcDueeFfO1JH5hahPM2MMVH1SGxwyShoY7oXxF1L6/bQ1s2koRNL2vMwFo
         wv6GzYy0BclxW3t18Ol2utwgvAyxLVuCstinNuDrtSVF0w0W6lVb70ZjamxCnCQiacDS
         48Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZMX9luGKi7gHYdneKnQu6cEgD/0QJSbk12gVsNJhAw=;
        b=I1yjVKbCqCAsC+tcNWmQha8IPU0T1UJ0aXD69XuV960LTTI6aPgty2rzCk6X250vXc
         TWLxUI37RAsmtyWd5df+HyPiOXgyT4MUCAjqTtf58n4bxjnW8ic+S33XCJSUhOUPbz2J
         mj+sTDVPA6nsAdHBbidc1DlAoHfIM/Yww2XyYs+J2tNM6lLiXzAMYH+Vo0OgTavmxXyv
         O1UgSpWn9nKFFCOnihZsQEcUnRY2JQLHciDQGXceGCnbf98toazcKC7gP/8ARQcRUlkr
         jnIcXJFxgVK6hz9INoPiO9QvDPgby9OyCYJsJP/2XTPTXnIyq2Q9mtIUP/u8CxHzssl2
         q8qg==
X-Gm-Message-State: AHQUAuY11lDr+Dg46w6hLEMvDMM0MRhmPKtvhWa+Z2RREe1HQ3yKyqTr
        RuE6FvFZon3pSaF4WzZlE8STh3zw2sHeLBTJGxg=
X-Google-Smtp-Source: AHgI3IYDyJFV8pbRZLK2IXgaqtMCwiinpihiYFDPitlGGBkVIj/tPVIdVa+xFnGuTwIaO4a0ashHLcK1zqAoKxnWAKw=
X-Received: by 2002:aca:3bd5:: with SMTP id i204mr1319698oia.167.1551159926278;
 Mon, 25 Feb 2019 21:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20190220205732.2514975-1-andriin@fb.com> <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
 <20190225200822.GB13100@kernel.org> <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
 <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com> <9033db30-1aab-69ae-dc2c-7dfa2585ead3@fb.com>
In-Reply-To: <9033db30-1aab-69ae-dc2c-7dfa2585ead3@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 21:45:14 -0800
Message-ID: <CAEf4BzZOC9O=ho2cdi2aY=BuXwcBBTO7zBCkW3zKbN7DMQ-a9Q@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 9:38 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/25/19 1:36 PM, Andrii Nakryiko wrote:
> > On Mon, Feb 25, 2019 at 12:51 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Mon, Feb 25, 2019 at 12:08 PM Arnaldo Carvalho de Melo
> >> <arnaldo.melo@gmail.com> wrote:
> >>>
> >>> Em Mon, Feb 25, 2019 at 11:42:29AM -0800, Andrii Nakryiko escreveu:
> >>>> On Mon, Feb 25, 2019 at 11:00 AM Arnaldo Carvalho de Melo> <arnaldo.melo@gmail.com> wrote:
> >>>
> >>>>> Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>>>> So yeah, the BTF encoder/decoder is working just fine, the problem is in
> >>>>>> pahole's DWARF code, lemme see...
> >>>>>
> >>>>> Please try the patch below, for me btfdiff continues to show no diff for
> >>>>> all types in my vmlinux and now it also produces the same output for
> >>>>> when the first element of a bitfield has its bit_size equal to its
> >>>>> byte_size * 8:
> >>>>
> >>>> Yes, this fixes all the issues I've seen. btfdiff output is now empty
> >>>> for my kernel image. Thanks for quick fix!
> >>>>
> >>>> Reviewed-by: Andrii Nakryiko <andriin@fb.com>
> >>>
> >>> Thanks, just for some extra testing I tried encoding BTF for glibc 2.28:
> >>>
> >>> [acme@quaco pahole]$ pahole -JV libc-2.28.so.debug
> >>> <BIG snip>
> >>
> >> <snip>
> >>
> >>> [386075] INT long unsigned int size=8 bit_offset=0 nr_bits=64 encoding=(none)
> >>> Cannot open libc-2.28.so.debug
> >>> Failed to encode BTF
> >>
> >> I've tried the same on libc-2.26.so.debug and it worked.
> >>
> >> It failes after BTF encoding and deduping is done, exactly when it
> >> tries to re-open libc-2.28.so.debug to write out new contents. Not
> >> sure why it would fail, as it seems to be just plain open() call, but
> >> the fact that we both can repro this means there is something there.
> >>
> >> It also seems that libc-2.28.so.debug is corrupted:
> >>
> >> $ readelf -n /home/andriin/local/btf/libc-2.26.so.debug | grep
> >> 'Unknown note type' | wc -l
> >> 0
> >> $ readelf -n /home/andriin/local/btf/libc-2.28.so.debug | grep
> >> 'Unknown note type' | wc -l
> >> 17953
> >>
> >
> > Ignore everything I've said (though 'Unknown note type' issue is
> > strange), for me it was just permissions issues.
> >
> > $ chmod +rw /home/andriin/local/btf/libc-2.28.so.debug
> >
> > $ ~/local/pahole/build/pahole -J ~/local/btf/libc-2.28.so.debug
> >
> > $ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/libc-2.28.so.debug
> > base_type__name_to_size: base_type _Float128
> > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > base_type__name_to_size: base_type _Float128
> > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > base_type__name_to_size: base_type _Float128
> > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > base_type__name_to_size: base_type _Float128
> > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > base_type__name_to_size: base_type _Float128
> > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > base_type__name_to_size: base_type _Float128
> > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > --- /tmp/btfdiff.dwarf.aV4wSL   2019-02-25 13:31:54.787923673 -0800
> > +++ /tmp/btfdiff.btf.22NQmJ     2019-02-25 13:31:54.802923668 -0800
> > @@ -461,9 +461,15 @@ struct La_x86_64_retval {
> >          uint64_t                   lrv_rdx;              /*     8     8 */
> >          La_x86_64_xmm              lrv_xmm0;             /*    16    16 */
> >          La_x86_64_xmm              lrv_xmm1;             /*    32    16 */
> > -       long double                lrv_st0;              /*    48    16 */
> > +       long double                lrv_st0;              /*    48     8 */
> > +
> > +       /* XXX 8 bytes hole, try to pack */
> > +
> >          /* --- cacheline 1 boundary (64 bytes) --- */
> > -       long double                lrv_st1;              /*    64    16 */
> > +       long double                lrv_st1;              /*    64     8 */
> > +
> > +       /* XXX 8 bytes hole, try to pack */
> > +
> >          La_x86_64_vector           lrv_vector0;          /*    80    64 */
> >          /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
> >          La_x86_64_vector           lrv_vector1;          /*   144    64 */
> > @@ -472,6 +478,7 @@ struct La_x86_64_retval {
> >          __int128                   lrv_bnd1;             /*   224    16 */
> >
> >          /* size: 240, cachelines: 4, members: 10 */
> > +       /* sum members: 224, holes: 2, sum holes: 16 */
> >          /* last cacheline: 48 bytes */
> >   };
> >   struct r_debug {
> > @@ -2044,7 +2051,7 @@ union ieee754_float {
> >          } ieee_nan;                                    /*     0     4 */
> >   };
> >   union ieee854_long_double {
> > -       long double                d;                  /*     0    16 */
> > +       long double                d;                  /*     0     8 */
> >          struct {
> >                  unsigned int       mantissa1:32;       /*     0: 0  4 */
> >                  unsigned int       mantissa0:32;       /*     4: 0  4 */
> > @@ -2141,7 +2148,7 @@ struct ucontext_t {
> >          /* last cacheline: 8 bytes */
> >   };
> >   union ieee854_float128 {
> > -       _Float128                  d;                  /*     0    16 */
> > +       _Float128                  d;                  /*     0     0 */
> >          struct {
> >                  unsigned int       mantissa3:32;       /*     0: 0  4 */
> >                  unsigned int       mantissa2:32;       /*     4: 0  4 */
> > @@ -2219,7 +2226,7 @@ union printf_arg {
> >          long unsigned int          pa_u_long_int;      /*     0     8 */
> >          long long unsigned int     pa_u_long_long_int; /*     0     8 */
> >          double                     pa_double;          /*     0     8 */
> > -       long double                pa_long_double;     /*     0    16 */
> > +       long double                pa_long_double;     /*     0     8 */
> >          const char  *              pa_string;          /*     0     8 */
> >          const wchar_t  *           pa_wstring;         /*     0     8 */
> >          void *                     pa_pointer;         /*     0     8 */
> >
> > Seems like "long double" size is invalid for BTF. And we should
> > probably add "_Float128" as another "well known" base type name?
>
> BPF does not support floating point instructions. As the result,
> BTF design does not contain floating point types.
>
> Looks like kernel also uses float types (in certain drivers and arch's),
> but types referred by bpf program mostly will not contain float types.
>
> Currently, both llvm and pahole will ignore floating types, so
> from type comparison point of view, we will be fine.
> The issue may come up with people using vmlinux BTF inside the
> kernel for different purpose where a float type needs to be
> specified, e.g., for a floating point function argument in ftrace.
> But this is rare too.
>
> I am not 100% sure whether pahole dwarf/btf parity is considered
> as a strong reason to add floating point type support in BTF or not.

Isn't float and double just another base type with corresponding name?
Fundamentally, how is it different from int or long? It's still just a
collection of bits in 32-bit, 64-bit, etc number, except interpreted
differently. Do you mean that for BTF to properly support floats,
we'll need to extends set of possible encodings in INT type (in
addition to today's CHAR, SIGNED and UNSIGNED)?

>
> >
> > Though for the latter, it probably would be better to resolve base
> > type size using BTF data itself.
> >
> >>> [acme@quaco pahole]$
