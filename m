Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E49AC433EF
	for <bpf@archiver.kernel.org>; Tue, 14 Jun 2022 20:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357639AbiFNUQy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357901AbiFNUQk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 16:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012234EF6E;
        Tue, 14 Jun 2022 13:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D88061162;
        Tue, 14 Jun 2022 20:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEA23C341C4;
        Tue, 14 Jun 2022 20:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655237412;
        bh=Jb3q6Ri4PxJrE88gxL0hxbYuEi3OuaYtKPa9Rq/8gOE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DWwro7EDxLHgWJMZLfeb84JIVxDz43S7Wxjb1WLYyco7kwpTC2hwNtaKVT4HVfNvw
         JoPDwNxEbwS9IHShsWT8AwAylE6Xp6ZKNiGCjkFNVpREywkdRM/tzkKZycVdYDUT3q
         khWd9MWJnrnhoYDbtV4TNlSBinkGwtmhzKkhyXV6j0ZwjzXcUeJ1zjqozDEC1Ur9Jn
         HrUOdGCeDjPJ823R2SIj0AYSH0ayRkzYIe0j9VjUV8OwtI2XNc44RwGNo0+gLG9BFw
         58ZJFa4I2gVChSpvjdxPHw8tCqcC4PAZ6KDCzi+otykGf8YwB5qxXDZPvnB8SQUCm0
         j4UddroRsye1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4AF3FD99FF;
        Tue, 14 Jun 2022 20:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] bpf, arm: Remove unused function emit_a32_alu_r()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165523741267.23128.7750820754124347008.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 20:10:12 +0000
References: <20220611040904.8976-1-yuehaibing@huawei.com>
In-Reply-To: <20220611040904.8976-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     illusionist.neo@gmail.com, linux@armlinux.org.uk, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, johan.almbladh@anyfinetworks.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 11 Jun 2022 12:09:04 +0800 you wrote:
> Since commit b18bea2a45b1 ("ARM: net: bpf: improve 64-bit ALU implementation")
> this is unused anymore, so can remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/arm/net/bpf_jit_32.c | 16 ----------------
>  1 file changed, 16 deletions(-)

Here is the summary with links:
  - [-next] bpf, arm: Remove unused function emit_a32_alu_r()
    https://git.kernel.org/bpf/bpf-next/c/fc386ba7211d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


