Return-Path: <SRS0=fGWk=3K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4F7C2D0CE
	for <bpf@archiver.kernel.org>; Tue, 21 Jan 2020 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B56924655
	for <bpf@archiver.kernel.org>; Tue, 21 Jan 2020 19:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7V3uRh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgAUTGU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:06:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42840 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAUTGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 14:06:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id q15so3125393qke.9;
        Tue, 21 Jan 2020 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9l4pccApU6icRLlOza3B0ImHsVOwXrkyewWhbtE6M8=;
        b=Y7V3uRh4VCQUOCckTPU9FlDtZ7lj354vAGW71DSl9e+k6dD8wek9fSEh8U7SgWn3Y9
         cMKNDy7lu5Zu6IarlWw+aUo9vAT+I/aYUJ/kI+LRa3DZOw2fn1T8emIXi+Vdo9Twj9Yo
         kappk8Ny8E63YBwb4RAT+aJAnxjbw3pqkj2xNBVtrZxrBJgAtpJqavFkhwvwHTMtrOLl
         jYt6CSrnXzlk9U/P4IERjPTidx9nlA3ys+bPiQ9pIjGfpB4GFQsoQ/9MwsCgZ9jhP0HX
         3aszLnFhXb7/UTHVwAiWEj+GIwvgdjbs8m3gOEgEic7U+o63nxMQHY/hj65nTDcjavHS
         5ktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9l4pccApU6icRLlOza3B0ImHsVOwXrkyewWhbtE6M8=;
        b=MI3XB9i7g/ZjOD/sL4e2g8uhIoLaTZhhk4E0H+ebfakWtlKDuCSBasu3GOvu5U+Nq0
         HUnwEZ8DHm3Ckakhkein+PL34r3kDAM+YBTLJIPv5pMsvb8vrrlEHw0hPhQHhEc+Y2uS
         ArHnQhnmot8nlr8Gbjwy4oZMI+gwv9Hn0XcLKrHdNHKpK7RUwvltgKcoFmsJgchc5dmi
         4ivuzcaj7NxuPKlU6o9E5ZCG1HDzATjmc1wuve5NL92jSSxbTwPGpLSqmgJIxGU/g2ke
         CebYNwGt+yzczYd3umK66Ep5X13Uh5fdFB08fv6unmbgFA6pOOOIBPuMfVIO5WHcSVGO
         eexw==
X-Gm-Message-State: APjAAAVfWe5SvSx/6x7iaGbF+wzHGMfmjMgO5jauSQa7X7jSJPvlBtMQ
        2c+F0X87NAvd2wfsRIZ14EByd4Jf/Oq7aIrmdy4=
X-Google-Smtp-Source: APXvYqy2audXzA+YxzidLA6ObNy6ejjEuNrh3Hh1Vkla+z2riht/2+VeIe7+aEry1RV/NNRLNT8cWC9LmJK+Y062G5g=
X-Received: by 2002:a37:e408:: with SMTP id y8mr6013574qkf.39.1579633578497;
 Tue, 21 Jan 2020 11:06:18 -0800 (PST)
MIME-Version: 1.0
References: <20200121150431.GA240246@chrisdown.name>
In-Reply-To: <20200121150431.GA240246@chrisdown.name>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Jan 2020 11:06:07 -0800
Message-ID: <CAEf4BzZj4PEamHktYLHqHrau0_pkr_q-J85MPCzFbe7mtLQ_+Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: Always output invariant hit in pahole DWARF to
 BTF transform
To:     Chris Down <chris@chrisdown.name>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 21, 2020 at 7:05 AM Chris Down <chris@chrisdown.name> wrote:
>
> When trying to compile with CONFIG_DEBUG_INFO_BTF enabled, I got this
> error:
>
>     % make -s
>     Failed to generate BTF for vmlinux
>     Try to disable CONFIG_DEBUG_INFO_BTF
>     make[3]: *** [vmlinux] Error 1
>
> Compiling again without -s shows the true error (that pahole is
> missing), but since this is fatal, we should show the error
> unconditionally on stderr as well, not silence it using the `info`
> function. With this patch:
>
>     % make -s
>     BTF: .tmp_vmlinux.btf: pahole (pahole) is not available
>     Failed to generate BTF for vmlinux
>     Try to disable CONFIG_DEBUG_INFO_BTF
>     make[3]: *** [vmlinux] Error 1
>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: kernel-team@fb.com
> ---
>  scripts/link-vmlinux.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index c287ad9b3a67..c8e9f49903a0 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -108,13 +108,15 @@ gen_btf()
>         local bin_arch
>
>         if ! [ -x "$(command -v ${PAHOLE})" ]; then
> -               info "BTF" "${1}: pahole (${PAHOLE}) is not available"
> +               printf 'BTF: %s: pahole (%s) is not available\n' \
> +                       "${1}" "${PAHOLE}" >&2

any reason not to use echo instead of printf? would be more minimal change

>                 return 1
>         fi
>
>         pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
>         if [ "${pahole_ver}" -lt "113" ]; then
> -               info "BTF" "${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.13"
> +               printf 'BTF: %s: pahole version %s is too old, need at least v1.13\n' \
> +                       "${1}" "$(${PAHOLE} --version)" >&2
>                 return 1
>         fi
>
> --
> 2.25.0
>
