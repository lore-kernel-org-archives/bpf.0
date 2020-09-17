Return-Path: <SRS0=dFgW=C2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB688C43463
	for <bpf@archiver.kernel.org>; Thu, 17 Sep 2020 21:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937352137B
	for <bpf@archiver.kernel.org>; Thu, 17 Sep 2020 21:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYT7gO1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIQVDo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Sep 2020 17:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgIQVDo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 17:03:44 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEB4C06174A;
        Thu, 17 Sep 2020 14:03:43 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 8so2683707ybu.4;
        Thu, 17 Sep 2020 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/lxaNf8epLM85huh8HbgBldYe44GATtXP9r+k2/77w=;
        b=VYT7gO1DzykdTVZKO16cTODx8ejBTCa9WQRfzoioVUFm+ha+SYUzsEdaMVrI4fBEyE
         kxf9k2XtbNL258GWIsdxgHmezQG1GjViFXQMamoQuT5Et2a56ylH0fsuWt7eE8JVGvFM
         1ySRIdYwJhPZHRU1u86u4LDWKQF/vDwLi4UkMPjg5riCumZ6UVcAJOlpZS4r3e1ZHvsO
         j5z0yOcA5mBBm8PSZIWzjv5NXa/4ruiauMuUY/Uv0OoDX/jpSSUZZjKXQ+Lw9JFroAN6
         lYr5Q6yh8EYXhGMgME71SCsvOdal849SETaCZKt7Fljk4SrWb++JDdIDZhQQNgSoyjOn
         wNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/lxaNf8epLM85huh8HbgBldYe44GATtXP9r+k2/77w=;
        b=hwpTh2ZzWhBQfLUMHy+IN5c6nW7iZQkx5ZZ2fK3ZF3Bm0mbvHsjHtK+c/m6PG+RaeP
         bimDAAiZElK+vuUV0C6ZXzaQoFS7gBKTogKIMu5RZCOY1INA+uJeAvUPbvZJLya+C+42
         6DNerYRkY7q3mzULHPH2/V8MNsEZ8gbtdXRGWD4iCYQ5ZHGH4U9zXL1p9hnnowgq6/77
         cTeZjOoXsHJUQgqMf38NB9mMjkTrNUhM6s1IlktyQtO83fn8HOhA+AGBjcK+KQY3OcIC
         aqRKFyQlzswbAcsBpVFmA7zi/P7CV/EL33/7KgRaefIsu6FPNIqsaC9y4GiSQjn7b6pP
         gfpg==
X-Gm-Message-State: AOAM530Is9IiGmoNOsdgp7QdtFJXdlHrRxYKtJ6WnBPeovRn7py53EQc
        wNid/3uSGxUJiz69v7BB3dhDImqZR6ACyZWY/MHRU94Vmbs=
X-Google-Smtp-Source: ABdhPJwqrC/AI8hiAQDt/cU75g+Sj32FDEKYnq/Y8Wmh4jctrdipZzA/MiwSAxpnrc22E7BRRGuQ/9+g7+w8IkEP2AI=
X-Received: by 2002:a25:8541:: with SMTP id f1mr12875364ybn.230.1600376623186;
 Thu, 17 Sep 2020 14:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200916211010.3685-1-maciej.fijalkowski@intel.com> <20200916211010.3685-7-maciej.fijalkowski@intel.com>
In-Reply-To: <20200916211010.3685-7-maciej.fijalkowski@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Sep 2020 14:03:32 -0700
Message-ID: <CAEf4Bza908+c__590SK+_39fUuk51+O2oQnLzGNZ8jyjib5yzw@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 6/7] bpf: allow for tailcalls in BPF
 subprograms for x64 JIT
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 16, 2020 at 3:54 PM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Relax verifier's restriction that was meant to forbid tailcall usage
> when subprog count was higher than 1.
>
> Also, do not max out the stack depth of program that utilizes tailcalls.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---

Maciej,

Only patches 6 and 7 arrived (a while ago) and seems like the other
patches are lost and not going to come. Do you mind resending entire
patch set?

[...]
