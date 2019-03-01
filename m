Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6836EC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 06:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30560206DD
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 06:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQzz9RzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfCAGfb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:35:31 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43245 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfCAGfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 01:35:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so13663416qke.10;
        Thu, 28 Feb 2019 22:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUC4qzQGHYx36zgzUe83MUmf9+K58LsJSj2I4sRo+fY=;
        b=nQzz9RzHg97iz5olsVbn5kCUd2RlU75GhTcYXQwXUjBoUYPLYYQNJgT7Gg+Xm8tm5u
         r7y5JXAss2QBn7kAYWmmwWVIxp/gnB1uq4IfUcn6z6L//qJcndr6VLYl74H6op3ZsK5g
         4faNudgdV+/RNOXmZRcSqTAUN6UgHdJ8KmcTzJpbqmmGqpIw9HspK39BYZzpA7cyzldZ
         d2dnnasF3kKa4QSmlNJLMvYDYSYVtqNNkZp7FuqVZ7UZ7v7D2p68AGJP7pRKfow+SILv
         5iqbAI66chd304h5pcwPuNDIYfedLlPhvoQlkgKvQhBhrojM13FSvonL+wn3/jgLyuvF
         /T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUC4qzQGHYx36zgzUe83MUmf9+K58LsJSj2I4sRo+fY=;
        b=f4XhifjmDHTt5FNiaL38LBNPTNiybSw+lZJc2Kh8VhS1SqrFB/8I47dQdFKHiKwQiX
         QpNdXSSQBs8ARvGb+XzQ7RSTl/vD4+xYK45z3/Fzdvjl9ch1G8OTD959CmcsTqS2kE+C
         YgmCZTuF6ZEUmSZAxmBNUkgoDJXDRRBXyS/8uyI18PMWJWB8iSwVXkTZOTUm+qr7xtwQ
         +OsNZR/h+uPOt5d2jclUKElfdO8TMICoZEZqrkwXeSn7OwOcv7WTazZKK7GYos1YJdhn
         OdiCMTdJJEPbttKP6TSJir/NqhZyRBbdahIuDqu1rOY1vy19c4LlijUetpUp6ZS38BBS
         62ig==
X-Gm-Message-State: APjAAAU3WKXy95KvP3DkvK4bjk+3dAGiyWqVEP25ZFdCcbmozLeiJqJh
        b1M71GFfi67oNWFIaDUpuAiOryTTs51OAEQgQAg=
X-Google-Smtp-Source: APXvYqyj7Q2IiMorneVMjWKPeiowTxzXsTNrQ7qOFD3vvxUc4RdNmEuxr0GFvd3BMwdGZ53b+A6g+7BcxrkAS9vo8J0=
X-Received: by 2002:a37:bc04:: with SMTP id m4mr2666850qkf.41.1551422130619;
 Thu, 28 Feb 2019 22:35:30 -0800 (PST)
MIME-Version: 1.0
References: <20190301011221.1290474-1-andriin@fb.com>
In-Reply-To: <20190301011221.1290474-1-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 28 Feb 2019 22:35:19 -0800
Message-ID: <CAPhsuW4ihU28Wok8psLKN5qFxk-bpnk3p9PV9R64ppn4W9p_=w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/3] bpf docs typo, wording and formatting fixes
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@fb.com,
        yhs@fb.com, Networking <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 6:02 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> A bunch of BPF-related docs typo, wording and formatting fixes.
>
> v1->v2:
> - split off non-documentation changes into separate patchset

For the series:

Acked-by: Song Liu <songliubraving@fb.com>

>
> Andrii Nakryiko (3):
>   docs/btf: fix typos, improve wording
>   docs/btf: reflow text to fill up to 78 characters
>   docs/bpf: minor casing/punctuation fixes
>
>  Documentation/bpf/bpf_design_QA.rst |  24 +--
>  Documentation/bpf/btf.rst           | 316 +++++++++++++---------------
>  Documentation/networking/filter.txt |   2 +-
>  3 files changed, 160 insertions(+), 182 deletions(-)
>
> --
> 2.17.1
>
