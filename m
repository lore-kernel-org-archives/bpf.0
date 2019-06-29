Return-Path: <SRS0=toPo=U4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12934C4321A
	for <bpf@archiver.kernel.org>; Sat, 29 Jun 2019 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84942086D
	for <bpf@archiver.kernel.org>; Sat, 29 Jun 2019 08:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgvrW0fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfF2I4H (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 29 Jun 2019 04:56:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36969 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF2I4H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Jun 2019 04:56:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so9182419qtk.4;
        Sat, 29 Jun 2019 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3bT9EVpnV95c8ajVidkbIYok+0DnrnG9SJ3NNjWPDQ=;
        b=QgvrW0fjnpuQrMySQlEFY3ORlsrC4yy9h2sdFiJ14Z9n5Vdx1A0Wgi2Tu9Pr42t/8y
         vaXAWVTZ3pfu0zf0wpQoMl86Sm6QaZhng6obrw2Mp7g0r02a+jJm7xPs9s2tE8x5Hy8i
         Tks5Q5a955acqQ/xHWXBLiRx+3tHrVPbBMwpDO1LbefRwoTtaPqBfcxtlwpQOqv5w8vs
         aixJOzib9a2wcPRcOl6Q77n0f+6K+uvMPD3Gu75yQboRq6T8Nwd73Haj2XzDCcM9OcvG
         EdxzIT7T1Pb4RRpFHnTYcVTCymbdNZNdYTTMzJBetS0jGQzQhyoyzzusneG6HXjYPUOF
         0CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3bT9EVpnV95c8ajVidkbIYok+0DnrnG9SJ3NNjWPDQ=;
        b=Q0aTbhWENW0PDqRZbL/qdjF3OhZHm98ciWoczS8eJIQtJ64OtrMzFQo23NmzJAwzZn
         hOwaLn4ezunDxotUdBNzSvcdy4AUKhOd8LA6iM7XBGeKq45nhQeEs4JtfCOF48H9RS6M
         RVzHcu6kBQXNvtrjW+XQKzh9XjbLygHXlX5s8vuJ+LBUep0uV9kzbFGOWgOz/xp9bHdh
         lDekbqEJjFNZfzoaaoADsoP/ZzC9vflEFLhpacZVRUO6lLTPFmxc3sWpjXfIyDBQ6a5c
         NZo5RWt+pVi/3GzMxPboey7xSp9tRVDHM1suSbErBuou1lzMgbQHjdHVrH9cNqV86ZzW
         8BFg==
X-Gm-Message-State: APjAAAUP9jImpcdesDyo7S+UFhtAcs4Dr/CalWwwYqlxEAP+fwiwPxRK
        /CIrDqHG60VcbPzlOJKNq6m036N5uEu0EAvBSMo=
X-Google-Smtp-Source: APXvYqzWZu46v2gW7RF4ZYeubet8Kbl36Bn9mFb9kFAw9r0OPCFeneWXiohFbbjCgiemjqgxfyf9mK0zHe/DZ+Cok0E=
X-Received: by 2002:ac8:25e7:: with SMTP id f36mr11682012qtf.139.1561798566392;
 Sat, 29 Jun 2019 01:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190629055309.1594755-1-andriin@fb.com> <20190629055309.1594755-3-andriin@fb.com>
In-Reply-To: <20190629055309.1594755-3-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sat, 29 Jun 2019 01:55:55 -0700
Message-ID: <CAPhsuW71yTbuRc7d2wGRfddy42_0CREnNqJiqdMkTre8dC+u-Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/4] libbpf: auto-set PERF_EVENT_ARRAY size to
 number of CPUs
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 28, 2019 at 10:55 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> For BPF_MAP_TYPE_PERF_EVENT_ARRAY typically correct size is number of
> possible CPUs. This is impossible to specify at compilation time. This
> change adds automatic setting of PERF_EVENT_ARRAY size to number of
> system CPUs, unless non-zero size is specified explicitly. This allows
> to adjust size for advanced specific cases, while providing convenient
> and logical defaults.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
