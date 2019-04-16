Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4B3C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 21:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977332075B
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 21:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1w7ut/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfDPV1r (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:27:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40030 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPV1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 17:27:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so25078058qts.7;
        Tue, 16 Apr 2019 14:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iV8MkoiW8d2iUJ/VdUH8U+BaK2l3aR/0Ul6vDAcbtGc=;
        b=t1w7ut/sMlK49jvpwSLBkd74+6+DoHgX4rMpFgIFeVL5XExEyt8+z8LPcUYIXRXGs1
         2L7ER/gBierrZe730kWjwKGrq4Cg4EHo3t9SCHwJU/tzy8petM+yEXm97rh+inw0kM66
         W5E3BsuIWqMqMoU49mq6csEn+FwuuwZ3CsGxkdfbxaSIojOA85Cs9B8cklvoGVpZxEU1
         4Y3XzADmx6BhP/9UdqFNcUG+m0AX1gaNiUpLOflX4Duyyd+3zreHrsuYfTvuQ1tdC9/I
         CEORfoT4pPmYtcZu5n3OX7rKeMnX/+V9IyiUWU5178RSxrFwiPFybB8bZqwkyWUlH/Db
         i5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iV8MkoiW8d2iUJ/VdUH8U+BaK2l3aR/0Ul6vDAcbtGc=;
        b=hSL8xPbwdBNrc9wDvqhmm0CZFDp5qmvCVe+BGlJwDuJBZ5hmJdxxnZiTar7lwytDYN
         br8FoGgxfas+4tughxypGsPXPZgPpq5Z+2750NAvy2grwW83dZQjyiRr6bZZG/5/3Yu5
         jlQ/xbaS6iTFqHiWZqYUd3K7S0uODVhKTffCYnXuK6jkBibv7Qk/5pMcnC767SMk3RwQ
         +cW719z7wY/FcvexMZf2nx6wpWH/h4oSbfiIzqjtw93Xr5X9Edo1K/j5+2bEpmiugNrV
         dORViLHJg1jOK3PnfgkMwcZ4YHz011PvIAdAeO7TX1RtbGf0xV0/1amlbIPYVfiTZ3nH
         KKWA==
X-Gm-Message-State: APjAAAXCP9n0nF2zlQergXkfFKTwkp+QGA2IzZdtlVOoqgnCaEskMc0E
        +a4u32dL4Zwtyu/n/y/7VlILROdjdkq4PMlUkbs=
X-Google-Smtp-Source: APXvYqxG9iSFh5N38DlQvj81+5rWi7PFvq/z9FEO0kmfb6ZzE+bvx5A4NiOBday8q7hyFXCkCtaEPtp53mdXe8JQxeo=
X-Received: by 2002:a0c:9624:: with SMTP id 33mr68163479qvx.71.1555450066002;
 Tue, 16 Apr 2019 14:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190416184717.1392147-1-andrii.nakryiko@gmail.com>
In-Reply-To: <20190416184717.1392147-1-andrii.nakryiko@gmail.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 16 Apr 2019 14:27:34 -0700
Message-ID: <CAPhsuW5L1hdsy3wHMo+Fsc89iv-HoXki7rnwnbqo1qnLjnsF+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix printf formatter for ptrdiff_t argument
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        evvers@ya.ru, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 16, 2019 at 11:47 AM <andrii.nakryiko@gmail.com> wrote:
>
> From: Andrii Nakryiko <andriin@fb.com>
>
> Using %ld for printing out value of ptrdiff_t type is not portable
> between 32-bit and 64-bit archs. This is causing compilation errors for
> libbpf on 32-bit platform (discovered as part of an effort to integrate
> libbpf into systemd ([0])). Proper formatter is %td, which is used in
> this patch.
>
> v2->v1:
>   - add Reported-by
>   - provide more context on how this issue was discovered
>
> [0] https://github.com/systemd/systemd/pull/12151
>
> Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index e5b77ad97795..d817bf20f3d6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -817,7 +817,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, struct bpf_map *map,
>                 memcpy(*data_buff, data->d_buf, data->d_size);
>         }
>
> -       pr_debug("map %ld is \"%s\"\n", map - obj->maps, map->name);
> +       pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
>         return 0;
>  }
>
> --
> 2.17.1
>
