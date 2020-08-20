Return-Path: <SRS0=CWvS=B6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE701C433E1
	for <bpf@archiver.kernel.org>; Thu, 20 Aug 2020 23:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0222072D
	for <bpf@archiver.kernel.org>; Thu, 20 Aug 2020 23:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNNWsnDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgHTXbY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgHTXbT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 19:31:19 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58CC061386;
        Thu, 20 Aug 2020 16:31:18 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id g3so80964ybc.3;
        Thu, 20 Aug 2020 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k9YgLZZHHcncWuqjsOaWEuLF17t1Fvi8ZvDI53bpe08=;
        b=HNNWsnDnmQZgMbGnCQVsUsiyvP44j/akTpLehKz4Jq79e5/FwUpntqR5mFeZEQk96k
         Pv3xV1GZ651fe2lxYb6Dr5+TezoH715DcI/s+BItr51gqAlUXQdxZFwRYHanFy1N0i0q
         QoHFER5uGkto9dA+8YRPSSKADiQ6mnlTC+3slDnG603EWXUYATCGLmoqK5Symehigc0z
         AWSSMZNw25hFkoDVN/l3u/pPXUcdBYaM6QaGK2Bkc+zVSZZekMH9Th5sUrFyQ7gnQzug
         Nr7l8IN5X41llPfX76EoyVYTQ1cHhDxSqGAKlSSEhB9GYR93oKZGWVMEnxyp08qt0aSR
         YRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9YgLZZHHcncWuqjsOaWEuLF17t1Fvi8ZvDI53bpe08=;
        b=poZoL04Dta8MqJNFrNu2SuVemQswinPKPcpY2FguDoQdVR34nC0QYd8+OaszC7QTkP
         g94wEvMspApTHqWp0Daod8OOhbh6uiQfheO8eY/dq+iDC0u7olNV6Jvl+o1/6N3Pijr3
         ZR0LS54yJe+93RLqE+cb2Qv5Z7VuYRvrqEHGh38kWMye05phLwl4NANcCHbfm4O4FHqM
         p0U59YUJmrJ/ayXOziepqYC2EsXZmOT12bIT4nXbj9OFDlqlD3BjmZoiheYXSZyxyB27
         rcnIH8wUU23KB0yXa3HKGcwW7h5qjQaLlUR7NOe8LkqJR5B8KLLNVYfZFNF+rQYlfJej
         BtMA==
X-Gm-Message-State: AOAM533UMVTbrhBsafS5T2qDLXvSIpUvK97oxLBrmKAv1whknD26MOva
        taXlKMKDKJTssX//bQxbyC4H2zd9gxz1yyIjnbg=
X-Google-Smtp-Source: ABdhPJyMSeoPi//xdJIzZ95ET6jt4ynLUKSlWu6/V1VPqpcfbwOotyA9wqIOpnmRz5xhjQC1FSxHpgaqIBJFm5Oo0IY=
X-Received: by 2002:a25:84cd:: with SMTP id x13mr158154ybm.425.1597966277001;
 Thu, 20 Aug 2020 16:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200820231250.1293069-1-andriin@fb.com> <20200820231250.1293069-11-andriin@fb.com>
In-Reply-To: <20200820231250.1293069-11-andriin@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Aug 2020 16:31:06 -0700
Message-ID: <CAEf4BzbeaUZ5Uxaq8URxKtstoA6UN8vnFQWjTpuSL4HMfS0m5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/16] libbpf: implement generalized .BTF.ext
 func/line info adjustment
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 4:13 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Complete multi-prog sections and multi sub-prog support in libbpf by properly
> adjusting .BTF.ext's line and function information. Mark exposed
> btf_ext__reloc_func_info() and btf_ext__reloc_func_info() APIs as deprecated.
> These APIs have simplistic assumption that all sub-programs are going to be
> appended to all main BPF programs, which doesn't hold in real life. It's
> unlikely there are any users of this API, as it's very libbpf
> internals-specific.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/btf.h           |  18 +--
>  tools/lib/bpf/libbpf.c        | 217 ++++++++++++++++++++++------------
>  tools/lib/bpf/libbpf_common.h |   2 +
>  3 files changed, 153 insertions(+), 84 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
> index a23ae1ac27eb..145ddff57235 100644
> --- a/tools/lib/bpf/libbpf_common.h
> +++ b/tools/lib/bpf/libbpf_common.h
> @@ -15,6 +15,8 @@
>  #define LIBBPF_API __attribute__((visibility("default")))
>  #endif
>
> +#define DEPRECATED(msg) __attribute__((deprecated(msg)))

Given this will end up in user code, it seems like using
LIBBPF_DEPRECATED would be a better choice. I'll update for v2.

> +
>  /* Helper macro to declare and initialize libbpf options struct
>   *
>   * This dance with uninitialized declaration, followed by memset to zero,
> --
> 2.24.1
>
