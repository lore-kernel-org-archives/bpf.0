Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2555EC433EF
	for <bpf@archiver.kernel.org>; Fri, 18 Mar 2022 17:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiCRRVd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbiCRRVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 13:21:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E169190E98;
        Fri, 18 Mar 2022 10:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 504DDB82386;
        Fri, 18 Mar 2022 17:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B62ECC340EC;
        Fri, 18 Mar 2022 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647624010;
        bh=su8ZevchIlNuFpQhDvRvybZhdAJ4Gax+0h7kl4q65bw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pMoFh23JQpjMQrAV+vNiQq38R7yKBuMb2/JrjqkFkMjOrO7tyTJ4lP24buDDFucBW
         Yvosla82tfWWYo1Od+x7vvhVHeutFces+O4CE48Md68dip/E3AFNJZYhlPRC2TkK7N
         WFyaqDxG6cM2FqKF4KHzS/MBsa0nWOB/Sh6oVQVerpN7B/4+BXKaLyZsu/0ru1ovq/
         wWQpbHcLDxAX7Q97UxQ5XfU/Q9guTLWhceucAT0tbg0DqVD3WE8aJydztvOsLeEbHK
         glxpmzsY48pRNPr4eXs8NwsVGIxkbY06ZphIFh/1lzRkHAMuXeBY4i7gnE3W6Mxv8r
         KQXmcv72ao33Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92E2FEAC09C;
        Fri, 18 Mar 2022 17:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2022-03-18
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164762401059.27083.8906082654501657452.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Mar 2022 17:20:10 +0000
References: <20220318152418.28638-1-daniel@iogearbox.net>
In-Reply-To: <20220318152418.28638-1-daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        andrii@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Mar 2022 16:24:18 +0100 you wrote:
> Hi David, hi Jakub,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 2 non-merge commits during the last 18 day(s) which contain
> a total of 2 files changed, 50 insertions(+), 20 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2022-03-18
    https://git.kernel.org/netdev/net/c/6bd0c76bd704

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


