Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F62DC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 18:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBFC20842
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 18:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmGrUg/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfCASsh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:48:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41295 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCASsh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 13:48:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id t7so21823614otk.8;
        Fri, 01 Mar 2019 10:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzBwxMAQB/X2x4EMcvNecJCp0nggsi5rS6rpMUa0PPU=;
        b=OmGrUg/x7t8evuS5esBKCU+ZVOkUI+2/xPmTtrrg9/5V7cxriZxJmAft8W4px7Iev7
         7m+WbCL17WN2CaEL3iRaKdE8IeACfF+3HD5E89kB/7C84RQdG6zlo7vMwDlVmrJcDZSe
         8B3peohjlzfgYK4K0PSWMsrXOoOje8p8KwVHvel3YgmCFGikt7h95SOI5PyHR/n0D51M
         BalNXBTFsWxMAdApACP4n3tQWs37le0wy1vyyHgkOoIsEwyP+gitTXqtRdtWl1bJyoc3
         7FY4c4xouMLFjElUnvfxEZ4PWStXlk/oVZoSm82s/masYkgXkNOUyaeg+5hztCUQvr1W
         L37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzBwxMAQB/X2x4EMcvNecJCp0nggsi5rS6rpMUa0PPU=;
        b=cNB0ngk3d+TuYOAVurglKpiYG7fcfpuUJ4nmGyTMWzwt4j46t2GNDwuTsDEVINNJ8t
         18fU7yLu1maIjVz7zqce2CprWq6gX3txSIqJlJzbes9NNM4j5NpcJPUcNTvDmaEHM5J7
         bZMAjl31hfz5sLOky5ouo+6dfq6fRrF51h6rlzGHLmvFt6XV0pXLJizzV1JmNs61dd5v
         RFMp7Uifx2uvicqCpbjs5Mi+LdCXmX9zGzd6tnZprss28LcgS4dVssAvSWPBdiyeio7i
         UHFhijpBdG392egePRc9SCiq/ESRfzzZ1PeRTkwFV5gGyp0xnf78KB765m2fHPaFJVsP
         YD/g==
X-Gm-Message-State: APjAAAWU56pvl8kfJEghJ/0WoI2CbRDCf6slIogu33ghRfmCzJlIxMYA
        C/qpvoA4yDvOPuHNMnqpo0dcvf+SLcN7xRqg1JE=
X-Google-Smtp-Source: APXvYqwmgBk3nZUoQ0209r69n7AKyZ01gwHLHViESBcohjG2Mt3jJAvj6l+CzWH3Idg5Pwhg3fUXZiqt3R8VfUsqZZs=
X-Received: by 2002:a05:6830:100b:: with SMTP id a11mr45980otp.75.1551466116047;
 Fri, 01 Mar 2019 10:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20190228231829.11993-1-daniel@iogearbox.net> <20190228231829.11993-6-daniel@iogearbox.net>
 <1e21ba74-f236-60b8-f33c-f3f060419197@fb.com>
