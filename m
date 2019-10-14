Return-Path: <SRS0=k+HZ=YH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6517ECE58C
	for <bpf@archiver.kernel.org>; Mon, 14 Oct 2019 19:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C17206A3
	for <bpf@archiver.kernel.org>; Mon, 14 Oct 2019 19:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNggBWTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfJNT5h (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:57:37 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:42920 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfJNT5g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Oct 2019 15:57:36 -0400
Received: by mail-lj1-f180.google.com with SMTP id y23so17801492lje.9;
        Mon, 14 Oct 2019 12:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWBqM7ACPJuFVmwODsf/7WGCZG2xafP+d2gCrOTywtQ=;
        b=PNggBWTQgMaMIP7D8fncGMjvU4nHhX173SW6zyv4rGeJchmNir+50H+3PUjxQeap69
         sVE+De0Z8uLXNB0BZ7JyT7rCY7JPNcjcE1XoE/nEtKJxDD0QAuFrIsub1M3cEkTpEYzo
         yZQcqK/a/DtEEtLD0DwiZf/3WXqFC1Uaus2yZjY6WIKYgc5BvU81X9wTJ+i/beA4yoqH
         QSJ0AjbqJGDGsl3SQQHLyTfTt38hMi8rYFQ3I1WyacBohz17anwWppt0Uw8wx/FjpHyP
         bYATtTdfqjDYyEd2LbxgCyYVddrFK0cE7UwLE2JZOIdEHj0rrJUvk+SqR9l4DM5lR00z
         GsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWBqM7ACPJuFVmwODsf/7WGCZG2xafP+d2gCrOTywtQ=;
        b=MwBFnvbkAPQzapqyNmYssd90Q1BFgR0bXKn6YF1nQm5m++eMq18sEvazVqEa79GQbg
         NGYZNxMaLUUpJot1xnXPCVm2Ima6jj2Wjv+TFCGYjqdqDFFG2rJPXJVc8Tp6lau5FUd2
         Hs3lY4C6PkHn3e82xmEM/XaqTxYtqVhJnqD1QvMIxUI2iX85LSb5BwfA33PFjc42zNuE
         8ha8vMufL0tZ0aSme93+/Tc9TExy2VtsbEBMWkn223cltPG9v0u2IbKjoZdOJoR34lIg
         mJfktfeqid3O/OLvIZp/BODOCX6hwhAawZwT0sz0RfooeECPRZSAGGgOn3LBWmr+/cLe
         cPBA==
X-Gm-Message-State: APjAAAV5qDRYG0F5yoye59Mx05rflft/Uu6zlgzcd0+r+YEL/CIYpDp1
        jzrkg00L9vu8J08zfEy4v9qKkim7XTCjzyy8uPg=
X-Google-Smtp-Source: APXvYqyyT5FRJM7T4H2nIXgZWKX18IJJiyBedoSVCOs43m6vvEvDI2pgwUFktLjqiZBcmLa+x71q+jSjFIocvI060Q4=
X-Received: by 2002:a2e:6c15:: with SMTP id h21mr19628476ljc.10.1571083054916;
 Mon, 14 Oct 2019 12:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191014190620.1588663-1-ast@kernel.org> <20191014.121756.12312306435084737.davem@davemloft.net>
In-Reply-To: <20191014.121756.12312306435084737.davem@davemloft.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 14 Oct 2019 12:57:23 -0700
Message-ID: <CAADnVQJJNhVbBuX_094LipXFazEQOAqnJ4RwkeLr-Qd+E0z2Qg@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2019-10-14
To:     David Miller <davem@davemloft.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 14, 2019 at 12:18 PM David Miller <davem@davemloft.net> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
> Date: Mon, 14 Oct 2019 12:06:20 -0700
>
> > The following pull-request contains BPF updates for your *net-next* tree.
> >
> > 12 days of development and
> > 85 files changed, 1889 insertions(+), 1020 deletions(-)
>
> This is nice, do you have a script which generates this?

Not yet :) This bit was manual. For the rest Daniel wrote
pw-pull script in
https://git.kernel.org/pub/scm/linux/kernel/git/dborkman/pw.git
