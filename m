Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92CFC77B6E
	for <bpf@archiver.kernel.org>; Wed, 12 Apr 2023 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDLRuU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDLRuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 13:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA0DE69;
        Wed, 12 Apr 2023 10:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 239D963656;
        Wed, 12 Apr 2023 17:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6919DC433D2;
        Wed, 12 Apr 2023 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681321817;
        bh=FJ4KPsLqt3/kPJSTAFO3C74a/mwBbKh95cFJHfKaHwk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=atyH/myqDqlj6dbWUz+wMpSFA89bR2kWUsfrk1HvY3C5rCOYJ+nzcgEwhDp038qpJ
         A2RkX388IB965VbhmWAFuRZjt3saskeOXK8PX1SW+V7Fq3rl4VK9msORyu7dLBLwdo
         9pf+/huOawhUTEbia28MQKnDezZKyfc+rzQjZ11uE7YQdkhC6NAaySWrTROGohAIuo
         9T45RrNJ6/s01DRh7Rmcsd8PvujN5pFQTSL6GOdu5pIkX7pfs7xJ9/zOLraGbqiswV
         oa2YBCDX/rABZ6y+TMAXb3R7IePvgM5kXbS4IKJH4VnI60aFxZm37WeYmYJtvTpwIi
         ZL9P0HWzDP2Ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52760E5244F;
        Wed, 12 Apr 2023 17:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Handle NULL in bpf_local_storage_free.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168132181733.666.17463837668317872941.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Apr 2023 17:50:17 +0000
References: <20230412171252.15635-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20230412171252.15635-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 12 Apr 2023 10:12:52 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> During OOM bpf_local_storage_alloc() may fail to allocate 'storage' and
> call to bpf_local_storage_free() with NULL pointer will cause a crash like:
> [ 271718.917646] BUG: kernel NULL pointer dereference, address: 00000000000000a0
> [ 271719.019620] RIP: 0010:call_rcu+0x2d/0x240
> [ 271719.216274]  bpf_local_storage_alloc+0x19e/0x1e0
> [ 271719.250121]  bpf_local_storage_update+0x33b/0x740
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Handle NULL in bpf_local_storage_free.
    https://git.kernel.org/bpf/bpf-next/c/10fd5f70c397

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


