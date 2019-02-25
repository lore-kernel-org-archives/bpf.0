Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD90C10F00
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89079217F5
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uN9oUAnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfBYViY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:38:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45636 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732645AbfBYVhJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id t82so8537291oie.12;
        Mon, 25 Feb 2019 13:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+PJHcecBPZdXNhMs2XMXGJhSN2qxdwUYLLBwc3OsbU=;
        b=uN9oUAnx1u0l4aZROkrmPZ1aRHSE8qRPJRQZLC73rOaZ9CVMDuc6uZq3ehQJeZD5pd
         oNpgOtTjQXkGLWC6d5qjbhhtQZCl6nKj7yQCbpQKfNE4xqUb1mkLuKPYpOusJKp/EWeI
         SNGexfjenglzNcXwioEqGz1u39XrmMdBE5XsNFXpWj5j7Rle+Sk/Dca+ncjmIZeMnigQ
         7osxG7AL7xSssXr9tRfgnoXru6yi1su432ClRHbpRAOW1VyaQvRZHiczOaQkJSJULLTS
         jbcSkt6bMEjeUXirqVougQ557VqKv7uHP/VJ3fbpCAHjoxg2qUWhxhF1yCxem3L5Nc7z
         s3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+PJHcecBPZdXNhMs2XMXGJhSN2qxdwUYLLBwc3OsbU=;
        b=StVxN6enbZ3jKALvRbqgEU+S0Dm23bLfNeRPOBXasqstxLuM+wIEnANd7E3OlKK8HK
         9dHtcnYmMxy5guMPkROuPuJuukmLVb9CEM+b2m8dHPEKoJ0QthMFigQgh+ovTiPXDk2E
         LVBNxKRt5yDsW9hoIFUbdqmRn9agkcEqmEYXXhoDPk3on9JARnVyRxn7EL7Udf7WeiL+
         ia0VAjU9FP0Ovmc3pMw8J+XJtv6cKmsgKQCijW4DdgS25u3x8z9CpoekVOmu7iXCjW9m
         kFR+enHRFjO8jVvRyfz8KAbzfaNEY3J+vlvXG+EaJe01C/IBQW59Ty1/MAfn/qYKls4j
         eF9g==
X-Gm-Message-State: AHQUAuaJsn+arIDII/2HZT2y1QzjLVmlAmqynLFcKizBuqGzAM3JBNTU
        qi0ZeJXtqtqU8rdBCOYj8uTZ7tQB7tWFOFdFPoB6UmtAIdU=
X-Google-Smtp-Source: AHgI3IY9NmW5+1B0hhRVGIJWEZ9l6XVNygrdfhccCVuTucbKFCe+CpPwbXtrMiTErpC2pBNO/irSb1pnaJ4jb6u39Gk=
X-Received: by 2002:aca:abcf:: with SMTP id u198mr254218oie.55.1551130627961;
 Mon, 25 Feb 2019 13:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20190220205732.2514975-1-andriin@fb.com> <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
 <20190225200822.GB13100@kernel.org> <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 13:36:57 -0800
Message-ID: <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
Subject: Re: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling of
 bitfields in btf_loader
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 12:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 25, 2019 at 12:08 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Mon, Feb 25, 2019 at 11:42:29AM -0800, Andrii Nakryiko escreveu:
> > > On Mon, Feb 25, 2019 at 11:00 AM Arnaldo Carvalho de Melo> <arnaldo.melo@gmail.com> wrote:
> >
> > > > Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > So yeah, the BTF encoder/decoder is working just fine, the problem is in
> > > > > pahole's DWARF code, lemme see...
> > > >
> > > > Please try the patch below, for me btfdiff continues to show no diff for
> > > > all types in my vmlinux and now it also produces the same output for
> > > > when the first element of a bitfield has its bit_size equal to its
> > > > byte_size * 8:
> > >
> > > Yes, this fixes all the issues I've seen. btfdiff output is now empty
> > > for my kernel image. Thanks for quick fix!
> > >
> > > Reviewed-by: Andrii Nakryiko <andriin@fb.com>
> >
> > Thanks, just for some extra testing I tried encoding BTF for glibc 2.28:
> >
> > [acme@quaco pahole]$ pahole -JV libc-2.28.so.debug
> > <BIG snip>
>
> <snip>
>
> > [386075] INT long unsigned int size=8 bit_offset=0 nr_bits=64 encoding=(none)
> > Cannot open libc-2.28.so.debug
> > Failed to encode BTF
>
> I've tried the same on libc-2.26.so.debug and it worked.
>
> It failes after BTF encoding and deduping is done, exactly when it
> tries to re-open libc-2.28.so.debug to write out new contents. Not
> sure why it would fail, as it seems to be just plain open() call, but
> the fact that we both can repro this means there is something there.
>
> It also seems that libc-2.28.so.debug is corrupted:
>
> $ readelf -n /home/andriin/local/btf/libc-2.26.so.debug | grep
> 'Unknown note type' | wc -l
> 0
> $ readelf -n /home/andriin/local/btf/libc-2.28.so.debug | grep
> 'Unknown note type' | wc -l
> 17953
>

