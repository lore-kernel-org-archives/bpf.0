Return-Path: <SRS0=Z2SS=YA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB429ECE58C
	for <bpf@archiver.kernel.org>; Mon,  7 Oct 2019 20:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F3E20835
	for <bpf@archiver.kernel.org>; Mon,  7 Oct 2019 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH5qje+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfJGUsr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:48:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35470 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfJGUsr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Oct 2019 16:48:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so10260756lfl.2;
        Mon, 07 Oct 2019 13:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJA9g2wzczIi07Y3G67IfbEUpDDFU5O873LDD0k5C+A=;
        b=RH5qje+ctaEpAwa/G9MXjmLlVPeIj8PnZ+krO0UJa1E6MUCAY0L6sQH+udN4MlfB+1
         92iukPvLZOkh3sBwBstCP2/uvqN3LznRlbW5YiAXVOjmHKzXfSzGw3bbyk9h6MT+memd
         FJfGsgN+xHzndH+rYkKuSWRK2IMtDfWGw6WG2DVr1BoXBDKxVbX3SFloAomRtzZ79Vzq
         1LV7ft/MGnkBDWX0s0sUO3Uv44QQ2Xw1pLvHUxDup/OAqrZ7vIuMmEeTb6tL5dMFX10t
         H5E5OI3poHsfXuc8RIPYvpDxIQLXh6JqLl+P8/5oiKQRYEWDYyquY0JWXY6zQiS23+iq
         TeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJA9g2wzczIi07Y3G67IfbEUpDDFU5O873LDD0k5C+A=;
        b=Q90GLj0mtba+Vt8Vf2mZf3jgK7Ir498f9x/PMHRQvdkgOsyR7YC9XHEGv+kKt+99FJ
         IU0KecKafVgz3ShODKY88JeDzxkduv9F37hWDcUEblojaBkiWFm+tSPDOSJvwqVL/KB5
         x0PMGin30Jh62rEhMRlCoUxpyMuyAWKAPSvLE2xZ7u9faYnzVEv3PSe6pWigWAvT/23d
         Y06N2nUZHzjEPTY3/X6HB+J5YGJGovzVB5jkw8KkN/v/R11wVNdUufLv0JjTq6zSD6m/
         sMnUWP2eYVJ7iPGu8vDh2X+iBlwcWhoRukgk6iuurJKDWVfsZ0JG5ijbqrY1vRNDcv5Q
         z2hA==
X-Gm-Message-State: APjAAAVLotehzKSileGr4/0pXB6nXROg557cuiUzB7kOyare8fZBZGCb
        gfOVCxx6ab+WlcQt9M5wKStycJ1/h4nx0k+fkcU=
X-Google-Smtp-Source: APXvYqzEmUSnUoVCTMQrqdJbpz99filYHH/aWWeA6ULhSkQMdK/cwdWIlm7Mp7rL6+uZA8x7GWhU5HqYgvOp4yXs4Gw=
X-Received: by 2002:a19:6455:: with SMTP id b21mr18204694lfj.167.1570481325021;
 Mon, 07 Oct 2019 13:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191007204149.1575990-1-andriin@fb.com>
In-Reply-To: <20191007204149.1575990-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Oct 2019 13:48:33 -0700
Message-ID: <CAADnVQJOv_xZT=paCTRbQ8hd2rh3taYo_1ZrhtNYd7FqptjVzQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: fix dependency ordering for
 attach_probe test
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 7, 2019 at 1:42 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Current Makefile dependency chain is not strict enough and allows
> test_attach_probe.o to be built before test_progs's
> prog_test/attach_probe.o is built, which leads to assembler complaining
> about missing included binary.
>
> This patch is a minimal fix to fix this issue by enforcing that
> test_attach_probe.o (BPF object file) is built before
> prog_tests/attach_probe.c is attempted to be compiled.
>
> Fixes: 928ca75e59d7 ("selftests/bpf: switch tests to new bpf_object__open_{file, mem}() APIs")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

This time the fix is actually fixing the build in my setup.
Thanks. Applied.
