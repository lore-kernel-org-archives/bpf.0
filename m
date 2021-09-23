Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A690C433EF
	for <bpf@archiver.kernel.org>; Thu, 23 Sep 2021 11:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333B66109E
	for <bpf@archiver.kernel.org>; Thu, 23 Sep 2021 11:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbhIWLXn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Sep 2021 07:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbhIWLXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Sep 2021 07:23:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DF3C061574
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 04:22:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id b15so24717088lfe.7
        for <bpf@vger.kernel.org>; Thu, 23 Sep 2021 04:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfNdPCJwWXSgngxKTkxEsCFtYLCJNhShlI3+RACn/MQ=;
        b=F9I+ghCgRL2KqFCdF9sc3S/lQ7hfSmnPw8Vj5P4y7sn1ZFTu6uYqHWYXTeDic+YiW4
         z7PH7cUr17daV4hrwp7YoS5+k9OUQA/9L9ihePPtfxgsoHCq5vEjNvjonjzzK/VEhZnH
         uOc6dH0jvYC/VjLXSo7IDeYQQyxYWK0D+uSFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfNdPCJwWXSgngxKTkxEsCFtYLCJNhShlI3+RACn/MQ=;
        b=CbxA+i8MtHEO22fJoox1fbfihvyqdOmWVpqfpolqPDatWHHXYUA7WeVJy/PoXI8a8D
         HK6+6F/eDFfRt3OhyS9eaFG0R9CPuHWgvVQYpgPemQR0p2Jgo66d2MiNyL1urXb49idA
         0q66w5RQoSVxp2i2YQL6CYBzGnZgfdaI73BxsFHL5ZI10Uafb/qyvrHm43rXM2aLViIk
         bAz8tktUNdcmgPjYnubPdNSM+tbU1ERJZ+cljjvJMQfOMjSWMhsANC7TLXPhASNPE0uf
         lscfK+QIfzvH+iu3hHwYrACLAftfKyEcdwvgIPmo2qcv2dmSdYF2YZrP7O9MQMMwp+QF
         poUg==
X-Gm-Message-State: AOAM530khCyxhR/jSOusNP3kTHzdHgkSblMVOXya2RI116ifxfnZNGwB
        hwKZyq3dg4ZIhScNXwEBCjpJdFkoW5I2cX83y6dWgg==
X-Google-Smtp-Source: ABdhPJwIuUntmw7+VVJutKmYyqxMYh6kl8McZvMQPsaLUBVUb42SPcseMi1CJdt5wqevxuBUeQT5zw3OFA0HvSKTicM=
X-Received: by 2002:a2e:7c0b:: with SMTP id x11mr4502005ljc.298.1632396129713;
 Thu, 23 Sep 2021 04:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com> <20210917215721.43491-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20210917215721.43491-4-alexei.starovoitov@gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 23 Sep 2021 12:21:58 +0100
Message-ID: <CACAyw992kSRHmHky+S03TdOcwDLCAsqK9quoy-p3vQ9DjCdyKA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 03/10] bpf: Add proto of bpf_core_apply_relo()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        mcroce@microsoft.com, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 17 Sept 2021 at 22:57, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Prototype of bpf_core_apply_relo() helper.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

...

> @@ -6313,4 +6321,10 @@ enum bpf_core_relo_kind {
>         BPF_CORE_ENUMVAL_VALUE = 11,         /* enum value integer value */
>  };
>
> +struct bpf_core_relo_desc {
> +       __u32 type_id;
> +       __u32 access_str_off;
> +       enum bpf_core_relo_kind kind;

Not a C expert, I thought enums don't have a fixed size?

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
