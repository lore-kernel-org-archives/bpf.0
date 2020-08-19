Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726B2C433E1
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 00:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B49B20738
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 00:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2qDUnNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHSAYe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgHSAYb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 20:24:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E7C061389;
        Tue, 18 Aug 2020 17:24:30 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 74so10759699pfx.13;
        Tue, 18 Aug 2020 17:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9hX7/jnnxbAk5wAQIdPFnO+IQaOTQaG5y84ogGkzkX8=;
        b=F2qDUnNyuI2DLpYA9mbYoROxoPJGf8+FHy/IC6Ty1PJxp7qQ/DX+nqQ32iinAo+SLS
         gjy1fd0D3l5KBYymj5jTEl1szMB0sGSOEI00umL7nXLW0kCgE6veB2bz2yvdNSL7Bgl9
         /QBsrhrveOW85YeaikOQumhg0hXSS/x6IZV8ghv3rnDTE0vmw+xn23GMW5v/9tikxJrX
         hjNSNNpXtcQ2631zvD6BtSAqFsAzHxlfup34LUWC+8KOlxFqbraaP6MbJMRPwXHhK/Rx
         hb5xBlUgzkRIqLhZbf+pTT4gxVs8rgfoowP/t3Wi8wczf+YxWhHuDgqVTXQ+g+yO/TtD
         Ke9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9hX7/jnnxbAk5wAQIdPFnO+IQaOTQaG5y84ogGkzkX8=;
        b=QJazVpsX9sAJRH602qySHBN+QiHal9kIoJQeZybbLmVvcatKiVDG4lCqCopGmhoRlt
         chUBgmTQXXneB1Cap63O6oLvQ/1dv+RLaC+FpMDFKXRu5XNpN2CnAQnt51A0WMrgQngF
         bxvVdz9ICPoqeODVL4+M2/QBPNCKgjN/xpfvvQlgbWSIaQ6GqcESCQ9J0V1KVrxXjuRU
         EfFoZTPjah1gwWij1VEvZO9TPUJUd2V3y6EyKQP4rM2cyHagArJb32o8oz2FaN5MxhxC
         05cFVuik6Ns72tjG/jlh/+toPfJkv1ms85jSVRv2+tkqPRW1ISw4ozCzPvoHxgrOAcAc
         eCrg==
X-Gm-Message-State: AOAM5325WPWOInj2o3qno9kcDVxCmux931sPdzLyAUBjaw4eoF5VwAjj
        ViCNxl5qRr5tXlZa08cu0hQ3jwgEy5M=
X-Google-Smtp-Source: ABdhPJyedOQbYrPixXEApg/L/BeIqzF74tc5ExwsPvLnv8GIfL40Dzx0Gdpb1pWB88xYQ4mr/qjFTA==
X-Received: by 2002:a65:62c3:: with SMTP id m3mr14791972pgv.338.1597796670088;
        Tue, 18 Aug 2020 17:24:30 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:20fd])
        by smtp.gmail.com with ESMTPSA id e29sm25811202pfj.92.2020.08.18.17.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 17:24:28 -0700 (PDT)
Date:   Tue, 18 Aug 2020 17:24:27 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 0/7] libbpf feature probing and sanitization
 improvements
Message-ID: <20200819002427.5ktz6us47zb2iazr@ast-mbp.dhcp.thefacebook.com>
References: <20200818213356.2629020-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818213356.2629020-1-andriin@fb.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 18, 2020 at 02:33:49PM -0700, Andrii Nakryiko wrote:
> This patch set refactors libbpf feature probing to be done lazily on as-needed
> basis, instead of proactively testing all possible features libbpf knows
> about. This allows to scale such detections and mitigations better, without
> issuing unnecessary syscalls on each bpf_object__load() call. It's also now
> memoized globally, instead of per-bpf_object.
> 
> Building on that, libbpf will now detect availability of
> bpf_probe_read_kernel() helper (which means also -user and -str variants), and
> will sanitize BPF program code by replacing such references to generic
> variants (bpf_probe_read[_str]()). This allows to migrate all BPF programs
> into proper -kernel/-user probing helpers, without the fear of breaking them
> for old kernels.
> 
> With that, update BPF_CORE_READ() and related macros to use
> bpf_probe_read_kernel(), as it doesn't make much sense to do CO-RE relocations
> against user-space types. And the only class of cases in which BPF program
> might read kernel type from user-space are UAPI data structures which by
> definition are fixed in their memory layout and don't need relocating. This is
> exemplified by test_vmlinux test, which is fixed as part of this patch set as
> well. BPF_CORE_READ() is useful for chainingg bpf_probe_read_{kernel,user}()
> calls together even without relocation, so we might add user-space variants,
> if there is a need.
> 
> While at making libbpf more useful for older kernels, also improve handling of
> a complete lack of BTF support in kernel by not even attempting to load BTF
> info into kernel. This eliminates annoying warning about lack of BTF support
> in the kernel and map creation retry without BTF. If user is using features
> that require kernel BTF support, it will still fail, of course.

Applied, Thanks
