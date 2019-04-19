Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E8C282DF
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 19:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FEA217D7
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 19:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLmNmNct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfDSTfH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:35:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34824 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfDSTfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 15:35:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so6455430qte.2;
        Fri, 19 Apr 2019 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jg4w/KUWhZqoxw2fU+Vk09jXeyyeAB0h73RKIPrePvg=;
        b=tLmNmNctw/ylSrvlBy74HcCotwi97QMG2fhzYzVvvRYRIk++4e+vAncEwytKxGY02q
         PMj3n6ytYGnAeh/nD4r7go5bq0PTvY9ZY13AdzrZuDCvdIS9VfYJzEOZKXeZnQZVYOFx
         xKhNzH1gDt4FWIq9fE/QQJvaWI7Q2Kq62txsF2KFFpvwsBJV8phpfsyF4bXI0d6J752g
         fRx888Mv/QSorJeXj22XZcEXdAh91Z2m5Q6WVcABN4Y+FzLtv3IdOvf0CfSrH4w0b5ZT
         IwX22TeDX9uZBDkQE9K3qomvnrL4n+XoDK3cbkFQcQlRfETx0z1zr1yM4ctys1Kwb3Xp
         CjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jg4w/KUWhZqoxw2fU+Vk09jXeyyeAB0h73RKIPrePvg=;
        b=kcr5nN3F0CK5U23yqE2jydr6DOFJjNeWKbH6soISjZtEoCeUCP1MoFQbNPyzoFKM0o
         kZa1+uKLMlOjLJdrTzu5m/EVn1GXF6f9qpOOCkrPhdQOQh/xtdHU+mCaj3swO9jEZm11
         zqjLU26GarKd2/ie7F8jVDIFf6b4y8NTfYAAzO8SJ+7cPY5cYlF1jpwVoa2KYtIA1mXs
         PbBXSVpRva0Yr2FblItmZDBZETL60On6VS3DxJ36sLrti7MPThVQWUUcL5/PTMh/eH+F
         pFzsQ9uJBiW7CdtyxB8uvjAYmSF8pQlKgvRTvBttaSfN5CvgJ8eoOQbKSiAkxV5Hp4dC
         GtFA==
X-Gm-Message-State: APjAAAUOfQNWq+Uw5ZdVwbbt9+NP5w6gCQ1lotmBDiZX1FUuSrZaC6yS
        LpoAtXwXZ53QYJSl7S95gdkPi8OpmGaixSYgb5Y=
X-Google-Smtp-Source: APXvYqy2klhP0XeuCelMWASgVU/VLYQLQpU8+yV68Hzoztz7usd5dq7QnuF3BqSQ/VZyfdbCE1ga+TJmDNUG9GCJ2Es=
X-Received: by 2002:a0c:a9d7:: with SMTP id c23mr4747911qvb.11.1555702506093;
 Fri, 19 Apr 2019 12:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190419144455.853134-1-ast@kernel.org>
In-Reply-To: <20190419144455.853134-1-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 19 Apr 2019 12:34:54 -0700
Message-ID: <CAEf4BzZ7W+6v=hqcO=40BXgT0BYd6haVeqPU1HZTdP8srE4tMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: parallel verification
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     davem@davemloft.net, Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 19, 2019 at 11:24 AM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Allow the bpf verifier to run in parallel for root.
>
> Alexei Starovoitov (2):
>   bpf: remove global variables
>   bpf: drop bpf_verifier_lock
>
>  include/linux/bpf_verifier.h |  5 +++++
>  kernel/bpf/verifier.c        | 33 ++++++++++++++++++---------------
>  2 files changed, 23 insertions(+), 15 deletions(-)
>
> --
> 2.20.0
>
lgtm, for the set:

Acked-by: Andrii Nakryiko <andriin@fb.com>
