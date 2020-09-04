Return-Path: <SRS0=/x2n=CN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C84C43461
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 21:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AEF2206D4
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 21:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpiDpDkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgIDVk4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIDVkz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 17:40:55 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC9C061244;
        Fri,  4 Sep 2020 14:40:55 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h126so5370573ybg.4;
        Fri, 04 Sep 2020 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YGavqY1LAAfivBSvDQ5+2tSM73w9eC3O1SDrKV6HmoI=;
        b=EpiDpDkVqHB1RHFUe6l+1P4dexP7L8Wn301/pn/tA2gmP46++vhNS5fHBgUjgVFI/b
         iWLxoyQIh5yZhGkGHcuXjbm/dq30Lt0C6JeStZkiuzYjHN6xYh67phg1mareBF+MANdH
         L59doE1IkLmAVuxAktQz0vOB9v8RewlUX6GrgpMkwkKeS/UmRYk8FN4eUZWhtyFdwwNb
         mgPJW2y9xgYWdwWIDjDhXLZg6FS1WJLQjQwnAiiJIIK3lZcxRDiVDRFawUR2GhHN4ruQ
         b5Gvs/Oniqk5IlJKdLEpQcDrsS4vRzy6gcc++KDQ0JnGlT5MsxzkD9jiCMiBBCamXqC7
         FMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YGavqY1LAAfivBSvDQ5+2tSM73w9eC3O1SDrKV6HmoI=;
        b=PqMB5p1ox2gpR//asttpNZR+F52EXNG47VsYzBe7BqYBW0Pxnerj+fCIgREN16jcui
         SW3h8WNssTiYo8PCvSopAmjTq6KjDmGdZjkZEo9Povk8W/RLn/Q7gVEJuweulsXViDMK
         NZVuZCOCHI9dha1j8T8iWJP77cNjLrH6I0mib2xNjcqlRrt9kxHfPEPBJR9q2AGkk7PG
         7iFjICYZ7DLTjCG0jCO4X3PnJLJHCiJxOt8OKtizEfsf6tWJOZPyXQdSvWwH8hu0gfo/
         XHiKmCuj2WxLJ2yZGMmmsxpdDXJl8Qbq8qir/S2KgAZHWIAfsFelDz+dZhcxWNnL74LY
         DLnA==
X-Gm-Message-State: AOAM532I70+UB6pc1JUKDFaRR1FoRxsvIcflEiGdeIHBuiHT5cYq3bw+
        2muBHVcARLSzZP0adufWUrccOZQNm/X+fWH6zRM=
X-Google-Smtp-Source: ABdhPJylq+GVPvRwwyluWxo3O4wQ0/yE+LF27Hsi7rzdWCVMyFv0fNFDCcV4zD1c7V/D9eF0NoaJVRhOYOmwo8mX1Ls=
X-Received: by 2002:a25:aa8f:: with SMTP id t15mr3527068ybi.459.1599255654650;
 Fri, 04 Sep 2020 14:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161454.31135-1-quentin@isovalent.com>
In-Reply-To: <20200904161454.31135-1-quentin@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Sep 2020 14:40:43 -0700
Message-ID: <CAEf4BzYi8ELhNhxPikFQLQmB7HAXr7sRsyKi6QYJs+XBoDiwhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: format fixes for BPF helpers and
 bpftool documentation
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 9:15 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> This series contains minor fixes (or harmonisation edits) for the
> bpftool-link documentation (first patch) and BPF helpers documentation
> (last two patches), so that all related man pages can build without errors.
>
> Quentin Monnet (3):
>   tools: bpftool: fix formatting in bpftool-link documentation
>   bpf: fix formatting in documentation for BPF helpers
>   tools, bpf: synchronise BPF UAPI header with tools
>
>  include/uapi/linux/bpf.h                      | 87 ++++++++++---------
>  .../bpftool/Documentation/bpftool-link.rst    |  2 +-
>  tools/include/uapi/linux/bpf.h                | 87 ++++++++++---------
>  3 files changed, 91 insertions(+), 85 deletions(-)
>
> --
> 2.20.1
>

This obviously looks good to me:

Acked-by: Andrii Nakryiko <andriin@fb.com>

But do you think we can somehow prevent issues like this? Consider
adding building/testing of documentation to selftests or something.
Not sure if that will catch all the issues you've fixed, but that
would be a good start.
