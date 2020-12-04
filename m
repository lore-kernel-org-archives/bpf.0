Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE9CC4361B
	for <bpf@archiver.kernel.org>; Fri,  4 Dec 2020 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E94D622B40
	for <bpf@archiver.kernel.org>; Fri,  4 Dec 2020 16:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgLDQAq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgLDQAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 11:00:46 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607097606;
        bh=6AkramXhXSVoC4i3I48GuXVufwB3OrsCv/GmztvWuQc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aTVOBaSUG1vbGW47XZuf+1UNakRNvaiYrCe0bOE5VhShcc1aSE9PS0KbLhjeBhfvq
         c2xJkgOXnjVaUie0piKCJb6l8+cmjKmkz23L4wPl7XhrRIY7mSettGseDbsUcfHkSa
         +73z82cVmmvwl5Hmi9IB9egu3up03KKqmbNo7b+VOZVmV2QqH3pUBhjmuiJM4zPKdi
         qkYTE2UsMXSh1jA0m3DC1wPpKGS+mkoOwb0L8+bT1U9/XhsH6MRAmFbnv1dKi7n9Oa
         IwcioycPMHp+y79wpcwEplQIO8i/GuTtayIpHA5910RPhjxNXe+vDO79XCLe5sT3wx
         LxO+MHKplbzKg==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] xsk: Return error code if force_zc is set
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160709760590.23287.16780855853847993962.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Dec 2020 16:00:05 +0000
References: <1607077277-41995-1-git-send-email-zhangchangzhong@huawei.com>
In-Reply-To: <1607077277-41995-1-git-send-email-zhangchangzhong@huawei.com>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     bjorn.topel@intel.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Fri, 4 Dec 2020 18:21:16 +0800 you wrote:
> If force_zc is set, we should exit out with an error, not fall back to
> copy mode.
> 
> Fixes: 921b68692abb ("xsk: Enable sharing of dma mappings")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] xsk: Return error code if force_zc is set
    https://git.kernel.org/bpf/bpf/c/12c8a8ca117f

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


