Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFEEC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 21:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6882087C
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 21:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8efRVs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfCNVFQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:05:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38034 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfCNVFQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 17:05:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id a15so5624749oid.5;
        Thu, 14 Mar 2019 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FFfSxxSU2EElzQovPmq3n0ljqourgdqSipQml16+Fk=;
        b=M8efRVs0TM3V1BgZPrMoAgAPfWZ6kKxSnaa7xUPDYtNaqWUIPXdNfKaBzFXWHHlZgY
         fQd8yZt5/BvHbeqfc82fuohMSO2Ezn8bExR8FsoLb4PLmAyBfjD6Cg8HoB2SChTk5T8Z
         iWHGDXbH4NOdCoK5Pia0rhZaFehNh4tccvNFuPm/0AX68YZ5lszAJ6UFLx5P5HSmOIkP
         lY1Kh4at7HvEgq1fTsA7awSDBWz1p1cO5Fa3k7NbXDNMZ6UyJLU+TC8U0mY3G3odDC+Y
         H21ypmIJtTzIpupwEU3ASfBGMj6qT+vvN4WA/YktoNrqzCpTbFYDKSqw2ZyJyAL2gav2
         9KKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FFfSxxSU2EElzQovPmq3n0ljqourgdqSipQml16+Fk=;
        b=fX8jn6mGqioz+IFDpjNrW6ht6sBCWLqnMr42xpxUV4qRxUaRAaYZsO+ZZHBd+eAf5g
         L8lO2fyJXWqjvXJiAphwl5j+IX5coQ6qR2ZgNJpg3h4q9PzgK47KCA1yamGIc9ODzdUS
         iXeHr5E/ZHs8q8ritHrM1TlRkCWcaJ9hK2RLEF9jppyNlnnh/QM58ynaLR4K8pBqsfFE
         B4YD7JImp9SY0OwJUQQsVYPINKuT4e/kSpOIMkI0PpvWp5RMZZmNVYIWnSsn+WXZH5yR
         M79vHatgXGUlIqZPAb4xJ/MtPhcRAnN7AXlMxU9FxJW6b9WMyiCGqUupEdRp5juf8G/+
         kpjg==
X-Gm-Message-State: APjAAAUeULCqf5jU7XVQMWRKq6ZjtgXeYPYIywT2wYYFJxVDls1wfojJ
        BKf0+o48UmDceu4iWaSWAG6easQiCR9LGeRvFv4=
X-Google-Smtp-Source: APXvYqwQZvbyxRpe/RU/Zogej9deJ9Ruj5h1JCo90BYD5Mh80MbRj1YQDyCwONoSlknD+7wHU/5vpmUEE8klM3Pt/zs=
X-Received: by 2002:aca:3ed4:: with SMTP id l203mr353810oia.88.1552597514981;
 Thu, 14 Mar 2019 14:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190311215125.17793-1-daniel@iogearbox.net> <20190311215125.17793-7-daniel@iogearbox.net>
In-Reply-To: <20190311215125.17793-7-daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Mar 2019 14:05:04 -0700
Message-ID: <CAEf4BzY_wkZV0zMD4pAvLdpSMFAbiLq0vLSiRZSgxadgZEfr4w@mail.gmail.com>
Subject: Re: [PATCH rfc v3 bpf-next 6/9] bpf, libbpf: refactor relocation handling
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, tgraf@suug.ch,
        lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 2:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> From: Joe Stringer <joe@wand.net.nz>
>
> Adjust the code for relocations slightly with no functional changes,
> so that upcoming patches that will introduce support for relocations
> into the .data, .rodata and .bss sections can be added independent
> of these changes.
>
> Signed-off-by: Joe Stringer <joe@wand.net.nz>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

lgtm

Acked-by: Andrii Nakryiko <andriin@fb.com>

