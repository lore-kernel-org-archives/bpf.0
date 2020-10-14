Return-Path: <SRS0=xWwI=DV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E3C43457
	for <bpf@archiver.kernel.org>; Wed, 14 Oct 2020 09:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694CC20757
	for <bpf@archiver.kernel.org>; Wed, 14 Oct 2020 09:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OT4R4azZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgJNJcz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgJNJcu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Oct 2020 05:32:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3FBC0613D3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2020 02:32:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p15so3849382ejm.7
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2020 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=2Q2EXfY9q/OGGKRqeKKhw4ADQDGAvZJdTCK/YEvIMm4=;
        b=OT4R4azZBe83H2jAFxtXzBAZ+lZSdmcLVCr2JZ/C592Oath74URYOWe8A/1jNOG8Kh
         7Zr/5B9kixpwPUt31hr000uny9DfqH/D52Q4ddESsUWurzzDPOOSrjGerZySJtHeKdRv
         IbzWx9790xp3fX2rE8MGogzVVRQ88EQaClvuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=2Q2EXfY9q/OGGKRqeKKhw4ADQDGAvZJdTCK/YEvIMm4=;
        b=DtnV42CSzCsW0FBDJ9NoBX0ki30Bo2sA5Die60iVhzqHLi58BswlMBtRiO8MD26nBt
         PwQQGXWtV74USokfllK0IBia1rVlDuNdoBE6Xw+X1AYptSDindoA/zNc7j14CLy/YSK8
         J622ejjDop0qUtt4F+SbkyIMEJOtJh6MwWn1wG5ld54w8Vg38dKDjLcXOYFd8nHIsCFr
         Gnukr0I9qyVCiRVJN4EDb+1+Ep9Y3fHQvg4HafHBZbsXT1QMgZ5A27JzpZ79GOqPT2wY
         i/leumbSc6hNEn6Oy25yMRfIWeyZsySaBxgKukznzhxKdrDSJE4IiOc/+ScMfCpOph1r
         ad/w==
X-Gm-Message-State: AOAM531sdzgh3O5khQB9f2yq04OrTRZHr2+8WjZyMdXy/PLptLI2cT1b
        883qjd9whcoXdr8n/iDhbsccug==
X-Google-Smtp-Source: ABdhPJxjVAEFb20MNniWGcu/vedUiKayXCpuy0FwmpcpSpxWvQ7TYpYLJ8QYNDaxIR5qKoyrbGtUQQ==
X-Received: by 2002:a17:906:c08f:: with SMTP id f15mr4220755ejz.97.1602667967489;
        Wed, 14 Oct 2020 02:32:47 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id a10sm1370276ejs.11.2020.10.14.02.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 02:32:46 -0700 (PDT)
References: <20201012170952.60750-1-alex.dewar90@gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sockmap: Don't call bpf_prog_put() on NULL pointer
In-reply-to: <20201012170952.60750-1-alex.dewar90@gmail.com>
Date:   Wed, 14 Oct 2020 11:32:45 +0200
Message-ID: <877drtqhj6.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 12, 2020 at 07:09 PM CEST, Alex Dewar wrote:
> If bpf_prog_inc_not_zero() fails for skb_parser, then bpf_prog_put() is
> called unconditionally on skb_verdict, even though it may be NULL. Fix
> and tidy up error path.
>
> Addresses-Coverity-ID: 1497799: Null pointer dereferences (FORWARD_NULL)
> Fixes: 743df8b7749f ("bpf, sockmap: Check skb_verdict and skb_parser programs explicitly")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---

Note to maintainers: the issue exists only in bpf-next where we have:

  https://lore.kernel.org/bpf/160239294756.8495.5796595770890272219.stgit@john-Precision-5820-Tower/

The patch also looks like it is supposed to be applied on top of the above.
