Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAFEC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 16:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6FE20C01
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 16:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C84tBkAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfBYQC4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:02:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37877 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfBYQC4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 11:02:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id a48so11079293qtb.4;
        Mon, 25 Feb 2019 08:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e92I+OTXRh6MBDhpcEsTsaqf7KTdif10qkpLioQ4tnM=;
        b=C84tBkANlh/3EpOSf8qbP5o2C6tnk2+cJ20biCscEJsjy6CocQ39nIY5WtGhoc9bfs
         wUn7Y/p9UtRGuJpapBlDFLfEj2AHps7hd1k0EQkUqNhjWp7R3gYxsHVcBl5UPrrzjKIX
         I6eDFAUUth9hWsW29nDTnFjb69Y296xKuF9HySzE6GK8zEkrMwiCdJjUwvcsk7gPvwXm
         3bwtuozE/rjZmNHLIsJwyW39rJQIoJ3nNftux3B3ssqrS7gERqoN+7lpyxy4ejRxT/Dg
         EjSEYZbrChs6/xxcJEQsFqZv68R6ZTulHp31q29M3cLtWNaVuNRLHgXvC9Hpwcktu7d8
         DXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e92I+OTXRh6MBDhpcEsTsaqf7KTdif10qkpLioQ4tnM=;
        b=cEEuX8NzGxEeTToHjCpb4e03Rm4Lei7IcUR5/xLhNp2WUsDgzhbejLFjIBcPGmI65Z
         ZLq9hNxXV09QsarTcfIW4jFmukuDB6Zk3YH1Qka7EFwh6fPlBBnQ2HOh2nwqF/ssx9hL
         7KwpmX1j+oeNDkNClO8OrdXv3M6sWIPIVdNIGCY0UfmMKJFceBKXUjwIZ/CKO6zxAef3
         uptvdTXvYaIuvvklwmYtCknGh7HPynohX2ShtOS/Sg6R52c6BrvHIsyCmVAIEVtUuz1a
         OtAXgNQ5sf4RZrkFyV/1EzNs6K6ZoNu6rUmDgAXm+m/3CI2PeVEroaSup1ibNvGP8kB3
         cDcg==
X-Gm-Message-State: AHQUAuajMYgproh6SXRP1XyoDSNXeebLAKg0lV2hxdvjbMgHdgoBQ9tI
        nG3B2msUD3z0nEWXtFpj4tQ=
X-Google-Smtp-Source: AHgI3IaJBUOfVG9bmBpEwcxMy5/4IvpOSiwDod377ZPlnGnD7/p5tef6jQjbupfZeK+dEJCV7H08Dw==
X-Received: by 2002:aed:3ef6:: with SMTP id o51mr14333347qtf.183.1551110574139;
        Mon, 25 Feb 2019 08:02:54 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id u20sm6281750qku.50.2019.02.25.08.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 08:02:52 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AD7A4039C; Mon, 25 Feb 2019 13:02:39 -0300 (-03)
Date:   Mon, 25 Feb 2019 13:02:39 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH pahole 0/3] fix handling of bitfields in btf_loader
Message-ID: <20190225160239.GR31136@kernel.org>
References: <20190220205732.2514975-1-andriin@fb.com>
 <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 22, 2019 at 03:23:52PM -0800, Andrii Nakryiko escreveu:
