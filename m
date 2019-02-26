Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E18C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 00:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A932184E
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 00:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjiiW5m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfBZAe3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:34:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39380 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfBZAe3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 19:34:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id e15so52698otk.6;
        Mon, 25 Feb 2019 16:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRIr3U7ypK8d++LIZdKekRDIwmleB8I0keOIa3xdKmI=;
        b=rjiiW5m0Btx8QKo9UImSGKMJi1j7WDz2N6BbS+qf7VKMTbZRsMvPK9m7Il/g0NKx/J
         CtT6ejMfHCb540s01XVQbyioonUckq0Vkd2nAYWQEeWyckfIkA+NjUmOlhTPxaNspMrf
         xOA/6ypz8ABfOy+/loBU5B0jNA5b2r9I+vDzZPEvwKQxWVgXrQmgG9GW9ZT7o8wnvwN2
         wlQOZEi/GDzrJniMspsHb1EQU5WvPmc1a8ZPIkJ7Kl9c1qEjzL/N0MmibPHK/NqlMeOJ
         XWftUJdlJMcmqMxlTxv4APAcCuf64C/f6ZnGanQKsGgTOgWOTeKfBZrz7TV7s9ZMdI8x
         onIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRIr3U7ypK8d++LIZdKekRDIwmleB8I0keOIa3xdKmI=;
        b=L+GOqNmV6w+W0XwBglHSse4xyRRgu5k/SGqWfJ/rAwnlh5rB/y/4bS5flvwwwW7J1s
         aXH1+S9Q7z2s47tNgY8hOCbBWojvHKNxmMXFgbh8WbFPaPeXAobfOwv4zQeRCHWYu3XA
         F17o2oQx4aSjHkedHaM9rXqsPQOqZka2WJzc7soB8EM80lwzhYHl0KAdjhFDPjXvsLpN
         3bmMUokwZXF2wiSKulm0l4WI7CO8xIbFStXvsbE+urPJZpptfN1On39ZNA1ApzjWIo97
         KwLxGlGvwUqARBrmfNk5LpCn9rOSPGVaeQTrLHRDl46jyfxGfESwQa6fiVmywfXxtqEn
         LpTA==
X-Gm-Message-State: AHQUAuaKYanb0qO4J/y/u4sQrxsqqtgwiE0/G2/9jmJ8ET+qZCOA9JF3
        cEBuBTQAgUjsCf0j9W6W6JMfVdntmAJC9ujoQPw=
X-Google-Smtp-Source: AHgI3IainqZjnMENcHzDUmibylTR1b4bR6GARG8GU5QgXqHpZIv6CpcIa2xyALgBXpzd2Q4ayS2m+wj5PmS/BtHGEQk=
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr13590857otq.206.1551141267804;
 Mon, 25 Feb 2019 16:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20190220205732.2514975-1-andriin@fb.com> <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
 <20190225200822.GB13100@kernel.org> <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
 <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
In-Reply-To: <CAEf4BzYLomoEfGzW+81RtRS2s7pFyo4FuSbCLUxW8NBiOGxLdA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 16:34:16 -0800
Message-ID: <CAEf4BzaxQdGChYNLjL5FGCDAn3k_ZcbwawXzdS_t5ocCJTrW-A@mail.gmail.com>
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

One more datapoint. I've compiled latest redis sources and tested
pahole/BTF on it:

$ ~/local/pahole/build/pahole -J ~/local/btf/redis-server.debug

$ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/redis-server.debug

$ readelf -S ~/local/btf/redis-server.debug | rg -A1 'BTF|debug_str|debug_info'
readelf: /home/andriin/local/btf/redis-server.debug: Warning: the
.dynamic section is not contained within the dynamic segment
  [30] .debug_info       PROGBITS         0000000000000000  0019738d
       00000000002529cf  0000000000000000           0     0     1
--
  [33] .debug_str        PROGBITS         0000000000000000  004574a0
       000000000004fba1  0000000000000001  MS       0     0     1
--
  [40] .BTF              PROGBITS         0000000000000000  007dcc92
       000000000001553c  0000000000000000           0     0     1

$ printf "dwarf data: %d, dwarf strs: %d, btf: %d (ratio: %.3lf)\n"
0x2529cf 0x4fba1 0x1553c '(0x2529cf+0x4fba1+1.0)/0x1553c'
dwarf data: 2435535, dwarf strs: 326561, btf: 87356 (ratio: 31.619)

Even for relatively small DWARF in redis (2.6MB, including strings),
BTF deduplication gives 31.5x compression.

-- Andrii

