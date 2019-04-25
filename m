Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE907C4321A
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C4206BA
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="e4P7rW2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfDYTUJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:20:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52215 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYTUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:20:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so655880wmf.1
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yCMWAOtuyMvaww4mfGH4nTaCFQJ+YuYeoYyt+uGAjjw=;
        b=e4P7rW2zL52Ukn9cotJ11ytzyRcdnTPt7oQZgBcgVjABifQ+bVtEutgN9e7Xlt6HJX
         Nft9UJozNdTvjYBzTpROqX/KUlzgerllkHrSt0vJ2D4Su8DOZLZ1mMkpgqE0xTKrNS8a
         N0uNKY2LIeQO/fav2v/U+BDAWCYYBCVMd5B/a2J9zBJllLDi3A5Y73+pAtC8Zivsysx/
         MjtQDT5F/gFNpbpYiffFGI8gRRxXPv0mij93yMnSs6eemKNXZ8sDKl4rOKXnnC6ZNfx1
         7gIJM39X0M+9dtwlPGjgHKdtD1ZSUxY2FkhnwwLO8arfOW99gIrBLwg5wLzoDqc9A73R
         PaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yCMWAOtuyMvaww4mfGH4nTaCFQJ+YuYeoYyt+uGAjjw=;
        b=GuUtY0aitGHHVPnpy1wzbVWbcMawk7MjFYLCuSRA8z/EJbZ+reKuFUoBiMayELX9/e
         YX3V6uY84a1fTRqffQflUHlxeoxAMrTs49qxKkjuYNmzk9W6z7cRzo2hMXG5fNcoo0Sb
         l9lv6LrxgS6epyPl4IxuAz3uGrfFtjpWV/D5wr25OApBKKM+5A6AyHyWzdzXI/Ko88wB
         QntgKcEArmiQ9W8PctWM93koWqISXakTgyratQJEXc5YBGGf6pcDM4R7yWjmuVWml23l
         mMZqgUBlxPqUNqRhu1IduhKstHUjBtJuXsqm8LhBvjUdcjnakR67xtnSjRe0xw31CfP+
         N7sw==
X-Gm-Message-State: APjAAAWuhCgXbrwmREA9Dm+ZW+/fLcwa2D61U2/tEdKR6YF/9FQWpRX5
        Nw3Nv4V4sW1iVVVqJXpuV+fDZQ==
X-Google-Smtp-Source: APXvYqzzZ5P6w8cCIPO00CLkBBMpMj5KlWDsoKTjAqM/1bWSWrgah9nhQcbhzZvMldTYkT/3IqNYpw==
X-Received: by 2002:a1c:ca07:: with SMTP id a7mr4991595wmg.104.1556220007182;
        Thu, 25 Apr 2019 12:20:07 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id z15sm15449169wrv.80.2019.04.25.12.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:20:06 -0700 (PDT)
Subject: Re: [PATCH v3 bpf-next 0/4] add btf dumping to bpftool
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        ast@fb.com, daniel@iogearbox.net, yhs@fb.com,
        songliubraving@fb.com, kafai@fb.com, acme@kernel.org
References: <20190425165539.3317350-1-andriin@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <4596def1-740e-c409-2aea-506f629df8d0@netronome.com>
Date:   Thu, 25 Apr 2019 20:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425165539.3317350-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-25 09:55 UTC-0700 ~ Andrii Nakryiko <andriin@fb.com>
> This patch set adds a new `bpftool btf dump` sub-command, which allows to dump
> BTF contents (only types for now). Currently it only outputs low-level
> content, almost 1:1 with binary BTF format, but follow up patches will add
> ability to dump BTF types as a compilable C header file. JSON output is
> supported as well.
> 
> Patch #1 adds `btf` sub-command, dumping BTF types in human-readable format.
> It also implements reading .BTF data from ELF file.
> Patch #2 adds minimal documentation with output format examples and different
> ways to specify source of BTF data.
> Patch #3 adds support for btf command in bash-completion/bpftool script.
> Patch #4 fixes minor indentation issue in bash-completion script.
> 
> Output format is mostly following existing format of BPF verifier log, but
> deviates from it in few places. More details are in commit message for patch
> #1.
> 
> Example of output for all supported BTF kinds are in patch #2 as part of
> documentation. Some field names are quite verbose and I'd rather shorten them,
> if we don't feel like being very close to BPF verifier names is a necessity,
> but in this patch I left them exactly the same as in verifier log.
> 
> v2->v3:
>    - make map's key|value|kv|all suggestion more precise (Quentin)
>    - fix default case indentations (Quentin)
> 
> v1->v2:
>    - fix unnecessary trailing whitespaces in bpftool-btf.rst (Yonghong)
>    - add btf in main.c for a list of possible OBJECTs
>    - handle unknown keyword under `bpftool btf dump` (Yonghong)
> 
> Andrii Nakryiko (4):
>    bpftool: add ability to dump BTF types
>    bpftool/docs: add btf sub-command documentation
>    bpftool: add bash completions for btf command
>    bpftool: fix indendation in bash-completion/bpftool
> 
>   .../bpf/bpftool/Documentation/bpftool-btf.rst | 205 +++++++
>   .../bpftool/Documentation/bpftool-cgroup.rst  |   3 +-
>   .../bpftool/Documentation/bpftool-feature.rst |   3 +-
>   .../bpf/bpftool/Documentation/bpftool-map.rst |   3 +-
>   .../bpf/bpftool/Documentation/bpftool-net.rst |   3 +-
>   .../bpftool/Documentation/bpftool-perf.rst    |   3 +-
>   .../bpftool/Documentation/bpftool-prog.rst    |   3 +-
>   tools/bpf/bpftool/Documentation/bpftool.rst   |   3 +-
>   tools/bpf/bpftool/bash-completion/bpftool     |  68 +-
>   tools/bpf/bpftool/btf.c                       | 580 ++++++++++++++++++
>   tools/bpf/bpftool/main.c                      |   3 +-
>   tools/bpf/bpftool/main.h                      |   1 +
>   12 files changed, 859 insertions(+), 19 deletions(-)
>   create mode 100644 tools/bpf/bpftool/Documentation/bpftool-btf.rst
>   create mode 100644 tools/bpf/bpftool/btf.c
> 

Hi Andrii,

I got all your patches this time, but I think this is because you CC-ed 
me (thanks!), I cannot see them in patchwork or in the archives of the 
mailing lists (not even the cover letter this time, it seems). I don't 
know what can be the cause of it :(.

Other than this, I have a few nitpicks on the first two patches, I'm 
sending them separately.

Best regards,
Quentin
