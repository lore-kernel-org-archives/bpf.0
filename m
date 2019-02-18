Return-Path: <SRS0=+2DZ=QZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45939C43381
	for <bpf@archiver.kernel.org>; Mon, 18 Feb 2019 19:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C932177E
	for <bpf@archiver.kernel.org>; Mon, 18 Feb 2019 19:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2ghy43X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfBRTiy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:38:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36778 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfBRTiy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Feb 2019 14:38:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id v62so21382811otb.3;
        Mon, 18 Feb 2019 11:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6x7BYJNbLiaPwyOY0EdmDwbNjIHw2v05M9biNMut+k=;
        b=K2ghy43XwgDPqbN6mToJAw06GekrkXYTGUnC/Ti73FB4ctD5AY44hMRnIvudEET5pr
         ddxNRRNOyEzo3ipa6pThkjYiWmGXMixmVLOAkO7gDd+VGiKZYaDMkQtKcXPNrRzu1qKH
         mDpiHeosfI7oE7drB9YwXtTjQdOrb/76lNPBmmAEFUP33DOg+RrH6hi8GhRmnLIsq+4r
         odKJxngWWC4mpG2YwmjLqLPRGhK//hJVY6fbmklpMrvrxmkLV1h96mvImbuLXbi4F/D3
         HMjDlzmMN2cXjI6q+8dYbpTxByR1VVXwfmS601tJAZfo0v0mfplX0oSgh0/T17CsMk5/
         0bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6x7BYJNbLiaPwyOY0EdmDwbNjIHw2v05M9biNMut+k=;
        b=JW7igZ/7bNXzdm/hCFcq45+xhsS5Y3K28yIQb54npacBK6YF1DMM8ULPeldNg3ieY9
         /HtTEN5vSxsKwqbq4W8BTihtblMd2CVK8VbSvYd4pcj3EWrECeS9Zx/f3efdSFIH+XM+
         h11CyVKN+9Xh+kaBDaQta4Bm6yaPAQ1ITt11pbYheTm/Pbf5MK0T+nGDVDthpkLi0xny
         btzrGXwvpCey3zrLpKbgluRcy7FIZwrrli3v8fNkzA73k3whd7C8XHCnPW05zagRPhF/
         kkGrMsI0LXpKdRlgNDUMT7j0HgveZIsv2YJ1h8Xex2NMEtP5zguJ4UDAcRfK0RbShPZA
         U7sg==
X-Gm-Message-State: AHQUAuYPhU9GzPU01ZNZaYGH5wkMZMPCTbkiMe2WIUft5hlOinQfTAvX
        uWmkCxAoC5ZP46HxBE9lzwc2+Pv7xLSVIdn5HUo=
X-Google-Smtp-Source: AHgI3Ia2Kn092jpmbz0IkaDckcw0IcTenAtGSWxZt/XdTkzR9vHaTQnvxX2ccFZkNQAfSNaDm22N6y2Hu1Mf26AY0jk=
X-Received: by 2002:a9d:20c4:: with SMTP id x62mr15108812ota.202.1550518733080;
 Mon, 18 Feb 2019 11:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20190217082018.1008069-1-andriin@fb.com> <20190217082018.1008069-3-andriin@fb.com>
 <20190218142900.GR31177@kernel.org>
In-Reply-To: <20190218142900.GR31177@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 18 Feb 2019 11:38:41 -0800
Message-ID: <CAEf4BzYCD91JaoJyTRi2i3BS69=TkJVh34uc8++Wwd7B5nExLA@mail.gmail.com>
Subject: Re: [PATCH pahole 2/2] btf_encoder: run BTF deduplication before
 writing out to ELF
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 18, 2019 at 6:29 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Sun, Feb 17, 2019 at 12:20:18AM -0800, Andrii Nakryiko escreveu:
> > After btf_encoder completes DWARF to BTF 1-to-1 conversion, utilize
> > libbpf to construct struct btf and run btf__dedup() algorithm on it.
> > This significantly reduces number of BTF types and strings section size
> > without losing any information.
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>
> Applied, and added these commit notes, doing the process before and
> after:

Thanks for additional testing!

