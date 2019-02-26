Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF08C10F0B
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C39221850
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 17:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnmEBPc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfBZRqE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:46:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39702 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfBZRqD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Feb 2019 12:46:03 -0500
Received: by mail-qt1-f196.google.com with SMTP id o6so15882035qtk.6;
        Tue, 26 Feb 2019 09:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rEgXRdIy7G2mozcoXIFc2VA53OPtgQdaj+5M6A0jNH0=;
        b=RnmEBPc2jPx+ZphB8wzJJCNiNV129o5pTQwVvCF+DB8sAcPh6XN3r+ygk2SNnvSLMf
         s9B6BGeM0Mj5EWFEbTdQ/d8PDKRTyYI5v6+UfWBmbXBCYHlLggYmMsVDC4/a5HMQMz7e
         7vV68Zjz5urpJXNQF5sObSxdN02UW7TUpZ6t2aNO9tD/4PLeWvblMDb6TJg7Nxooz7j1
         NyxGohrWGo81+WYoLLeLfKirlTfmMVthR+VCBOinc8I79I7/ee24SK7KfVbRd3KiaLwk
         vxPe8BcHXkyN69ureUcuDwnsrcXmS+jWIQjJ9UYZRLCRDpKrol7QP4bjraVK7be1EY15
         VbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rEgXRdIy7G2mozcoXIFc2VA53OPtgQdaj+5M6A0jNH0=;
        b=LUoKUym6gzr51Y/wpxXn2Jib3u4SzT9gq/LGsQJELB/eBu4cz3oqKK8rqhIhaLJoOi
         rVFXit5ABdwqwe0t6u2NNBGnJNfvYzdKlpFmY9jLbHzdGUZfV6QHPlsgg9qG3utu7M6x
         CFIQDVvMOkhpGLB2Os3pACiANsO2eGlF+ihQz+yJ8EXh360ZOqDW5Sxt5zmEJiw2Nem4
         jDuGtBanbQKdeZLxNohwis+awa6qwQVNwkY6RZif5lzBbjXGI1aseGfxiCyCet7JbVqc
         s6vDX21FBXAY7QKIE5oci/trIVTVDcDJvAlEF8/kdC1mxl1lf/3/TR2cBh25qpj6bAwT
         /Qqw==
X-Gm-Message-State: AHQUAubpiXAkEGN3aqXSNnfveZS1RvsrNb+MSoYu+Jh5X6FFPo3HWq58
        kid9KaSC/9VdXIDReE4hkvc=
X-Google-Smtp-Source: AHgI3Ib5Z/6PrQLywmUyDgLrYiYjx1eK4ch8zDmeSLUHWB0T1KbrsBxBpNQq9pJQMU0LwemZhjoKfA==
X-Received: by 2002:ac8:26a7:: with SMTP id 36mr19646475qto.234.1551203161704;
        Tue, 26 Feb 2019 09:46:01 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id c126sm7592866qke.4.2019.02.26.09.46.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 09:46:00 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E5CE4039C; Tue, 26 Feb 2019 14:45:57 -0300 (-03)
Date:   Tue, 26 Feb 2019 14:45:57 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling
 of bitfields in btf_loader
Message-ID: <20190226174557.GA3227@kernel.org>
References: <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org>
 <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
 <20190225200822.GB13100@kernel.org>
 <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
 <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
 <20190226131156.GA26786@kernel.org>
 <CAEf4Bzb8F+Z+dJu+raKYqv5swnDen-jzfmJkzOx_ki7pCfh3rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb8F+Z+dJu+raKYqv5swnDen-jzfmJkzOx_ki7pCfh3rQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Feb 26, 2019 at 09:14:57AM -0800, Andrii Nakryiko escreveu:
