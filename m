Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FA2C433F5
	for <bpf@archiver.kernel.org>; Tue, 29 Mar 2022 23:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiC2XUF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Mar 2022 19:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiC2XUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 19:20:04 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA8DDED
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 16:18:21 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e18so13468065ilr.2
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0tfPrGqFbuzq7YgqyiPRI9+NBMBLQsDBtsKF/Gah+b4=;
        b=E12cAXcuHAcQXpRoF0MxIQxvZwWGCHuoISQ/M5zsHvbl4Of7ewpwCCbFgGbtxYsY/j
         Z2x3qM61hoSGyOhVJoNKX7XHrIyckdMj7Is+HCa2gG4t9Exa88CAxazptpHMqsengakH
         D/Y7RRAA9cY2zYuygkVq7S7ZDG3lCK7ux7JSSF+QoffYT8B6b8WxLOK23blluxXbh205
         vu3Qx4sFo12cKPtNhq0lCxO6DgicM7USS6MaARHNF//pgd2W35FWEtd+LrmRC4tzubI8
         f7iPhFTybY4hvI44SkzkY7zjMl4abHfyQ+Cibrcle0ufgmNf/z4ypUQVauVjF1jkJhZx
         Z/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0tfPrGqFbuzq7YgqyiPRI9+NBMBLQsDBtsKF/Gah+b4=;
        b=7G5fYezQw6H71QLVl7nvgpwElHsd4QJ66gwCgOlYp6ZiOTY+Zj3qeDAPhjEEOgBqQY
         hn+YQq/kmuqq4VgpA69BVBHOU8c98WmjGBBC1t+h6PcP8xKLXSPYlaEii/tvozqrhgsm
         k/Jvu7J5BmLOqffn6FTJZAdkTXwOiA23Rt8/p+a9VAElhQHSpe1VOgLl9sG3Jngtlo2i
         NamL8uItGGPDF+EUgDi0C+9WFDKaqk1goYkB7U4BwOISY1ByE1fF21SDjb3tevJ6Ziae
         PJPD7OMcV1MRqegwzG4/UkuIimAVPZe5ZiZKI/6mqWI3DaJIl1yGtYamY6xqwsRBpwdT
         Gyrw==
X-Gm-Message-State: AOAM533uig+cPCiGvGpfEP0AA5/GaHUGrRkT3Nt1Vxj2dIaDCRQGVIu0
        dmUU4E6a/+JcUWf0yAoua7bHDt1VDtY1qcgSsN4=
X-Google-Smtp-Source: ABdhPJyrG/QY6ohUIG3BNOo4A6B0rhg2QxQYlkcxM4DYDpfgRwoisrho/7OiSrLidd6oRyO5JeBnFqZO8gn/TuAxjeY=
X-Received: by 2002:a05:6e02:1a8f:b0:2c9:da3d:e970 with SMTP id
 k15-20020a056e021a8f00b002c9da3de970mr1921663ilv.239.1648595900477; Tue, 29
 Mar 2022 16:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220326144320.560939-1-hengqi.chen@gmail.com>
In-Reply-To: <20220326144320.560939-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 29 Mar 2022 16:18:09 -0700
Message-ID: <CAEf4BzZzLy2DjJ4pk_wx8KCsErfZE2-eG6pXO+5WnnRHxcfpiA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow kprobe attach using legacy debugfs interface
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 26, 2022 at 7:43 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> On some old kernels, kprobe auto-attach may fail when attach to symbols
> like udp_send_skb.isra.52 . This is because the kernel has kprobe PMU
> but don't allow attach to a symbol with '.' ([0]). Add a new option to
> bpf_kprobe_opts to allow using the legacy kprobe attach directly.
> This way, users can use bpf_program__attach_kprobe_opts in a dedicated
> custom sec handler to handle such case.
>
>   [0]: https://github.com/torvalds/linux/blob/v4.18/kernel/trace/trace_kprobe.c#L340-L343
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

It's sad, but it makes sense. But, let's have a selftests that
validates uses legacy option explicitly (e.g., in
prog_tests/attach_probe.c). Also, let's fix this limitation in the
kernel? It makes no sense to limit attaching to a proper kallsym
symbol.

>  tools/lib/bpf/libbpf.c | 9 ++++++++-
>  tools/lib/bpf/libbpf.h | 4 +++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>

[...]
