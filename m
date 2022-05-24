Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30669C433F5
	for <bpf@archiver.kernel.org>; Tue, 24 May 2022 00:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiEXAa1 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 May 2022 20:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiEXAaZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 20:30:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E829D051;
        Mon, 23 May 2022 17:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89F35615BF;
        Tue, 24 May 2022 00:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAD49C34100;
        Tue, 24 May 2022 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653352223;
        bh=WwZx9Z1eEWFyLPzcW6rTHnmzKGkSvgk9o5XVVPMOAsk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=St6o9M3eOytBVLWBBdI0PY1feujO7TUQAks4RLJN2kM+jBWA0eXwkLX1dSxkLFlpe
         cNQIr20sdVfD6je95XV7y7J+lYUTwG/ffvNcdv4ZedpoiwH9A5RG4se6BIsZrsowB+
         z1y4tRqMcz5UAtRPJYo7mjz/dxeRcc1Vog4yaFqWzBV1d+IRlDV1Sdldu0GdQyFjot
         9YoiZnHj/I1KeR0acZrGLdGkcmIjBSSzGnqAGd7bmS+49pUP2e/UXOMv6XsLwM7O6I
         0zYMbedcp+Iz5ZxJzcHrCP88Xq9xhGqRdfZFltEOJ7tcN5vxfIn57mjZ0NPF9cT2uW
         IGdLduFIlTmQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9428F03943;
        Tue, 24 May 2022 00:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2022-05-23
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165335222374.8029.12691441777905719219.git-patchwork-notify@kernel.org>
Date:   Tue, 24 May 2022 00:30:23 +0000
References: <20220523223805.27931-1-daniel@iogearbox.net>
In-Reply-To: <20220523223805.27931-1-daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, ast@kernel.org, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 May 2022 00:38:05 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 113 non-merge commits during the last 26 day(s) which contain
> a total of 121 files changed, 7425 insertions(+), 1586 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2022-05-23
    https://git.kernel.org/netdev/net-next/c/1ef0736c0711

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