> On Tue, Feb 26, 2019 at 5:12 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, Feb 25, 2019 at 01:36:57PM -0800, Andrii Nakryiko escreveu:
> > > On Mon, Feb 25, 2019 at 12:51 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 25, 2019 at 12:08 PM Arnaldo Carvalho de Melo
> > > > <arnaldo.melo@gmail.com> wrote:
> > > > >
> > > > > Em Mon, Feb 25, 2019 at 11:42:29AM -0800, Andrii Nakryiko escreveu:
> > > > > > On Mon, Feb 25, 2019 at 11:00 AM Arnaldo Carvalho de Melo> <arnaldo.melo@gmail.com> wrote:
> > > > >
> > > > > > > Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > > > So yeah, the BTF encoder/decoder is working just fine, the problem is in
> > > > > > > > pahole's DWARF code, lemme see...
> > > > > > >
> > > > > > > Please try the patch below, for me btfdiff continues to show no diff for
> > > > > > > all types in my vmlinux and now it also produces the same output for
> > > > > > > when the first element of a bitfield has its bit_size equal to its
> > > > > > > byte_size * 8:
> > > > > >
> > > > > > Yes, this fixes all the issues I've seen. btfdiff output is now empty
> > > > > > for my kernel image. Thanks for quick fix!
> > > > > >
> > > > > > Reviewed-by: Andrii Nakryiko <andriin@fb.com>
> > > > >
> > > > > Thanks, just for some extra testing I tried encoding BTF for glibc 2.28:
> > > > >
> > > > > [acme@quaco pahole]$ pahole -JV libc-2.28.so.debug
> > > > > <BIG snip>
> > > >
> > > > <snip>
> > > >
> > > > > [386075] INT long unsigned int size=8 bit_offset=0 nr_bits=64 encoding=(none)
> > > > > Cannot open libc-2.28.so.debug
> > > > > Failed to encode BTF
> > > >
> > > > I've tried the same on libc-2.26.so.debug and it worked.
> > > >
> > > > It failes after BTF encoding and deduping is done, exactly when it
> > > > tries to re-open libc-2.28.so.debug to write out new contents. Not
> > > > sure why it would fail, as it seems to be just plain open() call, but
> > > > the fact that we both can repro this means there is something there.
> > > >
> > > > It also seems that libc-2.28.so.debug is corrupted:
> > > >
> > > > $ readelf -n /home/andriin/local/btf/libc-2.26.so.debug | grep
> > > > 'Unknown note type' | wc -l
> > > > 0
> > > > $ readelf -n /home/andriin/local/btf/libc-2.28.so.debug | grep
> > > > 'Unknown note type' | wc -l
> > > > 17953
> > > >
> > >
> > > Ignore everything I've said (though 'Unknown note type' issue is
> > > strange), for me it was just permissions issues.
> >
> > yeah, we need to fix up these messages, I did the chmod here and got
> > further.
> >
> > [acme@quaco pahole]$ ls -la libc-2.28.so.debug
> > -r--r--r--. 1 acme acme 17189368 Feb 25 17:04 libc-2.28.so.debug
> > [acme@quaco pahole]$ pahole -J libc-2.28.so.debug
> > Cannot open libc-2.28.so.debug
> > Failed to encode BTF
> > [acme@quaco pahole]$ chmod +w libc-2.28.so.debug
> > [acme@quaco pahole]$ ls -la libc-2.28.so.debug
> > -rw-rw-r--. 1 acme acme 17189368 Feb 25 17:04 libc-2.28.so.debug
> > [acme@quaco pahole]$ pahole -J libc-2.28.so.debug
> > [acme@quaco pahole]$
> >
> > And I get the same warnings.
> >
> > base_type__name_to_size: base_type _Float128
> >
> > If we just add _Float128 to the base_type__name_to_size arrays I think
> > its good enough for pretty printing, i.e. we won't know from encoding
> > that this is a float or double, as CTF and DWARF can, but for printing
> > purposes, even regenerating the type for consumption by other tools, it
> > should just work, no?
> 
> With "btf_loader: Simplify fixup code by relying on BTF data more" patch,
> btf_loader doesn't rely on this mapping at all. So if there is any other
> base type we didn't foresee, BTF output should still be correct.
> 
> > So, two bugs, the bit_size for "long double" is 128, not 64, and if we
> > add an entry for _Float128, then btfdiff is clean for libc, without any
> > further work on properly supporting float types as in CTF or DWARF:
> 
> My worry with this table (and one of the reasons for that patch to not use
> it at all) was that those sizeof() sizes might be correct for the
> architecture on which pahole was built, but not necessarily on the target
> arch for which ELF file was built. E.g., I don't know if it's true that

Right, that is why there are some entries with size zero, meaning they
need to be calculated based on the size of a pointer in the arch where
it was produced, not the one where it is beind processed.

But yeah, I even made a note about that in the cset I added fixing the
bit_size for "long double".

As you said, I have to look and see if we can use the same logic in DWARF
that you used for BTF and in the end just ditch this table completely.

- Arnaldo

