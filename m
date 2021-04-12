Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272F7C001E6
	for <bpf@archiver.kernel.org>; Mon, 12 Apr 2021 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95C661243
	for <bpf@archiver.kernel.org>; Mon, 12 Apr 2021 09:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239549AbhDLJNG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbhDLJH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 05:07:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABB5C06138E
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 02:03:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a25so1156736ljm.11
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nd0ImIdUa1u7AnlGFIsqEhD94Kk6bOws+tMPgx4SdcM=;
        b=kw+yIfvvq1XfnpibTfDCGnnJ1mYeDtq37FUQquMZx5h9hLBU8qGwZd8BT4SjXeY4DK
         Rx7IYR0mASkjzEIQ0pjSevykpYXGpzGwsLS+dMncsBG8y5yIhuR3mpmRe8Ifhwcdh3hL
         /BJjv9yuItyfrysDnb+kbcFcLZOIZD+Y3BM3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nd0ImIdUa1u7AnlGFIsqEhD94Kk6bOws+tMPgx4SdcM=;
        b=O/XdXCiJyYJnzKeG7YZH79sb3PmkWbAMERgIv8+VV73RdEiGk4VV9ry/g3Ho1xp7I4
         bRLWXy9EK9rhhHFEyNx73deR22RcshJUuql7svB2tjvA88HdqH5d6IZSAtQk2wTEh53F
         IwdMSx2mLg6Xhi8lklHTRT2YNOOyAJSp1kCRyKqDqwSNsRoLEilST3QjQBziLqPJ6ybd
         Vq1ndFuCVDCGDJqa+iNqgYdeNzeVvdpuK/q9VJP2KU0t4Xqq3Si/wmyQESUHL0T2mKJD
         tL8BhSYlcc/Wgo686SdVCi9+9vlOJ9DgvY4BnmVCW6mTgIZJ7j3FdXHNxkToNcVwVhEA
         /ZQg==
X-Gm-Message-State: AOAM532RgTXTuYLMIjlT49K7UxlaKQbq4YGquTYwnVd6D2mtlmat5XlF
        rZtcu1WjWwJSBh+0ncxa5X3mr3k51LExx3n1adSLUQguEmk=
X-Google-Smtp-Source: ABdhPJyxs1rVilsqWGsko72nwwiCo6wjukjatK959ot/o0qzPCD0APWIXXwtyuGLipc6w4dnU0dO1t4Tml6/fgWFVO0=
X-Received: by 2002:a2e:9618:: with SMTP id v24mr983489ljh.83.1618218179258;
 Mon, 12 Apr 2021 02:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210410174549.816482-1-joe@cilium.io>
In-Reply-To: <20210410174549.816482-1-joe@cilium.io>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 12 Apr 2021 10:02:48 +0100
Message-ID: <CACAyw98he5f+07kU_fLgMZB0FY6jKjxDMOt5A9U7o-PNLKfFYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Document PROG_TEST_RUN limitations
To:     Joe Stringer <joe@cilium.io>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 10 Apr 2021 at 18:45, Joe Stringer <joe@cilium.io> wrote:
>
> Per net/bpf/test_run.c, particular prog types have additional
> restrictions around the parameters that can be provided, so document
> these in the header.
>
> I didn't bother documenting the limitation on duration for raw
> tracepoints since that's an output parameter anyway.
>
> Tested with ./tools/testing/selftests/bpf/test_doc_build.sh.
>
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>

Thanks Joe!

Acked-by: Lorenz Bauer <lmb@cloudflare.com>


-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
