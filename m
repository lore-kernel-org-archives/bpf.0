Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858C1C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 19:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B722084D
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 19:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inzXZNfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfBYTml (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:42:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46408 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYTml (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 14:42:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id j135so8276317oib.13;
        Mon, 25 Feb 2019 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuzVp6F8/hRM6JfFSuodsE9UCuDXBsnRQADd/RiOkSo=;
        b=inzXZNfl9XNuJev3iQmWqBZmzMY/YJwaVPQcCzL8cRT/3veKGSKUoBpETBms+udTlh
         EY9XkbLoytGX9oJY6bP9NNe17wYNfZUJvcZ7ZrSShDwnuewWhQPcOhv36waPS7CxMXxX
         v4ytAZjfhxxFdSMtBrRVy030LGyZ4bayWcLsMcJ/uVHhCrvw1NW6dJ14uL7OgG2fCBIG
         5jDxjDIVbiQBNrNKnxU5+v/qt7whViqleq/FGvnFXBzArg1QN8JHPvOrSYt42VSGuOzL
         Gg5HxbGh1EcqHjuV4wYJTguzUEipe4+7dm4MqMjYZPb8Ld+s6WAV6maz6Wogd7UICJUy
         YlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuzVp6F8/hRM6JfFSuodsE9UCuDXBsnRQADd/RiOkSo=;
        b=sw+1aCNk+0Iz4NDcVvOcepTilsdWSd7wCSIlBaZaHR4deZmYrL9A8uRqqGMj3CiF9b
         YhkVI+D9HWzGNY6nZSaj6x9Q2xtQsqvpUhVPfO5AGlJi9NqfmJ5OttiDP0UpZS1ZN65o
         IJuoCnnhl9DMsxB+zmhsaCqR2JhhWZ10tA4wejKT8HNspAbzJiP01oDHZZKC5xLGLIdp
         VYajktOwah9LG2sciJ6FowJgBXh096wihZcb82oIuXzZL4SmWlIAkcc98Lq9gMc6Htfd
         Z+ugkUnxuKyJv0VNJGXhv5lHIuwe0IDo3C3gl1wIqwDxqm+TuY5U9FIsOqHjuFBXT/dD
         rHQw==
X-Gm-Message-State: AHQUAuZUJKfId5XVVHiLV3N52I5X5Se4jQrF+/TGpGvxaKPWWqAXFL/W
        kjgkyxNIXmkMwToNGenVGgkdI/6zcYwNd7GMyDI=
X-Google-Smtp-Source: AHgI3Ia0qxwWVvOiIbE00B/Ovl25ReEyZK6Wj3/5yjgk0rC/M/U055SQBv0XBN7YXeLBJ2cTY6Ro5WRyOxAkDudAHYg=
X-Received: by 2002:aca:3bd5:: with SMTP id i204mr12645731oia.167.1551123760319;
 Mon, 25 Feb 2019 11:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20190220205732.2514975-1-andriin@fb.com> <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
In-Reply-To: <20190225185949.GT31136@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 11:42:29 -0800
Message-ID: <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com>
Subject: Re: [PATCH pahole 0/3] fix handling of bitfields in btf_loader
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 11:00 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > So yeah, the BTF encoder/decoder is working just fine, the problem is in
> > pahole's DWARF code, lemme see...
>
> Please try the patch below, for me btfdiff continues to show no diff for
> all types in my vmlinux and now it also produces the same output for
> when the first element of a bitfield has its bit_size equal to its
> byte_size * 8:

Yes, this fixes all the issues I've seen. btfdiff output is now empty
for my kernel image. Thanks for quick fix!

Reviewed-by: Andrii Nakryiko <andriin@fb.com>

>
> [acme@quaco pahole]$ btfdiff vmlinux
> [acme@quaco pahole]$ btfdiff examples/andrii/hsw_tsx_tuning-gcc
> [acme@quaco pahole]$ btfdiff examples/andrii/hsw_tsx_tuning-clang
> [acme@quaco pahole]$ pahole examples/andrii/hsw_tsx_tuning-clang
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
> [acme@quaco pahole]$ pahole -F btf examples/andrii/hsw_tsx_tuning-clang
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
> [acme@quaco pahole]$
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index adef437109f6..37477fb23be3 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -607,7 +607,8 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu)
>
>  int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t bit_size)
>  {
> -       uint16_t id;
> +       int id;
> +       uint16_t short_id;
>         struct tag *recoded;
>         /* in all the cases the name is at the same offset */
>         strings_t name = tag__namespace(tag)->name;
> @@ -620,7 +621,7 @@ int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t bit_size
>                 struct tag *type = dtype->tag;
>
>                 id = tag__recode_dwarf_bitfield(type, cu, bit_size);
> -               if (id == tag->type)
> +               if (id < 0)
>                         return id;
>
>                 struct type *new_typedef = obstack_zalloc(&cu->obstack,
> @@ -660,10 +661,9 @@ int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t bit_size
>                  * the dwarf_cu as in dwarf there are no such things
>                  * as base_types of less than 8 bits, etc.
>                  */
> -               recoded = cu__find_base_type_by_sname_and_size(cu, name, bit_size, &id);
> +               recoded = cu__find_base_type_by_sname_and_size(cu, name, bit_size, &short_id);
>                 if (recoded != NULL)
> -                       return id;
> -
> +                       return short_id;
>
>                 struct base_type *new_bt = obstack_zalloc(&cu->obstack,
>                                                           sizeof(*new_bt));
> @@ -683,10 +683,9 @@ int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t bit_size
>                  * the dwarf_cu as in dwarf there are no such things
>                  * as enumeration_types of less than 8 bits, etc.
>                  */
> -               recoded = cu__find_enumeration_by_sname_and_size(cu, name,
> -                                                                bit_size, &id);
> +               recoded = cu__find_enumeration_by_sname_and_size(cu, name, bit_size, &short_id);
>                 if (recoded != NULL)
> -                       return id;
> +                       return short_id;
>
>                 struct type *alias = tag__type(tag);
>                 struct type *new_enum = obstack_zalloc(&cu->obstack, sizeof(*new_enum));
