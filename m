Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E52C433E9
	for <bpf@archiver.kernel.org>; Wed,  6 Jan 2021 01:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151C2230FC
	for <bpf@archiver.kernel.org>; Wed,  6 Jan 2021 01:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbhAFBAt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbhAFBAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jan 2021 20:00:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 69B85229EF;
        Wed,  6 Jan 2021 01:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894808;
        bh=sYYPTmzA415ubGj4VX/B1hFMXo+AKCAIKo7GhA4hO3s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kqxHTKxOWxE9zs1mf3uEUl6hNuN5iHPa0O8Q2vnae/OWVumyIVHR9e4Gq7fvOTJBY
         sZVfMd7/taWji4ZoBi6GFPzcRfYsnjjml8JizMOB+Bxwm8fZu9ea9Yv5YfGXxYbLYI
         4XEsAV98m6bHRpbklrPPR3tzOENbgBiBVE/XEwPhWNA3tv0OlXaOfbHCraztH0CASx
         sx5RaYrBGuy+j+UTi0HBk/RGOWAVG5PxKBMphrbYY6P/aixy8jot9ZG3eHz+mmRLge
         ksX0Kik9uMGMh77LCMU9TxxsA3DlocbjS+DqM80NokE1wTX9p1TgNYLpAEPnQldzn7
         O87r7naA58Tng==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: fix the return value for UDP GRO test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160989480835.15297.3332305981136366306.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Jan 2021 01:00:08 +0000
References: <20210105101740.11816-1-po-hsu.lin@canonical.com>
In-Reply-To: <20210105101740.11816-1-po-hsu.lin@canonical.com>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org, shuah@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue,  5 Jan 2021 18:17:40 +0800 you wrote:
> The udpgro.sh will always return 0 (unless the bpf selftest was not
> build first) even if there are some failed sub test-cases.
> 
> Therefore the kselftest framework will report this case is OK.
> 
> Check and return the exit status of each test to make it easier to
> spot real failures.
> 
> [...]

Here is the summary with links:
  - selftests: fix the return value for UDP GRO test
    https://git.kernel.org/netdev/net/c/3503ee6c0bec

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