> On Fri, Feb 22, 2019 at 2:02 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Wed, Feb 20, 2019 at 12:57:29PM -0800, Andrii Nakryiko escreveu:
> > > This patchset fixes the logic of determining bitfield_offsets and
> > > initial bit_offset when using BTF type information. It eliminates all
> > > the remaining discrepancies, when doing btfdiff on vmlinux image, module
> > > two instances of incorrectly reporting struct member type name when
> > > bitfield is the very first field in a struct, which is only happening
> > > when using DWARF data.
> > >
> > > Patch #1 makes btfdiff script easier to use during local development.
> > >
> > > Patch #2 fixes list of known base type names to handle clang-generated
> > > type descriptions better.
> > >
> > > Patch #3 fixes bitfield handling logic in btf_loader.
> >
> > Thanks a lot! Applied.
> >
> > And here I see no differences in my vmlinux:
> >
> 
> <SNIP>
> 
> >
> > Which ones where these: "module two instances of incorrectly reporting struct
> > member type name when bitfield is the very first field in a struct, which is
> > only happening when using DWARF data." ?
> 
> $ ./btfdiff /tmp/vmlinux4
> --- /tmp/btfdiff.dwarf.GIVfpr   2019-02-20 12:18:29.138788970 -0800
> +++ /tmp/btfdiff.btf.c3x2KY     2019-02-20 12:18:29.351786365 -0800
> @@ -16884,7 +16884,7 @@ struct pebs_record_nhm {
>  };
>  union hsw_tsx_tuning {
>         struct {
> -               unsigned int       cycles_last_block:32; /*     0: 0  4 */
> +               u32                cycles_last_block:32; /*     0: 0  4 */

$ vim hsw_tsx_tuning.c
$ gcc -g -c hsw_tsx_tuning.c -o hsw_tsx_tuning-gcc
$ pahole -J hsw_tsx_tuning
pahole: hsw_tsx_tuning: No such file or directory
$ pahole -J hsw_tsx_tuning-gcc
$
$ btfdiff hsw_tsx_tuning-gcc
--- /tmp/btfdiff.dwarf.ErXffk	2019-02-25 10:26:56.863625697 -0300
+++ /tmp/btfdiff.btf.Y5EDdM	2019-02-25 10:26:56.864625706 -0300
@@ -1,6 +1,6 @@
 union hsw_tsx_tuning {
 	struct {
-		unsigned int       cycles_last_block:32; /*     0: 0  4 */
+		u32                cycles_last_block:32; /*     0: 0  4 */
 		u32                hle_abort:1;        /*     4:31  4 */
 		u32                rtm_abort:1;        /*     4:30  4 */
 		u32                instruction_abort:1; /*     4:29  4 */
$

Reproduced. 

 <2><5c>: Abbrev Number: 5 (DW_TAG_member)
    <5d>   DW_AT_name        : (indirect string, offset: 0x23): cycles_last_block
    <61>   DW_AT_decl_file   : 1
    <62>   DW_AT_decl_line   : 8
    <63>   DW_AT_decl_column : 13
    <64>   DW_AT_type        : <0x40>
    <68>   DW_AT_byte_size   : 4
    <69>   DW_AT_bit_size    : 32
    <6a>   DW_AT_bit_offset  : 0
    <6b>   DW_AT_data_member_location: 0
 <1><40>: Abbrev Number: 2 (DW_TAG_typedef)
    <41>   DW_AT_name        : u32
    <45>   DW_AT_decl_file   : 1
    <46>   DW_AT_decl_line   : 4
    <47>   DW_AT_decl_column : 22
    <48>   DW_AT_type        : <0x4c>
 <1><4c>: Abbrev Number: 3 (DW_TAG_base_type)
    <4d>   DW_AT_byte_size   : 4
    <4e>   DW_AT_encoding    : 7        (unsigned)
    <4f>   DW_AT_name        : (indirect string, offset: 0x16): unsigned int

So yeah, the BTF encoder/decoder is working just fine, the problem is in
pahole's DWARF code, lemme see...

>                 u32                hle_abort:1;        /*     4:31  4 */
>                 u32                rtm_abort:1;        /*     4:30  4 */
>                 u32                instruction_abort:1; /*     4:29  4 */
> @@ -26154,7 +26154,7 @@ struct acpi_device_power {
>         /* last cacheline: 40 bytes */
>  };
>  struct acpi_device_perf_flags {
> -       unsigned char              reserved:8;           /*     0: 0  1 */
> +       u8                         reserved:8;           /*     0: 0  1 */
> 
>         /* size: 1, cachelines: 1, members: 1 */
>         /* last cacheline: 1 bytes */
> 
> For hsw_tsx_tuning, it is defined in sources like this:
> 
> $ cat hsw_tsx_tuning.c
> typedef unsigned long long u64;
> typedef unsigned int u32;
> 
> union hsw_tsx_tuning {
>     struct {
>         u32 cycles_last_block     : 32,
>             hle_abort             : 1,
>             rtm_abort             : 1,
>             instruction_abort     : 1,
>             non_instruction_abort : 1,
>             retry                 : 1,
>             data_conflict         : 1,
>             capacity_writes       : 1,
>             capacity_reads        : 1;
>     };
>     u64        value;
> };
> 
> int main() {
>     union hsw_tsx_tuning t;
>     return 0;
> }
> 
> Building same defition with gcc and clang reveals some more info.
> 
> $ cc -g -c hsw_tsx_tuning.c -o hsw_tsx_tuning-gcc &&
> ~/local/pahole/build/pahole -J hsw_tsx_tuning-gcc
> $ clang -g -c hsw_tsx_tuning.c -o hsw_tsx_tuning-clang &&
> ~/local/pahole/build/pahole -J hsw_tsx_tuning-clang
> 
> GCC-generated DWARF/BTF exposes this bug:
> 
> $ PAHOLE=~/local/pahole/build/pahole ~/local/pahole/btfdiff hsw_tsx_tuning-gcc
> --- /tmp/btfdiff.dwarf.khRiFg   2019-02-22 15:18:46.768858141 -0800
> +++ /tmp/btfdiff.btf.jqdEsR     2019-02-22 15:18:46.770858140 -0800
> @@ -1,6 +1,6 @@
>  union hsw_tsx_tuning {
>         struct {
> -               unsigned int       cycles_last_block:32; /*     0: 0  4 */
> +               u32                cycles_last_block:32; /*     0: 0  4 */
>                 u32                hle_abort:1;        /*     4:31  4 */
>                 u32                rtm_abort:1;        /*     4:30  4 */
>                 u32                instruction_abort:1; /*     4:29  4 */
> 
> But the one generated by clang doesn't:
> 
> $ PAHOLE=~/local/pahole/build/pahole ~/local/pahole/btfdiff hsw_tsx_tuning-clang
> 
> The only difference is that GCC correctly marks cycles_last_block as
> bitfield, while clang optimizes it to stand-alone u32.
> 
> $ ~/local/pahole/build/pahole -F btf hsw_tsx_tuning-gcc
> union hsw_tsx_tuning {
>         struct {
>                 u32                cycles_last_block:32; /*     0: 0  4 */
>                 u32                hle_abort:1;        /*     4:31  4 */
>                 u32                rtm_abort:1;        /*     4:30  4 */
>                 u32                instruction_abort:1; /*     4:29  4 */
>                 u32                non_instruction_abort:1; /*     4:28  4 */
>                 u32                retry:1;            /*     4:27  4 */
>                 u32                data_conflict:1;    /*     4:26  4 */
>                 u32                capacity_writes:1;  /*     4:25  4 */
>                 u32                capacity_reads:1;   /*     4:24  4 */
>         };                                             /*     0     8 */
>         u64                        value;              /*     0     8 */
> };
> 
> $ ~/local/pahole/build/pahole -F btf hsw_tsx_tuning-clang
> union hsw_tsx_tuning {
>         struct {
>                 u32                cycles_last_block;  /*     0     4 */
>                 u32                hle_abort:1;        /*     4:31  4 */
>                 u32                rtm_abort:1;        /*     4:30  4 */
>                 u32                instruction_abort:1; /*     4:29  4 */
>                 u32                non_instruction_abort:1; /*     4:28  4 */
>                 u32                retry:1;            /*     4:27  4 */
>                 u32                data_conflict:1;    /*     4:26  4 */
>                 u32                capacity_writes:1;  /*     4:25  4 */
>                 u32                capacity_reads:1;   /*     4:24  4 */
>         };                                             /*     0     8 */
>         u64                        value;              /*     0     8 */
> };
> 
> I've spent a bit of time debugging this, but didn't get far, as I'm
> pretty unfamiliar with overall flow of decoders, I was hoping this can
> give you some idea where to look, though.
> 
> >
> > - Arnaldo

-- 

- Arnaldo
