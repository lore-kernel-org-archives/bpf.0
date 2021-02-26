Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5ADC433DB
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 19:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFF564E21
	for <bpf@archiver.kernel.org>; Fri, 26 Feb 2021 19:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhBZTOt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Feb 2021 14:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhBZTOs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 14:14:48 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B873C061574
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:14:08 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id l8so9909309ybe.12
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qlf0aZF6N2PaFUMRac6a01KYvFVInvH6zkfhNqIBaIg=;
        b=fvL4umrhv7djD8+oZzG/dlwvpihmDxSGnw7H6MK/QVxfK4k8xKtZMzW1moFF73BVgy
         hL4SVXgfKXvAliMV7/jXCpCKe4pIjafGpiOUjlsvCyuiwzTtcAKQJyL5LFjBum+nUaxy
         RJFMCXTnXek0n6EwHJSpmSczPWu/AwR9B/7z4mdEvsnYR2j/US1hoc2UlaBPuBOoILyB
         Jgr9elPGTQvx8uWCDhtFcFDrRR8i05yHze7mFNtW9MQogMgXCuhda/ntFdiaWR6Fakty
         +4/5hIa0DxuQ/AsSs7MATbEm1pb6enwF026POxDgjxTRN8zx0wqcP7JGLFoXR42liFMo
         E+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qlf0aZF6N2PaFUMRac6a01KYvFVInvH6zkfhNqIBaIg=;
        b=udmQj9w4VFWD7wOb/JZGzbKp1NcW7JR9aBBYzdPFQllDl8azZzWk/nPqsrasEfookn
         k2gm2BH7Q5RTBWlvLa/zepyfS8jvL3UJP5YG1CNUn6pGs/dfDIgg0ud5K4rYBASDu6/7
         OKnPOsusIEXoHdO1NHY1M3/63oPyy7rt84ZJF0AWfpscYQGTMRX5okuBN1odD9TSseE6
         DB4E8ZyLBkGIq8IP7TOtkVKGzAJ6mZlhWK+T/RP82mkZPzvst1/pMBA5pbV07QTjvlT+
         hdZDh93lMFbrZpJqW1i2CUH1PVu5DIP3o7OCRGD0VDogwgpdSdj+vT6Z1NaPPUGdsDBj
         ncBw==
X-Gm-Message-State: AOAM530BjNV/N5pq++N8eSkqsmKUS6yOPfT6nHDR731vII2ea37Fd6N8
        fqkVMYz5gLirmKpB5+jbZ/uTxEqQ/xamc52mubY=
X-Google-Smtp-Source: ABdhPJxi4TC8UY2N0V+W7U/Wo/WSC8CLuD43t7cnU8BiGRPQnDr9uv/RGCzegSd765C3aU88t6tg7rqRzyz3Y0aamyA=
X-Received: by 2002:a25:1e89:: with SMTP id e131mr6636189ybe.459.1614366847596;
 Fri, 26 Feb 2021 11:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20210226051305.3428235-1-yhs@fb.com> <20210226051308.3428482-1-yhs@fb.com>
In-Reply-To: <20210226051308.3428482-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Feb 2021 11:13:56 -0800
Message-ID: <CAEf4BzbzwCxBR9whcwtxMP8FXR4B7c4bTd3-q5-gSu4ip-FfUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/12] bpf: refactor check_func_call() to
 allow callback function
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 9:16 PM Yonghong Song <yhs@fb.com> wrote:
>
> Later proposed bpf_for_each_map_elem() helper has callback
> function as one of its arguments. This patch refactored
> check_func_call() to permit callback function which sets
> callee state. Different callback functions may have
> different callee states.
> There is no functionality change for this patch.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

yeah, I like this much better, thanks

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c | 60 +++++++++++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 17 deletions(-)
>

[...]
