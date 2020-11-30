Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60292C71155
	for <bpf@archiver.kernel.org>; Mon, 30 Nov 2020 23:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0805720725
	for <bpf@archiver.kernel.org>; Mon, 30 Nov 2020 23:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zzIvINrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgK3Xau (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 Nov 2020 18:30:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388590AbgK3Xau (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Nov 2020 18:30:50 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606779008;
        bh=sc9AcIKcGWtRyOxkD+akZIHNfARM1pr2D943DF9LSK0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=zzIvINrLKGuLQ6/NX6qf2UGI1VXYl6ltCTYmNo3UBUU3NvWx87Hqf1FqgShUdzWrQ
         w+x7hAJdsvQxGAnHcyS9tR3HuBYv2YmIQM1LgOHoXKFGh9xmr8iyg+yhXzIN2/f6QR
         Z3pfh+gIijIUwvrgB43eOC0t7vK8y84qiFO0ybvA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/10] Introduce preferred busy-polling
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160677900881.6839.6641263585447290878.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Nov 2020 23:30:08 +0000
References: <20201130185205.196029-1-bjorn.topel@gmail.com>
In-Reply-To: <20201130185205.196029-1-bjorn.topel@gmail.com>
To:     =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm4udG9wZWxAZ21haWwuY29tPg==?=@ci.codeaurora.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, bjorn.topel@intel.com,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
        jesse.brandeburg@intel.com, qi.z.zhang@intel.com, kuba@kernel.org,
        edumazet@google.com, jonathan.lemon@gmail.com, maximmi@nvidia.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 30 Nov 2020 19:51:55 +0100 you wrote:
> This series introduces three new features:
> 
> 1. A new "heavy traffic" busy-polling variant that works in concert
>    with the existing napi_defer_hard_irqs and gro_flush_timeout knobs.
> 
> 2. A new socket option that let a user change the busy-polling NAPI
>    budget.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/10] net: introduce preferred busy-polling
    https://git.kernel.org/bpf/bpf-next/c/7fd3253a7de6
  - [bpf-next,v4,02/10] net: add SO_BUSY_POLL_BUDGET socket option
    https://git.kernel.org/bpf/bpf-next/c/7c951cafc0cb
  - [bpf-next,v4,03/10] xsk: add support for recvmsg()
    https://git.kernel.org/bpf/bpf-next/c/45a86681844e
  - [bpf-next,v4,04/10] xsk: check need wakeup flag in sendmsg()
    https://git.kernel.org/bpf/bpf-next/c/e39208183728
  - [bpf-next,v4,05/10] xsk: add busy-poll support for {recv,send}msg()
    https://git.kernel.org/bpf/bpf-next/c/a0731952d9cd
  - [bpf-next,v4,06/10] xsk: propagate napi_id to XDP socket Rx path
    https://git.kernel.org/bpf/bpf-next/c/b02e5a0ebb17
  - [bpf-next,v4,07/10] samples/bpf: use recvfrom() in xdpsock/rxdrop
    https://git.kernel.org/bpf/bpf-next/c/f2d2728220ac
  - [bpf-next,v4,08/10] samples/bpf: use recvfrom() in xdpsock/l2fwd
    https://git.kernel.org/bpf/bpf-next/c/284cbc61f851
  - [bpf-next,v4,09/10] samples/bpf: add busy-poll support to xdpsock
    https://git.kernel.org/bpf/bpf-next/c/b35fc1482ceb
  - [bpf-next,v4,10/10] samples/bpf: add option to set the busy-poll budget
    https://git.kernel.org/bpf/bpf-next/c/41bf900fe2a0

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


