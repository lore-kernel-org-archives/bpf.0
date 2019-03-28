Return-Path: <SRS0=idkB=R7=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC69C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A1F20823
	for <bpf@archiver.kernel.org>; Thu, 28 Mar 2019 16:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTjc97/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfC1QAl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:00:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35844 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfC1QAl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Mar 2019 12:00:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id t206so16147294oib.3;
        Thu, 28 Mar 2019 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQr/r0q5vndvVzjmbd5cAnmJti91jyQI5WXEhITNxK8=;
        b=PTjc97/vfMeRCNYFSfUo2R1WiUXnTkm6C9fZ7rwAxP6KL8hgDWEm3PJSpPNI5jcm3n
         NJe0W2UkscKyWXKSkXDdC6ZLXN+qxksHX8LLchsBHcjwNoSilafuBvtwIY6wTpH7ETQD
         O0I2gbELv7Z952JRo2MJo11NE1cAzsj2Lz9eGiB409H/oy30uxELnUXGEkhOCLKTo234
         CuveZVeq6SMdZsHICZ9Wg951hv/MNKox5B/hMpChPbHKdWWeXP+oNnS3iZgNZJCCPJ7g
         w67hzz6D86oKKBasC6mcBgJv6lP5IH9WOchZ2nLNwKFM/ONbQ0REEpzeVQgL4SufbAhF
         I+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQr/r0q5vndvVzjmbd5cAnmJti91jyQI5WXEhITNxK8=;
        b=f6R73Ae2NqRragmnKdHOvCT0O/gqBwhLtY1D3H0i4DdMVjrQouECBm1HKratPYPz3r
         BmAgRfVbIGHGXWt3SCDQEST+71Y6jXgWHvU5PGjc9S21plIZ0rtDfr0VqLKGvlXW0HQw
         bwBu54mCbAo+CtnFdO5LhgzxL7v29GfhWb6ktG94B4kXrK82cTELWmy54A61REZPxwnT
         bFchKDo3KRbcPYgn2TmHJoSdmpGptMJRPbJGTXVdg7Nyi1RgOEzJPOVv6H8VGoxLO9Hq
         DgXIW7P7l4p9KueB7NZEknwROmKM1sXAeanhgATuS1d/H7sOlyDufPdE03CchnZe/qeD
         bzMw==
X-Gm-Message-State: APjAAAW8SuWJt+JJIc3Ucw9q/kEo3Yi1nSQHF7FsrvESVbGobOQnAqkg
        0GL3Sn/hzkDiiV0NPSf+MazuEcf02O5BMI6EWytXKw==
X-Google-Smtp-Source: APXvYqxPTB5NOMHBfy5KvScLrXqrIh47qkYgytTe0G6k3i87vH/kAprSkkHga0A9TheiJjhnYhiaVff7p9Qiz49vdh4=
X-Received: by 2002:aca:3254:: with SMTP id y81mr504569oiy.45.1553788840490;
 Thu, 28 Mar 2019 09:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <9c98d4498ec2209a879b04a8f9385b70e28e2114.1553788223.git.daniel@iogearbox.net>
In-Reply-To: <9c98d4498ec2209a879b04a8f9385b70e28e2114.1553788223.git.daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Mar 2019 09:00:29 -0700
Message-ID: <CAEf4BzZ+iQhqdpz33HF3mA95x8+cokmqfL6peGZeicb=HtaWyQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, libbpf: fix quiet install_headers
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 28, 2019 at 8:54 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Both btf.h and xsk.h headers are not installed quietly due to
> missing '\' for the call to QUIET_INSTALL. Lets fix it.
>
> Before:
>
>   # make install_headers
>     INSTALL  headers
>   if [ ! -d '''/usr/local/include/bpf' ]; then install -d -m 755 '''/usr/local/include/bpf'; fi; install btf.h -m 644 '''/usr/local/include/bpf';
>   if [ ! -d '''/usr/local/include/bpf' ]; then install -d -m 755 '''/usr/local/include/bpf'; fi; install xsk.h -m 644 '''/usr/local/include/bpf';
>   # ls /usr/local/include/bpf/
>   bpf.h  btf.h  libbpf.h  xsk.h
>
> After:
>
>   # make install_headers
>     INSTALL  headers
>   # ls /usr/local/include/bpf/
>   bpf.h  btf.h  libbpf.h  xsk.h
>
> Fixes: a493f5f9d8c2 ("libbpf: Install btf.h with libbpf")
> Fixes: 379e2014c95b ("libbpf: add xsk.h to install_headers target")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 7beec4d..8e7c56e 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -220,8 +220,8 @@ install_lib: all_cmd
>  install_headers:
>         $(call QUIET_INSTALL, headers) \
>                 $(call do_install,bpf.h,$(prefix)/include/bpf,644); \
> -               $(call do_install,libbpf.h,$(prefix)/include/bpf,644);
> -               $(call do_install,btf.h,$(prefix)/include/bpf,644);
> +               $(call do_install,libbpf.h,$(prefix)/include/bpf,644); \
> +               $(call do_install,btf.h,$(prefix)/include/bpf,644); \
>                 $(call do_install,xsk.h,$(prefix)/include/bpf,644);
>
>  install: install_lib
> --
> 2.9.5
>
