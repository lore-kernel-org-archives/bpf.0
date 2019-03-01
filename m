Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37602C10F03
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0371D2083D
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 23:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In3rzCgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfCAXbY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:31:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34922 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCAXbY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 18:31:24 -0500
Received: by mail-qk1-f195.google.com with SMTP id z13so15383083qki.2;
        Fri, 01 Mar 2019 15:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIiOJHOkuXq3tZOzFrsbR1OhLt1DEAf/dnejDu/Mgho=;
        b=In3rzCggEfMfFW8U6Fo7JNHvo7H+kWQ7kOnPQmX+fv+gNkVGaZDit9J8KGhtmypJOu
         pwtzGxjFcEzgrt2NlLaDRgeotWRnXiLJcPvD6SIbQOyYsBbA/FfjmJ93mHohspEiSR80
         wcWTIJikRs2io1HqrUyY0Ky84AYntvFejVw/TECemuOSmCvabiGzDQ5Ug3+yFjvA0rAp
         m/9rhfpRSPhyaP1K+yqHiCOIzCt2KOtP+IEOuB2X5+nKNFx58d3bnAm6C1gkIuqZnCTQ
         I7dIOeeQ+4iqh77bMbV/QWMX6nCKSNmORCpLRuMcvw3z/picO6C8ahU7IGUyNp0PwmuJ
         8UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIiOJHOkuXq3tZOzFrsbR1OhLt1DEAf/dnejDu/Mgho=;
        b=hxQ1ufIftVz1rGSmZVocvrefAbyMWG9iNfE7um094VbOB9aJgwFnB9/CzoJ/hHU2ip
         RsBtwIh7u7pfgPaxOnWfk+cszBqqQ7RSPzhtnYfcnowX6jdWwXL7n9T2LZ5fTDwSrVn0
         XCWUMCsrVhAC5IktLOOkQO+Vm+IyggXEjiut9+Nm/NCYbfFfKGVgQFnpBCXh6PJCxtWH
         h20P5l8TwlVmYC/YKmtGLHioAH078Cr+07gse00++c/s1CwgE4upDnD0AAVOdwscqBBy
         3CMUWoDYb+Ks5SwlYPqL2mxsZ+zLoBfrA//rhsQWbjvjZ+BaXZDp72Gq+asxnTyHY4Ga
         UBNA==
X-Gm-Message-State: APjAAAU0nPqaP76lI4+1P2L/NXpJVEJICIwcBobVLXP0VbzXlr3cJXG8
        8DO6ABJTua2UmMaA3i6bRwXf/Utr9Qp6Ov0iDgw=
X-Google-Smtp-Source: APXvYqwAeQ7+IvY+LGc9/XztREKcchlppyXz/gAI0xeRMu6MmM/xQ6VnsxYwBHPECpzdn8vh3BX3MHHRjoYXqzxfmko=
X-Received: by 2002:a37:9686:: with SMTP id y128mr5479721qkd.355.1551483082697;
 Fri, 01 Mar 2019 15:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20190301223311.155501-1-edumazet@google.com>
In-Reply-To: <20190301223311.155501-1-edumazet@google.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 1 Mar 2019 15:31:11 -0800
Message-ID: <CAPhsuW5Oh-Z3kZWh=+pD1ERdCmQjAauDuoAm8C4PxH7g5BSXFw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: fix u64_stats_init() usage in bpf_prog_alloc()
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 2:34 PM Eric Dumazet <edumazet@google.com> wrote:
>
> We need to iterate through all possible cpus.
>
> Fixes: 492ecee892c2 ("bpf: enable program stats")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
>  kernel/bpf/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 1c14c347f3cfe1f7c0cf8a7eccff8135b16df81f..3f08c257858e1570339cd64a6351824bcc332ee3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -109,6 +109,7 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
>  {
>         gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
>         struct bpf_prog *prog;
> +       int cpu;
>
>         prog = bpf_prog_alloc_no_stats(size, gfp_extra_flags);
>         if (!prog)
> @@ -121,7 +122,12 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
>                 return NULL;
>         }
>
> -       u64_stats_init(&prog->aux->stats->syncp);
> +       for_each_possible_cpu(cpu) {
> +               struct bpf_prog_stats *pstats;
> +
> +               pstats = per_cpu_ptr(prog->aux->stats, cpu);
> +               u64_stats_init(&pstats->syncp);
> +       }
>         return prog;
>  }
>  EXPORT_SYMBOL_GPL(bpf_prog_alloc);
> --
> 2.21.0.352.gf09ad66450-goog
>
