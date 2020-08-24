Return-Path: <SRS0=dkA9=CC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAA2C433E1
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0A2204EA
	for <bpf@archiver.kernel.org>; Mon, 24 Aug 2020 21:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUkpj9lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHXVvd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Aug 2020 17:51:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486FC061574;
        Mon, 24 Aug 2020 14:51:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so11446210ljk.6;
        Mon, 24 Aug 2020 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73V1VGeqSaeMpk3jSWcbtFWTB3xSFqOLFDIQrBzJHB4=;
        b=JUkpj9lOLk5bi744jOFwiIuL9/BCz0bQtDhWWNv+bTs+9K0g/JH7wfSXi4LpAKRM9g
         OaJjt49b9w0UR/WayZ/euGfqrfqbYe83u23geuCRocTOOCGhfLKh3ftBqrbWsD5NShdX
         hwzCAEJjJNq0yXj+SVymGyukDOxPJlqDjistNklp1ElzUNGlSEyjNRlrIugr/dslNKw5
         om67BgDtpzVaEB+sgcDEpj8lcAqAsRmelbKMRfcIjBv8R04ceWJZMRGdVEb1mUit0/av
         fns9QFWD80OJcWoyRk6uxVXQki52jBFFNk+8ON374VqnFHHCwizZUohun+tPWjLQIO0y
         XC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73V1VGeqSaeMpk3jSWcbtFWTB3xSFqOLFDIQrBzJHB4=;
        b=PKvkQeIfYA+72yZbIie5Uc5t5HeePDyKCVX/n/kA9vGhsWu7ZBqsg+kPfB02gz7nJt
         6OCiIJlVUqyXeSYgCUArkqAUZirNQDXlIFPONKwFg//rK36/03Jissku5+HhRvkpfPEv
         HHCKSEli9aQX0SRiwuxCvt5XHVEmN75N0DiRvMW/L8jh9ZE7OtNeDE/ro4HGzxWkrjef
         +Hf9OQLtduBRU9GM+WR4ZAU2m2aLos42/bQOm0xUHInFn4xR8o6e+BEZn4hS6DyNge5y
         poGD5YDp6S2MoqyuzEvpxJLLRvBBlCdzqWT2A1LG7RuLkbzQxG9ZmMsSw1Isz0rQ8msK
         btKQ==
X-Gm-Message-State: AOAM531tITnEdLjE19bUQPV0/5FNsVkj6YIaNwRqf/ihH1Hg1N5x1QJx
        4uPpXjB0pFSTiD5DGxr0e21LzKx/N1d4cqYY72o=
X-Google-Smtp-Source: ABdhPJzuUFNMMXArYzyt+hOfzgaM5xK39foOc9q2RwyY1tHHB3PdTegQ41iY94rV1kzJSN4GEBXphFwKnjr1mWdad7M=
X-Received: by 2002:a2e:b6cd:: with SMTP id m13mr3608921ljo.91.1598305891084;
 Mon, 24 Aug 2020 14:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200821225653.2180782-1-andriin@fb.com>
In-Reply-To: <20200821225653.2180782-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Aug 2020 14:51:19 -0700
Message-ID: <CAADnVQL8rkUUTTRhjhVUDNTcoWq5Wxxg8ajTpu-OqBgvAqXryg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix type compatibility check copy-paste error
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 21, 2020 at 4:00 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Fix copy-paste error in types compatibility check. Local type is accidentally
> used instead of target type for the very first type check strictness check.
> This can result in potentially less strict candidate comparison. Fix the
> error.
>
> Fixes: 3fc32f40c402 ("libbpf: Implement type-based CO-RE relocations support")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied. Thanks
