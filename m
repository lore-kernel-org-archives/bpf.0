Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C128C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 05:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4861C218AE
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 05:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8yY8cNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCAFwq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:52:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43468 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfCAFwq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 00:52:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id i8so18577400oib.10;
        Thu, 28 Feb 2019 21:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikkni3G/pWNgHy7fdkkhWkaq7jI+hZ+AQTxNHugE8Lc=;
        b=q8yY8cNZqTvaqsjpshPZp4X/bi5V7RBxG4xVTzQKP+9AXhk3lPaXHPgzKWrCOnR5/2
         OmXKCqRWvFYbZxGNSlyP6pM4SZrRpX2H7P5CLNuTiJZKIrkCJigoIZ3T2r/T8XiH56Gm
         PKCm14wmrI7PFHneyRpOwC0U+Tdm02q5Eu5gjmv8JlxTdaWoIM8l+vnRQKGhCDhhqZnA
         4SsKrzksB67QODHlH4szL2s3BTDD8CVP11N+GhvCjocatOdQmtT85/eTMoJhAoIGlZcc
         d5TSNumqCb3l3XhL02Mhs4LT77R/DMbqtz+QDET3Ws7QM20k+LQ7LASLPG5IIfYoHeBb
         aWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikkni3G/pWNgHy7fdkkhWkaq7jI+hZ+AQTxNHugE8Lc=;
        b=uWAWL6Y0VWlP6TZ/d+kVNUDhDQqYLXg7bar2MPMgCvIrTfWfazHlVZ2jNmN20nvUN6
         1/ywHn2PTv9nEnlGPjg6gFny2BN4an1gHYy8WVhn14+h9cCM04caQ614rh0Idpugpixi
         A8QzBzk+3EtMgg6xFT/Pf5+hKgu9p2q1AwNfpC+d2A98lhmi1VNsJUYfK0ZZth9y7ZDk
         anf4rMcRuIXYocDG0ZKGUD1h1qgrLVobXls5Hkjcn2HZxMBpqAHT05U811wOvgE/Fqja
         ALsllpWSMkkIiXtVDpHCAxULmG9ydLU0c2dvnIL4p64GONxP6WXcSqPOENdwhejXbvfc
         Y8iw==
X-Gm-Message-State: AHQUAuZJ3e8ccxS0oPEhuqTJ2Aulv5JsxI2B24WAVXcqJrNjq+aWPBjn
        VAu0+//9M9CQom6ELkIWwGK4tqc+7t60J9EdxfI=
X-Google-Smtp-Source: AHgI3IbXiCNvkNdaOWq1geLCsYdbQ/NRI8NkMSMqeHGoNsDUkYUPFC+G3y0qezHprJke9VcTyPKe0+m9OldslNzaIU8=
X-Received: by 2002:aca:3ed4:: with SMTP id l203mr2330588oia.88.1551419565463;
 Thu, 28 Feb 2019 21:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20190228231829.11993-1-daniel@iogearbox.net> <20190228231829.11993-4-daniel@iogearbox.net>
In-Reply-To: <20190228231829.11993-4-daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Feb 2019 21:52:33 -0800
Message-ID: <CAEf4BzYKj6KtAUN8Zisvvp95429cqGgdo4d54LWDtN85_8W3Rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf, obj: allow . char as part of the name
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 3:31 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Trivial addition to allow '.' aside from '_' as "special" characters
> in the object name. Used to name maps from loader side as ".bss",
> ".data", ".rodata".
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Andrii Nakryiko <andriin@fb.com>

> ---
>  kernel/bpf/syscall.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d3ef45e01d7a..90044da3346e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -440,10 +440,10 @@ static int bpf_obj_name_cpy(char *dst, const char *src)
>         const char *end = src + BPF_OBJ_NAME_LEN;
>
>         memset(dst, 0, BPF_OBJ_NAME_LEN);
> -
> -       /* Copy all isalnum() and '_' char */
> +       /* Copy all isalnum(), '_' and '.' chars. */

Is there any reason names are so restrictive? Say, why not '-' as
well? It's perfectly safe even in filenames. Or even '/' and '\'? Is
this name used by anything else in the system, except for
introspection?

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
