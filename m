Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A958C433DB
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 00:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BF361A0A
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 00:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZAAn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Mar 2021 20:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhCZAAK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 20:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5F15C61A33;
        Fri, 26 Mar 2021 00:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616716809;
        bh=EkqLeuQdPkxljGq82YuYNyQBCQ3nUbqAe8em7BFCV78=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j8wFoC5QJ8Zma0+8RPVSnC10PZ/FW7QsPUu8WsnMANKqfPBmywmM8hOLm/IdDloNB
         RiEiyMMsY30Ev9KjsP2xjLg1ghFON0YOWOBxpew4f2bC/tDdXrM/AYMstYHXZHeWgh
         Wkr1wF+YVqLJ/AS1O48rVUMo/BIRuQjN6dGfOH4RS6hyap1hHSgwhUoj2SVLheuQ21
         Cuxg8mcQZSByqHzyKBlGbI5WiOIjGPnqmutH99WdkSboMfdQYh16jBBeXC28Slou6E
         A1rYm5EYGuLQe47W8VfAIqSxCnwNynndoZMfI2rRMZ8vNCH38L774ltPIEnVgdYqI0
         MN2Vpt39gpF7A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] qede: remove unused including <linux/version.h>
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161671680932.21425.5550356374583894306.git-patchwork-notify@kernel.org>
Date:   Fri, 26 Mar 2021 00:00:09 +0000
References: <20210325032928.1550157-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210325032928.1550157-1-zhengyongjun3@huawei.com>
To:     'Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org, hulkci@huawei.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Thu, 25 Mar 2021 11:29:28 +0800 you wrote:
> From: Zheng Yongjun <zhengyongjun3@huawei.com>
> 
> Remove including <linux/version.h> that don't need it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] qede: remove unused including <linux/version.h>
    https://git.kernel.org/netdev/net-next/c/711550a0b97e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


