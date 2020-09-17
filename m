Return-Path: <SRS0=dFgW=C2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB7DC43463
	for <bpf@archiver.kernel.org>; Thu, 17 Sep 2020 22:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871A920872
	for <bpf@archiver.kernel.org>; Thu, 17 Sep 2020 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600380194;
	bh=fzoB74crSzCrnyBIx7j1le08Ul1PJdBgTdFlcxWJ1L4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aNjJqlX9QfRv0QMg8D07mC7OBq5I+sw/YEW38MtgSThbcHoybD1KDADkxbSpkIS8R
	 tZGNOuHgH2xQ32FZ7ppUVE6RkQUeAS6Ffj2aKTsHYwUNth7ZUXgf2cKIb7noLmKL00
	 3+e9E+oeCLYGYGaLRnws6bZtsMreI/HrmrJA6FOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIQWDO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgIQWDN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 18:03:13 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A95E223447
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2020 22:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600380193;
        bh=fzoB74crSzCrnyBIx7j1le08Ul1PJdBgTdFlcxWJ1L4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EQrmfn3WjIXX8WtS+FFLU8FVgBY6G5N04y1OBqjftxGODDCnHX2UrxnkINaHYYGBo
         zf0eKmuaXn8vZgVLehmk+PYZJ/FUz5/JLmyONJK+CBtHRfxQomoqkhF5ZfsYa8i/IY
         4XOzMQuoA+ss73YE2Pjoh62T4FaX7SoqwSUbb+3g=
Received: by mail-lj1-f174.google.com with SMTP id y4so3345584ljk.8
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2020 15:03:12 -0700 (PDT)
X-Gm-Message-State: AOAM531mtJGonhcuE1oL6zRDCDHt8sEXpTUrwfhptHdDvAjaO9/Ir/Ho
        pRcmPxUWtw/QIYQEm0gYP8U6q15qqk8UyZwNXYQ=
X-Google-Smtp-Source: ABdhPJygRGW0qqK0b/Wm8hlkSmAK3UCpfb5SQQiKGiX42KV4qKbWv4HU5WUSidabhLoCq6tYiG1IkcGNWpPqC/1hlsA=
X-Received: by 2002:a2e:b0d6:: with SMTP id g22mr9869106ljl.350.1600380191016;
 Thu, 17 Sep 2020 15:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200915115519.3769807-1-iii@linux.ibm.com> <CAEf4BzZzqs6Z8E0imPOUdr2sSeAz_JvsEKgoy=7FsJnnK0Edhw@mail.gmail.com>
In-Reply-To: <CAEf4BzZzqs6Z8E0imPOUdr2sSeAz_JvsEKgoy=7FsJnnK0Edhw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 17 Sep 2020 15:02:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5qOebwOS9oZc7mtJnsQv1mrii3pQSyNMmF7ZUyM4Obfg@mail.gmail.com>
Message-ID: <CAPhsuW5qOebwOS9oZc7mtJnsQv1mrii3pQSyNMmF7ZUyM4Obfg@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next] samples/bpf: Fix test_map_in_map on s390
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 6:00 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 15, 2020 at 5:42 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > s390 uses socketcall multiplexer instead of individual socket syscalls.
> > Therefore, "kprobe/" SYSCALL(sys_connect) does not trigger and
> > test_map_in_map fails. Fix by using "kprobe/__sys_connect" instead.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >
>
> LGTM.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
