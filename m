Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F0C433F5
	for <bpf@archiver.kernel.org>; Fri,  5 Nov 2021 23:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE44611EF
	for <bpf@archiver.kernel.org>; Fri,  5 Nov 2021 23:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhKEXms (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Nov 2021 19:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhKEXms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 19:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0CCF46120A;
        Fri,  5 Nov 2021 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636155608;
        bh=s04XcOKHQjJvF+BeL712zwrU+ONxSd7gtSWZinIOgok=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OVKmDU0rx9KBO2kHyf+Wlqg3kjJPrn7xHzDhbmHWVKpf0XQF3+6FAfAqHt6f8tk7O
         bhI1bR9dCuUJoz99ENJE8SkOajUgHQCqsdblil51BMrgh1uls/o1pAvADOTxN4h0Hd
         hGcSv6wvSd8E6zuX4qgD0S7gpl7W77Lel86rv8xO4YT/rNZbyCNfkrx2/1otraAY2v
         MuqmvW6V4wUEAzWsIorVEEoV7suRzibkQ1U3wlODiSsFlUbVPX1wrFKM8DjMsscuLm
         PohA4U2OwdK64wxcW7nNXBao5IaAF+z1rjMiQEySH3UXBKYx+Ecyi7HetyMDYSp5Yp
         jVG32RA4tGHcg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2021-11-05
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163615560797.9193.16037609112421925730.git-patchwork-notify@kernel.org>
Date:   Fri, 05 Nov 2021 23:40:07 +0000
References: <20211105165803.29372-1-daniel@iogearbox.net>
In-Reply-To: <20211105165803.29372-1-daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Nov 2021 17:58:03 +0100 you wrote:
> Hi David, hi Jakub,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 15 non-merge commits during the last 3 day(s) which contain
> a total of 14 files changed, 199 insertions(+), 90 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2021-11-05
    https://git.kernel.org/netdev/net/c/9bea6aa4980f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


