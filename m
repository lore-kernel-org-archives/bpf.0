Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DC9C433E0
	for <bpf@archiver.kernel.org>; Thu,  4 Feb 2021 19:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B27364F70
	for <bpf@archiver.kernel.org>; Thu,  4 Feb 2021 19:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhBDTks (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236813AbhBDTkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 14:40:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8B67C64E07;
        Thu,  4 Feb 2021 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612467606;
        bh=QRdzaOhqV1YA0jawlRZXll9qFnZhTEghj2eey9E/ssk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gpOzdn9Fnh51kjuquSC40onsv4vEM6C5hpDHsL88TBHYO0XU5BdwHp+qpEqvSiki1
         sgwCAoVdSJOvZTVJ5nbU8LMkLiiyA5scpZi8O3oLoNBTSG+tjsy6fxLsBj8FiVzoYh
         AnqjVwodV+AOXKxhvuSD/3ivFmlf1f3ZAIoDb+xMx8kqokvqy/Y3+mhVbE9o8I4nO4
         1cu5dA7wA/PPeNs5a4Jw3Ljy/eizQJhwoU+VdK05Ol7gzFmQHZXQubmuUfNNbc/l4+
         1v1e/aWkA4pj5lwHfTgzEaE8yc3UnQirPxJLJsyuDy+lHKNp8zayetSWBgWVyGFiZh
         lV/RuPdtcCaLQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drivers: net: xen-netfront: Simplify the calculation of
 variables
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161246760649.23921.17330459930759347792.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Feb 2021 19:40:06 +0000
References: <1612261069-13315-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612261069-13315-1-git-send-email-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, kpsingh@kernel.org,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Tue,  2 Feb 2021 18:17:49 +0800 you wrote:
> Fix the following coccicheck warnings:
> 
> ./drivers/net/xen-netfront.c:1816:52-54: WARNING !A || A && B is
> equivalent to !A || B.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - drivers: net: xen-netfront: Simplify the calculation of variables
    https://git.kernel.org/netdev/net-next/c/e93fac3b5161

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


