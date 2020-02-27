Return-Path: <SRS0=DkpX=4P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FB1C4BA24
	for <bpf@archiver.kernel.org>; Thu, 27 Feb 2020 05:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C577E24679
	for <bpf@archiver.kernel.org>; Thu, 27 Feb 2020 05:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582782870;
	bh=YBjXhU/CemLtEnaFYjD1gLcBE8dcVCt7LRKyMaf+rj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a6yhUuTgWO9eFhfjk4sEwCneykLQZ5cCnwWZL19q3WvgWIi/Z7MfIGGIeSircnVJV
	 H4GLTAgxfHjKUcTieBZ29xj/Por5b9j7WO3m59mRYWxxDIaclvtDIcroz6gNZ8eRex
	 YYsFw3p7sNLwxZKlRW9UkRI+uBLbNlk7aowDiTcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgB0Fya (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:54:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgB0Fya (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 00:54:30 -0500
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6666B2467B;
        Thu, 27 Feb 2020 05:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582782869;
        bh=YBjXhU/CemLtEnaFYjD1gLcBE8dcVCt7LRKyMaf+rj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6dPKfV7uu0lFBYIvR0FyR47gjR0mDojCdcK7o0gQugJR8nfdiytcd2+zaYIJxWgz
         wVYHmaeEyIAiKy0apFJ3Zj1m+LuzFhPbUfW48NEUc8Z7JmSj2KJIY2AxHDi/VBTg4h
         9CdGKrzlufv4xqNWrGJ0TWDAQ4qWAA1tTS9cM+rY=
Received: by mail-lj1-f176.google.com with SMTP id q23so1923404ljm.4;
        Wed, 26 Feb 2020 21:54:29 -0800 (PST)
X-Gm-Message-State: ANhLgQ3aJ8BYvxE14GBIIJOpJKJdqR+GVkbEUjm6lpzSzXOfyy2vB7zG
        t0LhAI+m6qwr6CJT6Izd8kgjsszt2oQXw5WV9Wo=
X-Google-Smtp-Source: ADFU+vvC0MyUkEzgb8n4fviHJpl88c9Yqf/sjgp06O/Nn16OeQSdYeGn3h2nN40GWvs8tQnP7ULJaQr/2W1x18TGbM4=
X-Received: by 2002:a2e:b017:: with SMTP id y23mr1649969ljk.229.1582782867602;
 Wed, 26 Feb 2020 21:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20200226130345.209469-1-jolsa@kernel.org> <20200226130345.209469-19-jolsa@kernel.org>
In-Reply-To: <20200226130345.209469-19-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 26 Feb 2020 21:54:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7QCFzUPKvLKa4gdzozSPpeAimzw8W5HQKKW6AH4rhTfQ@mail.gmail.com>
Message-ID: <CAPhsuW7QCFzUPKvLKa4gdzozSPpeAimzw8W5HQKKW6AH4rhTfQ@mail.gmail.com>
Subject: Re: [PATCH 18/18] perf annotate: Add base support for bpf_image
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 26, 2020 at 5:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding the DSO_BINARY_TYPE__BPF_IMAGE dso binary type
> to recognize bpf images that carry trampoline or dispatcher.
>
> Upcoming patches will add support to read the image data,
> store it within the BPF feature in perf.data and display
> it for annotation purposes.
>
> Currently we only display following message:
>
>   # ./perf annotate bpf_trampoline_24456 --stdio
>    Percent |      Source code & Disassembly of . for cycles (504  ...
>   --------------------------------------------------------------- ...
>            :       to be implemented
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