Ignore everything I've said (though 'Unknown note type' issue is
strange), for me it was just permissions issues.

$ chmod +rw /home/andriin/local/btf/libc-2.28.so.debug

$ ~/local/pahole/build/pahole -J ~/local/btf/libc-2.28.so.debug

$ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/libc-2.28.so.debug
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
base_type__name_to_size: base_type _Float128
class__fixup_btf_bitfields: unknown base type name "_Float128"!
--- /tmp/btfdiff.dwarf.aV4wSL   2019-02-25 13:31:54.787923673 -0800
+++ /tmp/btfdiff.btf.22NQmJ     2019-02-25 13:31:54.802923668 -0800
@@ -461,9 +461,15 @@ struct La_x86_64_retval {
        uint64_t                   lrv_rdx;              /*     8     8 */
        La_x86_64_xmm              lrv_xmm0;             /*    16    16 */
        La_x86_64_xmm              lrv_xmm1;             /*    32    16 */
-       long double                lrv_st0;              /*    48    16 */
+       long double                lrv_st0;              /*    48     8 */
+
+       /* XXX 8 bytes hole, try to pack */
+
        /* --- cacheline 1 boundary (64 bytes) --- */
-       long double                lrv_st1;              /*    64    16 */
+       long double                lrv_st1;              /*    64     8 */
+
+       /* XXX 8 bytes hole, try to pack */
+
        La_x86_64_vector           lrv_vector0;          /*    80    64 */
        /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
        La_x86_64_vector           lrv_vector1;          /*   144    64 */
@@ -472,6 +478,7 @@ struct La_x86_64_retval {
        __int128                   lrv_bnd1;             /*   224    16 */

        /* size: 240, cachelines: 4, members: 10 */
+       /* sum members: 224, holes: 2, sum holes: 16 */
        /* last cacheline: 48 bytes */
 };
 struct r_debug {
@@ -2044,7 +2051,7 @@ union ieee754_float {
        } ieee_nan;                                    /*     0     4 */
 };
 union ieee854_long_double {
-       long double                d;                  /*     0    16 */
+       long double                d;                  /*     0     8 */
        struct {
                unsigned int       mantissa1:32;       /*     0: 0  4 */
                unsigned int       mantissa0:32;       /*     4: 0  4 */
@@ -2141,7 +2148,7 @@ struct ucontext_t {
        /* last cacheline: 8 bytes */
 };
 union ieee854_float128 {
-       _Float128                  d;                  /*     0    16 */
+       _Float128                  d;                  /*     0     0 */
        struct {
                unsigned int       mantissa3:32;       /*     0: 0  4 */
                unsigned int       mantissa2:32;       /*     4: 0  4 */
@@ -2219,7 +2226,7 @@ union printf_arg {
        long unsigned int          pa_u_long_int;      /*     0     8 */
        long long unsigned int     pa_u_long_long_int; /*     0     8 */
        double                     pa_double;          /*     0     8 */
-       long double                pa_long_double;     /*     0    16 */
+       long double                pa_long_double;     /*     0     8 */
        const char  *              pa_string;          /*     0     8 */
        const wchar_t  *           pa_wstring;         /*     0     8 */
        void *                     pa_pointer;         /*     0     8 */

Seems like "long double" size is invalid for BTF. And we should
probably add "_Float128" as another "well known" base type name?

Though for the latter, it probably would be better to resolve base
type size using BTF data itself.

> > [acme@quaco pahole]$
