Return-Path: <SRS0=ch4g=U3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95278C4321A
	for <bpf@archiver.kernel.org>; Fri, 28 Jun 2019 20:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B60620828
	for <bpf@archiver.kernel.org>; Fri, 28 Jun 2019 20:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvIEw/Eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfF1UgG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:36:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45309 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfF1UgF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 16:36:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so6010923qkj.12
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 13:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=96lpywtnOXjnb9Ke6M8Ym7JfRzLHR7gQkllmjWRm69g=;
        b=VvIEw/EoIVLrZHvcFr1Ga9xXmT/EDapk6/nHqvV1pxpzeChlCMUHIyPtwQFH+O3JR/
         hWFwjyIber+b5Fc+swdvLvFw+9ICAXbc3vdlfeX0FVeuniWufQKVidj60c04G0T+QmLr
         zO+/F2SF/+2CT8hOTU9+A/I3dThakMd7bzLhUtBXys+ylsty+Pq2oIyWWsvUqKcjdj3c
         b5sWPBwcd6x6xs7e3U7/eDzJm/4HU05TbRUt6+PnAppvtTE8MEkoX2pkp0afroHGUKQB
         en5sTmswYupvLMumdbHlKGRxGcCXJ9XP6UXsJtMVucB2chR1nL67GXEDnoBUz+LgCc9K
         9Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=96lpywtnOXjnb9Ke6M8Ym7JfRzLHR7gQkllmjWRm69g=;
        b=CiUKK6ZyJXPqtJHiUqdkDzg1htvV/h3H/BUAgoCA7QjyXYM+s04p5+w7ZnPE3Tn440
         5BUA2lMjeODMJ1peyKUX7FP+ZMdB8ibwQh6keCfWEfdhP3ZJCOfS1/e3qr4wlnIb8sw5
         X9onLMk1lPAgjjxuQetK9EmVNUhQ0Rb1aw7FPhxBBDPLkoy5qy9PAK2lyRNXMBm80Kif
         VeU4oyIaq9vyhzCxwS6oE3WmHwi9WrdNUoBiWsx1rTUJDiqhkZvxjHDWp9Yere4rG+Pu
         dCOd5/bCLFLAJzLsEqBCrJHiPRdslxxNzeDxEAzgT3E5OCAi8T9tNobAJwhgWKhxNTKv
         i8Lw==
X-Gm-Message-State: APjAAAW7fAN32We8WvBUgjm58HlNHOAmUY32QJfH8QArOb8b0K1dWna6
        0jFsjVLYIDWic7gU9vdU2Wm4BmpMWHWKtHDONXajHg==
X-Google-Smtp-Source: APXvYqxrvFeWwCu9tMwW++tPVB7hVyWPcmms0zPDBrapfqNh6qpCXmUJqbwZDdxWne44xgJFK2aFdKR6r1QQWp2pXKM=
X-Received: by 2002:a37:5cc3:: with SMTP id q186mr10311342qkb.74.1561754165042;
 Fri, 28 Jun 2019 13:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190627091450.78550-1-iii@linux.ibm.com>
In-Reply-To: <20190627091450.78550-1-iii@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Fri, 28 Jun 2019 13:35:54 -0700
Message-ID: <CAPhsuW5ToikpcEbJjC+JsxWSjgUBHKS97=hiTmt1EHmC9HFb8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: do not ignore clang failures
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 27, 2019 at 2:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> When compiling an eBPF prog fails, make still returns 0, because
> failing clang command's output is piped to llc and therefore its
> exit status is ignored.
>
> This patch uses bash's pipefail option to fail the build when clang
> fails, and also make's .DELETE_ON_ERROR target to get rid of partial
> BPF bytecode files.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index f2dbe2043067..2316fa2d5b3b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +SHELL := /bin/bash

I am not sure whether it is ok to require bash. I don't see such requirements in
other Makefile's under tools/.

Can we enable some fall back when bash is not present?

Thanks,
Song
