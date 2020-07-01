Return-Path: <SRS0=pDiR=AM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1EDC433DF
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 15:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436F320760
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 15:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsSzl2/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgGAPCM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgGAPCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 11:02:11 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DDBC08C5C1;
        Wed,  1 Jul 2020 08:02:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z24so2530187ljn.8;
        Wed, 01 Jul 2020 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlk0b0IfBO/bqS7TXs1l8iaSfo4iEgKF69QXFItExcg=;
        b=WsSzl2/lC4yBxm3v0edfUILvKn0UcuiRWHDUelwD7sXxKNoEj9zTlFkFyFvD5GqiyB
         5H6s4MY3UFloFXPnw/gmd42stoSF2GKM0nwjDR7/mdQ3m3VSAxzenNGZuzZDxVHdFTrf
         hMBenXkHqayGSJT/fFDFy0+WikiIl4IBfUAvIzkMsEaqLmQmg5qI/NRnh7aUrl35iCsu
         hqW+skLKvAQDoenBsZDb1tF6DvyFwRkFNBzQW2e3TvdMzqx7L8eK7b7quNHcGLi3rhdI
         O8L2FyLfmZ/4hnkimDH7UT3PR3rSd98HWPUuZ+m8LlRfuUxMMEmje18zKAJWUppOUYt2
         TeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlk0b0IfBO/bqS7TXs1l8iaSfo4iEgKF69QXFItExcg=;
        b=mabT3K9J4kL2Znp3mvD4DVygB8UnvFnOQ6gB2MnFHcUit4sWhjL3KLYK0pcS11L9WU
         Upj3LeBt8rJk+isG/aEn18kPVRNLj46tX6ppWPI2hpjAnWg5f4PQ3uACEo9mAxj2h/2k
         htLfTitO0OHot1JWhPdpRjq5iVcYTUJ/gilPJw3KCB0ET65RxushQFo1etnj4jMwJ5Yv
         7fM6Swl1KsurgHppG7xYMNox/kT2mldNFZKfcBwdRdHvCuL4hDVmP+/Ma9jFN350Rv5t
         +ZFVY9V6tl7uWdawPoogZwzvR+sr4/FlzsrYRs804wJJyt2vEtIX7ZvA7h3y6nPqTcU2
         x2AQ==
X-Gm-Message-State: AOAM532p7aZaxJyN6PSaHNLNe3YaNTujVFGn2Akw4WXF3to+1ym/fb/2
        MdbBax2CGjdmYvxdY73vNC0LqCzesc6RGSSNHLnX9Q==
X-Google-Smtp-Source: ABdhPJyDC3BClVpIPFL16p2gkWICLszGTqOyKCaGslTz3jXQf6O+JKexNa7GjSZ4R4fAac+t8/9gQRI5j60D87NvYH0=
X-Received: by 2002:a2e:8216:: with SMTP id w22mr7230064ljg.2.1593615729655;
 Wed, 01 Jul 2020 08:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200701064527.3158178-1-andriin@fb.com>
In-Reply-To: <20200701064527.3158178-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Jul 2020 08:01:58 -0700
Message-ID: <CAADnVQLGQB9MeOpT0vGpbwV4Ye7j1A9bJVQzF-krWQY_gNfcpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Strip away modifiers from BPF skeleton
 global variables
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 11:46 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Fix bpftool logic of stripping away const/volatile modifiers for all global
> variables during BPF skeleton generation. See patch #1 for details on when
> existing logic breaks and why it's important. Support special .strip_mods=true
> mode in btf_dump. Add selftests validating that everything works as expected.

Why bother with the flag?
It looks like bugfix to me.
