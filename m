Return-Path: <SRS0=M8wK=7X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7FBC433E0
	for <bpf@archiver.kernel.org>; Wed, 10 Jun 2020 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FF02078C
	for <bpf@archiver.kernel.org>; Wed, 10 Jun 2020 08:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqVVUJoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgFJIqT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgFJIqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jun 2020 04:46:18 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7997C03E96F
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 01:46:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id mb16so1653231ejb.4
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2020 01:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fr9WSBy3gq5GY8giUE4KFe+ZLK4loVtHVClvYlgpVVQ=;
        b=TqVVUJoSRKntkPgmQCHuFRGWI2BxlwxQqsTclCYQSCf3eaVZpD7azhD7/QG6YAJQKg
         eI6na/W/DIwZ84Qt/aaZ/XVkVellNvzRI94eENitRi8ribFC5CRIvpEVJTba6+uJIT/D
         fC3WJTBmPf6caQC9IyXy5jMWJ6vs61gRXJMwvfDkmEEkaydtTZe32inwrCGoGNopHZUm
         K2Kev9SuC0Te4VLCcq0LagBi1XEOnohn16uumL+sxUHhJwcNyaoAJsmhkuJ9Fp+ieAd5
         ZjUivzxPfztI3q0hHnzfnoiuJkqBT1Bt/c0xSX01IRZQZ28lefeFup44z2IVWqQjVS1P
         hHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fr9WSBy3gq5GY8giUE4KFe+ZLK4loVtHVClvYlgpVVQ=;
        b=Mo6/PsR6ZankWuUbgnk7aZnyiEprImPDcNipk9woTR0f539mhud3qauADBJlpnhkph
         yrhTQLl6Wvt3UtlizxMWN246vyIZ3UbOoEmskcuHyPqfH+mGDpkm/NDjLP7g2awcgGKF
         gqXcBeRXbXmVXUFEKXBOG0nf2NImeihBs7GRJlttn+q8cofqsCNnH8BOjr6M6echVS0I
         EbCmVWQOzh6Fwdn77uNPx+3jz3L6nUR9URk/hxy1ZWsvCgvcHUL9/RssxpozEvhzBkXt
         RGUm/NsTV6J1wo4jale1hCloj3P05P9VclVU0JEQ8VlAQ6wAjxUOS50gw28c7/YGS16D
         5y6w==
X-Gm-Message-State: AOAM530CUh4Y1zvmrP2bM4SFnm+Q+9CAMBvC1dKWKgfuwoUPgU8PZSdl
        AytW5mEPlAwuvUBQc4LpeUEhpThdn/o=
X-Google-Smtp-Source: ABdhPJzA97A3rrLRtTlBwR3B3e3BG33eFj9uqUFs9Ug4zmbFxTvGgBuwrDfFMBkC8/t0lc1NotIZ0w==
X-Received: by 2002:a17:906:2b92:: with SMTP id m18mr2574832ejg.218.1591778776018;
        Wed, 10 Jun 2020 01:46:16 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p13sm16608202edq.50.2020.06.10.01.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 01:46:15 -0700 (PDT)
Date:   Wed, 10 Jun 2020 10:46:05 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf] libbpf: handle GCC noreturn-turned-volatile quirk
Message-ID: <20200610084605.GB6844@myrica>
References: <20200610052335.2862559-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610052335.2862559-1-andriin@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 09, 2020 at 10:23:35PM -0700, Andrii Nakryiko wrote:
> Handle a GCC quirk of emitting extra volatile modifier in DWARF (and
> subsequently preserved in BTF by pahole) for function pointers marked as
> __attribute__((noreturn)). This was the way to mark such functions before GCC
> 2.5 added noreturn attribute. Drop such func_proto modifiers, similarly to how
> it's done for array (also to handle GCC quirk/bug).
> 
> Such volatile attribute is emitted by GCC only, so existing selftests can't
> express such test. Simple repro is like this (compiled with GCC + BTF
> generated by pahole):
> 
>   struct my_struct {
>       void __attribute__((noreturn)) (*fn)(int);
>   };
>   struct my_struct a;
> 
> Without this fix, output will be:
> 
> struct my_struct {
>     voidvolatile  (*fn)(int);
> };
> 
> With the fix:
> 
> struct my_struct {
>     void (*fn)(int);
> };
> 
> Reported-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Thanks, this fixes the issue I was seeing with the arm64 vmlinux

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

