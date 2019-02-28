Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE918C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D54218CD
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDMcpAk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfB1TUN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:20:13 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37624 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfB1TUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 14:20:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so18710320otp.4;
        Thu, 28 Feb 2019 11:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7HNtpaNiO9UJUImWUP9icflqQvhjZIAHP4zL84UvM4=;
        b=ZDMcpAk0kBhtjNZgdGlFIJJcbdJN0D6tffgUy8NyDNmFdb+uE2TNwZqXMovzE48h67
         fLEcyz1oLQmkX0UGhz9dLxlT4HdpVpojmxQWBmI2I23rl8LscZC948IoTfrvYlIbCTIG
         paZJFg7SPyuNspO5+1bZqjy6ynILZY4SfvwgWyUPj0Gxi961QhSmE0RvlDfxJkcCsm82
         kcIWBteZJbWqNDBTwy9MmW38c3jtLaYiDMGQwfzpJzrlyf/79w1NgDGRGfim1c4ctM/9
         /vAiu66MqKqMAe//lh6+ZRoE01UAhNBEahXWmkQOR1b20uXPj5zV3l7uayAuO0EncLR2
         vuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7HNtpaNiO9UJUImWUP9icflqQvhjZIAHP4zL84UvM4=;
        b=P3id1+7xWY0bJFix1EUQv7XN0e4UheKId5p9NXlcQfnwAjBq46h9oZpW8b0jpI3WZw
         ZuSNp53Z+cZ/UWE6atulUk4S8wXLaVze2Ms2rJDTO/ngQCuDSBopcqU64wEqVZQcqCUA
         0iMpGt3uR51myiYnR70GePreS6gB4YDv+QdBFZia8IXWxGqONuC+78o327efzUqUDUK3
         3Ro/tcw3fS4Ql9BqYYopWUlMFmfV+3G4oizhD+KVqUgh87olBKsjZmZjTM0pWUxrXeOG
         fs3mhqmjUTr16vEP1pL9i8I+2lrugrveIRei3qaIti0AHBU+yd9/MsjMGIuNXZQqM+cu
         VwyQ==
X-Gm-Message-State: APjAAAWMXGu4KXL5AqKQFrTuAbzBqh2ERQa+Jb4cLD/xIGHG9Rcig9kg
        x5lzJ/MtvVavy/D3zbLfTrSpGvhiybFbhwB7A68=
X-Google-Smtp-Source: APXvYqxQgVNnhcrvS+YWb9Z01gG93f00EfLNzO/WMWu1BO3vtKhiXqW2/uyIAbDqBQkHZiGnsHrad62AxlqufhmyXdk=
X-Received: by 2002:a9d:6a08:: with SMTP id g8mr842787otn.191.1551381612405;
 Thu, 28 Feb 2019 11:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20190227224642.1069138-1-andriin@fb.com> <20190227224642.1069138-3-andriin@fb.com>
 <20190228185311.GI9508@kernel.org>
In-Reply-To: <20190228185311.GI9508@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Feb 2019 11:20:01 -0800
Message-ID: <CAEf4BzYX37SzZ0a5aC=4cZtP9CCaR=H=DGcedrxv9pfUuZk0eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] libbpf: fix formatting for btf_ext__get_raw_data
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 10:53 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Feb 27, 2019 at 02:46:38PM -0800, Andrii Nakryiko escreveu:
> > Fix invalid formatting of pointer arg.
> >
> > Fixes: ae4ab4b4117d ("btf: expose API to work with raw btf_ext data")
>
> Also I think Fixes here is not applicable :-)

Yeah, I was probably too pedantic, I'll remove it from v2 :)

>
> - Arnaldo
>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  tools/lib/bpf/btf.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index 94bbc249b0f1..b60bb7cf5fff 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -76,7 +76,7 @@ LIBBPF_API int btf__get_map_kv_tids(const struct btf *btf, const char *map_name,
> >
> >  LIBBPF_API struct btf_ext *btf_ext__new(__u8 *data, __u32 size);
> >  LIBBPF_API void btf_ext__free(struct btf_ext *btf_ext);
> > -LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext* btf_ext,
> > +LIBBPF_API const void *btf_ext__get_raw_data(const struct btf_ext *btf_ext,
> >                                            __u32 *size);
> >  LIBBPF_API int btf_ext__reloc_func_info(const struct btf *btf,
> >                                       const struct btf_ext *btf_ext,
> > --
> > 2.17.1
>
> --
>
> - Arnaldo