On Mon, Feb 25, 2019 at 1:36 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 25, 2019 at 12:51 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Feb 25, 2019 at 12:08 PM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Mon, Feb 25, 2019 at 11:42:29AM -0800, Andrii Nakryiko escreveu:
> > > > On Mon, Feb 25, 2019 at 11:00 AM Arnaldo Carvalho de Melo> <arnaldo.melo@gmail.com> wrote:
> > >
> > > > > Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > So yeah, the BTF encoder/decoder is working just fine, the problem is in
> > > > > > pahole's DWARF code, lemme see...
> > > > >
> > > > > Please try the patch below, for me btfdiff continues to show no diff for
> > > > > all types in my vmlinux and now it also produces the same output for
> > > > > when the first element of a bitfield has its bit_size equal to its
> > > > > byte_size * 8:
> > > >
> > > > Yes, this fixes all the issues I've seen. btfdiff output is now empty
> > > > for my kernel image. Thanks for quick fix!
> > > >
> > > > Reviewed-by: Andrii Nakryiko <andriin@fb.com>
> > >
> > > Thanks, just for some extra testing I tried encoding BTF for glibc 2.28:
> > >
> > > [acme@quaco pahole]$ pahole -JV libc-2.28.so.debug
> > > <BIG snip>
> >
> > <snip>
> >
> > > [386075] INT long unsigned int size=8 bit_offset=0 nr_bits=64 encoding=(none)
> > > Cannot open libc-2.28.so.debug
> > > Failed to encode BTF
> >
> > I've tried the same on libc-2.26.so.debug and it worked.
> >
> > It failes after BTF encoding and deduping is done, exactly when it
> > tries to re-open libc-2.28.so.debug to write out new contents. Not
> > sure why it would fail, as it seems to be just plain open() call, but
> > the fact that we both can repro this means there is something there.
> >
> > It also seems that libc-2.28.so.debug is corrupted:
> >
> > $ readelf -n /home/andriin/local/btf/libc-2.26.so.debug | grep
> > 'Unknown note type' | wc -l
> > 0
> > $ readelf -n /home/andriin/local/btf/libc-2.28.so.debug | grep
> > 'Unknown note type' | wc -l
> > 17953
> >
>
> Ignore everything I've said (though 'Unknown note type' issue is
> strange), for me it was just permissions issues.
>
> $ chmod +rw /home/andriin/local/btf/libc-2.28.so.debug
>
> $ ~/local/pahole/build/pahole -J ~/local/btf/libc-2.28.so.debug
>
> $ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/libc-2.28.so.debug
> base_type__name_to_size: base_type _Float128
> class__fixup_btf_bitfields: unknown base type name "_Float128"!
> base_type__name_to_size: base_type _Float128
> class__fixup_btf_bitfields: unknown base type name "_Float128"!
> base_type__name_to_size: base_type _Float128
> class__fixup_btf_bitfields: unknown base type name "_Float128"!
> base_type__name_to_size: base_type _Float128
> class__fixup_btf_bitfields: unknown base type name "_Float128"!
> base_type__name_to_size: base_type _Float128
> class__fixup_btf_bitfields: unknown base type name "_Float128"!
> base_type__name_to_size: base_type _Float128
> class__fixup_btf_bitfields: unknown base type name "_Float128"!
> --- /tmp/btfdiff.dwarf.aV4wSL   2019-02-25 13:31:54.787923673 -0800
> +++ /tmp/btfdiff.btf.22NQmJ     2019-02-25 13:31:54.802923668 -0800
> @@ -461,9 +461,15 @@ struct La_x86_64_retval {
>         uint64_t                   lrv_rdx;              /*     8     8 */
>         La_x86_64_xmm              lrv_xmm0;             /*    16    16 */
>         La_x86_64_xmm              lrv_xmm1;             /*    32    16 */
> -       long double                lrv_st0;              /*    48    16 */
> +       long double                lrv_st0;              /*    48     8 */
> +
> +       /* XXX 8 bytes hole, try to pack */
> +
>         /* --- cacheline 1 boundary (64 bytes) --- */
> -       long double                lrv_st1;              /*    64    16 */
> +       long double                lrv_st1;              /*    64     8 */
> +
> +       /* XXX 8 bytes hole, try to pack */
> +
>         La_x86_64_vector           lrv_vector0;          /*    80    64 */
>         /* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
>         La_x86_64_vector           lrv_vector1;          /*   144    64 */
> @@ -472,6 +478,7 @@ struct La_x86_64_retval {
>         __int128                   lrv_bnd1;             /*   224    16 */
>
>         /* size: 240, cachelines: 4, members: 10 */
> +       /* sum members: 224, holes: 2, sum holes: 16 */
>         /* last cacheline: 48 bytes */
>  };
>  struct r_debug {
> @@ -2044,7 +2051,7 @@ union ieee754_float {
>         } ieee_nan;                                    /*     0     4 */
>  };
>  union ieee854_long_double {
> -       long double                d;                  /*     0    16 */
> +       long double                d;                  /*     0     8 */
>         struct {
>                 unsigned int       mantissa1:32;       /*     0: 0  4 */
>                 unsigned int       mantissa0:32;       /*     4: 0  4 */
> @@ -2141,7 +2148,7 @@ struct ucontext_t {
>         /* last cacheline: 8 bytes */
>  };
>  union ieee854_float128 {
> -       _Float128                  d;                  /*     0    16 */
> +       _Float128                  d;                  /*     0     0 */
>         struct {
>                 unsigned int       mantissa3:32;       /*     0: 0  4 */
>                 unsigned int       mantissa2:32;       /*     4: 0  4 */
> @@ -2219,7 +2226,7 @@ union printf_arg {
>         long unsigned int          pa_u_long_int;      /*     0     8 */
>         long long unsigned int     pa_u_long_long_int; /*     0     8 */
>         double                     pa_double;          /*     0     8 */
> -       long double                pa_long_double;     /*     0    16 */
> +       long double                pa_long_double;     /*     0     8 */
>         const char  *              pa_string;          /*     0     8 */
>         const wchar_t  *           pa_wstring;         /*     0     8 */
>         void *                     pa_pointer;         /*     0     8 */
>
> Seems like "long double" size is invalid for BTF. And we should
> probably add "_Float128" as another "well known" base type name?
>
> Though for the latter, it probably would be better to resolve base
> type size using BTF data itself.
>
> > > [acme@quaco pahole]$