> ---
>  tools/lib/bpf/libbpf.c | 62 ++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 30 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f5eb60379c8d..0afdb8914386 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -851,20 +851,20 @@ static int bpf_object__elf_collect(struct bpf_object *obj, int flags)
>                                 obj->efile.symbols = data;
>                                 obj->efile.strtabidx = sh.sh_link;
>                         }
> -               } else if ((sh.sh_type == SHT_PROGBITS) &&
> -                          (sh.sh_flags & SHF_EXECINSTR) &&
> -                          (data->d_size > 0)) {
> -                       if (strcmp(name, ".text") == 0)
> -                               obj->efile.text_shndx = idx;
> -                       err = bpf_object__add_program(obj, data->d_buf,
> -                                                     data->d_size, name, idx);
> -                       if (err) {
> -                               char errmsg[STRERR_BUFSIZE];
> -                               char *cp = libbpf_strerror_r(-err, errmsg,
> -                                                            sizeof(errmsg));
> -
> -                               pr_warning("failed to alloc program %s (%s): %s",
> -                                          name, obj->path, cp);
> +               } else if (sh.sh_type == SHT_PROGBITS && data->d_size > 0) {
> +                       if (sh.sh_flags & SHF_EXECINSTR) {
> +                               if (strcmp(name, ".text") == 0)
> +                                       obj->efile.text_shndx = idx;
> +                               err = bpf_object__add_program(obj, data->d_buf,
> +                                                             data->d_size, name, idx);
> +                               if (err) {
> +                                       char errmsg[STRERR_BUFSIZE];
> +                                       char *cp = libbpf_strerror_r(-err, errmsg,
> +                                                                    sizeof(errmsg));
> +
> +                                       pr_warning("failed to alloc program %s (%s): %s",
> +                                                  name, obj->path, cp);
> +                               }
>                         }
>                 } else if (sh.sh_type == SHT_REL) {
>                         void *reloc = obj->efile.reloc;
> @@ -1026,24 +1026,26 @@ bpf_program__collect_reloc(struct bpf_program *prog, GElf_Shdr *shdr,
>                         return -LIBBPF_ERRNO__RELOC;
>                 }
>
> -               /* TODO: 'maps' is sorted. We can use bsearch to make it faster. */
> -               for (map_idx = 0; map_idx < nr_maps; map_idx++) {
> -                       if (maps[map_idx].offset == sym.st_value) {
> -                               pr_debug("relocation: find map %zd (%s) for insn %u\n",
> -                                        map_idx, maps[map_idx].name, insn_idx);
> -                               break;
> +               if (sym.st_shndx == maps_shndx) {
> +                       /* TODO: 'maps' is sorted. We can use bsearch to make it faster. */
> +                       for (map_idx = 0; map_idx < nr_maps; map_idx++) {
> +                               if (maps[map_idx].offset == sym.st_value) {
> +                                       pr_debug("relocation: find map %zd (%s) for insn %u\n",
> +                                                map_idx, maps[map_idx].name, insn_idx);
> +                                       break;
> +                               }
>                         }
> -               }
>
> -               if (map_idx >= nr_maps) {
> -                       pr_warning("bpf relocation: map_idx %d large than %d\n",
> -                                  (int)map_idx, (int)nr_maps - 1);
> -                       return -LIBBPF_ERRNO__RELOC;
> -               }
> +                       if (map_idx >= nr_maps) {
> +                               pr_warning("bpf relocation: map_idx %d large than %d\n",
> +                                          (int)map_idx, (int)nr_maps - 1);
> +                               return -LIBBPF_ERRNO__RELOC;
> +                       }
>
> -               prog->reloc_desc[i].type = RELO_LD64;
> -               prog->reloc_desc[i].insn_idx = insn_idx;
> -               prog->reloc_desc[i].map_idx = map_idx;
> +                       prog->reloc_desc[i].type = RELO_LD64;
> +                       prog->reloc_desc[i].insn_idx = insn_idx;
> +                       prog->reloc_desc[i].map_idx = map_idx;
> +               }
>         }
>         return 0;
>  }
> @@ -1405,7 +1407,7 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
>                         }
>                         insns[insn_idx].src_reg = BPF_PSEUDO_MAP_FD;
>                         insns[insn_idx].imm = obj->maps[map_idx].fd;
> -               } else {
> +               } else if (prog->reloc_desc[i].type == RELO_CALL) {
>                         err = bpf_program__reloc_text(prog, obj,
>                                                       &prog->reloc_desc[i]);
>                         if (err)
> --
> 2.17.1
>
