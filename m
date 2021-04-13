Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332C6C433ED
	for <bpf@archiver.kernel.org>; Tue, 13 Apr 2021 01:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B7C61222
	for <bpf@archiver.kernel.org>; Tue, 13 Apr 2021 01:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhDMBpI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 12 Apr 2021 21:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbhDMBpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 21:45:07 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3914C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 18:44:48 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id n4so12758331ili.8
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 18:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=FjQHa5SIpgNQ1s3XjWdQKjIEKOvfum3Bjqf/DowJCKE=;
        b=dvZZh2cD1Z8QvLTNyKckp0/ad28jp+M6zzBQ6DzcOUiFjKf7a5EHSNX3RZKHm5DOIZ
         p4mP5ZJqTwvr/CzaQF2rw3mFx9AxnUraM6eMtehJSCxYcI4gLBk0Pd9+ig+b+aH4U2p4
         Bdj8DfYK77w8I5OoZQ2wjjxtiWAfg65DECV2eE7Fq6HGwfe4iUuIEZLrDjZXSwnTbDgZ
         IJWxYDMtWbZwVWZ2kAtlLFl1PaIUatly58G7NCmgL7Qs35mwk9qxpidKHbwzb38JkdyG
         QpTPB+eOK59gBtaVnPagb+amIDf2YoicCyY+8GoFdRcmOQWp8nTHiRFAYMsU22OuYwwA
         nuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=FjQHa5SIpgNQ1s3XjWdQKjIEKOvfum3Bjqf/DowJCKE=;
        b=Iz7d7mwP4v6kTBsQQh0SWw6FocH0aSaNj+gHb6437u00KfGOsSDhzD6K8Bw/2FiyA1
         VQ0PYmSP/cQmVlmf15OiUPiDNqLetpP46XfHj9REoNrtv1TKX7MXMdzHyL05SUDoUw00
         8u2uElucojl8yWzN/5GnrwxIPyfIikIFbtXnGRI7mm+OCJ4uWnzZecmcARauT2+OT1z4
         N3qrtLdjn4GW8qD6J0FKqeQtTeN+gDCtQ6IaqnhBPY8S6Qlj4IRJ4XqArGKQVGqqbESh
         P5XCRqC1+3zaqO69Yp+tiaWwa2ReTkSaUjQA6UUAhj/QXKVG+sR6VYRHdynjI7qrJS02
         ZuSw==
X-Gm-Message-State: AOAM533bXZixm4SZb4LBGD2DjnniBe/hy00zL9LlauoPcPktWv9J/SAv
        UTtXTXuc83p3znszTsirYAOO7CU7ZGhnK1Xntfo=
X-Google-Smtp-Source: ABdhPJytGHh2Ux0qV29SIbolqWsKm0h6zH6HpPvi7WoEDSoMkYdNsBa6qWv18Uu7Pcg4b0a+7nmcJKq+rBidWHPJ8ps=
X-Received: by 2002:a05:6e02:b2e:: with SMTP id e14mr24904674ilu.186.1618278288357;
 Mon, 12 Apr 2021 18:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com>
In-Reply-To: <20210412142905.266942-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 13 Apr 2021 03:44:16 +0200
Message-ID: <CA+icZUVFGe443PsDj8SmBpD95YEBzYATgx8LDQQwYtdY+j6sxw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 4:29 PM Yonghong Song <yhs@fb.com> wrote:
>
> To build kernel with clang, people typically use
>   make -j60 LLVM=1 LLVM_IAS=1
> LLVM_IAS=1 is not required for non-LTO build but
> is required for LTO build. In my environment,
> I am always having LLVM_IAS=1 regardless of
> whether LTO is enabled or not.
>
> After kernel is build with clang, the following command
> can be used to build selftests with clang:
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>
> But currently, using the above command, some compilations
> still use gcc and there are also compilation errors and warnings.
> This patch set intends to fix these issues.
> Patch #1 and #2 fixed the issue so clang/clang++ is
> used instead of gcc/g++. Patch #3 fixed a compilation
> failure. Patch #4 and #5 fixed various compiler warnings.
>

Might be good to add some hints like when the build stops or errors:

Like in my case when I had no CONFIG_DEBUG_INFO_BTF set.

Of course in combination with Clang-LTO a pointer "you need pahole
version 1.21." and CONFIG_DEBUG_INFO_BTF=y.

Finally, a hint for missing xxx-dev(el) packages (see Nick's report).

The tools directory has its own build rules thus I cannot say how to
check for specific Kconfigs.
I have not looked.

NOTE: I have not checked without setting CONFIG_DEBUG_INFO.

- Sedat -

> Changelog:
>   v1 -> v2:
>     . add -Wno-unused-command-line-argument and -Wno-format-security
>       for clang only as (1). gcc does not exhibit those
>       warnings, and (2). -Wno-unused-command-line-argument is
>       only supported by clang. (Sedat)
>
> Yonghong Song (5):
>   selftests: set CC to clang in lib.mk if LLVM is set
>   tools: allow proper CC/CXX/... override with LLVM=1 in
>     Makefile.include
>   selftests/bpf: fix test_cpp compilation failure with clang
>   selftests/bpf: silence clang compilation warnings
>   bpftool: fix a clang compilation warning
>
>  tools/bpf/bpftool/net.c              |  2 +-
>  tools/scripts/Makefile.include       | 12 ++++++++++--
>  tools/testing/selftests/bpf/Makefile |  7 ++++++-
>  tools/testing/selftests/lib.mk       |  4 ++++
>  4 files changed, 21 insertions(+), 4 deletions(-)
>
> --
> 2.30.2
>
