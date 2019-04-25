Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C171FC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF861206C1
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 22:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXfEMCmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfDYWA7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:00:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40899 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfDYWA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 18:00:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id y49so1941497qta.7;
        Thu, 25 Apr 2019 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3JsbHFa0ry8wYGCjAlqnlenQrB7Hvzfhjv9scpuLGg=;
        b=pXfEMCmYr0dTVnuu+ECKTXm9Hhqjm69sqC77awYJlespTtBbmLQf6zkgeRXa2t8ykd
         HDzmJmuGRXSidIKqHoMW5rEXRkRP/6HGyIYhybC4znBinbGwrXP4YFENwzG1VMd/Nb1L
         sdHhZVwzsH/a9jB5d9gbQXyRZwN5ktFSPROGNkM7lBP5DSgFKX0RnaHTsSUcuyU7ebJi
         qUvTv7Efm/6TV/WRWWnQUeNBkgdekPf/zP/6xrXePQrzeti3olyDTBJvqUZbI4nPraSr
         rm5n8CIMwI/xKao3gjCNUMCqUPn6tNneKdJPdFZ5uCLqLPkqQykYUSpvAD0IdLqnqa5n
         kPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3JsbHFa0ry8wYGCjAlqnlenQrB7Hvzfhjv9scpuLGg=;
        b=L4P6kGjxFaH/D9fHa8syxkfRnClbi9Vc3qim6HEVl16NblTnq/d3cgYGmn2BkQVeD1
         JcrP6BCKv59bPcyNI+5bBf2CxwKSmROiV9MqR6q8vCbJ2kPOE6f+p3ZRr4XumvcXNVuN
         vW9MvYuJGZ71x9w8sHgmi7xCr7+DWtbZsAoPSXYKQCFrilwMn4UxUvz8rhwA07h1XZdM
         oDDi0wT+NKVYGaeuMZkmzC5FehXL1vuYhjwPx7XJjqZuz8cF0gEyuKwTAIjBaTlDl5Iy
         VvhBf1G9qYNFExRkkVJOuV+RFEAJ9P7I36lLj52/JPgQ6c2CRcINBvgrQIA2z7AeFGw6
         V0+A==
X-Gm-Message-State: APjAAAXoVJpuGXwq/SevTIf2yo3muYiJ8LgtV1lbHa4dkXPtQPHvf4li
        IYf+An4fAXHExMuTNaCWBNgWdkThjWaxZ44kk7c=
X-Google-Smtp-Source: APXvYqxmdoylklgCbvH7ct0XrVPacUGwFGhiz2grM24V9fKmrMjtn8IfDIzP0sneD3s3CGXyO+d5METqWAEE6BraM4M=
X-Received: by 2002:a0c:b753:: with SMTP id q19mr31670232qve.69.1556229657676;
 Thu, 25 Apr 2019 15:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190425165539.3317350-1-andriin@fb.com> <20190425165539.3317350-2-andriin@fb.com>
 <e6654ecd-c102-858f-2d9e-a9394ec28895@netronome.com>
In-Reply-To: <e6654ecd-c102-858f-2d9e-a9394ec28895@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Apr 2019 15:00:46 -0700
Message-ID: <CAEf4BzbboN0rLqNywMuR79+E9Gqm2OCpT8m8DmwABMRLwwUdMA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/4] bpftool: add ability to dump BTF types
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin Lau <kafai@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 12:20 PM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2019-04-25 09:55 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
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
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >   tools/bpf/bpftool/btf.c  | 580 +++++++++++++++++++++++++++++++++++++++
> >   tools/bpf/bpftool/main.c |   3 +-
> >   tools/bpf/bpftool/main.h |   1 +
> >   3 files changed, 583 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/bpf/bpftool/btf.c
> >
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > new file mode 100644
> > index 000000000000..cbf04850c798
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -0,0 +1,580 @@
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
>
> Can we have as in prog.c/map.c: standard includes sorted alphabetically,
> then linux/ includes, then bpf includes?

Sure, will do.

