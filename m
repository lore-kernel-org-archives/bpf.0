Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E0C433E6
	for <bpf@archiver.kernel.org>; Mon, 22 Feb 2021 12:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C86C614A5
	for <bpf@archiver.kernel.org>; Mon, 22 Feb 2021 12:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhBVMbr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 22 Feb 2021 07:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhBVMbK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 07:31:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67340C06178C
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:30:20 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so18898488wrx.4
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 04:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=+5FjT6BL7TWtnWBbuxvQGk5iDW/ARvKk9CGt0Yit98Y=;
        b=wrReV27Wqu6HXTC9oAAnYexAtiYwCj3WMVZ6Hyc3pXTqXtGiAgQTT7vSJ9vndvb7wV
         VWFa0q6pBDO+94Rl+7Cu87UY2xXtI16qjMq/2eotMXKbQm5bGw3fWCfVvma3ejg6R+qd
         eac2zqpbv+h3WuDZZ6XknRCXMxru7CTvdyiKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=+5FjT6BL7TWtnWBbuxvQGk5iDW/ARvKk9CGt0Yit98Y=;
        b=DH1RE9/aFQAUrD0wnwz1UP1FMZaibDbGfZSqK6diUATFPno2zUuaZsF7LNxjDAR1nw
         l1G5Fp06Zr0dP6eo6ojdsG84vKkzj7XNlO9zXXy39wcuzo98GrGD2dAdZRO+I4ZpFQE8
         6s3agHf+NzGwGvt8Zpu67VO2XHR97Ncvt+jtQcyu5/datIFhuFC2DRy0NCtQVbs4T8yb
         xNHMYWQiPoG1iP+o7b0jiSdXDtf9CKaQ3cohX1XTDyaig5aQH3zmNSwmjsSzQ9VwlJvN
         j18OcrEAJBZaQpLmTiL50IOJx71W9jNE/B+v7GTcX4a9+ixpLCvuLjLQMw8UbMbz8LjC
         JESw==
X-Gm-Message-State: AOAM531wbAeQrWpSP8f2nS3aDty+5U4/ZfSD7pd3PraMtkNiEUxZl16R
        JgHOGTSz8ye6vju0Hx2mYUB07A==
X-Google-Smtp-Source: ABdhPJy72fKE18mEee454FQSixKBimcXNLyUVC670NZGVJBf2ppuHgISlUREGmeKVtEiAIBE3ZPG4A==
X-Received: by 2002:adf:cd0b:: with SMTP id w11mr3588014wrm.86.1613997019207;
        Mon, 22 Feb 2021 04:30:19 -0800 (PST)
Received: from cloudflare.com (79.184.34.53.ipv4.supernova.orange.pl. [79.184.34.53])
        by smtp.gmail.com with ESMTPSA id t16sm10494577wrq.53.2021.02.22.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:30:18 -0800 (PST)
References: <20210220052924.106599-1-xiyou.wangcong@gmail.com>
 <20210220052924.106599-8-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf-next v6 7/8] skmsg: make
 __sk_psock_purge_ingress_msg() static
In-reply-to: <20210220052924.106599-8-xiyou.wangcong@gmail.com>
Date:   Mon, 22 Feb 2021 13:30:17 +0100
Message-ID: <87a6rw4752.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 20, 2021 at 06:29 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> It is only used within skmsg.c so can become static.
>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
