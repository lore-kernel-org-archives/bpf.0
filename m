Return-Path: <SRS0=+7Cc=BL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054FEC433E3
	for <bpf@archiver.kernel.org>; Sat,  1 Aug 2020 01:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28682072A
	for <bpf@archiver.kernel.org>; Sat,  1 Aug 2020 01:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHPJ8JTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgHABrw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 31 Jul 2020 21:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHABrv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 21:47:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5956C061756
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 18:47:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d190so9857885wmd.4
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 18:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJnx156cIb/ocnmEd5ytGaOA79Apq7RDxlvXJ4tSsU4=;
        b=uHPJ8JTDI5M2xkK0OfVUZ91EQVxWN9DazwFxWTFkpAifi13mVt9bCnKisGvl27mBUC
         OvFoO0m9UX7sogSIhzYAPwMYSPIjRGt5zHfRme+S+/umFocYOjjZ6tvedl0AcH+sOl3z
         aKk7Lf0PwIXr/0Ko9KpWw/xp/82CeFEHrKHDiBfuQFzXZa4aYximl0LKOPKR0rJ+N9mR
         sDdNIsAXRz4PBBWeb4t+bU7xX1+0g8pDHK7nwycuN+CjwIsvIKZV71mQYKII4BhjYrZ1
         Gm5IJPuhc7Hxx1eAmJvcYpBf9FSF3RLj/kkhrFfgu3pkBAKReMXgrG72QAixGcCBGWSz
         xIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJnx156cIb/ocnmEd5ytGaOA79Apq7RDxlvXJ4tSsU4=;
        b=lqZmXnB6J8tQa1bSUM0BBy64otZ3eY3tRlO9bIiZskHqVCgMAXATlWYJ4ip5pHhzJn
         dPVkYOWUk0wvwdm8RZaqyprvGQfmqJJCfNSNff7qDTObkVWeTKrcwqa3EUZltg6LOMKf
         1knkEhFwyLDhMeIcwvO/TicQhuNxSpPQ/kM9YivuqfJLKdBGBGHct6XOX1LfW1ZJL5nf
         UV5gfJ/SRpr4yJN1j8lOUxK+okicJV1Cc/lftfMcwnlP+egzKk6A0g7mdQ7YiwovqQzM
         pMguaaEhY5e8vUV64+/jNg1FXVO/2bq8az5aVYiwF8ohHzmQodEYra29OCeJAiHbnRg2
         ksLA==
X-Gm-Message-State: AOAM531FJSKjCa8GAx2+jRAOjaSw3T3gNUItOaW9CstrbJJb7feBAmbR
        Tqdu5m/dAqceEIwmLC62FjpVu6+76m3J1yeG0Qbpbg==
X-Google-Smtp-Source: ABdhPJxNN8XPrym2dtCX5BafY9kl52WklwSBrh4rLPbkpscRMCdHbrC3skywII6y3C2tPoKBJWnof6EfF9rGIng1dxQ=
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr5914617wme.58.1596246468111;
 Fri, 31 Jul 2020 18:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200722054314.2103880-1-irogers@google.com> <CAEf4BzaBYaFJ3eUinS9nHeykJ0xEbZpwLts33ZDp1PT=bkyjww@mail.gmail.com>
In-Reply-To: <CAEf4BzaBYaFJ3eUinS9nHeykJ0xEbZpwLts33ZDp1PT=bkyjww@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 31 Jul 2020 18:47:36 -0700
Message-ID: <CAP-5=fXMUWFs6YtQVuxjenCrOmKtKYCqZE3YofwdR=ArDYSwbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] bpftool btf: Add prefix option to dump C
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 21, 2020 at 11:58 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jul 21, 2020 at 10:44 PM Ian Rogers <irogers@google.com> wrote:
> >
> > When bpftool dumps types and enum members into a header file for
> > inclusion the names match those in the original source. If the same
> > header file needs to be included in the original source and the bpf
> > program, the names of structs, unions, typedefs and enum members will
> > have naming collisions.
>
> vmlinux.h is not really intended to be used from user-space, because
> it's incompatible with pretty much any other header that declares any
> type. Ideally we should make this better, but that might require some
> compiler support. We've been discussing with Yonghong extending Clang
> with a compile-time check for whether some type is defined or not,
> which would allow to guard every type and only declare it
> conditionally, if it's missing. But that's just an idea at this point.

Thanks Andrii! We're not looking at user-space code but the BPF code.
The prefix idea comes from a way to solve this problem in C++ with
namespaces:

namespace vmlinux {
#include "vmlinux.h"
}

As the BPF programs are C code then the prefix acts like the
namespace. It seems strange to need to extend the language.

> Regardless, vmlinux.h is also very much Clang-specific, and shouldn't
> work well with GCC. Could you elaborate on the specifics of the use
> case you have in mind? That could help me see what might be the right
> solution. Thanks!

So the use-case is similar to btf_iter.h:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/bpf_iter.h
To avoid collisions with somewhat cleaner macro or not games.

Prompted by your concern I was looking into changing bpf_iter.h to use
a prefix to show what the difference would be like. I also think that
there may be issues with our kernel and tool set up that may mean that
the prefix is unnecessary, if I fix something else. Anyway, to give an
example I needed to build the selftests but this is failing for me.
What I see is:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
$ cd bpf-next
$ make defconfig
$ cat >>.config <<EOF
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_BTF=y
EOF
$ make -j all
$ mkdir /tmp/selftests
$ make O=/tmp/selftests/ TARGETS=bpf kselftest
...
  CLANG    /tmp/selftests//kselftest/bpf/tools/build/bpftool/profiler.bpf.o
skeleton/profiler.bpf.c:18:21: error: invalid application of 'sizeof'
to an incomplete type 'struct bpf_perf_event_value'
        __uint(value_size, sizeof(struct bpf_perf_event_value));
                           ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Checking with bpftool the vmlinux lacks struct bpf_perf_event_value
but as this is unconditionally defined in bpf.h this seems wrong. Do
you have any suggestions and getting a working build?

> > To avoid these collisions an approach is to redeclare the header file
> > types and enum members, which leads to duplication and possible
> > inconsistencies. Another approach is to use preprocessor macros
> > to rename conflicting names, but this can be cumbersome if there are
> > many conflicts.
> >
> > This patch adds a prefix option for the dumped names. Use of this option
> > can avoid name conflicts and compile time errors.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-btf.rst |  7 ++++++-
> >  tools/bpf/bpftool/btf.c                       | 18 ++++++++++++++---
> >  tools/lib/bpf/btf.h                           |  1 +
> >  tools/lib/bpf/btf_dump.c                      | 20 +++++++++++++------
> >  4 files changed, 36 insertions(+), 10 deletions(-)
> >
>
> [...]
>
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index 491c7b41ffdc..fea4baab00bd 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -117,6 +117,7 @@ struct btf_dump;
> >
> >  struct btf_dump_opts {
> >         void *ctx;
> > +       const char *name_prefix;
> >  };
>
> BTW, we can't do that, this breaks ABI. btf_dump_opts were added
> before we understood the problem of backward/forward  compatibility of
> libbpf APIs, unfortunately.

This could be fixed by adding a "new" API for the parameter, which
would be unfortunate compared to just amending the existing API. There
may be solutions that are less duplicative.

Thanks,
Ian

> >
> >  typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index e1c344504cae..baf2b4d82e1e 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
>
> [...]