>
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
> > +static const char *btf_str(const struct btf *btf, __u32 off)
> > +{
> > +     if (!off)
> > +             return "(anon)";
> > +     return btf__name_by_offset(btf, off) ? : "(invalid)";
> > +}
> > +
> > +static int dump_btf_type(const struct btf *btf, __u32 id,
> > +                      const struct btf_type *t)
> > +{
> > +     int kind = BTF_INFO_KIND(t->info);
> > +     int safe_kind = kind <= BTF_KIND_MAX ? kind : BTF_KIND_UNKN;
> > +     json_writer_t *w = json_wtr;
>
> Can we keep reverse-Christmas tree style for declarations? Assigning the
> values can be done on its own after the declarations.

Ok.

>
> > +
> > +     if (json_output) {
> > +             jsonw_start_object(w);
> > +             jsonw_uint_field(w, "id", id);
> > +             jsonw_string_field(w, "kind", btf_kind_str[safe_kind]);
> > +             jsonw_string_field(w, "name", btf_str(btf, t->name_off));
> > +     } else {
> > +             printf("[%u] %s '%s'", id, btf_kind_str[safe_kind],
> > +                    btf_str(btf, t->name_off));
> > +     }
> > +
> > +     switch (BTF_INFO_KIND(t->info)) {
> > +     case BTF_KIND_INT: {
> > +             __u32 v = *(__u32 *)(t + 1);
> > +             const char *enc = btf_int_enc_str(BTF_INT_ENCODING(v));
>
> Same thing here.

Fixing.

>
> > +
> > +             if (json_output) {
> > +                     jsonw_uint_field(w, "size", t->size);
> > +                     jsonw_uint_field(w, "bits_offset", BTF_INT_OFFSET(v));
> > +                     jsonw_uint_field(w, "nr_bits", BTF_INT_BITS(v));
> > +                     jsonw_string_field(w, "encoding", enc);
> > +             } else {
> > +                     printf(" size=%u bits_offset=%u nr_bits=%u encoding=%s",
> > +                            t->size, BTF_INT_OFFSET(v), BTF_INT_BITS(v),
> > +                            enc);
> > +             }
> > +             break;
> > +     }
> > +     case BTF_KIND_PTR:
>
> [...]
>
> printf(" type_id=%u", t->type);
> > +             break;
> > +     case BTF_KIND_FUNC_PROTO: {
> > +             const struct btf_param *p = (const void *)(t + 1);
> > +             __u16 vlen = BTF_INFO_VLEN(t->info);
> > +             int i;
> > +
> > +             if (json_output) {
> > +                     jsonw_uint_field(w, "ret_type_id", t->type);
> > +                     jsonw_uint_field(w, "vlen", vlen);
> > +                     jsonw_name(w, "params");
> > +                     jsonw_start_array(w);
> > +             } else {
> > +                     printf(" ret_type_id=%u vlen=%u", t->type, vlen);
> > +             }
> > +             for (i = 0; i < vlen; i++, p++) {
> > +                     const char *name = btf_str(btf, p->name_off);
> > +
> > +                     if (json_output) {
> > +                             jsonw_start_object(w);
> > +                             jsonw_string_field(w, "name", name);
> > +                             jsonw_uint_field(w, "type_id", p->type);
> > +                             jsonw_end_object(w);
> > +                     } else {
> > +                             printf("\n\t'%s' type_id=%u", name, p->type);
> > +                     }
> > +             }
> > +             if (json_output)
> > +                     jsonw_end_array(w);
> > +             break;
> > +     }
> > +     case BTF_KIND_VAR: {
> > +             const struct btf_var *v = (const void *)(t + 1);
> > +             const char *linkage = btf_var_linkage_str(v->linkage);
>
> And here please.
>
> > +
> > +             if (json_output) {
> > +                     jsonw_uint_field(w, "type_id", t->type);
> > +                     jsonw_string_field(w, "linkage", linkage);
> > +             } else {
> > +                     printf(" type_id=%u, linkage=%s", t->type, linkage);
> > +             }
> > +             break;
> > +     }
> > +     case BTF_KIND_DATASEC: {
>
> [...]
>
> > +static int do_help(int argc, char **argv)
> > +{
> > +     if (json_output) {
> > +             jsonw_null(json_wtr);
> > +             return 0;
> > +     }
> > +
> > +     fprintf(stderr,
> > +             "Usage: %s btf dump       BTF_SRC\n"
>
> Why so much space between "dump" and "BTF_SRC"?

Followed map.c's style, which has that much space (though in that case
it's aligned on longest command). But seems like prog.c doesn't follow
that. I'll make spacing tighter.
