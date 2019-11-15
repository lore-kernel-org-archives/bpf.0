Return-Path: <SRS0=5OmT=ZH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6519C43215
	for <bpf@archiver.kernel.org>; Fri, 15 Nov 2019 22:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947D220732
	for <bpf@archiver.kernel.org>; Fri, 15 Nov 2019 22:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGCfzx04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKOWS3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:18:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39440 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfKOWS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Nov 2019 17:18:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id 15so9385318qkh.6;
        Fri, 15 Nov 2019 14:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0JHYIr3rYhpppM/Kx17FvzS5raftI8VMJzo0JktffY=;
        b=qGCfzx04PeUzAbgA7qhNJRrFdwZ6nyJeFCO4vwlPDhOhqy0cbgGbjS3nO/rDDE+4oY
         WIm1sMkWWOVmCiQLatNhBc36qIEFgGZTT0c+LVUFOJJByYEJigmwflBuRR4c6huTn05n
         MlBocdqNvxBIcbCz1vcdxtqfg+uOWUFSrQUPLP14W/DW4qocBsu30AuBDeMun95NhvAP
         cFiLesnAKsKR/Ulbk8c5RcXxnIRvg2TN22H3U//ypycXoy04tIHzu5JQKlEfX64jTdaJ
         DWcOSmuMIOXpRFM5sk84IXncPnag/wJsJtmbRy/aUItK0uQsLc3hFsHF4dHSxeS/ln3W
         I91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0JHYIr3rYhpppM/Kx17FvzS5raftI8VMJzo0JktffY=;
        b=rH5qOwc+A4fvT7SNryuJTIEb1931kii7g5i8FoOb4OV9HkcFXXaQcG+5u77HVPx6YJ
         6L4UuYj5MYSM38JxbCT9oMB5xFLEP49WlFoPYnmeB6EWi1BXoeNnL9/zetxDjQQ3lTl3
         UtWZlsZT5BkIYZzYxV5LnMo23sLhvv1ABnorVbx4FWanCw6nos/eKtzxE5a4JR9YahcW
         8rbsDuzFf7jw6JGMqFBk6yvo1ZYbjGNX6fGLqkpSXxYucx4Hln+gWAayRlS09aVSId6R
         gDSWLFblmktK6dAW2XoPNEUrr2Rv+hZOge/Xx7jaOqyExMrDbtNETP54QRGGYg/QFqwE
         Uf8w==
X-Gm-Message-State: APjAAAX2SbTd79L6gY1qdpuhI5HKVWPnTXdd938eT8Id79sMbyXLvsDl
        tlBAE9j2/b3hY5JkPqWVtgRmqsJ1Dkz7qHFiNv0=
X-Google-Smtp-Source: APXvYqxzhlqMSsiCT6vEboonnZwTcJBdsgLXKlZMzF7ivGf1iDcUdOf0uxK4joTsiK5Yzgx/ZX+DcAwutLzYKKsHu6o=
X-Received: by 2002:a37:9a8a:: with SMTP id c132mr2157700qke.92.1573856306990;
 Fri, 15 Nov 2019 14:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20191114185720.1641606-1-ast@kernel.org> <20191114185720.1641606-4-ast@kernel.org>
In-Reply-To: <20191114185720.1641606-4-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 15 Nov 2019 14:18:16 -0800
Message-ID: <CAEf4BzbTrm4cQ7jBp-1izfhzD3cEc2QUzCd3rugd1PzFSb2Qfw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 03/20] bpf: Add bpf_arch_text_poke() helper
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 14, 2019 at 10:58 AM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Add bpf_arch_text_poke() helper that is used by BPF trampoline logic to patch
> nops/calls in kernel text into calls into BPF trampoline and to patch
> calls/nops inside BPF programs too.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Song Liu <songliubraving@fb.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  arch/x86/net/bpf_jit_comp.c | 51 +++++++++++++++++++++++++++++++++++++
>  include/linux/bpf.h         |  8 ++++++
>  kernel/bpf/core.c           |  6 +++++
>  3 files changed, 65 insertions(+)
>

[...]
