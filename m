Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDAC433FE
	for <bpf@archiver.kernel.org>; Wed,  9 Feb 2022 23:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiBIXQS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 9 Feb 2022 18:16:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiBIXQO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 18:16:14 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A87E051119
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 15:16:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y8so4310198pfa.11
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiEPjANCsoc2fvs2Pw5lmjLT2HWBxHyAt8A18o33Kq4=;
        b=hqVZmcvQ9KIz4xNdDtIYwsY+XgYR4zlFlrVA/sPYEwZkc+zDZKn6aDqtYI3B8G2BlH
         567ZenDQFW7wdYqppOJd4bFFSR+Xe1tWPrifLGASZtmYt+XmhR77AukFMuIeydXr/Eff
         gIaOrCytOExEW+4ug843hVLKnicR8zN+91rkVp1L+5TCGTUuwcSlhHlv2hjKZIChO873
         J0O9V5xrInKHppL3txp33YL0myBCUNBNu93Sk2h3PUOxB2JEqeRAPDjVWvg4nYX1HdVW
         0/ECNvw2gUfrW1ckImQW0URJxda+strhDVFuMhyz7EJWBC/XbFNwcTCJhN32OCSYpB4e
         XKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiEPjANCsoc2fvs2Pw5lmjLT2HWBxHyAt8A18o33Kq4=;
        b=ZU4zOiRkghyH/mNZROKoQGrb6CFtoH0rpoXruVg22rmnyVyt/oqgmcBjWdQh3kPYE/
         uJ2L+MD1e6obGLrJGemGRDwaQQ7DdXU3aQONc2WRV7s+TauD5yIl6C6cwGzAgSet53/Y
         LHtq+8VtN0/KzpMF1fl9lBfuTKFN6Ph6XG+DxiYD91VcuyZNu1xqqWv2MaIJIf96ID4H
         s1XSS26PZcRn73Vwlu4+6ETh1bx2xUjwAwEiCH59KGZo/e2XzlhIiu34w+V7u0pZ8lc5
         pBUjuiP+hJH2UToP9F6Ks1/ePs+PZljD3Wuteii38gYK3aElgBW1vjndUEkWj26ZgS3G
         kJYw==
X-Gm-Message-State: AOAM532NIXUQjqHbc0U0uH79+ZqrGgTOH7yuOeHzTTqHcoOPyE5OobDK
        81Rht8Ml1534mBhTshoSoUoDrXyG1MNQtCT6owM=
X-Google-Smtp-Source: ABdhPJxEdG4ur4ylaLNRzR5K30mupRQBn3ND5IT9dLTuXtrYTdBfIPt5P8fAW3MojSOg39I8d76Vn9GNLugV0Soaa7o=
X-Received: by 2002:a63:2c4e:: with SMTP id s75mr3720688pgs.497.1644448562155;
 Wed, 09 Feb 2022 15:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
 <20220209054315.73833-3-alexei.starovoitov@gmail.com> <2e1afed6-680e-e311-d94a-b8fb28d93bbf@fb.com>
In-Reply-To: <2e1afed6-680e-e311-d94a-b8fb28d93bbf@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Feb 2022 15:15:50 -0800
Message-ID: <CAADnVQ+nR_J9VO597aWQjiGWU_taU-P1FVvNxhZv15kaWi5AZQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/5] libbpf: Prepare light skeleton for the kernel.
To:     Yonghong Song <yhs@fb.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 9, 2022 at 8:49 AM Yonghong Song <yhs@fb.com> wrote:
> > +
> > +static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz, size_t val_sz)
> > +{
> > +     return (__u64) (long) *addr;
> > +}
>
> The above is user space lskel definition for skel_prep_init_value.
> Below the kernel space lskel definition:
>
> +static inline __u64 skel_prep_init_value(void **addr, size_t mmap_sz,
> size_t val_sz)
> +{
> +       return (__u64) (long) *addr;
> +}
>
> First they are identical and second this function is simple enough can
> we do actual inlining during lskel code generation?

Sure. Will do.
