Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D34C433DB
	for <bpf@archiver.kernel.org>; Fri, 15 Jan 2021 16:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF75221FE
	for <bpf@archiver.kernel.org>; Fri, 15 Jan 2021 16:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbhAOQjx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Jan 2021 11:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhAOQjx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jan 2021 11:39:53 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9DCC0613D3
        for <bpf@vger.kernel.org>; Fri, 15 Jan 2021 08:39:12 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id h16so4225231qvu.8
        for <bpf@vger.kernel.org>; Fri, 15 Jan 2021 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+tkUYiTSMZ6aZ2SFhexaT+SsaeIWjTivEj+w6tLR3g=;
        b=TB5NZE3Hxl8ljI7dGaiqKe3Xr5kVQhSvWat/VKetbaGOEzq81mqtlI7mTc4uOEFGLY
         WNKbj/URwAYxLVNojc5ihCHBqcTpr5BLfuHAErztTgGOXLp/gu+TCrAZyWn3KxnFsCTa
         kn75VTHudIHwbLqSzCDi0N0zESdgaT+fd6mg4bOLsXuJKndhNxjrpDGZdQokowK4ZjCG
         dcPD6OUVGsSg1s8DdQC32qzlnBgRDIskrNHNI2q2OQju+wAAY/+UhA5460ofWLqe6PH6
         2Qdqfki3MYLxhRxF4aK6VJVjc94B6uCnWXh1avsnldoKB4SUHiGlLpCi+5QzUwkG+yZp
         dF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+tkUYiTSMZ6aZ2SFhexaT+SsaeIWjTivEj+w6tLR3g=;
        b=DPJcqOcopacJFtNXfGKipTveRFQ6pvsSHyW5uYcwI+A0Phus1Cx0UMIB4vwDb/XWeh
         NEus9QoLr4rfsbrKnU07RZT0t0wqwpNWhRwwHGhxgBmSfbuUpM5zZarsTaKH2iU9Q9h6
         hE8Dr5Y0Rf/jv5lMN2y4oL+u1PfsfKcDtXxh8QQ/sXVTguacsSAqXyRGmspspvi5yz4P
         qYB6ZHFrBXKb2hkWF8i+B+jyB+O5G5Yx5QDfwI3AzcGN7Hmt5XQW2ntpYoK2b7mNS5OB
         v1FjPxJUxEwKQiNB1fHDhnx/B0/6KFzLTfRhJHD5hi4roxGnbgH8sZQNcNiq1ITOiPaA
         Utow==
X-Gm-Message-State: AOAM530WABg70cQrJsy90jwZ1sN6ZFdFCYM/kELm94L7r/2kjRSGBrEl
        bTWejARHp0yKqNU8VLBTWZ3Jie/iLBu0wpu3I0Htug==
X-Google-Smtp-Source: ABdhPJy1Qtz6TjR5mJqiQ1mxDU1AgQiXDERUi9WuA2dypM2+OnO6K4m4y5ICpOwri14Hil3gSnpU1G2/ynvydUgowbo=
X-Received: by 2002:a0c:b21e:: with SMTP id x30mr12889913qvd.21.1610728751775;
 Fri, 15 Jan 2021 08:39:11 -0800 (PST)
MIME-Version: 1.0
References: <1627e0f688c7de7fe291b09c524c7fbb55cfe367.1610669653.git.sdf@google.com>
 <CAEf4BzZOt-VZPwHZ4uGxG_mZYb7NX3wJv1UiAnnt3+dOSkkqtA@mail.gmail.com>
 <CAKH8qBuvbRa0qSbYBqJ0cz5vcQ-8XQA8k6B4FS-TNE1QUEnH8Q@mail.gmail.com>
 <CAADnVQJwOteRbJuZXhbkexBYp2Sr2R9KxgTF4xEw16KmCuH1sQ@mail.gmail.com> <500e4d8b-6ed0-92a5-a5ef-9477766be3e4@fb.com>
In-Reply-To: <500e4d8b-6ed0-92a5-a5ef-9477766be3e4@fb.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 15 Jan 2021 08:39:00 -0800
Message-ID: <CAKH8qBuZ0iLAiuqi=65RBiQ=Vhi3qkitPzj0b7U=XuiH_4TuLA@mail.gmail.com>
Subject: Re: [RPC PATCH bpf-next] bpf: implement new BPF_CGROUP_INET_SOCK_POST_CONNECT
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 8:27 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 1/14/21 7:59 PM, Alexei Starovoitov wrote:
> > On Thu, Jan 14, 2021 at 7:51 PM Stanislav Fomichev <sdf@google.com> wrote:
> >>>>
> >>>>          lock_sock(sock->sk);
> >>>>          err = __inet_stream_connect(sock, uaddr, addr_len, flags, 0);
> >>>
> >>> Similarly here, attaching fexit to __inet_stream_connect would execute
> >>> your BPF program at exactly the same time (and then you can check for
> >>> err value).
> >>>
> >>> Or the point here is to have a more "stable" BPF program type?
> >> Good suggestion, I can try to play with it, I think it should give me
> >> all the info I need (I only need sock).
> >> But yeah, I'd rather prefer a stable interface against stable
> >> __sk_buff, but maybe fexit will also work.
> >
> > Maybe we can add an extension to fentry/fexit that are cgroup scoped?
> > I think this will solve many such cases.
>
> Currently, google is pushing LTO build of the kernel. If this happens,
> it is possible one global function in one file (say a.c) might be
> inlined into another file (say b.c). So in this particular case,
> if the global function is inlined, fentry/fexit approach might be
> missing some cases? We could mark certain *special purpose* function
> as non-inline, but not sure whether this is scalable or not.
For this particular case I don't think it matters, right?
I'd like to fexit ip4_datagram_connect which is exported symbol,
it's accessed via proto->connect and there is no way it's
gonna be inlined. Unless our indirect call macros give clang
a hint :-/

I'm in general a bit concerned about using tracing calls for stuff
like that and depending on the non-uapi, but it's probably
time to give it a try and see how co-re works :-)
