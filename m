Return-Path: <SRS0=lXkO=26=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A43AC33CA2
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 22:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54732073A
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 22:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWyBkgt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgAIWfv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:35:51 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36892 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgAIWfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 17:35:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so263347qtk.4;
        Thu, 09 Jan 2020 14:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFEDF9fNYtbwEo0RQ5gK4Dnv2xdq/FTuRFEt1FS2wJ0=;
        b=CWyBkgt3hSawwcTavfAVyuJ1rfFMm0jdIEoNIuOe2NqyM9xCTB0OJitVm5HG1Z9g21
         xdHwy1BL0Fq2fbn8x7uNJWLCHOGYuQoTqH1ob2DNp1N8/Gxa0oUYL9MzEFRyr11yuuMl
         EGvH9Xvhur84mbUAsmX2P+s19ESklnHA/V3YndC8auWpitkdfFIkFjeBhQYVqG1Lhhm0
         OeSxFYR/OW3LUQMMVbaspBNv7PwC08dcIeMVgJz003YWk/3HxPvgNN07P0i6vWjDk4Ym
         L4cjkXQmrdgaJWW1ADRe8FjcacWBzp5G7+z2/qJpHT+genrqDYcKao2hTEO3kQw9cWHe
         mITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFEDF9fNYtbwEo0RQ5gK4Dnv2xdq/FTuRFEt1FS2wJ0=;
        b=G9f/i1rqkPdC7m2dccIM7FreTH8jOm4xE+tSR/DP9vcCZosU4zt+4cFlY+5z9BIGg2
         u8MoDbVy/2H74fDYLwhJNMmHaeCAXdFcjCfIt2jRoCu0O/i5qCdw+Xl8jLahzcJeg/9J
         sPlBXJUFtne8lGUbM8xeAQNPy5CElACFaXzFSvRCC5QUHKzRq9pPzuZTo8r6ohpm46pE
         uowG02uo5NpQgwfb7PxlyCrg96DrcTxNAppkZ8kd589WIod7qCDO2/KxYgtxaJebDkRV
         26oM2MNXJea4xMOzg4m1gXSy6Q+IrPAgkO+dNcO6SCHOg/YLbHFS6rbbvbJabCIiPt+E
         xGMw==
X-Gm-Message-State: APjAAAViZFmGms/d9CXGVSDzAP2ZwnzXNRwbGvD+H6s1M7JQVvLYHkDr
        pnxBa71w/bVnujmLo6IwrE39kt0WIZ2wqCeZZ7Y=
X-Google-Smtp-Source: APXvYqzS7b1xmCfeA/UBm3rodaozEM0efpQ+TyqJH6cjwf7GVNVKkQmh8LDnnDwPi0vnGgxojEwkCeI5UtNtThX6Z2E=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr9724038qtl.171.1578609350666;
 Thu, 09 Jan 2020 14:35:50 -0800 (PST)
MIME-Version: 1.0
References: <20191226211855.3190765-1-andriin@fb.com> <20200109184820.mvgtxql7435bhzx3@ast-mbp>
In-Reply-To: <20200109184820.mvgtxql7435bhzx3@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Jan 2020 14:35:39 -0800
Message-ID: <CAEf4BzZsZ1hs-DG5WJ144hRoqFD_yLeKghV-FkboJ6B1_UJQxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add BPF_HANDLER, BPF_KPROBE, and
 BPF_KRETPROBE macros
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Martin Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 9, 2020 at 10:48 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 26, 2019 at 01:18:55PM -0800, Andrii Nakryiko wrote:
> > Streamline BPF_TRACE_x macro by moving out return type and section attribute
> > definition out of macro itself. That makes those function look in source code
> > similar to other BPF programs. Additionally, simplify its usage by determining
> > number of arguments automatically (so just single BPF_TRACE vs a family of
> > BPF_TRACE_1, BPF_TRACE_2, etc). Also, allow more natural function argument
> > syntax without commas inbetween argument type and name.
> >
> > Given this helper is useful not only for tracing tp_btf/fenty/fexit programs,
> > but could be used for LSM programs and others following the same pattern,
> > rename BPF_TRACE macro into more generic BPF_HANDLER. Existing BPF_TRACE_x
> > usages in selftests are converted to new BPF_HANDLER macro.
> >
> > Following the same pattern, define BPF_KPROBE and BPF_KRETPROBE macros for
> > nicer usage of kprobe/kretprobe arguments, respectively. BPF_KRETPROBE, adopts
> > same convention used by fexit programs, that last defined argument is probed
> > function's return result.
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ...
> > +
> > +#define BPF_HANDLER(name, args...)                                       \
> > +name(unsigned long long *ctx);                                                   \
> > +static __always_inline typeof(name(0)) ____##name(args);                 \
> > +typeof(name(0)) name(unsigned long long *ctx)                                    \
> > +{                                                                        \
> > +     _Pragma("GCC diagnostic push")                                      \
> > +     _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")              \
> > +     return ____##name(___bpf_ctx_cast(args));                           \
> > +     _Pragma("GCC diagnostic pop")                                       \
>
> It says "GCC ..", but does it actually work with gcc?
> If the answer is no, I think it's still ok, but would be good to document.

I'll write a simple test program to verify. I expect it to work, of course :)

>
> Other than the above BPF_HANDLER, BPF_KPROBE, BPF_KRETPROBE distinction make sense.
> Please document it. It's not obvious when to use each one.

Yep, will do.

>
> Also the intent is do let users do s/BPF_KRETPROBE/BPF_HANDLER/ conversion
> when they transition from kretprobe to fexit without changing anything else
> in the function body and function declaration? That's neat if that can work.

Yep, it should be a trivial s/BPF_KPROBE/BPF_HANDLER/ change.