>
> commit dd3a7d3ab3e843867338805df8dd5dfe2769fc13
> Author: Andrii Nakryiko <andriin@fb.com>
> Date:   Sun Feb 17 00:20:18 2019 -0800
>
>     btf_encoder: run BTF deduplication before writing out to ELF
>
>     After btf_encoder completes DWARF to BTF 0-to-1 conversion, utilize
>     libbpf to construct struct btf and run btf__dedup() algorithm on it.
>     This significantly reduces number of BTF types and strings section size
>     without losing any information.
>
>     Committer testing:
>
>     Before:
>
>       $ cp ../build/v5.0-rc3+/vmlinux .
>       $ ls -la vmlinux
>       -rwxrwxr-x. 1 acme acme 654357792 Feb 18 10:51 vmlinux
>       $ pahole -J vmlinux
>       $ ls -la vmlinux
>       -rwxrwxr-x. 1 acme acme 824950072 Feb 18 10:52 vmlinux
>       $ echo $((824950072 - 654357792))
>       170592280
>       $
>       $ readelf -SW vmlinux  | head -4
>       There are 79 section headers, starting at offset 0x312ba978:
>
>       Section Headers:
>         [Nr] Name   Type      Address          Off      Size    ES Flg Lk Inf Al
>       <SNIP>
>         [78] .BTF   PROGBITS  0000000000000000 27053da9 a266bcd 00      0   0  1
>         $
>       >>> 0xa266bcd
>       170290125
>
>     After:
>
>       $ cp ../build/v5.0-rc3+/vmlinux .
>       $ ls -la vmlinux
>     -rwxrwxr-x. 1 acme acme 654357792 Feb 18 11:01 vmlinux
>       $ pahole -J vmlinux
>       $ ls -la vmlinux
>     -rwxrwxr-x. 1 acme acme 656641544 Feb 18 11:01 vmlinux
>       $ echo $((656641544 - 654357792))
>     2283752
>       $ readelf -SW vmlinux  | grep BTF
>       [78] .BTF              PROGBITS        0000000000000000 27053da9 1e3c9e 00      0   0  1
>     >>> 0x1e3c9e
>     1981598
>     >>>
>
>     Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>     Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     Cc: Alexei Starovoitov <ast@fb.com>
>     Cc: bpf@vger.kernel.org
>     Cc: dwarves@vger.kernel.org
>     Cc: kernel-team@fb.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> ----------------------------------------------------------------------------------------------
>
> Using btfdiff we still have some things to look at probably bugs in
> pahole,, mostly about packed data structures pretty printed from BTF, I
> have to re-read the discussions I had with Yonhghong at some point about
> that.

Yeah I remember I followed that discussion and looked at pahole code.
I think it's btf_loader's part that does bit field adjustment that
doesn't handle all the cases well. I'll try to look at that today,
when I get time.

>
> The 'struct sun_disklabel' is interesting, pahole doesn't print it for
> the DWARF case when pretty printing all structs, but it works for the
> BTF case, I'll investigate.

I wonder if that has something to do with the fact that btf_dedup also
does FWD -> STRUCT/UNION resolution?

