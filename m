Return-Path: <SRS0=4c4M=C6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E89CC4727D
	for <bpf@archiver.kernel.org>; Mon, 21 Sep 2020 22:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C24323A63
	for <bpf@archiver.kernel.org>; Mon, 21 Sep 2020 22:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQai4T3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgIUWjj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgIUWji (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 18:39:38 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747A8C061755;
        Mon, 21 Sep 2020 15:39:38 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id k2so11427375ybp.7;
        Mon, 21 Sep 2020 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MTgpZaEUVu6kw4q7DIocpZoFpDJ7k2hZvDPOxQF+RYE=;
        b=OQai4T3aq5xMgt4Okwu55BQKVFWJSSRJX71HyJAnxCiEhHvVTVhjc85pD3l+MNSWG/
         9WefO3e786Sqb6BPeS+DjagLwS2T7Odl0nLfo6wqjsmd92qCWuZEo0g41FeshBsWitkk
         jQFd/fyoKs0Wss/Fmv7wrA6dCswmBN2bZd5qomCbBYN3U/82tmM1bpYOZS/j0TQDVQ3j
         YjOZ64aWu44m0J1zfu0tE3U3r5rYFTgif+7CmuRUzejmY3YAevuMLjkajVrbljpuPWog
         kFHM7c1iLQ557HgCYT4zFSTLgK/eeww9XYhZtgqO8Za76t8smMp02IP4eihrrWbYqz3+
         90BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MTgpZaEUVu6kw4q7DIocpZoFpDJ7k2hZvDPOxQF+RYE=;
        b=ItzbYHWI0EBmVvuCkfZMIYp9fOaJ6SGwA/AfxZFrDSYiSGnqc3vTGT7ovmK+dRu4BS
         nF7lV1lpZWY0XTLwDXmjuugkxtMisadk+PeFhWPLK2nkXOgYL/wIUZza733/wjp8YZUl
         xWhRkseTnyUU8rKDXn5BOe5RNCPaJBDSFW6T3cPQCxb0+0RKZE68pxAOt2ItujINMhMR
         miziDE8o4/yrlYAuxOYtLXECVSsdptJE1oZxl/6dXuaLB/eY2gWFvM9ICHfcKMjfBR2N
         Hd64jqY1crQLeYaKpfTo3cU4RL1ytrLf3ygXumBEs0d/37XmsFUjFL5h0OCFuxlFUali
         TKug==
X-Gm-Message-State: AOAM5300XerHAprkN9gLIuKYFlh508LcjRgrA1Mr6YfRe4lyOKIzLHjr
        4HkhGIVjkJ4Uo/JNeoGbESM5qNZ2Qjr9MJih1xE=
X-Google-Smtp-Source: ABdhPJxB5o8KlxMuPMl/axpG5ZW52JZukZAYMK/AT8rssYF45l4E1hsJ4zJOHZT25pRPx0fjoXNqMlcIa+Fctw8w8GU=
X-Received: by 2002:a25:4446:: with SMTP id r67mr2919486yba.459.1600727977616;
 Mon, 21 Sep 2020 15:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <160051618267.58048.2336966160671014012.stgit@toke.dk> <160051618391.58048.12525358750568883938.stgit@toke.dk>
In-Reply-To: <160051618391.58048.12525358750568883938.stgit@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Sep 2020 15:39:26 -0700
Message-ID: <CAEf4Bzbb5gt7KgmfXM6FiC750GjxL23XO4GPnVHFgCGaMTuDCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 01/10] bpf: disallow attaching modify_return
 tracing functions to other BPF programs
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 19, 2020 at 4:50 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> From the checks and commit messages for modify_return, it seems it was
> never the intention that it should be possible to attach a tracing progra=
m
> with expected_attach_type =3D=3D BPF_MODIFY_RETURN to another BPF program=
.
> However, check_attach_modify_return() will only look at the function name=
,
> so if the target function starts with "security_", the attach will be
> allowed even for bpf2bpf attachment.
>
> Fix this oversight by also blocking the modification if a target program =
is
> supplied.
>
> Fixes: 18644cec714a ("bpf: Fix use-after-free in fmod_ret check")
> Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN"=
)
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  kernel/bpf/verifier.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4161b6c406bc..cb1b0f9fd770 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11442,7 +11442,7 @@ static int check_attach_btf_id(struct bpf_verifie=
r_env *env)
>                                         prog->aux->attach_func_name);
>                 } else if (prog->expected_attach_type =3D=3D BPF_MODIFY_R=
ETURN) {
>                         ret =3D check_attach_modify_return(prog, addr);
> -                       if (ret)
> +                       if (ret || tgt_prog)

can you please do it as a separate check with a more appropriate and
meaningful message?

>                                 verbose(env, "%s() is not modifiable\n",
>                                         prog->aux->attach_func_name);
>                 }
>
