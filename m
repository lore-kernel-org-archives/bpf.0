Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB84C7EE2D
	for <bpf@archiver.kernel.org>; Wed,  1 Mar 2023 19:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCATKW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Mar 2023 14:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCATKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 14:10:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C04F36FD3;
        Wed,  1 Mar 2023 11:10:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 122EFB8111B;
        Wed,  1 Mar 2023 19:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2787C433D2;
        Wed,  1 Mar 2023 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677697817;
        bh=VGAg8j33LoKqC7wOuV+x3w9jeVa+MQtGIsYnrnybqBQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VMO38ozHwy4fdXKysC775cbpd3PfH9NWmGPXbAZjgqZH5DwcoS4OqWjhTRaz9A/TT
         3kKUiUlj/LcQM+VOvRT4Bpk77SUO5u40kjgrFLu1yC+JFG6iwEJCOBaZsqwMn/PjZy
         SbOh8TVJln9R2ib7kyG+Cnn5KorJ23RE7pbdJSD5MQDXpPIUAk6y+QP6PQxZF9mrbV
         An1aIryY3SW+zWkLcuVxqOvFiGbWYmE/9cfeGWJLXCj4dvAhlnKAVmybrW15x7Mx9n
         yLZtAMn7DD2J2vy8ZYvg07WFrVybclFX9yWtPOnf+SymOnX4FaPItjzBB9p6JfsDPV
         JRa7nCuiwZvBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83D8EE450A5;
        Wed,  1 Mar 2023 19:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Set __BITS_PER_LONG if target is
 bpf for LoongArch
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167769781753.18258.945686895645404447.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Mar 2023 19:10:17 +0000
References: <1677585781-21628-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1677585781-21628-1-git-send-email-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 28 Feb 2023 20:03:01 +0800 you wrote:
> If target is bpf, there is no __loongarch__ definition, __BITS_PER_LONG
> defaults to 32, __NR_nanosleep is not defined:
> 
>   #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
>   #define __NR_nanosleep 101
>   __SC_3264(__NR_nanosleep, sys_nanosleep_time32, sys_nanosleep)
>   #endif
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Set __BITS_PER_LONG if target is bpf for LoongArch
    https://git.kernel.org/bpf/bpf-next/c/be35f4af719c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


