Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E017C432BE
	for <bpf@archiver.kernel.org>; Thu, 26 Aug 2021 02:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBA960F39
	for <bpf@archiver.kernel.org>; Thu, 26 Aug 2021 02:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbhHZCqn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Aug 2021 22:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhHZCqn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Aug 2021 22:46:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B648AC061757;
        Wed, 25 Aug 2021 19:45:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b9so872107plx.2;
        Wed, 25 Aug 2021 19:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfZY7/KYBdyUngWYbBs3KCgnIznYeyHefpYrVfk/TDE=;
        b=gjssXE1+8lDOFt3vv+5VwxmFOkrc7NVGyJeoZF/EVdYnqvrOS3rLiX1PQb8QybFRM+
         TB19xuMiZ9YezBwt2jdbTLtmwisamUXnAFLmXVeti3DiKnzuxPVSwt0sa/f00vIrjxMQ
         HHwPrvXWIe3mwJuFe1DETLKgpopfUehYZhiXxndpgcwyV4v3RUQ+rGD7V9n52o+P+mkn
         sm5SM3V4wXDeD1Qbiig+5JNc89PCAmGoPixyVjRwbHUMAp1ziyP8VXm1phk8NbLpOH9O
         PwvTKr1Ykz2y/dM2wnjK+WzU/+E117AFDjWihfrPKNJ7VSzdQI4wqZ7Uga+Pd+ZPt7J5
         MJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfZY7/KYBdyUngWYbBs3KCgnIznYeyHefpYrVfk/TDE=;
        b=j9m4KOumW47SQ7+t2oSzzmJyqFaRLJ1CeMh85FfdrRcQWnZay4+8Hyfic7cxveEFM4
         j4TOgmGa9SaL3qL3gzuWoJzwhPjQEryrrQQRiAxJYVRzoXwxfEWMLjMQmuZwPMs492Mk
         H++tV/KBGZd3QL7k4lzK4OfSE96azvhyvobfDoXNZozrytUfmVUp+scjILsw35iuYsyZ
         p7UlXmfsZoiZ4TkP8tyRZsdiDDRbStA8iT4b7nQ2izVKi6Ch4mBYjp1WmSGjnfd56OTD
         EvrM4cktV0fxI8txv1AloFtoigftB7eb68Ond7lKVgYXcDNepttOt+z1jrBKDwXTOP14
         3vlA==
X-Gm-Message-State: AOAM531UA/JxbvewfJkWdCL3+mcEd1RIQf4dRWTPH12PUyLYYuAQK8X1
        CSfTOD1d9SgrJtsKvflWjzabWq7EGQxboVJe138H9dhp
X-Google-Smtp-Source: ABdhPJx78rLDjpRvAWeopEHOevAHoPZnk8R5tfQrrO/ODssqY+r4N4oxuIbwUq7TS+3MO1bUUzwIZIoJNPwAQCwLT44=
X-Received: by 2002:a17:90a:6ac2:: with SMTP id b2mr1644032pjm.36.1629945956222;
 Wed, 25 Aug 2021 19:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <05d94748d9f4b3eecedc4fddd6875418a396e23c.1629942444.git.dxu@dxuuu.xyz>
In-Reply-To: <05d94748d9f4b3eecedc4fddd6875418a396e23c.1629942444.git.dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 25 Aug 2021 19:45:45 -0700
Message-ID: <CAADnVQJFk5mgy1oFmz=6hBZHxjPvmQp81rWU_gY5MYi0tZoipg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix bpf-next builds without CONFIG_BPF_EVENTS
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 25, 2021 at 6:48 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit fixes linker errors along the lines of:
>
>     s390-linux-ld: task_iter.c:(.init.text+0xa4): undefined reference to `btf_task_struct_ids'`
>
> Fix by defining btf_task_struct_ids unconditionally in kernel/bpf/btf.c
> since there exists code that unconditionally uses btf_task_struct_ids.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

Applied. Thanks
