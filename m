Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24CDECAAA0
	for <bpf@archiver.kernel.org>; Thu, 25 Aug 2022 20:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbiHYU2c (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Aug 2022 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbiHYU2S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 16:28:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749065839;
        Thu, 25 Aug 2022 13:27:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v14so5191028ejf.9;
        Thu, 25 Aug 2022 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=adXeMAqrdZFFCHGRW4ZrYNTwe8MV97cHNOLtkyOs6EU=;
        b=l5kivjE0h3XoUlY7SvzjG0YIOLa1TWG4HJ6tD1gMB+eK/qYHFL14CmPxJsT3of3i2K
         tpRg+9J0YxFu8WNb1uPRhDZql4XgrVUoJsuIJoRelImNhUY2gpZe88Pzp4wyqMpZu7Pr
         pS8rbDewmJdX7H3kamDg4vPb9sTmX4R4P1/bN/7XqN2HNZ+nBPhoh5qoajQ06Vd4/rKW
         2/oJFJrhuVn+/xLTu5gliICAK+ir+oStb1iPLNUNAm8WgaYelqg+568OeLmEO7/LquH6
         IzM+m6qjSFnp0yRfPfe1g54IKT8quqhrfjvJcuooyzi2nWrivaZOAst8+aOup2NVSKb6
         J0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=adXeMAqrdZFFCHGRW4ZrYNTwe8MV97cHNOLtkyOs6EU=;
        b=rjZrfRVoiKfMAs2xu3lUMwpkTdZpfNLz5nYKYOK3ZY82Yn14Kej4ksiTPYmwfX5XR2
         PvTbxpj89P1/k9kNzAflFeVa9W4OdwSMqsR1MDmpPRQ+8kdgBxQCy6qQ3S9qclvo0E6f
         hViyglwVyWhgUgTDSbFf5yk1XfoEAQk79g6bZMGJSPTb0TjR8fE3CXffoCyVBfZMo6d5
         1aLMOVLpTY45i1bkrmkhNF0hDl88E2PdCZAVPRzRJ/tI0y6KpuqtarNEzOcRvt/7Dgk3
         G+YFzJAOmmP/KpbiGjWU+i4vNjLGZJ6yuSdR52TrTWlAAyerKXfLQaDSakhXv3jlI2Ui
         fWXQ==
X-Gm-Message-State: ACgBeo0DdUM0siXpAHA0U77tORM8FVhtwhwNU35xCMRGv6NLZ0oqU/d3
        Sr5Jvn0anVrRsa4i8jP+LG8YnIhJSRkUHu+UxXI=
X-Google-Smtp-Source: AA6agR5gheunS7Kl9cvfMlq4wH8EV38+5zhYf/V2Lq3mkl3vH67KiAEZ4L30JHEiSJQbGAhOZva++8jW+jRVIou1cws=
X-Received: by 2002:a17:906:8a43:b0:73d:7cc2:245e with SMTP id
 gx3-20020a1709068a4300b0073d7cc2245emr3535868ejc.114.1661459216870; Thu, 25
 Aug 2022 13:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <1661349907-57222-1-git-send-email-chentao.kernel@linux.alibaba.com>
In-Reply-To: <1661349907-57222-1-git-send-email-chentao.kernel@linux.alibaba.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 13:26:45 -0700
Message-ID: <CAEf4BzZPYAZ-ZJXa0CnrpxzFrXjTScfuioF=DOAw4j1L_tMXTg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Support raw btf placed in the default path
To:     "chentao.ct" <chentao.kernel@linux.alibaba.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 7:05 AM chentao.ct
<chentao.kernel@linux.alibaba.com> wrote:
>
> Now only elf btf can be placed in the default path, raw btf should
> also can be there.
>

It's not clear what you are trying to achieve. Do you want libbpf to
attempt to load /boot/vmlinux-%1$s as raw BTF as well (so you can sort
of sneak in pregenerated BTF), or what exactly?
btf__load_vmlinux_btf() code already supports loading raw BTF, it just
needs to be explicitly specified in locations table.

So with your change locations[i].raw_btf check doesn't make sense and
we need to clean this up.

But first, let's discuss the use case, instead of your specific solution.


> Signed-off-by: chentao.ct <chentao.kernel@linux.alibaba.com>
> ---
>  tools/lib/bpf/btf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index bb1e06e..b22b5b3 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4661,7 +4661,7 @@ struct btf *btf__load_vmlinux_btf(void)
>         } locations[] = {
>                 /* try canonical vmlinux BTF through sysfs first */
>                 { "/sys/kernel/btf/vmlinux", true /* raw BTF */ },
> -               /* fall back to trying to find vmlinux ELF on disk otherwise */
> +               /* fall back to trying to find vmlinux RAW/ELF on disk otherwise */
>                 { "/boot/vmlinux-%1$s" },
>                 { "/lib/modules/%1$s/vmlinux-%1$s" },
>                 { "/lib/modules/%1$s/build/vmlinux" },
> @@ -4686,7 +4686,7 @@ struct btf *btf__load_vmlinux_btf(void)
>                 if (locations[i].raw_btf)
>                         btf = btf__parse_raw(path);
>                 else
> -                       btf = btf__parse_elf(path, NULL);
> +                       btf = btf__parse(path, NULL);
>                 err = libbpf_get_error(btf);
>                 pr_debug("loading kernel BTF '%s': %d\n", path, err);
>                 if (err)
> --
> 2.2.1
>
