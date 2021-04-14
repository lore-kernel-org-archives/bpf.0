Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD305C433ED
	for <bpf@archiver.kernel.org>; Wed, 14 Apr 2021 10:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A3A613CD
	for <bpf@archiver.kernel.org>; Wed, 14 Apr 2021 10:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhDNK5S (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Apr 2021 06:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhDNK5S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 06:57:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568BC061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 03:56:57 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id v123so13352418ioe.10
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJdZSbHTyMBCsVp7BAaTCxdXi6B0tpl9od8+wlQ9J+g=;
        b=TEAgfFBFUB3b0fB+QOyjxFBwYw0U5RxeWNc26RxJa8ik23iALaiCaRngy5LMzw9L8o
         ngDCjNrtS7pw5RNK5LCLafOfxKX5DMh1H3zLWoCqWVa9aaP7xk6xhD22vEEhdjO/3zMq
         4tbPUaynT31cZgfRtXvFhfpcpcSWqp//AzYq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJdZSbHTyMBCsVp7BAaTCxdXi6B0tpl9od8+wlQ9J+g=;
        b=GuqV4uY6/0oqUiIa32DwauGAPIaCpkuuKaBMOxh7NFbHXzIclSNG6ySxKq4pRB4csI
         s/HgfxERs3UcPx8omV7TnQiOuvdUuEOcdl1se7BbSflSN6j7gQK/HkntcdTZpNIDu+uX
         ycElOp79ZAzBRk8WXKuDqgR5WDo65Mk7GsKqLKSolYs5qce2lmxc5kCsLaTpn4cEpIiZ
         ZgY166fAxQbD2MYQAkiff7o2Eb5QcYEnuK31NgIV+mdN933I/VXSFIzdL4FQECdSBYol
         diqYDBKrrooTJ2fBxN3wxzJ/5ehVHMnyXK6mEprp47fG1+L1GlNqauYS97kLpRiTV1wp
         g7uw==
X-Gm-Message-State: AOAM531ZVCfVLYJZ2g5dJcvTcRE7v28RYiFNzZ9OOeABIyOEdqVJobaN
        gioydVakqJznwnGodREiX6RwrGIw5tbYicSz/zAcgw==
X-Google-Smtp-Source: ABdhPJzbOpygaeq8A7GMJvLn+Om67N8hLLaO1CKhbeDgYPkDMIxrniuJJUuaib3hhaIExfwv2HbHOYjtPypZ2p0Mt3M=
X-Received: by 2002:a02:b197:: with SMTP id t23mr37906352jah.125.1618397816954;
 Wed, 14 Apr 2021 03:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-2-revest@chromium.org>
 <CAEf4BzaUeE7EPObUuS=NPw9qmssxJ=i6+M1v6A3=wvLVGOKkXg@mail.gmail.com> <CABRcYmKjcZD4px3QwjqMZozOJDTXV+fWvf+w2R=ssPyBOJmMTg@mail.gmail.com>
In-Reply-To: <CABRcYmKjcZD4px3QwjqMZozOJDTXV+fWvf+w2R=ssPyBOJmMTg@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 14 Apr 2021 12:56:46 +0200
Message-ID: <CABRcYmJz_yGqJx_suu8JN8SkHZm10RaSS5xx=f7QDZFFNS9twg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Factorize bpf_trace_printk and bpf_seq_printf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 11:56 AM Florent Revest <revest@chromium.org> wrote:
> On Wed, Apr 14, 2021 at 1:01 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
> > > +       err = 0;
> > > +out:
> > > +       put_fmt_tmp_buf();
> >
> > so you are putting tmp_buf unconditionally, even when there was no
> > error. That seems wrong? Should this be:
> >
> > if (err)
> >     put_fmt_tmp_buf()
> >
> > ?
>
> Yeah the naming is unfortunate, as discussed in the other patch, I
> will rename that to bpf_pintf_cleanup instead. It's not clear from the
> name that it only "puts" if the buffer was already gotten.

Ah, sorry I see what you meant! Indeed, my mistake. :|
