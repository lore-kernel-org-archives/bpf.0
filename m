Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA931FA373E
	for <bpf@archiver.kernel.org>; Mon, 24 Oct 2022 10:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiJXKL3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 24 Oct 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJXKLR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 06:11:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74548E82;
        Mon, 24 Oct 2022 03:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62637B810CC;
        Mon, 24 Oct 2022 10:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F307EC433C1;
        Mon, 24 Oct 2022 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666606216;
        bh=Wj5xGNUHkLkjRz+Sks+fImmtlPHNGd9XD5LspGPBhOE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=V3MMfCYl1LgYxbKUs55A/7LZjeo6WtpYZJc8ILK/3cG0y8Ru82eKQwuKB/tFPifqc
         p0ueGRH6CLU612TgaspHvXdevvcrCMqMx1/DsOM3URT5DI7yTujKCQj/7Di0iYuCtn
         271JfvW6X3wR9HozMIsl9TrwqvE66RLfH+Us8kM8oExEVmQFmWJ61YotyroSjdJ1+c
         nHsEF7NAwLd1Pu0abI6tN+MWBe0JeuMh9vlGfKTpr2mGpxXFyBhKI3AAd8BLg+Pp73
         nFMr3vevuFyGhOURga6D2kEHuG52iCAecEP7KCXhGd2OhcWe4Md2KdateJm+q6rxm4
         eEisR4fGwez5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D69A8C4166D;
        Mon, 24 Oct 2022 10:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: netdev: offer performance feedback to contributors
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166660621587.6109.10588903646372875602.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Oct 2022 10:10:15 +0000
References: <20221020183031.1245964-1-kuba@kernel.org>
In-Reply-To: <20221020183031.1245964-1-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, bpf@vger.kernel.org, jesse.brandeburg@intel.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Oct 2022 11:30:31 -0700 you wrote:
> Some of us gotten used to producing large quantities of peer feedback
> at work, every 3 or 6 months. Extending the same courtesy to community
> members seems like a logical step. It may be hard for some folks to
> get validation of how important their work is internally, especially
> at smaller companies which don't employ many kernel experts.
> 
> The concept of "peer feedback" may be a hyperscaler / silicon valley
> thing so YMMV. Hopefully we can build more context as we go.
> 
> [...]

Here is the summary with links:
  - [net] docs: netdev: offer performance feedback to contributors
    https://git.kernel.org/netdev/net/c/c5884ef477b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


