Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8518FC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 19:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D86217F5
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 19:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiALaZ/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCNTkc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:40:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36113 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfCNTkc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 15:40:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id v62so6247220otb.3;
        Thu, 14 Mar 2019 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACR6I54ujBl+OjRkjhF5YBdYhBIqfFUJqG9AUY7rC4g=;
        b=tiALaZ/7ekcBECT1+OcHz7aSNv5gwWnNHX4Y1KD8vSpO/RU5X/QJCCjPsjxwYXrL73
         oBl25dOQMFO+a+JlZK8LS0N+ETgSC52/fHBgXzZJM6Vn0CVkYxi2oM6Gjw/PdP+j+RSN
         7glaAiLJ8tDDiIDJP+dmMLUGoXgQh3WqlNIv22q24gHiuy+m2ujYTluCEmrJRTqPHZdG
         MxrhIYErKwhBgUHn3ld/LmIc38C1QmHUZ4Z9tUSTvNjM2ZUTw/r2vGIXxoGX3OBVq6vk
         mUFO4YW3xevOyaTuY3va4EBbZRTYFnWcUgHod3UM/VWADd7CuxqyTqfDJDn0n/KzZ+RA
         tztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACR6I54ujBl+OjRkjhF5YBdYhBIqfFUJqG9AUY7rC4g=;
        b=E+eIcgR6CPzfpdYfpLRuIfnygS06Mzy3A4d3u+fb4TyXYRoGxDuW0WObH3P4/LkfDw
         cBCe6KwU0q/XqATvXARjdK+cALxLGYZG8xQpUcVvF82hC8uV7TFHGaBfW1KzSO8lhhmK
         JDl7vkTXNqe4f3UUqdMOYZt4qmNA2AFBnlJL9oQ6Rm1wSlfJ3yTjBE0pVdpWc67oOqt2
         mmB2Wh8SNKjs2ZA4l/qofFK1bdhLnIYPDxGS7zFcB2mst7I5H8VatOXDhLdkX4QLZ/4y
         /CBN3oZQw8AsHHq/HCPox+luvx6AvYJvjlQ3x4yWzSVqPtwCv2rbZjHRSsb99Z8BbGaE
         PM7A==
X-Gm-Message-State: APjAAAVeTkugwJbR46ElvMmq3kC1XzrgUhtfmCKtxZd30UMwd0Y5UGjD
        9yA9FvCU+ALu99dxHY27591Uwk3OQWyOD4enUnk=
X-Google-Smtp-Source: APXvYqwYxzMdvb+bUFdTH8P34XaFaHHG3CIx2R8UFt/LOcQ9GM8dk+chFjgbH0R8y+r2KuGPHYjvEhRa1GBDgBUO0Ds=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr32258874otk.206.1552592431569;
 Thu, 14 Mar 2019 12:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190311215125.17793-1-daniel@iogearbox.net> <20190311215125.17793-5-daniel@iogearbox.net>
In-Reply-To: <20190311215125.17793-5-daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Mar 2019 12:40:20 -0700
Message-ID: <CAEf4BzaeJe+0WKTRC7utiUh5zqTxpV2e0DSqVrfge2qSzHRfKQ@mail.gmail.com>
Subject: Re: [PATCH rfc v3 bpf-next 4/9] bpf, obj: allow . char as part of the name
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
> Trivial addition to allow '.' aside from '_' as "special" characters
> in the object name. Used to allow for substrings in maps from loader
> side such as ".bss", ".data", ".rodata", but could also be useful for
> other purposes.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Andrii Nakryiko <andriin@fb.com>

> ---
>  kernel/bpf/syscall.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b5ba138351e1..04279747c092 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -456,10 +456,10 @@ static int bpf_obj_name_cpy(char *dst, const char *src)
>         const char *end = src + BPF_OBJ_NAME_LEN;
>
>         memset(dst, 0, BPF_OBJ_NAME_LEN);
> -
> -       /* Copy all isalnum() and '_' char */
> +       /* Copy all isalnum(), '_' and '.' chars. */
>         while (src < end && *src) {
> -               if (!isalnum(*src) && *src != '_')
> +               if (!isalnum(*src) &&
> +                   *src != '_' && *src != '.')
>                         return -EINVAL;
>                 *dst++ = *src++;
>         }
> --
> 2.17.1
>
