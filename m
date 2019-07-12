Return-Path: <SRS0=+3xt=VJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C7FC742D2
	for <bpf@archiver.kernel.org>; Fri, 12 Jul 2019 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE895204FD
	for <bpf@archiver.kernel.org>; Fri, 12 Jul 2019 18:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4tzxMXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfGLSWW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Jul 2019 14:22:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34151 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLSWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jul 2019 14:22:22 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so9111151qtq.1;
        Fri, 12 Jul 2019 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z52CPvGYyshFCv4ps78yejJkNPzy34bZ7EuWUc8Pj4A=;
        b=s4tzxMXm3PPwohaf/EAtbvBVHUYWXQhwO2Wrv2WnBSvcv69uzfvmSygqEXF4NlfPsI
         En2tAWUix1tpMvnlqnaSidDZ9t3ob5/2jX3Jt9Z1f/4HsvHoj9hr1z6LMK2zWeywXl53
         zstcce3UpuxYe44+y65pTwj7aiyz+T3dHBYQTEHI4wTBrP1KR3aTL3dWTcHfHwXM1Br0
         n9ZAbmDioXrTq412HcTkwIhaUkRHlL/rrlAvi6CtFyoNrY+CYUHdAuZX2aDJmRfGmmIe
         8c1z9Gv18CtIjL5V/6skJ9oC3ClLWcswHZDR6ydR9EoQrR8A1kasogQjH+SDJEssmsbO
         gyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z52CPvGYyshFCv4ps78yejJkNPzy34bZ7EuWUc8Pj4A=;
        b=YO9pTISeJv58xSsHyyyC5hbErTnooGEDyouc3lmo2XLihT3Kxb4w3jD9pHqaB8WIC6
         5VRPUhMo/O4z+nJW/yI3RcNN5MqGpJwXbc5QwpaAUoYqbH6ZvNksJKdfcLKPZfCYbw86
         4igGXbysxCv8D5upZDScDg2ypbVJNSugZSSLm4gWuhzGc4r5jNmPD+tbrdVuRkQFZ5jK
         GWhPz5TbwQwCR1sUjzMzOFiBiaW0w/3DQFGkrEt020lPQidq4ZEDpvXIioRDNUejCOoE
         vLWJ4BekhuUGGlI6qdz2N7kbukjen4+H80HkbSIT73D1u2hOa1690wuFBk5f/VeS+moj
         tOAA==
X-Gm-Message-State: APjAAAVwfhouvz2YPjAggm05tjaRlntw1hpwimquiaaSdKSMjjqQ0Nqa
        +wuKESQWVhhLeI9wEL62yPAFAovlFjDKOUFTjEx/WPdEWsHqlA==
X-Google-Smtp-Source: APXvYqzWA26861Tgr1sr9MwSfjI7n12pUnm7Kkqsqwg10lYG2Mi/4ZCZbb78mG2WPOkvMCPepx9+kLFxnaJEwDKUNdA=
X-Received: by 2002:a0c:c107:: with SMTP id f7mr7844274qvh.150.1562955741479;
 Fri, 12 Jul 2019 11:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190712174528.1767-1-iii@linux.ibm.com>
In-Reply-To: <20190712174528.1767-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 12 Jul 2019 11:22:10 -0700
Message-ID: <CAEf4BzbZ4gUZb67EKiNZTc0MnqqGz7sTB20u-M+sF+YG0Sr3pg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix test_send_signal_nmi on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        gor@linux.ibm.com, heiko.carstens@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 12, 2019 at 10:46 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Many s390 setups (most notably, KVM guests) do not have access to
> hardware performance events.
>
> Therefore, use the software event instead.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/send_signal.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> index 67cea1686305..4a45ea0b8448 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -176,10 +176,19 @@ static int test_send_signal_tracepoint(void)
>  static int test_send_signal_nmi(void)
>  {
>         struct perf_event_attr attr = {
> +#if defined(__s390__)
> +               /* Many s390 setups (most notably, KVM guests) do not have
> +                * access to hardware performance events.
> +                */
> +               .sample_period = 1,
> +               .type = PERF_TYPE_SOFTWARE,
> +               .config = PERF_COUNT_SW_CPU_CLOCK,
> +#else

Is there any harm in switching all archs to software event? I'd rather
avoid all those special arch cases, which will be really hard to test
for people without direct access to them.

>                 .sample_freq = 50,
>                 .freq = 1,
>                 .type = PERF_TYPE_HARDWARE,
>                 .config = PERF_COUNT_HW_CPU_CYCLES,
> +#endif
>         };
>
>         return test_send_signal_common(&attr, BPF_PROG_TYPE_PERF_EVENT, "perf_event");
> --
> 2.21.0
>
