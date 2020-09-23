Return-Path: <SRS0=NOCw=DA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26172C2D0A8
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 16:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC178206B5
	for <bpf@archiver.kernel.org>; Wed, 23 Sep 2020 16:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrfmCEEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIWQIv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Sep 2020 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgIWQIv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 12:08:51 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CBBC0613CE;
        Wed, 23 Sep 2020 09:08:50 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id v60so142170ybi.10;
        Wed, 23 Sep 2020 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZqylZfBJaRy7Aj7DhGeHIodSDWRD2Dwb1QLbio1Mwc=;
        b=IrfmCEEFxaA3n8vc2fHralCE5dM4TlHQgDNDDNllN7jQ82+440UDOHgiOHJBhe2vAK
         wejkhW7mn4c1t+X/NADxzowsR8QJcQ0Z61kLv2dx/YR72CasoMjavK/IWPrNkUbejT4i
         k3cf47kSxNtTRfTagWBVB5Uq9sgm0ao/h2M3JupwNeZQjeFZrnvIpDnmR6DRg82X2Qh/
         un4lS5RtAZR+DbdmYnZ3fdNZ/dNMF6+xj4IAWIRAB7bHmClUB4fYIrcGh4wiSjXP0OS2
         xtPXQxpNJ9xJOTKYuAJdB0z2WgBf5gnMfr2g1P5bpi1HO3l4R81lEgsC83VdkbHF3j/z
         tlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZqylZfBJaRy7Aj7DhGeHIodSDWRD2Dwb1QLbio1Mwc=;
        b=JVNT8IqSj2Lst064San1Qee4UNCtrk9rEzq2I4Y3qV5kwVptsFtJGuFTKfS1f/UX+z
         mAtUH2zPg8Qtvw4ChG5yHPGriwUDG+cnQDpWfEUKmwU1yTmViiv7TArlrD3LxJKpZL57
         xCLIJEaNhuob7i5G4gWBRQQh4RkZ72FmvgkGZ8hjv6eQ3El0ymtVWnHyCScmCLKC52MM
         8H3oFdueK5zm5y+kB7flY1Lsngfa3g5C/obGYY2PrcWEpzISQnWTglVZI6yoErtkMYQE
         cW1RaeQaGBSWN5f8zbTca5dKCSi+Byl76cXQOxOVsg8NsMewhnrIWx41XfjgpBb43vJ6
         lv/g==
X-Gm-Message-State: AOAM53364ey7uWv7PNWwoR2WgdOOVj5Uw+lxt2ilZIu145sYboCRFXpb
        HRqSPO0qB+ecil7BSZrEAf+1gU/Mbg6TB2Fqu0Q=
X-Google-Smtp-Source: ABdhPJwwp3pEXKvAFIcOXTC1fHA25TnTq+suQEfgnlwuNdcaz0D1Xowm0MYm8wA2AViwQf2ct5NCXHr0DiqIAd+WaW0=
X-Received: by 2002:a25:4446:: with SMTP id r67mr933504yba.459.1600877330201;
 Wed, 23 Sep 2020 09:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200923140459.3029213-1-jolsa@kernel.org> <20200923140459.3029213-2-jolsa@kernel.org>
In-Reply-To: <20200923140459.3029213-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Sep 2020 09:08:38 -0700
Message-ID: <CAEf4BzbjmimSnpdKkg9M9NJ2PBttQ2x+5trifzQgJdcSczXR1A@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 2/2] tools resolve_btfids: Always force HOSTARCH
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 7:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Seth reported problem with cross builds, that fail
> on resolve_btfids build, because we are trying to
> build it on cross build arch.
>
> Fixing this by always forcing the host arch.
>
> Reported-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/bpf/resolve_btfids/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index a88cd4426398..d3c818b8d8d3 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  include ../../scripts/Makefile.include
> +include ../../scripts/Makefile.arch
>
>  ifeq ($(srctree),)
>  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> @@ -29,6 +30,7 @@ endif
>  AR       = $(HOSTAR)
>  CC       = $(HOSTCC)
>  LD       = $(HOSTLD)
> +ARCH     = $(HOSTARCH)
>
>  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
>
> --
> 2.26.2
>
