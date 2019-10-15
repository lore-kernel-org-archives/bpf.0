Return-Path: <SRS0=zD4z=YI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14381C10F14
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 16:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D860E20872
	for <bpf@archiver.kernel.org>; Tue, 15 Oct 2019 16:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQJEW2la"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfJOQWt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:22:49 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:36655 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfJOQWt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 12:22:49 -0400
Received: by mail-qt1-f180.google.com with SMTP id o12so31441678qtf.3;
        Tue, 15 Oct 2019 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iddr0FKoPOEPm9BynpBCTguodRMFh274qlurBhFXN5w=;
        b=oQJEW2laLowiKpwk+IiKpsJJmdjaxGxmby4xDbZVS+KqENDZthmkLNZJfO0uYeh9Za
         KA/mfqSfdOObDfR3THW09S+XYmB/wNgkXJFI0MblQ8KdQvC6Kq453GBW+41YOtMr1A8Q
         3YhOlNRopmMP4B+1N2UQI4vIHIUbAGBrM/jD7Ic87pPoRxR6B0V9xIiFNgSRCVHRMc5+
         psdBa3YSgY/rxezRHeo8xtgpqIbhWoa4bmDuX8LfDxKJA8vYrMBW7iVQKYCbn1HQ2CSW
         3U4kuKu7t9RMMFXWGwWKuJEXEeQmuuSBZaJt5uHTaDXb319440L5DiQYGAK1GRljbsUG
         KPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iddr0FKoPOEPm9BynpBCTguodRMFh274qlurBhFXN5w=;
        b=oerRNc4p+oHDdEjgBHhcUZwfMI0xQgu+Ly4QXfBaYtL3ZsZxeeOoucI5Q0aSgmEaVI
         SvELtq5RQPzP4ShITt9ZbIJqCtU2OkOkG5FoDZglQ7jTnD49OssbEX7w6c7VfeJy140z
         zWa6H9AIGXjTzVSYr6lobm6RGyfs5cFsKhq0Yd//a1PX3tPzBNx208bi8qaI0a9vCiDC
         S6zgmiYEqUnMVnkcMbMntDMNU3EDg/w3K6zb7KdDrCFWktBJZBU5DWjGVnzCBArKIllk
         /NvxBQqgN0h7a69f9146AmKVxp2mJuySUPdWEPFMQwhIKEs7lN5al/hdA62IrvoBg3Iy
         kvcA==
X-Gm-Message-State: APjAAAWZkIlWHRZuNHT5mOrd6HBBp+Wu/ETfTNt26N4QSVp6SUdLdEe9
        Q0/lw4lBXTnYFkVh3znvBECT/5w1DZgzacN9kuU=
X-Google-Smtp-Source: APXvYqy2EoQUp3knE5L8RWfwGKnub3zMUUl1fazbwjPQI2ZQZthRNAOfP2kWdviDYp4kfwcBN4ihRo+ibwWLYjpf2Vk=
X-Received: by 2002:ac8:379d:: with SMTP id d29mr37654157qtc.93.1571156566754;
 Tue, 15 Oct 2019 09:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191015130117.32292-1-jolsa@kernel.org>
In-Reply-To: <20191015130117.32292-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Oct 2019 09:22:35 -0700
Message-ID: <CAEf4BzYdJ-hPHVehZriS_synLWtgad9wx_eoN6-JDBUUHFjfgQ@mail.gmail.com>
Subject: Re: [RFC] libbpf: Allow to emit all dependent definitions
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 15, 2019 at 6:03 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently the bpf dumper does not emit definitions
> of pointers to structs. It only emits forward type
> declarations.
>
> Having 2 structs like:
>
>    struct B {
>      int b;
>    };
>
>    struct A {
>      struct B *ptr;
>    };
>
> the call to btf_dump__dump_type(id = struct A) dumps:
>
>    struct B;
>    struct A {
>      struct B *ptr;
>    };
>
> It'd ease up bpftrace code if we could dump definitions
> of all dependent types, like:
>
>    struct B {
>      int b;
>    };
>    struct A {
>      struct B *ptr;
>    };
>
> So we could dereference all the pointers easily, instead
> of searching for each access member's type and dumping it
> separately.
>
> Adding struct btf_dump_opts::emit_all to do that.
>

Hey Jiri,

Yeah, Daniel Xu mentioned that this would be useful. I haven't thought
this through very well yet, but I suspect that this simple change
might not be enough to make this work. There are cases where you are
not yet allowed to emit definition and have to emit
forward-declaration first. I suggest trying to use this on vmlinux BTF
and see if resulting header files still compiles with both Clang and
GCC. Do you mind checking?

But also, as we learned over last few months, just adding extra field
to an opts struct is not backwards-compatible, so we'll need to add
new API and follow the pattern that we used for
bpf_object__open_{file,mem).

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

[...]
