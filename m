Return-Path: <SRS0=2TgV=5X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30040C2BA16
	for <bpf@archiver.kernel.org>; Tue,  7 Apr 2020 06:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FEA20692
	for <bpf@archiver.kernel.org>; Tue,  7 Apr 2020 06:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0T4IWqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDGGwu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:52:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37152 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGGwu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Apr 2020 02:52:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id n17so1919185qtv.4;
        Mon, 06 Apr 2020 23:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3DtR8lJo6PTMwtSOd+rDZo3P/UEBQfONul+r7GtLsU=;
        b=J0T4IWqfZlYey7gFpBduMZFlKmMrJI2QJTLGFSL3Qub25yImfM7rA42D1WRalOvS7a
         QIIdY0EUBpHSxjtJF/CzyIoBhfBESDvoEgVScJrbJwBRg2lk/QBsKsnUn3pk++r/L/UM
         u1uufVNUCJIYGyKZeGkrjJjlQVyFHqgc7ksFVhI0PNL+JDpW5e/YaHbmCsFvJJz477xO
         VWyGTA4L8P2kKesky/9pfxzrjQMsqs8X/ShR19wT9nXqeKOj++2yefaVMDieyAePhIrr
         he0tRLj8MkCLHJo1ldEY7Ido9Z5+Rt8ujqLFj4RWJKlCI1MsJy0QVRPlqLXyXDNFml3l
         TkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3DtR8lJo6PTMwtSOd+rDZo3P/UEBQfONul+r7GtLsU=;
        b=Ru5jUE1R8o3BFOmH07N1wAObtae9WzP/zEQElNhip7FXDpvJCjN6hFKdnQrOC46DIA
         /KtjHmXxPNKbXmjTJM6vbY79HaJ+28Oexw0Loh+g1+CaJkcW7mTof0cGdRjpUx1J99rp
         u4MkUOcrHJcg4rQX8n5xgAemZuPdc8L4Ml13xjVP5zVA8GdPU2uxULQ0MUhB9FqeuNho
         DH8sYdUpOOVsqV566q1qIMWIv+gSTqtqbNhQ8i4LWKW5q2JZDjIIwL1FwUxQCALufYYA
         XqY3MriWn1L/TI070fs3q1xJhLEte+uflydJaBqmRYPqoiyRFGtLq6E6HJye3IpeXO2e
         vlRA==
X-Gm-Message-State: AGi0PuZN9xhNwVCFGBGmzv+7MZEysqPcYMcoEoVKcQBmG+fI3er4H7eI
        jI9R9NG+AZus5/TCNRugxZSHcfvFAk0PGR6oFa8=
X-Google-Smtp-Source: APiQypI9+0Hu73evKwOrHhmG710cmV0+RzwTXSunS6tGdmAfIwMAutiMZhsmZ9W6/U/21KFfbEr53pc5AJcjz5hChAw=
X-Received: by 2002:ac8:468d:: with SMTP id g13mr773636qto.59.1586242369205;
 Mon, 06 Apr 2020 23:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <1586240904-14176-1-git-send-email-komachi.yoshiki@gmail.com>
In-Reply-To: <1586240904-14176-1-git-send-email-komachi.yoshiki@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Apr 2020 23:52:38 -0700
Message-ID: <CAEf4BzZaMX=xPSkOdggX6kMa_a2eWZws9W0EiJm7Qf1x1sR+cQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Make bpf/bpf_helpers.h self-contained
To:     Yoshiki Komachi <komachi.yoshiki@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 6, 2020 at 11:29 PM Yoshiki Komachi
<komachi.yoshiki@gmail.com> wrote:
>
> I tried to compile a bpf program including bpf_helpers.h, however it
> resulted in failure as below:
>
>   # clang -I./linux/tools/lib/ -I/lib/modules/$(uname -r)/build/include/ \
>     -O2 -Wall -target bpf -emit-llvm -c bpf_prog.c -o bpf_prog.bc
>   ...
>   In file included from linux/tools/lib/bpf/bpf_helpers.h:5:
>   linux/tools/lib/bpf/bpf_helper_defs.h:56:82: error: unknown type name '__u64'
>   ...
>
> This is because bpf_helpers.h depends on linux/types.h and it is not
> self-contained. This has been like this long time, but since bpf_helpers.h
> was moved from selftests private file to libbpf header file, IMO it
> should include linux/types.h by itself.
>
> Fixes: e01a75c15969 ("libbpf: Move bpf_{helpers, helper_defs, endian, tracing}.h into libbpf")
> Signed-off-by: Yoshiki Komachi <komachi.yoshiki@gmail.com>
> ---
>  tools/lib/bpf/bpf_helpers.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index f69cc208778a..d9288e695eb1 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -2,6 +2,7 @@
>  #ifndef __BPF_HELPERS__
>  #define __BPF_HELPERS__
>
> +#include <linux/types.h>
>  #include "bpf_helper_defs.h"

It's actually intentional, so that bpf_helpers.h can be used together
with auto-generated (from BTF) vmlinux.h (which will have all the
__u64 and other typedefs).

>
>  #define __uint(name, val) int (*name)[val]
> --
> 2.24.1
>
