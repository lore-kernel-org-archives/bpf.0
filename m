Return-Path: <SRS0=xxat=CZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592DAC433E2
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 01:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07816208E4
	for <bpf@archiver.kernel.org>; Wed, 16 Sep 2020 01:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMbdC5jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIPBQf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Sep 2020 21:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIPBQe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 21:16:34 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33888C06174A;
        Tue, 15 Sep 2020 18:16:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so4439407ljg.9;
        Tue, 15 Sep 2020 18:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pVZCHPuKhoctM+wIqtZFC5/NsUM8NDsj+HSHpKsqPJ4=;
        b=dMbdC5jz+oen4UslnCqWLzyzUj+yux1azrfF52ZAs2RdkGaJDlJk7FzLutQfcbN/kG
         rN6OPW1eqZ6giHnMKzpMUBD3gF4NmRE5DerFmAEYBYRWhZ6mHFu45xc1z5018R6Vb4Iv
         Mj00bfM9jkrbQOm6iESgJ+dhsSjvWqow7UgmEpKA4zz6XrHMRP/8WR3htRsEYB3cTANE
         hCXGECZoYHkhRxylJnC/to64glC5iEx9OvK1rpc0FgQmjJjVIAh+tPE24bqMSAnz1hdm
         SGr363oqaYe/GgZJ1Wr8yfYqvHdxwNabTF/3AFxBr5U83JvlRgwvjZUGl4upyGDzkzzA
         hlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pVZCHPuKhoctM+wIqtZFC5/NsUM8NDsj+HSHpKsqPJ4=;
        b=falhXeXRj1IWU1TWH/DfkG0qZIVEE2eJqPpaot26DJY6Bj2yQ+LeDuBf6bxQnoEEpC
         iSZ3duusSe6DYRg0APfEEUvECRAZ8+tLYhUywhbiKF9NaRq6KdHnhmxHfSQmrBPn4dta
         rGUkLORpgv7dlhIV40ZFK9OK1hQpJ0OLQuWc8dIhAPAibIVK3kT4NHWf9F/MdBVm9tT3
         1BNq/fimaYa1RjZigODH1H0zMxfq31QtZPhtih+x4OwJnF0l7YjRXXKmBJ90OzpFfCEy
         mwS/Vas/6hmuhpeEk8143JnSk+vsFKoFZocpO9nmpoM8bUAsssyVnv7FOGVj8nVHpPyH
         H08A==
X-Gm-Message-State: AOAM533OMWs+UOkwBfOtM809sWWXAAA3sgMNmpTCA34MW+D0LXyR7u+6
        4thF16VtXFn1NuZdUdvXlZOwjxJU3DuNSdEJXxQ=
X-Google-Smtp-Source: ABdhPJwhh4BSSi+d3MMa1AHgbxqxA7GvwGxCmOlhuNDdAprEWHU9zDnpTCgakTRA4PPVlvHzqMO5P4qNFJQ2CIA2Rks=
X-Received: by 2002:a2e:4554:: with SMTP id s81mr8300339lja.121.1600218992285;
 Tue, 15 Sep 2020 18:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200915182959.241101-1-kafai@fb.com> <CAPhsuW7b6oMHgOn0Oyq1Fk-xOws=8tK0Bfmbh-UvZUYUFE-zCQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7b6oMHgOn0Oyq1Fk-xOws=8tK0Bfmbh-UvZUYUFE-zCQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Sep 2020 18:16:20 -0700
Message-ID: <CAADnVQJjS_Uez_C_EZMyT_Wrk1kL_BSBX7oJ_tH5q-aTuu_uQQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: bpf_skc_to_* casting helpers require a NULL
 check on sk
To:     Song Liu <song@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 2:45 PM Song Liu <song@kernel.org> wrote:
>
> On Tue, Sep 15, 2020 at 11:32 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > The bpf_skc_to_* type casting helpers are available to
> > BPF_PROG_TYPE_TRACING.  The traced PTR_TO_BTF_ID may be NULL.
> > For example, the skb->sk may be NULL.  Thus, these casting helpers
> > need to check "!sk" also and this patch fixes them.
> >
> > Fixes: 0d4fad3e57df ("bpf: Add bpf_skc_to_udp6_sock() helper")
> > Fixes: 478cfbdf5f13 ("bpf: Add bpf_skc_to_{tcp, tcp_timewait, tcp_request}_sock() helpers")
> > Fixes: af7ec1383361 ("bpf: Add bpf_skc_to_tcp6_sock() helper")
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>

Applied. Thanks