>
> When we ask specifically for it, it works and the same output is
> produced:
>
> [acme@quaco pahole]$ pahole -C sun_disklabel vmlinux  > /tmp/dwarf
> [acme@quaco pahole]$ pahole -F btf -C sun_disklabel vmlinux  > /tmp/btf
> [acme@quaco pahole]$ diff -u /tmp/dwarf /tmp/btf
> [acme@quaco pahole]$
>
> Some more testing:
>
> [acme@quaco pahole]$ pahole -F btf --sizes vmlinux | grep b[pt]f | sort -k2 -nr | head -25
> bpf_verifier_env        4736    2
> btf_verifier_env        1592    0
> bpf_verifier_log        1048    1
> bpf_func_state          1008    1
> bpf_htab                 576    1
> cgroup_bpf               512    0
> bpf_scratchpad           512    0
> bpf_prog_aux             288    2
> bpf_stack_map            256    1
> bpf_stab                 256    0
> bpf_queue_stack          256    0
> bpf_offloaded_map        256    0
> bpf_lru                  256    0
> bpf_dtab                 256    0
> bpf_cpu_map              256    0
> bpf_cgroup_storage_map   256    1
> bpf_array                256    1
> bpf_prog_info            192    0
> bpf_map                  192    1
> bpf_common_lru           192    0
> bpf_sock_ops             184    0
> bpf_perf_event_data      184    0
> bpf_map_ops              144    0
> bpf_lru_list             128    0
> btf                      112    1
> [acme@quaco pahole]$
>
> 'struct btf_verifier_env' is tightly organized, but there are some holes
> in 'struct bpf_verifier_env':
>
> [acme@quaco pahole]$ pahole -F btf -C bpf_verifier_env vmlinux
> struct bpf_verifier_env {
>         u32                        insn_idx;             /*     0     4 */
>         u32                        prev_insn_idx;        /*     4     4 */
>         struct bpf_prog *          prog;                 /*     8     8 */
>         const struct bpf_verifier_ops  * ops;            /*    16     8 */
>         struct bpf_verifier_stack_elem * head;           /*    24     8 */
>         int                        stack_size;           /*    32     4 */
>         bool                       strict_alignment;     /*    36     1 */
>
>         /* XXX 3 bytes hole, try to pack */
>
>         struct bpf_verifier_state * cur_state;           /*    40     8 */
>         struct bpf_verifier_state_list * * explored_states; /*    48     8 */
>         struct bpf_map *           used_maps[64];        /*    56   512 */
>         /* --- cacheline 8 boundary (512 bytes) was 56 bytes ago --- */
>         u32                        used_map_cnt;         /*   568     4 */
>         u32                        id_gen;               /*   572     4 */
>         /* --- cacheline 9 boundary (576 bytes) --- */
>         bool                       allow_ptr_leaks;      /*   576     1 */
>         bool                       seen_direct_write;    /*   577     1 */
>
>         /* XXX 6 bytes hole, try to pack */
>
>         struct bpf_insn_aux_data * insn_aux_data;        /*   584     8 */
>         const struct bpf_line_info  * prev_linfo;        /*   592     8 */
>         struct bpf_verifier_log    log;                  /*   600  1048 */
>         /* --- cacheline 25 boundary (1600 bytes) was 48 bytes ago --- */
>         struct bpf_subprog_info    subprog_info[257];    /*  1648  3084 */
>         /* --- cacheline 73 boundary (4672 bytes) was 60 bytes ago --- */
>         u32                        subprog_cnt;          /*  4732     4 */
>
>         /* size: 4736, cachelines: 74, members: 19 */
>         /* sum members: 4727, holes: 2, sum holes: 9 */
> };
> [acme@quaco pahole]$
>
> [acme@quaco pahole]$ pahole -F btf -C bpf_verifier_env --reorganize vmlinux
> struct bpf_verifier_env {
>         u32                        insn_idx;             /*     0     4 */
>         u32                        prev_insn_idx;        /*     4     4 */
>         struct bpf_prog *          prog;                 /*     8     8 */
>         const struct bpf_verifier_ops  * ops;            /*    16     8 */
>         struct bpf_verifier_stack_elem * head;           /*    24     8 */
>         int                        stack_size;           /*    32     4 */
>         bool                       strict_alignment;     /*    36     1 */
>         bool                       seen_direct_write;    /*    37     1 */
>         bool                       allow_ptr_leaks;      /*    38     1 */
>
>         /* XXX 1 byte hole, try to pack */
>
>         struct bpf_verifier_state * cur_state;           /*    40     8 */
>         struct bpf_verifier_state_list * * explored_states; /*    48     8 */
>         struct bpf_map *           used_maps[64];        /*    56   512 */
>         /* --- cacheline 8 boundary (512 bytes) was 56 bytes ago --- */
>         u32                        used_map_cnt;         /*   568     4 */
>         u32                        id_gen;               /*   572     4 */
>         /* --- cacheline 9 boundary (576 bytes) --- */
>         struct bpf_insn_aux_data * insn_aux_data;        /*   576     8 */
>         const struct bpf_line_info  * prev_linfo;        /*   584     8 */
>         struct bpf_verifier_log    log;                  /*   592  1048 */
>         /* --- cacheline 25 boundary (1600 bytes) was 40 bytes ago --- */
>         struct bpf_subprog_info    subprog_info[257];    /*  1640  3084 */
>         /* --- cacheline 73 boundary (4672 bytes) was 52 bytes ago --- */
>         u32                        subprog_cnt;          /*  4724     4 */
>
>         /* size: 4728, cachelines: 74, members: 19 */
>         /* sum members: 4727, holes: 2, sum holes: 1 */
>         /* last cacheline: 56 bytes */
> };   /* saved 8 bytes! */
> [acme@quaco pahole]$
>
> [acme@quaco pahole]$ pahole -F btf -C bpf_verifier_env --reorganize --show_reorg_steps vmlinux  | grep ^/
> /* Moving 'seen_direct_write' from after 'allow_ptr_leaks' to after 'strict_alignment' */
> /* Moving 'allow_ptr_leaks' from after 'id_gen' to after 'seen_direct_write' */
> /* Final reorganized struct: */

Heh, this is nifty, I haven't used that functionality yet!

> [acme@quaco pahole]$
>
> And this is so cool, so much faster :-)

Now we should think about making .BTF part of vmlinux by default ;)

>
> [acme@quaco pahole]$ time pahole -F btf vmlinux  > /tmp/btf
>
> real    0m0.091s
> user    0m0.078s
> sys     0m0.013s
> [acme@quaco pahole]$ time pahole -F dwarf vmlinux  > /tmp/dwarf
>
> real    0m14.472s
> user    0m14.018s
> sys     0m0.426s
> [acme@quaco pahole]$ wc -l /tmp/btf
> 106948 /tmp/btf
> [acme@quaco pahole]$ wc -l /tmp/dwarf
> 105808 /tmp/dwarf
> [acme@quaco pahole]$
>
> [acme@quaco pahole]$ time pahole --sizes vmlinux > /dev/null
>
> real    0m14.432s
> user    0m13.992s
> sys     0m0.413s
> [acme@quaco pahole]$ time pahole -F btf --sizes vmlinux > /dev/null
>
> real    0m0.038s
> user    0m0.030s
> sys     0m0.008s
> [acme@quaco pahole]$
>
> Thanks for all the cool work!

My pleasure, it was fun! :)

>
> - Arnaldo
>
> $ btfdiff vmlinux

<SNIP>
