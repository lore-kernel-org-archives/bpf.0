Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C88C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B07206C1
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 21:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlJti+iz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfDYVxe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:53:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38087 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDYVxe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 17:53:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id g1so734125qki.5;
        Thu, 25 Apr 2019 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SP9jpBgkJJkGSjOqTRIPxR1O1LuDgQHrNZcP5/Jmd20=;
        b=hlJti+izMnCnb3K4/qefWo+ImU6/jFAk/X2UADlwio6uWP7e+qMRyTQ/rExbzUp3Gf
         f12L33NtMtPU2Vu1x9ls+7k97y1pFos1hKK3pu0ahFNgeAQ4mDA+dghUV0N0lEwEWKm2
         YOSZRYFHXfZQvPJfrvFy2txy7xrhYBEiboRXuCFH/S4FJnLh3rIYf9kwwBfTMuQ8tSjv
         ofiRHDH5Q2GfhQ2y+iyn/DYiEwk/PDyoiFAtfbntzXlVl0eEDHfry4mRje1bAJe9050N
         MPGpDS5axhrDA/UIraexEsW6AoJgM/AfSsWeTMjaGpq/92RPMANvgkXJQ5/d1MJ8DJUb
         WGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SP9jpBgkJJkGSjOqTRIPxR1O1LuDgQHrNZcP5/Jmd20=;
        b=DoI/95R/NQbfUdCVKYiNd4lOwvROH2kCZLnfBaPNlQ/nghwb/5fIv9LhSK7h+uUZQB
         KjiruaKv0PSVzffysnEduivRY5YlzzsQuyUdUk7PhG22qO0ZWfUbw0HS4cZBh2vuvqJx
         +cjgh9ZvRXg4TApM4VCvs98ZZgyZucrOCUSvFuqFgvhy06iKmPxPswnKTsL2hJjXgou0
         LSXRw33ROOWfGbTDe/xzXEVhkB6FiKBjMlBGeTCX/b5+HWRUgTyLrJne/RIP8UUeFpDY
         9wvFsnm8LFPs+Z0BzvfzLgUCB1njnPd43oEHXzc2m3/d2VOaTZys2h0y1GXHprD+JxZx
         Biuw==
X-Gm-Message-State: APjAAAVptiigrB5phjRTWQ9GJLBk4V0H9b6lgFnCR5Zr/kuB+th72MYm
        VInQgB92oqHmZqX088mLuuYmVCpmV0EQ4Wl+7lM=
X-Google-Smtp-Source: APXvYqw7nLI6W3F4nCEtFp3YPZggdRF6+9cfx3iK/UpXTohWjceM2OE1KRXUvtDT8+cme5c2nQV9MMI7PIf/OTtIPnU=
X-Received: by 2002:ae9:f30f:: with SMTP id p15mr32621951qkg.182.1556229212965;
 Thu, 25 Apr 2019 14:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190425165539.3317350-1-andriin@fb.com> <4596def1-740e-c409-2aea-506f629df8d0@netronome.com>
In-Reply-To: <4596def1-740e-c409-2aea-506f629df8d0@netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Apr 2019 14:53:21 -0700
Message-ID: <CAEf4Bzbj86CaeRXZHOiE1UN3BuB-pXnMuYDjV1aejiVm6T4B4Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] add btf dumping to bpftool
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin Lau <kafai@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 25, 2019 at 12:20 PM Quentin Monnet
<quentin.monnet@netronome.com> wrote:
>
> 2019-04-25 09:55 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> > This patch set adds a new `bpftool btf dump` sub-command, which allows to dump
> > BTF contents (only types for now). Currently it only outputs low-level
> > content, almost 1:1 with binary BTF format, but follow up patches will add
> > ability to dump BTF types as a compilable C header file. JSON output is
> > supported as well.
> >
> > Patch #1 adds `btf` sub-command, dumping BTF types in human-readable format.
> > It also implements reading .BTF data from ELF file.
> > Patch #2 adds minimal documentation with output format examples and different
> > ways to specify source of BTF data.
> > Patch #3 adds support for btf command in bash-completion/bpftool script.
> > Patch #4 fixes minor indentation issue in bash-completion script.
> >
> > Output format is mostly following existing format of BPF verifier log, but
> > deviates from it in few places. More details are in commit message for patch
> > #1.
> >
> > Example of output for all supported BTF kinds are in patch #2 as part of
> > documentation. Some field names are quite verbose and I'd rather shorten them,
> > if we don't feel like being very close to BPF verifier names is a necessity,
> > but in this patch I left them exactly the same as in verifier log.
> >
> > v2->v3:
> >    - make map's key|value|kv|all suggestion more precise (Quentin)
> >    - fix default case indentations (Quentin)
> >
> > v1->v2:
> >    - fix unnecessary trailing whitespaces in bpftool-btf.rst (Yonghong)
> >    - add btf in main.c for a list of possible OBJECTs
> >    - handle unknown keyword under `bpftool btf dump` (Yonghong)
> >
> > Andrii Nakryiko (4):
> >    bpftool: add ability to dump BTF types
> >    bpftool/docs: add btf sub-command documentation
> >    bpftool: add bash completions for btf command
> >    bpftool: fix indendation in bash-completion/bpftool
> >
> >   .../bpf/bpftool/Documentation/bpftool-btf.rst | 205 +++++++
> >   .../bpftool/Documentation/bpftool-cgroup.rst  |   3 +-
> >   .../bpftool/Documentation/bpftool-feature.rst |   3 +-
> >   .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
> >   .../bpf/bpftool/Documentation/bpftool-net.rst |   3 +-
> >   .../bpftool/Documentation/bpftool-perf.rst    |   3 +-
> >   .../bpftool/Documentation/bpftool-prog.rst    |   3 +-
> >   tools/bpf/bpftool/Documentation/bpftool.rst   |   3 +-
> >   tools/bpf/bpftool/bash-completion/bpftool     |  68 +-
> >   tools/bpf/bpftool/btf.c                       | 580 ++++++++++++++++++
> >   tools/bpf/bpftool/main.c                      |   3 +-
> >   tools/bpf/bpftool/main.h                      |   1 +
> >   12 files changed, 859 insertions(+), 19 deletions(-)
> >   create mode 100644 tools/bpf/bpftool/Documentation/bpftool-btf.rst
> >   create mode 100644 tools/bpf/bpftool/btf.c
> >
>
> Hi Andrii,
>
> I got all your patches this time, but I think this is because you CC-ed
> me (thanks!), I cannot see them in patchwork or in the archives of the
> mailing lists (not even the cover letter this time, it seems). I don't
> know what can be the cause of it :(.

Yeah, it's strange. I'll try to shorten CC list and see if that helps.
I must be in some list of spammer or something. :)

>
> Other than this, I have a few nitpicks on the first two patches, I'm
> sending them separately.

Thanks!

>
> Best regards,
> Quentin
