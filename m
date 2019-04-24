Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3496C282E1
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B457320685
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 18:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPYvH8GU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387997AbfDXSM7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:12:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41417 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387916AbfDXSM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 14:12:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id l199so1751469qke.8;
        Wed, 24 Apr 2019 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqMByqdoSGjeWKq3qP9GG935RK9Cr2q1RzPsKeyvz+c=;
        b=tPYvH8GUH4bVf12f4ewkrS43mGIRW5G8a3lVY5z4OUsvj4CedCZKU5JmlCaT6RdD2I
         i+hX7/E1l0F32L9IemSgfHm8OG24am1hUBrZrXwoPXIzfdUVXWWNkFxTckxkgIA6TrNu
         zVMW0OEFATjQs1eqHEm4FFWRYjUQYaG26VlDcHQW1gw+Mcmr663KidiDZx7s2J2Yqmxx
         0k1sObq6201yr6zLr9iIdgp6n1W0kZ3Cy24BMB5VSH/KPD9kAA81nZMjpFNYRyqTNl5G
         rbESB8K0MVZCGGRIZnI9W1eLhSfmpQolCZlJtmvYeauHVgxyP0PeoE+9M2zDLyW1Tg8x
         zCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqMByqdoSGjeWKq3qP9GG935RK9Cr2q1RzPsKeyvz+c=;
        b=ayPMLe+Yykf0OOnItchqN8C+q3y85jpm4BsS7gZXEcNKYdaToP7XGt9xL/07LD/mFd
         U697E0i7mTiUsQCtzRqKL2Z/CzO3VBnijuK+rZ4+XXOnyxnwy8E3Ld3XLPpLFoXFXITI
         Xxa5wLjXakCIZEOZmewmZl+ZI2SMKhJtmlzanTZiey2nG2u26+CxiQkdldV7r+0V71GH
         SClbGbpASTO2VdgObJoDUL8QRLLOv62Y+boc1BPzGZ/Hflsxl3DXkKOwLkuSjNW3RVus
         ZhEA+Sqwtu1+QlcNIG/h5Fqim/qKKegMWW2p+xb6l/IZdQBd4ARF6qL1apprwU7iC7Qz
         AkwQ==
X-Gm-Message-State: APjAAAXZd2FSPhtrBtvs6ehqh8rzwCTRvFiivaIhYeCNaZgqxqwA4m5V
        VpXDaXFftw6PSRqahh4vd3FKy/uxP329UbFBkRpgF2q3lvs=
X-Google-Smtp-Source: APXvYqy6cNDH4FMsI/UCvgSQA/Uy/pr+jrHDelm4Jl1x8VMTu4g9wmsWbYt3eSRVPxmCME0Vthc5KMja8PoOpaEKkw4=
X-Received: by 2002:a37:8c44:: with SMTP id o65mr8776611qkd.189.1556129577626;
 Wed, 24 Apr 2019 11:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190424052200.1625142-1-andrii.nakryiko@gmail.com>
 <20190424052200.1625142-2-andrii.nakryiko@gmail.com> <94852017-ca8e-78c1-9b98-bdc6b9852e76@fb.com>
In-Reply-To: <94852017-ca8e-78c1-9b98-bdc6b9852e76@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Apr 2019 11:12:46 -0700
Message-ID: <CAEf4BzYXzQH50BsZQ5VoYQxiZ1N2Fz5BamKbzOD5aLgj1_ozQA@mail.gmail.com>
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

