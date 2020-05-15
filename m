Return-Path: <SRS0=Xcm6=65=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29F8C433E0
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 01:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44AE2065F
	for <bpf@archiver.kernel.org>; Fri, 15 May 2020 01:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rM3Aj+Jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEOBhU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 May 2020 21:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgEOBhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 21:37:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB35C061A0C
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 18:37:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so461542lfd.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2020 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nTCxr919JLcLy8gr2eID1e/ZOYe2jUxvHLfSOwtbGfk=;
        b=rM3Aj+JoSOKJzCTbS5/nRT2R+80BYij2zinfeBL/1bjOeKXWl+21ETIi5L99IygPCB
         Eo1O0XupTl8WPKoMm+CalCSRRsO0sQSKzr1RdnjZExtgrx8Lyx+wro8jEnoM8/OmNBkZ
         7BYqHwxWDd2oCWDUIZw4GoAISXA2jp5HSoOi9394dojZbqwwWxpcl0jdrPJo0J0HokKT
         DpUyQ7WnxObxROJ3ha6jgILYi6B6GSr2Hma5CAO46wJdD5GnFBZ+YVdVYwR1nAa4Th3I
         rrkCE5sbCLYT0pE+5P8F2B5O5KLvg9elfiuzGYk5PHbMJDUQci012j+Jls3zFYH4awFU
         DZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTCxr919JLcLy8gr2eID1e/ZOYe2jUxvHLfSOwtbGfk=;
        b=PFq5W4Ctz7+R54XE28FatWuHWMbMFZxb/ImT/KRS08YTn706cspm9hd61566BtumO2
         TMiAK1ymc4AkXz/wgSlvUdU7x0Yg7un8avwtp71tKAq/M3PyiG3yH1pQJs3Vb83SsjsG
         yIMirsvxTIs8lQ7hRzqdKoQpBrzRntMLqsigo1Lstu1mTNAyrHmX/pd28DFvZoMzuGhm
         mxyVSwuatQ27crQvEHscn/fMzouaHhE1P/T3gilhPqqH6gX+3p6JY2a71T05lcR9hIE/
         Vc+4/+I1kbVykCO+rzGy8MNyopY28ZYD2LeSqr1UmIgea0iU50b2gLuDteMZVOG/hxhR
         ZBzA==
X-Gm-Message-State: AOAM5303Vyx1hU2fzhuUKu56w1ky+61PNUPROiKtUFofHSRiESs+kd28
        0oXSJQSRGE3B4xg3jrPOmmILecsAZCiowz2WOJs=
X-Google-Smtp-Source: ABdhPJw0nz4XBaxLoCvYOl66cQj774jgpGiWO6EB2JUgbL5zuw30NdPYAZJ9Eq5F4NCP92rKc9buFzywz+LBI6iTU7g=
X-Received: by 2002:ac2:58d7:: with SMTP id u23mr613464lfo.119.1589506636820;
 Thu, 14 May 2020 18:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589420814.git.rdna@fb.com>
In-Reply-To: <cover.1589420814.git.rdna@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 May 2020 18:37:05 -0700
Message-ID: <CAADnVQJZTjGYBuDRobuCeuwdM89MgcFsf-adX094CD5Z936XLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Narrow loads for bpf_sock_addr.user_port
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 6:50 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> This patch set adds support for narrow loads from bpf_sock_addr.user_port
> in BPF_PROG_TYPE_CGROUP_SOCK_ADDR program.s
>
> Patch 1 adds narrow loads support for user_port.
> Patch 2 tests it.

Applied. Thanks
