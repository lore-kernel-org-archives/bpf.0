Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87035C433E0
	for <bpf@archiver.kernel.org>; Tue, 12 Jan 2021 19:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548762310A
	for <bpf@archiver.kernel.org>; Tue, 12 Jan 2021 19:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbhALTRQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbhALTRQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 14:17:16 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E20C061575;
        Tue, 12 Jan 2021 11:16:36 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id r63so3185868ybf.5;
        Tue, 12 Jan 2021 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNPja6jXIGq6+WeUuKATWjnFXyMnNMz8ngrg6c9AKD0=;
        b=uu1jt8YOQDPTwOiEnroeayfpLf1D92LEYOVacbYjPt7p1jd1Bvcazv++l6w76EcvQl
         8Ri5Nrg1mP+zTo3mOK1ffdacadGEQc1nX5JwphjAYug/LqWFJLoUugg6g1sxqakQL/7O
         bnLWHRE7q2JsHX21JKEr7axULwLP33NkO4hGyhKV+cn8k+OsZfydt9jNdAxTlgpgbbLY
         ul8Kp6VqDzBBeazvgy++vwNbMq91IWBHQMh42KM8BQofGjU5icKldisJjcgvnwhpd4bK
         PcJ2a21kBGwuq/xtaQSW+lNBX1ZlAua8LTMks2aXJwJaN4wwO9k/9GbBevIsuCad/hKT
         fEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNPja6jXIGq6+WeUuKATWjnFXyMnNMz8ngrg6c9AKD0=;
        b=hO9ty3cVPQ2zhtyy2cBn7pVoPlGTse8w3MBixyvpdfCwiQNmtDRoWE4Rz5qR91UEg4
         D2ZdTYP3kt+VU/MsAFlsEVUpsDQmFlMFNBN5b7l7IBBOI61gCLv30EuNWLS3IpzD40Sa
         Y+wm1zOwUr1KHGxDBGjcbaHOhtYbYOxMR3SVS7IT6OdnelPqzek6yQtiU0WEl3c/OD0F
         Xmo3UC7nFa/KANbWRSjrDfbT/oZSFXTZ3q0DedEJ5x+UM5U3qqELinw9pq2t9Fjrxtoc
         XoE5gZ4SrQSwaAmq2RyphM04OFjijIRyewpDuHR2eC18fRdvUfGkrd1HQ9Hr5RvJ63Pf
         J1OQ==
X-Gm-Message-State: AOAM531dOoEz7VE+b0NE5Ojvfn3JJNZNrnM55PMtxcP4uQgVHLSDGLDl
        7yT2XSKpyIFnL2OBp5A4ThYlTe4DT67ZMQQiIEQ=
X-Google-Smtp-Source: ABdhPJzTE6XLD/0GklQqhkz7rye4/VfeOf2y6g9GJzivBRrxewispiOrvdTApjZZOWVE9JPafLpEoj49Wa3GkV6FN2c=
X-Received: by 2002:a25:9882:: with SMTP id l2mr1232712ybo.425.1610478995598;
 Tue, 12 Jan 2021 11:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20210112123913.2016804-1-jackmanb@google.com>
In-Reply-To: <20210112123913.2016804-1-jackmanb@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Jan 2021 11:16:24 -0800
Message-ID: <CAEf4BzYoJ4oAH8UL0n4_RWsxCiPiC04KALvf0Gpy+t-AzS26rg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix a verifier message for alloc size
 helper arg
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 4:39 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> The error message here is misleading, the argument will be rejected
> unless it is a known constant.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 17270b8404f1..5534e667bdb1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4319,7 +4319,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                         err = mark_chain_precision(env, regno);
>         } else if (arg_type_is_alloc_size(arg_type)) {
>                 if (!tnum_is_const(reg->var_off)) {
> -                       verbose(env, "R%d unbounded size, use 'var &= const' or 'if (var < const)'\n",
> +                       verbose(env, "R%d is not a known constant'\n",
>                                 regno);
>                         return -EACCES;
>                 }
>
> base-commit: e22d7f05e445165e58feddb4e40cc9c0f94453bc
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>
