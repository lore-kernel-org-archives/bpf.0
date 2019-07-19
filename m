Return-Path: <SRS0=h/Ra=VQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3402C76195
	for <bpf@archiver.kernel.org>; Fri, 19 Jul 2019 17:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987382186A
	for <bpf@archiver.kernel.org>; Fri, 19 Jul 2019 17:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxupLYU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfGSR21 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Jul 2019 13:28:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46864 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfGSR21 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jul 2019 13:28:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so23731396qkm.13;
        Fri, 19 Jul 2019 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YQdxHwgD6BkG2btn7ZJ+raWLPXv95G8zip6/mSc1b0M=;
        b=pxupLYU+JfkFsm9nJC7j2+lZVNhPpYCdUllENGuQAF747LGLA9rmjj73cH+fRRAxjC
         p79SR3uHQ2LMEd/K0KbcutZrkgHnRiC4Tr/ns1t/kLNf40j44P6fT21dzJPW0hBM7KVk
         G5L4oZQ0c3Zv42EmPQ1LzA0c7J+8ccNedAU5HaVXLiI06OXXAtgVLSlz/RSbUHv5Dvl7
         T+I70p5ir4AovM5RGkDQLE1Gw+dH+ex/KjZgMCNVJoexkQD2bFeVVkp+RIAUARhsNV0P
         O2fVQ7qOuq3KDPzpaCnSK32HrGx3MrRuWB9M7vr16UlpyZbLCCOUzYngLmvy31645fSe
         MXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YQdxHwgD6BkG2btn7ZJ+raWLPXv95G8zip6/mSc1b0M=;
        b=SKcdAWmnq9RpeHjYpS7fxfualZHqK+mFEPmY96GJUVmG720MrNpXRWqm4hIYJ+X/+N
         lqkgb3hwwpwnCW+ooH0P1iDXQH3cq1UHyzi4NgWVi2a580+0ZIURr3hyjy90KJ4R3xpY
         ajJdvxEnrPrZQg9+XN9PElWtB1RnFCri9/qtsBiYMJIFvOGdXB1fHZ2Vg8MZZ/Qq0JgQ
         +LC1js4IrVbhOyzMw/Ugt7DxqhyglR+AUXjXnqldMk5Rv6c7Or0V3JTZ5ymob/9hX/xU
         FCu6M4bAKVK24+QChj6syq9gMMUPud5oRlzBALORapRWZw9mRLViGGSMpCHSlFtcLm2k
         y0IQ==
X-Gm-Message-State: APjAAAXTadVkTojW7qQFfsDSyPDDppjBJ6R1hPBLD4bLkJIioxnei+pR
        q3MsYSc+xCYFfMtdLQq9uNqRJ3pxPOvaggRD/BI=
X-Google-Smtp-Source: APXvYqxkh9i7nR3GIJjsIbfezBbI/vVEp6Xyl/7vOCvPEsks+4k9/SiUQpqGN2f2zmSLq5YhYnZ3fC1X8M51sQ3u2GI=
X-Received: by 2002:a37:bf42:: with SMTP id p63mr36928588qkf.437.1563557306169;
 Fri, 19 Jul 2019 10:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190719143407.20847-1-acme@kernel.org> <20190719143407.20847-3-acme@kernel.org>
In-Reply-To: <20190719143407.20847-3-acme@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Jul 2019 10:28:14 -0700
Message-ID: <CAEf4BzbvMyS=Z4Gxmsou5MB1mPiXLM_XKKefOgeWMf=i7NQi5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] libbpf: Avoid designated initializers for unnamed
 union members
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Clark Williams <williams@redhat.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 19, 2019 at 7:34 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> As it fails to build in some systems with:
>
>   libbpf.c: In function 'perf_buffer__new':
>   libbpf.c:4515: error: unknown field 'sample_period' specified in initializer
>   libbpf.c:4516: error: unknown field 'wakeup_events' specified in initializer
>
> Doing as:
>
>     attr.sample_period = 1;
>
> I.e. not as a designated initializer makes it build everywhere.
>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Fixes: fb84b8224655 ("libbpf: add perf buffer API")
> Link: https://lkml.kernel.org/n/tip-hnlmch8qit1ieksfppmr32si@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---

Thanks, Arnaldo!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/libbpf.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b1dec5b1de54..aaca132def74 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4508,13 +4508,13 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>                                      const struct perf_buffer_opts *opts)
>  {
>         struct perf_buffer_params p = {};
> -       struct perf_event_attr attr = {
> -               .config = PERF_COUNT_SW_BPF_OUTPUT,
> -               .type = PERF_TYPE_SOFTWARE,
> -               .sample_type = PERF_SAMPLE_RAW,
> -               .sample_period = 1,
> -               .wakeup_events = 1,
> -       };
> +       struct perf_event_attr attr = { 0, };
> +
> +       attr.config = PERF_COUNT_SW_BPF_OUTPUT,
> +       attr.type = PERF_TYPE_SOFTWARE;
> +       attr.sample_type = PERF_SAMPLE_RAW;
> +       attr.sample_period = 1;
> +       attr.wakeup_events = 1;
>
>         p.attr = &attr;
>         p.sample_cb = opts ? opts->sample_cb : NULL;
> --
> 2.21.0
>
