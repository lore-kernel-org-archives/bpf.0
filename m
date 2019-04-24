Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1624FC282E1
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D165820685
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzsjECaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbfDXSRC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:17:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47020 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732944AbfDXSRC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 14:17:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id w73so9268692qkb.13;
        Wed, 24 Apr 2019 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJ13m2JAt52dn3hlEQov4A1vri+FEKsuux71s6SxwnQ=;
        b=LzsjECaLNgYKvgQccnBaWThlzLgw16q7bQ8PWvp9iL0Wyf86+Hp9/NC+DMUoqusJOJ
         zwqZSNmbrQ0ofcFPTgnjZosLr9MqknuOPVutpQviVXCnP+T5BN67cJvLRzemKLoaqozP
         Nv01pSZVC/Y+053qqcfAax4Tpga6KVcXMQ6rGnhop0n2pN1FdmopKJ6H/41l6MaLJrhv
         7DtHduS1E/KNDKZ/s4GBUkQKjfIsdLzONrUNjEnfkXzL+d2BaOy3romYJwdDUj10cqmk
         k17yPCyDV0qSTR/HSZ6o1ehKG+hxs6E24dsiW5gfqh8gGbfr8VxH+OKyl4oakE/v8TWu
         9aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJ13m2JAt52dn3hlEQov4A1vri+FEKsuux71s6SxwnQ=;
        b=iv5HVGtKPktwB8KlL4u2ct1ijJznJ44q8+XCMGi8Yq7Y8jQDlLgQYN0IYewfKwIlWl
         OBOxnZVf3DslZCslX+BRY1rB5n99ErFuDCNH4ClNHb8M6dhraJ6LYVqpat7LyW6iLUFJ
         uuC7N6L/TrOp6iidH+X9T/0YnS5cwpBidGZZ6gTMOwoJZ5/7GFinv06EOo1BPJ8wI4q4
         JAkr08jIZTnvoOE5E9QayP1hOMV37YzcXMAwzPL6N3H61ctTXWB5sxkTUZLaBK8OTINT
         SpTexSAEjNKDCU5hK2ZmNbzbbTvG29aqu31NCGfgyxWVjYLIRdQvxL0lpC9HJWsCdjtX
         D7Xg==
X-Gm-Message-State: APjAAAUsv24KayXcPXTOUHuN1sssutZeZAKIKH9lQgFAcuSx4Q/GQBRo
        hBsMixfqRGrU1Tydugxlf4+NLK7P/fBQ/Pxl2wU=
X-Google-Smtp-Source: APXvYqzLG4d667HyFXy0yjM0OuIcFgzn/LJOHo+WkhK9TEt3LJOSI539ALMJGOTZJ4PNKBlEpK2mlyqLdBxKH1hS3y4=
X-Received: by 2002:ae9:f30f:: with SMTP id p15mr26583636qkg.182.1556129820912;
 Wed, 24 Apr 2019 11:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190424052200.1625142-1-andrii.nakryiko@gmail.com>
 <20190424052200.1625142-2-andrii.nakryiko@gmail.com> <c149c047-7b6a-bb8b-d472-6ea01a9e4caa@fb.com>
