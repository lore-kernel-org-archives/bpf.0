Return-Path: <SRS0=LM74=ZT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB3DC432C0
	for <bpf@archiver.kernel.org>; Wed, 27 Nov 2019 20:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F60020661
	for <bpf@archiver.kernel.org>; Wed, 27 Nov 2019 20:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAA8LLgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfK0UH6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:07:58 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35907 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0UH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Nov 2019 15:07:58 -0500
Received: by mail-qk1-f196.google.com with SMTP id v19so1050276qkv.3;
        Wed, 27 Nov 2019 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrZ3xCNb2052nOq69onqXPRWOJl+S7CdYgh6z78YYAk=;
        b=EAA8LLgpFt+cOeImZ8W4z5dM3uDKAYK5tgauDvd2MirnE84TDcD15k/jyXeVnYMSS8
         jpBLJHEEi2EcbdBa4SzT5pcluTr8Vgr077iah0DBJGhmg8NCej98IS1uAfe7TLXpukvE
         FahDXXLRpoKUwgU+ajbK3kLvV9lvx+TCZkeAo48Q3vuXwRtx5l/yvyrOR5hfr3+dd+21
         RwvjAxD8s9g5ZbQkRA00nsWdPFvPXW9mrId0ENpU40B+yLLN0sJMmoNfDHSJ4slS/Req
         BAqMkpBJ24WUVlJlrtiqLh1Uv5QOlJpAT5vb+JMn/1Xf90BAJTzMVJBTUmaBPCxXcc9r
         ET+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrZ3xCNb2052nOq69onqXPRWOJl+S7CdYgh6z78YYAk=;
        b=rnVr/FXJF7PuGXtVEbZaJPu4EDWS8XT8isYN4mMK6AB9HTEL0rjzFvCNeXnXjbUZcP
         j+F+V5/hMG4KSKKNZrW0p1Pe6KaBJ51Kr4BPGsgyEPEUhZyNR3vBztf6R4Vg3B9YAYxw
         8we8+ddrR4dAQ4JOJzmUpZLXnpiucvEz7uTzqiK9rusL40KdvLYlznwLU6xrvED+1Drr
         yT3qWKFv2blTUuwdsjZPJEIhRjKCtUHPZ6INZB6EtIpZs4nZXSE+61vjq7d7UPEB0jWE
         fLIdReLYEjT8uQXOHrVUDTpIeh70n1cQD1LWB5WfdAHmYBxI9SFx94Ed2ZMkZze5uPim
         IweA==
X-Gm-Message-State: APjAAAWW6iX+x8ukNQwZDxtdtAHg3EdXrqcyFOQ9jMYA6j5ZhAujKLe1
        VyS9yYvA/TzXqCDFSbeNlxeCxbFcJLAIMwRhzPSjCw==
X-Google-Smtp-Source: APXvYqwRTiK03pg7n1hAISlwmdnQn2MmL7dgLOR3aX5uGripIzAtFpvVeuo62i86mbf0ZeXsa6jwPXCvJGbd1uG9LlI=
X-Received: by 2002:a37:a914:: with SMTP id s20mr6295131qke.92.1574885276802;
 Wed, 27 Nov 2019 12:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20191127060144.3066500-1-andriin@fb.com> <ce16b691-8afa-2e0c-6a99-ec509a125115@fb.com>
In-Reply-To: <ce16b691-8afa-2e0c-6a99-ec509a125115@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Nov 2019 12:07:45 -0800
Message-ID: <CAEf4BzZ+iEDwCtzzE=JxYQQJ-inkbRx4OOq70ejewUq1-8ahxQ@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix global variable relocation
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 27, 2019 at 10:19 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/26/19 10:01 PM, Andrii Nakryiko wrote:
> > Similarly to a0d7da26ce86 ("libbpf: Fix call relocation offset calculation
> > bug"), relocations against global variables need to take into account
> > referenced symbol's st_value, which holds offset into a corresponding data
> > section (and, subsequently, offset into internal backing map). For static
> > variables this offset is always zero and data offset is completely described
> > by respective instruction's imm field.
> >
> > Convert a bunch of selftests to global variables. Previously they were relying
> > on `static volatile` trick to ensure Clang doesn't inline static variables,
> > which with global variables is not necessary anymore.
> >
> > Fixes: 393cdfbee809 ("libbpf: Support initialized global variables")
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>
> LGTM with a few nits below.
>

Good points, I was too laser-focused. Updated in v2, thanks!

> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   tools/lib/bpf/libbpf.c                        | 40 +++++++++----------
> >   .../testing/selftests/bpf/progs/fentry_test.c | 12 +++---
> >   .../selftests/bpf/progs/fexit_bpf2bpf.c       |  6 +--
> >   .../testing/selftests/bpf/progs/fexit_test.c  | 12 +++---
> >   tools/testing/selftests/bpf/progs/test_mmap.c |  4 +-
> >   5 files changed, 35 insertions(+), 39 deletions(-)
> >

[...]
