Return-Path: <SRS0=dKsF=3G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B513C33C9E
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D736C20748
	for <bpf@archiver.kernel.org>; Fri, 17 Jan 2020 19:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMlV7tgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgAQTDe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:03:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38634 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgAQTDe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 14:03:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so23726722qki.5;
        Fri, 17 Jan 2020 11:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdM0UP+39dbV9emP4mHrL7R9dXzKhuSTU2cL9VQ2ROg=;
        b=lMlV7tgADkTyN1KyMJ9GrpGOXxJvXNlem4fqkkoGg989apTQA59buLHUuXD/peu1+J
         mmKwWfA+xwo2BKHaAKjex3UE6eamvF6IPIARlkQklTcjrnBKs88sYhHI+bX3dIIgWjPV
         xIYDsMBZ5FEoStHyPv5FC86CDxuu7kHxcfDqnWO30xIIImGu+wvyVP8lH22kU4R8BNg6
         weyc0jmL1FRU73EJqGGyqkUGXy5DAnuit5HpRTBEOxN0AHg5kn2YvGLiBNDoVzNZWRCe
         fTBMZ66p3UgHi40RtLdErVMucuX9qEzZ5dxzP8ilGV/7PgNYkWso8M6GsCHBXsmpAjT7
         8NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdM0UP+39dbV9emP4mHrL7R9dXzKhuSTU2cL9VQ2ROg=;
        b=ZMZkTDTxgoSP9KxJbvlKKPahh/ZSWUujFV4mlrQcpdohoQ+RWpsUII976wI2r9eFvA
         hEWv25LNBERdeRxH9ckV0Xltvyw3iENjSHnHOzFocFLTN0+3kLFyTWXNJKIvXCqz8Z0R
         Br/s6k/zjNbtM/ei5Wm7eNnuhDghMTkwNGZHo0CTpQJmEQvIHRGgKyVLcXwtCub+j8SC
         kIhzXkWf3pW0rdHsemBx53XnMFQHw/A16jNPsSzTWrLXqtFU4MCkxKr0m9zyEsUeHTpW
         DHq7k59p3tWZ5CQghraxIrr6y4JNnIps9zpFzSiuy/EPAP+yvVq/hEVoS4H69cGHdQdX
         uzaQ==
X-Gm-Message-State: APjAAAXFfTAOq/xzjhVjLnwzoyk6YeCBhnP6MlYDHBm+9pjVlLRYMlKh
        A12jyVdM2Nv+HH86+gozxGeYimhrXQ1611sC+30=
X-Google-Smtp-Source: APXvYqziRA6aUMN7QP0bfKR/3GnvYM7RIzXmVMmLvaqtZLCbdhiOUmYtqB0BNBO7MBm0taWrkwQGupFfQ7eJ2yewFck=
X-Received: by 2002:a37:e408:: with SMTP id y8mr39639242qkf.39.1579287813154;
 Fri, 17 Jan 2020 11:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20200117060801.1311525-1-andriin@fb.com> <20200117060801.1311525-5-andriin@fb.com>
 <a1f6c13d-775c-6e48-6102-27332b5366a1@netronome.com>
In-Reply-To: <a1f6c13d-775c-6e48-6102-27332b5366a1@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Jan 2020 11:03:22 -0800
Message-ID: <CAEf4BzYzxv3q2G_MoOZ8PwjhgdRjZW2GPDknfqZ6aUzrL=6YVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpftool: avoid const discard compilation warning
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 17, 2020 at 7:55 AM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2020-01-16 22:08 UTC-0800 ~ Andrii Nakryiko <andriin@fb.com>
> > Avoid compilation warning in bpftool when assigning disassembler_options by
> > casting explicitly to non-const pointer.
> >
> > Fixes: 3ddeac6705ab ("tools: bpftool: use 4 context mode for the NFP disasm")
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  tools/bpf/bpftool/jit_disasm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> > index bfed711258ce..22ef85b0f86c 100644
> > --- a/tools/bpf/bpftool/jit_disasm.c
> > +++ b/tools/bpf/bpftool/jit_disasm.c
> > @@ -119,7 +119,7 @@ void disasm_print_insn(unsigned char *image, ssize_t len, int opcodes,
> >       info.arch = bfd_get_arch(bfdf);
> >       info.mach = bfd_get_mach(bfdf);
> >       if (disassembler_options)
> > -             info.disassembler_options = disassembler_options;
> > +             info.disassembler_options = (char *)disassembler_options;
> >       info.buffer = image;
> >       info.buffer_length = len;
> >
> >
>
> Thanks Andrii,
>
> This fix has been proposed and discussed before:
> https://lore.kernel.org/bpf/20190328141652.wssqboyekxmp6tkw@yubo-2/t/#u
>
> I still believe that we should not add the cast.

Oh, ok, didn't know that. Seems like Alexei dropped it already.

>
> Best regards,
> Quentin