> long double is always 128-bit on all architectures, so relying on that
> table might still break output for CTF and DWARF (but not BTF, because it
> takes bitness from BTF data itself).
> 
> But otherwise it's still good thing to complete that table.
> 
> >
> > [acme@quaco pahole]$ btfdiff libc-2.28.so.debug
> > [acme@quaco pahole]$ git diff
> > diff --git a/dwarves.c b/dwarves.c
> > index adc411a8279d..48a018a9c354 100644
> > --- a/dwarves.c
> > +++ b/dwarves.c
> > @@ -168,11 +168,12 @@ static struct base_type_name_to_size {
> >         { .name = "double double",          .size = 64, },
> >         { .name = "single float",           .size = 32, },
> >         { .name = "float",                  .size = 32, },
> > -       { .name = "long double",            .size = 64, },
> > -       { .name = "long double long double", .size = 64, },
> > +       { .name = "long double",            .size = sizeof(long double) * 8, },
> > +       { .name = "long double long double", .size = sizeof(long double) * 8, },
> >         { .name = "__int128",               .size = 128, },
> >         { .name = "unsigned __int128",      .size = 128, },
> >         { .name = "__int128 unsigned",      .size = 128, },
> > +       { .name = "_Float128",              .size = 128, },
> >         { .name = NULL },
> >  };
> >
> > [acme@quaco pahole]$
> >
> > I'll add a series of patches fixing up the types that don't have encoded
> > in its name the size in bits, so that it works on all arches, one more
> > for _Float128, should be enough for now, right?
> >
> > - Arnaldo
> >
> > > $ chmod +rw /home/andriin/local/btf/libc-2.28.so.debug
> > >
> > > $ ~/local/pahole/build/pahole -J ~/local/btf/libc-2.28.so.debug
> > >
> > > $ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/libc-2.28.so.debug
> > > base_type__name_to_size: base_type _Float128
> > > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > > base_type__name_to_size: base_type _Float128
> > > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > > base_type__name_to_size: base_type _Float128
> > > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > > base_type__name_to_size: base_type _Float128
> > > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > > base_type__name_to_size: base_type _Float128
> > > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > > base_type__name_to_size: base_type _Float128
> > > class__fixup_btf_bitfields: unknown base type name "_Float128"!
> > > --- /tmp/btfdiff.dwarf.aV4wSL   2019-02-25 13:31:54.787923673 -0800
> > > +++ /tmp/btfdiff.btf.22NQmJ     2019-02-25 13:31:54.802923668 -0800
> > > @@ -461,9 +461,15 @@ struct La_x86_64_retval {
> > >         uint64_t                   lrv_rdx;              /*     8     8 */
> > >         La_x86_64_xmm              lrv_xmm0;             /*    16    16 */
> > >         La_x86_64_xmm              lrv_xmm1;             /*    32    16 */
> > > -       long double                lrv_st0;              /*    48    16 */
> > > +       long double                lrv_st0;              /*    48     8 */
> > > +
> > > +       /* XXX 8 bytes hole, try to pack */
> > > +
> > >         /* --- cacheline 1 boundary (64 bytes) --- */
> > > -       long double                lrv_st1;              /*    64    16 */
> > > +       long double                lrv_st1;              /*    64     8 */
> > > +
> > > +       /* XXX 8 bytes hole, try to pack */
> > > +
> > >         La_x86_64_vector           lrv_vector0;          /*    80    64 */
> > >         /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
> > >         La_x86_64_vector           lrv_vector1;          /*   144    64 */
> > > @@ -472,6 +478,7 @@ struct La_x86_64_retval {
> > >         __int128                   lrv_bnd1;             /*   224    16 */
> > >
> > >         /* size: 240, cachelines: 4, members: 10 */
> > > +       /* sum members: 224, holes: 2, sum holes: 16 */
> > >         /* last cacheline: 48 bytes */
> > >  };
> > >  struct r_debug {
> > > @@ -2044,7 +2051,7 @@ union ieee754_float {
> > >         } ieee_nan;                                    /*     0     4 */
> > >  };
> > >  union ieee854_long_double {
> > > -       long double                d;                  /*     0    16 */
> > > +       long double                d;                  /*     0     8 */
> > >         struct {
> > >                 unsigned int       mantissa1:32;       /*     0: 0  4 */
> > >                 unsigned int       mantissa0:32;       /*     4: 0  4 */
> > > @@ -2141,7 +2148,7 @@ struct ucontext_t {
> > >         /* last cacheline: 8 bytes */
> > >  };
> > >  union ieee854_float128 {
> > > -       _Float128                  d;                  /*     0    16 */
> > > +       _Float128                  d;                  /*     0     0 */
> > >         struct {
> > >                 unsigned int       mantissa3:32;       /*     0: 0  4 */
> > >                 unsigned int       mantissa2:32;       /*     4: 0  4 */
> > > @@ -2219,7 +2226,7 @@ union printf_arg {
> > >         long unsigned int          pa_u_long_int;      /*     0     8 */
> > >         long long unsigned int     pa_u_long_long_int; /*     0     8 */
> > >         double                     pa_double;          /*     0     8 */
> > > -       long double                pa_long_double;     /*     0    16 */
> > > +       long double                pa_long_double;     /*     0     8 */
> > >         const char  *              pa_string;          /*     0     8 */
> > >         const wchar_t  *           pa_wstring;         /*     0     8 */
> > >         void *                     pa_pointer;         /*     0     8 */
> > >
> > > Seems like "long double" size is invalid for BTF. And we should
> > > probably add "_Float128" as another "well known" base type name?
> > >
> > > Though for the latter, it probably would be better to resolve base
> > > type size using BTF data itself.
> > >
> > > > > [acme@quaco pahole]$
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
