Return-Path: <SRS0=5OmT=ZH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404AEC432C3
	for <bpf@archiver.kernel.org>; Fri, 15 Nov 2019 23:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182642072B
	for <bpf@archiver.kernel.org>; Fri, 15 Nov 2019 23:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8A0e+aV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKOXcZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:32:25 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45471 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfKOXcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Nov 2019 18:32:25 -0500
Received: by mail-qv1-f66.google.com with SMTP id g12so4408389qvy.12;
        Fri, 15 Nov 2019 15:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsYoej1/MXzwT+7pP01oUl74JtlEBDH629NdgZhWFok=;
        b=m8A0e+aVfikZnfdSgMgalD1RXQiYYUJvHtTBpdVybLdBL5Df55WDpq2X21a8ifkLWr
         LEZs6dyUpLaybRmysUcKgAhRaxUU0ASCQ1JxYqjNDfiOV96CiOv2bjUxwz9kBqmnAJD/
         tGzzA6E9VfSec7VTNBZG/fqqeephuvaj7hVo1e4lpum62Mmaz440dJ8jyR3sx/rriqOk
         p/SVkSKDhs6qZddccJ8HKarI4bNTToAW5Jb56sarf9zvdeSHqLI52/I9+elDfJmi/opb
         rKZYkazQl6mFnkNqOMhMF3MCBYKpQZNO1uTkSlUG/AeuQwNN4Y+2iMezKnmIB4dkKTtD
         Avag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsYoej1/MXzwT+7pP01oUl74JtlEBDH629NdgZhWFok=;
        b=GbqRiflf+Zx1dm/sT+2y7WnA3VbNtzG6BZ0QY+p0Yjm4+BdTpis9gNjRXCLXO0VwAN
         hXq7KCQfKzMj6mQPSWdgYVcp0y/QV1kWMOCtHOaM8+kYt2V+Ko+YAPSUxPLvUM0lWsLb
         5uS45AzCninPiWpFFnnrATv/AA1xDr9zXvH9ZCTdCdS0zMcZfaHnGg9rMrElgLUTjlH7
         xgcefusF3X9rpv96F3kgFTTdE/eXlYmIB6oFulDkB8xjasNCQSRxeFh6eRlenRyNPxzJ
         GoOc7iPkczh6Y3e+cNoF3dV3DD8IF4PrXwDPRY2FItIsxu4IDwzWtMOb34/lOMN9fbBA
         XHSQ==
X-Gm-Message-State: APjAAAV28pcNihXKKXuYeezTPCbZfB5km3Atzp9EqvvFwWOhSCYAPeEI
        XsQ6rvyArhef/117cYPuQ6iNNRu+RWmvr0L/PEof+ude
X-Google-Smtp-Source: APXvYqz9hfEdg6/aNwmc7fjhDKXX9myO10aOeRCAfdTNq8fOcOVfkqSxH8SsuiJdllX86uAQm9IlH5xNVHDIeCXaRyo=
X-Received: by 2002:a0c:baa5:: with SMTP id x37mr656469qvf.228.1573860744104;
 Fri, 15 Nov 2019 15:32:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573779287.git.daniel@iogearbox.net> <a89b60af47ea3fc87a7fceec10f70fabd9771d88.1573779287.git.daniel@iogearbox.net>
In-Reply-To: <a89b60af47ea3fc87a7fceec10f70fabd9771d88.1573779287.git.daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Nov 2019 15:32:13 -0800
Message-ID: <CAEf4BzYF_fwxBd8Ofj-AcJ=Y=L1RgPUT6D15C1p7XtWQLA4K4w@mail.gmail.com>
Subject: Re: [PATCH rfc bpf-next 3/8] bpf: move bpf_free_used_maps into
 sleepable section
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 14, 2019 at 5:04 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> We later on are going to need a sleepable context as opposed to plain
> RCU callback in order to untrack programs we need to poke at runtime
> and tracking as well as image update is performed under mutex.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  include/linux/bpf.h  |  4 ++++
>  kernel/bpf/core.c    | 23 +++++++++++++++++++++++
>  kernel/bpf/syscall.c | 20 --------------------
>  3 files changed, 27 insertions(+), 20 deletions(-)
>

[...]
