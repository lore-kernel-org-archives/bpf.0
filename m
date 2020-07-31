Return-Path: <SRS0=uiV1=BK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DABCC433DF
	for <bpf@archiver.kernel.org>; Fri, 31 Jul 2020 22:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C10208E4
	for <bpf@archiver.kernel.org>; Fri, 31 Jul 2020 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596235677;
	bh=b5JO+/JgUpSFXa4/rz7ZFekRFLfuwg/2wbt6wlTIbdk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WzPJmSkdC81Bhwbuh75ly0WTk/BKRZirHNeO6UWW896N1ontyb+9cLsI9wgJtAGTG
	 f9lerpwerBPGPpYQd6g5a6TIyIlaZy9EB5ULctnv8wgycuVhQ9f7MkDtj9i+M78zxW
	 wz7Y+dpoz5feO6LOQJNBiYhKp8TS8vNKAZyn4xKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgGaWr5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgGaWr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 18:47:56 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BC2B22CA1;
        Fri, 31 Jul 2020 22:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596235676;
        bh=b5JO+/JgUpSFXa4/rz7ZFekRFLfuwg/2wbt6wlTIbdk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g2+ALqyCuTAB0Vlzzea2WFmhBAXWs1yW33mD+aSeC9rO/2W02RLQKoPfyEo6wA8z/
         GE0fWf5k2JRCK+lMSRRStQjsryj7h1ZsaiNMco3I9YEVC8qNIJ5XW5wL7zL35HapvH
         MiGUM/9yfxfErxfsKKBq8q2hubm0r9ZTmBFOA5u8=
Received: by mail-lf1-f42.google.com with SMTP id b11so17655201lfe.10;
        Fri, 31 Jul 2020 15:47:56 -0700 (PDT)
X-Gm-Message-State: AOAM533atkeVpoGATXJ8Af25DhcJV3Z8lNGe6MUrN0vxrYe5r8Nvbt68
        ejb/NfrjbTD2Pthe1cPm2bh1xVXV9v/cVfwbbUg=
X-Google-Smtp-Source: ABdhPJxuo4sNEX2s+7M7UJBHmg90CO4wbasCESFdqa24wlRtwstPHpt4DRutCpTxoUn7zgxETgwNCfpdb+2vdKkUoAA=
X-Received: by 2002:a19:be53:: with SMTP id o80mr3015618lff.33.1596235674356;
 Fri, 31 Jul 2020 15:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200730212310.2609108-1-guro@fb.com> <20200730212310.2609108-28-guro@fb.com>
In-Reply-To: <20200730212310.2609108-28-guro@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Jul 2020 15:47:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW60O0=QuU2sgf96JLqacddfdDwyrQuOQVtaNFjog9E1gg@mail.gmail.com>
Message-ID: <CAPhsuW60O0=QuU2sgf96JLqacddfdDwyrQuOQVtaNFjog9E1gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 27/29] bpf: eliminate rlimit-based memory
 accounting infra for bpf maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 30, 2020 at 2:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> Remove rlimit-based accounting infrastructure code, which is not used
> anymore.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

The code is good, so

Acked-by: Song Liu <songliubraving@fb.com>

However, I am still nervous as we deprecate memlock.

> ---
>  include/linux/bpf.h                           | 12 ----
>  kernel/bpf/syscall.c                          | 64 +------------------
>  .../selftests/bpf/progs/map_ptr_kern.c        |  5 --
>  3 files changed, 2 insertions(+), 79 deletions(-)

[...]
