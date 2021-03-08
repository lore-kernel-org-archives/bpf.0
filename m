Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE32C433DB
	for <bpf@archiver.kernel.org>; Mon,  8 Mar 2021 18:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE82A6518A
	for <bpf@archiver.kernel.org>; Mon,  8 Mar 2021 18:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhCHShf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhCHShX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 13:37:23 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F179C06174A
        for <bpf@vger.kernel.org>; Mon,  8 Mar 2021 10:37:23 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id x19so11226771ybe.0
        for <bpf@vger.kernel.org>; Mon, 08 Mar 2021 10:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uemaIjIKCehEfHbKiKkATbWIEaCoalEO2NkpqCf/Fzs=;
        b=E1MtIUoEguxfuVCKYGkXfUKW49LqcI+hNDr6MfR89LpKu1D/zNhbwTuoZMUhKKcIhE
         Pr0kUfTXI2F3TSioj0JnFlFXlIP3rXGoFRkeMK4LqFi45x+pZQTdUhLCaSxMAbYIJF6a
         acyyrIGCrCoWJE0V19W2Ony6YzrR7SsBEhZK5COy2UvsFooU1ZIYTiZ4JuAfV30HGAog
         5JnME/tiryEMvRjWf3O46lCFWO6WOIK1i4ogNKjO8eWEn0zsP0IGUdMKYLOg1fp9QANG
         MQxNjMa8fkO7TBAyvK0qjHktP35fAE7LHYnCYGItH34N41vdR8hFRZDUoSyfVlhgIjSq
         +vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uemaIjIKCehEfHbKiKkATbWIEaCoalEO2NkpqCf/Fzs=;
        b=WcaQgsnBn1ubmNic2PnIfGpbTS+eW148P7nUVx+Ldwuor8ywuuUwCFkCrpLugw1WE7
         CCIQGuNIN5DKchYSYY187+CzMYGm9xrQwwAUgAoTQL3ZmZ2WjDC32qF5OhtoajECn8HA
         e6aln+TVJFwh4bKse4fZY2RiXaEyTNtvFheEkUeNvlaspdEIcg/H2yAGN5tMThQZA5l7
         w3DSSlpFoH1tA8jXx3SE0ppwivLJgb/0oqjcrJqZE/fmiMB4fq10yL1kaM4lSwMl2Wmr
         pjWXKqVAfPOL8tctxptqW1S/7fZvDpupNTPHhHW3aW4VavfJ3NItt0KlpBwI0jcDFtJb
         bGWg==
X-Gm-Message-State: AOAM5339NgVJpDliZLMin0eO2FUKOhwm8pvRSZk34zf6aGYEs/jnTkBM
        3bk7bTx1aDO0vXkedSZdPwIxyB340GduFS04AEd364Hpf/6/Og==
X-Google-Smtp-Source: ABdhPJyBwxszQnJt6IG/+BJvYzPitUT+/fwt98ib4cqOQ5ZQNKF0U1PBOI8UXUZCv/8UTMtxOrP7EP26l7+PkBMz9ig=
X-Received: by 2002:a25:bd12:: with SMTP id f18mr34740961ybk.403.1615228642288;
 Mon, 08 Mar 2021 10:37:22 -0800 (PST)
MIME-Version: 1.0
References: <20210308182521.155536-1-jean-philippe@linaro.org>
In-Reply-To: <20210308182521.155536-1-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Mar 2021 10:37:11 -0800
Message-ID: <CAEf4BzbFDrGNP1oc7YX9YEkgOkFFy5S0u7WQY_=fJoZYMBpJeQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix arm64 build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 8, 2021 at 10:26 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The macro for libbpf_smp_store_release() doesn't build on arm64, fix it.
>
> Fixes: 60d0e5fdbdf6 ("libbpf, xsk: Add libbpf_smp_store_release libbpf_smp_load_acquire")

I had to force-push bpf-next meanwhile, so the hash is wrong now. I
fixed it up (it's 291471dd1559 now) and pushed your fix to bpf-next.
Please re-pull bpf-master to get the correct branch.

Thanks!

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/lib/bpf/libbpf_util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
> index 94a0d7bb6f3c..cfbcfc063c81 100644
> --- a/tools/lib/bpf/libbpf_util.h
> +++ b/tools/lib/bpf/libbpf_util.h
> @@ -35,7 +35,7 @@ extern "C" {
>                 typeof(*p) ___p1;                                       \
>                 asm volatile ("ldar %w0, %1"                            \
>                               : "=r" (___p1) : "Q" (*p) : "memory");    \
> -               __p1;                                                   \
> +               ___p1;                                                  \
>         })
>  #elif defined(__riscv)
>  # define libbpf_smp_store_release(p, v)                                        \
> --
> 2.30.1
>
