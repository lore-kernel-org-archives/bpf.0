Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB2EC2B9F8
	for <bpf@archiver.kernel.org>; Tue, 25 May 2021 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D5461413
	for <bpf@archiver.kernel.org>; Tue, 25 May 2021 11:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhEYLbk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 May 2021 07:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhEYLbj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 07:31:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C160D6101E;
        Tue, 25 May 2021 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621942209;
        bh=q4L5wdwBU28Rn8eJuB8RKAj1PXY+ccKhb8bNuIOc6W0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Rx7ad90rdMxi0ZEHJhA3h8YAhNoo/LJ6pMZXsTXa5HWtOXQIcbI39hxu0JA6ZJQJf
         ak7DQuzqueVxA2XB/PM3oay7PZA+a7QgeyXQt5ptgEWLCQ67yyfjjx1EmIGJc94dxc
         q6/AADt0e/d72zLtA7n7xYHnSCxEFSt5xeTDXVaGNS9DEqLzlnhF6SHBkago9lqPKR
         uULYltDsYqR+C1MRZbU1qVuzwM8KPJuaOIQTFTGDuHNzy90/LAcefWKaYvjVNGdJmu
         LaYpb/q94lO9YiySrZFgmIVRiQHlu/HVhvfWYHRCV9fkpJSBeC0nifs76LtHiNWHNf
         mJpkLAFfx/v2g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: use kvcalloc to support large umems
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162194220973.7286.14434533629445355511.git-patchwork-notify@kernel.org>
Date:   Tue, 25 May 2021 11:30:09 +0000
References: <20210521083301.26921-1-magnus.karlsson@gmail.com>
In-Reply-To: <20210521083301.26921-1-magnus.karlsson@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, dan@coverfire.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 21 May 2021 10:33:01 +0200 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Use kvcalloc() instead of kcalloc() to support large umems with, on my
> server, one million pages or more in the umem.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Reported-by: Dan Siemon <dan@coverfire.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: use kvcalloc to support large umems
    https://git.kernel.org/bpf/bpf-next/c/a720a2a0ad6c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


