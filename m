Return-Path: <SRS0=ZyRU=QW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D2CC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E518A21924
	for <bpf@archiver.kernel.org>; Fri, 15 Feb 2019 16:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrxYFLlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBOQRd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:17:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33187 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBOQRd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Feb 2019 11:17:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id q12so7638858lfm.0;
        Fri, 15 Feb 2019 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLj7bMrMeqPO+LuN6jh2KGuOQZ1RDzQL39lnVFJNKWg=;
        b=MrxYFLlmL+3oEUKZpOmVdzyB1dAZYCDhjswHwEDgJGWEIIiivSGawC3+zVcRAouFqG
         oTvPNRJ2W4RApzt76aSHFSz8Ii/xdD9jki/FgHwj0axkiszjjro1JAfDmfE/YiG5QLtd
         Ggoh6vX8k7ODp9FhHbDR2hxg/KDIHUuaqhJofo4eAIs6sGPF1VAw/MhFrvP/IuKVXaxG
         FLvphB7DCcZ3DkJZEJ/B0EmW8yy8BPX8th1v9YtVGnCjO2TgwxWe8xSkNZ6TEihWkJu/
         2iv9cywdYh1T8ZXcqrsA3gfz6nnZBHB00OsylOMXhAcapeJjJdALdwnO+VvE4srt6AGu
         NGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLj7bMrMeqPO+LuN6jh2KGuOQZ1RDzQL39lnVFJNKWg=;
        b=jOEHHj5/2Jrsm2JmTfD3Mjmu2/2yCo0UjXR1ftrXTt6eW2wT/obQxiCpWHVb5Hrt/A
         +ZiCFY7juQQ8Au/07XeP3gfg2c16npQ1kHtnS74SuqQAF3AhyptxWe1McJWDWTSqnpu/
         nfxUGSzwaT2KF62kcXaMqEwOKlrP6NZzE/mBayAwsAmmNWLnc/tM9tg7kq3Lq5HVH106
         fOgtRXFCPoRLAZyQd7b8XFMXnXrINlY/ezKgyE6UJAyyUaM6B+ionJomg5KgN2BBBvNQ
         Z7XEvZA6V4GdvW78FznKfJBFVK1TkWRpjy/+26eFVM5l3HiPeQbfV2E0yW34F3L0jbIm
         IYCA==
X-Gm-Message-State: AHQUAuZ7jKb2nUH68p5dS+14KguPM0zuavhPOhG09q81ALpy01TEryRN
        wMthqvjez0L4PHKWxWdpIBZKmc4nsHx4C47M/kE=
X-Google-Smtp-Source: AHgI3IZUsXF41GA8Nqa54bCGCgRGed6qh9SbPHBtdc0z5yywRNWx+nF6uOmv6p7rUFpUWac+gYV1aIgcoFGrKs6z0kc=
X-Received: by 2002:ac2:4343:: with SMTP id o3mr5449955lfl.129.1550247450827;
 Fri, 15 Feb 2019 08:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20190212004729.535-1-joe@wand.net.nz> <20190212004729.535-3-joe@wand.net.nz>
 <CAH3MdRVU5ayEm6eb9Fz53Q5gjA60vadyJ+0_meCkWBo+t+XXYA@mail.gmail.com>
In-Reply-To: <CAH3MdRVU5ayEm6eb9Fz53Q5gjA60vadyJ+0_meCkWBo+t+XXYA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 15 Feb 2019 08:17:18 -0800
Message-ID: <CAADnVQJ5RLwhHXWQzYywX3pQJMGXr=+eHuSY4twRCa+4_w5bpg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: Support 32-bit static data loads
To:     Y Song <ys114321@gmail.com>
Cc:     Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 14, 2019 at 9:38 PM Y Song <ys114321@gmail.com> wrote:
>
> On Mon, Feb 11, 2019 at 4:48 PM Joe Stringer <joe@wand.net.nz> wrote:
> >
> > Support loads of static 32-bit data when BPF writers make use of
> > convenience macros for accessing static global data variables. A later
> > patch in this series will demonstrate its usage in a selftest.
> >
> > As of LLVM-7, this technique only works with 32-bit data, as LLVM will
> > complain if this technique is attempted with data of other sizes:
> >
> >     LLVM ERROR: Unsupported relocation: try to compile with -O2 or above,
> >     or check your static variable usage
>
> A little bit clarification from compiler side.
> The above compiler error is to prevent people use static variables since current
> kernel/libbpf does not handle this. The compiler only warns if .bss or
> .data section
> has more than one definitions. The first definition always has section offset 0
> and the compiler did not warn.

ahh. missed that while playing with .s output.
when target is asm clang doesn't complain.
let's relax this llvm error.
will set of existing relocation be enough to generate
properly formed .o ?
or we need to define a new one?
