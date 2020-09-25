Return-Path: <SRS0=/Hy+=DC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD169C4727C
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 23:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716E121741
	for <bpf@archiver.kernel.org>; Fri, 25 Sep 2020 23:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNXPZIY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgIYX5B (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 25 Sep 2020 19:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIYX5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 19:57:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF790C0613CE
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 16:57:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id c8so4236877edv.5
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 16:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fmWSkGqGH8iPJNhPCVGrf62MqajYo96ZYWtYF0O/4Js=;
        b=bNXPZIY1oR91NQ4ZlLDvaoVpzpkidh3D8IsJP0XMEqGtr5jGDwl0qFxdItvejMxmKy
         c6Fr8WEVvBn1p9UjM89pWuDTvBympGKe6MZHzoaGPdwnTK6+0JD+F2MnYNwwoNnN523T
         h17R03My4UXeDq6k492dggTcFXx0j3TJMCz0Ubt0uKQQp+AhnC9a3J4fPx8RQE0kU7rf
         mzFpKMxVWxKesNRHmuqxGnvMUDU0FvOXa/kVwY+xZsHj8l70cuScY5+ZhuehC0d47mK+
         WNARUf1dakLrIyrpPmJYZpmUvJEduDt/T2KJkzWBMJnx94tnHdtk+wXdqOokF+Rcl+VN
         KVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fmWSkGqGH8iPJNhPCVGrf62MqajYo96ZYWtYF0O/4Js=;
        b=CDqMl+MFBrPRxMjaSCHC+zkI/lnA74CrcZEu2CnG0rRf05UYjLPhJtqacbewFoglSO
         +2yaeH4yyKX79rPxhB1zg16ud7yuAefOaSd3L74HMBAPsSIAaM8opDftV0NvyKqhby8n
         QMd6KGCBalCE3fjkCeiGCJrP38J+eGxMIxaimPKxnLe1qQixSI6rdIoasTXGTFUd3f9b
         sA22ue5qveD2Rj4SDw9CVCHNFEn6woOlWaQOzRTr6PkhLUKMY0NZTRz41z6njNpJcN4d
         0rnjB8HRbNcC1Vex4VYrI5v8eO5KBh/6mHufyuDsB6IctMXgZ/4GHcTuWfSGBsvoj4Ai
         ZgGA==
X-Gm-Message-State: AOAM530wYK96MZTi3q042PuvnbPaKfShMnnfp3LY3NeYVz1Lgc+EOQV4
        mDefDvGrBFwVBlYKwfPvG3yBceC6KERhzqjoWxYzGLgDKCiY9g==
X-Google-Smtp-Source: ABdhPJzaA8ga4CATYhHXJj/mi4GD6Eltuje+JPWfHpy+w+cViuiKbSxvMCq1mnEwFTyJN2HvsUsQ+RxuJcgsjumuiUg=
X-Received: by 2002:a05:6402:1148:: with SMTP id g8mr4117237edw.271.1601078218966;
 Fri, 25 Sep 2020 16:56:58 -0700 (PDT)
MIME-Version: 1.0
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Sat, 26 Sep 2020 02:56:48 +0300
Message-ID: <CAMy7=ZVMPuXp6sOTPPtDYZbhan2PZDBUtsTTZ78PikxKMoBm9g@mail.gmail.com>
Subject: Help using libbpf with kernel 4.14
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I'm developing a tool which is now based on BCC, and would like to
make the move to libbpf.
I need the tool to support a minimal kernel version 4.14, which
doesn't have CO-RE.

I have read bcc-to-libbpf-howto-guide, and looked at the libbpf-tools of bcc,
but both only deal with newer kernels, and I failed to change them to
run with a 4.14 kernel.

Although some of the bpf samples in the kernel source don't use CO-RE,
they all use bpf_load.h,
and have dependencies on the tools dir, which I would like to avoid.

I would appreciate it if someone can help with a simple working
example of using libbpf on 4.14 kernel, without having any
dependencies. Specifically, I'm looking for an example makefile, and
to know how to load my bpf code with libbpf.

Thanks,
Yaniv
