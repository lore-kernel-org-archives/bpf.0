Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD6FC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 06:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5073120825
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 06:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVswTe3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfDOGGu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:06:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33294 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOGGt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 02:06:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id k14so17878083qtb.0;
        Sun, 14 Apr 2019 23:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjLOwnlq6i3TEEm06ENQBF7vpFtYBgYd3d+EiptOvVc=;
        b=tVswTe3o0x8YNXru/MMn8E1z13aoVddhx4gGmwvlLejTZr04ddDu7LqTuVDqEmKh/r
         IQQdRhW62t/Cw0deHSruWpNhtsmZN1HeuAKY86qLanWg/RGTgym9iDCrnFp1ZvxN7ypW
         /ZaP1zhwo7V1oWMGYxGn6puJ3fo0bBIi1mfQ4pzIsfnlbNGtFB84FL3ictASRGbdQEID
         IIYJ1EjePksWMhtpoqfBR5BJD5PYQHvAidfAbASKnxDahD9PdanlTsn3UfRvCRJPLZm5
         KkCqccaSYcPV1TKkZa/Z3OeP0m1KTR3OMk7qfLTnHSzab3oA43ySFz14LuLS02rqorod
         8aRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjLOwnlq6i3TEEm06ENQBF7vpFtYBgYd3d+EiptOvVc=;
        b=RsRvoRLpy09Caf8ex/jMLhpNtAHd2oLZVLb6xaOkkSndME5xJj/hmFmfySwHfZef2J
         zIpZmN/4JjNKo7IaHf7bp/3AJhdp/XP4gZf5rPx8PD9BNtG74kcm6/YtxLwASc602SJ4
         zaftHYnqHOLEAm0KaP6ZE+tsyZ8Ky9YSZ0PyohSdclrtI3oM3tb8FnPGT7g+vEuFnF87
         Uj9RCtZJl5ts6+PWhCzXrouKyTA3P10WNI2VYDVHi6CKy350X4WqU2tpI3MOdRAfmKZk
         YJbvuRKM2yXzoZfiKg0JPKvaazmOO2xBt/EUnzPc8ou83C6hlo1zeIKWJmpgTF8NKYNH
         Dv6Q==
X-Gm-Message-State: APjAAAXizdYLA00X8zYvyt0LlWvmtla5lRnnBINL77ViA6WEec/znRJ3
        Vdf1iLsKIsUWHe5l5Mvss+J+3PXLPBMqEqDo1+k=
X-Google-Smtp-Source: APXvYqwrmkjSdvAp6cDAyskS1mBDqUI9LlxTYlyDbdpYSmx/8g3hGscrvDIHTCRVfgXh2TrKxa9G/10+LmvQrc2eDFo=
X-Received: by 2002:aed:35b0:: with SMTP id c45mr58181538qte.144.1555308408852;
 Sun, 14 Apr 2019 23:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190413013732.18432-1-mcroce@redhat.com> <20190412184235.5fd2d650@cakuba.netronome.com>
In-Reply-To: <20190412184235.5fd2d650@cakuba.netronome.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Sun, 14 Apr 2019 23:06:38 -0700
Message-ID: <CAPhsuW71UM15V-_=EPoTV6A-qU4DtvLg6Vm96AQTOGq3Y+DXVA@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: add binary to gitignore
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Matteo Croce <mcroce@redhat.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 12, 2019 at 6:42 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Sat, 13 Apr 2019 03:37:32 +0200, Matteo Croce wrote:
> > Some binaries are generated when building libbpf from tools/lib/bpf/,
> > namely libbpf.so.0.0.2 and libbpf.so.0.
> > Add them to the local .gitignore.
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Acked-by: Song Liu <songliubraving@fb.com>

>
> Thanks!