In-Reply-To: <c149c047-7b6a-bb8b-d472-6ea01a9e4caa@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Apr 2019 11:16:48 -0700
Message-ID: <CAEf4BzYaeWZEHQCJHfoYs6MT3emYbTfFQwLnXgudp7w9YDyrDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: add ability to dump BTF types
To:     Yonghong Song <yhs@fb.com>
Cc:     Kernel Team <Kernel-team@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Martin Lau <kafai@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 24, 2019 at 10:17 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/23/19 10:21 PM, andrii.nakryiko@gmail.com wrote:
> > From: Andrii Nakryiko <andriin@fb.com>
> >
> > Add new `btf dump` sub-command to bpftool. It allows to dump
> > human-readable low-level BTF types representation of BTF types. BTF can
> > be retrieved from few different sources:
> >    - from BTF object by ID;
> >    - from PROG, if it has associated BTF;
> >    - from MAP, if it has associated BTF data; it's possible to narrow
> >      down types to either key type, value type, both, or all BTF types;
> >    - from ELF file (.BTF section).
> >
> > Output format mostly follows BPF verifier log format with few notable
> > exceptions:
> >    - all the type/field/param/etc names are enclosed in single quotes to
> >      allow easier grepping and to stand out a little bit more;
> >    - FUNC_PROTO output follows STRUCT/UNION/ENUM format of having one
> >      line per each argument; this is more uniform and allows easy
> >      grepping, as opposed to succinct, but inconvenient format that BPF
> >      verifier log is using.
> >
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@fb.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Song Liu <songliubraving@fb.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >   tools/bpf/bpftool/btf.c  | 576 +++++++++++++++++++++++++++++++++++++++
> >   tools/bpf/bpftool/main.c |   1 +
> >   tools/bpf/bpftool/main.h |   1 +
> >   3 files changed, 578 insertions(+)
> >   create mode 100644 tools/bpf/bpftool/btf.c
> >
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > new file mode 100644
> > index 000000000000..afe5cb7bab0c
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -0,0 +1,576 @@
> > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +/* Copyright (C) 2019 Facebook */
> > +
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <linux/err.h>
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <gelf.h>
> > +#include <bpf.h>
> > +#include <linux/btf.h>
> > +
> > +#include "btf.h"
> > +#include "json_writer.h"
> > +#include "main.h"
> > +
> > +static const char * const btf_kind_str[NR_BTF_KINDS] = {
> > +     [BTF_KIND_UNKN]         = "UNKNOWN",
> > +     [BTF_KIND_INT]          = "INT",
> > +     [BTF_KIND_PTR]          = "PTR",
> > +     [BTF_KIND_ARRAY]        = "ARRAY",
> > +     [BTF_KIND_STRUCT]       = "STRUCT",
> > +     [BTF_KIND_UNION]        = "UNION",
> > +     [BTF_KIND_ENUM]         = "ENUM",
> > +     [BTF_KIND_FWD]          = "FWD",
> > +     [BTF_KIND_TYPEDEF]      = "TYPEDEF",
> > +     [BTF_KIND_VOLATILE]     = "VOLATILE",
> > +     [BTF_KIND_CONST]        = "CONST",
> > +     [BTF_KIND_RESTRICT]     = "RESTRICT",
> > +     [BTF_KIND_FUNC]         = "FUNC",
> > +     [BTF_KIND_FUNC_PROTO]   = "FUNC_PROTO",
> > +     [BTF_KIND_VAR]          = "VAR",
> > +     [BTF_KIND_DATASEC]      = "DATASEC",
> > +};
> > +
> > +static const char *btf_int_enc_str(__u8 encoding)
> > +{
> > +     switch (encoding) {
> > +     case 0:
> > +             return "(none)";
> > +     case BTF_INT_SIGNED:
> > +             return "SIGNED";
> > +     case BTF_INT_CHAR:
> > +             return "CHAR";
> > +     case BTF_INT_BOOL:
> > +             return "BOOL";
> > +     default:
> > +             return "UNKN";
> > +     }
> > +}
> > +
> > +static const char *btf_var_linkage_str(__u32 linkage)
> > +{
> > +     switch (linkage) {
> > +     case BTF_VAR_STATIC:
> > +             return "static";
> > +     case BTF_VAR_GLOBAL_ALLOCATED:
> > +             return "global-alloc";
> > +     default:
> > +             return "(unknown)";
> > +     }
> > +}
> > +
> [...]
> > +
> > +static bool check_btf_endianness(GElf_Ehdr *ehdr)
> > +{
> > +     static unsigned int const endian = 1;
> > +
> > +     switch (ehdr->e_ident[EI_DATA]) {
> > +     case ELFDATA2LSB:
> > +             return *(unsigned char const *)&endian == 1;
> > +     case ELFDATA2MSB:
> > +             return *(unsigned char const *)&endian == 0;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static int btf_load_from_elf(const char *path, struct btf **btf)
> > +{
> > +     int err = -1, fd = -1, idx = 0;
> > +     Elf_Data *btf_data = NULL;
> > +     Elf_Scn *scn = NULL;
> > +     Elf *elf = NULL;
> > +     GElf_Ehdr ehdr;
> > +
> > +     if (elf_version(EV_CURRENT) == EV_NONE) {
> > +             p_err("failed to init libelf for %s", path);
> > +             return -1;
> > +     }
> > +
> > +     fd = open(path, O_RDONLY);
> > +     if (fd < 0) {
> > +             p_err("failed to open %s: %s", path, strerror(errno));
> > +             return -1;
> > +     }
> > +
> > +     elf = elf_begin(fd, ELF_C_READ, NULL);
> > +     if (!elf) {
> > +             p_err("failed to open %s as ELF file", path);
> > +             goto done;
> > +     }
> > +     if (!gelf_getehdr(elf, &ehdr)) {
> > +             p_err("failed to get EHDR from %s", path);
> > +             goto done;
> > +     }
> > +     if (!check_btf_endianness(&ehdr)) {
> > +             p_err("non-native ELF endianness is not supported");
>
> We should relex this. It is possible that for some embedded system,
> bpftool is running on some x86 server examining a objfile file used
> for an embedded system.

I agree, but I think that should be done in libbpf. I've been meaning
to add that for a while now, but never got around to that, it's still
on my TODO list.

My intent is to teach btf__new to look at BTF header, and if it's
endianness is not native, convert all the integers to native
endianness. That way, struct btf is always of native endianness in
memory and won't require any extra checks from other code. I'll do it
some time soonish at which point both pahole (which handles this
explicitly right now) and bpftool can greatly benefit from that. How
does that sound?

>
> > +             goto done;
> > +     }
> > +     if (!elf_rawdata(elf_getscn(elf, ehdr.e_shstrndx), NULL)) {
> > +             p_err("failed to get e_shstrndx from %s\n", path);
> > +             goto done;
> > +     }
> > +
> > +     while ((scn = elf_nextscn(elf, scn)) != NULL) {
> > +             GElf_Shdr sh;
> > +             char *name;
> > +
> > +             idx++;
> > +             if (gelf_getshdr(scn, &sh) != &sh) {
> > +                     p_err("failed to get section(%d) header from %s",
> > +                           idx, path);
> > +                     goto done;
> > +             }
> > +             name = elf_strptr(elf, ehdr.e_shstrndx, sh.sh_name);
> > +             if (!name) {
> > +                     p_err("failed to get section(%d) name from %s",
> > +                           idx, path);
> > +                     goto done;
> > +             }
> > +             if (strcmp(name, BTF_ELF_SEC) == 0) {
> > +                     btf_data = elf_getdata(scn, 0);
> > +                     if (!btf_data) {
> > +                             p_err("failed to get section(%d, %s) data from %s",
> > +                                   idx, name, path);
> > +                             goto done;
> > +                     }
> > +                     break;
> > +             }
> > +     }
> > +
> > +     if (!btf_data) {
> > +             p_err("%s ELF section not found in %s", BTF_ELF_SEC, path);
> > +             goto done;
> > +     }
> > +
> > +     *btf = btf__new(btf_data->d_buf, btf_data->d_size);
> > +     if (IS_ERR(*btf)) {
> > +             err = PTR_ERR(*btf);
> > +             *btf = NULL;
> > +             p_err("failed to load BTF data from %s: %s",
> > +                   path, strerror(err));
> > +             goto done;
> > +     }
> > +
> > +     err = 0;
> > +done:
> > +     if (err) {
> > +             if (*btf) {
> > +                     btf__free(*btf);
> > +                     *btf = NULL;
> > +             }
> > +     }
> > +     if (elf)
> > +             elf_end(elf);
> > +     close(fd);
> > +     return err;
> > +}
> > +
> [...]
> > +}
> > diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> > index a9d5e9e6a732..eba56edd7c77 100644
> > --- a/tools/bpf/bpftool/main.c
> > +++ b/tools/bpf/bpftool/main.c
> > @@ -188,6 +188,7 @@ static const struct cmd cmds[] = {
> >       { "perf",       do_perf },
> >       { "net",        do_net },
> >       { "feature",    do_feature },
> > +     { "btf",        do_btf },
> >       { "version",    do_version },
> >       { 0 }
> >   };
> > diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> > index 1ccc46169a19..3d63feb7f852 100644
> > --- a/tools/bpf/bpftool/main.h
> > +++ b/tools/bpf/bpftool/main.h
> > @@ -150,6 +150,7 @@ int do_perf(int argc, char **arg);
> >   int do_net(int argc, char **arg);
> >   int do_tracelog(int argc, char **arg);
> >   int do_feature(int argc, char **argv);
> > +int do_btf(int argc, char **argv);
> >
> >   int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
> >   int prog_parse_fd(int *argc, char ***argv);
> >
