Return-Path: <SRS0=eg6P=T5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0656C28CC0
	for <bpf@archiver.kernel.org>; Wed, 29 May 2019 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67D623EAE
	for <bpf@archiver.kernel.org>; Wed, 29 May 2019 17:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSYEg5Ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfE2RDz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 May 2019 13:03:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34157 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfE2RDz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 May 2019 13:03:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id h1so3526803qtp.1;
        Wed, 29 May 2019 10:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lyYcWrWqk2uqaWHLdJCXZCIIhh/8/m2Rv6Ciz2qleeI=;
        b=iSYEg5Ov8Q4PYW60985QWPtPvYglm2clHxaldgubR4k9IrHX73wb8rxpsgt1SfWsUK
         LbxMrCphd3esuOlfZY9i4PBCVSYEB70ZfOoQ4iBcEIEHubF95mlyTct1O0jDjF+XmGwo
         5W87w1vH2F9XqbN/n2pe+gEmiPAAb9sRKnODO5o6WPzvzkqYvV4LVSct7GuyHsBqt9YL
         F33Kpjd+P2HTGL9ElYbYrZNsxUmjzkhQuy7KqnTNe40IApe8Nqr0AxqD22pBwgkXk4P+
         Sr+tc1d5xH+ExmjXkBzpefz+wv+VB93T24RgeGe4WTp1mhPRwSJDGwVF+JftKcF5wzuH
         UNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lyYcWrWqk2uqaWHLdJCXZCIIhh/8/m2Rv6Ciz2qleeI=;
        b=WtoQSrnvehmIej60treawQqg4qWU1yBdDOPfuMFhMeMWecjhz+B7DT/s51iCF898hu
         9OcFG93cC0+oLXW71cKMgu1Mq+dWVVzIjE1Mve9vebSn3ymUODEzOgscEwI7FLttkS/d
         QjXAJ9o2O8LbF3sRAPhVLihXkxrq00tgZ7PqYDLhQz3DjnjM5QNtL4Fw2u/Pge7jaxxn
         l9eMQzF1N8//txhyUeIln0ogqFOOgM+0qkEICg3O3x4EicwDTZTeAETiQ2dduePlagif
         7GQjW5zRQVGLtgwfge50LjOuTGU+a06K77Jio97hDqCN2EQsLB/LWnKzbTszCBVmUGaK
         uz8Q==
X-Gm-Message-State: APjAAAVv6K6QCFCu5a1uZ/O7mSpnsGP5foxKFlS3jj/aXXAeG7nbpDRH
        qlbPvZZURmk5A2CJSxqi6Md8eVjtseOuk/DaDP4=
X-Google-Smtp-Source: APXvYqy02lL+Z1B3IFy6hII2uGlCJeix/zAVZ/i/X8OzJVW4iu/6Q0XrzeMW1xyFDOZUCjFfNSv7g6g0HM2ktLtATwU=
X-Received: by 2002:aed:3b66:: with SMTP id q35mr19513211qte.118.1559149434203;
 Wed, 29 May 2019 10:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190529011426.1328736-1-andriin@fb.com> <20190529011426.1328736-3-andriin@fb.com>
In-Reply-To: <20190529011426.1328736-3-andriin@fb.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 29 May 2019 10:03:43 -0700
Message-ID: <CAPhsuW6OTt78SB+1-01=PZ3wAu0DV1V3HyTvSoQTDkfVP9hfeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/9] libbpf: preserve errno before calling into
 user callback
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 28, 2019 at 6:14 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> pr_warning ultimately may call into user-provided callback function,
> which can clobber errno value, so we need to save it before that.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>


> ---
>  tools/lib/bpf/libbpf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 05a73223e524..7b80b9ae8a1f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -565,12 +565,12 @@ static int bpf_object__elf_init(struct bpf_object *obj)
>         } else {
>                 obj->efile.fd = open(obj->path, O_RDONLY);
>                 if (obj->efile.fd < 0) {
> -                       char errmsg[STRERR_BUFSIZE];
> -                       char *cp = libbpf_strerror_r(errno, errmsg,
> -                                                    sizeof(errmsg));
> +                       char errmsg[STRERR_BUFSIZE], *cp;
>
> +                       err = -errno;
> +                       cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
>                         pr_warning("failed to open %s: %s\n", obj->path, cp);
> -                       return -errno;
> +                       return err;
>                 }
>
>                 obj->efile.elf = elf_begin(obj->efile.fd,
> --
> 2.17.1
>
