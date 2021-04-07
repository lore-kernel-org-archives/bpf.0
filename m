Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25CC433B4
	for <bpf@archiver.kernel.org>; Wed,  7 Apr 2021 23:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D149B611EE
	for <bpf@archiver.kernel.org>; Wed,  7 Apr 2021 23:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhDGXOt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDGXOt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Apr 2021 19:14:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46086C061760;
        Wed,  7 Apr 2021 16:14:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id p12so10167892pgj.10;
        Wed, 07 Apr 2021 16:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdhYf9J/J/LeifXgyo0yJPbV1Fchbgma7e7wm36aBQ8=;
        b=EK4mqKyYjoayRxkK+Iwhj6jhCUhpdRvmpQJEjtbxbe/PKOnJ7UoETDgJRgtly9ri/i
         VSNF9S8OUiSxAja7QF7HMSlOf7HYyRyhEMaubU+lRxwB5auBXnY0CQYNEJhsFSnyxn7O
         HeXEHqj68CPkD5nPylrAuQRdqvf5oMlhCWn4nu04SBkILhKxnxxnubcmCCsya8Xb2yhU
         Qb5KWWy4CjCgJpeHOy97Zhqgg6AWyO3DN0r4E0zycCPLIF8AQszWOr6FD8capyTG+FWo
         Ui9E2cRiwiv6wvv9RQYB++lmUla8lQXXDIOzejizBiE4H9QmahKPD38mQs4La64lx0HZ
         yAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdhYf9J/J/LeifXgyo0yJPbV1Fchbgma7e7wm36aBQ8=;
        b=XFoefGdydvHe5quH86kIP05YCJefZA1YmvjInhbGBsUdYvFJT+179UzN5GUWxRqraM
         2DcNP6Hmj/7/VRtM7S7N49Cfof3bEd3qna0bel+YDcFp2OhqaRRfDAwZIMCIr1+rB5Qq
         uJnca9VPePTT5KOx7rPvelL1Cr64HMCx7jHCeyxNmulcsztKcCnyZOuLoTrAqM2oo3Vd
         rE0SVGypHwozzCGvMuswavvF2+EFyr6PQSPClKMcPkyB2zzZMO7aKKlgC+PHVZl9Ooen
         RCxT+KBAv9jCLGnAYRAsWyTp8QFNWXI3fU6O1O0nR+Z+HhKj0Lwkvn8Bu7Ngz2MRehzN
         ooeA==
X-Gm-Message-State: AOAM530lQS8gIzT+ZLuCIuWToCgMb6L02mc40jj/QLuuTeIcRM56mYpJ
        4ATnIe0BL7Gu2Sx/9f1XbHqbEUt9w+fow376SdE=
X-Google-Smtp-Source: ABdhPJz3kNJsptq+qEkv3mJ20fgEN6ihbPdMBBofgIFBgq9DfZTalhDkPLfGooMbQJGB6Jt8pZgyGGi55R989xoi4V4=
X-Received: by 2002:a63:6a41:: with SMTP id f62mr5259840pgc.428.1617837278842;
 Wed, 07 Apr 2021 16:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <YG3SuK4W/N9jqknL@krava>
In-Reply-To: <YG3SuK4W/N9jqknL@krava>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed, 7 Apr 2021 16:14:27 -0700
Message-ID: <CAM_iQpUdbsf97g8X=K7wKnGu1mmfuu7bseHdtaQ_uvo1XOmG_A@mail.gmail.com>
Subject: Re: WARNING net/core/stream.c:208 when running test_sockmap
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Paolo Abeni <pabeni@redhat.com>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 7, 2021 at 2:22 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> hi,
> I'm getting couple of WARNINGs below when running
> test_sockmap on latest bpf-next/master, like:
>
>   # while :; do ./test_sockmap ; done
>
> The warning is at:
>   WARN_ON(sk->sk_forward_alloc);
>
> so looks like some socket allocation math goes wrong.

This one should be fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=144748eb0c445091466c9b741ebd0bfcc5914f3d

So please try the latest bpf branch.

Thanks.
