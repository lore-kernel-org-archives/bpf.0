Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7222C7EE30
	for <bpf@archiver.kernel.org>; Mon, 27 Feb 2023 23:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjB0Xx5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Feb 2023 18:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0Xx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 18:53:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD401ADC5;
        Mon, 27 Feb 2023 15:53:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE6B5B80DD2;
        Mon, 27 Feb 2023 23:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27066C433EF;
        Mon, 27 Feb 2023 23:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677542033;
        bh=N+JWjKKVCI46b94fNKhlbsnPd2vC3JCoKjLJk1alP4g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MntPASzPlgn6u+3Te5ykMPjETpwxRcpi1eAtxw7ZVRCXDRllFq/fImBMAzE3uRAa5
         A4l41aPyTYdvteCKGF+1WpaNJ8BXAy1C2KDdW+tY16tBeotWCIbuPDxdhLbYQXtnGp
         alEIuI7nzMKcI7sdjjc2Ak7uRsTClMOAMX7hgefYLB3IH+7EcJqTXW2dowvr8os05+
         chLBnS7tvIglZ0l32p6tWVFeUCidimIWGH0FMoQ7u1yQrUhQg+ALGX7FZwGwIsk5CF
         gqlX4LiSJR/Uhm8LtBg409t5D8VL25nJG38wmaF8R8G7zq89JGuI8PPaEvEXxAqmu0
         gr7WJWH2f/Q/w==
Date:   Mon, 27 Feb 2023 15:53:52 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     syzbot <syzbot+9c0268252b8ef967c62e@syzkaller.appspotmail.com>,
        borisp@nvidia.com, bpf@vger.kernel.org, davem@davemloft.net,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: task hung in tls_sw_sendpage (3)
Message-ID: <20230227155352.3399bb10@kernel.org>
In-Reply-To: <CANn89iJ_kLaF0tVVUfzKQwVkQ0VtCca1dL8eF+RrXCVDTK6h2Q@mail.gmail.com>
References: <000000000000e412e905f5b46201@google.com>
        <CANn89iJ_kLaF0tVVUfzKQwVkQ0VtCca1dL8eF+RrXCVDTK6h2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Feb 2023 21:35:41 +0100 Eric Dumazet wrote:
> This looks suspicious to me
> 
> commit 79ffe6087e9145d2377385cac48d0d6a6b4225a5
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Tue Nov 5 14:24:35 2019 -0800
> 
>     net/tls: add a TX lock
> 
> 
> If tls_sw_sendpage() has to call sk_stream_wait_memory(),
> sk_stream_wait_memory() is properly releasing the socket lock,
> but knows nothing about mutex_{un}lock(&tls_ctx->tx_lock);

That's supposed to be the point of the lock, prevent new writers from
messing with the partially pushed records when the original writer
is waiting for write space.

Obvious hack but the async crypto support makes TLS a bit of a mess :|

sendpage_lock not taking tx_lock may lead to obvious problems, I'm not
seeing where the deadlock is, tho..

