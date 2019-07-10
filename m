Return-Path: <SRS0=z4n/=VH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607FC74A2B
	for <bpf@archiver.kernel.org>; Wed, 10 Jul 2019 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1702087F
	for <bpf@archiver.kernel.org>; Wed, 10 Jul 2019 15:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1NtUKxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfGJP61 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:58:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38663 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGJP61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jul 2019 11:58:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so2294584qkk.5;
        Wed, 10 Jul 2019 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaPiMajfGp54cGGlKUvEZSpr6ikhvgm4Ag50n6qRe6U=;
        b=P1NtUKxNTRAx6ucV115hziJ5bI4vrqhyRdsVsNg2aX2KO/a/Xw2ZhZ9JEjffaFfRip
         oWUeo0Kpb1fUtN8Q1JD8f1Y67vqbiOjto0WnjL4qWJGEEagM+lUP9hjwr4PuFuR8kq1t
         TP3SLDgVtVXO5c4UQ3spNKDI85RMvQBjRYxflSgzqetG93bkI85PYTgz98mEDFHCGnCh
         KrA/KZbkLJE3viiRSZsfIDk5VpE7iDpnoNX706GKizwN397gDjR3octoxgm2aVES46OG
         JZ7HqCIcP47WuuIktqxu5FVPd5F3EFzb6QuTNOAUf2Og7yZW6ww3kJLXP+is60/wcit1
         qunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaPiMajfGp54cGGlKUvEZSpr6ikhvgm4Ag50n6qRe6U=;
        b=WhDUn0LA2nBC8F/yRzdVlHvtuv2vLDekbbU04Sliqth6GNVk2V6oef+5V+xdi8qGau
         drI/nWJq3t50AZkXF0RAsE12YTfCg7Z5Ppmi9wZKOiGfK8xQVk5CnP/UaTJEJvwMV+/F
         ZWXVnsqNrIwJMGUuZ+ELeYeHuKoUxqI1C2qqT0fua7fkgqqpr+2MBv+MfUrKVLvcfnU9
         8AIJXoffniKVaoe9eh8aJMkCvnwGEGhZc6IZ5M4M7YE9o4URozD0DazYMeFH8QOuocM7
         PmrQl/iWk1EhBdILaZukyJuYlF5buzpmpDwZFsFYz5XqMNsUDQyPvdYy1B/RqCRnJrj4
         UuMA==
X-Gm-Message-State: APjAAAXf+4UrzTtseTklD4Si3pmpugaNiq5xNdtYpECR9RUShuelUD0/
        EGHkDUIqLlKb0DVW8biFcaGOcX3348JjADYNF08=
X-Google-Smtp-Source: APXvYqxJ7BeXUHTB4trqQlRllqrbD/zJQjyuwoQMWoDCk/peW+D71XBGRmJJdlkD+UH0D9N8Jt2D/z7nEnbjMhjhgIE=
X-Received: by 2002:a05:620a:16a6:: with SMTP id s6mr23714896qkj.39.1562774306406;
 Wed, 10 Jul 2019 08:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190710115654.44841-1-iii@linux.ibm.com>
In-Reply-To: <20190710115654.44841-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Jul 2019 08:58:15 -0700
Message-ID: <CAEf4BzaiBVWiaSuv76nFO4o5_nu_zo0q9YrAw_jOOGSxN=aPWw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] selftests/bpf: fix bpf_target_sparc check
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 10, 2019 at 4:57 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> bpf_helpers.h fails to compile on sparc: the code should be checking
> for defined(bpf_target_sparc), but checks simply for bpf_target_sparc.
>
> Also change #ifdef bpf_target_powerpc to #if defined() for consistency.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
> v1->v2: bpf_target_powerpc change
>
>  tools/testing/selftests/bpf/bpf_helpers.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
> index 5f6f9e7aba2a..0214797518ce 100644
> --- a/tools/testing/selftests/bpf/bpf_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_helpers.h
> @@ -440,10 +440,10 @@ static int (*bpf_skb_adjust_room)(void *ctx, __s32 len_diff, __u32 mode,
>
>  #endif
>
> -#ifdef bpf_target_powerpc
> +#if defined(bpf_target_powerpc)

Oh, yeah, that mix of #ifdef and #if definitely threw me off. I prefer
consistency, so thanks for this update!

>  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({ (ip) = (ctx)->link; })
>  #define BPF_KRETPROBE_READ_RET_IP              BPF_KPROBE_READ_RET_IP
> -#elif bpf_target_sparc
> +#elif defined(bpf_target_sparc)
>  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                ({ (ip) = PT_REGS_RET(ctx); })
>  #define BPF_KRETPROBE_READ_RET_IP              BPF_KPROBE_READ_RET_IP
>  #else
> --
> 2.21.0
>
