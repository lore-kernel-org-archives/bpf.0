Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E29AC55ABD
	for <bpf@archiver.kernel.org>; Wed, 11 Nov 2020 05:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C5D20729
	for <bpf@archiver.kernel.org>; Wed, 11 Nov 2020 05:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qox+XGoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgKKFNh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Nov 2020 00:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKFNh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 00:13:37 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49107C0613D1;
        Tue, 10 Nov 2020 21:13:37 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id v92so803499ybi.4;
        Tue, 10 Nov 2020 21:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2tHbsI1qrMbLY2mC82o/SQf6XT3MOfFW8iQzwk6HpQ=;
        b=qox+XGoPxc3yc6BHUsKMZNUwfuGRDcgIGxgRiFzRu6SnkOQ1tLbwXPpTU0I76XT0rt
         e5fgzCx3koyGJJ03A4g2Za/7misLIKCP5oUE1e2NREDMsZk4wbwBPwpARQENA7EKgI+r
         DpoMLcvsJxUYb+F77U4+HIpBiE4jadvh+jeHzOzfz6MJD42iRlh1y8UrwNU7MAyl3URd
         clVWy7pCceEt8liiVWFjLJ3WyF7qkloxthYw8UjH0pawGTfEkop3vTNz0thPts4w2ps7
         yb/KMTAftFpD+1uKHFXb8scgrfJMbB6wQtunzybXQgKKKiwh5H3UCthGiHsIFUUjFFBC
         Yn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2tHbsI1qrMbLY2mC82o/SQf6XT3MOfFW8iQzwk6HpQ=;
        b=O3y1H+gbShCDhiDSVb9lPXGSAPoH5sGeVjJ4fFKfxDW2QN7o7i0ROdn0YcK1JM+BLV
         b/QB+8Dbwz37Bf9+ms5rFhVrDNpuE6S01/fLY8w345MbXUd86tLqahqS5ystHuNXzMGH
         iXJXR3OQEPeeyVKvZEJWHClv6FHGN6TGR4sdsWR5WrSLL47SRjpkpiZO01udqc2VqbuY
         W4IekHSt9L85sTc6y8avnoUfCAI1r9LN5/1FD7On7pERMfQhl1nuS/uk7PXQ1OV7teEc
         x95W5N1GRxhQV0bSi8Z+5UYhUC+vp92r20TlH0mxuqpabgn9nhisU00SGmO66owYTCNX
         aB+g==
X-Gm-Message-State: AOAM530PeCzfzbiq0onfFK+GrY9DChobfrwI1WzcyhcVYnOLloXmvUQY
        gDYu3Iw+yGMcuQrntLoWqZuUrg0Mn8wmy8EJwHtxNVkQgQ3S9A==
X-Google-Smtp-Source: ABdhPJz7m2bC5Eo4wpm2N2V9R29/ixlJod1hMGdjqVGHx8KuzqKgWBLJrmhJVYy4mMgm5p7k0ZyOEfwp6Jva4fyG3gw=
X-Received: by 2002:a25:585:: with SMTP id 127mr20192242ybf.425.1605071616605;
 Tue, 10 Nov 2020 21:13:36 -0800 (PST)
MIME-Version: 1.0
References: <1605071026-25906-1-git-send-email-kaixuxia@tencent.com>
In-Reply-To: <1605071026-25906-1-git-send-email-kaixuxia@tencent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 21:13:25 -0800
Message-ID: <CAEf4BzZzGZTFky0F=U1_XKSBu8AqhuNzQgY7yibWYokrMbWK0Q@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: Fix unsigned 'datasec_id' compared with zero in check_pseudo_btf_id
To:     xiakaixu1987@gmail.com
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 9:03 PM <xiakaixu1987@gmail.com> wrote:
>
> From: Kaixu Xia <kaixuxia@tencent.com>
>
> The unsigned variable datasec_id is assigned a return value from the call
> to check_pseudo_btf_id(), which may return negative error code.
>
> Fixes coccicheck warning:
>
> ./kernel/bpf/verifier.c:9616:5-15: WARNING: Unsigned expression compared with zero: datasec_id > 0
>
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---

Looks good.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
