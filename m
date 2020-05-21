Return-Path: <SRS0=Vsws=7D=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C771C433DF
	for <bpf@archiver.kernel.org>; Thu, 21 May 2020 19:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D3F20738
	for <bpf@archiver.kernel.org>; Thu, 21 May 2020 19:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSYhanAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgEUTJ6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 May 2020 15:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbgEUTJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 May 2020 15:09:58 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6657C061A0E;
        Thu, 21 May 2020 12:09:56 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ee19so3574053qvb.11;
        Thu, 21 May 2020 12:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4V3QDFKFZsXUI/pfICicsfUOUS9805zC9jDFYXssMow=;
        b=eSYhanAzQhGZEiY+3dCu1QiaG4ITdyGX6ae1gmfSbsm3f2/HIxaUV0umpnjYORaAAn
         v2HLmOP2W0saotJcQtTcVtzDo23F/xke6NCmpDfy0+GIffzPzYKR1MBCu4gif1hILRWd
         sjEh5JgoWf1gCSkR/HhmENEoq1lOzxxv91FPqEsUbVyQXKe7nCRgZi5GLQ1ogb5fZSk/
         gVgTEiwDjz2u4GbscR/g9oL7upJChTq/RMkKvNV/ohYHCYOtdGIsPfY8u62LUcvjp0W/
         o3DPzqmiGuaXh+aLthcAnVUp1sHwIY4zMXCzQR6ECGIgzZhqECwt4hXl1LaAaqDc1wK0
         0BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4V3QDFKFZsXUI/pfICicsfUOUS9805zC9jDFYXssMow=;
        b=IC2V62o55hkf2sXrnBcwyhwfSAa4g17ZS+kVJ3yfTg7BrYnjUmcsPUNZgoYMBfWNoN
         dznX+CXl29/3V84d/s6jwKR5UbOO4qMUXXVcNFqOldSXT3cO7qHtqYtTd2sZ7Fjw3jRG
         UGfJQsGIsSkhZvPjhE9Eq3I7U6DBW/dSI8RLXyy7nLr5bYo4XLK+sgRknkHiBzYbIw6S
         0qfU3bpGgRLEaf4RnIqxPfPNLR4jLOfggqJLsFNLfAgfY7jiD5102iMbNCMdjb5NWIJg
         eFra1cVkDD5bE4BhaR0kyqD8s4tYzTvqdqvSpAuqWR59kEhZSbrUQsx2E9aCjP3oN4f4
         /sjA==
X-Gm-Message-State: AOAM530vIA1wi8USXeU1QiYxyCqDQKsHDZUIr4knNjPGPL5UTZH5Kkgl
        8ia6PZpC2FptFotsjoaYqUpbjEZ2izvtISqxwRg=
X-Google-Smtp-Source: ABdhPJxwY7wkwdwPPUpUKbQ9KmcRGuP5kLAjHm6RSFl1KIuQK/XEoCOpe7Q4V3p1Q5WeVohxLyfeX3oo1PNWJqCLoaE=
X-Received: by 2002:a0c:e4d4:: with SMTP id g20mr205248qvm.228.1590088195968;
 Thu, 21 May 2020 12:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200521125247.30178-1-fejes@inf.elte.hu>
In-Reply-To: <20200521125247.30178-1-fejes@inf.elte.hu>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 May 2020 12:09:45 -0700
Message-ID: <CAEf4BzYO-1UsmO6r3x2C95xLj+Lxg73c0hKF8-ZEnA8Bqy=pvg@mail.gmail.com>
Subject: Re: [PATCH net-next] Extending bpf_setsockopt with SO_BINDTODEVICE sockopt
To:     Ferenc Fejes <fejes@inf.elte.hu>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 5:54 AM Ferenc Fejes <fejes@inf.elte.hu> wrote:
>
> This option makes possible to programatically bind sockets to netdevices.
> With the help of this option sockets of VRF unaware applications
> could be distributed between multiple VRFs with eBPF sock_ops program.
> This let the applications benefit from the multiple possible routes.
>
> Signed-off-by: Ferenc Fejes <fejes@inf.elte.hu>
> ---
>  net/core/filter.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>

I'll let more networking-familiar folks to comment on functionality,
but features like this needs tests in selftest/bpf.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 822d662f97ef..25dac75bfc5d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[...]
