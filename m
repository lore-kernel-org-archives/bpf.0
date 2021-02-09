Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEA1C433DB
	for <bpf@archiver.kernel.org>; Tue,  9 Feb 2021 23:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58ED64E37
	for <bpf@archiver.kernel.org>; Tue,  9 Feb 2021 23:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhBIXqx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:46:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234347AbhBIWsF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 17:48:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5571764E2E
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 22:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612910844;
        bh=Z/J9TGMKx54GXCy4CJFG/zUREUT7kS8mAIM4AVzzY0Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=juUfhtAQjUHSVJUFnYAbs51qn9cpyEMwa+x+cI4hDnY2By5aLw076Q6QxASk0ktpb
         lBTJs34HoAVabyKoWX/4GVoMiT413ifQ01mKwElUg+7Z/x6jYEGMfBvad07PikE0pC
         sYsDVv1znCJZuj5wBO7SiRxk8Yp2MYznhGaxv7+7vrpMeW56UQFYXzauqDELMuWR+G
         7CbBvEkLRCvmM76tPmy7nEDiF7iZoC2v/bam+NWgZUbRw63npWhOrXJHDtMkrparTd
         XzedClvLnW4uzMnEbnntX1ZH9ME86Dp+D1QKzzOCIUI8G8RayTNBMftLRC2AvKFRuv
         9xvoDYynPbRbQ==
Received: by mail-lj1-f181.google.com with SMTP id e18so265859lja.12
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 14:47:24 -0800 (PST)
X-Gm-Message-State: AOAM533zWVV6gETZKAFlC/jUY5xnb/FiH+5Jsnvuqbbuh2GEHDw1gDKE
        jqJjBAhViRp6uARJfc+3X6vom2EmCjvJ/MacH0YaHg==
X-Google-Smtp-Source: ABdhPJxHfLNh653Wc5ekEFKXZ/VT1RRamLpztkAtEoc2x6QTP+FqHdO1dcy/g5O+2S8RyyE2oRBk3lcgmHj5kgRJvHI=
X-Received: by 2002:a2e:91c8:: with SMTP id u8mr50799ljg.112.1612910842564;
 Tue, 09 Feb 2021 14:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com> <20210209194856.24269-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20210209194856.24269-3-alexei.starovoitov@gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 9 Feb 2021 23:47:11 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4skw5x=i-bqWXmo9sH-k=5jQXZ1Jir7hvY_se9fFxOSg@mail.gmail.com>
Message-ID: <CACYkzJ4skw5x=i-bqWXmo9sH-k=5jQXZ1Jir7hvY_se9fFxOSg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/8] bpf: Compute program stats for sleepable programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 10:01 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> In older non-RT kernels migrate_disable() was the same as preempt_disable().
> Since commit 74d862b682f5 ("sched: Make migrate_disable/enable() independent of RT")

nit: It would be nice to split out the bit that adds
migrate_disbale/enable into a separate patch
just to make it more explicit.

> migrate_disable() is real and doesn't prevent sleeping.
> Use it to efficiently compute execution stats for sleepable bpf programs.
> migrate_disable() will also be used to enable per-cpu maps in sleepable programs
> in the future patches.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Just the optional comment about splitting the migrate_enable / disable bit.

Acked-by: KP Singh <kpsingh@kernel.org>
