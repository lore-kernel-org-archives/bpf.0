Return-Path: <SRS0=5juC=7Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F2C433E0
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2272520663
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 22:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VETHs8vX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLW3L (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLW3L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jun 2020 18:29:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18986C03E96F;
        Fri, 12 Jun 2020 15:29:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so12839871ljo.0;
        Fri, 12 Jun 2020 15:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBSctRi6PehbvFyRdsaixGKXnCr9EQHvB+HGYrtZxRg=;
        b=VETHs8vXVoP6oxOZODpHaIbwZjcKXGwfa3Tghg8qibF7uYieaLSYR4G0wuYaf1MO4C
         bZSS4QDVaJoyi5OmXjmXXhK1G7QD/uyXmXk8Rr9v7q0BAgDRVVe6aONLItBq5pqa9uBL
         Qfjuh2vsuISfaho1m0kJ4DKC9yGaKZifPmfOCZ2Hl26LaG8M6c8Cc24nN/n8cB9wVCXf
         mHScHD1GOLKu8ACHOPYlKJPdZq9pnjvVlY5HNkKCkp0BE2snFOwcIfTMG73eWINlNxMM
         NwcF4wVJln7AwLJofFQ5XXW93tuHQNbQJvbpN08s8fehkcGLSCCYZBfwusIqwGxNUzcu
         gScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBSctRi6PehbvFyRdsaixGKXnCr9EQHvB+HGYrtZxRg=;
        b=VLKwZ9AH4pC1QrDKox2OjLwsI6+A9NvUyJh2u+N2YDxxvwHi3pRsnrshq1SaVWNVMF
         cGUgllmDmYVaHL4/jZPBpXlD/bl3QO/Cend3MVV7dxwhHOpfnNRHZPiXWtGhokKpIQ/h
         Gb2oJh5tXCtq+dz1FIuMIntHU6MmviqWtdPq0V3CDUZndUSo357u4cTugfEmLMkAdDWw
         YU9HFwe9OpV99NP73fG9OJB4UIbEtBFgHdapEIqCKPefOnWS1hp5Cu6TcGjNXUTzsAvX
         x5eie+iU00SN10W9Hh/nGEH8d4mIBrI1xho7Q6Dobqoz0jlZvNRSfDHvPjEpNXURki8t
         LmBQ==
X-Gm-Message-State: AOAM532h6wBy1ZOqG0tZcC88zytkclKoxwZl/LNnY3ACvpBgLMrWsj55
        Ih755eM78IYK8OwaXyj4G2tp2s2ETdliuCnp3MM=
X-Google-Smtp-Source: ABdhPJyovprWcYVnZI8jJAEoXVpjq1i16qahkDZz0eRNK1wgCzuVueRv7FXd07BeDYqUP4755oOpwwYExHAN+koxk2Y=
X-Received: by 2002:a2e:974a:: with SMTP id f10mr8132427ljj.283.1592000948468;
 Fri, 12 Jun 2020 15:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200612194504.557844-1-andriin@fb.com>
In-Reply-To: <20200612194504.557844-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 12 Jun 2020 15:28:57 -0700
Message-ID: <CAADnVQ+HO3um5jU2qt3p8iEBt4_mC_MSGyA=uScck-N5Mp8t5w@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: support pre-initializing .bss global variables
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 12, 2020 at 12:45 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Remove invalid assumption in libbpf that .bss map doesn't have to be updated
> in kernel. With addition of skeleton and memory-mapped initialization image,
> .bss doesn't have to be all zeroes when BPF map is created, because user-code
> might have initialized those variables from user-space.
>
> Fixes: eba9c5f498a1 ("libbpf: Refactor global data map initialization")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