In-Reply-To: <1e21ba74-f236-60b8-f33c-f3f060419197@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 1 Mar 2019 10:48:24 -0800
Message-ID: <CAEf4BzYx=05UXSkOpRdKzhXenXJpRYrukgnG7fGjTSR30wLz-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
To:     Yonghong Song <yhs@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "tgraf@suug.ch" <tgraf@suug.ch>, Andrii Nakryiko <andriin@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 10:31 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/28/19 3:18 PM, Daniel Borkmann wrote:
> > This work adds BPF loader support for global data sections
> > to libbpf. This allows to write BPF programs in more natural
> > C-like way by being able to define global variables and const
> > data.
> >
> > Back at LPC 2018 [0] we presented a first prototype which
> > implemented support for global data sections by extending BPF
> > syscall where union bpf_attr would get additional memory/size
> > pair for each section passed during prog load in order to later
> > add this base address into the ldimm64 instruction along with
> > the user provided offset when accessing a variable. Consensus
> > from LPC was that for proper upstream support, it would be
> > more desirable to use maps instead of bpf_attr extension as
> > this would allow for introspection of these sections as well
> > as potential life updates of their content. This work follows
> > this path by taking the following steps from loader side:
> >
> >   1) In bpf_object__elf_collect() step we pick up ".data",
> >      ".rodata", and ".bss" section information.
> >
> >   2) If present, in bpf_object__init_global_maps() we create
> >      a map that corresponds to each of the present sections.
> >      Given section size and access properties can differ, a
> >      single entry array map is created with value size that
> >      is corresponding to the ELF section size of .data, .bss
> >      or .rodata. In the latter case, the map is created as
> >      read-only from program side such that verifier rejects
> >      any write attempts into .rodata. In a subsequent step,
> >      for .data and .rodata sections, the section content is
> >      copied into the map through bpf_map_update_elem(). For
> >      .bss this is not necessary since array map is already
> >      zero-initialized by default.
> >
> >   3) In bpf_program__collect_reloc() step, we record the
> >      corresponding map, insn index, and relocation type for
> >      the global data.
> >
> >   4) And last but not least in the actual relocation step in
> >      bpf_program__relocate(), we mark the ldimm64 instruction
> >      with src_reg = BPF_PSEUDO_MAP_VALUE where in the first
> >      imm field the map's file descriptor is stored as similarly
> >      done as in BPF_PSEUDO_MAP_FD, and in the second imm field
> >      (as ldimm64 is 2-insn wide) we store the access offset
> >      into the section.
> >
> >   5) On kernel side, this special marked BPF_PSEUDO_MAP_VALUE
> >      load will then store the actual target address in order
> >      to have a 'map-lookup'-free access. That is, the actual
> >      map value base address + offset. The destination register
> >      in the verifier will then be marked as PTR_TO_MAP_VALUE,
> >      containing the fixed offset as reg->off and backing BPF
> >      map as reg->map_ptr. Meaning, it's treated as any other
> >      normal map value from verification side, only with
> >      efficient, direct value access instead of actual call to
> >      map lookup helper as in the typical case.
> >
> > Simple example dump of program using globals vars in each
> > section:
> >
> >    # readelf -a test_global_data.o
> >    [...]
> >    [ 6] .bss              NOBITS           0000000000000000  00000328
> >         0000000000000010  0000000000000000  WA       0     0     8
> >    [ 7] .data             PROGBITS         0000000000000000  00000328
> >         0000000000000010  0000000000000000  WA       0     0     8
> >    [ 8] .rodata           PROGBITS         0000000000000000  00000338
> >         0000000000000018  0000000000000000   A       0     0     8
> >    [...]
> >      95: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    6 static_bss
> >      96: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    6 static_bss2
> >      97: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    7 static_data
> >      98: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    7 static_data2
> >      99: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    8 static_rodata
> >     100: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    8 static_rodata2
> >     101: 0000000000000010     8 OBJECT  LOCAL  DEFAULT    8 static_rodata3
> >    [...]
> >
> >    # bpftool prog
> >    103: sched_cls  name load_static_dat  tag 37a8b6822fc39a29  gpl
> >         loaded_at 2019-02-28T02:02:35+0000  uid 0
> >         xlated 712B  jited 426B  memlock 4096B  map_ids 63,64,65,66
> >    # bpftool map show id 63
> >    63: array  name .bss  flags 0x0                      <-- .bss area, rw
> >        key 4B  value 16B  max_entries 1  memlock 4096B
> >    # bpftool map show id 64
> >    64: array  name .data  flags 0x0                     <-- .data area, rw
> >        key 4B  value 16B  max_entries 1  memlock 4096B
> >    # bpftool map show id 65
> >    65: array  name .rodata  flags 0x80                  <-- .rodata area, ro
> >        key 4B  value 24B  max_entries 1  memlock 4096B
> >
> >    # bpftool prog dump xlated id 103
> >    int load_static_data(struct __sk_buff * skb):
> >    ; int load_static_data(struct __sk_buff *skb)
> >       0: (b7) r1 = 0
> >    ; key = 0;
> >       1: (63) *(u32 *)(r10 -4) = r1
> >       2: (bf) r6 = r10
> >    ; int load_static_data(struct __sk_buff *skb)
> >       3: (07) r6 += -4
> >    ; bpf_map_update_elem(&result, &key, &static_bss, 0);
> >       4: (18) r1 = map[id:66]
> >       6: (bf) r2 = r6
> >       7: (18) r3 = map[id:63][0]+0         <-- direct static_bss addr in .bss area
> >       9: (b7) r4 = 0
> >      10: (85) call array_map_update_elem#99888
> >      11: (b7) r1 = 1
> >    ; key = 1;
> >      12: (63) *(u32 *)(r10 -4) = r1
> >    ; bpf_map_update_elem(&result, &key, &static_data, 0);
> >      13: (18) r1 = map[id:66]
> >      15: (bf) r2 = r6
> >      16: (18) r3 = map[id:64][0]+0         <-- direct static_data addr in .data area
> >      18: (b7) r4 = 0
> >      19: (85) call array_map_update_elem#99888
> >      20: (b7) r1 = 2
> >    ; key = 2;
> >      21: (63) *(u32 *)(r10 -4) = r1
> >    ; bpf_map_update_elem(&result, &key, &static_rodata, 0);
> >      22: (18) r1 = map[id:66]
> >      24: (bf) r2 = r6
> >      25: (18) r3 = map[id:65][0]+0         <-- direct static_rodata addr in .rodata area
> >      27: (b7) r4 = 0
> >      28: (85) call array_map_update_elem#99888
> >      29: (b7) r1 = 3
> >    ; key = 3;
> >      30: (63) *(u32 *)(r10 -4) = r1
> >    ; bpf_map_update_elem(&result, &key, &static_bss2, 0);
> >      31: (18) r7 = map[id:63][0]+8         <--.
> >      33: (18) r1 = map[id:66]                 |
> >      35: (bf) r2 = r6                         |
> >      36: (18) r3 = map[id:63][0]+8         <-- direct static_bss2 addr in .bss area
> >      38: (b7) r4 = 0
> >      39: (85) call array_map_update_elem#99888
> >    [...]
> >
> > For now .data/.rodata/.bss maps are not exposed via API to the
> > user, but this could be done in a subsequent step.
> >
> > Based upon recent fix in LLVM, commit c0db6b6bd444 ("[BPF] Don't
> > fail for static variables").
> >
> > Joint work with Joe Stringer.
> >
> >    [0] LPC 2018, BPF track, "ELF relocation for static data in BPF",
> >        http://vger.kernel.org/lpc-bpf2018.html#session-3
> >
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Joe Stringer <joe@wand.net.nz>
> > ---
> >   tools/include/uapi/linux/bpf.h |  10 +-
> >   tools/lib/bpf/libbpf.c         | 259 +++++++++++++++++++++++++++------
> >   2 files changed, 226 insertions(+), 43 deletions(-)
> >
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 8884072e1a46..04b26f59b413 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -287,7 +287,7 @@ enum bpf_attach_type {
> > [...]
> > @@ -999,8 +1120,10 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
> >                        (long long) (rel.r_info >> 32),
> >                        (long long) sym.st_value, sym.st_name);
> >
> > -             if (sym.st_shndx != maps_shndx && sym.st_shndx != text_shndx) {
> > -                     pr_warning("Program '%s' contains non-map related relo data pointing to section %u\n",
> > +             if (sym.st_shndx != maps_shndx && sym.st_shndx != text_shndx &&
> > +                 sym.st_shndx != data_shndx && sym.st_shndx != rodata_shndx &&
> > +                 sym.st_shndx != bss_shndx) {
> > +                     pr_warning("Program '%s' contains unrecognized relo data pointing to section %u\n",
> >                                  prog->section_name, sym.st_shndx);
> >                       return -LIBBPF_ERRNO__RELOC;
> >               }
> > @@ -1045,6 +1168,30 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
> >                       prog->reloc_desc[i].type = RELO_LD64;
> >                       prog->reloc_desc[i].insn_idx = insn_idx;
> >                       prog->reloc_desc[i].map_idx = map_idx;
> > +             } else if (sym.st_shndx == data_shndx ||
> > +                        sym.st_shndx == rodata_shndx ||
> > +                        sym.st_shndx == bss_shndx) {
> > +                     int type = (sym.st_shndx == data_shndx)   ? RELO_DATA :
> > +                                (sym.st_shndx == rodata_shndx) ? RELO_RODATA :
> > +                                                                 RELO_BSS;
> > +
> > +                     for (map_idx = 0; map_idx < nr_maps_global; map_idx++) {
> > +                             if (maps_global[map_idx].global_type == type) {
> > +                                     pr_debug("relocation: find map %zd (%s) for insn %u\n",
> > +                                              map_idx, maps_global[map_idx].name, insn_idx);
> > +                                     break;
> > +                             }
> > +                     }
> > +
> > +                     if (map_idx >= nr_maps_global) {
> > +                             pr_warning("bpf relocation: map_idx %d large than %d\n",
> > +                                        (int)map_idx, (int)nr_maps_global - 1);
> > +                             return -LIBBPF_ERRNO__RELOC;
> > +                     }
> > +
> > +                     prog->reloc_desc[i].type = type;
> > +                     prog->reloc_desc[i].insn_idx = insn_idx;
> > +                     prog->reloc_desc[i].map_idx = map_idx;
> >               }
> >       }
> >       return 0;
> > @@ -1176,15 +1323,58 @@ bpf_object__probe_caps(struct bpf_object *obj)
> >   }
> >
> >   static int
> [...]
> > +
> > +static int
> > +bpf_object__create_maps(struct bpf_object *obj)
> > +{
> >       unsigned int i;
> >       int err;
> >
> >       for (i = 0; i < obj->nr_maps; i++) {
> >               struct bpf_map *map = &obj->maps[i];
> > -             struct bpf_map_def *def = &map->def;
> >               char *cp, errmsg[STRERR_BUFSIZE];
> >               int *pfd = &map->fd;
> >
> > @@ -1193,41 +1383,7 @@ bpf_object__create_maps(struct bpf_object *obj)
> >                                map->name, map->fd);
> >                       continue;
> >               }
> > -
> > -             if (obj->caps.name)
> > -                     create_attr.name = map->name;
> > -             create_attr.map_ifindex = map->map_ifindex;
> > -             create_attr.map_type = def->type;
> > -             create_attr.map_flags = def->map_flags;
> > -             create_attr.key_size = def->key_size;
> > -             create_attr.value_size = def->value_size;
> > -             create_attr.max_entries = def->max_entries;
> > -             create_attr.btf_fd = 0;
> > -             create_attr.btf_key_type_id = 0;
> > -             create_attr.btf_value_type_id = 0;
> > -             if (bpf_map_type__is_map_in_map(def->type) &&
> > -                 map->inner_map_fd >= 0)
> > -                     create_attr.inner_map_fd = map->inner_map_fd;
> > -
> > -             if (obj->btf && !bpf_map_find_btf_info(map, obj->btf)) {
> > -                     create_attr.btf_fd = btf__fd(obj->btf);
> > -                     create_attr.btf_key_type_id = map->btf_key_type_id;
> > -                     create_attr.btf_value_type_id = map->btf_value_type_id;
> > -             }
> > -
> > -             *pfd = bpf_create_map_xattr(&create_attr);
> > -             if (*pfd < 0 && create_attr.btf_key_type_id) {
> > -                     cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
> > -                     pr_warning("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
> > -                                map->name, cp, errno);
> > -                     create_attr.btf_fd = 0;
> > -                     create_attr.btf_key_type_id = 0;
> > -                     create_attr.btf_value_type_id = 0;
> > -                     map->btf_key_type_id = 0;
> > -                     map->btf_value_type_id = 0;
> > -                     *pfd = bpf_create_map_xattr(&create_attr);
> > -             }
> > -
> > +             *pfd = bpf_object__create_map(obj, map);
> >               if (*pfd < 0) {
> >                       size_t j;
> >
> > @@ -1412,6 +1568,24 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
> >                                                     &prog->reloc_desc[i]);
> >                       if (err)
> >                               return err;
> > +             } else if (prog->reloc_desc[i].type == RELO_DATA ||
> > +                        prog->reloc_desc[i].type == RELO_RODATA ||
> > +                        prog->reloc_desc[i].type == RELO_BSS) {
> > +                     struct bpf_insn *insns = prog->insns;
> > +                     int insn_idx, map_idx, data_off;
> > +
> > +                     insn_idx = prog->reloc_desc[i].insn_idx;
> > +                     map_idx  = prog->reloc_desc[i].map_idx;
> > +                     data_off = insns[insn_idx].imm;
>
> I want to point to a subtle difference here between handling pure global
> variables and static global variables. The "imm" value is only available
> for static variables. For example,
>
> -bash-4.4$ cat g.c
> static volatile long sg = 2;
> static volatile int si = 3;
> long g = 4;
> int i = 5;
> int test() { return sg + si + g + i; }
> -bash-4.4$
> -bash-4.4$ clang -target bpf -O2 -c g.c
>
> -bash-4.4$ readelf -s g.o
>
>
> Symbol table '.symtab' contains 8 entries:
>     Num:    Value          Size Type    Bind   Vis      Ndx Name
>       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>       1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS g.c
>       2: 0000000000000010     8 OBJECT  LOCAL  DEFAULT    4 sg
>       3: 0000000000000018     4 OBJECT  LOCAL  DEFAULT    4 si
>       4: 0000000000000000     0 SECTION LOCAL  DEFAULT    4
>       5: 0000000000000000     8 OBJECT  GLOBAL DEFAULT    4 g
>       6: 0000000000000008     4 OBJECT  GLOBAL DEFAULT    4 i
>       7: 0000000000000000   128 FUNC    GLOBAL DEFAULT    2 test
> -bash-4.4$
> -bash-4.4$ llvm-readelf -r g.o
>
> Relocation section '.rel.text' at offset 0x1d8 contains 4 entries:
>      Offset             Info             Type               Symbol's
> Value  Symbol's Name
> 0000000000000000  0000000400000001 R_BPF_64_64
> 0000000000000000 .data
> 0000000000000018  0000000400000001 R_BPF_64_64
> 0000000000000000 .data
> 0000000000000038  0000000500000001 R_BPF_64_64            0000000000000000 g
> 0000000000000058  0000000600000001 R_BPF_64_64            0000000000000008 i
> -bash-4.4$ llvm-objdump -d g.o
>
> g.o:    file format ELF64-BPF
>
> Disassembly of section .text:
> 0000000000000000 test:
>         0:       18 01 00 00 10 00 00 00 00 00 00 00 00 00 00 00
> r1 = 16 ll
>         2:       79 11 00 00 00 00 00 00         r1 = *(u64 *)(r1 + 0)
>         3:       18 02 00 00 18 00 00 00 00 00 00 00 00 00 00 00
> r2 = 24 ll
>         5:       61 22 00 00 00 00 00 00         r2 = *(u32 *)(r2 + 0)
>         6:       0f 21 00 00 00 00 00 00         r1 += r2
>         7:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> r2 = 0 ll
>         9:       79 22 00 00 00 00 00 00         r2 = *(u64 *)(r2 + 0)
>        10:       0f 21 00 00 00 00 00 00         r1 += r2
>        11:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> r2 = 0 ll
>        13:       61 20 00 00 00 00 00 00         r0 = *(u32 *)(r2 + 0)
>        14:       0f 10 00 00 00 00 00 00         r0 += r1
>        15:       95 00 00 00 00 00 00 00         exit
> -bash-4.4$
>
> You can see the above, the non-static global access does not have its
> in-section offset encoded in the insn itself. The difference is due to
> llvm treating static global and non-static global differently.
>
> To support both cases, during relocation recording stage, you can
> also record:
>     . symbol binding (GELF_ST_BIND(sym.st_info)),
>       non-static global has binding STB_GLOBAL and static
>       global has binding STB_LOCAL
>     . symbol value (sym.st_value)
>
> During the above relocation resolution, if symbol bind is local, do
> what you already did here. If symbol bind is global, assign data_off
> with symbol value.
>
> This applied to both .data and .rodata sections.
>
> The non initialized
> global variable will not be in any allocated section in ELF file,
> it is in a COM section which is to be allocated by loader.
> So user defines some like
>     int g;
> and later on uses it. Right now, it will not work. The workaround
> is "int g = 4", or "static int g". I guess it should be
> okay, we should encourage users to use "static" variables instead.

Would it be reasonable to just plain disable usage of uninitialized
global variables, as it kind of goes against BPF's philosophy that
everything should be written to, before can be read? So while we can
just implicitly zero-out everything beforehand, it might be a good
idea to remind and enforce that explictly?

>
> > +
> > +                     if (insn_idx + 1 >= (int)prog->insns_cnt) {
> > +                             pr_warning("relocation out of range: '%s'\n",
> > +                                        prog->section_name);
> > +                             return -LIBBPF_ERRNO__RELOC;
> > +                     }
> > +                     insns[insn_idx].src_reg = BPF_PSEUDO_MAP_VALUE;
> > +                     insns[insn_idx].imm = obj->maps_global[map_idx].fd;
> > +                     insns[insn_idx + 1].imm = data_off;
> >               }
> >       }
> >
> > @@ -1717,6 +1891,7 @@ __bpf_object__open(const char *path, void *obj_buf, size_t obj_buf_sz,
> >
> >       CHECK_ERR(bpf_object__elf_init(obj), err, out);
> >       CHECK_ERR(bpf_object__check_endianness(obj), err, out);
> > +     CHECK_ERR(bpf_object__probe_caps(obj), err, out);
> >       CHECK_ERR(bpf_object__elf_collect(obj, flags), err, out);
> >       CHECK_ERR(bpf_object__collect_reloc(obj), err, out);
> >       CHECK_ERR(bpf_object__validate(obj, needs_kver), err, out);
> > @@ -1789,7 +1964,8 @@ int bpf_object__unload(struct bpf_object *obj)
> >
> >       for (i = 0; i < obj->nr_maps; i++)
> >               zclose(obj->maps[i].fd);
> > -
> > +     for (i = 0; i < obj->nr_maps_global; i++)
> > +             zclose(obj->maps_global[i].fd);
> >       for (i = 0; i < obj->nr_programs; i++)
> >               bpf_program__unload(&obj->programs[i]);
> >
> > @@ -1810,7 +1986,6 @@ int bpf_object__load(struct bpf_object *obj)
> >
> >       obj->loaded = true;
> >
> > -     CHECK_ERR(bpf_object__probe_caps(obj), err, out);
> >       CHECK_ERR(bpf_object__create_maps(obj), err, out);
> >       CHECK_ERR(bpf_object__relocate(obj), err, out);
> >       CHECK_ERR(bpf_object__load_progs(obj), err, out);
> >
