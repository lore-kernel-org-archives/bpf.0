Return-Path: <SRS0=N9AH=77=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090BFC433E0
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 22:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C0F2070A
	for <bpf@archiver.kernel.org>; Thu, 18 Jun 2020 22:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5IWrvMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgFRWfE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFRWfC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 18:35:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981EBC0613EE;
        Thu, 18 Jun 2020 15:35:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g28so7286341qkl.0;
        Thu, 18 Jun 2020 15:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5vJjS/jzXZ1TJgMwiikwMrcCpvPwYwlpwX3QKMzAXvU=;
        b=d5IWrvMeSkS1Cg0/5+4DZYBJaOOxpocfjK6qmZWmWab0u1mKxBOL1hKmeJpBOddCTA
         1Bt1qzWixU7R3giYuQyq4SW4jWHbGjdfh+ixWryGk/tEIgSrsc3LjgjGCc/BdlZ4/x3x
         pCtGNs05JI+l/chu560LSLPZ2fepJSeGkbaJi42J7KiGeb//x3/nbuHaLIMn4/KP98kD
         Y5hEhJjd6My+gEwyqyiSTwFPkzgoXnrnsaeTRd74cPgMrYFlgdv9CQkuEGU6brtH72E7
         2DB6IX1aFBzxBsikVwhmEvWBZe2n6zgGrh3W7AHBb06OtuniTuEdQmHSeQTbdXC8kJa5
         BKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5vJjS/jzXZ1TJgMwiikwMrcCpvPwYwlpwX3QKMzAXvU=;
        b=kHgeB3H2w1ijM+sfxftsi3nDpuNKltlADoRM6mRp6glQsf2hcHA8I//7KgGYsfCVMb
         ptNoK7ccb87962/wxV+B0cNETWLnuhVsOaeZXFhRoRBUTjzLt0qfelpPWqwJLa0BVXA7
         zL8E6ibx+jq2/VLG9ZfQ32bAneupUQrFEIDvj+jGKkKBb5+1d74rk6JDPNe/K8RuteeC
         7J7345AH8BsbCB6z8PXq21LPNJz9u6d89aXLpiD1jLoDvdmsrluquio2VoL/QT+HXcbu
         jUbvuB4xV562sp9/3UPDLYpXK1YV0DuVbiCVeopTIqC54gVMs1p4+mhy5iDC39Y1OmOg
         NVmA==
X-Gm-Message-State: AOAM530ey2Hjkcu7In51HNj9QJxhscY3hSWcc5sBeVDCtVWVnHSbmHXH
        YsyKKLBwB4JF5UGQu0YPDX/zaTJRD140ysabCLM=
X-Google-Smtp-Source: ABdhPJyfYDOjj2Vz9Ql197CU8hm8vPZt0Zv5Z8/mfrERbyF0PXwxRtRxamcwoSK1cKMo1gW6izC/mzw72P9+Qsfi/a0=
X-Received: by 2002:a37:a89:: with SMTP id 131mr708766qkk.92.1592519701886;
 Thu, 18 Jun 2020 15:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200611222340.24081-1-alexei.starovoitov@gmail.com> <20200611222340.24081-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20200611222340.24081-4-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Jun 2020 15:34:51 -0700
Message-ID: <CAEf4Bza44nCC_1dCww_rQbo9+SNLgBgpF5vpg_9tmZu0aSOFLg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 bpf-next 3/4] libbpf: support sleepable progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 11, 2020 at 3:25 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Pass request to load program as sleepable via ".s" suffix in the section name.
> If it happens in the future that all map types and helpers are allowed with
> BPF_F_SLEEPABLE flag "fmod_ret/" and "lsm/" can be aliased to "fmod_ret.s/" and
> "lsm.s/" to make all lsm and fmod_ret programs sleepable by default. The fentry
> and fexit programs would always need to have sleepable vs non-sleepable
> distinction, since not all fentry/fexit progs will be attached to sleepable
> kernel functions.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: KP Singh <kpsingh@google.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/libbpf.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>

[...]