On Wed, Apr 24, 2019 at 10:12 AM Yonghong Song <yhs@fb.com> wrote:
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
> This is great. Thanks!
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
> [.....]
> > +
> > +static int do_dump(int argc, char **argv)
> > +{
> > +     struct btf *btf = NULL;
> > +     __u32 root_type_ids[2];
> > +     int root_type_cnt = 0;
> > +     __u32 btf_id = -1;
> > +     const char *src;
> > +     int fd = -1;
> > +     int err;
> > +
> > +     if (!REQ_ARGS(2)) {
> > +             usage();
> > +             return -1;
> > +     }
> > +     src = GET_ARG();
> > +
> > +     if (is_prefix(src, "map")) {
> > +             struct bpf_map_info info = {};
> > +             __u32 len = sizeof(info);
> > +
> > +             if (!REQ_ARGS(2)) {
> > +                     usage();
> > +                     return -1;
> > +             }
> > +
> > +             fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> > +             if (fd < 0)
> > +                     return -1;
> > +
> > +             btf_id = info.btf_id;
> > +             if (argc && is_prefix(*argv, "key")) {
> > +                     root_type_ids[root_type_cnt++] = info.btf_key_type_id;
> > +                     NEXT_ARG();
> > +             } else if (argc && is_prefix(*argv, "value")) {
> > +                     root_type_ids[root_type_cnt++] = info.btf_value_type_id;
> > +                     NEXT_ARG();
> > +             } else if (argc && is_prefix(*argv, "all")) {
> > +                     NEXT_ARG();
> > +             } else if (argc && is_prefix(*argv, "kv")) {
> > +                     root_type_ids[root_type_cnt++] = info.btf_key_type_id;
> > +                     root_type_ids[root_type_cnt++] = info.btf_value_type_id;
> > +                     NEXT_ARG();
> > +             } else {
> > +                     root_type_ids[root_type_cnt++] = info.btf_key_type_id;
> > +                     root_type_ids[root_type_cnt++] = info.btf_value_type_id;
> > +             }
> > +     } else if (is_prefix(src, "prog")) {
> > +             struct bpf_prog_info info = {};
> > +             __u32 len = sizeof(info);
> > +
> > +             if (!REQ_ARGS(2)) {
> > +                     usage();
> > +                     return -1;
> > +             }
> > +
> > +             fd = prog_parse_fd(&argc, &argv);
> > +             if (fd < 0)
> > +                     return -1;
> > +
> > +             err = bpf_obj_get_info_by_fd(fd, &info, &len);
> > +             if (err) {
> > +                     p_err("can't get prog info: %s", strerror(errno));
> > +                     goto done;
> > +             }
> > +
> > +             btf_id = info.btf_id;
> > +     } else if (is_prefix(src, "id")) {
> > +             char *endptr;
> > +
> > +             btf_id = strtoul(*argv, &endptr, 0);
> > +             if (*endptr) {
> > +                     p_err("can't parse %s as ID", **argv);
> > +                     return -1;
> > +             }
> > +             NEXT_ARG();
> > +     } else if (is_prefix(src, "file")) {
> > +             err = btf_load_from_elf(*argv, &btf);
> > +             if (err)
> > +                     goto done;
> > +             NEXT_ARG();
> > +     }
>
> Another "else" branch here to handle wrong prefix? Otherwise, it will
> fall down to "can't find btf with ID (4294967295)" where "4294967295 ==
> -1) which is a little misleading for users.

Yep, makes sense, will add, not sure why I haven't done that in the
first place...

>
> > +
> > +     if (!btf) {
> > +             err = btf__get_from_id(btf_id, &btf);
> > +             if (err) {
> > +                     p_err("get btf by id (%u): %s", btf_id, strerror(err));
> > +                     goto done;
> > +             }
> > +             if (!btf) {
> > +                     err = ENOENT;
> > +                     p_err("can't find btf with ID (%u)", btf_id);
> > +                     goto done;
> > +             }
> > +     }
> > +
> > +     dump_btf_raw(btf, root_type_ids, root_type_cnt);
> > +
> > +done:
> > +     close(fd);
> > +     btf__free(btf);
> > +     return err;
> > +}
> > +
> > +static int do_help(int argc, char **argv)
> > +{
> > +     if (json_output) {
> > +             jsonw_null(json_wtr);
> > +             return 0;
> > +     }
> > +
> > +     fprintf(stderr,
> > +             "Usage: %s btf dump       BTF_SRC\n"
> > +             "       %s btf help\n"
> > +             "\n"
> > +             "       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | elf FILE }\n"
>
> "elf FILE" is not consistent with implementation. The implementation
> uses "file FILE". I prefer to use "file FILE".

Oops, yep, it should be file.

>
> > +             "       " HELP_SPEC_MAP "\n"
> > +             "       " HELP_SPEC_PROGRAM "\n"
> > +             "       " HELP_SPEC_OPTIONS "\n"
> > +             "",
> > +             bin_name, bin_name);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct cmd cmds[] = {
> > +     { "help",       do_help },
> > +     { "dump",       do_dump },
> > +     { 0 }
> > +};
> > +
> > +int do_btf(int argc, char **argv)
> > +{
> > +     return cmd_select(cmds, argc, argv, do_help);
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
