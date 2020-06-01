Return-Path: <SRS0=sVLx=7O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF71C433E0
	for <bpf@archiver.kernel.org>; Mon,  1 Jun 2020 20:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A6E206E2
	for <bpf@archiver.kernel.org>; Mon,  1 Jun 2020 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591043741;
	bh=JsbQXlmFMhtqXjx/A34pmF0kYb2nSCb+1ngY5SN7Qkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nPUnUE8PP/2pyzvHbVh0HdarP4vKJO6a4e5lawNwxfC0d2DbGE3EvBgeTS0ogAI2T
	 yhsDGbkAojswbSTF1gqngMOdqhDQFh4j1yeFilHF8bEjTcKNFLsDDUzLYQIlYQAdOv
	 rGNtgjAhA3pNISXOooXlwgHWoAW3JYtJy9KhThxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgFAUfl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgFAUfk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 16:35:40 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FB2206E2;
        Mon,  1 Jun 2020 20:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591043740;
        bh=JsbQXlmFMhtqXjx/A34pmF0kYb2nSCb+1ngY5SN7Qkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yD2ZjHKYRoQlAovF6CK3povaxVZgJOlJhbZQMa9wgQNdR/5Rd41v4yKI1fnKKjVJ4
         aVR/61LGpJ+TEAbNbeLRr67ahpxb7Ut9F70duul3xk5j+0MmgQEHSUKgZE/5Hzu4Hq
         jA3sGQ87WclwPZgzUemhJguU05TeTkxmhtzl+qns=
Received: by mail-lj1-f177.google.com with SMTP id q2so9810097ljm.10;
        Mon, 01 Jun 2020 13:35:40 -0700 (PDT)
X-Gm-Message-State: AOAM532R/qOEOxzSwlxcQ9dLLw5J2R5AK7vZwW+Ln7Udg0jrCgia1q3m
        en+Xfy35ErhcEo4mCuItGL7yJ8cbxcqmenMad/U=
X-Google-Smtp-Source: ABdhPJxp3mMx0eNS2rBQtUj8o7jjp8bUGw2/F23NrTuI05rFCATzlcxPoYtxEm2S3lktxuONzdgrTY5jw4tX3/TGr8I=
X-Received: by 2002:a2e:a377:: with SMTP id i23mr11078911ljn.392.1591043738495;
 Mon, 01 Jun 2020 13:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200601202601.2139477-1-andriin@fb.com>
In-Reply-To: <20200601202601.2139477-1-andriin@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 1 Jun 2020 13:35:27 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7PooK=u12k2NDeSdm8NMTW1aUKGRbmAuLAXgRKT12MpQ@mail.gmail.com>
Message-ID: <CAPhsuW7PooK=u12k2NDeSdm8NMTW1aUKGRbmAuLAXgRKT12MpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add _GNU_SOURCE for reallocarray to ringbuf.c
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 1, 2020 at 1:26 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> On systems with recent enough glibc, reallocarray compat won't kick in, so
> reallocarray() itself has to come from stdlib.h include. But _GNU_SOURCE is
> necessary to enable it. So add it.
>
> Fixes: 4cff2ba58bf1 ("libbpf: Add BPF ring buffer support")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
