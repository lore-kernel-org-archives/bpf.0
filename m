Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D8C4332F
	for <bpf@archiver.kernel.org>; Sat, 12 Nov 2022 02:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiKLCuV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 11 Nov 2022 21:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKLCuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 21:50:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C4DEFD;
        Fri, 11 Nov 2022 18:50:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B479B82896;
        Sat, 12 Nov 2022 02:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A27C1C433D7;
        Sat, 12 Nov 2022 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668221416;
        bh=fGki6oVqYB5T2fTAO8C+FIwM2L90kH4LQrHU/iglhRE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=i+hwfWogSnpn6T4BLr3C+y4OCRbYkrS3dNTgr2L63qIOEi1kNi+X9v7Kc5mjjeYRS
         sbfsaGuZcUnkRNHjJhV8dopfhlvoMl6FRAYZ88bLF5nuT7iRXG2ImV0+q2D4/eW19n
         ZO4o+qmEsGQOSmb/F8igTVoOkw56pAvkKK55UCRLOwenmB6Wb+pRJXtB8Q2OfUJpJi
         erficrXsR/OdlGuf/Pnz/V9Bli/B1tPx/KWObJxHdDIHZviiFKkhPj60VDmlWudWQS
         xuz0cQVpjixULpaq/CxOwxv6jMMeNZxbfEtk6oTmtGw0PPJC7lWex4MzUSp6ykFjTY
         zUemGIkba9OVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86F6DE270C3;
        Sat, 12 Nov 2022 02:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2022-11-11
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166822141654.16918.7544395109554152871.git-patchwork-notify@kernel.org>
Date:   Sat, 12 Nov 2022 02:50:16 +0000
References: <20221111231624.938829-1-andrii@kernel.org>
In-Reply-To: <20221111231624.938829-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, daniel@iogearbox.net, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Nov 2022 15:16:24 -0800 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 11 non-merge commits during the last 8 day(s) which contain
> a total of 11 files changed, 83 insertions(+), 74 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2022-11-11
    https://git.kernel.org/netdev/net/c/c1754bf019bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


