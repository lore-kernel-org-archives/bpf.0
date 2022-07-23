Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B201BC43334
	for <bpf@archiver.kernel.org>; Sat, 23 Jul 2022 02:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiGWCK2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Jul 2022 22:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbiGWCK1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 22:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A11101D7;
        Fri, 22 Jul 2022 19:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F4AE60F44;
        Sat, 23 Jul 2022 02:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8CA4C341CA;
        Sat, 23 Jul 2022 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658542225;
        bh=TgDVJqP4jQYvvrf07gRD3WhxPbiGonmxAGY98wXDmS4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VxLg7QhQiJSkDNrS6gwiOrwzMdk1uSbbQKByyRIh4+swRhgO9XzdSOD+b/1HgxyS0
         6eWUZSsNwIjqy7IFn97U/8Tk28JbUZxmMWxZkRsJbUp7jbYUYi8+hBwkN8h76vizE5
         hEDfI2r27RXkyB3tpbOz8lNQUEXwDJDrTMTEntZF0oYKfB1wnvIL/Yx1QKFV0CQmf7
         QgZZOSGLTzAVbBMxxU9UfIc38jOtjuvg10LGS2TyoDQlOX/LRnr563252teN9orAc/
         +Vkoro5xsH/H9Lq+2l4cgIk4L486bvkYluHj7WIZzAyvZEDnroZtET8rPxd7cmJOTP
         wS+8Xqt33Xbkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD580D9DDDD;
        Sat, 23 Jul 2022 02:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2022-07-22
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165854222577.22628.10765393378341067283.git-patchwork-notify@kernel.org>
Date:   Sat, 23 Jul 2022 02:10:25 +0000
References: <20220722221218.29943-1-daniel@iogearbox.net>
In-Reply-To: <20220722221218.29943-1-daniel@iogearbox.net>
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

On Sat, 23 Jul 2022 00:12:18 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 73 non-merge commits during the last 12 day(s) which contain
> a total of 88 files changed, 3458 insertions(+), 860 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2022-07-22
    https://git.kernel.org/netdev/net-next/c/b3fce974d423

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


