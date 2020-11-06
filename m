Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA8C2D0A3
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 03:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF422075A
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 03:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH+8jr1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgKFDxR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Nov 2020 22:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDxR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 22:53:17 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE668C0613CF;
        Thu,  5 Nov 2020 19:53:16 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id f6so2587ybr.0;
        Thu, 05 Nov 2020 19:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2AIiVxkOnwPyftxYL1/j7Dy6SZMLtDsVFSo2M4HZ00=;
        b=TH+8jr1O5vLPDH4dbuO2Dz6p1Yd/QzZehL7b5uRnz1ilNH26KAyT2Xa3p+tCJbzw9C
         iZshgXOQHIENIB544P5LFmvJZV7d8a0h9fs1G76RIwsWCEhyC1sfm9/a0UGkJAI4wnXg
         MPBg7RiQtiIo4yU1xnJhMtj3vGIDKb1IiEIuvK6FrSW5+ERVJedXP6VLAPP0gEw6mpwJ
         w419HoAwpzPExfLsu1MFjkoEhcI3hge+qxaILaPFXeiMrqg3z7h7FHyBjt2Xd39jZMC8
         t1VGPs6I9hLODV0jG5jrmQDqyRGSnrZYc0C3bxjId4DWRzHMi02fyT/XukzwNYceAMGJ
         UzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2AIiVxkOnwPyftxYL1/j7Dy6SZMLtDsVFSo2M4HZ00=;
        b=ZKisKfrSPOMp7gLo1gO/Dt005VZFOpulBTApNeiAnz48YGe8mKs8cM6GJrNbTS8Vt7
         1+3WoDN0YlExPUQ9tT46P/nx20lQRQ/uzlOcLGM62l114UiasjVr0Ate2CAtGj98pqiU
         FV1BcEkR2c+j/ugflUx/4CZUcRvYvxXktmjQOMEMvrOhYW8hAbY5gdtBdfzle9NMjqhW
         M7XLsjSGeOz6Kwc7GWLh5ONK4hV8O2e2YlgoYCJQVD94qgvi0SQfAkIkeRks6j4RbCM5
         mrMkZUMKFenPOvyU5khqdSuG1EaGbqcDdvk0l6ZJ9ChjPAryCc2bQ64say0JXE2u23Zx
         3TbQ==
X-Gm-Message-State: AOAM533c5zjN5eeenwl6WUyzrEwKL2C3Nz0UXPG6rgn3pNTdXjX+aa06
        CTUxhSejh/h7HPLxtZi+ZXUY5kS4mWwH7mIM1QI=
X-Google-Smtp-Source: ABdhPJzjOn/LUMbXAzDVz/o0f2HeEUukHJv7w47ijR6bdpg0B2XCe5mt1wYLixTDSMQz5xcLln4vRswoKiRprb0uNwc=
X-Received: by 2002:a25:da4e:: with SMTP id n75mr241475ybf.425.1604634796022;
 Thu, 05 Nov 2020 19:53:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604620776.git.dxu@dxuuu.xyz> <8b8c8f51aff8fabac4425da9b0054b4c976c944b.1604620776.git.dxu@dxuuu.xyz>
In-Reply-To: <8b8c8f51aff8fabac4425da9b0054b4c976c944b.1604620776.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 5 Nov 2020 19:53:05 -0800
Message-ID: <CAEf4BzafhaMDuTi3CYsF2sEp_cgOv5kohBOOwSX6qPoUr4-HWw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 4:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Previously, bpf_probe_read_user_str() could potentially overcopy the
> trailing bytes after the NUL due to how do_strncpy_from_user() does the
> copy in long-sized strides. The issue has been fixed in the previous
> commit.
>
> This commit adds a selftest that ensures we don't regress
> bpf_probe_read_user_str() again.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../bpf/prog_tests/probe_read_user_str.c      | 71 +++++++++++++++++++
>  .../bpf/progs/test_probe_read_user_str.c      | 25 +++++++
>  2 files changed, 96 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
>

[...]
