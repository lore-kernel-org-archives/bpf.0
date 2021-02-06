Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDF2C433DB
	for <bpf@archiver.kernel.org>; Sat,  6 Feb 2021 18:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260C564E05
	for <bpf@archiver.kernel.org>; Sat,  6 Feb 2021 18:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhBFSkt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 6 Feb 2021 13:40:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhBFSkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 13:40:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 27B8D64E65;
        Sat,  6 Feb 2021 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612636807;
        bh=y2xADXBGupcbkorncEKQnNBydIwNcvPHkkVfcAS+u5U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ht/fDgB9kkMlKEA6CaFKj6UqIgnkOdtvzAUhboZ4NQ29EO0SD+PUAk3yj81gXCZZs
         mReVvyCsQJ8j0womKnsTA/PScj7NCYrNkCPZji2wdCxwlwfkwf4nRFVuHhitVcakUX
         FUlGNGJ7+ykABJdCM0psnDyckyCY+Wq3NcA6CATI8ERV8TRovRSOgWMBxqNJurK0fm
         LxWOGd5GVwaiefgNxI5AFjvcG+Wsjw0OTpJCcHaYqdfwaF2ESobiQ8ota6dD1AtB6I
         SNnPYP8Sm+5bSrOCYHp7fn9KxrrCnEbnS5eBu7FpDwRbvjBkXu/MLo1cWQ2iaxEfKl
         wu4c8q+E9HfiQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dpaa2-eth: Simplify the calculation of variables
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161263680707.6816.15998203411073238204.git-patchwork-notify@kernel.org>
Date:   Sat, 06 Feb 2021 18:40:07 +0000
References: <1612260157-128026-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612260157-128026-1-git-send-email-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     ioana.ciornei@nxp.com, ruxandra.radulescu@nxp.com,
        davem@davemloft.net, linux@armlinux.org.uk, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Tue,  2 Feb 2021 18:02:37 +0800 you wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:1651:36-38: WARNING
> !A || A && B is equivalent to !A || B.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - dpaa2-eth: Simplify the calculation of variables
    https://git.kernel.org/netdev/net-next/c/b91b3a211542

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


