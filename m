Return-Path: <SRS0=G29D=7V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A9BC433E0
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 18:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1332063A
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 18:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcdnu3nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFHSgr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFHSgq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 14:36:46 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B52C08C5C2;
        Mon,  8 Jun 2020 11:36:46 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w90so15488436qtd.8;
        Mon, 08 Jun 2020 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBbgABUF6qx/HDS6+33rOogQw3fsuD4IcJkSYS3P3GQ=;
        b=hcdnu3ntcBCmvYPKcOUMFsgYTsAjhW5ArmwPlAG7fJyRXe8rQy3yzFbk5zkQWTq4Sc
         zp/CA1UlNp2BiKcej8TygpIE8YoyPS4ChUd6PBmgbI64jtsv5aVcgHO3R/BwPKO24o1g
         dKyHPPslYdShZOkQ7PcE4yYszP69nra/k8kmSCiTUrAAQ0jyU2LLHEIQUvK3hTuomGyG
         xKsCP2aeSbmcA5rzzVvmB+mXuLfmDuv84rIRA0xftMYga1kDh96GRBJfRzd1SpZdB255
         QJiLmY/4l5wgzfbHeDM/hngc+VjZG8GMpsQl0xgeTti05ermHLuqlCNSr4iKGaWRq/iV
         es+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBbgABUF6qx/HDS6+33rOogQw3fsuD4IcJkSYS3P3GQ=;
        b=AEoQIJ+BfkaHnpMhveKPQ+uH1OWu0im94wxJUzfxY7mxq/WwD7+qjbIEH2h5DWvkEd
         38H7yFeCX/1hh4SsVMsmiqdNwgnQAYvIMQ0H7jzlv3uxWtx8y7VQ2TX6wXMOiJJR3+Pw
         DcXhp01izFC4q6pZ4nHwcBCLCH50Wf6FPBot+rfi9C4bLskML5RahkXab3IRbuGuOHrU
         nDRFj7N0I8UorLztGJn58pSpXKaNZWCHvqBDqjyuL7VjYc7G71pgGgYRhAXfnJTynX1D
         oHSLRkscXIkSbqoQBQx4nZUxrgFAJmdchV8KsusG1DWXpUPG5GKtRYKdEYLcarRee5du
         2+2A==
X-Gm-Message-State: AOAM531hHs/Gmt9alwRAZCIQbo2wPuW2UqPS7bvc3GX8XuCsmihGsnGR
        qCYcaGNI2TwXZXx2zAIwYD5HY1iqCSVcWj8o+Zk=
X-Google-Smtp-Source: ABdhPJy8AAojywSEtDsWtYBbt+ytH/fQq7k1JLjujeY5ppIeGWaZNMLqO+/lpSjZrOmWKZIWb4ljZK/52YWnRx11gJo=
X-Received: by 2002:ac8:2bba:: with SMTP id m55mr24358863qtm.171.1591641405232;
 Mon, 08 Jun 2020 11:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <159163498340.1967373.5048584263152085317.stgit@firesoul> <159163507753.1967373.62249862728421448.stgit@firesoul>
In-Reply-To: <159163507753.1967373.62249862728421448.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Jun 2020 11:36:33 -0700
Message-ID: <CAEf4BzagW8GFfybMf10yorwTA+fpiuZHqT41Uu-vAsRHnZqKRw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: syscall to start at file-descriptor 1
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 8, 2020 at 9:51 AM Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
> This patch change BPF syscall to avoid returning file descriptor value zero.
>
> As mentioned in cover letter, it is very impractical when extending kABI
> that the file-descriptor value 'zero' is valid, as this requires new fields
> must be initialised as minus-1. First step is to change the kernel such that
> BPF-syscall simply doesn't return value zero as a FD number.
>
> This patch achieves this by similar code to anon_inode_getfd(), with the
> exception of getting unused FD starting from 1. The kernel already supports
> starting from a specific FD value, as this is used by f_dupfd(). It seems
> simpler to replicate part of anon_inode_getfd() code and use this start from
> offset feature, instead of using f_dupfd() handling afterwards.

Wouldn't it be better to just handle that on libbpf side? That way it
works on all kernels and doesn't require this duplication of logic
inside kernel?

>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  fs/file.c            |    2 +-
>  include/linux/file.h |    1 +
>  kernel/bpf/syscall.c |   38 ++++++++++++++++++++++++++++++++------
>  3 files changed, 34 insertions(+), 7 deletions(-)
>

[...]
